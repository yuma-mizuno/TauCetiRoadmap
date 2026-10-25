/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.PolynomialQuantumOpposite

/-!
# Replacement in all polynomial quantum directions

Positive and negative interactions use one finite replacement proof, through
the opposite comparison. Zero interaction fixes the second exchange. Applying
replacement on both sides gives the four-generator equality.
-/

@[expose] public section

namespace TauCeti.Cluster.PolynomialExchangeSeed

open TauCeti TauCeti.QuantumTorus TauCeti.Laurent

variable {R₀ : Type*} [CommRing R₀] {u₀ : R₀ˣ}
  {D : Type*} [DivisionRing D] [Algebra R₀ D]
  {M K : Type*} [Fintype M] [DecidableEq M] [Fintype K] [DecidableEq K]
  {row : K ↪ M} (s : PolynomialExchangeSeed (u₀ := u₀) D row)

noncomputable section

theorem mutate_exchangeCoordinate_of_eq_zero {i j : K} (hij : i ≠ j)
    (hzero : s.exchange.matrix (row i) j = 0) :
    (s.mutate i).exchangeCoordinate j = s.exchangeCoordinate j := by
  have hcol : ∀ a, (s.mutate i).exchange.matrix a j = s.exchange.matrix a j := by
    intro a
    rw [mutate_exchange_matrix]
    by_cases ha : a = row i
    · subst a
      simp [extendedMatrixMutation, hzero]
    · simp [extendedMatrixMutation, ha, hij.symm, hzero, positivePart]
  have hβ : (s.mutate i).dividedColumn j = s.dividedColumn j := by
    funext a
    simp only [dividedColumn, s.mutate_degree, hcol]
  have he (l : ℕ) : (s.mutate i).exchangeExponent j l = s.exchangeExponent j l := by
    simp only [exchangeExponent, hβ, exchangeExponentNeg]
    congr 1
    funext a
    simp only [Pi.add_apply, Pi.neg_apply]
    rw [hcol]
  rw [exchangeCoordinate, s.mutate_degree, exchangeCoordinate]
  apply Finset.sum_congr rfl
  intro l _
  rw [s.mutate_polynomial_of_ne hij.symm, he l, s.mutate_monomial,
    s.mutateChart_monomial_of_apply_eq_zero i]
  simp [exchangeExponent, exchangeExponentNeg, row.injective.ne hij, hzero,
    dividedColumn, positivePart]

theorem pairRing_mutate (i : K) (b : M) :
    (s.mutate i).toExchangeFrame.pairRing (row i) b = s.toExchangeFrame.pairRing (row i) b := by
  simp only [ExchangeFrame.pairRing]
  congr 1
  funext a
  rw [s.mutate_coordinate_of_ne i a.2.1]

/-- The polynomial exchange pair ring in two directions. -/
def fourRing (i j : K) : Subring D :=
  TauCeti.Laurent.fourRing (s.toExchangeFrame.pairRing (row i) (row j)) (s.coordinate (row i) : D)
    (s.exchangeCoordinate i) (s.coordinate (row j) : D) (s.exchangeCoordinate j)

/-- Full polynomial quantum replacement, constructed from the seed alone. -/
theorem replacement_mem {i j : K} (hij : i ≠ j) :
    (s.mutate i).exchangeCoordinate j ∈ TauCeti.Laurent.generated
      (s.toExchangeFrame.pairRing (row i) (row j))
      {s.exchangeCoordinate i, s.exchangeCoordinate j, (s.coordinate (row j) : D)} := by
  rcases lt_trichotomy (s.exchange.matrix (row i) j) 0 with h | h | h
  · exact s.replacement_mem_neg hij h
  · rw [s.mutate_exchangeCoordinate_of_eq_zero hij h]
    exact TauCeti.Laurent.generator_mem_generated _ _ (by simp)
  · exact s.replacement_mem_pos hij h

/-- The four-generator ring is unchanged by mutation, for arbitrary exchange degrees. -/
theorem fourRing_mutate {i j : K} (hij : i ≠ j) :
    (s.mutate i).fourRing i j = s.fourRing i j := by
  have hqj : row j ≠ row i := row.injective.ne hij.symm
  have h1 := s.replacement_mem hij
  have h2 := (s.mutate i).replacement_mem hij
  rw [mutate_mutate, pairRing_mutate, mutate_exchangeCoordinate,
    mutate_coordinate_of_ne _ i hqj] at h2
  simp only [fourRing]
  rw [pairRing_mutate, mutate_coordinate_row, mutate_exchangeCoordinate,
    mutate_coordinate_of_ne _ i hqj]
  refine TauCeti.Laurent.generated_eq_of_mem _ (fun a ha ↦ ?_) (fun a ha ↦ ?_)
  · rcases ha with rfl | rfl | rfl | rfl
    · exact TauCeti.Laurent.generator_mem_generated _ _ (by simp)
    · exact TauCeti.Laurent.generator_mem_generated _ _ (by simp)
    · exact TauCeti.Laurent.generator_mem_generated _ _ (by simp)
    · exact TauCeti.Laurent.generated_mono _ (by rintro z (rfl | rfl | rfl) <;> simp) h1
  · rcases ha with rfl | rfl | rfl | rfl
    · exact TauCeti.Laurent.generator_mem_generated _ _ (by simp)
    · exact TauCeti.Laurent.generator_mem_generated _ _ (by simp)
    · exact TauCeti.Laurent.generator_mem_generated _ _ (by simp)
    · exact TauCeti.Laurent.generated_mono _ (by rintro z (rfl | rfl | rfl) <;> simp) h2

end
end TauCeti.Cluster.PolynomialExchangeSeed
