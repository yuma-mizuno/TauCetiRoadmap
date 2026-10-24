/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.QuantumPair

/-! # Support bounds for quantum exchange defects

The support estimates depend only on the faithful chart. Polynomial and binary
exchanges use the same two-coordinate multiplication and divisibility lemmas.
-/

@[expose] public section

namespace TauCeti.Cluster.QuantumSeed

open TauCeti TauCeti.QuantumTorus TauCeti.Laurent

variable {D : Type*} [DivisionRing D] [Algebra Zv D]
  {M K : Type*} [Fintype M] [DecidableEq M] {row : K ↪ M}
  (s : QuantumSeed D row)

noncomputable section

/-- The `Zv`-span of the monomials `M(a)` with `a p = m` and `n ≤ a q`. -/
def twoCoordinateSpan (p q : M) (m n : ℤ) : Submodule Zv D :=
  Submodule.span Zv (s.monomial '' {a | a p = m ∧ n ≤ a q})

theorem monomial_mem_twoCoordinateSpan {p q : M} {m n : ℤ} {a : M → ℤ} (hp : a p = m)
    (hq : n ≤ a q) : s.monomial a ∈ s.twoCoordinateSpan p q m n :=
  Submodule.subset_span ⟨a, ⟨hp, hq⟩, rfl⟩

theorem mul_mem_twoCoordinateSpan {p q : M} {m n m' n' m'' n'' : ℤ} {x z : D}
    (hx : x ∈ s.twoCoordinateSpan p q m n) (hz : z ∈ s.twoCoordinateSpan p q m' n')
    (hm : m + m' = m'')
    (hn : n'' ≤ n + n') : x * z ∈ s.twoCoordinateSpan p q m'' n'' := by
  have h := Submodule.mul_mem_mul hx hz
  rw [twoCoordinateSpan, twoCoordinateSpan, Submodule.span_mul_span] at h
  refine Submodule.span_le.2 ?_ h
  rintro _ ⟨_, ⟨a, ha, rfl⟩, _, ⟨b, hb, rfl⟩, rfl⟩
  change s.monomial a * s.monomial b ∈ s.twoCoordinateSpan p q m'' n''
  rw [monomial_mul_monomial, ← Algebra.smul_def]
  refine Submodule.smul_mem _ _ (s.monomial_mem_twoCoordinateSpan ?_ ?_)
  · simp only [Set.mem_ofPred_eq] at ha hb
    simp [ha.1, hb.1, hm]
  · simp only [Set.mem_ofPred_eq] at ha hb
    simp only [Pi.add_apply]
    omega

/-- A monomial without `X_p` and with nonnegative `q`-exponent lies in `C[X_q]`. -/
theorem monomial_mem_skewPolyRing {p q : M} {b : M → ℤ} (hp : b p = 0)
    (hq : 0 ≤ b q) :
    s.monomial b ∈ skewPolyRing (s.pairRing p q) (s.coordinate q : D) := by
  set T := skewPolyRing (s.pairRing p q) (s.coordinate q : D)
  have h := s.monomial_mul_monomial (b - b q • Pi.single q 1) (b q • Pi.single q 1)
  rw [sub_add_cancel, s.monomial_zsmul_single] at h
  have h' : s.monomial b = algebraMap Zv D
      (((vUnit ^ matrixForm s.form (b - b q • Pi.single q 1) (b q • Pi.single q 1))⁻¹ : Zvˣ) :
        Zv) * (s.monomial (b - b q • Pi.single q 1) * (s.coordinate q : D) ^ b q) := by
    rw [h, ← mul_assoc, ← map_mul, Units.inv_mul, map_one, one_mul]
  have hpow : (s.coordinate q : D) ^ b q ∈ T := by
    obtain ⟨n, hn⟩ := Int.eq_ofNat_of_zero_le hq
    rw [hn, zpow_natCast]
    exact T.pow_mem (generator_mem_skewPolyRing _ _) n
  rw [h']
  refine T.mul_mem (le_skewPolyRing _ _ (s.algebraMap_mem_pairRing p q _))
    (T.mul_mem (le_skewPolyRing _ _ (s.monomial_mem_pairRing ?_ ?_)) hpow)
  · by_cases hpq : p = q
    · subst hpq; simp
    · simp [hp, hpq]
  · simp

/-- Elements of the span with `p`-exponent `0` and `q`-exponent at least `1` are left
divisible by `y = X_q` in `C[y]`. -/
theorem inv_mul_mem_skewPolyRing {p q : M} (hpq : p ≠ q) {z : D}
    (hz : z ∈ s.twoCoordinateSpan p q 0 1) :
    (s.coordinate q : D)⁻¹ * z ∈ skewPolyRing (s.pairRing p q) (s.coordinate q : D) := by
  set T := skewPolyRing (s.pairRing p q) (s.coordinate q : D)
  let S : Submodule Zv D :=
    { carrier := {z | (s.coordinate q : D)⁻¹ * z ∈ T}
      add_mem' := fun ha hb ↦ by
        simp only [Set.mem_ofPred_eq, mul_add] at ha hb ⊢
        exact T.add_mem ha hb
      zero_mem' := by simp
      smul_mem' := fun c z hz ↦ by
        simp only [Set.mem_ofPred_eq, Algebra.smul_def] at hz ⊢
        rw [← mul_assoc, ← Algebra.commutes, mul_assoc]
        exact T.mul_mem (le_skewPolyRing _ _ (s.algebraMap_mem_pairRing p q c)) hz }
  have hle : s.twoCoordinateSpan p q 0 1 ≤ S := by
    refine Submodule.span_le.2 ?_
    rintro _ ⟨a, ⟨hap, haq⟩, rfl⟩
    change (s.coordinate q : D)⁻¹ * s.monomial a ∈ T
    rw [← s.monomial_neg_single, monomial_mul_monomial]
    refine T.mul_mem (le_skewPolyRing _ _ (s.algebraMap_mem_pairRing p q _))
      (s.monomial_mem_skewPolyRing ?_ ?_)
    · simp [hap, hpq]
    · simp only [Pi.add_apply, Pi.neg_apply, Pi.single_eq_same]
      omega
  exact hle hz


/-- A positive-support remainder in an exchange gives every power defect.
The exchange expression may have any number of summands. -/
theorem pow_mul_pow_sub_mem_of_positive_remainder {p q : M} (hpq : p ≠ q)
    {Y A : D} (hA : A ∈ s.twoCoordinateSpan p q (-1) 0)
    (hR : Y - A ∈ s.twoCoordinateSpan p q (-1) 1) (r : ℕ) :
    Y ^ r * (s.coordinate p : D) ^ r - A ^ r * (s.coordinate p : D) ^ r ∈
      ((s.coordinate q : D) * ·) '' (skewPolyRing (s.pairRing p q)
        (s.coordinate q : D) : Set D) := by
  have hApow (n : ℕ) : A ^ n ∈ s.twoCoordinateSpan p q (-n) 0 := by
    induction n with
    | zero =>
      rw [pow_zero, ← s.monomial_zero]
      exact s.monomial_mem_twoCoordinateSpan (by simp) (by simp)
    | succ n ih =>
      rw [pow_succ]
      exact s.mul_mem_twoCoordinateSpan ih hA (by push_cast; ring) (by omega)
  have hdef (n : ℕ) : Y ^ n - A ^ n ∈ s.twoCoordinateSpan p q (-n) 1 := by
    induction n with
    | zero => simp
    | succ n ih =>
      have he : Y ^ (n + 1) - A ^ (n + 1) =
          (Y ^ n - A ^ n) * A + (Y ^ n - A ^ n) * (Y - A) + A ^ n * (Y - A) := by
        rw [pow_succ, pow_succ]
        noncomm_ring
      rw [he]
      exact Submodule.add_mem _ (Submodule.add_mem _
        (s.mul_mem_twoCoordinateSpan ih hA (by push_cast; ring) (by omega))
        (s.mul_mem_twoCoordinateSpan ih hR (by push_cast; ring) (by omega)))
        (s.mul_mem_twoCoordinateSpan (hApow n) hR (by push_cast; ring) (by omega))
  have hxr : (s.coordinate p : D) ^ r = s.monomial ((r : ℤ) • Pi.single p 1) := by
    rw [s.monomial_zsmul_single, zpow_natCast]
  have hVx : (Y ^ r - A ^ r) * (s.coordinate p : D) ^ r ∈
      s.twoCoordinateSpan p q 0 1 := by
    rw [hxr]
    exact s.mul_mem_twoCoordinateSpan (hdef r)
      (s.monomial_mem_twoCoordinateSpan (m := r) (n := 0)
        (by simp) (by simp [hpq.symm])) (by ring) (by omega)
  refine ⟨_, s.inv_mul_mem_skewPolyRing hpq hVx, ?_⟩
  dsimp only
  rw [mul_inv_cancel_left₀ (Units.ne_zero _), sub_mul]

theorem pairRing_le_otherRing {a b : M} (hba : b ≠ a) : s.pairRing a b ≤ s.otherRing a := by
  rw [s.otherRing_eq_regroup hba]
  exact fun _ h ↦ coefficient_mem_chartRing _ _ h

/-- A normalized monomial with nonnegative `c`-exponent lies in a subring containing the
scalars, `X_c` and the monomial with the `c`-exponent removed. -/
theorem monomial_mem_of_nonneg {T : Subring D} {c : M} {e : M → ℤ}
    (hscal : ∀ r : Zv, algebraMap Zv D r ∈ T) (hc : (s.coordinate c : D) ∈ T)
    (he' : s.monomial (e - e c • Pi.single c 1) ∈ T) (he : 0 ≤ e c) : s.monomial e ∈ T := by
  have h := s.monomial_mul_monomial (e - e c • Pi.single c 1) (e c • Pi.single c 1)
  rw [sub_add_cancel, s.monomial_zsmul_single] at h
  have h' : s.monomial e = algebraMap Zv D
      (((vUnit ^ matrixForm s.form (e - e c • Pi.single c 1) (e c • Pi.single c 1))⁻¹ : Zvˣ) : Zv) *
        (s.monomial (e - e c • Pi.single c 1) * (s.coordinate c : D) ^ e c) := by
    rw [h, ← mul_assoc, ← map_mul, Units.inv_mul, map_one, one_mul]
  have hpow : (s.coordinate c : D) ^ e c ∈ T := by
    obtain ⟨n, hn⟩ := Int.eq_ofNat_of_zero_le he
    rw [hn, zpow_natCast]
    exact T.pow_mem hc n
  rw [h']
  exact T.mul_mem (hscal _) (T.mul_mem he' hpow)

/-- `x = X_a` and `y = X_b` satisfy `x y x⁻¹ = y e` with a scalar `e`. -/
theorem coordinate_conj_coordinate (a b : M) :
    (s.coordinate a : D) * s.coordinate b * (s.coordinate a : D)⁻¹ =
      s.coordinate b *
        algebraMap Zv D ((vUnit ^ (2 * matrixForm s.form (Pi.single a 1) (Pi.single b 1)) : Zvˣ) :
          Zv) := by
  rw [s.quasiCommuting a b, Algebra.smul_def, mul_assoc, mul_assoc,
    mul_inv_cancel₀ (Units.ne_zero _), mul_one, Algebra.commutes]

/-- Removing a summand with coefficient one leaves the prescribed support
bound whenever every other summand satisfies it. -/
theorem sum_smul_monomial_sub_mem_twoCoordinateSpan {ι : Type*}
    (S : Finset ι) (c : ι → Zv) (a : ι → M → ℤ) {k : ι} (hk : k ∈ S)
    (hc : c k = 1) {p q : M} {m n : ℤ}
    (ha : ∀ l ∈ S, l ≠ k → a l p = m ∧ n ≤ a l q) :
    (∑ l ∈ S, c l • s.monomial (a l)) - s.monomial (a k) ∈
      s.twoCoordinateSpan p q m n := by
  classical
  rw [← Finset.sum_erase_add S _ hk, hc, one_smul, add_sub_cancel_right]
  apply Submodule.sum_mem
  intro l hl
  have h := ha l (Finset.mem_erase.mp hl).2 (Finset.mem_erase.mp hl).1
  exact Submodule.smul_mem _ _ (s.monomial_mem_twoCoordinateSpan h.1 h.2)


end
end TauCeti.Cluster.QuantumSeed
