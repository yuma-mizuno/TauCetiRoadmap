/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.Rechart
public import TauCetiRoadmap.LaurentPhenomenon.SpecializationDescent
public import TauCetiRoadmap.LaurentPhenomenon.GroupRing
public import TauCetiRoadmap.LaurentPhenomenon.GenericChart

/-! # Universal Induction -/

@[expose] public section

noncomputable section
namespace TauCeti.Laurent
universe u
variable {I : Type u} [DecidableEq I]

/-- The induction statement quantifies over coefficient groups and realizations,
so a finite universal deformation and a new source chart remain within its scope. -/
def UniversalLaurent (P : CaterpillarPath I) : Prop :=
  ∀ (G : Type u) [AddCommGroup G] [IsDomain (TotalLaurentRing G I)]
    (F : Type u) [Field F] (T : PositiveCaterpillar G P)
    (f : TotalLaurentRing G I →+* F)
    (_hf : ∀ p, positiveCast p ≠ 0 → f (positiveCast p) ≠ 0) (k : I),
    T.value f P.target k ∈ chartRing (coefficientRange f) (T.value f P.source)

theorem universalLaurent_base (P : CaterpillarPath I) (h : P.length ≤ 2) :
    UniversalLaurent P := by
  intro G _ _ F _ T f hf k
  exact (T.realized f hf).target_mem_of_length_le_two h k

namespace PositiveCaterpillar
variable {G F : Type u} [AddCommGroup G] [IsDomain (TotalLaurentRing G I)] [Field F]
variable {P Q : CaterpillarPath I} (T : PositiveCaterpillar G P)
variable (f : TotalLaurentRing G I →+* F)
variable (hf : ∀ p, positiveCast p ≠ 0 → f (positiveCast p) ≠ 0)

instance deformation_isDomain (h : 3 ≤ P.length) :
    IsDomain (TotalLaurentRing (T.LiftGroup h) I) := by
  let A := FamilyAtom (deformationInputs (T.initialStar h) T.correction)
  let : IsDomain (AddMonoidAlgebra ℤ (A ⊕ I →₀ ℤ)) := groupRing_isDomain _
  exact (AddMonoidAlgebra.mapDomainRingEquiv ℤ (freeGroupLatticeEquiv A I)).toMulEquiv.isDomain _

theorem restriction_laurent (U : PositiveCaterpillar G Q) (e : Q.Vertex → P.Vertex)
    (he : ∀ {a b i}, Q.Edge a b i → P.Edge (e a) (e b) i)
    (hE : ∀ {a b i}, Q.Edge a b i → U.exchange a i = T.exchange (e a) i)
    (ih : UniversalLaurent Q) (k : I) :
    (T.realized f hf).coord (e Q.target) k ∈
      chartRing (coefficientRange f) ((T.realized f hf).coord (e Q.source)) := by
  have hm := ih G F U (T.vertexRechart f hf (e Q.source))
    (T.vertexRechart_positive f hf (e Q.source)) k
  have hc : coefficientRange (T.vertexRechart f hf (e Q.source)) = coefficientRange f :=
    rechart_coefficientRange f _ _
  have hs : U.value (T.vertexRechart f hf (e Q.source)) Q.source = T.value f (e Q.source) :=
    funext (T.restriction_value f hf U e he hE Q.source)
  rw [hc, hs, T.restriction_value f hf U e he hE Q.target k] at hm
  exact hm

include hf in
/-- Assemble the smaller *actual* caterpillars. The local intersection here is
an explicit intermediate input to be discharged at the first generic star. -/
theorem step_of_universal_shorter (h : 3 ≤ P.length)
    (htail : UniversalLaurent P.tail)
    (hthree : P.firstLabel h = P.thirdLabel h → UniversalLaurent P.dropThree)
    (hdetour : ∀ hi : P.firstLabel h ≠ P.thirdLabel h,
      UniversalLaurent (P.detour h (P.firstLabel h) hi))
    (hfirst : chartRing (coefficientRange f) (T.value f (P.spine ⟨1, by omega⟩)) ⊓
      chartRing (coefficientRange f) (T.value f (P.thirdVertex h)) ≤
        chartRing (coefficientRange f) (T.value f P.source)) (k : I) :
    T.value f P.target k ∈ chartRing (coefficientRange f) (T.value f P.source) := by
  apply (T.realized f hf).caterpillar_step h k hfirst
  · exact T.restriction_laurent f hf (T.tail (by omega)) (P.tailEmbedding (by omega))
      (P.tailEmbedding_edge (by omega)) (fun _ => rfl) htail k
  · intro hi
    exact T.restriction_laurent f hf (T.dropThree h) (P.dropThreeEmbedding h)
      (P.dropThreeEmbedding_edge h) (fun _ => rfl) (hthree hi) k
  · intro hi
    exact T.restriction_laurent f hf
      (T.detour h (P.firstLabel h) (P.firstLabel_ne_secondLabel h) hi)
      (P.detourEmbedding h (P.firstLabel h) (P.firstLabel_ne_secondLabel h) hi)
      (P.detourEmbedding_edge h (P.firstLabel h) (P.firstLabel_ne_secondLabel h) hi)
      (fun _ => rfl) (hdetour hi) k

end PositiveCaterpillar

/-- The universal induction step: all smaller statements are used in the generic
pattern, and the resulting finite Laurent representative is specialized back. -/
theorem universalLaurent_step (P : CaterpillarPath I) (h : 3 ≤ P.length)
    (htail : UniversalLaurent P.tail)
    (hthree : P.firstLabel h = P.thirdLabel h → UniversalLaurent P.dropThree)
    (hdetour : ∀ hi : P.firstLabel h ≠ P.thirdLabel h,
      UniversalLaurent (P.detour h (P.firstLabel h) hi))
    (hlocal : ∀ (G : Type u) [AddCommGroup G] [IsDomain (TotalLaurentRing G I)]
      (T : PositiveCaterpillar G P),
      let U := T.deform h
      let f := canonicalMap (G := T.LiftGroup h) (I := I)
      chartRing (coefficientRange f) (U.value f (P.spine ⟨1, by omega⟩)) ⊓
        chartRing (coefficientRange f) (U.value f (P.thirdVertex h)) ≤
          chartRing (coefficientRange f) (U.value f P.source)) :
    UniversalLaurent P := by
  intro G _ _ F _ T f hf k
  apply T.deform_chart_descent h f hf P.target k
  exact (T.deform h).step_of_universal_shorter _
    canonicalMap_positive h htail hthree hdetour (hlocal G T) k

end TauCeti.Laurent
