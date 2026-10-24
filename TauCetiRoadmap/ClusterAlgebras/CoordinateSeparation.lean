/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.PrincipalSeparation

/-! # Coordinate Separation -/

@[expose] public section

namespace TauCeti.Cluster
open TauCeti.Laurent
noncomputable section

variable {I V W P F : Type*} [Fintype I] [DecidableEq I]
  [CoefficientSemifield P] [Field F]

theorem principal_coordinate_separation
    (N : NormalizedMutationPattern (Trop I) I V)
    (M : NormalizedMutationPattern P I W)
    (f : TotalLaurentRing (Additive P) I →+* F)
    (hf : ∀ p, positiveCast p ≠ 0 → f (positiveCast p) ≠ 0)
    (s : V) (t : W) (hB : N.matrix s = M.matrix t)
    (hy0 : ∀ i, N.coefficient s i = Trop.generator i)
    (w : List I) (j : I) :
    N.wordCoordinates
        (principalToTarget (principalCoefficientHom (M.coefficient t)) f) s w j =
      (coefficientFieldMap f)
        (principalWordFValue N
          (principalCoefficientHom (M.coefficient t)) s w j) *
        M.wordCoordinates f t w j := by
  let η := principalCoefficientHom (M.coefficient t)
  let g := principalToTarget η f
  let e := coefficientFieldMap f
  induction w using List.reverseRecOn generalizing j with
  | nil =>
      simp only [N.wordCoordinates_nil, M.wordCoordinates_nil]
      rw [principalWordFValue_nil]
      simp [principalToTarget_initialVariables]
  | append_singleton w k ih =>
      by_cases hjk : j = k
      · subst j
        let B := M.matrix (mutateWord M.mutation w t)
        let d : I → P := fun i => principalWordFValue N η s w i
        let x : I → F := M.wordCoordinates f t w
        let n : I → F := N.wordCoordinates g s w
        let y : P := (η (Additive.ofMul
          (N.coefficient (mutateWord N.mutation w s) k))).toMul
        let h : P := (η (Additive.ofMul
          (N.coefficient (mutateWord N.mutation w s) k + 1))).toMul
        let dPlus : P := ∏ i, d i ^ positivePart (B i k)
        let dMinus : P := ∏ i, d i ^ positivePart (-B i k)
        have hm := normalizedPattern_matrix_word_eq N M s t hB w
        have hfactor : ∀ i, n i = e (d i) * x i := by
          intro i
          exact ih i
        have hplus : positiveColumnMonomial n B k =
            e dPlus * positiveColumnMonomial x B k := by
          exact fieldMonomial_factor e d x n hfactor
            (fun i => positivePart (B i k))
        have hminus : negativeColumnMonomial n B k =
            e dMinus * negativeColumnMonomial x B k := by
          exact fieldMonomial_factor e d x n hfactor
            (fun i => positivePart (-B i k))
        have hd := principalWordFValue_mutate_self N η s w k
        have hy := principal_coefficient_separation N M s t hB hy0 w k
        have hx : x k ≠ 0 := by
          change M.wordCoordinates f t w k ≠ 0
          rw [← M.wordExpressions_evaluate f t w k]
          exact expression_evaluate_ne_zero f hf _
        have hnum := normalized_wordCoordinates_mutate_self N g s w k
        have htar := normalized_wordCoordinates_mutate_self M f t w k
        have hdrec : principalWordFValue N η s (w ++ [k]) k =
            (y * dPlus + dMinus) / (h * d k) := by
          rw [hm] at hd
          simpa only [d, y, h, dPlus, dMinus, B] using hd
        have hyrec : M.coefficient (mutateWord M.mutation w t) k =
            y * dPlus / dMinus := by
          rw [coefficientColumnMonomial_eq_ratio] at hy
          simpa only [d, y, dPlus, dMinus, B, mul_div_assoc] using hy
        have hnrec : N.wordCoordinates g s (w ++ [k]) k =
            (e y * positiveColumnMonomial n B k +
              negativeColumnMonomial n B k) /
              (e h * n k) := by
          rw [hm] at hnum
          simpa only [n, g, e, y, h, B, principalToTarget_coefficient]
            using hnum
        have htrec : M.wordCoordinates f t (w ++ [k]) k =
            (e (y * dPlus / dMinus) * positiveColumnMonomial x B k +
              negativeColumnMonomial x B k) /
              (e (y * dPlus / dMinus + 1) * x k) := by
          rw [hyrec] at htar
          simpa only [x, e, B] using htar
        exact principal_coordinate_separation_step e y h dPlus dMinus
          (d k) (principalWordFValue N η s (w ++ [k]) k)
          (positiveColumnMonomial x B k) (negativeColumnMonomial x B k)
          (x k) (M.wordCoordinates f t (w ++ [k]) k)
          (positiveColumnMonomial n B k) (negativeColumnMonomial n B k)
          (n k) (N.wordCoordinates g s (w ++ [k]) k)
          hdrec htrec hnrec hplus hminus (hfactor k) hx
      · rw [principalWordFValue_mutate_other N η s w k j hjk]
        have hN := congrArg (fun z : I → F => z j)
          (N.wordCoordinates_append_single g s w k)
        have hM := congrArg (fun z : I → F => z j)
          (M.wordCoordinates_append_single f t w k)
        rw [hN, hM]
        simpa [mutateCoordinateValues, Function.update_of_ne hjk]
          using ih j

end
end TauCeti.Cluster
