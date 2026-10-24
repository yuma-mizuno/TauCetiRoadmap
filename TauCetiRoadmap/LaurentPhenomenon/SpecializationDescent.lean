/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.PositiveCaterpillarRealization
public import TauCetiRoadmap.LaurentPhenomenon.CoefficientChart

/-! # Specialization Descent -/

@[expose] public section

noncomputable section
namespace TauCeti.Laurent
open scoped BigOperators
variable {G I F : Type*} [AddCommGroup G] [DecidableEq I] [Field F]

namespace PositiveCaterpillar
variable [IsDomain (TotalLaurentRing G I)] {P : CaterpillarPath I}
  (T : PositiveCaterpillar G P)

theorem value_eq_positiveFractionEmbedding (s : P.Vertex) (i : I) :
    T.value (canonicalMap (G := G) (I := I)) s i =
      positiveFractionEmbedding (positiveCast (G := G × (I →₀ ℤ)))
        (T.vertexExpression s i).representatives.value := by
  exact (PositiveExpression.specialize_representatives (canonicalMap (G := G) (I := I))
    (canonicalMap_positive (G := G) (I := I)) (T.vertexExpression s i)).symm

/-- C6 descends actual generic chart membership by extracting one finite Laurent
    representative, descending its equality, then specializing that representative. -/
theorem value_chart_descent (f : TotalLaurentRing G I →+* F)
    (hf : ∀ p, positiveCast p ≠ 0 → f (positiveCast p) ≠ 0)
    (s : P.Vertex) (i : I)
    (h : T.value (canonicalMap (G := G) (I := I)) s i ∈
      chartRing (coefficientRange (canonicalMap (G := G) (I := I)))
        (T.value (canonicalMap (G := G) (I := I)) P.source)) :
    T.value f s i ∈ chartRing (coefficientRange f) (T.value f P.source) := by
  have hsource0 : T.value (canonicalMap (G := G) (I := I)) P.source =
      initialVariables (canonicalMap (G := G) (I := I)) := by
    funext k
    exact T.value_source _ k
  have hsourcef : T.value f P.source = initialVariables f := by
    funext k
    exact T.value_source f k
  rw [hsource0, initialChart_eq_range] at h
  obtain ⟨r, hr⟩ := h
  have hrep : positiveFractionEmbedding (positiveCast (G := G × (I →₀ ℤ)))
      (T.vertexExpression s i).representatives.value =
      algebraMap _ (FractionRing (TotalLaurentRing G I)) r :=
    (T.value_eq_positiveFractionEmbedding s i).symm.trans hr.symm
  rw [T.value_specialize_laurent f hf s i r hrep, hsourcef]
  exact laurent_image_mem_initialChart f r

omit [DecidableEq I] [IsDomain (TotalLaurentRing G I)] in
/-- Coefficient inclusion commutes with arbitrary group specialization. -/
theorem coefficientInclusion_natural {H : Type*} [AddCommGroup H] (η : G →+ H) :
    (integerCoefficientMap (I := I) η).comp (coefficientInclusion (G := G) (I := I)) =
      (coefficientInclusion (G := H) (I := I)).comp (AddMonoidAlgebra.mapDomainRingHom ℤ η) := by
  apply AddMonoidAlgebra.ringHom_ext
  · intro n
    simp [integerCoefficientMap, coefficientInclusion, Prod.map]
  · intro g
    simp [integerCoefficientMap, coefficientInclusion, Prod.map]

omit [DecidableEq I] [IsDomain (TotalLaurentRing G I)] in
theorem coefficientRange_integerMap_le {H : Type*} [AddCommGroup H]
    (η : G →+ H) (ψ : TotalLaurentRing H I →+* F) :
    coefficientRange (ψ.comp (integerCoefficientMap (I := I) η)) ≤ coefficientRange ψ := by
  classical
  rintro a ⟨r, rfl⟩
  refine ⟨AddMonoidAlgebra.mapDomainRingHom ℤ η r, ?_⟩
  change ψ (coefficientInclusion (AddMonoidAlgebra.mapDomainRingHom ℤ η r)) =
    ψ (integerCoefficientMap η (coefficientInclusion r))
  exact congrArg ψ (RingHom.congr_fun (coefficientInclusion_natural η) r).symm

omit [DecidableEq I] [IsDomain (TotalLaurentRing G I)] in
theorem positive_comp_integerMap {H : Type*} [AddCommGroup H]
    (η : G →+ H) (ψ : TotalLaurentRing H I →+* F)
    (hψ : ∀ p, positiveCast p ≠ 0 → ψ (positiveCast p) ≠ 0)
    (p : AddMonoidAlgebra ℕ (G × (I →₀ ℤ))) (hp : positiveCast p ≠ 0) :
    (ψ.comp (integerCoefficientMap (I := I) η)) (positiveCast p) ≠ 0 := by
  let φ : G × (I →₀ ℤ) →+ H × (I →₀ ℤ) := η.prodMap (AddMonoidHom.id _)
  have hp₀ : p ≠ 0 := by
    intro h
    apply hp
    rw [h, map_zero]
  have hnon := positive_mapDomain_ne_zero φ hp₀
  have htarget := hψ (AddMonoidAlgebra.mapDomainRingHom ℕ φ p) (positiveCast_ne_zero hnon)
  have hc := RingHom.congr_fun
    (AddMonoidAlgebra.mapRingHom_comp_mapDomainRingHom (Nat.castRingHom ℤ) φ) p
  change positiveCast (AddMonoidAlgebra.mapDomainRingHom ℕ φ p) =
    AddMonoidAlgebra.mapDomainRingHom ℤ φ (positiveCast p) at hc
  change ψ (AddMonoidAlgebra.mapDomainRingHom ℤ φ (positiveCast p)) ≠ 0
  rwa [← hc]

/-- C6 followed by coefficient-group naturality: a generic Laurent result
    specializes to the original actual caterpillar, even with parameter relations. -/
theorem value_chart_descent_natural {H : Type*} [AddCommGroup H]
    (η : G →+ H) (U : PositiveCaterpillar H P)
    (ψ : TotalLaurentRing H I →+* F)
    (hψ : ∀ p, positiveCast p ≠ 0 → ψ (positiveCast p) ≠ 0)
    (hE : ∀ {a b i}, P.Edge a b i → coefficientMap η (T.exchange a i) = U.exchange a i)
    (s : P.Vertex) (i : I)
    (h : T.value (canonicalMap (G := G) (I := I)) s i ∈
      chartRing (coefficientRange (canonicalMap (G := G) (I := I)))
        (T.value (canonicalMap (G := G) (I := I)) P.source)) :
    U.value ψ s i ∈ chartRing (coefficientRange ψ) (U.value ψ P.source) := by
  have hd := T.value_chart_descent (ψ.comp (integerCoefficientMap (I := I) η))
    (positive_comp_integerMap η ψ hψ) s i h
  have hs : T.value (ψ.comp (integerCoefficientMap (I := I) η)) P.source =
      U.value ψ P.source := by
    funext k
    exact T.value_natural η U ψ hE P.source k
  rw [T.value_natural η U ψ hE s i, hs] at hd
  apply chartRing_le (x := U.value ψ P.source)
    (L := chartRing (coefficientRange ψ) (U.value ψ P.source))
    (fun a ha => coefficient_mem_chartRing _ _ (coefficientRange_integerMap_le η ψ ha))
    (coordinate_mem_chartRing _ _) (inverse_mem_chartRing _ _) hd

omit [IsDomain (TotalLaurentRing G I)] in
/-- The universal deformation's generic initial-chart result descends to the
    original positive caterpillar, with no map out of its fraction field. -/
theorem deform_chart_descent (h : 3 ≤ P.length)
    [IsDomain (TotalLaurentRing (T.LiftGroup h) I)]
    (f : TotalLaurentRing G I →+* F)
    (hf : ∀ p, positiveCast p ≠ 0 → f (positiveCast p) ≠ 0)
    (s : P.Vertex) (i : I)
    (hmem : (T.deform h).value (canonicalMap (G := T.LiftGroup h) (I := I)) s i ∈
      chartRing (coefficientRange (canonicalMap (G := T.LiftGroup h) (I := I)))
        ((T.deform h).value (canonicalMap (G := T.LiftGroup h) (I := I)) P.source)) :
    T.value f s i ∈ chartRing (coefficientRange f) (T.value f P.source) := by
  exact (T.deform h).value_chart_descent_natural (T.liftMap h) T f hf
    (fun he => T.deform_specializes_edge h he) s i hmem

end PositiveCaterpillar
end TauCeti.Laurent
