/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.FiniteExchangeReplacement

/-!
# Replacement of an exchanged variable in a division ring

Seed-free algebra for the rank-two step of the skew upper-bound argument (§0.5); no
commutativity is assumed and coefficients stand on the left. `ReplacementPremise` is the
premise: `x` and `z` normalize `C`, `(x*) ^ r x ^ r - g₀ ∈ z C[z]` for some `g₀`,
`z* z = n₁ + x ^ r n₂` and `z** z = (x*) ^ r m₁ + m₂` with `n₁ ≠ 0` and `n₁⁻¹, n₂, m₁ ∈ C`, and
`g₀ x^{-r} m₁ n₁⁻¹ x ^ r n₂ = m₂`. Then `ReplacementPremise.zss_eq` writes `z**` explicitly and
`ReplacementPremise.zss_mem` places it in `C⟨x*, z*, z⟩`. The order of the summands of the two
relations is immaterial (rewrite with `add_comm`).
-/

@[expose] public section

namespace TauCeti.Laurent

section DivisionRing

variable {D : Type*} [DivisionRing D]

/-- The premise of the replacement theorem (§0.5): `x` and `z` normalize `C`,
`(x*) ^ r x ^ r - g₀ ∈ z C[z]`, `z* z = n₁ + x ^ r n₂`, `z** z = (x*) ^ r m₁ + m₂` with `n₁ ≠ 0` and
`n₁⁻¹, n₂, m₁ ∈ C`, and `g₀ x^{-r} (m₁ n₁⁻¹) x ^ r n₂ = m₂`. No condition is put on `g₀`. -/
structure ReplacementPremise (C : Subring D) (x xs z zs zss : D) (r : ℕ)
    (g0 n1 n2 m1 m2 : D) : Prop where
  x_normalizes : Normalizes C x
  z_normalizes : Normalizes C z
  pow_mul_pow_sub_mem : xs ^ r * x ^ r - g0 ∈ (z * ·) '' (skewPolyRing C z : Set D)
  n1_ne_zero : n1 ≠ 0
  n1_inv_mem : n1⁻¹ ∈ C
  n2_mem : n2 ∈ C
  m1_mem : m1 ∈ C
  zs_mul : zs * z = n1 + x ^ r * n2
  zss_mul : zss * z = xs ^ r * m1 + m2
  compat : g0 * (x ^ r)⁻¹ * (m1 * n1⁻¹) * x ^ r * n2 = m2

/-- The existing quantum binary premise is a one-term instance. -/
theorem ReplacementPremise.finiteReplacement
    {C : Subring D} {x xs z zs zss g0 n1 n2 m1 m2 : D} {r : ℕ}
    (h : ReplacementPremise C x xs z zs zss r g0 n1 n2 m1 m2) :
    FiniteReplacementPremise C x xs z zs zss (m1 * n1⁻¹) n1 m1
      ({()} : Finset Unit) r (fun _ ↦ r) (fun _ ↦ n2) (fun _ ↦ m2) (fun _ ↦ g0) where
  x_normalizes := h.x_normalizes
  z_normalizes := h.z_normalizes
  degree _ _ := le_rfl
  phi_mem := C.mul_mem h.m1_mem h.n1_inv_mem
  coefficient_mem _ _ := h.n2_mem
  constant := by simp [h.n1_ne_zero]
  defect_mem _ _ := h.pow_mul_pow_sub_mem
  zs_mul := by simpa using h.zs_mul
  zss_mul := by simpa using h.zss_mul
  compat _ _ := by simpa only [mul_assoc] using h.compat.symm

namespace ReplacementPremise

variable {C : Subring D} {x xs z zs zss g0 n1 n2 m1 m2 : D} {r : ℕ}
  (h : ReplacementPremise C x xs z zs zss r g0 n1 n2 m1 m2)
include h

/-- The explicit binary correction is the singleton finite correction. -/
theorem zss_eq :
    zss = xs ^ r * (m1 * n1⁻¹) * zs -
      (xs ^ r * x ^ r - g0) * ((x ^ r)⁻¹ * (m1 * n1⁻¹) * x ^ r) * n2 * z⁻¹ := by
  simpa only [Finset.sum_singleton, Nat.sub_self, pow_zero, one_mul, mul_assoc] using
    h.finiteReplacement.zss_eq

/-- Binary replacement is a singleton instance of finite replacement. -/
theorem zss_mem : zss ∈ Subring.closure ((C : Set D) ∪ {xs, zs, z}) :=
  h.finiteReplacement.zss_mem

end ReplacementPremise
end DivisionRing
end TauCeti.Laurent
