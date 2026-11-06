import Mathlib.LinearAlgebra.Matrix.GeneralLinearGroup.Defs
import TauCeti.LinearAlgebra.IntegralLattice.Isometry.Transvection

/-!
# Discrete Painlevé equations: selected interfaces

**This file is not the roadmap and is not exhaustive.** The definitive document is
`README.md`. These declarations suggest Lean forms for selected constructions and
theorems; discharging them finishes neither a layer nor the roadmap.

At the generic point a difference module uses Mathlib's `LinearEquiv`: for a field
automorphism `σ`, its operator has type `V ≃ₛₗ[(σ : K →+* K)] V`. With column solutions
`σ(Y) = A Y`, the operator on sections is `A⁻¹ σ`, so a change `Y' = G Y` gives
`A' = σ(G) A G⁻¹`. The first section pins this convention without defining a second
kind of semilinear equivalence. It describes generic fibers only: the lattices, local
types and regular isomorphisms in the README are additional geometric data.

The second section states compatibility for commuting spectral and parameter shifts.
The final section consumes the existing integral-lattice transvection API. Surface
families, moduli functors and their comparison theorems are specified in the README;
this file introduces no stand-ins for their unavailable interfaces.
-/

namespace TauCetiRoadmap.DiscretePainleveEquations

open Matrix

noncomputable section

/-! ## Generic difference operators and changes of frame -/

section GenericDifferenceOperators

variable {K : Type*} [Field K] {ι : Type*} [Fintype ι] [DecidableEq ι]

attribute [local instance] RingHomInvPair.of_ringEquiv RingHomInvPair.of_ringEquiv_symm

/-- Apply the field automorphism to every coordinate. -/
def scalarShift (σ : K ≃+* K) : (ι → K) ≃ₛₗ[(σ : K →+* K)] (ι → K) where
  toFun v := fun i => σ (v i)
  invFun v := fun i => σ.symm (v i)
  left_inv v := funext fun i => σ.symm_apply_apply (v i)
  right_inv v := funext fun i => σ.apply_symm_apply (v i)
  map_add' v w := funext fun i => σ.map_add (v i) (w i)
  map_smul' a v := funext fun i => σ.map_mul a (v i)

/-- The semilinear operator whose fixed vectors solve `σ(Y) = A Y`. -/
def differenceOperator (σ : K ≃+* K) (A : GeneralLinearGroup ι K) :
    (ι → K) ≃ₛₗ[(σ : K →+* K)] (ι → K) :=
  (scalarShift σ).trans (GeneralLinearGroup.toLin A⁻¹).toLinearEquiv

@[simp]
theorem differenceOperator_apply (σ : K ≃+* K) (A : GeneralLinearGroup ι K)
    (v : ι → K) :
    differenceOperator σ A v = (↑(A⁻¹) : Matrix ι ι K) *ᵥ (fun i => σ (v i)) := rfl

/-- Invertibility is built into `A`; fixed vectors recover the stated equation. -/
theorem differenceOperator_fixed_iff (σ : K ≃+* K) (A : GeneralLinearGroup ι K)
    (v : ι → K) :
    differenceOperator σ A v = v ↔ (fun i => σ (v i)) = (↑A : Matrix ι ι K) *ᵥ v := by
  sorry

/-- Coefficient change for column solutions transformed by `Y' = G Y`. -/
def gaugeTransform (σ : K ≃+* K) (A G : GeneralLinearGroup ι K) :
    GeneralLinearGroup ι K :=
  GeneralLinearGroup.map (σ : K →+* K) G * A * G⁻¹

@[simp]
theorem gaugeTransform_one (σ : K ≃+* K) (A : GeneralLinearGroup ι K) :
    gaugeTransform σ A 1 = A := by
  simp [gaugeTransform]

/-- Changing by `G` and then by `H` is changing by `H G`, in that order. -/
theorem gaugeTransform_comp (σ : K ≃+* K) (A G H : GeneralLinearGroup ι K) :
    gaugeTransform σ (gaugeTransform σ A G) H = gaugeTransform σ A (H * G) := by
  simp [gaugeTransform, mul_assoc]

/-- The coefficient formula is equivalent to intertwining the semilinear operators. -/
theorem gaugeTransform_eq_iff (σ : K ≃+* K) (A A' G : GeneralLinearGroup ι K) :
    gaugeTransform σ A G = A' ↔
      ∀ v : ι → K,
        differenceOperator σ A' ((↑G : Matrix ι ι K) *ᵥ v) =
          (↑G : Matrix ι ι K) *ᵥ differenceOperator σ A v := by
  sorry

/-- The determinant remembers the scalar part of a change of frame. -/
theorem det_gaugeTransform (σ : K ≃+* K) (A G : GeneralLinearGroup ι K) :
    GeneralLinearGroup.det (gaugeTransform σ A G) =
      Units.map (σ : K →+* K).toMonoidHom (GeneralLinearGroup.det G) *
        GeneralLinearGroup.det A * (GeneralLinearGroup.det G)⁻¹ := by
  simp only [gaugeTransform, map_mul, map_inv, GeneralLinearGroup.map_det]
  rfl

/-! ## Compatibility of spectral and parameter shifts -/

/-- The Lax compatibility equation is the commuting-operator equation.

For Jimbo–Sakai, `σ` shifts the spectral variable and `τ` shifts the time parameter.
This algebraic statement does not assert preservation of a local singularity type:
the modification theorem must supply that data separately.
-/
theorem compatibility_iff (σ τ : K ≃+* K)
    (hστ : Function.Commute (σ : K → K) (τ : K → K))
    (A R : GeneralLinearGroup ι K) :
    GeneralLinearGroup.map (τ : K →+* K) A * R =
        GeneralLinearGroup.map (σ : K →+* K) R * A ↔
      ∀ v : ι → K,
        differenceOperator σ A (differenceOperator τ R v) =
          differenceOperator τ R (differenceOperator σ A v) := by
  sorry

end GenericDifferenceOperators

/-! ## Existing Picard-lattice translation convention

For the Picard intersection form, `δ = -K` is isotropic and a translation parameter
belongs to `L.evenOrthogonal δ`. Tau Ceti's Eichler transvection is exactly the Kac
translation with the convention in the README. Its integrality, isometry property,
addition law and descent in the parameter modulo `ℤ δ` are existing API, not new
constructions here. Descent of a period homomorphism is a different question.
-/

open TauCeti IntegralLattice

example {V : Type*} [AddCommGroup V] [Module ℚ V]
    (L : IntegralLattice V) (δ : L) (hδ : L.integralNorm δ = 0)
    (v : L.evenOrthogonal δ) (x : V) :
    eichlerTransvection hδ v x =
      x + L.form x δ • ((v : L) : V) - L.form x v • (δ : V) -
        (L.form v v / 2 * L.form x δ) • (δ : V) :=
  eichlerTransvection_apply hδ v x

end

end TauCetiRoadmap.DiscretePainleveEquations
