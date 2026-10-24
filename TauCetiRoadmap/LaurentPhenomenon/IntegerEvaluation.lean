/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.CoefficientChart

/-! # Integer Evaluation -/

@[expose] public section

noncomputable section
namespace TauCeti.Laurent
open scoped BigOperators
variable {G I : Type} [AddCommGroup G]

/-- Evaluate every coefficient-group and mutable Laurent monomial at one. -/
def allOnesInteger : TotalLaurentRing G I →+* ℤ :=
  AddMonoidAlgebra.liftNCRingHom (RingHom.id ℤ) 1 (fun _ _ => Commute.all _ _)

/-- The rational-valued augmentation sending every coefficient-group and mutable monomial to one. -/
def allOnes : TotalLaurentRing G I →+* ℚ :=
  (Int.castRingHom ℚ).comp allOnesInteger

@[simp] theorem allOnesInteger_single (t : G × (I →₀ ℤ)) (n : ℤ) :
    allOnesInteger (AddMonoidAlgebra.single t n) = n := by
  simp [allOnesInteger]

@[simp] theorem allOnes_single (t : G × (I →₀ ℤ)) (n : ℤ) :
    allOnes (AddMonoidAlgebra.single t n) = (n : ℚ) := by
  simp [allOnes, RingHom.comp_apply]

/-- The entire universal Laurent ring takes integer values at one. -/
theorem allOnes_mem_integerRange (r : TotalLaurentRing G I) :
    allOnes r ∈ (Int.castRingHom ℚ).range :=
  ⟨allOnesInteger r, rfl⟩

theorem allOnes_positive (p : PositiveLaurent G I)
    (hp : positiveCast p ≠ 0) : allOnes (positiveCast p) ≠ 0 := by
  classical
  have hsum : allOnes (positiveCast p) =
      ((∑ t ∈ p.coeff.support, p.coeff t : ℕ) : ℚ) := by
    conv_lhs => rw [← AddMonoidAlgebra.sum_coeff_single p]
    simp [Finsupp.sum, map_sum, Nat.cast_sum, positiveCast]
  rw [hsum]
  apply Nat.cast_ne_zero.mpr
  intro hz
  apply hp
  have hpzero : p = 0 := by
    apply AddMonoidAlgebra.coeff_injective
    ext t
    by_cases ht : t ∈ p.coeff.support
    · exact (Finset.sum_eq_zero_iff_of_nonneg (fun _ _ => Nat.zero_le _)).mp hz t ht
    · simpa using Finsupp.notMem_support_iff.mp ht
  rw [hpzero, map_zero]

variable [DecidableEq I]
omit [DecidableEq I] in
@[simp] theorem initialVariables_allOnes (i : I) :
    initialVariables (allOnes (G := G)) i = 1 := by
  simp [initialVariables]

variable [IsDomain (TotalLaurentRing G I)]
omit [DecidableEq I] [IsDomain (TotalLaurentRing G I)] in
theorem coefficientRange_allOnes_le :
    coefficientRange (allOnes (G := G) (I := I)) ≤
      (Int.castRingHom ℚ).range := by
  rintro x ⟨r, rfl⟩
  exact allOnes_mem_integerRange _

omit [DecidableEq I] [IsDomain (TotalLaurentRing G I)] in
theorem chartRing_allOnes_le :
    chartRing (coefficientRange (allOnes (G := G) (I := I)))
      (initialVariables (allOnes (G := G) (I := I))) ≤ (Int.castRingHom ℚ).range := by
  apply chartRing_le (coefficientRange_allOnes_le (G := G) (I := I))
  · intro i; simp
  · intro i; simp

end TauCeti.Laurent
