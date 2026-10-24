/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.FirstStarModel
public import TauCetiRoadmap.LaurentPhenomenon.UniversalInduction

/-! The complete positive Caterpillar proof: finite coefficient deformation,
the explicit three-edge cancellation and coprimality calculation, induction
over shorter actual trees, and specialization of a finite Laurent representative.
The public theorems assume no local intersection, coprimality, or Laurent result. -/

@[expose] public section

noncomputable section
namespace TauCeti.Laurent
universe u
variable {I : Type u} [DecidableEq I] [Finite I]


/-- The coefficient group and realization are universally quantified *inside*
the induction, so each shorter path admits its own fresh finite deformation. -/
theorem universalLaurent (P : CaterpillarPath I) : UniversalLaurent P := by
  apply CaterpillarPath.strong_induction UniversalLaurent universalLaurent_base ?_ P
  intro Q h htail hthree hdetour
  apply universalLaurent_step Q h htail hthree hdetour
  intro G _ _ T
  exact T.deform_first_intersection h

namespace PositiveCaterpillar
variable {G F : Type u} [AddCommGroup G] [IsDomain (TotalLaurentRing G I)] [Field F]
variable {P : CaterpillarPath I} (T : PositiveCaterpillar G P)

/-- Laurentness for every finite positive caterpillar and every realization
which does not annihilate a nonzero positive Laurent polynomial. -/
theorem laurent (f : TotalLaurentRing G I →+* F)
    (hf : ∀ p, positiveCast p ≠ 0 → f (positiveCast p) ≠ 0) (k : I) :
    T.value f P.target k ∈ chartRing (coefficientRange f) (T.value f P.source) :=
  universalLaurent P G F T f hf k

/-- The formal Laurent phenomenon in the canonical rational-function field. -/
theorem canonical_laurent (k : I) :
    T.value (canonicalMap (G := G) (I := I)) P.target k ∈
      chartRing (coefficientRange (canonicalMap (G := G) (I := I)))
        (T.value (canonicalMap (G := G) (I := I)) P.source) :=
  T.laurent _ canonicalMap_positive k

end PositiveCaterpillar

end TauCeti.Laurent
