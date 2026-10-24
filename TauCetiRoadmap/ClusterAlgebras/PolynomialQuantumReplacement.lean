/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.PolynomialQuantumTerms
public import TauCetiRoadmap.ClusterAlgebras.PolynomialQuantumDefects
public import TauCetiRoadmap.LaurentPhenomenon.FiniteExchangeReplacement

/-!
# Finite replacement constructed from polynomial quantum seeds

For positive interaction every coefficient, constant term and defect is
constructed from the polynomial seed. The finite replacement theorem is
applied only after all of its algebraic hypotheses have been proved.
-/

@[expose] public section

namespace TauCeti.Cluster.PolynomialQuantumSeed

open TauCeti TauCeti.QuantumTorus TauCeti.Laurent

variable {D : Type*} [DivisionRing D] [Algebra Zv D]
  {M K : Type*} [Fintype M] [DecidableEq M] {row : K ↪ M}
  (s : PolynomialQuantumSeed D row)

noncomputable section

theorem scaledMonomial_mem_pairRing (i j : K) (t : ℤ) {a : M → ℤ}
    (hi : a (row i) = 0) (hj : a (row j) = 0) :
    scaledMonomial s.toQuantumSeed.chart t a ∈ s.toQuantumSeed.pairRing (row i) (row j) :=
  Subring.mul_mem _ (s.toQuantumSeed.algebraMap_mem_pairRing _ _ _)
    (s.toQuantumSeed.monomial_mem_pairRing hi hj)

theorem replacementCoefficient_mem {i j : K} (hij : i ≠ j)
    (hpos : 0 < s.exchange.matrix (row i) j) (l : ℕ) :
    s.replacementCoefficient i j l ∈ s.toQuantumSeed.pairRing (row i) (row j) := by
  apply Subring.mul_mem _ (s.toQuantumSeed.algebraMap_mem_pairRing _ _ _)
  apply s.scaledMonomial_mem_pairRing
  · simp only [replacementOriginalBase, Pi.sub_apply, Pi.add_apply, Pi.smul_apply,
      smul_eq_mul, Pi.single_eq_same, mul_one, s.replacementExponent_cast hpos]
    rw [positivePart, max_eq_right (by omega : -s.exchange.matrix (row i) j ≤ 0)]
    ring
  · simp [replacementOriginalBase, s.exchange.diagonal j, s.dividedColumn_row j,
      row.injective.ne hij.symm, positivePart]

theorem replacementCoefficient_zero_ne_zero (i j : K) :
    s.replacementCoefficient i j 0 ≠ 0 := by
  rw [s.replacementCoefficient_zero]
  exact scaledMonomial_ne_zero _ s.toQuantumSeed.isAlt _ _

theorem replacementCoefficient_zero_inv_mem {i j : K}
    (hpos : 0 < s.exchange.matrix (row i) j) :
    (s.replacementCoefficient i j 0)⁻¹ ∈ s.toQuantumSeed.pairRing (row i) (row j) := by
  rw [s.replacementCoefficient_zero, scaledMonomial_inv _ s.toQuantumSeed.isAlt]
  apply s.scaledMonomial_mem_pairRing
  · simp [replacementOriginalBase, positivePart,
      max_eq_right (by omega : -s.exchange.matrix (row i) j ≤ 0)]
  · simp [replacementOriginalBase, s.exchange.diagonal j, positivePart]

variable [Fintype K] [DecidableEq K]

theorem replacementMutatedCoefficient_mem {i j : K} (hij : i ≠ j)
    (hpos : 0 < s.exchange.matrix (row i) j) (l : ℕ) :
    s.replacementMutatedCoefficient i j l ∈ s.toQuantumSeed.pairRing (row i) (row j) := by
  apply Subring.mul_mem _ (s.toQuantumSeed.algebraMap_mem_pairRing _ _ _)
  apply s.scaledMonomial_mem_pairRing
  · simp only [Pi.add_apply, Pi.smul_apply, smul_eq_mul, s.replacementBase_row_left hpos,
      exchangeExponentPos_row (s.exchange.diagonal i), mul_neg_one, zero_add,
      s.replacementExponent_cast hpos]
    ring
  · simp [s.replacementBase_row_right hij, s.dividedColumn_row j, exchangeExponentPos,
      row.injective.ne hij.symm, positivePart,
      max_eq_right (s.exchange_matrix_reverse_neg hpos).le]

omit [Fintype K] [DecidableEq K] in
theorem exchange_product_split (i j : K) :
    s.exchangeCoordinate j * s.coordinate (row j) = s.replacementCoefficient i j 0 +
      ∑ l ∈ (Finset.range (s.degree j + 1)).erase 0,
        (s.coordinate (row i) : D) ^ s.replacementExponent i j l *
          s.replacementCoefficient i j l := by
  rw [exchangeCoordinate, Finset.sum_mul]
  simp_rw [s.original_exchange_term i j]
  rw [← Finset.sum_erase_add _ _ (Finset.mem_range.mpr (by omega : 0 < s.degree j + 1))]
  simp only [replacementExponent, zero_mul, pow_zero, one_mul]
  exact add_comm _ _

theorem mutated_exchange_product_split_pos {i j : K} (hij : i ≠ j)
    (hpos : 0 < s.exchange.matrix (row i) j) :
    (s.mutate i).exchangeCoordinate j * s.coordinate (row j) =
      s.exchangeCoordinate i ^ s.replacementDegree i j * s.replacementMutatedCoefficient i j 0 +
        ∑ l ∈ (Finset.range (s.degree j + 1)).erase 0,
          s.exchangeCoordinate i ^ (s.replacementDegree i j - s.replacementExponent i j l) *
            s.replacementMutatedCoefficient i j l := by
  rw [← s.mutate_coordinate_of_ne i (row.injective.ne hij.symm), exchangeCoordinate,
    s.mutate_degree, Finset.sum_mul]
  have hsum : ∑ l ∈ Finset.range (s.degree j + 1),
      (algebraMap Zv D (((s.mutate i).polynomial j).coeff l) *
        (s.mutate i).toQuantumSeed.monomial ((s.mutate i).exchangeExponent j l)) *
          (s.mutate i).coordinate (row j) =
      ∑ l ∈ Finset.range (s.degree j + 1),
        s.exchangeCoordinate i ^ (s.replacementDegree i j - s.replacementExponent i j l) *
          s.replacementMutatedCoefficient i j l := by
    apply Finset.sum_congr rfl
    intro l hl
    exact s.mutated_exchange_term_pos hij hpos (by have := Finset.mem_range.mp hl; omega)
  rw [hsum, ← Finset.sum_erase_add _ _
    (Finset.mem_range.mpr (by omega : 0 < s.degree j + 1))]
  simp only [replacementExponent, zero_mul, Nat.sub_zero]
  exact add_comm _ _

/-- All finite replacement hypotheses follow from the polynomial seed, for any
positive interaction and arbitrary exchange degrees and central coefficients. -/
theorem finiteReplacement_pos {i j : K} (hij : i ≠ j)
    (hpos : 0 < s.exchange.matrix (row i) j) :
    FiniteReplacementPremise (s.toQuantumSeed.pairRing (row i) (row j))
      (s.coordinate (row i) : D) (s.exchangeCoordinate i) (s.coordinate (row j) : D)
      (s.exchangeCoordinate j) ((s.mutate i).exchangeCoordinate j)
      (s.replacementMutatedCoefficient i j 0 * (s.replacementCoefficient i j 0)⁻¹)
      (s.replacementCoefficient i j 0) (s.replacementMutatedCoefficient i j 0)
      ((Finset.range (s.degree j + 1)).erase 0) (s.replacementDegree i j)
      (s.replacementExponent i j) (s.replacementCoefficient i j)
      (s.replacementMutatedCoefficient i j) (s.replacementConstant i j) where
  x_normalizes := s.toQuantumSeed.coordinate_normalizes_pairRing _ _ _
  z_normalizes := s.toQuantumSeed.coordinate_normalizes_pairRing _ _ _
  degree l hl := s.replacementExponent_le hpos (by
    have := Finset.mem_range.mp (Finset.mem_erase.mp hl).2; omega)
  phi_mem := Subring.mul_mem _ (s.replacementMutatedCoefficient_mem hij hpos 0)
    (s.replacementCoefficient_zero_inv_mem hpos)
  coefficient_mem l _ := s.replacementCoefficient_mem hij hpos l
  constant := by
    rw [mul_assoc, inv_mul_cancel₀ (s.replacementCoefficient_zero_ne_zero i j), mul_one]
  defect_mem l _ := s.replacement_defect_mem_pos hij hpos l
  zs_mul := s.exchange_product_split i j
  zss_mul := s.mutated_exchange_product_split_pos hij hpos
  compat l _ := by
    simpa only [mul_assoc] using s.replacementCoefficient_compat_pos hij hpos l

/-- Polynomial quantum replacement in the positive interaction case. -/
theorem replacement_mem_pos {i j : K} (hij : i ≠ j)
    (hpos : 0 < s.exchange.matrix (row i) j) :
    (s.mutate i).exchangeCoordinate j ∈
      Subring.closure ((s.toQuantumSeed.pairRing (row i) (row j) : Set D) ∪
        {s.exchangeCoordinate i, s.exchangeCoordinate j, (s.coordinate (row j) : D)}) :=
  (s.finiteReplacement_pos hij hpos).zss_mem

end
end TauCeti.Cluster.PolynomialQuantumSeed
