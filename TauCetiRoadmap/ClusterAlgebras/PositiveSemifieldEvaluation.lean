/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.Coefficients
public import Mathlib.Algebra.Ring.WithZero
public import Mathlib.Algebra.MonoidAlgebra.Lift
public import TauCetiRoadmap.LaurentPhenomenon.PositiveFraction

/-!
# Evaluating positive coefficient polynomials in a coefficient semifield

Adjoining an additive zero lets finite natural-coefficient sums be evaluated
without treating the coefficient semifield as a ring.  Every nonzero positive
polynomial evaluates to a nonzero element, even when distinct monomials acquire
the same value.
-/

@[expose] public section

namespace TauCeti.Cluster
open TauCeti.Laurent

variable {P : Type*} [CoefficientSemifield P]

instance (priority := 100) instCommSemiringWithZeroCoefficients : CommSemiring (WithZero P) where
  natCast_zero := by rfl
  natCast_succ := by intros; rfl

theorem withZero_add_eq_zero (a b : WithZero P) :
    a + b = 0 ↔ a = 0 ∧ b = 0 := by
  cases a <;> cases b <;> simp [← WithZero.coe_add]

theorem positive_natCast_ne_zero (n : ℕ) (hn : n ≠ 0) :
    (n : WithZero P) ≠ 0 := by
  obtain ⟨m, rfl⟩ := Nat.exists_eq_succ_of_ne_zero hn
  intro h
  have h1 := (withZero_add_eq_zero (m : WithZero P) 1).mp (by simpa using h)
  exact one_ne_zero h1.2

/-- Send a formal coefficient-group monomial to its value in the coefficient semifield with zero
adjoined.
-/
noncomputable def coefficientCharacter : Multiplicative (Additive P) →* WithZero P where
  toFun g := (g.toAdd.toMul : WithZero P)
  map_one' := by simp
  map_mul' a b := by simp

/-- Evaluate a natural-coefficient group polynomial using auxiliary addition
after adjoining zero. -/
noncomputable def positiveCoefficientEval :
    AddMonoidAlgebra ℕ (Additive P) →+* WithZero P :=
  AddMonoidAlgebra.liftNCRingHom (Nat.castRingHom (WithZero P))
    coefficientCharacter (fun _ _ => Commute.all _ _)

@[simp] theorem positiveCoefficientEval_single (g : Additive P) (n : ℕ) :
    positiveCoefficientEval (AddMonoidAlgebra.single g n) =
      (n : WithZero P) * (g.toMul : WithZero P) := by
  rw [positiveCoefficientEval, AddMonoidAlgebra.liftNCRingHom_single]
  change (Nat.castRingHom (WithZero P)) n *
    coefficientCharacter (Multiplicative.ofAdd g) = _
  rfl

private theorem withZero_sum_eq_zero_forall {A : Type*} (s : Finset A)
    (f : A → WithZero P) (h : ∑ a ∈ s, f a = 0) :
    ∀ a ∈ s, f a = 0 := by
  classical
  induction s using Finset.induction_on with
  | empty => simp
  | @insert a s ha ih =>
      simp only [Finset.sum_insert ha] at h
      have hh := (withZero_add_eq_zero _ _).mp h
      intro b hb
      rcases Finset.mem_insert.mp hb with rfl | hs
      · exact hh.1
      · exact ih hh.2 b hs

/-- Positive specialization never kills a nonzero coefficient polynomial. -/
theorem positiveCoefficientEval_ne_zero
    {p : AddMonoidAlgebra ℕ (Additive P)} (hp : p ≠ 0) :
    positiveCoefficientEval p ≠ 0 := by
  intro hzero
  have hsum : ∑ g ∈ p.coeff.support,
      positiveCoefficientEval (AddMonoidAlgebra.single g (p.coeff g)) = 0 := by
    rw [← AddMonoidAlgebra.sum_coeff_single p] at hzero
    simpa only [Finsupp.sum, map_sum] using hzero
  have hall := withZero_sum_eq_zero_forall p.coeff.support
    (fun g => positiveCoefficientEval (AddMonoidAlgebra.single g (p.coeff g))) hsum
  apply hp
  apply AddMonoidAlgebra.coeff_injective
  ext g
  by_cases hg : g ∈ p.coeff.support
  · have hc : p.coeff g ≠ 0 := Finsupp.mem_support_iff.mp hg
    have hn : (p.coeff g : WithZero P) ≠ 0 := positive_natCast_ne_zero _ hc
    have hg' := hall g hg
    simp only [positiveCoefficientEval_single] at hg'
    exact False.elim ((mul_ne_zero hn (by simp)) hg')
  · by_contra hcg
    exact hg (Finsupp.mem_support_iff.mpr hcg)

/-- Nonzero positive polynomials evaluate in the coefficient group itself. -/
noncomputable def positivePolynomialValue
    (p : AddMonoidAlgebra ℕ (Additive P)) (hp : p ≠ 0) : P :=
  WithZero.unzero (positiveCoefficientEval_ne_zero hp)

@[simp] theorem positivePolynomialValue_coe
    (p : AddMonoidAlgebra ℕ (Additive P)) (hp : p ≠ 0) :
    (positivePolynomialValue (P := P) p hp : WithZero P) = positiveCoefficientEval p :=
  WithZero.coe_unzero _

theorem positivePolynomialValue_mul
    (p q : AddMonoidAlgebra ℕ (Additive P)) (hp : p ≠ 0) (hq : q ≠ 0)
    (hpq : p * q ≠ 0) :
    positivePolynomialValue (p * q) hpq =
      positivePolynomialValue p hp * positivePolynomialValue q hq := by
  apply WithZero.coe_inj.mp
  simp [positivePolynomialValue_coe]

theorem positivePolynomialValue_add
    (p q : AddMonoidAlgebra ℕ (Additive P)) (hp : p ≠ 0) (hq : q ≠ 0)
    (hpq : p + q ≠ 0) :
    positivePolynomialValue (p + q) hpq =
      positivePolynomialValue p hp + positivePolynomialValue q hq := by
  apply WithZero.coe_inj.mp
  simp [positivePolynomialValue_coe, WithZero.coe_add]

/-- Evaluate a positive rational representative in an arbitrary coefficient
semifield, using only positive denominators. -/
noncomputable def positiveFractionValue
    (x : TauCeti.Laurent.PositiveFraction (Additive P)) : P :=
  positivePolynomialValue x.numerator x.numerator_ne_zero /
    positivePolynomialValue x.denominator x.denominator_ne_zero

/-- Equality of positive fractions is preserved by semifield evaluation.
The hypothesis is the cross-product equality that follows from equality in
the universal rational-function field. -/
theorem positiveFractionValue_eq_of_cross
    (x y : TauCeti.Laurent.PositiveFraction (Additive P))
    (hcross : x.numerator * y.denominator =
      y.numerator * x.denominator) :
    positiveFractionValue x = positiveFractionValue y := by
  have hmap := congrArg positiveCoefficientEval hcross
  simp only [map_mul] at hmap
  have hcross' :
      positivePolynomialValue (P := P) x.numerator x.numerator_ne_zero *
          positivePolynomialValue (P := P) y.denominator y.denominator_ne_zero =
        positivePolynomialValue (P := P) y.numerator y.numerator_ne_zero *
          positivePolynomialValue (P := P) x.denominator x.denominator_ne_zero := by
    apply WithZero.coe_inj.mp
    simpa only [WithZero.coe_mul, positivePolynomialValue_coe] using hmap
  unfold positiveFractionValue
  apply div_eq_div_iff_mul_eq_mul.mpr
  exact hcross'

theorem positiveFractionValue_mul
    (x y : TauCeti.Laurent.PositiveFraction (Additive P)) :
    positiveFractionValue (x.mul y) =
      positiveFractionValue x * positiveFractionValue y := by
  let hn := TauCeti.Laurent.positive_mul_ne_zero
    x.numerator_ne_zero y.numerator_ne_zero
  let hd := TauCeti.Laurent.positive_mul_ne_zero
    x.denominator_ne_zero y.denominator_ne_zero
  have hnum := positivePolynomialValue_mul x.numerator y.numerator
    x.numerator_ne_zero y.numerator_ne_zero hn
  have hden := positivePolynomialValue_mul x.denominator y.denominator
    x.denominator_ne_zero y.denominator_ne_zero hd
  change positivePolynomialValue (x.numerator * y.numerator) _ /
      positivePolynomialValue (x.denominator * y.denominator) _ =
        positivePolynomialValue x.numerator x.numerator_ne_zero /
          positivePolynomialValue x.denominator x.denominator_ne_zero *
        (positivePolynomialValue y.numerator y.numerator_ne_zero /
          positivePolynomialValue y.denominator y.denominator_ne_zero)
  rw [hnum, hden]
  exact (div_mul_div_comm (α := P) _ _ _ _).symm

private theorem coefficient_fraction_add (a b c d : P) :
    (a * d + c * b) / (b * d) = a / b + c / d := by
  simp only [div_eq_mul_inv, mul_inv_rev, add_mul]
  congr 1
  · calc
      a * d * (d⁻¹ * b⁻¹) = a * (d * d⁻¹) * b⁻¹ := by ac_rfl
      _ = a * b⁻¹ := by simp
  · calc
      c * b * (d⁻¹ * b⁻¹) = c * (b * b⁻¹) * d⁻¹ := by ac_rfl
      _ = c * d⁻¹ := by simp

theorem positiveFractionValue_add
    (x y : TauCeti.Laurent.PositiveFraction (Additive P)) :
    positiveFractionValue (x.add y) =
      positiveFractionValue x + positiveFractionValue y := by
  have h₁ := TauCeti.Laurent.positive_mul_ne_zero
    x.numerator_ne_zero y.denominator_ne_zero
  have h₂ := TauCeti.Laurent.positive_mul_ne_zero
    y.numerator_ne_zero x.denominator_ne_zero
  have h₃ : x.numerator * y.denominator +
      y.numerator * x.denominator ≠ 0 :=
    TauCeti.Laurent.positive_add_ne_zero h₁
  have h₄ := TauCeti.Laurent.positive_mul_ne_zero
    x.denominator_ne_zero y.denominator_ne_zero
  have ha := positivePolynomialValue_add
    (x.numerator * y.denominator) (y.numerator * x.denominator) h₁ h₂ h₃
  have hm₁ := positivePolynomialValue_mul x.numerator y.denominator
    x.numerator_ne_zero y.denominator_ne_zero h₁
  have hm₂ := positivePolynomialValue_mul y.numerator x.denominator
    y.numerator_ne_zero x.denominator_ne_zero h₂
  have hm₃ := positivePolynomialValue_mul x.denominator y.denominator
    x.denominator_ne_zero y.denominator_ne_zero h₄
  change positivePolynomialValue
      (x.numerator * y.denominator + y.numerator * x.denominator) _ /
      positivePolynomialValue (x.denominator * y.denominator) _ =
        positivePolynomialValue x.numerator x.numerator_ne_zero /
          positivePolynomialValue x.denominator x.denominator_ne_zero +
        positivePolynomialValue y.numerator y.numerator_ne_zero /
          positivePolynomialValue y.denominator y.denominator_ne_zero
  rw [ha, hm₁, hm₂, hm₃]
  exact coefficient_fraction_add _ _ _ _

theorem positiveFractionValue_inv
    (x : TauCeti.Laurent.PositiveFraction (Additive P)) :
    positiveFractionValue x.inv = (positiveFractionValue x)⁻¹ := by
  change positivePolynomialValue x.denominator x.denominator_ne_zero /
      positivePolynomialValue x.numerator x.numerator_ne_zero =
        (positivePolynomialValue x.numerator x.numerator_ne_zero /
          positivePolynomialValue x.denominator x.denominator_ne_zero)⁻¹
  rw [inv_div]

/-- Evaluation in `P` depends only on the rational function represented by a
positive fraction.  Injectivity is used in the universal fraction field,
before the possibly noninjective coefficient evaluation. -/
theorem positiveFractionValue_eq_of_universal_eq
    [IsDomain (AddMonoidAlgebra ℤ (Additive P))]
    (x y : TauCeti.Laurent.PositiveFraction (Additive P))
    (h : x.evaluate (algebraMap _
      (FractionRing (AddMonoidAlgebra ℤ (Additive P)))) =
      y.evaluate (algebraMap _
        (FractionRing (AddMonoidAlgebra ℤ (Additive P))))) :
    positiveFractionValue x = positiveFractionValue y := by
  let a : AddMonoidAlgebra ℤ (Additive P) →+*
      FractionRing (AddMonoidAlgebra ℤ (Additive P)) := algebraMap _ _
  have hdx : a (TauCeti.Laurent.positiveCast x.denominator) ≠ 0 :=
    IsFractionRing.to_map_eq_zero_iff.not.mpr
      (TauCeti.Laurent.positiveCast_ne_zero x.denominator_ne_zero)
  have hdy : a (TauCeti.Laurent.positiveCast y.denominator) ≠ 0 :=
    IsFractionRing.to_map_eq_zero_iff.not.mpr
      (TauCeti.Laurent.positiveCast_ne_zero y.denominator_ne_zero)
  have hcrossZ :
      TauCeti.Laurent.positiveCast x.numerator *
          TauCeti.Laurent.positiveCast y.denominator =
        TauCeti.Laurent.positiveCast y.numerator *
          TauCeti.Laurent.positiveCast x.denominator := by
    apply IsFractionRing.injective (AddMonoidAlgebra ℤ (Additive P))
      (FractionRing (AddMonoidAlgebra ℤ (Additive P)))
    simp only [map_mul]
    exact (div_eq_div_iff hdx hdy).mp h
  have hcross : x.numerator * y.denominator =
      y.numerator * x.denominator := by
    apply TauCeti.Laurent.positiveCast_injective
    simpa only [map_mul] using hcrossZ
  exact positiveFractionValue_eq_of_cross x y hcross

variable {G : Type*} [AddCommGroup G]

/-- Map a positive rational representative along a coefficient-group map.
Natural coefficients cannot cancel, so both images remain nonzero. -/
noncomputable def mapPositiveFraction (η : G →+ Additive P)
    (x : TauCeti.Laurent.PositiveFraction G) :
    TauCeti.Laurent.PositiveFraction (Additive P) where
  numerator := AddMonoidAlgebra.mapDomainRingHom ℕ η x.numerator
  denominator := AddMonoidAlgebra.mapDomainRingHom ℕ η x.denominator
  numerator_ne_zero := TauCeti.Laurent.positive_mapDomain_ne_zero η x.numerator_ne_zero
  denominator_ne_zero := TauCeti.Laurent.positive_mapDomain_ne_zero η x.denominator_ne_zero

/-- Specialize exponent-group coefficients along eta and evaluate the resulting positive fraction
in P.
-/
noncomputable def positiveFractionEvaluateAt (η : G →+ Additive P)
    (x : TauCeti.Laurent.PositiveFraction G) : P :=
  positiveFractionValue (mapPositiveFraction η x)

theorem mapPositiveFraction_add
    (η : G →+ Additive P)
    (x y : TauCeti.Laurent.PositiveFraction G) :
    mapPositiveFraction η (x.add y) =
      (mapPositiveFraction η x).add (mapPositiveFraction η y) := by
  cases x
  cases y
  simp [mapPositiveFraction, TauCeti.Laurent.PositiveFraction.add, map_add, map_mul]

theorem mapPositiveFraction_mul
    (η : G →+ Additive P)
    (x y : TauCeti.Laurent.PositiveFraction G) :
    mapPositiveFraction η (x.mul y) =
      (mapPositiveFraction η x).mul (mapPositiveFraction η y) := by
  cases x
  cases y
  simp [mapPositiveFraction, TauCeti.Laurent.PositiveFraction.mul, map_mul]

theorem mapPositiveFraction_inv
    (η : G →+ Additive P)
    (x : TauCeti.Laurent.PositiveFraction G) :
    mapPositiveFraction η x.inv = (mapPositiveFraction η x).inv := by
  cases x
  rfl

/-- Evaluation in any coefficient semifield depends only on the universal
subtraction-free rational function, even when `η` identifies monomials. -/
theorem positiveFractionEvaluateAt_eq_of_universal_eq
    [IsDomain (AddMonoidAlgebra ℤ G)]
    (η : G →+ Additive P)
    (x y : TauCeti.Laurent.PositiveFraction G)
    (h : x.evaluate (algebraMap _ (FractionRing (AddMonoidAlgebra ℤ G))) =
      y.evaluate (algebraMap _ (FractionRing (AddMonoidAlgebra ℤ G)))) :
    positiveFractionEvaluateAt η x = positiveFractionEvaluateAt η y := by
  let a : AddMonoidAlgebra ℤ G →+* FractionRing (AddMonoidAlgebra ℤ G) :=
    algebraMap _ _
  have hdx : a (TauCeti.Laurent.positiveCast x.denominator) ≠ 0 :=
    IsFractionRing.to_map_eq_zero_iff.not.mpr
      (TauCeti.Laurent.positiveCast_ne_zero x.denominator_ne_zero)
  have hdy : a (TauCeti.Laurent.positiveCast y.denominator) ≠ 0 :=
    IsFractionRing.to_map_eq_zero_iff.not.mpr
      (TauCeti.Laurent.positiveCast_ne_zero y.denominator_ne_zero)
  have hcrossZ :
      TauCeti.Laurent.positiveCast x.numerator *
          TauCeti.Laurent.positiveCast y.denominator =
        TauCeti.Laurent.positiveCast y.numerator *
          TauCeti.Laurent.positiveCast x.denominator := by
    apply IsFractionRing.injective (AddMonoidAlgebra ℤ G)
      (FractionRing (AddMonoidAlgebra ℤ G))
    simp only [map_mul]
    exact (div_eq_div_iff hdx hdy).mp h
  have hcross : x.numerator * y.denominator =
      y.numerator * x.denominator := by
    apply TauCeti.Laurent.positiveCast_injective
    simpa only [map_mul] using hcrossZ
  unfold positiveFractionEvaluateAt
  apply positiveFractionValue_eq_of_cross
  exact map_mul (AddMonoidAlgebra.mapDomainRingHom ℕ η) x.numerator y.denominator ▸
    (map_mul (AddMonoidAlgebra.mapDomainRingHom ℕ η) y.numerator x.denominator ▸
      congrArg (AddMonoidAlgebra.mapDomainRingHom ℕ η) hcross)

/-- Evaluate a finite subtraction-free expression at arbitrary coefficient
values.  The value is defined through a positive fraction, so no denominator
can vanish in the target semifield. -/
noncomputable def positiveExpressionEvaluateAt
    (η : G →+ Additive P) (x : PositiveExpression G) : P :=
  positiveFractionEvaluateAt η x.representatives

theorem positiveExpressionEvaluateAt_add
    (η : G →+ Additive P)
    (x y : PositiveExpression G) :
    positiveExpressionEvaluateAt η (.add x y) =
      positiveExpressionEvaluateAt η x + positiveExpressionEvaluateAt η y := by
  simp [positiveExpressionEvaluateAt, positiveFractionEvaluateAt,
    PositiveExpression.representatives,
    mapPositiveFraction_add, positiveFractionValue_add]

theorem positiveExpressionEvaluateAt_mul
    (η : G →+ Additive P)
    (x y : PositiveExpression G) :
    positiveExpressionEvaluateAt η (.mul x y) =
      positiveExpressionEvaluateAt η x * positiveExpressionEvaluateAt η y := by
  simp [positiveExpressionEvaluateAt, positiveFractionEvaluateAt,
    PositiveExpression.representatives,
    mapPositiveFraction_mul, positiveFractionValue_mul]

theorem positiveExpressionEvaluateAt_inv
    (η : G →+ Additive P)
    (x : PositiveExpression G) :
    positiveExpressionEvaluateAt η (.inv x) =
      (positiveExpressionEvaluateAt η x)⁻¹ := by
  simp [positiveExpressionEvaluateAt, positiveFractionEvaluateAt,
    PositiveExpression.representatives,
    mapPositiveFraction_inv, positiveFractionValue_inv]

theorem positiveExpressionEvaluateAt_atom_single
    (η : G →+ Additive P) (g : G) :
    positiveExpressionEvaluateAt η
      (.atom (AddMonoidAlgebra.single g 1)
        (AddMonoidAlgebra.single_eq_zero.not.mpr one_ne_zero)) =
      (η g).toMul := by
  simp [positiveExpressionEvaluateAt, positiveFractionEvaluateAt,
    mapPositiveFraction, PositiveExpression.representatives,
    TauCeti.Laurent.PositiveFraction.atom, positiveFractionValue,
    positivePolynomialValue, positiveCoefficientEval_single]
  rfl

theorem positiveExpressionEvaluateAt_one
    (η : G →+ Additive P) :
    positiveExpressionEvaluateAt η (PositiveExpression.one (G := G)) = 1 := by
  simpa [PositiveExpression.one, AddMonoidAlgebra.one_def] using
    positiveExpressionEvaluateAt_atom_single η 0

theorem positiveExpressionEvaluateAt_powNat
    (η : G →+ Additive P) (x : PositiveExpression G) (n : ℕ) :
    positiveExpressionEvaluateAt η (PositiveExpression.powNat x n) =
      (positiveExpressionEvaluateAt η x) ^ n := by
  induction n with
  | zero => simp [PositiveExpression.powNat, positiveExpressionEvaluateAt_one]
  | succ n ih => simp [PositiveExpression.powNat,
    positiveExpressionEvaluateAt_mul, ih, pow_succ, mul_comm]

theorem positiveExpressionEvaluateAt_powInt
    (η : G →+ Additive P) (x : PositiveExpression G) (n : ℤ) :
    positiveExpressionEvaluateAt η (PositiveExpression.powInt x n) =
      (positiveExpressionEvaluateAt η x) ^ n := by
  cases n <;>
    simp [PositiveExpression.powInt, positiveExpressionEvaluateAt_powNat,
      positiveExpressionEvaluateAt_inv, zpow_negSucc]


theorem positiveExpressionEvaluateAt_product
    {A : Type*}
    (t : Finset A) (v : A → PositiveExpression G)
    (η : G →+ Additive P) :
    positiveExpressionEvaluateAt η (PositiveExpression.product t v) =
      ∏ i ∈ t, positiveExpressionEvaluateAt η (v i) := by
  classical
  have h (l : List A) :
      positiveExpressionEvaluateAt η
        (l.foldr (fun i q => PositiveExpression.mul (v i) q)
          (PositiveExpression.one (G := G))) =
        (l.map (fun i => positiveExpressionEvaluateAt η (v i))).prod := by
    induction l with
    | nil => simp [positiveExpressionEvaluateAt_one]
    | cons i l ih => simp [positiveExpressionEvaluateAt_mul, ih]
  simpa [PositiveExpression.product, Finset.prod_toList] using h t.toList


/-- Two expressions representing the same universal rational function have
the same value in every coefficient semifield. -/
theorem positiveExpressionEvaluateAt_eq_of_universal_eq
    [IsDomain (AddMonoidAlgebra ℤ G)]
    (η : G →+ Additive P) (x y : PositiveExpression G)
    (h : x.evaluate (algebraMap _ (FractionRing (AddMonoidAlgebra ℤ G))) =
      y.evaluate (algebraMap _ (FractionRing (AddMonoidAlgebra ℤ G)))) :
    positiveExpressionEvaluateAt η x = positiveExpressionEvaluateAt η y := by
  let a : AddMonoidAlgebra ℤ G →+* FractionRing (AddMonoidAlgebra ℤ G) :=
    algebraMap _ _
  have ha : ∀ p, TauCeti.Laurent.positiveCast p ≠ 0 →
      a (TauCeti.Laurent.positiveCast p) ≠ 0 :=
    fun _ hp => IsFractionRing.to_map_eq_zero_iff.not.mpr hp
  unfold positiveExpressionEvaluateAt
  apply positiveFractionEvaluateAt_eq_of_universal_eq η
  exact (x.representatives_evaluate a ha).trans <|
    h.trans (y.representatives_evaluate a ha).symm

end TauCeti.Cluster
