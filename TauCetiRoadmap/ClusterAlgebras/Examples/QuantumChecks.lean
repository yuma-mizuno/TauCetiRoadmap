/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.QuantumAlgebra
public import TauCetiRoadmap.ClusterAlgebras.QuantumSeedSign
public import TauCetiRoadmap.LaurentPhenomenon.Quantum.Ore
public import TauCetiRoadmap.LaurentPhenomenon.Quantum.Specialization

/-!
# Checks of §1.5 and Q1–Q3 on explicit quantum seeds

Every compatible pair `(B_ext, Λ)` has a quantum seed in `Frac T(ℚ(v), v, Λ)`, whose coordinates are
the images of the generators under the faithful integral chart (`integralSeed`). On such seeds:

* §1.5: the principal pair of `B = 0` on `Fin 2` (symmetrizer `(1, 2)`) and on `K` empty is
  alternating with `B_ext_prᵀ Λ_pr = (D_s 0)`, computed entrywise.
* Q1: for `Λ = ((0,-1),(1,0))`, `B_ext = (0,1)ᵀ`, `X_1 X'_1 = 1 + v⁻¹ X_2`, `X'_1 X_1 = 1 + v X_2`,
  both specialize at `v = 1` to `1 + x_2`, and `(X'_1)² = (1 + v X_2)(1 + v³ X_2) X_1^{-2}`.
* Q2: for the principal pair of `B = 0` on `Fin 2` (frozen `X_3, X_4`), `X''_2 = X'_2`, and
  `H_12 = C⟨X_1, X'_1, X_2, X'_2⟩` contains `X'_1 X'_2` but not `X_1⁻¹ X_2⁻¹ (1 + v⁻¹ X_3)`.
  For the principal pairs of `B = ±((0,b),(-c,0))`, `(b,c) ∈ {(1,1),(1,2),(2,1),(1,3),(3,1)}`,
  §0.5's replacement premise holds at `x = X_1`, `z = X_2` with `r = b`, and
  `X''_2 ∈ C⟨X_1, X'_1, X_2, X'_2⟩`.
* Q3: for `K` empty and `J = Fin 1`, `A_{v,∅} = Zv[X_1]` and `A_{v,J} = U_v = Zv[X_1^{±1}]`.
-/

@[expose] public section

namespace TauCeti.Cluster.QuantumChecks

open TauCeti TauCeti.QuantumTorus TauCeti.Laurent Matrix

noncomputable section

/-! ### The integral quantum seed of a compatible pair -/

section IntegralSeed

variable {M K : Type*} [Fintype M] [DecidableEq M] {row : K ↪ M}

/-- The skew field `Frac T(ℚ(v), v, Λ)`. -/
abbrev IntegralField (Λ : Matrix M M ℤ) : Type _ :=
  FractionDivisionRing (FractionRing Zv)
    (Units.map (algebraMap Zv (FractionRing Zv) : Zv →* FractionRing Zv) vUnit) (matrixForm Λ)

/-- The faithful integral chart `T(Zv, v, Λ) → Frac T(ℚ(v), v, Λ)`. -/
abbrev integralChart (Λ : Matrix M M ℤ) :
    quantumTorus Zv vUnit (matrixForm Λ) →ₐ[Zv] IntegralField Λ :=
  QuantumTorus.integralChart Zv (FractionRing Zv) vUnit (matrixForm Λ)

variable {Λ : Matrix M M ℤ} (hΛ : IsAlternatingMatrix Λ)

/-- The images `X_i` of the generators under the integral chart. -/
def integralCoordinate (i : M) : (IntegralField Λ)ˣ :=
  Units.map (integralChart Λ : quantumTorus Zv vUnit (matrixForm Λ) →* IntegralField Λ)
    (monomialUnit hΛ.isAlt (Pi.single i 1))

theorem integralCoordinate_val (i : M) :
    (integralCoordinate hΛ i : IntegralField Λ) = integralChart Λ (monomial (Pi.single i 1)) := by
  simp [integralCoordinate]

theorem integralCoordinate_quasiCommuting :
    IsQuasiCommuting vUnit (matrixForm Λ) (integralCoordinate hΛ) := by
  intro i j
  rw [integralCoordinate_val, integralCoordinate_val, ← map_mul, ← map_mul,
    monomial_mul_monomial_comm hΛ.isAlt, map_smul]

theorem integralChart_eq_lift :
    integralChart Λ = QuantumTorus.lift hΛ.isAlt (integralCoordinate hΛ)
      (integralCoordinate_quasiCommuting hΛ) :=
  eq_lift _ _ _ fun i ↦ (integralCoordinate_val hΛ i).symm

/-- The quantum seed of a compatible pair in `Frac T(ℚ(v), v, Λ)`. -/
def integralSeed (E : ExtendedExchangeMatrix row) (hc : IsCompatiblePair E Λ) :
    QuantumSeed (IntegralField Λ) row where
  exchange := E
  form := Λ
  alternating := hΛ
  compatible := hc
  coordinate := integralCoordinate hΛ
  quasiCommuting := integralCoordinate_quasiCommuting hΛ
  faithful := by
    rw [← integralChart_eq_lift]
    exact integralChart_injective _ _ _ _

theorem integralSeed_chart (E : ExtendedExchangeMatrix row) (hc : IsCompatiblePair E Λ) :
    (integralSeed hΛ E hc).chart = integralChart Λ :=
  (integralChart_eq_lift hΛ).symm

end IntegralSeed

/-! ### Generic computations in a seed -/

section Generic

variable {D : Type*} [DivisionRing D] [Algebra Zv D] {M K : Type*} [Fintype M] [DecidableEq M]
  {row : K ↪ M} (s : QuantumSeed D row)

/-- `v ^ n` in `D`. -/
abbrev vpow (D : Type*) [Ring D] [Algebra Zv D] (n : ℤ) : D :=
  algebraMap Zv D (LaurentPolynomial.T n)

theorem vpow_eq (n : ℤ) : algebraMap Zv D ((vUnit ^ n : Zvˣ) : Zv) = vpow D n := by
  rw [vUnit_zpow_val]

theorem monomial_mul_monomial' (a b : M → ℤ) :
    s.monomial a * s.monomial b = vpow D (matrixForm s.form a b) * s.monomial (a + b) := by
  rw [s.monomial_mul_monomial, vpow_eq]

theorem chart_vpow_smul_monomial (n : ℤ) (a : M → ℤ) :
    s.chart ((LaurentPolynomial.T n : Zv) • (QuantumTorus.monomial a :
      quantumTorus Zv vUnit (matrixForm s.form))) = vpow D n * s.monomial a := by
  rw [map_smul, Algebra.smul_def]
  rfl

theorem commute_coordinate {i j : M} (h : s.form i j = 0) :
    Commute (s.coordinate i : D) (s.coordinate j) := by
  have := s.quasiCommuting i j
  rw [matrixForm_single_single, h, mul_zero, zpow_zero, Units.val_one, one_smul] at this
  exact this

end Generic

/-! ### §1.5: the principal pair of `B = 0` on `Fin 2` and on `K` empty -/

section Principal

/-- The symmetrizer `(1, 2)` of the zero matrix on `Fin 2`. -/
def d₂ : Fin 2 → ℤ := ![1, 2]
/-- The principal form of `B = 0` on `Fin 2`, symmetrizer `(1, 2)`: entrywise
`Λ_pr = ((0, -D), (D, 0))` with `D = diag(1, 2)`. -/
theorem principalPairForm_zero_fin_two (i j : Fin 2 ⊕ Fin 2) :
    principalPairForm (0 : Fin 2 → Fin 2 → ℤ) d₂ i j =
      match i, j with
      | .inl i, .inr j => if i = j then -d₂ i else 0
      | .inr i, .inl j => if i = j then d₂ i else 0
      | _, _ => 0 := by
  rcases i with i | i <;> rcases j with j | j <;> simp

theorem principalPairForm_zero_fin_two_isAlternating :
    IsAlternatingMatrix (principalPairForm (0 : Fin 2 → Fin 2 → ℤ) d₂) := by
  rintro (i | i) (j | j) <;> fin_cases i <;> fin_cases j <;> simp [d₂]

/-- `B_ext_prᵀ Λ_pr = (D_s 0)` for `B = 0` on `Fin 2`, computed entrywise. -/
theorem principalPair_zero_fin_two_compatible :
    (principalPairMatrix (0 : Fin 2 → Fin 2 → ℤ))ᵀ * principalPairForm 0 d₂ =
      compatibilityMatrix (Function.Embedding.inl : Fin 2 ↪ Fin 2 ⊕ Fin 2) d₂ := by
  ext k (l | l) <;> fin_cases k <;> fin_cases l <;>
    simp [Matrix.mul_apply, Fintype.sum_sum_type, compatibilityMatrix, d₂]

/-- For `K` empty the principal pair lives on the empty index type: it is alternating. -/
theorem principalPairForm_empty_isAlternating (B : Empty → Empty → ℤ) (d : Empty → ℤ) :
    IsAlternatingMatrix (principalPairForm B d) := by
  rintro (i | i) <;> exact i.elim

/-- For `K` empty, `B_ext_prᵀ Λ_pr = (D_s 0)` is the equality of empty matrices. -/
theorem principalPair_empty_compatible (B : Empty → Empty → ℤ) (d : Empty → ℤ) :
    (principalPairMatrix B)ᵀ * principalPairForm B d =
      compatibilityMatrix (Function.Embedding.inl : Empty ↪ Empty ⊕ Empty) d := by
  ext k
  exact k.elim

end Principal

/-! ### Q1 on `Λ = ((0,-1),(1,0))`, `B_ext = (0,1)ᵀ` -/

section RankOne

/-- The rank-one principal pair: `B = 0` on `Unit` with symmetrizer `1`. -/
def rankOneExchange : ExtendedExchangeMatrix (Function.Embedding.inl : Unit ↪ Unit ⊕ Unit) :=
  principalExchangeMatrix 0 1 (fun _ ↦ one_pos) (fun _ _ ↦ by simp)

/-- `Λ = ((0,-1),(1,0))` on `Unit ⊕ Unit`. -/
abbrev rankOneForm : Matrix (Unit ⊕ Unit) (Unit ⊕ Unit) ℤ := principalPairForm 0 1

theorem rankOneForm_isAlternating : IsAlternatingMatrix rankOneForm :=
  principalPairForm_isAlternating _ _ fun _ _ ↦ by simp

/-- The rank-one seed in `Frac T(ℚ(v), v, Λ)`. -/
abbrev s₁ : QuantumSeed (IntegralField rankOneForm) (Function.Embedding.inl : Unit ↪ Unit ⊕ Unit) :=
  integralSeed rankOneForm_isAlternating rankOneExchange
    (principalPair_isCompatible 0 1 (fun _ ↦ one_pos) (fun _ _ ↦ by simp))

/-- The data: `Λ = ((0,-1),(1,0))`, `B_ext = (0,1)ᵀ`, symmetrizer `1`. -/
theorem s₁_data :
    s₁.form (Sum.inl ()) (Sum.inl ()) = 0 ∧ s₁.form (Sum.inl ()) (Sum.inr ()) = -1 ∧
      s₁.form (Sum.inr ()) (Sum.inl ()) = 1 ∧ s₁.form (Sum.inr ()) (Sum.inr ()) = 0 ∧
      s₁.exchange.matrix (Sum.inl ()) () = 0 ∧ s₁.exchange.matrix (Sum.inr ()) () = 1 ∧
      s₁.exchange.symmetrizer () = 1 := by
  simp [s₁, integralSeed, rankOneExchange]

local notation "D₁" => IntegralField rankOneForm

/-- `X_1`. -/
abbrev X₁ : D₁ := s₁.coordinate (Sum.inl ())
/-- The frozen `X_2`. -/
abbrev X₂ : D₁ := s₁.coordinate (Sum.inr ())
/-- `X'_1`. -/
abbrev X'₁ : D₁ := s₁.exchangeCoordinate ()

theorem s₁_exchangeExponentPos :
    exchangeExponentPos (Function.Embedding.inl : Unit ↪ Unit ⊕ Unit) s₁.exchange.matrix () =
      -Pi.single (Sum.inl ()) 1 + Pi.single (Sum.inr ()) 1 := by
  funext i
  rcases i with i | i <;> simp [s₁, integralSeed, rankOneExchange, exchangeExponentPos,
    positivePart]

theorem s₁_exchangeExponentNeg :
    exchangeExponentNeg (Function.Embedding.inl : Unit ↪ Unit ⊕ Unit) s₁.exchange.matrix () =
      -Pi.single (Sum.inl ()) 1 := by
  funext i
  rcases i with i | i <;> simp [s₁, integralSeed, rankOneExchange, exchangeExponentNeg,
    positivePart]

/-- `X'_1 = M(-e_1 + e_2) + M(-e_1)`. -/
theorem s₁_exchangeCoordinate :
    X'₁ = s₁.monomial (-Pi.single (Sum.inl ()) 1 + Pi.single (Sum.inr ()) 1) +
      s₁.monomial (-Pi.single (Sum.inl ()) 1) := by
  unfold X'₁ QuantumSeed.exchangeCoordinate
  rw [s₁_exchangeExponentPos, s₁_exchangeExponentNeg]

theorem s₁_form_apply (a b : Unit ⊕ Unit → ℤ) :
    matrixForm s₁.form a b = a (Sum.inr ()) * b (Sum.inl ()) - a (Sum.inl ()) * b (Sum.inr ()) := by
  simp [matrixForm_eq_sum, Fintype.sum_sum_type, s₁, integralSeed]
  ring

theorem s₁_coordinate_mul_monomial (a : Unit ⊕ Unit → ℤ) :
    X₁ * s₁.monomial a =
      vpow D₁ (-a (Sum.inr ())) * s₁.monomial (Pi.single (Sum.inl ()) 1 + a) := by
  unfold X₁
  rw [← s₁.monomial_single, monomial_mul_monomial', s₁_form_apply]
  simp

theorem s₁_monomial_mul_coordinate (a : Unit ⊕ Unit → ℤ) :
    s₁.monomial a * X₁ = vpow D₁ (a (Sum.inr ())) * s₁.monomial (a + Pi.single (Sum.inl ()) 1) := by
  unfold X₁
  rw [← s₁.monomial_single, monomial_mul_monomial', s₁_form_apply]
  simp

theorem vpow_zero {D : Type*} [Ring D] [Algebra Zv D] : vpow D 0 = 1 := by
  rw [vpow, LaurentPolynomial.T_zero, map_one]

/-- **Q1 check.** `X_1 X'_1 = 1 + v⁻¹ X_2`. -/
theorem s₁_coordinate_mul_exchangeCoordinate : X₁ * X'₁ = 1 + vpow D₁ (-1) * X₂ := by
  have h₁ : (-Pi.single (Sum.inl ()) 1 + Pi.single (Sum.inr ()) 1 : Unit ⊕ Unit → ℤ)
      (Sum.inr ()) = 1 := by simp
  have h₀ : (-Pi.single (Sum.inl ()) 1 : Unit ⊕ Unit → ℤ) (Sum.inr ()) = 0 := by simp
  rw [s₁_exchangeCoordinate, mul_add, s₁_coordinate_mul_monomial, s₁_coordinate_mul_monomial,
    add_neg_cancel_left, add_neg_cancel, QuantumSeed.monomial_zero, QuantumSeed.monomial_single,
    h₁, h₀, neg_zero, vpow_zero, mul_one, add_comm]

/-- **Q1 check.** `X'_1 X_1 = 1 + v X_2`. -/
theorem s₁_exchangeCoordinate_mul_coordinate : X'₁ * X₁ = 1 + vpow D₁ 1 * X₂ := by
  have h₁ : (-Pi.single (Sum.inl ()) 1 + Pi.single (Sum.inr ()) 1 : Unit ⊕ Unit → ℤ)
      (Sum.inr ()) = 1 := by simp
  have h₀ : (-Pi.single (Sum.inl ()) 1 : Unit ⊕ Unit → ℤ) (Sum.inr ()) = 0 := by simp
  have hs : (-Pi.single (Sum.inl ()) 1 + Pi.single (Sum.inr ()) 1 + Pi.single (Sum.inl ()) 1 :
      Unit ⊕ Unit → ℤ) = Pi.single (Sum.inr ()) 1 := by abel
  rw [s₁_exchangeCoordinate, add_mul, s₁_monomial_mul_coordinate, s₁_monomial_mul_coordinate, hs,
    neg_add_cancel, QuantumSeed.monomial_zero, QuantumSeed.monomial_single, h₁, h₀, vpow_zero,
    mul_one, add_comm]

/-- The torus `T(Zv, v, Λ)` of the rank-one seed. -/
abbrev T₁ : Type _ := quantumTorus Zv vUnit (matrixForm s₁.form)

/-- The exponent `e_2` of the frozen variable. -/
abbrev e₂ : Unit ⊕ Unit → ℤ := Pi.single (Sum.inr ()) 1

/-- **Q1 check.** `X_1 X'_1` is the image of `1 + v⁻¹ X^{e_2}`, whose classical limit is
`1 + x^{e_2}`. -/
theorem s₁_coordinate_mul_exchangeCoordinate_sp :
    s₁.chart (1 + (LaurentPolynomial.T (-1) : Zv) • (monomial e₂ : T₁)) = X₁ * X'₁ ∧
      sp _ (1 + (LaurentPolynomial.T (-1) : Zv) • (monomial e₂ : T₁)) =
        1 + AddMonoidAlgebra.single e₂ 1 := by
  refine ⟨?_, ?_⟩
  · rw [map_add, map_one, chart_vpow_smul_monomial, QuantumSeed.monomial_single,
      s₁_coordinate_mul_exchangeCoordinate]
  · rw [map_add, map_one, sp_smul_monomial, evalOne_T]

/-- **Q1 check.** `X'_1 X_1` is the image of `1 + v X^{e_2}`, whose classical limit is
`1 + x^{e_2}`. -/
theorem s₁_exchangeCoordinate_mul_coordinate_sp :
    s₁.chart (1 + (LaurentPolynomial.T 1 : Zv) • (monomial e₂ : T₁)) = X'₁ * X₁ ∧
      sp _ (1 + (LaurentPolynomial.T 1 : Zv) • (monomial e₂ : T₁)) =
        1 + AddMonoidAlgebra.single e₂ 1 := by
  refine ⟨?_, ?_⟩
  · rw [map_add, map_one, chart_vpow_smul_monomial, QuantumSeed.monomial_single,
      s₁_exchangeCoordinate_mul_coordinate]
  · rw [map_add, map_one, sp_smul_monomial, evalOne_T]

/-- **Q1 check.** `(X'_1)² = (1 + v X_2)(1 + v³ X_2) X_1^{-2}`, through Q1's
`(X'_k) ^ r = P_{k,r} M(-e_k + [-b_{•k}]_+) ^ r`. -/
theorem s₁_exchangeCoordinate_sq :
    X'₁ ^ 2 = (1 + vpow D₁ 1 * X₂) * (1 + vpow D₁ 3 * X₂) * X₁ ^ (-2 : ℤ) := by
  have hcol : (fun l ↦ s₁.exchange.matrix l ()) = Pi.single (Sum.inr ()) 1 := by
    funext l
    rcases l with l | l <;> simp [s₁, integralSeed, rankOneExchange]
  rw [s₁.exchangeCoordinate_pow, s₁_exchangeExponentNeg, QuantumSeed.monomial_neg_single,
    QuantumSeed.centralProduct]
  simp only [List.range_succ, List.range_zero, List.nil_append, mul_one,
    QuantumSeed.binomialFactor, hcol,
    QuantumSeed.monomial_single, vpow_eq, s₁_data]
  norm_num

end RankOne

/-! ### Q2 for the principal pair of `B = 0` on `Fin 2` -/

section ZeroRankTwo

/-- An evaluation `T(Zv, v, Λ) → ℤ`: the classical limit followed by `x_j ↦ -1` and `x_i ↦ 1` for
`i ≠ j`. -/
def signEval {M : Type*} [Fintype M] [DecidableEq M] (Λ : Matrix M M ℤ) (j : M) :
    quantumTorus Zv vUnit (matrixForm Λ) →+* ℤ :=
  (AddMonoidAlgebra.lift ℤ ℤ (M → ℤ)
    ((Units.coeHom ℤ).comp ((zpowersHom ℤˣ (-1)).comp
      (AddMonoidHom.toMultiplicative (Pi.evalAddMonoidHom (fun _ : M ↦ ℤ) j))))).toRingHom.comp
    (sp (matrixForm Λ))

theorem signEval_smul_monomial {M : Type*} [Fintype M] [DecidableEq M] (Λ : Matrix M M ℤ)
    (j : M) (n : ℤ) (a : M → ℤ) :
    signEval Λ j ((LaurentPolynomial.T n : Zv) • monomial a) = (((-1 : ℤˣ) ^ a j : ℤˣ) : ℤ) := by
  simp [signEval, AddMonoidAlgebra.lift_single]

theorem signEval_monomial {M : Type*} [Fintype M] [DecidableEq M] (Λ : Matrix M M ℤ)
    (j : M) (a : M → ℤ) :
    signEval Λ j (monomial a) = (((-1 : ℤˣ) ^ a j : ℤˣ) : ℤ) := by
  simpa using signEval_smul_monomial Λ j 0 a

/-- The principal pair of `B = 0` on `Fin 2` with symmetrizer `1`. -/
def zeroExchange : ExtendedExchangeMatrix (Function.Embedding.inl : Fin 2 ↪ Fin 2 ⊕ Fin 2) :=
  principalExchangeMatrix 0 1 (fun _ ↦ one_pos) (fun _ _ ↦ by simp)

/-- `Λ_pr = ((0, -1), (1, 0))` in blocks of size two. -/
abbrev zeroForm : Matrix (Fin 2 ⊕ Fin 2) (Fin 2 ⊕ Fin 2) ℤ := principalPairForm 0 1

theorem zeroForm_isAlternating : IsAlternatingMatrix zeroForm :=
  principalPairForm_isAlternating _ _ fun _ _ ↦ by simp

/-- The principal seed of `B = 0` on `Fin 2`: `X_1 = X_{inl 0}`, `X_2 = X_{inl 1}` mutable and
`X_3 = X_{inr 0}`, `X_4 = X_{inr 1}` frozen. -/
abbrev s₂ : QuantumSeed (IntegralField zeroForm) (Function.Embedding.inl : Fin 2 ↪ Fin 2 ⊕ Fin 2) :=
  integralSeed zeroForm_isAlternating zeroExchange
    (principalPair_isCompatible 0 1 (fun _ ↦ one_pos) (fun _ _ ↦ by simp))

local notation "D₂" => IntegralField zeroForm

/-- The coordinate `X_a` of `s₂`. -/
abbrev Y (a : Fin 2 ⊕ Fin 2) : D₂ := s₂.coordinate a

theorem s₂_matrix (a : Fin 2 ⊕ Fin 2) (k : Fin 2) :
    s₂.exchange.matrix a k = match a with
      | .inl _ => 0
      | .inr i => if i = k then 1 else 0 := by
  rcases a with a | a <;> simp [s₂, integralSeed, zeroExchange]

/-- **Q2 check.** `b_12 = 0`, so `X''_2 = X'_2`. -/
theorem s₂_mutate_exchangeCoordinate :
    (s₂.mutate 0).exchangeCoordinate 1 = s₂.exchangeCoordinate 1 :=
  s₂.mutate_exchangeCoordinate_of_eq_zero (by decide) (by simp [s₂_matrix])

/-- **Q2 check.** `(T_s ∩ T_{μ_1 s}) ∩ (T_s ∩ T_{μ_2 s}) = H_12 = C⟨X_1, X'_1, X_2, X'_2⟩`. -/
theorem s₂_inf_eq_fourRing :
    (s₂.chartRing ⊓ (s₂.mutate 0).chartRing) ⊓ (s₂.chartRing ⊓ (s₂.mutate 1).chartRing) =
      s₂.fourRing 0 1 :=
  s₂.inf_mutate_inf_inf_mutate_eq_fourRing_of_eq_zero (by decide) (by simp [s₂_matrix])

/-- **Q2 check.** `X'_1 X'_2 ∈ H_12`. -/
theorem s₂_exchangeCoordinate_mul_mem_fourRing :
    s₂.exchangeCoordinate 0 * s₂.exchangeCoordinate 1 ∈ s₂.fourRing 0 1 :=
  mul_mem (UpperBound.generator_mem_generated _ _ (by simp))
    (UpperBound.generator_mem_generated _ _ (by simp))

theorem s₂_form_inl_one_inr_zero : s₂.form (Sum.inl 1) (Sum.inr 0) = 0 := by
  simp [s₂, integralSeed]

/-- The coefficient `X_1⁻¹ (1 + v⁻¹ X_3)` of the non-member at `X_2^{-1}`. -/
abbrev c₀ : D₂ := (Y (Sum.inl 0))⁻¹ * (1 + vpow D₂ (-1) * Y (Sum.inr 0))

theorem c₀_mem_otherRing : c₀ ∈ s₂.otherRing (Sum.inl 1) := by
  refine mul_mem ?_ (add_mem (one_mem _) (mul_mem (s₂.algebraMap_mem_otherRing _ _) ?_))
  · rw [Y, ← QuantumSeed.monomial_neg_single]
    exact s₂.monomial_mem_otherRing (by simp)
  · rw [Y, ← QuantumSeed.monomial_single]
    exact s₂.monomial_mem_otherRing (by simp)

theorem c₀_eq_chart : c₀ =
    s₂.chart (monomial (-Pi.single (Sum.inl 0) 1) *
      (1 + (LaurentPolynomial.T (-1) : Zv) • monomial (Pi.single (Sum.inr 0) 1))) := by
  rw [map_mul, map_add, map_one, chart_vpow_smul_monomial, QuantumSeed.monomial_single]
  exact congrArg (· * _) (s₂.monomial_neg_single _).symm

/-- `P_{2,1} = 1 + v X_4`, as the image of `1 + v X^{e_4}`. -/
theorem s₂_centralProduct_one :
    s₂.centralProduct 1 1 =
      s₂.chart (1 + (LaurentPolynomial.T 1 : Zv) • monomial (Pi.single (Sum.inr 1) 1)) := by
  have hcol : (fun l ↦ s₂.exchange.matrix l 1) = Pi.single (Sum.inr 1) 1 := by
    funext l
    rcases l with l | l <;> fin_cases l <;> simp [s₂_matrix]
  rw [map_add, map_one, chart_vpow_smul_monomial, QuantumSeed.centralProduct]
  simp only [List.range_one, List.map_cons, List.map_nil, List.prod_cons, List.prod_nil,
    mul_one, QuantumSeed.binomialFactor, hcol, vpow_eq]
  simp [s₂, integralSeed, zeroExchange]

/-- In the integral torus, `X^{-e_1}(1 + v⁻¹ X^{e_3})` is not a left multiple of `1 + v X^{e_4}`:
the evaluation `v, X_1, X_2, X_3 ↦ 1`, `X_4 ↦ -1` sends them to `2` and `0`. -/
theorem not_dvd_torus (c' : quantumTorus Zv vUnit (matrixForm s₂.form)) :
    (monomial (-Pi.single (Sum.inl 0) 1) *
      (1 + (LaurentPolynomial.T (-1) : Zv) • monomial (Pi.single (Sum.inr 0) 1)) :
        quantumTorus Zv vUnit (matrixForm s₂.form)) ≠
      c' * (1 + (LaurentPolynomial.T 1 : Zv) • monomial (Pi.single (Sum.inr 1) 1)) := by
  intro h
  have h := congrArg (signEval s₂.form (Sum.inr 1)) h
  simp only [map_mul, map_add, map_one, signEval_monomial, signEval_smul_monomial] at h
  norm_num at h

theorem s₂_nonMember_eq :
    (Y (Sum.inl 0))⁻¹ * (Y (Sum.inl 1))⁻¹ * (1 + vpow D₂ (-1) * Y (Sum.inr 0)) =
      SkewExchange.expand (Y (Sum.inl 1)) (Finsupp.single (-1) c₀) := by
  have hcomm : Commute (Y (Sum.inl 1))⁻¹ (1 + vpow D₂ (-1) * Y (Sum.inr 0)) :=
    Commute.inv_left₀ (Commute.add_right (Commute.one_right _)
      (Commute.mul_right (Algebra.commutes _ _).symm
        (commute_coordinate s₂ s₂_form_inl_one_inr_zero)))
  rw [SkewExchange.expand_single, zpow_neg_one, c₀, mul_assoc, hcomm.eq, ← mul_assoc]

theorem s₂_nonMember_coeff :
    SkewExchange.coeff (s₂.otherRing ((Function.Embedding.inl : Fin 2 ↪ Fin 2 ⊕ Fin 2) 1))
      (s₂.coordinate ((Function.Embedding.inl : Fin 2 ↪ Fin 2 ⊕ Fin 2) 1) : D₂)
      ((Y (Sum.inl 0))⁻¹ * (Y (Sum.inl 1))⁻¹ * (1 + vpow D₂ (-1) * Y (Sum.inr 0)))
      (-((1 : ℕ) : ℤ)) = c₀ := by
  rw [s₂_nonMember_eq]
  have key := SkewExchange.coeff_expand (s₂.exchangeData 1).x_leftFree
    (fun m ↦ SkewExchange.single_mem c₀_mem_otherRing (-1) m)
  exact (DFunLike.congr_fun key _).trans (by simp)

/-- **Q2 check.** `X_1⁻¹ X_2⁻¹ (1 + v⁻¹ X_3) ∉ H_12`. It lies in `T_s`, and Q1's criterion at
`k = 2` would make its coefficient `X_1⁻¹ (1 + v⁻¹ X_3)` at `X_2^{-1}` a left multiple of
`P_{2,1} = 1 + v X_4` in `T_s` (`not_dvd_torus`). -/
theorem s₂_not_mem_fourRing :
    (Y (Sum.inl 0))⁻¹ * (Y (Sum.inl 1))⁻¹ * (1 + vpow D₂ (-1) * Y (Sum.inr 0)) ∉
      s₂.fourRing 0 1 := by
  intro hg
  rw [s₂.fourRing_comm] at hg
  obtain ⟨hgs, hg1⟩ := Subring.mem_inf.1 (s₂.fourRing_le_inf_mutate (by decide) hg)
  obtain ⟨c, hc, hce⟩ := (s₂.mem_mutate_chartRing_iff 1 hgs).1 hg1 1 one_pos
  rw [s₂_nonMember_coeff] at hce
  have hcs : c ∈ s₂.chartRing :=
    s₂.chartRing_eq_regroup _ ▸ coefficient_mem_chartRing _ _ hc
  rw [← s₂.range_chart] at hcs
  obtain ⟨c', rfl⟩ := hcs
  rw [c₀_eq_chart, s₂_centralProduct_one] at hce
  exact not_dvd_torus c' (s₂.chart_injective (hce.trans (map_mul s₂.chart c' _).symm))

end ZeroRankTwo

/-! ### Q2's replacement for `B = ±((0,b),(-c,0))` -/

section RankTwo

/-- The sign `ε = ±1` of `B = ε((0,b),(-c,0))`: `-1` for `true`. -/
def rankTwoSign (neg : Bool) : ℤ := if neg then -1 else 1
/-- `B = ε((0,b),(-c,0))`. -/
def rankTwoMatrix (neg : Bool) (b c : ℕ) : Fin 2 → Fin 2 → ℤ :=
  fun i j ↦ rankTwoSign neg * !![0, (b : ℤ); -c, 0] i j

/-- The symmetrizer `(c, b)`. -/
def rankTwoSymmetrizer (b c : ℕ) : Fin 2 → ℤ := ![c, b]
theorem rankTwo_symmetrized (ε : Bool) (b c : ℕ) (i j : Fin 2) :
    rankTwoSymmetrizer b c i * rankTwoMatrix ε b c i j =
      -(rankTwoSymmetrizer b c j * rankTwoMatrix ε b c j i) := by
  fin_cases i <;> fin_cases j <;> simp [rankTwoSymmetrizer, rankTwoMatrix] <;> ring

variable {b c : ℕ} (hb : 0 < b) (hc : 0 < c)

include hb hc in
theorem rankTwoSymmetrizer_pos (i : Fin 2) : 0 < rankTwoSymmetrizer b c i := by
  fin_cases i <;> simp [rankTwoSymmetrizer, hb, hc]

/-- The principal pair of `B = ε((0,b),(-c,0))`. -/
def rankTwoExchange (ε : Bool) :
    ExtendedExchangeMatrix (Function.Embedding.inl : Fin 2 ↪ Fin 2 ⊕ Fin 2) :=
  principalExchangeMatrix (rankTwoMatrix ε b c) (rankTwoSymmetrizer b c)
    (rankTwoSymmetrizer_pos hb hc) (rankTwo_symmetrized ε b c)

/-- The principal seed of `B = ε((0,b),(-c,0))`. -/
abbrev rankTwoSeed (ε : Bool) :
    QuantumSeed (IntegralField (principalPairForm (rankTwoMatrix ε b c) (rankTwoSymmetrizer b c)))
      (Function.Embedding.inl : Fin 2 ↪ Fin 2 ⊕ Fin 2) :=
  integralSeed (principalPairForm_isAlternating _ _ (rankTwo_symmetrized ε b c))
    (rankTwoExchange hb hc ε)
    (principalPair_isCompatible _ _ (rankTwoSymmetrizer_pos hb hc) (rankTwo_symmetrized ε b c))

local notation "ι" => (Function.Embedding.inl : Fin 2 ↪ Fin 2 ⊕ Fin 2)

theorem rankTwoSeed_b₁₂ (ε : Bool) :
    (rankTwoSeed hb hc ε).exchange.matrix (ι 0) 1 = rankTwoSign ε * b := by
  simp [rankTwoSeed, integralSeed, rankTwoExchange, rankTwoMatrix]

omit hb hc

/-- The constructed finite replacement premise and membership for a pos interaction. -/
theorem replacement_check_pos {D : Type*} [DivisionRing D] [Algebra Zv D] (s : QuantumSeed D ι)
    {b : ℕ} (hb : 0 < b) (h : s.exchange.matrix (ι 0) 1 = b) :
    let p := s.polynomialSeed
    FiniteReplacementPremise (p.toQuantumSeed.pairRing (ι 0) (ι 1))
      (p.coordinate (ι 0)) (p.exchangeCoordinate 0) (p.coordinate (ι 1))
      (p.exchangeCoordinate 1) ((p.mutate 0).exchangeCoordinate 1)
      (p.replacementMutatedCoefficient 0 1 0 * (p.replacementCoefficient 0 1 0)⁻¹)
      (p.replacementCoefficient 0 1 0) (p.replacementMutatedCoefficient 0 1 0)
      ((Finset.range (p.degree 1 + 1)).erase 0) (p.replacementDegree 0 1)
      (p.replacementExponent 0 1) (p.replacementCoefficient 0 1)
      (p.replacementMutatedCoefficient 0 1) (p.replacementConstant 0 1) ∧
      (s.mutate 0).exchangeCoordinate 1 ∈ s.fourRing 0 1 := by
  dsimp only
  refine ⟨(s.polynomialSeed).finiteReplacement_pos (i := 0) (j := 1) (by decide) ?_, ?_⟩
  · change 0 < s.exchange.matrix (ι 0) 1
    rw [h]
    omega
  · exact UpperBound.generated_mono _ (by rintro z (rfl | rfl | rfl) <;> simp)
      (s.replacement_mem (i := 0) (j := 1) (by decide))

/-- The constructed finite replacement premise and membership for a neg interaction. -/
theorem replacement_check_neg {D : Type*} [DivisionRing D] [Algebra Zv D] (s : QuantumSeed D ι)
    {b : ℕ} (hb : 0 < b) (h : s.exchange.matrix (ι 0) 1 = -b) :
    let p := s.polynomialSeed.opposite
    FiniteReplacementPremise (p.toQuantumSeed.pairRing (ι 0) (ι 1))
      (p.coordinate (ι 0)) (p.exchangeCoordinate 0) (p.coordinate (ι 1))
      (p.exchangeCoordinate 1) ((p.mutate 0).exchangeCoordinate 1)
      (p.replacementMutatedCoefficient 0 1 0 * (p.replacementCoefficient 0 1 0)⁻¹)
      (p.replacementCoefficient 0 1 0) (p.replacementMutatedCoefficient 0 1 0)
      ((Finset.range (p.degree 1 + 1)).erase 0) (p.replacementDegree 0 1)
      (p.replacementExponent 0 1) (p.replacementCoefficient 0 1)
      (p.replacementMutatedCoefficient 0 1) (p.replacementConstant 0 1) ∧
      (s.mutate 0).exchangeCoordinate 1 ∈ s.fourRing 0 1 := by
  dsimp only
  refine ⟨(s.polynomialSeed.opposite).finiteReplacement_pos (i := 0) (j := 1) (by decide) ?_, ?_⟩
  · change 0 < -s.exchange.matrix (ι 0) 1
    rw [h]
    omega
  · exact UpperBound.generated_mono _ (by rintro z (rfl | rfl | rfl) <;> simp)
      (s.replacement_mem (i := 0) (j := 1) (by decide))

/-! The ten principal seeds `B = ±((0,b),(-c,0))`, `(b,c) = (1,1),(1,2),(2,1),(1,3),(3,1)`. -/

example := replacement_check_pos (rankTwoSeed (b := 1) (c := 1) one_pos one_pos false) one_pos
  (by rw [rankTwoSeed_b₁₂]; norm_num [rankTwoSign])
example := replacement_check_pos (rankTwoSeed (b := 1) (c := 2) one_pos two_pos false) one_pos
  (by rw [rankTwoSeed_b₁₂]; norm_num [rankTwoSign])
example := replacement_check_pos (rankTwoSeed (b := 2) (c := 1) two_pos one_pos false) two_pos
  (by rw [rankTwoSeed_b₁₂]; norm_num [rankTwoSign])
example := replacement_check_pos (rankTwoSeed (b := 1) (c := 3) one_pos three_pos false) one_pos
  (by rw [rankTwoSeed_b₁₂]; norm_num [rankTwoSign])
example := replacement_check_pos (rankTwoSeed (b := 3) (c := 1) three_pos one_pos false) three_pos
  (by rw [rankTwoSeed_b₁₂]; norm_num [rankTwoSign])
example := replacement_check_neg (rankTwoSeed (b := 1) (c := 1) one_pos one_pos true) one_pos
  (by rw [rankTwoSeed_b₁₂]; norm_num [rankTwoSign])
example := replacement_check_neg (rankTwoSeed (b := 1) (c := 2) one_pos two_pos true) one_pos
  (by rw [rankTwoSeed_b₁₂]; norm_num [rankTwoSign])
example := replacement_check_neg (rankTwoSeed (b := 2) (c := 1) two_pos one_pos true) two_pos
  (by rw [rankTwoSeed_b₁₂]; norm_num [rankTwoSign])
example := replacement_check_neg (rankTwoSeed (b := 1) (c := 3) one_pos three_pos true) one_pos
  (by rw [rankTwoSeed_b₁₂]; norm_num [rankTwoSign])
example := replacement_check_neg (rankTwoSeed (b := 3) (c := 1) three_pos one_pos true) three_pos
  (by rw [rankTwoSeed_b₁₂]; norm_num [rankTwoSign])

end RankTwo

/-! ### Q3 for `K` empty and `J = Fin 1` -/

section Frozen

/-- No mutable index: `Empty ↪ Fin 1`. -/
def frozenRow : Empty ↪ Fin 1 := ⟨Empty.elim, fun a ↦ a.elim⟩
/-- The empty extended exchange matrix on `J = Fin 1`. -/
def frozenExchange : ExtendedExchangeMatrix frozenRow where
  matrix := fun _ k ↦ k.elim
  symmetrizer := fun k ↦ k.elim
  symmetrizer_pos := fun k ↦ k.elim
  symmetrized := fun i ↦ i.elim

theorem frozenForm_isAlternating : IsAlternatingMatrix (0 : Matrix (Fin 1) (Fin 1) ℤ) := by
  intro i j
  simp

/-- The quantum seed with one frozen variable `X_1` and no mutable variable, `Λ = 0`. -/
abbrev s₀ : QuantumSeed (IntegralField (0 : Matrix (Fin 1) (Fin 1) ℤ)) frozenRow :=
  integralSeed frozenForm_isAlternating frozenExchange fun k ↦ k.elim

local notation "D₀" => IntegralField (0 : Matrix (Fin 1) (Fin 1) ℤ)

/-- The frozen variable `X_1`. -/
abbrev X₀ : D₀ := s₀.coordinate 0

theorem s₀_clusterVariables : s₀.clusterVariables = ∅ := by
  ext x
  simp [QuantumSeed.clusterVariables]

theorem s₀_range_row_compl : (Set.range frozenRow)ᶜ = Set.univ := by
  ext j
  simp [frozenRow]

theorem s₀_coordinate_image_univ : (fun j ↦ (s₀.coordinate j : D₀)) '' Set.univ = {X₀} := by
  ext x
  simp only [Set.image_univ, Set.mem_range, Set.mem_singleton_iff, Fin.exists_fin_one]
  exact eq_comm

/-- **Q3 check.** `A_{v,∅} = Zv[X_1]`. -/
theorem s₀_clusterAlgebra_empty : s₀.clusterAlgebra ∅ = Algebra.adjoin Zv {X₀} := by
  rw [QuantumSeed.clusterAlgebra, QuantumSeed.clusterGenerators, s₀_clusterVariables,
    s₀_range_row_compl, s₀_coordinate_image_univ, Set.image_empty, Set.union_empty,
    Set.empty_union]

/-- **Q3 check.** `A_{v,J} = Zv[X_1^{±1}]`. -/
theorem s₀_clusterAlgebra_univ :
    s₀.clusterAlgebra Set.univ = Algebra.adjoin Zv {X₀, X₀⁻¹} := by
  have hinv : (fun j ↦ (s₀.coordinate j : D₀)⁻¹) '' Set.univ = {X₀⁻¹} := by
    ext x
    simp only [Set.image_univ, Set.mem_range, Set.mem_singleton_iff, Fin.exists_fin_one]
    exact eq_comm
  rw [QuantumSeed.clusterAlgebra, QuantumSeed.clusterGenerators, s₀_clusterVariables,
    s₀_range_row_compl, s₀_coordinate_image_univ, hinv, Set.empty_union, Set.singleton_union,
    Set.pair_comm, Set.insert_eq, Set.union_comm, ← Set.insert_eq, Set.pair_comm]

theorem s₀_chartAlgebra : s₀.chartAlgebra = Algebra.adjoin Zv {X₀, X₀⁻¹} := by
  apply Subalgebra.toSubring_injective
  rw [QuantumSeed.toSubring_chartAlgebra, Algebra.adjoin_eq_ring_closure, QuantumSeed.chartRing,
    Laurent.chartRing]
  congr 1
  ext x
  simp only [Set.mem_union, SetLike.mem_coe, RingHom.mem_range, Set.mem_range,
    Set.mem_insert_iff, Set.mem_singleton_iff, Fin.exists_fin_one]
  rw [eq_comm (a := (s₀.coordinate 0 : D₀)), eq_comm (a := (s₀.coordinate 0 : D₀)⁻¹)]
  tauto

/-- **Q3 check.** `U_v = Zv[X_1^{±1}]`: the only reachable seed is `s₀`. -/
theorem s₀_upperAlgebra : s₀.upperAlgebra = Algebra.adjoin Zv {X₀, X₀⁻¹} := by
  rw [← s₀_chartAlgebra, QuantumSeed.upperAlgebra]
  refine le_antisymm (iInf_le_of_le [] le_rfl) (le_iInf fun w ↦ ?_)
  cases w with
  | nil => exact le_rfl
  | cons k _ => exact k.elim

/-- **Q3 check.** `A_{v,J} = U_v`. -/
theorem s₀_clusterAlgebra_univ_eq_upperAlgebra :
    s₀.clusterAlgebra Set.univ = s₀.upperAlgebra := by
  rw [s₀_clusterAlgebra_univ, s₀_upperAlgebra]

end Frozen

end

end TauCeti.Cluster.QuantumChecks
