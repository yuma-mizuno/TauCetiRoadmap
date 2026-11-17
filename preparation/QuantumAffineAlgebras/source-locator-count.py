#!/usr/bin/env python3
"""Count explicit research-source locator bundles and compare a reviewed git version.

One occurrence is a source ID followed by a section/equation/theorem/remark/
introduction locator. A bundle listing several results counts once. Repeated
bundles count separately. Bibliography entries and unlocated mentions do not.
This is an inventory, not a mathematical source-verification substitute.
"""
from __future__ import annotations
import argparse
from collections import Counter
import hashlib
import json
from pathlib import Path
import re
import subprocess

IDS = ["KKOP20", "K02", "AK97", "KKOP22", "CP95", "CP98", "K94", "KKKO15", "K91", "H10"]
PATTERN = re.compile(
    r"\b(" + "|".join(IDS)
    + r")\s+(?=§|\(|Theorem|Proposition|Lemma|Corollary|Definition|Introduction|Section|Remark)"
)
RELATIVE = "TauCetiRoadmap/QuantumAffineAlgebras/README.md"
BASELINE = "9f9a91680f97a98778950d2e202d1444d0b9d967"


def inventory(text: str) -> dict:
    body = text.split("## References", 1)[0]
    hits = [
        {"source": m.group(1), "line": body.count("\n", 0, m.start()) + 1}
        for m in PATTERN.finditer(body)
    ]
    counts = Counter(h["source"] for h in hits)
    return {"sha256": hashlib.sha256(text.encode()).hexdigest(),
            "counts": {source: counts[source] for source in IDS},
            "total": len(hits), "hits": hits}


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--repo", type=Path, default=Path.cwd())
    parser.add_argument("--baseline", default=BASELINE)
    parser.add_argument("--output", type=Path)
    args = parser.parse_args()
    current = inventory((args.repo / RELATIVE).read_text())
    prior = subprocess.run(
        ["git", "-C", str(args.repo), "show", args.baseline + ":" + RELATIVE],
        capture_output=True, text=True, check=True,
    ).stdout
    old = inventory(prior)
    result = {
        "baseline_commit": args.baseline,
        "readme": RELATIVE,
        "counting_rule": __doc__.strip(),
        "baseline": old, "current": current,
        "delta": {source: current["counts"][source] - old["counts"][source] for source in IDS},
    }
    payload = json.dumps(result, ensure_ascii=False, indent=2) + "\n"
    if args.output:
        args.output.write_text(payload)
    else:
        print(payload, end="")


if __name__ == "__main__":
    main()

