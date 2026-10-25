/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.GeometricSeed
public import TauCetiRoadmap.LaurentPhenomenon.MutationWord

/-!
# Classical geometric exchange patterns

Matrix and coordinate mutation on independent classical data, with no quantum
input. The degree-one comparison with polynomial patterns uses this same owner.
-/

@[expose] public section

namespace TauCeti.Cluster

open TauCeti TauCeti.Laurent

noncomputable section

/-! ### Classical geometric patterns -/

section GeometricPattern

variable {M K F : Type*} [Fintype M] [DecidableEq M] [DecidableEq K] [Field F]
  (row : K ↪ M)

/-- One classical geometric exchange at `k` of an extended matrix `B_ext` and values `x : M → F`:
`B_ext ↦ μ_k B_ext` and `x_k ↦ (∏_i x_i^{[b_ik]_+} + ∏_i x_i^{[-b_ik]_+}) / x_k`. -/
def geometricExchange (k : K) (p : Matrix M K ℤ × (M → F)) : Matrix M K ℤ × (M → F) :=
  (extendedMatrixMutation row p.1 k,
    Function.update p.2 (row k)
      ((∏ i, p.2 i ^ positivePart (p.1 i k) + ∏ i, p.2 i ^ positivePart (-p.1 i k)) /
        p.2 (row k)))

/-- The classical geometric pattern with initial extended matrix `B_ext` and initial values `x`:
the extended matrix and the values after the word `w`. -/
def geometricPattern (B : Matrix M K ℤ) (x : M → F) (w : List K) : Matrix M K ℤ × (M → F) :=
  mutateWord (geometricExchange row) w (B, x)

variable {row} (k : K) (p : Matrix M K ℤ × (M → F))

@[simp] theorem geometricExchange_fst :
    (geometricExchange row k p).1 = extendedMatrixMutation row p.1 k := rfl

@[simp] theorem geometricExchange_snd_row :
    (geometricExchange row k p).2 (row k) =
      (∏ i, p.2 i ^ positivePart (p.1 i k) + ∏ i, p.2 i ^ positivePart (-p.1 i k)) /
        p.2 (row k) :=
  Function.update_self _ _ _

theorem geometricExchange_snd_of_ne {j : M} (hj : j ≠ row k) :
    (geometricExchange row k p).2 j = p.2 j :=
  Function.update_of_ne hj _ _

/-- The classical exchange relation `x'_k x_k = ∏ x_i^{[b_ik]_+} + ∏ x_i^{[-b_ik]_+}`. -/
theorem geometricExchange_snd_row_mul (hp : p.2 (row k) ≠ 0) :
    (geometricExchange row k p).2 (row k) * p.2 (row k) =
      ∏ i, p.2 i ^ positivePart (p.1 i k) + ∏ i, p.2 i ^ positivePart (-p.1 i k) := by
  rw [geometricExchange_snd_row, div_mul_cancel₀ _ hp]

/-- Over a field of characteristic zero the exchange is the evaluation of the geometric exchange
polynomial. -/
theorem geometricExchange_snd_eq_geometricMutationCoordinates [Algebra ℚ F] :
    (geometricExchange row k p).2 = geometricMutationCoordinates row p.1 p.2 k := by
  rw [geometricMutationCoordinates, aeval_geometricExchangePolynomial]
  rfl

variable (row) {B : Matrix M K ℤ} {x : M → F}

@[simp] theorem geometricPattern_nil : geometricPattern row B x [] = (B, x) := rfl
theorem geometricPattern_append (w : List K) :
    geometricPattern row B x (w ++ [k]) = geometricExchange row k (geometricPattern row B x w) := by
  rw [geometricPattern, mutateWord_append]
  rfl

/-- The matrices of a geometric pattern are the mutated extended matrices. -/
theorem geometricPattern_fst (w : List K) :
    (geometricPattern row B x w).1 =
      mutateWord (fun k B ↦ extendedMatrixMutation row B k) w B := by
  induction w generalizing B x with
  | nil => rfl
  | cons k w ih => exact ih

/-- Geometric exchanges preserve algebraic independence over `ℚ` of the values, provided the
diagonal entries at the exchanged directions vanish. -/
theorem algebraicIndependent_geometricPattern [Algebra ℚ F] (hx : AlgebraicIndependent ℚ x)
    (w : List K) (hdiag : ∀ u k, u ++ [k] <+: w → (geometricPattern row B x u).1 (row k) k = 0) :
    AlgebraicIndependent ℚ (geometricPattern row B x w).2 := by
  induction w using List.reverseRecOn with
  | nil => exact hx
  | append_singleton w k ih =>
    have ih := ih fun u j hu ↦ hdiag u j (hu.trans (List.prefix_append _ _))
    rw [geometricPattern_append, geometricExchange_snd_eq_geometricMutationCoordinates]
    exact algebraicIndependent_update_exchange ih (row k) _
      (geometricExchangePolynomial_ne_zero _ k)
      (geometricExchangePolynomial_independent _ k row (hdiag w k (List.prefix_refl _)))

end GeometricPattern


section SeedComparison
variable {M K F : Type*} [Fintype M] [Fintype K] [DecidableEq M] [DecidableEq K]
  [Field F] [Algebra ℚ F] {row : K ↪ M} {d : K → ℤ} (hd : ∀ k, 0 < d k)

namespace GeometricSeed

variable (s : GeometricSeed (F := F) row d)

omit [Fintype K] in
/-- One step of a classical geometric pattern is the mutation of §1.4's geometric seeds. -/
theorem geometricExchange_eq_mutate (k : K) :
    geometricExchange row k (s.exchange, s.coordinate) =
      ((s.mutate hd k).exchange, (s.mutate hd k).coordinate) :=
  Prod.ext rfl (geometricExchange_snd_eq_geometricMutationCoordinates k _)

omit [Fintype K] in
/-- **Bridge to §1.4.** The classical geometric pattern of the extended matrix and values of a
geometric seed consists of the extended matrices and values of its mutations along words. -/
theorem geometricPattern_eq [Finite K] (w : List K) :
    geometricPattern row s.exchange s.coordinate w =
      ((mutateWord (fun k t ↦ t.mutate hd k) w s).exchange,
        (mutateWord (fun k t ↦ t.mutate hd k) w s).coordinate) := by
  let : Fintype K := Fintype.ofFinite K
  induction w generalizing s with
  | nil => rfl
  | cons k w ih =>
    rw [mutateWord_cons, ← ih (s.mutate hd k)]
    exact congrArg (mutateWord (geometricExchange row) w) (s.geometricExchange_eq_mutate hd k)

end GeometricSeed

end SeedComparison

end
end TauCeti.Cluster
