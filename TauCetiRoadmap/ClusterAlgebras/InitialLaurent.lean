/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.InitialSeed
public import TauCetiRoadmap.ClusterAlgebras.UpperLaurent
public import TauCetiRoadmap.LaurentPhenomenon.CoefficientChart

/-! # Initial Laurent -/

@[expose] public section

open TauCeti.Laurent

/-!
# Laurent theorem from initial matrix and coefficient data
Only a positive integral symmetrizer, its matrix identity, and initial
coefficients are needed. Coordinates, all mutation laws, and the mutation pattern
are constructed. No reachability laws or coordinate exchange equations are inputs.
-/
noncomputable section
namespace TauCeti.Cluster.MatrixSeed
universe u
variable {C I : Type u} [CoefficientSemifield C] [DecidableEq I] [Finite I]
  {d : I → ℤ} (hd : ∀ i, 0 < d i) (s : MatrixSeed C I d)

/-- The canonical fraction field of the integer Laurent ring in the coefficient group and mutable
variables.
-/
abbrev Ambient (C I : Type*) [CoefficientSemifield C] :=
  FractionRing (TotalLaurentRing (Additive C) I)

/-- The canonical cluster coordinates after an arbitrary mutation word. -/
def cluster (w : List I) : I → Ambient C I :=
  (pattern hd).wordCoordinates canonicalMap s w

@[simp] theorem cluster_nil : s.cluster hd [] =
    initialVariables (canonicalMap (G := Additive C) (I := I)) := rfl

theorem cluster_laurent (w : List I) (i : I) :
    s.cluster hd w i ∈
      chartRing (coefficientRange
        (canonicalMap (G := Additive C) (I := I)))
        (initialVariables canonicalMap) := by
  let := Fintype.ofFinite I
  obtain ⟨r, hr⟩ := matrixSeed_integral_laurent hd s w i
  change (pattern hd).wordCoordinates (algebraMap _ _) s w i ∈ _
  rw [← hr]
  exact laurent_image_mem_initialChart _ r

/-- A unique finite Laurent polynomial for every constructed cluster coordinate. -/
theorem cluster_laurent_unique (w : List I) (i : I) :
    ∃! p : TotalLaurentRing (Additive C) I,
      algebraMap _ (Ambient C I) p = s.cluster hd w i := by
  have h := s.cluster_laurent hd w i
  rw [initialChart_eq_range] at h
  obtain ⟨p, hp⟩ := h
  refine ⟨p, hp, ?_⟩
  intro q hq
  exact IsFractionRing.injective (TotalLaurentRing (Additive C) I) (Ambient C I)
    (hq.trans hp.symm)

/-- The usual exchange recurrence for the canonical constructed cluster. -/
theorem cluster_append_single (w : List I) (i : I) :
    s.cluster hd (w ++ [i]) = mutateCoordinateValues canonicalMap
      (seedExchange ((mutateWord (mutate hd) w s).coefficient i)
        (fun h => (mutateWord (mutate hd) w s).matrix h i)) i (s.cluster hd w) :=
  (pattern hd).wordCoordinates_append_single _ s w i

theorem cluster_reduce (w : List I) :
    s.cluster hd (reduceMutationWord w) = s.cluster hd w := by
  let f : TotalLaurentRing (Additive C) I →+* Ambient C I :=
    canonicalMap
  have hf : ∀ p : PositiveLaurent (Additive C) I,
      positiveCast p ≠ 0 → f (positiveCast p) ≠ 0 :=
    canonicalMap_positive
  exact (pattern hd).wordCoordinates_reduce f hf s w

end TauCeti.Cluster.MatrixSeed
