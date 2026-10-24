/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.UpperBoundInteracting
public import TauCetiRoadmap.ClusterAlgebras.UpperBoundCommuting

/-! Assembly of rank-two upper-bound comparisons from one-exchange
intersection identities. These identities are discharged by `chartRing_exchangeIntersection`;
they are local intermediate hypotheses, not fields of cluster seed data. -/

@[expose] public section

namespace TauCeti.Cluster.UpperBound
variable {F : Type*} [Field F]

theorem fourRing_swap_first (C : Subring F) (x xs y ys : F) :
    fourRing C x xs y ys = fourRing C xs x y ys := by
  unfold fourRing generated
  congr 1
  ext z
  simp only [Set.mem_union, Set.mem_insert_iff, Set.mem_singleton_iff]
  tauto

/-- The interacting three-chart comparison. The three one-exchange
identifications are supplied by the coefficient-divisibility theorem. -/
theorem interacting_three_chart
    (C L Lx Ly Lxy : Subring F) (a b d f g h x xs y ys : F)
    {c e : ℕ} (hc : 0 < c) (he : 0 < e)
    (hx : x ≠ 0) (hxs : xs ≠ 0) (hy : y ≠ 0) (hf : f ≠ 0) (hh : h ≠ 0)
    (ha : a ∈ C) (hb : b ∈ C) (hd : d ∈ C) (hfC : f ∈ C) (hfi : f⁻¹ ∈ C)
    (hg : g ∈ C) (hhC : h ∈ C) (hhi : h⁻¹ ∈ C)
    (hex : x * xs = a * y ^ c + b) (hey : y * ys = d * x ^ e + f)
    (hcompat : f * h = d * g * b ^ e)
    (hLx : L ⊓ Lx = generated C {x, xs, y, y⁻¹})
    (hLy : L ⊓ Ly = generated C {x, x⁻¹, y, ys})
    (hLxy : Lx ⊓ Lxy = generated C {xs, xs⁻¹, y, (g * xs ^ e + h)/y}) :
    L ⊓ Lx ⊓ Ly = Lx ⊓ L ⊓ Lxy := by
  have hleft : L ⊓ Lx ⊓ Ly = fourRing C x xs y ys := by
    calc
      _ = (L ⊓ Lx) ⊓ (L ⊓ Ly) := by ext z; simp only [Subring.mem_inf]; tauto
      _ = _ := by
        rw [hLx, hLy]
        exact interacting_intersection C a b d f x xs y ys
          he hx hy hf ha hb hd hfC hfi hex hey
  have hgen : generated C {x, xs, y, y⁻¹} = generated C {xs, x, y, y⁻¹} := by
    unfold generated
    congr 1
    ext z
    simp only [Set.mem_union, Set.mem_insert_iff, Set.mem_singleton_iff]
    tauto
  have hright : Lx ⊓ L ⊓ Lxy = fourRing C xs x y ((g * xs ^ e + h)/y) := by
    calc
      _ = (L ⊓ Lx) ⊓ (Lx ⊓ Lxy) := by ext z; simp only [Subring.mem_inf]; tauto
      _ = _ := by
        rw [hLx, hLxy, hgen]
        apply interacting_intersection C a b g h xs x y ((g * xs ^ e + h)/y)
          he hxs hy hh ha hb hg hhC hhi
        · simpa [mul_comm] using hex
        · field_simp
  rw [hleft, hright]
  rw [fourRing_replacement C a b d f g h x xs y ys hc hy hf hh
    ha hb hd hfi hg hhi hex hey hcompat]
  exact fourRing_swap_first C _ _ _ _

/-- The zero-interaction comparison. Coprimality is needed only in this
branch; the faithful Laurent evaluations refer to the actual two charts. -/
theorem commuting_three_chart (C L Lx Ly Lxy : Subring F) [DecompositionMonoid C]
    (x xs y : Fˣ) (E H : C) (hEH : IsRelPrime E H)
    (hex : (x : F) * xs = E)
    (hinj : Function.Injective (pairEval C x y))
    (hinj' : Function.Injective (pairEval C xs y))
    (hLx : L ⊓ Lx = generated C {(x : F), (xs : F), (y : F), (y : F)⁻¹})
    (hLy : L ⊓ Ly = generated C {(x : F), (x : F)⁻¹, (y : F), (H : F)/y})
    (hLxy : Lx ⊓ Lxy = generated C {(xs : F), (xs : F)⁻¹, (y : F), (H : F)/y}) :
    L ⊓ Lx ⊓ Ly = Lx ⊓ L ⊓ Lxy := by
  have hex' : (E : F) / x = xs := by rw [← hex]; field_simp
  have hex'' : (E : F) / xs = x := by rw [← hex]; field_simp
  have hleft := commuting_intersection_embedded C x y E H hEH hinj
  rw [hex'] at hleft
  have hright := commuting_intersection_embedded C xs y E H hEH hinj'
  rw [hex''] at hright
  have hgen : generated C {(x : F), (xs : F), (y : F), (y : F)⁻¹} =
      generated C {(xs : F), (x : F), (y : F), (y : F)⁻¹} := by
    unfold generated
    congr 1
    ext z
    simp only [Set.mem_union, Set.mem_insert_iff, Set.mem_singleton_iff]
    tauto
  calc
    _ = (L ⊓ Lx) ⊓ (L ⊓ Ly) := by ext z; simp only [Subring.mem_inf]; tauto
    _ = fourRing C x xs y ((H : F)/y) := by rw [hLx, hLy]; exact hleft
    _ = fourRing C xs x y ((H : F)/y) := fourRing_swap_first C _ _ _ _
    _ = (L ⊓ Lx) ⊓ (Lx ⊓ Lxy) := by rw [hLx, hLxy, hgen]; exact hright.symm
    _ = _ := by ext z; simp only [Subring.mem_inf]; tauto

end TauCeti.Cluster.UpperBound
