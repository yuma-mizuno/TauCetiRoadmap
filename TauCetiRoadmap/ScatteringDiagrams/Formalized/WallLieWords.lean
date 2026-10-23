import Mathlib.Algebra.Lie.Basic
import Mathlib.Algebra.Module.Submodule.Lattice
import Mathlib.LinearAlgebra.Span.Basic

/-!
# Homogeneous wall Lie words with a possibly noninjective direction map

This file proves the Lie-word vanishing step used in README §3.3 from the
wall-space axioms of §3.1. It does not assume a completion theorem, a BCH
construction, positivity of the grading, or a nonzero geometric direction.
-/

set_option autoImplicit false

namespace TauCetiRoadmap.ScatteringDiagrams.Formalized

section WallSpaces

variable {R Γ Λ g : Type*} [CommRing R] [AddCommGroup Γ] [AddCommGroup Λ]
  [LieRing g] [LieAlgebra R g]

/-- The integer normal of the bracket; `ρ` maps degrees to tangent vectors. -/
def wallBracketNormal (ρ : Γ →+ Λ) (n n' : Γ) (m m' : Λ →+ ℤ) : Λ →+ ℤ :=
  m (ρ n') • m' - m' (ρ n) • m

/-- The exact homogeneous wall-space axioms of README §3.1. -/
structure DirectedWallSpaces (ρ : Γ →+ Λ) (ℒ : Γ → Submodule R g) where
  wall : Γ → (Λ →+ ℤ) → Submodule R g
  wall_le_piece : ∀ n m, wall n m ≤ ℒ n
  zero_normal : ∀ n, wall n 0 = ⊥
  nontangent : ∀ n m, m (ρ n) ≠ 0 → wall n m = ⊥
  rescale : ∀ n m (c : ℤ), c ≠ 0 → wall n (c • m) = wall n m
  bracket_mem : ∀ n n' m m' (x y : g),
    x ∈ wall n m → y ∈ wall n' m' →
      ⁅x, y⁆ ∈ wall (n + n') (wallBracketNormal ρ n n' m m')

namespace DirectedWallSpaces

variable {ρ : Γ →+ Λ} {ℒ : Γ → Submodule R g} (W : DirectedWallSpaces ρ ℒ)

/-- A nonzero wall coefficient forces tangency of its own normal. -/
theorem normal_apply_eq_zero {n : Γ} {m : Λ →+ ℤ} {x : g}
    (hx : x ∈ W.wall n m) (hne : x ≠ 0) : m (ρ n) = 0 := by
  by_contra h
  rw [W.nontangent n m h, Submodule.mem_bot] at hx
  exact hne hx

/-- The last bracket vanishes when its total direction is annihilated by both normals. -/
theorem lie_eq_zero_of_normals_annihilate_total {n n' : Γ} {m m' : Λ →+ ℤ} {x y : g}
    (hx : x ∈ W.wall n m) (hy : y ∈ W.wall n' m')
    (hm : m (ρ (n + n')) = 0) (hm' : m' (ρ (n + n')) = 0) : ⁅x, y⁆ = 0 := by
  by_cases hx0 : x = 0
  · simp [hx0]
  by_cases hy0 : y = 0
  · simp [hy0]
  have hn := W.normal_apply_eq_zero hx hx0
  have hn' := W.normal_apply_eq_zero hy hy0
  have hm_cross : m (ρ n') = 0 := by simpa [map_add, hn] using hm
  have hm'_cross : m' (ρ n) = 0 := by simpa [map_add, hn'] using hm'
  have h := W.bracket_mem n n' m m' x y hx hy
  simpa [wallBracketNormal, hm_cross, hm'_cross, W.zero_normal] using h

/-- Rationally proportional nonzero normals give commuting wall spaces. -/
theorem parallel_lie_eq_zero {n n' : Γ} {m m' : Λ →+ ℤ} {x y : g}
    (hx : x ∈ W.wall n m) (hy : y ∈ W.wall n' m')
    {a b : ℤ} (ha : a ≠ 0) (hb : b ≠ 0) (hab : a • m = b • m') : ⁅x, y⁆ = 0 := by
  have hx' : x ∈ W.wall n (a • m) := by rwa [W.rescale n m a ha]
  have hy' : y ∈ W.wall n' (a • m) := by rwa [hab, W.rescale n' m' b hb]
  by_cases hx0 : x = 0
  · simp [hx0]
  by_cases hy0 : y = 0
  · simp [hy0]
  have hn := W.normal_apply_eq_zero hx' hx0
  have hn' := W.normal_apply_eq_zero hy' hy0
  exact W.lie_eq_zero_of_normals_annihilate_total hx' hy'
    (by simp [map_add, hn, hn']) (by simp [map_add, hn, hn'])

/-- A binary Lie word whose leaf normals annihilate `J`. The number of leaves is
part of the index, so the vanishing theorem cannot accidentally include a single leaf.
For a real joint direction `U` and lattice map `i`, take `J = i ⁻¹'(U)`. -/
inductive IsJointLieWord (J : AddSubgroup Λ) : g → Γ → (Λ →+ ℤ) → ℕ → Prop
  | leaf {x : g} {n : Γ} {m : Λ →+ ℤ}
      (mem : x ∈ W.wall n m) (annihilates : ∀ v ∈ J, m v = 0) :
      IsJointLieWord J x n m 1
  | bracket {x y : g} {n n' : Γ} {m m' : Λ →+ ℤ} {k k' : ℕ}
      (left : IsJointLieWord J x n m k) (right : IsJointLieWord J y n' m' k') :
      IsJointLieWord J ⁅x, y⁆ (n + n') (wallBracketNormal ρ n n' m m') (k + k')

namespace IsJointLieWord

variable {W} {J : AddSubgroup Λ} {x : g} {n : Γ} {m : Λ →+ ℤ} {k : ℕ}

theorem mem_wall (h : W.IsJointLieWord J x n m k) : x ∈ W.wall n m := by
  induction h with
  | leaf hx _ => exact hx
  | bracket _ _ hx hy => exact W.bracket_mem _ _ _ _ _ _ hx hy

theorem annihilates (h : W.IsJointLieWord J x n m k) : ∀ v ∈ J, m v = 0 := by
  induction h with
  | leaf _ hm => exact hm
  | bracket _ _ hm hm' =>
    intro v hv
    simp [wallBracketNormal, hm v hv, hm' v hv]

theorem leaves_pos (h : W.IsJointLieWord J x n m k) : 0 < k := by
  induction h with
  | leaf => omega
  | bracket _ _ hk hk' => omega

/-- Arbitrary-length vanishing, including noninjective `ρ` and zero intermediate
coefficients. This is the algebraic obstruction lemma of README §§3.1 and 3.3. -/
theorem zero_of_total_mem (h : W.IsJointLieWord J x n m k) (hk : 2 ≤ k)
    (hn : ρ n ∈ J) : x = 0 := by
  cases h with
  | leaf => omega
  | bracket hx hy =>
    exact W.lie_eq_zero_of_normals_annihilate_total hx.mem_wall hy.mem_wall
      (hx.annihilates _ hn) (hy.annihilates _ hn)

/-- No nontrivial iterated bracket can create a coefficient-only obstruction. -/
theorem zeroDirectionLieWord (h : W.IsJointLieWord J x n m k) (hk : 2 ≤ k)
    (hn : ρ n = 0) : x = 0 :=
  h.zero_of_total_mem hk (hn ▸ J.zero_mem)

end IsJointLieWord

/-- All homogeneous Lie-word contributions of a specified degree with at least two
leaves. Taking the span allows the finite BCH linear combinations used at a joint. -/
def jointObstructionSpace (J : AddSubgroup Λ) (n : Γ) : Submodule R g :=
  Submodule.span R {x | ∃ m k, 2 ≤ k ∧ W.IsJointLieWord J x n m k}

/-- The entire obstruction space vanishes, not merely a selected bracket. -/
theorem jointObstructionSpace_eq_bot {J : AddSubgroup Λ} {n : Γ} (hn : ρ n ∈ J) :
    W.jointObstructionSpace J n = ⊥ := by
  rw [jointObstructionSpace, Submodule.span_eq_bot]
  rintro x ⟨m, k, hk, hx⟩
  exact hx.zero_of_total_mem hk hn

theorem zeroDirectionObstruction {J : AddSubgroup Λ} {n : Γ} (hn : ρ n = 0) :
    W.jointObstructionSpace J n = ⊥ :=
  W.jointObstructionSpace_eq_bot (hn ▸ J.zero_mem)

end DirectedWallSpaces
end WallSpaces
end TauCetiRoadmap.ScatteringDiagrams.Formalized
