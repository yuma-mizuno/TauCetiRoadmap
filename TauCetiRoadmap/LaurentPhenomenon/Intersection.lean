/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.Chart
public import TauCetiRoadmap.LaurentPhenomenon.Denominator

/-! # Intersection -/

@[expose] public section

namespace TauCeti.Laurent

variable {F I : Type*} [Field F]

/-- Two relatively prime allowed denominators have no common pole. -/
theorem away_inf_away_le (L : Subring F) [DecompositionMonoid L]
    (d e : L) (hd : (d : F) ≠ 0) (he : (e : F) ≠ 0)
    (hde : IsRelPrime d e) : away L d ⊓ away L e ≤ L := by
  rintro w ⟨hwd, hwe⟩
  obtain ⟨m, a, ha⟩ := (mem_away_iff L d hd w).mp hwd
  obtain ⟨n, b, hb⟩ := (mem_away_iff L e he w).mp hwe
  have hd' : d ≠ 0 := fun h ↦ hd (congrArg Subtype.val h)
  have he' : e ≠ 0 := fun h ↦ he (congrArg Subtype.val h)
  obtain ⟨c, hc⟩ := mem_of_relPrime_denominators L.subtype Subtype.val_injective
    (pow_ne_zero m hd') (pow_ne_zero n he') hde.pow
    (show L.subtype a / L.subtype (d ^ m) = L.subtype b / L.subtype (e ^ n) by
      simpa using ha.symm.trans hb)
  have hc' : (c : F) = w := by simpa [← ha] using hc
  exact hc' ▸ c.property

theorem away_inf_away_eq (L : Subring F) [DecompositionMonoid L]
    (d e : L) (hd : (d : F) ≠ 0) (he : (e : F) ≠ 0)
    (hde : IsRelPrime d e) : away L d ⊓ away L e = L :=
  le_antisymm (away_inf_away_le L d e hd he hde)
    (le_inf (le_away L d) (le_away L e))

/-- A chart differing in one coordinate lies in the localization at that coordinate. -/
theorem chart_change_one_le_away (C : Subring F) (x y : I → F) (i : I)
    (z : chartRing C x) (hz : (z : F) ≠ 0) (hy : y i = z)
    (hother : ∀ k, k ≠ i → y k = x k) :
    chartRing C y ≤ away (chartRing C x) z := by
  apply chartRing_le
  · intro a ha
    exact le_away _ _ (coefficient_mem_chartRing C x ha)
  · intro k
    by_cases hk : k = i
    · subst k
      rw [hy]
      exact le_away _ _ z.property
    · rw [hother k hk]
      exact le_away _ _ (coordinate_mem_chartRing C x k)
  · intro k
    by_cases hk : k = i
    · subst k
      rw [hy]
      exact inv_mem_away _ _ hz
    · rw [hother k hk]
      exact le_away _ _ (inverse_mem_chartRing C x k)

/-- A chart differing in two coordinates lies in the localization at their product. -/
theorem chart_change_two_le_away (C : Subring F) (x y : I → F) (i j : I)
    (u v : chartRing C x) (hu : (u : F) ≠ 0) (hv : (v : F) ≠ 0)
    (hyi : y i = u) (hyj : y j = v)
    (hother : ∀ k, k ≠ i → k ≠ j → y k = x k) :
    chartRing C y ≤ away (chartRing C x) (u * v) := by
  apply chartRing_le
  · intro a ha
    exact le_away _ _ (coefficient_mem_chartRing C x ha)
  · intro k
    by_cases hi : k = i
    · subst k
      rw [hyi]
      exact le_away _ _ u.property
    · by_cases hj : k = j
      · subst k
        rw [hyj]
        exact le_away _ _ v.property
      · rw [hother k hi hj]
        exact le_away _ _ (coordinate_mem_chartRing C x k)
  · intro k
    by_cases hi : k = i
    · subst k
      rw [hyi]
      exact inv_left_mem_away_mul _ _ _ hu
    · by_cases hj : k = j
      · subst k
        rw [hyj]
        exact inv_right_mem_away_mul _ _ _ hv
      · rw [hother k hi hj]
        exact le_away _ _ (inverse_mem_chartRing C x k)

/-- The local chart intersection used in the caterpillar induction. All membership
and coprimality inputs concern the three explicitly constructed local coordinates. -/
theorem local_chart_intersection (C : Subring F) (x x₁ x₃ : I → F) (i j : I)
    [DecompositionMonoid (chartRing C x)]
    (z u v : chartRing C x) (hz : (z : F) ≠ 0) (hu : (u : F) ≠ 0)
    (hv : (v : F) ≠ 0) (hzu : IsRelPrime z u) (hzv : IsRelPrime z v)
    (h₁ : x₁ i = z) (h₁other : ∀ k, k ≠ i → x₁ k = x k)
    (h₃i : x₃ i = v) (h₃j : x₃ j = u)
    (h₃other : ∀ k, k ≠ i → k ≠ j → x₃ k = x k) :
    chartRing C x₁ ⊓ chartRing C x₃ ≤ chartRing C x := by
  apply le_trans (inf_le_inf
    (chart_change_one_le_away C x x₁ i z hz h₁ h₁other)
    (chart_change_two_le_away C x x₃ i j v u hv hu h₃i h₃j h₃other))
  exact away_inf_away_le _ z (v * u) hz (mul_ne_zero hv hu) (hzv.mul_right hzu)

end TauCeti.Laurent
