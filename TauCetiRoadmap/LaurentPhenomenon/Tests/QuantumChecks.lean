/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.Quantum.Specialization
public import Mathlib.LinearAlgebra.Matrix.BilinearForm
public import Mathlib.LinearAlgebra.Matrix.Notation

/-!
# Seed-free half of the Q1 check

Q1's check (`ClusterAlgebras/README.md`, §2.1) takes `Λ = ((0,-1),(1,0))` and `B_ext = (0,1)ᵀ`. The
initial chart is faithful, so its relations can be read in `T(Zv, v, Λ)` itself, where
`X'_1 = X^{-e_1 + e_2} + X^{-e_1}`:

* the quasi-commutation `X_1 X_2 = v^{2Λ_12} X_2 X_1 = v^{-2} X_2 X_1` (§0.4, `q = v²`);
* `X_1 X'_1 = 1 + v⁻¹ X_2` and `X'_1 X_1 = 1 + v X_2`;
* both specialize under the classical limit `sp` (L5) to `1 + x_2`.

The seed-level form, including `(X'_1)² = (1 + v X_2)(1 + v³ X_2) X_1^{-2}`, is in
`ClusterAlgebras/Examples/QuantumChecks.lean`. §§0.4–0.6 state no checks of their own.
-/

@[expose] public section

namespace TauCeti.QuantumTorus.QuantumChecks

open TauCeti TauCeti.QuantumTorus

noncomputable section

/-- `Λ = ((0,-1),(1,0))`. -/
abbrev Λ₁ : LinearMap.BilinForm ℤ (Fin 2 → ℤ) := Matrix.toBilin' !![0, -1; 1, 0]

/-- `T(Zv, v, Λ)`. -/
abbrev T₁ : Type := quantumTorus Zv vUnit Λ₁

/-- `e_1`. -/
abbrev e₁ : Fin 2 → ℤ := Pi.single 0 1

/-- `e_2`. -/
abbrev e₂ : Fin 2 → ℤ := Pi.single 1 1

theorem Λ₁_apply (a b : Fin 2 → ℤ) : Λ₁ a b = a 1 * b 0 - a 0 * b 1 := by
  simp [Matrix.toBilin'_apply, Fin.sum_univ_two]
  ring

theorem vUnit_zpow_val (n : ℤ) : ((vUnit ^ n : Zvˣ) : Zv) = LaurentPolynomial.T n := by
  have h : ∀ m : ℕ, ((vUnit ^ m : Zvˣ) : Zv) = LaurentPolynomial.T m := fun m ↦ by
    rw [Units.val_pow_eq_pow_val, vUnit_val, LaurentPolynomial.T_pow, mul_one]
  cases n with
  | ofNat m => exact h m
  | negSucc m =>
    rw [zpow_negSucc]
    refine Units.inv_eq_of_mul_eq_one_right ?_
    rw [h, ← LaurentPolynomial.T_add, Int.negSucc_eq]
    push_cast
    rw [add_neg_cancel, LaurentPolynomial.T_zero]

theorem monomial_mul_monomial₁ (a b : Fin 2 → ℤ) :
    (monomial a : T₁) * monomial b =
      (LaurentPolynomial.T (a 1 * b 0 - a 0 * b 1) : Zv) • monomial (a + b) := by
  rw [monomial_mul_monomial, vUnit_zpow_val, Λ₁_apply]

/-- `X'_1 = M(-e_1 + [b]_+) + M(-e_1 + [-b]_+)` with `b = e_2`. -/
abbrev X'₁ : T₁ := monomial (-e₁ + e₂) + monomial (-e₁)

/-- **Check (§0.4).** `X_1 X_2 = v^{-2} X_2 X_1`. -/
theorem quasiCommute : (monomial e₁ : T₁) * monomial e₂ =
    (LaurentPolynomial.T (-2) : Zv) • (monomial e₂ * monomial e₁) := by
  rw [monomial_mul_monomial₁, monomial_mul_monomial₁, smul_smul, ← LaurentPolynomial.T_add,
    add_comm e₂]
  norm_num

/-- **Check (Q1).** `X_1 X'_1 = 1 + v⁻¹ X_2`. -/
theorem mul_exchange : (monomial e₁ : T₁) * X'₁ =
    1 + (LaurentPolynomial.T (-1) : Zv) • monomial e₂ := by
  rw [X'₁, mul_add, monomial_mul_monomial₁, monomial_mul_monomial₁, add_neg_cancel_left,
    add_neg_cancel, monomial_zero, add_comm]
  norm_num

/-- **Check (Q1).** `X'_1 X_1 = 1 + v X_2`. -/
theorem exchange_mul : X'₁ * (monomial e₁ : T₁) =
    1 + (LaurentPolynomial.T 1 : Zv) • monomial e₂ := by
  rw [X'₁, add_mul, monomial_mul_monomial₁, monomial_mul_monomial₁, neg_add_cancel_comm,
    neg_add_cancel, monomial_zero, add_comm]
  norm_num

/-- **Check (Q1, L5).** Both exchange products specialize to `1 + x_2`. -/
theorem sp_mul_exchange :
    sp Λ₁ ((monomial e₁ : T₁) * X'₁) = 1 + AddMonoidAlgebra.single e₂ 1 ∧
      sp Λ₁ (X'₁ * (monomial e₁ : T₁)) = 1 + AddMonoidAlgebra.single e₂ 1 := by
  rw [mul_exchange, exchange_mul, map_add, map_add, map_one, sp_smul_monomial,
    sp_smul_monomial, evalOne_T, evalOne_T]
  exact ⟨rfl, rfl⟩

end

end TauCeti.QuantumTorus.QuantumChecks
