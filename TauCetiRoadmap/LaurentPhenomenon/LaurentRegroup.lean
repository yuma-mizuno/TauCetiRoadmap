/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.LaurentEvaluation
public import Mathlib.Algebra.MonoidAlgebra.Basic

/-!
# Regrouping Laurent variables

For a commutative semiring `R` and types `K`, `J`, the Laurent ring `L(R, K ⊔ J)` in the variables
indexed by `K ⊕ J` is the Laurent ring in the `K`-variables over the Laurent ring in the
`J`-variables: `laurentRegroup : L(R, K ⊔ J) ≃ₐ[R] L(L(R, J), K)`, with
`X ^ a ↦ X^{a ∘ inl} · (X^{a ∘ inr})`. Evaluating a Laurent polynomial at units `x : K ⊕ J → Sˣ`
is evaluating its regrouping first at the `J`-units and then at the `K`-units
(`eval_laurentRegroup`).
-/

@[expose] public section

namespace TauCeti.Laurent

open AddMonoidAlgebra

noncomputable section

variable (R : Type*) [CommSemiring R] (K J : Type*)

/-- **The regrouping** `L(R, K ⊔ J) ≃ₐ[R] L(L(R, J), K)`: the `K`-exponents become the outer
exponents and the `J`-exponents those of the coefficients. -/
def laurentRegroup :
    AddMonoidAlgebra R (K ⊕ J →₀ ℤ) ≃ₐ[R] AddMonoidAlgebra (AddMonoidAlgebra R (J →₀ ℤ)) (K →₀ ℤ) :=
  (domCongr R R Finsupp.sumFinsuppAddEquivProdFinsupp).trans (curryAlgEquiv R)

variable {R K J}

@[simp] theorem laurentRegroup_single (a : K ⊕ J →₀ ℤ) (r : R) :
    laurentRegroup R K J (single a r) =
      single (Finsupp.sumFinsuppAddEquivProdFinsupp a).1
        (single (Finsupp.sumFinsuppAddEquivProdFinsupp a).2 r) := by
  simp [laurentRegroup]

@[simp] theorem laurentRegroup_symm_single (a : K →₀ ℤ) (b : J →₀ ℤ) (r : R) :
    (laurentRegroup R K J).symm (single a (single b r)) = single (a.sumElim b) r := by
  rw [AlgEquiv.symm_apply_eq, laurentRegroup_single]
  congr
  · ext k
    rfl
  · ext j
    rfl

/-- A `K`-variable is a variable of the outer ring. -/
theorem laurentRegroup_single_inl (k : K) (n : ℤ) (r : R) :
    laurentRegroup R K J (single (Finsupp.single (Sum.inl k) n) r) =
      single (Finsupp.single k n) (single 0 r) := by
  classical
  rw [laurentRegroup_single]
  congr
  · ext k'
    simp [Finsupp.single_apply]
  · ext j
    simp

/-- A `J`-variable is a variable of the coefficient ring. -/
theorem laurentRegroup_single_inr (j : J) (n : ℤ) (r : R) :
    laurentRegroup R K J (single (Finsupp.single (Sum.inr j) n) r) =
      single 0 (single (Finsupp.single j n) r) := by
  classical
  rw [laurentRegroup_single]
  congr
  · ext k
    simp
  · ext j'
    simp [Finsupp.single_apply]

end

namespace LaurentEvaluation

variable {R S K J : Type*} [CommRing R] [CommRing S]

theorem exponentCharacter_sumElim (x : K ⊕ J → Sˣ) (a : K →₀ ℤ) (b : J →₀ ℤ) :
    exponentCharacter x (a.sumElim b) =
      exponentCharacter (x ∘ Sum.inl) a + exponentCharacter (x ∘ Sum.inr) b := by
  have hab : a.sumElim b =
      Finsupp.embDomain Function.Embedding.inl a + Finsupp.embDomain Function.Embedding.inr b := by
    rw [Finsupp.embDomain_inl, Finsupp.embDomain_inr, ← Finsupp.sumElim_add, add_zero, zero_add]
  rw [hab, map_add]
  simp only [exponentCharacter, Finsupp.liftAddHom_apply]
  rw [Finsupp.sum, Finsupp.sum, Finsupp.support_embDomain, Finsupp.support_embDomain,
    Finset.sum_map, Finset.sum_map]
  simp [Finsupp.sum]

/-- **Evaluation after regrouping.** Evaluating `p ∈ L(R, K ⊔ J)` at `x` is evaluating its
regrouping at the `J`-units `x ∘ inr` on coefficients and then at the `K`-units `x ∘ inl`. -/
theorem eval_laurentRegroup (c : R →+* S) (x : K ⊕ J → Sˣ) (p : Ring R (K ⊕ J)) :
    eval (eval c (x ∘ Sum.inr)) (x ∘ Sum.inl) (laurentRegroup R K J p) = eval c x p := by
  induction p using AddMonoidAlgebra.induction_linear with
  | zero => simp
  | add p q hp hq => rw [map_add, map_add, hp, hq, map_add]
  | single a r =>
    obtain ⟨⟨a, b⟩, rfl⟩ := Finsupp.sumFinsuppAddEquivProdFinsupp.symm.surjective a
    rw [laurentRegroup_single, AddEquiv.apply_symm_apply, eval_single, eval_single, eval_single,
      Finsupp.sumFinsuppAddEquivProdFinsupp_symm_apply, exponentCharacter_sumElim, toMul_add,
      Units.val_mul]
    ac_rfl

theorem eval_laurentRegroup_symm (c : R →+* S) (x : K ⊕ J → Sˣ)
    (p : AddMonoidAlgebra (AddMonoidAlgebra R (J →₀ ℤ)) (K →₀ ℤ)) :
    eval c x ((laurentRegroup R K J).symm p) =
      eval (eval c (x ∘ Sum.inr)) (x ∘ Sum.inl) p := by
  rw [← eval_laurentRegroup, AlgEquiv.apply_symm_apply]

end LaurentEvaluation

end TauCeti.Laurent
