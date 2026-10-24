/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.QuantumSeed
public import TauCetiRoadmap.LaurentPhenomenon.Quantum.Sign

/-!
# Sign comparisons of quantum seeds

Two comparisons send a quantum seed with data `(v, Λ, B_ext)` to a quantum seed with data
`(-Λ, -B_ext)` (§1.5). Both are derived from the torus isomorphisms of
`LaurentPhenomenon/Quantum/Sign.lean`, which fix every monomial `X ^ a`:

* the **coefficient-semilinear comparison**, from the bar isomorphism
  `QuantumTorus.barEquiv : T(Zv,v,Λ) ≃+* T(Zv,v,-Λ)`, semilinear along `v ↦ v⁻¹`: along any ring
  map `φ : D →+* D'` with `φ (r • 1) = r_bar • 1`, the chart of the transported seed is
  `φ ∘ chart ∘ barEquiv⁻¹` (`QuantumSeed.barChart_apply`) and the elements `φ X_i` form a seed
  (`QuantumSeed.barMap`); `QuantumSeed.bar` is the case of `D` itself with the twisted
  `Zv`-algebra structure `BarTwist D`;
* the **opposite-algebra comparison**, from `QuantumTorus.opAlgEquiv :
  T(Zv,v,Λ)ᵐᵒᵖ ≃ₐ[Zv] T(Zv,v,-Λ)`: the chart of the opposite seed is `chartᵒᵖ ∘ opAlgEquiv⁻¹`
  (`QuantumSeed.oppositeChart_apply`) and the elements `op X_i` form a seed of `Dᵐᵒᵖ`
  (`QuantumSeed.opposite`).

In both cases the transported pair is compatible with the same symmetrizer, the normalized
monomials are the images of the old ones (`barMap_monomial`, `opposite_monomial`), the two exchange
summands are interchanged (`barMap_monomial_exchangeExponentPos`, ...), and mutation commutes with
the comparison (`barMap_mutate`, `opposite_mutate`).
-/

@[expose] public section

namespace TauCeti.Cluster

open TauCeti TauCeti.QuantumTorus TauCeti.Laurent MulOpposite

/-! ### Exponents and scalars -/

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

theorem vUnit_zpow_val (n : ℤ) : ((vUnit ^ n : Zvˣ) : Zv) = LaurentPolynomial.T n := by
  have h : ∀ m : ℕ, ((vUnit ^ m : Zvˣ) : Zv) = LaurentPolynomial.T m := fun m ↦ by
    rw [Units.val_pow_eq_pow_val, vUnit_val, LaurentPolynomial.T_pow, mul_one]
  cases n with
  | ofNat m => exact h m
  | negSucc m =>
    rw [zpow_negSucc]
    refine Units.inv_eq_of_mul_eq_one_right ?_
    rw [h, ← LaurentPolynomial.T_add, Int.negSucc_eq]
    push_cast
    rw [add_neg_cancel, LaurentPolynomial.T_zero]

/-- The bar involution `v ↦ v⁻¹` inverts the powers of `v`. -/
theorem invert_vUnit_zpow (n : ℤ) :
    LaurentPolynomial.invert ((vUnit ^ n : Zvˣ) : Zv) = ((vUnit ^ (-n) : Zvˣ) : Zv) := by
  rw [vUnit_zpow_val, vUnit_zpow_val, LaurentPolynomial.invert_T]

/-! ### The bar-twisted algebra structure -/

/-- `D` with its `Zv`-algebra structure twisted by the bar involution `v ↦ v⁻¹`: `r ∈ Zv` acts
through `r_bar`. -/
def BarTwist (D : Type*) : Type _ := D
namespace BarTwist

variable (D : Type*) [DivisionRing D]

instance : DivisionRing (BarTwist D) := inferInstanceAs (DivisionRing D)

/-- The identity of `D` as a ring isomorphism onto `BarTwist D`. -/
def toBarTwist : D ≃+* BarTwist D := RingEquiv.refl D
variable [Algebra Zv D]

noncomputable instance : Algebra Zv (BarTwist D) :=
  Algebra.compHom D (LaurentPolynomial.invert : Zv ≃ₐ[ℤ] Zv).toRingEquiv.toRingHom

variable {D}

theorem algebraMap_apply (r : Zv) :
    algebraMap Zv (BarTwist D) r = toBarTwist D (algebraMap Zv D (LaurentPolynomial.invert r)) :=
  rfl

/-- `toBarTwist` is semilinear for the bar involution. -/
theorem toBarTwist_algebraMap (r : Zv) :
    toBarTwist D (algebraMap Zv D r) = algebraMap Zv (BarTwist D) (LaurentPolynomial.invert r) := by
  rw [algebraMap_apply, LaurentPolynomial.involutive_invert r]

end BarTwist

namespace QuantumSeed

noncomputable section

variable {D : Type*} [DivisionRing D] [Algebra Zv D] {M K : Type*} [Fintype M] [DecidableEq M]
  {row : K ↪ M} (s : QuantumSeed D row)

/-! ### The coefficient-semilinear comparison -/

section Bar

variable {D' : Type*} [DivisionRing D'] [Algebra Zv D'] (φ : D →+* D')
  (hφ : ∀ r, φ (algebraMap Zv D r) = algebraMap Zv D' (LaurentPolynomial.invert r))

/-- The coordinates `φ X_i`. -/
def barCoordinate (i : M) : D'ˣ := Units.map (φ : D →* D') (s.coordinate i)
omit [Algebra Zv D'] in
@[simp] theorem val_barCoordinate (i : M) : (s.barCoordinate φ i : D') = φ (s.coordinate i) :=
  rfl

include hφ in
theorem map_algebraMap_vUnit_zpow (n : ℤ) :
    φ (algebraMap Zv D ((vUnit ^ n : Zvˣ) : Zv)) =
      algebraMap Zv D' ((vUnit ^ (-n) : Zvˣ) : Zv) := by
  rw [hφ, invert_vUnit_zpow]

include hφ in
theorem barCoordinate_quasiCommuting :
    IsQuasiCommuting vUnit (matrixForm (-s.form)) (s.barCoordinate φ) := by
  intro i j
  rw [val_barCoordinate, val_barCoordinate, ← map_mul, s.quasiCommuting i j, Algebra.smul_def,
    map_mul, map_mul, map_algebraMap_vUnit_zpow φ hφ, Algebra.smul_def, matrixForm_neg, mul_neg]

/-- The chart of the transported seed, `X ^ a ↦ M'(a)` for `(v, -Λ)` in `D'`. -/
def barChart : quantumTorus Zv vUnit (matrixForm (-s.form)) →ₐ[Zv] D' :=
  QuantumTorus.lift s.alternating.neg.isAlt (s.barCoordinate φ)
    (s.barCoordinate_quasiCommuting φ hφ)

/-- The bar isomorphism `T(Zv,v,Λ) ≃+* T(Zv,v,-Λ)` of the form of `s`. -/
def formBarEquiv :
    quantumTorus Zv vUnit (matrixForm s.form) ≃+* quantumTorus Zv vUnit (matrixForm (-s.form)) :=
  QuantumTorus.barEquiv (matrixForm_neg s.form)

@[simp] theorem formBarEquiv_symm_monomial (a : M → ℤ) :
    s.formBarEquiv.symm (QuantumTorus.monomial a) = QuantumTorus.monomial a := by
  rw [RingEquiv.symm_apply_eq, formBarEquiv, barEquiv_monomial]

/-- The `Zv`-algebra map `φ ∘ chart ∘ barEquiv⁻¹ : T(Zv,v,-Λ) → D'`. -/
def barChartOfEquiv : quantumTorus Zv vUnit (matrixForm (-s.form)) →ₐ[Zv] D' :=
  { (φ.comp (s.chart : quantumTorus Zv vUnit (matrixForm s.form) →+* D)).comp
      (s.formBarEquiv.symm : quantumTorus Zv vUnit (matrixForm (-s.form)) →+*
        quantumTorus Zv vUnit (matrixForm s.form)) with
    commutes' := fun c ↦ by
      have h : s.formBarEquiv.symm (algebraMap Zv _ c) =
          algebraMap Zv _ (LaurentPolynomial.invert c) := by
        rw [RingEquiv.symm_apply_eq, formBarEquiv, barEquiv_algebraMap,
          LaurentPolynomial.involutive_invert]
      change φ (s.chart (s.formBarEquiv.symm (algebraMap Zv _ c))) = algebraMap Zv D' c
      rw [h, AlgHom.commutes, hφ, LaurentPolynomial.involutive_invert c] }

theorem barChartOfEquiv_monomial (a : M → ℤ) :
    s.barChartOfEquiv φ hφ (QuantumTorus.monomial a) = φ (s.monomial a) := by
  change φ (s.chart (s.formBarEquiv.symm (QuantumTorus.monomial a))) = _
  rw [formBarEquiv_symm_monomial]
  rfl

/-- **The transported chart is derived from the bar isomorphism**:
`barChart = φ ∘ chart ∘ barEquiv⁻¹`. -/
theorem barChart_eq : s.barChart φ hφ = s.barChartOfEquiv φ hφ :=
  algHom_ext_single s.alternating.neg.isAlt fun i ↦ by
    rw [barChart, lift_monomial_single, barChartOfEquiv_monomial, monomial_single,
      val_barCoordinate]

theorem barChart_apply (x : quantumTorus Zv vUnit (matrixForm (-s.form))) :
    s.barChart φ hφ x = φ (s.chart (s.formBarEquiv.symm x)) := by
  rw [barChart_eq]
  rfl

/-- **The cocycle check.** The normalized monomials of the transported seed are the images of
the normalized monomials of `s`. -/
theorem barChart_monomial (a : M → ℤ) :
    s.barChart φ hφ (QuantumTorus.monomial a) = φ (s.monomial a) := by
  rw [barChart_eq, barChartOfEquiv_monomial]

theorem barChart_injective : Function.Injective (s.barChart φ hφ) := by
  intro x y h
  rw [barChart_apply, barChart_apply] at h
  exact s.formBarEquiv.symm.injective (s.chart_injective (φ.injective h))

/-- **The coefficient-semilinear comparison** `(v, Λ, B_ext) ↦ (v⁻¹, -Λ, -B_ext)`. Along a ring map
`φ : D →+* D'` with `φ (r • 1) = r_bar • 1`, the elements `φ X_i` form a quantum seed of `D'` with
form `-Λ`, extended matrix `-B_ext` and the same symmetrizer. -/
def barMap : QuantumSeed D' row where
  exchange := s.exchange.neg
  form := -s.form
  alternating := s.alternating.neg
  compatible := s.compatible.neg
  coordinate := s.barCoordinate φ
  quasiCommuting := s.barCoordinate_quasiCommuting φ hφ
  faithful := s.barChart_injective φ hφ

@[simp] theorem barMap_exchange : (s.barMap φ hφ).exchange.matrix = -s.exchange.matrix := rfl
@[simp] theorem barMap_form : (s.barMap φ hφ).form = -s.form := rfl
@[simp] theorem val_barMap_coordinate (i : M) :
    ((s.barMap φ hφ).coordinate i : D') = φ (s.coordinate i) := rfl

@[simp] theorem barMap_monomial (a : M → ℤ) : (s.barMap φ hφ).monomial a = φ (s.monomial a) :=
  s.barChart_monomial φ hφ a

/-- The first exchange summand of the transported seed is the image of the second summand of
`s`. -/
theorem barMap_monomial_exchangeExponentPos (k : K) :
    (s.barMap φ hφ).monomial (exchangeExponentPos row (s.barMap φ hφ).exchange.matrix k) =
      φ (s.monomial (exchangeExponentNeg row s.exchange.matrix k)) := by
  rw [barMap_exchange, exchangeExponentPos_neg, barMap_monomial]

/-- The second exchange summand of the transported seed is the image of the first summand of
`s`. -/
theorem barMap_monomial_exchangeExponentNeg (k : K) :
    (s.barMap φ hφ).monomial (exchangeExponentNeg row (s.barMap φ hφ).exchange.matrix k) =
      φ (s.monomial (exchangeExponentPos row s.exchange.matrix k)) := by
  rw [barMap_exchange, exchangeExponentNeg_neg, barMap_monomial]

theorem barMap_exchangeCoordinate (k : K) :
    (s.barMap φ hφ).exchangeCoordinate k = φ (s.exchangeCoordinate k) := by
  rw [exchangeCoordinate, s.barMap_monomial_exchangeExponentPos,
    s.barMap_monomial_exchangeExponentNeg, exchangeCoordinate, map_add, add_comm]

/-- **Mutation commutes with the coefficient-semilinear comparison.** -/
theorem barMap_mutate [Fintype K] [DecidableEq K] (k : K) :
    (s.barMap φ hφ).mutate k = (s.mutate k).barMap φ hφ := by
  refine QuantumSeed.ext (s.exchange.neg_mutate k)
    (s.compatible.formMutation_neg s.alternating (Or.inl rfl)) (funext fun j ↦ Units.ext ?_)
  by_cases hj : j = row k
  · subst hj
    rw [mutate_coordinate_row, val_barMap_coordinate, mutate_coordinate_row,
      barMap_exchangeCoordinate]
  · rw [mutate_coordinate_of_ne _ _ hj, val_barMap_coordinate, val_barMap_coordinate,
      mutate_coordinate_of_ne _ _ hj]

end Bar

/-- **The coefficient-semilinear comparison in `D` itself**: the coordinates of `s` form a
quantum seed for `(-Λ, -B_ext)` when `Zv` acts on `D` through the bar involution. -/
def bar : QuantumSeed (BarTwist D) row :=
  s.barMap (BarTwist.toBarTwist D).toRingHom BarTwist.toBarTwist_algebraMap

@[simp] theorem bar_exchange : s.bar.exchange.matrix = -s.exchange.matrix := rfl
@[simp] theorem bar_form : s.bar.form = -s.form := rfl
theorem val_bar_coordinate (i : M) :
    (s.bar.coordinate i : BarTwist D) = BarTwist.toBarTwist D (s.coordinate i) := rfl

theorem bar_monomial (a : M → ℤ) :
    s.bar.monomial a = BarTwist.toBarTwist D (s.monomial a) :=
  s.barMap_monomial _ _ a

theorem bar_exchangeCoordinate (k : K) :
    s.bar.exchangeCoordinate k = BarTwist.toBarTwist D (s.exchangeCoordinate k) :=
  s.barMap_exchangeCoordinate _ _ k

theorem bar_mutate [Fintype K] [DecidableEq K] (k : K) :
    s.bar.mutate k = (s.mutate k).bar :=
  s.barMap_mutate _ _ k

/-! ### The opposite-algebra comparison -/

section Opposite

/-- The coordinates `op X_i` of `Dᵐᵒᵖ`. -/
def oppositeCoordinate (i : M) : (Dᵐᵒᵖ)ˣ := Units.opEquiv.symm (op (s.coordinate i))
@[simp] theorem val_oppositeCoordinate (i : M) :
    (s.oppositeCoordinate i : Dᵐᵒᵖ) = op (s.coordinate i : D) :=
  rfl

theorem oppositeCoordinate_quasiCommuting :
    IsQuasiCommuting vUnit (matrixForm (-s.form)) s.oppositeCoordinate := by
  intro i j
  rw [val_oppositeCoordinate, val_oppositeCoordinate, ← op_mul, s.quasiCommuting j i, op_smul,
    op_mul, matrixForm_neg, matrixForm_single_single, matrixForm_single_single,
    s.alternating i j, neg_neg]

/-- The chart of the opposite seed, `X ^ a ↦ M'(a)` for `(v, -Λ)` in `Dᵐᵒᵖ`. -/
def oppositeChart : quantumTorus Zv vUnit (matrixForm (-s.form)) →ₐ[Zv] Dᵐᵒᵖ :=
  QuantumTorus.lift s.alternating.neg.isAlt s.oppositeCoordinate
    s.oppositeCoordinate_quasiCommuting

/-- The opposite isomorphism `T(Zv,v,Λ)ᵐᵒᵖ ≃ₐ[Zv] T(Zv,v,-Λ)` of the form of `s`. -/
def formOpEquiv :
    (quantumTorus Zv vUnit (matrixForm s.form))ᵐᵒᵖ ≃ₐ[Zv]
      quantumTorus Zv vUnit (matrixForm (-s.form)) :=
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

theorem oppositeChart_apply (x : quantumTorus Zv vUnit (matrixForm (-s.form))) :
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
def opposite : QuantumSeed Dᵐᵒᵖ row where
  exchange := s.exchange.neg
  form := -s.form
  alternating := s.alternating.neg
  compatible := s.compatible.neg
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

/-- **Mutation commutes with the opposite-algebra comparison.** -/
theorem opposite_mutate [Fintype K] [DecidableEq K] (k : K) :
    s.opposite.mutate k = (s.mutate k).opposite := by
  refine QuantumSeed.ext (s.exchange.neg_mutate k)
    (s.compatible.formMutation_neg s.alternating (Or.inl rfl)) (funext fun j ↦ Units.ext ?_)
  by_cases hj : j = row k
  · subst hj
    rw [mutate_coordinate_row, val_opposite_coordinate, mutate_coordinate_row,
      opposite_exchangeCoordinate]
  · rw [mutate_coordinate_of_ne _ _ hj, val_opposite_coordinate, val_opposite_coordinate,
      mutate_coordinate_of_ne _ _ hj]

end Opposite

end

end QuantumSeed

end TauCeti.Cluster
