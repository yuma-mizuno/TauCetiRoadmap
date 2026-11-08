#!/usr/bin/env python3
"""Validate the shared RH proof architecture against an immutable snapshot.

The README files specify the mathematics. This checker verifies their structured
mirrors, prerequisite graph, source addresses, parsing and the edit boundary.
It does not infer mathematical scope preservation from selected prose phrases.
Historical checkers supply pure parsing helpers; their main programs are not run.
"""
from __future__ import annotations

import argparse
import difflib
import hashlib
import importlib.util
import json
import re
import shutil
import sys
import tomllib
from pathlib import Path


BASELINE_COMMIT = "fa5beb6d40adf6b8b96db4116b0aeabf781074fc"
AUTHORIZED_TARGETS = {"4.1", "4.2", "4.3", "4.4"}
DOCS = {"en": "README.md", "ja": "README.ja.md"}
CORE = [*DOCS.values(), "design/plan.json", "design/dependencies.json",
        "design/reuse_graph.json", "design/reuse_registry.json", "sources.toml",
        "Suggested.lean", "metadata.toml"]


def load_helpers(path, name):
    sys.dont_write_bytecode = True
    spec = importlib.util.spec_from_file_location(name, path)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


def needs_references(text, lang):
    marker = r"^Internal: ([^;]+)" if lang == "en" else r"^内部依存：([^;]+)"
    match = re.search(marker, text)
    internal = re.findall(r"\d+\.\d+", match[1]) if match else []
    external = re.findall(r"\]\(#dependency-([^\)]+)\)", text)
    return ["target:" + key for key in internal] + ["dependency:" + key for key in external]


class Receipt:
    def __init__(self, args):
        self.args, self.gates, self.failures, self.skips = args, [], [], []
        self.result = {
            "baseline_commit": BASELINE_COMMIT,
            "coverage": {}, "input_sha256": {}, "failures": self.failures,
            "limits": [
                "Structural consistency and preservation are checked; the roadmap theorem statements and shared-proof scope require mathematical review.",
                "Existing Japanese metadata is checked exactly; bilingual mathematical equivalence is not inferred from equal item counts.",
                "No Lean build or theorem proof is performed; GFM parsing is not a visual inspection of GitHub.",
            ],
        }

    def gate(self, name, errors):
        self.gates.append(name)
        if errors:
            self.failures.append({"check": name, "details": errors})

    def skip(self, name, reason):
        self.skips.append({"check": name, "reason": reason})

    def run(self):
        root, baseline = self.args.root.resolve(), self.args.baseline_dir.resolve()
        allowed = AUTHORIZED_TARGETS | set(self.args.allow_target)
        historical = sorted(str(path.relative_to(baseline)) for path in (baseline / "reports").rglob("*") if path.is_file())
        names = CORE + historical
        snapshots = {"current": {}, "baseline": {}}
        missing = []
        for label, directory in [("current", root), ("baseline", baseline)]:
            for name in names:
                path = directory / name
                if path.is_file():
                    snapshots[label][name] = path.read_bytes()
                else:
                    missing.append(label + ":" + name)
        self.gate("required inputs present", missing)
        self.result["input_sha256"] = {
            name: {label: hashlib.sha256(data[name]).hexdigest() for label, data in snapshots.items() if name in data}
            for name in names}
        self.result["checker_sha256"] = hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
        if missing:
            return
        if self.args.baseline_manifest:
            manifest = json.loads(self.args.baseline_manifest.read_text())
            mismatches = []
            for name, info in manifest["files"].items():
                data = snapshots["baseline"].get(name)
                actual = hashlib.sha1(b"blob " + str(len(data)).encode() + b"\0" + data).hexdigest() if data is not None else None
                if actual != info["blob_sha"]:
                    mismatches.append(name)
            if manifest["commit"] != BASELINE_COMMIT:
                mismatches.append("baseline commit")
            self.gate("baseline bytes match the pinned Git object manifest", mismatches)
        current, old = ({name: value.decode("utf-8") for name, value in snapshots[label].items()}
                        for label in ["current", "baseline"])
        parsers = load_helpers(baseline / "reports/timeless/check_timeless.py", "_sharing_fields")
        helpers = load_helpers(baseline / "reports/rh-reorganization/check_reorganization.py", "_sharing_helpers")
        math = load_helpers(baseline / "reports/submission/check_math_rendering.py", "_sharing_math")
        self.result["coverage"]["parser_helpers"] = ["sections", "fields", "ancestors", "source_mentions", "strings", "math_spans", "table_width_errors", "pandoc_math"]
        self.result["coverage"]["historical_main_programs_run"] = False
        docs = {lang: current[name] for lang, name in DOCS.items()}
        old_docs = {lang: old[name] for lang, name in DOCS.items()}
        sections = {lang: parsers.sections(text) for lang, text in docs.items()}
        old_sections = {lang: parsers.sections(text) for lang, text in old_docs.items()}
        plan, old_plan = (json.loads(data["design/plan.json"]) for data in [current, old])
        targets = [target for layer in plan["layers"] for target in layer["targets"]]
        old_targets = {target["id"]: target for layer in old_plan["layers"] for target in layer["targets"]}
        by_id = {target["id"]: target for target in targets}
        ids, inventory_errors = list(by_id), []
        if ids != list(old_targets) or len(targets) != len(by_id):
            inventory_errors.append("plan target identities/order")
        for lang in docs:
            headings = re.findall(r"^### (\d+\.\d+) ", docs[lang], re.M)
            if headings != ids or list(sections[lang]) != ids:
                inventory_errors.append(lang + " target headings")
        self.gate("target inventory and order preserved", inventory_errors)
        if inventory_errors:
            return
        changed = {lang: [tid for tid in ids if sections[lang][tid]["text"] != old_sections[lang][tid]["text"]] for lang in docs}
        scope_errors = [lang + ": " + tid for lang in docs for tid in changed[lang] if tid not in allowed]
        if changed["en"] != changed["ja"]:
            scope_errors.append("EN/JA changed target sets differ")
        for target in targets:
            tid = target["id"]
            if tid not in allowed and target != old_targets[tid]:
                scope_errors.append("metadata: " + tid)
        self.gate("numbered edits confined to authorized targets", scope_errors)
        self.result["coverage"]["numbered_sections"] = {"total": len(ids), "authorized": sorted(allowed), "changed": changed,
                                                        "unchanged_en": len(ids) - len(changed["en"]), "unchanged_ja": len(ids) - len(changed["ja"])}
        parsed, parse_errors = {lang: {} for lang in docs}, []
        for lang in docs:
            for tid in ids:
                try:
                    parsed[lang][tid] = parsers.fields(sections[lang][tid]["text"])
                except Exception as error:
                    parse_errors.append({"target": tid, "language": lang, "error": str(error)})
        self.gate("every numbered contract parses", parse_errors)
        if parse_errors:
            return
        parts = {part["id"]: part for part in plan["parts"]}
        old_parts = {part["id"]: part for part in old_plan["parts"]}
        deps = json.loads(current["design/dependencies.json"])["contracts"]
        dep_by_id = {contract["id"]: contract for contract in deps}
        graph = json.loads(current["design/reuse_graph.json"])
        registry = json.loads(current["design/reuse_registry.json"])
        contract_errors, identity_errors, needs_errors, item_ids = [], [], [], []
        for name in ["design/plan.json", "design/dependencies.json", "design/reuse_graph.json", "design/reuse_registry.json"]:
            before, after = json.loads(old[name]), json.loads(current[name])
            if set(before) != set(after) or before.get("schema") != after.get("schema"):
                identity_errors.append(name + " schema")
        ja_coverage = {"full_contracts": 0, "hypotheses": 0, "supporting_items": 0}
        for target in targets:
            tid, previous = target["id"], old_targets[target["id"]]
            en, ja = parsed["en"][tid], parsed["ja"][tid]
            if any(target.get(key) != previous.get(key) for key in ["id", "kind", "name", "part", "scope_role", "owner"]):
                identity_errors.append(tid)
            if set(target) != set(previous):
                identity_errors.append(tid + " metadata field inventory")
            if target["part"] not in parts or target["scope_role"] != parts[target["part"]]["scope_role"]:
                identity_errors.append(tid + " part role")
            comparisons = [("title", target["title"], sections["en"][tid]["title"]),
                           ("statement", target["statement"], en["statement"]),
                           ("hypotheses", target["hypotheses"], en["hypotheses"]),
                           ("hypotheses bilingual count", len(en["hypotheses"]), len(ja["hypotheses"])),
                           ("source-scope bilingual field presence", en["source_scope"] is not None, ja["source_scope"] is not None),
                           ("needs", target["readme_needs"], en.get("needs")),
                           ("needs_ja", target["readme_needs_ja"], ja.get("needs"))]
            for field in ["api", "tests"]:
                entries = target[field]
                comparisons.append((field, [entry["statement"] for entry in entries], en[field]))
                comparisons.append((field + " bilingual count", len(en[field]), len(ja[field])))
                comparisons.append((field + " local IDs", [entry["id"] for entry in entries], [f"{tid}.{field}.{i + 1}" for i in range(len(entries))]))
                item_ids.extend(entry["id"] for entry in entries)
                for index, entry in enumerate(entries):
                    if "statement_ja" in entry:
                        comparisons.append((entry["id"] + ".statement_ja", entry["statement_ja"], ja[field][index] if index < len(ja[field]) else None))
            support = target.get("supporting_constructions", [])
            if [entry["id"] for entry in support] != [entry["id"] for entry in previous.get("supporting_constructions", [])]:
                identity_errors.append(tid + " supporting construction identities")
            comparisons.extend([("supporting", [entry["statement"] for entry in support], en["supporting"]),
                                ("supporting_ja", [entry["statement_ja"] for entry in support], ja["supporting"])])
            item_ids.extend(entry["id"] for entry in support)
            ja_coverage["supporting_items"] += len(support)
            for field in ["title", "statement", "hypotheses", "api", "tests", "source_scope"]:
                key = field + "_ja"
                if key in previous and key not in target:
                    contract_errors.append({"target": tid, "field": key + " removed"})
                if key in target:
                    comparisons.append((key, target[key], sections["ja"][tid]["title"] if field == "title" else ja[field]))
                    if field == "hypotheses":
                        ja_coverage["hypotheses"] += 1
            if en["source_scope"] is not None:
                comparisons.append(("source_scope", target.get("source_scope"), en["source_scope"]))
                if "locator" in target:
                    comparisons.append(("source_scope locator", target["locator"].get("where"), en["source_scope"]))
            elif "source_scope" in target and target["source_scope"] not in en["statement"]:
                contract_errors.append({"target": tid, "field": "inline source_scope"})
            if "ja" in previous and "ja" not in target:
                contract_errors.append({"target": tid, "field": "full ja object removed"})
            if "ja" in target:
                ja_coverage["full_contracts"] += 1
                for field in ["title", "statement", "hypotheses", "api", "tests", "needs", "source_scope"]:
                    if field in target["ja"]:
                        comparisons.append(("ja." + field, target["ja"][field], sections["ja"][tid]["title"] if field == "title" else ja[field]))
            contract_errors.extend({"target": tid, "field": field} for field, expected, actual in comparisons if expected != actual)
            for lang, labels in [("en", {"framework": "General theory.", "application": "Painlevé application."}),
                                 ("ja", {"framework": "一般理論。", "application": "パンルヴェへの適用。"})]:
                roles = [key for key, label in labels.items() if "**" + label + "**" in sections[lang][tid]["text"]]
                if roles != [target["scope_role"]]:
                    identity_errors.append(tid + " " + lang + " role marker")
                grouped = ([entry for entry in target["prerequisites"] if entry.startswith("target:")]
                           + [entry for entry in target["prerequisites"] if entry.startswith("dependency:")])
                if needs_references(parsed[lang][tid].get("needs", ""), lang) != grouped:
                    needs_errors.append(tid + " " + lang)
        self.gate("target identities and bilingual ownership preserved", identity_errors)
        self.gate("EN/JA contract fields match the plan", contract_errors)
        self.gate("bilingual Needs match prerequisite declarations", needs_errors)
        self.gate("API, diagnostic and supporting addresses unique", [] if len(item_ids) == len(set(item_ids)) else ["duplicate item IDs"])
        self.result["coverage"]["japanese_metadata"] = ja_coverage
        self.result["coverage"]["contract_fields"] = ["title", "statement", "hypotheses", "api", "tests", "supporting", "source_scope", "Needs", "existing Japanese fields"]

        positions = {tid: i for i, tid in enumerate(ids)}
        adjacency, prerequisite_errors = {}, []
        for target in targets:
            tid, prerequisites = target["id"], target["prerequisites"]
            internal = [entry[7:] for entry in prerequisites if entry.startswith("target:")]
            external = [entry[11:] for entry in prerequisites if entry.startswith("dependency:")]
            if len(internal) + len(external) != len(prerequisites) or len(set(prerequisites)) != len(prerequisites):
                prerequisite_errors.append(tid + " malformed/duplicate prerequisites")
            if not set(external) <= set(dep_by_id) or any(positions.get(dep, len(ids)) >= positions[tid] for dep in internal):
                prerequisite_errors.append(tid + " unknown or forward prerequisite")
            adjacency[tid] = internal
        self.gate("prerequisites are known, unique and preceding", prerequisite_errors)
        expected_edges = [{"from": tid, "to": dep} for tid, parents in adjacency.items() for dep in parents]
        expected_nodes = [{key: target[key] for key in ["id", "part", "scope_role"]} for target in targets]
        self.gate("reuse graph matches contracts", [] if graph["edges"] == expected_edges and graph["nodes"] == expected_nodes else ["nodes or edges differ"])
        try:
            ancestry = helpers.ancestors(adjacency)
            independence_errors = [tid for tid in ids if by_id[tid]["scope_role"] == "framework"
                                   and any(by_id[ancestor]["scope_role"] != "framework" for ancestor in ancestry[tid])]
            independence_errors += [tid for tid in ids if 3 <= int(tid.split(".")[0]) <= 6 and any(dep.startswith("7.") for dep in ancestry[tid])]
            if any(dep.startswith("4.") for dep in ancestry["3.8"]):
                independence_errors.append("3.8 depends on Layer 4")
            self.gate("DAG and general/local proof independence", independence_errors)
        except ValueError as error:
            self.gate("DAG and general/local proof independence", [str(error)])
        registry_errors = []
        if list(parts) != list(old_parts) or [part["id"] for part in registry["parts"]] != list(parts):
            registry_errors.append("part inventory")
        for part in plan["parts"]:
            if part["scope_role"] == "framework" and part != old_parts.get(part["id"]):
                registry_errors.append("general part changed: " + part["id"])
        for part in registry["parts"]:
            definition = parts.get(part["id"], {})
            if (part["target_ids"] != [target["id"] for target in targets if target["part"] == part["id"]]
                    or any(part.get(key) != definition.get(key) for key in ["title", "scope_role"])
                    or part["owner"] != definition.get("contracts", {}).get("owner")):
                registry_errors.append(part["id"])
        self.gate("part registry and general frameworks preserved", registry_errors)
        counts = {"parts": len(parts), "general_parts": sum(part["scope_role"] == "framework" for part in parts.values()),
                  "layers": len(plan["layers"]), "targets": len(targets),
                  "general_targets": sum(target["scope_role"] == "framework" for target in targets),
                  "api_laws": sum(len(target["api"]) for target in targets), "diagnostics": sum(len(target["tests"]) for target in targets),
                  "internal_edges": len(expected_edges), "supporting_constructions": sum(len(target.get("supporting_constructions", [])) for target in targets)}
        self.gate("all counts derived from contracts", [] if counts == plan["counts"] else [counts])
        layer_errors = []
        if [layer["key"] for layer in plan["layers"]] != [layer["key"] for layer in old_plan["layers"]]:
            layer_errors.append("layer inventory")
        for layer in plan["layers"]:
            if f"## Layer {layer['key']}: {layer['title']}" not in docs["en"] or f"## レイヤー{layer['key']}：{layer['title_ja']}" not in docs["ja"]:
                layer_errors.append(layer["key"] + " title")
            if any(target["id"].split(".")[0] != layer["key"] for target in layer["targets"]):
                layer_errors.append(layer["key"] + " numbering")
        self.gate("layer titles and numbering synchronized", layer_errors)
        self.result["coverage"]["counts"] = counts | {"application_targets": len(targets) - counts["general_targets"]}
        supplier_errors = []
        old_deps = {contract["id"]: contract for contract in json.loads(old["design/dependencies.json"])["contracts"]}
        if list(dep_by_id) != list(old_deps) or len(dep_by_id) != len(deps):
            supplier_errors.append("supplier inventory")
        for contract in deps:
            cid = contract["id"]
            if contract["consumers"] != [target["id"] for target in targets if "dependency:" + cid in target["prerequisites"]]:
                supplier_errors.append(cid + " consumers")
            if any(contract.get(key) != old_deps.get(cid, {}).get(key) for key in ["paths", "sections", "source_revision", "supplied"]):
                supplier_errors.append(cid + " supplied scope")
            for lang in docs:
                matching = [line for line in docs[lang].splitlines() if '<a id="dependency-' + cid + '">' in line]
                scope = contract["supplied"] + " " + contract["owned_here"] if lang == "en" else contract["supplied_ja"]
                if len(matching) != 1 or scope not in matching[0]:
                    supplier_errors.append(cid + " " + lang + " table")
        self.gate("external scopes, consumers and bilingual tables synchronized", supplier_errors)

        sources, old_sources = (tomllib.loads(data["sources.toml"])["source"] for data in [current, old])
        source_by_id = {source["id"]: source for source in sources}
        old_source_by_id = {source["id"]: source for source in old_sources}
        source_errors = []
        if len(source_by_id) != len(sources) or not set(old_source_by_id) <= set(source_by_id):
            source_errors.append("source inventory")
        for lang, doc in docs.items():
            bibliography = re.findall(r"^- \*\*([A-Z][A-Z0-9_-]*)\.\*\*", doc, re.M)
            if set(bibliography) != set(source_by_id) or len(bibliography) != len(set(bibliography)):
                source_errors.append(lang + " bibliography/registry inventory")
            citations = set(re.findall(r"(?:\(|;)\s*([A-Z]{1,8}\d{2})(?=[,;:)\s])", doc))
            if citations - set(source_by_id):
                source_errors.append(lang + " unregistered citation keys: " + repr(sorted(citations - set(source_by_id))))
        for source in sources:
            sid, cited = source["id"], source["cited_for"]
            if not set(cited) <= set(ids) or len(cited) != len(set(cited)):
                source_errors.append(sid + " consumers")
            previous = old_source_by_id.get(sid)
            if previous and any(source.get(key) != previous.get(key) for key in ["id", "authors", "title", "year", "venue", "arxiv", "url"]):
                source_errors.append(sid + " bibliographic identity")
            if (set(cited) ^ set(previous["cited_for"] if previous else [])) - allowed:
                source_errors.append(sid + " unrelated consumers changed")
        for target in targets:
            tid, locator = target["id"], target.get("locator", {})
            explicit = set(locator.get("sources", [])) | ({locator["source"]} if "source" in locator else set())
            for support in target.get("supporting_constructions", []):
                explicit.update(support.get("source_keys", []))
            if not explicit <= set(source_by_id) | {"generic"}:
                source_errors.append(tid + " unknown locator/source key")
            mentioned = explicit - {"generic"}
            for lang in docs:
                mentioned |= helpers.source_mentions(sections[lang][tid]["text"], source_by_id)
            mentioned |= helpers.source_mentions(json.dumps([locator, target.get("additional_source_refs", [])], ensure_ascii=False), source_by_id)
            for sid in mentioned:
                if tid not in source_by_id.get(sid, {}).get("cited_for", []):
                    source_errors.append(tid + " unregistered source " + sid)
        for part in plan["parts"]:
            for source in part["contracts"].get("sources", []):
                if source["key"] not in source_by_id or source.get("url") != source_by_id[source["key"]].get("url"):
                    source_errors.append(part["id"] + " source summary " + source["key"])
            for item in part["contracts"].get("owned_proof_obligations", []):
                owners = item.get("targets", [item["target"]] if "target" in item else [])
                if not owners or not set(owners) <= set(ids):
                    source_errors.append(part["id"] + " unknown proof owner")
        self.gate("bibliographic identities and all explicit source consumers resolve", source_errors)
        self.result["coverage"]["sources"] = {"total": len(sources), "added": sorted(set(source_by_id) - set(old_source_by_id)),
                                               "consumer_changes": {sid: {"before": old_source_by_id.get(sid, {}).get("cited_for", []), "after": source["cited_for"]}
                                                                    for sid, source in source_by_id.items() if source["cited_for"] != old_source_by_id.get(sid, {}).get("cited_for", [])}}

        syntax_errors, math_errors, math_counts, math_changes = [], [], {}, {}
        for lang, doc in docs.items():
            anchors = re.findall(r'<a id="([^"]+)"></a>', doc)
            links = set(re.findall(r"\]\(#([^\)]+)\)", doc))
            if len(anchors) != len(set(anchors)) or not links <= set(anchors):
                syntax_errors.append(lang + " duplicate/missing anchors: " + repr(sorted(links - set(anchors))))
            if {anchor for anchor in anchors if anchor.startswith("target-")} != {"target-" + tid.replace(".", "-") for tid in ids}:
                syntax_errors.append(lang + " target anchor inventory")
            widths = math.table_width_errors(doc)
            if widths:
                syntax_errors.append({"language": lang, "table_widths": widths})
            spans, old_spans = math.math_spans(doc), math.math_spans(old_docs[lang])
            raw = lambda text: [text[item["start"]:item["end"]] for item in math.math_spans(text)]
            outside, old_outside = doc, old_docs[lang]
            for tid in allowed:
                if tid in sections[lang]:
                    outside = outside.replace(sections[lang][tid]["text"], "", 1)
                    old_outside = old_outside.replace(old_sections[lang][tid]["text"], "", 1)
            if raw(outside) != raw(old_outside):
                math_errors.append(lang + " math outside authorized targets changed")
            math_changes[lang] = [tid for tid in ids if raw(sections[lang][tid]["text"]) != raw(old_sections[lang][tid]["text"])]
            if re.search(r"\\operatorname\b", doc):
                math_errors.append(lang + " forbidden operator macro")
            if shutil.which("pandoc"):
                if math.pandoc_math(doc) != [(span["kind"], span["tex"]) for span in spans]:
                    math_errors.append(lang + " independent GFM parser disagrees")
            else:
                self.skip(lang + " independent GFM parser", "pandoc is not installed")
            math_counts[lang] = {"baseline": len(old_spans), "current": len(spans)}
        self.gate("Markdown tables, unique anchors and fragment links valid", syntax_errors)
        self.gate("math preserved outside edit scope and independently parsed", math_errors)
        self.result["coverage"]["math"] = {"counts": math_counts, "changed_target_payloads": math_changes,
                                            "pandoc_available": shutil.which("pandoc") is not None}
        active_prose = [(name, f"line {number}", line) for name in DOCS.values() for number, line in enumerate(current[name].splitlines(), 1)]
        for name in ["design/plan.json", "design/dependencies.json"]:
            active_prose.extend((name, path, value) for path, _, value in helpers.strings(json.loads(current[name])))
        active_prose.extend(("sources.toml", source["id"], source.get("version_note", "")) for source in sources)
        scars = [{"file": name, "location": location, "match": match[0]} for name, location, text in active_prose for match in helpers.REVIEW_PROSE.finditer(text)]
        self.gate("active prose has no draft or review-response markers", scars)
        immutable = ["Suggested.lean", "metadata.toml", *[name for name in historical if name != "reports/submission/REVIEW.md"]]
        history_errors = [name for name in immutable if snapshots["current"][name] != snapshots["baseline"][name]]
        submission = "reports/submission/REVIEW.md"
        additions = difflib.SequenceMatcher(None, old[submission].splitlines(keepends=True), current[submission].splitlines(keepends=True), autojunk=False)
        if any(tag not in {"equal", "insert"} for tag, *_ in additions.get_opcodes()):
            history_errors.append(submission + " historical text changed beyond an inserted supersession pointer")
        self.gate("Suggested, topic metadata and historical receipts retained", history_errors)
        self.result["coverage"]["historical_files_preserved"] = len(immutable) - 2
        self.result["changed_input_files"] = [name for name in names if snapshots["current"][name] != snapshots["baseline"][name]]
        stable_errors = [label + ":" + name for label, directory in [("current", root), ("baseline", baseline)]
                         for name, data in snapshots[label].items() if not (directory / name).is_file() or (directory / name).read_bytes() != data]
        self.gate("inputs stable during verification", stable_errors)

    def finish(self):
        self.result["summary"] = {"gates": len(self.gates), "passed": len(self.gates) - len(self.failures),
                                  "failed": len(self.failures), "skipped": len(self.skips)}
        self.result["checked_gates"] = self.gates
        if self.skips:
            self.result["skipped"] = self.skips
        return self.result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--baseline-dir", type=Path, required=True, help="Immutable PainleveEquations directory at the pinned baseline")
    parser.add_argument("--baseline-manifest", type=Path, help="Optional Git-object manifest for the baseline snapshot")
    parser.add_argument("--root", type=Path, default=Path(__file__).resolve().parents[2])
    parser.add_argument("--allow-target", action="append", default=[], help="Additional explicitly approved numbered cross-reference edit")
    parser.add_argument("--output", type=Path)
    args = parser.parse_args()
    receipt = Receipt(args)
    try:
        receipt.run()
    except Exception as error:
        receipt.gate("verification completed", [type(error).__name__ + ": " + str(error)])
    result = receipt.finish()
    if args.output:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(json.dumps(result, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(json.dumps({"summary": result["summary"], "coverage": result["coverage"], "failures": result["failures"]}, ensure_ascii=False, indent=2))
    return int(bool(result["summary"]["failed"]))


if __name__ == "__main__":
    sys.exit(main())
