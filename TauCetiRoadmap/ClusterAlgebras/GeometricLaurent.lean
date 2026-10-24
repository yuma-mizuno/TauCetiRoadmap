/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.GeometricInteracting
public import TauCetiRoadmap.ClusterAlgebras.GeometricCommuting
public import TauCetiRoadmap.ClusterAlgebras.GeometricLaurentBase

/-! Laurentness for full-column-rank geometric seeds by mutation invariance
of the finite upper bound. The two local comparisons are proved from the seed
data, not included as fields or additional hypotheses. -/

@[expose] public section

noncomputable section
namespace TauCeti.Cluster
open TauCeti.Laurent
open UpperBound
variable {M K F : Type*} [Fintype M] [Fintype K]
  [DecidableEq M] [DecidableEq K] [Field F] [Algebra ℚ F]
  {row : K ↪ M} {d : K → ℤ}

theorem integerRing_le_rational : ∀ a ∈ geometricIntegerRing F,
    a ∈ (algebraMap ℚ F).range := by
  rintro a ⟨n, rfl⟩
  exact ⟨(n : ℚ), by simp⟩

namespace FullRankGeometricSeed

theorem three_chart (hd : ∀ i, 0 < d i)
    (s : FullRankGeometricSeed (F := F) row d) (i j : K) (hij : i ≠ j) :
    chartRing (geometricIntegerRing F) s.1.coordinate ⊓
        chartRing (geometricIntegerRing F) (s.mutate hd i).1.coordinate ⊓
        chartRing (geometricIntegerRing F) (s.mutate hd j).1.coordinate =
      chartRing (geometricIntegerRing F) (s.mutate hd i).1.coordinate ⊓
        chartRing (geometricIntegerRing F) s.1.coordinate ⊓
        chartRing (geometricIntegerRing F) ((s.mutate hd i).mutate hd j).1.coordinate := by
  by_cases hcomm : s.1.exchange (row j) i = 0
  · exact geometric_commuting_three_charts row d hd s hij hcomm
  · exact geometric_interacting_three_chart (geometricIntegerRing F)
      integerRing_le_rational row d hd s.1 i j hij hcomm

/-- The integral finite upper bound is invariant under every mutation. -/
theorem upperBound_mutation (hd : ∀ i, 0 < d i)
    (s : FullRankGeometricSeed (F := F) row d) (k : K) :
    upperBound (geometricIntegerRing F) (fun t => t.1.coordinate)
        (fun i t => mutate hd t i) (s.mutate hd k) =
      upperBound (geometricIntegerRing F) (fun t => t.1.coordinate)
        (fun i t => mutate hd t i) s := by
  exact upperBound_mutation_of_three_chart (geometricIntegerRing F)
    (fun t : FullRankGeometricSeed (F := F) row d => t.1.coordinate)
    (fun i t => mutate hd t i)
    (fun i t => mutate_involutive hd t i)
    (fun t i j hji => three_chart hd t i j hji.symm) s k

/-- Every coordinate reached by an arbitrary mutation word has an integral
Laurent expansion in the initial total coordinates. -/
theorem laurent (hd : ∀ i, 0 < d i)
    (s : FullRankGeometricSeed (F := F) row d) (w : List K) (a : M) :
    (mutateWord (fun i t => mutate hd t i) w s).1.coordinate a ∈
      chartRing (geometricIntegerRing F) s.1.coordinate :=
  laurent_of_upperBound_invariant (V := FullRankGeometricSeed (F := F) row d)
    (I := K) (J := M) (geometricIntegerRing F)
    (fun t : FullRankGeometricSeed (F := F) row d => t.1.coordinate)
    (fun i t => mutate hd t i)
    (fun i t => mutate_involutive hd t i)
    (fun t i a => mutate_coordinate_mem_chart hd (geometricIntegerRing F) t i a)
    (fun t i => upperBound_mutation hd t i) s w a

/-- The infinite intersection of reachable charts is already the finite
upper bound; this equality is proved, rather than assumed in seed data. -/
theorem upperClusterRing_eq (hd : ∀ i, 0 < d i)
    (s : FullRankGeometricSeed (F := F) row d) :
    upperClusterRing (geometricIntegerRing F) (fun t => t.1.coordinate)
        (fun i t => mutate hd t i) s =
      upperBound (geometricIntegerRing F) (fun t => t.1.coordinate)
        (fun i t => mutate hd t i) s :=
  upperClusterRing_eq_upperBound (geometricIntegerRing F)
    (fun t : FullRankGeometricSeed (F := F) row d => t.1.coordinate)
    (fun i t => mutate hd t i) (fun t i => upperBound_mutation hd t i) s

/-! ### Coefficients `R_J` and `𝕜_J`

The coefficients `C` are a factorial subring of a field `𝕜 ⊆ F` over which the coordinates of the
initial seed are algebraically independent: `C = ℤ`, `𝕜 = ℚ` for `R_J`
(`geometricIntegerRing_uniqueFactorizationMonoid`, `integerRing_le_rational`), and `C` the image
of `𝕜` for `𝕜_J` (`algebraMap_range_uniqueFactorizationMonoid`). Independence over `𝕜` is known
only at the seeds reached from `s`, which is where the pattern theorems need it. -/

section Coefficients

variable {𝕜 : Type*} [Field 𝕜] [Algebra 𝕜 F]

theorem algebraicIndependent_mutateWord (hd : ∀ i, 0 < d i)
    (s : FullRankGeometricSeed (F := F) row d) (hAI : AlgebraicIndependent 𝕜 s.1.coordinate)
    (w : List K) :
    AlgebraicIndependent 𝕜 (mutateWord (fun i t => mutate hd t i) w s).1.coordinate := by
  induction w generalizing s with
  | nil => exact hAI
  | cons k w ih => exact ih (s.mutate hd k) (s.1.algebraicIndependent_mutate hd hAI k)

/-- **Three-chart equality over `R_J` and `𝕜_J`.** -/
theorem three_chart_of_independent (C : Subring F) [UniqueFactorizationMonoid C]
    (hC : ∀ a ∈ C, a ∈ (algebraMap 𝕜 F).range) (hd : ∀ i, 0 < d i)
    (s : FullRankGeometricSeed (F := F) row d) (hAI : AlgebraicIndependent 𝕜 s.1.coordinate)
    (i j : K) (hij : i ≠ j) :
    chartRing C s.1.coordinate ⊓ chartRing C (s.mutate hd i).1.coordinate ⊓
        chartRing C (s.mutate hd j).1.coordinate =
      chartRing C (s.mutate hd i).1.coordinate ⊓ chartRing C s.1.coordinate ⊓
        chartRing C ((s.mutate hd i).mutate hd j).1.coordinate := by
  by_cases hcomm : s.1.exchange (row j) i = 0
  · exact geometric_commuting_three_charts_of_rank C hC row d hd s.1 hAI s.2 hij hcomm
  · exact geometric_interacting_three_chart_of_independent C hC row d hd s.1 hAI i j hij hcomm

/-- The upper bound over `C` is invariant under each mutation at every seed reached from `s`. -/
theorem upperBound_mutation_of_independent (C : Subring F) [UniqueFactorizationMonoid C]
    (hC : ∀ a ∈ C, a ∈ (algebraMap 𝕜 F).range) (hd : ∀ i, 0 < d i)
    (s : FullRankGeometricSeed (F := F) row d) (hAI : AlgebraicIndependent 𝕜 s.1.coordinate)
    (w : List K) (k : K) :
    upperBound C (fun t => t.1.coordinate) (fun i t => mutate hd t i)
        ((mutateWord (fun i t => mutate hd t i) w s).mutate hd k) =
      upperBound C (fun t => t.1.coordinate) (fun i t => mutate hd t i)
        (mutateWord (fun i t => mutate hd t i) w s) :=
  patternUpperBound_mutation_of_three_chart
    (fun t : FullRankGeometricSeed (F := F) row d => chartRing C t.1.coordinate)
    (fun i t => mutate hd t i) (fun i t => mutate_involutive hd t i) s
    (fun w i j hji => three_chart_of_independent C hC hd _
      (algebraicIndependent_mutateWord hd s hAI w) i j hji.symm) w k

/-- **U3 for a full-rank pattern over `R_J` or `𝕜_J`.** The upper bound over `C` is the same at
every seed reached from `s`. -/
theorem upperBound_mutateWord_of_independent (C : Subring F) [UniqueFactorizationMonoid C]
    (hC : ∀ a ∈ C, a ∈ (algebraMap 𝕜 F).range) (hd : ∀ i, 0 < d i)
    (s : FullRankGeometricSeed (F := F) row d) (hAI : AlgebraicIndependent 𝕜 s.1.coordinate)
    (w : List K) :
    upperBound C (fun t => t.1.coordinate) (fun i t => mutate hd t i)
        (mutateWord (fun i t => mutate hd t i) w s) =
      upperBound C (fun t => t.1.coordinate) (fun i t => mutate hd t i) s :=
  patternUpperBound_mutateWord
    (fun t : FullRankGeometricSeed (F := F) row d => chartRing C t.1.coordinate)
    (fun i t => mutate hd t i) s (upperBound_mutation_of_independent C hC hd s hAI) w

/-- Laurentness over `R_J` or `𝕜_J`: every coordinate of a seed reached from `s` lies in the chart
ring over `C` of every seed reached from `s`. -/
theorem laurent_of_independent (C : Subring F) [UniqueFactorizationMonoid C]
    (hC : ∀ a ∈ C, a ∈ (algebraMap 𝕜 F).range) (hd : ∀ i, 0 < d i)
    (s : FullRankGeometricSeed (F := F) row d) (hAI : AlgebraicIndependent 𝕜 s.1.coordinate)
    (u w : List K) (a : M) :
    (mutateWord (fun i t => mutate hd t i) w s).1.coordinate a ∈
      chartRing C (mutateWord (fun i t => mutate hd t i) u s).1.coordinate :=
  generator_mem_of_patternUpperBound
    (fun t : FullRankGeometricSeed (F := F) row d => chartRing C t.1.coordinate)
    (fun i t => mutate hd t i) (fun t => t.1.coordinate) (fun i t => mutate_involutive hd t i) s
    (fun _ a => coordinate_mem_chartRing C _ a)
    (fun _ i a => mutate_coordinate_mem_chart hd C _ i a)
    (upperBound_mutation_of_independent C hC hd s hAI) u w a

/-- Over `R_J` or `𝕜_J`, the intersection of all reachable charts is the finite upper bound. -/
theorem upperClusterRing_eq_of_independent (C : Subring F) [UniqueFactorizationMonoid C]
    (hC : ∀ a ∈ C, a ∈ (algebraMap 𝕜 F).range) (hd : ∀ i, 0 < d i)
    (s : FullRankGeometricSeed (F := F) row d) (hAI : AlgebraicIndependent 𝕜 s.1.coordinate) :
    upperClusterRing C (fun t => t.1.coordinate) (fun i t => mutate hd t i) s =
      upperBound C (fun t => t.1.coordinate) (fun i t => mutate hd t i) s :=
  patternUpperRing_eq_patternUpperBound
    (fun t : FullRankGeometricSeed (F := F) row d => chartRing C t.1.coordinate)
    (fun i t => mutate hd t i) s (upperBound_mutation_of_independent C hC hd s hAI)

end Coefficients

end FullRankGeometricSeed
end TauCeti.Cluster
