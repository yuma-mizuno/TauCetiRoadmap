/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.PositiveSubstitution
public import Mathlib.Tactic.Abel

/-! # Binomial Correction -/

@[expose] public section


noncomputable section
namespace TauCeti.Laurent
variable {G I : Type*} [AddCommGroup G] [DecidableEq I]

omit [DecidableEq I] in
theorem positiveSubstitute_add (E R q : PositiveLaurent G I) (j : I) :
    positiveSubstitute (E + R) q j = positiveSubstitute E q j + positiveSubstitute R q j := by
  classical
  unfold positiveSubstitute
  change (E.coeff + R.coeff).sum _ = _
  exact Finsupp.sum_add_index (fun t _ => map_zero (positiveSubstitutionTerm q j t))
    (fun t _ a b => map_add (positiveSubstitutionTerm q j t) a b)

omit [DecidableEq I] in
@[simp] theorem positiveSubstitute_single (q : PositiveLaurent G I) (j : I)
    (t : G × (I →₀ ℤ)) (n : ℕ) :
    positiveSubstitute (AddMonoidAlgebra.single t n) q j = positiveSubstitutionTerm q j t n := by
  classical
  simp [positiveSubstitute]

omit [DecidableEq I] in
theorem positiveSetZero_add (E R : PositiveLaurent G I) (i : I) :
    positiveSetZero (E + R) i = positiveSetZero E i + positiveSetZero R i := by
  ext t
  by_cases h : t.2 i = 0 <;> simp [positiveSetZero_coeff, h]

omit [DecidableEq I] in
theorem positiveSetZero_single (t : G × (I →₀ ℤ)) (n : ℕ) (i : I) :
    positiveSetZero (AddMonoidAlgebra.single t n) i =
      if t.2 i = 0 then AddMonoidAlgebra.single t n else 0 := by
  by_cases h : t.2 i = 0
  · simp [positiveSetZero, Finsupp.filter_single_of_pos, h]
  · simp [positiveSetZero, Finsupp.filter_single_of_neg, h]


omit [DecidableEq I] in
theorem positiveSubstitute_of_independent (E q : PositiveLaurent G I)
    (j : I) (hE : PositiveIndependent E j) : positiveSubstitute E q j = E := by
  classical
  conv_rhs => rw [← AddMonoidAlgebra.sum_coeff_single E]
  simp only [positiveSubstitute, Finsupp.sum]
  apply Finset.sum_congr rfl
  intro t ht
  have hj : t.2 j = 0 := by
    apply hE t.2
    simp only [mutableSupport, Finset.mem_image]
    exact ⟨t, ht, rfl⟩
  rcases t with ⟨g, a⟩
  simp [positiveSubstitutionTerm, reflectedExponent, hj, AddMonoidAlgebra.smul_single]

omit [DecidableEq I] in
/-- The exact monomial correction identity, retaining both summands even when
their exponents coincide. The balance is in the coefficient-and-mutable lattice. -/
theorem binomial_positive_correction
    (a b q a' b' : G × (I →₀ ℤ)) (j : I) (d : ℕ)
    (ha : a.2 j = d) (hb : b.2 j = 0)
    (hbalance : (a' - b) + (a.1, reflectedExponent j a.2) + d • q = b') :
    AddMonoidAlgebra.single a' 1 + AddMonoidAlgebra.single b' 1 =
      positivePropagate (AddMonoidAlgebra.single (a' - b) 1)
        (AddMonoidAlgebra.single a 1 + AddMonoidAlgebra.single b 1)
        (AddMonoidAlgebra.single q 1) j := by
  classical
  rw [positivePropagate, positiveSubstitute_add]
  simp only [positiveSubstitute_single, positiveSubstitutionTerm, multiplesHom_apply,
    one_nsmul, ha, hb, Int.toNat_natCast, Int.toNat_zero, pow_zero, mul_one,
    AddMonoidAlgebra.single_pow, mul_add, AddMonoidAlgebra.single_mul_single, one_mul,
    mul_one]
  have hbr : (b.1, reflectedExponent j b.2) = b := by
    simp [reflectedExponent, hb]
  rw [hbr, sub_add_cancel, ← add_assoc, hbalance, add_comm]
  simp

end TauCeti.Laurent
