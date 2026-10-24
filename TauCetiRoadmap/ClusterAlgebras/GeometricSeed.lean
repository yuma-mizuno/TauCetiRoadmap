/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.GeometricCoordinates
public import TauCetiRoadmap.ClusterAlgebras.ExtendedRank
public import TauCetiRoadmap.ClusterAlgebras.LaurentFaithfulness

/-! Geometric seeds with their genuine extended exchange law. -/

@[expose] public section

namespace TauCeti.Cluster
open TauCeti.Laurent

variable {M K F : Type*} [Fintype M] [Fintype K]
  [DecidableEq M] [DecidableEq K] [Field F] [Algebra ℚ F]

omit [Fintype K] [Fintype M] in
theorem extendedMatrixMutation_involutive (row : K ↪ M)
    (B : Matrix M K ℤ) (k : K) :
    extendedMatrixMutation row (extendedMatrixMutation row B k) k = B := by
  ext a j
  by_cases ha : a = row k
  · subst a
    simp [extendedMatrixMutation]
  · by_cases hj : j = k
    · subst j
      simp [extendedMatrixMutation, ha]
    · simp [extendedMatrixMutation, ha, hj]

omit [Fintype K] [Fintype M] in
theorem extendedMatrixMutation_principal (row : K ↪ M)
    (B : Matrix M K ℤ) (k i j : K) :
    (extendedMatrixMutation row B k) (row i) j =
      matrixMutation (fun u v => B (row u) v) k i j := by
  simp only [extendedMatrixMutation, matrixMutation, row.injective.eq_iff]

omit [Fintype K] in
theorem geometricExchangePolynomial_mutate_self (row : K ↪ M)
    (B : Matrix M K ℤ) (k : K) :
    geometricExchangePolynomial (extendedMatrixMutation row B k) k =
      geometricExchangePolynomial B k := by
  have hp : geometricPositiveDegree (extendedMatrixMutation row B k) k =
      geometricPositiveDegree (-B) k := by
    ext a
    simp [geometricPositiveDegree_apply, extendedMatrixMutation]
  have hn : geometricPositiveDegree (-(extendedMatrixMutation row B k)) k =
      geometricPositiveDegree B k := by
    ext a
    simp [geometricPositiveDegree_apply, extendedMatrixMutation]
  simp only [geometricExchangePolynomial, hp, hn]
  exact add_comm _ _

/-- A geometric seed contains a symmetrizable mutable block and an actual
algebraically independent tuple of all mutable and frozen coordinates. -/
structure GeometricSeed (row : K ↪ M) (d : K → ℤ) where
  /-- The extended exchange matrix, with mutable columns and all mutable and frozen rows. -/
  exchange : Matrix M K ℤ
  /-- The values of all mutable and frozen coordinates in the ambient field. -/
  coordinate : M → F
  symmetrized : ∀ i j, d i * exchange (row i) j = -(d j * exchange (row j) i)
  independent : AlgebraicIndependent ℚ coordinate

namespace GeometricSeed

/-- Package each independent coordinate as a unit of the ambient field. -/
noncomputable def units {row : K ↪ M} {d : K → ℤ}
    (s : GeometricSeed (F := F) row d) (a : M) : Fˣ :=
  Units.mk0 (s.coordinate a)
    (nonzero_coordinate_of_algebraicIndependent s.coordinate s.independent a)

omit [DecidableEq K] [DecidableEq M] [Fintype K] [Fintype M] in
@[simp] theorem units_val {row : K ↪ M} {d : K → ℤ}
    (s : GeometricSeed (F := F) row d) (a : M) :
    (s.units a : F) = s.coordinate a := rfl

omit [DecidableEq K] [DecidableEq M] [Fintype K] [Fintype M] in
@[ext] theorem ext {row : K ↪ M} {d : K → ℤ}
    {s t : GeometricSeed (F := F) row d}
    (hB : s.exchange = t.exchange) (hx : s.coordinate = t.coordinate) : s = t := by
  cases s
  cases t
  cases hB
  cases hx
  rfl

omit [DecidableEq K] [DecidableEq M] [Fintype K] [Fintype M] in
theorem diagonal {row : K ↪ M} {d : K → ℤ} (hd : ∀ i, 0 < d i)
    (s : GeometricSeed (F := F) row d) (k : K) : s.exchange (row k) k = 0 := by
  have h := s.symmetrized k k
  have hd0 : d k ≠ 0 := ne_of_gt (hd k)
  have hz : d k * s.exchange (row k) k = 0 := by omega
  exact (mul_eq_zero.mp hz).resolve_left hd0

/-- Exact seed mutation, evaluating the two-term exchange polynomial in the
current coordinates and dividing by the exchanged coordinate. -/
noncomputable def mutate {row : K ↪ M} {d : K → ℤ}
    (hd : ∀ i, 0 < d i) (s : GeometricSeed (F := F) row d) (k : K) :
    GeometricSeed (F := F) row d where
  exchange := extendedMatrixMutation row s.exchange k
  coordinate := geometricMutationCoordinates row s.exchange s.coordinate k
  symmetrized := by
    intro i j
    rw [extendedMatrixMutation_principal, extendedMatrixMutation_principal]
    exact matrixMutation_symmetrizer (fun u v => s.exchange (row u) v) d hd
      s.symmetrized k i j
  independent := algebraicIndependent_update_exchange s.independent (row k)
    (geometricExchangePolynomial s.exchange k)
    (geometricExchangePolynomial_ne_zero s.exchange k)
    (geometricExchangePolynomial_independent s.exchange k row (s.diagonal hd k))

/-- Full column rank is preserved under every geometric mutation. -/
theorem mutate_rank {row : K ↪ M} {d : K → ℤ}
    (hd : ∀ i, 0 < d i) (s : GeometricSeed (F := F) row d) (k : K) :
    (((s.mutate hd k).exchange).map (Int.castRingHom ℚ)).rank =
      ((s.exchange).map (Int.castRingHom ℚ)).rank :=
  extendedMatrixMutation_rank_map row s.exchange k (s.diagonal hd k) ℚ
    (Int.castRingHom ℚ)

omit [Fintype K] in
theorem exchange_eval_mutate {row : K ↪ M} {d : K → ℤ}
    (hd : ∀ i, 0 < d i) (s : GeometricSeed (F := F) row d) (k : K) :
    MvPolynomial.aeval (s.mutate hd k).coordinate
      (geometricExchangePolynomial s.exchange k) =
    MvPolynomial.aeval s.coordinate (geometricExchangePolynomial s.exchange k) := by
  apply MvPolynomial.eval₂Hom_congr' rfl ?_ rfl
  intro a ha _
  have hne : a ≠ row k := by
    intro he
    subst a
    exact (geometricExchangePolynomial_independent s.exchange k row
      (s.diagonal hd k)) ha
  simp [mutate, geometricMutationCoordinates, Function.update_of_ne hne]

omit [Fintype K] in
theorem mutate_involutive [Finite K] {row : K ↪ M} {d : K → ℤ}
    (hd : ∀ i, 0 < d i) (s : GeometricSeed (F := F) row d) (k : K) :
    (s.mutate hd k).mutate hd k = s := by
  let : Fintype K := Fintype.ofFinite K
  have hx : s.coordinate (row k) ≠ 0 := by
    exact nonzero_coordinate_of_algebraicIndependent s.coordinate s.independent (row k)
  have hP : MvPolynomial.aeval s.coordinate
      (geometricExchangePolynomial s.exchange k) ≠ 0 := by
    exact (algebraicIndependent_iff_injective_aeval.mp s.independent).ne
      (geometricExchangePolynomial_ne_zero s.exchange k)
  apply GeometricSeed.ext
  · exact extendedMatrixMutation_involutive row s.exchange k
  · funext a
    by_cases ha : a = row k
    · subst a
      have hEval : MvPolynomial.aeval
          (Function.update s.coordinate (row k)
            (MvPolynomial.aeval s.coordinate
              (geometricExchangePolynomial s.exchange k) / s.coordinate (row k)))
          (geometricExchangePolynomial s.exchange k) =
          MvPolynomial.aeval s.coordinate
            (geometricExchangePolynomial s.exchange k) := by
        simpa only [mutate, geometricMutationCoordinates] using exchange_eval_mutate hd s k
      simp only [mutate, geometricMutationCoordinates]
      simp only [Function.update_self]
      rw [geometricExchangePolynomial_mutate_self, hEval]
      field_simp
    · simp [mutate, geometricMutationCoordinates, Function.update_of_ne ha]

omit [DecidableEq K] [DecidableEq M] [Fintype K] [Fintype M] in
/-- Skew-symmetrizability: `b_ji = 0` forces `b_ij = 0`. -/
theorem exchange_eq_zero_of_eq_zero {row : K ↪ M} {d : K → ℤ}
    (hd : ∀ k, 0 < d k) (s : GeometricSeed (F := F) row d) {i j : K}
    (h : s.exchange (row j) i = 0) : s.exchange (row i) j = 0 := by
  have hs := s.symmetrized i j
  rw [h, mul_zero, neg_zero] at hs
  exact (mul_eq_zero.mp hs).resolve_left (ne_of_gt (hd i))

omit [Fintype K] in
/-- Algebraic independence over any coefficient field `𝕜 ⊆ F` (such as `ℚ` for `R_J` or a field
`𝕜` of characteristic zero for `𝕜_J`) is preserved by mutation. -/
theorem algebraicIndependent_mutate {𝕜 : Type*} [Field 𝕜] [Algebra 𝕜 F]
    {row : K ↪ M} {d : K → ℤ} (hd : ∀ i, 0 < d i) (s : GeometricSeed (F := F) row d)
    (hs : AlgebraicIndependent 𝕜 s.coordinate) (k : K) :
    AlgebraicIndependent 𝕜 (s.mutate hd k).coordinate := by
  have : CharZero F := algebraRat.charZero F
  have : CharZero 𝕜 := (algebraMap 𝕜 F).charZero
  let E : MvPolynomial M 𝕜 := MvPolynomial.monomial (geometricPositiveDegree s.exchange k) 1 +
    MvPolynomial.monomial (geometricPositiveDegree (-s.exchange) k) 1
  have hE : MvPolynomial.aeval s.coordinate E =
      MvPolynomial.aeval s.coordinate (geometricExchangePolynomial s.exchange k) := by
    simp only [E, geometricExchangePolynomial, map_add, MvPolynomial.aeval_monomial, map_one]
  have hE0 : E ≠ 0 := by
    intro hz
    have h := congrArg (MvPolynomial.eval (fun _ : M ↦ (1 : 𝕜))) hz
    simp only [E, map_add, MvPolynomial.eval_monomial, one_pow, Finsupp.prod, Finset.prod_const_one,
      mul_one, map_zero] at h
    norm_num at h
  have hvars : row k ∉ E.vars := by
    have hdiag := s.diagonal hd k
    have hp : row k ∉ (geometricPositiveDegree s.exchange k).support := by
      simp [geometricPositiveDegree_apply, hdiag, positivePart]
    have hn : row k ∉ (geometricPositiveDegree (-s.exchange) k).support := by
      simp [geometricPositiveDegree_apply, hdiag, positivePart]
    intro h
    have hm := MvPolynomial.vars_add_subset
      (MvPolynomial.monomial (geometricPositiveDegree s.exchange k) (1 : 𝕜))
      (MvPolynomial.monomial (geometricPositiveDegree (-s.exchange) k) (1 : 𝕜)) h
    simp only [MvPolynomial.vars_monomial one_ne_zero, Finset.mem_union] at hm
    exact hm.elim hp hn
  change AlgebraicIndependent 𝕜 (Function.update s.coordinate (row k)
    (MvPolynomial.aeval s.coordinate (geometricExchangePolynomial s.exchange k) /
      s.coordinate (row k)))
  rw [← hE]
  exact algebraicIndependent_update_exchange hs (row k) E hE0 hvars

end GeometricSeed

/-- Full-column-rank geometric seeds; the rank condition is preserved by
mutation and is separate from the underlying seed space. -/
abbrev FullRankGeometricSeed (row : K ↪ M) (d : K → ℤ) :=
  {s : GeometricSeed (F := F) row d //
    (s.exchange.map (Int.castRingHom ℚ)).rank = Fintype.card K}

/-- Mutate the geometric seed and transport its proved full-column-rank certificate. -/
noncomputable def FullRankGeometricSeed.mutate {row : K ↪ M} {d : K → ℤ}
    (hd : ∀ i, 0 < d i) (s : FullRankGeometricSeed (F := F) row d) (k : K) :
    FullRankGeometricSeed (F := F) row d :=
  ⟨s.1.mutate hd k, (s.1.mutate_rank hd k).trans s.2⟩

theorem FullRankGeometricSeed.mutate_involutive {row : K ↪ M} {d : K → ℤ}
    (hd : ∀ i, 0 < d i) (s : FullRankGeometricSeed (F := F) row d) (k : K) :
    (s.mutate hd k).mutate hd k = s := by
  apply Subtype.ext
  exact s.1.mutate_involutive hd k

/-- The initial principal-coefficient seed in the rational function field on
all mutable and frozen initial variables. -/
noncomputable def principalInitialGeometricSeed {I : Type*}
    [Fintype I] [DecidableEq I]
    (d : I → ℤ) (hd : ∀ i, 0 < d i)
    (B : I → I → ℤ) (hB : ∀ i j, d i * B i j = -(d j * B j i)) :
    FullRankGeometricSeed (F := PrincipalGeometricField I)
      (Function.Embedding.inl : I ↪ I ⊕ I) d := by
  refine ⟨⟨principalExtendedMatrix hd B hB [],
    rationalLaurentCoordinates (I ⊕ I), ?_,
    algebraicIndependent_rationalLaurentCoordinates (I ⊕ I)⟩,
    principalExtendedMatrix_rank_nil hd B hB⟩
  intro i j
  simpa [principalExtendedMatrix] using hB i j

end TauCeti.Cluster
