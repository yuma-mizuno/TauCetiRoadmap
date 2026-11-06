"""Audit the scope reduction against the preceding committed specification.

Historical receipts remain tied to their original inputs. This checks the
authorized deletions, the exact edits to surviving targets and unchanged TeX
inside surviving target bodies. It does not establish mathematical truth.
"""
from __future__ import annotations

import hashlib
import json
import re
import subprocess

BASELINE = "8eaf4ed294dfeee63b0fe5603331a185f0379a70"
REMOVED = {"0.9"} | {f"2.{i}" for i in range(7, 11)} | {
    f"{layer}.{i}" for layer in (8, 9) for i in range(1, 9)}
FILES = {"README.md", "README.ja.md", "Suggested.lean", "metadata.toml",
         "sources.toml", "design/plan.json", "design/dependencies.json",
         "design/reuse_graph.json", "design/reuse_registry.json"}


def scope_inputs(root, math_spans):
    record = json.loads((root / "reports/submission/scope_revision.json").read_text(encoding="utf-8"))
    checks, previous = [], {}

    def check(name, ok):
        checks.append({"check": "scope: " + name, "passed": bool(ok)})

    def sha(text):
        return hashlib.sha256(text.encode("utf-8")).hexdigest()

    check("pinned preceding commit", record["baseline_commit"] == BASELINE)
    check("exact file scope", set(record["files"]) == FILES)
    check("authorized target deletions", set(record["removed_target_ids"]) == REMOVED)
    for name in sorted(FILES):
        previous[name] = subprocess.check_output(
            ["git", "show", BASELINE + ":TauCetiRoadmap/PainleveEquationsAndFunctions/" + name],
            cwd=root.parents[1]).decode("utf-8")
        current = (root / name).read_text(encoding="utf-8")
        hashes = record["files"][name]
        check(name + " baseline fingerprint", sha(previous[name]) == hashes["before_sha256"])
        check(name + " current fingerprint", sha(current) == hashes["after_sha256"])

    def targets(plan):
        return {t["id"]: t for layer in plan["layers"] for t in layer["targets"]}

    before = targets(json.loads(previous["design/plan.json"]))
    plan = json.loads((root / "design/plan.json").read_text(encoding="utf-8"))
    after = targets(plan)
    check("57 surviving target identities", set(after) == set(before) - REMOVED and len(after) == 57)
    check("current counts", record["retained_counts"] == plan["counts"])
    declared = record["retained_target_edits"]
    allowed_paths = {"1.6": [["statement"]], "2.6": [["tests", 3, "statement"]],
                     "3.7": [["statement"]], "3.8": [["statement"]], "7.3": [["statement"]]}
    check("complete surviving-target edit inventory",
          set(declared) == {tid for tid in after if after[tid] != before[tid]}
          and {tid: [edit["path"] for edit in rows] for tid, rows in declared.items()} == allowed_paths)
    for tid, target in after.items():
        expected = json.loads(json.dumps(before[tid]))
        for edit in declared.get(tid, []):
            node = expected
            for key in edit["path"][:-1]:
                node = node[key]
            key = edit["path"][-1]
            check(tid + " declared preceding field " + str(edit["path"]), node[key] == edit["before"])
            node[key] = edit["after"]
        check(tid + " exact surviving fields", expected == target)
        check(tid + " general definitions and hypotheses retained",
              all(target.get(k) == before[tid].get(k) for k in (
                  "kind", "name", "hypotheses", "hypotheses_ja", "api", "prerequisites")))
    # Each retained target's formulas are compared locally, so removing an entire
    # development cannot hide changes to formulas in the retained development.
    def bodies(text):
        result = {}
        for match in re.finditer(r'^<a id="target-(\d+)-(\d+)"></a>\s*\n### [^\n]*\n', text, re.M):
            tail = text[match.end():]
            boundary = re.search(r'^(?:<a id="(?:target-|layer-)|#{1,3} )', tail, re.M)
            result[match[1] + "." + match[2]] = tail[:boundary.start()] if boundary else tail
        return result

    for name in ("README.md", "README.ja.md"):
        old_bodies = bodies(previous[name])
        text = (root / name).read_text(encoding="utf-8")
        new_bodies = bodies(text)
        check(name + " exact target scope", set(new_bodies) == set(after))
        for tid in after:
            payload = lambda s: [(x["kind"], x["tex"]) for x in math_spans(s)]
            check(name + " " + tid + " unchanged formulas",
                  payload(old_bodies[tid]) == payload(new_bodies.get(tid, "")))
        check(name + " no deleted target anchors",
              all('id="target-' + tid.replace(".", "-") + '"' not in text for tid in REMOVED))
    for name in ("Suggested.lean", "metadata.toml"):
        check(name + " unchanged", (root / name).read_text(encoding="utf-8") == previous[name])
    return previous, checks
