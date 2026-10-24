/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.MutationPattern
public import TauCetiRoadmap.ClusterAlgebras.Laurent
public import TauCetiRoadmap.LaurentPhenomenon.PathRealization

/-! # Normalized Word -/

@[expose] public section

open TauCeti.Laurent

namespace TauCeti.Cluster
noncomputable section
universe u v

namespace NormalizedMutationPattern
variable {C I : Type u} {V : Type v} [CoefficientSemifield C] [DecidableEq I] [Finite I]
variable (N : NormalizedMutationPattern C I V)

/-- A submitted finite mutation word determines genuine seed data on every spine and leaf. -/
def toCaterpillar (P : CaterpillarPath I) (s : V) : NormalizedCaterpillar C P where
  matrix a := N.matrix (P.seedAt N.mutation s a)
  coefficient a := N.coefficient (P.seedAt N.mutation s a)
  diagonal a := N.diagonal _
  signSkew a := N.signSkew _
  matrix_law he := by
    rw [P.seedAt_edge N.mutation s N.involutive he]
    exact N.matrix_law _ _
  coefficient_self he := by
    rw [P.seedAt_edge N.mutation s N.involutive he]
    exact N.coefficient_self _ _
  coefficient_other he i hi := by
    rw [P.seedAt_edge N.mutation s N.involutive he]
    exact N.coefficient_other _ _ i hi

variable {F : Type u} [Field F]
variable (f : TotalLaurentRing (Additive C) I →+* F)
variable (x : V → I → F)
variable (hother : ∀ s i k, k ≠ i → x (N.mutation i s) k = x s k)
variable (hexchange : ∀ s i, x (N.mutation i s) i =
  coordinateEvaluate f (seedExchange (N.coefficient s i) (fun h ↦ N.matrix s h i)) (x s) / x s i)
include hother hexchange

/-- The canonical finite-tree realization agrees with the supplied actual cluster coordinates. -/
theorem coordinate_value_eq (P : CaterpillarPath I) (s : V)
    (hsource : ∀ i, x s i = initialVariables f i) (a : P.Vertex) (i : I) :
    x (P.seedAt N.mutation s a) i = (N.toCaterpillar P s).toPositive.value f a i := by
  apply (N.toCaterpillar P s).toPositive.value_unique f (fun a ↦ x (P.seedAt N.mutation s a))
  · intro k
    simpa [initialVariables] using hsource k
  · intro a b j he k hkj
    rw [P.seedAt_edge N.mutation s N.involutive he]
    exact hother _ j k hkj
  · intro a b j he
    rw [P.seedAt_edge N.mutation s N.involutive he]
    exact hexchange _ j

/-- The normalized Laurent phenomenon for every finite mutation word, including words
with neighboring repeated labels. Cancellation is proved using mutation involutivity. -/
theorem laurent_word
    (hf : ∀ p, positiveCast p ≠ 0 → f (positiveCast p) ≠ 0)
    (w : List I) (s : V) (hsource : ∀ i, x s i = initialVariables f i) (k : I) :
    x (mutateWord N.mutation w s) k ∈
      chartRing (coefficientRange f) (x s) := by
  let P := reducedWordPath w
  let D := N.toCaterpillar P s
  have hm := D.laurent f hf k
  have heq := N.coordinate_value_eq f x hother hexchange P s hsource P.target k
  have hs : D.toPositive.value f P.source = x s := by
    funext i
    exact (D.toPositive.value_source f i).trans (hsource i).symm
  rw [hs, ← heq] at hm
  rw [reducedWordPath_target N.mutation N.involutive w s] at hm
  exact hm

/-- An injective initial Laurent-chart map automatically supplies the positive
nonvanishing hypothesis. This is the usual algebraically independent seed case. -/
theorem laurent_word_of_injective (hfi : Function.Injective f)
    (w : List I) (s : V) (hsource : ∀ i, x s i = initialVariables f i) (k : I) :
    x (mutateWord N.mutation w s) k ∈
      chartRing (coefficientRange f) (x s) :=
  N.laurent_word f x hother hexchange
    (fun _ hp hz => hp (hfi (hz.trans (map_zero f).symm))) w s hsource k

end NormalizedMutationPattern
end
end TauCeti.Cluster
