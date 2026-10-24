/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.Normalization
public import TauCetiRoadmap.LaurentPhenomenon.CoordinateEvaluation

/-! # Seed Evaluation -/

@[expose] public section

open TauCeti.Laurent

noncomputable section
namespace TauCeti.Cluster
open scoped BigOperators
variable {I F : Type*} [DecidableEq I] [Field F]

omit [DecidableEq I] in
theorem coordinateEvaluate_seedExchange {C : Type*} [CoefficientSemifield C]
    [Fintype I] (f : TotalLaurentRing (Additive C) I →+* F)
    (hf : ∀ g, f (AddMonoidAlgebra.single (g, 0) 1) = 1)
    (y : C) (b : I → ℤ) (x : I → F) :
    coordinateEvaluate f (seedExchange y b) x =
      (∏ i, x i ^ positivePart (b i)) +
        ∏ i, x i ^ positivePart (-b i) := by
  classical
  rw [seedExchange, coordinateEvaluate_add,
    coordinateEvaluate_single_one f _ _ _ (hf _),
    coordinateEvaluate_single_one f _ _ _ (hf _)]
  simp only [columnPositiveExponent_apply]

end TauCeti.Cluster
