/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.Quantum.Domain
public import TauCetiRoadmap.LaurentPhenomenon.Quantum.Monomial
public import TauCetiRoadmap.LaurentPhenomenon.GroupRing

/-!
# Extreme homogeneous parts in a twisted lattice algebra

Let `w : L →+ ℤ` be an integer weight on the lattice of `T(R,u,Λ)`. A nonzero element `f` has
a greatest and a least `w`-weight `hi_w f`, `lo_w f` on its support, and the homogeneous parts
`top_w f`, `bot_w f` of `f` at these weights are nonzero. Over a domain, for a torsion-free
lattice, `top_w (f g) = top_w f * top_w g` and `bot_w (f g) = bot_w f * bot_w g`: the product of
the extreme parts already carries the cocycle `u^{Λ(a,b)}` of each pair of extreme exponents, and
it is nonzero because `T(R,u,Λ)` is a domain. Hence `lo_w`, `hi_w` and the width
`hi_w - lo_w` are additive. No property of `u` or `Λ` is used, so the ordinary Laurent ring is
the case `u = 1`.
-/

@[expose] public section

namespace TauCeti.QuantumTorus

open TauCeti

variable {R : Type*} [CommRing R] {L : Type*} [AddCommGroup L] {u : Rˣ}
    {Λ : LinearMap.BilinForm ℤ L}

theorem support_nonempty {f : quantumTorus R u Λ} (hf : f ≠ 0) : (support f).Nonempty :=
  Finsupp.support_nonempty_iff.2 ((map_ne_zero_iff _ monomialBasis.repr.injective).2 hf)

/-- Every exponent of a product is a sum of exponents of the factors. -/
theorem exists_add_eq_of_mem_support_mul {f g : quantumTorus R u Λ} {c : L}
    (hc : c ∈ support (f * g)) : ∃ a ∈ support f, ∃ b ∈ support g, a + b = c := by
  classical
  by_contra! h
  refine mem_support_iff.1 hc ?_
  rw [coeff_apply, repr_mul_apply]
  exact Finset.sum_eq_zero fun a ha ↦ Finset.sum_eq_zero fun b hb ↦ by simp [h a ha b hb]

theorem support_add_subset [DecidableEq L] (f g : quantumTorus R u Λ) :
    support (f + g) ⊆ support f ∪ support g := by
  intro c hc
  rw [mem_support_iff, map_add] at hc
  rw [Finset.mem_union, mem_support_iff, mem_support_iff]
  by_contra! h
  exact hc (by rw [h.1, h.2, add_zero])

/-! ### Extreme weights -/

section Weight

variable (w : L →+ ℤ)

/-- The greatest `w`-weight on the support of a nonzero element. -/
noncomputable def hiWeight (f : quantumTorus R u Λ) (hf : f ≠ 0) : ℤ :=
  ((support f).image w).max' ((support_nonempty hf).image w)

/-- The least `w`-weight on the support of a nonzero element. -/
noncomputable def loWeight (f : quantumTorus R u Λ) (hf : f ≠ 0) : ℤ :=
  ((support f).image w).min' ((support_nonempty hf).image w)

/-- The `w`-width `hi_w f - lo_w f` of the support of a nonzero element. -/
noncomputable def supportWidth (f : quantumTorus R u Λ) (hf : f ≠ 0) : ℕ :=
  (hiWeight w f hf - loWeight w f hf).toNat

variable {f : quantumTorus R u Λ} (hf : f ≠ 0)

theorem le_hiWeight_of_mem {m : L} (hm : m ∈ support f) : w m ≤ hiWeight w f hf :=
  Finset.le_max' _ _ (Finset.mem_image_of_mem w hm)

theorem loWeight_le_of_mem {m : L} (hm : m ∈ support f) : loWeight w f hf ≤ w m :=
  Finset.min'_le _ _ (Finset.mem_image_of_mem w hm)

theorem exists_mem_support_hiWeight : ∃ m ∈ support f, w m = hiWeight w f hf :=
  Finset.mem_image.1 (Finset.max'_mem _ _)

theorem exists_mem_support_loWeight : ∃ m ∈ support f, w m = loWeight w f hf :=
  Finset.mem_image.1 (Finset.min'_mem _ _)

theorem loWeight_le_hiWeight : loWeight w f hf ≤ hiWeight w f hf :=
  Finset.min'_le_max' _ ((support_nonempty hf).image w)

/-- The width is `hi_w - lo_w`. -/
theorem supportWidth_eq : (supportWidth w f hf : ℤ) = hiWeight w f hf - loWeight w f hf :=
  Int.toNat_of_nonneg (sub_nonneg.2 (loWeight_le_hiWeight w hf))

theorem hiWeight_neg : hiWeight (-w) f hf = -loWeight w f hf := by
  obtain ⟨m, hm, hmw⟩ := exists_mem_support_hiWeight (-w) hf
  obtain ⟨n, hn, hnw⟩ := exists_mem_support_loWeight w hf
  have h₁ := le_hiWeight_of_mem (-w) hf hn
  have h₂ := loWeight_le_of_mem w hf hm
  simp only [AddMonoidHom.neg_apply] at hmw h₁
  omega

theorem loWeight_neg : loWeight (-w) f hf = -hiWeight w f hf := by
  have := hiWeight_neg (-w) hf
  rw [neg_neg] at this
  omega

end Weight

/-! ### Extreme homogeneous parts -/

section Part

variable (w : L →+ ℤ)

/-- The homogeneous part of a nonzero element at its greatest `w`-weight. -/
noncomputable def topPart (f : quantumTorus R u Λ) (hf : f ≠ 0) : quantumTorus R u Λ :=
  monomialBasis.repr.symm ((monomialBasis.repr f).filter fun a ↦ w a = hiWeight w f hf)

/-- The homogeneous part of a nonzero element at its least `w`-weight. -/
noncomputable def bottomPart (f : quantumTorus R u Λ) (hf : f ≠ 0) : quantumTorus R u Λ :=
  monomialBasis.repr.symm ((monomialBasis.repr f).filter fun a ↦ w a = loWeight w f hf)

variable {f : quantumTorus R u Λ} (hf : f ≠ 0)

theorem coeff_topPart (a : L) :
    coeff a (topPart w f hf) = if w a = hiWeight w f hf then coeff a f else 0 := by
  simp [topPart, coeff_apply, Finsupp.filter_apply]

theorem coeff_bottomPart (a : L) :
    coeff a (bottomPart w f hf) = if w a = loWeight w f hf then coeff a f else 0 := by
  simp [bottomPart, coeff_apply, Finsupp.filter_apply]

theorem bottomPart_eq_topPart_neg : bottomPart w f hf = topPart (-w) f hf := by
  refine ext_coeff fun a ↦ ?_
  simp only [coeff_bottomPart, coeff_topPart, hiWeight_neg, AddMonoidHom.neg_apply, neg_inj]

theorem mem_support_topPart {a : L} :
    a ∈ support (topPart w f hf) ↔ a ∈ support f ∧ w a = hiWeight w f hf := by
  simp only [mem_support_iff, coeff_topPart]
  split_ifs with h <;> simp [h]

theorem mem_support_bottomPart {a : L} :
    a ∈ support (bottomPart w f hf) ↔ a ∈ support f ∧ w a = loWeight w f hf := by
  simp only [mem_support_iff, coeff_bottomPart]
  split_ifs with h <;> simp [h]

/-- The top part is homogeneous of weight `hi_w f`. -/
theorem topPart_homogeneous {a : L} (ha : a ∈ support (topPart w f hf)) :
    w a = hiWeight w f hf :=
  ((mem_support_topPart w hf).1 ha).2

/-- The bottom part is homogeneous of weight `lo_w f`. -/
theorem bottomPart_homogeneous {a : L} (ha : a ∈ support (bottomPart w f hf)) :
    w a = loWeight w f hf :=
  ((mem_support_bottomPart w hf).1 ha).2

theorem topPart_ne_zero : topPart w f hf ≠ 0 := by
  obtain ⟨m, hm, hmw⟩ := exists_mem_support_hiWeight w hf
  intro h
  have := (mem_support_topPart w hf).2 ⟨hm, hmw⟩
  rw [h] at this
  simp [support] at this

theorem bottomPart_ne_zero : bottomPart w f hf ≠ 0 := by
  rw [bottomPart_eq_topPart_neg]
  exact topPart_ne_zero (-w) hf

/-- Away from the top part, every exponent has weight below `hi_w f`. -/
theorem weight_lt_of_mem_support_sub_topPart {a : L} (ha : a ∈ support (f - topPart w f hf)) :
    w a < hiWeight w f hf := by
  rw [mem_support_iff, map_sub, coeff_topPart] at ha
  split_ifs at ha with h
  · exact absurd (sub_self _) ha
  · exact lt_of_le_of_ne (le_hiWeight_of_mem w hf (mem_support_iff.2 (by simpa using ha))) h

end Part

/-! ### Products -/

section Mul

variable (w : L →+ ℤ) {f g : quantumTorus R u Λ} (hf : f ≠ 0) (hg : g ≠ 0)

theorem weight_mul_le_add_hi {m : L} (hm : m ∈ support (f * g)) :
    w m ≤ hiWeight w f hf + hiWeight w g hg := by
  obtain ⟨a, ha, b, hb, rfl⟩ := exists_add_eq_of_mem_support_mul hm
  rw [map_add]
  exact add_le_add (le_hiWeight_of_mem w hf ha) (le_hiWeight_of_mem w hg hb)

theorem add_lo_le_weight_mul {m : L} (hm : m ∈ support (f * g)) :
    loWeight w f hf + loWeight w g hg ≤ w m := by
  obtain ⟨a, ha, b, hb, rfl⟩ := exists_add_eq_of_mem_support_mul hm
  rw [map_add]
  exact add_le_add (loWeight_le_of_mem w hf ha) (loWeight_le_of_mem w hg hb)

private theorem weight_lt_of_mem_support_mul {x y : quantumTorus R u Λ} {s t : ℤ}
    (hx : ∀ a ∈ support x, w a ≤ s) (hy : ∀ b ∈ support y, w b ≤ t)
    (hlt : (∀ a ∈ support x, w a < s) ∨ ∀ b ∈ support y, w b < t)
    {c : L} (hc : c ∈ support (x * y)) : w c < s + t := by
  obtain ⟨a, ha, b, hb, rfl⟩ := exists_add_eq_of_mem_support_mul hc
  rw [map_add]
  rcases hlt with h | h
  · exact add_lt_add_of_lt_of_le (h a ha) (hy b hb)
  · exact add_lt_add_of_le_of_lt (hx a ha) (h b hb)

/-- `f g` is the product of the top parts plus terms of weight below `hi_w f + hi_w g`. -/
private theorem mul_eq_topPart_mul_add :
    ∃ E : quantumTorus R u Λ, f * g = topPart w f hf * topPart w g hg + E ∧
      ∀ c ∈ support E, w c < hiWeight w f hf + hiWeight w g hg := by
  classical
  refine ⟨topPart w f hf * (g - topPart w g hg) + (f - topPart w f hf) * g,
    by rw [mul_sub, sub_mul]; abel, fun c hc ↦ ?_⟩
  rcases Finset.mem_union.1 (support_add_subset _ _ hc) with hc | hc
  · exact weight_lt_of_mem_support_mul w
      (fun a ha ↦ (topPart_homogeneous w hf ha).le)
      (fun b hb ↦ (weight_lt_of_mem_support_sub_topPart w hg hb).le)
      (Or.inr fun b hb ↦ weight_lt_of_mem_support_sub_topPart w hg hb) hc
  · exact weight_lt_of_mem_support_mul w
      (fun a ha ↦ (weight_lt_of_mem_support_sub_topPart w hf ha).le)
      (fun b hb ↦ le_hiWeight_of_mem w hg hb)
      (Or.inl fun a ha ↦ weight_lt_of_mem_support_sub_topPart w hf ha) hc

/-- The product of the top parts is homogeneous of weight `hi_w f + hi_w g`. -/
theorem weight_eq_of_mem_support_topPart_mul {c : L}
    (hc : c ∈ support (topPart w f hf * topPart w g hg)) :
    w c = hiWeight w f hf + hiWeight w g hg := by
  obtain ⟨a, ha, b, hb, rfl⟩ := exists_add_eq_of_mem_support_mul hc
  rw [map_add, topPart_homogeneous w hf ha, topPart_homogeneous w hg hb]

variable [IsDomain R] [IsAddTorsionFree L]

/-- Over a domain, the product of the top parts is nonzero. -/
theorem topPart_mul_ne_zero : topPart w f hf * topPart w g hg ≠ 0 :=
  letI : UniqueSums L := Laurent.torsionFree_uniqueSums L
  mul_ne_zero (topPart_ne_zero w hf) (topPart_ne_zero w hg)

/-- Over a domain, the product of the bottom parts is nonzero. -/
theorem bottomPart_mul_ne_zero : bottomPart w f hf * bottomPart w g hg ≠ 0 :=
  letI : UniqueSums L := Laurent.torsionFree_uniqueSums L
  mul_ne_zero (bottomPart_ne_zero w hf) (bottomPart_ne_zero w hg)

/-- **Additivity of the greatest weight.** -/
theorem hiWeight_mul (hfg : f * g ≠ 0) :
    hiWeight w (f * g) hfg = hiWeight w f hf + hiWeight w g hg := by
  obtain ⟨E, hE, hEw⟩ := mul_eq_topPart_mul_add w hf hg
  refine le_antisymm (Finset.max'_le _ _ _ fun t ht ↦ ?_) ?_
  · obtain ⟨m, hm, rfl⟩ := Finset.mem_image.1 ht
    exact weight_mul_le_add_hi w hf hg hm
  · obtain ⟨c, hc⟩ := support_nonempty (topPart_mul_ne_zero w hf hg)
    have hcw := weight_eq_of_mem_support_topPart_mul w hf hg hc
    have hcE : c ∉ support E := fun h ↦ (hEw c h).ne hcw
    have hcfg : c ∈ support (f * g) := by
      rw [mem_support_iff, hE, map_add, coeff_eq_zero_of_notMem_support hcE, add_zero]
      exact mem_support_iff.1 hc
    exact hcw ▸ le_hiWeight_of_mem w hfg hcfg

/-- **Multiplicativity of the top part.** The cocycle `u^{Λ(a,b)}` of each pair of top exponents
is carried by the product on the right. -/
theorem topPart_mul (hfg : f * g ≠ 0) :
    topPart w (f * g) hfg = topPart w f hf * topPart w g hg := by
  obtain ⟨E, hE, hEw⟩ := mul_eq_topPart_mul_add w hf hg
  refine ext_coeff fun c ↦ ?_
  rw [coeff_topPart, hiWeight_mul w hf hg hfg]
  split_ifs with hcw
  · rw [hE, map_add, coeff_eq_zero_of_notMem_support fun h ↦ (hEw c h).ne hcw, add_zero]
  · exact (coeff_eq_zero_of_notMem_support fun h ↦
      hcw (weight_eq_of_mem_support_topPart_mul w hf hg h)).symm

/-- **Additivity of the least weight.** -/
theorem loWeight_mul (hfg : f * g ≠ 0) :
    loWeight w (f * g) hfg = loWeight w f hf + loWeight w g hg := by
  have := hiWeight_mul (-w) hf hg hfg
  rw [hiWeight_neg, hiWeight_neg, hiWeight_neg] at this
  omega

/-- **Multiplicativity of the bottom part.** -/
theorem bottomPart_mul (hfg : f * g ≠ 0) :
    bottomPart w (f * g) hfg = bottomPart w f hf * bottomPart w g hg := by
  simp only [bottomPart_eq_topPart_neg]
  exact topPart_mul (-w) hf hg hfg

/-- **Additivity of the width.** -/
theorem supportWidth_mul (hfg : f * g ≠ 0) :
    supportWidth w (f * g) hfg = supportWidth w f hf + supportWidth w g hg := by
  have h := supportWidth_eq w hfg
  rw [hiWeight_mul w hf hg hfg, loWeight_mul w hf hg hfg] at h
  have hf' := supportWidth_eq w hf
  have hg' := supportWidth_eq w hg
  omega

end Mul

end TauCeti.QuantumTorus
