/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.ExchangeFrame
public import TauCetiRoadmap.LaurentPhenomenon.Quantum.Sign

/-! # Opposite based quantum frames over an arbitrary scalar ring -/

@[expose] public section

namespace TauCeti.Cluster
open TauCeti TauCeti.QuantumTorus TauCeti.Laurent MulOpposite

section Vectors

variable {M K : Type*} [DecidableEq M] (row : K ↪ M) (B : Matrix M K ℤ) (k : K)

/-- Negating `B_ext` turns the first exchange exponent into the second. -/
theorem exchangeExponentPos_neg :
    exchangeExponentPos row (-B) k = exchangeExponentNeg row B k := by
  funext i
  simp [exchangeExponentPos, exchangeExponentNeg]

/-- Negating `B_ext` turns the second exchange exponent into the first. -/
theorem exchangeExponentNeg_neg :
    exchangeExponentNeg row (-B) k = exchangeExponentPos row B k := by
  funext i
  simp [exchangeExponentPos, exchangeExponentNeg]

end Vectors

namespace ExchangeFrame
noncomputable section
variable {R₀ : Type*} [CommRing R₀] {u₀ : R₀ˣ}
  {D : Type*} [DivisionRing D] [Algebra R₀ D]
  {M K : Type*} [Fintype M] [DecidableEq M] {row : K ↪ M}
  (s : ExchangeFrame (u₀ := u₀) D row)

section Opposite

/-- The coordinates `op X_i` of `Dᵐᵒᵖ`. -/
def oppositeCoordinate (i : M) : (Dᵐᵒᵖ)ˣ := Units.opEquiv.symm (op (s.coordinate i))
@[simp] theorem val_oppositeCoordinate (i : M) :
    (s.oppositeCoordinate i : Dᵐᵒᵖ) = op (s.coordinate i : D) :=
  rfl

theorem oppositeCoordinate_quasiCommuting :
    IsQuasiCommuting u₀ (matrixForm (-s.form)) s.oppositeCoordinate := by
  intro i j
  rw [val_oppositeCoordinate, val_oppositeCoordinate, ← op_mul, s.quasiCommuting j i, op_smul,
    op_mul, matrixForm_neg, matrixForm_single_single, matrixForm_single_single,
    s.alternating i j, neg_neg]

/-- The chart of the opposite seed, `X ^ a ↦ M'(a)` for `(v, -Λ)` in `Dᵐᵒᵖ`. -/
def oppositeChart : quantumTorus R₀ u₀ (matrixForm (-s.form)) →ₐ[R₀] Dᵐᵒᵖ :=
  QuantumTorus.lift s.alternating.neg.isAlt s.oppositeCoordinate
    s.oppositeCoordinate_quasiCommuting

/-- The opposite isomorphism `T(R₀,v,Λ)ᵐᵒᵖ ≃ₐ[R₀] T(R₀,v,-Λ)` of the form of `s`. -/
def formOpEquiv :
    (quantumTorus R₀ u₀ (matrixForm s.form))ᵐᵒᵖ ≃ₐ[R₀]
      quantumTorus R₀ u₀ (matrixForm (-s.form)) :=
  QuantumTorus.opAlgEquiv fun a b ↦ by
    rw [matrixForm_neg, s.alternating.matrixForm_swap a b, neg_neg]

@[simp] theorem formOpEquiv_symm_monomial (a : M → ℤ) :
    s.formOpEquiv.symm (QuantumTorus.monomial a) = op (QuantumTorus.monomial a) :=
  opAlgEquiv_symm_monomial _ a

/-- **The opposite chart is derived from the opposite isomorphism**:
`oppositeChart = chartᵒᵖ ∘ opAlgEquiv⁻¹`. -/
theorem oppositeChart_eq :
    s.oppositeChart = (AlgHom.op s.chart).comp s.formOpEquiv.symm.toAlgHom :=
  algHom_ext_single s.alternating.neg.isAlt fun i ↦ by
    change _ = AlgHom.op s.chart (s.formOpEquiv.symm (QuantumTorus.monomial (Pi.single i 1)))
    rw [oppositeChart, lift_monomial_single, formOpEquiv_symm_monomial, AlgHom.op_apply_apply,
      unop_op, val_oppositeCoordinate, show s.chart (QuantumTorus.monomial (Pi.single i 1)) =
        s.monomial (Pi.single i 1) from rfl, monomial_single]

theorem oppositeChart_apply (x : quantumTorus R₀ u₀ (matrixForm (-s.form))) :
    s.oppositeChart x = op (s.chart (unop (s.formOpEquiv.symm x))) := by
  rw [oppositeChart_eq]
  rfl

/-- **The cocycle check.** The normalized monomials of the opposite seed are the opposites of the
normalized monomials of `s`. -/
theorem oppositeChart_monomial (a : M → ℤ) :
    s.oppositeChart (QuantumTorus.monomial a) = op (s.monomial a) := by
  rw [oppositeChart_apply, formOpEquiv_symm_monomial, unop_op]
  rfl

theorem oppositeChart_injective : Function.Injective s.oppositeChart := by
  intro x y h
  rw [oppositeChart_apply, oppositeChart_apply] at h
  exact s.formOpEquiv.symm.injective (unop_injective (s.chart_injective (op_injective h)))

/-- **The opposite-algebra comparison** `(Λ, B_ext) ↦ (-Λ, -B_ext)` with `v` fixed: the elements
`op X_i` form a quantum seed of `Dᵐᵒᵖ` with form `-Λ`, extended matrix `-B_ext` and the same
symmetrizer. -/
def opposite : ExchangeFrame (u₀ := u₀) Dᵐᵒᵖ row where
  exchange := s.exchange.neg
  form := -s.form
  alternating := s.alternating.neg
  formWeight := s.formWeight
  compatible := s.compatible.neg
  independentColumns := by
    convert! s.independentColumns.neg using 1
  coordinate := s.oppositeCoordinate
  quasiCommuting := s.oppositeCoordinate_quasiCommuting
  faithful := s.oppositeChart_injective

@[simp] theorem opposite_exchange : s.opposite.exchange.matrix = -s.exchange.matrix := rfl
@[simp] theorem opposite_form : s.opposite.form = -s.form := rfl
@[simp] theorem val_opposite_coordinate (i : M) :
    (s.opposite.coordinate i : Dᵐᵒᵖ) = op (s.coordinate i : D) := rfl

@[simp] theorem opposite_monomial (a : M → ℤ) : s.opposite.monomial a = op (s.monomial a) :=
  s.oppositeChart_monomial a

/-- The first exchange summand of the opposite seed is the opposite of the second summand of
`s`. -/
theorem opposite_monomial_exchangeExponentPos (k : K) :
    s.opposite.monomial (exchangeExponentPos row s.opposite.exchange.matrix k) =
      op (s.monomial (exchangeExponentNeg row s.exchange.matrix k)) := by
  rw [opposite_exchange, exchangeExponentPos_neg, opposite_monomial]

/-- The second exchange summand of the opposite seed is the opposite of the first summand of
`s`. -/
theorem opposite_monomial_exchangeExponentNeg (k : K) :
    s.opposite.monomial (exchangeExponentNeg row s.opposite.exchange.matrix k) =
      op (s.monomial (exchangeExponentPos row s.exchange.matrix k)) := by
  rw [opposite_exchange, exchangeExponentNeg_neg, opposite_monomial]

theorem opposite_exchangeCoordinate (k : K) :
    s.opposite.exchangeCoordinate k = op (s.exchangeCoordinate k) := by
  rw [exchangeCoordinate, s.opposite_monomial_exchangeExponentPos,
    s.opposite_monomial_exchangeExponentNeg, exchangeCoordinate, op_add, add_comm]

end Opposite

end
end ExchangeFrame
end TauCeti.Cluster
