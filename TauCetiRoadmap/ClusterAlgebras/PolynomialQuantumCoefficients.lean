/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.PolynomialQuantumLocalVectors

/-!
# Constructed coefficients for polynomial quantum replacement

The old and new coefficients, and the constant part of the first exchange
power, are explicit normalized monomials. Compatibility follows from the
actual compatible matrix pair. The coefficient relation is not seed data.
-/

@[expose] public section

namespace TauCeti.Cluster.PolynomialExchangeSeed

open TauCeti TauCeti.QuantumTorus TauCeti.Laurent

variable {R₀ : Type*} [CommRing R₀] {u₀ : R₀ˣ}
  {D : Type*} [DivisionRing D] [Algebra R₀ D]
  {M K : Type*} [Fintype M] [DecidableEq M] {row : K ↪ M}
  (s : PolynomialExchangeSeed (u₀ := u₀) D row)

noncomputable section

/-- The zero-index coefficient direction of the old exchange product. -/
def replacementOriginalBase (j : K) : M → ℤ :=
  fun a ↦ positivePart (-s.exchange.matrix a j)

/-- The coefficient after splitting the old changed-coordinate power on the left. -/
def replacementCoefficient (i j : K) (l : ℕ) : D :=
  let e : M → ℤ := Pi.single (row i) 1
  let f : M → ℤ := Pi.single (row j) 1
  let V := s.replacementOriginalBase j + (l : ℤ) • s.dividedColumn j
  let n : ℤ := s.replacementExponent i j l
  algebraMap R₀ D ((s.polynomial j).coeff l) *
    scaledMonomial s.toExchangeFrame.chart
      (matrixForm s.form (V - f) f - matrixForm s.form (n • e) (V - n • e)) (V - n • e)

variable [Fintype K] [DecidableEq K]

/-- The coefficient direction after the first mutation,
with the changed-coordinate power removed. -/
def replacementMutatedCoefficient (i j : K) (l : ℕ) : D :=
  let f : M → ℤ := Pi.single (row j) 1
  let A := exchangeExponentPos row s.exchange.matrix i
  let n : ℤ := s.replacementExponent i j l
  let N : ℤ := s.replacementDegree i j
  let V := s.replacementBase i j + (l : ℤ) • s.dividedColumn j + n • A
  algebraMap R₀ D ((s.polynomial j).coeff l) *
    scaledMonomial s.toExchangeFrame.chart
      ((N - n) * matrixForm s.form (V - f) A + matrixForm s.form (V - f) f) V

/-- The explicit constant part of the first exchange power times the old coordinate power. -/
def replacementConstant (i j : K) (l : ℕ) : D :=
  let e : M → ℤ := Pi.single (row i) 1
  let A := exchangeExponentPos row s.exchange.matrix i
  let n : ℤ := s.replacementExponent i j l
  scaledMonomial s.toExchangeFrame.chart (matrixForm s.form (n • A) (n • e)) (n • A + n • e)

omit [Fintype K] [DecidableEq K] in
theorem replacementCoefficient_zero (i j : K) :
    s.replacementCoefficient i j 0 = scaledMonomial s.toExchangeFrame.chart
      (matrixForm s.form (s.replacementOriginalBase j - Pi.single (row j) 1)
        (Pi.single (row j) 1)) (s.replacementOriginalBase j) := by
  simp [replacementCoefficient, replacementExponent, s.constant_one]

theorem replacementMutatedCoefficient_zero (i j : K) :
    s.replacementMutatedCoefficient i j 0 = scaledMonomial s.toExchangeFrame.chart
      ((s.replacementDegree i j : ℤ) * matrixForm s.form
          (s.replacementBase i j - Pi.single (row j) 1)
          (exchangeExponentPos row s.exchange.matrix i) +
        matrixForm s.form (s.replacementBase i j - Pi.single (row j) 1)
          (Pi.single (row j) 1)) (s.replacementBase i j) := by
  simp [replacementMutatedCoefficient, replacementExponent, s.constant_one]

omit [Fintype K] [DecidableEq K] in
theorem scaledMonomial_coordinate_power (i : K) (n : ℕ) :
    scaledMonomial s.toExchangeFrame.chart 0 ((n : ℤ) • Pi.single (row i) 1) =
      (s.coordinate (row i) : D) ^ n := by
  rw [scaledMonomial_nat_smul _ s.toExchangeFrame.isAlt]
  change s.toExchangeFrame.monomial (Pi.single (row i) 1) ^ n = _
  rw [s.toExchangeFrame.monomial_single]

/-- The finite replacement compatibility relation is proved for every intermediate
coefficient of every positively interacting pair, without reciprocity. -/
theorem replacementCoefficient_compat_pos {i j : K} (hij : i ≠ j)
    (hpos : 0 < s.exchange.matrix (row i) j) (l : ℕ) :
    s.replacementMutatedCoefficient i j l = s.replacementConstant i j l *
      ((s.coordinate (row i) : D) ^ s.replacementExponent i j l)⁻¹ *
        (s.replacementMutatedCoefficient i j 0 * (s.replacementCoefficient i j 0)⁻¹) *
        (s.coordinate (row i) : D) ^ s.replacementExponent i j l *
          s.replacementCoefficient i j l := by
  let e : M → ℤ := Pi.single (row i) 1
  let f : M → ℤ := Pi.single (row j) 1
  let A := exchangeExponentPos row s.exchange.matrix i
  let U := s.replacementOriginalBase j
  let Z := s.replacementBase i j
  let J := s.dividedColumn j
  have he : e (row j) = 0 := by simp [e, row.injective.ne hij.symm]
  have hA : A (row j) = 0 := by
    simp [A, exchangeExponentPos, row.injective.ne hij.symm, positivePart,
      max_eq_right (s.exchange_matrix_reverse_neg hpos).le]
  have hU : U (row j) = 0 := by
    simp [U, replacementOriginalBase, s.exchange.diagonal j, positivePart]
  have hZ : Z (row j) = 0 := s.replacementBase_row_right hij
  have h := polynomialReplacement_coefficient s.toExchangeFrame.chart s.toExchangeFrame.isAlt
    e f A U Z J (s.replacementDegree i j : ℤ) (s.replacementExponent i j l : ℤ) (l : ℤ)
    (s.matrixForm_dividedColumn_of_apply_eq_zero j he)
    (s.matrixForm_dividedColumn_of_apply_eq_zero j hA)
    (s.matrixForm_dividedColumn_of_apply_eq_zero j hU)
    (s.matrixForm_dividedColumn_of_apply_eq_zero j hZ)
  rw [s.scaledMonomial_coordinate_power,
    ← s.replacementCoefficient_zero i j, ← s.replacementMutatedCoefficient_zero i j] at h
  change scaledMonomial s.toExchangeFrame.chart _ _ =
    s.replacementConstant i j l * _ * _ * _ * _ at h
  let T := s.replacementConstant i j l *
    ((s.coordinate (row i) : D) ^ s.replacementExponent i j l)⁻¹ *
      (s.replacementMutatedCoefficient i j 0 * (s.replacementCoefficient i j 0)⁻¹) *
      (s.coordinate (row i) : D) ^ s.replacementExponent i j l
  change algebraMap R₀ D ((s.polynomial j).coeff l) * _ =
    T * (algebraMap R₀ D ((s.polynomial j).coeff l) * _)
  rw [h, ← mul_assoc, Algebra.commutes ((s.polynomial j).coeff l) T, mul_assoc]

end
end TauCeti.Cluster.PolynomialExchangeSeed
