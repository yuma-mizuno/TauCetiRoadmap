/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.ExchangeMatrix
public import TauCetiRoadmap.ClusterAlgebras.Normalization
public import TauCetiRoadmap.LaurentPhenomenon.BinomialCorrection

/-! # Normalized Pattern -/

@[expose] public section

open TauCeti.Laurent

noncomputable section
namespace TauCeti.Cluster
open CoefficientSemifield
variable {P I : Type*} [CoefficientSemifield P] [Finite I] [DecidableEq I]

/-- Local normalized seed data before and after one genuine mutation.
    The fields contain matrix/coefficient laws, not correction identities or Laurent conclusions. -/
structure NormalizedLocalMutation (P I : Type*) [CoefficientSemifield P] [DecidableEq I] (i j : I)
  where
  distinct : i ≠ j
  /-- The exchange matrix before mutation in direction j. -/
  before : I → I → ℤ
  /-- The exchange matrix after mutation in direction j. -/
  after : I → I → ℤ
  /-- The coefficient tuple before the local mutation. -/
  coefficient : I → P
  /-- The coefficient tuple after the local mutation. -/
  coefficientAfter : I → P
  diagonal : ∀ k, before k k = 0
  diagonalAfter : ∀ k, after k k = 0
  signSkew : ∀ h k, SignSkewAt (before h k) (before k h)
  matrixLaw : after = matrixMutation before j
  coefficientLaw : coefficientAfter i = coefficientMutation (coefficient i) (coefficient j)
    (coefficient j + 1) (before j i)

private theorem positivePart_difference (a : ℤ) : positivePart a - positivePart (-a) = a := by
  unfold positivePart
  omega

/-- The finite exponent vector given by the positive part of a signed matrix column. -/
def signedColumnExponent (B : I → I → ℤ) (i : I) (δ : ℤ) : I →₀ ℤ :=
  columnPositiveExponent (fun h => δ * B h i)

omit [DecidableEq I] in
@[simp] theorem signedColumnExponent_apply (B : I → I → ℤ) (i : I) (δ : ℤ) (h : I) :
    signedColumnExponent B i δ h = positivePart (δ * B h i) := by
  classical
  simp [signedColumnExponent]

namespace NormalizedLocalMutation
variable {i j : I} (D : NormalizedLocalMutation P I i j)

theorem selected_q_exponent_zero (δ d : ℤ) (hδ : δ = 1 ∨ δ = -1) (hd : 0 < d)
    (hb : D.before j i = δ * d) :
    signedColumnExponent D.before j δ i = 0 := by
  have hsign := D.signSkew i j
  rw [signedColumnExponent_apply]
  rcases hδ with rfl | rfl <;> rcases hsign with h | h | h <;>
    simp only [one_mul, neg_one_mul] at * <;> unfold positivePart <;> omega

/-- The complete mutable-lattice balance, including the reflected j-exponent. -/
theorem signed_exponent_balance (δ : ℤ) (d : ℕ) (hδ : δ = 1 ∨ δ = -1)
    (hd : 0 < d) (hb : D.before j i = δ * (d : ℤ)) :
    (signedColumnExponent D.after i (-δ) - signedColumnExponent D.before i (-δ)) +
        reflectedExponent j (signedColumnExponent D.before i δ) +
        d • signedColumnExponent D.before j δ = signedColumnExponent D.after i δ := by
  ext h
  have hd' : 0 < (d : ℤ) := by exact_mod_cast hd
  have hqi := D.selected_q_exponent_zero δ d hδ hd' hb
  have hmut := congrFun (congrFun D.matrixLaw h) i
  by_cases hhi : h = i
  · subst h
    simp [signedColumnExponent_apply, reflectedExponent, D.distinct.symm,
      D.diagonal, D.diagonalAfter, hqi, positivePart]
  · by_cases hhj : h = j
    · subst h
      have hji : D.after j i = -D.before j i := by
        simpa [matrixMutation] using hmut
      rcases hδ with rfl | rfl <;>
        simp [signedColumnExponent_apply, reflectedExponent, hji, hb, D.diagonal,
          positivePart] <;>
            omega
    · have hm : D.after h i = D.before h i +
          positivePart (D.before h j) * positivePart (D.before j i) -
            positivePart (-D.before h j) * positivePart (-D.before j i) := by
        simpa [matrixMutation, hhj, D.distinct] using hmut
      have hi := signed_matrix_increment (D.before h j) (D.before j i) δ d hδ
        (le_of_lt hd') hb
      have ho := positivePart_difference (δ * D.before h i)
      have hn := positivePart_difference (δ * D.after h i)
      simp only [Finsupp.add_apply, Finsupp.sub_apply, reflectedExponent,
        signedColumnExponent_apply, Finsupp.smul_apply, nsmul_eq_mul,
        Finsupp.single_apply, Ne.symm hhj, ite_false, sub_zero]
      rcases hδ with rfl | rfl <;> simp only [one_mul, neg_one_mul, neg_neg] at * <;> omega

/-- The coefficient-group exponent and mutable exponent vector of one signed exchange term. -/
def normalizedTerm (y : P) (B : I → I → ℤ) (i : I) (δ : ℤ) :
    Additive P × (I →₀ ℤ) :=
  (Additive.ofMul (normalizedSigned y δ), signedColumnExponent B i δ)

omit [DecidableEq I] in
private theorem seedExchange_signed (y : P) (B : I → I → ℤ) (i : I)
    (δ : ℤ) (hδ : δ = 1 ∨ δ = -1) :
    seedExchange y (fun h => B h i) =
      AddMonoidAlgebra.single (normalizedTerm y B i δ) 1 +
        AddMonoidAlgebra.single (normalizedTerm y B i (-δ)) 1 := by
  classical
  rcases hδ with rfl | rfl
  · simp [seedExchange, normalizedTerm, normalizedSigned, signedColumnExponent]
  · simp only [seedExchange, normalizedTerm, normalizedSigned, neg_neg, ite_true]
    simpa [signedColumnExponent] using
      (add_comm
        (AddMonoidAlgebra.single (Additive.ofMul (normalizedPositive y), columnPositiveExponent (fun
          h => B h i)) 1)
        (AddMonoidAlgebra.single (Additive.ofMul (normalizedNegative y), columnPositiveExponent (fun
          h => -B h i)) 1))

theorem normalized_q0 (δ : ℤ) (d : ℕ) (hδ : δ = 1 ∨ δ = -1) (hd : 0 < d)
    (hb : D.before j i = δ * (d : ℤ)) :
    positiveSetZero (seedExchange (D.coefficient j) (fun h => D.before h j)) i =
      AddMonoidAlgebra.single (normalizedTerm (D.coefficient j) D.before j δ) 1 := by
  rw [seedExchange_signed _ _ _ δ hδ, positiveSetZero_add, positiveSetZero_single,
    positiveSetZero_single]
  have hzero := D.selected_q_exponent_zero δ d hδ (by exact_mod_cast hd) hb
  have hsign := D.signSkew i j
  have hnonzero : signedColumnExponent D.before j (-δ) i ≠ 0 := by
    rcases hδ with rfl | rfl <;> rcases hsign with h | h | h <;>
      simp only [one_mul, neg_one_mul, neg_neg] at * <;>
      simp only [signedColumnExponent_apply, positivePart] <;> omega
  simp only [normalizedTerm, hzero, hnonzero, ite_true, ite_false, add_zero]

/-- Coefficient and mutable-exponent balances together give the actual lattice identity. -/
theorem normalized_term_balance (δ : ℤ) (d : ℕ) (hδ : δ = 1 ∨ δ = -1)
    (hd : 0 < d) (hb : D.before j i = δ * (d : ℤ)) :
    (normalizedTerm (D.coefficientAfter i) D.after i (-δ) -
        normalizedTerm (D.coefficient i) D.before i (-δ)) +
      ((normalizedTerm (D.coefficient i) D.before i δ).1,
        reflectedExponent j (normalizedTerm (D.coefficient i) D.before i δ).2) +
      d • normalizedTerm (D.coefficient j) D.before j δ =
        normalizedTerm (D.coefficientAfter i) D.after i δ := by
  apply Prod.ext
  · change (normalizedSigned (D.coefficientAfter i) (-δ) /
        normalizedSigned (D.coefficient i) (-δ)) * normalizedSigned (D.coefficient i) δ *
      normalizedSigned (D.coefficient j) δ ^ d = normalizedSigned (D.coefficientAfter i) δ
    rw [D.coefficientLaw]
    simpa only [zpow_natCast] using normalized_mutation_balance (D.coefficient i) (D.coefficient j)
      (D.before j i) δ d hδ (by positivity) hb
  · exact D.signed_exponent_balance δ d hδ hd hb

/-- The monomial ratio of the corresponding exchange terms before and after mutation. -/
def signedCorrection (δ : ℤ) : PositiveLaurent (Additive P) I :=
  AddMonoidAlgebra.single (normalizedTerm (D.coefficientAfter i) D.after i (-δ) -
    normalizedTerm (D.coefficient i) D.before i (-δ)) 1

theorem signedCorrection_independent (δ : ℤ) : PositiveIndependent (D.signedCorrection δ) i := by
  intro a ha
  rw [signedCorrection, mutableSupport_single_one] at ha
  rw [Finset.mem_singleton.mp ha]
  simp [normalizedTerm, D.diagonal, D.diagonalAfter, positivePart]

theorem signedCorrection_nonnegative (δ : ℤ) (d : ℕ) (hδ : δ = 1 ∨ δ = -1)
    (hb : D.before j i = δ * (d : ℤ)) : PositiveNonnegativeAt (D.signedCorrection δ) j := by
  intro a ha
  rw [signedCorrection, mutableSupport_single_one] at ha
  rw [Finset.mem_singleton.mp ha]
  have hji : D.after j i = -D.before j i := by
    have hm := congrFun (congrFun D.matrixLaw j) i
    simpa [matrixMutation] using hm
  rcases hδ with rfl | rfl <;>
    simp [normalizedTerm, hji, hb, positivePart]

theorem signedCorrection_identity (δ : ℤ) (d : ℕ) (hδ : δ = 1 ∨ δ = -1)
    (hd : 0 < d) (hb : D.before j i = δ * (d : ℤ)) :
    seedExchange (D.coefficientAfter i) (fun h => D.after h i) =
      positivePropagate (D.signedCorrection δ)
        (seedExchange (D.coefficient i) (fun h => D.before h i))
        (positiveSetZero (seedExchange (D.coefficient j) (fun h => D.before h j)) i) j := by
  have hneg : -δ = 1 ∨ -δ = -1 := by rcases hδ with rfl | rfl <;> simp
  rw [seedExchange_signed _ _ _ (-δ) hneg, seedExchange_signed _ _ _ δ hδ,
    D.normalized_q0 δ d hδ hd hb]
  simp only [neg_neg]
  apply binomial_positive_correction _ _ _ _ _ j d
  · rcases hδ with rfl | rfl <;> simp [normalizedTerm, hb, positivePart]
  · rcases hδ with rfl | rfl <;> simp [normalizedTerm, hb, positivePart]
  · exact D.normalized_term_balance δ d hδ hd hb

theorem zero_correction_identity (hb : D.before j i = 0) :
    seedExchange (D.coefficientAfter i) (fun h => D.after h i) =
      positivePropagate 1 (seedExchange (D.coefficient i) (fun h => D.before h i))
        (positiveSetZero (seedExchange (D.coefficient j) (fun h => D.before h j)) i) j := by
  have hcol : (fun h => D.after h i) = (fun h => D.before h i) := by
    funext h
    have hm := congrFun (congrFun D.matrixLaw h) i
    by_cases hh : h = j
    · subst h
      simpa [matrixMutation, hb] using hm
    · simpa [matrixMutation, hh, D.distinct, hb, positivePart] using hm
  have hy : D.coefficientAfter i = D.coefficient i := by
    simpa [coefficientMutation, hb, positivePart] using D.coefficientLaw
  rw [hy, hcol, positivePropagate, one_mul, positiveSubstitute_of_independent]
  exact seedExchange_independent _ _ j hb

/-- Every actual normalized mutation supplies the finite positive correction
    required by C4; no Laurentness or coprimality hypothesis occurs. -/
theorem correction_exists :
    ∃ H : PositiveLaurent (Additive P) I, H ≠ 0 ∧ PositiveIndependent H i ∧
      PositiveNonnegativeAt H j ∧
      seedExchange (D.coefficientAfter i) (fun h => D.after h i) =
        positivePropagate H (seedExchange (D.coefficient i) (fun h => D.before h i))
          (positiveSetZero (seedExchange (D.coefficient j) (fun h => D.before h j)) i) j := by
  by_cases hb0 : D.before j i = 0
  · refine ⟨1, one_ne_zero, ?_, ?_, D.zero_correction_identity hb0⟩
    · simp [PositiveIndependent, mutableSupport]
    · simp [PositiveNonnegativeAt, mutableSupport]
  · by_cases hbpos : 0 < D.before j i
    · have hnat : ((D.before j i).toNat : ℤ) = D.before j i := Int.toNat_of_nonneg (le_of_lt hbpos)
      have hd : 0 < (D.before j i).toNat := by omega
      refine ⟨D.signedCorrection 1, AddMonoidAlgebra.single_eq_zero.not.mpr one_ne_zero,
        D.signedCorrection_independent 1, ?_, ?_⟩
      · exact D.signedCorrection_nonnegative 1 (D.before j i).toNat (Or.inl rfl)
          (by simpa only [one_mul] using hnat.symm)
      · exact D.signedCorrection_identity 1 (D.before j i).toNat (Or.inl rfl) hd
          (by simpa only [one_mul] using hnat.symm)
    · have hbneg : D.before j i < 0 := by omega
      have hnat : ((-D.before j i).toNat : ℤ) = -D.before j i :=
        Int.toNat_of_nonneg (by omega)
      have hd : 0 < (-D.before j i).toNat := by omega
      have hb : D.before j i = -1 * (((-D.before j i).toNat : ℕ) : ℤ) := by omega
      exact ⟨D.signedCorrection (-1), AddMonoidAlgebra.single_eq_zero.not.mpr one_ne_zero,
        D.signedCorrection_independent (-1),
        D.signedCorrection_nonnegative (-1) _ (Or.inr rfl) hb,
        D.signedCorrection_identity (-1) _ (Or.inr rfl) hd hb⟩

end NormalizedLocalMutation
end TauCeti.Cluster
