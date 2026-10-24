/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.ExchangeMatrix
public import TauCetiRoadmap.ClusterAlgebras.Coefficients
public import TauCetiRoadmap.LaurentPhenomenon.MutationWord

/-! # Mutation Pattern -/

@[expose] public section

namespace TauCeti.Cluster

/-- Normalized seed mutation data with its actual matrix and coefficient laws.
No Laurentness, exchange-polynomial compatibility, or local intersection is assumed. -/
structure NormalizedMutationPattern (C I V : Type*) [CoefficientSemifield C] [DecidableEq I] where
  /-- The elementary mutation at an index, acting on the state space. -/
  mutation : I → V → V
  involutive : ∀ i, Function.Involutive (mutation i)
  /-- The exchange matrix attached to each state. -/
  matrix : V → I → I → ℤ
  /-- The coefficient tuple attached to each state. -/
  coefficient : V → I → C
  diagonal : ∀ s i, matrix s i i = 0
  signSkew : ∀ s i j, SignSkewAt (matrix s i j) (matrix s j i)
  matrix_law : ∀ s j, matrix (mutation j s) = matrixMutation (matrix s) j
  coefficient_self : ∀ s j, coefficient (mutation j s) j = (coefficient s j)⁻¹
  coefficient_other : ∀ s j i, i ≠ j → coefficient (mutation j s) i =
    coefficientMutation (coefficient s i) (coefficient s j) (coefficient s j + 1) (matrix s j i)

end TauCeti.Cluster
