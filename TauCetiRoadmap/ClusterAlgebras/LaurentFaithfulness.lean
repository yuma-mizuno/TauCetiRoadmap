/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.GeometricCoordinates
public import TauCetiRoadmap.LaurentPhenomenon.LaurentSupport
public import TauCetiRoadmap.LaurentPhenomenon.LaurentEvaluation
public import Mathlib.Algebra.MonoidAlgebra.Support

/-! Clearing the finite set of negative exponents reduces injectivity of
Laurent evaluation to algebraic independence of the coordinate family. -/

@[expose] public section

namespace TauCeti.Cluster
open scoped BigOperators
variable {J F K : Type*} [Fintype J] [DecidableEq J] [Field K] [Field F] [Algebra K F]

/-- Include nonnegative polynomial exponents into the integer Laurent exponent lattice. -/
noncomputable def polynomialToLaurentField (K J : Type*) [Field K] :
    MvPolynomial J K →+* AddMonoidAlgebra K (J →₀ ℤ) :=
  AddMonoidAlgebra.mapDomainRingHom K (naturalExponentInclusion J)

/-- A finite nonnegative exponent vector large enough to clear every negative exponent of p. -/
noncomputable def clearingExponent (p : AddMonoidAlgebra K (J →₀ ℤ)) : J →₀ ℤ :=
  (Finsupp.equivFunOnFinite).symm
    (fun j => ∑ a ∈ p.coeff.support, |a j|)

omit [DecidableEq J] in
@[simp] theorem clearingExponent_apply (p : AddMonoidAlgebra K (J →₀ ℤ)) (j : J) :
    clearingExponent p j = ∑ a ∈ p.coeff.support, |a j| := by
  simp [clearingExponent]

omit [DecidableEq J] in
theorem exponent_add_clearing_nonneg (p : AddMonoidAlgebra K (J →₀ ℤ))
    {a : J →₀ ℤ} (ha : a ∈ p.coeff.support) (j : J) :
    0 ≤ (a + clearingExponent p) j := by
  classical
  have hle : |a j| ≤ ∑ t ∈ p.coeff.support, |t j| :=
    Finset.single_le_sum (fun t ht => abs_nonneg (t j)) ha
  have hneg := neg_le_abs (a j)
  simp only [Finsupp.add_apply, clearingExponent_apply]
  omega

/-- Take the coordinatewise natural part of an integer exponent vector. -/
noncomputable def exponentToNat (a : J →₀ ℤ) : J →₀ ℕ :=
  a.mapRange Int.toNat (by simp)

omit [DecidableEq J] [Fintype J] in
theorem naturalExponentInclusion_exponentToNat (a : J →₀ ℤ)
    (ha : ∀ j, 0 ≤ a j) : naturalExponentInclusion J (exponentToNat a) = a := by
  ext j
  simp [naturalExponentInclusion, exponentToNat, Int.toNat_of_nonneg (ha j)]

omit [DecidableEq J] [Fintype J] in
@[simp] theorem polynomialToLaurent_monomial (a : J →₀ ℕ) (c : K) :
    polynomialToLaurentField K J (MvPolynomial.monomial a c) =
      AddMonoidAlgebra.single (naturalExponentInclusion J a) c := by
  change AddMonoidAlgebra.mapDomain (naturalExponentInclusion J)
    (AddMonoidAlgebra.single a c) = _
  rw [AddMonoidAlgebra.mapDomain_single]

omit [DecidableEq J] [Fintype J] in
@[simp] theorem polynomialToLaurentField_X [Finite J] (j : J) :
    polynomialToLaurentField K J (MvPolynomial.X j) =
      AddMonoidAlgebra.single (Finsupp.single j 1) 1 := by
  classical
  let : Fintype J := Fintype.ofFinite J
  rw [MvPolynomial.X, polynomialToLaurent_monomial]
  simp [naturalExponentInclusion]

/-- A Laurent polynomial becomes an ordinary polynomial after multiplying
by one explicit monomial. -/
noncomputable def clearedPolynomial (p : AddMonoidAlgebra K (J →₀ ℤ)) :
    MvPolynomial J K :=
  ∑ a ∈ p.coeff.support,
    MvPolynomial.monomial (exponentToNat (a + clearingExponent p)) (p.coeff a)

omit [DecidableEq J] in
theorem polynomialToLaurent_clearedPolynomial (p : AddMonoidAlgebra K (J →₀ ℤ)) :
    polynomialToLaurentField K J (clearedPolynomial p) =
      p * AddMonoidAlgebra.single (clearingExponent p) 1 := by
  classical
  calc
    polynomialToLaurentField K J (clearedPolynomial p) =
        ∑ a ∈ p.coeff.support,
          AddMonoidAlgebra.single
            (naturalExponentInclusion J (exponentToNat (a + clearingExponent p)))
            (p.coeff a) := by simp [clearedPolynomial]
    _ = ∑ a ∈ p.coeff.support,
          AddMonoidAlgebra.single a (p.coeff a) *
            AddMonoidAlgebra.single (clearingExponent p) 1 := by
        apply Finset.sum_congr rfl
        intro a ha
        rw [naturalExponentInclusion_exponentToNat _
          (fun j => exponent_add_clearing_nonneg p ha j),
          AddMonoidAlgebra.single_mul_single, mul_one]
    _ = p * AddMonoidAlgebra.single (clearingExponent p) 1 := by
        rw [← Finset.sum_mul]
        exact congrArg (fun q : AddMonoidAlgebra K (J →₀ ℤ) =>
          q * AddMonoidAlgebra.single (clearingExponent p) 1) p.sum_coeff_single

omit [DecidableEq J] [Fintype J] in
theorem aeval_eq_laurent_eval_on_polynomial [Finite J]
    (e : AddMonoidAlgebra K (J →₀ ℤ) →+* F)
    (hcoeff : ∀ c : K, e (AddMonoidAlgebra.single 0 c) = algebraMap K F c) :
    (MvPolynomial.aeval
      (fun j : J => e (AddMonoidAlgebra.single (Finsupp.single j 1) 1))).toRingHom =
      e.comp (polynomialToLaurentField K J) := by
  classical
  let : Fintype J := Fintype.ofFinite J
  apply MvPolynomial.ringHom_ext
  · intro c
    change (MvPolynomial.aeval
      (fun j : J => e (AddMonoidAlgebra.single (Finsupp.single j 1) 1)))
      (MvPolynomial.C c) = e ((polynomialToLaurentField K J) (MvPolynomial.C c))
    have hc : (polynomialToLaurentField K J) (MvPolynomial.C c) =
        AddMonoidAlgebra.single 0 c := by
      change AddMonoidAlgebra.mapDomain (naturalExponentInclusion J)
        (AddMonoidAlgebra.single 0 c) = _
      rw [AddMonoidAlgebra.mapDomain_single]
      simp
    rw [hc]
    simpa only [MvPolynomial.aeval_C] using (hcoeff c).symm
  · intro j
    simp

omit [DecidableEq J] [Fintype J] in
/-- Algebraic independence of the coordinates makes every formal Laurent
expression faithful in the ambient field. -/
theorem laurent_eval_injective_of_algebraicIndependent [Finite J]
    (e : AddMonoidAlgebra K (J →₀ ℤ) →+* F)
    (hcoeff : ∀ c : K, e (AddMonoidAlgebra.single 0 c) = algebraMap K F c)
    (hai : AlgebraicIndependent K
      (fun j : J => e (AddMonoidAlgebra.single (Finsupp.single j 1) 1))) :
    Function.Injective e := by
  classical
  let : Fintype J := Fintype.ofFinite J
  apply (injective_iff_map_eq_zero e).mpr
  intro p hp
  have heq := aeval_eq_laurent_eval_on_polynomial e hcoeff
  have hq : MvPolynomial.aeval
      (fun j : J => e (AddMonoidAlgebra.single (Finsupp.single j 1) 1))
      (clearedPolynomial p) = 0 := by
    change (MvPolynomial.aeval
      (fun j : J => e (AddMonoidAlgebra.single (Finsupp.single j 1) 1))).toRingHom
        (clearedPolynomial p) = 0
    rw [heq, RingHom.comp_apply, polynomialToLaurent_clearedPolynomial,
      map_mul, hp, zero_mul]
  have hzero := hai.eq_zero_of_aeval_eq_zero (clearedPolynomial p) hq
  have hprod : p * AddMonoidAlgebra.single (clearingExponent p) 1 = 0 := by
    rw [← polynomialToLaurent_clearedPolynomial p, hzero, map_zero]
  have hunit : IsUnit (AddMonoidAlgebra.single (clearingExponent p) (1 : K) :
      AddMonoidAlgebra K (J →₀ ℤ)) := TauCeti.Laurent.isUnit_monomial _
  exact (mul_eq_zero.mp hprod).resolve_right hunit.ne_zero

omit [DecidableEq J] [Fintype J] in
theorem nonzero_coordinate_of_algebraicIndependent (x : J → F)
    (hai : AlgebraicIndependent K x) (j : J) : x j ≠ 0 := by
  intro hx
  apply MvPolynomial.X_ne_zero (R := K) j
  apply hai.eq_zero_of_aeval_eq_zero
  simp [hx]

omit [DecidableEq J] [Fintype J] in
/-- The canonical Laurent evaluation at an algebraically independent field
family is injective, with all negative powers genuinely interpreted. -/
theorem laurentEvaluation_injective_of_algebraicIndependent [Finite J] (x : J → F)
    (hai : AlgebraicIndependent K x) :
    Function.Injective (TauCeti.Laurent.LaurentEvaluation.eval (algebraMap K F)
      (fun j => Units.mk0 (x j) (nonzero_coordinate_of_algebraicIndependent x hai j))) := by
  classical
  let : Fintype J := Fintype.ofFinite J
  apply laurent_eval_injective_of_algebraicIndependent
  · intro c
    exact TauCeti.Laurent.LaurentEvaluation.eval_constant (algebraMap K F) _ c
  · convert hai using 1
    funext j
    simp

theorem principalGeometric_laurentEvaluation_injective
    {I : Type*} [Fintype I] [DecidableEq I]
    (d : I → ℤ) (hd : ∀ i, 0 < d i)
    (B : I → I → ℤ) (hB : ∀ i j, d i * B i j = -(d j * B j i))
    (w : List I) :
    Function.Injective (TauCeti.Laurent.LaurentEvaluation.eval
      (algebraMap ℚ (PrincipalGeometricField I))
      (fun j => Units.mk0 ((geometricWordData d hd B hB w).2 j)
        (nonzero_coordinate_of_algebraicIndependent _
          (geometricWordData_independent d hd B hB w) j))) :=
  laurentEvaluation_injective_of_algebraicIndependent _
    (geometricWordData_independent d hd B hB w)

/-- Changing integer Laurent coefficients to rational ones is faithful. -/
theorem integerLaurent_to_rational_injective (J : Type*) :
    Function.Injective
      (AddMonoidAlgebra.mapRingHom (J →₀ ℤ) (Int.castRingHom ℚ) :
        AddMonoidAlgebra ℤ (J →₀ ℤ) →+* AddMonoidAlgebra ℚ (J →₀ ℤ)) := by
  intro p q h
  apply AddMonoidAlgebra.coeff_injective
  ext a
  have ha := congrArg (fun z : AddMonoidAlgebra ℚ (J →₀ ℤ) => z.coeff a) h
  simp only [AddMonoidAlgebra.coeff_mapRingHom] at ha
  simpa using ha

/-- The integer-coefficient formal Laurent ring embeds in every faithful
rational-coordinate realization. -/
theorem integerLaurent_eval_injective_of_rational
    (J : Type*) {F : Type*} [Field F]
    (e : AddMonoidAlgebra ℚ (J →₀ ℤ) →+* F) (he : Function.Injective e) :
    Function.Injective
      (e.comp (AddMonoidAlgebra.mapRingHom (J →₀ ℤ) (Int.castRingHom ℚ))) :=
  he.comp (integerLaurent_to_rational_injective J)

omit [Fintype J] [DecidableEq J] in
/-- Algebraically independent field coordinates also faithfully evaluate
integer-coefficient Laurent expressions. -/
theorem integerLaurent_eval_injective_of_algebraicIndependent
    {J F : Type*} [Finite J] [Field F] [Algebra ℚ F] (x : J → Fˣ)
    (hai : AlgebraicIndependent ℚ (fun j => (x j : F))) :
    Function.Injective (TauCeti.Laurent.LaurentEvaluation.eval (Int.castRingHom F) x) := by
  classical
  let : Fintype J := Fintype.ofFinite J
  have hr := laurentEvaluation_injective_of_algebraicIndependent
    (fun j => (x j : F)) hai
  have hunit : (fun j => Units.mk0 (x j : F)
      (nonzero_coordinate_of_algebraicIndependent _ hai j)) = x := by
    funext j
    exact Units.ext rfl
  rw [hunit] at hr
  have heq : TauCeti.Laurent.LaurentEvaluation.eval (Int.castRingHom F) x =
      (TauCeti.Laurent.LaurentEvaluation.eval (algebraMap ℚ F) x).comp
        (AddMonoidAlgebra.mapRingHom (J →₀ ℤ) (Int.castRingHom ℚ)) := by
    apply AddMonoidAlgebra.ringHom_ext
    · intro a
      simp
    · intro m
      simp [TauCeti.Laurent.LaurentEvaluation.eval_single]
  rw [heq]
  convert integerLaurent_eval_injective_of_rational J _ hr using 1

end TauCeti.Cluster
