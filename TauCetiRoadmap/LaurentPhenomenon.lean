/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.ExchangeRings
public import TauCetiRoadmap.LaurentPhenomenon.MatrixColumns
public import TauCetiRoadmap.LaurentPhenomenon.UpperBoundPattern
public import TauCetiRoadmap.LaurentPhenomenon.DenominatorPatching
public import TauCetiRoadmap.LaurentPhenomenon.PolynomialExchange
public import TauCetiRoadmap.LaurentPhenomenon.FlatDivisibility
public import TauCetiRoadmap.LaurentPhenomenon.PolynomialSupport
public import TauCetiRoadmap.LaurentPhenomenon.Quantum.PolynomialDivisibility
public import TauCetiRoadmap.LaurentPhenomenon.Quantum.ChangeChart
public import TauCetiRoadmap.LaurentPhenomenon.Quantum.ScaledMonomial
public import TauCetiRoadmap.LaurentPhenomenon.FiniteExchangeReplacement
public import TauCetiRoadmap.LaurentPhenomenon.OrderedExchange
public import TauCetiRoadmap.LaurentPhenomenon.LaurentChart
public import TauCetiRoadmap.LaurentPhenomenon.LaurentReindex
public import TauCetiRoadmap.LaurentPhenomenon.CoefficientRing
public import TauCetiRoadmap.LaurentPhenomenon.Birational
public import TauCetiRoadmap.LaurentPhenomenon.AlgebraicCaterpillar
public import TauCetiRoadmap.LaurentPhenomenon.LocalModel
public import TauCetiRoadmap.LaurentPhenomenon.FiniteLaurent
public import TauCetiRoadmap.LaurentPhenomenon.PositivePoint
public import TauCetiRoadmap.LaurentPhenomenon.Recurrence
public import TauCetiRoadmap.LaurentPhenomenon.SkewPatching
public import TauCetiRoadmap.LaurentPhenomenon.SkewExchange
public import TauCetiRoadmap.LaurentPhenomenon.SkewReplacement
public import TauCetiRoadmap.LaurentPhenomenon.Quantum.Torus
public import TauCetiRoadmap.LaurentPhenomenon.Quantum.Monomial
public import TauCetiRoadmap.LaurentPhenomenon.Quantum.Lift
public import TauCetiRoadmap.LaurentPhenomenon.Quantum.LiftMonomial
public import TauCetiRoadmap.LaurentPhenomenon.Quantum.Specialization
public import TauCetiRoadmap.LaurentPhenomenon.Quantum.Domain
public import TauCetiRoadmap.LaurentPhenomenon.Quantum.Ore
public import TauCetiRoadmap.LaurentPhenomenon.Quantum.CentralDivisibility
public import TauCetiRoadmap.LaurentPhenomenon.Quantum.Coefficients
public import TauCetiRoadmap.LaurentPhenomenon.Quantum.Subalgebra
public import TauCetiRoadmap.LaurentPhenomenon.Quantum.Chart
public import TauCetiRoadmap.LaurentPhenomenon.Quantum.Support
public import TauCetiRoadmap.LaurentPhenomenon.Quantum.Center
public import TauCetiRoadmap.LaurentPhenomenon.Quantum.LatticeBasis
public import TauCetiRoadmap.LaurentPhenomenon.Quantum.Sign
public import TauCetiRoadmap.LaurentPhenomenon.FreeDivisibility
public import TauCetiRoadmap.LaurentPhenomenon.PolynomialDescent
public import TauCetiRoadmap.LaurentPhenomenon.LaurentRegroup
public import TauCetiRoadmap.LaurentPhenomenon.MixedLaurent

/-!
# Laurent phenomena

The library has no dependency on exchange matrices or coefficient semifields.
`LaurentEvaluation` supplies Laurent polynomials over any commutative ring,
evaluation at units, change of coefficients and reindexing.
`PolynomialChartModel` is the shared local cancellation certificate used by both
global polynomial exchange patterns and finite realized caterpillars.
`PositiveCaterpillar` constructs its universal deformation and discharges these
certificates, giving Laurentness without coprimality assumptions on input data.
`PositiveExpression.DefinedAt` permits specialization whenever the inversions
actually used by a finite expression are defined.

Examples and axiom audits are separate modules; this entry point imports no tests.
-/

@[expose] public section
