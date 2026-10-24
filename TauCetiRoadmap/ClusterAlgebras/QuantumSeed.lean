/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.Quantum.ChangeChart
public import TauCetiRoadmap.LaurentPhenomenon.SkewExchange
public import TauCetiRoadmap.LaurentPhenomenon.OneExchangeChart
public import TauCetiRoadmap.ClusterAlgebras.QuantumCompatible
public import TauCetiRoadmap.ClusterAlgebras.GeometricSeed
public import TauCetiRoadmap.ClusterAlgebras.UpperBound

/-!
# Quantum seeds and their mutation

A quantum seed in a division ring `D` over `Zv = ℤ[v,v⁻¹]` is a compatible pair `(B_ext, Λ)`, where
`B_ext` carries its positive symmetrizer (`ExtendedExchangeMatrix`), together with quasi-commuting
units `X_i` whose normalized monomials `M(a)` are `Zv`-linearly independent, i.e. a faithful chart
`T(Zv,v,Λ) → D`.
Mutation at `k` replaces `X_k` by `X'_k = M(-e_k + [b_{•k}]_+) + M(-e_k + [-b_{•k}]_+)`, `B_ext` by
matrix mutation and `Λ` by `E_εᵀ Λ E_ε`. We prove that the new tuple quasi-commutes for the
mutated form and that the new chart is faithful (from the one-exchange data of
`TauCeti.Laurent.SkewExchange`, without leading terms), and that mutation is involutive.
As a corollary the two-chart intersection is `C⟨X_k, X'_k⟩` (Q1), and the upper-bound API of
`UpperBound.lean` applies to quantum seeds; its hypotheses are stated at the seeds reachable from
`s` (`QuantumSeed.Reachable`).
-/

@[expose] public section

namespace TauCeti.Cluster

open TauCeti TauCeti.QuantumTorus TauCeti.Laurent Matrix

theorem IsAlternatingMatrix.isAlt {M : Type*} [Fintype M] [DecidableEq M]
    {Λ : Matrix M M ℤ} (hΛ : IsAlternatingMatrix Λ) : LinearMap.IsAlt (matrixForm Λ) :=
  hΛ.matrixForm_self

section Vectors

variable {M K : Type*} [DecidableEq M] (row : K ↪ M) (B : Matrix M K ℤ) (k : K)

/-- The exponent `-e_k + [b_{•k}]_+` of the first exchange summand. -/
def exchangeExponentPos : M → ℤ := -(Pi.single (row k) 1) + fun i => positivePart (B i k)
/-- The exponent `-e_k + [-b_{•k}]_+` of the second exchange summand. -/
def exchangeExponentNeg : M → ℤ := -(Pi.single (row k) 1) + fun i => positivePart (-B i k)
theorem exchangeExponentPos_eq_neg_add :
    exchangeExponentPos row B k = exchangeExponentNeg row B k + fun i => B i k := by
  funext i
  have := positivePart_sub_positivePart_neg (B i k)
  simp only [exchangeExponentPos, exchangeExponentNeg, Pi.add_apply, Pi.neg_apply]
  omega

theorem single_add_exchangeExponentPos :
    Pi.single (row k) 1 + exchangeExponentPos row B k = fun i => positivePart (B i k) := by
  rw [exchangeExponentPos, add_neg_cancel_left]

theorem single_add_exchangeExponentNeg :
    Pi.single (row k) 1 + exchangeExponentNeg row B k = fun i => positivePart (-B i k) := by
  rw [exchangeExponentNeg, add_neg_cancel_left]

theorem exchangeExponentPos_mutation [Finite K] [Finite M] [DecidableEq K] :
    exchangeExponentPos row (extendedMatrixMutation row B k) k = exchangeExponentNeg row B k := by
  let : Fintype K := Fintype.ofFinite K
  let : Fintype M := Fintype.ofFinite M
  funext i
  simp [exchangeExponentPos, exchangeExponentNeg, extendedMatrixMutation]

theorem exchangeExponentNeg_mutation [Finite K] [Finite M] [DecidableEq K] :
    exchangeExponentNeg row (extendedMatrixMutation row B k) k = exchangeExponentPos row B k := by
  let : Fintype K := Fintype.ofFinite K
  let : Fintype M := Fintype.ofFinite M
  funext i
  simp [exchangeExponentPos, exchangeExponentNeg, extendedMatrixMutation]

variable {row B k}

theorem exchangeExponentPos_row (hdiag : B (row k) k = 0) :
    exchangeExponentPos row B k (row k) = -1 := by
  simp [exchangeExponentPos, hdiag, positivePart]

theorem exchangeExponentNeg_row (hdiag : B (row k) k = 0) :
    exchangeExponentNeg row B k (row k) = -1 := by
  simp [exchangeExponentNeg, hdiag, positivePart]

variable [Fintype M]

theorem IsCompatiblePair.matrixForm_exchangeExponentPos_eq_neg {Λ : Matrix M M ℤ}
    {E : ExtendedExchangeMatrix row} (hc : IsCompatiblePair E Λ) {j : M} (hj : j ≠ row k) :
    matrixForm Λ (exchangeExponentPos row E.matrix k) (Pi.single j 1) =
      matrixForm Λ (exchangeExponentNeg row E.matrix k) (Pi.single j 1) :=
  hc.matrixForm_exchange_pos_eq_neg hj

theorem mutationLeft_mulVec_of_apply_eq_zero (ε : ℤ) {a : M → ℤ} (ha : a (row k) = 0) :
    mutationLeft row B k ε *ᵥ a = a := by
  funext i
  rw [mutationLeft_mulVec_apply]
  split_ifs with hi
  · subst hi
    rw [ha, neg_zero]
  · rw [ha, mul_zero, add_zero]

/-- The mutated form agrees with `Λ` on vectors with vanishing `row k` coordinate. -/
theorem formMutation_matrixForm_of_apply_eq_zero (Λ : Matrix M M ℤ) (ε : ℤ) {a b : M → ℤ}
    (ha : a (row k) = 0) (hb : b (row k) = 0) :
    matrixForm (formMutation row B Λ k ε) a b = matrixForm Λ a b := by
  rw [formMutation_matrixForm, mutationLeft_mulVec_of_apply_eq_zero ε ha,
    mutationLeft_mulVec_of_apply_eq_zero ε hb]

/-- The mutated form against an integer multiple of `e_k`. -/
theorem formMutation_matrixForm_zsmul_single (Λ : Matrix M M ℤ) (hdiag : B (row k) k = 0)
    {a : M → ℤ} (ha : a (row k) = 0) (n : ℤ) :
    matrixForm (formMutation row B Λ k 1) a (n • Pi.single (row k) 1) =
      n * matrixForm Λ a (exchangeExponentNeg row B k) := by
  rw [formMutation_matrixForm, mutationLeft_mulVec_of_apply_eq_zero 1 ha, mulVec_smul,
    mutationLeft_mulVec_single_row row B k hdiag, map_zsmul, smul_eq_mul]
  simp [exchangeExponentNeg]

end Vectors

variable {D : Type*} [DivisionRing D] [Algebra Zv D]
  {M K : Type*} [Fintype M] [DecidableEq M]

theorem algebraMap_units_inv (c : Zvˣ) :
    (algebraMap Zv D (c : Zv))⁻¹ = algebraMap Zv D ((c⁻¹ : Zvˣ) : Zv) :=
  inv_eq_of_mul_eq_one_right (by rw [← map_mul, Units.mul_inv, map_one])

variable (D) in
/-- A **quantum seed** in `D`: a compatible pair `(B_ext, Λ)` and quasi-commuting units `X_i`
whose chart `T(Zv,v,Λ) → D`, `X ^ a ↦ M(a)`, is injective. -/
structure QuantumSeed (row : K ↪ M) where
  /-- The extended exchange matrix `B_ext` with its symmetrizer. -/
  exchange : ExtendedExchangeMatrix row
  /-- The quasi-commutation form `Λ`. -/
  form : Matrix M M ℤ
  alternating : IsAlternatingMatrix form
  compatible : IsCompatiblePair exchange form
  /-- The cluster and frozen variables `X_i`. -/
  coordinate : M → Dˣ
  quasiCommuting : IsQuasiCommuting vUnit (matrixForm form) coordinate
  faithful : Function.Injective (QuantumTorus.lift alternating.isAlt coordinate
    quasiCommuting)

namespace QuantumSeed

noncomputable section

variable {row : K ↪ M} (s : QuantumSeed D row)

@[ext] theorem ext {s t : QuantumSeed D row} (h₁ : s.exchange = t.exchange)
    (h₂ : s.form = t.form) (h₃ : s.coordinate = t.coordinate) : s = t := by
  cases s
  cases t
  cases h₁
  cases h₂
  cases h₃
  rfl

theorem isAlt : LinearMap.IsAlt (matrixForm s.form) :=
  s.alternating.isAlt

/-- The chart `T(Zv,v,Λ) → D` of the seed, `X_i ↦ X_i`. -/
noncomputable def chart : quantumTorus Zv vUnit (matrixForm s.form) →ₐ[Zv] D :=
  QuantumTorus.lift s.isAlt s.coordinate s.quasiCommuting

theorem chart_injective : Function.Injective s.chart := s.faithful
/-- The normalized monomial `M(a)`, the image of `X ^ a` under the chart. -/
noncomputable def monomial (a : M → ℤ) : D := s.chart (QuantumTorus.monomial a)
/-- The integral quantum chart ring `Zv[X_i^{±1}]` of the seed. -/
def chartRing : Subring D :=
  Laurent.chartRing (algebraMap Zv D).range (fun i ↦ (s.coordinate i : D))

theorem range_chart : s.chart.range.toSubring = s.chartRing :=
  range_lift _ _

theorem linearIndependent_monomial : LinearIndependent Zv s.monomial :=
  (lift_injective_iff _ _).1 s.faithful

theorem monomial_mem_chartRing (a : M → ℤ) : s.monomial a ∈ s.chartRing := by
  rw [← range_chart]
  exact ⟨_, rfl⟩

theorem monomial_mul_monomial (a b : M → ℤ) :
    s.monomial a * s.monomial b =
      algebraMap Zv D ((vUnit ^ matrixForm s.form a b : Zvˣ) : Zv) * s.monomial (a + b) := by
  rw [monomial, monomial, ← map_mul, QuantumTorus.monomial_mul_monomial, map_smul,
    Algebra.smul_def]
  rfl

/-- Quasi-commutation of normalized monomials, `M(a) M(b) = v^{2Λ(a,b)} M(b) M(a)`. -/
theorem monomial_mul_monomial_comm (a b : M → ℤ) :
    s.monomial a * s.monomial b =
      algebraMap Zv D ((vUnit ^ (2 * matrixForm s.form a b) : Zvˣ) : Zv) *
        (s.monomial b * s.monomial a) := by
  rw [monomial, monomial, ← map_mul, ← map_mul, QuantumTorus.monomial_mul_monomial_comm
    s.isAlt, map_smul, Algebra.smul_def]

@[simp] theorem monomial_zero : s.monomial 0 = 1 := by
  simp [monomial]

@[simp] theorem monomial_single (i : M) : s.monomial (Pi.single i 1) = s.coordinate i :=
  lift_monomial_single _ _ i

theorem monomial_neg_single (i : M) :
    s.monomial (-Pi.single i 1) = (s.coordinate i : D)⁻¹ := by
  rw [monomial, chart, lift_monomial_neg_single, Units.val_inv_eq_inv_val]

theorem monomial_zsmul_single (i : M) (n : ℤ) :
    s.monomial (n • Pi.single i 1) = (s.coordinate i : D) ^ n := by
  rw [monomial, chart, lift_monomial_zsmul_single, Units.val_zpow_eq_zpow_val]

theorem monomial_mul_monomial_neg (a : M → ℤ) : s.monomial a * s.monomial (-a) = 1 := by
  rw [monomial, monomial, ← map_mul, QuantumTorus.monomial_mul_monomial_neg s.isAlt,
    map_one]

theorem monomial_ne_zero (a : M → ℤ) : s.monomial a ≠ 0 :=
  left_ne_zero_of_mul_eq_one (s.monomial_mul_monomial_neg a)

theorem isUnit_monomial (a : M → ℤ) : IsUnit (s.monomial a) :=
  isUnit_iff_ne_zero.2 (s.monomial_ne_zero a)

theorem monomial_inv (a : M → ℤ) : (s.monomial a)⁻¹ = s.monomial (-a) :=
  inv_eq_of_mul_eq_one_right (s.monomial_mul_monomial_neg a)

/-- `M(a) X_j = v^{2Λ(a,e_j)} X_j M(a)`. -/
theorem monomial_mul_coordinate (a : M → ℤ) (j : M) :
    s.monomial a * s.coordinate j =
      algebraMap Zv D ((vUnit ^ (2 * matrixForm s.form a (Pi.single j 1)) : Zvˣ) : Zv) *
        (s.coordinate j * s.monomial a) := by
  rw [← s.monomial_single j, monomial_mul_monomial_comm]

/-- `X_j M(a) = v^{2Λ(e_j,a)} M(a) X_j`. -/
theorem coordinate_mul_monomial (a : M → ℤ) (j : M) :
    s.coordinate j * s.monomial a =
      algebraMap Zv D ((vUnit ^ (2 * matrixForm s.form (Pi.single j 1) a) : Zvˣ) : Zv) *
        (s.monomial a * s.coordinate j) := by
  rw [← s.monomial_single j, monomial_mul_monomial_comm]

/-! ### The exchanged coordinate -/

/-- The exchanged coordinate `X'_k = M(-e_k + [b_{•k}]_+) + M(-e_k + [-b_{•k}]_+)`. -/
noncomputable def exchangeCoordinate (k : K) : D :=
  s.monomial (exchangeExponentPos row s.exchange.matrix k) +
    s.monomial (exchangeExponentNeg row s.exchange.matrix k)

theorem exchangeCoordinate_ne_zero (k : K) :
    s.exchangeCoordinate k ≠ 0 := by
  intro h
  have hne : exchangeExponentNeg row s.exchange.matrix k ≠
      exchangeExponentPos row s.exchange.matrix k := by
    intro he
    apply s.compatible.col_ne_zero k
    have h2 := exchangeExponentPos_eq_neg_add row s.exchange.matrix k
    rw [← he] at h2
    simpa using h2.symm
  have h0 : (QuantumTorus.monomial (exchangeExponentPos row s.exchange.matrix k) +
      QuantumTorus.monomial (exchangeExponentNeg row s.exchange.matrix k) :
        quantumTorus Zv vUnit (matrixForm s.form)) = 0 :=
    s.chart_injective (by rw [map_add, map_zero]; exact h)
  have := congrArg (coeff (exchangeExponentPos row s.exchange.matrix k)) h0
  rw [map_add, coeff_monomial_self, coeff_monomial_of_ne hne, map_zero, add_zero] at this
  exact one_ne_zero this

theorem exchangeCoordinate_mem_chartRing (k : K) : s.exchangeCoordinate k ∈ s.chartRing :=
  Subring.add_mem _ (s.monomial_mem_chartRing _) (s.monomial_mem_chartRing _)

/-- `X'_k X_j = v^{2Λ(-e_k+[b_{•k}]_+, e_j)} X_j X'_k` for `j ≠ row k`. -/
theorem exchangeCoordinate_mul_coordinate (k : K) {j : M} (hj : j ≠ row k) :
    s.exchangeCoordinate k * s.coordinate j =
      algebraMap Zv D ((vUnit ^ (2 * matrixForm s.form (exchangeExponentPos row s.exchange.matrix k)
        (Pi.single j 1)) : Zvˣ) : Zv) * (s.coordinate j * s.exchangeCoordinate k) := by
  rw [exchangeCoordinate, add_mul, monomial_mul_coordinate, monomial_mul_coordinate,
    ← s.compatible.matrixForm_exchangeExponentPos_eq_neg hj, ← mul_add, ← mul_add]

/-- `X_j X'_k = v^{2Λ(e_j, -e_k+[b_{•k}]_+)} X'_k X_j` for `j ≠ row k`. -/
theorem coordinate_mul_exchangeCoordinate (k : K) {j : M} (hj : j ≠ row k) :
    s.coordinate j * s.exchangeCoordinate k =
      algebraMap Zv D ((vUnit ^ (2 * matrixForm s.form (Pi.single j 1)
        (exchangeExponentPos row s.exchange.matrix k)) : Zvˣ) : Zv) *
        (s.exchangeCoordinate k * s.coordinate j) := by
  have h := s.compatible.matrixForm_exchangeExponentPos_eq_neg hj
  rw [s.alternating.matrixForm_swap, s.alternating.matrixForm_swap _ (Pi.single j 1)] at h
  rw [exchangeCoordinate, mul_add, coordinate_mul_monomial, coordinate_mul_monomial,
    neg_inj.1 h, ← mul_add, ← add_mul]

/-- `X_k X'_k = v^{Λ(e_k,α⁺)} M([b_{•k}]_+) + v^{Λ(e_k,α⁻)} M([-b_{•k}]_+)`, where
`α^± = -e_k + [±b_{•k}]_+` are the exchange exponents. -/
theorem coordinate_mul_exchangeCoordinate_eq (k : K) :
    (s.coordinate (row k) : D) * s.exchangeCoordinate k =
      algebraMap Zv D ((vUnit ^ matrixForm s.form (Pi.single (row k) 1)
          (exchangeExponentPos row s.exchange.matrix k) : Zvˣ) : Zv) *
          s.monomial (fun l ↦ positivePart (s.exchange.matrix l k)) +
        algebraMap Zv D ((vUnit ^ matrixForm s.form (Pi.single (row k) 1)
          (exchangeExponentNeg row s.exchange.matrix k) : Zvˣ) : Zv) *
          s.monomial (fun l ↦ positivePart (-s.exchange.matrix l k)) := by
  rw [exchangeCoordinate, mul_add, ← s.monomial_single (row k), monomial_mul_monomial,
    monomial_mul_monomial, single_add_exchangeExponentPos, single_add_exchangeExponentNeg]

/-- `X'_k X_k = v^{Λ(α⁺,e_k)} M([b_{•k}]_+) + v^{Λ(α⁻,e_k)} M([-b_{•k}]_+)`, where
`α^± = -e_k + [±b_{•k}]_+` are the exchange exponents. -/
theorem exchangeCoordinate_mul_coordinate_eq (k : K) :
    s.exchangeCoordinate k * s.coordinate (row k) =
      algebraMap Zv D ((vUnit ^ matrixForm s.form (exchangeExponentPos row s.exchange.matrix k)
          (Pi.single (row k) 1) : Zvˣ) : Zv) *
          s.monomial (fun l ↦ positivePart (s.exchange.matrix l k)) +
        algebraMap Zv D ((vUnit ^ matrixForm s.form (exchangeExponentNeg row s.exchange.matrix k)
          (Pi.single (row k) 1) : Zvˣ) : Zv) *
          s.monomial (fun l ↦ positivePart (-s.exchange.matrix l k)) := by
  rw [exchangeCoordinate, add_mul, ← s.monomial_single, monomial_mul_monomial,
    monomial_mul_monomial, add_comm (exchangeExponentPos _ _ _),
    add_comm (exchangeExponentNeg _ _ _), single_add_exchangeExponentPos,
    single_add_exchangeExponentNeg]

/-! ### The ring of the other coordinates -/

/-- The integral chart ring of the coordinates other than `X_i`. -/
def otherRing (i : M) : Subring D :=
  OneExchange.otherCoordinateRing (algebraMap Zv D).range (fun j ↦ (s.coordinate j : D)) i

theorem algebraMap_mem_otherRing (i : M) (r : Zv) : algebraMap Zv D r ∈ s.otherRing i :=
  coefficient_mem_chartRing _ _ ⟨r, rfl⟩

theorem orderedProd_mem_otherRing {i : M} {a : M → ℤ} (ha : a i = 0) (l : List M) :
    ((orderedProd s.coordinate l a : Dˣ) : D) ∈ s.otherRing i := by
  induction l with
  | nil => exact Subring.one_mem _
  | cons j l ih =>
    rw [orderedProd_cons, Units.val_mul]
    refine Subring.mul_mem _ ?_ ih
    by_cases hj : j = i
    · subst hj
      rw [ha, zpow_zero, Units.val_one]
      exact Subring.one_mem _
    · rw [Units.val_zpow_eq_zpow_val]
      exact coordinate_zpow_mem_chartRing _ (fun j : {j // j ≠ i} ↦ (s.coordinate j : D))
        ⟨j, hj⟩ (a j)

/-- A normalized monomial without `X_i` lies in the ring of the other coordinates. -/
theorem monomial_mem_otherRing {i : M} {a : M → ℤ} (ha : a i = 0) :
    s.monomial a ∈ s.otherRing i := by
  rw [monomial, chart, lift_monomial, normalizedProd, Algebra.smul_def]
  exact Subring.mul_mem _ (s.algebraMap_mem_otherRing i _) (s.orderedProd_mem_otherRing ha _)

theorem conj_mem_otherRing {i : M} {z : D} (hz : z ≠ 0) (w : M → Zvˣ)
    (hw : ∀ j, j ≠ i → z * s.coordinate j * z⁻¹ = algebraMap Zv D (w j : Zv) * s.coordinate j)
    {c : D} (hc : c ∈ s.otherRing i) : z * c * z⁻¹ ∈ s.otherRing i := by
  refine conj_mem_of_mem_closure hz ?_ hc
  rintro a ((⟨r, rfl⟩ | ⟨⟨j, hj⟩, rfl⟩) | ⟨⟨j, hj⟩, rfl⟩)
  · rw [← Algebra.commutes, mul_assoc, mul_inv_cancel₀ hz, mul_one]
    exact s.algebraMap_mem_otherRing i r
  · dsimp only
    rw [hw j hj]
    exact Subring.mul_mem _ (s.algebraMap_mem_otherRing i _)
      (coordinate_mem_chartRing _ (fun j : {j // j ≠ i} ↦ (s.coordinate j : D)) ⟨j, hj⟩)
  · dsimp only
    have : z * (s.coordinate j : D)⁻¹ * z⁻¹ = (z * s.coordinate j * z⁻¹)⁻¹ := by
      simp only [_root_.mul_inv_rev, inv_inv, mul_assoc]
    rw [this, hw j hj, _root_.mul_inv_rev, algebraMap_units_inv]
    exact Subring.mul_mem _
      (inverse_mem_chartRing _ (fun j : {j // j ≠ i} ↦ (s.coordinate j : D)) ⟨j, hj⟩)
      (s.algebraMap_mem_otherRing i _)

/-- An element that commutes with every `X_j`, `j ≠ i`, up to scalar units normalizes the ring
of the other coordinates. -/
theorem normalizes_otherRing {i : M} {z : D} (hz : z ≠ 0) (w : M → Zvˣ)
    (hw : ∀ j, j ≠ i →
      z * s.coordinate j = algebraMap Zv D (w j : Zv) * (s.coordinate j * z)) :
    Normalizes (s.otherRing i) z := by
  refine ⟨hz, fun c hc ↦ s.conj_mem_otherRing hz w (fun j hj ↦ ?_) hc,
    fun c hc ↦ ?_⟩
  · rw [hw j hj, mul_assoc, mul_assoc, mul_inv_cancel₀ hz, mul_one]
  · have h := s.conj_mem_otherRing (inv_ne_zero hz) (fun j ↦ (w j)⁻¹) (fun j hj ↦ ?_) hc
    · simpa using h
    · have hc : Commute (algebraMap Zv D (w j : Zv)) z⁻¹ := Algebra.commutes _ _
      have h1 : algebraMap Zv D (w j : Zv) * (z⁻¹ * s.coordinate j * z) = s.coordinate j := by
        calc algebraMap Zv D (w j : Zv) * (z⁻¹ * s.coordinate j * z)
            = (algebraMap Zv D (w j : Zv) * z⁻¹) * s.coordinate j * z := by
              simp only [mul_assoc]
          _ = z⁻¹ * (algebraMap Zv D (w j : Zv) * (s.coordinate j * z)) := by
              rw [hc.eq]; simp only [mul_assoc]
          _ = s.coordinate j := by rw [← hw j hj, ← mul_assoc, inv_mul_cancel₀ hz, one_mul]
      rw [inv_inv]
      conv_rhs => rw [← h1]
      rw [← mul_assoc, ← map_mul, Units.inv_mul, map_one, one_mul]

/-! ### Graded pieces and freeness of `X_i` -/

/-- The `Zv`-span of the normalized monomials with `i`-th exponent `n`. -/
def gradedSpan (i : M) (n : ℤ) : Submodule Zv D :=
  Submodule.span Zv (s.monomial '' {a | a i = n})

theorem monomial_mem_gradedSpan {i : M} {a : M → ℤ} {n : ℤ} (ha : a i = n) :
    s.monomial a ∈ s.gradedSpan i n :=
  Submodule.subset_span ⟨a, ha, rfl⟩

theorem mul_mem_gradedSpan {i : M} {m n : ℤ} {p q : D} (hp : p ∈ s.gradedSpan i m)
    (hq : q ∈ s.gradedSpan i n) : p * q ∈ s.gradedSpan i (m + n) := by
  have h := Submodule.mul_mem_mul hp hq
  rw [gradedSpan, gradedSpan, Submodule.span_mul_span] at h
  refine Submodule.span_le.2 ?_ h
  rintro _ ⟨_, ⟨a, ha, rfl⟩, _, ⟨b, hb, rfl⟩, rfl⟩
  change s.monomial a * s.monomial b ∈ s.gradedSpan i (m + n)
  rw [monomial_mul_monomial, ← Algebra.smul_def]
  refine Submodule.smul_mem _ _ (s.monomial_mem_gradedSpan ?_)
  simp only [Set.mem_ofPred_eq] at ha hb
  simp [ha, hb]

/-- The graded pieces are independent: a vanishing finite sum of elements of distinct pieces
has vanishing terms. -/
theorem eq_zero_of_sum_mem_gradedSpan {i : M} {S : Finset ℤ} {p : ℤ → D}
    (hp : ∀ n ∈ S, p n ∈ s.gradedSpan i n) (hsum : ∑ n ∈ S, p n = 0) :
    ∀ n ∈ S, p n = 0 := by
  classical
  choose! l hl hlp using fun n hn ↦
    (Finsupp.mem_span_image_iff_linearCombination Zv).1 (hp n hn)
  have hl0 : ∑ n ∈ S, l n = 0 := by
    refine linearIndependent_iff.1 s.linearIndependent_monomial _ ?_
    rw [map_sum, ← hsum]
    exact Finset.sum_congr rfl fun n hn ↦ hlp n hn
  intro n hn
  rw [← hlp n hn]
  suffices l n = 0 by rw [this, map_zero]
  refine Finsupp.ext fun a ↦ ?_
  by_cases ha : a i = n
  · have := congrArg (· a) hl0
    simp only [Finsupp.coe_finsetSum, Finset.sum_apply, Finsupp.coe_zero,
      Pi.zero_apply] at this
    rw [Finset.sum_eq_single n (fun m hm hmn ↦ ?_) (fun h ↦ absurd hn h)] at this
    · exact this
    · by_contra h
      exact hmn (ha ▸ (hl m hm (Finsupp.mem_support_iff.2 h)).symm)
  · by_contra h
    exact ha (hl n hn (Finsupp.mem_support_iff.2 h))

/-- The ring of the other coordinates lies in the degree-zero piece. -/
theorem otherRing_le_gradedSpan (i : M) {c : D} (hc : c ∈ s.otherRing i) :
    c ∈ s.gradedSpan i 0 := by
  let S : Subring D :=
    { carrier := s.gradedSpan i 0
      mul_mem' := fun hp hq ↦ by simpa using s.mul_mem_gradedSpan hp hq
      one_mem' := by
        rw [← s.monomial_zero]
        exact s.monomial_mem_gradedSpan rfl
      add_mem' := Submodule.add_mem _
      zero_mem' := Submodule.zero_mem _
      neg_mem' := Submodule.neg_mem _ }
  have hS : s.otherRing i ≤ S := by
    refine chartRing_le ?_ (fun j ↦ ?_) (fun j ↦ ?_)
    · rintro _ ⟨r, rfl⟩
      change algebraMap Zv D r ∈ s.gradedSpan i 0
      rw [← mul_one (algebraMap Zv D r), ← Algebra.smul_def, ← s.monomial_zero]
      exact Submodule.smul_mem _ _ (s.monomial_mem_gradedSpan rfl)
    · change (s.coordinate j : D) ∈ s.gradedSpan i 0
      rw [← s.monomial_single]
      exact s.monomial_mem_gradedSpan (by simp [j.2])
    · change (s.coordinate j : D)⁻¹ ∈ s.gradedSpan i 0
      rw [← s.monomial_neg_single]
      exact s.monomial_mem_gradedSpan (by simp [j.2])
  exact hS hc

/-- The integer powers of `X_i` are free over the ring of the other coordinates. -/
theorem leftFree_coordinate (i : M) :
    SkewExchange.LeftFree (s.otherRing i) (s.coordinate i : D) := by
  apply SkewExchange.leftFree_of_sum
  intro S c hc hsum n hn
  have hmem : ∀ m ∈ S, c m * (s.coordinate i : D) ^ m ∈ s.gradedSpan i m := by
    intro m hm
    have h2 : (s.coordinate i : D) ^ m ∈ s.gradedSpan i m := by
      rw [← s.monomial_zsmul_single]
      exact s.monomial_mem_gradedSpan (by simp)
    simpa using s.mul_mem_gradedSpan (s.otherRing_le_gradedSpan i (hc m hm)) h2
  have := s.eq_zero_of_sum_mem_gradedSpan hmem hsum n hn
  exact (mul_eq_zero.1 this).resolve_right (zpow_ne_zero _ (Units.ne_zero _))

/-! ### The one-exchange data -/

theorem coordinate_normalizes (i : M) :
    Normalizes (s.otherRing i) (s.coordinate i : D) :=
  s.normalizes_otherRing (Units.ne_zero _)
    (fun j ↦ vUnit ^ (2 * matrixForm s.form (Pi.single i 1) (Pi.single j 1)))
    (fun j _ ↦ by rw [s.quasiCommuting i j, Algebra.smul_def])

theorem exchangeCoordinate_normalizes (k : K) :
    Normalizes (s.otherRing (row k)) (s.exchangeCoordinate k) :=
  s.normalizes_otherRing (s.exchangeCoordinate_ne_zero k)
    (fun j ↦ vUnit ^ (2 * matrixForm s.form (exchangeExponentPos row s.exchange.matrix k)
      (Pi.single j 1)))
    (fun _ hj ↦ s.exchangeCoordinate_mul_coordinate k hj)

theorem exchangeCoordinate_mul_coordinate_mem (k : K) :
    s.exchangeCoordinate k * s.coordinate (row k) ∈ s.otherRing (row k) := by
  have hdiag := s.exchange.diagonal k
  rw [exchangeCoordinate, add_mul, ← s.monomial_single, monomial_mul_monomial,
    monomial_mul_monomial, add_comm (exchangeExponentPos _ _ _),
    add_comm (exchangeExponentNeg _ _ _), single_add_exchangeExponentPos,
    single_add_exchangeExponentNeg]
  refine Subring.add_mem _ (Subring.mul_mem _ (s.algebraMap_mem_otherRing _ _)
    (s.monomial_mem_otherRing ?_)) (Subring.mul_mem _ (s.algebraMap_mem_otherRing _ _)
    (s.monomial_mem_otherRing ?_)) <;> simp [hdiag, positivePart]

/-- **The one-exchange data of a quantum seed** (§0.5 for Q1): `C` is the ring of the other
coordinates, `x = X_k`, and `E = X'_k X_k ∈ C`; the exchanged coordinate `E x⁻¹` is `X'_k`. -/
theorem exchangeData (k : K) :
    SkewExchange.ExchangeData (s.otherRing (row k)) (s.coordinate (row k) : D)
      (s.exchangeCoordinate k * s.coordinate (row k)) where
  x_normalizes := s.coordinate_normalizes (row k)
  x_leftFree := s.leftFree_coordinate (row k)
  E_mem := s.exchangeCoordinate_mul_coordinate_mem k
  E_normalizes := (s.exchangeCoordinate_normalizes k).mul (s.coordinate_normalizes (row k))

theorem exchangeData_y (k : K) :
    s.exchangeCoordinate k * s.coordinate (row k) * (s.coordinate (row k) : D)⁻¹ =
      s.exchangeCoordinate k :=
  mul_inv_cancel_right₀ (Units.ne_zero _) _

theorem exchangeCoordinate_leftFree (k : K) :
    SkewExchange.LeftFree (s.otherRing (row k)) (s.exchangeCoordinate k) := by
  simpa only [exchangeData_y] using (s.exchangeData k).y_leftFree

/-! ### The mutated chart -/

/-- The coordinates of `μ_k(s)`: `X_{row k}` is replaced by `X'_k`. -/
def mutateCoordinate (k : K) : M → Dˣ :=
  Function.update s.coordinate (row k)
    (Units.mk0 (s.exchangeCoordinate k) (s.exchangeCoordinate_ne_zero k))

theorem mutateCoordinate_row (k : K) :
    (s.mutateCoordinate k (row k) : D) = s.exchangeCoordinate k := by
  simp [mutateCoordinate]

theorem mutateCoordinate_of_ne (k : K) {j : M} (hj : j ≠ row k) :
    s.mutateCoordinate k j = s.coordinate j :=
  Function.update_of_ne hj _ _

/-- The new coordinates quasi-commute for the mutated form `Λ' = E_εᵀ Λ E_ε`. -/
theorem mutateCoordinate_quasiCommuting (k : K) :
    IsQuasiCommuting vUnit (matrixForm (formMutation row s.exchange.matrix s.form k 1))
      (s.mutateCoordinate k) := by
  have hrow : ∀ {j}, j ≠ row k → formMutation row s.exchange.matrix s.form k 1 (row k) j =
      matrixForm s.form (exchangeExponentPos row s.exchange.matrix k) (Pi.single j 1) :=
    fun hj ↦ s.compatible.formMutation_apply_row_left_pos (Or.inl rfl) hj
  intro i j
  rw [matrixForm_single_single, Algebra.smul_def]
  by_cases hi : i = row k <;> by_cases hj : j = row k
  · subst hi
    rw [hj, formMutation_apply_row_row k s.alternating]
    simp
  · subst hi
    rw [hrow hj, mutateCoordinate_row, mutateCoordinate_of_ne _ _ hj]
    exact s.exchangeCoordinate_mul_coordinate k hj
  · subst hj
    rw [(s.alternating.formMutation k 1) i (row k), hrow hi, mutateCoordinate_row,
      mutateCoordinate_of_ne _ _ hi, s.coordinate_mul_exchangeCoordinate k hi,
      s.alternating.matrixForm_swap (Pi.single i 1)]
  · rw [formMutation_apply_of_ne row _ _ k 1 hi hj, mutateCoordinate_of_ne _ _ hi,
      mutateCoordinate_of_ne _ _ hj, s.quasiCommuting i j, matrixForm_single_single,
      Algebra.smul_def]

/-- The chart of `μ_k(s)`, before its faithfulness is known. -/
def mutateChart (k : K) :
    quantumTorus Zv vUnit (matrixForm (formMutation row s.exchange.matrix s.form k 1)) →ₐ[Zv] D :=
  QuantumTorus.lift (s.alternating.formMutation k 1).isAlt (s.mutateCoordinate k)
    (s.mutateCoordinate_quasiCommuting k)

/-- Off `row k` the new normalized monomials are the old ones. -/
theorem mutateChart_monomial_of_apply_eq_zero (k : K) {a : M → ℤ}
    (ha : a (row k) = 0) : s.mutateChart k (QuantumTorus.monomial a) = s.monomial a := by
  refine (lift_monomial_congr s.isAlt _ s.quasiCommuting _ (fun i hi ↦ ?_)
    (fun p q hp hq ↦ ?_)).symm
  · refine (s.mutateCoordinate_of_ne k ?_).symm
    rintro rfl
    exact hi ha
  · exact (formMutation_matrixForm_of_apply_eq_zero _ _ (hp _ ha) (hq _ ha)).symm

theorem mutateChart_monomial_zsmul_single (k : K) (n : ℤ) :
    s.mutateChart k (QuantumTorus.monomial (n • Pi.single (row k) 1)) =
      s.exchangeCoordinate k ^ n := by
  rw [mutateChart, lift_monomial_zsmul_single, Units.val_zpow_eq_zpow_val, mutateCoordinate_row]

/-- A new normalized monomial is a scalar unit times an old monomial without `X_{row k}` times a
power of `X'_k`. -/
theorem mutateChart_monomial (k : K) (a : M → ℤ) :
    s.mutateChart k (QuantumTorus.monomial a) =
      algebraMap Zv D ((vUnit ^ (-(a (row k) *
        matrixForm s.form (a - a (row k) • Pi.single (row k) 1)
          (exchangeExponentNeg row s.exchange.matrix k))) : Zvˣ) : Zv) *
        (s.monomial (a - a (row k) • Pi.single (row k) 1) *
          s.exchangeCoordinate k ^ a (row k)) := by
  have hdiag := s.exchange.diagonal k
  have hb0 : (a - a (row k) • Pi.single (row k) 1 : M → ℤ) (row k) = 0 := by simp
  have h := congrArg (s.mutateChart k) (QuantumTorus.monomial_mul_monomial (R := Zv)
    (u := vUnit) (Λ := matrixForm (formMutation row s.exchange.matrix s.form k 1))
    (a - a (row k) • Pi.single (row k) 1) (a (row k) • Pi.single (row k) 1))
  rw [map_mul, map_smul, Algebra.smul_def (R := Zv) (A := D), sub_add_cancel,
    s.mutateChart_monomial_of_apply_eq_zero k hb0, s.mutateChart_monomial_zsmul_single,
    formMutation_matrixForm_zsmul_single _ hdiag hb0] at h
  rw [h, ← mul_assoc, ← map_mul, ← Units.val_mul, ← zpow_add, neg_add_cancel, zpow_zero,
    Units.val_one, map_one, one_mul]

/-- **Faithfulness of the mutated chart.** A relation among new monomials, grouped by the
exponent of `X'_k`, is a left relation among powers of `X'_k` over the ring `C` of the other
coordinates; these are free (`ExchangeData.y_leftFree`), and the old monomials are independent. -/
theorem mutateChart_injective (k : K) :
    Function.Injective (s.mutateChart k) := by
  apply algHom_injective_of_coordinate_free (s.alternating.formMutation k 1).isAlt
    s.chart (s.mutateChart k) s.chart_injective (row k) (s.otherRing (row k))
    (s.algebraMap_mem_otherRing _) (fun _ ha ↦ s.monomial_mem_otherRing ha)
    (fun _ ha ↦ s.mutateChart_monomial_of_apply_eq_zero k ha)
  simpa only [mutateChart, lift_monomial_single, mutateCoordinate_row] using
    s.exchangeCoordinate_leftFree k

variable [Fintype K] [DecidableEq K]

/-- **Mutation** `μ_k` of a quantum seed: matrix mutation of `B_ext`, `Λ ↦ E_εᵀ Λ E_ε`, and
`X_{row k} ↦ X'_k`. -/
def mutate (k : K) : QuantumSeed D row where
  exchange := s.exchange.mutate k
  form := formMutation row s.exchange.matrix s.form k 1
  alternating := s.alternating.formMutation k 1
  compatible := s.compatible.mutation (Or.inl rfl)
  coordinate := s.mutateCoordinate k
  quasiCommuting := s.mutateCoordinate_quasiCommuting k
  faithful := s.mutateChart_injective k

variable (k : K)

@[simp] theorem mutate_exchange : (s.mutate k).exchange = s.exchange.mutate k := rfl
theorem mutate_exchange_matrix :
    (s.mutate k).exchange.matrix = extendedMatrixMutation row s.exchange.matrix k := rfl

@[simp] theorem mutate_form : (s.mutate k).form = formMutation row s.exchange.matrix s.form k 1 :=
  rfl

theorem mutate_coordinate : (s.mutate k).coordinate = s.mutateCoordinate k := rfl
theorem mutate_chart : (s.mutate k).chart = s.mutateChart k := rfl
theorem mutate_monomial (a : M → ℤ) :
    (s.mutate k).monomial a = s.mutateChart k (QuantumTorus.monomial a) := rfl

@[simp] theorem mutate_coordinate_row :
    ((s.mutate k).coordinate (row k) : D) = s.exchangeCoordinate k :=
  s.mutateCoordinate_row k

theorem mutate_coordinate_of_ne {j : M} (hj : j ≠ row k) :
    (s.mutate k).coordinate j = s.coordinate j :=
  s.mutateCoordinate_of_ne k hj

/-! ### Involutivity -/

omit [Fintype K] [DecidableEq K] in
theorem mutateChart_monomial_mul_exchangeCoordinate {a : M → ℤ} (ha : a (row k) = -1) :
    s.mutateChart k (QuantumTorus.monomial a) * s.exchangeCoordinate k =
      algebraMap Zv D ((vUnit ^ matrixForm s.form (a + Pi.single (row k) 1)
        (exchangeExponentNeg row s.exchange.matrix k) : Zvˣ) : Zv) *
        s.monomial (a + Pi.single (row k) 1) := by
  have hsub : a - (-1 : ℤ) • Pi.single (row k) 1 = a + Pi.single (row k) 1 := by
    rw [neg_one_zsmul, sub_neg_eq_add]
  rw [mutateChart_monomial, ha, hsub, neg_one_mul, neg_neg, mul_assoc, mul_assoc, zpow_neg_one,
    inv_mul_cancel₀ (s.exchangeCoordinate_ne_zero k), mul_one]

/-- The exchanged coordinate of `μ_k(s)` at `k` is `X_{row k}`: both `X''_k X'_k` and
`X_{row k} X'_k` expand to `v^{Λ(e_k,·)} M([b_{•k}]_+) + v^{Λ(e_k,·)} M([-b_{•k}]_+)`. -/
theorem mutate_exchangeCoordinate :
    (s.mutate k).exchangeCoordinate k = s.coordinate (row k) := by
  have hdiag := s.exchange.diagonal k
  have hX' := s.exchangeCoordinate_ne_zero k
  set e : M → ℤ := Pi.single (row k) 1 with he
  set p := exchangeExponentPos row s.exchange.matrix k with hp
  set q := exchangeExponentNeg row s.exchange.matrix k with hq
  have hpq : matrixForm s.form (p + e) q = matrixForm s.form e p := by
    rw [hp, exchangeExponentPos_eq_neg_add, ← hq]
    simp only [map_add, LinearMap.add_apply]
    rw [s.alternating.matrixForm_self, s.compatible.matrixForm_col,
      s.compatible.matrixForm_col_right s.alternating, hq, exchangeExponentNeg_row hdiag]
    simp [he]
    ring
  have hqq : matrixForm s.form (q + e) q = matrixForm s.form e q := by
    simp only [map_add, LinearMap.add_apply]
    rw [s.alternating.matrixForm_self, zero_add]
  apply mul_right_cancel₀ hX'
  have hL : (s.mutate k).exchangeCoordinate k =
      (s.mutate k).monomial q + (s.mutate k).monomial p := by
    change (s.mutate k).monomial (exchangeExponentPos row (extendedMatrixMutation row
      s.exchange.matrix k) k) + (s.mutate k).monomial (exchangeExponentNeg row
      (extendedMatrixMutation row s.exchange.matrix k) k) = _
    rw [exchangeExponentPos_mutation, exchangeExponentNeg_mutation]
  rw [hL, add_mul, mutate_monomial, mutate_monomial,
    s.mutateChart_monomial_mul_exchangeCoordinate k (exchangeExponentNeg_row hdiag),
    s.mutateChart_monomial_mul_exchangeCoordinate k (exchangeExponentPos_row hdiag),
    hqq, hpq, exchangeCoordinate, mul_add, ← s.monomial_single, monomial_mul_monomial,
    monomial_mul_monomial, add_comm e p, add_comm e q, add_comm]

/-- **Involutivity of mutation.** -/
theorem mutate_mutate : (s.mutate k).mutate k = s := by
  refine QuantumSeed.ext (s.exchange.mutate_mutate k)
    (s.compatible.formMutation_involutive s.alternating (Or.inl rfl) (Or.inl rfl)) ?_
  funext j
  by_cases hj : j = row k
  · subst hj
    exact Units.ext
      (((s.mutate k).mutate_coordinate_row k).trans (s.mutate_exchangeCoordinate k))
  · rw [mutate_coordinate_of_ne _ _ hj, mutate_coordinate_of_ne _ _ hj]

theorem mutate_involutive :
    Function.Involutive (fun t : QuantumSeed D row ↦ t.mutate k) :=
  fun t ↦ t.mutate_mutate k

/-! ### Reachable seeds -/

/-- `t` is reached from `s` by a finite mutation word. -/
def Reachable (s t : QuantumSeed D row) : Prop :=
  ∃ w : List K, mutateWord (fun k t ↦ QuantumSeed.mutate t k) w s = t

theorem reachable_mutateWord (s : QuantumSeed D row) (w : List K) :
    s.Reachable (mutateWord (fun k t ↦ QuantumSeed.mutate t k) w s) :=
  ⟨w, rfl⟩

@[refl] theorem Reachable.refl (s : QuantumSeed D row) : s.Reachable s :=
  ⟨[], rfl⟩

theorem reachable_mutate (s : QuantumSeed D row) (k : K) : s.Reachable (s.mutate k) :=
  ⟨[k], rfl⟩

theorem Reachable.trans {s t u : QuantumSeed D row} (h₁ : s.Reachable t) (h₂ : t.Reachable u) :
    s.Reachable u := by
  obtain ⟨w₁, rfl⟩ := h₁
  obtain ⟨w₂, rfl⟩ := h₂
  exact ⟨w₁ ++ w₂, mutateWord_append _ _ _ _⟩

theorem Reachable.symm {s t : QuantumSeed D row} (h : s.Reachable t) : t.Reachable s := by
  obtain ⟨w, rfl⟩ := h
  exact ⟨w.reverse, mutateWord_reverse _ (fun k ↦ mutate_involutive k) w s⟩

theorem reachable_comm {s t : QuantumSeed D row} : s.Reachable t ↔ t.Reachable s :=
  ⟨Reachable.symm, Reachable.symm⟩

/-! ### The one-exchange intersection (Q1) -/

omit [Fintype K] [DecidableEq K] in
theorem chartRing_eq_regroup (i : M) :
    s.chartRing = Laurent.chartRing (s.otherRing i) (fun _ : Unit ↦ (s.coordinate i : D)) :=
  OneExchange.chartRing_regroup _ _ i

@[simp] theorem mutate_otherRing : (s.mutate k).otherRing (row k) = s.otherRing (row k) := by
  simp only [otherRing, OneExchange.otherCoordinateRing]
  congr 1
  funext j
  rw [mutate_coordinate_of_ne _ _ j.2]

/-- **Q1.** `T_s ∩ T_{μ_k(s)} = C⟨X_k, X'_k⟩` with `C` the integral chart ring of the other
coordinates. Normal forms and the coefficient criterion come from `s.exchangeData k`. -/
theorem chartRing_inf_mutate_chartRing :
    s.chartRing ⊓ (s.mutate k).chartRing =
      Subring.closure ((s.otherRing (row k) : Set D) ∪
        {(s.coordinate (row k) : D), s.exchangeCoordinate k}) := by
  rw [s.chartRing_eq_regroup (row k), (s.mutate k).chartRing_eq_regroup (row k),
    mutate_otherRing, mutate_coordinate_row, ← s.exchangeData_y k]
  exact (s.exchangeData k).chartRing_inf_chartRing

/-! ### The mutation pattern and the quantum upper bound -/

/-- One-step membership: the coordinates of `μ_k(s)` lie in the chart ring of `s`. -/
theorem mutate_coordinate_mem_chartRing (j : M) :
    ((s.mutate k).coordinate j : D) ∈ s.chartRing := by
  by_cases hj : j = row k
  · subst hj
    rw [mutate_coordinate_row]
    exact s.exchangeCoordinate_mem_chartRing k
  · rw [mutate_coordinate_of_ne _ _ hj]
    exact coordinate_mem_chartRing _ _ j

/-- The quantum upper bound `T_s ∩ ⋂_k T_{μ_k(s)}`. -/
def upperBound : Subring D :=
  TauCeti.Cluster.upperBound (algebraMap Zv D).range
    (fun t : QuantumSeed D row ↦ fun i ↦ (t.coordinate i : D)) (fun k t ↦ t.mutate k) s

theorem mem_upperBound {a : D} :
    a ∈ s.upperBound ↔ a ∈ s.chartRing ∧ ∀ k, a ∈ (s.mutate k).chartRing :=
  TauCeti.Cluster.mem_upperBound

theorem upperBound_le_chartRing : s.upperBound ≤ s.chartRing :=
  upperBound_le_chart _ _ _ s

theorem coordinate_mem_upperBound (j : M) : (s.coordinate j : D) ∈ s.upperBound :=
  TauCeti.Cluster.coordinate_mem_upperBound _ _ _ (fun k ↦ mutate_involutive k)
    (fun t k j ↦ t.mutate_coordinate_mem_chartRing k j) s j

/-- Local three-chart equalities give upper-bound invariance under quantum mutation. -/
theorem upperBound_mutate_of_three_chart
    (hthree : ∀ (t : QuantumSeed D row) (i j : K), j ≠ i →
      t.chartRing ⊓ (t.mutate i).chartRing ⊓ (t.mutate j).chartRing =
        (t.mutate i).chartRing ⊓ t.chartRing ⊓ ((t.mutate i).mutate j).chartRing) :
    (s.mutate k).upperBound = s.upperBound :=
  TauCeti.Cluster.upperBound_mutation_of_three_chart _ _ _ (fun k ↦ mutate_involutive k)
    hthree s k

/-- Quantum Laurentness from upper-bound invariance: every coordinate reached by a mutation
word lies in the integral chart ring of the initial seed. -/
theorem coordinate_mutateWord_mem_chartRing_of_upperBound_mutate
    (hmut : ∀ (t : QuantumSeed D row) (k : K), (t.mutate k).upperBound = t.upperBound)
    (w : List K) (j : M) :
    ((mutateWord (fun k t ↦ QuantumSeed.mutate t k) w s).coordinate j : D) ∈ s.chartRing :=
  TauCeti.Cluster.laurent_of_upperBound_invariant _ _ _ (fun k ↦ mutate_involutive k)
    (fun t k j ↦ t.mutate_coordinate_mem_chartRing k j) hmut s w j

/-! ### Q3 with hypotheses at the seeds reachable from `s` -/

/-- **Q3, invariance.** The three-chart equalities at every seed reached from `s` make the quantum
upper bound the same at all seeds reached from `s`. -/
theorem upperBound_eq_of_three_chart
    (hthree : ∀ t : QuantumSeed D row,
      s.Reachable t →
      ∀ i j : K, j ≠ i →
        t.chartRing ⊓ (t.mutate i).chartRing ⊓ (t.mutate j).chartRing =
          (t.mutate i).chartRing ⊓ t.chartRing ⊓ ((t.mutate i).mutate j).chartRing)
    {t : QuantumSeed D row}
    (ht : s.Reachable t) :
    t.upperBound = s.upperBound := by
  obtain ⟨w, rfl⟩ := ht
  exact patternUpperBound_mutateWord_of_three_chart
    (fun t : QuantumSeed D row ↦ t.chartRing) (fun k t ↦ t.mutate k)
    (fun k ↦ mutate_involutive k) s
    (fun w i j hji ↦ hthree _ ⟨w, rfl⟩ i j hji) w

/-- **Q3, Laurentness.** If the quantum upper bound is invariant under mutation at every seed
reached from `s`, every coordinate of a seed reached from `s` lies in the integral chart ring of
every seed reached from `s`. -/
theorem coordinate_mem_chartRing_of_upperBound_mutate
    (hmut : ∀ t : QuantumSeed D row,
      s.Reachable t →
      ∀ k : K, (t.mutate k).upperBound = t.upperBound)
    {t u : QuantumSeed D row}
    (ht : s.Reachable t)
    (hu : s.Reachable u) (j : M) :
    (t.coordinate j : D) ∈ u.chartRing := by
  obtain ⟨w, rfl⟩ := ht
  obtain ⟨v, rfl⟩ := hu
  exact generator_mem_of_patternUpperBound
    (fun t : QuantumSeed D row ↦ t.chartRing) (fun k t ↦ t.mutate k)
    (fun t i ↦ (t.coordinate i : D))
    (fun k ↦ mutate_involutive k) s (fun _ j ↦ coordinate_mem_chartRing _ _ j)
    (fun _ k j ↦ QuantumSeed.mutate_coordinate_mem_chartRing _ k j)
    (fun w k ↦ hmut _ ⟨w, rfl⟩ k) v w j

/-- If the quantum upper bound is invariant under mutation at every seed reached from `s`, the
quantum upper cluster algebra `⋂_t T_t` equals the finite upper bound at `s`. -/
theorem upperClusterRing_eq_upperBound_of_upperBound_mutate
    (hmut : ∀ t : QuantumSeed D row,
      s.Reachable t →
      ∀ k : K, (t.mutate k).upperBound = t.upperBound) :
    TauCeti.Cluster.upperClusterRing (algebraMap Zv D).range
        (fun t : QuantumSeed D row ↦ fun i ↦ (t.coordinate i : D))
        (fun k t ↦ t.mutate k) s = s.upperBound :=
  patternUpperRing_eq_patternUpperBound
    (fun t : QuantumSeed D row ↦ t.chartRing) (fun k t ↦ t.mutate k) s
    fun w k ↦ hmut _ ⟨w, rfl⟩ k

/-- If the quantum upper bound is invariant under mutation at every seed reached from `s`, the
quantum cluster ring lies in the quantum upper cluster algebra. -/
theorem clusterRing_le_upperClusterRing_of_upperBound_mutate
    (hmut : ∀ t : QuantumSeed D row,
      s.Reachable t →
      ∀ k : K, (t.mutate k).upperBound = t.upperBound) :
    TauCeti.Cluster.clusterRing (algebraMap Zv D).range
        (fun t : QuantumSeed D row ↦ fun i ↦ (t.coordinate i : D))
        (fun k t ↦ t.mutate k) s ≤
      TauCeti.Cluster.upperClusterRing (algebraMap Zv D).range
        (fun t : QuantumSeed D row ↦ fun i ↦ (t.coordinate i : D))
        (fun k t ↦ t.mutate k) s :=
  clusterRing_le_patternUpperRing
    (fun t : QuantumSeed D row ↦ Laurent.chartRing (algebraMap Zv D).range
      (fun i ↦ (t.coordinate i : D))) (fun k t ↦ t.mutate k) (algebraMap Zv D).range
    (fun t : QuantumSeed D row ↦ fun i ↦ (t.coordinate i : D))
    (fun k ↦ mutate_involutive k) s
    (coefficient_le_upperBound (algebraMap Zv D).range
      (fun t : QuantumSeed D row ↦ fun i ↦ (t.coordinate i : D)) (fun k t ↦ t.mutate k) s)
    (fun _ j ↦ coordinate_mem_chartRing _ _ j)
    (fun _ k j ↦ QuantumSeed.mutate_coordinate_mem_chartRing _ k j)
    (fun w k ↦ hmut _ ⟨w, rfl⟩ k)

end

end QuantumSeed

end TauCeti.Cluster
