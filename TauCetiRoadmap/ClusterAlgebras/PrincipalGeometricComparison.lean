/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.GeometricLaurentBase
public import TauCetiRoadmap.ClusterAlgebras.HatY
public import TauCetiRoadmap.ClusterAlgebras.ExpressionCoordinates
public import TauCetiRoadmap.LaurentPhenomenon.LaurentRegroup

/-! The integral change of exponent lattice between normalized principal
coefficients and total geometric coordinates. -/

@[expose] public section

noncomputable section
namespace TauCeti.Cluster
open TauCeti.Laurent
open scoped BigOperators
variable {I : Type*} [Fintype I] [DecidableEq I]

/-- Mutable coordinates come first, frozen coordinates second. -/
def principalExponentEquiv :
    (Additive (Trop I) × (I →₀ ℤ)) ≃+ (I ⊕ I →₀ ℤ) :=
  ((Trop.exponentEquiv.prodCongr (AddEquiv.refl _)).trans
    AddEquiv.prodComm).trans Finsupp.sumFinsuppAddEquivProdFinsupp.symm

omit [DecidableEq I] [Fintype I] in
@[simp] theorem principalExponentEquiv_inl (a : Additive (Trop I) × (I →₀ ℤ)) (i : I) :
    principalExponentEquiv a (Sum.inl i) = a.2 i := rfl

omit [DecidableEq I] [Fintype I] in
@[simp] theorem principalExponentEquiv_inr (a : Additive (Trop I) × (I →₀ ℤ)) (i : I) :
    principalExponentEquiv a (Sum.inr i) = a.1.toMul.toAdd i := rfl

/-- `ℤ[Trop(I)][x_i^{±1}] ≃ L(ℤ, I ⊔ I)`: the tropical coefficients become the frozen Laurent
variables, and L5's regrouping `L(ℤ, I ⊔ I) ≃ L(L(ℤ, I), I)` puts the mutable variables first. -/
def principalLaurentEquiv : TotalLaurentRing (Additive (Trop I)) I ≃+*
    AddMonoidAlgebra ℤ (I ⊕ I →₀ ℤ) :=
  ((AddMonoidAlgebra.domCongr ℤ ℤ
      ((Trop.exponentEquiv.prodCongr (AddEquiv.refl _)).trans AddEquiv.prodComm)).trans
    (AddMonoidAlgebra.curryAlgEquiv ℤ)).toRingEquiv.trans (laurentRegroup ℤ I I).symm.toRingEquiv

omit [Fintype I] [DecidableEq I] in
theorem principalLaurentEquiv_single (a : Additive (Trop I) × (I →₀ ℤ)) (n : ℤ) :
    principalLaurentEquiv (AddMonoidAlgebra.single a n) =
      AddMonoidAlgebra.single (principalExponentEquiv a) n := by
  change (laurentRegroup ℤ I I).symm (AddMonoidAlgebra.curryAlgEquiv ℤ
    (AddMonoidAlgebra.domCongr ℤ ℤ _ (AddMonoidAlgebra.single a n))) = _
  rw [AddMonoidAlgebra.domCongr_single, AddMonoidAlgebra.curryAlgEquiv_single,
    laurentRegroup_symm_single]
  rfl

omit [Fintype I] [DecidableEq I] in
/-- Through the regrouping, `principalLaurentEquiv` identifies the tropical coefficient ring with
the Laurent ring of the frozen variables. -/
theorem laurentRegroup_principalLaurentEquiv (p : TotalLaurentRing (Additive (Trop I)) I) :
    laurentRegroup ℤ I I (principalLaurentEquiv p) =
      AddMonoidAlgebra.curryAlgEquiv ℤ (AddMonoidAlgebra.domCongr ℤ ℤ
        ((Trop.exponentEquiv.prodCongr (AddEquiv.refl _)).trans AddEquiv.prodComm) p) :=
  (laurentRegroup ℤ I I).apply_symm_apply _

/-- Evaluate the total principal Laurent ring in its canonical mutable and frozen geometric
coordinates.
-/
def principalGeometricMap : TotalLaurentRing (Additive (Trop I)) I →+*
    PrincipalGeometricField I :=
  (LaurentEvaluation.eval (Int.castRingHom _) principalGeometricUnits).comp
    principalLaurentEquiv.toRingHom

omit [Fintype I] in
omit [DecidableEq I] in
theorem principalGeometricMap_injective [Finite I] : Function.Injective
    (principalGeometricMap (I := I)) := by
  classical
  let : Fintype I := Fintype.ofFinite I
  exact (integerLaurent_eval_injective_of_algebraicIndependent principalGeometricUnits
    (algebraicIndependent_rationalLaurentCoordinates (I ⊕ I))).comp
      principalLaurentEquiv.injective

omit [Fintype I] in
omit [DecidableEq I] in
theorem principalGeometricMap_positive [Finite I] (p : PositiveLaurent (Additive (Trop I)) I)
    (hp : positiveCast p ≠ 0) : principalGeometricMap (positiveCast p) ≠ 0 := by
  classical
  let : Fintype I := Fintype.ofFinite I
  exact fun h => hp (principalGeometricMap_injective (h.trans (map_zero _).symm))

omit [DecidableEq I] in
theorem principalGeometricMap_single (a : Additive (Trop I) × (I →₀ ℤ)) (n : ℤ) :
    principalGeometricMap (AddMonoidAlgebra.single a n) =
      (n : PrincipalGeometricField I) *
        (∏ i, rationalLaurentCoordinates (I ⊕ I) (Sum.inl i) ^ a.2 i) *
        ∏ i, rationalLaurentCoordinates (I ⊕ I) (Sum.inr i) ^ a.1.toMul.toAdd i := by
  classical
  change LaurentEvaluation.eval (Int.castRingHom _) principalGeometricUnits
    (principalLaurentEquiv (AddMonoidAlgebra.single a n)) = _
  rw [principalLaurentEquiv_single, LaurentEvaluation.eval_single_product]
  have hprod : (∏ i ∈ (principalExponentEquiv a).support,
      ((principalGeometricUnits i ^ principalExponentEquiv a i :
        (PrincipalGeometricField I)ˣ) : PrincipalGeometricField I)) =
      ∏ i, rationalLaurentCoordinates (I ⊕ I) i ^ principalExponentEquiv a i := by
    simp only [Units.val_zpow_eq_zpow_val, principalGeometricUnits, Units.val_mk0]
    apply Finset.prod_subset (Finset.subset_univ _)
    intro i _ hi
    simp [Finsupp.notMem_support_iff.mp hi]
  rw [hprod, Fintype.prod_sum_type]
  simp only [principalExponentEquiv_inl, principalExponentEquiv_inr,
    mul_assoc]
  rfl

omit [Fintype I] in
omit [DecidableEq I] in
@[simp] theorem principalGeometricMap_initial [Finite I] (i : I) :
    initialVariables (principalGeometricMap (I := I)) i =
      rationalLaurentCoordinates (I ⊕ I) (Sum.inl i) := by
  classical
  let : Fintype I := Fintype.ofFinite I
  rw [initialVariables, principalGeometricMap_single]
  simp [Finsupp.single_apply]

omit [DecidableEq I] in
theorem principalGeometricMap_coefficient (y : Trop I) :
    coefficientFieldMap (principalGeometricMap (I := I)) y =
      ∏ i, rationalLaurentCoordinates (I ⊕ I) (Sum.inr i) ^ y.toAdd i := by
  classical
  change principalGeometricMap (AddMonoidAlgebra.single (Additive.ofMul y, 0) 1) = _
  rw [principalGeometricMap_single]
  simp

omit [DecidableEq I] in
/-- Tropical normalization is precisely the split into positive and negative
parts of the frozen rows, including columns with mixed signs. -/
theorem geometric_normalized_exchange (B : Matrix (I ⊕ I) I ℤ) (y : Trop I) (k : I)
    (hy : ∀ j, B (Sum.inr j) k = y.toAdd j)
    (x : I → PrincipalGeometricField I) :
    MvPolynomial.aeval (Sum.elim x
      (fun j => rationalLaurentCoordinates (I ⊕ I) (Sum.inr j)))
      (geometricExchangePolynomial B k) =
      coordinateEvaluate principalGeometricMap (seedExchange y (fun j => B (Sum.inl j) k)) x := by
  classical
  have hp (j : I) : (CoefficientSemifield.normalizedPositive y).toAdd j =
      positivePart (y.toAdd j) := by
    simp [CoefficientSemifield.normalizedPositive, Trop.add_apply, positivePart]
    omega
  have hn (j : I) : (CoefficientSemifield.normalizedNegative y).toAdd j =
      positivePart (-y.toAdd j) := by
    simp [CoefficientSemifield.normalizedNegative, Trop.add_apply, positivePart]
    omega
  rw [aeval_geometricExchangePolynomial (F := PrincipalGeometricField I)
    (M := I ⊕ I) (K := I) B k
    (Sum.elim x (fun j => rationalLaurentCoordinates (I ⊕ I) (Sum.inr j))), seedExchange,
    coordinateEvaluate_add, coordinateEvaluate_single_coefficient,
    coordinateEvaluate_single_coefficient]
  simp only [principalGeometricMap_coefficient, hp, hn,
    columnPositiveExponent_apply, Fintype.prod_sum_type, Sum.elim_inl, Sum.elim_inr, hy]
  ring

theorem geometricWordData_frozen (d : I → ℤ) (hd : ∀ i, 0 < d i)
    (B : I → I → ℤ) (hB : ∀ i j, d i * B i j = -(d j * B j i))
    (w : List I) (j : I) :
    (geometricWordData d hd B hB w).2 (Sum.inr j) =
      rationalLaurentCoordinates (I ⊕ I) (Sum.inr j) := by
  induction w using List.reverseRecOn with
  | nil => rfl
  | append_singleton w k ih =>
    simpa [geometricWordData, List.foldl_append, geometricStep] using ih

/-- The geometric construction and the normalized principal construction
compute exactly the same mutable coordinates after every finite word. -/
theorem geometricWordData_normalized (d : I → ℤ) (hd : ∀ i, 0 < d i)
    (B : I → I → ℤ) (hB : ∀ i j, d i * B i j = -(d j * B j i))
    (w : List I) :
    (geometricWordData d hd B hB w).2 = Sum.elim
      ((MatrixSeed.pattern (C := Trop I) hd).wordCoordinates
        principalGeometricMap (principalSeed B hB) w)
      (fun j => rationalLaurentCoordinates (I ⊕ I) (Sum.inr j)) := by
  induction w using List.reverseRecOn with
  | nil =>
    funext a
    cases a with
    | inl i => exact (principalGeometricMap_initial i).symm
    | inr j => rfl
  | append_singleton w k ih =>
    have hm := geometricWordData_matrix d hd B hB w
    funext a
    cases a with
    | inr j => exact geometricWordData_frozen d hd B hB _ j
    | inl i =>
      rw [NormalizedMutationPattern.wordCoordinates_append_single]
      rw [geometricWordData, List.foldl_append]
      simp only [List.foldl_cons, List.foldl_nil]
      change (geometricStep k (geometricWordData d hd B hB w)).2 (Sum.inl i) = _
      simp only [geometricStep, hm, ih, mutateCoordinateValues]
      by_cases hi : i = k
      · subst i
        simp only [Function.update_self, Sum.elim_inl]
        apply congrArg (fun z => z / _)
        exact geometric_normalized_exchange (principalExtendedMatrix hd B hB w)
          ((mutateWord (MatrixSeed.mutate hd) w (principalSeed B hB)).coefficient k) k
          (fun j => rfl) _
      · simp only [Function.update_of_ne (show Sum.inl i ≠ Sum.inl k from
          fun h => hi (Sum.inl.inj h)), Function.update_of_ne hi, Sum.elim_inl]

theorem principalSeed_mutateWord_data (d : I → ℤ) (hd : ∀ i, 0 < d i)
    (B : I → I → ℤ) (hB : ∀ i j, d i * B i j = -(d j * B j i))
    (w : List I) :
    let t := mutateWord (fun i s => FullRankGeometricSeed.mutate hd s i) w
      (principalInitialGeometricSeed d hd B hB)
    (t.1.exchange, t.1.coordinate) = geometricWordData d hd B hB w := by
  induction w using List.reverseRecOn with
  | nil => rfl
  | append_singleton w k ih =>
    dsimp only at ih ⊢
    rw [mutateWord_append, geometricWordData, List.foldl_append]
    change geometricStep k
      ((mutateWord (fun i s => FullRankGeometricSeed.mutate hd s i) w
        (principalInitialGeometricSeed d hd B hB)).1.exchange,
       (mutateWord (fun i s => FullRankGeometricSeed.mutate hd s i) w
        (principalInitialGeometricSeed d hd B hB)).1.coordinate) =
      geometricStep k (geometricWordData d hd B hB w)
    exact congrArg (geometricStep k) ih

/-- The principal Laurent representation is in the integral source ring,
not merely in a Laurent ring with rational coefficients. -/
theorem principalWord_integral_of_geometric_chart (d : I → ℤ) (hd : ∀ i, 0 < d i)
    (B : I → I → ℤ) (hB : ∀ i j, d i * B i j = -(d j * B j i))
    (w : List I) (i : I)
    (hmem : (geometricWordData d hd B hB w).2 (Sum.inl i) ∈
      chartRing (Int.castRingHom (PrincipalGeometricField I)).range
        (rationalLaurentCoordinates (I ⊕ I))) :
    ∃ r : TotalLaurentRing (Additive (Trop I)) I,
      algebraMap _ (FractionRing (TotalLaurentRing (Additive (Trop I)) I)) r =
        (MatrixSeed.pattern (C := Trop I) hd).wordCoordinates
          (algebraMap _ _) (principalSeed B hB) w i := by
  let N := MatrixSeed.pattern (C := Trop I) hd
  let s := principalSeed B hB
  let φ := algebraMap (TotalLaurentRing (Additive (Trop I)) I)
    (FractionRing (TotalLaurentRing (Additive (Trop I)) I))
  have hφ : Function.Injective φ := IsFractionRing.injective _ _
  have hφpos : ∀ p, positiveCast p ≠ 0 → φ (positiveCast p) ≠ 0 :=
    fun p hp h => hp (hφ (h.trans (map_zero φ).symm))
  obtain ⟨p, hp⟩ := (LaurentEvaluation.mem_chart_iff_exists
    (Int.castRingHom (PrincipalGeometricField I)) principalGeometricUnits _).mp hmem
  let r := principalLaurentEquiv.symm p
  have heval : principalGeometricMap r = N.wordCoordinates principalGeometricMap s w i := by
    change LaurentEvaluation.eval (Int.castRingHom _) principalGeometricUnits
      (principalLaurentEquiv (principalLaurentEquiv.symm p)) = _
    rw [principalLaurentEquiv.apply_symm_apply, hp, geometricWordData_normalized]
    rfl
  have hrep : principalGeometricMap r =
      (N.wordExpressions s w i).representatives.evaluate principalGeometricMap := by
    rw [PositiveExpression.representatives_evaluate _ principalGeometricMap_positive,
      N.wordExpressions_evaluate]
    exact heval
  refine ⟨r, ?_⟩
  have h := PositiveFraction.represented_transfer principalGeometricMap
    principalGeometricMap_injective φ hφpos (N.wordExpressions s w i).representatives r hrep
  rw [PositiveExpression.representatives_evaluate φ hφpos,
    N.wordExpressions_evaluate] at h
  exact h

end TauCeti.Cluster
