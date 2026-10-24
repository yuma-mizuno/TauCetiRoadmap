/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import Mathlib.Algebra.Ring.Hom.Defs
public import Mathlib.Algebra.Ring.Equiv
public import Mathlib.Algebra.Group.Units.Basic
public import Mathlib.Logic.Function.Iterate

/-!
# Ordered products in a skew exchange

These identities use a ring homomorphism for the coefficient ring and a unit
normalizing its image. They do not introduce a second skew-Laurent carrier or
assume that the coefficients commute. A faithful chart and a nonzero normal
exchange factor are additional inputs for an intersection theorem, not for the
power identities proved here.
-/

@[expose] public section

namespace TauCeti.Laurent.OrderedExchange

variable {C F : Type*} [Ring C] [Ring F]

/-- The coefficient accumulated by repeated exchange. -/
def orderedProduct (sigma : C ≃+* C) (E : C) : ℕ → C
  | 0 => 1
  | n + 1 => orderedProduct sigma E n * (sigma.symm : C → C)^[n] E

@[simp] theorem orderedProduct_zero (sigma : C ≃+* C) (E : C) :
    orderedProduct sigma E 0 = 1 := rfl

@[simp] theorem orderedProduct_succ (sigma : C ≃+* C) (E : C) (n : ℕ) :
    orderedProduct sigma E (n + 1) =
      orderedProduct sigma E n * (sigma.symm : C → C)^[n] E := rfl

theorem inv_mul_coefficient (iota : C →+* F) (sigma : C ≃+* C) (x : Fˣ)
    (hskew : ∀ c, (x : F) * iota c = iota (sigma c) * (x : F)) (c : C) :
    (↑x⁻¹ : F) * iota c = iota (sigma.symm c) * (↑x⁻¹ : F) := by
  have h := hskew (sigma.symm c)
  rw [sigma.apply_symm_apply] at h
  calc
    (↑x⁻¹ : F) * iota c =
        (↑x⁻¹ : F) * (iota c * (x : F)) * (↑x⁻¹ : F) := by simp [mul_assoc]
    _ = (↑x⁻¹ : F) * ((x : F) * iota (sigma.symm c)) * (↑x⁻¹ : F) := by rw [h]
    _ = _ := by simp

theorem inv_pow_mul_coefficient (iota : C →+* F) (sigma : C ≃+* C) (x : Fˣ)
    (hskew : ∀ c, (x : F) * iota c = iota (sigma c) * (x : F)) (n : ℕ) (c : C) :
    (↑x⁻¹ : F) ^ n * iota c =
      iota ((sigma.symm : C → C)^[n] c) * (↑x⁻¹ : F) ^ n := by
  induction n generalizing c with
  | zero => simp
  | succ n ih =>
    calc
      (↑x⁻¹ : F) ^ (n + 1) * iota c =
          (↑x⁻¹ : F) ^ n * ((↑x⁻¹ : F) * iota c) := by rw [pow_succ, mul_assoc]
      _ = (↑x⁻¹ : F) ^ n * (iota (sigma.symm c) * (↑x⁻¹ : F)) := by
        rw [inv_mul_coefficient iota sigma x hskew]
      _ = iota ((sigma.symm : C → C)^[n] (sigma.symm c)) *
          (↑x⁻¹ : F) ^ (n + 1) := by rw [← mul_assoc, ih, mul_assoc, ← pow_succ]
      _ = _ := by rw [Function.iterate_succ_apply]

theorem exchange_pow (iota : C →+* F) (sigma : C ≃+* C) (x : Fˣ)
    (hskew : ∀ c, (x : F) * iota c = iota (sigma c) * (x : F)) (E : C) (n : ℕ) :
    (iota E * (↑x⁻¹ : F)) ^ n = iota (orderedProduct sigma E n) * (↑x⁻¹ : F) ^ n := by
  induction n with
  | zero => simp
  | succ n ih =>
    rw [pow_succ, ih]
    calc
      (iota (orderedProduct sigma E n) * (↑x⁻¹ : F) ^ n) * (iota E * (↑x⁻¹ : F)) =
          iota (orderedProduct sigma E n) *
            ((↑x⁻¹ : F) ^ n * iota E) * (↑x⁻¹ : F) := by simp only [mul_assoc]
      _ = iota (orderedProduct sigma E n) *
          (iota ((sigma.symm : C → C)^[n] E) * (↑x⁻¹ : F) ^ n) * (↑x⁻¹ : F) := by
        rw [inv_pow_mul_coefficient iota sigma x hskew]
      _ = _ := by rw [orderedProduct_succ, map_mul, pow_succ]; simp only [mul_assoc]

@[simp] theorem orderedProduct_refl (E : C) (n : ℕ) :
    orderedProduct (RingEquiv.refl C) E n = E ^ n := by
  induction n with
  | zero => simp
  | succ n ih => simp [orderedProduct_succ, ih, pow_succ]

end TauCeti.Laurent.OrderedExchange
