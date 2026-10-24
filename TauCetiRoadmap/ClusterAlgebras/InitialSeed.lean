/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.MutationPattern
public import TauCetiRoadmap.ClusterAlgebras.Normalization
public import TauCetiRoadmap.ClusterAlgebras.MatrixMutation

/-! # Initial Seed -/

@[expose] public section

open TauCeti.Laurent

noncomputable section
namespace TauCeti.Cluster

variable {C I : Type*} [CoefficientSemifield C] [DecidableEq I]

/-- Matrix and coefficient data with a fixed integral symmetrizing identity.
Mutation and the normalized pattern require positivity of the symmetrizer. -/
structure MatrixSeed (C I : Type*) [CoefficientSemifield C] (d : I → ℤ) where
  /-- The initial exchange matrix, indexed by mutable directions. -/
  matrix : I → I → ℤ
  /-- The initial coefficient tuple in the chosen coefficient semifield. -/
  coefficient : I → C
  symmetrized : ∀ i j, d i * matrix i j = -(d j * matrix j i)

namespace MatrixSeed
@[ext] theorem ext {C I : Type*} [CoefficientSemifield C] {d : I → ℤ}
    (s t : MatrixSeed C I d) (hB : s.matrix = t.matrix)
    (hy : s.coefficient = t.coefficient) : s = t := by
  cases s; cases t; cases hB; cases hy; rfl
variable {d : I → ℤ}

/-- Mutate the matrix and coefficient tuple while preserving the fixed symmetrizer. -/
def mutate (hd : ∀ i, 0 < d i) (k : I) (s : MatrixSeed C I d) : MatrixSeed C I d where
  matrix := matrixMutation s.matrix k
  coefficient i := if i = k then (s.coefficient k)⁻¹ else
    coefficientMutation (s.coefficient i) (s.coefficient k) (s.coefficient k + 1) (s.matrix k i)
  symmetrized := matrixMutation_symmetrizer s.matrix d hd s.symmetrized k

theorem mutate_involutive (hd : ∀ i, 0 < d i) (k : I) :
    Function.Involutive (mutate (C := C) hd k) := by
  intro s
  cases s with
  | mk B y hB =>
    apply MatrixSeed.ext
    · exact matrixMutation_involutive B k
    · funext i
      by_cases hi : i = k
      · subst i; simp [mutate]
      · simp only [mutate, hi, ite_false, ite_true, matrixMutation, true_or]
        exact coefficientMutation_involutive (y i) (y k) (B k i)

/-- Every actual skew-symmetrizable seed gives the reusable normalized pattern. -/
def pattern (hd : ∀ i, 0 < d i) : NormalizedMutationPattern C I (MatrixSeed C I d) where
  mutation := mutate hd
  involutive := mutate_involutive hd
  matrix := MatrixSeed.matrix
  coefficient := MatrixSeed.coefficient
  diagonal s := diagonal_of_positive_symmetrizer s.matrix d hd s.symmetrized
  signSkew s := signSkew_of_positive_symmetrizer s.matrix d hd s.symmetrized
  matrix_law _ _ := rfl
  coefficient_self _ _ := by simp [mutate]
  coefficient_other _ _ _ hi := by simp [mutate, hi]

end MatrixSeed
end TauCeti.Cluster
