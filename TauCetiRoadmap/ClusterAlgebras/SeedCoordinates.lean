/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.WordCoordinates
public import TauCetiRoadmap.ClusterAlgebras.NormalizedWord

/-! # Seed Coordinates -/

@[expose] public section

open TauCeti.Laurent
namespace TauCeti.Cluster.NormalizedMutationPattern
universe u v
variable {C I F : Type u} {V : Type v} [CoefficientSemifield C]
  [DecidableEq I] [Finite I] [Field F]
variable (N : NormalizedMutationPattern C I V)
variable (f : TotalLaurentRing (Additive C) I →+* F)
variable (hf : ∀ p, positiveCast p ≠ 0 → f (positiveCast p) ≠ 0)

include hf in
theorem wordCoordinates_laurent (s : V) (w : List I) (i : I) :
    N.wordCoordinates f s w i ∈
      chartRing (coefficientRange f) (initialVariables f) := by
  apply (N.realizedPattern f hf).laurent_word f (fun s => s.2.val) ?_ ?_ hf w
    (s, PositivePoint.initial f) (fun _ => rfl) i
  · intro s j k hkj
    change mutateCoordinateValues f _ j s.2.val k = s.2.val k
    simp [mutateCoordinateValues, hkj]
  · intro s j
    change mutateCoordinateValues f _ j s.2.val j = _
    simp [mutateCoordinateValues, exchange, realizedPattern]

end TauCeti.Cluster.NormalizedMutationPattern
