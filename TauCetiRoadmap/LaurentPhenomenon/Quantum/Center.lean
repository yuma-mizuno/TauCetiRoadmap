/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.Quantum.CentralDivisibility
public import TauCetiRoadmap.LaurentPhenomenon.Quantum.Support

/-!
# The center of a quantum torus

Let `Λ` be alternating and let `rad Λ = {n | ∀ a, Λ n a = 0}`, the kernel `LinearMap.ker Λ`.
Monomials `X ^ n` with `n ∈ rad Λ` are central. Conversely, comparing the coefficients of `X^{a +
  b}` in
`f X ^ b` and `X ^ b f` gives `c_a u^{Λ(a,b)} = c_a u^{-Λ(a,b)}`; over a domain, and when no nonzero
power of `u²` is `1`, this forces `Λ(a,b) = 0` for every exponent `a` of a central `f`. Hence the
center of `T(R,u,Λ)` is the span of the monomials of `rad Λ`, which is the image of `centralHom e`
for any `e` spanning `rad Λ`; for linearly independent `e` (a basis of `rad Λ`, which exists
when `L` is a lattice) this identifies the center with the Laurent ring `R[ℤ ^ I] ≅ R[rad Λ]`.

Finally, the group ring of a finitely generated torsion-free abelian group over a factorial
domain is factorial; in particular `Zv[N]` is factorial for every sublattice `N`.
-/

@[expose] public section

namespace TauCeti.QuantumTorus

open TauCeti

variable {R : Type*} [CommRing R] {L : Type*} [AddCommGroup L] {u : Rˣ}
    {Λ : LinearMap.BilinForm ℤ L}

/-! ### Coefficients of products with a monomial -/

/-- The coefficient of `X^{a + b}` in `f X ^ b` is `c_a u^{Λ(a,b)}`. -/
theorem coeff_add_mul_monomial (f : quantumTorus R u Λ) (a b : L) :
    coeff (a + b) (f * monomial b) = coeff a f * ((u ^ Λ a b : Rˣ) : R) := by
  have key : coeff (a + b) ∘ₗ LinearMap.mulRight R (monomial b : quantumTorus R u Λ) =
      ((u ^ Λ a b : Rˣ) : R) • coeff a := by
    refine monomialBasis.ext fun a' ↦ ?_
    simp only [LinearMap.comp_apply, LinearMap.mulRight_apply, monomialBasis_apply,
      LinearMap.smul_apply, monomial_mul_monomial, map_smul, smul_eq_mul]
    by_cases h : a' = a
    · subst h
      simp
    · rw [coeff_monomial_of_ne ((add_left_injective b).ne h), coeff_monomial_of_ne h]
      simp
  simpa [mul_comm] using LinearMap.congr_fun key f

/-- The coefficient of `X^{b + a}` in `X ^ b f` is `u^{Λ(b,a)} c_a`. -/
theorem coeff_add_monomial_mul (f : quantumTorus R u Λ) (a b : L) :
    coeff (b + a) (monomial b * f) = ((u ^ Λ b a : Rˣ) : R) * coeff a f := by
  have key : coeff (b + a) ∘ₗ LinearMap.mulLeft R (monomial b : quantumTorus R u Λ) =
      ((u ^ Λ b a : Rˣ) : R) • coeff a := by
    refine monomialBasis.ext fun a' ↦ ?_
    simp only [LinearMap.comp_apply, LinearMap.mulLeft_apply, monomialBasis_apply,
      LinearMap.smul_apply, monomial_mul_monomial, map_smul, smul_eq_mul]
    by_cases h : a' = a
    · subst h
      simp
    · rw [coeff_monomial_of_ne ((add_right_injective b).ne h), coeff_monomial_of_ne h]
      simp
  exact LinearMap.congr_fun key f

/-! ### Central elements -/

/-- An element supported on `rad Λ` is central. -/
theorem mem_center_of_forall_mem_support (hΛ : LinearMap.IsAlt Λ) {f : quantumTorus R u Λ}
    (h : ∀ a ∈ support f, Λ a = 0) : f ∈ Subalgebra.center R (quantumTorus R u Λ) := by
  refine Subalgebra.mem_center_iff.2 fun g ↦ ?_
  have hf : Commute g f := by
    rw [← sum_coeff_smul_monomial f]
    exact Commute.sum_right _ _ _ fun a ha ↦
      ((commute_monomial_of_eq_zero hΛ (h a ha) g).symm).smul_right _
  exact hf.eq

/-- **The center of a quantum torus.** Over a domain, when no nonzero power of `u²` is `1`, an
element is central exactly when its support lies in `rad Λ = LinearMap.ker Λ`. -/
theorem mem_center_iff [IsDomain R] (hΛ : LinearMap.IsAlt Λ) (hu : ¬IsOfFinOrder (u ^ 2))
    {f : quantumTorus R u Λ} :
    f ∈ Subalgebra.center R (quantumTorus R u Λ) ↔ ∀ a ∈ support f, Λ a = 0 := by
  refine ⟨fun hf a ha ↦ LinearMap.ext fun b ↦ ?_, mem_center_of_forall_mem_support hΛ⟩
  have hcomm := congrArg (coeff (a + b)) (Subalgebra.mem_center_iff.1 hf (monomial b))
  rw [coeff_add_mul_monomial, add_comm, coeff_add_monomial_mul, mul_comm] at hcomm
  have hunit : u ^ Λ b a = u ^ Λ a b :=
    Units.ext (mul_left_cancel₀ (mem_support_iff.1 ha) hcomm)
  rw [← hΛ.neg] at hunit
  rw [LinearMap.zero_apply]
  by_contra hne
  refine hu (isOfFinOrder_iff_zpow_eq_one.2 ⟨Λ a b, hne, ?_⟩)
  rw [sq, mul_zpow]
  nth_rw 1 [← hunit]
  rw [← zpow_add, neg_add_cancel, zpow_zero]

/-! ### The image of `centralHom` -/

variable {I : Type*} {e : I → L}

/-- The image of `centralHom e` consists of the elements supported on the span of `e`. -/
theorem mem_range_centralHom_iff (hc : ∀ i, Λ (e i) = 0) {f : quantumTorus R u Λ} :
    f ∈ (centralHom e hc).range ↔ ∀ a ∈ support f, a ∈ latticeSpan e := by
  classical
  constructor
  · intro hf
    obtain ⟨r, rfl⟩ := (AlgHom.mem_range _).1 hf
    clear hf
    induction r using AddMonoidAlgebra.induction_linear with
    | zero => simp [support]
    | add x y hx hy =>
      intro a ha
      rw [map_add] at ha
      rcases Finset.mem_union.1 (support_add_subset _ _ ha) with ha | ha
      · exact hx a ha
      · exact hy a ha
    | single n r =>
      intro a ha
      rw [centralHom_single, mem_support_iff, map_smul] at ha
      by_cases h : Finsupp.linearCombination ℤ e n = a
      · exact h ▸ linearCombination_mem_latticeSpan n
      · exact absurd (by rw [coeff_monomial_of_ne h, smul_zero]) ha
  · intro h
    rw [← sum_coeff_smul_monomial f]
    refine Subalgebra.sum_mem _ fun a ha ↦ Subalgebra.smul_mem _ ?_ _
    obtain ⟨n, hn⟩ := LinearMap.mem_range.1 (Submodule.mem_toAddSubgroup _ |>.1 (h a ha))
    exact (AlgHom.mem_range _).2
      ⟨AddMonoidAlgebra.single n 1, by rw [centralHom_single, hn, one_smul]⟩

/-- **The center as the image of `R[rad Λ]`.** Over a domain, when no nonzero power of `u²` is
`1`, the center of `T(R,u,Λ)` is the image of `centralHom e` for any `e` spanning `rad Λ`. -/
theorem center_eq_range_centralHom [IsDomain R] (hΛ : LinearMap.IsAlt Λ)
    (hu : ¬IsOfFinOrder (u ^ 2)) (hc : ∀ i, Λ (e i) = 0) (hspan : latticeSpan e =
      (LinearMap.ker Λ).toAddSubgroup) :
    Subalgebra.center R (quantumTorus R u Λ) = (centralHom e hc).range := by
  ext f
  rw [mem_center_iff hΛ hu, mem_range_centralHom_iff, hspan]
  simp only [Submodule.mem_toAddSubgroup, LinearMap.mem_ker]

/-- The inclusion of a subgroup spans it. -/
theorem latticeSpan_subtype (H : AddSubgroup L) : latticeSpan (Subtype.val : H → L) = H := by
  ext a
  rw [latticeSpan, Submodule.mem_toAddSubgroup, Finsupp.range_linearCombination,
    Subtype.range_coe_subtype]
  change a ∈ Submodule.span ℤ (H.toIntSubmodule : Set L) ↔ a ∈ H.toIntSubmodule
  rw [Submodule.span_eq]

/-- The center is the image of `centralHom` for the inclusion of `rad Λ`. -/
theorem center_eq_range_centralHom_ker [IsDomain R] (hΛ : LinearMap.IsAlt Λ)
    (hu : ¬IsOfFinOrder (u ^ 2)) :
    Subalgebra.center R (quantumTorus R u Λ) =
      (centralHom (Subtype.val : (LinearMap.ker Λ).toAddSubgroup → L) fun i ↦
        LinearMap.mem_ker.1 ((Submodule.mem_toAddSubgroup _).1 i.2)).range :=
  center_eq_range_centralHom hΛ hu _ (latticeSpan_subtype (LinearMap.ker Λ).toAddSubgroup)

/-- A subgroup of a finitely generated torsion-free abelian group is spanned by a linearly
independent finite family. -/
theorem exists_linearIndependent_latticeSpan_eq [Module.Finite ℤ L] [IsAddTorsionFree L]
    (H : AddSubgroup L) :
    ∃ (n : ℕ) (e : Fin n → L), LinearIndependent ℤ e ∧ latticeSpan e = H := by
  obtain ⟨n, b⟩ := Module.basisOfFiniteTypeTorsionFree' (R := ℤ) (M := H.toIntSubmodule)
  refine ⟨n, fun i ↦ (b i : L), b.linearIndependent.map' _ (Submodule.ker_subtype _), ?_⟩
  ext a
  rw [latticeSpan, Submodule.mem_toAddSubgroup, Finsupp.range_linearCombination]
  have : Set.range (fun i ↦ (b i : L)) = H.toIntSubmodule.subtype '' Set.range b := by
    rw [← Set.range_comp]
    rfl
  rw [this, Submodule.span_image, b.span_eq, Submodule.map_top, Submodule.range_subtype]
  rfl

/-- **The center is a Laurent ring.** For `e` linearly independent and spanning `rad Λ`, over a
domain and when no nonzero power of `u²` is `1`, `centralHom e` identifies `R[ℤ ^ I]` with the
center of `T(R,u,Λ)`. -/
noncomputable def centerEquiv [IsDomain R] (hΛ : LinearMap.IsAlt Λ) (hu : ¬IsOfFinOrder (u ^ 2))
    (he : LinearIndependent ℤ e) (hc : ∀ i, Λ (e i) = 0) (hspan : latticeSpan e =
      (LinearMap.ker Λ).toAddSubgroup) :
    AddMonoidAlgebra R (I →₀ ℤ) ≃ₐ[R] Subalgebra.center R (quantumTorus R u Λ) :=
  (AlgEquiv.ofInjective _ (centralHom_injective he hc)).trans
    (Subalgebra.equivOfEq _ _ (center_eq_range_centralHom hΛ hu hc hspan).symm)

@[simp] theorem coe_centerEquiv_apply [IsDomain R] (hΛ : LinearMap.IsAlt Λ)
    (hu : ¬IsOfFinOrder (u ^ 2)) (he : LinearIndependent ℤ e) (hc : ∀ i, Λ (e i) = 0)
    (hspan : latticeSpan e = (LinearMap.ker Λ).toAddSubgroup) (r : AddMonoidAlgebra R (I →₀ ℤ)) :
    (centerEquiv hΛ hu he hc hspan r : quantumTorus R u Λ) = centralHom e hc r :=
  rfl

end TauCeti.QuantumTorus

namespace TauCeti.Laurent

/-- The group ring of a finitely generated torsion-free abelian group over a factorial domain is
factorial. -/
theorem groupRing_uniqueFactorizationMonoid (R G : Type*) [CommRing R]
    [UniqueFactorizationMonoid R] [AddCommGroup G] [Module.Finite ℤ G] [IsAddTorsionFree G] :
    UniqueFactorizationMonoid (AddMonoidAlgebra R G) := by
  obtain ⟨n, b⟩ := Module.basisOfFiniteTypeTorsionFree' (R := ℤ) (M := G)
  have := latticeRing_uniqueFactorizationMonoid R (Fin n)
  exact (AddMonoidAlgebra.mapDomainRingEquiv R b.repr.toAddEquiv).symm.toMulEquiv
    |>.uniqueFactorizationMonoid inferInstance

end TauCeti.Laurent

namespace TauCeti.QuantumTorus

/-- **`Zv[N]` is factorial** for every subgroup `N` of a finitely generated torsion-free abelian
group, in particular for every sublattice. -/
theorem uniqueFactorizationMonoid_Zv_sublattice {L : Type*} [AddCommGroup L] [Module.Finite ℤ L]
    [IsAddTorsionFree L] (N : AddSubgroup L) : UniqueFactorizationMonoid (AddMonoidAlgebra Zv N) :=
  have : Module.Finite ℤ N := inferInstanceAs (Module.Finite ℤ N.toIntSubmodule)
  have := uniqueFactorizationMonoid_Zv
  Laurent.groupRing_uniqueFactorizationMonoid Zv N

end TauCeti.QuantumTorus
