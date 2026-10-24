/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import Mathlib.Algebra.Polynomial.Laurent
public import Mathlib.Tactic

/-!
# Pole order at an exchange variable

The order of a pole of a Laurent monomial at the exchange variable, used for the coefficient
divisibility of two commuting exchange directions (`CommutingExchange`). The one-exchange
itself is the instance `OneExchangeChart` of the embedded skew one-exchange.
-/

@[expose] public section

namespace TauCeti.Laurent.OneExchange

/-- The order of a pole at the exchange variable. -/
def poleOrder (n : ℤ) : ℕ := (-n).toNat
theorem poleOrder_add_le (m n : ℤ) :
    poleOrder (m + n) ≤ poleOrder m + poleOrder n := by
  unfold poleOrder
  omega

end TauCeti.Laurent.OneExchange
