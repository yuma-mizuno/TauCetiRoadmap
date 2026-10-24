/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import Mathlib.Algebra.Order.Field.Rat
public import Mathlib.Tactic

/-! # Somos4Sequence -/

@[expose] public section

namespace TauCeti.Examples.Somos4

/-- The sliding window form of the Somos-4 recurrence. -/
def step (w : Fin 4 → ℚ) : Fin 4 → ℚ :=
  ![w 1, w 2, w 3, (w 1 * w 3 + (w 2) ^ 2) / w 0]

/-- The rational windows starting with four ones. -/
def window : ℕ → Fin 4 → ℚ
  | 0 => fun _ => 1
  | n + 1 => step (window n)

/-- The rational Somos-4 sequence, indexed starting with four ones at index zero. -/
def sequence (n : ℕ) : ℚ := window n 0
@[simp] theorem window_zero (i : Fin 4) : window 0 i = 1 := rfl
@[simp] theorem window_succ (n : ℕ) : window (n + 1) = step (window n) := rfl
theorem window_pos (n : ℕ) (i : Fin 4) : 0 < window n i := by
  induction n generalizing i with
  | zero => norm_num
  | succ n ih =>
    fin_cases i
    · exact ih 1
    · exact ih 2
    · exact ih 3
    · exact div_pos (add_pos (mul_pos (ih 1) (ih 3)) (sq_pos_of_pos (ih 2))) (ih 0)

theorem sequence_pos (n : ℕ) : 0 < sequence n := window_pos n 0
theorem sequence_ne_zero (n : ℕ) : sequence n ≠ 0 := ne_of_gt (sequence_pos n)
/-- Coordinates of a window are four consecutive terms. -/
theorem window_eq_sequence (n : ℕ) (i : Fin 4) :
    window n i = sequence (n + i.val) := by
  fin_cases i <;> rfl

@[simp] theorem sequence_zero : sequence 0 = 1 := rfl
@[simp] theorem sequence_one : sequence 1 = 1 := rfl
@[simp] theorem sequence_two : sequence 2 = 1 := rfl
@[simp] theorem sequence_three : sequence 3 = 1 := rfl
theorem sequence_next (n : ℕ) :
    sequence (n + 4) =
      (sequence (n + 1) * sequence (n + 3) + (sequence (n + 2)) ^ 2) / sequence n := by
  change window (n + 1) 3 = _
  change (window n 1 * window n 3 + (window n 2) ^ 2) / window n 0 = _
  simp only [window_eq_sequence]
  rfl

theorem sequence_recurrence (n : ℕ) :
    sequence (n + 4) * sequence n =
      sequence (n + 1) * sequence (n + 3) + (sequence (n + 2)) ^ 2 := by
  rw [sequence_next, div_mul_cancel₀ _ (sequence_ne_zero n)]


/-- Rational solutions with the same four initial terms are unique. -/
theorem sequence_unique (f : ℕ → ℚ)
    (hinit : ∀ i : Fin 4, f i.val = 1)
    (hrec : ∀ n, f (n + 4) * f n = f (n + 1) * f (n + 3) + (f (n + 2)) ^ 2) :
    f = sequence := by
  funext n
  induction n using Nat.strong_induction_on with
  | h n ih =>
    by_cases hn : n < 4
    · have hi := hinit ⟨n, hn⟩
      interval_cases n <;> simpa using hi
    · let k := n - 4
      have hnk : n = k + 4 := by dsimp [k]; omega
      have hk : k < n := by omega
      have hk1 : k + 1 < n := by omega
      have hk2 : k + 2 < n := by omega
      have hk3 : k + 3 < n := by omega
      have hr := hrec k
      rw [ih k hk, ih (k + 1) hk1, ih (k + 2) hk2, ih (k + 3) hk3] at hr
      rw [hnk, sequence_next]
      exact (eq_div_iff (sequence_ne_zero k)).2 hr


/-- Place the first entry of a sliding window at the indicated cyclic label. -/
def rotated (p : Fin 4) (w : Fin 4 → ℚ) : Fin 4 → ℚ :=
  match p.val with
  | 0 => w
  | 1 => ![w 3, w 0, w 1, w 2]
  | 2 => ![w 2, w 3, w 0, w 1]
  | _ => ![w 1, w 2, w 3, w 0]

@[simp] theorem rotated_head (p : Fin 4) (w : Fin 4 → ℚ) :
    rotated p w p = w 0 := by
  fin_cases p <;> rfl

/-- A window in fixed cyclic labels, with its oldest term at `n % 4`. -/
def labelledWindow (n : ℕ) : Fin 4 → ℚ :=
  rotated ⟨n % 4, Nat.mod_lt n (by decide)⟩ (window n)

theorem labelledWindow_head (n : ℕ) :
    labelledWindow n ⟨n % 4, Nat.mod_lt n (by decide)⟩ = sequence n := by
  exact rotated_head _ _

end TauCeti.Examples.Somos4
