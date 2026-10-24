/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.Chart
public import Mathlib.Algebra.MvPolynomial.Eval

/-! # Exchange Pattern -/

@[expose] public section

namespace TauCeti.Laurent

variable {F I V : Type*} [Field F]

/-- Actual polynomial exchange data, with neither Laurentness nor coprimality assumed. -/
structure PolynomialExchangePattern (C : Subring F) (I V : Type*) where
  /-- The mutable coordinate values at each state of the polynomial exchange pattern. -/
  coord : V → I → F
  coord_ne_zero : ∀ s i, coord s i ≠ 0
  /-- The elementary state mutation in a chosen direction. -/
  mutation : I → V → V
  mutation_involutive : ∀ i, Function.Involutive (mutation i)
  /-- The polynomial numerator governing each state and mutation direction. -/
  exchange : V → I → MvPolynomial I C
  exchange_independent : ∀ s i m, (exchange s i).coeff m ≠ 0 → m i = 0
  other_coord : ∀ s i k, k ≠ i → coord (mutation i s) k = coord s k
  exchange_relation : ∀ s i, coord (mutation i s) i * coord s i =
    MvPolynomial.eval₂ C.subtype (coord s) (exchange s i)

namespace PolynomialExchangePattern

variable {C : Subring F} (P : PolynomialExchangePattern C I V)

theorem exchange_eval_ne_zero (s : V) (i : I) :
    MvPolynomial.eval₂ C.subtype (P.coord s) (P.exchange s i) ≠ 0 := by
  rw [← P.exchange_relation]
  exact mul_ne_zero (P.coord_ne_zero _ i) (P.coord_ne_zero s i)

theorem exchange_ne_zero (s : V) (i : I) : P.exchange s i ≠ 0 := by
  intro h
  apply P.exchange_eval_ne_zero s i
  simp [h]

theorem exchange_formula (s : V) (i : I) :
    P.coord (P.mutation i s) i =
      MvPolynomial.eval₂ C.subtype (P.coord s) (P.exchange s i) / P.coord s i :=
  (eq_div_iff (P.coord_ne_zero s i)).mpr (P.exchange_relation s i)

theorem eval_exchange_mem (s : V) (i : I) (L : Subring F) (hC : C ≤ L)
    (hx : ∀ k, P.coord s k ∈ L) :
    MvPolynomial.eval₂ C.subtype (P.coord s) (P.exchange s i) ∈ L :=
  MvPolynomial.eval₂_mem (fun m _ => hC (P.exchange s i |>.coeff m).property) hx

theorem one_step_mem (s : V) (i k : I) :
    P.coord (P.mutation i s) k ∈ chartRing C (P.coord s) := by
  by_cases hki : k = i
  · subst k
    rw [P.exchange_formula, div_eq_mul_inv]
    exact Subring.mul_mem _
      (P.eval_exchange_mem s i _ (fun _ ha => coefficient_mem_chartRing C _ ha)
        (coordinate_mem_chartRing C _))
      (inverse_mem_chartRing C _ i)
  · rw [P.other_coord s i k hki]
    exact coordinate_mem_chartRing C _ k

theorem two_step_distinct_mem (s : V) (i j k : I) (hij : i ≠ j) :
    P.coord (P.mutation j (P.mutation i s)) k ∈ chartRing C (P.coord s) := by
  by_cases hkj : k = j
  · subst k
    rw [P.exchange_formula, div_eq_mul_inv, P.other_coord s i j hij.symm]
    exact Subring.mul_mem _
      (P.eval_exchange_mem (P.mutation i s) j _
        (fun _ ha => coefficient_mem_chartRing C _ ha) (P.one_step_mem s i))
      (inverse_mem_chartRing C _ j)
  · rw [P.other_coord (P.mutation i s) j k hkj]
    exact P.one_step_mem s i k

theorem two_step_mem (s : V) (i j k : I) :
    P.coord (P.mutation j (P.mutation i s)) k ∈ chartRing C (P.coord s) := by
  by_cases hij : i = j
  · subst j
    rw [P.mutation_involutive i s]
    exact coordinate_mem_chartRing C _ k
  · exact P.two_step_distinct_mem s i j k hij

theorem triple_middle_coord (s : V) (i j : I) (hij : i ≠ j) :
    P.coord (P.mutation i (P.mutation j (P.mutation i s))) j =
      P.coord (P.mutation j (P.mutation i s)) j :=
  P.other_coord _ i j hij.symm

theorem triple_other_coord (s : V) (i j k : I) (hki : k ≠ i) (hkj : k ≠ j) :
    P.coord (P.mutation i (P.mutation j (P.mutation i s))) k = P.coord s k := by
  rw [P.other_coord _ i k hki, P.other_coord _ j k hkj, P.other_coord _ i k hki]

end PolynomialExchangePattern

end TauCeti.Laurent
