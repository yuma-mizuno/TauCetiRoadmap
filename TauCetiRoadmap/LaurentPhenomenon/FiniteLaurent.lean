/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.CoefficientRing
public import TauCetiRoadmap.LaurentPhenomenon.PositiveLaurentTheorem
public import TauCetiRoadmap.LaurentPhenomenon.PositiveFraction

/-!
# Laurentness under finite denominator hypotheses

Canonical Laurentness produces one finite representative in the integer group
ring. Specialization needs nonvanishing only of operands actually inverted in
the target coordinate expression. In particular the specialization field may
have positive characteristic.
-/

@[expose] public section
noncomputable section
namespace TauCeti.Laurent
universe u v
namespace PositiveCaterpillar
variable {G I : Type u} [AddCommGroup G] [DecidableEq I] [Finite I]
variable [IsDomain (TotalLaurentRing G I)] {P : CaterpillarPath I}
variable (T : PositiveCaterpillar G P)

/-- The canonical coordinate has a unique finite Laurent representative. -/
theorem exists_unique_canonical_laurent_representative (k : I) :
    ∃! r : TotalLaurentRing G I,
      T.value (canonicalMap (G := G) (I := I)) P.target k = canonicalMap r := by
  have h := T.canonical_laurent k
  rw [T.value_source_tuple, initialChart_eq_range] at h
  obtain ⟨r, hr⟩ := h
  refine ⟨r, hr.symm, ?_⟩
  intro s hs
  exact IsFractionRing.injective (TotalLaurentRing G I) (FractionRing (TotalLaurentRing G I))
    (hs.symm.trans hr.symm)

/-- The Laurent phenomenon at one specified target coordinate, assuming only
that the finite expression for this coordinate has defined inversions. -/
theorem laurent_at {F : Type v} [Field F] (f : TotalLaurentRing G I →+* F)
    (k : I) (hx : (T.vertexExpression P.target k).DefinedAt f) :
    T.value f P.target k ∈ chartRing (coefficientRange f) (T.value f P.source) := by
  obtain ⟨r, hr, _⟩ := T.exists_unique_canonical_laurent_representative k
  have he : T.value f P.target k = f r :=
    PositiveExpression.specialize_laurent_at f (T.vertexExpression P.target k) hx r hr
  rw [he]
  exact T.image_mem_source f r

omit [Finite I] in
/-- A canonical Laurent representative specializes to the target coordinate
wherever that coordinate's finite expression is defined. -/
theorem canonical_laurent_representative_specializes {F : Type v} [Field F]
    (f : TotalLaurentRing G I →+* F) (k : I)
    (hx : (T.vertexExpression P.target k).DefinedAt f) (r : TotalLaurentRing G I)
    (hr : T.value (canonicalMap (G := G) (I := I)) P.target k = canonicalMap r) :
    T.value f P.target k = f r :=
  PositiveExpression.specialize_laurent_at f (T.vertexExpression P.target k) hx r hr

/-- The same canonical representative, presented as a Laurent polynomial over
the coefficient group ring rather than as a product group ring. -/
theorem exists_unique_canonical_coefficient_laurent (k : I) :
    ∃! r : LaurentEvaluation.Ring (AddMonoidAlgebra ℤ G) I,
      T.value (canonicalMap (G := G) (I := I)) P.target k =
        canonicalMap (LaurentEvaluation.coefficientRingEquiv.symm r) := by
  let e := LaurentEvaluation.coefficientRingEquiv (R := ℤ) (G := G) (I := I)
  obtain ⟨r, hr, hu⟩ := T.exists_unique_canonical_laurent_representative k
  refine ⟨e r, by simpa [e] using hr, ?_⟩
  intro s hs
  apply e.symm.injective
  simpa [e] using hu (e.symm s) hs

omit [Finite I] in
/-- Specialization of the canonical representative agrees with the generic
Laurent evaluator, using the coefficient-ring equivalence as the bridge. -/
theorem coefficient_laurent_representative_specializes {F : Type v} [Field F]
    (c : AddMonoidAlgebra ℤ G →+* F) (x : I → Fˣ) (k : I)
    (hx : (T.vertexExpression P.target k).DefinedAt
      ((LaurentEvaluation.eval c x).comp LaurentEvaluation.coefficientRingEquiv.toRingHom))
    (r : LaurentEvaluation.Ring (AddMonoidAlgebra ℤ G) I)
    (hr : T.value (canonicalMap (G := G) (I := I)) P.target k =
      canonicalMap (LaurentEvaluation.coefficientRingEquiv.symm r)) :
    T.value ((LaurentEvaluation.eval c x).comp
      LaurentEvaluation.coefficientRingEquiv.toRingHom) P.target k =
      LaurentEvaluation.eval c x r := by
  let e : TotalLaurentRing G I ≃+*
      LaurentEvaluation.Ring (AddMonoidAlgebra ℤ G) I :=
    LaurentEvaluation.coefficientRingEquiv
  let f : TotalLaurentRing G I →+* F := (LaurentEvaluation.eval c x).comp e.toRingHom
  have h : T.value f P.target k = f (e.symm r) :=
    T.canonical_laurent_representative_specializes f k hx (e.symm r) hr
  change T.value f P.target k = LaurentEvaluation.eval c x r
  calc
    T.value f P.target k = f (e.symm r) := h
    _ = LaurentEvaluation.eval c x r := by
      change LaurentEvaluation.eval c x (e (e.symm r)) = _
      rw [e.apply_symm_apply]

end PositiveCaterpillar
end TauCeti.Laurent
