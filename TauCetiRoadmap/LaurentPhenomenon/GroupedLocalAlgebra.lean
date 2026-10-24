/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.PositiveLocalModel
public import TauCetiRoadmap.LaurentPhenomenon.GenericChart
public import TauCetiRoadmap.LaurentPhenomenon.FreshParameter

/-! # Grouped Local Algebra -/

@[expose] public section

namespace TauCeti.Laurent
noncomputable section
open Polynomial
open scoped LaurentPolynomial
variable {G I : Type*} [AddCommGroup G] [DecidableEq I]

/-- Evaluate one mutable variable at one and regard the result as a Laurent polynomial in the
remaining variables.
-/
def eraseMutable (i : I) : TotalLaurentRing G I →+* MutableCoefficientRing G I i :=
  (LaurentPolynomial.eval₂ (RingHom.id _) (1 : (MutableCoefficientRing G I i)ˣ)).comp
    (laurentSplit i).toRingHom

/-- Include the complementary coefficient ring by assigning zero exponent to the omitted mutable
variable.
-/
def embedMutableCoefficient (j : I) : MutableCoefficientRing G I j →+* TotalLaurentRing G I :=
  (laurentSplit j).symm.toRingHom.comp LaurentPolynomial.C

theorem eraseMutable_constant (i : I) (c : MutableCoefficientRing G I i) :
    eraseMutable i (embedMutableCoefficient i c) = c := by
  simp [eraseMutable, embedMutableCoefficient, ← Polynomial.toLaurent_C]

theorem embedMutableCoefficient_single (j : I) (g : G) (m : I →₀ ℤ) (n : ℤ) :
    embedMutableCoefficient j (AddMonoidAlgebra.single (g, (splitExponents j m).2) n) =
      AddMonoidAlgebra.single (g, m - Finsupp.single j (m j)) n := by
  apply (laurentSplit j).injective
  have he : (splitExponents j (m - Finsupp.single j (m j))).2 = (splitExponents j m).2 := by
    ext k
    simp [splitExponents_snd_apply]
  change (laurentSplit j) ((laurentSplit j).symm
    (LaurentPolynomial.C (AddMonoidAlgebra.single (g, (splitExponents j m).2) n))) = _
  simp only [RingEquiv.apply_symm_apply, laurentSplit_single, Finsupp.sub_apply,
    Finsupp.single_eq_same,
    sub_self, he]
  rfl

theorem eraseMutable_single (i : I) (g : G) (m : I →₀ ℤ) (n : ℤ) :
    eraseMutable i (AddMonoidAlgebra.single (g, m) n) =
      AddMonoidAlgebra.single (g, (splitExponents i m).2) n := by
  simp [eraseMutable, laurentSplit_single, LaurentPolynomial.single_eq_C_mul_T,
    ← Polynomial.toLaurent_C]

/-- Group a positive Laurent polynomial by j, then erase i in the coefficient variables. -/
def regroupedPolynomial (E : PositiveLaurent G I) (i j : I) :
    Polynomial (MutableCoefficientRing G I i) :=
  (groupedPolynomial E j).map ((eraseMutable i).comp (embedMutableCoefficient j))

theorem split_eraseMutable_single (i : I) (g : G) (m : I →₀ ℤ) (n : ℤ) (hi : m i = 0) :
    LaurentPolynomial.C (eraseMutable i (AddMonoidAlgebra.single (g, m) n)) =
      laurentSplit i (AddMonoidAlgebra.single (g, m) n) := by
  rw [eraseMutable_single, laurentSplit_constant i g m n hi]

/-- When R is independent of Xi, its coefficients after grouping in Xj still lie in S_i. -/
theorem regroupedPolynomial_map (E : PositiveLaurent G I) (i j : I) (hij : i ≠ j)
    (hi : PositiveIndependent E i) :
    (regroupedPolynomial E i j).map LaurentPolynomial.C =
      (groupedPolynomial E j).map ((laurentSplit i).toRingHom.comp (embedMutableCoefficient j)) :=
        by
  classical
  unfold regroupedPolynomial groupedPolynomial
  simp only [Polynomial.map_sum, Polynomial.map_monomial]
  apply Finset.sum_congr rfl
  intro t ht
  have hti : t.2 i = 0 := by
    apply hi t.2
    simp only [mutableSupport, Finset.mem_image]
    exact ⟨t, ht, rfl⟩
  congr 1
  change LaurentPolynomial.C (eraseMutable i (embedMutableCoefficient j _)) =
    laurentSplit i (embedMutableCoefficient j _)
  rw [embedMutableCoefficient_single]
  apply split_eraseMutable_single
  simp [hti, hij.symm]

theorem regroupedPolynomial_embed (E : PositiveLaurent G I) (i j : I) (hij : i ≠ j)
    (hi : PositiveIndependent E i) :
    (regroupedPolynomial E i j).map (embedMutableCoefficient i) =
      (groupedPolynomial E j).map (embedMutableCoefficient j) := by
  apply Polynomial.map_injective (laurentSplit (R := ℤ) (G := G) i).toRingHom
    (laurentSplit (R := ℤ) (G := G) i).injective
  rw [Polynomial.map_map, Polynomial.map_map]
  have hc : (laurentSplit (R := ℤ) (G := G) i).toRingHom.comp (embedMutableCoefficient i) =
      LaurentPolynomial.C := by
    apply RingHom.ext
    intro a
    change (laurentSplit i) ((laurentSplit i).symm (LaurentPolynomial.C a)) = _
    rw [RingEquiv.apply_symm_apply]
  rw [hc]
  exact regroupedPolynomial_map E i j hij hi

/-- Evaluation after regrouping uses the actual inverse-coordinate substitution. -/
theorem regroupedPolynomial_substitution (E q : PositiveLaurent G I) (i j : I)
    (hE : PositiveNonnegativeAt E j) :
    (regroupedPolynomial E i j).eval
      (eraseMutable i (positiveCast q) *
        eraseMutable i (AddMonoidAlgebra.single (0, Finsupp.single j (-1)) 1)) =
      eraseMutable i (positiveCast (positiveSubstitute E q j)) := by
  let π : (MutableCoefficientRing G I j)[T;T⁻¹] →+* MutableCoefficientRing G I i :=
    (eraseMutable i).comp (laurentSplit j).symm.toRingHom
  have hT : (laurentSplit (R := ℤ) (G := G) j).symm (LaurentPolynomial.T (-1)) =
      AddMonoidAlgebra.single (0, Finsupp.single j (-1)) 1 := by
    apply (laurentSplit (R := ℤ) (G := G) j).injective
    rw [RingEquiv.apply_symm_apply, laurentSplit_chosen]
  have hz : π (laurentSplit j (positiveCast q) * LaurentPolynomial.T (-1)) =
      eraseMutable i (positiveCast q) *
        eraseMutable i (AddMonoidAlgebra.single (0, Finsupp.single j (-1)) 1) := by
    change eraseMutable i ((laurentSplit j).symm
      (laurentSplit j (positiveCast q) * LaurentPolynomial.T (-1))) = _
    rw [map_mul, RingEquiv.symm_apply_apply, hT, map_mul]
  have h := congrArg π (groupedPolynomial_substitution E q j hE)
  rw [← Polynomial.eval₂_at_apply, Polynomial.eval₂_map, hz] at h
  have hright : π (laurentSplit j (positiveCast (positiveSubstitute E q j))) =
      eraseMutable i (positiveCast (positiveSubstitute E q j)) := by
    change eraseMutable i ((laurentSplit j).symm (laurentSplit j _)) = _
    rw [RingEquiv.symm_apply_apply]
  rw [hright] at h
  rw [regroupedPolynomial, Polynomial.eval_map]
  change (groupedPolynomial E j).eval₂ (π.comp LaurentPolynomial.C) _ = _
  exact h

theorem eraseMutable_independent (E : PositiveLaurent G I) (i : I)
    (hi : PositiveIndependent E i) :
    LaurentPolynomial.C (eraseMutable i (positiveCast E)) = laurentSplit i (positiveCast E) := by
  obtain ⟨e, he⟩ := positiveIndependent_split E i hi
  change LaurentPolynomial.C ((LaurentPolynomial.eval₂ (RingHom.id _) (1 : (MutableCoefficientRing G
    I i)ˣ))
    (laurentSplit i (positiveCast E))) = _
  rw [he]
  simp [← Polynomial.toLaurent_C]

theorem groupedPolynomial_constantTerm_erase (Q : PositiveLaurent G I) (i : I)
    (hQ : PositiveNonnegativeAt Q i) :
    (groupedPolynomial Q i).eval 0 = eraseMutable i (positiveCast (positiveSetZero Q i)) := by
  change (groupedPolynomial Q i).eval 0 =
    (LaurentPolynomial.eval₂ (RingHom.id _) (1 : (MutableCoefficientRing G I i)ˣ))
      (laurentSplit i (positiveCast (positiveSetZero Q i)))
  have h := congrArg (LaurentPolynomial.eval₂ (RingHom.id _)
    (1 : (MutableCoefficientRing G I i)ˣ)) (groupedPolynomial_constantTerm Q i hQ)
  simpa only [← Polynomial.toLaurent_C, LaurentPolynomial.eval₂_toLaurent,
    Polynomial.eval₂_C, RingHom.id_apply] using h

/-- The actual reversed finite correction identity supplies C2 compatibility in S_i. -/
theorem regroupedPolynomial_compatibility
    (E Q H R : PositiveLaurent G I) (i j : I)
    (hQ : PositiveNonnegativeAt Q i) (hR : PositiveNonnegativeAt R j)
    (hreverse : positiveSubstitute R (positiveSetZero Q i) j =
      positiveSubstitute H (positiveSetZero Q i) j * E) :
    (regroupedPolynomial R i j).eval
      (eraseMutable i (AddMonoidAlgebra.single (0, Finsupp.single j (-1)) 1) *
        (groupedPolynomial Q i).eval 0) =
      eraseMutable i (positiveCast (positiveSubstitute H (positiveSetZero Q i) j)) *
        eraseMutable i (positiveCast E) := by
  rw [groupedPolynomial_constantTerm_erase Q i hQ, mul_comm]
  rw [regroupedPolynomial_substitution R (positiveSetZero Q i) i j hR, hreverse,
    map_mul, map_mul]

theorem eraseMutable_ne_zero (E : PositiveLaurent G I) (i : I)
    (hi : PositiveIndependent E i) (hE : E ≠ 0) : eraseMutable i (positiveCast E) ≠ 0 := by
  intro hz
  have h := eraseMutable_independent E i hi
  rw [hz, map_zero] at h
  have hc : positiveCast E = 0 := (laurentSplit i).injective (by simpa using h.symm)
  exact hE (positiveCast_injective (by simpa using hc))

/-- The inverse of an unchanged mutable coordinate is a unit in S_i. -/
theorem eraseMutable_inverse_unit (i j : I) :
    IsUnit (eraseMutable (G := G) i
      (AddMonoidAlgebra.single (0, Finsupp.single j (-1)) 1)) := by
  exact (groupRingBasisUnit (G := G) (0, Finsupp.single j (-1))).isUnit.map (eraseMutable i)

/-- C5's actual first-star certificates descend to the precise C2 coefficient ring S_i. -/
theorem firstStar_erased_certificates
    {G₀ L : Type*} [AddCommGroup G₀]
    (p : L → PositiveLaurent G₀ I)
    (lE lQ lH : L) (hEQ : lQ ≠ lE) (hEH : lH ≠ lE)
    (hE : p lE ≠ 0) (hH : p lH ≠ 0) (hQ : PositiveNoVariableFactor (p lQ))
    (i j : I) (hij : i ≠ j)
    (hEi : PositiveIndependent (p lE) i) (hHi : PositiveIndependent (p lH) i)
    (hQi : PositiveNonnegativeAt (familyAtomLift p lQ) i) :
    let E := familyAtomLift p lE
    let Q := familyAtomLift p lQ
    let A := positiveSubstitute (familyAtomLift p lH) (positiveSetZero Q i) j
    eraseMutable i (positiveCast E) ≠ 0 ∧
      IsRelPrime (eraseMutable i (positiveCast E)) ((groupedPolynomial Q i).eval 0) ∧
      IsRelPrime (eraseMutable i (positiveCast E)) (eraseMutable i (positiveCast A)) := by
  classical
  dsimp only
  have hEl : PositiveIndependent (familyAtomLift p lE) i := by
    unfold PositiveIndependent at *
    rwa [familyAtomLift_mutableSupport]
  have hHl : PositiveIndependent (familyAtomLift p lH) i := by
    unfold PositiveIndependent at *
    rwa [familyAtomLift_mutableSupport]
  have hAl := positiveSubstitute_independent (familyAtomLift p lH)
    (positiveSetZero (familyAtomLift p lQ) i) j i hij hHl
    (positiveSetZero_independent_self _ i)
  obtain ⟨hEq, hEA⟩ := firstStar_relPrime_certificates_of_inputs p lE lQ lH
    hEQ hEH hE hH hQ i j
  refine ⟨eraseMutable_ne_zero _ i hEl ?_, ?_, ?_⟩
  · intro hz
    apply hE
    rw [← familyAtomLift_specializes p lE, hz, map_zero]
  · exact relPrime_split_constants i (eraseMutable_independent _ i hEl).symm
      (groupedPolynomial_constantTerm _ i hQi).symm hEq
  · exact relPrime_split_constants i (eraseMutable_independent _ i hEl).symm
      (eraseMutable_independent _ i hAl).symm hEA

end
end TauCeti.Laurent
