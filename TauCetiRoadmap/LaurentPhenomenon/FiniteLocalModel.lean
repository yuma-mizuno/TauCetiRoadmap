/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.FiniteTheorem
public import TauCetiRoadmap.LaurentPhenomenon.PolynomialChartModel
public import TauCetiRoadmap.LaurentPhenomenon.Intersection

/-! # Finite Local Model -/

@[expose] public section

namespace TauCeti.Laurent

open Polynomial
open scoped LaurentPolynomial

noncomputable section

namespace RealizedCaterpillar

variable {F I : Type*} [Field F] {C : Subring F} {P : CaterpillarPath I}
variable (R₀ : RealizedCaterpillar C P)
variable {a b c d : P.Vertex} {i j : I}

/-- Concrete polynomial data for one three-edge configuration in a finite
caterpillar. The membership and coprimality of the third coordinate are outputs. -/
abbrev PolynomialLocalModel (hab : P.Edge a b i) (hbc : P.Edge b c j)
    (hij : i ≠ j) (S : Type*) [CommRing S] :=
  PolynomialChartModel (chartRing C (R₀.coord a))
    ⟨R₀.coord b i, R₀.edge_mem hab i⟩
    ⟨R₀.coord c j, R₀.two_edge_mem hab hbc hij j⟩ (R₀.coord d i) S

namespace PolynomialLocalModel

variable {R₀} {hab : P.Edge a b i} {hbc : P.Edge b c j} {hij : i ≠ j}
variable {S : Type*} [CommRing S] [IsDomain S] [UniqueFactorizationMonoid S]

theorem third_mem_and_relPrime (M : R₀.PolynomialLocalModel (d := d) hab hbc hij S) :
    ∃ hv : R₀.coord d i ∈ chartRing C (R₀.coord a),
      IsRelPrime (⟨R₀.coord b i, R₀.edge_mem hab i⟩ : chartRing C (R₀.coord a))
        ⟨R₀.coord c j, R₀.two_edge_mem hab hbc hij j⟩ ∧
      IsRelPrime (⟨R₀.coord b i, R₀.edge_mem hab i⟩ : chartRing C (R₀.coord a))
        ⟨R₀.coord d i, hv⟩ :=
  PolynomialChartModel.third_mem_and_relPrime M (R₀.coord_ne_zero b i)

theorem intersection (M : R₀.PolynomialLocalModel (d := d) hab hbc hij S)
    (hcd : P.Edge c d i) :
    chartRing C (R₀.coord b) ⊓ chartRing C (R₀.coord d) ≤ chartRing C (R₀.coord a) := by
  let := PolynomialChartModel.chart_uniqueFactorizationMonoid M
  obtain ⟨hv, hzu, hzv⟩ := M.third_mem_and_relPrime
  apply local_chart_intersection C (R₀.coord a) (R₀.coord b) (R₀.coord d) i j
    ⟨_, R₀.edge_mem hab i⟩ ⟨_, R₀.two_edge_mem hab hbc hij j⟩ ⟨_, hv⟩
    (R₀.coord_ne_zero b i) (R₀.coord_ne_zero c j) (R₀.coord_ne_zero d i)
    hzu hzv rfl (R₀.other_coord hab) rfl (R₀.other_coord hcd j hij.symm)
  intro k hki hkj
  rw [R₀.other_coord hcd k hki, R₀.other_coord hbc k hkj, R₀.other_coord hab k hki]

end PolynomialLocalModel
end RealizedCaterpillar
end
end TauCeti.Laurent
