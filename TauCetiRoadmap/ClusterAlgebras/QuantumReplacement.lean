/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.QuantumPolynomial

/-!
# Ordinary quantum replacement from the polynomial construction

The degree-one comparison transfers the constructed finite replacement theorem.
There is one coefficient/defect proof engine, in the polynomial development.
-/

@[expose] public section

namespace TauCeti.Cluster.QuantumSeed

open TauCeti TauCeti.Laurent

variable {D : Type*} [DivisionRing D] [Algebra Zv D]
  {M K : Type*} [Fintype M] [DecidableEq M] [Fintype K] [DecidableEq K]
  {row : K ↪ M} (s : QuantumSeed D row)

/-- Noninteracting exchanges are unchanged by the other mutation. -/
theorem mutate_exchangeCoordinate_of_eq_zero {i j : K} (hij : i ≠ j)
    (hb : s.exchange.matrix (row i) j = 0) :
    (s.mutate i).exchangeCoordinate j = s.exchangeCoordinate j := by
  have h := s.polynomialSeed.mutate_exchangeCoordinate_of_eq_zero hij hb
  simpa only [polynomialSeed_mutate, polynomialSeed_exchangeCoordinate] using h

/-- Ordinary replacement, as the degree-one polynomial replacement theorem. -/
theorem replacement_mem {i j : K} (hij : i ≠ j) :
    (s.mutate i).exchangeCoordinate j ∈
      UpperBound.generated (s.pairRing (row i) (row j))
        {s.exchangeCoordinate i, s.exchangeCoordinate j, (s.coordinate (row j) : D)} := by
  have h := s.polynomialSeed.replacement_mem hij
  simpa only [polynomialSeed_mutate, polynomialSeed_exchangeCoordinate,
    polynomialSeed_toQuantumSeed] using h

/-- The four-generator ring is unchanged by ordinary mutation. -/
theorem fourRing_mutate {i j : K} (hij : i ≠ j) :
    (s.mutate i).fourRing i j = s.fourRing i j := by
  have h := s.polynomialSeed.fourRing_mutate hij
  simpa only [polynomialSeed_mutate, polynomialSeed_fourRing] using h

end TauCeti.Cluster.QuantumSeed
