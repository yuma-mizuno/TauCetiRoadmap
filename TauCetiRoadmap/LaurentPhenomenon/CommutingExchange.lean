/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.OneExchangeBase
public import TauCetiRoadmap.LaurentPhenomenon.FlatDivisibility
public import Mathlib.RingTheory.UniqueFactorizationDomain.Basic

/-! Coefficient divisibility in two commuting exchange directions. This is
the algebraic four-quadrant calculation underlying the zero-interaction case. -/

@[expose] public section

noncomputable section
namespace TauCeti.Laurent.CommutingExchange
open OneExchange

variable {D G : Type*} [CommRing D] [AddCommGroup G]

/-- Divisibility along an integer weight, retained coefficient by coefficient. -/
def weightDivisibleRing (E : D) (w : G →+ ℤ) : Subring (AddMonoidAlgebra D G) where
  carrier := {p | ∀ a, E ^ poleOrder (w a) ∣ p.coeff a}
  zero_mem' := by intro a; exact dvd_zero _
  one_mem' := by
    classical
    intro a
    have hcoeff : (1 : AddMonoidAlgebra D G).coeff a = if a = 0 then 1 else 0 := by
      change (Finsupp.single 0 (1 : D)) a = _
      simp only [Finsupp.single_apply, eq_comm]
    rw [hcoeff]
    by_cases ha : a = 0
    · subst a; simp [poleOrder]
    · simp [ha]
  add_mem' := by
    intro p q hp hq a
    simpa using dvd_add (hp a) (hq a)
  neg_mem' := by
    intro p hp a
    simpa using dvd_neg.mpr (hp a)
  mul_mem' := by
    intro p q hp hq a
    classical
    rw [AddMonoidAlgebra.coeff_mul]
    change E ^ poleOrder (w a) ∣ ∑ i ∈ p.coeff.support,
      ∑ j ∈ q.coeff.support, if i + j = a then p.coeff i * q.coeff j else 0
    apply Finset.dvd_sum
    intro i hi
    apply Finset.dvd_sum
    intro j hj
    split_ifs with hij
    · have hpower : E ^ poleOrder (w a) ∣ E ^ (poleOrder (w i) + poleOrder (w j)) := by
        apply pow_dvd_pow E
        rw [← hij, map_add]
        exact poleOrder_add_le (w i) (w j)
      exact hpower.trans (by rw [pow_add]; exact mul_dvd_mul (hp i) (hq j))
    · exact dvd_zero _

theorem single_mem_weightDivisibleRing (E : D) (w : G →+ ℤ) (a : G) (r : D)
    (hr : E ^ poleOrder (w a) ∣ r) :
    AddMonoidAlgebra.single a r ∈ weightDivisibleRing E w := by
  intro b
  by_cases hab : a = b
  · subst b; simpa using hr
  · simp [hab]

/-- The coefficient ring's group algebra on the two-dimensional integer exponent lattice. -/
abbrev BiLaurent (D : Type*) [CommRing D] := AddMonoidAlgebra D (ℤ × ℤ)

/-- The four exchange generators and the coefficient ring. -/
def exchangeRing (E F : D) : Subring (BiLaurent D) :=
  Subring.closure (Set.range (fun a : D => AddMonoidAlgebra.single (0, 0) a) ∪
    {AddMonoidAlgebra.single (1, 0) 1, AddMonoidAlgebra.single (-1, 0) E,
     AddMonoidAlgebra.single (0, 1) 1, AddMonoidAlgebra.single (0, -1) F})

theorem coefficient_mem (E F a : D) :
    AddMonoidAlgebra.single (0, 0) a ∈ exchangeRing E F :=
  Subring.subset_closure (Or.inl ⟨a, rfl⟩)

theorem x_mem (E F : D) : AddMonoidAlgebra.single (1, 0) (1 : D) ∈ exchangeRing E F :=
  Subring.subset_closure (Or.inr (by simp))
theorem xs_mem (E F : D) : AddMonoidAlgebra.single (-1, 0) E ∈ exchangeRing E F :=
  Subring.subset_closure (Or.inr (by simp))
theorem y_mem (E F : D) : AddMonoidAlgebra.single (0, 1) (1 : D) ∈ exchangeRing E F :=
  Subring.subset_closure (Or.inr (by simp))
theorem ys_mem (E F : D) : AddMonoidAlgebra.single (0, -1) F ∈ exchangeRing E F :=
  Subring.subset_closure (Or.inr (by simp))

theorem x_monomial_mem (E F : D) (m : ℤ) :
    AddMonoidAlgebra.single (m, 0) (E ^ poleOrder m) ∈ exchangeRing E F := by
  cases m with
  | ofNat n =>
    simpa [AddMonoidAlgebra.single_pow, poleOrder] using
      (exchangeRing E F).pow_mem (x_mem E F) n
  | negSucc n =>
    simpa [AddMonoidAlgebra.single_pow, poleOrder, Int.negSucc_eq] using
      (exchangeRing E F).pow_mem (xs_mem E F) (n + 1)

theorem y_monomial_mem (E F : D) (n : ℤ) :
    AddMonoidAlgebra.single (0, n) (F ^ poleOrder n) ∈ exchangeRing E F := by
  cases n with
  | ofNat n =>
    simpa [AddMonoidAlgebra.single_pow, poleOrder] using
      (exchangeRing E F).pow_mem (y_mem E F) n
  | negSucc n =>
    simpa [AddMonoidAlgebra.single_pow, poleOrder, Int.negSucc_eq] using
      (exchangeRing E F).pow_mem (ys_mem E F) (n + 1)

/-- Reconstruction of all four exponent quadrants in a single formula. -/
theorem single_mem_exchangeRing (E F : D) (m n : ℤ) (a : D)
    (ha : E ^ poleOrder m * F ^ poleOrder n ∣ a) :
    AddMonoidAlgebra.single (m, n) a ∈ exchangeRing E F := by
  obtain ⟨b, rfl⟩ := ha
  have h := (exchangeRing E F).mul_mem
    ((exchangeRing E F).mul_mem (x_monomial_mem E F m) (y_monomial_mem E F n))
    (coefficient_mem E F b)
  simpa [AddMonoidAlgebra.single_mul_single] using h

/-- Combining the two divisibility conditions needs relative primality, not
the stronger Bezout property. -/
theorem mem_exchangeRing_of_divisibility [DecompositionMonoid D]
    (E F : D) (hEF : IsRelPrime E F) (p : BiLaurent D)
    (hE : p ∈ weightDivisibleRing E (AddMonoidHom.fst ℤ ℤ))
    (hF : p ∈ weightDivisibleRing F (AddMonoidHom.snd ℤ ℤ)) :
    p ∈ exchangeRing E F := by
  classical
  rw [← AddMonoidAlgebra.sum_coeff_single p, Finsupp.sum]
  apply (exchangeRing E F).sum_mem
  intro a ha
  apply single_mem_exchangeRing E F a.1 a.2 (p.coeff a)
  exact TauCeti.Module.algebraMap_mul_dvd_of_relPrime
    (R := D) (A := D) hEF.pow (hE a) (hF a)

theorem exchangeRing_le_fst (E F : D) :
    exchangeRing E F ≤ weightDivisibleRing E (AddMonoidHom.fst ℤ ℤ) := by
  apply Subring.closure_le.mpr
  rintro z (⟨a, rfl⟩ | hz)
  · apply single_mem_weightDivisibleRing
    simp [poleOrder]
  · simp only [Set.mem_insert_iff, Set.mem_singleton_iff] at hz
    rcases hz with rfl | rfl | rfl | rfl
    all_goals (apply single_mem_weightDivisibleRing; simp [poleOrder])

theorem exchangeRing_le_snd (E F : D) :
    exchangeRing E F ≤ weightDivisibleRing F (AddMonoidHom.snd ℤ ℤ) := by
  apply Subring.closure_le.mpr
  rintro z (⟨a, rfl⟩ | hz)
  · apply single_mem_weightDivisibleRing
    simp [poleOrder]
  · simp only [Set.mem_insert_iff, Set.mem_singleton_iff] at hz
    rcases hz with rfl | rfl | rfl | rfl
    all_goals (apply single_mem_weightDivisibleRing; simp [poleOrder])

theorem exchangeRing_mono {E F E' F' : D} (hE : E' ∣ E) (hF : F' ∣ F) :
    exchangeRing E F ≤ exchangeRing E' F' := by
  apply Subring.closure_le.mpr
  rintro z (⟨a, rfl⟩ | hz)
  · exact coefficient_mem E' F' a
  · simp only [Set.mem_insert_iff, Set.mem_singleton_iff] at hz
    rcases hz with rfl | rfl | rfl | rfl
    · exact x_mem E' F'
    · apply single_mem_exchangeRing
      simpa [poleOrder] using hE
    · exact y_mem E' F'
    · apply single_mem_exchangeRing
      simpa [poleOrder] using hF

/-- L2a in the bivariate Laurent ring. Setting one exchange factor to `1`
inverts that coordinate; the other coordinate retains its exchange relation. -/
theorem commuting_intersection [DecompositionMonoid D]
    (E F : D) (hEF : IsRelPrime E F) :
    exchangeRing E 1 ⊓ exchangeRing 1 F = exchangeRing E F := by
  apply le_antisymm
  · rintro p ⟨hE, hF⟩
    exact mem_exchangeRing_of_divisibility E F hEF p
      (exchangeRing_le_fst E 1 hE) (exchangeRing_le_snd 1 F hF)
  · exact le_inf (exchangeRing_mono dvd_rfl (one_dvd _))
      (exchangeRing_mono (one_dvd _) dvd_rfl)

/-- Transport the commuting intersection to any faithful realization. -/
theorem commuting_intersection_map {A : Type*} [CommRing A] [DecompositionMonoid D]
    (E F : D) (hEF : IsRelPrime E F) (φ : BiLaurent D →+* A)
    (hφ : Function.Injective φ) :
    (exchangeRing E 1).map φ ⊓ (exchangeRing 1 F).map φ = (exchangeRing E F).map φ := by
  rw [← Subring.map_inf _ _ φ hφ, commuting_intersection E F hEF]

end TauCeti.Laurent.CommutingExchange
