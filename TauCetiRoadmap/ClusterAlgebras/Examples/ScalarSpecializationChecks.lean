/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.Examples.PolynomialSeedChecks
public import TauCetiRoadmap.ClusterAlgebras.ClassicalFrame

/-!
# An integral nonreciprocal seed at parameter one

The coefficient ring is `ℤ`, the parameter is its unit one, and the ambient
field is an ordinary rational Laurent fraction field. The general polynomial
proof applies directly; it does not require a faithful `Zv` chart or invoke
the wordwise specialization theorem.
-/

@[expose] public section
namespace TauCeti.Examples.ScalarSpecializationChecks
open TauCeti TauCeti.Cluster TauCeti.Laurent
open PolynomialSeedChecks PolynomialQuantum
noncomputable section

/-- An ordinary commutative field with two independent Laurent coordinates. -/
abbrev ClassicalField := RationalLaurentField (Fin 2)

/-- The two classical coordinates as actual units. -/
def coordinates (a : Fin 2) : ClassicalFieldˣ :=
  Units.mk0 (rationalLaurentCoordinates (Fin 2) a)
    ((algebraicIndependent_rationalLaurentCoordinates (Fin 2)).ne_zero a)

/-- The nonreciprocal cubic over the integral scalar ring. -/
def exchangePolynomial : Polynomial ℤ := Polynomial.X ^ 3 + 2 * Polynomial.X + 1

theorem exchangePolynomial_degree : exchangePolynomial.natDegree = 3 := by
  unfold exchangePolynomial
  compute_degree!

theorem exchangePolynomial_monic : exchangePolynomial.Monic := by
  unfold exchangePolynomial
  monicity!

/-- A faithful integral seed at the unit parameter, with no quantization input. -/
def classicalCubicSeed : PolynomialExchangeSeed (u₀ := (1 : ℤˣ)) ClassicalField
    (Function.Embedding.refl (Fin 2)) where
  toExchangeFrame := commutativeFrame cubicExchange
    (by
      apply Matrix.linearIndependent_cols_of_det_ne_zero
        (A := cubicExchange.matrix.map (Int.castRingHom ℚ))
      norm_num [cubicExchange, Matrix.det_fin_two])
    (Int.castRingHom ℚ) Int.cast_injective (fun _ ↦ by simp)
    coordinates (algebraicIndependent_rationalLaurentCoordinates (Fin 2))
  polynomial := fun _ ↦ exchangePolynomial
  constant_one := fun _ ↦ by simp [exchangePolynomial]
  monic := fun _ ↦ exchangePolynomial_monic
  degree_pos := fun _ ↦ by rw [exchangePolynomial_degree]; norm_num
  degree_dvd := by
    intro i k
    rw [exchangePolynomial_degree]
    change (3 : ℤ) ∣ cubicExchange.matrix i k
    fin_cases i <;> fin_cases k <;> norm_num [cubicExchange]

/-- The common all-rank proof also proves integral classical Laurentness directly. -/
theorem classicalCubicSeed_laurent (u w : List (Fin 2)) (a : Fin 2) :
    ((mutateWord (fun k t ↦ PolynomialExchangeSeed.mutate t k) w
      classicalCubicSeed).coordinate a : ClassicalField) ∈
      (mutateWord (fun k t ↦ PolynomialExchangeSeed.mutate t k) u
        classicalCubicSeed).toExchangeFrame.chartRing :=
  classicalCubicSeed.coordinate_mutateWord_mem_mutateWord_chartRing u w a

/-- Coefficient reversal remains necessary at parameter one. -/
theorem classicalCubicSeed_reverse :
    ((classicalCubicSeed.mutate 0).polynomial 0).coeff 1 = 0 ∧
      (classicalCubicSeed.polynomial 0).coeff 1 = 2 := by
  change exchangePolynomial.reverse.coeff 1 = 0 ∧ exchangePolynomial.coeff 1 = 2
  rw [Polynomial.coeff_reverse, exchangePolynomial_degree,
    Polynomial.revAt_le (by decide : 1 ≤ 3)]
  norm_num [exchangePolynomial, Polynomial.coeff_one, Polynomial.coeff_X]

end
end TauCeti.Examples.ScalarSpecializationChecks
