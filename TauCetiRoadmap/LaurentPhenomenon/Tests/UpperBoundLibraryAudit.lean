/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.UpperBoundPattern
public import TauCetiRoadmap.LaurentPhenomenon.DenominatorPatching
public import TauCetiRoadmap.LaurentPhenomenon.PolynomialExchange
public import TauCetiRoadmap.LaurentPhenomenon.OrderedExchange
public import TauCetiRoadmap.LaurentPhenomenon.FlatDivisibility
public import Mathlib.LinearAlgebra.Matrix.Notation
public import Mathlib.Data.Matrix.Basic
public import Mathlib.LinearAlgebra.Matrix.StdBasis
public import Mathlib.Data.Rat.Defs

/-!
# Consumers of the seed-independent upper-bound library

The polynomial consumer has two signed three-term exchanges. The matrix
consumer has a nontrivial coefficient automorphism and tests the ordered
exchange product in a genuinely noncommutative ambient ring.
-/

@[expose] public section

noncomputable section
namespace TauCeti.Laurent.UpperBoundLibraryAudit

open Polynomial

/-- The signed three-term exchange polynomial X cubed minus X plus one. -/
def signedP : ℤ[X] := X ^ 3 - X + 1
/-- The signed reciprocal exchange polynomial X squared minus X plus one. -/
def signedQ : ℤ[X] := C 1 * X ^ 2 + C (-1) * X + C 1
theorem signed_three_term_replacement {F : Type*} [Field F]
    (H : Subring F) (x y z w : F)
    (hex : x * z = y ^ 3 - y + 1) (hew : y * w = x ^ 2 - x + 1)
    (hy : y ≠ 0) (hyH : y ∈ H) (hzH : z ∈ H) (hwH : w ∈ H) :
    (z ^ 2 - z + 1) / y ∈ H := by
  have hdegree : signedQ.natDegree ≤ 2 := by
    apply Polynomial.natDegree_add_le_of_degree_le
    · apply Polynomial.natDegree_add_le_of_degree_le
      · exact Polynomial.natDegree_C_mul_X_pow_le 1 2
      · simpa only [pow_one] using
          (Polynomial.natDegree_C_mul_X_pow_le (-1 : ℤ) 1).trans (by omega : 1 ≤ 2)
    · simp
  have h := PolynomialExchange.replacement_mem signedP signedQ
    (Int.castRingHom F) H (fun a => intCast_mem H a) x y z w 2 hdegree
    (by simpa [signedP] using hex) (by simpa [signedQ, sub_eq_add_neg] using hew)
    hy hyH hzH hwH
  have hP0 : (Int.castRingHom F) (signedP.coeff 0) = 1 := by simp [signedP]
  rw [hP0] at h
  have hQ : signedQ = C 1 * X ^ 2 + C (-1) * X ^ 1 + C 1 := by
    simp only [signedQ, pow_one]
  rw [hQ] at h
  simp only [PolynomialExchange.reflectedEval_add, C_mul_X_pow_eq_monomial,
    PolynomialExchange.reflectedEval_monomial, PolynomialExchange.reflectedEval_C] at h
  simpa [sub_eq_add_neg, add_comm, add_left_comm, add_assoc] using h

/-- The noncommutative ring of two-by-two rational matrices used by the ordered-exchange example. -/
abbrev MatrixRing := Matrix (Fin 2) (Fin 2) ℚ

/-- Exchange the two diagonal coefficient coordinates, as a ring automorphism. -/
def flip : (Fin 2 → ℚ) ≃+* (Fin 2 → ℚ) where
  toFun c i := c (Equiv.swap 0 1 i)
  invFun c i := c (Equiv.swap 0 1 i)
  left_inv c := by funext i; simp
  right_inv c := by funext i; simp
  map_mul' _ _ := rfl
  map_add' _ _ := rfl

/-- The permutation-matrix unit implementing the flip of the two diagonal coefficients. -/
def swapUnit : MatrixRingˣ where
  val := !![0, 1; 1, 0]
  inv := !![0, 1; 1, 0]
  val_inv := by ext i j; fin_cases i <;> fin_cases j <;> norm_num [Matrix.mul_apply,
    Fin.sum_univ_two]
  inv_val := by ext i j; fin_cases i <;> fin_cases j <;> norm_num [Matrix.mul_apply,
    Fin.sum_univ_two]

/-- The unequal diagonal coefficients one and two used to distinguish ordered products from
ordinary powers.
-/
def diagonalCoeff : Fin 2 → ℚ := ![1, 2]
theorem swap_skew (c : Fin 2 → ℚ) :
    (swapUnit : MatrixRing) * Matrix.diagonalRingHom (Fin 2) ℚ c =
      Matrix.diagonalRingHom (Fin 2) ℚ (flip c) * (swapUnit : MatrixRing) := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [swapUnit, flip, Matrix.mul_apply, Fin.sum_univ_two]

theorem noncommutative_exchange_pow (n : ℕ) :
    (Matrix.diagonalRingHom (Fin 2) ℚ diagonalCoeff * (↑swapUnit⁻¹ : MatrixRing)) ^ n =
      Matrix.diagonalRingHom (Fin 2) ℚ (OrderedExchange.orderedProduct flip diagonalCoeff n) *
        (↑swapUnit⁻¹ : MatrixRing) ^ n :=
  OrderedExchange.exchange_pow _ flip swapUnit swap_skew diagonalCoeff n

theorem ordered_product_is_not_naive_square :
    OrderedExchange.orderedProduct flip diagonalCoeff 2 ≠ diagonalCoeff ^ 2 := by
  intro h
  have hh := congrFun h 0
  norm_num [OrderedExchange.orderedProduct, flip, diagonalCoeff] at hh

/-- Central divisibility combines inside a noncommutative, flat algebra. -/
theorem matrix_central_divisibility (a : Matrix (Fin 2) (Fin 2) ℤ)
    (h2 : algebraMap ℤ _ 2 ∣ a) (h3 : algebraMap ℤ _ 3 ∣ a) :
    algebraMap ℤ _ 6 ∣ a := by
  have h : IsRelPrime (2 : ℤ) 3 :=
    (show IsCoprime (2 : ℤ) 3 from ⟨-1, 1, by norm_num⟩).isRelPrime
  simpa using TauCeti.Module.algebraMap_mul_dvd_of_relPrime h h2 h3


end TauCeti.Laurent.UpperBoundLibraryAudit
