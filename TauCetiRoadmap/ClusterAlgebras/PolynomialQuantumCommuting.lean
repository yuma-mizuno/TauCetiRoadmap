/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.PolynomialQuantumInteracting
public import TauCetiRoadmap.ClusterAlgebras.PolynomialQuantumCentralFactors
public import TauCetiRoadmap.ClusterAlgebras.QuantumPairChart
public import TauCetiRoadmap.LaurentPhenomenon.Quantum.PolynomialDivisibility

/-!
# The commuting two-direction intersection for polynomial quantum seeds

Polynomial central divisibility supplies simultaneous negative coefficient
conditions. The remaining reconstruction uses the shared skew Laurent normal form.
-/

@[expose] public section

namespace TauCeti.Cluster.PolynomialExchangeSeed

open TauCeti TauCeti.QuantumTorus TauCeti.Laurent

noncomputable section

variable {R₀ : Type*} [CommRing R₀] {u₀ : R₀ˣ}
  {D : Type*} [DivisionRing D] [Algebra R₀ D]
  {M K : Type*} [Fintype M] [DecidableEq M] {row : K ↪ M}
  (s : PolynomialExchangeSeed (u₀ := u₀) D row)

private theorem exchange_row_eq_zero {i j : K}
    (hb : s.exchange.matrix (row j) i = 0) : s.exchange.matrix (row i) j = 0 := by
  have h := s.exchange.symmetrized i j
  rw [hb, mul_zero, neg_zero] at h
  exact (mul_eq_zero.1 h).resolve_left (s.exchange.symmetrizer_pos i).ne'

private theorem pairTorusChart_aeval (a b : M) (p : ExchangeFrame.pairLattice a b)
    (q : Polynomial R₀) :
    s.toExchangeFrame.pairTorusChart a b (Polynomial.aeval (QuantumTorus.monomial p) q) =
      Polynomial.aeval (s.toExchangeFrame.monomial p) q := by
  rw [← Polynomial.aeval_algHom_apply, s.toExchangeFrame.pairTorusChart_monomial]

/-- Independent divided columns give simultaneous divisibility of exchange products. -/
theorem exists_eq_mul_centralProduct_mul [IsDomain R₀] [UniqueFactorizationMonoid R₀]
    {i j : K} (hij : i ≠ j)
    (hb : s.exchange.matrix (row j) i = 0) {c a b : D}
    (ha : a ∈ s.toExchangeFrame.pairRing (row i) (row j))
    (hb₂ : b ∈ s.toExchangeFrame.pairRing (row i) (row j)) (t r : ℕ)
    (hca : c = a * s.centralProduct i t) (hcb : c = b * s.centralProduct j r) :
    ∃ e ∈ s.toExchangeFrame.pairRing (row i) (row j),
      c = e * (s.centralProduct i t * s.centralProduct j r) := by
  have hji : row j ≠ row i := row.injective.ne hij.symm
  have hb' := s.exchange_row_eq_zero hb
  let p : ExchangeFrame.pairLattice (row i) (row j) :=
    ⟨s.dividedColumn i, s.dividedColumn_row i, by simp [dividedColumn, hb]⟩
  let q : ExchangeFrame.pairLattice (row i) (row j) :=
    ⟨s.dividedColumn j, by simp [dividedColumn, hb'], s.dividedColumn_row j⟩
  have hΛ : LinearMap.IsAlt (s.toExchangeFrame.pairTorusForm (row i) (row j)) :=
    fun x ↦ s.alternating.matrixForm_self x.1
  have hp : ∀ x, s.toExchangeFrame.pairTorusForm (row i) (row j) p x = 0 := fun x ↦ by
    change matrixForm s.form (s.dividedColumn i) x.1 = 0
    rw [s.matrixForm_dividedColumn, x.2.1, mul_zero]
  have hq : ∀ x, s.toExchangeFrame.pairTorusForm (row i) (row j) q x = 0 := fun x ↦ by
    change matrixForm s.form (s.dividedColumn j) x.1 = 0
    rw [s.matrixForm_dividedColumn, x.2.2, mul_zero]
  have hpq : ∀ m n : ℤ, m • p + n • q = 0 → m = 0 ∧ n = 0 := by
    intro m n h
    have hinj : Function.Injective (fun a : Fin 2 ↦ ![i, j] a) := by
      intro a b hab
      fin_cases a <;> fin_cases b <;> simp_all
    have hpair : LinearIndependent ℚ
        ![(fun a ↦ (s.dividedColumn i a : ℚ)), (fun a ↦ (s.dividedColumn j a : ℚ))] := by
      convert s.independent_dividedColumns.comp (fun a : Fin 2 ↦ ![i, j] a) hinj using 1
      ext a b
      fin_cases a <;> rfl
    have hbase := congrArg (fun x : ExchangeFrame.pairLattice (row i) (row j) ↦ (x : M → ℤ)) h
    have hq : (m : ℚ) • (fun a ↦ (s.dividedColumn i a : ℚ)) +
        (n : ℚ) • (fun a ↦ (s.dividedColumn j a : ℚ)) = 0 := by
      ext a
      change (m : ℚ) * (s.dividedColumn i a : ℚ) +
        (n : ℚ) * (s.dividedColumn j a : ℚ) = 0
      have ha := congrFun hbase a
      change m * s.dividedColumn i a + n * s.dividedColumn j a = 0 at ha
      exact_mod_cast ha
    exact_mod_cast (LinearIndependent.pair_iff.mp hpair (m : ℚ) (n : ℚ) hq)
  obtain ⟨a', rfl⟩ := s.toExchangeFrame.exists_pairTorusChart_eq _ _ ha
  obtain ⟨b', rfl⟩ := s.toExchangeFrame.exists_pairTorusChart_eq _ _ hb₂
  have hP := (s.pairTorusChart_aeval (row i) (row j) p (s.centralPolynomial i t)).trans
    (s.aeval_centralPolynomial i t)
  have hQ := (s.pairTorusChart_aeval (row i) (row j) q (s.centralPolynomial j r)).trans
    (s.aeval_centralPolynomial j r)
  rw [← hP, ← map_mul] at hca
  rw [← hQ, ← map_mul, hca] at hcb
  obtain ⟨g, hg⟩ := exists_eq_mul_aeval_mul_aeval hΛ hpq hp hq
    (s.centralPolynomial_coeff_zero i t) (s.centralPolynomial_coeff_zero j r)
    ⟨a', rfl⟩ ⟨b', s.toExchangeFrame.pairTorusChart_injective _ _ hcb⟩
  refine ⟨s.toExchangeFrame.pairTorusChart _ _ g,
    s.toExchangeFrame.pairTorusChart_mem_pairRing _ _ g, ?_⟩
  rw [hca, hg, map_mul, map_mul, hP, hQ]

/-! ### Divisibility of the `y`-coefficients -/

/-- `C⟨X_i, X'_i⟩` for `C = pairRing (row i) (row j)`. -/
private def halfRing (i j : K) : Subring D :=
  TauCeti.Laurent.generated (s.toExchangeFrame.pairRing (row i) (row j))
    {(s.coordinate (row i) : D), s.exchangeCoordinate i}

private theorem halfRing_eq (i j : K) :
    s.halfRing i j = Subring.closure ((s.toExchangeFrame.pairRing (row i) (row j) : Set D) ∪
      {(s.coordinate (row i) : D),
        s.exchangeCoordinate i * s.coordinate (row i) * (s.coordinate (row i) : D)⁻¹}) := by
  rw [s.exchangeData_y]
  rfl

private theorem pairRing_le_halfRing (i j : K) : s.toExchangeFrame.pairRing (row i) (row j) ≤
  s.halfRing i j :=
  fun _ h ↦ TauCeti.Laurent.coefficient_mem_generated _ _ h

private theorem coordinate_mem_halfRing (i j : K) : (s.coordinate (row i) : D) ∈ s.halfRing i j :=
  TauCeti.Laurent.generator_mem_generated _ _ (by simp)

private theorem exchangeCoordinate_mem_halfRing (i j : K) :
    s.exchangeCoordinate i ∈ s.halfRing i j :=
  TauCeti.Laurent.generator_mem_generated _ _ (by simp)

private theorem halfRing_le_fourRing (i j : K) : s.halfRing i j ≤ s.fourRing i j :=
  TauCeti.Laurent.generated_mono _ fun g hg ↦ by rcases hg with rfl | rfl <;> simp

private theorem halfRing_le_otherRing {i j : K} (hij : i ≠ j)
    (hb : s.exchange.matrix (row j) i = 0) : s.halfRing i j ≤ s.toExchangeFrame.otherRing (row j)
      := by
  have hij' : row i ≠ row j := row.injective.ne hij
  refine TauCeti.Laurent.generated_le _ _ _ (fun c hc ↦ ?_) ?_
  · rw [s.toExchangeFrame.pairRing_comm] at hc
    exact s.toExchangeFrame.pairRing_le_otherRing hij' hc
  · rintro g (rfl | rfl)
    · exact coordinate_mem_chartRing _ (fun l : {l // l ≠ row j} ↦ (s.coordinate l : D))
        ⟨row i, hij'⟩
    · rw [exchangeCoordinate]
      apply Subring.sum_mem
      intro l _
      refine Subring.mul_mem _ (s.toExchangeFrame.algebraMap_mem_otherRing _ _) ?_
      apply s.toExchangeFrame.monomial_mem_otherRing
      simp [exchangeExponent, exchangeExponentNeg, dividedColumn, hij', hb, positivePart]

/-- `y = X_j` normalizes `C⟨X_i, X'_i⟩`. -/
private theorem coordinate_normalizes_halfRing {i j : K} (hij : i ≠ j) :
    Normalizes (s.halfRing i j) (s.coordinate (row j) : D) := by
  have hji : row j ≠ row i := row.injective.ne hij.symm
  refine normalizes_closure (s.toExchangeFrame.coordinate_normalizes_pairRing _ _ _)
    (s.toExchangeFrame.algebraMap_mem_pairRing _ _) ?_
  rintro g (rfl | rfl)
  · exact ⟨_, by rw [s.quasiCommuting, Algebra.smul_def]⟩
  · exact ⟨_, s.coordinate_mul_exchangeCoordinate i hji⟩

/-- **Divisibility of a coefficient.** If `b_{row j, i} = 0`, an element `h ∈ C⟨X_i, X'_i⟩` that
is divisible on the right by `P_{j,r}` in `C[X_i^{±1}]` is divisible by it in `C⟨X_i, X'_i⟩`. -/
private theorem exists_eq_mul_centralProduct_of_mem_halfRing
    [IsDomain R₀] [UniqueFactorizationMonoid R₀] {i j : K}
    (hij : i ≠ j) (hb : s.exchange.matrix (row j) i = 0) {h a : D} (hh : h ∈ s.halfRing i j)
    (ha : a ∈ s.toExchangeFrame.otherRing (row j)) (r : ℕ) (hr : h = a * s.centralProduct j r) :
    ∃ e ∈ s.halfRing i j, h = e * s.centralProduct j r := by
  classical
  have hij' : row i ≠ row j := row.injective.ne hij
  have hb' := s.exchange_row_eq_zero hb
  have hSi := s.toExchangeFrame.exchange_eq_zero_of_not_mem_pair hb
  have hSj : ∀ l ∉ {l | l ≠ row i ∧ l ≠ row j}, s.exchange.matrix l j = 0 := by
    intro l hl
    simp only [Set.mem_ofPred_eq, not_and_or, not_not] at hl
    rcases hl with rfl | rfl
    · exact hb'
    · exact s.exchange.diagonal j
  have hki : row i ∉ {l | l ≠ row i ∧ l ≠ row j} := by simp
  have hCi : SkewExchange.ExchangeData (s.toExchangeFrame.pairRing (row i) (row j)) (s.coordinate
    (row i) : D)
      (s.exchangeCoordinate i * s.coordinate (row i)) :=
    s.exchangeData_subsetRing i hki hSi
  set x : D := (s.coordinate (row i) : D) with hx
  set P := s.centralProduct j r with hP
  have hPC : P ∈ s.toExchangeFrame.pairRing (row i) (row j) := s.centralProduct_mem_subsetRing j
    hSj r
  have hCH := s.pairRing_le_halfRing i j
  have hxj : x ∈ s.toExchangeFrame.otherRing (row j) :=
    coordinate_mem_chartRing _ (fun l : {l // l ≠ row j} ↦ (s.coordinate l : D)) ⟨row i, hij'⟩
  have hPx : ∀ m : ℤ, Commute P (x ^ m) := fun m ↦
    (s.commute_centralProduct j r hxj).zpow_right₀ m
  have hhx : h ∈ Laurent.chartRing (s.toExchangeFrame.pairRing (row i) (row j)) (fun _ : Unit ↦
    x) :=
    hCi.closure_le_chartRing_x (s.halfRing_eq i j ▸ hh)
  have hhy : h ∈ Laurent.chartRing (s.toExchangeFrame.pairRing (row i) (row j))
      (fun _ : Unit ↦ s.exchangeCoordinate i) := by
    rw [← s.exchangeData_y i]
    exact hCi.closure_le_chartRing_y (s.halfRing_eq i j ▸ hh)
  -- Q1 for `i` over `C`: the negative `x`-coefficients of `h` lie in `C P_{i,t}`
  have hcrit : ∀ t : ℕ, 0 < t → ∃ b ∈ s.toExchangeFrame.pairRing (row i) (row j),
      SkewExchange.coeff (s.toExchangeFrame.pairRing (row i) (row j)) x h (-(t : ℤ)) = b *
        s.centralProduct i t :=
    (s.mem_chartRing_exchangeCoordinate_iff i hki hSi hhx).1 hhy
  -- every `x`-coefficient of `h` lies in `C P_{j,r}`
  have hc1 : ∀ m, ∃ a' ∈ s.toExchangeFrame.pairRing (row i) (row j),
      SkewExchange.coeff (s.toExchangeFrame.pairRing (row i) (row j)) x h m = a' * P := by
    rw [s.toExchangeFrame.otherRing_eq_regroup hij', s.toExchangeFrame.pairRing_comm] at ha
    set g := SkewExchange.coeff (s.toExchangeFrame.pairRing (row i) (row j)) x a
    have hexp : h = ∑ m ∈ g.support, (g m * P) * x ^ m := by
      rw [hr, ← SkewExchange.expand_coeff hCi.x_normalizes ha, SkewExchange.expand_eq_sum,
        Finset.sum_mul]
      refine Finset.sum_congr rfl fun m _ ↦ ?_
      rw [mul_assoc (g m), mul_assoc (g m), (hPx m).eq]
    intro m
    refine ⟨g m, SkewExchange.coeff_mem _ x a m, ?_⟩
    rw [hexp, SkewExchange.coeff_sum_monomial hCi.x_leftFree]
    · exact SkewExchange.sum_ite_eq_apply g (fun m ↦ g m * P) (fun m hm ↦ by simp [hm]) m
    · exact fun m _ ↦ Subring.mul_mem _ (SkewExchange.coeff_mem _ x a m) hPC
  rw [← SkewExchange.expand_coeff hCi.x_normalizes hhx, SkewExchange.expand_eq_sum]
  refine Finset.sum_induction _ (fun t ↦ ∃ e ∈ s.halfRing i j, t = e * P)
    (fun _ _ ⟨e₁, he₁, h₁⟩ ⟨e₂, he₂, h₂⟩ ↦ ⟨e₁ + e₂, add_mem he₁ he₂, by rw [h₁, h₂, add_mul]⟩)
    ⟨0, zero_mem _, (zero_mul _).symm⟩ fun m _ ↦ ?_
  obtain ⟨a', ha'C, ha'⟩ := hc1 m
  rcases le_or_gt 0 m with hm | hm
  · refine ⟨a' * x ^ m, mul_mem (hCH ha'C) ?_, ?_⟩
    · lift m to ℕ using hm
      rw [zpow_natCast]
      exact pow_mem (s.coordinate_mem_halfRing i j) m
    · rw [ha', mul_assoc a', mul_assoc a', (hPx m).eq]
  · obtain ⟨t, rfl⟩ : ∃ t : ℕ, m = -(t : ℤ) := ⟨(-m).toNat, by omega⟩
    obtain ⟨b, hbC, hb₂⟩ := hcrit t (by omega)
    obtain ⟨e, heC, he⟩ := s.exists_eq_mul_centralProduct_mul hij hb hbC ha'C t r hb₂ ha'
    have hui : (s.toExchangeFrame.monomial (exchangeExponentNeg row s.exchange.matrix i) ^ t *
        (s.coordinate (row i) : D) ^ t)⁻¹ ∈ s.toExchangeFrame.pairRing (row i) (row j) :=
      s.toExchangeFrame.inv_monomial_pow_mul_coordinate_pow_mem i hSi t
    refine ⟨e * ((s.toExchangeFrame.monomial (exchangeExponentNeg row s.exchange.matrix i) ^ t *
        (s.coordinate (row i) : D) ^ t)⁻¹ * s.exchangeCoordinate i ^ t),
      mul_mem (hCH heC) (mul_mem (hCH hui) (pow_mem (s.exchangeCoordinate_mem_halfRing i j) t)),
      ?_⟩
    rw [he]
    simp only [mul_assoc]
    rw [(hPx _).eq, ← mul_assoc (s.centralProduct i t), s.centralProduct_mul_zpow_neg i t]
    simp only [mul_assoc]

/-! ### The commuting case of Q2 -/

variable [Fintype K] [DecidableEq K]

private theorem inf_mutate_le_chartRing_halfRing {i j : K} (hij : i ≠ j) :
    s.toExchangeFrame.chartRing ⊓ (s.mutate i).toExchangeFrame.chartRing ≤
      Laurent.chartRing (s.halfRing i j) (fun _ : Unit ↦ (s.coordinate (row j) : D)) := by
  rw [s.inf_mutate_eq_closure_pair hij]
  refine TauCeti.Laurent.generated_le _ _ _
    (fun c hc ↦ coefficient_mem_chartRing _ _ (s.pairRing_le_halfRing i j hc)) ?_
  rintro g (rfl | rfl | rfl | rfl)
  · exact coordinate_mem_chartRing _ (fun _ : Unit ↦ (s.coordinate (row j) : D)) ()
  · exact inverse_mem_chartRing _ (fun _ : Unit ↦ (s.coordinate (row j) : D)) ()
  · exact coefficient_mem_chartRing _ _ (s.coordinate_mem_halfRing i j)
  · exact coefficient_mem_chartRing _ _ (s.exchangeCoordinate_mem_halfRing i j)

private theorem inf_inf_le_fourRing [IsDomain R₀] [UniqueFactorizationMonoid R₀]
    {i j : K} (hij : i ≠ j)
    (hb : s.exchange.matrix (row j) i = 0) :
    (s.toExchangeFrame.chartRing ⊓ (s.mutate i).toExchangeFrame.chartRing) ⊓
      (s.toExchangeFrame.chartRing ⊓ (s.mutate j).toExchangeFrame.chartRing) ≤
      s.fourRing i j := by
  classical
  intro f hf
  obtain ⟨hfi, hfj⟩ := Subring.mem_inf.1 hf
  set y : D := (s.coordinate (row j) : D) with hy
  have hb' := s.exchange_row_eq_zero hb
  have hSj : ∀ l ∉ {l | l ≠ row i ∧ l ≠ row j}, s.exchange.matrix l j = 0 := by
    intro l hl
    simp only [Set.mem_ofPred_eq, not_and_or, not_not] at hl
    rcases hl with rfl | rfl
    · exact hb'
    · exact s.exchange.diagonal j
  have hyN := s.coordinate_normalizes_halfRing hij
  have hfA := s.inf_mutate_le_chartRing_halfRing hij hfi
  have hHA := s.halfRing_le_otherRing hij hb
  have hcoeff : SkewExchange.coeff (s.toExchangeFrame.otherRing (row j)) y f =
      SkewExchange.coeff (s.halfRing i j) y f := by
    conv_lhs => rw [← SkewExchange.expand_coeff hyN hfA]
    exact SkewExchange.coeff_expand (s.toExchangeFrame.leftFree_coordinate (row j))
      (fun m ↦ hHA (SkewExchange.coeff_mem _ _ _ m))
  have hHF := s.halfRing_le_fourRing i j
  have hCF : s.toExchangeFrame.pairRing (row i) (row j) ≤ s.fourRing i j :=
    fun _ hc ↦ TauCeti.Laurent.coefficient_mem_fourRing _ _ _ _ _ hc
  have hX'F : s.exchangeCoordinate j ∈ s.fourRing i j := TauCeti.Laurent.ys_mem_fourRing _ _ _ _ _
  have hyF : y ∈ s.fourRing i j := TauCeti.Laurent.y_mem_fourRing _ _ _ _ _
  rw [← SkewExchange.expand_coeff hyN hfA, SkewExchange.expand_eq_sum]
  refine Subring.sum_mem _ fun n _ ↦ ?_
  rcases le_or_gt 0 n with hn | hn
  · lift n to ℕ using hn
    rw [zpow_natCast]
    exact mul_mem (hHF (SkewExchange.coeff_mem _ _ _ _)) (pow_mem hyF n)
  · obtain ⟨r, rfl⟩ : ∃ r : ℕ, n = -(r : ℤ) := ⟨(-n).toNat, by omega⟩
    -- Q1 for `j`: the coefficient at `y^{-r}` lies in `T_s P_{j,r}`
    obtain ⟨a, ha, hae⟩ := (s.mem_mutate_chartRing_iff j (Subring.mem_inf.1 hfj).1).1
      (Subring.mem_inf.1 hfj).2 r (by omega)
    rw [hcoeff] at hae
    obtain ⟨e, he, hee⟩ := s.exists_eq_mul_centralProduct_of_mem_halfRing hij hb
      (SkewExchange.coeff_mem _ _ _ _) ha r hae
    have hui : (s.toExchangeFrame.monomial (exchangeExponentNeg row s.exchange.matrix j) ^ r *
        (s.coordinate (row j) : D) ^ r)⁻¹ ∈ s.toExchangeFrame.pairRing (row i) (row j) :=
      s.toExchangeFrame.inv_monomial_pow_mul_coordinate_pow_mem j hSj r
    rw [hee, mul_assoc, s.centralProduct_mul_zpow_neg j r]
    exact mul_mem (hHF he) (mul_mem (hCF hui) (pow_mem hX'F r))

/-- **Q2, commuting case.** If `b_{row j, i} = 0` (hence `b_{row i, j} = 0`), then
`(T_s ∩ T_{μ_i(s)}) ∩ (T_s ∩ T_{μ_j(s)}) = C⟨X_i, X'_i, X_j, X'_j⟩`. -/
theorem inf_mutate_inf_inf_mutate_eq_fourRing_of_eq_zero
    [IsDomain R₀] [UniqueFactorizationMonoid R₀] {i j : K}
    (hij : i ≠ j) (hb : s.exchange.matrix (row j) i = 0) :
    (s.toExchangeFrame.chartRing ⊓ (s.mutate i).toExchangeFrame.chartRing) ⊓
      (s.toExchangeFrame.chartRing ⊓ (s.mutate j).toExchangeFrame.chartRing) =
      s.fourRing i j :=
  le_antisymm (s.inf_inf_le_fourRing hij hb)
    (le_inf (s.fourRing_le_inf_mutate hij)
      (s.fourRing_comm i j ▸ s.fourRing_le_inf_mutate hij.symm))

end
end TauCeti.Cluster.PolynomialExchangeSeed
