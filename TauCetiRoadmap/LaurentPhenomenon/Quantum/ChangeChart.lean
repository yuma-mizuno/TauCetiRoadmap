/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.Quantum.LiftMonomial
public import TauCetiRoadmap.LaurentPhenomenon.SkewExchange

/-!
# Faithfulness after changing one quantum coordinate

The integer powers of the changed coordinate are free over the unchanged
coordinate ring. Grouping a relation by that exponent proves injectivity of
the new chart, independently of the exchange expression and exchange matrix.
-/

@[expose] public section

namespace TauCeti.QuantumTorus

open TauCeti.Laurent

variable {R D M : Type*} [CommRing R] [DivisionRing D] [Algebra R D]
  [DecidableEq M] {u : Rˣ}
  {Λ Γ : LinearMap.BilinForm ℤ (M → ℤ)}

/-- Agreement off one coordinate and freeness of the new coordinate imply
faithfulness. New-chart injectivity is a conclusion, not a premise. -/
theorem algHom_injective_of_coordinate_free (hΓ : LinearMap.IsAlt Γ)
    (f : quantumTorus R u Λ →ₐ[R] D) (g : quantumTorus R u Γ →ₐ[R] D)
    (hf : Function.Injective f) (i : M) (C : Subring D)
    (hR : ∀ r, algebraMap R D r ∈ C)
    (hC : ∀ a : M → ℤ, a i = 0 → f (monomial a) ∈ C)
    (hfix : ∀ a : M → ℤ, a i = 0 → g (monomial a) = f (monomial a))
    (hfree : SkewExchange.LeftFree C (g (monomial (Pi.single i 1)))) :
    Function.Injective g := by
  classical
  let y : Dˣ := Units.map (g : quantumTorus R u Γ →* D)
    (monomialUnit hΓ (Pi.single i 1))
  have hy : (y : D) = g (monomial (Pi.single i 1)) := rfl
  have hpow (n : ℤ) : g (monomial (n • Pi.single i 1)) = (y : D) ^ n := by
    rw [monomial_zsmul hΓ]
    change (↑((Units.map (g : quantumTorus R u Γ →* D))
      (monomialUnit hΓ (Pi.single i 1) ^ n)) : D) = (y : D) ^ n
    rw [map_zpow, Units.val_zpow_eq_zpow_val]
  let phase (n : ℤ) (a : M → ℤ) : Rˣ := u ^ (-Γ (a - n • Pi.single i 1)
    (n • Pi.single i 1))
  have hsplit (a : M → ℤ) :
      g (monomial a) = algebraMap R D (phase (a i) a : R) *
        (f (monomial (a - a i • Pi.single i 1)) * (y : D) ^ a i) := by
    have ha : (a - a i • Pi.single i 1 : M → ℤ) i = 0 := by simp
    have h := congrArg g (monomial_mul_monomial (R := R) (u := u) (Λ := Γ)
      (a - a i • Pi.single i 1) (a i • Pi.single i 1))
    rw [map_mul, map_smul, Algebra.smul_def (R := R) (A := D), sub_add_cancel,
      hfix _ ha, hpow] at h
    dsimp only [phase]
    rw [h, ← mul_assoc, ← map_mul, ← Units.val_mul, ← zpow_add,
      neg_add_cancel, zpow_zero, Units.val_one, map_one, one_mul]
  rw [algHom_injective_iff, linearIndependent_iff']
  intro S b hsum a ha
  let coef (n : ℤ) (a' : M → ℤ) : R := b a' * (phase n a' : R)
  let c (n : ℤ) : D := ∑ a' ∈ S with a' i = n,
    coef n a' • f (monomial (a' - n • Pi.single i 1))
  have hc : ∀ n ∈ S.image (fun a' ↦ a' i), c n ∈ C := by
    intro n _
    apply Subring.sum_mem
    intro a' ha'
    rw [Algebra.smul_def (R := R) (A := D)]
    exact C.mul_mem (hR _) (hC _ (by simp [(Finset.mem_filter.1 ha').2]))
  have hsum' : ∑ n ∈ S.image (fun a' ↦ a' i), c n * (y : D) ^ n = 0 := by
    rw [← hsum, ← Finset.sum_fiberwise_of_maps_to (g := fun a' : M → ℤ ↦ a' i)
      (t := S.image fun a' : M → ℤ ↦ a' i) (fun a' ha' ↦ Finset.mem_image_of_mem _ ha')]
    apply Finset.sum_congr rfl
    intro n _
    rw [Finset.sum_mul]
    apply Finset.sum_congr rfl
    intro a' ha'
    rw [← (Finset.mem_filter.1 ha').2, hsplit]
    simp only [coef, Algebra.smul_def (R := R) (A := D), map_mul, mul_assoc]
  rw [hy] at hsum'
  have hcn := hfree.eq_zero_of_sum _ (fun n ↦ n)
    (fun _ _ _ _ h ↦ h) c hc hsum' (Finset.mem_image_of_mem (fun a' ↦ a' i) ha)
  have hli := ((algHom_injective_iff f).1 hf).comp
    (fun a' ↦ a' - a i • Pi.single i 1) sub_left_injective
  have hz := linearIndependent_iff'.1 hli _ _ hcn a (Finset.mem_filter.2 ⟨ha, rfl⟩)
  exact (Units.mul_left_eq_zero _).1 hz

end TauCeti.QuantumTorus
