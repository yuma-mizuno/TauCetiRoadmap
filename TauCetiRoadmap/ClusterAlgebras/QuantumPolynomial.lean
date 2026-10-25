/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.PolynomialQuantumPair

/-!
# Binary exchange as degree-one polynomial exchange

The polynomial `1 + X` defines binary frame mutation using the common polynomial
construction. Faithfulness, involutivity and Q1 use that construction. Mutation
words are transported through the degree-one embedding.
-/

@[expose] public section

namespace TauCeti.Cluster.ExchangeFrame

open TauCeti TauCeti.QuantumTorus TauCeti.Laurent

noncomputable section

variable {R₀ : Type*} [CommRing R₀] {u₀ : R₀ˣ}
  {D : Type*} [DivisionRing D] [Algebra R₀ D]
  {M K : Type*} [Fintype M] [DecidableEq M] {row : K ↪ M}
  (s : ExchangeFrame (u₀ := u₀) D row)

/-- The ordinary quantum seed with its degree-one exchange polynomials. -/
def polynomialSeed : PolynomialExchangeSeed (u₀ := u₀) D row where
  toExchangeFrame := s
  polynomial := fun _ ↦ Polynomial.X + 1
  constant_one := fun _ ↦ by simp
  monic := fun _ ↦ by simpa using Polynomial.monic_X_add_C (1 : R₀)
  degree_pos := fun _ ↦ by let := (algebraMap R₀ D).domain_nontrivial; simp
  degree_dvd := fun _ _ ↦ by let := (algebraMap R₀ D).domain_nontrivial; simp

@[simp] theorem polynomialSeed_toExchangeFrame : s.polynomialSeed.toExchangeFrame = s := rfl

@[simp] theorem polynomialSeed_degree (k : K) : s.polynomialSeed.degree k = 1 := by
  let := (algebraMap R₀ D).domain_nontrivial
  simp [polynomialSeed, PolynomialExchangeSeed.degree]

theorem polynomialSeed_exchangeCoordinate (k : K) :
    s.polynomialSeed.exchangeCoordinate k = s.exchangeCoordinate k := by
  rw [PolynomialExchangeSeed.exchangeCoordinate, polynomialSeed_degree]
  simp only [Finset.sum_range_succ, Finset.sum_range_zero, zero_add]
  have he : s.polynomialSeed.exchangeExponent k 1 =
      exchangeExponentPos row s.exchange.matrix k := by
    have he := s.polynomialSeed.exchangeExponent_degree k
    rw [polynomialSeed_degree] at he
    exact he
  rw [s.polynomialSeed.exchangeExponent_zero, he]
  simp [polynomialSeed, exchangeCoordinate, Polynomial.coeff_one, add_comm]


theorem exchangeCoordinate_ne_zero (k : K) : s.exchangeCoordinate k ≠ 0 := by
  simpa only [polynomialSeed_exchangeCoordinate] using s.polynomialSeed.exchangeCoordinate_ne_zero k

theorem exchangeCoordinate_mem_chartRing (k : K) : s.exchangeCoordinate k ∈ s.chartRing := by
  simpa only [polynomialSeed_exchangeCoordinate, polynomialSeed_toExchangeFrame] using
    s.polynomialSeed.exchangeCoordinate_mem_chartRing k

theorem exchangeCoordinate_mul_coordinate (k : K) {j : M} (hj : j ≠ row k) :
    s.exchangeCoordinate k * s.coordinate j =
      algebraMap R₀ D ((u₀ ^ (2 * matrixForm s.form
        (exchangeExponentPos row s.exchange.matrix k) (Pi.single j 1)) : R₀ˣ) : R₀) *
        (s.coordinate j * s.exchangeCoordinate k) := by
  have h := s.polynomialSeed.exchangeCoordinate_mul_coordinate k hj
  rw [polynomialSeed_exchangeCoordinate] at h
  simpa only [polynomialSeed] using h

theorem exchangeData (k : K) :
    SkewExchange.ExchangeData (s.otherRing (row k)) (s.coordinate (row k) : D)
      (s.exchangeCoordinate k * s.coordinate (row k)) := by
  simpa only [polynomialSeed_exchangeCoordinate, polynomialSeed_toExchangeFrame] using
    s.polynomialSeed.exchangeData k

theorem exchangeData_y (k : K) :
    s.exchangeCoordinate k * s.coordinate (row k) * (s.coordinate (row k) : D)⁻¹ =
      s.exchangeCoordinate k := mul_inv_cancel_right₀ (Units.ne_zero _) _

theorem polynomialSeed_fourRing (i j : K) : s.polynomialSeed.fourRing i j = s.fourRing i j := by
  unfold PolynomialExchangeSeed.fourRing ExchangeFrame.fourRing
  rw [polynomialSeed_exchangeCoordinate, polynomialSeed_exchangeCoordinate]
  rfl


variable [Fintype K] [DecidableEq K]

/-- Binary mutation is defined by degree-one polynomial mutation. -/
def mutate (k : K) : ExchangeFrame (u₀ := u₀) D row :=
  (s.polynomialSeed.mutate k).toExchangeFrame

/-- Degree-one exchange data are preserved by the common mutation construction. -/
theorem polynomialSeed_mutate (k : K) :
    s.polynomialSeed.mutate k = (s.mutate k).polynomialSeed := by
  let := (algebraMap R₀ D).domain_nontrivial
  refine PolynomialExchangeSeed.ext (s := s.polynomialSeed.mutate k)
    (t := (s.mutate k).polynomialSeed) rfl ?_
  funext j
  simp only [PolynomialExchangeSeed.mutate_polynomial, PolynomialExchangeSeed.mutatePolynomial]
  by_cases hj : j = k
  · subst j
    rw [Function.update_self]
    change (Polynomial.X + Polynomial.C 1 : Polynomial R₀).reverse =
      Polynomial.X + Polynomial.C 1
    rw [Polynomial.reverse_add_C]
    simp [Polynomial.reverse, add_comm]
  · rw [Function.update_of_ne hj]
    rfl

@[simp] theorem mutate_exchange (k : K) : (s.mutate k).exchange = s.exchange.mutate k := rfl

theorem mutate_exchange_matrix (k : K) :
    (s.mutate k).exchange.matrix = extendedMatrixMutation row s.exchange.matrix k := rfl

@[simp] theorem mutate_form (k : K) :
    (s.mutate k).form = formMutation row s.exchange.matrix s.form k 1 := rfl

@[simp] theorem mutate_coordinate_row (k : K) :
    ((s.mutate k).coordinate (row k) : D) = s.exchangeCoordinate k := by
  change ((s.polynomialSeed.mutate k).coordinate (row k) : D) = _
  rw [s.polynomialSeed.mutate_coordinate_row, polynomialSeed_exchangeCoordinate]

theorem mutate_coordinate_of_ne (k : K) {j : M} (hj : j ≠ row k) :
    (s.mutate k).coordinate j = s.coordinate j :=
  s.polynomialSeed.mutate_coordinate_of_ne k hj

theorem mutate_exchangeCoordinate (k : K) :
    (s.mutate k).exchangeCoordinate k = s.coordinate (row k) := by
  have h := s.polynomialSeed.mutate_exchangeCoordinate k
  rw [polynomialSeed_mutate, polynomialSeed_exchangeCoordinate] at h
  simpa only [polynomialSeed] using h

/-- Binary involutivity is the degree-one instance of polynomial involutivity. -/
theorem mutate_mutate (k : K) : (s.mutate k).mutate k = s := by
  have h := congrArg PolynomialExchangeSeed.toExchangeFrame (s.polynomialSeed.mutate_mutate k)
  simpa only [polynomialSeed_mutate, polynomialSeed_toExchangeFrame] using h

theorem mutate_involutive (k : K) :
    Function.Involutive (fun t : ExchangeFrame (u₀ := u₀) D row ↦ t.mutate k) :=
  fun t ↦ t.mutate_mutate k

/-- Mutation words are transported by the degree-one embedding. -/
theorem polynomialSeed_mutateWord (w : List K) :
    mutateWord (fun k t ↦ PolynomialExchangeSeed.mutate t k) w s.polynomialSeed =
      (mutateWord (fun k t ↦ ExchangeFrame.mutate t k) w s).polynomialSeed :=
  (mutateWord_map (fun k t ↦ ExchangeFrame.mutate t k)
    (fun k t ↦ PolynomialExchangeSeed.mutate t k) polynomialSeed
    (fun k t ↦ (t.polynomialSeed_mutate k).symm) w s).symm

theorem opposite_mutate (k : K) : s.opposite.mutate k = (s.mutate k).opposite := by
  refine ExchangeFrame.ext (s.exchange.neg_mutate k)
    (s.compatible.formMutation_neg s.alternating (Or.inl rfl)) (funext fun j ↦ Units.ext ?_)
  by_cases hj : j = row k
  · subst hj
    rw [mutate_coordinate_row, val_opposite_coordinate, mutate_coordinate_row,
      opposite_exchangeCoordinate]
  · rw [mutate_coordinate_of_ne _ _ hj, val_opposite_coordinate, val_opposite_coordinate,
      mutate_coordinate_of_ne _ _ hj]

/-! ### Reachable seeds -/

/-- `t` is reached from `s` by a finite mutation word. -/
def Reachable (s t : ExchangeFrame (u₀ := u₀) D row) : Prop :=
  ∃ w : List K, mutateWord (fun k t ↦ ExchangeFrame.mutate t k) w s = t

theorem reachable_mutateWord (s : ExchangeFrame (u₀ := u₀) D row) (w : List K) :
    s.Reachable (mutateWord (fun k t ↦ ExchangeFrame.mutate t k) w s) :=
  ⟨w, rfl⟩

@[refl] theorem Reachable.refl (s : ExchangeFrame (u₀ := u₀) D row) : s.Reachable s :=
  ⟨[], rfl⟩

theorem reachable_mutate (s : ExchangeFrame (u₀ := u₀) D row) (k : K) : s.Reachable (s.mutate k) :=
  ⟨[k], rfl⟩

theorem Reachable.trans {s t u : ExchangeFrame (u₀ := u₀) D row} (h₁ : s.Reachable t) (h₂ :
  t.Reachable u) :
    s.Reachable u := by
  obtain ⟨w₁, rfl⟩ := h₁
  obtain ⟨w₂, rfl⟩ := h₂
  exact ⟨w₁ ++ w₂, mutateWord_append _ _ _ _⟩

theorem Reachable.symm {s t : ExchangeFrame (u₀ := u₀) D row} (h : s.Reachable t) : t.Reachable s
  := by
  obtain ⟨w, rfl⟩ := h
  exact ⟨w.reverse, mutateWord_reverse _ (fun k ↦ mutate_involutive k) w s⟩

theorem reachable_comm {s t : ExchangeFrame (u₀ := u₀) D row} : s.Reachable t ↔ t.Reachable s :=
  ⟨Reachable.symm, Reachable.symm⟩


variable (k : K)

@[simp] theorem mutate_otherRing : (s.mutate k).otherRing (row k) = s.otherRing (row k) := by
  simp only [otherRing, OneExchange.otherCoordinateRing]
  congr 1
  funext j
  rw [mutate_coordinate_of_ne _ _ j.2]

/-- Binary Q1 is the degree-one instance of polynomial Q1. -/
theorem chartRing_inf_mutate_chartRing :
    s.chartRing ⊓ (s.mutate k).chartRing =
      Subring.closure ((s.otherRing (row k) : Set D) ∪
        {(s.coordinate (row k) : D), s.exchangeCoordinate k}) := by
  change s.chartRing ⊓ (s.polynomialSeed.mutate k).toExchangeFrame.chartRing = _
  simpa only [polynomialSeed_exchangeCoordinate, polynomialSeed_toExchangeFrame] using
    s.polynomialSeed.chartRing_inf_mutate_chartRing k

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
  TauCeti.Cluster.upperBound (algebraMap R₀ D).range
    (fun t : ExchangeFrame (u₀ := u₀) D row ↦ fun i ↦ (t.coordinate i : D)) (fun k t ↦ t.mutate k) s

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
    (hthree : ∀ (t : ExchangeFrame (u₀ := u₀) D row) (i j : K), j ≠ i →
      t.chartRing ⊓ (t.mutate i).chartRing ⊓ (t.mutate j).chartRing =
        (t.mutate i).chartRing ⊓ t.chartRing ⊓ ((t.mutate i).mutate j).chartRing) :
    (s.mutate k).upperBound = s.upperBound :=
  TauCeti.Cluster.upperBound_mutation_of_three_chart _ _ _ (fun k ↦ mutate_involutive k)
    hthree s k

/-- Quantum Laurentness from upper-bound invariance: every coordinate reached by a mutation
word lies in the integral chart ring of the initial seed. -/
theorem coordinate_mutateWord_mem_chartRing_of_upperBound_mutate
    (hmut : ∀ (t : ExchangeFrame (u₀ := u₀) D row) (k : K), (t.mutate k).upperBound = t.upperBound)
    (w : List K) (j : M) :
    ((mutateWord (fun k t ↦ ExchangeFrame.mutate t k) w s).coordinate j : D) ∈ s.chartRing :=
  TauCeti.Cluster.laurent_of_upperBound_invariant _ _ _ (fun k ↦ mutate_involutive k)
    (fun t k j ↦ t.mutate_coordinate_mem_chartRing k j) hmut s w j

/-! ### Q3 with hypotheses at the seeds reachable from `s` -/

/-- **Q3, invariance.** The three-chart equalities at every seed reached from `s` make the quantum
upper bound the same at all seeds reached from `s`. -/
theorem upperBound_eq_of_three_chart
    (hthree : ∀ t : ExchangeFrame (u₀ := u₀) D row,
      s.Reachable t →
      ∀ i j : K, j ≠ i →
        t.chartRing ⊓ (t.mutate i).chartRing ⊓ (t.mutate j).chartRing =
          (t.mutate i).chartRing ⊓ t.chartRing ⊓ ((t.mutate i).mutate j).chartRing)
    {t : ExchangeFrame (u₀ := u₀) D row}
    (ht : s.Reachable t) :
    t.upperBound = s.upperBound := by
  obtain ⟨w, rfl⟩ := ht
  exact patternUpperBound_mutateWord_of_three_chart
    (fun t : ExchangeFrame (u₀ := u₀) D row ↦ t.chartRing) (fun k t ↦ t.mutate k)
    (fun k ↦ mutate_involutive k) s
    (fun w i j hji ↦ hthree _ ⟨w, rfl⟩ i j hji) w

/-- **Q3, Laurentness.** If the quantum upper bound is invariant under mutation at every seed
reached from `s`, every coordinate of a seed reached from `s` lies in the integral chart ring of
every seed reached from `s`. -/
theorem coordinate_mem_chartRing_of_upperBound_mutate
    (hmut : ∀ t : ExchangeFrame (u₀ := u₀) D row,
      s.Reachable t →
      ∀ k : K, (t.mutate k).upperBound = t.upperBound)
    {t u : ExchangeFrame (u₀ := u₀) D row}
    (ht : s.Reachable t)
    (hu : s.Reachable u) (j : M) :
    (t.coordinate j : D) ∈ u.chartRing := by
  obtain ⟨w, rfl⟩ := ht
  obtain ⟨v, rfl⟩ := hu
  exact generator_mem_of_patternUpperBound
    (fun t : ExchangeFrame (u₀ := u₀) D row ↦ t.chartRing) (fun k t ↦ t.mutate k)
    (fun t i ↦ (t.coordinate i : D))
    (fun k ↦ mutate_involutive k) s (fun _ j ↦ coordinate_mem_chartRing _ _ j)
    (fun _ k j ↦ ExchangeFrame.mutate_coordinate_mem_chartRing _ k j)
    (fun w k ↦ hmut _ ⟨w, rfl⟩ k) v w j

/-- If the quantum upper bound is invariant under mutation at every seed reached from `s`, the
quantum upper cluster algebra `⋂_t T_t` equals the finite upper bound at `s`. -/
theorem upperClusterRing_eq_upperBound_of_upperBound_mutate
    (hmut : ∀ t : ExchangeFrame (u₀ := u₀) D row,
      s.Reachable t →
      ∀ k : K, (t.mutate k).upperBound = t.upperBound) :
    TauCeti.Cluster.upperClusterRing (algebraMap R₀ D).range
        (fun t : ExchangeFrame (u₀ := u₀) D row ↦ fun i ↦ (t.coordinate i : D))
        (fun k t ↦ t.mutate k) s = s.upperBound :=
  patternUpperRing_eq_patternUpperBound
    (fun t : ExchangeFrame (u₀ := u₀) D row ↦ t.chartRing) (fun k t ↦ t.mutate k) s
    fun w k ↦ hmut _ ⟨w, rfl⟩ k

/-- If the quantum upper bound is invariant under mutation at every seed reached from `s`, the
quantum cluster ring lies in the quantum upper cluster algebra. -/
theorem clusterRing_le_upperClusterRing_of_upperBound_mutate
    (hmut : ∀ t : ExchangeFrame (u₀ := u₀) D row,
      s.Reachable t →
      ∀ k : K, (t.mutate k).upperBound = t.upperBound) :
    TauCeti.Cluster.clusterRing (algebraMap R₀ D).range
        (fun t : ExchangeFrame (u₀ := u₀) D row ↦ fun i ↦ (t.coordinate i : D))
        (fun k t ↦ t.mutate k) s ≤
      TauCeti.Cluster.upperClusterRing (algebraMap R₀ D).range
        (fun t : ExchangeFrame (u₀ := u₀) D row ↦ fun i ↦ (t.coordinate i : D))
        (fun k t ↦ t.mutate k) s :=
  clusterRing_le_patternUpperRing
    (fun t : ExchangeFrame (u₀ := u₀) D row ↦ Laurent.chartRing (algebraMap R₀ D).range
      (fun i ↦ (t.coordinate i : D))) (fun k t ↦ t.mutate k) (algebraMap R₀ D).range
    (fun t : ExchangeFrame (u₀ := u₀) D row ↦ fun i ↦ (t.coordinate i : D))
    (fun k ↦ mutate_involutive k) s
    (coefficient_le_upperBound (algebraMap R₀ D).range
      (fun t : ExchangeFrame (u₀ := u₀) D row ↦ fun i ↦ (t.coordinate i : D)) (fun k t ↦ t.mutate
        k) s)
    (fun _ j ↦ coordinate_mem_chartRing _ _ j)
    (fun _ k j ↦ ExchangeFrame.mutate_coordinate_mem_chartRing _ k j)
    (fun w k ↦ hmut _ ⟨w, rfl⟩ k)

end
end TauCeti.Cluster.ExchangeFrame
