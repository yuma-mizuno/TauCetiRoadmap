/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.PositiveCaterpillarRealization
public import Mathlib.Algebra.Group.PUnit
public import TauCetiRoadmap.ClusterAlgebras.NormalizedPattern
public import TauCetiRoadmap.ClusterAlgebras.Laurent

/-! # Caterpillar Checks -/

@[expose] public section

open TauCeti.Laurent
open TauCeti.Cluster

noncomputable section
namespace TauCeti.Cluster.Examples
open scoped BigOperators

/-- Four alternating rank-two mutations, beyond all C3 base lengths. -/
def a2Path : CaterpillarPath Bool where
  length := 4
  label k := k.val % 2 == 1
  reduced := by decide

/-- Natural-coefficient Laurent polynomials in the two coefficient-free A2 variables. -/
abbrev A2Laurent := PositiveLaurent PUnit Bool

/-- The nth integer power of the mutable variable indexed by i. -/
def a2X (i : Bool) (n : ℤ) : A2Laurent :=
  AddMonoidAlgebra.single (0, Finsupp.single i n) 1

/-- The A2 exchange polynomial, one plus the other mutable variable. -/
def a2Exchange (i : Bool) : A2Laurent := 1 + a2X (!i) 1
@[simp] theorem a2X_mutableSupport (i : Bool) (n : ℤ) :
    mutableSupport (a2X i n) = {Finsupp.single i n} := by
  simp [mutableSupport, a2X]

@[simp] theorem a2Exchange_support (i : Bool) :
    mutableSupport (a2Exchange i) = {0, Finsupp.single (!i) 1} := by
  classical
  rw [a2Exchange, mutableSupport_add]
  simp [mutableSupport, a2X]

theorem a2Exchange_ne_zero (i : Bool) : a2Exchange i ≠ 0 :=
  positive_add_ne_zero one_ne_zero

theorem a2Exchange_polynomial (i : Bool) : PositivePolynomialSupport (a2Exchange i) := by
  intro a ha k
  rw [a2Exchange_support] at ha
  simp only [Finset.mem_insert, Finset.mem_singleton] at ha
  rcases ha with rfl | rfl
  · simp
  · by_cases h : (!i) = k <;> simp [h]

theorem a2Exchange_independent (i : Bool) : PositiveIndependent (a2Exchange i) i := by
  intro a ha
  rw [a2Exchange_support] at ha
  simp only [Finset.mem_insert, Finset.mem_singleton] at ha
  rcases ha with rfl | rfl
  · simp
  · cases i <;> simp

theorem a2Exchange_no_factor (i : Bool) : PositiveNoVariableFactor (a2Exchange i) := by
  intro j
  refine ⟨0, ?_, by simp⟩
  rw [a2Exchange_support]
  simp

private theorem setZero_add (E R : A2Laurent) (i : Bool) :
    positiveSetZero (E + R) i = positiveSetZero E i + positiveSetZero R i := by
  ext t
  by_cases h : t.2 i = 0 <;> simp [positiveSetZero_coeff, h]

private theorem setZero_single (t : PUnit × (Bool →₀ ℤ)) (n : ℕ) (i : Bool) :
    positiveSetZero (AddMonoidAlgebra.single t n) i =
      if t.2 i = 0 then AddMonoidAlgebra.single t n else 0 := by
  by_cases h : t.2 i = 0
  · simp [positiveSetZero, Finsupp.filter_single_of_pos, h]
  · simp [positiveSetZero, Finsupp.filter_single_of_neg, h]

private theorem setZero_one (i : Bool) : positiveSetZero (1 : A2Laurent) i = 1 := by
  change positiveSetZero (AddMonoidAlgebra.single 0 1) i = 1
  rw [setZero_single]
  rfl

private theorem a2_q0 (i j : Bool) (hij : i ≠ j) :
    positiveSetZero (a2Exchange j) i = 1 := by
  rw [a2Exchange, setZero_add, setZero_one, a2X, setZero_single]
  cases i <;> cases j <;> simp_all

private theorem substitute_add (E R q : A2Laurent) (j : Bool) :
    positiveSubstitute (E + R) q j = positiveSubstitute E q j + positiveSubstitute R q j := by
  unfold positiveSubstitute
  exact Finsupp.sum_hom_add_index (positiveSubstitutionTerm q j)

private theorem substitute_single (t : PUnit × (Bool →₀ ℤ)) (n : ℕ)
    (q : A2Laurent) (j : Bool) :
    positiveSubstitute (AddMonoidAlgebra.single t n) q j = positiveSubstitutionTerm q j t n := by
  simp [positiveSubstitute]

private theorem substitute_one (q : A2Laurent) (j : Bool) :
    positiveSubstitute 1 q j = 1 := by
  change positiveSubstitute (AddMonoidAlgebra.single 0 1) q j = 1
  rw [substitute_single]
  simp [positiveSubstitutionTerm, reflectedExponent]
  rfl

private theorem substitute_a2X (j : Bool) :
    positiveSubstitute (a2X j 1) 1 j = a2X j (-1) := by
  rw [a2X, substitute_single]
  simp [positiveSubstitutionTerm, reflectedExponent_self, a2X]

private theorem a2X_mul (j : Bool) (a b : ℤ) :
    a2X j a * a2X j b = a2X j (a + b) := by
  simp [a2X, AddMonoidAlgebra.single_mul_single, Finsupp.single_add]

private theorem a2_compatibility (i j : Bool) (hij : i ≠ j) :
    a2Exchange i = positivePropagate (a2X j 1) (a2Exchange i)
      (positiveSetZero (a2Exchange j) i) j := by
  rw [a2_q0 i j hij]
  have ho : (!i) = j := by cases i <;> cases j <;> simp_all
  simp only [positivePropagate, a2Exchange, ho, substitute_add, substitute_one, substitute_a2X,
    mul_add, mul_one, a2X_mul]
  have hz : a2X j (1 + -1) = 1 := by simp [a2X]; rfl
  rw [hz]
  exact add_comm _ _

/-- Coefficient-free A2 exchange data satisfy the full positive caterpillar
    assumptions on a path of length four, with H=X_j. -/
def a2PositiveCaterpillar : PositiveCaterpillar PUnit a2Path where
  exchange _ := a2Exchange
  exchange_ne_zero _ := a2Exchange_ne_zero
  exchange_polynomial _ := a2Exchange_polynomial
  exchange_independent _ := a2Exchange_independent
  exchange_no_factor _ := a2Exchange_no_factor
  exchange_undirected _ := rfl
  correction p _ := a2X (a2Path.middleLabel p) 1
  correction_ne_zero _ _ _ := AddMonoidAlgebra.single_eq_zero.not.mpr one_ne_zero
  correction_independent p i hi := by
    intro a ha
    rw [a2X_mutableSupport] at ha
    have he : a = Finsupp.single (a2Path.middleLabel p) 1 := Finset.mem_singleton.mp ha
    rw [he]
    simp [Ne.symm hi]
  correction_nonnegative p i _ := by
    intro a ha
    rw [a2X_mutableSupport] at ha
    have he : a = Finsupp.single (a2Path.middleLabel p) 1 := Finset.mem_singleton.mp ha
    rw [he]
    simp
  compatibility p i hi := by exact a2_compatibility i (a2Path.middleLabel p) hi

/-- The length-four fixture genuinely reaches the inductive regime. -/
example : 3 ≤ a2Path.length := by decide

/-- Its fresh generic deformation specializes on the last actual edge. -/
example : coefficientMap (a2PositiveCaterpillar.liftMap (by decide))
    ((a2PositiveCaterpillar.deform (by decide)).exchange
      (a2Path.spine ⟨3, by decide⟩) (a2Path.label ⟨3, by decide⟩)) =
    a2PositiveCaterpillar.exchange (a2Path.spine ⟨3, by decide⟩) (a2Path.label ⟨3, by decide⟩) :=
  a2PositiveCaterpillar.deform_specializes_edge (by decide)
    (CaterpillarPath.Edge.path_forward ⟨3, by decide⟩)

/-- Multiplicity two is lifted using two separate parameter atoms. -/
def coefficientTwo : A2Laurent := AddMonoidAlgebra.single 0 2
/-- The first occurrence of the coefficient two, given its own free parameter. -/
def coefficientTwoFirstAtom : PositiveAtom coefficientTwo :=
  ⟨⟨0, by simp [coefficientTwo]⟩, ⟨0, by simp [coefficientTwo]⟩⟩

/-- The second occurrence of the coefficient two, with a parameter distinct from the first. -/
def coefficientTwoSecondAtom : PositiveAtom coefficientTwo :=
  ⟨⟨0, by simp [coefficientTwo]⟩, ⟨1, by simp [coefficientTwo]⟩⟩

example : coefficientTwoFirstAtom ≠ coefficientTwoSecondAtom := by decide
/-- The two distinct parameters recover the nonunit integer coefficient 2. -/
example : AddMonoidAlgebra.mapDomainRingHom ℕ (atomExponentMap coefficientTwo)
    (atomLift coefficientTwo) = AddMonoidAlgebra.single 0 2 :=
  atomLift_specializes coefficientTwo

section ConstantTwo
variable {J : Type*} [DecidableEq J]

/-- The constant positive exchange polynomial two, in an arbitrary mutable index type. -/
def constantTwoExchange : PositiveLaurent PUnit J := AddMonoidAlgebra.single 0 2
omit [DecidableEq J] in
private theorem constantTwo_support : mutableSupport (constantTwoExchange (J := J)) = {0} := by
  simp [constantTwoExchange, mutableSupport]

omit [DecidableEq J] in
private theorem constantTwo_substitute (q : PositiveLaurent PUnit J) (j : J) :
    positiveSubstitute constantTwoExchange q j = constantTwoExchange := by
  simp only [positiveSubstitute, constantTwoExchange, AddMonoidAlgebra.coeff_single,
    positiveSubstitutionTerm, reflectedExponent, multiplesHom_apply, nsmul_eq_mul, Nat.cast_zero,
    Prod.fst_zero, PUnit.zero_eq, Prod.snd_zero, Finsupp.coe_zero, Pi.zero_apply, mul_zero,
    Finsupp.single_zero, sub_self, Int.toNat_zero, pow_zero, mul_one, zero_mul,
    Finsupp.sum_single_index, Nat.cast_ofNat]
  ext t
  simp only [AddMonoidAlgebra.coeff_mul_single_apply, AddMonoidAlgebra.coeff_ofNat, Prod.neg_mk,
    PUnit.neg_eq, neg_zero, mul_one, AddMonoidAlgebra.coeff_single]
  exact congrArg (Finsupp.single 0 2) (add_zero t)

/-- Zero exchange matrix: every direction has exchange polynomial 2.
    Coprimality in the original integer ring fails, so the generic deformation
    and positive specialization are essential. -/
def constantTwoPattern (P : CaterpillarPath J) : PositiveCaterpillar PUnit P where
  exchange _ _ := constantTwoExchange
  exchange_ne_zero _ _ := AddMonoidAlgebra.single_eq_zero.not.mpr (by decide)
  exchange_polynomial _ _ := by
    intro a ha j
    rw [constantTwo_support] at ha
    have hz : a = 0 := Finset.mem_singleton.mp ha
    simp [hz]
  exchange_independent _ _ := by
    intro a ha
    rw [constantTwo_support] at ha
    have hz : a = 0 := Finset.mem_singleton.mp ha
    simp [hz]
  exchange_no_factor _ _ := by
    intro j
    exact ⟨0, by rw [constantTwo_support]; simp, by simp⟩
  exchange_undirected _ := rfl
  correction _ _ := 1
  correction_ne_zero _ _ _ := one_ne_zero
  correction_independent _ _ _ := by simp [PositiveIndependent, mutableSupport]
  correction_nonnegative _ _ _ := by simp [PositiveNonnegativeAt, mutableSupport]
  compatibility _ _ _ := by simp [positivePropagate, constantTwo_substitute]

end ConstantTwo

/-- Length three reaches the repeated-label/drop-three induction branch. -/
def repeatedLabelPath : CaterpillarPath Bool where
  length := 3
  label k := k.val % 2 == 1
  reduced := by decide

/-- Three distinct labels reach the actual detour induction branch. -/
def detourPath : CaterpillarPath (Fin 3) where
  length := 3
  label k := k
  reduced := by decide

/-- Constant-two exchanges on the four-edge A2-labelled path. -/
def constantTwoLengthFour := constantTwoPattern a2Path
/-- Constant-two exchanges on the path whose first and third labels agree. -/
def constantTwoRepeated := constantTwoPattern repeatedLabelPath
/-- Constant-two exchanges on the path with an additional detour. -/
def constantTwoDetour := constantTwoPattern detourPath
example : repeatedLabelPath.firstLabel (by decide) = repeatedLabelPath.thirdLabel (by decide) := by
  decide

example : detourPath.firstLabel (by decide) ≠ detourPath.thirdLabel (by decide) := by decide

section NormalizedFixtures
/-- The one-element coefficient semifield, with its unique multiplication and auxiliary addition. -/
local instance trivialCoefficientSemifield : CoefficientSemifield PUnit where
  toCommGroup := inferInstance
  toAddCommSemigroup := inferInstance
  left_distrib _ _ _ := rfl
  right_distrib _ _ _ := rfl

/-- The skew-symmetric rank-two A2 exchange matrix. -/
def a2Matrix (h k : Bool) : ℤ := if h = k then 0 else if h then -1 else 1
/-- The normalized two-direction A2 mutation data, with trivial coefficients. -/
def normalizedA2Local (i j : Bool) (hij : i ≠ j) : NormalizedLocalMutation PUnit Bool i j where
  distinct := hij
  before := a2Matrix
  after h k := -a2Matrix h k
  coefficient _ := 1
  coefficientAfter _ := 1
  diagonal k := by simp [a2Matrix]
  diagonalAfter k := by simp [a2Matrix]
  signSkew h k := by cases h <;> cases k <;> simp [SignSkewAt, a2Matrix]
  matrixLaw := by
    funext h k
    cases i <;> cases j <;> cases h <;> cases k <;>
      simp_all [a2Matrix, matrixMutation, positivePart]
  coefficientLaw := Subsingleton.elim _ _

/-- Commuting rank-two local mutation data with the zero exchange matrix. -/
def normalizedZeroLocal : NormalizedLocalMutation PUnit Bool false true where
  distinct := by decide
  before _ _ := 0
  after _ _ := 0
  coefficient _ := 1
  coefficientAfter _ := 1
  diagonal _ := rfl
  diagonalAfter _ := rfl
  signSkew _ _ := Or.inl ⟨rfl, rfl⟩
  matrixLaw := by funext h k; simp [matrixMutation, positivePart]
  coefficientLaw := Subsingleton.elim _ _

/-- Exact normalized C8 correction exists in the negative-entry orientation. -/
example : ∃ H : PositiveLaurent (Additive PUnit) Bool, H ≠ 0 ∧ PositiveIndependent H false ∧
    PositiveNonnegativeAt H true ∧
    seedExchange (1 : PUnit) (fun h => -a2Matrix h false) =
      positivePropagate H (seedExchange 1 (fun h => a2Matrix h false))
        (positiveSetZero (seedExchange 1 (fun h => a2Matrix h true)) false) true :=
  (normalizedA2Local false true (by decide)).correction_exists

/-- The opposite orientation exercises the positive-entry branch. -/
example : ∃ H : PositiveLaurent (Additive PUnit) Bool, H ≠ 0 ∧ PositiveIndependent H true ∧
    PositiveNonnegativeAt H false ∧
    seedExchange (1 : PUnit) (fun h => -a2Matrix h true) =
      positivePropagate H (seedExchange 1 (fun h => a2Matrix h true))
        (positiveSetZero (seedExchange 1 (fun h => a2Matrix h false)) true) false :=
  (normalizedA2Local true false (by decide)).correction_exists

/-- Zero matrix entries exercise the separate H=1 branch. -/
example : ∃ H : PositiveLaurent (Additive PUnit) Bool, H ≠ 0 ∧ PositiveIndependent H false ∧
    PositiveNonnegativeAt H true ∧
    seedExchange (1 : PUnit) (fun _ : Bool => 0) =
      positivePropagate H (seedExchange 1 (fun _ : Bool => 0))
        (positiveSetZero (seedExchange 1 (fun _ : Bool => 0)) false) true :=
  normalizedZeroLocal.correction_exists

/-- Rank-two skew-symmetrizable matrices of types A2, B2 and G2. -/
def rankTwoMatrix (n : ℤ) (h k : Bool) : ℤ :=
  if h = k then 0 else if h then -n else 1

/-- Rank-two normalized mutation data with a positive integer exchange multiplicity. -/
def normalizedRankTwoLocal (n : ℤ) (hn : 0 < n) (i j : Bool) (hij : i ≠ j) :
    NormalizedLocalMutation PUnit Bool i j where
  distinct := hij
  before := rankTwoMatrix n
  after h k := -rankTwoMatrix n h k
  coefficient _ := 1
  coefficientAfter _ := 1
  diagonal k := by simp [rankTwoMatrix]
  diagonalAfter k := by simp [rankTwoMatrix]
  signSkew h k := by
    cases h <;> cases k <;> simp [SignSkewAt, rankTwoMatrix] <;> omega
  matrixLaw := by
    funext h k
    cases i <;> cases j <;> cases h <;> cases k <;>
      simp_all [rankTwoMatrix, matrixMutation, positivePart] <;> omega
  coefficientLaw := Subsingleton.elim _ _

/-- Each rank-two magnitude and both signs produce an actual positive correction. -/
theorem rankTwo_correction (n : ℤ) (hn : 0 < n) (i j : Bool) (hij : i ≠ j) :
    ∃ H : PositiveLaurent (Additive PUnit) Bool, H ≠ 0 ∧ PositiveIndependent H i ∧
      PositiveNonnegativeAt H j ∧
      seedExchange (1 : PUnit) (fun h => -rankTwoMatrix n h i) =
        positivePropagate H (seedExchange 1 (fun h => rankTwoMatrix n h i))
          (positiveSetZero (seedExchange 1 (fun h => rankTwoMatrix n h j)) i) j :=
  (normalizedRankTwoLocal n hn i j hij).correction_exists

example := rankTwo_correction 1 (by decide) false true (by decide)
example := rankTwo_correction 1 (by decide) true false (by decide)
example := rankTwo_correction 2 (by decide) false true (by decide)
example := rankTwo_correction 2 (by decide) true false (by decide)
example := rankTwo_correction 3 (by decide) false true (by decide)
example := rankTwo_correction 3 (by decide) true false (by decide)

end NormalizedFixtures
/-- The nonconstant A2 fixture reaches the final public Laurent theorem. -/
theorem a2_laurent (k : Bool) :
    a2PositiveCaterpillar.value (canonicalMap (G := PUnit.{1}) (I := Bool))
        a2Path.target k ∈
      chartRing (coefficientRange
        (canonicalMap (G := PUnit.{1}) (I := Bool)))
        (a2PositiveCaterpillar.value
          (canonicalMap (G := PUnit.{1}) (I := Bool)) a2Path.source) :=
  a2PositiveCaterpillar.canonical_laurent k

/-- Common integer factor 2 in every original exchange does not obstruct Laurentness. -/
theorem constantTwo_laurent {J : Type} [DecidableEq J] [Finite J]
    (P : CaterpillarPath J) (k : J) :
    (constantTwoPattern P).value (canonicalMap (G := PUnit.{1}) (I := J))
        P.target k ∈
      chartRing (coefficientRange
        (canonicalMap (G := PUnit.{1}) (I := J)))
        ((constantTwoPattern P).value
          (canonicalMap (G := PUnit.{1}) (I := J)) P.source) :=
  (constantTwoPattern P).canonical_laurent k

/-- The same fixture accepts every positive-preserving specialization, including
ones which identify coefficient parameters. -/
theorem constantTwo_specialized_laurent {J F : Type} [DecidableEq J] [Finite J] [Field F]
    (P : CaterpillarPath J) (f : TotalLaurentRing PUnit.{1} J →+* F)
    (hf : ∀ p, positiveCast p ≠ 0 → f (positiveCast p) ≠ 0) (k : J) :
    (constantTwoPattern P).value f P.target k ∈
      chartRing (coefficientRange f)
        ((constantTwoPattern P).value f P.source) :=
  (constantTwoPattern P).laurent f hf k

example (k : Bool) := constantTwo_laurent a2Path k
example (k : Bool) := constantTwo_laurent repeatedLabelPath k
example (k : Fin 3) := constantTwo_laurent detourPath k

end TauCeti.Cluster.Examples
