/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.ClassicalFrame
public import TauCetiRoadmap.ClusterAlgebras.PolynomialQuantumLaurent

/-!
# Classical upper bounds from the common polynomial proof at unit parameter

The classical frame uses zero form and zero form weights. Column independence
is supplied directly by full rank. The faithful chart retains its
coefficient subring and has parameter one. The classical local comparison is
then the very same polynomial Q2 theorem, with no separate commuting or
interacting proof.
-/

@[expose] public section
noncomputable section
namespace TauCeti.Cluster
open TauCeti TauCeti.Laurent TauCeti.QuantumTorus

namespace UpperBound
variable {F 𝕜 : Type*} [Field F] [Field 𝕜] [Algebra 𝕜 F]

/-- The integral coefficient subring of the ambient field. -/
abbrev geometricIntegerRing (F : Type*) [Field F] := (Int.castRingHom F).range

/-- A field is isomorphic to its coefficient image. -/
def algebraMapRangeEquiv (𝕜 : Type*) [Field 𝕜] [Algebra 𝕜 F] :
    𝕜 ≃+* (algebraMap 𝕜 F).range :=
  RingEquiv.ofBijective (algebraMap 𝕜 F).rangeRestrict
    ⟨fun _ _ h ↦ (algebraMap 𝕜 F).injective (congrArg Subtype.val h),
      (algebraMap 𝕜 F).rangeRestrict_surjective⟩

/-- An embedding of a coefficient subring into its field of independence. -/
def coefficientEmbedding (C : Subring F)
    (hC : ∀ a ∈ C, a ∈ (algebraMap 𝕜 F).range) : C →+* 𝕜 :=
  (algebraMapRangeEquiv (F := F) 𝕜).symm.toRingHom.comp (Subring.inclusion hC)

@[simp] theorem algebraMap_coefficientEmbedding (C : Subring F)
    (hC : ∀ a ∈ C, a ∈ (algebraMap 𝕜 F).range) (a : C) :
    algebraMap 𝕜 F (coefficientEmbedding C hC a) = a :=
  congrArg Subtype.val ((algebraMapRangeEquiv (F := F) 𝕜).apply_symm_apply
    (Subring.inclusion hC a))

theorem coefficientEmbedding_injective (C : Subring F)
    (hC : ∀ a ∈ C, a ∈ (algebraMap 𝕜 F).range) :
    Function.Injective (coefficientEmbedding C hC) := by
  intro a b h
  apply Subtype.ext
  rw [← algebraMap_coefficientEmbedding C hC a, ← algebraMap_coefficientEmbedding C hC b, h]

/-- The image of a field is factorial. -/
theorem algebraMap_range_uniqueFactorizationMonoid :
    UniqueFactorizationMonoid (algebraMap 𝕜 F).range :=
  (algebraMapRangeEquiv (F := F) 𝕜).toMulEquiv.uniqueFactorizationMonoid inferInstance

/-- The integral coefficient subring is factorial in characteristic zero. -/
theorem geometricIntegerRing_uniqueFactorizationMonoid [Algebra ℚ F] :
    UniqueFactorizationMonoid (geometricIntegerRing F) := by
  have : CharZero F := algebraRat.charZero F
  exact (RingEquiv.ofBijective (Int.castRingHom F).rangeRestrict
    ⟨fun _ _ h ↦ Int.cast_injective (congrArg Subtype.val h),
      (Int.castRingHom F).rangeRestrict_surjective⟩).toMulEquiv.uniqueFactorizationMonoid
    inferInstance

end UpperBound

variable {F 𝕜 M K : Type*} [Field F] [Algebra ℚ F] [Field 𝕜] [Algebra 𝕜 F]
  [Fintype M] [Fintype K] [DecidableEq M] [DecidableEq K]
  {row : K ↪ M} {d : K → ℤ}

namespace FullRankGeometricSeed
open UpperBound

/-- The classical realization in the common framework has literal zero form
and zero form weights; its matrix symmetrizer is unchanged. -/
def toCommutativeFrame (C : Subring F)
    (hC : ∀ a ∈ C, a ∈ (algebraMap 𝕜 F).range) (hd : ∀ i, 0 < d i)
    (s : FullRankGeometricSeed (F := F) row d)
    (hx : AlgebraicIndependent 𝕜 s.1.coordinate) :
    ExchangeFrame (u₀ := (1 : Cˣ)) F row :=
  commutativeFrame
    { matrix := s.1.exchange
      symmetrizer := d
      symmetrizer_pos := hd
      symmetrized := s.1.symmetrized }
    ((linearIndependent_columns_iff_rank _).2 s.2)
    (coefficientEmbedding C hC) (coefficientEmbedding_injective C hC)
    (algebraMap_coefficientEmbedding C hC) s.1.units hx

omit [DecidableEq K] in
@[simp] theorem toCommutativeFrame_form (C : Subring F)
    (hC : ∀ a ∈ C, a ∈ (algebraMap 𝕜 F).range) (hd : ∀ i, 0 < d i)
    (s : FullRankGeometricSeed (F := F) row d) (hx : AlgebraicIndependent 𝕜 s.1.coordinate) :
    (s.toCommutativeFrame C hC hd hx).form = 0 := rfl

omit [DecidableEq K] in
@[simp] theorem toCommutativeFrame_formWeight (C : Subring F)
    (hC : ∀ a ∈ C, a ∈ (algebraMap 𝕜 F).range) (hd : ∀ i, 0 < d i)
    (s : FullRankGeometricSeed (F := F) row d) (hx : AlgebraicIndependent 𝕜 s.1.coordinate) :
    (s.toCommutativeFrame C hC hd hx).formWeight = fun _ ↦ 0 := rfl

/-- Forgetting rank certificates and auxiliary forms commutes with mutation words. -/
theorem geometricPattern_eq (hd : ∀ i, 0 < d i)
    (s : FullRankGeometricSeed (F := F) row d) (w : List K) :
    geometricPattern row s.1.exchange s.1.coordinate w =
      ((mutateWord (fun k t ↦ t.mutate hd k) w s).1.exchange,
        (mutateWord (fun k t ↦ t.mutate hd k) w s).1.coordinate) := by
  exact (mutateWord_map (fun k t ↦ t.mutate hd k) (geometricExchange row)
    (fun t : FullRankGeometricSeed (F := F) row d ↦ (t.1.exchange, t.1.coordinate))
    (fun k t ↦ (t.1.geometricExchange_eq_mutate hd k).symm) w s).symm

/-- Chart equality for the actual unit-parameter realization after every word. -/
theorem unitParameterFrame_chartRing (C : Subring F) (hd : ∀ i, 0 < d i)
    (s : FullRankGeometricSeed (F := F) row d) (t : ExchangeFrame (u₀ := (1 : Cˣ)) F row)
    (hB : t.exchange.matrix = s.1.exchange)
    (hx : (fun a ↦ (t.coordinate a : F)) = s.1.coordinate) (w : List K) :
    (mutateWord (fun k t ↦ ExchangeFrame.mutate t k) w t).chartRing =
      chartRing C (mutateWord (fun k t ↦ t.mutate hd k) w s).1.coordinate := by
  have h := t.mutateWord_pair_unitParameter w
  rw [hB, hx, s.geometricPattern_eq hd] at h
  have hcoords := congrArg Prod.snd h
  change (fun a ↦ ((mutateWord (fun k t ↦ ExchangeFrame.mutate t k) w t).coordinate a : F)) =
    (mutateWord (fun k t ↦ t.mutate hd k) w s).1.coordinate at hcoords
  change chartRing (algebraMap C F).range _ = _
  rw [hcoords]
  congr 1
  exact Subring.range_subtype C

/-- Every classical coordinate is Laurent in every reachable chart by direct
application of the common polynomial theorem at unit parameter. -/
theorem coordinate_mem_chart_unitParameter (C : Subring F) [UniqueFactorizationMonoid C]
    (hC : ∀ a ∈ C, a ∈ (algebraMap 𝕜 F).range) (hd : ∀ i, 0 < d i)
    (s : FullRankGeometricSeed (F := F) row d) (hx : AlgebraicIndependent 𝕜 s.1.coordinate)
    (u w : List K) (a : M) :
    (mutateWord (fun k t ↦ t.mutate hd k) w s).1.coordinate a ∈
      chartRing C (mutateWord (fun k t ↦ t.mutate hd k) u s).1.coordinate := by
  let t := s.toCommutativeFrame C hC hd hx
  have hB : t.exchange.matrix = s.1.exchange := rfl
  have hcoords : (fun a ↦ (t.coordinate a : F)) = s.1.coordinate := rfl
  have h := t.polynomialSeed.coordinate_mutateWord_mem_mutateWord_chartRing u w a
  simp only [ExchangeFrame.polynomialSeed_mutateWord,
    ExchangeFrame.polynomialSeed_toExchangeFrame] at h
  have hp := t.mutateWord_pair_unitParameter w
  rw [hB, hcoords, s.geometricPattern_eq hd] at hp
  have hc := congrArg Prod.snd hp
  change (fun a ↦ ((mutateWord (fun k t ↦ ExchangeFrame.mutate t k) w t).coordinate a : F)) =
    (mutateWord (fun k t ↦ t.mutate hd k) w s).1.coordinate at hc
  rw [← congrFun hc a]
  rwa [s.unitParameterFrame_chartRing C hd t hB hcoords u] at h

/-- Classical Q2 is the common polynomial Q2 theorem at scalar unit one. -/
theorem three_chart_unitParameter (C : Subring F) [UniqueFactorizationMonoid C]
    (hC : ∀ a ∈ C, a ∈ (algebraMap 𝕜 F).range) (hd : ∀ i, 0 < d i)
    (s : FullRankGeometricSeed (F := F) row d) (hx : AlgebraicIndependent 𝕜 s.1.coordinate)
    (i j : K) (hij : i ≠ j) :
    chartRing C s.1.coordinate ⊓ chartRing C (s.mutate hd i).1.coordinate ⊓
        chartRing C (s.mutate hd j).1.coordinate =
      chartRing C (s.mutate hd i).1.coordinate ⊓ chartRing C s.1.coordinate ⊓
        chartRing C ((s.mutate hd i).mutate hd j).1.coordinate := by
  let t := s.toCommutativeFrame C hC hd hx
  have hB : t.exchange.matrix = s.1.exchange := rfl
  have hcoords : (fun a ↦ (t.coordinate a : F)) = s.1.coordinate := rfl
  have h := t.polynomialSeed.three_chart i j hij.symm
  simp only [ExchangeFrame.polynomialSeed_mutate,
    ExchangeFrame.polynomialSeed_toExchangeFrame] at h
  have h0 := s.unitParameterFrame_chartRing C hd t hB hcoords []
  have hi := s.unitParameterFrame_chartRing C hd t hB hcoords [i]
  have hj := s.unitParameterFrame_chartRing C hd t hB hcoords [j]
  have hij' := s.unitParameterFrame_chartRing C hd t hB hcoords [i, j]
  simp only [mutateWord_cons, mutateWord_nil] at h0 hi hj hij'
  rw [h0, hi, hj, hij'] at h
  exact h

end FullRankGeometricSeed
end TauCeti.Cluster
