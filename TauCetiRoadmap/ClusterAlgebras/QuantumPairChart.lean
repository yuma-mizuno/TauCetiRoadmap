/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.QuantumSubsetRing
public import TauCetiRoadmap.ClusterAlgebras.QuantumSupport

/-!
# The quantum torus on coordinates outside a pair

The restricted lattice chart is faithful and its image is the pair coordinate ring.
-/

@[expose] public section

namespace TauCeti.Cluster.QuantumSeed

open TauCeti TauCeti.QuantumTorus TauCeti.Laurent

noncomputable section

variable {D : Type*} [DivisionRing D] [Algebra Zv D]
  {M K : Type*} [Fintype M] [DecidableEq M] {row : K ↪ M}
  (s : QuantumSeed D row)

/-! ### `pairRing` as the ring of a set of coordinates -/

theorem pairRing_eq_subsetRing (a b : M) :
    s.pairRing a b = s.subsetRing {l | l ≠ a ∧ l ≠ b} := rfl

/-- If `b_{b, k} = 0`, the column `b_{•k}` vanishes off the coordinates other than `row k, b`. -/
theorem exchange_eq_zero_of_not_mem_pair {k : K} {b : M}
    (hb : s.exchange.matrix b k = 0) : ∀ l ∉ {l | l ≠ row k ∧ l ≠ b}, s.exchange.matrix l k
        = 0 := by
  intro l hl
  simp only [Set.mem_ofPred_eq, not_and_or, not_not] at hl
  rcases hl with rfl | rfl
  · exact s.exchange.diagonal k
  · exact hb

/-! ### `pairRing` as a quantum torus -/

/-- The exponents vanishing at `a` and `b`: the lattice of the quantum torus `pairRing a b`. -/
def pairLattice (a b : M) : AddSubgroup (M → ℤ) where
  carrier := {e | e a = 0 ∧ e b = 0}
  add_mem' := by
    rintro x y ⟨hx, hx'⟩ ⟨hy, hy'⟩
    exact ⟨by simp [hx, hy], by simp [hx', hy']⟩
  zero_mem' := ⟨rfl, rfl⟩
  neg_mem' := by
    rintro x ⟨hx, hx'⟩
    exact ⟨by simp [hx], by simp [hx']⟩

/-- The restriction of `Λ` to `pairLattice a b`. -/
def pairTorusForm (a b : M) : LinearMap.BilinForm ℤ (pairLattice a b) :=
  (matrixForm s.form).compl₁₂ (pairLattice a b).subtype.toIntLinearMap
    (pairLattice a b).subtype.toIntLinearMap

/-- The chart of the quantum torus on `pairLattice a b`, `X ^ e ↦ M(e)`. It is injective
(`pairTorusChart_injective`) with image `pairRing a b` (`pairTorusChart_mem_pairRing`,
`exists_pairTorusChart_eq`). -/
def pairTorusChart (a b : M) : quantumTorus Zv vUnit (s.pairTorusForm a b) →ₐ[Zv] D :=
  TwistedMonoidAlgebra.lift
    (fun g ↦ s.monomial ((Multiplicative.toAdd g : pairLattice a b) : M → ℤ))
    (by simp) (fun g h ↦ by rw [monomial_mul_monomial, Algebra.smul_def]; rfl)

theorem pairTorusChart_monomial (a b : M) (x : pairLattice a b) :
    s.pairTorusChart a b (QuantumTorus.monomial x) = s.monomial x :=
  TwistedMonoidAlgebra.lift_of _ _ _ _

theorem pairTorusChart_injective (a b : M) : Function.Injective (s.pairTorusChart a b) := by
  rw [algHom_injective_iff]
  have := s.linearIndependent_monomial.comp (Subtype.val : pairLattice a b → M → ℤ)
    Subtype.val_injective
  convert this using 1
  funext x
  exact s.pairTorusChart_monomial a b x

theorem pairTorusChart_mem_pairRing (a b : M) (x : quantumTorus Zv vUnit (s.pairTorusForm a b)) :
    s.pairTorusChart a b x ∈ s.pairRing a b := by
  rw [← sum_coeff_smul_monomial x, map_sum]
  refine Subring.sum_mem _ fun e _ ↦ ?_
  rw [map_smul, pairTorusChart_monomial, Algebra.smul_def]
  exact Subring.mul_mem _ (s.algebraMap_mem_pairRing _ _ _) (s.monomial_mem_pairRing e.2.1 e.2.2)

theorem exists_pairTorusChart_eq (a b : M) {c : D} (hc : c ∈ s.pairRing a b) :
    ∃ x, s.pairTorusChart a b x = c := by
  have hle : s.pairRing a b ≤ (s.pairTorusChart a b).range.toSubring := by
    refine chartRing_le ?_ (fun l ↦ ?_) (fun l ↦ ?_)
    · rintro _ ⟨r, rfl⟩
      exact ⟨algebraMap Zv _ r, AlgHom.commutes _ r⟩
    · refine ⟨QuantumTorus.monomial ⟨Pi.single (l : M) 1, ?_, ?_⟩, ?_⟩
      · simp [Ne.symm l.2.1]
      · simp [Ne.symm l.2.2]
      · change s.pairTorusChart a b _ = _
        rw [pairTorusChart_monomial]
        exact s.monomial_single l
    · refine ⟨QuantumTorus.monomial ⟨-Pi.single (l : M) 1, ?_, ?_⟩, ?_⟩
      · simp [Ne.symm l.2.1]
      · simp [Ne.symm l.2.2]
      · change s.pairTorusChart a b _ = _
        rw [pairTorusChart_monomial]
        exact s.monomial_neg_single l
  exact hle hc

end

end TauCeti.Cluster.QuantumSeed
