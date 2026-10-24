/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import Mathlib.Algebra.Ring.Subring.Basic
public import Mathlib.Tactic
public import Mathlib.RingTheory.Localization.Away.Basic

/-!
# Laurent chart rings and localization inside a field

These definitions do not assume a Laurent theorem. The chart ring is generated
by coefficients, coordinates, and their inverses inside a division ring, so the
same definition serves commutative and quantum charts. `away` is the actual
subring of a field obtained by allowing a power of one specified element as
denominator; for a nonzero element it is a localization of the subring away from
that element (`isLocalization_away`, `awayLocalizationEquiv`).
-/

@[expose] public section

namespace TauCeti.Laurent

section DivisionRing

variable {F : Type*} [DivisionRing F]

/-- The coefficient ring and the coordinates generate this Laurent chart. -/
def chartRing {I : Type*} (C : Subring F) (x : I → F) : Subring F :=
  Subring.closure ((C : Set F) ∪ Set.range x ∪ Set.range (fun i ↦ (x i)⁻¹))

theorem coefficient_mem_chartRing {I : Type*} (C : Subring F) (x : I → F)
    {a : F} (ha : a ∈ C) : a ∈ chartRing C x :=
  Subring.subset_closure (Or.inl (Or.inl ha))

theorem coordinate_mem_chartRing {I : Type*} (C : Subring F) (x : I → F) (i : I) :
    x i ∈ chartRing C x :=
  Subring.subset_closure (Or.inl (Or.inr ⟨i, rfl⟩))

theorem inverse_mem_chartRing {I : Type*} (C : Subring F) (x : I → F) (i : I) :
    (x i)⁻¹ ∈ chartRing C x :=
  Subring.subset_closure (Or.inr ⟨i, rfl⟩)

theorem coordinate_zpow_mem_chartRing {I : Type*} (C : Subring F) (x : I → F)
    (i : I) (n : ℤ) : x i ^ n ∈ chartRing C x := by
  cases n with
  | ofNat n =>
    simpa using (chartRing C x).pow_mem (coordinate_mem_chartRing C x i) n
  | negSucc n =>
    simpa [zpow_negSucc, inv_pow] using
      (chartRing C x).pow_mem (inverse_mem_chartRing C x i) (n + 1)

theorem chartRing_le {I : Type*} {C L : Subring F} {x : I → F}
    (hC : C ≤ L) (hx : ∀ i, x i ∈ L) (hi : ∀ i, (x i)⁻¹ ∈ L) :
    chartRing C x ≤ L := by
  apply Subring.closure_le.mpr
  rintro a ((ha | ⟨i, rfl⟩) | ⟨i, rfl⟩)
  · exact hC ha
  · exact hx i
  · exact hi i

/-- The chart ring depends only on the set of coordinates. -/
theorem chartRing_congr_range {I J : Type*} (C : Subring F) {x : I → F} {y : J → F}
    (h : Set.range x = Set.range y) : chartRing C x = chartRing C y := by
  have hinv : Set.range (fun i ↦ (x i)⁻¹) = Set.range (fun j ↦ (y j)⁻¹) := by
    rw [Set.range_comp' (fun a : F ↦ a⁻¹) x, Set.range_comp' (fun a : F ↦ a⁻¹) y, h]
  unfold chartRing
  rw [h, hinv]

end DivisionRing

variable {F : Type*} [Field F]

/-- Localization away from one element, realized inside the same field. -/
def away (L : Subring F) (d : L) : Subring F where
  carrier := {w | ∃ n : ℕ, (d : F) ^ n * w ∈ L}
  zero_mem' := ⟨0, by simp⟩
  one_mem' := ⟨0, by simp⟩
  add_mem' := by
    rintro a b ⟨m, hm⟩ ⟨n, hn⟩
    refine ⟨m + n, ?_⟩
    have h₁ := L.mul_mem (L.pow_mem d.property n) hm
    have h₂ := L.mul_mem (L.pow_mem d.property m) hn
    convert L.add_mem h₁ h₂ using 1; ring
  mul_mem' := by
    rintro a b ⟨m, hm⟩ ⟨n, hn⟩
    refine ⟨m + n, ?_⟩
    convert L.mul_mem hm hn using 1; ring
  neg_mem' := by
    rintro a ⟨m, hm⟩
    refine ⟨m, ?_⟩
    simpa using L.neg_mem hm

theorem le_away (L : Subring F) (d : L) : L ≤ away L d := by
  intro a ha
  exact ⟨0, by simpa using ha⟩

theorem inv_mem_away (L : Subring F) (d : L) (hd : (d : F) ≠ 0) :
    (d : F)⁻¹ ∈ away L d := by
  refine ⟨1, ?_⟩
  simp [hd]

theorem mem_away_iff (L : Subring F) (d : L) (hd : (d : F) ≠ 0) (w : F) :
    w ∈ away L d ↔ ∃ n : ℕ, ∃ a : L, w = (a : F) / (d : F) ^ n := by
  constructor
  · rintro ⟨n, hn⟩
    refine ⟨n, ⟨_, hn⟩, ?_⟩
    exact (eq_div_iff (pow_ne_zero n hd)).mpr (mul_comm _ _)
  · rintro ⟨n, a, rfl⟩
    refine ⟨n, ?_⟩
    simp [mul_div_cancel₀, pow_ne_zero n hd]

theorem away_eq_closure (L : Subring F) (d : L) (hd : (d : F) ≠ 0) :
    away L d = Subring.closure ((L : Set F) ∪ {(d : F)⁻¹}) := by
  apply le_antisymm
  · intro w hw
    obtain ⟨n, a, rfl⟩ := (mem_away_iff L d hd w).mp hw
    rw [div_eq_mul_inv]
    apply Subring.mul_mem
    · exact Subring.subset_closure (Or.inl a.property)
    · rw [← inv_pow]
      exact (Subring.closure ((L : Set F) ∪ {(d : F)⁻¹})).pow_mem
        (Subring.subset_closure (Or.inr rfl)) n
  · apply Subring.closure_le.mpr
    rintro w (hw | hw)
    · exact le_away L d hw
    · obtain rfl := Set.mem_singleton_iff.mp hw
      exact inv_mem_away L d hd

/-- Two coordinates can be inverted by inverting their product. -/
theorem inv_left_mem_away_mul (L : Subring F) (u v : L) (hu : (u : F) ≠ 0) :
    (u : F)⁻¹ ∈ away L (u * v) := by
  refine ⟨1, ?_⟩
  have h : ((u : F) * (v : F)) * (u : F)⁻¹ = v := by field_simp
  simpa only [pow_one, Subring.coe_mul, h] using v.property

theorem inv_right_mem_away_mul (L : Subring F) (u v : L) (hv : (v : F) ≠ 0) :
    (v : F)⁻¹ ∈ away L (u * v) := by
  refine ⟨1, ?_⟩
  simpa only [pow_one, Subring.coe_mul, mul_inv_cancel_right₀ hv] using u.property

/-- The inclusion `L → away L d` makes `away L d` an `L`-algebra. -/
instance (L : Subring F) (d : L) : Algebra L (away L d) :=
  (Subring.inclusion (le_away L d)).toAlgebra

@[simp] theorem coe_algebraMap_away (L : Subring F) (d : L) (a : L) :
    ((algebraMap L (away L d) a : away L d) : F) = a :=
  rfl

/-- **`away` is a localization.** For `d ≠ 0`, the subring `away L d` is a localization of `L`
away from `d`, with the inclusion as structure map. -/
theorem isLocalization_away (L : Subring F) (d : L) (hd : (d : F) ≠ 0) :
    IsLocalization.Away d (away L d) := by
  refine IsLocalization.Away.mk d ?_ ?_ ?_
  · refine IsUnit.of_mul_eq_one ⟨(d : F)⁻¹, inv_mem_away L d hd⟩ (Subtype.ext ?_)
    simp [hd]
  · rintro ⟨w, n, hn⟩
    refine ⟨n, ⟨_, hn⟩, Subtype.ext ?_⟩
    simp only [Subring.coe_mul, SubmonoidClass.coe_pow, coe_algebraMap_away]
    ring
  · intro a b h
    refine ⟨0, ?_⟩
    rw [pow_zero, one_mul, one_mul]
    have h' : (a : F) = b := congrArg (fun x : away L d ↦ (x : F)) h
    exact Subtype.ext h'

/-- For `d ≠ 0`, the localization of `L` away from `d` is `away L d`. -/
noncomputable def awayLocalizationEquiv (L : Subring F) (d : L) (hd : (d : F) ≠ 0) :
    Localization.Away d ≃ₐ[L] away L d :=
  letI := isLocalization_away L d hd
  IsLocalization.algEquiv (Submonoid.powers d) _ _

theorem awayLocalizationEquiv_mk' (L : Subring F) (d : L) (hd : (d : F) ≠ 0) (a : L) (n : ℕ) :
    ((awayLocalizationEquiv L d hd
      (IsLocalization.mk' _ a ⟨d ^ n, pow_mem (Submonoid.mem_powers d) n⟩) : away L d) : F) =
      a / (d : F) ^ n := by
  have := isLocalization_away L d hd
  rw [awayLocalizationEquiv, IsLocalization.algEquiv_mk', eq_div_iff (pow_ne_zero n hd)]
  have h := IsLocalization.mk'_spec (away L d) a ⟨d ^ n, pow_mem (Submonoid.mem_powers d) n⟩
  have := congrArg Subtype.val h
  simpa only [Subring.coe_mul, coe_algebraMap_away, SubmonoidClass.coe_pow] using this

end TauCeti.Laurent
