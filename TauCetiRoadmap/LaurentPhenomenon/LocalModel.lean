/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.FactorialTheorem
public import TauCetiRoadmap.LaurentPhenomenon.PolynomialChartModel

/-!
# Polynomial certificates for the local caterpillar step

A local model records the polynomial exchange data after separating out the
first coordinate. It contains the two relative-primality hypotheses on exchange
data, not relative primality or Laurentness of the resulting third coordinate.
-/

@[expose] public section

namespace TauCeti.Laurent

open Polynomial
open scoped LaurentPolynomial

noncomputable section

namespace PolynomialExchangePattern

variable {F I V : Type*} [Field F] {C : Subring F}
variable (P : PolynomialExchangePattern C I V)

/-- The three-edge polynomial chart certificate for the i,j,i mutation sequence based at s. -/
abbrev PolynomialLocalModel (s : V) (i j : I) (S : Type*) [CommRing S] :=
  PolynomialChartModel (chartRing C (P.coord s))
    ⟨P.coord (P.mutation i s) i, P.one_step_mem s i i⟩
    ⟨P.coord (P.mutation j (P.mutation i s)) j, P.two_step_mem s i j j⟩
    (P.coord (P.mutation i (P.mutation j (P.mutation i s))) i) S

namespace PolynomialLocalModel

variable {P} {s : V} {i j : I} {S : Type*} [CommRing S]
variable [IsDomain S] [UniqueFactorizationMonoid S]

/-- Polynomial cancellation constructs the missing coordinate in the chart and
proves both coordinate coprimality claims. -/
theorem coordinateCertificate (M : P.PolynomialLocalModel s i j S) :
    P.LocalCoordinateCertificate s i j :=
  PolynomialChartModel.third_mem_and_relPrime M (P.coord_ne_zero (P.mutation i s) i)

end PolynomialLocalModel

/-- The factorial caterpillar mechanism with explicit polynomial local models.
The positive-deformation theorem must construct these models; none is provided
implicitly by the definition of `PolynomialExchangePattern`. -/
theorem laurent_of_polynomial_local_models
    (S : V → I → I → Type*) [∀ s i j, CommRing (S s i j)]
    [∀ s i j, IsDomain (S s i j)] [∀ s i j, UniqueFactorizationMonoid (S s i j)]
    (models : ∀ s i j, i ≠ j → P.PolynomialLocalModel s i j (S s i j))
    (w : List I) (s : V) (k : I) :
    P.coord (mutateWord P.mutation w s) k ∈ chartRing C (P.coord s) := by
  apply laurent_of_local_intersections P.mutation P.mutation_involutive
    (fun t => chartRing C (P.coord t)) P.coord
    (fun t l => coordinate_mem_chartRing C (P.coord t) l) P.one_step_mem
    ?_ w s k
  intro t i j hij
  let M := models t i j hij
  let := PolynomialChartModel.chart_uniqueFactorizationMonoid M
  exact P.local_intersection_of_local_coordinates t i j hij M.coordinateCertificate

end PolynomialExchangePattern
end
end TauCeti.Laurent
