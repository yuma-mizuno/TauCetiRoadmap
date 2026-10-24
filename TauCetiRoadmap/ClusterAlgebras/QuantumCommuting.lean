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
`TauCeti.QuantumTorus.exists_eq_mul_prod_mul_prod_vUnit` gives divisibility by
`P_{i,t} P_{j,r}` (`exists_eq_mul_centralProduct_mul`). This proves the commuting case of Q2,
`inf_mutate_inf_inf_mutate_eq_fourRing_of_eq_zero`.
-/

@[expose] public section

namespace TauCeti.Cluster.QuantumSeed

open TauCeti TauCeti.QuantumTorus TauCeti.Laurent

noncomputable section

variable {D : Type*} [DivisionRing D] [Algebra Zv D]
  {M K : Type*} [Fintype M] [DecidableEq M] {row : K ↪ M}
  (s : QuantumSeed D row)

private theorem exchange_row_eq_zero {i j : K}
    (hb : s.exchange.matrix (row j) i = 0) : s.exchange.matrix (row i) j = 0 := by
  have h := s.exchange.symmetrized i j
  rw [hb, mul_zero, neg_zero] at h
  exact (mul_eq_zero.1 h).resolve_left (s.exchange.symmetrizer_pos i).ne'

/-- The chart image of a binomial product in `X ^ x`, `x = b_{•k}`, is `P_{k,r}`. -/
private theorem pairTorusChart_prod (a b : M) (k : K) (x : pairLattice a b)
    (hx : (x : M → ℤ) = fun l ↦ s.exchange.matrix l k) (r : ℕ) :
    s.pairTorusChart a b ((((List.range r).map fun h : ℕ ↦ (2 * (h : ℤ) + 1)
        * s.exchange.symmetrizer k).map
      fun h ↦ 1 + algebraMap Zv (quantumTorus Zv vUnit (s.pairTorusForm a b))
        ((vUnit ^ h : Zvˣ) : Zv) * QuantumTorus.monomial x).prod) = s.centralProduct k r := by
  rw [map_list_prod, List.map_map, List.map_map, centralProduct]
  congr 1
  refine List.map_congr_left fun h _ ↦ ?_
  simp only [Function.comp_apply, map_add, map_one, map_mul, AlgHom.commutes,
    pairTorusChart_monomial, hx, binomialFactor]

/-- **Central divisibility in `C`** (§0.6, commuting case of Q2). If `b_{row j, i} = 0` and
`c ∈ C = pairRing (row i) (row j)` is divisible on the right in `C` by `P_{i,t}` and by
`P_{j,r}`, it is divisible by `P_{i,t} P_{j,r}`. -/
theorem exists_eq_mul_centralProduct_mul {i j : K} (hij : i ≠ j)
    (hb : s.exchange.matrix (row j) i = 0) {c a b : D} (ha : a ∈ s.pairRing (row i) (row j))
    (hb₂ : b ∈ s.pairRing (row i) (row j)) (t r : ℕ) (hca : c = a * s.centralProduct i t)
    (hcb : c = b * s.centralProduct j r) :
    ∃ e ∈ s.pairRing (row i) (row j), c = e * (s.centralProduct i t * s.centralProduct j r) := by
  have hji : row j ≠ row i := row.injective.ne hij.symm
  have hb' := s.exchange_row_eq_zero hb
  have hdi := s.exchange.diagonal
  let p : pairLattice (row i) (row j) := ⟨fun l ↦ s.exchange.matrix l i, hdi i, hb⟩
  let q : pairLattice (row i) (row j) := ⟨fun l ↦ s.exchange.matrix l j, hb', hdi j⟩
  have hΛ : LinearMap.IsAlt (s.pairTorusForm (row i) (row j)) := fun x ↦
    s.alternating.matrixForm_self x.1
  have hp : ∀ x, s.pairTorusForm (row i) (row j) p x = 0 := fun x ↦ by
    change matrixForm s.form (fun l ↦ s.exchange.matrix l i) x.1 = 0
    rw [s.compatible.matrixForm_col, x.2.1, mul_zero]
  have hq : ∀ x, s.pairTorusForm (row i) (row j) q x = 0 := fun x ↦ by
    change matrixForm s.form (fun l ↦ s.exchange.matrix l j) x.1 = 0
    rw [s.compatible.matrixForm_col, x.2.2, mul_zero]
  have hpq : ∀ m n : ℤ, m • p + n • q = 0 → m = 0 ∧ n = 0 := by
    intro m n h
    have h1 := congrArg (fun x : pairLattice (row i) (row j) ↦
      matrixForm s.form (Pi.single (row i) 1) (x : M → ℤ)) h
    have h2 := congrArg (fun x : pairLattice (row i) (row j) ↦
      matrixForm s.form (Pi.single (row j) 1) (x : M → ℤ)) h
    simp only [AddSubgroup.coe_add, AddSubgroup.coe_zsmul, AddSubgroup.coe_zero, map_add,
      map_zsmul, map_zero, p, q, s.compatible.matrixForm_col_right s.alternating,
      smul_eq_mul] at h1 h2
    simp [hji, hji.symm] at h1 h2
    exact ⟨h1.resolve_right (s.exchange.symmetrizer_pos i).ne',
      h2.resolve_right (s.exchange.symmetrizer_pos j).ne'⟩
  obtain ⟨a', rfl⟩ := s.exists_pairTorusChart_eq _ _ ha
  obtain ⟨b', rfl⟩ := s.exists_pairTorusChart_eq _ _ hb₂
  have hP := s.pairTorusChart_prod (row i) (row j) i p rfl t
  have hQ := s.pairTorusChart_prod (row i) (row j) j q rfl r
  rw [← hP, ← map_mul] at hca
  rw [← hQ, ← map_mul, hca] at hcb
  obtain ⟨g, hg⟩ := exists_eq_mul_prod_mul_prod_vUnit hΛ hpq hp hq _ _
    ⟨a', rfl⟩ ⟨b', s.pairTorusChart_injective _ _ hcb⟩
  refine ⟨s.pairTorusChart _ _ g, s.pairTorusChart_mem_pairRing _ _ g, ?_⟩
  rw [hca, hg, map_mul, map_mul, hP, hQ]

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
      polynomialSeed_toQuantumSeed] using h

end

end TauCeti.Cluster.QuantumSeed
