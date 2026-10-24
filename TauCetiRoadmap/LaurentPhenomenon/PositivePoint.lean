/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.PositiveRealization

/-! Positive rational coordinate points and their reversible coordinate updates. -/

@[expose] public section
noncomputable section
namespace TauCeti.Laurent
variable {G I F : Type*} [AddCommGroup G] [DecidableEq I] [Field F]
  [IsDomain (AddMonoidAlgebra ℤ (G × (I →₀ ℤ)))]
/-- A coordinate tuple supplied with finite positive expressions whose evaluations give its
entries.
-/
def PositivePoint (f : TotalLaurentRing G I →+* F) :=
  {x : I → F // ∃ e : I → CoordinateExpression G I,
    ∀ i, x i = (e i).evaluate f}

namespace PositivePoint
variable (f : TotalLaurentRing G I →+* F)

/-- The initial Laurent generator tuple, represented by its canonical atomic coordinate
expressions.
-/
def initial : PositivePoint f :=
  ⟨initialVariables f, initialCoordinateExpression,
    fun i => (initialCoordinateExpression_evaluate f i).symm⟩

/-- Apply the exchange formula to a represented coordinate tuple and construct expressions for the
updated tuple.
-/
def update (E : PositiveLaurent G I) (hE : E ≠ 0)
    (i : I) (x : PositivePoint f) : PositivePoint f := by
  refine ⟨mutateCoordinateValues f E i x.val, ?_⟩
  obtain ⟨e, he⟩ := x.property
  refine ⟨mutateCoordinateExpressions E hE i e, ?_⟩
  intro k
  rw [mutateCoordinateExpressions_evaluate]
  congr 1
  exact funext he


omit [DecidableEq I] [IsDomain (AddMonoidAlgebra ℤ (G × (I →₀ ℤ)))] in
theorem evaluate_ne_zero
    (hf : ∀ p, positiveCast p ≠ 0 → f (positiveCast p) ≠ 0)
    (E : PositiveLaurent G I) (hE : E ≠ 0) (x : PositivePoint f) :
    coordinateEvaluate f E x.val ≠ 0 := by
  obtain ⟨e, he⟩ := x.property
  rw [funext he]
  exact coordinateEvaluate_ne_zero f hf E hE e


omit [IsDomain (AddMonoidAlgebra ℤ (G × (I →₀ ℤ)))] in
theorem update_twice
    (hf : ∀ p, positiveCast p ≠ 0 → f (positiveCast p) ≠ 0)
    (E : PositiveLaurent G I) (hE : E ≠ 0)
    (i : I) (hi : PositiveIndependent E i) (x : PositivePoint f) :
    update f E hE i (update f E hE i x) = x := by
  apply Subtype.ext
  change mutateCoordinateValues f E i (mutateCoordinateValues f E i x.val) = x.val
  unfold mutateCoordinateValues
  rw [coordinateEvaluate_update f E i hi]
  funext k
  by_cases hki : k = i
  · subst k
    simp only [Function.update_self]
    exact div_div_cancel₀ (evaluate_ne_zero f hf E hE x)
  · simp [Function.update_of_ne hki]

end PositivePoint

end TauCeti.Laurent
