import Mathlib.Algebra.Category.Grp.Limits
import Mathlib.Algebra.Lie.Free
import Mathlib.Algebra.Lie.Graded
import Mathlib.Algebra.Lie.Nilpotent
import Mathlib.Algebra.Lie.Quotient
import Mathlib.Analysis.Normed.Module.FiniteDimension
import Mathlib.Basic.Sign.Basic
import Mathlib.Topology.Sheaves.Limits
import Mathlib.Topology.Sheaves.LocalPredicate
import TauCeti.Algebra.Lie.InnerAutomorphism
import TauCeti.Algebra.Lie.Quotient
import TauCeti.Algebra.Lie.UniversalEnveloping.PBW.Embedding

/-!
# Wall-crossing structures: suggested Lean forms

**This file is not the roadmap and is not exhaustive.** The definitive specification is
`README.md`. These declarations suggest Lean forms for selected carriers and statements;
proving them all would not by itself complete the roadmap. Required material absent here
remains required by the README.

The group carrier is the BCH group of an actual graded Lie-algebra quotient. Admitted
definitions and proofs mark proposed constructions, not additional axioms imposed on an
abstract wall-crossing datum. The finite WCS sheaf is built with Mathlib's local-predicate
API, and the completed sheaf is a limit in its existing category of sheaves of types.
The middle projection and the classification equivalences are maps of sets. In particular,
no pointwise group law on the WCS sheaf is asserted.
-/

noncomputable section

open CategoryTheory CategoryTheory.Limits Opposite TopologicalSpace

namespace TauCetiRoadmap.WallCrossing

universe u

/-! ## §0.1: positive gradings and their quotient tower -/

/-- A positive monoid with finitely many lattice degrees at every order. -/
structure PositiveDegrees (N : Type*) [AddCommGroup N] where
  monoid : AddSubmonoid N
  degree : N →+ ℤ
  degree_pos : ∀ n ∈ monoid, n ≠ 0 → 0 < degree n
  finite_cutoff : ∀ k : ℕ, {n : N | n ∈ monoid ∧ degree n ≤ (k : ℤ)}.Finite

namespace PositiveDegrees

variable {N : Type*} [AddCommGroup N] (D : PositiveDegrees N)

def positive : Set N := {n | n ∈ D.monoid ∧ n ≠ 0}

/-- Includes only the nonzero degrees; zero is never an active wall degree. -/
def activeDegrees (k : ℕ) : Finset N :=
  ((D.finite_cutoff k).subset (by
    intro n hn
    exact ⟨hn.1.1, hn.2⟩) :
      {n : N | n ∈ D.positive ∧ D.degree n ≤ (k : ℤ)}.Finite).toFinset

@[simp] theorem mem_activeDegrees (k : ℕ) (n : N) :
    n ∈ D.activeDegrees k ↔ n ∈ D.positive ∧ D.degree n ≤ (k : ℤ) := by
  simp [activeDegrees]

theorem sharp {n : N} (hn : n ∈ D.monoid) (hneg : -n ∈ D.monoid) : n = 0 := by
  by_contra h
  have hp := D.degree_pos n hn h
  have hm := D.degree_pos (-n) hneg (neg_ne_zero.mpr h)
  rw [map_neg] at hm
  omega

end PositiveDegrees

section GradedLie

variable {R N g : Type*} [CommRing R] [AddCommGroup N] [DecidableEq N]
  [LieRing g] [LieAlgebra R g] (D : PositiveDegrees N) (ℒ : N → Submodule R g)

/-- The grading is Mathlib's `GradedLieAlgebra`; this is its positive-support condition. -/
class IsPositiveGrading : Prop where
  eq_bot_of_notMem : ∀ n, n ∉ D.positive → ℒ n = ⊥

def degreeSubmodule (k : ℕ) : Submodule R g :=
  ⨆ n, ⨆ (_ : (k : ℤ) < D.degree n), ℒ n

theorem degreeSubmodule_lie_mem [GradedLieAlgebra ℒ] [IsPositiveGrading D ℒ]
    (k : ℕ) (x y : g) (hy : y ∈ degreeSubmodule D ℒ k) :
    ⁅x, y⁆ ∈ degreeSubmodule D ℒ k := by
  sorry

variable [GradedLieAlgebra ℒ] [IsPositiveGrading D ℒ]

/-- The Lie ideal `F^(k+1) g` of degrees strictly greater than `k`. -/
def degreeIdeal (k : ℕ) : LieIdeal R g :=
  { degreeSubmodule D ℒ k with
    lie_mem := fun {x y} hy => degreeSubmodule_lie_mem D ℒ k x y hy }

abbrev TruncatedLie (k : ℕ) := g ⧸ degreeIdeal D ℒ k

instance truncatedLie_nilpotent (k : ℕ) : LieRing.IsNilpotent (TruncatedLie D ℒ k) := by
  sorry

theorem degreeIdeal_antitone : Antitone (degreeIdeal D ℒ) := by
  intro i j hij
  change degreeSubmodule D ℒ j ≤ degreeSubmodule D ℒ i
  refine iSup_le fun n => iSup_le fun hn => ?_
  exact le_iSup_of_le n (le_iSup_of_le (show (i : ℤ) < D.degree n by omega) le_rfl)

/-- The quotient map at a finite order, as a Lie algebra morphism. -/
def quotientLieMap (k : ℕ) : g →ₗ⁅R⁆ TruncatedLie D ℒ k :=
  (degreeIdeal D ℒ k).mkQ

/-- Quotient transition, with the induced map on the existing quotient carrier. -/
def truncateLieMap {i j : ℕ} (hij : i ≤ j) :
    TruncatedLie D ℒ j →ₗ⁅R⁆ TruncatedLie D ℒ i :=
  (degreeIdeal D ℒ j).liftQ (degreeIdeal D ℒ i).mkQ (by
    rw [LieIdeal.ker_mkQ]
    exact degreeIdeal_antitone D ℒ hij)

@[simp] theorem truncateLieMap_quotient {i j : ℕ} (hij : i ≤ j) (x : g) :
    truncateLieMap D ℒ hij (quotientLieMap D ℒ j x) = quotientLieMap D ℒ i x := rfl

end GradedLie

/-! ## §0.2: universal rational BCH and the groups of the truncations -/

/-- The homogeneous length-`n` term of the universal rational BCH Lie series. The README
specifies it by the degree-`n` term of `log (exp X * exp Y)` in free associative words. -/
def universalBCHTerm (n : ℕ) : FreeLieAlgebra ℚ (Fin 2) := by
  sorry

@[simp] theorem universalBCHTerm_zero : universalBCHTerm 0 = 0 := by
  sorry

theorem universalBCHTerm_one : universalBCHTerm 1 =
    FreeLieAlgebra.of ℚ (0 : Fin 2) + FreeLieAlgebra.of ℚ (1 : Fin 2) := by
  sorry

theorem universalBCHTerm_two : universalBCHTerm 2 =
    (1 / 2 : ℚ) • ⁅FreeLieAlgebra.of ℚ (0 : Fin 2), FreeLieAlgebra.of ℚ (1 : Fin 2)⁆ := by
  sorry

/-- Existing PBW supplies the faithful universal test over `ℚ`; no freeness is imposed on
the homogeneous modules of the eventual coefficient algebra. -/
example : Function.Injective
    (UniversalEnvelopingAlgebra.ι ℚ : FreeLieAlgebra ℚ (Fin 2) →
      UniversalEnvelopingAlgebra ℚ (FreeLieAlgebra ℚ (Fin 2))) :=
  TauCeti.UniversalEnvelopingAlgebra.ι_injective ℚ _

section BCH

variable (R L : Type*) [CommRing R] [Algebra ℚ R] [LieRing L] [LieAlgebra R L]

/-- Evaluation of a universal rational Lie polynomial, using the existing scalar restriction. -/
def evalRationalLie (x y : L) (p : FreeLieAlgebra ℚ (Fin 2)) : L :=
  letI := TauCeti.ratLieAlgebra R L
  FreeLieAlgebra.lift ℚ (fun i => if i = 0 then x else y) p

variable [LieRing.IsNilpotent L]

/-- The finite sum of the universal terms through a nilpotency bound. Independence of the
chosen bound is one of the BCH targets. -/
def bch (R L : Type*) [CommRing R] [Algebra ℚ R] [LieRing L] [LieAlgebra R L]
    [LieRing.IsNilpotent L] (x y : L) : L := by
  sorry

theorem bch_eq_sum (c : ℕ) (hc : LieModule.lowerCentralSeries R L L c = ⊥) (x y : L) :
    bch R L x y = ∑ n ∈ Finset.range (c + 1),
      evalRationalLie R L x y (universalBCHTerm n) := by
  sorry

@[simp] theorem bch_zero_left (x : L) : bch R L 0 x = x := by sorry
@[simp] theorem bch_zero_right (x : L) : bch R L x 0 = x := by sorry
@[simp] theorem bch_neg_left (x : L) : bch R L (-x) x = 0 := by sorry

theorem bch_assoc (x y z : L) :
    bch R L (bch R L x y) z = bch R L x (bch R L y z) := by
  sorry

/-- A separate multiplicative carrier, so its multiplication cannot be confused with addition. -/
@[ext] structure BCHGroup (R L : Type*) where
  log : L

instance : Group (BCHGroup R L) where
  mul x y := ⟨bch R L x.log y.log⟩
  one := ⟨0⟩
  inv x := ⟨-x.log⟩
  mul_assoc x y z := BCHGroup.ext (bch_assoc R L x.log y.log z.log)
  one_mul x := BCHGroup.ext (bch_zero_left R L x.log)
  mul_one x := BCHGroup.ext (bch_zero_right R L x.log)
  inv_mul_cancel x := BCHGroup.ext (bch_neg_left R L x.log)

def expBCH : L ≃ BCHGroup R L where
  toFun := BCHGroup.mk
  invFun := BCHGroup.log
  left_inv _ := rfl
  right_inv _ := rfl

theorem bch_mem (H : LieSubalgebra R L) {x y : L} (hx : x ∈ H) (hy : y ∈ H) :
    bch R L x y ∈ H := by
  sorry

/-- BCH subgroup attached to an actual Lie subalgebra. -/
def bchSubgroup (H : LieSubalgebra R L) : Subgroup (BCHGroup R L) where
  carrier := {x | x.log ∈ H}
  one_mem' := H.zero_mem
  mul_mem' := fun hx hy => bch_mem R L H hx hy
  inv_mem' := fun hx => H.neg_mem hx

variable {R L} {L' : Type*} [LieRing L'] [LieAlgebra R L'] [LieRing.IsNilpotent L']

theorem map_bch (f : L →ₗ⁅R⁆ L') (x y : L) :
    f (bch R L x y) = bch R L' (f x) (f y) := by
  sorry

def bchMap (f : L →ₗ⁅R⁆ L') : BCHGroup R L →* BCHGroup R L' where
  toFun x := ⟨f x.log⟩
  map_one' := BCHGroup.ext (map_zero f)
  map_mul' x y := BCHGroup.ext (map_bch f x.log y.log)

end BCH

/-! ## §0.3: the completed group -/

section GroupTower

variable {R N g : Type*} [CommRing R] [Algebra ℚ R] [AddCommGroup N] [DecidableEq N]
  [LieRing g] [LieAlgebra R g] (D : PositiveDegrees N) (ℒ : N → Submodule R g)
  [GradedLieAlgebra ℒ] [IsPositiveGrading D ℒ]

abbrev TruncatedGroup (k : ℕ) := BCHGroup R (TruncatedLie D ℒ k)

def truncateGroup {i j : ℕ} (hij : i ≤ j) : TruncatedGroup D ℒ j →* TruncatedGroup D ℒ i :=
  bchMap (truncateLieMap D ℒ hij)

@[simp] theorem truncateGroup_refl (k : ℕ) (x : TruncatedGroup D ℒ k) :
    truncateGroup D ℒ (le_refl k) x = x := by
  sorry

theorem truncateGroup_trans {i j k : ℕ} (hij : i ≤ j) (hjk : j ≤ k)
    (x : TruncatedGroup D ℒ k) :
    truncateGroup D ℒ hij (truncateGroup D ℒ hjk x) =
      truncateGroup D ℒ (hij.trans hjk) x := by
  sorry

def groupTower : ℕᵒᵖ ⥤ GrpCat where
  obj k := GrpCat.of (TruncatedGroup D ℒ k.unop)
  map f := GrpCat.ofHom (truncateGroup D ℒ (leOfHom f.unop))
  map_id k := GrpCat.hom_ext (MonoidHom.ext fun x =>
    truncateGroup_refl D ℒ k.unop x)
  map_comp f h := GrpCat.hom_ext (MonoidHom.ext fun x =>
    (truncateGroup_trans D ℒ (leOfHom h.unop) (leOfHom f.unop) x).symm)

/-- The standard compatible-section subgroup for the BCH tower. -/
abbrev CompletedGroup := GrpCat.sectionsSubgroup (groupTower D ℒ)

def completedProjection (k : ℕ) : CompletedGroup D ℒ →* TruncatedGroup D ℒ k :=
  GrpCat.sectionsπMonoidHom (groupTower D ℒ) (op k)

end GroupTower

/-! ## §§1.1 and 2.3: the finite central arrangement and sign factorization -/

/-- A genuine finite-dimensional real dual model for the degree lattice. The normed topology
is supplied on `V`; `eval` identifies its real vector space with the full lattice dual. -/
structure KSSpace (N V : Type*) [AddCommGroup N] [NormedAddCommGroup V] [NormedSpace ℝ V] where
  eval : V ≃ₗ[ℝ] (N →+ ℝ)

section SignFactorization

variable {R N g V : Type*} [CommRing R] [Algebra ℚ R]
  [AddCommGroup N] [DecidableEq N] [Module.Free ℤ N] [Module.Finite ℤ N]
  [LieRing g] [LieAlgebra R g]
  [NormedAddCommGroup V] [NormedSpace ℝ V] [FiniteDimensional ℝ V]
  (D : PositiveDegrees N) (ℒ : N → Submodule R g)
  [GradedLieAlgebra ℒ] [IsPositiveGrading D ℒ] (S : KSSpace N V)

def weight (n : N) : V →ₗ[ℝ] ℝ :=
  { toFun := fun θ => S.eval θ n
    map_add' := by intro x y; simp
    map_smul' := by intro a x; simp }

omit [DecidableEq N] [Module.Free ℤ N] [Module.Finite ℤ N] in
theorem continuous_weight (n : N) : Continuous (weight S n) :=
  (weight S n).continuous_of_finiteDimensional

/-- Hyperplanes come from the finitely many active lattice degrees, not from an arbitrary
polyhedral carrier. -/
def degreeHyperplane (n : N) : Submodule ℝ V := LinearMap.ker (weight S n)

def IsRegular (k : ℕ) (θ : V) : Prop :=
  ∀ n ∈ D.activeDegrees k, S.eval θ n ≠ 0

def signSubmodule (k : ℕ) (θ : V) (ε : SignType) : Submodule R (TruncatedLie D ℒ k) :=
  ⨆ n, ⨆ (_ : SignType.sign (S.eval θ n) = ε),
    (ℒ n).map (quotientLieMap D ℒ k).toLinearMap

theorem signSubmodule_lie_mem (k : ℕ) (θ : V) (ε : SignType)
    {x y : TruncatedLie D ℒ k}
    (hx : x ∈ signSubmodule D ℒ S k θ ε) (hy : y ∈ signSubmodule D ℒ S k θ ε) :
    ⁅x, y⁆ ∈ signSubmodule D ℒ S k θ ε := by
  sorry

def signSubalgebra (k : ℕ) (θ : V) (ε : SignType) : LieSubalgebra R (TruncatedLie D ℒ k) :=
  { signSubmodule D ℒ S k θ ε with
    lie_mem' := fun hx hy => signSubmodule_lie_mem D ℒ S k θ ε hx hy }

def signGroup (k : ℕ) (θ : V) (ε : SignType) : Subgroup (TruncatedGroup D ℒ k) :=
  bchSubgroup R _ (signSubalgebra D ℒ S k θ ε)

/-- The convention is positive, then zero, then negative. This is an equivalence of types. -/
def signFactorization (k : ℕ) (θ : V) :
    (signGroup D ℒ S k θ 1 × signGroup D ℒ S k θ 0 × signGroup D ℒ S k θ (-1)) ≃
      TruncatedGroup D ℒ k := by
  sorry

theorem signFactorization_apply (k : ℕ) (θ : V)
    (x : signGroup D ℒ S k θ 1 × signGroup D ℒ S k θ 0 × signGroup D ℒ S k θ (-1)) :
    signFactorization D ℒ S k θ x = x.1.val * x.2.1.val * x.2.2.val := by
  sorry

def middle (k : ℕ) (θ : V) (x : TruncatedGroup D ℒ k) : signGroup D ℒ S k θ 0 :=
  ((signFactorization D ℒ S k θ).symm x).2.1

def positive (k : ℕ) (θ : V) (x : TruncatedGroup D ℒ k) : signGroup D ℒ S k θ 1 :=
  ((signFactorization D ℒ S k θ).symm x).1

@[simp] theorem middle_of_zero (k : ℕ) (x : TruncatedGroup D ℒ k) :
    (middle D ℒ S k 0 x).val = x := by
  sorry

@[simp] theorem middle_of_mem (k : ℕ) (θ : V) (x : signGroup D ℒ S k θ 0) :
    middle D ℒ S k θ x.val = x := by
  sorry

theorem middle_eq_one_of_regular (k : ℕ) (θ : V) (hθ : IsRegular D S k θ)
    (x : TruncatedGroup D ℒ k) : middle D ℒ S k θ x = 1 := by
  sorry

/-- A finite sign-neighborhood keeps every nonzero sign at `θ` fixed. This lemma gives the
local WCS chart and the injectivity of finite stalk evaluation. -/
theorem exists_middle_neighborhood (k : ℕ) (θ : V) :
    ∃ U : Opens V, θ ∈ U ∧ ∀ η ∈ U, ∀ x : TruncatedGroup D ℒ k,
      middle D ℒ S k η x = middle D ℒ S k η (middle D ℒ S k θ x).val := by
  sorry

theorem middle_pos_smul (k : ℕ) (θ : V) (t : ℝ) (ht : 0 < t)
    (x : TruncatedGroup D ℒ k) :
    (middle D ℒ S k (t • θ) x).val = (middle D ℒ S k θ x).val := by
  sorry

theorem truncateGroup_middle {i j : ℕ} (hij : i ≤ j) (θ : V) (x : TruncatedGroup D ℒ j) :
    truncateGroup D ℒ hij (middle D ℒ S j θ x).val =
      (middle D ℒ S i θ (truncateGroup D ℒ hij x)).val := by
  sorry

/-- Endpoint transport for the global WCS represented by `x` (§2.4). Successive transports act
on the left, so a path from `a` through `b` to `c` has product `T(b,c) * T(a,b)`. -/
def transport (k : ℕ) (x : TruncatedGroup D ℒ k) (a b : V) : TruncatedGroup D ℒ k :=
  (positive D ℒ S k b x).val⁻¹ * (positive D ℒ S k a x).val

@[simp] theorem transport_self (k : ℕ) (x : TruncatedGroup D ℒ k) (a : V) :
    transport D ℒ S k x a a = 1 := by simp [transport]

theorem transport_comp (k : ℕ) (x : TruncatedGroup D ℒ k) (a b c : V) :
    transport D ℒ S k x b c * transport D ℒ S k x a b = transport D ℒ S k x a c := by
  simp [transport, mul_assoc]

end SignFactorization

/-! ## §§1.2-1.3: finite WCS sheaves and their global sections -/

section WCS

variable {R N : Type*} {g V : Type u} [CommRing R] [Algebra ℚ R]
  [AddCommGroup N] [DecidableEq N] [Module.Free ℤ N] [Module.Finite ℤ N]
  [LieRing g] [LieAlgebra R g]
  [NormedAddCommGroup V] [NormedSpace ℝ V] [FiniteDimensional ℝ V]
  (D : PositiveDegrees N) (ℒ : N → Submodule R g)
  [GradedLieAlgebra ℒ] [IsPositiveGrading D ℒ] (S : KSSpace N V)

/-- On an open set, a single chart is the middle projection of one finite-order group element.
The fibers are the actual zero-sign subgroups. -/
def wcsPrelocal (k : ℕ) :
    TopCat.PrelocalPredicate (X := TopCat.of V) (fun θ => signGroup D ℒ S k θ 0) where
  pred {_} s := ∃ x : TruncatedGroup D ℒ k, ∀ θ, s θ = middle D ℒ S k θ.val x
  res i s hs := by
    obtain ⟨x, hx⟩ := hs
    exact ⟨x, fun θ => hx ⟨θ.val, i.le θ.property⟩⟩

def wcsLocal (k : ℕ) := (wcsPrelocal D ℒ S k).sheafify

def finiteSheaf (k : ℕ) : TopCat.Sheaf (Type u) (TopCat.of V) :=
  TopCat.subsheafToTypes (wcsLocal D ℒ S k)

abbrev FiniteSections (k : ℕ) (U : Opens V) :=
  (finiteSheaf D ℒ S k).presheaf.obj (op U)

@[ext] theorem finiteSections_ext (k : ℕ) (U : Opens V) (s t : FiniteSections D ℒ S k U)
    (h : ∀ θ, s.val θ = t.val θ) : s = t := Subtype.ext (funext h)

/-- The global section represented by a fixed finite-order group element. -/
def finiteGlobalSection (k : ℕ) (x : TruncatedGroup D ℒ k) : FiniteSections D ℒ S k ⊤ :=
  ⟨fun θ => middle D ℒ S k θ.val x,
    TopCat.PrelocalPredicate.sheafifyOf ⟨x, fun _ => rfl⟩⟩

def finiteGlobalEvaluation (k : ℕ) (s : FiniteSections D ℒ S k ⊤) : TruncatedGroup D ℒ k :=
  (s.val ⟨0, trivial⟩).val

@[simp] theorem finiteGlobalEvaluation_section (k : ℕ) (x : TruncatedGroup D ℒ k) :
    finiteGlobalEvaluation D ℒ S k (finiteGlobalSection D ℒ S k x) = x :=
  middle_of_zero D ℒ S k x

/-- The proof extends the chart at the origin along each positive radial ray. -/
theorem finiteGlobalSection_evaluation (k : ℕ) (s : FiniteSections D ℒ S k ⊤) :
    finiteGlobalSection D ℒ S k (finiteGlobalEvaluation D ℒ S k s) = s := by
  sorry

/-- Finite global classification, canonically given by evaluation at the origin. -/
def finiteGlobalEquiv (k : ℕ) : TruncatedGroup D ℒ k ≃ FiniteSections D ℒ S k ⊤ where
  toFun := finiteGlobalSection D ℒ S k
  invFun := finiteGlobalEvaluation D ℒ S k
  left_inv := finiteGlobalEvaluation_section D ℒ S k
  right_inv := finiteGlobalSection_evaluation D ℒ S k

theorem finiteStalkEvaluation_bijective (k : ℕ) (θ : V) :
    Function.Bijective (TopCat.stalkToFiber (X := TopCat.of V) (wcsLocal D ℒ S k) θ) := by
  sorry

/-- Finite stalks are exactly the zero-sign groups, using the existing stalk-to-fiber map. -/
def finiteStalkEquiv (k : ℕ) (θ : V) :
    (finiteSheaf D ℒ S k).presheaf.stalk θ ≃ signGroup D ℒ S k θ 0 :=
  Equiv.ofBijective (TopCat.stalkToFiber (X := TopCat.of V) (wcsLocal D ℒ S k) θ)
    (finiteStalkEvaluation_bijective D ℒ S k θ)

/-! ## §2.1: the completed WCS sheaf and its global classification -/

/-- Restriction of a quotient map to the zero-sign fibers. -/
def truncateZeroGroup {i j : ℕ} (hij : i ≤ j) (θ : V) :
    signGroup D ℒ S j θ 0 →* signGroup D ℒ S i θ 0 :=
  { toFun := fun x => ⟨truncateGroup D ℒ hij x.val, by
      have h := truncateGroup_middle D ℒ S hij θ x.val
      rw [middle_of_mem] at h
      rw [h]
      exact (middle D ℒ S i θ (truncateGroup D ℒ hij x.val)).property⟩
    map_one' := Subtype.ext (map_one (truncateGroup D ℒ hij))
    map_mul' x y := Subtype.ext (map_mul (truncateGroup D ℒ hij) x.val y.val) }

theorem truncateZeroGroup_preserves_local {i j : ℕ} (hij : i ≤ j) {U : Opens V}
    (s : ∀ θ : U, signGroup D ℒ S j θ.val 0) (hs : (wcsLocal D ℒ S j).pred s) :
    (wcsLocal D ℒ S i).pred (fun θ => truncateZeroGroup D ℒ S hij θ.val (s θ)) := by
  sorry

def truncateSheaf {i j : ℕ} (hij : i ≤ j) : finiteSheaf D ℒ S j ⟶ finiteSheaf D ℒ S i :=
  ⟨{ app := fun U => ↾fun s =>
        ⟨fun θ => truncateZeroGroup D ℒ S hij θ.val (s.val θ),
          truncateZeroGroup_preserves_local D ℒ S hij s.val s.property⟩
     naturality := by intro U W f; rfl }⟩

@[simp] theorem truncateSheaf_globalEvaluation {i j : ℕ} (hij : i ≤ j)
    (s : FiniteSections D ℒ S j ⊤) :
    finiteGlobalEvaluation D ℒ S i ((truncateSheaf D ℒ S hij).hom.app (op ⊤) s) =
      truncateGroup D ℒ hij (finiteGlobalEvaluation D ℒ S j s) := rfl

def sheafTower : ℕᵒᵖ ⥤ TopCat.Sheaf (Type _) (TopCat.of V) where
  obj k := finiteSheaf D ℒ S k.unop
  map f := truncateSheaf D ℒ S (leOfHom f.unop)
  map_id := by
    intro k
    apply CategoryTheory.Sheaf.hom_ext
    apply NatTrans.ext
    funext U
    apply ConcreteCategory.hom_ext
    intro s
    apply finiteSections_ext
    intro θ
    exact Subtype.ext (truncateGroup_refl D ℒ k.unop _)
  map_comp := by
    intro i j k f h
    apply CategoryTheory.Sheaf.hom_ext
    apply NatTrans.ext
    funext U
    apply ConcreteCategory.hom_ext
    intro s
    apply finiteSections_ext
    intro θ
    exact Subtype.ext (truncateGroup_trans D ℒ _ _ _).symm

/-- The limit is taken in Mathlib's category of sheaves of types. -/
def completedSheaf : TopCat.Sheaf (Type _) (TopCat.of V) := limit (sheafTower D ℒ S)

abbrev CompletedSections (U : Opens V) := (completedSheaf D ℒ S).presheaf.obj (op U)

def finiteSectionProjection (k : ℕ) (U : Opens V) :
    CompletedSections D ℒ S U → FiniteSections D ℒ S k U :=
  (limit.π (sheafTower D ℒ S) (op k)).hom.app (op U)

/-- Objectwise compatible finite sections compute sections of the limit sheaf. -/
def completedSectionsEquiv (U : Opens V) : CompletedSections D ℒ S U ≃
    {s : ∀ k, FiniteSections D ℒ S k U //
      ∀ (i j : ℕ) (hij : i ≤ j), (truncateSheaf D ℒ S hij).hom.app (op U) (s j) = s i} := by
  sorry

theorem completedSectionsEquiv_apply (U : Opens V) (s : CompletedSections D ℒ S U) (k : ℕ) :
    (completedSectionsEquiv D ℒ S U s).val k = finiteSectionProjection D ℒ S k U s := by
  sorry

/-- Evaluation of a completed global section at the origin, one finite order at a time. -/
def completedGlobalEvaluation (s : CompletedSections D ℒ S ⊤) : CompletedGroup D ℒ :=
  ⟨fun k => finiteGlobalEvaluation D ℒ S k.unop (finiteSectionProjection D ℒ S k.unop ⊤ s), by
    intro i j f
    sorry⟩

theorem completedGlobalEvaluation_bijective :
    Function.Bijective (completedGlobalEvaluation D ℒ S) := by
  sorry

/-- Main goal: completed global WCS sections are classified by the completed BCH group. -/
def globalWCSEquiv : CompletedGroup D ℒ ≃ CompletedSections D ℒ S ⊤ :=
  (Equiv.ofBijective (completedGlobalEvaluation D ℒ S)
    (completedGlobalEvaluation_bijective D ℒ S)).symm

@[simp] theorem globalWCSEquiv_symm_component (s : CompletedSections D ℒ S ⊤) (k : ℕ) :
    completedProjection D ℒ k ((globalWCSEquiv D ℒ S).symm s) =
      finiteGlobalEvaluation D ℒ S k (finiteSectionProjection D ℒ S k ⊤ s) := rfl

end WCS

end TauCetiRoadmap.WallCrossing
