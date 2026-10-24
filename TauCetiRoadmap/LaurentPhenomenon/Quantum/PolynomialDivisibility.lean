/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.Quantum.CentralDivisibility
public import TauCetiRoadmap.LaurentPhenomenon.PolynomialSupport

/-!
# Central divisibility for polynomial factors

Scalar polynomials with constant coefficient one, evaluated on independent central
lattice directions, satisfy the same intersection-of-principal-ideals theorem as
binomial products. The proof uses the existing coset basis of the quantum torus.
-/

@[expose] public section

namespace TauCeti.QuantumTorus

noncomputable section

variable {R L I : Type*} [CommRing R] [AddCommGroup L]
  {u : Rˣ} {Λ : LinearMap.BilinForm ℤ L}

theorem centralHom_aeval_single (e : I → L) (hc : ∀ i, Λ (e i) = 0) (i : I)
    (p : Polynomial R) :
    centralHom (u := u) e hc
        (Polynomial.aeval (AddMonoidAlgebra.single (Finsupp.single i 1) (1 : R)) p) =
      Polynomial.aeval (monomial (e i) : quantumTorus R u Λ) p := by
  have h : (centralHom (u := u) e hc).comp
        (Polynomial.aeval (AddMonoidAlgebra.single (Finsupp.single i 1) (1 : R))) =
      Polynomial.aeval (monomial (e i) : quantumTorus R u Λ) := by
    apply Polynomial.algHom_ext
    simp [centralHom_single]
  exact AlgHom.congr_fun h p

/-- Relatively prime central polynomial factors may be divided simultaneously. -/
theorem exists_eq_mul_aeval_mul_aeval [IsDomain R] [UniqueFactorizationMonoid R]
    (hΛ : LinearMap.IsAlt Λ) {a b : L}
    (hab : ∀ m n : ℤ, m • a + n • b = 0 → m = 0 ∧ n = 0)
    (ha : ∀ x, Λ a x = 0) (hb : ∀ x, Λ b x = 0) {p q : Polynomial R}
    (hp : p.coeff 0 = 1) (hq : q.coeff 0 = 1) {f : quantumTorus R u Λ}
    (hP : ∃ g, f = g * Polynomial.aeval (monomial a) p)
    (hQ : ∃ g, f = g * Polynomial.aeval (monomial b) q) :
    ∃ g, f = g * (Polynomial.aeval (monomial a) p * Polynomial.aeval (monomial b) q) := by
  classical
  let e := ![a, b]
  have he : LinearIndependent ℤ e := LinearIndependent.pair_iff.mpr hab
  have hc : ∀ i, Λ (e i) = 0 := by
    intro i
    fin_cases i
    · exact LinearMap.ext ha
    · exact LinearMap.ext hb
  have h0 : e 0 = a := rfl
  have h1 : e 1 = b := rfl
  have := Laurent.latticeRing_uniqueFactorizationMonoid R (Fin 2)
  have h := exists_eq_mul_centralHom_mul (u := u) hΛ he hc
    (Laurent.isRelPrime_aeval_single
      (linearIndependent_single_single (i := (0 : Fin 2)) (j := 1) (by decide)) hp hq)
    (f := f)
    (by rwa [centralHom_aeval_single, h0])
    (by rwa [centralHom_aeval_single, h1])
  rwa [map_mul, centralHom_aeval_single, centralHom_aeval_single, h0, h1] at h

end
end TauCeti.QuantumTorus
