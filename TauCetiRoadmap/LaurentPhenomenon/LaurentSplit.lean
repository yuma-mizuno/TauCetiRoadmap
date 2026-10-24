/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import Mathlib.Algebra.MonoidAlgebra.MapDomain
public import Mathlib.Algebra.Polynomial.Laurent
public import Mathlib.Data.Finsupp.Option
public import Mathlib.Logic.Equiv.Option
public import Mathlib.Algebra.FreeAbelianGroup.Finsupp

/-! # Laurent Split -/

@[expose] public section

namespace TauCeti.Laurent
noncomputable section

/-- Separate the exponent of one coordinate from all other finitely supported exponents. -/
def splitExponents {I : Type*} [DecidableEq I] (k : I) :
    (I →₀ ℤ) ≃+ ℤ × ({i // i ≠ k} →₀ ℤ) :=
  (Finsupp.domCongr (Equiv.optionSubtypeNe k).symm).trans
    { toEquiv := Finsupp.optionEquiv
      map_add' := by
        intro a b
        apply Prod.ext
        · rfl
        · ext i
          rfl }

@[simp] theorem splitExponents_fst {I : Type*} [DecidableEq I] (k : I) (m : I →₀ ℤ) :
    (splitExponents k m).1 = m k := by simp [splitExponents, Finsupp.domCongr]

@[simp] theorem splitExponents_snd_apply {I : Type*} [DecidableEq I] (k : I) (m : I →₀ ℤ)
    (i : {i // i ≠ k}) : (splitExponents k m).2 i = m i := by
  simp [splitExponents, Finsupp.domCongr]

/-- Separate one mutable exponent while retaining arbitrary coefficient-group exponents. -/
def splitGroupExponents {G I : Type*} [AddCommGroup G] [DecidableEq I] (k : I) :
    (G × (I →₀ ℤ)) ≃+ ℤ × (G × ({i // i ≠ k} →₀ ℤ)) where
  toFun p := ((splitExponents k p.2).1, (p.1, (splitExponents k p.2).2))
  invFun p := (p.2.1, (splitExponents k).symm (p.1, p.2.2))
  left_inv p := by
    change (p.1, (splitExponents k).symm (splitExponents k p.2)) = p
    simp only [AddEquiv.symm_apply_apply]
  right_inv p := by simp
  map_add' p q := by simp

open scoped LaurentPolynomial

/-- A chosen coordinate of a multivariate group algebra becomes the Laurent variable. -/
def laurentSplit {R G I : Type*} [CommRing R] [AddCommGroup G] [DecidableEq I] (k : I) :
    AddMonoidAlgebra R (G × (I →₀ ℤ)) ≃+*
      (AddMonoidAlgebra R (G × ({i // i ≠ k} →₀ ℤ)))[T;T⁻¹] :=
  (AddMonoidAlgebra.mapDomainRingEquiv R (splitGroupExponents (G := G) k)).trans
    AddMonoidAlgebra.curryRingEquiv

@[simp] theorem laurentSplit_single {R G I : Type*} [CommRing R] [AddCommGroup G]
    [DecidableEq I] (k : I) (g : G) (m : I →₀ ℤ) (r : R) :
    laurentSplit k (AddMonoidAlgebra.single (g, m) r) =
      AddMonoidAlgebra.single (m k)
        (AddMonoidAlgebra.single (g, (splitExponents k m).2) r) := by
  simp [laurentSplit, splitGroupExponents]

@[simp] theorem splitExponents_chosen {I : Type*} [DecidableEq I] (k : I) (n : ℤ) :
    splitExponents k (Finsupp.single k n) = (n, 0) := by
  apply Prod.ext
  · simp
  · ext i
    simp [i.property]

/-- The chosen mutable monomial becomes exactly T to the same exponent. -/
theorem laurentSplit_chosen {R G I : Type*} [CommRing R] [AddCommGroup G]
    [DecidableEq I] (k : I) (n : ℤ) :
    laurentSplit (R := R) (G := G) k
      (AddMonoidAlgebra.single (0, Finsupp.single k n) 1) = LaurentPolynomial.T n := by
  rw [laurentSplit_single, splitExponents_chosen]
  change AddMonoidAlgebra.single ((Finsupp.single k n) k)
    (AddMonoidAlgebra.single (0, 0) 1) = AddMonoidAlgebra.single n 1
  rw [Finsupp.single_eq_same]
  rfl

/-- Monomials with zero chosen exponent become constants in the Laurent variable. -/
theorem laurentSplit_constant {R G I : Type*} [CommRing R] [AddCommGroup G]
    [DecidableEq I] (k : I) (g : G) (m : I →₀ ℤ) (r : R) (hm : m k = 0) :
    laurentSplit k (AddMonoidAlgebra.single (g, m) r) =
      LaurentPolynomial.C (AddMonoidAlgebra.single (g, (splitExponents k m).2) r) := by
  rw [laurentSplit_single, hm]
  rfl

/-- The original coefficient group is contained in the coefficient Laurent ring. -/
theorem laurentSplit_coefficient {R G I : Type*} [CommRing R] [AddCommGroup G]
    [DecidableEq I] (k : I) (g : G) (r : R) :
    laurentSplit k (AddMonoidAlgebra.single (g, 0) r) =
      LaurentPolynomial.C (AddMonoidAlgebra.single (g, 0) r) := by
  simpa only [map_zero, Prod.snd_zero] using laurentSplit_constant k g 0 r rfl

/-- Put one free coefficient atom in the Laurent variable, keeping all mutable exponents
and every other atom in its coefficient ring. -/
def atomLaurentSplit {R A M : Type*} [CommRing R] [AddCommGroup M] [DecidableEq A] (k : A) :
    AddMonoidAlgebra R (FreeAbelianGroup A × M) ≃+*
      (AddMonoidAlgebra R (M × ({a // a ≠ k} →₀ ℤ)))[T;T⁻¹] :=
  (AddMonoidAlgebra.mapDomainRingEquiv R
    ((AddEquiv.prodComm : FreeAbelianGroup A × M ≃+ M × FreeAbelianGroup A).trans
      (AddEquiv.prodCongr (AddEquiv.refl M) (FreeAbelianGroup.equivFinsupp A)))).trans
    (laurentSplit k)

@[simp] theorem atomLaurentSplit_single {R A M : Type*} [CommRing R] [AddCommGroup M]
    [DecidableEq A] (k : A) (a : FreeAbelianGroup A) (m : M) (r : R) :
    atomLaurentSplit k (AddMonoidAlgebra.single (a, m) r) =
      AddMonoidAlgebra.single (a.toFinsupp k)
        (AddMonoidAlgebra.single (m, (splitExponents k a.toFinsupp).2) r) := by
  unfold atomLaurentSplit
  rw [RingEquiv.trans_apply, AddMonoidAlgebra.mapDomainRingEquiv_single]
  change laurentSplit k (AddMonoidAlgebra.single (m, a.toFinsupp) r) = _
  exact laurentSplit_single k m a.toFinsupp r

/-- The selected fresh atom becomes T, with unit coefficient. -/
theorem atomLaurentSplit_chosen {R A M : Type*} [CommRing R] [AddCommGroup M]
    [DecidableEq A] (k : A) :
    atomLaurentSplit (R := R) (M := M) k
      (AddMonoidAlgebra.single (FreeAbelianGroup.of k, 0) 1) = LaurentPolynomial.T 1 := by
  rw [atomLaurentSplit_single]
  simp only [FreeAbelianGroup.toFinsupp_of, splitExponents_chosen, Finsupp.single_eq_same]
  rfl

/-- Every other atom is constant in the chosen fresh parameter. -/
theorem atomLaurentSplit_other {R A M : Type*} [CommRing R] [AddCommGroup M]
    [DecidableEq A] (k j : A) (hj : j ≠ k) (m : M) (r : R) :
    atomLaurentSplit k (AddMonoidAlgebra.single (FreeAbelianGroup.of j, m) r) =
      LaurentPolynomial.C
        (AddMonoidAlgebra.single (m, (splitExponents k (Finsupp.single j 1)).2) r) := by
  rw [atomLaurentSplit_single]
  simp only [FreeAbelianGroup.toFinsupp_of, Finsupp.single_eq_of_ne hj.symm]
  rfl

/-- Vanishing chosen-atom exponents identify the coefficient subring concretely. -/
theorem atomLaurentSplit_avoiding {R A M : Type*} [CommRing R] [AddCommGroup M]
    [DecidableEq A] (k : A) (q : AddMonoidAlgebra R (FreeAbelianGroup A × M))
    (hq : ∀ t ∈ q.coeff.support, t.1.toFinsupp k = 0) :
    ∃ b : AddMonoidAlgebra R (M × ({a // a ≠ k} →₀ ℤ)),
      atomLaurentSplit k q = LaurentPolynomial.C b := by
  classical
  refine ⟨q.coeff.sum (fun t r ↦
    AddMonoidAlgebra.single (t.2, (splitExponents k t.1.toFinsupp).2) r), ?_⟩
  conv_lhs => rw [← AddMonoidAlgebra.sum_coeff_single q]
  simp only [Finsupp.sum, map_sum]
  apply Finset.sum_congr rfl
  intro t ht
  rw [atomLaurentSplit_single, hq t ht]
  rfl

end
end TauCeti.Laurent
