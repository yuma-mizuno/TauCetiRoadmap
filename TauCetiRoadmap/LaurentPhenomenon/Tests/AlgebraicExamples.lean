/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.AlgebraicCaterpillar

/-! # Algebraic Examples -/

@[expose] public section

namespace TauCeti.Laurent.AlgebraicExamples
open Polynomial
open scoped LaurentPolynomial

/-- A signed three-term exchange polynomial, beyond the positive setting. -/
noncomputable def signedQ : ℤ[X] := X ^ 2 - X + 1
/-- The signed third-exchange polynomial X squared minus X minus two. -/
noncomputable def signedR : ℤ[X] := X ^ 2 - X - C 2
/-- Its exact C2 compatibility has negative correction `A = -1`. -/
theorem signed_compatibility : signedR.eval ((1 : ℤ) * signedQ.eval 0) = (-1) * 2 := by
  simp [signedQ, signedR]

/-- The general local cancellation and relative-primality theorem applies to
these signed, three-term polynomials over the coefficient UFD `ℤ`. -/
theorem signed_local_certificate :
    firstLocal (2 : ℤ) * thirdLocal 2 (-1) 1 signedQ signedR =
      (signedR.map LaurentPolynomial.C).eval (secondLocal 2 1 signedQ) ∧
    IsRelPrime (firstLocal (2 : ℤ)) (secondLocal 2 1 signedQ) ∧
    IsRelPrime (firstLocal (2 : ℤ)) (thirdLocal 2 (-1) 1 signedQ signedR) := by
  refine ⟨thirdLocal_exchange 2 (-1) 1 signedQ signedR signed_compatibility, ?_⟩
  apply localStep_relPrime 2 (-1) 1 signedQ signedR (by decide)
  · simpa [signedQ] using (isRelPrime_one_right : IsRelPrime (2 : ℤ) 1)
  · exact (isUnit_one.neg : IsUnit (-1 : ℤ)).isRelPrime_right
  · exact isUnit_one

end TauCeti.Laurent.AlgebraicExamples
