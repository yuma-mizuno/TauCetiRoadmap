/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.QuantumSeed
public import TauCetiRoadmap.LaurentPhenomenon.Quantum.Subalgebra

/-!
# Polynomial seed realizations

For an alternating integer matrix `Λ` and a `Zv`-algebra `A`, a polynomial seed realization is an
injective `Zv`-algebra map from the quantum polynomial algebra `T_∅(Zv,v,Λ)` into `A`
(`PolynomialRealization`). Equivalently it is a quasi-commuting tuple `x : M → A` whose
normalized monomials `M(a)`, `a ∈ ℕ ^ M`, are `Zv`-linearly independent
(`PolynomialRealization.exists_generator_eq_iff`). A realization is determined by its generators
(`PolynomialRealization.ext_generator`) and is transported along injective algebra maps
(`PolynomialRealization.map`).

If `A` embeds in a division ring `D` by `ι`, the images of the generators are units and the
induced chart `T(Zv,v,Λ) → D` of the full quantum torus is injective
(`PolynomialRealization.torusChart_injective`): a relation among Laurent monomials becomes a
relation among polynomial monomials after multiplication by a monomial. With a compatible
`B_ext` this is a quantum seed in `D` (`PolynomialRealization.toSeed`). Such a seed lives in `D`;
whether a mutated generator lies in `A` is a separate question, which needs an exchange or
divisibility witness in `A`. A mutation at `k` in `A` is such a witness `y ∈ A` with `ι(y) = X'_k`
(`PolynomialRealization.IsMutation`); it gives the mutated realization
(`PolynomialRealization.mutate`), whose seed in `D` is the mutated seed
(`PolynomialRealization.toSeed_mutate`).

Consumer theorem: when all reachable mutable variables (and the frozen variables) of a seed lie
in the image of an injective `ι : A → D`, restricting the inverse of `ι` gives an injective
algebra map `A_{v,∅} → A` (`ExchangeFrame.clusterAlgebraLift`). No assertion is made that one-step
membership implies membership at later seeds.
-/

@[expose] public section

namespace TauCeti.Cluster

open TauCeti TauCeti.Laurent TauCeti.QuantumTorus

noncomputable section

variable {M : Type*} [Fintype M] [DecidableEq M] {Λ : Matrix M M ℤ}
  {A : Type*} [Ring A] [Algebra Zv A] {A' : Type*} [Ring A'] [Algebra Zv A']

/-! ### Realizations -/

variable (Λ A) in
/-- A **polynomial seed realization** of `Λ` in the `Zv`-algebra `A`: an injective `Zv`-algebra
map from the quantum polynomial algebra `T_∅(Zv,v,Λ)`. -/
structure PolynomialRealization where
  /-- The realizing algebra map. -/
  toAlgHom : polynomialSubalgebra Zv vUnit (matrixForm Λ) →ₐ[Zv] A
  injective : Function.Injective toAlgHom

namespace PolynomialRealization

/-- The normalized monomial `M(a) = v^{-Σ_{i<j} a_i a_j Λ_ij} ∏_i x_i^{a_i}` of a tuple, for
`a ∈ ℕ ^ M`; it does not depend on the order of the product
(`TauCeti.QuantumTorus.mixedLift_mixedBasis`). -/
def tupleMonomial (x : M → A) (a : mixedExponents (∅ : Set M)) : A :=
  mixedNormalizedProd vUnit (matrixForm Λ) ∅ x (fun i hi ↦ absurd hi (Set.notMem_empty i))
    (Finset.univ : Finset M).toList a

variable (r : PolynomialRealization Λ A)

/-- The generator `x_i`, the image of `X_i`. -/
def generator (i : M) : A := r.toAlgHom (mixedX ∅ i)
/-- The normalized monomial `M(a)`, `a ∈ ℕ ^ M`: the image of the basis monomial `X ^ a`. -/
def monomial (a : mixedExponents (∅ : Set M)) : A :=
  r.toAlgHom (mixedBasis Zv vUnit (matrixForm Λ) ∅ a)

theorem linearIndependent_monomial : LinearIndependent Zv r.monomial :=
  (polynomialSubalgebra_algHom_injective_iff r.toAlgHom).1 r.injective

variable (hΛ : IsAlternatingMatrix Λ)

include hΛ in
theorem isQuasiCommutingFamily : IsQuasiCommutingFamily vUnit (matrixForm Λ) r.generator := by
  intro i j
  have hs : ∀ (c : Zv) (y : polynomialSubalgebra Zv vUnit (matrixForm Λ)),
      r.toAlgHom (c • y) = c • r.toAlgHom y := fun c y ↦ r.toAlgHom.toLinearMap.map_smul c y
  simp only [generator]
  rw [← map_mul, isQuasiCommutingFamily_mixedX hΛ.isAlt i j, hs, map_mul]

include hΛ in
/-- The normalized monomials of a realization are those of its generators. -/
theorem monomial_eq_tupleMonomial (a : mixedExponents (∅ : Set M)) :
    r.monomial a = tupleMonomial (Λ := Λ) r.generator a :=
  algHom_mixedBasis_eq hΛ.isAlt r.toAlgHom (Finset.nodup_toList _) (fun i ↦ by simp) a

variable {r} in
include hΛ in
/-- **Generator extensionality.** A realization is determined by its generators. -/
theorem ext_generator {r' : PolynomialRealization Λ A} (h : ∀ i, r.generator i = r'.generator i) :
    r = r' := by
  obtain ⟨f, hf⟩ := r
  obtain ⟨g, hg⟩ := r'
  obtain rfl : f = g := mixedAlgHom_ext hΛ.isAlt h
  rfl

/-- The realization of a quasi-commuting tuple whose normalized monomials are linearly
independent. -/
def ofQuasiCommuting (x : M → A) (hx : IsQuasiCommutingFamily vUnit (matrixForm Λ) x)
    (hli : LinearIndependent Zv (tupleMonomial (Λ := Λ) x)) : PolynomialRealization Λ A where
  toAlgHom := mixedLift hΛ.isAlt x (fun i hi ↦ absurd hi (Set.notMem_empty i)) hx
  injective := by
    rw [polynomialSubalgebra_algHom_injective_iff]
    convert hli using 1
    funext a
    exact mixedLift_mixedBasis hΛ.isAlt hx (Finset.nodup_toList _) (fun i ↦ by simp) a

@[simp] theorem generator_ofQuasiCommuting (x : M → A)
    (hx : IsQuasiCommutingFamily vUnit (matrixForm Λ) x)
    (hli : LinearIndependent Zv (tupleMonomial (Λ := Λ) x)) :
    (ofQuasiCommuting hΛ x hx hli).generator = x :=
  funext fun i ↦ mixedLift_mixedX hΛ.isAlt hx i

include hΛ in
/-- **Realizations are quasi-commuting tuples with independent normalized monomials.** -/
theorem exists_generator_eq_iff (x : M → A) (hx : IsQuasiCommutingFamily vUnit (matrixForm Λ) x) :
    (∃ r : PolynomialRealization Λ A, r.generator = x) ↔
      LinearIndependent Zv (tupleMonomial (Λ := Λ) x) := by
  constructor
  · rintro ⟨r, rfl⟩
    convert r.linearIndependent_monomial using 1
    funext a
    exact (r.monomial_eq_tupleMonomial hΛ a).symm
  · intro hli
    exact ⟨ofQuasiCommuting hΛ x hx hli, generator_ofQuasiCommuting hΛ x hx hli⟩

/-! ### Transport along injective algebra maps -/

/-- **Transport** of a realization along an injective `Zv`-algebra map. -/
def map (f : A →ₐ[Zv] A') (hf : Function.Injective f) : PolynomialRealization Λ A' where
  toAlgHom := f.comp r.toAlgHom
  injective := hf.comp r.injective

@[simp] theorem map_generator (f : A →ₐ[Zv] A') (hf : Function.Injective f) (i : M) :
    (r.map f hf).generator i = f (r.generator i) :=
  rfl

@[simp] theorem map_monomial (f : A →ₐ[Zv] A') (hf : Function.Injective f)
    (a : mixedExponents (∅ : Set M)) : (r.map f hf).monomial a = f (r.monomial a) :=
  rfl

/-! ### The induced chart of the full quantum torus -/

theorem generator_ne_zero (i : M) : r.generator i ≠ 0 := by
  intro h
  have h0 : (mixedX ∅ i : polynomialSubalgebra Zv vUnit (matrixForm Λ)) = 0 :=
    r.injective (h.trans (map_zero _).symm)
  have := congrArg (fun f : polynomialSubalgebra Zv vUnit (matrixForm Λ) ↦
    coeff (Pi.single i 1) (f : quantumTorus Zv vUnit (matrixForm Λ))) h0
  simp at this

variable {D : Type*} [DivisionRing D] [Algebra Zv D] (ι : A →ₐ[Zv] D)
  (hι : Function.Injective ι)

include hι in
theorem map_generator_ne_zero (i : M) : ι (r.generator i) ≠ 0 := by
  have : Nontrivial A := ι.toRingHom.domain_nontrivial
  exact fun h ↦ r.generator_ne_zero i (hι (h.trans (map_zero ι).symm))

/-- The images `ι(x_i)` of the generators, as units of `D`. -/
def unitGenerator (i : M) : Dˣ :=
  Units.mk0 (ι (r.generator i)) (r.map_generator_ne_zero ι hι i)

@[simp] theorem val_unitGenerator (i : M) :
    (r.unitGenerator ι hι i : D) = ι (r.generator i) :=
  rfl

include hΛ in
theorem isQuasiCommuting_unitGenerator :
    IsQuasiCommuting vUnit (matrixForm Λ) (r.unitGenerator ι hι) := by
  intro i j
  simp only [val_unitGenerator]
  rw [← map_mul, r.isQuasiCommutingFamily hΛ i j, map_smul, map_mul]

/-- **The induced full torus chart** `T(Zv,v,Λ) → D`, `X_i ↦ ι(x_i)`. -/
def torusChart : quantumTorus Zv vUnit (matrixForm Λ) →ₐ[Zv] D :=
  QuantumTorus.lift hΛ.isAlt (r.unitGenerator ι hι)
    (r.isQuasiCommuting_unitGenerator hΛ ι hι)

theorem torusChart_monomial_single (i : M) :
    r.torusChart hΛ ι hι (QuantumTorus.monomial (Pi.single i 1)) = ι (r.generator i) :=
  lift_monomial_single _ _ i

/-- On the quantum polynomial algebra the torus chart is `ι` composed with the realization. -/
theorem torusChart_comp_val :
    (r.torusChart hΛ ι hι).comp (polynomialSubalgebra Zv vUnit (matrixForm Λ)).val =
      ι.comp r.toAlgHom :=
  mixedAlgHom_ext hΛ.isAlt fun i ↦ by
    rw [AlgHom.comp_apply, AlgHom.comp_apply, Subalgebra.coe_val, coe_mixedX,
      torusChart_monomial_single]
    rfl

/-- **Faithfulness of the induced chart.** -/
theorem torusChart_injective : Function.Injective (r.torusChart hΛ ι hι) := by
  refine (injective_iff_map_eq_zero _).2 fun f hf ↦ ?_
  obtain ⟨N, hN⟩ := exists_mul_monomial_mem_polynomialSubalgebra f
  have h1 : (⟨f * QuantumTorus.monomial N, hN⟩ : polynomialSubalgebra Zv vUnit (matrixForm Λ)) =
      0 := by
    apply hι.comp r.injective
    have h := DFunLike.congr_fun (r.torusChart_comp_val hΛ ι hι) ⟨_, hN⟩
    rw [AlgHom.comp_apply, AlgHom.comp_apply, Subalgebra.coe_val, map_mul, hf, zero_mul] at h
    rw [Function.comp_apply, Function.comp_apply, ← h, map_zero, map_zero]
  have h2 : f * QuantumTorus.monomial N = 0 := congrArg Subtype.val h1
  calc f = f * QuantumTorus.monomial N * QuantumTorus.monomial (-N) := by
        rw [mul_assoc, monomial_mul_monomial_neg hΛ.isAlt, mul_one]
    _ = 0 := by rw [h2, zero_mul]

/-! ### The quantum seed of a realization -/

variable {K : Type*} {row : K ↪ M}

/-- The quantum seed in `D` of a realization of a compatible pair `(B_ext, Λ)` in `A ⊆ D`; its
coordinates are the images of the generators. -/
def toSeed (B : ExtendedExchangeMatrix row) (hc : IsCompatiblePair B Λ) :
    ExchangeFrame (u₀ := vUnit) D row :=
  (QuantumSeed.ofCompatible B Λ hΛ hc (r.unitGenerator ι hι)
    (r.isQuasiCommuting_unitGenerator hΛ ι hι) (r.torusChart_injective hΛ ι hι)).1

@[simp] theorem toSeed_coordinate (B : ExtendedExchangeMatrix row) (hc : IsCompatiblePair B Λ)
    (i : M) :
    ((r.toSeed hΛ ι hι B hc).coordinate i : D) = ι (r.generator i) :=
  rfl

theorem toSeed_chart (B : ExtendedExchangeMatrix row) (hc : IsCompatiblePair B Λ) :
    (r.toSeed hΛ ι hι B hc).chart = r.torusChart hΛ ι hι :=
  rfl

end PolynomialRealization

/-! ### The map `A_{v,∅} → A` -/

namespace ExchangeFrame

variable {D : Type*} [DivisionRing D] [Algebra Zv D] {K : Type*} [Fintype K] [DecidableEq K]
  {row : K ↪ M} (s : ExchangeFrame (u₀ := vUnit) D row) (ι : A →ₐ[Zv] D)

/-- If the reachable mutable variables and the frozen variables lie in `ι(A)`, so does
`A_{v,∅}`. -/
theorem clusterAlgebra_empty_le_range (hmut : s.clusterVariables ⊆ ι.range)
    (hfr : ∀ j ∉ Set.range row, (s.coordinate j : D) ∈ ι.range) :
    s.clusterAlgebra ∅ ≤ ι.range := by
  refine Algebra.adjoin_le ?_
  rintro x ((hx | ⟨j, hj, rfl⟩) | ⟨j, hj, -⟩)
  · exact hmut hx
  · exact hfr j hj
  · exact hj.elim

variable (hι : Function.Injective ι)

/-- **The map `A_{v,∅} → A`** induced by an embedding `ι : A → D` whose image contains
`A_{v,∅}`: the restriction of the inverse of `ι`. -/
def clusterAlgebraLift (h : s.clusterAlgebra ∅ ≤ ι.range) : s.clusterAlgebra ∅ →ₐ[Zv] A :=
  (AlgEquiv.ofInjective ι hι).symm.toAlgHom.comp (Subalgebra.inclusion h)

theorem apply_clusterAlgebraLift (h : s.clusterAlgebra ∅ ≤ ι.range)
    (x : s.clusterAlgebra ∅) : ι (s.clusterAlgebraLift ι hι h x) = x := by
  rw [← AlgEquiv.ofInjective_apply ι hι, clusterAlgebraLift, AlgHom.comp_apply,
    AlgEquiv.toAlgHom_apply, AlgEquiv.apply_symm_apply]
  rfl

theorem clusterAlgebraLift_eq_iff (h : s.clusterAlgebra ∅ ≤ ι.range)
    (x : s.clusterAlgebra ∅) (y : A) : s.clusterAlgebraLift ι hι h x = y ↔ ι y = x :=
  ⟨fun e ↦ e ▸ s.apply_clusterAlgebraLift ι hι h x,
    fun e ↦ hι ((s.apply_clusterAlgebraLift ι hι h x).trans e.symm)⟩

theorem clusterAlgebraLift_injective (h : s.clusterAlgebra ∅ ≤ ι.range) :
    Function.Injective (s.clusterAlgebraLift ι hι h) := fun x y e ↦
  Subtype.ext ((s.apply_clusterAlgebraLift ι hι h x).symm.trans
    ((congrArg ι e).trans (s.apply_clusterAlgebraLift ι hι h y)))

end ExchangeFrame

namespace PolynomialRealization

variable {D : Type*} [DivisionRing D] [Algebra Zv D] {K : Type*} [Fintype K] [DecidableEq K]
  {row : K ↪ M} (r : PolynomialRealization Λ A) (hΛ : IsAlternatingMatrix Λ)
  (ι : A →ₐ[Zv] D) (hι : Function.Injective ι) (B : ExtendedExchangeMatrix row)
  (hc : IsCompatiblePair B Λ)

/-- For the seed of a realization, membership of all reachable mutable variables in `A` puts
`A_{v,∅}` inside `ι(A)`. -/
theorem clusterAlgebra_le_range
    (hmut : (r.toSeed hΛ ι hι B hc).clusterVariables ⊆ ι.range) :
    (r.toSeed hΛ ι hι B hc).clusterAlgebra ∅ ≤ ι.range :=
  ExchangeFrame.clusterAlgebra_empty_le_range _ ι hmut fun j _ ↦ ⟨r.generator j, rfl⟩

/-- **The consumer map `A_{v,∅} → A`.** If every reachable mutable variable of the seed of a
realization lies in `A`, restricting the inverse of the faithful realization gives an injective
`Zv`-algebra map `A_{v,∅} → A` sending each frozen variable to its generator. -/
def clusterAlgebraToRealization
    (hmut : (r.toSeed hΛ ι hι B hc).clusterVariables ⊆ ι.range) :
    (r.toSeed hΛ ι hι B hc).clusterAlgebra ∅ →ₐ[Zv] A :=
  (r.toSeed hΛ ι hι B hc).clusterAlgebraLift ι hι
    (r.clusterAlgebra_le_range hΛ ι hι B hc hmut)

theorem apply_clusterAlgebraToRealization
    (hmut : (r.toSeed hΛ ι hι B hc).clusterVariables ⊆ ι.range)
    (x : (r.toSeed hΛ ι hι B hc).clusterAlgebra ∅) :
    ι (r.clusterAlgebraToRealization hΛ ι hι B hc hmut x) = x :=
  ExchangeFrame.apply_clusterAlgebraLift _ ι hι _ x

theorem clusterAlgebraToRealization_injective
    (hmut : (r.toSeed hΛ ι hι B hc).clusterVariables ⊆ ι.range) :
    Function.Injective (r.clusterAlgebraToRealization hΛ ι hι B hc hmut) :=
  ExchangeFrame.clusterAlgebraLift_injective _ ι hι _

theorem clusterAlgebraToRealization_frozen
    (hmut : (r.toSeed hΛ ι hι B hc).clusterVariables ⊆ ι.range) {j : M}
    (hj : j ∉ Set.range row) :
    r.clusterAlgebraToRealization hΛ ι hι B hc hmut
        ⟨_, (r.toSeed hΛ ι hι B hc).coordinate_mem_clusterAlgebra_of_notMem ∅ hj⟩ =
      r.generator j :=
  (ExchangeFrame.clusterAlgebraLift_eq_iff _ ι hι _ _ _).2 rfl

end PolynomialRealization

/-! ### Mutation in a realization -/

namespace PolynomialRealization

variable {D : Type*} [DivisionRing D] [Algebra Zv D] {K : Type*} [Fintype K] [DecidableEq K]
  {row : K ↪ M} (r : PolynomialRealization Λ A) (hΛ : IsAlternatingMatrix Λ)
  (ι : A →ₐ[Zv] D) (hι : Function.Injective ι) (B : ExtendedExchangeMatrix row)
  (hc : IsCompatiblePair B Λ)

/-- A **mutation at `k` in `A`** of the realization: `y ∈ A` with `ι(y) = X'_k`, the mutated
variable of the induced seed in `D`. The mutated seed in `D` does not provide such a `y`. -/
def IsMutation (k : K) (y : A) : Prop :=
  ι y = (((r.toSeed hΛ ι hι B hc).mutate k).coordinate (row k) : D)

theorem isMutation_iff (k : K) (y : A) :
    r.IsMutation hΛ ι hι B hc k y ↔ ι y = (r.toSeed hΛ ι hι B hc).exchangeCoordinate k := by
  rw [IsMutation, ExchangeFrame.mutate_coordinate_row]

variable {r hΛ ι hι B hc} in
/-- A mutation in `A` is unique. -/
theorem IsMutation.unique {k : K} {y y' : A} (h : r.IsMutation hΛ ι hι B hc k y)
    (h' : r.IsMutation hΛ ι hι B hc k y') : y = y' :=
  hι (h.trans h'.symm)

/-- A mutation at `k` exists in `A` exactly when `X'_k` lies in `ι(A)`. -/
theorem exists_isMutation_iff (k : K) :
    (∃ y, r.IsMutation hΛ ι hι B hc k y) ↔
      (((r.toSeed hΛ ι hι B hc).mutate k).coordinate (row k) : D) ∈ ι.range :=
  ⟨fun ⟨y, hy⟩ ↦ ⟨y, hy⟩, fun ⟨y, hy⟩ ↦ ⟨y, hy⟩⟩

variable {k : K} {y : A} (hy : r.IsMutation hΛ ι hι B hc k y)
include hy

/-- The mutated generators `Y'_i = Y_i` (`i ≠ row k`), `Y'_k = y` are sent by `ι` to the
coordinates of the mutated seed. -/
theorem apply_update_generator (i : M) :
    ι (Function.update r.generator (row k) y i) =
      (((r.toSeed hΛ ι hι B hc).mutate k).coordinate i : D) := by
  by_cases hi : i = row k
  · subst hi
    rw [Function.update_self]
    exact hy
  · rw [Function.update_of_ne hi, ExchangeFrame.mutate_coordinate_of_ne _ _ hi, toSeed_coordinate]

/-- The mutated generators quasi-commute for the mutated form `Λ'`. -/
theorem isQuasiCommutingFamily_update :
    IsQuasiCommutingFamily vUnit (matrixForm (formMutation row B.matrix Λ k 1))
      (Function.update r.generator (row k) y) := by
  intro i j
  apply hι
  rw [map_mul, map_smul, map_mul, r.apply_update_generator hΛ ι hι B hc hy,
    r.apply_update_generator hΛ ι hι B hc hy]
  exact ((r.toSeed hΛ ι hι B hc).mutate k).quasiCommuting i j

/-- `ι` composed with the map defined by the mutated generators is the chart of the mutated seed
on the quantum polynomial algebra of `Λ'`. -/
theorem comp_mixedLift_update :
    ι.comp (mixedLift ((r.toSeed hΛ ι hι B hc).mutate k).isAlt
        (Function.update r.generator (row k) y) (fun i hi ↦ absurd hi (Set.notMem_empty i))
        (r.isQuasiCommutingFamily_update hΛ ι hι B hc hy)) =
      ((r.toSeed hΛ ι hι B hc).mutate k).chart.comp
        (polynomialSubalgebra Zv vUnit (matrixForm (formMutation row B.matrix Λ k 1))).val :=
  mixedAlgHom_ext ((r.toSeed hΛ ι hι B hc).mutate k).isAlt fun i ↦
    (congrArg ι (mixedLift_mixedX ((r.toSeed hΛ ι hι B hc).mutate k).isAlt
      (r.isQuasiCommutingFamily_update hΛ ι hι B hc hy) i)).trans
      ((r.apply_update_generator hΛ ι hι B hc hy i).trans
        (((r.toSeed hΛ ι hι B hc).mutate k).monomial_single i).symm)

/-- **The mutated realization.** A mutation `y` at `k` in `A` gives the realization of the mutated
form `Λ'` in `A` with generators `Y'_i = Y_i` (`i ≠ row k`), `Y'_k = y`. -/
def mutate : PolynomialRealization (formMutation row B.matrix Λ k 1) A where
  toAlgHom := mixedLift ((r.toSeed hΛ ι hι B hc).mutate k).isAlt
    (Function.update r.generator (row k) y) (fun i hi ↦ absurd hi (Set.notMem_empty i))
    (r.isQuasiCommutingFamily_update hΛ ι hι B hc hy)
  injective := by
    have h : Function.Injective (((r.toSeed hΛ ι hι B hc).mutate k).chart.comp
        (polynomialSubalgebra Zv vUnit (matrixForm (formMutation row B.matrix Λ k 1))).val) :=
      ((r.toSeed hΛ ι hι B hc).mutate k).chart_injective.comp Subtype.val_injective
    rw [← r.comp_mixedLift_update hΛ ι hι B hc hy] at h
    exact fun a b hab ↦ h (congrArg ι hab)

@[simp] theorem mutate_generator :
    (r.mutate hΛ ι hι B hc hy).generator = Function.update r.generator (row k) y :=
  funext fun i ↦ mixedLift_mixedX ((r.toSeed hΛ ι hι B hc).mutate k).isAlt
    (r.isQuasiCommutingFamily_update hΛ ι hι B hc hy) i

/-- The seed in `D` of the mutated realization is the mutated seed. -/
theorem toSeed_mutate (hΛ' : IsAlternatingMatrix (formMutation row B.matrix Λ k 1))
    (hc' : IsCompatiblePair (B.mutate k) (formMutation row B.matrix Λ k 1)) :
    (r.mutate hΛ ι hι B hc hy).toSeed hΛ' ι hι (B.mutate k) hc' =
      (r.toSeed hΛ ι hι B hc).mutate k := by
  refine ExchangeFrame.ext rfl rfl (funext fun i ↦ Units.ext ?_)
  rw [toSeed_coordinate, mutate_generator]
  exact r.apply_update_generator hΛ ι hι B hc hy i

end PolynomialRealization

end

end TauCeti.Cluster
