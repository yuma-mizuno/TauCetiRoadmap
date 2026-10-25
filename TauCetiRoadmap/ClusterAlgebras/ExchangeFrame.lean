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
# Based exchange frames over a commutative scalar ring

The matrix has a positive symmetrizer. Its rational columns are independent.
The alternating integer form has separate diagonal compatibility weights, which
may vanish. A faithful based-torus chart realizes the coordinates in a possibly
noncommutative division algebra over the scalar ring, with a chosen central unit.
This file owns monomials, normalizers and one-coordinate gradings. Polynomial
mutation owns the changed faithful frame; binary mutation is its degree-one case.
Classical frames have unit parameter, zero form and zero form weights. Ordinary
quantum seeds retain positive quantum compatibility in `QuantumSeed`.
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

theorem IsColumnCompatible.matrixForm_exchangeExponentPos_eq_neg {Λ : Matrix M M ℤ}
    {E : ExtendedExchangeMatrix row} {w : K → ℤ} (hc : IsColumnCompatible E Λ w) {j : M} (hj : j
      ≠ row k) :
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

variable {R₀ : Type*} [CommRing R₀] {u₀ : R₀ˣ}
  {D : Type*} [DivisionRing D] [Algebra R₀ D]
  {M K : Type*} [Fintype M] [DecidableEq M]

theorem algebraMap_units_inv (c : R₀ˣ) :
    (algebraMap R₀ D (c : R₀))⁻¹ = algebraMap R₀ D ((c⁻¹ : R₀ˣ) : R₀) :=
  inv_eq_of_mul_eq_one_right (by rw [← map_mul, Units.mul_inv, map_one])

variable (D) in
/-- A **quantum seed** in `D`: a compatible pair `(B_ext, Λ)` and quasi-commuting units `X_i`
whose chart `T(R₀,v,Λ) → D`, `X ^ a ↦ M(a)`, is injective. -/
structure ExchangeFrame (row : K ↪ M) where
  /-- The extended exchange matrix `B_ext` with its symmetrizer. -/
  exchange : ExtendedExchangeMatrix row
  /-- The quasi-commutation form `Λ`. -/
  form : Matrix M M ℤ
  alternating : IsAlternatingMatrix form
  /-- The diagonal form weights; zero is allowed independently of the symmetrizer. -/
  formWeight : K → ℤ
  compatible : IsColumnCompatible exchange form formWeight
  /-- Column independence is separate from the commutation form. -/
  independentColumns : LinearIndependent ℚ (fun k ↦ fun a ↦ (exchange.matrix a k : ℚ))
  /-- The cluster and frozen variables `X_i`. -/
  coordinate : M → Dˣ
  quasiCommuting : IsQuasiCommuting u₀ (matrixForm form) coordinate
  faithful : Function.Injective (QuantumTorus.lift alternating.isAlt coordinate
    quasiCommuting)

namespace ExchangeFrame

noncomputable section

variable {row : K ↪ M} (s : ExchangeFrame (u₀ := u₀) D row)

@[ext] theorem ext {s t : ExchangeFrame (u₀ := u₀) D row} (h₁ : s.exchange = t.exchange)
    (h₂ : s.form = t.form) (h₃ : s.coordinate = t.coordinate) : s = t := by
  have hw : s.formWeight = t.formWeight := by
    funext k
    have hs := s.compatible k (row k)
    have ht := t.compatible k (row k)
    rw [← h₁, ← h₂] at ht
    simpa only [ite_true] using hs.symm.trans ht
  cases s
  cases t
  cases h₁
  cases h₂
  cases hw
  cases h₃
  rfl

/-- Every exchange column is nonzero by the independent-column hypothesis. -/
theorem column_ne_zero (k : K) : (fun a ↦ s.exchange.matrix a k) ≠ 0 := by
  intro h
  apply s.independentColumns.ne_zero k
  funext a
  change (s.exchange.matrix a k : ℚ) = 0
  have ha : s.exchange.matrix a k = 0 := congrFun h a
  exact_mod_cast ha

theorem isAlt : LinearMap.IsAlt (matrixForm s.form) :=
  s.alternating.isAlt

/-- The chart `T(R₀,v,Λ) → D` of the seed, `X_i ↦ X_i`. -/
noncomputable def chart : quantumTorus R₀ u₀ (matrixForm s.form) →ₐ[R₀] D :=
  QuantumTorus.lift s.isAlt s.coordinate s.quasiCommuting

theorem chart_injective : Function.Injective s.chart := s.faithful
/-- The normalized monomial `M(a)`, the image of `X ^ a` under the chart. -/
noncomputable def monomial (a : M → ℤ) : D := s.chart (QuantumTorus.monomial a)
/-- The integral quantum chart ring `R₀[X_i^{±1}]` of the seed. -/
def chartRing : Subring D :=
  Laurent.chartRing (algebraMap R₀ D).range (fun i ↦ (s.coordinate i : D))

theorem range_chart : s.chart.range.toSubring = s.chartRing :=
  range_lift _ _

theorem linearIndependent_monomial : LinearIndependent R₀ s.monomial :=
  (lift_injective_iff _ _).1 s.faithful

theorem monomial_mem_chartRing (a : M → ℤ) : s.monomial a ∈ s.chartRing := by
  rw [← range_chart]
  exact ⟨_, rfl⟩

theorem monomial_mul_monomial (a b : M → ℤ) :
    s.monomial a * s.monomial b =
      algebraMap R₀ D ((u₀ ^ matrixForm s.form a b : R₀ˣ) : R₀) * s.monomial (a + b) := by
  rw [monomial, monomial, ← map_mul, QuantumTorus.monomial_mul_monomial, map_smul,
    Algebra.smul_def]
  rfl

/-- Quasi-commutation of normalized monomials, `M(a) M(b) = v^{2Λ(a,b)} M(b) M(a)`. -/
theorem monomial_mul_monomial_comm (a b : M → ℤ) :
    s.monomial a * s.monomial b =
      algebraMap R₀ D ((u₀ ^ (2 * matrixForm s.form a b) : R₀ˣ) : R₀) *
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
      algebraMap R₀ D ((u₀ ^ (2 * matrixForm s.form a (Pi.single j 1)) : R₀ˣ) : R₀) *
        (s.coordinate j * s.monomial a) := by
  rw [← s.monomial_single j, monomial_mul_monomial_comm]

/-- `X_j M(a) = v^{2Λ(e_j,a)} M(a) X_j`. -/
theorem coordinate_mul_monomial (a : M → ℤ) (j : M) :
    s.coordinate j * s.monomial a =
      algebraMap R₀ D ((u₀ ^ (2 * matrixForm s.form (Pi.single j 1) a) : R₀ˣ) : R₀) *
        (s.monomial a * s.coordinate j) := by
  rw [← s.monomial_single j, monomial_mul_monomial_comm]

/-! ### The exchanged coordinate -/

/-- The exchanged coordinate `X'_k = M(-e_k + [b_{•k}]_+) + M(-e_k + [-b_{•k}]_+)`. -/
noncomputable def exchangeCoordinate (k : K) : D :=
  s.monomial (exchangeExponentPos row s.exchange.matrix k) +
    s.monomial (exchangeExponentNeg row s.exchange.matrix k)

/-- `X_k X'_k = v^{Λ(e_k,α⁺)} M([b_{•k}]_+) + v^{Λ(e_k,α⁻)} M([-b_{•k}]_+)`, where
`α^± = -e_k + [±b_{•k}]_+` are the exchange exponents. -/
theorem coordinate_mul_exchangeCoordinate_eq (k : K) :
    (s.coordinate (row k) : D) * s.exchangeCoordinate k =
      algebraMap R₀ D ((u₀ ^ matrixForm s.form (Pi.single (row k) 1)
          (exchangeExponentPos row s.exchange.matrix k) : R₀ˣ) : R₀) *
          s.monomial (fun l ↦ positivePart (s.exchange.matrix l k)) +
        algebraMap R₀ D ((u₀ ^ matrixForm s.form (Pi.single (row k) 1)
          (exchangeExponentNeg row s.exchange.matrix k) : R₀ˣ) : R₀) *
          s.monomial (fun l ↦ positivePart (-s.exchange.matrix l k)) := by
  rw [exchangeCoordinate, mul_add, ← s.monomial_single (row k), monomial_mul_monomial,
    monomial_mul_monomial, single_add_exchangeExponentPos, single_add_exchangeExponentNeg]

/-- `X'_k X_k = v^{Λ(α⁺,e_k)} M([b_{•k}]_+) + v^{Λ(α⁻,e_k)} M([-b_{•k}]_+)`, where
`α^± = -e_k + [±b_{•k}]_+` are the exchange exponents. -/
theorem exchangeCoordinate_mul_coordinate_eq (k : K) :
    s.exchangeCoordinate k * s.coordinate (row k) =
      algebraMap R₀ D ((u₀ ^ matrixForm s.form (exchangeExponentPos row s.exchange.matrix k)
          (Pi.single (row k) 1) : R₀ˣ) : R₀) *
          s.monomial (fun l ↦ positivePart (s.exchange.matrix l k)) +
        algebraMap R₀ D ((u₀ ^ matrixForm s.form (exchangeExponentNeg row s.exchange.matrix k)
          (Pi.single (row k) 1) : R₀ˣ) : R₀) *
          s.monomial (fun l ↦ positivePart (-s.exchange.matrix l k)) := by
  rw [exchangeCoordinate, add_mul, ← s.monomial_single, monomial_mul_monomial,
    monomial_mul_monomial, add_comm (exchangeExponentPos _ _ _),
    add_comm (exchangeExponentNeg _ _ _), single_add_exchangeExponentPos,
    single_add_exchangeExponentNeg]

/-! ### The ring of the other coordinates -/

/-- The integral chart ring of the coordinates other than `X_i`. -/
def otherRing (i : M) : Subring D :=
  OneExchange.otherCoordinateRing (algebraMap R₀ D).range (fun j ↦ (s.coordinate j : D)) i

theorem algebraMap_mem_otherRing (i : M) (r : R₀) : algebraMap R₀ D r ∈ s.otherRing i :=
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

theorem conj_mem_otherRing {i : M} {z : D} (hz : z ≠ 0) (w : M → R₀ˣ)
    (hw : ∀ j, j ≠ i → z * s.coordinate j * z⁻¹ = algebraMap R₀ D (w j : R₀) * s.coordinate j)
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
theorem normalizes_otherRing {i : M} {z : D} (hz : z ≠ 0) (w : M → R₀ˣ)
    (hw : ∀ j, j ≠ i →
      z * s.coordinate j = algebraMap R₀ D (w j : R₀) * (s.coordinate j * z)) :
    Normalizes (s.otherRing i) z := by
  refine ⟨hz, fun c hc ↦ s.conj_mem_otherRing hz w (fun j hj ↦ ?_) hc,
    fun c hc ↦ ?_⟩
  · rw [hw j hj, mul_assoc, mul_assoc, mul_inv_cancel₀ hz, mul_one]
  · have h := s.conj_mem_otherRing (inv_ne_zero hz) (fun j ↦ (w j)⁻¹) (fun j hj ↦ ?_) hc
    · simpa using h
    · have hc : Commute (algebraMap R₀ D (w j : R₀)) z⁻¹ := Algebra.commutes _ _
      have h1 : algebraMap R₀ D (w j : R₀) * (z⁻¹ * s.coordinate j * z) = s.coordinate j := by
        calc algebraMap R₀ D (w j : R₀) * (z⁻¹ * s.coordinate j * z)
            = (algebraMap R₀ D (w j : R₀) * z⁻¹) * s.coordinate j * z := by
              simp only [mul_assoc]
          _ = z⁻¹ * (algebraMap R₀ D (w j : R₀) * (s.coordinate j * z)) := by
              rw [hc.eq]; simp only [mul_assoc]
          _ = s.coordinate j := by rw [← hw j hj, ← mul_assoc, inv_mul_cancel₀ hz, one_mul]
      rw [inv_inv]
      conv_rhs => rw [← h1]
      rw [← mul_assoc, ← map_mul, Units.inv_mul, map_one, one_mul]

/-! ### Graded pieces and freeness of `X_i` -/

/-- The `R₀`-span of the normalized monomials with `i`-th exponent `n`. -/
def gradedSpan (i : M) (n : ℤ) : Submodule R₀ D :=
  Submodule.span R₀ (s.monomial '' {a | a i = n})

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
    (Finsupp.mem_span_image_iff_linearCombination R₀).1 (hp n hn)
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
      change algebraMap R₀ D r ∈ s.gradedSpan i 0
      rw [← mul_one (algebraMap R₀ D r), ← Algebra.smul_def, ← s.monomial_zero]
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
    (fun j ↦ u₀ ^ (2 * matrixForm s.form (Pi.single i 1) (Pi.single j 1)))
    (fun j _ ↦ by rw [s.quasiCommuting i j, Algebra.smul_def])

/-- Regroup a faithful chart around one coordinate. -/
theorem chartRing_eq_regroup (i : M) :
    s.chartRing = Laurent.chartRing (s.otherRing i) (fun _ : Unit ↦ (s.coordinate i : D)) :=
  OneExchange.chartRing_regroup _ _ i

end
end ExchangeFrame
end TauCeti.Cluster
