/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.QuantumCompatible
public import TauCetiRoadmap.ClusterAlgebras.QuantumPolynomial
public import TauCetiRoadmap.ClusterAlgebras.GeometricPattern
public import TauCetiRoadmap.LaurentPhenomenon.Quantum.Specialization

/-!
# Classical charts as the unit-parameter case of based quantum frames

The scalar ring is retained: setting the central unit to one does not replace
integral Laurent rings by rational ones. Faithfulness follows from algebraic
independence after an injective change of coefficient rings.
-/

@[expose] public section

namespace TauCeti.Cluster
open TauCeti TauCeti.Laurent TauCeti.QuantumTorus
noncomputable section

variable {R 𝕜 F M K : Type*} [CommRing R] [Field 𝕜] [Field F]
  [Algebra R F] [Algebra 𝕜 F] [Fintype M] [DecidableEq M]

omit [Fintype M] [DecidableEq M] in
/-- Independent coordinates faithfully evaluate Laurent expressions over any
coefficient ring embedded in the field of independence. -/
theorem laurentEvaluation_injective_of_coefficientEmbedding [Finite M] (f : R →+* 𝕜)
    (hf : Function.Injective f) (hc : ∀ r, algebraMap 𝕜 F (f r) = algebraMap R F r)
    (x : M → Fˣ) (hx : AlgebraicIndependent 𝕜 fun a ↦ (x a : F)) :
    Function.Injective (LaurentEvaluation.eval (algebraMap R F) x) := by
  have he := laurentEvaluation_injective_of_algebraicIndependent (fun a ↦ (x a : F)) hx
  have hu : (fun a ↦ Units.mk0 (x a : F) (hx.ne_zero a)) = x := by
    funext a
    exact Units.ext rfl
  rw [hu] at he
  have hmap : Function.Injective (AddMonoidAlgebra.mapRingHom (M →₀ ℤ) f) := by
    intro p q h
    apply AddMonoidAlgebra.coeff_injective
    ext a
    apply hf
    simpa only [AddMonoidAlgebra.coeff_mapRingHom] using
      congrArg (fun z : AddMonoidAlgebra 𝕜 (M →₀ ℤ) ↦ z.coeff a) h
  have heq : LaurentEvaluation.eval (algebraMap R F) x =
      (LaurentEvaluation.eval (algebraMap 𝕜 F) x).comp
        (AddMonoidAlgebra.mapRingHom (M →₀ ℤ) f) := by
    apply AddMonoidAlgebra.ringHom_ext
    · intro r
      simp [hc]
    · intro a
      simp
  rw [heq]
  exact he.comp hmap

/-- The unit-parameter chart through the ordinary Laurent group algebra. -/
def unitParameterChart (Λ : Matrix M M ℤ) (x : M → Fˣ) :
    quantumTorus R (1 : Rˣ) (matrixForm Λ) →ₐ[R] F :=
  let e := equivAddMonoidAlgebraOfZpowEqOne
    (u := (1 : Rˣ)) (Λ := matrixForm Λ) (fun _ _ ↦ one_zpow _)
  let t := AddMonoidAlgebra.domCongr R R
    (Finsupp.linearEquivFunOnFinite ℤ ℤ M).symm.toAddEquiv
  let v : AddMonoidAlgebra R (M →₀ ℤ) →ₐ[R] F :=
    { LaurentEvaluation.eval (algebraMap R F) x with
      commutes' r := LaurentEvaluation.eval_constant _ _ r }
  v.comp (t.toAlgHom.comp e.toAlgHom)

@[simp] theorem unitParameterChart_single (Λ : Matrix M M ℤ) (x : M → Fˣ) (a : M) :
    unitParameterChart (R := R) Λ x (monomial (Pi.single a 1)) = x a := by
  change LaurentEvaluation.eval (algebraMap R F) x
    (AddMonoidAlgebra.mapDomainRingEquiv R
      (Finsupp.linearEquivFunOnFinite ℤ ℤ M).symm.toAddEquiv
      (equivAddMonoidAlgebraOfZpowEqOne
        (u := (1 : Rˣ)) (Λ := matrixForm Λ) (fun _ _ ↦ one_zpow _)
        (monomial (Pi.single a 1)))) = _
  rw [equivAddMonoidAlgebraOfZpowEqOne_monomial,
    AddMonoidAlgebra.mapDomainRingEquiv_single]
  change LaurentEvaluation.eval (algebraMap R F) x
    (AddMonoidAlgebra.single
      ((Finsupp.linearEquivFunOnFinite ℤ ℤ M).symm (Pi.single a 1)) 1) = _
  rw [Finsupp.linearEquivFunOnFinite_symm_single]
  simp

/-- The classical chart is faithful over the original coefficient ring. -/
theorem unitParameterChart_injective (Λ : Matrix M M ℤ) (f : R →+* 𝕜)
    (hf : Function.Injective f) (hc : ∀ r, algebraMap 𝕜 F (f r) = algebraMap R F r)
    (x : M → Fˣ) (hx : AlgebraicIndependent 𝕜 fun a ↦ (x a : F)) :
    Function.Injective (unitParameterChart (R := R) Λ x) :=
  (laurentEvaluation_injective_of_coefficientEmbedding f hf hc x hx).comp
    ((AddMonoidAlgebra.domCongr R R
      (Finsupp.linearEquivFunOnFinite ℤ ℤ M).symm.toAddEquiv).injective.comp
      (equivAddMonoidAlgebraOfZpowEqOne
        (u := (1 : Rˣ)) (Λ := matrixForm Λ) (fun _ _ ↦ one_zpow _)).injective)

/-- Independent classical coordinates give a faithful frame with zero form and
zero form weights, retaining the original exchange symmetrizer. -/
def commutativeFrame {row : K ↪ M} (E : ExtendedExchangeMatrix row)
    (hI : LinearIndependent ℚ (fun k ↦ fun a ↦ (E.matrix a k : ℚ)))
    (f : R →+* 𝕜) (hf : Function.Injective f)
    (hc : ∀ r, algebraMap 𝕜 F (f r) = algebraMap R F r)
    (x : M → Fˣ) (hx : AlgebraicIndependent 𝕜 fun a ↦ (x a : F)) :
    ExchangeFrame (u₀ := (1 : Rˣ)) F row where
  exchange := E
  form := 0
  alternating := by intro i j; simp
  formWeight := fun _ ↦ 0
  compatible := by intro k l; simp
  independentColumns := hI
  coordinate := x
  quasiCommuting := by intro i j; simp [mul_comm]
  faithful := by
    have hAlt : IsAlternatingMatrix (0 : Matrix M M ℤ) := by intro i j; simp
    have h : unitParameterChart (R := R) 0 x =
        QuantumTorus.lift (R := R) (u := (1 : Rˣ)) hAlt.isAlt x
          (by intro i j; simp [mul_comm]) :=
      eq_lift hAlt.isAlt (by intro i j; simp [mul_comm])
        (unitParameterChart (R := R) 0 x) (unitParameterChart_single 0 x)
    rw [← h]
    exact unitParameterChart_injective 0 f hf hc x hx

namespace ExchangeFrame

variable {row : K ↪ M} (s : ExchangeFrame (u₀ := (1 : Rˣ)) F row)

/-- At unit parameter, normalized monomials are ordinary products of integer powers. -/
theorem monomial_eq_prod_unitParameter (v : M → ℤ) :
    s.monomial v = ∏ a, (s.coordinate a : F) ^ v a := by
  let φ : Multiplicative (M → ℤ) →* F :=
    { toFun := fun a ↦ s.monomial a.toAdd
      map_one' := s.monomial_zero
      map_mul' := fun a b ↦ by
        simpa only [toAdd_mul, one_zpow, Units.val_one, map_one, one_mul] using
          (s.monomial_mul_monomial a.toAdd b.toAdd).symm }
  have hv : (∏ a, Multiplicative.ofAdd (v a • Pi.single a (1 : ℤ))) =
      Multiplicative.ofAdd v := by
    apply Multiplicative.toAdd.injective
    change (∑ a, v a • Pi.single a (1 : ℤ)) = v
    ext a
    simp [Finset.sum_apply, Pi.single_apply]
  rw [show s.monomial v = φ (Multiplicative.ofAdd v) from rfl, ← hv, map_prod]
  exact Finset.prod_congr rfl fun a _ ↦ s.monomial_zsmul_single a (v a)

variable [Fintype K] [DecidableEq K]

/-- Binary frame mutation at unit parameter is ordinary geometric exchange. -/
theorem mutate_pair_unitParameter (k : K) :
    ((s.mutate k).exchange.matrix, fun a ↦ ((s.mutate k).coordinate a : F)) =
      geometricExchange row k (s.exchange.matrix, fun a ↦ (s.coordinate a : F)) := by
  refine Prod.ext (s.mutate_exchange_matrix k) ?_
  funext a
  change ((s.mutate k).coordinate a : F) =
    (geometricExchange row k (s.exchange.matrix, fun a ↦ (s.coordinate a : F))).2 a
  by_cases ha : a = row k
  · subst a
    rw [s.mutate_coordinate_row, geometricExchange_snd_row]
    apply (eq_div_iff (Units.ne_zero (s.coordinate (row k)))).2
    simpa only [one_zpow, Units.val_one, map_one, one_mul,
      s.monomial_eq_prod_unitParameter] using s.exchangeCoordinate_mul_coordinate_eq k
  · rw [s.mutate_coordinate_of_ne k ha, geometricExchange_snd_of_ne k _ ha]

/-- Every unit-parameter mutation word gives the independently defined classical pattern. -/
theorem mutateWord_pair_unitParameter (w : List K) :
    ((mutateWord (fun k t ↦ ExchangeFrame.mutate t k) w s).exchange.matrix,
      fun a ↦ ((mutateWord (fun k t ↦ ExchangeFrame.mutate t k) w s).coordinate a : F)) =
      geometricPattern row s.exchange.matrix (fun a ↦ (s.coordinate a : F)) w := by
  exact mutateWord_map (fun k t ↦ ExchangeFrame.mutate t k) (geometricExchange row)
    (fun t : ExchangeFrame (u₀ := (1 : Rˣ)) F row ↦
      (t.exchange.matrix, fun a ↦ (t.coordinate a : F)))
    (fun k t ↦ t.mutate_pair_unitParameter k) w s

/-- At parameter one, every mutated coordinate is independent of the auxiliary
compatible form and its symmetrizer witness. -/
theorem mutateWord_coordinate_eq_unitParameter
    {t : ExchangeFrame (u₀ := (1 : Rˣ)) F row}
    (hB : s.exchange.matrix = t.exchange.matrix)
    (hx : (fun a ↦ (s.coordinate a : F)) = fun a ↦ (t.coordinate a : F)) (w : List K) :
    (fun a ↦ ((mutateWord (fun k t ↦ ExchangeFrame.mutate t k) w s).coordinate a : F)) =
      fun a ↦ ((mutateWord (fun k t ↦ ExchangeFrame.mutate t k) w t).coordinate a : F) := by
  have hs := congrArg Prod.snd (s.mutateWord_pair_unitParameter w)
  have ht := congrArg Prod.snd (t.mutateWord_pair_unitParameter w)
  rw [hB, hx] at hs
  exact hs.trans ht.symm

/-- Unit-parameter chart rings along words are independent of the auxiliary form. -/
theorem mutateWord_chartRing_eq_unitParameter
    {t : ExchangeFrame (u₀ := (1 : Rˣ)) F row}
    (hB : s.exchange.matrix = t.exchange.matrix)
    (hx : (fun a ↦ (s.coordinate a : F)) = fun a ↦ (t.coordinate a : F)) (w : List K) :
    (mutateWord (fun k t ↦ ExchangeFrame.mutate t k) w s).chartRing =
      (mutateWord (fun k t ↦ ExchangeFrame.mutate t k) w t).chartRing := by
  unfold chartRing
  rw [s.mutateWord_coordinate_eq_unitParameter hB hx w]

end ExchangeFrame
end
end TauCeti.Cluster
