"""Run the pinned worker's unchanged similarity functions over exact-head snapshots."""
from pathlib import Path
import hashlib
import json
import subprocess
import sys

workspace = Path('/workspace/scratch/889845af25ea')
root = workspace / 'TauCetiRoadmap'
output = workspace / 'preparation/QuantumAffineAlgebras'
sys.path.insert(0, str(workspace / 'TauCetiRoadmapWorker'))
from tauceti_roadmap_worker import overlaps

index = json.loads((output / 'open-pr-readme-index.json').read_text())
main_sha = index['main_sha']
paths = subprocess.check_output(['git', 'ls-tree', '-r', '--name-only', main_sha], cwd=root, text=True).splitlines()
paths = [p for p in paths if p.endswith('/README.md') and len(p.split('/')) >= 3
         and p.split('/')[0] in {'TauCetiRoadmap', 'Completed'}]
# Match openroadmaps.main_roadmaps: first path for each actual roadmap name.
main_paths = {}
for path in paths:
    main_paths.setdefault(path.split('/')[-2], path)
texts = [('main', name, subprocess.check_output(['git', 'show', f'{main_sha}:{path}'], cwd=root, text=True))
         for name, path in main_paths.items()]
main_count = len(texts)
for item in index['snapshots']:
    text = Path(item['local_path']).read_text()
    if hashlib.sha256(text.encode()).hexdigest() != item['sha256']:
        raise RuntimeError(f"Snapshot hash mismatch: {item['local_path']}")
    texts.append((item['where'], item['roadmap'], text))

readme = (root / 'TauCetiRoadmap/QuantumAffineAlgebras/README.md').read_text()
report = {
    'method': 'unmodified pinned worker overlaps.neighbours and overlaps.subject_neighbours',
    'worker_sha': subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=workspace / 'TauCetiRoadmapWorker', text=True).strip(),
    'main_sha': main_sha,
    'candidate_readme_sha256': hashlib.sha256(readme.encode()).hexdigest(),
    'main_readme_count': main_count,
    'open_readme_count': len(index['snapshots']),
    'head_mismatches': index['head_mismatches'],
    'missing_readmes': index['missing_readmes'],
    'open_vocabulary': overlaps.neighbours(texts, readme, own='QuantumAffineAlgebras', k=15),
    'main_vocabulary': overlaps.neighbours(texts, readme, own='QuantumAffineAlgebras', k=10, on_main=True),
    'subject': overlaps.subject_neighbours(texts, readme, own='QuantumAffineAlgebras', k=15),
}
(output / 'open-pr-neighbours.json').write_text(json.dumps(report, indent=2, ensure_ascii=False) + '\n')
lines = ['# QuantumAffineAlgebras: worker neighbour analysis', '',
         f"Worker `{report['worker_sha']}`, main `{main_sha}`.",
         f"Candidate README SHA256: `{report['candidate_readme_sha256']}`.",
         f"Compared {main_count} main README snapshots and {report['open_readme_count']} open-head README snapshots.",
         'These similarity results are leads for a mathematical ownership review, not evidence that a target is supplied.', '',
         f"Head mismatches: {len(index['head_mismatches'])}; missing READMEs: {len(index['missing_readmes'])}."]
for key, title in [('open_vocabulary','Open roadmap neighbours by vocabulary'), ('main_vocabulary','Main roadmap neighbours by vocabulary'), ('subject','Main and open neighbours by named results and headings')]:
    lines += ['', '## ' + title, '', '| Score | Snapshot | Roadmap |', '| --- | --- | --- |']
    lines += [f'| {score} | {where} | {name} |' for score, where, name in report[key]]
    if not report[key]:
        lines.append('| — | — | No result above the worker threshold |')
lines += ['', 'The score, weighting, thresholds and tokenization are those of the pinned worker. No thresholds were lowered and no source text was edited for this comparison.', '']
(output / 'open-pr-neighbours.md').write_text('\n'.join(lines))
print(json.dumps(report, indent=2, ensure_ascii=False))
