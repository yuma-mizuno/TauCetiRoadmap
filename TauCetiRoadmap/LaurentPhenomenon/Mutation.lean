/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.MutationWord
public import Mathlib.Algebra.Ring.Subring.Basic

/-! # Mutation -/

@[expose] public section

namespace TauCeti.Laurent
variable {I V : Type*}

/-- The finite-word caterpillar induction. No Laurentness is assumed at distance
greater than one. The second shorter path starts at `i j i(s)` and has word
`i :: tail`, so its length is smaller even without choosing reduced words. -/
theorem laurent_of_local_intersections {F : Type*} [Ring F]
    (mutation : I → V → V) (hinv : ∀ i, Function.Involutive (mutation i))
    (L : V → Subring F) (x : V → I → F)
    (hzero : ∀ s k, x s k ∈ L s)
    (hone : ∀ s i k, x (mutation i s) k ∈ L s)
    (hlocal : ∀ s i j, i ≠ j →
      L (mutation i s) ⊓ L (mutation i (mutation j (mutation i s))) ≤ L s)
    (w : List I) (s : V) (k : I) : x (mutateWord mutation w s) k ∈ L s := by
  induction w using (measure List.length).wf.induction generalizing s with
  | _ w ih =>
    cases w with
    | nil => exact hzero s k
    | cons i w =>
      cases w with
      | nil => exact hone s i k
      | cons j w =>
        by_cases hij : i = j
        · subst j
          rw [mutateWord_cancel mutation hinv]
          exact ih w (by change w.length < (i :: i :: w).length; simp) s
        · apply hlocal s i j hij
          constructor
          · exact ih (j :: w)
              (by change (j :: w).length < (i :: j :: w).length; simp) (mutation i s)
          · have h := ih (i :: w)
              (by change (i :: w).length < (i :: j :: w).length; simp)
              (mutation i (mutation j (mutation i s)))
            change x (mutateWord mutation w (mutation j (mutation i s))) k ∈
              L (mutation i (mutation j (mutation i s)))
            simp only [mutateWord_cons, hinv i (mutation j (mutation i s))] at h
            exact h

end TauCeti.Laurent
