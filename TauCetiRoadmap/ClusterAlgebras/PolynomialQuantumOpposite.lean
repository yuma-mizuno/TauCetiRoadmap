/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.PolynomialQuantumReplacement
public import TauCetiRoadmap.ClusterAlgebras.QuantumOpposite
public import Mathlib.Algebra.Ring.Subring.MulOpposite

/-!
# Opposite polynomial quantum seeds

Passing to the opposite algebra negates both matrix and form and reverses
the exchange coefficient lists. This transports positive replacement to
negative interaction without a second coefficient calculation.
-/

@[expose] public section

namespace TauCeti.Cluster.PolynomialExchangeSeed

open TauCeti TauCeti.QuantumTorus TauCeti.Laurent MulOpposite

variable {R₀ : Type*} [CommRing R₀] {u₀ : R₀ˣ}
  {D : Type*} [DivisionRing D] [Algebra R₀ D]
  {M K : Type*} [Fintype M] [DecidableEq M] {row : K ↪ M}
  (s : PolynomialExchangeSeed (u₀ := u₀) D row)

noncomputable section

/-- The existing opposite quantum frame, with all exchange coefficient lists reversed. -/
def opposite : PolynomialExchangeSeed (u₀ := u₀) Dᵐᵒᵖ row where
  toExchangeFrame := s.toExchangeFrame.opposite
  polynomial k := (s.polynomial k).reverse
  constant_one k := by rw [Polynomial.coeff_zero_reverse]; exact s.monic k
  monic := s.polynomial_reverse_monic
  degree_pos k := by rw [s.polynomial_reverse_natDegree]; exact s.degree_pos k
  degree_dvd a k := by
    rw [s.polynomial_reverse_natDegree]
    exact dvd_neg.mpr (s.degree_dvd a k)

theorem opposite_polynomial (k : K) : (s.opposite.polynomial k) = (s.polynomial k).reverse := rfl

theorem opposite_degree (k : K) : s.opposite.degree k = s.degree k :=
  s.polynomial_reverse_natDegree k

theorem opposite_coordinate (a : M) : (s.opposite.coordinate a : Dᵐᵒᵖ) = op (s.coordinate a : D) :=
  rfl

theorem opposite_monomial (a : M → ℤ) :
    s.opposite.toExchangeFrame.monomial a = op (s.toExchangeFrame.monomial a) :=
  s.toExchangeFrame.opposite_monomial a

theorem opposite_dividedColumn (k : K) : s.opposite.dividedColumn k = -s.dividedColumn k := by
  have hr : (s.degree k : ℤ) ≠ 0 := by
    have := s.degree_pos k
    change 0 < s.degree k at this
    omega
  apply smul_right_injective (M := M → ℤ) hr
  change (s.degree k : ℤ) • s.opposite.dividedColumn k =
    (s.degree k : ℤ) • (-s.dividedColumn k)
  rw [← s.opposite_degree k, s.opposite.degree_mul_dividedColumn,
    s.opposite_degree, smul_neg, s.degree_mul_dividedColumn]
  rfl

theorem opposite_exchangeExponent (k : K) {l : ℕ} (hl : l ≤ s.degree k) :
    s.opposite.exchangeExponent k l = s.exchangeExponent k (s.degree k - l) := by
  rw [exchangeExponent, s.opposite_dividedColumn,
    show s.opposite.exchange.matrix = -s.exchange.matrix from rfl,
    exchangeExponentNeg_neg, exchangeExponentPos_eq_neg_add,
    ← s.degree_mul_dividedColumn, exchangeExponent]
  push_cast [Nat.cast_sub hl]
  module

theorem opposite_polynomial_coeff_reflect (k : K) {l : ℕ} (hl : l ≤ s.degree k) :
    (s.opposite.polynomial k).coeff (s.degree k - l) = (s.polynomial k).coeff l := by
  change l ≤ (s.polynomial k).natDegree at hl
  change (s.polynomial k).reverse.coeff ((s.polynomial k).natDegree - l) = _
  rw [Polynomial.coeff_reverse, Polynomial.revAt_le (Nat.sub_le _ _), Nat.sub_sub_self hl]

theorem opposite_exchangeCoordinate (k : K) :
    s.opposite.exchangeCoordinate k = op (s.exchangeCoordinate k) := by
  rw [exchangeCoordinate, s.opposite_degree]
  conv_lhs => rw [← Finset.sum_range_reflect]
  rw [exchangeCoordinate, Finset.op_sum]
  apply Finset.sum_congr rfl
  intro l hl
  have hle : l ≤ s.degree k := by have := Finset.mem_range.mp hl; omega
  simp only [Nat.add_sub_cancel, s.opposite_polynomial_coeff_reflect k hle]
  rw [s.opposite_exchangeExponent k (Nat.sub_le _ _), Nat.sub_sub_self hle,
    s.opposite_monomial]
  change op (algebraMap R₀ D ((s.polynomial k).coeff l)) *
    op (s.toExchangeFrame.monomial (s.exchangeExponent k l)) = _
  rw [← op_mul, Algebra.commutes]

theorem opposite_pairRing (a b : M) :
    s.opposite.toExchangeFrame.pairRing a b = (s.toExchangeFrame.pairRing a b).op := by
  have hR : (algebraMap R₀ Dᵐᵒᵖ).range = (algebraMap R₀ D).range.op := by
    ext z
    constructor
    · rintro ⟨r, rfl⟩
      exact ⟨r, rfl⟩
    · rintro ⟨r, hr⟩
      exact ⟨r, by change op (algebraMap R₀ D r) = z; rw [hr, op_unop]⟩
  simp only [ExchangeFrame.pairRing, Laurent.chartRing, hR, Subring.op_closure]
  congr 1
  ext z
  obtain ⟨d, rfl⟩ := op_surjective z
  simp only [Set.mem_union, Set.mem_range, Set.mem_preimage, SetLike.mem_coe,
    Subring.mem_op, unop_op, s.opposite_coordinate, ← op_inv, op_inj]

variable [Fintype K] [DecidableEq K]

theorem opposite_mutate (k : K) : s.opposite.mutate k = (s.mutate k).opposite := by
  refine ext ?_ ?_
  · refine ExchangeFrame.ext (s.exchange.neg_mutate k)
      (s.compatible.formMutation_neg s.alternating (Or.inl rfl)) (funext fun a ↦ Units.ext ?_)
    by_cases ha : a = row k
    · subst a
      rw [mutate_coordinate_row, opposite_coordinate, mutate_coordinate_row,
        opposite_exchangeCoordinate]
    · rw [mutate_coordinate_of_ne _ _ ha, opposite_coordinate, opposite_coordinate,
        mutate_coordinate_of_ne _ _ ha]
  · funext j
    by_cases hj : j = k
    · subst j
      simp only [mutate_polynomial, mutatePolynomial, Function.update_self, opposite_polynomial]
    · simp only [mutate_polynomial, mutatePolynomial, Function.update_of_ne hj,
        opposite_polynomial]

/-- Negative interaction is obtained from the same constructed finite replacement
by passing to the opposite algebra. -/
theorem replacement_mem_neg {i j : K} (hij : i ≠ j)
    (hneg : s.exchange.matrix (row i) j < 0) :
    (s.mutate i).exchangeCoordinate j ∈
      Subring.closure ((s.toExchangeFrame.pairRing (row i) (row j) : Set D) ∪
        {s.exchangeCoordinate i, s.exchangeCoordinate j, (s.coordinate (row j) : D)}) := by
  have hp : 0 < s.opposite.exchange.matrix (row i) j := by
    change 0 < -s.exchange.matrix (row i) j
    omega
  have h := s.opposite.replacement_mem_pos hij hp
  rw [s.opposite_mutate, (s.mutate i).opposite_exchangeCoordinate,
    s.opposite_pairRing, s.opposite_exchangeCoordinate, s.opposite_exchangeCoordinate,
    s.opposite_coordinate] at h
  let T := Subring.closure ((s.toExchangeFrame.pairRing (row i) (row j) : Set D) ∪
    {s.exchangeCoordinate i, s.exchangeCoordinate j, (s.coordinate (row j) : D)})
  have hle : Subring.closure (((s.toExchangeFrame.pairRing (row i) (row j)).op : Set Dᵐᵒᵖ) ∪
      {op (s.exchangeCoordinate i), op (s.exchangeCoordinate j), op (s.coordinate (row j) : D)}) ≤
      T.op := by
    apply Subring.closure_le.mpr
    rintro a (ha | ha)
    · exact Subring.subset_closure (Or.inl ha)
    · rcases ha with rfl | rfl | rfl <;>
        exact Subring.subset_closure (Or.inr (by simp))
  exact hle h

end
end TauCeti.Cluster.PolynomialExchangeSeed
