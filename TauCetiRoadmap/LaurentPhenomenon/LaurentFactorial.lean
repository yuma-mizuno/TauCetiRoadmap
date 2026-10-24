/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.LaurentSplit
public import TauCetiRoadmap.LaurentPhenomenon.GroupRing
public import TauCetiRoadmap.LaurentPhenomenon.LaurentModel
public import Mathlib.Data.Fintype.Option

/-! # Laurent Factorial -/

@[expose] public section

namespace TauCeti.Laurent
noncomputable section
open scoped LaurentPolynomial

/-- Split an optional lattice generator into the Laurent variable. -/
def optionLatticeEquiv {A : Type*} : (Option A →₀ ℤ) ≃+ ℤ × (A →₀ ℤ) where
  toEquiv := Finsupp.optionEquiv
  map_add' a b := by
    apply Prod.ext
    · rfl
    · ext i
      rfl

/-- Separate the variable indexed by none as the single Laurent variable, retaining the
some-indexed coefficient ring.
-/
def optionLaurentEquiv {R A : Type*} [CommRing R] :
    AddMonoidAlgebra R (Option A →₀ ℤ) ≃+* (AddMonoidAlgebra R (A →₀ ℤ))[T;T⁻¹] :=
  (AddMonoidAlgebra.mapDomainRingEquiv R optionLatticeEquiv).trans AddMonoidAlgebra.curryRingEquiv

/-- Laurent polynomial rings preserve unique factorization. -/
theorem laurent_uniqueFactorizationMonoid {R : Type*} [CommRing R]
    [UniqueFactorizationMonoid R] : UniqueFactorizationMonoid R[T;T⁻¹] :=
  UniqueFactorizationMonoid.of_isLocalization (Submonoid.powers (Polynomial.X : Polynomial R)) _

/-- A finite-rank lattice group ring is a UFD, via repeated genuine Laurent extension. -/
theorem latticeRing_uniqueFactorizationMonoid (R A : Type*) [CommRing R]
    [UniqueFactorizationMonoid R] [Finite A] :
    UniqueFactorizationMonoid (AddMonoidAlgebra R (A →₀ ℤ)) := by
  induction A using Finite.induction_empty_option with
  | @of_equiv A B e ih =>
    exact (AddMonoidAlgebra.mapDomainRingEquiv R (Finsupp.domCongr
      e)).toMulEquiv.uniqueFactorizationMonoid ih
  | h_empty =>
    exact (AddMonoidAlgebra.uniqueRingEquiv (PEmpty →₀ ℤ)).symm.toMulEquiv.uniqueFactorizationMonoid
      inferInstance
  | @h_option A _ ih =>
    let := torsionFree_uniqueSums (A →₀ ℤ)
    let := ih
    let : UniqueFactorizationMonoid (AddMonoidAlgebra R (A →₀ ℤ))[T;T⁻¹] :=
      laurent_uniqueFactorizationMonoid
    exact optionLaurentEquiv.symm.toMulEquiv.uniqueFactorizationMonoid inferInstance

/-- Combine free coefficient atoms and mutable Laurent exponents into one free lattice. -/
def freeGroupLatticeEquiv (A I : Type*) :
    (FreeAbelianGroup A × (I →₀ ℤ)) ≃+ (A ⊕ I →₀ ℤ) :=
  (AddEquiv.prodCongr (FreeAbelianGroup.equivFinsupp A) (AddEquiv.refl _)).trans
    Finsupp.sumFinsuppAddEquivProdFinsupp.symm

/-- The generic coefficient-and-coordinate Laurent ring is factorial. -/
theorem freeGroupLatticeRing_uniqueFactorizationMonoid (R A I : Type*)
    [CommRing R] [UniqueFactorizationMonoid R] [Finite A] [Finite I] :
    UniqueFactorizationMonoid (AddMonoidAlgebra R (FreeAbelianGroup A × (I →₀ ℤ))) := by
  let := latticeRing_uniqueFactorizationMonoid R (A ⊕ I)
  exact (AddMonoidAlgebra.mapDomainRingEquiv R (freeGroupLatticeEquiv A
    I)).symm.toMulEquiv.uniqueFactorizationMonoid
    inferInstance

end
end TauCeti.Laurent
