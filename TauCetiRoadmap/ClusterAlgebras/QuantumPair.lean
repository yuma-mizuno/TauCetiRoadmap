/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.ExchangeFrame
public import TauCetiRoadmap.LaurentPhenomenon.ExchangeRings

/-!
# Two mutable directions of a quantum seed

For distinct mutable directions `i, j` of a quantum seed, `pairRing` is the chart ring of the
coordinates other than `X_i, X_j`, and `fourRing` is `C⟨X_i, X'_i, X_j, X'_j⟩` inside the
ambient division ring, the four-generator ring `TauCeti.Laurent.fourRing` of the classical route.
The two-direction comparison (Q2) identifies `fourRing` with the intersection of the two
adjacent one-exchange intersections.
-/

@[expose] public section

namespace TauCeti.Cluster.ExchangeFrame

open TauCeti TauCeti.QuantumTorus TauCeti.Laurent

variable {R₀ : Type*} [CommRing R₀] {u₀ : R₀ˣ}
  {D : Type*} [DivisionRing D] [Algebra R₀ D]
  {M K : Type*} [Fintype M] [DecidableEq M] {row : K ↪ M}
  (s : ExchangeFrame (u₀ := u₀) D row)

/-- The chart ring of the coordinates other than `a` and `b`. -/
noncomputable def pairRing (a b : M) : Subring D :=
  Laurent.chartRing (algebraMap R₀ D).range (fun j : {j // j ≠ a ∧ j ≠ b} ↦ (s.coordinate j : D))

theorem algebraMap_mem_pairRing (a b : M) (r : R₀) : algebraMap R₀ D r ∈ s.pairRing a b :=
  coefficient_mem_chartRing _ _ ⟨r, rfl⟩

/-- A normalized monomial without `X_a` and `X_b` lies in `pairRing a b`. -/
theorem monomial_mem_pairRing {a b : M} {e : M → ℤ} (ha : e a = 0) (hb : e b = 0) :
    s.monomial e ∈ s.pairRing a b := by
  have hl : ∀ l : List M, ((orderedProd s.coordinate l e : Dˣ) : D) ∈ s.pairRing a b := by
    intro l
    induction l with
    | nil => exact Subring.one_mem _
    | cons c l ih =>
      rw [orderedProd_cons, Units.val_mul]
      refine Subring.mul_mem _ ?_ ih
      by_cases hc : c = a ∨ c = b
      · have h0 : e c = 0 := by rcases hc with rfl | rfl <;> assumption
        rw [h0, zpow_zero, Units.val_one]
        exact Subring.one_mem _
      · obtain ⟨hca, hcb⟩ := not_or.1 hc
        rw [Units.val_zpow_eq_zpow_val]
        exact coordinate_zpow_mem_chartRing _
          (fun j : {j // j ≠ a ∧ j ≠ b} ↦ (s.coordinate j : D)) ⟨c, hca, hcb⟩ (e c)
  rw [monomial, chart, lift_monomial, normalizedProd, Algebra.smul_def]
  exact Subring.mul_mem _ (s.algebraMap_mem_pairRing a b _) (hl _)

/-- Every coordinate normalizes `pairRing a b`. -/
theorem coordinate_normalizes_pairRing (a b c : M) :
    Normalizes (s.pairRing a b) (s.coordinate c : D) := by
  have h := normalizes_closure (R := R₀) (C := (algebraMap R₀ D).range)
    (T := Set.range (fun j : {j // j ≠ a ∧ j ≠ b} ↦ (s.coordinate j : D)) ∪
      Set.range (fun j : {j // j ≠ a ∧ j ≠ b} ↦ (s.coordinate j : D)⁻¹))
    (normalizes_algebraMap_range (Units.ne_zero (s.coordinate c))) (fun r ↦ ⟨r, rfl⟩) ?_
  · rwa [← Set.union_assoc] at h
  rintro g (⟨j, rfl⟩ | ⟨j, rfl⟩)
  · exact ⟨_, by rw [s.quasiCommuting c j, Algebra.smul_def]⟩
  · refine ⟨u₀ ^ (2 * matrixForm s.form (Pi.single c 1) (-Pi.single (j : M) 1)), ?_⟩
    dsimp only
    rw [← s.monomial_neg_single, ← s.monomial_single c, monomial_mul_monomial_comm]

theorem pairRing_comm (a b : M) : s.pairRing a b = s.pairRing b a :=
  chartRing_congr_range _ <| by
    ext z
    constructor
    · rintro ⟨⟨j, ha, hb⟩, rfl⟩; exact ⟨⟨j, hb, ha⟩, rfl⟩
    · rintro ⟨⟨j, hb, ha⟩, rfl⟩; exact ⟨⟨j, ha, hb⟩, rfl⟩

/-- Regrouping the coordinates other than `a` around a second coordinate `b`. -/
theorem otherRing_eq_regroup {a b : M} (hba : b ≠ a) :
    s.otherRing a = Laurent.chartRing (s.pairRing a b) (fun _ : Unit ↦ (s.coordinate b : D)) := by
  rw [otherRing, OneExchange.otherCoordinateRing,
    OneExchange.chartRing_regroup _ _ (⟨b, hba⟩ : {j // j ≠ a})]
  congr 1
  rw [OneExchange.otherCoordinateRing, pairRing]
  apply chartRing_congr_range
  ext z
  constructor
  · rintro ⟨⟨⟨j, hja⟩, hjb⟩, rfl⟩
    exact ⟨⟨j, hja, fun h ↦ hjb (Subtype.ext h)⟩, rfl⟩
  · rintro ⟨⟨j, hja, hjb⟩, rfl⟩
    exact ⟨⟨⟨j, hja⟩, fun h ↦ hjb (congrArg Subtype.val h)⟩, rfl⟩

variable [Fintype K] [DecidableEq K]

/-- `C⟨X_i, X'_i, X_j, X'_j⟩` for mutable directions `i, j`. -/
noncomputable def fourRing (i j : K) : Subring D :=
  TauCeti.Laurent.fourRing (s.pairRing (row i) (row j)) (s.coordinate (row i) : D)
    (s.exchangeCoordinate i) (s.coordinate (row j) : D) (s.exchangeCoordinate j)

end TauCeti.Cluster.ExchangeFrame
