/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.CommutingCoprimality
public import TauCetiRoadmap.ClusterAlgebras.GeometricSeed
public import TauCetiRoadmap.ClusterAlgebras.GeometricExchangePair
public import TauCetiRoadmap.LaurentPhenomenon.LaurentChart
public import TauCetiRoadmap.LaurentPhenomenon.LaurentFactorial

/-! The unchanged-coordinate coefficient ring `D` in a commuting geometric
exchange is a factorial Laurent ring over the coefficients (`R_J` or `𝕜_J`). The
commuting three-chart equality holds when `E_i`, `E_j` are relatively prime in `D`;
full column rank of the extended matrix implies this. -/

@[expose] public section

noncomputable section
namespace TauCeti.Cluster.UpperBound
open TauCeti.Laurent TauCeti.Laurent.OneExchange TauCeti.Cluster

variable {F M K : Type*} [Field F] [Algebra ℚ F]
  [Fintype M] [Fintype K] [DecidableEq M] [DecidableEq K]

/-- The image of the integer scalar homomorphism in the ambient field. -/
abbrev geometricIntegerRing (F : Type*) [Field F] := (Int.castRingHom F).range

/-- The original units restricted to coordinates outside i and j. -/
def complementLaurentUnits (x : M → Fˣ) (i j : M) :
    {a : M // a ≠ i ∧ a ≠ j} → Fˣ := fun a => x a

/-- Evaluate integer Laurent polynomials in the complementary coordinates, with codomain their
actual chart ring.
-/
def complementLaurentEvaluation (x : M → Fˣ) (i j : M) :
    AddMonoidAlgebra ℤ ({a : M // a ≠ i ∧ a ≠ j} →₀ ℤ) →+*
      pairComplementRing (geometricIntegerRing F) (fun a => (x a : F)) i j :=
  (TauCeti.Laurent.LaurentEvaluation.eval (Int.castRingHom F)
    (complementLaurentUnits x i j)).codRestrict _ (by
    intro p
    exact TauCeti.Laurent.LaurentEvaluation.eval_mem_chart
      (Int.castRingHom F) (complementLaurentUnits x i j) p)

omit [DecidableEq M] [Fintype M] in
theorem complementLaurentEvaluation_injective [Finite M] (x : M → Fˣ) (i j : M)
    (hAI : AlgebraicIndependent ℚ (fun a => (x a : F))) :
    Function.Injective (complementLaurentEvaluation x i j) := by
  let : Fintype M := Fintype.ofFinite M
  intro p q hpq
  apply integerLaurent_eval_injective_of_algebraicIndependent
    (complementLaurentUnits x i j) (hAI.comp Subtype.val Subtype.val_injective)
  exact congrArg Subtype.val hpq

omit [Algebra ℚ F] [DecidableEq M] [Fintype M] in
theorem complementLaurentEvaluation_surjective (x : M → Fˣ) (i j : M) :
    Function.Surjective (complementLaurentEvaluation x i j) := by
  intro a
  have ha : (a : F) ∈ pairComplementRing (geometricIntegerRing F)
      (fun a => (x a : F)) i j := a.property
  change (a : F) ∈ chartRing (Int.castRingHom F).range
    (fun z : {a : M // a ≠ i ∧ a ≠ j} => (x z : F)) at ha
  rw [TauCeti.Laurent.LaurentEvaluation.chart_eq_range] at ha
  obtain ⟨p, hp⟩ := ha
  exact ⟨p, Subtype.ext hp⟩

/-- Identify the formal complementary Laurent ring with its chart using algebraic independence. -/
def complementLaurentEquiv (x : M → Fˣ) (i j : M)
    (hAI : AlgebraicIndependent ℚ (fun a => (x a : F))) :
    AddMonoidAlgebra ℤ ({a : M // a ≠ i ∧ a ≠ j} →₀ ℤ) ≃+*
      pairComplementRing (geometricIntegerRing F) (fun a => (x a : F)) i j :=
  RingEquiv.ofBijective (complementLaurentEvaluation x i j)
    ⟨complementLaurentEvaluation_injective x i j hAI,
      complementLaurentEvaluation_surjective x i j⟩

omit [DecidableEq M] [Fintype M] in
theorem complement_uniqueFactorizationMonoid [Finite M] (x : M → Fˣ) (i j : M)
    (hAI : AlgebraicIndependent ℚ (fun a => (x a : F))) :
    UniqueFactorizationMonoid
      (pairComplementRing (geometricIntegerRing F) (fun a => (x a : F)) i j) := by
  classical
  let : Fintype M := Fintype.ofFinite M
  let : UniqueFactorizationMonoid
      (AddMonoidAlgebra ℤ ({a : M // a ≠ i ∧ a ≠ j} →₀ ℤ)) :=
    latticeRing_uniqueFactorizationMonoid ℤ _
  exact (complementLaurentEquiv x i j hAI).toMulEquiv.uniqueFactorizationMonoid
    inferInstance

omit [Algebra ℚ F] [DecidableEq K] [Fintype K] in
theorem complementLaurentEval_positive (row : K ↪ M) (B : Matrix M K ℤ)
    (x : M → Fˣ) (i j k : K) :
    TauCeti.Laurent.LaurentEvaluation.eval (Int.castRingHom F)
      (complementLaurentUnits x (row i) (row j))
      (AddMonoidAlgebra.single (pairPositiveExponent row B i j k) 1) =
    ((pairCoefficient (geometricIntegerRing F) x (row i) (row j)
      (fun a => B a k) 1 :
      pairComplementRing (geometricIntegerRing F) (fun a => (x a : F))
        (row i) (row j)) : F) := by
  rw [TauCeti.Laurent.LaurentEvaluation.eval_single_product]
  simp only [map_one, one_mul, pairCoefficient_val, one_mul]
  change (pairPositiveExponent row B i j k).prod
    (fun a n => ((complementLaurentUnits x (row i) (row j) a ^ n : Fˣ) : F)) = _
  rw [Finsupp.prod_fintype _ _ (fun _ => by simp)]
  apply Finset.prod_congr rfl
  intro a ha
  simp [complementLaurentUnits, pairPositiveExponent_apply]

omit [Algebra ℚ F] [DecidableEq K] [Fintype K] in
theorem complementLaurentEval_negative (row : K ↪ M) (B : Matrix M K ℤ)
    (x : M → Fˣ) (i j k : K) :
    TauCeti.Laurent.LaurentEvaluation.eval (Int.castRingHom F)
      (complementLaurentUnits x (row i) (row j))
      (AddMonoidAlgebra.single (pairNegativeExponent row B i j k) 1) =
    ((pairCoefficient (geometricIntegerRing F) x (row i) (row j)
      (fun a => B a k) (-1) :
      pairComplementRing (geometricIntegerRing F) (fun a => (x a : F))
        (row i) (row j)) : F) := by
  rw [TauCeti.Laurent.LaurentEvaluation.eval_single_product]
  simp only [map_one, one_mul, pairCoefficient_val, neg_one_mul]
  change (pairNegativeExponent row B i j k).prod
    (fun a n => ((complementLaurentUnits x (row i) (row j) a ^ n : Fˣ) : F)) = _
  rw [Finsupp.prod_fintype _ _ (fun _ => by simp)]
  apply Finset.prod_congr rfl
  intro a ha
  simp [complementLaurentUnits, pairNegativeExponent_apply]

omit [DecidableEq K] [DecidableEq M] [Fintype K] in
theorem pairExchangeLaurent_eval [Finite K] (row : K ↪ M) (B : Matrix M K ℤ)
    (x : M → Fˣ) {i j : K} (hij : i ≠ j) (k : K)
    (hi : B (row i) k = 0) (hj : B (row j) k = 0) :
    TauCeti.Laurent.LaurentEvaluation.eval (Int.castRingHom F)
      (complementLaurentUnits x (row i) (row j))
      (pairExchangeLaurent row B i j k) =
    MvPolynomial.aeval (fun a => (x a : F)) (geometricExchangePolynomial B k) := by
  classical
  let : Fintype K := Fintype.ofFinite K
  have hp := signedMonomial_pair_split (geometricIntegerRing F) x
    (row i) (row j) (row.injective.ne hij) (fun a => B a k) hi 1
  have hn := signedMonomial_pair_split (geometricIntegerRing F) x
    (row i) (row j) (row.injective.ne hij) (fun a => B a k) hi (-1)
  simp only [hj, mul_zero, positivePart, max_self, zpow_zero, mul_one] at hp hn
  rw [pairExchangeLaurent, map_add,
    complementLaurentEval_positive, complementLaurentEval_negative,
    aeval_geometricExchangePolynomial]
  simpa only [positivePart, one_mul, neg_one_mul] using
    congrArg₂ (· + ·) hp.symm hn.symm

/-- Evaluate the exchange binomial after removing the two selected rows, as an element of the
complementary chart.
-/
def pairExchangeFactor (row : K ↪ M) (B : Matrix M K ℤ)
    (x : M → Fˣ) (i j k : K) :
    pairComplementRing (geometricIntegerRing F) (fun a => (x a : F))
      (row i) (row j) :=
  complementLaurentEvaluation x (row i) (row j)
    (pairExchangeLaurent row B i j k)

omit [DecidableEq K] [DecidableEq M] [Fintype K] in
theorem pairExchangeFactor_val [Finite K] (row : K ↪ M) (B : Matrix M K ℤ)
    (x : M → Fˣ) {i j : K} (hij : i ≠ j) (k : K)
    (hi : B (row i) k = 0) (hj : B (row j) k = 0) :
    (pairExchangeFactor row B x i j k : F) =
      MvPolynomial.aeval (fun a => (x a : F)) (geometricExchangePolynomial B k) := by
  classical
  let : Fintype K := Fintype.ofFinite K
  exact pairExchangeLaurent_eval row B x hij k hi hj

omit [DecidableEq K] [DecidableEq M] in
theorem pairExchangeFactors_isRelPrime (row : K ↪ M) (B : Matrix M K ℤ)
    (x : M → Fˣ) (hAI : AlgebraicIndependent ℚ (fun a => (x a : F)))
    (hrank : (B.map (Int.castRingHom ℚ)).rank = Fintype.card K)
    {i j : K} (hij : i ≠ j)
    (hii : B (row i) i = 0) (hij0 : B (row i) j = 0)
    (hji0 : B (row j) i = 0) (hjj : B (row j) j = 0) :
    IsRelPrime (pairExchangeFactor row B x i j i)
      (pairExchangeFactor row B x i j j) := by
  classical
  let e := complementLaurentEquiv x (row i) (row j) hAI
  have h := pairExchangeLaurent_isRelPrime row B hrank hij hii hij0 hji0 hjj
  have he : IsRelPrime
      (e (pairExchangeLaurent row B i j i))
      (e (pairExchangeLaurent row B i j j)) := by
    apply IsRelPrime.of_map e.symm
    simpa using h
  exact he

theorem geometricIntegerRing_mem_rational (a : F)
    (ha : a ∈ geometricIntegerRing F) : a ∈ (algebraMap ℚ F).range := by
  obtain ⟨n, rfl⟩ := ha
  exact ⟨n, by simp⟩

omit [Fintype K] [Fintype M] in
theorem extendedMatrixMutation_commuting_column (row : K ↪ M)
    (B : Matrix M K ℤ) {i j : K} (hij : i ≠ j)
    (hzero : B (row i) j = 0) (a : M) :
    extendedMatrixMutation row B i a j = B a j := by
  by_cases ha : a = row i
  · subst a
    simp [extendedMatrixMutation, hzero]
  · simp [extendedMatrixMutation, ha, Ne.symm hij, hzero, positivePart]

omit [Fintype K] in
theorem geometricExchangePolynomial_commuting_column [Finite K] (row : K ↪ M)
    (B : Matrix M K ℤ) {i j : K} (hij : i ≠ j)
    (hzero : B (row i) j = 0) :
    geometricExchangePolynomial (extendedMatrixMutation row B i) j =
      geometricExchangePolynomial B j := by
  let : Fintype K := Fintype.ofFinite K
  have hp : geometricPositiveDegree (extendedMatrixMutation row B i) j =
      geometricPositiveDegree B j := by
    ext a
    simp [geometricPositiveDegree_apply,
      extendedMatrixMutation_commuting_column row B hij hzero]
  have hn : geometricPositiveDegree (-(extendedMatrixMutation row B i)) j =
      geometricPositiveDegree (-B) j := by
    ext a
    simp [geometricPositiveDegree_apply,
      extendedMatrixMutation_commuting_column row B hij hzero]
  simp [geometricExchangePolynomial, hp, hn]

omit [Fintype K] in
theorem geometric_commuting_exchange_eval [Finite K] (row : K ↪ M) (d : K → ℤ)
    (hd : ∀ k, 0 < d k) (s : GeometricSeed (F := F) row d)
    {i j : K} (hij : i ≠ j) (hzero : s.exchange (row i) j = 0) :
    MvPolynomial.aeval (s.mutate hd i).coordinate
      (geometricExchangePolynomial (s.mutate hd i).exchange j) =
    MvPolynomial.aeval s.coordinate (geometricExchangePolynomial s.exchange j) := by
  let : Fintype K := Fintype.ofFinite K
  rw [show (s.mutate hd i).exchange =
      extendedMatrixMutation row s.exchange i from rfl,
    geometricExchangePolynomial_commuting_column row s.exchange hij hzero]
  apply MvPolynomial.eval₂Hom_congr' rfl ?_ rfl
  intro a ha _
  have hne : a ≠ row i := by
    intro he
    subst a
    exact (geometricExchangePolynomial_omits s.exchange j (row i) hzero) ha
  simp [GeometricSeed.mutate, geometricMutationCoordinates, Function.update_of_ne hne]

theorem geometric_commuting_three_pairCharts (row : K ↪ M) (d : K → ℤ)
    (hd : ∀ k, 0 < d k)
    (s : FullRankGeometricSeed (F := F) row d)
    {i j : K} (hij : i ≠ j)
    (hcomm : s.1.exchange (row j) i = 0) :
    let C := geometricIntegerRing F
    let D := pairComplementRing C s.1.coordinate (row i) (row j)
    let xi := s.1.units (row i)
    let yj := s.1.units (row j)
    let xs := (s.1.mutate hd i).units (row i)
    let H := pairExchangeFactor row s.1.exchange s.1.units i j j
    pairChart D xi yj ⊓ pairChart D xs yj ⊓ pairChart D xi ((H : F) / yj) =
      pairChart D xs yj ⊓ pairChart D xi yj ⊓ pairChart D xs ((H : F) / yj) := by
  let C := geometricIntegerRing F
  let x := s.1.units
  let D := pairComplementRing C s.1.coordinate (row i) (row j)
  let xi := x (row i)
  let yj := x (row j)
  let xs := (s.1.mutate hd i).units (row i)
  let E := pairExchangeFactor row s.1.exchange x i j i
  let H := pairExchangeFactor row s.1.exchange x i j j
  have hii := s.1.diagonal hd i
  have hjj := s.1.diagonal hd j
  have hij0 : s.1.exchange (row i) j = 0 := by
    have hs := s.1.symmetrized i j
    rw [hcomm, mul_zero, neg_zero] at hs
    exact (mul_eq_zero.mp hs).resolve_left (ne_of_gt (hd i))
  have hAIx : AlgebraicIndependent ℚ (fun a => (x a : F)) := by
    simpa only [x, GeometricSeed.units_val] using s.1.independent
  let : UniqueFactorizationMonoid D :=
    complement_uniqueFactorizationMonoid x (row i) (row j) hAIx
  have hrel : IsRelPrime E H :=
    pairExchangeFactors_isRelPrime row s.1.exchange x hAIx s.2 hij
      hii hij0 hcomm hjj
  have hE : (E : F) = MvPolynomial.aeval s.1.coordinate
      (geometricExchangePolynomial s.1.exchange i) := by
    simpa only [E, x, GeometricSeed.units_val] using
      pairExchangeFactor_val row s.1.exchange x hij i hii hcomm
  have hH : (H : F) = MvPolynomial.aeval s.1.coordinate
      (geometricExchangePolynomial s.1.exchange j) := by
    simpa only [H, x, GeometricSeed.units_val] using
      pairExchangeFactor_val row s.1.exchange x hij j hij0 hjj
  have hex : (xi : F) * xs = E := by
    rw [hE]
    simp only [xi, xs, x, GeometricSeed.units_val,
      GeometricSeed.mutate, geometricMutationCoordinates, Function.update_self]
    field_simp [nonzero_coordinate_of_algebraicIndependent s.1.coordinate
      s.1.independent (row i)]
  have hHnz : (H : F) ≠ 0 := by
    rw [hH]
    exact (algebraicIndependent_iff_injective_aeval.mp s.1.independent).ne
      (geometricExchangePolynomial_ne_zero s.1.exchange j)
  have hAI : let : Algebra (FractionRing D) F :=
      (fractionCoefficients D).toAlgebra
      AlgebraicIndependent (FractionRing D)
        (pairCoordinates (xi : F) (yj : F)) := by
    have hh := pair_independent_over_complement_field (K := ℚ) C s.1.coordinate
      (row i) (row j) (row.injective.ne hij)
      (fun a ha => geometricIntegerRing_mem_rational a ha) s.1.independent
    change (let : Algebra (FractionRing D) F := (fractionCoefficients D).toAlgebra
      AlgebraicIndependent (FractionRing D)
        (pairCoordinates (s.1.coordinate (row i)) (s.1.coordinate (row j))))
    exact hh
  have hAIxs : let : Algebra (FractionRing D) F :=
      (fractionCoefficients D).toAlgebra
      AlgebraicIndependent (FractionRing D)
        (pairCoordinates (xs : F) (yj : F)) := by
    let t := s.1.mutate hd i
    have ht := pair_independent_over_complement_field (K := ℚ) C t.coordinate
      (row i) (row j) (row.injective.ne hij)
      (fun a ha => geometricIntegerRing_mem_rational a ha) t.independent
    have hD : pairComplementRing C t.coordinate (row i) (row j) = D := by
      simpa only [t, GeometricSeed.mutate, geometricMutationCoordinates, D] using
        pairComplementRing_update_left C s.1.coordinate (row i) (row j)
          (MvPolynomial.aeval s.1.coordinate
            (geometricExchangePolynomial s.1.exchange i) / s.1.coordinate (row i))
    change (let D' := pairComplementRing C t.coordinate (row i) (row j)
      let : Algebra (FractionRing D') F := (fractionCoefficients D').toAlgebra
      AlgebraicIndependent (FractionRing D')
        (pairCoordinates (t.coordinate (row i)) (t.coordinate (row j)))) at ht
    dsimp only at ht
    rw [hD] at ht
    have hy : t.coordinate (row j) = s.1.coordinate (row j) := by
      simp [t, GeometricSeed.mutate, geometricMutationCoordinates,
        Function.update_of_ne (row.injective.ne hij).symm]
    change (let : Algebra (FractionRing D) F := (fractionCoefficients D).toAlgebra
      AlgebraicIndependent (FractionRing D)
        (pairCoordinates (t.coordinate (row i)) (s.1.coordinate (row j))))
    simpa only [hy] using ht
  change pairChart D xi yj ⊓ pairChart D xs yj ⊓ pairChart D xi ((H : F) / yj) =
    pairChart D xs yj ⊓ pairChart D xi yj ⊓ pairChart D xs ((H : F) / yj)
  exact commuting_three_pairCharts_of_independent D xi xs yj E H hrel hex hHnz hAI hAIxs

/-! ### Coefficients inside a field over which the coordinates are independent

For `R_J` take `C = ℤ` and `𝕜 = ℚ`; for `𝕜_J` take `C` the image of `𝕜`. All frozen coordinates
are inverted in the charts `chartRing C x`. -/

section Coefficients

variable {𝕜 : Type*} [Field 𝕜] [Algebra 𝕜 F]

variable (𝕜) in
/-- A field is isomorphic to its image. -/
noncomputable def algebraMapRangeEquiv : 𝕜 ≃+* (algebraMap 𝕜 F).range :=
  RingEquiv.ofBijective (algebraMap 𝕜 F).rangeRestrict
    ⟨fun _ _ h ↦ (algebraMap 𝕜 F).injective (congrArg Subtype.val h),
      (algebraMap 𝕜 F).rangeRestrict_surjective⟩

omit [Algebra ℚ F] in
/-- The coefficient ring of `𝕜_J` is factorial. -/
theorem algebraMap_range_uniqueFactorizationMonoid :
    UniqueFactorizationMonoid (algebraMap 𝕜 F).range :=
  (algebraMapRangeEquiv (F := F) 𝕜).toMulEquiv.uniqueFactorizationMonoid inferInstance

/-- The coefficient ring of `R_J` is factorial. -/
theorem geometricIntegerRing_uniqueFactorizationMonoid :
    UniqueFactorizationMonoid (geometricIntegerRing F) := by
  have : CharZero F := algebraRat.charZero F
  exact (RingEquiv.ofBijective (Int.castRingHom F).rangeRestrict
    ⟨fun _ _ h ↦ Int.cast_injective (congrArg Subtype.val h),
      (Int.castRingHom F).rangeRestrict_surjective⟩).toMulEquiv.uniqueFactorizationMonoid
    inferInstance

/-- A subring of `F` inside the image of `𝕜`, as a subring of `𝕜`. -/
noncomputable def coefficientEmbedding (C : Subring F)
    (hC : ∀ a ∈ C, a ∈ (algebraMap 𝕜 F).range) : C →+* 𝕜 :=
  (algebraMapRangeEquiv (F := F) 𝕜).symm.toRingHom.comp (Subring.inclusion hC)

omit [Algebra ℚ F] in
@[simp] theorem algebraMap_coefficientEmbedding (C : Subring F)
    (hC : ∀ a ∈ C, a ∈ (algebraMap 𝕜 F).range) (a : C) :
    algebraMap 𝕜 F (coefficientEmbedding C hC a) = a :=
  congrArg Subtype.val ((algebraMapRangeEquiv (F := F) 𝕜).apply_symm_apply (Subring.inclusion hC a))

omit [Algebra ℚ F] in
theorem coefficientEmbedding_injective (C : Subring F)
    (hC : ∀ a ∈ C, a ∈ (algebraMap 𝕜 F).range) :
    Function.Injective (coefficientEmbedding C hC) := by
  intro a b h
  apply Subtype.ext
  rw [← algebraMap_coefficientEmbedding C hC a, ← algebraMap_coefficientEmbedding C hC b, h]

/-- Laurent evaluation of the coordinates other than `i, j`, with coefficients in `C`. -/
noncomputable def complementLaurentEvaluationOf (C : Subring F) (x : M → Fˣ) (i j : M) :
    AddMonoidAlgebra C ({a : M // a ≠ i ∧ a ≠ j} →₀ ℤ) →+*
      pairComplementRing C (fun a => (x a : F)) i j :=
  (TauCeti.Laurent.LaurentEvaluation.eval C.subtype (complementLaurentUnits x i j)).codRestrict _
    fun p ↦ by
      have h := TauCeti.Laurent.LaurentEvaluation.eval_mem_chart C.subtype
        (complementLaurentUnits x i j) p
      rw [Subring.range_subtype] at h
      exact h

omit [Algebra ℚ F] in
theorem complementLaurentEvaluationOf_single (C : Subring F) (x : M → Fˣ) (i j : M)
    (p : {a : M // a ≠ i ∧ a ≠ j} →₀ ℤ) :
    (complementLaurentEvaluationOf C x i j (AddMonoidAlgebra.single p 1) : F) =
      ∏ a : {a : M // a ≠ i ∧ a ≠ j}, (x a : F) ^ p a := by
  change TauCeti.Laurent.LaurentEvaluation.eval C.subtype (complementLaurentUnits x i j)
    (AddMonoidAlgebra.single p 1) = _
  rw [TauCeti.Laurent.LaurentEvaluation.eval_single_product]
  simp only [map_one, one_mul]
  change p.prod (fun a n => ((complementLaurentUnits x i j a ^ n : Fˣ) : F)) = _
  rw [Finsupp.prod_fintype _ _ (fun _ => by simp)]
  simp [complementLaurentUnits]

omit [DecidableEq M] [Fintype M] in
omit [Algebra ℚ F] in
theorem complementLaurentEvaluationOf_injective [Finite M] (C : Subring F)
    (hC : ∀ a ∈ C, a ∈ (algebraMap 𝕜 F).range) (x : M → Fˣ) (i j : M)
    (hAI : AlgebraicIndependent 𝕜 (fun a => (x a : F))) :
    Function.Injective (complementLaurentEvaluationOf C x i j) := by
  let : Fintype M := Fintype.ofFinite M
  let u := complementLaurentUnits x i j
  have heq : TauCeti.Laurent.LaurentEvaluation.eval C.subtype u =
      (TauCeti.Laurent.LaurentEvaluation.eval (algebraMap 𝕜 F) u).comp
        (AddMonoidAlgebra.mapRingHom _ (coefficientEmbedding C hC)) := by
    apply AddMonoidAlgebra.ringHom_ext
    · intro a
      simp
    · intro m
      simp [TauCeti.Laurent.LaurentEvaluation.eval_single]
  have hu : Function.Injective (TauCeti.Laurent.LaurentEvaluation.eval (algebraMap 𝕜 F) u) := by
    apply laurent_eval_injective_of_algebraicIndependent
    · intro c
      exact TauCeti.Laurent.LaurentEvaluation.eval_constant _ _ c
    · convert hAI.comp Subtype.val Subtype.val_injective using 1
      funext a
      simp [u, complementLaurentUnits]
  have hm : Function.Injective
      (AddMonoidAlgebra.mapRingHom ({a : M // a ≠ i ∧ a ≠ j} →₀ ℤ)
        (coefficientEmbedding C hC)) := by
    intro p q h
    apply AddMonoidAlgebra.coeff_injective
    ext a
    have ha := congrArg (fun z : AddMonoidAlgebra 𝕜 ({a : M // a ≠ i ∧ a ≠ j} →₀ ℤ) =>
      z.coeff a) h
    simp only [AddMonoidAlgebra.coeff_mapRingHom] at ha
    exact congrArg Subtype.val (coefficientEmbedding_injective C hC ha)
  intro p q hpq
  have h := congrArg Subtype.val hpq
  change TauCeti.Laurent.LaurentEvaluation.eval C.subtype u p =
    TauCeti.Laurent.LaurentEvaluation.eval C.subtype u q at h
  rw [heq] at h
  exact hm (hu h)

omit [Algebra ℚ F] [DecidableEq M] [Fintype M] in
theorem complementLaurentEvaluationOf_surjective (C : Subring F) (x : M → Fˣ) (i j : M) :
    Function.Surjective (complementLaurentEvaluationOf C x i j) := by
  intro a
  have ha : (a : F) ∈ chartRing C.subtype.range
      (fun z : {a : M // a ≠ i ∧ a ≠ j} => (complementLaurentUnits x i j z : F)) := by
    rw [Subring.range_subtype]
    exact a.property
  rw [TauCeti.Laurent.LaurentEvaluation.chart_eq_range] at ha
  obtain ⟨p, hp⟩ := ha
  exact ⟨p, Subtype.ext hp⟩

/-- The Laurent ring `D` of the coordinates other than `i, j` over `C` is the Laurent polynomial
ring over `C` in those coordinates. -/
noncomputable def complementLaurentEquivOf (C : Subring F)
    (hC : ∀ a ∈ C, a ∈ (algebraMap 𝕜 F).range) (x : M → Fˣ) (i j : M)
    (hAI : AlgebraicIndependent 𝕜 (fun a => (x a : F))) :
    AddMonoidAlgebra C ({a : M // a ≠ i ∧ a ≠ j} →₀ ℤ) ≃+*
      pairComplementRing C (fun a => (x a : F)) i j :=
  RingEquiv.ofBijective (complementLaurentEvaluationOf C x i j)
    ⟨complementLaurentEvaluationOf_injective C hC x i j hAI,
      complementLaurentEvaluationOf_surjective C x i j⟩

omit [DecidableEq M] [Fintype M] in
omit [Algebra ℚ F] in
/-- The Laurent ring `D` of the coordinates other than `i, j` over a factorial `C` is
factorial. -/
theorem pairComplementRing_uniqueFactorizationMonoid [Finite M] (C : Subring F)
  [UniqueFactorizationMonoid C]
    (hC : ∀ a ∈ C, a ∈ (algebraMap 𝕜 F).range) (x : M → Fˣ) (i j : M)
    (hAI : AlgebraicIndependent 𝕜 (fun a => (x a : F))) :
    UniqueFactorizationMonoid (pairComplementRing C (fun a => (x a : F)) i j) := by
  classical
  let : Fintype M := Fintype.ofFinite M
  have := latticeRing_uniqueFactorizationMonoid C {a : M // a ≠ i ∧ a ≠ j}
  exact (complementLaurentEquivOf C hC x i j hAI).toMulEquiv.uniqueFactorizationMonoid
    inferInstance

end Coefficients

/-- The two-term exchange binomial of column `k` with the rows `i, j` removed, in the coefficient
ring `D` of the pair `i, j`; it is the exchange value `E_k` when column `k` vanishes in rows
`i, j` (`pairExchangeElement_val`). -/
noncomputable def pairExchangeElement (C : Subring F) (row : K ↪ M) (B : Matrix M K ℤ)
    (x : M → Fˣ) (i j k : K) : pairComplementRing C (fun a => (x a : F)) (row i) (row j) :=
  (pairCoefficient C x (row i) (row j) (fun a => B a k) 1 :
      pairComplementRing C (fun a => (x a : F)) (row i) (row j)) +
    (pairCoefficient C x (row i) (row j) (fun a => B a k) (-1) :
      pairComplementRing C (fun a => (x a : F)) (row i) (row j))

omit [DecidableEq K] [Fintype K] in
theorem pairExchangeElement_val (C : Subring F) (row : K ↪ M) (B : Matrix M K ℤ)
    (x : M → Fˣ) {i j : K} (hij : i ≠ j) (k : K)
    (hi : B (row i) k = 0) (hj : B (row j) k = 0) :
    (pairExchangeElement C row B x i j k : F) =
      MvPolynomial.aeval (fun a => (x a : F)) (geometricExchangePolynomial B k) := by
  have hp := signedMonomial_pair_split C x (row i) (row j) (row.injective.ne hij)
    (fun a => B a k) hi 1
  have hn := signedMonomial_pair_split C x (row i) (row j) (row.injective.ne hij)
    (fun a => B a k) hi (-1)
  simp only [hj, mul_zero, positivePart, max_self, zpow_zero, mul_one] at hp hn
  rw [aeval_geometricExchangePolynomial, pairExchangeElement, Subring.coe_add]
  simpa only [positivePart, one_mul, neg_one_mul] using congrArg₂ (· + ·) hp.symm hn.symm

omit [DecidableEq K] in
omit [Algebra ℚ F] in
/-- **Full rank implies relative primality (U4).** If the columns of `B` have full rank and
columns `i, j` vanish in rows `i, j`, then `E_i` and `E_j` are relatively prime in `D`. -/
theorem pairExchangeElement_isRelPrime {𝕜 : Type*} [Field 𝕜] [Algebra 𝕜 F] (C : Subring F)
    (hC : ∀ a ∈ C, a ∈ (algebraMap 𝕜 F).range) (row : K ↪ M) (B : Matrix M K ℤ)
    (x : M → Fˣ) (hAI : AlgebraicIndependent 𝕜 (fun a => (x a : F)))
    (hrank : (B.map (Int.castRingHom ℚ)).rank = Fintype.card K)
    {i j : K} (hij : i ≠ j)
    (hii : B (row i) i = 0) (hij0 : B (row i) j = 0)
    (hji0 : B (row j) i = 0) (hjj : B (row j) j = 0) :
    IsRelPrime (pairExchangeElement C row B x i j i) (pairExchangeElement C row B x i j j) := by
  obtain ⟨r, t, hminor⟩ :=
    exists_integer_two_minor_away_of_full_column_rank row B hrank hij hii hij0 hji0 hjj
  let e := complementLaurentEquivOf C hC x (row i) (row j) hAI
  have hval (k : K) :
      e (AddMonoidAlgebra.single (pairPositiveExponent row B i j k) (1 : C) +
          AddMonoidAlgebra.single (pairNegativeExponent row B i j k) 1) =
        pairExchangeElement C row B x i j k := by
    apply Subtype.ext
    change ((complementLaurentEvaluationOf C x (row i) (row j)
      (AddMonoidAlgebra.single (pairPositiveExponent row B i j k) (1 : C) +
        AddMonoidAlgebra.single (pairNegativeExponent row B i j k) 1) : _) : F) = _
    rw [map_add, Subring.coe_add, complementLaurentEvaluationOf_single,
      complementLaurentEvaluationOf_single]
    simp only [pairExchangeElement, Subring.coe_add, pairCoefficient_val,
      pairPositiveExponent_apply, pairNegativeExponent_apply, one_mul, neg_one_mul]
  have h : IsRelPrime
      (AddMonoidAlgebra.single (pairPositiveExponent row B i j i) (1 : C) +
        AddMonoidAlgebra.single (pairNegativeExponent row B i j i) 1)
      (AddMonoidAlgebra.single (pairPositiveExponent row B i j j) (1 : C) +
        AddMonoidAlgebra.single (pairNegativeExponent row B i j j) 1) := by
    apply isRelPrime_monomial_add_monomial_of_minor (r := r) (s := t)
    rw [pairExponentDifference_apply, pairExponentDifference_apply,
      pairExponentDifference_apply, pairExponentDifference_apply]
    exact hminor
  rw [← hval i, ← hval j]
  apply IsRelPrime.of_map e.symm
  simpa using h

omit [Fintype K] in
/-- **Three-chart equality, commuting case.** Let the coefficients `C` be a factorial subring of a
field `𝕜 ⊆ F` over which the coordinates of `s` are algebraically independent (`C = ℤ`, `𝕜 = ℚ`
for `R_J`; `C = 𝕜` for `𝕜_J`). If `b_ji = 0` and `E_i`, `E_j` are relatively prime in the Laurent
ring `D` of the other coordinates, the three-chart equality holds. -/
theorem geometric_commuting_three_charts_of_isRelPrime [Finite K] {𝕜 : Type*} [Field 𝕜] [Algebra
  𝕜 F]
    (C : Subring F) [UniqueFactorizationMonoid C] (hC : ∀ a ∈ C, a ∈ (algebraMap 𝕜 F).range)
    (row : K ↪ M) (d : K → ℤ) (hd : ∀ k, 0 < d k)
    (s : GeometricSeed (F := F) row d) (hAI : AlgebraicIndependent 𝕜 s.coordinate)
    {i j : K} (hij : i ≠ j) (hcomm : s.exchange (row j) i = 0)
    (hrel : IsRelPrime (pairExchangeElement C row s.exchange s.units i j i)
      (pairExchangeElement C row s.exchange s.units i j j)) :
    chartRing C s.coordinate ⊓ chartRing C (s.mutate hd i).coordinate ⊓
      chartRing C (s.mutate hd j).coordinate =
    chartRing C (s.mutate hd i).coordinate ⊓ chartRing C s.coordinate ⊓
      chartRing C ((s.mutate hd i).mutate hd j).coordinate := by
  let : Fintype K := Fintype.ofFinite K
  let x := s.units
  let D := pairComplementRing C s.coordinate (row i) (row j)
  let xi := x (row i)
  let yj := x (row j)
  let t := s.mutate hd i
  let xs := t.units (row i)
  let E := pairExchangeElement C row s.exchange x i j i
  let H := pairExchangeElement C row s.exchange x i j j
  have hri : row i ≠ row j := row.injective.ne hij
  have hij0 : s.exchange (row i) j = 0 := s.exchange_eq_zero_of_eq_zero hd hcomm
  have : UniqueFactorizationMonoid D :=
    pairComplementRing_uniqueFactorizationMonoid C hC x (row i) (row j) hAI
  have hE : (E : F) = MvPolynomial.aeval s.coordinate
      (geometricExchangePolynomial s.exchange i) := by
    simpa only [E, x, GeometricSeed.units_val] using
      pairExchangeElement_val C row s.exchange x hij i (s.diagonal hd i) hcomm
  have hH : (H : F) = MvPolynomial.aeval s.coordinate
      (geometricExchangePolynomial s.exchange j) := by
    simpa only [H, x, GeometricSeed.units_val] using
      pairExchangeElement_val C row s.exchange x hij j hij0 (s.diagonal hd j)
  have hex : (xi : F) * xs = E := by
    rw [hE]
    simp only [xi, xs, x, t, GeometricSeed.units_val,
      GeometricSeed.mutate, geometricMutationCoordinates, Function.update_self]
    field_simp [nonzero_coordinate_of_algebraicIndependent s.coordinate
      s.independent (row i)]
  have hHnz : (H : F) ≠ 0 := by
    rw [hH]
    exact (algebraicIndependent_iff_injective_aeval.mp s.independent).ne
      (geometricExchangePolynomial_ne_zero s.exchange j)
  have hD : pairComplementRing C t.coordinate (row i) (row j) = D := by
    simpa only [t, GeometricSeed.mutate, geometricMutationCoordinates, D] using
      pairComplementRing_update_left C s.coordinate (row i) (row j)
        (MvPolynomial.aeval s.coordinate
          (geometricExchangePolynomial s.exchange i) / s.coordinate (row i))
  have hy : t.coordinate (row j) = s.coordinate (row j) := by
    simp [t, GeometricSeed.mutate, geometricMutationCoordinates,
      Function.update_of_ne hri.symm]
  have hAI₁ : let : Algebra (FractionRing D) F := (fractionCoefficients D).toAlgebra
      AlgebraicIndependent (FractionRing D) (pairCoordinates (xi : F) (yj : F)) :=
    pair_independent_over_complement_field (K := 𝕜) C s.coordinate (row i) (row j) hri hC hAI
  have hAI₂ : let : Algebra (FractionRing D) F := (fractionCoefficients D).toAlgebra
      AlgebraicIndependent (FractionRing D) (pairCoordinates (xs : F) (yj : F)) := by
    have ht := pair_independent_over_complement_field (K := 𝕜) C t.coordinate
      (row i) (row j) hri hC (s.algebraicIndependent_mutate hd hAI i)
    change (let D' := pairComplementRing C t.coordinate (row i) (row j)
      let : Algebra (FractionRing D') F := (fractionCoefficients D').toAlgebra
      AlgebraicIndependent (FractionRing D')
        (pairCoordinates (t.coordinate (row i)) (t.coordinate (row j)))) at ht
    dsimp only at ht
    rw [hD] at ht
    change (let : Algebra (FractionRing D) F := (fractionCoefficients D).toAlgebra
      AlgebraicIndependent (FractionRing D)
        (pairCoordinates (t.coordinate (row i)) (s.coordinate (row j))))
    simpa only [hy] using ht
  have hpair : pairChart D xi yj ⊓ pairChart D xs yj ⊓ pairChart D xi ((H : F) / yj) =
      pairChart D xs yj ⊓ pairChart D xi yj ⊓ pairChart D xs ((H : F) / yj) :=
    commuting_three_pairCharts_of_independent D xi xs yj E H hrel hex hHnz hAI₁ hAI₂
  have h0 : chartRing C s.coordinate = pairChart D xi yj := by
    simpa only [D, xi, yj, x, GeometricSeed.units_val] using
      chartRing_pair_regroup C s.coordinate (row i) (row j)
  have hi : chartRing C t.coordinate = pairChart D xs yj := by
    simpa only [t, x, GeometricSeed.mutate, geometricMutationCoordinates,
      xs, yj, GeometricSeed.units_val, Function.update_self, D] using
      chartRing_pair_update_left C s.coordinate (row i) (row j) hri
        (MvPolynomial.aeval s.coordinate
          (geometricExchangePolynomial s.exchange i) / s.coordinate (row i))
  have hj : chartRing C (s.mutate hd j).coordinate = pairChart D xi ((H : F) / yj) := by
    rw [hH]
    simpa only [GeometricSeed.mutate, geometricMutationCoordinates,
      xi, yj, x, GeometricSeed.units_val, D] using
      chartRing_pair_update_right C s.coordinate (row i) (row j) hri
        (MvPolynomial.aeval s.coordinate
          (geometricExchangePolynomial s.exchange j) / s.coordinate (row j))
  have hvij : MvPolynomial.aeval t.coordinate
      (geometricExchangePolynomial t.exchange j) / t.coordinate (row j) = (H : F) / yj := by
    rw [geometric_commuting_exchange_eval row d hd s hij hij0, ← hH, hy]
    rfl
  have hijmut : chartRing C (t.mutate hd j).coordinate = pairChart D xs ((H : F) / yj) := by
    rw [← hvij]
    simpa only [t, x, GeometricSeed.mutate, geometricMutationCoordinates,
      xs, GeometricSeed.units_val, Function.update_self, D] using
      chartRing_pair_update_both C s.coordinate (row i) (row j) hri
        (MvPolynomial.aeval s.coordinate
          (geometricExchangePolynomial s.exchange i) / s.coordinate (row i))
        (MvPolynomial.aeval t.coordinate
          (geometricExchangePolynomial t.exchange j) / t.coordinate (row j))
  change chartRing C s.coordinate ⊓ chartRing C t.coordinate ⊓
      chartRing C (s.mutate hd j).coordinate =
    chartRing C t.coordinate ⊓ chartRing C s.coordinate ⊓
      chartRing C (t.mutate hd j).coordinate
  rw [h0, hi, hj, hijmut]
  exact hpair

/-- The commuting three-chart equality when the extended matrix has full column rank, which
makes `E_i`, `E_j` relatively prime in `D` (`pairExchangeElement_isRelPrime`). -/
theorem geometric_commuting_three_charts_of_rank {𝕜 : Type*} [Field 𝕜] [Algebra 𝕜 F]
    (C : Subring F) [UniqueFactorizationMonoid C] (hC : ∀ a ∈ C, a ∈ (algebraMap 𝕜 F).range)
    (row : K ↪ M) (d : K → ℤ) (hd : ∀ k, 0 < d k)
    (s : GeometricSeed (F := F) row d) (hAI : AlgebraicIndependent 𝕜 s.coordinate)
    (hrank : (s.exchange.map (Int.castRingHom ℚ)).rank = Fintype.card K)
    {i j : K} (hij : i ≠ j) (hcomm : s.exchange (row j) i = 0) :
    chartRing C s.coordinate ⊓ chartRing C (s.mutate hd i).coordinate ⊓
      chartRing C (s.mutate hd j).coordinate =
    chartRing C (s.mutate hd i).coordinate ⊓ chartRing C s.coordinate ⊓
      chartRing C ((s.mutate hd i).mutate hd j).coordinate :=
  geometric_commuting_three_charts_of_isRelPrime C hC row d hd s hAI hij hcomm
    (pairExchangeElement_isRelPrime C hC row s.exchange s.units hAI hrank hij
      (s.diagonal hd i) (s.exchange_eq_zero_of_eq_zero hd hcomm) hcomm (s.diagonal hd j))

theorem geometric_commuting_three_charts (row : K ↪ M) (d : K → ℤ)
    (hd : ∀ k, 0 < d k)
    (s : FullRankGeometricSeed (F := F) row d)
    {i j : K} (hij : i ≠ j)
    (hcomm : s.1.exchange (row j) i = 0) :
    let C := geometricIntegerRing F
    chartRing C s.1.coordinate ⊓ chartRing C (s.1.mutate hd i).coordinate ⊓
      chartRing C (s.1.mutate hd j).coordinate =
    chartRing C (s.1.mutate hd i).coordinate ⊓ chartRing C s.1.coordinate ⊓
      chartRing C ((s.1.mutate hd i).mutate hd j).coordinate :=
  let := geometricIntegerRing_uniqueFactorizationMonoid (F := F)
  geometric_commuting_three_charts_of_rank (geometricIntegerRing F)
    geometricIntegerRing_mem_rational row d hd s.1 s.1.independent s.2 hij hcomm

end TauCeti.Cluster.UpperBound
