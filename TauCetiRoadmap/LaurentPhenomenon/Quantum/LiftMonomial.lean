/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.Quantum.Lift

/-!
# Comparing lifts on single monomials

The value of `TauCeti.QuantumTorus.lift` on `X ^ a` only involves the generators `U_i` with
`a_i ≠ 0` and the form on vectors supported where `a` is nonzero. Two quasi-commuting families
that agree there send `X ^ a` to the same element (`lift_monomial_congr`). The lift sends
`X_i ^ n` to `U_i ^ n` (`lift_monomial_zsmul_single`).
-/

@[expose] public section

namespace TauCeti.QuantumTorus

open TauCeti

variable {R : Type*} [CommRing R] {A : Type*} [Ring A] [Algebra R A] {M : Type*}

theorem orderedProd_congr {U U' : M → Aˣ} {a : M → ℤ} (h : ∀ i, a i ≠ 0 → U i = U' i)
    (l : List M) : orderedProd U l a = orderedProd U' l a := by
  induction l with
  | nil => rfl
  | cons i l ih =>
    rw [orderedProd_cons, orderedProd_cons, ih]
    by_cases hi : a i = 0
    · simp [hi]
    · rw [h i hi]

variable [DecidableEq M]

theorem listExponent_apply_eq_zero {l : List M} {a : M → ℤ} {i : M} (hi : a i = 0) :
    listExponent l a i = 0 := by
  induction l with
  | nil => rfl
  | cons j l ih =>
    rw [listExponent_cons, Pi.add_apply, ih, add_zero, Pi.smul_apply, smul_eq_mul]
    by_cases hj : j = i
    · subst hj
      simp [hi]
    · simp [Ne.symm hj]

/-- The order correction of `a` only sees the form on vectors supported where `a` is
nonzero. -/
theorem orderCorrection_congr {Λ Λ' : LinearMap.BilinForm ℤ (M → ℤ)} {a : M → ℤ}
    (h : ∀ p q : M → ℤ, (∀ i, a i = 0 → p i = 0) → (∀ i, a i = 0 → q i = 0) →
      Λ p q = Λ' p q)
    (l : List M) : orderCorrection Λ l a = orderCorrection Λ' l a := by
  induction l with
  | nil => rfl
  | cons j l ih =>
    simp only [orderCorrection]
    rw [ih, h]
    · intro i hi
      by_cases hj : j = i
      · subst hj
        simp [hi]
      · simp [Ne.symm hj]
    · intro i hi
      exact listExponent_apply_eq_zero hi

variable [Fintype M] {u : Rˣ}

/-- **Locality of `lift` on a monomial.** If `U_i = U'_i` wherever `a_i ≠ 0` and the forms
agree on vectors supported where `a` is nonzero, the two lifts agree on `X ^ a`. -/
theorem lift_monomial_congr {Λ Λ' : LinearMap.BilinForm ℤ (M → ℤ)} (hΛ : LinearMap.IsAlt Λ)
    (hΛ' : LinearMap.IsAlt Λ') {U U' : M → Aˣ} (hU : IsQuasiCommuting u Λ U)
    (hU' : IsQuasiCommuting u Λ' U') {a : M → ℤ} (hUa : ∀ i, a i ≠ 0 → U i = U' i)
    (hΛa : ∀ p q : M → ℤ, (∀ i, a i = 0 → p i = 0) → (∀ i, a i = 0 → q i = 0) →
      Λ p q = Λ' p q) :
    lift hΛ U hU (monomial a : quantumTorus R u Λ) =
      lift hΛ' U' hU' (monomial a : quantumTorus R u Λ') := by
  rw [lift_monomial, lift_monomial, normalizedProd, normalizedProd,
    orderCorrection_congr hΛa, orderedProd_congr hUa]

/-- `lift` sends `X_i ^ n` to `U_i ^ n`. -/
theorem lift_monomial_zsmul_single {Λ : LinearMap.BilinForm ℤ (M → ℤ)} (hΛ : LinearMap.IsAlt Λ)
    {U : M → Aˣ} (hU : IsQuasiCommuting u Λ U) (i : M) (n : ℤ) :
    lift hΛ U hU (monomial (n • Pi.single i 1) : quantumTorus R u Λ) = ((U i ^ n : Aˣ) : A) := by
  have h : Units.map (lift hΛ U hU : quantumTorus R u Λ →* A)
      (monomialUnit hΛ (Pi.single i 1)) = U i :=
    Units.ext (by simp)
  rw [monomial_zsmul hΛ, ← h, ← map_zpow, Units.coe_map]
  rfl

end TauCeti.QuantumTorus
