/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.PolynomialQuantumCommuting

/-!
# Polynomial quantum upper bounds and the Laurent phenomenon

Both cases of Q2 are constructed from polynomial seed data. They imply the
three-chart identity, upper-bound invariance and Laurentness along arbitrary words.
Coefficient reversal, rather than reciprocal fixed coefficients, is the mutation law.
-/

@[expose] public section

namespace TauCeti.Cluster.PolynomialExchangeSeed

open TauCeti TauCeti.Laurent

noncomputable section

variable {R₀ : Type*} [CommRing R₀] {u₀ : R₀ˣ}
  {D : Type*} [DivisionRing D] [Algebra R₀ D]
  {M K : Type*} [Fintype M] [DecidableEq M] [Fintype K] [DecidableEq K]
  {row : K ↪ M} (s : PolynomialExchangeSeed (u₀ := u₀) D row)

/-- The two adjacent one-exchange intersections meet in the four-coordinate ring. -/
theorem inf_inf_eq_fourRing [IsDomain R₀] [UniqueFactorizationMonoid R₀]
    {i j : K} (hij : i ≠ j) :
    (s.toExchangeFrame.chartRing ⊓ (s.mutate i).toExchangeFrame.chartRing) ⊓
        (s.toExchangeFrame.chartRing ⊓ (s.mutate j).toExchangeFrame.chartRing) =
      s.fourRing i j := by
  by_cases hb : s.exchange.matrix (row j) i = 0
  · exact s.inf_mutate_inf_inf_mutate_eq_fourRing_of_eq_zero hij hb
  · exact s.inf_mutate_inf_inf_mutate_eq_fourRing hij hb

/-- The local three-chart equality, in every polynomial degree. -/
theorem three_chart [IsDomain R₀] [UniqueFactorizationMonoid R₀]
    (i j : K) (hji : j ≠ i) :
    s.toExchangeFrame.chartRing ⊓ (s.mutate i).toExchangeFrame.chartRing ⊓
        (s.mutate j).toExchangeFrame.chartRing =
      (s.mutate i).toExchangeFrame.chartRing ⊓ s.toExchangeFrame.chartRing ⊓
        ((s.mutate i).mutate j).toExchangeFrame.chartRing := by
  have hij : i ≠ j := hji.symm
  have h' := (s.mutate i).inf_inf_eq_fourRing hij
  rw [s.mutate_mutate i, s.fourRing_mutate hij] at h'
  exact inf_inf_eq_of_inf_eq rfl rfl (s.inf_inf_eq_fourRing hij) rfl rfl h' rfl

/-- The initial chart and its one-step polynomial neighbours. -/
def upperBound : Subring D :=
  TauCeti.Cluster.upperBound (algebraMap R₀ D).range
    (fun t : PolynomialExchangeSeed (u₀ := u₀) D row ↦ fun a ↦ (t.coordinate a : D))
    (fun k t ↦ t.mutate k) s

/-- Q3: the upper bound is invariant under polynomial quantum mutation. -/
theorem upperBound_mutate [IsDomain R₀] [UniqueFactorizationMonoid R₀]
    (k : K) : (s.mutate k).upperBound = s.upperBound :=
  upperBound_mutation_of_three_chart (algebraMap R₀ D).range
    (fun t : PolynomialExchangeSeed (u₀ := u₀) D row ↦ fun a ↦ (t.coordinate a : D))
    (fun k t ↦ t.mutate k) (fun k ↦ mutate_involutive k)
    (fun t i j hji ↦ t.three_chart i j hji) s k

theorem coordinate_mutate_mem_chartRing (k : K) (a : M) :
    ((s.mutate k).coordinate a : D) ∈ s.toExchangeFrame.chartRing := by
  by_cases ha : a = row k
  · subst a
    rw [s.mutate_coordinate_row]
    exact s.exchangeCoordinate_mem_chartRing k
  · rw [s.mutate_coordinate_of_ne k ha]
    exact coordinate_mem_chartRing _ _ a

/-- Every reachable polynomial quantum coordinate lies in every reachable integral chart. -/
theorem coordinate_mutateWord_mem_mutateWord_chartRing
    [IsDomain R₀] [UniqueFactorizationMonoid R₀] (u w : List K) (a : M) :
    ((mutateWord (fun k t ↦ PolynomialExchangeSeed.mutate t k) w s).coordinate a : D) ∈
      (mutateWord (fun k t ↦ PolynomialExchangeSeed.mutate t k) u s).toExchangeFrame.chartRing :=
  generator_mem_of_patternUpperBound
    (fun t : PolynomialExchangeSeed (u₀ := u₀) D row ↦ t.toExchangeFrame.chartRing)
    (fun k t ↦ t.mutate k) (fun t a ↦ (t.coordinate a : D))
    (fun k ↦ mutate_involutive k) s
    (fun _ a ↦ coordinate_mem_chartRing _ _ a)
    (fun _ k a ↦ coordinate_mutate_mem_chartRing _ k a)
    (fun _ k ↦ upperBound_mutate _ k) u w a

/-- Polynomial quantum Laurentness in the initial integral chart. -/
theorem coordinate_mutateWord_mem_chartRing [IsDomain R₀] [UniqueFactorizationMonoid R₀]
    (w : List K) (a : M) :
    ((mutateWord (fun k t ↦ PolynomialExchangeSeed.mutate t k) w s).coordinate a : D) ∈
      s.toExchangeFrame.chartRing :=
  s.coordinate_mutateWord_mem_mutateWord_chartRing [] w a

/-- The infinite upper cluster ring equals the finite upper bound. -/
theorem upperClusterRing_eq_upperBound [IsDomain R₀] [UniqueFactorizationMonoid R₀] :
    TauCeti.Cluster.upperClusterRing (algebraMap R₀ D).range
        (fun t : PolynomialExchangeSeed (u₀ := u₀) D row ↦ fun a ↦ (t.coordinate a : D))
        (fun k t ↦ t.mutate k) s = s.upperBound :=
  TauCeti.Cluster.upperClusterRing_eq_upperBound (algebraMap R₀ D).range
    (fun t : PolynomialExchangeSeed (u₀ := u₀) D row ↦ fun a ↦ (t.coordinate a : D))
    (fun k t ↦ t.mutate k) (fun t k ↦ t.upperBound_mutate k) s

/-- The polynomial quantum cluster ring is contained in its upper cluster ring. -/
theorem clusterRing_le_upperClusterRing [IsDomain R₀] [UniqueFactorizationMonoid R₀] :
    TauCeti.Cluster.clusterRing (algebraMap R₀ D).range
        (fun t : PolynomialExchangeSeed (u₀ := u₀) D row ↦ fun a ↦ (t.coordinate a : D))
        (fun k t ↦ t.mutate k) s ≤
      TauCeti.Cluster.upperClusterRing (algebraMap R₀ D).range
        (fun t : PolynomialExchangeSeed (u₀ := u₀) D row ↦ fun a ↦ (t.coordinate a : D))
        (fun k t ↦ t.mutate k) s :=
  TauCeti.Cluster.clusterRing_le_upperClusterRing (algebraMap R₀ D).range
    (fun t : PolynomialExchangeSeed (u₀ := u₀) D row ↦ fun a ↦ (t.coordinate a : D))
    (fun k t ↦ t.mutate k) (fun k ↦ mutate_involutive k)
    (fun t k a ↦ t.coordinate_mutate_mem_chartRing k a)
    (fun t k ↦ t.upperBound_mutate k) s

end
end TauCeti.Cluster.PolynomialExchangeSeed
