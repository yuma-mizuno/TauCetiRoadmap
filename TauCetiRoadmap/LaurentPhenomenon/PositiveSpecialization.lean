/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import Mathlib.Algebra.MonoidAlgebra.MapDomain
public import Mathlib.RingTheory.Localization.Basic
public import Mathlib.RingTheory.Localization.FractionRing

/-! # Positive Specialization -/

@[expose] public section

noncomputable section
namespace TauCeti.Laurent

variable {G H : Type*} [AddCommMonoid G] [AddCommMonoid H]

/-- Cast natural group-polynomial coefficients to integers without changing their exponents. -/
def positiveCast : AddMonoidAlgebra ℕ G →+* AddMonoidAlgebra ℤ G :=
  AddMonoidAlgebra.mapRingHom G (Nat.castRingHom ℤ)

theorem positiveCast_injective : Function.Injective (positiveCast (G := G)) :=
  AddMonoidAlgebra.map_injective _ Nat.cast_injective

theorem positive_mapDomain_ne_zero (φ : G →+ H)
    {p : AddMonoidAlgebra ℕ G} (hp : p ≠ 0) :
    AddMonoidAlgebra.mapDomainRingHom ℕ φ p ≠ 0 := by
  intro h
  apply hp
  apply AddMonoidAlgebra.coeff_injective
  exact (Finsupp.mapDomain_apply_eq_zero_iff_of_subsingletonAddUnits φ p.coeff).mp
    (congrArg AddMonoidAlgebra.coeff h)

theorem positive_specialization_ne_zero (φ : G →+ H)
    {p : AddMonoidAlgebra ℕ G} (hp : p ≠ 0) :
    AddMonoidAlgebra.mapDomainRingHom ℤ φ (positiveCast p) ≠ 0 := by
  have hc := AddMonoidAlgebra.mapRingHom_comp_mapDomainRingHom
    (Nat.castRingHom ℤ) φ
  change ((AddMonoidAlgebra.mapDomainRingHom ℤ φ).comp
    (AddMonoidAlgebra.mapRingHom G (Nat.castRingHom ℤ))) p ≠ 0
  rw [← hc]
  exact fun h => positive_mapDomain_ne_zero φ hp
    (positiveCast_injective (h.trans (map_zero _).symm))

section Localization
variable {R P K : Type*} [CommRing R] [IsDomain R] [CommSemiring P]
  [Field K]

/-- Nonzero elements of a positive semiring image form the allowed denominators. -/
def positiveDenominators (ι : P →+* R) : Submonoid R where
  carrier := {r | r ≠ 0 ∧ r ∈ Set.range ι}
  one_mem' := ⟨one_ne_zero, ⟨1, map_one ι⟩⟩
  mul_mem' := by
    rintro a b ⟨ha, p, rfl⟩ ⟨hb, q, rfl⟩
    exact ⟨mul_ne_zero ha hb, ⟨p * q, map_mul ι p q⟩⟩

theorem positiveDenominators_zero_not_mem (ι : P →+* R) :
    0 ∉ positiveDenominators ι := fun h => h.1 rfl

/-- The specialization is defined on the positive localization, without a fraction-field map. -/
def specializePositive (ι : P →+* R) (f : R →+* K)
    (hf : ∀ p, ι p ≠ 0 → f (ι p) ≠ 0) :
    Localization (positiveDenominators ι) →+* K :=
  IsLocalization.lift (M := positiveDenominators ι) (g := f) (fun s =>
    isUnit_iff_ne_zero.mpr (by
      obtain ⟨p, hp⟩ := s.property.2
      exact hp ▸ hf p (hp.symm ▸ s.property.1)))

@[simp] theorem specializePositive_algebraMap (ι : P →+* R) (f : R →+* K)
    (hf : ∀ p, ι p ≠ 0 → f (ι p) ≠ 0) (r : R) :
    specializePositive ι f hf (algebraMap R (Localization (positiveDenominators ι)) r) =
      f r := by
  unfold specializePositive
  exact IsLocalization.lift_eq _ _

/-- An ambient injective realization lets equality descend before specialization. -/
theorem transport_laurent_representative (ι : P →+* R) (f : R →+* K)
    (hf : ∀ p, ι p ≠ 0 → f (ι p) ≠ 0)
    {A : Type*} [CommRing A]
    (j : Localization (positiveDenominators ι) →+* A)
    (hj : Function.Injective j) (x : Localization (positiveDenominators ι)) (r : R)
    (h : j x = j (algebraMap R (Localization (positiveDenominators ι)) r)) :
    specializePositive ι f hf x = f r := by
  rw [hj h]
  exact specializePositive_algebraMap ι f hf r

/-- The positive localization embeds in the fraction field of the source ring. -/
def positiveFractionEmbedding (ι : P →+* R) :
    Localization (positiveDenominators ι) →+* FractionRing R :=
  specializePositive ι (algebraMap R (FractionRing R))
    (fun _ h => IsFractionRing.to_map_eq_zero_iff.not.mpr h)

theorem positiveFractionEmbedding_injective (ι : P →+* R) :
    Function.Injective (positiveFractionEmbedding ι) := by
  unfold positiveFractionEmbedding specializePositive
  apply (IsLocalization.lift_injective_iff _).mpr
  intro x y
  have hbase : Function.Injective
      (algebraMap R (Localization (positiveDenominators ι))) :=
    IsLocalization.injective _ (show positiveDenominators ι ≤ nonZeroDivisors R from
      fun s hs => mem_nonZeroDivisors_of_ne_zero hs.1)
  exact hbase.eq_iff.trans (IsFractionRing.injective R (FractionRing R)).eq_iff.symm

/-- Equality can be tested in the source fraction field. -/
theorem positiveFractionEmbedding_eq_iff (ι : P →+* R)
    (x y : Localization (positiveDenominators ι)) :
    positiveFractionEmbedding ι x = positiveFractionEmbedding ι y ↔ x = y :=
  (positiveFractionEmbedding_injective ι).eq_iff

/-- A Laurent expression found over the universal coefficient ring specializes
    after descending its fraction-field equality to the positive localization. -/
theorem specialize_laurent_expression (ι : P →+* R) (f : R →+* K)
    (hf : ∀ p, ι p ≠ 0 → f (ι p) ≠ 0)
    (x : Localization (positiveDenominators ι)) (r : R)
    (h : positiveFractionEmbedding ι x = algebraMap R (FractionRing R) r) :
    specializePositive ι f hf x = f r := by
  apply transport_laurent_representative ι f hf
    (positiveFractionEmbedding ι) (positiveFractionEmbedding_injective ι) x r
  simpa [positiveFractionEmbedding] using h

end Localization

/-- Relations in the coefficient group preserve every positive denominator when the
    target Laurent chart is injectively realized in a field. Mutable Laurent exponents
    can be included by taking the product of the coefficient and exponent groups. -/
theorem positive_specialization_field_ne_zero {K : Type*} [Field K]
    (φ : G →+ H) (chart : AddMonoidAlgebra ℤ H →+* K)
    (hchart : Function.Injective chart) {p : AddMonoidAlgebra ℕ G} (hp : p ≠ 0) :
    chart (AddMonoidAlgebra.mapDomainRingHom ℤ φ (positiveCast p)) ≠ 0 := by
  exact fun h => positive_specialization_ne_zero φ hp
    (hchart (h.trans (map_zero chart).symm))
/-- The seed-free C6 specialization for coefficient and Laurent exponent groups. -/
def groupPositiveSpecialization [IsDomain (AddMonoidAlgebra ℤ G)]
    {K : Type*} [Field K] (φ : G →+ H)
    (chart : AddMonoidAlgebra ℤ H →+* K) (hchart : Function.Injective chart) :
    Localization (positiveDenominators (positiveCast (G := G))) →+* K :=
  specializePositive (positiveCast (G := G)) (chart.comp (AddMonoidAlgebra.mapDomainRingHom ℤ φ))
    (fun p hp => positive_specialization_field_ne_zero φ chart hchart
      (by intro h; apply hp; rw [h]; exact map_zero _))

@[simp] theorem groupPositiveSpecialization_algebraMap
    [IsDomain (AddMonoidAlgebra ℤ G)] {K : Type*} [Field K] (φ : G →+ H)
    (chart : AddMonoidAlgebra ℤ H →+* K) (hchart : Function.Injective chart)
    (r : AddMonoidAlgebra ℤ G) :
    groupPositiveSpecialization φ chart hchart
      (algebraMap _ (Localization (positiveDenominators (positiveCast (G := G)))) r) =
    chart (AddMonoidAlgebra.mapDomainRingHom ℤ φ r) := by
  apply specializePositive_algebraMap

end TauCeti.Laurent
