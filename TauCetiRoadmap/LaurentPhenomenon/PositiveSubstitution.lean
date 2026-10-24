/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.PositiveLift
public import Mathlib.Algebra.Group.Nat.Hom

/-! # Positive Substitution -/

@[expose] public section

noncomputable section
namespace TauCeti.Laurent
open scoped BigOperators
variable {G H I : Type*} [AddCommGroup G] [AddCommGroup H] [DecidableEq I]
/-- Natural-coefficient group polynomials in coefficient-group and mutable integer exponents. -/
abbrev PositiveLaurent (G I : Type*) :=
  AddMonoidAlgebra ℕ (G × (I →₀ ℤ))

/-- Negate the jth component of a finite integer exponent vector, retaining every other component.
-/
def reflectedExponent (j : I) (a : I →₀ ℤ) : I →₀ ℤ :=
  a - Finsupp.single j (2 * a j)

/-- Finite substitution term. The nonnegative exponent condition on the input
    identifies `toNat` with the original exponent in rational evaluation. -/
def positiveSubstitutionTerm (q : PositiveLaurent G I) (j : I)
    (t : G × (I →₀ ℤ)) : ℕ →+ PositiveLaurent G I :=
  multiplesHom _ (AddMonoidAlgebra.single (t.1, reflectedExponent j t.2) 1 *
    q ^ (t.2 j).toNat)

/-- The finite formula for substituting q/X_j for X_j, agreeing with rational substitution on
nonnegative j-support.
-/
def positiveSubstitute (E q : PositiveLaurent G I) (j : I) : PositiveLaurent G I :=
  E.coeff.sum (fun t n => positiveSubstitutionTerm q j t n)

/-- Change the coefficient exponent group along phi while retaining mutable exponents and natural
coefficients.
-/
def coefficientMap (φ : G →+ H) : PositiveLaurent G I →+* PositiveLaurent H I :=
  AddMonoidAlgebra.mapDomainRingHom ℕ (φ.prodMap (AddMonoidHom.id _))

omit [DecidableEq I] in
@[simp] theorem coefficientMap_single (φ : G →+ H) (g : G) (a : I →₀ ℤ) (n : ℕ) :
    coefficientMap (I := I) φ (AddMonoidAlgebra.single (g, a) n) =
      AddMonoidAlgebra.single (φ g, a) n := by
  simp [coefficientMap]

omit [DecidableEq I] in
@[simp] theorem coefficientMap_substitutionTerm (φ : G →+ H)
    (q : PositiveLaurent G I) (j : I) (t : G × (I →₀ ℤ)) (n : ℕ) :
    coefficientMap φ (positiveSubstitutionTerm q j t n) =
      positiveSubstitutionTerm (coefficientMap φ q) j (φ t.1, t.2) n := by
  simp [positiveSubstitutionTerm, map_mul, map_pow]

omit [DecidableEq I] in
/-- Noninjective coefficient specialization commutes with positive substitution;
    merging coefficients is handled by additivity of each term. -/
theorem positiveSubstitute_natural (φ : G →+ H)
    (E q : PositiveLaurent G I) (j : I) :
    coefficientMap φ (positiveSubstitute E q j) =
      positiveSubstitute (coefficientMap φ E) (coefficientMap φ q) j := by
  unfold positiveSubstitute
  change coefficientMap φ (E.coeff.sum _) =
    (Finsupp.mapDomain (φ.prodMap (AddMonoidHom.id _)) E.coeff).sum _
  rw [Finsupp.sum_mapDomain_index_addMonoidHom]
  simp only [Finsupp.sum, map_sum, coefficientMap_substitutionTerm]
  rfl

/-- Zero specialization on a polynomial keeps exactly the exponent-zero terms.
    As a linear operation this is also defined on the ambient Laurent algebra. -/
def positiveSetZero (E : PositiveLaurent G I) (i : I) : PositiveLaurent G I :=
  AddMonoidAlgebra.ofCoeff (E.coeff.filter (fun t => t.2 i = 0))

omit [DecidableEq I] in
omit [AddCommGroup G] in
@[simp] theorem positiveSetZero_coeff (E : PositiveLaurent G I) (i : I)
    (t : G × (I →₀ ℤ)) :
    (positiveSetZero E i).coeff t = if t.2 i = 0 then E.coeff t else 0 := by
  classical
  simp [positiveSetZero, Finsupp.filter_apply]

omit [DecidableEq I] in
theorem positiveSetZero_as_sum (E : PositiveLaurent G I) (i : I) :
    positiveSetZero E i = E.coeff.sum
      (fun t n => if t.2 i = 0 then AddMonoidAlgebra.single t n else 0) := by
  classical
  apply AddMonoidAlgebra.coeff_injective
  simp only [positiveSetZero, AddMonoidAlgebra.coeff_ofCoeff, Finsupp.filter_eq_sum,
    Finsupp.sum, AddMonoidAlgebra.coeff_sum,
    Finset.sum_filter]
  apply Finset.sum_congr rfl
  intro t ht
  split <;> simp_all

omit [DecidableEq I] in
omit [AddCommGroup G] in
theorem positiveSetZero_support (E : PositiveLaurent G I) (i : I) :
    (positiveSetZero E i).coeff.support = E.coeff.support.filter (fun t => t.2 i = 0) := by
  classical
  exact Finsupp.support_filter _ _

omit [DecidableEq I] in
theorem positiveSetZero_ne_zero (E : PositiveLaurent G I) (i : I)
    (h : ∃ t ∈ E.coeff.support, t.2 i = 0) : positiveSetZero E i ≠ 0 := by
  obtain ⟨t, ht, hi⟩ := h
  intro hz
  have he := congrArg (fun p : PositiveLaurent G I => p.coeff t) hz
  apply Finsupp.mem_support_iff.mp ht
  simpa [positiveSetZero_coeff, hi] using he

omit [DecidableEq I] in
/-- Setting a mutable variable to zero commutes with coefficient specialization. -/
theorem positiveSetZero_natural (φ : G →+ H) (E : PositiveLaurent G I) (i : I) :
    coefficientMap φ (positiveSetZero E i) = positiveSetZero (coefficientMap φ E) i := by
  classical
  rw [positiveSetZero_as_sum, positiveSetZero_as_sum]
  change coefficientMap φ (E.coeff.sum _) =
    (Finsupp.mapDomain (φ.prodMap (AddMonoidHom.id _)) E.coeff).sum _
  rw [Finsupp.sum_mapDomain_index
    (fun t => by split <;> simp)
    (fun t a b => by split <;> simp [AddMonoidAlgebra.single_add])]
  simp only [Finsupp.sum, map_sum]
  apply Finset.sum_congr rfl
  intro t ht
  split <;> simp_all [coefficientMap]

/-- A full correction/substitution propagation step. -/
def positivePropagate (H E q : PositiveLaurent G I) (j : I) : PositiveLaurent G I :=
  H * positiveSubstitute E q j

omit [DecidableEq I] in
theorem positivePropagate_natural (φ : G →+ H)
    (C E q : PositiveLaurent G I) (j : I) :
    coefficientMap φ (positivePropagate C E q j) =
      positivePropagate (coefficientMap φ C) (coefficientMap φ E) (coefficientMap φ q) j := by
  classical
  simp only [positivePropagate, map_mul, positiveSubstitute_natural]

omit [DecidableEq I] in
/-- The propagated lift has the exact original mutable support: no positivity
    hypothesis is hidden here, since the expressions lie in the natural semiring. -/
theorem positivePropagate_mutableSupport (φ : G →+ H)
    (C E q : PositiveLaurent G I) (j : I) :
    mutableSupport (positivePropagate C E q j) =
      mutableSupport (positivePropagate (coefficientMap φ C) (coefficientMap φ E)
        (coefficientMap φ q) j) := by
  classical
  rw [← positivePropagate_natural]
  exact (mutableSupport_coefficient_map φ _).symm

/-- Polynomiality is a statement about mutable support. -/
def PositiveNonnegativeAt (E : PositiveLaurent G I) (j : I) : Prop :=
  ∀ a ∈ mutableSupport E, 0 ≤ a j

/-- Every supported mutable exponent is nonnegative in every coordinate. -/
def PositivePolynomialSupport (E : PositiveLaurent G I) : Prop :=
  ∀ a ∈ mutableSupport E, ∀ i, 0 ≤ a i

/-- Every supported exponent has zero ith mutable component. -/
def PositiveIndependent (E : PositiveLaurent G I) (i : I) : Prop :=
  ∀ a ∈ mutableSupport E, a i = 0

/-- For each mutable variable, some supported exponent has zero component in that variable. -/
def PositiveNoVariableFactor (E : PositiveLaurent G I) : Prop :=
  ∀ i, ∃ a ∈ mutableSupport E, a i = 0

omit [DecidableEq I] in
/-- Exact support preservation transfers polynomiality. -/
theorem positivePropagate_polynomial (φ : G →+ H)
    (C E q : PositiveLaurent G I) (j : I)
    (h : PositivePolynomialSupport (positivePropagate (coefficientMap φ C)
      (coefficientMap φ E) (coefficientMap φ q) j)) :
    PositivePolynomialSupport (positivePropagate C E q j) := by
  classical
  unfold PositivePolynomialSupport at *
  rwa [positivePropagate_mutableSupport φ]

/-- One whole star is propagated, retaining the exchange polynomial on its label. -/
def positiveStarStep (E C : I → PositiveLaurent G I) (j i : I) : PositiveLaurent G I :=
  if i = j then E i else positivePropagate (C i) (E i) (positiveSetZero (E j) i) j

theorem positiveStarStep_natural (φ : G →+ H)
    (E C : I → PositiveLaurent G I) (j i : I) :
    coefficientMap φ (positiveStarStep E C j i) =
      positiveStarStep (fun k => coefficientMap φ (E k))
        (fun k => coefficientMap φ (C k)) j i := by
  unfold positiveStarStep
  split <;> simp only [positivePropagate_natural, positiveSetZero_natural]

theorem positiveStarStep_mutableSupport (φ : G →+ H)
    (E C : I → PositiveLaurent G I) (j i : I) :
    mutableSupport (positiveStarStep E C j i) =
      mutableSupport (positiveStarStep (fun k => coefficientMap φ (E k))
        (fun k => coefficientMap φ (C k)) j i) := by
  rw [← positiveStarStep_natural]
  exact (mutableSupport_coefficient_map φ _).symm

/-- Forward finite propagation uses only input stars and correction polynomials. -/
def positiveStarIterate (E₀ : I → PositiveLaurent G I)
    (C : ℕ → I → PositiveLaurent G I) (labels : ℕ → I) :
    ℕ → I → PositiveLaurent G I
  | 0 => E₀
  | n + 1 => positiveStarStep (positiveStarIterate E₀ C labels n) (C n) (labels n)

theorem positiveStarIterate_natural (φ : G →+ H)
    (E₀ : I → PositiveLaurent G I) (C : ℕ → I → PositiveLaurent G I)
    (labels : ℕ → I) (n : ℕ) (i : I) :
    coefficientMap φ (positiveStarIterate E₀ C labels n i) =
      positiveStarIterate (fun k => coefficientMap φ (E₀ k))
        (fun m k => coefficientMap φ (C m k)) labels n i := by
  induction n generalizing i with
  | zero => rfl
  | succ n ih =>
    simp only [positiveStarIterate, positiveStarStep_natural]
    congr 1
    funext k
    exact ih k

omit [DecidableEq I] in
/-- Absence of a variable factor gives the required nonzero zero specialization. -/
theorem positiveNoVariableFactor_setZero_ne_zero (E : PositiveLaurent G I)
    (h : PositiveNoVariableFactor E) (i : I) : positiveSetZero E i ≠ 0 := by
  classical
  obtain ⟨a, ha, hi⟩ := h i
  simp only [mutableSupport, Finset.mem_image] at ha
  obtain ⟨t, ht, rfl⟩ := ha
  exact positiveSetZero_ne_zero E i ⟨t, ht, hi⟩

theorem positiveStarIterate_mutableSupport (φ : G →+ H)
    (E₀ : I → PositiveLaurent G I) (C : ℕ → I → PositiveLaurent G I)
    (labels : ℕ → I) (n : ℕ) (i : I) :
    mutableSupport (positiveStarIterate E₀ C labels n i) =
      mutableSupport (positiveStarIterate (fun k => coefficientMap φ (E₀ k))
        (fun m k => coefficientMap φ (C m k)) labels n i) := by
  rw [← positiveStarIterate_natural]
  exact (mutableSupport_coefficient_map φ _).symm

omit [DecidableEq I] in
omit [AddCommGroup G] [AddCommGroup H] in
/-- Polynomiality, label independence, and absence of variable factors depend
    only on mutable support and therefore descend to every propagated lift. -/
theorem positive_support_properties_transfer
    (E : PositiveLaurent G I) (R : PositiveLaurent H I)
    (hsupp : mutableSupport E = mutableSupport R) (i : I) :
    (PositivePolynomialSupport E ↔ PositivePolynomialSupport R) ∧
    (PositiveIndependent E i ↔ PositiveIndependent R i) ∧
    (PositiveNoVariableFactor E ↔ PositiveNoVariableFactor R) := by
  unfold PositivePolynomialSupport PositiveIndependent PositiveNoVariableFactor
  rw [hsupp]
  exact ⟨Iff.rfl, Iff.rfl, Iff.rfl⟩

omit [DecidableEq I] in
/-- Positivity makes the support of any finite sum the union of term supports. -/
theorem mutableSupport_sum_mem {A : Type*} (s : Finset A)
    (f : A → PositiveLaurent G I) (a : I →₀ ℤ) :
    a ∈ mutableSupport (∑ t ∈ s, f t) ↔ ∃ t ∈ s, a ∈ mutableSupport (f t) := by
  classical
  induction s using Finset.induction_on with
  | empty => simp [mutableSupport]
  | @insert t s ht ih =>
    rw [Finset.sum_insert ht, mutableSupport_add]
    simp only [Finset.mem_union, ih, Finset.mem_insert]
    constructor
    · rintro (h | ⟨u, hu, h⟩)
      · exact ⟨t, Or.inl rfl, h⟩
      · exact ⟨u, Or.inr hu, h⟩
    · rintro ⟨u, rfl | hu, h⟩
      · exact Or.inl h
      · exact Or.inr ⟨u, hu, h⟩

omit [DecidableEq I] in
theorem mutableSupport_nsmul (n : ℕ) (p : PositiveLaurent G I) (hn : n ≠ 0) :
    mutableSupport (n • p) = mutableSupport p := by
  classical
  induction n with
  | zero => exact False.elim (hn rfl)
  | succ n ih =>
    cases n with
    | zero => simp
    | succ n =>
      rw [succ_nsmul, mutableSupport_add, ih (Nat.succ_ne_zero _), Finset.union_self]

/-- One substituted monomial has the expected translated power support. -/
theorem positiveSubstitutionTerm_support (q : PositiveLaurent G I) (j : I)
    (t : G × (I →₀ ℤ)) (n : ℕ) (hn : n ≠ 0) :
    mutableSupport (positiveSubstitutionTerm q j t n) =
      (mutableSupport (q ^ (t.2 j).toNat)).image (fun b => reflectedExponent j t.2 + b) := by
  classical
  change mutableSupport (n • (AddMonoidAlgebra.single (t.1, reflectedExponent j t.2) 1 *
    q ^ (t.2 j).toNat)) = _
  rw [mutableSupport_nsmul n _ hn, mutableSupport_mul]
  simp [mutableSupport]

omit [DecidableEq I] in
/-- Explicit substitution support, retaining all mutable variables. -/
theorem positiveSubstitute_support_mem (E q : PositiveLaurent G I) (j : I) (a : I →₀ ℤ) :
    a ∈ mutableSupport (positiveSubstitute E q j) ↔
      ∃ t ∈ E.coeff.support, ∃ b ∈ mutableSupport (q ^ (t.2 j).toNat),
        reflectedExponent j t.2 + b = a := by
  classical
  unfold positiveSubstitute
  rw [Finsupp.sum, mutableSupport_sum_mem]
  constructor
  · rintro ⟨t, ht, ha⟩
    rw [positiveSubstitutionTerm_support _ _ _ _ (Finsupp.mem_support_iff.mp ht)] at ha
    exact ⟨t, ht, Finset.mem_image.mp ha⟩
  · rintro ⟨t, ht, b, hb, hba⟩
    refine ⟨t, ht, ?_⟩
    rw [positiveSubstitutionTerm_support _ _ _ _ (Finsupp.mem_support_iff.mp ht)]
    exact Finset.mem_image.mpr ⟨b, hb, hba⟩

omit [DecidableEq I] in
theorem positiveLaurent_support_nonempty (E : PositiveLaurent G I) (hp : E ≠ 0) :
    E.coeff.support.Nonempty := by
  apply Finset.nonempty_iff_ne_empty.mpr
  intro h
  apply hp
  apply AddMonoidAlgebra.coeff_injective
  exact Finsupp.support_eq_empty.mp h

omit [DecidableEq I] in
/-- Natural coefficient convolution has no zero divisors, even for groups
    with torsion; positivity supplies the argument. -/
theorem positiveLaurent_mul_ne_zero {E q : PositiveLaurent G I} (hE : E ≠ 0) (hq : q ≠ 0) :
    E * q ≠ 0 := by
  classical
  obtain ⟨a, ha⟩ := positiveLaurent_support_nonempty E hE
  obtain ⟨b, hb⟩ := positiveLaurent_support_nonempty q hq
  have hm : a + b ∈ (E * q).coeff.support := by
    rw [positive_support_mul]
    exact Finset.mem_image₂.mpr ⟨a, ha, b, hb, rfl⟩
  intro h
  simp [h] at hm

omit [DecidableEq I] in
theorem positiveLaurent_pow_ne_zero {q : PositiveLaurent G I} (hq : q ≠ 0) (n : ℕ) :
    q ^ n ≠ 0 := by
  classical
  induction n with
  | zero => exact one_ne_zero
  | succ n ih =>
    rw [pow_succ]
    exact positiveLaurent_mul_ne_zero ih hq

omit [DecidableEq I] in
/-- Every positive substitution used in C4/C5 is nonzero. -/
theorem positiveSubstitute_ne_zero {E q : PositiveLaurent G I} (hE : E ≠ 0) (hq : q ≠ 0)
    (j : I) : positiveSubstitute E q j ≠ 0 := by
  classical
  obtain ⟨t, ht⟩ := positiveLaurent_support_nonempty E hE
  obtain ⟨b, hb⟩ := positiveLaurent_support_nonempty (q ^ (t.2 j).toNat)
    (positiveLaurent_pow_ne_zero hq _)
  have hm : reflectedExponent j t.2 + b.2 ∈ mutableSupport (positiveSubstitute E q j) := by
    apply (positiveSubstitute_support_mem E q j _).mpr
    refine ⟨t, ht, b.2, ?_, rfl⟩
    simp only [mutableSupport, Finset.mem_image]
    exact ⟨b, hb, rfl⟩
  intro h
  simp [h, mutableSupport] at hm

end TauCeti.Laurent
