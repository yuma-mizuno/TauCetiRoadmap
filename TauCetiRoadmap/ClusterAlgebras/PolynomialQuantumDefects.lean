/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.PolynomialQuantumCoefficients
public import TauCetiRoadmap.ClusterAlgebras.QuantumSupport

/-!
# Polynomial exchange defects from support

The endpoint coefficient is one. Every other summand has positive exponent
in the interacting direction. The shared support theorem constructs all
power defects required by finite replacement, in every degree.
-/

@[expose] public section

namespace TauCeti.Cluster.PolynomialQuantumSeed

open TauCeti TauCeti.QuantumTorus TauCeti.Laurent

variable {D : Type*} [DivisionRing D] [Algebra Zv D]
  {M K : Type*} [Fintype M] [DecidableEq M] {row : K ↪ M}
  (s : PolynomialQuantumSeed D row)

noncomputable section

theorem exchangeCoordinate_positive_remainder {i j : K} (hij : i ≠ j)
    (hpos : 0 < s.exchange.matrix (row i) j) :
    s.exchangeCoordinate i - s.toQuantumSeed.monomial
        (exchangeExponentPos row s.exchange.matrix i) ∈
      s.toQuantumSeed.twoCoordinateSpan (row i) (row j) (-1) 1 := by
  let S := Finset.range (s.degree i + 1)
  let t (l : ℕ) : D := algebraMap Zv D ((s.polynomial i).coeff l) *
    s.toQuantumSeed.monomial (s.exchangeExponent i l)
  have hdeg : s.degree i ∈ S := Finset.mem_range.mpr (Nat.lt_succ_self _)
  have hc : (s.polynomial i).coeff (s.degree i) = 1 := s.monic i
  have hend : t (s.degree i) =
      s.toQuantumSeed.monomial (exchangeExponentPos row s.exchange.matrix i) := by
    dsimp only [t]
    rw [hc, map_one, one_mul, s.exchangeExponent_degree]
  have hs : s.exchangeCoordinate i = ∑ l ∈ S.erase (s.degree i), t l +
      s.toQuantumSeed.monomial (exchangeExponentPos row s.exchange.matrix i) := by
    change (∑ l ∈ S, t l) = _
    rw [← Finset.sum_erase_add S t hdeg, hend]
  rw [hs, add_sub_cancel_right]
  apply Submodule.sum_mem
  intro l hl
  have hlr : l < s.degree i := by
    have hm := Finset.mem_erase.mp hl
    have := Finset.mem_range.mp hm.2
    omega
  change algebraMap Zv D ((s.polynomial i).coeff l) *
    s.toQuantumSeed.monomial (s.exchangeExponent i l) ∈ _
  rw [← Algebra.smul_def (R := Zv) (A := D)]
  apply Submodule.smul_mem
  apply s.toQuantumSeed.monomial_mem_twoCoordinateSpan (s.exchangeExponent_row i l)
  have hb := s.exchange_matrix_reverse_neg hpos
  have hcol := s.dividedColumn_apply_mul_degree i (row j)
  have ht : s.dividedColumn i (row j) ≤ -1 := by
    by_contra h
    have ht0 : 0 ≤ s.dividedColumn i (row j) := by omega
    have := mul_nonneg (Int.natCast_nonneg (s.degree i)) ht0
    omega
  have hlcast : (l : ℤ) < s.degree i := by exact_mod_cast hlr
  have hprod : 1 ≤ ((s.degree i : ℤ) - l) * (-s.dividedColumn i (row j)) := by
    nlinarith
  simp only [exchangeExponent, exchangeExponentNeg, Pi.add_apply, Pi.neg_apply,
    Pi.single_eq_of_ne (row.injective.ne hij.symm), neg_zero, zero_add,
    Pi.smul_apply, smul_eq_mul]
  rw [positivePart, max_eq_left (by omega : 0 ≤ -s.exchange.matrix (row j) i)]
  nlinarith

theorem replacementConstant_eq (i j : K) (l : ℕ) :
    s.replacementConstant i j l =
      s.toQuantumSeed.monomial (exchangeExponentPos row s.exchange.matrix i) ^
          s.replacementExponent i j l *
        (s.coordinate (row i) : D) ^ s.replacementExponent i j l := by
  let n := s.replacementExponent i j l
  unfold replacementConstant
  dsimp only
  rw [← s.scaledMonomial_coordinate_power i]
  have hA := scaledMonomial_nat_smul s.toQuantumSeed.chart s.toQuantumSeed.isAlt
    (exchangeExponentPos row s.exchange.matrix i) n
  change scaledMonomial s.toQuantumSeed.chart 0
    ((n : ℤ) • exchangeExponentPos row s.exchange.matrix i) =
    s.toQuantumSeed.monomial (exchangeExponentPos row s.exchange.matrix i) ^ n at hA
  change scaledMonomial s.toQuantumSeed.chart _ _ =
    s.toQuantumSeed.monomial (exchangeExponentPos row s.exchange.matrix i) ^ n * _
  rw [← hA, scaledMonomial_mul, zero_add, zero_add]

/-- Every finite-replacement defect is constructed from the polynomial exchange itself. -/
theorem replacement_defect_mem_pos {i j : K} (hij : i ≠ j)
    (hpos : 0 < s.exchange.matrix (row i) j) (l : ℕ) :
    s.exchangeCoordinate i ^ s.replacementExponent i j l *
        (s.coordinate (row i) : D) ^ s.replacementExponent i j l -
        s.replacementConstant i j l ∈
      ((s.coordinate (row j) : D) * ·) ''
        (skewPolyRing (s.toQuantumSeed.pairRing (row i) (row j))
          (s.coordinate (row j) : D) : Set D) := by
  rw [s.replacementConstant_eq]
  apply s.toQuantumSeed.pow_mul_pow_sub_mem_of_positive_remainder (row.injective.ne hij)
  · apply s.toQuantumSeed.monomial_mem_twoCoordinateSpan
      (exchangeExponentPos_row (s.exchange.diagonal i))
    simp [exchangeExponentPos, row.injective.ne hij.symm, positivePart,
      max_eq_right (s.exchange_matrix_reverse_neg hpos).le]
  · exact s.exchangeCoordinate_positive_remainder hij hpos

end
end TauCeti.Cluster.PolynomialQuantumSeed
