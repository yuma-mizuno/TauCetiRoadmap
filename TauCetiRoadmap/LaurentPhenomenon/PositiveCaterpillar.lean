/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.PositiveSubstitution
public import TauCetiRoadmap.LaurentPhenomenon.FiniteCaterpillar
public import TauCetiRoadmap.LaurentPhenomenon.UniversalDeformation

/-! # Positive Caterpillar -/

@[expose] public section

namespace TauCeti.Laurent

noncomputable section


variable {G I : Type*} [AddCommGroup G] [DecidableEq I]

/-- Positive polynomial exchange data on a concrete finite caterpillar.
No coprimality or Laurentness is part of this structure. -/
structure PositiveCaterpillar (G : Type*) [AddCommGroup G] (P : CaterpillarPath I) where
  /-- The positive Laurent exchange polynomial at each vertex and direction. -/
  exchange : P.Vertex → I → PositiveLaurent G I
  exchange_ne_zero : ∀ s i, exchange s i ≠ 0
  exchange_polynomial : ∀ s i, PositivePolynomialSupport (exchange s i)
  exchange_independent : ∀ s i, PositiveIndependent (exchange s i) i
  exchange_no_factor : ∀ s i, PositiveNoVariableFactor (exchange s i)
  exchange_undirected : ∀ {a b i}, P.Edge a b i → exchange a i = exchange b i
  /-- The positive correction polynomials for propagation between adjacent internal stars. -/
  correction : Fin (P.length - 2) → I → PositiveLaurent G I
  correction_ne_zero : ∀ p i, i ≠ P.middleLabel p → correction p i ≠ 0
  correction_independent : ∀ p i, i ≠ P.middleLabel p → PositiveIndependent (correction p i) i
  correction_nonnegative : ∀ p i, i ≠ P.middleLabel p →
    PositiveNonnegativeAt (correction p i) (P.middleLabel p)
  compatibility : ∀ p i, i ≠ P.middleLabel p →
    exchange (P.rightStar p) i = positivePropagate (correction p i)
      (exchange (P.leftStar p) i)
      (positiveSetZero (exchange (P.leftStar p) (P.middleLabel p)) i) (P.middleLabel p)

namespace PositiveCaterpillar

variable {P : CaterpillarPath I} (T : PositiveCaterpillar G P)

/-- Pull exchange data and propagation corrections back along a map preserving labelled edges and
internal stars.
-/
def restrict {Q : CaterpillarPath I} (f : Q.Vertex → P.Vertex)
    (hf : ∀ {a b i}, Q.Edge a b i → P.Edge (f a) (f b) i)
    (shift : Fin (Q.length - 2) → Fin (P.length - 2))
    (hleft : ∀ p, f (Q.leftStar p) = P.leftStar (shift p))
    (hright : ∀ p, f (Q.rightStar p) = P.rightStar (shift p))
    (hlabel : ∀ p, Q.middleLabel p = P.middleLabel (shift p)) : PositiveCaterpillar G Q where
  exchange s := T.exchange (f s)
  exchange_ne_zero s := T.exchange_ne_zero (f s)
  exchange_polynomial s := T.exchange_polynomial (f s)
  exchange_independent s := T.exchange_independent (f s)
  exchange_no_factor s := T.exchange_no_factor (f s)
  exchange_undirected he := T.exchange_undirected (hf he)
  correction p := T.correction (shift p)
  correction_ne_zero p i hi := T.correction_ne_zero (shift p) i (by rwa [← hlabel p])
  correction_independent p i hi := T.correction_independent (shift p) i (by rwa [← hlabel p])
  correction_nonnegative p i hi := by
    rw [hlabel p]
    exact T.correction_nonnegative (shift p) i (by rwa [← hlabel p])
  compatibility p i hi := by
    rw [hleft p, hright p, hlabel p]
    exact T.compatibility (shift p) i (by rwa [← hlabel p])

/-- Restrict the positive caterpillar to the tail beginning at the next spine vertex. -/
def tail (h : 0 < P.length) : PositiveCaterpillar G P.tail :=
  T.restrict (P.tailEmbedding h) (P.tailEmbedding_edge h)
    (fun p => ⟨p.val + 1, by have hh : p.val < P.length - 1 - 2 := p.isLt; omega⟩)
    (fun _ => rfl) (fun _ => rfl) (fun _ => rfl)

/-- Restrict the positive caterpillar after the first three spine edges are removed. -/
def dropThree (h : 3 ≤ P.length) : PositiveCaterpillar G P.dropThree :=
  T.restrict (P.dropThreeEmbedding h) (P.dropThreeEmbedding_edge h)
    (fun p => ⟨p.val + 3, by have hh : p.val < P.length - 1 - 1 - 1 - 2 := p.isLt; omega⟩)
    (fun _ => rfl) (fun _ => rfl) (fun _ => rfl)

/-- Restrict the positive caterpillar to the shorter path starting at the chosen attached leaf. -/
def detour (h : 3 ≤ P.length) (i : I)
    (hl : i ≠ P.label ⟨1, by omega⟩) (hr : i ≠ P.label ⟨2, by omega⟩) :
    PositiveCaterpillar G (P.detour h i hr) := by
  apply T.restrict (P.detourEmbedding h i hl hr) (P.detourEmbedding_edge h i hl hr)
    (fun p => ⟨p.val + 1, by have hh : p.val < P.length - 1 - 2 := p.isLt; omega⟩)
  · intro p
    simp [CaterpillarPath.leftStar, CaterpillarPath.detourEmbedding, CaterpillarPath.spine,
      CaterpillarPath.internalIndex, CaterpillarPath.interiorLeft]
    rfl
  · intro p
    simp [CaterpillarPath.rightStar, CaterpillarPath.detourEmbedding, CaterpillarPath.spine,
      CaterpillarPath.internalIndex, CaterpillarPath.interiorRight]
    rfl
  · intro p
    simp [CaterpillarPath.middleLabel, CaterpillarPath.rightLabel, CaterpillarPath.rightIndex,
      CaterpillarPath.interiorLeft, CaterpillarPath.detour, CaterpillarPath.detourLabel]

/-- The exchange tuple at the first internal spine vertex. -/
def initialStar (h : 3 ≤ P.length) : I → PositiveLaurent G I :=
  T.exchange (P.spine ⟨1, by omega⟩)

/-- The next internal propagation label, with the first edge label used beyond the finite
propagation range.
-/
def propagationLabel (_T : PositiveCaterpillar G P) (h : 3 ≤ P.length) (n : ℕ) : I :=
  if hn : n < P.length - 2 then P.middleLabel ⟨n, hn⟩ else P.firstLabel h

/-- The original stars are recovered by the finite forward recursion. -/
theorem originalStar_recursion (h : 3 ≤ P.length) (n : ℕ) (hn : n ≤ P.length - 2) (i : I) :
    positiveStarIterate (T.initialStar h) (finiteCorrections T.correction)
      (T.propagationLabel h) n i = T.exchange (P.spine ⟨n + 1, by omega⟩) i := by
  induction n generalizing i with
  | zero => rfl
  | succ n ih =>
    have hn' : n < P.length - 2 := by omega
    have heq : positiveStarIterate (T.initialStar h) (finiteCorrections T.correction)
        (T.propagationLabel h) n = T.exchange (P.spine ⟨n + 1, by omega⟩) :=
      funext (fun k => ih (by omega) k)
    rw [positiveStarIterate, heq]
    simp only [propagationLabel, dite_eq_left hn']
    unfold positiveStarStep
    split_ifs with hi
    · subst i
      exact T.exchange_undirected
        (CaterpillarPath.Edge.path_forward (P := P) ⟨n + 1, by omega⟩)
    · simp only [finiteCorrections, dite_eq_left hn']
      exact (T.compatibility ⟨n, hn'⟩ i hi).symm

/-- The free abelian coefficient-occurrence group for the initial star and all local corrections. -/
abbrev LiftGroup (h : 3 ≤ P.length) := DeformationGroup (T.initialStar h) T.correction

/-- Specialize the free coefficient-occurrence group back to the original coefficient group. -/
def liftMap (h : 3 ≤ P.length) : T.LiftGroup h →+ G :=
  deformationMap (T.initialStar h) T.correction

/-- Iterate propagation from the freely lifted initial star and correction polynomials. -/
def liftedStar (h : 3 ≤ P.length) : ℕ → I → PositiveLaurent (T.LiftGroup h) I :=
  deformedStar (T.initialStar h) T.correction (T.propagationLabel h)

theorem liftedStar_specializes (h : 3 ≤ P.length) (n : ℕ)
    (hn : n ≤ P.length - 2) (i : I) :
    coefficientMap (T.liftMap h) (T.liftedStar h n i) =
      T.exchange (P.spine ⟨n + 1, by omega⟩) i := by
  rw [liftedStar, liftMap, deformedStar_specializes, T.originalStar_recursion h n hn i]

theorem liftedStar_properties (h : 3 ≤ P.length) (n : ℕ)
    (hn : n ≤ P.length - 2) (i : I) :
    T.liftedStar h n i ≠ 0 ∧ PositivePolynomialSupport (T.liftedStar h n i) ∧
      PositiveIndependent (T.liftedStar h n i) i ∧
        PositiveNoVariableFactor (T.liftedStar h n i) := by
  have heq := T.originalStar_recursion h n hn i
  have h₀ := deformedStar_ne_zero (T.initialStar h) T.correction (T.propagationLabel h)
    n i (by rw [heq]; exact T.exchange_ne_zero _ i)
  have h₁ := deformedStar_properties (T.initialStar h) T.correction (T.propagationLabel h)
    n i (by rw [heq]; exact T.exchange_polynomial _ i)
      (by rw [heq]; exact T.exchange_independent _ i)
      (by rw [heq]; exact T.exchange_no_factor _ i)
  exact ⟨h₀, h₁⟩

/-- Endpoints use the adjacent internal star; every leg uses its parent star. -/
def starIndex (_T : PositiveCaterpillar G P) : P.Vertex → ℕ
  | Sum.inl k => min (k.val - 1) (P.length - 2)
  | Sum.inr q => q.val.1.val

omit [DecidableEq I] in
theorem starIndex_le (s : P.Vertex) : T.starIndex s ≤ P.length - 2 := by
  cases s with
  | inl k => exact min_le_right _ _
  | inr q =>
    change q.val.1.val ≤ P.length - 2
    have := q.val.1.isLt
    omega

/-- The deformed exchange tuple at a vertex, selected by its internal star index. -/
def liftedExchange (h : 3 ≤ P.length) (s : P.Vertex) (i : I) :
    PositiveLaurent (T.LiftGroup h) I := T.liftedStar h (T.starIndex s) i

/-- The freely lifted correction polynomial for the selected internal edge and direction. -/
def liftedCorrection (h : 3 ≤ P.length) (p : Fin (P.length - 2)) (i : I) :
    PositiveLaurent (T.LiftGroup h) I :=
  deformedCorrections (T.initialStar h) T.correction p.val i

omit [DecidableEq I] in
theorem liftedCorrection_specializes (h : 3 ≤ P.length)
    (p : Fin (P.length - 2)) (i : I) :
    coefficientMap (T.liftMap h) (T.liftedCorrection h p i) = T.correction p i := by
  simp [liftedCorrection, liftMap, deformedCorrections_specializes, finiteCorrections, p.isLt]

omit [DecidableEq I] in
theorem liftedCorrection_properties (h : 3 ≤ P.length)
    (p : Fin (P.length - 2)) (i : I) (hi : i ≠ P.middleLabel p) :
    T.liftedCorrection h p i ≠ 0 ∧ PositiveIndependent (T.liftedCorrection h p i) i ∧
      PositiveNonnegativeAt (T.liftedCorrection h p i) (P.middleLabel p) := by
  classical
  have hspec := T.liftedCorrection_specializes h p i
  have hsupp : mutableSupport (T.liftedCorrection h p i) = mutableSupport (T.correction p i) := by
    rw [← hspec]
    exact (mutableSupport_coefficient_map (T.liftMap h) _).symm
  refine ⟨?_, ?_, ?_⟩
  · intro hz
    apply T.correction_ne_zero p i hi
    rw [← hspec, hz, map_zero]
  · unfold PositiveIndependent
    rw [hsupp]
    exact T.correction_independent p i hi
  · unfold PositiveNonnegativeAt
    rw [hsupp]
    exact T.correction_nonnegative p i hi

theorem liftedStar_retains_label (h : 3 ≤ P.length) (n : ℕ) :
    T.liftedStar h (n + 1) (T.propagationLabel h n) =
      T.liftedStar h n (T.propagationLabel h n) := by
  simp [liftedStar, deformedStar, positiveStarIterate, positiveStarStep]

theorem liftedExchange_path (h : 3 ≤ P.length) (k : Fin P.length) :
    T.liftedExchange h (P.spine ⟨k.val, by omega⟩) (P.label k) =
      T.liftedExchange h (P.spine ⟨k.val + 1, by omega⟩) (P.label k) := by
  by_cases hk0 : k.val = 0
  · simp [liftedExchange, starIndex, CaterpillarPath.spine, hk0]
  · by_cases hkLast : k.val + 1 = P.length
    · have hs : T.starIndex (P.spine ⟨k.val, by omega⟩) = P.length - 2 := by
        dsimp [starIndex, CaterpillarPath.spine]
        omega
      have ht : T.starIndex (P.spine ⟨k.val + 1, by omega⟩) = P.length - 2 := by
        dsimp [starIndex, CaterpillarPath.spine]
        omega
      simp only [liftedExchange, hs, ht]
    · have hn : k.val - 1 < P.length - 2 := by omega
      have hs : T.starIndex (P.spine ⟨k.val, by omega⟩) = k.val - 1 := by
        dsimp [starIndex, CaterpillarPath.spine]; omega
      have ht : T.starIndex (P.spine ⟨k.val + 1, by omega⟩) = k.val := by
        dsimp [starIndex, CaterpillarPath.spine]; omega
      have hj : T.propagationLabel h (k.val - 1) = P.label k := by
        rw [propagationLabel, dite_eq_left hn]
        apply congrArg P.label
        apply Fin.ext
        dsimp [CaterpillarPath.middleLabel, CaterpillarPath.rightLabel,
          CaterpillarPath.rightIndex, CaterpillarPath.interiorLeft]
        omega
      have hnext : k.val - 1 + 1 = k.val := by omega
      have heq := T.liftedStar_retains_label h (k.val - 1)
      rw [hj, hnext] at heq
      exact (show T.liftedStar h (T.starIndex (P.spine ⟨k.val, by omega⟩)) (P.label k) =
        T.liftedStar h (T.starIndex (P.spine ⟨k.val + 1, by omega⟩)) (P.label k) by
          rw [hs, ht]; exact heq.symm)

theorem liftedExchange_undirected (h : 3 ≤ P.length) {a b : P.Vertex} {i : I}
    (he : P.Edge a b i) : T.liftedExchange h a i = T.liftedExchange h b i := by
  cases he with
  | path_forward k => exact T.liftedExchange_path h k
  | path_backward k => exact (T.liftedExchange_path h k).symm
  | leaf_forward q =>
    unfold liftedExchange
    congr 1
    dsimp [starIndex, CaterpillarPath.spine, CaterpillarPath.leaf, CaterpillarPath.internalIndex]
    have := q.val.1.isLt
    omega
  | leaf_backward q =>
    unfold liftedExchange
    congr 1
    dsimp [starIndex, CaterpillarPath.spine, CaterpillarPath.leaf, CaterpillarPath.internalIndex]
    have := q.val.1.isLt
    omega

theorem liftedExchange_compatibility (h : 3 ≤ P.length) (p : Fin (P.length - 2))
    (i : I) (hi : i ≠ P.middleLabel p) :
    T.liftedExchange h (P.rightStar p) i = positivePropagate (T.liftedCorrection h p i)
      (T.liftedExchange h (P.leftStar p) i)
      (positiveSetZero (T.liftedExchange h (P.leftStar p) (P.middleLabel p)) i)
      (P.middleLabel p) := by
  have hs : T.starIndex (P.leftStar p) = p.val := by
    dsimp [starIndex, CaterpillarPath.leftStar, CaterpillarPath.internalIndex,
      CaterpillarPath.interiorLeft, CaterpillarPath.spine]
    have := p.isLt
    omega
  have ht : T.starIndex (P.rightStar p) = p.val + 1 := by
    dsimp [starIndex, CaterpillarPath.rightStar, CaterpillarPath.internalIndex,
      CaterpillarPath.interiorRight, CaterpillarPath.spine]
    have := p.isLt
    omega
  simp only [liftedExchange, hs, ht]
  have hj : T.propagationLabel h p.val = P.middleLabel p := by
    simp [propagationLabel, p.isLt]
  unfold liftedStar deformedStar
  rw [positiveStarIterate, hj]
  simp only [positiveStarStep, ite_eq_right hi]
  rfl

/-- The universal deformation is an actual positive caterpillar on the same tree. -/
def deform (h : 3 ≤ P.length) : PositiveCaterpillar (T.LiftGroup h) P where
  exchange := T.liftedExchange h
  exchange_ne_zero s i := (T.liftedStar_properties h _ (T.starIndex_le s) i).1
  exchange_polynomial s i := (T.liftedStar_properties h _ (T.starIndex_le s) i).2.1
  exchange_independent s i := (T.liftedStar_properties h _ (T.starIndex_le s) i).2.2.1
  exchange_no_factor s i := (T.liftedStar_properties h _ (T.starIndex_le s) i).2.2.2
  exchange_undirected := T.liftedExchange_undirected h
  correction := T.liftedCorrection h
  correction_ne_zero p i hi := (T.liftedCorrection_properties h p i hi).1
  correction_independent p i hi := (T.liftedCorrection_properties h p i hi).2.1
  correction_nonnegative p i hi := (T.liftedCorrection_properties h p i hi).2.2
  compatibility := T.liftedExchange_compatibility h

theorem deform_firstStar (h : 3 ≤ P.length) (i : I) :
    (T.deform h).exchange (P.spine ⟨1, by omega⟩) i =
      familyAtomLift (deformationInputs (T.initialStar h) T.correction) (.inl i) := by
  simp [deform, liftedExchange, starIndex, CaterpillarPath.spine, liftedStar, deformedStar,
    positiveStarIterate, deformedInitial]

theorem deform_correction (h : 3 ≤ P.length) (p : Fin (P.length - 2)) (i : I) :
    (T.deform h).correction p i =
      familyAtomLift (deformationInputs (T.initialStar h) T.correction) (.inr (p, i)) := by
  simp [deform, liftedCorrection, deformedCorrections, p.isLt]

omit [DecidableEq I] in
theorem originalStar_incident (h : 3 ≤ P.length) {a b : P.Vertex} {i : I}
    (he : P.Edge a b i) :
    T.exchange (P.spine ⟨T.starIndex a + 1, by have := T.starIndex_le a; omega⟩) i =
      T.exchange a i := by
  cases he with
  | path_forward k =>
    by_cases hk : k.val = 0
    · have hv : P.spine ⟨T.starIndex (P.spine ⟨k.val, by omega⟩) + 1, by
          have := T.starIndex_le (P.spine ⟨k.val, by omega⟩); omega⟩ =
          P.spine ⟨k.val + 1, by omega⟩ := by
        apply congrArg Sum.inl
        apply Fin.ext
        simp [starIndex, CaterpillarPath.spine, hk]
      rw [hv]
      exact (T.exchange_undirected (CaterpillarPath.Edge.path_forward k)).symm
    · have hv : P.spine ⟨T.starIndex (P.spine ⟨k.val, by omega⟩) + 1, by
          have := T.starIndex_le (P.spine ⟨k.val, by omega⟩); omega⟩ =
          P.spine ⟨k.val, by omega⟩ := by
        apply congrArg Sum.inl
        apply Fin.ext
        dsimp [starIndex, CaterpillarPath.spine]
        have := k.isLt
        omega
      rw [hv]
  | path_backward k =>
    by_cases hk : k.val + 1 = P.length
    · have hv : P.spine ⟨T.starIndex (P.spine ⟨k.val + 1, by omega⟩) + 1, by
          have := T.starIndex_le (P.spine ⟨k.val + 1, by omega⟩); omega⟩ =
          P.spine ⟨k.val, by omega⟩ := by
        apply congrArg Sum.inl
        apply Fin.ext
        dsimp [starIndex, CaterpillarPath.spine]
        omega
      rw [hv]
      exact T.exchange_undirected (CaterpillarPath.Edge.path_forward k)
    · have hv : P.spine ⟨T.starIndex (P.spine ⟨k.val + 1, by omega⟩) + 1, by
          have := T.starIndex_le (P.spine ⟨k.val + 1, by omega⟩); omega⟩ =
          P.spine ⟨k.val + 1, by omega⟩ := by
        apply congrArg Sum.inl
        apply Fin.ext
        dsimp [starIndex, CaterpillarPath.spine]
        have := k.isLt
        omega
      rw [hv]
  | leaf_forward q =>
    have hv : P.spine ⟨T.starIndex (P.spine (P.internalIndex q.val.1)) + 1, by
        have := T.starIndex_le (P.spine (P.internalIndex q.val.1)); omega⟩ =
        P.spine (P.internalIndex q.val.1) := by
      apply congrArg Sum.inl
      apply Fin.ext
      dsimp [starIndex, CaterpillarPath.spine, CaterpillarPath.internalIndex]
      have := q.val.1.isLt
      omega
    rw [hv]
  | leaf_backward q => exact T.exchange_undirected (CaterpillarPath.Edge.leaf_forward q)

/-- Specialization is asserted on every actual edge, including endpoint and leg edges. -/
theorem deform_specializes_edge (h : 3 ≤ P.length) {a b : P.Vertex} {i : I}
    (he : P.Edge a b i) :
    coefficientMap (T.liftMap h) ((T.deform h).exchange a i) = T.exchange a i := by
  change coefficientMap (T.liftMap h) (T.liftedStar h (T.starIndex a) i) = _
  rw [T.liftedStar_specializes h _ (T.starIndex_le a) i]
  exact T.originalStar_incident h he
end PositiveCaterpillar

end

end TauCeti.Laurent
