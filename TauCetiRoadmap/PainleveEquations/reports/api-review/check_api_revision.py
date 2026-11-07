#!/usr/bin/env python3
"""Check the Painleve API revision's contracts, graph, math syntax and regressions.

These are source-consistency checks and exact finite calculations, not Lean proofs.
Historical submission receipts are left bound to their original snapshots.
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
from collections import Counter
from pathlib import Path


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--root',type=Path,default=Path(__file__).resolve().parents[2])
    parser.add_argument('--baseline',default='d59dd62f39e96a680baf3656fc4398dfa8de7fb2')
    parser.add_argument('--output',type=Path)
    args=parser.parse_args()
    root=args.root.resolve();repo=root.parents[1];prefix=str(root.relative_to(repo))+'/'
    rows=[]
    def check(name,passed,detail=None):
        row={'check':name,'passed':bool(passed)}
        if detail is not None:row['detail']=detail
        rows.append(row)
    def baseline(name):
        return subprocess.check_output(['git','show',args.baseline+':'+prefix+name],cwd=repo).decode()
    def sections(text):
        out={}
        for m in re.finditer(r'^### (\d+\.\d+) [^\n]+\n',text,re.M):
            end=re.search(r'^(?:<a id="(?:target-|layer-|part-)|#### |### (?:Scope|References|本ロードマップ|対象|参考))',text[m.end():],re.M)
            stop=m.end()+end.start() if end else len(text)
            out[m[1]]=text[m.start():stop].strip()
        return out
    docs={lang:(root/name).read_text() for lang,name in [('en','README.md'),('ja','README.ja.md')]}
    old_docs={lang:baseline(name) for lang,name in [('en','README.md'),('ja','README.ja.md')]}
    blocks={lang:sections(text) for lang,text in docs.items()}
    old_blocks={lang:sections(text) for lang,text in old_docs.items()}
    plan=json.loads((root/'design/plan.json').read_text())
    old_plan=json.loads(baseline('design/plan.json'))
    targets=[t for layer in plan['layers'] for t in layer['targets']]
    old_targets=[t for layer in old_plan['layers'] for t in layer['targets']]
    ids=[t['id'] for t in targets];by_id={t['id']:t for t in targets}
    check('57 targets with unchanged identities',ids==[t['id'] for t in old_targets] and len(ids)==57 and len(set(ids))==57)
    check('8 unchanged numerical layers',[x['key'] for x in plan['layers']]==[str(i) for i in range(8)])
    graph=json.loads((root/'design/reuse_graph.json').read_text())
    contracts=json.loads((root/'design/dependencies.json').read_text())['contracts']
    contract_ids={x['id'] for x in contracts}
    position={x:i for i,x in enumerate(ids)}
    edges=[];changed={lang:[] for lang in docs}
    for lang in docs:
        check(lang+' target headings match plan',list(blocks[lang])==ids)
        check(lang+' unique explicit anchors',len(re.findall(r'^<a id="target-\d+-\d+"></a>$',docs[lang],re.M))==57)
        changed[lang]=[tid for tid in ids if blocks[lang][tid]!=old_blocks[lang][tid]]
    check('same revised target set in both languages',changed['en']==changed['ja'])
    for t in targets:
        tid=t['id'];block=blocks['en'][tid];jblock=blocks['ja'][tid]
        check(tid+' statement in English target',t['statement'] in block)
        check(tid+' English hypotheses in target',all(x in block for x in t['hypotheses']))
        check(tid+' Japanese hypotheses in target',all(x in jblock for x in t.get('hypotheses_ja',[])))
        check(tid+' Needs in both languages',t['readme_needs'] in block and t.get('readme_needs_ja','') in jblock)
        for field in ['api','tests']:
            check(tid+' '+field+' text in English target',all(x['statement'] in block for x in t[field]))
            check(tid+' '+field+' stable numbering',[x['id'] for x in t[field]]==[f'{tid}.{field}.{i}' for i in range(1,len(t[field])+1)])
        for item in t.get('supporting_constructions',[]):
            check(item['id']+' supporting construction in both languages',item['statement'] in block and item['statement_ja'] in jblock)
        refs=t['prerequisites'];internal=[x[7:] for x in refs if x.startswith('target:')]
        external=[x[11:] for x in refs if x.startswith('dependency:')]
        check(tid+' prerequisites are named and unique',len(refs)==len(set(refs)) and set(internal)<=set(ids) and set(external)<=contract_ids)
        check(tid+' prerequisites precede owner',all(position.get(x,10**9)<position[tid] for x in internal))
        header=re.search(r'^Internal: ([^;]+)',t['readme_needs'])
        listed=re.findall(r'\d+\.\d+',header[1]) if header else []
        check(tid+' Needs agrees with internal graph',listed==internal)
        ja_header=re.search(r'^内部依存：([^;]+)',t.get('readme_needs_ja',''))
        ja_listed=re.findall(r'\d+\.\d+',ja_header[1]) if ja_header else []
        check(tid+' Japanese Needs agrees with graph',ja_listed==internal)
        check(tid+' Needs agrees with external graph',re.findall(r'\]\(#dependency-([^\)]+)\)',t['readme_needs'])==external)
        for dep in internal:edges.append({'from':tid,'to':dep})
    check('dependency graph exactly matches plan',graph['edges']==edges)
    adjacency={tid:[] for tid in ids}
    for e in edges:adjacency[e['from']].append(e['to'])
    def ancestors(tid,seen=None):
        seen=set() if seen is None else seen
        for x in adjacency[tid]:
            if x not in seen:seen.add(x);ancestors(x,seen)
        return seen
    for t in targets:
        reach=ancestors(t['id'])
        check(t['id']+' no dependency cycle',t['id'] not in reach)
        if t['scope_role']=='framework':
            check(t['id']+' general theory independent of applications',all(by_id[x]['scope_role']=='framework' for x in reach))
        if 3<=int(t['id'].split('.')[0])<=6:
            check(t['id']+' geometric construction independent of Layer 7',not any(x.startswith('7.') for x in reach))
    for c in contracts:
        check('contract '+c['id']+' consumers',[t['id'] for t in targets if 'dependency:'+c['id'] in t['prerequisites']]==c['consumers'])
    expected_counts={
        'parts':len(plan['parts']),'general_parts':sum(x['scope_role']=='framework' for x in plan['parts']),
        'layers':len(plan['layers']),'targets':len(targets),'general_targets':sum(t['scope_role']=='framework' for t in targets),
        'api_laws':sum(len(t['api']) for t in targets),'diagnostics':sum(len(t['tests']) for t in targets),
        'internal_edges':len(edges),'supporting_constructions':sum(len(t.get('supporting_constructions',[])) for t in targets)}
    check('all derived counts',plan['counts']==expected_counts,expected_counts)
    sources=tomllib.loads((root/'sources.toml').read_text())['source']
    source_ids={x['id'] for x in sources}
    check('source keys unique',len(source_ids)==len(sources))
    check('source consumer targets valid',all(set(x.get('cited_for',[]))<=set(ids) for x in sources))
    for t in targets:
        if 'source' in t.get('locator', {}):
            check(t['id']+' primary source key valid',t['locator']['source'] in source_ids or t['locator']['source']=='generic')
        if 'sources' in t.get('locator', {}):
            check(t['id']+' source keys valid',set(t['locator']['sources'])<=source_ids)
    check('source correction owner is 7.2', 'source corrections in §7.4' not in docs['en'] and 'scalar correction in §7.4' not in docs['en'] and 'source-sign corrections and' not in blocks['en']['7.4'])
    check('observer construction is owned by 7.2', 'certificates' in blocks['en']['7.2'] and 'conditional' in blocks['en']['4.8'])
    check('RH inverse and target specified', 'Uθ = RHθ⁻¹(Vθ)' in blocks['en']['4.3'] and 'Rθᵃᵈᵐ := Rθ' in blocks['en']['4.4'])
    check('unchanged representative Lean interfaces',(root/'Suggested.lean').read_bytes()==baseline('Suggested.lean').encode())
    check('unchanged arXiv topic',(root/'metadata.toml').read_bytes()==baseline('metadata.toml').encode())
    # Independent GFM parsing and the existing math lexer inspect current bytes,
    # without replaying old preservation manifests against changed mathematics.
    spec=importlib.util.spec_from_file_location('math_check',root/'reports/submission/check_math_rendering.py')
    sys.dont_write_bytecode=True
    mod=importlib.util.module_from_spec(spec);spec.loader.exec_module(mod)
    math_counts={}
    for lang,text in docs.items():
        spans=mod.math_spans(text);old_spans=mod.math_spans(old_docs[lang])
        actual=[(x['kind'],x['tex']) for x in spans]
        expected=mod.pandoc_math(text)
        check(lang+' GFM math syntax agrees with independent parser',actual==expected)
        check(lang+' existing TeX payloads retained',not (Counter((x['kind'],x['tex']) for x in old_spans)-Counter(actual)))
        check(lang+' no forbidden operator macro',not re.search(r'\\operatorname\b',text))
        check(lang+' tables have consistent widths',not mod.table_width_errors(text))
        check(lang+' no draft placeholders',not re.search(r'SIGMA_INVENTORY|TODO|FIXME|PLACEHOLDER',text))
        math_counts[lang]={'before':len(old_spans),'after':len(spans)}
    # Exact algebraic regressions for the false PII reverse implication.
    import sympy as s
    u,v,w,t,h,c=s.symbols('u v w t h c')
    E=v**2+4*u**3+2*u*(t*u-h)-c**2/4;D=w+6*u**2+2*t*u-h
    derivative=lambda f:s.diff(f,t)+s.diff(f,h)*u+s.diff(f,u)*v+s.diff(f,v)*w
    q=(2*v+c)/(4*u);p=-2*u;H=p**2/2-(q**2+t/2)*p-c*q
    for label,residual in {
        'PII E derivative':derivative(E)-2*v*D,
        'PII second Hamilton equation':derivative(p)-(2*q*p+c),
        'PII first Hamilton residual identity':derivative(q)-(p-q**2-t/2)-(D/(2*u)-E/(4*u**2)),
        'PII Hamiltonian value identity':H-h-E/(2*u),
    }.items():check(label,s.cancel(residual)==0)
    subs={h:t+2,u:1,v:0,w:0,c:0}
    check('PII counterexample satisfies sigma equation',s.cancel(E.subs(subs))==0)
    check('PII counterexample fails first Hamilton equation at zero',s.cancel((derivative(q)-(p-q**2-t/2)).subs(subs).subs(t,0))==2)
    a,b=s.symbols('a b');linear=s.cancel(E.subs({h:a*t+b,u:a,v:0}))
    check('PII affine branch equation',s.expand(linear-(4*a**3-2*a*b-c**2/4))==0)
    PI=v**2+4*u**3+2*t*u-2*h
    check('PI differentiated sigma equation',s.expand(derivative(PI)-2*v*(w+6*u**2+t))==0)
    check('PI affine spurious branches',s.expand(PI.subs({h:a*t+2*a**3,u:a,v:0}))==0)
    canonical=s.Symbol('s');normalized=2*canonical
    check('tau normalization changes coefficient but not logarithmic derivative',s.cancel(s.diff(normalized,canonical)/normalized-1/canonical)==0 and normalized.subs(canonical,1)==2)
    inputs={name:hashlib.sha256((root/name).read_bytes()).hexdigest() for name in
            ['README.md','README.ja.md','design/plan.json','design/dependencies.json','design/reuse_graph.json','sources.toml','Suggested.lean','metadata.toml']}
    result={'baseline_commit':args.baseline,'counts':expected_counts,'changed_targets':changed['en'],
            'math_counts':math_counts,'input_sha256':inputs,'checks':rows,
            'summary':{'passed':sum(x['passed'] for x in rows),'failed':sum(not x['passed'] for x in rows)},
            'limits':['No full lake build or new Lean proof was performed.','Syntax parsing is not a visual inspection of the remote GitHub renderer.','Exact sigma calculations and contract checks do not prove the roadmap existence theorems.']}
    if args.output:args.output.write_text(json.dumps(result,ensure_ascii=False,indent=2)+'\n')
    print(json.dumps({'summary':result['summary'],'counts':expected_counts,'math_counts':math_counts,
                      'failures':[x for x in rows if not x['passed']]},ensure_ascii=False,indent=2))
    return 1 if result['summary']['failed'] else 0

if __name__=='__main__':sys.exit(main())
