/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.FiniteExchangeReplacement
public import Mathlib.Algebra.Polynomial.Div
public import Mathlib.Algebra.Polynomial.Eval.Degree
public import Mathlib.Algebra.Ring.Subring.Basic
public import Mathlib.Tactic.Ring
public import Mathlib.Tactic.LinearCombination

/-!
# Polynomial corrections for replacing an exchange partner

The correction is constructed in a polynomial ring, before evaluation in any
ambient ring. No Laurentness, positivity, factoriality, monicity, or reciprocity
assumption is used. The reflection identity describes precisely which next
exchange polynomial is covered by the replacement theorem.
-/

@[expose] public section

namespace TauCeti.Laurent.PolynomialExchange

open Polynomial

variable {R A : Type*} [CommRing R] [CommRing A]

/-- A polynomial quotient, not division by the evaluated coordinate. -/
noncomputable def powerCorrection (P : R[X]) (n : ℕ) : R[X] :=
  (P ^ n - C (P.coeff 0 ^ n)).divX

theorem X_mul_powerCorrection (P : R[X]) (n : ℕ) :
    X * powerCorrection P n = P ^ n - C (P.coeff 0 ^ n) := by
  have h := X_mul_divX_add (P ^ n - C (P.coeff 0 ^ n))
  simpa [powerCorrection, coeff_zero_eq_eval_zero] using h

theorem eval_powerCorrection (P : R[X]) (n : ℕ) (f : R →+* A) (y : A) :
    y * (powerCorrection P n).eval₂ f y =
      P.eval₂ f y ^ n - f (P.coeff 0) ^ n := by
  have h := congrArg (Polynomial.eval₂ f y) (X_mul_powerCorrection P n)
  simpa only [eval₂_mul, eval₂_X, eval₂_sub, eval₂_C, eval₂_pow, map_pow] using h

theorem powerCorrection_map {S : Type*} [CommRing S] (P : R[X]) (f : R →+* S) (n : ℕ) :
    powerCorrection (P.map f) n = (powerCorrection P n).map f := by
  have hdiv (p : R[X]) : p.divX.map f = (p.map f).divX := by
    ext k
    simp only [coeff_map, coeff_divX]
  unfold powerCorrection
  rw [hdiv]
  congr 1
  simp

/-- Homogenized reciprocal evaluation with a specified degree bound. -/
noncomputable def reflectedEval (Q : R[X]) (f : R →+* A) (b z : A) (e : ℕ) : A :=
  Q.sum fun n a => f a * b ^ n * z ^ (e - n)

theorem reflectedEval_add (P Q : R[X]) (f : R →+* A) (b z : A) (e : ℕ) :
    reflectedEval (P + Q) f b z e = reflectedEval P f b z e + reflectedEval Q f b z e := by
  unfold reflectedEval
  apply Polynomial.sum_add_index <;> simp [add_mul]

@[simp] theorem reflectedEval_monomial (n : ℕ) (a : R) (f : R →+* A)
    (b z : A) (e : ℕ) :
    reflectedEval (monomial n a) f b z e = f a * b ^ n * z ^ (e - n) := by
  simp [reflectedEval]

@[simp] theorem reflectedEval_C (a : R) (f : R →+* A) (b z : A) (e : ℕ) :
    reflectedEval (C a) f b z e = f a * z ^ e := by
  simp [reflectedEval]

theorem reflectedEval_binomial (d a : R) (f : R →+* A) (b z : A) (e : ℕ) :
    reflectedEval (C d * X ^ e + C a) f b z e = f d * b ^ e + f a * z ^ e := by
  rw [reflectedEval_add, C_mul_X_pow_eq_monomial]
  simp

theorem reflectedEval_map {S : Type*} [CommRing S] (Q : R[X]) (f : R →+* S)
    (g : S →+* A) (b z : A) (e : ℕ) :
    reflectedEval (Q.map f) g b z e = reflectedEval Q (g.comp f) b z e := by
  induction Q using Polynomial.induction_on' with
  | add P Q hP hQ => simp only [Polynomial.map_add, reflectedEval_add, hP, hQ]
  | monomial n a => simp

theorem map_reflectedEval {B : Type*} [CommRing B] (Q : R[X]) (f : R →+* A)
    (g : A →+* B) (b z : A) (e : ℕ) :
    g (reflectedEval Q f b z e) = reflectedEval Q (g.comp f) (g b) (g z) e := by
  simp [reflectedEval, Polynomial.sum]

/-- The finite correction for an arbitrary polynomial in the other direction. -/
noncomputable def correctionEval (P Q : R[X]) (f : R →+* A) (y z : A) (e : ℕ) : A :=
  Q.sum fun n a => f a * z ^ (e - n) * (powerCorrection P n).eval₂ f y

theorem correctionEval_add (P Q Q' : R[X]) (f : R →+* A) (y z : A) (e : ℕ) :
    correctionEval P (Q + Q') f y z e =
      correctionEval P Q f y z e + correctionEval P Q' f y z e := by
  unfold correctionEval
  apply Polynomial.sum_add_index <;> simp [add_mul]

theorem correctionEval_map {S : Type*} [CommRing S] (P Q : R[X]) (f : R →+* S)
    (g : S →+* A) (y z : A) (e : ℕ) :
    correctionEval (P.map f) (Q.map f) g y z e =
      correctionEval P Q (g.comp f) y z e := by
  induction Q using Polynomial.induction_on' with
  | add Q Q' hQ hQ' => simp only [Polynomial.map_add, correctionEval_add, hQ, hQ']
  | monomial n a => simp [correctionEval, powerCorrection_map, Polynomial.eval₂_map]

theorem map_correctionEval {B : Type*} [CommRing B] (P Q : R[X]) (f : R →+* A)
    (g : A →+* B) (y z : A) (e : ℕ) :
    g (correctionEval P Q f y z e) = correctionEval P Q (g.comp f) (g y) (g z) e := by
  simp [correctionEval, Polynomial.sum, Polynomial.hom_eval₂]

theorem replacement_identity (P Q : R[X]) (f : R →+* A) (x y z : A) (e : ℕ)
    (hdegree : Q.natDegree ≤ e) (hex : x * z = P.eval₂ f y) :
    z ^ e * Q.eval₂ f x - reflectedEval Q f (f (P.coeff 0)) z e =
      y * correctionEval P Q f y z e := by
  classical
  rw [Polynomial.eval₂_eq_sum]
  simp only [reflectedEval, correctionEval, Polynomial.sum,
    Finset.mul_sum, ← Finset.sum_sub_distrib]
  apply Finset.sum_congr rfl
  intro n hn
  have hnle : n ≤ e :=
    (Polynomial.le_natDegree_of_ne_zero (Polynomial.mem_support_iff.mp hn)).trans hdegree
  have hpow : z ^ e * x ^ n = z ^ (e - n) * P.eval₂ f y ^ n := by
    calc
      z ^ e * x ^ n = z ^ (e - n + n) * x ^ n := by rw [Nat.sub_add_cancel hnle]
      _ = z ^ (e - n) * (x * z) ^ n := by rw [pow_add, mul_pow]; ring
      _ = _ := by rw [hex]
  calc
    z ^ e * (f (Q.coeff n) * x ^ n) -
        f (Q.coeff n) * f (P.coeff 0) ^ n * z ^ (e - n) =
      f (Q.coeff n) * (z ^ e * x ^ n) -
        f (Q.coeff n) * f (P.coeff 0) ^ n * z ^ (e - n) := by ring
    _ = f (Q.coeff n) * z ^ (e - n) *
        (P.eval₂ f y ^ n - f (P.coeff 0) ^ n) := by rw [hpow]; ring
    _ = y * (f (Q.coeff n) * z ^ (e - n) * (powerCorrection P n).eval₂ f y) := by
      rw [← eval_powerCorrection P n f y]
      ring

theorem eval_mem_subring (P : R[X]) (f : R →+* A) (H : Subring A)
    (hcoeff : ∀ a, f a ∈ H) (y : A) (hy : y ∈ H) : P.eval₂ f y ∈ H := by
  classical
  rw [Polynomial.eval₂_eq_sum, Polynomial.sum]
  exact H.sum_mem fun n _ => H.mul_mem (hcoeff _) (H.pow_mem hy n)

theorem correctionEval_mem (P Q : R[X]) (f : R →+* A) (H : Subring A)
    (hcoeff : ∀ a, f a ∈ H) (y z : A) (hy : y ∈ H) (hz : z ∈ H) (e : ℕ) :
    correctionEval P Q f y z e ∈ H := by
  classical
  unfold correctionEval Polynomial.sum
  exact H.sum_mem fun n _ => H.mul_mem
    (H.mul_mem (hcoeff _) (H.pow_mem hz _))
    (eval_mem_subring _ f H hcoeff y hy)

section Field

variable {F : Type*} [Field F]

/-- The nonzero-coordinate case uses the noncommutative finite replacement. -/
theorem replacement_mem_of_ne_zero (P Q : R[X]) (f : R →+* F) (H : Subring F)
    (hcoeff : ∀ a, f a ∈ H) (x y z w : F) (e : ℕ)
    (hdegree : Q.natDegree ≤ e) (hex : x * z = P.eval₂ f y)
    (hew : y * w = Q.eval₂ f x) (hx : x ≠ 0) (hy : y ≠ 0)
    (hyH : y ∈ H) (hzH : z ∈ H) (hwH : w ∈ H) :
    PolynomialExchange.reflectedEval Q f (f (P.coeff 0)) z e / y ∈ H := by
  classical
  have hnorm (a : F) (ha : a ≠ 0) : Normalizes H a :=
    ⟨ha, fun c hc ↦ by
      simpa only [mul_right_comm a c a⁻¹, mul_inv_cancel₀ ha, one_mul] using hc,
      fun c hc ↦ by
      simpa only [mul_right_comm a⁻¹ c a, inv_mul_cancel₀ ha, one_mul] using hc⟩
  have hp : FiniteReplacementPremise H x z y w
      (PolynomialExchange.reflectedEval Q f (f (P.coeff 0)) z e / y)
      1 0 0 Q.support e (fun i ↦ i) (fun i ↦ f (Q.coeff i))
      (fun i ↦ f (Q.coeff i) * f (P.coeff 0) ^ i)
      (fun i ↦ f (P.coeff 0) ^ i) := by
    refine ⟨hnorm x hx, hnorm y hy, ?_, H.one_mem, fun i _ ↦ hcoeff _, by simp,
      ?_, ?_, ?_, ?_⟩
    · intro i hi
      exact (Polynomial.le_natDegree_of_ne_zero (Polynomial.mem_support_iff.mp hi)).trans hdegree
    · intro i _
      refine ⟨(PolynomialExchange.powerCorrection P i).eval₂ f y,
        le_skewPolyRing H y (PolynomialExchange.eval_mem_subring _ f H hcoeff y hyH), ?_⟩
      change y * (PolynomialExchange.powerCorrection P i).eval₂ f y = _
      rw [PolynomialExchange.eval_powerCorrection, ← hex, mul_pow]
      ring
    · rw [mul_comm w y, hew]
      simp only [zero_add, Polynomial.eval₂_eq_sum, Polynomial.sum]
      apply Finset.sum_congr rfl
      intro i _
      ring
    · rw [div_mul_cancel₀ _ hy]
      simp only [mul_zero, zero_add, PolynomialExchange.reflectedEval, Polynomial.sum]
      apply Finset.sum_congr rfl
      intro i _
      ring
    · intro i _
      have hxi : x ^ i ≠ 0 := pow_ne_zero _ hx
      simp [mul_comm, mul_left_comm, hxi]
  apply (Subring.closure_le.mpr ?_ : Subring.closure ((H : Set F) ∪ {z, w, y}) ≤ H)
    hp.zss_mem
  rintro a (ha | ha)
  · exact ha
  · simp only [Set.mem_insert_iff, Set.mem_singleton_iff] at ha
    rcases ha with rfl | rfl | rfl
    · exact hzH
    · exact hwH
    · exact hyH


/-- Concrete polynomial exchange data imply membership of the next partner. -/
theorem replacement_mem (P Q : R[X]) (f : R →+* F) (H : Subring F)
    (hcoeff : ∀ a, f a ∈ H) (x y z w : F) (e : ℕ)
    (hdegree : Q.natDegree ≤ e) (hex : x * z = P.eval₂ f y)
    (hew : y * w = Q.eval₂ f x) (hy : y ≠ 0)
    (hyH : y ∈ H) (hzH : z ∈ H) (hwH : w ∈ H) :
    reflectedEval Q f (f (P.coeff 0)) z e / y ∈ H := by
  by_cases hx : x ≠ 0
  · exact replacement_mem_of_ne_zero P Q f H hcoeff x y z w e hdegree hex hew
      hx hy hyH hzH hwH
  have hform : reflectedEval Q f (f (P.coeff 0)) z e / y =
      z ^ e * w - correctionEval P Q f y z e := by
    apply (div_eq_iff hy).mpr
    have hid := replacement_identity P Q f x y z e hdegree hex
    rw [← hew] at hid
    linear_combination -hid
  rw [hform]
  exact H.sub_mem (H.mul_mem (H.pow_mem hzH e) hwH)
    (correctionEval_mem P Q f H hcoeff y z hyH hzH e)

end Field
end TauCeti.Laurent.PolynomialExchange
