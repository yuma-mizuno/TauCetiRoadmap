import TauCetiRoadmap.ScatteringDiagrams.Formalized.RationalSweepConnection
import TauCetiRoadmap.ScatteringDiagrams.Formalized.HeisenbergConnection
import Mathlib.LinearAlgebra.Matrix.Determinant.Basic

/-!
# Sweep orientation and the geometric correction trace in rank two

All intersections of a specified counterclockwise rectangle with the two
incoming hyperplanes and the swept outgoing ray are computed. The trace is
exhaustive, including the two distinct crossings on its bottom edge. Its
first-crossing-rightmost product is then evaluated in the constructed
Heisenberg BCH group. This tests a concrete connection, not the general
polyhedral-cochain quotient or the general completion theorem.
-/

set_option autoImplicit false

namespace TauCetiRoadmap.ScatteringDiagrams.Formalized.RankTwoSweepConnection

open TauCetiRoadmap.ScatteringDiagrams
open HeisenbergConnection

abbrev Plane := Fin 2 → ℝ

def area : AltForm Plane 2 := Matrix.detRowAlternating

def mu : Module.Dual ℝ Plane :=
  (LinearMap.proj 0 : Plane →ₗ[ℝ] ℝ) - LinearMap.proj 1

/-- The swept orientation is `dy-dx`, the negative of the correction wall's
normal `dx-dy`. This is the sign connecting `S ζ` to its labelled wall. -/
theorem sweep_orientation (v : Plane) :
    area.curryLeft ![1, 1] ![v] = -mu v := by
  change Matrix.det !![1, 1; v 0, v 1] = -(v 0 - v 1)
  rw [Matrix.det_fin_two]
  simp

def degreeX : Fin 2 → ℤ := ![1, 0]
def degreeY : Fin 2 → ℤ := ![0, 1]
def normalX : (Fin 2 → ℤ) →+ ℤ := (LinearMap.proj 1 : _ →ₗ[ℤ] ℤ).toAddMonoidHom
def normalY : (Fin 2 → ℤ) →+ ℤ := (LinearMap.proj 0 : _ →ₗ[ℤ] ℤ).toAddMonoidHom

theorem bracket_normal :
    wallBracketNormal (AddMonoidHom.id _) degreeX degreeY normalX normalY =
      normalY - normalX := by
  ext v
  simp [wallBracketNormal, degreeX, degreeY, normalX, normalY]

/-- The actual swept support of the joint, computed without an existential
presentation or an assumed outgoing-wall construction. -/
theorem sweep_support (v : Plane) :
    v ∈ sweepSupport ({0} : Set Plane) ![1, 1] ↔ v 0 = v 1 ∧ v 0 ≤ 0 := by
  constructor
  · rintro ⟨x, hx, t, ht, he⟩
    have hx0 : x = 0 := Set.mem_singleton_iff.mp hx
    subst x
    subst v
    simp only [Pi.sub_apply, Pi.zero_apply, Pi.smul_apply, smul_eq_mul,
      Matrix.cons_val_zero, Matrix.cons_val_one, mul_one, zero_sub]
    exact ⟨trivial, neg_nonpos.mpr ht⟩
  · rintro ⟨hv, hn⟩
    refine ⟨0, Set.mem_singleton _, -v 0, neg_nonneg.mpr hn, ?_⟩
    ext j
    fin_cases j <;> simp [hv]

def support : Fin 3 → Set Plane :=
  ![{v | v 1 = 0}, {v | v 0 = 0}, sweepSupport {0} ![1, 1]]

def normal : Fin 3 → Module.Dual ℝ Plane :=
  ![LinearMap.proj 1, LinearMap.proj 0, mu]

def vertex : Fin 5 → Plane := ![![1, 1], ![-2, 1], ![-2, -1], ![1, -1], ![1, 1]]

def segmentPoint (e : Fin 4) (t : ℝ) : Plane :=
  (1 - t) • vertex e.castSucc + t • vertex e.succ

def velocity (e : Fin 4) : Plane := vertex e.succ - vertex e.castSucc

/-- All five crossings, ordered by segment and then by parameter. -/
noncomputable def events : List (Fin 4 × ℝ × Fin 3) :=
  [(0, 1/3, 1), (1, 1/2, 0), (2, 1/3, 2), (2, 2/3, 1), (3, 1/2, 0)]

/-- Exhaustiveness is proved from the support equations. No list of wall
crossings is accepted as an input. In particular no intersection is omitted. -/
theorem crossings_iff (e : Fin 4) (w : Fin 3) (t : ℝ) (ht : 0 ≤ t) (ht' : t ≤ 1) :
    segmentPoint e t ∈ support w ↔ (e, t, w) ∈ events := by
  fin_cases e <;> fin_cases w <;>
    norm_num [support, segmentPoint, vertex, sweep_support, events, Prod.mk.injEq]
  all_goals first
    | (constructor <;> intro h <;> (try rcases h with ⟨h₁, h₂⟩) <;>
        (try constructor) <;> linarith)
    | (intro h; linarith)

theorem events_strictly_ordered : events.Pairwise (fun a b =>
    a.1.val < b.1.val ∨ (a.1 = b.1 ∧ a.2.1 < b.2.1)) := by
  norm_num [events, List.pairwise_cons]

theorem crossings_transverse : ∀ q ∈ events, normal q.2.2 (velocity q.1) ≠ 0 := by
  simp only [events, List.mem_cons, List.not_mem_nil, or_false]
  intro q h
  rcases h with rfl | rfl | rfl | rfl | rfl <;>
    norm_num [normal, velocity, vertex, mu]

theorem crossings_avoid_joint : ∀ q ∈ events, segmentPoint q.1 q.2.1 ≠ 0 := by
  simp only [events, List.mem_cons, List.not_mem_nil, or_false]
  intro q h
  rcases h with rfl | rfl | rfl | rfl | rfl <;>
    intro he <;> have h := congrFun he 0 <;> have h' := congrFun he 1 <;>
    norm_num [segmentPoint, vertex] at h <;> norm_num [segmentPoint, vertex] at h'

/-- Convention 3, with exactly the same three branches as `DirectedWall.signedFactor`. -/
noncomputable def factor {G : Type*} [Group G] (label : G) (value : ℝ) : G :=
  if value < 0 then label else if 0 < value then label⁻¹ else 1

theorem factor_agrees_with_source {L Λ V G : Type*} [AddCommGroup L] [AddCommGroup Λ]
    [NormedAddCommGroup V] [NormedSpace ℝ V] [Group G]
    {i : Λ →+ V} {hi : TauCeti.Toric.IsIntegralLattice i} {ρ : L →+ Λ}
    {D : PositiveDegrees L} {groups : L → (Λ →+ ℤ) → Subgroup G}
    (w : DirectedWall hi ρ D groups) (v : V) :
    factor w.label.val (w.realNormal v) = w.signedFactor v := rfl

theorem factor_reverse_orientation {G : Type*} [Group G] (g : G) (r : ℝ) :
    factor g⁻¹ (-r) = factor g r := by
  rcases lt_trichotomy r 0 with hr | rfl | hr
  · simp [factor, hr, neg_pos.mpr hr, not_lt.mpr (neg_nonneg.mpr hr.le)]
  · simp [factor]
  · simp [factor, hr, hr.not_gt, neg_neg_of_pos hr]

/-- The minus in the wall label and the minus in its normal cancel. This
connects the actual contraction of the joint form to Convention 3. -/
theorem swept_label_factor (c : ℚ) (v : Plane) :
    factor (Z (-c)) (area.curryLeft ![1, 1] ![v]) = factor (Z c) (mu v) := by
  have hz : Z (-c) = (Z c)⁻¹ := by ext <;> simp [Z]
  rw [sweep_orientation, hz, factor_reverse_orientation]

def labels (a b c : ℚ) : Fin 3 → H := ![X a, Y b, Z c]

noncomputable def traceProduct (a b c : ℚ) : H :=
  (events.map fun q => factor (labels a b c q.2.2) (normal q.2.2 (velocity q.1))).reverse.prod

theorem traceProduct_eq (a b c : ℚ) : traceProduct a b c = correctedProduct a b c := by
  norm_num [traceProduct, events, labels, normal, velocity, vertex, mu, factor,
    correctedProduct, mul_assoc]

/-- The constructed chamber path uses exactly the uncorrected geometric loop
product. A zero correction coefficient contributes the identity. -/
theorem chamberPath_product_eq_trace (a b : ℚ) :
    (chamberPath a b).product = traceProduct a b 0 := by
  rw [chamberPath_product, traceProduct_eq, initialProduct_eq, correctedProduct_eq, sub_zero]

/-- Start with the *computed* meridian defect, sweep its oriented joint, attach
the prescribed negative exponential, and read the exhaustive geometric trace. -/
noncomputable def sweptTraceProduct (a b : ℚ) : H :=
  (events.map fun q => if q.2.2 = 2 then
    factor (Z (-(chamberPath a b).defectSum))
      (area.curryLeft ![1, 1] ![velocity q.1])
    else factor (labels a b 0 q.2.2) (normal q.2.2 (velocity q.1))).reverse.prod

theorem sweptTraceProduct_eq (a b : ℚ) : sweptTraceProduct a b = traceProduct a b (a * b) := by
  simp only [sweptTraceProduct, chamberPath_defect, swept_label_factor]
  simp [traceProduct, events, labels, normal]

theorem computed_defect_sweep_cancels (a b : ℚ) : sweptTraceProduct a b = 1 := by
  rw [sweptTraceProduct_eq, traceProduct_eq, correctedProduct_eq_one]

/-- The completely enumerated geometric trace cancels with the bracket
coefficient from the actual BCH Lie algebra. -/
theorem geometric_correction_cancels (a b : ℚ) : traceProduct a b (a * b) = 1 := by
  rw [traceProduct_eq, correctedProduct_eq_one]

theorem reversed_correction_fails : traceProduct 1 1 (-1) ≠ 1 := by
  rw [traceProduct_eq]
  exact wrong_sign_detected

end TauCetiRoadmap.ScatteringDiagrams.Formalized.RankTwoSweepConnection
