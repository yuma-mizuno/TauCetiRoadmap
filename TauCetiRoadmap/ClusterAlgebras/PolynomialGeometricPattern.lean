/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.GeometricSeed
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

end
end TauCeti.Cluster
