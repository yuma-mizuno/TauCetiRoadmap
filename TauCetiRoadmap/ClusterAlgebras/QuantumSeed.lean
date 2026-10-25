/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.QuantumAlgebra
public import TauCetiRoadmap.ClusterAlgebras.PolynomialQuantumAlgebra

/-!
# Ordinary quantum seeds inside the common exchange framework

The common frame permits zero form weights. An ordinary quantum seed instead
has form weights equal to its positive matrix symmetrizer. This is a genuine
restriction of the data, retained as a subtype. All mutation constructions and
Laurent proofs are inherited from the common polynomial construction.
-/

@[expose] public section
namespace TauCeti.Cluster
open TauCeti TauCeti.Laurent TauCeti.QuantumTorus
noncomputable section

/-- An ordinary quantum seed has the positive compatible diagonal of its matrix. -/
abbrev QuantumSeed (D : Type*) [DivisionRing D] [Algebra Zv D]
    {M K : Type*} [Fintype M] [DecidableEq M] (row : K ↪ M) :=
  {s : ExchangeFrame (u₀ := vUnit) D row // s.formWeight = s.exchange.symmetrizer}

/-- Polynomial quantum seeds retain the ordinary positive quantum compatibility condition. -/
abbrev PolynomialQuantumSeed (D : Type*) [DivisionRing D] [Algebra Zv D]
    {M K : Type*} [Fintype M] [DecidableEq M] (row : K ↪ M) :=
  {s : PolynomialExchangeSeed (u₀ := vUnit) D row //
    s.formWeight = s.exchange.symmetrizer}

namespace QuantumSeed
variable {D : Type*} [DivisionRing D] [Algebra Zv D]
  {M K : Type*} [Fintype M] [DecidableEq M] {row : K ↪ M}

/-- Construct the ordinary seed from precisely the usual compatible faithful chart data.
Column independence is derived, not an additional quantum seed input. -/
def ofCompatible (E : ExtendedExchangeMatrix row) (Λ : Matrix M M ℤ)
    (hΛ : IsAlternatingMatrix Λ) (hc : IsCompatiblePair E Λ) (x : M → Dˣ)
    (hx : IsQuasiCommuting vUnit (matrixForm Λ) x)
    (hfaithful : Function.Injective (QuantumTorus.lift hΛ.isAlt x hx)) : QuantumSeed D row :=
  ⟨{ exchange := E
     form := Λ
     alternating := hΛ
     formWeight := E.symmetrizer
     compatible := hc
     independentColumns := hc.independent_columns
     coordinate := x
     quasiCommuting := hx
     faithful := hfaithful }, rfl⟩

/-- The ordinary seed satisfies the standard positive compatibility condition. -/
theorem compatible (s : QuantumSeed D row) : IsCompatiblePair s.1.exchange s.1.form := by
  have h := s.1.compatible
  rwa [s.2] at h

variable [Fintype K] [DecidableEq K]

/-- Ordinary quantum mutation is the common degree-one polynomial mutation. -/
def mutate (s : QuantumSeed D row) (k : K) : QuantumSeed D row :=
  ⟨s.1.mutate k, by change s.1.formWeight = s.1.exchange.symmetrizer; exact s.2⟩

@[simp] theorem val_mutate (s : QuantumSeed D row) (k : K) :
    (s.mutate k).1 = s.1.mutate k := rfl

/-- Ordinary quantum involutivity follows from the common polynomial involutivity proof. -/
theorem mutate_mutate (s : QuantumSeed D row) (k : K) : (s.mutate k).mutate k = s :=
  Subtype.ext (s.1.mutate_mutate k)

/-- Every ordinary mutation word is the same word in the common frame. -/
theorem val_mutateWord (s : QuantumSeed D row) (w : List K) :
    (mutateWord (fun k t ↦ QuantumSeed.mutate t k) w s).1 =
      mutateWord (fun k t ↦ ExchangeFrame.mutate t k) w s.1 :=
  mutateWord_map (fun k t ↦ QuantumSeed.mutate t k)
    (fun k t ↦ ExchangeFrame.mutate t k) Subtype.val (fun _ _ ↦ rfl) w s

/-- Ordinary quantum Laurentness in every reachable integral chart. -/
theorem coordinate_mutateWord_mem_mutateWord_chartRing
    (s : QuantumSeed D row) (u w : List K) (a : M) :
    ((mutateWord (fun k t ↦ QuantumSeed.mutate t k) w s).1.coordinate a : D) ∈
      (mutateWord (fun k t ↦ QuantumSeed.mutate t k) u s).1.chartRing := by
  rw [val_mutateWord, val_mutateWord]
  exact s.1.coordinate_mutateWord_mem_mutateWord_chartRing u w a

/-- Ordinary quantum Laurentness in the initial chart. -/
theorem coordinate_mutateWord_mem_chartRing (s : QuantumSeed D row) (w : List K) (a : M) :
    ((mutateWord (fun k t ↦ QuantumSeed.mutate t k) w s).1.coordinate a : D) ∈ s.1.chartRing :=
  s.coordinate_mutateWord_mem_mutateWord_chartRing [] w a

/-- Standard quantum upper-bound invariance is inherited from the common proof. -/
theorem upperBound_mutate (s : QuantumSeed D row) (k : K) :
    (s.mutate k).1.upperBound = s.1.upperBound := s.1.upperBound_mutate k

/-- The standard quantum cluster algebra lies in the upper algebra for every frozen convention. -/
theorem clusterAlgebra_le_upperAlgebra (s : QuantumSeed D row) {S : Set M}
    (hS : S ⊆ (Set.range row)ᶜ) : s.1.clusterAlgebra S ≤ s.1.upperAlgebra :=
  s.1.clusterAlgebra_le_upperAlgebra hS

/-- The standard quantum upper algebra is its finite upper bound. -/
theorem upperAlgebra_eq_upperBoundAlgebra (s : QuantumSeed D row) :
    s.1.upperAlgebra = s.1.upperBoundAlgebra := s.1.upperAlgebra_eq_upperBoundAlgebra

end QuantumSeed

namespace PolynomialQuantumSeed
variable {D : Type*} [DivisionRing D] [Algebra Zv D]
  {M K : Type*} [Fintype M] [DecidableEq M] {row : K ↪ M}

/-- Add normalized central monic polynomials to an ordinary quantum seed. -/
def ofSeed (s : QuantumSeed D row) (H : K → Polynomial Zv)
    (h0 : ∀ k, (H k).coeff 0 = 1) (hmonic : ∀ k, (H k).Monic)
    (hpos : ∀ k, 0 < (H k).natDegree)
    (hdiv : ∀ a k, ((H k).natDegree : ℤ) ∣ s.1.exchange.matrix a k) :
    PolynomialQuantumSeed D row :=
  ⟨{ toExchangeFrame := s.1
     polynomial := H
     constant_one := h0
     monic := hmonic
     degree_pos := hpos
     degree_dvd := hdiv }, s.2⟩

variable [Fintype K] [DecidableEq K]

/-- Polynomial quantum mutation uses the common polynomial mutation construction. -/
def mutate (s : PolynomialQuantumSeed D row) (k : K) : PolynomialQuantumSeed D row :=
  ⟨s.1.mutate k, by change s.1.formWeight = s.1.exchange.symmetrizer; exact s.2⟩

@[simp] theorem val_mutate (s : PolynomialQuantumSeed D row) (k : K) :
    (s.mutate k).1 = s.1.mutate k := rfl

/-- Involutivity includes reversal of the selected exchange polynomial. -/
theorem mutate_mutate (s : PolynomialQuantumSeed D row) (k : K) : (s.mutate k).mutate k = s :=
  Subtype.ext (s.1.mutate_mutate k)

/-- The ordinary-compatible polynomial words are words of the common polynomial seed. -/
theorem val_mutateWord (s : PolynomialQuantumSeed D row) (w : List K) :
    (mutateWord (fun k t ↦ PolynomialQuantumSeed.mutate t k) w s).1 =
      mutateWord (fun k t ↦ PolynomialExchangeSeed.mutate t k) w s.1 :=
  mutateWord_map (fun k t ↦ PolynomialQuantumSeed.mutate t k)
    (fun k t ↦ PolynomialExchangeSeed.mutate t k) Subtype.val (fun _ _ ↦ rfl) w s

/-- The polynomial quantum theorem is an instance of the common all-rank proof. -/
theorem coordinate_mutateWord_mem_mutateWord_chartRing
    (s : PolynomialQuantumSeed D row) (u w : List K) (a : M) :
    ((mutateWord (fun k t ↦ PolynomialQuantumSeed.mutate t k) w s).1.coordinate a : D) ∈
      (mutateWord (fun k t ↦ PolynomialQuantumSeed.mutate t k) u s).1.toExchangeFrame.chartRing
        := by
  rw [val_mutateWord, val_mutateWord]
  exact s.1.coordinate_mutateWord_mem_mutateWord_chartRing u w a

/-- Initial-chart polynomial quantum Laurentness. -/
theorem coordinate_mutateWord_mem_chartRing
    (s : PolynomialQuantumSeed D row) (w : List K) (a : M) :
    ((mutateWord (fun k t ↦ PolynomialQuantumSeed.mutate t k) w s).1.coordinate a : D) ∈
      s.1.toExchangeFrame.chartRing :=
  s.coordinate_mutateWord_mem_mutateWord_chartRing [] w a

/-- Polynomial quantum cluster algebra inclusion for arbitrary frozen inverses. -/
theorem clusterAlgebra_le_upperAlgebra (s : PolynomialQuantumSeed D row) {S : Set M}
    (hS : S ⊆ (Set.range row)ᶜ) : s.1.clusterAlgebra S ≤ s.1.upperAlgebra :=
  s.1.clusterAlgebra_le_upperAlgebra hS

/-- Polynomial quantum upper algebra equals its finite upper bound. -/
theorem upperAlgebra_eq_upperBoundAlgebra (s : PolynomialQuantumSeed D row) :
    s.1.upperAlgebra = s.1.upperBoundAlgebra := s.1.upperAlgebra_eq_upperBoundAlgebra

end PolynomialQuantumSeed
end
end TauCeti.Cluster
