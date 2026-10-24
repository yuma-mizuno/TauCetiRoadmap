/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.PolynomialQuantumInvolutive
public import TauCetiRoadmap.ClusterAlgebras.QuantumSubsetRing
public import Mathlib.Algebra.Polynomial.AlgebraMap

/-!
# Central polynomial factors of a quantum exchange

A polynomial exchange is an evaluation at the central divided-column monomial,
followed by the negative endpoint monomial. Ordered products retain the usual
one-exchange coefficient criterion, in every degree.
-/

@[expose] public section

namespace TauCeti.Cluster.PolynomialQuantumSeed

open TauCeti TauCeti.QuantumTorus TauCeti.Laurent

noncomputable section

variable {D : Type*} [DivisionRing D] [Algebra Zv D]
  {M K : Type*} [Fintype M] [DecidableEq M] {row : K ↪ M}
  (s : PolynomialQuantumSeed D row)

/-- The integral pairing of a divided column with its own coordinate. -/
def columnWeight (k : K) : ℤ :=
  matrixForm s.form (s.dividedColumn k) (Pi.single (row k) 1)

theorem degree_mul_columnWeight (k : K) :
    (s.degree k : ℤ) * s.columnWeight k = s.exchange.symmetrizer k := by
  have h := s.compatible.matrixForm_col k (Pi.single (row k) 1)
  rw [← s.degree_mul_dividedColumn, map_zsmul, LinearMap.smul_apply, smul_eq_mul,
    Pi.single_eq_same, mul_one] at h
  exact h

theorem matrixForm_dividedColumn (k : K) (a : M → ℤ) :
    matrixForm s.form (s.dividedColumn k) a = s.columnWeight k * a (row k) := by
  apply mul_left_cancel₀ (show (s.degree k : ℤ) ≠ 0 by
    have := s.degree_pos k
    change 0 < s.degree k at this
    omega)
  rw [← mul_assoc, s.degree_mul_columnWeight]
  have h := s.compatible.matrixForm_col k a
  rwa [← s.degree_mul_dividedColumn, map_zsmul, LinearMap.smul_apply, smul_eq_mul] at h

theorem columnWeight_pos (k : K) : 0 < s.columnWeight k := by
  have hp : (0 : ℤ) < s.degree k := Int.natCast_pos.mpr (s.degree_pos k)
  have hm := s.exchange.symmetrizer_pos k
  rw [← s.degree_mul_columnWeight] at hm
  exact (mul_pos_iff.mp hm).resolve_right (fun h ↦ (not_lt_of_ge hp.le) h.1) |>.2

theorem degree_dvd_symmetrizer (k : K) : (s.degree k : ℤ) ∣ s.exchange.symmetrizer k :=
  ⟨s.columnWeight k, (s.degree_mul_columnWeight k).symm⟩

theorem columnWeight_ne_zero (k : K) : s.columnWeight k ≠ 0 := by
  intro h
  have ht := s.degree_mul_columnWeight k
  rw [h, mul_zero] at ht
  exact (s.exchange.symmetrizer_pos k).ne' ht.symm

theorem matrixForm_dividedColumn_right (k : K) (a : M → ℤ) :
    matrixForm s.form a (s.dividedColumn k) = -s.columnWeight k * a (row k) := by
  rw [s.alternating.matrixForm_swap, s.matrixForm_dividedColumn]
  ring

theorem monomial_dividedColumn_pow (k : K) (l : ℕ) :
    s.toQuantumSeed.monomial (s.dividedColumn k) ^ l =
      s.toQuantumSeed.monomial ((l : ℤ) • s.dividedColumn k) := by
  change s.toQuantumSeed.chart _ ^ l = s.toQuantumSeed.chart _
  rw [← map_pow, ← QuantumTorus.monomial_nsmul s.isAlt, natCast_zsmul]

/-- Evaluation of the exchange polynomial at a scalar multiple of its column monomial. -/
def polynomialFactor (k : K) (n : ℤ) : D :=
  Polynomial.aeval
    (algebraMap Zv D ((vUnit ^ n : Zvˣ) : Zv) *
      s.toQuantumSeed.monomial (s.dividedColumn k)) (s.polynomial k)

theorem polynomialFactor_eq_sum (k : K) (n : ℤ) :
    s.polynomialFactor k n = ∑ l ∈ Finset.range (s.degree k + 1),
      algebraMap Zv D ((s.polynomial k).coeff l) *
        (algebraMap Zv D ((vUnit ^ (n * l) : Zvˣ) : Zv) *
          s.toQuantumSeed.monomial ((l : ℤ) • s.dividedColumn k)) := by
  rw [polynomialFactor, Polynomial.aeval_eq_sum_range]
  apply Finset.sum_congr rfl
  intro l _
  rw [Algebra.smul_def (R := Zv) (A := D),
    (Algebra.commute_algebraMap_left _ _).mul_pow, ← map_pow,
    ← Units.val_pow_eq_pow_val, ← zpow_natCast, ← zpow_mul,
    s.monomial_dividedColumn_pow]

theorem exchangeCoordinate_eq_polynomialFactor_mul (k : K) :
    s.exchangeCoordinate k = s.polynomialFactor k (s.columnWeight k) *
      s.toQuantumSeed.monomial (exchangeExponentNeg row s.exchange.matrix k) := by
  rw [polynomialFactor_eq_sum, Finset.sum_mul, exchangeCoordinate]
  apply Finset.sum_congr rfl
  intro l _
  rw [mul_assoc, mul_assoc, s.toQuantumSeed.monomial_mul_monomial,
    map_zsmul, LinearMap.smul_apply, smul_eq_mul, s.matrixForm_dividedColumn,
    exchangeExponentNeg_row (s.exchange.diagonal k), mul_neg_one,
    ← mul_assoc (algebraMap Zv D ((vUnit ^ (s.columnWeight k * (l : ℤ)) : Zvˣ) : Zv)),
    ← map_mul, ← Units.val_mul, ← zpow_add]
  have h : s.columnWeight k * (l : ℤ) + (l : ℤ) * -s.columnWeight k = 0 := by ring
  rw [h, zpow_zero, Units.val_one, map_one, one_mul]
  congr 2
  exact add_comm _ _

theorem commute_monomial_dividedColumn (k : K) {c : D}
    (hc : c ∈ s.toQuantumSeed.otherRing (row k)) :
    Commute (s.toQuantumSeed.monomial (s.dividedColumn k)) c := by
  have hX : ∀ l : M, l ≠ row k →
      Commute (s.toQuantumSeed.monomial (s.dividedColumn k)) (s.coordinate l : D) := by
    intro l hl
    have h := s.toQuantumSeed.monomial_mul_coordinate (s.dividedColumn k) l
    rw [s.matrixForm_dividedColumn_single hl] at h
    simpa [Commute, SemiconjBy] using h
  have hle : s.toQuantumSeed.otherRing (row k) ≤
      Subring.centralizer {s.toQuantumSeed.monomial (s.dividedColumn k)} := by
    refine chartRing_le ?_ (fun l ↦ ?_) (fun l ↦ ?_)
    · rintro _ ⟨r, rfl⟩
      rw [Subring.mem_centralizer_iff]
      rintro g rfl
      exact (Algebra.commutes r _).symm
    · rw [Subring.mem_centralizer_iff]
      rintro g rfl
      exact hX l l.2
    · rw [Subring.mem_centralizer_iff]
      rintro g rfl
      exact (hX l l.2).inv_right₀
  exact (Subring.mem_centralizer_iff.1 (hle hc)) _ rfl

theorem polynomialFactor_mem_subsetRing (k : K) {S : Set M}
    (hS : ∀ a ∉ S, s.exchange.matrix a k = 0) (n : ℤ) :
    s.polynomialFactor k n ∈ s.toQuantumSeed.subsetRing S := by
  rw [polynomialFactor_eq_sum]
  apply Subring.sum_mem
  intro l _
  refine Subring.mul_mem _ (s.toQuantumSeed.algebraMap_mem_subsetRing _ _) ?_
  refine Subring.mul_mem _ (s.toQuantumSeed.algebraMap_mem_subsetRing _ _) ?_
  apply s.toQuantumSeed.monomial_mem_subsetRing
  intro a ha
  simp [dividedColumn, hS a ha]

theorem commute_polynomialFactor (k : K) (n : ℤ) {c : D}
    (hc : c ∈ s.toQuantumSeed.otherRing (row k)) : Commute (s.polynomialFactor k n) c := by
  rw [polynomialFactor_eq_sum]
  apply Commute.sum_left
  intro l _
  rw [← s.monomial_dividedColumn_pow]
  exact (Algebra.commute_algebraMap_left _ c).mul_left
    ((Algebra.commute_algebraMap_left _ c).mul_left
      ((s.commute_monomial_dividedColumn k hc).pow_left l))


theorem endpoint_mul_polynomialFactor (k : K) (n : ℤ) :
    s.toQuantumSeed.monomial (exchangeExponentNeg row s.exchange.matrix k) *
        s.polynomialFactor k n =
      s.polynomialFactor k (n + 2 * s.columnWeight k) *
        s.toQuantumSeed.monomial (exchangeExponentNeg row s.exchange.matrix k) := by
  rw [polynomialFactor_eq_sum, polynomialFactor_eq_sum, Finset.mul_sum, Finset.sum_mul]
  apply Finset.sum_congr rfl
  intro l _
  have hform : matrixForm s.form (exchangeExponentNeg row s.exchange.matrix k)
      ((l : ℤ) • s.dividedColumn k) = (l : ℤ) * s.columnWeight k := by
    rw [s.alternating.matrixForm_swap, map_zsmul, LinearMap.smul_apply,
      smul_eq_mul, s.matrixForm_dividedColumn, exchangeExponentNeg_row (s.exchange.diagonal k)]
    ring
  rw [← mul_assoc, ← Algebra.commutes ((s.polynomial k).coeff l), mul_assoc,
    ← mul_assoc (s.toQuantumSeed.monomial _), ← Algebra.commutes,
    mul_assoc, s.toQuantumSeed.monomial_mul_monomial_comm, hform,
    ← mul_assoc (algebraMap Zv D ((vUnit ^ (n * (l : ℤ)) : Zvˣ) : Zv)),
    ← map_mul, ← Units.val_mul, ← zpow_add]
  have h : n * (l : ℤ) + 2 * ((l : ℤ) * s.columnWeight k) =
      (n + 2 * s.columnWeight k) * (l : ℤ) := by ring
  rw [h]
  simp only [mul_assoc]

theorem endpoint_pow_mul_polynomialFactor (k : K) (n : ℤ) (r : ℕ) :
    s.toQuantumSeed.monomial (exchangeExponentNeg row s.exchange.matrix k) ^ r *
        s.polynomialFactor k n =
      s.polynomialFactor k (n + 2 * r * s.columnWeight k) *
        s.toQuantumSeed.monomial (exchangeExponentNeg row s.exchange.matrix k) ^ r := by
  induction r generalizing n with
  | zero => simp
  | succ r ih =>
    rw [pow_succ, mul_assoc, endpoint_mul_polynomialFactor, ← mul_assoc, ih, mul_assoc]
    congr 2
    push_cast
    ring

/-- The central factors of powers of the exchanged coordinate. -/
def centralProduct (k : K) (r : ℕ) : D :=
  ((List.range r).map fun h : ℕ ↦
    s.polynomialFactor k ((2 * (h : ℤ) + 1) * s.columnWeight k)).prod

@[simp] theorem centralProduct_zero (k : K) : s.centralProduct k 0 = 1 := rfl

theorem centralProduct_succ (k : K) (r : ℕ) :
    s.centralProduct k (r + 1) = s.centralProduct k r *
      s.polynomialFactor k ((2 * (r : ℤ) + 1) * s.columnWeight k) := by
  simp [centralProduct, List.range_succ]

theorem exchangeCoordinate_pow (k : K) (r : ℕ) :
    s.exchangeCoordinate k ^ r = s.centralProduct k r *
      s.toQuantumSeed.monomial (exchangeExponentNeg row s.exchange.matrix k) ^ r := by
  induction r with
  | zero => simp
  | succ r ih =>
    rw [pow_succ, ih, s.exchangeCoordinate_eq_polynomialFactor_mul k, mul_assoc,
      ← mul_assoc (s.toQuantumSeed.monomial _ ^ r),
      s.endpoint_pow_mul_polynomialFactor, centralProduct_succ, pow_succ]
    simp only [mul_assoc]
    congr 3
    ring

theorem centralProduct_mem_subsetRing (k : K) {S : Set M}
    (hS : ∀ a ∉ S, s.exchange.matrix a k = 0) (r : ℕ) :
    s.centralProduct k r ∈ s.toQuantumSeed.subsetRing S := by
  induction r with
  | zero => exact Subring.one_mem _
  | succ r ih =>
    rw [centralProduct_succ]
    exact Subring.mul_mem _ ih (s.polynomialFactor_mem_subsetRing k hS _)

theorem commute_centralProduct (k : K) (r : ℕ) {c : D}
    (hc : c ∈ s.toQuantumSeed.otherRing (row k)) : Commute (s.centralProduct k r) c := by
  induction r with
  | zero => exact Commute.one_left c
  | succ r ih =>
    rw [centralProduct_succ]
    exact ih.mul_left (s.commute_polynomialFactor k _ hc)

theorem exchangeCoordinate_normalizes_subsetRing (k : K) {S : Set M}
    (hk : row k ∉ S) :
    Normalizes (s.toQuantumSeed.subsetRing S) (s.exchangeCoordinate k) :=
  s.toQuantumSeed.normalizes_subsetRing (s.exchangeCoordinate_ne_zero k)
    (fun j ↦ vUnit ^ (2 * matrixForm s.form (exchangeExponentPos row s.exchange.matrix k)
      (Pi.single j 1)))
    (fun _ hj ↦ s.exchangeCoordinate_mul_coordinate k (fun h ↦ hk (h ▸ hj)))

theorem exchangeData_subsetRing (k : K) {S : Set M} (hk : row k ∉ S)
    (hS : ∀ a ∉ S, s.exchange.matrix a k = 0) :
    SkewExchange.ExchangeData (s.toQuantumSeed.subsetRing S) (s.coordinate (row k) : D)
      (s.exchangeCoordinate k * s.coordinate (row k)) where
  x_normalizes := s.toQuantumSeed.coordinate_normalizes_subsetRing S (row k)
  x_leftFree := fun f hf h0 ↦ s.toQuantumSeed.leftFree_coordinate (row k) f
    (fun m ↦ s.toQuantumSeed.subsetRing_le_otherRing hk (hf m)) h0
  E_mem := by
    rw [exchangeCoordinate, Finset.sum_mul]
    apply Subring.sum_mem
    intro l _
    rw [mul_assoc, ← s.toQuantumSeed.monomial_single,
      s.toQuantumSeed.monomial_mul_monomial]
    refine Subring.mul_mem _ (s.toQuantumSeed.algebraMap_mem_subsetRing _ _) ?_
    refine Subring.mul_mem _ (s.toQuantumSeed.algebraMap_mem_subsetRing _ _) ?_
    apply s.toQuantumSeed.monomial_mem_subsetRing
    intro a ha
    simp [exchangeExponent, exchangeExponentNeg, dividedColumn, hS a ha, positivePart]
  E_normalizes := (s.exchangeCoordinate_normalizes_subsetRing k hk).mul
    (s.toQuantumSeed.coordinate_normalizes_subsetRing S (row k))


theorem exchangeData_y (k : K) :
    s.exchangeCoordinate k * s.coordinate (row k) * (s.coordinate (row k) : D)⁻¹ =
      s.exchangeCoordinate k := mul_inv_cancel_right₀ (Units.ne_zero _) _

theorem commute_centralProduct_of_mem_subsetRing (k : K) {S : Set M}
    (hk : row k ∉ S) (r : ℕ) {c : D} (hc : c ∈ s.toQuantumSeed.subsetRing S) :
    Commute (s.centralProduct k r) c :=
  s.commute_centralProduct k r (s.toQuantumSeed.subsetRing_le_otherRing hk hc)


theorem mutate_otherRing [Fintype K] [DecidableEq K] (k : K) :
    (s.mutate k).toQuantumSeed.otherRing (row k) = s.toQuantumSeed.otherRing (row k) := by
  unfold QuantumSeed.otherRing OneExchange.otherCoordinateRing
  congr 1
  funext j
  dsimp only
  rw [s.mutate_coordinate_of_ne k j.2]

/-- **Q1, the ordered products.** The ordered products of the one-exchange are
`P_r = P_{k,r} M(-e_k + [-b_{•k}]_+) ^ r X_k ^ r`. -/
theorem orderedProduct_eq_centralProduct_mul (k : K) (r : ℕ) :
    SkewExchange.orderedProduct (s.coordinate (row k) : D)
        (s.exchangeCoordinate k * s.coordinate (row k)) r =
      s.centralProduct k r *
        (s.toQuantumSeed.monomial (exchangeExponentNeg row s.exchange.matrix k) ^ r *
          (s.coordinate (row k) : D) ^ r) := by
  have hx : (s.coordinate (row k) : D) ≠ 0 := Units.ne_zero _
  have hy := (s.exchangeData k).y_pow r
  rw [s.exchangeData_y, s.exchangeCoordinate_pow k] at hy
  rw [← mul_assoc, hy, mul_assoc, ← zpow_natCast, ← zpow_add₀ hx, neg_add_cancel, zpow_zero,
    mul_one]

/-- `P_{k,r} X_k^{-r} = (M(-e_k + [-b_{•k}]_+) ^ r X_k ^ r)⁻¹ (X'_k) ^ r`. -/
theorem centralProduct_mul_zpow_neg (k : K) (r : ℕ) :
    s.centralProduct k r * (s.coordinate (row k) : D) ^ (-(r : ℤ)) =
      (s.toQuantumSeed.monomial (exchangeExponentNeg row s.exchange.matrix k) ^ r *
        (s.coordinate (row k) : D) ^ r)⁻¹ * s.exchangeCoordinate k ^ r := by
  have hu := s.toQuantumSeed.monomial_pow_mul_coordinate_pow_mem k
    (s.toQuantumSeed.exchange_eq_zero_of_not_mem_ne k) r
  have hu0 : s.toQuantumSeed.monomial (exchangeExponentNeg row s.exchange.matrix k) ^ r *
      (s.coordinate (row k) : D) ^ r ≠ 0 :=
    mul_ne_zero (pow_ne_zero _ (s.toQuantumSeed.monomial_ne_zero _)) (pow_ne_zero _
      (Units.ne_zero _))
  have hy := (s.exchangeData k).y_pow r
  rw [s.exchangeData_y, s.orderedProduct_eq_centralProduct_mul k r] at hy
  set u := s.toQuantumSeed.monomial (exchangeExponentNeg row s.exchange.matrix k) ^ r *
    (s.coordinate (row k) : D) ^ r
  rw [hy, (s.commute_centralProduct k r hu).eq, mul_assoc u, inv_mul_cancel_left₀ hu0]

/-- Divisibility by the ordered product `P_r` in the ring of `S` is divisibility by the central
product `P_{k,r}`. -/
theorem exists_eq_mul_orderedProduct_iff (k : K) {S : Set M}
    (hk : row k ∉ S) (hS : ∀ l ∉ S, s.exchange.matrix l k = 0) (r : ℕ) (a : D) :
    (∃ c ∈ s.toQuantumSeed.subsetRing S, a = c * SkewExchange.orderedProduct
      (s.coordinate (row k) : D) (s.exchangeCoordinate k * s.coordinate (row k)) r) ↔
      ∃ c ∈ s.toQuantumSeed.subsetRing S, a = c * s.centralProduct k r := by
  have hw := s.toQuantumSeed.monomial_pow_mul_coordinate_pow_mem k hS r
  have hwi := s.toQuantumSeed.inv_monomial_pow_mul_coordinate_pow_mem k hS r
  have hw0 : s.toQuantumSeed.monomial (exchangeExponentNeg row s.exchange.matrix k) ^ r *
      (s.coordinate (row k) : D) ^ r ≠ 0 :=
    mul_ne_zero (pow_ne_zero _ (s.toQuantumSeed.monomial_ne_zero _)) (pow_ne_zero _
      (Units.ne_zero _))
  have hcomm := (s.commute_centralProduct_of_mem_subsetRing k hk r hw).eq
  rw [s.orderedProduct_eq_centralProduct_mul k r]
  set u := s.toQuantumSeed.monomial (exchangeExponentNeg row s.exchange.matrix k) ^ r *
    (s.coordinate (row k) : D) ^ r
  constructor
  · rintro ⟨c, hc, rfl⟩
    exact ⟨c * u, Subring.mul_mem _ hc hw, by rw [hcomm, mul_assoc c u]⟩
  · rintro ⟨c, hc, rfl⟩
    refine ⟨c * u⁻¹, Subring.mul_mem _ hc hwi, ?_⟩
    rw [hcomm, mul_assoc c u⁻¹, ← mul_assoc u⁻¹ u, inv_mul_cancel₀ hw0, one_mul]

/-- **Q1, the coefficient criterion over `C'`.** Let `C'` be the ring of a set `S` of coordinates
with `row k ∉ S` containing the support of `b_{•k}`. An element `f ∈ C'[X_k^{±1}]` lies in
`C'[X'^{±1}_k]` iff, expanding `f = ∑ c_m X_k ^ m` with left coefficients in `C'`,
`c_{-r} ∈ C' P_{k,r}` for every `r > 0`. -/
theorem mem_chartRing_exchangeCoordinate_iff (k : K) {S : Set M}
    (hk : row k ∉ S) (hS : ∀ l ∉ S, s.exchange.matrix l k = 0) {f : D}
    (hf : f ∈ Laurent.chartRing (s.toQuantumSeed.subsetRing S) (fun _ : Unit ↦ (s.coordinate
      (row k) : D))) :
    f ∈ Laurent.chartRing (s.toQuantumSeed.subsetRing S) (fun _ : Unit ↦ s.exchangeCoordinate k) ↔
      ∀ r : ℕ, 0 < r → ∃ c ∈ s.toQuantumSeed.subsetRing S,
        SkewExchange.coeff (s.toQuantumSeed.subsetRing S) (s.coordinate (row k) : D) f (-(r : ℤ)) =
          c * s.centralProduct k r := by
  rw [← s.exchangeData_y k, (s.exchangeData_subsetRing k hk hS).mem_chartRing_y_iff hf]
  exact forall₂_congr fun r _ ↦ s.exists_eq_mul_orderedProduct_iff k hk hS r _

/-- **Q1, the coefficient criterion over `C'`, intersection form.** For `c_m ∈ C'`,
`∑ c_m X_k ^ m ∈ C'[X_k^{±1}] ∩ C'[X'^{±1}_k]` iff `c_{-r} ∈ C' P_{k,r}` for every `r > 0`. -/
theorem expand_mem_inf_iff (k : K) {S : Set M} (hk : row k ∉ S)
    (hS : ∀ l ∉ S, s.exchange.matrix l k = 0) {g : ℤ →₀ D} (hg : ∀ m, g m ∈
      s.toQuantumSeed.subsetRing S) :
    SkewExchange.expand (s.coordinate (row k) : D) g ∈
        Laurent.chartRing (s.toQuantumSeed.subsetRing S) (fun _ : Unit ↦ (s.coordinate (row k)
          : D)) ⊓
          Laurent.chartRing (s.toQuantumSeed.subsetRing S) (fun _ : Unit ↦ s.exchangeCoordinate k) ↔
      ∀ r : ℕ, 0 < r → ∃ c ∈ s.toQuantumSeed.subsetRing S, g (-(r : ℤ)) = c * s.centralProduct
        k r := by
  have hE := s.exchangeData_subsetRing k hk hS
  have hf : SkewExchange.expand (s.coordinate (row k) : D) g ∈
      Laurent.chartRing (s.toQuantumSeed.subsetRing S) (fun _ : Unit ↦ (s.coordinate (row k) :
        D)) :=
    (SkewExchange.mem_chartRing_iff hE.x_normalizes).2 ⟨g, hg, rfl⟩
  rw [Subring.mem_inf, and_iff_right hf, s.mem_chartRing_exchangeCoordinate_iff k hk hS hf,
    SkewExchange.coeff_expand hE.x_leftFree hg]

/-- **Q1, the coefficient criterion with central factors.** An element `f` of the chart ring of
`s` lies in the chart ring of `μ_k(s)` iff, expanding `f = ∑ c_m X_k ^ m` with left coefficients in
the ring `C` of the other coordinates, `c_{-r} ∈ C P_{k,r}` for every `r > 0`. -/
theorem mem_mutate_chartRing_iff [Fintype K] [DecidableEq K] (k : K) {f : D}
    (hf : f ∈ s.toQuantumSeed.chartRing) :
    f ∈ (s.mutate k).toQuantumSeed.chartRing ↔ ∀ r : ℕ, 0 < r → ∃ c ∈ s.toQuantumSeed.otherRing
      (row k),
      SkewExchange.coeff (s.toQuantumSeed.otherRing (row k)) (s.coordinate (row k) : D) f (-(r
        : ℤ)) =
        c * s.centralProduct k r := by
  rw [s.toQuantumSeed.chartRing_eq_regroup (row k)] at hf
  rw [(s.mutate k).toQuantumSeed.chartRing_eq_regroup (row k), s.mutate_otherRing,
    mutate_coordinate_row]
  exact s.mem_chartRing_exchangeCoordinate_iff k (S := {l | l ≠ row k}) (by simp)
    (s.toQuantumSeed.exchange_eq_zero_of_not_mem_ne k) hf


/-- The exchange polynomial after scaling its variable by `v^n`. -/
def shiftedPolynomial (k : K) (n : ℤ) : Polynomial Zv :=
  (s.polynomial k).comp (Polynomial.C ((vUnit ^ n : Zvˣ) : Zv) * Polynomial.X)

theorem aeval_shiftedPolynomial (k : K) (n : ℤ) :
    Polynomial.aeval (s.toQuantumSeed.monomial (s.dividedColumn k))
        (s.shiftedPolynomial k n) = s.polynomialFactor k n := by
  simp [shiftedPolynomial, polynomialFactor, Polynomial.aeval_def, Polynomial.eval₂_comp']

/-- The ordinary scalar polynomial whose evaluation is the central exchange product. -/
def centralPolynomial (k : K) (r : ℕ) : Polynomial Zv :=
  ((List.range r).map fun h : ℕ ↦
    s.shiftedPolynomial k ((2 * (h : ℤ) + 1) * s.columnWeight k)).prod

theorem centralPolynomial_coeff_zero (k : K) (r : ℕ) :
    (s.centralPolynomial k r).coeff 0 = 1 := by
  have hp : ∀ n, (s.shiftedPolynomial k n).eval 0 = 1 := by
    intro n
    rw [shiftedPolynomial, Polynomial.eval_comp, Polynomial.eval_mul, Polynomial.eval_C,
      Polynomial.eval_X, mul_zero, ← Polynomial.coeff_zero_eq_eval_zero, s.constant_one]
  rw [Polynomial.coeff_zero_eq_eval_zero, centralPolynomial, Polynomial.eval_list_prod,
    List.map_map]
  simp only [Function.comp_def, hp, List.map_const', List.prod_replicate, one_pow]

theorem aeval_centralPolynomial (k : K) (r : ℕ) :
    Polynomial.aeval (s.toQuantumSeed.monomial (s.dividedColumn k))
        (s.centralPolynomial k r) = s.centralProduct k r := by
  rw [centralPolynomial, map_list_prod, List.map_map, centralProduct]
  congr 1
  exact List.map_congr_left fun _ _ ↦ s.aeval_shiftedPolynomial _ _

end
end TauCeti.Cluster.PolynomialQuantumSeed
