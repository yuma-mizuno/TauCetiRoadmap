/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.QuantumLaurent
public import TauCetiRoadmap.ClusterAlgebras.ChartSpecialization
public import TauCetiRoadmap.ClusterAlgebras.GeometricPattern
public import TauCetiRoadmap.ClusterAlgebras.PolynomialQuantumSpecialization
public import TauCetiRoadmap.ClusterAlgebras.GeometricCoordinates
public import TauCetiRoadmap.LaurentPhenomenon.Quantum.Ore
public import TauCetiRoadmap.LaurentPhenomenon.Quantum.Specialization
public import TauCetiRoadmap.LaurentPhenomenon.LaurentChart
public import TauCetiRoadmap.LaurentPhenomenon.LaurentRegroup
public import TauCetiRoadmap.ClusterAlgebras.GeometricClusterAlgebra

/-!
# The classical limit of quantum seeds (L5)

Let `s` be a quantum seed in a `Zv`-division ring `D`, with extended matrix `B_ext` and integral
chart `T(Zv,v,Λ) → D`, and let `ε : ℤ[ℤ ^ M] → F` be a ring map to a field sending the generator
`x^{e_a}` to `x_a`. The classical geometric pattern `geometricPattern row B_ext x` mutates
  `(B_ext, x)`
by matrix mutation and the two-term exchange `x_k ↦ (∏ x_i^{[b_ik]_+} + ∏ x_i^{[-b_ik]_+}) / x_k`.
By quantum Laurentness (Q3) every quantum coordinate reached by a word `w` has a unique
representative `f` in `T(Zv,v,Λ)`; the polynomial specialization theorem proves
that `ε (sp f)` is the
classical coordinate after `w`, provided the classical coordinates exchanged along `w` are
nonzero. Each step multiplies the quantum exchange relation by the old coordinate, pulls it back
through the injective chart of `s`, applies `sp`, and cancels the nonzero classical old
coordinate; `sp` is never extended to the division ring. The nonvanishing holds automatically
when the initial values are algebraically independent over `ℚ`, since geometric exchanges
preserve independence. Taking for `ε` the inclusion of `ℤ[ℤ ^ M]` into its fraction field, `sp f`
is the unique Laurent preimage of the classical coordinate.

Over a field of characteristic zero, `geometricPattern` is the mutation of §1.4's geometric seeds
(`GeometricSeed.geometricPattern_eq`, built on `geometricMutationCoordinates`), and L5 is restated
for a geometric seed with the extended matrix of `s` (`ExchangeFrame.eval_sp_eq_geometricSeed`).

For the principal quantum seed in `Frac T(ℚ(v),v,Λ_pr)` and the evaluation at the initial
principal geometric coordinates this gives that the classical principal geometric coordinates
(`geometricWordData`) are integral Laurent polynomials in the initial coordinates; by the
regrouping `L(ℤ, I ⊔ I) ≃ L(L(ℤ, I), I)` each has a unique expansion in
`ℤ[u_i^{±1}][x_i^{±1}]`. `C_t` is the frozen block of the mutated principal matrix `B_ext_t` and the
`c`-vector `c_{j;t}` its `j`th column (`cMatrix`, `cVector`).
-/

@[expose] public section

namespace TauCeti.Cluster

open TauCeti TauCeti.QuantumTorus TauCeti.Laurent

noncomputable section

/-! ### Geometric seeds of §1.4 -/

section GeometricSeed

variable {M K F : Type*} [Fintype M] [Fintype K] [DecidableEq M] [DecidableEq K] [Field F]
  [Algebra ℚ F] {row : K ↪ M} {d : K → ℤ} (hd : ∀ k, 0 < d k)



/-- The geometric seed of §1.4 with the extended matrix and symmetrizer of the quantum seed `s`
and algebraically independent values `x`. -/
def ExchangeFrame.geometricSeed {D : Type*} [DivisionRing D] [Algebra Zv D]
    (s : ExchangeFrame (u₀ := vUnit) D row) (x : M → F) (hx : AlgebraicIndependent ℚ x) :
    GeometricSeed (F := F) row s.exchange.symmetrizer where
  exchange := s.exchange.matrix
  coordinate := x
  symmetrized := s.exchange.symmetrized
  independent := hx

end GeometricSeed

/-! ### The comparison for an arbitrary quantum seed -/

section Comparison

variable {D : Type*} [DivisionRing D] [Algebra Zv D]
  {M K : Type*} [Fintype M] [DecidableEq M] [Fintype K] [DecidableEq K]
  {row : K ↪ M} {F : Type*} [Field F]

namespace ExchangeFrame

variable (s : ExchangeFrame (u₀ := vUnit) D row)

/-- The extended matrices of a quantum pattern are the mutated extended matrices. -/
theorem mutateWord_exchange (w : List K) :
    (mutateWord (fun k t ↦ ExchangeFrame.mutate t k) w s).exchange.matrix =
      mutateWord (fun k B ↦ extendedMatrixMutation row B k) w s.exchange.matrix := by
  induction w generalizing s with
  | nil => rfl
  | cons k w ih => exact ih (s.mutate k)

/-- A quantum pattern and the classical geometric pattern with the same initial extended matrix
carry the same extended matrices. -/
theorem mutateWord_exchange_eq_geometricPattern (x : M → F) (w : List K) :
    (mutateWord (fun k t ↦ ExchangeFrame.mutate t k) w s).exchange.matrix =
      (geometricPattern row s.exchange.matrix x w).1 := by
  rw [mutateWord_exchange, geometricPattern_fst]

/-- By Q3, every coordinate reached by a word has a unique representative in the quantum torus
of `s`. -/
theorem existsUnique_chart_eq_coordinate_mutateWord (w : List K) (a : M) :
    ∃! f, s.chart f =
      ((mutateWord (fun k t ↦ ExchangeFrame.mutate t k) w s).coordinate a : D) := by
  have h := s.coordinate_mutateWord_mem_chartRing w a
  rw [← s.range_chart] at h
  obtain ⟨f, hf⟩ := h
  exact ⟨f, hf, fun g hg ↦ s.chart_injective (hg.trans hf.symm)⟩

omit [Fintype K] in
/-- Algebraically independent initial values stay algebraically independent along the classical
geometric pattern of the extended matrix of `s`; the symmetrizer makes the diagonal vanish. -/
theorem algebraicIndependent_geometricPattern [Finite K] [Algebra ℚ F] {x : M → F}
    (hx : AlgebraicIndependent ℚ x) (w : List K) :
    AlgebraicIndependent ℚ (geometricPattern row s.exchange.matrix x w).2 := by
  let : Fintype K := Fintype.ofFinite K
  exact TauCeti.Cluster.algebraicIndependent_geometricPattern row hx w fun u k _ ↦ by
    rw [← s.mutateWord_exchange_eq_geometricPattern x u]
    exact (mutateWord (fun k t ↦ ExchangeFrame.mutate t k) u s).exchange.diagonal k

omit [Fintype K] [DecidableEq K] [Field F] in
/-- Degree-one polynomial classical data are the usual binary data. -/
theorem polynomialSeed_classicalData (x : M → F) :
    s.polynomialSeed.classicalData x = binomialData (s.exchange.matrix, x) := by
  apply PolynomialGeometricData.ext
  · rfl
  · funext k
    simp [PolynomialExchangeSeed.classicalData, polynomialSeed, binomialData]
  · rfl

omit [Fintype K] in
/-- The classical polynomial pattern is the binary pattern in degree one. -/
theorem polynomialSeed_classicalPattern (x : M → F) (w : List K) :
    polynomialGeometricPattern row s.polynomialSeed.degree
        (s.polynomialSeed.classicalData x) w =
      binomialData (geometricPattern row s.exchange.matrix x w) := by
  have hd : s.polynomialSeed.degree = fun _ ↦ 1 := funext s.polynomialSeed_degree
  rw [hd, s.polynomialSeed_classicalData, polynomialGeometricPattern_one]
  rfl

variable {s} (ε : AddMonoidAlgebra ℤ (M → ℤ) →+* F) {x : M → F}
  (hε : ∀ a, ε (AddMonoidAlgebra.single (Pi.single a 1) 1) = x a)
include hε

/-- **L5, wordwise.** If `ε` sends `x^{e_a}` to `x_a` and the classical coordinates exchanged
along `w` are nonzero, then every quantum coordinate reached from `s` by `w` is the image under
the chart of `s` of a quantum Laurent polynomial whose classical limit evaluates under `ε` to
the classical geometric coordinate after `w`. -/
theorem mutateWord_chartSpecializes (w : List K)
    (hx : ∀ u k, u ++ [k] <+: w → (geometricPattern row s.exchange.matrix x u).2 (row k) ≠ 0)
        (a : M) :
    ChartSpecializes s.chart ε
      ((mutateWord (fun k t ↦ ExchangeFrame.mutate t k) w s).coordinate a : D)
      ((geometricPattern row s.exchange.matrix x w).2 a) := by
  have h := s.polynomialSeed.mutateWord_chartSpecializes ε hε w
    (fun u k hu ↦ by
      simpa only [s.polynomialSeed_classicalPattern, binomialData] using hx u k hu) a
  rw [s.polynomialSeed_mutateWord, s.polynomialSeed_classicalPattern] at h
  exact h

/-- **L5.** The classical limit of the unique quantum Laurent representative of a reachable
coordinate evaluates under `ε` to the classical geometric coordinate after the same word. -/
theorem eval_sp_eq_geometricPattern (w : List K)
    (hx : ∀ u k, u ++ [k] <+: w → (geometricPattern row s.exchange.matrix x u).2 (row k) ≠ 0)
        (a : M)
    (f : quantumTorus Zv vUnit (matrixForm s.form))
    (hf : s.chart f = ((mutateWord (fun k t ↦ ExchangeFrame.mutate t k) w s).coordinate a : D)) :
    ε (sp _ f) = (geometricPattern row s.exchange.matrix x w).2 a :=
  (ChartSpecializes.chart f).unique s.chart_injective
    (hf ▸ mutateWord_chartSpecializes (s := s) ε hε w hx a)

/-- **L5, wordwise, for algebraically independent initial values.** Then no exchanged classical
coordinate vanishes. -/
theorem mutateWord_chartSpecializes_of_algebraicIndependent [Algebra ℚ F]
    (hx : AlgebraicIndependent ℚ x) (w : List K) (a : M) :
    ChartSpecializes s.chart ε
      ((mutateWord (fun k t ↦ ExchangeFrame.mutate t k) w s).coordinate a : D)
      ((geometricPattern row s.exchange.matrix x w).2 a) :=
  mutateWord_chartSpecializes ε hε w
    (fun u k _ ↦ (s.algebraicIndependent_geometricPattern hx u).ne_zero (row k)) a

/-- **L5 for algebraically independent initial values.** The classical limit of the unique
quantum Laurent representative of a reachable coordinate evaluates under `ε` to the classical
geometric coordinate after the same word. -/
theorem eval_sp_eq_geometricPattern_of_algebraicIndependent [Algebra ℚ F]
    (hx : AlgebraicIndependent ℚ x) (w : List K) (a : M)
    (f : quantumTorus Zv vUnit (matrixForm s.form))
    (hf : s.chart f = ((mutateWord (fun k t ↦ ExchangeFrame.mutate t k) w s).coordinate a : D)) :
    ε (sp _ f) = (geometricPattern row s.exchange.matrix x w).2 a :=
  eval_sp_eq_geometricPattern ε hε w
    (fun u k _ ↦ (s.algebraicIndependent_geometricPattern hx u).ne_zero (row k)) a f hf

omit hε in
/-- **L5, wordwise, on §1.4's geometric seeds.** For a geometric seed `g` with the extended
matrix of `s` and `ε(x^{e_a}) = g_a`, every quantum coordinate reached from `s` by `w` is the
image under the chart of `s` of a quantum Laurent polynomial whose classical limit evaluates
under `ε` to the value of the geometric seed reached from `g` by `w`. -/
theorem mutateWord_chartSpecializes_geometricSeed [Algebra ℚ F]
    {g : GeometricSeed (F := F) row s.exchange.symmetrizer}
    (hg : g.exchange = s.exchange.matrix)
    (hεg : ∀ a, ε (AddMonoidAlgebra.single (Pi.single a 1) 1) =
      g.coordinate a) (w : List K) (a : M) :
    ChartSpecializes s.chart ε
      ((mutateWord (fun k t ↦ ExchangeFrame.mutate t k) w s).coordinate a : D)
      ((mutateWord (fun k t ↦ t.mutate s.exchange.symmetrizer_pos k) w g).coordinate a) := by
  have h := mutateWord_chartSpecializes_of_algebraicIndependent (s := s) ε hεg
    g.independent w a
  rwa [← hg, g.geometricPattern_eq s.exchange.symmetrizer_pos] at h

omit hε in
/-- **L5 on §1.4's geometric seeds.** The classical limit of the unique quantum Laurent
representative of a reachable coordinate evaluates under `ε` to the value with the same word and
label of the geometric seed with the same extended matrix and values `ε(x^{e_a})`. -/
theorem eval_sp_eq_geometricSeed [Algebra ℚ F]
    {g : GeometricSeed (F := F) row s.exchange.symmetrizer}
    (hg : g.exchange = s.exchange.matrix)
    (hεg : ∀ a, ε (AddMonoidAlgebra.single (Pi.single a 1) 1) =
      g.coordinate a) (w : List K) (a : M) (f : quantumTorus Zv vUnit (matrixForm s.form))
    (hf : s.chart f = ((mutateWord (fun k t ↦ ExchangeFrame.mutate t k) w s).coordinate a : D)) :
    ε (sp _ f) = (mutateWord (fun k t ↦ t.mutate s.exchange.symmetrizer_pos k) w g).coordinate a :=
  (ChartSpecializes.chart f).unique s.chart_injective
    (hf ▸ mutateWord_chartSpecializes_geometricSeed (s := s) ε hg hεg w a)

omit [Fintype K] in
/-- Every classical geometric coordinate reached under the nonvanishing hypothesis is the image
under `ε` of an integral Laurent polynomial. -/
theorem geometricPattern_snd_mem_range [Finite K] (s : ExchangeFrame (u₀ := vUnit) D row)
    (w : List K)
    (hx : ∀ u k, u ++ [k] <+: w → (geometricPattern row s.exchange.matrix x u).2 (row k) ≠ 0)
        (a : M) :
    (geometricPattern row s.exchange.matrix x w).2 a ∈ ε.range := by
  let : Fintype K := Fintype.ofFinite K
  obtain ⟨f, -, hf⟩ := mutateWord_chartSpecializes (s := s) ε hε w hx a
  exact ⟨_, hf⟩

end ExchangeFrame

end Comparison

/-! ### The comparison in the Laurent ring -/

section LaurentForm

variable (M : Type*) [Fintype M] [DecidableEq M]

/-- Algebraic independence over `ℤ` in a field of characteristic zero gives it over `ℚ`. -/
theorem algebraicIndependent_rat_of_int {ι F : Type*} [Field F] [CharZero F] {x : ι → F}
    (hx : AlgebraicIndependent ℤ x) : AlgebraicIndependent ℚ x := by
  have : Algebra.IsAlgebraic ℤ ℚ := IsLocalization.isAlgebraic ℚ (nonZeroDivisors ℤ)
  exact hx.extendScalars ℚ

omit [Fintype M] in
/-- The generators `x^{e_a}` of `ℤ[ℤ ^ M]` are algebraically independent over `ℤ`. -/
theorem algebraicIndependent_single_single :
    AlgebraicIndependent ℤ fun a : M ↦
      (AddMonoidAlgebra.single (Pi.single a 1) 1 : AddMonoidAlgebra ℤ (M → ℤ)) := by
  let φ : (M →₀ ℕ) →+ (M → ℤ) :=
    { toFun := fun f a ↦ (f a : ℤ)
      map_zero' := by ext; simp
      map_add' := fun f g ↦ by ext; simp }
  have hφ : Function.Injective φ := fun f g h ↦ Finsupp.ext fun a ↦ by
    have := congrFun h a
    simp only [φ, AddMonoidHom.coe_mk, ZeroHom.coe_mk] at this
    exact_mod_cast this
  have heq : (MvPolynomial.aeval fun a : M ↦
      (AddMonoidAlgebra.single (Pi.single a 1) 1 : AddMonoidAlgebra ℤ (M → ℤ))).toRingHom =
      AddMonoidAlgebra.mapDomainRingHom ℤ φ := by
    apply MvPolynomial.ringHom_ext
    · intro c
      exact (eq_intCast ((MvPolynomial.aeval fun a : M ↦
        (AddMonoidAlgebra.single (Pi.single a 1) 1 : AddMonoidAlgebra ℤ (M → ℤ))).toRingHom.comp
          MvPolynomial.C) c).trans
        (eq_intCast ((AddMonoidAlgebra.mapDomainRingHom ℤ φ).comp MvPolynomial.C) c).symm
    · intro a
      change _ = AddMonoidAlgebra.mapDomain φ (AddMonoidAlgebra.single (Finsupp.single a 1) 1)
      rw [AddMonoidAlgebra.mapDomain_single]
      simp only [AlgHom.toRingHom_eq_coe, RingHom.coe_coe, MvPolynomial.aeval_X]
      congr 1
      funext b
      simp [φ, Finsupp.single_apply, Pi.single_apply, eq_comm]
  rw [algebraicIndependent_iff_injective_aeval]
  change Function.Injective (MvPolynomial.aeval fun a : M ↦
    (AddMonoidAlgebra.single (Pi.single a 1) 1 : AddMonoidAlgebra ℤ (M → ℤ))).toRingHom
  rw [heq]
  exact AddMonoidAlgebra.mapDomain_injective hφ

/-- The generators `x^{e_a}` of `ℤ[ℤ ^ M]` in its fraction field. -/
def laurentFractionCoordinate (a : M) : FractionRing (AddMonoidAlgebra ℤ (M → ℤ)) :=
  algebraMap (AddMonoidAlgebra ℤ (M → ℤ)) _ (AddMonoidAlgebra.single (Pi.single a 1) 1)

omit [Fintype M] in
theorem algebraicIndependent_laurentFractionCoordinate :
    AlgebraicIndependent ℤ (laurentFractionCoordinate M) :=
  ((IsScalarTower.toAlgHom ℤ (AddMonoidAlgebra ℤ (M → ℤ)) _).algebraicIndependent_iff
    (IsFractionRing.injective _ _)).2 (algebraicIndependent_single_single M)

variable {M} {D : Type*} [DivisionRing D] [Algebra Zv D] {K : Type*} [Fintype K] [DecidableEq K]
  {row : K ↪ M}

namespace ExchangeFrame

/-- **L5 in the Laurent ring.** The classical limit of the unique quantum Laurent representative
`f` of a reachable coordinate is the Laurent expansion in the initial coordinates of the
classical geometric coordinate with the same word, initial extended matrix and label. -/
theorem algebraMap_sp_eq_geometricPattern (s : ExchangeFrame (u₀ := vUnit) D row)
    (w : List K) (a : M) (f : quantumTorus Zv vUnit (matrixForm s.form))
    (hf : s.chart f = ((mutateWord (fun k t ↦ ExchangeFrame.mutate t k) w s).coordinate a : D)) :
    algebraMap _ (FractionRing (AddMonoidAlgebra ℤ (M → ℤ))) (sp _ f) =
      (geometricPattern row s.exchange.matrix (laurentFractionCoordinate M) w).2 a := by
  have hZ := algebraicIndependent_laurentFractionCoordinate M
  let : CharZero (FractionRing (AddMonoidAlgebra ℤ (M → ℤ))) :=
    charZero_of_injective_algebraMap hZ.algebraMap_injective
  -- `hZ` uses the localization's `ℤ`-algebra; `Algebra ℤ _` is a subsingleton.
  have hQ := algebraicIndependent_rat_of_int (x := laurentFractionCoordinate M)
    (by convert hZ; exact Subsingleton.elim _ _)
  exact eval_sp_eq_geometricPattern_of_algebraicIndependent (algebraMap _ _) (fun _ ↦ rfl) hQ
    w a f hf

/-- The classical geometric coordinate has a unique Laurent preimage in `ℤ[ℤ ^ M]`, namely the
classical limit of the quantum representative. -/
theorem algebraMap_eq_geometricPattern_iff (s : ExchangeFrame (u₀ := vUnit) D row)
    (w : List K) (a : M) (f : quantumTorus Zv vUnit (matrixForm s.form))
    (hf : s.chart f = ((mutateWord (fun k t ↦ ExchangeFrame.mutate t k) w s).coordinate a : D))
    (p : AddMonoidAlgebra ℤ (M → ℤ)) :
    algebraMap _ (FractionRing (AddMonoidAlgebra ℤ (M → ℤ))) p =
        (geometricPattern row s.exchange.matrix (laurentFractionCoordinate M) w).2 a ↔ p
            = sp _ f := by
  rw [← s.algebraMap_sp_eq_geometricPattern w a f hf]
  exact (IsFractionRing.injective _ _).eq_iff

end ExchangeFrame

end LaurentForm

/-! ### The principal quantum seed -/

variable {I : Type*} [Fintype I] [DecidableEq I]

section PrincipalSeed

variable (d : I → ℤ) (B : I → I → ℤ)

/-- The ambient division ring `Frac T(ℚ(v), v, Λ_pr)` of the principal quantum seed. -/
abbrev PrincipalQuantumField : Type _ :=
  FractionDivisionRing (FractionRing Zv)
    (Units.map (algebraMap Zv (FractionRing Zv) : Zv →* FractionRing Zv) vUnit)
    (matrixForm (principalPairForm B d))

/-- The integral chart `T(Zv,v,Λ_pr) → Frac T(ℚ(v),v,Λ_pr)` of the principal pair. -/
abbrev principalQuantumChart :
    quantumTorus Zv vUnit (matrixForm (principalPairForm B d)) →ₐ[Zv] PrincipalQuantumField d B :=
  integralChart Zv (FractionRing Zv) vUnit (matrixForm (principalPairForm B d))

theorem principalQuantumChart_injective : Function.Injective (principalQuantumChart d B) :=
  integralChart_injective _ _ _ _

variable (hB : ∀ i j, d i * B i j = -(d j * B j i)) (hd : ∀ i, 0 < d i)

include hB in
theorem principalPairForm_matrixForm_isAlt :
    LinearMap.IsAlt (matrixForm (principalPairForm B d)) :=
  (principalPairForm_isAlternating B d hB).isAlt

/-- The initial quantum coordinates `X_a`, the images of the generators of `T(Zv,v,Λ_pr)`. -/
def principalQuantumCoordinate (a : I ⊕ I) : (PrincipalQuantumField d B)ˣ :=
  Units.map (principalQuantumChart d B :
      quantumTorus Zv vUnit (matrixForm (principalPairForm B d)) →* PrincipalQuantumField d B)
    (monomialUnit (principalPairForm_matrixForm_isAlt d B hB) (Pi.single a 1))

@[simp] theorem principalQuantumCoordinate_val (a : I ⊕ I) :
    (principalQuantumCoordinate d B hB a : PrincipalQuantumField d B) =
      principalQuantumChart d B (monomial (Pi.single a 1)) := by
  simp [principalQuantumCoordinate]

theorem principalQuantumCoordinate_quasiCommuting :
    IsQuasiCommuting vUnit (matrixForm (principalPairForm B d))
      (principalQuantumCoordinate d B hB) := by
  intro i j
  rw [principalQuantumCoordinate_val, principalQuantumCoordinate_val, ← map_mul, ← map_mul,
    monomial_mul_monomial_comm (principalPairForm_matrixForm_isAlt d B hB), map_smul]

theorem principalQuantumChart_eq_lift :
    principalQuantumChart d B =
      QuantumTorus.lift (principalPairForm_matrixForm_isAlt d B hB)
        (principalQuantumCoordinate d B hB) (principalQuantumCoordinate_quasiCommuting d B hB) :=
  eq_lift _ _ _ fun a ↦ (principalQuantumCoordinate_val d B hB a).symm

/-- **The principal quantum seed** in `Frac T(ℚ(v),v,Λ_pr)`: the principal compatible pair
`(B_ext_pr, Λ_pr)` and the generators of the faithful integral chart. -/
def principalExchangeFrame :
    ExchangeFrame (u₀ := vUnit) (PrincipalQuantumField d B) (Function.Embedding.inl : I ↪ I ⊕ I)
      where
  exchange := principalExchangeMatrix B d hd hB
  form := principalPairForm B d
  alternating := principalPairForm_isAlternating B d hB
  formWeight := d
  compatible := principalPair_isCompatible B d hd hB
  independentColumns := (principalPair_isCompatible B d hd hB).independent_columns
  coordinate := principalQuantumCoordinate d B hB
  quasiCommuting := principalQuantumCoordinate_quasiCommuting d B hB
  faithful := by
    rw [← principalQuantumChart_eq_lift]
    exact principalQuantumChart_injective d B

@[simp] theorem principalExchangeFrame_exchange :
    (principalExchangeFrame d B hB hd).exchange.matrix = principalPairMatrix B := rfl

@[simp] theorem principalExchangeFrame_form :
    (principalExchangeFrame d B hB hd).form = principalPairForm B d := rfl

theorem principalExchangeFrame_chart :
    (principalExchangeFrame d B hB hd).chart = principalQuantumChart d B :=
  (principalQuantumChart_eq_lift d B hB).symm

end PrincipalSeed

/-! ### Classical evaluation -/

/-- The classical evaluation `ℤ[ℤ^{I⊕I}] → ℚ(x, z)`, `x ^ a ↦ ∏ x_i^{a_i}`, at the initial
principal geometric coordinates. -/
def principalGeometricEval : AddMonoidAlgebra ℤ ((I ⊕ I) → ℤ) →+* PrincipalGeometricField I :=
  (LaurentEvaluation.eval (Int.castRingHom _) principalGeometricUnits).comp
    (AddMonoidAlgebra.mapDomainRingHom ℤ
      (Finsupp.linearEquivFunOnFinite ℤ ℤ (I ⊕ I)).symm.toAddEquiv.toAddMonoidHom)

theorem principalGeometricEval_single (a : I ⊕ I) :
    principalGeometricEval (AddMonoidAlgebra.single (Pi.single a 1) 1) =
      rationalLaurentCoordinates (I ⊕ I) a := by
  simp [principalGeometricEval, AddMonoidAlgebra.mapDomain_single,
    principalGeometricUnits]

omit [DecidableEq I] in
theorem principalGeometricEval_apply (p : AddMonoidAlgebra ℤ ((I ⊕ I) → ℤ)) :
    principalGeometricEval p =
      LaurentEvaluation.eval (Int.castRingHom _) principalGeometricUnits
        (AddMonoidAlgebra.mapDomainRingHom ℤ
          (Finsupp.linearEquivFunOnFinite ℤ ℤ (I ⊕ I)).symm.toAddEquiv.toAddMonoidHom p) := by
  classical
  exact rfl

omit [DecidableEq I] in
/-- Classical evaluation lands in the integral Laurent chart ring of the initial coordinates. -/
theorem principalGeometricEval_mem_chartRing (p : AddMonoidAlgebra ℤ ((I ⊕ I) → ℤ)) :
    principalGeometricEval p ∈ chartRing (Int.castRingHom (PrincipalGeometricField I)).range
      (rationalLaurentCoordinates (I ⊕ I)) := by
  classical
  exact LaurentEvaluation.eval_mem_chart _ principalGeometricUnits _


/-! ### The principal comparison -/

section PrincipalComparison

variable (d : I → ℤ) (hd : ∀ i, 0 < d i) (B : I → I → ℤ)
  (hB : ∀ i j, d i * B i j = -(d j * B j i))

theorem geometricWordData_append (w : List I) (k : I) :
    geometricWordData d hd B hB (w ++ [k]) = geometricStep k (geometricWordData d hd B hB w) := by
  rw [geometricWordData, List.foldl_append]
  rfl

theorem geometricStep_eq_geometricExchange (k : I)
    (p : Matrix (I ⊕ I) I ℤ × ((I ⊕ I) → PrincipalGeometricField I)) :
    geometricStep k p = geometricExchange (Function.Embedding.inl : I ↪ I ⊕ I) k p := by
  refine Prod.ext rfl ?_
  rw [geometricExchange_snd_eq_geometricMutationCoordinates]
  rfl

/-- The principal geometric coordinates form the classical geometric pattern of the initial
principal extended matrix at the initial coordinates. -/
theorem geometricWordData_eq_geometricPattern (w : List I) :
    geometricWordData d hd B hB w =
      geometricPattern (Function.Embedding.inl : I ↪ I ⊕ I) (principalExtendedMatrix hd B hB [])
        (rationalLaurentCoordinates (I ⊕ I)) w := by
  induction w using List.reverseRecOn with
  | nil => rfl
  | append_singleton w k ih =>
    rw [geometricWordData_append, geometricPattern_append, ih, geometricStep_eq_geometricExchange]

theorem principalExchangeFrame_geometricPattern (w : List I) :
    geometricPattern (Function.Embedding.inl : I ↪ I ⊕ I)
        (principalExchangeFrame d B hB hd).exchange.matrix
        (rationalLaurentCoordinates (I ⊕ I)) w = geometricWordData d hd B hB w := by
  rw [principalExchangeFrame_exchange, principalPairMatrix_eq_principalExtendedMatrix B d hd hB,
    geometricWordData_eq_geometricPattern]

/-- The quantum and classical principal patterns carry the same extended matrix. -/
theorem principalExchangeFrame_mutateWord_exchange (w : List I) :
    (mutateWord (fun k t ↦ ExchangeFrame.mutate t k) w
        (principalExchangeFrame d B hB hd)).exchange.matrix =
      (geometricWordData d hd B hB w).1 := by
  rw [(principalExchangeFrame d B hB hd).mutateWord_exchange_eq_geometricPattern
    (rationalLaurentCoordinates (I ⊕ I)), principalExchangeFrame_geometricPattern]

/-- **L5 for the principal seed, wordwise.** Every coordinate reached by a word is the image of
a quantum Laurent polynomial whose classical limit evaluates to the classical geometric
coordinate after the same word. -/
theorem principalExchangeFrame_mutateWord_chartSpecializes (w : List I) (a : I ⊕ I) :
    ChartSpecializes (principalQuantumChart d B) principalGeometricEval
      ((mutateWord (fun k t ↦ ExchangeFrame.mutate t k) w (principalExchangeFrame d B hB
        hd)).coordinate
        a : PrincipalQuantumField d B) ((geometricWordData d hd B hB w).2 a) := by
  have h := ExchangeFrame.mutateWord_chartSpecializes_of_algebraicIndependent
    (s := principalExchangeFrame d B hB hd) principalGeometricEval
    principalGeometricEval_single (algebraicIndependent_rationalLaurentCoordinates (I ⊕ I)) w a
  rwa [principalExchangeFrame_geometricPattern d hd B hB, principalExchangeFrame_chart] at h

/-- The unique quantum Laurent representative of a reachable coordinate specializes, at `v = 1`
and the initial geometric coordinates, to the classical geometric coordinate. -/
theorem principalGeometricEval_sp_eq_geometricWordData
    (w : List I) (a : I ⊕ I) (f : quantumTorus Zv vUnit (matrixForm (principalPairForm B d)))
    (hf : principalQuantumChart d B f =
      ((mutateWord (fun k t ↦ ExchangeFrame.mutate t k) w (principalExchangeFrame d B hB
        hd)).coordinate
        a : PrincipalQuantumField d B)) :
    principalGeometricEval (sp _ f) = (geometricWordData d hd B hB w).2 a :=
  (ChartSpecializes.chart f).unique (principalQuantumChart_injective d B)
    (hf ▸ principalExchangeFrame_mutateWord_chartSpecializes d hd B hB w a)

/-- Each reachable coordinate has a unique representative in the initial quantum torus. -/
theorem existsUnique_principalQuantumChart_eq (w : List I) (a : I ⊕ I) :
    ∃! f, principalQuantumChart d B f =
      ((mutateWord (fun k t ↦ ExchangeFrame.mutate t k) w (principalExchangeFrame d B hB
        hd)).coordinate
        a : PrincipalQuantumField d B) := by
  rw [← principalExchangeFrame_chart d B hB]
  exact (principalExchangeFrame d B hB hd).existsUnique_chart_eq_coordinate_mutateWord w a

/-- **The principal expansion in `ℤ[u_i^{±1}][x_i^{±1}]`.** Through the regrouping
`L(ℤ, I ⊔ I) ≃ L(L(ℤ, I), I)`, every principal geometric coordinate `X_{j;t}(x, u)` has a unique
expansion as a Laurent polynomial in the initial mutable values `x_i` whose coefficients are
Laurent polynomials in the initial frozen values `u_i`. -/
theorem existsUnique_eval_eq_geometricWordData (w : List I) (a : I ⊕ I) :
    ∃! p : AddMonoidAlgebra (AddMonoidAlgebra ℤ (I →₀ ℤ)) (I →₀ ℤ),
      LaurentEvaluation.eval
          (LaurentEvaluation.eval (Int.castRingHom _) (principalGeometricUnits ∘ Sum.inr))
          (principalGeometricUnits ∘ Sum.inl) p =
        (geometricWordData d hd B hB w).2 a := by
  obtain ⟨f, -, hf⟩ := principalExchangeFrame_mutateWord_chartSpecializes d hd B hB w a
  rw [principalGeometricEval_apply] at hf
  refine ⟨laurentRegroup ℤ I I _, (LaurentEvaluation.eval_laurentRegroup _ _ _).trans hf,
    fun p hp ↦ ?_⟩
  have hu : (fun i ↦ (principalGeometricUnits i : PrincipalGeometricField I)) =
      rationalLaurentCoordinates (I ⊕ I) := funext fun _ ↦ Units.val_mk0 _
  have hai := algebraicIndependent_rationalLaurentCoordinates (I ⊕ I)
  rw [← hu] at hai
  have hinj := integerLaurent_eval_injective_of_algebraicIndependent
    principalGeometricUnits hai
  rw [← (laurentRegroup ℤ I I).apply_symm_apply p]
  refine congrArg _ (hinj ?_)
  rw [LaurentEvaluation.eval_laurentRegroup_symm, hp, hf]

/-- §1.4's geometric seeds give the principal geometric coordinates: they are the extended
matrices and values of the mutations of the initial principal geometric seed. -/
theorem geometricWordData_eq_mutateWord (w : List I) :
    geometricWordData d hd B hB w =
      ((mutateWord (fun k t ↦ t.mutate hd k) w (principalInitialGeometricSeed d hd B
        hB).1).exchange,
        (mutateWord (fun k t ↦ t.mutate hd k) w
          (principalInitialGeometricSeed d hd B hB).1).coordinate) := by
  rw [geometricWordData_eq_geometricPattern]
  exact (principalInitialGeometricSeed d hd B hB).1.geometricPattern_eq hd w

end PrincipalComparison

/-! ### `C`-matrices and `c`-vectors -/

section CVectors

variable (B : I → I → ℤ)

/-- **`C_t`**: the frozen block of the principal extended matrix `B_ext_t = μ_w (B; Id)` after the
word `w`. -/
def cMatrix (w : List I) : Matrix I I ℤ := fun i j ↦
  mutateWord (fun k B ↦ extendedMatrixMutation (Function.Embedding.inl : I ↪ I ⊕ I) B k) w
    (principalPairMatrix B) (Sum.inr i) j

/-- **The `c`-vector** `c_{j;t}`: the `j`th column of `C_t`. -/
def cVector (w : List I) (j : I) : I → ℤ := fun i ↦ cMatrix B w i j
omit [Fintype I] in
@[simp] theorem cMatrix_nil : cMatrix B [] = 1 := by
  ext i j
  simp [cMatrix, Matrix.one_apply]

omit [Fintype I] in
@[simp] theorem cVector_nil (j : I) : cVector B [] j = Pi.single j 1 := by
  funext i
  simp [cVector, Matrix.one_apply, Pi.single_apply]

omit [Fintype I] in
/-- **Mutation of `c`-vectors**, with `b_{kj}` the entries of the principal block of `B_ext_t`. -/
theorem cMatrix_append (w : List I) (k i j : I) :
    cMatrix B (w ++ [k]) i j =
      if j = k then -cMatrix B w i k else
        cMatrix B w i j + positivePart (cMatrix B w i k) *
          positivePart (mutateWord (fun k B ↦ extendedMatrixMutation
            (Function.Embedding.inl : I ↪ I ⊕ I) B k) w (principalPairMatrix B) (Sum.inl k) j) -
        positivePart (-cMatrix B w i k) *
          positivePart (-mutateWord (fun k B ↦ extendedMatrixMutation
            (Function.Embedding.inl : I ↪ I ⊕ I) B k) w (principalPairMatrix B) (Sum.inl k) j) := by
  simp only [cMatrix, mutateWord_append, mutateWord_cons, mutateWord_nil]
  by_cases hj : j = k
  · subst hj
    simp [extendedMatrixMutation]
  · simp [extendedMatrixMutation, hj]

variable {B} (d : I → ℤ) (hd : ∀ i, 0 < d i) (hB : ∀ i j, d i * B i j = -(d j * B j i))
include hd hB

/-- `C_t` is the frozen block of the principal geometric pattern and of the principal quantum
pattern. -/
theorem cMatrix_eq_geometricWordData (w : List I) (i j : I) :
    cMatrix B w i j = (geometricWordData d hd B hB w).1 (Sum.inr i) j := by
  rw [← principalExchangeFrame_mutateWord_exchange d hd B hB,
    (principalExchangeFrame d B hB hd).mutateWord_exchange]
  rfl

omit [Fintype I] in
/-- The `c`-vectors are the tropical exponents of the principal coefficients `y_{j;t}`. -/
theorem cMatrix_eq_principalFrozenRow [Finite I] (w : List I) (i j : I) :
    cMatrix B w i j = principalFrozenRow hd B hB w i j := by
  let : Fintype I := Fintype.ofFinite I
  rw [cMatrix_eq_geometricWordData d hd hB, geometricWordData_matrix]
  rfl

end CVectors

end

end TauCeti.Cluster
