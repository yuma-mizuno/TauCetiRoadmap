/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.MatrixConvention
public import Mathlib.Tactic.Linarith
public import Mathlib.Tactic.LinearCombination

/-! # Matrix Mutation -/

@[expose] public section

namespace TauCeti.Cluster

private theorem mutation_increment_symmetrized (a b c e di dj dk : ℤ)
    (hi : 0 < di) (hj : 0 < dj) (hk : 0 < dk)
    (ha : di * a = -(dk * c)) (hb : dk * b = -(dj * e)) :
    di * (positivePart a * positivePart b - positivePart (-a) * positivePart (-b)) =
      -(dj * (positivePart e * positivePart c - positivePart (-e) * positivePart (-c))) := by
  have hac := signSkewAt_of_positive_symmetrizer a c di dk hi hk ha
  have hbe := signSkewAt_of_positive_symmetrizer b e dk dj hk hj hb
  have heq : di * a * b = dj * e * c := by
    linear_combination b * ha - c * hb
  rcases hac with ⟨rfl, rfl⟩ | ⟨ha, hc⟩ | ⟨ha, hc⟩ <;>
    rcases hbe with ⟨rfl, rfl⟩ | ⟨hb, he⟩ | ⟨hb, he⟩ <;>
    simp (disch := omega) [positivePart] <;> nlinarith only [heq]

theorem matrixMutation_symmetrizer {I : Type*} [DecidableEq I]
    (B : I → I → ℤ) (d : I → ℤ) (hd : ∀ i, 0 < d i)
    (hB : ∀ i j, d i * B i j = -(d j * B j i)) (k : I) :
    ∀ i j, d i * matrixMutation B k i j = -(d j * matrixMutation B k j i) := by
  intro i j
  by_cases hi : i = k
  · subst i
    simp only [matrixMutation, true_or, or_true, ite_true]
    nlinarith [hB k j]
  · by_cases hj : j = k
    · subst j
      simp only [matrixMutation, true_or, or_true, ite_true]
      nlinarith [hB i k]
    · simp only [matrixMutation, hi, hj, false_or, ite_false]
      have h := mutation_increment_symmetrized (B i k) (B k j) (B k i) (B j k)
        (d i) (d j) (d k) (hd i) (hd j) (hd k) (hB i k) (hB k j)
      linear_combination h + hB i j

theorem matrixMutation_involutive {I : Type*} [DecidableEq I]
    (B : I → I → ℤ) (k : I) : matrixMutation (matrixMutation B k) k = B := by
  funext i j
  by_cases hi : i = k
  · subst i; simp [matrixMutation]
  · by_cases hj : j = k
    · subst j; simp [matrixMutation]
    · simp [matrixMutation, hi, hj]

end TauCeti.Cluster
