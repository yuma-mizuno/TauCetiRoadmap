/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import Mathlib.Algebra.MonoidAlgebra.Lift
public import Mathlib.Algebra.MonoidAlgebra.MapDomain
public import Mathlib.Data.Finsupp.Basic

/-! # Laurent Evaluation -/

@[expose] public section

noncomputable section
namespace TauCeti.Laurent.LaurentEvaluation
variable {R S T I J : Type*} [CommRing R] [CommRing S] [CommRing T]
/-- Multivariable Laurent polynomials over R, represented by the group algebra of finite integer
exponent vectors.
-/
abbrev Ring (R I : Type*) [CommRing R] := AddMonoidAlgebra R (I →₀ ℤ)

/-- The homomorphism taking an integer to the corresponding power of a unit. -/
def integerPower (u : Sˣ) : ℤ →+ Additive Sˣ where
  toFun n := Additive.ofMul (u ^ n)
  map_zero' := by simp
  map_add' a b := by simp [zpow_add]

/-- Evaluate a finite integer exponent vector as the product of the assigned unit powers. -/
def exponentCharacter (x : I → Sˣ) : (I →₀ ℤ) →+ Additive Sˣ :=
  Finsupp.liftAddHom (fun i => integerPower (x i))

/-- The field or ring value of a Laurent exponent monomial, regarded as a multiplicative
character.
-/
def monomialCharacter (x : I → Sˣ) : Multiplicative (I →₀ ℤ) →* S where
  toFun a := ((exponentCharacter x a.toAdd).toMul : S)
  map_one' := by simp
  map_mul' a b := by simp

/-- Evaluation of multivariable Laurent polynomials at units, over arbitrary
commutative coefficient rings. -/
def eval (c : R →+* S) (x : I → Sˣ) : Ring R I →+* S :=
  AddMonoidAlgebra.liftNCRingHom c (monomialCharacter x) (fun _ _ => Commute.all _ _)

@[simp] theorem eval_single (c : R →+* S) (x : I → Sˣ) (a : I →₀ ℤ) (r : R) :
    eval c x (AddMonoidAlgebra.single a r) =
      c r * ((exponentCharacter x a).toMul : S) := by
  simp [eval, monomialCharacter]

theorem eval_constant (c : R →+* S) (x : I → Sˣ) (r : R) :
    eval c x (AddMonoidAlgebra.single 0 r) = c r := by simp

@[simp] theorem exponentCharacter_single (x : I → Sˣ) (i : I) (n : ℤ) :
    exponentCharacter x (Finsupp.single i n) = Additive.ofMul (x i ^ n) := by
  simp [exponentCharacter, integerPower]

theorem eval_variable_power (c : R →+* S) (x : I → Sˣ) (i : I) (n : ℤ) :
    eval c x (AddMonoidAlgebra.single (Finsupp.single i n) 1) = ((x i ^ n : Sˣ) : S) := by
  simp

/-- Every monomial evaluates to its coefficient times the finite product of
integer powers of the assigned units. -/
theorem eval_single_product (c : R →+* S) (x : I → Sˣ) (a : I →₀ ℤ) (r : R) :
    eval c x (AddMonoidAlgebra.single a r) =
      c r * ∏ i ∈ a.support, ((x i ^ a i : Sˣ) : S) := by
  classical
  simp [exponentCharacter, Finsupp.liftAddHom_apply, Finsupp.sum,
    integerPower]

/-- Evaluation commutes with a homomorphism of target rings. -/
theorem eval_natural (c : R →+* S) (h : S →+* T) (x : I → Sˣ)
    (p : Ring R I) :
    h (eval c x p) = eval (h.comp c) (fun i => Units.map h.toMonoidHom (x i)) p := by
  classical
  conv_lhs => rw [← AddMonoidAlgebra.sum_coeff_single p]
  conv_rhs => rw [← AddMonoidAlgebra.sum_coeff_single p]
  simp only [Finsupp.sum, map_sum]
  apply Finset.sum_congr rfl
  intro a ha
  rw [eval_single_product, eval_single_product]
  simp only [map_mul, map_prod, RingHom.comp_apply]
  congr 1
  apply Finset.prod_congr rfl
  intro i hi
  rw [← map_zpow, Units.coe_map]
  rfl

end TauCeti.Laurent.LaurentEvaluation
