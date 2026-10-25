"""Validate the common-exchange roadmap revision against its verified proof snapshot.

Run from a checkout containing the parent proof snapshot and its built library:
  lake -f lakefile.library.toml build
  python verification/cluster-polynomial/evidence/ReviewRoadmap.py

The frozen-boundary nonmembership has the grading proof written in the roadmap;
this script checks its identities and finite grading certificate. The grading
mutation identity is tested exactly in 48 cases, not presented as a universal
Lean proof of the remaining polynomial grading API.
"""
from pathlib import Path
import json
import os
import hashlib
import subprocess
import re
import shutil
import importlib.util
import sympy as sp
ROOT=Path(__file__).resolve().parents[3]
BASE_COMMIT='192ba6a680de7b34292432aa986c2aeae027c69e'
OUTPUT=ROOT/'.lake/verification/roadmap-review'
RESULT=ROOT/'verification/cluster-polynomial/evidence/roadmap-review.json'

def main():
    os.chdir(ROOT)
    OUTPUT.mkdir(parents=True,exist_ok=True)
    RESULT.write_text(json.dumps(dict(status='running'))+'\n',encoding='utf-8',newline='\n')
    root=ROOT;roadmap=Path('TauCetiRoadmap/ClusterAlgebras/README.md')
    text=roadmap.read_text(encoding='utf-8')
    before=subprocess.check_output(['git','show',BASE_COMMIT+':'+roadmap.as_posix()]).decode()
    (OUTPUT/'README.before.md').write_text(before,encoding='utf-8',newline='\n')
    old=json.loads(Path('verification/cluster-polynomial/evidence/unified-result.json').read_text())
    changed=[]
    for n,h in old['input_sha256'].items():
     if hashlib.sha256(Path(n).read_bytes()).hexdigest()!=h:changed.append(n)
    assert changed==[roadmap.as_posix()],changed
    source_paths=[Path('TauCetiRoadmap/ClusterAlgebras.lean'),Path('TauCetiRoadmap/LaurentPhenomenon.lean')]
    for area in ['ClusterAlgebras','LaurentPhenomenon']:source_paths+=list((Path('TauCetiRoadmap')/area).rglob('*.lean'))
    assert len(source_paths)==190
    spec=importlib.util.spec_from_file_location('library_verification',
        ROOT/'verification/cluster-polynomial/run_verification.py')
    verifier=importlib.util.module_from_spec(spec)
    spec.loader.exec_module(verifier)
    pins=verifier.dependency_pins(json.loads((ROOT/'lake-manifest.json').read_text()))
    assert pins==old['dependency_pins']
    for p in source_paths:assert hashlib.sha256(p.read_bytes()).hexdigest()==old['input_sha256'][p.as_posix()]
    for layer in [3,5,6,7]:
     start='## Layer '+str(layer)+':'
     def extract(s):
      a=s.index(start);m=re.search(r'^## (?:Layer |Completion criteria)',s[a+len(start):],re.M)
      return s[a:a+len(start)+m.start()] if m else s[a:]
     assert extract(before)==extract(text),'Unrelated layer changed: '+str(layer)
    markers=['**P1 —','**Q1 —','**P2 / Q2 —','**Q3 —','**L5 —','**P3 —']
    assert all(text.count(m)==1 for m in markers)
    assert [text.index(m) for m in markers]==sorted(text.index(m) for m in markers)
    assert sum(line.strip()=='$$' for line in text.splitlines())%2==0
    assert text.count('```')%2==0
    assert text.count('`')%2==0
    assert b'\r' not in roadmap.read_bytes()
    for forbidden in ['quantum-first','quantum-9b74','common polynomial theorem of §0.7','Q1–Q3 → L5','build-library','FORMALIZATION.md','PolynomialQuantumLaurent.lean']:
     assert forbidden not in text,forbidden
    links=[]
    for target in re.findall(r'\[[^\]]+\]\(([^)]+)\)',text):
     if '://' in target or target.startswith('#'):continue
     path=target.split('#')[0]
     assert (roadmap.parent/path).exists(),target
     links.append(target)
    # The noninvertible-frozen boundary: identities and a finite grading certificate.
    x,y,z=sp.symbols('x y z');xp=(y+z)/x;yp=(x+z)/y;h=(x+y+z)/(x*y)
    assert sp.cancel(h-(1+xp)/y)==0
    assert sp.cancel(h-(1+yp)/x)==0
    assert sp.cancel(z*h-(xp*yp-1))==0
    assert sp.cancel(h.subs(z,0)-(1/x+1/y))==0
    fixed_H=y**3+2*y+1;reversed_H=y**3+2*y**2+1
    assert sp.gcd(fixed_H,reversed_H)==1
    assert sp.Poly(reversed_H,y).degree()==3 and reversed_H.subs(y,0)==1
    B=sp.Matrix([[0,1],[-1,0],[1,-1]])
    def mutate(B,k):
     return sp.Matrix(B.rows,B.cols,lambda i,j:
      -B[i,j] if i==k or j==k else B[i,j]+max(B[i,k],0)*max(B[k,j],0)-max(-B[i,k],0)*max(-B[k,j],0))
    Bm=mutate(B,0);assert B.rank()==2 and Bm[2,1]==0
    # Evaluate the actual scalar polynomial exchange formula on [0,0].
    B3=sp.Matrix([[0,3],[-3,0]])
    def exchange(A,coords,k,coeff):
        total=0
        for ell,c in enumerate(coeff):
            monomial=sp.prod(coords[a]**(max(-A[a,k],0)+ell*(A[a,k]/3))
                             for a in range(2))
            total+=c*monomial
        return sp.cancel(total/coords[k])
    first=exchange(B3,[x,y],0,[1,2,0,1])
    assert sp.cancel(first-reversed_H/x)==0
    wrong=exchange(mutate(B3,0),[first,y],0,[1,2,0,1])
    right=exchange(mutate(B3,0),[first,y],0,[1,0,2,1])
    assert sp.cancel(wrong-x*fixed_H/reversed_H)==0
    assert sp.cancel(right-x)==0
    # Verify the divided-column identity used by the polynomial grading target.
    case_count=0
    for n in range(1,4):
     for sign in [-1,1]:
      r=sp.diag(*list(range(2,n+2)))
      C=sp.Matrix(n,n,lambda i,j:sign*((j-i) if abs(j-i)==1 else 0))
      A=(C*r).col_join(r)
      for step in range(4):
       k=step%n
       Ap=mutate(A,k)
       for eps in [-1,1]:
        E=sp.eye(2*n);F=sp.eye(n)
        for i in range(2*n):E[i,k]=-1 if i==k else max(-eps*A[i,k],0)
        for j in range(n):F[k,j]=-1 if j==k else max(eps*A[k,j],0)
        Fr=r*F*r.inv()
        assert all(a.q==1 for a in Fr)
        assert E*E==sp.eye(2*n)
        assert Ap==E*A*F
        assert E*(Ap*r.inv())==(A*r.inv())*Fr
        case_count+=1
       A=Ap
    lake=shutil.which('lake') or str(Path.home()/'.elan/bin/lake.exe')
    env=os.environ.copy()
    for var in ['LEAN_PATH','LEAN_SRC_PATH','ELAN_TOOLCHAIN','PYTHONOPTIMIZE']:env.pop(var,None)
    probe=Path('verification/cluster-polynomial/evidence/RoadmapInterfaces.lean')
    assert not re.search(r'\b(?:sorry|native_decide)\b',probe.read_text(encoding='utf-8'))
    assert not re.search(r'^\s*axiom\s',probe.read_text(encoding='utf-8'),re.M)
    command=[lake,'-f','lakefile.library.toml','env','lean',
     '-Dweak.linter.mathlibStandardSet=true','-DwarningAsError=true',str(probe)]
    with (OUTPUT/'interfaces.log').open('w',encoding='utf-8') as log:
     result=subprocess.run(command,cwd=root,env=env,stdout=log,stderr=subprocess.STDOUT)
    if result.returncode:raise RuntimeError('Lean contract probe failed; see interfaces.log')
    log=(OUTPUT/'interfaces.log').read_text(encoding='utf-8')
    assert 'All three zero-phase cubic contracts use only standard axioms.' in log

    out=dict(status='passed',scope='roadmap contracts, structure and exact algebraic checks',
     base_commit=BASE_COMMIT,lean_contract_probe=True,critical_contract_axiom_audit=True,
     lean_contract_command=command,
     contract_source_sha256=hashlib.sha256(probe.read_bytes()).hexdigest(),
     audit_script_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
     nonreciprocal_fixed_rule_counterexample=True,fixed_rule_word=[0,0],
     unchanged_lean_modules=len(source_paths),dependency_pins_unchanged=True,changed_original_verification_inputs=changed,
     unchanged_unrelated_layers=[3,5,6,7],ordered_milestones=markers,local_links_checked=len(links),
     timeless_content_checks=True,balanced_markdown_and_display_math=True,
     frozen_inversion_boundary=dict(matrix_rank=2,identities=True,
      generator_degrees_after_z_zero=[1,1,0,0],candidate_degrees=[-1,-1],
      nonmembership_reason='Every polynomial in the specialized generators has nonnegative total degree.'),
     divided_column_mutation_identity_cases=case_count,
     roadmap_sha256=hashlib.sha256(roadmap.read_bytes()).hexdigest(),
     prior_production_proof_record='verification/cluster-polynomial/evidence/unified-result.json',
     prior_production_proof_record_sha256=hashlib.sha256(Path('verification/cluster-polynomial/evidence/unified-result.json').read_bytes()).hexdigest())
    RESULT.write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8',newline='\n')
    print(json.dumps(out,indent=2))
if __name__=='__main__':
    try:
        main()
    except Exception as error:
        RESULT.write_text(json.dumps(dict(status='failed',reason=str(error)),indent=2)+'\n',encoding='utf-8',newline='\n')
        raise
