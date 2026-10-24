/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.Birational
public import TauCetiRoadmap.ClusterAlgebras.MutationPattern
public import TauCetiRoadmap.ClusterAlgebras.SeedBinomial
public import Mathlib.Algebra.MvPolynomial.Variables
public import Mathlib.Algebra.MonoidAlgebra.MapDomain
public import Mathlib.RingTheory.Localization.FractionRing
public import TauCetiRoadmap.LaurentPhenomenon.GroupRing
public import TauCetiRoadmap.ClusterAlgebras.PrincipalRank

/-! A concrete polynomial exchange law preserves algebraic independence of
all mutable and frozen coordinates. This supplies faithful Laurent charts
after every finite mutation word. -/

@[expose] public section

namespace TauCeti.Cluster
open TauCeti.Laurent

variable {K F I J V : Type*} [Field K] [Field F] [Algebra K F]
  [DecidableEq J]

omit [DecidableEq J] in
/-- Mutation changes just one coordinate, by a nonzero polynomial in the
remaining coordinates divided by the old coordinate. -/
theorem algebraicIndependent_geometric_mutation
    (row : I ↪ J) (x : V → J → F) (mutation : I → V → V)
    (E : V → I → MvPolynomial J K)
    (hother : ∀ s i j, j ≠ row i → x (mutation i s) j = x s j)
    (hexchange : ∀ s i, x (mutation i s) (row i) =
      MvPolynomial.aeval (x s) (E s i) / x s (row i))
    (hE : ∀ s i, E s i ≠ 0)
    (hindependent : ∀ s i, row i ∉ (E s i).vars)
    {s : V} (hs : AlgebraicIndependent K (x s)) (i : I) :
    AlgebraicIndependent K (x (mutation i s)) := by
  classical
  have hx : x (mutation i s) =
      Function.update (x s) (row i)
        (MvPolynomial.aeval (x s) (E s i) / x s (row i)) := by
    funext j
    by_cases hj : j = row i
    · subst j
      simp [hexchange]
    · simp [hother s i j hj, Function.update_of_ne hj]
  rw [hx]
  exact algebraicIndependent_update_exchange hs (row i) (E s i) (hE s i)
    (hindependent s i)

omit [DecidableEq J] in
/-- Faithfulness propagates to every chart reached by a finite word. -/
theorem algebraicIndependent_geometric_word
    (row : I ↪ J) (x : V → J → F) (mutation : I → V → V)
    (E : V → I → MvPolynomial J K)
    (hother : ∀ s i j, j ≠ row i → x (mutation i s) j = x s j)
    (hexchange : ∀ s i, x (mutation i s) (row i) =
      MvPolynomial.aeval (x s) (E s i) / x s (row i))
    (hE : ∀ s i, E s i ≠ 0)
    (hindependent : ∀ s i, row i ∉ (E s i).vars)
    (s : V) (hs : AlgebraicIndependent K (x s)) (w : List I) :
    AlgebraicIndependent K (x (mutateWord mutation w s)) := by
  classical
  induction w generalizing s with
  | nil => exact hs
  | cons i w ih =>
      exact ih (mutation i s)
        (algebraicIndependent_geometric_mutation row x mutation E hother hexchange hE
          hindependent hs i)

end TauCeti.Cluster


namespace TauCeti.Cluster

/-- Inclusion of nonnegative exponent vectors into Laurent exponent vectors. -/
noncomputable def naturalExponentInclusion (J : Type*) : (J →₀ ℕ) →+ (J →₀ ℤ) :=
  Finsupp.mapRange.addMonoidHom (Nat.castAddMonoidHom ℤ)

theorem naturalExponentInclusion_injective (J : Type*) :
    Function.Injective (naturalExponentInclusion J) := by
  exact Finsupp.mapRange_injective _ (by simp) Nat.cast_injective

/-- The polynomial ring embeds into the Laurent group ring on the same coordinates. -/
noncomputable def polynomialToLaurent (J : Type*) :
    MvPolynomial J ℚ →+* AddMonoidAlgebra ℚ (J →₀ ℤ) :=
  AddMonoidAlgebra.mapDomainRingHom ℚ (naturalExponentInclusion J)

theorem polynomialToLaurent_injective (J : Type*) :
    Function.Injective (polynomialToLaurent J) :=
  AddMonoidAlgebra.mapDomain_injective (naturalExponentInclusion_injective J)

@[simp] theorem polynomialToLaurent_X (J : Type*) (j : J) :
    polynomialToLaurent J (MvPolynomial.X j) =
      AddMonoidAlgebra.single (Finsupp.single j 1) (1 : ℚ) := by
  classical
  change AddMonoidAlgebra.mapDomain (naturalExponentInclusion J)
    (AddMonoidAlgebra.single (Finsupp.single j 1) (1 : ℚ)) = _
  rw [AddMonoidAlgebra.mapDomain_single]
  simp [naturalExponentInclusion, Finsupp.mapRange_single]

/-- The Laurent variables are algebraically independent over the rational field. -/
theorem algebraicIndependent_laurent_generators (J : Type*) :
    AlgebraicIndependent ℚ
      (fun j : J => (AddMonoidAlgebra.single (Finsupp.single j 1) (1 : ℚ) :
        AddMonoidAlgebra ℚ (J →₀ ℤ))) := by
  classical
  apply algebraicIndependent_iff_injective_aeval.mpr
  have heq : (MvPolynomial.aeval
      (fun j : J => (AddMonoidAlgebra.single (Finsupp.single j 1) (1 : ℚ) :
        AddMonoidAlgebra ℚ (J →₀ ℤ)))).toRingHom = polynomialToLaurent J := by
    apply MvPolynomial.ringHom_ext
    · intro c
      have hl : (polynomialToLaurent J) (MvPolynomial.C c) =
          AddMonoidAlgebra.single 0 c := by
        change AddMonoidAlgebra.mapDomain (naturalExponentInclusion J)
          (AddMonoidAlgebra.single 0 c) = _
        rw [AddMonoidAlgebra.mapDomain_single]
        simp
      simpa [MvPolynomial.aeval_C, AddMonoidAlgebra.coe_algebraMap] using hl.symm
    · intro j
      simp
  change Function.Injective (MvPolynomial.aeval
    (fun j : J => (AddMonoidAlgebra.single (Finsupp.single j 1) (1 : ℚ) :
      AddMonoidAlgebra ℚ (J →₀ ℤ)))).toRingHom
  rw [heq]
  exact polynomialToLaurent_injective J

instance rationalLaurent_isDomain (J : Type*) :
    IsDomain (AddMonoidAlgebra ℚ (J →₀ ℤ)) := by
  have : UniqueSums (J →₀ ℤ) := TauCeti.Laurent.torsionFree_uniqueSums (J →₀ ℤ)
  infer_instance

/-- The fraction field of the rational-coefficient Laurent ring in variables indexed by J. -/
abbrev RationalLaurentField (J : Type*) :=
  FractionRing (AddMonoidAlgebra ℚ (J →₀ ℤ))

/-- The canonical jth Laurent generator in the rational Laurent fraction field. -/
noncomputable def rationalLaurentCoordinates (J : Type*) (j : J) :
    RationalLaurentField J :=
  algebraMap (AddMonoidAlgebra ℚ (J →₀ ℤ)) (RationalLaurentField J)
    (AddMonoidAlgebra.single (Finsupp.single j 1) 1)

theorem algebraicIndependent_rationalLaurentCoordinates (J : Type*) :
    AlgebraicIndependent ℚ (rationalLaurentCoordinates J) := by
  classical
  let R := AddMonoidAlgebra ℚ (J →₀ ℤ)
  let F := RationalLaurentField J
  have hinj : Function.Injective (IsScalarTower.toAlgHom ℚ R F) :=
    IsFractionRing.injective R F
  have h := ((IsScalarTower.toAlgHom ℚ R F).algebraicIndependent_iff hinj).mpr
    (algebraicIndependent_laurent_generators J)
  change AlgebraicIndependent ℚ
    (fun j : J => (algebraMap R F) (AddMonoidAlgebra.single (Finsupp.single j 1) 1))
  exact h

end TauCeti.Cluster

namespace TauCeti.Cluster

variable {I J : Type*} [Fintype J] [DecidableEq J]

/-- Positive degree vector of an extended matrix column. -/
noncomputable def geometricPositiveDegree (B : Matrix J I ℤ) (k : I) : J →₀ ℕ :=
  (Finsupp.equivFunOnFinite).symm (fun j => Int.toNat (positivePart (B j k)))

omit [DecidableEq J] in
@[simp] theorem geometricPositiveDegree_apply (B : Matrix J I ℤ) (k : I) (j : J) :
    geometricPositiveDegree B k j = Int.toNat (positivePart (B j k)) := by
  simp [geometricPositiveDegree]

/-- The genuine two-term geometric exchange polynomial for a full extended column. -/
noncomputable def geometricExchangePolynomial (B : Matrix J I ℤ) (k : I) : MvPolynomial J ℚ :=
  MvPolynomial.monomial (geometricPositiveDegree B k) 1 +
    MvPolynomial.monomial (geometricPositiveDegree (-B) k) 1

omit [DecidableEq J] in
theorem geometricExchangePolynomial_ne_zero (B : Matrix J I ℤ) (k : I) :
    geometricExchangePolynomial B k ≠ 0 := by
  intro hz
  have heval := congrArg (MvPolynomial.aeval (fun _ : J => (1 : ℚ))) hz
  simp [geometricExchangePolynomial, MvPolynomial.eval_monomial] at heval

omit [DecidableEq J] in
theorem geometricExchangePolynomial_independent (B : Matrix J I ℤ) (k : I)
    (row : I ↪ J) (hdiag : B (row k) k = 0) :
    row k ∉ (geometricExchangePolynomial B k).vars := by
  classical
  have hp : row k ∉ (geometricPositiveDegree B k).support := by
    simp [geometricPositiveDegree_apply, hdiag, positivePart]
  have hn : row k ∉ (geometricPositiveDegree (-B) k).support := by
    simp [geometricPositiveDegree_apply, hdiag, positivePart]
  intro h
  have hsubset := MvPolynomial.vars_add_subset
    (MvPolynomial.monomial (geometricPositiveDegree B k) (1 : ℚ))
    (MvPolynomial.monomial (geometricPositiveDegree (-B) k) (1 : ℚ))
  have hm := hsubset h
  simp only [MvPolynomial.vars_monomial one_ne_zero, Finset.mem_union] at hm
  exact hm.elim hp hn

omit [DecidableEq J] in
/-- Every zero entry of an extended exchange column gives a variable omitted
by that column's exchange polynomial. -/
theorem geometricExchangePolynomial_omits (B : Matrix J I ℤ) (k : I)
    (a : J) (ha : B a k = 0) :
    a ∉ (geometricExchangePolynomial B k).vars := by
  classical
  have hp : a ∉ (geometricPositiveDegree B k).support := by
    simp [geometricPositiveDegree_apply, ha, positivePart]
  have hn : a ∉ (geometricPositiveDegree (-B) k).support := by
    simp [geometricPositiveDegree_apply, ha, positivePart]
  intro h
  have hsubset := MvPolynomial.vars_add_subset
    (MvPolynomial.monomial (geometricPositiveDegree B k) (1 : ℚ))
    (MvPolynomial.monomial (geometricPositiveDegree (-B) k) (1 : ℚ))
  have hm := hsubset h
  simp only [MvPolynomial.vars_monomial one_ne_zero, Finset.mem_union] at hm
  exact hm.elim hp hn

/-- The two monomials of the geometric exchange polynomial, with integer exponents. -/
theorem aeval_geometricExchangePolynomial {M K F : Type*} [Fintype M] [Field F]
    [Algebra ℚ F] (B : Matrix M K ℤ) (k : K) (x : M → F) :
    MvPolynomial.aeval x (geometricExchangePolynomial B k) =
      (∏ a, x a ^ positivePart (B a k)) + ∏ a, x a ^ positivePart (-B a k) := by
  classical
  have hmono (b : Matrix M K ℤ) :
      MvPolynomial.aeval x (MvPolynomial.monomial (geometricPositiveDegree b k) (1 : ℚ)) =
        ∏ a, x a ^ positivePart (b a k) := by
    rw [MvPolynomial.aeval_monomial, map_one, one_mul,
      Finsupp.prod_fintype _ _ (fun _ ↦ pow_zero _)]
    refine Finset.prod_congr rfl fun a _ ↦ ?_
    rw [geometricPositiveDegree_apply, ← zpow_natCast,
      Int.toNat_of_nonneg (show 0 ≤ positivePart (b a k) from le_max_right _ _)]
  rw [geometricExchangePolynomial, map_add, hmono, hmono]
  rfl

/-- The full coordinate tuple after one geometric exchange. -/
noncomputable def geometricMutationCoordinates {F : Type*} [Field F] [Algebra ℚ F]
    (row : I ↪ J) (B : Matrix J I ℤ) (x : J → F) (k : I) : J → F :=
  Function.update x (row k)
    (MvPolynomial.aeval x (geometricExchangePolynomial B k) / x (row k))

end TauCeti.Cluster

namespace TauCeti.Cluster

variable {I : Type*} [Fintype I] [DecidableEq I]
open TauCeti.Laurent

/-- The rational function field with one mutable and one frozen variable for each index. -/
abbrev PrincipalGeometricField (I : Type*) := RationalLaurentField (I ⊕ I)

/-- The initial principal geometric coordinates, as units of the field. -/
noncomputable def principalGeometricUnits (i : I ⊕ I) : (PrincipalGeometricField I)ˣ :=
  Units.mk0 (rationalLaurentCoordinates (I ⊕ I) i)
    ((algebraicIndependent_rationalLaurentCoordinates (I ⊕ I)).ne_zero i)

/-- One genuine geometric mutation of a full extended matrix and all
mutable/frozen field coordinates. -/
noncomputable def geometricStep (k : I)
    (state : Matrix (I ⊕ I) I ℤ × ((I ⊕ I) → PrincipalGeometricField I)) :
    Matrix (I ⊕ I) I ℤ × ((I ⊕ I) → PrincipalGeometricField I) :=
  (extendedMatrixMutation (Function.Embedding.inl : I ↪ I ⊕ I) state.1 k,
    Function.update state.2 (Sum.inl k)
      (MvPolynomial.aeval state.2 (geometricExchangePolynomial state.1 k) /
        state.2 (Sum.inl k)))

/-- Actual total coordinates obtained from the principal extended seed by
successive polynomial exchange, including frozen initial variables. -/
noncomputable def geometricWordData (d : I → ℤ) (hd : ∀ i, 0 < d i)
    (B : I → I → ℤ) (hB : ∀ i j, d i * B i j = -(d j * B j i))
    (w : List I) :
    Matrix (I ⊕ I) I ℤ × ((I ⊕ I) → PrincipalGeometricField I) :=
  w.foldl (fun state k => geometricStep k state)
    (principalExtendedMatrix hd B hB [], rationalLaurentCoordinates (I ⊕ I))

theorem geometricWordData_matrix (d : I → ℤ) (hd : ∀ i, 0 < d i)
    (B : I → I → ℤ) (hB : ∀ i j, d i * B i j = -(d j * B j i))
    (w : List I) :
    (geometricWordData d hd B hB w).1 = principalExtendedMatrix hd B hB w := by
  induction w using List.reverseRecOn with
  | nil => rfl
  | append_singleton w k ih =>
      rw [geometricWordData, List.foldl_append]
      simp only [List.foldl_cons, List.foldl_nil]
      change (geometricStep k (geometricWordData d hd B hB w)).1 = _
      simp [geometricStep, ih, principalExtendedMatrix_append]

theorem geometricWordData_independent (d : I → ℤ) (hd : ∀ i, 0 < d i)
    (B : I → I → ℤ) (hB : ∀ i j, d i * B i j = -(d j * B j i))
    (w : List I) :
    AlgebraicIndependent ℚ (geometricWordData d hd B hB w).2 := by
  induction w using List.reverseRecOn with
  | nil => exact algebraicIndependent_rationalLaurentCoordinates (I ⊕ I)
  | append_singleton w k ih =>
      rw [geometricWordData, List.foldl_append]
      simp only [List.foldl_cons, List.foldl_nil]
      change AlgebraicIndependent ℚ (geometricStep k (geometricWordData d hd B hB w)).2
      dsimp only [geometricStep]
      have hm := geometricWordData_matrix d hd B hB w
      exact algebraicIndependent_update_exchange ih (Sum.inl k)
        (geometricExchangePolynomial (geometricWordData d hd B hB w).1 k)
        (geometricExchangePolynomial_ne_zero _ _)
        (geometricExchangePolynomial_independent
          (geometricWordData d hd B hB w).1 k
          (Function.Embedding.inl : I ↪ I ⊕ I) (hm ▸
            principalExtendedMatrix_diagonal hd B hB w k))

end TauCeti.Cluster
