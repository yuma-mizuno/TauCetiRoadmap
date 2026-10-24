/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.LocalStep
public import Mathlib.GroupTheory.MonoidLocalization.UniqueFactorization

/-!
# Polynomial certificates in a Laurent chart

This is the common local algebra for finite caterpillars and global exchange
patterns. It refers only to a subring of a field, two elements of that subring,
and a third field element. Graphs, mutation words and positivity play no role.
The third element's membership and both coprimality statements are outputs.
-/

@[expose] public section
noncomputable section
namespace TauCeti.Laurent
open Polynomial
open scoped LaurentPolynomial

variable {F : Type*} [Field F]

/-- A Laurent-chart identification and explicit three-edge polynomial data satisfying cancellation
and scalar coprimality certificates.
-/
structure PolynomialChartModel (L : Subring F) (z u : L) (v : F)
    (S : Type*) [CommRing S] where
  /-- Identify the actual initial chart with a one-variable Laurent ring over S. -/
  equiv : L ≃+* S[T;T⁻¹]
  /-- The numerator of the first local exchange, so the first coordinate is E/T. -/
  E : S
  /-- The correction factor in the scalar identity R(yinv*Q(0))=A*E. -/
  A : S
  /-- The unit coefficient multiplying Q in the second local exchange. -/
  yinv : S
  /-- The polynomial defining the second local exchanged coordinate. -/
  Q : S[X]
  /-- The polynomial defining the third exchange numerator after evaluation at the second
  coordinate.
  -/
  R : S[X]
  E_ne_zero : E ≠ 0
  relPrime_constant : IsRelPrime E (Q.eval 0)
  relPrime_correction : IsRelPrime E A
  yinv_unit : IsUnit yinv
  compatibility : R.eval (yinv * Q.eval 0) = A * E
  first_eq : equiv z = firstLocal E
  second_eq : equiv u = secondLocal E yinv Q
  third_exchange : v * (z : F) =
    L.subtype (equiv.symm ((R.map LaurentPolynomial.C).eval (secondLocal E yinv Q)))

namespace PolynomialChartModel
variable {L : Subring F} {z u : L} {v : F} {S : Type*} [CommRing S]
  [IsDomain S] [UniqueFactorizationMonoid S]

omit [IsDomain S] in
theorem chart_uniqueFactorizationMonoid (M : PolynomialChartModel L z u v S) :
    UniqueFactorizationMonoid L := by
  have : UniqueFactorizationMonoid S[T;T⁻¹] :=
    UniqueFactorizationMonoid.of_isLocalization (Submonoid.powers (X : S[X])) _
  exact M.equiv.symm.toMulEquiv.uniqueFactorizationMonoid inferInstance

theorem third_mem_and_relPrime (M : PolynomialChartModel L z u v S)
    (hz : (z : F) ≠ 0) :
    ∃ hv : v ∈ L, IsRelPrime z u ∧ IsRelPrime z ⟨v, hv⟩ := by
  let φ : S[T;T⁻¹] →+* F := L.subtype.comp M.equiv.symm.toRingHom
  have hfirst : φ (firstLocal M.E) = (z : F) := by
    change ((M.equiv.symm (firstLocal M.E) : L) : F) = _
    rw [← M.first_eq, M.equiv.symm_apply_apply]
  have hthird : φ (thirdLocal M.E M.A M.yinv M.Q M.R) = v := by
    apply mul_right_cancel₀ hz
    have h := congrArg φ (thirdLocal_exchange M.E M.A M.yinv M.Q M.R M.compatibility)
    rw [map_mul, hfirst] at h
    rw [mul_comm, h]
    exact M.third_exchange.symm
  have hv : v ∈ L := by
    rw [← hthird]
    exact (M.equiv.symm (thirdLocal M.E M.A M.yinv M.Q M.R)).property
  refine ⟨hv, ?_, ?_⟩
  · apply IsRelPrime.of_map M.equiv
    rw [M.first_eq, M.second_eq]
    exact (localStep_relPrime M.E M.A M.yinv M.Q M.R M.E_ne_zero
      M.relPrime_constant M.relPrime_correction M.yinv_unit).1
  · have hv' : M.equiv ⟨v, hv⟩ = thirdLocal M.E M.A M.yinv M.Q M.R := by
      apply M.equiv.symm.injective
      apply Subtype.ext
      rw [M.equiv.symm_apply_apply]
      exact hthird.symm
    apply IsRelPrime.of_map M.equiv
    rw [M.first_eq, hv']
    exact (localStep_relPrime M.E M.A M.yinv M.Q M.R M.E_ne_zero
      M.relPrime_constant M.relPrime_correction M.yinv_unit).2

end PolynomialChartModel
end TauCeti.Laurent
