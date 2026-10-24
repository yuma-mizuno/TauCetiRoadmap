/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.Chart
public import TauCetiRoadmap.LaurentPhenomenon.SkewPatching

/-!
# The embedded skew one-exchange

Inside a division ring `D`, let `C` be a subring and let `x ≠ 0` normalize `C`, with the integer
powers of `x` free over `C` for left coefficients. For a nonzero element `E ∈ C` normalizing `C`,
put `y = E * x⁻¹`, `σ(c) = x * c * x⁻¹`, `P_0 = 1` and `P_{r + 1} = P_r * σ^{-r}(E)`.
This file proves:

* every element of the chart `C[x^{±1}]` has a unique finite expansion `∑ c_m * x ^ m` with
  `c_m ∈ C` (`mem_chartRing_iff`, `coeff`, `coeff_expand`);
* `y` is nonzero, normalizes `C`, is free over `C`, and `y ^ r = P_r * x ^ (-r)`
  (`ExchangeData.y_leftFree`, `ExchangeData.y_pow`);
* an element of `C[x^{±1}]` lies in `C[y^{±1}]` iff `c_{-r} ∈ C * P_r` for every `r > 0`
  (`ExchangeData.mem_chartRing_y_iff`);
* `C[x^{±1}] ∩ C[y^{±1}] = C⟨x, y⟩`, with unique normal forms
  `c_0 + ∑_{r>0} (c_r * x ^ r + c'_r * y ^ r)` (`ExchangeData.chartRing_inf_chartRing`,
  `ExchangeData.exists_normalForm`, `ExchangeData.normalForm_injective`);
* the same statements with the roles of `x` and `y` exchanged, using `x = σ(E) * y⁻¹`
  (`ExchangeData.swap`).

No commutativity is assumed, and every coefficient stands on the left.
-/

@[expose] public section

namespace TauCeti.Laurent.SkewExchange

open Finset

noncomputable section

variable {D : Type*} [DivisionRing D]

/-! ### Normalizing elements and conjugation -/

theorem normalizes_zpow {C : Subring D} {u : D} (h : Normalizes C u) (n : ℤ) :
    Normalizes C (u ^ n) := by
  cases n with
  | ofNat n => simpa using h.pow n
  | negSucc n => simpa [zpow_negSucc] using (h.pow (n + 1)).inv

/-- The conjugate `σ ^ n(c) = x ^ n * c * x ^ (-n)`. -/
def conj (x : D) (n : ℤ) (c : D) : D := x ^ n * c * x ^ (-n)
section Conj

variable {C : Subring D} {x : D}

theorem conj_mem (h : Normalizes C x) (n : ℤ) {c : D} (hc : c ∈ C) : conj x n c ∈ C := by
  simpa only [conj, zpow_neg] using (normalizes_zpow h n).conj_mem hc

theorem conj_zero (c : D) : conj x 0 c = c := by simp [conj]
theorem conj_one (hx : x ≠ 0) (n : ℤ) : conj x n 1 = 1 := by
  rw [conj, mul_one, ← zpow_add₀ hx, add_neg_cancel, zpow_zero]

theorem conj_mul (hx : x ≠ 0) (n : ℤ) (a b : D) :
    conj x n (a * b) = conj x n a * conj x n b := by
  have : x ^ (-n) * (x ^ n * (b * x ^ (-n))) = b * x ^ (-n) := by
    rw [← mul_assoc, ← zpow_add₀ hx, neg_add_cancel, zpow_zero, one_mul]
  simp only [conj, mul_assoc, this]

theorem conj_conj (hx : x ≠ 0) (m n : ℤ) (c : D) :
    conj x m (conj x n c) = conj x (m + n) c := by
  simp only [conj, neg_add_rev, zpow_add₀ hx, mul_assoc]

theorem conj_ne_zero (hx : x ≠ 0) (n : ℤ) {c : D} (hc : c ≠ 0) : conj x n c ≠ 0 :=
  mul_ne_zero (mul_ne_zero (zpow_ne_zero n hx) hc) (zpow_ne_zero _ hx)

/-- Moving a power of `x` past a left coefficient conjugates it. -/
theorem monomial_mul_monomial (hx : x ≠ 0) (c d : D) (m n : ℤ) :
    c * x ^ m * (d * x ^ n) = c * conj x m d * x ^ (m + n) := by
  have : x ^ (-m) * x ^ (m + n) = x ^ n := by rw [← zpow_add₀ hx, neg_add_cancel_left]
  simp only [conj, mul_assoc, this]

end Conj

/-! ### Expansions in powers of `x` -/

/-- The element `∑ m, f m * x ^ m`, with coefficients on the left. -/
def expand (x : D) : (ℤ →₀ D) →+ D :=
  Finsupp.liftAddHom fun m ↦ AddMonoidHom.mulRight (x ^ m)

theorem expand_apply (x : D) (f : ℤ →₀ D) : expand x f = f.sum fun m c ↦ c * x ^ m := rfl
theorem expand_eq_sum (x : D) (f : ℤ →₀ D) : expand x f = ∑ m ∈ f.support, f m * x ^ m := rfl
theorem expand_single (x : D) (m : ℤ) (c : D) : expand x (Finsupp.single m c) = c * x ^ m := by
  simp [expand]

/-- The integer powers of `x` are linearly independent over `C` for left coefficients. -/
def LeftFree (C : Subring D) (x : D) : Prop :=
  ∀ f : ℤ →₀ D, (∀ m, f m ∈ C) → (f.sum fun m c ↦ c * x ^ m) = 0 → f = 0

section Expansion

variable {C : Subring D} {x : D}

theorem single_mem {c : D} (hc : c ∈ C) (n m : ℤ) : Finsupp.single n c m ∈ C := by
  classical
  rw [Finsupp.single_apply]
  split_ifs
  exacts [hc, C.zero_mem]

variable (C x) in
/-- A finite sum of monomials with coefficients in `C` is an expansion, with the expected
coefficients. -/
theorem exists_expand_eq_sum {ι : Type*} (s : Finset ι) (e : ι → ℤ) (c : ι → D)
    (hc : ∀ i ∈ s, c i ∈ C) :
    ∃ g : ℤ →₀ D, (∀ m, g m ∈ C) ∧ expand x g = ∑ i ∈ s, c i * x ^ e i ∧
      ∀ m, g m = ∑ i ∈ s, if e i = m then c i else 0 := by
  classical
  have hg : ∀ m, (∑ i ∈ s, Finsupp.single (e i) (c i)) m =
      ∑ i ∈ s, if e i = m then c i else 0 := by
    intro m
    rw [Finsupp.finsetSum_apply]
    simp [Finsupp.single_apply]
  refine ⟨∑ i ∈ s, Finsupp.single (e i) (c i), fun m ↦ ?_, ?_, hg⟩
  · rw [hg]
    refine C.sum_mem fun i hi ↦ ?_
    split_ifs
    exacts [hc i hi, C.zero_mem]
  · simp [map_sum, expand_single]

theorem LeftFree.eq_of_expand_eq (hfree : LeftFree C x) {g g' : ℤ →₀ D} (hg : ∀ m, g m ∈ C)
    (hg' : ∀ m, g' m ∈ C) (h : expand x g = expand x g') : g = g' := by
  have := hfree (g - g') (fun m ↦ C.sub_mem (hg m) (hg' m))
    (by rw [← expand_apply, map_sub, h, sub_self])
  exact sub_eq_zero.mp this

/-- Freeness in the form of a finite sum with injective exponents. -/
theorem LeftFree.eq_zero_of_sum (hfree : LeftFree C x) {ι : Type*} (s : Finset ι)
    (e : ι → ℤ) (he : Set.InjOn e s) (c : ι → D) (hc : ∀ i ∈ s, c i ∈ C)
    (h : ∑ i ∈ s, c i * x ^ e i = 0) {i : ι} (hi : i ∈ s) : c i = 0 := by
  obtain ⟨g, hgC, hg, hgm⟩ := exists_expand_eq_sum C x s e c hc
  have hg0 : g = 0 := hfree g hgC (by rw [← expand_apply, hg, h])
  have := hgm (e i)
  rw [hg0, Finsupp.zero_apply, Finset.sum_eq_single i] at this
  · simpa using this.symm
  · intro j hj hji
    rw [ite_eq_right fun hji' ↦ hji (he hj hi hji')]
  · exact fun h ↦ absurd hi h

theorem leftFree_of_sum
    (h : ∀ (s : Finset ℤ) (c : ℤ → D), (∀ i ∈ s, c i ∈ C) →
      ∑ i ∈ s, c i * x ^ i = 0 → ∀ i ∈ s, c i = 0) :
    LeftFree C x := by
  intro f hf hsum
  ext m
  by_contra hm
  exact hm (h f.support f (fun i _ ↦ hf i) hsum m (Finsupp.mem_support_iff.mpr hm))

/-- Every element of the chart `C[x^{±1}]` is a finite sum `∑ c_m * x ^ m` with `c_m ∈ C`. -/
theorem mem_chartRing_iff (hσ : Normalizes C x) {a : D} :
    a ∈ chartRing C (fun _ : Unit ↦ x) ↔
      ∃ g : ℤ →₀ D, (∀ m, g m ∈ C) ∧ (g.sum fun m c ↦ c * x ^ m) = a := by
  constructor
  · intro ha
    let S : Subring D :=
      { carrier := {a | ∃ g : ℤ →₀ D, (∀ m, g m ∈ C) ∧ expand x g = a}
        zero_mem' := ⟨0, fun _ ↦ C.zero_mem, map_zero _⟩
        one_mem' := ⟨Finsupp.single 0 1, single_mem C.one_mem 0, by simp [expand_single]⟩
        add_mem' := by
          rintro _ _ ⟨g, hg, rfl⟩ ⟨g', hg', rfl⟩
          exact ⟨g + g', fun m ↦ C.add_mem (hg m) (hg' m), map_add _ _ _⟩
        neg_mem' := by
          rintro _ ⟨g, hg, rfl⟩
          exact ⟨-g, fun m ↦ C.neg_mem (hg m), map_neg _ _⟩
        mul_mem' := by
          rintro _ _ ⟨g, hg, rfl⟩ ⟨g', hg', rfl⟩
          obtain ⟨k, hk, hke, -⟩ := exists_expand_eq_sum C x (g.support ×ˢ g'.support)
            (fun p ↦ p.1 + p.2) (fun p ↦ g p.1 * conj x p.1 (g' p.2))
            (fun p _ ↦ C.mul_mem (hg _) (conj_mem hσ _ (hg' _)))
          refine ⟨k, hk, ?_⟩
          rw [hke, Finset.sum_product, expand_eq_sum, expand_eq_sum, Finset.sum_mul]
          refine Finset.sum_congr rfl fun m _ ↦ ?_
          rw [Finset.mul_sum]
          exact Finset.sum_congr rfl fun n _ ↦ (monomial_mul_monomial hσ.ne_zero _ _ _ _).symm }
    have hS : chartRing C (fun _ : Unit ↦ x) ≤ S := by
      refine chartRing_le (fun c hc ↦ ⟨Finsupp.single 0 c, single_mem hc 0, by
        simp [expand_single]⟩) (fun _ ↦ ⟨Finsupp.single 1 1, single_mem C.one_mem 1, by
        simp [expand_single]⟩) (fun _ ↦ ⟨Finsupp.single (-1) 1, single_mem C.one_mem (-1), by
        simp [expand_single]⟩)
    obtain ⟨g, hg, rfl⟩ := hS ha
    exact ⟨g, hg, rfl⟩
  · rintro ⟨g, hg, rfl⟩
    refine Subring.sum_mem _ fun m _ ↦ Subring.mul_mem _ (coefficient_mem_chartRing C _ (hg m)) ?_
    simpa using coordinate_zpow_mem_chartRing C (fun _ : Unit ↦ x) () m

theorem sum_monomial_mem_chartRing {ι : Type*} (s : Finset ι) (e : ι → ℤ) (c : ι → D)
    (hc : ∀ i ∈ s, c i ∈ C) : ∑ i ∈ s, c i * x ^ e i ∈ chartRing C (fun _ : Unit ↦ x) :=
  Subring.sum_mem _ fun i hi ↦ Subring.mul_mem _ (coefficient_mem_chartRing C _ (hc i hi))
    (by simpa using coordinate_zpow_mem_chartRing C (fun _ : Unit ↦ x) () (e i))

open scoped Classical in
variable (C x) in
/-- The left coefficients of `a` in powers of `x` over `C`; zero when `a` has no expansion. -/
def coeff (a : D) : ℤ →₀ D :=
  if h : ∃ g : ℤ →₀ D, (∀ m, g m ∈ C) ∧ expand x g = a then h.choose else 0

variable (C x) in
theorem coeff_mem (a : D) (m : ℤ) : coeff C x a m ∈ C := by
  unfold coeff
  split_ifs with h
  · exact h.choose_spec.1 m
  · exact C.zero_mem

theorem expand_coeff (hσ : Normalizes C x) {a : D}
    (ha : a ∈ chartRing C (fun _ : Unit ↦ x)) : expand x (coeff C x a) = a := by
  have h : ∃ g : ℤ →₀ D, (∀ m, g m ∈ C) ∧ expand x g = a := (mem_chartRing_iff hσ).mp ha
  rw [coeff, dite_eq_left h]
  exact h.choose_spec.2

theorem coeff_expand (hfree : LeftFree C x) {g : ℤ →₀ D} (hg : ∀ m, g m ∈ C) :
    coeff C x (expand x g) = g := by
  have h : ∃ g' : ℤ →₀ D, (∀ m, g' m ∈ C) ∧ expand x g' = expand x g := ⟨g, hg, rfl⟩
  rw [coeff, dite_eq_left h]
  exact hfree.eq_of_expand_eq h.choose_spec.1 hg h.choose_spec.2

/-- The coefficient function is characterized by its expansion. -/
theorem coeff_eq_iff (hσ : Normalizes C x) (hfree : LeftFree C x) {a : D}
    (ha : a ∈ chartRing C (fun _ : Unit ↦ x)) {g : ℤ →₀ D} (hg : ∀ m, g m ∈ C) :
    coeff C x a = g ↔ (g.sum fun m c ↦ c * x ^ m) = a := by
  constructor
  · rintro rfl
    exact expand_coeff hσ ha
  · intro h
    rw [← h, ← expand_apply, coeff_expand hfree hg]

theorem eq_of_coeff_eq (hσ : Normalizes C x) {a b : D}
    (ha : a ∈ chartRing C (fun _ : Unit ↦ x)) (hb : b ∈ chartRing C (fun _ : Unit ↦ x))
    (h : coeff C x a = coeff C x b) : a = b := by
  rw [← expand_coeff hσ ha, ← expand_coeff hσ hb, h]

theorem coeff_add (hσ : Normalizes C x) (hfree : LeftFree C x) {a b : D}
    (ha : a ∈ chartRing C (fun _ : Unit ↦ x)) (hb : b ∈ chartRing C (fun _ : Unit ↦ x)) :
    coeff C x (a + b) = coeff C x a + coeff C x b := by
  have := coeff_expand hfree (g := coeff C x a + coeff C x b)
    (fun m ↦ C.add_mem (coeff_mem C x a m) (coeff_mem C x b m))
  rwa [map_add, expand_coeff hσ ha, expand_coeff hσ hb] at this

theorem coeff_sum_monomial (hfree : LeftFree C x) {ι : Type*} (s : Finset ι) (e : ι → ℤ)
    (c : ι → D) (hc : ∀ i ∈ s, c i ∈ C) (m : ℤ) :
    coeff C x (∑ i ∈ s, c i * x ^ e i) m = ∑ i ∈ s, if e i = m then c i else 0 := by
  obtain ⟨g, hgC, hg, hgm⟩ := exists_expand_eq_sum C x s e c hc
  rw [← hg, coeff_expand hfree hgC, hgm]

end Expansion

theorem sum_ite_eq_apply {α M : Type*} [DecidableEq α] [Zero M] {N : Type*} [AddCommMonoid N]
    (g : α →₀ M) (F : α → N) (hF : ∀ a, g a = 0 → F a = 0) (a : α) :
    (∑ b ∈ g.support, if b = a then F b else 0) = F a := by
  rw [Finset.sum_ite_eq']
  split_ifs with h
  · rfl
  · exact (hF a (Finsupp.notMem_support_iff.mp h)).symm

/-! ### The exchanged coordinate -/

/-- The ordered products `P_0 = 1`, `P_{r + 1} = P_r * σ^{-r}(E)`, so that
`(E * x⁻¹) ^ r = P_r * x ^ (-r)`. -/
def orderedProduct (x E : D) : ℕ → D
  | 0 => 1
  | r + 1 => orderedProduct x E r * conj x (-(r : ℤ)) E

/-- Hypotheses of the one-exchange: `x` normalizes `C` with powers free over `C`, and `E ∈ C`
normalizes `C` (both are nonzero by `Normalizes`). The exchanged coordinate is `E * x⁻¹`. -/
structure ExchangeData (C : Subring D) (x E : D) : Prop where
  x_normalizes : Normalizes C x
  x_leftFree : LeftFree C x
  E_mem : E ∈ C
  E_normalizes : Normalizes C E

namespace ExchangeData

variable {C : Subring D} {x E : D} (h : ExchangeData C x E)
include h

theorem x_ne_zero : x ≠ 0 := h.x_normalizes.ne_zero
theorem E_ne_zero : E ≠ 0 := h.E_normalizes.ne_zero
theorem orderedProduct_mem (r : ℕ) : orderedProduct x E r ∈ C := by
  induction r with
  | zero => exact C.one_mem
  | succ r ih => exact C.mul_mem ih (conj_mem h.x_normalizes _ h.E_mem)

theorem orderedProduct_ne_zero (r : ℕ) : orderedProduct x E r ≠ 0 := by
  induction r with
  | zero => exact one_ne_zero
  | succ r ih => exact mul_ne_zero ih (conj_ne_zero h.x_ne_zero _ h.E_ne_zero)

/-- `P_{r + N} = P_r * σ^{-r}(P_N)`. -/
theorem orderedProduct_add (r N : ℕ) :
    orderedProduct x E (r + N) =
      orderedProduct x E r * conj x (-(r : ℤ)) (orderedProduct x E N) := by
  induction N with
  | zero => simp [orderedProduct, conj_one h.x_ne_zero]
  | succ N ih =>
    rw [← add_assoc]
    simp only [orderedProduct]
    rw [ih, conj_mul h.x_ne_zero, conj_conj h.x_ne_zero, mul_assoc]
    congr 3
    push_cast
    ring

theorem y_ne_zero : E * x⁻¹ ≠ 0 := mul_ne_zero h.E_ne_zero (inv_ne_zero h.x_ne_zero)
theorem y_normalizes : Normalizes C (E * x⁻¹) := h.E_normalizes.mul h.x_normalizes.inv
theorem y_pow (r : ℕ) : (E * x⁻¹) ^ r = orderedProduct x E r * x ^ (-(r : ℤ)) := by
  induction r with
  | zero => simp [orderedProduct]
  | succ r ih =>
    rw [pow_succ, ih, show E * x⁻¹ = E * x ^ (-1 : ℤ) by rw [zpow_neg_one],
      monomial_mul_monomial h.x_ne_zero,
      show -(r : ℤ) + -1 = -((r + 1 : ℕ) : ℤ) by push_cast; ring]
    rfl

theorem y_zpow_of_nonneg {n : ℤ} (hn : 0 ≤ n) :
    (E * x⁻¹) ^ n = orderedProduct x E n.toNat * x ^ (-n) := by
  lift n to ℕ using hn
  rw [zpow_natCast, y_pow h, Int.toNat_natCast]

/-- The powers of `y = E * x⁻¹` are free over `C`. -/
theorem y_leftFree : LeftFree C (E * x⁻¹) := by
  apply leftFree_of_sum
  intro s c hc hsum
  set N : ℕ := s.sup fun n ↦ (-n).toNat
  have hN : ∀ n ∈ s, 0 ≤ n + N := fun n hn ↦ by
    have : (-n).toNat ≤ N := Finset.le_sup (f := fun n ↦ (-n).toNat) hn
    omega
  have key : ∑ n ∈ s, (c n * orderedProduct x E (n + N).toNat) * x ^ (-(n + N)) = 0 := by
    rw [← zero_mul ((E * x⁻¹) ^ (N : ℤ)), ← hsum, Finset.sum_mul]
    refine Finset.sum_congr rfl fun n hn ↦ ?_
    rw [mul_assoc (c n) _ ((E * x⁻¹) ^ (N : ℤ)), ← zpow_add₀ h.y_ne_zero,
      h.y_zpow_of_nonneg (hN n hn), mul_assoc]
  intro n hn
  have := h.x_leftFree.eq_zero_of_sum s (fun n ↦ -(n + N))
    (fun a _ b _ hab ↦ by dsimp only at hab; omega) _
    (fun n hn ↦ C.mul_mem (hc n hn) (h.orderedProduct_mem _)) key hn
  exact (mul_eq_zero.mp this).resolve_right (h.orderedProduct_ne_zero _)

/-! ### The coefficient criterion -/

theorem closure_le_chartRing_x :
    Subring.closure ((C : Set D) ∪ {x, E * x⁻¹}) ≤ chartRing C (fun _ : Unit ↦ x) := by
  apply Subring.closure_le.mpr
  rintro a (ha | ha | ha)
  · exact coefficient_mem_chartRing C _ ha
  · rw [ha]
    exact coordinate_mem_chartRing C (fun _ : Unit ↦ x) ()
  · rw [Set.mem_singleton_iff.mp ha]
    exact Subring.mul_mem _ (coefficient_mem_chartRing C _ h.E_mem)
      (inverse_mem_chartRing C (fun _ : Unit ↦ x) ())

theorem closure_le_chartRing_y :
    Subring.closure ((C : Set D) ∪ {x, E * x⁻¹}) ≤ chartRing C (fun _ : Unit ↦ E * x⁻¹) := by
  apply Subring.closure_le.mpr
  rintro a (ha | ha | ha)
  · exact coefficient_mem_chartRing C _ ha
  · have hx : (E * x⁻¹)⁻¹ * E = a := by
      rw [mul_inv_rev, inv_inv, mul_assoc, inv_mul_cancel₀ h.E_ne_zero, mul_one, ha]
    rw [← hx]
    exact Subring.mul_mem _ (inverse_mem_chartRing C (fun _ : Unit ↦ E * x⁻¹) ())
      (coefficient_mem_chartRing C _ h.E_mem)
  · rw [Set.mem_singleton_iff.mp ha]
    exact coordinate_mem_chartRing C (fun _ : Unit ↦ E * x⁻¹) ()

/-- An element of `C[x^{±1}]` whose negative coefficients satisfy `c_{-r} ∈ C * P_r` lies
in `C⟨x, y⟩`. -/
theorem mem_closure_of_coeff {f : D} (hf : f ∈ chartRing C (fun _ : Unit ↦ x))
    (hc : ∀ r : ℕ, 0 < r → ∃ c ∈ C, coeff C x f (-(r : ℤ)) = c * orderedProduct x E r) :
    f ∈ Subring.closure ((C : Set D) ∪ {x, E * x⁻¹}) := by
  set K := Subring.closure ((C : Set D) ∪ {x, E * x⁻¹})
  have hCK : ∀ c ∈ C, c ∈ K := fun c hc ↦ Subring.subset_closure (Or.inl hc)
  have hxK : x ∈ K := Subring.subset_closure (Or.inr (Set.mem_insert _ _))
  have hyK : E * x⁻¹ ∈ K := Subring.subset_closure (Or.inr (Set.mem_insert_of_mem _ rfl))
  rw [← expand_coeff h.x_normalizes hf, expand_eq_sum]
  refine K.sum_mem fun m _ ↦ ?_
  rcases le_or_gt 0 m with hm | hm
  · lift m to ℕ using hm
    rw [zpow_natCast]
    exact K.mul_mem (hCK _ (coeff_mem C x f _)) (K.pow_mem hxK _)
  · obtain ⟨r, rfl⟩ : ∃ r : ℕ, m = -(r : ℤ) := ⟨(-m).toNat, by omega⟩
    obtain ⟨c, hcC, hce⟩ := hc r (by omega)
    rw [hce, mul_assoc, ← h.y_pow]
    exact K.mul_mem (hCK c hcC) (K.pow_mem hyK _)

/-- If `f` lies in both charts then `c_{-r} ∈ C * P_r` for every `r > 0`. -/
theorem exists_coeff_neg_eq {f : D} (hfx : f ∈ chartRing C (fun _ : Unit ↦ x))
    (hfy : f ∈ chartRing C (fun _ : Unit ↦ E * x⁻¹)) (r : ℕ) :
    ∃ c ∈ C, coeff C x f (-(r : ℤ)) = c * orderedProduct x E r := by
  obtain ⟨d, hdC, hd⟩ := (mem_chartRing_iff h.y_normalizes).mp hfy
  set s := d.support
  set N : ℕ := s.sup fun n ↦ (-n).toNat
  have hN : ∀ n ∈ s, 0 ≤ n + N := fun n hn ↦ by
    have : (-n).toNat ≤ N := Finset.le_sup (f := fun n ↦ (-n).toNat) hn
    omega
  have e1 : f * (E * x⁻¹) ^ N =
      ∑ n ∈ s, (d n * orderedProduct x E (n + N).toNat) * x ^ (-(n + N)) := by
    rw [← hd, Finsupp.sum, Finset.sum_mul]
    refine Finset.sum_congr rfl fun n hn ↦ ?_
    rw [← zpow_natCast, mul_assoc, ← zpow_add₀ h.y_ne_zero, h.y_zpow_of_nonneg (hN n hn),
      mul_assoc]
  have e2 : f * (E * x⁻¹) ^ N = ∑ m ∈ (coeff C x f).support,
      (coeff C x f m * conj x m (orderedProduct x E N)) * x ^ (m + -(N : ℤ)) := by
    conv_lhs => rw [← expand_coeff h.x_normalizes hfx]
    rw [expand_eq_sum, Finset.sum_mul, h.y_pow]
    exact Finset.sum_congr rfl fun m _ ↦ monomial_mul_monomial h.x_ne_zero _ _ _ _
  have c1 := coeff_sum_monomial h.x_leftFree s (fun n ↦ -(n + N))
    (fun n ↦ d n * orderedProduct x E (n + N).toNat)
    (fun n _ ↦ C.mul_mem (hdC n) (h.orderedProduct_mem _)) (-((N : ℤ) + r))
  have c2 := coeff_sum_monomial h.x_leftFree (coeff C x f).support (fun m ↦ m + -(N : ℤ))
    (fun m ↦ coeff C x f m * conj x m (orderedProduct x E N))
    (fun m _ ↦ C.mul_mem (coeff_mem C x f m) (conj_mem h.x_normalizes _
      (h.orderedProduct_mem _))) (-((N : ℤ) + r))
  rw [← e1] at c1
  rw [← e2, c1] at c2
  have i1 : ∀ n : ℤ, (-(n + (N : ℤ)) = -((N : ℤ) + r)) = (n = r) := fun n ↦ propext (by omega)
  have i2 : ∀ m : ℤ, (m + -(N : ℤ) = -((N : ℤ) + r)) = (m = -(r : ℤ)) :=
    fun m ↦ propext (by omega)
  simp only [i1, i2] at c2
  rw [sum_ite_eq_apply d (fun n ↦ d n * orderedProduct x E (n + N).toNat)
      (fun n hn ↦ by simp [hn]),
    sum_ite_eq_apply (coeff C x f) (fun m ↦ coeff C x f m * conj x m (orderedProduct x E N))
      (fun m hm ↦ by simp [hm])] at c2
  have hrN : ((r : ℤ) + N).toNat = r + N := by omega
  rw [hrN, h.orderedProduct_add, ← mul_assoc] at c2
  exact ⟨d r, hdC r, mul_right_cancel₀
    (conj_ne_zero h.x_ne_zero _ (h.orderedProduct_ne_zero N)) c2.symm⟩

/-- The coefficient criterion: an element of `C[x^{±1}]` lies in `C[y^{±1}]` iff its
coefficient at `x ^ (-r)` lies in `C * P_r` for every `r > 0`. -/
theorem mem_chartRing_y_iff {f : D} (hf : f ∈ chartRing C (fun _ : Unit ↦ x)) :
    f ∈ chartRing C (fun _ : Unit ↦ E * x⁻¹) ↔
      ∀ r : ℕ, 0 < r → ∃ c ∈ C, coeff C x f (-(r : ℤ)) = c * orderedProduct x E r :=
  ⟨fun hfy r _ ↦ h.exists_coeff_neg_eq hf hfy r,
    fun hc ↦ h.closure_le_chartRing_y (h.mem_closure_of_coeff hf hc)⟩

/-- The two-chart intersection is the subring generated by `C`, `x` and `y = E * x⁻¹`. -/
theorem chartRing_inf_chartRing :
    chartRing C (fun _ : Unit ↦ x) ⊓ chartRing C (fun _ : Unit ↦ E * x⁻¹) =
      Subring.closure ((C : Set D) ∪ {x, E * x⁻¹}) := by
  apply le_antisymm
  · intro f hf
    rw [Subring.mem_inf] at hf
    exact h.mem_closure_of_coeff hf.1 fun r _ ↦ h.exists_coeff_neg_eq hf.1 hf.2 r
  · exact le_inf h.closure_le_chartRing_x h.closure_le_chartRing_y

end ExchangeData

/-! ### Normal forms -/

/-- The element `∑ r, a r * x ^ r + ∑ r, b r * y ^ r`, with coefficients on the left. -/
def normalForm (x y : D) (a b : ℕ →₀ D) : D :=
  (a.sum fun r c ↦ c * x ^ r) + b.sum fun r c ↦ c * y ^ r

namespace ExchangeData

variable {C : Subring D} {x E : D} (h : ExchangeData C x E)
include h

omit h in
theorem normalForm_mem_closure {a b : ℕ →₀ D} (ha : ∀ r, a r ∈ C) (hb : ∀ r, b r ∈ C) :
    normalForm x (E * x⁻¹) a b ∈ Subring.closure ((C : Set D) ∪ {x, E * x⁻¹}) := by
  set K := Subring.closure ((C : Set D) ∪ {x, E * x⁻¹})
  have hxK : x ∈ K := Subring.subset_closure (Or.inr (Set.mem_insert _ _))
  have hyK : E * x⁻¹ ∈ K := Subring.subset_closure (Or.inr (Set.mem_insert_of_mem _ rfl))
  refine K.add_mem (K.sum_mem fun r _ ↦ ?_) (K.sum_mem fun r _ ↦ ?_)
  · exact K.mul_mem (Subring.subset_closure (Or.inl (ha r))) (K.pow_mem hxK r)
  · exact K.mul_mem (Subring.subset_closure (Or.inl (hb r))) (K.pow_mem hyK r)

theorem normalForm_mem_inf {a b : ℕ →₀ D} (ha : ∀ r, a r ∈ C) (hb : ∀ r, b r ∈ C) :
    normalForm x (E * x⁻¹) a b ∈
      chartRing C (fun _ : Unit ↦ x) ⊓ chartRing C (fun _ : Unit ↦ E * x⁻¹) := by
  rw [h.chartRing_inf_chartRing]
  exact normalForm_mem_closure ha hb

theorem normalForm_eq (a b : ℕ →₀ D) :
    normalForm x (E * x⁻¹) a b = (∑ r ∈ a.support, a r * x ^ (r : ℤ)) +
      ∑ r ∈ b.support, (b r * orderedProduct x E r) * x ^ (-(r : ℤ)) := by
  simp only [normalForm, Finsupp.sum, zpow_natCast, h.y_pow, mul_assoc]

theorem coeff_normalForm {a b : ℕ →₀ D} (ha : ∀ r, a r ∈ C) (hb : ∀ r, b r ∈ C) (m : ℤ) :
    coeff C x (normalForm x (E * x⁻¹) a b) m =
      (∑ r ∈ a.support, if (r : ℤ) = m then a r else 0) +
        ∑ r ∈ b.support, if -(r : ℤ) = m then b r * orderedProduct x E r else 0 := by
  have hb' : ∀ r ∈ b.support, b r * orderedProduct x E r ∈ C :=
    fun r _ ↦ C.mul_mem (hb r) (h.orderedProduct_mem r)
  rw [h.normalForm_eq, coeff_add h.x_normalizes h.x_leftFree
      (sum_monomial_mem_chartRing _ _ _ fun r _ ↦ ha r) (sum_monomial_mem_chartRing _ _ _ hb'),
    Finsupp.add_apply, coeff_sum_monomial h.x_leftFree _ _ _ (fun r _ ↦ ha r),
    coeff_sum_monomial h.x_leftFree _ _ _ hb']

theorem coeff_normalForm_natCast {a b : ℕ →₀ D} (ha : ∀ r, a r ∈ C) (hb : ∀ r, b r ∈ C)
    (hb0 : b 0 = 0) (r : ℕ) : coeff C x (normalForm x (E * x⁻¹) a b) (r : ℤ) = a r := by
  rw [h.coeff_normalForm ha hb]
  have i1 : ∀ j : ℕ, ((j : ℤ) = r) = (j = r) := fun j ↦ propext Nat.cast_inj
  simp only [i1]
  rw [sum_ite_eq_apply a a (fun _ h ↦ h), Finset.sum_eq_zero, add_zero]
  intro j _
  split_ifs with hj
  · obtain rfl : j = 0 := by omega
    simp [hb0]
  · rfl

theorem coeff_normalForm_neg {a b : ℕ →₀ D} (ha : ∀ r, a r ∈ C) (hb : ∀ r, b r ∈ C)
    {r : ℕ} (hr : 0 < r) :
    coeff C x (normalForm x (E * x⁻¹) a b) (-(r : ℤ)) = b r * orderedProduct x E r := by
  rw [h.coeff_normalForm ha hb]
  have i1 : ∀ j : ℕ, (-(j : ℤ) = -(r : ℤ)) = (j = r) := fun j ↦ propext (by omega)
  simp only [i1]
  rw [sum_ite_eq_apply b (fun j ↦ b j * orderedProduct x E j) (fun _ h ↦ by simp [h]),
    Finset.sum_eq_zero, zero_add]
  intro j _
  rw [ite_eq_right (by omega)]

/-- Uniqueness of the normal form `c_0 + ∑_{r>0} (c_r * x ^ r + c'_r * y ^ r)`. -/
theorem normalForm_injective {a b a' b' : ℕ →₀ D} (ha : ∀ r, a r ∈ C) (hb : ∀ r, b r ∈ C)
    (ha' : ∀ r, a' r ∈ C) (hb' : ∀ r, b' r ∈ C) (hb0 : b 0 = 0) (hb0' : b' 0 = 0)
    (heq : normalForm x (E * x⁻¹) a b = normalForm x (E * x⁻¹) a' b') :
    a = a' ∧ b = b' := by
  refine ⟨Finsupp.ext fun r ↦ ?_, Finsupp.ext fun r ↦ ?_⟩
  · rw [← h.coeff_normalForm_natCast ha hb hb0, heq, h.coeff_normalForm_natCast ha' hb' hb0']
  · rcases Nat.eq_zero_or_pos r with rfl | hr
    · rw [hb0, hb0']
    · have := h.coeff_normalForm_neg ha hb hr
      rw [heq, h.coeff_normalForm_neg ha' hb' hr] at this
      exact (mul_right_cancel₀ (h.orderedProduct_ne_zero r) this).symm

/-- Every element of the two-chart intersection has a normal form
`c_0 + ∑_{r>0} (c_r * x ^ r + c'_r * y ^ r)` with coefficients in `C`. -/
theorem exists_normalForm {f : D}
    (hf : f ∈ chartRing C (fun _ : Unit ↦ x) ⊓ chartRing C (fun _ : Unit ↦ E * x⁻¹)) :
    ∃ a b : ℕ →₀ D, (∀ r, a r ∈ C) ∧ (∀ r, b r ∈ C) ∧ b 0 = 0 ∧
      normalForm x (E * x⁻¹) a b = f := by
  classical
  rw [Subring.mem_inf] at hf
  set c := coeff C x f
  let a : ℕ →₀ D := Finsupp.onFinset (c.support.image Int.toNat) (fun r ↦ c r) (fun r hr ↦
    Finset.mem_image.mpr ⟨r, Finsupp.mem_support_iff.mpr hr, Int.toNat_natCast r⟩)
  let b : ℕ →₀ D := Finsupp.onFinset (c.support.image fun m ↦ (-m).toNat)
    (fun r ↦ if r = 0 then 0 else c (-(r : ℤ)) * (orderedProduct x E r)⁻¹) (fun r hr ↦ by
      refine Finset.mem_image.mpr ⟨-(r : ℤ), Finsupp.mem_support_iff.mpr ?_, by simp⟩
      intro h0
      simp [h0] at hr)
  have ha : ∀ r, a r ∈ C := fun r ↦ coeff_mem C x f r
  have hb : ∀ r, b r ∈ C := by
    intro r
    simp only [b, Finsupp.onFinset_apply]
    split_ifs with hr
    · exact C.zero_mem
    · obtain ⟨c', hc', he⟩ := h.exists_coeff_neg_eq hf.1 hf.2 r
      rw [he, mul_inv_cancel_right₀ (h.orderedProduct_ne_zero r)]
      exact hc'
  have hb0 : b 0 = 0 := by simp [b]
  refine ⟨a, b, ha, hb, hb0, ?_⟩
  have hmem := h.closure_le_chartRing_x (normalForm_mem_closure ha hb)
  refine eq_of_coeff_eq h.x_normalizes hmem hf.1 (Finsupp.ext fun m ↦ ?_)
  rcases le_or_gt 0 m with hm | hm
  · lift m to ℕ using hm
    rw [h.coeff_normalForm_natCast ha hb hb0]
    rfl
  · obtain ⟨r, rfl⟩ : ∃ r : ℕ, m = -(r : ℤ) := ⟨(-m).toNat, by omega⟩
    have hr : 0 < r := by omega
    rw [h.coeff_normalForm_neg ha hb hr]
    simp only [b, Finsupp.onFinset_apply, ite_eq_right hr.ne']
    rw [inv_mul_cancel_right₀ (h.orderedProduct_ne_zero r)]

/-! ### Exchanging the roles of `x` and `y` -/

/-- With `y = E * x⁻¹`, the data `(C, y, σ(E))` is again exchange data, and its exchanged
coordinate is `x` (`swap_exchange`). -/
theorem swap : ExchangeData C (E * x⁻¹) (x * E * x⁻¹) where
  x_normalizes := h.y_normalizes
  x_leftFree := h.y_leftFree
  E_mem := h.x_normalizes.conj_mem h.E_mem
  E_normalizes := (h.x_normalizes.mul h.E_normalizes).mul h.x_normalizes.inv

omit h in
theorem swap_exchange (hx : x ≠ 0) (hE : E ≠ 0) : x * E * x⁻¹ * (E * x⁻¹)⁻¹ = x := by
  rw [mul_inv_rev, inv_inv]
  simp only [mul_assoc, inv_mul_cancel_left₀ hx, mul_inv_cancel₀ hE, mul_one]

theorem chartRing_inf_chartRing_swap :
    chartRing C (fun _ : Unit ↦ E * x⁻¹) ⊓ chartRing C (fun _ : Unit ↦ x) =
      Subring.closure ((C : Set D) ∪ {E * x⁻¹, x}) := by
  have := h.swap.chartRing_inf_chartRing
  rwa [swap_exchange h.x_ne_zero h.E_ne_zero] at this

/-- The coefficient criterion read from the `y`-chart: an element of `C[y^{±1}]` lies in
`C[x^{±1}]` iff its `y`-coefficient at `y ^ (-r)` lies in `C * P'_r` for every `r > 0`, where
`P'` are the ordered products of `y` and `σ(E)`. -/
theorem mem_chartRing_x_iff {f : D} (hf : f ∈ chartRing C (fun _ : Unit ↦ E * x⁻¹)) :
    f ∈ chartRing C (fun _ : Unit ↦ x) ↔
      ∀ r : ℕ, 0 < r → ∃ c ∈ C,
        coeff C (E * x⁻¹) f (-(r : ℤ)) = c * orderedProduct (E * x⁻¹) (x * E * x⁻¹) r := by
  have := h.swap.mem_chartRing_y_iff hf
  rwa [swap_exchange h.x_ne_zero h.E_ne_zero] at this

/-- Normal forms read from the `y`-chart: `c_0 + ∑_{r>0} (c_r * y ^ r + c'_r * x ^ r)`. -/
theorem exists_normalForm_swap {f : D}
    (hf : f ∈ chartRing C (fun _ : Unit ↦ x) ⊓ chartRing C (fun _ : Unit ↦ E * x⁻¹)) :
    ∃ a b : ℕ →₀ D, (∀ r, a r ∈ C) ∧ (∀ r, b r ∈ C) ∧ b 0 = 0 ∧
      normalForm (E * x⁻¹) x a b = f := by
  have := @exists_normalForm _ _ _ _ _ h.swap f
  rw [swap_exchange h.x_ne_zero h.E_ne_zero, inf_comm] at this
  exact this hf

theorem normalForm_injective_swap {a b a' b' : ℕ →₀ D} (ha : ∀ r, a r ∈ C)
    (hb : ∀ r, b r ∈ C) (ha' : ∀ r, a' r ∈ C) (hb' : ∀ r, b' r ∈ C) (hb0 : b 0 = 0)
    (hb0' : b' 0 = 0) (heq : normalForm (E * x⁻¹) x a b = normalForm (E * x⁻¹) x a' b') :
    a = a' ∧ b = b' := by
  have := @normalForm_injective _ _ _ _ _ h.swap a b a' b' ha hb ha' hb' hb0 hb0'
  rw [swap_exchange h.x_ne_zero h.E_ne_zero] at this
  exact this heq

end ExchangeData

end

end TauCeti.Laurent.SkewExchange
