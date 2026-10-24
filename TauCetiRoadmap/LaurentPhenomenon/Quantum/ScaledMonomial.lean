/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.Quantum.Monomial
public import Mathlib.Tactic

/-!
# Scalar-normalized monomials in a quantum chart

These multiplication rules retain the exact central parameter exponent. They
also prove the coefficient identity for intermediate polynomial exchange terms.
-/

@[expose] public section

namespace TauCeti.QuantumTorus

variable {R D L : Type*} [CommRing R] [DivisionRing D] [Algebra R D]
  [AddCommGroup L] {u : Rˣ} {Λ : LinearMap.BilinForm ℤ L}

noncomputable section

/-- A central integral power of the quantum parameter times a chart monomial. -/
def scaledMonomial (χ : quantumTorus R u Λ →ₐ[R] D) (k : ℤ) (a : L) : D :=
  algebraMap R D ((u ^ k : Rˣ) : R) * χ (monomial a)

variable (χ : quantumTorus R u Λ →ₐ[R] D)

theorem scaledMonomial_mul (k l : ℤ) (a b : L) :
    scaledMonomial χ k a * scaledMonomial χ l b =
      scaledMonomial χ (k + l + Λ a b) (a + b) := by
  simp only [scaledMonomial]
  rw [mul_assoc, ← mul_assoc (χ _), ← Algebra.commutes, mul_assoc,
    ← map_mul, monomial_mul_monomial, map_smul, Algebra.smul_def (R := R) (A := D),
    ← mul_assoc, ← mul_assoc, ← map_mul, ← map_mul,
    ← Units.val_mul, ← Units.val_mul, ← zpow_add, ← zpow_add]

theorem scaledMonomial_zero : scaledMonomial χ 0 (0 : L) = 1 := by
  simp [scaledMonomial]

theorem scaledMonomial_inv (hΛ : LinearMap.IsAlt Λ) (k : ℤ) (a : L) :
    (scaledMonomial χ k a)⁻¹ = scaledMonomial χ (-k) (-a) := by
  apply inv_eq_of_mul_eq_one_right
  rw [scaledMonomial_mul]
  simp only [map_neg, hΛ.self_eq_zero a, neg_zero, add_neg_cancel, add_zero]
  exact scaledMonomial_zero χ

theorem scaledMonomial_ne_zero (hΛ : LinearMap.IsAlt Λ) (k : ℤ) (a : L) :
    scaledMonomial χ k a ≠ 0 := by
  apply left_ne_zero_of_mul_eq_one (b := scaledMonomial χ (-k) (-a))
  rw [scaledMonomial_mul]
  simp only [map_neg, hΛ.self_eq_zero a, neg_zero, add_neg_cancel, add_zero]
  exact scaledMonomial_zero χ

theorem scaledMonomial_split (k : ℤ) (a b : L) :
    scaledMonomial χ k a = scaledMonomial χ 0 b *
      scaledMonomial χ (k - Λ b (a - b)) (a - b) := by
  rw [scaledMonomial_mul]
  congr 1
  · ring
  · abel

theorem scaledMonomial_nat_smul (hΛ : LinearMap.IsAlt Λ) (a : L) (n : ℕ) :
    scaledMonomial χ 0 ((n : ℤ) • a) = (χ (monomial a)) ^ n := by
  simpa [scaledMonomial] using congrArg χ (monomial_nsmul hΛ a n)

/-- The ordered coefficient identity for a term whose old exponent is `n` and
new exponent is `N-n`. The divided column `J` commutes with the four displayed
coefficient directions. No exchange membership conclusion is assumed. -/
theorem polynomialReplacement_coefficient (hΛ : LinearMap.IsAlt Λ)
    (e f A U Z J : L) (N n l : ℤ)
    (hJe : Λ J e = 0) (hJA : Λ J A = 0) (hJU : Λ J U = 0) (hJZ : Λ J Z = 0) :
    scaledMonomial χ
        ((N - n) * Λ (Z + l • J + n • A - f) A + Λ (Z + l • J + n • A - f) f)
        (Z + l • J + n • A) =
      scaledMonomial χ (Λ (n • A) (n • e)) (n • A + n • e) *
        (scaledMonomial χ 0 (n • e))⁻¹ *
        (scaledMonomial χ (N * Λ (Z - f) A + Λ (Z - f) f) Z *
          (scaledMonomial χ (Λ (U - f) f) U)⁻¹) *
        scaledMonomial χ 0 (n • e) *
        scaledMonomial χ (Λ (U + l • J - f) f - Λ (n • e) (U + l • J - n • e))
          (U + l • J - n • e) := by
  have hswap (a b : L) : Λ a b = -Λ b a := by
    have := hΛ.neg a b
    omega
  simp only [scaledMonomial_inv χ hΛ, scaledMonomial_mul]
  congr 1
  · simp only [map_add, map_sub, map_neg, map_zsmul, LinearMap.add_apply,
      LinearMap.sub_apply, LinearMap.neg_apply, LinearMap.smul_apply,
      smul_eq_mul, hΛ.self_eq_zero]
    simp only [hswap Z A, hswap f A,
      hswap U e, hswap Z e, hswap e J, hswap A J, hswap U J, hswap Z J,
      hJe, hJA, hJU, hJZ]
    ring
  · module

end
end TauCeti.QuantumTorus
