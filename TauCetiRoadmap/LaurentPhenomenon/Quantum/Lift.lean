/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.Quantum.Monomial
public import TauCetiRoadmap.LaurentPhenomenon.Chart

/-!
# The universal property of a quantum torus on quasi-commuting generators

Let `L = M → ℤ` with `M` finite and `Λ` alternating, and write `Λ_ij = Λ(e_i,e_j)`.
Units `U_i` of an `R`-algebra `A` with `U_i U_j = u^{2Λ_ij} U_j U_i` extend to a unique
`R`-algebra map `T(R,u,Λ) → A` with `X_i ↦ U_i`. For a list `l` enumerating `M` once,
it sends `X ^ a` to the normalized ordered product
`u^{-Σ_{i<j} a_i a_j Λ_ij} ∏_{i increasing} U_i^{a_i}`, the order being that of `l`;
this value does not depend on `l`. In a division ring its image is the Laurent chart
ring of the `U_i` over the image of `R`, and it is injective iff the images of the
monomials are `R`-linearly independent.
-/

@[expose] public section

namespace TauCeti.QuantumTorus

open TauCeti

variable {R : Type*} [CommRing R] {A : Type*} [Ring A] [Algebra R A]

/-! ### Commuting powers of quasi-commuting units -/

/-- If `x y = c • y x` for units `x, y` and a scalar unit `c`, then
`x ^ m y ^ n = c^{mn} • y ^ n x ^ m`. -/
theorem units_zpow_mul_zpow {x y : Aˣ} {c : Rˣ}
    (h : (x : A) * y = (c : R) • ((y : A) * x)) (m n : ℤ) :
    ((x ^ m : Aˣ) : A) * ((y ^ n : Aˣ) : A) =
      ((c ^ (m * n) : Rˣ) : R) • (((y ^ n : Aˣ) : A) * ((x ^ m : Aˣ) : A)) := by
  set ζ : Aˣ := Units.map (algebraMap R A : R →* A) c with hζdef
  have hζ : ∀ g : Aˣ, Commute ζ g := fun g ↦
    Units.ext (by simpa [hζdef] using Algebra.commutes (c : R) (g : A))
  have hsmul : ∀ (k : ℤ) (z : Aˣ), ((c ^ k : Rˣ) : R) • (z : A) = ((ζ ^ k * z : Aˣ) : A) := by
    intro k z
    simp [hζdef, Algebra.smul_def, ← map_zpow]
  have h1 : x * y * x⁻¹ = ζ * y := by
    have e := hsmul 1 (y * x)
    rw [zpow_one, zpow_one, Units.val_mul] at e
    have : x * y = ζ * (y * x) := Units.ext (by rw [Units.val_mul, h, e])
    rw [this]; group
  have h2 : x * y ^ n * x⁻¹ = ζ ^ n * y ^ n := by
    rw [← conj_zpow, h1, (hζ y).mul_zpow]
  have h3 : (y ^ n)⁻¹ * x * y ^ n = ζ ^ n * x := by
    calc (y ^ n)⁻¹ * x * y ^ n = (y ^ n)⁻¹ * (x * y ^ n * x⁻¹) * x := by group
      _ = (y ^ n)⁻¹ * (y ^ n * ζ ^ n) * x := by rw [h2, ((hζ _).zpow_left n).eq]
      _ = ζ ^ n * x := by group
  have h4 : (y ^ n)⁻¹ * x ^ m * y ^ n = ζ ^ (m * n) * x ^ m := by
    have := conj_zpow (i := m) (a := (y ^ n)⁻¹) (b := x)
    rw [inv_inv] at this
    rw [← this, h3, ((hζ x).zpow_left n).mul_zpow, ← zpow_mul, mul_comm n m]
  rw [← Units.val_mul, ← Units.val_mul, hsmul]
  congr 1
  calc x ^ m * y ^ n = y ^ n * ((y ^ n)⁻¹ * x ^ m * y ^ n) := by group
    _ = ζ ^ (m * n) * (y ^ n * x ^ m) := by
      rw [h4, ← mul_assoc, ← ((hζ _).zpow_left (m * n)).eq, mul_assoc]

/-! ### Ordered products -/

variable {M : Type*}

/-- The ordered product `∏_{i ∈ l} U_i^{a_i}`, in the order of the list `l`. -/
def orderedProd (U : M → Aˣ) (l : List M) (a : M → ℤ) : Aˣ :=
  (l.map fun i ↦ U i ^ a i).prod

@[simp] theorem orderedProd_nil (U : M → Aˣ) (a : M → ℤ) : orderedProd U [] a = 1 := rfl
@[simp] theorem orderedProd_cons (U : M → Aˣ) (i : M) (l : List M) (a : M → ℤ) :
    orderedProd U (i :: l) a = U i ^ a i * orderedProd U l a := by
  simp [orderedProd]

@[simp] theorem orderedProd_zero (U : M → Aˣ) (l : List M) : orderedProd U l 0 = 1 := by
  induction l <;> simp_all

variable [DecidableEq M]

/-- The units `U_i` quasi-commute according to `u` and `Λ`:
`U_i U_j = u^{2Λ_ij} U_j U_i`. -/
def IsQuasiCommuting (u : Rˣ) (Λ : LinearMap.BilinForm ℤ (M → ℤ)) (U : M → Aˣ) : Prop :=
  ∀ i j, (U i : A) * U j = ((u ^ (2 * Λ (Pi.single i 1) (Pi.single j 1)) : Rˣ) : R) •
    ((U j : A) * U i)

/-- The part `Σ_{j ∈ l} a_j e_j` of an exponent `a` read along the list `l`. -/
def listExponent (l : List M) (a : M → ℤ) : M → ℤ :=
  (l.map fun j ↦ a j • Pi.single j (1 : ℤ)).sum

@[simp] theorem listExponent_nil (a : M → ℤ) : listExponent [] a = 0 := rfl
@[simp] theorem listExponent_cons (i : M) (l : List M) (a : M → ℤ) :
    listExponent (i :: l) a = a i • Pi.single i 1 + listExponent l a := by
  simp [listExponent]

theorem listExponent_add (l : List M) (a b : M → ℤ) :
    listExponent l (a + b) = listExponent l a + listExponent l b := by
  induction l with
  | nil => simp
  | cons i l ih => simp only [listExponent_cons, ih, Pi.add_apply, add_smul]; abel

theorem listExponent_eq_zero {l : List M} {a : M → ℤ} (h : ∀ j ∈ l, a j = 0) :
    listExponent l a = 0 := by
  induction l with
  | nil => rfl
  | cons i l ih =>
    rw [listExponent_cons, h i List.mem_cons_self,
      ih fun j hj ↦ h j (List.mem_cons_of_mem i hj)]
    simp

theorem listExponent_eq {l : List M} (hl : l.Nodup) (hlc : ∀ i, i ∈ l)
    (a : M → ℤ) : listExponent l a = a := by
  let : Fintype M := ⟨l.toFinset, fun i ↦ List.mem_toFinset.mpr (hlc i)⟩
  have hfin : l.toFinset = Finset.univ := Finset.eq_univ_of_forall fun i ↦ by simpa using hlc i
  rw [listExponent, ← List.sum_toFinset _ hl, hfin]
  ext k
  simp [Finset.sum_apply, Pi.single_apply]

/-- The correction exponent `Σ_{i before j in l} a_i a_j Λ_ij`. -/
def orderCorrection (Λ : LinearMap.BilinForm ℤ (M → ℤ)) : List M → (M → ℤ) → ℤ
  | [], _ => 0
  | i :: l, a => Λ (a i • Pi.single i 1) (listExponent l a) + orderCorrection Λ l a

/-- The twist `2 Σ_{j before i in l} a_j b_i Λ_ji` acquired when multiplying two ordered
products. -/
def orderTwist (Λ : LinearMap.BilinForm ℤ (M → ℤ)) : List M → (M → ℤ) → (M → ℤ) → ℤ
  | [], _, _ => 0
  | i :: l, a, b => 2 * Λ (listExponent l a) (b i • Pi.single i 1) + orderTwist Λ l a b

/-- The normalized ordered product `u^{-Σ_{i<j} a_i a_j Λ_ij} ∏_{i ∈ l} U_i^{a_i}`. -/
noncomputable def normalizedProd (u : Rˣ) (Λ : LinearMap.BilinForm ℤ (M → ℤ)) (U : M → Aˣ)
    (l : List M) (a : M → ℤ) : A :=
  ((u ^ (-orderCorrection Λ l a) : Rˣ) : R) • ((orderedProd U l a : Aˣ) : A)

variable {u : Rˣ} {Λ : LinearMap.BilinForm ℤ (M → ℤ)} {U : M → Aˣ}

@[simp] theorem orderCorrection_zero (l : List M) : orderCorrection Λ l 0 = 0 := by
  induction l <;> simp_all [orderCorrection]

theorem orderedProd_single (U : M → Aˣ) {l : List M} (hl : l.Nodup) (i : M) :
    orderedProd U l (Pi.single i 1) = if i ∈ l then U i else 1 := by
  induction l with
  | nil => simp
  | cons j l ih =>
    obtain ⟨hj, hl⟩ := List.nodup_cons.1 hl
    rw [orderedProd_cons, ih hl]
    by_cases hji : j = i
    · subst hji
      simp [hj]
    · simp [Ne.symm hji, hji]

theorem orderCorrection_single {l : List M} (hl : l.Nodup) (i : M) :
    orderCorrection Λ l (Pi.single i 1) = 0 := by
  induction l with
  | nil => rfl
  | cons j l ih =>
    obtain ⟨hj, hl⟩ := List.nodup_cons.1 hl
    rw [orderCorrection, ih hl, add_zero]
    by_cases hji : j = i
    · subst hji
      rw [listExponent_eq_zero fun k hk ↦ by
        simp [show k ≠ j from fun h ↦ hj (h ▸ hk)]]
      simp
    · simp [hji]

/-- The twist of two ordered products, in terms of the corrections. -/
theorem orderTwist_eq (hΛ : LinearMap.IsAlt Λ) (l : List M) (a b : M → ℤ) :
    orderTwist Λ l a b = Λ (listExponent l a) (listExponent l b) + orderCorrection Λ l a +
      orderCorrection Λ l b - orderCorrection Λ l (a + b) := by
  induction l with
  | nil => simp [orderTwist, orderCorrection]
  | cons i l ih =>
    have h1 := hΛ.neg (listExponent l a) (b i • Pi.single i 1)
    have h2 : Λ (a i • Pi.single i 1) (b i • Pi.single i 1) = 0 := by
      simp only [map_zsmul, LinearMap.smul_apply, hΛ.self_eq_zero, smul_zero]
    simp only [orderTwist, orderCorrection, ih, listExponent_cons, listExponent_add,
      Pi.add_apply, add_smul, map_add, LinearMap.add_apply]
    linarith

/-! ### The multiplication of ordered products -/

theorem IsQuasiCommuting.zpow_mul_zpow (hU : IsQuasiCommuting u Λ U) (i j : M) (m n : ℤ) :
    ((U i ^ m : Aˣ) : A) * ((U j ^ n : Aˣ) : A) =
      ((u ^ (2 * Λ (m • Pi.single i 1) (n • Pi.single j 1)) : Rˣ) : R) •
        (((U j ^ n : Aˣ) : A) * ((U i ^ m : Aˣ) : A)) := by
  rw [units_zpow_mul_zpow (hU i j) m n, ← zpow_mul]
  congr 3
  simp only [map_zsmul, LinearMap.smul_apply, smul_eq_mul]
  ring

theorem orderedProd_mul_zpow (hU : IsQuasiCommuting u Λ U) (l : List M) (a : M → ℤ) (i : M)
    (b : ℤ) :
    ((orderedProd U l a : Aˣ) : A) * ((U i ^ b : Aˣ) : A) =
      ((u ^ (2 * Λ (listExponent l a) (b • Pi.single i 1)) : Rˣ) : R) •
        (((U i ^ b : Aˣ) : A) * (orderedProd U l a : A)) := by
  induction l with
  | nil => simp
  | cons j l ih =>
    rw [orderedProd_cons, Units.val_mul, mul_assoc, ih, mul_smul_comm, ← mul_assoc,
      hU.zpow_mul_zpow, smul_mul_assoc, smul_smul, ← Units.val_mul, ← zpow_add, mul_assoc]
    congr 3
    simp only [listExponent_cons, map_add, LinearMap.add_apply]
    ring

theorem orderedProd_mul_orderedProd (hU : IsQuasiCommuting u Λ U) (l : List M)
    (a b : M → ℤ) :
    ((orderedProd U l a : Aˣ) : A) * (orderedProd U l b : A) =
      ((u ^ orderTwist Λ l a b : Rˣ) : R) • ((orderedProd U l (a + b) : Aˣ) : A) := by
  induction l with
  | nil => simp [orderTwist]
  | cons i l ih =>
    simp only [orderedProd_cons, Units.val_mul, Pi.add_apply]
    have e : ((U i ^ a i : Aˣ) : A) * (orderedProd U l a : A) *
        (((U i ^ b i : Aˣ) : A) * (orderedProd U l b : A)) =
        ((U i ^ a i : Aˣ) : A) * (((orderedProd U l a : A) * ((U i ^ b i : Aˣ) : A)) *
          (orderedProd U l b : A)) := by
      simp only [mul_assoc]
    rw [e, orderedProd_mul_zpow hU, smul_mul_assoc, mul_smul_comm, mul_assoc, ih]
    simp only [mul_smul_comm, smul_smul, ← mul_assoc, ← Units.val_mul, ← zpow_add, orderTwist]

/-- **The cocycle identity of normalized ordered products.** -/
theorem normalizedProd_mul (hΛ : LinearMap.IsAlt Λ) (hU : IsQuasiCommuting u Λ U) (l : List M)
    (a b : M → ℤ) :
    normalizedProd u Λ U l a * normalizedProd u Λ U l b =
      ((u ^ Λ (listExponent l a) (listExponent l b) : Rˣ) : R) •
        normalizedProd u Λ U l (a + b) := by
  simp only [normalizedProd, smul_mul_assoc, mul_smul_comm, smul_smul,
    orderedProd_mul_orderedProd hU, ← Units.val_mul, ← zpow_add, orderTwist_eq hΛ]
  congr 3
  ring

/-! ### Algebra maps out of the quantum torus -/

/-- An algebra map is determined on monomials by its values on the generators: for a list `l`
enumerating `M` once, `f (X ^ a)` is the normalized ordered product of the images of the `X_i`. -/
theorem algHom_monomial_eq (hΛ : LinearMap.IsAlt Λ)
    (f : quantumTorus R u Λ →ₐ[R] A) {l : List M} (hl : l.Nodup) (hlc : ∀ i, i ∈ l)
    (a : M → ℤ) :
    f (monomial a) = normalizedProd u Λ
      (fun i ↦ Units.map (f : quantumTorus R u Λ →* A) (monomialUnit hΛ (Pi.single i 1))) l a := by
  set V : M → Aˣ := fun i ↦
    Units.map (f : quantumTorus R u Λ →* A) (monomialUnit hΛ (Pi.single i 1))
  have key : ∀ l : List M, ((orderedProd V l a : Aˣ) : A) =
      ((u ^ orderCorrection Λ l a : Rˣ) : R) • f (monomial (listExponent l a)) := by
    intro l
    induction l with
    | nil => simp [orderCorrection]
    | cons i l ih =>
      have hV : ((V i ^ a i : Aˣ) : A) = f (monomial (a i • Pi.single i 1)) := by
        simp only [V, ← map_zpow, ← monomialUnit_zsmul hΛ, Units.coe_map, MonoidHom.coe_ofClass,
          val_monomialUnit]
      rw [orderedProd_cons, Units.val_mul, hV, ih, mul_smul_comm, ← map_mul,
        monomial_mul_monomial, map_smul, smul_smul, ← Units.val_mul, ← zpow_add,
        listExponent_cons, orderCorrection, add_comm (orderCorrection Λ l a)]
  rw [normalizedProd, key, smul_smul, ← Units.val_mul, ← zpow_add, neg_add_cancel, zpow_zero,
    Units.val_one, one_smul, listExponent_eq hl hlc]

/-- An algebra map out of `T(R,u,Λ)` is determined by its values on the generators `X_i`. -/
theorem algHom_ext_single [Finite M] (hΛ : LinearMap.IsAlt Λ)
    {f g : quantumTorus R u Λ →ₐ[R] A}
    (h : ∀ i, f (monomial (Pi.single i 1)) = g (monomial (Pi.single i 1))) : f = g := by
  let : Fintype M := Fintype.ofFinite M
  refine TwistedMonoidAlgebra.algHom_ext fun x ↦ ?_
  have hl := Finset.nodup_toList (Finset.univ : Finset M)
  have hlc : ∀ i, i ∈ (Finset.univ : Finset M).toList := fun i ↦ by simp
  change f (monomial x.toAdd) = g (monomial x.toAdd)
  rw [algHom_monomial_eq hΛ f hl hlc, algHom_monomial_eq hΛ g hl hlc]
  congr 1
  funext i
  exact Units.ext (h i)

variable [Fintype M]

/-- The algebra map sending `X ^ a` to the normalized ordered product along a list `l`
enumerating `M` once. Use `TauCeti.QuantumTorus.lift`; this auxiliary form records the
order. -/
noncomputable def liftList (hΛ : LinearMap.IsAlt Λ) (U : M → Aˣ) (hU : IsQuasiCommuting u Λ U)
    (l : List M) (hl : l.Nodup) (hlc : ∀ i, i ∈ l) : quantumTorus R u Λ →ₐ[R] A :=
  TwistedMonoidAlgebra.lift (fun g ↦ normalizedProd u Λ U l g.toAdd)
    (by simp [normalizedProd])
    (fun g h ↦ by
      rw [normalizedProd_mul hΛ hU, listExponent_eq hl hlc, listExponent_eq hl hlc]
      rfl)

omit [Fintype M] in
theorem liftList_monomial (hΛ : LinearMap.IsAlt Λ) (hU : IsQuasiCommuting u Λ U) {l : List M}
    (hl : l.Nodup) (hlc : ∀ i, i ∈ l) (a : M → ℤ) :
    liftList hΛ U hU l hl hlc (monomial a) = normalizedProd u Λ U l a :=
  TwistedMonoidAlgebra.lift_of _ _ _ (Multiplicative.ofAdd a)

/-- **The universal property for quasi-commuting units.** Units `U_i` with
`U_i U_j = u^{2Λ_ij} U_j U_i` define an `R`-algebra map `T(R,u,Λ) → A` with `X_i ↦ U_i`;
it is unique by `TauCeti.QuantumTorus.algHom_ext_single`. -/
noncomputable def lift (hΛ : LinearMap.IsAlt Λ) (U : M → Aˣ) (hU : IsQuasiCommuting u Λ U) :
    quantumTorus R u Λ →ₐ[R] A :=
  liftList hΛ U hU (Finset.univ : Finset M).toList (Finset.nodup_toList _) (fun i ↦ by simp)

/-- The value of `lift` on `X ^ a` is the normalized ordered product along the order of
`Finset.univ.toList`. -/
theorem lift_monomial (hΛ : LinearMap.IsAlt Λ) (hU : IsQuasiCommuting u Λ U) (a : M → ℤ) :
    lift hΛ U hU (monomial a) = normalizedProd u Λ U (Finset.univ : Finset M).toList a :=
  liftList_monomial hΛ hU _ _ a

@[simp] theorem lift_monomial_single (hΛ : LinearMap.IsAlt Λ) (hU : IsQuasiCommuting u Λ U)
    (i : M) : lift hΛ U hU (monomial (Pi.single i 1)) = U i := by
  rw [lift_monomial, normalizedProd, orderCorrection_single (Finset.nodup_toList _),
    orderedProd_single _ (Finset.nodup_toList _)]
  simp

theorem lift_monomial_neg_single (hΛ : LinearMap.IsAlt Λ) (hU : IsQuasiCommuting u Λ U)
    (i : M) : lift hΛ U hU (monomial (-Pi.single i 1)) = ((U i)⁻¹ : Aˣ) := by
  have h : Units.map (lift hΛ U hU : quantumTorus R u Λ →* A)
      (monomialUnit hΛ (Pi.single i 1)) = U i :=
    Units.ext (by simp)
  rw [← val_inv_monomialUnit hΛ, ← h]
  rfl

/-- Uniqueness: an algebra map sending each `X_i` to `U_i` is `lift`. -/
theorem eq_lift (hΛ : LinearMap.IsAlt Λ) (hU : IsQuasiCommuting u Λ U)
    (f : quantumTorus R u Λ →ₐ[R] A) (hf : ∀ i, f (monomial (Pi.single i 1)) = U i) :
    f = lift hΛ U hU :=
  algHom_ext_single hΛ fun i ↦ by rw [hf, lift_monomial_single]

/-- **Independence of the order.** Along any list enumerating `M` once, `lift` sends `X ^ a`
to the normalized ordered product. -/
theorem lift_monomial_eq_normalizedProd (hΛ : LinearMap.IsAlt Λ) (hU : IsQuasiCommuting u Λ U)
    {l : List M} (hl : l.Nodup) (hlc : ∀ i, i ∈ l) (a : M → ℤ) :
    lift hΛ U hU (monomial a) = normalizedProd u Λ U l a := by
  rw [← liftList_monomial hΛ hU hl hlc a,
    eq_lift hΛ hU (liftList hΛ U hU l hl hlc) fun i ↦ by
      rw [liftList_monomial, normalizedProd, orderCorrection_single hl, orderedProd_single _ hl]
      simp [hlc i]]

omit [Fintype M] in
/-- The normalized ordered product does not depend on the enumeration of `M`. -/
theorem normalizedProd_eq_of_nodup (hΛ : LinearMap.IsAlt Λ) (hU : IsQuasiCommuting u Λ U)
    {l₁ l₂ : List M} (hl₁ : l₁.Nodup) (hlc₁ : ∀ i, i ∈ l₁) (hl₂ : l₂.Nodup)
    (hlc₂ : ∀ i, i ∈ l₂) (a : M → ℤ) :
    normalizedProd u Λ U l₁ a = normalizedProd u Λ U l₂ a := by
  let : Fintype M := ⟨l₁.toFinset, fun i ↦ List.mem_toFinset.mpr (hlc₁ i)⟩
  rw [← lift_monomial_eq_normalizedProd hΛ hU hl₁ hlc₁,
    ← lift_monomial_eq_normalizedProd hΛ hU hl₂ hlc₂]

/-! ### Faithfulness and image -/

/-- An algebra map out of `T(R,u,Λ)` is injective iff it keeps the monomials linearly
independent. -/
theorem algHom_injective_iff {L : Type*} [AddCommGroup L] {Λ₀ : LinearMap.BilinForm ℤ L}
    (f : quantumTorus R u Λ₀ →ₐ[R] A) :
    Function.Injective f ↔ LinearIndependent R fun a ↦ f (monomial a) := by
  have hb := (monomialBasis : Module.Basis L R (quantumTorus R u Λ₀)).linearIndependent
  constructor
  · intro hf
    have := hb.map' f.toLinearMap (LinearMap.ker_eq_bot.2 hf)
    convert this using 1
    funext a
    simp
  · intro hli
    refine (injective_iff_map_eq_zero f).2 fun x hx ↦ ?_
    have h0 : (monomialBasis : Module.Basis L R (quantumTorus R u Λ₀)).repr x = 0 := by
      refine linearIndependent_iff.1 hli _ ?_
      have := Finsupp.apply_linearCombination R f.toLinearMap
        (monomialBasis : Module.Basis L R (quantumTorus R u Λ₀))
        ((monomialBasis : Module.Basis L R (quantumTorus R u Λ₀)).repr x)
      rw [Module.Basis.linearCombination_repr] at this
      calc _ = Finsupp.linearCombination R
            (f.toLinearMap ∘ (monomialBasis : Module.Basis L R (quantumTorus R u Λ₀)))
            ((monomialBasis : Module.Basis L R (quantumTorus R u Λ₀)).repr x) := by
            congr 2; funext a; simp
        _ = 0 := this.symm.trans hx
    simpa using h0

/-- **Faithfulness criterion.** `lift` is injective iff the images of the monomials are
`R`-linearly independent. -/
theorem lift_injective_iff (hΛ : LinearMap.IsAlt Λ) (hU : IsQuasiCommuting u Λ U) :
    Function.Injective (lift hΛ U hU) ↔
      LinearIndependent R fun a ↦ lift hΛ U hU (monomial a) :=
  algHom_injective_iff _

section DivisionRing

variable {D : Type*} [DivisionRing D] [Algebra R D] {U : M → Dˣ}

omit [DecidableEq M] [Fintype M] in
theorem orderedProd_mem_chartRing (U : M → Dˣ) (l : List M) (a : M → ℤ) :
    ((orderedProd U l a : Dˣ) : D) ∈
      Laurent.chartRing (algebraMap R D).range (fun i ↦ (U i : D)) := by
  induction l with
  | nil => simp
  | cons i l ih =>
    rw [orderedProd_cons, Units.val_mul, Units.val_zpow_eq_zpow_val]
    exact Subring.mul_mem _ (Laurent.coordinate_zpow_mem_chartRing _ _ i (a i)) ih

/-- **The image of `lift`** in a division ring is the Laurent chart ring of the `U_i` over the
image of `R`. -/
theorem range_lift (hΛ : LinearMap.IsAlt Λ) (hU : IsQuasiCommuting u Λ U) :
    (lift hΛ U hU).range.toSubring =
      Laurent.chartRing (algebraMap R D).range (fun i ↦ (U i : D)) := by
  apply le_antisymm
  · rintro _ ⟨x, rfl⟩
    change lift hΛ U hU x ∈ _
    rw [← sum_coeff_smul_monomial x, map_sum]
    refine Subring.sum_mem _ fun a _ ↦ ?_
    rw [map_smul, lift_monomial, normalizedProd, smul_smul, Algebra.smul_def]
    exact Subring.mul_mem _
      (Laurent.coefficient_mem_chartRing _ _ ⟨_, rfl⟩) (orderedProd_mem_chartRing U _ a)
  · refine Laurent.chartRing_le ?_ (fun i ↦ ⟨monomial (Pi.single i 1), by simp⟩)
      (fun i ↦ ⟨monomial (-Pi.single i 1), ?_⟩)
    · rintro _ ⟨r, rfl⟩
      exact ⟨algebraMap R _ r, (lift hΛ U hU).commutes r⟩
    · change lift hΛ U hU _ = _
      rw [lift_monomial_neg_single, Units.val_inv_eq_inv_val]

end DivisionRing

end TauCeti.QuantumTorus
