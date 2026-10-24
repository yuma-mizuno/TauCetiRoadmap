/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.LocalCoprimality
public import Mathlib.RingTheory.Localization.FractionRing

/-! The local three-exchange calculation in an actual Laurent polynomial ring.
The third coordinate is constructed as a Laurent polynomial before mapping to a
field; its exchange equation and both coprimality assertions are proved here. -/

@[expose] public section

namespace TauCeti.Laurent

open Polynomial
open scoped LaurentPolynomial

noncomputable section

variable {S : Type*} [CommRing S]

/-- The first local exchanged coordinate E/T in a one-variable Laurent ring. -/
def firstLocal (E : S) : S[T;T⁻¹] :=
  LaurentPolynomial.C E * LaurentPolynomial.T (-1)

/-- The second local coordinate yinv times Q evaluated at the first local coordinate. -/
def secondLocal (E yinv : S) (Q : S[X]) : S[T;T⁻¹] :=
  LaurentPolynomial.C yinv * (Q.map LaurentPolynomial.C).eval (firstLocal E)

/-- The Laurent expression constructed by dividing the substitution polynomial by X and adding the
correction T*A.
-/
def thirdLocal (E A yinv : S) (Q R : S[X]) : S[T;T⁻¹] :=
  ((substitutionPolynomial Q R yinv).map LaurentPolynomial.C).divX.eval (firstLocal E) +
    LaurentPolynomial.T 1 * LaurentPolynomial.C A

theorem firstLocal_exchange (E : S) :
    LaurentPolynomial.C E = LaurentPolynomial.T 1 * firstLocal E := by
  simp [firstLocal]

theorem thirdLocal_exchange (E A yinv : S) (Q R : S[X])
    (hcompat : R.eval (yinv * Q.eval 0) = A * E) :
    firstLocal E * thirdLocal E A yinv Q R =
      (R.map LaurentPolynomial.C).eval (secondLocal E yinv Q) := by
  have hconstant :
      ((substitutionPolynomial Q R yinv).map LaurentPolynomial.C).eval 0 =
        LaurentPolynomial.C A * LaurentPolynomial.C E := by
    simpa [substitutionPolynomial, ← map_mul] using congrArg LaurentPolynomial.C hcompat
  have h := exact_cancellation_mul
    ((substitutionPolynomial Q R yinv).map LaurentPolynomial.C)
    (LaurentPolynomial.T 1) (firstLocal E) (LaurentPolynomial.C E)
    (LaurentPolynomial.C A) (firstLocal_exchange E) hconstant
  simpa [thirdLocal, substitutionPolynomial, secondLocal, Polynomial.map_comp,
    Polynomial.eval_comp] using h

theorem localStep_relPrime [IsDomain S] [UniqueFactorizationMonoid S]
    (E A yinv : S) (Q R : S[X]) (hE : E ≠ 0)
    (hq : IsRelPrime E (Q.eval 0)) (hA : IsRelPrime E A) (hy : IsUnit yinv) :
    IsRelPrime (firstLocal E) (secondLocal E yinv Q) ∧
      IsRelPrime (firstLocal E) (thirdLocal E A yinv Q R) :=
  local_coprimality Q (substitutionPolynomial Q R yinv) hE hq hA hy
    (firstLocal E) (firstLocal_exchange E)

/-- Mapping the constructed third Laurent polynomial to a field gives precisely
the third exchange quotient. The map need not extend to the whole fraction field. -/
theorem thirdLocal_fraction {F : Type*} [Field F] (φ : S[T;T⁻¹] →+* F)
    (E A yinv : S) (Q R : S[X])
    (hcompat : R.eval (yinv * Q.eval 0) = A * E)
    (hz : φ (firstLocal E) ≠ 0) :
    φ (thirdLocal E A yinv Q R) =
      φ ((R.map LaurentPolynomial.C).eval (secondLocal E yinv Q)) /
        φ (firstLocal E) := by
  apply (eq_div_iff hz).mpr
  have h := congrArg φ (thirdLocal_exchange E A yinv Q R hcompat)
  simpa only [map_mul, mul_comm] using h

end
end TauCeti.Laurent
