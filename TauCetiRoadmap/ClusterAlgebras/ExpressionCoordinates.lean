/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.WordCoordinates

/-! Deterministic positive expressions for the constructed cluster coordinates. -/

@[expose] public section
noncomputable section
namespace TauCeti.Cluster.NormalizedMutationPattern
open TauCeti.Laurent
variable {C I F V : Type*} [CoefficientSemifield C] [DecidableEq I] [Finite I] [Field F]
variable (N : NormalizedMutationPattern C I V)

/-- Mutate the underlying state and its tuple of finite positive coordinate expressions together. -/
def mutateExpressions (i : I) (s : V × (I → CoordinateExpression (Additive C) I)) :
    V × (I → CoordinateExpression (Additive C) I) :=
  (N.mutation i s.1, mutateCoordinateExpressions (N.exchange s.1 i) (N.exchange_ne_zero s.1 i) i
    s.2)

/-- The coordinate expressions obtained from the initial variables along a mutation word. -/
def wordExpressions (s : V) (w : List I) : I → CoordinateExpression (Additive C) I :=
  (mutateWord N.mutateExpressions w (s, initialCoordinateExpression)).2

/-- Evaluate a state's coordinate expressions to obtain a realized seed at f. -/
def expressionSeed (f : TotalLaurentRing (Additive C) I →+* F)
    (s : V × (I → CoordinateExpression (Additive C) I)) : N.RealizedSeed f :=
  (s.1, ⟨fun i => (s.2 i).evaluate f, s.2, fun _ => rfl⟩)

theorem expressionSeed_mutate (f : TotalLaurentRing (Additive C) I →+* F)
    (i : I) (s : V × (I → CoordinateExpression (Additive C) I)) :
    N.expressionSeed f (N.mutateExpressions i s) = N.mutateRealized f i (N.expressionSeed f s) := by
  apply Prod.ext
  · rfl
  · apply Subtype.ext
    funext j
    exact mutateCoordinateExpressions_evaluate f _ _ i j s.2

theorem expressionSeed_mutateWord (f : TotalLaurentRing (Additive C) I →+* F)
    (w : List I) (s : V × (I → CoordinateExpression (Additive C) I)) :
    N.expressionSeed f (mutateWord N.mutateExpressions w s) =
      mutateWord (N.mutateRealized f) w (N.expressionSeed f s) := by
  induction w generalizing s with
  | nil => rfl
  | cons i w ih =>
    simp only [mutateWord_cons, ih, expressionSeed_mutate]

theorem wordExpressions_evaluate (f : TotalLaurentRing (Additive C) I →+* F)
    (s : V) (w : List I) (i : I) :
    (N.wordExpressions s w i).evaluate f = N.wordCoordinates f s w i := by
  have h := congrArg (fun t : N.RealizedSeed f => t.2.val i)
    (N.expressionSeed_mutateWord f w (s, initialCoordinateExpression))
  have hi : N.expressionSeed f (s, initialCoordinateExpression) = (s, PositivePoint.initial f) := by
    apply Prod.ext
    · rfl
    · apply Subtype.ext
      funext j
      exact initialCoordinateExpression_evaluate f j
  rw [hi] at h
  exact h

/-- A Laurent representation established in the universal ambient field
specializes to every realization where the positive exchange expressions are
defined. This lemma is independent of the proof producing the representation. -/
theorem wordCoordinates_specialize (f : TotalLaurentRing (Additive C) I →+* F)
    (hf : ∀ p, positiveCast p ≠ 0 → f (positiveCast p) ≠ 0)
    (s : V) (w : List I) (i : I) (r : TotalLaurentRing (Additive C) I)
    (hr : algebraMap _ (FractionRing (TotalLaurentRing (Additive C) I)) r =
      N.wordCoordinates (algebraMap _ _) s w i) :
    N.wordCoordinates f s w i = f r := by
  rw [← N.wordExpressions_evaluate]
  apply PositiveExpression.specialize_laurent_at f (N.wordExpressions s w i)
    (PositiveExpression.definedAt_of_positive f hf _) r
  rw [N.wordExpressions_evaluate]
  exact hr.symm

end TauCeti.Cluster.NormalizedMutationPattern
