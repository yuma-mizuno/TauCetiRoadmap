/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.MutationWord
public import Mathlib.Algebra.Ring.Subring.Basic

/-!
# Upper bounds of an involutive family of charts

The order-theoretic statements need only a complete lattice. Concrete exchange
theories supply the local three-chart inclusions; neither Laurentness nor upper
bound invariance is part of their seed data. The subring application works in
an arbitrary ring, with no commutativity or finite-rank assumption.
-/

@[expose] public section

namespace TauCeti.Laurent.UpperBoundPattern

variable {A S I : Type*} [CompleteLattice A]

/-- A chart together with all its one-step neighbours. -/
def upperBound (L : S → A) (mutation : I → S → S) (s : S) : A :=
  L s ⊓ ⨅ i, L (mutation i s)

/-- The intersection of all charts reached by finite mutation words. -/
def reachableInf (L : S → A) (mutation : I → S → S) (s : S) : A :=
  ⨅ w : List I, L (mutateWord mutation w s)

theorem upperBound_le_chart (L : S → A) (mutation : I → S → S) (s : S) :
    upperBound L mutation s ≤ L s := inf_le_left

theorem reachableInf_le_upperBound (L : S → A) (mutation : I → S → S) (s : S) :
    reachableInf L mutation s ≤ upperBound L mutation s := by
  apply le_inf
  · exact iInf_le_of_le [] le_rfl
  · exact le_iInf fun i => iInf_le_of_le [i] le_rfl

/-- The local three-chart inclusions at one state give one upper-bound inclusion. -/
theorem upperBound_le_mutation (L : S → A) (mutation : I → S → S)
    (hinv : ∀ i, Function.Involutive (mutation i))
    (s : S) (i : I)
    (hlocal : ∀ j, j ≠ i →
      L s ⊓ L (mutation i s) ⊓ L (mutation j s) ≤ L (mutation j (mutation i s))) :
    upperBound L mutation s ≤ upperBound L mutation (mutation i s) := by
  apply le_inf
  · exact inf_le_right.trans (iInf_le _ i)
  · apply le_iInf
    intro j
    by_cases hji : j = i
    · subst j
      simpa only [hinv i s, upperBound] using
        (inf_le_left : upperBound L mutation s ≤ L s)
    · apply le_trans _ (hlocal j hji)
      exact le_inf
        (le_inf inf_le_left (inf_le_right.trans (iInf_le _ i)))
        (inf_le_right.trans (iInf_le _ j))

/-- A one-sided local inclusion suffices, since mutation is involutive. -/
theorem upperBound_mutation (L : S → A) (mutation : I → S → S)
    (hinv : ∀ i, Function.Involutive (mutation i))
    (hlocal : ∀ s i j, j ≠ i →
      L s ⊓ L (mutation i s) ⊓ L (mutation j s) ≤ L (mutation j (mutation i s)))
    (s : S) (i : I) : upperBound L mutation (mutation i s) = upperBound L mutation s := by
  apply le_antisymm _ (upperBound_le_mutation L mutation hinv s i (hlocal s i))
  simpa only [hinv i s] using
    upperBound_le_mutation L mutation hinv (mutation i s) i (hlocal (mutation i s) i)

theorem upperBound_mutateWord (L : S → A) (mutation : I → S → S)
    (hstable : ∀ s i, upperBound L mutation (mutation i s) = upperBound L mutation s)
    (w : List I) (s : S) :
    upperBound L mutation (mutateWord mutation w s) = upperBound L mutation s := by
  induction w generalizing s with
  | nil => rfl
  | cons i w ih => exact (ih (mutation i s)).trans (hstable s i)

theorem reachableInf_eq_upperBound (L : S → A) (mutation : I → S → S)
    (hstable : ∀ s i, upperBound L mutation (mutation i s) = upperBound L mutation s)
    (s : S) : reachableInf L mutation s = upperBound L mutation s := by
  apply le_antisymm (reachableInf_le_upperBound L mutation s)
  apply le_iInf
  intro w
  rw [← upperBound_mutateWord L mutation hstable w s]
  exact inf_le_left

section Subring

variable {F J : Type*} [Ring F]

/-- Generators in the local upper bounds belong to every reachable chart. -/
theorem generator_mem_chart (L : S → Subring F) (mutation : I → S → S)
    (g : S → J → F)
    (hstable : ∀ s i, upperBound L mutation (mutation i s) = upperBound L mutation s)
    (hself : ∀ s j, g s j ∈ L s)
    (hadj : ∀ s i j, g s j ∈ L (mutation i s))
    (s : S) (w : List I) (j : J) :
    g (mutateWord mutation w s) j ∈ L s := by
  have hm : g (mutateWord mutation w s) j ∈
      upperBound L mutation (mutateWord mutation w s) :=
    ⟨hself _ _, Subring.mem_iInf.mpr (fun i => hadj _ i _)⟩
  rw [upperBound_mutateWord L mutation hstable w s] at hm
  exact hm.1

end Subring
end TauCeti.Laurent.UpperBoundPattern
