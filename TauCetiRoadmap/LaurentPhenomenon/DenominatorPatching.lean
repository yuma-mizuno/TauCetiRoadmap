/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import Mathlib.Algebra.Ring.Subring.MulOpposite
public import Mathlib.Algebra.BigOperators.Ring.Finset
public import Mathlib.Tactic.NoncommRing

/-!
# Clearing finitely many denominators inside an embedded subring

Only a finite right-ideal identity is used. The ambient ring may be
noncommutative, and the denominators need not be central or invertible.
-/

@[expose] public section

namespace TauCeti.Laurent

variable {F I : Type*} [Ring F]

theorem mem_of_mul_mem_of_sum_eq_one (H : Subring F) (s : Finset I)
    (a u : I → H) (f : F)
    (hmem : ∀ i ∈ s, f * (a i : F) ∈ H)
    (hone : ∑ i ∈ s, a i * u i = 1) : f ∈ H := by
  have heq : f = ∑ i ∈ s, (f * (a i : F)) * (u i : F) := by
    calc
      f = f * (↑(∑ i ∈ s, a i * u i) : F) := by rw [hone]; simp
      _ = _ := by simp [Finset.mul_sum, mul_assoc]
  rw [heq]
  exact H.sum_mem fun i hi => H.mul_mem (hmem i hi) (u i).property

theorem mem_of_mul_mem_of_right_bezout (H : Subring F) (a b u v : H) (f : F)
    (ha : f * (a : F) ∈ H) (hb : f * (b : F) ∈ H)
    (hone : a * u + b * v = 1) : f ∈ H := by
  have heq : f = (f * (a : F)) * (u : F) + (f * (b : F)) * (v : F) := by
    have h : (a : F) * (u : F) + (b : F) * (v : F) = 1 :=
      congrArg Subtype.val hone
    calc
      f = f * ((a : F) * (u : F) + (b : F) * (v : F)) := by rw [h]; simp
      _ = _ := by noncomm_ring
  rw [heq]
  exact H.add_mem (H.mul_mem ha u.property) (H.mul_mem hb v.property)

theorem mem_of_mul_mem_of_left_bezout (H : Subring F) (a b u v : H) (f : F)
    (ha : (a : F) * f ∈ H) (hb : (b : F) * f ∈ H)
    (hone : u * a + v * b = 1) : f ∈ H := by
  have heq : f = (u : F) * ((a : F) * f) + (v : F) * ((b : F) * f) := by
    have h : (u : F) * (a : F) + (v : F) * (b : F) = 1 :=
      congrArg Subtype.val hone
    calc
      f = ((u : F) * (a : F) + (v : F) * (b : F)) * f := by rw [h]; simp
      _ = _ := by noncomm_ring
  rw [heq]
  exact H.add_mem (H.mul_mem u.property ha) (H.mul_mem v.property hb)

end TauCeti.Laurent
