/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.GroupedLocalAlgebra
public import TauCetiRoadmap.LaurentPhenomenon.Rechart

/-! # Realized Local Coordinates -/

@[expose] public section

namespace TauCeti.Laurent

noncomputable section
open scoped LaurentPolynomial

variable {G I F : Type*} [AddCommGroup G] [DecidableEq I] [Field F]

omit [DecidableEq I] in
/-- Coefficients and the mutable basis variables determine a Laurent evaluation. -/
theorem laurentRingHom_ext (f g : TotalLaurentRing G I →+* F)
    (hc : ∀ a, f (AddMonoidAlgebra.single (a, 0) 1) = g (AddMonoidAlgebra.single (a, 0) 1))
    (hx : ∀ i, f (AddMonoidAlgebra.single (0, Finsupp.single i 1) 1) =
      g (AddMonoidAlgebra.single (0, Finsupp.single i 1) 1)) : f = g := by
  have hc' (a : G) : ringCharacter f (a, 0) = ringCharacter g (a, 0) := by
    ext
    exact hc a
  have hx' (i : I) : ringCharacter f (0, Finsupp.single i 1) =
      ringCharacter g (0, Finsupp.single i 1) := by
    ext
    exact hx i
  have hl (a : I →₀ ℤ) : ringCharacter f (0, a) = ringCharacter g (0, a) := by
    induction a using Finsupp.induction_linear with
    | zero => exact map_zero (ringCharacter f) |>.trans (map_zero (ringCharacter g)).symm
    | add a b ha hb =>
      rw [show ((0, a + b) : LaurentExponent G I) = (0, a) + (0, b) by simp]
      rw [map_add, map_add, ha, hb]
    | single i n =>
      have he : ((0, Finsupp.single i n) : LaurentExponent G I) =
          n • (0, Finsupp.single i 1) := by simp [Finsupp.smul_single]
      rw [he, map_zsmul, map_zsmul, hx' i]
  have hχ : ringCharacter f = ringCharacter g := by
    apply AddMonoidHom.ext
    intro t
    have he : t = (t.1, 0) + (0, t.2) := by simp
    rw [he, map_add, map_add, hc', hl]
  apply AddMonoidAlgebra.ringHom_ext
  · intro n
    change f (n : TotalLaurentRing G I) = g (n : TotalLaurentRing G I)
    simp
  · intro t
    have ht := DFunLike.congr_fun hχ t
    exact congrArg (fun a : Additive Fˣ => ((a.toMul : Fˣ) : F)) ht

omit [DecidableEq I] in
theorem initialVariables_ne_zero (f : TotalLaurentRing G I →+* F) (i : I) :
    initialVariables f i ≠ 0 := (Units.map f.toMonoidHom
      (groupRingBasisUnit (0, Finsupp.single i 1))).ne_zero

omit [DecidableEq I] in
theorem rechart_initial (f : TotalLaurentRing G I →+* F) :
    rechart f (initialVariables f) (initialVariables_ne_zero f) = f := by
  apply laurentRingHom_ext
  · intro g
    have h := RingHom.congr_fun (rechart_coefficient f (initialVariables f)
      (initialVariables_ne_zero f)) (AddMonoidAlgebra.single g 1)
    simp []
  · intro i
    exact rechart_variable f _ _ i

omit [DecidableEq I] in
theorem coordinateEvaluate_initial (f : TotalLaurentRing G I →+* F)
    (E : PositiveLaurent G I) :
    coordinateEvaluate f E (initialVariables f) = f (positiveCast E) := by
  classical
  rw [← rechart_positive f _ (initialVariables_ne_zero f), rechart_initial]

theorem updateInitialNonzero (f : TotalLaurentRing G I →+* F) (j : I) (u : Fˣ) :
    ∀ k, Function.update (initialVariables f) j (u : F) k ≠ 0 := by
  intro k
  by_cases hk : k = j
  · subst k; simp
  · simpa [Function.update_of_ne hk] using initialVariables_ne_zero f k

/-- Retain the coefficient evaluation of f and evaluate the selected Laurent variable at the
prescribed unit.
-/
def oneVariableEvaluation (f : TotalLaurentRing G I →+* F) (j : I) (u : Fˣ) :
    TotalLaurentRing G I →+* F :=
  (LaurentPolynomial.eval₂ (f.comp (embedMutableCoefficient j)) u).comp (laurentSplit j).toRingHom

theorem rechart_oneVariable (f : TotalLaurentRing G I →+* F) (j : I) (u : Fˣ) :
    rechart f (Function.update (initialVariables f) j (u : F)) (updateInitialNonzero f j u) =
      oneVariableEvaluation f j u := by
  apply laurentRingHom_ext
  · intro g
    change (rechart f _ _) (AddMonoidAlgebra.single (g, 0) 1) =
      LaurentPolynomial.eval₂ (f.comp (embedMutableCoefficient j)) u
        (laurentSplit j (AddMonoidAlgebra.single (g, 0) 1))
    rw [laurentSplit_coefficient]
    rw [show LaurentPolynomial.eval₂ (f.comp (embedMutableCoefficient j)) u
        (LaurentPolynomial.C (AddMonoidAlgebra.single (g, 0) 1)) =
        f (embedMutableCoefficient j (AddMonoidAlgebra.single (g, 0) 1)) by
          simp [← Polynomial.toLaurent_C]]
    have he : embedMutableCoefficient j (AddMonoidAlgebra.single (g, 0) 1) =
        AddMonoidAlgebra.single (g, 0) 1 := by
      simpa using embedMutableCoefficient_single j g (0 : I →₀ ℤ) 1
    rw [he]
    simp [rechart_single]
  · intro k
    rw [rechart_variable]
    change Function.update (initialVariables f) j (u : F) k =
      LaurentPolynomial.eval₂ (f.comp (embedMutableCoefficient j)) u
        (laurentSplit j (AddMonoidAlgebra.single (0, Finsupp.single k 1) 1))
    by_cases hk : k = j
    · subst k
      rw [laurentSplit_chosen]
      simp [← Polynomial.toLaurent_X]
    · have hj : (Finsupp.single k (1 : ℤ)) j = 0 :=
        Finsupp.single_eq_of_ne (fun hh => hk hh.symm)
      rw [laurentSplit_constant (R := ℤ) (G := G) j (0 : G) (Finsupp.single k 1) (1 : ℤ) hj]
      rw [show LaurentPolynomial.eval₂ (f.comp (embedMutableCoefficient j)) u
          (LaurentPolynomial.C (AddMonoidAlgebra.single
            (0, (splitExponents j (Finsupp.single k 1)).2) 1)) =
          f (embedMutableCoefficient j (AddMonoidAlgebra.single
            (0, (splitExponents j (Finsupp.single k 1)).2) 1)) by
              simp [← Polynomial.toLaurent_C]]
      rw [embedMutableCoefficient_single]
      simp [Function.update_of_ne hk, hj, initialVariables]

theorem groupedPolynomial_eval_update (f : TotalLaurentRing G I →+* F)
    (E : PositiveLaurent G I) (j : I) (u : Fˣ) (hE : PositiveNonnegativeAt E j) :
    coordinateEvaluate f E (Function.update (initialVariables f) j (u : F)) =
      ((groupedPolynomial E j).map (f.comp (embedMutableCoefficient j))).eval (u : F) := by
  rw [← rechart_positive f _ (updateInitialNonzero f j u), rechart_oneVariable]
  change LaurentPolynomial.eval₂ (f.comp (embedMutableCoefficient j)) u
    (laurentSplit j (positiveCast E)) = _
  rw [← groupedPolynomial_toLaurent E j hE, LaurentPolynomial.eval₂_toLaurent,
    Polynomial.eval_map]

/-- The formal inverse of the ith mutable Laurent generator. -/
def inverseVariable (i : I) : TotalLaurentRing G I :=
  AddMonoidAlgebra.single (0, Finsupp.single i (-1)) 1

omit [DecidableEq I] in
theorem inverseVariable_image (f : TotalLaurentRing G I →+* F) (i : I) :
    f (inverseVariable i) = (initialVariables f i)⁻¹ := by
  apply eq_inv_of_mul_eq_one_left
  change f (inverseVariable i) * f (AddMonoidAlgebra.single (0, Finsupp.single i 1) 1) = 1
  rw [← map_mul]
  have he : inverseVariable (G := G) i * AddMonoidAlgebra.single (0, Finsupp.single i 1) 1 = 1 := by
    simp [inverseVariable, AddMonoidAlgebra.single_mul_single,
      AddMonoidAlgebra.one_def]
    rfl
  exact (congrArg f he).trans (map_one f)

/-- The first exchanged Laurent coordinate, the integer-cast exchange polynomial divided by the
ith variable.
-/
def firstRingExpression (E : PositiveLaurent G I) (i : I) : TotalLaurentRing G I :=
  positiveCast E * inverseVariable i

/-- Evaluate the second exchange polynomial at the first exchanged coordinate and divide by the
jth variable.
-/
def secondRingExpression (E Q : PositiveLaurent G I) (i j : I) : TotalLaurentRing G I :=
  inverseVariable j * ((groupedPolynomial Q i).map (embedMutableCoefficient i)).eval
    (firstRingExpression E i)

/-- The third exchange numerator evaluated at the second exchanged Laurent coordinate. -/
def thirdExchangeRingExpression (E Q R : PositiveLaurent G I) (i j : I) : TotalLaurentRing G I :=
  ((regroupedPolynomial R i j).map (embedMutableCoefficient i)).eval (secondRingExpression E Q i j)

theorem split_firstRingExpression (E : PositiveLaurent G I) (i : I)
    (hEi : PositiveIndependent E i) :
    laurentSplit i (firstRingExpression E i) = firstLocal (eraseMutable i (positiveCast E)) := by
  rw [firstRingExpression, map_mul, ← eraseMutable_independent E i hEi]
  rw [inverseVariable, laurentSplit_chosen]
  rfl

theorem split_secondRingExpression (E Q : PositiveLaurent G I) (i j : I)
    (hij : i ≠ j) (hEi : PositiveIndependent E i) :
    laurentSplit i (secondRingExpression E Q i j) =
      secondLocal (eraseMutable i (positiveCast E)) (eraseMutable i (inverseVariable j))
        (groupedPolynomial Q i) := by
  rw [secondRingExpression, map_mul]
  have hy : laurentSplit i (inverseVariable (G := G) j) =
      LaurentPolynomial.C (eraseMutable i (inverseVariable j)) := by
    apply (split_eraseMutable_single i 0 (Finsupp.single j (-1)) 1
      (by simp [hij.symm])).symm
  rw [hy]
  have hmaps : (laurentSplit (G := G) i).toRingHom.comp (embedMutableCoefficient i) =
      LaurentPolynomial.C := by
    apply RingHom.ext
    intro c
    change (laurentSplit i) ((laurentSplit i).symm (LaurentPolynomial.C c)) = _
    exact (laurentSplit i).apply_symm_apply _
  have hp := (Polynomial.eval_map_apply (f := (laurentSplit (G := G) i).toRingHom)
    (p := (groupedPolynomial Q i).map (embedMutableCoefficient i)) (firstRingExpression E i)).symm
  change (laurentSplit i) (((groupedPolynomial Q i).map (embedMutableCoefficient i)).eval
    (firstRingExpression E i)) =
      (((groupedPolynomial Q i).map (embedMutableCoefficient i)).map (laurentSplit
        i).toRingHom).eval
        (laurentSplit i (firstRingExpression E i)) at hp
  rw [hp, Polynomial.map_map, hmaps, split_firstRingExpression E i hEi]
  rfl

theorem split_thirdExchangeRingExpression (E Q R : PositiveLaurent G I) (i j : I)
    (hij : i ≠ j) (hEi : PositiveIndependent E i) :
    laurentSplit i (thirdExchangeRingExpression E Q R i j) =
      ((regroupedPolynomial R i j).map LaurentPolynomial.C).eval
        (secondLocal (eraseMutable i (positiveCast E)) (eraseMutable i (inverseVariable j))
          (groupedPolynomial Q i)) := by
  have hmaps : (laurentSplit (G := G) i).toRingHom.comp (embedMutableCoefficient i) =
      LaurentPolynomial.C := by
    apply RingHom.ext
    intro c
    change (laurentSplit i) ((laurentSplit i).symm (LaurentPolynomial.C c)) = _
    exact (laurentSplit i).apply_symm_apply _
  unfold thirdExchangeRingExpression
  have hp := (Polynomial.eval_map_apply (f := (laurentSplit (G := G) i).toRingHom)
    (p := (regroupedPolynomial R i j).map (embedMutableCoefficient i))
      (secondRingExpression E Q i j)).symm
  change (laurentSplit i) (((regroupedPolynomial R i j).map (embedMutableCoefficient i)).eval
    (secondRingExpression E Q i j)) =
      (((regroupedPolynomial R i j).map (embedMutableCoefficient i)).map (laurentSplit
        i).toRingHom).eval
        (laurentSplit i (secondRingExpression E Q i j)) at hp
  rw [hp, Polynomial.map_map, hmaps, split_secondRingExpression E Q i j hij hEi]

namespace PositiveCaterpillar

variable {P : CaterpillarPath I}
variable (T : PositiveCaterpillar G P) (f : TotalLaurentRing G I →+* F)
variable (hf : ∀ p, positiveCast p ≠ 0 → f (positiveCast p) ≠ 0)

theorem value_source_tuple : T.value f P.source = initialVariables f :=
  funext (T.value_source f)

theorem image_mem_source (r : TotalLaurentRing G I) :
    f r ∈ chartRing (coefficientRange f) (T.value f P.source) := by
  rw [T.value_source_tuple f]
  exact laurent_image_mem_initialChart f r

/-- Identify the realized source chart with a one-variable Laurent ring using the faithful map f. -/
def sourceLaurentEquiv (hfi : Function.Injective f) (i : I) :=
  (RingEquiv.subringCongr (show chartRing (coefficientRange f) (T.value f P.source) =
    chartRing (coefficientRange f) (initialVariables f) from
      congrArg (chartRing (coefficientRange f)) (T.value_source_tuple f))).trans
    (groupChartLaurentEquiv f hfi i)

theorem sourceLaurent_image (hfi : Function.Injective f) (i : I) (r : TotalLaurentRing G I) :
    T.sourceLaurentEquiv f hfi i ⟨f r, T.image_mem_source f r⟩ = laurentSplit i r := by
  change groupChartLaurentEquiv f hfi i (groupChartEquiv f hfi r) = _
  exact groupChartLaurentEquiv_image f hfi i r

include hf in
theorem value_first_tuple (h : 3 ≤ P.length) :
    T.value f (P.spine ⟨1, by omega⟩) = Function.update (initialVariables f) (P.firstLabel h)
      (T.value f (P.spine ⟨1, by omega⟩) (P.firstLabel h)) := by
  funext k
  by_cases hk : k = P.firstLabel h
  · subst k; simp
  · rw [Function.update_of_ne hk]
    exact ((T.value_edge f hf (CaterpillarPath.Edge.path_forward (P := P) ⟨0, by omega⟩)).1 k
      hk).trans
      (T.value_source f k)

include hf in
theorem value_first_ring (h : 3 ≤ P.length) :
    T.value f (P.spine ⟨1, by omega⟩) (P.firstLabel h) =
      f (firstRingExpression (T.exchange (P.spine ⟨1, by omega⟩) (P.firstLabel h)) (P.firstLabel h))
        := by
  have hv := (T.value_edge f hf
    (CaterpillarPath.Edge.path_forward (P := P) ⟨0, by omega⟩)).2
  change T.value f (P.spine ⟨1, by omega⟩) (P.firstLabel h) *
    T.value f P.source (P.firstLabel h) =
      coordinateEvaluate f (T.exchange P.source (P.firstLabel h)) (T.value f P.source) at hv
  rw [T.value_source_tuple f, coordinateEvaluate_initial] at hv
  have he := T.exchange_undirected (CaterpillarPath.Edge.path_forward (P := P) ⟨0, by omega⟩)
  change T.exchange P.source (P.firstLabel h) =
    T.exchange (P.spine ⟨1, by omega⟩) (P.firstLabel h) at he
  rw [he] at hv
  have hquot := (eq_div_iff (initialVariables_ne_zero f (P.firstLabel h))).mpr hv
  rw [hquot, firstRingExpression, map_mul, inverseVariable_image, div_eq_mul_inv]

include hf in
theorem value_second_ring (h : 3 ≤ P.length) :
    T.value f (P.spine ⟨2, by omega⟩) (P.secondLabel h) =
      f (secondRingExpression (T.exchange (P.spine ⟨1, by omega⟩) (P.firstLabel h))
        (T.exchange (P.spine ⟨1, by omega⟩) (P.secondLabel h)) (P.firstLabel h) (P.secondLabel h))
          := by
  let i := P.firstLabel h
  let j := P.secondLabel h
  let z := firstRingExpression (T.exchange (P.spine ⟨1, by omega⟩) i) i
  let zu : Fˣ := Units.mk0 (T.value f (P.spine ⟨1, by omega⟩) i) (T.value_ne_zero f hf _ i)
  have hv := (T.value_edge f hf
    (CaterpillarPath.Edge.path_forward (P := P) ⟨1, by omega⟩)).2
  change T.value f (P.spine ⟨2, by omega⟩) j * T.value f (P.spine ⟨1, by omega⟩) j =
    coordinateEvaluate f (T.exchange (P.spine ⟨1, by omega⟩) j)
      (T.value f (P.spine ⟨1, by omega⟩)) at hv
  have hQ : PositiveNonnegativeAt (T.exchange (P.spine ⟨1, by omega⟩) j) i :=
    fun a ha => T.exchange_polynomial _ _ a ha i
  rw [T.value_first_tuple f hf h] at hv
  change T.value f (P.spine ⟨2, by omega⟩) j *
    Function.update (initialVariables f) i (zu : F) j =
      coordinateEvaluate f (T.exchange (P.spine ⟨1, by omega⟩) j)
        (Function.update (initialVariables f) i (zu : F)) at hv
  rw [groupedPolynomial_eval_update f _ i zu hQ] at hv
  have hij := P.firstLabel_ne_secondLabel h
  have hy : Function.update (initialVariables f) i (zu : F) j = initialVariables f j :=
    Function.update_of_ne hij.symm _ _
  change _ * Function.update (initialVariables f) i (zu : F) j = _ at hv
  rw [hy] at hv
  have hz : (zu : F) = f z := T.value_first_ring f hf h
  rw [hz] at hv
  have hpoly : ((groupedPolynomial (T.exchange (P.spine ⟨1, by omega⟩) j) i).map
      (f.comp (embedMutableCoefficient i))).eval (f z) =
      f (((groupedPolynomial (T.exchange (P.spine ⟨1, by omega⟩) j) i).map
        (embedMutableCoefficient i)).eval z) := by
    rw [← Polynomial.map_map, Polynomial.eval_map_apply]
  rw [hpoly] at hv
  have hquot := (eq_div_iff (initialVariables_ne_zero f j)).mpr hv
  change _ = f (inverseVariable j * _)
  rw [hquot, map_mul, inverseVariable_image, div_eq_mul_inv, mul_comm]

include hf in
theorem sourceLaurent_first (h : 3 ≤ P.length) (hfi : Function.Injective f)
    (hm : T.value f (P.spine ⟨1, by omega⟩) (P.firstLabel h) ∈
      chartRing (coefficientRange f) (T.value f P.source)) :
    T.sourceLaurentEquiv f hfi (P.firstLabel h) ⟨_, hm⟩ =
      firstLocal (eraseMutable (P.firstLabel h)
        (positiveCast (T.exchange (P.spine ⟨1, by omega⟩) (P.firstLabel h)))) := by
  have he : (⟨T.value f (P.spine ⟨1, by omega⟩) (P.firstLabel h), hm⟩ :
      chartRing (coefficientRange f) (T.value f P.source)) =
      ⟨f (firstRingExpression (T.exchange (P.spine ⟨1, by omega⟩) (P.firstLabel h)) (P.firstLabel
        h)),
        T.image_mem_source f _⟩ := Subtype.ext (T.value_first_ring f hf h)
  rw [he, T.sourceLaurent_image]
  exact split_firstRingExpression _ _ (T.exchange_independent _ _)

include hf in
theorem sourceLaurent_second (h : 3 ≤ P.length) (hfi : Function.Injective f)
    (hm : T.value f (P.spine ⟨2, by omega⟩) (P.secondLabel h) ∈
      chartRing (coefficientRange f) (T.value f P.source)) :
    T.sourceLaurentEquiv f hfi (P.firstLabel h) ⟨_, hm⟩ =
      secondLocal (eraseMutable (P.firstLabel h)
        (positiveCast (T.exchange (P.spine ⟨1, by omega⟩) (P.firstLabel h))))
        (eraseMutable (P.firstLabel h) (inverseVariable (P.secondLabel h)))
        (groupedPolynomial (T.exchange (P.spine ⟨1, by omega⟩) (P.secondLabel h)) (P.firstLabel h))
          := by
  have he : (⟨T.value f (P.spine ⟨2, by omega⟩) (P.secondLabel h), hm⟩ :
      chartRing (coefficientRange f) (T.value f P.source)) =
      ⟨f (secondRingExpression (T.exchange (P.spine ⟨1, by omega⟩) (P.firstLabel h))
        (T.exchange (P.spine ⟨1, by omega⟩) (P.secondLabel h)) (P.firstLabel h) (P.secondLabel h)),
        T.image_mem_source f _⟩ := Subtype.ext (T.value_second_ring f hf h)
  rw [he, T.sourceLaurent_image]
  exact split_secondRingExpression _ _ _ _ (P.firstLabel_ne_secondLabel h) (T.exchange_independent _
    _)

include hf in
theorem value_second_tuple (h : 3 ≤ P.length) :
    T.value f (P.spine ⟨2, by omega⟩) =
      Function.update (T.value f (P.spine ⟨1, by omega⟩)) (P.secondLabel h)
        (T.value f (P.spine ⟨2, by omega⟩) (P.secondLabel h)) := by
  funext k
  by_cases hk : k = P.secondLabel h
  · subst k; simp
  · rw [Function.update_of_ne hk]
    exact (T.value_edge f hf (CaterpillarPath.Edge.path_forward (P := P) ⟨1, by omega⟩)).1 k hk

include hf in
theorem value_third_exchange_image (h : 3 ≤ P.length) :
    T.value f (P.thirdVertex h) (P.firstLabel h) *
      T.value f (P.spine ⟨1, by omega⟩) (P.firstLabel h) =
      f (thirdExchangeRingExpression
        (T.exchange (P.spine ⟨1, by omega⟩) (P.firstLabel h))
        (T.exchange (P.spine ⟨1, by omega⟩) (P.secondLabel h))
        (T.exchange (P.spine ⟨2, by omega⟩) (P.firstLabel h)) (P.firstLabel h) (P.secondLabel h)) :=
          by
  let i := P.firstLabel h
  let j := P.secondLabel h
  let E := T.exchange (P.spine ⟨1, by omega⟩) i
  let Q := T.exchange (P.spine ⟨1, by omega⟩) j
  let R := T.exchange (P.spine ⟨2, by omega⟩) i
  let u := secondRingExpression E Q i j
  let uu : Fˣ := Units.mk0 (T.value f (P.spine ⟨2, by omega⟩) j) (T.value_ne_zero f hf _ j)
  have hij : i ≠ j := P.firstLabel_ne_secondLabel h
  have hv := (T.value_edge f hf (P.thirdVertex_edge h)).2
  have hi := (T.value_edge f hf
    (CaterpillarPath.Edge.path_forward (P := P) ⟨1, by omega⟩)).1 i hij
  change T.value f (P.spine ⟨2, by omega⟩) i = T.value f (P.spine ⟨1, by omega⟩) i at hi
  rw [hi] at hv
  have heval : coordinateEvaluate f R (T.value f (P.spine ⟨2, by omega⟩)) =
      coordinateEvaluate f R (Function.update (initialVariables f) j (uu : F)) := by
    rw [T.value_second_tuple f hf h, T.value_first_tuple f hf h]
    have he : Function.update (Function.update (initialVariables f) i
        (T.value f (P.spine ⟨1, by omega⟩) i)) j (uu : F) =
        Function.update (Function.update (initialVariables f) j (uu : F)) i
          (T.value f (P.spine ⟨1, by omega⟩) i) := by
      funext k
      by_cases hki : k = i <;> by_cases hkj : k = j <;> simp_all
    change coordinateEvaluate f R (Function.update (Function.update (initialVariables f) i
      (T.value f (P.spine ⟨1, by omega⟩) i)) j (uu : F)) = _
    rw [he]
    exact coordinateEvaluate_update f R i (T.exchange_independent _ _) _ _
  change _ = coordinateEvaluate f R (T.value f (P.spine ⟨2, by omega⟩)) at hv
  rw [heval, groupedPolynomial_eval_update f R j uu
    (fun a ha => T.exchange_polynomial _ _ a ha j)] at hv
  have hu : (uu : F) = f u := T.value_second_ring f hf h
  have hp : (regroupedPolynomial R i j).map (f.comp (embedMutableCoefficient i)) =
      (groupedPolynomial R j).map (f.comp (embedMutableCoefficient j)) := by
    rw [← Polynomial.map_map, ← Polynomial.map_map,
      regroupedPolynomial_embed R i j hij (T.exchange_independent _ _)]
  rw [← hp, hu, ← Polynomial.map_map, Polynomial.eval_map_apply] at hv
  exact hv

include hf in
theorem value_third_exchange_ring (h : 3 ≤ P.length) (hfi : Function.Injective f) :
    T.value f (P.thirdVertex h) (P.firstLabel h) *
      T.value f (P.spine ⟨1, by omega⟩) (P.firstLabel h) =
    ((T.sourceLaurentEquiv f hfi (P.firstLabel h)).symm
      (((regroupedPolynomial (T.exchange (P.spine ⟨2, by omega⟩) (P.firstLabel h))
        (P.firstLabel h) (P.secondLabel h)).map LaurentPolynomial.C).eval
        (secondLocal (eraseMutable (P.firstLabel h)
          (positiveCast (T.exchange (P.spine ⟨1, by omega⟩) (P.firstLabel h))))
          (eraseMutable (P.firstLabel h) (inverseVariable (P.secondLabel h)))
          (groupedPolynomial (T.exchange (P.spine ⟨1, by omega⟩) (P.secondLabel h))
            (P.firstLabel h)))) : F) := by
  let r := thirdExchangeRingExpression
    (T.exchange (P.spine ⟨1, by omega⟩) (P.firstLabel h))
    (T.exchange (P.spine ⟨1, by omega⟩) (P.secondLabel h))
    (T.exchange (P.spine ⟨2, by omega⟩) (P.firstLabel h)) (P.firstLabel h) (P.secondLabel h)
  have he : (T.sourceLaurentEquiv f hfi (P.firstLabel h)).symm (laurentSplit (P.firstLabel h) r) =
      ⟨f r, T.image_mem_source f r⟩ := by
    apply (T.sourceLaurentEquiv f hfi (P.firstLabel h)).injective
    rw [RingEquiv.apply_symm_apply, T.sourceLaurent_image]
  rw [← split_thirdExchangeRingExpression _ _ _ _ _ (P.firstLabel_ne_secondLabel h)
    (T.exchange_independent _ _)]
  change _ = ((T.sourceLaurentEquiv f hfi (P.firstLabel h)).symm (laurentSplit (P.firstLabel h) r) :
    F)
  rw [he]
  exact T.value_third_exchange_image f hf h

end PositiveCaterpillar

end

end TauCeti.Laurent
