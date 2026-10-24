/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import Mathlib.Algebra.Polynomial.Div
public import Mathlib.RingTheory.Ideal.Span
public import Mathlib.Algebra.Ring.Subring.Basic
public import Mathlib.Tactic.Ring

/-! Polynomial cancellation and exact ideal remainders for the caterpillar step.
The ring statements apply in any Laurent chart once its units and evaluation maps
have been constructed; the field statement supplies the actual cancellation. -/

@[expose] public section

namespace TauCeti.Laurent

open Polynomial

noncomputable section

variable {B : Type*} [CommRing B]

/-- The polynomial obtained by the two forward substitutions. -/
def substitutionPolynomial (Q R : B[X]) (yinv : B) : B[X] :=
  R.comp (C yinv * Q)

@[simp] theorem substitutionPolynomial_eval (Q R : B[X]) (yinv t : B) :
    (substitutionPolynomial Q R yinv).eval t = R.eval (yinv * Q.eval t) := by
  simp [substitutionPolynomial]

theorem divX_eval_identity (f : B[X]) (z : B) :
    z * f.divX.eval z = f.eval z - f.eval 0 := by
  have h := congrArg (Polynomial.eval z) (Polynomial.X_mul_divX_add f)
  simp only [eval_add, eval_mul, eval_X, eval_C, coeff_zero_eq_eval_zero] at h
  exact eq_sub_of_add_eq h

@[simp] theorem divX_eval_zero (f : B[X]) : f.divX.eval 0 = f.coeff 1 := by
  simp [← coeff_zero_eq_eval_zero]

/-- Exact cancellation expressed without division, valid already in a ring. -/
theorem exact_cancellation_mul (f : B[X]) (x z E A : B)
    (hE : E = x * z) (hconstant : f.eval 0 = A * E) :
    z * (f.divX.eval z + x * A) = f.eval z := by
  rw [mul_add, divX_eval_identity, hconstant, hE]
  ring

/-- A polynomial differs from its constant term by a multiple of its input. -/
theorem polynomial_remainder_mem (p : B[X]) (z E : B) (hz : E ∣ z) :
    p.eval z - p.eval 0 ∈ Ideal.span ({E} : Set B) := by
  rw [Ideal.mem_span_singleton]
  exact hz.trans (by simpa using Polynomial.sub_dvd_eval_sub z 0 p)

/-- The first residue, with the inverse of the unit `y` displayed explicitly. -/
theorem first_remainder_mem (Q : B[X]) (yinv z E : B) (hz : E ∣ z) :
    yinv * Q.eval z - yinv * Q.eval 0 ∈ Ideal.span ({E} : Set B) := by
  rw [← mul_sub]
  exact Ideal.mul_mem_left _ _ (polynomial_remainder_mem Q z E hz)

/-- The second residue is exactly the coefficient of degree one plus `x * A`. -/
theorem second_remainder_mem (f : B[X]) (x z E A v : B) (hz : E ∣ z)
    (hv : v = f.divX.eval z + x * A) :
    v - (f.coeff 1 + x * A) ∈ Ideal.span ({E} : Set B) := by
  rw [hv]
  have h := polynomial_remainder_mem f.divX z E hz
  simpa only [divX_eval_zero, add_sub_add_right_eq_sub] using h

/-- Polynomial evaluation stays in a subring if all coefficients and the input do. -/
theorem polynomial_eval_mem (S : Subring B) (p : B[X]) (z : B)
    (hp : ∀ n, p.coeff n ∈ S) (hz : z ∈ S) : p.eval z ∈ S := by
  rw [Polynomial.eval_eq_sum, Polynomial.sum_def]
  exact S.sum_mem fun n _ => S.mul_mem (hp n) (S.pow_mem hz n)

theorem cancelled_expression_mem (S : Subring B) (f : B[X]) (x z A : B)
    (hf : ∀ n, f.coeff n ∈ S) (hx : x ∈ S) (hz : z ∈ S) (hA : A ∈ S) :
    f.divX.eval z + x * A ∈ S := by
  exact S.add_mem (polynomial_eval_mem S f.divX z
    (fun n => by simpa using hf (n + 1)) hz) (S.mul_mem hx hA)

/-- The principal ideals coincide when the original coordinate is a unit. -/
theorem exchange_principal_ideal (x z E : B) (hx : IsUnit x) (hE : E = x * z) :
    Ideal.span ({E} : Set B) = Ideal.span ({z} : Set B) := by
  apply le_antisymm
  · apply Ideal.span_le.2
    intro a ha
    rcases Set.mem_singleton_iff.1 ha with rfl
    rw [hE]
    exact Ideal.mul_mem_left _ _ (Ideal.subset_span (Set.mem_singleton z))
  · apply Ideal.span_le.2
    intro a ha
    rcases Set.mem_singleton_iff.1 ha with rfl
    change a ∈ Ideal.span ({E} : Set B)
    rw [Ideal.mem_span_singleton, hE]
    rcases hx with ⟨u, rfl⟩
    exact ⟨↑u⁻¹, by simp [mul_assoc, mul_comm]⟩

section Field

variable {K : Type*} [Field K]

/-- Actual Laurent expression for the last exchanged coordinate. -/
theorem exact_cancellation (f : K[X]) (x z E A : K) (hz : z ≠ 0)
    (hE : E = x * z) (hconstant : f.eval 0 = A * E) :
    f.eval z / z = f.divX.eval z + x * A := by
  apply (div_eq_iff hz).2
  simpa only [mul_comm] using (exact_cancellation_mul f x z E A hE hconstant).symm

theorem exchange_exact_cancellation (Q R : K[X]) (x y z E A : K)
    (hz : z ≠ 0) (hE : E = x * z)
    (hcompat : R.eval (Q.eval 0 / y) = A * E) :
    R.eval (Q.eval z / y) / z =
      (substitutionPolynomial Q R y⁻¹).divX.eval z + x * A := by
  have hc : (substitutionPolynomial Q R y⁻¹).eval 0 = A * E := by
    simpa [div_eq_mul_inv, mul_comm] using hcompat
  simpa [div_eq_mul_inv, mul_comm] using
    exact_cancellation (substitutionPolynomial Q R y⁻¹) x z E A hz hE hc

/-- The cancelled quotient is an actual element of the prescribed chart subring. -/
theorem exact_cancellation_mem (S : Subring K) (f : K[X]) (x z E A : K)
    (hz : z ≠ 0) (hE : E = x * z) (hconstant : f.eval 0 = A * E)
    (hf : ∀ n, f.coeff n ∈ S) (hx : x ∈ S) (hzS : z ∈ S) (hA : A ∈ S) :
    f.eval z / z ∈ S := by
  rw [exact_cancellation f x z E A hz hE hconstant]
  exact cancelled_expression_mem S f x z A hf hx hzS hA

end Field

end

end TauCeti.Laurent
