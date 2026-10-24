/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.PositiveSubstitution
public import TauCetiRoadmap.ClusterAlgebras.SeedCompatibility

/-! # Seed Binomial -/

@[expose] public section

open TauCeti.Laurent

namespace TauCeti.Cluster
noncomputable section
open scoped BigOperators

/-- Mutable monomial exponent of the positive part of one matrix column. -/
def columnPositiveExponent {I : Type*} [Finite I] (b : I → ℤ) : I →₀ ℤ :=
  (Finsupp.equivFunOnFinite).symm (fun h ↦ positivePart (b h))

@[simp] theorem columnPositiveExponent_apply {I : Type*} [Finite I] (b : I → ℤ) (h :
  I) :
    columnPositiveExponent b h = positivePart (b h) := by
  classical
  simp [columnPositiveExponent]

/-- The actual normalized exchange binomial, with multiplicities retained if its terms coincide.
In additive notation y-c and -c represent y/(y⊕1) and 1/(y⊕1). -/
def normalizedExchangeBinomial {G I : Type*} [AddCommGroup G] [Finite I]
    (y c : G) (b : I → ℤ) : PositiveLaurent G I :=
  AddMonoidAlgebra.single (y - c, columnPositiveExponent b) 1 +
    AddMonoidAlgebra.single (-c, columnPositiveExponent (fun h ↦ -b h)) 1

@[simp] theorem mutableSupport_single_one {G I : Type*}
    (g : G) (a : I →₀ ℤ) :
    mutableSupport (AddMonoidAlgebra.single (g, a) 1) = {a} := by
  classical
  simp [mutableSupport]

theorem normalizedExchangeBinomial_mutableSupport {G I : Type*} [AddCommGroup G]
    [Finite I] [DecidableEq I] (y c : G) (b : I → ℤ) :
    mutableSupport (normalizedExchangeBinomial y c b) =
      {columnPositiveExponent b, columnPositiveExponent (fun h ↦ -b h)} := by
  classical
  simp [normalizedExchangeBinomial, mutableSupport_add]

theorem normalizedExchangeBinomial_ne_zero {G I : Type*} [AddCommGroup G]
    [Finite I] (y c : G) (b : I → ℤ) : normalizedExchangeBinomial y c b ≠ 0 := by
  classical
  intro hz
  have hs := normalizedExchangeBinomial_mutableSupport y c b
  rw [hz] at hs
  have hm : columnPositiveExponent b ∈ mutableSupport (0 : PositiveLaurent G I) := by
    rw [hs]
    simp
  simp [mutableSupport] at hm

theorem normalizedExchangeBinomial_polynomial {G I : Type*} [AddCommGroup G]
    [Finite I] (y c : G) (b : I → ℤ) :
    PositivePolynomialSupport (normalizedExchangeBinomial y c b) := by
  classical
  intro a ha h
  rw [normalizedExchangeBinomial_mutableSupport] at ha
  rcases Finset.mem_insert.mp ha with rfl | ha
  · exact le_max_right _ _
  · have ha' : a = columnPositiveExponent (fun h ↦ -b h) := Finset.mem_singleton.mp ha
    rw [ha', columnPositiveExponent_apply]
    exact le_max_right _ _

theorem normalizedExchangeBinomial_independent {G I : Type*} [AddCommGroup G]
    [Finite I] (y c : G) (b : I → ℤ) (i : I) (hbi : b i = 0) :
    PositiveIndependent (normalizedExchangeBinomial y c b) i := by
  classical
  intro a ha
  rw [normalizedExchangeBinomial_mutableSupport] at ha
  rcases Finset.mem_insert.mp ha with rfl | ha
  · simp [hbi, positivePart]
  · rw [Finset.mem_singleton.mp ha]
    simp [hbi, positivePart]

theorem normalizedExchangeBinomial_no_factor {G I : Type*} [AddCommGroup G]
    [Finite I] (y c : G) (b : I → ℤ) :
    PositiveNoVariableFactor (normalizedExchangeBinomial y c b) := by
  classical
  classical
  intro i
  by_cases hbi : 0 ≤ b i
  · refine ⟨columnPositiveExponent (fun h ↦ -b h), ?_, ?_⟩
    · rw [normalizedExchangeBinomial_mutableSupport]
      simp
    · simp [positivePart, max_eq_right (neg_nonpos.mpr hbi)]
  · refine ⟨columnPositiveExponent b, ?_, ?_⟩
    · rw [normalizedExchangeBinomial_mutableSupport]
      simp
    · simp [positivePart, max_eq_right (le_of_not_ge hbi)]

end
end TauCeti.Cluster
