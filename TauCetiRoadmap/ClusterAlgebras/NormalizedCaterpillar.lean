/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.NormalizedPattern
public import TauCetiRoadmap.LaurentPhenomenon.PositiveCaterpillar

/-! # Normalized Caterpillar -/

@[expose] public section

open TauCeti.Laurent

noncomputable section
namespace TauCeti.Cluster
variable {I C : Type*} [DecidableEq I] [Finite I] [CoefficientSemifield C]

/-- Normalized matrix and coefficient data on the finite tree. Every edge obeys
the actual Fomin–Zelevinsky mutation formulas. No exchange-polynomial
compatibility, coprimality, or Laurent conclusion is supplied as input. -/
structure NormalizedCaterpillar (C : Type*) [CoefficientSemifield C]
    (P : CaterpillarPath I) where
  /-- The exchange matrix assigned to every vertex of the finite caterpillar. -/
  matrix : P.Vertex → I → I → ℤ
  /-- The coefficient tuple assigned to every vertex of the finite caterpillar. -/
  coefficient : P.Vertex → I → C
  diagonal : ∀ s i, matrix s i i = 0
  signSkew : ∀ s i j, SignSkewAt (matrix s i j) (matrix s j i)
  matrix_law : ∀ {a b j}, P.Edge a b j → matrix b = matrixMutation (matrix a) j
  coefficient_self : ∀ {a b j}, P.Edge a b j → coefficient b j = (coefficient a j)⁻¹
  coefficient_other : ∀ {a b j}, P.Edge a b j → ∀ i, i ≠ j →
    coefficient b i = coefficientMutation (coefficient a i) (coefficient a j)
      (coefficient a j + 1) (matrix a j i)


namespace NormalizedCaterpillar
variable {P : CaterpillarPath I} (D : NormalizedCaterpillar C P)

/-- The two-direction normalized mutation data determined by two adjacent internal stars. -/
def localMutation (p : Fin (P.length - 2)) (i : I) (hi : i ≠ P.middleLabel p) :
    NormalizedLocalMutation C I i (P.middleLabel p) where
  distinct := hi
  before := D.matrix (P.leftStar p)
  after := D.matrix (P.rightStar p)
  coefficient := D.coefficient (P.leftStar p)
  coefficientAfter := D.coefficient (P.rightStar p)
  diagonal := D.diagonal (P.leftStar p)
  diagonalAfter := D.diagonal (P.rightStar p)
  signSkew := D.signSkew (P.leftStar p)
  matrixLaw := D.matrix_law (P.middle_edge p)
  coefficientLaw := D.coefficient_other (P.middle_edge p) i hi

/-- The positive Laurent exchange binomial obtained from the local matrix column and normalized
coefficient.
-/
def exchange (s : P.Vertex) (i : I) : PositiveLaurent (Additive C) I :=
  seedExchange (D.coefficient s i) (fun h => D.matrix s h i)

theorem exchange_undirected {a b : P.Vertex} {j : I} (he : P.Edge a b j) :
    D.exchange a j = D.exchange b j := by
  have hcol : (fun h => D.matrix b h j) = (fun h => -D.matrix a h j) := by
    funext h
    rw [D.matrix_law he]
    simp [matrixMutation]
  unfold exchange
  rw [D.coefficient_self he, hcol, seedExchange_own_mutation]

/-- The constructed local propagation correction for a direction distinct from the intervening
edge label.
-/
def correction (p : Fin (P.length - 2)) (i : I) : PositiveLaurent (Additive C) I :=
  if hi : i ≠ P.middleLabel p then (D.localMutation p i hi).correction_exists.choose else 1

theorem correction_spec (p : Fin (P.length - 2)) (i : I) (hi : i ≠ P.middleLabel p) :
    D.correction p i ≠ 0 ∧ PositiveIndependent (D.correction p i) i ∧
      PositiveNonnegativeAt (D.correction p i) (P.middleLabel p) ∧
      D.exchange (P.rightStar p) i = positivePropagate (D.correction p i)
        (D.exchange (P.leftStar p) i)
        (positiveSetZero (D.exchange (P.leftStar p) (P.middleLabel p)) i) (P.middleLabel p) := by
  simp only [correction, dite_eq_left hi]
  exact (D.localMutation p i hi).correction_exists.choose_spec

/-- Actual normalized mutation laws supply every hypothesis of the positive
Caterpillar theorem, including the correction identities for zero matrix entries. -/
def toPositive : PositiveCaterpillar (Additive C) P where
  exchange := D.exchange
  exchange_ne_zero s i := seedExchange_ne_zero (D.coefficient s i) (fun h => D.matrix s h i)
  exchange_polynomial s i := seedExchange_polynomial (D.coefficient s i) (fun h => D.matrix s h i)
  exchange_independent s i := seedExchange_independent _ _ i (D.diagonal s i)
  exchange_no_factor s i := seedExchange_no_factor (D.coefficient s i) (fun h => D.matrix s h i)
  exchange_undirected := D.exchange_undirected
  correction := D.correction
  correction_ne_zero p i hi := (D.correction_spec p i hi).1
  correction_independent p i hi := (D.correction_spec p i hi).2.1
  correction_nonnegative p i hi := (D.correction_spec p i hi).2.2.1
  compatibility p i hi := (D.correction_spec p i hi).2.2.2

end NormalizedCaterpillar
end TauCeti.Cluster
