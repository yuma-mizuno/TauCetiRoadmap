/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.PrincipalCoefficients
public import TauCetiRoadmap.ClusterAlgebras.ExpressionCoordinates
public import TauCetiRoadmap.LaurentPhenomenon.CoordinateWeight

/-! Every geometric cluster coordinate has frozen order zero. Combining this
with a Laurent expansion removes all negative frozen exponents. The argument
uses subtraction-free expressions and normalized tropical coefficients only. -/

@[expose] public section

noncomputable section
namespace TauCeti.Cluster
open TauCeti.Laurent CoefficientSemifield
variable {I J V : Type*} [DecidableEq I] [Finite I]

/-- The exponent of the frozen coefficient generator indexed by j. -/
def frozenCoefficientWeight (j : J) : Additive (Trop J) →+ ℤ where
  toFun g := g.toMul.toAdd j
  map_zero' := rfl
  map_add' _ _ := rfl

omit [DecidableEq I] in
theorem seedExchange_mem_support_iff {P : Type*} [CoefficientSemifield P]
    (y : P) (b : I → ℤ) (t : Additive P × (I →₀ ℤ)) :
    t ∈ (seedExchange y b).coeff.support ↔
      t = (Additive.ofMul (normalizedPositive y), columnPositiveExponent b) ∨
      t = (Additive.ofMul (normalizedNegative y), columnPositiveExponent (fun i => -b i)) := by
  classical
  classical
  change t ∈ ((Finsupp.single _ (1 : ℕ)) + Finsupp.single _ 1).support ↔ _
  rw [Finsupp.support_add_eq_union]
  simp [eq_comm]

theorem normalizedPositive_frozenWeight (y : Trop J) (j : J) :
    frozenCoefficientWeight j (Additive.ofMul (normalizedPositive y)) =
      y.toAdd j - min (y.toAdd j) 0 := by
  change (normalizedPositive y).toAdd j = _
  simp [normalizedPositive, Trop.add_apply]

theorem normalizedNegative_frozenWeight (y : Trop J) (j : J) :
    frozenCoefficientWeight j (Additive.ofMul (normalizedNegative y)) =
      -min (y.toAdd j) 0 := by
  change (normalizedNegative y).toAdd j = _
  simp [normalizedNegative, Trop.add_apply]

omit [DecidableEq I] in
theorem seedExchange_frozen_nonnegative (y : Trop J) (b : I → ℤ) (j : J) :
    ∀ t ∈ (seedExchange y b).coeff.support, 0 ≤ frozenCoefficientWeight j t.1 := by
  classical
  intro t ht
  rcases (seedExchange_mem_support_iff y b t).mp ht with rfl | rfl
  · rw [normalizedPositive_frozenWeight]
    omega
  · rw [normalizedNegative_frozenWeight]
    omega

omit [DecidableEq I] in
theorem seedExchange_frozen_zero (y : Trop J) (b : I → ℤ) (j : J) :
    ∃ t ∈ (seedExchange y b).coeff.support, frozenCoefficientWeight j t.1 = 0 := by
  classical
  by_cases h : y.toAdd j ≤ 0
  · refine ⟨(Additive.ofMul (normalizedPositive y), columnPositiveExponent b),
      (seedExchange_mem_support_iff y b _).mpr (Or.inl rfl), ?_⟩
    rw [normalizedPositive_frozenWeight, min_eq_left h, sub_self]
  · refine ⟨(Additive.ofMul (normalizedNegative y), columnPositiveExponent (fun i => -b i)),
      (seedExchange_mem_support_iff y b _).mpr (Or.inr rfl), ?_⟩
    rw [normalizedNegative_frozenWeight, min_eq_right (by omega), neg_zero]

namespace NormalizedMutationPattern
variable (N : NormalizedMutationPattern (Trop J) I V)

/-- All constructed coordinates have frozen order zero at every word, without
assuming Laurentness, sign-coherence, or positivity of Laurent coefficients. -/
theorem wordExpressions_frozen_order (s : V) (w : List I) (i : I) (j : J) :
    (N.wordExpressions s w i).order (coefficientWeight (frozenCoefficientWeight j)) = 0 := by
  have hword (v : List I) (t : V × (I → CoordinateExpression (Additive (Trop J)) I))
      (ht : ∀ k, (t.2 k).order (coefficientWeight (frozenCoefficientWeight j)) = 0) :
      ∀ k, ((mutateWord N.mutateExpressions v t).2 k).order
        (coefficientWeight (frozenCoefficientWeight j)) = 0 := by
    induction v generalizing t with
    | nil => exact ht
    | cons k v ih =>
      apply ih (N.mutateExpressions k t)
      intro l
      apply mutateCoordinateExpressions_order_zero _ _ _ t.2 ht
      · exact seedExchange_frozen_nonnegative _ _ j
      · exact seedExchange_frozen_zero _ _ j
  apply hword w (s, initialCoordinateExpression) _ i
  intro k
  simp only [initialCoordinateExpression, PositiveExpression.order_atom]
  rw [positiveOrder_single _ _ 1 one_ne_zero]
  rfl

/-- If the upper-bound argument supplies a Laurent representative, each of its
frozen exponents is nonnegative. No assertion about coefficient signs is used. -/
theorem wordCoordinates_frozen_nonnegative (s : V) (w : List I) (i : I)
    (r : TotalLaurentRing (Additive (Trop J)) I) (hr : r ≠ 0)
    (heq : algebraMap _ (FractionRing (TotalLaurentRing (Additive (Trop J)) I)) r =
      N.wordCoordinates (algebraMap _ _) s w i) (j : J) :
    ∀ a ∈ r.coeff.support, 0 ≤ a.1.toMul.toAdd j := by
  let φ := algebraMap (TotalLaurentRing (Additive (Trop J)) I)
    (FractionRing (TotalLaurentRing (Additive (Trop J)) I))
  have hφ : Function.Injective φ := IsFractionRing.injective _ _
  have hpos : ∀ p, positiveCast p ≠ 0 → φ (positiveCast p) ≠ 0 :=
    fun p hp h => hp (hφ (h.trans (map_zero φ).symm))
  have he : φ r = (N.wordExpressions s w i).representatives.evaluate φ := by
    rw [PositiveExpression.representatives_evaluate φ hpos,
      N.wordExpressions_evaluate φ s w i]
    exact heq
  exact nonnegative_support_of_positive_fraction
    (coefficientWeight (frozenCoefficientWeight j)) _ r hr he
    (le_of_eq (N.wordExpressions_frozen_order s w i j).symm)

end NormalizedMutationPattern
end TauCeti.Cluster
