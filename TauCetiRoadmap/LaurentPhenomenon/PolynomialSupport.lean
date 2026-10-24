/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.LaurentSupport
public import Mathlib.Algebra.Polynomial.AlgebraMap

/-!
# Polynomial evaluations in independent Laurent directions

Relative primality of scalar polynomials on two independent cyclic lattices.
-/

@[expose] public section

namespace TauCeti.Laurent

variable {R I G : Type*} [CommRing R] [AddCommGroup G] [IsAddTorsionFree G]

noncomputable section

omit [IsAddTorsionFree G] in
/-- Evaluating a monomial at a Laurent monomial preserves its coefficient. -/
theorem aeval_single_monomial (a : G) (n : ℕ) (c : R) :
    Polynomial.aeval (AddMonoidAlgebra.single a (1 : R)) (Polynomial.monomial n c) =
      AddMonoidAlgebra.single (n • a) c := by
  simp [Polynomial.aeval_monomial, AddMonoidAlgebra.single_pow]

omit [IsAddTorsionFree G] in
/-- Evaluation at `X^a` has support in the nonnegative multiples of `a`. -/
theorem aeval_single_support (a : G) (p : Polynomial R) :
    ∀ m, (Polynomial.aeval (AddMonoidAlgebra.single a (1 : R)) p).coeff m ≠ 0 →
      ∃ n : ℕ, m = n • a := by
  classical
  induction p using Polynomial.induction_on' with
  | add p q hp hq =>
    intro m hm
    rw [map_add, AddMonoidAlgebra.coeff_add, Finsupp.add_apply] at hm
    by_cases h : (Polynomial.aeval (AddMonoidAlgebra.single a (1 : R)) p).coeff m = 0
    · rw [h, zero_add] at hm
      exact hq m hm
    · exact hp m h
  | monomial n c =>
    intro m hm
    rw [aeval_single_monomial] at hm
    refine ⟨n, ?_⟩
    by_contra h
    exact hm (by simp [AddMonoidAlgebra.coeff_single, Ne.symm h])

/-- A nonzero exponent prevents any positive power from contributing to the constant term. -/
theorem aeval_single_coeff_zero {a : G} (ha : a ≠ 0) (p : Polynomial R) :
    (Polynomial.aeval (AddMonoidAlgebra.single a (1 : R)) p).coeff 0 = p.coeff 0 := by
  classical
  induction p using Polynomial.induction_on' with
  | add p q hp hq =>
    simp only [map_add, AddMonoidAlgebra.coeff_add, Finsupp.add_apply, Polynomial.coeff_add,
      hp, hq]
  | monomial n c =>
    rw [aeval_single_monomial]
    by_cases hn : n = 0
    · subst n
      simp
    · have hna : n • a ≠ 0 := by simp [ha, hn]
      rw [AddMonoidAlgebra.coeff_single, Finsupp.single_eq_of_ne (Ne.symm hna),
        Polynomial.coeff_monomial]
      simp [hn]

/-- Polynomials with constant coefficient one on independent directions are relatively prime. -/
theorem isRelPrime_aeval_single [IsDomain R] {a b : I →₀ ℤ}
    (hab : LinearIndependent ℤ ![a, b]) {p q : Polynomial R}
    (hp : p.coeff 0 = 1) (hq : q.coeff 0 = 1) :
    IsRelPrime (Polynomial.aeval (AddMonoidAlgebra.single a (1 : R)) p)
      (Polynomial.aeval (AddMonoidAlgebra.single b (1 : R)) q) := by
  have ha : a ≠ 0 := hab.ne_zero 0
  have hb : b ≠ 0 := hab.ne_zero 1
  refine isRelPrime_of_support_zmultiples hab (fun m hm ↦ ?_) (fun m hm ↦ ?_)
    ⟨0, ?_⟩ ?_
  · obtain ⟨n, rfl⟩ := aeval_single_support a p m (Finsupp.mem_support_iff.mp hm)
    exact AddSubgroup.nsmul_mem _ (AddSubgroup.mem_zmultiples a) n
  · obtain ⟨n, rfl⟩ := aeval_single_support b q m (Finsupp.mem_support_iff.mp hm)
    exact AddSubgroup.nsmul_mem _ (AddSubgroup.mem_zmultiples b) n
  · rw [aeval_single_coeff_zero ha, hp]
    exact isUnit_one
  · intro h
    have hc := aeval_single_coeff_zero (R := R) hb q
    rw [h] at hc
    change (0 : R) = q.coeff 0 at hc
    rw [hq] at hc
    exact zero_ne_one hc

end
end TauCeti.Laurent
