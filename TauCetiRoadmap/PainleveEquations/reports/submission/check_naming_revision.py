"""Check the directory/identifier rename against its committed predecessor."""
import hashlib
import json
import subprocess

BASELINE = "f05568ae46e28030502b460d64a7b95e760fafc0"
OLD = "PainleveEquationsAndFunctions"
NEW = "PainleveEquations"
FILES = {"README.md", "README.ja.md", "Suggested.lean", "metadata.toml",
         "sources.toml", "design/plan.json", "design/dependencies.json",
         "design/reuse_graph.json", "design/reuse_registry.json"}


def naming_inputs(root):
    record = json.loads((root / "reports/submission/naming_revision.json").read_text(encoding="utf-8"))
    checks, previous = [], {}

    def check(name, ok):
        checks.append({"check": "naming: " + name, "passed": bool(ok)})

    sha = lambda text: hashlib.sha256(text.encode("utf-8")).hexdigest()
    check("pinned preceding commit", record["baseline_commit"] == BASELINE)
    check("exact specification files", set(record["files"]) == FILES)
    check("new directory and removed old directory", root.name == NEW and not (root.parent / OLD).exists())
    for name in sorted(FILES):
        previous[name] = subprocess.check_output(
            ["git", "show", BASELINE + ":TauCetiRoadmap/" + OLD + "/" + name],
            cwd=root.parents[1]).decode("utf-8")
        current = (root / name).read_text(encoding="utf-8")
        hashes = record["files"][name]
        check(name + " preceding fingerprint", sha(previous[name]) == hashes["before_sha256"])
        check(name + " current fingerprint", sha(current) == hashes["after_sha256"])
        check(name + " identifier substitution only", current == previous[name].replace(OLD, NEW))
    return previous, checks
