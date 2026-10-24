/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.LaurentEvaluation

/-! # Laurent Reindex -/

@[expose] public section

noncomputable section
namespace TauCeti.Laurent.LaurentEvaluation
variable {R S I J K : Type*} [CommRing R] [CommRing S]

/-- Rename variables along any function, adding exponents when labels coincide. -/
def rename (e : I → J) : Ring R I →+* Ring R J :=
  AddMonoidAlgebra.mapDomainRingHom R (Finsupp.mapDomain.addMonoidHom e)

@[simp] theorem rename_single (e : I → J) (a : I →₀ ℤ) (r : R) :
    rename e (AddMonoidAlgebra.single a r) =
      AddMonoidAlgebra.single (Finsupp.mapDomain e a) r := by
  simp [rename]

@[simp] theorem rename_id (p : Ring R I) : rename id p = p := by
  simp [rename]

theorem rename_comp (e : I → J) (d : J → K) (p : Ring R I) :
    rename d (rename e p) = rename (d ∘ e) p := by
  change ((rename d).comp (rename e)) p = _
  have h : (rename (R := R) d).comp (rename e) = rename (d ∘ e) := by
    apply AddMonoidAlgebra.ringHom_ext
    · intro r; simp
    · intro a
      simp only [RingHom.comp_apply, rename_single]
      rw [Finsupp.mapDomain_comp]
  rw [h]

/-- A bijection of variable labels induces an equivalence of Laurent rings. -/
def renameEquiv (e : I ≃ J) : Ring R I ≃+* Ring R J :=
  RingEquiv.ofRingHom (rename e) (rename e.symm)
    (by
      apply RingHom.ext; intro p
      change rename e (rename e.symm p) = p
      rw [rename_comp]
      have he : (e : I → J) ∘ e.symm = id := funext e.apply_symm_apply
      rw [he, rename_id])
    (by
      apply RingHom.ext; intro p
      change rename e.symm (rename e p) = p
      rw [rename_comp]
      have he : (e.symm : J → I) ∘ e = id := funext e.symm_apply_apply
      rw [he, rename_id])

private theorem exponentCharacter_rename (e : I → J) (y : J → Sˣ) (a : I →₀ ℤ) :
    exponentCharacter y (Finsupp.mapDomain e a) = exponentCharacter (y ∘ e) a := by
  induction a using Finsupp.induction_linear with
  | zero => simp
  | add a b ha hb => simp [Finsupp.mapDomain_add, ha, hb]
  | single i n => simp [Function.comp_def]

/-- Renaming labels agrees with precomposing the unit assignment. -/
theorem eval_rename (c : R →+* S) (e : I → J) (y : J → Sˣ) (p : Ring R I) :
    eval c y (rename e p) = eval c (y ∘ e) p := by
  classical
  conv_lhs => rw [← AddMonoidAlgebra.sum_coeff_single p]
  conv_rhs => rw [← AddMonoidAlgebra.sum_coeff_single p]
  simp only [Finsupp.sum, map_sum]
  apply Finset.sum_congr rfl
  intro a ha
  simp [exponentCharacter_rename]

/-- Change the coefficient ring while retaining every Laurent exponent. -/
def mapCoefficients (d : R →+* S) : Ring R I →+* Ring S I :=
  AddMonoidAlgebra.mapRingHom (I →₀ ℤ) d

theorem eval_mapCoefficients {T : Type*} [CommRing T]
    (d : R →+* S) (c : S →+* T) (x : I → Tˣ) (p : Ring R I) :
    eval c x (mapCoefficients d p) = eval (c.comp d) x p := by
  classical
  conv_lhs => rw [← AddMonoidAlgebra.sum_coeff_single p]
  conv_rhs => rw [← AddMonoidAlgebra.sum_coeff_single p]
  simp only [Finsupp.sum, map_sum]
  apply Finset.sum_congr rfl
  intro a ha
  simp [mapCoefficients]

end TauCeti.Laurent.LaurentEvaluation
