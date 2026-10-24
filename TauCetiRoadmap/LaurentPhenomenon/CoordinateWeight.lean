/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.PositiveWeight
public import TauCetiRoadmap.LaurentPhenomenon.PositiveRealization

/-! Frozen orders of the actual subtraction-free coordinate constructions. -/

@[expose] public section
noncomputable section
namespace TauCeti.Laurent
variable {G I : Type*} [AddCommGroup G] [IsAddTorsionFree G] [DecidableEq I]

/-- Extend a coefficient-group weight to total exponents by ignoring the mutable exponent vector. -/
def coefficientWeight (w : G →+ ℤ) : (G × (I →₀ ℤ)) →+ ℤ :=
  w.comp (AddMonoidHom.fst _ _)

omit [DecidableEq I] [IsAddTorsionFree G] in
@[simp] theorem coefficientWeight_apply (w : G →+ ℤ) (g : G) (a : I →₀ ℤ) :
    coefficientWeight w (g, a) = w g := rfl

namespace CoordinateExpression
open PositiveExpression
variable (w : G →+ ℤ)

omit [DecidableEq I] [IsAddTorsionFree G] in
@[simp] theorem order_one : (one (G := G × (I →₀ ℤ))).order (coefficientWeight w) = 0 := by
  simp [one]

omit [DecidableEq I] in
theorem order_powNat (x : CoordinateExpression G I) (n : ℕ) :
    (powNat x n).order (coefficientWeight w) = n * x.order (coefficientWeight w) := by
  classical
  induction n with
  | zero => simp [powNat]
  | succ n ih => simp [powNat, ih, Nat.cast_add, add_mul]; omega

omit [DecidableEq I] in
theorem order_powInt (x : CoordinateExpression G I) (n : ℤ) :
    (powInt x n).order (coefficientWeight w) = n * x.order (coefficientWeight w) := by
  classical
  cases n with
  | ofNat n => simp [powInt, order_powNat]
  | negSucc n => simp [powInt, order_powNat, Int.negSucc_eq, add_mul]

omit [DecidableEq I] in
theorem order_product_zero {A : Type*} (s : Finset A) (f : A → CoordinateExpression G I)
    (hf : ∀ a ∈ s, (f a).order (coefficientWeight w) = 0) :
    (product s f).order (coefficientWeight w) = 0 := by
  classical
  have hlist (l : List A) (hl : ∀ a ∈ l, (f a).order (coefficientWeight w) = 0) :
      (l.foldr (fun t x => .mul (f t) x) one).order (coefficientWeight w) = 0 := by
    induction l with
    | nil => simp
    | cons a l ih =>
      simp only [List.foldr_cons, PositiveExpression.order_mul]
      rw [hl a (by simp), ih (fun b hb => hl b (by simp [hb]))]
      rfl
  exact hlist s.toList (by simpa using hf)

omit [DecidableEq I] in
private theorem order_fold_sum_nonneg {A : Type*} (l : List A)
    (f : A → CoordinateExpression G I) (z : CoordinateExpression G I)
    (hf : ∀ a ∈ l, 0 ≤ (f a).order (coefficientWeight w))
    (hz : 0 ≤ z.order (coefficientWeight w)) :
    0 ≤ (l.foldr (fun t x => .add (f t) x) z).order (coefficientWeight w) := by
  induction l with
  | nil => exact hz
  | cons a l ih =>
    simp only [List.foldr_cons, PositiveExpression.order_add]
    exact le_min (hf a (by simp)) (ih (fun b hb => hf b (by simp [hb])))

omit [DecidableEq I] in
theorem order_sum_nonneg {A : Type*} (s : Finset A) (hs : s.Nonempty)
    (f : A → CoordinateExpression G I)
    (hf : ∀ a ∈ s, 0 ≤ (f a).order (coefficientWeight w)) :
    0 ≤ (sum s hs f).order (coefficientWeight w) := by
  classical
  exact order_fold_sum_nonneg w _ f _
    (fun a ha => hf a (Finset.mem_of_mem_erase (Finset.mem_toList.mp ha)))
    (hf hs.choose hs.choose_spec)

omit [DecidableEq I] in
private theorem order_fold_sum_le_last {A : Type*} (l : List A)
    (f : A → CoordinateExpression G I) (z : CoordinateExpression G I) :
    (l.foldr (fun t x => .add (f t) x) z).order (coefficientWeight w) ≤
      z.order (coefficientWeight w) := by
  induction l with
  | nil => exact le_rfl
  | cons a l ih =>
    simp only [List.foldr_cons, PositiveExpression.order_add]
    exact (min_le_right _ _).trans ih

omit [DecidableEq I] in
private theorem order_fold_sum_le_member {A : Type*} (l : List A)
    (f : A → CoordinateExpression G I) (z : CoordinateExpression G I)
    (a : A) (ha : a ∈ l) :
    (l.foldr (fun t x => .add (f t) x) z).order (coefficientWeight w) ≤
      (f a).order (coefficientWeight w) := by
  induction l with
  | nil => simp at ha
  | cons b l ih =>
    simp only [List.foldr_cons, PositiveExpression.order_add]
    rcases List.mem_cons.mp ha with rfl | ha
    · exact min_le_left _ _
    · exact (min_le_right _ _).trans (ih ha)

omit [DecidableEq I] in
theorem order_sum_le {A : Type*} (s : Finset A) (hs : s.Nonempty)
    (f : A → CoordinateExpression G I) (a : A) (ha : a ∈ s) :
    (sum s hs f).order (coefficientWeight w) ≤ (f a).order (coefficientWeight w) := by
  classical
  by_cases h : a = hs.choose
  · subst a
    exact order_fold_sum_le_last w _ f _
  · exact order_fold_sum_le_member w _ f _ a
      (Finset.mem_toList.mpr (Finset.mem_erase.mpr ⟨h, ha⟩))

end CoordinateExpression

omit [DecidableEq I] in
theorem translatedTerm_order_of_zero (w : G →+ ℤ) (t : G × (I →₀ ℤ))
    (n : ℕ) (hn : n ≠ 0) (x : I → CoordinateExpression G I)
    (hx : ∀ i, (x i).order (coefficientWeight w) = 0) :
    (translatedTerm t n hn x).order (coefficientWeight w) = w t.1 := by
  classical
  simp only [translatedTerm, PositiveExpression.order_mul, PositiveExpression.order_atom]
  rw [positiveOrder_single _ _ n hn]
  have h := CoordinateExpression.order_product_zero w t.2.support
    (fun i => PositiveExpression.powInt (x i) (t.2 i))
    (fun i _ => by rw [CoordinateExpression.order_powInt, hx i, mul_zero])
  rw [h, add_zero]
  rfl

omit [DecidableEq I] in
/-- If a positive exchange has nonnegative frozen weights and contains a term
of frozen weight zero, mutation of coordinates of order zero retains order zero. -/
theorem translatePositive_order_zero (w : G →+ ℤ)
    (E : PositiveLaurent G I) (hE : E ≠ 0) (x : I → CoordinateExpression G I)
    (hx : ∀ i, (x i).order (coefficientWeight w) = 0)
    (hnonneg : ∀ t ∈ E.coeff.support, 0 ≤ w t.1)
    (hzero : ∃ t ∈ E.coeff.support, w t.1 = 0) :
    (translatePositive E hE x).order (coefficientWeight w) = 0 := by
  classical
  have ht (t) (h : t ∈ E.coeff.support) :
      (translatedTermTotal E x t).order (coefficientWeight w) = w t.1 := by
    rw [translatedTermTotal, dite_eq_right (Finsupp.mem_support_iff.mp h)]
    exact translatedTerm_order_of_zero w t _ _ x hx
  apply le_antisymm
  · obtain ⟨t, hts, htz⟩ := hzero
    have h := CoordinateExpression.order_sum_le w E.coeff.support
      (positive_support_nonempty E hE) (translatedTermTotal E x) t hts
    rwa [ht t hts, htz] at h
  · exact CoordinateExpression.order_sum_nonneg w E.coeff.support
      (positive_support_nonempty E hE) (translatedTermTotal E x)
      (fun t h => by rw [ht t h]; exact hnonneg t h)

theorem mutateCoordinateExpressions_order_zero (w : G →+ ℤ)
    (E : PositiveLaurent G I) (hE : E ≠ 0) (x : I → CoordinateExpression G I)
    (hx : ∀ i, (x i).order (coefficientWeight w) = 0)
    (hnonneg : ∀ t ∈ E.coeff.support, 0 ≤ w t.1)
    (hzero : ∃ t ∈ E.coeff.support, w t.1 = 0) (i j : I) :
    (mutateCoordinateExpressions E hE i x j).order (coefficientWeight w) = 0 := by
  by_cases h : j = i
  · subst j
    simp only [mutateCoordinateExpressions, Function.update_self, PositiveExpression.order_mul,
      PositiveExpression.order_inv, translatePositive_order_zero w E hE x hx hnonneg hzero, hx]
    rfl
  · simpa [mutateCoordinateExpressions, Function.update_of_ne h] using hx j

end TauCeti.Laurent
