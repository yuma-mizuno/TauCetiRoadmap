#!/usr/bin/env python3
"""Check contract synchronization and preservation for the timeless revision.

This verifies document structure, source inventories, dependency laws, exact TeX
preservation and unchanged Lean declarations. It does not certify the mathematical
theorems stated as roadmap goals or replace the recorded editorial review.
"""
from __future__ import annotations

import argparse
import hashlib
import importlib.util
import json
import re
import subprocess
import sys
import tomllib
from pathlib import Path

BASELINE = '2441b2fe3a68efbb628db17eae5f282d35cbb8bd'
LABELS = {
    'Hypotheses': 'hypotheses', 'Hypotheses.': 'hypotheses',
    '入力条件': 'hypotheses', '仮定.': 'hypotheses',
    'API': 'api', 'API.': 'api', '構成・法則（API）': 'api',
    'Checks.': 'tests', 'Tests and falsification cases': 'tests',
    '検証事項': 'tests', 'チェック.': 'tests',
    'Supporting constructions owned by this target.': 'supporting',
    '本目標が担う補助構成。': 'supporting',
}
ROLES = {'General theory.', 'Painlevé application.', '一般理論。', 'パンルヴェへの適用。'}
SOURCES = {'Source scope.', 'Source scope and owned proof:', '出典と適用範囲.', '文献の範囲と担当証明：'}


def sections(text):
    out = {}
    for m in re.finditer(r'^### (\d+\.\d+) ([^\n]+)\n', text, re.M):
        following = re.search(r'^(?:<a id="(?:target-|layer-|part-)|#{1,4} )', text[m.end():], re.M)
        end = m.end() + following.start() if following else len(text)
        out[m[1]] = {'title': m[2], 'text': text[m.start():end].strip()}
    return out


def fields(block):
    text = re.sub(r'^### [^\n]+\n', '', block, count=1)
    result = {'statement': '', 'hypotheses': [], 'api': [], 'tests': [], 'supporting': [], 'source_scope': None}
    chunks = re.split(r'(?m)^(\*\*[^\n]*?\*\*[^\n]*|\*Needs:\*[^\n]*|\*必要な先行結果：\*[^\n]*)\n?', text)
    statements = [chunks[0].strip()] if chunks[0].strip() else []
    for i in range(1, len(chunks), 2):
        heading = chunks[i].strip()
        body = chunks[i + 1].strip() if i + 1 < len(chunks) else ''
        if heading.startswith('*Needs:*') or heading.startswith('*必要な先行結果：*'):
            result['needs'] = heading.split('*', 2)[2].strip()
            continue
        match = re.match(r'\*\*(.*?)\*\*(.*)', heading)
        label, inline = match[1], match[2].strip()
        if label in ROLES:
            if body:
                statements.append(body)
        elif label in SOURCES:
            result['source_scope'] = '\n\n'.join(x for x in [inline, body] if x)
        elif label in LABELS:
            kind = LABELS[label]
            for paragraph in re.split(r'\n\s*\n', body):
                paragraph = paragraph.strip()
                if paragraph.startswith('- '):
                    result[kind].extend(x[2:].strip() for x in re.split(r'\n(?=- )', paragraph))
                elif paragraph and kind == 'hypotheses':
                    statements.append(paragraph)
                elif paragraph:
                    raise ValueError(('unparsed contract field', kind, paragraph[:80]))
        else:
            raise ValueError(('unknown target heading', label))
    result['statement'] = '\n\n'.join(statements)
    return result


def without_lean_comments(text):
    out, i = [], 0
    while i < len(text):
        if text.startswith('/-', i):
            depth = 1
            i += 2
            while depth:
                if i >= len(text):
                    raise ValueError('unterminated Lean block comment')
                if text.startswith('/-', i):
                    depth += 1
                    i += 2
                elif text.startswith('-/', i):
                    depth -= 1
                    i += 2
                else:
                    i += 1
        elif text.startswith('--', i):
            i = text.find('\n', i)
            if i < 0:
                break
        elif text[i] == '"':
            start = i
            i += 1
            while i < len(text):
                if text[i] == '\\':
                    i += 2
                elif text[i] == '"':
                    i += 1
                    break
                else:
                    i += 1
            out.append(text[start:i])
        else:
            out.append(text[i])
            i += 1
    return ''.join(out)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--root', type=Path, default=Path(__file__).resolve().parents[2])
    parser.add_argument('--baseline', default=BASELINE)
    parser.add_argument('--output', type=Path)
    args = parser.parse_args()
    root = args.root.resolve()
    repo = root.parents[1]
    prefix = str(root.relative_to(repo)) + '/'
    rows = []

    def check(name, passed, detail=None):
        row = {'check': name, 'passed': bool(passed)}
        if detail is not None:
            row['detail'] = detail
        rows.append(row)

    def baseline(path):
        return subprocess.check_output(['git', 'show', args.baseline + ':' + prefix + path], cwd=repo).decode()

    docs = {lang: (root / name).read_text() for lang, name in [('en', 'README.md'), ('ja', 'README.ja.md')]}
    old_docs = {lang: baseline(name) for lang, name in [('en', 'README.md'), ('ja', 'README.ja.md')]}
    blocks = {lang: sections(text) for lang, text in docs.items()}
    old_blocks = {lang: sections(text) for lang, text in old_docs.items()}
    parsed = {lang: {tid: fields(s['text']) for tid, s in entries.items()} for lang, entries in blocks.items()}
    plan = json.loads((root / 'design/plan.json').read_text())
    old_plan = json.loads(baseline('design/plan.json'))
    targets = [t for layer in plan['layers'] for t in layer['targets']]
    old_targets = [t for layer in old_plan['layers'] for t in layer['targets']]
    by_id = {t['id']: t for t in targets}
    old_by_id = {t['id']: t for t in old_targets}
    ids = list(by_id)
    position = {tid: i for i, tid in enumerate(ids)}
    deps = json.loads((root / 'design/dependencies.json').read_text())['contracts']
    old_deps = json.loads(baseline('design/dependencies.json'))['contracts']
    dependency_ids = {c['id'] for c in deps}
    graph = json.loads((root / 'design/reuse_graph.json').read_text())
    registry = json.loads((root / 'design/reuse_registry.json').read_text())
    parts = {p['id']: p for p in plan['parts']}
    check('57 targets and identities preserved', ids == [t['id'] for t in old_targets] and len(ids) == 57)
    check('8 numerical layers preserved', [l['key'] for l in plan['layers']] == [str(i) for i in range(8)])
    check('dependency graph file unchanged', (root / 'design/reuse_graph.json').read_text() == baseline('design/reuse_graph.json'))
    check('reuse registry unchanged', (root / 'design/reuse_registry.json').read_text() == baseline('design/reuse_registry.json'))
    changed = {}
    for lang in docs:
        check(lang + ' headings match plan', list(blocks[lang]) == ids)
        changed[lang] = [tid for tid in ids if blocks[lang][tid]['text'] != old_blocks[lang][tid]['text']]
        anchors = re.findall(r'<a id="([^"]+)"></a>', docs[lang])
        check(lang + ' explicit anchors unique', len(anchors) == len(set(anchors)))
        check(lang + ' fragment links resolve', set(re.findall(r'\]\(#([^\)]+)\)', docs[lang])) <= set(anchors))
        check(lang + ' draft markers absent', not re.search(r'\b(?:TODO|FIXME|PLACEHOLDER|SIGMA_INVENTORY)\b', docs[lang]))
        check(lang + ' review-response phrases absent', not re.search(r'by fiat|unlocated source|unlocated theorem|proof-development task|unspecified closure|レビューへの|レビューに応じ|未配置|無言で|黙って', docs[lang], re.I))
    for layer in plan['layers']:
        check('layer ' + layer['key'] + ' English title', f"## Layer {layer['key']}: {layer['title']}" in docs['en'])
        check('layer ' + layer['key'] + ' Japanese title', f"## レイヤー{layer['key']}：{layer['title_ja']}" in docs['ja'])
    edges = []
    for t in targets:
        tid = t['id']
        old = old_by_id[tid]
        en, ja = parsed['en'][tid], parsed['ja'][tid]
        check(tid + ' title synchronized', t['title'] == blocks['en'][tid]['title'])
        for field in ['statement', 'hypotheses']:
            check(tid + ' English ' + field, t[field] == en[field])
            if field + '_ja' in t:
                check(tid + ' Japanese ' + field, t[field + '_ja'] == ja[field])
        check(tid + ' Needs synchronized', t['readme_needs'] == en['needs'] and t['readme_needs_ja'] == ja['needs'])
        check(tid + ' owner and prerequisites preserved', all(t[k] == old[k] for k in ['part', 'scope_role', 'prerequisites']))
        for field in ['api', 'tests']:
            check(tid + ' ' + field + ' synchronized', [x['statement'] for x in t[field]] == en[field])
            check(tid + ' ' + field + ' identifiers preserved', [x['id'] for x in t[field]] == [x['id'] for x in old[field]])
            check(tid + ' bilingual ' + field + ' counts preserved', len(en[field]) == len(ja[field]) == len(old[field]))
        support = t.get('supporting_constructions', [])
        check(tid + ' supporting constructions synchronized', [x['statement'] for x in support] == en['supporting'] and [x['statement_ja'] for x in support] == ja['supporting'])
        check(tid + ' supporting identifiers preserved', [x['id'] for x in support] == [x['id'] for x in old.get('supporting_constructions', [])])
        if 'source_scope' in t:
            if en['source_scope'] is not None:
                check(tid + ' source scope synchronized', t['source_scope'] == en['source_scope'] and ('locator' not in t or t['locator']['where'] == en['source_scope']))
            else:
                check(tid + ' source scope synchronized', t['source_scope'] in en['statement'])
        if 'ja' in t:
            expected = dict(t['ja'])
            expected.update({k: ja[k] for k in ['statement', 'hypotheses', 'api', 'tests', 'needs']})
            expected['title'] = blocks['ja'][tid]['title']
            if 'source_scope' in expected:
                expected['source_scope'] = ja['source_scope']
            check(tid + ' full Japanese contract synchronized', t['ja'] == expected)
        internal = [x[7:] for x in t['prerequisites'] if x.startswith('target:')]
        external = [x[11:] for x in t['prerequisites'] if x.startswith('dependency:')]
        for lang, marker in [('en', r'^Internal: ([^;]+)'), ('ja', r'^内部依存：([^;]+)')]:
            m = re.search(marker, parsed[lang][tid]['needs'])
            declared = re.findall(r'\d+\.\d+', m[1]) if m else []
            check(tid + ' ' + lang + ' dependencies match graph', declared == internal and re.findall(r'\]\(#dependency-([^\)]+)\)', parsed[lang][tid]['needs']) == external)
        check(tid + ' valid preceding prerequisites', len(t['prerequisites']) == len(set(t['prerequisites'])) and set(external) <= dependency_ids and all(position.get(x, 10**9) < position[tid] for x in internal))
        edges.extend({'from': tid, 'to': dep} for dep in internal)
    check('graph edges agree with contracts', graph['edges'] == edges)
    check('graph nodes agree with target ownership', graph['nodes'] == [{'id': t['id'], 'part': t['part'], 'scope_role': t['scope_role']} for t in targets])
    ancestor_sets = {}
    for t in targets:
        ancestry = set()
        for dep in t['prerequisites']:
            if dep.startswith('target:'):
                ancestor = dep[7:]
                ancestry.add(ancestor)
                ancestry.update(ancestor_sets.get(ancestor, set()))
        ancestor_sets[t['id']] = ancestry
        if t['scope_role'] == 'framework':
            check(t['id'] + ' general theory independent of applications', all(by_id[x]['scope_role'] == 'framework' for x in ancestry))
        if 3 <= int(t['id'].split('.')[0]) <= 6:
            check(t['id'] + ' geometric construction independent of Layer 7', not any(x.startswith('7.') for x in ancestry))
    for part in registry['parts']:
        expected = parts[part['id']]
        check('part ' + part['id'] + ' registry matches plan', part['target_ids'] == [t['id'] for t in targets if t['part'] == part['id']] and all(part[k] == expected[k] for k in ['title', 'scope_role']) and part['owner'] == expected['contracts']['owner'])
    for c, old in zip(deps, old_deps):
        check('supplier ' + c['id'] + ' identity and scope addresses preserved', all(c.get(k) == old.get(k) for k in ['id', 'paths', 'sections', 'source_revision', 'consumer_sections']))
        check('supplier ' + c['id'] + ' consumers match plan', c['consumers'] == [t['id'] for t in targets if 'dependency:' + c['id'] in t['prerequisites']])
        en_row = next(line for line in docs['en'].splitlines() if '<a id="dependency-' + c['id'] + '">' in line)
        ja_row = next(line for line in docs['ja'].splitlines() if '<a id="dependency-' + c['id'] + '">' in line)
        check('supplier ' + c['id'] + ' bilingual table synchronized', c['supplied'] + ' ' + c['owned_here'] in en_row and c['supplied_ja'] in ja_row)
    expected_counts = {
        'parts': len(plan['parts']), 'general_parts': sum(p['scope_role'] == 'framework' for p in plan['parts']),
        'layers': len(plan['layers']), 'targets': len(targets), 'general_targets': sum(t['scope_role'] == 'framework' for t in targets),
        'api_laws': sum(len(t['api']) for t in targets), 'diagnostics': sum(len(t['tests']) for t in targets),
        'internal_edges': len(edges), 'supporting_constructions': sum(len(t.get('supporting_constructions', [])) for t in targets),
    }
    check('all counts preserved and derived', expected_counts == plan['counts'] == old_plan['counts'], expected_counts)
    check('reference convention has actual layer range', 'Layers 0–7' in plan['reference_convention']['internal'] and 'Layers 0–9' not in json.dumps(plan))
    moduli = parts['connection_moduli']['contracts']
    for item in moduli['owned_proof_obligations']:
        check(item['id'] + ' summary synchronized', '- `' + item['id'] + '` — ' + item['statement'] in docs['en'])
    for interface in moduli['foundational_interfaces']:
        contract = next(c for c in deps if c['id'] == interface['contract'][11:])
        check(interface['contract'] + ' summary synchronized', interface['scope'] == contract['supplied'])
    sources = tomllib.loads((root / 'sources.toml').read_text())['source']
    old_sources = tomllib.loads(baseline('sources.toml'))['source']
    check('source identities and locators preserved', [{k: v for k, v in s.items() if k != 'version_note'} for s in sources] == [{k: v for k, v in s.items() if k != 'version_note'} for s in old_sources])
    history=json.loads((root / 'reports/timeless/source-note-history.json').read_text())
    expected_note_changes=[{'source': old['id'], 'previous_note': old['version_note'], 'current_note': new['version_note']} for old,new in zip(old_sources,sources) if old['version_note']!=new['version_note']]
    check('source-note provenance and limitations retained', history['baseline_commit']==args.baseline and history['changes']==expected_note_changes)
    source_ids = {s['id'] for s in sources}
    check('source keys unique and consumers valid', len(source_ids) == len(sources) and all(set(s['cited_for']) <= set(ids) for s in sources))
    for t in targets:
        locator = t.get('locator', {})
        keys = locator.get('sources', []) + ([locator['source']] if 'source' in locator else [])
        check(t['id'] + ' source keys resolve', set(keys) <= source_ids | {'generic'})
    i13 = next(s for s in sources if s['id'] == 'I13')
    i13_summary = next(s for s in moduli['sources'] if s['key'] == 'I13')
    check('I13 fixed version synchronized', i13['url'] == i13_summary['url'] and i13_summary['pdf'].endswith('0602004v2') and all('](https://arxiv.org/abs/math/0602004);' not in doc for doc in docs.values()))
    check('required Suggested opening disclaimer retained', '**This file is not the roadmap and is not exhaustive.**' in (root / 'Suggested.lean').read_text())
    check('Lean noncomment bytes unchanged', without_lean_comments((root / 'Suggested.lean').read_text()) == without_lean_comments(baseline('Suggested.lean')))
    check('topic metadata unchanged', (root / 'metadata.toml').read_text() == baseline('metadata.toml'))
    check('sigma verification program unchanged', (root / 'reports/api-review/verify_sigma_inventory.py').read_text() == baseline('reports/api-review/verify_sigma_inventory.py'))
    spec = importlib.util.spec_from_file_location('math_check', root / 'reports/submission/check_math_rendering.py')
    sys.dont_write_bytecode = True
    math = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(math)
    math_counts = {}
    for lang in docs:
        payloads = lambda text: [(s['kind'], s['tex']) for s in math.math_spans(text)]
        current, previous = payloads(docs[lang]), payloads(old_docs[lang])
        check(lang + ' exact ordered TeX unchanged', current == previous)
        check(lang + ' independent GFM math parser agrees', current == math.pandoc_math(docs[lang]))
        check(lang + ' table widths consistent', not math.table_width_errors(docs[lang]))
        check(lang + ' forbidden operator macro absent', not re.search(r'\\operatorname\b', docs[lang]))
        for tid in ids:
            check(tid + ' ' + lang + ' exact ordered TeX unchanged', payloads(blocks[lang][tid]['text']) == payloads(old_blocks[lang][tid]['text']))
        math_counts[lang] = len(current)
    diff = subprocess.run(['git', 'diff', '--check'], cwd=repo, capture_output=True, text=True)
    check('git diff whitespace check', diff.returncode == 0, diff.stdout + diff.stderr)
    inputs = ['README.md', 'README.ja.md', 'design/plan.json', 'design/dependencies.json', 'design/reuse_graph.json', 'design/reuse_registry.json', 'sources.toml', 'Suggested.lean', 'metadata.toml', 'reports/timeless/check_timeless.py', 'reports/timeless/source-note-history.json']
    result = {
        'baseline_commit': args.baseline, 'counts': expected_counts, 'changed_targets': changed, 'math_counts': math_counts,
        'input_sha256': {name: hashlib.sha256((root / name).read_bytes()).hexdigest() for name in inputs},
        'checks': rows,
        'summary': {'passed': sum(r['passed'] for r in rows), 'failed': sum(not r['passed'] for r in rows)},
        'limits': ['These checks establish document consistency and stated preservation properties, not roadmap theorem proofs.', 'No full lake build or new Lean proof was performed.', 'GFM syntax was parsed independently; this is not a visual inspection of the remote GitHub renderer.'],
    }
    if args.output:
        args.output.write_text(json.dumps(result, ensure_ascii=False, indent=2) + '\n')
    print(json.dumps({k: result[k] for k in ['summary', 'counts', 'math_counts', 'changed_targets']} | {'failures': [r for r in rows if not r['passed']]}, ensure_ascii=False, indent=2))
    return int(bool(result['summary']['failed']))


if __name__ == '__main__':
    sys.exit(main())
