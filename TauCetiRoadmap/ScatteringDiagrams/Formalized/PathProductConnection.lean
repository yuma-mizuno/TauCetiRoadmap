import TauCetiRoadmap.ScatteringDiagrams.Suggested
import Mathlib.Algebra.BigOperators.Group.List.Lemmas

/-!
# Connecting the two actual path-product definitions

This module imports the prototype to test its exact carriers and definitions.
None of its admitted theorems is used. `AxiomAudit` follows the dependencies of
every declaration here, so importing the prototype cannot conceal an admitted
proof in this test.
-/

set_option autoImplicit false

namespace TauCetiRoadmap.ScatteringDiagrams.Formalized.PathProductConnection

open TauCetiRoadmap.ScatteringDiagrams

/-- Equal kernels of nonzero integral characters give integral proportionality.
No primitive-normal normalization, field division, or saturated lattice is assumed. -/
theorem characters_proportional {Λ : Type*} [AddCommGroup Λ]
    (m m' : Λ →+ ℤ) (hm : m ≠ 0)
    (hk : ∀ v, m v = 0 ↔ m' v = 0) :
    ∃ a b : ℤ, a ≠ 0 ∧ b ≠ 0 ∧ a • m = b • m' := by
  obtain ⟨u, hu⟩ : ∃ u, m u ≠ 0 := by
    by_contra h
    push Not at h
    exact hm (AddMonoidHom.ext h)
  refine ⟨m' u, m u, fun h => hu ((hk u).mpr h), hu, ?_⟩
  ext v
  have he : m (m u • v - m v • u) = 0 := by
    simp only [map_sub, map_zsmul, zsmul_eq_mul, Int.cast_id]
    ring
  have he' := (hk _).mp he
  simp only [map_sub, map_zsmul, zsmul_eq_mul, Int.cast_id, sub_eq_zero] at he'
  change m' u * m v = m u * m' v
  calc
    m' u * m v = m v * m' u := mul_comm _ _
    _ = m u * m' v := he'.symm

variable {L Λ V : Type*} [AddCommGroup L] [AddCommGroup Λ]
  [NormedAddCommGroup V] [NormedSpace ℝ V]
  {i : Λ →+ V} {hi : TauCeti.Toric.IsIntegralLattice i}
  {ρ : L →+ Λ} {D : PositiveDegrees L} {G : Type*} [Group G]
  {wallGroup : L → (Λ →+ ℤ) → Subgroup G}
  {K : OrderFiltration G} {ι : Type*}
  (𝔇 : DirectedDiagram hi ρ D wallGroup K ι)

theorem normals_proportional (d e : ι)
    (h : affineDir (𝔇.wall d).support = affineDir (𝔇.wall e).support) :
    ∃ a b : ℤ, a ≠ 0 ∧ b ≠ 0 ∧ a • (𝔇.wall d).normal = b • (𝔇.wall e).normal := by
  apply characters_proportional _ _ (𝔇.wall d).normal_ne_zero
  have hker : LinearMap.ker (hi.realCharacter (𝔇.wall d).normal) =
      LinearMap.ker (hi.realCharacter (𝔇.wall e).normal) := by
    rw [← (𝔇.wall d).support_direction, ← (𝔇.wall e).support_direction]
    exact h
  intro v
  have hmem := SetLike.ext_iff.mp hker (i v)
  simpa only [LinearMap.mem_ker, hi.realCharacter_apply, Int.cast_eq_zero] using hmem

theorem signedFactor_commute_of_direction_eq (d e : ι) (v w : V)
    (h : affineDir (𝔇.wall d).support = affineDir (𝔇.wall e).support) :
    Commute ((𝔇.wall d).signedFactor v) ((𝔇.wall e).signedFactor w) := by
  obtain ⟨a, b, ha, hb, hab⟩ := normals_proportional 𝔇 d e h
  have hc := 𝔇.parallel_commute _ _ _ _ (𝔇.wall d).normal_ne_zero
    (𝔇.wall e).normal_ne_zero a b ha hb hab
    (𝔇.wall d).label (𝔇.wall d).label.property (𝔇.wall e).label (𝔇.wall e).label.property
  unfold DirectedWall.signedFactor
  split_ifs <;> first | exact hc | exact hc.inv_left | exact hc.inv_right |
    exact hc.inv_left.inv_right | exact Commute.one_left _ | exact Commute.one_right _

/-- Joint avoidance supplies commuting factors at a regular crossing; this is
deduced from the actual admissibility fields, not supplied as a new hypothesis. -/
theorem factors_commute_at_crossing (k : ℕ) (a b x : V)
    (hadm : 𝔇.IsAdmissiblePolygon k ![a, b]) (hx : x ∈ segment ℝ a b)
    (d e : ι) (hd : (𝔇.wall d).label.val ∉ K.ker k)
    (he : (𝔇.wall e).label.val ∉ K.ker k)
    (hxd : x ∈ (𝔇.wall d).support) (hxe : x ∈ (𝔇.wall e).support) :
    Commute ((𝔇.wall d).signedFactor (b - a)) ((𝔇.wall e).signedFactor (b - a)) := by
  apply signedFactor_commute_of_direction_eq
  by_contra hn
  have hdis := hadm.avoids_joints 0 d e hd he hn
  exact Set.disjoint_left.mp hdis hx ⟨hxd, hxe⟩

private theorem prod_filter {α M : Type*} [Monoid M] (l : List α)
    (p : α → Prop) [DecidablePred p] (f : α → M) :
    ((l.filter fun a => decide (p a)).map f).prod =
      (l.map fun a => if p a then f a else 1).prod := by
  induction l with
  | nil => rfl
  | cons a l ih => by_cases ha : p a <;> simp [ha, ih]

/-- Sorting and reversing commuting incident factors agrees with inserting
identity factors at all other walls. This does not require the ambient group
to be commutative. -/
theorem sorted_filtered_product {α M : Type*} [Monoid M] (s : Finset α)
    (p : α → Prop) [DecidablePred p] (r : α → α → Bool) (f : α → M)
    (hc : ∀ a ∈ s, p a → ∀ b ∈ s, p b → Commute (f a) (f b)) :
    (((s.filter p).toList.mergeSort r).map f).reverse.prod =
      (s.toList.map fun a => if p a then f a else 1).prod := by
  classical
  have hp : List.Perm (s.filter p).toList (s.toList.filter (fun a => decide (p a))) := by
    apply (List.perm_ext_iff_of_nodup (Finset.nodup_toList _)
      ((Finset.nodup_toList _).filter _)).mpr
    intro a
    simp
  have hperm : List.Perm (((s.filter p).toList.mergeSort r).map f).reverse
      ((s.toList.filter (fun a => decide (p a))).map f) :=
    (List.reverse_perm _).trans (((List.mergeSort_perm _ _).trans hp).map f)
  have hpair : ((s.toList.filter fun a => decide (p a)).map f).Pairwise Commute := by
    apply List.pairwise_of_forall_mem_list
    intro x hx y hy
    obtain ⟨a, ha, rfl⟩ := List.mem_map.mp hx
    obtain ⟨b, hb, rfl⟩ := List.mem_map.mp hy
    simp only [List.mem_filter, Finset.mem_toList, decide_eq_true_eq] at ha hb
    exact hc a ha.1 ha.2 b hb.1 hb.2
  exact (hperm.symm.prod_eq' hpair).symm.trans (prod_filter _ p f)

/-- The exact statement of Suggested's `segmentProduct_eq_wallProductAt`,
proved from the exact definitions. No finite-dimensionality is needed beyond
what is already supplied by the lattice data. -/
theorem segmentProduct_eq_wallProductAt (k : ℕ) (a b x : V)
    (hx : x ∈ segment ℝ a b) (hadm : 𝔇.IsAdmissiblePolygon k ![a, b])
    (hcross : ∀ d, (𝔇.wall d).label.val ∉ K.ker k →
      ∀ y ∈ segment ℝ a b, y ∈ (𝔇.wall d).support → y = x) :
    𝔇.segmentProduct k a b = 𝔇.wallProductAt k x (b - a) := by
  classical
  let s := (𝔇.finite_at_order k).toFinset
  have hf : s.filter (fun d => (segment ℝ a b ∩ (𝔇.wall d).support).Nonempty) =
      s.filter (fun d => x ∈ (𝔇.wall d).support) := by
    ext d
    simp only [Finset.mem_filter]
    constructor
    · rintro ⟨hd, y, hy, hyd⟩
      have hd' : (𝔇.wall d).label.val ∉ K.ker k := (Set.Finite.mem_toFinset _).mp hd
      exact ⟨hd, hcross d hd' y hy hyd ▸ hyd⟩
    · rintro ⟨hd, hxd⟩
      exact ⟨hd, x, hx, hxd⟩
  unfold DirectedDiagram.segmentProduct DirectedDiagram.wallProductAt
  change (((s.filter _).toList.mergeSort _).map _).reverse.prod = _
  rw [hf]
  apply sorted_filtered_product
  intro d hd hxd e he hxe
  exact factors_commute_at_crossing 𝔇 k a b x hadm hx d e
    ((Set.Finite.mem_toFinset _).mp hd) ((Set.Finite.mem_toFinset _).mp he) hxd hxe

end TauCetiRoadmap.ScatteringDiagrams.Formalized.PathProductConnection
