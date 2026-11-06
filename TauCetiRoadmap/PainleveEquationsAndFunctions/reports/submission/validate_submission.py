#!/usr/bin/env python3
"""Check the roadmap's documents, dependency graph, and preservation manifest.

These are consistency and content-preservation checks, not mathematical proofs.
Run after dependency checkout. --baseline independently compares the original
source plan; --previous-plan independently compares the published plan before
the numerical regrouping. Historical field hashes retain their original IDs.
"""
from __future__ import annotations

import argparse
import hashlib
import importlib.util
import json
import re
import sys
import tomllib
from collections import Counter
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
REPO = ROOT.parents[1]
CORE_FIELDS = ("kind", "name", "title", "statement", "hypotheses", "api", "tests")
PARTS = {
    "nonlinear_connections": "framework",
    "connection_moduli": "framework",
    "analytic_theory": "framework",
    "algebraic_confluence": "framework",
    "painleve": "application",
    "five_point_application": "application",
}
LEGACY_PARTS = dict(zip("NMACPG", PARTS))
CORE_FILES = (
    "README.md", "README.ja.md", "metadata.toml", "sources.toml",
    "design/plan.json", "design/dependencies.json", "design/reuse_graph.json",
    "design/reuse_registry.json",
)


def digest(value):
    return hashlib.sha256(
        json.dumps(value, ensure_ascii=False, sort_keys=True, separators=(",", ":")).encode()
    ).hexdigest()


def targets(plan):
    return [t for layer in plan["layers"] for t in layer["targets"]]


def file_digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def target_block(text, tid):
    anchor = '<a id="target-' + tid.lower().replace(".", "-") + '"></a>'
    start = text.find(anchor)
    if start < 0:
        return ""
    rest = text[start + len(anchor):]
    # The target's own heading is now level three. Skip it before looking for
    # the next target, thematic subsection, or numbered layer.
    heading = re.match(r'\s*### ' + re.escape(tid) + r'(?=\s|$)[^\n]*(?:\n|$)', rest)
    if not heading:
        return ""
    content_start = start + len(anchor) + heading.end()
    boundary = re.search(r'^(?:<a id="(?:target-|layer-|part-)|#{1,3} )',
                         text[content_start:], re.M)
    end = content_start + boundary.start() if boundary else len(text)
    return text[start:end]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--baseline", type=Path, help="source design/plan.json")
    parser.add_argument("--previous-plan", type=Path,
                        help="published design/plan.json before numerical regrouping")
    parser.add_argument("--output", type=Path, help="write the JSON result")
    parser.add_argument("--packages-dir", type=Path, default=REPO / ".lake/packages",
                        help="existing pinned dependency checkouts (no build or download)")
    args = parser.parse_args()
    checks = []

    def check(category, name, ok, detail=None):
        row = {"category": category, "check": name, "passed": bool(ok)}
        if detail is not None:
            row["detail"] = detail
        checks.append(row)

    def read_json(name):
        return json.loads((ROOT / name).read_text())

    plan = read_json("design/plan.json")
    ts = targets(plan)
    by_id = {t["id"]: t for t in ts}
    ids = set(by_id)
    # Preserve the reviewed numbering snapshot. A presentation-only revision
    # supplies a reversible patch, exact old/new file hashes, and independently
    # checked equality of prose and ordered TeX payloads. All mathematical and
    # document-consistency checks below still inspect the current plan.
    rendering_path = ROOT / "reports/submission/math_rendering.json"
    rendering_report = None
    restored_inputs = {}
    preformat_by_id = by_id
    if rendering_path.is_file():
        spec = importlib.util.spec_from_file_location(
            "painleve_math_rendering_check", Path(__file__).with_name("check_math_rendering.py"))
        module = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(module)
        rendering_report, restored_inputs = module.audit_manifest(ROOT)
        for item in rendering_report["checks"]:
            check("math_rendering", item["check"], item["passed"], item.get("detail"))
        if "design/plan.json" in restored_inputs:
            preformat_by_id = {t["id"]: t for t in targets(
                json.loads(restored_inputs["design/plan.json"]))}
    graph = read_json("design/reuse_graph.json")
    registry = read_json("design/reuse_registry.json")
    contracts = read_json("design/dependencies.json")["contracts"]
    by_dep = {d["id"]: d for d in contracts}
    docs = {lang: (ROOT / name).read_text() for lang, name in
            [("en", "README.md"), ("ja", "README.ja.md")]}
    check("targets", "unique IDs", len(ids) == len(ts))
    by_part = {p["id"]: p for p in plan["parts"]}
    check("targets", "six semantic parts", len(plan["parts"]) == len(PARTS)
          and set(by_part) == set(PARTS))
    for part in plan["parts"]:
        check("targets", part["id"] + " scope role",
              part["scope_role"] == PARTS.get(part["id"]))
    check("targets", "unique dependency contract IDs", len(by_dep) == len(contracts))
    expected_counts = {
        "parts": len(plan["parts"]),
        "general_parts": sum(p["scope_role"] == "framework" for p in plan["parts"]),
        "layers": len(plan["layers"]),
        "targets": len(ts),
        "general_targets": sum(t["scope_role"] == "framework" for t in ts),
        "api_laws": sum(len(t["api"]) for t in ts),
        "diagnostics": sum(len(t["tests"]) for t in ts),
        "internal_edges": sum(r.startswith("target:") for t in ts for r in t["prerequisites"]),
        "supporting_constructions": sum(len(t.get("supporting_constructions", [])) for t in ts),
    }
    check("targets", "derived counts", plan["counts"] == expected_counts, expected_counts)
    layer_keys = [layer["key"] for layer in plan["layers"]]
    check("layers", "ten consecutive numerical layers", layer_keys == [str(i) for i in range(10)])
    check("targets", "78 mathematical targets", len(ts) == 78)
    for layer in plan["layers"]:
        key = layer["key"]
        members = layer["targets"]
        roles = {t["scope_role"] for t in members}
        role = next(iter(roles)) if len(roles) == 1 else "mixed"
        check("layers", key + " sequential target IDs",
              [t["id"] for t in members] == [key + "." + str(i)
                                               for i in range(1, len(members) + 1)])
        check("layers", key + " semantic parts",
              len(layer.get("parts", [])) == len({t["part"] for t in members})
              and set(layer.get("parts", [])) == {t["part"] for t in members})
        check("layers", key + " scope role", layer.get("scope_role") == role)
        for lang, text in docs.items():
            if lang == "en":
                heading = "## Layer " + key + ": " + layer["title"]
            else:
                heading = "## レイヤー" + key + "：" + layer.get("title_ja", "")
            check("documents", key + " " + lang + " layer title",
                  len(re.findall(r"^" + re.escape(heading) + r"$", text, re.M)) == 1)
    for lang, text in docs.items():
        pattern = r"^## Layer (\d+):" if lang == "en" else r"^## レイヤー(\d+)："
        check("documents", lang + " numerical layer order",
              re.findall(pattern, text, re.M) == layer_keys)

    adjacency = {}
    positions = {t["id"]: i for i, t in enumerate(ts)}
    for t in ts:
        tid = t["id"]
        blocks = {lang: target_block(text, tid) for lang, text in docs.items()}
        check("targets", tid + " address", bool(re.fullmatch(r"(?:0|[1-9]\d*)\.[1-9]\d*", tid)))
        check("targets", tid + " semantic part", t["part"] in by_part
              and t["scope_role"] == by_part[t["part"]]["scope_role"])
        check("targets", tid + " local owner", t["owner"] == "PainleveEquationsAndFunctions:" + tid)
        refs = t["prerequisites"]
        check("dependencies", tid + " no duplicate prerequisites", len(refs) == len(set(refs)))
        for ref in refs:
            valid = (ref.startswith("target:") and ref[7:] in ids) or (
                ref.startswith("dependency:") and ref[11:] in by_dep)
            check("dependencies", tid + " -> " + ref, valid)
        adjacency[tid] = {r[7:] for r in refs if r.startswith("target:") and r[7:] in ids}
        check("dependencies", tid + " prerequisites precede target",
              all(positions[dep] < positions[tid] for dep in adjacency[tid]))
        for field in ["statement", "readme_needs"]:
            check("documents", tid + " English " + field + " in owning target", t[field] in blocks["en"])
        for i, hyp in enumerate(t["hypotheses"], 1):
            check("documents", tid + " English hypothesis " + str(i) + " in owning target", hyp in blocks["en"])
        for i, hyp in enumerate(t.get("hypotheses_ja", []), 1):
            check("documents", tid + " Japanese hypothesis " + str(i) + " in owning target", hyp in blocks["ja"])
        for field in ["api", "tests"]:
            item_ids = [x["id"] for x in t[field]]
            check("targets", tid + " addressed " + field,
                  item_ids == [f"{tid}.{field}.{i}" for i in range(1, len(item_ids) + 1)])
            for i, item in enumerate(t[field], 1):
                check("documents", tid + " English " + field + " " + str(i),
                      item["statement"] in blocks["en"])
                if field == "tests":
                    check("targets", tid + " diagnostic kind " + str(i),
                          bool(item.get("kind")) and "role" not in item)
        check("documents", tid + " Japanese Needs", t["readme_needs_ja"] in blocks["ja"])
        for item in t.get("supporting_constructions", []):
            check("documents", item["id"] + " English", item["statement"] in blocks["en"])
            check("documents", item["id"] + " Japanese", item["statement_ja"] in blocks["ja"])
        for lang, text in docs.items():
            anchor = '<a id="target-' + tid.lower().replace(".", "-") + '"></a>'
            check("documents", tid + " " + lang + " unique anchor", text.count(anchor) == 1)
            headings = re.findall(r"^### " + re.escape(tid) + r"(?:\s|$)", text, re.M)
            check("documents", tid + " " + lang + " unique heading", len(headings) == 1)

    visiting, done, cycles = set(), set(), []

    def visit(tid):
        if tid in visiting:
            cycles.append(tid)
            return
        if tid in done:
            return
        visiting.add(tid)
        for dep in adjacency[tid]:
            visit(dep)
        visiting.remove(tid)
        done.add(tid)

    for tid in sorted(ids):
        visit(tid)
    check("dependencies", "acyclic internal graph", not cycles, cycles)

    def closure(tid):
        out, pending = set(), list(adjacency[tid])
        while pending:
            dep = pending.pop()
            if dep not in out:
                out.add(dep)
                pending.extend(adjacency[dep])
        return out

    for tid in sorted(ids):
        inherited = closure(tid)
        t = by_id[tid]
        if t["scope_role"] == "framework":
            check("boundaries", tid + " general independence",
                  all(by_id[x]["scope_role"] == "framework" for x in inherited))
        if t["part"] == "five_point_application":
            check("boundaries", tid + " independent consumer",
                  not any(by_id[x]["part"] == "painleve" for x in inherited))
        if t["part"] == "painleve" and tid.partition(".")[0] in {"3", "4", "5", "6"}:
            check("boundaries", tid + " before coordinate formulas",
                  not any(x.startswith("7.") for x in inherited))

    edges = {(t, d) for t, ds in adjacency.items() for d in ds}
    check("registries", "graph nodes", len(graph["nodes"]) == len(ts) and
          {n["id"]: n for n in graph["nodes"]} == {
              t["id"]: {"id": t["id"], "part": t["part"], "scope_role": t["scope_role"]} for t in ts})
    graph_edges = [(e["from"], e["to"]) for e in graph["edges"]]
    check("registries", "graph edges", set(graph_edges) == edges and len(graph_edges) == len(edges))
    check("registries", "semantic parts",
          len(registry["parts"]) == len(by_part)
          and {p["id"] for p in registry["parts"]} == set(by_part))
    for part in registry["parts"]:
        check("registries", part["id"] + " targets", part["target_ids"] == [
            t["id"] for t in ts if t["part"] == part["id"]])

    supplier_paths = set()
    for d in contracts:
        consumers = [t["id"] for t in ts if "dependency:" + d["id"] in t["prerequisites"]]
        check("dependencies", d["id"] + " consumers",
              len(d["consumers"]) == len(consumers) and set(d["consumers"]) == set(consumers))
        check("dependencies", d["id"] + " scope", all(d.get(k) for k in
              ["paths", "sections", "supplied", "owned_here", "supplied_ja"]))
        for path in d["paths"]:
            supplier_paths.add(path)
            prefix = REPO
            if path.startswith("Mathlib/"):
                prefix = args.packages_dir / "mathlib"
            elif path.startswith("TauCeti/"):
                prefix = args.packages_dir / "TauCeti"
            check("supplier_files", path, (prefix / path).is_file())

    for lang, text in docs.items():
        explicit_anchors = re.findall(r'<a id="([^"]+)"', text)
        check("documents", lang + " unique explicit anchors",
              len(explicit_anchors) == len(set(explicit_anchors)))
        for ref in sorted(set(re.findall(r"\btarget:([A-Za-z0-9]+\.\d+)", text))):
            check("documents", lang + " target reference " + ref, ref in ids)
        for label, link in re.findall(r"\[([^\]\n]+)\]\(([^)\s]+)\)", text):
            if re.match(r"(?:https?://|mailto:)", link):
                continue
            filename, _, fragment = link.partition("#")
            if filename:
                check("links", lang + " " + link, (ROOT / filename).is_file())
            elif fragment:
                check("links", lang + " " + link, fragment in explicit_anchors)
        for pattern in [r"\boptional\b", r"\bfork[- ]only\b", r"\bfork[- ]draft\b",
                        r"旧版からの統合", r"この改訂では", r"レビュー経緯",
                        r"FormalConnectionsOpers", r"ComplexComparisonPartII",
                        r"AlgebraicModuliForArithmeticGeometry", r"PadicDifferential"]:
            check("timeless_prose", lang + " absence: " + pattern,
                  re.search(pattern, text, re.I) is None)

    metadata = tomllib.loads((ROOT / "metadata.toml").read_text())
    check("metadata", "math.AG topic", metadata.get("topic") == "math.AG")
    source_records = tomllib.loads((ROOT / "sources.toml").read_text())["source"]
    source_ids = {s["id"] for s in source_records}
    check("sources", "unique source IDs", len(source_ids) == len(source_records))
    for source in source_records:
        check("sources", source["id"] + " locator", bool(source.get("locator")))
        check("sources", source["id"] + " target addresses",
              set(source.get("cited_for", [])) <= ids)
    for part in plan["parts"]:
        for key in part["contracts"].get("source_keys", []):
            check("sources", part["id"] + " " + key, key in source_ids)
    for t in ts:
        for construction in t.get("supporting_constructions", []):
            for key in construction.get("source_keys", []):
                check("sources", construction["id"] + " " + key, key in source_ids)

    numbering_path = ROOT / "reports/submission/numbering.json"
    check("numbering", "numbering manifest exists", numbering_path.is_file())
    numbering = json.loads(numbering_path.read_text()) if numbering_path.is_file() else {}
    target_map = numbering.get("target_map", {})
    records = numbering.get("targets", [])
    previous_records = {r["before_id"]: r for r in records}
    check("numbering", "78-target bijection", len(target_map) == 78
          and len(set(target_map.values())) == 78 and set(target_map.values()) == ids)
    check("numbering", "semantic part map", numbering.get("parts_map") == LEGACY_PARTS)
    check("numbering", "one record per previous target", len(records) == len(target_map)
          and set(previous_records) == set(target_map))
    check("numbering", "current counts", numbering.get("current_counts") == expected_counts)
    check("numbering", "previous published commit",
          numbering.get("previous_commit") == "089ae2b8698b5e01523978ba6797e8891dc0a0dd")
    check("numbering", "previous plan fingerprint",
          bool(re.fullmatch(r"[0-9a-f]{64}", numbering.get("previous_plan_sha256", ""))))

    before_edges = [tuple(e) for e in numbering.get("before_internal_edges", [])]
    after_edges = [tuple(e) for e in numbering.get("after_internal_edges", [])]
    check("numbering", "previous edges resolve",
          all(a in target_map and b in target_map for a, b in before_edges))
    mapped_edges = {(target_map[a], target_map[b]) for a, b in before_edges
                    if a in target_map and b in target_map}
    check("numbering", "exact edge bijection",
          len(before_edges) == len(set(before_edges)) == len(after_edges) == len(set(after_edges))
          and mapped_edges == set(after_edges) == edges)
    for old_id, row in previous_records.items():
        new_id = row["after_id"]
        check("numbering", old_id + " target address", target_map.get(old_id) == new_id)
        t = by_id.get(new_id)
        recorded_t = preformat_by_id.get(new_id)
        check("numbering", new_id + " recorded target fingerprint", t is not None
              and recorded_t is not None and digest(recorded_t) == row["after_sha256"])
        check("numbering", old_id + " previous target fingerprint",
              bool(re.fullmatch(r"[0-9a-f]{64}", row.get("before_sha256", ""))))
        check("numbering", new_id + " complete core field fingerprints",
              set(row.get("field_sha256", {})) == set(CORE_FIELDS))
        for field in CORE_FIELDS:
            hashes = row.get("field_sha256", {}).get(field, {})
            check("numbering", new_id + " recorded " + field,
                  t is not None and recorded_t is not None
                  and digest(recorded_t.get(field)) == hashes.get("after"))
    recorded_inputs = numbering.get("inputs_sha256", {})
    check("numbering", "core input fingerprints recorded", set(CORE_FILES) <= set(recorded_inputs))
    for name, recorded_hash in recorded_inputs.items():
        path = ROOT / name
        actual_hash = (hashlib.sha256(restored_inputs[name].encode("utf-8")).hexdigest()
                       if name in restored_inputs else file_digest(path) if path.is_file() else None)
        check("numbering", name + " exact recorded input fingerprint",
              actual_hash == recorded_hash,
              {"presentation_bridge": name in restored_inputs})

    previous_checked = False
    if args.previous_plan:
        previous = json.loads(args.previous_plan.read_text())
        previous_checked = True
        previous_ts = {t["id"]: t for t in targets(previous)}
        check("previous_source", "source bytes match pinned previous plan",
              file_digest(args.previous_plan) == numbering.get("previous_plan_sha256"))
        check("previous_source", "previous target identities", set(previous_ts) == set(target_map))
        actual_previous_edges = [(t["id"], r[7:]) for t in targets(previous)
                                 for r in t["prerequisites"] if r.startswith("target:")]
        check("previous_source", "exact previous prerequisite edges",
              len(actual_previous_edges) == len(before_edges)
              and set(actual_previous_edges) == set(before_edges))
        for old_id, row in previous_records.items():
            old_t = previous_ts.get(old_id)
            new_t = by_id.get(row["after_id"])
            check("previous_source", old_id + " target fingerprint",
                  old_t is not None and digest(old_t) == row["before_sha256"])
            if old_t is None or new_t is None:
                continue
            for field in CORE_FIELDS:
                check("previous_source", old_id + " previous " + field,
                      digest(old_t.get(field)) == row["field_sha256"][field]["before"])
            check("previous_source", old_id + " semantic part and role preserved",
                  new_t["part"] == LEGACY_PARTS.get(old_t["part"])
                  and new_t["scope_role"] == old_t["scope_role"])
            for field in ["api", "tests"]:
                check("previous_source", old_id + " exact " + field + " names",
                      [x["name"] for x in old_t[field]] == [x["name"] for x in
                          preformat_by_id[row["after_id"]][field]])
            old_support = [x["id"] for x in old_t.get("supporting_constructions", [])]
            new_support = [x["id"] for x in new_t.get("supporting_constructions", [])]
            check("previous_source", old_id + " supporting construction prefixes",
                  all(s.startswith(old_id + ".") for s in old_support))
            check("previous_source", old_id + " exact supporting construction IDs",
                  [row["after_id"] + s[len(old_id):] for s in old_support] == new_support)
            mapped_prerequisites = ["target:" + target_map.get(r[7:], "<missing>")
                                    if r.startswith("target:") else r
                                    for r in old_t["prerequisites"]]
            check("previous_source", old_id + " exact mapped prerequisites",
                  mapped_prerequisites == new_t["prerequisites"])

    manifest_path = ROOT / "reports/submission/preservation.json"
    check("preservation", "manifest exists", manifest_path.is_file())
    baseline_checked = False
    if manifest_path.is_file():
        manifest = json.loads(manifest_path.read_text())
        baseline_ids = {t["id"] for t in manifest["baseline_targets"]}
        check("preservation", "all original target identities retained through numbering",
              baseline_ids <= set(target_map))
        check("preservation", "only declared additions",
              set(target_map) - baseline_ids == set(manifest["added_targets"]))
        base_edges = {tuple(e) for e in manifest["baseline_internal_edges"]}
        mapped_base_edges = {(target_map[a], target_map[b]) for a, b in base_edges
                             if a in target_map and b in target_map}
        check("preservation", "all original internal prerequisites retained",
              len(mapped_base_edges) == len(base_edges) and mapped_base_edges <= edges)
        allowed = {(v["target"], v["field"]): v for v in manifest["revised_fields"]}
        for base_t in manifest["baseline_targets"]:
            tid = base_t["id"]
            t = by_id.get(target_map.get(tid))
            row = previous_records.get(tid, {})
            for field in CORE_FIELDS:
                # Link the immutable original-source manifest to the published
                # pre-numbering field, then check the new field separately above.
                # Reversing numbers in prose would corrupt literature locators.
                previous_hash = row.get("field_sha256", {}).get(field, {}).get("before")
                old = base_t["field_sha256"][field]
                if previous_hash == old:
                    check("preservation", tid + " unchanged " + field, True)
                else:
                    revision = allowed.get((tid, field))
                    check("preservation", tid + " declared revision " + field,
                          revision is not None and revision["before_sha256"] == old
                          and revision["after_sha256"] == previous_hash and bool(revision["reason"]))
            for field in ["api", "tests"]:
                recorded_t = preformat_by_id.get(target_map.get(tid))
                names = {x["name"] for x in recorded_t[field]} if recorded_t is not None else set()
                check("preservation", tid + " original " + field + " retained",
                      set(base_t[field + "_names"]) <= names)
        if args.baseline:
            base = json.loads(args.baseline.read_text())
            baseline_checked = True
            check("baseline_source", "source bytes match pinned source manifest",
                  file_digest(args.baseline) == manifest["baseline_plan_sha256"])
            bt = {t["id"]: t for t in targets(base)}
            check("baseline_source", "baseline target IDs", set(bt) == baseline_ids)
            for item in manifest["baseline_targets"]:
                tid = item["id"]
                for field in CORE_FIELDS:
                    check("baseline_source", tid + " " + field,
                          tid in bt and digest(bt[tid].get(field)) == item["field_sha256"][field])

    failures = [c for c in checks if not c["passed"]]
    result = {
        "meaning": "Mechanical consistency and content preservation; not proof of mathematical truth or human approval.",
        "passed": not failures,
        "checks": len(checks),
        "passed_checks": len(checks) - len(failures),
        "failed_checks": len(failures),
        "baseline_source_independently_compared": baseline_checked,
        "previous_plan_independently_compared": previous_checked,
        "counts": expected_counts,
        "external_contracts": len(contracts),
        "distinct_supplier_files": len(supplier_paths),
        "source_records": len(source_records),
        "categories": dict(Counter(c["category"] for c in checks)),
        "inputs_sha256": {p: file_digest(ROOT / p) for p in CORE_FILES},
        "numbering_manifest_sha256": file_digest(numbering_path) if numbering_path.is_file() else None,
        "math_rendering_manifest_sha256": file_digest(rendering_path) if rendering_path.is_file() else None,
        "presentation_bridge_used": rendering_report is not None,
        "math_rendering_checks": rendering_report["check_count"] if rendering_report else 0,
        "organization_revision_checked": bool(rendering_report and
            rendering_report.get("organization_baseline_used")),
        "failures": failures,
    }
    encoded = json.dumps(result, ensure_ascii=False, indent=2) + "\n"
    if args.output:
        args.output.write_text(encoded)
    print(encoded, end="")
    return 0 if not failures else 1


if __name__ == "__main__":
    sys.exit(main())
