/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.Quantum.Ore
public import Mathlib.Algebra.Ring.Hom.InjSurj

/-!
# Quantum charts and their ambient division rings

* **Ore realizations.** For a ring `A` whose nonzero elements form a left Ore set, an injective
  ring map `f : A → D` into a division ring induces a ring map from the skew field of fractions
  of `A` (`TauCeti.oreFractionHom`); it is an isomorphism exactly when `f(A)` generates `D`,
  i.e. `Subfield.closure (Set.range f) = ⊤` (`TauCeti.oreFractionEquiv`). Hence two such generating
    maps `A → D₁`, `A → D₂` induce a
  unique ring isomorphism `D₁ ≃+* D₂` compatible with them.
* A quantum chart is an injective `R`-algebra map `f` of `T(R,u,Λ)` into a division ring, stated
  as `Function.Injective f`; its coefficient ring is a domain (`isDomain_of_injective`).
  `TauCeti.QuantumTorus.IsGeneratingQuantumChart`: a quantum chart whose image generates the
  division ring. For a finite free lattice, **generating charts determine their ambient division
  ring up to unique isomorphism** (`IsGeneratingQuantumChart.equiv`,
  `IsGeneratingQuantumChart.existsUnique_ringEquiv`). The integral chart into the skew field of
  fractions is generating (`isGeneratingQuantumChart_integralChart`).
-/

@[expose] public section

namespace TauCeti

open nonZeroDivisors

/-! ### Ore realizations -/

section OreRealization

variable {A : Type*} [Ring A] [Nontrivial A] [NoZeroDivisors A]
  [OreLocalization.OreSet (nonZeroDivisors A)] {D : Type*} [DivisionRing D]

/-- An injective ring map into a division ring sends nonzero elements to units. -/
noncomputable def oreFractionUnits (f : A →+* D) (hf : Function.Injective f) : A⁰ →* Dˣ :=
  IsUnit.liftRight ((f : A →* D).comp A⁰.subtype) fun s ↦
    ((map_ne_zero_iff f hf).2 (nonZeroDivisors.coe_ne_zero s)).isUnit

variable (A) in
/-- The skew field of fractions of `A`: its left Ore localization at the nonzero elements. -/
abbrev OreFraction : Type _ := OreLocalization A⁰ A

/-- The ring map from the skew field of fractions of `A` induced by an injective ring map
`f : A → D` into a division ring, sending `s⁻¹ r` to `f(s)⁻¹ f(r)`. -/
noncomputable def oreFractionHom (f : A →+* D) (hf : Function.Injective f) : OreFraction A →+* D :=
  OreLocalization.universalHom f (oreFractionUnits f hf) fun _ ↦ rfl

omit [NoZeroDivisors A] in
theorem oreFractionHom_oreDiv (f : A →+* D) (hf : Function.Injective f) (r : A) (s : A⁰) :
    oreFractionHom f hf (r /ₒ s) = (f s)⁻¹ * f r := by
  change ((oreFractionUnits f hf s)⁻¹ : Dˣ) * f r = _
  rw [Units.val_inv_eq_inv_val]
  rfl

omit [NoZeroDivisors A] in
theorem oreFractionHom_numeratorHom (f : A →+* D) (hf : Function.Injective f) (r : A) :
    oreFractionHom f hf (OreLocalization.numeratorHom r) = f r :=
  OreLocalization.universalHom_commutes _ _ _

theorem oreFractionHom_injective (f : A →+* D) (hf : Function.Injective f) :
    Function.Injective (oreFractionHom f hf) := by
  refine (injective_iff_map_eq_zero _).2 fun x hx ↦ ?_
  by_contra hx0
  have h := map_mul (oreFractionHom f hf) x x⁻¹
  rw [mul_inv_cancel₀ hx0, map_one, hx, zero_mul] at h
  exact one_ne_zero h

/-- If `f(A)` generates `D` as a division ring, the induced map from the skew field of
fractions is surjective. -/
theorem oreFractionHom_surjective (f : A →+* D) (hf : Function.Injective f)
    (hgen : Subfield.closure (Set.range f) = ⊤) : Function.Surjective (oreFractionHom f hf) := by
  rw [← RingHom.fieldRange_eq_top_iff, eq_top_iff, ← hgen, Subfield.closure_le]
  rintro _ ⟨r, rfl⟩
  exact ⟨OreLocalization.numeratorHom r, oreFractionHom_numeratorHom f hf r⟩

omit [NoZeroDivisors A] in
/-- Conversely, if the induced map is surjective then `f(A)` generates `D`. -/
theorem closure_range_eq_top_of_surjective (f : A →+* D) (hf : Function.Injective f)
    (hs : Function.Surjective (oreFractionHom f hf)) : Subfield.closure (Set.range f) = ⊤ := by
  refine eq_top_iff.2 fun d _ ↦ ?_
  obtain ⟨x, rfl⟩ := hs d
  induction x using OreLocalization.ind with | _ r s
  rw [oreFractionHom_oreDiv]
  exact Subfield.mul_mem _ (Subfield.inv_mem _ (Subfield.subset_closure ⟨s, rfl⟩))
    (Subfield.subset_closure ⟨r, rfl⟩)

/-- **Every element of a generated division ring is a left fraction** `f(s)⁻¹ f(r)`. -/
theorem exists_eq_inv_mul_of_closure_eq_top (f : A →+* D) (hf : Function.Injective f)
    (hgen : Subfield.closure (Set.range f) = ⊤) (d : D) :
    ∃ r : A, ∃ s ∈ A⁰, d = (f s)⁻¹ * f r := by
  obtain ⟨x, rfl⟩ := oreFractionHom_surjective f hf hgen d
  induction x using OreLocalization.ind with | _ r s
  exact ⟨r, s, s.2, oreFractionHom_oreDiv f hf r s⟩

/-- **The ambient division ring of a generating realization** is the skew field of fractions. -/
noncomputable def oreFractionEquiv (f : A →+* D) (hf : Function.Injective f)
    (hgen : Subfield.closure (Set.range f) = ⊤) : OreFraction A ≃+* D :=
  RingEquiv.ofBijective (oreFractionHom f hf)
    ⟨oreFractionHom_injective f hf, oreFractionHom_surjective f hf hgen⟩

theorem oreFractionEquiv_numeratorHom (f : A →+* D) (hf : Function.Injective f)
    (hgen : Subfield.closure (Set.range f) = ⊤) (r : A) :
    oreFractionEquiv f hf hgen (OreLocalization.numeratorHom r) = f r :=
  oreFractionHom_numeratorHom f hf r

variable {D' : Type*} [DivisionRing D']

/-- The isomorphism between the ambient division rings of two generating realizations of `A`. -/
noncomputable def oreRealizationEquiv (f : A →+* D) (hf : Function.Injective f)
    (hgen : Subfield.closure (Set.range f) = ⊤) (f' : A →+* D') (hf' : Function.Injective f')
    (hgen' : Subfield.closure (Set.range f') = ⊤) : D ≃+* D' :=
  (oreFractionEquiv f hf hgen).symm.trans (oreFractionEquiv f' hf' hgen')

@[simp] theorem oreRealizationEquiv_apply (f : A →+* D) (hf : Function.Injective f)
    (hgen : Subfield.closure (Set.range f) = ⊤) (f' : A →+* D') (hf' : Function.Injective f')
    (hgen' : Subfield.closure (Set.range f') = ⊤) (r : A) :
    oreRealizationEquiv f hf hgen f' hf' hgen' (f r) = f' r := by
  rw [oreRealizationEquiv, RingEquiv.trans_apply, ← oreFractionEquiv_numeratorHom f hf hgen,
    RingEquiv.symm_apply_apply, oreFractionEquiv_numeratorHom]

end OreRealization

namespace QuantumTorus

/-! ### Quantum charts -/

section Chart

variable {R : Type*} [CommRing R] {L : Type*} [AddCommGroup L] {u : Rˣ}
    {Λ : LinearMap.BilinForm ℤ L}
  {D : Type*} [DivisionRing D] [Algebra R D]

/-- A **generating quantum chart**: an injective `R`-algebra map of `T(R,u,Λ)` into a division
ring whose image generates the division ring. -/
structure IsGeneratingQuantumChart (f : quantumTorus R u Λ →ₐ[R] D) : Prop where
  injective : Function.Injective f
  closure_range : Subfield.closure (Set.range f) = ⊤

/-- The scalars embed into the quantum torus. -/
theorem algebraMap_injective : Function.Injective (algebraMap R (quantumTorus R u Λ)) := by
  intro c c' h
  have hc : ∀ c : R, coeff 0 (algebraMap R (quantumTorus R u Λ) c) = c := fun c ↦ by
    rw [Algebra.algebraMap_eq_smul_one, ← monomial_zero, map_smul, coeff_monomial_self,
      smul_eq_mul, mul_one]
  rw [← hc c, h, hc]

/-- The coefficient ring of a quantum chart, an injective algebra map into a division ring, is a
domain. -/
theorem isDomain_of_injective {f : quantumTorus R u Λ →ₐ[R] D} (hf : Function.Injective f) :
    IsDomain R := by
  have h : Function.Injective (algebraMap R D) := by
    rw [← f.comp_algebraMap]
    exact hf.comp algebraMap_injective
  exact h.isDomain (algebraMap R D)

end Chart

section Uniqueness

variable {R : Type*} [CommRing R] {L : Type*} [AddCommGroup L] [Module.Free ℤ L]
  [Module.Finite ℤ L] {u : Rˣ} {Λ : LinearMap.BilinForm ℤ L} {D₁ : Type*} [DivisionRing D₁]
      [Algebra R D₁]
  {D₂ : Type*} [DivisionRing D₂] [Algebra R D₂]
  {f₁ : quantumTorus R u Λ →ₐ[R] D₁} {f₂ : quantumTorus R u Λ →ₐ[R] D₂}

/-- **Generating charts determine their ambient division ring**: two generating charts of the
same quantum torus into `D₁` and `D₂` induce an `R`-algebra isomorphism `D₁ ≃ D₂` compatible
with them (`IsGeneratingQuantumChart.equiv_apply`); it is the unique such ring isomorphism
(`IsGeneratingQuantumChart.existsUnique_ringEquiv`). -/
noncomputable def IsGeneratingQuantumChart.equiv (h₁ : IsGeneratingQuantumChart f₁)
    (h₂ : IsGeneratingQuantumChart f₂) : D₁ ≃ₐ[R] D₂ :=
  letI := isDomain_of_injective h₁.injective
  letI := (nonempty_oreSet_of_isDomain (R := R) (u := u) (Λ := Λ)).some
  AlgEquiv.ofRingEquiv
    (f := oreRealizationEquiv f₁.toRingHom h₁.injective h₁.closure_range
      f₂.toRingHom h₂.injective h₂.closure_range)
    fun r ↦ by
      rw [← f₁.commutes, ← f₂.commutes]
      exact oreRealizationEquiv_apply f₁.toRingHom _ _ f₂.toRingHom _ _ _

@[simp] theorem IsGeneratingQuantumChart.equiv_apply (h₁ : IsGeneratingQuantumChart f₁)
    (h₂ : IsGeneratingQuantumChart f₂) (x : quantumTorus R u Λ) : h₁.equiv h₂ (f₁ x) = f₂ x := by
  let := isDomain_of_injective h₁.injective
  let := (nonempty_oreSet_of_isDomain (R := R) (u := u) (Λ := Λ)).some
  exact oreRealizationEquiv_apply f₁.toRingHom _ _ f₂.toRingHom _ _ x

omit [Module.Free ℤ L] [Module.Finite ℤ L] in
/-- Ring isomorphisms between the ambient division rings of generating charts are determined
by their compatibility with the charts. -/
theorem IsGeneratingQuantumChart.ringEquiv_ext (h₁ : IsGeneratingQuantumChart f₁)
    {e e' : D₁ ≃+* D₂} (he : ∀ x, e (f₁ x) = f₂ x) (he' : ∀ x, e' (f₁ x) = f₂ x) : e = e' :=
  RingEquiv.toRingHom_injective <| RingHom.eq_of_eqOn_of_field_closure_eq_top
    h₁.closure_range (by rintro _ ⟨x, rfl⟩; exact (he x).trans (he' x).symm)

/-- **Uniqueness of the ambient realization.** Two generating charts of the same quantum torus
into `D₁` and `D₂` induce a unique ring isomorphism `D₁ ≃+* D₂` compatible with the charts. -/
theorem IsGeneratingQuantumChart.existsUnique_ringEquiv (h₁ : IsGeneratingQuantumChart f₁)
    (h₂ : IsGeneratingQuantumChart f₂) : ∃! e : D₁ ≃+* D₂, ∀ x, e (f₁ x) = f₂ x :=
  ⟨(h₁.equiv h₂).toRingEquiv, h₁.equiv_apply h₂, fun _ he ↦
    h₁.ringEquiv_ext he (h₁.equiv_apply h₂)⟩

end Uniqueness

/-! ### The integral chart is generating -/

section IntegralChart

variable (R : Type*) [CommRing R] (K : Type*) [Field K] [Algebra R K] [IsFractionRing R K]
  {L : Type*} [AddCommGroup L] [Module.Free ℤ L] [Module.Finite ℤ L] (u : Rˣ)
  (Λ : LinearMap.BilinForm ℤ L)

/-- In the skew field of fractions, `r /ₒ s = s⁻¹ r`. -/
theorem oreDiv_eq_inv_mul {u : Kˣ} (r : quantumTorus K u Λ)
    (s : nonZeroDivisors (quantumTorus K u Λ)) :
    (r /ₒ s : FractionDivisionRing K u Λ) =
      (OreLocalization.numeratorHom (s : quantumTorus K u Λ))⁻¹ * OreLocalization.numeratorHom r :=
        by
  have hs : (OreLocalization.numeratorHom (s : quantumTorus K u Λ) : FractionDivisionRing K u Λ) ≠
      0 := by
    rw [← map_zero (OreLocalization.numeratorRingHom (R := quantumTorus K u Λ)
      (S := nonZeroDivisors (quantumTorus K u Λ)))]
    exact fun h ↦ nonZeroDivisors.coe_ne_zero s (numeratorHom_injective K u Λ h)
  rw [eq_inv_mul_iff_mul_eq₀ hs, OreLocalization.numeratorHom_apply,
    OreLocalization.numeratorHom_apply, OreLocalization.mul_cancel]

/-- **The integral chart is generating**: `T(R,u,Λ)` generates the skew field of fractions of
`T(K,u,Λ)` as a division ring. -/
theorem isGeneratingQuantumChart_integralChart :
    IsGeneratingQuantumChart (integralChart R K u Λ) := by
  refine ⟨integralChart_injective R K u Λ, eq_top_iff.2 fun q _ ↦ ?_⟩
  set C := Subfield.closure (Set.range (integralChart R K u Λ))
  have hnum : ∀ x, (OreLocalization.numeratorHom x : FractionDivisionRing K _ Λ) ∈ C := by
    intro x
    obtain ⟨d, hd, y, hy⟩ := exists_mapRangeAlgHom_eq_smul x
    have hd1 : integralChart R K u Λ (d • 1) =
        OreLocalization.numeratorHom (algebraMap R K d • 1) := by
      rw [show (1 : quantumTorus R u Λ) = monomial 0 from monomial_zero.symm]
      change OreLocalization.numeratorRingHom
          (mapRangeAlgHom (algebraMap_coe_eq_coe_unitsMap K u) (d • monomial 0)) = _
      rw [mapRangeAlgHom_smul_monomial, monomial_zero]
      rfl
    have hd0 : (OreLocalization.numeratorHom (algebraMap R K d • 1 :
        quantumTorus K (Units.map (algebraMap R K : R →* K) u) Λ) :
        FractionDivisionRing K _ Λ) ≠ 0 := by
      rw [← map_zero (OreLocalization.numeratorRingHom (R := quantumTorus K _ Λ)
        (S := nonZeroDivisors (quantumTorus K (Units.map (algebraMap R K : R →* K) u) Λ)))]
      refine fun h ↦ smul_ne_zero (IsLocalization.map_units K (⟨d, hd⟩ : R⁰)).ne_zero
        one_ne_zero (numeratorHom_injective K _ Λ h)
    have e : OreLocalization.numeratorHom x =
        (OreLocalization.numeratorHom (algebraMap R K d • 1 :
          quantumTorus K (Units.map (algebraMap R K : R →* K) u) Λ) :
          FractionDivisionRing K _ Λ)⁻¹ * integralChart R K u Λ y := by
      rw [eq_inv_mul_iff_mul_eq₀ hd0]
      change OreLocalization.numeratorRingHom _ * OreLocalization.numeratorRingHom x =
        OreLocalization.numeratorRingHom (mapRangeAlgHom (algebraMap_coe_eq_coe_unitsMap K u) y)
      rw [← map_mul, hy, smul_mul_assoc, one_mul]
    rw [e, ← hd1]
    exact Subfield.mul_mem _ (Subfield.inv_mem _ (Subfield.subset_closure ⟨_, rfl⟩))
      (Subfield.subset_closure ⟨y, rfl⟩)
  induction q using OreLocalization.ind with | _ r s
  rw [oreDiv_eq_inv_mul]
  exact Subfield.mul_mem _ (Subfield.inv_mem _ (hnum _)) (hnum r)

end IntegralChart

end QuantumTorus

end TauCeti
