"""Exact Laurent-torus arithmetic; no floating point or Laurentness input.

Each value is its finite monomial expansion. Every equality is checked by
expanding Laurent polynomials in the independent scalar parameters.
"""
from pathlib import Path
import argparse
import json
import sympy as S

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--output', type=Path)
output = parser.parse_args().output or Path(__file__).with_name('symbolic-multiterm.json')

v, A, B = S.symbols('v A B')
sign = 1

def clean(f):
    return {a: S.expand(c) for a, c in f.items() if S.expand(c) != 0}

def add(*fs):
    out = {}
    for f in fs:
        for a, c in f.items():
            out[a] = out.get(a, 0) + c
    return clean(out)

def scale(c, f):
    return clean({a: c*b for a, b in f.items()})

def mul(f, g):
    out = {}
    for (a,b), c in f.items():
        for (d,e), h in g.items():
            k = (a+d,b+e)
            out[k] = out.get(k, 0) + c*h*v**(sign*(a*e-b*d))
    return clean(out)

def power(f, n):
    out = one
    for _ in range(n):
        out = mul(out, f)
    return out

def mono(a,b): return {(a,b): S.Integer(1)}
one = mono(0,0)
x, y, yi = mono(1,0), mono(0,1), mono(0,-1)

def coeffs(r, h):
    return [S.Integer(1)] + [h]*(r-1) + [S.Integer(1)]

results = []
for sign in [1,-1]:
    for r1,r2,u1,u2 in [(1,1,1,1),(2,2,1,1),(2,3,1,1),(3,2,1,1),
                         (3,3,1,1),(2,2,2,2)]:
        hs, ks = coeffs(r1,A), coeffs(r2,B)
        xs = add(*(scale(hs[l],mono(-1,l*u1)) for l in range(r1+1)))
        ys = add(*(scale(ks[l],mono(l*u2,-1)) for l in range(r2+1)))
        N = r2*u2
        phi = v**(-sign*N)
        yss = mul(add(*(scale(ks[l]*v**(-sign*(N-l*u2)),
                               power(xs,N-l*u2)) for l in range(r2+1))),yi)
        assert mul(x,y) != mul(y,x)
        assert mul(xs,y) == scale(v**(-2*sign),mul(y,xs))
        expected_first = add(*(scale(hs[l]*v**(-sign*l*u1),mono(0,l*u1))
                               for l in range(r1+1)))
        assert mul(xs,x) == expected_first
        initial_second = add(*(scale(ks[l]*v**(sign*l*u2),power(x,l*u2))
                               for l in range(r2+1)))
        assert mul(ys,y) == initial_second
        corr = {}
        for l in range(1,r2+1):
            n = l*u2
            defect = add(mul(power(xs,n),power(x,n)),scale(-1,one))
            assert all(a==0 and b>=1 for a,b in defect), (sign,r1,r2,l,defect)
            # This quotient is in C[y], not an assumed membership witness.
            quotient = {(a,b-1):c for (a,b),c in defect.items()}
            assert mul(y,quotient) == defect
            c = ks[l]*v**(sign*n)
            d = ks[l]*v**(-sign*(N-n))
            assert S.expand(d-phi*c)==0
            corr = add(corr,mul(scale(phi*c,mul(power(xs,N-n),defect)),yi))
        constructed = add(scale(phi,mul(power(xs,N),ys)),scale(-1,corr))
        assert constructed == yss
        # Specialization is applied to finite coefficient expressions only.
        special = clean({a:c.subs(v,1) for a,c in yss.items()})
        assert all(not c.has(v) for c in special.values())
        X,Y = S.symbols('X Y')
        xs_classical = sum(hs[l]*Y**(l*u1) for l in range(r1+1))/X
        next_classical = sum(ks[l]*xs_classical**(N-l*u2)
                             for l in range(r2+1))/Y
        specialized_expansion = sum(c*X**a*Y**b for (a,b),c in special.items())
        assert S.cancel(specialized_expansion-next_classical) == 0
        results.append(dict(sign=sign,degrees=[r1,r2],column_steps=[u1,u2],
                            output_terms=len(yss),generic_coefficients=True,
                            constructed_defects=True,replacement=True,specialization=True))

out=output
out.write_text(json.dumps({'arithmetic':'exact symbolic Laurent polynomials',
                           'checks':results},indent=2),encoding='utf-8')
print(f'{len(results)} exact generic-coefficient quantum checks passed; {out}')
