#!/usr/bin/env python3
"""Exact algebra checks for the fixed Painleve sigma inventory.

Requires SymPy. Run with --output PATH to save JSON, otherwise prints JSON.
The checks verify rational identities and source-coordinate conjugacies; they do
not certify the holomorphic inverse theorem, geometric coverage, or Lean proofs.
All Hamilton equations use q' = K_p, p' = -K_q and hbar = 1.
"""
import sympy as S
import json
from pathlib import Path

q,p,t = S.symbols('q p t')
a,b,c,d = S.symbols('theta0 theta1 thetat thetainf')
th = S.symbols('theta')
s,u,v = S.symbols('s u v')
R = S.Rational
cases={}
cases['I'] = (p**2/2-2*q**3-t*q, p**2/2-2*q**3-t*q, v**2+4*u**3+2*t*u-2*s)
cases['II'] = (p**2/2-(q**2+t/2)*p-th*q, p**2/2-(q**2+t/2)*p-th*q, v**2+4*u**3+2*u*(t*u-s)-th**2/4)
H3=(2*q*q*p*p+2*(-t*q*q+d*q+t)*p-(a+d)*t*q-t*t-(a*a-d*d)/4-p*q)/t
sigma3=S.expand(t*H3+p*q)
E3=(t*v-u)**2-4*(2*s-t*u)*(u*u-4*t*t)-2*(a*a+d*d)*(u*u+4*t*t)+16*a*d*t*u
cases['III_D6_IMS']=(H3,sigma3,E3)
H4=q*p*p+2*(q*q+t*q+a)*p+2*(a+d)*q
sigma4=H4+2*t*(a+d/3)
aa=-2*a-R(2,3)*d
bb=2*a-R(2,3)*d
cc=R(4,3)*d
E4=v*v-4*(t*u-s)**2+4*(u+aa)*(u+bb)*(u+cc)
cases['IV_IMS']=(H4,sigma4,E4)
H5=(q*(q-1)**2*p*p+((a-b+d)/2*(q-1)**2+(a+b)*q*(q-1)-t*q)*p+a*(a+b+d)*q/2)/t
sigma5=S.expand(t*H5)
n1=-(a-b+d)/2
n2=-a
n3=-(a+b+d)/2
E5=t*t*v*v-(s-t*u+2*u*u+(n1+n2+n3)*u)**2+4*u*(u+n1)*(u+n2)*(u+n3)
cases['V_IMS']=(H5,sigma5,E5)
def H6(h, multiplier=1):
 return (q*(q-1)*(q-t)*p*p-(a*(q-1)*(q-t)+b*q*(q-t)+(c-h)*q*(q-1))*p+(a+b+c-d)*(a+b+c+d-multiplier*h)*(q-t)/4+((t-1)*a+t*b)*(c-h)/2)/(t*(t-1))
sigma6=S.cancel(t*(t-1)*H6(0)+(c*c-d*d)*t/4-(a*a+c*c-b*b-d*d)/8)
E6=u*t*t*(t-1)**2*v*v+(2*u*(t*u-s)-u*u+(c*c-d*d)*(b*b-a*a)/16)**2-(u+(c+d)**2/4)*(u+(c-d)**2/4)*(u+(a+b)**2/4)*(u+(a-b)**2/4)
cases['VI_IMS_printed']=(H6(1),sigma6,E6)
cases['VI_IMS_corrected']=(H6(1,2),sigma6,E6)
H7=(q*q*p*p+th*q*p+t*p-q)/t
sigma7=S.expand(t*H7)
E7=t*t*v*v-(th*u-1)**2-4*u*u*(s-t*u)
cases['III_D7']=(H7,sigma7,E7)
H8=(q*q*p*p-q-t/q)/t
sigma8=S.expand(t*H8)
E8=t*t*v*v+4*t*u**3-4*s*u*u+4*u
cases['III_D8']=(H8,sigma8,E8)


import argparse

checks=[]
def check_zero(label, expression):
    residual=S.factor(S.cancel(expression))
    checks.append({'name':label,'pass':residual==0,'residual':str(residual)})
    assert residual == 0, (label, residual)

def scalar_acceleration(K):
    # Eliminate p from q' = 2*a*p+b for K=a*p^2+b*p+c.
    aa=S.diff(K,p,2)/2
    bb=S.diff(K,p).subs(p,0)
    cc=K.subs(p,0)
    return S.cancel(S.diff(aa,q)*(w*w-bb*bb)/(2*aa)
        +S.diff(aa,t)*(w-bb)/aa+bb*S.diff(bb,q)-2*aa*S.diff(cc,q)+S.diff(bb,t))

def rhs_iii(time,position,velocity,alpha,beta,gamma,delta):
    return velocity**2/position-velocity/time+(alpha*position**2+beta)/time+gamma*position**3+delta/position

# The seven small forward identities and their exact Jacobian formulas.
for name,(H,sigma,E) in cases.items():
    if name.startswith('VI_'):
        continue
    qdot=S.diff(H,p)
    pdot=-S.diff(H,q)
    X=lambda f:S.cancel(S.diff(f,t)+qdot*S.diff(f,q)+pdot*S.diff(f,p))
    sigma1=X(sigma)
    sigma2=X(sigma1)
    check_zero(name+': forward sigma identity',E.subs({s:sigma,u:sigma1,v:sigma2},simultaneous=True))
    jac=S.diff(sigma,q)*S.diff(sigma1,p)-S.diff(sigma,p)*S.diff(sigma1,q)
    if name in ('I','II','IV_IMS'):
        expected=-sigma2
    elif name=='III_D6_IMS':
        expected=sigma1-t*sigma2
    else:
        expected=-t*sigma2
    check_zero(name+': reconstruction Jacobian',jac-expected)

# Standard scalar dictionaries, including the coordinate and time rescalings.
w,T=S.symbols('w T')
check_zero('I: standard scalar equation',scalar_acceleration(cases['I'][0])-(6*q*q+t))
check_zero('II: standard scalar equation',scalar_acceleration(cases['II'][0])-(2*q**3+t*q+th-S.Rational(1,2)))
check_zero('III_D6: standard scalar dictionary',scalar_acceleration(cases['III_D6_IMS'][0])-rhs_iii(t,q,w,4*a,4*(1-d),4,-4))
acc=scalar_acceleration(cases['IV_IMS'][0])
rhs=(2*w)**2/(2*(2*q))+S.Rational(3,2)*(2*q)**3+4*t*(2*q)**2+2*(t*t-(2*d-1))*(2*q)-8*a*a/(2*q)
check_zero('IV: standard scalar dictionary Q=2q',2*acc-rhs)
acc=scalar_acceleration(cases['V_IMS'][0])
alpha=(a-b-d)**2/8
beta=-(a-b+d)**2/8
rhs=(1/(2*q)+1/(q-1))*w*w-w/t+(q-1)**2*(alpha*q+beta/q)/(t*t)+(a+b-1)*q/t-q*(q+1)/(2*(q-1))
check_zero('V: standard scalar dictionary',acc-rhs)
acc=scalar_acceleration(cases['VI_IMS_corrected'][0])
alpha=(d-1)**2/2
beta=-a*a/2
gamma=b*b/2
delta=(1-c*c)/2
rhs=(1/q+1/(q-1)+1/(q-t))*w*w/2-(1/t+1/(t-1)+1/(q-t))*w+q*(q-1)*(q-t)*(alpha+beta*t/q**2+gamma*(t-1)/(q-1)**2+delta*t*(t-1)/(q-t)**2)/(t*t*(t-1)**2)
check_zero('VI: corrected standard scalar dictionary',acc-rhs)
for name,Q,alpha,beta,gamma,delta in [('III_D7',T/q,4*(th-1),-8,4,0),('III_D8',q/T,8,-8,0,0)]:
    acc=scalar_acceleration(cases[name][0]).subs(t,T*T)
    Dt=lambda f:S.diff(f,T)+2*T*w*S.diff(f,q)+2*T*acc*S.diff(f,w)
    Q1=Dt(Q)
    Q2=Dt(Q1)
    check_zero(name+': square-time scalar dictionary',Q2-rhs_iii(T,Q,Q1,alpha,beta,gamma,delta))

# The two fixed changes from VDPS09 first-order systems.
r,z=S.symbols('r z')
As=2*z/t
Bs=2*z*z/(t*r)+t*r**3/2+(th-1)*r*r/2-1/t
Xsrc=lambda f:S.diff(f,t)+As*S.diff(f,r)+Bs*S.diff(f,z)
newq=1/r
newp=-z-th*r/2-t*r*r/2
H7=cases['III_D7'][0]
check_zero('D7: VDPS09 q equation conjugacy',Xsrc(newq)-S.diff(H7,p).subs({q:newq,p:newp}))
check_zero('D7: VDPS09 p equation conjugacy',Xsrc(newp)+S.diff(H7,q).subs({q:newq,p:newp}))
As=(2*z+r)/t
Bs=2*z*z/(r*t)+z/t+r*r/t-1
newq=r
newp=(z+r/2)/(r*r)
H8=cases['III_D8'][0]
check_zero('D8: VDPS09 q equation conjugacy',Xsrc(newq)-S.diff(H8,p).subs({q:newq,p:newp}))
check_zero('D8: VDPS09 p equation conjugacy',Xsrc(newp)+S.diff(H8,q).subs({q:newq,p:newp}))
H8source=-z*z/(r*r*t)-z/(r*t)+1/r+r/t
check_zero('D8: time-only Hamiltonian correction',H8.subs({q:newq,p:newp})+H8source-1/(4*t))

# PVI forward identity in sparse polynomial arithmetic, avoiding enormous
# intermediate rational expansions in the four independent parameters.
def pvi_polynomial_identity():
    from sympy.polys.rings import ring
    from sympy.polys.domains import QQ
    ring6,rq,rp,rt,ra,rb,rc,rd=ring('q,p,t,a,b,c,d',QQ)
    denominator=rt*(rt-1)
    def numerator(eps):
        return rq*(rq-1)*(rq-rt)*rp*rp-(ra*(rq-1)*(rq-rt)+rb*rq*(rq-rt)+(rc-eps)*rq*(rq-1))*rp+(ra+rb+rc-rd)*(ra+rb+rc+rd-2*eps)*(rq-rt)/4+((rt-1)*ra+rt*rb)*(rc-eps)/2
    n=numerator(1)
    sigma=numerator(0)+(rc*rc-rd*rd)*rt/4-(ra*ra+rc*rc-rb*rb-rd*rd)/8
    sn1=denominator*sigma.diff(rt)+n.diff(rp)*sigma.diff(rq)-n.diff(rq)*sigma.diff(rp)
    sn2=denominator*sn1.diff(rt)-sn1*denominator.diff(rt)+n.diff(rp)*sn1.diff(rq)-n.diff(rq)*sn1.diff(rp)
    aa=(rc*rc-rd*rd)*(rb*rb-ra*ra)/16
    middle=(2*rt-1)*sn1*sn1-2*sigma*sn1*denominator+aa*denominator*denominator
    product=ring6.one
    for bb in [(rc+rd)**2/4,(rc-rd)**2/4,(ra+rb)**2/4,(ra-rb)**2/4]:
        product*=sn1+bb*denominator
    residual=sn1*sn2*sn2*denominator+middle*middle-product
    checks.append({'name':'VI: corrected forward sigma identity','pass':not residual,'residual_polynomial_terms':len(residual)})
    assert not residual
pvi_polynomial_identity()

# An exact counterexample distinguishes the PVI factors -1 and -2.
H,sigma,E=cases['VI_IMS_printed']
qdot=S.diff(H,p)
pdot=-S.diff(H,q)
u0=S.diff(sigma,t)+qdot*S.diff(sigma,q)+pdot*S.diff(sigma,p)
v0=S.diff(u0,t)+qdot*S.diff(u0,q)+pdot*S.diff(u0,p)
point={q:3,p:2,t:2,a:1,b:2,c:3,d:4}
wrong_residual=S.simplify(E.subs(point).subs({s:sigma.subs(point),u:u0.subs(point),v:v0.subs(point)}))
checks.append({'name':'VI: reject coefficient A+theta_inf-1','pass':wrong_residual==-S.Rational(85995,16),'expected_nonzero_residual':str(wrong_residual),'point':{'q':3,'p':2,'t':2,'theta0':1,'theta1':2,'thetat':3,'thetainf':4}})
assert wrong_residual==-S.Rational(85995,16)

result={'scope':'Exact rational identities for the finite eight-model sigma inventory; no analytic or Lean proof claim.','sympy_version':S.__version__,'check_count':len(checks),'all_passed':all(item['pass'] for item in checks),'checks':checks}
parser=argparse.ArgumentParser()
parser.add_argument('--output',type=Path)
args=parser.parse_args()
payload=json.dumps(result,ensure_ascii=False,indent=2)+'\n'
if args.output:
    args.output.write_text(payload)
    print(json.dumps({'output':str(args.output),'check_count':len(checks),'all_passed':result['all_passed']}))
else:
    print(payload,end='')
