/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.PolynomialQuantumMutation

/-!
# Involutivity and the polynomial quantum one-exchange intersection

Reversal of the mutated coefficient list reverses the exchange summation. The phases agree
by compatibility, giving involutivity for every degree. Q1 then follows from
the same skew one-exchange theorem used in the ordinary quantum theory.
-/

@[expose] public section

namespace TauCeti.Cluster.PolynomialQuantumSeed

open TauCeti TauCeti.QuantumTorus TauCeti.Laurent

variable {D : Type*} [DivisionRing D] [Algebra Zv D]
  {M K : Type*} [Fintype M] [DecidableEq M] {row : K ↪ M}

@[ext] theorem ext {s t : PolynomialQuantumSeed D row}
    (hframe : s.toQuantumSeed = t.toQuantumSeed) (hpoly : s.polynomial = t.polynomial) :
    s = t := by
  cases s
  cases t
  cases hframe
  cases hpoly
  rfl

noncomputable section

variable (s : PolynomialQuantumSeed D row)

theorem matrixForm_dividedColumn_of_apply_eq_zero (k : K) {a : M → ℤ}
    (ha : a (row k) = 0) : matrixForm s.form (s.dividedColumn k) a = 0 := by
  have h := s.compatible.matrixForm_col k a
  rw [← s.degree_mul_dividedColumn, map_zsmul, LinearMap.smul_apply, smul_eq_mul, ha,
    mul_zero] at h
  have hr : (s.degree k : ℤ) ≠ 0 := by
    have := s.degree_pos k
    change 0 < s.degree k at this
    omega
  exact (mul_eq_zero.mp h).resolve_left hr

theorem exchangeExponent_phase (k : K) (l : ℕ) :
    matrixForm s.form (s.exchangeExponent k l + Pi.single (row k) 1)
        (exchangeExponentNeg row s.exchange.matrix k) =
      matrixForm s.form (Pi.single (row k) 1) (s.exchangeExponent k l) := by
  have hz := s.matrixForm_dividedColumn_of_apply_eq_zero k (a :=
    exchangeExponentNeg row s.exchange.matrix k + Pi.single (row k) 1)
    (by simp [exchangeExponentNeg_row (s.exchange.diagonal k)])
  simp only [map_add] at hz
  simp only [exchangeExponent, map_add, map_zsmul, LinearMap.add_apply,
    LinearMap.smul_apply, smul_eq_mul, s.alternating.matrixForm_self]
  rw [s.alternating.matrixForm_swap (Pi.single (row k) 1) (s.dividedColumn k)]
  linear_combination (l : ℤ) * hz

theorem mutateChart_monomial_mul_exchangeCoordinate (k : K) {a : M → ℤ}
    (ha : a (row k) = -1) :
    s.mutateChart k (QuantumTorus.monomial a) * s.exchangeCoordinate k =
      algebraMap Zv D ((vUnit ^ matrixForm s.form (a + Pi.single (row k) 1)
        (exchangeExponentNeg row s.exchange.matrix k) : Zvˣ) : Zv) *
        s.toQuantumSeed.monomial (a + Pi.single (row k) 1) := by
  have ha0 : (a + Pi.single (row k) 1 : M → ℤ) (row k) = 0 := by simp [ha]
  have hform : matrixForm (formMutation row s.exchange.matrix s.form k 1)
      a (Pi.single (row k) 1) =
      matrixForm s.form (a + Pi.single (row k) 1)
        (exchangeExponentNeg row s.exchange.matrix k) := by
    have h := formMutation_matrixForm_zsmul_single (row := row) (B := s.exchange.matrix)
      (k := k) s.form (s.exchange.diagonal k) ha0 1
    simpa only [one_zsmul, one_mul, map_add, LinearMap.add_apply,
      (s.alternating.formMutation k 1).matrixForm_self, add_zero] using h
  have h := congrArg (s.mutateChart k) (monomial_mul_monomial (R := Zv) (u := vUnit)
    (Λ := matrixForm (formMutation row s.exchange.matrix s.form k 1)) a (Pi.single (row k) 1))
  rw [map_mul, map_smul, Algebra.smul_def (R := Zv) (A := D), hform,
    s.mutateChart_monomial_of_apply_eq_zero k ha0] at h
  simpa only [mutateChart, lift_monomial_single, mutateCoordinate_row] using h

variable [Fintype K] [DecidableEq K]

theorem mutate_polynomial (k : K) : (s.mutate k).polynomial = s.mutatePolynomial k := rfl

/-- Keeping the entire coefficient family fixed at a mutation is exactly reciprocity there. -/
theorem mutate_polynomial_eq_iff (k : K) :
    (s.mutate k).polynomial = s.polynomial ↔
      (s.polynomial k).reverse = s.polynomial k := by
  rw [mutate_polynomial, mutatePolynomial, Function.update_eq_self_iff]

@[simp] theorem mutate_degree (k j : K) : (s.mutate k).degree j = s.degree j :=
  s.mutatePolynomial_degree k j

theorem mutate_exchange_matrix (k : K) :
    (s.mutate k).exchange.matrix = extendedMatrixMutation row s.exchange.matrix k := rfl

theorem mutate_coordinate_row (k : K) :
    ((s.mutate k).coordinate (row k) : D) = s.exchangeCoordinate k :=
  s.mutateCoordinate_row k

theorem mutate_coordinate_of_ne (k : K) {j : M} (hj : j ≠ row k) :
    (s.mutate k).coordinate j = s.coordinate j := s.mutateCoordinate_of_ne k hj

theorem mutate_monomial (k : K) (a : M → ℤ) :
    (s.mutate k).toQuantumSeed.monomial a = s.mutateChart k (QuantumTorus.monomial a) := rfl

theorem mutate_dividedColumn (k : K) : (s.mutate k).dividedColumn k = -s.dividedColumn k := by
  have hr : (s.degree k : ℤ) ≠ 0 := by
    have := s.degree_pos k
    change 0 < s.degree k at this
    omega
  apply smul_right_injective (M := M → ℤ) hr
  change (s.degree k : ℤ) • (s.mutate k).dividedColumn k =
    (s.degree k : ℤ) • (-s.dividedColumn k)
  rw [smul_neg, s.degree_mul_dividedColumn, ← s.mutate_degree k k,
    (s.mutate k).degree_mul_dividedColumn]
  funext i
  simp [mutate_exchange_matrix, extendedMatrixMutation]

theorem mutate_exchangeExponent (k : K) {l : ℕ} (hl : l ≤ s.degree k) :
    (s.mutate k).exchangeExponent k l = s.exchangeExponent k (s.degree k - l) := by
  rw [exchangeExponent, mutate_exchange_matrix, exchangeExponentNeg_mutation,
    s.mutate_dividedColumn, exchangeExponent, exchangeExponentPos_eq_neg_add,
    ← s.degree_mul_dividedColumn]
  push_cast [Nat.cast_sub hl]
  module

theorem mutate_polynomial_coeff_reflect (k : K) {l : ℕ} (hl : l ≤ s.degree k) :
    ((s.mutate k).polynomial k).coeff (s.degree k - l) = (s.polynomial k).coeff l := by
  change l ≤ (s.polynomial k).natDegree at hl
  rw [mutate_polynomial, mutatePolynomial, Function.update_self]
  change (s.polynomial k).reverse.coeff ((s.polynomial k).natDegree - l) = _
  rw [Polynomial.coeff_reverse, Polynomial.revAt_le (Nat.sub_le _ _), Nat.sub_sub_self hl]

/-- The second polynomial exchange returns the original coordinate, in every degree. -/
theorem mutate_exchangeCoordinate (k : K) :
    (s.mutate k).exchangeCoordinate k = s.coordinate (row k) := by
  apply mul_right_cancel₀ (s.exchangeCoordinate_ne_zero k)
  rw [exchangeCoordinate, mutate_degree, Finset.sum_mul]
  conv_lhs => rw [← Finset.sum_range_reflect]
  conv_rhs => rw [exchangeCoordinate, Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro l hl
  have hle : l ≤ s.degree k := by have := Finset.mem_range.mp hl; omega
  have hrl : s.degree k - l ≤ s.degree k := Nat.sub_le _ _
  simp only [Nat.add_sub_cancel, s.mutate_polynomial_coeff_reflect k hle]
  rw [s.mutate_exchangeExponent k hrl, Nat.sub_sub_self hle, mul_assoc,
    s.mutate_monomial, s.mutateChart_monomial_mul_exchangeCoordinate k
      (s.exchangeExponent_row k l), s.exchangeExponent_phase]
  conv_rhs =>
    rw [← s.toQuantumSeed.monomial_single (row k), ← mul_assoc,
      ← Algebra.commutes ((s.polynomial k).coeff l)
        (s.toQuantumSeed.monomial (Pi.single (row k) 1)),
      mul_assoc, s.toQuantumSeed.monomial_mul_monomial]
  rw [add_comm (s.exchangeExponent k l)]

/-- Polynomial mutation is an involution on the original seed data. -/
theorem mutate_mutate (k : K) : (s.mutate k).mutate k = s := by
  refine ext (s := (s.mutate k).mutate k) (t := s) ?_ ?_
  · apply QuantumSeed.ext (s.exchange.mutate_mutate k)
      (s.compatible.formMutation_involutive s.alternating (Or.inl rfl) (Or.inl rfl))
    funext j
    by_cases hj : j = row k
    · subst hj
      exact Units.ext (((s.mutate k).mutate_coordinate_row k).trans
        (s.mutate_exchangeCoordinate k))
    · rw [mutate_coordinate_of_ne _ _ hj, mutate_coordinate_of_ne _ _ hj]
  · funext j
    by_cases hj : j = k
    · subst j
      simp only [mutate_polynomial, mutatePolynomial, Function.update_self]
      exact s.polynomial_reverse_reverse k
    · simp only [mutate_polynomial, mutatePolynomial, Function.update_of_ne hj]

theorem mutate_involutive (k : K) :
    Function.Involutive (fun s : PolynomialQuantumSeed D row ↦ s.mutate k) :=
  fun s ↦ s.mutate_mutate k

/-- Q1 for polynomial exchanges, from the shared skew one-exchange theorem. -/
theorem chartRing_inf_mutate_chartRing (k : K) :
    s.toQuantumSeed.chartRing ⊓ (s.mutate k).toQuantumSeed.chartRing =
      Subring.closure ((s.toQuantumSeed.otherRing (row k) : Set D) ∪
        {(s.coordinate (row k) : D), s.exchangeCoordinate k}) := by
  rw [s.toQuantumSeed.chartRing_eq_regroup (row k),
    (s.mutate k).toQuantumSeed.chartRing_eq_regroup (row k)]
  have ho : (s.mutate k).toQuantumSeed.otherRing (row k) =
      s.toQuantumSeed.otherRing (row k) := by
    unfold QuantumSeed.otherRing OneExchange.otherCoordinateRing
    congr 1
    funext j
    dsimp only
    rw [s.mutate_coordinate_of_ne k j.2]
  rw [ho, s.mutate_coordinate_row]
  have he := (s.exchangeData k).chartRing_inf_chartRing
  simpa only [mul_inv_cancel_right₀ (Units.ne_zero (s.coordinate (row k)))] using he

end
end TauCeti.Cluster.PolynomialQuantumSeed
