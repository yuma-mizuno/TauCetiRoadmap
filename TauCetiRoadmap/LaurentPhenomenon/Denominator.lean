/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import Mathlib.RingTheory.Polynomial.UniqueFactorization
public import Mathlib.Algebra.Polynomial.Laurent
public import Mathlib.GroupTheory.MonoidLocalization.Divisibility
public import Mathlib.RingTheory.UniqueFactorizationDomain.Basic
public import Mathlib.RingTheory.Coprime.Lemmas
public import Mathlib.Algebra.Field.Basic

/-! # Denominator -/

@[expose] public section

namespace TauCeti.Laurent

/-- Coprime denominators force a common fraction into the source ring. -/
theorem mem_of_relPrime_denominators
    {R K : Type*} [CommRing R] [DecompositionMonoid R] [Field K]
    (ι : R →+* K) (hι : Function.Injective ι)
    {a b d e : R} (hd : d ≠ 0) (he : e ≠ 0) (hde : IsRelPrime d e)
    (h : ι a / ι d = ι b / ι e) :
    ∃ c : R, ι c = ι a / ι d := by
  have hd' : ι d ≠ 0 := fun hz ↦ hd (hι (by simpa using hz))
  have he' : ι e ≠ 0 := fun hz ↦ he (hι (by simpa using hz))
  have hcross : a * e = b * d := hι (by
    simpa only [map_mul] using (div_eq_div_iff hd' he').mp h)
  have hdiv : d ∣ a := hde.dvd_of_dvd_mul_right (hcross ▸ dvd_mul_left d b)
  obtain ⟨c, hc⟩ := hdiv
  refine ⟨c, ?_⟩
  rw [hc, map_mul, mul_div_cancel_left₀ _ hd']

/-- Denominator descent for the powers and product occurring in the caterpillar induction. -/
theorem mem_of_relPrime_power_product_denominators
    {R K : Type*} [CommRing R] [IsDomain R] [DecompositionMonoid R] [Field K]
    (ι : R →+* K) (hι : Function.Injective ι)
    {a b z u v : R} (hz : z ≠ 0) (hu : u ≠ 0) (hv : v ≠ 0)
    (hzu : IsRelPrime z u) (hzv : IsRelPrime z v) (r s t : ℕ)
    (h : ι a / ι (z ^ r) = ι b / ι (u ^ s * v ^ t)) :
    ∃ c : R, ι c = ι a / ι (z ^ r) := by
  exact mem_of_relPrime_denominators ι hι (pow_ne_zero _ hz)
    (mul_ne_zero (pow_ne_zero _ hu) (pow_ne_zero _ hv))
    (hzu.pow.mul_right hzv.pow) h

/-- Localization preserves relative primality in a decomposition ring. -/
theorem isRelPrime_map_localization
    {R S : Type*} [CommRing R] [DecompositionMonoid R] [CommRing S]
    (M : Submonoid R) [Algebra R S] [IsLocalization M S]
    {a b : R} (hab : IsRelPrime a b) :
    IsRelPrime (algebraMap R S a) (algebraMap R S b) := by
  intro d hda hdb
  obtain ⟨⟨r, m⟩, hr⟩ := IsLocalization.surj M d
  have hra : algebraMap R S r ∣ algebraMap R S a := by
    rw [← hr]
    exact (IsLocalization.map_units S m).mul_right_dvd.mpr hda
  have hrb : algebraMap R S r ∣ algebraMap R S b := by
    rw [← hr]
    exact (IsLocalization.map_units S m).mul_right_dvd.mpr hdb
  obtain ⟨s, hs, hsa⟩ := (IsLocalization.toLocalizationMap M S).map_dvd_map.mp hra
  obtain ⟨t, ht, htb⟩ := (IsLocalization.toLocalizationMap M S).map_dvd_map.mp hrb
  obtain ⟨r₁, r₂, h₁, h₂, heq⟩ := exists_dvd_and_dvd_of_dvd_mul hsa
  have hr₂b : IsRelPrime r₂ b := hab.of_dvd_left h₂
  have hr₂tb : r₂ ∣ t * b := (heq ▸ dvd_mul_left r₂ r₁).trans htb
  have hrt : r ∣ s * t := by
    rw [heq]
    exact mul_dvd_mul h₁ (hr₂b.dvd_of_dvd_mul_right hr₂tb)
  have hrunit : IsUnit (algebraMap R S r) :=
    (IsLocalization.algebraMap_isUnit_iff (S := S) M).mpr ⟨s * t, M.mul_mem hs ht, hrt⟩
  exact isUnit_of_dvd_unit (hr ▸ dvd_mul_right d (algebraMap R S m)) hrunit
open Polynomial in
/-- Adjoining a variable preserves relative primality of constants. -/
theorem isRelPrime_polynomial_constants
    {R : Type*} [CommRing R] [IsDomain R] {a b : R}
    (ha : a ≠ 0) (hab : IsRelPrime a b) :
    IsRelPrime (C a) (C b) := by
  intro p hp hq
  have hpdeg : p.degree ≤ 0 := (degree_le_of_dvd hp (by simpa using ha)).trans degree_C_le
  have hpc : p = C (p.coeff 0) := eq_C_of_degree_le_zero hpdeg
  rw [hpc] at hp hq ⊢
  apply (hab ?_ ?_).map C
  · simpa using (C_dvd_iff_dvd_coeff _ _).mp hp 0
  · simpa using (C_dvd_iff_dvd_coeff _ _).mp hq 0

open Polynomial in
/-- The coefficient of X detects coprimality with a nonzero constant. -/
theorem isRelPrime_polynomial_linear
    {R : Type*} [CommRing R] [IsDomain R] {a b c : R}
    (ha : a ≠ 0) (hab : IsRelPrime a b) :
    IsRelPrime (C a) (C b * X + C c) := by
  intro p hp hq
  have hpdeg : p.degree ≤ 0 := (degree_le_of_dvd hp (by simpa using ha)).trans degree_C_le
  have hpc : p = C (p.coeff 0) := eq_C_of_degree_le_zero hpdeg
  rw [hpc] at hp hq ⊢
  apply (hab ?_ ?_).map C
  · simpa using (C_dvd_iff_dvd_coeff _ _).mp hp 0
  · simpa using (C_dvd_iff_dvd_coeff _ _).mp hq 1

open Polynomial
open scoped LaurentPolynomial

/-- Relative primality of constants persists in a Laurent polynomial ring. -/
theorem isRelPrime_laurent_constants
    {R : Type*} [CommRing R] [IsDomain R] [UniqueFactorizationMonoid R] {a b : R}
    (ha : a ≠ 0) (hab : IsRelPrime a b) :
    IsRelPrime (LaurentPolynomial.C a : R[T;T⁻¹]) (LaurentPolynomial.C b) := by
  simpa only [LaurentPolynomial.algebraMap_eq_toLaurent, Polynomial.toLaurent_C] using
    (isRelPrime_map_localization (S := R[T;T⁻¹]) (Submonoid.powers (Polynomial.X : R[X]))
      (isRelPrime_polynomial_constants ha hab))

/-- A linear Laurent polynomial is relatively prime to a constant if its X coefficient is. -/
theorem isRelPrime_laurent_linear
    {R : Type*} [CommRing R] [IsDomain R] [UniqueFactorizationMonoid R] {a b c : R}
    (ha : a ≠ 0) (hab : IsRelPrime a b) :
    IsRelPrime (LaurentPolynomial.C a : R[T;T⁻¹])
      (LaurentPolynomial.C b * LaurentPolynomial.T 1 + LaurentPolynomial.C c) := by
  simpa only [LaurentPolynomial.algebraMap_eq_toLaurent, map_add, map_mul,
    Polynomial.toLaurent_C, Polynomial.toLaurent_X] using
    (isRelPrime_map_localization (S := R[T;T⁻¹]) (Submonoid.powers (Polynomial.X : R[X]))
      (isRelPrime_polynomial_linear (c := c) ha hab))

end TauCeti.Laurent
