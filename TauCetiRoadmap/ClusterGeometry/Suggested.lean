module

import Mathlib

/-!
# Cluster geometry: target signatures

The roadmap is `README.md`; this file is not the roadmap or an exhaustive checklist.
It states the headline theorems expressible against the pinned APIs. The geometric
recognition theorem uses native scheme gluing data; the seed decorations determine
the gluing data to which it applies.

The following headline theorems are not statable at the pins:

* Realization and comparison of marked cluster atlases need the mutable-family seed
  pattern, its marked geometric charts, and mutation-compatible atlas morphisms.
* Quotient realization, coherent descent, and invariance under changes of stack
  presentation need algebraic-stack quotient charts, their actual overlap
  groupoids, representable open immersions, and compatible two-morphisms. The
  category-valued pseudofunctor carrier on schemes alone does not supply these objects.
* Characterwise recovery of sections needs character-graded quasi-coherent sheaves
  on the quotient charts and compatible identifications on their overlaps. The
  natural-number-graded quasi-coherent algebras on schemes do not express this
  statement.
* Recovery of sections across a frozen boundary needs the marked boundary models
  and the preceding character-graded section carriers. General scheme Hartogs
  results are supplied by the existing dependencies.

These statements remain part of the mathematical specification in `README.md`.
-/

open AlgebraicGeometry CategoryTheory

namespace TauCetiRoadmap.ClusterGeometry

universe u

/-- A morphism from a glued scheme whose restrictions to all charts are open
immersions is an open immersion exactly when every prescribed overlap is the
actual fiber product of the two charts over the target. In particular, chartwise
open immersions alone do not permit additional identifications in the target. -/
theorem isOpenImmersion_iff_exact_overlaps
    (D : Scheme.GlueData.{u}) {X : Scheme.{u}}
    (f : D.glued ⟶ X)
    (hcharts : ∀ i : D.J, IsOpenImmersion (D.ι i ≫ f)) :
    IsOpenImmersion f ↔
      ∀ i j : D.J,
        IsPullback (D.f i j) (D.t i j ≫ D.f j i)
          (D.ι i ≫ f) (D.ι j ≫ f) := by
  sorry

end TauCetiRoadmap.ClusterGeometry
