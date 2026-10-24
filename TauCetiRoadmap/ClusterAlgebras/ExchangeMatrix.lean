/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.SeedCompatibility

/-! Exchange-matrix mutation and its sign-skew convention, independent of coefficients. -/

@[expose] public section
namespace TauCeti.Cluster
variable {I : Type*} [DecidableEq I]
/-- The standard exchange-matrix mutation formula. -/
def matrixMutation (B : I → I → ℤ) (j h k : I) : ℤ :=
  if h = j ∨ k = j then -B h k else
    B h k + positivePart (B h j) * positivePart (B j k) -
      positivePart (-B h j) * positivePart (-B j k)

/-- The two integers are either both zero or have strictly opposite signs. -/
def SignSkewAt (a b : ℤ) : Prop :=
  (a = 0 ∧ b = 0) ∨ (0 < a ∧ b < 0) ∨ (a < 0 ∧ 0 < b)

end TauCeti.Cluster
