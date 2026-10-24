/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.PrincipalCoefficients

/-!
# The universal subtraction-free Y-pattern

The ordinary-addition Y-recurrence is built as a positive expression.  Its
evaluation in any coefficient semifield follows the normalized coefficient
mutation word by word.  No cluster-coordinate Laurentness is used.
-/

@[expose] public section

namespace TauCeti.Cluster
open TauCeti.Laurent
noncomputable section

variable {G I P : Type*} [AddCommGroup G] [DecidableEq I]
  [CoefficientSemifield P]

/-- An exchange matrix and a tuple of finite positive coefficient expressions. -/
structure UniversalYSeed (G I : Type*) [AddCommGroup G] where
  /-- The exchange matrix controlling mutation of the universal coefficient expressions. -/
  matrix : I → I → ℤ
  /-- The finite positive expression representing each coefficient. -/
  coefficient : I → PositiveExpression G

namespace UniversalYSeed

/-- Mutate the matrix and apply the coefficient mutation rule to the positive expressions. -/
def mutate (k : I) (s : UniversalYSeed G I) : UniversalYSeed G I where
  matrix := matrixMutation s.matrix k
  coefficient j := if j = k then .inv (s.coefficient k) else
    .mul (.mul (s.coefficient j)
      (PositiveExpression.powInt (s.coefficient k)
        (positivePart (s.matrix k j))))
      (PositiveExpression.powInt (.add (s.coefficient k) (PositiveExpression.one (G := G)))
        (-(s.matrix k j)))

theorem evaluate_mutate (η : G →+ Additive P)
    (s : UniversalYSeed G I) (k j : I) :
    positiveExpressionEvaluateAt η ((s.mutate k).coefficient j) =
      if j = k then (positiveExpressionEvaluateAt η (s.coefficient k))⁻¹ else
        coefficientMutation (positiveExpressionEvaluateAt η (s.coefficient j))
          (positiveExpressionEvaluateAt η (s.coefficient k))
          (positiveExpressionEvaluateAt η (s.coefficient k) + 1)
          (s.matrix k j) := by
  by_cases hj : j = k
  · simp [mutate, hj, positiveExpressionEvaluateAt_inv]
  · simp [mutate, hj, coefficientMutation,
      positiveExpressionEvaluateAt_mul, positiveExpressionEvaluateAt_add,
      positiveExpressionEvaluateAt_powInt, positiveExpressionEvaluateAt_one]

/-- Evaluating the universal ordinary-addition recurrence in `P` gives the
actual coefficient mutation at every step of every finite word. -/
theorem evaluate_word {d : I → ℤ} (hd : ∀ i, 0 < d i)
    (η : G →+ Additive P) (v : UniversalYSeed G I) (s : MatrixSeed P I d)
    (hm : v.matrix = s.matrix)
    (hy : ∀ j, positiveExpressionEvaluateAt η (v.coefficient j) = s.coefficient j)
    (w : List I) :
    (mutateWord UniversalYSeed.mutate w v).matrix =
        (mutateWord (MatrixSeed.mutate hd) w s).matrix ∧
      ∀ j, positiveExpressionEvaluateAt η
        ((mutateWord UniversalYSeed.mutate w v).coefficient j) =
          (mutateWord (MatrixSeed.mutate hd) w s).coefficient j := by
  induction w generalizing v s with
  | nil => exact ⟨hm, hy⟩
  | cons k w ih =>
      apply ih (v.mutate k) (s.mutate hd k)
      · simpa [UniversalYSeed.mutate, MatrixSeed.mutate] using
          congrArg (fun B => matrixMutation B k) hm
      · intro j
        rw [evaluate_mutate]
        by_cases hj : j = k
        · subst j
          simp [MatrixSeed.mutate, hy]
        · simp [MatrixSeed.mutate, hj, hy, hm]

end UniversalYSeed

/-- The universal Y-seed whose coefficients are the independent principal tropical generators. -/
def principalYInitial (B : I → I → ℤ) :
    UniversalYSeed (Additive (Trop I)) I where
  matrix := B
  coefficient i := .atom
    (AddMonoidAlgebra.single (Additive.ofMul (Trop.generator i)) 1)
    (AddMonoidAlgebra.single_eq_zero.not.mpr one_ne_zero)

/-- The universal Y-expression evaluated at arbitrary initial coefficients is
the coefficient of the actual normalized seed after the same mutation word. -/
theorem principalY_word_specialization {d : I → ℤ} (hd : ∀ i, 0 < d i)
    (s : MatrixSeed P I d) (w : List I) (j : I) :
    positiveExpressionEvaluateAt (principalCoefficientHom s.coefficient)
      ((mutateWord UniversalYSeed.mutate w
        (principalYInitial s.matrix)).coefficient j) =
      (mutateWord (MatrixSeed.mutate hd) w s).coefficient j := by
  have h := UniversalYSeed.evaluate_word hd
    (principalCoefficientHom s.coefficient) (principalYInitial s.matrix) s rfl
    (by
      intro i
      simpa [principalYInitial] using
        (positiveExpressionEvaluateAt_atom_single
          (principalCoefficientHom s.coefficient)
          (Additive.ofMul (Trop.generator i))).trans
            (congrArg Additive.toMul
              (principalCoefficientHom_generator s.coefficient i))) w
  exact h.2 j

end
end TauCeti.Cluster
