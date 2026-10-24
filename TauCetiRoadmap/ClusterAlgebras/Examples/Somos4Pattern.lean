/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.InitialSeed
public import Mathlib.Algebra.Group.PUnit
public import Mathlib.LinearAlgebra.Matrix.Notation

/-! # Somos4Pattern -/

@[expose] public section

open TauCeti.Laurent
open TauCeti.Cluster

noncomputable section

namespace TauCeti.Examples.Somos4

instance trivialCoefficientSemifield : CoefficientSemifield PUnit where
  toCommGroup := inferInstance
  toAddCommSemigroup := inferInstance
  left_distrib _ _ _ := rfl
  right_distrib _ _ _ := rfl

/-- The cyclic mutable direction at recurrence time n, obtained by reducing n modulo four. -/
def label (n : ℕ) : Fin 4 := ⟨n % 4, Nat.mod_lt _ (by decide)⟩
/-- The initial skew-symmetric exchange matrix for the Somos-4 recurrence. -/
def sourceMatrix : Fin 4 → Fin 4 → ℤ :=
  !![0, -1, 2, -1; 1, 0, -3, 2; -2, 3, 0, -1; 1, -2, 1, 0]

/-- The source exchange matrix with both indices cyclically shifted to the given phase. -/
def phaseMatrix (p : Fin 4) (i j : Fin 4) : ℤ :=
  sourceMatrix ⟨(i.val + 4 - p.val) % 4, Nat.mod_lt _ (by decide)⟩
    ⟨(j.val + 4 - p.val) % 4, Nat.mod_lt _ (by decide)⟩
/-- The exchange matrix at recurrence time n, selected by its cyclic phase. -/
def spineMatrix (n : ℕ) := phaseMatrix (label n)
theorem phase_step (p : Fin 4) :
    phaseMatrix (label (p.val + 1)) = matrixMutation (phaseMatrix p) p := by
  fin_cases p <;> ext i j <;> fin_cases i <;> fin_cases j <;>
    norm_num [phaseMatrix, label, sourceMatrix, matrixMutation, positivePart]

theorem spineMatrix_succ (n : ℕ) :
    spineMatrix (n + 1) = matrixMutation (spineMatrix n) (label n) := by
  have h : label ((label n).val + 1) = label (n + 1) := by
    apply Fin.ext
    simp [label, Nat.add_mod]
  simpa only [h, spineMatrix] using phase_step (label n)

theorem source_symmetrized (i j : Fin 4) : sourceMatrix i j = -sourceMatrix j i := by
  fin_cases i <;> fin_cases j <;> norm_num [sourceMatrix]

theorem phase_symmetrized (p i j : Fin 4) : phaseMatrix p i j = -phaseMatrix p j i :=
  source_symmetrized _ _

/-- The coefficient-free Somos-4 matrix seed with unit symmetrizer. -/
def sourceSeed : MatrixSeed PUnit (Fin 4) (fun _ => 1) where
  matrix := sourceMatrix
  coefficient _ := 1
  symmetrized i j := by simpa using source_symmetrized i j

/-- The normalized mutation pattern of the four-variable, unit-symmetrizer seeds. -/
def pattern := MatrixSeed.pattern (C := PUnit) (I := Fin 4) (d := fun _ => 1) (fun _ => by norm_num)
theorem phase_diagonal (p i : Fin 4) : phaseMatrix p i i = 0 :=
  diagonal_of_positive_symmetrizer (phaseMatrix p) (fun _ => 1) (fun _ => by norm_num)
    (fun i j => by simpa using phase_symmetrized p i j) i

theorem phase_signSkew (p i j : Fin 4) :
    SignSkewAt (phaseMatrix p i j) (phaseMatrix p j i) :=
  signSkew_of_positive_symmetrizer (phaseMatrix p) (fun _ => 1) (fun _ => by norm_num)
    (fun i j => by simpa using phase_symmetrized p i j) i j

theorem phase_mutation_involutive (p k : Fin 4) :
    matrixMutation (matrixMutation (phaseMatrix p) k) k = phaseMatrix p :=
  matrixMutation_involutive _ _

theorem phase_mutation_diagonal (p k i : Fin 4) :
    matrixMutation (phaseMatrix p) k i i = 0 :=
  diagonal_of_positive_symmetrizer _ (fun _ => 1) (fun _ => by norm_num)
    (matrixMutation_symmetrizer (phaseMatrix p) (fun _ => 1) (fun _ => by norm_num)
      (fun i j => by simpa using phase_symmetrized p i j) k) i

theorem phase_mutation_signSkew (p k i j : Fin 4) :
    SignSkewAt (matrixMutation (phaseMatrix p) k i j)
      (matrixMutation (phaseMatrix p) k j i) :=
  signSkew_of_positive_symmetrizer _ (fun _ => 1) (fun _ => by norm_num)
    (matrixMutation_symmetrizer (phaseMatrix p) (fun _ => 1) (fun _ => by norm_num)
      (fun i j => by simpa using phase_symmetrized p i j) k) i j
@[simp] theorem spineMatrix_zero : spineMatrix 0 = sourceMatrix := by
  ext i j
  fin_cases i <;> fin_cases j <;> norm_num [spineMatrix, phaseMatrix, label, sourceMatrix]

/-- The finite cyclic mutation word, with no auxiliary tree. -/
def mutationWord (n : ℕ) : List (Fin 4) := (List.range n).map label
@[simp] theorem mutationWord_zero : mutationWord 0 = [] := rfl
@[simp] theorem mutationWord_succ (n : ℕ) :
    mutationWord (n + 1) = mutationWord n ++ [label n] := by
  simp [mutationWord, List.range_succ]

theorem mutationWord_matrix (n : ℕ) :
    (mutateWord pattern.mutation (mutationWord n) sourceSeed).matrix = spineMatrix n := by
  induction n with
  | zero => exact spineMatrix_zero.symm
  | succ n ih =>
    rw [mutationWord_succ, mutateWord_append]
    change matrixMutation (mutateWord pattern.mutation (mutationWord n) sourceSeed).matrix
      (label n) = spineMatrix (n + 1)
    rw [ih, spineMatrix_succ]

theorem phase_column (p i : Fin 4) :
    phaseMatrix p i p =
      if i = p then 0 else if i = label (p.val + 2) then -2 else 1 := by
  fin_cases p <;> fin_cases i <;>
    norm_num [phaseMatrix, sourceMatrix, matrixMutation, positivePart, label]

theorem spineMatrix_column (n : ℕ) (i : Fin 4) :
    spineMatrix n i (label n) =
      if i = label n then 0 else if i = label (n + 2) then -2 else 1 := by
  have h : label ((label n).val + 2) = label (n + 2) := by
    apply Fin.ext
    simp [label, Nat.add_mod]
  simpa only [h, spineMatrix] using phase_column (label n) i
end TauCeti.Examples.Somos4
