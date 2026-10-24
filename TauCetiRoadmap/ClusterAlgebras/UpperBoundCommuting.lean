/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.UpperBoundLocal
public import TauCetiRoadmap.LaurentPhenomenon.CommutingExchange
public import Mathlib.Algebra.MonoidAlgebra.Lift

/-! Faithful realizations of the commuting rank-two intersection (U2a). The
coprimality assumption is on the two actual exchange factors in the ring of
unchanged Laurent coordinates, not on the two exchanged variables. The
divisibility step is §0.6's central divisibility in the commutative case
(`TauCeti.Laurent.CommutingExchange.mem_exchangeRing_of_divisibility`). -/

@[expose] public section

noncomputable section
namespace TauCeti.Cluster.UpperBound
open TauCeti.Laurent.CommutingExchange
variable {F : Type*} [Field F]

/-- Evaluate an integer exponent pair at the two prescribed field units. -/
def pairCharacter (x y : Fˣ) : Multiplicative (ℤ × ℤ) →* F where
  toFun m := (x : F) ^ m.toAdd.1 * (y : F) ^ m.toAdd.2
  map_one' := by simp
  map_mul' m n := by
    change (x : F) ^ (m.toAdd.1 + n.toAdd.1) * (y : F) ^ (m.toAdd.2 + n.toAdd.2) = _
    rw [zpow_add₀ (Units.ne_zero x), zpow_add₀ (Units.ne_zero y)]
    ring

/-- Evaluate the formal bivariate Laurent ring in the ambient field at x and y. -/
def pairEval (C : Subring F) (x y : Fˣ) : BiLaurent C →+* F :=
  AddMonoidAlgebra.liftNCRingHom C.subtype (pairCharacter x y)
    (fun _ _ => Commute.all _ _)

@[simp] theorem pairEval_single (C : Subring F) (x y : Fˣ) (m : ℤ × ℤ) (a : C) :
    pairEval C x y (AddMonoidAlgebra.single m a) = (a : F) * (x : F) ^ m.1 * (y : F) ^ m.2 := by
  simp [pairEval, pairCharacter, mul_assoc]

theorem pairEval_exchangeRing (C : Subring F) (x y : Fˣ) (E H : C) :
    (exchangeRing E H).map (pairEval C x y) =
      fourRing C x ((E : F) / x) y ((H : F) / y) := by
  unfold exchangeRing fourRing generated
  rw [RingHom.map_closure, Set.image_union, Set.image_insert_eq, Set.image_insert_eq,
    Set.image_insert_eq, Set.image_singleton]
  have hC : pairEval C x y '' Set.range (fun a : C =>
      AddMonoidAlgebra.single (0, 0) a) = (C : Set F) := by
    ext z
    constructor
    · rintro ⟨p, ⟨a, rfl⟩, rfl⟩
      simp
    · intro hz
      exact ⟨_, ⟨⟨z, hz⟩, rfl⟩, by simp⟩
  rw [hC]
  simp [div_eq_mul_inv]

/-- Actual embedded commuting intersection, with an explicit faithful
evaluation of the two independent Laurent coordinates. -/
theorem commuting_intersection_embedded (C : Subring F) [DecompositionMonoid C]
    (x y : Fˣ) (E H : C) (hEH : IsRelPrime E H)
    (hinj : Function.Injective (pairEval C x y)) :
    generated C {(x : F), (E : F) / x, (y : F), (y : F)⁻¹} ⊓
      generated C {(x : F), (x : F)⁻¹, (y : F), (H : F) / y} =
        fourRing C x ((E : F) / x) y ((H : F) / y) := by
  have h := commuting_intersection_map E H hEH (pairEval C x y) hinj
  rw [pairEval_exchangeRing, pairEval_exchangeRing, pairEval_exchangeRing] at h
  simpa [fourRing] using h

end TauCeti.Cluster.UpperBound
