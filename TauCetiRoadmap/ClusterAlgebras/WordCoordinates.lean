/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.MutationPattern
public import TauCetiRoadmap.ClusterAlgebras.Normalization
public import TauCetiRoadmap.LaurentPhenomenon.PositivePoint

/-! # Word Coordinates -/

@[expose] public section

open TauCeti.Laurent

/-!
# Constructed coordinates for normalized seed patterns

The constructor carries actual field values, not a freely chosen realization
with mutation laws supplied by the caller. Under the positive nonvanishing
hypothesis on the coefficient realization, positive expressions certify that
the coordinate updates and their inverses are defined. The canonical fraction
field realization supplies this hypothesis automatically.
-/
noncomputable section
namespace TauCeti.Cluster
variable {C I F V : Type*} [CoefficientSemifield C]
  [DecidableEq I] [Finite I] [Field F]

namespace NormalizedMutationPattern
variable (N : NormalizedMutationPattern C I V)
variable (f : TotalLaurentRing (Additive C) I →+* F)
variable (hf : ∀ p, positiveCast p ≠ 0 → f (positiveCast p) ≠ 0)

/-- The normalized positive exchange binomial attached to a state and direction. -/
def exchange (s : V) (i : I) : PositiveLaurent (Additive C) I :=
  seedExchange (N.coefficient s i) (fun h => N.matrix s h i)

theorem exchange_ne_zero (s : V) (i : I) : N.exchange s i ≠ 0 :=
  seedExchange_ne_zero _ _

theorem exchange_independent (s : V) (i : I) : PositiveIndependent (N.exchange s i) i :=
  seedExchange_independent _ _ _ (N.diagonal s i)

theorem exchange_mutation (s : V) (i : I) :
    N.exchange (N.mutation i s) i = N.exchange s i := by
  unfold exchange
  rw [N.coefficient_self, N.matrix_law]
  have hc : (fun h => matrixMutation (N.matrix s) i h i) =
      (fun h => -N.matrix s h i) := by
    funext h
    simp [matrixMutation]
  rw [hc, seedExchange_own_mutation]

/-- An underlying pattern state together with a tuple represented by finite positive coordinate
expressions at f.
-/
abbrev RealizedSeed (_N : NormalizedMutationPattern C I V)
    (f : TotalLaurentRing (Additive C) I →+* F) := V × PositivePoint f

/-- Mutate the pattern state and its realized positive coordinate point together. -/
def mutateRealized (i : I) (s : N.RealizedSeed f) : N.RealizedSeed f :=
  (N.mutation i s.1, PositivePoint.update f (N.exchange s.1 i)
    (N.exchange_ne_zero s.1 i) i s.2)

include hf in
theorem mutateRealized_involutive (i : I) : Function.Involutive (N.mutateRealized f i) := by
  intro s
  apply Prod.ext
  · exact N.involutive i s.1
  · change PositivePoint.update f (N.exchange (N.mutation i s.1) i)
      (N.exchange_ne_zero _ _) i
      (PositivePoint.update f (N.exchange s.1 i) (N.exchange_ne_zero _ _) i s.2) = s.2
    simp only [N.exchange_mutation]
    exact PositivePoint.update_twice f hf _ _ _ (N.exchange_independent _ _) _

/-- The original normalized mutation pattern lifted to realized coordinate seeds. -/
def realizedPattern : NormalizedMutationPattern C I (N.RealizedSeed f) where
  mutation := N.mutateRealized f
  involutive := N.mutateRealized_involutive f hf
  matrix s := N.matrix s.1
  coefficient s := N.coefficient s.1
  diagonal s := N.diagonal s.1
  signSkew s := N.signSkew s.1
  matrix_law s := N.matrix_law s.1
  coefficient_self s := N.coefficient_self s.1
  coefficient_other s := N.coefficient_other s.1

/-- Actual evaluation of a mutation word, starting from the initial coordinate
chart. No coordinate realization or mutation laws are arguments. -/
def wordCoordinates (s : V) (w : List I) : I → F :=
  (mutateWord (N.mutateRealized f) w (s, PositivePoint.initial f)).2.val

@[simp] theorem wordCoordinates_nil (s : V) :
    N.wordCoordinates f s [] = initialVariables f := rfl

theorem mutateWord_data (w : List I) (s : N.RealizedSeed f) :
    (mutateWord (N.mutateRealized f) w s).1 = mutateWord N.mutation w s.1 := by
  induction w generalizing s with
  | nil => rfl
  | cons i w ih => exact ih (N.mutateRealized f i s)

/-- The constructed values satisfy the literal forward mutation recurrence. -/
theorem wordCoordinates_append_single (s : V) (w : List I) (i : I) :
    N.wordCoordinates f s (w ++ [i]) =
      mutateCoordinateValues f (N.exchange (mutateWord N.mutation w s) i) i
        (N.wordCoordinates f s w) := by
  unfold wordCoordinates
  rw [mutateWord_append]
  change mutateCoordinateValues f
    (N.exchange (mutateWord (N.mutateRealized f) w (s, PositivePoint.initial f)).1 i) i
    (mutateWord (N.mutateRealized f) w (s, PositivePoint.initial f)).2.val = _
  rw [N.mutateWord_data]

include hf in
theorem wordCoordinates_reduce (s : V) (w : List I) :
    N.wordCoordinates f s (reduceMutationWord w) = N.wordCoordinates f s w := by
  unfold wordCoordinates
  rw [mutateWord_reduce (N.mutateRealized f) (N.mutateRealized_involutive f hf)]

end NormalizedMutationPattern
end TauCeti.Cluster
