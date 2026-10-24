/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.PrincipalCoefficients
public import TauCetiRoadmap.ClusterAlgebras.ExtendedRank

/-! The actual principal-coefficient pattern has full extended column rank at
every word, even when its mutable exchange matrix is singular. -/

@[expose] public section

noncomputable section
namespace TauCeti.Cluster
open TauCeti.Laurent Matrix
variable {I : Type*} [Fintype I] [DecidableEq I]
variable {d : I → ℤ} (hd : ∀ i, 0 < d i)
    (B : I → I → ℤ) (hB : ∀ i j, d i * B i j = -(d j * B j i))

/-- The mutable block together with the evolved frozen rows for a principal mutation word. -/
def principalExtendedMatrix (w : List I) : Matrix (I ⊕ I) I ℤ :=
  Sum.elim (mutateWord (MatrixSeed.mutate hd) w (principalSeed B hB)).matrix
    (principalFrozenRow hd B hB w)

omit [Fintype I] in
theorem principalExtendedMatrix_nil_frozen :
    (principalExtendedMatrix hd B hB []).submatrix Sum.inr id = 1 := by
  ext i j
  simp [principalExtendedMatrix, Matrix.submatrix, eq_comm, Matrix.one_apply]

omit [Fintype I] in
theorem principalExtendedMatrix_diagonal (w : List I) (k : I) :
    principalExtendedMatrix hd B hB w (Sum.inl k) k = 0 :=
  diagonal_of_positive_symmetrizer _ d hd
    (mutateWord (MatrixSeed.mutate hd) w (principalSeed B hB)).symmetrized k

omit [Fintype I] in
theorem principalExtendedMatrix_append (w : List I) (k : I) :
    principalExtendedMatrix hd B hB (w ++ [k]) =
      extendedMatrixMutation (Function.Embedding.inl : I ↪ I ⊕ I)
        (principalExtendedMatrix hd B hB w) k := by
  ext a j
  cases a with
  | inl i =>
    simp [principalExtendedMatrix, extendedMatrixMutation, mutateWord_append,
      MatrixSeed.mutate, matrixMutation]
  | inr f =>
    by_cases hjk : j = k
    · subst j
      simpa [principalExtendedMatrix, extendedMatrixMutation] using
        principalFrozenRow_append_self hd B hB w f k
    · simpa [principalExtendedMatrix, extendedMatrixMutation, hjk] using
        principalFrozenRow_extended_mutation hd B hB w f k j hjk

theorem principalExtendedMatrix_rank_nil :
    ((principalExtendedMatrix hd B hB []).map (Int.castRingHom ℚ)).rank = Fintype.card I := by
  let A := (principalExtendedMatrix hd B hB []).map (Int.castRingHom ℚ)
  have hf : A.submatrix Sum.inr id = 1 := by
    ext i j
    change (Int.castRingHom ℚ) (principalFrozenRow hd B hB [] i j) = (1 : Matrix I I ℚ) i j
    simp [Matrix.one_apply, eq_comm]
  apply le_antisymm (rank_le_card_width _)
  have h := rank_submatrix_le A Sum.inr id
  rwa [hf, rank_one] at h

theorem principalExtendedMatrix_rank (w : List I) :
    ((principalExtendedMatrix hd B hB w).map (Int.castRingHom ℚ)).rank = Fintype.card I := by
  induction w using List.reverseRecOn with
  | nil => exact principalExtendedMatrix_rank_nil hd B hB
  | append_singleton w k ih =>
    rw [principalExtendedMatrix_append]
    rw [extendedMatrixMutation_rank_map (Function.Embedding.inl : I ↪ I ⊕ I)
      (principalExtendedMatrix hd B hB w) k (principalExtendedMatrix_diagonal hd B hB w k)
      ℚ (Int.castRingHom ℚ)]
    exact ih

end TauCeti.Cluster
