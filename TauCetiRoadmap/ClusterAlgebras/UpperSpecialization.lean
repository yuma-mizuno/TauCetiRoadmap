/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.Coefficients
public import TauCetiRoadmap.LaurentPhenomenon.PositiveRealization
public import Mathlib.Tactic.FieldSimp

/-!
# The coefficient normalization step, independent of Laurentness

This is the algebraic step in separation of additions.  The auxiliary sum in
the coefficient semifield is deliberately never mapped to field addition.
The proof uses its distributivity only after extracting the common coefficient
monomial.  It makes no Laurentness assumption, nor does it import the
Caterpillar proof.
-/

@[expose] public section

namespace TauCeti.Cluster

variable {P F : Type*} [CoefficientSemifield P] [Field F]

/-- A multiplicative coefficient realization sends every coefficient to a
nonzero field element. -/
theorem coefficientMap_ne_zero (e : P →* F) (p : P) : e p ≠ 0 := by
  have h : e p * e p⁻¹ = 1 := by rw [← map_mul, mul_inv_cancel, map_one]
  exact left_ne_zero_of_mul_eq_one h

/-- The scalar cancellation at one normalized mutation.  The two terms of the
numerator are evaluated using ordinary field addition, whereas the denominator
is evaluated using the coefficient-semifield sum. -/
theorem normalized_specialization_step (e : P →* F)
    (y dPlus dMinus dK h : P) (xPlus xMinus xK : F)
    (hxK : xK ≠ 0) :
    let a : P := y * dPlus / dMinus
    let dNew : P := (y * dPlus + dMinus) / (h * dK)
    let nNew : F :=
      (e y * (e dPlus * xPlus) + e dMinus * xMinus) /
        (e h * (e dK * xK))
    nNew / e dNew =
      (e a * xPlus + xMinus) / (e (a + 1) * xK) := by
  dsimp
  have hfactor : y * dPlus + dMinus =
      dMinus * (y * dPlus / dMinus + 1) := by
    rw [mul_add, mul_one]
    simp [div_eq_mul_inv, mul_assoc, mul_left_comm]
  have hefactor : e (y * dPlus + dMinus) =
      e dMinus * e (y * dPlus / dMinus + 1) := by
    rw [hfactor, map_mul]
  have hy := coefficientMap_ne_zero e y
  have hp := coefficientMap_ne_zero e dPlus
  have hm := coefficientMap_ne_zero e dMinus
  have hk := coefficientMap_ne_zero e dK
  have hh := coefficientMap_ne_zero e h
  have hsum := coefficientMap_ne_zero e (y * dPlus / dMinus + 1)
  have ha : e (y * dPlus / dMinus) * e dMinus = e y * e dPlus := by
    simp [map_mul, div_eq_mul_inv, hm, mul_assoc, mul_comm, mul_left_comm]
  simp only [map_div, map_mul, hefactor]
  field_simp

/-- Recurrence-facing form of `normalized_specialization_step`.  In a word
induction, the hypotheses are the specialized principal exchange recurrence
and its `F`-polynomial image.  They involve only the current mutation; no
Laurent conclusion for the target pattern is included. -/
theorem normalized_specialization_step_of_recurrences (e : P →* F)
    (y dPlus dMinus dK h dNew : P)
    (xPlus xMinus xK nNew : F) (hxK : xK ≠ 0)
    (hdNew : dNew = (y * dPlus + dMinus) / (h * dK))
    (hnNew : nNew =
      (e y * (e dPlus * xPlus) + e dMinus * xMinus) /
        (e h * (e dK * xK))) :
    nNew / e dNew =
      (e (y * dPlus / dMinus) * xPlus + xMinus) /
        (e (y * dPlus / dMinus + 1) * xK) := by
  subst dNew
  subst nNew
  exact normalized_specialization_step e y dPlus dMinus dK h xPlus xMinus xK hxK

/-- The same step with the principal numerator monomials kept explicit.  This
matches the induction hypothesis `N_i = [D_i] x_i` term by term. -/
theorem normalized_specialization_step_from_monomials (e : P →* F)
    (y dPlus dMinus dK h dNew : P)
    (xPlus xMinus xK nPlus nMinus nK nNew : F) (hxK : xK ≠ 0)
    (hPlus : nPlus = e dPlus * xPlus)
    (hMinus : nMinus = e dMinus * xMinus)
    (hK : nK = e dK * xK)
    (hdNew : dNew = (y * dPlus + dMinus) / (h * dK))
    (hnNew : nNew = (e y * nPlus + nMinus) / (e h * nK)) :
    nNew / e dNew =
      (e (y * dPlus / dMinus) * xPlus + xMinus) /
        (e (y * dPlus / dMinus + 1) * xK) := by
  subst nPlus
  subst nMinus
  subst nK
  exact normalized_specialization_step_of_recurrences e y dPlus dMinus dK h dNew
    xPlus xMinus xK nNew hxK hdNew hnNew

end TauCeti.Cluster

namespace TauCeti.Cluster

open TauCeti.Laurent
noncomputable section


variable {G H I F : Type*} [AddCommGroup G] [AddCommGroup H] [Field F]

/-- Finite Laurent coefficient substitution along a multiplicative group map.
It is defined on the Laurent ring, not on its entire fraction field. -/
def finiteCoefficientSpecialization (η : G →+ H) :
    TotalLaurentRing G I →+* TotalLaurentRing H I :=
  AddMonoidAlgebra.mapDomainRingHom ℤ
    (η.prodMap (AddMonoidHom.id (I →₀ ℤ)))

/-- Positive sums survive even a noninjective coefficient substitution. -/
theorem finiteCoefficientSpecialization_positive_ne_zero
    (η : G →+ H) (ψ : TotalLaurentRing H I →+* F)
    (hψ : ∀ p, positiveCast p ≠ 0 → ψ (positiveCast p) ≠ 0)
    {p : AddMonoidAlgebra ℕ (G × (I →₀ ℤ))} (hp : p ≠ 0) :
    (ψ.comp (finiteCoefficientSpecialization η)) (positiveCast p) ≠ 0 := by
  let φ : G × (I →₀ ℤ) →+ H × (I →₀ ℤ) :=
    η.prodMap (AddMonoidHom.id _)
  have hnon := positive_mapDomain_ne_zero φ hp
  have htarget := hψ (AddMonoidAlgebra.mapDomainRingHom ℕ φ p)
    (positiveCast_ne_zero hnon)
  have hc := RingHom.congr_fun
    (AddMonoidAlgebra.mapRingHom_comp_mapDomainRingHom
      (Nat.castRingHom ℤ) φ) p
  change positiveCast (AddMonoidAlgebra.mapDomainRingHom ℕ φ p) =
    AddMonoidAlgebra.mapDomainRingHom ℤ φ (positiveCast p) at hc
  change ψ (AddMonoidAlgebra.mapDomainRingHom ℤ φ (positiveCast p)) ≠ 0
  rwa [← hc]

end
end TauCeti.Cluster
