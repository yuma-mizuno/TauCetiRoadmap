/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.QuantumInteracting
public import TauCetiRoadmap.ClusterAlgebras.QuantumCentralFactors
public import TauCetiRoadmap.LaurentPhenomenon.Quantum.CentralDivisibility
public import TauCetiRoadmap.ClusterAlgebras.QuantumPairChart
public import TauCetiRoadmap.ClusterAlgebras.PolynomialQuantumCommuting

/-!
# The commuting two-direction intersection of a quantum seed

For distinct mutable directions `i, j` of a quantum seed with `b_{row j, i} = 0` (hence also
`b_{row i, j} = 0`), put `C = pairRing (row i) (row j)`, the ring `subsetRing S` of the set
`S` of coordinates other than `row i, row j`, `x = X_{row i}` and `y = X_{row j}`. The column
`b_{•i}` vanishes off `S`, so Q1 applies over `C` (`mem_chartRing_exchangeCoordinate_iff`): an
element of `C[x^{±1}] ∩ C[X'^{±1}_i]` has its coefficient at `x^{-t}` in `C P_{i,t}`; likewise
for `j`. Expanding `f ∈ T_s ∩ T_{μ_i(s)}` in powers of `y` with coefficients in `C⟨x, X'_i⟩`,
Q1 for `j` (`mem_mutate_chartRing_iff`) says that the coefficient at `y^{-r}` lies in
`T_s P_{j,r}`; `P_{j,r}` commutes with `x`, so every `x`-coefficient of it lies in `C P_{j,r}`,
and the negative ones also in `C P_{i,t}`. `C` is the faithful image of the quantum torus on
the exponents vanishing at `row i, row j`, where `M(b_{•i})` and `M(b_{•j})` are central, so
the common polynomial central-divisibility theorem gives divisibility by
`P_{i,t} P_{j,r}` (`exists_eq_mul_centralProduct_mul`). Both this calculation and the
commuting Q2 intersection are degree-one instances of the polynomial proofs.
-/

@[expose] public section

namespace TauCeti.Cluster.ExchangeFrame

open TauCeti TauCeti.QuantumTorus TauCeti.Laurent

noncomputable section

variable {D : Type*} [DivisionRing D] [Algebra Zv D]
  {M K : Type*} [Fintype M] [DecidableEq M] {row : K ↪ M}
  (s : ExchangeFrame (u₀ := vUnit) D row)

/-- **Central divisibility in `C`** (§0.6, commuting case of Q2). If `b_{row j, i} = 0` and
`c ∈ C = pairRing (row i) (row j)` is divisible on the right in `C` by `P_{i,t}` and by
`P_{j,r}`, it is divisible by `P_{i,t} P_{j,r}`. -/
theorem exists_eq_mul_centralProduct_mul {i j : K} (hij : i ≠ j)
    (hb : s.exchange.matrix (row j) i = 0) {c a b : D} (ha : a ∈ s.pairRing (row i) (row j))
    (hb₂ : b ∈ s.pairRing (row i) (row j)) (t r : ℕ) (hca : c = a * s.centralProduct i t)
    (hcb : c = b * s.centralProduct j r) :
    ∃ e ∈ s.pairRing (row i) (row j), c = e * (s.centralProduct i t * s.centralProduct j r) := by
  have h := s.polynomialSeed.exists_eq_mul_centralProduct_mul hij hb ha hb₂ t r
    (by simpa only [polynomialSeed_centralProduct] using hca)
    (by simpa only [polynomialSeed_centralProduct] using hcb)
  simpa only [polynomialSeed_centralProduct, polynomialSeed_toExchangeFrame] using h

variable [Fintype K] [DecidableEq K]

/-- **Q2, commuting case.** If `b_{row j, i} = 0` (hence `b_{row i, j} = 0`), then
`(T_s ∩ T_{μ_i(s)}) ∩ (T_s ∩ T_{μ_j(s)}) = C⟨X_i, X'_i, X_j, X'_j⟩`. -/
theorem inf_mutate_inf_inf_mutate_eq_fourRing_of_eq_zero {i j : K}
    (hij : i ≠ j) (hb : s.exchange.matrix (row j) i = 0) :
    (s.chartRing ⊓ (s.mutate i).chartRing) ⊓ (s.chartRing ⊓ (s.mutate j).chartRing) =
      s.fourRing i j :=
  by
    have h := s.polynomialSeed.inf_mutate_inf_inf_mutate_eq_fourRing_of_eq_zero hij hb
    simpa only [polynomialSeed_mutate, polynomialSeed_fourRing,
      polynomialSeed_toExchangeFrame] using h

end

end TauCeti.Cluster.ExchangeFrame
