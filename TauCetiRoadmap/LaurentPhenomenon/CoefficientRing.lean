/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.LaurentEvaluation

/-!
# Separating coefficient and mutable exponents

The product group ring used by the universal proof and Laurent polynomials over
the coefficient group ring are two presentations of the same ring. Use this
equivalence to transport results, rather than introducing a second Laurent object.
-/

@[expose] public section
noncomputable section
namespace TauCeti.Laurent.LaurentEvaluation
variable {R G I : Type*} [CommRing R] [AddCommGroup G]

/-- Regroup coefficient-group and mutable exponents as a Laurent ring over the coefficient group
ring.
-/
def coefficientRingEquiv :
    AddMonoidAlgebra R (G × (I →₀ ℤ)) ≃+* Ring (AddMonoidAlgebra R G) I :=
  (AddMonoidAlgebra.mapDomainRingEquiv R (AddEquiv.prodComm : G × (I →₀ ℤ) ≃+ (I →₀ ℤ) × G)).trans
    AddMonoidAlgebra.curryRingEquiv

@[simp] theorem coefficientRingEquiv_single (g : G) (a : I →₀ ℤ) (r : R) :
    coefficientRingEquiv (AddMonoidAlgebra.single (g, a) r) =
      AddMonoidAlgebra.single a (AddMonoidAlgebra.single g r) := by
  simp [coefficientRingEquiv]

@[simp] theorem coefficientRingEquiv_symm_single (g : G) (a : I →₀ ℤ) (r : R) :
    coefficientRingEquiv.symm
        (AddMonoidAlgebra.single a (AddMonoidAlgebra.single g r)) =
      AddMonoidAlgebra.single (g, a) r := by
  apply coefficientRingEquiv.injective
  simp

theorem eval_coefficientRingEquiv_single {S : Type*} [CommRing S]
    (c : AddMonoidAlgebra R G →+* S) (x : I → Sˣ)
    (g : G) (a : I →₀ ℤ) (r : R) :
    eval c x (coefficientRingEquiv (AddMonoidAlgebra.single (g, a) r)) =
      c (AddMonoidAlgebra.single g r) * ((exponentCharacter x a).toMul : S) := by
  simp

end TauCeti.Laurent.LaurentEvaluation
