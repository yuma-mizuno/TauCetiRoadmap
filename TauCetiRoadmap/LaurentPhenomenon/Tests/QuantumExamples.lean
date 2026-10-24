/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.Quantum.Ore

/-! Instance checks for quantum tori: quantum tori over a domain are domains, the Ore
localization of a quantum torus over a field is a division ring, and the integral chart over
`Zv` into it is an injective `Zv`-algebra map. -/

@[expose] public section

namespace TauCeti.QuantumTorus.Tests

open TauCeti TauCeti.QuantumTorus

example {R : Type*} [CommRing R] [IsDomain R] {u : Rˣ} {M : Type*} [Fintype M]
    {Λ : LinearMap.BilinForm ℤ (M → ℤ)} : IsDomain (quantumTorus R u Λ) :=
  inferInstance

noncomputable example (K : Type*) [Field K] {M : Type*} [Finite M] (u : Kˣ)
    (Λ : LinearMap.BilinForm ℤ (M → ℤ)) : DivisionRing (FractionDivisionRing K u Λ) :=
  inferInstance

noncomputable example {M : Type*} [Finite M] (Λ : LinearMap.BilinForm ℤ (M → ℤ)) :
    Algebra Zv (FractionDivisionRing (FractionRing Zv)
      (Units.map (algebraMap Zv (FractionRing Zv) : Zv →* FractionRing Zv) vUnit) Λ) :=
  inferInstance

example {M : Type*} [Finite M] (Λ : LinearMap.BilinForm ℤ (M → ℤ)) :
    Function.Injective (integralChart Zv (FractionRing Zv) vUnit Λ) :=
  integralChart_injective _ _ _ _

end TauCeti.QuantumTorus.Tests
