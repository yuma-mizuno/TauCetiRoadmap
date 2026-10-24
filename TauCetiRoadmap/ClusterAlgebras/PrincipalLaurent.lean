/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.QuantumLaurent
public import TauCetiRoadmap.ClusterAlgebras.QuantumSpecialization
public import TauCetiRoadmap.ClusterAlgebras.PrincipalGeometricComparison
public import TauCetiRoadmap.ClusterAlgebras.FrozenWeight

/-! The principal-coefficient Laurent theorem with integral coefficients and
no negative frozen exponents (L5). Its proof is the classical limit `v = 1` of the
integral quantum Laurent phenomenon for the principal compatible pair, which in
turn rests on mutation invariance of finite quantum upper bounds. -/

@[expose] public section

noncomputable section
namespace TauCeti.Cluster
open TauCeti.Laurent
open UpperBound
variable {I : Type*} [Fintype I] [DecidableEq I]

theorem principalGeometricWord_laurent (d : I → ℤ) (hd : ∀ i, 0 < d i)
    (B : I → I → ℤ) (hB : ∀ i j, d i * B i j = -(d j * B j i))
    (w : List I) (a : I ⊕ I) :
    (geometricWordData d hd B hB w).2 a ∈
      chartRing (Int.castRingHom (PrincipalGeometricField I)).range
        (rationalLaurentCoordinates (I ⊕ I)) :=
  principalGeometricWord_laurent_of_quantum d hd B hB w a

omit [Fintype I] in
/-- The principal Laurent representation is in the integral source ring,
not merely in a Laurent ring with rational coefficients. -/
theorem principalWord_integral_laurent [Finite I] (d : I → ℤ) (hd : ∀ i, 0 < d i)
    (B : I → I → ℤ) (hB : ∀ i j, d i * B i j = -(d j * B j i))
    (w : List I) (i : I) :
    ∃ r : TotalLaurentRing (Additive (Trop I)) I,
      algebraMap _ (FractionRing (TotalLaurentRing (Additive (Trop I)) I)) r =
        (MatrixSeed.pattern (C := Trop I) hd).wordCoordinates
          (algebraMap _ _) (principalSeed B hB) w i := by
  let : Fintype I := Fintype.ofFinite I
  exact principalWord_integral_of_geometric_chart d hd B hB w i
    (principalGeometricWord_laurent d hd B hB w (Sum.inl i))

omit [Fintype I] in
/-- The sharper geometric theorem: every frozen exponent is nonnegative.
No sign-coherence, scattering diagram, or coefficient positivity is used. -/
theorem principalWord_polynomial_frozen [Finite I] (d : I → ℤ) (hd : ∀ i, 0 < d i)
    (B : I → I → ℤ) (hB : ∀ i j, d i * B i j = -(d j * B j i))
    (w : List I) (i : I) :
    ∃ r : TotalLaurentRing (Additive (Trop I)) I,
      (algebraMap _ (FractionRing (TotalLaurentRing (Additive (Trop I)) I)) r =
        (MatrixSeed.pattern (C := Trop I) hd).wordCoordinates
          (algebraMap _ _) (principalSeed B hB) w i) ∧
      ∀ a ∈ r.coeff.support, ∀ j, 0 ≤ a.1.toMul.toAdd j := by
  let : Fintype I := Fintype.ofFinite I
  obtain ⟨r, hr⟩ := principalWord_integral_laurent d hd B hB w i
  refine ⟨r, hr, ?_⟩
  by_cases hz : r = 0
  · simp [hz]
  · intro a ha j
    exact (MatrixSeed.pattern (C := Trop I) hd).wordCoordinates_frozen_nonnegative
      (principalSeed B hB) w i r hz hr j a ha

end TauCeti.Cluster
