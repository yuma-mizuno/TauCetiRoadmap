/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.PolynomialExchangeSeed
public import TauCetiRoadmap.LaurentPhenomenon.Quantum.ChangeChart

/-!
# Mutation of polynomial quantum seeds

The new chart is constructed from the polynomial exchange expression. Its
faithfulness follows from the existing skew one-exchange freeness theorem.
The matrix and form mutation are the ordinary compatible-pair constructions.
-/

@[expose] public section

namespace TauCeti.Cluster.PolynomialExchangeSeed

open TauCeti TauCeti.QuantumTorus TauCeti.Laurent

variable {R₀ : Type*} [CommRing R₀] {u₀ : R₀ˣ}
  {D : Type*} [DivisionRing D] [Algebra R₀ D]
  {M K : Type*} [Fintype M] [DecidableEq M] {row : K ↪ M}
  (s : PolynomialExchangeSeed (u₀ := u₀) D row)

noncomputable section

theorem coordinate_mul_exchangeCoordinate (k : K) {j : M} (hj : j ≠ row k) :
    s.coordinate j * s.exchangeCoordinate k =
      algebraMap R₀ D ((u₀ ^ (2 * matrixForm s.form (Pi.single j 1)
        (exchangeExponentPos row s.exchange.matrix k)) : R₀ˣ) : R₀) *
        (s.exchangeCoordinate k * s.coordinate j) := by
  rw [s.alternating.matrixForm_swap (Pi.single j 1), mul_neg]
  calc
    (s.coordinate j : D) * s.exchangeCoordinate k =
        algebraMap R₀ D ((u₀ ^ (-(2 * matrixForm s.form
          (exchangeExponentPos row s.exchange.matrix k) (Pi.single j 1))) : R₀ˣ) : R₀) *
        (algebraMap R₀ D ((u₀ ^ (2 * matrixForm s.form
          (exchangeExponentPos row s.exchange.matrix k) (Pi.single j 1)) : R₀ˣ) : R₀) *
          (s.coordinate j * s.exchangeCoordinate k)) := by
      rw [← mul_assoc, ← map_mul, ← Units.val_mul, ← zpow_add, neg_add_cancel]
      simp
    _ = _ := by rw [← s.exchangeCoordinate_mul_coordinate k hj]

theorem exchangeCoordinate_normalizes (k : K) :
    Normalizes (s.toExchangeFrame.otherRing (row k)) (s.exchangeCoordinate k) :=
  s.toExchangeFrame.normalizes_otherRing (s.exchangeCoordinate_ne_zero k)
    (fun j ↦ u₀ ^ (2 * matrixForm s.form (exchangeExponentPos row s.exchange.matrix k)
      (Pi.single j 1))) (fun _ hj ↦ s.exchangeCoordinate_mul_coordinate k hj)

theorem exchangeCoordinate_mul_coordinate_mem (k : K) :
    s.exchangeCoordinate k * s.coordinate (row k) ∈ s.toExchangeFrame.otherRing (row k) := by
  rw [exchangeCoordinate, Finset.sum_mul]
  apply Subring.sum_mem
  intro l _
  rw [mul_assoc, ← s.toExchangeFrame.monomial_single, s.toExchangeFrame.monomial_mul_monomial]
  apply Subring.mul_mem
  · exact s.toExchangeFrame.algebraMap_mem_otherRing _ _
  · apply Subring.mul_mem
    · exact s.toExchangeFrame.algebraMap_mem_otherRing _ _
    · exact s.toExchangeFrame.monomial_mem_otherRing (by
        simp [s.exchangeExponent_row])

/-- Polynomial exchange constructs all hypotheses of the seed-free one-exchange theorem. -/
theorem exchangeData (k : K) :
    SkewExchange.ExchangeData (s.toExchangeFrame.otherRing (row k)) (s.coordinate (row k) : D)
      (s.exchangeCoordinate k * s.coordinate (row k)) where
  x_normalizes := s.toExchangeFrame.coordinate_normalizes (row k)
  x_leftFree := s.toExchangeFrame.leftFree_coordinate (row k)
  E_mem := s.exchangeCoordinate_mul_coordinate_mem k
  E_normalizes := (s.exchangeCoordinate_normalizes k).mul
    (s.toExchangeFrame.coordinate_normalizes (row k))

theorem exchangeCoordinate_leftFree (k : K) :
    SkewExchange.LeftFree (s.toExchangeFrame.otherRing (row k)) (s.exchangeCoordinate k) := by
  simpa only [mul_inv_cancel_right₀ (Units.ne_zero (s.coordinate (row k)))] using
    (s.exchangeData k).y_leftFree

/-- Replace the selected coordinate by the nonzero polynomial exchange expression. -/
def mutateCoordinate (k : K) : M → Dˣ :=
  Function.update s.coordinate (row k)
    (Units.mk0 (s.exchangeCoordinate k) (s.exchangeCoordinate_ne_zero k))

theorem mutateCoordinate_row (k : K) :
    (s.mutateCoordinate k (row k) : D) = s.exchangeCoordinate k := by
  simp [mutateCoordinate]

theorem mutateCoordinate_of_ne (k : K) {j : M} (hj : j ≠ row k) :
    s.mutateCoordinate k j = s.coordinate j := Function.update_of_ne hj _ _

theorem mutateCoordinate_quasiCommuting (k : K) :
    IsQuasiCommuting u₀ (matrixForm (formMutation row s.exchange.matrix s.form k 1))
      (s.mutateCoordinate k) := by
  have hrow : ∀ {j}, j ≠ row k → formMutation row s.exchange.matrix s.form k 1 (row k) j =
      matrixForm s.form (exchangeExponentPos row s.exchange.matrix k) (Pi.single j 1) :=
    fun hj ↦ s.compatible.formMutation_apply_row_left_pos (Or.inl rfl) hj
  intro i j
  rw [matrixForm_single_single, Algebra.smul_def]
  by_cases hi : i = row k <;> by_cases hj : j = row k
  · subst hi
    rw [hj, formMutation_apply_row_row k s.alternating]
    simp
  · subst hi
    rw [hrow hj, mutateCoordinate_row, mutateCoordinate_of_ne _ _ hj]
    exact s.exchangeCoordinate_mul_coordinate k hj
  · subst j
    rw [(s.alternating.formMutation k 1) i (row k), hrow hi, mutateCoordinate_row,
      mutateCoordinate_of_ne _ _ hi, s.coordinate_mul_exchangeCoordinate k hi,
      s.alternating.matrixForm_swap (Pi.single i 1)]
  · rw [formMutation_apply_of_ne row _ _ k 1 hi hj, mutateCoordinate_of_ne _ _ hi,
      mutateCoordinate_of_ne _ _ hj, s.quasiCommuting i j, matrixForm_single_single,
      Algebra.smul_def]

/-- The constructed chart for the mutated alternating form. -/
def mutateChart (k : K) :
    quantumTorus R₀ u₀ (matrixForm (formMutation row s.exchange.matrix s.form k 1)) →ₐ[R₀] D :=
  QuantumTorus.lift (s.alternating.formMutation k 1).isAlt (s.mutateCoordinate k)
    (s.mutateCoordinate_quasiCommuting k)

theorem mutateChart_monomial_of_apply_eq_zero (k : K) {a : M → ℤ}
    (ha : a (row k) = 0) :
    s.mutateChart k (QuantumTorus.monomial a) = s.toExchangeFrame.monomial a := by
  refine (lift_monomial_congr s.toExchangeFrame.isAlt _ s.quasiCommuting _
    (fun i hi ↦ ?_) (fun p q hp hq ↦ ?_)).symm
  · refine (s.mutateCoordinate_of_ne k ?_).symm
    rintro rfl
    exact hi ha
  · exact (formMutation_matrixForm_of_apply_eq_zero _ _ (hp _ ha) (hq _ ha)).symm

/-- Faithfulness is deduced from the constructed one-exchange data, for arbitrary degree. -/
theorem mutateChart_injective (k : K) : Function.Injective (s.mutateChart k) := by
  apply algHom_injective_of_coordinate_free (s.alternating.formMutation k 1).isAlt
    s.toExchangeFrame.chart (s.mutateChart k) s.toExchangeFrame.chart_injective
    (row k) (s.toExchangeFrame.otherRing (row k))
    (s.toExchangeFrame.algebraMap_mem_otherRing _) (fun _ ha ↦
      s.toExchangeFrame.monomial_mem_otherRing ha)
    (fun _ ha ↦ s.mutateChart_monomial_of_apply_eq_zero k ha)
  simpa only [mutateChart, lift_monomial_single, mutateCoordinate_row] using
    s.exchangeCoordinate_leftFree k

variable [Fintype K] [DecidableEq K]

/-- Reverse the coefficient list in the mutated direction. The reciprocal case
is exactly the case in which this update fixes the exchange polynomials. -/
def mutatePolynomial (k : K) : K → Polynomial R₀ :=
  Function.update s.polynomial k (s.polynomial k).reverse

omit [Fintype K] in
theorem mutatePolynomial_degree (k j : K) :
    (s.mutatePolynomial k j).natDegree = (s.polynomial j).natDegree := by
  by_cases hj : j = k
  · subst j
    simp only [mutatePolynomial, Function.update_self, s.polynomial_reverse_natDegree]
  · rw [mutatePolynomial, Function.update_of_ne hj]

omit [Fintype K] in
theorem degree_dvd_mutation (k : K) (a : M) (j : K) :
    (s.degree j : ℤ) ∣ extendedMatrixMutation row s.exchange.matrix k a j := by
  have hmax {r b : ℤ} (h : r ∣ b) : r ∣ positivePart b := by
    by_cases hb : 0 ≤ b
    · simpa [positivePart, max_eq_left hb] using h
    · simp [positivePart, max_eq_right (le_of_not_ge hb)]
  simp only [extendedMatrixMutation]
  split_ifs
  · exact dvd_neg.mpr (s.degree_dvd a j)
  · exact dvd_sub (dvd_add (s.degree_dvd a j)
      (dvd_mul_of_dvd_right (hmax (s.degree_dvd (row k) j)) _))
      (dvd_mul_of_dvd_right (hmax (dvd_neg.mpr (s.degree_dvd (row k) j))) _)

/-- Polynomial mutation uses the existing compatible-pair mutation and the proved new chart. -/
def mutate (k : K) : PolynomialExchangeSeed (u₀ := u₀) D row where
  toExchangeFrame := {
    exchange := s.exchange.mutate k
    form := formMutation row s.exchange.matrix s.form k 1
    alternating := s.alternating.formMutation k 1
    formWeight := s.formWeight
    compatible := s.compatible.mutation s.alternating (Or.inl rfl)
    independentColumns := by
      change LinearIndependent ℚ
        (fun j ↦ fun a ↦ ((extendedMatrixMutation row s.exchange.matrix k) a j : ℚ))
      apply (linearIndependent_columns_iff_rank
        ((extendedMatrixMutation row s.exchange.matrix k).map (Int.castRingHom ℚ))).2
      exact (extendedMatrixMutation_rank_map row s.exchange.matrix k (s.exchange.diagonal k)
        ℚ (Int.castRingHom ℚ)).trans
        ((linearIndependent_columns_iff_rank
          (s.exchange.matrix.map (Int.castRingHom ℚ))).1 s.independentColumns)
    coordinate := s.mutateCoordinate k
    quasiCommuting := s.mutateCoordinate_quasiCommuting k
    faithful := s.mutateChart_injective k }
  polynomial := s.mutatePolynomial k
  constant_one j := by
    by_cases hj : j = k
    · subst j
      simp only [mutatePolynomial, Function.update_self, Polynomial.coeff_zero_reverse]
      exact s.monic k
    · rw [mutatePolynomial, Function.update_of_ne hj]
      exact s.constant_one j
  monic j := by
    by_cases hj : j = k
    · subst j
      simp only [mutatePolynomial, Function.update_self]
      exact s.polynomial_reverse_monic k
    · rw [mutatePolynomial, Function.update_of_ne hj]
      exact s.monic j
  degree_pos j := by rw [s.mutatePolynomial_degree]; exact s.degree_pos j
  degree_dvd a j := by rw [s.mutatePolynomial_degree]; exact s.degree_dvd_mutation k a j

end
end TauCeti.Cluster.PolynomialExchangeSeed
