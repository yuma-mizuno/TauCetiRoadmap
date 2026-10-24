/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import Mathlib.Algebra.Group.Basic
public import Mathlib.Tactic.Group
public import Mathlib.Tactic.SplitIfs
public import Lean.Elab.Tactic.Omega
public import Mathlib.Tactic.Ring
public import Mathlib.Tactic.FieldSimp

/-! # Seed Compatibility -/

@[expose] public section

namespace TauCeti.Cluster

/-- Integer positive part used by matrix mutation. -/
def positivePart (a : ℤ) : ℤ := max a 0
/-- The positive parts of `a` and `-a` differ by `a`. -/
theorem positivePart_sub_positivePart_neg (a : ℤ) : positivePart a - positivePart (-a) = a := by
  simp only [positivePart]
  rw [max_def, max_def]
  split_ifs <;> omega

/-- The matrix-mutation increment in the positive orientation. -/
theorem matrix_increment_pos (a b : ℤ) (hb : 0 ≤ b) :
    positivePart a * positivePart b - positivePart (-a) * positivePart (-b) =
      b * positivePart a := by
  simp only [positivePart, max_eq_left hb, max_eq_right (by omega : -b ≤ 0), mul_zero,
    sub_zero]
  ring

/-- The matrix-mutation increment in the negative orientation. -/
theorem matrix_increment_neg (a b : ℤ) (hb : b ≤ 0) :
    -(positivePart a * positivePart b - positivePart (-a) * positivePart (-b)) =
      (-b) * positivePart (-a) := by
  simp only [positivePart, max_eq_right hb, max_eq_left (by omega : 0 ≤ -b), mul_zero,
    zero_sub, neg_neg]
  ring

theorem signed_matrix_increment (a b δ d : ℤ) (hδ : δ = 1 ∨ δ = -1)
    (hd : 0 ≤ d) (hb : b = δ * d) :
    δ * (positivePart a * positivePart b - positivePart (-a) * positivePart (-b)) =
      d * positivePart (δ * a) := by
  rcases hδ with rfl | rfl
  · simp only [one_mul] at hb ⊢
    subst b
    exact matrix_increment_pos a d hd
  · simp only [neg_one_mul] at hb ⊢
    subst b
    simpa using matrix_increment_neg a (-d) (by omega)

section Coefficients

variable {G : Type*} [CommGroup G]

/-- Normalized coefficient mutation, with the auxiliary sum denominator explicit. -/
def coefficientMutation (yi yj c : G) (b : ℤ) : G :=
  yi * yj ^ positivePart b * c ^ (-b)

theorem coefficient_ratio_pos (yi yj c : G) (b : ℤ) (hb : 0 ≤ b) :
    coefficientMutation yi yj c b / yi = (yj / c) ^ b := by
  simp only [coefficientMutation, positivePart, max_eq_left hb, div_zpow, zpow_neg]
  simp only [div_eq_mul_inv]
  calc
    _ = (yi * yi⁻¹) * (yj ^ b * (c ^ b)⁻¹) := by ac_rfl
    _ = _ := by simp

theorem coefficient_ratio_neg (yi yj c : G) (b : ℤ) (hb : b ≤ 0) :
    (coefficientMutation yi yj c b / yi)⁻¹ = (1 / c) ^ (-b) := by
  simp only [coefficientMutation, positivePart, max_eq_right hb, zpow_zero, mul_one,
    one_div, inv_zpow]
  simp [div_eq_mul_inv, mul_comm, mul_left_comm, zpow_neg]

theorem coefficient_ratio_signed (yi yj c : G) (b δ d : ℤ)
    (hδ : δ = 1 ∨ δ = -1) (hd : 0 ≤ d) (hb : b = δ * d) :
    (coefficientMutation yi yj c b / yi) ^ δ =
      (if δ = 1 then yj / c else 1 / c) ^ d := by
  rcases hδ with rfl | rfl
  · simp only [one_mul] at hb
    subst b
    simpa using coefficient_ratio_pos yi yj c d hd
  · simp only [neg_one_mul] at hb
    subst b
    simpa using coefficient_ratio_neg yi yj c (-d) (by omega)

end Coefficients

section Correction

variable {K : Type*} [Field K]

/-- The direct C4 correction follows from the coefficient and exponent balance. -/
theorem correction_identity (a b q a' b' y : K) (d : ℕ)
    (hb : b ≠ 0) (hy : y ≠ 0) (hbalance : b' * b = a' * a * q ^ d) :
    a' * y ^ d + b' = (a' / b) * y ^ d * (a * (q / y) ^ d + b) := by
  have hyp : y ^ d ≠ 0 := pow_ne_zero _ hy
  rw [div_pow]
  field_simp
  calc
    _ = a' * b * y ^ d + (b' * b) := by ring
    _ = _ := by rw [hbalance]; ring

end Correction

end TauCeti.Cluster
