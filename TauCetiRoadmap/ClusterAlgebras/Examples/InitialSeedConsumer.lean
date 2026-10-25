/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.InitialLaurent
public import TauCetiRoadmap.ClusterAlgebras.GeometricLaurent
public import TauCetiRoadmap.ClusterAlgebras.Examples.Somos4Pattern

/-! A direct consumer of the initial-seed API: the explicit Somos-4 matrix,
trivial initial coefficients, and unit symmetrizer determine Laurent coordinates
after every mutation word, without user-supplied mutation laws.

The proof term of `initial_seed_laurent_representative`, followed through every constant of
this project, uses only the axioms `propext`, `Classical.choice` and `Quot.sound`; uses
`MatrixSeed.cluster_laurent_unique`, the general and principal Laurent theorems, the classical
unit-parameter construction and `PolynomialExchangeSeed.upperBound_mutate`; uses no
constant whose name contains `Caterpillar`, `universalLaurent` or `sorryAx`; and uses no
quantum word specialization, coefficient map `sp`, or auxiliary positive compatible form. -/

@[expose] public section
noncomputable section
open TauCeti.Laurent TauCeti.Cluster
namespace TauCeti.Examples.Somos4

theorem symmetrizerPositive : ∀ _ : Fin 4, 0 < (1 : ℤ) := fun _ => by norm_num
theorem initial_seed_laurent_representative (w : List (Fin 4)) (i : Fin 4) :
    ∃! p : TotalLaurentRing (Additive PUnit) (Fin 4),
      algebraMap _ (MatrixSeed.Ambient PUnit (Fin 4)) p =
        sourceSeed.cluster symmetrizerPositive w i :=
  sourceSeed.cluster_laurent_unique symmetrizerPositive w i

end TauCeti.Examples.Somos4

