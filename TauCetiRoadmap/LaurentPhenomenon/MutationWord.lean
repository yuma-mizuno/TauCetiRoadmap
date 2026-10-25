/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import Mathlib.Data.List.Chain
public import Mathlib.Tactic

/-! Finite words of involutions, independent of any Laurent proof. -/

@[expose] public section
namespace TauCeti.Laurent
variable {I V : Type*}

/-- Apply elementary mutations successively in the order in which their labels occur in the list. -/
def mutateWord (mutation : I → V → V) : List I → V → V
  | [], s => s
  | i :: w, s => mutateWord mutation w (mutation i s)

@[simp] theorem mutateWord_nil (mutation : I → V → V) (s : V) :
    mutateWord mutation [] s = s := rfl

@[simp] theorem mutateWord_cons (mutation : I → V → V) (i : I) (w : List I) (s : V) :
    mutateWord mutation (i :: w) s = mutateWord mutation w (mutation i s) := rfl

theorem mutateWord_append (mutation : I → V → V) (u w : List I) (s : V) :
    mutateWord mutation (u ++ w) s = mutateWord mutation w (mutateWord mutation u s) := by
  induction u generalizing s with
  | nil => rfl
  | cons i u ih => exact ih (mutation i s)

/-- A map commuting with elementary mutations commutes with every mutation word. -/
theorem mutateWord_map {W : Type*} (mutation : I → V → V) (mutation' : I → W → W)
    (f : V → W) (hf : ∀ i s, f (mutation i s) = mutation' i (f s))
    (w : List I) (s : V) : f (mutateWord mutation w s) = mutateWord mutation' w (f s) := by
  induction w generalizing s with
  | nil => rfl
  | cons i w ih => rw [mutateWord_cons, ih, hf, mutateWord_cons]

theorem mutateWord_cancel (mutation : I → V → V)
    (hinv : ∀ i, Function.Involutive (mutation i)) (i : I) (w : List I) (s : V) :
    mutateWord mutation (i :: i :: w) s = mutateWord mutation w s := by
  simp only [mutateWord_cons, hinv i s]

theorem mutateWord_reverse (mutation : I → V → V)
    (hinv : ∀ i, Function.Involutive (mutation i)) (w : List I) (s : V) :
    mutateWord mutation w.reverse (mutateWord mutation w s) = s := by
  induction w generalizing s with
  | nil => rfl
  | cons i w ih =>
    simp only [List.reverse_cons, mutateWord_append, mutateWord_cons]
    rw [ih]
    exact hinv i s

section
variable [DecidableEq I]

/-- Cancel equal neighboring involutions, recursively retaining a reduced word. -/
def reduceMutationWord : List I → List I
  | [] => []
  | i :: w => match reduceMutationWord w with
    | [] => [i]
    | j :: v => if i = j then v else i :: j :: v

theorem reduceMutationWord_isChain (w : List I) :
    (reduceMutationWord w).IsChain (fun i j => i ≠ j) := by
  induction w with
  | nil => simp [reduceMutationWord]
  | cons i w ih =>
    cases hw : reduceMutationWord w with
    | nil => simp [reduceMutationWord, hw]
    | cons j v =>
      have hr : (j :: v).IsChain (fun i j => i ≠ j) := hw ▸ ih
      by_cases hij : i = j
      · simpa [reduceMutationWord, hw, hij] using hr.tail
      · simpa [reduceMutationWord, hw, hij, List.isChain_cons_cons] using And.intro hij hr

theorem mutateWord_reduce (mutation : I → V → V)
    (hinv : ∀ i, Function.Involutive (mutation i)) (w : List I) (s : V) :
    mutateWord mutation (reduceMutationWord w) s = mutateWord mutation w s := by
  induction w generalizing s with
  | nil => rfl
  | cons i w ih =>
    change mutateWord mutation (reduceMutationWord (i :: w)) s =
      mutateWord mutation w (mutation i s)
    rw [← ih]
    cases hw : reduceMutationWord w with
    | nil => simp [reduceMutationWord, hw, mutateWord]
    | cons j v =>
      by_cases hij : i = j
      · subst j
        simp [reduceMutationWord, hw, mutateWord, hinv i s]
      · simp [reduceMutationWord, hw, hij, mutateWord]

end
end TauCeti.Laurent
