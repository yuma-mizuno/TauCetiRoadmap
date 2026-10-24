/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.GroupedLocalAlgebra
public import TauCetiRoadmap.LaurentPhenomenon.RealizedLocalCoordinates

/-! # First Star Model -/

@[expose] public section

namespace TauCeti.Laurent
noncomputable section
open Polynomial
open scoped LaurentPolynomial

namespace PositiveCaterpillar
variable {G I : Type*} [AddCommGroup G] [DecidableEq I]
variable {P : CaterpillarPath I} (T : PositiveCaterpillar G P)

/-- The first exchange polynomial, independent of the first variable and expressed in its
complementary coefficient ring.
-/
def localE (h : 3 ≤ P.length) : MutableCoefficientRing G I (P.firstLabel h) :=
  eraseMutable (P.firstLabel h) (positiveCast (T.exchange (P.spine ⟨1, by omega⟩) (P.firstLabel h)))

/-- The second exchange polynomial, grouped by the first mutable variable. -/
def localQ (h : 3 ≤ P.length) : Polynomial (MutableCoefficientRing G I (P.firstLabel h)) :=
  groupedPolynomial (T.exchange (P.spine ⟨1, by omega⟩) (P.secondLabel h)) (P.firstLabel h)

/-- The third exchange polynomial in the first mutable variable's complementary coefficient ring. -/
def localR (h : 3 ≤ P.length) : Polynomial (MutableCoefficientRing G I (P.firstLabel h)) :=
  regroupedPolynomial (T.exchange (P.spine ⟨2, by omega⟩) (P.firstLabel h))
    (P.firstLabel h) (P.secondLabel h)

/-- The propagation correction after substituting the second exchange's zero-value term and
erasing the first variable.
-/
def localA (h : 3 ≤ P.length) : MutableCoefficientRing G I (P.firstLabel h) :=
  eraseMutable (P.firstLabel h) (positiveCast
    (positiveSubstitute (T.correction ⟨0, by omega⟩ (P.firstLabel h))
      (positiveSetZero (T.exchange (P.spine ⟨1, by omega⟩) (P.secondLabel h)) (P.firstLabel h))
      (P.secondLabel h)))

/-- The inverse of the second mutable variable in the first variable's complementary coefficient
ring.
-/
def localYinv (_T : PositiveCaterpillar G P) (h : 3 ≤ P.length) : MutableCoefficientRing G I
  (P.firstLabel h) :=
  eraseMutable (P.firstLabel h)
    (AddMonoidAlgebra.single (0, Finsupp.single (P.secondLabel h) (-1)) 1)

theorem localYinv_unit (h : 3 ≤ P.length) : IsUnit (T.localYinv h) :=
  eraseMutable_inverse_unit _ _

theorem local_compatibility [IsDomain (TotalLaurentRing G I)] (h : 3 ≤ P.length) :
    (T.localR h).eval (T.localYinv h * (T.localQ h).eval 0) = T.localA h * T.localE h := by
  have hp := T.correction_reverse_identity (⟨0, by omega⟩ : Fin (P.length - 2)) (P.firstLabel h)
    (by
      simpa [CaterpillarPath.middleLabel, CaterpillarPath.rightLabel, CaterpillarPath.rightIndex,
        CaterpillarPath.interiorLeft, CaterpillarPath.secondLabel]
        using (P.firstLabel_ne_secondLabel h))
  change (regroupedPolynomial _ _ _).eval (_ * (groupedPolynomial _ _).eval 0) =
    eraseMutable _ (positiveCast _) * eraseMutable _ (positiveCast _)
  apply regroupedPolynomial_compatibility
    (T.exchange (P.spine ⟨1, by omega⟩) (P.firstLabel h))
    (T.exchange (P.spine ⟨1, by omega⟩) (P.secondLabel h))
    (T.correction ⟨0, by omega⟩ (P.firstLabel h))
    (T.exchange (P.spine ⟨2, by omega⟩) (P.firstLabel h)) _ _
  · exact fun a ha ↦ T.exchange_polynomial _ _ a ha _
  · exact fun a ha ↦ T.exchange_polynomial _ _ a ha _
  · simpa [CaterpillarPath.leftStar, CaterpillarPath.rightStar, CaterpillarPath.middleLabel,
      CaterpillarPath.internalIndex, CaterpillarPath.interiorLeft, CaterpillarPath.interiorRight,
      CaterpillarPath.rightLabel, CaterpillarPath.rightIndex, CaterpillarPath.secondLabel] using hp

theorem deform_local_coprime (h : 3 ≤ P.length) :
    (T.deform h).localE h ≠ 0 ∧
    IsRelPrime ((T.deform h).localE h) (((T.deform h).localQ h).eval 0) ∧
    IsRelPrime ((T.deform h).localE h) ((T.deform h).localA h) := by
  classical
  let p := deformationInputs (T.initialStar h) T.correction
  let i := P.firstLabel h
  let j := P.secondLabel h
  have hij : i ≠ j := P.firstLabel_ne_secondLabel h
  have hmid : P.middleLabel (⟨0, by omega⟩ : Fin (P.length - 2)) = j := rfl
  have hcert := firstStar_erased_certificates p (.inl i) (.inl j) (.inr (⟨0, by omega⟩, i))
    (by intro heq; exact hij (Sum.inl.inj heq).symm) (by intro heq; cases heq)
    (T.exchange_ne_zero _ i) (T.correction_ne_zero _ i (hmid ▸ hij))
    (T.exchange_no_factor _ j) i j hij (T.exchange_independent _ i)
    (T.correction_independent _ i (hmid ▸ hij))
    (by
      rw [← T.deform_firstStar h j]
      exact fun a ha ↦ (T.deform h).exchange_polynomial _ _ a ha i)
  simpa only [localE, localQ, localA, T.deform_firstStar, T.deform_correction] using hcert

/-- Assemble the first three-edge chart model from coordinate formulas and scalar coprimality
certificates.
-/
def firstPolynomialLocalModel {F : Type*} [Field F] [IsDomain (TotalLaurentRing G I)]
    (f : TotalLaurentRing G I →+* F)
    (hf : ∀ p, positiveCast p ≠ 0 → f (positiveCast p) ≠ 0) (hfi : Function.Injective f)
    (h : 3 ≤ P.length) (hE : T.localE h ≠ 0)
    (hq : IsRelPrime (T.localE h) ((T.localQ h).eval 0))
    (hA : IsRelPrime (T.localE h) (T.localA h)) :
    (T.realized f hf).PolynomialLocalModel (d := P.thirdVertex h)
      (CaterpillarPath.Edge.path_forward (P := P) ⟨0, by omega⟩)
      (CaterpillarPath.Edge.path_forward (P := P) ⟨1, by omega⟩)
      (P.firstLabel_ne_secondLabel h) (MutableCoefficientRing G I (P.firstLabel h)) where
  equiv := T.sourceLaurentEquiv f hfi (P.firstLabel h)
  E := T.localE h
  A := T.localA h
  yinv := T.localYinv h
  Q := T.localQ h
  R := T.localR h
  E_ne_zero := hE
  relPrime_constant := hq
  relPrime_correction := hA
  yinv_unit := T.localYinv_unit h
  compatibility := T.local_compatibility h
  first_eq := T.sourceLaurent_first f hf h hfi _
  second_eq := T.sourceLaurent_second f hf h hfi _
  third_exchange := T.value_third_exchange_ring f hf h hfi

local instance firstDeformationDomain (h : 3 ≤ P.length) :
    IsDomain (TotalLaurentRing (T.LiftGroup h) I) := freeGroupTotal_isDomain _ _

theorem deform_first_intersection [Finite I] (h : 3 ≤ P.length) :
    let U := T.deform h
    let f := canonicalMap (G := T.LiftGroup h) (I := I)
    chartRing (coefficientRange f) (U.value f (P.spine ⟨1, by omega⟩)) ⊓
      chartRing (coefficientRange f) (U.value f (P.thirdVertex h)) ≤
        chartRing (coefficientRange f) (U.value f P.source) := by
  classical
  let U := T.deform h
  let : IsDomain (TotalLaurentRing (T.LiftGroup h) I) := freeGroupTotal_isDomain _ _
  let f := canonicalMap (G := T.LiftGroup h) (I := I)
  have hfi : Function.Injective f := IsFractionRing.injective _ _
  let : IsDomain (MutableCoefficientRing (T.LiftGroup h) I (P.firstLabel h)) :=
    genericCoefficientRing_isDomain _ _ _
  let : UniqueFactorizationMonoid (MutableCoefficientRing (T.LiftGroup h) I (P.firstLabel h)) :=
    genericCoefficientRing_uniqueFactorizationMonoid _ _ _
  have hsource : U.value f P.source = initialVariables f := U.value_source_tuple f
  let : UniqueFactorizationMonoid (chartRing (coefficientRange f) (U.value f P.source)) := by
    rw [hsource]
    exact genericInitialChart_uniqueFactorizationMonoid f hfi
  let : DecompositionMonoid (chartRing (coefficientRange f) (U.value f P.source)) := inferInstance
  obtain ⟨hE, hq, hA⟩ := T.deform_local_coprime h
  let M := U.firstPolynomialLocalModel f canonicalMap_positive hfi h hE hq hA
  let : DecompositionMonoid (chartRing (coefficientRange f)
      ((U.realized f canonicalMap_positive).coord (P.spine ⟨0, by omega⟩))) := by
    change DecompositionMonoid (chartRing (coefficientRange f) (U.value f P.source))
    infer_instance
  exact M.intersection (P.thirdVertex_edge h)

end PositiveCaterpillar
end
end TauCeti.Laurent
