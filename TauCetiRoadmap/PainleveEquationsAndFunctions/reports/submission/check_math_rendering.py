#!/usr/bin/env python3
"""Check a reversible, formula-preserving GitHub math presentation change.

The standard-library checks reconstruct the reviewed input exactly and compare
ordered math payloads and non-math text, permitting only the three explicit
operator-name expansions below. --pandoc independently checks the GFM syntax
tree. Neither test claims that a remote GitHub page was visually checked.
"""
from __future__ import annotations

import argparse
import hashlib
import json
import re
import subprocess
import sys
from collections import Counter
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
TICK = chr(96)
FENCE = re.compile(r"[ ]{0,3}(" + TICK + r"{3,}|~{3,})([^\r\n]*)\r?\n")
EXPECTED_FILES = {"README.md", "README.ja.md", "design/plan.json"}
EXPECTED_COMMIT = "4287135b0e642d91c29df0ec1cfa5996fa1c5bcb"
TEX_TYPOGRAPHY_SUBSTITUTIONS = {
    "\\operatorname{im}": "\\mathop{\\mathrm{im}}\\nolimits ",
    "\\operatorname{Log}": "\\mathop{\\mathrm{Log}}\\nolimits ",
    "\\operatorname{diag}": "\\mathop{\\mathrm{diag}}\\nolimits ",
}
FORBIDDEN_OPERATOR_MACRO = re.compile(r"\\operatorname\b")


def sha(text):
    return hashlib.sha256(text.encode("utf-8")).hexdigest()


def escaped(text, offset):
    i = offset - 1
    while i >= 0 and text[i] == "\\":
        i -= 1
    return (offset - i - 1) % 2 == 1


def closing(text, delimiter, start):
    at = text.find(delimiter, start)
    while at >= 0 and escaped(text, at):
        at = text.find(delimiter, at + len(delimiter))
    if at < 0:
        raise ValueError("unclosed math delimiter at " + str(start))
    return at


def math_spans(text):
    """Lex old delimiters and the protected GitHub forms, outside ordinary code."""
    spans = []
    i = 0
    while i < len(text):
        if i == 0 or text[i - 1] == "\n":
            opening = FENCE.match(text, i)
            if opening:
                fence, info = opening.groups()
                pattern = re.compile(r"(?m)^[ ]{0,3}" + re.escape(fence[0])
                                     + "{" + str(len(fence)) + r",}[ \t]*\r?$")
                end = pattern.search(text, opening.end())
                if end is None:
                    raise ValueError("unclosed fenced block at " + str(i))
                if info.strip() == "math":
                    spans.append({"kind": "display", "form": "math_fence",
                                  "start": i, "end": end.end(),
                                  "tex": text[opening.end():end.start()].strip()})
                i = end.end()
                continue
        if text.startswith("$" + TICK, i) and not escaped(text, i):
            end = closing(text, TICK + "$", i + 2)
            spans.append({"kind": "inline", "form": "protected_inline",
                          "start": i, "end": end + 2, "tex": text[i + 2:end].strip()})
            i = end + 2
            continue
        if text.startswith("\\[", i) and not escaped(text, i):
            end = closing(text, "\\]", i + 2)
            spans.append({"kind": "display", "form": "bracket_display",
                          "start": i, "end": end + 2, "tex": text[i + 2:end].strip()})
            i = end + 2
            continue
        if text[i] == "$" and not escaped(text, i):
            delimiter = "$$" if text.startswith("$$", i) else "$"
            end = closing(text, delimiter, i + len(delimiter))
            spans.append({"kind": "display" if delimiter == "$$" else "inline",
                          "form": "dollar_display" if delimiter == "$$" else "dollar_inline",
                          "start": i, "end": end + len(delimiter),
                          "tex": text[i + len(delimiter):end].strip()})
            i = end + len(delimiter)
            continue
        if text[i] == TICK:
            end = i + 1
            while end < len(text) and text[end] == TICK:
                end += 1
            close = text.find(text[i:end], end)
            i = close + end - i if close >= 0 else end
            continue
        i += 1
    return spans


def canonical_tex(tex):
    """Reverse only approved exact operator spellings, including the separator."""
    for before, after in TEX_TYPOGRAPHY_SUBSTITUTIONS.items():
        tex = tex.replace(after, before)
    return tex


def typography_changes(before_spans, after_spans):
    """Expose every changed payload; canonical comparison decides acceptability."""
    return [{"formula_index": i, "kind": after["kind"],
             "before": before["tex"], "after": after["tex"],
             "expansions": {old: after["tex"].count(new)
                            for old, new in TEX_TYPOGRAPHY_SUBSTITUTIONS.items()
                            if new in after["tex"]}}
            for i, (before, after) in enumerate(zip(before_spans, after_spans), 1)
            if before["tex"] != after["tex"]]


def canonical(text):
    spans = math_spans(text)
    pieces = []
    start = 0
    previous_display = False
    for item in spans:
        literal = text[start:item["start"]]
        if previous_display:
            literal = literal.lstrip("\r\n")
        if item["kind"] == "display":
            literal = literal.rstrip("\r\n")
        pieces.extend([("text", literal), (item["kind"], canonical_tex(item["tex"]))])
        previous_display = item["kind"] == "display"
        start = item["end"]
    literal = text[start:]
    if previous_display:
        literal = literal.lstrip("\r\n")
    pieces.append(("text", literal))
    return pieces


def reconstruct_before(current, record):
    pieces = []
    after_at = before_at = 0
    for edit in record["edits"]:
        a, b = edit["after_start"], edit["after_end"]
        c, d = edit["before_start"], edit["before_end"]
        if not (after_at <= a <= b <= len(current) and before_at <= c <= d):
            raise ValueError("unordered or invalid patch offsets")
        if b - a != len(edit["after"]) or d - c != len(edit["before"]):
            raise ValueError("patch offset/length mismatch")
        if current[a:b] != edit["after"] or a - after_at != c - before_at:
            raise ValueError("patch does not match current content")
        pieces.extend([current[after_at:a], edit["before"]])
        after_at, before_at = b, d
    pieces.append(current[after_at:])
    previous = "".join(pieces)
    for edit in record["edits"]:
        if previous[edit["before_start"]:edit["before_end"]] != edit["before"]:
            raise ValueError("patch does not reconstruct its stated previous span")
    return previous


def changed_strings(before, after, path=()):
    if isinstance(before, dict):
        if not isinstance(after, dict) or set(before) != set(after):
            raise ValueError("JSON object structure changed at " + repr(path))
        return [item for key in before
                for item in changed_strings(before[key], after[key], path + (key,))]
    if isinstance(before, list):
        if not isinstance(after, list) or len(before) != len(after):
            raise ValueError("JSON list structure changed at " + repr(path))
        return [item for i, (a, b) in enumerate(zip(before, after))
                for item in changed_strings(a, b, path + (i,))]
    if before == after:
        return []
    if not isinstance(before, str) or not isinstance(after, str):
        raise ValueError("non-string JSON content changed at " + repr(path))
    return [{"path": list(path), "before": before, "after": after}]


def pandoc_math(text):
    result = subprocess.run(["pandoc", "--from=gfm", "--to=json"], input=text,
                            text=True, capture_output=True, check=True)
    out = []

    def visit(value):
        if isinstance(value, dict):
            if value.get("t") == "Math":
                kind, tex = value["c"]
                out.append(("display" if kind["t"] == "DisplayMath" else "inline", tex.strip()))
            for child in value.values():
                visit(child)
        elif isinstance(value, list):
            for child in value:
                visit(child)

    visit(json.loads(result.stdout))
    return out


def table_width_errors(text):
    errors = []
    width = None
    for lineno, line in enumerate(text.splitlines(), 1):
        if not line.startswith("|"):
            width = None
            continue
        delimiters = [i for i, char in enumerate(line) if char == "|" and not escaped(line, i)]
        count = len(delimiters) - (1 if line.rstrip().endswith("|") else 0)
        if width is None:
            width = count
        elif count != width:
            errors.append({"line": lineno, "expected": width, "actual": count})
    return errors


def organization_inputs(root):
    """Check the editorial successor without reassigning historical review receipts."""
    path = root / "reports/submission/organization.json"
    if not path.is_file():
        return {}, []
    record = json.loads(path.read_text(encoding="utf-8"))
    checks, inputs = [], {}

    def check(name, ok):
        checks.append({"check": "organization: " + name, "passed": bool(ok)})

    expected = {"README.md", "README.ja.md", "Suggested.lean",
                "design/plan.json", "design/reuse_registry.json"}
    check("exact file scope", set(record["files"]) == expected)
    commit = record["baseline_commit"]
    if not re.fullmatch(r"[0-9a-f]{40}", commit):
        raise ValueError("invalid organization baseline commit")
    label_cleanup = record.get("item_identifier_cleanup") is not None
    baseline_plan = json.loads(subprocess.check_output(
        ["git", "show", commit + ":TauCetiRoadmap/PainleveEquationsAndFunctions/design/plan.json"],
        cwd=root.parents[1]).decode("utf-8"))
    old_labels = {item["name"] for layer in baseline_plan["layers"]
                  for target in layer["targets"] for field in ["api", "tests"]
                  for item in target[field]}
    label_prefix = re.compile(r'^- `(?:' + '|'.join(re.escape(x) for x in old_labels)
                              + r')`(?: \([^\n)]*\)|（[^\n）]*）)?[ \t]*—[ \t]*', re.M)
    for name in sorted(expected):
        git_path = "TauCetiRoadmap/PainleveEquationsAndFunctions/" + name
        before = subprocess.check_output(
            ["git", "show", commit + ":" + git_path], cwd=root.parents[1]).decode("utf-8")
        current = (root / name).read_bytes().decode("utf-8").replace("\r\n", "\n")
        check(name + " baseline fingerprint", sha(before) == record["files"][name]["before_sha256"])
        check(name + " current fingerprint", sha(current) == record["files"][name]["after_sha256"])
        inputs[name] = before
        if name.endswith(".md"):
            # Compare statements exactly, excluding headings and removed synthetic labels.
            def bodies(text):
                out = {}
                for match in re.finditer(r'^<a id="target-([0-9]+-[0-9]+)"></a>\n### [^\n]*\n', text, re.M):
                    tail = text[match.end():]
                    boundary = re.search(r'^(?:<a id="(?:target-|layer-)|#{1,3} )', tail, re.M)
                    out[match.group(1)] = tail[:boundary.start()] if boundary else tail
                return out
            old_bodies, current_bodies = bodies(before), bodies(current)
            check(name + " 78 target identities", len(old_bodies) == 78
                  and old_bodies.keys() == current_bodies.keys())
            for tid, body in old_bodies.items():
                expected_body = label_prefix.sub('- ', body) if label_cleanup else body
                check(name + " unchanged mathematical target body " + tid,
                      current_bodies.get(tid) == expected_body)
            if label_cleanup:
                check(name + " no synthetic API or diagnostic labels",
                      not any('`' + label + '`' in current for label in old_labels))
            check(name + " no appendix references", "reuse-contract" not in current)
            check(name + " one global overview", current.count('<a id="general-theory"></a>') == 1)
        elif name.endswith(".lean"):
            check(name + " documentation title only", current == before.replace(
                "# Intrinsic Painlevé theory: representative target signatures",
                "# Painlevé equations and functions: suggested interfaces", 1))
        else:
            before_json, current_json = json.loads(before), json.loads(current)
            if name == "design/plan.json" and label_cleanup:
                before_json["schema"] = "tauceti-roadmap/mathematical-plan-v3"
                before_json["item_identifiers"] = (
                    "Target-local document addresses, not proposed Lean declaration names: "
                    "<target>.api.<index> and <target>.tests.<index>.")
                for layer in before_json["layers"]:
                    for target in layer["targets"]:
                        for field in ["api", "tests"]:
                            for i, item in enumerate(target[field], 1):
                                item.pop("name")
                                item["id"] = f"{target['id']}.{field}.{i}"
            def mathematical_content(value, top=False):
                if isinstance(value, dict):
                    return {k: mathematical_content(v) for k, v in value.items()
                            if k not in {"title", "title_ja"} and not (top and k == "summary")}
                if isinstance(value, list):
                    return [mathematical_content(v) for v in value]
                return value
            check(name + " unchanged mathematical fields",
                  mathematical_content(before_json, True)
                  == mathematical_content(current_json, True))
    return inputs, checks


def audit_manifest(root=ROOT, use_pandoc=False):
    root = Path(root)
    manifest_path = root / "reports/submission/math_rendering.json"
    manifest = json.loads(manifest_path.read_text())
    numbering_path = root / "reports/submission/numbering.json"
    numbering = json.loads(numbering_path.read_text())
    editorial_inputs, checks = organization_inputs(root)
    restored, summaries = {}, {}

    def check(name, ok, detail=None):
        item = {"check": name, "passed": bool(ok)}
        if detail is not None:
            item["detail"] = detail
        checks.append(item)

    check("presentation schema", manifest.get("schema") == "tauceti-roadmap/math-rendering-v1")
    check("published preceding commit", manifest.get("previous_commit") == EXPECTED_COMMIT)
    check("immutable numbering manifest", manifest.get("numbering_manifest_sha256")
          == hashlib.sha256(numbering_path.read_bytes()).hexdigest())
    check("exact approved TeX typography substitutions",
          manifest.get("tex_typography_substitutions") == TEX_TYPOGRAPHY_SUBSTITUTIONS)
    records = manifest.get("files", {})
    check("exact presentation file scope", set(records) == EXPECTED_FILES)
    for name, record in records.items():
        if name not in EXPECTED_FILES:
            continue
        current = editorial_inputs.get(name, (root / name).read_bytes().decode("utf-8"))
        snapshot_label = " presentation snapshot bytes" if name in editorial_inputs else " current bytes"
        check(name + snapshot_label, sha(current) == record["after_sha256"])
        check(name + " recorded preceding bytes",
              record["before_sha256"] == numbering["inputs_sha256"].get(name))
        try:
            previous = reconstruct_before(current, record)
            check(name + " exact reversible patch", sha(previous) == record["before_sha256"])
            restored[name] = previous
            if name.endswith(".md"):
                before_spans, spans = math_spans(previous), math_spans(current)
                check(name + " literal prose and ordered TeX payloads with named expansions only",
                      canonical(previous) == canonical(current))
                check(name + " protected GitHub math forms",
                      all(x["form"] in {"protected_inline", "math_fence"} for x in spans))
                check(name + " no GitHub-rejected operatorname macro",
                      not any(FORBIDDEN_OPERATOR_MACRO.search(x["tex"]) for x in spans))
                check(name + " table column counts", not table_width_errors(current), table_width_errors(current))
                counts = dict(Counter(x["kind"] for x in spans))
                summaries[name] = {"inline": counts.get("inline", 0), "display": counts.get("display", 0),
                                   "total": len(spans), "previous_total": len(before_spans),
                                   "forms": dict(Counter(x["form"] for x in spans)),
                                   "typography_exceptions": typography_changes(before_spans, spans)}
                check(name + " required full formula inventory", len(spans) == (249 if name == "README.md" else 237))
                if use_pandoc:
                    parsed = pandoc_math(current)
                    expected = [(x["kind"], x["tex"]) for x in spans]
                    check(name + " independent Pandoc GFM math nodes", parsed == expected,
                          {"parsed": len(parsed), "expected": len(expected)})
            else:
                edits = changed_strings(json.loads(previous), json.loads(current))
                recorded_edits = manifest.get("plan_string_edits", [])
                check("complete structured-plan edit inventory", edits == recorded_edits)
                for edit in edits:
                    label = "/".join(str(x) for x in edit["path"])
                    check("plan presentation only: " + label,
                          canonical(edit["before"]) == canonical(edit["after"]))
                check("structured plan has no GitHub-rejected operatorname macro",
                      not FORBIDDEN_OPERATOR_MACRO.search(current))
                exceptions = []
                for edit in edits:
                    changes = typography_changes(math_spans(edit["before"]), math_spans(edit["after"]))
                    if changes:
                        exceptions.append({"path": edit["path"], "formulas": changes})
                summaries[name] = {"changed_string_fields": len(edits), "typography_exceptions": exceptions}
        except (ValueError, KeyError, subprocess.SubprocessError) as exc:
            check(name + " presentation audit", False, str(exc))
    # The historical rendering receipt stays bound to its original bytes.
    # Independently check the current, shorter documents as Markdown math.
    if editorial_inputs:
        for name in ["README.md", "README.ja.md"]:
            text = (root / name).read_text(encoding="utf-8")
            spans = math_spans(text)
            check(name + " current protected math forms",
                  all(x["form"] in {"protected_inline", "math_fence"} for x in spans))
            check(name + " current operator macros",
                  not any(FORBIDDEN_OPERATOR_MACRO.search(x["tex"]) for x in spans))
            check(name + " current table columns", not table_width_errors(text))
            summaries[name] = {"current_total": len(spans),
                               "current_forms": dict(Counter(x["form"] for x in spans)),
                               "historical_presentation_total": summaries.get(name, {}).get("total")}
            if use_pandoc:
                check(name + " current independent Pandoc GFM math nodes",
                      pandoc_math(text) == [(x["kind"], x["tex"]) for x in spans])
        for name, text in editorial_inputs.items():
            restored.setdefault(name, text)
    failures = [x for x in checks if not x["passed"]]
    result = {
        "meaning": "Presentation preservation with three exact operator-name expansions and Markdown recognition; not theorem proof or remote visual verification.",
        "passed": not failures, "checks": checks, "check_count": len(checks),
        "failed_checks": len(failures), "failures": failures, "documents": summaries,
        "pandoc_used": use_pandoc,
        "organization_baseline_used": bool(editorial_inputs),
        "tex_typography_substitutions": TEX_TYPOGRAPHY_SUBSTITUTIONS,
        "manifest_sha256": hashlib.sha256(manifest_path.read_bytes()).hexdigest(),
    }
    return result, restored


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--root", type=Path, default=ROOT)
    parser.add_argument("--pandoc", action="store_true", help="also compare the independent GFM syntax tree")
    parser.add_argument("--output", type=Path)
    args = parser.parse_args()
    result, _ = audit_manifest(args.root, args.pandoc)
    encoded = json.dumps(result, ensure_ascii=False, indent=2) + "\n"
    if args.output:
        args.output.write_text(encoded)
    print(encoded, end="")
    return 0 if result["passed"] else 1


if __name__ == "__main__":
    sys.exit(main())
