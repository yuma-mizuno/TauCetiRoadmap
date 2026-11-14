module

import Mathlib
import TauCeti.AlgebraicGeometry.Scheme.Normal

/-!
# Cluster geometry: target signatures

The roadmap is `README.md`; this file is not the roadmap or an exhaustive checklist.
It states the headline theorems expressible against the pinned APIs. Exact-overlap
recognition uses native scheme gluing data; the seed decorations determine the
gluing data to which it applies. Extension of automorphisms across a codimension-two
complement uses native schemes, opens and codimension, together with Tau Ceti's
normal-scheme predicate, Hartogs and affine reconstruction.

The following headline theorems are not statable at the pins:

* Realization and comparison of marked cluster atlases need the mutable-family seed
  pattern, its marked geometric charts, and mutation-compatible atlas morphisms.
  The canonical open immersion of a maximal A locus into the spectrum of its upper
  algebra also needs these carriers and their marked upper-algebra comparison.
* Intrinsic cluster Poisson realization needs the algebraic Poisson bracket,
  its localization and etale transport, the normalized X seed forms, and the
  gerbe-valued X charts with Cartesian transitions. A graded A quotient does
  not supply these interfaces or choose its X Poisson form. The roadmap gives
  their construction from the existing derivation and differential APIs.
  The full ambient structure additionally needs the Cartan action complex,
  its completed signed dg-Lie and Maurer--Cartan simplicial carrier, torsor
  presentation invariance, and standard log-canonical gerbe-model comparisons.
  A transverse bracket alone does not state this headline.
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
* Fixed-object stacks and finite-cyclic equivariant objects need the algebraic-stack
  carrier, its two-fiber products, and coherent action data.
* The main undecorated double Bott--Samelson theorem concerns the entire stack
  of torsors with flag chains, defined independently of seed charts. It needs
  the equivalence with its full torus-quotient presentation, the ambient
  Cartan Poisson datum, and the cluster-gerbe recognition interfaces. The
  full decorated X construction supplies that datum through a finite etale
  comparison and an invariant Poisson quotient. The four-flag full-stack
  class, invisible on its cluster open, and nontrivial torsor families are
  required tests; the five-flag surface supplies a different scalar-bracket test.

These statements remain part of the mathematical specification in `README.md`.
-/

open AlgebraicGeometry CategoryTheory

namespace TauCetiRoadmap.ClusterGeometry

universe u

/-! ## Layer 0: marked scheme atlases and realization -/

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

/-! ## Layer 5: global comparison, reconstruction and fixed objects -/

/-- Every automorphism of an open subscheme of an integral normal affine
Noetherian scheme whose complement has codimension at least two extends uniquely
to the whole affine scheme. The displayed equation says that the extension
restricts to the given automorphism. -/
theorem extendAutomorphism_of_codimension_two
    (Y : Scheme.{u}) [IsIntegral Y]
    [TauCeti.AlgebraicGeometry.IsNormalScheme Y] [IsAffine Y] [IsNoetherian Y]
    (U : Y.Opens) (hcodim : ∀ x : Y, x ∉ U → 2 ≤ Order.coheight x)
    (e : U.toScheme ≅ U.toScheme) :
    ∃! E : Y ≅ Y, U.ι ≫ E.hom = e.hom ≫ U.ι := by
  sorry

end TauCetiRoadmap.ClusterGeometry
