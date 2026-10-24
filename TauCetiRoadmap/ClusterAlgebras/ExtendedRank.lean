/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.MatrixMutation
public import Mathlib.LinearAlgebra.Matrix.Rank
public import Mathlib.Tactic

/-! # Extended Rank -/

@[expose] public section


namespace TauCeti.Cluster

open Matrix

variable {M K : Type*} [Fintype M] [Fintype K] [DecidableEq M] [DecidableEq K]

/-- Mutation of an extended integer matrix. The map `row` locates each mutable row. -/
def extendedMatrixMutation (row : K ↪ M) (B : Matrix M K ℤ) (k : K) : Matrix M K ℤ :=
  fun i j => if i = row k ∨ j = k then -B i j else
    B i j + positivePart (B i k) * positivePart (B (row k) j) -
      positivePart (-B i k) * positivePart (-B (row k) j)

/-- The left elementary mutation matrix, for either choice of sign. -/
def mutationLeft (row : K ↪ M) (B : Matrix M K ℤ) (k : K) (ε : ℤ) : Matrix M M ℤ :=
  fun i j => if j = row k then
    if i = row k then -1 else positivePart (-ε * B i k)
  else if i = j then 1 else 0

/-- The right elementary mutation matrix, for either choice of sign. -/
def mutationRight (row : K ↪ M) (B : Matrix M K ℤ) (k : K) (ε : ℤ) : Matrix K K ℤ :=
  fun i j => if i = k then
    if j = k then -1 else positivePart (ε * B (row k) j)
  else if i = j then 1 else 0

private theorem positivePart_mutation_identity (a b ε : ℤ) (hε : ε = 1 ∨ ε = -1) :
    positivePart (-ε * a) * b + a * positivePart (ε * b) =
      positivePart a * positivePart b - positivePart (-a) * positivePart (-b) := by
  rcases hε with rfl | rfl <;> simp only [one_mul, neg_one_mul, neg_neg]
  all_goals
    rcases le_total 0 a with ha | ha <;> rcases le_total 0 b with hb | hb <;>
      simp [positivePart, ha, hb]

omit [DecidableEq K] [Fintype K] in
theorem mutationLeft_mul {N : Type*} (row : K ↪ M) (B : Matrix M K ℤ)
    (C : Matrix M N ℤ) (k : K) (ε : ℤ) (i : M) (j : N) :
    (mutationLeft row B k ε * C) i j =
      if i = row k then -C i j else C i j + positivePart (-ε * B i k) * C (row k) j := by
  classical
  by_cases hi : i = row k
  · subst i
    simp only [Matrix.mul_apply, mutationLeft, ite_true, ite_mul, neg_one_mul, one_mul, zero_mul]
    have hh (x : M) :
        (if x = row k then -C x j else if row k = x then C x j else 0) =
          if x = row k then -C x j else 0 := by
      by_cases hx : x = row k <;> simp [hx, eq_comm]
    rw [Finset.sum_congr rfl (fun x _ => hh x)]
    simp
  · simp only [Matrix.mul_apply, mutationLeft, hi, ite_false, ite_mul, one_mul, zero_mul]
    have hh (x : M) :
        (if x = row k then positivePart (-ε * B i k) * C x j else
          if i = x then C x j else 0) =
        (if x = row k then positivePart (-ε * B i k) * C x j else 0) +
          (if i = x then C x j else 0) := by
      by_cases hx : x = row k <;> by_cases hix : i = x <;> simp_all
    rw [Finset.sum_congr rfl (fun x _ => hh x)]
    simp [Finset.sum_add_distrib, add_comm]

omit [DecidableEq M] [Fintype M] in
theorem mul_mutationRight {N : Type*} (row : K ↪ M) (B : Matrix M K ℤ)
    (C : Matrix N K ℤ) (k : K) (ε : ℤ) (i : N) (j : K) :
    (C * mutationRight row B k ε) i j =
      if j = k then -C i j else C i j + C i k * positivePart (ε * B (row k) j) := by
  classical
  by_cases hj : j = k
  · subst j
    simp only [Matrix.mul_apply, mutationRight, ite_true, mul_ite, mul_neg_one, mul_one, mul_zero]
    have hh (x : K) :
        (if x = k then -C i x else if x = k then C i x else 0) =
          if x = k then -C i x else 0 := by
      by_cases hx : x = k <;> simp [hx]
    rw [Finset.sum_congr rfl (fun x _ => hh x)]
    simp
  · simp only [Matrix.mul_apply, mutationRight, hj, ite_false, mul_ite, mul_one, mul_zero]
    have hh (x : K) :
        (if x = k then C i x * positivePart (ε * B (row k) j) else
          if x = j then C i x else 0) =
        (if x = k then C i x * positivePart (ε * B (row k) j) else 0) +
          (if x = j then C i x else 0) := by
      by_cases hx : x = k <;> by_cases hxj : x = j <;> simp_all
    rw [Finset.sum_congr rfl (fun x _ => hh x)]
    simp [Finset.sum_add_distrib, add_comm]

theorem extendedMatrixMutation_factorization (row : K ↪ M) (B : Matrix M K ℤ)
    (k : K) (ε : ℤ) (hε : ε = 1 ∨ ε = -1) (hdiag : B (row k) k = 0) :
    extendedMatrixMutation row B k = mutationLeft row B k ε * B * mutationRight row B k ε := by
  ext i j
  rw [mul_mutationRight, mutationLeft_mul]
  by_cases hi : i = row k
  · subst i
    by_cases hj : j = k <;> simp [extendedMatrixMutation, hj, hdiag, mutationLeft_mul]
  · by_cases hj : j = k
    · subst j
      simp [extendedMatrixMutation, hi, hdiag]
    · simp only [extendedMatrixMutation, hi, hj, false_or, ite_false]
      simp only [mutationLeft_mul, hi, hdiag, mul_zero, add_zero, ite_false]
      have h := positivePart_mutation_identity (B i k) (B (row k) j) ε hε
      linear_combination -h

omit [DecidableEq K] [Fintype K] in
theorem mutationLeft_involutive [Finite K] (row : K ↪ M) (B : Matrix M K ℤ) (k : K) (ε : ℤ) :
    mutationLeft row B k ε * mutationLeft row B k ε = 1 := by
  classical
  let : Fintype K := Fintype.ofFinite K
  ext i j
  rw [mutationLeft_mul]
  by_cases hi : i = row k
  · subst i
    by_cases hj : j = row k <;> simp [mutationLeft, Matrix.one_apply, hj, eq_comm]
  · by_cases hj : j = row k <;> simp [mutationLeft, Matrix.one_apply, hi, hj, eq_comm]

omit [DecidableEq M] [Fintype M] in
theorem mutationRight_involutive [Finite M] (row : K ↪ M) (B : Matrix M K ℤ) (k : K) (ε : ℤ) :
    mutationRight row B k ε * mutationRight row B k ε = 1 := by
  classical
  let : Fintype M := Fintype.ofFinite M
  ext i j
  rw [mul_mutationRight]
  by_cases hj : j = k
  · subst j
    by_cases hi : i = k <;> simp [mutationRight, Matrix.one_apply, hi]
  · have hkj : k ≠ j := Ne.symm hj
    by_cases hi : i = k <;> simp [mutationRight, Matrix.one_apply, hi, hj, hkj]

omit [Fintype M] in
/-- Integer elementary factorization preserves rank after any coefficient specialization. -/
theorem extendedMatrixMutation_rank_map [Finite M] (row : K ↪ M) (B : Matrix M K ℤ)
    (k : K) (hdiag : B (row k) k = 0) (R : Type*) [CommRing R]
    [StrongRankCondition R] (f : ℤ →+* R) :
    ((extendedMatrixMutation row B k).map f).rank = (B.map f).rank := by
  let : Fintype M := Fintype.ofFinite M
  let E := (mutationLeft row B k 1).map f
  let F := (mutationRight row B k 1).map f
  have hE : E * E = 1 := by
    simpa only [E, ← Matrix.map_mul, Matrix.map_one, map_zero, map_one] using
      congrArg (fun A : Matrix M M ℤ => A.map f) (mutationLeft_involutive row B k 1)
  have hF : F * F = 1 := by
    simpa only [F, ← Matrix.map_mul, Matrix.map_one, map_zero, map_one] using
      congrArg (fun A : Matrix K K ℤ => A.map f) (mutationRight_involutive row B k 1)
  have hfactor : (extendedMatrixMutation row B k).map f = E * B.map f * F := by
    simpa only [E, F, Matrix.map_mul] using
      congrArg (fun A : Matrix M K ℤ => A.map f)
        (extendedMatrixMutation_factorization row B k 1 (Or.inl rfl) hdiag)
  rw [hfactor]
  apply le_antisymm
  · exact (rank_mul_le_left (E * B.map f) F).trans
      (rank_mul_le_right E (B.map f))
  · have hback : B.map f = E * (E * B.map f * F) * F := by
      calc
        B.map f = E * (E * B.map f * (F * F)) := by
          rw [hF, Matrix.mul_one, ← Matrix.mul_assoc, hE, Matrix.one_mul]
        _ = E * (E * B.map f * F) * F := by simp only [Matrix.mul_assoc]
    calc
      (B.map f).rank = (E * (E * B.map f * F) * F).rank := congrArg Matrix.rank hback
      _ ≤ (E * B.map f * F).rank :=
        (rank_mul_le_left (E * (E * B.map f * F)) F).trans
          (rank_mul_le_right E (E * B.map f * F))

omit [DecidableEq K] [DecidableEq M] [Fintype M] in
/-- Full column rank supplies a nonzero minor for any two distinct columns. -/
theorem exists_two_minor_of_full_column_rank [Finite M] (A : Matrix M K ℚ)
    (hrank : A.rank = Fintype.card K) {i j : K} (hij : i ≠ j) :
    ∃ r s : M, A r i * A s j - A s i * A r j ≠ 0 := by
  let : Fintype M := Fintype.ofFinite M
  have hli : LinearIndependent ℚ A.col := by
    apply linearIndependent_iff_card_eq_finrank_span.mpr
    simpa [Set.finrank, Matrix.rank_eq_finrank_span_cols] using hrank.symm
  have hu : A.col i ≠ 0 := hli.ne_zero i
  obtain ⟨r, hr⟩ : ∃ r : M, A r i ≠ 0 := by
    by_contra h
    push Not at h
    exact hu (funext h)
  by_contra hminor
  push Not at hminor
  have hprop : A.col j = (A r j / A r i) • A.col i := by
    funext s
    have hs := hminor r s
    simp only [Matrix.col_apply, Pi.smul_apply, smul_eq_mul]
    field_simp
    nlinarith [hs]
  have hspan : A.col j ∈ Submodule.span ℚ (A.col '' {j}ᶜ) := by
    rw [hprop]
    apply Submodule.smul_mem
    exact Submodule.subset_span ⟨i, by simpa using hij, rfl⟩
  exact (hli.notMem_span j) hspan

omit [DecidableEq K] [DecidableEq M] [Fintype M] in
/-- The integer minor certificate used by Laurent-binomial coprimality. -/
theorem exists_integer_two_minor_of_full_column_rank [Finite M] (B : Matrix M K ℤ)
    (hrank : (B.map (Int.castRingHom ℚ)).rank = Fintype.card K)
    {i j : K} (hij : i ≠ j) :
    ∃ r s : M, B r i * B s j - B s i * B r j ≠ 0 := by
  classical
  let : Fintype M := Fintype.ofFinite M
  obtain ⟨r, s, h⟩ := exists_two_minor_of_full_column_rank
    (B.map (Int.castRingHom ℚ)) hrank hij
  refine ⟨r, s, ?_⟩
  intro hz
  apply h
  simpa only [Matrix.map_apply, map_sub, map_mul, map_zero] using
    congrArg (Int.castRingHom ℚ) hz

omit [DecidableEq K] [DecidableEq M] [Fintype M] in
/-- A minor witnessing independence stays away from two rows on which both columns vanish. -/
theorem exists_integer_two_minor_away_of_full_column_rank [Finite M] (row : K ↪ M)
    (B : Matrix M K ℤ)
    (hrank : (B.map (Int.castRingHom ℚ)).rank = Fintype.card K)
    {i j : K} (hij : i ≠ j)
    (hii : B (row i) i = 0) (hij0 : B (row i) j = 0)
    (hji0 : B (row j) i = 0) (hjj : B (row j) j = 0) :
    ∃ r s : {a : M // a ≠ row i ∧ a ≠ row j},
      B r.1 i * B s.1 j - B s.1 i * B r.1 j ≠ 0 := by
  classical
  let : Fintype M := Fintype.ofFinite M
  obtain ⟨r, s, hminor⟩ := exists_integer_two_minor_of_full_column_rank B hrank hij
  have away (a : M) (ha : a = r ∨ a = s) : a ≠ row i ∧ a ≠ row j := by
    constructor
    · intro hae
      rcases ha with rfl | rfl
      · exact hminor (by rw [hae, hii, hij0]; ring)
      · exact hminor (by rw [hae, hii, hij0]; ring)
    · intro hae
      rcases ha with rfl | rfl
      · exact hminor (by rw [hae, hji0, hjj]; ring)
      · exact hminor (by rw [hae, hji0, hjj]; ring)
  exact ⟨⟨r, away r (Or.inl rfl)⟩, ⟨s, away s (Or.inr rfl)⟩, hminor⟩

end TauCeti.Cluster
