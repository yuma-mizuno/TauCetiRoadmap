import Mathlib.Analysis.Normed.Module.FiniteDimension
import Mathlib.LinearAlgebra.Dual.Lemmas
import Mathlib.LinearAlgebra.AffineSpace.AffineSubspace.Defs
import Mathlib.LinearAlgebra.FiniteDimensional.Lemmas
import Mathlib.Tactic.Module

/-!
# Transverse sweeps

The support is exactly `P - ℝ≥0 n`, as in README §1.4. We construct a separating
linear functional from transversality, recover the sweep parameter uniquely,
and prove closedness and strict outgoingness. Closedness of a Minkowski sum
is not used as an unproved general principle.
-/

set_option autoImplicit false

namespace TauCetiRoadmap.ScatteringDiagrams.Formalized
namespace SweepGeometry

variable {V : Type*} [AddCommGroup V] [Module ℝ V]

def sweepSupport (P : Set V) (n : V) : Set V :=
  {y | ∃ x ∈ P, ∃ t : ℝ, 0 ≤ t ∧ y = x - t • n}

theorem subset_sweepSupport (P : Set V) (n : V) : P ⊆ sweepSupport P n := by
  intro x hx
  exact ⟨x, hx, 0, le_rfl, by simp⟩

/-- Transversality supplies a height function equal to a constant on the base
and equal to one on the sweeping vector. No finite-dimensionality is needed. -/
theorem exists_height {P : Set V} {n : V} (hP : P.Nonempty)
    (hn : n ∉ vectorSpan ℝ P) :
    ∃ (f : V →ₗ[ℝ] ℝ) (c : ℝ), f n = 1 ∧ ∀ x ∈ P, f x = c := by
  obtain ⟨f, hfn, hf⟩ := Submodule.exists_dual_map_eq_bot_of_notMem hn inferInstance
  obtain ⟨p, hp⟩ := hP
  refine ⟨(f n)⁻¹ • f, (f n)⁻¹ * f p, ?_, ?_⟩
  · simp [hfn]
  · intro x hx
    have h : f (x - p) = 0 := by
      have hmem : f (x - p) ∈ (vectorSpan ℝ P).map f :=
        Submodule.mem_map_of_mem (vsub_mem_vectorSpan ℝ hx hp)
      rwa [hf, Submodule.mem_bot] at hmem
    have heq : f x = f p := sub_eq_zero.mp (by simpa only [map_sub] using h)
    simp [heq]

/-- A normalized height functional gives an explicit inverse to the sweep
parameterization, expressed without an existentially chosen intersection time. -/
theorem mem_sweepSupport_iff {P : Set V} {n y : V} (f : V →ₗ[ℝ] ℝ) (c : ℝ)
    (hfn : f n = 1) (hfP : ∀ x ∈ P, f x = c) :
    y ∈ sweepSupport P n ↔ f y ≤ c ∧ y + (c - f y) • n ∈ P := by
  constructor
  · rintro ⟨x, hx, t, ht, rfl⟩
    have he : f (x - t • n) = c - t := by simp [hfP x hx, hfn]
    rw [he]
    refine ⟨sub_le_self _ ht, ?_⟩
    convert hx using 1
    module
  · rintro ⟨hy, hx⟩
    refine ⟨y + (c - f y) • n, hx, c - f y, sub_nonneg.mpr hy, ?_⟩
    module

theorem sweep_parameter_unique {P : Set V} {n : V} (hn : n ∉ vectorSpan ℝ P)
    {x x' : V} (hx : x ∈ P) (hx' : x' ∈ P) {t t' : ℝ}
    (h : x - t • n = x' - t' • n) : x = x' ∧ t = t' := by
  obtain ⟨f, c, hfn, hfP⟩ := exists_height ⟨x, hx⟩ hn
  have hheight := congrArg f h
  simp only [map_sub, map_smul, hfP x hx, hfP x' hx', hfn, smul_eq_mul,
    mul_one, sub_right_inj] at hheight
  subst t'
  exact ⟨sub_left_inj.mp h, rfl⟩

/-- The positive ray through any base point leaves the entire swept support. -/
theorem positive_translate_notMem {P : Set V} {n x : V}
    (hn : n ∉ vectorSpan ℝ P) (hx : x ∈ P) {t : ℝ} (ht : 0 < t) :
    x + t • n ∉ sweepSupport P n := by
  obtain ⟨f, c, hfn, hfP⟩ := exists_height ⟨x, hx⟩ hn
  intro h
  have hle := ((mem_sweepSupport_iff f c hfn hfP).mp h).1
  have : c + t ≤ c := by simpa [hfP x hx, hfn] using hle
  exact (not_le_of_gt (lt_add_of_pos_right c ht)) this

/-- The swept support is strictly outgoing in the exact definition of §3.2. -/
theorem sweep_strictlyOutgoing {P : Set V} {n : V} (hP : P.Nonempty)
    (hn : n ∉ vectorSpan ℝ P) :
    ¬ ∀ x ∈ sweepSupport P n, ∀ t : ℝ, 0 ≤ t → x + t • n ∈ sweepSupport P n := by
  intro h
  obtain ⟨x, hx⟩ := hP
  exact positive_translate_notMem hn hx zero_lt_one
    (h x (subset_sweepSupport P n hx) 1 zero_le_one)

/-- Sweeping a nonempty set never produces the empty set. -/
theorem sweep_nonempty {P : Set V} (hP : P.Nonempty) (n : V) :
    (sweepSupport P n).Nonempty := hP.mono (subset_sweepSupport P n)

/-- Subdivision covers remain covers after sweeping. -/
theorem sweep_iUnion {ι : Sort*} (P : ι → Set V) (n : V) :
    sweepSupport (⋃ i, P i) n = ⋃ i, sweepSupport (P i) n := by
  ext y
  simp only [sweepSupport, Set.mem_ofPred_eq, Set.mem_iUnion]
  constructor
  · rintro ⟨x, ⟨i, hx⟩, t, ht, he⟩
    exact ⟨i, x, hx, t, ht, he⟩
  · rintro ⟨i, x, hx, t, ht, he⟩
    exact ⟨x, ⟨i, hx⟩, t, ht, he⟩

/-- On a transverse common base, sweeping does not create intersections
between distinct base pieces. This is needed for subdivision relations. -/
theorem sweep_inter {P Q : Set V} {n : V} (hn : n ∉ vectorSpan ℝ (P ∪ Q)) :
    sweepSupport P n ∩ sweepSupport Q n = sweepSupport (P ∩ Q) n := by
  ext y
  constructor
  · rintro ⟨⟨x, hx, t, ht, he⟩, ⟨x', hx', t', ht', he'⟩⟩
    have hxx := (sweep_parameter_unique hn (Or.inl hx) (Or.inr hx')
      (he.symm.trans he')).1
    exact ⟨x, ⟨hx, hxx ▸ hx'⟩, t, ht, he⟩
  · rintro ⟨x, ⟨hx, hx'⟩, t, ht, he⟩
    exact ⟨⟨x, hx, t, ht, he⟩, ⟨x, hx', t, ht, he⟩⟩

/-- The affine direction gains exactly the sweeping vector, even for sets
with lineality or unbounded support. -/
theorem vectorSpan_sweepSupport {P : Set V} (hP : P.Nonempty) (n : V) :
    vectorSpan ℝ (sweepSupport P n) = vectorSpan ℝ P ⊔ Submodule.span ℝ {n} := by
  apply le_antisymm
  · rw [vectorSpan_def]
    apply Submodule.span_le.mpr
    rintro v ⟨a, ha, b, hb, rfl⟩
    obtain ⟨x, hx, t, ht, rfl⟩ := ha
    obtain ⟨y, hy, s, hs, rfl⟩ := hb
    have hbase : x - y ∈ vectorSpan ℝ P ⊔ Submodule.span ℝ {n} :=
      (le_sup_left : vectorSpan ℝ P ≤ _)
        (vsub_mem_vectorSpan ℝ hx hy)
    have hn : n ∈ vectorSpan ℝ P ⊔ Submodule.span ℝ {n} :=
      (le_sup_right : Submodule.span ℝ {n} ≤ _) (Submodule.subset_span (Set.mem_singleton n))
    have hh := (vectorSpan ℝ P ⊔ Submodule.span ℝ {n}).add_mem hbase
      ((vectorSpan ℝ P ⊔ Submodule.span ℝ {n}).smul_mem (s - t) hn)
    change (x - t • n) - (y - s • n) ∈ _
    have he : (x - t • n) - (y - s • n) = x - y + (s - t) • n := by module
    rw [he]
    exact hh
  · apply sup_le (vectorSpan_mono ℝ (subset_sweepSupport P n))
    rw [Submodule.span_singleton_le_iff_mem]
    obtain ⟨x, hx⟩ := hP
    have hy : x - n ∈ sweepSupport P n := ⟨x, hx, 1, zero_le_one, by simp⟩
    simpa using vsub_mem_vectorSpan ℝ (subset_sweepSupport P n hx) hy

end SweepGeometry

namespace SweepGeometry

variable {V : Type*} [NormedAddCommGroup V] [NormedSpace ℝ V] [FiniteDimensional ℝ V]

/-- A transverse sweep of a closed set is closed. The proof uses the explicit
height formula; it does not assume compactness, boundedness, or salience. -/
theorem isClosed_sweepSupport {P : Set V} {n : V} (hP : IsClosed P)
    (hn : n ∉ vectorSpan ℝ P) : IsClosed (sweepSupport P n) := by
  rcases P.eq_empty_or_nonempty with he | hne
  · subst P
    simp [sweepSupport]
  · obtain ⟨f, c, hfn, hfP⟩ := exists_height hne hn
    have he : sweepSupport P n = {y | f y ≤ c} ∩
        (fun y => y + (c - f y) • n) ⁻¹' P := by
      ext y
      exact mem_sweepSupport_iff f c hfn hfP
    rw [he]
    exact (isClosed_le f.continuous_of_finiteDimensional continuous_const).inter
      (hP.preimage (continuous_id.add
        ((continuous_const.sub f.continuous_of_finiteDimensional).smul continuous_const)))

/-- Sweeping a transverse support lowers its codimension by exactly one. -/
theorem finrank_sweepSupport {P : Set V} {n : V} (hP : P.Nonempty)
    (hn : n ∉ vectorSpan ℝ P) :
    Module.finrank ℝ (vectorSpan ℝ (sweepSupport P n)) =
      Module.finrank ℝ (vectorSpan ℝ P) + 1 := by
  rw [vectorSpan_sweepSupport hP n]
  exact Submodule.finrank_sup_span_singleton hn

end SweepGeometry
end TauCetiRoadmap.ScatteringDiagrams.Formalized
