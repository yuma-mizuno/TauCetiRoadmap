/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.InitialLaurent
public import TauCetiRoadmap.ClusterAlgebras.MatrixConvention
public import TauCetiRoadmap.ClusterAlgebras.SeedEvaluation
public import TauCetiRoadmap.ClusterAlgebras.QuantumSeed
public import TauCetiRoadmap.ClusterAlgebras.QuantumLaurent
public import TauCetiRoadmap.ClusterAlgebras.PolynomialQuantumAlgebra
public import TauCetiRoadmap.ClusterAlgebras.QuantumAlgebra
public import TauCetiRoadmap.ClusterAlgebras.QuantumExpansion
public import TauCetiRoadmap.ClusterAlgebras.QuantumRealization
public import TauCetiRoadmap.ClusterAlgebras.QuantumFrameDivision
public import TauCetiRoadmap.ClusterAlgebras.QuantumFrameSign
public import TauCetiRoadmap.ClusterAlgebras.QuantumCentralFactors
public import TauCetiRoadmap.ClusterAlgebras.QuantumClassicalLimit
public import TauCetiRoadmap.ClusterAlgebras.GeometricClusterAlgebra
public import TauCetiRoadmap.ClusterAlgebras.GeometricLaurent

/-!
# Cluster algebra mutation and Laurentness

The public constructor is `TauCeti.Cluster.MatrixSeed`: an initial matrix,
coefficient tuple and symmetrizing identity. Given positivity of the fixed
integral symmetrizer, `MatrixSeed.cluster` constructs
coordinates after any mutation word, and `cluster_laurent_unique` produces their
unique finite Laurent representatives. Matrix, coefficient and coordinate
mutation laws are proved, not supplied for all reachable states.

The public Laurent proof uses the common polynomial exchange theorem on a
zero-form unit-parameter principal seed and normalized coefficient specialization.
It imposes no full-rank condition on the input mutable matrix. Ordinary quantum
seeds use the same proof with their positive compatible form. The classical
full-rank upper-bound theorem (`GeometricLaurent`) uses the same polynomial local
proof with unit parameter and zero form through the common `ExchangeFrame`.
It has no Caterpillar dependency. General Caterpillar theorems have their own
entry point in `LaurentPhenomenon`; this cluster library has one canonical Laurent route.
Concrete examples and proof-dependency audits live in `ClusterAlgebras.Examples`.
-/

@[expose] public section
