/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.SkewPatching

/-! # Finite polynomial exchange replacement

Left coefficients and conjugation are retained in an arbitrary division ring.
The binary replacement theorem is a one-term instance of the same finite sum.
-/

@[expose] public section

namespace TauCeti.Laurent

section FiniteReplacement

variable {D ι : Type*} [DivisionRing D]

/-- Algebraic input only: finite exchange identities and polynomial defects.
There is no Laurentness or chart-membership conclusion among the fields. -/
structure FiniteReplacementPremise (C : Subring D) (x xs z zs zss phi n0 m0 : D)
    (s : Finset ι) (N : ℕ) (r : ι → ℕ) (c d g : ι → D) : Prop where
  x_normalizes : Normalizes C x
  z_normalizes : Normalizes C z
  degree : ∀ i ∈ s, r i ≤ N
  phi_mem : phi ∈ C
  coefficient_mem : ∀ i ∈ s, c i ∈ C
  constant : phi * n0 = m0
  defect_mem : ∀ i ∈ s,
    xs ^ r i * x ^ r i - g i ∈ (z * ·) '' (skewPolyRing C z : Set D)
  zs_mul : zs * z = n0 + ∑ i ∈ s, x ^ r i * c i
  zss_mul : zss * z = xs ^ N * m0 + ∑ i ∈ s, xs ^ (N - r i) * d i
  compat : ∀ i ∈ s, d i = g i * (x ^ r i)⁻¹ * phi * x ^ r i * c i

namespace FiniteReplacementPremise

variable {C : Subring D} {x xs z zs zss phi n0 m0 : D}
    {s : Finset ι} {N : ℕ} {r : ι → ℕ} {c d g : ι → D}
    (h : FiniteReplacementPremise C x xs z zs zss phi n0 m0 s N r c d g)
include h

theorem term_identity (i : ι) (hi : i ∈ s) :
    xs ^ N * phi * (x ^ r i * c i) - xs ^ (N - r i) * d i =
      xs ^ (N - r i) * (xs ^ r i * x ^ r i - g i) *
        ((x ^ r i)⁻¹ * phi * x ^ r i) * c i := by
  have hx : x ^ r i ≠ 0 := pow_ne_zero _ h.x_normalizes.ne_zero
  have hp : xs ^ (N - r i) * xs ^ r i = xs ^ N := by
    rw [← pow_add, Nat.sub_add_cancel (h.degree i hi)]
  rw [h.compat i hi]
  rw [← hp]
  simp [mul_sub, sub_mul, mul_assoc, hx]

theorem zss_eq :
    zss = xs ^ N * phi * zs -
      ∑ i ∈ s, xs ^ (N - r i) * (xs ^ r i * x ^ r i - g i) *
        ((x ^ r i)⁻¹ * phi * x ^ r i) * c i * z⁻¹ := by
  have hz := h.z_normalizes.ne_zero
  have hs : (∑ i ∈ s, xs ^ N * phi * (x ^ r i * c i)) =
      (∑ i ∈ s, xs ^ (N - r i) * d i) +
        ∑ i ∈ s, xs ^ (N - r i) * (xs ^ r i * x ^ r i - g i) *
          ((x ^ r i)⁻¹ * phi * x ^ r i) * c i := by
    rw [← Finset.sum_add_distrib]
    apply Finset.sum_congr rfl
    intro i hi
    exact (sub_eq_iff_eq_add.mp (h.term_identity i hi)).trans (add_comm _ _)
  apply mul_right_cancel₀ hz
  rw [h.zss_mul, sub_mul, mul_assoc _ zs z, h.zs_mul, mul_add,
    mul_assoc (xs ^ N) phi n0, h.constant, Finset.mul_sum, Finset.sum_mul]
  simp only [mul_assoc, inv_mul_cancel₀ hz, mul_one]
  simp only [mul_assoc] at hs
  rw [hs]
  abel

theorem zss_mem : zss ∈ Subring.closure ((C : Set D) ∪ {xs, zs, z}) := by
  let T := Subring.closure ((C : Set D) ∪ {xs, zs, z})
  have hCT : C ≤ T := fun _ hc ↦ Subring.subset_closure (Or.inl hc)
  have hxs : xs ∈ T := Subring.subset_closure (Or.inr (by simp))
  have hzs : zs ∈ T := Subring.subset_closure (Or.inr (by simp))
  have hST : skewPolyRing C z ≤ T :=
    skewPolyRing_le hCT (Subring.subset_closure (Or.inr (by simp)))
  rw [h.zss_eq]
  apply T.sub_mem (T.mul_mem (T.mul_mem (T.pow_mem hxs _) (hCT h.phi_mem)) hzs)
  apply T.sum_mem
  intro i hi
  have hphi : (x ^ r i)⁻¹ * phi * x ^ r i ∈ C :=
    (h.x_normalizes.pow _).inv_conj_mem h.phi_mem
  obtain ⟨w, hw, he⟩ := h.defect_mem i hi
  have hc : (xs ^ r i * x ^ r i - g i) *
      ((x ^ r i)⁻¹ * phi * x ^ r i) * c i * z⁻¹ ∈ T := by
    rw [← he]
    have ht := hST ((normalizes_skewPolyRing h.z_normalizes).conj_mem
      ((skewPolyRing C z).mul_mem ((skewPolyRing C z).mul_mem hw
        (le_skewPolyRing C z hphi)) (le_skewPolyRing C z (h.coefficient_mem i hi))))
    simpa only [mul_assoc] using ht
  simpa only [mul_assoc] using T.mul_mem (T.pow_mem hxs (N - r i)) hc

end FiniteReplacementPremise

end FiniteReplacement

end TauCeti.Laurent
