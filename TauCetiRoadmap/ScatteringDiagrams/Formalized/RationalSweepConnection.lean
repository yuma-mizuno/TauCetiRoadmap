import TauCetiRoadmap.ScatteringDiagrams.Suggested
import TauCetiRoadmap.ScatteringDiagrams.Formalized.SweepGeometry
import Mathlib.Data.Finset.Max

/-!
# Sweeping the actual rational-normal presentations

One-variable elimination constructs a finite inequality presentation of the
sweep. Rationality of the new normals follows from evaluation on the lattice
vector; offsets remain arbitrary real numbers. No rational-height or boundedness
hypothesis is added. The resulting theorem has the exact prototype signature.
-/

set_option autoImplicit false

namespace TauCetiRoadmap.ScatteringDiagrams.Formalized.RationalSweepConnection

open TauCetiRoadmap.ScatteringDiagrams

/-- Eliminate a nonnegative real variable from finitely many linear inequalities.
The first constraints compare upper bounds with zero; the second compare every
lower bound with every upper bound. With no upper bounds, the finite maximum
of the lower bounds and zero still provides a witness. -/
theorem exists_nonneg_parameter_iff {ι : Type*} [Fintype ι] (a b : ι → ℝ) :
    (∃ t : ℝ, 0 ≤ t ∧ ∀ j, t * a j ≤ b j) ↔
      (∀ j, 0 ≤ a j → 0 ≤ b j) ∧
      (∀ p q, 0 < a p → a q < 0 → a p * b q ≥ a q * b p) := by
  classical
  constructor
  · rintro ⟨t, ht, h⟩
    refine ⟨fun j hj => le_trans (mul_nonneg ht hj) (h j), ?_⟩
    intro p q hp hq
    have h₁ := mul_le_mul_of_nonneg_left (h q) hp.le
    have h₂ := mul_le_mul_of_nonpos_left (h p) hq.le
    nlinarith
  · rintro ⟨hzero, hpair⟩
    let lows : Finset ℝ := insert 0 (Finset.univ.image fun j =>
      if a j < 0 then b j / a j else 0)
    have hlows : lows.Nonempty := ⟨0, Finset.mem_insert_self _ _⟩
    let t := lows.max' hlows
    have ht : 0 ≤ t := lows.le_max' 0 (Finset.mem_insert_self _ _)
    refine ⟨t, ht, fun j => ?_⟩
    rcases lt_trichotomy (a j) 0 with hj | hj | hj
    · have hmem : b j / a j ∈ lows := by
        apply Finset.mem_insert_of_mem
        apply Finset.mem_image.mpr
        exact ⟨j, Finset.mem_univ _, ite_eq_left hj⟩
      have hle : b j / a j ≤ t := lows.le_max' _ hmem
      exact (div_le_iff_of_neg hj).mp hle
    · simpa [hj] using hzero j hj.ge
    · have upper : t ≤ b j / a j := by
        apply lows.max'_le
        intro y hy
        rcases Finset.mem_insert.mp hy with rfl | hy
        · exact div_nonneg (hzero j hj.le) hj.le
        · obtain ⟨q, _, rfl⟩ := Finset.mem_image.mp hy
          split_ifs with hq
          · apply (div_le_iff_of_neg hq).mpr
            apply (mul_le_mul_iff_right₀ hj).mp
            calc
              a j * (b j / a j * a q) = a q * b j := by field_simp
              _ ≤ a j * b q := hpair j q hj hq
          · exact div_nonneg (hzero j hj.le) hj.le
      exact (le_div_iff₀ hj).mp upper

variable {N V : Type*} [AddCommGroup N] [NormedAddCommGroup V] [NormedSpace ℝ V]
  {i : N →+ V}

abbrev SweepIndex (P : RationalAffinePolyhedron i) :=
  Fin P.numIneq ⊕ (Fin P.numIneq × Fin P.numIneq)

noncomputable def sweepNormal (P : RationalAffinePolyhedron i) (n₀ : N) :
    SweepIndex P → Module.Dual ℝ V
  | .inl j => if 0 ≤ P.normal j (i n₀) then P.normal j else 0
  | .inr (p, q) =>
    if 0 < P.normal p (i n₀) ∧ P.normal q (i n₀) < 0 then
      P.normal p (i n₀) • P.normal q - P.normal q (i n₀) • P.normal p else 0

noncomputable def sweepOffset (P : RationalAffinePolyhedron i) (n₀ : N) : SweepIndex P → ℝ
  | .inl j => if 0 ≤ P.normal j (i n₀) then P.offset j else 0
  | .inr (p, q) =>
    if 0 < P.normal p (i n₀) ∧ P.normal q (i n₀) < 0 then
      P.normal p (i n₀) * P.offset q - P.normal q (i n₀) * P.offset p else 0

theorem sweepNormal_rational (P : RationalAffinePolyhedron i) (n₀ : N) (j : SweepIndex P) :
    IsRationalFunctional i (sweepNormal P n₀ j) := by
  intro n
  rcases j with j | ⟨p, q⟩
  · simp only [sweepNormal]
    split_ifs
    · exact P.normal_rational j n
    · exact ⟨0, by simp⟩
  · simp only [sweepNormal]
    split_ifs
    · obtain ⟨a, ha⟩ := P.normal_rational p n₀
      obtain ⟨b, hb⟩ := P.normal_rational q n₀
      obtain ⟨c, hc⟩ := P.normal_rational p n
      obtain ⟨d, hd⟩ := P.normal_rational q n
      exact ⟨a * d - b * c, by simp [ha, hb, hc, hd]⟩
    · exact ⟨0, by simp⟩

/-- An explicit presentation with `m + m²` inequalities. The irrelevant
inequalities are `0 ≤ 0`, so there is no dependence on a chosen enumeration of
positive and negative slopes. -/
noncomputable def sweepPresentation (P : RationalAffinePolyhedron i) (n₀ : N) :
    RationalAffinePolyhedron i where
  numIneq := Fintype.card (SweepIndex P)
  normal j := sweepNormal P n₀ ((Fintype.equivFin (SweepIndex P)).symm j)
  offset j := sweepOffset P n₀ ((Fintype.equivFin (SweepIndex P)).symm j)
  normal_rational _ := sweepNormal_rational P n₀ _

theorem mem_sweepPresentation (P : RationalAffinePolyhedron i) (n₀ : N) (y : V) :
    y ∈ (sweepPresentation P n₀).carrier ↔
      ∃ t : ℝ, 0 ≤ t ∧ ∀ j, P.normal j (y + t • i n₀) ≤ P.offset j := by
  have hreindex : y ∈ (sweepPresentation P n₀).carrier ↔
      ∀ j : SweepIndex P, sweepNormal P n₀ j y ≤ sweepOffset P n₀ j := by
    constructor
    · intro h j
      simpa [sweepPresentation] using h ((Fintype.equivFin (SweepIndex P)) j)
    · intro h j
      exact h ((Fintype.equivFin (SweepIndex P)).symm j)
  rw [hreindex]
  have hlinear : (∃ t : ℝ, 0 ≤ t ∧ ∀ j, P.normal j (y + t • i n₀) ≤ P.offset j) ↔
      ∃ t : ℝ, 0 ≤ t ∧ ∀ j, t * P.normal j (i n₀) ≤ P.offset j - P.normal j y := by
    simp only [map_add, map_smul, smul_eq_mul, le_sub_iff_add_le, add_comm]
  rw [hlinear, exists_nonneg_parameter_iff]
  constructor
  · intro h
    constructor
    · intro j hj
      have hh := h (.inl j)
      simp only [sweepNormal, sweepOffset, ite_eq_left hj] at hh
      linarith
    · intro p q hp hq
      have hh := h (.inr (p, q))
      simp only [sweepNormal, sweepOffset, hp, hq, and_self, ite_true,
        LinearMap.sub_apply, LinearMap.smul_apply, smul_eq_mul] at hh
      nlinarith
  · rintro ⟨hzero, hpair⟩ (j | ⟨p, q⟩)
    · simp only [sweepNormal, sweepOffset]
      split_ifs with hj
      · have := hzero j hj
        linarith
      · simp
    · simp only [sweepNormal, sweepOffset]
      split_ifs with hpq
      · have := hpair p q hpq.1 hpq.2
        simp only [LinearMap.sub_apply, LinearMap.smul_apply, smul_eq_mul]
        nlinarith
      · simp

/-- Equality with the actual support definition in Suggested, not a substitute
notion of sweep. -/
theorem sweepPresentation_carrier (P : RationalAffinePolyhedron i) (n₀ : N) :
    (sweepPresentation P n₀).carrier = sweepSupport P.carrier (i n₀) := by
  ext y
  rw [mem_sweepPresentation]
  constructor
  · rintro ⟨t, ht, hy⟩
    exact ⟨y + t • i n₀, hy, t, ht, by module⟩
  · rintro ⟨x, hx, t, ht, rfl⟩
    refine ⟨t, ht, ?_⟩
    have he : x - t • i n₀ + t • i n₀ = x := by module
    simpa only [he] using (show ∀ j, P.normal j x ≤ P.offset j from hx)

/-- Rational-normality itself needs neither transversality nor nonemptiness. -/
theorem sweep_rational {P : Set V} (hP : IsRationalAffinePolyhedron i P) (n₀ : N) :
    IsRationalAffinePolyhedron i (sweepSupport P (i n₀)) := by
  obtain ⟨Q, rfl⟩ := hP
  exact ⟨sweepPresentation Q n₀, sweepPresentation_carrier Q n₀⟩

/-- The full, unchanged statement of Suggested's `sweepSupport_isCell`.
Its two definitions of affine direction and swept support are connected by
definitional equality and Mathlib's `direction_affineSpan`. -/
theorem sweepSupport_isCell [FiniteDimensional ℝ V] {P : Set V}
    (hP : IsRationalAffinePolyhedron i P) (hne : P.Nonempty) (n₀ : N)
    (hn : i n₀ ∉ affineDir P) :
    IsRationalAffinePolyhedron i (sweepSupport P (i n₀)) ∧
      affineDir (sweepSupport P (i n₀)) = affineDir P ⊔ Submodule.span ℝ {i n₀} ∧
      Module.finrank ℝ (affineDir (sweepSupport P (i n₀))) =
        Module.finrank ℝ (affineDir P) + 1 := by
  have hs : sweepSupport P (i n₀) = SweepGeometry.sweepSupport P (i n₀) := rfl
  have hn' : i n₀ ∉ vectorSpan ℝ P := by
    simpa only [affineDir, direction_affineSpan] using hn
  refine ⟨sweep_rational hP n₀, ?_, ?_⟩
  · simpa only [affineDir, direction_affineSpan, hs] using
      SweepGeometry.vectorSpan_sweepSupport hne (i n₀)
  · change Module.finrank ℝ ((affineSpan ℝ (sweepSupport P (i n₀))).direction) =
      Module.finrank ℝ ((affineSpan ℝ P).direction) + 1
    rw [direction_affineSpan, direction_affineSpan, hs]
    exact SweepGeometry.finrank_sweepSupport hne hn'

end TauCetiRoadmap.ScatteringDiagrams.Formalized.RationalSweepConnection
