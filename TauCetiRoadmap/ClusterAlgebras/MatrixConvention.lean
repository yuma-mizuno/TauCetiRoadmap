/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.ExchangeMatrix

/-! # Matrix Convention -/

@[expose] public section

namespace TauCeti.Cluster

/-- A positive skew symmetrizer gives the sign convention used by C8. -/
theorem signSkewAt_of_positive_symmetrizer (a b di dj : ℤ)
    (hi : 0 < di) (hj : 0 < dj) (hab : di * a = -(dj * b)) : SignSkewAt a b := by
  by_cases ha : a = 0
  · left
    refine ⟨ha, ?_⟩
    have hp : dj * b = 0 := by rw [ha, mul_zero] at hab; omega
    exact (mul_eq_zero.mp hp).resolve_left (ne_of_gt hj)
  · by_cases hapos : 0 < a
    · right; left
      refine ⟨hapos, ?_⟩
      by_contra hb
      have h₁ : 0 < di * a := mul_pos hi hapos
      have h₂ : 0 ≤ dj * b := mul_nonneg (le_of_lt hj) (by omega)
      omega
    · right; right
      have haneg : a < 0 := by omega
      refine ⟨haneg, ?_⟩
      by_contra hb
      have h₁ : di * a < 0 := mul_neg_of_pos_of_neg hi haneg
      have h₂ : dj * b ≤ 0 := mul_nonpos_of_nonneg_of_nonpos (le_of_lt hj) (by omega)
      omega

theorem signSkewAt_of_nat_symmetrizer (a b : ℤ) (di dj : ℕ)
    (hi : 0 < di) (hj : 0 < dj) (hab : (di : ℤ) * a = -((dj : ℤ) * b)) :
    SignSkewAt a b :=
  signSkewAt_of_positive_symmetrizer a b di dj (by exact_mod_cast hi) (by exact_mod_cast hj) hab

theorem signSkew_of_positive_symmetrizer {I : Type*} (B : I → I → ℤ) (d : I → ℤ)
    (hd : ∀ i, 0 < d i) (hB : ∀ i j, d i * B i j = -(d j * B j i)) :
    ∀ i j, SignSkewAt (B i j) (B j i) :=
  fun i j => signSkewAt_of_positive_symmetrizer _ _ _ _ (hd i) (hd j) (hB i j)

theorem diagonal_of_positive_symmetrizer {I : Type*} (B : I → I → ℤ) (d : I → ℤ)
    (hd : ∀ i, 0 < d i) (hB : ∀ i j, d i * B i j = -(d j * B j i)) :
    ∀ i, B i i = 0 := by
  intro i
  have h := signSkew_of_positive_symmetrizer B d hd hB i i
  rcases h with h | h | h <;> omega

end TauCeti.Cluster
