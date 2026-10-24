/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.InitialSeed
public import TauCetiRoadmap.ClusterAlgebras.PositiveSemifieldEvaluation
public import TauCetiRoadmap.LaurentPhenomenon.PositiveRealization
public import Mathlib.Data.Finsupp.Defs

/-!
# Tropical principal coefficients

The auxiliary addition is coordinatewise minimum on finitely supported
integer exponents.  This is distinct from addition in the coefficient group
ring and does not induce an additive map to an arbitrary semifield.
-/

@[expose] public section

namespace TauCeti.Cluster

noncomputable section
open TauCeti.Laurent

/-- The free multiplicative tropical group on I, represented by finite integer exponent vectors. -/
abbrev Trop (I : Type*) := Multiplicative (I →₀ ℤ)

namespace Trop

/-- Identify the additive form of the tropical multiplicative group with its integer exponent
lattice.
-/
def exponentEquiv {I : Type*} : Additive (Trop I) ≃+ (I →₀ ℤ) where
  toFun a := a.toMul.toAdd
  invFun a := Additive.ofMul (Multiplicative.ofAdd a)
  left_inv := by intro a; rfl
  right_inv := by intro a; rfl
  map_add' := by intro a b; rfl


variable {I : Type*}

/-- The coordinatewise minimum operation defining tropical auxiliary addition. -/
def minimum (a b : Trop I) : Trop I :=
  Multiplicative.ofAdd <| Finsupp.zipWith min (by simp) a.toAdd b.toAdd

instance : Add (Trop I) := ⟨minimum⟩

@[simp] theorem add_apply (a b : Trop I) (i : I) :
    (a + b).toAdd i = min (a.toAdd i) (b.toAdd i) := by
  simp [HAdd.hAdd, Add.add, minimum]

instance : AddCommSemigroup (Trop I) where
  add_assoc a b c := by
    ext i
    simp [min_assoc]
  add_comm a b := by
    ext i
    simp [min_comm]

instance : Distrib (Trop I) where
  left_distrib a b c := by
    ext i
    simp [min_add_add_left]
  right_distrib a b c := by
    ext i
    simp [min_add_add_right]

instance : CoefficientSemifield (Trop I) := {}

/-- The tropical generator with exponent one at i and zero at every other index. -/
def generator (i : I) : Trop I :=
  Multiplicative.ofAdd (Finsupp.single i 1)

@[simp] theorem generator_apply [DecidableEq I] (i j : I) :
    (generator i).toAdd j = if i = j then 1 else 0 := by
  simp [generator, Finsupp.single_apply]

end Trop

theorem tropicalCoefficientMutation_apply {I : Type*} (yi yk : Trop I)
    (b : ℤ) (f : I) :
    (coefficientMutation yi yk (yk + 1) b).toAdd f =
      yi.toAdd f + positivePart b * yk.toAdd f -
        b * min (yk.toAdd f) 0 := by
  simp [coefficientMutation, Trop.add_apply, mul_comm, mul_left_comm]
  ring

/-- The tropical coefficient recursion is exactly the frozen-row part of
extended matrix mutation, including mixed-sign columns. -/
theorem tropical_frozen_increment (b c : ℤ) :
    positivePart b * c - b * min c 0 =
      positivePart c * positivePart b -
        positivePart (-c) * positivePart (-b) := by
  have hmin : min c 0 = -positivePart (-c) := by
    unfold positivePart
    omega
  have hb : b = positivePart b - positivePart (-b) := by
    unfold positivePart
    omega
  have hc : c = positivePart c - positivePart (-c) := by
    unfold positivePart
    omega
  calc
    positivePart b * c - b * min c 0 =
        positivePart b * (positivePart c - positivePart (-c)) -
          (positivePart b - positivePart (-b)) * (-positivePart (-c)) := by
            rw [← hb, ← hc, ← hmin]
    _ = _ := by ring

variable {I : Type*} [DecidableEq I]

/-- The initial principal-coefficient seed attached to a skew-symmetrizable
mutable exchange matrix. -/
def principalSeed {d : I → ℤ} (B : I → I → ℤ)
    (hB : ∀ i j, d i * B i j = -(d j * B j i)) :
    MatrixSeed (Trop I) I d where
  matrix := B
  coefficient := Trop.generator
  symmetrized := hB

omit [DecidableEq I] in
@[simp] theorem principalSeed_matrix {d : I → ℤ} (B : I → I → ℤ)
    (hB : ∀ i j, d i * B i j = -(d j * B j i)) :
    (principalSeed B hB).matrix = B := by
  classical
  exact rfl

omit [DecidableEq I] in
@[simp] theorem principalSeed_coefficient {d : I → ℤ} (B : I → I → ℤ)
    (hB : ∀ i j, d i * B i j = -(d j * B j i)) (i : I) :
    (principalSeed B hB).coefficient i = Trop.generator i := by
  classical
  exact rfl

/-- The frozen row of the extended matrix is the exponent of the corresponding
principal coefficient.  This definition does not use any Laurent theorem. -/
def principalFrozenRow {d : I → ℤ} (hd : ∀ i, 0 < d i)
    (B : I → I → ℤ) (hB : ∀ i j, d i * B i j = -(d j * B j i))
    (w : List I) (f j : I) : ℤ :=
  ((mutateWord (MatrixSeed.mutate hd) w (principalSeed B hB)).coefficient j).toAdd f

@[simp] theorem principalFrozenRow_nil {d : I → ℤ} (hd : ∀ i, 0 < d i)
    (B : I → I → ℤ) (hB : ∀ i j, d i * B i j = -(d j * B j i))
    (f j : I) :
    principalFrozenRow hd B hB [] f j = if j = f then 1 else 0 := by
  simp [principalFrozenRow]

theorem principalFrozenRow_append_self {d : I → ℤ} (hd : ∀ i, 0 < d i)
    (B : I → I → ℤ) (hB : ∀ i j, d i * B i j = -(d j * B j i))
    (w : List I) (f k : I) :
    principalFrozenRow hd B hB (w ++ [k]) f k =
      -principalFrozenRow hd B hB w f k := by
  simp [principalFrozenRow, mutateWord_append, MatrixSeed.mutate]

theorem principalFrozenRow_append_other {d : I → ℤ} (hd : ∀ i, 0 < d i)
    (B : I → I → ℤ) (hB : ∀ i j, d i * B i j = -(d j * B j i))
    (w : List I) (f k j : I) (hjk : j ≠ k) :
    principalFrozenRow hd B hB (w ++ [k]) f j =
      principalFrozenRow hd B hB w f j +
        positivePart ((mutateWord (MatrixSeed.mutate hd) w
          (principalSeed B hB)).matrix k j) * principalFrozenRow hd B hB w f k -
        (mutateWord (MatrixSeed.mutate hd) w
          (principalSeed B hB)).matrix k j *
          min (principalFrozenRow hd B hB w f k) 0 := by
  rw [principalFrozenRow, mutateWord_append]
  simp only [mutateWord_cons, mutateWord_nil]
  simp [MatrixSeed.mutate, hjk, tropicalCoefficientMutation_apply,
    principalFrozenRow]

/-- The explicit frozen-row matrix-mutation formula. -/
theorem principalFrozenRow_extended_mutation {d : I → ℤ} (hd : ∀ i, 0 < d i)
    (B : I → I → ℤ) (hB : ∀ i j, d i * B i j = -(d j * B j i))
    (w : List I) (f k j : I) (hjk : j ≠ k) :
    principalFrozenRow hd B hB (w ++ [k]) f j =
      principalFrozenRow hd B hB w f j +
        positivePart (principalFrozenRow hd B hB w f k) *
          positivePart ((mutateWord (MatrixSeed.mutate hd) w
            (principalSeed B hB)).matrix k j) -
        positivePart (-principalFrozenRow hd B hB w f k) *
          positivePart (-((mutateWord (MatrixSeed.mutate hd) w
            (principalSeed B hB)).matrix k j)) := by
  rw [principalFrozenRow_append_other hd B hB w f k j hjk]
  have hinc := tropical_frozen_increment
    ((mutateWord (MatrixSeed.mutate hd) w (principalSeed B hB)).matrix k j)
    (principalFrozenRow hd B hB w f k)
  linear_combination hinc

/-- Integer powers of one coefficient, viewed as an additive homomorphism. -/
def coefficientIntegerPower {P : Type*} [CoefficientSemifield P]
    (p : P) : ℤ →+ Additive P where
  toFun n := Additive.ofMul (p ^ n)
  map_zero' := by simp
  map_add' a b := by simp [zpow_add]

/-- A free principal coefficient monomial can be evaluated at arbitrary
initial coefficients.  Only multiplication is preserved; tropical auxiliary
addition is deliberately absent from the type. -/
def principalCoefficientHom {P : Type*} [CoefficientSemifield P]
    (y : I → P) : Additive (Trop I) →+ Additive P where
  toFun a := Finsupp.liftAddHom (fun i => coefficientIntegerPower (y i)) a.toMul.toAdd
  map_zero' := by simp
  map_add' a b := by simp [map_add]

omit [DecidableEq I] in
@[simp] theorem principalCoefficientHom_generator {P : Type*}
    [CoefficientSemifield P] (y : I → P) (i : I) :
    principalCoefficientHom y (Additive.ofMul (Trop.generator i)) =
      Additive.ofMul (y i) := by
  classical
  simp [principalCoefficientHom, Trop.generator, coefficientIntegerPower]

/-- Semifield evaluation of a universal positive rational expression in the
principal coefficient variables.  This is valid for every initial tuple `y`;
it does not claim a tropical-semifield homomorphism to `P`. -/
def principalPositiveEvaluate {P : Type*} [CoefficientSemifield P]
    (y : I → P)
    (x : TauCeti.Laurent.PositiveExpression (Additive (Trop I))) : P := by
  letI : IsDomain (AddMonoidAlgebra ℤ (Additive (Trop I))) :=
    CoefficientSemifield.coefficientGroupRing_isDomain
  exact positiveExpressionEvaluateAt (principalCoefficientHom y) x

omit [DecidableEq I] in
theorem principalPositiveEvaluate_eq_of_universal_eq
    {P : Type*} [CoefficientSemifield P]
    (y : I → P)
    (x z : TauCeti.Laurent.PositiveExpression (Additive (Trop I)))
    (h : x.evaluate (algebraMap _
      (FractionRing (AddMonoidAlgebra ℤ (Additive (Trop I))))) =
      z.evaluate (algebraMap _
        (FractionRing (AddMonoidAlgebra ℤ (Additive (Trop I)))))) :
    principalPositiveEvaluate y x = principalPositiveEvaluate y z := by
  exact positiveExpressionEvaluateAt_eq_of_universal_eq
    (principalCoefficientHom y) x z h

/-- The substitution `x_i ↦ 1`, `u_i ↦ y_i` on exponent lattices.
It is a multiplicative specialization, not an ordinary ring homomorphism
from the full rational-function field. -/
def principalAtOneHom {P : Type*} [CoefficientSemifield P]
    (y : I → P) :
    (Additive (Trop I) × (I →₀ ℤ)) →+ Additive P where
  toFun t := principalCoefficientHom y t.1
  map_zero' := by simp
  map_add' a b := by simp

/-- Evaluate a principal positive coordinate expression at mutable variables
equal to one and principal variables equal to `y`.  This is the denominator
evaluation needed for separation, available before proving polynomiality of
the principal `F`-expression. -/
def principalExpressionAtOne {P : Type*} [CoefficientSemifield P]
    (y : I → P)
    (x : TauCeti.Laurent.PositiveExpression
      (Additive (Trop I) × (I →₀ ℤ))) : P := by
  letI : IsDomain (TauCeti.Laurent.TotalLaurentRing (Additive (Trop I)) I) :=
    TauCeti.Laurent.torsionFreeTotalLaurent_isDomain
  exact positiveExpressionEvaluateAt (principalAtOneHom y) x

omit [DecidableEq I] in
theorem principalExpressionAtOne_eq_of_universal_eq
    {P : Type*} [CoefficientSemifield P]
    (y : I → P)
    (x z : TauCeti.Laurent.PositiveExpression
      (Additive (Trop I) × (I →₀ ℤ)))
    (h : x.evaluate (algebraMap _
      (FractionRing (TauCeti.Laurent.TotalLaurentRing (Additive (Trop I)) I))) =
      z.evaluate (algebraMap _
        (FractionRing (TauCeti.Laurent.TotalLaurentRing (Additive (Trop I)) I)))) :
    principalExpressionAtOne y x = principalExpressionAtOne y z := by
  exact positiveExpressionEvaluateAt_eq_of_universal_eq
    (principalAtOneHom y) x z h

end
end TauCeti.Cluster
