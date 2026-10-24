"""Exact Q2 checks with a noncommutative frozen coefficient torus.

The second mutated exchange is constructed from B', Lambda' and its monomial
formula, independently of the finite-replacement compatibility identity.
"""
from pathlib import Path
import argparse
import json, random
import sympy as S

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--output', type=Path)
output = parser.parse_args().output or Path(__file__).with_name('frozen-quantum.json')

v,A,B=S.symbols('v A B')
lam=None

def clean(f): return {a:S.expand(c) for a,c in f.items() if S.expand(c)!=0}
def add(*fs):
 out={}
 for f in fs:
  for a,c in f.items(): out[a]=out.get(a,0)+c
 return clean(out)
def sc(c,f): return clean({a:c*b for a,b in f.items()})
def form(a,b,L=None): return (S.Matrix(a).T*(lam if L is None else L)*S.Matrix(b))[0]
def mul(f,g):
 out={}
 for a,c in f.items():
  for b,d in g.items():
   k=tuple(x+y for x,y in zip(a,b));out[k]=out.get(k,0)+c*d*v**form(a,b)
 return clean(out)
def mon(a): return {tuple(a):S.Integer(1)}
zero=(0,)*4
one=mon(zero)
def power(f,n):
 assert n>=0
 ans=one
 for _ in range(n):ans=mul(ans,f)
 return ans
def invmono(f):
 assert len(f)==1
 a,c=next(iter(f.items()))
 return {tuple(-x for x in a):1/c}
def e(i):return tuple(int(j==i) for j in range(4))
def ap(b,k,l):
 beta=[int(b[j,k]/2) for j in range(4)]
 return tuple(-int(j==k)+l*max(beta[j],0)+(2-l)*max(-beta[j],0) for j in range(4))
def exchange(b,k,h):return add(*(sc(h[l],mon(ap(b,k,l))) for l in range(3)))
def mutation(b,k):
 return S.Matrix(4,2,lambda i,j:-b[i,j] if i==k or j==k else
                 b[i,j]+max(b[i,k],0)*max(b[k,j],0)-max(-b[i,k],0)*max(-b[k,j],0))

rng=random.Random(90214);cases=[]
for attempt in range(70):
 L=S.zeros(4)
 for i in range(4):
  for j in range(i+1,4):L[i,j]=rng.choice([-1,0,1]);L[j,i]=-L[i,j]
 if L.det()!=1 or not L[2,3]:continue
 b=-L.inv()[:,0:2]*2
 if not b[0,1] or not any(b[j,k] for j in [2,3] for k in [0,1]):continue
 cases.append((L,b))
 if len(cases)==3:break
assert len(cases)==3
records=[]
for L,b0 in cases:
 for sign in [1,-1]:
  lam=sign*L;b=sign*b0
  assert b.T*lam==S.Matrix([[2,0,0,0],[0,2,0,0]])
  x,y=mon(e(0)),mon(e(1));xs=exchange(b,0,[1,A,1]);ys=exchange(b,1,[1,B,1])
  bp=mutation(b,0);E=S.eye(4)
  E[0,0]=-1
  for i in range(1,4):E[i,0]=max(-b[i,0],0)
  lp=E.T*lam*E
  assert bp.T*lp==S.Matrix([[2,0,0,0],[0,2,0,0]])
  for j in range(1,4):
   assert mul(xs,mon(e(j)))==sc(v**(2*lp[0,j]),mul(mon(e(j)),xs))
  # Build the new normalized monomial using the actual changed form.
  def newmon(a):
   n=a[0];assert n>=0
   a0=(0,)+a[1:]
   return sc(v**(-form(a0,tuple(n*t for t in e(0)),lp)),mul(mon(a0),power(xs,n)))
  yss=add(*(sc([1,B,1][l],newmon(ap(bp,1,l))) for l in range(3)))
  ns=[ap(b,1,l)[0] for l in range(3)];N=int(abs(b[0,1]));assert max(ns)==N
  cs=[];ds=[]
  for l,n in enumerate(ns):
   F=sc([1,B,1][l],mul(mon(ap(b,1,l)),y))
   cs.append(mul(mon(tuple(-n*t for t in e(0))),F))
   a=ap(bp,1,l);dexp=N-n;assert a[0]==dexp
   a0=(0,)+a[1:]
   # F'=X*^d times a frozen monomial times y; derive that coefficient independently.
   phase=v**(form(a0,tuple(dexp*t for t in e(0)),lp))
   ds.append(sc([1,B,1][l]*phase,mul(mon(a0),y)))
  z=ns.index(0);n0=cs[z];m0=ds[z];phi=mul(m0,invmono(n0))
  assert all(a[0]==0 and a[1]==0 for f in cs+ds+[phi] for a in f)
  corr={};noncomm=False
  for l,n in enumerate(ns):
   if l==z:continue
   prod=mul(power(xs,n),power(x,n))
   g={a:c for a,c in prod.items() if a[1]==0}
   defect=add(prod,sc(-1,g))
   assert all(a[0]==0 and a[1]>=1 for a in defect)
   quotient=mul(mon(tuple(-t for t in e(1))),defect)
   assert mul(y,quotient)==defect
   kappa=mul(mul(mon(tuple(-n*t for t in e(0))),phi),power(x,n))
   assert ds[l]==mul(mul(g,kappa),cs[l]),(lam,b,l,ds[l],mul(mul(g,kappa),cs[l]))
   noncomm |= mul(kappa,cs[l])!=mul(cs[l],kappa)
   corr=add(corr,mul(mul(mul(power(xs,N-n),defect),mul(kappa,cs[l])),invmono(y)))
  assert yss==add(mul(mul(power(xs,N),phi),ys),sc(-1,corr))
  # The frozen coefficient ring itself is noncommutative, independently of whether
  # a particular coefficient pair happens to commute.
  assert mul(mon(e(2)),mon(e(3)))!=mul(mon(e(3)),mon(e(2)))
  records.append(dict(sign=sign,Lambda=str(lam),matrix=str(b),
                      frozen_ring_noncommutative=True,coefficient_pair_noncommutative=noncomm,
                      independently_constructed_second_mutation=True,replacement=True))
output.write_text(json.dumps(records,indent=2),encoding='utf-8')
print(f'{len(records)} exact four-coordinate checks passed, with a noncommutative frozen torus.')
