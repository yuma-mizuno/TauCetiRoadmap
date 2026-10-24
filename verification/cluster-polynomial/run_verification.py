"""Run the cluster/Laurent library trial with ordinary Lake imports.

The dedicated Lake configuration uses the same pinned dependency manifest and
source tree as the roadmap package, with Tau Ceti's production Lean options.
No other worktree, project .olean, import override or generated proof is loaded.
"""
from pathlib import Path
import argparse
import hashlib
import json
import os
import re
import shutil
import subprocess
import sys
import time
import sympy
try:
    import tomllib
except ModuleNotFoundError:
    from pip._vendor import tomli as tomllib

ROOT = Path(__file__).resolve().parents[2]
SOURCES = Path(__file__).resolve().parent
OUTPUT = ROOT / '.lake/verification/library'
CONFIG = ROOT / 'lakefile.library.toml'
AUDIT = SOURCES / 'LibraryAudit.lean'


def source_files():
    files = [ROOT / 'TauCetiRoadmap/ClusterAlgebras.lean',
             ROOT / 'TauCetiRoadmap/LaurentPhenomenon.lean']
    for name in ['ClusterAlgebras', 'LaurentPhenomenon']:
        files.extend((ROOT / 'TauCetiRoadmap' / name).rglob('*.lean'))
    return sorted(files)


def fingerprints(files):
    return {p.relative_to(ROOT).as_posix(): hashlib.sha256(p.read_bytes()).hexdigest()
            for p in files}


def dependency_pins(manifest):
    pins = {}
    for dep in manifest['packages']:
        if dep['type'] != 'git':
            raise RuntimeError(f'Unpinned dependency: {dep["name"]}')
        directory = ROOT / manifest['packagesDir'] / dep['name']
        head = subprocess.check_output(['git', '-C', str(directory), 'rev-parse', 'HEAD'],
                                       cwd=ROOT, text=True).strip()
        if head != dep['rev']:
            raise RuntimeError(f'Dependency pin mismatch: {dep["name"]}')
        subprocess.run(['git', '-C', str(directory), 'diff', '--quiet', 'HEAD', '--'],
                       cwd=ROOT, check=True)
        extra = subprocess.check_output(
            ['git', '-C', str(directory), 'ls-files', '--others', '--exclude-standard',
             '--', '*.lean'], cwd=ROOT, text=True)
        if extra.strip():
            raise RuntimeError(f'Untracked Lean dependency sources: {dep["name"]}')
        pins[dep['name']] = head
    return pins


def run(command, filename, env):
    with (OUTPUT / filename).open('w', encoding='utf-8') as log:
        result = subprocess.run(command, cwd=ROOT, env=env, stdout=log,
                                stderr=subprocess.STDOUT)
    if result.returncode:
        raise RuntimeError(f'{filename}: command failed with exit code {result.returncode}')
    return (OUTPUT / filename).read_text(encoding='utf-8', errors='replace')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--fresh', action='store_true',
                        help='Archive this trial package build directory before rebuilding.')
    args = parser.parse_args()
    OUTPUT.mkdir(parents=True, exist_ok=True)
    result_file = OUTPUT / 'result.json'
    result_file.write_text(json.dumps({'status': 'running'}), encoding='utf-8')
    files = source_files()
    modules = {p.relative_to(ROOT).with_suffix('').as_posix().replace('/', '.')
               for p in files}
    # Production module docs follow the import block; prose inside them is not Lean syntax.
    for driver in [AUDIT, SOURCES / 'DocumentationAudit.lean']:
        import_block = driver.read_text(encoding='utf-8').split('/-!', 1)[0]
        imported = set(re.findall(r'^import (\S+)', import_block, re.M))
        if modules != imported:
            raise RuntimeError(f'{driver.name}: source coverage mismatch: '
                               f'missing={modules-imported}, extra={imported-modules}')
    for p in files:
        text = p.read_text(encoding='utf-8')
        if re.search(r'^\s*set_option\s+(maxHeartbeats|maxRecDepth)\b', text, re.M):
            raise RuntimeError(f'Proof budget override in {p.relative_to(ROOT)}')
        if re.search(r'^\s*set_option\s+linter\.[^\n]*\bfalse\b', text, re.M):
            raise RuntimeError(f'Disabled linter in {p.relative_to(ROOT)}')
        if len(text.splitlines()) > 1000:
            raise RuntimeError(f'New-file length limit exceeded in {p.relative_to(ROOT)}')
    # Public mathematical roots must not transitively import tests or examples;
    # generic Laurent algebra must not import the cluster layer.
    graph = {}
    for p in files:
        name = p.relative_to(ROOT).with_suffix('').as_posix().replace('/', '.')
        import_lines = re.findall(r'^(?:public )?(?:meta )?import \S+',
                                 p.read_text(encoding='utf-8'), re.M)
        imports = [line.split()[-1] for line in import_lines]
        if len(import_lines) != len(set(import_lines)):
            raise RuntimeError(f'Duplicate imports: {name}')
        if '.LaurentPhenomenon.' in name and any('.ClusterAlgebras' in i for i in imports):
            raise RuntimeError(f'Generic algebra imports cluster layer: {name}')
        graph[name] = imports
    for root in ['TauCetiRoadmap.ClusterAlgebras', 'TauCetiRoadmap.LaurentPhenomenon']:
        visited, pending = set(), [root]
        while pending:
            name = pending.pop()
            if name in visited:
                continue
            visited.add(name)
            if '.Tests.' in name or '.Examples.' in name:
                raise RuntimeError(f'Test/example leaks into public import closure: {root}: {name}')
            pending.extend(graph.get(name, []))
    lake = shutil.which('lake') or str(Path.home() / '.elan/bin/lake.exe')
    env = os.environ.copy()
    env.pop('LEAN_PATH', None)
    env.pop('LEAN_SRC_PATH', None)
    env.pop('ELAN_TOOLCHAIN', None)
    env.pop('PYTHONOPTIMIZE', None)
    command = [lake, '-f', CONFIG.name]
    manifest = json.loads((ROOT / 'lake-manifest.json').read_text())
    pins = dependency_pins(manifest)
    production_config = ROOT / manifest['packagesDir'] / 'TauCeti/lakefile.toml'
    production = tomllib.loads(production_config.read_text(encoding='utf-8'))
    trial = tomllib.loads(CONFIG.read_text(encoding='utf-8'))
    production_options = next(lib['leanOptions'] for lib in production['lean_lib']
                              if lib['name'] == 'TauCeti')
    trial_options = next(lib['leanOptions'] for lib in trial['lean_lib']
                         if lib['name'] == 'TauCetiRoadmap')
    if trial_options != production_options:
        raise RuntimeError('Trial Lean options differ from the pinned production library')
    inputs = files + [CONFIG, ROOT / 'lean-toolchain', ROOT / 'lake-manifest.json',
                      Path(__file__).resolve(),
                      ROOT / 'TauCetiRoadmap/ClusterAlgebras/README.md',
                      ROOT / 'TauCetiRoadmap/ClusterAlgebras/FORMALIZATION.md',
                      ROOT / 'TauCetiRoadmap/LaurentPhenomenon/README.md']
    inputs += sorted(SOURCES.glob('check_*.py')) + sorted(SOURCES.glob('*.lean'))
    initial = fingerprints(inputs)
    if args.fresh:
        build = (ROOT / '.lake/build-library').resolve()
        backup = (ROOT / '.lake/backups/library-validation' /
                  ('build-' + str(time.time_ns()))).resolve()
        if not build.is_relative_to(ROOT / '.lake') or not backup.is_relative_to(ROOT / '.lake'):
            raise RuntimeError('Build archive path escaped the workspace')
        if build.exists():
            shutil.move(str(build), str(backup))
    print(f'Building all {len(files)} source modules with production Lean options.', flush=True)
    version = run(command + ['env', 'lean', '--version'], 'version.log', env).strip()
    expected_version = (ROOT / 'lean-toolchain').read_text().strip().split(':')[-1].lstrip('v')
    if f'version {expected_version},' not in version:
        raise RuntimeError(f'Unexpected Lean executable: {version}')
    run(command + ['build'], 'build.log', env)
    audit_log = run(command + ['env', 'lean', str(AUDIT)], 'audit.log', env)
    doc_log = run(command + ['env', 'lean', str(SOURCES / 'DocumentationAudit.lean')],
                  'documentation.log', env)
    if 'Both axiom-audit negative controls passed.' not in audit_log:
        raise RuntimeError('Axiom-audit negative controls did not run')
    match = re.search(r'Audited (\d+) declarations: only propext, Classical.choice, Quot.sound',
                      audit_log)
    if not match or int(match[1]) == 0:
        raise RuntimeError('Whole-library axiom audit did not report nonempty coverage')
    docs = re.search(r'Documentation: (\d+)/(\d+); no project nolint exemptions', doc_log)
    linters = re.search(r'All (\d+) default environment linters passed', audit_log)
    if not docs or int(docs[1]) == 0 or docs[1] != docs[2] or not linters or int(linters[1]) == 0:
        raise RuntimeError('Environment/documentation audits did not report complete coverage')
    header = ROOT / manifest['packagesDir'] / 'TauCeti/scripts/HeaderStyle.lean'
    run(command + ['env', 'lean', '--run', str(header)] +
        [str(p.relative_to(ROOT)) for p in files], 'headers.log', env)
    ordered_modules = [p.relative_to(ROOT).with_suffix('').as_posix().replace('/', '.')
                       for p in files]
    for script, log in [('ModuleAudit.lean', 'modules.log'), ('StyleAudit.lean', 'style.log')]:
        run(command + ['env', 'lean', '--run', str(SOURCES / script)] + ordered_modules,
            log, env)
    symbolic_outputs = ['symbolic-multiterm.json', 'frozen-quantum.json', 'principal-and-negative.json']
    scripts = ['check_polynomial_quantum.py', 'check_frozen_quantum.py', 'check_principal.py']
    for name, output in zip(scripts, symbolic_outputs):
        destination = OUTPUT / output
        if destination.exists():
            destination.unlink()
        run([sys.executable, str(SOURCES / name), '--output', str(destination)],
            name + '.log', env)
    rank_two = json.loads((OUTPUT / symbolic_outputs[0]).read_text())['checks']
    frozen = json.loads((OUTPUT / symbolic_outputs[1]).read_text())
    principal_report = json.loads((OUTPUT / symbolic_outputs[2]).read_text())
    principal = principal_report['principal_cases']
    reversal = principal_report['nonreciprocal_reversal_cases']
    if len(reversal) != 3 or not all(c['reversal'] and c['laurent'] for c in reversal):
        raise RuntimeError('Nonreciprocal reversal checks have incomplete coverage')
    if (len(rank_two), len(frozen), len(principal)) != (12, 6, 12):
        raise RuntimeError('Exact symbolic checks have incomplete case coverage')
    if not all(c['replacement'] and c['specialization'] and c['constructed_defects'] for c in rank_two):
        raise RuntimeError('Rank-two symbolic checks did not certify every case')
    if not all(c['replacement'] and c['frozen_ring_noncommutative'] and
               c['independently_constructed_second_mutation'] for c in frozen):
        raise RuntimeError('Frozen symbolic checks did not certify every case')
    if not all(c['integral_alternating_compatible'] and
               c['mutation_preserves_column_degrees'] for c in principal):
        raise RuntimeError('Principal symbolic checks did not certify every case')
    if source_files() != files or initial != fingerprints(inputs):
        raise RuntimeError('Source inputs changed during verification')
    if dependency_pins(manifest) != pins:
        raise RuntimeError('Dependency sources changed during verification')
    report = dict(status='passed', fresh_project_build=args.fresh,
                  source_modules=len(files), audited_declarations=int(match[1]),
                  toolchain=(ROOT / 'lean-toolchain').read_text().strip(),
                  dependency_pins=pins, input_sha256=initial,
                  lean_executable=version, axiom_negative_controls=True,
                  module_system=True, environment_linters=True, docstrings=True,
                  text_and_filename_linters=True,
                  default_environment_linters=int(linters[1]),
                  documented_definitions=int(docs[1]),
                  symbolic_runtime=dict(python=sys.version, sympy=sympy.__version__),
                  lean_options='lakefile.library.toml',
                  exact_symbolic_cases=dict(rank_two=12, frozen=6, principal=12, reversal=3),
                  generalized_all_rank_implementation=True,
                  polynomial_wordwise_classical_specialization=True,
                  polynomial_exchange_scope="monic central Zv; constant term one; reversal mutation")
    result_file.write_text(json.dumps(report, indent=2), encoding='utf-8')
    print(f'Passed: {len(files)} modules, {match[1]} axiom-audited declarations, '
          'copyright headers, exact symbolic checks.', flush=True)


if __name__ == '__main__':
    try:
        main()
    except Exception as error:
        OUTPUT.mkdir(parents=True, exist_ok=True)
        (OUTPUT / 'result.json').write_text(json.dumps(
            dict(status='failed', reason=str(error)), indent=2), encoding='utf-8')
        print(error, file=sys.stderr)
        sys.exit(1)
