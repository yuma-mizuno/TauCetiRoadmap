/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.GroupRing
public import TauCetiRoadmap.LaurentPhenomenon.PositiveFraction
public import TauCetiRoadmap.LaurentPhenomenon.PositiveEvaluation
public import Mathlib.Algebra.MvPolynomial.Eval

/-! # Positive Realization -/

@[expose] public section

noncomputable section
namespace TauCeti.Laurent
open scoped BigOperators
/-- The integer group ring of coefficient-group exponents and finite mutable integer exponent
vectors.
-/
abbrev TotalLaurentRing (G I : Type*) :=
  AddMonoidAlgebra ℤ (G × (I →₀ ℤ))

instance (priority := 100) torsionFreeTotalLaurent_isDomain
    {G I : Type*} [AddCommGroup G] [IsAddTorsionFree G] :
    IsDomain (TotalLaurentRing G I) := groupRing_isDomain (G × (I →₀ ℤ))

/-- The mutable variables of the source Laurent chart. -/
def initialVariables {G I F : Type*} [AddCommGroup G] [CommRing F]
    (f : TotalLaurentRing G I →+* F) (i : I) : F :=
  f (AddMonoidAlgebra.single (0, Finsupp.single i 1) 1)

variable {G I : Type*} [AddCommGroup G] [DecidableEq I]
/-- A finite positive rational expression in coefficient-group and mutable Laurent monomials. -/
abbrev CoordinateExpression (G I : Type*) [AddCommGroup G] :=
  PositiveExpression (G × (I →₀ ℤ))


/-- A nonzero natural coefficient is an atom; mutable powers are built using
    finite products and reciprocals of the coordinate expressions. -/
def translatedTerm (t : G × (I →₀ ℤ)) (n : ℕ) (hn : n ≠ 0)
    (x : I → CoordinateExpression G I) : CoordinateExpression G I :=
  .mul (.atom (AddMonoidAlgebra.single (t.1, 0) n)
    (AddMonoidAlgebra.single_eq_zero.not.mpr hn))
    (PositiveExpression.product t.2.support (fun i => PositiveExpression.powInt (x i) (t.2 i)))

/-- Translate a supported Laurent term to a coordinate expression, returning one on unsupported
exponents.
-/
def translatedTermTotal (E : PositiveLaurent G I) (x : I → CoordinateExpression G I)
    (t : G × (I →₀ ℤ)) : CoordinateExpression G I :=
  if hn : E.coeff t = 0 then PositiveExpression.one else translatedTerm t (E.coeff t) hn x

omit [DecidableEq I] in
theorem positive_support_nonempty (E : PositiveLaurent G I) (hp : E ≠ 0) :
    E.coeff.support.Nonempty := by
  apply Finset.nonempty_iff_ne_empty.mpr
  intro h
  apply hp
  apply AddMonoidAlgebra.coeff_injective
  exact Finsupp.support_eq_empty.mp h

/-- Translate a genuine nonzero positive Laurent polynomial into a finite
    subtraction-free expression in the supplied coordinate expressions. -/
def translatePositive (E : PositiveLaurent G I) (hp : E ≠ 0)
    (x : I → CoordinateExpression G I) : CoordinateExpression G I :=
  PositiveExpression.sum E.coeff.support (positive_support_nonempty E hp)
    (translatedTermTotal E x)

variable {F : Type*} [Field F]
  (φ : AddMonoidAlgebra ℤ (G × (I →₀ ℤ)) →+* F)

omit [DecidableEq I] in
theorem translatedTerm_evaluate (t : G × (I →₀ ℤ)) (n : ℕ) (hn : n ≠ 0)
    (x : I → CoordinateExpression G I) :
    (translatedTerm t n hn x).evaluate φ =
      φ (positiveCast (AddMonoidAlgebra.single (t.1, 0) n)) *
        ∏ i ∈ t.2.support, (x i).evaluate φ ^ (t.2 i) := by
  classical
  simp [translatedTerm, PositiveExpression.evaluate]

omit [DecidableEq I] in
theorem translatePositive_evaluate (E : PositiveLaurent G I) (hp : E ≠ 0)
    (x : I → CoordinateExpression G I) :
    (translatePositive E hp x).evaluate φ =
      ∑ t ∈ E.coeff.support,
        φ (positiveCast (AddMonoidAlgebra.single (t.1, 0) (E.coeff t))) *
          ∏ i ∈ t.2.support, (x i).evaluate φ ^ (t.2 i) := by
  classical
  rw [translatePositive, PositiveExpression.evaluate_sum]
  apply Finset.sum_congr rfl
  intro t ht
  rw [translatedTermTotal, dite_eq_right (Finsupp.mem_support_iff.mp ht)]
  exact translatedTerm_evaluate φ t _ _ x
/-- Explicit finite Laurent evaluation in an arbitrary current coordinate chart. -/
def coordinateEvaluate (E : PositiveLaurent G I) (x : I → F) : F :=
  ∑ t ∈ E.coeff.support,
    φ (positiveCast (AddMonoidAlgebra.single (t.1, 0) (E.coeff t))) *
      ∏ i ∈ t.2.support, x i ^ (t.2 i)

/-- Replace the ith expression by the positive exchange expression divided by its current value. -/
def mutateCoordinateExpressions (E : PositiveLaurent G I) (hp : E ≠ 0)
    (i : I) (x : I → CoordinateExpression G I) : I → CoordinateExpression G I :=
  Function.update x i (.mul (translatePositive E hp x) (.inv (x i)))

/-- Replace the ith field coordinate by the evaluated exchange polynomial divided by that
coordinate.
-/
def mutateCoordinateValues (E : PositiveLaurent G I) (i : I) (x : I → F) : I → F :=
  Function.update x i (coordinateEvaluate φ E x / x i)

/-- Evaluating the constructed mutation gives precisely the exchange relation. -/
theorem mutateCoordinateExpressions_evaluate (E : PositiveLaurent G I) (hp : E ≠ 0)
    (i k : I) (x : I → CoordinateExpression G I) :
    (mutateCoordinateExpressions E hp i x k).evaluate φ =
      mutateCoordinateValues φ E i (fun h => (x h).evaluate φ) k := by
  by_cases hk : k = i
  · subst k
    simp [mutateCoordinateExpressions, mutateCoordinateValues, PositiveExpression.evaluate,
      translatePositive_evaluate, coordinateEvaluate, div_eq_mul_inv]
  · simp [mutateCoordinateExpressions, mutateCoordinateValues, hk]

/-- Iterate the prescribed polynomial exchanges and labels on an initial tuple of coordinate
expressions.
-/
def realizeCoordinateExpressions (E : ℕ → PositiveLaurent G I) (hp : ∀ n, E n ≠ 0)
    (labels : ℕ → I) (x₀ : I → CoordinateExpression G I) : ℕ → I → CoordinateExpression G I
  | 0 => x₀
  | n + 1 => mutateCoordinateExpressions (E n) (hp n) (labels n)
      (realizeCoordinateExpressions E hp labels x₀ n)

/-- Iterate the evaluated exchange formulas on an initial field-valued coordinate tuple. -/
def realizeCoordinateValues (E : ℕ → PositiveLaurent G I)
    (labels : ℕ → I) (x₀ : I → F) : ℕ → I → F
  | 0 => x₀
  | n + 1 => mutateCoordinateValues φ (E n) (labels n)
      (realizeCoordinateValues E labels x₀ n)

/-- Path induction constructs each realized coordinate from the actual exchange
    inputs, rather than assuming a positive rational representation. -/
theorem realizeCoordinateExpressions_evaluate (E : ℕ → PositiveLaurent G I)
    (hp : ∀ n, E n ≠ 0) (labels : ℕ → I) (x₀ : I → CoordinateExpression G I)
    (n : ℕ) (i : I) :
    (realizeCoordinateExpressions E hp labels x₀ n i).evaluate φ =
      realizeCoordinateValues φ E labels (fun k => (x₀ k).evaluate φ) n i := by
  induction n generalizing i with
  | zero => rfl
  | succ n ih =>
    simp only [realizeCoordinateExpressions, realizeCoordinateValues,
      mutateCoordinateExpressions_evaluate]
    congr 1
    funext k
    exact ih k

omit [DecidableEq I] in
theorem expression_evaluate_ne_zero
    (hf : ∀ p, positiveCast p ≠ 0 → φ (positiveCast p) ≠ 0)
    (x : CoordinateExpression G I) : x.evaluate φ ≠ 0 := by
  rw [← PositiveExpression.representatives_evaluate φ hf]
  exact PositiveFraction.evaluate_ne_zero φ hf _

/-- Positivity supplies nonzero coordinates at every mutation step. -/
theorem realizeCoordinateValues_ne_zero
    (hf : ∀ p, positiveCast p ≠ 0 → φ (positiveCast p) ≠ 0)
    (E : ℕ → PositiveLaurent G I) (hp : ∀ n, E n ≠ 0)
    (labels : ℕ → I) (x₀ : I → CoordinateExpression G I) (n : ℕ) (i : I) :
    realizeCoordinateValues φ E labels (fun k => (x₀ k).evaluate φ) n i ≠ 0 := by
  rw [← realizeCoordinateExpressions_evaluate φ E hp]
  exact expression_evaluate_ne_zero φ hf _

omit [DecidableEq I] in
/-- Every nonzero positive Laurent polynomial stays nonzero at every tuple
    represented by positive expressions. -/
theorem coordinateEvaluate_ne_zero
    (hf : ∀ p, positiveCast p ≠ 0 → φ (positiveCast p) ≠ 0)
    (E : PositiveLaurent G I) (hp : E ≠ 0) (x : I → CoordinateExpression G I) :
    coordinateEvaluate φ E (fun i => (x i).evaluate φ) ≠ 0 := by
  classical
  unfold coordinateEvaluate
  rw [← translatePositive_evaluate φ E hp x]
  exact expression_evaluate_ne_zero φ hf _

/-- Positivity of evaluation is preserved by each actual mutation. -/
theorem positive_evaluation_mutated
    (hf : ∀ p, positiveCast p ≠ 0 → φ (positiveCast p) ≠ 0)
    (E R : PositiveLaurent G I) (hE : E ≠ 0) (hR : R ≠ 0)
    (i : I) (x : I → CoordinateExpression G I) :
    coordinateEvaluate φ R (mutateCoordinateValues φ E i (fun k => (x k).evaluate φ)) ≠ 0 := by
  have he : (fun k => (mutateCoordinateExpressions E hE i x k).evaluate φ) =
      mutateCoordinateValues φ E i (fun k => (x k).evaluate φ) := by
    funext k
    exact mutateCoordinateExpressions_evaluate φ E hE i k x
  rw [← he]
  exact coordinateEvaluate_ne_zero φ hf R hR _

/-- Positivity at all realized vertices follows from the initial positive map. -/
theorem positive_evaluation_iterate
    (hf : ∀ p, positiveCast p ≠ 0 → φ (positiveCast p) ≠ 0)
    (E : ℕ → PositiveLaurent G I) (hp : ∀ n, E n ≠ 0) (labels : ℕ → I)
    (x₀ : I → CoordinateExpression G I) (n : ℕ) (R : PositiveLaurent G I) (hR : R ≠ 0) :
    coordinateEvaluate φ R
      (realizeCoordinateValues φ E labels (fun k => (x₀ k).evaluate φ) n) ≠ 0 := by
  have he : (fun k => (realizeCoordinateExpressions E hp labels x₀ n k).evaluate φ) =
      realizeCoordinateValues φ E labels (fun k => (x₀ k).evaluate φ) n := by
    funext k
    exact realizeCoordinateExpressions_evaluate φ E hp labels x₀ n k
  rw [← he]
  exact coordinateEvaluate_ne_zero φ hf R hR _

/-- C6 applied to an actual exchange path and its finite universal Laurent representative. -/
theorem realizeCoordinate_specialize_laurent
    [IsDomain (AddMonoidAlgebra ℤ (G × (I →₀ ℤ)))]
    (hf : ∀ p, positiveCast p ≠ 0 → φ (positiveCast p) ≠ 0)
    (E : ℕ → PositiveLaurent G I) (hp : ∀ n, E n ≠ 0) (labels : ℕ → I)
    (x₀ : I → CoordinateExpression G I) (n : ℕ) (i : I)
    (r : AddMonoidAlgebra ℤ (G × (I →₀ ℤ)))
    (h : positiveFractionEmbedding (positiveCast (G := G × (I →₀ ℤ)))
      (realizeCoordinateExpressions E hp labels x₀ n i).representatives.value =
      algebraMap _ (FractionRing (AddMonoidAlgebra ℤ (G × (I →₀ ℤ)))) r) :
    realizeCoordinateValues φ E labels (fun k => (x₀ k).evaluate φ) n i = φ r := by
  rw [← realizeCoordinateExpressions_evaluate φ E hp]
  exact PositiveExpression.specialize_laurent φ hf _ r h

/-- Include a coefficient-group polynomial in the total Laurent ring with zero mutable exponent. -/
def coefficientInclusion : AddMonoidAlgebra ℤ G →+*
    AddMonoidAlgebra ℤ (G × (I →₀ ℤ)) :=
  AddMonoidAlgebra.mapDomainRingHom ℤ
    { toFun := fun g => (g, 0)
      map_zero' := rfl
      map_add' := by intros; ext <;> simp }

/-- Take the coordinatewise natural truncation of an integer exponent vector. -/
def nonnegativeExponent (a : I →₀ ℤ) : I →₀ ℕ := a.mapRange Int.toNat rfl
/-- An actual multivariate polynomial obtained from finite nonnegative support. -/
def positiveToPolynomial (E : PositiveLaurent G I) : MvPolynomial I (AddMonoidAlgebra ℤ G) :=
  ∑ t ∈ E.coeff.support, MvPolynomial.monomial (nonnegativeExponent t.2)
    (AddMonoidAlgebra.single t.1 (E.coeff t : ℤ))

omit [DecidableEq I] in
/-- Natural exponents retain all supported variables of a nonnegative integer exponent. -/
theorem nonnegativeExponent_prod (a : I →₀ ℤ) (ha : ∀ i, 0 ≤ a i) (x : I → F) :
    (∏ i ∈ (nonnegativeExponent a).support, x i ^ (nonnegativeExponent a i)) =
      ∏ i ∈ a.support, x i ^ (a i) := by
  classical
  have hs : (nonnegativeExponent a).support = a.support := by
    ext i
    simp only [Finsupp.mem_support_iff, nonnegativeExponent, Finsupp.mapRange_apply,
      ne_eq, Int.toNat_eq_zero]
    exact not_congr ⟨fun h => le_antisymm h (ha i), fun h => h.le⟩
  rw [hs]
  apply Finset.prod_congr rfl
  intro i hi
  change x i ^ (a i).toNat = x i ^ (a i)
  rw [← zpow_natCast, Int.toNat_of_nonneg (ha i)]

omit [DecidableEq I] in
/-- The polynomial conversion has exactly the same evaluation as the original
    finite positive Laurent expression when its mutable exponents are nonnegative. -/
theorem positiveToPolynomial_eval (E : PositiveLaurent G I)
    (hE : PositivePolynomialSupport E) (x : I → F) :
    MvPolynomial.eval₂ (φ.comp coefficientInclusion) x (positiveToPolynomial E) =
      coordinateEvaluate φ E x := by
  classical
  simp only [positiveToPolynomial, MvPolynomial.eval₂_sum, MvPolynomial.eval₂_monomial,
    coordinateEvaluate]
  apply Finset.sum_congr rfl
  intro t ht
  have ha : ∀ i, 0 ≤ t.2 i := by
    apply hE t.2
    simp only [mutableSupport, Finset.mem_image]
    exact ⟨t, ht, rfl⟩
  rw [Finsupp.prod, nonnegativeExponent_prod t.2 ha x]
  congr 1
  simp [coefficientInclusion, positiveCast, AddMonoidAlgebra.mapDomain_single]

/-- Canonical initial variables as positive expressions. -/
def initialCoordinateExpression (i : I) : CoordinateExpression G I :=
  .atom (AddMonoidAlgebra.single (0, Finsupp.single i 1) 1)
    (AddMonoidAlgebra.single_eq_zero.not.mpr one_ne_zero)

omit [DecidableEq I] in
@[simp] theorem initialCoordinateExpression_evaluate (i : I) :
    (initialCoordinateExpression (G := G) i).evaluate φ =
      φ (AddMonoidAlgebra.single (0, Finsupp.single i 1) 1) := by
  simp [initialCoordinateExpression, PositiveExpression.evaluate, positiveCast]

omit [DecidableEq I] in
/-- Coefficient relations may merge terms, but their finite Laurent evaluation
    commutes with the noninjective group specialization. -/
theorem coordinateEvaluate_natural {H : Type*} [AddCommGroup H]
    (η : G →+ H) (ψ : AddMonoidAlgebra ℤ (H × (I →₀ ℤ)) →+* F)
    (E : PositiveLaurent G I) (x : I → F) :
    coordinateEvaluate (G := G) (I := I) (ψ.comp (AddMonoidAlgebra.mapDomainRingHom ℤ
      (η.prodMap (AddMonoidHom.id (I →₀ ℤ))))) E x =
      coordinateEvaluate (G := H) (I := I) ψ (coefficientMap (I := I) η E) x := by
  classical
  unfold coordinateEvaluate
  change E.coeff.sum (fun t n =>
    (ψ.comp (AddMonoidAlgebra.mapDomainRingHom ℤ (η.prodMap (AddMonoidHom.id (I →₀ ℤ)))))
      (positiveCast (AddMonoidAlgebra.single (t.1, 0) n)) *
      ∏ i ∈ t.2.support, x i ^ (t.2 i)) =
    (Finsupp.mapDomain (η.prodMap (AddMonoidHom.id (I →₀ ℤ))) E.coeff).sum
      (fun t n => ψ (positiveCast (AddMonoidAlgebra.single (t.1, 0) n)) *
        ∏ i ∈ t.2.support, x i ^ (t.2 i))
  rw [Finsupp.sum_mapDomain_index
    (fun t => by simp)
    (fun t a b => by simp [AddMonoidAlgebra.single_add, add_mul])]
  apply Finsupp.sum_congr
  intro t ht
  simp [positiveCast, AddMonoidAlgebra.mapDomainRingHom_apply,
    AddMonoidAlgebra.mapDomain_single]

/-- Independence of the mutation label makes Laurent evaluation unchanged
    when precisely that coordinate is updated. -/
theorem coordinateEvaluate_update (E : PositiveLaurent G I) (i : I)
    (hE : PositiveIndependent E i) (x : I → F) (y : F) :
    coordinateEvaluate φ E (Function.update x i y) = coordinateEvaluate φ E x := by
  classical
  unfold coordinateEvaluate
  apply Finset.sum_congr rfl
  intro t ht
  congr 1
  apply Finset.prod_congr rfl
  intro k hk
  by_cases hki : k = i
  · subst k
    have hz : t.2 i = 0 := by
      apply hE t.2
      simp only [mutableSupport, Finset.mem_image]
      exact ⟨t, ht, rfl⟩
    simp [hz]
  · simp [Function.update_of_ne hki]

omit [DecidableEq I] in
theorem positiveToPolynomial_independent (E : PositiveLaurent G I) (i : I)
    (hE : PositiveIndependent E i) (m : I →₀ ℕ)
    (hm : (positiveToPolynomial E).coeff m ≠ 0) : m i = 0 := by
  classical
  by_contra hmi
  apply hm
  simp only [positiveToPolynomial, MvPolynomial.coeff_sum]
  apply Finset.sum_eq_zero
  intro t ht
  have hz : t.2 i = 0 := by
    apply hE t.2
    simp only [mutableSupport, Finset.mem_image]
    exact ⟨t, ht, rfl⟩
  have hneq : nonnegativeExponent t.2 ≠ m := by
    intro h
    have he := congrArg (fun a : I →₀ ℕ => a i) h
    simp [nonnegativeExponent, hz] at he
    exact hmi he.symm
  simp [MvPolynomial.coeff_monomial, hneq]

end TauCeti.Laurent
