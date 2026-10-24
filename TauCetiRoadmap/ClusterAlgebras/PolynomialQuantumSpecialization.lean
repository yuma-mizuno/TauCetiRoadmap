/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.PolynomialQuantumLaurent
public import TauCetiRoadmap.ClusterAlgebras.PolynomialGeometricPattern
public import TauCetiRoadmap.ClusterAlgebras.ChartSpecialization

/-!
# Classical specialization of polynomial quantum mutation

Classical exchanges are defined independently in `PolynomialGeometricPattern`.
The specialization `v ↦ 1` commutes with polynomial reversal and every mutation
word, on the unique integral quantum Laurent representatives. Nonvanishing of
classical denominators is stated explicitly; no ambient division-ring map is used.
-/

@[expose] public section

namespace TauCeti.Cluster

open TauCeti TauCeti.QuantumTorus TauCeti.Laurent

noncomputable section

variable {D : Type*} [DivisionRing D] [Algebra Zv D]
  {M K : Type*} [Fintype M] [DecidableEq M] [Fintype K] [DecidableEq K]
  {row : K ↪ M} {F : Type*} [Field F]

namespace PolynomialQuantumSeed

variable (s : PolynomialQuantumSeed D row)

/-- Initial classical data, with each scalar exchange coefficient evaluated at `v=1`. -/
def classicalData (x : M → F) : PolynomialGeometricData F M K :=
  ⟨s.exchange.matrix, fun k ↦ (s.polynomial k).map evalOne, x⟩

omit [Fintype K] [DecidableEq K] in
theorem evalOne_polynomial_reverse (k : K) :
    (s.polynomial k).reverse.map evalOne = ((s.polynomial k).map evalOne).reverse := by
  rw [Polynomial.reverse, Polynomial.reverse,
    Polynomial.natDegree_map_eq_of_isUnit_leadingCoeff evalOne
      (by rw [s.leadingCoeff_eq_one]; exact isUnit_one), Polynomial.reflect_map]

theorem mutateWord_degree (w : List K) (k : K) :
    (mutateWord (fun k t ↦ PolynomialQuantumSeed.mutate t k) w s).degree k = s.degree k := by
  induction w generalizing s with
  | nil => rfl
  | cons j w ih => rw [mutateWord_cons, ih, mutate_degree]

/-- The independent classical and quantum patterns carry the same matrices and polynomials. -/
theorem mutateWord_classicalData (x : M → F) (w : List K) :
    let t := mutateWord (fun k t ↦ PolynomialQuantumSeed.mutate t k) w s
    let p := polynomialGeometricPattern row s.degree (s.classicalData x) w
    t.exchange.matrix = p.exchange ∧
      (fun k ↦ (t.polynomial k).map evalOne) = p.polynomial := by
  induction w using List.reverseRecOn with
  | nil => exact ⟨rfl, rfl⟩
  | append_singleton w k ih =>
    dsimp only at ih ⊢
    rw [mutateWord_append, polynomialGeometricPattern_append]
    simp only [mutateWord_cons, mutateWord_nil]
    refine ⟨congrArg (fun B ↦ extendedMatrixMutation row B k) ih.1, ?_⟩
    funext j
    dsimp only [polynomialGeometricExchange]
    rw [mutate_polynomial, mutatePolynomial]
    by_cases hj : j = k
    · subst j
      rw [Function.update_self, Function.update_self, evalOne_polynomial_reverse]
      exact congrArg Polynomial.reverse (congrFun ih.2 k)
    · rw [Function.update_of_ne hj, Function.update_of_ne hj]
      exact congrFun ih.2 j

omit [Fintype K] [DecidableEq K] in
theorem exchange_numerator_exponent (k : K) (l : ℕ) (a : M) :
    (s.exchangeExponent k l + Pi.single (row k) 1 : M → ℤ) a =
      positivePart (-s.exchange.matrix a k) + (l : ℤ) * (s.exchange.matrix a k / s.degree k) := by
  simp only [exchangeExponent, exchangeExponentNeg, dividedColumn, Pi.add_apply,
    Pi.neg_apply, Pi.smul_apply, smul_eq_mul]
  ring

omit [Fintype K] [DecidableEq K] in
theorem exchange_numerator_exponent_nonneg (k : K) {l : ℕ} (hl : l ≤ s.degree k) :
    ∀ a, 0 ≤ (s.exchangeExponent k l + Pi.single (row k) 1 : M → ℤ) a := by
  intro a
  by_cases ha : a = row k
  · subst a
    simp [s.exchangeExponent_row]
  · simpa [Pi.single_eq_of_ne ha] using s.exchangeExponent_nonneg_of_ne k ha hl

/-- Every quantum reachable coordinate has a unique integral Laurent representative. -/
theorem existsUnique_chart_eq_coordinate_mutateWord (w : List K) (a : M) :
    ∃! f, s.toQuantumSeed.chart f =
      ((mutateWord (fun k t ↦ PolynomialQuantumSeed.mutate t k) w s).coordinate a : D) := by
  have h := s.coordinate_mutateWord_mem_chartRing w a
  rw [← s.toQuantumSeed.range_chart] at h
  obtain ⟨f, hf⟩ := h
  exact ⟨f, hf, fun g hg ↦ s.toQuantumSeed.chart_injective (hg.trans hf.symm)⟩

variable {s} (ε : AddMonoidAlgebra ℤ (M → ℤ) →+* F) {x : M → F}
  (hε : ∀ a, ε (AddMonoidAlgebra.single (Pi.single a 1) 1) = x a)
include hε

/-- Specialization commutes with every polynomial quantum mutation word. -/
theorem mutateWord_chartSpecializes (w : List K)
    (hx : ∀ u k, u ++ [k] <+: w →
      (polynomialGeometricPattern row s.degree (s.classicalData x) u).coordinate (row k) ≠ 0)
    (a : M) :
    ChartSpecializes s.toQuantumSeed.chart ε
      ((mutateWord (fun k t ↦ PolynomialQuantumSeed.mutate t k) w s).coordinate a : D)
      ((polynomialGeometricPattern row s.degree (s.classicalData x) w).coordinate a) := by
  induction w using List.reverseRecOn generalizing a with
  | nil =>
    refine ⟨QuantumTorus.monomial (Pi.single a 1), s.toQuantumSeed.monomial_single a, ?_⟩
    rw [sp_monomial, hε]
    rfl
  | append_singleton w k ih =>
    have ih := ih fun u j hu ↦ hx u j (hu.trans (List.prefix_append _ _))
    set t := mutateWord (fun k t ↦ PolynomialQuantumSeed.mutate t k) w s
    set p := polynomialGeometricPattern row s.degree (s.classicalData x) w
    have hmeta := s.mutateWord_classicalData x w
    change t.exchange.matrix = p.exchange ∧
      (fun k ↦ (t.polynomial k).map evalOne) = p.polynomial at hmeta
    have hdegree : t.degree = s.degree := funext (s.mutateWord_degree w)
    have hmut : mutateWord (fun k t ↦ PolynomialQuantumSeed.mutate t k) (w ++ [k]) s =
        t.mutate k := by rw [mutateWord_append]; rfl
    obtain ⟨f', hf', -⟩ := s.existsUnique_chart_eq_coordinate_mutateWord (w ++ [k]) a
    rw [hmut] at hf' ⊢
    rw [polynomialGeometricPattern_append]
    by_cases ha : a = row k
    · subst a
      rw [t.mutate_coordinate_row k] at hf' ⊢
      have h₁ : ChartSpecializes s.toQuantumSeed.chart ε
          (t.exchangeCoordinate k * (t.coordinate (row k) : D))
          (ε (sp _ f') * p.coordinate (row k)) := by
        rw [← hf']
        exact (ChartSpecializes.chart f').mul (ih (row k))
      have hterm : ∀ l ∈ Finset.range (t.degree k + 1),
          ChartSpecializes s.toQuantumSeed.chart ε
            (algebraMap Zv D ((t.polynomial k).coeff l) *
              (t.toQuantumSeed.monomial (t.exchangeExponent k l) * t.coordinate (row k)))
            (((p.polynomial k).coeff l : F) * ∏ a, p.coordinate a ^
              (positivePart (-p.exchange a k) + (l : ℤ) *
                (p.exchange a k / s.degree k)).toNat) := by
        intro l hl
        have hl' : l ≤ t.degree k := by have := Finset.mem_range.mp hl; omega
        have hm := t.toQuantumSeed.chartSpecializes_monomial ih
          (t.exchange_numerator_exponent_nonneg k hl')
        have hcoef := (ChartSpecializes.algebraMap ((t.polynomial k).coeff l)).mul
          (hm.vUnit_zpow_mul
            (matrixForm t.form (t.exchangeExponent k l) (Pi.single (row k) 1)))
        rw [← t.toQuantumSeed.monomial_single, t.toQuantumSeed.monomial_mul_monomial]
        convert hcoef using 1
        rw [← Polynomial.coeff_map, congrFun hmeta.2 k]
        congr 1
        apply Finset.prod_congr rfl
        intro b _
        have he : (t.exchangeExponent k l + Pi.single (row k) 1 : M → ℤ) b =
            positivePart (-p.exchange b k) + (l : ℤ) *
              (p.exchange b k / s.degree k) := by
          rw [t.exchange_numerator_exponent, hmeta.1, congrFun hdegree k]
        rw [← he, ← zpow_natCast,
          Int.toNat_of_nonneg (t.exchange_numerator_exponent_nonneg k hl' b)]
      have h₂ : ChartSpecializes s.toQuantumSeed.chart ε
          (t.exchangeCoordinate k * (t.coordinate (row k) : D))
          (polynomialGeometricNumerator s.degree p k) := by
        rw [exchangeCoordinate, Finset.sum_mul, polynomialGeometricNumerator]
        simpa only [mul_assoc, hdegree] using
          ChartSpecializes.sum (Finset.range (t.degree k + 1)) hterm
      have heq := h₁.unique s.toQuantumSeed.chart_injective h₂
      refine ⟨f', hf', ?_⟩
      rw [polynomialGeometricExchange_coordinate_row]
      exact eq_div_of_mul_eq (hx w k (List.prefix_refl _)) heq
    · rw [t.mutate_coordinate_of_ne k ha,
        polynomialGeometricExchange_coordinate_of_ne row s.degree p k ha]
      exact ih a

/-- The unique quantum Laurent representative specializes to the classical coordinate. -/
theorem eval_sp_eq_polynomialGeometricPattern (w : List K)
    (hx : ∀ u k, u ++ [k] <+: w →
      (polynomialGeometricPattern row s.degree (s.classicalData x) u).coordinate (row k) ≠ 0)
    (a : M) (f : quantumTorus Zv vUnit (matrixForm s.form))
    (hf : s.toQuantumSeed.chart f =
      ((mutateWord (fun k t ↦ PolynomialQuantumSeed.mutate t k) w s).coordinate a : D)) :
    ε (sp _ f) = (polynomialGeometricPattern row s.degree (s.classicalData x) w).coordinate a :=
  (ChartSpecializes.chart f).unique s.toQuantumSeed.chart_injective
    (hf ▸ mutateWord_chartSpecializes (s := s) ε hε w hx a)

end PolynomialQuantumSeed
end
end TauCeti.Cluster
