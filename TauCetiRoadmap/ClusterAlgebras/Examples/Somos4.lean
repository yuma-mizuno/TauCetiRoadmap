/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.Examples.Somos4Pattern
public import TauCetiRoadmap.ClusterAlgebras.Examples.Somos4Sequence
public import TauCetiRoadmap.ClusterAlgebras.SeedEvaluation
public import TauCetiRoadmap.LaurentPhenomenon.IntegerEvaluation
public import TauCetiRoadmap.ClusterAlgebras.InitialLaurent
public import TauCetiRoadmap.ClusterAlgebras.ExpressionCoordinates

/-! # Somos4 -/

@[expose] public section

open TauCeti.Laurent
open TauCeti.Cluster

/-!
# Somos-4 integrality from the upper-bound Laurent theorem

The rational sequence is defined independently in `Somos4Sequence`. Its cyclic
windows agree with the evaluated cluster coordinates of `Somos4Pattern`.
The all-one specialization of the proved Laurent theorem then gives integrality.
-/
noncomputable section
namespace TauCeti.Examples.Somos4
open scoped BigOperators

theorem phase_mutate_window (p : Fin 4) (w : Fin 4 → ℚ) :
    mutateCoordinateValues allOnes
      (seedExchange (1 : PUnit) (fun i => phaseMatrix p i p)) p (rotated p w) =
      rotated (label (p.val + 1)) (step w) := by
  have he := coordinateEvaluate_seedExchange (I := Fin 4) (F := ℚ) (C := PUnit)
    (allOnes (G := Additive PUnit) (I := Fin 4))
    (fun g => allOnes_single (g, 0) 1) (1 : PUnit)
    (fun i => phaseMatrix p i p) (rotated p w)
  unfold mutateCoordinateValues
  rw [he]
  funext i
  fin_cases p <;> fin_cases i <;>
    norm_num [rotated, label, step, phaseMatrix, sourceMatrix, positivePart,
      Fin.prod_univ_succ, Function.update_apply]
  all_goals ring

theorem labelledWindow_succ (n : ℕ) :
    labelledWindow (n + 1) = mutateCoordinateValues allOnes
      (seedExchange (1 : PUnit) (fun i => spineMatrix n i (label n)))
      (label n) (labelledWindow n) := by
  have hlabel : label ((label n).val + 1) = label (n + 1) := by
    apply Fin.ext
    simp [label, Nat.add_mod]
  have h := phase_mutate_window (label n) (window n)
  rw [hlabel] at h
  simpa only [labelledWindow, spineMatrix, window_succ, label] using h.symm

theorem labelledWindow_initial : labelledWindow 0 =
    initialVariables (allOnes (G := Additive PUnit)) := by
  funext i
  simp [labelledWindow, rotated]

/-- Actual word evaluation gives the independently defined sliding window. -/
theorem wordCoordinates_eq_window (n : ℕ) :
    pattern.wordCoordinates allOnes sourceSeed (mutationWord n) = labelledWindow n := by
  induction n with
  | zero => exact labelledWindow_initial.symm
  | succ n ih =>
    rw [mutationWord_succ, pattern.wordCoordinates_append_single, ih]
    change mutateCoordinateValues allOnes
      (seedExchange ((mutateWord pattern.mutation (mutationWord n) sourceSeed).coefficient (label
        n))
        (fun i => (mutateWord pattern.mutation (mutationWord n) sourceSeed).matrix i (label n)))
      (label n) (labelledWindow n) = _
    have hc : (mutateWord pattern.mutation (mutationWord n) sourceSeed).coefficient (label n) = 1 :=
      Subsingleton.elim _ _
    rw [hc, mutationWord_matrix]
    exact (labelledWindow_succ n).symm

/-- Every term is integral by specializing the proved upper-bound Laurent
representation at the all-one initial chart. -/
theorem sequence_integral (n : ℕ) : ∃ z : ℤ, (z : ℚ) = sequence n := by
  obtain ⟨r, hr, _⟩ := sourceSeed.cluster_laurent_unique (fun _ => by norm_num)
    (mutationWord n) (label n)
  have h := pattern.wordCoordinates_specialize allOnes allOnes_positive sourceSeed
    (mutationWord n) (label n) r hr
  rw [wordCoordinates_eq_window] at h
  exact ⟨allOnesInteger r, h.symm.trans (labelledWindow_head n)⟩

/-- The conclusion applies to any rational sequence satisfying the usual initial
conditions and recurrence, independently of the sliding-window implementation. -/
theorem integral_of_recurrence (a : ℕ → ℚ)
    (hinit : ∀ i : Fin 4, a i.val = 1)
    (hrec : ∀ n, a (n + 4) * a n = a (n + 1) * a (n + 3) + (a (n + 2)) ^ 2)
    (n : ℕ) : ∃ z : ℤ, (z : ℚ) = a n := by
  rw [sequence_unique a hinit hrec]
  exact sequence_integral n

/-- Standard Somos-4 has strictly positive integer terms. -/
theorem sequence_positive_integral (n : ℕ) :
    ∃ z : ℤ, 0 < z ∧ (z : ℚ) = sequence n := by
  obtain ⟨z, hz⟩ := sequence_integral n
  refine ⟨z, ?_, hz⟩
  have h : (0 : ℚ) < z := hz.symm ▸ sequence_pos n
  exact_mod_cast h

end TauCeti.Examples.Somos4
