/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/

import TauCetiRoadmap.ClusterAlgebras.ChartSpecialization
import TauCetiRoadmap.ClusterAlgebras.ClassicalFrame
import TauCetiRoadmap.ClusterAlgebras.Coefficients
import TauCetiRoadmap.ClusterAlgebras.CoordinateSeparation
import TauCetiRoadmap.ClusterAlgebras.Examples.InitialSeedConsumer
import TauCetiRoadmap.ClusterAlgebras.Examples.PolynomialQuantum
import TauCetiRoadmap.ClusterAlgebras.Examples.PolynomialSeedChecks
import TauCetiRoadmap.ClusterAlgebras.Examples.QuantumChecks
import TauCetiRoadmap.ClusterAlgebras.Examples.ScalarSpecializationChecks
import TauCetiRoadmap.ClusterAlgebras.Examples.Somos4
import TauCetiRoadmap.ClusterAlgebras.Examples.Somos4Audit
import TauCetiRoadmap.ClusterAlgebras.Examples.Somos4Pattern
import TauCetiRoadmap.ClusterAlgebras.Examples.Somos4Sequence
import TauCetiRoadmap.ClusterAlgebras.ExchangeFrame
import TauCetiRoadmap.ClusterAlgebras.ExchangeMatrix
import TauCetiRoadmap.ClusterAlgebras.ExpressionCoordinates
import TauCetiRoadmap.ClusterAlgebras.ExtendedRank
import TauCetiRoadmap.ClusterAlgebras.FrozenWeight
import TauCetiRoadmap.ClusterAlgebras.GeometricClusterAlgebra
import TauCetiRoadmap.ClusterAlgebras.GeometricCoordinates
import TauCetiRoadmap.ClusterAlgebras.GeometricFrame
import TauCetiRoadmap.ClusterAlgebras.GeometricLaurent
import TauCetiRoadmap.ClusterAlgebras.GeometricLaurentBase
import TauCetiRoadmap.ClusterAlgebras.GeometricPattern
import TauCetiRoadmap.ClusterAlgebras.GeometricSeed
import TauCetiRoadmap.ClusterAlgebras.HatY
import TauCetiRoadmap.ClusterAlgebras.InitialLaurent
import TauCetiRoadmap.ClusterAlgebras.InitialSeed
import TauCetiRoadmap.ClusterAlgebras.LaurentFaithfulness
import TauCetiRoadmap.ClusterAlgebras.MatrixConvention
import TauCetiRoadmap.ClusterAlgebras.MatrixMutation
import TauCetiRoadmap.ClusterAlgebras.MutationPattern
import TauCetiRoadmap.ClusterAlgebras.Normalization
import TauCetiRoadmap.ClusterAlgebras.PolynomialExchangeSeed
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
import TauCetiRoadmap.ClusterAlgebras.QuantumFrameDivision
import TauCetiRoadmap.ClusterAlgebras.QuantumFrameSign
import TauCetiRoadmap.ClusterAlgebras.QuantumInteracting
import TauCetiRoadmap.ClusterAlgebras.QuantumLaurent
import TauCetiRoadmap.ClusterAlgebras.QuantumOpposite
import TauCetiRoadmap.ClusterAlgebras.QuantumPair
import TauCetiRoadmap.ClusterAlgebras.QuantumPairChart
import TauCetiRoadmap.ClusterAlgebras.QuantumPolynomial
import TauCetiRoadmap.ClusterAlgebras.QuantumRealization
import TauCetiRoadmap.ClusterAlgebras.QuantumReplacement
import TauCetiRoadmap.ClusterAlgebras.QuantumSeed
import TauCetiRoadmap.ClusterAlgebras.QuantumSpecialization
import TauCetiRoadmap.ClusterAlgebras.QuantumSubsetRing
import TauCetiRoadmap.ClusterAlgebras.QuantumSupport
import TauCetiRoadmap.ClusterAlgebras.SeedBinomial
import TauCetiRoadmap.ClusterAlgebras.SeedCompatibility
import TauCetiRoadmap.ClusterAlgebras.SeedEvaluation
import TauCetiRoadmap.ClusterAlgebras.UniversalY
import TauCetiRoadmap.ClusterAlgebras.UpperBound
import TauCetiRoadmap.ClusterAlgebras.UpperLaurent
import TauCetiRoadmap.ClusterAlgebras.UpperSpecialization
import TauCetiRoadmap.ClusterAlgebras.WordCoordinates
import TauCetiRoadmap.ClusterAlgebras
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
import TauCetiRoadmap.LaurentPhenomenon.ExchangeRings
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
import TauCetiRoadmap.LaurentPhenomenon.GroupedLocalAlgebra
import TauCetiRoadmap.LaurentPhenomenon.GroupRing
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
import TauCetiRoadmap.LaurentPhenomenon.MatrixColumns
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
import TauCetiRoadmap.LaurentPhenomenon.Tests.CaterpillarChecks
import TauCetiRoadmap.LaurentPhenomenon.Tests.QuantumChecks
import TauCetiRoadmap.LaurentPhenomenon.Tests.QuantumExamples
import TauCetiRoadmap.LaurentPhenomenon.Tests.ReusableAPIAudit
import TauCetiRoadmap.LaurentPhenomenon.Tests.UpperBoundLibraryAudit
import TauCetiRoadmap.LaurentPhenomenon.UniversalDeformation
import TauCetiRoadmap.LaurentPhenomenon.UniversalInduction
import TauCetiRoadmap.LaurentPhenomenon.UpperBoundPattern
import TauCetiRoadmap.LaurentPhenomenon

/-! Whole-library audit in a legacy driver: imports include the private olean
parts, so private declarations and actual proof values remain visible.
The verification runner compares this import list with the complete source tree.
-/

namespace TauCeti.Laurent.Tests
open Lean Lean.Elab.Command

/-- Whether `n` is defined in this project: in the current module or in a module whose name
starts with `TauCetiRoadmap`. -/
def isProjectConstant (env : Environment) (n : Name) : Bool :=
  match env.getModuleIdxFor? n with
  | none => true
  | some idx =>
    match env.header.moduleNames[idx.toNat]? with
    | some mod => (`TauCetiRoadmap).isPrefixOf mod
    | none => false

/-- Constants reachable from `root` through the values of definitions and theorems of this
project (`isProjectConstant`), whatever their namespace. Constants of Mathlib, the Tau Ceti
library and Lean are leaves: they are recorded but not expanded, since their definitions cannot
point back into this project. -/
def transitiveUsedConstants (env : Environment) (root : Name) : NameSet := Id.run do
  let mut visited : NameSet := {}
  let mut pending : List Name := [root]
  while !pending.isEmpty do
    let n := pending.head!
    pending := pending.tail!
    if visited.contains n then
      continue
    visited := visited.insert n
    if isProjectConstant env n then
      if let some info := env.find? n then
        if let some value := info.value? (allowOpaque := true) then
          pending := value.getUsedConstants.toList ++ pending
  return visited

def assertTransitiveDependency (env : Environment) (root target : Name) : CommandElabM Unit := do
  unless (transitiveUsedConstants env root).contains target do
    throwError "Required transitive proof dependency missing: {root} → {target}"

def assertNoTransitiveDependency (env : Environment) (root target : Name) :
    CommandElabM Unit := do
  if (transitiveUsedConstants env root).contains target then
    throwError "Unexpected transitive proof dependency: {root} → {target}"

def assertNoForbiddenDependencies (env : Environment) (root : Name) : CommandElabM Unit := do
  for n in transitiveUsedConstants env root do
    let s := n.toString
    if (s.splitOn "Caterpillar").length > 1 ||
        (s.splitOn "universalLaurent").length > 1 ||
        (s.splitOn "sorryAx").length > 1 then
      throwError "Forbidden proof dependency in {root}: {n}"

/-- Fails unless every axiom used by `root` (`Lean.collectAxioms`) is one of `propext`,
`Classical.choice` and `Quot.sound`. -/
def assertAxiomsStandard (root : Name) : CommandElabM Unit := do
  let axioms ← liftCoreM (Lean.collectAxioms root)
  for ax in axioms do
    unless ax == ``propext || ax == ``Classical.choice || ax == ``Quot.sound do
      throwError "Nonstandard axiom in {root}: {ax}"

/-- Build the reachable dependency graph, then propagate forbidden axioms backwards.
Every edge in both types and values is retained. Backwards reachability handles
cycles without assuming that imported libraries are themselves axiom-clean. -/
def nonstandardAxiomDependents (env : Environment) (roots : Array Name) :
    NameSet × Array Name :=
    Id.run do
  let mut visited : NameSet := {}
  let mut missing : Array Name := #[]
  let mut parents : NameMap (Array Name) := {}
  let mut pending := roots.toList
  let mut bad : NameSet := {}
  let mut propagate : List Name := []
  while !pending.isEmpty do
    let n := pending.head!
    pending := pending.tail!
    if visited.contains n then continue
    visited := visited.insert n
    if (env.find? n).isNone then missing := missing.push n
    let expressions : Array Expr := match env.find? n with
      | some (.axiomInfo v) => #[v.type]
      | some (.defnInfo v) => #[v.type, v.value]
      | some (.thmInfo v) => #[v.type, v.value]
      | some (.opaqueInfo v) => #[v.type, v.value]
      | some (.ctorInfo v) => #[v.type]
      | some (.recInfo v) => #[v.type]
      | some (.inductInfo v) => #[v.type]
      | _ => #[]
    let mut children := expressions.flatMap Expr.getUsedConstants
    if let some (.inductInfo v) := env.find? n then
      children := children ++ v.ctors.toArray
    if let some (.axiomInfo _) := env.find? n then
      unless n == ``propext || n == ``Classical.choice || n == ``Quot.sound do
        bad := bad.insert n
        propagate := n :: propagate
    for child in children do
      parents := parents.insert child (((parents.find? child).getD #[]).push n)
      pending := child :: pending
  while !propagate.isEmpty do
    let n := propagate.head!
    propagate := propagate.tail!
    for parent in (parents.find? n).getD #[] do
      unless bad.contains parent do
        bad := bad.insert parent
        propagate := parent :: propagate
  return (bad, missing)

/-- Audit every declaration defined in the specified imported module families,
including private helpers, definitions and generated declarations. -/
def assertLibraryAxiomsStandard (roots : Array Name) : CommandElabM Unit := do
  let env ← getEnv
  let belongs (n : Name) : Bool :=
    match env.getModuleIdxFor? n with
    | none => roots.any (·.isPrefixOf env.mainModule)
    | some idx =>
      match env.header.moduleNames[idx.toNat]? with
      | some m => roots.any (·.isPrefixOf m)
      | none => false
  let candidates := env.constants.fold (init := #[]) fun acc n _ =>
    if belongs n then acc.push n else acc
  let (bad, missing) := nonstandardAxiomDependents env candidates
  unless missing.isEmpty do
    throwError "Axiom audit cannot inspect missing constants: {missing}"
  for n in candidates do
    if bad.contains n then
      assertAxiomsStandard n
      throwError "Nonstandard axiom reachable from {n}"
  logInfo m!"Audited {candidates.size} declarations: only propext, Classical.choice, Quot.sound."

end TauCeti.Laurent.Tests

namespace TauCeti.Laurent.Tests

open Lean Lean.Elab.Command

private def expectAxiomRejection (action : CommandElabM Unit) : CommandElabM Unit := do
  let rejected ← try
    action
    pure false
  catch ex =>
    match ex with
    | .error _ message =>
      let text ← message.toString
      if (text.splitOn "Nonstandard axiom").length > 1 then pure true else throw ex
    | _ => throw ex
  unless rejected do
    throwError "Axiom-audit negative control was accepted"

run_cmd do
  expectAxiomRejection (assertAxiomsStandard ``sorryAx)
  let env ← getEnv
  let some idx := env.getModuleIdxFor? ``sorryAx
    | throwError "Cannot locate the negative-control module"
  let some mod := env.header.moduleNames[idx.toNat]?
    | throwError "Invalid negative-control module index"
  expectAxiomRejection (assertLibraryAxiomsStandard #[mod])
  logInfo "Both axiom-audit negative controls passed."

end TauCeti.Laurent.Tests

open Lean TauCeti.Laurent.Tests TauCeti.Laurent TauCeti.Cluster
open TauCeti.Examples.Somos4

run_cmd do
  assertLibraryAxiomsStandard #[`TauCetiRoadmap.ClusterAlgebras,
    `TauCetiRoadmap.LaurentPhenomenon]

-- Standard-axiom checks for the cluster endpoints.
run_cmd do
  for root in #[``TauCeti.Laurent.PositiveCaterpillar.laurent,
      ``TauCeti.Laurent.PositiveCaterpillar.deform_first_intersection,
      ``TauCeti.Laurent.PositiveCaterpillar.deform_chart_descent] do
    assertAxiomsStandard root

-- Finite replacement in the ordinary quantum Laurent proof.
run_cmd do
  let env ← getEnv
  let root := ``TauCeti.Cluster.ExchangeFrame.coordinate_mutateWord_mem_chartRing
  assertAxiomsStandard root
  assertTransitiveDependency env root ``TauCeti.Laurent.FiniteReplacementPremise.zss_mem

-- Quantum and classical public endpoints use the common polynomial proof.
run_cmd do
  let env ← getEnv
  let quantum := ``TauCeti.Cluster.ExchangeFrame.coordinate_mutateWord_mem_chartRing
  assertTransitiveDependency env quantum ``TauCeti.Laurent.FiniteReplacementPremise.zss_mem
  assertTransitiveDependency env quantum ``TauCeti.Laurent.UpperBoundPattern.upperBound_le_mutation
  assertTransitiveDependency env quantum ``TauCeti.Module.exists_mul_smul_of_flat
  let geometric := ``TauCeti.Cluster.FullRankGeometricSeed.laurent
  let principal := ``TauCeti.Cluster.principalWord_integral_laurent
  let general := ``TauCeti.Cluster.matrixSeed_integral_laurent
  let limit := ``TauCeti.Cluster.ExchangeFrame.mutateWord_chartSpecializes
  let laurent := ``TauCeti.Cluster.ExchangeFrame.algebraMap_sp_eq_geometricPattern
  let algebra := ``TauCeti.Cluster.ExchangeFrame.range_classicalLimit
  let endpoints := #[quantum, geometric, limit, laurent, algebra, principal, general,
    ``TauCeti.Cluster.principalWord_polynomial_frozen,
    ``TauCeti.Cluster.matrixSeed_polynomial_frozen]
  for root in endpoints do
    assertAxiomsStandard root
    assertNoForbiddenDependencies env root
  for (root, target) in #[
    (quantum, ``TauCeti.Cluster.PolynomialExchangeSeed.upperBound_mutate),
    (quantum, ``TauCeti.Cluster.PolynomialExchangeSeed.inf_mutate_inf_inf_mutate_eq_fourRing),
    (quantum, ``TauCeti.Cluster.PolynomialExchangeSeed.inf_mutate_inf_inf_mutate_eq_fourRing_of_eq_zero),
    (quantum, ``TauCeti.Cluster.PolynomialExchangeSeed.fourRing_mutate),
    (quantum, ``TauCeti.Cluster.PolynomialExchangeSeed.chartRing_inf_mutate_chartRing),
    (quantum, ``TauCeti.Cluster.PolynomialExchangeSeed.mem_mutate_chartRing_iff),
    (quantum, ``TauCeti.Cluster.PolynomialExchangeSeed.mem_chartRing_exchangeCoordinate_iff),
    (geometric, ``TauCeti.Cluster.PolynomialExchangeSeed.coordinate_mutateWord_mem_mutateWord_chartRing),
    (limit, ``TauCeti.Cluster.PolynomialExchangeSeed.mutateWord_chartSpecializes),
    (laurent, limit),
    (algebra, limit),
    (algebra, quantum),
    (principal, ``TauCeti.Cluster.principalGeometricWord_laurent),
    (principal, ``TauCeti.Cluster.FullRankGeometricSeed.laurent),
    (principal, ``TauCeti.Cluster.commutativeFrame),
    (principal, ``TauCeti.Cluster.PolynomialExchangeSeed.coordinate_mutateWord_mem_mutateWord_chartRing),
    (general, principal),
    (general, ``TauCeti.Cluster.PolynomialExchangeSeed.coordinate_mutateWord_mem_mutateWord_chartRing),
    (general, ``TauCeti.Cluster.principal_coordinate_separation)] do
    assertTransitiveDependency env root target
  let classical := #[geometric,
    ``TauCeti.Cluster.FullRankGeometricSeed.upperBound_mutation,
    ``TauCeti.Cluster.FullRankGeometricSeed.three_chart_unitParameter]
  for root in #[quantum, limit, laurent, algebra] do
    for target in classical do
      assertNoTransitiveDependency env root target
  for root in #[geometric, principal, general] do
    for target in #[limit, ``TauCeti.QuantumTorus.sp,
        ``TauCeti.Cluster.IsCompatiblePair.independent_columns] do
      assertNoTransitiveDependency env root target

-- The all-rank polynomial theorem constructs its local inputs from actual seed data.
run_cmd do
  let env ← getEnv
  let root := ``TauCeti.Cluster.PolynomialExchangeSeed.coordinate_mutateWord_mem_chartRing
  let limit := ``TauCeti.Cluster.PolynomialExchangeSeed.mutateWord_chartSpecializes_of_independent
  let ordinary := ``TauCeti.Cluster.ExchangeFrame.coordinate_mutateWord_mem_chartRing
  for n in #[root, limit,
      ``TauCeti.Cluster.PolynomialExchangeSeed.clusterAlgebra_le_upperAlgebra,
      ``TauCeti.Cluster.PolynomialExchangeSeed.classicalLimitOnto_surjective,
      ``TauCeti.Examples.PolynomialSeedChecks.cubicSeed_laurent,
      ``TauCeti.Examples.PolynomialSeedChecks.cubicSeed_classical_word] do
    assertAxiomsStandard n
    assertNoForbiddenDependencies env n
  for target in #[
      ``TauCeti.Cluster.PolynomialExchangeSeed.finiteReplacement_pos,
      ``TauCeti.Cluster.PolynomialExchangeSeed.replacementCoefficient_compat_pos,
      ``TauCeti.Cluster.PolynomialExchangeSeed.replacement_defect_mem_pos,
      ``TauCeti.Cluster.PolynomialExchangeSeed.mutated_exchange_term_pos,
      ``TauCeti.QuantumTorus.exists_eq_mul_aeval_mul_aeval,
      ``TauCeti.QuantumTorus.algHom_injective_of_coordinate_free,
      ``TauCeti.Laurent.UpperBoundPattern.upperBound_le_mutation] do
    assertTransitiveDependency env root target
  assertTransitiveDependency env limit root
  assertTransitiveDependency env limit
    ``TauCeti.Cluster.PolynomialExchangeSeed.classicalExchangePolynomial_ne_zero
  assertTransitiveDependency env ordinary
    ``TauCeti.Cluster.PolynomialExchangeSeed.inf_inf_eq_fourRing
  assertTransitiveDependency env ordinary ``TauCeti.Cluster.ExchangeFrame.polynomialSeed_mutate
  assertNoTransitiveDependency env root ordinary
  assertNoTransitiveDependency env root ``TauCeti.Cluster.FullRankGeometricSeed.laurent
  assertTransitiveDependency env
    ``TauCeti.Examples.PolynomialSeedChecks.cubicSeed_laurent
    ``TauCeti.Cluster.PolynomialExchangeSeed.coordinate_mutateWord_mem_mutateWord_chartRing
  assertTransitiveDependency env
    ``TauCeti.Examples.PolynomialSeedChecks.cubicSeed_classical_word limit

-- Proof audit for ClusterAlgebras/Examples/InitialSeedConsumer.lean
-- Both sectors instantiate one polynomial proof; the classical constructor
-- uses zero form, independently certified columns and the original coefficient ring.
run_cmd do
  let env ← getEnv
  let core := ``TauCeti.Cluster.PolynomialExchangeSeed.coordinate_mutateWord_mem_chartRing
  let classical := ``TauCeti.Cluster.FullRankGeometricSeed.three_chart_unitParameter
  let zeroCase := ``TauCeti.Examples.ScalarSpecializationChecks.classicalCubicSeed_laurent
  for root in #[``TauCeti.Cluster.QuantumSeed.coordinate_mutateWord_mem_chartRing,
      ``TauCeti.Cluster.PolynomialQuantumSeed.coordinate_mutateWord_mem_chartRing,
      zeroCase] do
    assertTransitiveDependency env root
      ``TauCeti.Cluster.PolynomialExchangeSeed.coordinate_mutateWord_mem_mutateWord_chartRing
    assertAxiomsStandard root
    assertNoForbiddenDependencies env root
  assertTransitiveDependency env classical ``TauCeti.Cluster.PolynomialExchangeSeed.three_chart
  assertTransitiveDependency env classical
    ``TauCeti.Cluster.PolynomialExchangeSeed.independent_dividedColumns
  assertTransitiveDependency env classical ``TauCeti.Cluster.commutativeFrame
  assertTransitiveDependency env classical ``TauCeti.Cluster.unitParameterChart_injective
  assertTransitiveDependency env ``TauCeti.Cluster.ExchangeFrame.mutate
    ``TauCeti.Cluster.PolynomialExchangeSeed.mutate
  assertTransitiveDependency env ``TauCeti.Cluster.ExchangeFrame.mutate_mutate
    ``TauCeti.Cluster.PolynomialExchangeSeed.mutate_mutate
  assertTransitiveDependency env ``TauCeti.Cluster.ExchangeFrame.chartRing_inf_mutate_chartRing
    ``TauCeti.Cluster.PolynomialExchangeSeed.chartRing_inf_mutate_chartRing
  for (binary, polynomial) in #[
    (``TauCeti.Cluster.ExchangeFrame.exchangeCoordinate_pow,
      ``TauCeti.Cluster.PolynomialExchangeSeed.exchangeCoordinate_pow),
    (``TauCeti.Cluster.ExchangeFrame.exchangeData_subsetRing,
      ``TauCeti.Cluster.PolynomialExchangeSeed.exchangeData_subsetRing),
    (``TauCeti.Cluster.ExchangeFrame.mem_mutate_chartRing_iff,
      ``TauCeti.Cluster.PolynomialExchangeSeed.mem_mutate_chartRing_iff),
    (``TauCeti.Cluster.ExchangeFrame.commute_centralProduct,
      ``TauCeti.Cluster.PolynomialExchangeSeed.commute_centralProduct)] do
    assertTransitiveDependency env binary polynomial
  assertTransitiveDependency env ``TauCeti.Cluster.QuantumSeed.ofCompatible
    ``TauCeti.Cluster.IsCompatiblePair.independent_columns
  assertNoTransitiveDependency env core ``TauCeti.Cluster.IsCompatiblePair.independent_columns
  for target in #[``TauCeti.Cluster.ExchangeFrame.mutate,
      ``TauCeti.Cluster.ExchangeFrame.coordinate_mutateWord_mem_chartRing,
      ``TauCeti.Cluster.ExchangeFrame.upperBound_mutate,
      ``TauCeti.Cluster.FullRankGeometricSeed.laurent] do
    assertNoTransitiveDependency env core target
  assertNoTransitiveDependency env zeroCase
    ``TauCeti.Cluster.PolynomialExchangeSeed.mutateWord_chartSpecializes
  assertNoTransitiveDependency env zeroCase ``TauCeti.Cluster.IsCompatiblePair.independent_columns
  assertNoTransitiveDependency env ``TauCeti.Cluster.commutativeFrame core
  for old in #[`TauCeti.Cluster.principalGeometricWord_laurent_of_quantum,
      `TauCeti.Cluster.exists_integral_compatible_extension,
      `TauCeti.Cluster.ExchangeFrame.mutateChart_injective,
      `TauCeti.Cluster.PolynomialExchangeSeed.columnWeight_ne_zero,
      `TauCeti.Cluster.UpperBound.geometric_commuting_three_charts,
      `TauCeti.Cluster.UpperBound.geometric_interacting_three_chart,
      `TauCeti.Cluster.NormalizedMutationPattern.laurent_word] do
    if env.contains old then throwError "Obsolete specialized proof still present: {old}"

run_cmd do
  let env ← getEnv
  let root := ``TauCeti.Examples.Somos4.initial_seed_laurent_representative
  assertAxiomsStandard root
  for target in #[
    ``TauCeti.Cluster.MatrixSeed.cluster_laurent_unique,
    ``TauCeti.Cluster.matrixSeed_integral_laurent,
    ``TauCeti.Cluster.principalWord_integral_laurent,
    ``TauCeti.Cluster.principalGeometricWord_laurent,
    ``TauCeti.Cluster.PolynomialExchangeSeed.upperBound_mutate] do
    assertTransitiveDependency env root target
  assertNoForbiddenDependencies env root
  for target in #[``TauCeti.Cluster.ExchangeFrame.mutateWord_chartSpecializes,
    ``TauCeti.QuantumTorus.sp, ``TauCeti.Cluster.IsCompatiblePair.independent_columns] do
    assertNoTransitiveDependency env root target

-- Proof audit for ClusterAlgebras/Examples/PolynomialQuantum.lean
namespace TauCeti.Examples.PolynomialQuantum

run_cmd do
  let env ← getEnv
  assertAxiomsStandard ``replacement
  assertAxiomsStandard ``xy_ne_yx
  assertTransitiveDependency env ``replacement ``FiniteReplacementPremise.zss_mem
  assertNoTransitiveDependency env ``replacement ``ExchangeFrame.replacement_mem
  assertNoTransitiveDependency env ``replacement ``ReplacementPremise.zss_mem

end TauCeti.Examples.PolynomialQuantum

-- Proof audit for ClusterAlgebras/Examples/Somos4Audit.lean
run_cmd do
  let env ← getEnv
  let roots := #[``TauCeti.Examples.Somos4.sequence_integral,
    ``TauCeti.Examples.Somos4.integral_of_recurrence,
    ``TauCeti.Examples.Somos4.sequence_positive_integral]
  let excluded := #[``TauCeti.Cluster.ExchangeFrame.mutateWord_chartSpecializes,
    ``TauCeti.QuantumTorus.sp,
    ``TauCeti.Cluster.IsCompatiblePair.independent_columns]
  for root in roots do
    assertAxiomsStandard root
    assertNoForbiddenDependencies env root
    for target in excluded do
      assertNoTransitiveDependency env root target
  let root := ``TauCeti.Examples.Somos4.sequence_integral
  for target in #[
    ``TauCeti.Cluster.MatrixSeed.cluster_laurent_unique,
    ``TauCeti.Cluster.matrixSeed_integral_laurent,
    ``TauCeti.Cluster.principalWord_integral_laurent,
    ``TauCeti.Cluster.principalGeometricWord_laurent,
    ``TauCeti.Cluster.PolynomialExchangeSeed.upperBound_mutate] do
    assertTransitiveDependency env root target

-- Both binary and commutative-polynomial adapters use the finite replacement core.
run_cmd do
  let env ← getEnv
  for root in #[``TauCeti.Laurent.ReplacementPremise.zss_mem,
      ``TauCeti.Laurent.PolynomialExchange.replacement_mem_of_ne_zero] do
    assertTransitiveDependency env root ``TauCeti.Laurent.FiniteReplacementPremise.zss_mem
    assertNoTransitiveDependency env root ``TauCeti.Laurent.PolynomialExchange.replacement_mem
    assertNoTransitiveDependency env root ``TauCeti.Laurent.PolynomialExchange.replacement_identity
    assertAxiomsStandard root

-- Proof audit for LaurentPhenomenon/Tests/ReusableAPIAudit.lean
namespace TauCeti.Laurent.ReusableAPIAudit

run_cmd do
  for root in #[``RealizedCaterpillar.forwardLocalIntersections_of_polynomial_models,
      ``RealizedCaterpillar.target_mem_of_polynomial_models,
      ``PositiveCaterpillar.laurent_at,
      ``PositiveCaterpillar.exists_unique_canonical_laurent_representative,
      ``finiteExpression_specializes,
      ``not_global_positive_nonvanishing] do
    assertAxiomsStandard root

end TauCeti.Laurent.ReusableAPIAudit

-- Proof audit for LaurentPhenomenon/Tests/UpperBoundLibraryAudit.lean
namespace TauCeti.Laurent.UpperBoundLibraryAudit

run_cmd do
  let env ← getEnv
  for (root, target) in #[
    (``signed_three_term_replacement, ``PolynomialExchange.replacement_identity),
    (``signed_three_term_replacement, ``PolynomialExchange.replacement_mem),
    (``noncommutative_exchange_pow, ``OrderedExchange.exchange_pow),
    (``matrix_central_divisibility, ``TauCeti.Module.exists_mul_smul_of_flat)] do
    assertTransitiveDependency env root target
  for root in #[``signed_three_term_replacement, ``noncommutative_exchange_pow,
      ``UpperBoundPattern.upperBound_mutation, ``mem_of_mul_mem_of_sum_eq_one,
      ``matrix_central_divisibility] do
    assertNoForbiddenDependencies env root

end TauCeti.Laurent.UpperBoundLibraryAudit

-- Derive the default environment-linter set from this pinned environment.
-- docBlame is replaced by the legacy-environment scan below, as in Tau Ceti CI.
run_cmd do
  let env ← getEnv
  let expected := #["checkType", "defsWithUnderscore", "deprecatedNoSince",
    "impossibleInstance", "nonClassInstance", "simpComm", "simpNF", "structureInType",
    "subsetDotNotationLinter", "synTaut", "tacticDocs", "unusedArguments",
    "unusedHavesSuffices"]
  let mut actual : Array String := #[]
  for (name, _, dflt) in Batteries.Tactic.Lint.batteriesLinterExt.getState env do
    if dflt && name != `docBlame then actual := actual.push name.toString
  actual := actual.qsort (· < ·)
  unless actual == expected || actual == (expected.push "tacticAlt").qsort (· < ·) do
    throwError "Unexpected default environment-linter set: {actual}"
  logInfo m!"Default environment linters: {actual}"

-- The same lintCore API as Tau Ceti CI, restricted to imported trial declarations.
-- Governance helpers declared in this driver are not library declarations.
open Batteries.Tactic.Lint in
run_cmd do
  let env ← getEnv
  let decls ← Lean.Elab.Command.liftCoreM (getDeclsInPackage `TauCetiRoadmap)
  let decls := decls.filter (fun n => (env.getModuleIdxFor? n).isSome)
  unless !decls.isEmpty do throwError "Environment linter has empty source coverage"
  let names := (batteriesLinterExt.getState env).toList.filterMap fun (n, _, dflt) =>
    if dflt && n != `docBlame then some n else none
  let linters ← Lean.Elab.Command.liftCoreM <|
    getChecks (slow := true) (runOnly := some names) (runAlways := none)
  unless linters.size == names.length do throwError "Environment linter was not loaded"
  let results ← Lean.Elab.Command.liftCoreM <| lintCore decls linters (inIO := true)
  let report ← Lean.Elab.Command.liftCoreM <| formatLinterResults results decls
    (groupByFilename := true) "in the trial libraries" (runSlowLinters := true) .medium linters.size
  if results.any (!·.2.isEmpty) then
    logError report
  else
    logInfo m!"{report}\nAll {linters.size} default environment linters passed."
