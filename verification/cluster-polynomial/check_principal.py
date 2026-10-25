"""Exact checks of degree-weighted principal lifts and a negative example."""
from pathlib import Path
import argparse
import json
import sympy as s

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--output', type=Path)
output = parser.parse_args().output or Path(__file__).with_name('principal-and-negative.json')

records=[]
for n in range(4):
 for trial in range(3):
  r=s.diag(*[i+2 for i in range(n)])
  d=s.diag(*[(i+2)*(trial+i+1) for i in range(n)])
  a=s.zeros(n)
  for i in range(n):
   for j in range(i+1,n):a[i,j]=(i+j+trial)%3-1;a[j,i]=-a[i,j]
  b=a*d;v=r.inv()*d if n else s.zeros(0);lam=s.zeros(2*n)
  if n:lam[:n,n:]=-v;lam[n:,:n]=v;lam[n:,n:]=r.inv()*b.T*v
  ext=b.col_join(r)
  assert lam.T==-lam
  assert all(x.is_Integer for x in lam)
  assert ext.T*lam==d.row_join(s.zeros(n))
  for k in range(n):
   bm=s.Matrix(2*n,n,lambda i,j:-ext[i,j] if i==k or j==k else
      ext[i,j]+max(ext[i,k],0)*max(ext[k,j],0)-max(-ext[i,k],0)*max(-ext[k,j],0))
   assert all(bm[i,j]%r[j,j]==0 for i in range(2*n) for j in range(n))
   e=s.eye(2*n)
   for i in range(2*n):e[i,k]=-1 if i==k else max(-ext[i,k],0)
   lm=e.T*lam*e
   assert lm.T==-lm and bm.T*lm==d.row_join(s.zeros(n))
  records.append(dict(rank=n,trial=trial,integral_alternating_compatible=True,
                      mutation_preserves_column_degrees=True))
x,y=s.symbols('x y');p=1+y+y**3;z=p/x;w=(1+z)/y;t=s.cancel((1+w+w**3)/z)
num,den=s.fraction(t);rem=s.rem(num,p,y)
assert rem!=0
assert s.rem(den,p,y)==0 and s.Poly(p,y).is_irreducible
nonreciprocal = []
for a in [1, 2, 3]:
 p = 1 + a*y + y**3
 z = p/x
 w = (1+z)/y
 t = s.cancel((1+a*w**2+w**3)/z)
 num, den = s.fraction(t)
 assert len(s.Poly(den, x, y).terms()) == 1
 assert s.cancel(t*z - (1+a*w**2+w**3)) == 0
 nonreciprocal.append(dict(coefficient=a, reversal=True, laurent=True))
output.write_text(json.dumps(
 {'principal_cases':records,'arbitrary_fixed_polynomial_failure':str(t),
  'nonzero_remainder':str(rem), 'nonreciprocal_reversal_cases':nonreciprocal},indent=2),encoding='utf-8')
print('12 principal lifts and 3 nonreciprocal reversal cases checked; fixed-rule negative control passed.')
