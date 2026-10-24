/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.Denominator
public import TauCetiRoadmap.LaurentPhenomenon.LocalCancellation

/-! # Local Coprimality -/

@[expose] public section

namespace TauCeti.Laurent

/-- Relative primality is invariant under replacing the second entry modulo the first. -/
theorem isRelPrime_of_dvd_sub {B : Type*} [CommRing B] {a b c : B}
    (hac : IsRelPrime a c) (h : a ∣ b - c) : IsRelPrime a b := by
  intro p hpa hpb
  have hpbc : p ∣ b - c := hpa.trans h
  have hpc : p ∣ c := by
    have := dvd_sub hpb hpbc
    simpa using this
  exact hac hpa hpc

open Polynomial
open scoped LaurentPolynomial

/-- Both coprimality conclusions of the local caterpillar step from its exact residues. -/
theorem local_coprimality_of_remainders
    {S : Type*} [CommRing S] [IsDomain S] [UniqueFactorizationMonoid S]
    {E q₀ A f₁ yinv : S} (hE : E ≠ 0)
    (hEq : IsRelPrime E q₀) (hEA : IsRelPrime E A) (hy : IsUnit yinv)
    {z u v : S[T;T⁻¹]}
    (hz : LaurentPolynomial.C E = LaurentPolynomial.T 1 * z)
    (hu : u - LaurentPolynomial.C (yinv * q₀) ∈
      Ideal.span ({LaurentPolynomial.C E} : Set S[T;T⁻¹]))
    (hv : v - (LaurentPolynomial.C f₁ + LaurentPolynomial.T 1 * LaurentPolynomial.C A) ∈
      Ideal.span ({LaurentPolynomial.C E} : Set S[T;T⁻¹])) :
    IsRelPrime z u ∧ IsRelPrime z v := by
  have hEq' : IsRelPrime (LaurentPolynomial.C E : S[T;T⁻¹])
      (LaurentPolynomial.C (yinv * q₀)) := by
    rw [map_mul, isRelPrime_mul_unit_left_right (hy.map LaurentPolynomial.C)]
    exact isRelPrime_laurent_constants hE hEq
  have hEA' : IsRelPrime (LaurentPolynomial.C E : S[T;T⁻¹])
      (LaurentPolynomial.C f₁ + LaurentPolynomial.T 1 * LaurentPolynomial.C A) := by
    simpa only [add_comm, mul_comm] using isRelPrime_laurent_linear (c := f₁) hE hEA
  have hEu := isRelPrime_of_dvd_sub hEq' (Ideal.mem_span_singleton.mp hu)
  have hEv := isRelPrime_of_dvd_sub hEA' (Ideal.mem_span_singleton.mp hv)
  rw [hz, isRelPrime_mul_unit_left_left (LaurentPolynomial.isUnit_T 1)] at hEu hEv
  exact ⟨hEu, hEv⟩

/-- Coprimality for the actual polynomial expressions after local cancellation. -/
theorem local_coprimality
    {S : Type*} [CommRing S] [IsDomain S] [UniqueFactorizationMonoid S]
    (Q f : S[X]) {E A yinv : S} (hE : E ≠ 0)
    (hEq : IsRelPrime E (Q.eval 0)) (hEA : IsRelPrime E A) (hy : IsUnit yinv)
    (z : S[T;T⁻¹]) (hz : LaurentPolynomial.C E = LaurentPolynomial.T 1 * z) :
    IsRelPrime z (LaurentPolynomial.C yinv * (Q.map LaurentPolynomial.C).eval z) ∧
    IsRelPrime z ((f.map LaurentPolynomial.C).divX.eval z +
      LaurentPolynomial.T 1 * LaurentPolynomial.C A) := by
  have hdiv : LaurentPolynomial.C E ∣ z := by
    rw [hz]
    exact (LaurentPolynomial.isUnit_T 1).mul_left_dvd.mpr (dvd_refl z)
  apply local_coprimality_of_remainders hE hEq hEA hy hz
  · have h := first_remainder_mem (Q.map LaurentPolynomial.C)
      (LaurentPolynomial.C yinv) z (LaurentPolynomial.C E) hdiv
    simpa using h
  · have h := second_remainder_mem (f.map LaurentPolynomial.C) (LaurentPolynomial.T 1)
      z (LaurentPolynomial.C E) (LaurentPolynomial.C A)
      ((f.map LaurentPolynomial.C).divX.eval z + LaurentPolynomial.T 1 * LaurentPolynomial.C A)
      hdiv rfl
    simpa using h

end TauCeti.Laurent
