/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.FiniteCaterpillar
public import TauCetiRoadmap.LaurentPhenomenon.Mutation
public import Mathlib.Data.List.OfFn
public import Mathlib.Data.List.Chain

/-! # Path Realization -/

@[expose] public section

namespace TauCeti.Laurent

namespace CaterpillarPath

variable {I V : Type*} (P : CaterpillarPath I) (mutation : I → V → V) (s : V)

/-- The actual seed after the first n labels on the spine. -/
def seedOnSpine : (n : ℕ) → n ≤ P.length → V
  | 0, _ => s
  | n + 1, hn => mutation (P.label ⟨n, by omega⟩) (seedOnSpine n (by omega))

/-- Every attached leaf is obtained by its one additional mutation. -/
def seedAt : P.Vertex → V
  | Sum.inl k => P.seedOnSpine mutation s k.val (by have := k.isLt; omega)
  | Sum.inr q => mutation q.val.2
      (P.seedOnSpine mutation s (q.val.1.val + 1) (by have := q.val.1.isLt; omega))

@[simp] theorem seedAt_source : P.seedAt mutation s P.source = s := rfl
@[simp] theorem seedAt_target : P.seedAt mutation s P.target = P.seedOnSpine mutation s P.length
  le_rfl := rfl

theorem seedAt_edge (hinv : ∀ i, Function.Involutive (mutation i))
    {a b : P.Vertex} {i : I} (he : P.Edge a b i) :
    P.seedAt mutation s b = mutation i (P.seedAt mutation s a) := by
  cases he with
  | path_forward k => rfl
  | path_backward k => exact (hinv _ _).symm
  | leaf_forward q => rfl
  | leaf_backward q => exact (hinv _ _).symm

/-- The ordered list of labels on the first n spine edges. -/
def prefixWord (n : ℕ) (hn : n ≤ P.length) : List I :=
  List.ofFn (fun k : Fin n => P.label ⟨k.val, by omega⟩)

@[simp] theorem prefixWord_zero : P.prefixWord 0 (by omega) = [] := rfl
theorem prefixWord_succ (n : ℕ) (hn : n + 1 ≤ P.length) :
    P.prefixWord (n + 1) hn = P.prefixWord n (by omega) ++ [P.label ⟨n, by omega⟩] := by
  unfold prefixWord
  rw [List.ofFn_succ']
  rw [List.concat_eq_append]
  rfl

theorem seedOnSpine_eq_mutateWord (n : ℕ) (hn : n ≤ P.length) :
    P.seedOnSpine mutation s n hn = mutateWord mutation (P.prefixWord n hn) s := by
  induction n with
  | zero => rfl
  | succ n ih =>
    rw [P.prefixWord_succ, mutateWord_append]
    change mutation (P.label ⟨n, by omega⟩) (P.seedOnSpine mutation s n (by omega)) =
      mutation (P.label ⟨n, by omega⟩) (mutateWord mutation (P.prefixWord n (by omega)) s)
    rw [ih]

/-- The complete ordered mutation word along the distinguished spine. -/
def pathWord : List I := P.prefixWord P.length le_rfl
theorem seedAt_target_eq_mutateWord :
    P.seedAt mutation s P.target = mutateWord mutation P.pathWord s :=
  P.seedOnSpine_eq_mutateWord mutation s P.length le_rfl

end CaterpillarPath

section WordReduction

variable {I V : Type*} [DecidableEq I]

/-- The finite caterpillar spine labelled by the mutation word after adjacent equal labels are
cancelled.
-/
def reducedWordPath (w : List I) : CaterpillarPath I where
  length := (reduceMutationWord w).length
  label := (reduceMutationWord w).get
  reduced k hk := by
    have hc := reduceMutationWord_isChain w
    rw [List.isChain_iff_getElem] at hc
    exact hc k.val hk

theorem reducedWordPath_word (w : List I) : (reducedWordPath w).pathWord = reduceMutationWord w :=
  by
  simp [CaterpillarPath.pathWord, CaterpillarPath.prefixWord, reducedWordPath]

/-- The finite tree assignment reaches the original word's endpoint, with no
assumption that the submitted word was reduced. -/
theorem reducedWordPath_target (mutation : I → V → V)
    (hinv : ∀ i, Function.Involutive (mutation i)) (w : List I) (s : V) :
    (reducedWordPath w).seedAt mutation s (reducedWordPath w).target = mutateWord mutation w s := by
  rw [CaterpillarPath.seedAt_target_eq_mutateWord, reducedWordPath_word,
    mutateWord_reduce mutation hinv]

end WordReduction

end TauCeti.Laurent
