/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.UpperBoundRegroup
public import TauCetiRoadmap.ClusterAlgebras.UpperBoundCoefficients
public import TauCetiRoadmap.ClusterAlgebras.GeometricCoordinates

/-! The coefficient units in a two-coordinate geometric exchange are actual
monomials in the unchanged coordinates. -/

@[expose] public section

noncomputable section
namespace TauCeti.Cluster.UpperBound
open TauCeti.Laurent
open scoped BigOperators
variable {F M K : Type*} [Field F] [Fintype M] [DecidableEq M]

/-- Forget that a coefficient-ring element is a unit and embed its value into the ambient field. -/
def unitValue (C : Subring F) : Cˣ →* F where
  toFun u := ((u : C) : F)
  map_one' := rfl
  map_mul' _ _ := rfl

@[simp] theorem unitValue_apply (C : Subring F) (u : Cˣ) : unitValue C u = ((u : C) : F) := rfl
theorem unitValue_ne_zero (C : Subring F) (u : Cˣ) : unitValue C u ≠ 0 :=
  (u.isUnit.map C.subtype).ne_zero

theorem unitValue_inv (C : Subring F) (u : Cˣ) :
    unitValue C u⁻¹ = (unitValue C u)⁻¹ := by
  have h := congrArg (fun a : C => (a : F)) u.inv_val
  change unitValue C u⁻¹ * unitValue C u = 1 at h
  apply (mul_right_cancel₀ (unitValue_ne_zero C u))
  rw [h, inv_mul_cancel₀ (unitValue_ne_zero C u)]

theorem unitValue_mem (C : Subring F) (u : Cˣ) : unitValue C u ∈ C := (u : C).property
theorem unitValue_inv_mem (C : Subring F) (u : Cˣ) : (unitValue C u)⁻¹ ∈ C := by
  rw [← unitValue_inv]
  exact unitValue_mem C _

theorem signSkew_nonzero_data {a b : ℤ} (hs : SignSkewAt a b) (ha : a ≠ 0) :
    ∃ (σ : ℤ) (c e : ℕ), (σ = 1 ∨ σ = -1) ∧ 0 < c ∧ 0 < e ∧
      a = σ * (c : ℤ) ∧ b = (-σ) * (e : ℤ) := by
  rcases hs with h | h | h
  · exact (ha h.1).elim
  · refine ⟨1, a.toNat, (-b).toNat, Or.inl rfl, ?_, ?_, ?_, ?_⟩ <;> omega
  · refine ⟨-1, (-a).toNat, b.toNat, Or.inr rfl, ?_, ?_, ?_, ?_⟩ <;> omega

/-- A coordinate outside the selected pair, regarded as a unit of the complementary chart ring. -/
def complementUnit (C : Subring F) (x : M → Fˣ) (i j : M)
    (a : {a : M // a ≠ i ∧ a ≠ j}) :
    (pairComplementRing C (fun m => (x m : F)) i j)ˣ where
  val := ⟨x a, coordinate_mem_chartRing C _ a⟩
  inv := ⟨(x a : F)⁻¹, inverse_mem_chartRing C _ a⟩
  val_inv := Subtype.ext (mul_inv_cancel₀ (Units.ne_zero (x a)))
  inv_val := Subtype.ext (inv_mul_cancel₀ (Units.ne_zero (x a)))

/-- The signed column monomial in the complementary coordinates, as a unit of their chart. -/
def pairCoefficient (C : Subring F) (x : M → Fˣ) (i j : M) (b : M → ℤ) (σ : ℤ) :
    (pairComplementRing C (fun m => (x m : F)) i j)ˣ :=
  signedMonomial (complementUnit C x i j) (fun a => b a) σ

@[simp] theorem pairCoefficient_val (C : Subring F) (x : M → Fˣ)
    (i j : M) (b : M → ℤ) (σ : ℤ) :
    ((pairCoefficient C x i j b σ : pairComplementRing C (fun m => (x m : F)) i j) : F) =
      ∏ a : {a : M // a ≠ i ∧ a ≠ j}, (x a : F) ^ positivePart (σ * b a) := by
  simp only [pairCoefficient, signedMonomial, Units.coe_prod]
  change (pairComplementRing C (fun m => (x m : F)) i j).subtype
    (∏ a : {a : M // a ≠ i ∧ a ≠ j},
      ↑(complementUnit C x i j a ^ positivePart (σ * b a))) = _
  rw [map_prod]
  apply Finset.prod_congr rfl
  intro a ha
  have hn : 0 ≤ positivePart (σ * b a) := by unfold positivePart; omega
  rw [← Int.toNat_of_nonneg hn]
  simp only [zpow_natCast, Units.val_pow_eq_pow_val]
  rfl

theorem prod_pair_complement {A : Type*} [CommMonoid A] (u : M → A)
    (i j : M) (hij : i ≠ j) :
    ∏ a, u a = u i * u j * ∏ a : {a : M // a ≠ i ∧ a ≠ j}, u a := by
  have h := Finset.prod_mul_prod_compl ({i,j} : Finset M) u
  rw [Finset.prod_subtype (p := fun a => a ≠ i ∧ a ≠ j) (F := inferInstance) ({i,j}ᶜ)
    (by intro a; simp)] at h
  simpa [hij, mul_assoc] using h.symm

theorem signedMonomial_pair_split (C : Subring F) (x : M → Fˣ)
    (i j : M) (hij : i ≠ j) (b : M → ℤ) (hi : b i = 0) (σ : ℤ) :
    ∏ a, (x a : F) ^ positivePart (σ * b a) =
      ((pairCoefficient C x i j b σ : pairComplementRing C (fun m => (x m : F)) i j) : F) *
        (x j : F) ^ positivePart (σ * b j) := by
  rw [prod_pair_complement _ i j hij, hi]
  simp only [mul_zero, positivePart, max_self, zpow_zero, one_mul, pairCoefficient_val]
  exact mul_comm _ _

/-- The rank-two correction compatibility is a consequence of the literal
extended matrix recurrence on every unchanged row. -/
theorem pairCoefficient_replacement_relation (C : Subring F) (x : M → Fˣ)
    (i j : M) (b c c' : M → ℤ) (t σ : ℤ) (e : ℕ)
    (hσ : σ = 1 ∨ σ = -1) (ht : t = σ * (e : ℤ))
    (hmut : ∀ a, a ≠ i → a ≠ j → c' a = c a +
      positivePart (b a) * positivePart t - positivePart (-b a) * positivePart (-t)) :
    pairCoefficient C x i j c (-σ) * pairCoefficient C x i j c' σ =
      pairCoefficient C x i j c σ * pairCoefficient C x i j c' (-σ) *
        (pairCoefficient C x i j b σ) ^ e := by
  apply signedMonomial_replacement_relation _ _ _ _ t σ e hσ ht
  intro a
  exact hmut a a.property.1 a.property.2

theorem pairCoefficient_extended_relation [Finite K] [DecidableEq K]
    (C : Subring F) (x : M → Fˣ) (row : K ↪ M) (B : Matrix M K ℤ)
    (i j : K) (hij : i ≠ j) (σ : ℤ) (e : ℕ)
    (hσ : σ = 1 ∨ σ = -1) (hijB : B (row i) j = σ * (e : ℤ)) :
    pairCoefficient C x (row i) (row j) (fun a => B a j) (-σ) *
      pairCoefficient C x (row i) (row j) (fun a => extendedMatrixMutation row B i a j) σ =
    pairCoefficient C x (row i) (row j) (fun a => B a j) σ *
      pairCoefficient C x (row i) (row j) (fun a => extendedMatrixMutation row B i a j) (-σ) *
      (pairCoefficient C x (row i) (row j) (fun a => B a i) σ) ^ e := by
  let : Fintype K := Fintype.ofFinite K
  apply pairCoefficient_replacement_relation _ _ _ _ _ _ _ (B (row i) j) σ e hσ hijB
  intro a hai haj
  simp [extendedMatrixMutation, hai, hij.symm]

theorem pairCoefficient_value_congr (C : Subring F) (x x' : M → Fˣ)
    (i j : M) (b : M → ℤ) (σ : ℤ)
    (hx : ∀ a, a ≠ i → a ≠ j → (x' a : F) = x a) :
    ((pairCoefficient C x' i j b σ : pairComplementRing C (fun m => (x' m : F)) i j) : F) =
      ((pairCoefficient C x i j b σ : pairComplementRing C (fun m => (x m : F)) i j) : F) := by
  rw [pairCoefficient_val, pairCoefficient_val]
  apply Finset.prod_congr rfl
  intro a ha
  rw [hx a a.property.1 a.property.2]

/-- The full-column exchange reduces to a two-term polynomial in the other
chosen coordinate, with all remaining factors in the coefficient ring. -/
theorem geometricExchangePolynomial_pair [Algebra ℚ F]
    (C : Subring F) (x : M → Fˣ) (B : Matrix M K ℤ) (k : K)
    (i j : M) (hij : i ≠ j) (hi : B i k = 0)
    (σ : ℤ) (c : ℕ) (hσ : σ = 1 ∨ σ = -1) (hj : B j k = σ * (c : ℤ)) :
    MvPolynomial.aeval (fun a => (x a : F)) (geometricExchangePolynomial B k) =
      ((pairCoefficient C x i j (fun a => B a k) σ :
        pairComplementRing C (fun m => (x m : F)) i j) : F) * (x j : F) ^ c +
      ((pairCoefficient C x i j (fun a => B a k) (-σ) :
        pairComplementRing C (fun m => (x m : F)) i j) : F) := by
  rw [aeval_geometricExchangePolynomial]
  have hp := signedMonomial_pair_split C x i j hij (fun a => B a k) hi 1
  have hn := signedMonomial_pair_split C x i j hij (fun a => B a k) hi (-1)
  simp only [one_mul] at hp
  simp only [neg_one_mul] at hn
  rw [hp, hn]
  rcases hσ with rfl | rfl
  · simp only [one_mul] at hj
    rw [hj]
    simp [positivePart]
  · simp only [neg_one_mul] at hj
    rw [hj]
    simp [positivePart, add_comm]

end TauCeti.Cluster.UpperBound
