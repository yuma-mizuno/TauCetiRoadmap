/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.PositiveCaterpillarRealization

/-! # Rechart -/

@[expose] public section

noncomputable section
namespace TauCeti.Laurent
open scoped BigOperators

variable {G I F : Type*} [AddCommGroup G] [DecidableEq I] [Field F]

/-- Evaluate integer-coefficient Laurent polynomials through a unit-valued exponent character. -/
def integerEvaluate (χ : LaurentExponent G I →+ Additive Fˣ) :
    AddMonoidAlgebra ℤ (LaurentExponent G I) →+* F :=
  AddMonoidAlgebra.liftNCRingHom (Int.castRingHom F) (characterMonoidHom χ)
    (fun _ _ => Commute.all _ _)

omit [DecidableEq I] in
@[simp] theorem integerEvaluate_single (χ : LaurentExponent G I →+ Additive Fˣ)
    (t : LaurentExponent G I) (n : ℤ) :
    integerEvaluate χ (AddMonoidAlgebra.single t n) =
      (n : F) * ((χ t).toMul : F) := by
  simp [integerEvaluate, characterMonoidHom]

/-- Restrict the total Laurent evaluation to coefficient monomials and record their unit values. -/
def coefficientCharacter
    (f : AddMonoidAlgebra ℤ (G × (I →₀ ℤ)) →+* F) : G →+ Additive Fˣ :=
  ((f.comp coefficientInclusion).toMonoidHom.comp
    (AddMonoidAlgebra.of ℤ G)).toHomUnits.toAdditiveRight

omit [DecidableEq I] in
@[simp] theorem coefficientCharacter_value
    (f : AddMonoidAlgebra ℤ (G × (I →₀ ℤ)) →+* F) (g : G) :
    ((coefficientCharacter f g).toMul : F) = f (AddMonoidAlgebra.single (g, 0) 1) := by
  simp [coefficientCharacter, coefficientInclusion, AddMonoidAlgebra.of_apply,
    AddMonoidAlgebra.mapDomain_single]

/-- Evaluate the Laurent ring in an actual tuple of nonzero coordinates. -/
def rechart (f : AddMonoidAlgebra ℤ (G × (I →₀ ℤ)) →+* F)
    (x : I → F) (hx : ∀ i, x i ≠ 0) :
    AddMonoidAlgebra ℤ (G × (I →₀ ℤ)) →+* F :=
  integerEvaluate (chartCharacter (coefficientCharacter f) (fun i => Units.mk0 (x i) (hx i)))

omit [DecidableEq I] in
@[simp] theorem rechart_single (f : AddMonoidAlgebra ℤ (G × (I →₀ ℤ)) →+* F)
    (x : I → F) (hx : ∀ i, x i ≠ 0) (g : G) (a : I →₀ ℤ) (n : ℤ) :
    rechart f x hx (AddMonoidAlgebra.single (g, a) n) =
      (n : F) * (f (AddMonoidAlgebra.single (g, 0) 1) * ∏ i ∈ a.support, x i ^ a i) := by
  classical
  simp [rechart, chartCharacter_value]

omit [DecidableEq I] in
theorem rechart_variable (f : AddMonoidAlgebra ℤ (G × (I →₀ ℤ)) →+* F)
    (x : I → F) (hx : ∀ i, x i ≠ 0) (i : I) :
    rechart f x hx (AddMonoidAlgebra.single (0, Finsupp.single i 1) 1) = x i := by
  classical
  simp [rechart, chartCharacter_variable]

omit [DecidableEq I] in
theorem rechart_coefficient (f : AddMonoidAlgebra ℤ (G × (I →₀ ℤ)) →+* F)
    (x : I → F) (hx : ∀ i, x i ≠ 0) :
    (rechart f x hx).comp coefficientInclusion = f.comp coefficientInclusion := by
  classical
  apply AddMonoidAlgebra.ringHom_ext
  · intro n
    change ((rechart f x hx).comp coefficientInclusion) (n : AddMonoidAlgebra ℤ G) =
      (f.comp coefficientInclusion) (n : AddMonoidAlgebra ℤ G)
    simp
  intro g
  change rechart f x hx (coefficientInclusion (AddMonoidAlgebra.single g 1)) =
    f (coefficientInclusion (AddMonoidAlgebra.single g 1))
  have hg : coefficientInclusion (I := I) (AddMonoidAlgebra.single g (1 : ℤ)) =
      AddMonoidAlgebra.single (g, 0) 1 := by
    simp [coefficientInclusion, AddMonoidAlgebra.mapDomain_single]
  rw [hg, rechart_single]
  simp

omit [DecidableEq I] in
theorem rechart_positive (f : AddMonoidAlgebra ℤ (G × (I →₀ ℤ)) →+* F)
    (x : I → F) (hx : ∀ i, x i ≠ 0) (E : PositiveLaurent G I) :
    rechart f x hx (positiveCast E) = coordinateEvaluate f E x := by
  classical
  unfold coordinateEvaluate
  conv_lhs => rw [← AddMonoidAlgebra.sum_coeff_single E]
  simp only [Finsupp.sum, map_sum, positiveCast, AddMonoidAlgebra.mapRingHom_single]
  apply Finset.sum_congr rfl
  intro t ht
  rw [rechart_single]
  change ((E.coeff t : ℤ) : F) * (f (AddMonoidAlgebra.single (t.1, 0) 1) *
    ∏ i ∈ t.2.support, x i ^ t.2 i) =
    f (AddMonoidAlgebra.single (t.1, 0) (E.coeff t : ℤ)) *
      ∏ i ∈ t.2.support, x i ^ t.2 i
  rw [Int.cast_natCast]
  have hn : f (AddMonoidAlgebra.single (t.1, 0) (E.coeff t : ℤ)) =
      (E.coeff t : F) * f (AddMonoidAlgebra.single (t.1, 0) 1) := by
    rw [show (AddMonoidAlgebra.single (t.1, 0) (E.coeff t : ℤ) :
        AddMonoidAlgebra ℤ (G × (I →₀ ℤ))) =
      (E.coeff t : ℤ) • AddMonoidAlgebra.single (t.1, 0) 1 by simp]
    rw [map_zsmul]
    simp only [zsmul_eq_mul, Int.cast_natCast]
  rw [hn, mul_assoc]

omit [DecidableEq I] in
theorem rechart_coefficientRange (f : AddMonoidAlgebra ℤ (G × (I →₀ ℤ)) →+* F)
    (x : I → F) (hx : ∀ i, x i ≠ 0) :
    coefficientRange (rechart f x hx) =
      coefficientRange f := by
  classical
  unfold coefficientRange
  rw [rechart_coefficient]

omit [DecidableEq I] in
theorem coordinateEvaluate_rechart
    (f : AddMonoidAlgebra ℤ (G × (I →₀ ℤ)) →+* F)
    (x : I → F) (hx : ∀ i, x i ≠ 0) (E : PositiveLaurent G I) (y : I → F) :
    coordinateEvaluate (rechart f x hx) E y = coordinateEvaluate f E y := by
  classical
  unfold coordinateEvaluate
  apply Finset.sum_congr rfl
  intro t ht
  congr 1
  have h := RingHom.congr_fun (rechart_coefficient f x hx)
    (AddMonoidAlgebra.single t.1 (E.coeff t : ℤ))
  simp only [positiveCast, AddMonoidAlgebra.mapRingHom_single]
  change rechart f x hx (AddMonoidAlgebra.single (t.1, 0) (E.coeff t : ℤ)) =
    f (AddMonoidAlgebra.single (t.1, 0) (E.coeff t : ℤ))
  have hc : coefficientInclusion (I := I) (AddMonoidAlgebra.single t.1 (E.coeff t : ℤ)) =
      AddMonoidAlgebra.single (t.1, 0) (E.coeff t : ℤ) := by
    simp [coefficientInclusion, AddMonoidAlgebra.mapDomain_single]
  simpa only [RingHom.comp_apply, hc] using h

namespace PositiveCaterpillar

variable [IsDomain (AddMonoidAlgebra ℤ (G × (I →₀ ℤ)))]
variable {P Q : CaterpillarPath I} (T : PositiveCaterpillar G P)
variable (f : AddMonoidAlgebra ℤ (G × (I →₀ ℤ)) →+* F)
variable (hf : ∀ p, positiveCast p ≠ 0 → f (positiveCast p) ≠ 0)

/-- The total Laurent evaluation sending initial variables to the realized coordinates at the
selected vertex.
-/
def vertexRechart (s : P.Vertex) : AddMonoidAlgebra ℤ (G × (I →₀ ℤ)) →+* F :=
  rechart f (T.value f s) (T.value_ne_zero f hf s)

omit [IsDomain (AddMonoidAlgebra ℤ (G × (I →₀ ℤ)))] in
theorem vertexRechart_positive (s : P.Vertex) (p : PositiveLaurent G I)
    (hp : positiveCast p ≠ 0) : T.vertexRechart f hf s (positiveCast p) ≠ 0 := by
  rw [vertexRechart, rechart_positive]
  apply T.value_positive f hf s p
  intro hz
  apply hp
  rw [hz, map_zero]

omit [IsDomain (AddMonoidAlgebra ℤ (G × (I →₀ ℤ)))] in
/-- Restricting the actual tree agrees with starting the shorter positive pattern
at its actual source tuple. Only the exchanges on incident edges are compared. -/
theorem restriction_value (U : PositiveCaterpillar G Q) (e : Q.Vertex → P.Vertex)
    (he : ∀ {a b i}, Q.Edge a b i → P.Edge (e a) (e b) i)
    (hE : ∀ {a b i}, Q.Edge a b i → U.exchange a i = T.exchange (e a) i)
    (s : Q.Vertex) (k : I) :
    U.value (T.vertexRechart f hf (e Q.source)) s k = T.value f (e s) k := by
  symm
  apply U.value_unique (T.vertexRechart f hf (e Q.source)) (fun s => T.value f (e s))
  · intro i
    exact (rechart_variable f _ _ i).symm
  · intro a b i h k hk
    exact (T.value_edge f hf (he h)).1 k hk
  · intro a b i h
    have hr := (T.value_edge f hf (he h)).2
    rw [vertexRechart, coordinateEvaluate_rechart, hE h]
    exact (eq_div_iff (T.value_ne_zero f hf (e a) i)).mpr hr

end PositiveCaterpillar

end TauCeti.Laurent
