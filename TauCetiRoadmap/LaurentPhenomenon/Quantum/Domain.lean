/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.Quantum.Torus
public import Mathlib.Algebra.Group.UniqueProds.Basic

/-!
# Quantum tori over a domain are domains

The coefficient of `X ^ c` in a product `x * y` of the quantum torus `T(R,u,Λ)` is the sum of
`x_a y_b u^{Λ(a,b)}` over `a + b = c`. When the lattice has unique sums (for instance a
lattice `M → ℤ`, ordered lexicographically) a pair of extreme exponents `a₀, b₀` of the
supports of `x` and `y` contributes alone to the coefficient of `X^{a₀ + b₀}`, which is the
product of the two extreme coefficients times a unit. Over a domain this coefficient is
nonzero, so `T(R,u,Λ)` is a domain.
-/

@[expose] public section

namespace TauCeti.QuantumTorus

open TauCeti

variable {R : Type*} [CommRing R] {L : Type*} [AddCommGroup L] {u : Rˣ}
    {Λ : LinearMap.BilinForm ℤ L}

/-- Every element is the sum of its coefficients times the basis monomials. -/
theorem sum_repr_smul_monomial (x : quantumTorus R u Λ) :
    ∑ a ∈ (monomialBasis.repr x).support, monomialBasis.repr x a • monomial a = x := by
  conv_rhs => rw [← (monomialBasis (R := R) (u := u) (Λ := Λ)).linearCombination_repr x]
  simp [Finsupp.linearCombination_apply, Finsupp.sum]

/-- The coefficients of a product of two elements of the quantum torus. -/
theorem repr_mul_apply [DecidableEq L] (x y : quantumTorus R u Λ) (c : L) :
    monomialBasis.repr (x * y) c =
      ∑ a ∈ (monomialBasis.repr x).support, ∑ b ∈ (monomialBasis.repr y).support,
        if a + b = c then
          monomialBasis.repr x a * monomialBasis.repr y b * ((u ^ Λ a b : Rˣ) : R)
        else 0 := by
  conv_lhs => rw [← sum_repr_smul_monomial x, ← sum_repr_smul_monomial y]
  simp only [Finset.sum_mul, Finset.mul_sum, smul_mul_smul_comm, monomial_mul_monomial,
    smul_smul, map_sum, map_smul, Finsupp.coe_finsetSum, Finset.sum_apply,
    Finsupp.smul_apply, smul_eq_mul]
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun a _ ↦ Finset.sum_congr rfl fun b _ ↦ ?_
  rw [← monomialBasis_apply, Module.Basis.repr_self, Finsupp.single_apply]
  split_ifs <;> simp

/-- If `a₀ + b₀` is a unique sum of the supports of `x` and `y`, the coefficient of
`X^{a₀ + b₀}` in `x * y` is `x_{a₀} y_{b₀} u^{Λ(a₀,b₀)}`. -/
theorem repr_mul_apply_of_uniqueAdd (x y : quantumTorus R u Λ) {a₀ b₀ : L}
    (ha₀ : a₀ ∈ (monomialBasis.repr x).support) (hb₀ : b₀ ∈ (monomialBasis.repr y).support)
    (h : UniqueAdd (monomialBasis.repr x).support (monomialBasis.repr y).support a₀ b₀) :
    monomialBasis.repr (x * y) (a₀ + b₀) =
      monomialBasis.repr x a₀ * monomialBasis.repr y b₀ * ((u ^ Λ a₀ b₀ : Rˣ) : R) := by
  classical
  rw [repr_mul_apply, Finset.sum_eq_single a₀, Finset.sum_eq_single b₀, ite_eq_left rfl]
  · intro b hb hne
    rw [ite_eq_right]
    exact fun he ↦ hne (h ha₀ hb he).2
  · exact fun h' ↦ absurd hb₀ h'
  · intro a ha hne
    refine Finset.sum_eq_zero fun b hb ↦ ?_
    rw [ite_eq_right]
    exact fun he ↦ hne (h ha hb he).1
  · exact fun h' ↦ absurd ha₀ h'

instance [Nontrivial R] : Nontrivial (quantumTorus R u Λ) :=
  ⟨⟨0, 1, by
    rw [← monomial_zero, ← monomialBasis_apply]
    exact (monomialBasis.ne_zero 0).symm⟩⟩

/-- Over a domain, a quantum torus on a lattice with unique sums has no zero divisors. -/
instance [IsDomain R] [UniqueSums L] : NoZeroDivisors (quantumTorus R u Λ) where
  eq_zero_or_eq_zero_of_mul_eq_zero {x y} hxy := by
    by_contra! hne
    obtain ⟨a₀, ha₀, b₀, hb₀, h⟩ := UniqueSums.uniqueAdd_of_nonempty
      (Finsupp.support_nonempty_iff.2 ((map_ne_zero_iff _ monomialBasis.repr.injective).2 hne.1))
      (Finsupp.support_nonempty_iff.2 ((map_ne_zero_iff _ monomialBasis.repr.injective).2 hne.2))
    have hc := repr_mul_apply_of_uniqueAdd x y ha₀ hb₀ h
    rw [hxy, map_zero, Finsupp.zero_apply] at hc
    exact mul_ne_zero (mul_ne_zero (Finsupp.mem_support_iff.1 ha₀)
      (Finsupp.mem_support_iff.1 hb₀)) (Units.ne_zero _) hc.symm

/-- **A quantum torus over a domain is a domain**, for any lattice with unique sums, in
particular for `M → ℤ`. -/
instance [IsDomain R] [UniqueSums L] : IsDomain (quantumTorus R u Λ) :=
  NoZeroDivisors.to_isDomain (quantumTorus R u Λ)

end TauCeti.QuantumTorus
