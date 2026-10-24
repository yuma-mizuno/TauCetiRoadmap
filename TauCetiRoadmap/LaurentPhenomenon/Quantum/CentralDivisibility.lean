/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.Quantum.Monomial
public import TauCetiRoadmap.LaurentPhenomenon.LaurentSupport
public import TauCetiRoadmap.LaurentPhenomenon.LaurentFactorial
public import TauCetiRoadmap.LaurentPhenomenon.FreeDivisibility

/-!
# Central divisibility in a quantum torus

Let `Λ` be alternating and let `e : I → L` be `ℤ`-linearly independent with `Λ (e i) = 0`
for every `i`. On the sublattice `N` spanned by `e` the cocycle is trivial, so
`n ↦ X^{Σ n_i e_i}` extends to an injective `R`-algebra map
`centralHom e : R[ℤ ^ I] → T(R,u,Λ)` with central image, and `T(R,u,Λ)` is an `R[ℤ ^ I]`-algebra
(`centralAlgebra`).

Choosing a representative `c₀` of each coset `c` of `N`, every `f` has a coset part
`cosetPart e c f ∈ R[ℤ ^ I]`; these are the coordinates of `f` in the basis `X^{c₀}` of
`T(R,u,Λ)` over `R[ℤ ^ I]` (`cosetBasis`), so `T(R,u,Λ)` is free over the central Laurent ring.
Consequently, if `P` and `Q` are relatively prime in `R[ℤ ^ I]`, then `T·P ∩ T·Q = T·(PQ)`
(`span_centralHom_inf_span_centralHom`), as an instance of `TauCeti.exists_eq_mul_algebraMap_mul`.

For two independent central exponents `p, q` over a factorial domain `R` the products
`∏ (1 + c X ^ p)` and `∏ (1 + d X ^ q)` are relatively prime in `R[ℤ²]`
(`Laurent.isRelPrime_list_prod_one_add_single`), which gives the central divisibility theorem used
for commuting exchanges; it is stated in particular over `Zv` with coefficients `v ^ h`.
-/

@[expose] public section

namespace TauCeti.QuantumTorus

open TauCeti

variable {R : Type*} [CommRing R] {L : Type*} [AddCommGroup L] {u : Rˣ}
    {Λ : LinearMap.BilinForm ℤ L}
  {I : Type*} {e : I → L}

/-! ### The central Laurent subring -/

theorem form_linearCombination_eq_zero (hc : ∀ i, Λ (e i) = 0) (n : I →₀ ℤ) :
    Λ (Finsupp.linearCombination ℤ e n) = 0 := by
  induction n using Finsupp.induction_linear with
  | zero => simp
  | add m n hm hn => rw [map_add, map_add, hm, hn, add_zero]
  | single i k => rw [Finsupp.linearCombination_single, map_zsmul, hc i, smul_zero]

/-- The algebra map `R[ℤ ^ I] → T(R,u,Λ)`, `x ^ n ↦ X^{Σ n_i e_i}`, for exponents `e i` in the
radical of `Λ`. -/
noncomputable def centralHom (e : I → L) (hc : ∀ i, Λ (e i) = 0) :
    AddMonoidAlgebra R (I →₀ ℤ) →ₐ[R] quantumTorus R u Λ :=
  AddMonoidAlgebra.lift R (quantumTorus R u Λ) (I →₀ ℤ)
    { toFun n := monomial (Finsupp.linearCombination ℤ e n.toAdd)
      map_one' := by simp
      map_mul' m n := by
        rw [monomial_mul_monomial, form_linearCombination_eq_zero hc]
        simp }

@[simp] theorem centralHom_single (hc : ∀ i, Λ (e i) = 0) (n : I →₀ ℤ) (r : R) :
    centralHom (u := u) e hc (AddMonoidAlgebra.single n r) =
      r • monomial (Finsupp.linearCombination ℤ e n) := by
  rw [centralHom, AddMonoidAlgebra.lift_single]
  rfl

/-- A monomial whose exponent is in the radical of an alternating form is central. -/
theorem commute_monomial_of_eq_zero (hΛ : LinearMap.IsAlt Λ) {a : L} (ha : Λ a = 0)
    (f : quantumTorus R u Λ) : Commute (monomial a) f := by
  rw [← sum_coeff_smul_monomial f]
  refine Commute.sum_right _ _ _ fun b _ ↦ Commute.smul_right ?_ _
  rw [Commute, SemiconjBy, monomial_mul_monomial_comm hΛ, ha]
  simp

/-- The image of `centralHom` is central. -/
theorem commute_centralHom (hΛ : LinearMap.IsAlt Λ) (hc : ∀ i, Λ (e i) = 0)
    (r : AddMonoidAlgebra R (I →₀ ℤ)) (f : quantumTorus R u Λ) :
    Commute (centralHom e hc r) f := by
  induction r using AddMonoidAlgebra.induction_linear with
  | zero => rw [map_zero]; exact Commute.zero_left f
  | add x y hx hy => rw [map_add]; exact hx.add_left hy
  | single n r =>
    rw [centralHom_single]
    exact (commute_monomial_of_eq_zero hΛ (form_linearCombination_eq_zero hc n) f).smul_left r

/-! ### Coset decomposition -/

/-- The sublattice `N` spanned by `e`. -/
noncomputable def latticeSpan (e : I → L) : AddSubgroup L :=
  (LinearMap.range (Finsupp.linearCombination ℤ e)).toAddSubgroup

theorem linearCombination_mem_latticeSpan (n : I →₀ ℤ) :
    Finsupp.linearCombination ℤ e n ∈ latticeSpan e :=
  LinearMap.mem_range_self _ n

theorem mk_add_linearCombination (a : L) (n : I →₀ ℤ) :
    ((a + Finsupp.linearCombination ℤ e n : L) : L ⧸ latticeSpan e) = a :=
  QuotientAddGroup.mk_add_of_mem a (linearCombination_mem_latticeSpan n)

theorem mk_out_add_linearCombination (c : L ⧸ latticeSpan e) (n : I →₀ ℤ) :
    ((c.out + Finsupp.linearCombination ℤ e n : L) : L ⧸ latticeSpan e) = c := by
  rw [mk_add_linearCombination, QuotientAddGroup.out_eq']

theorem exists_cosetCoord (e : I → L) (a : L) :
    ∃ n, Finsupp.linearCombination ℤ e n = a - (a : L ⧸ latticeSpan e).out := by
  have h : -(a : L ⧸ latticeSpan e).out + a ∈ latticeSpan e :=
    QuotientAddGroup.eq.1 (QuotientAddGroup.out_eq' (a : L ⧸ latticeSpan e))
  obtain ⟨n, hn⟩ := LinearMap.mem_range.1 (Submodule.mem_toAddSubgroup _ |>.1 h)
  exact ⟨n, by rw [hn]; abel⟩

/-- The coordinates in `ℤ ^ I` of `a` relative to the chosen representative of its coset. -/
noncomputable def cosetCoord (e : I → L) (a : L) : I →₀ ℤ :=
  (exists_cosetCoord e a).choose

theorem linearCombination_cosetCoord (a : L) :
    Finsupp.linearCombination ℤ e (cosetCoord e a) = a - (a : L ⧸ latticeSpan e).out :=
  (exists_cosetCoord e a).choose_spec

theorem out_add_cosetCoord (a : L) :
    (a : L ⧸ latticeSpan e).out + Finsupp.linearCombination ℤ e (cosetCoord e a) = a := by
  rw [linearCombination_cosetCoord]
  abel

theorem cosetCoord_out_add (he : LinearIndependent ℤ e) (c : L ⧸ latticeSpan e)
    (n : I →₀ ℤ) : cosetCoord e (c.out + Finsupp.linearCombination ℤ e n) = n := by
  refine he ?_
  rw [linearCombination_cosetCoord, mk_out_add_linearCombination]
  abel

theorem cosetCoord_add (he : LinearIndependent ℤ e) (a : L) (n : I →₀ ℤ) :
    cosetCoord e (a + Finsupp.linearCombination ℤ e n) = cosetCoord e a + n := by
  refine he ?_
  rw [map_add, linearCombination_cosetCoord, linearCombination_cosetCoord,
    mk_add_linearCombination]
  abel

open Classical in
/-- The part of an element in the coset `c` of `N`: the coefficient of `X^{c₀ + Σ n_i e_i}`,
for the chosen representative `c₀` of `c`, placed at `x ^ n`. -/
noncomputable def cosetPart (e : I → L) (c : L ⧸ latticeSpan e) :
    quantumTorus R u Λ →ₗ[R] AddMonoidAlgebra R (I →₀ ℤ) :=
  monomialBasis.constr R fun a ↦
    if (a : L ⧸ latticeSpan e) = c then AddMonoidAlgebra.single (cosetCoord e a) 1 else 0

theorem cosetPart_monomial_of_eq {c : L ⧸ latticeSpan e} {a : L}
    (h : (a : L ⧸ latticeSpan e) = c) :
    cosetPart (u := u) (Λ := Λ) e c (monomial a) = AddMonoidAlgebra.single (cosetCoord e a) 1 := by
  rw [← monomialBasis_apply, cosetPart, Module.Basis.constr_basis]
  simp [h]

theorem cosetPart_monomial_of_ne {c : L ⧸ latticeSpan e} {a : L}
    (h : (a : L ⧸ latticeSpan e) ≠ c) :
    cosetPart (u := u) (Λ := Λ) e c (monomial a) = 0 := by
  rw [← monomialBasis_apply, cosetPart, Module.Basis.constr_basis]
  simp [h]

/-- The coefficients of a coset part are coefficients of the element. -/
theorem coeff_cosetPart (he : LinearIndependent ℤ e) (c : L ⧸ latticeSpan e) (n : I →₀ ℤ)
    (f : quantumTorus R u Λ) :
    (cosetPart e c f).coeff n = coeff (c.out + Finsupp.linearCombination ℤ e n) f := by
  have key : (Finsupp.lapply n ∘ₗ (AddMonoidAlgebra.coeffLinearEquiv R).toLinearMap) ∘ₗ
      cosetPart (u := u) (Λ := Λ) e c = coeff (c.out + Finsupp.linearCombination ℤ e n) := by
    refine monomialBasis.ext fun a ↦ ?_
    simp only [LinearMap.comp_apply, monomialBasis_apply, LinearEquiv.coe_coe,
      AddMonoidAlgebra.coeffLinearEquiv_apply, Finsupp.lapply_apply]
    by_cases ha : a = c.out + Finsupp.linearCombination ℤ e n
    · subst ha
      rw [cosetPart_monomial_of_eq (mk_out_add_linearCombination c n), cosetCoord_out_add he,
        coeff_monomial_self, AddMonoidAlgebra.coeff_single, Finsupp.single_eq_same]
    · rw [coeff_monomial_of_ne ha]
      by_cases hac : (a : L ⧸ latticeSpan e) = c
      · have hn : cosetCoord e a ≠ n := by
          rintro rfl
          exact ha (by rw [← hac, out_add_cosetCoord])
        rw [cosetPart_monomial_of_eq hac, AddMonoidAlgebra.coeff_single,
          Finsupp.single_eq_of_ne hn.symm]
      · rw [cosetPart_monomial_of_ne hac, AddMonoidAlgebra.coeff_zero, Finsupp.zero_apply]
  exact LinearMap.congr_fun key f

/-- An element is determined by its coset parts. -/
theorem eq_of_cosetPart_eq (he : LinearIndependent ℤ e) {f g : quantumTorus R u Λ}
    (h : ∀ c, cosetPart e c f = cosetPart e c g) : f = g := by
  refine ext_coeff fun a ↦ ?_
  have := congrArg (fun x ↦ x.coeff (cosetCoord e a)) (h a)
  simpa only [coeff_cosetPart he, out_add_cosetCoord] using this

/-- The part in a coset meeting no exponent of the support vanishes. -/
theorem cosetPart_eq_zero (he : LinearIndependent ℤ e) {c : L ⧸ latticeSpan e}
    {f : quantumTorus R u Λ} (h : ∀ a ∈ support f, (a : L ⧸ latticeSpan e) ≠ c) :
    cosetPart e c f = 0 := by
  refine AddMonoidAlgebra.coeff_injective (Finsupp.ext fun n ↦ ?_)
  rw [coeff_cosetPart he, AddMonoidAlgebra.coeff_zero, Finsupp.zero_apply]
  exact coeff_eq_zero_of_notMem_support fun ha ↦ h _ ha (mk_out_add_linearCombination c n)

/-- Right multiplication by a central Laurent element acts on each coset part. -/
theorem cosetPart_mul_centralHom (hΛ : LinearMap.IsAlt Λ) (he : LinearIndependent ℤ e)
    (hc : ∀ i, Λ (e i) = 0) (c : L ⧸ latticeSpan e) (f : quantumTorus R u Λ)
    (r : AddMonoidAlgebra R (I →₀ ℤ)) :
    cosetPart e c (f * centralHom e hc r) = cosetPart e c f * r := by
  have key : cosetPart e c ∘ₗ LinearMap.mulRight R (centralHom (u := u) e hc r) =
      LinearMap.mulRight R r ∘ₗ cosetPart e c := by
    refine monomialBasis.ext fun a ↦ ?_
    simp only [LinearMap.comp_apply, LinearMap.mulRight_apply, monomialBasis_apply]
    induction r using AddMonoidAlgebra.induction_linear with
    | zero => simp
    | add x y hx hy => rw [map_add, mul_add, map_add, hx, hy, mul_add]
    | single n s =>
      have hΛa : Λ a (Finsupp.linearCombination ℤ e n) = 0 := by
        rw [← hΛ.neg, form_linearCombination_eq_zero hc, LinearMap.zero_apply, neg_zero]
      rw [centralHom_single, mul_smul_comm, monomial_mul_monomial, hΛa, zpow_zero,
        Units.val_one, one_smul, map_smul]
      by_cases hac : (a : L ⧸ latticeSpan e) = c
      · rw [cosetPart_monomial_of_eq (by rw [mk_add_linearCombination, hac]),
          cosetPart_monomial_of_eq hac, cosetCoord_add he, AddMonoidAlgebra.single_mul_single,
          one_mul, AddMonoidAlgebra.smul_single', mul_one]
      · rw [cosetPart_monomial_of_ne (by rwa [mk_add_linearCombination]),
          cosetPart_monomial_of_ne hac, smul_zero, zero_mul]
  exact LinearMap.congr_fun key f

/-- The coset parts of `centralHom e r * X^{c₀}`, for the representative `c₀` of `c`. -/
theorem cosetPart_centralHom_mul_monomial_out [DecidableEq (L ⧸ latticeSpan e)]
    (he : LinearIndependent ℤ e) (hc : ∀ i, Λ (e i) = 0) (c c' : L ⧸ latticeSpan e)
    (r : AddMonoidAlgebra R (I →₀ ℤ)) :
    cosetPart (u := u) e c' (centralHom e hc r * monomial c.out) = if c = c' then r else 0 := by
  induction r using AddMonoidAlgebra.induction_linear with
  | zero => simp
  | add x y hx hy =>
    rw [map_add, add_mul, map_add, hx, hy]
    split_ifs <;> simp
  | single n s =>
    rw [centralHom_single, smul_mul_assoc, monomial_mul_monomial,
      form_linearCombination_eq_zero hc, LinearMap.zero_apply, zpow_zero, Units.val_one,
      one_smul, map_smul, add_comm]
    split_ifs with h
    · subst h
      rw [cosetPart_monomial_of_eq (mk_out_add_linearCombination c n), cosetCoord_out_add he,
        AddMonoidAlgebra.smul_single', mul_one]
    · rw [cosetPart_monomial_of_ne ((mk_out_add_linearCombination c n).trans_ne h), smul_zero]

/-- **Freeness over the central Laurent ring**: every finitely supported family of coset parts
is realized by an element, namely `Σ_c centralHom e (h c) * X^{c₀}`. -/
theorem exists_cosetPart_eq (he : LinearIndependent ℤ e) (hc : ∀ i, Λ (e i) = 0)
    (h : L ⧸ latticeSpan e → AddMonoidAlgebra R (I →₀ ℤ)) (S : Finset (L ⧸ latticeSpan e))
    (hS : ∀ c ∉ S, h c = 0) :
    ∃ g : quantumTorus R u Λ, ∀ c, cosetPart e c g = h c := by
  classical
  refine ⟨∑ c ∈ S, centralHom e hc (h c) * monomial c.out, fun c' ↦ ?_⟩
  simp_rw [map_sum, cosetPart_centralHom_mul_monomial_out he hc, Finset.sum_ite_eq']
  split_ifs with hc'
  · rfl
  · exact (hS c' hc').symm

/-- `centralHom e` is injective: it identifies `R[ℤ ^ I]` with the span of the monomials of `N`. -/
theorem centralHom_injective (he : LinearIndependent ℤ e) (hc : ∀ i, Λ (e i) = 0) :
    Function.Injective (centralHom (R := R) (u := u) e hc) := by
  classical
  intro r s h
  have := congrArg (fun x ↦ cosetPart e (0 : L ⧸ latticeSpan e)
    (x * monomial (0 : L ⧸ latticeSpan e).out)) h
  simpa [cosetPart_centralHom_mul_monomial_out he hc] using this

/-! ### Freeness over the central Laurent ring -/

/-- `T(R,u,Λ)` as an algebra over the central Laurent ring `R[ℤ ^ I]` through `centralHom e`. -/
noncomputable abbrev centralAlgebra (hΛ : LinearMap.IsAlt Λ) (hc : ∀ i, Λ (e i) = 0) :
    Algebra (AddMonoidAlgebra R (I →₀ ℤ)) (quantumTorus R u Λ) :=
  (centralHom e hc).toRingHom.toAlgebra' fun r f ↦ commute_centralHom hΛ hc r f

theorem cosetPart_sum_centralHom_mul_monomial_out (he : LinearIndependent ℤ e)
    (hc : ∀ i, Λ (e i) = 0) (k : L ⧸ latticeSpan e →₀ AddMonoidAlgebra R (I →₀ ℤ))
    (c' : L ⧸ latticeSpan e) :
    cosetPart (u := u) e c' (k.sum fun c r ↦ centralHom e hc r * monomial c.out) = k c' := by
  classical
  rw [Finsupp.sum, map_sum]
  simp_rw [cosetPart_centralHom_mul_monomial_out he hc]
  rw [Finset.sum_ite_eq']
  split_ifs with h
  · rfl
  · exact (Finsupp.notMem_support_iff.1 h).symm

open Classical in
/-- The coset parts of an element, as a finitely supported family. -/
noncomputable def cosetParts (he : LinearIndependent ℤ e) (f : quantumTorus R u Λ) :
    L ⧸ latticeSpan e →₀ AddMonoidAlgebra R (I →₀ ℤ) :=
  Finsupp.onFinset ((support f).image (↑)) (fun c ↦ cosetPart e c f) fun c hc ↦ by
    by_contra h
    exact hc (cosetPart_eq_zero he fun a ha hac ↦ h (Finset.mem_image.2 ⟨a, ha, hac⟩))

@[simp] theorem cosetParts_apply (he : LinearIndependent ℤ e) (f : quantumTorus R u Λ)
    (c : L ⧸ latticeSpan e) : cosetParts he f c = cosetPart e c f := by
  classical
  simp [cosetParts]

/-- **Freeness over the central Laurent ring.** The monomials `X^{c₀}` at the chosen coset
representatives form a basis of `T(R,u,Λ)` over `R[ℤ ^ I]`; the coordinates are the coset
parts. -/
noncomputable def cosetBasis (hΛ : LinearMap.IsAlt Λ) (he : LinearIndependent ℤ e)
    (hc : ∀ i, Λ (e i) = 0) :
    letI := centralAlgebra (u := u) hΛ hc
    Module.Basis (L ⧸ latticeSpan e) (AddMonoidAlgebra R (I →₀ ℤ)) (quantumTorus R u Λ) :=
  letI := centralAlgebra (u := u) hΛ hc
  .ofRepr
    { toFun := cosetParts he
      invFun := fun k ↦ k.sum fun c r ↦ centralHom e hc r * monomial c.out
      map_add' := fun f g ↦ Finsupp.ext fun c ↦ by simp [map_add]
      map_smul' := fun r f ↦ by
        refine Finsupp.ext fun c ↦ ?_
        rw [cosetParts_apply, RingHom.id_apply, Finsupp.smul_apply, cosetParts_apply,
          smul_eq_mul, Algebra.smul_def]
        change cosetPart e c (centralHom e hc r * f) = r * cosetPart e c f
        rw [(commute_centralHom hΛ hc r f).eq, cosetPart_mul_centralHom hΛ he hc, mul_comm]
      left_inv := fun f ↦ eq_of_cosetPart_eq he fun c ↦ by
        rw [cosetPart_sum_centralHom_mul_monomial_out he hc, cosetParts_apply]
      right_inv := fun k ↦ by
        refine Finsupp.ext fun c ↦ ?_
        rw [cosetParts_apply, cosetPart_sum_centralHom_mul_monomial_out he hc] }

theorem cosetBasis_repr_apply (hΛ : LinearMap.IsAlt Λ) (he : LinearIndependent ℤ e)
    (hc : ∀ i, Λ (e i) = 0) (f : quantumTorus R u Λ) (c : L ⧸ latticeSpan e) :
    letI := centralAlgebra (u := u) hΛ hc
    (cosetBasis hΛ he hc).repr f c = cosetPart e c f :=
  cosetParts_apply he f c

theorem cosetBasis_apply (hΛ : LinearMap.IsAlt Λ) (he : LinearIndependent ℤ e)
    (hc : ∀ i, Λ (e i) = 0) (c : L ⧸ latticeSpan e) :
    letI := centralAlgebra (u := u) hΛ hc
    cosetBasis (u := u) hΛ he hc c = monomial c.out := by
  let := centralAlgebra (u := u) hΛ hc
  refine (cosetBasis hΛ he hc).repr.injective (Finsupp.ext fun c' ↦ ?_)
  classical
  rw [Module.Basis.repr_self, cosetBasis_repr_apply, ← one_mul (monomial c.out),
    ← map_one (centralHom (u := u) e hc), cosetPart_centralHom_mul_monomial_out he hc,
    Finsupp.single_apply]

/-- `T(R,u,Λ)` is free over the central Laurent ring `R[ℤ ^ I]`. -/
theorem free_centralAlgebra (hΛ : LinearMap.IsAlt Λ) (he : LinearIndependent ℤ e)
    (hc : ∀ i, Λ (e i) = 0) :
    letI := centralAlgebra (u := u) hΛ hc
    Module.Free (AddMonoidAlgebra R (I →₀ ℤ)) (quantumTorus R u Λ) :=
  letI := centralAlgebra (u := u) hΛ hc
  .of_basis (cosetBasis hΛ he hc)

/-! ### Central divisibility -/

/-- **Central divisibility.** If `P, Q` are relatively prime in `R[ℤ ^ I]`, an element divisible
on the right by `centralHom e P` and by `centralHom e Q` is divisible by
`centralHom e (P * Q)`. -/
theorem exists_eq_mul_centralHom_mul [DecompositionMonoid (AddMonoidAlgebra R (I →₀ ℤ))]
    (hΛ : LinearMap.IsAlt Λ) (he : LinearIndependent ℤ e) (hc : ∀ i, Λ (e i) = 0)
    {P Q : AddMonoidAlgebra R (I →₀ ℤ)} (hPQ : IsRelPrime P Q) {f : quantumTorus R u Λ}
    (hP : ∃ g, f = g * centralHom e hc P) (hQ : ∃ g, f = g * centralHom e hc Q) :
    ∃ g, f = g * centralHom e hc (P * Q) :=
  letI := centralAlgebra (u := u) hΛ hc
  TauCeti.exists_eq_mul_algebraMap_mul_of_basis (cosetBasis hΛ he hc) hPQ hP hQ

/-- **Central divisibility** as an equality of left ideals: `T P ∩ T Q = T (P Q)` for `P, Q`
relatively prime in `R[ℤ ^ I]`. -/
theorem span_centralHom_inf_span_centralHom
    [DecompositionMonoid (AddMonoidAlgebra R (I →₀ ℤ))] (hΛ : LinearMap.IsAlt Λ)
    (he : LinearIndependent ℤ e) (hc : ∀ i, Λ (e i) = 0) {P Q : AddMonoidAlgebra R (I →₀ ℤ)}
    (hPQ : IsRelPrime P Q) :
    Ideal.span {centralHom (u := u) e hc P} ⊓ Ideal.span {centralHom e hc Q} =
      Ideal.span {centralHom e hc (P * Q)} :=
  letI := centralAlgebra (u := u) hΛ hc
  letI := free_centralAlgebra (u := u) hΛ he hc
  TauCeti.span_algebraMap_inf_span_algebraMap hPQ

/-- **Central divisibility**, with the central factors on the left. -/
theorem exists_eq_centralHom_mul_mul [DecompositionMonoid (AddMonoidAlgebra R (I →₀ ℤ))]
    (hΛ : LinearMap.IsAlt Λ) (he : LinearIndependent ℤ e) (hc : ∀ i, Λ (e i) = 0)
    {P Q : AddMonoidAlgebra R (I →₀ ℤ)} (hPQ : IsRelPrime P Q) {f : quantumTorus R u Λ}
    (hP : ∃ g, f = centralHom e hc P * g) (hQ : ∃ g, f = centralHom e hc Q * g) :
    ∃ g, f = centralHom e hc (P * Q) * g :=
  (exists_eq_mul_centralHom_mul hΛ he hc hPQ
      (hP.imp fun g hg ↦ hg.trans (commute_centralHom hΛ hc P g).eq)
      (hQ.imp fun g hg ↦ hg.trans (commute_centralHom hΛ hc Q g).eq)).imp
    fun g hg ↦ hg.trans (commute_centralHom hΛ hc _ g).eq.symm

/-! ### Products of binomials in two independent central directions -/

/-- The product of a list of elements relatively prime to `y` is relatively prime to `y`. -/
theorem _root_.TauCeti.isRelPrime_list_prod_left {α : Type*} [CommMonoidWithZero α]
    [DecompositionMonoid α] {l : List α} {y : α} (h : ∀ x ∈ l, IsRelPrime x y) :
    IsRelPrime l.prod y := by
  induction l with
  | nil => exact isRelPrime_one_left
  | cons x l ih =>
    rw [List.prod_cons]
    exact (h x List.mem_cons_self).mul_left (ih fun z hz ↦ h z (List.mem_cons_of_mem _ hz))

/-- `x` is relatively prime to the product of a list of elements relatively prime to `x`. -/
theorem _root_.TauCeti.isRelPrime_list_prod_right {α : Type*} [CommMonoidWithZero α]
    [DecompositionMonoid α] {x : α} {l : List α} (h : ∀ y ∈ l, IsRelPrime x y) :
    IsRelPrime x l.prod :=
  (isRelPrime_list_prod_left fun y hy ↦ (h y hy).symm).symm

theorem linearIndependent_single_single {i j : I} (hij : i ≠ j) :
    LinearIndependent ℤ ![(Finsupp.single i 1 : I →₀ ℤ), Finsupp.single j 1] := by
  classical
  exact Laurent.linearIndependent_of_minor (r := i) (s := j) (by simp [hij, hij.symm])

/-- Binomials `1 + c x_i` and `1 + d x_j` in distinct variables are relatively prime in
`R[ℤ ^ I]` over a domain. -/
theorem isRelPrime_one_add_single [IsDomain R] {i j : I} (hij : i ≠ j)
    (c d : R) :
    IsRelPrime (1 + AddMonoidAlgebra.single (Finsupp.single i 1) c : AddMonoidAlgebra R (I →₀ ℤ))
      (1 + AddMonoidAlgebra.single (Finsupp.single j 1) d) := by
  classical
  exact Laurent.isRelPrime_unitBinomial (linearIndependent_single_single hij) c d

/-- Products of binomials in two distinct variables are relatively prime in `R[ℤ ^ I]` over a
domain; this is the coordinate case of `Laurent.isRelPrime_list_prod_one_add_single`. -/
theorem isRelPrime_list_prod_one_add_single [IsDomain R] {i j : I}
    (hij : i ≠ j) (α β : List Rˣ) :
    IsRelPrime
      (α.map fun c : Rˣ ↦
        (1 + AddMonoidAlgebra.single (Finsupp.single i 1) (c : R) :
          AddMonoidAlgebra R (I →₀ ℤ))).prod
      (β.map fun d : Rˣ ↦ 1 + AddMonoidAlgebra.single (Finsupp.single j 1) (d : R)).prod := by
  classical
  simpa only [List.map_map, Function.comp_def] using
    Laurent.isRelPrime_list_prod_one_add_single (linearIndependent_single_single hij)
      (α.map ((↑) : Rˣ → R)) (β.map ((↑) : Rˣ → R))

section TwoDirections

variable [IsDomain R] [UniqueFactorizationMonoid R] {p q : L}

omit [IsDomain R] [UniqueFactorizationMonoid R] in
private theorem centralHom_prod (hc : ∀ i, Λ (![p, q] i) = 0) (i : Fin 2) {x : L}
    (hx : ![p, q] i = x) (γ : List Rˣ) :
    centralHom (u := u) ![p, q] hc
        (γ.map fun c : Rˣ ↦ 1 + AddMonoidAlgebra.single (Finsupp.single i 1) (c : R)).prod =
      (γ.map fun c : Rˣ ↦ 1 + algebraMap R (quantumTorus R u Λ) c * monomial x).prod := by
  rw [map_list_prod, List.map_map]
  congr 1
  refine List.map_congr_left fun c _ ↦ ?_
  simp [centralHom_single, Algebra.smul_def, hx]

omit [IsDomain R] [UniqueFactorizationMonoid R] in
private theorem two_directions (hpq : ∀ m n : ℤ, m • p + n • q = 0 → m = 0 ∧ n = 0)
    (hp : ∀ a, Λ p a = 0) (hq : ∀ a, Λ q a = 0) :
    LinearIndependent ℤ ![p, q] ∧ ∀ i, Λ (![p, q] i) = 0 :=
  ⟨LinearIndependent.pair_iff.2 hpq, fun i ↦ by
    fin_cases i
    · exact LinearMap.ext hp
    · exact LinearMap.ext hq⟩

/-- **Central divisibility for commuting exchanges.** Let `p, q` be linearly independent and in
the radical of `Λ`, and put `P = ∏_{c ∈ α} (1 + c X ^ p)`, `Q = ∏_{d ∈ β} (1 + d X ^ q)` with
unit coefficients. If `f ∈ T P ∩ T Q` then `f ∈ T (P Q)`. -/
theorem exists_eq_mul_prod_mul_prod (hΛ : LinearMap.IsAlt Λ)
    (hpq : ∀ m n : ℤ, m • p + n • q = 0 → m = 0 ∧ n = 0)
    (hp : ∀ a, Λ p a = 0) (hq : ∀ a, Λ q a = 0) (α β : List Rˣ) {f : quantumTorus R u Λ}
    (hP : ∃ g, f = g *
      (α.map fun c : Rˣ ↦ 1 + algebraMap R (quantumTorus R u Λ) c * monomial p).prod)
    (hQ : ∃ g, f = g *
      (β.map fun d : Rˣ ↦ 1 + algebraMap R (quantumTorus R u Λ) d * monomial q).prod) :
    ∃ g, f = g * ((α.map fun c : Rˣ ↦ 1 + algebraMap R (quantumTorus R u Λ) c * monomial p).prod *
      (β.map fun d : Rˣ ↦ 1 + algebraMap R (quantumTorus R u Λ) d * monomial q).prod) := by
  classical
  obtain ⟨he, hc⟩ := two_directions hpq hp hq
  have := Laurent.latticeRing_uniqueFactorizationMonoid R (Fin 2)
  have h := exists_eq_mul_centralHom_mul hΛ he hc
    (isRelPrime_list_prod_one_add_single (i := 0) (j := 1) (by decide) α β) (f := f)
    (by rwa [centralHom_prod hc 0 rfl]) (by rwa [centralHom_prod hc 1 rfl])
  rwa [map_mul, centralHom_prod hc 0 rfl, centralHom_prod hc 1 rfl] at h

/-- **Central divisibility for commuting exchanges**, with the factors on the left. -/
theorem exists_eq_prod_mul_prod_mul (hΛ : LinearMap.IsAlt Λ)
    (hpq : ∀ m n : ℤ, m • p + n • q = 0 → m = 0 ∧ n = 0)
    (hp : ∀ a, Λ p a = 0) (hq : ∀ a, Λ q a = 0) (α β : List Rˣ) {f : quantumTorus R u Λ}
    (hP : ∃ g, f =
      (α.map fun c : Rˣ ↦ 1 + algebraMap R (quantumTorus R u Λ) c * monomial p).prod * g)
    (hQ : ∃ g, f =
      (β.map fun d : Rˣ ↦ 1 + algebraMap R (quantumTorus R u Λ) d * monomial q).prod * g) :
    ∃ g, f = (α.map fun c : Rˣ ↦ 1 + algebraMap R (quantumTorus R u Λ) c * monomial p).prod *
      (β.map fun d : Rˣ ↦ 1 + algebraMap R (quantumTorus R u Λ) d * monomial q).prod * g := by
  classical
  obtain ⟨he, hc⟩ := two_directions hpq hp hq
  have := Laurent.latticeRing_uniqueFactorizationMonoid R (Fin 2)
  have h := exists_eq_centralHom_mul_mul hΛ he hc
    (isRelPrime_list_prod_one_add_single (i := 0) (j := 1) (by decide) α β) (f := f)
    (by rwa [centralHom_prod hc 0 rfl]) (by rwa [centralHom_prod hc 1 rfl])
  rwa [map_mul, centralHom_prod hc 0 rfl, centralHom_prod hc 1 rfl] at h

end TwoDirections

/-! ### Over `Zv` -/

section Zv

/-- `Zv = ℤ[v^{±1}]` is factorial. -/
theorem uniqueFactorizationMonoid_Zv : UniqueFactorizationMonoid Zv :=
  Laurent.laurent_uniqueFactorizationMonoid

attribute [local instance] uniqueFactorizationMonoid_Zv

variable {p q : L}

/-- **Central divisibility over `Zv`.** For `p, q` linearly independent in the radical of `Λ`
and `P = ∏_{h ∈ α} (1 + v ^ h X ^ p)`, `Q = ∏_{h ∈ β} (1 + v ^ h X ^ q)`, `T P ∩ T Q = T (P Q)`. -/
theorem exists_eq_mul_prod_mul_prod_vUnit (hΛ : LinearMap.IsAlt Λ)
    (hpq : ∀ m n : ℤ, m • p + n • q = 0 → m = 0 ∧ n = 0)
    (hp : ∀ a, Λ p a = 0) (hq : ∀ a, Λ q a = 0) (α β : List ℤ)
    {f : quantumTorus Zv vUnit Λ}
    (hP : ∃ g, f = g * (α.map fun h ↦
      1 + algebraMap Zv (quantumTorus Zv vUnit Λ) ((vUnit ^ h : Zvˣ) : Zv) * monomial p).prod)
    (hQ : ∃ g, f = g * (β.map fun h ↦
      1 + algebraMap Zv (quantumTorus Zv vUnit Λ) ((vUnit ^ h : Zvˣ) : Zv) * monomial q).prod) :
    ∃ g, f = g * ((α.map fun h ↦
      1 + algebraMap Zv (quantumTorus Zv vUnit Λ) ((vUnit ^ h : Zvˣ) : Zv) * monomial p).prod *
      (β.map fun h ↦ 1 + algebraMap Zv (quantumTorus Zv vUnit Λ) ((vUnit ^ h : Zvˣ) : Zv) *
        monomial q).prod) := by
  have := exists_eq_mul_prod_mul_prod hΛ hpq hp hq (α.map (vUnit ^ ·)) (β.map (vUnit ^ ·))
    (f := f) (by simpa only [List.map_map, Function.comp_def] using hP)
    (by simpa only [List.map_map, Function.comp_def] using hQ)
  simpa only [List.map_map, Function.comp_def] using this

/-- **Central divisibility over `Zv`**, with the factors on the left. -/
theorem exists_eq_prod_mul_prod_mul_vUnit (hΛ : LinearMap.IsAlt Λ)
    (hpq : ∀ m n : ℤ, m • p + n • q = 0 → m = 0 ∧ n = 0)
    (hp : ∀ a, Λ p a = 0) (hq : ∀ a, Λ q a = 0) (α β : List ℤ)
    {f : quantumTorus Zv vUnit Λ}
    (hP : ∃ g, f = (α.map fun h ↦
      1 + algebraMap Zv (quantumTorus Zv vUnit Λ) ((vUnit ^ h : Zvˣ) : Zv) * monomial p).prod * g)
    (hQ : ∃ g, f = (β.map fun h ↦
      1 + algebraMap Zv (quantumTorus Zv vUnit Λ) ((vUnit ^ h : Zvˣ) : Zv) * monomial q).prod * g) :
    ∃ g, f = (α.map fun h ↦
      1 + algebraMap Zv (quantumTorus Zv vUnit Λ) ((vUnit ^ h : Zvˣ) : Zv) * monomial p).prod *
      (β.map fun h ↦
        1 + algebraMap Zv (quantumTorus Zv vUnit Λ) ((vUnit ^ h : Zvˣ) : Zv) * monomial q).prod *
        g := by
  have := exists_eq_prod_mul_prod_mul hΛ hpq hp hq (α.map (vUnit ^ ·)) (β.map (vUnit ^ ·))
    (f := f) (by simpa only [List.map_map, Function.comp_def] using hP)
    (by simpa only [List.map_map, Function.comp_def] using hQ)
  simpa only [List.map_map, Function.comp_def] using this

end Zv

end TauCeti.QuantumTorus
