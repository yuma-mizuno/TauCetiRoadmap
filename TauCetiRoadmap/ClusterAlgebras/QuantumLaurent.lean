/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.QuantumCommuting
public import TauCetiRoadmap.ClusterAlgebras.PolynomialQuantumLaurent
public import TauCetiRoadmap.ClusterAlgebras.QuantumPolynomial
public import TauCetiRoadmap.ClusterAlgebras.QuantumReplacement
public import TauCetiRoadmap.LaurentPhenomenon.SkewReplacement

/-!
# Quantum upper bounds and the quantum Laurent phenomenon (Q3)

For distinct mutable directions the two-direction comparison (Q2, in its commuting and
interacting cases) and the replacement theorem give the three-chart equality. Hence the
finite upper bound `T_s ∩ ⋂_k T_{μ_k s}` is invariant under mutation, every reachable quantum
cluster variable lies in every integral quantum chart, and the upper cluster algebra equals the
finite upper bound. Everything is proved from the compatible seed data alone.
-/

@[expose] public section

namespace TauCeti.Cluster.ExchangeFrame

open TauCeti TauCeti.Laurent

variable {D : Type*} [DivisionRing D] [Algebra Zv D]
  {M K : Type*} [Fintype M] [DecidableEq M] [Fintype K] [DecidableEq K]
  {row : K ↪ M} (s : ExchangeFrame (u₀ := vUnit) D row)

/-- **Q2.** The two adjacent one-exchange intersections meet in `C⟨X_i, X'_i, X_j, X'_j⟩`. -/
theorem inf_inf_eq_fourRing {i j : K} (hij : i ≠ j) :
    (s.chartRing ⊓ (s.mutate i).chartRing) ⊓ (s.chartRing ⊓ (s.mutate j).chartRing) =
      s.fourRing i j := by
  have h := s.polynomialSeed.inf_inf_eq_fourRing hij
  simpa only [polynomialSeed_mutate, polynomialSeed_toExchangeFrame,
    polynomialSeed_fourRing] using h

/-- The three-chart equality behind upper-bound invariance. -/
theorem three_chart (i j : K) (hji : j ≠ i) :
    s.chartRing ⊓ (s.mutate i).chartRing ⊓ (s.mutate j).chartRing =
      (s.mutate i).chartRing ⊓ s.chartRing ⊓ ((s.mutate i).mutate j).chartRing := by
  have h := s.polynomialSeed.three_chart i j hji
  simpa only [polynomialSeed_mutate, polynomialSeed_toExchangeFrame] using h

/-- The finite upper bound agrees with the degree-one polynomial upper bound. -/
theorem polynomialSeed_upperBound : s.polynomialSeed.upperBound = s.upperBound := by
  simp only [PolynomialExchangeSeed.upperBound, upperBound, TauCeti.Cluster.upperBound,
    polynomialSeed_mutate]
  rfl

/-- **Q3.** The finite quantum upper bound is the same at every seed reached from `s`. -/
theorem upperBound_eq_of_reachable {t : ExchangeFrame (u₀ := vUnit) D row}
    (ht : s.Reachable t) :
    t.upperBound = s.upperBound :=
  s.upperBound_eq_of_three_chart (fun u _ i j hji ↦ u.three_chart i j hji) ht

/-- **Q3.** The finite quantum upper bound is invariant under mutation. -/
theorem upperBound_mutate (k : K) : (s.mutate k).upperBound = s.upperBound := by
  have h := s.polynomialSeed.upperBound_mutate k
  simpa only [polynomialSeed_mutate, polynomialSeed_upperBound] using h

/-- **The quantum Laurent phenomenon.** Every quantum cluster variable reached from `s` by a
mutation word lies in the integral quantum torus of every seed reached from `s`. -/
theorem coordinate_mutateWord_mem_mutateWord_chartRing (u w : List K) (j : M) :
    ((mutateWord (fun k t ↦ ExchangeFrame.mutate t k) w s).coordinate j : D) ∈
      (mutateWord (fun k t ↦ ExchangeFrame.mutate t k) u s).chartRing := by
  have h := s.polynomialSeed.coordinate_mutateWord_mem_mutateWord_chartRing u w j
  simpa only [polynomialSeed_mutateWord, polynomialSeed_toExchangeFrame] using h

/-- **The quantum Laurent phenomenon.** Every quantum cluster variable reached from `s` by a
mutation word lies in the integral quantum torus `T_s` of `s`. -/
theorem coordinate_mutateWord_mem_chartRing (w : List K) (j : M) :
    ((mutateWord (fun k t ↦ ExchangeFrame.mutate t k) w s).coordinate j : D) ∈ s.chartRing :=
  s.coordinate_mutateWord_mem_mutateWord_chartRing [] w j

/-- The quantum upper cluster algebra `⋂_t T_t` equals the finite upper bound at `s`. -/
theorem upperClusterRing_eq_upperBound :
    TauCeti.Cluster.upperClusterRing (algebraMap Zv D).range
        (fun t : ExchangeFrame (u₀ := vUnit) D row ↦ fun i ↦ (t.coordinate i : D))
        (fun k t ↦ t.mutate k) s = s.upperBound :=
  s.upperClusterRing_eq_upperBound_of_upperBound_mutate fun t _ k ↦ t.upperBound_mutate k

/-- The quantum cluster algebra is contained in the quantum upper cluster algebra. -/
theorem clusterRing_le_upperClusterRing :
    TauCeti.Cluster.clusterRing (algebraMap Zv D).range
        (fun t : ExchangeFrame (u₀ := vUnit) D row ↦ fun i ↦ (t.coordinate i : D))
        (fun k t ↦ t.mutate k) s ≤
      TauCeti.Cluster.upperClusterRing (algebraMap Zv D).range
        (fun t : ExchangeFrame (u₀ := vUnit) D row ↦ fun i ↦ (t.coordinate i : D))
        (fun k t ↦ t.mutate k) s :=
  s.clusterRing_le_upperClusterRing_of_upperBound_mutate fun t _ k ↦ t.upperBound_mutate k

end TauCeti.Cluster.ExchangeFrame
