/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import Mathlib.LinearAlgebra.Matrix.Rank

/-! # Column independence and full column rank -/

@[expose] public section
namespace TauCeti.Laurent

/-- For finite matrices over a field, column independence is full column rank. -/
theorem linearIndependent_columns_iff_rank {k M K : Type*} [Field k] [Fintype K]
    (B : Matrix M K k) : LinearIndependent k (fun j ↦ fun i ↦ B i j) ↔
      B.rank = Fintype.card K := by
  rw [linearIndependent_iff_card_eq_finrank_span, Matrix.rank_eq_finrank_span_cols]
  exact eq_comm

end TauCeti.Laurent
