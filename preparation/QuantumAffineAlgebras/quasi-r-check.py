"""Check the rank-one quasi-R normalization and spectral orientation.

These symbolic matrix identities check the convention-sensitive example in
README 5.1; they are not a proof of the general supplier contract.
"""
import sympy as s

q = s.symbols('q', nonzero=True)
e = s.Matrix([[0, 1], [0, 0]])
f = e.T
K = s.diag(q, q**-1)
I = s.eye(2)
tensor = s.kronecker_product
Xi = s.eye(4) - (q - q**-1) * tensor(e, f)
flip = s.Matrix([[1, 0, 0, 0], [0, 0, 1, 0],
                 [0, 1, 0, 0], [0, 0, 0, 1]])
checks = 0


def equal(label, left, right):
    global checks
    assert (left - right).applyfunc(s.simplify) == s.zeros(*left.shape), label
    checks += 1
    print(f'PASS {label}')


delta_e = tensor(e, K.inv()) + tensor(I, e)
bar_delta_e = tensor(e, K) + tensor(I, e)
delta_f = tensor(f, I) + tensor(K, f)
bar_delta_f = tensor(f, I) + tensor(K.inv(), f)
equal('Xi Delta(e) = barDelta(e) Xi', Xi * delta_e, bar_delta_e * Xi)
equal('Xi Delta(f) = barDelta(f) Xi', Xi * delta_f, bar_delta_f * Xi)
equal('Xi commutes with Delta(K)', Xi * tensor(K, K), tensor(K, K) * Xi)
opposite = flip * Xi.inv() * flip
equal('inverse-swapped nilpotent coefficient', opposite,
      s.eye(4) + (q - q**-1) * tensor(f, e))
# For the middle total-weight-zero space, toral/top normalization is q^-1
# in the KKOP orientation and q in the K02 orientation.
equal('KKOP normalized middle block at spectral ratio 0',
      (flip * opposite)[1:3, 1:3] / q,
      s.Matrix([[1 - q**-2, q**-1], [q**-1, 0]]))
equal('K02 normalized middle block at spectral ratio infinity',
      q * (flip * Xi)[1:3, 1:3],
      s.Matrix([[0, q], [q, 1 - q**2]]))
print(f'{checks} symbolic matrix checks passed; SymPy {s.__version__}.')
