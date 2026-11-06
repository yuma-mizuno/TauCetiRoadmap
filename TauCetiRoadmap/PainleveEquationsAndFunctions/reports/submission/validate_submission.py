#!/usr/bin/env python3
"""Check the roadmap's documents, dependency graph, and preservation manifest.

These are consistency and content-preservation checks, not mathematical proofs.
Run after `lake update`/dependency checkout. An optional --baseline points to the
source roadmap's design/plan.json for an independent comparison with that file.
"""
from __future__ import annotations

import argparse
import hashlib
import json
import re
import sys
import tomllib
from collections import Counter
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
REPO = ROOT.parents[1]
CORE_FIELDS = ("kind", "name", "title", "statement", "hypotheses", "api", "tests")


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
    start = text.index(anchor)
    rest = text[start + len(anchor):]
    boundary = re.search(r'^(?:<a id="(?:target-|part-)|#{1,3} )', rest, re.M)
    end = start + len(anchor) + boundary.start() if boundary else len(text)
    return text[start:end]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--baseline", type=Path, help="source design/plan.json")
    parser.add_argument("--output", type=Path, help="write the JSON result")
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
    graph = read_json("design/reuse_graph.json")
    registry = read_json("design/reuse_registry.json")
    contracts = read_json("design/dependencies.json")["contracts"]
    by_dep = {d["id"]: d for d in contracts}
    docs = {lang: (ROOT / name).read_text() for lang, name in
            [("en", "README.md"), ("ja", "README.ja.md")]}
    check("targets", "unique IDs", len(ids) == len(ts))
    check("targets", "six parts", {p["id"] for p in plan["parts"]} == set("NMACPG"))
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
    adjacency = {}
    for t in ts:
        tid = t["id"]
        blocks = {lang: target_block(text, tid) for lang, text in docs.items()}
        check("targets", tid + " address", bool(re.fullmatch(r"[NMACPG]\d+\.\d+", tid)))
        check("targets", tid + " part", t["part"] == tid[0])
        check("targets", tid + " local owner", t["owner"] == "PainleveEquationsAndFunctions:" + tid)
        refs = t["prerequisites"]
        check("dependencies", tid + " no duplicate prerequisites", len(refs) == len(set(refs)))
        for ref in refs:
            valid = (ref.startswith("target:") and ref[7:] in ids) or (
                ref.startswith("dependency:") and ref[11:] in by_dep)
            check("dependencies", tid + " -> " + ref, valid)
        adjacency[tid] = {r[7:] for r in refs if r.startswith("target:") and r[7:] in ids}
        for field in ["statement", "readme_needs"]:
            check("documents", tid + " English " + field + " in owning target", t[field] in blocks["en"])
        for i, hyp in enumerate(t["hypotheses"], 1):
            check("documents", tid + " English hypothesis " + str(i) + " in owning target", hyp in blocks["en"])
        for i, hyp in enumerate(t.get("hypotheses_ja", []), 1):
            check("documents", tid + " Japanese hypothesis " + str(i) + " in owning target", hyp in blocks["ja"])
        for field in ["api", "tests"]:
            names = [x["name"] for x in t[field]]
            check("targets", tid + " unique " + field, len(names) == len(set(names)))
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
            headings = re.findall(r"^#### " + re.escape(tid) + r"(?:\s|$)", text, re.M)
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
        if tid[0] in "NMAC":
            check("boundaries", tid + " general independence", not any(x[0] in "PG" for x in inherited))
        if tid[0] == "G":
            check("boundaries", tid + " independent consumer", not any(x[0] == "P" for x in inherited))
        if tid[0] == "P" and int(tid[1:].split(".")[0]) <= 8:
            check("boundaries", tid + " before coordinate formulas", not any(x.startswith("P9.") for x in inherited))

    edges = {(t, d) for t, ds in adjacency.items() for d in ds}
    check("registries", "graph nodes", len(graph["nodes"]) == len(ts) and
          {n["id"]: n for n in graph["nodes"]} == {
              t["id"]: {"id": t["id"], "part": t["part"], "scope_role": t["scope_role"]} for t in ts})
    graph_edges = [(e["from"], e["to"]) for e in graph["edges"]]
    check("registries", "graph edges", set(graph_edges) == edges and len(graph_edges) == len(edges))
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
                prefix /= ".lake/packages/mathlib"
            elif path.startswith("TauCeti/"):
                prefix /= ".lake/packages/TauCeti"
            check("supplier_files", path, (prefix / path).is_file())

    for lang, text in docs.items():
        explicit_anchors = re.findall(r'<a id="([^"]+)"', text)
        check("documents", lang + " unique explicit anchors",
              len(explicit_anchors) == len(set(explicit_anchors)))
        for ref in sorted(set(re.findall(r"\btarget:([NMACPG]\d+\.\d+)", text))):
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

    manifest_path = ROOT / "reports/submission/preservation.json"
    check("preservation", "manifest exists", manifest_path.is_file())
    baseline_checked = False
    if manifest_path.is_file():
        manifest = json.loads(manifest_path.read_text())
        baseline_ids = {t["id"] for t in manifest["baseline_targets"]}
        check("preservation", "all original target IDs retained", baseline_ids <= ids)
        check("preservation", "only declared additions", ids - baseline_ids == set(manifest["added_targets"]))
        base_edges = {tuple(e) for e in manifest["baseline_internal_edges"]}
        check("preservation", "all original internal prerequisites retained", base_edges <= edges)
        allowed = {(v["target"], v["field"]): v for v in manifest["revised_fields"]}
        for base_t in manifest["baseline_targets"]:
            tid = base_t["id"]
            t = by_id[tid]
            for field in CORE_FIELDS:
                current = digest(t.get(field))
                old = base_t["field_sha256"][field]
                if current == old:
                    check("preservation", tid + " unchanged " + field, True)
                else:
                    revision = allowed.get((tid, field))
                    check("preservation", tid + " declared revision " + field,
                          revision is not None and revision["before_sha256"] == old
                          and revision["after_sha256"] == current and bool(revision["reason"]))
            for field in ["api", "tests"]:
                names = {x["name"] for x in t[field]}
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
                          digest(bt[tid].get(field)) == item["field_sha256"][field])

    failures = [c for c in checks if not c["passed"]]
    result = {
        "meaning": "Mechanical consistency and content preservation; not proof of mathematical truth or human approval.",
        "passed": not failures,
        "checks": len(checks),
        "passed_checks": len(checks) - len(failures),
        "failed_checks": len(failures),
        "baseline_source_independently_compared": baseline_checked,
        "counts": expected_counts,
        "external_contracts": len(contracts),
        "distinct_supplier_files": len(supplier_paths),
        "source_records": len(source_records),
        "categories": dict(Counter(c["category"] for c in checks)),
        "inputs_sha256": {p: file_digest(ROOT / p) for p in
                          ["README.md", "README.ja.md", "metadata.toml", "sources.toml",
                           "design/plan.json", "design/dependencies.json", "design/reuse_graph.json",
                           "design/reuse_registry.json"]},
        "failures": failures,
    }
    encoded = json.dumps(result, ensure_ascii=False, indent=2) + "\n"
    if args.output:
        args.output.write_text(encoded)
    print(encoded, end="")
    return 0 if not failures else 1


if __name__ == "__main__":
    sys.exit(main())
