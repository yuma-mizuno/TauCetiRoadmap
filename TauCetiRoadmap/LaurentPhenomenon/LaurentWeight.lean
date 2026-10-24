/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.GroupRing
public import TauCetiRoadmap.LaurentPhenomenon.Quantum.Support
public import TauCetiRoadmap.LaurentPhenomenon.Quantum.Specialization
public import Mathlib.Algebra.MonoidAlgebra.Degree
public import Mathlib.Algebra.MonoidAlgebra.Grading
public import Mathlib.Algebra.Divisibility.Units
public import Mathlib.Tactic.LinearCombination

/-!
Extremal support weights for group algebras over torsion-free abelian groups.

The group algebra `D[G]` is the trivial-twist quantum torus `T(D,1,0)` through
`toQuantumTorus` (`QuantumTorus.equivAddMonoidAlgebra`). The weights `hiWeight`, `loWeight`,
the width `supportWidth` and the parts `topPart`, `bottomPart` are abbreviations of those of
`Quantum/Support.lean` read through this identification, and every theorem here is the
corresponding theorem there.
-/

@[expose] public section

namespace TauCeti.Laurent

variable {D G : Type*} [CommRing D] [AddCommGroup G]

open QuantumTorus

/-! ### The trivial-twist identification -/

/-- `D[G]` as the trivial-twist quantum torus `T(D,1,0)`. -/
noncomputable abbrev toQuantumTorus :
    AddMonoidAlgebra D G ≃ₐ[D] quantumTorus D 1 (0 : LinearMap.BilinForm ℤ G) :=
  (QuantumTorus.equivAddMonoidAlgebra 0).symm

theorem coeff_toQuantumTorus (f : AddMonoidAlgebra D G) (a : G) :
    QuantumTorus.coeff a (toQuantumTorus f) = f.coeff a := by
  rw [← coeff_equivAddMonoidAlgebra, AlgEquiv.apply_symm_apply]

theorem support_toQuantumTorus (f : AddMonoidAlgebra D G) :
    QuantumTorus.support (toQuantumTorus f) = f.coeff.support := by
  ext a
  rw [QuantumTorus.mem_support_iff, Finsupp.mem_support_iff, coeff_toQuantumTorus]

theorem toQuantumTorus_ne_zero {f : AddMonoidAlgebra D G} (hf : f ≠ 0) :
    toQuantumTorus f ≠ 0 :=
  (map_ne_zero_iff _ (toQuantumTorus (D := D) (G := G)).injective).2 hf

/-! ### Extreme weights and parts -/

/-- Greatest weight occurring in the finite support of a nonzero Laurent polynomial. -/
noncomputable abbrev hiWeight (w : G →+ ℤ) (f : AddMonoidAlgebra D G) (hf : f ≠ 0) : ℤ :=
  QuantumTorus.hiWeight w (toQuantumTorus f) (toQuantumTorus_ne_zero hf)

/-- Least weight occurring in the finite support of a nonzero Laurent polynomial. -/
noncomputable abbrev loWeight (w : G →+ ℤ) (f : AddMonoidAlgebra D G) (hf : f ≠ 0) : ℤ :=
  QuantumTorus.loWeight w (toQuantumTorus f) (toQuantumTorus_ne_zero hf)

/-- Nonnegative width of the support in an integer linear direction. -/
noncomputable abbrev supportWidth (w : G →+ ℤ) (f : AddMonoidAlgebra D G) (hf : f ≠ 0) : ℕ :=
  QuantumTorus.supportWidth w (toQuantumTorus f) (toQuantumTorus_ne_zero hf)

/-- The homogeneous part at the greatest support weight. -/
noncomputable abbrev topPart (w : G →+ ℤ) (f : AddMonoidAlgebra D G) (hf : f ≠ 0) :
    AddMonoidAlgebra D G :=
  toQuantumTorus.symm (QuantumTorus.topPart w (toQuantumTorus f) (toQuantumTorus_ne_zero hf))

/-- The homogeneous part at the least support weight. -/
noncomputable abbrev bottomPart (w : G →+ ℤ) (f : AddMonoidAlgebra D G) (hf : f ≠ 0) :
    AddMonoidAlgebra D G :=
  toQuantumTorus.symm (QuantumTorus.bottomPart w (toQuantumTorus f) (toQuantumTorus_ne_zero hf))

theorem support_image_nonempty (w : G →+ ℤ) {f : AddMonoidAlgebra D G} (hf : f ≠ 0) :
    (f.coeff.support.image w).Nonempty := by
  rw [← support_toQuantumTorus]
  exact (QuantumTorus.support_nonempty (toQuantumTorus_ne_zero hf)).image w

/-- `hiWeight` is the greatest weight on the support. -/
theorem hiWeight_eq_max' (w : G →+ ℤ) {f : AddMonoidAlgebra D G} (hf : f ≠ 0) :
    hiWeight w f hf = (f.coeff.support.image w).max' (support_image_nonempty w hf) := by
  simp only [hiWeight, QuantumTorus.hiWeight, support_toQuantumTorus]

/-- `loWeight` is the least weight on the support. -/
theorem loWeight_eq_min' (w : G →+ ℤ) {f : AddMonoidAlgebra D G} (hf : f ≠ 0) :
    loWeight w f hf = (f.coeff.support.image w).min' (support_image_nonempty w hf) := by
  simp only [loWeight, QuantumTorus.loWeight, support_toQuantumTorus]

theorem loWeight_le_hiWeight (w : G →+ ℤ) {f : AddMonoidAlgebra D G} (hf : f ≠ 0) :
    loWeight w f hf ≤ hiWeight w f hf :=
  QuantumTorus.loWeight_le_hiWeight w _

theorem le_hiWeight_of_mem (w : G →+ ℤ) {f : AddMonoidAlgebra D G} (hf : f ≠ 0)
    {m : G} (hm : m ∈ f.coeff.support) : w m ≤ hiWeight w f hf :=
  QuantumTorus.le_hiWeight_of_mem w _ (by rwa [support_toQuantumTorus])

theorem loWeight_le_of_mem (w : G →+ ℤ) {f : AddMonoidAlgebra D G} (hf : f ≠ 0)
    {m : G} (hm : m ∈ f.coeff.support) : loWeight w f hf ≤ w m :=
  QuantumTorus.loWeight_le_of_mem w _ (by rwa [support_toQuantumTorus])

theorem exists_mem_support_hiWeight (w : G →+ ℤ) {f : AddMonoidAlgebra D G} (hf : f ≠ 0) :
    ∃ m ∈ f.coeff.support, w m = hiWeight w f hf := by
  simpa only [support_toQuantumTorus] using
    QuantumTorus.exists_mem_support_hiWeight w (toQuantumTorus_ne_zero hf)

theorem exists_mem_support_loWeight (w : G →+ ℤ) {f : AddMonoidAlgebra D G} (hf : f ≠ 0) :
    ∃ m ∈ f.coeff.support, w m = loWeight w f hf := by
  simpa only [support_toQuantumTorus] using
    QuantumTorus.exists_mem_support_loWeight w (toQuantumTorus_ne_zero hf)

/-- The width is `hi_w - lo_w`. -/
theorem supportWidth_eq (w : G →+ ℤ) {f : AddMonoidAlgebra D G} (hf : f ≠ 0) :
    (supportWidth w f hf : ℤ) = hiWeight w f hf - loWeight w f hf :=
  QuantumTorus.supportWidth_eq w _

/-- The width vanishes exactly when all exponents of the support have the same weight. -/
theorem supportWidth_eq_zero_iff (w : G →+ ℤ) {f : AddMonoidAlgebra D G} (hf : f ≠ 0) :
    supportWidth w f hf = 0 ↔ ∀ a ∈ f.coeff.support, ∀ b ∈ f.coeff.support, w a = w b := by
  have hw := supportWidth_eq w hf
  constructor
  · intro h a ha b hb
    have := le_hiWeight_of_mem w hf ha
    have := le_hiWeight_of_mem w hf hb
    have := loWeight_le_of_mem w hf ha
    have := loWeight_le_of_mem w hf hb
    omega
  · intro h
    obtain ⟨a, ha, hae⟩ := exists_mem_support_hiWeight w hf
    obtain ⟨b, hb, hbe⟩ := exists_mem_support_loWeight w hf
    have := h a ha b hb
    omega

@[simp] theorem hiWeight_single (w : G →+ ℤ) (a : G) {r : D}
    (h : (AddMonoidAlgebra.single a r : AddMonoidAlgebra D G) ≠ 0) :
    hiWeight w (AddMonoidAlgebra.single a r) h = w a := by
  classical
  have hr : r ≠ 0 := fun hr ↦ h (by simp [hr])
  simp [hiWeight_eq_max', AddMonoidAlgebra.coeff_single, Finsupp.support_single _ hr]

@[simp] theorem loWeight_single (w : G →+ ℤ) (a : G) {r : D}
    (h : (AddMonoidAlgebra.single a r : AddMonoidAlgebra D G) ≠ 0) :
    loWeight w (AddMonoidAlgebra.single a r) h = w a := by
  classical
  have hr : r ≠ 0 := fun hr ↦ h (by simp [hr])
  simp [loWeight_eq_min', AddMonoidAlgebra.coeff_single, Finsupp.support_single _ hr]

theorem coeff_topPart (w : G →+ ℤ) {f : AddMonoidAlgebra D G} (hf : f ≠ 0) (a : G) :
    (topPart w f hf).coeff a = if w a = hiWeight w f hf then f.coeff a else 0 := by
  rw [topPart, ← coeff_toQuantumTorus, AlgEquiv.apply_symm_apply, QuantumTorus.coeff_topPart,
    coeff_toQuantumTorus]

theorem coeff_bottomPart (w : G →+ ℤ) {f : AddMonoidAlgebra D G} (hf : f ≠ 0) (a : G) :
    (bottomPart w f hf).coeff a = if w a = loWeight w f hf then f.coeff a else 0 := by
  rw [bottomPart, ← coeff_toQuantumTorus, AlgEquiv.apply_symm_apply,
    QuantumTorus.coeff_bottomPart, coeff_toQuantumTorus]

theorem topPart_ne_zero (w : G →+ ℤ) {f : AddMonoidAlgebra D G} (hf : f ≠ 0) :
    topPart w f hf ≠ 0 :=
  (map_ne_zero_iff _ toQuantumTorus.symm.injective).2 (QuantumTorus.topPart_ne_zero w _)

theorem bottomPart_ne_zero (w : G →+ ℤ) {f : AddMonoidAlgebra D G} (hf : f ≠ 0) :
    bottomPart w f hf ≠ 0 :=
  (map_ne_zero_iff _ toQuantumTorus.symm.injective).2 (QuantumTorus.bottomPart_ne_zero w _)

theorem topPart_homogeneous (w : G →+ ℤ) {f : AddMonoidAlgebra D G} (hf : f ≠ 0) :
    topPart w f hf ∈ AddMonoidAlgebra.gradeBy D w (hiWeight w f hf) := by
  intro m hm
  rw [Finsupp.mem_support_iff, coeff_topPart] at hm
  by_contra h
  exact hm (by simp [h])

theorem bottomPart_homogeneous (w : G →+ ℤ) {f : AddMonoidAlgebra D G} (hf : f ≠ 0) :
    bottomPart w f hf ∈ AddMonoidAlgebra.gradeBy D w (loWeight w f hf) := by
  intro m hm
  rw [Finsupp.mem_support_iff, coeff_bottomPart] at hm
  by_contra h
  exact hm (by simp [h])

/-! ### Products -/

theorem weight_mul_le_add_hi (w : G →+ ℤ) {f g : AddMonoidAlgebra D G} (hf : f ≠ 0)
    (hg : g ≠ 0) {m : G} (hm : m ∈ (f * g).coeff.support) :
    w m ≤ hiWeight w f hf + hiWeight w g hg :=
  QuantumTorus.weight_mul_le_add_hi w _ _ (by rwa [← map_mul, support_toQuantumTorus])

theorem add_lo_le_weight_mul (w : G →+ ℤ) {f g : AddMonoidAlgebra D G} (hf : f ≠ 0)
    (hg : g ≠ 0) {m : G} (hm : m ∈ (f * g).coeff.support) :
    loWeight w f hf + loWeight w g hg ≤ w m :=
  QuantumTorus.add_lo_le_weight_mul w _ _ (by rwa [← map_mul, support_toQuantumTorus])

variable [IsAddTorsionFree G]

theorem topPart_mul_ne_zero [IsDomain D] (w : G →+ ℤ) {f g : AddMonoidAlgebra D G}
    (hf : f ≠ 0) (hg : g ≠ 0) : topPart w f hf * topPart w g hg ≠ 0 := by
  rw [← map_mul]
  exact (map_ne_zero_iff _ toQuantumTorus.symm.injective).2 (QuantumTorus.topPart_mul_ne_zero w _ _)

theorem bottomPart_mul_ne_zero [IsDomain D] (w : G →+ ℤ) {f g : AddMonoidAlgebra D G}
    (hf : f ≠ 0) (hg : g ≠ 0) : bottomPart w f hf * bottomPart w g hg ≠ 0 := by
  rw [← map_mul]
  exact (map_ne_zero_iff _ toQuantumTorus.symm.injective).2
    (QuantumTorus.bottomPart_mul_ne_zero w _ _)

theorem hiWeight_mul [IsDomain D] (w : G →+ ℤ) {f g : AddMonoidAlgebra D G}
    (hf : f ≠ 0) (hg : g ≠ 0) (hfg : f * g ≠ 0) :
    hiWeight w (f * g) hfg = hiWeight w f hf + hiWeight w g hg := by
  simp only [hiWeight, map_mul]
  exact QuantumTorus.hiWeight_mul w _ _ _

theorem loWeight_mul [IsDomain D] (w : G →+ ℤ) {f g : AddMonoidAlgebra D G}
    (hf : f ≠ 0) (hg : g ≠ 0) (hfg : f * g ≠ 0) :
    loWeight w (f * g) hfg = loWeight w f hf + loWeight w g hg := by
  simp only [loWeight, map_mul]
  exact QuantumTorus.loWeight_mul w _ _ _

theorem supportWidth_mul [IsDomain D] (w : G →+ ℤ) {f g : AddMonoidAlgebra D G}
    (hf : f ≠ 0) (hg : g ≠ 0) (hfg : f * g ≠ 0) :
    supportWidth w (f * g) hfg = supportWidth w f hf + supportWidth w g hg := by
  simp only [supportWidth, map_mul]
  exact QuantumTorus.supportWidth_mul w _ _ _

theorem topPart_mul [IsDomain D] (w : G →+ ℤ) {f g : AddMonoidAlgebra D G}
    (hf : f ≠ 0) (hg : g ≠ 0) (hfg : f * g ≠ 0) :
    topPart w (f * g) hfg = topPart w f hf * topPart w g hg := by
  simp only [topPart, ← map_mul]
  congr 1
  simp only [map_mul]
  exact QuantumTorus.topPart_mul w _ _ _

theorem bottomPart_mul [IsDomain D] (w : G →+ ℤ) {f g : AddMonoidAlgebra D G}
    (hf : f ≠ 0) (hg : g ≠ 0) (hfg : f * g ≠ 0) :
    bottomPart w (f * g) hfg = bottomPart w f hf * bottomPart w g hg := by
  simp only [bottomPart, ← map_mul]
  congr 1
  simp only [map_mul]
  exact QuantumTorus.bottomPart_mul w _ _ _

end TauCeti.Laurent
