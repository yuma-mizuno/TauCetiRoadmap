/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import Mathlib.GroupTheory.FreeAbelianGroup
public import Mathlib.Algebra.MonoidAlgebra.MapDomain
public import Mathlib.Data.Fintype.BigOperators
public import Mathlib.Data.Finsupp.Order
public import Mathlib.Algebra.MonoidAlgebra.Support

/-! # Positive Lift -/

@[expose] public section

noncomputable section
namespace TauCeti.Laurent
open scoped BigOperators

variable {G M : Type*} [AddCommGroup G] [AddCommGroup M]

/-- One tag for each occurrence of a positive integer coefficient. -/
abbrev PositiveAtom (p : AddMonoidAlgebra ℕ (G × M)) :=
  (t : p.coeff.support) × Fin (p.coeff t.val)

instance (p : AddMonoidAlgebra ℕ (G × M)) : Fintype (PositiveAtom p) := by
  classical
  unfold PositiveAtom
  infer_instance

/-- The universal coefficient group has a distinct generator for every atom. -/
abbrev AtomGroup (p : AddMonoidAlgebra ℕ (G × M)) := FreeAbelianGroup (PositiveAtom p)

/-- Each parameter specializes to its original group basis unit. -/
def atomCoefficientMap (p : AddMonoidAlgebra ℕ (G × M)) : AtomGroup p →+ G :=
  FreeAbelianGroup.lift (fun a => a.1.val.1)

/-- Specialize free coefficient atoms to their original coefficient exponents while retaining the
mutable exponent.
-/
def atomExponentMap (p : AddMonoidAlgebra ℕ (G × M)) :
    AtomGroup p × M →+ G × M :=
  (atomCoefficientMap p).prodMap (AddMonoidHom.id M)

/-- The atom lift retains the mutable exponent and replaces coefficient atoms by
    independent free-group generators, each with coefficient one. -/
def atomLift (p : AddMonoidAlgebra ℕ (G × M)) :
    AddMonoidAlgebra ℕ (AtomGroup p × M) :=
  ∑ a : PositiveAtom p, AddMonoidAlgebra.single
    (FreeAbelianGroup.of a, a.1.val.2) 1

@[simp] theorem atomExponentMap_generator (p : AddMonoidAlgebra ℕ (G × M))
    (a : PositiveAtom p) :
    atomExponentMap p (FreeAbelianGroup.of a, a.1.val.2) = a.1.val := by
  simp [atomExponentMap, atomCoefficientMap]

/-- Specialization recovers all coefficient multiplicities, including collisions. -/
theorem atomLift_specializes (p : AddMonoidAlgebra ℕ (G × M)) :
    AddMonoidAlgebra.mapDomainRingHom ℕ (atomExponentMap p) (atomLift p) = p := by
  classical
  simp only [atomLift, map_sum, AddMonoidAlgebra.mapDomainRingHom_apply,
    AddMonoidAlgebra.mapDomain_single, atomExponentMap_generator]
  change (∑ a : (t : p.coeff.support) × Fin (p.coeff t.val),
    AddMonoidAlgebra.single a.1.val 1) = p
  rw [Fintype.sum_sigma]
  simp only [Finset.sum_const, Finset.card_univ, Fintype.card_fin]
  apply AddMonoidAlgebra.coeff_injective
  simp only [Finset.univ_eq_attach, AddMonoidAlgebra.smul_single, smul_eq_mul, mul_one,
    Finsupp.sum_attach_index, AddMonoidAlgebra.coeff_sum, AddMonoidAlgebra.coeff_single]
  change p.coeff.sum Finsupp.single = p.coeff
  exact Finsupp.sum_single p.coeff

/-- Mutable support forgets coefficient-group exponents. -/
def mutableSupport (p : AddMonoidAlgebra ℕ (G × M)) : Finset M := by
  classical
  exact p.coeff.support.image Prod.snd

theorem mutableSupport_coefficient_map {H : Type*} [AddCommGroup H]
    (φ : G →+ H) (p : AddMonoidAlgebra ℕ (G × M)) :
    mutableSupport (AddMonoidAlgebra.mapDomainRingHom ℕ
      (φ.prodMap (AddMonoidHom.id M)) p) = mutableSupport p := by
  classical
  unfold mutableSupport
  change (Finsupp.mapDomain (φ.prodMap (AddMonoidHom.id M)) p.coeff).support.image
    Prod.snd = p.coeff.support.image Prod.snd
  rw [Finsupp.mapDomain_support_of_subsingletonAddUnits, Finset.image_image]
  rfl

/-- Replacing coefficient atoms preserves the entire mutable support. -/
theorem atomLift_mutableSupport (p : AddMonoidAlgebra ℕ (G × M)) :
    mutableSupport (atomLift p) = mutableSupport p := by
  have h := mutableSupport_coefficient_map (atomCoefficientMap p) (atomLift p)
  rw [show (atomCoefficientMap p).prodMap (AddMonoidHom.id M) = atomExponentMap p
    from rfl, atomLift_specializes] at h
  exact h.symm

/-- Every nonzero input gives a nonzero universal lift. -/
theorem atomLift_ne_zero {p : AddMonoidAlgebra ℕ (G × M)} (hp : p ≠ 0) :
    atomLift p ≠ 0 := by
  intro h
  apply hp
  rw [← atomLift_specializes p, h, map_zero]

section Families
variable {L : Type*}

/-- Locations keep all first-star inputs and correction parameters disjoint. -/
abbrev FamilyAtom (p : L → AddMonoidAlgebra ℕ (G × M)) :=
  (l : L) × PositiveAtom (p l)

instance [Fintype L] (p : L → AddMonoidAlgebra ℕ (G × M)) : Fintype (FamilyAtom p) := by
  classical
  unfold FamilyAtom
  infer_instance

/-- Send each free family-occurrence atom to its original coefficient-group exponent. -/
def familyAtomCoefficientMap (p : L → AddMonoidAlgebra ℕ (G × M)) :
    FreeAbelianGroup (FamilyAtom p) →+ G :=
  FreeAbelianGroup.lift (fun a => a.2.1.val.1)

/-- Specialize all free coefficient-occurrence exponents and retain the original mutable exponent.
-/
def familyAtomExponentMap (p : L → AddMonoidAlgebra ℕ (G × M)) :
    FreeAbelianGroup (FamilyAtom p) × M →+ G × M :=
  (familyAtomCoefficientMap p).prodMap (AddMonoidHom.id M)

/-- Replace every coefficient occurrence in a family member by its own free atom, retaining its
mutable exponent.
-/
def familyAtomLift (p : L → AddMonoidAlgebra ℕ (G × M)) (l : L) :
    AddMonoidAlgebra ℕ (FreeAbelianGroup (FamilyAtom p) × M) :=
  ∑ a : PositiveAtom (p l), AddMonoidAlgebra.single
    (FreeAbelianGroup.of (⟨l, a⟩ : FamilyAtom p), a.1.val.2) 1

theorem familyAtomLift_specializes (p : L → AddMonoidAlgebra ℕ (G × M)) (l : L) :
    AddMonoidAlgebra.mapDomainRingHom ℕ (familyAtomExponentMap p)
      (familyAtomLift p l) = p l := by
  classical
  simp only [familyAtomLift, map_sum, AddMonoidAlgebra.mapDomainRingHom_apply,
    AddMonoidAlgebra.mapDomain_single]
  have hg (a : PositiveAtom (p l)) :
      familyAtomExponentMap p (FreeAbelianGroup.of (⟨l, a⟩ : FamilyAtom p), a.1.val.2) =
      a.1.val := by
    change ((FreeAbelianGroup.lift (fun b : FamilyAtom p => b.2.1.val.1))
      (FreeAbelianGroup.of (⟨l, a⟩ : FamilyAtom p)), a.1.val.2) = a.1.val
    rw [FreeAbelianGroup.lift_apply_of]
  simp_rw [hg]
  change (∑ a : (t : (p l).coeff.support) × Fin ((p l).coeff t.val),
    AddMonoidAlgebra.single a.1.val 1) = p l
  rw [Fintype.sum_sigma]
  simp only [Finset.sum_const, Finset.card_univ, Fintype.card_fin]
  apply AddMonoidAlgebra.coeff_injective
  simp only [Finset.univ_eq_attach, AddMonoidAlgebra.smul_single, smul_eq_mul, mul_one,
    Finsupp.sum_attach_index, AddMonoidAlgebra.coeff_sum, AddMonoidAlgebra.coeff_single]
  change (p l).coeff.sum Finsupp.single = (p l).coeff
  exact Finsupp.sum_single (p l).coeff

theorem familyAtomLift_mutableSupport (p : L → AddMonoidAlgebra ℕ (G × M)) (l : L) :
    mutableSupport (familyAtomLift p l) = mutableSupport (p l) := by
  have h := mutableSupport_coefficient_map (familyAtomCoefficientMap p) (familyAtomLift p l)
  rw [show (familyAtomCoefficientMap p).prodMap (AddMonoidHom.id M) =
    familyAtomExponentMap p from rfl, familyAtomLift_specializes] at h
  exact h.symm

omit [AddCommGroup G] [AddCommGroup M] in
/-- Tags from different input locations are distinct. -/
theorem familyAtom_locations_disjoint (p : L → AddMonoidAlgebra ℕ (G × M))
    {l k : L} (hlk : l ≠ k) (a : PositiveAtom (p l)) (b : PositiveAtom (p k)) :
    (⟨l, a⟩ : FamilyAtom p) ≠ ⟨k, b⟩ := by
  intro h
  exact hlk (congrArg Sigma.fst h)

omit [AddCommGroup M] in
/-- Every coefficient parameter evaluates to a basis unit, even when the
    original coefficient multiplicity is greater than one. -/
theorem familyAtom_parameter_isUnit (p : L → AddMonoidAlgebra ℕ (G × M))
    (a : FamilyAtom p) :
    IsUnit (AddMonoidAlgebra.single (familyAtomCoefficientMap p (FreeAbelianGroup.of a))
      (1 : ℤ)) := by
  let g := familyAtomCoefficientMap p (FreeAbelianGroup.of a)
  refine ⟨⟨AddMonoidAlgebra.single g 1, AddMonoidAlgebra.single (-g) 1, ?_, ?_⟩, rfl⟩
  · simp [AddMonoidAlgebra.single_mul_single, AddMonoidAlgebra.one_def]
  · simp [AddMonoidAlgebra.single_mul_single, AddMonoidAlgebra.one_def]

end Families

/-- Positive coefficients prevent cancellation in sums. -/
theorem positive_support_add [DecidableEq G] [DecidableEq M] (p q : AddMonoidAlgebra ℕ (G × M)) :
    (p + q).coeff.support = p.coeff.support ∪ q.coeff.support := by
  classical
  exact Finsupp.support_add_eq_union

/-- Positive coefficients prevent cancellation in the convolution product. -/
theorem positive_support_mul [DecidableEq G] [DecidableEq M] (p q : AddMonoidAlgebra ℕ (G × M)) :
    (p * q).coeff.support = Finset.image₂ (· + ·) p.coeff.support q.coeff.support := by
  classical
  ext z
  simp only [Finsupp.mem_support_iff, AddMonoidAlgebra.coeff_mul, Finsupp.sum,
    Finset.mem_image₂, ne_eq, Finset.sum_eq_zero_iff]
  constructor
  · intro h
    push Not at h
    obtain ⟨a, ha, b, hb, hab⟩ := h
    by_cases he : a + b = z
    · exact ⟨a, ha, b, hb, he⟩
    · exact False.elim (hab (ite_eq_right he))
  · rintro ⟨a, ha, b, hb, rfl⟩ h
    have he := h a ha b hb
    simp only [ite_true] at he
    exact mul_ne_zero ha hb he
/-- The mutable support of a sum is its union. -/
theorem mutableSupport_add [DecidableEq M]
    (p q : AddMonoidAlgebra ℕ (G × M)) :
    mutableSupport (p + q) = mutableSupport p ∪ mutableSupport q := by
  classical
  unfold mutableSupport
  rw [positive_support_add]
  ext z
  simp only [Finset.mem_image, Finset.mem_union]
  constructor
  · rintro ⟨a, ha | ha, haz⟩
    · exact Or.inl ⟨a, ha, haz⟩
    · exact Or.inr ⟨a, ha, haz⟩
  · rintro (⟨a, ha, haz⟩ | ⟨a, ha, haz⟩)
    · exact ⟨a, Or.inl ha, haz⟩
    · exact ⟨a, Or.inr ha, haz⟩

/-- The mutable support of a product is the Minkowski sum. -/
theorem mutableSupport_mul [DecidableEq M]
    (p q : AddMonoidAlgebra ℕ (G × M)) :
    mutableSupport (p * q) = Finset.image₂ (· + ·) (mutableSupport p) (mutableSupport q) := by
  classical
  simp only [mutableSupport, positive_support_mul]
  ext z
  simp only [Finset.mem_image, Finset.mem_image₂]
  constructor
  · rintro ⟨_, ⟨a, ha, b, hb, rfl⟩, rfl⟩
    exact ⟨a.2, ⟨a, ha, rfl⟩, b.2, ⟨b, hb, rfl⟩, rfl⟩
  · rintro ⟨_, ⟨a, ha, rfl⟩, _, ⟨b, hb, rfl⟩, rfl⟩
    exact ⟨a + b, ⟨a, ha, b, hb, rfl⟩, rfl⟩

end TauCeti.Laurent
