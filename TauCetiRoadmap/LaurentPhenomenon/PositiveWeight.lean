/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.LaurentWeight
public import TauCetiRoadmap.LaurentPhenomenon.PositiveFraction

/-! Orders of subtraction-free rational functions. These integer orders are
computed from finite supports, so no analytic valuation or positivity theorem
for cluster expansions is required. -/

@[expose] public section

noncomputable section
namespace TauCeti.Laurent
variable {G : Type*} [AddCommGroup G] [IsAddTorsionFree G]

attribute [local instance] groupRing_isDomain

omit [IsAddTorsionFree G] in
theorem loWeight_mem (w : G →+ ℤ) {p : AddMonoidAlgebra ℤ G} (hp : p ≠ 0) :
    ∃ a ∈ p.coeff.support, w a = loWeight w p hp :=
  exists_mem_support_loWeight w hp

omit [IsAddTorsionFree G] in
theorem le_loWeight_iff (w : G →+ ℤ) {p : AddMonoidAlgebra ℤ G}
    (hp : p ≠ 0) (n : ℤ) :
    n ≤ loWeight w p hp ↔ ∀ a ∈ p.coeff.support, n ≤ w a := by
  constructor
  · intro h a ha
    exact h.trans (loWeight_le_of_mem w hp ha)
  · intro h
    obtain ⟨a, ha, he⟩ := loWeight_mem w hp
    rw [← he]
    exact h a ha

omit [IsAddTorsionFree G] in
theorem mem_support_positiveCast (p : AddMonoidAlgebra ℕ G) (a : G) :
    a ∈ (positiveCast p).coeff.support ↔ a ∈ p.coeff.support := by
  simp [Finsupp.mem_support_iff, positiveCast]

/-- The least supported weight of a nonzero positive polynomial after integer coefficient casting.
-/
def positiveOrder (w : G →+ ℤ) (p : AddMonoidAlgebra ℕ G) (hp : p ≠ 0) : ℤ :=
  loWeight w (positiveCast p) (positiveCast_ne_zero hp)

omit [IsAddTorsionFree G] in
@[simp] theorem positiveOrder_single (w : G →+ ℤ) (a : G) (n : ℕ) (hn : n ≠ 0) :
    positiveOrder w (AddMonoidAlgebra.single a n)
      (AddMonoidAlgebra.single_eq_zero.not.mpr hn) = w a := by
  classical
  simp [positiveOrder, loWeight, positiveCast, hn]

omit [IsAddTorsionFree G] in
@[simp] theorem positiveOrder_one (w : G →+ ℤ) :
    positiveOrder w 1 one_ne_zero = 0 := by
  simp [AddMonoidAlgebra.one_def]

theorem positiveOrder_mul (w : G →+ ℤ) (p q : AddMonoidAlgebra ℕ G)
    (hp : p ≠ 0) (hq : q ≠ 0) :
    positiveOrder w (p * q) (positive_mul_ne_zero hp hq) =
      positiveOrder w p hp + positiveOrder w q hq := by
  unfold positiveOrder
  simpa only [map_mul] using loWeight_mul w (positiveCast_ne_zero hp)
    (positiveCast_ne_zero hq) (mul_ne_zero (positiveCast_ne_zero hp) (positiveCast_ne_zero hq))

omit [IsAddTorsionFree G] in
theorem positiveOrder_add (w : G →+ ℤ) (p q : AddMonoidAlgebra ℕ G)
    (hp : p ≠ 0) (hq : q ≠ 0) :
    positiveOrder w (p + q) (positive_add_ne_zero hp) =
      min (positiveOrder w p hp) (positiveOrder w q hq) := by
  have hs (a : G) : a ∈ (positiveCast (p + q)).coeff.support ↔
      a ∈ (positiveCast p).coeff.support ∨ a ∈ (positiveCast q).coeff.support := by
    rw [mem_support_positiveCast, mem_support_positiveCast, mem_support_positiveCast]
    simp only [Finsupp.mem_support_iff]
    change p.coeff a + q.coeff a ≠ 0 ↔ p.coeff a ≠ 0 ∨ q.coeff a ≠ 0
    omega
  apply le_antisymm
  · apply le_min
    · obtain ⟨a, ha, he⟩ := loWeight_mem w (positiveCast_ne_zero hp)
      exact (loWeight_le_of_mem w (positiveCast_ne_zero (positive_add_ne_zero hp))
        ((hs a).mpr (Or.inl ha))).trans_eq he
    · obtain ⟨a, ha, he⟩ := loWeight_mem w (positiveCast_ne_zero hq)
      exact (loWeight_le_of_mem w (positiveCast_ne_zero (positive_add_ne_zero hp))
        ((hs a).mpr (Or.inr ha))).trans_eq he
  · apply (le_loWeight_iff w (positiveCast_ne_zero (positive_add_ne_zero hp)) _).mpr
    intro a ha
    rcases (hs a).mp ha with ha | ha
    · exact (min_le_left _ _).trans (loWeight_le_of_mem w (positiveCast_ne_zero hp) ha)
    · exact (min_le_right _ _).trans (loWeight_le_of_mem w (positiveCast_ne_zero hq) ha)

/-- The least numerator weight minus the least denominator weight of a positive fraction. -/
def PositiveFraction.order (w : G →+ ℤ) (p : PositiveFraction G) : ℤ :=
  positiveOrder w p.numerator p.numerator_ne_zero -
    positiveOrder w p.denominator p.denominator_ne_zero

theorem PositiveFraction.order_mul (w : G →+ ℤ) (p q : PositiveFraction G) :
    (p.mul q).order w = p.order w + q.order w := by
  dsimp only [order, mul]
  rw [positiveOrder_mul w _ _ p.numerator_ne_zero q.numerator_ne_zero,
    positiveOrder_mul w _ _ p.denominator_ne_zero q.denominator_ne_zero]
  omega

omit [IsAddTorsionFree G] in
theorem PositiveFraction.order_inv (w : G →+ ℤ) (p : PositiveFraction G) :
    p.inv.order w = -p.order w := by
  simp only [order, inv]
  omega

theorem PositiveFraction.order_add (w : G →+ ℤ) (p q : PositiveFraction G) :
    (p.add q).order w = min (p.order w) (q.order w) := by
  dsimp only [order, add]
  rw [positiveOrder_add w _ _ (positive_mul_ne_zero p.numerator_ne_zero q.denominator_ne_zero)
    (positive_mul_ne_zero q.numerator_ne_zero p.denominator_ne_zero),
    positiveOrder_mul w _ _ p.numerator_ne_zero q.denominator_ne_zero,
    positiveOrder_mul w _ _ q.numerator_ne_zero p.denominator_ne_zero,
    positiveOrder_mul w _ _ p.denominator_ne_zero q.denominator_ne_zero]
  omega

omit [IsAddTorsionFree G] in
@[simp] theorem PositiveFraction.order_atom (w : G →+ ℤ)
    (p : AddMonoidAlgebra ℕ G) (hp : p ≠ 0) :
    (PositiveFraction.atom p hp).order w = positiveOrder w p hp := by
  simp [order, atom]

/-- Orders depend only on the rational function, including when positive
representatives have different numerator and denominator supports. -/
theorem PositiveFraction.order_eq_of_evaluate_eq (w : G →+ ℤ)
    (p q : PositiveFraction G)
    (heq : p.evaluate (algebraMap _ (FractionRing (AddMonoidAlgebra ℤ G))) =
      q.evaluate (algebraMap _ (FractionRing (AddMonoidAlgebra ℤ G)))) :
    p.order w = q.order w := by
  let φ := algebraMap (AddMonoidAlgebra ℤ G) (FractionRing (AddMonoidAlgebra ℤ G))
  have hφ : Function.Injective φ := IsFractionRing.injective _ _
  have hp : φ (positiveCast p.denominator) ≠ 0 := fun h =>
    positiveCast_ne_zero p.denominator_ne_zero (hφ (h.trans (map_zero φ).symm))
  have hq : φ (positiveCast q.denominator) ≠ 0 := fun h =>
    positiveCast_ne_zero q.denominator_ne_zero (hφ (h.trans (map_zero φ).symm))
  have hm : p.numerator * q.denominator = q.numerator * p.denominator := by
    apply positiveCast_injective
    apply hφ
    simpa only [map_mul] using (div_eq_div_iff hp hq).mp heq
  have ho := congrArg (fun z : {r : AddMonoidAlgebra ℕ G // r ≠ 0} =>
    positiveOrder w z.val z.property)
    (show (⟨p.numerator * q.denominator, positive_mul_ne_zero p.numerator_ne_zero
      q.denominator_ne_zero⟩ :
      {r : AddMonoidAlgebra ℕ G // r ≠ 0}) =
      ⟨q.numerator * p.denominator, positive_mul_ne_zero q.numerator_ne_zero p.denominator_ne_zero⟩
      from Subtype.ext hm)
  dsimp only at ho
  rw [positiveOrder_mul w _ _ p.numerator_ne_zero q.denominator_ne_zero,
    positiveOrder_mul w _ _ q.numerator_ne_zero p.denominator_ne_zero] at ho
  dsimp [order]
  omega

/-- The order of the positive numerator-denominator representative constructed from the
expression.
-/
def PositiveExpression.order (w : G →+ ℤ) (e : PositiveExpression G) : ℤ :=
  e.representatives.order w

omit [IsAddTorsionFree G] in
@[simp] theorem PositiveExpression.order_atom (w : G →+ ℤ)
    (p : AddMonoidAlgebra ℕ G) (hp : p ≠ 0) :
    (PositiveExpression.atom p hp).order w = positiveOrder w p hp :=
  PositiveFraction.order_atom w p hp

@[simp] theorem PositiveExpression.order_add (w : G →+ ℤ) (a b : PositiveExpression G) :
    (a.add b).order w = min (a.order w) (b.order w) :=
  PositiveFraction.order_add w _ _

@[simp] theorem PositiveExpression.order_mul (w : G →+ ℤ) (a b : PositiveExpression G) :
    (a.mul b).order w = a.order w + b.order w :=
  PositiveFraction.order_mul w _ _

omit [IsAddTorsionFree G] in
@[simp] theorem PositiveExpression.order_inv (w : G →+ ℤ) (a : PositiveExpression G) :
    a.inv.order w = -a.order w := PositiveFraction.order_inv w _

/-- Any Laurent representative of a positive fraction has its literal lowest
support weight. This also proves independence of the chosen positive fraction. -/
theorem loWeight_of_positive_fraction (w : G →+ ℤ)
    (p : PositiveFraction G) (f : AddMonoidAlgebra ℤ G) (hf : f ≠ 0)
    (heq : algebraMap (AddMonoidAlgebra ℤ G) (FractionRing (AddMonoidAlgebra ℤ G)) f =
      p.evaluate (algebraMap _ _)) :
    loWeight w f hf = p.order w := by
  let φ := algebraMap (AddMonoidAlgebra ℤ G) (FractionRing (AddMonoidAlgebra ℤ G))
  have hφ : Function.Injective φ := IsFractionRing.injective _ _
  have hden := positiveCast_ne_zero p.denominator_ne_zero
  have hden' : φ (positiveCast p.denominator) ≠ 0 :=
    fun h => hden (hφ (h.trans (map_zero φ).symm))
  have hmul : f * positiveCast p.denominator = positiveCast p.numerator := by
    apply hφ
    rw [map_mul]
    exact (eq_div_iff hden').mp heq
  have hweight := loWeight_mul w hf hden (mul_ne_zero hf hden)
  simp only [hmul] at hweight
  dsimp [PositiveFraction.order, positiveOrder]
  omega

/-- A nonnegative order excludes negative exponents in that weight from an
already proved Laurent expansion. This is the frozen-polynomial descent step. -/
theorem nonnegative_support_of_positive_fraction (w : G →+ ℤ)
    (p : PositiveFraction G) (f : AddMonoidAlgebra ℤ G) (hf : f ≠ 0)
    (heq : algebraMap (AddMonoidAlgebra ℤ G) (FractionRing (AddMonoidAlgebra ℤ G)) f =
      p.evaluate (algebraMap _ _)) (horder : 0 ≤ p.order w) :
    ∀ a ∈ f.coeff.support, 0 ≤ w a := by
  apply (le_loWeight_iff w hf 0).mp
  rwa [loWeight_of_positive_fraction w p f hf heq]

end TauCeti.Laurent
