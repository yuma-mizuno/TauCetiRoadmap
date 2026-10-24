/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.Quantum.Coefficients

/-!
# Sign changes of the form of a quantum torus

Two isomorphisms fix every monomial `X ^ a` and change the sign of the form `Λ`:

* **the semilinear isomorphism** `TauCeti.QuantumTorus.barRingEquiv`: for a ring isomorphism
  `σ : R ≃+* R'` with `σ u = u'⁻¹`, the ring isomorphism `T(R,u,Λ) ≃+* T(R',u',-Λ)`,
  `c X ^ a ↦ σ(c) X ^ a`, semilinear along `σ` (`barRingEquiv_smul`). The two cocycles agree:
  `cocycle u'⁻¹ Λ = cocycle u' (-Λ)` (`cocycle_inv_neg`). For `Zv` and the bar involution
  `v ↦ v⁻¹` this is `TauCeti.QuantumTorus.barEquiv : T(Zv,v,Λ) ≃+* T(Zv,v,-Λ)`;
* **the opposite isomorphism** `TauCeti.QuantumTorus.opAlgEquiv`: for the transposed form
  `Λ'(a,b) = Λ(b,a)`, the `R`-algebra isomorphism `T(R,u,Λ)ᵐᵒᵖ ≃ₐ[R] T(R,u,Λ')`,
  `op X ^ a ↦ X ^ a`; for alternating `Λ` the transpose is `-Λ` (`opAlgEquivNeg`).

Both take the form as a second argument `Λ'` with the sign relation as a hypothesis, so that they
apply to forms written in different ways (for instance `matrixForm (-Λ)` and `-matrixForm Λ`).
-/

@[expose] public section

namespace TauCeti.QuantumTorus

open TauCeti MulOpposite

variable {R : Type*} [CommRing R] {L : Type*} [AddCommGroup L]

section Cocycle

/-- The cocycle of `(u⁻¹, -Λ)` is the cocycle of `(u, Λ)`. -/
theorem cocycle_inv_neg (u : Rˣ) (Λ : LinearMap.BilinForm ℤ L) : cocycle u⁻¹ (-Λ)
    = cocycle u Λ := by
  funext a b
  simp [cocycle]

/-- For alternating `Λ`, the cocycle of `(u, -Λ)` is the cocycle of `(u, Λ)` with its arguments
exchanged: `T(R,u,-Λ)` is opposite to `T(R,u,Λ)`. -/
theorem cocycle_neg_apply {Λ : LinearMap.BilinForm ℤ L} (hΛ : LinearMap.IsAlt Λ) (u : Rˣ)
    (a b : Multiplicative L) : cocycle u (-Λ) a b = cocycle u Λ b a := by
  simp only [cocycle, LinearMap.neg_apply]
  rw [hΛ.neg]

end Cocycle

/-! ### The semilinear isomorphism -/

section Bar

variable {R' : Type*} [CommRing R'] {u : Rˣ} {u' : R'ˣ} {Λ Λ' : LinearMap.BilinForm ℤ L}

/-- **The semilinear sign isomorphism.** For a ring isomorphism `σ : R ≃+* R'` with
`σ u = u'⁻¹` and `Λ' = -Λ`, the ring isomorphism `T(R,u,Λ) ≃+* T(R',u',Λ')` sending `c X ^ a` to
`σ(c) X ^ a`. -/
noncomputable def barRingEquiv (σ : R ≃+* R') (hu : σ u = ((u'⁻¹ : R'ˣ) : R'))
    (hΛ : ∀ a b, Λ' a b = -Λ a b) : quantumTorus R u Λ ≃+* quantumTorus R' u' Λ' :=
  (mapRangeRingEquiv σ hu).trans
    (TwistedMonoidAlgebra.equivOfCoboundary (cocycle u' Λ') (cocycle u'⁻¹ Λ) 1
      fun g h ↦ by simp [cocycle, hΛ]).toRingEquiv

variable (σ : R ≃+* R') (hu : σ u = ((u'⁻¹ : R'ˣ) : R')) (hΛ : ∀ a b, Λ' a b = -Λ a b)

theorem barRingEquiv_smul_monomial (c : R) (a : L) :
    barRingEquiv σ hu hΛ (c • monomial a) = σ c • monomial a := by
  rw [barRingEquiv, RingEquiv.trans_apply, coe_mapRangeRingEquiv, mapRangeRingHom_smul_monomial,
    AlgEquiv.coe_toRingEquiv, map_smul]
  simp [monomial]

@[simp] theorem barRingEquiv_monomial (a : L) :
    barRingEquiv σ hu hΛ (monomial a) = monomial a := by
  simpa using barRingEquiv_smul_monomial σ hu hΛ 1 a

theorem barRingEquiv_algebraMap (c : R) :
    barRingEquiv σ hu hΛ (algebraMap R (quantumTorus R u Λ) c) =
      algebraMap R' (quantumTorus R' u' Λ') (σ c) := by
  rw [Algebra.algebraMap_eq_smul_one, ← monomial_zero, barRingEquiv_smul_monomial, monomial_zero,
    ← Algebra.algebraMap_eq_smul_one]

/-- The sign isomorphism is semilinear along `σ`. -/
theorem barRingEquiv_smul (c : R) (x : quantumTorus R u Λ) :
    barRingEquiv σ hu hΛ (c • x) = σ c • barRingEquiv σ hu hΛ x := by
  rw [Algebra.smul_def, map_mul, barRingEquiv_algebraMap, ← Algebra.smul_def]

/-- The sign isomorphism applies `σ` to every coefficient. -/
@[simp] theorem coeff_barRingEquiv (x : quantumTorus R u Λ) (a : L) :
    coeff a (barRingEquiv σ hu hΛ x) = σ (coeff a x) := by
  classical
  conv_lhs => rw [← sum_coeff_smul_monomial x]
  simp only [map_sum, barRingEquiv_smul_monomial, map_smul, coeff_monomial, Finsupp.single_apply,
    smul_eq_mul, mul_ite, mul_one, mul_zero, Finset.sum_ite_eq']
  split_ifs with h
  · rfl
  · rw [coeff_eq_zero_of_notMem_support h, map_zero]


end Bar

section Zv

theorem invert_vUnit : LaurentPolynomial.invert (vUnit : Zv) = ((vUnit⁻¹ : Zvˣ) : Zv) := by
  rw [vUnit_val, LaurentPolynomial.invert_T]
  refine (Units.inv_eq_of_mul_eq_one_right ?_).symm
  rw [vUnit_val, ← LaurentPolynomial.T_add, add_neg_cancel, LaurentPolynomial.T_zero]

variable {Λ Λ' : LinearMap.BilinForm ℤ L}

/-- **The bar isomorphism** `T(Zv,v,Λ) ≃+* T(Zv,v,-Λ)`, `c(v) X ^ a ↦ c(v⁻¹) X ^ a`, for
`Λ' = -Λ`. -/
noncomputable def barEquiv (hΛ : ∀ a b, Λ' a b = -Λ a b) :
    quantumTorus Zv vUnit Λ ≃+* quantumTorus Zv vUnit Λ' :=
  barRingEquiv (LaurentPolynomial.invert : Zv ≃ₐ[ℤ] Zv).toRingEquiv invert_vUnit hΛ

variable (hΛ : ∀ a b, Λ' a b = -Λ a b)

@[simp] theorem barEquiv_monomial (a : L) : barEquiv hΛ (monomial a) = monomial a :=
  barRingEquiv_monomial _ _ hΛ a

theorem barEquiv_smul (c : Zv) (x : quantumTorus Zv vUnit Λ) :
    barEquiv hΛ (c • x) = LaurentPolynomial.invert c • barEquiv hΛ x :=
  barRingEquiv_smul _ _ hΛ c x

theorem barEquiv_algebraMap (c : Zv) :
    barEquiv hΛ (algebraMap Zv (quantumTorus Zv vUnit Λ) c) =
      algebraMap Zv (quantumTorus Zv vUnit Λ') (LaurentPolynomial.invert c) :=
  barRingEquiv_algebraMap _ _ hΛ c

@[simp] theorem coeff_barEquiv (x : quantumTorus Zv vUnit Λ) (a : L) :
    coeff a (barEquiv hΛ x) = LaurentPolynomial.invert (coeff a x) :=
  coeff_barRingEquiv _ _ hΛ x a

end Zv

/-! ### The opposite isomorphism -/

section Opposite

variable {u : Rˣ} {Λ Λ' : LinearMap.BilinForm ℤ L}

/-- For the transposed form `Λ'`, `X ^ a ↦ op X ^ a` is an `R`-algebra map
`T(R,u,Λ') → T(R,u,Λ)ᵐᵒᵖ`. -/
noncomputable def toOpAlgHom (hΛ : ∀ a b, Λ' a b = Λ b a) :
    quantumTorus R u Λ' →ₐ[R] (quantumTorus R u Λ)ᵐᵒᵖ :=
  TwistedMonoidAlgebra.lift (fun g ↦ op (monomial g.toAdd : quantumTorus R u Λ)) (by simp)
    fun g h ↦ by
      rw [← op_mul, monomial_mul_monomial, op_smul, toAdd_mul, add_comm]
      simp [cocycle, hΛ]

@[simp] theorem toOpAlgHom_monomial (hΛ : ∀ a b, Λ' a b = Λ b a) (a : L) :
    toOpAlgHom (R := R) (u := u) hΛ (monomial a) = op (monomial a) :=
  TwistedMonoidAlgebra.lift_of _ _ _ (Multiplicative.ofAdd a)

/-- **The opposite isomorphism.** For the transposed form `Λ'(a,b) = Λ(b,a)`, the `R`-algebra
isomorphism `T(R,u,Λ)ᵐᵒᵖ ≃ₐ[R] T(R,u,Λ')` sending `op X ^ a` to `X ^ a`. -/
noncomputable def opAlgEquiv (hΛ : ∀ a b, Λ' a b = Λ b a) :
    (quantumTorus R u Λ)ᵐᵒᵖ ≃ₐ[R] quantumTorus R u Λ' :=
  AlgEquiv.ofAlgHom (AlgHom.opComm (toOpAlgHom fun a b ↦ (hΛ b a).symm)) (toOpAlgHom hΛ)
    (TwistedMonoidAlgebra.algHom_ext fun g ↦ by
      change AlgHom.opComm _ (toOpAlgHom hΛ (monomial g.toAdd)) = monomial g.toAdd
      rw [toOpAlgHom_monomial, AlgHom.opComm_apply_apply, unop_op, toOpAlgHom_monomial, unop_op])
    (by
      refine AlgHom.ext fun x ↦ ?_
      induction x using MulOpposite.rec' with | _ x
      have key : ((toOpAlgHom hΛ).comp
          (AlgHom.opComm (toOpAlgHom fun a b ↦ (hΛ b a).symm))).toLinearMap ∘ₗ
            (MulOpposite.opLinearEquiv R : quantumTorus R u Λ ≃ₗ[R] _).toLinearMap =
          (MulOpposite.opLinearEquiv R : quantumTorus R u Λ ≃ₗ[R] _).toLinearMap :=
        (monomialBasis (R := R) (u := u) (Λ := Λ)).ext fun a ↦ by
          simp only [LinearMap.coe_comp, LinearEquiv.coe_coe, Function.comp_apply,
            monomialBasis_apply, MulOpposite.coe_opLinearEquiv, AlgHom.toLinearMap_apply,
            AlgHom.comp_apply, AlgHom.opComm_apply_apply, toOpAlgHom_monomial, unop_op]
      simpa using LinearMap.congr_fun key x)

variable (hΛ : ∀ a b, Λ' a b = Λ b a)

@[simp] theorem opAlgEquiv_op_monomial (a : L) :
    opAlgEquiv (u := u) hΛ (op (monomial a)) = monomial a := by
  rw [opAlgEquiv, AlgEquiv.ofAlgHom_apply, AlgHom.opComm_apply_apply, unop_op,
    toOpAlgHom_monomial, unop_op]

@[simp] theorem opAlgEquiv_symm_monomial (a : L) :
    (opAlgEquiv (u := u) hΛ).symm (monomial a) = op (monomial a) := by
  rw [AlgEquiv.symm_apply_eq, opAlgEquiv_op_monomial]

/-- The opposite isomorphism keeps every coefficient. -/
@[simp] theorem coeff_opAlgEquiv (x : (quantumTorus R u Λ)ᵐᵒᵖ) (a : L) :
    coeff a (opAlgEquiv hΛ x) = coeff a (unop x) := by
  classical
  induction x using MulOpposite.rec' with | _ x
  conv_lhs => rw [← sum_coeff_smul_monomial x]
  rw [unop_op, ← MulOpposite.opAddEquiv_apply, map_sum]
  simp only [MulOpposite.opAddEquiv_apply, op_smul, map_sum, map_smul, opAlgEquiv_op_monomial,
    coeff_monomial, Finsupp.single_apply, smul_eq_mul, mul_ite, mul_one, mul_zero,
    Finset.sum_ite_eq']
  split_ifs with h
  · rfl
  · rw [coeff_eq_zero_of_notMem_support h]

/-- **The opposite isomorphism for an alternating form**: `T(R,u,Λ)ᵐᵒᵖ ≃ₐ[R] T(R,u,-Λ)`. -/
noncomputable abbrev opAlgEquivNeg {Λ : LinearMap.BilinForm ℤ L} (hΛ : LinearMap.IsAlt Λ) :
    (quantumTorus R u Λ)ᵐᵒᵖ ≃ₐ[R] quantumTorus R u (-Λ) :=
  opAlgEquiv hΛ.neg

end Opposite

end TauCeti.QuantumTorus
