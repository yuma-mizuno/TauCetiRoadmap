/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import Mathlib.Basic.Finite.Sum
public import Mathlib.Basic.Finite.Prod
public import Mathlib.Combinatorics.SimpleGraph.Acyclic
public import Lean.Elab.Tactic.Omega

/-! # Finite Caterpillar -/

@[expose] public section

namespace TauCeti.Laurent

/-- A reduced finite path; length zero and one have no internal stars. -/
structure CaterpillarPath (I : Type*) where
  /-- The number of labelled edges on the distinguished spine. -/
  length : ℕ
  /-- The mutable direction attached to each spine edge. -/
  label : Fin length → I
  reduced : ∀ (k : Fin length) (h : k.val + 1 < length),
    label k ≠ label ⟨k.val + 1, h⟩

namespace CaterpillarPath

variable {I : Type*} (P : CaterpillarPath I)

/-- The left edge index in a pair of consecutive spine edges. -/
def leftIndex (p : Fin (P.length - 1)) : Fin P.length := ⟨p.val, by omega⟩
/-- The right edge index in a pair of consecutive spine edges. -/
def rightIndex (p : Fin (P.length - 1)) : Fin P.length := ⟨p.val + 1, by omega⟩
/-- The spine vertex shared by the two consecutive edges indexed by p and p+1. -/
def internalIndex (p : Fin (P.length - 1)) : Fin (P.length + 1) :=
  ⟨p.val + 1, by omega⟩

/-- The label of the left edge incident to the selected internal spine vertex. -/
def leftLabel (p : Fin (P.length - 1)) : I := P.label (P.leftIndex p)
/-- The label of the right edge incident to the selected internal spine vertex. -/
def rightLabel (p : Fin (P.length - 1)) : I := P.label (P.rightIndex p)
theorem leftLabel_ne_rightLabel (p : Fin (P.length - 1)) :
    P.leftLabel p ≠ P.rightLabel p := P.reduced (P.leftIndex p) (by dsimp [leftIndex]; omega)

/-- Only labels missing from the two path edges give attached leaves. -/
def Leaf := {q : Fin (P.length - 1) × I //
  q.2 ≠ P.leftLabel q.1 ∧ q.2 ≠ P.rightLabel q.1}

/-- The disjoint union of spine vertices and attached leaves. -/
def Vertex := Fin (P.length + 1) ⊕ P.Leaf
instance [Finite I] : Finite P.Leaf := Subtype.finite
instance [Finite I] : Finite P.Vertex := by unfold Vertex; infer_instance

/-- Include a spine vertex in the full caterpillar vertex type. -/
def spine (k : Fin (P.length + 1)) : P.Vertex := Sum.inl k
/-- Include an attached leaf in the full caterpillar vertex type. -/
def leaf (q : P.Leaf) : P.Vertex := Sum.inr q
/-- The first spine vertex, at which the initial coordinate tuple is prescribed. -/
def source : P.Vertex := P.spine ⟨0, by omega⟩
/-- The last spine vertex, whose coordinates are the Laurentness target. -/
def target : P.Vertex := P.spine ⟨P.length, by omega⟩
/-- Labeled edges are precisely path edges and attachments, in both directions. -/
inductive Edge : P.Vertex → P.Vertex → I → Prop
  | path_forward (k : Fin P.length) :
      Edge (P.spine ⟨k.val, by omega⟩) (P.spine ⟨k.val + 1, by omega⟩) (P.label k)
  | path_backward (k : Fin P.length) :
      Edge (P.spine ⟨k.val + 1, by omega⟩) (P.spine ⟨k.val, by omega⟩) (P.label k)
  | leaf_forward (q : P.Leaf) :
      Edge (P.spine (P.internalIndex q.val.1)) (P.leaf q) q.val.2
  | leaf_backward (q : P.Leaf) :
      Edge (P.leaf q) (P.spine (P.internalIndex q.val.1)) q.val.2

theorem Edge.symm {a b : P.Vertex} {i : I} (h : P.Edge a b i) : P.Edge b a i := by
  cases h with
  | path_forward k => exact Edge.path_backward k
  | path_backward k => exact Edge.path_forward k
  | leaf_forward q => exact Edge.leaf_backward q
  | leaf_backward q => exact Edge.leaf_forward q

theorem Edge.ne {a b : P.Vertex} {i : I} (h : P.Edge a b i) : a ≠ b := by
  intro hab
  cases h with
  | path_forward k =>
    unfold spine at hab
    injection hab with hk
    have := congrArg Fin.val hk
    dsimp at this
    omega
  | path_backward k =>
    unfold spine at hab
    injection hab with hk
    have := congrArg Fin.val hk
    dsimp at this
    omega
  | leaf_forward q => simp [spine, leaf] at hab
  | leaf_backward q => simp [spine, leaf] at hab

/-- Every label has an explicit neighbor at an internal star. -/
noncomputable def starNeighbor (p : Fin (P.length - 1)) (i : I) : P.Vertex := by
  classical
  exact if hl : i = P.leftLabel p then P.spine ⟨p.val, by omega⟩
    else if hr : i = P.rightLabel p then P.spine ⟨p.val + 2, by omega⟩
    else P.leaf ⟨(p, i), hl, hr⟩

theorem starNeighbor_edge (p : Fin (P.length - 1)) (i : I) :
    P.Edge (P.spine (P.internalIndex p)) (P.starNeighbor p i) i := by
  classical
  unfold starNeighbor
  split_ifs with hl hr
  · subst i
    exact Edge.path_backward (P.leftIndex p)
  · subst i
    exact Edge.path_forward (P.rightIndex p)
  · exact Edge.leaf_forward ⟨(p, i), hl, hr⟩

theorem starNeighbor_left (p : Fin (P.length - 1)) :
    P.starNeighbor p (P.leftLabel p) = P.spine ⟨p.val, by omega⟩ := by
  classical
  simp [starNeighbor]

theorem starNeighbor_right (p : Fin (P.length - 1)) :
    P.starNeighbor p (P.rightLabel p) = P.spine ⟨p.val + 2, by omega⟩ := by
  classical
  simp [starNeighbor, (P.leftLabel_ne_rightLabel p).symm]

theorem Edge.eq_starNeighbor {a b : P.Vertex} {i : I} (he : P.Edge a b i)
    (p : Fin (P.length - 1)) (ha : a = P.spine (P.internalIndex p)) :
    b = P.starNeighbor p i := by
  classical
  cases he with
  | path_forward k =>
    have hk : k = P.rightIndex p := by
      apply Fin.ext
      have hh := congrArg Fin.val (Sum.inl.inj ha)
      exact hh
    subst k
    exact (P.starNeighbor_right p).symm
  | path_backward k =>
    have hk : k = P.leftIndex p := by
      apply Fin.ext
      have hh := congrArg Fin.val (Sum.inl.inj ha)
      dsimp [internalIndex] at hh
      dsimp [leftIndex]
      omega
    subst k
    exact (P.starNeighbor_left p).symm
  | leaf_forward q =>
    rcases q with ⟨⟨r, i⟩, hri⟩
    have hr : r = p := by
      apply Fin.ext
      have hh := congrArg Fin.val (Sum.inl.inj ha)
      dsimp [internalIndex] at hh
      omega
    subst r
    simp [starNeighbor, hri.1, hri.2]
  | leaf_backward q => simp [leaf, spine] at ha

theorem star_neighbor_unique (p : Fin (P.length - 1)) (i : I) :
    ∃! b, P.Edge (P.spine (P.internalIndex p)) b i := by
  refine ⟨P.starNeighbor p i, P.starNeighbor_edge p i, ?_⟩
  intro b hb
  exact Edge.eq_starNeighbor P hb p rfl

theorem map_starNeighbor {Q : CaterpillarPath I} (f : Q.Vertex → P.Vertex)
    (hf : ∀ {a b i}, Q.Edge a b i → P.Edge (f a) (f b) i)
    (p : Fin (Q.length - 1)) (q : Fin (P.length - 1))
    (hc : f (Q.spine (Q.internalIndex p)) = P.spine (P.internalIndex q)) (i : I) :
    f (Q.starNeighbor p i) = P.starNeighbor q i :=
  Edge.eq_starNeighbor P (hf (Q.starNeighbor_edge p i)) q hc

/-- The first internal vertex index of a pair of consecutive internal stars. -/
def interiorLeft (p : Fin (P.length - 2)) : Fin (P.length - 1) := ⟨p.val, by omega⟩
/-- The second internal vertex index of a pair of consecutive internal stars. -/
def interiorRight (p : Fin (P.length - 2)) : Fin (P.length - 1) := ⟨p.val + 1, by omega⟩
/-- The smaller caterpillar rooted at the next spine vertex. -/
def tail : CaterpillarPath I where
  length := P.length - 1
  label k := P.label ⟨k.val + 1, by omega⟩
  reduced k h := P.reduced ⟨k.val + 1, by omega⟩ (by dsimp; omega)

@[simp] theorem tail_length : P.tail.length = P.length - 1 := rfl
/-- The embedding includes all required internal legs of the shortened spine. -/
def tailEmbedding (hpos : 0 < P.length) : P.tail.Vertex → P.Vertex
  | Sum.inl k => P.spine ⟨k.val + 1, by have := k.isLt; simp at this; omega⟩
  | Sum.inr q => P.leaf ⟨(⟨q.val.1.val + 1, by
      have := q.val.1.isLt
      simp only [tail_length] at this
      omega⟩, q.val.2), by
      constructor
      · exact q.property.1
      · exact q.property.2⟩

theorem tailEmbedding_source (hpos : 0 < P.length) :
    P.tailEmbedding hpos P.tail.source = P.spine ⟨1, by omega⟩ := rfl

theorem tailEmbedding_target (hpos : 0 < P.length) :
    P.tailEmbedding hpos P.tail.target = P.target := by
  apply congrArg Sum.inl
  apply Fin.ext
  change P.length - 1 + 1 = P.length
  omega

/-- Every edge, including every attached leg, keeps its label and orientation. -/
theorem tailEmbedding_edge (hpos : 0 < P.length) {a b : P.tail.Vertex} {i : I}
    (h : P.tail.Edge a b i) :
    P.Edge (P.tailEmbedding hpos a) (P.tailEmbedding hpos b) i := by
  cases h with
  | path_forward k => exact Edge.path_forward ⟨k.val + 1, by have := k.isLt; simp at this; omega⟩
  | path_backward k => exact Edge.path_backward ⟨k.val + 1, by have := k.isLt; simp at this; omega⟩
  | leaf_forward q =>
    exact Edge.leaf_forward ⟨(⟨q.val.1.val + 1, by
      have hq : q.val.1.val < P.length - 1 - 1 := q.val.1.isLt
      omega⟩, q.val.2), q.property⟩
  | leaf_backward q =>
    exact Edge.leaf_backward ⟨(⟨q.val.1.val + 1, by
      have hq : q.val.1.val < P.length - 1 - 1 := q.val.1.isLt
      omega⟩, q.val.2), q.property⟩

theorem tailEmbedding_injective (hpos : 0 < P.length) :
    Function.Injective (P.tailEmbedding hpos) := by
  intro a b hab
  cases a with
  | inl a =>
    cases b with
    | inl b =>
      apply congrArg Sum.inl
      apply Fin.ext
      have h := congrArg Fin.val (Sum.inl.inj hab)
      dsimp [tailEmbedding, spine] at h
      omega
    | inr b => simp [tailEmbedding, spine, leaf] at hab
  | inr a =>
    cases b with
    | inl b => simp [tailEmbedding, spine, leaf] at hab
    | inr b =>
      apply congrArg Sum.inr
      apply Subtype.ext
      apply Prod.ext
      · apply Fin.ext
        have h := congrArg (fun q : P.Leaf => q.val.1.val) (Sum.inr.inj hab)
        dsimp [tailEmbedding, leaf] at h
        omega
      · exact congrArg (fun q : P.Leaf => q.val.2) (Sum.inr.inj hab)

/-- The path obtained by taking the tail three times, with saturated natural-number subtraction. -/
def dropThree := P.tail.tail.tail
@[simp] theorem dropThree_length : P.dropThree.length = P.length - 3 := by
  dsimp [dropThree, tail]
  omega

/-- Embed the path with its first three spine edges removed into the original caterpillar. -/
def dropThreeEmbedding (h : 3 ≤ P.length) : P.dropThree.Vertex → P.Vertex :=
  P.tailEmbedding (by omega) ∘
    P.tail.tailEmbedding (by dsimp [tail]; omega) ∘
      P.tail.tail.tailEmbedding (by dsimp [tail]; omega)

theorem dropThreeEmbedding_injective (h : 3 ≤ P.length) :
    Function.Injective (P.dropThreeEmbedding h) :=
  (P.tailEmbedding_injective (by omega)).comp
    ((P.tail.tailEmbedding_injective (by dsimp [tail]; omega)).comp
      (P.tail.tail.tailEmbedding_injective (by dsimp [tail]; omega)))

theorem dropThreeEmbedding_source (h : 3 ≤ P.length) :
    P.dropThreeEmbedding h P.dropThree.source = P.spine ⟨3, by omega⟩ := rfl

theorem dropThreeEmbedding_target (h : 3 ≤ P.length) :
    P.dropThreeEmbedding h P.dropThree.target = P.target := by
  unfold dropThreeEmbedding dropThree
  simp only [Function.comp_apply, tailEmbedding_target]

theorem dropThreeEmbedding_edge (h : 3 ≤ P.length)
    {a b : P.dropThree.Vertex} {i : I} (he : P.dropThree.Edge a b i) :
    P.Edge (P.dropThreeEmbedding h a) (P.dropThreeEmbedding h b) i := by
  exact P.tailEmbedding_edge (by omega) (P.tail.tailEmbedding_edge (by dsimp [tail]; omega)
    (P.tail.tail.tailEmbedding_edge (by dsimp [tail]; omega) he))

/-- The shorter detour's edge labels: i first, followed by the original labels starting at index
two.
-/
def detourLabel (i : I) (k : Fin (P.length - 1)) : I :=
  if k.val = 0 then i else P.label ⟨k.val + 1, by omega⟩

/-- The shorter path from an attached leaf at `v₂` to the original target. -/
def detour (h : 3 ≤ P.length) (i : I)
    (hi : i ≠ P.label ⟨2, by omega⟩) : CaterpillarPath I where
  length := P.length - 1
  label := P.detourLabel i
  reduced k hk := by
    by_cases hz : k.val = 0
    · simpa [detourLabel, hz] using hi
    · simpa [detourLabel, hz] using
        P.reduced ⟨k.val + 1, by omega⟩ (by dsimp; omega)

/-- The original leaf attached at the second internal spine vertex in direction i. -/
def detourInitialLeaf (h : 3 ≤ P.length) (i : I)
    (hl : i ≠ P.label ⟨1, by omega⟩) (hr : i ≠ P.label ⟨2, by omega⟩) : P.Leaf :=
  ⟨(⟨1, by omega⟩, i), hl, hr⟩

/-- Embed the shorter path starting at the selected attached leaf into the original caterpillar. -/
noncomputable def detourEmbedding (h : 3 ≤ P.length) (i : I)
    (hl : i ≠ P.label ⟨1, by omega⟩) (hr : i ≠ P.label ⟨2, by omega⟩) :
    (P.detour h i hr).Vertex → P.Vertex := by
  classical
  intro v
  cases v with
  | inl k =>
    exact if hk : k.val = 0 then P.leaf (P.detourInitialLeaf h i hl hr)
      else P.spine ⟨k.val + 1, by
        have hh : k.val < P.length - 1 + 1 := k.isLt
        omega⟩
  | inr q =>
    by_cases hp : q.val.1.val = 0
    · by_cases hq : q.val.2 = P.label ⟨1, by omega⟩
      · exact P.spine ⟨1, by omega⟩
      · exact P.leaf ⟨(⟨1, by omega⟩, q.val.2), hq, by
          have hh := q.property.2
          simpa [rightLabel, rightIndex, detour, detourLabel, hp] using hh⟩
    · exact P.leaf ⟨(⟨q.val.1.val + 1, by
          have hh : q.val.1.val < P.length - 1 - 1 := q.val.1.isLt
          omega⟩, q.val.2), by
        constructor
        · simpa [leftLabel, leftIndex, detour, detourLabel, hp] using q.property.1
        · simpa [rightLabel, rightIndex, detour, detourLabel] using q.property.2⟩

theorem detourEmbedding_source (h : 3 ≤ P.length) (i : I)
    (hl : i ≠ P.label ⟨1, by omega⟩) (hr : i ≠ P.label ⟨2, by omega⟩) :
    P.detourEmbedding h i hl hr (P.detour h i hr).source =
      P.leaf (P.detourInitialLeaf h i hl hr) := by
  classical
  simp [source, spine, detourEmbedding]

theorem detourEmbedding_target (h : 3 ≤ P.length) (i : I)
    (hl : i ≠ P.label ⟨1, by omega⟩) (hr : i ≠ P.label ⟨2, by omega⟩) :
    P.detourEmbedding h i hl hr (P.detour h i hr).target = P.target := by
  classical
  change (if hk : P.length - 1 = 0 then P.leaf (P.detourInitialLeaf h i hl hr)
    else P.spine ⟨P.length - 1 + 1, by omega⟩) = P.target
  rw [dite_eq_right (by omega)]
  apply congrArg Sum.inl
  apply Fin.ext
  dsimp
  omega

theorem detourEmbedding_path_forward (h : 3 ≤ P.length) (i : I)
    (hl : i ≠ P.label ⟨1, by omega⟩) (hr : i ≠ P.label ⟨2, by omega⟩)
    (k : Fin (P.detour h i hr).length) :
    P.Edge (P.detourEmbedding h i hl hr ((P.detour h i hr).spine ⟨k.val, by omega⟩))
      (P.detourEmbedding h i hl hr ((P.detour h i hr).spine ⟨k.val + 1, by omega⟩))
      ((P.detour h i hr).label k) := by
  classical
  by_cases hk : k.val = 0
  · simpa [detourEmbedding, spine, detour, detourLabel, hk, detourInitialLeaf, leaf,
      internalIndex] using (Edge.leaf_backward (P.detourInitialLeaf h i hl hr))
  · have hk' : k.val + 1 ≠ 0 := by omega
    simpa [detourEmbedding, spine, detour, detourLabel, hk, hk'] using
      (Edge.path_forward (P := P) ⟨k.val + 1, by
        have hh : k.val < P.length - 1 := k.isLt
        omega⟩)

theorem detourEmbedding_leaf_forward (h : 3 ≤ P.length) (i : I)
    (hl : i ≠ P.label ⟨1, by omega⟩) (hr : i ≠ P.label ⟨2, by omega⟩)
    (q : (P.detour h i hr).Leaf) :
    P.Edge
      (P.detourEmbedding h i hl hr ((P.detour h i hr).spine
        ((P.detour h i hr).internalIndex q.val.1)))
      (P.detourEmbedding h i hl hr ((P.detour h i hr).leaf q)) q.val.2 := by
  classical
  by_cases hp : q.val.1.val = 0
  · by_cases hq : q.val.2 = P.label ⟨1, by omega⟩
    · simpa [detourEmbedding, spine, leaf, internalIndex, hp, hq] using
        (Edge.path_backward (P := P) ⟨1, by omega⟩)
    · let q' : P.Leaf := ⟨(⟨1, by omega⟩, q.val.2), hq, by
        simpa [rightLabel, rightIndex, detour, detourLabel, hp] using q.property.2⟩
      simpa [detourEmbedding, spine, leaf, internalIndex, hp, hq, q'] using
        (Edge.leaf_forward q')
  · let q' : P.Leaf := ⟨(⟨q.val.1.val + 1, by
        have hh : q.val.1.val < P.length - 1 - 1 := q.val.1.isLt
        omega⟩, q.val.2), by
      constructor
      · simpa [leftLabel, leftIndex, detour, detourLabel, hp] using q.property.1
      · simpa [rightLabel, rightIndex, detour, detourLabel] using q.property.2⟩
    have hp' : q.val.1.val + 1 ≠ 0 := by omega
    simpa [detourEmbedding, spine, leaf, internalIndex, hp, hp', q'] using
      (Edge.leaf_forward q')

theorem detourEmbedding_edge (h : 3 ≤ P.length) (i : I)
    (hl : i ≠ P.label ⟨1, by omega⟩) (hr : i ≠ P.label ⟨2, by omega⟩)
    {a b : (P.detour h i hr).Vertex} {k : I} (he : (P.detour h i hr).Edge a b k) :
    P.Edge (P.detourEmbedding h i hl hr a) (P.detourEmbedding h i hl hr b) k := by
  cases he with
  | path_forward k => exact P.detourEmbedding_path_forward h i hl hr k
  | path_backward k => exact (P.detourEmbedding_path_forward h i hl hr k).symm
  | leaf_forward q => exact P.detourEmbedding_leaf_forward h i hl hr q
  | leaf_backward q => exact (P.detourEmbedding_leaf_forward h i hl hr q).symm

/-- Encode a spine vertex by its natural index and a leaf by its attachment index and label. -/
def vertexCode : P.Vertex → ℕ ⊕ (ℕ × I)
  | Sum.inl k => Sum.inl k.val
  | Sum.inr q => Sum.inr (q.val.1.val, q.val.2)

theorem vertexCode_injective : Function.Injective P.vertexCode := by
  intro a b hab
  cases a with
  | inl a =>
    cases b with
    | inl b => exact congrArg Sum.inl (Fin.ext (Sum.inl.inj hab))
    | inr b => simp [vertexCode] at hab
  | inr a =>
    cases b with
    | inl b => simp [vertexCode] at hab
    | inr b =>
      have hc : (a.val.1.val, a.val.2) = (b.val.1.val, b.val.2) := Sum.inr.inj hab
      apply congrArg Sum.inr
      apply Subtype.ext
      exact Prod.ext (Fin.ext (congrArg (fun q : ℕ × I => q.1) hc))
        (congrArg (fun q : ℕ × I => q.2) hc)

/-- Assign original vertices their candidate numeric vertex codes in the shorter detour. -/
noncomputable def detourDecode (h : 3 ≤ P.length) (i : I) : P.Vertex → ℕ ⊕ (ℕ × I) := by
  classical
  intro v
  exact match v with
    | Sum.inl k => if k.val = 1 then Sum.inr (0, P.label ⟨1, by omega⟩)
      else Sum.inl (k.val - 1)
    | Sum.inr q => if q.val.1.val = 1 ∧ q.val.2 = i then Sum.inl 0
      else Sum.inr (q.val.1.val - 1, q.val.2)

theorem detourDecode_embedding (h : 3 ≤ P.length) (i : I)
    (hl : i ≠ P.label ⟨1, by omega⟩) (hr : i ≠ P.label ⟨2, by omega⟩)
    (v : (P.detour h i hr).Vertex) :
    P.detourDecode h i (P.detourEmbedding h i hl hr v) =
      (P.detour h i hr).vertexCode v := by
  classical
  cases v with
  | inl k =>
    by_cases hk : k.val = 0
    · simp [detourEmbedding, detourDecode, vertexCode, leaf, detourInitialLeaf, hk]
    · simp [detourEmbedding, detourDecode, vertexCode, spine, hk]
  | inr q =>
    by_cases hp : q.val.1.val = 0
    · by_cases hq : q.val.2 = P.label ⟨1, by omega⟩
      · simp [detourEmbedding, detourDecode, vertexCode, spine, hp, hq]
      · have hqi : q.val.2 ≠ i := by
          simpa [leftLabel, leftIndex, detour, detourLabel, hp] using q.property.1
        simp [detourEmbedding, detourDecode, vertexCode, leaf, hp, hq, hqi]
    · simp [detourEmbedding, detourDecode, vertexCode, leaf, hp]

theorem detourEmbedding_injective (h : 3 ≤ P.length) (i : I)
    (hl : i ≠ P.label ⟨1, by omega⟩) (hr : i ≠ P.label ⟨2, by omega⟩) :
    Function.Injective (P.detourEmbedding h i hl hr) := by
  intro a b hab
  apply (P.detour h i hr).vertexCode_injective
  rw [← P.detourDecode_embedding h i hl hr a, ← P.detourDecode_embedding h i hl hr b, hab]

/-- The undirected simple graph obtained by forgetting the labels on caterpillar edges. -/
def graph : SimpleGraph P.Vertex where
  Adj a b := ∃ i, P.Edge a b i
  symm := ⟨by rintro a b ⟨i, hi⟩; exact ⟨i, hi.symm⟩⟩
  loopless := ⟨by intro a ⟨i, hi⟩; exact Edge.ne P hi rfl⟩

theorem spine_reachable (k : Fin (P.length + 1)) :
    P.graph.Reachable P.source (P.spine k) := by
  obtain ⟨k, hk⟩ := k
  induction k with
  | zero => exact SimpleGraph.Reachable.refl _
  | succ k ih =>
    exact (ih (by omega)).trans
      (SimpleGraph.Adj.reachable (show P.graph.Adj (P.spine ⟨k, by omega⟩)
        (P.spine ⟨k + 1, hk⟩) from
          ⟨P.label ⟨k, by omega⟩, Edge.path_forward (P := P) ⟨k, by omega⟩⟩))

theorem graph_connected : P.graph.Connected := by
  apply P.graph.connected_iff_exists_forall_reachable.mpr
  refine ⟨P.source, ?_⟩
  intro v
  cases v with
  | inl k => exact P.spine_reachable k
  | inr q =>
    exact (P.spine_reachable (P.internalIndex q.val.1)).trans
      (SimpleGraph.Adj.reachable (show P.graph.Adj _ _ from ⟨q.val.2, Edge.leaf_forward q⟩))

/-- A cut crossed by only one edge proves that edge is a bridge. -/
theorem bridge_of_cut {W : Type*} (G : SimpleGraph W) (a b : W) (χ : W → Bool)
    (hab : χ a ≠ χ b)
    (hcut : ∀ u v, G.Adj u v → χ u ≠ χ v → s(u, v) = s(a, b)) :
    G.IsBridge s(a, b) := by
  rw [SimpleGraph.isBridge_iff]
  rintro ⟨w⟩
  apply hab
  have hinv : ∀ {u v}, (G.deleteEdges {s(a, b)}).Walk u v → χ u = χ v := by
    intro u v walk
    induction walk with
    | nil => rfl
    | @cons u v w hadj tail ih =>
      have he := SimpleGraph.deleteEdges_adj.mp hadj
      have huv : χ u = χ v := by
        by_contra hne
        exact he.2 (Set.mem_singleton_iff.mpr (hcut u v he.1 hne))
      exact huv.trans ih
  exact hinv w

/-- The natural index of a spine vertex or of the spine vertex carrying an attached leaf. -/
def owner : P.Vertex → ℕ
  | Sum.inl k => k.val
  | Sum.inr q => q.val.1.val + 1

/-- The Boolean cut consisting of vertices whose owning spine index is at most k. -/
def pathCut (k : Fin P.length) (v : P.Vertex) : Bool := decide (P.owner v ≤ k.val)
theorem pathEdge_bridge (k : Fin P.length) :
    P.graph.IsBridge s(P.spine ⟨k.val, by omega⟩, P.spine ⟨k.val + 1, by omega⟩) := by
  apply bridge_of_cut P.graph _ _ (P.pathCut k)
  · simp [pathCut, owner, spine]
  · intro a b ⟨i, he⟩ hχ
    cases he with
    | path_forward r =>
      have hr : r = k := by
        apply Fin.ext
        dsimp [pathCut, owner, spine] at hχ
        by_cases hrk : r.val ≤ k.val <;> by_cases hrk' : r.val + 1 ≤ k.val <;>
          simp_all <;> omega
      subst r
      rfl
    | path_backward r =>
      have hr : r = k := by
        apply Fin.ext
        dsimp [pathCut, owner, spine] at hχ
        by_cases hrk : r.val ≤ k.val <;> by_cases hrk' : r.val + 1 ≤ k.val <;>
          simp_all <;> omega
      subst r
      exact Sym2.eq_swap
    | leaf_forward q => simp [pathCut, owner, spine, leaf, internalIndex] at hχ
    | leaf_backward q => simp [pathCut, owner, spine, leaf, internalIndex] at hχ

theorem leafEdge_bridge (q : P.Leaf) :
    P.graph.IsBridge s(P.spine (P.internalIndex q.val.1), P.leaf q) := by
  classical
  apply bridge_of_cut P.graph _ _ (fun v => decide (v = P.leaf q))
  · simp only [spine, ne_eq, leaf, reduceCtorEq, decide_false, Bool.false_eq, Bool.not_eq_false]
    exact decide_eq_true_eq.mpr rfl
  · intro a b ⟨i, he⟩ hχ
    cases he with
    | path_forward k => simp [spine, leaf] at hχ
    | path_backward k => simp [spine, leaf] at hχ
    | leaf_forward r =>
      have hr : r = q := by
        by_contra hne
        have h₁ : decide (P.spine (P.internalIndex r.val.1) = P.leaf q) = false :=
          decide_eq_false_iff_not.mpr (by simp [spine, leaf])
        have h₂ : decide (P.leaf r = P.leaf q) = false :=
          decide_eq_false_iff_not.mpr (fun hh => hne (Sum.inr.inj hh))
        exact hχ (h₁.trans h₂.symm)
      subst r
      rfl
    | leaf_backward r =>
      have hr : r = q := by
        by_contra hne
        have h₁ : decide (P.spine (P.internalIndex r.val.1) = P.leaf q) = false :=
          decide_eq_false_iff_not.mpr (by simp [spine, leaf])
        have h₂ : decide (P.leaf r = P.leaf q) = false :=
          decide_eq_false_iff_not.mpr (fun hh => hne (Sum.inr.inj hh))
        exact hχ (h₂.trans h₁.symm)
      subst r
      exact Sym2.eq_swap

theorem graph_isTree : P.graph.IsTree := by
  refine ⟨P.graph_connected, SimpleGraph.isAcyclic_iff_forall_adj_isBridge.mpr ?_⟩
  intro a b ⟨i, he⟩
  cases he with
  | path_forward k => exact P.pathEdge_bridge k
  | path_backward k =>
    rw [Sym2.eq_swap]
    exact P.pathEdge_bridge k
  | leaf_forward q => exact P.leafEdge_bridge q
  | leaf_backward q =>
    rw [Sym2.eq_swap]
    exact P.leafEdge_bridge q

/-- The label of the first spine edge in the three-edge local configuration. -/
def firstLabel (h : 3 ≤ P.length) : I := P.label ⟨0, by omega⟩
/-- The label of the second spine edge in the three-edge local configuration. -/
def secondLabel (h : 3 ≤ P.length) : I := P.label ⟨1, by omega⟩
/-- The label of the third spine edge in the three-edge local configuration. -/
def thirdLabel (h : 3 ≤ P.length) : I := P.label ⟨2, by omega⟩
theorem firstLabel_ne_secondLabel (h : 3 ≤ P.length) :
    P.firstLabel h ≠ P.secondLabel h := P.reduced ⟨0, by omega⟩ (by dsimp; omega)

/-- The `i`-neighbor of `v₂`, used as the second induction source. -/
noncomputable def thirdVertex (h : 3 ≤ P.length) : P.Vertex :=
  P.starNeighbor ⟨1, by omega⟩ (P.firstLabel h)

theorem thirdVertex_edge (h : 3 ≤ P.length) :
    P.Edge (P.spine ⟨2, by omega⟩) (P.thirdVertex h) (P.firstLabel h) :=
  P.starNeighbor_edge ⟨1, by omega⟩ (P.firstLabel h)

theorem thirdVertex_eq_spine (h : 3 ≤ P.length)
    (hi : P.firstLabel h = P.thirdLabel h) :
    P.thirdVertex h = P.spine ⟨3, by omega⟩ := by
  unfold thirdVertex
  rw [hi]
  exact P.starNeighbor_right ⟨1, by omega⟩

theorem thirdVertex_eq_leaf (h : 3 ≤ P.length)
    (hi : P.firstLabel h ≠ P.thirdLabel h) :
    P.thirdVertex h = P.leaf (P.detourInitialLeaf h (P.firstLabel h)
      (P.firstLabel_ne_secondLabel h) hi) := by
  classical
  have hl' : P.label ⟨0, by omega⟩ ≠ P.label ⟨1, by omega⟩ :=
    P.firstLabel_ne_secondLabel h
  have hr' : P.label ⟨0, by omega⟩ ≠ P.label ⟨2, by omega⟩ := hi
  simp [thirdVertex, starNeighbor, leftLabel, rightLabel, leftIndex, rightIndex,
    firstLabel, hl', hr', detourInitialLeaf]

theorem dropThreeEmbedding_source_thirdVertex (h : 3 ≤ P.length)
    (hi : P.firstLabel h = P.thirdLabel h) :
    P.dropThreeEmbedding h P.dropThree.source = P.thirdVertex h := by
  rw [P.dropThreeEmbedding_source, P.thirdVertex_eq_spine h hi]

theorem detourEmbedding_source_thirdVertex (h : 3 ≤ P.length)
    (hi : P.firstLabel h ≠ P.thirdLabel h) :
    P.detourEmbedding h (P.firstLabel h) (P.firstLabel_ne_secondLabel h) hi
      (P.detour h (P.firstLabel h) hi).source = P.thirdVertex h := by
  exact (P.detourEmbedding_source h (P.firstLabel h)
    (P.firstLabel_ne_secondLabel h) hi).trans (P.thirdVertex_eq_leaf h hi).symm

end CaterpillarPath

end TauCeti.Laurent

namespace TauCeti.Laurent
namespace CaterpillarPath

variable {I : Type*} (P : CaterpillarPath I)

/-- The internal star at spine vertex p+1. -/
def leftStar (p : Fin (P.length - 2)) : P.Vertex :=
  P.spine (P.internalIndex (P.interiorLeft p))
/-- The next internal star, at spine vertex p+2. -/
def rightStar (p : Fin (P.length - 2)) : P.Vertex :=
  P.spine (P.internalIndex (P.interiorRight p))
/-- The edge label joining the two consecutive internal stars. -/
def middleLabel (p : Fin (P.length - 2)) : I := P.rightLabel (P.interiorLeft p)
end CaterpillarPath
namespace CaterpillarPath

theorem middle_edge {I : Type*} (P : CaterpillarPath I) (p : Fin (P.length - 2)) :
    P.Edge (P.leftStar p) (P.rightStar p) (P.middleLabel p) :=
  Edge.path_forward ⟨p.val + 1, by have := p.isLt; omega⟩

end CaterpillarPath
end TauCeti.Laurent
