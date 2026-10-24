/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.CoordinateSeparation
public import TauCetiRoadmap.ClusterAlgebras.PrincipalLaurent
public import TauCetiRoadmap.LaurentPhenomenon.CoefficientChart

/-! Arbitrary normalized-coefficient Laurentness from principal geometric
upper bounds and positive coordinate separation. -/

@[expose] public section

namespace TauCeti.Cluster
open TauCeti.Laurent
noncomputable section

variable {I P : Type*} [Fintype I] [DecidableEq I]
  [CoefficientSemifield P]

omit [Fintype I] in
/-- Laurentness for every matrix seed over an arbitrary coefficient semifield.
The principal representative comes from finite upper bounds; the denominator
is an invertible coefficient monomial. -/
theorem matrixSeed_integral_laurent [Finite I] {d : I → ℤ}
    (hd : ∀ i, 0 < d i) (s : MatrixSeed P I d)
    (w : List I) (i : I) :
    ∃ q : TotalLaurentRing (Additive P) I,
      algebraMap _ (FractionRing (TotalLaurentRing (Additive P) I)) q =
        (MatrixSeed.pattern hd).wordCoordinates (algebraMap _ _) s w i := by
  let : Fintype I := Fintype.ofFinite I
  let R := TotalLaurentRing (Additive P) I
  let F := FractionRing R
  let f : R →+* F := algebraMap _ _
  let η := principalCoefficientHom s.coefficient
  let g := principalToTarget η f
  let N := MatrixSeed.pattern (C := Trop I) hd
  let M := MatrixSeed.pattern (C := P) hd
  let s₀ := principalSeed s.matrix s.symmetrized
  let D := principalWordFValue N η s₀ w i
  let e := coefficientFieldMap f
  have hf : ∀ p : PositiveLaurent (Additive P) I,
      positiveCast p ≠ 0 → f (positiveCast p) ≠ 0 := by
    intro p hp
    exact canonicalMap_positive p hp
  have hg : ∀ p : PositiveLaurent (Additive (Trop I)) I,
      positiveCast p ≠ 0 → g (positiveCast p) ≠ 0 := by
    intro p hp
    exact principalToTarget_positive_ne_zero η f hf p hp
  obtain ⟨r, hr⟩ := principalWord_integral_laurent d hd
    s.matrix s.symmetrized w i
  have hspecial := N.wordCoordinates_specialize g hg s₀ w i r hr
  have hsep := principal_coordinate_separation N M f hf s₀ s
    (by rfl) (by intro j; rfl) w i
  have hnum : g r = e D * M.wordCoordinates f s w i := by
    calc
      g r = N.wordCoordinates g s₀ w i := hspecial.symm
      _ = e D * M.wordCoordinates f s w i := hsep
  let q : R := finiteCoefficientSpecialization η r *
    AddMonoidAlgebra.single (Additive.ofMul D⁻¹, 0) 1
  refine ⟨q, ?_⟩
  change f q = M.wordCoordinates f s w i
  have hq : f q = g r * e D⁻¹ := by
    simp [q, g, principalToTarget, e, coefficientFieldMap]
  rw [hq, hnum, map_inv]
  have hD : e D ≠ 0 := coefficientMap_ne_zero e D
  calc
    e D * M.wordCoordinates f s w i * (e D)⁻¹ =
        M.wordCoordinates f s w i * (e D * (e D)⁻¹) := by ring
    _ = M.wordCoordinates f s w i := by rw [mul_inv_cancel₀ hD, mul_one]

omit [Fintype I] in
/-- Geometric coefficients admit a Laurent representative polynomial in every
frozen generator. This holds for any tropical coefficient index type. -/
theorem matrixSeed_polynomial_frozen [Finite I] {J : Type*} {d : I → ℤ}
    (hd : ∀ i, 0 < d i) (s : MatrixSeed (Trop J) I d)
    (w : List I) (i : I) :
    ∃ r : TotalLaurentRing (Additive (Trop J)) I,
      (algebraMap _ (FractionRing (TotalLaurentRing (Additive (Trop J)) I)) r =
        (MatrixSeed.pattern hd).wordCoordinates (algebraMap _ _) s w i) ∧
      ∀ a ∈ r.coeff.support, ∀ j : J, 0 ≤ a.1.toMul.toAdd j := by
  let : Fintype I := Fintype.ofFinite I
  obtain ⟨r, hr⟩ := matrixSeed_integral_laurent hd s w i
  refine ⟨r, hr, ?_⟩
  by_cases hz : r = 0
  · simp [hz]
  · intro a ha j
    exact (MatrixSeed.pattern hd).wordCoordinates_frozen_nonnegative
      s w i r hz hr j a ha

end
end TauCeti.Cluster
