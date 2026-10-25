/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.QuantumAlgebra

/-!
# Normalized-monomial expansions in quantum charts

The chart `T(Zv,v,Λ) → D` of a quantum seed `s` is injective, so its inverse on the range
`T_s` gives every element of `T_s` a unique finite expansion `Σ_a c_a M(a)` in the normalized
monomials of `s`, with coefficients `c_a ∈ Zv` (`ExchangeFrame.expansion`). Expanding and then
evaluating is the inclusion `T_s → D`.

By the quantum Laurent phenomenon every coordinate of a seed `t` reachable from `u` lies in
`T_u`; `ExchangeFrame.variableExpansion` is its expansion in the chart of `u`, and
`ExchangeFrame.laurentExpansion` is the expansion of the variable reached by a mutation word.
We prove the laws of these expansions:

* evaluation: the chart sends the expansion back to the variable;
* re-rooting: for `t = μ_w(s)` and `u = μ_{w'}(s)`, the expansion of `X_{j;t}` in the chart of
  `u` is the Laurent expansion from the root `u` along `w'⁻¹w`;
* reindexing: along a relabelling of `M` and `K` transporting the seed data, expansions are
  carried by the lattice reindexing `QuantumTorus.domCongr`;
* ambient transport: along a `Zv`-algebra map of division rings, expansions do not change.
-/

@[expose] public section

namespace TauCeti.Cluster.ExchangeFrame

open TauCeti TauCeti.Laurent TauCeti.QuantumTorus

noncomputable section

variable {D : Type*} [DivisionRing D] [Algebra Zv D]
  {M K : Type*} [Fintype M] [DecidableEq M] {row : K ↪ M}

/-! ### The expansion in one chart -/

section Expansion

variable (s : ExchangeFrame (u₀ := vUnit) D row)

/-- The **expansion** in the chart of `s`: the inverse of the injective chart on its range
`T_s`. -/
def expansion : s.chartAlgebra ≃ₐ[Zv] quantumTorus Zv vUnit (matrixForm s.form) :=
  (AlgEquiv.ofInjective s.chart s.chart_injective).symm

/-- **Evaluation.** The chart sends the expansion of `x` back to `x`. -/
@[simp] theorem chart_expansion (x : s.chartAlgebra) : s.chart (s.expansion x) = x :=
  (AlgEquiv.ofInjective_apply s.chart s.chart_injective _).symm.trans
    (congrArg Subtype.val ((AlgEquiv.ofInjective s.chart s.chart_injective).apply_symm_apply x))

/-- Expanding and then evaluating is the inclusion `T_s → D`. -/
theorem chart_comp_expansion :
    s.chart.comp s.expansion.toAlgHom = s.chartAlgebra.val :=
  AlgHom.ext s.chart_expansion

theorem chart_mem_chartAlgebra (f : quantumTorus Zv vUnit (matrixForm s.form)) :
    s.chart f ∈ s.chartAlgebra :=
  ⟨f, rfl⟩

theorem expansion_eq_iff {x : s.chartAlgebra} {f : quantumTorus Zv vUnit (matrixForm s.form)} :
    s.expansion x = f ↔ s.chart f = x := by
  constructor
  · rintro rfl
    exact s.chart_expansion x
  · intro h
    apply s.chart_injective
    rw [chart_expansion, h]

@[simp] theorem expansion_chart (f : quantumTorus Zv vUnit (matrixForm s.form)) :
    s.expansion ⟨s.chart f, s.chart_mem_chartAlgebra f⟩ = f :=
  (s.expansion_eq_iff).2 rfl

/-- **Uniqueness of expansions.** Every element of `T_s` is the image of exactly one element of
the quantum torus. -/
theorem existsUnique_chart_eq {x : D} (hx : x ∈ s.chartAlgebra) :
    ∃! f : quantumTorus Zv vUnit (matrixForm s.form), s.chart f = x :=
  ⟨s.expansion ⟨x, hx⟩, s.chart_expansion _, fun _ hf ↦ ((s.expansion_eq_iff).2 hf).symm⟩

/-- **The finite normalized-monomial expansion** `x = Σ_a c_a M(a)`, over the finite support of
the expansion, with coefficients `c_a ∈ Zv`. -/
theorem sum_coeff_expansion_smul_monomial (x : s.chartAlgebra) :
    ∑ a ∈ support (s.expansion x), coeff a (s.expansion x) • s.monomial a = x := by
  conv_rhs => rw [← s.chart_expansion x, ← sum_coeff_smul_monomial (s.expansion x)]
  rw [map_sum]
  simp only [map_smul]
  rfl

/-- A finite expansion `x = Σ_{a ∈ T} c_a M(a)` is the expansion of `x`. -/
theorem expansion_eq_sum {x : s.chartAlgebra} {T : Finset (M → ℤ)} {c : (M → ℤ) → Zv}
    (h : (x : D) = ∑ a ∈ T, c a • s.monomial a) :
    s.expansion x = ∑ a ∈ T, c a • QuantumTorus.monomial a := by
  rw [expansion_eq_iff, h, map_sum]
  simp only [map_smul]
  rfl

/-- **Uniqueness of coefficients.** The coefficients of a finite expansion
`x = Σ_{a ∈ T} c_a M(a)` are those of the expansion of `x`. -/
theorem coeff_expansion_of_eq_sum {x : s.chartAlgebra} {T : Finset (M → ℤ)}
    {c : (M → ℤ) → Zv} (h : (x : D) = ∑ a ∈ T, c a • s.monomial a) (b : M → ℤ) :
    coeff b (s.expansion x) = if b ∈ T then c b else 0 := by
  rw [s.expansion_eq_sum h]
  simp only [map_sum, map_smul, coeff_monomial, Finsupp.single_apply, smul_eq_mul, mul_ite,
    mul_one, mul_zero, Finset.sum_ite_eq']

@[simp] theorem expansion_monomial (a : M → ℤ) :
    s.expansion ⟨s.monomial a, s.monomial_mem_chartAlgebra a⟩ = QuantumTorus.monomial a :=
  s.expansion_chart _

theorem coordinate_mem_chartAlgebra (j : M) : (s.coordinate j : D) ∈ s.chartAlgebra :=
  s.mem_chartAlgebra.2 (Laurent.coordinate_mem_chartRing _ _ j)

@[simp] theorem expansion_coordinate (j : M) :
    s.expansion ⟨s.coordinate j, s.coordinate_mem_chartAlgebra j⟩ =
      QuantumTorus.monomial (Pi.single j 1) :=
  (s.expansion_eq_iff).2 (s.monomial_single j)

end Expansion

/-! ### Expansions of reachable variables and re-rooting -/

section Reachable

variable [Fintype K] [DecidableEq K]

/-- The expansion of the coordinate `X_{j;t}` of a seed `t` reachable from `u` in the chart of
`u`; it exists by the quantum Laurent phenomenon. -/
def variableExpansion {u t : ExchangeFrame (u₀ := vUnit) D row} (h : Reachable u t) (j : M) :
    quantumTorus Zv vUnit (matrixForm u.form) :=
  u.expansion ⟨t.coordinate j, h.coordinate_mem_chartAlgebra j⟩

/-- The Laurent expansion in the chart of `s` of the variable `X_{j;w}` of the seed reached
from `s` by the word `w`. -/
def laurentExpansion (s : ExchangeFrame (u₀ := vUnit) D row) (w : List K) (j : M) :
    quantumTorus Zv vUnit (matrixForm s.form) :=
  variableExpansion (reachable_mutateWord s w) j

variable {u t : ExchangeFrame (u₀ := vUnit) D row}

/-- **Evaluation.** -/
@[simp] theorem chart_variableExpansion (h : Reachable u t) (j : M) :
    u.chart (variableExpansion h j) = t.coordinate j :=
  u.chart_expansion _

theorem variableExpansion_eq_iff (h : Reachable u t) (j : M)
    {f : quantumTorus Zv vUnit (matrixForm u.form)} :
    variableExpansion h j = f ↔ u.chart f = t.coordinate j :=
  u.expansion_eq_iff

/-- The expansion depends only on the seeds, not on the reachability witness. -/
theorem variableExpansion_congr {t' : ExchangeFrame (u₀ := vUnit) D row} (h : Reachable u t)
    (h' : Reachable u t') (ht : t = t') (j : M) :
    variableExpansion h j = variableExpansion h' j := by
  subst ht
  rfl

@[simp] theorem variableExpansion_refl (j : M) :
    variableExpansion (Reachable.refl u) j = QuantumTorus.monomial (Pi.single j 1) :=
  u.expansion_coordinate j

/-- Frozen variables are expanded as themselves in every chart. -/
theorem variableExpansion_of_notMem (h : Reachable u t) {j : M} (hj : j ∉ Set.range row) :
    variableExpansion h j = QuantumTorus.monomial (Pi.single j 1) := by
  rw [variableExpansion_eq_iff, h.coordinate_of_notMem hj]
  exact u.monomial_single j

theorem chart_laurentExpansion (s : ExchangeFrame (u₀ := vUnit) D row) (w : List K) (j : M) :
    s.chart (s.laurentExpansion w j) =
      (mutateWord (fun k t ↦ ExchangeFrame.mutate t k) w s).coordinate j :=
  chart_variableExpansion _ j

/-- **Re-rooting.** For `t = μ_w(s)` and `u = μ_{w'}(s)`, the expansion of `X_{j;t}` in the
chart of `u` is the Laurent expansion from the root `u` along `w'⁻¹ w`. -/
theorem laurentExpansion_reroot (s : ExchangeFrame (u₀ := vUnit) D row) (w w' : List K) (j : M) :
    (mutateWord (fun k t ↦ ExchangeFrame.mutate t k) w' s).laurentExpansion
        (w'.reverse ++ w) j =
      variableExpansion ((reachable_mutateWord s w').symm.trans (reachable_mutateWord s w))
        j :=
  variableExpansion_congr _ _ (by
    rw [mutateWord_append, mutateWord_reverse _ (fun k ↦ mutate_involutive k)]) j

end Reachable

/-! ### Reindexing -/

section Reindex

variable {M' K' : Type*} [Fintype M'] [DecidableEq M'] {row' : K' ↪ M'}
  (σ : M ≃ M') (τ : K ≃ K') (hrow : ∀ k, row' (τ k) = σ (row k))
  (s : ExchangeFrame (u₀ := vUnit) D row)

/-- **Reindexing.** The expansion in the chart of the relabelled seed is the lattice
reindexing of the expansion in the chart of `s`. -/
theorem reindex_expansion {x : D} (hx : x ∈ s.chartAlgebra)
    (hx' : x ∈ (s.reindex σ τ hrow).chartAlgebra) :
    (s.reindex σ τ hrow).expansion ⟨x, hx'⟩ =
      domCongr (exponentReindex σ) (matrixForm_reindex σ s.form) (s.expansion ⟨x, hx⟩) :=
  ((s.reindex σ τ hrow).expansion_eq_iff).2
    ((s.reindex_chart_domCongr σ τ hrow _).trans (s.chart_expansion _))

/-- **Reindexing of Laurent expansions.** The variable `X_{σ j; τ(w)}` of the relabelled seed
has the relabelled Laurent expansion of `X_{j;w}`. -/
theorem laurentExpansion_reindex [Fintype K] [DecidableEq K] [Fintype K'] [DecidableEq K']
    (w : List K) (j : M) :
    (s.reindex σ τ hrow).laurentExpansion (w.map τ) (σ j) =
      domCongr (exponentReindex σ) (matrixForm_reindex σ s.form) (s.laurentExpansion w j) := by
  refine (variableExpansion_eq_iff _ _).2 ?_
  rw [reindex_chart_domCongr, chart_laurentExpansion, ← reindex_mutateWord σ τ hrow s,
    reindex_coordinate]

end Reindex

/-! ### Ambient transport -/

section Map

variable {D' : Type*} [DivisionRing D'] [Algebra Zv D'] (φ : D →ₐ[Zv] D')
  (s : ExchangeFrame (u₀ := vUnit) D row)

theorem map_mem_chartAlgebra {x : D} (hx : x ∈ s.chartAlgebra) :
    φ x ∈ (s.map φ).chartAlgebra := by
  rw [map_chartAlgebra]
  exact Subalgebra.mem_map.2 ⟨x, hx, rfl⟩

theorem map_chart_apply (f : quantumTorus Zv vUnit (matrixForm s.form)) :
    (s.map φ).chart f = φ (s.chart f) :=
  DFunLike.congr_fun (s.map_chart φ) f

/-- **Ambient transport.** The expansion of `φ x` in the chart of the transported seed is the
expansion of `x`. -/
theorem map_expansion (x : s.chartAlgebra) :
    (s.map φ).expansion ⟨φ x, s.map_mem_chartAlgebra φ x.2⟩ = s.expansion x :=
  ((s.map φ).expansion_eq_iff).2
    ((s.map_chart_apply φ _).trans (congrArg φ (s.chart_expansion x)))

/-- **Ambient transport of Laurent expansions.** -/
theorem laurentExpansion_map [Fintype K] [DecidableEq K] (w : List K)
    (j : M) : (s.map φ).laurentExpansion w j = s.laurentExpansion w j := by
  refine (variableExpansion_eq_iff _ _).2 ?_
  rw [← map_mutateWord, map_coordinate]
  exact (s.map_chart_apply φ _).trans (congrArg φ (s.chart_laurentExpansion w j))

end Map

end

end TauCeti.Cluster.ExchangeFrame
