#!/usr/bin/env python3
"""Independent preservation checks for the single Painleve roadmap.

This program is read-only with respect to the baseline and the candidate.  It
writes only the explicitly selected JSON report.  Its checks concern a
mathematical specification and its provenance, not the truth of its theorems.
"""
from __future__ import annotations

import argparse
from collections import Counter
from datetime import datetime, timezone
import hashlib
import importlib.util
import json
from pathlib import Path
import re
import sys
import tempfile
import tomllib
import zipfile


HERE = Path(__file__).resolve().parent
PARTS = (
    ("N", "NonlinearConnections", "frameworks/NonlinearConnections", "framework"),
    ("M", "MeromorphicConnectionModuli", "frameworks/MeromorphicConnectionModuli", "framework"),
    ("A", "AnalyticRHPAndDeterminants", "frameworks/AnalyticRHPAndDeterminants", "framework"),
    ("C", "AlgebraicConfluence", "frameworks/AlgebraicConfluence", "framework"),
    ("P", "PainleveEquationsAndFunctions", ".", "application"),
    ("G", "FiveLogarithmicPoints", "applications/FiveLogarithmicPoints", "application"),
)
PREFIX = {name: prefix for prefix, name, _, _ in PARTS}
EXPECTED = {"targets": 77, "api_laws": 214, "diagnostics": 257,
            "internal_edges": 321, "source_records": 24, "layers": 19}
ROADMAP = "PainleveEquationsAndFunctions"
EXTERNAL_PREFIXES = ("roadmap:", "foundation:", "mathlib:", "gap:")


class Audit:
    def __init__(self):
        self.checks = []
        self.observations = []

    def check(self, name, condition, detail=None):
        row = {"check": name, "passed": bool(condition)}
        if not condition and detail is not None:
            row["detail"] = detail
        self.checks.append(row)
        return bool(condition)

    def equal(self, name, actual, expected):
        return self.check(name, actual == expected,
                          {"expected": expected, "actual": actual})

    def observation(self, text):
        self.observations.append(text)


def load_json(path):
    return json.loads(path.read_text(encoding="utf-8"))


def sha256(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def text_sha256(text):
    return hashlib.sha256(text.encode("utf-8")).hexdigest()


def value_sha256(value):
    return text_sha256(json.dumps(value, ensure_ascii=False, sort_keys=True, separators=(",", ":")))


def strings(value):
    if isinstance(value, str):
        yield value
    elif isinstance(value, list):
        for item in value:
            yield from strings(item)
    elif isinstance(value, dict):
        for item in value.values():
            yield from strings(item)


def targets(plan):
    return [target for layer in plan["layers"] for target in layer["targets"]]


def resolve_old(ref, module):
    """Resolve old edges independently of the merger's implementation."""
    if ref.startswith("target:"):
        return f"{module}/{ref[len('target:'):]}"
    for tag in ("framework:", "application:"):
        if ref.startswith(tag):
            return ref[len(tag):]
    if ref.startswith(EXTERNAL_PREFIXES):
        return None
    raise ValueError(f"Unrecognized old dependency in {module}: {ref}")


def resolve_new(ref):
    if ref.startswith("target:"):
        return ref[len("target:"):]
    if ref.startswith(EXTERNAL_PREFIXES):
        return None
    raise ValueError(f"Unrecognized unified dependency: {ref}")


def graph_id(value):
    if value.startswith(ROADMAP + "/"):
        return value[len(ROADMAP) + 1:]
    return value


def counts(plan):
    ts = targets(plan)
    return {"targets": len(ts),
            "api_laws": sum(len(t.get("api", [])) for t in ts),
            "diagnostics": sum(len(t.get("tests", [])) for t in ts),
            "layers": len(plan["layers"])}


def closure(adjacency, start):
    found = set()
    pending = list(adjacency.get(start, []))
    while pending:
        point = pending.pop()
        if point not in found:
            found.add(point)
            pending.extend(adjacency.get(point, []))
    return found


def cycles(adjacency):
    state = {}
    stack = []
    result = []

    def visit(node):
        if state.get(node) == 2:
            return
        if state.get(node) == 1:
            result.append(stack[stack.index(node):] + [node])
            return
        state[node] = 1
        stack.append(node)
        for nxt in adjacency.get(node, []):
            visit(nxt)
        stack.pop()
        state[node] = 2

    for node in adjacency:
        visit(node)
    return result


def mapped_json(value, prefix, normalization):
    if isinstance(value, str):
        return normalization.map_ref(value, prefix)
    if isinstance(value, list):
        return [mapped_json(item, prefix, normalization) for item in value]
    if isinstance(value, dict):
        return {key: mapped_json(item, prefix, normalization)
                for key, item in value.items()}
    return value


def check_structural(audit, before, candidate, normalization):
    source_plans = {}
    expected_targets = {}
    old_to_new = {}
    original_targets = {}
    source_layers = []
    for prefix, module, directory, scope in PARTS:
        rel = "design/plan.json" if directory == "." else directory + "/plan.json"
        plan = load_json(before / rel)
        audit.equal(f"baseline identity {prefix}", plan["roadmap"], module)
        source_plans[prefix] = plan
        for layer in plan["layers"]:
            source_layers.append((prefix, layer, scope))
            for target in layer["targets"]:
                old = f"{module}/{target['id']}"
                new = prefix + target["id"]
                audit.check(f"source unique address {old}", old not in old_to_new)
                old_to_new[old] = new
                original_targets[old] = target
                expected = mapped_json(target, prefix, normalization)
                expected["id"] = new
                expected_targets[new] = (expected, prefix, scope, target)

    source_edges = []
    old_adjacency = {}
    expected_adjacency = {}
    expected_external = {}
    for old, target in original_targets.items():
        module = old.split("/", 1)[0]
        new = old_to_new[old]
        deps = []
        ext = []
        for ref in target.get("prerequisites", []):
            resolved = resolve_old(ref, module)
            if resolved is None:
                ext.append(ref)
            else:
                audit.check(f"baseline resolves {old} -> {resolved}",
                            resolved in old_to_new)
                deps.append(resolved)
                source_edges.append((old, resolved))
        old_adjacency[old] = deps
        expected_adjacency[new] = [old_to_new[d] for d in deps]
        expected_external[new] = ext

    source_counts = {
        "targets": len(original_targets),
        "api_laws": sum(len(t.get("api", [])) for t in original_targets.values()),
        "diagnostics": sum(len(t.get("tests", [])) for t in original_targets.values()),
        "internal_edges": len(source_edges),
        "layers": len(source_layers),
    }
    for key, value in source_counts.items():
        audit.equal(f"reviewed baseline {key}", value, EXPECTED[key])

    plan = load_json(candidate / "design/plan.json")
    audit.equal("one roadmap identity", plan.get("roadmap"), ROADMAP)
    new_targets = targets(plan)
    by_id = {t["id"]: t for t in new_targets}
    audit.equal("unified target addresses are unique", len(by_id), len(new_targets))
    audit.equal("target-address bijection", sorted(by_id), sorted(expected_targets))
    for key, value in counts(plan).items():
        audit.equal(f"unified {key}", value, EXPECTED[key])

    for new, (expected, prefix, scope, original) in expected_targets.items():
        if new not in by_id:
            continue
        actual = by_id[new]
        audit.equal(f"part metadata {new}", actual.get("part"), prefix)
        audit.equal(f"scope metadata {new}", actual.get("scope_role"), scope)
        for key, value in expected.items():
            audit.check(f"field exists {new}.{key}", key in actual)
            audit.equal(f"field preserved {new}.{key}", actual.get(key), value)
        unexpected = sorted(set(actual) - set(expected) - {"part", "scope_role"})
        audit.equal(f"only administrative target fields added {new}", unexpected, [])
        for value in strings(actual):
            for ref in re.findall(r"target:([NMACPG]\d+\.\d+)", value):
                audit.check(f"explicit target reference resolves {new} -> {ref}",
                            ref in by_id)

    actual_layer_index = {(layer.get("part"), layer["key"]): layer
                          for layer in plan["layers"]}
    audit.equal("layer identities are unique", len(actual_layer_index), len(plan["layers"]))
    expected_layer_order = [prefix + layer["key"] for prefix, layer, _ in source_layers]
    audit.equal("part-local layer order preserved", [x["key"] for x in plan["layers"]],
                expected_layer_order)
    for prefix, layer, scope in source_layers:
        key = prefix + layer["key"]
        actual = actual_layer_index.get((prefix, key))
        audit.check(f"layer present {key}", actual is not None)
        if actual is None:
            continue
        expected_title = normalization.rewrite_text(layer["title"], prefix)
        if key == "M4":
            # Reviewed presentation clarification: the branch is conditional
            # in use, but all of its theorem targets remain in roadmap scope.
            audit.equal("reviewed original M4 heading", expected_title,
                        "Optional logarithmic Riemann–Hilbert and properness branch")
            expected_title = "Logarithmic Riemann–Hilbert and properness branch"
        audit.equal(f"layer title preserved {key}", actual.get("title"), expected_title)
        audit.equal(f"layer scope {key}", actual.get("scope_role"), scope)
        audit.equal(f"layer target order {key}", [t["id"] for t in actual["targets"]],
                    [prefix + t["id"] for t in layer["targets"]])

    adjacency = {}
    external = {}
    for target in new_targets:
        name = target["id"]
        internal = []
        ext = []
        for ref in target.get("prerequisites", []):
            try:
                resolved = resolve_new(ref)
            except ValueError as error:
                audit.check(f"unified reference syntax {name}", False, str(error))
                continue
            if resolved is None:
                ext.append(ref)
            else:
                audit.check(f"unified dependency resolves {name} -> {resolved}",
                            resolved in by_id)
                internal.append(resolved)
        adjacency[name] = internal
        external[name] = ext
        audit.equal(f"exact internal adjacency {name}", internal,
                    expected_adjacency.get(name))
        audit.equal(f"exact external contracts {name}", ext,
                    expected_external.get(name))

    edge_count = sum(len(v) for v in adjacency.values())
    audit.equal("unified internal edge count", edge_count, EXPECTED["internal_edges"])
    mapped_edges = Counter((old_to_new[u], old_to_new[v]) for u, v in source_edges)
    current_edges = Counter((u, v) for u, vs in adjacency.items() for v in vs)
    audit.equal("dependency multigraph isomorphism", sorted(current_edges.items()),
                sorted(mapped_edges.items()))
    audit.equal("no dependency cycle", cycles(adjacency), [])
    for node in by_id:
        reached = closure(adjacency, node)
        if node[0] in {"N", "M", "A", "C"}:
            bad = sorted(v for v in reached if v[0] in {"P", "G"})
            audit.equal(f"general closure excludes applications {node}", bad, [])
        if node.startswith("G"):
            audit.equal(f"five-pole closure excludes Painleve {node}",
                        sorted(v for v in reached if v.startswith("P")), [])
        if re.match(r"P[1-8]\.", node):
            audit.equal(f"intrinsic closure excludes scalar comparison {node}",
                        sorted(v for v in reached if v.startswith("P9.")), [])

    graph = load_json(candidate / "design/reuse_graph.json")
    nodes = graph["nodes"]
    graph_nodes = {graph_id(node["id"]): node for node in nodes}
    audit.equal("graph nodes unique", len(graph_nodes), len(nodes))
    audit.equal("graph covers plan", sorted(graph_nodes), sorted(by_id))
    for name, node in graph_nodes.items():
        audit.equal(f"graph internal edges {name}",
                    [graph_id(x) for x in node.get("prerequisites", [])],
                    adjacency.get(name))
        audit.equal(f"graph external contracts {name}",
                    node.get("external_contracts", []), external.get(name))
    old_graph = load_json(before / "design/reuse_graph.json")
    for node in old_graph["nodes"]:
        name = node["id"]
        audit.equal(f"baseline stored graph edges {name}",
                    node["prerequisites"], old_adjacency.get(name))
        audit.equal(f"baseline stored graph externals {name}",
                    node["external_contracts"], expected_external.get(old_to_new.get(name)))

    active_plans = []
    for path in candidate.rglob("plan.json"):
        relative = path.relative_to(candidate)
        if relative.parts[0] not in {"reports", "history", "input"}:
            active_plans.append(relative.as_posix())
    audit.equal("one active plan file", sorted(active_plans), ["design/plan.json"])
    registry = load_json(candidate / "design/reuse_registry.json")
    audit.equal("registry identity", registry.get("roadmap"), ROADMAP)
    audit.equal("registry points to one plan", registry.get("plan"), "design/plan.json")
    audit.check("registry no six active modules", "modules" not in registry)

    old_sources = tomllib.loads((before / "sources.toml").read_text(encoding="utf-8"))
    new_sources = tomllib.loads((candidate / "sources.toml").read_text(encoding="utf-8"))
    audit.equal("source records count", len(new_sources["source"]), EXPECTED["source_records"])
    audit.equal("all source records unchanged", new_sources, old_sources)
    audit.equal("source registry bytes unchanged", sha256(candidate / "sources.toml"),
                sha256(before / "sources.toml"))

    # The shape of the author-generated provenance report is audited separately
    # below once present; this canonical address map does not depend on that report.
    provenance = load_json(candidate / "reports/unification/id_map.json")
    audit.equal("provenance mapping agrees independently", provenance.get("mapping"), old_to_new)
    recorded_metadata = provenance.get("original_component_metadata", {})
    audit.equal("historical metadata namespaces", sorted(recorded_metadata), sorted(PREFIX))
    for prefix, module, _, _ in PARTS:
        original = {k: v for k, v in source_plans[prefix].items() if k != "layers"}
        audit.equal(f"complete historical component metadata {module}",
                    recorded_metadata.get(module), original)

    registry_parts = {p["id"]: p for p in registry.get("parts", [])}
    audit.equal("registry has exactly six internal parts", sorted(registry_parts),
                sorted(p[0] for p in PARTS))
    for prefix, _, _, scope in PARTS:
        entry = registry_parts.get(prefix, {})
        audit.equal(f"registry target coverage {prefix}", entry.get("target_ids"),
                    [t["id"] for t in new_targets if t["part"] == prefix])
        audit.equal(f"registry layer coverage {prefix}", entry.get("layer_keys"),
                    [l["key"] for l in plan["layers"] if l["part"] == prefix])
        audit.equal(f"registry scope {prefix}", entry.get("scope_role"), scope)

    return {"source_plans": source_plans, "old_to_new": old_to_new,
            "counts": dict(counts(plan), internal_edges=edge_count,
                           source_records=len(new_sources["source"])),
            "plan": plan}


EN_TITLES = {
    "N": "Nonlinear connections and their general theorems",
    "M": "Intrinsic construction from meromorphic-connection moduli",
    "A": "Analytic RHPs and determinants", "C": "Algebraic confluence",
    "P": "Painlevé equations and functions: the intrinsic application",
    "G": "Five logarithmic points: a second application",
}
JA_TITLES = {
    "N": "非線形接続とその一般定理", "M": "有理型接続モジュライからの内在的構成",
    "A": "解析的RHPと行列式", "C": "代数的合流",
    "P": "パンルヴェ方程式・関数への内在的な適用", "G": "五つの対数極への第二の適用",
}
# The reviewer will freeze this digest after reading every administrative edit.
# A changed manifest therefore cannot silently authorize a new prose rewrite.
APPROVED_LAYOUT_EDITS_SHA256 = "25a418c74cb61b765297ad1e42864e5170e0b5638c56324d2c78f1713934d167"


def document_heading(part, language):
    if part == "R":
        return ("## Appendix: the reusable proof contract" if language == "en"
                else "## 付録：再利用可能な証明の構成方針")
    title = (EN_TITLES if language == "en" else JA_TITLES)[part]
    return f"## {part}. {title}"


def document_link_map(part):
    mapping = {}
    for prefix, _, directory, _ in PARTS:
        mapping[directory + "/README.md"] = "#part-" + prefix.lower()
        mapping[directory + "/README.ja.md"] = "#part-" + prefix.lower()
    mapping.update({"REUSABILITY.md": "README.md#reuse-contract",
                    "REUSABILITY.ja.md": "README.ja.md#reuse-contract",
                    "plan.json": "design/plan.json",
                    "../../design/plan.json": "design/plan.json",
                    "../../sources.toml": "sources.toml"})
    if part != "R":
        for name in ("README.md", "README.ja.md"):
            mapping[name] = name + "#part-" + part.lower()
    return mapping


def mapped_source_body(raw, part, language, edits, normalization):
    """Independent application of the reviewed address/layout specification.

    The document-builder is never imported or executed by this validator.
    All old prose passes through this function, including text not duplicated
    in any structured target and Japanese-only appendices.
    """
    value = raw
    for edit in edits:
        value = value.replace(edit["old"], edit["new"])
    value = normalization.rewrite_text(value, part if part != "R" else "P")
    link_map = document_link_map(part)
    value = re.sub(r"\]\(([^)]+)\)",
                   lambda m: "](" + link_map.get(m.group(1), m.group(1)) + ")", value)
    value = re.sub(r"(?<![/\w])`plan\.json`", "`design/plan.json`", value)
    original_lines = value.splitlines()
    output = [document_heading(part, language)]
    for line in original_lines[1:]:
        match = re.fullmatch(r"(#{2,5}) (.*)", line)
        if match:
            content = match.group(2)
            local_target = re.fullmatch(r"(\d+\.\d+)(\s+.*)", content)
            if local_target and part != "R":
                address = part + local_target.group(1)
                output.append('<a id="target-' + address.lower().replace(".", "-") + '"></a>')
                output.append("#### " + address + local_target.group(2))
            else:
                if part != "R":
                    content = re.sub(r"^Layer (\d+)",
                                     lambda m: "Layer " + part + m.group(1), content)
                    content = re.sub(r"^第(\d+)層",
                                     lambda m: part + m.group(1) + "層", content)
                output.append("#" + match.group(1) + " " + content)
        elif part != "R" and re.match(r"^\| \d+\.\d+ \|", line):
            output.append(re.sub(r"^(\| )(\d+\.\d+)",
                                 lambda m: m.group(1) + part + m.group(2), line))
        else:
            output.append(line)
    return "\n".join(output).rstrip() + "\n"


def check_bodies(audit, before, candidate, manifest_path, normalization):
    """Compare every source-body character after only approved layout changes."""
    audit.check("document preservation manifest available", manifest_path.is_file(),
                str(manifest_path))
    if not manifest_path.is_file():
        return
    manifest = load_json(manifest_path)
    documents = manifest.get("documents", [])
    edits = manifest.get("layout_edits", [])
    audit.equal("administrative edits match independently reviewed scope",
                value_sha256(edits), APPROVED_LAYOUT_EDITS_SHA256)
    expected_sources = set()
    for language, filename in (("en", "README.md"), ("ja", "README.ja.md")):
        for prefix, _, directory, _ in PARTS:
            expected_sources.add((str(Path(directory) / filename), prefix, language, filename))
        source = "REUSABILITY.md" if language == "en" else "REUSABILITY.ja.md"
        expected_sources.add((source, "R", language, filename))
    actual_sources = [(x["source"], x["part"], x["language"], x["destination"]) for x in documents]
    audit.equal("fourteen full source bodies represented", len(documents), 14)
    audit.equal("source-body coverage", sorted(actual_sources), sorted(expected_sources))
    audit.equal("source-body addresses unique", len(set(actual_sources)), len(actual_sources))

    texts = {name: (candidate / name).read_text(encoding="utf-8")
             for name in ("README.md", "README.ja.md")}
    for entry in documents:
        source = entry["source"]
        part, language = entry["part"], entry["language"]
        key = f"{part}:{language}"
        old = (before / source).read_text(encoding="utf-8")
        document = texts[entry["destination"]]
        start, end = entry["start_marker"], entry["end_marker"]
        audit.equal(f"source bytes {key}", text_sha256(old), entry["source_sha256"])
        audit.equal(f"source character count {key}", len(old), entry["source_characters"])
        audit.equal(f"unique source begin marker {key}", document.count(start), 1)
        audit.equal(f"unique source end marker {key}", document.count(end), 1)
        if document.count(start) != 1 or document.count(end) != 1:
            continue
        begin = document.index(start) + len(start)
        finish = document.index(end)
        audit.check(f"ordered body markers {key}", begin < finish)
        audit.equal(f"body newline after marker {key}", document[begin:begin+1], "\n")
        actual = document[begin+1:finish]
        audit.equal(f"recorded body bytes {key}", text_sha256(actual), entry["transformed_sha256"])
        audit.equal(f"recorded body length {key}", len(actual), entry["preserved_body_characters"])
        local_edits = [e for e in edits if e["source"] == source]
        edited = old
        for number, edit in enumerate(local_edits):
            audit.equal(f"administrative edit occurrences {key}/{number}",
                        edited.count(edit["old"]), edit["occurrences"])
            audit.equal(f"administrative edit category {key}/{number}",
                        edit["kind"], "layout-or-reference-explanation")
            edited = edited.replace(edit["old"], edit["new"])
        expected = mapped_source_body(old, part, language, local_edits, normalization)
        audit.equal(f"full source prose preserved {key}", actual, expected)
        old_urls = Counter(re.findall(r"\]\((https?://[^)]+)\)", old))
        new_urls = Counter(re.findall(r"\]\((https?://[^)]+)\)", actual))
        audit.equal(f"external citation links unchanged {key}", new_urls, old_urls)

    plan = load_json(candidate / "design/plan.json")
    canonical_ids = [t["id"] for t in targets(plan)]
    for filename, document in texts.items():
        audit.equal(f"single document title {filename}", len(re.findall(r"^# ", document, re.M)), 1)
        anchors = re.findall(r'<a id="([^"]+)"></a>', document)
        audit.equal(f"explicit anchors unique {filename}", len(anchors), len(set(anchors)))
        for part, _, _, _ in PARTS:
            audit.equal(f"one part anchor {filename}/{part}",
                        anchors.count("part-" + part.lower()), 1)
        for target in canonical_ids:
            anchor = "target-" + target.lower().replace(".", "-")
            audit.equal(f"one target anchor {filename}/{target}", anchors.count(anchor), 1)
            audit.equal(f"one target heading {filename}/{target}",
                        len(re.findall(r"^#### " + re.escape(target) + r"\s", document, re.M)), 1)
        local = re.findall(r"\]\(([^)]+)\)", document)
        for link in local:
            if link.startswith("#"):
                audit.check(f"same-document link resolves {filename}/{link}", link[1:] in anchors)
            elif "#" in link and link.split("#", 1)[0] in texts:
                dest, anchor = link.split("#", 1)
                audit.check(f"language link resolves {filename}/{link}",
                            f'<a id="{anchor}"></a>' in texts[dest])
        audit.check(f"no old component-directory links {filename}",
                    not any(link.startswith(("frameworks/", "applications/", "../../")) for link in local))
    audit.check("DOC-01 canonical Painleve numbering clarified in English",
                "now with the canonical prefix P; reports/unification/id_map.json" in texts["README.md"])
    audit.check("DOC-01 current and prior reviews distinguished in English",
                "the current consolidation review is in `reports/unification/review_report.ja.md`" in texts["README.md"])
    audit.check("DOC-01 canonical Painleve numbering clarified in Japanese",
                "44個の旧ローカル番号は、接頭辞Pを付けた正式番号" in texts["README.ja.md"])
    audit.check("DOC-01 prior-review wording no longer called current",
                "Current independent review and repairs are in `reports/reusability/review_report.ja.md`" not in texts["README.md"])
    audit.observation("Every character of all 14 source bodies is covered by the independent permitted-transformation comparison; the source builder is not imported.")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--before", type=Path,
                        help="Expanded baseline; otherwise use sibling before/ or temporarily extract before.zip")
    parser.add_argument("--candidate", type=Path,
                        help="Roadmap root; defaults to the enclosing roadmap for a packaged validator")
    parser.add_argument("--output", type=Path, default=HERE / "validation.rerun.json",
                        help="Write a fresh audit report without replacing the frozen reviewer record")
    parser.add_argument("--body-manifest", type=Path)
    parser.add_argument("--structural-only", action="store_true")
    args = parser.parse_args()
    normalization_file = HERE / "normalization.py"
    spec = importlib.util.spec_from_file_location("unification_normalization", normalization_file)
    normalization = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(normalization)
    audit = Audit()
    result = {}
    baseline_temporary = None
    baseline_origin = None
    try:
        if args.candidate is None:
            working_candidate = HERE / "candidate"
            args.candidate = (working_candidate if (working_candidate / "design/plan.json").is_file()
                              else Path(__file__).resolve().parents[2])
        if args.before is None:
            working_baseline = HERE / "before"
            if (working_baseline / "design/plan.json").is_file():
                args.before = working_baseline
            else:
                archive = HERE / "before.zip"
                expected_members = {"design/plan.json", "design/reuse_registry.json",
                                    "design/reuse_graph.json", "sources.toml",
                                    "README.md", "README.ja.md", "REUSABILITY.md", "REUSABILITY.ja.md"}
                for _, _, directory, _ in PARTS:
                    if directory != ".":
                        for name in ("README.md", "README.ja.md", "plan.json"):
                            expected_members.add(directory + "/" + name)
                with zipfile.ZipFile(archive) as source_zip:
                    members = source_zip.namelist()
                    audit.equal("baseline archive has the exact 23 text sources",
                                sorted(members), sorted(expected_members))
                    if len(members) != 23 or set(members) != expected_members:
                        raise ValueError("The baseline archive must contain exactly the 23 recorded relative text paths.")
                    baseline_temporary = tempfile.TemporaryDirectory(prefix="painleve_one_roadmap_baseline_")
                    args.before = Path(baseline_temporary.name)
                    source_zip.extractall(args.before)
                baseline_origin = {"archive": str(archive.resolve()), "sha256": sha256(archive),
                                   "members": 23, "extraction": "temporary; cleaned after validation"}
        if baseline_origin is None:
            baseline_origin = {"directory": str(args.before.resolve())}
        audit.equal("normalization part map", normalization.PREFIX, PREFIX)
        result = check_structural(audit, args.before, args.candidate, normalization)
        if not args.structural_only:
            manifest_path = args.body_manifest or args.candidate / "reports/unification/content_manifest.json"
            check_bodies(audit, args.before, args.candidate, manifest_path, normalization)
    except Exception as error:
        audit.check("audit completed without exception", False,
                    {"type": type(error).__name__, "message": str(error)})
    failures = [item for item in audit.checks if not item["passed"]]
    report = {
        "schema": "single-roadmap-independent-preservation-review/v1",
        "reviewer": "unify_content_review",
        "generated_at": datetime.now(timezone.utc).isoformat(),
        "scope": "specification preservation and dependency consistency; not theorem verification",
        "structural_only": args.structural_only,
        "baseline": baseline_origin,
        "candidate": str(args.candidate.resolve()) if args.candidate is not None else None,
        "normalization_sha256": sha256(normalization_file),
        "counts": result.get("counts"),
        "check_count": len(audit.checks),
        "failure_count": len(failures),
        "passed": not failures,
        "decision": "pass" if not failures else "needs-fix",
        "failures": failures,
        "observations": audit.observations,
        "checks": audit.checks,
    }
    reviewed = ["README.md", "README.ja.md", "REUSABILITY.md", "REUSABILITY.ja.md",
                "design/plan.json", "design/reuse_registry.json", "design/reuse_graph.json",
                "sources.toml", "reports/unification/id_map.json",
                "reports/unification/content_manifest.json"]
    report["reviewed_files"] = {name: sha256(args.candidate / name) for name in reviewed
                                if (args.candidate / name).is_file()}
    report["validator_sha256"] = sha256(Path(__file__))
    if not args.structural_only:
        report["editorial_review"] = {
            "approved_layout_edits": 46,
            "approved_layout_edits_sha256": APPROVED_LAYOUT_EDITS_SHA256,
            "status_edit_context": "Root confirmed a new user instruction to create and push a draft branch in the user's fork. This reviewer performed no remote action.",
            "closed_findings": [{
                "id": "DOC-01", "severity": "low", "status": "closed" if not failures else "closure-awaits-pass",
                "finding": "The reusable-contract appendix still described original IDs as unchanged and the preceding split-edition review as the current review.",
                "resolution": "Both languages distinguish preserved local numbers from the canonical P prefix; the English text distinguishes the old mathematical review from the current consolidation review. Exact address map retained.",
            }],
            "scope": "All original mathematical target fields and complete source bodies retained modulo approved layout and address transformations; no new theorem-proof claim.",
        }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(report, ensure_ascii=False, indent=2, default=str) + "\n",
                           encoding="utf-8")
    print(json.dumps({"checks": len(audit.checks), "failures": len(failures),
                      "passed": not failures, "report": str(args.output),
                      "first_failures": failures[:8]}, ensure_ascii=False, default=str))
    if baseline_temporary is not None:
        baseline_temporary.cleanup()
    return 0 if not failures else 1


if __name__ == "__main__":
    sys.exit(main())
