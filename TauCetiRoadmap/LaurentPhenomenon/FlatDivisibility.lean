/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import Mathlib.RingTheory.Flat.EquationalCriterion
public import Mathlib.RingTheory.UniqueFactorizationDomain.Basic
public import Mathlib.Tactic.LinearCombination

/-!
# Simultaneous divisibility in flat modules

A scalar intersection identity `(p) ∩ (q) = (p * q)` extends to any flat
module. The proof uses Mathlib's equational criterion for flatness and does
not choose a basis. In an algebra the scalar action is multiplication by
central coefficients, so the resulting divisibility theorem applies even
when the algebra itself is noncommutative.
-/

@[expose] public section

namespace TauCeti.Module

variable {R M : Type*} [CommRing R] [AddCommGroup M] [Module R M]

/-- Flatness extends a scalar common-multiple identity to module elements. -/
theorem exists_mul_smul_of_flat [Module.Flat R M] (p q : R)
    (hscalar : ∀ r : R, p ∣ r → q ∣ r → p * q ∣ r)
    (m : M) (hp : ∃ a, p • a = m) (hq : ∃ b, q • b = m) :
    ∃ c, (p * q) • c = m := by
  classical
  obtain ⟨a, ha⟩ := hp
  obtain ⟨b, hb⟩ := hq
  have hrel : ∑ i : Fin 2, (![p, -q] i) • (![a, b] i) = 0 := by
    simpa [Fin.sum_univ_two, sub_eq_add_neg] using sub_eq_zero.mpr (ha.trans hb.symm)
  obtain ⟨k, coefficients, values, hvalues, hrelations⟩ :=
    Module.Flat.isTrivialRelation_of_sum_smul_eq_zero hrel
  have hcommon (j : Fin k) : p * q ∣ p * coefficients 0 j := by
    have h := hrelations j
    simp only [Fin.sum_univ_two, Matrix.cons_val_zero, Matrix.cons_val_one,
      neg_mul] at h
    have heq : p * coefficients 0 j = q * coefficients 1 j := by
      linear_combination h
    exact hscalar _ ⟨coefficients 0 j, rfl⟩ ⟨coefficients 1 j, heq⟩
  choose factors hfactors using hcommon
  have ha' : a = ∑ j, coefficients 0 j • values j := by simpa using hvalues 0
  refine ⟨∑ j, factors j • values j, ?_⟩
  calc
    (p * q) • (∑ j, factors j • values j) =
        ∑ j, ((p * q) * factors j) • values j := by simp [Finset.smul_sum, mul_smul]
    _ = ∑ j, (p * coefficients 0 j) • values j := by
      apply Finset.sum_congr rfl
      intro j _
      rw [← hfactors j]
    _ = p • (∑ j, coefficients 0 j • values j) := by simp [Finset.smul_sum, mul_smul]
    _ = m := by rw [← ha', ha]

theorem exists_mul_smul_iff_of_flat [Module.Flat R M] (p q : R)
    (hscalar : ∀ r : R, p ∣ r → q ∣ r → p * q ∣ r) (m : M) :
    (∃ c, (p * q) • c = m) ↔ (∃ a, p • a = m) ∧ (∃ b, q • b = m) := by
  constructor
  · rintro ⟨c, rfl⟩
    exact ⟨⟨q • c, (mul_smul p q c).symm⟩,
      ⟨p • c, by rw [smul_smul, mul_comm q p]⟩⟩
  · rintro ⟨hp, hq⟩
    exact exists_mul_smul_of_flat p q hscalar m hp hq

theorem exists_mul_smul_of_relPrime [DecompositionMonoid R] [Module.Flat R M]
    {p q : R} (h : IsRelPrime p q) (m : M)
    (hp : ∃ a, p • a = m) (hq : ∃ b, q • b = m) :
    ∃ c, (p * q) • c = m :=
  exists_mul_smul_of_flat p q (fun _ hp hq => h.mul_dvd hp hq) m hp hq

/-- The submodule form of the same intersection identity. -/
theorem range_lsmul_inf_of_flat [Module.Flat R M] (p q : R)
    (hscalar : ∀ r : R, p ∣ r → q ∣ r → p * q ∣ r) :
    LinearMap.range (LinearMap.lsmul R M p) ⊓ LinearMap.range (LinearMap.lsmul R M q) =
      LinearMap.range (LinearMap.lsmul R M (p * q)) := by
  ext m
  exact (exists_mul_smul_iff_of_flat p q hscalar m).symm

section Algebra

variable {A : Type*} [Ring A] [Algebra R A] [Module.Flat R A]

/-- Combining central divisibility does not require a commutative algebra. -/
theorem algebraMap_mul_dvd_of_flat (p q : R)
    (hscalar : ∀ r : R, p ∣ r → q ∣ r → p * q ∣ r) {a : A}
    (hp : algebraMap R A p ∣ a) (hq : algebraMap R A q ∣ a) :
    algebraMap R A (p * q) ∣ a := by
  obtain ⟨u, hu⟩ := hp
  obtain ⟨v, hv⟩ := hq
  obtain ⟨w, hw⟩ := exists_mul_smul_of_flat p q hscalar a
    ⟨u, by simpa [Algebra.smul_def] using hu.symm⟩
    ⟨v, by simpa [Algebra.smul_def] using hv.symm⟩
  exact ⟨w, by simpa [Algebra.smul_def] using hw.symm⟩

theorem algebraMap_mul_dvd_of_relPrime [DecompositionMonoid R]
    {p q : R} (h : IsRelPrime p q) {a : A}
    (hp : algebraMap R A p ∣ a) (hq : algebraMap R A q ∣ a) :
    algebraMap R A (p * q) ∣ a :=
  algebraMap_mul_dvd_of_flat p q (fun _ hp hq => h.mul_dvd hp hq) hp hq

end Algebra
end TauCeti.Module
