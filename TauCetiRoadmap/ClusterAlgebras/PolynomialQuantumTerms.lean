/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.PolynomialQuantumCoefficients

/-!
# Actual summands of the two polynomial quantum exchanges

The coefficient formulas are identified with the old and mutated exchange
summands. The new monomial is computed from the constructed mutated chart.
-/

@[expose] public section

namespace TauCeti.Cluster.PolynomialQuantumSeed

open TauCeti TauCeti.QuantumTorus TauCeti.Laurent

variable {D : Type*} [DivisionRing D] [Algebra Zv D]
  {M K : Type*} [Fintype M] [DecidableEq M] {row : K ↪ M}
  (s : PolynomialQuantumSeed D row)

noncomputable section

theorem mutateChart_monomial_power (k : K) (n : ℕ) :
    s.mutateChart k (monomial ((n : ℤ) • Pi.single (row k) 1)) =
      s.exchangeCoordinate k ^ n := by
  rw [mutateChart, lift_monomial_zsmul_single, Units.val_zpow_eq_zpow_val,
    s.mutateCoordinate_row, zpow_natCast]

theorem matrixForm_endpoint_eq (k : K) {a : M → ℤ} (ha : a (row k) = 0) :
    matrixForm s.form a (exchangeExponentNeg row s.exchange.matrix k) =
      matrixForm s.form a (exchangeExponentPos row s.exchange.matrix k) := by
  rw [exchangeExponentPos_eq_neg_add, map_add,
    s.compatible.matrixForm_col_right s.alternating, ha, mul_zero, neg_zero, add_zero]

/-- Splitting the changed coordinate on the left in an actual mutated monomial. -/
theorem mutateChart_monomial_split_left (k : K) (n : ℕ) {a : M → ℤ}
    (ha : a (row k) = n) :
    s.mutateChart k (monomial a) = s.exchangeCoordinate k ^ n *
      scaledMonomial s.toQuantumSeed.chart
        ((n : ℤ) * matrixForm s.form (a - (n : ℤ) • Pi.single (row k) 1)
          (exchangeExponentPos row s.exchange.matrix k))
        (a - (n : ℤ) • Pi.single (row k) 1) := by
  let b := a - (n : ℤ) • Pi.single (row k) 1
  have hb : b (row k) = 0 := by simp [b, ha]
  have hform : matrixForm (formMutation row s.exchange.matrix s.form k 1)
      ((n : ℤ) • Pi.single (row k) 1) b =
      -((n : ℤ) * matrixForm s.form b (exchangeExponentPos row s.exchange.matrix k)) := by
    rw [(s.alternating.formMutation k 1).matrixForm_swap,
      formMutation_matrixForm_zsmul_single s.form (s.exchange.diagonal k) hb,
      s.matrixForm_endpoint_eq k hb]
  have h := congrArg (s.mutateChart k) (monomial_mul_monomial (R := Zv) (u := vUnit)
    (Λ := matrixForm (formMutation row s.exchange.matrix s.form k 1))
    ((n : ℤ) • Pi.single (row k) 1) b)
  have he : (n : ℤ) • Pi.single (row k) 1 + b = a := by dsimp [b]; abel
  rw [map_mul, map_smul, Algebra.smul_def (R := Zv) (A := D), he,
    s.mutateChart_monomial_power, s.mutateChart_monomial_of_apply_eq_zero k hb, hform] at h
  let t := (n : ℤ) * matrixForm s.form b (exchangeExponentPos row s.exchange.matrix k)
  change s.mutateChart k (monomial a) = s.exchangeCoordinate k ^ n *
    (algebraMap Zv D ((vUnit ^ t : Zvˣ) : Zv) * s.toQuantumSeed.monomial b)
  calc
    s.mutateChart k (monomial a) = algebraMap Zv D ((vUnit ^ t : Zvˣ) : Zv) *
        (algebraMap Zv D ((vUnit ^ (-t) : Zvˣ) : Zv) * s.mutateChart k (monomial a)) := by
      rw [← mul_assoc, ← map_mul, ← Units.val_mul, ← zpow_add, add_neg_cancel]
      simp
    _ = algebraMap Zv D ((vUnit ^ t : Zvˣ) : Zv) *
        (s.exchangeCoordinate k ^ n * s.toQuantumSeed.monomial b) := by rw [← h]
    _ = _ := by rw [← mul_assoc, Algebra.commutes, mul_assoc]

theorem original_exchange_term (i j : K) (l : ℕ) :
    (algebraMap Zv D ((s.polynomial j).coeff l) *
      s.toQuantumSeed.monomial (s.exchangeExponent j l)) * s.coordinate (row j) =
      (s.coordinate (row i) : D) ^ s.replacementExponent i j l *
        s.replacementCoefficient i j l := by
  let e : M → ℤ := Pi.single (row i) 1
  let f : M → ℤ := Pi.single (row j) 1
  let V := s.replacementOriginalBase j + (l : ℤ) • s.dividedColumn j
  have hα : s.exchangeExponent j l = V - f := by
    change (-(Pi.single (row j) 1) + s.replacementOriginalBase j) +
      (l : ℤ) • s.dividedColumn j =
      (s.replacementOriginalBase j + (l : ℤ) • s.dividedColumn j) - Pi.single (row j) 1
    abel
  rw [mul_assoc, ← s.toQuantumSeed.monomial_single (row j),
    s.toQuantumSeed.monomial_mul_monomial, hα, sub_add_cancel]
  change algebraMap Zv D ((s.polynomial j).coeff l) *
    scaledMonomial s.toQuantumSeed.chart (matrixForm s.form (V - f) f) V = _
  rw [scaledMonomial_split _ _ _ ((s.replacementExponent i j l : ℤ) • e),
    s.scaledMonomial_coordinate_power]
  rw [← mul_assoc, Algebra.commutes, mul_assoc]
  rfl

variable [Fintype K] [DecidableEq K]

theorem mutated_exchangeExponent_row_left {i j : K} (hij : i ≠ j)
    (hpos : 0 < s.exchange.matrix (row i) j) {l : ℕ} (hl : l ≤ s.degree j) :
    (s.mutate i).exchangeExponent j l (row i) =
      ((s.replacementDegree i j - s.replacementExponent i j l : ℕ) : ℤ) := by
  have h := congrFun (s.mutated_coefficient_vector_pos hij hpos hl) (row i)
  simp only [Pi.sub_apply, Pi.add_apply, Pi.smul_apply, Pi.single_eq_same, smul_eq_mul,
    s.replacementBase_row_left hpos, zero_add, exchangeExponentPos_row
      (s.exchange.diagonal i), mul_neg_one] at h
  rw [Pi.single_eq_of_ne (row.injective.ne hij)] at h
  rw [s.replacementExponent_cast hpos] at h
  linear_combination h

/-- The constructed coefficient is the actual coefficient of the changed
coordinate power in each mutated exchange summand. -/
theorem mutated_exchange_term_pos {i j : K} (hij : i ≠ j)
    (hpos : 0 < s.exchange.matrix (row i) j) {l : ℕ} (hl : l ≤ s.degree j) :
    (algebraMap Zv D (((s.mutate i).polynomial j).coeff l) *
      (s.mutate i).toQuantumSeed.monomial ((s.mutate i).exchangeExponent j l)) *
        (s.mutate i).coordinate (row j) =
      s.exchangeCoordinate i ^ (s.replacementDegree i j - s.replacementExponent i j l) *
        s.replacementMutatedCoefficient i j l := by
  let m := s.replacementDegree i j - s.replacementExponent i j l
  let f : M → ℤ := Pi.single (row j) 1
  let V := s.replacementBase i j + (l : ℤ) • s.dividedColumn j +
    (s.replacementExponent i j l : ℤ) • exchangeExponentPos row s.exchange.matrix i
  have hv : (s.mutate i).exchangeExponent j l - (m : ℤ) • Pi.single (row i) 1 = V - f := by
    have h := s.mutated_coefficient_vector_pos hij hpos hl
    dsimp [m, V, f]
    linear_combination h
  rw [s.mutate_polynomial_of_ne hij.symm, s.mutate_coordinate_of_ne i (row.injective.ne hij.symm),
    s.mutate_monomial, s.mutateChart_monomial_split_left i m
      (s.mutated_exchangeExponent_row_left hij hpos hl), hv]
  simp only [mul_assoc]
  rw [← mul_assoc (algebraMap Zv D ((s.polynomial j).coeff l)) (s.exchangeCoordinate i ^ m),
    Algebra.commutes ((s.polynomial j).coeff l) (s.exchangeCoordinate i ^ m), mul_assoc]
  congr 1
  have hf : (s.coordinate (row j) : D) = scaledMonomial s.toQuantumSeed.chart 0 f := by
    simp only [scaledMonomial, zpow_zero, Units.val_one, map_one, one_mul]
    exact (s.toQuantumSeed.monomial_single (row j)).symm
  rw [hf]
  change algebraMap Zv D ((s.polynomial j).coeff l) *
    (scaledMonomial s.toQuantumSeed.chart _ (V - f) * scaledMonomial s.toQuantumSeed.chart 0 f) = _
  rw [scaledMonomial_mul, sub_add_cancel, add_zero]
  dsimp only [replacementMutatedCoefficient, m]
  rw [Nat.cast_sub (s.replacementExponent_le hpos hl)]

end
end TauCeti.Cluster.PolynomialQuantumSeed
