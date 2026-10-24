/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.Quantum.Monomial

/-!
# Coefficient change and lattice reindexing of based quantum tori

* `TauCeti.QuantumTorus.mapRangeAlgHom`, `TauCeti.QuantumTorus.mapRangeRingHom`: change of
  coefficients `T(R,u,Λ) → T(R',u',Λ)` along a ring map `f` with `f u = u'`, given by
  `c • X ^ a ↦ f c • X ^ a`. It acts coefficientwise (`coeff_mapRangeRingHom`), is injective when
    `f`
  is, has kernel the elements with all coefficients in `ker f`, and satisfies the identity and
  composition laws; along a ring isomorphism it is a ring isomorphism
  (`TauCeti.QuantumTorus.mapRangeRingEquiv`).
* `TauCeti.QuantumTorus.mapDomainAlgHom`: for an additive map `e : L →+ L'` with
  `Λ' (e a) (e b) = Λ a b`, the `R`-algebra map `T(R,u,Λ) → T(R,u,Λ')`, `X ^ a ↦ X^{e a}`.
  For an additive equivalence this is the lattice reindexing
  `TauCeti.QuantumTorus.domCongr : T(R,u,Λ) ≃ₐ[R] T(R,u,Λ')`, with `coeff (e a) ∘ domCongr =
  coeff a`. Both satisfy the identity and composition laws and commute with coefficient change.
-/

@[expose] public section

namespace TauCeti.QuantumTorus

open TauCeti

variable {R : Type*} [CommRing R] {L : Type*} [AddCommGroup L] {u : Rˣ}
    {Λ : LinearMap.BilinForm ℤ L}

/-! ### Change of coefficients -/

section MapRange

variable {R' : Type*} [CommRing R'] {R'' : Type*} [CommRing R''] {u' : R'ˣ} {u'' : R''ˣ}

/-- The values of the cocycle are compatible with a ring map sending `u` to `u'`. -/
theorem map_cocycle {F : Type*} [FunLike F R R'] [MonoidHomClass F R R'] (f : F)
    (hu : f u = u') (g h : Multiplicative L) :
    f (cocycle u Λ g h : R) = (cocycle u' Λ g h : R') := by
  have hu' : Units.map (f : R →* R') u = u' := Units.ext hu
  rw [cocycle, cocycle, ← hu', ← map_zpow, Units.coe_map, MonoidHom.coe_ofClass]

section AlgHom

variable [Algebra R R']

/-- Change of coefficients along `algebraMap R R'`, as an `R`-algebra map
`T(R,u,Λ) →ₐ[R] T(R',u',Λ)` sending `X ^ a` to `X ^ a`. -/
noncomputable def mapRangeAlgHom (hu : algebraMap R R' u = u') :
    quantumTorus R u Λ →ₐ[R] quantumTorus R' u' Λ :=
  TwistedMonoidAlgebra.lift (fun g ↦ TwistedMonoidAlgebra.of g) TwistedMonoidAlgebra.of_one
    fun g h ↦ by
      rw [TwistedMonoidAlgebra.of_mul_of, ← algebraMap_smul R' ((cocycle u Λ g h : Rˣ) : R),
        map_cocycle _ hu]

@[simp]
theorem mapRangeAlgHom_monomial (hu : algebraMap R R' u = u') (a : L) :
    mapRangeAlgHom (Λ := Λ) hu (monomial a) = monomial a :=
  TwistedMonoidAlgebra.lift_of ..

theorem mapRangeAlgHom_smul_monomial (hu : algebraMap R R' u = u') (c : R) (a : L) :
    mapRangeAlgHom (Λ := Λ) hu (c • monomial a) = algebraMap R R' c • monomial a := by
  rw [map_smul, mapRangeAlgHom_monomial, algebraMap_smul]

/-- Change of coefficients acts coefficientwise. -/
theorem coeff_mapRangeAlgHom (hu : algebraMap R R' u = u') (x : quantumTorus R u Λ) (a : L) :
    coeff a (mapRangeAlgHom hu x) = algebraMap R R' (coeff a x) := by
  classical
  conv_lhs => rw [← sum_coeff_smul_monomial x]
  simp only [map_sum, mapRangeAlgHom_smul_monomial]
  simp only [map_smul, coeff_monomial, Finsupp.single_apply, smul_eq_mul, mul_ite, mul_one,
    mul_zero, Finset.sum_ite_eq']
  split_ifs with h
  · rfl
  · rw [coeff_eq_zero_of_notMem_support h, map_zero]

/-- The coefficients of the image under change of coefficients. -/
theorem repr_mapRangeAlgHom (hu : algebraMap R R' u = u') (x : quantumTorus R u Λ) (a : L) :
    monomialBasis.repr (mapRangeAlgHom hu x) a = algebraMap R R' (monomialBasis.repr x a) :=
  coeff_mapRangeAlgHom hu x a

theorem mapRangeAlgHom_injective (hu : algebraMap R R' u = u')
    (hf : Function.Injective (algebraMap R R')) :
    Function.Injective (mapRangeAlgHom (Λ := Λ) hu) := by
  refine (injective_iff_map_eq_zero _).2 fun x hx ↦ ext_coeff fun a ↦ hf ?_
  rw [← coeff_mapRangeAlgHom hu, hx]
  simp

/-- Change of coefficients along the identity is the identity. -/
@[simp]
theorem mapRangeAlgHom_self (hu : algebraMap R R (u : R) = (u : R)) :
    mapRangeAlgHom (Λ := Λ) hu = AlgHom.id R (quantumTorus R u Λ) :=
  TwistedMonoidAlgebra.algHom_ext fun g ↦ mapRangeAlgHom_monomial hu (Multiplicative.toAdd g)

/-- Change of coefficients along a tower `R → R' → R''` is the composite of the two changes. -/
theorem mapRangeAlgHom_mapRangeAlgHom [Algebra R' R''] [Algebra R R''] [IsScalarTower R R' R'']
    (hu : algebraMap R R' u = u') (hu' : algebraMap R' R'' u' = u'')
    (hu'' : algebraMap R R'' u = u'') (x : quantumTorus R u Λ) :
    mapRangeAlgHom hu' (mapRangeAlgHom hu x) = mapRangeAlgHom hu'' x :=
  ext_coeff fun a ↦ by
    rw [coeff_mapRangeAlgHom, coeff_mapRangeAlgHom, coeff_mapRangeAlgHom,
      IsScalarTower.algebraMap_apply R R' R'']

end AlgHom

/-- Change of coefficients along a ring map `f : R →+* R'` with `f u = u'`, sending
`c • X ^ a` to `f c • X ^ a`. -/
noncomputable def mapRangeRingHom (f : R →+* R') (hu : f u = u') :
    quantumTorus R u Λ →+* quantumTorus R' u' Λ :=
  letI := f.toAlgebra
  (mapRangeAlgHom (R' := R') hu).toRingHom

theorem mapRangeRingHom_smul_monomial (f : R →+* R') (hu : f u = u') (c : R) (a : L) :
    mapRangeRingHom (Λ := Λ) f hu (c • monomial a) = f c • monomial a :=
  letI := f.toAlgebra
  mapRangeAlgHom_smul_monomial (R' := R') hu c a

@[simp]
theorem mapRangeRingHom_monomial (f : R →+* R') (hu : f u = u') (a : L) :
    mapRangeRingHom (Λ := Λ) f hu (monomial a) = monomial a :=
  letI := f.toAlgebra
  mapRangeAlgHom_monomial (R' := R') hu a

/-- Change of coefficients acts coefficientwise. -/
@[simp]
theorem coeff_mapRangeRingHom (f : R →+* R') (hu : f u = u') (x : quantumTorus R u Λ)
    (a : L) : coeff a (mapRangeRingHom f hu x) = f (coeff a x) :=
  letI := f.toAlgebra
  coeff_mapRangeAlgHom (R' := R') hu x a

theorem repr_mapRangeRingHom (f : R →+* R') (hu : f u = u') (x : quantumTorus R u Λ)
    (a : L) : monomialBasis.repr (mapRangeRingHom f hu x) a = f (monomialBasis.repr x a) :=
  coeff_mapRangeRingHom f hu x a

theorem mapRangeRingHom_injective (f : R →+* R') (hu : f u = u')
    (hf : Function.Injective f) : Function.Injective (mapRangeRingHom (Λ := Λ) f hu) :=
  letI := f.toAlgebra
  mapRangeAlgHom_injective (R' := R') hu hf

/-- An element lies in the kernel of a change of coefficients iff all its coefficients lie in the
kernel of the ring map. -/
theorem mem_ker_mapRangeRingHom (f : R →+* R') (hu : f u = u') {x : quantumTorus R u Λ} :
    x ∈ RingHom.ker (mapRangeRingHom f hu) ↔ ∀ a, coeff a x ∈ RingHom.ker f := by
  simp only [RingHom.mem_ker]
  refine ⟨fun h a ↦ ?_, fun h ↦ ext_coeff fun a ↦ ?_⟩
  · rw [← coeff_mapRangeRingHom f hu, h, map_zero]
  · rw [coeff_mapRangeRingHom, h, map_zero]

/-- Change of coefficients along the identity is the identity. -/
@[simp]
theorem mapRangeRingHom_id :
    mapRangeRingHom (Λ := Λ) (RingHom.id R) (u := u) rfl = RingHom.id (quantumTorus R u Λ) :=
  RingHom.ext fun x ↦ ext_coeff fun a ↦ by simp

/-- Change of coefficients along a composite is the composite of the changes. -/
theorem mapRangeRingHom_comp (g : R' →+* R'') (f : R →+* R') (hv : g u' = u'')
    (hu : f u = u') :
    (mapRangeRingHom (Λ := Λ) g hv).comp (mapRangeRingHom f hu) =
      mapRangeRingHom (g.comp f) (by rw [RingHom.comp_apply, hu, hv]) :=
  RingHom.ext fun x ↦ ext_coeff fun a ↦ by simp

theorem mapRangeRingHom_mapRangeRingHom (g : R' →+* R'') (f : R →+* R') (hv : g u' = u'')
    (hu : f u = u') (x : quantumTorus R u Λ) :
    mapRangeRingHom (Λ := Λ) g hv (mapRangeRingHom f hu x) =
      mapRangeRingHom (g.comp f) (by rw [RingHom.comp_apply, hu, hv]) x :=
  RingHom.congr_fun (mapRangeRingHom_comp g f hv hu) x

/-- Change of coefficients along a ring isomorphism `e : R ≃+* R'` with `e u = u'`. -/
noncomputable def mapRangeRingEquiv (e : R ≃+* R') (hu : e u = u') :
    quantumTorus R u Λ ≃+* quantumTorus R' u' Λ :=
  RingEquiv.ofRingHom (mapRangeRingHom (e : R →+* R') (show (e : R →+* R') u = u' from hu))
    (mapRangeRingHom (e.symm : R' →+* R) (by rw [← hu]; exact e.symm_apply_apply _))
    (RingHom.ext fun x ↦ ext_coeff fun a ↦ by
      rw [RingHom.comp_apply, coeff_mapRangeRingHom, coeff_mapRangeRingHom]
      exact e.apply_symm_apply _)
    (RingHom.ext fun x ↦ ext_coeff fun a ↦ by
      rw [RingHom.comp_apply, coeff_mapRangeRingHom, coeff_mapRangeRingHom]
      exact e.symm_apply_apply _)

@[simp]
theorem coe_mapRangeRingEquiv (e : R ≃+* R') (hu : e u = u') :
    ⇑(mapRangeRingEquiv (Λ := Λ) e hu) =
      mapRangeRingHom (e : R →+* R') (show (e : R →+* R') u = u' from hu) :=
  rfl

end MapRange

/-! ### Lattice reindexing -/

section MapDomain

variable {L' : Type*} [AddCommGroup L'] {L'' : Type*} [AddCommGroup L'']
  {Λ' : LinearMap.BilinForm ℤ L'} {Λ'' : LinearMap.BilinForm ℤ L''}

/-- For an additive map `e : L →+ L'` carrying `Λ` to `Λ'`, the `R`-algebra map
`T(R,u,Λ) → T(R,u,Λ')` sending `X ^ a` to `X^{e a}`. -/
noncomputable def mapDomainAlgHom (e : L →+ L') (hΛ : ∀ a b, Λ' (e a) (e b) = Λ a b) :
    quantumTorus R u Λ →ₐ[R] quantumTorus R u Λ' :=
  TwistedMonoidAlgebra.lift (fun g ↦ monomial (e g.toAdd)) (by simp)
    fun g h ↦ by
      rw [monomial_mul_monomial, hΛ, ← map_add, toAdd_mul]
      rfl

@[simp]
theorem mapDomainAlgHom_monomial (e : L →+ L') (hΛ : ∀ a b, Λ' (e a) (e b) = Λ a b) (a : L) :
    mapDomainAlgHom (u := u) e hΛ (monomial a) = monomial (e a) :=
  TwistedMonoidAlgebra.lift_of ..

theorem mapDomainAlgHom_smul_monomial (e : L →+ L') (hΛ : ∀ a b, Λ' (e a) (e b) = Λ a b)
    (c : R) (a : L) :
    mapDomainAlgHom (u := u) e hΛ (c • monomial a) = c • monomial (e a) := by
  rw [map_smul, mapDomainAlgHom_monomial]

@[simp]
theorem mapDomainAlgHom_id :
    mapDomainAlgHom (AddMonoidHom.id L) (fun _ _ ↦ rfl) =
      AlgHom.id R (quantumTorus R u Λ) :=
  TwistedMonoidAlgebra.algHom_ext fun g ↦
    mapDomainAlgHom_monomial (AddMonoidHom.id L) _ (Multiplicative.toAdd g)

theorem mapDomainAlgHom_comp (e' : L' →+ L'') (e : L →+ L')
    (hΛ' : ∀ a b, Λ'' (e' a) (e' b) = Λ' a b) (hΛ : ∀ a b, Λ' (e a) (e b) = Λ a b) :
    (mapDomainAlgHom (u := u) e' hΛ').comp (mapDomainAlgHom e hΛ) =
      mapDomainAlgHom (e'.comp e) (fun a b ↦ (hΛ' _ _).trans (hΛ a b)) :=
  TwistedMonoidAlgebra.algHom_ext fun g ↦ by
    change mapDomainAlgHom e' hΛ' (mapDomainAlgHom e hΛ (monomial g.toAdd)) =
      mapDomainAlgHom (e'.comp e) _ (monomial g.toAdd)
    rw [mapDomainAlgHom_monomial, mapDomainAlgHom_monomial, mapDomainAlgHom_monomial,
      AddMonoidHom.comp_apply]

/-- Lattice reindexing commutes with change of coefficients. -/
theorem mapRangeRingHom_mapDomainAlgHom {R' : Type*} [CommRing R'] {u' : R'ˣ} (f : R →+* R')
    (hu : f u = u') (e : L →+ L') (hΛ : ∀ a b, Λ' (e a) (e b) = Λ a b)
    (x : quantumTorus R u Λ) :
    mapRangeRingHom f hu (mapDomainAlgHom e hΛ x) =
      mapDomainAlgHom e hΛ (mapRangeRingHom f hu x) := by
  conv_lhs => rw [← sum_coeff_smul_monomial x]
  conv_rhs => rw [← sum_coeff_smul_monomial x]
  simp only [map_sum, mapDomainAlgHom_smul_monomial, mapRangeRingHom_smul_monomial]

/-- **Lattice reindexing.** An additive equivalence `e : L ≃+ L'` carrying `Λ` to `Λ'` induces
the `R`-algebra isomorphism `T(R,u,Λ) ≃ₐ[R] T(R,u,Λ')`, `X ^ a ↦ X^{e a}`. -/
noncomputable def domCongr (e : L ≃+ L') (hΛ : ∀ a b, Λ' (e a) (e b) = Λ a b) :
    quantumTorus R u Λ ≃ₐ[R] quantumTorus R u Λ' :=
  AlgEquiv.ofAlgHom (mapDomainAlgHom (e : L →+ L') hΛ)
    (mapDomainAlgHom (e.symm : L' →+ L) fun a b ↦ by
      rw [← hΛ, AddMonoidHom.coe_ofClass, e.apply_symm_apply, e.apply_symm_apply])
    (by rw [mapDomainAlgHom_comp]; ext g; simp)
    (by rw [mapDomainAlgHom_comp]; ext g; simp)

theorem domCongr_apply (e : L ≃+ L') (hΛ : ∀ a b, Λ' (e a) (e b) = Λ a b)
    (x : quantumTorus R u Λ) : domCongr e hΛ x = mapDomainAlgHom (e : L →+ L') hΛ x :=
  rfl

@[simp]
theorem domCongr_monomial (e : L ≃+ L') (hΛ : ∀ a b, Λ' (e a) (e b) = Λ a b) (a : L) :
    domCongr (u := u) e hΛ (monomial a) = monomial (e a) :=
  mapDomainAlgHom_monomial _ hΛ a

theorem domCongr_smul_monomial (e : L ≃+ L') (hΛ : ∀ a b, Λ' (e a) (e b) = Λ a b)
    (c : R) (a : L) : domCongr (u := u) e hΛ (c • monomial a) = c • monomial (e a) :=
  mapDomainAlgHom_smul_monomial _ hΛ c a

/-- Reindexing moves the coefficient of `X ^ a` to `X^{e a}`. -/
@[simp]
theorem coeff_domCongr (e : L ≃+ L') (hΛ : ∀ a b, Λ' (e a) (e b) = Λ a b)
    (x : quantumTorus R u Λ) (a : L) : coeff (e a) (domCongr e hΛ x) = coeff a x := by
  classical
  conv_lhs => rw [← sum_coeff_smul_monomial x]
  simp only [map_sum, map_smul, domCongr_monomial, coeff_monomial, Finsupp.single_apply,
    e.injective.eq_iff, smul_eq_mul, mul_ite, mul_one, mul_zero, Finset.sum_ite_eq']
  split_ifs with h
  · rfl
  · rw [coeff_eq_zero_of_notMem_support h]

@[simp]
theorem domCongr_refl :
    domCongr (AddEquiv.refl L) (fun _ _ ↦ rfl) = AlgEquiv.refl (R := R) (A₁ := quantumTorus R u Λ)
      :=
  AlgEquiv.ext fun x ↦ ext_coeff fun a ↦ coeff_domCongr (AddEquiv.refl L) _ x a

theorem domCongr_trans (e : L ≃+ L') (e' : L' ≃+ L'') (hΛ : ∀ a b, Λ' (e a) (e b) = Λ a b)
    (hΛ' : ∀ a b, Λ'' (e' a) (e' b) = Λ' a b) :
    (domCongr (u := u) e hΛ).trans (domCongr e' hΛ') =
      domCongr (e.trans e') (fun a b ↦ by rw [AddEquiv.trans_apply, AddEquiv.trans_apply, hΛ', hΛ])
        :=
  AlgEquiv.ext fun x ↦ ext_coeff fun c ↦ by
    obtain ⟨a, rfl⟩ := (e.trans e').surjective c
    rw [AlgEquiv.trans_apply, AddEquiv.trans_apply, coeff_domCongr, coeff_domCongr,
      ← AddEquiv.trans_apply, coeff_domCongr]

theorem domCongr_symm (e : L ≃+ L') (hΛ : ∀ a b, Λ' (e a) (e b) = Λ a b) :
    (domCongr (u := u) e hΛ).symm = domCongr e.symm (fun a b ↦ by
      rw [← hΛ, e.apply_symm_apply, e.apply_symm_apply]) :=
  AlgEquiv.ext fun x ↦ ext_coeff fun c ↦ by
    obtain ⟨a, rfl⟩ := e.symm.surjective c
    rw [coeff_domCongr, ← coeff_domCongr e hΛ, AlgEquiv.apply_symm_apply, e.apply_symm_apply]

/-- Lattice reindexing commutes with change of coefficients. -/
theorem mapRangeRingHom_domCongr {R' : Type*} [CommRing R'] {u' : R'ˣ} (f : R →+* R')
    (hu : f u = u') (e : L ≃+ L') (hΛ : ∀ a b, Λ' (e a) (e b) = Λ a b)
    (x : quantumTorus R u Λ) :
    mapRangeRingHom f hu (domCongr e hΛ x) = domCongr e hΛ (mapRangeRingHom f hu x) :=
  mapRangeRingHom_mapDomainAlgHom f hu (e : L →+ L') hΛ x

end MapDomain

end TauCeti.QuantumTorus
