/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.Quantum.Coefficients
public import Mathlib.LinearAlgebra.FreeModule.Finite.Basic

/-!
# Quantum tori on a lattice with a basis

* A free `ℤ`-module has unique sums (it embeds into `ι →₀ ℤ`), so a quantum torus over a domain
  on a free lattice is a domain (`Quantum/Domain.lean`).
* `TauCeti.QuantumTorus.congrEquiv`: for a form `Λ` carried along `e : L ≃ₗ[ℤ] L'` by
  `LinearMap.BilinForm.congr`, the lattice reindexing `T(R,u,Λ) ≃ₐ[R] T(R,u,e_ * Λ)`.
* For a basis `b : Module.Basis ι ℤ L` of a lattice, `Λ_b = LinearMap.BilinForm.congr b.equivFun Λ`
  is `Λ` in the coordinates of `b`, `Λ_b(e_i,e_j) = Λ(b_i,b_j)`, and
  `basisTorusEquiv b : T(R,u,Λ) ≃ₐ[R] T(R,u,Λ_b)` sends `X ^ a` to `X^{(a_i)_i}` where
  `a = Σ a_i b_i`. Statements about `T(R,u,Λ)` on a finite free
  lattice are reduced through it to the coordinate lattice `ι → ℤ`.
-/

@[expose] public section

/-- **A free `ℤ`-module has unique sums**: a basis embeds it into `ι →₀ ℤ`. -/
instance (priority := 100) TauCeti.instTwoUniqueSumsOfFree {L : Type*} [AddCommGroup L]
    [Module.Free ℤ L] : TwoUniqueSums L :=
  TwoUniqueSums.of_injective_addHom (Module.Free.chooseBasis ℤ L).repr.toAddMonoidHom.toAddHom
    (Module.Free.chooseBasis ℤ L).repr.injective inferInstance

namespace TauCeti.QuantumTorus

open TauCeti

variable {R : Type*} [CommRing R] {u : Rˣ} {L : Type*} [AddCommGroup L] {L' : Type*}
  [AddCommGroup L'] {Λ : LinearMap.BilinForm ℤ L}

/-! ### Transport of forms -/

theorem isAlt_congr (hΛ : LinearMap.IsAlt Λ) (e : L ≃ₗ[ℤ] L') :
    LinearMap.IsAlt (LinearMap.BilinForm.congr e Λ) :=
  fun a ↦ (LinearMap.BilinForm.congr_apply e Λ a a).trans (hΛ.self_eq_zero _)

variable (R u Λ) in
/-- Lattice reindexing along `e`: the isomorphism `T(R,u,Λ) ≃ₐ[R] T(R,u,e_ * Λ)`, `X ^ a ↦ X^{e a}`,
where `e_ * Λ = LinearMap.BilinForm.congr e Λ`. -/
noncomputable def congrEquiv (e : L ≃ₗ[ℤ] L') :
    quantumTorus R u Λ ≃ₐ[R] quantumTorus R u (LinearMap.BilinForm.congr e Λ) :=
  domCongr e.toAddEquiv fun a b ↦ by simp

@[simp] theorem congrEquiv_monomial (e : L ≃ₗ[ℤ] L') (a : L) :
    congrEquiv R u Λ e (monomial a) = monomial (e a) :=
  domCongr_monomial _ _ a

@[simp] theorem congrEquiv_symm_monomial (e : L ≃ₗ[ℤ] L') (a : L') :
    (congrEquiv R u Λ e).symm (monomial a) = monomial (e.symm a) := by
  rw [AlgEquiv.symm_apply_eq, congrEquiv_monomial, e.apply_symm_apply]

/-! ### Coordinates of a basis -/

section Basis

variable {ι : Type*} [Finite ι] (b : Module.Basis ι ℤ L)

theorem equivFun_symm_single [DecidableEq ι] (i : ι) : b.equivFun.symm (Pi.single i 1) = b i := by
  rw [LinearEquiv.symm_apply_eq]
  funext j
  rw [Module.Basis.equivFun_self, Pi.single_apply]
  simp only [eq_comm]

theorem equivFun_self_eq_single [DecidableEq ι] (i : ι) : b.equivFun (b i) = Pi.single i 1 := by
  rw [← equivFun_symm_single b i, LinearEquiv.apply_symm_apply]

/-- The form in the coordinates of `b`: `Λ_b(e_i,e_j) = Λ(b_i,b_j)`. -/
theorem congr_equivFun_single_single [DecidableEq ι] (i j : ι) :
    LinearMap.BilinForm.congr b.equivFun Λ (Pi.single i 1) (Pi.single j 1) = Λ (b i) (b j) := by
  rw [LinearMap.BilinForm.congr_apply, equivFun_symm_single, equivFun_symm_single]

variable (R u Λ) in
/-- **The coordinates of a basis**: `T(R,u,Λ) ≃ₐ[R] T(R,u,Λ_b)`, `X ^ a ↦ X^{b.equivFun a}`, where
`Λ_b = LinearMap.BilinForm.congr b.equivFun Λ` is `Λ` in the coordinates of `b`. -/
noncomputable def basisTorusEquiv :
    quantumTorus R u Λ ≃ₐ[R] quantumTorus R u (LinearMap.BilinForm.congr b.equivFun Λ) :=
  congrEquiv R u Λ b.equivFun

@[simp] theorem basisTorusEquiv_monomial (a : L) :
    basisTorusEquiv R u Λ b (monomial a) = monomial (b.equivFun a) :=
  congrEquiv_monomial _ a

theorem basisTorusEquiv_monomial_basis [DecidableEq ι] (i : ι) :
    basisTorusEquiv R u Λ b (monomial (b i)) = monomial (Pi.single i 1) := by
  rw [basisTorusEquiv_monomial, equivFun_self_eq_single]

@[simp] theorem basisTorusEquiv_symm_monomial (a : ι → ℤ) :
    (basisTorusEquiv R u Λ b).symm (monomial a) = monomial (b.equivFun.symm a) :=
  congrEquiv_symm_monomial _ a

theorem coeff_basisTorusEquiv (f : quantumTorus R u Λ) (a : L) :
    coeff (b.equivFun a) (basisTorusEquiv R u Λ b f) = coeff a f :=
  coeff_domCongr b.equivFun.toAddEquiv _ f a

theorem coeff_basisTorusEquiv_symm
    (f : quantumTorus R u (LinearMap.BilinForm.congr b.equivFun Λ)) (a : ι → ℤ) :
    coeff (b.equivFun.symm a) ((basisTorusEquiv R u Λ b).symm f) = coeff a f := by
  rw [← coeff_basisTorusEquiv b, AlgEquiv.apply_symm_apply, LinearEquiv.apply_symm_apply]

end Basis

end TauCeti.QuantumTorus
