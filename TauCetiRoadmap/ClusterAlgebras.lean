/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.InitialLaurent
public import TauCetiRoadmap.ClusterAlgebras.MatrixConvention
public import TauCetiRoadmap.ClusterAlgebras.SeedEvaluation
public import TauCetiRoadmap.ClusterAlgebras.QuantumLaurent
public import TauCetiRoadmap.ClusterAlgebras.PolynomialQuantumAlgebra
public import TauCetiRoadmap.ClusterAlgebras.QuantumAlgebra
public import TauCetiRoadmap.ClusterAlgebras.QuantumExpansion
public import TauCetiRoadmap.ClusterAlgebras.QuantumRealization
public import TauCetiRoadmap.ClusterAlgebras.QuantumSeedDivision
public import TauCetiRoadmap.ClusterAlgebras.QuantumSeedSign
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

The public Laurent proof uses mutation-invariant finite upper bounds for
compatible quantum seeds (`QuantumSeed`, `QuantumLaurent`), the classical limit
`v = 1` for principal coefficients, and normalized coefficient specialization.
It imposes no full-rank condition on the input mutable matrix. The classical
full-rank upper-bound theorem (`GeometricLaurent`) is kept in the library as a
separate theorem and is not on this route.
It has no Caterpillar dependency. The independent Caterpillar route remains
available by explicitly importing `ClusterAlgebras.Laurent`.
Concrete examples and proof-dependency audits live in `ClusterAlgebras.Examples`.
-/

@[expose] public section
