/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.PolynomialQuantumInvolutive
public import TauCetiRoadmap.ClusterAlgebras.QuantumPair
public import TauCetiRoadmap.LaurentPhenomenon.Quantum.ScaledMonomial

/-!
# The lattice calculation for polynomial quantum replacement

For interacting directions, the divided column after mutation is computed
from ordinary matrix mutation. This supplies the intermediate exponents in
the finite replacement identity, rather than assuming their compatibility.
-/

@[expose] public section

namespace TauCeti.Cluster.PolynomialQuantumSeed

open TauCeti TauCeti.QuantumTorus TauCeti.Laurent

variable {D : Type*} [DivisionRing D] [Algebra Zv D]
  {M K : Type*} [Fintype M] [DecidableEq M] {row : K ↪ M}
  (s : PolynomialQuantumSeed D row)

noncomputable section

theorem dividedColumn_apply_mul_degree (j : K) (a : M) :
    (s.degree j : ℤ) * s.dividedColumn j a = s.exchange.matrix a j := by
  exact congrFun (s.degree_mul_dividedColumn j) a

theorem dividedColumn_pos {i j : K} (hpos : 0 < s.exchange.matrix (row i) j) :
    0 < s.dividedColumn j (row i) := by
  have hd := s.degree_pos j
  change 0 < s.degree j at hd
  have h := s.dividedColumn_apply_mul_degree j (row i)
  by_contra hn
  have := mul_nonpos_of_nonneg_of_nonpos (Int.natCast_nonneg (s.degree j)) (le_of_not_gt hn)
  omega

theorem exchange_matrix_reverse_neg {i j : K} (hpos : 0 < s.exchange.matrix (row i) j) :
    s.exchange.matrix (row j) i < 0 := by
  have hsym := s.exchange.symmetrized i j
  by_contra h
  nlinarith [mul_pos (s.exchange.symmetrizer_pos i) hpos,
    mul_nonneg (s.exchange.symmetrizer_pos j).le (not_lt.1 h)]

variable [Fintype K] [DecidableEq K]

theorem dividedColumn_mutation_pos {i j : K} (hij : i ≠ j)
    (hpos : 0 < s.exchange.matrix (row i) j) :
    (s.mutate i).dividedColumn j = s.dividedColumn j +
      s.dividedColumn j (row i) •
        (exchangeExponentPos row s.exchange.matrix i - Pi.single (row i) 1) := by
  have hr : (s.degree j : ℤ) ≠ 0 := by
    have := s.degree_pos j
    change 0 < s.degree j at this
    omega
  apply smul_right_injective (M := M → ℤ) hr
  change (s.degree j : ℤ) • (s.mutate i).dividedColumn j = _
  rw [← s.mutate_degree i j, (s.mutate i).degree_mul_dividedColumn]
  rw [s.mutate_degree]
  funext a
  change extendedMatrixMutation row s.exchange.matrix i a j =
    (s.degree j : ℤ) * (s.dividedColumn j a + s.dividedColumn j (row i) *
      (exchangeExponentPos row s.exchange.matrix i a - (Pi.single (row i) 1 : M → ℤ) a))
  have hpa : (s.degree j : ℤ) * s.dividedColumn j a = s.exchange.matrix a j :=
    s.dividedColumn_apply_mul_degree j a
  have hp := s.dividedColumn_apply_mul_degree j (row i)
  by_cases ha : a = row i
  · subst a
    rw [extendedMatrixMutation, ite_eq_left (Or.inl rfl),
      exchangeExponentPos_row (s.exchange.diagonal i)]
    simp only [Pi.single_eq_same]
    nlinarith
  · rw [extendedMatrixMutation, ite_eq_right (not_or.mpr ⟨ha, hij.symm⟩)]
    simp only [positivePart, max_eq_left hpos.le,
      max_eq_right (by omega : -s.exchange.matrix (row i) j ≤ 0),
      mul_zero, sub_zero, exchangeExponentPos, Pi.add_apply, Pi.neg_apply,
      Pi.single_eq_of_ne ha, neg_zero, zero_add, sub_zero]
    rw [mul_add, ← mul_assoc, hp, hpa]
    ring

theorem mutate_polynomial_of_ne {i j : K} (hji : j ≠ i) :
    (s.mutate i).polynomial j = s.polynomial j := by
  rw [mutate_polynomial, mutatePolynomial, Function.update_of_ne hji]

theorem mutate_exchangeExponent_pos {i j : K} (hij : i ≠ j)
    (hpos : 0 < s.exchange.matrix (row i) j) (l : ℕ) :
    (s.mutate i).exchangeExponent j l =
      exchangeExponentNeg row (s.mutate i).exchange.matrix j +
        (l : ℤ) • s.dividedColumn j +
        ((l : ℤ) * s.dividedColumn j (row i)) •
          (exchangeExponentPos row s.exchange.matrix i - Pi.single (row i) 1) := by
  rw [exchangeExponent, s.dividedColumn_mutation_pos hij hpos, smul_add, smul_smul]
  abel

/-- Strip the maximal changed-coordinate exponent from the constant-index
summand of the second exchange. -/
def replacementBase (i j : K) : M → ℤ :=
  (fun a ↦ positivePart (-(s.mutate i).exchange.matrix a j)) -
    (s.exchange.matrix (row i) j) • Pi.single (row i) 1

/-- The exponent of the changed coordinate in the old `l`th summand. -/
def replacementExponent (i j : K) (l : ℕ) : ℕ :=
  l * (s.dividedColumn j (row i)).toNat

/-- The largest changed-coordinate exponent in the exchange. -/
def replacementDegree (i j : K) : ℕ := (s.exchange.matrix (row i) j).natAbs

omit [Fintype K] [DecidableEq K] in
theorem replacementDegree_cast {i j : K} (hpos : 0 < s.exchange.matrix (row i) j) :
    (s.replacementDegree i j : ℤ) = s.exchange.matrix (row i) j := by
  simp [replacementDegree, abs_of_pos hpos]

omit [Fintype K] [DecidableEq K] in
theorem replacementExponent_cast {i j : K} (hpos : 0 < s.exchange.matrix (row i) j)
    (l : ℕ) : (s.replacementExponent i j l : ℤ) =
      (l : ℤ) * s.dividedColumn j (row i) := by
  simp [replacementExponent, Int.toNat_of_nonneg (s.dividedColumn_pos hpos).le]

omit [Fintype K] [DecidableEq K] in
theorem replacementExponent_le {i j : K} (hpos : 0 < s.exchange.matrix (row i) j)
    {l : ℕ} (hl : l ≤ s.degree j) :
    s.replacementExponent i j l ≤ s.replacementDegree i j := by
  have hle : (l : ℤ) ≤ s.degree j := by exact_mod_cast hl
  have h := mul_le_mul_of_nonneg_right hle (s.dividedColumn_pos hpos).le
  rw [s.dividedColumn_apply_mul_degree, ← s.replacementDegree_cast hpos,
    ← s.replacementExponent_cast hpos] at h
  exact_mod_cast h

theorem replacementBase_row_left {i j : K} (hpos : 0 < s.exchange.matrix (row i) j) :
    s.replacementBase i j (row i) = 0 := by
  simp [replacementBase, mutate_exchange_matrix, extendedMatrixMutation,
    positivePart, max_eq_left hpos.le]

theorem replacementBase_row_right {i j : K} (hij : i ≠ j) :
    s.replacementBase i j (row j) = 0 := by
  simp [replacementBase, (s.mutate i).exchange.diagonal j, positivePart,
    row.injective.ne hij.symm]

omit [Fintype K] [DecidableEq K] in
theorem exchangeExponent_row_left_pos {i j : K} (hij : i ≠ j)
    (hpos : 0 < s.exchange.matrix (row i) j) (l : ℕ) :
    s.exchangeExponent j l (row i) = s.replacementExponent i j l := by
  simp [exchangeExponent, exchangeExponentNeg, row.injective.ne hij,
    positivePart, max_eq_right (by omega : -s.exchange.matrix (row i) j ≤ 0),
    s.replacementExponent_cast hpos]

/-- Matrix mutation supplies the whole affine family of new coefficient exponents. -/
theorem mutated_coefficient_vector_pos {i j : K} (hij : i ≠ j)
    (hpos : 0 < s.exchange.matrix (row i) j) {l : ℕ} (hl : l ≤ s.degree j) :
    (s.mutate i).exchangeExponent j l + Pi.single (row j) 1 -
        ((s.replacementDegree i j - s.replacementExponent i j l : ℕ) : ℤ) •
          Pi.single (row i) 1 =
      s.replacementBase i j + (l : ℤ) • s.dividedColumn j +
        (s.replacementExponent i j l : ℤ) • exchangeExponentPos row s.exchange.matrix i := by
  rw [s.mutate_exchangeExponent_pos hij hpos, Nat.cast_sub (s.replacementExponent_le hpos hl),
    s.replacementDegree_cast hpos, s.replacementExponent_cast hpos]
  simp only [exchangeExponentNeg, replacementBase]
  module

end
end TauCeti.Cluster.PolynomialQuantumSeed
