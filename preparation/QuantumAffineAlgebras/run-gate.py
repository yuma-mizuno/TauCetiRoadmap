"""Run the unmodified worker gate with complete main/open-PR dependency evidence.

The local proposed order is not the worker board's official merge order.
Declared gap owners without a folder are names in that proposal, not fabricated
supplier READMEs and not entries in the merged or observed-open collections.
"""
from pathlib import Path
from graphlib import TopologicalSorter, CycleError
import hashlib
import io
import json
import os
import re
import subprocess
import sys

workspace = Path('/workspace/scratch/889845af25ea')
root = workspace / 'TauCetiRoadmap'
worker = workspace / 'TauCetiRoadmapWorker'
output = workspace / 'preparation/QuantumAffineAlgebras'
name = 'QuantumAffineAlgebras'
sys.path.insert(0, str(worker))
os.environ['PATH'] = str(workspace / 'tools/lean-4.36.0-rc2-linux/bin') + os.pathsep + os.environ['PATH']
from tauceti_roadmap_worker import depgraph
from tauceti_roadmap_worker.gates import GateOptions, run_gate, roadmap_names
from tauceti_roadmap_worker.lanes.design import validate_plan


def git(*args):
    return subprocess.check_output(['git', *args], cwd=root, text=True).strip()


def batch_blobs(specs):
    """Read exact git blobs in one process; no worktree or supplier mutation."""
    raw = subprocess.check_output(['git', 'cat-file', '--batch'], cwd=root,
                                  input=('\n'.join(specs) + '\n').encode())
    stream = io.BytesIO(raw)
    result = []
    for spec in specs:
        header = stream.readline().decode().strip().split()
        if len(header) != 3 or header[1] != 'blob':
            raise RuntimeError(f'Cannot read blob {spec}: {header}')
        data = stream.read(int(header[2]))
        if stream.read(1) != b'\n':
            raise RuntimeError(f'Invalid cat-file separator after {spec}')
        result.append(data.decode('utf-8'))
    return result


baseline = git('rev-parse', 'upstream/main')
inventory = json.loads((output / 'open-pr-inventory.json').read_text())
index = json.loads((output / 'open-pr-readme-index.json').read_text())
assert inventory['pull_collection_pages_complete']
assert inventory['changed_filenames_complete']
assert inventory['head_sha_verified_count'] == inventory['total'] == len(inventory['prs'])
assert not index['head_mismatches'] and not index['missing_readmes']
assert index['main_sha'] == baseline == inventory['main_comparison_sha']
assert inventory['readme_snapshot_count'] == len(index['snapshots'])
fetched_heads = dict(line.split(' ', 1) for line in git(
    'for-each-ref', '--format=%(refname) %(objectname)', 'refs/remotes/pr-audit/',
    'refs/remotes/pr-audit-current/').splitlines())
for pr in inventory['prs']:
    local_ref = pr.get('local_head_ref', f"refs/remotes/pr-audit/{pr['number']}")
    assert fetched_heads.get(local_ref) == pr['head_sha'], (pr['number'], local_ref)

paths = git('ls-tree', '-r', '--name-only', baseline).splitlines()
merged = roadmap_names(paths, ('TauCetiRoadmap', 'Completed'))
main_paths = {}
for path in paths:
    parts = path.split('/')
    if len(parts) >= 3 and parts[0] in {'TauCetiRoadmap', 'Completed'} and parts[-1] == 'README.md':
        main_paths.setdefault(parts[-2], path)
main_names = sorted(main_paths)
main_texts = batch_blobs([f'{baseline}:{main_paths[n]}' for n in main_names])
siblings = dict(zip(main_names, main_texts, strict=True))
open_readmes = [('main', n, t) for n, t in siblings.items()]
observed_open_names = set()
new_adders = {}
for item in sorted(index['snapshots'], key=lambda r: (r['number'], r['folder'])):
    text = Path(item['local_path']).read_text()
    assert hashlib.sha256(text.encode()).hexdigest() == item['sha256'], item['local_path']
    open_readmes.append((item['where'], item['roadmap'], text))
    observed_open_names.add(item['roadmap'])
    if item['roadmap'] not in merged:
        siblings.setdefault(item['roadmap'], text)
        new_adders.setdefault(item['roadmap'], item['number'])

readme_path = root / f'TauCetiRoadmap/{name}/README.md'
readme = readme_path.read_text()
readme_gaps = {g.rstrip('.') for g in re.findall(r'gap:([A-Za-z0-9][\w.-]*)', readme)}
plan_path = output / 'design/plan.json'
plan = json.loads(plan_path.read_text()) if plan_path.exists() else {}
plan_problems = validate_plan(plan, name) if plan else []
if plan and plan.get('provenance', {}).get('readme_sha256') != hashlib.sha256(readme.encode()).hexdigest():
    plan_problems.append('design/plan.json was generated from a different README hash; rebuild the plan before gating')
if plan and (output / 'design/README.md').read_text() != readme:
    plan_problems.append('design/README.md differs from the reviewed primary README')
if readme_gaps and not plan:
    plan_problems.append('README declares gaps but no design/plan.json exists')
declared = {g['slug']: g for g in plan.get('gaps', [])}
if readme_gaps != set(declared):
    plan_problems.append(f'README/plan gap mismatch: README={sorted(readme_gaps)}, plan={sorted(declared)}')
if plan_problems:
    raise RuntimeError('\n'.join(plan_problems))
gap_owners = {g['supplier'] for g in declared.values()}
assert 'none' not in gap_owners
planned_absent_owners = gap_owners - merged - observed_open_names

# Every observed name and every explicitly declared missing owner is visible to
# the unchanged worker parser. Only the candidate's transitive supplier closure
# is ordered before it; unrelated open roadmaps remain after it.
known = merged | observed_open_names | gap_owners | {name}
readmes = {**siblings, name: readme}
edges = depgraph.supplier_edges(readmes, known)
closure = {name}
frontier = [name]
while frontier:
    consumer = frontier.pop()
    for supplier in edges.get(consumer, {}):
        if supplier not in merged and supplier not in closure:
            closure.add(supplier)
            frontier.append(supplier)
subgraph = {n: set(edges.get(n, {})) & closure for n in closure}
try:
    suppliers_first = list(TopologicalSorter(subgraph).static_order())
except CycleError as exc:
    raise RuntimeError(f'Candidate supplier closure has a cycle: {exc}') from exc
proposed_order = sorted(merged) + suppliers_first + sorted(known - merged - closure)
supplemental_problems = depgraph.check_order(edges, proposed_order, only=closure, merged=merged)
supplemental_problems += [f'Unlisted supplier: {consumer} -> {supplier}'
                         for consumer in closure for supplier in edges.get(consumer, {})
                         if supplier not in merged and supplier not in proposed_order]
if supplemental_problems:
    raise RuntimeError('\n'.join(supplemental_problems))

options = GateOptions(order=proposed_order, merged=merged,
                      sibling_readmes=siblings, open_readmes=open_readmes,
                      pull_request=0,
                      tauceti_sources=root / '.lake/packages/TauCeti/TauCeti')
result = run_gate(root, name, options, base='upstream/main', build_cmd='lake build {module}')
record = result.to_dict()
record['reviewed_commit'] = git('rev-parse', 'HEAD')
record['upstream_baseline'] = baseline
record['worker_commit'] = subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=worker, text=True).strip()
record['merged_supplier_count'] = len(merged)
record['dependency_evidence'] = {
    'open_pr_count': inventory['total'],
    'open_pr_page_counts': inventory['page_counts'],
    'changed_file_count': inventory['changed_file_count'],
    'main_readme_count': len(main_names),
    'open_readme_count': len(index['snapshots']),
    'open_heads_verified': inventory['head_sha_verified_count'],
    'head_mismatches': index['head_mismatches'],
    'missing_readmes': index['missing_readmes'],
    'order_kind': 'local proposed supplier order, not the official board merge order',
    'candidate_suppliers': {n: sorted(lines) for n, lines in sorted(edges.get(name, {}).items())},
    'candidate_nonmain_supplier_closure': suppliers_first,
    'observed_open_suppliers_in_closure': {n: new_adders[n] for n in suppliers_first if n in new_adders},
    'planned_absent_gap_owners': sorted(planned_absent_owners),
    'planned_owner_limit': 'No supplier README was invented; absent owners have no mechanically checked outgoing target graph.',
    'conditional_gaps': sorted(declared),
    'supplemental_closure_problems': supplemental_problems,
    'plan_validation_problems': plan_problems,
    'proposed_order': proposed_order,
    'inventory_sha256': hashlib.sha256((output / 'open-pr-inventory.json').read_bytes()).hexdigest(),
    'snapshot_index_sha256': hashlib.sha256((output / 'open-pr-readme-index.json').read_bytes()).hexdigest(),
    'plan_sha256': hashlib.sha256(plan_path.read_bytes()).hexdigest() if plan_path.exists() else None,
}
record['options'] = {'base': 'upstream/main', 'build_cmd': 'lake build {module}',
                     'roadmap_files': options.roadmap_files,
                     'outside_folder_allow': options.outside_folder_allow,
                     'statement_hygiene': options.statement_hygiene,
                     'pull_request': 0,
                     'open_readmes': len(open_readmes),
                     'sibling_readmes': len(siblings)}
record['file_sha256'] = {p.name: hashlib.sha256(p.read_bytes()).hexdigest()
                         for p in sorted((root / f'TauCetiRoadmap/{name}').iterdir()) if p.is_file()}
(output / 'gate-result.json').write_text(json.dumps(record, indent=2, ensure_ascii=False) + '\n')
print(result.summary())
print(f"Dependency evidence: {inventory['total']} open PRs, {len(index['snapshots'])} exact-head READMEs, "
      f"{len(merged)} main suppliers; absent declared owners={sorted(planned_absent_owners)}; "
      f"conditional gaps={sorted(declared)}.")
if result.details:
    print(json.dumps(record['details'], indent=2, ensure_ascii=False))
raise SystemExit(result.exit_code)
