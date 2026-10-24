/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.PositiveSpecialization

/-! # Positive Fraction -/

@[expose] public section

noncomputable section
namespace TauCeti.Laurent
variable {G : Type*} [AddCommMonoid G]

theorem positive_add_ne_zero {p q : AddMonoidAlgebra ℕ G} (hp : p ≠ 0) : p + q ≠ 0 := by
  intro h
  apply hp
  apply AddMonoidAlgebra.coeff_injective
  ext g
  have he := congrArg (fun r : AddMonoidAlgebra ℕ G => r.coeff g) h
  exact (Nat.add_eq_zero_iff.mp he).1

theorem positiveCast_ne_zero {p : AddMonoidAlgebra ℕ G} (hp : p ≠ 0) :
    positiveCast p ≠ 0 :=
  fun h => hp (positiveCast_injective (h.trans (map_zero _).symm))

theorem positive_mul_ne_zero
    {p q : AddMonoidAlgebra ℕ G} (hp : p ≠ 0) (hq : q ≠ 0) : p * q ≠ 0 := by
  classical
  obtain ⟨a, ha⟩ := Finsupp.support_nonempty_iff.mpr
    (fun h ↦ hp (AddMonoidAlgebra.coeff_eq_zero.mp h))
  obtain ⟨b, hb⟩ := Finsupp.support_nonempty_iff.mpr
    (fun h ↦ hq (AddMonoidAlgebra.coeff_eq_zero.mp h))
  intro h
  have he := congrArg (fun r : AddMonoidAlgebra ℕ G ↦ r.coeff (a + b)) h
  simp only [AddMonoidAlgebra.coeff_mul, Finsupp.sum, AddMonoidAlgebra.coeff_zero,
    Finsupp.zero_apply, Finset.sum_eq_zero_iff] at he
  have hab := he a ha b hb
  simp only [ite_true] at hab
  exact mul_ne_zero (Finsupp.mem_support_iff.mp ha) (Finsupp.mem_support_iff.mp hb) hab

/-- Explicit nonzero positive numerator and denominator representatives. -/
structure PositiveFraction (G : Type*) [AddCommMonoid G] where
  /-- The nonzero natural-coefficient group polynomial in the numerator. -/
  numerator : AddMonoidAlgebra ℕ G
  /-- The nonzero natural-coefficient group polynomial in the denominator. -/
  denominator : AddMonoidAlgebra ℕ G
  numerator_ne_zero : numerator ≠ 0
  denominator_ne_zero : denominator ≠ 0

namespace PositiveFraction
variable [IsDomain (AddMonoidAlgebra ℤ G)]

/-- Represent a nonzero positive polynomial as a fraction with denominator one. -/
def atom (p : AddMonoidAlgebra ℕ G) (hp : p ≠ 0) : PositiveFraction G :=
  ⟨p, 1, hp, one_ne_zero⟩

/-- Add positive fractions by cross-multiplying their numerators and multiplying their
denominators.
-/
def add (x y : PositiveFraction G) : PositiveFraction G :=
  ⟨x.numerator * y.denominator + y.numerator * x.denominator,
    x.denominator * y.denominator,
    positive_add_ne_zero (positive_mul_ne_zero x.numerator_ne_zero y.denominator_ne_zero),
    positive_mul_ne_zero x.denominator_ne_zero y.denominator_ne_zero⟩

/-- Multiply the two numerator polynomials and the two denominator polynomials. -/
def mul (x y : PositiveFraction G) : PositiveFraction G :=
  ⟨x.numerator * y.numerator, x.denominator * y.denominator,
    positive_mul_ne_zero x.numerator_ne_zero y.numerator_ne_zero,
    positive_mul_ne_zero x.denominator_ne_zero y.denominator_ne_zero⟩

/-- Invert a positive fraction by exchanging its numerator and denominator. -/
def inv (x : PositiveFraction G) : PositiveFraction G :=
  ⟨x.denominator, x.numerator, x.denominator_ne_zero, x.numerator_ne_zero⟩

/-- The integer-cast denominator as an element of the positive localization's denominator
submonoid.
-/
def denominatorElement (x : PositiveFraction G) : positiveDenominators (positiveCast (G := G)) :=
  ⟨positiveCast x.denominator, positiveCast_ne_zero x.denominator_ne_zero,
    x.denominator, rfl⟩

/-- Every positive rational expression already belongs to the positive localization. -/
def value (x : PositiveFraction G) : Localization (positiveDenominators (positiveCast (G := G))) :=
  IsLocalization.mk' _ (positiveCast x.numerator) x.denominatorElement

/-- Map numerator and denominator through f and evaluate their quotient using field division. -/
def evaluate {K : Type*} [Field K] (f : AddMonoidAlgebra ℤ G →+* K)
    (x : PositiveFraction G) : K :=
  f (positiveCast x.numerator) / f (positiveCast x.denominator)

/-- Localization specialization evaluates the actual positive fraction. -/
theorem specialize_value {K : Type*} [Field K] (f : AddMonoidAlgebra ℤ G →+* K)
    (hf : ∀ p, positiveCast p ≠ 0 → f (positiveCast p) ≠ 0)
    (x : PositiveFraction G) :
    specializePositive positiveCast f hf x.value = x.evaluate f := by
  unfold value specializePositive evaluate
  apply (IsLocalization.lift_mk'_spec _ _ _ _).mpr
  exact (mul_div_cancel₀ _ (hf _ (positiveCast_ne_zero x.denominator_ne_zero))).symm

omit [IsDomain (AddMonoidAlgebra ℤ G)] in
@[simp] theorem evaluate_atom {K : Type*} [Field K] (f : AddMonoidAlgebra ℤ G →+* K)
    (p : AddMonoidAlgebra ℕ G) (hp : p ≠ 0) :
    (atom p hp).evaluate f = f (positiveCast p) := by
  simp [evaluate, atom]

omit [IsDomain (AddMonoidAlgebra ℤ G)] in
theorem evaluate_add {K : Type*} [Field K] (f : AddMonoidAlgebra ℤ G →+* K)
    (hf : ∀ p, positiveCast p ≠ 0 → f (positiveCast p) ≠ 0)
    (x y : PositiveFraction G) :
    (x.add y).evaluate f = x.evaluate f + y.evaluate f := by
  have hx := hf _ (positiveCast_ne_zero x.denominator_ne_zero)
  have hy := hf _ (positiveCast_ne_zero y.denominator_ne_zero)
  simp only [evaluate, add, map_add, map_mul]
  rw [div_add_div _ _ hx hy]
  rw [mul_comm (f (positiveCast y.numerator)) (f (positiveCast x.denominator))]

omit [IsDomain (AddMonoidAlgebra ℤ G)] in
theorem evaluate_mul {K : Type*} [Field K] (f : AddMonoidAlgebra ℤ G →+* K)
    (x y : PositiveFraction G) :
    (x.mul y).evaluate f = x.evaluate f * y.evaluate f := by
  simp [evaluate, mul, map_mul, div_mul_div_comm]

omit [IsDomain (AddMonoidAlgebra ℤ G)] in
theorem evaluate_inv {K : Type*} [Field K] (f : AddMonoidAlgebra ℤ G →+* K)
    (x : PositiveFraction G) : (x.inv).evaluate f = (x.evaluate f)⁻¹ := by
  simp [evaluate, inv, inv_div]

omit [IsDomain (AddMonoidAlgebra ℤ G)] in
theorem evaluate_ne_zero {K : Type*} [Field K] (f : AddMonoidAlgebra ℤ G →+* K)
    (hf : ∀ p, positiveCast p ≠ 0 → f (positiveCast p) ≠ 0)
    (x : PositiveFraction G) : x.evaluate f ≠ 0 :=
  div_ne_zero (hf _ (positiveCast_ne_zero x.numerator_ne_zero))
    (hf _ (positiveCast_ne_zero x.denominator_ne_zero))

end PositiveFraction

namespace PositiveFraction

/-- A faithful realization detects a Laurent representative by a ring identity.
This allows changing ambient fields without constructing a fraction-field
equivalence or specializing a rational function at a possible pole. -/
theorem represented_iff {K : Type*} [Field K]
    (f : AddMonoidAlgebra ℤ G →+* K) (hf : Function.Injective f)
    (p : PositiveFraction G) (r : AddMonoidAlgebra ℤ G) :
    f r = p.evaluate f ↔ r * positiveCast p.denominator = positiveCast p.numerator := by
  have hd : f (positiveCast p.denominator) ≠ 0 :=
    fun h => positiveCast_ne_zero p.denominator_ne_zero
      (hf (h.trans (map_zero f).symm))
  rw [evaluate, eq_div_iff hd, ← map_mul, hf.eq_iff]

theorem represented_transfer {K L : Type*} [Field K] [Field L]
    (f : AddMonoidAlgebra ℤ G →+* K) (hf : Function.Injective f)
    (g : AddMonoidAlgebra ℤ G →+* L)
    (hg : ∀ p, positiveCast p ≠ 0 → g (positiveCast p) ≠ 0)
    (p : PositiveFraction G) (r : AddMonoidAlgebra ℤ G)
    (h : f r = p.evaluate f) : g r = p.evaluate g := by
  have heq := (represented_iff f hf p r).mp h
  apply (eq_div_iff (hg _ (positiveCast_ne_zero p.denominator_ne_zero))).mpr
  rw [← map_mul, heq]

end PositiveFraction

/-- The subtraction-free rational operations used by positive mutation paths. -/
inductive PositiveExpression (G : Type*) [AddCommMonoid G] where
  | atom (p : AddMonoidAlgebra ℕ G) (hp : p ≠ 0)
  | add (x y : PositiveExpression G)
  | mul (x y : PositiveExpression G)
  | inv (x : PositiveExpression G)

namespace PositiveExpression

/-- Construct nonzero positive numerator and denominator polynomials by recursion on a finite
expression.
-/
def representatives : PositiveExpression G → PositiveFraction G
  | .atom p hp => PositiveFraction.atom p hp
  | .add x y => x.representatives.add y.representatives
  | .mul x y => x.representatives.mul y.representatives
  | .inv x => x.representatives.inv

/-- Evaluate a finite positive expression using the field operations, including totalized
inversion.
-/
def evaluate {K : Type*} [Field K] (f : AddMonoidAlgebra ℤ G →+* K) :
    PositiveExpression G → K
  | .atom p _ => f (positiveCast p)
  | .add x y => x.evaluate f + y.evaluate f
  | .mul x y => x.evaluate f * y.evaluate f
  | .inv x => (x.evaluate f)⁻¹


/-- The atomic positive expression for the constant one. -/
def one : PositiveExpression G := .atom 1 one_ne_zero
/-- Natural powers built recursively from multiplication of positive expressions. -/
def powNat (x : PositiveExpression G) : ℕ → PositiveExpression G
  | 0 => one
  | n + 1 => .mul x (powNat x n)

/-- Integer powers of positive expressions, using inversion for negative integers. -/
def powInt (x : PositiveExpression G) : ℤ → PositiveExpression G
  | .ofNat n => powNat x n
  | .negSucc n => .inv (powNat x (n + 1))

/-- Multiply a finite family of positive expressions, using one for the empty family. -/
def product {A : Type*} (s : Finset A) (f : A → PositiveExpression G) :
    PositiveExpression G :=
  s.toList.foldr (fun t x => .mul (f t) x) one

/-- Add a nonempty finite family of positive expressions without introducing a zero atom. -/
def sum {A : Type*} (s : Finset A) (hs : s.Nonempty)
    (f : A → PositiveExpression G) : PositiveExpression G := by
  classical
  exact (s.erase hs.choose).toList.foldr (fun t x => .add (f t) x) (f hs.choose)

variable {F : Type*} [Field F]
  (φ : AddMonoidAlgebra ℤ G →+* F)

@[simp] theorem evaluate_one : PositiveExpression.evaluate φ (one (G := G)) = 1 := by
  simp [one, PositiveExpression.evaluate]

@[simp] theorem evaluate_powNat (x : PositiveExpression G) (n : ℕ) :
    (powNat x n).evaluate φ = (x.evaluate φ) ^ n := by
  induction n with
  | zero => simp [powNat]
  | succ n ih => simp [powNat, PositiveExpression.evaluate, ih, pow_succ, mul_comm]

@[simp] theorem evaluate_powInt (x : PositiveExpression G) (n : ℤ) :
    (powInt x n).evaluate φ = (x.evaluate φ) ^ n := by
  classical
  cases n <;> simp [powInt, PositiveExpression.evaluate, zpow_negSucc]

theorem evaluate_product_list {A : Type*} (l : List A)
    (f : A → PositiveExpression G) (z : PositiveExpression G) :
    (l.foldr (fun t x => .mul (f t) x) z).evaluate φ =
      (l.map (fun t => (f t).evaluate φ)).prod * z.evaluate φ := by
  induction l with
  | nil => simp
  | cons a l ih => simp [PositiveExpression.evaluate, ih, mul_assoc]

@[simp] theorem evaluate_product {A : Type*} (s : Finset A)
    (f : A → PositiveExpression G) :
    (product s f).evaluate φ = ∏ t ∈ s, (f t).evaluate φ := by
  simp [product, evaluate_product_list]

theorem evaluate_sum_list {A : Type*} (l : List A)
    (f : A → PositiveExpression G) (z : PositiveExpression G) :
    (l.foldr (fun t x => .add (f t) x) z).evaluate φ =
      (l.map (fun t => (f t).evaluate φ)).sum + z.evaluate φ := by
  induction l with
  | nil => simp
  | cons a l ih => simp [PositiveExpression.evaluate, ih, add_assoc]

@[simp] theorem evaluate_sum {A : Type*} (s : Finset A) (hs : s.Nonempty)
    (f : A → PositiveExpression G) :
    (sum s hs f).evaluate φ = ∑ t ∈ s, (f t).evaluate φ := by
  classical
  simp only [sum, evaluate_sum_list]
  simpa using Finset.sum_erase_add s (fun t => (f t).evaluate φ) hs.choose_spec


/-- Only operands actually inverted by this finite expression must stay nonzero. -/
def DefinedAt {K : Type*} [Field K] (f : AddMonoidAlgebra ℤ G →+* K) :
    PositiveExpression G → Prop
  | .atom _ _ => True
  | .add x y => DefinedAt f x ∧ DefinedAt f y
  | .mul x y => DefinedAt f x ∧ DefinedAt f y
  | .inv x => DefinedAt f x ∧ x.evaluate f ≠ 0

theorem representatives_at {K : Type*} [Field K]
    (f : AddMonoidAlgebra ℤ G →+* K) (x : PositiveExpression G)
    (hx : x.DefinedAt f) :
    f (positiveCast x.representatives.denominator) ≠ 0 ∧
      x.representatives.evaluate f = x.evaluate f := by
  induction x with
  | atom p hp => simp [representatives, PositiveFraction.atom,
      PositiveFraction.evaluate, evaluate]
  | add x y ihx ihy =>
    obtain ⟨hdx, hex⟩ := ihx hx.1
    obtain ⟨hdy, hey⟩ := ihy hx.2
    constructor
    · simpa [representatives, PositiveFraction.add] using mul_ne_zero hdx hdy
    · simp only [representatives, PositiveFraction.evaluate, PositiveFraction.add,
        map_add, map_mul, evaluate]
      simp only [PositiveFraction.evaluate] at hex hey
      rw [← hex, ← hey, div_add_div _ _ hdx hdy]
      congr 1
      ring
  | mul x y ihx ihy =>
    obtain ⟨hdx, hex⟩ := ihx hx.1
    obtain ⟨hdy, hey⟩ := ihy hx.2
    constructor
    · simpa [representatives, PositiveFraction.mul] using mul_ne_zero hdx hdy
    · simpa [representatives, evaluate, PositiveFraction.evaluate_mul] using
        congrArg₂ (· * ·) hex hey
  | inv x ih =>
    obtain ⟨hd, he⟩ := ih hx.1
    constructor
    · have hn : f (positiveCast x.representatives.numerator) ≠ 0 := by
        intro hz
        apply hx.2
        rw [← he, PositiveFraction.evaluate, hz, zero_div]
      exact hn
    · simpa [representatives, evaluate, PositiveFraction.evaluate_inv] using
        congrArg Inv.inv he

/-- The global positivity condition implies every finite inversion condition. -/
theorem definedAt_of_positive {K : Type*} [Field K]
    (f : AddMonoidAlgebra ℤ G →+* K)
    (hf : ∀ p, positiveCast p ≠ 0 → f (positiveCast p) ≠ 0)
    (x : PositiveExpression G) : x.DefinedAt f := by
  induction x with
  | atom _ _ => trivial
  | add _ _ hx hy => exact ⟨hx, hy⟩
  | mul _ _ hx hy => exact ⟨hx, hy⟩
  | inv x hx =>
    refine ⟨hx, ?_⟩
    rw [← (representatives_at f x hx).2]
    exact PositiveFraction.evaluate_ne_zero f hf _

/-- Structural evaluation is controlled by the same finite-denominator theorem,
with global positivity supplying its inversion conditions. -/
theorem representatives_evaluate {K : Type*} [Field K]
    (f : AddMonoidAlgebra ℤ G →+* K)
    (hf : ∀ p, positiveCast p ≠ 0 → f (positiveCast p) ≠ 0)
    (x : PositiveExpression G) : x.representatives.evaluate f = x.evaluate f :=
  (representatives_at f x (definedAt_of_positive f hf x)).2

/-- Specialize a proved Laurent representative using only the denominators in
this finite expression. No condition is imposed on unrelated positive sums. -/
theorem specialize_laurent_at [IsDomain (AddMonoidAlgebra ℤ G)] {K : Type*} [Field K]
    (f : AddMonoidAlgebra ℤ G →+* K) (x : PositiveExpression G)
    (hx : x.DefinedAt f) (r : AddMonoidAlgebra ℤ G)
    (h : x.evaluate (algebraMap _ (FractionRing (AddMonoidAlgebra ℤ G))) =
      algebraMap _ (FractionRing (AddMonoidAlgebra ℤ G)) r) :
    x.evaluate f = f r := by
  let a : AddMonoidAlgebra ℤ G →+* FractionRing (AddMonoidAlgebra ℤ G) := algebraMap _ _
  have ha : ∀ p, positiveCast p ≠ 0 → a (positiveCast p) ≠ 0 :=
    fun _ hp => IsFractionRing.to_map_eq_zero_iff.not.mpr hp
  have he := x.representatives_evaluate a ha
  have hd : a (positiveCast x.representatives.denominator) ≠ 0 :=
    ha _ (positiveCast_ne_zero x.representatives.denominator_ne_zero)
  have hcross : positiveCast x.representatives.numerator =
      r * positiveCast x.representatives.denominator := by
    apply IsFractionRing.injective (AddMonoidAlgebra ℤ G) (FractionRing (AddMonoidAlgebra ℤ G))
    rw [map_mul]
    exact (div_eq_iff hd).mp (he.trans h)
  obtain ⟨hdf, hef⟩ := x.representatives_at f hx
  rw [← hef, PositiveFraction.evaluate, hcross, map_mul,
    mul_div_cancel_right₀ _ hdf]
/-- The finite-denominator version accepts the same universal Laurent equality
as the positive-localization specialization theorem. -/
theorem specialize_laurent_expression_at [IsDomain (AddMonoidAlgebra ℤ G)] {K : Type*} [Field K]
    (f : AddMonoidAlgebra ℤ G →+* K) (x : PositiveExpression G)
    (hx : x.DefinedAt f) (r : AddMonoidAlgebra ℤ G)
    (h : positiveFractionEmbedding (positiveCast (G := G)) x.representatives.value =
      algebraMap _ (FractionRing (AddMonoidAlgebra ℤ G)) r) :
    x.evaluate f = f r := by
  apply specialize_laurent_at f x hx r
  let a : AddMonoidAlgebra ℤ G →+* FractionRing (AddMonoidAlgebra ℤ G) := algebraMap _ _
  have ha : ∀ p, positiveCast p ≠ 0 → a (positiveCast p) ≠ 0 :=
    fun _ hp => IsFractionRing.to_map_eq_zero_iff.not.mpr hp
  have hv := x.representatives.specialize_value a ha
  have he := x.representatives_evaluate a ha
  exact (he.symm.trans hv.symm).trans h

/-- Every positive expression belongs to the positive localization and specializes
    to its recursive field evaluation. -/
theorem specialize_representatives [IsDomain (AddMonoidAlgebra ℤ G)] {K : Type*} [Field K]
    (f : AddMonoidAlgebra ℤ G →+* K)
    (hf : ∀ p, positiveCast p ≠ 0 → f (positiveCast p) ≠ 0)
    (x : PositiveExpression G) :
    specializePositive positiveCast f hf x.representatives.value = x.evaluate f := by
  rw [PositiveFraction.specialize_value f hf, representatives_evaluate f hf]

/-- A finite Laurent representative proved in the universal fraction field can
    be specialized along a noninjective coefficient map. -/
theorem specialize_laurent [IsDomain (AddMonoidAlgebra ℤ G)] {K : Type*} [Field K]
    (f : AddMonoidAlgebra ℤ G →+* K)
    (hf : ∀ p, positiveCast p ≠ 0 → f (positiveCast p) ≠ 0)
    (x : PositiveExpression G) (r : AddMonoidAlgebra ℤ G)
    (h : positiveFractionEmbedding (positiveCast (G := G)) x.representatives.value =
      algebraMap _ (FractionRing (AddMonoidAlgebra ℤ G)) r) :
    x.evaluate f = f r := by
  exact specialize_laurent_expression_at f x (definedAt_of_positive f hf x) r h

end PositiveExpression
end TauCeti.Laurent
