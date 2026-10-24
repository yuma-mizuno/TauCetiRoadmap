/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.GenericCoprimality
public import TauCetiRoadmap.LaurentPhenomenon.LaurentSplit
public import TauCetiRoadmap.LaurentPhenomenon.PositiveLift
public import TauCetiRoadmap.LaurentPhenomenon.PositiveSpecialization
public import TauCetiRoadmap.LaurentPhenomenon.GroupRing
public import TauCetiRoadmap.LaurentPhenomenon.PositiveSubstitution
public import Mathlib.GroupTheory.MonoidLocalization.UniqueFactorization

/-! # Fresh Parameter -/

@[expose] public section

namespace TauCeti.Laurent
noncomputable section
open Polynomial
open scoped LaurentPolynomial

/--
A prime relatively prime to q remains relatively prime after localization, even if it becomes a
unit.
-/
theorem prime_relPrime_localization
    {R S : Type*} [CommRing R] [CommRing S] [IsDomain S] (M : Submonoid R)
    [Algebra R S] [IsLocalization M S]
    (hi : Function.Injective (algebraMap R S)) {p q : R}
    (hp : Prime p) (hpq : IsRelPrime p q) :
    IsRelPrime (algebraMap R S p) (algebraMap R S q) := by
  by_cases hu : IsUnit (algebraMap R S p)
  · exact hu.isRelPrime_left
  have hn : algebraMap R S p ≠ 0 := fun hz ↦ hp.ne_zero (hi (by simpa using hz))
  have hprime := (IsLocalization.toLocalizationMap M S).map_prime hp hn hu
  apply hprime.irreducible.isRelPrime_iff_not_dvd.mpr
  intro hd
  obtain ⟨s, hs, hd⟩ := (IsLocalization.toLocalizationMap M S).map_dvd_map.mp hd
  rcases hp.dvd_or_dvd hd with hps | hpq'
  · exact hu (isUnit_of_dvd_unit (map_dvd (algebraMap R S) hps)
      (IsLocalization.map_units S ⟨s, hs⟩))
  · exact hp.not_isUnit (hpq.isUnit_of_dvd hpq')

/-- A primitive fresh-parameter expression is coprime to every nonzero expression avoiding it,
already in the Laurent polynomial ring. -/
theorem genericLinear_laurent_relPrime_constant
    {S : Type*} [CommRing S] [IsDomain S] (m : Sˣ) (b q : S) (hq : q ≠ 0) :
    IsRelPrime (LaurentPolynomial.C (m : S) * LaurentPolynomial.T 1 + LaurentPolynomial.C b)
      (LaurentPolynomial.C q) := by
  have h := prime_relPrime_localization (S := S[T;T⁻¹])
    (Submonoid.powers (X : S[X])) Polynomial.toLaurent_injective
    (genericLinear_prime m b) (genericLinear_relPrime_constant m b q hq)
  simpa only [LaurentPolynomial.algebraMap_eq_toLaurent, genericLinear, map_add, map_mul,
    Polynomial.toLaurent_C, Polynomial.toLaurent_X] using h

open scoped BigOperators

/-- A positive Laurent expression avoids an atom when every supported group exponent has
zero multiplicity at that atom. -/
def AvoidsAtom {A M : Type*} (k : A)
    (q : AddMonoidAlgebra ℕ (FreeAbelianGroup A × M)) : Prop :=
  ∀ t ∈ q.coeff.support, t.1.toFinsupp k = 0

theorem avoidsAtom_single {A M : Type*} (k : A)
    (t : FreeAbelianGroup A × M) (n : ℕ) (ht : t.1.toFinsupp k = 0) :
    AvoidsAtom k (AddMonoidAlgebra.single t n) := by
  intro u hu
  have hu' : u ∈ (Finsupp.single t n).support := hu
  have hut : u = t := Finset.mem_singleton.mp (Finsupp.support_single_subset hu')
  simpa [hut] using ht

/-- The positive-polynomial subsemiring whose supported exponents omit the chosen free coefficient
atom.
-/
def avoidsAtomSubsemiring {A M : Type*} [AddCommGroup M] (k : A) :
    Subsemiring (AddMonoidAlgebra ℕ (FreeAbelianGroup A × M)) where
  carrier := AvoidsAtom k
  zero_mem' := by intro t ht; simp at ht
  one_mem' := by
    apply avoidsAtom_single k 0 1
    simp
  add_mem' := by
    classical
    intro p q hp hq t ht
    rw [positive_support_add] at ht
    rcases Finset.mem_union.mp ht with ht | ht
    · exact hp t ht
    · exact hq t ht
  mul_mem' := by
    classical
    intro p q hp hq t ht
    rw [positive_support_mul] at ht
    obtain ⟨a, ha, b, hb, rfl⟩ := Finset.mem_image₂.mp ht
    simp [hp a ha, hq b hb]

theorem avoidsAtom_setZero {A I : Type*} (k : A)
    {q : PositiveLaurent (FreeAbelianGroup A) I} (hq : AvoidsAtom k q) (i : I) :
    AvoidsAtom k (positiveSetZero q i) := by
  classical
  intro t ht
  rw [positiveSetZero_support] at ht
  exact hq t (Finset.mem_filter.mp ht).1

theorem avoidsAtom_substitute {A I : Type*} (k : A)
    {E q : PositiveLaurent (FreeAbelianGroup A) I}
    (hE : AvoidsAtom k E) (hq : AvoidsAtom k q) (j : I) :
    AvoidsAtom k (positiveSubstitute E q j) := by
  classical
  change positiveSubstitute E q j ∈ avoidsAtomSubsemiring k
  unfold positiveSubstitute
  rw [Finsupp.sum]
  apply Subsemiring.sum_mem
  intro t ht
  change (E.coeff t) • (AddMonoidAlgebra.single (t.1, reflectedExponent j t.2) 1 *
    q ^ (t.2 j).toNat) ∈ avoidsAtomSubsemiring k
  apply Subsemiring.nsmul_mem
  apply Subsemiring.mul_mem
  · exact avoidsAtom_single k _ 1 (hE t ht)
  · exact Subsemiring.pow_mem _ hq _

theorem avoidsAtom_starStep {A I : Type*} [DecidableEq I] (k : A)
    (E C : I → PositiveLaurent (FreeAbelianGroup A) I)
    (hE : ∀ i, AvoidsAtom k (E i)) (hC : ∀ i, AvoidsAtom k (C i)) (j i : I) :
    AvoidsAtom k (positiveStarStep E C j i) := by
  unfold positiveStarStep
  split
  · exact hE i
  · exact Subsemiring.mul_mem (avoidsAtomSubsemiring k) (hC i)
      (avoidsAtom_substitute k (hE i) (avoidsAtom_setZero k (hE j) i) j)

theorem avoidsAtom_starIterate {A I : Type*} [DecidableEq I] (k : A)
    (E : I → PositiveLaurent (FreeAbelianGroup A) I)
    (C : ℕ → I → PositiveLaurent (FreeAbelianGroup A) I) (labels : ℕ → I)
    (hE : ∀ i, AvoidsAtom k (E i)) (n : ℕ)
    (hC : ∀ t < n, ∀ i, AvoidsAtom k (C t i)) (i : I) :
    AvoidsAtom k (positiveStarIterate E C labels n i) := by
  induction n generalizing i with
  | zero => exact hE i
  | succ n ih =>
    exact avoidsAtom_starStep k _ _
      (fun j ↦ ih (fun t ht ↦ hC t (Nat.lt_trans ht (Nat.lt_succ_self n))) j)
      (hC n (Nat.lt_succ_self n)) _ i

/-- Every basis monomial of a group algebra is a unit. -/
def basisMonomialUnit {R B : Type*} [CommRing R] [AddCommGroup B] (b : B) :
    (AddMonoidAlgebra R B)ˣ where
  val := AddMonoidAlgebra.single b 1
  inv := AddMonoidAlgebra.single (-b) 1
  val_inv := by simp [AddMonoidAlgebra.single_mul_single, AddMonoidAlgebra.one_def]
  inv_val := by simp [AddMonoidAlgebra.single_mul_single, AddMonoidAlgebra.one_def]

section Family
variable {G M L : Type*} [AddCommGroup G] [AddCommGroup M]

/-- The integer Laurent ring in the original mutable exponents and every free family atom except
k.
-/
abbrev FamilyCoefficientRing (p : L → AddMonoidAlgebra ℕ (G × M)) (k : FamilyAtom p) :=
  AddMonoidAlgebra ℤ (M × ({a // a ≠ k} →₀ ℤ))

/-- The free coefficient-occurrence lift of a family member, with natural coefficients cast to
integers.
-/
def integerFamilyLift (p : L → AddMonoidAlgebra ℕ (G × M)) (l : L) :=
  positiveCast (familyAtomLift p l)

omit [AddCommGroup G] in
theorem integerFamilyLift_sum (p : L → AddMonoidAlgebra ℕ (G × M)) (l : L) :
    integerFamilyLift p l = ∑ a : PositiveAtom (p l),
      AddMonoidAlgebra.single (FreeAbelianGroup.of (⟨l, a⟩ : FamilyAtom p), a.1.val.2) (1 : ℤ) := by
  simp [integerFamilyLift, positiveCast, familyAtomLift]

/-- The sum of the other coefficient occurrences in the selected family member, after separating
its chosen atom.
-/
def familyAtomRest (p : L → AddMonoidAlgebra ℕ (G × M))
    [instAtom : DecidableEq (FamilyAtom p)] (l : L)
    (a₀ : PositiveAtom (p l)) : FamilyCoefficientRing p ⟨l, a₀⟩ := by
  classical
  exact ∑ a ∈ Finset.univ.erase a₀,
    AddMonoidAlgebra.single
      (a.1.val.2, (@splitExponents (FamilyAtom p) instAtom (⟨l, a₀⟩ : FamilyAtom p)
        (Finsupp.single (⟨l, a⟩ : FamilyAtom p) 1)).2) 1

omit [AddCommGroup G] in
/-- The actual atom lift is linear in each chosen fresh atom, with a unit monomial coefficient. -/
theorem integerFamilyLift_linear (p : L → AddMonoidAlgebra ℕ (G × M))
    [DecidableEq (FamilyAtom p)] (l : L)
    (a₀ : PositiveAtom (p l)) :
    let k : FamilyAtom p := ⟨l, a₀⟩
    atomLaurentSplit k (integerFamilyLift p l) =
      LaurentPolynomial.C (basisMonomialUnit (R := ℤ)
        (a₀.1.val.2, (0 : {a : FamilyAtom p // a ≠ k} →₀ ℤ)) : FamilyCoefficientRing p k) *
        LaurentPolynomial.T 1 + LaurentPolynomial.C (familyAtomRest p l a₀) := by
  classical
  dsimp only
  rw [integerFamilyLift_sum, map_sum]
  rw [← Finset.add_sum_erase _ _ (Finset.mem_univ a₀)]
  congr 1
  · rw [atomLaurentSplit_single]
    simp only [FreeAbelianGroup.toFinsupp_of, Finsupp.single_eq_same, splitExponents_chosen]
    exact LaurentPolynomial.single_eq_C_mul_T _ _
  · simp only [familyAtomRest, map_sum]
    apply Finset.sum_congr rfl
    intro a ha
    have haa : a ≠ a₀ := (Finset.mem_erase.mp ha).1
    have htag : (⟨l, a⟩ : FamilyAtom p) ≠ ⟨l, a₀⟩ := by
      intro htag
      exact haa (by simpa using htag)
    exact atomLaurentSplit_other _ _ htag _ _

/-- A family member expressed in the coefficient ring with the chosen fresh atom coordinate
removed.
-/
def familyOtherCoefficient (p : L → AddMonoidAlgebra ℕ (G × M))
    [instAtom : DecidableEq (FamilyAtom p)] (k : FamilyAtom p) (j : L) :
    FamilyCoefficientRing p k :=
  ∑ a : PositiveAtom (p j), AddMonoidAlgebra.single
    (a.1.val.2, (@splitExponents (FamilyAtom p) instAtom k
      (Finsupp.single (⟨j, a⟩ : FamilyAtom p) 1)).2) 1

omit [AddCommGroup G] in
theorem integerFamilyLift_other (p : L → AddMonoidAlgebra ℕ (G × M))
    [DecidableEq (FamilyAtom p)] (k : FamilyAtom p) (j : L) (hjk : j ≠ k.1) :
    atomLaurentSplit k (integerFamilyLift p j) =
      LaurentPolynomial.C (familyOtherCoefficient p k j) := by
  rw [integerFamilyLift_sum, map_sum]
  simp only [familyOtherCoefficient, map_sum]
  apply Finset.sum_congr rfl
  intro a ha
  apply atomLaurentSplit_other
  intro heq
  exact hjk (congrArg Sigma.fst heq)

theorem integerFamilyLift_ne_zero (p : L → AddMonoidAlgebra ℕ (G × M)) (j : L)
    (hp : p j ≠ 0) : integerFamilyLift p j ≠ 0 := by
  intro hzero
  have hz : familyAtomLift p j = 0 := positiveCast_injective (by simpa [integerFamilyLift] using
    hzero)
  apply hp
  rw [← familyAtomLift_specializes p j, hz, map_zero]

theorem positiveAtom_nonempty (q : AddMonoidAlgebra ℕ (G × M)) (hq : q ≠ 0) :
    Nonempty (PositiveAtom q) := by
  have hc : q.coeff ≠ 0 := fun hz ↦ hq (AddMonoidAlgebra.coeff_injective (by simpa using hz))
  obtain ⟨m, hm⟩ := Finsupp.support_nonempty_iff.mpr hc
  exact ⟨⟨⟨m, hm⟩, ⟨0, Nat.pos_of_ne_zero (Finsupp.mem_support_iff.mp hm)⟩⟩⟩

/-- Fresh atoms at different input locations give the actual coprimality certificate. -/
theorem integerFamilyLift_relPrime
    [IsAddTorsionFree M] (p : L → AddMonoidAlgebra ℕ (G × M))
    (l j : L) (hlj : l ≠ j)
    (a₀ : PositiveAtom (p l)) (hpj : p j ≠ 0) :
    IsRelPrime (integerFamilyLift p l) (integerFamilyLift p j) := by
  classical
  let k : FamilyAtom p := ⟨l, a₀⟩
  let : IsDomain (FamilyCoefficientRing p k) := groupRing_isDomain _
  have hq : familyOtherCoefficient p k j ≠ 0 := by
    intro hz
    have h := integerFamilyLift_other p k j hlj.symm
    rw [hz, map_zero] at h
    exact integerFamilyLift_ne_zero p j hpj ((atomLaurentSplit k).injective (by simpa using h))
  have hh := genericLinear_laurent_relPrime_constant
    (basisMonomialUnit (R := ℤ) (a₀.1.val.2, (0 : {a : FamilyAtom p // a ≠ k} →₀ ℤ)))
    (familyAtomRest p l a₀) (familyOtherCoefficient p k j) hq
  rw [← integerFamilyLift_linear p l a₀, ← integerFamilyLift_other p k j hlj.symm] at hh
  exact IsRelPrime.of_map (atomLaurentSplit k) hh

/-- Pairwise coprimality of different nonzero input lifts, with the fresh atom chosen internally. -/
theorem integerFamilyLift_pairwise_relPrime
    [IsAddTorsionFree M] (p : L → AddMonoidAlgebra ℕ (G × M))
    (l j : L) (hlj : l ≠ j)
    (hpl : p l ≠ 0) (hpj : p j ≠ 0) :
    IsRelPrime (integerFamilyLift p l) (integerFamilyLift p j) := by
  classical
  obtain ⟨a₀⟩ := positiveAtom_nonempty (p l) hpl
  exact integerFamilyLift_relPrime p l j hlj a₀ hpj

omit [AddCommGroup G] in
theorem familyAtomLift_avoids_other (p : L → AddMonoidAlgebra ℕ (G × M))
    (k : FamilyAtom p) (j : L) (hjk : j ≠ k.1) :
    AvoidsAtom k (familyAtomLift p j) := by
  classical
  change familyAtomLift p j ∈ avoidsAtomSubsemiring k
  unfold familyAtomLift
  apply Subsemiring.sum_mem
  intro a ha
  apply avoidsAtom_single
  have htag : (⟨j, a⟩ : FamilyAtom p) ≠ k := fun heq ↦ hjk (congrArg Sigma.fst heq)
  simp [htag.symm]

omit [AddCommGroup G] in
/-- The first-star exchange lift is coprime to any nonzero positive expression avoiding
one selected atom of that exchange lift. -/
theorem integerFamilyLift_relPrime_fresh
    [IsAddTorsionFree M] (p : L → AddMonoidAlgebra ℕ (G × M))
    (l : L) (a₀ : PositiveAtom (p l))
    (q : AddMonoidAlgebra ℕ (FreeAbelianGroup (FamilyAtom p) × M))
    (hq : q ≠ 0) (hfresh : AvoidsAtom (⟨l, a₀⟩ : FamilyAtom p) q) :
    IsRelPrime (integerFamilyLift p l) (positiveCast q) := by
  classical
  let k : FamilyAtom p := ⟨l, a₀⟩
  let : IsDomain (FamilyCoefficientRing p k) := groupRing_isDomain _
  have hcast : ∀ t ∈ (positiveCast q).coeff.support, t.1.toFinsupp k = 0 := by
    intro t ht
    apply hfresh t
    simpa [positiveCast] using ht
  obtain ⟨b, hb⟩ := atomLaurentSplit_avoiding k (positiveCast q) hcast
  have hb0 : b ≠ 0 := by
    intro hz
    rw [hz, map_zero] at hb
    have hqz : positiveCast q = 0 := (atomLaurentSplit k).injective (by simpa using hb)
    exact hq (positiveCast_injective (by simpa using hqz))
  have hh := genericLinear_laurent_relPrime_constant
    (basisMonomialUnit (R := ℤ) (a₀.1.val.2, (0 : {a : FamilyAtom p // a ≠ k} →₀ ℤ)))
    (familyAtomRest p l a₀) b hb0
  rw [← integerFamilyLift_linear p l a₀, ← hb] at hh
  exact IsRelPrime.of_map (atomLaurentSplit k) hh

end Family

/-- The two first-star relative-primality certificates follow from disjoint input locations
for E, Q, and the correction H, after the actual zero specialization and inverse substitution. -/
theorem firstStar_relPrime_certificates
    {G I L : Type*} [AddCommGroup G]
    (p : L → PositiveLaurent G I)
    (lE lQ lH : L) (hEQ : lQ ≠ lE) (hEH : lH ≠ lE)
    (hE : p lE ≠ 0) (i j : I)
    (hq : positiveSetZero (familyAtomLift p lQ) i ≠ 0)
    (hA : positiveSubstitute (familyAtomLift p lH)
      (positiveSetZero (familyAtomLift p lQ) i) j ≠ 0) :
    IsRelPrime (integerFamilyLift p lE)
      (positiveCast (positiveSetZero (familyAtomLift p lQ) i)) ∧
    IsRelPrime (integerFamilyLift p lE)
      (positiveCast (positiveSubstitute (familyAtomLift p lH)
        (positiveSetZero (familyAtomLift p lQ) i) j)) := by
  classical
  obtain ⟨a₀⟩ := positiveAtom_nonempty (p lE) hE
  let k : FamilyAtom p := ⟨lE, a₀⟩
  have hqfresh := avoidsAtom_setZero k (familyAtomLift_avoids_other p k lQ hEQ) i
  have hAfresh := avoidsAtom_substitute k
    (familyAtomLift_avoids_other p k lH hEH) hqfresh j
  exact ⟨integerFamilyLift_relPrime_fresh p lE a₀ _ hq hqfresh,
    integerFamilyLift_relPrime_fresh p lE a₀ _ hA hAfresh⟩

/-- Nonzero correction input and q0 already ensure the nonzero substituted correction. -/
theorem firstStar_relPrime_certificates_of_nonzero
    {G I L : Type*} [AddCommGroup G]
    (p : L → PositiveLaurent G I)
    (lE lQ lH : L) (hEQ : lQ ≠ lE) (hEH : lH ≠ lE)
    (hE : p lE ≠ 0) (hH : p lH ≠ 0) (i j : I)
    (hq : positiveSetZero (familyAtomLift p lQ) i ≠ 0) :
    IsRelPrime (integerFamilyLift p lE)
      (positiveCast (positiveSetZero (familyAtomLift p lQ) i)) ∧
    IsRelPrime (integerFamilyLift p lE)
      (positiveCast (positiveSubstitute (familyAtomLift p lH)
        (positiveSetZero (familyAtomLift p lQ) i) j)) := by
  classical
  have hHl : familyAtomLift p lH ≠ 0 := by
    intro hz
    apply hH
    rw [← familyAtomLift_specializes p lH, hz, map_zero]
  exact firstStar_relPrime_certificates p lE lQ lH hEQ hEH hE i j hq
    (positiveSubstitute_ne_zero hHl hq j)

/-- First-star genericity from input conditions alone: independent location tags, nonzero
E and H, and no mutable variable factor in Q. -/
theorem firstStar_relPrime_certificates_of_inputs
    {G I L : Type*} [AddCommGroup G]
    (p : L → PositiveLaurent G I)
    (lE lQ lH : L) (hEQ : lQ ≠ lE) (hEH : lH ≠ lE)
    (hE : p lE ≠ 0) (hH : p lH ≠ 0) (hQ : PositiveNoVariableFactor (p lQ))
    (i j : I) :
    IsRelPrime (integerFamilyLift p lE)
      (positiveCast (positiveSetZero (familyAtomLift p lQ) i)) ∧
    IsRelPrime (integerFamilyLift p lE)
      (positiveCast (positiveSubstitute (familyAtomLift p lH)
        (positiveSetZero (familyAtomLift p lQ) i) j)) := by
  classical
  have hQl : PositiveNoVariableFactor (familyAtomLift p lQ) := by
    unfold PositiveNoVariableFactor at *
    rwa [familyAtomLift_mutableSupport]
  exact firstStar_relPrime_certificates_of_nonzero p lE lQ lH hEQ hEH hE hH i j
    (positiveNoVariableFactor_setZero_ne_zero _ hQl i)

end
end TauCeti.Laurent
