import Mathlib.Analysis.Convex.Segment
import Mathlib.Basic.Real.Basic
import Mathlib.Tactic.Linarith

/-!
# Escape from outgoing polyhedral supports

README §3.4 uses a separating halfspace and a far translated transverse
segment. The separation follows directly from the inequalities defining the
polyhedron. All signs and the uniformity over the whole segment are explicit.
This does not assert the subsequent path-product rectangle argument.
-/

set_option autoImplicit false

namespace TauCetiRoadmap.ScatteringDiagrams.Formalized
namespace OutgoingGeometry

variable {V I : Type*} [AddCommGroup V] [Module ℝ V]

/-- The inequalities defining an outgoing support contain a normal positive
on its forward direction. The conclusion refers to an actual defining
inequality, not an unspecified separation hypothesis. -/
theorem outgoing_has_separator (f : I → V →ₗ[ℝ] ℝ) (c : I → ℝ) (n : V)
    (hout : ¬ ∀ x : V, (∀ i, f i x ≤ c i) →
      ∀ t : ℝ, 0 ≤ t → ∀ i, f i (x + t • n) ≤ c i) :
    ∃ i, 0 < f i n := by
  by_contra h
  push Not at h
  apply hout
  intro x hx t ht i
  have htn := mul_nonpos_of_nonneg_of_nonpos ht (h i)
  simp only [map_add, map_smul, smul_eq_mul]
  linarith [hx i]

/-- A forward translate of an entire segment eventually lies strictly beyond
one halfspace. The bound is uniform in the segment parameter. -/
theorem segment_escape (f : V →ₗ[ℝ] ℝ) (c : ℝ) {n : V} (hn : 0 < f n) (a b : V) :
    ∃ T : ℝ, 0 < T ∧ ∀ t, T ≤ t → ∀ s : ℝ, 0 ≤ s → s ≤ 1 →
      c < f (((1 - s) • a + s • b) + t • n) := by
  let lo := min (f a) (f b)
  let T := max 0 ((c - lo) / f n) + 1
  refine ⟨T, by dsimp [T]; linarith [le_max_left 0 ((c - lo) / f n)], ?_⟩
  intro t ht s hs hs1
  have hfrac : (c - lo) / f n < t := by
    dsimp [T] at ht
    linarith [le_max_right 0 ((c - lo) / f n)]
  have htf : c - lo < t * f n := (div_lt_iff₀ hn).mp hfrac
  have ha : lo ≤ f a := min_le_left _ _
  have hb : lo ≤ f b := min_le_right _ _
  have h1 := mul_nonneg (sub_nonneg.mpr hs1) (sub_nonneg.mpr ha)
  have h2 := mul_nonneg hs (sub_nonneg.mpr hb)
  simp only [map_add, map_smul, smul_eq_mul]
  nlinarith

/-- The same uniform bound excludes the translated segment from the actual
polyhedron, using the separator constructed from outgoingness. -/
theorem outgoing_segment_escape (f : I → V →ₗ[ℝ] ℝ) (c : I → ℝ) (n a b : V)
    (hout : ¬ ∀ x : V, (∀ i, f i x ≤ c i) →
      ∀ t : ℝ, 0 ≤ t → ∀ i, f i (x + t • n) ≤ c i) :
    ∃ T : ℝ, 0 < T ∧ ∀ t, T ≤ t → ∀ s : ℝ, 0 ≤ s → s ≤ 1 →
      ¬ ∀ i, f i (((1 - s) • a + s • b) + t • n) ≤ c i := by
  obtain ⟨i, hi⟩ := outgoing_has_separator f c n hout
  obtain ⟨T, hT, hescape⟩ := segment_escape (f i) (c i) hi a b
  refine ⟨T, hT, ?_⟩
  intro t ht s hs hs1 hmem
  exact (not_le_of_gt (hescape t ht s hs hs1)) (hmem i)

/-- Finitely many outgoing supports admit a common escape time. The family
may be empty; the bound remains strictly positive in that case. -/
theorem finite_outgoing_segment_escape {J : Type*} (s : Finset J)
    (f : J → I → V →ₗ[ℝ] ℝ) (c : J → I → ℝ) (n a b : V)
    (hout : ∀ j ∈ s, ¬ ∀ x : V, (∀ i, f j i x ≤ c j i) →
      ∀ t : ℝ, 0 ≤ t → ∀ i, f j i (x + t • n) ≤ c j i) :
    ∃ T : ℝ, 0 < T ∧ ∀ t, T ≤ t → ∀ j ∈ s, ∀ r : ℝ, 0 ≤ r → r ≤ 1 →
      ¬ ∀ i, f j i (((1 - r) • a + r • b) + t • n) ≤ c j i := by
  classical
  induction s using Finset.induction_on with
  | empty => exact ⟨1, zero_lt_one, by simp⟩
  | @insert j s hj ih =>
    have hs : ∀ l ∈ s, ¬ ∀ x : V, (∀ i, f l i x ≤ c l i) →
        ∀ t : ℝ, 0 ≤ t → ∀ i, f l i (x + t • n) ≤ c l i :=
      fun l hl => hout l (Finset.mem_insert_of_mem hl)
    obtain ⟨T, hT, hTs⟩ := ih hs
    obtain ⟨U, hU, hUj⟩ := outgoing_segment_escape (f j) (c j) n a b
      (hout j (Finset.mem_insert_self j s))
    refine ⟨max T U, lt_of_lt_of_le hT (le_max_left T U), ?_⟩
    intro t ht l hl r hr hr1
    rcases Finset.mem_insert.mp hl with he | hl
    · subst l
      exact hUj t ((le_max_right T U).trans ht) r hr hr1
    · exact hTs t ((le_max_left T U).trans ht) l hl r hr hr1

end OutgoingGeometry
end TauCetiRoadmap.ScatteringDiagrams.Formalized
