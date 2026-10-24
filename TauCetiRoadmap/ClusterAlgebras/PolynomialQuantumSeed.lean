/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.QuantumSeed
public import Mathlib.Algebra.Polynomial.Reverse

/-!
# Polynomial quantum seeds

The underlying compatible pair and faithful chart are the existing `QuantumSeed`
data. Only the monic exchange polynomials with constant coefficient one are added.
Their degree divides the extended
matrix column. No mutation, new-chart faithfulness or Laurent property is input.
-/

@[expose] public section

namespace TauCeti.Cluster

open TauCeti TauCeti.QuantumTorus TauCeti.Laurent

variable {D : Type*} [DivisionRing D] [Algebra Zv D]
  {M K : Type*} [Fintype M] [DecidableEq M] {row : K ↪ M}

/-- A compatible faithful quantum chart with monic central exchange polynomials.
The degree is positive and divides every entry of its extended exchange column. -/
structure PolynomialQuantumSeed (D : Type*) [DivisionRing D] [Algebra Zv D]
    {M K : Type*} [Fintype M] [DecidableEq M] (row : K ↪ M)
    extends QuantumSeed D row where
  /-- The exchange polynomial in each mutable direction. -/
  polynomial : K → Polynomial Zv
  constant_one : ∀ k, (polynomial k).coeff 0 = 1
  monic : ∀ k, (polynomial k).Monic
  degree_pos : ∀ k, 0 < (polynomial k).natDegree
  degree_dvd : ∀ i k, ((polynomial k).natDegree : ℤ) ∣ exchange.matrix i k

namespace PolynomialQuantumSeed

noncomputable section

variable (s : PolynomialQuantumSeed D row)

/-- The exchange degree, independent of the symmetrizer of the compatible pair. -/
def degree (k : K) : ℕ := (s.polynomial k).natDegree

/-- The divided extended column of the exchange matrix. -/
def dividedColumn (k : K) : M → ℤ :=
  fun i ↦ s.exchange.matrix i k / s.degree k

theorem degree_mul_dividedColumn (k : K) :
    (s.degree k : ℤ) • s.dividedColumn k = fun i ↦ s.exchange.matrix i k := by
  funext i
  simp only [dividedColumn, Pi.smul_apply, smul_eq_mul]
  exact Int.mul_ediv_cancel' (s.degree_dvd i k)

theorem dividedColumn_ne_zero (k : K) : s.dividedColumn k ≠ 0 := by
  intro h
  have := s.degree_mul_dividedColumn k
  rw [h, smul_zero] at this
  exact s.compatible.col_ne_zero k this.symm

theorem dividedColumn_row (k : K) : s.dividedColumn k (row k) = 0 := by
  simp [dividedColumn, s.exchange.diagonal]

/-- The exponent of the `l`th exchange summand; the two endpoints are the ordinary
negative and positive exchange exponents. -/
def exchangeExponent (k : K) (l : ℕ) : M → ℤ :=
  exchangeExponentNeg row s.exchange.matrix k + (l : ℤ) • s.dividedColumn k

theorem exchangeExponent_zero (k : K) :
    s.exchangeExponent k 0 = exchangeExponentNeg row s.exchange.matrix k := by
  simp [exchangeExponent]

theorem exchangeExponent_degree (k : K) :
    s.exchangeExponent k (s.degree k) = exchangeExponentPos row s.exchange.matrix k := by
  rw [exchangeExponent, s.degree_mul_dividedColumn, exchangeExponentPos_eq_neg_add]

theorem exchangeExponent_row (k : K) (l : ℕ) :
    s.exchangeExponent k l (row k) = -1 := by
  simp [exchangeExponent, s.dividedColumn_row,
    exchangeExponentNeg_row (s.exchange.diagonal k)]

theorem exchangeExponent_injective (k : K) : Function.Injective (s.exchangeExponent k) := by
  intro l m h
  have hsmul : (l : ℤ) • s.dividedColumn k = (m : ℤ) • s.dividedColumn k :=
    add_left_cancel h
  exact_mod_cast (smul_left_injective ℤ (s.dividedColumn_ne_zero k) hsmul)

theorem exchangeExponent_nonneg_of_ne (k : K) {a : M} (ha : a ≠ row k)
    {l : ℕ} (hl : l ≤ s.degree k) : 0 ≤ s.exchangeExponent k l a := by
  have hc := congrFun (s.degree_mul_dividedColumn k) a
  change (s.degree k : ℤ) * s.dividedColumn k a = s.exchange.matrix a k at hc
  simp only [exchangeExponent, exchangeExponentNeg, Pi.add_apply, Pi.neg_apply,
    Pi.single_eq_of_ne ha, neg_zero, zero_add, Pi.smul_apply, smul_eq_mul]
  by_cases hb : 0 ≤ s.dividedColumn k a
  · have hB : 0 ≤ s.exchange.matrix a k := by
      rw [← hc]
      exact mul_nonneg (Int.natCast_nonneg _) hb
    rw [positivePart, max_eq_right (neg_nonpos.mpr hB), zero_add]
    exact mul_nonneg (Int.natCast_nonneg _) hb
  · have ht : s.dividedColumn k a ≤ 0 := le_of_not_ge hb
    have hB : s.exchange.matrix a k ≤ 0 := by
      rw [← hc]
      exact mul_nonpos_of_nonneg_of_nonpos (Int.natCast_nonneg _) ht
    rw [positivePart, max_eq_left (neg_nonneg.mpr hB)]
    have hle : (l : ℤ) ≤ s.degree k := by exact_mod_cast hl
    nlinarith [mul_nonneg (sub_nonneg.mpr hle) (neg_nonneg.mpr ht)]

theorem leadingCoeff_eq_one (k : K) : (s.polynomial k).leadingCoeff = 1 := by
  exact s.monic k

theorem polynomial_reverse_natDegree (k : K) :
    (s.polynomial k).reverse.natDegree = (s.polynomial k).natDegree := by
  rw [Polynomial.reverse_natDegree,
    Polynomial.natTrailingDegree_eq_zero.mpr (Or.inr (by rw [s.constant_one]; exact one_ne_zero)),
    Nat.sub_zero]

theorem polynomial_reverse_monic (k : K) : (s.polynomial k).reverse.Monic := by
  change (s.polynomial k).reverse.leadingCoeff = 1
  rw [Polynomial.reverse_leadingCoeff, Polynomial.trailingCoeff,
    Polynomial.natTrailingDegree_eq_zero.mpr (Or.inr (by rw [s.constant_one]; exact one_ne_zero)),
    s.constant_one]

theorem polynomial_reverse_reverse (k : K) : (s.polynomial k).reverse.reverse = s.polynomial k := by
  ext n
  rw [Polynomial.coeff_reverse, s.polynomial_reverse_natDegree,
    Polynomial.coeff_reverse, Polynomial.revAt_invol]

theorem matrixForm_dividedColumn_single {k : K} {j : M} (hj : j ≠ row k) :
    matrixForm s.form (s.dividedColumn k) (Pi.single j 1) = 0 := by
  have h := s.toQuantumSeed.compatible.matrixForm_col k (Pi.single j 1)
  rw [← s.degree_mul_dividedColumn, map_zsmul, LinearMap.smul_apply, smul_eq_mul] at h
  have hr : (s.degree k : ℤ) ≠ 0 := by
    have := s.degree_pos k
    change 0 < s.degree k at this
    omega
  have he : (Pi.single j 1 : M → ℤ) (row k) = 0 := Pi.single_eq_of_ne hj.symm 1
  rw [he, mul_zero] at h
  exact (mul_eq_zero.mp h).resolve_left hr

theorem matrixForm_exchangeExponent_single {k : K} {j : M} (hj : j ≠ row k) (l : ℕ) :
    matrixForm s.form (s.exchangeExponent k l) (Pi.single j 1) =
      matrixForm s.form (exchangeExponentPos row s.exchange.matrix k) (Pi.single j 1) := by
  rw [exchangeExponent, map_add, map_zsmul, LinearMap.add_apply, LinearMap.smul_apply,
    s.matrixForm_dividedColumn_single hj, smul_zero, add_zero]
  exact (s.compatible.matrixForm_exchangeExponentPos_eq_neg hj).symm

/-- The actual polynomial exchange coordinate in the ambient division ring. -/
def exchangeCoordinate (k : K) : D :=
  ∑ l ∈ Finset.range (s.degree k + 1),
    algebraMap Zv D ((s.polynomial k).coeff l) * s.toQuantumSeed.monomial
      (s.exchangeExponent k l)

theorem exchangeCoordinate_ne_zero (k : K) : s.exchangeCoordinate k ≠ 0 := by
  intro h
  have hsum : (∑ l ∈ Finset.range (s.degree k + 1),
      (s.polynomial k).coeff l • (QuantumTorus.monomial (s.exchangeExponent k l) :
        quantumTorus Zv vUnit (matrixForm s.form))) = 0 := by
    apply s.toQuantumSeed.chart_injective
    rw [map_sum, map_zero]
    change (∑ l ∈ Finset.range (s.degree k + 1), _) = 0
    convert h using 1
    apply Finset.sum_congr rfl
    intro l _
    rw [map_smul, Algebra.smul_def]
    rfl
  have hc := congrArg (coeff (s.exchangeExponent k 0)) hsum
  simp only [map_sum, map_smul, map_zero, smul_eq_mul] at hc
  rw [Finset.sum_eq_single 0] at hc
  · simp [s.constant_one] at hc
  · intro l _ hl
    rw [coeff_monomial_of_ne (fun h ↦ hl (s.exchangeExponent_injective k h)), mul_zero]
  · simp

theorem exchangeCoordinate_mem_chartRing (k : K) :
    s.exchangeCoordinate k ∈ s.toQuantumSeed.chartRing := by
  apply Subring.sum_mem
  intro l _
  exact Subring.mul_mem _ (coefficient_mem_chartRing _ _ ⟨_, rfl⟩)
    (s.toQuantumSeed.monomial_mem_chartRing _)

theorem exchangeCoordinate_mul_coordinate (k : K) {j : M} (hj : j ≠ row k) :
    s.exchangeCoordinate k * s.coordinate j =
      algebraMap Zv D ((vUnit ^ (2 * matrixForm s.form
        (exchangeExponentPos row s.exchange.matrix k) (Pi.single j 1)) : Zvˣ) : Zv) *
        (s.coordinate j * s.exchangeCoordinate k) := by
  simp only [exchangeCoordinate, Finset.sum_mul, Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro l _
  rw [mul_assoc, s.toQuantumSeed.monomial_mul_coordinate,
    s.matrixForm_exchangeExponent_single hj, ← mul_assoc, ← map_mul,
    mul_comm ((s.polynomial k).coeff l), map_mul, mul_assoc]
  congr 1
  rw [← mul_assoc, (Algebra.commutes ((s.polynomial k).coeff l)
    (s.coordinate j : D)), mul_assoc]

end
end PolynomialQuantumSeed
end TauCeti.Cluster
