/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
import TauCetiRoadmap.ClusterAlgebras
import TauCetiRoadmap.ClusterAlgebras.ChartSpecialization
import TauCetiRoadmap.ClusterAlgebras.Coefficients
import TauCetiRoadmap.ClusterAlgebras.CommutingCoprimality
import TauCetiRoadmap.ClusterAlgebras.CoordinateSeparation
import TauCetiRoadmap.ClusterAlgebras.Examples.CaterpillarChecks
import TauCetiRoadmap.ClusterAlgebras.Examples.InitialSeedConsumer
import TauCetiRoadmap.ClusterAlgebras.Examples.PolynomialQuantum
import TauCetiRoadmap.ClusterAlgebras.Examples.PolynomialSeedChecks
import TauCetiRoadmap.ClusterAlgebras.Examples.QuantumChecks
import TauCetiRoadmap.ClusterAlgebras.Examples.Somos4
import TauCetiRoadmap.ClusterAlgebras.Examples.Somos4Audit
import TauCetiRoadmap.ClusterAlgebras.Examples.Somos4Pattern
import TauCetiRoadmap.ClusterAlgebras.Examples.Somos4Sequence
import TauCetiRoadmap.ClusterAlgebras.ExchangeMatrix
import TauCetiRoadmap.ClusterAlgebras.ExpressionCoordinates
import TauCetiRoadmap.ClusterAlgebras.ExtendedRank
import TauCetiRoadmap.ClusterAlgebras.FrozenWeight
import TauCetiRoadmap.ClusterAlgebras.GeometricClusterAlgebra
import TauCetiRoadmap.ClusterAlgebras.GeometricCommuting
import TauCetiRoadmap.ClusterAlgebras.GeometricCoordinates
import TauCetiRoadmap.ClusterAlgebras.GeometricExchangePair
import TauCetiRoadmap.ClusterAlgebras.GeometricInteracting
import TauCetiRoadmap.ClusterAlgebras.GeometricLaurent
import TauCetiRoadmap.ClusterAlgebras.GeometricLaurentBase
import TauCetiRoadmap.ClusterAlgebras.GeometricSeed
import TauCetiRoadmap.ClusterAlgebras.HatY
import TauCetiRoadmap.ClusterAlgebras.InitialLaurent
import TauCetiRoadmap.ClusterAlgebras.InitialSeed
import TauCetiRoadmap.ClusterAlgebras.Laurent
import TauCetiRoadmap.ClusterAlgebras.LaurentFaithfulness
import TauCetiRoadmap.ClusterAlgebras.MatrixConvention
import TauCetiRoadmap.ClusterAlgebras.MatrixMutation
import TauCetiRoadmap.ClusterAlgebras.MutationPattern
import TauCetiRoadmap.ClusterAlgebras.Normalization
import TauCetiRoadmap.ClusterAlgebras.NormalizedCaterpillar
import TauCetiRoadmap.ClusterAlgebras.NormalizedPattern
import TauCetiRoadmap.ClusterAlgebras.NormalizedWord
import TauCetiRoadmap.ClusterAlgebras.PolynomialGeometricPattern
import TauCetiRoadmap.ClusterAlgebras.PolynomialQuantumAlgebra
import TauCetiRoadmap.ClusterAlgebras.PolynomialQuantumCentralFactors
import TauCetiRoadmap.ClusterAlgebras.PolynomialQuantumClassical
import TauCetiRoadmap.ClusterAlgebras.PolynomialQuantumCoefficients
import TauCetiRoadmap.ClusterAlgebras.PolynomialQuantumCommuting
import TauCetiRoadmap.ClusterAlgebras.PolynomialQuantumDefects
import TauCetiRoadmap.ClusterAlgebras.PolynomialQuantumInteracting
import TauCetiRoadmap.ClusterAlgebras.PolynomialQuantumInvolutive
import TauCetiRoadmap.ClusterAlgebras.PolynomialQuantumLaurent
import TauCetiRoadmap.ClusterAlgebras.PolynomialQuantumLocalVectors
import TauCetiRoadmap.ClusterAlgebras.PolynomialQuantumMutation
import TauCetiRoadmap.ClusterAlgebras.PolynomialQuantumOpposite
import TauCetiRoadmap.ClusterAlgebras.PolynomialQuantumPair
import TauCetiRoadmap.ClusterAlgebras.PolynomialQuantumReplacement
import TauCetiRoadmap.ClusterAlgebras.PolynomialQuantumSeed
import TauCetiRoadmap.ClusterAlgebras.PolynomialQuantumSpecialization
import TauCetiRoadmap.ClusterAlgebras.PolynomialQuantumTerms
import TauCetiRoadmap.ClusterAlgebras.PositiveSemifieldEvaluation
import TauCetiRoadmap.ClusterAlgebras.PrincipalCoefficients
import TauCetiRoadmap.ClusterAlgebras.PrincipalGeometricComparison
import TauCetiRoadmap.ClusterAlgebras.PrincipalLaurent
import TauCetiRoadmap.ClusterAlgebras.PrincipalRank
import TauCetiRoadmap.ClusterAlgebras.PrincipalSeparation
import TauCetiRoadmap.ClusterAlgebras.QuantumAlgebra
import TauCetiRoadmap.ClusterAlgebras.QuantumCentralFactors
import TauCetiRoadmap.ClusterAlgebras.QuantumClassicalLimit
import TauCetiRoadmap.ClusterAlgebras.QuantumCommuting
import TauCetiRoadmap.ClusterAlgebras.QuantumCompatible
import TauCetiRoadmap.ClusterAlgebras.QuantumExpansion
import TauCetiRoadmap.ClusterAlgebras.QuantumInteracting
import TauCetiRoadmap.ClusterAlgebras.QuantumLaurent
import TauCetiRoadmap.ClusterAlgebras.QuantumPair
import TauCetiRoadmap.ClusterAlgebras.QuantumPairChart
import TauCetiRoadmap.ClusterAlgebras.QuantumPolynomial
import TauCetiRoadmap.ClusterAlgebras.QuantumRealization
import TauCetiRoadmap.ClusterAlgebras.QuantumReplacement
import TauCetiRoadmap.ClusterAlgebras.QuantumSeed
import TauCetiRoadmap.ClusterAlgebras.QuantumSeedDivision
import TauCetiRoadmap.ClusterAlgebras.QuantumSeedSign
import TauCetiRoadmap.ClusterAlgebras.QuantumSpecialization
import TauCetiRoadmap.ClusterAlgebras.QuantumSubsetRing
import TauCetiRoadmap.ClusterAlgebras.QuantumSupport
import TauCetiRoadmap.ClusterAlgebras.SeedBinomial
import TauCetiRoadmap.ClusterAlgebras.SeedCompatibility
import TauCetiRoadmap.ClusterAlgebras.SeedCoordinates
import TauCetiRoadmap.ClusterAlgebras.SeedEvaluation
import TauCetiRoadmap.ClusterAlgebras.UniversalY
import TauCetiRoadmap.ClusterAlgebras.UpperBound
import TauCetiRoadmap.ClusterAlgebras.UpperBoundCharts
import TauCetiRoadmap.ClusterAlgebras.UpperBoundCoefficients
import TauCetiRoadmap.ClusterAlgebras.UpperBoundCommuting
import TauCetiRoadmap.ClusterAlgebras.UpperBoundInteracting
import TauCetiRoadmap.ClusterAlgebras.UpperBoundLocal
import TauCetiRoadmap.ClusterAlgebras.UpperBoundRankTwo
import TauCetiRoadmap.ClusterAlgebras.UpperBoundRegroup
import TauCetiRoadmap.ClusterAlgebras.UpperLaurent
import TauCetiRoadmap.ClusterAlgebras.UpperSpecialization
import TauCetiRoadmap.ClusterAlgebras.WordCoordinates
import TauCetiRoadmap.LaurentPhenomenon
import TauCetiRoadmap.LaurentPhenomenon.AlgebraicCaterpillar
import TauCetiRoadmap.LaurentPhenomenon.BinomialCorrection
import TauCetiRoadmap.LaurentPhenomenon.Birational
import TauCetiRoadmap.LaurentPhenomenon.Chart
import TauCetiRoadmap.LaurentPhenomenon.CoefficientChart
import TauCetiRoadmap.LaurentPhenomenon.CoefficientRing
import TauCetiRoadmap.LaurentPhenomenon.ComaximalIntersection
import TauCetiRoadmap.LaurentPhenomenon.CommutingExchange
import TauCetiRoadmap.LaurentPhenomenon.CoordinateEvaluation
import TauCetiRoadmap.LaurentPhenomenon.CoordinateWeight
import TauCetiRoadmap.LaurentPhenomenon.Denominator
import TauCetiRoadmap.LaurentPhenomenon.DenominatorPatching
import TauCetiRoadmap.LaurentPhenomenon.ExchangePattern
import TauCetiRoadmap.LaurentPhenomenon.FactorialTheorem
import TauCetiRoadmap.LaurentPhenomenon.FiniteCaterpillar
import TauCetiRoadmap.LaurentPhenomenon.FiniteExchangeReplacement
import TauCetiRoadmap.LaurentPhenomenon.FiniteLaurent
import TauCetiRoadmap.LaurentPhenomenon.FiniteLocalModel
import TauCetiRoadmap.LaurentPhenomenon.FiniteTheorem
import TauCetiRoadmap.LaurentPhenomenon.FirstStarModel
import TauCetiRoadmap.LaurentPhenomenon.FlatDivisibility
import TauCetiRoadmap.LaurentPhenomenon.FreeDivisibility
import TauCetiRoadmap.LaurentPhenomenon.FreshParameter
import TauCetiRoadmap.LaurentPhenomenon.GenericChart
import TauCetiRoadmap.LaurentPhenomenon.GenericCoprimality
import TauCetiRoadmap.LaurentPhenomenon.GroupRing
import TauCetiRoadmap.LaurentPhenomenon.GroupedLocalAlgebra
import TauCetiRoadmap.LaurentPhenomenon.IntegerEvaluation
import TauCetiRoadmap.LaurentPhenomenon.IntegerSpecialization
import TauCetiRoadmap.LaurentPhenomenon.Intersection
import TauCetiRoadmap.LaurentPhenomenon.LaurentChart
import TauCetiRoadmap.LaurentPhenomenon.LaurentEvaluation
import TauCetiRoadmap.LaurentPhenomenon.LaurentFactorial
import TauCetiRoadmap.LaurentPhenomenon.LaurentModel
import TauCetiRoadmap.LaurentPhenomenon.LaurentRegroup
import TauCetiRoadmap.LaurentPhenomenon.LaurentReindex
import TauCetiRoadmap.LaurentPhenomenon.LaurentSplit
import TauCetiRoadmap.LaurentPhenomenon.LaurentSupport
import TauCetiRoadmap.LaurentPhenomenon.LaurentWeight
import TauCetiRoadmap.LaurentPhenomenon.LocalCancellation
import TauCetiRoadmap.LaurentPhenomenon.LocalCoprimality
import TauCetiRoadmap.LaurentPhenomenon.LocalModel
import TauCetiRoadmap.LaurentPhenomenon.LocalStep
import TauCetiRoadmap.LaurentPhenomenon.MixedLaurent
import TauCetiRoadmap.LaurentPhenomenon.Mutation
import TauCetiRoadmap.LaurentPhenomenon.MutationWord
import TauCetiRoadmap.LaurentPhenomenon.OneExchangeBase
import TauCetiRoadmap.LaurentPhenomenon.OneExchangeChart
import TauCetiRoadmap.LaurentPhenomenon.OrderedExchange
import TauCetiRoadmap.LaurentPhenomenon.PathRealization
import TauCetiRoadmap.LaurentPhenomenon.PolynomialChartModel
import TauCetiRoadmap.LaurentPhenomenon.PolynomialDescent
import TauCetiRoadmap.LaurentPhenomenon.PolynomialExchange
import TauCetiRoadmap.LaurentPhenomenon.PolynomialSupport
import TauCetiRoadmap.LaurentPhenomenon.PositiveCaterpillar
import TauCetiRoadmap.LaurentPhenomenon.PositiveCaterpillarRealization
import TauCetiRoadmap.LaurentPhenomenon.PositiveEvaluation
import TauCetiRoadmap.LaurentPhenomenon.PositiveFraction
import TauCetiRoadmap.LaurentPhenomenon.PositiveLaurentTheorem
import TauCetiRoadmap.LaurentPhenomenon.PositiveLift
import TauCetiRoadmap.LaurentPhenomenon.PositiveLocalModel
import TauCetiRoadmap.LaurentPhenomenon.PositivePoint
import TauCetiRoadmap.LaurentPhenomenon.PositiveRealization
import TauCetiRoadmap.LaurentPhenomenon.PositiveSpecialization
import TauCetiRoadmap.LaurentPhenomenon.PositiveSubstitution
import TauCetiRoadmap.LaurentPhenomenon.PositiveWeight
import TauCetiRoadmap.LaurentPhenomenon.Quantum.Center
import TauCetiRoadmap.LaurentPhenomenon.Quantum.CentralDivisibility
import TauCetiRoadmap.LaurentPhenomenon.Quantum.ChangeChart
import TauCetiRoadmap.LaurentPhenomenon.Quantum.Chart
import TauCetiRoadmap.LaurentPhenomenon.Quantum.Coefficients
import TauCetiRoadmap.LaurentPhenomenon.Quantum.Domain
import TauCetiRoadmap.LaurentPhenomenon.Quantum.LatticeBasis
import TauCetiRoadmap.LaurentPhenomenon.Quantum.Lift
import TauCetiRoadmap.LaurentPhenomenon.Quantum.LiftMonomial
import TauCetiRoadmap.LaurentPhenomenon.Quantum.MixedSubalgebra
import TauCetiRoadmap.LaurentPhenomenon.Quantum.Monomial
import TauCetiRoadmap.LaurentPhenomenon.Quantum.Ore
import TauCetiRoadmap.LaurentPhenomenon.Quantum.PolynomialDivisibility
import TauCetiRoadmap.LaurentPhenomenon.Quantum.ScaledMonomial
import TauCetiRoadmap.LaurentPhenomenon.Quantum.Sign
import TauCetiRoadmap.LaurentPhenomenon.Quantum.Specialization
import TauCetiRoadmap.LaurentPhenomenon.Quantum.Subalgebra
import TauCetiRoadmap.LaurentPhenomenon.Quantum.Support
import TauCetiRoadmap.LaurentPhenomenon.Quantum.Torus
import TauCetiRoadmap.LaurentPhenomenon.RealizedLocalCoordinates
import TauCetiRoadmap.LaurentPhenomenon.Rechart
import TauCetiRoadmap.LaurentPhenomenon.Recurrence
import TauCetiRoadmap.LaurentPhenomenon.SkewExchange
import TauCetiRoadmap.LaurentPhenomenon.SkewPatching
import TauCetiRoadmap.LaurentPhenomenon.SkewReplacement
import TauCetiRoadmap.LaurentPhenomenon.SpecializationDescent
import TauCetiRoadmap.LaurentPhenomenon.Tests.AlgebraicExamples
import TauCetiRoadmap.LaurentPhenomenon.Tests.QuantumChecks
import TauCetiRoadmap.LaurentPhenomenon.Tests.QuantumExamples
import TauCetiRoadmap.LaurentPhenomenon.Tests.ReusableAPIAudit
import TauCetiRoadmap.LaurentPhenomenon.Tests.UpperBoundLibraryAudit
import TauCetiRoadmap.LaurentPhenomenon.UniversalDeformation
import TauCetiRoadmap.LaurentPhenomenon.UniversalInduction
import TauCetiRoadmap.LaurentPhenomenon.UpperBoundPattern


/-! Required documentation and linter-exemption audit in a legacy environment. -/

open Lean

private def isProjectConstant (env : Environment) (name : Name) : Bool :=
  match env.getModuleIdxFor? name with
  | some idx => (`TauCetiRoadmap).isPrefixOf env.header.moduleNames[idx.toNat]!
  | none => false

-- Mirror docBlame's kind filter in a legacy environment, where actual definition
-- kinds, private proof values and server-stored docstrings are all available.
open Lean Meta in
private def requiredDocKind (name : Name) : MetaM (Option String) := do
  if (← getEnv).isPrivateOrAutoDecl name then return none
  if ← isInstance name then return none
  if let .str parent _ := name then
    if ← isInstance parent then return none
  if let .str _ suffix := name then
    if ["parenthesizer", "formatter", "delaborator", "quot"].contains suffix then
      return none
  match ← getConstInfo name with
  | .axiomInfo .. => return some "axiom"
  | .opaqueInfo .. => return some "constant"
  | .defnInfo info =>
    if (← isProjectionFn name) && (← isProp info.type) then return none
    return some "definition"
  | .inductInfo .. => return some "inductive"
  | _ => return none

run_meta do
  let env ← getEnv
  let mut scanned : Nat := 0
  let mut documented : Nat := 0
  let mut missing : Array Name := #[]
  let candidates := env.constants.fold (init := #[]) fun acc name _ =>
    if isProjectConstant env name && (env.getModuleIdxFor? name).isSome then acc.push name else acc
  for name in candidates do
    if (← requiredDocKind name).isSome then
      scanned := scanned + 1
      if (← Lean.findDocString? env name).isSome then
        documented := documented + 1
      else
        missing := missing.push name
        let some idx := env.getModuleIdxFor? name | throwError "Missing source module"
        let range ← Lean.findDeclarationRanges? name
        IO.println s!"MISSING-DOC {name} {env.header.moduleNames[idx.toNat]!} {range.map (·.selectionRange.pos.line)}"
  unless scanned > 0 ∧ documented > 0 do
    throwError "Docstring scan has empty coverage"
  for sentinel in #[``TauCeti.Laurent.FiniteReplacementPremise,
      ``TauCeti.Cluster.QuantumSeed] do
    unless (← Lean.findDocString? env sentinel).isSome do
      throwError "Documented sentinel is invisible: {sentinel}"
  let mut seenNolints : Nat := 0
  for idx in [0:env.header.moduleNames.size] do
    let entries := Batteries.Tactic.Lint.nolintAttr.ext.getModuleEntries env idx
    seenNolints := seenNolints + entries.size
    if (`TauCetiRoadmap).isPrefixOf env.header.moduleNames[idx]! then
      unless entries.isEmpty do throwError "Project module contains a nolint exemption"
  unless seenNolints > 0 do throwError "Nolint scan has empty imported coverage"
  logInfo m!"Documentation: {documented}/{scanned}; no project nolint exemptions."
  unless missing.isEmpty do throwError "Missing required documentation for {missing.size} declarations"

