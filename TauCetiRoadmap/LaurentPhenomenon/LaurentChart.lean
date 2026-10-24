/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.LaurentEvaluation
public import TauCetiRoadmap.LaurentPhenomenon.Chart

/-! # Laurent Chart -/

@[expose] public section

noncomputable section
namespace TauCeti.Laurent.LaurentEvaluation
open scoped BigOperators
variable {R F I : Type*} [CommRing R] [Field F]

private theorem unit_power_mem_chart (c : R →+* F) (u : I → Fˣ) (i : I) (n : ℤ) :
    ((u i ^ n : Fˣ) : F) ∈ chartRing c.range (fun i => (u i : F)) := by
  cases n with
  | ofNat n =>
    simpa using (chartRing c.range (fun i => (u i : F))).pow_mem
      (coordinate_mem_chartRing c.range (fun i => (u i : F)) i) n
  | negSucc n =>
    simpa [zpow_negSucc] using (chartRing c.range (fun i => (u i : F))).pow_mem
      (inverse_mem_chartRing c.range (fun i => (u i : F)) i) (n + 1)

/-- Evaluating a Laurent polynomial produces an element of the chart generated
by coefficient values, assigned coordinates, and their inverses. -/
theorem eval_mem_chart (c : R →+* F) (u : I → Fˣ) (p : Ring R I) :
    eval c u p ∈ chartRing c.range (fun i => (u i : F)) := by
  classical
  rw [← AddMonoidAlgebra.sum_coeff_single p]
  simp only [Finsupp.sum, map_sum]
  apply Subring.sum_mem
  intro a ha
  rw [eval_single_product]
  apply Subring.mul_mem
  · exact coefficient_mem_chartRing c.range _ ⟨_, rfl⟩
  · apply Subring.prod_mem
    intro i hi
    exact unit_power_mem_chart c u i (a i)

/-- The concrete Laurent chart is exactly the image of Laurent evaluation. -/
theorem chart_eq_range (c : R →+* F) (u : I → Fˣ) :
    chartRing c.range (fun i => (u i : F)) = (eval c u).range := by
  apply le_antisymm
  · apply chartRing_le
    · rintro y ⟨r, rfl⟩
      exact ⟨AddMonoidAlgebra.single 0 r, eval_constant c u r⟩
    · intro i
      exact ⟨AddMonoidAlgebra.single (Finsupp.single i 1) 1, by simp⟩
    · intro i
      exact ⟨AddMonoidAlgebra.single (Finsupp.single i (-1)) 1, by simp⟩
  · rintro y ⟨p, rfl⟩
    exact eval_mem_chart c u p

/-- Membership in a Laurent chart supplies a finite Laurent representative. -/
theorem mem_chart_iff_exists (c : R →+* F) (u : I → Fˣ) (y : F) :
    y ∈ chartRing c.range (fun i => (u i : F)) ↔ ∃ p : Ring R I, eval c u p = y := by
  rw [chart_eq_range]
  rfl

/-- Uniqueness is available precisely when the chosen evaluation is injective. -/
theorem unique_representative (c : R →+* F) (u : I → Fˣ)
    (hinj : Function.Injective (eval c u)) {y : F}
    (hy : y ∈ chartRing c.range (fun i => (u i : F))) :
    ∃! p : Ring R I, eval c u p = y := by
  obtain ⟨p, hp⟩ := (mem_chart_iff_exists c u y).mp hy
  exact ⟨p, hp, fun q hq => hinj (hq.trans hp.symm)⟩

end TauCeti.Laurent.LaurentEvaluation
