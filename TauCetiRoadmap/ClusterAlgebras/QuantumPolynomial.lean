/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.PolynomialQuantumPair

/-!
# Ordinary quantum mutation as degree-one polynomial mutation

The polynomial `1 + X` identifies the original seed construction with the
polynomial construction, including mutation along every finite word.
-/

@[expose] public section

namespace TauCeti.Cluster.QuantumSeed

open TauCeti TauCeti.QuantumTorus TauCeti.Laurent

noncomputable section

variable {D : Type*} [DivisionRing D] [Algebra Zv D]
  {M K : Type*} [Fintype M] [DecidableEq M] {row : K ↪ M}
  (s : QuantumSeed D row)

/-- The ordinary quantum seed with its degree-one exchange polynomials. -/
def polynomialSeed : PolynomialQuantumSeed D row where
  toQuantumSeed := s
  polynomial := fun _ ↦ Polynomial.X + 1
  constant_one := fun _ ↦ by simp
  monic := fun _ ↦ by simpa using Polynomial.monic_X_add_C (1 : Zv)
  degree_pos := fun _ ↦ by simp
  degree_dvd := fun _ _ ↦ by simp

@[simp] theorem polynomialSeed_toQuantumSeed : s.polynomialSeed.toQuantumSeed = s := rfl

@[simp] theorem polynomialSeed_degree (k : K) : s.polynomialSeed.degree k = 1 := by
  simp [polynomialSeed, PolynomialQuantumSeed.degree]

theorem polynomialSeed_exchangeCoordinate (k : K) :
    s.polynomialSeed.exchangeCoordinate k = s.exchangeCoordinate k := by
  rw [PolynomialQuantumSeed.exchangeCoordinate, polynomialSeed_degree]
  simp only [Finset.sum_range_succ, Finset.sum_range_zero, zero_add]
  have he : s.polynomialSeed.exchangeExponent k 1 =
      exchangeExponentPos row s.exchange.matrix k := by
    have he := s.polynomialSeed.exchangeExponent_degree k
    rw [polynomialSeed_degree] at he
    exact he
  rw [s.polynomialSeed.exchangeExponent_zero, he]
  simp [polynomialSeed, exchangeCoordinate, Polynomial.coeff_one, add_comm]

variable [Fintype K] [DecidableEq K]

/-- The two mutation constructions agree on the full seed data. -/
theorem polynomialSeed_mutate (k : K) :
    s.polynomialSeed.mutate k = (s.mutate k).polynomialSeed := by
  apply PolynomialQuantumSeed.ext
  · apply QuantumSeed.ext
      (s := (s.polynomialSeed.mutate k).toQuantumSeed)
      (t := (s.mutate k).polynomialSeed.toQuantumSeed) rfl rfl
    funext a
    by_cases ha : a = row k
    · subst a
      apply Units.ext
      rw [s.polynomialSeed.mutate_coordinate_row]
      change s.polynomialSeed.exchangeCoordinate k = (s.mutate k).coordinate (row k)
      rw [s.mutate_coordinate_row, polynomialSeed_exchangeCoordinate]
    · rw [s.polynomialSeed.mutate_coordinate_of_ne k ha]
      change s.coordinate a = (s.mutate k).coordinate a
      rw [s.mutate_coordinate_of_ne k ha]
  · funext j
    simp only [PolynomialQuantumSeed.mutate_polynomial, PolynomialQuantumSeed.mutatePolynomial]
    by_cases hj : j = k
    · subst j
      rw [Function.update_self]
      change (Polynomial.X + 1 : Polynomial Zv).reverse = Polynomial.X + 1
      change (Polynomial.X + Polynomial.C 1 : Polynomial Zv).reverse =
        Polynomial.X + Polynomial.C 1
      rw [Polynomial.reverse_add_C]
      simp [Polynomial.reverse, add_comm]
    · rw [Function.update_of_ne hj]
      rfl

omit [Fintype K] [DecidableEq K] in
theorem polynomialSeed_fourRing (i j : K) : s.polynomialSeed.fourRing i j = s.fourRing i j := by
  unfold PolynomialQuantumSeed.fourRing QuantumSeed.fourRing
  rw [polynomialSeed_exchangeCoordinate, polynomialSeed_exchangeCoordinate]
  rfl

/-- Mutation words agree, not only the one-step exchange expression. -/
theorem polynomialSeed_mutateWord (w : List K) :
    mutateWord (fun k t ↦ PolynomialQuantumSeed.mutate t k) w s.polynomialSeed =
      (mutateWord (fun k t ↦ QuantumSeed.mutate t k) w s).polynomialSeed := by
  induction w generalizing s with
  | nil => rfl
  | cons k w ih =>
    rw [mutateWord_cons, s.polynomialSeed_mutate]
    exact ih _

end
end TauCeti.Cluster.QuantumSeed
