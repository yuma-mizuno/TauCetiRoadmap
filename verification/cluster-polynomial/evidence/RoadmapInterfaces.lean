/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module
public import TauCetiRoadmap.ClusterAlgebras.PolynomialQuantumLaurent
public import TauCetiRoadmap.ClusterAlgebras.QuantumSeed
public import TauCetiRoadmap.ClusterAlgebras.ClassicalFrame
public import TauCetiRoadmap.ClusterAlgebras.Examples.ScalarSpecializationChecks

/-!
# Exchange-frame contracts used by the roadmap

These checks verify the local scalar-ring hypotheses, the common all-word
statement, and the direct zero-phase cubic with symmetrizer one. The latter
has no integral positive compatible form. This file is verification evidence;
it is not imported by either public library root.
-/

@[expose] public section
namespace TauCeti.Cluster.RoadmapChecks
open TauCeti TauCeti.Cluster TauCeti.Laurent

section Local
variable {R D I K : Type*} [CommRing R] {u : Rˣ}
  [DivisionRing D] [Algebra R D] [Fintype I] [DecidableEq I]
  {row : K ↪ I} (s : PolynomialExchangeSeed (u₀ := u) D row)

example (k : K) : (s.degree k : ℤ) ∣ s.formWeight k :=
  s.degree_dvd_formWeight k

example (k : K) (n : ℕ) :
    s.exchangeCoordinate k ^ n = s.centralProduct k n *
      s.toExchangeFrame.monomial (exchangeExponentNeg row s.exchange.matrix k) ^ n :=
  s.exchangeCoordinate_pow k n

variable [Fintype K] [DecidableEq K]
example (k : K) : (s.mutate k).mutate k = s := s.mutate_mutate k

example [IsDomain R] [UniqueFactorizationMonoid R] (p w : List K) (a : I) :
    ((mutateWord (fun k t ↦ PolynomialExchangeSeed.mutate t k) w s).coordinate a : D) ∈
      (mutateWord (fun k t ↦ PolynomialExchangeSeed.mutate t k) p s).toExchangeFrame.chartRing :=
  s.coordinate_mutateWord_mem_mutateWord_chartRing p w a
end Local

section OrdinaryQuantum
variable {D I K : Type*} [DivisionRing D] [Algebra Zv D]
  [Fintype I] [DecidableEq I] {row : K ↪ I}
example (E : ExtendedExchangeMatrix row) (Λ : Matrix I I ℤ)
    (hc : IsCompatiblePair E Λ) :
    LinearIndependent ℚ (fun k a ↦ (E.matrix a k : ℚ)) := hc.independent_columns
end OrdinaryQuantum

section WordTransport
variable {K V W : Type*} (μ : K → V → V) (ν : K → W → W) (f : V → W)
example (hf : ∀ k s, f (μ k s) = ν k (f s)) (w : List K) (s : V) :
    f (mutateWord μ w s) = mutateWord ν w (f s) :=
  mutateWord_map μ ν f hf w s
end WordTransport
section ZeroPhaseCubic
open TauCeti.Examples.ScalarSpecializationChecks
open TauCeti.Examples.PolynomialSeedChecks
noncomputable section

/-- The cubic exchange matrix with its original unit symmetrizer. -/
def unitSymmetrizerExchange : ExtendedExchangeMatrix (Function.Embedding.refl (Fin 2)) where
  matrix := cubicExchange.matrix
  symmetrizer := fun _ ↦ 1
  symmetrizer_pos := fun _ ↦ by norm_num
  symmetrized := by intro i j; fin_cases i <;> fin_cases j <;> norm_num [cubicExchange]

/-- A zero-phase classical cubic requiring no positive quantum compatible form. -/
def unitSymmetrizerCubic : PolynomialExchangeSeed (u₀ := (1 : ℤˣ)) ClassicalField
    (Function.Embedding.refl (Fin 2)) where
  toExchangeFrame := commutativeFrame unitSymmetrizerExchange
    (by
      apply Matrix.linearIndependent_cols_of_det_ne_zero
        (A := unitSymmetrizerExchange.matrix.map (Int.castRingHom ℚ))
      norm_num [unitSymmetrizerExchange, cubicExchange, Matrix.det_fin_two])
    (Int.castRingHom ℚ) Int.cast_injective (fun _ ↦ by simp)
    coordinates (algebraicIndependent_rationalLaurentCoordinates (Fin 2))
  polynomial := fun _ ↦ exchangePolynomial
  constant_one := fun _ ↦ by simp [exchangePolynomial]
  monic := fun _ ↦ exchangePolynomial_monic
  degree_pos := fun _ ↦ by rw [exchangePolynomial_degree]; norm_num
  degree_dvd := by
    intro i k
    rw [exchangePolynomial_degree]
    change (3 : ℤ) ∣ unitSymmetrizerExchange.matrix i k
    fin_cases i <;> fin_cases k <;> norm_num [unitSymmetrizerExchange, cubicExchange]

/-- The common polynomial proof applies without a degree-divides-symmetrizer assumption. -/
theorem unitSymmetrizerCubic_laurent (p w : List (Fin 2)) (a : Fin 2) :
    ((mutateWord (fun k t ↦ PolynomialExchangeSeed.mutate t k) w
      unitSymmetrizerCubic).coordinate a : ClassicalField) ∈
      (mutateWord (fun k t ↦ PolynomialExchangeSeed.mutate t k) p
        unitSymmetrizerCubic).toExchangeFrame.chartRing :=
  unitSymmetrizerCubic.coordinate_mutateWord_mem_mutateWord_chartRing p w a

example : unitSymmetrizerCubic.form = 0 := rfl
example : unitSymmetrizerCubic.formWeight = fun _ ↦ 0 := rfl
/-- Exchange degrees need not divide the positive matrix symmetrizer at zero phase. -/
theorem unitSymmetrizerCubic_degree_not_dvd : ¬(unitSymmetrizerCubic.degree 0 : ℤ) ∣
    unitSymmetrizerCubic.exchange.symmetrizer 0 := by
  change ¬(exchangePolynomial.natDegree : ℤ) ∣ 1
  rw [exchangePolynomial_degree]
  norm_num

/-- The unit symmetrizer cannot be the diagonal of any integral compatible form here. -/
theorem unitSymmetrizerExchange_not_compatible (Λ : Matrix (Fin 2) (Fin 2) ℤ) :
    ¬IsCompatiblePair unitSymmetrizerExchange Λ := by
  intro hc
  have h := hc 0 0
  norm_num [unitSymmetrizerExchange, cubicExchange, Fin.sum_univ_two] at h
  omega

open Lean Lean.Elab.Command in
run_cmd do
  for root in #[``unitSymmetrizerCubic_laurent, ``unitSymmetrizerCubic_degree_not_dvd,
      ``unitSymmetrizerExchange_not_compatible] do
    let axioms ← liftCoreM (Lean.collectAxioms root)
    for ax in axioms do
      unless ax == ``propext || ax == ``Classical.choice || ax == ``Quot.sound do
        throwError "Nonstandard axiom in {root}: {ax}"
  logInfo "All three zero-phase cubic contracts use only standard axioms."
end
end ZeroPhaseCubic
end TauCeti.Cluster.RoadmapChecks
