/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import Mathlib.Algebra.Group.Torsion
public import Mathlib.Algebra.Ring.Defs
public import Mathlib.Tactic
public import TauCetiRoadmap.LaurentPhenomenon.GroupRing

/-! # Coefficients -/

@[expose] public section

open TauCeti.Laurent

/-! A coefficient semifield has a multiplicative abelian group and an auxiliary
addition. It has no additive zero in its interface and is not Mathlib's
`Semifield`. The torsion-free group-ring hypothesis is proved, not assumed. -/

namespace TauCeti.Cluster

/-- A commutative multiplicative group with auxiliary commutative, distributive addition; no
additive zero is required.
-/
class CoefficientSemifield (P : Type*) extends CommGroup P, AddCommSemigroup P, Distrib P

namespace CoefficientSemifield

variable {P : Type*} [CoefficientSemifield P]

/-- Nonempty geometric sum; no additive zero is required. -/
def geometricSum (a : P) : ℕ → P
  | 0 => 1
  | n + 1 => geometricSum a n + a ^ (n + 1)

theorem geometricSum_succ (a : P) (n : ℕ) :
    geometricSum a (n + 1) = 1 + a * geometricSum a n := by
  induction n with
  | zero => simp [geometricSum]
  | succ n ih =>
    calc
      geometricSum a ((n + 1) + 1) = geometricSum a (n + 1) + a ^ ((n + 1) + 1) := rfl
      _ = (1 + a * geometricSum a n) + a ^ ((n + 1) + 1) := by rw [ih]
      _ = 1 + a * (geometricSum a n + a ^ (n + 1)) := by
        rw [mul_add, ← pow_succ']
        exact add_assoc _ _ _
      _ = 1 + a * geometricSum a (n + 1) := rfl

theorem eq_one_of_pow_eq_one (a : P) {n : ℕ} (hn : n ≠ 0) (h : a ^ n = 1) : a = 1 := by
  obtain ⟨m, rfl⟩ := Nat.exists_eq_succ_of_ne_zero hn
  cases m with
  | zero => simpa using h
  | succ m =>
    have hfix : a * geometricSum a (m + 1) = geometricSum a (m + 1) := by
      calc
        a * geometricSum a (m + 1) = a * (geometricSum a m + a ^ (m + 1)) := rfl
        _ = a * geometricSum a m + a ^ ((m + 1) + 1) := by simp only [mul_add, pow_succ']
        _ = a * geometricSum a m + 1 := by rw [h]
        _ = 1 + a * geometricSum a m := add_comm _ _
        _ = geometricSum a (m + 1) := (geometricSum_succ a m).symm
    exact (mul_right_cancel (show a * geometricSum a (m + 1) =
      1 * geometricSum a (m + 1) by simpa using hfix))

instance : IsMulTorsionFree P where
  pow_left_injective n hn a b hab := by
    change a ^ n = b ^ n at hab
    have h : (a/b) ^ n = 1 := by simp only [div_pow, hab, div_self']
    exact (div_eq_one.mp (eq_one_of_pow_eq_one (a/b) (by omega) h))

theorem coefficientGroupRing_isDomain : IsDomain (AddMonoidAlgebra ℤ (Additive P)) :=
  TauCeti.Laurent.groupRing_isDomain (Additive P)

end CoefficientSemifield
end TauCeti.Cluster
