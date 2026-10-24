/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.PrincipalRank
public import TauCetiRoadmap.ClusterAlgebras.GeometricSeed
public import Mathlib.LinearAlgebra.Matrix.BilinearForm
public import Mathlib.Tactic

/-!
# Compatible pairs

An extended exchange matrix `B_ext` carries its positive symmetrizer `s` as data
(`ExtendedExchangeMatrix`, §1.1); mutation acts on the matrix and keeps `s`. A compatible pair is
`(B_ext, Λ)` with `Λ` alternating and `B_extᵀΛ = (D_s 0)` (`IsCompatiblePair`). The bilinear
  form of `Λ`
is Mathlib's `Matrix.toBilin' Λ` (`matrixForm`).

We prove that a positive `d` with `B_extᵀΛ = (diag(d) 0)` symmetrizes the principal block, the zero
diagonal and full column rank of `B_ext`; mutation of `Λ` by `Λ' = E_εᵀ Λ E_ε` (independent of `ε`,
preserving alternation and compatibility with the same `s`, involutive); the principal pair
`((B₀; Id), ((0, -D), (D, B₀ᵀD)))` for any `B₀`; and the sign transport `(B_ext, Λ) ↦ (-B_ext, -Λ)`.
-/

@[expose] public section

namespace TauCeti.Cluster

open Matrix

variable {M K : Type*} [Fintype M]

/-! ### The bilinear form of a matrix -/

section Form

variable [DecidableEq M]

/-- The integer bilinear form `a ↦ b ↦ aᵀ Λ b` of a square matrix: Mathlib's `Matrix.toBilin'`. -/
abbrev matrixForm (Λ : Matrix M M ℤ) : LinearMap.BilinForm ℤ (M → ℤ) :=
  Matrix.toBilin' Λ

theorem matrixForm_apply (Λ : Matrix M M ℤ) (a b : M → ℤ) :
    matrixForm Λ a b = a ⬝ᵥ (Λ *ᵥ b) :=
  Matrix.toBilin'_apply' Λ a b

theorem matrixForm_eq_sum (Λ : Matrix M M ℤ) (a b : M → ℤ) :
    matrixForm Λ a b = ∑ i, ∑ j, a i * Λ i j * b j :=
  Matrix.toBilin'_apply Λ a b

theorem matrixForm_single_left (Λ : Matrix M M ℤ) (i : M) (b : M → ℤ) :
    matrixForm Λ (Pi.single i 1) b = ∑ j, Λ i j * b j := by
  rw [matrixForm_apply, single_one_dotProduct]; rfl

theorem matrixForm_single_right (Λ : Matrix M M ℤ) (a : M → ℤ) (j : M) :
    matrixForm Λ a (Pi.single j 1) = ∑ i, a i * Λ i j := by
  rw [matrixForm_apply, mulVec_single_one]; rfl

theorem matrixForm_single_single (Λ : Matrix M M ℤ) (i j : M) :
    matrixForm Λ (Pi.single i 1) (Pi.single j 1) = Λ i j :=
  Matrix.toBilin'_single Λ i j

/-- The form of `Pᵀ Λ P` is the form of `Λ` evaluated on `P a` and `P b`. -/
theorem matrixForm_transpose_mul_mul (P Λ : Matrix M M ℤ) (a b : M → ℤ) :
    matrixForm (Pᵀ * Λ * P) a b = matrixForm Λ (P *ᵥ a) (P *ᵥ b) := by
  rw [matrixForm_apply, matrixForm_apply, ← mulVec_mulVec, ← mulVec_mulVec, dotProduct_mulVec,
    vecMul_transpose]

theorem matrixForm_neg (Λ : Matrix M M ℤ) (a b : M → ℤ) :
    matrixForm (-Λ) a b = -matrixForm Λ a b := by
  rw [matrixForm, map_neg, LinearMap.neg_apply, LinearMap.neg_apply]

end Form

/-! ### Alternating matrices and compatible pairs -/

/-- A square integer matrix is alternating if it is skew-symmetric (over `ℤ` this forces a zero
diagonal). -/
def IsAlternatingMatrix (Λ : Matrix M M ℤ) : Prop :=
  ∀ i j, Λ i j = -Λ j i

/-! ### Extended exchange matrices -/

/-- An **extended exchange matrix** (§1.1): `B_ext : Matrix M K ℤ`, whose rows `row k` form the
principal block, with a positive integer symmetrizer `s` of the principal block as data,
`s_i b_ij = -s_j b_ji`. -/
structure ExtendedExchangeMatrix (row : K ↪ M) where
  /-- The extended matrix `B_ext`. -/
  matrix : Matrix M K ℤ
  /-- The symmetrizer `s` of the principal block. -/
  symmetrizer : K → ℤ
  symmetrizer_pos : ∀ k, 0 < symmetrizer k
  symmetrized : ∀ i j, symmetrizer i * matrix (row i) j = -(symmetrizer j * matrix (row j) i)

namespace ExtendedExchangeMatrix

variable {row : K ↪ M}

omit [Fintype M] in
@[ext] theorem ext {B B' : ExtendedExchangeMatrix row} (h₁ : B.matrix = B'.matrix)
    (h₂ : B.symmetrizer = B'.symmetrizer) : B = B' := by
  cases B
  cases B'
  cases h₁
  cases h₂
  rfl

omit [Fintype M] in
/-- The principal block has zero diagonal. -/
theorem diagonal (B : ExtendedExchangeMatrix row) (k : K) : B.matrix (row k) k = 0 :=
  diagonal_of_positive_symmetrizer (fun i j ↦ B.matrix (row i) j) B.symmetrizer
    B.symmetrizer_pos B.symmetrized k

variable [DecidableEq M] [Fintype K] [DecidableEq K]

/-- Mutation `μ_k` acts on the matrix and keeps the symmetrizer. -/
def mutate (B : ExtendedExchangeMatrix row) (k : K) : ExtendedExchangeMatrix row where
  matrix := extendedMatrixMutation row B.matrix k
  symmetrizer := B.symmetrizer
  symmetrizer_pos := B.symmetrizer_pos
  symmetrized i j := by
    rw [extendedMatrixMutation_principal, extendedMatrixMutation_principal]
    exact matrixMutation_symmetrizer (fun u v ↦ B.matrix (row u) v) B.symmetrizer
      B.symmetrizer_pos B.symmetrized k i j

omit [Fintype K] [Fintype M] in
@[simp] theorem mutate_matrix (B : ExtendedExchangeMatrix row) (k : K) :
    (B.mutate k).matrix = extendedMatrixMutation row B.matrix k := rfl

omit [Fintype K] [Fintype M] in
@[simp] theorem mutate_symmetrizer (B : ExtendedExchangeMatrix row) (k : K) :
    (B.mutate k).symmetrizer = B.symmetrizer := rfl

omit [Fintype K] [Fintype M] in
theorem mutate_mutate (B : ExtendedExchangeMatrix row) (k : K) :
    (B.mutate k).mutate k = B :=
  ext (extendedMatrixMutation_involutive row B.matrix k) rfl

end ExtendedExchangeMatrix

/-- The sign transport `B_ext ↦ -B_ext`, with the same symmetrizer. -/
def ExtendedExchangeMatrix.neg {row : K ↪ M} (B : ExtendedExchangeMatrix row) :
    ExtendedExchangeMatrix row where
  matrix := -B.matrix
  symmetrizer := B.symmetrizer
  symmetrizer_pos := B.symmetrizer_pos
  symmetrized i j := by rw [neg_apply, neg_apply, mul_neg, mul_neg, B.symmetrized i j]

omit [Fintype M] in
@[simp] theorem ExtendedExchangeMatrix.neg_matrix {row : K ↪ M} (B : ExtendedExchangeMatrix row) :
    B.neg.matrix = -B.matrix := rfl

omit [Fintype M] in
@[simp] theorem ExtendedExchangeMatrix.neg_symmetrizer {row : K ↪ M}
    (B : ExtendedExchangeMatrix row) : B.neg.symmetrizer = B.symmetrizer := rfl

omit [Fintype M] in
/-- The sign transport commutes with mutation. -/
theorem ExtendedExchangeMatrix.neg_mutate [Finite K] [DecidableEq M] [DecidableEq K]
    {row : K ↪ M} (B : ExtendedExchangeMatrix row) (k : K) :
    B.neg.mutate k = (B.mutate k).neg := by
  let : Fintype K := Fintype.ofFinite K
  refine ExtendedExchangeMatrix.ext ?_ rfl
  ext i j
  simp only [mutate_matrix, neg_matrix, extendedMatrixMutation, neg_apply, neg_neg]
  split_ifs <;> ring

/-! ### Compatible pairs -/

variable [DecidableEq M]

/-- The right side `(D 0)` of the compatibility equation. -/
def compatibilityMatrix (row : K ↪ M) (d : K → ℤ) : Matrix K M ℤ :=
  fun k l => if l = row k then d k else 0

/-- `(B_ext, Λ)` is a **compatible pair**: `B_extᵀ Λ = (D_s 0)` for the symmetrizer `s` carried
  by `B_ext`,
where the mutable index `k` sits in row `row k`. Alternation of `Λ` is a separate hypothesis. -/
def IsCompatiblePair {row : K ↪ M} (B : ExtendedExchangeMatrix row) (Λ : Matrix M M ℤ) : Prop :=
  ∀ k l, ∑ i, B.matrix i k * Λ i l = if l = row k then B.symmetrizer k else 0

omit [Fintype M] [DecidableEq M] in
theorem isAlternatingMatrix_iff_transpose {Λ : Matrix M M ℤ} :
    IsAlternatingMatrix Λ ↔ Λᵀ = -Λ := by
  constructor
  · intro h
    ext i j
    simp [h j i]
  · intro h i j
    have := congrFun (congrFun h j) i
    simp only [transpose_apply, neg_apply] at this
    rw [this]

theorem isCompatiblePair_iff_transpose_mul {row : K ↪ M} {B : ExtendedExchangeMatrix row}
    {Λ : Matrix M M ℤ} :
    IsCompatiblePair B Λ ↔ B.matrixᵀ * Λ = compatibilityMatrix row B.symmetrizer := by
  constructor
  · intro h
    ext k l
    simp [Matrix.mul_apply, h k l, compatibilityMatrix]
  · intro h k l
    have := congrFun (congrFun h k) l
    simpa [Matrix.mul_apply, compatibilityMatrix] using this

theorem compatibilityMatrix_mul {N : Type*} (row : K ↪ M) (d : K → ℤ) (X : Matrix M N ℤ)
    (k : K) (l : N) : (compatibilityMatrix row d * X) k l = d k * X (row k) l := by
  simp [Matrix.mul_apply, compatibilityMatrix]

namespace IsAlternatingMatrix

variable {Λ : Matrix M M ℤ}

theorem matrixForm_swap (hΛ : IsAlternatingMatrix Λ) (a b : M → ℤ) :
    matrixForm Λ a b = -matrixForm Λ b a := by
  rw [matrixForm_eq_sum, matrixForm_eq_sum, Finset.sum_comm, ← Finset.sum_neg_distrib]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [← Finset.sum_neg_distrib]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [hΛ i j]
  ring

@[simp] theorem matrixForm_self (hΛ : IsAlternatingMatrix Λ) (a : M → ℤ) :
    matrixForm Λ a a = 0 := by
  have := hΛ.matrixForm_swap a a
  omega

omit [Fintype M] [DecidableEq M] in
theorem apply_self (hΛ : IsAlternatingMatrix Λ) (i : M) : Λ i i = 0 := by
  have := hΛ i i
  omega

omit [Fintype M] [DecidableEq M] in
theorem neg (hΛ : IsAlternatingMatrix Λ) : IsAlternatingMatrix (-Λ) := by
  intro i j
  simp [hΛ i j]

omit [DecidableEq M] in
/-- Congruence `Λ ↦ Pᵀ Λ P` preserves alternation. -/
theorem transpose_mul_mul (hΛ : IsAlternatingMatrix Λ) (P : Matrix M M ℤ) :
    IsAlternatingMatrix (Pᵀ * Λ * P) := by
  rw [isAlternatingMatrix_iff_transpose] at hΛ ⊢
  rw [transpose_mul, transpose_mul, transpose_transpose, hΛ]
  simp [Matrix.mul_assoc]

end IsAlternatingMatrix

private theorem mul_positivePart_of_nonneg {c : ℤ} (hc : 0 ≤ c) (x : ℤ) :
    c * positivePart x = positivePart (c * x) := by
  simp only [positivePart]
  rw [mul_max_of_nonneg _ _ hc, mul_zero]

/-! ### The compatibility equation for a raw matrix -/

section Raw

variable {row : K ↪ M} {B : Matrix M K ℤ} {Λ : Matrix M M ℤ} {d : K → ℤ}

theorem compatibility_apply (h : Bᵀ * Λ = compatibilityMatrix row d) (k : K) (l : M) :
    ∑ i, B i k * Λ i l = if l = row k then d k else 0 := by
  simpa [Matrix.mul_apply, compatibilityMatrix] using congrFun (congrFun h k) l

/-- Under `B_extᵀΛ = (diag(d) 0)`, the form against a column of `B_ext` reads off one coordinate. -/
theorem matrixForm_col_of_transpose_mul_eq (h : Bᵀ * Λ = compatibilityMatrix row d) (k : K)
    (b : M → ℤ) : matrixForm Λ (fun i => B i k) b = d k * b (row k) := by
  rw [matrixForm_eq_sum, Finset.sum_comm]
  simp_rw [← Finset.sum_mul, compatibility_apply h k]
  simp

/-- **The symmetrizer identity.** If `B_extᵀΛ = (diag(d) 0)` with `Λ` alternating, then `d`
symmetrizes the principal block, from the skew-symmetry of `B_extᵀ Λ B_ext`. -/
theorem symmetrized_of_transpose_mul_eq (hΛ : IsAlternatingMatrix Λ)
    (h : Bᵀ * Λ = compatibilityMatrix row d) (i j : K) :
    d i * B (row i) j = -(d j * B (row j) i) := by
  have h3 := hΛ.matrixForm_swap (fun a => B a i) (fun a => B a j)
  rwa [matrixForm_col_of_transpose_mul_eq h i, matrixForm_col_of_transpose_mul_eq h j] at h3

end Raw

/-- The extended exchange matrix `B_ext` with symmetrizer `d`, for `B_extᵀΛ = (diag(d) 0)`, `Λ`
alternating and `d` positive. -/
def ExtendedExchangeMatrix.ofCompatible {row : K ↪ M} (B : Matrix M K ℤ) {Λ : Matrix M M ℤ}
    (d : K → ℤ) (hd : ∀ k, 0 < d k) (hΛ : IsAlternatingMatrix Λ)
    (h : Bᵀ * Λ = compatibilityMatrix row d) : ExtendedExchangeMatrix row where
  matrix := B
  symmetrizer := d
  symmetrizer_pos := hd
  symmetrized := symmetrized_of_transpose_mul_eq hΛ h

theorem isCompatiblePair_ofCompatible {row : K ↪ M} (B : Matrix M K ℤ) {Λ : Matrix M M ℤ}
    (d : K → ℤ) (hd : ∀ k, 0 < d k) (hΛ : IsAlternatingMatrix Λ)
    (h : Bᵀ * Λ = compatibilityMatrix row d) :
    IsCompatiblePair (ExtendedExchangeMatrix.ofCompatible B d hd hΛ h) Λ :=
  isCompatiblePair_iff_transpose_mul.2 h

namespace IsCompatiblePair

variable {row : K ↪ M} {B : ExtendedExchangeMatrix row} {Λ : Matrix M M ℤ}

theorem transpose_mul (hc : IsCompatiblePair B Λ) :
    B.matrixᵀ * Λ = compatibilityMatrix row B.symmetrizer :=
  isCompatiblePair_iff_transpose_mul.1 hc

theorem matrixForm_col_single (hc : IsCompatiblePair B Λ) (k : K) (l : M) :
    matrixForm Λ (fun i => B.matrix i k) (Pi.single l 1) =
      if l = row k then B.symmetrizer k else 0 := by
  rw [matrixForm_single_right]
  exact hc k l

/-- The form against a column of `B_ext` reads off one coordinate. -/
theorem matrixForm_col (hc : IsCompatiblePair B Λ) (k : K) (b : M → ℤ) :
    matrixForm Λ (fun i => B.matrix i k) b = B.symmetrizer k * b (row k) :=
  matrixForm_col_of_transpose_mul_eq hc.transpose_mul k b

theorem matrixForm_col_right (hc : IsCompatiblePair B Λ) (hΛ : IsAlternatingMatrix Λ)
    (k : K) (a : M → ℤ) :
    matrixForm Λ a (fun i => B.matrix i k) = -(B.symmetrizer k * a (row k)) := by
  rw [hΛ.matrixForm_swap, hc.matrixForm_col]

theorem neg (hc : IsCompatiblePair B Λ) : IsCompatiblePair B.neg (-Λ) := by
  intro k l
  simpa [neg_mul_neg] using hc k l

theorem col_ne_zero (hc : IsCompatiblePair B Λ) (k : K) : (fun i => B.matrix i k) ≠ 0 := by
  intro h
  have := hc k (row k)
  simp only [show ∀ i, B.matrix i k = 0 from fun i => congrFun h i, zero_mul,
    Finset.sum_const_zero, ↓reduceIte] at this
  exact (B.symmetrizer_pos k).ne this

/-- Full column rank of `B_ext` over any characteristic-zero domain. -/
theorem mulVec_map_eq_zero [Fintype K] {R : Type*} [CommRing R] [NoZeroDivisors R]
    [CharZero R] (hc : IsCompatiblePair B Λ) {c : K → R}
    (h : B.matrix.map (Int.castRingHom R) *ᵥ c = 0) : c = 0 := by
  funext l
  have hk (k : K) : ∑ i, (B.matrix i k : R) * c k * (Λ i (row l) : R) =
      c k * ((if row l = row k then B.symmetrizer k else 0 : ℤ) : R) := by
    rw [← hc k (row l), Int.cast_sum, Finset.mul_sum]
    refine Finset.sum_congr rfl fun i _ => ?_
    push_cast
    ring
  have key : ∑ i, (B.matrix.map (Int.castRingHom R) *ᵥ c) i * (Λ i (row l) : R) =
      c l * B.symmetrizer l := by
    simp only [mulVec, dotProduct, map_apply, eq_intCast, Finset.sum_mul]
    rw [Finset.sum_comm]
    simp_rw [hk]
    rw [Finset.sum_eq_single l (fun b _ hb => by simp [row.injective.ne (Ne.symm hb)])
      (by simp)]
    simp
  rw [h] at key
  simp only [Pi.zero_apply, zero_mul, Finset.sum_const_zero] at key
  rcases mul_eq_zero.mp key.symm with h0 | h0
  · exact h0
  · exact absurd (Int.cast_eq_zero.mp h0) (B.symmetrizer_pos l).ne'

/-- Full column rank of `B_ext`: `B_ext c = 0` forces `c = 0`. -/
theorem mulVec_eq_zero [Fintype K] (hc : IsCompatiblePair B Λ) {c : K → ℤ}
    (h : B.matrix *ᵥ c = 0) : c = 0 :=
  hc.mulVec_map_eq_zero (R := ℤ) (by simpa using h)

theorem mulVec_rat_eq_zero [Fintype K] (hc : IsCompatiblePair B Λ) {c : K → ℚ}
    (h : B.matrix.map (Int.castRingHom ℚ) *ᵥ c = 0) : c = 0 :=
  hc.mulVec_map_eq_zero h

/-- Full column rank of `B_ext` over `ℚ`: `rank_ℚ B_ext = |K|`. -/
theorem rank_rat [Fintype K] (hc : IsCompatiblePair B Λ) :
    (B.matrix.map (Int.castRingHom ℚ)).rank = Fintype.card K := by
  have hinj : Function.Injective (B.matrix.map (Int.castRingHom ℚ)).mulVecLin :=
    (injective_iff_map_eq_zero _).mpr fun c hc' => hc.mulVec_rat_eq_zero hc'
  rw [Matrix.rank, LinearMap.finrank_range_of_inj hinj, Module.finrank_fintype_fun_eq_card]

/-- The two exchange vectors `-e_k + [±b_{•k}]_+` pair equally with every `e_j`, `j ≠ row k`:
they differ by the column `b_{•k}`. -/
theorem matrixForm_exchange_pos_eq_neg (hc : IsCompatiblePair B Λ) {k : K} {j : M}
    (hj : j ≠ row k) :
    matrixForm Λ (-(Pi.single (row k) 1) + fun i => positivePart (B.matrix i k))
        (Pi.single j 1) =
      matrixForm Λ (-(Pi.single (row k) 1) + fun i => positivePart (-B.matrix i k))
        (Pi.single j 1) := by
  have hv : (-(Pi.single (row k) 1) + fun i => positivePart (B.matrix i k)) =
      (-(Pi.single (row k) 1) + fun i => positivePart (-B.matrix i k)) +
        fun i => B.matrix i k := by
    funext i
    have := positivePart_sub_positivePart_neg (B.matrix i k)
    simp only [Pi.add_apply, Pi.neg_apply]
    omega
  rw [hv, map_add, LinearMap.add_apply, hc.matrixForm_col_single]
  simp [hj]

end IsCompatiblePair

/-- **Full rank from compatibility.** If `B_extᵀΛ = (diag(d) 0)` with `Λ` alternating and `d`
positive, then `rank_ℚ B_ext = |K|`. -/
theorem rank_rat_of_transpose_mul_eq [Fintype K] {row : K ↪ M} {B : Matrix M K ℤ}
    {Λ : Matrix M M ℤ} {d : K → ℤ} (hd : ∀ k, 0 < d k) (hΛ : IsAlternatingMatrix Λ)
    (h : Bᵀ * Λ = compatibilityMatrix row d) :
    (B.map (Int.castRingHom ℚ)).rank = Fintype.card K :=
  (isCompatiblePair_ofCompatible B d hd hΛ h).rank_rat

/-! ### Mutation of the form -/

section Mutation

variable (row : K ↪ M) (B : Matrix M K ℤ) (Λ : Matrix M M ℤ) (k : K)

/-- Mutation of a form, `Λ' = E_εᵀ Λ E_ε` with `E_ε = mutationLeft row B k ε`. -/
def formMutation (ε : ℤ) : Matrix M M ℤ :=
  (mutationLeft row B k ε)ᵀ * Λ * mutationLeft row B k ε

theorem formMutation_matrixForm (ε : ℤ) (a b : M → ℤ) :
    matrixForm (formMutation row B Λ k ε) a b =
      matrixForm Λ (mutationLeft row B k ε *ᵥ a) (mutationLeft row B k ε *ᵥ b) :=
  matrixForm_transpose_mul_mul _ _ a b

theorem mutationLeft_mulVec_apply (ε : ℤ) (a : M → ℤ) (i : M) :
    (mutationLeft row B k ε *ᵥ a) i =
      if i = row k then -a i else a i + positivePart (-ε * B i k) * a (row k) := by
  simp only [mulVec, dotProduct]
  by_cases hi : i = row k
  · subst hi
    rw [Fintype.sum_eq_single (row k)]
    · simp [mutationLeft]
    · intro b hb
      simp [mutationLeft, hb, Ne.symm hb]
  · rw [Fintype.sum_eq_add (row k) i (Ne.symm hi)]
    · simp [mutationLeft, hi]
      ring
    · rintro b ⟨hb, hbi⟩
      simp [mutationLeft, hb, Ne.symm hbi]

theorem mutationLeft_mulVec_single_of_ne (ε : ℤ) {j : M} (hj : j ≠ row k) :
    mutationLeft row B k ε *ᵥ Pi.single j 1 = Pi.single j 1 := by
  rw [mulVec_single_one]
  funext a
  simp [Matrix.col_apply, mutationLeft, hj, Pi.single_apply]

/-- `E_ε` sends `e_k` to the exchange vector `-e_k + [-ε b_{•k}]_+`. -/
theorem mutationLeft_mulVec_single_row (hdiag : B (row k) k = 0) (ε : ℤ) :
    mutationLeft row B k ε *ᵥ Pi.single (row k) 1 =
      -(Pi.single (row k) 1) + fun i => positivePart (-ε * B i k) := by
  rw [mulVec_single_one]
  funext a
  by_cases ha : a = row k
  · subst ha
    simp [Matrix.col_apply, mutationLeft, hdiag, positivePart]
  · simp [Matrix.col_apply, mutationLeft, ha]

theorem formMutation_apply (ε : ℤ) (i j : M) :
    formMutation row B Λ k ε i j =
      matrixForm Λ (mutationLeft row B k ε *ᵥ Pi.single i 1)
        (mutationLeft row B k ε *ᵥ Pi.single j 1) := by
  rw [← matrixForm_single_single (formMutation row B Λ k ε) i j, formMutation_matrixForm]

theorem formMutation_apply_of_ne (ε : ℤ) {i j : M} (hi : i ≠ row k) (hj : j ≠ row k) :
    formMutation row B Λ k ε i j = Λ i j := by
  rw [formMutation_apply, mutationLeft_mulVec_single_of_ne row B k ε hi,
    mutationLeft_mulVec_single_of_ne row B k ε hj, matrixForm_single_single]

theorem formMutation_apply_row_left (hdiag : B (row k) k = 0) (ε : ℤ) {j : M}
    (hj : j ≠ row k) :
    formMutation row B Λ k ε (row k) j =
      matrixForm Λ (-(Pi.single (row k) 1) + fun i => positivePart (-ε * B i k))
        (Pi.single j 1) := by
  rw [formMutation_apply, mutationLeft_mulVec_single_row row B k hdiag,
    mutationLeft_mulVec_single_of_ne row B k ε hj]

theorem formMutation_apply_row_right (hdiag : B (row k) k = 0) (ε : ℤ) {i : M}
    (hi : i ≠ row k) :
    formMutation row B Λ k ε i (row k) =
      matrixForm Λ (Pi.single i 1)
        (-(Pi.single (row k) 1) + fun j => positivePart (-ε * B j k)) := by
  rw [formMutation_apply, mutationLeft_mulVec_single_row row B k hdiag,
    mutationLeft_mulVec_single_of_ne row B k ε hi]

variable {row B Λ}

theorem formMutation_apply_row_row (hΛ : IsAlternatingMatrix Λ) (ε : ℤ) :
    formMutation row B Λ k ε (row k) (row k) = 0 := by
  rw [formMutation_apply]
  exact hΛ.matrixForm_self _

theorem IsAlternatingMatrix.formMutation (hΛ : IsAlternatingMatrix Λ) (ε : ℤ) :
    IsAlternatingMatrix (formMutation row B Λ k ε) :=
  hΛ.transpose_mul_mul _

omit [Fintype M] in
/-- Mutating `B` negates column `k`, so the left matrix of the mutated matrix is `E_{-ε}`. -/
theorem mutationLeft_extendedMatrixMutation [DecidableEq K] (ε : ℤ) :
    mutationLeft row (extendedMatrixMutation row B k) k ε = mutationLeft row B k (-ε) := by
  ext i j
  simp [mutationLeft, extendedMatrixMutation]

omit [Fintype M] in
theorem extendedMatrixMutation_neg [DecidableEq K] :
    extendedMatrixMutation row (-B) k = -extendedMatrixMutation row B k := by
  ext i j
  simp only [extendedMatrixMutation, neg_apply, neg_neg]
  split_ifs <;> ring

omit [Fintype M] in
theorem mutationLeft_neg (ε : ℤ) : mutationLeft row (-B) k ε = mutationLeft row B k (-ε) := by
  ext i j
  simp [mutationLeft]

theorem formMutation_neg (ε : ℤ) :
    formMutation row (-B) (-Λ) k ε = -formMutation row B Λ k (-ε) := by
  simp [formMutation, mutationLeft_neg]

end Mutation

/-! ### Mutation of compatible pairs -/

namespace IsCompatiblePair

variable {row : K ↪ M} {B : ExtendedExchangeMatrix row} {Λ : Matrix M M ℤ} {k : K}

theorem matrixForm_exchange_sign (hc : IsCompatiblePair B Λ) {ε : ℤ} (hε : ε = 1 ∨ ε = -1)
    {j : M} (hj : j ≠ row k) :
    matrixForm Λ (-(Pi.single (row k) 1) + fun i => positivePart (-ε * B.matrix i k))
        (Pi.single j 1) =
      matrixForm Λ (-(Pi.single (row k) 1) + fun i => positivePart (B.matrix i k))
        (Pi.single j 1) := by
  rcases hε with rfl | rfl
  · simp only [neg_mul, one_mul]
    exact (hc.matrixForm_exchange_pos_eq_neg hj).symm
  · simp only [neg_neg, one_mul]

/-- The entry `(row k, j)` of the mutated form is `Λ(-e_k + [b_{•k}]_+, e_j)`. -/
theorem formMutation_apply_row_left_pos (hc : IsCompatiblePair B Λ) {ε : ℤ}
    (hε : ε = 1 ∨ ε = -1) {j : M} (hj : j ≠ row k) :
    formMutation row B.matrix Λ k ε (row k) j =
      matrixForm Λ (-(Pi.single (row k) 1) + fun i => positivePart (B.matrix i k))
        (Pi.single j 1) := by
  rw [formMutation_apply_row_left row B.matrix Λ k (B.diagonal k) ε hj,
    hc.matrixForm_exchange_sign hε hj]

/-- The entry `(row k, j)` of the mutated form is `Λ(-e_k + [-b_{•k}]_+, e_j)`. -/
theorem formMutation_apply_row_left_neg (hc : IsCompatiblePair B Λ) {ε : ℤ}
    (hε : ε = 1 ∨ ε = -1) {j : M} (hj : j ≠ row k) :
    formMutation row B.matrix Λ k ε (row k) j =
      matrixForm Λ (-(Pi.single (row k) 1) + fun i => positivePart (-B.matrix i k))
        (Pi.single j 1) := by
  rw [hc.formMutation_apply_row_left_pos hε hj, hc.matrixForm_exchange_pos_eq_neg hj]

theorem formMutation_eq_one (hc : IsCompatiblePair B Λ) (hΛ : IsAlternatingMatrix Λ) {ε : ℤ}
    (hε : ε = 1 ∨ ε = -1) :
    formMutation row B.matrix Λ k ε = formMutation row B.matrix Λ k 1 := by
  have h1 : (1 : ℤ) = 1 ∨ (1 : ℤ) = -1 := Or.inl rfl
  have hrow {ε' : ℤ} (hε' : ε' = 1 ∨ ε' = -1) {j : M} (hj : j ≠ row k) :
      formMutation row B.matrix Λ k ε' (row k) j = formMutation row B.matrix Λ k 1 (row k) j := by
    rw [hc.formMutation_apply_row_left_pos hε' hj, hc.formMutation_apply_row_left_pos h1 hj]
  ext i j
  by_cases hi : i = row k <;> by_cases hj : j = row k
  · rw [hi, hj, formMutation_apply_row_row k hΛ, formMutation_apply_row_row k hΛ]
  · rw [hi]
    exact hrow hε hj
  · rw [hj, (hΛ.formMutation k ε) i (row k), (hΛ.formMutation k 1) i (row k), hrow hε hi]
  · rw [formMutation_apply_of_ne row B.matrix Λ k ε hi hj,
      formMutation_apply_of_ne row B.matrix Λ k 1 hi hj]

/-- The mutated form does not depend on the sign `ε`. -/
theorem formMutation_sign_eq (hc : IsCompatiblePair B Λ) (hΛ : IsAlternatingMatrix Λ)
    {ε ε' : ℤ} (hε : ε = 1 ∨ ε = -1) (hε' : ε' = 1 ∨ ε' = -1) :
    formMutation row B.matrix Λ k ε = formMutation row B.matrix Λ k ε' := by
  rw [hc.formMutation_eq_one hΛ hε, hc.formMutation_eq_one hΛ hε']

/-- Mutation preserves compatibility, with the same symmetrizer. -/
theorem mutation [Finite K] [DecidableEq K] (hc : IsCompatiblePair B Λ) {ε : ℤ}
    (hε : ε = 1 ∨ ε = -1) :
    IsCompatiblePair (B.mutate k) (formMutation row B.matrix Λ k ε) := by
  let : Fintype K := Fintype.ofFinite K
  have hdiag := B.diagonal k
  have hsym := B.symmetrized
  have hd := B.symmetrizer_pos
  have hmat := hc.transpose_mul
  rw [isCompatiblePair_iff_transpose_mul, ExtendedExchangeMatrix.mutate_matrix,
    ExtendedExchangeMatrix.mutate_symmetrizer,
    extendedMatrixMutation_factorization row B.matrix k ε hε hdiag, formMutation]
  have hEE : (mutationLeft row B.matrix k ε)ᵀ * (mutationLeft row B.matrix k ε)ᵀ = 1 := by
    rw [← Matrix.transpose_mul, mutationLeft_involutive, transpose_one]
  have hred : (mutationLeft row B.matrix k ε * B.matrix * mutationRight row B.matrix k ε)ᵀ *
      ((mutationLeft row B.matrix k ε)ᵀ * Λ * mutationLeft row B.matrix k ε) =
      ((compatibilityMatrix row B.symmetrizer * mutationLeft row B.matrix k ε)ᵀ *
        mutationRight row B.matrix k ε)ᵀ := by
    rw [← hmat]
    simp only [Matrix.transpose_mul, transpose_transpose, Matrix.mul_assoc]
    rw [← Matrix.mul_assoc (mutationLeft row B.matrix k ε)ᵀ (mutationLeft row B.matrix k ε)ᵀ,
      hEE, Matrix.one_mul]
  rw [hred]
  ext a l
  rw [transpose_apply, mul_mutationRight]
  simp only [transpose_apply, compatibilityMatrix_mul]
  have key : B.symmetrizer a * positivePart (-ε * B.matrix (row a) k) =
      B.symmetrizer k * positivePart (ε * B.matrix (row k) a) := by
    rw [mul_positivePart_of_nonneg (hd a).le, mul_positivePart_of_nonneg (hd k).le]
    congr 1
    linear_combination (-ε) * hsym a k
  simp only [neg_mul] at key
  by_cases hak : a = k
  · subst hak
    by_cases hl : l = row a
    · subst hl
      simp [mutationLeft, compatibilityMatrix]
    · simp [mutationLeft, compatibilityMatrix, hl, Ne.symm hl]
  · have hra : row a ≠ row k := row.injective.ne hak
    by_cases hl : l = row k
    · subst hl
      simp [mutationLeft, compatibilityMatrix, hak, hra, Ne.symm hra]
      linarith
    · by_cases hla : l = row a
      · subst hla
        simp [mutationLeft, compatibilityMatrix, hak, Ne.symm hak, hl]
      · simp [mutationLeft, compatibilityMatrix, hak, hl, Ne.symm hl, hla, Ne.symm hla]

/-- Mutating the pair at `k` and then the form again at `k` returns `Λ`. -/
theorem formMutation_involutive [Finite K] [DecidableEq K] (hc : IsCompatiblePair B Λ)
    (hΛ : IsAlternatingMatrix Λ) {ε ε' : ℤ} (hε : ε = 1 ∨ ε = -1) (hε' : ε' = 1 ∨ ε' = -1) :
    formMutation row (B.mutate k).matrix (formMutation row B.matrix Λ k ε) k ε' = Λ := by
  let : Fintype K := Fintype.ofFinite K
  have hε'' : -ε' = 1 ∨ -ε' = -1 := by omega
  rw [hc.formMutation_sign_eq hΛ hε hε'', formMutation, formMutation,
    ExtendedExchangeMatrix.mutate_matrix, mutationLeft_extendedMatrixMutation]
  have hE := mutationLeft_involutive row B.matrix k (-ε')
  have hEE : (mutationLeft row B.matrix k (-ε'))ᵀ * (mutationLeft row B.matrix k (-ε'))ᵀ = 1 := by
    rw [← Matrix.transpose_mul, hE, transpose_one]
  calc (mutationLeft row B.matrix k (-ε'))ᵀ *
        ((mutationLeft row B.matrix k (-ε'))ᵀ * Λ * mutationLeft row B.matrix k (-ε')) *
        mutationLeft row B.matrix k (-ε') =
      ((mutationLeft row B.matrix k (-ε'))ᵀ * (mutationLeft row B.matrix k (-ε'))ᵀ) * Λ *
        (mutationLeft row B.matrix k (-ε') * mutationLeft row B.matrix k (-ε')) := by
        simp only [Matrix.mul_assoc]
    _ = Λ := by rw [hEE, hE, Matrix.one_mul, Matrix.mul_one]

/-- The sign transport commutes with mutation of the form. -/
theorem formMutation_neg (hc : IsCompatiblePair B Λ) (hΛ : IsAlternatingMatrix Λ) {ε : ℤ}
    (hε : ε = 1 ∨ ε = -1) :
    formMutation row B.neg.matrix (-Λ) k ε = -formMutation row B.matrix Λ k ε := by
  have hε' : -ε = 1 ∨ -ε = -1 := by omega
  rw [ExtendedExchangeMatrix.neg_matrix, TauCeti.Cluster.formMutation_neg,
    hc.formMutation_sign_eq hΛ hε' hε]

end IsCompatiblePair

/-! ### The principal pair -/

section Principal

variable [Fintype K] [DecidableEq K]

/-- The principal extended matrix `B_ext_pr = (B₀; Id)`. -/
def principalPairMatrix (B₀ : K → K → ℤ) : Matrix (K ⊕ K) K ℤ :=
  Matrix.of (Sum.elim B₀ (1 : Matrix K K ℤ))

/-- The principal form `Λ_pr = ((0, -D), (D, B₀ᵀ D))`. -/
def principalPairForm (B₀ : K → K → ℤ) (d : K → ℤ) : Matrix (K ⊕ K) (K ⊕ K) ℤ :=
  Matrix.fromBlocks 0 (-diagonal d) (diagonal d) ((Matrix.of B₀)ᵀ * diagonal d)

variable (B₀ : K → K → ℤ) (d : K → ℤ)

omit [Fintype K] in
@[simp] theorem principalPairMatrix_inl (i j : K) :
    principalPairMatrix B₀ (Sum.inl i) j = B₀ i j := rfl

omit [Fintype K] in
@[simp] theorem principalPairMatrix_inr (i j : K) :
    principalPairMatrix B₀ (Sum.inr i) j = if i = j then 1 else 0 :=
  one_apply

@[simp] theorem principalPairForm_inl_inl (i j : K) :
    principalPairForm B₀ d (Sum.inl i) (Sum.inl j) = 0 := rfl

@[simp] theorem principalPairForm_inl_inr (i j : K) :
    principalPairForm B₀ d (Sum.inl i) (Sum.inr j) = if i = j then -d i else 0 := by
  simp [principalPairForm, diagonal_apply]

@[simp] theorem principalPairForm_inr_inl (i j : K) :
    principalPairForm B₀ d (Sum.inr i) (Sum.inl j) = if i = j then d i else 0 := by
  simp [principalPairForm, diagonal_apply]

@[simp] theorem principalPairForm_inr_inr (i j : K) :
    principalPairForm B₀ d (Sum.inr i) (Sum.inr j) = B₀ j i * d j := by
  simp [principalPairForm]

omit [Fintype K] in
/-- The principal pair's matrix is the initial principal extended matrix. -/
theorem principalPairMatrix_eq_principalExtendedMatrix (hd : ∀ i, 0 < d i)
    (hB : ∀ i j, d i * B₀ i j = -(d j * B₀ j i)) :
    principalPairMatrix B₀ = principalExtendedMatrix hd B₀ hB [] := by
  ext (i | i) j
  · rfl
  · simp [principalExtendedMatrix, eq_comm]

theorem principalPairForm_isAlternating (hB : ∀ i j, d i * B₀ i j = -(d j * B₀ j i)) :
    IsAlternatingMatrix (principalPairForm B₀ d) := by
  rintro (i | i) (j | j)
  · simp
  · by_cases h : i = j
    · subst h; simp
    · simp [h, Ne.symm h]
  · by_cases h : i = j
    · subst h; simp
    · simp [h, Ne.symm h]
  · simp only [principalPairForm_inr_inr]
    linarith [hB i j]

/-- `B_ext_prᵀ Λ_pr = (D 0)` for every `B₀` (singular or not), every `d` and every `K`. -/
theorem principalPair_transpose_mul :
    (principalPairMatrix B₀)ᵀ * principalPairForm B₀ d =
      compatibilityMatrix (Function.Embedding.inl : K ↪ K ⊕ K) d := by
  ext k l
  simp only [Matrix.mul_apply, transpose_apply, compatibilityMatrix]
  rw [Fintype.sum_sum_type]
  rcases l with j | j
  · by_cases h : j = k
    · subst h
      simp
    · simp [h]
  · simp

omit [Fintype K] in
/-- The principal extended exchange matrix `B_ext_pr = (B₀; Id)` of an exchange matrix `B₀` with
symmetrizer `d`. -/
def principalExchangeMatrix (hd : ∀ i, 0 < d i) (hB : ∀ i j, d i * B₀ i j = -(d j * B₀ j i)) :
    ExtendedExchangeMatrix (Function.Embedding.inl : K ↪ K ⊕ K) where
  matrix := principalPairMatrix B₀
  symmetrizer := d
  symmetrizer_pos := hd
  symmetrized := hB

variable {d} in
omit [Fintype K] in
@[simp] theorem principalExchangeMatrix_matrix (hd : ∀ i, 0 < d i)
    (hB : ∀ i j, d i * B₀ i j = -(d j * B₀ j i)) :
    (principalExchangeMatrix B₀ d hd hB).matrix = principalPairMatrix B₀ := rfl

variable {d} in
omit [Fintype K] in
@[simp] theorem principalExchangeMatrix_symmetrizer (hd : ∀ i, 0 < d i)
    (hB : ∀ i j, d i * B₀ i j = -(d j * B₀ j i)) :
    (principalExchangeMatrix B₀ d hd hB).symmetrizer = d := rfl

/-- The principal pair is compatible. -/
theorem principalPair_isCompatible (hd : ∀ i, 0 < d i)
    (hB : ∀ i j, d i * B₀ i j = -(d j * B₀ j i)) :
    IsCompatiblePair (principalExchangeMatrix B₀ d hd hB) (principalPairForm B₀ d) :=
  isCompatiblePair_iff_transpose_mul.2 (principalPair_transpose_mul B₀ d)

end Principal

end TauCeti.Cluster
