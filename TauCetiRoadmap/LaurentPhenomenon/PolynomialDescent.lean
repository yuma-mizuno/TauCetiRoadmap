/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.LaurentSupport
public import Mathlib.Algebra.MvPolynomial.Division

/-!
# Polynomial descent of relative primality

Over a domain `R`, the polynomial ring `R[x_i : i ∈ I]` embeds in the Laurent ring
`R[x_i^{±1} : i ∈ I] = R[ℤ ^ I]` (`mvPolynomialToLaurent`). A polynomial whose image is a unit is
a monomial with unit coefficient (`isUnit_iff_exists_single`). Hence two
polynomials, one of which has no variable factor, that are relatively prime in the Laurent ring
are relatively prime in the polynomial ring
(`isRelPrime_of_isRelPrime_mvPolynomialToLaurent`). Together with
`isRelPrime_list_prod_one_add_single` this gives relative primality of exchange polynomials in
the polynomial ring.
-/

@[expose] public section

namespace TauCeti.Laurent

open MvPolynomial

variable {R I : Type*} [CommRing R]

/-- The exponent inclusion `ℕ ^ I → ℤ ^ I`. -/
noncomputable abbrev natExponentHom (I : Type*) : (I →₀ ℕ) →+ (I →₀ ℤ) :=
  Finsupp.mapRange.addMonoidHom (Nat.castAddMonoidHom ℤ)

theorem natExponentHom_injective : Function.Injective (natExponentHom I) :=
  Finsupp.mapRange_injective _ (by simp) Nat.cast_injective

/-- The inclusion of polynomials into Laurent polynomials, `x ^ n ↦ x ^ n`. -/
noncomputable def mvPolynomialToLaurent (R I : Type*) [CommRing R] :
    MvPolynomial I R →ₐ[R] AddMonoidAlgebra R (I →₀ ℤ) :=
  AddMonoidAlgebra.mapDomainAlgHom R R (natExponentHom I)

@[simp] theorem mvPolynomialToLaurent_monomial (n : I →₀ ℕ) (c : R) :
    mvPolynomialToLaurent R I (monomial n c) = AddMonoidAlgebra.single (natExponentHom I n) c :=
  AddMonoidAlgebra.mapDomain_single

theorem mvPolynomialToLaurent_injective :
    Function.Injective (mvPolynomialToLaurent R I) :=
  AddMonoidAlgebra.mapDomain_injective natExponentHom_injective

/-- A polynomial that becomes a unit in the Laurent ring is a monomial with unit coefficient. -/
theorem exists_eq_monomial_of_isUnit_mvPolynomialToLaurent [IsDomain R] {h : MvPolynomial I R}
    (hu : IsUnit (mvPolynomialToLaurent R I h)) : ∃ n c, IsUnit c ∧ h = monomial n c := by
  classical
  obtain ⟨a, c, hc, ha⟩ := isUnit_iff_exists_single.1 hu
  have hmem : a ∈ (mvPolynomialToLaurent R I h).coeff.support := by
    rw [ha, AddMonoidAlgebra.coeff_single, Finsupp.mem_support_iff, Finsupp.single_eq_same]
    exact hc.ne_zero
  obtain ⟨n, -, rfl⟩ := Finset.mem_image.1 (Finsupp.mapDomain_support hmem)
  refine ⟨n, c, hc, mvPolynomialToLaurent_injective ?_⟩
  rw [ha, mvPolynomialToLaurent_monomial]

/-- **Polynomial descent.** Over a domain, if `P` has no variable factor and the images of `P`
and `Q` are relatively prime in the Laurent ring, then `P` and `Q` are relatively prime in the
polynomial ring. -/
theorem isRelPrime_of_isRelPrime_mvPolynomialToLaurent [IsDomain R] {P Q : MvPolynomial I R}
    (hP : ∀ i, ¬X i ∣ P)
    (h : IsRelPrime (mvPolynomialToLaurent R I P) (mvPolynomialToLaurent R I Q)) :
    IsRelPrime P Q := by
  intro d hdP hdQ
  obtain ⟨n, c, hc, rfl⟩ :=
    exists_eq_monomial_of_isUnit_mvPolynomialToLaurent (h (map_dvd _ hdP) (map_dvd _ hdQ))
  rcases eq_or_ne n 0 with rfl | hn
  · rw [monomial_zero']
    exact hc.map C
  · obtain ⟨i, hi⟩ := Finsupp.ne_iff.1 hn
    exact absurd ((X_dvd_monomial.2 (Or.inr hi)).trans hdP) (hP i)

end TauCeti.Laurent
