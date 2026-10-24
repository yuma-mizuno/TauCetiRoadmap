/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.ExchangePattern
public import TauCetiRoadmap.LaurentPhenomenon.Intersection
public import TauCetiRoadmap.LaurentPhenomenon.Mutation

/-! # Factorial Theorem -/

@[expose] public section

namespace TauCeti.Laurent

namespace PolynomialExchangePattern

variable {F I V : Type*} [Field F] {C : Subring F}
variable (P : PolynomialExchangePattern C I V)

/-- The intermediate local data still to be discharged by polynomial cancellation.
Only the third exchanged coordinate requires a membership witness: membership
of the first two is already proved from the polynomial exchange relations. -/
def LocalCoordinateCertificate (s : V) (i j : I) : Prop :=
  ∃ hv : P.coord (P.mutation i (P.mutation j (P.mutation i s))) i ∈
      chartRing C (P.coord s),
    IsRelPrime
      (⟨P.coord (P.mutation i s) i, P.one_step_mem s i i⟩ : chartRing C (P.coord s))
      (⟨P.coord (P.mutation j (P.mutation i s)) j,
        P.two_step_mem s i j j⟩ : chartRing C (P.coord s)) ∧
    IsRelPrime
      (⟨P.coord (P.mutation i s) i, P.one_step_mem s i i⟩ : chartRing C (P.coord s))
      (⟨P.coord (P.mutation i (P.mutation j (P.mutation i s))) i, hv⟩ :
        chartRing C (P.coord s))

theorem local_intersection_of_local_coordinates
    (s : V) (i j : I) (hij : i ≠ j)
    [DecompositionMonoid (chartRing C (P.coord s))]
    (h : P.LocalCoordinateCertificate s i j) :
    chartRing C (P.coord (P.mutation i s)) ⊓
      chartRing C (P.coord (P.mutation i (P.mutation j (P.mutation i s)))) ≤
        chartRing C (P.coord s) := by
  obtain ⟨hv, hzu, hzv⟩ := h
  exact local_chart_intersection C (P.coord s) (P.coord (P.mutation i s))
    (P.coord (P.mutation i (P.mutation j (P.mutation i s)))) i j
    ⟨_, P.one_step_mem s i i⟩ ⟨_, P.two_step_mem s i j j⟩ ⟨_, hv⟩
    (P.coord_ne_zero _ i) (P.coord_ne_zero _ j) (P.coord_ne_zero _ i)
    hzu hzv rfl (P.other_coord s i) rfl (P.triple_middle_coord s i j hij)
    (P.triple_other_coord s i j)

/-- All-word Laurentness from the explicit local coordinate certificates.
This is an intermediate theorem, not an assertion that such certificates exist
for every polynomial exchange pattern. -/
theorem laurent_of_local_coordinates
    [∀ s, DecompositionMonoid (chartRing C (P.coord s))]
    (hlocal : ∀ s i j, i ≠ j → P.LocalCoordinateCertificate s i j)
    (w : List I) (s : V) (k : I) :
    P.coord (mutateWord P.mutation w s) k ∈ chartRing C (P.coord s) := by
  exact laurent_of_local_intersections P.mutation P.mutation_involutive
    (fun t => chartRing C (P.coord t)) P.coord
    (fun t l => coordinate_mem_chartRing C (P.coord t) l) P.one_step_mem
    (fun t i j hij => P.local_intersection_of_local_coordinates t i j hij
      (hlocal t i j hij)) w s k

end PolynomialExchangePattern

end TauCeti.Laurent
