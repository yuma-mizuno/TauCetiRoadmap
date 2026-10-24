/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.PositiveSubstitution
public import TauCetiRoadmap.LaurentPhenomenon.LaurentEvaluation
public import Mathlib.Tactic.Abel

/-! # Positive Evaluation -/

@[expose] public section

noncomputable section
namespace TauCeti.Laurent
open scoped BigOperators
variable {G I F : Type*} [AddCommGroup G] [DecidableEq I] [Field F]
/-- A coefficient-group exponent paired with a finite mutable integer exponent vector. -/
abbrev LaurentExponent (G I : Type*) := G × (I →₀ ℤ)

/-- Regard an additive unit-valued exponent character as a multiplicative character with values in
F.
-/
def characterMonoidHom (χ : LaurentExponent G I →+ Additive Fˣ) :
    Multiplicative (LaurentExponent G I) →* F where
  toFun t := ((χ t.toAdd).toMul : F)
  map_one' := by simp
  map_mul' a b := by simp

/-- Evaluate natural-coefficient Laurent polynomials using the given exponent character and
natural scalar map.
-/
def positiveEvaluate (χ : LaurentExponent G I →+ Additive Fˣ) :
    PositiveLaurent G I →+* F :=
  AddMonoidAlgebra.liftNCRingHom (Nat.castRingHom F) (characterMonoidHom χ)
    (fun _ _ => Commute.all _ _)

omit [DecidableEq I] in
@[simp] theorem positiveEvaluate_single
    (χ : LaurentExponent G I →+ Additive Fˣ) (t : LaurentExponent G I) (n : ℕ) :
    positiveEvaluate χ (AddMonoidAlgebra.single t n) =
      (n : F) * ((χ t).toMul : F) := by
  simp [positiveEvaluate, characterMonoidHom]

/-- The additive exponent homomorphism reversing the sign of the jth mutable exponent. -/
def reflectionHom (j : I) : (I →₀ ℤ) →+ (I →₀ ℤ) where
  toFun := reflectedExponent j
  map_zero' := by simp [reflectedExponent]
  map_add' a b := by
    simp only [reflectedExponent, Finsupp.add_apply, mul_add, Finsupp.single_add]
    abel

/-- Evaluate only the jth mutable exponent as an integer power of the prescribed unit. -/
def exponentPowerHom (j : I) (u : Fˣ) : LaurentExponent G I →+ Additive Fˣ where
  toFun t := Additive.ofMul (u ^ (t.2 j))
  map_zero' := by simp
  map_add' a b := by simp [zpow_add]

/-- Character obtained by the rational substitution X_j ← q/X_j. -/
def substitutedCharacter (χ : LaurentExponent G I →+ Additive Fˣ) (j : I) (u : Fˣ) :
    LaurentExponent G I →+ Additive Fˣ :=
  χ.comp ((AddMonoidHom.id G).prodMap (reflectionHom j)) + exponentPowerHom j u

omit [DecidableEq I] in
@[simp] theorem substitutedCharacter_apply
    (χ : LaurentExponent G I →+ Additive Fˣ) (j : I) (u : Fˣ)
    (t : LaurentExponent G I) :
    ((substitutedCharacter χ j u t).toMul : F) =
      ((χ (t.1, reflectedExponent j t.2)).toMul : F) * (u : F) ^ (t.2 j) := by
  rcases t with ⟨g, a⟩
  simp [substitutedCharacter, exponentPowerHom, reflectionHom,
    Units.val_zpow_eq_zpow_val]

omit [DecidableEq I] in
/-- Finite positive substitution agrees with rational evaluation on every
    monomial with nonnegative j-exponent. -/
theorem positiveEvaluate_substitutionTerm
    (χ : LaurentExponent G I →+ Additive Fˣ) (q : PositiveLaurent G I)
    (j : I) (u : Fˣ) (hu : (u : F) = positiveEvaluate χ q)
    (t : LaurentExponent G I) (n : ℕ) (ht : 0 ≤ t.2 j) :
    positiveEvaluate χ (positiveSubstitutionTerm q j t n) =
      positiveEvaluate (substitutedCharacter χ j u) (AddMonoidAlgebra.single t n) := by
  simp only [positiveSubstitutionTerm, multiplesHom_apply, map_nsmul, map_mul, map_pow,
    positiveEvaluate_single, substitutedCharacter_apply]
  have hz : (u : F) ^ (t.2 j).toNat = (u : F) ^ (t.2 j) := by
    rw [← zpow_natCast, Int.toNat_of_nonneg ht]
  rw [← hu, hz]
  simp [nsmul_eq_mul]

omit [DecidableEq I] in
/-- The finite expression is precisely evaluation at X_j ← eval(q)/X_j. -/
theorem positiveEvaluate_substitute
    (χ : LaurentExponent G I →+ Additive Fˣ) (E q : PositiveLaurent G I)
    (j : I) (u : Fˣ) (hu : (u : F) = positiveEvaluate χ q)
    (hE : ∀ t ∈ E.coeff.support, 0 ≤ t.2 j) :
    positiveEvaluate χ (positiveSubstitute E q j) =
      positiveEvaluate (substitutedCharacter χ j u) E := by
  classical
  calc
    _ = ∑ t ∈ E.coeff.support,
        positiveEvaluate χ (positiveSubstitutionTerm q j t (E.coeff t)) := by
      simp only [positiveSubstitute, Finsupp.sum, map_sum]
    _ = ∑ t ∈ E.coeff.support,
        positiveEvaluate (substitutedCharacter χ j u)
          (AddMonoidAlgebra.single t (E.coeff t)) := by
      apply Finset.sum_congr rfl
      intro t ht
      exact positiveEvaluate_substitutionTerm χ q j u hu t _ (hE t ht)
    _ = positiveEvaluate (substitutedCharacter χ j u) E := by
      rw [← map_sum]
      congr 1
      exact AddMonoidAlgebra.sum_coeff_single E

omit [DecidableEq I] in
@[simp] theorem reflectedExponent_self (j : I) :
    reflectedExponent j (Finsupp.single j 1) = -Finsupp.single j 1 := by
  classical
  ext i
  by_cases hi : j = i
  · subst i
    simp [reflectedExponent]
  · simp [reflectedExponent, hi]

omit [DecidableEq I] in
/-- The changed character really sends the j-th variable to q/X_j. -/
theorem substitutedCharacter_variable_self
    (χ : LaurentExponent G I →+ Additive Fˣ) (j : I) (u : Fˣ) :
    ((substitutedCharacter χ j u (0, Finsupp.single j 1)).toMul : F) =
      (u : F) / ((χ (0, Finsupp.single j 1)).toMul : F) := by
  classical
  rw [substitutedCharacter_apply, reflectedExponent_self]
  have he : ((0, -(Finsupp.single j 1 : I →₀ ℤ)) : LaurentExponent G I) =
      -((0, Finsupp.single j 1) : LaurentExponent G I) := by simp
  rw [he, map_neg]
  simp [div_eq_mul_inv, mul_comm]

omit [DecidableEq I] in
/-- Coefficients are unchanged by the substitution. -/
theorem substitutedCharacter_coefficient
    (χ : LaurentExponent G I →+ Additive Fˣ) (j : I) (u : Fˣ) (g : G) :
    substitutedCharacter χ j u (g, 0) = χ (g, 0) := by
  simp [substitutedCharacter, exponentPowerHom, reflectionHom, reflectedExponent]

omit [DecidableEq I] in
/-- All other mutable variables are unchanged. -/
theorem substitutedCharacter_variable_other
    (χ : LaurentExponent G I →+ Additive Fˣ) (j k : I) (hkj : k ≠ j) (u : Fˣ) :
    substitutedCharacter χ j u (0, Finsupp.single k 1) =
      χ (0, Finsupp.single k 1) := by
  simp [substitutedCharacter, exponentPowerHom, reflectionHom, reflectedExponent, hkj]

/-- The Laurent character determined by coefficient units and initial-chart units. -/
def chartCharacter (c : G →+ Additive Fˣ) (x : I → Fˣ) :
    LaurentExponent G I →+ Additive Fˣ where
  toFun t := c t.1 + LaurentEvaluation.exponentCharacter x t.2
  map_zero' := by simp
  map_add' a b := by simp only [Prod.fst_add, Prod.snd_add, map_add]; abel

omit [DecidableEq I] in
@[simp] theorem chartCharacter_variable (c : G →+ Additive Fˣ) (x : I → Fˣ) (i : I) :
    chartCharacter c x (0, Finsupp.single i 1) = Additive.ofMul (x i) := by
  simp [chartCharacter]

omit [DecidableEq I] in
@[simp] theorem chartCharacter_coefficient (c : G →+ Additive Fˣ) (x : I → Fˣ) (g : G) :
    chartCharacter c x (g, 0) = c g := by
  simp [chartCharacter]

omit [DecidableEq I] in
theorem LaurentEvaluation.exponentCharacter_value (x : I → Fˣ) (a : I →₀ ℤ) :
    ((LaurentEvaluation.exponentCharacter x a).toMul : F) = ∏ i ∈ a.support, (x i : F) ^ (a i) := by
  classical
  simp [LaurentEvaluation.exponentCharacter, Finsupp.liftAddHom_apply, Finsupp.sum,
    LaurentEvaluation.integerPower, Units.val_zpow_eq_zpow_val]

omit [DecidableEq I] in
theorem chartCharacter_value (c : G →+ Additive Fˣ) (x : I → Fˣ)
    (g : G) (a : I →₀ ℤ) :
    ((chartCharacter c x (g, a)).toMul : F) =
      ((c g).toMul : F) * ∏ i ∈ a.support, (x i : F) ^ (a i) := by
  simp [chartCharacter, LaurentEvaluation.exponentCharacter_value]

end TauCeti.Laurent
