/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.FiniteLocalModel

/-!
# Algebraic caterpillar theorem from polynomial certificates
The hypotheses below are identities and relative primality statements on local
polynomial exchange data over arbitrary unique factorization domains. No order,
positivity, binomial shape, exchange matrix, or local Laurent/intersection
conclusion is assumed.
-/

@[expose] public section
namespace TauCeti.Laurent
open Polynomial
open scoped LaurentPolynomial
noncomputable section

namespace RealizedCaterpillar
variable {F I : Type*} [Field F] {C : Subring F} {P : CaterpillarPath I}
variable (R : RealizedCaterpillar C P)

/-- The middle edge between two adjacent internal stars. -/
theorem interior_edge (p : Fin (P.length - 2)) :
    P.Edge (P.spine (P.internalIndex (P.interiorLeft p)))
      (P.spine (P.internalIndex (P.interiorRight p)))
      (P.rightLabel (P.interiorLeft p)) :=
  P.middle_edge p

/-- Local polynomial certificates at precisely the forward configurations used
by finite caterpillar induction. Their fields are exposed by
`RealizedCaterpillar.PolynomialLocalModel`. -/
abbrev ForwardPolynomialModel (p : Fin (P.length - 2)) (i : I)
    (hi : i ≠ P.rightLabel (P.interiorLeft p)) (S : Type*) [CommRing S] :=
  R.PolynomialLocalModel (d := P.starNeighbor (P.interiorRight p) i)
    (P.starNeighbor_edge (P.interiorLeft p) i).symm (interior_edge (P := P) p) hi S

/-- The chart is factorial because its displayed polynomial coefficient ring
is factorial. This is derived, rather than required separately of every chart. -/
theorem PolynomialLocalModel.chart_uniqueFactorizationMonoid
    {a b c d : P.Vertex} {i j : I}
    {hab : P.Edge a b i} {hbc : P.Edge b c j} {hij : i ≠ j}
    {S : Type*} [CommRing S] [UniqueFactorizationMonoid S]
    (M : R.PolynomialLocalModel (d := d) hab hbc hij S) :
    UniqueFactorizationMonoid (chartRing C (R.coord a)) :=
  PolynomialChartModel.chart_uniqueFactorizationMonoid M

/-- Polynomial cancellation and relative primality derive all the local
intersections needed by the finite theorem. -/
theorem forwardLocalIntersections_of_polynomial_models
    (S : Fin (P.length - 2) → I → Type*)
    [∀ p i, CommRing (S p i)] [∀ p i, IsDomain (S p i)]
    [∀ p i, UniqueFactorizationMonoid (S p i)]
    (models : ∀ p i hi, R.ForwardPolynomialModel p i hi (S p i)) :
    R.ForwardLocalIntersections := by
  intro p i hi
  let M := models p i hi
  exact M.intersection (P.starNeighbor_edge (P.interiorRight p) i)

/-- The general algebraic finite caterpillar theorem. Only explicit local
polynomial certificates are inputs; the local intersections and Laurent
membership are proved outputs. -/
theorem target_mem_of_polynomial_models
    (S : Fin (P.length - 2) → I → Type*)
    [∀ p i, CommRing (S p i)] [∀ p i, IsDomain (S p i)]
    [∀ p i, UniqueFactorizationMonoid (S p i)]
    (models : ∀ p i hi, R.ForwardPolynomialModel p i hi (S p i)) (k : I) :
    R.coord P.target k ∈ chartRing C (R.coord P.source) :=
  R.target_mem_of_forwardLocalIntersections
    (R.forwardLocalIntersections_of_polynomial_models S models) k

end RealizedCaterpillar
end
end TauCeti.Laurent
