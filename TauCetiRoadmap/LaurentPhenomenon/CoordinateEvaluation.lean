/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.PositiveRealization

/-! # Coordinate Evaluation -/

@[expose] public section

noncomputable section
namespace TauCeti.Laurent
open scoped BigOperators
variable {G I F : Type*} [AddCommGroup G] [DecidableEq I] [Field F]
variable (f : AddMonoidAlgebra ℤ (G × (I →₀ ℤ)) →+* F)

omit [DecidableEq I] in
theorem coordinateEvaluate_add (E R : PositiveLaurent G I) (x : I → F) :
    coordinateEvaluate f (E + R) x =
      coordinateEvaluate f E x + coordinateEvaluate f R x := by
  classical
  unfold coordinateEvaluate
  change (E.coeff + R.coeff).sum (fun t n =>
    f (positiveCast (AddMonoidAlgebra.single (t.1, 0) n)) *
      ∏ i ∈ t.2.support, x i ^ t.2 i) = _
  apply Finsupp.sum_add_index
  · intro t
    simp
  · intro t a b
    simp [AddMonoidAlgebra.single_add, add_mul]

omit [DecidableEq I] in
theorem coordinateEvaluate_single (g : G) (a : I →₀ ℤ) (n : ℕ) (x : I → F) :
    coordinateEvaluate f (AddMonoidAlgebra.single (g, a) n) x =
      f (positiveCast (AddMonoidAlgebra.single (g, 0) n)) *
        ∏ i ∈ a.support, x i ^ a i := by
  classical
  unfold coordinateEvaluate
  change (Finsupp.single (g, a) n).sum (fun t m =>
    f (positiveCast (AddMonoidAlgebra.single (t.1, 0) m)) *
      ∏ i ∈ t.2.support, x i ^ t.2 i) = _
  rw [Finsupp.sum_single_index]
  simp

omit [DecidableEq I] in
theorem coordinateEvaluate_single_one [Fintype I]
    (g : G) (a : I →₀ ℤ) (x : I → F)
    (hg : f (AddMonoidAlgebra.single (g, 0) 1) = 1) :
    coordinateEvaluate f (AddMonoidAlgebra.single (g, a) 1) x =
      ∏ i, x i ^ a i := by
  rw [coordinateEvaluate_single]
  have hc : positiveCast (AddMonoidAlgebra.single (g, (0 : I →₀ ℤ)) 1) =
      AddMonoidAlgebra.single (g, 0) 1 := by simp [positiveCast]
  rw [hc, hg, one_mul]
  apply Finset.prod_subset (Finset.subset_univ _)
  intro i _ hi
  simp [Finsupp.notMem_support_iff.mp hi]

end TauCeti.Laurent
