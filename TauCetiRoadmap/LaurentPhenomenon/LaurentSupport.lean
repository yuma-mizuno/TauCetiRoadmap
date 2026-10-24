/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.LaurentWeight
public import Mathlib.Tactic.LinearCombination

/-!
# Relative primality in two independent directions

In the lattice Laurent ring `D[ℤ ^ I]` over a domain `D`, let `a, b` be linearly independent
exponents. A common divisor of an element supported on `ℤ a` and an element supported on `ℤ b`
has width zero for every integer weight annihilating `a` or `b`; the weights
`m ↦ a_r m_s - a_s m_r` show that it has singleton support. Hence such elements are relatively
prime as soon as one of them has a unit coefficient (`isRelPrime_of_support_zmultiples`). In
particular `∏ (1 + c_k X ^ a)` and `∏ (1 + d_l X ^ b)` are relatively prime for arbitrary
coefficients (`isRelPrime_list_prod_one_add_single`), and so are `1 + c X ^ a` and `1 + d X ^ b`.
The same width argument shows that the units of `D[ℤ ^ I]` are the monomials with unit coefficient.
-/

@[expose] public section

namespace TauCeti.Laurent

section Width

variable {D G : Type*} [CommRing D] [AddCommGroup G]

theorem supportWeight_eq_of_width_zero (w : G →+ ℤ)
    {f : AddMonoidAlgebra D G} (hf : f ≠ 0)
    (hwidth : supportWidth w f hf = 0)
    {a b : G} (ha : a ∈ f.coeff.support) (hb : b ∈ f.coeff.support) :
    w a = w b :=
  (supportWidth_eq_zero_iff w hf).1 hwidth a ha b hb

/-- A divisor of a nonzero element has width zero in every direction in which the element has
width zero. -/
theorem supportWidth_eq_zero_of_dvd [IsDomain D] [IsAddTorsionFree G] (w : G →+ ℤ)
    {h P : AddMonoidAlgebra D G} (hP : P ≠ 0) (hd : h ∣ P) (hw : supportWidth w P hP = 0) :
    supportWidth w h (ne_zero_of_dvd_ne_zero hP hd) = 0 := by
  obtain ⟨q, rfl⟩ := hd
  have := supportWidth_mul w (ne_zero_of_dvd_ne_zero hP (dvd_mul_right h q))
    (ne_zero_of_dvd_ne_zero hP (dvd_mul_left q h)) hP
  omega

/-- An element whose support is a single point is a monomial. -/
theorem exists_eq_single_of_forall_mem_support {f : AddMonoidAlgebra D G} (hf : f ≠ 0)
    (h : ∀ a ∈ f.coeff.support, ∀ b ∈ f.coeff.support, a = b) :
    ∃ a, f = AddMonoidAlgebra.single a (f.coeff a) := by
  classical
  have hcoeff : f.coeff ≠ 0 := fun hc ↦ hf (AddMonoidAlgebra.coeff_eq_zero.mp hc)
  obtain ⟨a, ha⟩ := Finsupp.support_nonempty_iff.mpr hcoeff
  refine ⟨a, AddMonoidAlgebra.coeff_injective ?_⟩
  simpa using Finsupp.support_subset_singleton.mp fun b hb ↦
    Finset.mem_singleton.mpr (h b hb a ha)

/-- A monomial with unit coefficient is a unit. -/
theorem isUnit_single (a : G) {c : D} (hc : IsUnit c) :
    IsUnit (AddMonoidAlgebra.single a c : AddMonoidAlgebra D G) := by
  obtain ⟨c, rfl⟩ := hc
  refine isUnit_iff_exists_inv.mpr ⟨AddMonoidAlgebra.single (-a) (↑c⁻¹ : D), ?_⟩
  simp [AddMonoidAlgebra.single_mul_single, AddMonoidAlgebra.one_def]

/-- A monomial dividing an element with a unit coefficient is a unit. -/
theorem isUnit_single_of_dvd {a : G} {c : D} {P : AddMonoidAlgebra D G}
    (hd : AddMonoidAlgebra.single a c ∣ P) (hP : ∃ m, IsUnit (P.coeff m)) :
    IsUnit (AddMonoidAlgebra.single a c : AddMonoidAlgebra D G) := by
  obtain ⟨q, rfl⟩ := hd
  obtain ⟨m, hm⟩ := hP
  rw [AddMonoidAlgebra.coeff_single_mul_apply] at hm
  exact isUnit_single a (isUnit_of_mul_isUnit_left hm)

end Width

variable {D I : Type*} [CommRing D]

/-! ### Separating two independent directions by integer weights -/

/-- The integer weight associated with a two-coordinate minor. -/
def determinantWeight (u : I →₀ ℤ) (r s : I) : (I →₀ ℤ) →+ ℤ where
  toFun m := u r * m s - u s * m r
  map_zero' := by simp
  map_add' a b := by simp [mul_add]; ring

@[simp] theorem determinantWeight_self (u : I →₀ ℤ) (r s : I) :
    determinantWeight u r s u = 0 := by
  simp [determinantWeight]
  ring

/-- An exponent annihilated by every weight annihilating `u` is a rational multiple of `u`. -/
theorem smul_eq_smul_of_forall_weight {u m : I →₀ ℤ} (r : I)
    (h : ∀ w : (I →₀ ℤ) →+ ℤ, w u = 0 → w m = 0) : u r • m = m r • u := by
  ext t
  have ht := h (determinantWeight u r t) (determinantWeight_self u r t)
  change u r * m t - u t * m r = 0 at ht
  simp only [Finsupp.smul_apply, smul_eq_mul]
  linear_combination ht

/-- **Weights separate independent directions.** If `a, b` are linearly independent, an exponent
annihilated by every integer weight annihilating `a` and by every integer weight annihilating `b`
is zero. -/
theorem eq_zero_of_forall_weight {a b : I →₀ ℤ} (hab : LinearIndependent ℤ ![a, b])
    {m : I →₀ ℤ} (ha : ∀ w : (I →₀ ℤ) →+ ℤ, w a = 0 → w m = 0)
    (hb : ∀ w : (I →₀ ℤ) →+ ℤ, w b = 0 → w m = 0) : m = 0 := by
  obtain ⟨r, hr⟩ := Finsupp.ne_iff.mp (hab.ne_zero 0)
  obtain ⟨s, hs⟩ := Finsupp.ne_iff.mp (hab.ne_zero 1)
  simp only [Matrix.cons_val_zero, Matrix.cons_val_one, Finsupp.coe_zero, Pi.zero_apply] at hr hs
  have hA := smul_eq_smul_of_forall_weight r ha
  have hB := smul_eq_smul_of_forall_weight s hb
  have hcomb : (b s * m r) • a + (-(a r * m s)) • b = 0 := by
    ext t
    have hAt := congrArg (fun x : I →₀ ℤ ↦ x t) hA
    have hBt := congrArg (fun x : I →₀ ℤ ↦ x t) hB
    simp only [Finsupp.smul_apply, smul_eq_mul] at hAt hBt
    simp only [Finsupp.add_apply, Finsupp.smul_apply, smul_eq_mul, Finsupp.coe_zero,
      Pi.zero_apply]
    linear_combination -(b s) * hAt + a r * hBt
  have hmr : m r = 0 := by
    have := (LinearIndependent.pair_iff.1 hab _ _ hcomb).1
    exact (mul_eq_zero.mp this).resolve_left hs
  ext t
  have ht := congrArg (fun x : I →₀ ℤ ↦ x t) hA
  simp only [Finsupp.smul_apply, smul_eq_mul, hmr, zero_mul] at ht
  exact (mul_eq_zero.mp ht).resolve_left hr

/-- A nonzero two-by-two minor makes two exponents linearly independent. -/
theorem linearIndependent_of_minor {u v : I →₀ ℤ} {r s : I}
    (hminor : u r * v s - u s * v r ≠ 0) : LinearIndependent ℤ ![u, v] := by
  refine LinearIndependent.pair_iff.2 fun m n h ↦ ?_
  have hr := congrArg (fun x : I →₀ ℤ ↦ x r) h
  have hs := congrArg (fun x : I →₀ ℤ ↦ x s) h
  simp only [Finsupp.add_apply, Finsupp.smul_apply, smul_eq_mul, Finsupp.coe_zero,
    Pi.zero_apply] at hr hs
  have hm : (u r * v s - u s * v r) * m = 0 := by linear_combination v s * hr - v r * hs
  have hn : (u r * v s - u s * v r) * n = 0 := by linear_combination u r * hs - u s * hr
  exact ⟨(mul_eq_zero.mp hm).resolve_left hminor, (mul_eq_zero.mp hn).resolve_left hminor⟩

/-! ### Relative primality -/

/-- **Relative primality in two independent directions.** Over a domain, let `P` be supported on
`ℤ a` with a unit coefficient and let `Q ≠ 0` be supported on `ℤ b`, for linearly independent
`a, b`. Then `P` and `Q` are relatively prime. -/
theorem isRelPrime_of_support_zmultiples [IsDomain D] {a b : I →₀ ℤ}
    (hab : LinearIndependent ℤ ![a, b]) {P Q : AddMonoidAlgebra D (I →₀ ℤ)}
    (hPa : ∀ m ∈ P.coeff.support, m ∈ AddSubgroup.zmultiples a)
    (hQb : ∀ m ∈ Q.coeff.support, m ∈ AddSubgroup.zmultiples b)
    (hPu : ∃ m, IsUnit (P.coeff m)) (hQ : Q ≠ 0) : IsRelPrime P Q := by
  intro h hhP hhQ
  have hP : P ≠ 0 := by
    rintro rfl
    obtain ⟨m, hm⟩ := hPu
    simp at hm
  have hh : h ≠ 0 := ne_zero_of_dvd_ne_zero hP hhP
  have hwidth {R : AddMonoidAlgebra D (I →₀ ℤ)} (hR : R ≠ 0) {c : I →₀ ℤ}
      (hRc : ∀ m ∈ R.coeff.support, m ∈ AddSubgroup.zmultiples c) (hd : h ∣ R)
      (w : (I →₀ ℤ) →+ ℤ) (hw : w c = 0) {x y : I →₀ ℤ} (hx : x ∈ h.coeff.support)
      (hy : y ∈ h.coeff.support) : w (x - y) = 0 := by
    have hR0 : supportWidth w R hR = 0 := by
      refine (supportWidth_eq_zero_iff w hR).2 fun m hm n hn ↦ ?_
      obtain ⟨k, rfl⟩ := AddSubgroup.mem_zmultiples_iff.1 (hRc m hm)
      obtain ⟨l, rfl⟩ := AddSubgroup.mem_zmultiples_iff.1 (hRc n hn)
      simp [hw]
    have := supportWeight_eq_of_width_zero w hh (supportWidth_eq_zero_of_dvd w hR hd hR0) hx hy
    rw [map_sub, this, sub_self]
  obtain ⟨x, hx⟩ := exists_eq_single_of_forall_mem_support hh fun x hx y hy ↦ sub_eq_zero.1 <|
    eq_zero_of_forall_weight hab (fun w hw ↦ hwidth hP hPa hhP w hw hx hy)
      (fun w hw ↦ hwidth hQ hQb hhQ w hw hx hy)
  rw [hx] at hhP ⊢
  exact isUnit_single_of_dvd hhP hPu

/--
The coefficient of `X ^ 0` in `∏ (1 + c_k X ^ a)` is `1`, and its exponents are multiples of `a`.
-/
theorem coeff_list_prod_one_add_single {G : Type*} [AddCommGroup G] [IsAddTorsionFree G]
    {a : G} (ha : a ≠ 0) (α : List D) :
    (∀ m, ((α.map fun c ↦ 1 + AddMonoidAlgebra.single a c).prod).coeff m ≠ 0 →
      ∃ k : ℕ, m = k • a) ∧
      ((α.map fun c ↦ 1 + AddMonoidAlgebra.single a c).prod).coeff 0 = 1 := by
  classical
  induction α with
  | nil =>
    refine ⟨fun m hm ↦ ⟨0, ?_⟩, by simp [AddMonoidAlgebra.one_def]⟩
    by_contra h
    exact hm (by simp [AddMonoidAlgebra.one_def, Ne.symm (by simpa using h)])
  | cons c α ih =>
    obtain ⟨ih₁, ih₂⟩ := ih
    have hneg : ((α.map fun c ↦ 1 + AddMonoidAlgebra.single a c).prod).coeff (-a) = 0 := by
      by_contra h
      obtain ⟨k, hk⟩ := ih₁ _ h
      have : (k + 1) • a = 0 := by rw [succ_nsmul, ← hk, neg_add_cancel]
      simp [ha] at this
    simp only [List.map_cons, List.prod_cons, add_mul, one_mul, AddMonoidAlgebra.coeff_add,
      Finsupp.add_apply, AddMonoidAlgebra.coeff_single_mul_apply]
    refine ⟨fun m hm ↦ ?_, by rw [add_zero, hneg, mul_zero, add_zero, ih₂]⟩
    by_cases h : ((α.map fun c ↦ 1 + AddMonoidAlgebra.single a c).prod).coeff m = 0
    · rw [h, zero_add] at hm
      obtain ⟨k, hk⟩ := ih₁ _ (right_ne_zero_of_mul hm)
      exact ⟨k + 1, by rw [succ_nsmul, ← hk, neg_add_cancel_comm]⟩
    · exact ih₁ m h

/-- **Products of binomials in two independent directions.** Over a domain, `∏ (1 + c_k X ^ a)` and
`∏ (1 + d_l X ^ b)` are relatively prime for linearly independent `a, b` and any coefficients. -/
theorem isRelPrime_list_prod_one_add_single [IsDomain D] {a b : I →₀ ℤ}
    (hab : LinearIndependent ℤ ![a, b]) (α β : List D) :
    IsRelPrime (α.map fun c ↦ 1 + AddMonoidAlgebra.single a c).prod
      (β.map fun d ↦ 1 + AddMonoidAlgebra.single b d).prod := by
  have hα := coeff_list_prod_one_add_single (hab.ne_zero 0) α
  have hβ := coeff_list_prod_one_add_single (hab.ne_zero 1) β
  simp only [Matrix.cons_val_zero, Matrix.cons_val_one] at hα hβ
  refine isRelPrime_of_support_zmultiples hab (fun m hm ↦ ?_) (fun m hm ↦ ?_)
    ⟨0, by rw [hα.2]; exact isUnit_one⟩ fun h ↦ by simp [h] at hβ
  · obtain ⟨k, rfl⟩ := hα.1 m (Finsupp.mem_support_iff.1 hm)
    exact AddSubgroup.nsmul_mem _ (AddSubgroup.mem_zmultiples a) k
  · obtain ⟨k, rfl⟩ := hβ.1 m (Finsupp.mem_support_iff.1 hm)
    exact AddSubgroup.nsmul_mem _ (AddSubgroup.mem_zmultiples b) k

/-! ### Binomials -/

/-- A two-term Laurent exchange binomial. -/
noncomputable def laurentBinomial (u : I →₀ ℤ) : AddMonoidAlgebra D (I →₀ ℤ) :=
  1 + AddMonoidAlgebra.single u 1

theorem laurentBinomial_coeff_zero {u : I →₀ ℤ} (hu : u ≠ 0) :
    (laurentBinomial (D := D) u).coeff 0 = 1 := by
  simp [laurentBinomial, AddMonoidAlgebra.one_def, hu, eq_comm]

theorem laurentBinomial_ne_zero [Nontrivial D] {u : I →₀ ℤ} (hu : u ≠ 0) :
    laurentBinomial (D := D) u ≠ 0 := by
  intro hz
  have h := congrArg (fun f : AddMonoidAlgebra D (I →₀ ℤ) => f.coeff 0) hz
  simp [laurentBinomial_coeff_zero hu] at h

theorem laurentBinomial_support [Nontrivial D] [DecidableEq I]
    {u : I →₀ ℤ} (hu : u ≠ 0) :
    (laurentBinomial (D := D) u).coeff.support = {0, u} := by
  classical
  ext m
  simp only [Finsupp.mem_support_iff]
  by_cases hm0 : m = 0
  · subst m
    simp [laurentBinomial_coeff_zero hu]
  · by_cases hmu : m = u
    · subst m
      simp [laurentBinomial, AddMonoidAlgebra.one_def, hu]
    · simp [laurentBinomial, AddMonoidAlgebra.one_def, hm0, hmu]

theorem laurentBinomial_width_zero [Nontrivial D]
    (w : (I →₀ ℤ) →+ ℤ) {u : I →₀ ℤ} (hu : u ≠ 0) (hwu : w u = 0) :
    supportWidth w (laurentBinomial (D := D) u) (laurentBinomial_ne_zero hu) = 0 := by
  classical
  rw [supportWidth_eq_zero_iff, laurentBinomial_support hu]
  simp [hwu]

theorem divisor_support_weight_eq [IsDomain D]
    (w : (I →₀ ℤ) →+ ℤ) {u : I →₀ ℤ} (hu : u ≠ 0) (hwu : w u = 0)
    {h : AddMonoidAlgebra D (I →₀ ℤ)} (hd : h ∣ laurentBinomial (D := D) u)
    {a b : I →₀ ℤ} (ha : a ∈ h.coeff.support) (hb : b ∈ h.coeff.support) :
    w a = w b :=
  supportWeight_eq_of_width_zero w _
    (supportWidth_eq_zero_of_dvd w _ hd (laurentBinomial_width_zero w hu hwu)) ha hb

/-- A normalized binomial with an arbitrary coefficient. -/
noncomputable def unitLaurentBinomial (u : I →₀ ℤ) (c : D) :
    AddMonoidAlgebra D (I →₀ ℤ) := 1 + AddMonoidAlgebra.single u c

theorem unitLaurentBinomial_coeff_zero {u : I →₀ ℤ}
    (hu : u ≠ 0) (c : D) :
    (unitLaurentBinomial u c).coeff 0 = 1 := by
  classical
  simp [unitLaurentBinomial, AddMonoidAlgebra.one_def, hu, eq_comm]

theorem unitLaurentBinomial_ne_zero [Nontrivial D]
    {u : I →₀ ℤ} (hu : u ≠ 0) (c : D) : unitLaurentBinomial u c ≠ 0 := by
  classical
  intro hz
  have h := congrArg (fun f : AddMonoidAlgebra D (I →₀ ℤ) => f.coeff 0) hz
  simp [unitLaurentBinomial_coeff_zero hu] at h

theorem unitLaurentBinomial_support [Nontrivial D] [DecidableEq I]
    {u : I →₀ ℤ} (hu : u ≠ 0) {c : D} (hc : IsUnit c) :
    (unitLaurentBinomial u c).coeff.support = {0, u} := by
  classical
  ext m
  simp only [Finsupp.mem_support_iff]
  by_cases hm0 : m = 0
  · subst m
    simp [unitLaurentBinomial_coeff_zero hu]
  · by_cases hmu : m = u
    · subst m
      simp [unitLaurentBinomial, AddMonoidAlgebra.one_def, hu, hc.ne_zero]
    · simp [unitLaurentBinomial, AddMonoidAlgebra.one_def, hm0, hmu]

/-- **Independent binomials are relatively prime.** Over a domain, `1 + c X ^ u` and `1 + d X ^ v`
are relatively prime for linearly independent `u, v` and any coefficients `c, d`. -/
theorem isRelPrime_unitBinomial [IsDomain D] {u v : I →₀ ℤ}
    (huv : LinearIndependent ℤ ![u, v]) (c d : D) :
    IsRelPrime (unitLaurentBinomial u c) (unitLaurentBinomial v d) := by
  simpa [unitLaurentBinomial] using isRelPrime_list_prod_one_add_single huv [c] [d]

/-- Independent Laurent binomials are relatively prime over any coefficient domain. -/
theorem isRelPrime_one_add_monomial [IsDomain D] {u v : I →₀ ℤ}
    (huv : LinearIndependent ℤ ![u, v]) :
    IsRelPrime (laurentBinomial (D := D) u) (laurentBinomial (D := D) v) :=
  isRelPrime_unitBinomial huv 1 1

theorem isRelPrime_one_add_monomial_of_minor [IsDomain D]
    {u v : I →₀ ℤ} {r s : I}
    (hminor : u r * v s - u s * v r ≠ 0) :
    IsRelPrime (laurentBinomial (D := D) u) (laurentBinomial (D := D) v) :=
  isRelPrime_one_add_monomial (linearIndependent_of_minor hminor)

/-- Every Laurent monomial with coefficient one is a unit. -/
theorem isUnit_monomial (a : I →₀ ℤ) :
    IsUnit (AddMonoidAlgebra.single a (1 : D) : AddMonoidAlgebra D (I →₀ ℤ)) :=
  isUnit_single a isUnit_one

/-- A signed pair of monomials is a monomial unit times a normalized binomial. -/
theorem monomial_add_monomial_eq (p n : I →₀ ℤ) :
    (AddMonoidAlgebra.single p (1 : D) + AddMonoidAlgebra.single n 1 :
      AddMonoidAlgebra D (I →₀ ℤ)) =
      AddMonoidAlgebra.single n 1 * laurentBinomial (p - n) := by
  simp [laurentBinomial, mul_add, AddMonoidAlgebra.single_mul_single,
    AddMonoidAlgebra.one_def, add_comm]

/-- Two signed monomial sums are coprime if their difference vectors have a nonzero minor. -/
theorem isRelPrime_monomial_add_monomial_of_minor [IsDomain D]
    {p n q m : I →₀ ℤ} {r s : I}
    (hminor : (p - n) r * (q - m) s - (p - n) s * (q - m) r ≠ 0) :
    IsRelPrime
      (AddMonoidAlgebra.single p (1 : D) + AddMonoidAlgebra.single n 1)
      (AddMonoidAlgebra.single q (1 : D) + AddMonoidAlgebra.single m 1) := by
  rw [monomial_add_monomial_eq p n, monomial_add_monomial_eq q m,
    isRelPrime_mul_unit_left_left (isUnit_monomial (D := D) n),
    isRelPrime_mul_unit_left_right (isUnit_monomial (D := D) m)]
  exact isRelPrime_one_add_monomial_of_minor hminor

/-! ### Units -/

/-- **Units of a lattice Laurent ring.** Over a domain, the units of `D[ℤ ^ I]` are the monomials
with unit coefficient. -/
theorem isUnit_iff_exists_single [IsDomain D] {f : AddMonoidAlgebra D (I →₀ ℤ)} :
    IsUnit f ↔ ∃ a c, IsUnit c ∧ f = AddMonoidAlgebra.single a c := by
  refine ⟨fun hf ↦ ?_, fun ⟨a, c, hc, hfa⟩ ↦ hfa ▸ isUnit_single a hc⟩
  have h1 : (1 : AddMonoidAlgebra D (I →₀ ℤ)) ≠ 0 := one_ne_zero
  have hd : f ∣ 1 := hf.dvd
  have hf0 : f ≠ 0 := ne_zero_of_dvd_ne_zero h1 hd
  have h1s : ∀ m ∈ (1 : AddMonoidAlgebra D (I →₀ ℤ)).coeff.support, m = 0 := fun m hm ↦ by
    by_contra h
    exact Finsupp.mem_support_iff.1 hm (by simp [AddMonoidAlgebra.one_def, Ne.symm h])
  obtain ⟨a, ha⟩ := exists_eq_single_of_forall_mem_support hf0 fun x hx y hy ↦ by
    ext i
    have hw := supportWidth_eq_zero_of_dvd (Finsupp.applyAddHom i) h1 hd
      ((supportWidth_eq_zero_iff _ h1).2 fun m hm n hn ↦ by rw [h1s m hm, h1s n hn])
    exact supportWeight_eq_of_width_zero _ hf0 hw hx hy
  rw [ha] at hd
  obtain ⟨q, hq⟩ := hd
  have h0 := congrArg (fun g : AddMonoidAlgebra D (I →₀ ℤ) ↦ g.coeff 0) hq
  simp only [AddMonoidAlgebra.coeff_single_mul_apply] at h0
  exact ⟨a, f.coeff a,
    IsUnit.of_mul_eq_one _ (by simpa [AddMonoidAlgebra.one_def] using h0.symm), ha⟩

end TauCeti.Laurent
