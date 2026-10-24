/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.PositiveSubstitution

/-!
# A finite universal deformation of a whole forward sequence of stars

The parameter set contains separate additive atoms for every initial direction
and every correction location. All later exchange polynomials are constructed
recursively, not lifted independently. Specialization and mutable support agree
at every stage of that recursion.
-/

@[expose] public section

namespace TauCeti.Laurent

noncomputable section

variable {G I : Type*} [AddCommGroup G] [DecidableEq I]

/-- Input locations for an initial exchange tuple and a finite list of correction tuples. -/
abbrev DeformationLocation (I : Type*) (N : ℕ) := I ⊕ (Fin N × I)

/-- Combine the initial exchange tuple and correction tuples into one labelled polynomial family. -/
def deformationInputs {N : ℕ} (E : I → PositiveLaurent G I)
    (H : Fin N → I → PositiveLaurent G I) :
    DeformationLocation I N → PositiveLaurent G I
  | .inl i => E i
  | .inr (p,i) => H p i

/-- The free abelian group on all coefficient occurrences of the deformation input family. -/
abbrev DeformationGroup {N : ℕ} (E : I → PositiveLaurent G I)
    (H : Fin N → I → PositiveLaurent G I) :=
  FreeAbelianGroup (FamilyAtom (deformationInputs E H))

/-- Specialize each free deformation atom to its original coefficient-group exponent. -/
def deformationMap {N : ℕ} (E : I → PositiveLaurent G I)
    (H : Fin N → I → PositiveLaurent G I) : DeformationGroup E H →+ G :=
  familyAtomCoefficientMap (deformationInputs E H)

/-- The initial exchange tuple with every coefficient occurrence replaced by its own free atom. -/
def deformedInitial {N : ℕ} (E : I → PositiveLaurent G I)
    (H : Fin N → I → PositiveLaurent G I) (i : I) :
    PositiveLaurent (DeformationGroup E H) I :=
  familyAtomLift (deformationInputs E H) (.inl i)

/-- Extend a finite list of correction tuples to natural indices by assigning zero outside its
range.
-/
def finiteCorrections {N : ℕ} (H : Fin N → I → PositiveLaurent G I)
    (n : ℕ) (i : I) : PositiveLaurent G I :=
  if h : n < N then H ⟨n,h⟩ i else 0

/-- The free-atom lifts of the finite correction tuples, extended by zero outside their range. -/
def deformedCorrections {N : ℕ} (E : I → PositiveLaurent G I)
    (H : Fin N → I → PositiveLaurent G I) (n : ℕ) (i : I) :
    PositiveLaurent (DeformationGroup E H) I :=
  if h : n < N then familyAtomLift (deformationInputs E H) (.inr (⟨n,h⟩,i)) else 0

/-- Propagate the deformed initial tuple using the deformed corrections and the prescribed labels.
-/
def deformedStar {N : ℕ} (E : I → PositiveLaurent G I)
    (H : Fin N → I → PositiveLaurent G I) (labels : ℕ → I) :
    ℕ → I → PositiveLaurent (DeformationGroup E H) I :=
  positiveStarIterate (deformedInitial E H) (deformedCorrections E H) labels

omit [DecidableEq I] in
@[simp] theorem deformedInitial_specializes {N : ℕ} (E : I → PositiveLaurent G I)
    (H : Fin N → I → PositiveLaurent G I) (i : I) :
    coefficientMap (deformationMap E H) (deformedInitial E H i) = E i :=
  familyAtomLift_specializes (deformationInputs E H) (.inl i)

omit [DecidableEq I] in
@[simp] theorem deformedCorrections_specializes {N : ℕ} (E : I → PositiveLaurent G I)
    (H : Fin N → I → PositiveLaurent G I) (n : ℕ) (i : I) :
    coefficientMap (deformationMap E H) (deformedCorrections E H n i) =
      finiteCorrections H n i := by
  unfold deformedCorrections finiteCorrections
  split
  · exact familyAtomLift_specializes (deformationInputs E H) (.inr (_,i))
  · exact map_zero _

/-- Every propagated polynomial specializes to the corresponding original one. -/
theorem deformedStar_specializes {N : ℕ} (E : I → PositiveLaurent G I)
    (H : Fin N → I → PositiveLaurent G I) (labels : ℕ → I) (n : ℕ) (i : I) :
    coefficientMap (deformationMap E H) (deformedStar E H labels n i) =
      positiveStarIterate E (finiteCorrections H) labels n i := by
  unfold deformedStar
  rw [positiveStarIterate_natural]
  simp only [deformedInitial_specializes, deformedCorrections_specializes]

/-- No cancellation at specialization: the complete mutable support is unchanged. -/
theorem deformedStar_mutableSupport {N : ℕ} (E : I → PositiveLaurent G I)
    (H : Fin N → I → PositiveLaurent G I) (labels : ℕ → I) (n : ℕ) (i : I) :
    mutableSupport (deformedStar E H labels n i) =
      mutableSupport (positiveStarIterate E (finiteCorrections H) labels n i) := by
  rw [← deformedStar_specializes]
  exact (mutableSupport_coefficient_map (deformationMap E H) _).symm

theorem deformedStar_properties {N : ℕ} (E : I → PositiveLaurent G I)
    (H : Fin N → I → PositiveLaurent G I) (labels : ℕ → I) (n : ℕ) (i : I)
    (hp : PositivePolynomialSupport (positiveStarIterate E (finiteCorrections H) labels n i))
    (hi : PositiveIndependent (positiveStarIterate E (finiteCorrections H) labels n i) i)
    (hv : PositiveNoVariableFactor (positiveStarIterate E (finiteCorrections H) labels n i)) :
    PositivePolynomialSupport (deformedStar E H labels n i) ∧
    PositiveIndependent (deformedStar E H labels n i) i ∧
    PositiveNoVariableFactor (deformedStar E H labels n i) := by
  obtain ⟨h₁,h₂,h₃⟩ := positive_support_properties_transfer
    (deformedStar E H labels n i) _ (deformedStar_mutableSupport E H labels n i) i
  exact ⟨h₁.mpr hp, h₂.mpr hi, h₃.mpr hv⟩

theorem deformedStar_ne_zero {N : ℕ} (E : I → PositiveLaurent G I)
    (H : Fin N → I → PositiveLaurent G I) (labels : ℕ → I) (n : ℕ) (i : I)
    (h : positiveStarIterate E (finiteCorrections H) labels n i ≠ 0) :
    deformedStar E H labels n i ≠ 0 := by
  intro hz
  apply h
  rw [← deformedStar_specializes E H labels n i, hz, map_zero]

end
end TauCeti.Laurent
