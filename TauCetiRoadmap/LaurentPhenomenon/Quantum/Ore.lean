/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.Quantum.Coefficients
public import TauCetiRoadmap.LaurentPhenomenon.Quantum.Domain
public import TauCetiRoadmap.LaurentPhenomenon.Quantum.LatticeBasis
public import Mathlib.Data.Int.Interval
public import Mathlib.LinearAlgebra.FiniteDimensional.Lemmas
public import Mathlib.RingTheory.Localization.FractionRing
public import Mathlib.RingTheory.OreLocalization.OreSet
public import Mathlib.RingTheory.OreLocalization.Ring

/-!
# The skew field of fractions of a quantum torus

* Over a field `K` and a finite free lattice `L`, the nonzero elements of `T(K,u,Λ)` satisfy both
  Ore conditions: `p r = q s` and `r p' = s q'` with `p, p' ≠ 0`. So they form a left Ore set of
  `T(K,u,Λ)` and of its opposite ring, and both left and right fractions exist. The proof is by
  growth on the coordinate lattice `M → ℤ` (`exists_mul_eq_mul_pi`): the span `W_n` of the
  monomials with exponents in the box `[-n,n] ^ M` has dimension `(2n + 1)^|M|`; if `r, s ≠ 0` lie
  in `W_c`, then `W_n r` and `W_n s` (respectively `r W_n` and `s W_n`) are subspaces of
  `W_{n + c}` of dimension `(2n + 1)^|M|`, so they meet as soon as `2(2n + 1)^|M| > (2n + 2c +
    1)^|M|`.
  A basis of `L` transports this to `L` (`TauCeti.QuantumTorus.basisTorusEquiv`).
* `TauCeti.QuantumTorus.FractionDivisionRing K u Λ`: the Ore localization of `T(K,u,Λ)` at its
  nonzero elements, a division ring into which `T(K,u,Λ)` embeds.
* `TauCeti.QuantumTorus.integralChart`: for a fraction field `K` of `R`, the injective
  `R`-algebra map from `T(R,u,Λ)` into the skew field of fractions of `T(K,u,Λ)`
  (`TauCeti.QuantumTorus.integralChart_injective`). For `R = Zv` this is the faithful integral
  chart of the quantum torus over `ℤ[v,v⁻¹]`.
* Over a domain `R`, the nonzero elements of `T(R,u,Λ)` satisfy the left Ore condition
  (`TauCeti.QuantumTorus.exists_mul_eq_mul_of_isDomain`), by clearing denominators in the Ore
  condition over the fraction field (`TauCeti.QuantumTorus.exists_mapRangeAlgHom_eq_smul`).
-/

@[expose] public section

namespace TauCeti.QuantumTorus

open TauCeti Module

/-! ### Boxes of exponents -/

section Box

variable {M : Type*} [Fintype M] [DecidableEq M]

/-- The exponents `a : M → ℤ` with `|a i| ≤ n` for all `i`. -/
def exponentBox (n : ℕ) : Finset (M → ℤ) :=
  Fintype.piFinset fun _ ↦ Finset.Icc (-(n : ℤ)) n

theorem mem_exponentBox {n : ℕ} {a : M → ℤ} :
    a ∈ exponentBox n ↔ ∀ i, -(n : ℤ) ≤ a i ∧ a i ≤ n := by
  simp [exponentBox]

theorem card_exponentBox (n : ℕ) :
    (exponentBox n : Finset (M → ℤ)).card = (2 * n + 1) ^ Fintype.card M := by
  rw [exponentBox, Fintype.card_piFinset, Finset.prod_const, Finset.card_univ, Int.card_Icc]
  congr 1
  omega

theorem add_mem_exponentBox {p q : ℕ} {a b : M → ℤ} (ha : a ∈ exponentBox p)
    (hb : b ∈ exponentBox q) : a + b ∈ exponentBox (p + q) := by
  rw [mem_exponentBox] at *
  intro i
  have := ha i
  have := hb i
  simp only [Pi.add_apply]
  omega

theorem exists_subset_exponentBox (s : Finset (M → ℤ)) : ∃ n, s ⊆ exponentBox n := by
  refine ⟨∑ a ∈ s, ∑ i, (a i).natAbs, fun a ha ↦ mem_exponentBox.2 fun i ↦ ?_⟩
  have h₁ : (a i).natAbs ≤ ∑ i, (a i).natAbs :=
    Finset.single_le_sum (f := fun i ↦ (a i).natAbs) (fun _ _ ↦ Nat.zero_le _) (Finset.mem_univ i)
  have h₂ : ∑ i, (a i).natAbs ≤ ∑ a ∈ s, ∑ i, (a i).natAbs :=
    Finset.single_le_sum (f := fun a : M → ℤ ↦ ∑ i, (a i).natAbs) (fun _ _ ↦ Nat.zero_le _) ha
  omega

variable {R : Type*} [CommRing R] {u : Rˣ} {Λ : LinearMap.BilinForm ℤ (M → ℤ)}

variable (R u Λ) in
/-- The `R`-span `W_n` of the monomials `X ^ a` with `a` in the box `[-n,n] ^ M`. -/
noncomputable def boxSubmodule (n : ℕ) : Submodule R (quantumTorus R u Λ) :=
  (Finsupp.supported R R (exponentBox (M := M) n : Set (M → ℤ))).map
    ((monomialBasis (R := R) (u := u) (Λ := Λ)).repr.symm :
      ((M → ℤ) →₀ R) →ₗ[R] quantumTorus R u Λ)

theorem mem_boxSubmodule {n : ℕ} {x : quantumTorus R u Λ} :
    x ∈ boxSubmodule R u Λ n ↔ ∀ a, monomialBasis.repr x a ≠ 0 → a ∈ exponentBox n := by
  rw [boxSubmodule, Submodule.mem_map_equiv, LinearEquiv.symm_symm, Finsupp.mem_supported]
  exact ⟨fun h a ha ↦ h (Finsupp.mem_support_iff.2 ha), fun h a ha ↦
    h a (Finsupp.mem_support_iff.1 ha)⟩

theorem mul_mem_boxSubmodule {p q : ℕ} {x y : quantumTorus R u Λ}
    (hx : x ∈ boxSubmodule R u Λ p) (hy : y ∈ boxSubmodule R u Λ q) :
    x * y ∈ boxSubmodule R u Λ (p + q) := by
  classical
  rw [mem_boxSubmodule] at *
  intro c hc
  by_contra hcn
  refine hc ?_
  rw [repr_mul_apply]
  refine Finset.sum_eq_zero fun a ha ↦ Finset.sum_eq_zero fun b hb ↦ ?_
  rw [ite_eq_right]
  rintro rfl
  exact absurd (add_mem_exponentBox (hx a (Finsupp.mem_support_iff.1 ha))
    (hy b (Finsupp.mem_support_iff.1 hb))) hcn

theorem mem_boxSubmodule_of_subset {n : ℕ} {x : quantumTorus R u Λ}
    (h : (monomialBasis.repr x).support ⊆ exponentBox n) : x ∈ boxSubmodule R u Λ n :=
  mem_boxSubmodule.2 fun _ ha ↦ h (Finsupp.mem_support_iff.2 ha)

variable {K : Type*} [Field K] {u : Kˣ}

theorem finrank_boxSubmodule (n : ℕ) :
    finrank K (boxSubmodule K u Λ n) = (2 * n + 1) ^ Fintype.card M := by
  rw [boxSubmodule, LinearEquiv.finrank_map_eq, (Finsupp.supportedEquivFinsupp _).finrank_eq,
    Module.finrank_finsupp_self]
  simp [card_exponentBox]

instance (n : ℕ) : FiniteDimensional K (boxSubmodule K u Λ n) :=
  Module.finite_of_finrank_pos (by rw [finrank_boxSubmodule]; positivity)

end Box

/-! ### The Ore condition -/

section Ore

/-- `(m + k) ^ (d + 1) ≤ m ^ d (m + (1 + k) ^ (d + 1) - 1)` for `m ≥ 1`, without subtraction. -/
theorem add_pow_succ_add_pow_le (m k d : ℕ) (hm : 1 ≤ m) :
    (m + k) ^ (d + 1) + m ^ d ≤ m ^ d * (m + (1 + k) ^ (d + 1)) := by
  induction d with
  | zero => simp only [zero_add, pow_one, pow_zero, one_mul]; omega
  | succ d ih =>
    obtain ⟨m', rfl⟩ : ∃ m', m = m' + 1 := ⟨m - 1, by omega⟩
    obtain ⟨A, hA⟩ : ∃ A, (1 + k) ^ (d + 1) = A + 1 :=
      ⟨(1 + k) ^ (d + 1) - 1, (Nat.sub_add_cancel (Nat.one_le_pow _ _ (by omega))).symm⟩
    rw [hA] at ih
    rw [pow_succ (m' + 1 + k), pow_succ (m' + 1) d, pow_succ (1 + k), hA]
    nlinarith [Nat.mul_le_mul_right (m' + 1 + k) ih, Nat.zero_le ((m' + 1) ^ d * k * m' * A)]

/-- For every `c` and `d` there is `n` with `(2n + 2c + 1) ^ d < 2(2n + 1) ^ d`. -/
theorem exists_pow_lt_two_mul_pow (c d : ℕ) :
    ∃ n : ℕ, (2 * n + 2 * c + 1) ^ d < 2 * (2 * n + 1) ^ d := by
  rcases d with _ | d
  · exact ⟨0, by norm_num⟩
  refine ⟨(1 + 2 * c) ^ (d + 1), ?_⟩
  set m := 2 * (1 + 2 * c) ^ (d + 1) + 1
  have h := add_pow_succ_add_pow_le m (2 * c) d (by omega)
  have hpos : 0 < m ^ d := pow_pos (by omega) d
  have hlt : m ^ d * (m + (1 + 2 * c) ^ (d + 1)) < m ^ d * (2 * m) :=
    Nat.mul_lt_mul_of_pos_left (by omega) hpos
  calc (2 * (1 + 2 * c) ^ (d + 1) + 2 * c + 1) ^ (d + 1) = (m + 2 * c) ^ (d + 1) := by
        simp only [m]; ring
    _ < m ^ d * (2 * m) := by omega
    _ = 2 * m ^ (d + 1) := by ring

section Growth

variable {K : Type*} [Field K] {M : Type*} [Fintype M] [DecidableEq M] {u : Kˣ}
  {Λ : LinearMap.BilinForm ℤ (M → ℤ)}

/-- **Growth in boxes.** Two injective `K`-linear endomorphisms `φ, ψ` of `T(K,u,Λ)` that raise
the box degree by at most `c` take equal values at some `p ≠ 0` and `q`: the images of `W_n`
have dimension `(2n + 1)^|M|` inside `W_{n + c}`, so they meet for large `n`. -/
theorem exists_ne_zero_apply_eq_apply (φ ψ : quantumTorus K u Λ →ₗ[K] quantumTorus K u Λ)
    (hφ : Function.Injective φ) (hψ : Function.Injective ψ) (c : ℕ)
    (hφc : ∀ n, (boxSubmodule K u Λ n).map φ ≤ boxSubmodule K u Λ (n + c))
    (hψc : ∀ n, (boxSubmodule K u Λ n).map ψ ≤ boxSubmodule K u Λ (n + c)) :
    ∃ p q : quantumTorus K u Λ, p ≠ 0 ∧ φ p = ψ q := by
  obtain ⟨n, hn⟩ := exists_pow_lt_two_mul_pow c (Fintype.card M)
  set W := boxSubmodule K u Λ n
  set A := W.map φ
  set B := W.map ψ
  have hA : A ≤ boxSubmodule K u Λ (n + c) := hφc n
  have hB : B ≤ boxSubmodule K u Λ (n + c) := hψc n
  have := Submodule.finiteDimensional_of_le hA
  have := Submodule.finiteDimensional_of_le hB
  have hAr : finrank K A = (2 * n + 1) ^ Fintype.card M := by
    rw [← finrank_boxSubmodule (K := K) (u := u) (Λ := Λ) n]
    exact (Submodule.equivMapOfInjective _ hφ W).finrank_eq.symm
  have hBr : finrank K B = (2 * n + 1) ^ Fintype.card M := by
    rw [← finrank_boxSubmodule (K := K) (u := u) (Λ := Λ) n]
    exact (Submodule.equivMapOfInjective _ hψ W).finrank_eq.symm
  have hsup : finrank K ↥(A ⊔ B) ≤ (2 * n + 2 * c + 1) ^ Fintype.card M := by
    have := Submodule.finrank_mono (sup_le hA hB)
    rwa [finrank_boxSubmodule, show 2 * (n + c) + 1 = 2 * n + 2 * c + 1 by ring] at this
  have key := Submodule.finrank_sup_add_finrank_inf_eq A B
  have hinf : A ⊓ B ≠ ⊥ := by
    intro h
    rw [h, finrank_bot, hAr, hBr] at key
    omega
  obtain ⟨z, hz, hz0⟩ := Submodule.exists_mem_ne_zero_of_ne_bot hinf
  obtain ⟨p, -, rfl⟩ := Submodule.mem_map.1 (Submodule.mem_inf.1 hz).1
  obtain ⟨q, -, hq⟩ := Submodule.mem_map.1 (Submodule.mem_inf.1 hz).2
  refine ⟨p, q, ?_, hq.symm⟩
  rintro rfl
  simp at hz0

/-- A single box contains the supports of two given elements. -/
theorem exists_mem_boxSubmodule (r s : quantumTorus K u Λ) :
    ∃ c, r ∈ boxSubmodule K u Λ c ∧ s ∈ boxSubmodule K u Λ c := by
  obtain ⟨c, hc⟩ :=
    exists_subset_exponentBox ((monomialBasis.repr r).support ∪ (monomialBasis.repr s).support)
  exact ⟨c, mem_boxSubmodule_of_subset (Finset.subset_union_left.trans hc),
    mem_boxSubmodule_of_subset (Finset.subset_union_right.trans hc)⟩

end Growth

section Coordinates

variable {K : Type*} [Field K] {M : Type*} [Finite M] {u : Kˣ}
  {Λ : LinearMap.BilinForm ℤ (M → ℤ)}

/-- The Ore condition on the coordinate lattice `M → ℤ`, by growth in boxes. -/
theorem exists_mul_eq_mul_pi (r s : quantumTorus K u Λ) (hr : r ≠ 0) (hs : s ≠ 0) :
    ∃ p q : quantumTorus K u Λ, p ≠ 0 ∧ p * r = q * s := by
  classical
  have := Fintype.ofFinite M
  obtain ⟨c, hrc, hsc⟩ := exists_mem_boxSubmodule r s
  exact exists_ne_zero_apply_eq_apply (LinearMap.mulRight K r) (LinearMap.mulRight K s)
    (fun _ _ h ↦ mul_right_cancel₀ hr h) (fun _ _ h ↦ mul_right_cancel₀ hs h) c
    (fun _ ↦ Submodule.map_le_iff_le_comap.2 fun _ hx ↦ mul_mem_boxSubmodule hx hrc)
    (fun _ ↦ Submodule.map_le_iff_le_comap.2 fun _ hx ↦ mul_mem_boxSubmodule hx hsc)

/-- The opposite Ore condition on the coordinate lattice `M → ℤ`, by growth in boxes. -/
theorem exists_mul_eq_mul_pi' (r s : quantumTorus K u Λ) (hr : r ≠ 0) (hs : s ≠ 0) :
    ∃ p q : quantumTorus K u Λ, p ≠ 0 ∧ r * p = s * q := by
  classical
  have := Fintype.ofFinite M
  obtain ⟨c, hrc, hsc⟩ := exists_mem_boxSubmodule r s
  exact exists_ne_zero_apply_eq_apply (LinearMap.mulLeft K r) (LinearMap.mulLeft K s)
    (fun _ _ h ↦ mul_left_cancel₀ hr h) (fun _ _ h ↦ mul_left_cancel₀ hs h) c
    (fun n ↦ Submodule.map_le_iff_le_comap.2 fun _ hx ↦ by
      rw [Submodule.mem_comap, LinearMap.mulLeft_apply, add_comm n c]
      exact mul_mem_boxSubmodule hrc hx)
    (fun n ↦ Submodule.map_le_iff_le_comap.2 fun _ hx ↦ by
      rw [Submodule.mem_comap, LinearMap.mulLeft_apply, add_comm n c]
      exact mul_mem_boxSubmodule hsc hx)

end Coordinates

variable {K : Type*} [Field K] {L : Type*} [AddCommGroup L] [Module.Free ℤ L] [Module.Finite ℤ L]
  {u : Kˣ} {Λ : LinearMap.BilinForm ℤ L}

/-- **The Ore condition for a quantum torus over a field** on a finite free lattice. For `r ≠ 0`
and `s ≠ 0` there are `p ≠ 0` and `q` with `p * r = q * s`. -/
theorem exists_mul_eq_mul (r s : quantumTorus K u Λ) (hr : r ≠ 0) (hs : s ≠ 0) :
    ∃ p q : quantumTorus K u Λ, p ≠ 0 ∧ p * r = q * s := by
  let e := basisTorusEquiv K u Λ (Module.Free.chooseBasis ℤ L)
  obtain ⟨p, q, hp, h⟩ := exists_mul_eq_mul_pi (e r) (e s) ((map_ne_zero_iff e e.injective).2 hr)
    ((map_ne_zero_iff e e.injective).2 hs)
  refine ⟨e.symm p, e.symm q, (map_ne_zero_iff _ e.symm.injective).2 hp, e.injective ?_⟩
  simp only [map_mul, AlgEquiv.apply_symm_apply, h]

/-- **The opposite Ore condition for a quantum torus over a field** on a finite free lattice. For
`r ≠ 0` and `s ≠ 0` there are `p ≠ 0` and `q` with `r * p = s * q`. -/
theorem exists_mul_eq_mul' (r s : quantumTorus K u Λ) (hr : r ≠ 0) (hs : s ≠ 0) :
    ∃ p q : quantumTorus K u Λ, p ≠ 0 ∧ r * p = s * q := by
  let e := basisTorusEquiv K u Λ (Module.Free.chooseBasis ℤ L)
  obtain ⟨p, q, hp, h⟩ := exists_mul_eq_mul_pi' (e r) (e s) ((map_ne_zero_iff e e.injective).2 hr)
    ((map_ne_zero_iff e e.injective).2 hs)
  refine ⟨e.symm p, e.symm q, (map_ne_zero_iff _ e.symm.injective).2 hp, e.injective ?_⟩
  simp only [map_mul, AlgEquiv.apply_symm_apply, h]

/-- The nonzero elements of a quantum torus over a field form a left Ore set. -/
noncomputable instance : OreLocalization.OreSet (nonZeroDivisors (quantumTorus K u Λ)) :=
  (OreLocalization.nonempty_oreSet_iff_of_noZeroDivisors.2 fun r s ↦ by
    by_cases hr : r = 0
    · exact ⟨0, 1, by simp [hr]⟩
    · obtain ⟨p, q, hp, h⟩ := exists_mul_eq_mul r s hr (nonZeroDivisors.coe_ne_zero s)
      exact ⟨q, ⟨p, mem_nonZeroDivisors_of_ne_zero hp⟩, h⟩).some

/-- The nonzero elements of the opposite ring of a quantum torus over a field form a left Ore
set; equivalently, those of `T(K,u,Λ)` form a right Ore set, so right fractions `r s⁻¹` exist. -/
noncomputable instance : OreLocalization.OreSet (nonZeroDivisors (quantumTorus K u Λ)ᵐᵒᵖ) :=
  (OreLocalization.nonempty_oreSet_iff_of_noZeroDivisors.2 fun r s ↦ by
    by_cases hr : r = 0
    · exact ⟨0, 1, by simp [hr]⟩
    · obtain ⟨p, q, hp, h⟩ := exists_mul_eq_mul' r.unop (s : (quantumTorus K u Λ)ᵐᵒᵖ).unop
        ((MulOpposite.unop_ne_zero_iff _).2 hr)
        ((MulOpposite.unop_ne_zero_iff _).2 (nonZeroDivisors.coe_ne_zero s))
      exact ⟨MulOpposite.op q, ⟨MulOpposite.op p,
        mem_nonZeroDivisors_of_ne_zero ((MulOpposite.op_ne_zero_iff _).2 hp)⟩,
        MulOpposite.unop_injective h⟩).some

end Ore

/-! ### The skew field of fractions and the integral chart -/

section Fractions

variable (K : Type*) [Field K] {L : Type*} [AddCommGroup L] [Module.Free ℤ L] [Module.Finite ℤ L]
  (u : Kˣ) (Λ : LinearMap.BilinForm ℤ L)

/-- The skew field of fractions of `T(K,u,Λ)`: its left Ore localization at the nonzero
elements. -/
abbrev FractionDivisionRing : Type _ :=
  OreLocalization (nonZeroDivisors (quantumTorus K u Λ)) (quantumTorus K u Λ)

/-- `T(K,u,Λ)` embeds into its skew field of fractions. -/
theorem numeratorHom_injective :
    Function.Injective
      (OreLocalization.numeratorHom : quantumTorus K u Λ → FractionDivisionRing K u Λ) :=
  OreLocalization.numeratorHom_inj ((le_refl _).trans inf_le_left)

end Fractions

section IntegralChart

variable (R : Type*) [CommRing R] (K : Type*) [Field K] [Algebra R K] {L : Type*}
  [AddCommGroup L] [Module.Free ℤ L] [Module.Finite ℤ L] (u : Rˣ) (Λ : LinearMap.BilinForm ℤ L)

/-- **The faithful integral chart into the skew field of fractions.** For a field `K` over `R`,
the `R`-algebra map `T(R,u,Λ) → Frac T(K,u,Λ)` obtained by changing coefficients to `K` and
taking numerators. It is injective when `K` is a fraction field of `R`
(`TauCeti.QuantumTorus.integralChart_injective`); for `R = Zv` and `K = FractionRing Zv` it is
the integral chart of the quantum torus over `ℤ[v,v⁻¹]`. -/
noncomputable def integralChart :
    quantumTorus R u Λ →ₐ[R]
      FractionDivisionRing K (Units.map (algebraMap R K : R →* K) u) Λ :=
  ({ OreLocalization.numeratorRingHom with commutes' := fun _ ↦ rfl } :
      quantumTorus K (Units.map (algebraMap R K : R →* K) u) Λ →ₐ[R]
        FractionDivisionRing K (Units.map (algebraMap R K : R →* K) u) Λ).comp
    (mapRangeAlgHom rfl)

@[simp]
theorem integralChart_monomial (a : L) :
    integralChart R K u Λ (monomial a) = OreLocalization.numeratorHom (monomial a) :=
  congrArg OreLocalization.numeratorHom (mapRangeAlgHom_monomial rfl a)

theorem integralChart_injective [IsFractionRing R K] :
    Function.Injective (integralChart R K u Λ) :=
  (numeratorHom_injective K _ Λ).comp
    (mapRangeAlgHom_injective rfl (IsFractionRing.injective R K))

end IntegralChart

/-! ### The Ore condition over a domain -/

section Domain

open nonZeroDivisors

variable {R : Type*} [CommRing R] {K : Type*} [Field K] [Algebra R K] {L : Type*}
  [AddCommGroup L] {u : Rˣ} {Λ : LinearMap.BilinForm ℤ L}

variable (K u) in
/-- The image of `u` in `K` is the value of the unit `u` mapped to `Kˣ`. -/
theorem algebraMap_coe_eq_coe_unitsMap :
    algebraMap R K (u : R) = ((Units.map (algebraMap R K : R →* K) u : Kˣ) : K) :=
  rfl

theorem mapRangeAlgHom_smul' (d : R) (y : quantumTorus R u Λ) :
    mapRangeAlgHom (algebraMap_coe_eq_coe_unitsMap K u) (d • y) =
      algebraMap R K d • mapRangeAlgHom (Λ := Λ) (algebraMap_coe_eq_coe_unitsMap K u) y := by
  calc mapRangeAlgHom (algebraMap_coe_eq_coe_unitsMap K u) (d • y) =
        mapRangeAlgHom (algebraMap_coe_eq_coe_unitsMap K u) ((d • monomial 0) * y) := by
          rw [smul_mul_assoc, monomial_zero, one_mul]
    _ = (algebraMap R K d • monomial 0) *
          mapRangeAlgHom (algebraMap_coe_eq_coe_unitsMap K u) y := by
          rw [map_mul, mapRangeAlgHom_smul_monomial]
    _ = algebraMap R K d • mapRangeAlgHom (algebraMap_coe_eq_coe_unitsMap K u) y := by
          rw [smul_mul_assoc, monomial_zero, one_mul]

/-- **Clearing denominators.** For a fraction field `K` of `R`, every element of `T(K,u,Λ)`
times some nonzero `d ∈ R` comes from `T(R,u,Λ)`. -/
theorem exists_mapRangeAlgHom_eq_smul [IsFractionRing R K]
    (x : quantumTorus K (Units.map (algebraMap R K : R →* K) u) Λ) :
    ∃ d ∈ R⁰, ∃ y : quantumTorus R u Λ,
      mapRangeAlgHom (algebraMap_coe_eq_coe_unitsMap K u) y = algebraMap R K d • x := by
  classical
  let P : quantumTorus K (Units.map (algebraMap R K : R →* K) u) Λ → Prop := fun z ↦
    ∃ d ∈ R⁰, ∃ y : quantumTorus R u Λ,
      mapRangeAlgHom (algebraMap_coe_eq_coe_unitsMap K u) y = algebraMap R K d • z
  have hadd : ∀ z₁ z₂, P z₁ → P z₂ → P (z₁ + z₂) := by
    rintro z₁ z₂ ⟨d₁, hd₁, y₁, h₁⟩ ⟨d₂, hd₂, y₂, h₂⟩
    refine ⟨d₁ * d₂, mul_mem hd₁ hd₂, d₂ • y₁ + d₁ • y₂, ?_⟩
    rw [map_add, mapRangeAlgHom_smul', mapRangeAlgHom_smul', h₁, h₂, smul_smul, smul_smul,
      smul_add, map_mul, mul_comm (algebraMap R K d₂)]
  have hterm : ∀ (c : K) (a : L), P (c • monomial a) := by
    intro c a
    obtain ⟨⟨n, d⟩, hnd⟩ := IsLocalization.surj R⁰ c
    refine ⟨d, d.2, n • monomial a, ?_⟩
    rw [mapRangeAlgHom_smul_monomial, ← hnd, smul_smul, mul_comm]
  rw [← sum_coeff_smul_monomial x]
  induction support x using Finset.induction_on with
  | empty => exact ⟨1, one_mem _, 0, by simp⟩
  | insert a t _ ih =>
    rw [Finset.sum_insert ‹_›]
    exact hadd _ _ (hterm _ _) ih

variable [Module.Free ℤ L] [Module.Finite ℤ L]

/-- **The Ore condition for a quantum torus over a domain.** For `s ≠ 0` there are `p ≠ 0` and
`q` with `p * r = q * s`. -/
theorem exists_mul_eq_mul_of_isDomain [IsDomain R] (r s : quantumTorus R u Λ) (hs : s ≠ 0) :
    ∃ p q : quantumTorus R u Λ, p ≠ 0 ∧ p * r = q * s := by
  by_cases hr : r = 0
  · exact ⟨1, 0, one_ne_zero, by simp [hr]⟩
  let K := FractionRing R
  let ι := mapRangeAlgHom (Λ := Λ) (algebraMap_coe_eq_coe_unitsMap K u)
  have hι : Function.Injective ι :=
    mapRangeAlgHom_injective _ (IsFractionRing.injective R K)
  obtain ⟨p₀, q₀, hp₀, h⟩ := exists_mul_eq_mul (ι r) (ι s)
    ((map_ne_zero_iff ι hι).2 hr) ((map_ne_zero_iff ι hι).2 hs)
  obtain ⟨d₁, hd₁, p₁, hp₁⟩ := exists_mapRangeAlgHom_eq_smul p₀
  obtain ⟨d₂, hd₂, q₂, hq₂⟩ := exists_mapRangeAlgHom_eq_smul q₀
  have hd : ∀ d ∈ R⁰, algebraMap R K d ≠ 0 := fun d hd ↦
    (IsLocalization.map_units K (⟨d, hd⟩ : R⁰)).ne_zero
  refine ⟨d₂ • p₁, d₁ • q₂, fun h0 ↦ ?_, hι ?_⟩
  · have := congrArg ι h0
    rw [map_zero, mapRangeAlgHom_smul', hp₁, smul_smul] at this
    exact smul_ne_zero (mul_ne_zero (hd d₂ hd₂) (hd d₁ hd₁)) hp₀ this
  · rw [map_mul, map_mul, mapRangeAlgHom_smul', mapRangeAlgHom_smul', hp₁, hq₂, smul_smul,
      smul_smul, smul_mul_assoc, smul_mul_assoc, h, mul_comm (algebraMap R K d₂)]

/-- Over a domain, the nonzero elements of `T(R,u,Λ)` form a left Ore set. This is not an
instance: over a field it would duplicate the instance above. -/
theorem nonempty_oreSet_of_isDomain [IsDomain R] :
    Nonempty (OreLocalization.OreSet (nonZeroDivisors (quantumTorus R u Λ))) :=
  OreLocalization.nonempty_oreSet_iff_of_noZeroDivisors.2 fun r s ↦ by
    obtain ⟨p, q, hp, h⟩ := exists_mul_eq_mul_of_isDomain r s (nonZeroDivisors.coe_ne_zero s)
    exact ⟨q, ⟨p, mem_nonZeroDivisors_of_ne_zero hp⟩, h⟩

end Domain

end TauCeti.QuantumTorus
