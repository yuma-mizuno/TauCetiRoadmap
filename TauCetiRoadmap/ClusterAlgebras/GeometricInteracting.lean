/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.GeometricExchangePair
public import TauCetiRoadmap.ClusterAlgebras.GeometricSeed

/-! The interacting three-chart comparison for genuine geometric mutations, for coefficients
inside a field over which the coordinates are algebraically independent (`R_J` and `𝕜_J`). -/

@[expose] public section

noncomputable section
namespace TauCeti.Cluster.UpperBound

open TauCeti.Laurent TauCeti.Laurent.OneExchange


variable {F M K : Type*} [Field F] [Fintype M] [DecidableEq M]
  [Fintype K] [DecidableEq K] [Algebra ℚ F]

/-- The nonzero coordinates of an algebraically independent geometric seed, packaged as units. -/
def seedCoordinateUnits {row : K ↪ M} {d : K → ℤ}
    (s : TauCeti.Cluster.GeometricSeed (F := F) row d) : M → Fˣ :=
  fun a ↦ Units.mk0 (s.coordinate a)
    (TauCeti.Cluster.nonzero_coordinate_of_algebraicIndependent
      s.coordinate s.independent a)

omit [DecidableEq K] [DecidableEq M] [Fintype K] [Fintype M] in
@[simp] theorem seedCoordinateUnits_val {row : K ↪ M} {d : K → ℤ}
    (s : TauCeti.Cluster.GeometricSeed (F := F) row d) (a : M) :
    (seedCoordinateUnits s a : F) = s.coordinate a := by
  simp [seedCoordinateUnits]

omit [Algebra ℚ F] [DecidableEq M] [Fintype M] in
theorem pairComplementRing_swap (C : Subring F) (x : M → F)
    (i j : M) :
    pairComplementRing C x i j = pairComplementRing C x j i := by
  apply le_antisymm <;> apply chartRing_le
  · intro a ha
    exact coefficient_mem_chartRing C _ ha
  · intro a
    exact coordinate_mem_chartRing C
      (fun b : {b : M // b ≠ j ∧ b ≠ i} => x b)
      ⟨a, a.property.2, a.property.1⟩
  · intro a
    exact inverse_mem_chartRing C
      (fun b : {b : M // b ≠ j ∧ b ≠ i} => x b)
      ⟨a, a.property.2, a.property.1⟩
  · intro a ha
    exact coefficient_mem_chartRing C _ ha
  · intro a
    exact coordinate_mem_chartRing C
      (fun b : {b : M // b ≠ i ∧ b ≠ j} => x b)
      ⟨a, a.property.2, a.property.1⟩
  · intro a
    exact inverse_mem_chartRing C
      (fun b : {b : M // b ≠ i ∧ b ≠ j} => x b)
      ⟨a, a.property.2, a.property.1⟩

/-- Exchange the order of the two excluded indices without changing any remaining index. -/
def pairComplementSwapEquiv (i j : M) :
    {a : M // a ≠ i ∧ a ≠ j} ≃ {a : M // a ≠ j ∧ a ≠ i} where
  toFun a := ⟨a, a.property.2, a.property.1⟩
  invFun a := ⟨a, a.property.2, a.property.1⟩
  left_inv a := by cases a; rfl
  right_inv a := by cases a; rfl

omit [Algebra ℚ F] in
theorem pairCoefficient_swap_val (C : Subring F) (x : M → Fˣ)
    (i j : M) (b : M → ℤ) (σ : ℤ) :
    ((pairCoefficient C x i j b σ : pairComplementRing C (fun m => (x m : F)) i j) : F) =
      ((pairCoefficient C x j i b σ : pairComplementRing C (fun m => (x m : F)) j i) : F) := by
  rw [pairCoefficient_val, pairCoefficient_val]
  apply Fintype.prod_equiv (pairComplementSwapEquiv i j)
  intro a
  rfl

omit [Fintype K] in
theorem geometric_exchange_first [Finite K] (C : Subring F) (row : K ↪ M) (d : K → ℤ)
    (hd : ∀ k, 0 < d k)
    (s : TauCeti.Cluster.GeometricSeed (F := F) row d)
    (i j : K) (hij : i ≠ j) (σ : ℤ) (c : ℕ)
    (hσ : σ = 1 ∨ σ = -1)
    (hji : s.exchange (row j) i = σ * (c : ℤ)) :
    s.coordinate (row i) * (s.mutate hd i).coordinate (row i) =
      unitValue (pairComplementRing C (fun m => (seedCoordinateUnits s m : F)) (row i) (row j))
        (pairCoefficient C (seedCoordinateUnits s) (row i) (row j)
          (fun a ↦ s.exchange a i) σ) * s.coordinate (row j) ^ c +
      unitValue (pairComplementRing C (fun m => (seedCoordinateUnits s m : F)) (row i) (row j))
        (pairCoefficient C (seedCoordinateUnits s) (row i) (row j)
          (fun a ↦ s.exchange a i) (-σ)) := by
  let : Fintype K := Fintype.ofFinite K
  have hri : row i ≠ row j := row.injective.ne hij
  have hx : s.coordinate (row i) ≠ 0 :=
    TauCeti.Cluster.nonzero_coordinate_of_algebraicIndependent
      s.coordinate s.independent (row i)
  have hP := geometricExchangePolynomial_pair C (seedCoordinateUnits s)
    s.exchange i (row i) (row j) hri (s.diagonal hd i) σ c hσ hji
  have hmut : (s.mutate hd i).coordinate (row i) =
      MvPolynomial.aeval s.coordinate (geometricExchangePolynomial s.exchange i) /
        s.coordinate (row i) := by
    simp [TauCeti.Cluster.GeometricSeed.mutate,
      TauCeti.Cluster.geometricMutationCoordinates]
  rw [hmut]
  field_simp
  simpa only [seedCoordinateUnits_val, unitValue_apply] using hP

omit [Fintype K] in
theorem geometric_exchange_second [Finite K] (C : Subring F) (row : K ↪ M) (d : K → ℤ)
    (hd : ∀ k, 0 < d k)
    (s : TauCeti.Cluster.GeometricSeed (F := F) row d)
    (i j : K) (hij : i ≠ j) (σ : ℤ) (e : ℕ)
    (hσ : σ = 1 ∨ σ = -1)
    (hijB : s.exchange (row i) j = (-σ) * (e : ℤ)) :
    s.coordinate (row j) * (s.mutate hd j).coordinate (row j) =
      unitValue (pairComplementRing C (fun m => (seedCoordinateUnits s m : F)) (row i) (row j))
        (pairCoefficient C (seedCoordinateUnits s) (row i) (row j)
          (fun a ↦ s.exchange a j) (-σ)) * s.coordinate (row i) ^ e +
      unitValue (pairComplementRing C (fun m => (seedCoordinateUnits s m : F)) (row i) (row j))
        (pairCoefficient C (seedCoordinateUnits s) (row i) (row j)
          (fun a ↦ s.exchange a j) σ) := by
  let : Fintype K := Fintype.ofFinite K
  have hσ' : -σ = 1 ∨ -σ = -1 := by
    rcases hσ with rfl | rfl <;> simp
  have h := geometric_exchange_first C row d hd s j i hij.symm (-σ) e hσ'
    (by simpa using hijB)
  simp only [neg_neg] at h
  have hvalD := pairCoefficient_swap_val C (seedCoordinateUnits s) (row i) (row j)
    (fun a ↦ s.exchange a j) (-σ)
  have hf := pairCoefficient_swap_val C (seedCoordinateUnits s) (row i) (row j)
    (fun a ↦ s.exchange a j) σ
  simp only [unitValue_apply] at h
  rw [← hvalD, ← hf] at h
  simpa only [unitValue_apply] using h

omit [Fintype K] in
theorem seedCoordinateUnits_mutate_other_val (row : K ↪ M) (d : K → ℤ)
    (hd : ∀ k, 0 < d k)
    (s : TauCeti.Cluster.GeometricSeed (F := F) row d)
    (i : K) (a : M) (ha : a ≠ row i) :
    (seedCoordinateUnits (s.mutate hd i) a : F) = seedCoordinateUnits s a := by
  change (s.mutate hd i).coordinate a = s.coordinate a
  simp [TauCeti.Cluster.GeometricSeed.mutate,
    TauCeti.Cluster.geometricMutationCoordinates, Function.update_of_ne ha]

omit [Fintype K] in
theorem geometric_pair_coefficient_compatibility [Finite K] (C : Subring F)
    (row : K ↪ M) (d : K → ℤ)
    (hd : ∀ k, 0 < d k)
    (s : TauCeti.Cluster.GeometricSeed (F := F) row d)
    (i j : K) (hij : i ≠ j) (σ : ℤ) (e : ℕ)
    (hσ : σ = 1 ∨ σ = -1)
    (hijB : s.exchange (row i) j = (-σ) * (e : ℤ)) :
    let D := pairComplementRing C (fun m => (seedCoordinateUnits s m : F)) (row i) (row j)
    let u := seedCoordinateUnits s
    let B := s.exchange
    let B' := (s.mutate hd i).exchange
    let b := unitValue D (pairCoefficient C u (row i) (row j) (fun a ↦ B a i) (-σ))
    let d₀ := unitValue D (pairCoefficient C u (row i) (row j) (fun a ↦ B a j) (-σ))
    let f := unitValue D (pairCoefficient C u (row i) (row j) (fun a ↦ B a j) σ)
    let g := unitValue D (pairCoefficient C u (row i) (row j) (fun a ↦ B' a j) σ)
    let h := unitValue D (pairCoefficient C u (row i) (row j) (fun a ↦ B' a j) (-σ))
    f * h = d₀ * g * b ^ e := by
  let : Fintype K := Fintype.ofFinite K
  dsimp
  have hσ' : -σ = 1 ∨ -σ = -1 := by
    rcases hσ with rfl | rfl <;> simp
  have hr := pairCoefficient_extended_relation C (seedCoordinateUnits s)
    row s.exchange i j hij (-σ) e hσ' (by simpa using hijB)
  have hv := congrArg (unitValue (pairComplementRing C
    (fun m => (seedCoordinateUnits s m : F)) (row i) (row j))) hr
  simp only [map_mul, map_pow, neg_neg] at hv
  simpa only [TauCeti.Cluster.GeometricSeed.mutate, unitValue_apply] using hv

omit [Fintype K] in
theorem geometric_exchange_after_first [Finite K] (C : Subring F)
    (row : K ↪ M) (d : K → ℤ) (hd : ∀ k, 0 < d k)
    (s : TauCeti.Cluster.GeometricSeed (F := F) row d)
    (i j : K) (hij : i ≠ j) (σ : ℤ) (e : ℕ)
    (hσ : σ = 1 ∨ σ = -1)
    (hijB : s.exchange (row i) j = (-σ) * (e : ℤ)) :
    let t := s.mutate hd i
    let D := pairComplementRing C (fun m => (seedCoordinateUnits s m : F)) (row i) (row j)
    let g := unitValue D (pairCoefficient C (seedCoordinateUnits s) (row i) (row j)
      (fun a ↦ t.exchange a j) σ)
    let h := unitValue D (pairCoefficient C (seedCoordinateUnits s) (row i) (row j)
      (fun a ↦ t.exchange a j) (-σ))
    s.coordinate (row j) * (t.mutate hd j).coordinate (row j) =
      g * t.coordinate (row i) ^ e + h := by
  let : Fintype K := Fintype.ofFinite K
  dsimp only
  let t := s.mutate hd i
  have hσ' : -σ = 1 ∨ -σ = -1 := by
    rcases hσ with rfl | rfl <;> simp
  have hB' : t.exchange (row i) j = (-(-σ)) * (e : ℤ) := by
    simp [t, TauCeti.Cluster.GeometricSeed.mutate,
      TauCeti.Cluster.extendedMatrixMutation, hijB]
  have hr := geometric_exchange_second C row d hd t i j hij (-σ) e hσ' hB'
  simp only [neg_neg] at hr
  have hother : ∀ a, a ≠ row i → a ≠ row j →
      (seedCoordinateUnits t a : F) = seedCoordinateUnits s a := by
    intro a ha _
    exact seedCoordinateUnits_mutate_other_val row d hd s i a ha
  have hg := pairCoefficient_value_congr C (seedCoordinateUnits s)
    (seedCoordinateUnits t) (row i) (row j)
    (fun a ↦ t.exchange a j) σ hother
  have hh := pairCoefficient_value_congr C (seedCoordinateUnits s)
    (seedCoordinateUnits t) (row i) (row j)
    (fun a ↦ t.exchange a j) (-σ) hother
  simp only [unitValue_apply] at hr ⊢
  rw [hg, hh] at hr
  have hy : t.coordinate (row j) = s.coordinate (row j) := by
    simp [t, TauCeti.Cluster.GeometricSeed.mutate,
      TauCeti.Cluster.geometricMutationCoordinates,
      Function.update_of_ne (row.injective.ne hij).symm]
  simpa only [hy] using hr

omit [Fintype K] in
/-- The interacting pair-chart equality for coefficients `C` inside a field `𝕜 ⊆ F` over which
the coordinates of `s` are algebraically independent. -/
theorem geometric_interacting_three_pairCharts_of_independent [Finite K] {𝕜 : Type*} [Field 𝕜]
    [Algebra 𝕜 F] (C : Subring F) (hC : ∀ a ∈ C, a ∈ (algebraMap 𝕜 F).range)
    (row : K ↪ M) (d : K → ℤ) (hd : ∀ k, 0 < d k)
    (s : TauCeti.Cluster.GeometricSeed (F := F) row d)
    (hAIs : AlgebraicIndependent 𝕜 s.coordinate)
    (i j : K) (hij : i ≠ j)
    (hB : s.exchange (row j) i ≠ 0) :
    let t := s.mutate hd i
    let D := pairComplementRing C (fun m => (seedCoordinateUnits s m : F)) (row i) (row j)
    pairChart D (s.coordinate (row i)) (s.coordinate (row j)) ⊓
      pairChart D (t.coordinate (row i)) (s.coordinate (row j)) ⊓
      pairChart D (s.coordinate (row i)) ((s.mutate hd j).coordinate (row j)) =
    pairChart D (t.coordinate (row i)) (s.coordinate (row j)) ⊓
      pairChart D (s.coordinate (row i)) (s.coordinate (row j)) ⊓
      pairChart D (t.coordinate (row i)) ((t.mutate hd j).coordinate (row j)) := by
  let : Fintype K := Fintype.ofFinite K
  let t := s.mutate hd i
  let D := pairComplementRing C (fun m => (seedCoordinateUnits s m : F)) (row i) (row j)
  let u := seedCoordinateUnits s
  let x := s.coordinate (row i)
  let xs := t.coordinate (row i)
  let y := s.coordinate (row j)
  let ys := (s.mutate hd j).coordinate (row j)
  have hri : row i ≠ row j := row.injective.ne hij
  have hs : SignSkewAt (s.exchange (row j) i) (s.exchange (row i) j) :=
    signSkewAt_of_positive_symmetrizer _ _ _ _ (hd j) (hd i)
      (s.symmetrized j i)
  obtain ⟨σ, c, e, hσ, hc, he, hji, hijB⟩ := signSkew_nonzero_data hs hB
  let a := unitValue D (pairCoefficient C u (row i) (row j)
    (fun m ↦ s.exchange m i) σ)
  let b := unitValue D (pairCoefficient C u (row i) (row j)
    (fun m ↦ s.exchange m i) (-σ))
  let d₀ := unitValue D (pairCoefficient C u (row i) (row j)
    (fun m ↦ s.exchange m j) (-σ))
  let f := unitValue D (pairCoefficient C u (row i) (row j)
    (fun m ↦ s.exchange m j) σ)
  let g := unitValue D (pairCoefficient C u (row i) (row j)
    (fun m ↦ t.exchange m j) σ)
  let h := unitValue D (pairCoefficient C u (row i) (row j)
    (fun m ↦ t.exchange m j) (-σ))
  have hx : x ≠ 0 := TauCeti.Cluster.nonzero_coordinate_of_algebraicIndependent
    s.coordinate s.independent (row i)
  have hxs : xs ≠ 0 := TauCeti.Cluster.nonzero_coordinate_of_algebraicIndependent
    t.coordinate t.independent (row i)
  have hy : y ≠ 0 := TauCeti.Cluster.nonzero_coordinate_of_algebraicIndependent
    s.coordinate s.independent (row j)
  have hf : f ≠ 0 := unitValue_ne_zero D _
  have hh : h ≠ 0 := unitValue_ne_zero D _
  have hex : x * xs = a * y ^ c + b := by
    simpa only [x, xs, y, a, b, D, u, t] using
      geometric_exchange_first C row d hd s i j hij σ c hσ hji
  have hey : y * ys = d₀ * x ^ e + f := by
    simpa only [x, y, ys, d₀, f, D, u] using
      geometric_exchange_second C row d hd s i j hij σ e hσ hijB
  have hcompat : f * h = d₀ * g * b ^ e := by
    simpa only [f, h, d₀, g, b, D, u, t] using
      geometric_pair_coefficient_compatibility C row d hd s i j hij σ e hσ hijB
  have hzprod : y * (t.mutate hd j).coordinate (row j) = g * xs ^ e + h := by
    simpa only [y, g, xs, h, D, u, t] using
      geometric_exchange_after_first C row d hd s i j hij σ e hσ hijB
  have hz : (t.mutate hd j).coordinate (row j) = (g * xs ^ e + h)/y := by
    apply (eq_div_iff hy).2
    simpa only [mul_comm] using hzprod
  have hAI : letI : Algebra (FractionRing D) F :=
      (fractionCoefficients D).toAlgebra
      AlgebraicIndependent (FractionRing D) (pairCoordinates x y) := by
    have hp := pair_independent_over_complement_field (K := 𝕜) C s.coordinate
      (row i) (row j) hri hC hAIs
    have hD : D = pairComplementRing C s.coordinate (row i) (row j) := by
      dsimp only [D]
      congr 1
    rw [hD]
    exact hp
  have hAIxs : letI : Algebra (FractionRing D) F :=
      (fractionCoefficients D).toAlgebra
      AlgebraicIndependent (FractionRing D) (pairCoordinates xs y) := by
    have hp := pair_independent_over_complement_field (K := 𝕜) C t.coordinate
      (row i) (row j) hri hC (s.algebraicIndependent_mutate hd hAIs i)
    have hD : pairComplementRing C t.coordinate (row i) (row j) = D := by
      have hfun : (fun m => (seedCoordinateUnits s m : F)) = s.coordinate := by
        funext m
        exact seedCoordinateUnits_val s m
      simp only [D, hfun]
      simpa only [t, TauCeti.Cluster.GeometricSeed.mutate,
        TauCeti.Cluster.geometricMutationCoordinates] using
        pairComplementRing_update_left C s.coordinate (row i) (row j)
          (MvPolynomial.aeval s.coordinate
            (geometricExchangePolynomial s.exchange i) / s.coordinate (row i))
    change (let D' := pairComplementRing C t.coordinate (row i) (row j)
      letI : Algebra (FractionRing D') F := (fractionCoefficients D').toAlgebra
      AlgebraicIndependent (FractionRing D')
        (pairCoordinates (t.coordinate (row i)) (t.coordinate (row j)))) at hp
    dsimp only at hp
    rw [hD] at hp
    have hy' : t.coordinate (row j) = y := by
      simp [t, y, TauCeti.Cluster.GeometricSeed.mutate,
        TauCeti.Cluster.geometricMutationCoordinates,
        Function.update_of_ne hri.symm]
    change (letI : Algebra (FractionRing D) F := (fractionCoefficients D).toAlgebra
      AlgebraicIndependent (FractionRing D)
        (pairCoordinates (t.coordinate (row i)) y))
    simpa only [hy'] using hp
  have hpair := interacting_three_pairCharts_of_independent D a b d₀ f g h x xs y ys
    hc he hx hxs hy hf hh
    (unitValue_mem D _) (unitValue_mem D _) (unitValue_mem D _)
    (unitValue_mem D _) (unitValue_inv_mem D _)
    (unitValue_mem D _) (unitValue_mem D _) (unitValue_inv_mem D _)
    hex hey hcompat hAI hAIxs
  rw [← hz] at hpair
  exact hpair

omit [Fintype K] in
theorem geometric_interacting_three_pairCharts [Finite K] (C : Subring F)
    (hC : ∀ a ∈ C, a ∈ (algebraMap ℚ F).range)
    (row : K ↪ M) (d : K → ℤ) (hd : ∀ k, 0 < d k)
    (s : TauCeti.Cluster.GeometricSeed (F := F) row d)
    (i j : K) (hij : i ≠ j)
    (hB : s.exchange (row j) i ≠ 0) :
    let t := s.mutate hd i
    let D := pairComplementRing C (fun m => (seedCoordinateUnits s m : F)) (row i) (row j)
    pairChart D (s.coordinate (row i)) (s.coordinate (row j)) ⊓
      pairChart D (t.coordinate (row i)) (s.coordinate (row j)) ⊓
      pairChart D (s.coordinate (row i)) ((s.mutate hd j).coordinate (row j)) =
    pairChart D (t.coordinate (row i)) (s.coordinate (row j)) ⊓
      pairChart D (s.coordinate (row i)) (s.coordinate (row j)) ⊓
      pairChart D (t.coordinate (row i)) ((t.mutate hd j).coordinate (row j)) := by
  let : Fintype K := Fintype.ofFinite K
  exact geometric_interacting_three_pairCharts_of_independent C hC row d hd s s.independent i j
    hij hB

omit [Fintype K] in
/-- **Three-chart equality, interacting case.** For coefficients `C` inside a field `𝕜 ⊆ F` over
which the coordinates of `s` are algebraically independent: `C = ℤ`, `𝕜 = ℚ` gives the charts
over `R_J`, and `C = 𝕜` the charts over `𝕜_J` (all frozen coordinates are inverted). -/
theorem geometric_interacting_three_chart_of_independent [Finite K] {𝕜 : Type*} [Field 𝕜]
    [Algebra 𝕜 F] (C : Subring F) (hC : ∀ a ∈ C, a ∈ (algebraMap 𝕜 F).range)
    (row : K ↪ M) (d : K → ℤ) (hd : ∀ k, 0 < d k)
    (s : TauCeti.Cluster.GeometricSeed (F := F) row d)
    (hAI : AlgebraicIndependent 𝕜 s.coordinate)
    (i j : K) (hij : i ≠ j)
    (hB : s.exchange (row j) i ≠ 0) :
    chartRing C s.coordinate ⊓ chartRing C (s.mutate hd i).coordinate ⊓
      chartRing C (s.mutate hd j).coordinate =
    chartRing C (s.mutate hd i).coordinate ⊓ chartRing C s.coordinate ⊓
      chartRing C ((s.mutate hd i).mutate hd j).coordinate := by
  let : Fintype K := Fintype.ofFinite K
  let t := s.mutate hd i
  let D := pairComplementRing C s.coordinate (row i) (row j)
  have hri : row i ≠ row j := row.injective.ne hij
  have h0 : chartRing C s.coordinate =
      pairChart D (s.coordinate (row i)) (s.coordinate (row j)) :=
    chartRing_pair_regroup C s.coordinate (row i) (row j)
  have hi : chartRing C t.coordinate =
      pairChart D (t.coordinate (row i)) (s.coordinate (row j)) := by
    simpa only [t, TauCeti.Cluster.GeometricSeed.mutate,
      TauCeti.Cluster.geometricMutationCoordinates, Function.update_self, D] using
      chartRing_pair_update_left C s.coordinate (row i) (row j) hri
        (MvPolynomial.aeval s.coordinate
          (geometricExchangePolynomial s.exchange i) / s.coordinate (row i))
  have hj : chartRing C (s.mutate hd j).coordinate =
      pairChart D (s.coordinate (row i)) ((s.mutate hd j).coordinate (row j)) := by
    simpa only [TauCeti.Cluster.GeometricSeed.mutate,
      TauCeti.Cluster.geometricMutationCoordinates, Function.update_self, D] using
      chartRing_pair_update_right C s.coordinate (row i) (row j) hri
        (MvPolynomial.aeval s.coordinate
          (geometricExchangePolynomial s.exchange j) / s.coordinate (row j))
  have hijmut : chartRing C (t.mutate hd j).coordinate =
      pairChart D (t.coordinate (row i)) ((t.mutate hd j).coordinate (row j)) := by
    simpa only [t, TauCeti.Cluster.GeometricSeed.mutate,
      TauCeti.Cluster.geometricMutationCoordinates, Function.update_self, D] using
      chartRing_pair_update_both C s.coordinate (row i) (row j) hri
        (MvPolynomial.aeval s.coordinate
          (geometricExchangePolynomial s.exchange i) / s.coordinate (row i))
        (MvPolynomial.aeval t.coordinate
          (geometricExchangePolynomial t.exchange j) / t.coordinate (row j))
  have hpair := geometric_interacting_three_pairCharts_of_independent C hC row d hd s hAI
    i j hij hB
  have hD : pairComplementRing C (fun m => (seedCoordinateUnits s m : F))
      (row i) (row j) = D := by
    dsimp only [D]
    congr 1
  rw [hD] at hpair
  change chartRing C s.coordinate ⊓ chartRing C t.coordinate ⊓
      chartRing C (s.mutate hd j).coordinate =
    chartRing C t.coordinate ⊓ chartRing C s.coordinate ⊓
      chartRing C (t.mutate hd j).coordinate
  rw [h0, hi, hj, hijmut]
  exact hpair

omit [Fintype K] in
theorem geometric_interacting_three_chart [Finite K] (C : Subring F)
    (hC : ∀ a ∈ C, a ∈ (algebraMap ℚ F).range)
    (row : K ↪ M) (d : K → ℤ) (hd : ∀ k, 0 < d k)
    (s : TauCeti.Cluster.GeometricSeed (F := F) row d)
    (i j : K) (hij : i ≠ j)
    (hB : s.exchange (row j) i ≠ 0) :
    chartRing C s.coordinate ⊓ chartRing C (s.mutate hd i).coordinate ⊓
      chartRing C (s.mutate hd j).coordinate =
    chartRing C (s.mutate hd i).coordinate ⊓ chartRing C s.coordinate ⊓
      chartRing C ((s.mutate hd i).mutate hd j).coordinate := by
  let : Fintype K := Fintype.ofFinite K
  exact geometric_interacting_three_chart_of_independent C hC row d hd s s.independent i j hij hB

end TauCeti.Cluster.UpperBound
