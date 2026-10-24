/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.GeometricCoordinates
public import TauCetiRoadmap.LaurentPhenomenon.LaurentSupport

/-! Coprimality of two commuting principal-coefficient exchange factors
in the Laurent ring on all unchanged mutable and frozen coordinates. -/

@[expose] public section

namespace TauCeti.Cluster
open TauCeti.Laurent

variable {M I : Type*} [Fintype M] [Fintype I] [DecidableEq M] [DecidableEq I]

/-- Rows remaining after deleting the two mutable rows indexed by i and j. -/
abbrev PairOtherRows (row : I ↪ M) (i j : I) :=
  {a : M // a ≠ row i ∧ a ≠ row j}

/-- Positive part of column k, restricted to rows outside the chosen pair. -/
noncomputable def pairPositiveExponent (row : I ↪ M) (B : Matrix M I ℤ)
    (i j k : I) : PairOtherRows row i j →₀ ℤ :=
  (Finsupp.equivFunOnFinite).symm (fun a => positivePart (B a.1 k))

/-- Negative part of column k, restricted to rows outside the chosen pair. -/
noncomputable def pairNegativeExponent (row : I ↪ M) (B : Matrix M I ℤ)
    (i j k : I) : PairOtherRows row i j →₀ ℤ :=
  (Finsupp.equivFunOnFinite).symm (fun a => positivePart (-B a.1 k))

omit [DecidableEq I] [DecidableEq M] [Fintype I] in
@[simp] theorem pairPositiveExponent_apply (row : I ↪ M) (B : Matrix M I ℤ)
    (i j k : I) (a : PairOtherRows row i j) :
    pairPositiveExponent row B i j k a = positivePart (B a.1 k) := by
  simp [pairPositiveExponent]

omit [DecidableEq I] [DecidableEq M] [Fintype I] in
@[simp] theorem pairNegativeExponent_apply (row : I ↪ M) (B : Matrix M I ℤ)
    (i j k : I) (a : PairOtherRows row i j) :
    pairNegativeExponent row B i j k a = positivePart (-B a.1 k) := by
  simp [pairNegativeExponent]

omit [DecidableEq I] [DecidableEq M] [Fintype I] in
theorem pairExponentDifference_apply [Finite I] (row : I ↪ M) (B : Matrix M I ℤ)
    (i j k : I) (a : PairOtherRows row i j) :
    (pairPositiveExponent row B i j k - pairNegativeExponent row B i j k) a = B a.1 k := by
  classical
  let : Fintype I := Fintype.ofFinite I
  simp only [Finsupp.sub_apply, pairPositiveExponent_apply, pairNegativeExponent_apply]
  unfold positivePart
  omega

/-- The exchange binomial in the Laurent variables outside the chosen pair. -/
noncomputable def pairExchangeLaurent (row : I ↪ M) (B : Matrix M I ℤ)
    (i j k : I) : AddMonoidAlgebra ℤ (PairOtherRows row i j →₀ ℤ) :=
  AddMonoidAlgebra.single (pairPositiveExponent row B i j k) 1 +
    AddMonoidAlgebra.single (pairNegativeExponent row B i j k) 1

omit [DecidableEq I] [DecidableEq M] in
/-- Full extended rank makes commuting exchange factors coprime after the
two exchanged rows are removed. The remaining rows include every frozen one. -/
theorem pairExchangeLaurent_isRelPrime (row : I ↪ M) (B : Matrix M I ℤ)
    (hrank : (B.map (Int.castRingHom ℚ)).rank = Fintype.card I)
    {i j : I} (hij : i ≠ j)
    (hii : B (row i) i = 0) (hij0 : B (row i) j = 0)
    (hji0 : B (row j) i = 0) (hjj : B (row j) j = 0) :
    IsRelPrime (pairExchangeLaurent row B i j i) (pairExchangeLaurent row B i j j) := by
  classical
  obtain ⟨r, s, hminor⟩ :=
    exists_integer_two_minor_away_of_full_column_rank
      row B hrank hij hii hij0 hji0 hjj
  unfold pairExchangeLaurent
  apply isRelPrime_monomial_add_monomial_of_minor (r := r) (s := s)
  rw [pairExponentDifference_apply, pairExponentDifference_apply,
    pairExponentDifference_apply, pairExponentDifference_apply]
  exact hminor

/-- At every principal seed, vanishing interaction supplies the four row
zeros; rank preservation supplies the minor. -/
theorem principal_pairExchangeLaurent_isRelPrime
    (d : I → ℤ) (hd : ∀ i, 0 < d i)
    (B : I → I → ℤ) (hB : ∀ i j, d i * B i j = -(d j * B j i))
    (w : List I) {i j : I} (hij : i ≠ j)
    (hcomm : (mutateWord (MatrixSeed.mutate hd) w (principalSeed B hB)).matrix i j = 0) :
    IsRelPrime
      (pairExchangeLaurent (Function.Embedding.inl : I ↪ I ⊕ I)
        (principalExtendedMatrix hd B hB w) i j i)
      (pairExchangeLaurent (Function.Embedding.inl : I ↪ I ⊕ I)
        (principalExtendedMatrix hd B hB w) i j j) := by
  let A := principalExtendedMatrix hd B hB w
  have hij0 : A (Sum.inl i) j = 0 := hcomm
  have hji0 : A (Sum.inl j) i = 0 := by
    have hs := (mutateWord (MatrixSeed.mutate hd) w (principalSeed B hB)).symmetrized i j
    have hdi : d i ≠ 0 := ne_of_gt (hd i)
    have hdj : d j ≠ 0 := ne_of_gt (hd j)
    change d i * A (Sum.inl i) j = -(d j * A (Sum.inl j) i) at hs
    rw [hij0, mul_zero] at hs
    have hz : d j * A (Sum.inl j) i = 0 := neg_eq_zero.mp hs.symm
    exact (mul_eq_zero.mp hz).resolve_left hdj
  exact pairExchangeLaurent_isRelPrime (Function.Embedding.inl : I ↪ I ⊕ I) A
    (principalExtendedMatrix_rank hd B hB w) hij
    (principalExtendedMatrix_diagonal hd B hB w i) hij0 hji0
    (principalExtendedMatrix_diagonal hd B hB w j)

end TauCeti.Cluster
