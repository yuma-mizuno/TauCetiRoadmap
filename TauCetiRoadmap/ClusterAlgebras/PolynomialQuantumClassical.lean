/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.PolynomialQuantumSpecialization
public import TauCetiRoadmap.LaurentPhenomenon.Birational
public import Mathlib.Algebra.MvPolynomial.Variables

/-!
# Faithful classical charts for polynomial quantum specialization

Scalar polynomial exchanges with distinct exponent vectors are nonzero polynomial
numerators independent of the selected coordinate. Thus classical algebraic
independence propagates, and denominators in wordwise specialization are nonzero.
-/

@[expose] public section

namespace TauCeti.Cluster.PolynomialQuantumSeed

open TauCeti TauCeti.QuantumTorus TauCeti.Laurent

noncomputable section

variable {D : Type*} [DivisionRing D] [Algebra Zv D]
  {M K : Type*} [Fintype M] [DecidableEq M] {row : K ↪ M}
  (s : PolynomialQuantumSeed D row)

/-- Natural exponent vector of a homogeneous exchange summand. -/
def numeratorDegree (k : K) (l : ℕ) : M →₀ ℕ :=
  Finsupp.equivFunOnFinite.symm fun a ↦
    (s.exchangeExponent k l + Pi.single (row k) 1 : M → ℤ) a |>.toNat

@[simp] theorem numeratorDegree_apply (k : K) (l : ℕ) (a : M) :
    s.numeratorDegree k l a =
      ((s.exchangeExponent k l + Pi.single (row k) 1 : M → ℤ) a).toNat := by
  simp [numeratorDegree]

theorem numeratorDegree_injectiveOn (k : K) :
    Set.InjOn (s.numeratorDegree k) {l | l ≤ s.degree k} := by
  intro l hl m hm h
  apply s.exchangeExponent_injective k
  apply add_right_cancel (b := Pi.single (row k) 1)
  funext a
  have h' := congrArg (fun f : M →₀ ℕ ↦ (f a : ℤ)) h
  simpa only [numeratorDegree_apply,
    Int.toNat_of_nonneg (s.exchange_numerator_exponent_nonneg k hl a),
    Int.toNat_of_nonneg (s.exchange_numerator_exponent_nonneg k hm a)] using h'

/-- The classical homogeneous exchange numerator, as an ordinary polynomial over `ℚ`. -/
def classicalExchangePolynomial (k : K) : MvPolynomial M ℚ :=
  ∑ l ∈ Finset.range (s.degree k + 1),
    MvPolynomial.monomial (s.numeratorDegree k l) (evalOne ((s.polynomial k).coeff l) : ℚ)

theorem classicalExchangePolynomial_ne_zero (k : K) :
    s.classicalExchangePolynomial k ≠ 0 := by
  intro h
  have hc := congrArg (fun f : MvPolynomial M ℚ ↦ f.coeff (s.numeratorDegree k 0)) h
  simp only [classicalExchangePolynomial, AddMonoidAlgebra.coeff_sum, Finsupp.finsetSum_apply] at hc
  rw [Finset.sum_eq_single 0] at hc
  · simp [s.constant_one] at hc
  · intro l hl hne
    rw [MvPolynomial.coeff_monomial]
    apply ite_eq_right
    intro he
    exact hne (s.numeratorDegree_injectiveOn k (x₁ := l) (x₂ := 0)
      (Nat.le_of_lt_succ (Finset.mem_range.mp hl)) (Nat.zero_le _) he)
  · simp

theorem classicalExchangePolynomial_independent (k : K) :
    row k ∉ (s.classicalExchangePolynomial k).vars := by
  intro h
  have hsub := MvPolynomial.vars_sum_subset (Finset.range (s.degree k + 1))
    (fun l ↦ MvPolynomial.monomial (s.numeratorDegree k l)
      (evalOne ((s.polynomial k).coeff l) : ℚ))
  obtain ⟨l, _, hl⟩ := Finset.mem_biUnion.mp (hsub h)
  have hdegree : row k ∈ (s.numeratorDegree k l).support := by
    by_cases hc : (evalOne ((s.polynomial k).coeff l) : ℚ) = 0
    · simp [hc] at hl
    · rwa [MvPolynomial.vars_monomial hc] at hl
  simp [s.exchangeExponent_row] at hdegree

variable {F : Type*} [Field F] [Algebra ℚ F]

theorem aeval_classicalExchangePolynomial (k : K) (x : M → F) :
    MvPolynomial.aeval x (s.classicalExchangePolynomial k) =
      polynomialGeometricNumerator s.degree (s.classicalData x) k := by
  rw [classicalExchangePolynomial, map_sum, polynomialGeometricNumerator]
  apply Finset.sum_congr rfl
  intro l _
  rw [MvPolynomial.aeval_monomial, Finsupp.prod_fintype _ _ (fun _ ↦ pow_zero _)]
  simp only [map_intCast, classicalData, Polynomial.coeff_map]
  congr 1
  apply Finset.prod_congr rfl
  intro a _
  rw [numeratorDegree_apply, s.exchange_numerator_exponent]

variable [Fintype K] [DecidableEq K]

omit [Fintype K] in
/-- Algebraic independence propagates through the independent classical polynomial pattern. -/
theorem algebraicIndependent_polynomialGeometricPattern [Finite K] {x : M → F}
    (hx : AlgebraicIndependent ℚ x) (w : List K) :
    AlgebraicIndependent ℚ
      (polynomialGeometricPattern row s.degree (s.classicalData x) w).coordinate := by
  let : Fintype K := Fintype.ofFinite K
  induction w using List.reverseRecOn with
  | nil => exact hx
  | append_singleton w k ih =>
    set t := mutateWord (fun k t ↦ PolynomialQuantumSeed.mutate t k) w s
    set p := polynomialGeometricPattern row s.degree (s.classicalData x) w
    have hmeta := s.mutateWord_classicalData x w
    change t.exchange.matrix = p.exchange ∧
      (fun k ↦ (t.polynomial k).map evalOne) = p.polynomial at hmeta
    have hd : t.degree = s.degree := funext (s.mutateWord_degree w)
    have hp : t.classicalData p.coordinate = p := by
      apply PolynomialGeometricData.ext
      · exact hmeta.1
      · exact hmeta.2
      · rfl
    rw [polynomialGeometricPattern_append]
    change AlgebraicIndependent ℚ (Function.update p.coordinate (row k)
      (polynomialGeometricNumerator s.degree p k / p.coordinate (row k)))
    rw [← hp, ← hd, ← t.aeval_classicalExchangePolynomial]
    exact algebraicIndependent_update_exchange ih (row k) _
      (t.classicalExchangePolynomial_ne_zero k) (t.classicalExchangePolynomial_independent k)

variable {s}

/-- For genuine independent classical variables, no denominator hypothesis is needed. -/
theorem mutateWord_chartSpecializes_of_independent
    (ε : AddMonoidAlgebra ℤ (M → ℤ) →+* F) {x : M → F}
    (hε : ∀ a, ε (AddMonoidAlgebra.single (Pi.single a 1) 1) = x a)
    (hx : AlgebraicIndependent ℚ x) (w : List K) (a : M) :
    ChartSpecializes s.toQuantumSeed.chart ε
      ((mutateWord (fun k t ↦ PolynomialQuantumSeed.mutate t k) w s).coordinate a : D)
      ((polynomialGeometricPattern row s.degree (s.classicalData x) w).coordinate a) :=
  mutateWord_chartSpecializes ε hε w
    (fun u k _ ↦ (s.algebraicIndependent_polynomialGeometricPattern hx u).ne_zero (row k)) a

end
end TauCeti.Cluster.PolynomialQuantumSeed
