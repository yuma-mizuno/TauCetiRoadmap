/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.PositiveCaterpillar
public import TauCetiRoadmap.LaurentPhenomenon.PositiveEvaluation
public import TauCetiRoadmap.LaurentPhenomenon.LaurentSplit
public import TauCetiRoadmap.LaurentPhenomenon.FiniteLocalModel
public import TauCetiRoadmap.LaurentPhenomenon.PositiveSpecialization

/-! # Positive Local Model -/

@[expose] public section

namespace TauCeti.Laurent

noncomputable section

open scoped LaurentPolynomial

variable {G I : Type*} [AddCommGroup G] [DecidableEq I]

omit [DecidableEq I] in
theorem reflectedExponent_involutive (j : I) (a : I →₀ ℤ) :
    reflectedExponent j (reflectedExponent j a) = a := by
  classical
  ext i
  by_cases hi : j = i
  · subst i
    simp only [reflectedExponent, Finsupp.sub_apply, Finsupp.single_eq_same]
    omega
  · simp [reflectedExponent, hi]

omit [DecidableEq I] in
theorem reflectedExponent_chosen (j : I) (a : I →₀ ℤ) :
    reflectedExponent j a j = -(a j) := by
  simp only [reflectedExponent, Finsupp.sub_apply, Finsupp.single_eq_same]
  omega

variable {F : Type*} [Field F]

/-- A coefficient-one group monomial as a unit, with inverse given by the negated exponent. -/
def groupRingBasisUnit (t : LaurentExponent G I) : (AddMonoidAlgebra ℤ (LaurentExponent G I))ˣ where
  val := AddMonoidAlgebra.single t 1
  inv := AddMonoidAlgebra.single (-t) 1
  val_inv := by simp [AddMonoidAlgebra.single_mul_single, AddMonoidAlgebra.one_def]
  inv_val := by simp [AddMonoidAlgebra.single_mul_single, AddMonoidAlgebra.one_def]

/-- Recover a unit-valued exponent character by applying a ring map to group-basis units. -/
def ringCharacter (φ : AddMonoidAlgebra ℤ (LaurentExponent G I) →+* F) :
    LaurentExponent G I →+ Additive Fˣ where
  toFun t := Additive.ofMul (Units.map φ.toMonoidHom (groupRingBasisUnit t))
  map_zero' := by ext; simp [groupRingBasisUnit, ← AddMonoidAlgebra.one_def]
  map_add' a b := by
    ext
    simp [groupRingBasisUnit, ← map_mul, AddMonoidAlgebra.single_mul_single]

omit [DecidableEq I] in
theorem positiveEvaluate_ringCharacter (φ : AddMonoidAlgebra ℤ (LaurentExponent G I) →+* F)
    (E : PositiveLaurent G I) : positiveEvaluate (ringCharacter φ) E = φ (positiveCast E) := by
  classical
  conv_lhs => rw [← AddMonoidAlgebra.sum_coeff_single E]
  conv_rhs => rw [← AddMonoidAlgebra.sum_coeff_single E]
  simp only [Finsupp.sum, map_sum]
  apply Finset.sum_congr rfl
  intro t ht
  rw [positiveEvaluate_single]
  change (E.coeff t : F) * φ (AddMonoidAlgebra.single t 1) = _
  simp only [positiveCast, AddMonoidAlgebra.mapRingHom_single]
  change (E.coeff t : F) * φ (AddMonoidAlgebra.single t 1) =
    φ (AddMonoidAlgebra.single t (E.coeff t : ℤ))
  have hn : AddMonoidAlgebra.single t (E.coeff t : ℤ) =
      (E.coeff t : AddMonoidAlgebra ℤ (LaurentExponent G I)) * AddMonoidAlgebra.single t 1 := by
    simp [AddMonoidAlgebra.natCast_def, AddMonoidAlgebra.single_mul_single]
  rw [hn, map_mul, map_natCast]

omit [DecidableEq I] in
theorem substitutedCharacter_involutive
    (χ : LaurentExponent G I →+ Additive Fˣ) (j : I) (u : Fˣ) :
    substitutedCharacter (substitutedCharacter χ j u) j u = χ := by
  classical
  ext t
  simp only [substitutedCharacter_apply, reflectedExponent_involutive,
    reflectedExponent_chosen, zpow_neg]
  simp only [Prod.mk.eta, mul_assoc, ne_eq, Units.ne_zero, not_false_eq_true, mul_eq_left₀]
  exact inv_mul_cancel₀ (zpow_ne_zero _ u.ne_zero)

omit [DecidableEq I] in
theorem positiveEvaluate_independent_substitution
    (χ : LaurentExponent G I →+ Additive Fˣ) (q : PositiveLaurent G I)
    (j : I) (u : Fˣ) (hq : PositiveIndependent q j) :
    positiveEvaluate (substitutedCharacter χ j u) q = positiveEvaluate χ q := by
  classical
  conv_lhs => rw [← AddMonoidAlgebra.sum_coeff_single q]
  conv_rhs => rw [← AddMonoidAlgebra.sum_coeff_single q]
  simp only [Finsupp.sum, map_sum]
  apply Finset.sum_congr rfl
  intro t ht
  have hj : t.2 j = 0 := by
    apply hq t.2
    simp only [mutableSupport, Finset.mem_image]
    exact ⟨t, ht, rfl⟩
  simp [positiveEvaluate_single, substitutedCharacter_apply, reflectedExponent, hj]

omit [DecidableEq I] in
/-- Reverse the actual positive correction identity in a field. The same q is
used in both substitutions because it is independent of the changed variable. -/
theorem positive_correction_reverse
    (χ : LaurentExponent G I →+ Additive Fˣ) (H E q R : PositiveLaurent G I)
    (j : I) (hq : PositiveIndependent q j) (u : Fˣ)
    (hu : (u : F) = positiveEvaluate χ q)
    (hE : ∀ t ∈ E.coeff.support, 0 ≤ t.2 j)
    (hcompat : R = positivePropagate H E q j) :
    positiveEvaluate (substitutedCharacter χ j u) R =
      positiveEvaluate (substitutedCharacter χ j u) H * positiveEvaluate χ E := by
  classical
  rw [hcompat, positivePropagate, map_mul]
  rw [positiveEvaluate_substitute _ E q j u
    (hu.trans (positiveEvaluate_independent_substitution χ q j u hq).symm) hE]
  rw [substitutedCharacter_involutive]

omit [DecidableEq I] in
theorem positive_reverse_identity
    [IsDomain (AddMonoidAlgebra ℤ (LaurentExponent G I))]
    (H E q R : PositiveLaurent G I) (j : I) (hq : PositiveIndependent q j) (hq0 : q ≠ 0)
    (hE : ∀ t ∈ E.coeff.support, 0 ≤ t.2 j)
    (hR : ∀ t ∈ R.coeff.support, 0 ≤ t.2 j)
    (hH : ∀ t ∈ H.coeff.support, 0 ≤ t.2 j)
    (hcompat : R = positivePropagate H E q j) :
    positiveSubstitute R q j = positiveSubstitute H q j * E := by
  classical
  let B := AddMonoidAlgebra ℤ (LaurentExponent G I)
  let K := FractionRing B
  let φ : B →+* K := algebraMap B K
  let χ := ringCharacter φ
  have hqval : positiveEvaluate χ q ≠ 0 := by
    rw [positiveEvaluate_ringCharacter]
    exact fun hz => hq0 (positiveCast_injective
      ((IsFractionRing.injective B K) (by simpa only [φ, map_zero] using hz)))
  let u : Kˣ := Units.mk0 (positiveEvaluate χ q) hqval
  have hu : (u : K) = positiveEvaluate χ q := rfl
  apply positiveCast_injective
  apply IsFractionRing.injective B K
  change φ (positiveCast (positiveSubstitute R q j)) = φ (positiveCast (positiveSubstitute H q j *
    E))
  calc
    _ = positiveEvaluate χ (positiveSubstitute R q j) := (positiveEvaluate_ringCharacter φ _).symm
    _ = positiveEvaluate (substitutedCharacter χ j u) R :=
      positiveEvaluate_substitute χ R q j u hu hR
    _ = positiveEvaluate (substitutedCharacter χ j u) H * positiveEvaluate χ E :=
      positive_correction_reverse χ H E q R j hq u hu hE hcompat
    _ = positiveEvaluate χ (positiveSubstitute H q j) * positiveEvaluate χ E := by
      rw [positiveEvaluate_substitute χ H q j u hu hH]
    _ = _ := by rw [← map_mul, positiveEvaluate_ringCharacter]

omit [DecidableEq I] in
omit [AddCommGroup G] in
theorem positiveSetZero_independent (Q : PositiveLaurent G I) (i j : I)
    (hQ : PositiveIndependent Q j) : PositiveIndependent (positiveSetZero Q i) j := by
  classical
  intro a ha
  simp only [mutableSupport, Finset.mem_image] at ha
  obtain ⟨t, ht, rfl⟩ := ha
  have ht' : t ∈ Q.coeff.support := by
    rw [positiveSetZero_support] at ht
    exact (Finset.mem_filter.mp ht).1
  apply hQ t.2
  simp only [mutableSupport, Finset.mem_image]
  exact ⟨t, ht', rfl⟩

omit [DecidableEq I] in
omit [AddCommGroup G] in
theorem positiveSetZero_independent_self (Q : PositiveLaurent G I) (i : I) :
    PositiveIndependent (positiveSetZero Q i) i := by
  classical
  intro a ha
  simp only [mutableSupport, Finset.mem_image] at ha
  obtain ⟨t, ht, rfl⟩ := ha
  rw [positiveSetZero_support] at ht
  exact (Finset.mem_filter.mp ht).2

omit [DecidableEq I] in
theorem positiveIndependent_pow (q : PositiveLaurent G I) (i : I)
    (hq : PositiveIndependent q i) (n : ℕ) : PositiveIndependent (q ^ n) i := by
  classical
  induction n with
  | zero => simp [PositiveIndependent, mutableSupport]
  | succ n ih =>
    intro a ha
    rw [pow_succ, mutableSupport_mul] at ha
    obtain ⟨b, hb, c, hc, rfl⟩ := Finset.mem_image₂.mp ha
    simp [ih b hb, hq c hc]

omit [DecidableEq I] in
theorem positiveSubstitute_independent (E q : PositiveLaurent G I) (j i : I)
    (hij : i ≠ j) (hE : PositiveIndependent E i) (hq : PositiveIndependent q i) :
    PositiveIndependent (positiveSubstitute E q j) i := by
  classical
  intro a ha
  obtain ⟨t, ht, b, hb, rfl⟩ := (positiveSubstitute_support_mem E q j a).mp ha
  have hi : t.2 i = 0 := by
    apply hE t.2
    simp only [mutableSupport, Finset.mem_image]
    exact ⟨t, ht, rfl⟩
  have hb0 := positiveIndependent_pow q i hq (t.2 j).toNat b hb
  simp [reflectedExponent, hij.symm, hi, hb0]

/-- The integer Laurent ring in the coefficient group and all mutable variables except i. -/
abbrev MutableCoefficientRing (G I : Type*) (i : I) :=
  AddMonoidAlgebra ℤ (G × ({k // k ≠ i} →₀ ℤ))

/-- Explicit regrouping by one nonnegative mutable exponent. -/
def groupedPolynomial (E : PositiveLaurent G I) (i : I) :
    Polynomial (MutableCoefficientRing G I i) :=
  ∑ t ∈ E.coeff.support, Polynomial.monomial (t.2 i).toNat
    (AddMonoidAlgebra.single (t.1, (splitExponents i t.2).2) (E.coeff t : ℤ))

theorem groupedPolynomial_toLaurent (E : PositiveLaurent G I) (i : I)
    (hE : PositiveNonnegativeAt E i) :
    Polynomial.toLaurent (groupedPolynomial E i) = laurentSplit i (positiveCast E) := by
  classical
  unfold groupedPolynomial
  rw [map_sum]
  conv_rhs => rw [← AddMonoidAlgebra.sum_coeff_single E]
  simp only [Finsupp.sum, map_sum]
  apply Finset.sum_congr rfl
  intro t ht
  have hi : 0 ≤ t.2 i := by
    apply hE t.2
    simp only [mutableSupport, Finset.mem_image]
    exact ⟨t, ht, rfl⟩
  rcases t with ⟨g, a⟩
  simp [positiveCast, Int.toNat_of_nonneg hi]

/-- A polynomial independent of the grouped variable is a genuine constant. -/
theorem groupedPolynomial_independent (E : PositiveLaurent G I) (i : I)
    (hE : PositiveIndependent E i) :
    groupedPolynomial E i = Polynomial.C ((groupedPolynomial E i).eval 0) := by
  classical
  unfold groupedPolynomial
  rw [Polynomial.eval_finsetSum, map_sum]
  apply Finset.sum_congr rfl
  intro t ht
  have hi : t.2 i = 0 := by
    apply hE t.2
    simp only [mutableSupport, Finset.mem_image]
    exact ⟨t, ht, rfl⟩
  simp [hi]

theorem groupedPolynomial_ne_zero (E : PositiveLaurent G I) (i : I)
    (hE : PositiveNonnegativeAt E i) (hE0 : E ≠ 0) : groupedPolynomial E i ≠ 0 := by
  intro hp
  apply hE0
  apply positiveCast_injective
  apply (laurentSplit i).injective
  simpa only [hp, map_zero] using (groupedPolynomial_toLaurent E i hE).symm

theorem groupedPolynomial_constantTerm (Q : PositiveLaurent G I) (i : I)
    (hQ : PositiveNonnegativeAt Q i) :
    LaurentPolynomial.C ((groupedPolynomial Q i).eval 0) =
      laurentSplit i (positiveCast (positiveSetZero Q i)) := by
  classical
  simp only [groupedPolynomial, Polynomial.eval_finsetSum, map_sum]
  rw [positiveSetZero_as_sum]
  simp only [Finsupp.sum, map_sum]
  apply Finset.sum_congr rfl
  intro t ht
  have hn : 0 ≤ t.2 i := by
    apply hQ t.2
    simp only [mutableSupport, Finset.mem_image]
    exact ⟨t, ht, rfl⟩
  by_cases hi : t.2 i = 0
  · rcases t with ⟨g, a⟩
    simp [hi, positiveCast]
  · have hnat : (t.2 i).toNat ≠ 0 := by omega
    simp [hi, hnat]

/-- Regrouping evaluates finite positive substitution exactly, within a Laurent
ring; the substituted numerator need not be a unit. -/
theorem groupedPolynomial_substitution (E q : PositiveLaurent G I) (j : I)
    (hE : PositiveNonnegativeAt E j) :
    ((groupedPolynomial E j).map LaurentPolynomial.C).eval
      (laurentSplit j (positiveCast q) * LaurentPolynomial.T (-1)) =
        laurentSplit j (positiveCast (positiveSubstitute E q j)) := by
  classical
  simp only [groupedPolynomial, Polynomial.map_sum, Polynomial.eval_finsetSum]
  simp only [positiveSubstitute, Finsupp.sum, map_sum]
  apply Finset.sum_congr rfl
  intro t ht
  have hn : 0 ≤ t.2 j := by
    apply hE t.2
    simp only [mutableSupport, Finset.mem_image]
    exact ⟨t, ht, rfl⟩
  have hs : (splitExponents j (reflectedExponent j t.2)).2 = (splitExponents j t.2).2 := by
    ext k
    simp [splitExponents_snd_apply, reflectedExponent]
  simp only [Polynomial.map_monomial, Polynomial.eval_monomial, positiveSubstitutionTerm,
    multiplesHom_apply, map_nsmul, map_mul, map_pow]
  rcases t with ⟨g, a⟩
  simp only [positiveCast, AddMonoidAlgebra.mapRingHom_single, laurentSplit_single]
  rw [reflectedExponent_chosen, hs]
  simp only [mul_pow, LaurentPolynomial.T_pow,
    Int.toNat_of_nonneg hn]
  rw [← smul_mul_assoc, AddMonoidAlgebra.smul_single, AddMonoidAlgebra.smul_single]
  simp only [map_one, nsmul_eq_mul, mul_one]
  rw [LaurentPolynomial.single_eq_C_mul_T, Int.mul_neg_one]
  ring

namespace PositiveCaterpillar

variable {P : CaterpillarPath I} (T : PositiveCaterpillar G P)

omit [DecidableEq I] in
theorem correction_substitute_independent (p : Fin (P.length - 2)) (i : I)
    (hi : i ≠ P.middleLabel p) :
    PositiveIndependent (positiveSubstitute (T.correction p i)
      (positiveSetZero (T.exchange (P.leftStar p) (P.middleLabel p)) i) (P.middleLabel p)) i := by
  classical
  exact positiveSubstitute_independent _ _ _ i hi (T.correction_independent p i hi)
    (positiveSetZero_independent_self _ i)

omit [DecidableEq I] in
theorem correction_substitute_ne_zero (p : Fin (P.length - 2)) (i : I)
    (hi : i ≠ P.middleLabel p) :
    positiveSubstitute (T.correction p i)
      (positiveSetZero (T.exchange (P.leftStar p) (P.middleLabel p)) i) (P.middleLabel p) ≠ 0 :=
  positiveSubstitute_ne_zero (T.correction_ne_zero p i hi)
    (positiveNoVariableFactor_setZero_ne_zero _ (T.exchange_no_factor _ _) i) _

omit [DecidableEq I] in
theorem correction_reverse_identity
    [IsDomain (AddMonoidAlgebra ℤ (LaurentExponent G I))]
    (p : Fin (P.length - 2)) (i : I) (hi : i ≠ P.middleLabel p) :
    positiveSubstitute (T.exchange (P.rightStar p) i)
      (positiveSetZero (T.exchange (P.leftStar p) (P.middleLabel p)) i) (P.middleLabel p) =
    positiveSubstitute (T.correction p i)
      (positiveSetZero (T.exchange (P.leftStar p) (P.middleLabel p)) i) (P.middleLabel p) *
      T.exchange (P.leftStar p) i := by
  classical
  apply positive_reverse_identity _ _ _ _ (P.middleLabel p)
    (positiveSetZero_independent _ i _ (T.exchange_independent _ _))
    (positiveNoVariableFactor_setZero_ne_zero _ (T.exchange_no_factor _ _) i)
    (fun t ht => T.exchange_polynomial _ _ t.2
      (by simp only [mutableSupport, Finset.mem_image]; exact ⟨t, ht, rfl⟩) _)
    (fun t ht => T.exchange_polynomial _ _ t.2
      (by simp only [mutableSupport, Finset.mem_image]; exact ⟨t, ht, rfl⟩) _)
    (fun t ht => T.correction_nonnegative p i hi t.2
      (by simp only [mutableSupport, Finset.mem_image]; exact ⟨t, ht, rfl⟩))
  exact T.compatibility p i hi

omit [DecidableEq I] in
theorem correction_reverse_evaluate (p : Fin (P.length - 2)) (i : I)
    (hi : i ≠ P.middleLabel p) (χ : LaurentExponent G I →+ Additive Fˣ) (u : Fˣ)
    (hu : (u : F) = positiveEvaluate χ
      (positiveSetZero (T.exchange (P.leftStar p) (P.middleLabel p)) i)) :
    positiveEvaluate (substitutedCharacter χ (P.middleLabel p) u)
      (T.exchange (P.rightStar p) i) =
    positiveEvaluate (substitutedCharacter χ (P.middleLabel p) u) (T.correction p i) *
      positiveEvaluate χ (T.exchange (P.leftStar p) i) := by
  classical
  apply positive_correction_reverse χ _ _ _ _ (P.middleLabel p)
    (positiveSetZero_independent _ i _ (T.exchange_independent _ _)) u hu
    (fun t ht => T.exchange_polynomial _ _ t.2
      (by simp only [mutableSupport, Finset.mem_image]; exact ⟨t, ht, rfl⟩) _)
  exact T.compatibility p i hi

end PositiveCaterpillar

end

end TauCeti.Laurent
