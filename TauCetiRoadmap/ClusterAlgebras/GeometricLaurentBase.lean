/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.GeometricSeed
public import TauCetiRoadmap.ClusterAlgebras.UpperBound
public import TauCetiRoadmap.LaurentPhenomenon.LaurentChart

/-! One-step Laurentness for actual geometric seeds, independent of either
global proof of the Laurent phenomenon. -/

@[expose] public section

namespace TauCeti.Cluster
open TauCeti.Laurent
open scoped BigOperators

variable {M K F : Type*} [Fintype M] [Fintype K]
  [DecidableEq M] [DecidableEq K] [Field F] [Algebra ℚ F]

omit [DecidableEq K] [DecidableEq M] [Fintype K] in
theorem geometricExchange_eval_mem_chart (C : Subring F)
    (B : Matrix M K ℤ) (x : M → F) (k : K) :
    MvPolynomial.aeval x (geometricExchangePolynomial B k) ∈ chartRing C x := by
  rw [aeval_geometricExchangePolynomial]
  apply Subring.add_mem
  · exact Subring.prod_mem _ fun a _ => coordinate_zpow_mem_chartRing C x a _
  · exact Subring.prod_mem _ fun a _ => coordinate_zpow_mem_chartRing C x a _

omit [Fintype K] in
theorem GeometricSeed.mutate_coordinate_mem_chart [Finite K] {row : K ↪ M} {d : K → ℤ}
    (hd : ∀ i, 0 < d i) (C : Subring F) (s : GeometricSeed (F := F) row d)
    (k : K) (a : M) :
    (s.mutate hd k).coordinate a ∈ chartRing C s.coordinate := by
  let : Fintype K := Fintype.ofFinite K
  by_cases ha : a = row k
  · subst a
    change Function.update s.coordinate (row k) _ (row k) ∈ _
    rw [Function.update_self, div_eq_mul_inv]
    exact (chartRing C s.coordinate).mul_mem
      (geometricExchange_eval_mem_chart C s.exchange s.coordinate k)
      (inverse_mem_chartRing C s.coordinate (row k))
  · simpa only [GeometricSeed.mutate, geometricMutationCoordinates,
      Function.update_of_ne ha] using coordinate_mem_chartRing C s.coordinate a

theorem FullRankGeometricSeed.mutate_coordinate_mem_chart
    {row : K ↪ M} {d : K → ℤ} (hd : ∀ i, 0 < d i)
    (C : Subring F) (s : FullRankGeometricSeed (F := F) row d) (k : K) (a : M) :
    (s.mutate hd k).1.coordinate a ∈ chartRing C s.1.coordinate :=
  s.1.mutate_coordinate_mem_chart hd C k a

end TauCeti.Cluster
