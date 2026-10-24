/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.Examples.PolynomialQuantum
public import TauCetiRoadmap.ClusterAlgebras.PolynomialQuantumAlgebra
public import Mathlib.Tactic.ComputeDegree

/-!
# Nonreciprocal polynomial quantum seed checks

A faithful rank-two seed with cubic exchange polynomial `1 + 2T + T³`.
Its coefficient reversal is essential; all-word Laurentness and classical
specialization are instances of the public general theorems.
-/

@[expose] public section

namespace TauCeti.Examples.PolynomialSeedChecks

open TauCeti TauCeti.QuantumTorus TauCeti.Laurent TauCeti.Cluster Matrix
open TauCeti.Cluster.QuantumChecks TauCeti.Examples.PolynomialQuantum

noncomputable section

/-- The cubic rank-two exchange matrix with symmetrizer three. -/
def cubicExchange : ExtendedExchangeMatrix (Function.Embedding.refl (Fin 2)) where
  matrix := !![0, 3; -3, 0]
  symmetrizer := fun _ ↦ 3
  symmetrizer_pos := fun _ ↦ by norm_num
  symmetrized := by intro i j; fin_cases i <;> fin_cases j <;> norm_num

theorem cubicCompatible : IsCompatiblePair cubicExchange omega := by
  intro k l
  fin_cases k <;> fin_cases l <;> norm_num [cubicExchange, omega, Fin.sum_univ_two]

/-- A monic normalized polynomial with unequal coefficients at degrees one and two. -/
def cubicPolynomial : Polynomial Zv := Polynomial.X ^ 3 + 2 * Polynomial.X + 1

theorem cubicPolynomial_degree : cubicPolynomial.natDegree = 3 := by
  unfold cubicPolynomial
  compute_degree!

theorem cubicPolynomial_monic : cubicPolynomial.Monic := by
  unfold cubicPolynomial
  monicity!

/-- The actual nonreciprocal seed in the faithful generic quantum torus's skew field. -/
def cubicSeed : PolynomialQuantumSeed D (Function.Embedding.refl (Fin 2)) where
  toQuantumSeed := integralSeed omega_alt cubicExchange cubicCompatible
  polynomial := fun _ ↦ cubicPolynomial
  constant_one := fun _ ↦ by simp [cubicPolynomial]
  monic := fun _ ↦ cubicPolynomial_monic
  degree_pos := fun _ ↦ by rw [cubicPolynomial_degree]; norm_num
  degree_dvd := by
    intro i k
    rw [cubicPolynomial_degree]
    fin_cases i <;> fin_cases k <;> norm_num [cubicExchange, integralSeed]

theorem cubicPolynomial_not_reciprocal : cubicPolynomial.reverse ≠ cubicPolynomial := by
  intro h
  have hc := congrArg (fun p : Polynomial Zv ↦ p.coeff 1) h
  rw [Polynomial.coeff_reverse, cubicPolynomial_degree] at hc
  rw [Polynomial.revAt_le (by decide : 1 ≤ 3)] at hc
  norm_num [cubicPolynomial, Polynomial.coeff_one, Polynomial.coeff_X] at hc
  have hz := congrArg evalOne hc
  rw [map_zero, show (2 : Zv) = 1 + 1 from one_add_one_eq_two.symm,
    map_add, map_one] at hz
  norm_num at hz

/-- The chosen coefficient list reverses on mutation. -/
theorem cubicSeed_mutate_polynomial :
    ((cubicSeed.mutate 0).polynomial 0).coeff 1 = 0 ∧
      (cubicSeed.polynomial 0).coeff 1 = 2 := by
  change cubicPolynomial.reverse.coeff 1 = 0 ∧ cubicPolynomial.coeff 1 = 2
  rw [Polynomial.coeff_reverse, cubicPolynomial_degree]
  rw [Polynomial.revAt_le (by decide : 1 ≤ 3)]
  norm_num [cubicPolynomial, Polynomial.coeff_one, Polynomial.coeff_X]

/-- Reversal restores the whole original seed after the second mutation. -/
theorem cubicSeed_mutate_mutate : (cubicSeed.mutate 0).mutate 0 = cubicSeed :=
  cubicSeed.mutate_mutate 0

/-- Every mutation word of the nonreciprocal seed is Laurent in every reachable chart. -/
theorem cubicSeed_laurent (u w : List (Fin 2)) (a : Fin 2) :
    ((mutateWord (fun k t ↦ PolynomialQuantumSeed.mutate t k) w cubicSeed).coordinate a : D) ∈
      (mutateWord (fun k t ↦ PolynomialQuantumSeed.mutate t k) u
        cubicSeed).toQuantumSeed.chartRing :=
  cubicSeed.coordinate_mutateWord_mem_mutateWord_chartRing u w a

/-- The independent classical cubic pattern is the wordwise specialization of this seed. -/
theorem cubicSeed_classical_word {F : Type*} [Field F] [Algebra ℚ F]
    (ε : AddMonoidAlgebra ℤ (Fin 2 → ℤ) →+* F) {x : Fin 2 → F}
    (hε : ∀ a, ε (AddMonoidAlgebra.single (Pi.single a 1) 1) = x a)
    (hx : AlgebraicIndependent ℚ x) (w : List (Fin 2)) (a : Fin 2) :
    ChartSpecializes cubicSeed.toQuantumSeed.chart ε
      ((mutateWord (fun k t ↦ PolynomialQuantumSeed.mutate t k) w cubicSeed).coordinate a : D)
      ((polynomialGeometricPattern (Function.Embedding.refl (Fin 2)) cubicSeed.degree
        (cubicSeed.classicalData x) w).coordinate a) :=
  cubicSeed.mutateWord_chartSpecializes_of_independent ε hε hx w a

end
end TauCeti.Examples.PolynomialSeedChecks
