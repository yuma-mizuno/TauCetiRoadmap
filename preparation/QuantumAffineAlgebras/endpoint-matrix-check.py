"""Independent symbolic check of the roadmap's fixed A1-affine conventions."""
import sympy as s

q, a, b, t = s.symbols('q a b t', nonzero=True)
I = s.eye(2)
E = s.Matrix([[0, 1], [0, 0]])
F = E.T
K = s.diag(q, 1/q)

def mod(c):
    return {'e1': E, 'f1': F, 'K1': K, 'e0': c*F, 'f0': E/c, 'K0': K.inv()}

def tensor(c, d):
    x, y = mod(c), mod(d)
    r = {}
    for i in ('0', '1'):
        r['e'+i] = s.kronecker_product(x['e'+i], y['K'+i].inv()) + s.kronecker_product(I, y['e'+i])
        r['f'+i] = s.kronecker_product(x['f'+i], I) + s.kronecker_product(x['K'+i], y['f'+i])
        r['K'+i] = s.kronecker_product(x['K'+i], y['K'+i])
    return r

def clean(x):
    return x.applyfunc(s.factor) if isinstance(x, s.MatrixBase) else s.factor(x)

def require_zero(label, x):
    y = clean(x)
    assert y == s.zeros(*y.shape), (label, y)
    print(label+': zero')

V = mod(a)
for i in ('0', '1'):
    for j in ('0', '1'):
        cij = 2 if i == j else -2
        require_zero('Cartan e '+i+j,V['K'+i]*V['e'+j]*V['K'+i].inv()-q**cij*V['e'+j])
        require_zero('Cartan f '+i+j,V['K'+i]*V['f'+j]*V['K'+i].inv()-q**(-cij)*V['f'+j])
        rhs = (V['K'+i]-V['K'+i].inv())/(q-1/q) if i == j else s.zeros(2)
        require_zero('commutator '+i+j,V['e'+i]*V['f'+j]-V['f'+j]*V['e'+i]-rhs)
    j = '1' if i == '0' else '0'
    for prefix in ('e','f'):
        A,B=V[prefix+i],V[prefix+j]
        require_zero('Serre '+prefix+i+j,A**3*B-(q*q+1+q**-2)*A**2*B*A+(q*q+1+q**-2)*A*B*A**2-B*A**3)
require_zero('level zero',V['K0']*V['K1']-I)

R = s.eye(4)
R[1:3,1:3] = s.Matrix([[q*q-1, q*(1-t)], [q*(1-t), t*(q*q-1)]])/(q*q-t)
ab, ba = tensor(a,b), tensor(b,a)
for name in ab:
    require_zero('intertwining '+name, R.subs(t,b/a)*ab[name]-ba[name]*R.subs(t,b/a))
require_zero('inverse', R.subs(t,1/t)*R-s.eye(4))
require_zero('identity at t=1', R.subs(t,1)-s.eye(4))
print('det R =',clean(R.det()))
print('expected determinant difference =',clean(R.det()-(q*q*t-1)/(q*q-t)))

u = s.Matrix([0,1,-q,0])
ell = u.T
print('e0 u =',clean(ab['e0']*u).T)
print('f0 u =',clean(ab['f0']*u).T)
print('ell e0 =',clean(ell*ab['e0']))
print('ell f0 =',clean(ell*ab['f0']))
require_zero('e1 u',ab['e1']*u)
require_zero('f1 u',ab['f1']*u)
require_zero('ell e1',ell*ab['e1'])
require_zero('ell f1',ell*ab['f1'])

S = s.Matrix([[1,0,0],[0,q,0],[0,1,0],[0,0,1]])
L = s.Matrix([[1,0,0,0],[0,0,1,0],[0,0,0,1]])
z = {}
for name, A in tensor(a,a*q*q).items():
    z[name] = clean(L*A*S)
    require_zero('Z stable under '+name,A*S-S*z[name])
require_zero('Z e0 = aq f1',z['e0']-a*q*z['f1'])
require_zero('Z f0 = (aq)^-1 e1',z['f0']-z['e1']/(a*q))
print('Z e1 =',z['e1'])
print('Z f1 =',z['f1'])
print('Z K1 =',z['K1'])

seed={q:s.Integer(2),a:s.Integer(3),b:s.Integer(5)}
print('fixed seed q=2,a=3,b=5: R =',clean(R.subs(t,b/a).subs(seed)))
print('fixed seed determinant =',clean(R.det().subs(t,b/a).subs(seed)))
print('fixed seed e0 u =',clean((ab['e0']*u).subs(seed)).T)
print('fixed seed f0 u =',clean((ab['f0']*u).subs(seed)).T)

cleared=clean((t-q*q)*R)
pole=clean(cleared.subs(t,q*q).subs(q,2))
zero=clean(R.subs(t,1/(q*q)).subs(q,2))
print('boundary q=2,t=4: (t-q^2)R =',pole)
print('boundary pole rank =',pole.rank())
print('boundary q=2,t=1/4: R =',zero)
print('boundary zero rank =',zero.rank())
require_zero('boundary reverse composite1',pole*zero)
require_zero('boundary reverse composite2',zero*pole)
actual_xy=pole/4
actual_yx=-15*zero
print('q=2,a=3: actual monic-z r_XY =',actual_xy)
print('q=2,a=3: actual monic-z r_YX =',actual_yx)
print('q=2,a=3: denominator d_XY(z)=z-1; d_YX(z)=z-16')
print('All symbolic assertions passed.')
