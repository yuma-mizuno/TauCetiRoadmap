/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.UpperBoundLocal

/-! The interacting rank-two intersection inside a field, as the commutative instance of the
seed-free patching theorem `TauCeti.Laurent.inf_eq_of_unitConstantTerm`: the second exchange
`y * ys = d * x ^ e + f` has unit constant term `f` in `C[x]`. No unique factorization or
algebraic independence is needed. -/

@[expose] public section

namespace TauCeti.Cluster.UpperBound
open TauCeti.Laurent
variable {F : Type*} [Field F]

/-- L2b, with the exact embedded rings: `C[x, xs, y^{±1}] ⊓ C[x^{±1}, y, ys]` is the
four-generator ring. -/
theorem interacting_intersection (C : Subring F) (a b d f x xs y ys : F)
    {c e : ℕ} (he : 0 < e) (hx : x ≠ 0) (hy : y ≠ 0) (hf : f ≠ 0)
    (ha : a ∈ C) (hb : b ∈ C) (hd : d ∈ C) (hfC : f ∈ C) (hfi : f⁻¹ ∈ C)
    (hex : x * xs = a * y ^ c + b) (hey : y * ys = d * x ^ e + f) :
    generated C {x, xs, y, y⁻¹} ⊓ generated C {x, x⁻¹, y, ys} =
      fourRing C x xs y ys := by
  let H := fourRing C x xs y ys
  have hCH : ∀ z ∈ C, z ∈ H := fun z hz ↦ coefficient_mem_fourRing C x xs y ys hz
  have hys : ys ∈ generated C {x, xs, y, y⁻¹} := by
    let A := generated C {x, xs, y, y⁻¹}
    have hval : ys = (d * x ^ e + f) * y⁻¹ := by rw [← hey]; field_simp
    rw [hval]
    exact A.mul_mem (A.add_mem
      (A.mul_mem (coefficient_mem_generated C _ hd)
        (A.pow_mem (generator_mem_generated C _ (by simp)) e))
      (coefficient_mem_generated C _ hfC)) (generator_mem_generated C _ (by simp))
  have hxs : xs ∈ generated C {x, x⁻¹, y, ys} := by
    let A := generated C {x, x⁻¹, y, ys}
    have hval : xs = (a * y ^ c + b) * x⁻¹ := by rw [← hex]; field_simp
    rw [hval]
    exact A.mul_mem (A.add_mem
      (A.mul_mem (coefficient_mem_generated C _ ha)
        (A.pow_mem (generator_mem_generated C _ (by simp)) c))
      (coefficient_mem_generated C _ hb)) (generator_mem_generated C _ (by simp))
  have hHle (s : Set F) (hs : ∀ z ∈ ({x, xs, y, ys} : Set F), z ∈ generated C s) :
      H ≤ generated C s :=
    generated_le C _ _ (fun _ hz ↦ coefficient_mem_generated C s hz) hs
  have hclos (z : F) : H ≤ Subring.closure ((H : Set F) ∪ {z⁻¹}) :=
    fun w hw ↦ Subring.subset_closure (Or.inl hw)
  have hinv (z : F) : z⁻¹ ∈ Subring.closure ((H : Set F) ∪ {z⁻¹}) :=
    Subring.subset_closure (Or.inr rfl)
  have hw : f⁻¹ * d * x ^ (e - 1) ∈ skewPolyRing C x :=
    Subring.mul_mem _ (Subring.mul_mem _ (le_skewPolyRing C x hfi) (le_skewPolyRing C x hd))
      (Subring.pow_mem _ (generator_mem_skewPolyRing C x) _)
  rw [inf_comm]
  refine inf_eq_of_unitConstantTerm (x := y) (y := x) (xs := ys) (e := 1)
    (Normalizes.of_ne_zero hx) (Normalizes.of_ne_zero hy) C.one_mem
    (by rw [mul_one, mul_comm y x, mul_inv_cancel_right₀ hy])
    ⟨f, hfC, hf, hfi, f⁻¹ * d * x ^ (e - 1), hw, ?_⟩
    (skewPolyRing_le (fun z hz ↦ hCH z hz) (x_mem_fourRing C x xs y ys))
    (ys_mem_fourRing C x xs y ys) ?_ ?_ ?_ ?_
  · have hxe : x * x ^ (e - 1) = x ^ e := by rw [← pow_succ', Nat.sub_add_cancel he]
    rw [hey, ← hxe]
    field_simp
    ring
  · refine hHle _ fun z hz ↦ ?_
    simp only [Set.mem_insert_iff, Set.mem_singleton_iff] at hz
    rcases hz with rfl | rfl | rfl | rfl
    · exact generator_mem_generated C _ (by simp)
    · exact hxs
    · exact generator_mem_generated C _ (by simp)
    · exact generator_mem_generated C _ (by simp)
  · refine hHle _ fun z hz ↦ ?_
    simp only [Set.mem_insert_iff, Set.mem_singleton_iff] at hz
    rcases hz with rfl | rfl | rfl | rfl
    · exact generator_mem_generated C _ (by simp)
    · exact generator_mem_generated C _ (by simp)
    · exact generator_mem_generated C _ (by simp)
    · exact hys
  · intro w hw
    refine exists_mul_pow_mem_of_mem_closure (Normalizes.of_ne_zero hx)
      (x_mem_fourRing C x xs y ys) (generated_le C _ _ (fun z hz ↦ hclos _ (hCH z hz)) (fun z hz ↦
        ?_) hw)
    simp only [Set.mem_insert_iff, Set.mem_singleton_iff] at hz
    rcases hz with hz | hz | hz | hz <;> rw [hz]
    · exact hclos _ (x_mem_fourRing C x xs y ys)
    · exact hinv x
    · exact hclos _ (y_mem_fourRing C x xs y ys)
    · exact hclos _ (ys_mem_fourRing C x xs y ys)
  · intro w hw
    refine exists_mul_pow_mem_of_mem_closure (Normalizes.of_ne_zero hy)
      (y_mem_fourRing C x xs y ys) (generated_le C _ _ (fun z hz ↦ hclos _ (hCH z hz)) (fun z hz ↦
        ?_) hw)
    simp only [Set.mem_insert_iff, Set.mem_singleton_iff] at hz
    rcases hz with hz | hz | hz | hz <;> rw [hz]
    · exact hclos _ (x_mem_fourRing C x xs y ys)
    · exact hclos _ (xs_mem_fourRing C x xs y ys)
    · exact hclos _ (y_mem_fourRing C x xs y ys)
    · exact hinv y

end TauCeti.Cluster.UpperBound
