/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.Chart
public import TauCetiRoadmap.LaurentPhenomenon.DenominatorPatching
public import Mathlib.RingTheory.Coprime.Lemmas

/-! Two principal localizations covering a ring have intersection equal to that
ring. Unlike relative-primality cancellation, this needs no factoriality. -/

@[expose] public section

namespace TauCeti.Laurent
variable {F : Type*} [Field F]

theorem away_inf_away_eq_of_isCoprime (L : Subring F) (d e : L)
    (h : IsCoprime d e) : away L d ⊓ away L e = L := by
  apply le_antisymm _ (le_inf (le_away L d) (le_away L e))
  rintro w ⟨⟨m, hm⟩, ⟨n, hn⟩⟩
  obtain ⟨a, b, hab⟩ := h.pow (m := m) (n := n)
  exact mem_of_mul_mem_of_left_bezout L (d ^ m) (e ^ n) a b w hm hn hab

/-- A rank-two exchange with positive exponent and unit constant term gives a
Bezout identity for the two old coordinates in their four-generator ring. -/
theorem isCoprime_of_exchange (L : Subring F) (x y ys d f : L)
    {e : ℕ} (he : 0 < e) (hf : IsUnit f)
    (hex : y * ys = d * x ^ e + f) : IsCoprime x y := by
  obtain ⟨u, hu⟩ := hf
  subst f
  refine ⟨-(d * (↑u⁻¹ : L) * x ^ (e-1)), (↑u⁻¹ : L) * ys, ?_⟩
  have heq : e - 1 + 1 = e := by omega
  have hp : x ^ e = x ^ (e-1) * x := by
    calc
      x ^ e = x ^ (e-1 + 1) := congrArg (fun n => x ^ n) heq.symm
      _ = _ := pow_succ x (e-1)
  calc
    -(d * (↑u⁻¹ : L) * x ^ (e-1)) * x + ((↑u⁻¹ : L) * ys) * y =
        (↑u⁻¹ : L) * (y * ys - d * x ^ e) := by rw [hp]; ring
    _ = 1 := by rw [hex]; simp

theorem away_inf_away_eq_of_exchange (L : Subring F) (x y ys d f : L)
    {e : ℕ} (he : 0 < e) (hf : IsUnit f)
    (hex : y * ys = d * x ^ e + f) : away L x ⊓ away L y = L :=
  away_inf_away_eq_of_isCoprime L x y (isCoprime_of_exchange L x y ys d f he hf hex)

end TauCeti.Laurent
