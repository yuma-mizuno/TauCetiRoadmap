/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import Mathlib.Algebra.Polynomial.RingDivision
public import Mathlib.RingTheory.Polynomial.Quotient
public import Mathlib.Tactic.Ring

/-! Elimination of a fresh coefficient parameter with unit coefficient.
The coefficient ring may already contain every other parameter and all mutable
Laurent variables. Constants in this polynomial ring precisely avoid the chosen
parameter. -/

@[expose] public section

namespace TauCeti.Laurent

open Polynomial

noncomputable section

variable {S : Type*} [CommRing S]

/-- The linear polynomial with unit leading coefficient m and constant coefficient b. -/
def genericLinear (m : Sˣ) (b : S) : S[X] := C (m : S) * X + C b
theorem genericLinear_factor (m : Sˣ) (b : S) :
    genericLinear m b = C (m : S) * (X - C (-(↑m⁻¹ * b))) := by
  simp only [genericLinear, map_neg, map_mul, sub_neg_eq_add, mul_add]
  congr 1
  rw [← mul_assoc, ← C_mul]
  simp

theorem genericLinear_dvd_iff (m : Sˣ) (b : S) (p : S[X]) :
    genericLinear m b ∣ p ↔ p.eval (-(↑m⁻¹ * b)) = 0 := by
  rw [genericLinear_factor, (isUnit_C.mpr m.isUnit).mul_left_dvd,
    dvd_iff_isRoot, IsRoot.def]

theorem genericLinear_ker_eval (m : Sˣ) (b : S) :
    RingHom.ker (Polynomial.evalRingHom (-(↑m⁻¹ * b))) =
      Ideal.span ({genericLinear m b} : Set S[X]) := by
  ext p
  simp only [RingHom.mem_ker, Polynomial.coe_evalRingHom, Ideal.mem_span_singleton,
    genericLinear_dvd_iff]

/-- Multiplying by the unit coefficient does not change the elimination ideal. -/
theorem genericLinear_span_eq (m : Sˣ) (b : S) :
    Ideal.span ({genericLinear m b} : Set S[X]) =
      Ideal.span ({X - C (-(↑m⁻¹ * b))} : Set S[X]) :=
  (genericLinear_ker_eval m b).symm.trans (Polynomial.ker_evalRingHom _)

/-- The normalized elimination quotient, with evaluation and constants as inverse maps.
`genericLinear_span_eq` identifies its ideal with that of `genericLinear`. -/
def genericLinearQuotientEquiv (m : Sˣ) (b : S) :=
  Polynomial.quotientSpanXSubCAlgEquiv (R := S) (-(↑m⁻¹ * b))

section Domain

variable [IsDomain S]

theorem genericLinear_prime (m : Sˣ) (b : S) : Prime (genericLinear m b) := by
  rw [genericLinear_factor]
  exact prime_mul_iff.mpr (Or.inr ⟨isUnit_C.mpr m.isUnit, prime_X_sub_C _⟩)

omit [IsDomain S] in
theorem genericLinear_not_dvd_constant (m : Sˣ) (b q : S) (hq : q ≠ 0) :
    ¬ genericLinear m b ∣ C q := by
  simpa [genericLinear_dvd_iff] using hq

/-- Freshness of one coefficient proves relative primality without a UFD hypothesis. -/
theorem genericLinear_relPrime_constant (m : Sˣ) (b q : S) (hq : q ≠ 0) :
    IsRelPrime (genericLinear m b) (C q) :=
  (genericLinear_prime m b).irreducible.isRelPrime_iff_not_dvd.mpr
    (genericLinear_not_dvd_constant m b q hq)

end Domain

end

end TauCeti.Laurent
