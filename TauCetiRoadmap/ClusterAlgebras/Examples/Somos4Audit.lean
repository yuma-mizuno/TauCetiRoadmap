/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.Examples.Somos4
public import TauCetiRoadmap.ClusterAlgebras.GeometricLaurent

/-! # Somos4Audit -/

@[expose] public section

open TauCeti.Laurent
open TauCeti.Cluster

/-!
Regression checks for the standard rational Somos-4 sequence: its first values, and the
following checks on the proof terms of `sequence_integral`, `integral_of_recurrence` and
`sequence_positive_integral`, which follow every constant of this project transitively:

* each uses only the axioms `propext`, `Classical.choice` and `Quot.sound`;
* each uses no constant whose name contains `Caterpillar`, `universalLaurent` or `sorryAx`;
* none uses the classical full-rank theorem `FullRankGeometricSeed.laurent`, its invariance
  step `FullRankGeometricSeed.upperBound_mutation`, or the classical three-chart equalities
  `UpperBound.geometric_commuting_three_charts` and
  `UpperBound.geometric_interacting_three_chart`;
* `sequence_integral` uses `MatrixSeed.cluster_laurent_unique`, the general and principal
  Laurent theorems, the classical limit `principalGeometricWord_laurent_of_quantum` and quantum
  upper-bound invariance `QuantumSeed.upperBound_mutate`.
-/
open TauCeti.Examples.Somos4

example : TauCeti.Examples.Somos4.sequence 4 = 2 := by
  norm_num [TauCeti.Examples.Somos4.sequence, window, step]
example : TauCeti.Examples.Somos4.sequence 5 = 3 := by
  norm_num [TauCeti.Examples.Somos4.sequence, window, step]
example : TauCeti.Examples.Somos4.sequence 6 = 7 := by
  norm_num [TauCeti.Examples.Somos4.sequence, window, step]
example : TauCeti.Examples.Somos4.sequence 7 = 23 := by
  norm_num [TauCeti.Examples.Somos4.sequence, window, step]
example : TauCeti.Examples.Somos4.sequence 8 = 59 := by
  norm_num [TauCeti.Examples.Somos4.sequence, window, step]

example (a : ℕ → ℚ) (hinit : ∀ i : Fin 4, a i.val = 1)
    (hrec : ∀ n, a (n + 4) * a n = a (n + 1) * a (n + 3) + (a (n + 2)) ^ 2) :
    ∀ n, ∃ z : ℤ, (z : ℚ) = a n := integral_of_recurrence a hinit hrec

