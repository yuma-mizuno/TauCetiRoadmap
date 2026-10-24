/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.HatY
public import TauCetiRoadmap.ClusterAlgebras.ExpressionCoordinates

/-! Positive principal coordinate expressions and their coefficient specialization. -/

@[expose] public section

namespace TauCeti.Cluster
open TauCeti.Laurent
noncomputable section

variable {G H F : Type*} [AddCommGroup G] [AddCommGroup H] [Field F]

/-- Map the exponent group of every positive atom, preserving addition, multiplication, and
inversion.
-/
def positiveExpressionMapDomain (φ : G →+ H) :
    PositiveExpression G → PositiveExpression H
  | .atom p hp => .atom (AddMonoidAlgebra.mapDomainRingHom ℕ φ p)
      (positive_mapDomain_ne_zero φ hp)
  | .add a b => .add (positiveExpressionMapDomain φ a)
      (positiveExpressionMapDomain φ b)
  | .mul a b => .mul (positiveExpressionMapDomain φ a)
      (positiveExpressionMapDomain φ b)
  | .inv a => .inv (positiveExpressionMapDomain φ a)

theorem positiveExpressionMapDomain_evaluate (φ : G →+ H)
    (ψ : AddMonoidAlgebra ℤ H →+* F) (a : PositiveExpression G) :
    (positiveExpressionMapDomain φ a).evaluate ψ =
      a.evaluate (ψ.comp (AddMonoidAlgebra.mapDomainRingHom ℤ φ)) := by
  induction a with
  | atom p hp =>
      change ψ (positiveCast (AddMonoidAlgebra.mapDomainRingHom ℕ φ p)) =
        ψ (AddMonoidAlgebra.mapDomainRingHom ℤ φ (positiveCast p))
      congr 1
      exact RingHom.congr_fun
        (AddMonoidAlgebra.mapRingHom_comp_mapDomainRingHom
          (Nat.castRingHom ℤ) φ) p
  | add a b ha hb => simp [positiveExpressionMapDomain, PositiveExpression.evaluate, ha, hb]
  | mul a b ha hb => simp [positiveExpressionMapDomain, PositiveExpression.evaluate, ha, hb]
  | inv a ha => simp [positiveExpressionMapDomain, PositiveExpression.evaluate, ha]

variable {I V P : Type*} [Fintype I] [DecidableEq I]
  [CoefficientSemifield P]

/-- The principal coordinate expression with every initial mutable variable specialized to one. -/
def principalWordFExpression
    (N : NormalizedMutationPattern (Trop I) I V)
    (s : V) (w : List I) (j : I) : PositiveExpression (Additive (Trop I)) :=
  positiveExpressionMapDomain
    (AddMonoidHom.fst (Additive (Trop I)) (I →₀ ℤ))
    (N.wordExpressions s w j)

/-- Evaluate the principal F-expression in a target coefficient semifield along eta. -/
def principalWordFValue
    (N : NormalizedMutationPattern (Trop I) I V)
    (η : Additive (Trop I) →+ Additive P)
    (s : V) (w : List I) (j : I) : P :=
  positiveExpressionEvaluateAt η (principalWordFExpression N s w j)

theorem principalWordFExpression_universal
    (N : NormalizedMutationPattern (Trop I) I V)
    (s : V) (w : List I) (j : I) :
    (principalWordFExpression N s w j).evaluate
      (algebraMap (AddMonoidAlgebra ℤ (Additive (Trop I)))
        (FractionRing (AddMonoidAlgebra ℤ (Additive (Trop I))))) =
      N.wordCoordinates principalAtOne s w j := by
  rw [principalWordFExpression, positiveExpressionMapDomain_evaluate]
  simpa only [principalAtOne, principalAtOneCoefficientMap] using
    N.wordExpressions_evaluate principalAtOne s w j

theorem principalY_universal_at_one
    (N : NormalizedMutationPattern (Trop I) I V)
    (s : V) (hy0 : ∀ i, N.coefficient s i = Trop.generator i)
    (w : List I) (j : I) :
    ((mutateWord UniversalYSeed.mutate w
      (principalYInitial (N.matrix s))).coefficient j).evaluate
        (algebraMap (AddMonoidAlgebra ℤ (Additive (Trop I)))
          (FractionRing (AddMonoidAlgebra ℤ (Additive (Trop I))))) =
      (coefficientFieldMap principalAtOne)
          (N.coefficient (mutateWord N.mutation w s) j) *
        ∏ i, (N.wordCoordinates principalAtOne s w i) ^
          (N.matrix (mutateWord N.mutation w s) i j) := by
  let ψ : AddMonoidAlgebra ℤ (Additive (Trop I)) →+*
      FractionRing (AddMonoidAlgebra ℤ (Additive (Trop I))) := algebraMap _ _
  have h := universalY_field_matches_hatY_word N principalAtOne
    (by
      intro p hp
      apply principalAtOne_positive_ne_zero p
      intro hz
      apply hp
      simp [hz]) ψ
    (principalYInitial (N.matrix s))
    (s, PositivePoint.initial principalAtOne) rfl
    (by
      intro i
      have hi : (PositivePoint.initial principalAtOne).val =
          (fun _ => (1 : FractionRing (AddMonoidAlgebra ℤ (Additive (Trop I))))) :=
        funext principalAtOne_initialVariables
      rw [hi]
      simp [principalYInitial, PositiveExpression.evaluate, positiveCast,
        hatY, columnMonomial, hy0 i, coefficientFieldMap,
        principalAtOne, principalAtOneCoefficientMap, ψ]) w
  simpa only [hatY, columnMonomial, N.mutateWord_data,
    NormalizedMutationPattern.wordCoordinates, ψ] using h.2 j

/-- The universal positive expression for a principal hat-y value after the given mutation word. -/
def principalYFExpression
    (N : NormalizedMutationPattern (Trop I) I V)
    (s : V) (w : List I) (j : I) : PositiveExpression (Additive (Trop I)) :=
  .mul
    (.atom (AddMonoidAlgebra.single
      (Additive.ofMul (N.coefficient (mutateWord N.mutation w s) j)) 1)
      (AddMonoidAlgebra.single_eq_zero.not.mpr one_ne_zero))
    (PositiveExpression.product Finset.univ (fun i =>
      PositiveExpression.powInt (principalWordFExpression N s w i)
        (N.matrix (mutateWord N.mutation w s) i j)))

theorem principalYFExpression_evaluate_field
    (N : NormalizedMutationPattern (Trop I) I V)
    (s : V) (w : List I) (j : I) :
    (principalYFExpression N s w j).evaluate
      (algebraMap (AddMonoidAlgebra ℤ (Additive (Trop I)))
        (FractionRing (AddMonoidAlgebra ℤ (Additive (Trop I))))) =
      (coefficientFieldMap principalAtOne)
          (N.coefficient (mutateWord N.mutation w s) j) *
        ∏ i, (N.wordCoordinates principalAtOne s w i) ^
          (N.matrix (mutateWord N.mutation w s) i j) := by
  simp only [principalYFExpression, PositiveExpression.evaluate,
    PositiveExpression.evaluate_product, PositiveExpression.evaluate_powInt,
    principalWordFExpression_universal]
  congr 1
  simp [positiveCast, coefficientFieldMap,
    principalAtOne, principalAtOneCoefficientMap]

theorem principalYFExpression_evaluate_coefficient
    (N : NormalizedMutationPattern (Trop I) I V)
    (η : Additive (Trop I) →+ Additive P)
    (s : V) (w : List I) (j : I) :
    positiveExpressionEvaluateAt η (principalYFExpression N s w j) =
      (η (Additive.ofMul (N.coefficient (mutateWord N.mutation w s) j))).toMul *
        ∏ i, (principalWordFValue N η s w i) ^
          (N.matrix (mutateWord N.mutation w s) i j) := by
  simp [principalYFExpression, positiveExpressionEvaluateAt_mul,
    positiveExpressionEvaluateAt_product, positiveExpressionEvaluateAt_powInt,
    positiveExpressionEvaluateAt_atom_single, principalWordFValue]

theorem principalY_separation_aux
    (N : NormalizedMutationPattern (Trop I) I V)
    (s : V) (hy0 : ∀ i, N.coefficient s i = Trop.generator i)
    (η : Additive (Trop I) →+ Additive P)
    (w : List I) (j : I) :
    positiveExpressionEvaluateAt η
      ((mutateWord UniversalYSeed.mutate w
        (principalYInitial (N.matrix s))).coefficient j) =
      (η (Additive.ofMul (N.coefficient (mutateWord N.mutation w s) j))).toMul *
        ∏ i, (principalWordFValue N η s w i) ^
          (N.matrix (mutateWord N.mutation w s) i j) := by
  calc
    _ = positiveExpressionEvaluateAt η (principalYFExpression N s w j) := by
      apply positiveExpressionEvaluateAt_eq_of_universal_eq
      exact (principalY_universal_at_one N s hy0 w j).trans
        (principalYFExpression_evaluate_field N s w j).symm
    _ = _ := principalYFExpression_evaluate_coefficient N η s w j

/-- The positive expression representing a single tropical coefficient monomial. -/
def tropicalAtom (p : Trop I) : PositiveExpression (Additive (Trop I)) :=
  .atom (AddMonoidAlgebra.single (Additive.ofMul p) 1)
    (AddMonoidAlgebra.single_eq_zero.not.mpr one_ne_zero)

omit [DecidableEq I] [Fintype I] in
theorem tropicalAtom_evaluate_field (p : Trop I) :
    (tropicalAtom p).evaluate
      (algebraMap (AddMonoidAlgebra ℤ (Additive (Trop I)))
        (FractionRing (AddMonoidAlgebra ℤ (Additive (Trop I))))) =
      (coefficientFieldMap principalAtOne) p := by
  simp [tropicalAtom, PositiveExpression.evaluate, positiveCast,
    coefficientFieldMap, principalAtOne, principalAtOneCoefficientMap]

omit [DecidableEq I] [Fintype I] in
theorem tropicalAtom_evaluate_coefficient (η : Additive (Trop I) →+ Additive P)
    (p : Trop I) :
    positiveExpressionEvaluateAt η (tropicalAtom p) =
      (η (Additive.ofMul p)).toMul := by
  simpa [tropicalAtom] using
    positiveExpressionEvaluateAt_atom_single η (Additive.ofMul p)

/-- The positive recurrence expression for the next principal F-coordinate in direction k. -/
def principalWordFStepExpression
    (N : NormalizedMutationPattern (Trop I) I V)
    (s : V) (w : List I) (k : I) : PositiveExpression (Additive (Trop I)) :=
  let t := mutateWord N.mutation w s
  let plus := PositiveExpression.product Finset.univ (fun i =>
    PositiveExpression.powInt (principalWordFExpression N s w i)
      (positivePart (N.matrix t i k)))
  let minus := PositiveExpression.product Finset.univ (fun i =>
    PositiveExpression.powInt (principalWordFExpression N s w i)
      (positivePart (-N.matrix t i k)))
  .mul
    (.add (.mul (tropicalAtom (N.coefficient t k)) plus) minus)
    (.inv (.mul (tropicalAtom (N.coefficient t k + 1))
      (principalWordFExpression N s w k)))

theorem principalWordFStepExpression_evaluate_field
    (N : NormalizedMutationPattern (Trop I) I V)
    (s : V) (w : List I) (k : I) :
    (principalWordFStepExpression N s w k).evaluate
      (algebraMap (AddMonoidAlgebra ℤ (Additive (Trop I)))
        (FractionRing (AddMonoidAlgebra ℤ (Additive (Trop I))))) =
      ((coefficientFieldMap principalAtOne)
          (N.coefficient (mutateWord N.mutation w s) k) *
          ∏ i, (N.wordCoordinates principalAtOne s w i) ^
            positivePart (N.matrix (mutateWord N.mutation w s) i k) +
        ∏ i, (N.wordCoordinates principalAtOne s w i) ^
            positivePart (-N.matrix (mutateWord N.mutation w s) i k)) /
        ((coefficientFieldMap principalAtOne)
            (N.coefficient (mutateWord N.mutation w s) k + 1) *
          N.wordCoordinates principalAtOne s w k) := by
  simp only [principalWordFStepExpression, PositiveExpression.evaluate,
    tropicalAtom_evaluate_field, PositiveExpression.evaluate_product,
    PositiveExpression.evaluate_powInt,
    principalWordFExpression_universal]
  ring

theorem principalWordFStepExpression_evaluate_coefficient
    (N : NormalizedMutationPattern (Trop I) I V)
    (η : Additive (Trop I) →+ Additive P)
    (s : V) (w : List I) (k : I) :
    positiveExpressionEvaluateAt η (principalWordFStepExpression N s w k) =
      ((η (Additive.ofMul (N.coefficient (mutateWord N.mutation w s) k))).toMul *
          ∏ i, (principalWordFValue N η s w i) ^
            positivePart (N.matrix (mutateWord N.mutation w s) i k) +
        ∏ i, (principalWordFValue N η s w i) ^
            positivePart (-N.matrix (mutateWord N.mutation w s) i k)) /
        ((η (Additive.ofMul (N.coefficient (mutateWord N.mutation w s) k + 1))).toMul *
          principalWordFValue N η s w k) := by
  simp only [principalWordFStepExpression, positiveExpressionEvaluateAt_mul,
    positiveExpressionEvaluateAt_add, positiveExpressionEvaluateAt_inv,
    tropicalAtom_evaluate_coefficient,
    positiveExpressionEvaluateAt_product,
    positiveExpressionEvaluateAt_powInt, principalWordFValue]
  simp [div_eq_mul_inv]

theorem principalWordFValue_mutate_self
    (N : NormalizedMutationPattern (Trop I) I V)
    (η : Additive (Trop I) →+ Additive P)
    (s : V) (w : List I) (k : I) :
    principalWordFValue N η s (w ++ [k]) k =
      ((η (Additive.ofMul (N.coefficient (mutateWord N.mutation w s) k))).toMul *
          ∏ i, (principalWordFValue N η s w i) ^
            positivePart (N.matrix (mutateWord N.mutation w s) i k) +
        ∏ i, (principalWordFValue N η s w i) ^
            positivePart (-N.matrix (mutateWord N.mutation w s) i k)) /
        ((η (Additive.ofMul (N.coefficient (mutateWord N.mutation w s) k + 1))).toMul *
          principalWordFValue N η s w k) := by
  let ψ : AddMonoidAlgebra ℤ (Additive (Trop I)) →+*
      FractionRing (AddMonoidAlgebra ℤ (Additive (Trop I))) := algebraMap _ _
  have hx : ∀ i, N.wordCoordinates principalAtOne s w i ≠ 0 := by
    intro i
    rw [← N.wordExpressions_evaluate principalAtOne s w i]
    exact expression_evaluate_ne_zero principalAtOne
      (by
        intro p hp
        apply principalAtOne_positive_ne_zero p
        intro hz
        apply hp
        simp [hz]) (N.wordExpressions s w i)
  have hfield : N.wordCoordinates principalAtOne s (w ++ [k]) k =
      ((coefficientFieldMap principalAtOne)
          (N.coefficient (mutateWord N.mutation w s) k) *
          ∏ i, (N.wordCoordinates principalAtOne s w i) ^
            positivePart (N.matrix (mutateWord N.mutation w s) i k) +
        ∏ i, (N.wordCoordinates principalAtOne s w i) ^
            positivePart (-N.matrix (mutateWord N.mutation w s) i k)) /
        ((coefficientFieldMap principalAtOne)
            (N.coefficient (mutateWord N.mutation w s) k + 1) *
          N.wordCoordinates principalAtOne s w k) := by
    have h := congrArg (fun z : I → FractionRing
      (AddMonoidAlgebra ℤ (Additive (Trop I))) => z k)
      (N.wordCoordinates_append_single principalAtOne s w k)
    rw [h]
    simp only [mutateCoordinateValues, Function.update_self]
    change coordinateEvaluate principalAtOne
      (seedExchange (N.coefficient (mutateWord N.mutation w s) k)
        (fun i => N.matrix (mutateWord N.mutation w s) i k))
      (N.wordCoordinates principalAtOne s w) /
        N.wordCoordinates principalAtOne s w k = _
    rw [coordinateEvaluate_seedExchange_actual]
    simp only [positiveColumnMonomial, negativeColumnMonomial]
    ring
  unfold principalWordFValue
  calc
    positiveExpressionEvaluateAt η (principalWordFExpression N s (w ++ [k]) k) =
        positiveExpressionEvaluateAt η (principalWordFStepExpression N s w k) := by
      apply positiveExpressionEvaluateAt_eq_of_universal_eq
      rw [principalWordFExpression_universal,
        principalWordFStepExpression_evaluate_field]
      exact hfield
    _ = _ := principalWordFStepExpression_evaluate_coefficient N η s w k

theorem principalWordFValue_mutate_other
    (N : NormalizedMutationPattern (Trop I) I V)
    (η : Additive (Trop I) →+ Additive P)
    (s : V) (w : List I) (k j : I) (hjk : j ≠ k) :
    principalWordFValue N η s (w ++ [k]) j =
      principalWordFValue N η s w j := by
  unfold principalWordFValue
  apply positiveExpressionEvaluateAt_eq_of_universal_eq
  rw [principalWordFExpression_universal,
    principalWordFExpression_universal]
  have h := congrArg (fun z : I → FractionRing
    (AddMonoidAlgebra ℤ (Additive (Trop I))) => z j)
    (N.wordCoordinates_append_single principalAtOne s w k)
  simpa [mutateCoordinateValues, Function.update_of_ne hjk] using h

omit [Fintype I] in
theorem normalizedPattern_matrix_word_eq {V' : Type*}
    (N : NormalizedMutationPattern (Trop I) I V)
    (M : NormalizedMutationPattern P I V')
    (s : V) (t : V') (hB : N.matrix s = M.matrix t)
    (w : List I) :
    N.matrix (mutateWord N.mutation w s) =
      M.matrix (mutateWord M.mutation w t) := by
  induction w generalizing s t with
  | nil => exact hB
  | cons k w ih =>
      apply ih (N.mutation k s) (M.mutation k t)
      rw [N.matrix_law, M.matrix_law, hB]

/-- Coefficient separation at every seed: the arbitrary normalized coefficient
is its tropical principal counterpart times the column monomial in F-values. -/
theorem principal_coefficient_separation {V' : Type*}
    (N : NormalizedMutationPattern (Trop I) I V)
    (M : NormalizedMutationPattern P I V')
    (s : V) (t : V') (hB : N.matrix s = M.matrix t)
    (hy0 : ∀ i, N.coefficient s i = Trop.generator i)
    (w : List I) (j : I) :
    M.coefficient (mutateWord M.mutation w t) j =
      ((principalCoefficientHom (M.coefficient t))
        (Additive.ofMul (N.coefficient (mutateWord N.mutation w s) j))).toMul *
        ∏ i, (principalWordFValue N
          (principalCoefficientHom (M.coefficient t)) s w i) ^
          (M.matrix (mutateWord M.mutation w t) i j) := by
  have hw := normalizedPattern_matrix_word_eq N M s t hB w
  rw [← principalY_coefficient_word M t w j]
  rw [← hB]
  rw [principalY_separation_aux N s hy0]
  rw [hw]

theorem principalWordFValue_nil
    (N : NormalizedMutationPattern (Trop I) I V)
    (η : Additive (Trop I) →+ Additive P)
    (s : V) (j : I) :
    principalWordFValue N η s [] j = 1 := by
  unfold principalWordFValue
  calc
    _ = positiveExpressionEvaluateAt η
        (PositiveExpression.one (G := Additive (Trop I))) := by
      apply positiveExpressionEvaluateAt_eq_of_universal_eq
      rw [principalWordFExpression_universal]
      simp [PositiveExpression.evaluate_one, principalAtOne_initialVariables]
    _ = 1 := positiveExpressionEvaluateAt_one η

/-- Evaluate principal Laurent coefficients through the target coefficient-group map and then
through f.
-/
def principalToTarget (η : Additive (Trop I) →+ Additive P)
    (f : TotalLaurentRing (Additive P) I →+* F) :
    TotalLaurentRing (Additive (Trop I)) I →+* F :=
  f.comp (finiteCoefficientSpecialization η)

omit [DecidableEq I] [Fintype I] in
theorem principalToTarget_positive_ne_zero
    (η : Additive (Trop I) →+ Additive P)
    (f : TotalLaurentRing (Additive P) I →+* F)
    (hf : ∀ p, positiveCast p ≠ 0 → f (positiveCast p) ≠ 0)
    (p : PositiveLaurent (Additive (Trop I)) I)
    (hp : positiveCast p ≠ 0) :
    principalToTarget η f (positiveCast p) ≠ 0 :=
  finiteCoefficientSpecialization_positive_ne_zero η f hf
    (by
      intro h
      apply hp
      simp [h])

omit [DecidableEq I] [Fintype I] in
theorem principalToTarget_initialVariables
    (η : Additive (Trop I) →+ Additive P)
    (f : TotalLaurentRing (Additive P) I →+* F) (i : I) :
    initialVariables (principalToTarget η f) i = initialVariables f i := by
  simp [principalToTarget, initialVariables, finiteCoefficientSpecialization]

omit [DecidableEq I] [Fintype I] in
theorem principalToTarget_coefficient
    (η : Additive (Trop I) →+ Additive P)
    (f : TotalLaurentRing (Additive P) I →+* F) (p : Trop I) :
    coefficientFieldMap (principalToTarget η f) p =
      coefficientFieldMap f ((η (Additive.ofMul p)).toMul) := by
  simp [coefficientFieldMap, principalToTarget,
    finiteCoefficientSpecialization]

omit [DecidableEq I] in
theorem coefficientColumnMonomial_eq_ratio
    (d : I → P) (B : I → I → ℤ) (k : I) :
    (∏ i, d i ^ (B i k)) =
      (∏ i, d i ^ positivePart (B i k)) /
        (∏ i, d i ^ positivePart (-B i k)) := by
  rw [← Finset.prod_div_distrib]
  apply Finset.prod_congr rfl
  intro i hi
  have hpart : positivePart (B i k) - positivePart (-B i k) = B i k := by
    unfold positivePart
    omega
  rw [div_eq_mul_inv, ← zpow_sub, hpart]

omit [DecidableEq I] in
theorem fieldMonomial_factor
    (e : P →* F) (d : I → P) (x n : I → F)
    (h : ∀ i, n i = e (d i) * x i) (b : I → ℤ) :
    (∏ i, n i ^ b i) =
      e (∏ i, d i ^ b i) * ∏ i, x i ^ b i := by
  simp_rw [h, mul_zpow]
  rw [map_prod, Finset.prod_mul_distrib]
  simp_rw [map_zpow]

theorem principal_coefficient_separation_field {V' : Type*}
    (N : NormalizedMutationPattern (Trop I) I V)
    (M : NormalizedMutationPattern P I V')
    (e : P →* F)
    (s : V) (t : V') (hB : N.matrix s = M.matrix t)
    (hy0 : ∀ i, N.coefficient s i = Trop.generator i)
    (w : List I) (j : I) :
    e (M.coefficient (mutateWord M.mutation w t) j) =
      e (((principalCoefficientHom (M.coefficient t))
        (Additive.ofMul (N.coefficient (mutateWord N.mutation w s) j))).toMul) *
        (∏ i, e (principalWordFValue N
          (principalCoefficientHom (M.coefficient t)) s w i) ^
          positivePart (M.matrix (mutateWord M.mutation w t) i j)) /
        (∏ i, e (principalWordFValue N
          (principalCoefficientHom (M.coefficient t)) s w i) ^
          positivePart (-M.matrix (mutateWord M.mutation w t) i j)) := by
  rw [principal_coefficient_separation N M s t hB hy0 w j]
  rw [map_mul, coefficientColumnMonomial_eq_ratio]
  simp [map_div, map_prod, map_zpow]
  ring

/-- One coordinate exchange, after the principal numerator, F-value, and
normalized coefficient recurrences have been identified. -/
theorem principal_coordinate_separation_step
    (e : P →* F) (y h dPlus dMinus dK dNew : P)
    (xPlus xMinus xK xNew nPlus nMinus nK nNew : F)
    (hd : dNew = (y * dPlus + dMinus) / (h * dK))
    (hy : xNew =
      (e (y * dPlus / dMinus) * xPlus + xMinus) /
        (e (y * dPlus / dMinus + 1) * xK))
    (hn : nNew = (e y * nPlus + nMinus) / (e h * nK))
    (hp : nPlus = e dPlus * xPlus)
    (hm : nMinus = e dMinus * xMinus)
    (hk : nK = e dK * xK)
    (hxK : xK ≠ 0) :
    nNew = e dNew * xNew := by
  have hquot := normalized_specialization_step_from_monomials e y
    dPlus dMinus dK h dNew xPlus xMinus xK nPlus nMinus nK nNew
    hxK hp hm hk hd hn
  rw [← hy] at hquot
  have hdne := coefficientMap_ne_zero e dNew
  calc
    nNew = xNew * e dNew := (div_eq_iff hdne).mp hquot
    _ = e dNew * xNew := mul_comm _ _

theorem normalized_wordCoordinates_mutate_self {C V' : Type*}
    [CoefficientSemifield C]
    (M : NormalizedMutationPattern C I V')
    (f : TotalLaurentRing (Additive C) I →+* F)
    (s : V') (w : List I) (k : I) :
    M.wordCoordinates f s (w ++ [k]) k =
      ((coefficientFieldMap f) (M.coefficient (mutateWord M.mutation w s) k) *
          positiveColumnMonomial (M.wordCoordinates f s w)
            (M.matrix (mutateWord M.mutation w s)) k +
        negativeColumnMonomial (M.wordCoordinates f s w)
            (M.matrix (mutateWord M.mutation w s)) k) /
        ((coefficientFieldMap f)
            (M.coefficient (mutateWord M.mutation w s) k + 1) *
          M.wordCoordinates f s w k) := by
  have h := congrArg (fun z : I → F => z k)
    (M.wordCoordinates_append_single f s w k)
  rw [h]
  simp only [mutateCoordinateValues, Function.update_self]
  change coordinateEvaluate f
    (seedExchange (M.coefficient (mutateWord M.mutation w s) k)
      (fun i => M.matrix (mutateWord M.mutation w s) i k))
      (M.wordCoordinates f s w) / M.wordCoordinates f s w k = _
  rw [coordinateEvaluate_seedExchange_actual]
  ring

end
end TauCeti.Cluster
