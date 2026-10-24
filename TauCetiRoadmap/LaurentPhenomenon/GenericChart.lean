/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.LaurentFactorial
public import TauCetiRoadmap.LaurentPhenomenon.LaurentSplit
public import TauCetiRoadmap.LaurentPhenomenon.GroupRing
public import TauCetiRoadmap.LaurentPhenomenon.LaurentModel
public import TauCetiRoadmap.LaurentPhenomenon.PositiveLift
public import TauCetiRoadmap.LaurentPhenomenon.PositiveSubstitution
public import TauCetiRoadmap.LaurentPhenomenon.PositiveSpecialization
public import TauCetiRoadmap.LaurentPhenomenon.SpecializationDescent
public import Mathlib.Data.Fintype.Option
public import Mathlib.Algebra.MonoidAlgebra.Basic

/-! # Generic Chart -/

@[expose] public section

namespace TauCeti.Laurent
noncomputable section
open scoped LaurentPolynomial

/-- Finite input locations have only finitely many coefficient occurrences. -/
instance familyAtom_finite {G M L : Type*} [Finite L]
    (p : L → AddMonoidAlgebra ℕ (G × M)) : Finite (FamilyAtom p) := by
  let : Fintype L := Fintype.ofFinite L
  infer_instance

/-- The exact coefficient ring S in C2 is factorial for a finite generic deformation. -/
theorem genericCoefficientRing_uniqueFactorizationMonoid
    (A I : Type*) [Finite A] [Finite I] (k : I) :
    UniqueFactorizationMonoid
      (AddMonoidAlgebra ℤ (FreeAbelianGroup A × ({i // i ≠ k} →₀ ℤ))) :=
  freeGroupLatticeRing_uniqueFactorizationMonoid ℤ A {i // i ≠ k}

/-- The same exact coefficient ring is a domain, independently of factoriality. -/
theorem genericCoefficientRing_isDomain (A I : Type*) (k : I) :
    IsDomain (AddMonoidAlgebra ℤ (FreeAbelianGroup A × ({i // i ≠ k} →₀ ℤ))) := by
  let : IsDomain (AddMonoidAlgebra ℤ (A ⊕ {i // i ≠ k} →₀ ℤ)) := groupRing_isDomain _
  exact (AddMonoidAlgebra.mapDomainRingEquiv ℤ (freeGroupLatticeEquiv A {i // i ≠
    k})).toMulEquiv.isDomain _

/-- Domain property of the generic total Laurent ring in arbitrary rank. -/
theorem freeGroupTotal_isDomain (A I : Type*) :
    IsDomain (AddMonoidAlgebra ℤ (FreeAbelianGroup A × (I →₀ ℤ))) := by
  let : IsDomain (AddMonoidAlgebra ℤ (A ⊕ I →₀ ℤ)) := groupRing_isDomain _
  exact (AddMonoidAlgebra.mapDomainRingEquiv ℤ (freeGroupLatticeEquiv A I)).toMulEquiv.isDomain _

/--
Vanishing mutable exponent gives an actual coefficient in the ring with that variable removed.
-/
theorem laurentSplit_avoiding {R G I : Type*} [CommRing R] [AddCommGroup G]
    [DecidableEq I] (k : I) (q : AddMonoidAlgebra R (G × (I →₀ ℤ)))
    (hq : ∀ t ∈ q.coeff.support, t.2 k = 0) :
    ∃ b : AddMonoidAlgebra R (G × ({i // i ≠ k} →₀ ℤ)),
      laurentSplit k q = LaurentPolynomial.C b := by
  classical
  refine ⟨q.coeff.sum (fun t r ↦
    AddMonoidAlgebra.single (t.1, (splitExponents k t.2).2) r), ?_⟩
  conv_lhs => rw [← AddMonoidAlgebra.sum_coeff_single q]
  simp only [Finsupp.sum, map_sum]
  apply Finset.sum_congr rfl
  intro t ht
  exact laurentSplit_constant k t.1 t.2 _ (hq t ht)

/-- The actual integer lift of a positive exchange independent of Xi belongs to S. -/
theorem positiveIndependent_split {G I : Type*} [AddCommGroup G] [DecidableEq I]
    (q : PositiveLaurent G I) (i : I) (hi : PositiveIndependent q i) :
    ∃ e : AddMonoidAlgebra ℤ (G × ({j // j ≠ i} →₀ ℤ)),
      laurentSplit i (positiveCast q) = LaurentPolynomial.C e := by
  classical
  apply laurentSplit_avoiding
  intro t ht
  have ht' : t ∈ q.coeff.support := by simpa [positiveCast] using ht
  apply hi t.2
  simp only [mutableSupport, Finset.mem_image]
  exact ⟨t, ht', rfl⟩

theorem relPrime_map_ringEquiv {R S : Type*} [CommRing R] [CommRing S]
    (e : R ≃+* S) {a b : R} (h : IsRelPrime a b) : IsRelPrime (e a) (e b) := by
  intro p hpa hpb
  have hpa' : e.symm p ∣ a := by simpa using map_dvd e.symm hpa
  have hpb' : e.symm p ∣ b := by simpa using map_dvd e.symm hpb
  simpa using (h hpa' hpb').map e

/-- Relative primality reflected from a full Laurent ring to its constant coefficient ring. -/
theorem relPrime_constants_reflect {R : Type*} [CommRing R] {a b : R}
    (h : IsRelPrime (LaurentPolynomial.C a) (LaurentPolynomial.C b)) : IsRelPrime a b := by
  intro p hpa hpb
  have hp := h (map_dvd LaurentPolynomial.C hpa) (map_dvd LaurentPolynomial.C hpb)
  have hh := hp.map (LaurentPolynomial.eval₂ (RingHom.id R) (1 : Rˣ))
  simpa [← Polynomial.toLaurent_C] using hh

/-- C5 coprimality in the full Laurent ring reflects into the exact C2 coefficient ring. -/
theorem relPrime_split_constants {R G I : Type*} [CommRing R] [AddCommGroup G]
    [DecidableEq I] (k : I) {a b : AddMonoidAlgebra R (G × (I →₀ ℤ))}
    {a₀ b₀ : AddMonoidAlgebra R (G × ({i // i ≠ k} →₀ ℤ))}
    (ha : laurentSplit k a = LaurentPolynomial.C a₀)
    (hb : laurentSplit k b = LaurentPolynomial.C b₀) (h : IsRelPrime a b) :
    IsRelPrime a₀ b₀ := by
  apply relPrime_constants_reflect
  rw [← ha, ← hb]
  exact relPrime_map_ringEquiv (laurentSplit k) h

/-- The canonical algebraic Laurent ring is exactly the initial concrete chart. -/
def groupChartEquiv {G I F : Type*} [AddCommGroup G] [Field F]
    (f : TotalLaurentRing G I →+* F) (hf : Function.Injective f) :
    TotalLaurentRing G I ≃+* chartRing (coefficientRange f) (initialVariables f) :=
  (RingEquiv.ofBijective f.rangeRestrict
    ⟨fun _ _ h ↦ hf (congrArg Subtype.val h), by
      rintro ⟨a, ha⟩
      obtain ⟨r, hr⟩ := ha
      exact ⟨r, Subtype.ext hr⟩⟩).trans
    (RingEquiv.subringCongr (initialChart_eq_range f).symm)

@[simp] theorem groupChartEquiv_val {G I F : Type*} [AddCommGroup G] [Field F]
    (f : TotalLaurentRing G I →+* F) (hf : Function.Injective f) (r : TotalLaurentRing G I) :
    (groupChartEquiv f hf r : F) = f r := by
  classical
  exact rfl

/-- The exact univariate Laurent chart equivalence required by PolynomialLocalModel. -/
def groupChartLaurentEquiv {G I F : Type*} [AddCommGroup G] [DecidableEq I] [Field F]
    (f : TotalLaurentRing G I →+* F) (hf : Function.Injective f) (i : I) :
    chartRing (coefficientRange f) (initialVariables f) ≃+*
      (AddMonoidAlgebra ℤ (G × ({j // j ≠ i} →₀ ℤ)))[T;T⁻¹] :=
  (groupChartEquiv f hf).symm.trans (laurentSplit i)

@[simp] theorem groupChartLaurentEquiv_image {G I F : Type*} [AddCommGroup G]
    [DecidableEq I] [Field F] (f : TotalLaurentRing G I →+* F)
    (hf : Function.Injective f) (i : I) (r : TotalLaurentRing G I) :
    groupChartLaurentEquiv f hf i (groupChartEquiv f hf r) = laurentSplit i r := by
  simp [groupChartLaurentEquiv]

theorem genericInitialChart_uniqueFactorizationMonoid
    {A I F : Type*} [Finite A] [Finite I] [Field F]
    (f : TotalLaurentRing (FreeAbelianGroup A) I →+* F) (hf : Function.Injective f) :
    UniqueFactorizationMonoid
      (chartRing (coefficientRange f) (initialVariables f)) := by
  classical
  let := freeGroupLatticeRing_uniqueFactorizationMonoid ℤ A I
  exact (groupChartEquiv f hf).toMulEquiv.uniqueFactorizationMonoid inferInstance

end
end TauCeti.Laurent
