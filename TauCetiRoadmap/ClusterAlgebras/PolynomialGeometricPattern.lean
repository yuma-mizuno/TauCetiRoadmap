/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.GeometricPattern
public import TauCetiRoadmap.LaurentPhenomenon.MutationWord
public import Mathlib.Algebra.Polynomial.Reverse
public import Mathlib.Algebra.BigOperators.Group.Finset.Basic

/-!
# Classical polynomial exchange patterns

The extended matrix uses the ordinary matrix-mutation convention. The degree
`d_k` divides its column, so the homogeneous exchange exponents are
`[-B_k]_+ + l B_k/d_k`. Mutation reverses only the selected polynomial.
This construction does not use quantum seeds or a quantum Laurent theorem.
-/

@[expose] public section

namespace TauCeti.Cluster

open TauCeti.Laurent

/-- Matrix, scalar exchange polynomials and coordinate values of a classical pattern. -/
@[ext] structure PolynomialGeometricData (F M K : Type*) where
  /-- The extended exchange matrix in the ordinary mutation convention. -/
  exchange : Matrix M K ℤ
  /-- The normalized scalar exchange polynomials. -/
  polynomial : K → Polynomial ℤ
  /-- The classical coordinate values. -/
  coordinate : M → F

/-- Reversal fixes the degree-one exchange polynomial. -/
theorem _root_.Polynomial.reverse_X_add_one {R : Type*} [CommRing R] [Nontrivial R] :
    (Polynomial.X + 1 : Polynomial R).reverse = Polynomial.X + 1 := by
  change (Polynomial.X + Polynomial.C 1 : Polynomial R).reverse =
    Polynomial.X + Polynomial.C 1
  rw [Polynomial.reverse_add_C]
  simp [Polynomial.reverse, add_comm]

noncomputable section

variable {M K F : Type*} [Fintype M] [DecidableEq M] [DecidableEq K] [Field F]
  (row : K ↪ M) (d : K → ℕ)

/-- The homogeneous polynomial exchange numerator at arbitrary coordinate values. -/
def polynomialGeometricNumerator (p : PolynomialGeometricData F M K) (k : K) : F :=
  ∑ l ∈ Finset.range (d k + 1), ((p.polynomial k).coeff l : F) *
    ∏ a, p.coordinate a ^ (positivePart (-p.exchange a k) +
      (l : ℤ) * (p.exchange a k / d k)).toNat

/-- Classical polynomial mutation, including reversal of the selected coefficient list. -/
def polynomialGeometricExchange (k : K) (p : PolynomialGeometricData F M K) :
    PolynomialGeometricData F M K where
  exchange := extendedMatrixMutation row p.exchange k
  polynomial := Function.update p.polynomial k (p.polynomial k).reverse
  coordinate := Function.update p.coordinate (row k)
    (polynomialGeometricNumerator d p k / p.coordinate (row k))

/-- The independently defined classical polynomial pattern along a mutation word. -/
def polynomialGeometricPattern (p : PolynomialGeometricData F M K) (w : List K) :
    PolynomialGeometricData F M K :=
  mutateWord (polynomialGeometricExchange row d) w p

@[simp] theorem polynomialGeometricPattern_nil (p : PolynomialGeometricData F M K) :
    polynomialGeometricPattern row d p [] = p := rfl

theorem polynomialGeometricPattern_append (p : PolynomialGeometricData F M K)
    (w : List K) (k : K) :
    polynomialGeometricPattern row d p (w ++ [k]) =
      polynomialGeometricExchange row d k (polynomialGeometricPattern row d p w) := by
  rw [polynomialGeometricPattern, mutateWord_append]
  rfl

@[simp] theorem polynomialGeometricExchange_coordinate_row
    (p : PolynomialGeometricData F M K) (k : K) :
    (polynomialGeometricExchange row d k p).coordinate (row k) =
      polynomialGeometricNumerator d p k / p.coordinate (row k) :=
  Function.update_self _ _ _

theorem polynomialGeometricExchange_coordinate_of_ne (p : PolynomialGeometricData F M K)
    (k : K) {a : M} (ha : a ≠ row k) :
    (polynomialGeometricExchange row d k p).coordinate a = p.coordinate a :=
  Function.update_of_ne ha _ _


/-- Embed binary classical exchange data as normalized degree-one polynomial data. -/
def binomialData (p : Matrix M K ℤ × (M → F)) : PolynomialGeometricData F M K :=
  ⟨p.1, fun _ ↦ Polynomial.X + 1, p.2⟩

omit [DecidableEq M] [DecidableEq K] in
/-- The binary polynomial exchange numerator is the usual two-monomial numerator. -/
theorem polynomialGeometricNumerator_one (p : Matrix M K ℤ × (M → F)) (k : K) :
    polynomialGeometricNumerator (fun _ ↦ 1) (binomialData p) k =
      (∏ a, p.2 a ^ positivePart (p.1 a k)) +
        ∏ a, p.2 a ^ positivePart (-p.1 a k) := by
  have hp (a : M) : positivePart (-p.1 a k) + p.1 a k = positivePart (p.1 a k) := by
    have := positivePart_sub_positivePart_neg (p.1 a k)
    omega
  simp only [polynomialGeometricNumerator, binomialData, Finset.sum_range_succ,
    Finset.sum_range_zero, Polynomial.coeff_add, Polynomial.coeff_X,
    Polynomial.coeff_one]
  simp only [Nat.cast_zero, Nat.cast_one, Int.ediv_one, zero_mul, one_mul, add_zero,
    zero_add]
  simp only [Nat.one_ne_zero, ite_eq_left, ite_false, add_zero, Int.cast_one, one_mul]
  simp_rw [hp]
  have hpow (b : ℤ) (a : M) : p.2 a ^ (positivePart b).toNat = p.2 a ^ positivePart b := by
    rw [← zpow_natCast, Int.toNat_of_nonneg (show 0 ≤ positivePart b from le_max_right b 0)]
  simp_rw [hpow]
  ring

/-- A binary mutation is exactly the degree-one polynomial mutation. -/
theorem polynomialGeometricExchange_one (p : Matrix M K ℤ × (M → F)) (k : K) :
    polynomialGeometricExchange row (fun _ ↦ 1) k (binomialData p) =
      binomialData (geometricExchange row k p) := by
  apply PolynomialGeometricData.ext
  · rfl
  · funext j
    change Function.update (fun _ ↦ (Polynomial.X + 1 : Polynomial ℤ)) k
      (Polynomial.X + 1).reverse j = Polynomial.X + 1
    rw [Polynomial.reverse_X_add_one, Function.update_eq_self]
  · funext a
    change Function.update p.2 (row k)
      (polynomialGeometricNumerator (fun _ ↦ 1) (binomialData p) k / p.2 (row k)) a = _
    rw [polynomialGeometricNumerator_one]
    rfl

/-- The independently defined classical patterns agree along every word in degree one. -/
theorem polynomialGeometricPattern_one (p : Matrix M K ℤ × (M → F)) (w : List K) :
    polynomialGeometricPattern row (fun _ ↦ 1) (binomialData p) w =
      binomialData (mutateWord (geometricExchange row) w p) := by
  induction w generalizing p with
  | nil => rfl
  | cons k w ih =>
    rw [polynomialGeometricPattern, mutateWord_cons, polynomialGeometricExchange_one]
    exact ih _

end
end TauCeti.Cluster
