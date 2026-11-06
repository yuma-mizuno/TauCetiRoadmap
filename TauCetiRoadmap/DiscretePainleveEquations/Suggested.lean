import Mathlib
import TauCeti.AlgebraicGeometry.VectorBundle.FixedRank
import TauCeti.AlgebraicGeometry.ProjectiveSpectrum.ProjectiveLine
import TauCeti.AlgebraicGeometry.ProjectiveSpectrum.TwistingSheaf.Basic

/-!
# Discrete Painlevé equations: target signatures

**This file is not the roadmap and is not exhaustive.** README.md is the definitive
specification. This file states a headline theorem against the pinned native APIs;
proving it does not discharge the remaining constructions and comparisons.

Target 1.4, the Birkhoff–Grothendieck splitting and uniqueness theorem, is statable
using native projective lines, fixed-rank locally free sheaves and twisting sheaves.

The other headline theorems require geometric carriers constructed in the README:

* 2.4 needs marked generalized Halphen families and their geometric Picard markings.
* 4.4 needs the noncommutative operator-surface category and its stable sheaf moduli.
* 6.3 and 7.2–7.4 need regular-lattice/presentation moduli, their stability and the
  independently constructed marked phase families for the Jimbo–Sakai and elliptic
  comparison isomorphisms.
* 6.4 needs the analytic difference-object and connection-data quotient carriers for
  its Riemann–Hilbert biholomorphism.
* 8.3 needs universal operator objects and their relative determinant lines for the
  tau-section comparison.
* 9.2–9.4 need the actual degenerating operator and phase families for degeneration
  and convergence of their transports.

These statements are specified there on those objects; generic matrix identities
or estimates on arbitrary functions would not state the same headline theorems.
-/

namespace TauCetiRoadmap.DiscretePainleveEquations

open CategoryTheory CategoryTheory.Limits AlgebraicGeometry
open TauCeti.AlgebraicGeometry

universe u

/-! ## Layer 1: Difference connections and modifications -/

/-- Every vector bundle of rank `r` on the split projective line over any field
has a unique weakly decreasing tuple of degrees whose twisting sheaves sum to it.
This is Birkhoff–Grothendieck, including uniqueness of the splitting type;
Hazewinkel–Martin, Theorem 4.1. -/
theorem existsUnique_splitting_projectiveLine (k : Type u) [Field k] (r : ℕ)
    (E : FiniteLocallyFreeSheaf.FixedRank (projectiveLine k) r) :
    ∃! d : Fin r → ℤ,
      Antitone d ∧ Nonempty (E.obj.obj ≅ ∐ fun i : Fin r =>
        Proj.twistingSheaf (TauCeti.SymmetricAlgebra.homogeneousSubmodule k (Fin 2 → k)) (d i)) := by
  sorry

end TauCetiRoadmap.DiscretePainleveEquations
