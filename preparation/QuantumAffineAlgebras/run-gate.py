"""Run the unmodified worker gate on the primary roadmap checkout."""
from pathlib import Path
import hashlib
import json
import os
import subprocess
import sys

workspace = Path('/workspace/scratch/889845af25ea')
root = workspace / 'TauCetiRoadmap'
worker = workspace / 'TauCetiRoadmapWorker'
output = workspace / 'preparation/QuantumAffineAlgebras'
sys.path.insert(0, str(worker))
os.environ['PATH'] = str(workspace / 'tools/lean-4.36.0-rc2-linux/bin') + os.pathsep + os.environ['PATH']
from tauceti_roadmap_worker.gates import GateOptions, run_gate

paths = subprocess.check_output(['git', 'ls-tree', '-r', '--name-only', 'upstream/main'], cwd=root, text=True).splitlines()
merged = {p.split('/')[1] for p in paths if p.startswith('TauCetiRoadmap/') and p.endswith('/README.md') and len(p.split('/')) == 3}
options = GateOptions(order=sorted(merged) + ['QuantumAffineAlgebras'], merged=merged,
                      tauceti_sources=root / '.lake/packages/TauCeti/TauCeti')
result = run_gate(root, 'QuantumAffineAlgebras', options,
                  base='upstream/main', build_cmd='lake build {module}')
record = result.to_dict()
record['reviewed_commit'] = subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=root, text=True).strip()
record['upstream_baseline'] = subprocess.check_output(['git', 'rev-parse', 'upstream/main'], cwd=root, text=True).strip()
record['worker_commit'] = subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=worker, text=True).strip()
record['merged_supplier_count'] = len(merged)
record['options'] = {'base': 'upstream/main', 'build_cmd': 'lake build {module}',
                     'roadmap_files': options.roadmap_files,
                     'outside_folder_allow': options.outside_folder_allow,
                     'statement_hygiene': options.statement_hygiene}
record['file_sha256'] = {p.name: hashlib.sha256(p.read_bytes()).hexdigest()
                         for p in sorted((root/'TauCetiRoadmap/QuantumAffineAlgebras').iterdir()) if p.is_file()}
(output/'gate-result.json').write_text(json.dumps(record, indent=2, ensure_ascii=False)+'\n')
print(result.summary())
if result.details:
    print(json.dumps(record['details'], indent=2, ensure_ascii=False))
raise SystemExit(result.exit_code)
