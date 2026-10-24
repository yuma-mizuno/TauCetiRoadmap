/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.IntegerEvaluation
public import TauCetiRoadmap.LaurentPhenomenon.PositiveLaurentTheorem

/-! # Integer Specialization -/

@[expose] public section

noncomputable section
namespace TauCeti.Laurent
variable {G I : Type} [AddCommGroup G] [DecidableEq I]
  [IsDomain (TotalLaurentRing G I)]

namespace PositiveCaterpillar
variable [Finite I] {P : CaterpillarPath I} (T : PositiveCaterpillar G P)
/-- Integrality at the all-one initial chart follows from the actual Laurent theorem. -/
theorem allOnes_integral (k : I) :
    T.value allOnes P.target k ∈ (Int.castRingHom ℚ).range := by
  apply chartRing_allOnes_le (G := G) (I := I)
  have h := T.laurent allOnes allOnes_positive k
  convert h using 1
  congr 1
  funext i
  exact (T.value_source allOnes i).symm
end PositiveCaterpillar
end TauCeti.Laurent
