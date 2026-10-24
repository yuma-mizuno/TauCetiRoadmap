/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.PolynomialQuantumPair

/-!
# Interacting polynomial quantum intersections

Each exchange has a unit endpoint and a remainder of positive support in
the other direction. The same two-denominator patching as for binary
exchanges computes the intersection, for arbitrary polynomial degrees.
-/

@[expose] public section

namespace TauCeti.Cluster.PolynomialQuantumSeed

open TauCeti TauCeti.QuantumTorus TauCeti.Laurent

variable {D : Type*} [DivisionRing D] [Algebra Zv D]
  {M K : Type*} [Fintype M] [DecidableEq M] {row : K ↪ M}
  (s : PolynomialQuantumSeed D row)

noncomputable section

theorem exchangeCoordinate_negative_remainder {i j : K} (hij : i ≠ j)
    (hneg : s.exchange.matrix (row i) j < 0) :
    s.exchangeCoordinate i - s.toQuantumSeed.monomial
        (exchangeExponentNeg row s.exchange.matrix i) ∈
      s.toQuantumSeed.twoCoordinateSpan (row i) (row j) (-1) 1 := by
  rw [exchangeCoordinate, ← s.exchangeExponent_zero i]
  simp_rw [← Algebra.smul_def (R := Zv) (A := D)]
  apply s.toQuantumSeed.sum_smul_monomial_sub_mem_twoCoordinateSpan _ _ _
    (Finset.mem_range.mpr (by omega : 0 < s.degree i + 1)) (s.constant_one i)
  intro l _ hl0
  refine ⟨s.exchangeExponent_row i l, ?_⟩
  have hb : 0 < s.exchange.matrix (row j) i := by
    have hsym := s.exchange.symmetrized i j
    by_contra hn
    nlinarith [mul_neg_of_pos_of_neg (s.exchange.symmetrizer_pos i) hneg,
      mul_nonpos_of_nonneg_of_nonpos (s.exchange.symmetrizer_pos j).le (not_lt.1 hn)]
  have hc := s.dividedColumn_apply_mul_degree i (row j)
  have ht : 1 ≤ s.dividedColumn i (row j) := by
    by_contra hn
    have ht0 : s.dividedColumn i (row j) ≤ 0 := by omega
    have := mul_nonpos_of_nonneg_of_nonpos (Int.natCast_nonneg (s.degree i)) ht0
    omega
  have hl : (1 : ℤ) ≤ l := by omega
  simp only [exchangeExponent, exchangeExponentNeg, Pi.add_apply, Pi.neg_apply,
    Pi.single_eq_of_ne (row.injective.ne hij.symm), neg_zero, zero_add,
    Pi.smul_apply, smul_eq_mul]
  rw [positivePart, max_eq_right (by omega : -s.exchange.matrix (row j) i ≤ 0), zero_add]
  nlinarith

/-- A concrete unit endpoint and positive-support remainder construct the
unit-constant-term input of noncommutative patching. -/
theorem unitConstantTerm_of_exchange_remainder {i j : K} (hij : i ≠ j)
    (a : M → ℤ) (ha : a (row i) = -1) (hb : a (row j) = 0)
    (hR : s.exchangeCoordinate i - s.toQuantumSeed.monomial a ∈
      s.toQuantumSeed.twoCoordinateSpan (row i) (row j) (-1) 1) :
    UnitConstantTerm (s.toQuantumSeed.pairRing (row i) (row j)) (s.coordinate (row j) : D)
      ((s.coordinate (row i) : D) * s.exchangeCoordinate i) := by
  let x : D := s.coordinate (row i)
  let y : D := s.coordinate (row j)
  let e : M → ℤ := Pi.single (row i) 1
  let a0 := x * s.toQuantumSeed.monomial a
  let R := x * (s.exchangeCoordinate i - s.toQuantumSeed.monomial a)
  have ha0 : a0 = scaledMonomial s.toQuantumSeed.chart (matrixForm s.form e a) (e + a) := by
    dsimp [a0, x, e]
    rw [← s.toQuantumSeed.monomial_single, s.toQuantumSeed.monomial_mul_monomial]
    rfl
  have hvp : (e + a) (row i) = 0 := by simp [e, ha]
  have hvq : (e + a) (row j) = 0 := by simp [e, hb, row.injective.ne hij.symm]
  have haC : a0 ∈ s.toQuantumSeed.pairRing (row i) (row j) := by
    rw [ha0]
    exact s.scaledMonomial_mem_pairRing i j _ hvp hvq
  have ha0ne : a0 ≠ 0 := by
    rw [ha0]
    exact scaledMonomial_ne_zero _ s.toQuantumSeed.isAlt _ _
  have hai : a0⁻¹ ∈ s.toQuantumSeed.pairRing (row i) (row j) := by
    rw [ha0, scaledMonomial_inv _ s.toQuantumSeed.isAlt]
    exact s.scaledMonomial_mem_pairRing i j _ (by simp [hvp]) (by simp [hvq])
  have hx : x ∈ s.toQuantumSeed.twoCoordinateSpan (row i) (row j) 1 0 := by
    change (s.coordinate (row i) : D) ∈ _
    rw [← s.toQuantumSeed.monomial_single]
    exact s.toQuantumSeed.monomial_mem_twoCoordinateSpan (by simp)
      (by simp [row.injective.ne hij.symm])
  have hR' : R ∈ s.toQuantumSeed.twoCoordinateSpan (row i) (row j) 0 1 :=
    s.toQuantumSeed.mul_mem_twoCoordinateSpan hx hR (by norm_num) (by norm_num)
  have hw := s.toQuantumSeed.inv_mul_mem_skewPolyRing (row.injective.ne hij) hR'
  have h := unitConstantTerm_add (s.toQuantumSeed.coordinate_normalizes_pairRing _ _ _)
    haC ha0ne hai hw
  have he : a0 + y * (y⁻¹ * R) = x * s.exchangeCoordinate i := by
    rw [mul_inv_cancel_left₀ (Units.ne_zero (s.coordinate (row j)))]
    dsimp only [a0, R]
    noncomm_ring
  rwa [he] at h

theorem unitConstantTerm_coordinate_mul_exchangeCoordinate {i j : K}
    (hb : s.exchange.matrix (row j) i ≠ 0) :
    UnitConstantTerm (s.toQuantumSeed.pairRing (row i) (row j)) (s.coordinate (row j) : D)
      ((s.coordinate (row i) : D) * s.exchangeCoordinate i) := by
  have hij : i ≠ j := by rintro rfl; exact hb (s.exchange.diagonal i)
  have hbij : s.exchange.matrix (row i) j ≠ 0 := by
    intro hz
    have h := s.exchange.symmetrized i j
    rw [hz, mul_zero] at h
    have hmul : s.exchange.symmetrizer j * s.exchange.matrix (row j) i = 0 := by omega
    exact hb ((mul_eq_zero.mp hmul).resolve_left (s.exchange.symmetrizer_pos j).ne')
  rcases hbij.lt_or_gt with h | h
  · apply s.unitConstantTerm_of_exchange_remainder hij
      (exchangeExponentNeg row s.exchange.matrix i)
      (exchangeExponentNeg_row (s.exchange.diagonal i))
    · have hbpos : 0 < s.exchange.matrix (row j) i := by
        have hs := s.exchange.symmetrized i j
        nlinarith [s.exchange.symmetrizer_pos i, s.exchange.symmetrizer_pos j,
          mul_neg_of_pos_of_neg (s.exchange.symmetrizer_pos i) h]
      simp [exchangeExponentNeg, row.injective.ne hij.symm, positivePart,
        max_eq_right (by omega : -s.exchange.matrix (row j) i ≤ 0)]
    · exact s.exchangeCoordinate_negative_remainder hij h
  · apply s.unitConstantTerm_of_exchange_remainder hij
      (exchangeExponentPos row s.exchange.matrix i)
      (exchangeExponentPos_row (s.exchange.diagonal i))
    · simp [exchangeExponentPos, row.injective.ne hij.symm, positivePart,
        max_eq_right (s.exchange_matrix_reverse_neg h).le]
    · exact s.exchangeCoordinate_positive_remainder hij h

theorem fourRing_comm (i j : K) : s.fourRing i j = s.fourRing j i := by
  rw [fourRing, fourRing, s.toQuantumSeed.pairRing_comm, UpperBound.fourRing_comm]

/-- `y = X_j` normalizes `C⟨X_i, X'_i, X_j⟩`. -/
theorem coordinate_normalizes_closure_pair {i j : K} (hij : i ≠ j) :
    Normalizes (UpperBound.generated (s.toQuantumSeed.pairRing (row i) (row j))
        {(s.coordinate (row i) : D), s.exchangeCoordinate i, (s.coordinate (row j) : D)})
      (s.coordinate (row j) : D) := by
  have hji : row j ≠ row i := row.injective.ne hij.symm
  refine normalizes_closure (s.toQuantumSeed.coordinate_normalizes_pairRing _ _ _)
    (s.toQuantumSeed.algebraMap_mem_pairRing _ _) ?_
  rintro g (rfl | rfl | rfl)
  · exact ⟨_, by rw [s.quasiCommuting, Algebra.smul_def]⟩
  · exact ⟨_, s.coordinate_mul_exchangeCoordinate i hji⟩
  · exact ⟨1, by simp⟩

theorem closure_pair_le_fourRing (i j : K) :
    UpperBound.generated (s.toQuantumSeed.pairRing (row i) (row j))
        {(s.coordinate (row i) : D), s.exchangeCoordinate i, (s.coordinate (row j) : D)} ≤
      s.fourRing i j :=
  UpperBound.generated_mono _ fun g hg ↦ by rcases hg with rfl | rfl | rfl <;> simp

variable [Fintype K] [DecidableEq K]

/-- Regrouping `T_s ∩ T_{μ_i(s)} = C⟨X_i, X'_i⟩` around a second coordinate:
`T_s ∩ T_{μ_i(s)} = C'⟨X_j, X_j⁻¹, X_i, X'_i⟩` with `C' = pairRing (row i) (row j)`. -/
theorem inf_mutate_eq_closure_pair {i j : K} (hij : i ≠ j) :
    s.toQuantumSeed.chartRing ⊓ (s.mutate i).toQuantumSeed.chartRing =
      UpperBound.generated (s.toQuantumSeed.pairRing (row i) (row j))
        {(s.coordinate (row j) : D), (s.coordinate (row j) : D)⁻¹,
          (s.coordinate (row i) : D), s.exchangeCoordinate i} := by
  have hji : row j ≠ row i := row.injective.ne hij.symm
  rw [s.chartRing_inf_mutate_chartRing i, s.toQuantumSeed.otherRing_eq_regroup hji]
  apply le_antisymm
  · refine Subring.closure_le.2 ?_
    rintro g (hg | hg)
    · refine chartRing_le (fun c hc ↦ UpperBound.coefficient_mem_generated _ _ hc)
        (fun _ ↦ UpperBound.generator_mem_generated _ _ (by simp))
        (fun _ ↦ UpperBound.generator_mem_generated _ _ (by simp)) hg
    · rcases hg with rfl | rfl <;> exact UpperBound.generator_mem_generated _ _ (by simp)
  · refine UpperBound.generated_le _ _ _
      (fun c hc ↦ Subring.subset_closure (Or.inl (coefficient_mem_chartRing _ _ hc))) ?_
    intro g hg
    · rcases hg with rfl | rfl | rfl | rfl
      · exact Subring.subset_closure
          (Or.inl (coordinate_mem_chartRing _ (fun _ : Unit ↦ (s.coordinate (row j) : D)) ()))
      · exact Subring.subset_closure
          (Or.inl (inverse_mem_chartRing _ (fun _ : Unit ↦ (s.coordinate (row j) : D)) ()))
      · exact Subring.subset_closure (Or.inr (by simp))
      · exact Subring.subset_closure (Or.inr (by simp))

/-- `C⟨X_i, X'_i, X_j, X'_j⟩ ⊆ T_s ∩ T_{μ_i(s)}`. -/
theorem fourRing_le_inf_mutate {i j : K} (hij : i ≠ j) :
    s.fourRing i j ≤ s.toQuantumSeed.chartRing ⊓ (s.mutate i).toQuantumSeed.chartRing := by
  have hji : row j ≠ row i := row.injective.ne hij.symm
  rw [s.chartRing_inf_mutate_chartRing i]
  set T := Subring.closure ((s.toQuantumSeed.otherRing (row i) : Set D) ∪
    {(s.coordinate (row i) : D), s.exchangeCoordinate i})
  have hO : s.toQuantumSeed.otherRing (row i) ≤ T := fun _ h ↦ Subring.subset_closure (Or.inl h)
  have hx : (s.coordinate (row i) : D) ∈ T := Subring.subset_closure (Or.inr (by simp))
  have hmon : ∀ e : M → ℤ, 0 ≤ e (row i) → s.toQuantumSeed.monomial e ∈ T := fun e he ↦
    s.toQuantumSeed.monomial_mem_of_nonneg
      (fun r ↦ hO (s.toQuantumSeed.algebraMap_mem_otherRing _ r)) hx
      (hO (s.toQuantumSeed.monomial_mem_otherRing (by simp))) he
  refine Subring.closure_le.2 ?_
  rintro g (hg | hg)
  · exact hO (s.toQuantumSeed.pairRing_le_otherRing hji hg)
  · rcases hg with rfl | rfl | rfl | rfl
    · exact hx
    · exact Subring.subset_closure (Or.inr (by simp))
    · exact hO (coordinate_mem_chartRing _ (fun l : {l // l ≠ row i} ↦ (s.coordinate l : D))
        ⟨row j, hji⟩)
    · rw [exchangeCoordinate]
      apply T.sum_mem
      intro l hl
      apply T.mul_mem (hO (s.toQuantumSeed.algebraMap_mem_otherRing _ _))
      exact hmon _ (s.exchangeExponent_nonneg_of_ne j hji.symm (by
        have := Finset.mem_range.mp hl; omega))

/-- Right denominators: every `f ∈ T_s ∩ T_{μ_i(s)}` has `f X_j ^ n ∈ C⟨X_i, X'_i, X_j⟩`. -/
theorem exists_mul_pow_mem_of_mem_inf_mutate {i j : K} (hij : i ≠ j) {f : D}
    (hf : f ∈ s.toQuantumSeed.chartRing ⊓ (s.mutate i).toQuantumSeed.chartRing) :
    ∃ n : ℕ, f * (s.coordinate (row j) : D) ^ n ∈
      UpperBound.generated (s.toQuantumSeed.pairRing (row i) (row j))
        {(s.coordinate (row i) : D), s.exchangeCoordinate i, (s.coordinate (row j) : D)} := by
  set H := UpperBound.generated (s.toQuantumSeed.pairRing (row i) (row j))
    {(s.coordinate (row i) : D), s.exchangeCoordinate i, (s.coordinate (row j) : D)}
  have hyH : (s.coordinate (row j) : D) ∈ H := UpperBound.generator_mem_generated _ _ (by simp)
  refine exists_mul_pow_mem_of_mem_closure (s.coordinate_normalizes_closure_pair hij) hyH ?_
  rw [s.inf_mutate_eq_closure_pair hij] at hf
  refine Subring.closure_mono ?_ hf
  rintro g (hg | hg)
  · exact Or.inl (UpperBound.coefficient_mem_generated _ _ hg)
  · rcases hg with rfl | rfl | rfl | rfl
    · exact Or.inl hyH
    · exact Or.inr rfl
    · exact Or.inl (UpperBound.generator_mem_generated _ _ (by simp))
    · exact Or.inl (UpperBound.generator_mem_generated _ _ (by simp))

/-- **Q2, interacting case.** If `b_{row j, i} ≠ 0`, then
`(T_s ∩ T_{μ_i(s)}) ∩ (T_s ∩ T_{μ_j(s)}) = C⟨X_i, X'_i, X_j, X'_j⟩`. -/
theorem inf_mutate_inf_inf_mutate_eq_fourRing {i j : K} (hij : i ≠ j)
    (hb : s.exchange.matrix (row j) i ≠ 0) :
    (s.toQuantumSeed.chartRing ⊓ (s.mutate i).toQuantumSeed.chartRing) ⊓
        (s.toQuantumSeed.chartRing ⊓ (s.mutate j).toQuantumSeed.chartRing) =
      s.fourRing i j := by
  have hC : s.toQuantumSeed.pairRing (row i) (row j) ≤ s.fourRing i j :=
    fun _ h ↦ UpperBound.coefficient_mem_fourRing _ _ _ _ _ h
  refine inf_eq_of_unitConstantTerm (C := s.toQuantumSeed.pairRing (row i) (row j))
    (x := (s.coordinate (row i) : D)) (y := (s.coordinate (row j) : D))
    (xs := s.exchangeCoordinate i) (s.toQuantumSeed.coordinate_normalizes_pairRing _ _ _)
    (s.toQuantumSeed.coordinate_normalizes_pairRing _ _ _)
    (s.toQuantumSeed.algebraMap_mem_pairRing _ _ _)
    (s.toQuantumSeed.coordinate_conj_coordinate _ _)
    (s.unitConstantTerm_coordinate_mul_exchangeCoordinate hb)
    (skewPolyRing_le hC (UpperBound.y_mem_fourRing _ _ _ _ _))
    (UpperBound.xs_mem_fourRing _ _ _ _ _)
    (s.fourRing_le_inf_mutate hij)
    (s.fourRing_comm i j ▸ s.fourRing_le_inf_mutate hij.symm)
    (fun f hf ↦ ?_) (fun f hf ↦ ?_)
  · obtain ⟨n, hn⟩ := s.exists_mul_pow_mem_of_mem_inf_mutate hij hf
    exact ⟨n, s.closure_pair_le_fourRing i j hn⟩
  · obtain ⟨n, hn⟩ := s.exists_mul_pow_mem_of_mem_inf_mutate hij.symm hf
    exact ⟨n, s.fourRing_comm j i ▸ s.closure_pair_le_fourRing j i hn⟩


end
end TauCeti.Cluster.PolynomialQuantumSeed
