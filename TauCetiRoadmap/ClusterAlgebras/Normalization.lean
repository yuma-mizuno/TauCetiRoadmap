/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.Coefficients
public import TauCetiRoadmap.ClusterAlgebras.SeedBinomial

/-! # Normalization -/

@[expose] public section

open TauCeti.Laurent

noncomputable section
namespace TauCeti.Cluster
namespace CoefficientSemifield
variable {P : Type*} [CoefficientSemifield P]

/-- Auxiliary addition is compatible with inverting the mutated coefficient. -/
theorem inverse_add_one (y : P) : y⁻¹ + 1 = (y + 1) / y := by
  calc
    y⁻¹ + 1 = (y⁻¹ + 1) * y / y := by simp
    _ = (y + 1) / y := by rw [add_mul, inv_mul_cancel, one_mul, add_comm]

/-- The positive exchange coefficient y divided by its auxiliary sum with one. -/
def normalizedPositive (y : P) : P := y / (y + 1)
/-- The negative exchange coefficient, the inverse of the auxiliary sum of y and one. -/
def normalizedNegative (y : P) : P := 1 / (y + 1)
@[simp] theorem normalizedPositive_inv (y : P) :
    normalizedPositive y⁻¹ = normalizedNegative y := by
  unfold normalizedPositive normalizedNegative
  rw [inverse_add_one]
  simp [div_eq_mul_inv, mul_comm]

@[simp] theorem normalizedNegative_inv (y : P) :
    normalizedNegative y⁻¹ = normalizedPositive y := by
  unfold normalizedPositive normalizedNegative
  rw [inverse_add_one]
  simp [div_eq_mul_inv, mul_comm]

@[simp] theorem normalized_ratio (y : P) :
    normalizedPositive y / normalizedNegative y = y := by
  unfold normalizedPositive normalizedNegative
  simp [div_eq_mul_inv, mul_comm]

/-- Choose the positive normalized coefficient at sign one and the negative coefficient otherwise.
-/
def normalizedSigned (y : P) (δ : ℤ) : P :=
  if δ = 1 then normalizedPositive y else normalizedNegative y

theorem normalizedSigned_ratio (y : P) (δ : ℤ) (hδ : δ = 1 ∨ δ = -1) :
    normalizedSigned y δ / normalizedSigned y (-δ) = y ^ δ := by
  rcases hδ with rfl | rfl
  · simp [normalizedSigned]
  · simp [normalizedSigned, normalizedPositive, normalizedNegative,
      div_eq_mul_inv, mul_comm]

/-- The coefficient part of the exact C8 monomial correction balance. -/
theorem normalized_mutation_balance (yi yj : P) (b δ d : ℤ)
    (hδ : δ = 1 ∨ δ = -1) (hd : 0 ≤ d) (hb : b = δ * d) :
    let yi' := coefficientMutation yi yj (yj + 1) b
    (normalizedSigned yi' (-δ) / normalizedSigned yi (-δ)) *
      normalizedSigned yi δ * normalizedSigned yj δ ^ d = normalizedSigned yi' δ := by
  dsimp only
  let yi' := coefficientMutation yi yj (yj + 1) b
  have hr := coefficient_ratio_signed yi yj (yj + 1) b δ d hδ hd hb
  change (yi' / yi) ^ δ = normalizedSigned yj δ ^ d at hr
  rw [div_zpow] at hr
  have hbalance : (normalizedSigned yi δ / normalizedSigned yi (-δ)) *
      normalizedSigned yj δ ^ d = normalizedSigned yi' δ / normalizedSigned yi' (-δ) := by
    rw [normalizedSigned_ratio yi δ hδ, normalizedSigned_ratio yi' δ hδ, ← hr]
    simp [div_eq_mul_inv, mul_comm]
  change (normalizedSigned yi' (-δ) / normalizedSigned yi (-δ)) *
    normalizedSigned yi δ * normalizedSigned yj δ ^ d = normalizedSigned yi' δ
  calc
    _ = normalizedSigned yi' (-δ) *
        ((normalizedSigned yi δ / normalizedSigned yi (-δ)) * normalizedSigned yj δ ^ d) := by
      simp only [div_eq_mul_inv]
      ac_rfl
    _ = _ := by
      rw [hbalance]
      simp [div_eq_mul_inv]

end CoefficientSemifield

open CoefficientSemifield
variable {P I : Type*} [CoefficientSemifield P] [Finite I] [DecidableEq I]

/-- Normalized seed exchange polynomial with coefficient multiplicities in ℕ[P]. -/
def seedExchange (y : P) (b : I → ℤ) : PositiveLaurent (Additive P) I :=
  AddMonoidAlgebra.single (Additive.ofMul (normalizedPositive y), columnPositiveExponent b) 1 +
    AddMonoidAlgebra.single
      (Additive.ofMul (normalizedNegative y), columnPositiveExponent (fun i => -b i)) 1

omit [DecidableEq I] in
theorem seedExchange_eq_binomial (y : P) (b : I → ℤ) :
    seedExchange y b =
      normalizedExchangeBinomial (Additive.ofMul y) (Additive.ofMul (y + 1)) b := by
  classical
  simp [seedExchange, normalizedExchangeBinomial, normalizedPositive, normalizedNegative]

omit [DecidableEq I] in
/-- Inverting y and reversing the exchange column preserves the *actual*
exchange polynomial; this is the undirected-edge normalization identity. -/
theorem seedExchange_own_mutation (y : P) (b : I → ℤ) :
    seedExchange y⁻¹ (fun i => -b i) = seedExchange y b := by
  simp only [seedExchange, normalizedPositive_inv, normalizedNegative_inv, neg_neg]
  exact add_comm _ _

omit [DecidableEq I] in
theorem seedExchange_ne_zero (y : P) (b : I → ℤ) : seedExchange y b ≠ 0 := by
  classical
  rw [seedExchange_eq_binomial]
  exact normalizedExchangeBinomial_ne_zero _ _ _

omit [DecidableEq I] in
theorem seedExchange_polynomial (y : P) (b : I → ℤ) :
    PositivePolynomialSupport (seedExchange y b) := by
  classical
  rw [seedExchange_eq_binomial]
  exact normalizedExchangeBinomial_polynomial _ _ _

omit [DecidableEq I] in
theorem seedExchange_independent (y : P) (b : I → ℤ) (i : I) (h : b i = 0) :
    PositiveIndependent (seedExchange y b) i := by
  classical
  rw [seedExchange_eq_binomial]
  exact normalizedExchangeBinomial_independent _ _ _ i h

omit [DecidableEq I] in
theorem seedExchange_no_factor (y : P) (b : I → ℤ) :
    PositiveNoVariableFactor (seedExchange y b) := by
  classical
  rw [seedExchange_eq_binomial]
  exact normalizedExchangeBinomial_no_factor _ _ _

omit [Finite I] [DecidableEq I] in
theorem coefficientMutation_involutive (a y : P) (b : ℤ) :
    coefficientMutation (coefficientMutation a y (y + 1) b) y⁻¹ (y⁻¹ + 1) (-b) = a := by
  rw [CoefficientSemifield.inverse_add_one]
  simp only [coefficientMutation, neg_neg, div_zpow, inv_zpow]
  have h : positivePart b - positivePart (-b) = b := by unfold positivePart; omega
  have he : positivePart b + -positivePart (-b) + -b = 0 := by omega
  calc
    _ = a * (y ^ (positivePart b + -positivePart (-b) + -b)) := by
      simp only [zpow_add, zpow_neg, div_eq_mul_inv]
      simp only [← zpow_neg]
      calc
        _ = a * (y ^ positivePart b * y ^ (-positivePart (-b)) * y ^ (-b)) *
            ((y + 1) ^ (-b) * (y + 1) ^ b) := by simp [mul_comm, mul_left_comm, mul_assoc]
        _ = _ := by simp only [← zpow_add]; simp
    _ = a := by rw [he]; simp

end TauCeti.Cluster
