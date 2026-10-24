/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.FiniteCaterpillar
public import TauCetiRoadmap.LaurentPhenomenon.Chart
public import Mathlib.Algebra.MvPolynomial.Eval

/-! # Finite Theorem -/

@[expose] public section

namespace TauCeti.Laurent

namespace CaterpillarPath

variable {I : Type*}

/-- Strong induction with both actual shortening constructions. The predicate may
quantify over all coefficient groups, fields and realizations, as required for a
universal deformation at the induction step. -/
theorem strong_induction (M : CaterpillarPath I → Prop)
    (hbase : ∀ P, P.length ≤ 2 → M P)
    (hstep : ∀ (P : CaterpillarPath I) (h : 3 ≤ P.length), M P.tail →
      (P.firstLabel h = P.thirdLabel h → M P.dropThree) →
      (∀ hi : P.firstLabel h ≠ P.thirdLabel h, M (P.detour h (P.firstLabel h) hi)) → M P)
    (P : CaterpillarPath I) : M P := by
  induction hn : P.length using Nat.strong_induction_on generalizing P with
  | h n ih =>
    by_cases hsmall : P.length ≤ 2
    · exact hbase P hsmall
    · have h : 3 ≤ P.length := by omega
      apply hstep P h
      · exact ih P.tail.length (by rw [tail_length]; omega) P.tail rfl
      · intro _
        exact ih P.dropThree.length (by rw [dropThree_length]; omega) P.dropThree rfl
      · intro hi
        exact ih (P.detour h (P.firstLabel h) hi).length
          (by change P.length - 1 < n; omega) (P.detour h (P.firstLabel h) hi) rfl

end CaterpillarPath

variable {F I : Type*} [Field F]

/-- A realization on the actual finite caterpillar. All exchange assumptions are
polynomial identities on edges; no Laurent conclusions are fields of the data. -/
structure RealizedCaterpillar (C : Subring F) (P : CaterpillarPath I) where
  /-- The actual coordinate tuple at each spine vertex or attached leaf. -/
  coord : P.Vertex → I → F
  coord_ne_zero : ∀ s i, coord s i ≠ 0
  /-- The exchange polynomial assigned to a vertex and direction. -/
  exchange : P.Vertex → I → MvPolynomial I C
  exchange_independent : ∀ s i m, (exchange s i).coeff m ≠ 0 → m i = 0
  exchange_undirected : ∀ {a b i}, P.Edge a b i → exchange a i = exchange b i
  other_coord : ∀ {a b i}, P.Edge a b i → ∀ k, k ≠ i → coord b k = coord a k
  exchange_relation : ∀ {a b i}, P.Edge a b i → coord b i * coord a i =
    MvPolynomial.eval₂ C.subtype (coord a) (exchange a i)

namespace RealizedCaterpillar

variable {C : Subring F} {P : CaterpillarPath I} (R : RealizedCaterpillar C P)

/-- Pull realized coordinate and exchange data back along a label-preserving caterpillar map. -/
def restrict {Q : CaterpillarPath I} (f : Q.Vertex → P.Vertex)
    (hf : ∀ {a b i}, Q.Edge a b i → P.Edge (f a) (f b) i) :
    RealizedCaterpillar C Q where
  coord s := R.coord (f s)
  coord_ne_zero s i := R.coord_ne_zero (f s) i
  exchange s := R.exchange (f s)
  exchange_independent s i m := R.exchange_independent (f s) i m
  exchange_undirected he := R.exchange_undirected (hf he)
  other_coord he := R.other_coord (hf he)
  exchange_relation he := R.exchange_relation (hf he)

theorem exchange_formula {a b : P.Vertex} {i : I} (he : P.Edge a b i) :
    R.coord b i = MvPolynomial.eval₂ C.subtype (R.coord a) (R.exchange a i) / R.coord a i :=
  (eq_div_iff (R.coord_ne_zero a i)).mpr (R.exchange_relation he)

theorem eval_exchange_mem (s : P.Vertex) (i : I) (L : Subring F) (hC : C ≤ L)
    (hx : ∀ k, R.coord s k ∈ L) :
    MvPolynomial.eval₂ C.subtype (R.coord s) (R.exchange s i) ∈ L :=
  MvPolynomial.eval₂_mem (fun m _ => hC (R.exchange s i |>.coeff m).property) hx

theorem edge_mem {a b : P.Vertex} {i : I} (he : P.Edge a b i) (k : I) :
    R.coord b k ∈ chartRing C (R.coord a) := by
  by_cases hki : k = i
  · subst k
    rw [R.exchange_formula he, div_eq_mul_inv]
    exact Subring.mul_mem _
      (R.eval_exchange_mem a i _ (fun _ ha => coefficient_mem_chartRing C _ ha)
        (coordinate_mem_chartRing C _)) (inverse_mem_chartRing C _ i)
  · rw [R.other_coord he k hki]
    exact coordinate_mem_chartRing C _ k

theorem two_edge_mem {a b c : P.Vertex} {i j : I}
    (hab : P.Edge a b i) (hbc : P.Edge b c j) (hij : i ≠ j) (k : I) :
    R.coord c k ∈ chartRing C (R.coord a) := by
  by_cases hkj : k = j
  · subst k
    rw [R.exchange_formula hbc, div_eq_mul_inv, R.other_coord hab j hij.symm]
    exact Subring.mul_mem _
      (R.eval_exchange_mem b j _ (fun _ ha => coefficient_mem_chartRing C _ ha)
        (R.edge_mem hab)) (inverse_mem_chartRing C _ j)
  · rw [R.other_coord hbc k hkj]
    exact R.edge_mem hab k

theorem target_mem_of_length_le_two (hsmall : P.length ≤ 2) (k : I) :
    R.coord P.target k ∈ chartRing C (R.coord P.source) := by
  by_cases hzero : P.length = 0
  · have hst : P.target = P.source := congrArg Sum.inl (Fin.ext hzero)
    rw [hst]
    exact coordinate_mem_chartRing C _ k
  · by_cases hone : P.length = 1
    · have ht : P.target = P.spine ⟨1, by omega⟩ := congrArg Sum.inl (Fin.ext hone)
      rw [ht]
      exact R.edge_mem (CaterpillarPath.Edge.path_forward (P := P) ⟨0, by omega⟩) k
    · have htwo : P.length = 2 := by omega
      have ht : P.target = P.spine ⟨2, by omega⟩ := congrArg Sum.inl (Fin.ext htwo)
      rw [ht]
      exact R.two_edge_mem
        (CaterpillarPath.Edge.path_forward (P := P) ⟨0, by omega⟩)
        (CaterpillarPath.Edge.path_forward (P := P) ⟨1, by omega⟩)
        (P.reduced ⟨0, by omega⟩ (by dsimp; omega)) k

/-- The finite induction step uses only the first local intersection. In
particular, it makes no coprimality claim at other stars of a generic lift. -/
theorem caterpillar_step (h : 3 ≤ P.length) (k : I)
    (hfirst : chartRing C (R.coord (P.spine ⟨1, by omega⟩)) ⊓
      chartRing C (R.coord (P.thirdVertex h)) ≤ chartRing C (R.coord P.source))
    (htail : (R.restrict (P.tailEmbedding (by omega)) (P.tailEmbedding_edge (by omega))).coord
      P.tail.target k ∈ chartRing C
        ((R.restrict (P.tailEmbedding (by omega)) (P.tailEmbedding_edge (by omega))).coord
          P.tail.source))
    (hthree : P.firstLabel h = P.thirdLabel h →
      (R.restrict (P.dropThreeEmbedding h) (P.dropThreeEmbedding_edge h)).coord
        P.dropThree.target k ∈ chartRing C
          ((R.restrict (P.dropThreeEmbedding h) (P.dropThreeEmbedding_edge h)).coord
            P.dropThree.source))
    (hdetour : ∀ hi : P.firstLabel h ≠ P.thirdLabel h,
      (R.restrict (P.detourEmbedding h (P.firstLabel h) (P.firstLabel_ne_secondLabel h) hi)
        (P.detourEmbedding_edge h (P.firstLabel h) (P.firstLabel_ne_secondLabel h) hi)).coord
          (P.detour h (P.firstLabel h) hi).target k ∈ chartRing C
            ((R.restrict (P.detourEmbedding h (P.firstLabel h) (P.firstLabel_ne_secondLabel h) hi)
              (P.detourEmbedding_edge h (P.firstLabel h) (P.firstLabel_ne_secondLabel h) hi)).coord
                (P.detour h (P.firstLabel h) hi).source)) :
    R.coord P.target k ∈ chartRing C (R.coord P.source) := by
  apply hfirst
  constructor
  · change R.coord P.target k ∈ chartRing C (R.coord (P.spine ⟨1, by omega⟩))
    change R.coord (P.tailEmbedding _ P.tail.target) k ∈
      chartRing C (R.coord (P.tailEmbedding _ P.tail.source)) at htail
    simpa only [P.tailEmbedding_target, P.tailEmbedding_source] using htail
  · change R.coord P.target k ∈ chartRing C (R.coord (P.thirdVertex h))
    by_cases hi : P.firstLabel h = P.thirdLabel h
    · have hh := hthree hi
      change R.coord (P.dropThreeEmbedding h P.dropThree.target) k ∈
        chartRing C (R.coord (P.dropThreeEmbedding h P.dropThree.source)) at hh
      simpa only [P.dropThreeEmbedding_target,
        P.dropThreeEmbedding_source_thirdVertex h hi] using hh
    · have hh := hdetour hi
      change R.coord (P.detourEmbedding h _ _ hi (P.detour h _ hi).target) k ∈
        chartRing C (R.coord (P.detourEmbedding h _ _ hi (P.detour h _ hi).source)) at hh
      have hs := P.detourEmbedding_source_thirdVertex h hi
      have he := P.detourEmbedding_target h (P.firstLabel h)
        (P.firstLabel_ne_secondLabel h) hi
      rw [he, hs] at hh
      exact hh

/-- Local intersections only across forward edges between internal spine vertices. -/
def ForwardLocalIntersections : Prop :=
  ∀ (p : Fin (P.length - 2)) (i : I),
    i ≠ P.rightLabel (P.interiorLeft p) →
    chartRing C (R.coord (P.spine (P.internalIndex (P.interiorLeft p)))) ⊓
      chartRing C (R.coord (P.starNeighbor (P.interiorRight p) i)) ≤
        chartRing C (R.coord (P.starNeighbor (P.interiorLeft p) i))

theorem restrict_forwardLocalIntersections (hlocal : R.ForwardLocalIntersections)
    {Q : CaterpillarPath I} (f : Q.Vertex → P.Vertex)
    (hf : ∀ {a b i}, Q.Edge a b i → P.Edge (f a) (f b) i)
    (shift : Fin (Q.length - 2) → Fin (P.length - 2))
    (hleft : ∀ p, f (Q.spine (Q.internalIndex (Q.interiorLeft p))) =
      P.spine (P.internalIndex (P.interiorLeft (shift p))))
    (hright : ∀ p, f (Q.spine (Q.internalIndex (Q.interiorRight p))) =
      P.spine (P.internalIndex (P.interiorRight (shift p))))
    (hlabel : ∀ p, Q.rightLabel (Q.interiorLeft p) = P.rightLabel (P.interiorLeft (shift p))) :
    (R.restrict f hf).ForwardLocalIntersections := by
  intro p i hi
  have hl := P.map_starNeighbor f hf (Q.interiorLeft p) (P.interiorLeft (shift p)) (hleft p) i
  have hr := P.map_starNeighbor f hf (Q.interiorRight p) (P.interiorRight (shift p)) (hright p) i
  change chartRing C (R.coord (f (Q.spine (Q.internalIndex (Q.interiorLeft p))))) ⊓
    chartRing C (R.coord (f (Q.starNeighbor (Q.interiorRight p) i))) ≤
      chartRing C (R.coord (f (Q.starNeighbor (Q.interiorLeft p) i)))
  rw [hleft p, hl, hr]
  exact hlocal (shift p) i (by rwa [← hlabel p])

theorem tail_forwardLocalIntersections (hlocal : R.ForwardLocalIntersections)
    (hpos : 0 < P.length) :
    (R.restrict (P.tailEmbedding hpos) (P.tailEmbedding_edge hpos)).ForwardLocalIntersections := by
  apply R.restrict_forwardLocalIntersections hlocal _ _
    (fun p => ⟨p.val + 1, by have hh : p.val < P.length - 1 - 2 := p.isLt; omega⟩)
  · intro p; rfl
  · intro p; rfl
  · intro p; rfl

theorem dropThree_forwardLocalIntersections (hlocal : R.ForwardLocalIntersections)
    (h : 3 ≤ P.length) :
    (R.restrict (P.dropThreeEmbedding h) (P.dropThreeEmbedding_edge h)).ForwardLocalIntersections :=
      by
  apply R.restrict_forwardLocalIntersections hlocal _ _
    (fun p => ⟨p.val + 3, by
      have hh : p.val < P.length - 1 - 1 - 1 - 2 := p.isLt
      omega⟩)
  · intro p; rfl
  · intro p; rfl
  · intro p; rfl

theorem detour_forwardLocalIntersections (hlocal : R.ForwardLocalIntersections)
    (h : 3 ≤ P.length) (i : I) (hl : i ≠ P.label ⟨1, by omega⟩)
    (hr : i ≠ P.label ⟨2, by omega⟩) :
    (R.restrict (P.detourEmbedding h i hl hr)
      (P.detourEmbedding_edge h i hl hr)).ForwardLocalIntersections := by
  classical
  apply R.restrict_forwardLocalIntersections hlocal _ _
    (fun p => ⟨p.val + 1, by have hh : p.val < P.length - 1 - 2 := p.isLt; omega⟩)
  · intro p
    simp [CaterpillarPath.detourEmbedding, CaterpillarPath.spine,
      CaterpillarPath.internalIndex, CaterpillarPath.interiorLeft]
    rfl
  · intro p
    simp [CaterpillarPath.detourEmbedding, CaterpillarPath.spine,
      CaterpillarPath.internalIndex, CaterpillarPath.interiorRight]
    rfl
  · intro p
    simp [CaterpillarPath.rightLabel, CaterpillarPath.rightIndex, CaterpillarPath.interiorLeft,
      CaterpillarPath.detour, CaterpillarPath.detourLabel]

theorem first_intersection (h : 3 ≤ P.length) (hlocal : R.ForwardLocalIntersections) :
    chartRing C (R.coord (P.spine ⟨1, by omega⟩)) ⊓
      chartRing C (R.coord (P.thirdVertex h)) ≤ chartRing C (R.coord P.source) := by
  have hh := hlocal ⟨0, by omega⟩ (P.firstLabel h) (P.firstLabel_ne_secondLabel h)
  change chartRing C (R.coord (P.spine ⟨1, by omega⟩)) ⊓
    chartRing C (R.coord (P.thirdVertex h)) ≤
      chartRing C (R.coord (P.starNeighbor ⟨0, by omega⟩ (P.firstLabel h))) at hh
  have hs : P.starNeighbor ⟨0, by omega⟩ (P.firstLabel h) = P.source :=
    P.starNeighbor_left ⟨0, by omega⟩
  rw [hs] at hh
  exact hh

/-- The finite factorial-route induction with only forward interior local
intersections. Polynomial C2 certificates can discharge these intersections. -/
theorem target_mem_of_forwardLocalIntersections
    (hlocal : R.ForwardLocalIntersections) (k : I) :
    R.coord P.target k ∈ chartRing C (R.coord P.source) := by
  have hall : ∀ Q : CaterpillarPath I, ∀ T : RealizedCaterpillar C Q,
      T.ForwardLocalIntersections → T.coord Q.target k ∈ chartRing C (T.coord Q.source) := by
    apply CaterpillarPath.strong_induction
    · intro Q hsmall T _
      exact T.target_mem_of_length_le_two hsmall k
    · intro Q h ihTail ihThree ihDetour T hT
      apply T.caterpillar_step h k (T.first_intersection h hT)
      · exact ihTail _ (T.tail_forwardLocalIntersections hT (by omega))
      · intro hi
        exact ihThree hi _ (T.dropThree_forwardLocalIntersections hT h)
      · intro hi
        exact ihDetour hi _ (T.detour_forwardLocalIntersections hT h (Q.firstLabel h)
          (Q.firstLabel_ne_secondLabel h) hi)
  exact hall P R hlocal

end RealizedCaterpillar

end TauCeti.Laurent
