#!/usr/bin/env python3
"""Check the Painlevé RH architecture against an immutable topic snapshot.

The snapshot is the PainleveEquations directory at commit 5377bc5, or a
repository containing that directory. Only parser functions are used from the
historical checkers; their revision-specific main programs are never invoked.
The checks establish preservation and document consistency, not the roadmap's
mathematical theorems or the adequacy of every proof contract.
"""
from __future__ import annotations

import argparse
import ast
import hashlib
import importlib.util
import json
import re
import shutil
import sys
import tomllib
from pathlib import Path


REMOVED = {"2.5", "2.6"}
REVISED = {"1.3", "2.4", "3.8", "4.1", "4.2", "4.3", "4.4"}
DOCUMENTS = {"en": "README.md", "ja": "README.ja.md"}
INPUTS = [
    *DOCUMENTS.values(), "design/plan.json", "design/dependencies.json",
    "design/reuse_graph.json", "design/reuse_registry.json", "sources.toml",
    "Suggested.lean", "metadata.toml", "reports/timeless/check_timeless.py",
    "reports/submission/check_math_rendering.py",
]
EXPECTED_MATH_COUNTS = {"en": 216, "ja": 204}
REVIEW_PROSE = re.compile(
    r"\b(?:TODO|FIXME|PLACEHOLDER|SIGMA_INVENTORY)\b|"
    r"\b(?:by fiat|unlocated source|unlocated theorem|proof-development task|"
    r"unspecified closure|to avoid a dependency cycle|in response to (?:the )?review|"
    r"newly added target|remaining proof obligation)\b|"
    r"レビューへの|レビューに応じ|未配置|無言で|黙って", re.I,
)


def topic_directory(path):
    """Accept either a topic snapshot or a full repository snapshot."""
    path = path.resolve()
    if (path / "design/plan.json").is_file():
        return path
    return path / "TauCetiRoadmap/PainleveEquations"


def import_parsers(path, name):
    # Importing under a private name leaves each historical __main__ uncalled.
    sys.dont_write_bytecode = True
    spec = importlib.util.spec_from_file_location(name, path)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


def digest(data):
    return hashlib.sha256(data).hexdigest()


def strings(value, path="$", key=None):
    """Visit active prose values without scanning report programs or history."""
    if isinstance(value, str):
        yield path, key, value
    elif isinstance(value, dict):
        for child, entry in value.items():
            yield from strings(entry, path + "." + child, child)
    elif isinstance(value, list):
        for index, entry in enumerate(value):
            yield from strings(entry, f"{path}[{index}]", key)


def source_mentions(text, source_ids):
    return {key for key in source_ids if re.search(
        r"(?<![A-Za-z0-9_-])" + re.escape(key) + r"(?![A-Za-z0-9_-])", text)}


def ancestors(adjacency):
    """Compute ancestry independently of the document's claimed ordering."""
    completed, active = {}, set()

    def visit(node):
        if node in active:
            raise ValueError("dependency cycle through " + node)
        if node in completed:
            return completed[node]
        if node not in adjacency:
            raise ValueError("unknown dependency target " + node)
        active.add(node)
        result = set()
        for parent in adjacency[node]:
            result.add(parent)
            result.update(visit(parent))
        active.remove(node)
        completed[node] = result
        return result

    for node in adjacency:
        visit(node)
    return completed


def symbolic_entry(text, symbols):
    """Parse the diagnostic's arithmetic without evaluating source text."""
    text = re.sub(r"\s+", "", text).replace("−", "-")
    text = re.sub(r"(?<=\d)(?=[πiz])|(?<=[πiz])(?=[πiz])", "*", text)
    text = text.replace("π", "pi")

    def visit(node):
        if isinstance(node, ast.Expression):
            return visit(node.body)
        if isinstance(node, ast.Constant) and type(node.value) is int:
            return symbols["Integer"](node.value)
        if isinstance(node, ast.Name) and node.id in {"z", "pi", "i"}:
            return symbols[node.id]
        if isinstance(node, ast.UnaryOp) and isinstance(node.op, (ast.UAdd, ast.USub)):
            value = visit(node.operand)
            return value if isinstance(node.op, ast.UAdd) else -value
        if isinstance(node, ast.BinOp):
            left, right = visit(node.left), visit(node.right)
            if isinstance(node.op, ast.Add):
                return left + right
            if isinstance(node.op, ast.Sub):
                return left - right
            if isinstance(node.op, ast.Mult):
                return left * right
            if isinstance(node.op, ast.Div):
                return left / right
            if isinstance(node.op, ast.Pow):
                return left ** right
        raise ValueError("unsupported arithmetic in diagnostic: " + text)

    return visit(ast.parse(text, mode="eval"))


def verify(args):
    root, baseline = topic_directory(args.root), topic_directory(args.baseline_dir)
    rows, hashes = [], {"current": {}, "baseline": {}}

    def check(name, passed, detail=None):
        row = {"check": name, "passed": bool(passed)}
        if detail is not None:
            row["detail"] = detail
        rows.append(row)

    def skip(name, reason):
        rows.append({"check": name, "passed": None, "skipped": reason})

    result = {
        "baseline_commit": "5377bc5",
        "baseline_directory": str(baseline), "root": str(root),
        "input_sha256": hashes, "checks": rows,
        "limits": [
            "These checks establish document consistency, dependency architecture and preservation; they do not prove the roadmap theorems.",
            "Japanese fields already represented in the plan are checked exactly; bilingual mathematical equivalence also requires editorial review.",
            "The symbolic diagnostic verifies one explicit local connection, not the general local-monodromy theorem.",
            "No Lean proof or full lake build is performed.",
            "The independent GFM parser checks syntax, not the visual output of the remote GitHub renderer.",
        ],
    }
    contents = {"current": {}, "baseline": {}}
    for label, directory in [("current", root), ("baseline", baseline)]:
        for name in INPUTS:
            path = directory / name
            check(label + " input exists: " + name, path.is_file())
            if path.is_file():
                data = path.read_bytes()
                hashes[label][name] = digest(data)
                contents[label][name] = data.decode("utf-8")
    if any(row["passed"] is False for row in rows):
        return result
    checker_path = Path(__file__).resolve()
    result["checker_sha256"] = digest(checker_path.read_bytes())
    current, old = contents["current"], contents["baseline"]
    parser = import_parsers(baseline / "reports/timeless/check_timeless.py", "_rh_contract_parsers")
    math = import_parsers(baseline / "reports/submission/check_math_rendering.py", "_rh_math_parsers")
    result["parser_verification"] = {
        "contract_helpers": ["sections", "fields"],
        "math_helpers": ["math_spans", "table_width_errors", "pandoc_math"],
        "historical_main_invoked": False,
        "pandoc_available": shutil.which("pandoc") is not None,
    }
    docs = {lang: current[name] for lang, name in DOCUMENTS.items()}
    old_docs = {lang: old[name] for lang, name in DOCUMENTS.items()}
    blocks = {lang: parser.sections(doc) for lang, doc in docs.items()}
    old_blocks = {lang: parser.sections(doc) for lang, doc in old_docs.items()}
    parsed = {lang: {tid: parser.fields(block["text"]) for tid, block in group.items()}
              for lang, group in blocks.items()}
    plan, old_plan = (json.loads(data["design/plan.json"]) for data in [current, old])
    targets = [target for layer in plan["layers"] for target in layer["targets"]]
    old_targets = [target for layer in old_plan["layers"] for target in layer["targets"]]
    by_id, old_by_id = ({target["id"]: target for target in group} for group in [targets, old_targets])
    ids, old_ids = list(by_id), list(old_by_id)
    expected_ids = [tid for tid in old_ids if tid not in REMOVED]
    positions = {tid: index for index, tid in enumerate(ids)}
    check("baseline has the 57-target architecture", len(old_targets) == len(old_by_id) == 57)
    check("only 2.5 and 2.6 removed; retained target order preserved",
          ids == expected_ids and len(targets) == len(by_id) == 55,
          {"removed": sorted(set(old_ids) - set(ids)), "added": sorted(set(ids) - set(old_ids))})
    check("eight consecutive layers retained", [layer["key"] for layer in plan["layers"]] == [str(i) for i in range(8)])
    check("all retained targets have framework or application roles",
          all(target["scope_role"] in {"framework", "application"} for target in targets))
    check("19 general and 36 application targets",
          sum(t["scope_role"] == "framework" for t in targets) == 19
          and sum(t["scope_role"] == "application" for t in targets) == 36)
    result["changed_targets"] = {}
    for lang, doc in docs.items():
        headings = re.findall(r"^### (\d+\.\d+) ", doc, re.M)
        check(lang + " unique target headings match the plan", headings == ids and len(headings) == len(set(headings)))
        changed = [tid for tid in ids if tid in blocks[lang] and tid in old_blocks[lang]
                   and blocks[lang][tid]["text"] != old_blocks[lang][tid]["text"]]
        result["changed_targets"][lang] = changed
        check(lang + " exactly the seven authorized numbered sections revised", set(changed) == REVISED)
        check(lang + " deleted sections absent", not (set(blocks[lang]) & REMOVED))
        anchors = re.findall(r'<a id="([^"]+)"></a>', doc)
        check(lang + " explicit anchors unique", len(anchors) == len(set(anchors)))
        links = set(re.findall(r"\]\(#([^\)]+)\)", doc))
        check(lang + " fragment links resolve", links <= set(anchors), sorted(links - set(anchors)))
        check(lang + " one anchor per retained target",
              {a for a in anchors if a.startswith("target-")}
              == {"target-" + tid.replace(".", "-") for tid in ids})
    # Avoid hiding a malformed heading behind a later KeyError.
    if any(set(blocks[lang]) != set(ids) for lang in docs) or set(ids) != set(expected_ids):
        return result

    deps = json.loads(current["design/dependencies.json"])["contracts"]
    old_deps = json.loads(old["design/dependencies.json"])["contracts"]
    dependency_by_id, old_dependency_by_id = ({c["id"]: c for c in group} for group in [deps, old_deps])
    dependency_ids = set(dependency_by_id)
    graph = json.loads(current["design/reuse_graph.json"])
    registry = json.loads(current["design/reuse_registry.json"])
    parts = {part["id"]: part for part in plan["parts"]}
    old_parts = {part["id"]: part for part in old_plan["parts"]}
    check("part inventory and ownership retained", list(parts) == list(old_parts)
          and all(parts[key]["scope_role"] == old_parts[key]["scope_role"]
                  and parts[key]["contracts"]["owner"] == old_parts[key]["contracts"]["owner"] for key in parts))
    for layer in plan["layers"]:
        key = layer["key"]
        check("layer " + key + " titles synchronized",
              f"## Layer {key}: {layer['title']}" in docs["en"]
              and f"## レイヤー{key}：{layer['title_ja']}" in docs["ja"])
        check("layer " + key + " numbered targets correctly placed",
              all(target["id"].split(".")[0] == key for target in layer["targets"]))

    edges, adjacency, item_ids = [], {}, []
    ja_coverage = {"hypotheses_ja": 0, "full_ja_contracts": 0, "supporting_constructions": 0}
    for target in targets:
        tid = target["id"]
        previous = old_by_id[tid]
        en, ja = parsed["en"][tid], parsed["ja"][tid]
        if tid not in REVISED:
            for lang in docs:
                check(tid + " " + lang + " entire numbered section byte-exact",
                      blocks[lang][tid]["text"].encode("utf-8") == old_blocks[lang][tid]["text"].encode("utf-8"))
            check(tid + " unchanged target metadata", target == previous)
        identity_fields = ["id", "kind", "name", "title", "part", "scope_role", "owner"]
        check(tid + " identity and ownership preserved", all(target.get(k) == previous.get(k) for k in identity_fields))
        check(tid + " ownership agrees with its part", target["part"] in parts
              and target["scope_role"] == parts[target["part"]]["scope_role"]
              and target["owner"] == plan["roadmap"] + ":" + tid
              and parts[target["part"]]["contracts"]["owner"] == plan["roadmap"] + ":" + target["part"])
        for lang, role_words in [("en", {"framework": "General theory.", "application": "Painlevé application."}),
                                 ("ja", {"framework": "一般理論。", "application": "パンルヴェへの適用。"})]:
            role_matches = [word for word in role_words.values() if "**" + word + "**" in blocks[lang][tid]["text"]]
            check(tid + " " + lang + " role synchronized", role_matches == [role_words[target["scope_role"]]])
        check(tid + " English title synchronized", target["title"] == blocks["en"][tid]["title"])
        for field in ["statement", "hypotheses"]:
            check(tid + " English " + field + " synchronized", target[field] == en[field])
        for field in ["title", "statement", "hypotheses", "api", "tests", "source_scope"]:
            key = field + "_ja"
            if key in previous:
                check(tid + " existing " + key + " retained", key in target)
            if key in target:
                actual = blocks["ja"][tid]["title"] if field == "title" else ja[field]
                check(tid + " " + key + " synchronized", target[key] == actual)
                if key == "hypotheses_ja":
                    ja_coverage[key] += 1
        check(tid + " bilingual Needs synchronized", target["readme_needs"] == en.get("needs")
              and target["readme_needs_ja"] == ja.get("needs"))
        for field in ["api", "tests"]:
            entries = target[field]
            check(tid + " " + field + " synchronized", [entry["statement"] for entry in entries] == en[field])
            check(tid + " bilingual " + field + " counts agree", len(en[field]) == len(ja[field]))
            check(tid + " " + field + " identifiers are local and sequential",
                  [entry["id"] for entry in entries] == [f"{tid}.{field}.{i}" for i in range(1, len(entries) + 1)])
            item_ids.extend(entry["id"] for entry in entries)
            for index, entry in enumerate(entries):
                if "statement_ja" in entry:
                    check(entry["id"] + " Japanese text synchronized", entry["statement_ja"] == ja[field][index])
        support = target.get("supporting_constructions", [])
        check(tid + " bilingual supporting constructions synchronized",
              [entry["statement"] for entry in support] == en["supporting"]
              and [entry["statement_ja"] for entry in support] == ja["supporting"])
        item_ids.extend(entry["id"] for entry in support)
        ja_coverage["supporting_constructions"] += len(support)
        if en["source_scope"] is not None:
            check(tid + " source scope synchronized", target.get("source_scope") == en["source_scope"])
            if "locator" in target:
                check(tid + " source-scope locator synchronized", target["locator"].get("where") == en["source_scope"])
        elif "source_scope" in target:
            check(tid + " inline source scope synchronized", target["source_scope"] in en["statement"])
        if "ja" in previous:
            check(tid + " full Japanese metadata retained", "ja" in target and set(previous["ja"]) <= set(target["ja"]))
        if "ja" in target:
            ja_coverage["full_ja_contracts"] += 1
            expected = dict(target["ja"])
            expected.update({key: ja[key] for key in ["statement", "hypotheses", "api", "tests", "needs"]})
            expected["title"] = blocks["ja"][tid]["title"]
            if "source_scope" in expected:
                expected["source_scope"] = ja["source_scope"]
            check(tid + " full Japanese contract synchronized", target["ja"] == expected)
        prerequisites = target["prerequisites"]
        internal = [entry[7:] for entry in prerequisites if entry.startswith("target:")]
        external = [entry[11:] for entry in prerequisites if entry.startswith("dependency:")]
        check(tid + " prerequisite types and identities valid",
              len(internal) + len(external) == len(prerequisites)
              and len(prerequisites) == len(set(prerequisites))
              and set(internal) <= set(ids) and set(external) <= dependency_ids)
        check(tid + " prerequisites precede their consumer", all(positions.get(dep, len(ids)) < positions[tid] for dep in internal))
        for lang, marker in [("en", r"^Internal: ([^;]+)"), ("ja", r"^内部依存：([^;]+)")]:
            needs = parsed[lang][tid].get("needs", "")
            match = re.search(marker, needs)
            declared = re.findall(r"\d+\.\d+", match[1]) if match else []
            externals = re.findall(r"\]\(#dependency-([^\)]+)\)", needs)
            check(tid + " " + lang + " Needs agrees with prerequisites", declared == internal and externals == external)
        adjacency[tid] = internal
        edges.extend({"from": tid, "to": dep} for dep in internal)
    result["japanese_metadata_coverage"] = ja_coverage
    check("contract item identifiers unique", len(item_ids) == len(set(item_ids)))
    check("reuse graph nodes agree with targets", graph["nodes"] == [{"id": t["id"], "part": t["part"], "scope_role": t["scope_role"]} for t in targets])
    check("reuse graph edges agree with prerequisites", graph["edges"] == edges)
    check("reuse registry part inventory agrees", [p["id"] for p in registry["parts"]] == list(parts))
    for part in registry["parts"]:
        expected = parts.get(part["id"], {})
        check("part " + part["id"] + " registry agrees with ownership",
              part["target_ids"] == [t["id"] for t in targets if t["part"] == part["id"]]
              and all(part.get(k) == expected.get(k) for k in ["title", "scope_role"])
              and part["owner"] == expected.get("contracts", {}).get("owner"))
    try:
        ancestry = ancestors(adjacency)
        check("dependency graph acyclic", True)
        for target in targets:
            tid = target["id"]
            if target["scope_role"] == "framework":
                check(tid + " general theory independent of applications",
                      all(by_id[dep]["scope_role"] == "framework" for dep in ancestry[tid]))
            if 3 <= int(tid.split(".")[0]) <= 6:
                check(tid + " geometry independent of Layer 7", not any(dep.startswith("7.") for dep in ancestry[tid]))
        check("3.8 local logarithmic monodromy has no Layer 4 prerequisites",
              not any(dep.startswith("4.") for dep in ancestry["3.8"]))
    except ValueError as error:
        check("dependency graph acyclic and resolved", False, str(error))
    result["prerequisite_changes"] = {
        tid: {"removed": [x for x in old_by_id[tid]["prerequisites"] if x not in by_id[tid]["prerequisites"]],
              "added": [x for x in by_id[tid]["prerequisites"] if x not in old_by_id[tid]["prerequisites"]]}
        for tid in ids if by_id[tid]["prerequisites"] != old_by_id[tid]["prerequisites"]}

    counts = {
        "parts": len(plan["parts"]), "general_parts": sum(p["scope_role"] == "framework" for p in plan["parts"]),
        "layers": len(plan["layers"]), "targets": len(targets),
        "general_targets": sum(t["scope_role"] == "framework" for t in targets),
        "api_laws": sum(len(t["api"]) for t in targets), "diagnostics": sum(len(t["tests"]) for t in targets),
        "internal_edges": len(edges), "supporting_constructions": sum(len(t.get("supporting_constructions", [])) for t in targets),
    }
    check("all plan counts derived from contracts", plan["counts"] == counts, counts)
    result["counts"] = counts | {"application_targets": sum(t["scope_role"] == "application" for t in targets)}
    check("external supplier inventory retained", list(dependency_by_id) == list(old_dependency_by_id)
          and len(dependency_ids) == len(deps))
    result["external_consumer_changes"] = {}
    for contract in deps:
        cid = contract["id"]
        prior = old_dependency_by_id.get(cid, {})
        check("supplier " + cid + " addresses and supplied scope retained",
              all(contract.get(k) == prior.get(k) for k in ["id", "paths", "sections", "source_revision", "consumer_sections", "supplied"]))
        consumers = [t["id"] for t in targets if "dependency:" + cid in t["prerequisites"]]
        check("supplier " + cid + " consumers match plan", contract["consumers"] == consumers)
        for lang in docs:
            table_rows = [line for line in docs[lang].splitlines() if '<a id="dependency-' + cid + '">' in line]
            scope = contract["supplied"] + " " + contract["owned_here"] if lang == "en" else contract["supplied_ja"]
            check("supplier " + cid + " " + lang + " table synchronized", len(table_rows) == 1 and scope in table_rows[0])
        if contract["consumers"] != prior.get("consumers"):
            result["external_consumer_changes"][cid] = {"before": prior.get("consumers"), "after": contract["consumers"]}
    moduli = parts["connection_moduli"]["contracts"]
    for interface in moduli["foundational_interfaces"]:
        supplied = dependency_by_id.get(interface["contract"].removeprefix("dependency:"), {})
        check(interface["contract"] + " foundational summary synchronized", interface["scope"] == supplied.get("supplied"))
    for part in plan["parts"]:
        for item in part["contracts"].get("owned_proof_obligations", []):
            owned = item.get("targets", [item["target"]] if "target" in item else [])
            check(part["id"] + " obligation targets exist: " + item.get("id", item.get("target", "")),
                  bool(owned) and set(owned) <= set(ids))
            if "id" in item:
                check(item["id"] + " summary synchronized", "- `" + item["id"] + "` — " + item["statement"] in docs["en"])

    sources, old_sources = (tomllib.loads(data["sources.toml"])["source"] for data in [current, old])
    source_by_id, old_source_by_id = ({s["id"]: s for s in group} for group in [sources, old_sources])
    source_ids = set(source_by_id)
    check("source inventory retained and unique", list(source_by_id) == list(old_source_by_id) and len(source_ids) == len(sources))
    result["source_consumer_changes"] = {}
    for source in sources:
        sid, previous = source["id"], old_source_by_id.get(source["id"], {})
        stable = lambda entry: {k: v for k, v in entry.items() if k not in {"version_note", "cited_for"}}
        check("source " + sid + " identity, version and exact locators retained", stable(source) == stable(previous))
        consumers = source["cited_for"]
        check("source " + sid + " consumers valid and unique", set(consumers) <= set(ids) and len(consumers) == len(set(consumers)))
        delta = set(consumers) ^ set(previous.get("cited_for", []))
        check("source " + sid + " consumer changes confined to reorganization", delta <= REMOVED | REVISED)
        if consumers != previous.get("cited_for"):
            result["source_consumer_changes"][sid] = {"before": previous.get("cited_for"), "after": consumers}
    for target in targets:
        tid, locator = target["id"], target.get("locator", {})
        keys = set(locator.get("sources", [])) | ({locator["source"]} if "source" in locator else set())
        check(tid + " locator source keys resolve", keys <= source_ids | {"generic"})
        mentioned = (keys - {"generic"}) | source_mentions(json.dumps(locator, ensure_ascii=False), source_ids)
        mentioned |= source_mentions(json.dumps(target.get("additional_source_refs", []), ensure_ascii=False), source_ids)
        for lang in docs:
            mentioned |= source_mentions(blocks[lang][tid]["text"], source_ids)
        missing = sorted(sid for sid in mentioned if tid not in source_by_id.get(sid, {}).get("cited_for", []))
        check(tid + " explicit source references have registered consumers", not missing, missing)
    for part in plan["parts"]:
        for source in part["contracts"].get("sources", []):
            registered = source_by_id.get(source["key"], {})
            check(part["id"] + " source summary resolves: " + source["key"],
                  bool(registered) and source.get("url") == registered.get("url"))
    i13 = source_by_id.get("I13", {})
    check("I13 uses the pinned preprint in its PVI application summary",
          i13.get("arxiv") == "math/0602004v2"
          and any(s["key"] == "I13" and s.get("pdf", "").endswith("0602004v2")
                  for s in parts["painleve"]["contracts"].get("sources", []))
          and all(s["key"] != "I13" for s in moduli.get("sources", [])))

    active_json = {"design/plan.json": plan, "design/dependencies.json": {"contracts": deps},
                   "design/reuse_graph.json": graph, "design/reuse_registry.json": registry}
    dangling = []
    for name, data in active_json.items():
        for path, key, value in strings(data):
            if value in {"target:" + tid for tid in REMOVED} or (key in {"targets", "target", "target_ids", "consumers", "from", "to"} and value in REMOVED):
                dangling.append({"file": name, "path": path, "value": value})
    for name in [*DOCUMENTS.values(), "sources.toml"]:
        for match in re.finditer(r"target:(?:2\.5|2\.6)(?!\d)|#target-2-[56](?!\d)", current[name]):
            dangling.append({"file": name, "offset": match.start(), "value": match[0]})
    check("deleted target references absent from active contracts", not dangling, dangling)
    prose = [(name, f"line {i}", line) for name in DOCUMENTS.values()
             for i, line in enumerate(current[name].splitlines(), 1)]
    prose.extend((name, path, value) for name, data in active_json.items() for path, _, value in strings(data))
    prose.extend(("sources.toml", source["id"] + ".version_note", source.get("version_note", "")) for source in sources)
    scars = [{"file": name, "location": location, "match": match[0]}
             for name, location, text in prose for match in REVIEW_PROSE.finditer(text)]
    check("active prose has no draft or review-response markers", not scars, scars)
    result["timeless_scan"] = {"scope": [*DOCUMENTS.values(), *active_json, "sources.toml: version_note"],
                               "pattern": REVIEW_PROSE.pattern,
                               "limitation": "A scoped editorial lint; ordinary mathematical uses of 'new', negation and source errata are allowed."}

    for name in ["Suggested.lean", "metadata.toml", "reports/timeless/check_timeless.py", "reports/submission/check_math_rendering.py"]:
        check(name + " byte-exactly unchanged", hashes["current"][name] == hashes["baseline"][name])
    result["math_counts"] = {}
    for lang, doc in docs.items():
        spans, prior_spans = math.math_spans(doc), math.math_spans(old_docs[lang])
        payloads = lambda items: [(item["kind"], item["tex"]) for item in items]
        raw = lambda text, items: [text[item["start"]:item["end"]] for item in items]
        check(lang + " deleted targets contain no TeX", all(not math.math_spans(old_blocks[lang][tid]["text"]) for tid in REMOVED))
        check(lang + " baseline TeX count matches snapshot", len(prior_spans) == EXPECTED_MATH_COUNTS[lang])
        check(lang + " ordered TeX and delimiters retained byte-exactly", raw(doc, spans) == raw(old_docs[lang], prior_spans))
        for tid in ids:
            before, after = old_blocks[lang][tid]["text"], blocks[lang][tid]["text"]
            check(tid + " " + lang + " TeX retained byte-exactly", raw(before, math.math_spans(before)) == raw(after, math.math_spans(after)))
        widths = math.table_width_errors(doc)
        check(lang + " Markdown table widths consistent", not widths, widths)
        check(lang + " forbidden operator macro absent", not re.search(r"\\operatorname\b", doc))
        if shutil.which("pandoc"):
            try:
                check(lang + " independent GFM math parser agrees", math.pandoc_math(doc) == payloads(spans))
            except Exception as error:
                check(lang + " independent GFM math parser succeeds", False, str(error))
        else:
            skip(lang + " independent GFM math parser", "pandoc is not installed")
        result["math_counts"][lang] = len(spans)

    try:
        import sympy as sym
    except ImportError:
        result["symbolic_verification"] = {"available": False}
        skip("3.8 exact resonant diagnostic", "sympy is not installed")
    else:
        z, X = sym.symbols("z X")
        symbols = {"z": z, "pi": sym.pi, "i": sym.I, "Integer": sym.Integer}
        pattern = re.compile(r"\[\[\s*([^,\[\]]+)\s*,\s*([^\[\]]+?)\s*\],\s*\[\s*([^,\[\]]+)\s*,\s*([^\[\]]+?)\s*\]\]")
        result["symbolic_verification"] = {
            "available": True, "sympy_version": sym.__version__,
            "fundamental_matrix_witness": "Y(z) = [[1, -log(z)], [0, 1/z]]; log(1) = 0",
            "positive_loop": "log(z) -> log(z) + 2*pi*i",
            "input": "The coefficient and monodromy matrices are parsed from each language's 3.8 diagnostic.",
        }
        for lang in docs:
            candidates = [test for test in parsed[lang]["3.8"]["tests"] if len(pattern.findall(test)) == 2]
            check("3.8 " + lang + " resonant matrix diagnostic identified", len(candidates) == 1)
            if len(candidates) != 1:
                continue
            try:
                A, T = [sym.Matrix(2, 2, [symbolic_entry(entry, symbols) for entry in matrix])
                        for matrix in pattern.findall(candidates[0])]
                Y = sym.Matrix([[1, -sym.log(z)], [0, 1/z]])
                continued = sym.Matrix([[1, -sym.log(z) - 2 * sym.pi * sym.I], [0, 1/z]])
                residue = (z * A).applyfunc(lambda entry: sym.limit(entry, z, 0))
                check("3.8 " + lang + " Y solves dY + A Y dz = 0 exactly", sym.simplify(Y.diff(z) + A * Y) == sym.zeros(2))
                check("3.8 " + lang + " standard basepoint frame", Y.subs(z, 1) == sym.eye(2))
                check("3.8 " + lang + " positive continuation gives the stated T", sym.simplify(continued - Y * T) == sym.zeros(2))
                check("3.8 " + lang + " stated residue and exponential", residue == sym.diag(0, 1) and (-2 * sym.pi * sym.I * residue).exp() == sym.eye(2))
                check("3.8 " + lang + " actual monodromy is nontrivial unipotent",
                      T != sym.eye(2) and (T - sym.eye(2)) ** 2 == sym.zeros(2)
                      and sym.expand(T.charpoly(X).as_expr() - (X - 1) ** 2) == 0)
            except Exception as error:
                check("3.8 " + lang + " symbolic diagnostic parsed and evaluated", False, str(error))

    # A concurrent edit must not yield a receipt assembled from different states.
    for label, directory in [("current", root), ("baseline", baseline)]:
        changed = [name for name, value in hashes[label].items()
                   if not (directory / name).is_file() or digest((directory / name).read_bytes()) != value]
        check(label + " inputs remained stable during verification", not changed, changed)
    return result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--baseline-dir", type=Path, required=True,
                        help="Immutable topic or repository directory at 5377bc5")
    parser.add_argument("--root", type=Path, default=Path(__file__).resolve().parents[2],
                        help="Current topic or repository directory")
    parser.add_argument("--output", type=Path, help="Write the complete JSON verification receipt")
    args = parser.parse_args()
    try:
        result = verify(args)
    except Exception as error:
        result = {"checks": [{"check": "verification completed", "passed": False,
                              "detail": type(error).__name__ + ": " + str(error)}]}
    rows = result["checks"]
    result["summary"] = {"passed": sum(row["passed"] is True for row in rows),
                         "failed": sum(row["passed"] is False for row in rows),
                         "skipped": sum(row["passed"] is None for row in rows)}
    if args.output:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(json.dumps(result, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    display = {key: result[key] for key in ["summary", "counts", "math_counts", "changed_targets"] if key in result}
    display["failures"] = [row for row in rows if row["passed"] is False]
    display["skipped"] = [row for row in rows if row["passed"] is None]
    print(json.dumps(display, ensure_ascii=False, indent=2))
    return int(bool(result["summary"]["failed"]))


if __name__ == "__main__":
    sys.exit(main())
