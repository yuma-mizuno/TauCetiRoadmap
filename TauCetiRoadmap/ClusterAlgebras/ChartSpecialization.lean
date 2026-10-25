/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.ExchangeFrame
public import TauCetiRoadmap.LaurentPhenomenon.Quantum.Specialization

/-!
# Classical values of integral quantum Laurent representatives

Specialization is a relation through an integral chart. It makes no claim of a
homomorphism from the ambient division ring to a commutative field.
-/

@[expose] public section

namespace TauCeti.Cluster

open TauCeti TauCeti.QuantumTorus TauCeti.Laurent

noncomputable section

/-! ### Elements with a prescribed classical limit -/

section Specializes

variable {D : Type*} [Ring D] [Algebra Zv D] {L : Type*} [AddCommGroup L]
  {Λ : LinearMap.BilinForm ℤ L} {F : Type*} [CommRing F]
  (χ : quantumTorus Zv vUnit Λ →ₐ[Zv] D) (ε : AddMonoidAlgebra ℤ L →+* F)

/-- `y` is the image under the chart `χ` of a quantum Laurent polynomial whose classical limit
evaluates to `z` under `ε`. -/
def ChartSpecializes (y : D) (z : F) : Prop :=
  ∃ f, χ f = y ∧ ε (sp Λ f) = z

namespace ChartSpecializes

variable {χ ε}

theorem chart (f : quantumTorus Zv vUnit Λ) : ChartSpecializes χ ε (χ f) (ε (sp Λ f)) :=
  ⟨f, rfl, rfl⟩

theorem one : ChartSpecializes χ ε (1 : D) (1 : F) :=
  ⟨1, map_one _, by rw [map_one, map_one]⟩

theorem algebraMap (c : Zv) :
    ChartSpecializes χ ε (Algebra.algebraMap Zv D c) (evalOne c : F) :=
  ⟨Algebra.algebraMap Zv _ c, χ.commutes c, by
    rw [sp_algebraMap]
    exact eq_intCast (ε.comp AddMonoidAlgebra.singleZeroRingHom) (evalOne c)⟩

theorem mul {y y' : D} {z z' : F} (h : ChartSpecializes χ ε y z)
    (h' : ChartSpecializes χ ε y' z') : ChartSpecializes χ ε (y * y') (z * z') := by
  obtain ⟨f, rfl, rfl⟩ := h
  obtain ⟨f', rfl, rfl⟩ := h'
  exact ⟨f * f', map_mul _ _ _, by rw [map_mul, map_mul]⟩

theorem add {y y' : D} {z z' : F} (h : ChartSpecializes χ ε y z)
    (h' : ChartSpecializes χ ε y' z') : ChartSpecializes χ ε (y + y') (z + z') := by
  obtain ⟨f, rfl, rfl⟩ := h
  obtain ⟨f', rfl, rfl⟩ := h'
  exact ⟨f + f', map_add _ _ _, by rw [map_add, map_add]⟩

theorem zero : ChartSpecializes χ ε (0 : D) (0 : F) :=
  ⟨0, map_zero _, by rw [map_zero, map_zero]⟩

theorem sum {I : Type*} (S : Finset I) {y : I → D} {z : I → F}
    (h : ∀ i ∈ S, ChartSpecializes χ ε (y i) (z i)) :
    ChartSpecializes χ ε (∑ i ∈ S, y i) (∑ i ∈ S, z i) := by
  classical
  induction S using Finset.induction_on with
  | empty => simpa using (zero : ChartSpecializes χ ε (0 : D) (0 : F))
  | @insert i S hi ih =>
    rw [Finset.sum_insert hi, Finset.sum_insert hi]
    exact (h i (Finset.mem_insert_self _ _)).add
      (ih fun j hj ↦ h j (Finset.mem_insert_of_mem hj))

/-- Powers of `v` specialize to `1`. -/
theorem vUnit_zpow_mul {y : D} {z : F} (h : ChartSpecializes χ ε y z) (n : ℤ) :
    ChartSpecializes χ ε (Algebra.algebraMap Zv D ((vUnit ^ n : Zvˣ) : Zv) * y) z := by
  simpa only [evalOne_vUnit_zpow, Int.cast_one, one_mul] using
    (algebraMap ((vUnit ^ n : Zvˣ) : Zv)).mul h

theorem pow {y : D} {z : F} (h : ChartSpecializes χ ε y z) (n : ℕ) :
    ChartSpecializes χ ε (y ^ n) (z ^ n) := by
  induction n with
  | zero => simpa using (one : ChartSpecializes χ ε (1 : D) (1 : F))
  | succ n ih => simpa only [pow_succ] using ih.mul h

/-- Through an injective chart the classical value is unique. -/
theorem unique (hχ : Function.Injective χ) {y : D} {z z' : F} (h : ChartSpecializes χ ε y z)
    (h' : ChartSpecializes χ ε y z') : z = z' := by
  obtain ⟨f, hf, rfl⟩ := h
  obtain ⟨f', hf', rfl⟩ := h'
  rw [hχ (hf.trans hf'.symm)]

end ChartSpecializes

end Specializes

section SpecializesField

variable {D : Type*} [DivisionRing D] [Algebra Zv D] {L : Type*} [AddCommGroup L]
  {Λ : LinearMap.BilinForm ℤ L} {F : Type*} [Field F]
  {χ : quantumTorus Zv vUnit Λ →ₐ[Zv] D} {ε : AddMonoidAlgebra ℤ L →+* F}

namespace ChartSpecializes

theorem zpow {y : D} {z : F} (h : ChartSpecializes χ ε y z) {n : ℤ} (hn : 0 ≤ n) :
    ChartSpecializes χ ε (y ^ n) (z ^ n) := by
  obtain ⟨n, rfl⟩ := Int.eq_ofNat_of_zero_le hn
  simpa only [zpow_natCast] using h.pow n

variable {M : Type*}

theorem orderedProd {U : M → Dˣ} {g : M → F}
    (hU : ∀ i, ChartSpecializes χ ε (U i : D) (g i)) {m : M → ℤ} (hm : ∀ i, 0 ≤ m i)
    (l : List M) :
    ChartSpecializes χ ε ((orderedProd U l m : Dˣ) : D) (l.map fun i ↦ g i ^ m i).prod := by
  induction l with
  | nil => simpa using (one : ChartSpecializes χ ε (1 : D) (1 : F))
  | cons i l ih =>
    rw [orderedProd_cons, Units.val_mul, Units.val_zpow_eq_zpow_val, List.map_cons,
      List.prod_cons]
    exact ((hU i).zpow (hm i)).mul ih

end ChartSpecializes

/-- A normalized monomial with nonnegative exponents of a quantum seed whose coordinates have
classical limits `g_i` has classical limit `∏ g_i^{m_i}`: the scalar is a power of `v`. -/
theorem ExchangeFrame.chartSpecializes_monomial {M K : Type*} [Fintype M]
    [DecidableEq M] {row : K ↪ M} (t : ExchangeFrame (u₀ := vUnit) D row) {g : M → F}
    (hg : ∀ i, ChartSpecializes χ ε (t.coordinate i : D) (g i)) {m : M → ℤ}
    (hm : ∀ i, 0 ≤ m i) : ChartSpecializes χ ε (t.monomial m) (∏ i, g i ^ m i) := by
  rw [ExchangeFrame.monomial, ExchangeFrame.chart, lift_monomial, normalizedProd, Algebra.smul_def,
    ← Finset.prod_map_toList]
  exact (ChartSpecializes.orderedProd hg hm _).vUnit_zpow_mul _

end SpecializesField

end
end TauCeti.Cluster
