/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.Quantum.Torus
public import Mathlib.LinearAlgebra.SesquilinearForm.Basic
public import Mathlib.LinearAlgebra.BilinearForm.Hom

/-!
# Monomials and coefficients in a based quantum torus

For an alternating form `Λ`, the monomials `X ^ a` of `T(R,u,Λ)` are units with
`(X ^ a)⁻¹ = X^{-a}`, satisfy `X^{n a} = (X ^ a) ^ n` for `n : ℤ`, and quasi-commute:
`X ^ a X ^ b = u^{2Λ(a,b)} X ^ b X ^ a`. Every element has finitely many nonzero
coefficients `coeff a f` in the monomial basis and is the sum of its terms.
Given a coordinate `φ : L →+ ℤ` and `e` with `φ e = 1`, every element is a finite
sum `∑ n, c_n X^{n e}` with left coefficients in the span of the monomials of
`φ`-coordinate zero; for `L = M → ℤ` this is the expansion in one variable `X_k`.
-/

@[expose] public section

namespace TauCeti.QuantumTorus

open TauCeti TauCeti.TwistedMonoidAlgebra

variable {R : Type*} [CommRing R] {L : Type*} [AddCommGroup L]
  {u : Rˣ} {Λ : LinearMap.BilinForm ℤ L}

/-! ### Units and powers -/

theorem monomial_mul_monomial_neg (hΛ : LinearMap.IsAlt Λ) (a : L) :
    (monomial a : quantumTorus R u Λ) * monomial (-a) = 1 := by
  simp [monomial_mul_monomial, hΛ.self_eq_zero a]

theorem monomial_neg_mul_monomial (hΛ : LinearMap.IsAlt Λ) (a : L) :
    (monomial (-a) : quantumTorus R u Λ) * monomial a = 1 := by
  simp [monomial_mul_monomial, hΛ.self_eq_zero a]

/-- For alternating `Λ`, the monomial `X ^ a` is a unit with inverse `X^{-a}`. -/
noncomputable def monomialUnit (hΛ : LinearMap.IsAlt Λ) (a : L) : (quantumTorus R u Λ)ˣ where
  val := monomial a
  inv := monomial (-a)
  val_inv := monomial_mul_monomial_neg hΛ a
  inv_val := monomial_neg_mul_monomial hΛ a

@[simp] theorem val_monomialUnit (hΛ : LinearMap.IsAlt Λ) (a : L) :
    ((monomialUnit hΛ a : (quantumTorus R u Λ)ˣ) : quantumTorus R u Λ) = monomial a := rfl

@[simp] theorem val_inv_monomialUnit (hΛ : LinearMap.IsAlt Λ) (a : L) :
    (((monomialUnit hΛ a)⁻¹ : (quantumTorus R u Λ)ˣ) : quantumTorus R u Λ) = monomial (-a) :=
  rfl

theorem monomialUnit_neg (hΛ : LinearMap.IsAlt Λ) (a : L) :
    (monomialUnit hΛ (-a) : (quantumTorus R u Λ)ˣ) = (monomialUnit hΛ a)⁻¹ :=
  Units.ext rfl

theorem isUnit_monomial (hΛ : LinearMap.IsAlt Λ) (a : L) :
    IsUnit (monomial a : quantumTorus R u Λ) :=
  (monomialUnit hΛ a).isUnit

theorem monomial_nsmul (hΛ : LinearMap.IsAlt Λ) (a : L) (n : ℕ) :
    (monomial (n • a) : quantumTorus R u Λ) = monomial a ^ n := by
  induction n with
  | zero => simp
  | succ n ih =>
    rw [pow_succ, ← ih, monomial_mul_monomial, succ_nsmul]
    simp [hΛ.self_eq_zero a]

theorem monomialUnit_zsmul (hΛ : LinearMap.IsAlt Λ) (a : L) (n : ℤ) :
    (monomialUnit hΛ (n • a) : (quantumTorus R u Λ)ˣ) = monomialUnit hΛ a ^ n := by
  cases n with
  | ofNat n =>
    exact Units.ext (by simpa using monomial_nsmul hΛ a n)
  | negSucc n =>
    rw [negSucc_zsmul, monomialUnit_neg, zpow_negSucc]
    congr 1
    exact Units.ext (by simpa using monomial_nsmul hΛ a (n + 1))

theorem monomial_zsmul (hΛ : LinearMap.IsAlt Λ) (a : L) (n : ℤ) :
    (monomial (n • a) : quantumTorus R u Λ) =
      ((monomialUnit hΛ a ^ n : (quantumTorus R u Λ)ˣ) : quantumTorus R u Λ) := by
  rw [← monomialUnit_zsmul hΛ a n, val_monomialUnit]

/-! ### Quasi-commutation and scalars -/

/-- **Quasi-commutation** `X ^ a X ^ b = u^{2Λ(a,b)} X ^ b X ^ a`. -/
theorem monomial_mul_monomial_comm (hΛ : LinearMap.IsAlt Λ) (a b : L) :
    (monomial a : quantumTorus R u Λ) * monomial b =
      ((u ^ (2 * Λ a b) : Rˣ) : R) • (monomial b * monomial a) := by
  rw [monomial_mul_monomial, monomial_mul_monomial, smul_smul, ← Units.val_mul, ← zpow_add,
    ← hΛ.neg, add_comm b a]
  congr 3
  ring

theorem algebraMap_mul_eq_smul (c : R) (f : quantumTorus R u Λ) :
    algebraMap R (quantumTorus R u Λ) c * f = c • f :=
  (Algebra.smul_def c f).symm
theorem algebraMap_mul_monomial (c : R) (a : L) :
    algebraMap R (quantumTorus R u Λ) c * monomial a = c • monomial a :=
  algebraMap_mul_eq_smul c _

/-- Scalars are central. -/
theorem commute_algebraMap (c : R) (f : quantumTorus R u Λ) :
    Commute (algebraMap R (quantumTorus R u Λ) c) f :=
  Algebra.commutes c f


/-! ### Coefficients and support -/

/-- The coefficient of `X ^ a`, read off from the monomial basis. -/
noncomputable def coeff (a : L) : quantumTorus R u Λ →ₗ[R] R :=
  Finsupp.lapply a ∘ₗ (monomialBasis : Module.Basis L R (quantumTorus R u Λ)).repr.toLinearMap

theorem coeff_apply (a : L) (f : quantumTorus R u Λ) :
    coeff a f = (monomialBasis : Module.Basis L R (quantumTorus R u Λ)).repr f a := rfl

/-- The finite set of exponents with nonzero coefficient. -/
noncomputable def support (f : quantumTorus R u Λ) : Finset L :=
  ((monomialBasis : Module.Basis L R (quantumTorus R u Λ)).repr f).support

theorem mem_support_iff {f : quantumTorus R u Λ} {a : L} : a ∈ support f ↔ coeff a f ≠ 0 :=
  Finsupp.mem_support_iff

theorem coeff_eq_zero_of_notMem_support {f : quantumTorus R u Λ} {a : L}
    (h : a ∉ support f) : coeff a f = 0 := by
  simpa [mem_support_iff] using h

theorem coeff_monomial (a b : L) :
    coeff a (monomial b : quantumTorus R u Λ) = (Finsupp.single b 1 : L →₀ R) a := by
  rw [coeff_apply, ← monomialBasis_apply, Module.Basis.repr_self]

@[simp] theorem coeff_monomial_self (a : L) :
    coeff a (monomial a : quantumTorus R u Λ) = 1 := by
  simp [coeff_monomial]

theorem coeff_monomial_of_ne {a b : L} (h : b ≠ a) :
    coeff a (monomial b : quantumTorus R u Λ) = 0 := by
  simp [coeff_monomial, h]

/-- Every element is the sum of its terms. -/
theorem sum_coeff_smul_monomial (f : quantumTorus R u Λ) :
    ∑ a ∈ support f, coeff a f • monomial a = f := by
  conv_rhs =>
    rw [← (monomialBasis : Module.Basis L R (quantumTorus R u Λ)).linearCombination_repr f]
  simp [Finsupp.linearCombination_apply, Finsupp.sum, support, coeff_apply]

theorem ext_coeff {f g : quantumTorus R u Λ} (h : ∀ a, coeff a f = coeff a g) : f = g :=
  (monomialBasis : Module.Basis L R (quantumTorus R u Λ)).repr.injective
    (Finsupp.ext fun a ↦ h a)

/-! ### Expansion in one variable -/

/-- Expansion along a coordinate `φ` with `φ e = 1`: every element is a finite sum
`∑ n, c_n * X^{n e}` with each left coefficient `c_n` in the span of the monomials of
`φ`-coordinate zero. -/
theorem exists_sum_mul_monomial_zsmul (φ : L →+ ℤ) {e : L} (he : φ e = 1)
    (f : quantumTorus R u Λ) :
    ∃ (s : Finset ℤ) (c : ℤ → quantumTorus R u Λ),
      (∀ n, c n ∈ Submodule.span R (monomial '' {a : L | φ a = 0})) ∧
      f = ∑ n ∈ s, c n * monomial (n • e) := by
  classical
  let t : L → ℤ → quantumTorus R u Λ := fun a n ↦
    (coeff a f * ((u ^ (-Λ (a - n • e) (n • e)) : Rˣ) : R)) • monomial (a - n • e)
  refine ⟨(support f).image φ, fun n ↦ ∑ a ∈ support f with φ a = n, t a n, ?_, ?_⟩
  · intro n
    refine Submodule.sum_mem _ fun a ha ↦ Submodule.smul_mem _ _ (Submodule.subset_span ?_)
    refine ⟨a - n • e, ?_, rfl⟩
    simp [(Finset.mem_filter.1 ha).2, he]
  · have hterm (a : L) : t a (φ a) * monomial (φ a • e) = coeff a f • monomial a := by
      simp only [t, smul_mul_assoc, monomial_mul_monomial, smul_smul, mul_assoc,
        ← Units.val_mul, ← zpow_add, neg_add_cancel, zpow_zero, Units.val_one, mul_one,
        sub_add_cancel]
    simp_rw [Finset.sum_mul]
    calc f = ∑ a ∈ support f, coeff a f • monomial a := (sum_coeff_smul_monomial f).symm
      _ = ∑ n ∈ (support f).image φ, ∑ a ∈ support f with φ a = n, coeff a f • monomial a :=
        (Finset.sum_fiberwise_of_maps_to (fun a ha ↦ Finset.mem_image_of_mem φ ha) _).symm
      _ = _ := by
        refine Finset.sum_congr rfl fun n _ ↦ Finset.sum_congr rfl fun a ha ↦ ?_
        rw [← (Finset.mem_filter.1 ha).2, hterm]

/-- Expansion in the variable `X_k` of `L = M → ℤ`: every element is a finite sum
`∑ n, c_n * X_k ^ n` with each `c_n` in the span of the monomials whose `k`-th coordinate
vanishes. -/
theorem exists_sum_mul_monomial_single {M : Type*} [DecidableEq M]
    {Λ : LinearMap.BilinForm ℤ (M → ℤ)} (k : M) (f : quantumTorus R u Λ) :
    ∃ (s : Finset ℤ) (c : ℤ → quantumTorus R u Λ),
      (∀ n, c n ∈ Submodule.span R (monomial '' {a : M → ℤ | a k = 0})) ∧
      f = ∑ n ∈ s, c n * monomial (n • Pi.single k 1) :=
  exists_sum_mul_monomial_zsmul (Pi.evalAddMonoidHom (fun _ ↦ ℤ) k) (by simp) f

end TauCeti.QuantumTorus
