/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.AlgebraicCaterpillar
public import TauCetiRoadmap.LaurentPhenomenon.PositiveFraction
public import TauCetiRoadmap.LaurentPhenomenon.FiniteLaurent
public import Mathlib.Data.ZMod.Basic

/-! Regression checks for the reusable algebraic and finite-specialization APIs.
The characteristic-two example uses a finite expression with one actual inverse;
it cannot satisfy nonvanishing of every positive polynomial. -/

@[expose] public section
noncomputable section
namespace TauCeti.Laurent.ReusableAPIAudit

/-- Evaluate all Laurent monomials at one and reduce coefficients modulo two. -/
def modTwo : AddMonoidAlgebra ℤ ℤ →+* ZMod 2 :=
  (AddMonoidAlgebra.lift ℤ (ZMod 2) ℤ 1).toRingHom

/-- A finite rational expression whose sole inverted operand is one. -/
def finiteExpression : PositiveExpression ℤ :=
  .inv (.atom 1 one_ne_zero)

theorem finiteExpression_defined : finiteExpression.DefinedAt modTwo := by
  simp [finiteExpression, PositiveExpression.DefinedAt, PositiveExpression.evaluate]

/-- The representative is proved in the universal rational function field. -/
theorem finiteExpression_universal :
    finiteExpression.evaluate
      (algebraMap (AddMonoidAlgebra ℤ ℤ) (FractionRing (AddMonoidAlgebra ℤ ℤ))) =
    algebraMap (AddMonoidAlgebra ℤ ℤ) (FractionRing (AddMonoidAlgebra ℤ ℤ)) 1 := by
  simp [finiteExpression, PositiveExpression.evaluate]

/-- The finite-denominator theorem genuinely specializes into characteristic two. -/
theorem finiteExpression_specializes : finiteExpression.evaluate modTwo = modTwo 1 :=
  PositiveExpression.specialize_laurent_at modTwo finiteExpression
    finiteExpression_defined 1 finiteExpression_universal

/-- Global positive nonvanishing is impossible here: the positive constant two
already maps to zero. Thus the finite specialization result is strictly usable
without that global hypothesis. -/
theorem not_global_positive_nonvanishing :
    ¬ (∀ p : AddMonoidAlgebra ℕ ℤ,
      positiveCast p ≠ 0 → modTwo (positiveCast p) ≠ 0) := by
  intro h
  have hc : positiveCast ((1 : AddMonoidAlgebra ℕ ℤ) + 1) ≠ 0 := by
    apply positiveCast_ne_zero
    exact positive_add_ne_zero (G := ℤ) (p := 1) (q := 1) one_ne_zero
  have hh := h (1 + 1) hc
  apply hh
  rw [map_add, map_one, map_add, map_one]
  decide

/-- Natural convolution stays nonzero even when the exponent group has torsion.
No domain instance for the integer group ring is supplied. -/
theorem positive_product_over_torsion_group (p q : AddMonoidAlgebra ℕ (ZMod 2))
    (hp : p ≠ 0) (hq : q ≠ 0) : p * q ≠ 0 :=
  positive_mul_ne_zero hp hq

end TauCeti.Laurent.ReusableAPIAudit
