/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.ClusterAlgebras.SeedCompatibility
public import Mathlib.Algebra.BigOperators.Group.Finset.Basic
public import Mathlib.Tactic.LinearCombination

/-! The coefficient identity for the rank-two upper-bound replacement follows
coordinatewise from extended matrix mutation. Coefficients can be units in any
commutative ring; no Laurent theorem or seed realization is used. -/
@[expose] public section

namespace TauCeti.Cluster.UpperBound
open scoped BigOperators
variable {M G : Type*} [Fintype M] [CommGroup G]

/-- The product of the given group elements to the positive parts of the signed exponents. -/
def signedMonomial (v : M → G) (a : M → ℤ) (σ : ℤ) : G :=
  ∏ l, v l ^ positivePart (σ * a l)

theorem signedMonomial_replacement_relation
    (v : M → G) (b c c' : M → ℤ) (t σ : ℤ) (e : ℕ)
    (hσ : σ = 1 ∨ σ = -1) (ht : t = σ * (e : ℤ))
    (hmut : ∀ l, c' l = c l + positivePart (b l) * positivePart t -
      positivePart (-b l) * positivePart (-t)) :
    signedMonomial v c (-σ) * signedMonomial v c' σ =
      signedMonomial v c σ * signedMonomial v c' (-σ) * (signedMonomial v b σ) ^ e := by
  have hbalance (l : M) :
      positivePart (-σ * c l) + positivePart (σ * c' l) =
        positivePart (σ * c l) + positivePart (-σ * c' l) +
          (e : ℤ) * positivePart (σ * b l) := by
    have hi := signed_matrix_increment (b l) t σ e hσ (Int.natCast_nonneg e) ht
    have hm := hmut l
    have hp (z : ℤ) : positivePart z - positivePart (-z) = z := by
      unfold positivePart; omega
    have hc := hp (σ * c l)
    have hc' := hp (σ * c' l)
    have hd : σ * c' l - σ * c l = (e : ℤ) * positivePart (σ * b l) := by
      rw [hm]
      linear_combination hi
    simp only [neg_mul] at *
    omega
  unfold signedMonomial
  rw [← Finset.prod_mul_distrib, ← Finset.prod_pow, ← Finset.prod_mul_distrib,
    ← Finset.prod_mul_distrib]
  apply Finset.prod_congr rfl
  intro l hl
  rw [← zpow_add, ← zpow_add, ← zpow_natCast, ← zpow_mul, ← zpow_add]
  congr 1
  rw [mul_comm (positivePart (σ * b l))]
  exact hbalance l

end TauCeti.Cluster.UpperBound
