/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.PositiveLaurentTheorem
public import TauCetiRoadmap.ClusterAlgebras.NormalizedCaterpillar

/-! # Laurent -/

@[expose] public section

open TauCeti.Laurent

noncomputable section
namespace TauCeti.Cluster
universe u
variable {I : Type u} [DecidableEq I] [Finite I]

namespace NormalizedCaterpillar
variable {C F : Type u} [CoefficientSemifield C] [Field F]
variable {P : CaterpillarPath I} (D : NormalizedCaterpillar C P)

/-- The Fomin–Zelevinsky normalized mutation laws imply Laurentness in arbitrary
finite rank, with arbitrary coefficient semifield and no full-rank assumption. -/
theorem laurent (f : TotalLaurentRing (Additive C) I →+* F)
    (hf : ∀ p, positiveCast p ≠ 0 → f (positiveCast p) ≠ 0) (k : I) :
    D.toPositive.value f P.target k ∈
      chartRing (coefficientRange f) (D.toPositive.value f P.source) :=
  D.toPositive.laurent f hf k

theorem canonical_laurent (k : I) :
    D.toPositive.value (canonicalMap (G := Additive C) (I := I)) P.target k ∈
      chartRing (coefficientRange
        (canonicalMap (G := Additive C) (I := I)))
        (D.toPositive.value (canonicalMap (G := Additive C) (I := I)) P.source) :=
  D.toPositive.canonical_laurent k

end NormalizedCaterpillar
end TauCeti.Cluster
