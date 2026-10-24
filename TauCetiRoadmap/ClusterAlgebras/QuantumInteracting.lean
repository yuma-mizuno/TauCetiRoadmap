/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.QuantumPolynomial
public import TauCetiRoadmap.ClusterAlgebras.PolynomialQuantumInteracting

/-!
# Ordinary interacting intersections as polynomial specializations

All finite-support and unit-constant-term calculations belong to the polynomial
construction. These ordinary statements retain their original seed hypotheses.
-/

@[expose] public section

namespace TauCeti.Cluster.QuantumSeed

open TauCeti TauCeti.Laurent

variable {D : Type*} [DivisionRing D] [Algebra Zv D]
  {M K : Type*} [Fintype M] [DecidableEq M] [Fintype K] [DecidableEq K]
  {row : K ↪ M} (s : QuantumSeed D row)

omit [Fintype K] [DecidableEq K] in
theorem fourRing_comm (i j : K) : s.fourRing i j = s.fourRing j i := by
  rw [fourRing, fourRing, s.pairRing_comm, UpperBound.fourRing_comm]

theorem fourRing_le_inf_mutate {i j : K} (hij : i ≠ j) :
    s.fourRing i j ≤ s.chartRing ⊓ (s.mutate i).chartRing := by
  have h := s.polynomialSeed.fourRing_le_inf_mutate hij
  simpa only [polynomialSeed_mutate, polynomialSeed_fourRing,
    polynomialSeed_toQuantumSeed] using h

/-- Q2 for an interacting pair of ordinary quantum directions. -/
theorem inf_mutate_inf_inf_mutate_eq_fourRing {i j : K} (hij : i ≠ j)
    (hb : s.exchange.matrix (row j) i ≠ 0) :
    (s.chartRing ⊓ (s.mutate i).chartRing) ⊓ (s.chartRing ⊓ (s.mutate j).chartRing) =
      s.fourRing i j := by
  have h := s.polynomialSeed.inf_mutate_inf_inf_mutate_eq_fourRing hij hb
  simpa only [polynomialSeed_mutate, polynomialSeed_fourRing,
    polynomialSeed_toQuantumSeed] using h

end TauCeti.Cluster.QuantumSeed
