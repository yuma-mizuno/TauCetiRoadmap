import TauCetiRoadmap.ScatteringDiagrams.Formalized.RankTwoSweepConnection

/-!
# Geometric tests for two specification boundaries

The source simplex definitions are used directly. A positively oriented triangle
can contain both endpoints of a wall segment while its boundary misses the wall.
Thus transverse incidence with a chosen joint and incidence only with walls
containing that joint do not express locality. This file checks that geometric
witness; it does not construct a complete `ChamberTrivialization` countermodel.

Cutting a transverse interval at its intersection with a point also shows why
subdivision invariance must be restricted to subdivisions in general position.
-/

set_option autoImplicit false

namespace TauCetiRoadmap.ScatteringDiagrams.Formalized.SpecificationStress

open TauCetiRoadmap.ScatteringDiagrams
open RankTwoSweepConnection (Plane area)

def triangle : Fin 3 → Plane := ![![-2, -2], ![4, -2], ![-2, 4]]
def wall : Set Plane := {x | 0 ≤ x 0 ∧ x 0 ≤ 1 ∧ x 1 = 0}
def joint (r : ℝ) : Plane := ![r, 0]

theorem simplex_coordinates (t : Fin 3 → ℝ) :
    simplexMap triangle t =
      ![-2 * t 0 + 4 * t 1 - 2 * t 2, -2 * t 0 - 2 * t 1 + 4 * t 2] := by
  ext j
  fin_cases j <;> simp [simplexMap, triangle, Fin.sum_univ_succ] <;> ring

theorem triangle_positive : 0 < area (edgeVectors triangle) := by
  change 0 < Matrix.det (edgeVectors triangle)
  have he : edgeVectors triangle = (!![6, 0; 0, 6] : Matrix (Fin 2) (Fin 2) ℝ) := by
    ext j l; fin_cases j <;> fin_cases l <;> norm_num [edgeVectors, triangle]
  rw [he, Matrix.det_fin_two]
  norm_num

theorem joint_in_wall {r : ℝ} (h0 : 0 ≤ r) (h1 : r ≤ 1) : joint r ∈ wall := by
  exact ⟨h0, h1, rfl⟩

/-- Both distinct endpoints, and the entire wall, lie strictly inside the triangle. -/
theorem joint_strictly_inside {r : ℝ} (h0 : 0 ≤ r) (h1 : r ≤ 1) :
    ∃ t ∈ paramSimplex 2, (∀ j, 0 < t j) ∧ simplexMap triangle t = joint r := by
  refine ⟨![(2-r)/6, (r+2)/6, 1/3], ?_, ?_, ?_⟩
  · constructor
    · intro j; fin_cases j <;> simp <;> linarith
    · simp [Fin.sum_univ_succ]; ring
  · intro j; fin_cases j <;> simp <;> linarith
  · rw [simplex_coordinates]
    ext j; fin_cases j <;> simp [joint] <;> ring

/-- In particular the boundary is admissible for the single wall: it never meets it. -/
theorem triangle_faces_avoid_wall {t : Fin 3 → ℝ} (ht : t ∈ paramSimplex 2)
    (hz : ∃ j, t j = 0) : simplexMap triangle t ∉ wall := by
  intro hw
  obtain ⟨hn, hs⟩ := ht
  have hs' : t 0 + t 1 + t 2 = 1 := by
    simpa [Fin.sum_univ_succ, add_assoc] using hs
  rw [simplex_coordinates] at hw
  change 0 ≤ -2*t 0 + 4*t 1 - 2*t 2 ∧
    -2*t 0 + 4*t 1 - 2*t 2 ≤ 1 ∧ -2*t 0 - 2*t 1 + 4*t 2 = 0 at hw
  obtain ⟨j, hj⟩ := hz
  fin_cases j <;> simp at hj <;> obtain ⟨ha, hb, hc⟩ := hw <;> linarith

theorem triangle_edges_span : Submodule.span ℝ (Set.range (edgeVectors triangle)) = ⊤ := by
  rw [eq_top_iff]
  intro x _
  have h0 := Submodule.subset_span (R := ℝ) (Set.mem_range_self (f := edgeVectors triangle) 0)
  have h1 := Submodule.subset_span (R := ℝ) (Set.mem_range_self (f := edgeVectors triangle) 1)
  have h := Submodule.add_mem _ (Submodule.smul_mem _ (x 0 / 6) h0)
    (Submodule.smul_mem _ (x 1 / 6) h1)
  convert h using 1
  ext j; fin_cases j <;> simp [edgeVectors, triangle] <;> ring

/-- Transversality to either point does not exclude the other point. -/
theorem triangle_transverse_point {N : Type*} [AddCommGroup N] {i : N →+ Plane}
    (σ : OrientedCell i 2) {r : ℝ} (hσ : σ.carrier = {joint r})
    (h0 : 0 ≤ r) (h1 : r ≤ 1) : IsTransverseSimplex triangle σ := by
  constructor
  · rw [triangle_edges_span, sup_top_eq]
  · intro t ht hz hp
    rw [hσ, Set.mem_singleton_iff] at hp
    exact triangle_faces_avoid_wall ht hz (hp ▸ joint_in_wall h0 h1)
  · simp [hσ, intrinsicFrontier_singleton]

theorem two_distinct_joints_inside :
    joint 0 ≠ joint 1 ∧
    (∃ t ∈ paramSimplex 2, simplexMap triangle t = joint 0) ∧
    (∃ t ∈ paramSimplex 2, simplexMap triangle t = joint 1) := by
  refine ⟨?_, ?_, ?_⟩
  · intro h; have h' := congrFun h 0; norm_num [joint] at h'
  · obtain ⟨t, ht, _, he⟩ := joint_strictly_inside (r := 0) (by norm_num) (by norm_num)
    exact ⟨t, ht, he⟩
  · obtain ⟨t, ht, _, he⟩ := joint_strictly_inside (r := 1) (by norm_num) (by norm_num)
    exact ⟨t, ht, he⟩

/-- The interval before cutting meets the point at an interior parameter. -/
theorem whole_interval_intersection :
    (![1/2, 1/2] : Fin 2 → ℝ) ∈ paramSimplex 1 ∧
    simplexMap ![(-1 : ℝ), 1] ![1/2, 1/2] = 0 ∧
    ∀ j : Fin 2, (![1/2, 1/2] : Fin 2 → ℝ) j ≠ 0 := by
  norm_num [paramSimplex, simplexMap, Fin.forall_fin_two, Fin.sum_univ_succ]
  intro j; fin_cases j <;> norm_num

/-- Cutting at the intersection puts that intersection on the boundary of BOTH pieces. -/
theorem cut_intersection_on_both_boundaries :
    (![0, 1] : Fin 2 → ℝ) ∈ paramSimplex 1 ∧
    simplexMap ![(-1 : ℝ), 0] ![0, 1] = 0 ∧
    (![1, 0] : Fin 2 → ℝ) ∈ paramSimplex 1 ∧
    simplexMap ![(0 : ℝ), 1] ![1, 0] = 0 := by
  norm_num [paramSimplex, simplexMap, Fin.forall_fin_two, Fin.sum_univ_succ]
  constructor <;> intro j <;> fin_cases j <;> norm_num

theorem cut_tests_not_transverse {N : Type*} [AddCommGroup N] {i : N →+ ℝ}
    (σ : OrientedCell i 1) (hσ : σ.carrier = {0}) :
    ¬ IsTransverseSimplex ![(-1 : ℝ), 0] σ ∧
    ¬ IsTransverseSimplex ![(0 : ℝ), 1] σ := by
  obtain ⟨hL, heL, hR, heR⟩ := cut_intersection_on_both_boundaries
  constructor
  · intro h
    exact h.faces_avoid _ hL ⟨0, rfl⟩ (by rw [heL, hσ]; exact Set.mem_singleton 0)
  · intro h
    exact h.faces_avoid _ hR ⟨1, rfl⟩ (by rw [heR, hσ]; exact Set.mem_singleton 0)

end TauCetiRoadmap.ScatteringDiagrams.Formalized.SpecificationStress
