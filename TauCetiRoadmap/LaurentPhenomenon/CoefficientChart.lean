/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.PositiveRealization
public import TauCetiRoadmap.LaurentPhenomenon.Chart

/-! # Coefficient Chart -/

@[expose] public section

noncomputable section
namespace TauCeti.Laurent
open scoped BigOperators
variable {G I F : Type*} [AddCommGroup G] [DecidableEq I] [Field F]

/-- Coefficients live in the actual image of the coefficient group ring. -/
def coefficientRange (f : TotalLaurentRing G I →+* F) : Subring F := (f.comp (coefficientInclusion
  (G := G) (I := I))).range

/-- The coefficient evaluation induced by f, with codomain restricted to its actual image subring.
-/
def coefficientRangeMap (f : TotalLaurentRing G I →+* F) : AddMonoidAlgebra ℤ G →+* coefficientRange
  f :=
  (f.comp (coefficientInclusion (G := G) (I := I))).rangeRestrict

omit [DecidableEq I] in
private theorem basis_inverse (f : TotalLaurentRing G I →+* F) (t : G × (I →₀ ℤ)) :
    f (AddMonoidAlgebra.single (-t) 1) = (f (AddMonoidAlgebra.single t 1))⁻¹ := by
  apply eq_inv_of_mul_eq_one_left
  rw [← map_mul, AddMonoidAlgebra.single_mul_single]
  simp only [neg_add_cancel, one_mul]
  exact map_one f

omit [DecidableEq I] in
/--
Every lattice basis element evaluates to an ordinary Laurent monomial in the initial variables.
-/
private theorem lattice_basis_mem (f : TotalLaurentRing G I →+* F) (a : I →₀ ℤ) :
    f (AddMonoidAlgebra.single (0, a) 1) ∈
      chartRing (coefficientRange f) (initialVariables f) := by
  classical
  let L := chartRing (coefficientRange f) (initialVariables f)
  induction a using Finsupp.induction_linear with
  | zero =>
    change f 1 ∈ L
    rw [map_one]
    exact L.one_mem
  | add a b ha hb =>
    have hh := L.mul_mem ha hb
    simpa [← map_mul, AddMonoidAlgebra.single_mul_single] using hh
  | single i n =>
    cases n with
    | ofNat n =>
      have hh := L.pow_mem (coordinate_mem_chartRing _ (initialVariables f) i) n
      simpa [L, initialVariables, ← map_pow, AddMonoidAlgebra.single_pow,
        Finsupp.smul_single] using hh
    | negSucc n =>
      have hi : f (AddMonoidAlgebra.single (0, Finsupp.single i (-1)) 1) =
          (initialVariables f i)⁻¹ := by
        simpa [initialVariables] using
          basis_inverse f (0, Finsupp.single i 1)
      have hh := L.pow_mem (inverse_mem_chartRing _ (initialVariables f) i) (n + 1)
      rw [← hi] at hh
      simpa [L, ← map_pow, AddMonoidAlgebra.single_pow, Finsupp.smul_single,
        Int.negSucc_eq] using hh

omit [DecidableEq I] in
/-- The image of every finite Laurent polynomial belongs to the actual source chart. -/
theorem laurent_image_mem_initialChart (f : TotalLaurentRing G I →+* F)
    (r : TotalLaurentRing G I) :
    f r ∈ chartRing (coefficientRange f) (initialVariables f) := by
  classical
  let L := chartRing (coefficientRange f) (initialVariables f)
  have hsingle (t : G × (I →₀ ℤ)) (n : ℤ) : f (AddMonoidAlgebra.single t n) ∈ L := by
    have hc : f (AddMonoidAlgebra.single (t.1, 0) n) ∈ coefficientRange f := by
      refine ⟨AddMonoidAlgebra.single t.1 n, ?_⟩
      simp [coefficientInclusion]
    have hm := L.mul_mem (coefficient_mem_chartRing _ _ hc) (lattice_basis_mem f t.2)
    simpa [← map_mul, AddMonoidAlgebra.single_mul_single] using hm
  rw [← AddMonoidAlgebra.sum_coeff_single r, Finsupp.sum, map_sum]
  exact L.sum_mem (fun t ht => hsingle t (r.coeff t))

omit [DecidableEq I] in
/-- The entire initial chart is exactly the image of the finite Laurent ring.
    This equality holds even for a noninjective realization of coefficients. -/
theorem initialChart_eq_range (f : TotalLaurentRing G I →+* F) :
    chartRing (coefficientRange f) (initialVariables f) = f.range := by
  classical
  apply le_antisymm
  · apply chartRing_le
    · rintro _ ⟨r, rfl⟩
      exact ⟨coefficientInclusion r, rfl⟩
    · intro i
      exact ⟨AddMonoidAlgebra.single (0, Finsupp.single i 1) 1, rfl⟩
    · intro i
      refine ⟨AddMonoidAlgebra.single (0, -Finsupp.single i 1) 1, ?_⟩
      simpa [initialVariables] using basis_inverse f (0, Finsupp.single i 1)
  · rintro _ ⟨r, rfl⟩
    exact laurent_image_mem_initialChart f r

variable [IsDomain (TotalLaurentRing G I)]

/-- The canonical homomorphism from the total Laurent domain to its fraction field. -/
def canonicalMap : TotalLaurentRing G I →+* FractionRing (TotalLaurentRing G I) :=
  algebraMap _ _

omit [DecidableEq I] [IsDomain (TotalLaurentRing G I)] in
theorem canonicalMap_positive (p : AddMonoidAlgebra ℕ (G × (I →₀ ℤ)))
    (hp : positiveCast p ≠ 0) : canonicalMap (G := G) (I := I) (positiveCast p) ≠ 0 :=
  IsFractionRing.to_map_eq_zero_iff.not.mpr hp

end TauCeti.Laurent
