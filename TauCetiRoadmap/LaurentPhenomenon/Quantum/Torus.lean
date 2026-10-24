/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCeti.Algebra.MonoidAlgebra.Twisted.Basic
public import Mathlib.Algebra.Polynomial.Laurent

/-!
# Based quantum tori

For a commutative ring `R`, a unit `u : Rˣ`, a lattice `L` and an integral
bilinear form `Λ` on `L`, the based quantum torus `T(R,u,Λ)` is the existing
twisted monoid algebra of `Multiplicative L` for the normalized cocycle
`α(a,b) = u ^ Λ a b`. Its basis elements `X a` multiply by
`X a * X b = u ^ Λ a b • X (a + b)`. No second multiplication or basis theory is
introduced here: both come from `TauCeti.twistedMonoidAlgebra`.

The quantum cluster coefficient ring is `Zv = ℤ[v,v⁻¹]`, with `v` the
Laurent variable.
-/

@[expose] public section

namespace TauCeti

open TwistedMonoidAlgebra in
/-- Over a commutative ring the twisted monoid algebra is a ring. Instance search does not find
`Subalgebra.toRing` here by itself, because the subalgebra is stated over the semiring structure
of `Module.End`. -/
noncomputable instance instRingTwistedMonoidAlgebra {R : Type*} [CommRing R] {G : Type*}
    [Monoid G] (α : G → G → Rˣ) [IsFactorSet α] : Ring (twistedMonoidAlgebra R G α) :=
  @Subalgebra.toRing R (Module.End R (G →₀ R)) _ _ _ (twistedMonoidAlgebra R G α)

end TauCeti

namespace TauCeti.QuantumTorus

open TauCeti TauCeti.TwistedMonoidAlgebra

variable {R : Type*} [CommRing R] {L : Type*} [AddCommGroup L]

/-- The normalized cocycle `α(a,b) = u ^ Λ a b` on `Multiplicative L`. -/
def cocycle (u : Rˣ) (Λ : LinearMap.BilinForm ℤ L) :
    Multiplicative L → Multiplicative L → Rˣ :=
  fun a b ↦ u ^ Λ a.toAdd b.toAdd

instance (u : Rˣ) (Λ : LinearMap.BilinForm ℤ L) : IsFactorSet (cocycle u Λ) where
  cocycle g h j := by
    simp only [cocycle, toAdd_mul, map_add, LinearMap.add_apply, ← zpow_add]
    congr 1
    abel
  one_left g := by simp [cocycle]
  one_right g := by simp [cocycle]

/-- The based quantum torus `T(R,u,Λ)`. -/
abbrev _root_.TauCeti.quantumTorus (R : Type*) [CommRing R] (u : Rˣ)
    {L : Type*} [AddCommGroup L] (Λ : LinearMap.BilinForm ℤ L) : Type _ :=
  twistedMonoidAlgebra R (Multiplicative L) (cocycle u Λ)

variable {u : Rˣ} {Λ : LinearMap.BilinForm ℤ L}

/-- The basis monomial `X ^ a`. -/
noncomputable def monomial (a : L) : quantumTorus R u Λ :=
  of (Multiplicative.ofAdd a)

theorem monomial_mul_monomial (a b : L) :
    (monomial a : quantumTorus R u Λ) * monomial b =
      ((u ^ Λ a b : Rˣ) : R) • monomial (a + b) := by
  simp [monomial, cocycle]

@[simp] theorem monomial_zero : (monomial 0 : quantumTorus R u Λ) = 1 := by
  simp [monomial]

/-- The monomials form an `R`-basis. -/
noncomputable def monomialBasis : Module.Basis L R (quantumTorus R u Λ) :=
  (TwistedMonoidAlgebra.basis R (Multiplicative L) (cocycle u Λ)).reindex
    Multiplicative.toAdd

@[simp] theorem monomialBasis_apply (a : L) :
    (monomialBasis a : quantumTorus R u Λ) = monomial a := by
  simp [monomialBasis, monomial]

end TauCeti.QuantumTorus

namespace TauCeti

/-- The coefficient ring `ℤ[v,v⁻¹]` of quantum cluster algebras. -/
abbrev Zv : Type := LaurentPolynomial ℤ

/-- The quantum parameter `v = q^{1/2}`, as a unit of `Zv`. -/
noncomputable def vUnit : Zvˣ := (LaurentPolynomial.isUnit_T (R := ℤ) 1).unit
@[simp] theorem vUnit_val : (vUnit : Zv) = LaurentPolynomial.T 1 := rfl
end TauCeti
