/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.UpperSpecialization
public import TauCetiRoadmap.ClusterAlgebras.ExchangeMatrix
public import TauCetiRoadmap.ClusterAlgebras.Normalization
public import TauCetiRoadmap.ClusterAlgebras.WordCoordinates
public import TauCetiRoadmap.ClusterAlgebras.UniversalY
public import TauCetiRoadmap.LaurentPhenomenon.CoordinateEvaluation
public import Mathlib.Tactic.Ring

/-! The mixed ordinary-addition Y variables of a normalized seed. -/

@[expose] public section

namespace TauCeti.Cluster

open scoped BigOperators
open TauCeti.Laurent
noncomputable section

variable {I F : Type*} [Fintype I] [DecidableEq I] [Field F]

/-- Evaluate coefficient monomials through a homomorphism from the total Laurent ring. -/
def coefficientFieldMap {P : Type*} [CoefficientSemifield P]
    (f : TauCeti.Laurent.TotalLaurentRing (Additive P) I →+* F) : P →* F where
  toFun p := f (AddMonoidAlgebra.single (Additive.ofMul p, 0) 1)
  map_one' := by change f 1 = 1; exact map_one f
  map_mul' p q := by
    rw [← map_mul]
    simp

/-- The product of initial coordinates to the integer exponents in the jth matrix column. -/
def columnMonomial (x : I → F) (B : I → I → ℤ) (j : I) : F :=
  ∏ i, x i ^ B i j

/-- The product of initial coordinates to the positive parts of the kth matrix column. -/
def positiveColumnMonomial (x : I → F) (B : I → I → ℤ) (k : I) : F :=
  ∏ i, x i ^ positivePart (B i k)

/-- The product of initial coordinates to the negative parts of the kth matrix column. -/
def negativeColumnMonomial (x : I → F) (B : I → I → ℤ) (k : I) : F :=
  ∏ i, x i ^ positivePart (-B i k)

omit [DecidableEq I] in
theorem coordinateEvaluate_single_coefficient {P : Type*} [CoefficientSemifield P]
    (f : TotalLaurentRing (Additive P) I →+* F)
    (p : P) (a : I →₀ ℤ) (x : I → F) :
    coordinateEvaluate f (AddMonoidAlgebra.single (Additive.ofMul p, a) 1) x =
      coefficientFieldMap f p * ∏ i, x i ^ a i := by
  rw [coordinateEvaluate_single]
  change f (positiveCast (AddMonoidAlgebra.single (Additive.ofMul p, 0) 1)) *
    ∏ i ∈ a.support, x i ^ a i = _
  simp only [positiveCast, AddMonoidAlgebra.mapRingHom_single, coefficientFieldMap]
  congr 1
  apply Finset.prod_subset (Finset.subset_univ _)
  intro i _ hi
  simp [Finsupp.notMem_support_iff.mp hi]

omit [DecidableEq I] in
theorem coordinateEvaluate_seedExchange_actual {P : Type*} [CoefficientSemifield P]
    (f : TotalLaurentRing (Additive P) I →+* F)
    (y : P) (B : I → I → ℤ) (k : I) (x : I → F) :
    coordinateEvaluate f (seedExchange y (fun i => B i k)) x =
      ((coefficientFieldMap f) y * positiveColumnMonomial x B k +
        negativeColumnMonomial x B k) / (coefficientFieldMap f) (y + 1) := by
  classical
  rw [seedExchange, coordinateEvaluate_add,
    coordinateEvaluate_single_coefficient,
    coordinateEvaluate_single_coefficient]
  simp only [columnPositiveExponent_apply, positiveColumnMonomial,
    negativeColumnMonomial]
  have h := coefficientMap_ne_zero (coefficientFieldMap f) (y + 1)
  simp only [CoefficientSemifield.normalizedPositive,
    CoefficientSemifield.normalizedNegative, map_div, map_one]
  field_simp

omit [DecidableEq I] in
theorem columnMonomial_eq_ratio (x : I → F) (B : I → I → ℤ)
    (hx : ∀ i, x i ≠ 0) (k : I) :
    columnMonomial x B k =
      positiveColumnMonomial x B k / negativeColumnMonomial x B k := by
  simp only [columnMonomial, positiveColumnMonomial, negativeColumnMonomial]
  rw [← Finset.prod_div_distrib]
  apply Finset.prod_congr rfl
  intro i _
  have h : positivePart (B i k) - positivePart (-B i k) = B i k := by
    unfold positivePart; omega
  rw [← zpow_sub₀ (hx i), h]

theorem columnMonomial_mutate (x x' : I → F) (B : I → I → ℤ)
    (hx : ∀ i, x i ≠ 0) (k j : I) (hjk : j ≠ k)
    (hdiag : B k k = 0) (hupdate : ∀ i, i ≠ k → x' i = x i) :
    columnMonomial x' (matrixMutation B k) j =
      columnMonomial x B j * (x' k * x k) ^ (-B k j) *
        positiveColumnMonomial x B k ^ positivePart (B k j) *
        negativeColumnMonomial x B k ^ (-positivePart (-B k j)) := by
  let b := B k j
  have hpoint (i : I) :
      x' i ^ matrixMutation B k i j =
        x i ^ B i j *
          (if i = k then (x' k * x k) ^ (-b) else 1) *
          (x i ^ positivePart (B i k)) ^ positivePart b *
          (x i ^ positivePart (-B i k)) ^ (-positivePart (-b)) := by
    by_cases hik : i = k
    · subst i
      simp only [matrixMutation, true_or, ite_true, hdiag, neg_zero]
      simp only [positivePart, max_self, zpow_zero, one_zpow, mul_one]
      have hpow : x k ^ B k j ≠ 0 := zpow_ne_zero _ (hx k)
      simp [b, mul_zpow, zpow_neg, hpow, mul_comm]
    · rw [hupdate i hik]
      simp only [matrixMutation, hik, hjk, false_or, ite_false, mul_one]
      rw [zpow_sub₀ (hx i), zpow_add₀ (hx i), ← zpow_mul, ← zpow_mul]
      dsimp only [b]
      convert rfl using 1
      ring_nf
      simp only [zpow_neg]
  simp only [columnMonomial, positiveColumnMonomial, negativeColumnMonomial]
  calc
    (∏ i, x' i ^ matrixMutation B k i j) =
        ∏ i, (x i ^ B i j *
          (if i = k then (x' k * x k) ^ (-b) else 1) *
          (x i ^ positivePart (B i k)) ^ positivePart b *
          (x i ^ positivePart (-B i k)) ^ (-positivePart (-b))) := by
        apply Finset.prod_congr rfl
        intro i _
        exact hpoint i
    _ = _ := by
      simp only [Finset.prod_mul_distrib,
        Finset.prod_zpow]
      simp [b, mul_assoc]

private theorem hatY_scalar_identity (a h p n t : F) (b : ℤ)
    (hh : h ≠ 0) (hn : n ≠ 0)
    (ht : t = (a * p + n) / h) :
    a ^ positivePart b * h ^ (-b) * t ^ (-b) *
        p ^ positivePart b * n ^ (-positivePart (-b)) =
      (a * p / n) ^ positivePart b *
        (1 + a * p / n) ^ (-b) := by
  have hsum : 1 + a * p / n = (a * p + n) / n := by
    field_simp
    ring
  have hpart : positivePart b - positivePart (-b) = b := by
    unfold positivePart; omega
  have hnexp : n ^ (-positivePart (-b)) = n ^ (-positivePart b) * n ^ b := by
    rw [← zpow_add₀ hn]
    congr 1
    omega
  calc
    _ = a ^ positivePart b * p ^ positivePart b *
          (a * p + n) ^ (-b) * n ^ (-positivePart (-b)) := by
      rw [ht, div_zpow]
      have hinv : (h ^ (-b))⁻¹ = h ^ b := by simp [zpow_neg]
      simp only [div_eq_mul_inv, hinv]
      have hc : h ^ (-b) * h ^ b = 1 := by
        rw [← zpow_add₀ hh]
        simp
      calc
        _ = (h ^ (-b) * h ^ b) *
            (a ^ positivePart b * p ^ positivePart b *
              (a * p + n) ^ (-b) * n ^ (-positivePart (-b))) := by ring
        _ = _ := by rw [hc]; ring
    _ = (a * p / n) ^ positivePart b *
          (1 + a * p / n) ^ (-b) := by
      rw [hsum, div_zpow, div_zpow, mul_zpow, hnexp]
      group

/-- The evaluated coefficient y_j multiplied by the coordinate monomial of the jth matrix column. -/
def hatY {P : Type*} [CoefficientSemifield P]
    (e : P →* F) (y : I → P) (x : I → F)
    (B : I → I → ℤ) (j : I) : F :=
  e (y j) * columnMonomial x B j

omit [DecidableEq I] in
theorem hatY_ne_zero {P : Type*} [CoefficientSemifield P]
    (e : P →* F) (y : I → P) (x : I → F)
    (B : I → I → ℤ) (hx : ∀ i, x i ≠ 0) (j : I) :
    hatY e y x B j ≠ 0 := by
  unfold hatY columnMonomial
  exact mul_ne_zero (coefficientMap_ne_zero e _)
    (Finset.prod_ne_zero_iff.mpr (by intro i _; exact zpow_ne_zero _ (hx i)))

omit [DecidableEq I] in
theorem one_add_hatY_ne_zero {P : Type*} [CoefficientSemifield P]
    (e : P →* F) (y : I → P) (x : I → F)
    (B : I → I → ℤ) (hx : ∀ i, x i ≠ 0) (k : I)
    (hnum : e (y k) * positiveColumnMonomial x B k +
      negativeColumnMonomial x B k ≠ 0) :
    1 + hatY e y x B k ≠ 0 := by
  have hn : negativeColumnMonomial x B k ≠ 0 := by
    unfold negativeColumnMonomial
    exact Finset.prod_ne_zero_iff.mpr (by intro i _; exact zpow_ne_zero _ (hx i))
  rw [hatY, columnMonomial_eq_ratio x B hx k]
  have heq : 1 + e (y k) * (positiveColumnMonomial x B k /
      negativeColumnMonomial x B k) =
      (e (y k) * positiveColumnMonomial x B k +
        negativeColumnMonomial x B k) / negativeColumnMonomial x B k := by
    field_simp
    ring
  rw [heq]
  exact div_ne_zero hnum hn

theorem columnMonomial_mutate_self (x x' : I → F) (B : I → I → ℤ)
    (k : I) (hdiag : B k k = 0)
    (hupdate : ∀ i, i ≠ k → x' i = x i) :
    columnMonomial x' (matrixMutation B k) k =
      (columnMonomial x B k)⁻¹ := by
  simp only [columnMonomial, ← Finset.prod_inv_distrib]
  apply Finset.prod_congr rfl
  intro i _
  by_cases hik : i = k
  · subst i
    simp [matrixMutation, hdiag]
  · rw [hupdate i hik]
    simp [matrixMutation, hik, zpow_neg]

theorem hatY_mutate_self {P : Type*} [CoefficientSemifield P]
    (e : P →* F) (y y' : I → P) (x x' : I → F)
    (B : I → I → ℤ) (k : I) (hdiag : B k k = 0)
    (hy : y' k = (y k)⁻¹)
    (hupdate : ∀ i, i ≠ k → x' i = x i) :
    hatY e y' x' (matrixMutation B k) k = (hatY e y x B k)⁻¹ := by
  simp only [hatY, hy, map_inv, columnMonomial_mutate_self x x' B k hdiag hupdate]
  rw [mul_inv_rev]
  ring

theorem hatY_mutate_other {P : Type*} [CoefficientSemifield P]
    (e : P →* F) (y y' : I → P) (x x' : I → F)
    (B : I → I → ℤ) (k j : I) (hjk : j ≠ k)
    (hdiag : B k k = 0) (hx : ∀ i, x i ≠ 0)
    (hupdate : ∀ i, i ≠ k → x' i = x i)
    (hy : y' j = coefficientMutation (y j) (y k) (y k + 1) (B k j))
    (hexchange : x' k * x k =
      (e (y k) * positiveColumnMonomial x B k +
        negativeColumnMonomial x B k) / e (y k + 1)) :
    hatY e y' x' (matrixMutation B k) j =
      hatY e y x B j * (hatY e y x B k) ^ positivePart (B k j) *
        (1 + hatY e y x B k) ^ (-B k j) := by
  have hp : positiveColumnMonomial x B k ≠ 0 := by
    unfold positiveColumnMonomial
    exact Finset.prod_ne_zero_iff.mpr (by intro i _; exact zpow_ne_zero _ (hx i))
  have hn : negativeColumnMonomial x B k ≠ 0 := by
    unfold negativeColumnMonomial
    exact Finset.prod_ne_zero_iff.mpr (by intro i _; exact zpow_ne_zero _ (hx i))
  have hs := hatY_scalar_identity (e (y k)) (e (y k + 1))
    (positiveColumnMonomial x B k) (negativeColumnMonomial x B k)
    (x' k * x k) (B k j)
    (coefficientMap_ne_zero e _) hn hexchange
  have hm := columnMonomial_mutate x x' B hx k j hjk hdiag hupdate
  have hr := columnMonomial_eq_ratio x B hx k
  simp only [hatY, hy, coefficientMutation, map_mul, map_zpow] at *
  rw [hm, hr]
  calc
    _ = (e (y j) * columnMonomial x B j) *
        (e (y k) ^ positivePart (B k j) * e (y k + 1) ^ (-B k j) *
          (x' k * x k) ^ (-B k j) *
          positiveColumnMonomial x B k ^ positivePart (B k j) *
          negativeColumnMonomial x B k ^ (-positivePart (-B k j))) := by ring
    _ = _ := by rw [hs]; ring

omit [Fintype I] in
omit [DecidableEq I] in
theorem positivePoint_coordinate_ne_zero {P : Type*} [CoefficientSemifield P]
    (f : TotalLaurentRing (Additive P) I →+* F)
    (hf : ∀ p, positiveCast p ≠ 0 → f (positiveCast p) ≠ 0)
    (q : PositivePoint f) (i : I) : q.val i ≠ 0 := by
  obtain ⟨a, ha⟩ := q.property
  rw [ha i]
  exact expression_evaluate_ne_zero f hf (a i)

theorem hatY_mutateRealized {P V : Type*} [CoefficientSemifield P]
    (N : NormalizedMutationPattern P I V)
    (f : TotalLaurentRing (Additive P) I →+* F)
    (hf : ∀ p, positiveCast p ≠ 0 → f (positiveCast p) ≠ 0)
    (q : N.RealizedSeed f) (k j : I) :
    hatY (coefficientFieldMap f) (N.coefficient (N.mutation k q.1))
      (N.mutateRealized f k q).2.val (N.matrix (N.mutation k q.1)) j =
      if j = k then
        (hatY (coefficientFieldMap f) (N.coefficient q.1) q.2.val
          (N.matrix q.1) k)⁻¹
      else
        hatY (coefficientFieldMap f) (N.coefficient q.1) q.2.val
            (N.matrix q.1) j *
          (hatY (coefficientFieldMap f) (N.coefficient q.1) q.2.val
            (N.matrix q.1) k) ^ positivePart (N.matrix q.1 k j) *
          (1 + hatY (coefficientFieldMap f) (N.coefficient q.1) q.2.val
            (N.matrix q.1) k) ^ (-N.matrix q.1 k j) := by
  let x := q.2.val
  let x' := (N.mutateRealized f k q).2.val
  have hx : ∀ i, x i ≠ 0 := positivePoint_coordinate_ne_zero f hf q.2
  have hupdate : ∀ i, i ≠ k → x' i = x i := by
    intro i hik
    simp [x', x, NormalizedMutationPattern.mutateRealized,
      PositivePoint.update, mutateCoordinateValues, hik]
  have hnum : (coefficientFieldMap f) (N.coefficient q.1 k) *
      positiveColumnMonomial x (N.matrix q.1) k +
      negativeColumnMonomial x (N.matrix q.1) k ≠ 0 := by
    have heval := PositivePoint.evaluate_ne_zero f hf
      (N.exchange q.1 k) (N.exchange_ne_zero q.1 k) q.2
    rw [NormalizedMutationPattern.exchange,
      coordinateEvaluate_seedExchange_actual] at heval
    exact (div_ne_zero_iff.mp heval).1
  have hexchange : x' k * x k =
      ((coefficientFieldMap f) (N.coefficient q.1 k) *
        positiveColumnMonomial x (N.matrix q.1) k +
        negativeColumnMonomial x (N.matrix q.1) k) /
          (coefficientFieldMap f) (N.coefficient q.1 k + 1) := by
    simp only [x', x, NormalizedMutationPattern.mutateRealized,
      PositivePoint.update, mutateCoordinateValues, Function.update_self]
    change coordinateEvaluate f
      (seedExchange (N.coefficient q.1 k) (fun i => N.matrix q.1 i k)) x /
        x k * x k = _
    rw [coordinateEvaluate_seedExchange_actual]
    exact div_mul_cancel₀ _ (hx k)
  rw [N.matrix_law]
  by_cases hj : j = k
  · subst j
    simp only [↓reduceIte]
    exact hatY_mutate_self (coefficientFieldMap f)
      (N.coefficient q.1) (N.coefficient (N.mutation k q.1))
      x x' (N.matrix q.1) k (N.diagonal q.1 k)
      (N.coefficient_self q.1 k) hupdate
  · simp only [hj, ite_false]
    exact hatY_mutate_other (coefficientFieldMap f)
      (N.coefficient q.1) (N.coefficient (N.mutation k q.1))
      x x' (N.matrix q.1) k j hj (N.diagonal q.1 k) hx hupdate
      (N.coefficient_other q.1 k j hj) hexchange


namespace UniversalYSeed

omit [Fintype I] in
theorem evaluate_field_mutate {G : Type*} [AddCommGroup G]
    (ψ : AddMonoidAlgebra ℤ G →+* F)
    (v : UniversalYSeed G I) (k j : I) :
    ((v.mutate k).coefficient j).evaluate ψ =
      if j = k then ((v.coefficient k).evaluate ψ)⁻¹ else
        (v.coefficient j).evaluate ψ *
          ((v.coefficient k).evaluate ψ) ^ positivePart (v.matrix k j) *
          (1 + (v.coefficient k).evaluate ψ) ^ (-v.matrix k j) := by
  by_cases hj : j = k
  · subst j
    simp [UniversalYSeed.mutate, PositiveExpression.evaluate]
  · simp only [UniversalYSeed.mutate, hj, ite_false, PositiveExpression.evaluate,
      PositiveExpression.evaluate_powInt,
      PositiveExpression.evaluate_one]
    rw [add_comm]

end UniversalYSeed

/-- An ordinary-addition universal Y-seed and an actual normalized realized
seed remain equal word by word once their initial mixed Y-values agree. -/
theorem universalY_field_matches_hatY_word {P V G : Type*}
    [CoefficientSemifield P] [AddCommGroup G]
    (N : NormalizedMutationPattern P I V)
    (f : TotalLaurentRing (Additive P) I →+* F)
    (hf : ∀ p, positiveCast p ≠ 0 → f (positiveCast p) ≠ 0)
    (ψ : AddMonoidAlgebra ℤ G →+* F)
    (v : UniversalYSeed G I) (q : N.RealizedSeed f)
    (hm : v.matrix = N.matrix q.1)
    (hy : ∀ j, (v.coefficient j).evaluate ψ =
      hatY (coefficientFieldMap f) (N.coefficient q.1) q.2.val
        (N.matrix q.1) j)
    (w : List I) :
    (mutateWord UniversalYSeed.mutate w v).matrix =
        N.matrix (mutateWord (N.mutateRealized f) w q).1 ∧
      ∀ j, ((mutateWord UniversalYSeed.mutate w v).coefficient j).evaluate ψ =
        hatY (coefficientFieldMap f)
          (N.coefficient (mutateWord (N.mutateRealized f) w q).1)
          (mutateWord (N.mutateRealized f) w q).2.val
          (N.matrix (mutateWord (N.mutateRealized f) w q).1) j := by
  induction w generalizing v q with
  | nil => exact ⟨hm, hy⟩
  | cons k w ih =>
      apply ih (v.mutate k) (N.mutateRealized f k q)
      · change matrixMutation v.matrix k = N.matrix (N.mutation k q.1)
        rw [N.matrix_law]
        exact congrArg (fun B => matrixMutation B k) hm
      · intro j
        rw [UniversalYSeed.evaluate_field_mutate]
        change _ = hatY (coefficientFieldMap f)
          (N.coefficient (N.mutation k q.1))
          (N.mutateRealized f k q).2.val
          (N.matrix (N.mutation k q.1)) j
        rw [hatY_mutateRealized N f hf q k j]
        simp only [hm, hy]

/-- Evaluate principal coefficient Laurent polynomials at the hat-y coordinates in the ambient
field.
-/
def principalHatYFieldEval {P : Type*} [CoefficientSemifield P]
    (e : P →* F) (y : I → P) (x : I → F)
    (B : I → I → ℤ) (hx : ∀ i, x i ≠ 0) :
    AddMonoidAlgebra ℤ (Additive (Trop I)) →+* F :=
  (LaurentEvaluation.eval (Int.castRingHom F)
    (fun i => Units.mk0 (hatY e y x B i) (hatY_ne_zero e y x B hx i))).comp
    (AddMonoidAlgebra.mapDomainRingHom ℤ (Trop.exponentEquiv (I := I)).toAddMonoidHom)

omit [DecidableEq I] in
theorem principalHatYFieldEval_generator {P : Type*} [CoefficientSemifield P]
    (e : P →* F) (y : I → P) (x : I → F)
    (B : I → I → ℤ) (hx : ∀ i, x i ≠ 0) (j : I) :
    principalHatYFieldEval e y x B hx
      (AddMonoidAlgebra.single (Additive.ofMul (Trop.generator j)) 1) =
      hatY e y x B j := by
  classical
  simp [principalHatYFieldEval, Trop.exponentEquiv, Trop.generator]

theorem principalY_field_hatY_word {P V : Type*} [CoefficientSemifield P]
    (N : NormalizedMutationPattern P I V)
    (f : TotalLaurentRing (Additive P) I →+* F)
    (hf : ∀ p, positiveCast p ≠ 0 → f (positiveCast p) ≠ 0)
    (s : V) (w : List I) (j : I) :
    ((mutateWord UniversalYSeed.mutate w
      (principalYInitial (N.matrix s))).coefficient j).evaluate
        (principalHatYFieldEval (coefficientFieldMap f)
          (N.coefficient s) (initialVariables f) (N.matrix s)
          (positivePoint_coordinate_ne_zero f hf (PositivePoint.initial f))) =
      hatY (coefficientFieldMap f)
        (N.coefficient (mutateWord N.mutation w s))
        (N.wordCoordinates f s w)
        (N.matrix (mutateWord N.mutation w s)) j := by
  let ψ := principalHatYFieldEval (coefficientFieldMap f)
    (N.coefficient s) (initialVariables f) (N.matrix s)
    (positivePoint_coordinate_ne_zero f hf (PositivePoint.initial f))
  have h := universalY_field_matches_hatY_word N f hf ψ
    (principalYInitial (N.matrix s)) (s, PositivePoint.initial f) rfl
    (by
      intro i
      simpa [principalYInitial, PositiveExpression.evaluate,
        positiveCast, PositivePoint.initial, ψ] using
        principalHatYFieldEval_generator (coefficientFieldMap f)
        (N.coefficient s) (initialVariables f) (N.matrix s)
        (positivePoint_coordinate_ne_zero f hf (PositivePoint.initial f)) i) w
  simpa only [N.mutateWord_data, NormalizedMutationPattern.wordCoordinates, ψ]
    using h.2 j

/-- At the specialization where the initial mutable coordinates are all one,
the universal ordinary-addition Y-value is the mutated coefficient times the
column monomial in the specialized cluster coordinates (the F-values). -/
theorem principalY_field_at_one_word {P V : Type*} [CoefficientSemifield P]
    (N : NormalizedMutationPattern P I V)
    (f : TotalLaurentRing (Additive P) I →+* F)
    (hf : ∀ p, positiveCast p ≠ 0 → f (positiveCast p) ≠ 0)
    (h1 : ∀ i, initialVariables f i = 1)
    (s : V) (w : List I) (j : I) :
    ((mutateWord UniversalYSeed.mutate w
      (principalYInitial (N.matrix s))).coefficient j).evaluate
        (principalHatYFieldEval (coefficientFieldMap f)
          (N.coefficient s) (fun _ => 1) (N.matrix s)
          (by intro _; simp)) =
      (coefficientFieldMap f) (N.coefficient (mutateWord N.mutation w s) j) *
        ∏ i, (N.wordCoordinates f s w i) ^
          (N.matrix (mutateWord N.mutation w s) i j) := by
  have hxEq : initialVariables f = (fun _ => (1 : F)) := funext h1
  simpa only [hatY, columnMonomial, hxEq] using
    principalY_field_hatY_word N f hf s w j

omit [Fintype I] in
/-- The same principal universal Y-expression evaluates in the auxiliary
semifield to the actual mutated coefficient. Together with
`principalY_field_at_one_word`, this is the two-evaluation separation identity. -/
theorem principalY_coefficient_word {P V : Type*} [CoefficientSemifield P]
    (N : NormalizedMutationPattern P I V) (s : V) (w : List I) (j : I) :
    positiveExpressionEvaluateAt (principalCoefficientHom (N.coefficient s))
      ((mutateWord UniversalYSeed.mutate w
        (principalYInitial (N.matrix s))).coefficient j) =
      N.coefficient (mutateWord N.mutation w s) j := by
  let η := principalCoefficientHom (N.coefficient s)
  have hword (v : UniversalYSeed (Additive (Trop I)) I) (t : V)
      (hm : v.matrix = N.matrix t)
      (hy : ∀ i, positiveExpressionEvaluateAt η (v.coefficient i) =
        N.coefficient t i) (u : List I) :
      (mutateWord UniversalYSeed.mutate u v).matrix =
          N.matrix (mutateWord N.mutation u t) ∧
        ∀ i, positiveExpressionEvaluateAt η
          ((mutateWord UniversalYSeed.mutate u v).coefficient i) =
            N.coefficient (mutateWord N.mutation u t) i := by
    induction u generalizing v t with
    | nil => exact ⟨hm, hy⟩
    | cons k u ih =>
        apply ih (v.mutate k) (N.mutation k t)
        · change matrixMutation v.matrix k = N.matrix (N.mutation k t)
          rw [N.matrix_law]
          exact congrArg (fun B => matrixMutation B k) hm
        · intro i
          rw [UniversalYSeed.evaluate_mutate]
          by_cases hi : i = k
          · subst i
            simpa only [ite_true, hy] using (N.coefficient_self t k).symm
          · simp only [hi, ite_false, hy, hm]
            exact (N.coefficient_other t k i hi).symm
  have h := hword (principalYInitial (N.matrix s)) s rfl
    (by
      intro i
      simpa [principalYInitial, η] using
        (positiveExpressionEvaluateAt_atom_single η
          (Additive.ofMul (Trop.generator i))).trans
          (congrArg Additive.toMul
            (principalCoefficientHom_generator (N.coefficient s) i))) w
  exact h.2 j

/-- Set every initial mutable variable to one, retaining the principal coefficient lattice. -/
def principalAtOneCoefficientMap :
    TotalLaurentRing (Additive (Trop I)) I →+*
      AddMonoidAlgebra ℤ (Additive (Trop I)) :=
  AddMonoidAlgebra.mapDomainRingHom ℤ
    (AddMonoidHom.fst (Additive (Trop I)) (I →₀ ℤ))

/-- Set the initial mutable variables to one and embed the resulting coefficient Laurent ring in
its fraction field.
-/
def principalAtOne :
    TotalLaurentRing (Additive (Trop I)) I →+*
      FractionRing (AddMonoidAlgebra ℤ (Additive (Trop I))) :=
  (algebraMap _ _).comp principalAtOneCoefficientMap

omit [DecidableEq I] [Fintype I] in
theorem principalAtOne_positive_ne_zero
    (p : PositiveLaurent (Additive (Trop I)) I) (hp : p ≠ 0) :
    principalAtOne (positiveCast p) ≠ 0 := by
  unfold principalAtOne
  change (algebraMap _ _) (principalAtOneCoefficientMap (positiveCast p)) ≠ 0
  apply IsFractionRing.to_map_eq_zero_iff.not.mpr
  exact positive_specialization_ne_zero
    (AddMonoidHom.fst (Additive (Trop I)) (I →₀ ℤ)) hp

omit [DecidableEq I] [Fintype I] in
theorem principalAtOne_initialVariables (i : I) :
    initialVariables principalAtOne i = 1 := by
  simp [initialVariables, principalAtOne, principalAtOneCoefficientMap]
  rfl

end
end TauCeti.Cluster
