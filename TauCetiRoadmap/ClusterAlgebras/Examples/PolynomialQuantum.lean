/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.FiniteExchangeReplacement
public import TauCetiRoadmap.ClusterAlgebras.Examples.QuantumChecks

/-! Both exchanges are genuine trinomials in a faithful generic quantum torus.
No replacement premise or Laurent membership is supplied as an input. -/

@[expose] public section

namespace TauCeti.Examples.PolynomialQuantum

open TauCeti.Laurent TauCeti TauCeti.QuantumTorus TauCeti.Cluster TauCeti.Cluster.QuantumChecks
  Matrix

noncomputable section

/-- The standard alternating form on the two-dimensional exponent lattice. -/
def omega : Matrix (Fin 2) (Fin 2) ℤ := !![0, 1; -1, 0]
theorem omega_alt : IsAlternatingMatrix omega := by
  intro i j
  fin_cases i <;> fin_cases j <;> norm_num [omega]

/-- The generic integral quantum torus's ambient division ring for omega. -/
abbrev D := IntegralField omega
/-- The faithful integral quantum chart for the alternating form omega. -/
abbrev chart := QuantumChecks.integralChart omega

/-- The normalized monomial of exponent (a,b), multiplied by the central scalar v to the kth
power.
-/
def sm (k a b : ℤ) : D :=
  algebraMap Zv D ((vUnit ^ k : Zvˣ) : Zv) * chart (monomial ![a,b])

theorem sm_mul (k a b l c d : ℤ) :
    sm k a b * sm l c d = sm (k + l + a * d - b * c) (a + c) (b + d) := by
  have hf : matrixForm omega ![a,b] ![c,d] = a * d - b * c := by
    simp [matrixForm_eq_sum, omega, Fin.sum_univ_two]
    ring
  have hv : (![a,b] + ![c,d] : Fin 2 → ℤ) = ![a + c,b + d] := by
    ext i
    fin_cases i <;> rfl
  simp only [sm]
  rw [mul_assoc, ← mul_assoc (chart _), ← Algebra.commutes,
    mul_assoc, ← map_mul, monomial_mul_monomial, map_smul, Algebra.smul_def,
    hf, hv, ← mul_assoc, ← mul_assoc, ← map_mul, ← map_mul,
    ← Units.val_mul, ← Units.val_mul, ← zpow_add, ← zpow_add]
  congr 2
  ring

theorem sm_scalar (k : ℤ) : sm k 0 0 = algebraMap Zv D ((vUnit ^ k : Zvˣ) : Zv) := by
  have hz : (![0,0] : Fin 2 → ℤ) = 0 := by ext i; fin_cases i <;> rfl
  simp only [sm, hz, monomial_zero, map_one, mul_one]

@[simp] theorem sm_zero : sm 0 0 0 = 1 := by rw [sm_scalar]; simp
theorem sm_inv (k a b : ℤ) : (sm k a b)⁻¹ = sm (-k) (-a) (-b) := by
  apply inv_eq_of_mul_eq_one_right
  rw [sm_mul]
  convert sm_zero using 1; ring

theorem sm_ne_zero (k a b : ℤ) : sm k a b ≠ 0 := by
  intro h
  have he : sm k a b * sm (-k) (-a) (-b) = 1 := by
    rw [sm_mul]
    convert sm_zero using 1; ring
  rw [h, zero_mul] at he
  exact zero_ne_one he

/-- The embedded central coefficient ring, the image of Zv in D. -/
def C : Subring D := (algebraMap Zv D).range
theorem sm_coeff (k : ℤ) : sm k 0 0 ∈ C := by
  rw [sm_scalar]
  exact ⟨_, rfl⟩

theorem normalizes_C (k a b : ℤ) : Normalizes C (sm k a b) := by
  refine ⟨sm_ne_zero _ _ _, ?_, ?_⟩
  · rintro c ⟨r, rfl⟩
    rw [← Algebra.commutes, mul_assoc, mul_inv_cancel₀ (sm_ne_zero k a b), mul_one]
    exact ⟨r, rfl⟩
  · rintro c ⟨r, rfl⟩
    rw [← Algebra.commutes, mul_assoc, inv_mul_cancel₀ (sm_ne_zero k a b), mul_one]
    exact ⟨r, rfl⟩

/-- The first initial quantum coordinate, with exponent (1,0). -/
def x : D := sm 0 1 0
/-- The second initial quantum coordinate, with exponent (0,1). -/
def y : D := sm 0 0 1
/-- The first trinomial exchange partner, with exponent terms (-1,0), (-1,1), and (-1,2). -/
def xs : D := sm 0 (-1) 0 + sm 0 (-1) 1 + sm 0 (-1) 2
/-- The second trinomial exchange partner, with exponent terms (0,-1), (1,-1), and (2,-1). -/
def ys : D := sm 0 0 (-1) + sm 0 1 (-1) + sm 0 2 (-1)
/-- The second exchange after replacing x by xs, with its required central v factors. -/
def yss : D := (sm (-2) 0 0 * xs ^ 2 + sm (-1) 0 0 * xs + 1) * y⁻¹
theorem xy_ne_yx : x * y ≠ y * x := by
  intro h
  have hm : sm 1 1 1 = sm (-1) 1 1 := by
    simpa only [x, y, sm_mul, Int.reduceAdd, Int.reduceMul, Int.reduceSub] using h
  have hs : ((vUnit ^ (1 : ℤ) : Zvˣ) : Zv) •
      (monomial ![1,1] : quantumTorus Zv vUnit (matrixForm omega)) =
      ((vUnit ^ (-1 : ℤ) : Zvˣ) : Zv) • monomial ![1,1] := by
    apply QuantumTorus.integralChart_injective Zv (FractionRing Zv) vUnit (matrixForm omega)
    change chart (_ • monomial ![1,1]) = chart (_ • monomial ![1,1])
    rw [map_smul, map_smul]
    simpa only [sm, Algebra.smul_def] using hm
  have hc := congrArg (coeff ![1,1]) hs
  simp only [map_smul, coeff_monomial_self, smul_eq_mul, mul_one] at hc
  rw [vUnit_zpow_val, vUnit_zpow_val] at hc
  have ht := congrArg (fun p : Zv ↦ p.coeff 1) hc
  norm_num at ht

theorem y_pow (n : ℕ) : y ^ n = sm 0 0 n := by
  induction n with
  | zero => simp
  | succ n ih => rw [pow_succ, ih, y, sm_mul]; norm_num

theorem sm_y_mem (k : ℤ) (n : ℕ) : sm k 0 n ∈ skewPolyRing C y := by
  have he : sm k 0 n = sm k 0 0 * y ^ n := by rw [y_pow, sm_mul]; norm_num
  rw [he]
  exact (skewPolyRing C y).mul_mem (le_skewPolyRing _ _ (sm_coeff _))
    ((skewPolyRing C y).pow_mem (generator_mem_skewPolyRing _ _) _)

/-- The polynomial quotient of the first exchange defect xs*x-1 by left multiplication by y. -/
def remainder1 : D := sm (-1) 0 0 + sm (-2) 0 1
/-- The polynomial quotient of the degree-two defect xs squared times x squared minus one by y. -/
def remainder2 : D := sm (-1) 0 0 + sm (-3) 0 0 + sm (-2) 0 1 +
  sm (-4) 0 1 + sm (-6) 0 1 + sm (-5) 0 2 + sm (-7) 0 2 + sm (-8) 0 3

theorem remainder1_mem : remainder1 ∈ skewPolyRing C y :=
  (skewPolyRing C y).add_mem (sm_y_mem _ 0) (sm_y_mem _ 1)

theorem remainder2_mem : remainder2 ∈ skewPolyRing C y := by
  unfold remainder2
  exact (skewPolyRing C y).add_mem
    ((skewPolyRing C y).add_mem
      ((skewPolyRing C y).add_mem
        ((skewPolyRing C y).add_mem
          ((skewPolyRing C y).add_mem
            ((skewPolyRing C y).add_mem
              ((skewPolyRing C y).add_mem (sm_y_mem _ 0) (sm_y_mem _ 0))
              (sm_y_mem _ 1)) (sm_y_mem _ 1)) (sm_y_mem _ 1))
          (sm_y_mem _ 2)) (sm_y_mem _ 2)) (sm_y_mem _ 3)

theorem defect1 : xs * x - 1 = y * remainder1 := by
  simp only [xs, x, y, remainder1, add_mul, mul_add, sm_mul]
  norm_num
  rw [← sm_zero]
  abel

theorem defect2 : xs ^ 2 * x ^ 2 - 1 = y * remainder2 := by
  simp only [xs, x, y, remainder2, pow_two, add_mul, mul_add, sm_mul]
  norm_num
  rw [← sm_zero]
  abel

theorem replacement : yss ∈ Subring.closure ((C : Set D) ∪ {xs, ys, y}) := by
  let r : Fin 2 → ℕ := ![1,2]
  let c : Fin 2 → D := ![sm 1 0 0, sm 2 0 0]
  let d : Fin 2 → D := ![sm (-1) 0 0, 1]
  have h : FiniteReplacementPremise C x xs y ys yss (sm (-2) 0 0) 1
      (sm (-2) 0 0) Finset.univ 2 r c d (fun _ ↦ 1) := by
    refine ⟨normalizes_C 0 1 0, normalizes_C 0 0 1, ?_, sm_coeff _, ?_, by simp,
      ?_, ?_, ?_, ?_⟩
    · intro i _; fin_cases i <;> norm_num [r]
    · intro i _; fin_cases i <;> exact sm_coeff _
    · intro i _
      fin_cases i
      · refine ⟨remainder1, remainder1_mem, ?_⟩
        change y * remainder1 = xs ^ 1 * x ^ 1 - 1
        simpa using defect1.symm
      · exact ⟨remainder2, remainder2_mem, defect2.symm⟩
    · simp only [ys, x, y, Fin.sum_univ_two, r, c, Matrix.cons_val_zero,
        Matrix.cons_val_one, pow_one, pow_two, add_mul, sm_mul]
      norm_num
      rw [← sm_zero]
      abel
    · rw [yss]
      have hy : y ≠ 0 := sm_ne_zero 0 0 1
      simp only [mul_assoc, inv_mul_cancel₀ hy, mul_one,
        Fin.sum_univ_two, r, d, Matrix.cons_val_zero, Matrix.cons_val_one]
      norm_num
      simp only [xs, pow_two, add_mul, mul_add, sm_mul]
      norm_num
      abel
    · intro i _
      fin_cases i <;> norm_num [r, c, d, x, pow_two, sm_mul, sm_inv]
  exact h.zss_mem


end
end TauCeti.Examples.PolynomialQuantum
