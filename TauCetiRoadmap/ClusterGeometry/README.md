# Roadmap: cluster geometry

**Summary.** Build cluster structures on specified schemes and algebraic stacks, with undecorated double Bott–Samelson stacks as the main geometric test. Define their flag-moduli functor before any seed coordinates, retain all torsors and stabilizers, and construct a cluster Poisson structure on that same full stack. A full structure consists of an ambient Poisson datum and a compatible X atlas with actual open overlaps and coherent descent. Gerbes over log-canonical tori describe its seed charts; the Cartan model for smooth diagonalizable quotients retains Poisson data that can be invisible on the cluster open. Decorated A and full decorated X spaces supply constructions and comparison theorems. Establish recognition, presentation invariance, character sections, boundary models and global comparisons. The four-flag stack tests nonneutral gerbes, families with changing inertia and a nonzero ambient Poisson class whose cluster restriction is zero; the five-flag surface tests a nonzero scalar bracket and a full chart cover.

## Scope and ownership

This roadmap owns the passage from seed geometry to a structure on a given space: recognition of chart images and their intersections; log-canonical Poisson brackets and their geometric descent; intrinsic stacky X charts; structured equivalence; decorated A presentations and their character lines; and comparison of a specified completion with its cluster locus. The definition of an X structure does not require a choice of A coordinates, an extended A lattice or a decoration torsor. Quotient presentations supply X structures only after their invariant characters, X mutations, Poisson form and actual quotient overlaps have been identified. A general equivariant presentation is a further input form, with an open-atlas comparison when the action preserves the individual chart opens.

The primary moduli target is 𝔅_G(i,j)=[Z_(i,j)/G], defined by its families of flag chains and their isomorphisms in §6.1, independently of any cluster structure. Construct Π_G on this full stack and a compatible dense X atlas, and prove the end theorem of §6.4. The equivalences with [V_(i,j)/T_G] and decorated quotients are presentations of this same moduli problem. The application owns the direct positive-word X coordinates, their Poisson mutations, the full chamber-minor A realization, and the global decorated-X-to-undecorated Poisson comparison. [SchubertGeometry](../SchubertGeometry/README.md), S1–S2, owns flag incidence and general word schemes; [ReductiveGroups](../ReductiveGroups/README.md), Layers 7, 7C, 8, 9D and 10, owns the group, root-coordinate, isogeny and representation theory. ClusterAlgebras §6.1 supplies generalized minors and their identities; its §§6.2–6.3 concern double reduced words and do not supply the arbitrary positive-word realization constructed here. The general Poisson and full-chart targets are over characteristic-zero fields for finite-dimensional split groups. The rank-one incidence, inertia and gerbe equations are separately established over every field; their characteristic-zero Poisson comparisons are stated explicitly.

[ClusterAlgebras](../ClusterAlgebras/README.md), §§3.1–3.5, owns lattice seeds, mutable families, torus mutations, mutation-word presentations, the marked coslice atlas, maximal regular-domain gluing, principal coefficients, and changes of seed presentation. Its §§1.4, 2.3 and 2.7 own the geometric coefficient algebras, Laurent phenomenon and finite-chart recovery. Reuse those carriers and formulas. This roadmap owns their Poisson compatibility and geometric realization with specified overlaps; maximal gluing is one construction and is not an axiom for a moduli atlas.

[SchemeAndStackFoundations](../SchemeAndStackFoundations/README.md), §0.6 and §§1.14–1.23, owns reflexive extension, groupoids, torsors, stackification, algebraic stacks, quotient and root stacks, and quasi-coherent descent. Its §3.4 owns Picard groupoids. [EquivariantIntersectionTheory](../EquivariantIntersectionTheory/README.md), §§1.1 and 1.4, owns linearised invertible sheaves and their quotient-stack comparison. General diagonalizable group schemes and comodule weight decompositions are already in Tau Ceti. The character-section targets here concern their compatibility with a marked cluster atlas; they do not reproduce those foundations.

A gerbe-valued X atlas carries a transverse bracket; a full cluster Poisson structure also carries the ambient Poisson datum and the standard Poisson seed-chart comparisons of §1.7. This roadmap constructs the shift-zero Cartan and Maurer–Cartan theory needed for smooth characteristic-zero stacks with diagonalizable quotient covers, including the entire undecorated double Bott–Samelson stack. The all-characteristic atlas, torsor and inertia theory retains its stated generality. [DGAInfinity](../DGAInfinity/README.md), Layers 0–1, supplies signed multilinear and DG conventions; its Hochschild-specific Maurer–Cartan developments in Layers 4 and 8 do not supply the Cartan extension constructed here. General shifted-Poisson theory outside this quotient class, scattering, theta bases, quantum and categorical structures, and coarse-moduli existence are outside this roadmap. No classification of all cluster structures or gerbes is part of the target.

## Conventions

Work over an affine base S = Spec R, where R is a commutative ring. All indexing sets are small in a fixed universe. Split tori are T(L) = Spec R[L], with L a finite free character lattice. D(Λ) denotes the diagonalizable group for a finitely generated abelian group Λ; Λ may have torsion. Group actions are left actions. Algebraic stacks are stacks in groupoids on the fppf site; all fibre products of stacks are 2-fibre products. An open immersion of stacks is representable. Equalities of stack morphisms in descent statements mean specified 2-isomorphisms with the stated coherence.

A seed pattern P uses the lattice data and elementary transformations of ClusterAlgebras §§3.1–3.3, with an explicit flavour A, X or A with principal coefficients. Retain the full lattice, mutable family, weights, skew pairing and any chosen adapted basis. The family may be dependent, repeated or nonspanning. An X pattern is usable on its own. Index a full geometric pattern by mutation words and seed isomorphisms before identifying parallel rational transformations. A relation between these indices is imposed only with a compatible geometric chart comparison and its coherence. The supplier's marked coslice is an alternative presentation when those comparisons transport the actual overlaps. Its definition compares both A and X rational maps; that joint presentation is not additional A-structure on an X moduli object. Rank zero means an empty mutable family, not a zero-dimensional torus. An ensemble map retains the supplier's lattice map as data; the exchange matrix does not determine it.

For X tori write N for the character lattice and ω for the skew pairing. In an adapted presentation ε_ij = ω(e_i,e_j)d_j, so the Poisson coefficient is ε_ij/d_j. Specify a scalar ring in which the values of ω exist, for example a ℚ-algebra or an integral model with its stated denominators inverted. Keeping ε fixed while multiplying ω changes the Poisson structure. The unfrozen X torus has character lattice N_uf; its projection from the full X torus comes from the subalgebra R[N_uf] ⊂ R[N]. It is not defined by setting frozen X coordinates to one.

Over a domain, a common-function-field realization requires the supplier's nonvanishing conditions for exchange factors. Over an arbitrary ring, use the specified localized isomorphisms and their open domains; empty domains are allowed. A family of geometric charts still exists when a special fibre ceases to be an integral cluster pattern. Statements about rational functions, valuations, normality or codimension carry their additional hypotheses explicitly.

Write C for the cluster locus, Y for a specified ambient scheme or stack, and j : C → Y for its realization. The notation C does not assert affineness, separatedness, quasi-compactness or finite type. Dense means schematically dense when used for an open realization: O_Y → j_* O_C is injective as a morphism of sheaves, not merely on global sections. Topological density alone is insufficient over a nonreduced base. For stacks use the lisse-étale sheaves, equivalently the condition on smooth scheme tests. Schematic dominance is preserved by flat locally finitely presented base change without a quasi-compactness assumption; arbitrary flat base change requires an additional hypothesis such as quasi-compactness (Rydh16, Definition 3.3 and the following paragraph, author version p. 5). Boundary codimension is also tested on smooth charts.

The degree convention is a* f = χ_λ ⊗ f for a function of weight λ under D(Λ). The character line L_λ on a quotient is the descent of the trivial line with action (y,v) ↦ (h·y,χ_λ(h)v). Thus its sections correspond to functions with that weight, without reversing λ.

## Exact supplier contracts

### From Mathlib

Use `AlgebraicGeometry.Scheme.GlueData`, its glued scheme, chart maps and open cover from `Mathlib.AlgebraicGeometry.Gluing`. In particular, use `Scheme.GlueData.vPullbackConeIsLimit` for the prescribed overlaps, `Scheme.Cover.glueMorphisms` for compatible chart maps, and the native `IsPullback` and `IsOpenImmersion` predicates. The recognition theorem in §0.2 adds a criterion for a map to a specified target; it does not construct a second gluing carrier. Use monoid algebras, localization, tensor products, finite free lattices and scheme base change with their existing universal properties. For algebraic Poisson transport use `KaehlerDifferential.linearMapEquivDerivation`, `Derivation.liftKaehlerDifferential` and `KaehlerDifferential.tensorKaehlerEquivOfFormallyEtale`; this roadmap constructs the alternating biderivation, Jacobi and sheaf comparisons from those differential APIs.

For the bounded Cartan construction use `CochainComplex`, `HomologicalComplex.monoidalCategory`, `HomologicalComplex.QuasiIso`, mapping cones and homotopy fibres, `SSet`, `CategoryTheory.CosimplicialObject`, `ExteriorAlgebra`, `SymmetricAlgebra` and `MvPolynomial`. Construct the signed Schouten bracket and filtered Maurer–Cartan statements on these native carriers. Mathlib's internally graded ordinary Lie algebra is not a Koszul-signed differential graded Lie algebra.

### From Tau Ceti

Use `TauCeti.DiagonalizableGroup.groupScheme`, `groupSchemeMap` and `schemeFunctor` from `TauCeti.Algebra.AlgebraicGroup.DiagonalizableGroup.Scheme.Basic` for D(Λ) and maps induced by character maps. Use `TauCeti.Comodule.weightSpace`, `weightProj` and `isInternal_weightSpace` from `TauCeti.Algebra.Coalgebra.Comodule.MonoidAlgebra.Basic` for algebraic weight decompositions. No characteristic-zero hypothesis is imposed on this diagonalizable theory.

Use `Derivation.extendOfIsLocalization` and `IsLocalization.eq_of_leibniz` from `TauCeti.RingTheory.Derivation.Localization` for extension and uniqueness of derivations. The Poisson localization proof applies these results twice and proves skewness and Jacobi by uniqueness; it does not introduce a second localization theory.

Use `StructureSheaf.toOpenₗ_bijective_of_two_le_depth` and the finite-module restriction results in `TauCeti.AlgebraicGeometry.Modules.Tilde.Hartogs` for affine depth-two extension. Use `TauCeti.AlgebraicGeometry.IsNormalScheme` from `TauCeti.AlgebraicGeometry.Scheme.Normal` for normal schemes in the automorphism-extension headline. The native natural-number-graded quasi-coherent algebra API is not substituted for arbitrary-character-graded sections on stacks. The stack carrier needed below is the algebraic-stack supplier, not merely a category-valued pseudofunctor on schemes.

Use `TauCeti.IsDGAlgebra`, `DGAlgHom` and `IsDGAlgebra.toCochainComplex` from the `TauCeti.Algebra.Homology.DG.Algebra` modules for DG products and maps. Use `TauCeti.koszulSymmetricCategory` from `TauCeti.Algebra.Homology.Monoidal.Braiding` and the native graded-complex adapters for Koszul signs. Use `TauCeti.adamsCompletion` and `adamsCompletionDifferential` from `TauCeti.Algebra.Homology.DG.Algebra.AdamsCompletion`, proving their comparison to the degreewise weight completion used below. These APIs do not supply the Cartan Schouten bracket, the complete Maurer–Cartan simplicial set or presentation invariance. The arity-nilpotent `TauCeti.AInfinityAlgebra.IsMaurerCartan` is not a substitute for that complete construction.

### From TauCetiRoadmap.DGAInfinity

Consume the standing cohomological conventions and Layers 0–1 for signed multilinear substitution, native cochain tensor comparisons and DG-algebra conventions. Adopt the landed native carriers listed above. Layers 4 and 8 concern the Hochschild specialization of complete Maurer–Cartan theory; §1.6 here constructs the signed filtered dg-Lie extension for Cartan polyvectors, polynomial-simplex forms, Kan and filtered quasi-isomorphism comparisons, and the required descent. No Hochschild realization of the quotient polyvectors is assumed.

### From TauCetiRoadmap.ClusterAlgebras

Consume §3.1 for full lattice data and mutable families, §3.2 for the adapted-basis matrix convention, and §3.3 for standalone X and A character mutations, their specified localized domains, marked charts, maximal gluing, Laurent intersections and regular toric charts. Consume §§3.4–3.5 for principal and seed-presentation comparisons. A comparison of maximal glued schemes alone does not compare two retained overlap systems; transport their opens and geometric maps as well. Consume §§1.2–1.4 for admissible binary realizations, their reachable-seed algebras and frozen inversions; §2.3 for Laurent inclusions; and §2.7 for finite-chart recovery. The X Poisson bracket and proof that these mutations preserve it are owned in §0.4. The full/frozen lattice, form and its scalar normalization remain explicit.

For Layer 6, consume §6.1's normalized generalized minors and rank-two identities, and §§2.1 and 2.7 for full-column-rank upper-bound invariance and finite Laurent-family recovery. The flag-configuration evaluations, positive-word seeds, principal-open chart inverses and codimension estimate are constructed in this roadmap.

### From TauCetiRoadmap.SchubertGeometry and TauCetiRoadmap.ReductiveGroups

Consume SchubertGeometry S1.2 and S1.4 for actual flag quotients, opposite cells and incidence schemes, and S2.1–S2.4 for minimal-parabolic fibre products, all finite word schemes, root-coordinate comparisons and braid/refinement correspondences. The exact-simple-relative-position opens used here are restrictions of those schemes. Construct the required braid isomorphisms on these open configuration spaces; the compact Bott–Samelson word schemes are not identified by the supplier's correspondence.

Consume ReductiveGroups Layers 3 and 7 for quotients, opposite Borels and maximal tori; Layer 7C for ordered root factors and their inverse coordinates; §§8.1–8.2 for full split lattices and pinnings; Layer 9D for pinned rational models and central isogenies; and Layer 10 for highest-weight representations and matrix coefficients. Keep the actual character lattice of the chosen group form. A Dynkin diagram alone does not specify that lattice or the center.

### From TauCetiRoadmap.SchemeAndStackFoundations

Consume §0.1 for direct-image structure algebras and their flat base-change comparison, §0.6 for normal/reflexive extension and coherent Hartogs, and §1.1 for quasi-coherent descent. Effective affine descent is consumed through its stated supplier, ModularCurves Layer 0E. Consume §§1.14–1.16 for action groupoids, stabilizers, torsors and contracted products; §1.18 for stackification, 2-fibre products and descent data; §§1.19–1.20 for representability, algebraicity, inertia and presentations; §1.21 for quotient stacks of flat, locally finitely presented groupoids and root stacks; §1.22 for descent and tensor operations on quasi-coherent sheaves; and §3.4 for the abstract Picard-groupoid construction and the symmetric monoidal groupoid of invertible sheaves on schemes. For an algebraic stack, apply that abstract construction to the tensor-invertible objects of its quasi-coherent category from §1.22, and compare on a scheme presentation; this supplies the stack version used in Layer 3. Open gluing in §1.3 below is the cluster-chart application constructed from these contracts. No general cohomological classification of gerbes is needed.

### From TauCetiRoadmap.EquivariantIntersectionTheory

Consume §1.1 for the groupoid of linearised invertible sheaves for a flat group scheme of finite presentation, retaining equivariant isomorphisms and scalar automorphisms. Consume §1.4 for its equivalence with invertible sheaves on the quotient stack. The characterwise section comparison in §3.2 strengthens this input by specifying the weight convention, the monoidal multiplication and compatibility with all cluster transitions.

## How to read the build

Layer 0 recognizes scheme atlases and constructs algebraic Poisson transport. Layer 1 first builds gerbe-valued X atlases, then the bounded Cartan Poisson carrier and the full structure on a specified ambient stack. Layer 2 treats geometric and Poisson equivalences; Layer 3 treats additional A decorations and their character sections. Layers 4–5 treat boundary models and global comparisons with their precise extension hypotheses. Layer 6 begins with the undecorated moduli problem, proves full-stack presentation equivalences, constructs its X charts, and equips the original full stack with the ambient Poisson datum. The four-flag and five-flag computations test different parts of that same construction.

## Layer 0: scheme atlases and cluster Poisson realization

### 0.1 Actual overlap data for a fixed pattern

For a fixed P, use all its geometrically marked seed tori T_i, with the mutation-word indexing and geometric relation comparisons of the conventions. An actual marked overlap system specifies an open V_ij in T_i and an isomorphism φ_ij : V_ij ≅ V_ji which is the prescribed seed transition on that domain. Require V_ii = T_i, identity on the diagonal, inverse transitions, the domain identity φ_ij(V_ij ∩ V_ik) = V_ji ∩ V_jk, and the cocycle identity on that triple overlap. For every elementary mutation a : i → j, require that its supplied localized domain D_a is contained in V_ij and that the restriction is that mutation. For a specified geometric seed isomorphism require the entire chart. Thus all supplied composite path domains are included by the domain and cocycle laws. Over a domain the transitions agree with the marked rational maps. Over an arbitrary ring require the universal character relations on the whole V_ij: every element of ℤ[L_i ⊕ L_j] vanishing on the universal transition graph over ℚ must vanish on the graph over R. Agreement only on a possibly empty supplied localization is insufficient. Every reachable seed chart is present; a finite subcollection is a cover only when its cover property is proved. Equality on rational functions alone does not identify two geometric chart maps into a nonseparated space.

The maximal system of ClusterAlgebras §3.3 is one such system. A system inherited by base change is also retained with its actual domains, including the pullbacks of the D_a. These are different operations: the definition includes the explicit comparisons just specified to the chosen seed pattern, but does not require every actual system to be maximal. Construct its glued scheme C with its distinguished full charts and their open restrictions. This is an application of native scheme gluing, with the seed markings retained.

- Provide extensionality for systems with the same marked charts, domains and transitions, and transport along a specified isomorphism of seed patterns.
- Identify V_ij with T_i ×_C T_j and identify the image of each chart with an open subscheme of C. Prove that the distinguished charts cover C.
- Restrict charts to open subdomains and transport the transitions by their actual intersections. These restrictions are refinements of the marked atlas, not new full seed tori.

**Checks.**

- For an empty mutable family the maximal cluster locus is the initial torus, including Spec R when its lattice has rank zero. It is not an arbitrary chosen rational open subset.
- For the repeated mutable family e₁ = e₂ = (1,0) in ℤ², the chart lattice still has rank two. Replacing it by the span of the mutable family would change the dimension.
- The rank-one exchange xx′ = 2 over ℤ has overlap D(2) in each torus. Over 𝔽₂ the pulled-back overlap is empty, so the fibre is two disjoint tori. The full-overlap relation xx′ = 0, with x and x′ both units, also forces any proposed overlap to be empty; agreement only on the empty supplied localization would not exclude a spurious identification.
- For xy = 1+z over a field, taking all distinct-chart overlaps empty violates the required inclusion of D(1+z). Merely listing all seeds without realizing their mutations is not an actual marked overlap system.

*Needs:* ClusterAlgebras §§3.1–3.3 and 3.5 for the marked pattern and transitions; Mathlib scheme gluing and open subschemes. The mutable-family generality is supported by GHKK, Remark B.8, arXiv v2, pp. 116–117; the maximal gluing comparison is GHK, Proposition 2.4, p. 149.

### 0.2 Exact-overlap recognition

Let D be scheme gluing data with charts T_i, prescribed overlaps V_ij, glued scheme C, and a map f : C → Y. Suppose every composite T_i → C → Y is an open immersion. Prove that f is an open immersion if and only if each comparison V_ij → T_i ×_Y T_j is an isomorphism. Its image is then the union of the chart images. The Lean headline is `isOpenImmersion_iff_exact_overlaps` in `Suggested.lean`.

The forward implication uses the native pullback description of gluing overlaps and the fact that an open immersion is a monomorphism. For the reverse implication, the exact-overlap hypothesis makes f injective on points: two representatives with the same image lie in the specified overlap and hence represent the same point. A chartwise open immersion is an isomorphism on stalks and an open map; the resulting injective local isomorphism is an open immersion. This route does not assume separatedness of Y.

Apply this theorem to compatible maps j_i : T_i → Y, using the gluing universal property to obtain f. For the maximal regular-overlap system of an integral marked pattern, prove that compatible chartwise open immersions already satisfy the comparison condition. The actual intersection in Y supplies an isomorphism on an open domain, so lies in the maximal regular domain; compatibility gives the reverse containment. This corollary requires compatibility on the whole chosen maximal overlap, not agreement merely on a dense subopen of a nonseparated target.

**Checks.**

- Two copies of 𝔸¹ glued along 𝔾_m map chartwise by the identity to 𝔸¹. Their prescribed overlap omits the origins whereas the target fibre product contains the origin, so the induced map is not an open immersion.
- A scheme with one chart has the diagonal overlap equal to the chart. The criterion reduces to the given open-immersion hypothesis without any separation assumption.
- For Y = Spec k[x,y,z±1]/(xy−1−z), the opens D(x) and D(y) intersect in D(xy), exactly the domain 1+z ≠ 0 of the exchange. The criterion gives an open immersion of the two-chart locus into Y and does not assert surjectivity.

*Needs:* §0.1 for marked applications; Mathlib `Scheme.GlueData`, its pullback-overlap theorem, `IsPullback`, `IsOpenImmersion`, chartwise morphism gluing and the source-open-cover criterion for an open immersion. GHK, Proposition 2.4, supplies the maximal-domain comparison, not the criterion for an arbitrary chosen overlap system.

### 0.3 A cluster structure on a specified scheme

A realized scheme cluster structure consists of P, an actual marked atlas with cluster locus C, and a schematically dense open immersion j : C → Y. The atlas marks the structure on Y; the ambient completion is retained as part of the datum. A presentation by chart maps into Y is equivalent to this datum exactly when its maps cover j(C) and satisfy §0.2. Neither equality with an upper algebra nor a codimension bound on Y ∖ C is an axiom.

- Recover the locus as the union of the distinguished chart images and recover its overlaps by fibre products over Y.
- Restrict the ambient space to an open containing C and transport the realized structure. Keep the resulting completion distinct unless the ambient spaces are isomorphic as realized pairs.
- Compare presentations with the same fixed marked atlas by the unique map induced on C. Scheme-level equality of induced maps follows from their restrictions to the distinguished charts.

**Checks.**

- The initial torus embeds densely both in itself and in a chosen toric partial compactification. These give the same cluster locus and different realized pairs.
- In the exchange surface of §0.2, the point x = y = 0, z = −1 lies outside both charts even though z is already invertible. A definition using only frozen-variable vanishing misses it.
- For R = k[x,ε]/(ε²,xε), the open D(x) is topologically dense in Spec R, but ε is nonzero and restricts to zero. This open immersion is not schematically dense and does not define such a realization. A test on underlying points would miss the defect.

*Needs:* §§0.1–0.2 for chart data and recognition; Mathlib open immersions and schematic density. The separation of the realized pair from its ring is established concretely in §5.1.

### 0.4 Log-canonical X structures and Poisson recognition

An algebraic Poisson structure on a scheme is an R-bilinear alternating bracket on its structure sheaf satisfying Leibniz in each argument and Jacobi. Construct localization and unique étale transport, and glue brackets on open or étale scheme charts. For étale A → B use Ω_(B/R) ≅ B ⊗_A Ω_(A/R) to extend the alternating biderivation; its Jacobiator is a triderivation, so vanishing follows from the generating old differentials. This gives the algebraic-space version by étale descent. No pullback along an arbitrary smooth morphism is asserted.

For an X seed put {zⁿ,zᵐ}_P = ω(n,m)zⁿ⁺ᵐ on R[N]. Prove Jacobi from bilinearity of ω and extend by localization. Prove that the supplier's character mutation is Poisson with the mutated seed form. In adapted coordinates this is {X_i,X_j}_P = (ε_ij/d_j)X_iX_j and X′_k = X_k⁻¹, X′_i = X_i X_k^[ε_ik]₊(1+X_k)^(−ε_ik) for i ≠ k. Verify the bracket on the actual elementary domain D(1+X_k), including the zero-form case where the rational formula may extend farther. For a zero mutable vector use the supplier's identity mutation on the whole torus; it is distinct from a nonzero vector in the radical. The full character proof also covers dependent mutable families.

- A Poisson X atlas is an X realization from §0.3 whose chart comparisons preserve these brackets; they glue to a unique π_C on its locus C. A cluster Poisson structure on a specified ambient scheme Y additionally includes a bracket π_Y on all of Y and requires j to be Poisson. Existence of such an ambient extension is a separate theorem, not a consequence of the atlas definition. An X realization carries no automatically selected A decoration.
- Prove Poisson recognition by the exact-overlap criterion and equality of chart brackets. For a given ambient bracket it suffices to verify the character-generator brackets on each chart; rational agreement alone does not verify the open realization. Transport and equivalences preserve ω itself, not just ε.
- Identify the Poisson central monomials by ω(n,N)=0 in R and compute the rank from the matrix over the base field. In characteristic zero the integral radical gives the central-character torus. In positive characteristic test the scalar pairing: pth powers can become central even when the integral radical is zero. Prove that projection to the unfrozen X torus is Poisson by restriction of the bracket to R[N_uf].

**Checks.**

- For ω(e₁,e₂)=−1 and unit weights, {X,Y}_P=−XY. Mutation at 1 gives (X⁻¹,XY/(1+X)), and the new bracket is the product of those two coordinates. An A exchange formula in place of this X formula fails the specified coordinate comparison.
- For N=ℤe with ω=0, X′=X⁻¹ is globally regular, but a geometric overlap may still be D(1+X). The two copies glued only there retain the two points over −1 and carry a zero Poisson bracket.
- Take ε₁₂=2, ε₂₁=−1 and (d₁,d₂)=(1,2). The coefficient {X₁,X₂}_P/(X₁X₂) is 1, not 2. Rescaling ω while compensating the weights preserves ε and the mutations but is not a Poisson equivalence with the original normalization.
- On a two-dimensional symplectic torus over a field of characteristic p, Xᵖ is Poisson central. The characteristic-zero radical calculation cannot be reused without reducing the pairing in the scalar field.

*Needs:* §§0.1–0.3; ClusterAlgebras §§3.1–3.3 for lattice forms and localized character mutations; the native derivation, localization and Kähler-differential contracts above; SchemeAndStackFoundations §1.1 and §§1.3–1.11 for sheaf and algebraic-space descent. Real smooth-manifold Poisson theories are not suppliers of this algebraic construction.

### Examples

The maximal A and X schemes of ClusterAlgebras §3.3 carry identity realizations, and §0.4 gives the X scheme its Poisson bracket. The A exchange xx′ = 1+z realizes the opens D(x), D(x′) in its surface. The independent rank-one X pattern has a zero bracket and can realize the doubled torus with its proper overlap. The rank-two X flips and the five-flag surface of §6.6 test a nonzero bracket and an ambient extension. Actual chart intersections remain part of recognition in each case.

### Dependencies

ClusterAlgebras §§3.1–3.5 supplies seed geometry. Mathlib and Tau Ceti supply gluing, open immersions, derivations and differential transport. The algebraic Poisson compatibility is constructed here. No stack theory, normality or upper-algebra equality is required by the scheme recognition criterion.

## Layer 1: X charts and Poisson structures on stacks

### 1.1 Stacky X tori and diagonalizable presentations

First define the banded-gerbe datum used here. For an algebraic stack B and a commutative flat group scheme K of finite presentation over B, it consists of an algebraic stack ρ : G → B such that every pullback to a scheme over B is locally nonempty and locally connected in the fppf topology, with pullback-compatible identifications of each object's relative automorphism sheaf with K. These identifications respect conjugation by arrows. Relative automorphisms fix the specified object of B; they need not be the total inertia when B is stacky. This datum is constructed from the supplied stack, torsor and automorphism carriers, and no neutralization is included.

An intrinsic stacky X chart consists of an X seed torus X_s = T(N_s) with its form ω_s and a banded gerbe ρ_s : C_s → X_s under a specified commutative diagonalizable group K_s. The band and gerbe are actual group-scheme and stack data; no section or product decomposition is required. Allow their forms after the descent of §4.4. The trivial band gives an ordinary Poisson X torus. The Poisson datum is on the torus base, together with the gerbe carrying the moduli automorphisms; this is the precise stacky-atlas meaning used here.

A graded torus is a construction of such a chart, not its intrinsic definition. Take a finite free L, a finitely generated abelian Λ and d : L → Λ, and form [T(L)/D(Λ)] by the translation action dual to d. Put M = ker d, I = im d and K = D(coker d). Construct the canonical map [T(L)/D(Λ)] → T(M), prove that it is a K-banded gerbe, and identify it with an X chart only after giving an integral isomorphism N_s ≅ M and the specified Poisson form on that lattice. The presentation keeps d when a decorated presentation is requested; it is not part of the underlying intrinsic X structure. Faithfulness of the action is not imposed.

- Construct the action and its functoriality under commuting squares of lattice and degree maps, using the native diagonalizable group functor.
- Identify the inertia over every object with the pullback of ker(D(Λ) → T(L)) = D(coker d). Prove that this description is compatible with base change and preserves nonreduced stabilizers.
- Factor through D(Λ) → D(I) and prove that T(L) → T(M) is a D(I)-torsor. The first homomorphism is an fppf epimorphism with kernel K, so its quotient is precisely the gerbe of lifting this torsor. This constructs the gerbe and its band without choosing a splitting or using an invariant ring as the moduli definition.
- For a surjective degree map, identify the quotient with T(ker d) by the explicit D(Λ)-torsor T(L) → T(ker d). To prove this, decompose R[L] over R[ker d] by the cosets in Λ, choose one monomial lift in each coset to see faithful freeness, and verify the torsor identity on the two character algebras. Finite generation of Λ and L gives finite presentation. For d = 0 identify the quotient with T(L) × B D(Λ). Record actual quotient morphisms, not only isomorphisms of invariant rings.

**Checks.**

- For d : ℤ → ℤ equal to the identity, [𝔾_m/𝔾_m] is Spec R and has trivial inertia, although the marked character lattice has rank one.
- For d = 0 and Λ = ℤ/rℤ, the chart is T(L) × Bμ_r and its functions are those of T(L). It retains μ_r even when the residue characteristic divides r.
- For the quotient map d : ℤ → ℤ/rℤ, the action on 𝔾_m is free and the quotient coordinate is xʳ. The kernel group is trivial; μ_r is the acting group, not the stabilizer.
- The point presented as Spec R and as [𝔾_m/𝔾_m] has the same intrinsic rank-zero X chart: M=0 and K=1. Adding this free decoration factor does not change its X structure. Retaining an A decoration is an additional choice.
- A prescribed ω on ker d is independent data: the same translation quotient can carry a zero or a nonzero Poisson form when its effective torus has dimension at least two. Degrees alone do not choose it.

*Needs:* §0.4 for Poisson X tori; native Tau Ceti diagonalizable group schemes; SchemeAndStackFoundations §§1.14–1.16 and 1.18–1.21 for stabilizers, torsors, algebraic stacks and quotient stacks. The banded-gerbe datum is specified above. Quotient algebraicity uses Stacks, Tag 06FI; inertia uses Tag 06PB; the local gerbe condition is Tag 06NZ. The fppf torus presentation need not be smooth when D(Λ) is not smooth.

### 1.2 X transitions and homogeneous A constructions

For intrinsic X charts, a transition consists of an actual open W_st ⊂ X_s, a Poisson isomorphism W_st ≅ W_ts agreeing with the seed transition, and a band-compatible equivalence C_s ×_(X_s) W_st ≃ C_t ×_(X_t) W_ts over that map. Thus its square with the base transition is Cartesian. Require the elementary X domain D(1+X_k) to be contained in W_st, and keep the induced band comparison and subsequent 2-coherence. A map on invariant functions or a band homomorphism alone does not supply this equivalence.

For an adapted A presentation, assign degrees a_i in Λ to every coordinate. An exchange at k is homogeneous when Σ_i b_ik a_i = 0. Write M₊ = ∏ x_i^[b_ik]₊ and M₋ = ∏ x_i^[−b_ik]₊, set a′_k = deg(M₊) − a_k and a′_i = a_i for i ≠ k, and prove equivariance of x_k x′_k = M₊+M₋ and preservation of all mutated balance equations. The mutable-family proof uses character pullbacks and coactions. To obtain an intrinsic X transition from this construction, additionally identify ker d_s with N_s integrally, prove the induced invariant-coordinate formula is the supplied X mutation, verify its Poisson form and identify its actual quotient domain with W_st. Homogeneity alone is not that comparison theorem.

- Characterize equivariance by the equality of coactions on the character generators and their localized inverses. For a nonzero coefficient ring, distinguish the two nonzero monomial summands when proving necessity of degree balance.
- Prove that the exchange open is invariant and that the localized mutation descends to an equivalence of the corresponding open quotient substacks. Compose these equivalences with their actual domains.
- Transport gradings through mutation words and seed isomorphisms, keeping the chosen identification of character groups. For X and principal charts require the same coaction compatibility for their supplied character formulas; do not infer it from the A degree equation without a comparison of the relevant lattices.
- Prove independence of the resulting intrinsic X transition from a change of A presentation whenever the two quotient-gerbe maps, X characters, Poisson forms and overlap equivalences are identified. An extra free torus factor in a decorated presentation is covered by this theorem.

**Checks.**

- For xy = 1+z with deg x = 1 and deg z = 0, mutation gives deg y = −1. Both numerator terms have degree zero and the divisor z = −1 is invariant.
- If deg z = 1 in that relation, 1 and z have different weights. The exchange fails the homogeneity condition over every nonzero field, so there is no quotient mutation for that proposed grading.
- For xx′ = 2 over 𝔽₂, the homogeneous exchange domain is empty. Equivariance of the empty-domain isomorphism remains true, but it does not produce a birational mutation on the fibre.
- For the five-flag chart of §6.6, X′=X⁻¹ and Y′=XY/(1+X), with {X,Y}_P=−XY, directly define a Poisson X transition. No A coordinate or degree map is required to specify this chart or its flip.

*Needs:* §§0.4 and 1.1; ClusterAlgebras §§1.1, 3.2–3.4 for matrix mutation, exchange and character formulas; native comodule weights and localization; SchemeAndStackFoundations §1.21 for the quotient comparison. The X Poisson proof is independent of the homogeneous A construction.

### 1.3 Coherent open-stack gluing

A general coherent open-stack gluing datum has algebraic chart stacks C_i, open substacks V_ij in C_i, equivalences φ_ij : V_ij ≃ V_ji, unit and inverse identifications, and 2-isomorphisms η_ijk : φ_jk φ_ij ⇒ φ_ik on the triple overlaps. Impose the same domain identity as in §0.1, the quadruple-overlap coherence equation for η, and the unit and inverse triangle laws, including the associators and unitors of composition. Equivalently use normalized data with φ_ii = id and η_iij and η_ijj the canonical unit comparisons, with the induced compatible inverse comparisons.

A coherent stacky cluster Poisson atlas is such a datum with every reachable X seed present, the gerbe charts of §1.1, and Cartesian lifted X transitions of §1.2. In particular V_ij is the pullback of an actual W_ij in the Poisson torus base. Require the elementary exchange domains, their Poisson character formulas, the band comparisons and all geometric relation comparisons. Glue the W_ij to an effective X locus X_eff and prove that C → X_eff is the gerbe with the descended band and coherence. The nonneutrality of this global gerbe is permitted even if its individual charts are neutral. The effective locus can be nonseparated.

An A atlas or a graded A quotient atlas retains its own seed and decoration data. It is compared to the preceding X atlas by §1.2, not identified with it by terminology. The general open-stack gluing theorem below applies to each specified chart class and preserves its extra data. Seed labels alone do not supply the chart-model identifications or transition equivalences.

- Construct a glued algebraic stack C with representable open chart maps, covering images, and comparisons V_ij ≃ C_i ×_C C_j. Recover the original transition 2-isomorphisms from this realization.
- Prove the bicategorical universal property: morphisms from C to any stack form the groupoid of chart morphisms with compatible transition 2-isomorphisms. Retain automorphisms in this groupoid.
- Prove uniqueness up to an equivalence compatible with all chart maps and coherence data. Changes of a chosen presentation induce coherent equivalences rather than an asserted literal equality of stacks.
- For an X atlas, glue the Poisson torus bases using §0.4 and verify that every stack overlap is the pullback of the stated base overlap. The gerbe and its tensor obstructions remain part of the output; its scalar Poisson functions do not reconstruct it.

For the construction, choose smooth scheme presentations of the C_i, pull the V_ij back to their pairwise presentation spaces, and form the groupoid whose composition is induced by η. The domain law gives a groupoid, and quadruple coherence gives associativity. Stackify its quotient using the supplier; the overlaps are open, so the resulting chart maps are representable open immersions. This construction also proves the stated universal property. It does not require the original quotient-torus presentations themselves to be smooth.

**Checks.**

- If every C_i is a scheme, its transition 2-isomorphisms are unique and the construction agrees with native scheme gluing.
- With one chart T × Bμ_r the glued object has the same μ_r inertia. Replacing the chart groupoid by its orbit set would incorrectly give T.
- Over a field of characteristic different from two, take four identical charts Bμ₂ and identity transitions. Setting η_012 = −1 and all other nondegenerate η to +1 gives quadruple composites −1 and +1, so the data are rejected. With one chart, setting η_iii = −1 while keeping the units trivial violates the unit law even though the quadruple equation alone holds.

*Needs:* §§0.1 and 0.4 for actual domains and Poisson gluing; §§1.1–1.2 for the X gerbes and decorated quotient comparisons; SchemeAndStackFoundations §§1.14, 1.18–1.21 for groupoids, stackification, algebraic presentations and quotients. The algebraicity input is Stacks, Tag 06FI.

### 1.4 Recognition on an algebraic stack

Let the data of §1.3 be given, and let its chart maps to an algebraic stack Y be representable open immersions with coherent compatibility. Prove that C → Y is a representable open immersion exactly when V_ij → C_i ×_Y C_j is an equivalence for every i,j. Its image is the union of the chart images. Apply a smooth atlas of Y for this geometric recognition and descend openness. Define an intrinsic realized stacky X atlas by the X atlas, its Poisson effective locus, its gerbe and the recognized schematically dense open C → Y. A chosen decorated A presentation is additional comparison data. This is a transverse atlas datum; the full ambient Poisson structure is defined in §1.7. No constant-inertia or global-gerbe assertion is made about Y ∖ C.

The comparison with the usual Poisson structure on a Deligne–Mumford locus with finite étale chart bands is constructed subsequently in §1.5. If Y is equipped with such a Poisson structure, compatibility on C is an additional recognition test. For positive-dimensional or non-étale bands retain the precise transverse atlas datum; a bracket on invariant functions is not a definition of a general 0-shifted Poisson structure. The smooth atlas used to test open immersions is not assigned a Poisson bracket by pullback.

- Compute inertia locally from the chart groupoids and identify it with the restriction of the inertia of Y. Mutation-word automorphisms are not added to this inertia.
- Compare the scheme and stack notions: a cover by representable open immersions from schemes makes C a scheme. A smooth or fppf cover by schemes has no such consequence.
- Transport the structure along an equivalence of ambient stacks and preserve the actual 2-fibre-product overlaps and the specified coherence maps.
- Recognize a moduli X structure directly from intrinsic invariant coordinates, their X mutations and their Poisson brackets, with the gerbe and actual overlaps verified on families. A quotient A realization is one proof of these conditions, not a premise of the recognition theorem.

**Checks.**

- Spec k → BG for a nontrivial group scheme G is a torsor atlas, not an open immersion: its self-2-fibre product is G rather than Spec k.
- A geometric point of T × Bμ_r has automorphism group μ_r, including its infinitesimal structure in characteristic dividing r. A torus-coordinate description cannot make this locus a scheme.
- Gluing two copies of 𝔾_m along 𝔾_m ∖ {1} with identity transition gives a scheme with two points over 1. Mapping both charts identically to 𝔾_m violates exact overlaps, even though all rational pullbacks agree.

*Needs:* §§0.2, 0.4 and 1.3; SchemeAndStackFoundations §§1.19–1.20 for representable open immersions, locality and inertia. Use Stacks, Tags 04YL, 0503, 0504 and 04YN for the open-immersion tests and invariant-open quotient comparison. The finite-étale Poisson comparison is the additional construction in §1.5.

### 1.5 Gerbe lifts of marked charts

Use the banded-gerbe datum of §1.1 for π : G → C with relative band K. Pull each chart and overlap of a given atlas on C back along π, retaining the geometric seed markings and coherence maps. This constructs a general marked gerbe atlas on G, without asserting a neutralization G ≃ B_C K.

For this lifted atlas to be an intrinsic stacky X atlas of §1.1, additionally prove that its composite over each X torus is a gerbe with an allowed diagonalizable band and identify that band and the Cartesian transitions. A commutative relative band over an already stacky base does not imply commutative total inertia.

For a Poisson algebraic-space base C and finite étale K, prove that Poisson structures on G, defined on an étale scheme presentation, are equivalent to Poisson structures on C. The gerbe is étale over C and has an étale scheme atlas U; hence U → C is étale. Pull the bracket to U by §0.4. On U ×_G U the two pullbacks agree. Conversely U ×_G U → U ×_C U is the surjective finite étale Isom-torsor, so a compatible bracket on the former descends to C. The comparison does not require a neutralization. For a positive-dimensional band this argument is unavailable; a transverse X atlas remains meaningful, while a stronger Poisson enhancement is separate data.

- Prove functoriality under base change and equivalence of banded lifts, and prove that the pulled-back charts are an open cover with the required exact overlaps.
- A chosen section s : C → G with πs ≅ id_C identifies the gerbe with B_C K, compatibly with the band. Conversely a band-compatible equivalence with B_C K supplies such a section. For a stack base, prove the neutralization on scheme tests and descend it. An S-point of G is not a section over C.
- Prove that the coordinate functions of C pull back to G, but a character of K defines a coordinate line on G only when the corresponding line descent data actually exist. Transport existing monoidal line systems; do not manufacture one from the band alone.

**Checks.**

- The displayed product T × Bμ_r has its trivial-torsor section, relative inertia μ_r, and the ordinary functions of T. An abstract neutral gerbe acquires an identified classifying-stack presentation only after a section is chosen.
- Over ℝ, let the constant group C₄ act on Spec ℂ through C₄ → C₂ = Gal(ℂ/ℝ). The quotient [Spec ℂ/C₄] is a C₂-banded gerbe over Spec ℝ with no ℝ-object: such an object would give a homomorphism C₂ → C₄ lifting the identity of C₂, which does not exist. Its product with a torus is a nonneutral lifted rank-zero pattern.
- On this gerbe a line with the nontrivial kernel C₂-character cannot exist. Its equivariant structure would require an antilinear F(z) = a·conj(z) with F² = −1, whereas F² = |a|². This rules out a definition that attaches all character lines automatically.
- The nonneutral μ₂-gerbe over the doubled X torus in §6.5 has the Poisson bracket of its base by this theorem when 2 is invertible. Its gerbe class is still nontrivial. In characteristic two the theorem's finite-étale hypothesis fails even though the incidence and transverse-atlas constructions remain valid.
- In characteristic different from two, BQ₈ → B(C₂ × C₂) is a central C₂-gerbe. The base is a diagonalizable-band rank-zero X chart, but the total inertia Q₈ is noncommutative. It is a general gerbe presentation, not a chart of §1.1 without enlarging the specified chart class.

*Needs:* §§0.4, 1.1 and 1.3; SchemeAndStackFoundations §§1.15–1.16 and 1.18–1.21 for torsors, stack pullbacks and étale Deligne–Mumford presentations. Use Stacks, Tags 06NZ and 06QG, for gerbes and neutralization, the étale-presentation theorem in Tag 06N3, and Lemma 101.35.5 in Tag 0CIK for étale morphisms. The Poisson comparison is proved by the displayed differential and Isom-torsor descent, without a general gerbe classification.

### 1.6 Poisson data on smooth diagonalizable quotient stacks

In this subsection k has characteristic zero, V = Spec A is smooth affine of finite type, and H is a smooth diagonalizable k-group acting on V. This includes a split torus and a finite diagonalizable factor. Write h = Lie H and a : h → Der_k(A) for the infinitesimal action. Construct the quotient tangent complex E = [A ⊗ h → Der_k(A)] in degrees −1,0 with differential a, and its dual cotangent complex L in degrees 0,1. Derive these complexes from the action groupoid and square-zero deformations of a torsor with an equivariant map; retain their equivariant structures. Their fibre at an object is the deformation complex, not the tangent space of an invariant affine scheme.

Construct the weight-p Cartan polyvectors Pᵖ = Hom_A(Symᵖ_A(L[1]),A)^H. Finite projectivity and characteristic zero identify them with (Symᵖ_A(E[−1]))^H, using normalized symmetric products. Equivalently they are sums of Symʳ(h) ⊗ Λˢ_A Der_k(A), with r+s=p, followed by H-invariants. A Lie-algebra generator has cohomological degree zero and a vector-field generator degree one. Fix the identification of each shifted h-generator η_ξ with its negative so that the differential is dη_ξ=a(ξ); without this identification the standard cochain shift gives −a. The differential vanishes on the ordinary polyvector coefficients. Extend the ordinary Schouten bracket with the η-generators central, and then restrict to H-invariants. Prove that this is a differential graded bracket of cohomological degree −1 and weight −1. Commutation with the differential is required on invariants; it is false on unrestricted coefficients in general.

Define the degreewise complete differential graded Lie algebra g_(V,H) = ∏_(p≥2) Pᵖ[1], with descending filtration by weights p≥r+1. A Poisson datum is a Maurer–Cartan element Π, so dΠ + [Π,Π]/2 = 0; its component Π_p has degree two before the shift. Construct its simplicial space of choices and comparisons by

    MC_n(g) = MC(lim_r ((g/Fʳg) ⊗ Ω_poly(Δⁿ))),
    Ω_poly(Δⁿ) = (k[t₀,…,t_n] ⊗ Λ(dt₀,…,dt_n))/(Σt_i−1, Σdt_i),

where |t_i|=0, |dt_i|=1 and d(t_i)=dt_i. Use the graded-commutative product, so the odd dt-generators anticommute. Include face and degeneracy maps and the completed tensor product. Prove that the finite weight quotients are nilpotent dg-Lie algebras in degrees at least −1, that surjective maps give Kan fibrations, and that weightwise quasi-isomorphisms induce weak equivalences of their Maurer–Cartan spaces. Prove the complete result by the inverse limit of these Kan-fibration towers; an unqualified application of a finite nilpotent theorem is insufficient. Getzler09, Proposition 4.7, gives the fibration proof, and DR15, Theorem 1.1, gives the filtered quasi-isomorphism comparison with the cohomological shift adapter. Reuse the native DG-algebra, Koszul tensor and Adams-completion carriers, and prove the adapter from Adams completion to the degreewise product of these Cartan complexes. Construct the signed dg-Lie and complete Maurer–Cartan extension here; the supplied Hochschild specialization does not assert it for this complex. An ordinary internally graded Lie algebra does not provide the Koszul-signed bracket or this simplicial carrier. Keeping only the set of Maurer–Cartan solutions would lose the comparisons used below.

- Construct restriction along invariant opens and unique transport along equivariant étale maps with the same acting group H. More general group changes require their stated formally étale quotient comparison. Cover an invariant open of V by principal opens D(f) with f semi-invariant, using homogeneous generators of its complement ideal. For open or étale quotient covers use common presentation spaces and affine refinements. Construct the homotopy totalization of the resulting cosimplicial Maurer–Cartan spaces, using a Reedy fibrant replacement, and prove its independence, descent and compatibility with further refinements. Construct this homotopy-descent comparison; ordinary strict totalization is not sufficient. This construction concerns smooth stacks admitting such diagonalizable quotient covers; it does not assume that every Artin stack has one.
- Prove independence of a smooth diagonalizable quotient presentation. For [V/H] ≃ [V′/H′], use the common affine torsor V ×_Y V′ with its H × H′-action. For a morphism of presentations construct the complex of pairs of multiderivations agreeing after evaluation on the cotangent map, with its projections to the two Cartan complexes. Use the resulting spans, rather than an unsupported pullback of bivectors along a smooth map. Prove that these projections are quasi-isomorphisms for torsor replacements. For an H′-torsor E→V with a commuting lifted H-action, the quotient of the Cartan cotangent map is [Ω_(E/V)→O_E⊗h′*], whose differential is an isomorphism by the torsor identity. Finite projectivity and exactness of diagonalizable invariants give a graded equivariant retract. This retract identifies the strict compatible-multiderivation kernel with a homotopy fibre; symmetric powers, duality and torsor descent then prove both projections are quasi-isomorphisms. This includes nontrivial torsors, not only product presentations. Descend the comparison and prove compatibility for chains of replacements by the same compatible-multiderivation construction. This defines the intrinsic space Pois(Y,0) on this class of stacks, with coherent transport along stack equivalences.
- Prove that an H-invariant ordinary Poisson bivector π_V determines a Maurer–Cartan element with only its weight-two component nonzero, hence a 0-shifted Poisson structure on the whole [V/H]. On a free quotient it agrees with the usual reduced bracket; on a finite étale gerbe it agrees with §1.5. This is a construction from a specified invariant bivector, not a pullback of a scalar bracket through a smooth torsor.
- For λ ∈ Λ²h prove that π_V and π_V+a(λ) have explicitly equivalent quotient data. They are both Poisson because h is abelian and π_V is invariant. For λ=ξ∧ζ, the Cartan element (η_ξ a(ζ)−η_ζ a(ξ))/2 has differential a(ξ)∧a(ζ); use it to construct the Maurer–Cartan path, and extend linearly. Retain the path, its concatenation comparison and the higher coherence; do not assert a unique comparison. Establish the corresponding comparison for adding or removing a free torus factor.
- For a translation quotient seed chart [T(L)/D(Λ)], construct a constant log-canonical numerator bivector extending its prescribed form on ker d. Prove that any two such constant lifts induce equivalent full quotient data. After a Lie-level splitting their difference has at least one effective orbit vector in each term; replacing that vector by its Cartan η-generator supplies a primitive. Constant logarithmic vector fields commute, so the resulting linear homotopy satisfies the Maurer–Cartan equation. After an étale trivialization of the gerbe this gives the standard local datum π_X+0 on a product with its classifying-stack band. This statement concerns constant lifts; it does not classify all Poisson structures on a positive-dimensional gerbe.
- Construct the leading bivector class in the weight-two cohomology of the quotient tangent complex and prove its invariance under Maurer–Cartan paths. Compute this class after pullback to a geometric object, using its stabilizer representation. Its nonvanishing can distinguish full-stack Poisson structures whose brackets on invariant functions agree.

This is the smooth, shift-zero specialization of the Cartan model in Yeung22, Theorem 2.16, Definition 2.24, Propositions 3.9–3.10 and Theorem 4.16. The quotient complexes, completed Maurer–Cartan carrier, descent and presentation comparison are construction targets here, rather than assumed consequences of algebraic-stack descent. The comparison with the usual 0-shifted definition is realized by the action-groupoid resolution and the compatible-multiderivation spans in those statements; no general theory of all shifts or derived moduli is an input. Safronov18, Definition 2.5 and Proposition 2.14, give the equivalent invariant-Poisson-action construction via a 1-shifted coisotropic map [V/H] → BH. That coisotropic interpretation is not substituted for the explicit shift-zero carrier.

**Checks.**

- For H=1 and smooth affine V, there are no degree-zero η-generators. Degree two occurs only in weight two, so the construction recovers an ordinary Poisson bivector and its Jacobi equation. The space of such structures is discrete.
- For a finite étale H, h=0 and taking invariants gives the usual étale quotient bracket, even for a nonfree finite action. For a positive-dimensional H the two-term complex is indispensable.
- For V=𝔾_m acted on freely by H=𝔾_m, the anchor identifies the Lie-algebra generator with x∂x. The vertical pair is contractible and the quotient has the Poisson structures of Spec k. Keeping the Lie-algebra term without its differential would give a different result.
- On V=Spec k[x,y,(xy−1)⁻¹] with H=𝔾_m acting with weights (1,−1), put π=(xy−1)∂x∧∂y. It is invariant and Poisson. At x=y=0 the anchor is zero, and π has nonzero invariant leading class −∂x∧∂y. On D(x)∪D(y) the quotient is a curve and both π and the zero structure induce the zero Poisson structure. Thus restriction to a schematically dense cluster locus need not distinguish ambient stack Poisson structures.

*Needs:* §0.4 for algebraic brackets and étale transport; §§1.1 and 1.4 for actions, quotient stacks and open recognition; the native cochain, signed DG, simplicial, symmetric/exterior and completion APIs in the exact contracts; DGAInfinity Layers 0–1 for signed multilinear conventions; SchemeAndStackFoundations §§1.14–1.22 for affine torsors, common presentations and equivariant module descent. The algebraic Schouten and Cartan extension, the filtered dg-Lie Maurer–Cartan specialization, and the quotient-comparison constructions used here are owned in this subsection; the native associative DG and tensor carriers are reused. Yeung22 supplies their specialized proof route; a real smooth-manifold Lie-groupoid theory is not this algebraic supplier.

### 1.7 Cluster Poisson structures on the ambient stack

For a smooth characteristic-zero algebraic stack Y admitting the quotient presentations of §1.6, define a cluster Poisson structure to consist of a Poisson datum Π_Y ∈ Pois(Y,0) and an intrinsic realized X atlas j : C → Y from §1.4. Each chart retains the actual restriction of Π_Y and a full Poisson comparison with the standard log-canonical gerbe model: on a specified étale cover of its torus base that trivializes the band and gerbe, it is equivalent to π_X+0 on U×BK_s. Retain the comparison paths and their descent coherence; no global neutralization is required. Translation-quotient charts use the constant-lift comparison of §1.6 to prove this condition. In particular the induced bracket on torus characters is ω_s, but that scalar equality alone is insufficient. Lifted mutations and geometric relation comparisons preserve the full restricted data and these comparisons, with all coherence. A gerbe-valued transverse X atlas without Π_Y is the weaker datum of §§1.1–1.4, not a full cluster Poisson structure on Y. The definition does not require a decoration torsor or a neutralization of the chart gerbes.

- Prove recognition with a specified ambient Π_Y: combine the exact 2-overlap criterion with the standard local Poisson-model comparisons, chart character brackets and full restricted Poisson comparisons. An equivariant Poisson presentation, after the construction of §1.6, is one way to supply Π_Y; equality of invariant rings is not such a construction.
- Define a full Poisson structured equivalence to include an equivalence of ambient stacks, a specified equivalence of their transported Maurer–Cartan data, and compatible intrinsic X chart comparisons. Build identities, inverses, compositions and their coherences using the simplicial carrier. Forgetting Π_Y gives the atlas equivalence of Layer 2, but that forgetful map need not distinguish structures.
- Separate existence and uniqueness of an ambient extension. Both are questions about Π_Y, and neither follows solely from density, a codimension-two complement in a smooth presentation, or the sheaf bracket on C. Preserve the full complement and its inertia in the input Y.
- Prove that on smooth schemes this definition recovers an ambient ordinary Poisson bracket together with a compatible X realization. On finite étale gerbe loci it agrees with §1.5. Positive-dimensional stabilizers use the Cartan construction, with no automatic lift from a base Poisson torus asserted.

**Checks.**

- The two Poisson structures on [Spec k[x,y,(xy−1)⁻¹]/𝔾_m] in §1.6 have the same rank-one X atlas, the same two charts, the same exact overlaps and the same chart brackets. Their leading classes at the residual B𝔾_m differ, so they are not equivalent over the identity ambient stack. A definition retaining only the gerbe atlas fails this test.
- For a point with the rank-zero X atlas and the free presentation [𝔾_m/𝔾_m], the acyclic-pair comparison of §1.6 preserves its Poisson datum as well as its underlying stack. A free decoration factor does not create a new Poisson moduli object.
- On a product T×B𝔾_m, a formal higher-weight term involving the degree-zero inertial generator can satisfy the Maurer–Cartan equation without altering the scalar character bracket. The definition requires a comparison with its standard log-canonical model; equality of that scalar bracket does not discharge the requirement.
- A chosen ordinary bracket on a torus together with an abstract positive-dimensional gerbe over it is insufficient input for this definition. A quotient model with a verified invariant bivector, its comparison to the gerbe, and the standard local Poisson-model comparisons above is sufficient. An invariant numerator bivector alone does not discharge the seed-model condition.

*Needs:* §§1.1–1.6 and §0.4. The full-stack structure uses the completed Poisson carrier of §1.6; all-characteristic fppf atlas and inertia constructions retain their earlier scope.

### Examples

Ordinary Poisson X tori give the scheme subcase. Intrinsic flag cross-ratios give X charts without A decorations. A homogeneous A pattern produces the same intrinsic type only after the integral character and Poisson comparisons of §1.2. Neutral and nonneutral bands retain different moduli data over the same Poisson base. The finite-étale theorem compares the atlas with ordinary Poisson Deligne–Mumford stacks. The Cartan construction retains ambient Poisson information at positive-dimensional stabilizers, and the four-flag quotient shows why the full datum is necessary.

### Dependencies

Layer 0 supplies recognition and algebraic Poisson transport. Native diagonalizable groups and comodule weights supply the graded quotient construction. Native signed DG, tensor and completion APIs and DGAInfinity Layers 0–1 supply the linear-algebraic floor for §1.6; its Cartan, Maurer–Cartan and homotopy-descent statements are constructed here. ClusterAlgebras supplies X and A mutation formulas. SchemeAndStackFoundations supplies ordinary stack and module descent, quotients and sheaves; EquivariantIntersectionTheory supplies the linearisations used by the gerbe check.

## Layer 2: structure, equivalence and equivariant presentations

### 2.1 Compatible refinements and equivalence

Associate to an intrinsic X atlas its (2,1)-category of admissible chart maps into C. Start with the full gerbe charts and their open restrictions. Generate comparisons by geometric X mutations and seed isomorphisms preserving ω, by their actual banded-gerbe equivalences, and by isomorphisms over C preserving this X data. Close under restrictions and compatible gluing. For u : U → C and v : V → C, a 1-morphism is an allowed f : U → V with α : u ⇒ vf; a 2-morphism to (f′,α′) is θ : f ⇒ f′ with α′ = (v ⋆ θ)α. Keep these automorphisms. A decorated A structure can additionally mark its A charts, gradings, lines and permitted grading translations; these extra choices refine the intrinsic X structure and are not prerequisites for it.

A structured X equivalence consists of C ≃ C′ and a compatible biequivalence of these chart categories, preserving the full X seeds, their Poisson pairings, bands, gerbes and actual transition comparisons. A change of indexing is supplied geometrically, and can compare mutation-word and coslice presentations without identifying maps solely by their rational action. A realized atlas equivalence also includes Y ≃ Y′ commuting with the open realizations. For full cluster Poisson structures it additionally carries the ambient Poisson comparison and standard seed-model comparisons of §1.7; equality of transverse pairings does not replace them. A common compatible refinement uses open restrictions covering each original full chart. Equivalence of chosen A decorations is a stronger comparison retaining their additional data. Two different A presentations can induce the same intrinsic X structure.

- Prove that compatible refinements induce structured equivalences and that successive refinements compose. Prove the converse local criterion: given the specified seed-pattern and chart-model identifications, when an equivalence carries each chart locally to an admissible chart in both directions respecting those identifications, the pullbacks of these domains give a common compatible refinement.
- For the underlying atlas structures construct the hom groupoid of structured equivalences, including their compatible 2-isomorphisms. These assemble into a 2-groupoid with a forgetful pseudofunctor to the underlying realized pairs and their equivalences. Its fibres retain different decorations on the same space. Full ambient Poisson comparisons retain the Maurer–Cartan paths and their higher coherence from §1.7; they are not replaced by this underlying atlas 2-groupoid.
- Preserve the whole cluster locus under equivalence. Restricting two loci to a shared dense open yields a comparison of restrictions, not an equivalence of their original structures.

**Checks.**

- Refining a chart by two opens that cover it preserves the structure. Deleting a point from the chart and keeping only the complement is not a refinement covering that chart.
- A rank-zero marking of 𝔾_m and a rank-zero marking of 𝔾_m ∖ {1} cannot be identified by their common rational coordinate: the latter open is not a full torus chart, and the loci differ.
- The point presented as Spec k and as [𝔾_m/𝔾_m] has the same intrinsic X chart by the canonical torsor quotient. A chosen A marking can distinguish the two decorated presentations; that distinction is not imposed on their X structure.
- Multiplying a nonzero skew pairing by two while dividing compatible weights by two can leave ε unchanged. The coordinate mutation patterns agree, but the identity map is not a Poisson structured equivalence.
- On the doubled torus, interchanging its two points over −1 is a nontrivial geometric automorphism inducing the identity on the common rational coordinate. Its actual chart comparisons must be retained.

*Needs:* §§0.1, 0.4 and 1.1–1.5 for intrinsic charts and their 2-morphisms; ClusterAlgebras §3.5 for seed-presentation comparisons, with actual domains separately transported; SchemeAndStackFoundations §1.18 for descent. Changes of an auxiliary A presentation use the canonical gerbe comparison of §1.1 and the X-coordinate comparison of §1.2.

### 2.2 Poisson chart maps and decorated transport

A chartwise monomial Poisson map of intrinsic X loci is specified on open covers of every full source chart. Choose a target X chart, a contravariant character map q : N_target → N_source and a unit-valued character c : N_target → Rˣ, with f* zⁿ = c(n)z^(q(n)) in the displayed source coordinates. Require ω_source(q(n),q(m)) = ω_target(n,m). The scalars depend on the base, not freely on a chart point; they may be supplied with compatible base descent. Include an actual morphism of the chart gerbes over this torus map, with its band map. Keep the displayed source characters when testing the formula, and require compatibility with all actual transitions. These monomial Poisson maps form a specified class of geometric maps, not the definition of every Poisson map or every structured equivalence.

For a map of chosen A decorations add the character map q_A : L_target → L_source and degree map β with d_source q_A = β d_target. When its scalar is required to come from a grading translation h, use f* zᵐ = χ_(d_target(m))(h)z^(q_A(m)). Verify that its restriction to invariant characters is the underlying X map through the supplied integral lattice identifications. The additional decorated map cannot supply a missing gerbe morphism merely by its action on functions.

The pieces, seed labels and actual overlaps form a refinement diagram. Require containment of each source overlap in the chosen target overlap and commutation with each required source transition, using coherent 2-isomorphisms for the gerbes. The decorated degree condition gives the equivariance homomorphism D(β) and its quotient comparison. Refining domains does not change their full source-seed labels or displayed characters.

A chartwise monomial map of realized pairs additionally includes F : Y → Y′ and a 2-isomorphism F j ⇒ j′ f. These maps form a specified class of regular maps with marking data. Structured equivalence of presentations remains the notion of §2.1; it gives an invertible map in this class when its comparisons and their inverses satisfy the displayed-character condition. A rational seed transformation on a proper domain is not an everywhere defined map of completions.

- Construct f by descent and compare compatible refinements of its local description through the compatible 2-isomorphisms. Retain the groupoid of such comparisons.
- Construct identity maps and composition. On X bases the composite has q_f q_g and scalar c_g(n)c_f(q_g(n)); the pairing identity composes. For the specified grading translations the composite parameter is h_g · D(β_g)(h_f). Refine source domains by inverse images of the second domain cover. Actual-overlap conditions, band maps and coherence compose, proving associativity and units by descent.
- Transport an atlas along a geometric isomorphism of X seed patterns, preserving ω and the actual domains. Change the initial seed using the transported word or coslice presentation and its geometric comparisons. Transport additional A lattices and degrees separately. These operations do not insert an unrecorded nonlinear change into the displayed source formula.

**Checks.**

- In rank zero, x ↦ x² on 𝔾_m is a regular marked monomial map. In characteristic two it is not étale, so the definition must not force all maps to be chart isomorphisms.
- The inversion x ↦ x⁻¹ is an automorphism of the rank-zero torus. It does not extend to an automorphism of its specified completion 𝔸¹.
- Two maps of stacks with the same action on ordinary functions can have different effects on stabilizers. The comparison of maps therefore includes the groupoid maps and their 2-isomorphisms.
- On a rank-zero Poisson torus, x ↦ c x is allowed with its stated unit c. Composition with inversion has the explicit scalar c⁻¹; the definition does not discard this base-valued coefficient.
- On a symplectic two-torus with {X,Y}_P=XY, the monomial map (X,Y) ↦ (X²,Y) is not Poisson to the torus with the same bracket in characteristic zero. Its character map multiplies the pairing by two.

*Needs:* §2.1; §§0.2, 0.4 and 1.1–1.4 for Poisson comparison, gerbes, descent and recognition; ClusterAlgebras §§3.3–3.5 for seed transport. No claim that an arbitrary morphism of ambient spaces pulls back a full cluster structure is used here.

### 2.3 Equivariant cluster presentations

Let G be a flat group scheme of finite presentation acting on a realized cluster locus C and on Y, with j equivariant. An equivariant presentation includes a coherent lift to the admissible chart categories of §2.1, compatible with base change, multiplication and units. For X structures require preservation of the base Poisson pairings and the gerbe data. For split charts a sufficient condition is that locally on the group parameter and chart domain the action is a specified seed transformation followed by a base-valued torus translation compatible with the full transition system; in a decorated presentation this can be a grading translation. Check the group identities and the Poisson condition, rather than only an action on rational functions. Point-dependent gauge 2-isomorphisms of maps into an existing quotient chart are still permitted; they change a framing and not the X-coordinate transformation.

The output quotient presentation has admissible chart maps obtained by composing the numerator's admissible maps with C → [C/G], including the actual action 2-isomorphisms parametrized by G, and closing under the same permitted domain comparisons, restrictions and gluing. Retain their hom groupoids as in §2.1. These maps need not be open immersions, so the output is a marked quotient presentation. The invariant-chart comparison below gives an open-stack atlas; it is an open cluster atlas in the chart class of §1.3 when each resulting quotient chart is additionally identified with a permitted marked model.

- Form the quotient of the full action groupoid G × C ⇉ C, retaining its marked presentation. If C is itself a stack, choose a smooth scheme atlas U → C and form the algebraic space of triples (u,g,v) with an isomorphism g·u ≅ v in C. Its two maps to U are flat and locally finitely presented; the coherent action supplies groupoid composition. The supplier's quotient of this algebraic-space groupoid constructs [C/G] and proves independence of U. The induced map to [Y/G] is a representable open immersion when C is G-invariant: after the fppf base change Y → [Y/G] it is C → Y, and openness descends. The same descent preserves the stated schematic density.
- If the action preserves every chart open, prove that [C_i/G] form a coherent open-stack atlas of [C/G], with overlaps [V_ij/G]. This is the comparison to the general gluing datum of §1.3. To obtain its narrower cluster-chart class also supply the quotient charts' identifications with allowed seed models; arbitrary G need not preserve that class. If charts are permuted, retain all arrows of the action groupoid instead of replacing an orbit by a chart modulo its setwise stabilizer.
- Prove invariance under an equivariant compatible refinement. More generally a supplied equivalence of presenting groupoids induces a structured equivalence exactly when its chart comparisons give the required biequivalence of admissible marked chart (2,1)-categories; an undecorated Morita equivalence alone does not supply this conclusion.

**Checks.**

- A common homogeneous D(Λ)-action preserving all seed charts recovers the quotient atlas from §1.2.
- For xy = 1+z, the involution swapping x and y permutes D(x) and D(y), which overlap. The map from D(x) modulo its trivial setwise stabilizer to [C/C₂] identifies points through the other chart and is not an open immersion in general. The full action groupoid contains these arrows.
- An arbitrary action of a reductive group on a rational variety is not an equivariant cluster presentation: preservation of the specified marked chart transformations must be supplied and checked. A point-dependent factor chosen to fit any birational formula does not satisfy the sufficient condition above.
- Over a field of characteristic different from two, C₂ acts on the single rank-zero torus chart by x ↦ x⁻¹, a permitted seed-lattice isomorphism. Its quotient has C₂ inertia at x = ±1 and trivial inertia elsewhere. It is an equivariant cluster presentation, but it cannot be treated as one translation quotient-torus chart with constant inertia.

*Needs:* §§1.1–1.4 and 2.1–2.2; SchemeAndStackFoundations §§1.14–1.16 and 1.18–1.21 for action groupoids, representable diagonals, descent and quotients. Stacks, Tag 04YN, gives the invariant-open comparison for a smooth presentation; the fppf descent argument above gives the stated flat, finitely presented action case. General reductive-group theory is not a prerequisite for this construction.

### Examples

Changes of the initial seed preserve the marked maximal cluster locus. Compatible restrictions give the same locus. The common grading action gives genuine open quotient charts, while the chart-swapping involution requires the full equivariant presentation. These comparisons explain separately which data come from seed transformations, which come from an action on the moduli problem, and which produce actual inertia.

### Dependencies

Layers 0–1 supply recognized and coherent marked atlases. ClusterAlgebras §3.5 supplies seed-presentation transport. SchemeAndStackFoundations §§1.14–1.21 supplies the groupoid and descent operations. No ordinary ring reconstruction is needed for these equivalences.

## Layer 3: A decorations, line-bundle exchange and characterwise sections

### 3.1 Monoidal line systems and exchange sections

This layer constructs additional A-decoration data and its recovery from torsors. An intrinsic X atlas from Layer 1 is already defined before choosing these lines. Conversely a monoidal line system on a stack does not by itself determine its X Poisson pairing or its actual chart overlaps.

For a finitely generated abelian group Λ, a monoidal line system on an algebraic stack Y is a symmetric monoidal functor from the discrete Picard groupoid Λ to the Picard groupoid of invertible sheaves on Y. It includes actual lines L_λ, an identification L₀ ≅ O_Y, tensor identifications L_λ ⊗ L_μ ≅ L_(λ+μ), and their unit, symmetry and associativity coherence. A line-valued seed chart C_s → Y additionally identifies its coordinate functions, after pullback and the specified local frames, with sections s_i in Γ(C_s,L_(a_i)|C_s). For homogeneous exchange, require the identity s_k s′_k = M₊(s)+M₋(s) on its actual mutation overlap, in the single line L_(deg M₊), using the chosen tensor identifications. Extension of a coordinate section to C or to Y is a separate assertion; X coordinates and boundary completions can prevent such extension.

- Construct the Λ-graded algebra ⊕_λ Γ(Y,L_λ) using these tensor identifications. Prove associativity, commutativity and the degree-zero identification with Γ(Y,O_Y).
- Pull back the entire system and exchange identities along a morphism. Compare two systems by a monoidal natural isomorphism; equality of their classes in Pic(Y) is insufficient.
- Glue local coordinate sections exactly when their line and section identifications agree with all transition 2-isomorphisms. Changes of local frame act by units and preserve the identity after the corresponding coherent tensor transport.

**Checks.**

- For Λ = 0 the graded algebra is Γ(Y,O_Y), and the exchange identity is an ordinary identity of functions.
- On Bμ_r over a field, the character line of weight λ has no nonzero section unless λ = 0 in ℤ/rℤ. It is nevertheless an invertible sheaf; triviality of a pulled-back line does not make its descended section invariant.
- The nonneutral real gerbe in §1.5 has no line of the nontrivial band character. Its band does not define a monoidal line system containing that character, even though such a line exists after the splitting extension ℂ/ℝ.
- On Spec ℝ with Λ = ℤ/2ℤ, take L₀ = L₁ = O. Choosing the tensor identification L₁ ⊗ L₁ → L₀ as +1 or −1 gives graded section algebras ℝ[t]/(t²−1) and ℝ[t]/(t²+1). The Picard classes coincide, but a real change of frame multiplies the chosen coefficient by a square and cannot identify these monoidal systems.

*Needs:* §§1.2, 1.5 and 2.2; SchemeAndStackFoundations §§1.22 and 3.4 for invertible sheaves, Picard groupoids and descent; EquivariantIntersectionTheory §1.1 for the equivariant line convention. The construction retains monoidal data rather than choosing representatives in a Picard group.

### 3.2 Sections on diagonalizable quotients

Let Y be an R-scheme with an action of H = D(Λ), put Q = [Y/H], and let L_λ be its character lines with the convention above. Let A_λ consist of the functions in A = Γ(Y,O_Y) satisfying the weight-λ transformation law. Prove the multiplication-compatible identifications Γ(Q,L_λ) ≅ A_λ, without a quasi-compactness assumption. The actual H-torsor p : Y → Q is representable affine, and its character lines give a canonical isomorphism of quasi-coherent algebras p_* O_Y ≅ ⊕_λ L_λ. Consequently Γ(Q,⊕_λ L_λ) ≅ A without quasi-compactness or quasi-separatedness hypotheses on Y. In degree zero, Γ(Q,O) ≅ A₀ = Aᴴ. No faithfulness, reducedness or characteristic-zero assumption on H is required.

Use quasi-coherent descent to identify a quotient section with an equivariant section on Y. Prove the sheaf-algebra identity after trivializing the torsor, where it is the character decomposition of O[Λ], and descend it. If Y is quasi-compact and quasi-separated, the action gives an algebraic coaction on A; apply the native internal weight decomposition to obtain ⊕_λ Γ(Q,L_λ) ≅ A as Λ-graded R-algebras. Prove compatibility with restriction to invariant opens and with all homogeneous mutations of §1.2. For a non-quasi-compact locus, the sheaf-algebra and weightwise comparisons still hold, but recovery of A by the direct sum of global weight spaces requires a separately established finite-weight property for each global function.

**Checks.**

- For the translation action of 𝔾_m on itself, the quotient is a point. Each character line is isomorphic to a trivial line on that point, but the labelled direct sum recovers k[x±1]; forgetting the character labels leaves only k.
- For a trivial H-action, A has only weight zero and Γ(Y × BH,O) = A. Nontrivial inertia is invisible to this equality.
- Let Y be the disjoint union of countably many copies of 𝔾_m with translation action. The global function whose nth component is xⁿ has unbounded weight support. It lies in the product of the Laurent rings and not in the direct sum of global weight spaces, showing why the quasi-compactness or finite-weight hypothesis is needed.

This graded algebra is not asserted to be a Cox ring. Such a comparison also needs a specified relation between Λ and Pic(Y/H), the chosen representative lines and their tensor coherence; redundant characters and missing line classes are allowed here.

*Needs:* §§1.1–1.2 and 3.1; native comodule weight decomposition; the effective affine descent supplier above and SchemeAndStackFoundations §§0.1, 1.1 and 1.22 for direct-image algebras and quotient quasi-coherent descent; EquivariantIntersectionTheory §§1.1 and 1.4 for character lines and their quotient interpretation. The torsor-local calculation fixes the character sign and multiplication.

### 3.3 Descent of the graded section algebra

For a coherent marked atlas of C and an already specified monoidal line system on C, identify Γ(C,L_λ) with the equalizer of the product of chart sections and the two restrictions to the actual pairwise overlaps. One restriction uses the specified line transition. Prove that these equalizers assemble into the graded algebra of §3.1, with multiplication induced chartwise and with all η_ijk accounted for. This is the upper section algebra of the decorated atlas. Its definition uses section descent, so it also applies when no common function field exists.

- Prove independence under the compatible refinements of §2.1 and functoriality under maps with a specified comparison of their monoidal line systems.
- For an integral scheme atlas with dense overlaps and Λ = 0, identify the equalizer with the intersection of the chart rings in the marked common field. For the maximal A atlas, compare with the upper algebra supplied by ClusterAlgebras §3.3. If Λ is nonzero and every line is coherently trivialized, the full graded algebra is the group algebra of that intersection with grading group Λ; only its degree-zero part is the ordinary intersection.
- For a global diagonalizable quotient presentation satisfying §3.2, identify this equalizer degree by degree with the homogeneous components of the section equalizer upstairs. When the upstairs atlas is integral with dense overlaps in a marked common field, this is the homogeneous part of its chart-ring intersection. Without those additional hypotheses retain the equalizer formulation. The ordinary functions downstairs are its degree-zero part.

**Checks.**

- For two charts with empty overlap the equalizer is the product of their section modules, not an intersection in a common field.
- For T × Bμ_r, nontrivial character degrees have zero sections and the trivial degree is R[L]. A construction using only the coarse torus would incorrectly fill every degree with R[L].
- For the two quotient charts of xy = 1+z with weights (1,−1,0), the degree-zero chart rings are both k[z±1], with actual overlap z ≠ −1. Their equalizer is k[z±1] even though the quotient locus has two points over −1.

*Needs:* §§1.3, 2.1 and 3.1–3.2; SchemeAndStackFoundations §1.22 for section descent; ClusterAlgebras §3.3 for the ordinary upper-algebra identification. The equalizer proof uses the sheaf condition and the supplied coherence, not a new affineness hypothesis.

### 3.4 Descent with a character local system

Let Λ be a locally constant sheaf of finitely generated abelian groups on the fppf site of S, with specified local identifications with constant groups on an fppf cover; an étale splitting cover can be used when supplied. A line system indexed by Λ on Y → S assigns an invertible sheaf L_λ on Y_T to every T → S and λ in Λ(T), together with pullback, unit and symmetric monoidal tensor identifications satisfying descent and coherence. Thus an identification of Λ with a constant group Γ recovers the line systems of §3.1, while changes of a local identification may permute the degrees. The sheaf Λ and its descent data are retained; no global choice of individual character labels is inferred.

- On a cover trivializing Λ, form the quasi-coherent algebra sheaf A_i = ⊕_(λ∈Λ_i) L_λ on Y_i. Use the given degree relabelings and monoidal line comparisons to descend these algebras to A on Y. A relabeling on an overlap need only be locally constant: refine that overlap to define its summand maps and glue them as sheaf maps. Prove independence of the splitting cover and functoriality under pullback and compatible maps of the character sheaves. Its unit and distinguished degree-zero subsheaf descend as O_Y.
- Define the section algebra of this descended sheaf as Γ(Y,A), carrying its locally graded descent structure. After a chosen global trivialization of Λ, compare it with ⊕_λ Γ(Y,L_λ) when global sections commute with this direct sum. This holds for a quasi-compact quasi-separated scheme; in other settings retain the sheaf-level algebra and state the comparison only with a supplier theorem or a proof that each section has finite global weight support. Taking the sum over Λ(S) before descent does not recover A in general.
- For a supplied affine group H over S with compatible split identifications H_i ≅ D(Λ_i), and an actual H-torsor p : X → Y, use its associated line system. The morphism p is representable affine by local triviality and affine descent. Descend the canonical local identities p_* O_X ≅ ⊕_λ L_λ from §3.2 to obtain p_* O_X ≅ A. Hence Γ(Y,A) ≅ Γ(X,O_X) without any quasi-compactness assumption on X or Y. Preserve homogeneous exchange through the local degree relabelings and compare the upper-section equalizers after the same descent. An arbitrary local line system does not, in this target, come with an already constructed global torsor X.

The proof first applies quasi-coherent algebra descent on Y, where arbitrary direct sums and the monoidal comparisons are defined, and then takes global sections. Interchanging global sections with a direct sum, or identifying them after tensor-product base change, uses its separately stated hypotheses. No classification of multiplicative-type groups or new carrier for their character sheaves is required: the local system and, in the torsor comparison, the group and actual torsor are inputs.

**Checks.**

- For a constant Λ with identity degree cocycle, the descended sheaf is ⊕_λ L_λ. On a quasi-compact quasi-separated scheme its global sections agree with the graded algebra of §3.1. On the non-quasi-compact disjoint-union example of §3.2, sheaf sections with unbounded weight support show why this last comparison needs its hypothesis.
- Over ℝ, the semilinear involution σ(t) = t⁻¹ on ℂ[t±1] descends the degree lattice ℤ with sign monodromy. Its fixed ring is ℝ[a,b]/(a²+b²−1), with a = (t+t⁻¹)/2 and b = (t−t⁻¹)/(2i). The global character group is zero, so summing only global character degrees would give ℝ and lose a and b.
- On ℂ[x±1,y±1], let complex conjugation exchange x and y. The descended lattice has global characters ℤ(1,1), but the descended ring is ℝ[a,b,(a²+b²)⁻¹], with a = (x+y)/2 and b = (x−y)/(2i). The global-character sum ℝ[(xy)±1] omits a and b. All rings in these two descent examples are affine, so the discrepancy comes from degree monodromy rather than a failure of quasi-compactness.

*Needs:* §§1.3, 2.1 and 3.1–3.3 for compatible chart and line data; the effective affine descent supplier above; SchemeAndStackFoundations §§0.1, 1.1, 1.15, 1.21–1.22 and 3.4 for direct-image algebras, torsors, quotient stacks and quasi-coherent and Picard descent; Mathlib sheaves, locally constant maps and direct sums. Affine descent and affine pushforward on scheme or algebraic-space tests are Stacks, Tag 0245 and Lemma 69.11.1 in Tag 073I; apply quasi-coherent descent for the stack comparison. The displayed descent rings are computed directly from their semilinear involutions.

### Examples

For a homogeneous A pattern, coordinates descend as sections of the character lines and every exchange is an equality in a specified tensor product of those lines. When all degrees vanish, the comparison gives ordinary cluster functions on a quotient with potentially nontrivial generic inertia. When the degree map is surjective, an underlying scheme quotient can still need its character labels to recover the original graded coordinate algebra. Descent of those labels can produce a character local system even when every split chart has a fixed lattice.

### Dependencies

Layers 1–2 supply equivariant mutation and coherent comparisons. SchemeAndStackFoundations §§1.22 and 3.4 supplies sheaf and Picard descent. EquivariantIntersectionTheory §§1.1 and 1.4 and native comodule weights supply the quotient comparison. No extension of line bundles across a boundary is assumed.

## Layer 4: boundary models, forms and families

### 4.1 Specified frozen-boundary models

A frozen-boundary model for a marked atlas specifies, for each relevant full seed chart, a regular toric partial compactification together with its full cone and face data, a marking of the chosen frozen directions, and open transition extensions satisfying the domain and coherence laws. Its torus restriction must be the original actual transition system. The toric charts are Spec R[σ∨ ∩ L] for regular cones in the cocharacter lattice, using ClusterAlgebras §3.3. A general mutable family is allowed; an adapted basis or explicit character/cone data must be supplied whenever frozen coordinate hyperplanes are named. Arbitrary rays alone do not supply this boundary model.

- Glue the extended charts and prove that the original C embeds as an open subspace C → Cᶠʳ, compatibly with all markings. Prove density where the torus inclusions are schematically dense, including the supplied regular toric models over arbitrary R.
- Extend homogeneous diagonalizable actions to the monoid algebras and descend compatible boundary models to quotient stacks. Track each boundary coordinate as a section of its character line, together with its vanishing substack.
- For an X toric model, prove that {zⁿ,zᵐ}_P = ω(n,m)zⁿ⁺ᵐ preserves its semigroup algebra and extends the torus bracket. Require every extended transition to preserve it. For roots with orders invertible in R, extend ω to the enlarged character lattice, construct the corresponding log-canonical bracket and its finite étale diagonalizable quotient presentation. If an order is not invertible, a compatible extended pairing must be supplied and checked; an arbitrary root construction does not automatically lift the bracket.
- Given specified effective Cartier boundary divisors and positive root orders, use the supplier's root stacks to construct the corresponding rooted model and its restriction to C. Retain the root orders, divisor sections and their identifications; the underlying divisorial valuations do not determine these stabilizers.

**Checks.**

- The cone generated by the first basis cocharacter gives Spec R[t,z±1]; its zero face gives Spec R[t±1,z±1], including R = ℤ/4ℤ. The coordinate t remains a nonzerodivisor despite nilpotents in R.
- 𝔸² and 𝔸² ∖ {0} have the same dense torus and the same two coordinate divisorial valuations, but different cones and boundary incidence. A list of rays would identify two different models.
- The rth root of (𝔸¹,{0}) is [𝔸¹_u/μ_r] with base coordinate t = uʳ. Its geometric stabilizer at zero is μ_r, while its scheme-theoretic fibre over t = 0 is [Spec k[u]/(uʳ)/μ_r], not merely Bμ_r.
- If {t,z}_P=tz and t=uʳ, a compatible log bracket has {u,z}_P=(1/r)uz when r is invertible. In characteristic dividing r, Leibniz gives {uʳ,z}_P=0, so this nonzero base bracket cannot have such a lift. The root order is a Poisson hypothesis as well as inertia data.

*Needs:* §§0.1, 1.2–1.4 and 3.1; ClusterAlgebras §3.3 for regular toric charts and base change; SchemeAndStackFoundations §1.21 for root stacks and quotient constructions. GHKK, Construction B.9, arXiv v2, p. 117, motivates the specified frozen extensions; it does not assert existence for arbitrary chosen cone systems.

### 4.2 Ambient completions and the remaining locus

A boundary-compatible realization is a pair of open immersions C → Cᶠʳ → Y, where the first is a specified model of §4.1 and the second is a realization satisfying exact overlaps for its extended charts. Define the remaining locus as the closed subset |Y| ∖ |Cᶠʳ|. A closed-substack structure on this subset, when needed, is additional data; it is not recovered from the ordinary coordinate ring. The frozen boundary lies in Cᶠʳ ∖ C and the remaining locus need not be a union of frozen divisors.

- Recognize the extended chart realization by §§0.2 or 1.4, and identify its image as their union. Keep the complement and all inertia induced from Y.
- Transport the pair along a structured equivalence preserving the cone, root and divisor data. Prove that changing the specified ambient completion need not preserve the remaining locus.
- Formulate the condition that the remaining locus has codimension at least two, or that a specified sheaf has depth at least two along it. Use these as hypotheses for the section comparison of §5.2, not as axioms of a cluster structure or as a claim that line bundles extend. For a full cluster Poisson stack retain Π_Y on the remaining locus as well. Scheme Hartogs for a fixed regular bivector does not imply that restriction on full stack Poisson spaces is injective; the four-flag example of §6.5 distinguishes these assertions.

**Checks.**

- For xy = 1+z with z inverted and no frozen direction added, Cᶠʳ = C = D(x) ∪ D(y), and the remaining locus in its affine exchange surface is the single point (0,0,−1).
- Taking Y = Cᶠʳ makes the remaining locus empty. The same marked locus can have a nonempty remaining locus in another completion.
- A root order along a frozen divisor changes the stabilizer of the ambient stack without changing the ordinary vanishing order of the base coordinate. Boundary-compatible equivalence must retain that order and the root section.

*Needs:* §§0.3, 1.4, 2.1 and 4.1; SchemeAndStackFoundations §§0.6–0.7 and 1.20 for depth, dimension and their smooth-local interpretation. No extension or reconstruction theorem is included in this definition.

### 4.3 Base change with actual domains

For any ring map R → R′, pull back every chart, actual overlap, transition, coherence map and existing realization. Prove that the resulting glued scheme or stack is the base change of the original glued object. Prove the analogous comparison for a supplied action-groupoid quotient and for character lines. The pulled-back chart domains are part of the comparison. Do not replace them by the maximal regular domains of the specialized rational maps.

For X structures also extend the scalar-valued bracket and transport its pairing. This is scalar extension of an R-bilinear bracket, not Poisson pullback along an arbitrary morphism into the moduli space. Keep any required denominator units. The radical and the scheme structure of inertia can change in a fibre; the integral seed lattice and the actual band do not become their sets of geometric points.

Prove preservation of open immersions and exact-overlap recognition by base change. Preserve a dense realization when it is S-universally schematically dense, meaning that C ×_S S′ → Y ×_S S′ is schematically dense for every S′ → S. Without that hypothesis carry the resulting open realization and assert density only when proved on the new base. The condition is relative to S, not to every base change into Y. For a fibre over a field κ, the supplied common-function-field pattern requires that every required specialized A exchange factor for a nonzero mutable direction be nonzero; X factors for nonzero directions are nonzero over every κ, and zero directions have the supplied identity mutation. Under these conditions the specialized field pattern and its maximal system are defined, but the inherited actual system is still not re-maximized. For the graded global-section algebra provide the natural base-change map; it is an isomorphism only when a relevant base-change theorem or a direct chart computation proves this.

**Checks.**

- For xx′ = 2 over ℤ, let C be the two tori glued over D(2). The integral chart intersection is ℤ[x,x′]/(xx′−2): in a Laurent expansion in x, the coefficient of x⁻ⁿ is divisible by 2ⁿ. On the 𝔽₂-fibre the two tori are disjoint and its functions are 𝔽₂[x±1] × 𝔽₂[x′±1]. The natural map from 𝔽₂[x,x′]/(xx′) is not surjective, for example onto (x⁻¹,0).
- The dense open Spec ℤ[1/2] → Spec ℤ pulls back to the empty open over 𝔽₂. Schematic density without universal density is insufficient for arbitrary base change.
- In characteristic two the exchange factor 1+z² = (1+z)² remains nonzero as a Laurent polynomial. Its nonreduced zero scheme must be retained; replacing integral exponent labels by their residues would give a false degeneration.

*Needs:* §§0.1–0.3, 1.3–1.4, 2.3 and 3.1–3.3; Mathlib localization and scheme base change; SchemeAndStackFoundations §§1.18–1.22 for stack and quasi-coherent base change; ClusterAlgebras §3.3 for localized mutations over arbitrary rings. GHK, Remark 4.2, p. 162, records the danger of retaining only specialized rational transitions.

### 4.4 Descent of split presentations

In this subsection allow an arbitrary base scheme S, with the preceding affine-base constructions on its affine opens. A descended marked presentation over S consists of a split presentation after an fppf covering family, a comparison on each pairwise fibre product using the permitted seed, grading and boundary transformations, and a coherent descent 2-isomorphism on each triple fibre product. These comparisons must identify the actual exchange domains and section identities. The seed lattices and index sets are transported by the supplied comparisons; a global ordering or a global coordinate frame is not chosen unless the descent data provide it. An étale-local torus form uses an arbitrary étale covering family; no single finite étale splitting cover is asserted.

- Descend the decorated geometric object in the 2-category of algebraic stacks and prove that its pullback recovers the given split presentation. Descend the recognized realization and boundary data. The degree cocycle descends a character local system, and the monoidal line comparisons descend the line system indexed by it as in §3.4. Obtain an ordinary constant-group graded section algebra only with a chosen trivialization of that local system, or a degree-preserving cocycle, and the section-comparison hypothesis of §3.4.
- For an individual torus chart, identify the descended affine form or torus torsor by effective affine descent. For a whole cluster locus, conclude that it is a scheme only when the descended charts give a representable open scheme cover or another supplier criterion proves schemeness; descent of an arbitrary scheme presentation does not by itself supply that conclusion.
- Compare two descended presentations using a common refinement of their base covers and the structured comparisons of §2.1. Keep their descent cocycles, including band and character-line obstructions.
- Descend the X pairing and its relative Poisson bracket with the base-change data, preserving its normalization on every splitting chart. Descend the actual gerbe and its transition equivalences independently of a choice of A decoration.

**Checks.**

- In rank zero, descent of 𝔾_m over ℂ with conjugation acting by inversion on its character lattice gives the norm-one real torus. It need not have a split real character coordinate.
- The complement of the zero section in O(−1) over ℙ¹ is a 𝔾_m-torsor with locally split rank-zero charts. A global coordinate frame would trivialize O(−1), which this descent datum does not do.
- Translating z by a unit c changes 1+z to 1+cz. A purported descent datum using this translation but keeping the exchange section 1+z fixed fails unless its other specified data compensate for that change.

*Needs:* §§1.3–1.5, 2.1–2.2, 3.1–3.4 and 4.1–4.3; SchemeAndStackFoundations §§1.1–1.4, 1.15–1.19 and 1.22 for effective affine, algebraic-space and stack descent. This target concerns supplied compatible descent data, not a classification of nonsplit cluster forms.

### Examples

Regular toric frozen charts and their root stacks provide explicit boundary models. The rank-one family xx′ = 2 gives both loss of a common function field on a fibre and failure of global sections to commute with specialization. A descended rank-zero torus torsor explains why a coordinate must sometimes be treated as a local frame or a line-bundle section rather than as a global function.

### Dependencies

Layers 0–3 supply actual overlaps, coherent descent, quotient presentations and line systems. ClusterAlgebras §3.3 supplies regular toric charts and their scalar change. SchemeAndStackFoundations supplies root stacks, effective descent, dimension and depth. Full toric varieties over a fixed analytic field are not substituted for these arbitrary-base regular charts.

## Layer 5: global comparison, reconstruction and fixed objects

### 5.1 Ordinary upper algebras and an ambient completion

Let C be an integral marked scheme cluster locus over a domain, with dense overlaps and a common marked function field. Compare Γ(C,O_C) with the intersection of its chart rings using §3.3. For the maximal adapted A pattern this is the upper algebra U with the chosen frozen inversions. Given a dense open realization C → Y with Y integral, construct the injective restriction map Γ(Y,O_Y) → U. If Y is normal and Noetherian and Y ∖ C has codimension at least two, prove that this restriction is an isomorphism by the supplied Hartogs theorem. Keep this conclusion distinct from equality of C and Y and from the separate algebraic equality A = U.

For a maximal adapted A atlas over a domain, with the supplier's exchange nonvanishing conditions and all frozen coordinates inverted, prove that the canonical map C → Spec U is an open immersion. The Laurent theorem places every seed coordinate in U. For each seed s, inverting the product of its finitely many coordinates identifies U[(∏_i x_i)⁻¹] with the entire Laurent chart ring R[x_i±1], so each chart maps by an open immersion. The maximal-overlap corollary of §0.2 then proves the global assertion. This recovers GHK, Theorem 3.14, p. 160, by a route using the supplier's Laurent theorem, and does not extend it to arbitrary X loci, quotient stacks or arbitrary actual overlap systems. Where finite-chart computation is desired, use ClusterAlgebras §2.7 with all of its depth and cover hypotheses.

For a Poisson X locus, its Laurent intersection is a Poisson algebra because every chart bracket is the same rational biderivation. If C ⊂ Y is an open in an integral normal affine Noetherian scheme with complement of codimension at least two, use Hartogs to transport this bracket to Γ(Y,O_Y), then localization to construct the unique regular Poisson extension on Y. Its restriction to C agrees by uniqueness on localizations. This is a Poisson-extension theorem under the stated affine Hartogs hypotheses; it does not reconstruct an ambient stack or enlarge the given X locus.

**Checks.**

- Over any field k, set R = k[x,y,z±1]/(xy−1−z). Eliminating z identifies Y = Spec R with Spec k[x,y,(xy−1)⁻¹], a smooth integral surface. The two seed tori cover C = Y ∖ {(0,0,−1)}. The complement has codimension two, so Γ(C,O) = R although C ≠ Y.
- In this rank-one pattern the cluster algebra with z inverted is generated by x, y and z±1, so A = R. The chart intersection and Hartogs comparison give U = R. Thus A = U = Γ(Y,O) does not make the chart union equal to Y.
- The schemes 𝔸² and 𝔸² ∖ {0} have the same global functions over a field. Normality and a coordinate-ring isomorphism alone do not identify a specified open completion with its locus.

*Needs:* §§0.3–0.4, 3.3 and 4.2; ClusterAlgebras §§1.4, 2.3, 2.7 and 3.3 for algebraic inclusions and upper algebras; native affine Hartogs and SchemeAndStackFoundations §0.6. The Poisson extension additionally uses the localization uniqueness in §0.4. The Hartogs input is also Stacks, Tag 0E9I.

### 5.2 Sections across a boundary

Let Y be a normal Noetherian scheme, let j : C → Y be a dense open, and let L be an already given invertible sheaf on Y. Regard a section on C as a rational section of L on each integral component. Prove that it extends to Y exactly when its order is nonnegative at every codimension-one point of Y outside C. Orders use a local frame of L over the corresponding discrete valuation ring, so are independent of that frame. If the complement has codimension at least two, every section extends uniquely. The proof applies reflexive extension and the codimension-one description of sections to L, not an assertion that every line bundle on C extends to an invertible sheaf on Y.

For a normal locally Noetherian algebraic stack and a specified invertible sheaf, prove the corresponding extension criterion on a smooth scheme atlas: test nonnegative orders at all codimension-one boundary points of that atlas. Prove independence of the atlas by smooth pullback and descent of the unique extensions. If the complement has smooth-local codimension at least two, restriction on sections is an isomorphism. This formulation does not assume a common function field for the stack or choose a normalization of stacky divisorial valuations.

Apply these comparisons degree by degree to an actual monoidal line system on Y extending the one on C. The extension isomorphisms preserve multiplication by uniqueness, giving a graded-algebra comparison. For specified frozen-boundary charts, identify the subalgebra of the upper section algebra cut out by the boundary order conditions. Compare with a non-inverted frozen coefficient algebra only after proving that its chart rings and sections are the stated boundary models.

**Checks.**

- For C = 𝔾_m in Y = 𝔸¹ and L = O, the extension condition is ord₀(f) ≥ 0. It cuts k[x] out of k[x±1] and excludes x⁻¹.
- For C = 𝔸² ∖ {0} in Y = 𝔸², there are no missing codimension-one points. Restriction on sections of an existing invertible sheaf is an isomorphism, without identifying C and Y.
- On the root model t = uʳ from §4.1, a character section can be tested by equivariant fppf descent on the u-chart with its line character retained. This chart need not be a smooth atlas when the characteristic divides r. Testing only invariant functions of t cannot recover all graded sections or their stabilizer characters.

*Needs:* §§3.1–3.3 and 4.1–4.2; native affine Hartogs; SchemeAndStackFoundations §0.6 for reflexive sections and depth, §0.30 for normal codimension-one local rings, and §§1.19 and 1.22 for smooth-local descent. Stacks, Tag 0E9I, supplies the depth-two extension input. Existence of an invertible extension of the line system is a hypothesis, not a conclusion of this theorem.

### 5.3 A quotient with doubled points and unchanged functions

Use Y, C and R from §5.1 and let H = 𝔾_m act by h·(x,y,z) = (hx,h⁻¹y,z). Establish all of the following comparisons as a single worked recognition example, over every field k.

The quotient of D(x) is 𝔾_m with coordinate z, since x trivializes the H-torsor; the same holds for D(y). Their actual quotient overlap is 𝔾_m ∖ {−1}, because xy = 1+z. Consequently [C/H] is the scheme obtained by gluing two copies of 𝔾_m along that proper open by the identity. It has two distinct points over z = −1. The full quotient [Y/H] additionally contains the closed substack B𝔾_m over the fixed point (0,0,−1). Its other geometric points have trivial stabilizers.

Compute Γ([C/H],O) = Γ([Y/H],O) = k[z±1], using the equalizer and quotient-weight comparisons. The affine invariant quotient is Spec k[z±1]. It is not a coarse moduli space for [Y/H]: over z = −1 the two nonzero axis orbits and the origin are three distinct geometric isomorphism classes with the same image. The scheme [C/H], the Artin stack [Y/H] and the ordinary torus therefore have the same function ring and different geometry.

Recognize the same quotient directly as a rank-one X atlas: use X=z in one chart, X′=z⁻¹ in the other, zero Poisson pairing, and exchange domain D(1+X). Replacing this overlap by the largest regular domain of inversion identifies the two points over −1 and destroys the moduli locus. The A quotient proves a comparison with this intrinsic X structure; its chosen degrees are retained only when the decorated presentation is requested.

*Needs:* §§0.2, 1.1–1.4, 2.3, 3.2–3.3 and 5.1; SchemeAndStackFoundations §1.20 for inertia and §1.23 for the geometric-point condition in the definition of a coarse moduli space. The calculations use only the displayed equation and action. In characteristic two, −1 = 1 remains an invertible value, so the same distinction persists.

### 5.4 Automorphisms, extension and fixed objects

A structured automorphism of a realized pair is a self-equivalence in §2.1 preserving the required seed, line and boundary data up to their specified coherent comparisons. Invertible chartwise monomial maps of §2.2 provide such automorphisms when their diagram comparisons identify the marked atlas. Its restriction to C, its action on the section algebra with its character data and its action on inertia are separate comparison maps. A mutation word returning to an isomorphic seed defines an automorphism only through its supplied geometric action; a loop in a word presentation is not an automorphism of every moduli object.

- For an integral normal affine Noetherian scheme Y and C ⊂ Y with complement of codimension at least two, prove that every automorphism of C extends uniquely to an automorphism of Y. Use Γ(Y,O) ≅ Γ(C,O), affine reconstruction and the naturality of the map to Spec Γ; apply the same argument to the inverse. The Lean headline is `extendAutomorphism_of_codimension_two`, using the native normal-scheme predicate and point coheight for the codimension hypothesis. Preservation of a chosen frozen model or line system requires that data to be preserved as well.
- For an algebraic stack C and an actual automorphism F, construct the fixed-object stack as the 2-fibre product of (id,F) : C → C × C with the diagonal. Its objects are pairs (x,α : x ≅ F(x)). Prove functoriality under structured conjugacy, with all 2-isomorphisms retained.
- For a specified action of a finite cyclic group of order r, identify the equivariant-object stack by imposing the additional relation Fʳ⁻¹(α) ··· F(α) α = id using the chosen comparison Fʳ ≅ id. The fixed-object stack for one automorphism alone does not impose this relation.

**Checks.**

- The codimension bound is needed: inversion on 𝔾_m does not extend to 𝔸¹. Normality is also needed: for A = k[x²,x³,y,xy] ⊂ k[x,y], normalization is an isomorphism away from the origin, since x = x³/x² on D(x²) and x = xy/y on D(y). Swapping x and y acts on the punctured surface, but an extension to Spec A would send y ∈ A to x ∉ A.
- Affineness is needed: take Y = ℙ² ∖ {q} and C = ℙ² ∖ {p,q} for distinct k-rational points p,q. A projective automorphism interchanging p and q preserves C but cannot extend to Y. Any such extension, composed with Y → ℙ², would equal the original projective map by density and separatedness, and would send p to the omitted point q.
- If F = id on C, its fixed-object stack is the inertia stack I(C). For C = BG this is [G/G] under conjugation, not just BG; for commutative G it is G × BG.
- For C = 𝔾_m and F(x) = x⁻¹, the fixed scheme has ring k[x±1]/(x²−1). The invariant ring k[x+x⁻¹] describes a different construction, and in characteristic two the fixed scheme is nonreduced.
- For the identity automorphism of B𝔾_m, an object of the fixed-object stack includes an arbitrary scalar automorphism. A trivial cyclic action of order r instead requires that scalar to satisfy aʳ = 1. Forgetting the cyclic relation gives the wrong equivariant objects.

*Needs:* §§2.1–2.3, 3.1 and 5.1–5.2; SchemeAndStackFoundations §§1.18–1.20 for 2-fibre products and inertia; Mathlib affine scheme reconstruction. The automorphism extension theorem is restricted to schemes with the stated affine and Hartogs hypotheses; no reconstruction of a general stack from its ordinary ring is asserted.

### Examples

The rank-one exchange surface simultaneously verifies chart recognition, a codimension-two remaining locus, equality of cluster and upper algebras, homogeneous quotient descent, a nonseparated quotient locus, and a stack completion with extra inertia. The family xx′ = 2 separates geometric base change from upper-algebra base change. The root model and the real nonneutral gerbe show independently why boundary stabilizers and line descent cannot be read from ordinary function rings.

### Dependencies

Layers 0–4 supply the realized and boundary data, structured maps and graded sections. ClusterAlgebras supplies the ordinary algebraic comparison. Native Hartogs and SchemeAndStackFoundations §0.6 supplies extension of existing sheaf sections. SchemeAndStackFoundations §§1.18–1.23 supplies inertia, fixed-object fibre products and the meaning of a coarse moduli space. No categorical, derived or scattering-theoretic recognition theorem is required.

## Layer 6: undecorated double Bott–Samelson stacks

### 6.1 The undecorated moduli stack and its presentations

Let k be a characteristic-zero field and G a pinned split connected reductive k-group with maximal torus T_G and opposite Borels B_+,B_-. Take arbitrary finite positive words i=(i₁,…,i_m) and j=(j₁,…,j_n), including empty words and repetitions. Define Z_(i,j) as the scheme of chains F⁺₀,…,F⁺_m and F⁻₀,…,F⁻_n whose consecutive relative positions are exactly s_(i_l) and s_(j_k), and whose initial pair and terminal pair are opposite. Use the supplied incidence schemes with their open exact-position conditions. Define the undecorated double Bott–Samelson stack independently of seeds, decorations or Poisson coordinates by

    𝔅_G(i,j) = [Z_(i,j)/G].

On a test scheme S its objects are G-torsors P with those two chains of Borel reductions in the associated flag bundles; its arrows are the torsor isomorphisms carrying every reduction to its counterpart. Construct pullback, its coherence and fppf descent. This moduli problem is the fixed target throughout this layer. A cluster atlas is constructed on this same stack; its complement is retained.

Evaluation at the initial opposite pair gives Z_(i,j) → G/T_G. Let V_(i,j) be its fibre over the standard pair (B_+,B_-). Prove the G-equivariant associated-bundle isomorphism and the induced stack equivalence

    Z_(i,j) ≅ G ×^(T_G) V_(i,j),
    𝔅_G(i,j) ≃ [V_(i,j)/T_G].

For an arbitrary S-object the opposite Borel reductions give a T_G-reduction Q of P; the remaining flags give a T_G-equivariant map Q → V. Extension of structure group takes (Q,Q→V) back to the original object. Verify the inverse comparisons on arrows and under pullback. This is a presentation of the full original stack, including nontrivial torsors, rather than a choice of a global trivialization or an open subproblem.

Construct this fibre explicitly. Let dot{s}_i be the image of the matrix with rows (0,−1),(1,0) under the pinned SL₂ homomorphism, with a sign adapter if the supplied representative differs. Put p_i⁺(a)=e_i(a)dot{s}_i, p_i⁻(b)=e_(−i)(−b)dot{s}_i, g_l=∏_(r≤l)p_(i_r)⁺(a_r), h_k=∏_(r≤k)p_(j_r)⁻(b_r), w_l=s_(i₁)⋯s_(i_l) and v_k=s_(j₁)⋯s_(j_k). Prove that these products parametrize the exact-position chains from the standard initial flags. Final opposition is h_n⁻¹g_m ∈ B_-B_+. Thus

    V_(i,j) = D(f) ⊂ 𝔸^(m+n),
    f = ∏_ω Δ_ω(h_n⁻¹g_m),

where the normalized principal minors for the fundamental weights are evaluated in the simply connected group before passing to the chosen group form. Their root-coordinate polynomials and their common nonvanishing condition descend to every specified G. Prove that f is not the zero polynomial. Deduce that V is smooth, geometrically integral and affine of dimension m+n. Its residual action is diagonal with weights w_(l−1)α_(i_l) on a_l and −v_(k−1)α_(j_k) on b_k; prove that Δ_ω(h_n⁻¹g_m) is semi-invariant of weight v_nω−w_mω. These are prefix-root weights; the different node coordinates in §6.2 have their own simple-root weights.

- Let J be the simple-root support of the words. Prove that the displayed coordinate weights generate Q_J integrally by induction through the prefixes. Construct the full inertia scheme over V by the equations (χ(a_l)(t)−1)a_l=0 and (χ(b_k)(t)−1)b_k=0. Its quotient by T_G is the inertia of 𝔅_G, with T_G acting trivially on the t-coordinate. The globally ineffective kernel and generic stabilizer are K_J=D(X*(T_G)/Q_J); the same equations allow larger stabilizers elsewhere. In families the coordinates are sections of the character lines associated to Q, and these equations are equations in those lines.
- Prove endpoint-preserving braid-move isomorphisms of the open chain schemes and their composition coherence. Their equivariance gives comparisons of the original moduli stacks, so the construction depends on positive braids b,d with their specified presentation comparisons. Their Weyl-group images alone do not determine the object.
- For the simply connected semisimple form G_sc, decorate F⁺₀ by A⁰ in G_sc/U_+ and F⁻_n by A_n in U_-∖G_sc. Construct the commuting H=T_sc×T_sc torsor Z̃ → Z, with (t_+,t_-)·(A⁰,A_n)=(A⁰t_+,t_-A_n) and with g acting on A_n by right g⁻¹. Construct the scheme D=Z̃/G_sc using the mixed pinning and endpoint root coordinates. It is a nonempty principal open in T_sc×𝔸^(m+n), smooth affine and geometrically integral of dimension rank(G_sc)+m+n. The same construction for the adjoint form gives D_ad. These are auxiliary presentations of the independently defined moduli problem.
- Construct [D/H] ≃ 𝔅_(G_sc)(i,j) from the commuting torsors, on families and arrows. The map D → 𝔅_(G_sc) is the actual endpoint-decoration H-torsor, with its character lines from §3.2. The mixed pinning makes the G_sc-action on Z̃ free; it does not make the H-action on D free.

**Checks.**

- For two empty words V=Spec k, Z=G/T_G and 𝔅_G=B T_G, of dimension −dim T_G. Its single geometric orbit does not determine this stack. In the simply connected decorated presentation D=T_sc and (t_+,t_-)·a=t_-at_+.
- For type A₁ with both words (s), compute h₁⁻¹g₁ with rows (1+ab,−b),(−a,1). The full undecorated stack is [Spec k[a,b,(1+ab)⁻¹]/T_G], with weights (+α,−α). The point a=b=0 belongs to this moduli problem and has stabilizer T_G. This is a double-word test with neither chain empty.
- For lower word s² and upper word empty, f₂=b₁b₂−1. The coordinates x=b₁, y=b₂/f₂ and z=1/f₂ satisfy xy=1+z and recover the four-flag presentation of §6.5. For lower word s the three lines are pairwise distinct and have common stabilizer μ₂ for SL₂. Empty words and s² have the same Weyl-group image but different dimensions.
- In characteristic zero take S=ℙ¹, a residual SL₂ torus torsor corresponding to L=O(1), a section x of L² with two simple zeros, y=0 in L⁻² and z=−1. The equation xy=1+z gives a family in the full four-flag stack. Its inertia is μ₂ away from those zeros and 𝔾_m at them. It has no global torus trivialization and does not factor through the cluster locus. Verify it using the torsor-and-reductions definition above.

*Needs:* SchubertGeometry S1.2, S1.4 and S2.1–S2.4; ReductiveGroups Layers 3, 7, 7C, 8 and 9D; ClusterAlgebras §6.1 for the minors detecting opposition; SchemeAndStackFoundations §§1.14–1.21 for torsors, actions and quotient comparisons. SW21, Definitions 2.17–2.21, Theorem 2.18, Proposition 2.26 and Theorem 2.30, supply the flag and decoration proof sources. The associated-bundle equivalence, prefix-root weights, full inertia equations and nontrivial family test are proved from the displayed constructions.

### 6.2 Direct X coordinates and the full chamber-minor comparison

Use the coroot-row Cartan convention C_ij = ⟨α_j,α_i∨⟩, so α_j = Σ_i C_ij ω_i. Prove the adapter to Mathlib's root-row, coroot-column Cartan matrix: C is its transpose. The nonsymmetric cases use this adapter before applying any native matrix identity.

Construct a seed from a triangulated trapezoid with top intervals labelled by i and bottom intervals by j. Put a node on the corresponding simple-root level in each triangle; strings are the horizontal segments cut by those nodes. Every string is a vertex, the strings with two node endpoints are mutable, and the boundary strings are frozen, including an uncut level when its root never occurs. For a positive bottom node of level i between its left and right strings a,b, put ε_ab = −1 and ε_ba = 1. For a string c of level j ≠ i crossing that triangle put ε_ac = −C_ji/2, ε_bc = C_ji/2, ε_ca = C_ij/2 and ε_cb = −C_ij/2, where C is the Cartan matrix. Reverse these contributions for a top node, put all other contributions zero, and sum over nodes. Choose once on each original Dynkin component the positive integer right symmetrizer d with C_ij d_j = C_ji d_i and gcd one; put d_a=d_i on level i. Set ω_ab=ε_ab/d_b and B_ak=ε_ka. Keep these inherited weights on the unfrozen sublattice, even when their gcd there exceeds one. Prove mutable integrality and skewness of ω; frozen–frozen half entries do not enter an A exchange.

Construct the X coordinates first from the underlying flags. Normalize the initial opposite pair and retain its residual torus action. On the open where the triangulation diagonals are opposite, reconstruct the successive root factors e_i(q) or e_(−i)(p), with nonzero node parameters. In the adjoint form use the fundamental coweights to factor e_i(q)=q^(ω_i∨)e_i(1)q^(−ω_i∨) and e_(−i)(p)=p^(−ω_i∨)e_(−i)(1)p^(ω_i∨). Multiply the factors bordering each closed string. If its two node parameters are u_l,u_r with signs σ_l,σ_r for their positive or negative root factors, the resulting coordinate is X_a=u_l^(−σ_l)u_r^(σ_r). It is invariant under the residual torus. The consecutive-node exponent vectors form an integral basis of the weight kernel, so these coordinates give the effective torus, with the actual residual stabilizer retained as its gerbe band.

Prove the flip and braid formulas for these intrinsic coordinates on the flag-incidence opens. They are the unfrozen X mutations, and their Poisson bracket is {X_a,X_b}_P=ω_ab X_aX_b. Apply §0.4 to prove compatibility and glue their brackets. The full adjoint decorated X chart also has open-string coordinates; forgetting decorations projects to the closed-string character sublattice. It does not specialize the frozen X coordinates to one. Pinning, cyclic order and the chosen right symmetrizer fix the sign and scale. The following A construction proves that every further mutation seed is realized and compares its quotient with these direct charts.

Propagate the two endpoint decorations along their chains. For a string of level i crossing the diagonal between F⁺_l and F⁻_k, define its chamber function as Δ_(ω_i)(A_k,A^l). Prove independence of the crossed diagonal and construct the principal open where all chamber functions are nonzero as its full seed torus, with a regular reconstruction of the configuration. On a diagonal let w_l = s_(i₁)⋯s_(i_l) and v_k = s_(j_(k+1))⋯s_(j_n). With (wλ)(t) = λ(w⁻¹tw), prove the actual H-degree formula

    deg Δ_λ(A_k,A^l) = (w_l λ, v_k⁻¹ λ).

Thus degrees are derived from the decoration action. Prove the homogeneous exchanges with these degrees, the rank-one flip formulas and the rank-two braid comparisons in all finite Cartan types, on their actual domains. Pinning and word changes carry their specified chart comparisons.

- For the triangulation with all top steps preceding all bottom steps, construct each adjacent mutation chart, including mutations not given by a single triangulation flip. Prove that its coordinate functions are regular on D and that its principal open has exactly the corresponding Laurent ring. Prove that the initial and adjacent opens contain every codimension-one point, using the irreducible minor divisors and a nonempty adjacent-chart open in each such divisor.
- Prove full column rank of this seed's mutable extended matrix, with the empty-column case included. Use the independent consecutive-node ratios or products and their exchange-column exponents for the direct rank calculation. Smoothness supplies the depth bound. Apply ClusterAlgebras §2.7 to the initial and adjacent charts and §2.1 to their upper bound to obtain Γ(D,O_D) ≅ U with all frozen coordinates inverted. Verify the hypotheses of those comparisons on the constructed minors.
- For every mutation-word seed s, use Laurentness and the affine identification to prove Γ(D,O_D)[(∏_a A_(s,a))⁻¹] = k[A_(s,a)±1]. This constructs every full A torus T_s as an H-invariant open of D, including seeds beyond the triangulation family. Take its overlaps to be T_s ×_D T_t and prove the marked identities. On invariant characters prove that the ensemble monomials are precisely the direct closed-string X coordinates and obey the X mutation formula. Apply §§0.1–0.3 and 5.1 to obtain C_D ⊂ D. The integral quotient recognition in the following subsection then obtains every full intrinsic X chart and its gerbe; neither locus is required to exhaust its ambient space.

Construct these comparisons over the pinned rational model and transport them to k, using ReductiveGroups Layer 9D and faithful flat descent when a complex proof is used. No embedding of k into ℂ is assumed. An all-characteristic chart theorem is not inferred from this scalar-change argument.

**Checks.**

- An uncut root level contributes one frozen A coordinate. For two empty words D = T_sc, with r frozen A variables and no mutable variable. The intrinsic unfrozen X torus is a point with gerbe B T_sc; the unused-root A strings do not create undecorated X coordinates.
- For C with rows (2,−1), (−2,2), the right multipliers are (1,2). A level-1 node crossed by a level-2 string contributes ε_ac=1 and ε_ca=−1/2, hence ω_ac=1/2 and ω_ca=−1/2. Using the left symmetrizer (2,1) in this convention would fail skewness.
- For SL₂ with lower word s², choose compatible lower covectors with det(w₀,w₁) = det(w₁,w₂) = 1 and top vector v. Put p = w₀(v), q = w₂(v), A = w₁(v), A′ = det(w₀,w₂). Then w₀+w₂ = A′w₁ gives AA′ = p+q, with p,q invertible. In order (A,p,q), the mutable column is (0,1,−1). The degrees are deg A = (1,−1), deg p = deg q = (1,1), deg A′ = (0,2); both sides of the exchange have degree (1,1).
- The type A₂ minor identity Δ_(12,12) Δ_(23,23) = Δ_(12,23) Δ_(23,12) + g₂₂ on SL₃ has the required positive sign. On the matrix with rows (1,1,0), (1,2,1), (0,1,2), of determinant 1, it reads 1·3 = 1·1+2. Its restriction to the relevant configuration chart must preserve these pinned minor normalizations.
- In the preceding SL₂ seed, the initial and adjacent charts omit A = A′ = 0, p = −q, a nonempty codimension-two subset. The upper-algebra identification therefore cannot be used to claim that the seed charts cover the whole decorated scheme.

*Needs:* §6.1; §§0.1–0.4, 1.1–1.4 and 5.1; ClusterAlgebras §§1.1–1.4, 2.1, 2.3, 2.7, 3.1–3.5 and 6.1; ReductiveGroups Layer 9D for rational-model transport. SW21, §§3.1–3.2, Lemma 3.10 and Definition 3.13, supply the direct X construction; Propositions 3.23 and 3.25, Lemma 3.37, Proposition 3.42 and Theorem 3.45 supply the A chamber and finite-chart proofs. The full geometric atlas follows by localization and the invariant-character comparison.

### 6.3 Forgetting decorations and retaining the group form

Retain the direct X coordinates and the auxiliary decorated D and C_D from §6.2. To include split reductive group forms, specify G = (G_sc × Z₀)/K, where Z₀ is a split central torus and K is a finite central subgroup scheme, with compatible pinned root data. The raw flag-configuration scheme Z is the same one, and 𝔅_G(b,d) = [Z/G]. Set H₀ = T_sc × T_sc × Z₀, let Z₀ act trivially on D, and embed K by (z,c) ↦ ((z,z⁻¹),c). It acts trivially on D. Put H_G = H₀/K and Λ_G = ker(X*(H₀) → X*(K)). The following comparison realizes the intrinsic X atlas on the independently defined moduli stack; §6.4 constructs its full ambient Poisson datum.

- Construct the equivalence [D/H_G] ≃ 𝔅_G(b,d) using the common torsor E = Z̃ × Z₀. It is a G_sc × Z₀-torsor over D and an H₀-torsor over Z; the two indicated K-actions coincide. The fppf quotient E/K is a common torsor for the quotient groups and induces the equivalence on families and arrows. Prove its compatibility with the endpoint decorations and field extension. This construction retains K scheme-theoretically.
- Prove that each degree map from §6.2, with zero Z₀-component, lands in Λ_G. Descend the full invariant atlas to representable open charts [T_s/H_G] → 𝔅_G(b,d). For V_st = T_s ×_D T_t prove the exact overlap [T_s/H_G] ×_(𝔅_G(b,d)) [T_t/H_G] ≃ [V_st/H_G]. Identify each chart as the gerbe over its direct X torus by the integral sequence below. Its invariant overlap is the pullback of a unique open W_st in that torus; construct this open and identify its map with the X transition. The pairing is the fixed ω of §6.2. Thus §§1.2–1.4 recognize [C_D/H_G] as a dense gerbe-valued X locus with exact overlaps and transverse Poisson comparisons. This is the atlas part of the main theorem; §6.4 supplies Π_G on the full ambient stack. Its complement can contain larger stabilizers.
- Let J be the set of simple roots occurring in either word, Q_J their integral span in X*(T_G), and M_(X,s) the free lattice on the mutable X-coordinates. Prove the exact integral sequence 0 → M_(X,s) → L_s → Λ_G → X*(T_G)/Q_J → 0, where the first map sends an X-character to its ensemble monomial, with exponent column B_•k, and the middle map is d_s. Put P = X*(T_sc), identify X*(T_G) with its sublattice of P ⊕ X*(Z₀), and let w_b be the Weyl-group image of the top word. The last map sends (λ,μ,ν) to the class of (λ−w_b μ,ν); the Weyl action on central characters is trivial, so this element lies in X*(T_G). Thus chart functions have character lattice ker d_s ≅ M_(X,s), while chart inertia is D(coker d_s) ≅ ⋂_(i∈J) ker(α_i : T_G → 𝔾_m). This can contain a positive-dimensional torus and a finite nonreduced part in the explicit characteristic-p models. Prove mutation compatibility and identify this group with the scheme-theoretic intersection of the configuration's Borels on the chart; the intersection can grow outside the cluster locus.
- For a further central quotient G → G/K′, identify 𝔅_G(b,d) → 𝔅_(G/K′)(b,d) as the gerbe of lifting the actual torsor through that central extension, with relative band K′. Do not assert a neutralization without a section. Apply §3.2 to the actual H_G-torsor D → 𝔅_G(b,d): its Λ_G-labelled character sections recover Γ(D,O_D), while ordinary functions recover only the invariant part. Compare these lines and their exchanges on all chart overlaps.

For the cokernel calculation, use chamber degrees to eliminate the terminal graph of the Weyl action. Consecutive chamber degrees differ by top prefix or bottom suffix roots, generating Q_J integrally by reflection induction. For the kernel, compare the chamber torus with the same torus reconstructed by nonzero node parameters and terminal decoration. The regular inverse makes the exponent change unimodular. After removing decoration, the parameters have signed simple-root weights; consecutive-node ratios or products give a primitive basis of the kernel and are precisely the direct X coordinates. This proves the integral torus comparison and transports X mutations. The Poisson form comes from those X seeds, not from a purported canonical bracket on A coordinates. No overlap is enlarged by this comparison.

In the adjoint form, simple roots are a basis of X*(T_ad). The fixed support J gives T_ad = T_J × T_unused by their dual cocharacters. In the normalized flag slice every root factor belongs to J, so T_unused acts trivially on the entire slice. On its cluster part T_J acts freely, giving 𝔅_ad^cl ≃ X_eff × B T_unused. Construct X_eff from the actual X torus charts; it can be nonseparated. All seed changes use the same support splitting. General group forms retain the finite central-gerbe comparisons from G_sc and the extra central torus. With full support and semisimple G the bands are finite étale in characteristic zero, so §1.5 gives ordinary Poisson Deligne–Mumford stacks. With positive-dimensional center or incomplete support the atlas retains the displayed torus band, and §6.4 supplies its full Poisson enhancement from the specified global quotient presentation.

The two-endpoint pattern is one A decoration of the intrinsic X structure. A normalization slice, a free added decoration factor, or another torsor presentation induces the same X structure when its gerbe, direct X characters, pairing and actual transitions are identified. Apply §2.1 to those comparisons. Retain the larger A lattice and character lines only in the stronger decorated comparison of Layer 3.

**Checks.**

- With empty words and G = G_sc, the degree map is λ ↦ (λ,λ), whose cokernel is X*(T_sc); the stack is B T_sc. Generic inertia cannot be declared to be the finite center for words of incomplete support.
- For the SL₂ seed (A,p,q) of §6.2, the degree image is the sublattice of ℤ² where the two coordinates have equal parity. Its cokernel is ℤ/2ℤ, giving μ₂. Passing to PGL₂ changes the acting character lattice to that parity sublattice, so the resulting degree map is surjective and the quotient chart is a scheme. Tensoring both degree maps with ℚ would hide this distinction.
- For G = GL₂ use (SL₂ × 𝔾_m)/{(ζI,ζ⁻¹): ζ∈μ₂}. A configuration of three distinct lines has stabilizer the scalar 𝔾_m; its undecorated stack is B𝔾_m. The same ordered-line configuration gives a point for PGL₂ and Bμ₂ for SL₂. The reductive center is retained by the extra Z₀ factor.

*Needs:* §§0.4, 1.1–1.5, 2.1–2.3, 3.1–3.4 and 6.1–6.2; ReductiveGroups Layers 3, 8 and 9D for root lattices and central quotients; SchemeAndStackFoundations §§1.14–1.21 for common torsors and relative inertia. SW21, Proposition 2.26 and §6.1, supply the decoration quotient, and Lemma 3.10, Definition 3.13, Corollary 3.22 and Proposition 3.43 supply the node and ensemble comparisons. The support splitting, group-form comparison and intrinsic X recognition are the displayed constructions.

### 6.4 Poisson structure on the whole undecorated stack

For every G and pair of words of §6.1, construct a cluster Poisson structure in the full sense of §1.7 on the fixed moduli stack 𝔅_G=[Z/G]. The output is (𝔅_G,Π_G,C_G→𝔅_G), where C_G=[C_D/H_G] is the locus recognized in §6.3. Its Poisson datum Π_G is defined on all of 𝔅_G, including points with larger inertia. Neither the effective X scheme nor C_G is substituted for the moduli stack. The construction uses full decorated X coordinates as a source of a global invariant bivector, and then proves their comparison with the undecorated charts.

- On the adjoint decorated scheme D_ad of §6.1 construct the full X torus from all strings of §6.2, including the open strings. Give the actual coordinate reconstruction and the full log-canonical bracket with the fixed ω and inherited d. Derive the frozen monomials from the retained endpoint action and the terminal formula A_n=U_-t⁻¹g⁻¹; any inversions in a source's decoration convention require an explicit adapter. The closed-string sublattice and its bracket identify the invariant coordinates of the undecorated charts. The projection to them does not supply a bracket on the full decorated scheme by smooth pullback.
- Put C₀=Z(G_sc). Construct the map p_fin : D_sc → D_ad induced by the central isogeny as a finite étale C₀-torsor. On the decorated configuration spaces the kernel is C₀²; the common group action removes c↦(c,c⁻¹), leaving C₀²/C₀,anti≅C₀. Perform these quotient and torsor comparisons on scheme tests and descend through the free adjoint-group action. This finite map is distinct from the positive-dimensional ensemble map to the unfrozen X torus.
- Identify the image of the initial A torus under p_fin with the full adjoint X torus using both the closed-string and open-string monomial formulas. Construct the adjacent full X charts by the mutation-compatible finite-index lattice map, preserving its integral cokernel. Each initial or adjacent A open is C₀-invariant and saturated, and its image has that open as its full preimage. Therefore their image union U_X⊂D_ad has complement of codimension at least two, by the codimension estimate of §6.2 and finite étale pullback. Glue the full X brackets on U_X and extend to D_ad by the smooth affine scheme theorem of §5.1. This constructs the regular Poisson bivector π_ad on the entire decorated scheme without assuming that its cluster charts cover it.
- Compute the endpoint-torus coactions on the full X characters from the node and terminal-decoration formulas. Prove that all these characters are semi-invariant and that the closed-string characters have degree zero. Since a log-canonical bracket respects these character coactions, the H_ad-action with zero torus bracket is Poisson on U_X. Equality of regular bivectors on the dense open of the smooth scheme D_ad proves it globally. Pull π_ad back uniquely along p_fin to π_sc, prove H_sc-invariance by the same coaction comparison, and extend to the H₀-action with trivial Z₀-factor. The action factors through H_G and remains Poisson by faithfully flat descent.
- Apply §1.6 to the specified invariant bivector on D_sc and H_G. Transport its Maurer–Cartan datum through the full equivalence [D_sc/H_G]≃[Z/G] from §6.3 to obtain Π_G. For every reachable seed, transport the full-X finite-index monomial comparison through its mutation word and prove that π_sc restricts to a constant log-canonical numerator bivector with the prescribed closed-string form ω. Apply §1.6 to construct the standard étale-local π_X+0 gerbe-model comparisons, retaining their paths and coherence. Thus every chart satisfies the full condition of §1.7, not only equality of its scalar bracket. This supplies the enhancement for positive-dimensional bands and boundary inertia as well as for finite étale bands.
- Prove compatibility with scalar extension, specified braid comparisons and changes of pinning that preserve the stated form and sign conventions. Prove equality of regular bivectors on D_ad from the full X formulas, extend that equality on the smooth scheme, and only then transport through finite étale pullback and the quotient comparison. Equality on the dense undecorated cluster open alone does not prove equality on the entire stack. For central changes of G, use the same numerator D_sc and its compatible actions to construct the full Poisson comparisons, preserving the actual relative gerbe and its band.

Prove the dimension and inertia comparisons simultaneously with recognition: dim 𝔅_G=m+n−dim T_G, each effective X torus has dimension m+n−|J|, and its band K_J has dimension dim T_G−|J|. The integral group scheme K_J and the full inertia equations of §6.1 are part of the comparison. The full theorem applies with incomplete root support, connected center and nonneutral central gerbes. No free-action hypothesis is added to the original moduli problem.

**Checks.**

- Empty words give the full rank-zero object B T_G with the zero Poisson datum, not a point. A one-step SL₂ word gives Bμ₂; for GL₂ the same three-line moduli problem gives B𝔾_m. The respective classifying-stack factors remain in the output.
- For the four-flag SL₂ stack of §6.5 the full datum is induced by (xy−1)∂x∧∂y and has nonzero leading class at the residual B𝔾_m, while the entire cluster locus has zero bracket. A construction returning the zero ambient structure would pass the scalar X tests and fail this full-stack test.
- The two words (s),(s) in type A₁ give the same four-flag Poisson quotient model by x=b, y=−a, z=−(1+ab), with the same residual-torus parameter. The alternative stack isomorphism x=a, y=−b reverses the perimeter orientation and is anti-Poisson in these conventions. Verify the full Poisson comparison, not just an isomorphism of the underlying stacks.
- The ℙ¹-family of §6.1 is an object of this same Poisson moduli stack throughout the inertia jump. It is not required to define a Poisson morphism from ℙ¹; the test concerns the underlying moduli functor and its full Poisson datum. Restricting the target to C_G would incorrectly remove two fibres of the family.
- If a nonzero skew pairing is rescaled, repeat the construction with that rescaled pairing and record the changed Π_G. The underlying flag stack is unchanged, but a fixed normalization is part of its Poisson structure.

*Needs:* §§0.4, 1.6–1.7, 2.1–2.3, 5.1 and 6.1–6.3; ReductiveGroups Layer 9D for the central isogeny; native étale differential transport and smooth affine Hartogs. SW21, Propositions 3.43–3.44, the following full-torus comparison, Appendix A.2 (Proposition A.28 and Remark A.29) and Theorem 3.46, supply the full-X proof route with the stated convention adapters. The torsor, coaction and Cartan-quotient steps are constructed here. SW21, Remark 1.11, concerns equality with an independently defined Lu–Mouquin flag-product bracket; that equality is not inferred from this construction.

### 6.5 Four flags: the full stack, its Poisson datum and its cluster locus

In this subsection work over any field k. Construct the type A₁ incidence schemes by their explicit equations over ℤ and base change them; these computations are independent of the characteristic-zero theorem of §6.2. Take upper word empty and lower words e,s,s². Normalize the initial opposite lines to (∞,0) by the associated-bundle isomorphism Z ≅ G ×^T V; prove this isomorphism on scheme tests, not only on k-points. It gives [Z/G] ≃ [V/T]. For s² write the two subsequent lower lines as ⟨(1,−x)⟩ and ⟨(−y,1)⟩. Their being distinct is 1−xy ≠ 0, so

    V = Spec k[x,y,z±1]/(xy−1−z),     z = xy−1.

Parametrize the PGL₂ residual torus by λ acting as (x,y) ↦ (λx,λ⁻¹y), and the SL₂ torus by diag(h⁻¹,h); its action is (x,y) ↦ (h²x,h⁻²y). The central comparison is λ = h². Relate this slice to the actual decorated minors of §6.2 by x = Ap, y = A′/(pq), z = p/q and c = q. These are invertible frozen-monomial changes on each seed chart, with xy = 1+z. The decoration action is (u,v)·(x,y,c) = (u²x,u⁻²y,uvc). Replacing the torus parameters by (u,w = uv) removes the free c-factor from the quotient and proves the stated slice comparison while retaining the original minor markings.

Establish the following comparisons as one worked recognition result.

- The cluster slice is C = D(x) ∪ D(y). For PGL₂ its quotient Q is the two copies of Spec k[z±1] glued by the identity only on D(1+z), as in §5.3. In unfrozen X coordinates z and z⁻¹ the transition is inversion on this same proper open. Enlarging it to the whole regular domain of inversion would identify the two points over z = −1 and give the wrong undecorated locus.
- Recognize this directly as the rank-one X structure with zero pairing and exchange domain D(1+X). The gerbe lifts give the intrinsic SL₂ charts; when 2 is invertible §1.5 identifies them with Poisson Deligne–Mumford charts. This zero transverse bracket tests the effective rank-one X chart. The full-stack Poisson calculation below is nonzero and is detected at the larger-inertia boundary; the three-step example additionally tests a nonzero scalar bracket.
- For SL₂ each quotient seed chart is 𝔾_m × Bμ₂. The full quotient has residual gerbe B𝔾_m at x = y = 0, z = −1, and inertia μ₂ on C. Identify its central map to the PGL₂ quotient as the gerbe of lifting the residual torus torsor through squaring. The equations (h²−1)x = (h²−1)y = 0 compute its inertia scheme, including its nonreduced fibres.
- Prove that the μ₂-gerbe over Q is nonneutral. On the two quotient charts the torsor has sections s_x = (1,z+1) and s_y = (z+1,1), with s_y = (z+1)·s_x. Since the charts have trivial Picard group, line-bundle gluing gives Pic(Q) ≅ k[z±1,(z+1)⁻¹]ˣ/(k[z±1]ˣ · k[z±1]ˣ) ≅ ℤ. The associated weight-one line has transition (z+1)⁻¹ and represents a generator. It has no square root, so there is no global lift of the torsor. Compute the overlap equivalence between the locally neutral μ₂-gerbes by this square-root torsor; gluing them by the trivial equivalence would give a different stack.
- Compute Γ([V/T_PGL₂],O) = Γ([V/T_SL₂],O) = k[z±1], and the same equality for their cluster loci, using the actual coactions and §3.2. Over z = −1, the two nonzero axis orbits and the origin have the same invariant value and are three distinct geometric isomorphism classes. This affine invariant scheme is not a coarse moduli space for either full quotient.


In characteristic zero verify the full Poisson datum of §6.4 before restricting to these charts. Fix A⁰=e₁ and write the final simply connected decorated covector as c(1,y), so c=q in the preceding presentation. The root-factor product is g=e_+(−y), and A_n=U_-t⁻¹g⁻¹ gives t_sc=diag(c⁻¹,c). Thus the adjoint terminal parameter is C⁻¹ with C=c². This fixes its reciprocal convention geometrically. The three full X characters, with unit weights and the bottom-node orientation, are

    (U,X,W)=(-1/x, z, -x/(zC)),
    {U,X}_P=−UX,    {X,W}_P=−XW,    {U,W}_P=0.

Prove these formulas directly from the node parameters −1/x and −z/x and the endpoint decoration. They give {x,z}_P=xz, {x,C}_P=−xC and {z,C}_P=0, hence {x,y}_P=z and {y,C}_P=yC. The finite étale pullback C=c² gives the regular invariant bivector

    π_D = z∂x∧∂y − (1/2)(x∂x−y∂y)∧c∂c.

The mixed term is an endpoint-vertical bivector. Remove it by the explicit Cartan comparison of §1.6, then remove the free c-torus factor by its torsor comparison. Under [Z/G]≃[V/T_G] the full Poisson datum is therefore represented by

    π_V=(xy−1)∂x∧∂y,
    {x,y}_P=z,    {x,z}_P=xz,    {y,z}_P=−yz.

Verify regularity, Jacobi and invariance under the weight-(1,−1) and weight-(2,−2) actions directly. This tensor is nondegenerate on V since z is invertible; the quotient stack is not thereby asserted to be symplectic. On C its effective quotient is a curve and the induced Poisson structure is zero, including on the finite étale SL₂ gerbe. At o=(0,0,−1), however, the action tangent complex [Lie T_G→T_oV] has zero differential. The leading class of π_V is −∂x∧∂y, nonzero and invariant. Prove that it cannot be changed to zero by a Maurer–Cartan equivalence. Thus the zero ambient structure and Π_G have the same entire cluster atlas but are different Poisson structures on the original undecorated stack. This is a required test of the definition itself.

For the genuinely double pair (s),(s), put f=1+ab and write the final decorated covector as c₀(b,1). On the top-first triangulation the root parameters are p=1/a and q=−a/f. Solving the terminal-decoration formula gives the full adjoint X characters (U,X,W)=(a,−1/f,−a/(fC)), where C=c₀². The node form has ε_UX=+1, ε_XW=−1 and ε_UW=0. Compute

    {a,b}_P=−f,    {a,c₀}_P=ac₀/2,    {b,c₀}_P=−bc₀/2.

Now x=b, y=−a, z=−f and c=c₀ identify the full numerator bivector with π_D above. The source endpoint action is (a,b,c₀)↦(u⁻²a,u²b,(v/u)c₀); the integral torus change v′=v/u² makes it the displayed (u,v′)-action on (x,y,c). After removal of the free factor, the residual parameter diag(h⁻¹,h) is unchanged. The source closed character is z⁻¹ and its chart a≠0 is D(y). These comparisons verify the full Poisson structure with both chains nonempty. The map x=a,y=−b would give an underlying stack isomorphism but the opposite bracket. All displayed Poisson and Cartan statements in this paragraph are in characteristic zero; the incidence, torsor and inertia statements retain their all-characteristic scope.

**Checks.**

- For the empty lower word, V is a point and the two stacks are B T_PGL₂ and B T_SL₂; their comparison is induced by h ↦ h². For lower word s, V = 𝔾_m, and the stacks are respectively a point and Bμ₂. Empty, one-step and two-step configurations therefore test different stabilizers and different chart complements.
- In characteristic two the inertia on the SL₂ cluster locus is μ₂ = Spec k[ε]/(ε²), although it has only one geometric point. The nonneutrality argument still uses fppf torsors and the integer Picard group; replacing μ₂ by its geometric points loses this example.
- On the nonneutral central gerbe the tautological line M has nontrivial μ₂-character and M⊗² ≅ π*L, where L is the generator just computed. Pullback by π is injective on Picard groups: a trivialization of a pulled-back line has trivial band action and descends. Thus π*L is nontrivial, and M does not define a ℤ/2ℤ-indexed monoidal line system with square O. The actual torus-character line system retains this tensor relation, testing the distinction between an inertia character and coherent global degree data.
- The single exchange AA′ = p+q gives d(A) = (1,−1) and d(A′) = (0,2). Forgetting the two decoration characters would turn these sections into purported ordinary functions on the undecorated stack; their nontrivial coactions exclude that conclusion.

*Needs:* §§1.1–1.7, 2.3, 3.1–3.3, 5.3 and 6.1–6.4; SchemeAndStackFoundations §§1.15–1.16 and 3.4 for torsor lifting and line-bundle gluing. The flag framework is SW21, Definitions 2.20–2.21. The displayed incidence, determinant, character, inertia and Picard calculations prove the comparisons over every field directly, without a general gerbe classification.

### 6.6 Five flags and a nonzero Poisson bracket

Work over a characteristic-zero field and take upper word empty and lower word s³ for type A₁. The PGL₂ moduli object is a cyclically ordered five-tuple of lines with every adjacent pair complementary. Construct its X atlas directly from those flags. On a fan chart normalize the tuple to (∞,0,p,q,r), where p,q,r are finite and p(q−p)(r−q) is invertible; the remaining projective transformation scales p,q,r simultaneously. Put

    X = (q−p)/p,     Y = (r−q)/(q−p).

These are intrinsic cross-ratios. For vector representatives v₀,…,v₄ they are det(v₀,v₁)det(v₂,v₃)/(det(v₁,v₂)det(v₀,v₃)) and det(v₀,v₂)det(v₃,v₄)/(det(v₂,v₃)det(v₀,v₄)); all rescalings cancel. The inverse construction p=1, q=1+X, r=1+X+XY identifies the quotient chart with a full two-dimensional torus. The bottom-string convention gives ε_XY=−1, unit weights and {X,Y}_P=−XY.

- Flip the first diagonal on the geometric open q ≠ 0, which is exactly D(1+X). The new cross-ratios are (X⁻¹,XY/(1+X)). Flip the second on r ≠ p, exactly D(1+Y), obtaining (X(1+Y),Y⁻¹). Compute their brackets by the biderivation rule: in both cases the new bracket is X′Y′, agreeing with the mutated form. These are direct X formulas on flag configurations.
- Prove the geometric pentagon: five alternating mutations return (Y,X), with the two diagonals relabelled, on the actual composite domains. The five fan charts cover the whole moduli scheme. Indeed no line appears three times in an adjacent-distinct five-cycle, and two lines cannot color an odd cycle, so some line occurs once. The fan from that vertex has all required opposite pairs. Test the covering on geometric points and use the open incidence subfunctors to obtain the cover on families.
- Construct the entire quotient as the affine surface S = Spec k[u,v,w]/(uvw−u−v−1). Use chain representatives v_(−1)=e₁, v₀=e₂, v_i=a_i v_(i−1)−v_(i−2), and put f₂=a₁a₂−1, f₃=a₁a₂a₃−a₁−a₃. The slice is Spec k[a₁,a₂,a₃,f₃⁻¹]. With the residual torus parametrization of §6.5 its adjoint weights are (1,−1,1), and f₃ has weight 1. The invariants u=a₁/f₃, v=a₃/f₃, w=a₂f₃ give the quotient, with inverse a₁=tu, a₂=w/t, a₃=tv, f₃=t. Thus the effective torsor is globally trivial. The same calculation gives the SL₂ stack S × Bμ₂ and the GL₂ stack S × B𝔾_m, with their specified product presentations.
- On the fan chart prove X=1/f₂=1/(uw−1) and Y=u, equivalently u=Y, v=X(1+Y), w=(1+X)/(XY). Transporting the bracket gives

      {u,v}_P = uv,     {v,w}_P = vw−1,     {w,u}_P = uw−1.

  Prove this is the Jacobian bracket of F=uvw−u−v−1, so F is a Casimir and the bracket descends to S. Its coefficient vector is (vw−1,uw−1,uv). These entries never vanish simultaneously: the first two equalities force u,v,w to be nonzero, contradicting uv=0. Consequently S is smooth and the bracket has rank two everywhere. This verifies the ambient extension and nondegeneracy independently of choosing one torus chart. Its rational Poisson center is k, agreeing with the zero radical of the rank-two seed form. The finite-étale theorem of §1.5 equips the SL₂ stack with its ordinary Poisson structure. For GL₂ compare the full Cartan datum of §6.4 with the Poisson structure on S times the zero structure on B𝔾_m, using the specified product presentation and the constant-lift comparison of §1.6.

**Checks.**

- At X=Y=1 the configuration is (∞,0,1,2,3), the surface point is (u,v,w)=(1,2,2), and the initial bracket equals −1. The first flip gives (X′,Y′)=(1,1/2) and bracket 1/2, detecting the sign reversal.
- At X=−1,Y=1 the surface point (1,−2,0) is regular and the Poisson bracket is nonzero. The first flip is unavailable because q=0. Invertible X coordinates do not make every flip defined, even at a symplectic point.
- The three-step SL₂ gerbe is neutral by the explicit f₃ trivialization, whereas the two-step gerbe of §6.5 is nonneutral. The definition admits both without choosing a neutralization as part of every X chart comparison.
- The two-step example has transverse Poisson rank zero and a nonzero full-stack class at its residual gerbe; the three-step PGL₂ example has rank two and its five charts cover S. Neither the rank nor exhaustion of the ambient moduli space is fixed by the definition of a cluster structure.

*Needs:* §§0.4, 1.1–1.7, 6.1 and 6.4 for direct X recognition, Poisson étale descent, flag quotients and the full GL₂ Cartan comparison. The cross-ratios, incidence domains, pentagon, five-chart cover, quotient surface and Jacobian bracket are proved from the displayed formulas. The A construction of §6.2 supplies an independent ensemble comparison and is not an input to the direct surface computation. SW21, §3.2, fixes the string orientation; its Remark 1.11 does not supply an identification with a separately normalized flag-product Poisson structure.

### Examples

The full four-flag stack, presented both by the words e,s² and by s,s, is the principal test: it checks the original moduli functor, nontrivial torsor families, exact X overlaps, nonseparatedness, a nonneutral gerbe, an inertia jump and Poisson data invisible on the cluster open. Its incidence models also retain characteristic-two nonreduced inertia. The s³ configuration tests intrinsic cross-ratios, both X flip formulas, a nonzero Poisson form, its regular symplectic extension and a full five-chart cover. Empty and one-step words distinguish positive-dimensional, finite and trivial stabilizers, and GL₂ retains a connected center. General positive words use the direct node coordinates and the full A-to-X comparison, through the same intrinsic recognition theorem.

### Dependencies

Layers 0–5 supply direct X recognition, the full Cartan Poisson construction, quotient comparisons, gerbes and character lines. SchubertGeometry supplies flag and word schemes; ReductiveGroups supplies root coordinates, pinnings, group forms and highest weights; ClusterAlgebras supplies mutation, generic minors, Laurentness and the finite upper-bound comparison. This layer constructs the full undecorated moduli theorem using that algebraic floor. No Legendrian, categorical or scattering recognition theorem is an input.

## Downstream consumers

Moduli constructions first specify their underlying stack on families and arrows. They establish an X atlas from direct coordinates, the specified form, actual open overlaps and gerbe comparisons; a full cluster Poisson structure additionally supplies the ambient datum and standard seed-model comparisons of §1.7. A decorated A construction can prove the same recognition conditions through §1.2 and then recover line-valued functions through Layer 3. Gauge quotients use §2.3 and identify their output chart models explicitly. Boundary compactifications supply their cone, divisor, root and Poisson-extension data without asserting that the cluster locus exhausts the ambient space.

Theta-basis and canonical-basis constructions can compare their functions or character sections with the upper section algebra, using the supplier's algebraic theorems and the explicit geometric realization here. Dynamical constructions can distinguish regular automorphisms of the locus, extensions to the chosen completion, invariant functions and fixed moduli objects. Derived and categorical consumers receive the marked geometric object, its actual stabilizers and the constructed shift-zero Poisson datum when the stated quotient hypotheses hold. Further shifted or categorical comparisons require their own theorems.

## References

- **GHK15.** Mark Gross, Paul Hacking and Sean Keel, *Birational geometry of cluster algebras*, Algebraic Geometry 2 (2) (2015), 137–175, [doi:10.14231/AG-2015-007](https://doi.org/10.14231/AG-2015-007), [open published PDF](https://api.algebraicgeometry.nl/Article/18588/2015-2-007.pdf). Proposition 2.4, p. 149, supplies maximal regular-domain gluing; Theorem 3.14, p. 160, concerns the standard A scheme and Spec of its upper algebra; Remark 4.2, p. 162, explains specialized identity transitions with proper inherited overlaps. These locators use the published pagination.
- **GHKK18.** Mark Gross, Paul Hacking, Sean Keel and Maxim Kontsevich, *Canonical bases for cluster algebras*, Journal of the American Mathematical Society 31 (2) (2018), 497–608, [arXiv:1411.1394v2](https://arxiv.org/abs/1411.1394v2). The cited locators are the arXiv v2 numbering and pagination: Remark B.8, pp. 116–117, for dependent and nonspanning mutable families; Construction B.9, p. 117, for specified frozen partial compactifications. They are not page references to the published journal version.
- **Rydh16.** David Rydh, *Approximation of sheaves on algebraic stacks*, International Mathematics Research Notices 2016 (3), 717–737, [doi:10.1093/imrn/rnv142](https://doi.org/10.1093/imrn/rnv142), [author version](https://davidrydh.se/papers/approximation20150507.pdf). Definition 3.3 and the following paragraph, p. 5 of the author version, specify schematic dominance and its preservation by flat locally finitely presented base change without quasi-compactness; Definition 3.4 specifies the relative universal condition.
- **SW21.** Linhui Shen and Daping Weng, *Cluster Structures on Double Bott–Samelson Cells*, Forum of Mathematics, Sigma 9 (2021), e66, [doi:10.1017/fms.2021.59](https://doi.org/10.1017/fms.2021.59), [open published article](https://www.cambridge.org/core/journals/forum-of-mathematics-sigma/article/cluster-structures-on-double-bottsamelson-cells/7F06D4F3A0D6FBC538A5B92A89AEE1BB). Definitions 2.17–2.21 specify the flag configurations; Theorem 2.18 gives word coherence, Proposition 2.26 the endpoint-decoration torsor, and Theorem 2.30 the affine realization. Section 3.1, Propositions 3.23 and 3.25, Lemma 3.37, Proposition 3.42 and Theorem 3.45 supply the chamber and finite-chart proof sources. Lemma 3.10, Definition 3.13, Corollary 3.22 and Proposition 3.43 provide the node-parameter and ensemble-monomial comparisons used in the integral lattice proof. Section 3.2 gives the direct X construction and Appendix A.2 its Poisson convention. Proposition 3.44 supplies the open-string monomials, and Theorem 3.46 supplies the full decorated adjoint upper-X comparison used for the ambient Poisson construction. Remark 1.11 distinguishes this structure from a separately constructed flag-product bracket, whose equality requires a further comparison. The integral degree, gerbe and five-flag computations are specified directly in Layer 6.
- **Yeung22.** Wai-Kit Yeung, *Shifted symplectic and Poisson structures on global quotients*, [arXiv:2103.09491v3](https://arxiv.org/abs/2103.09491v3), [versioned PDF](https://arxiv.org/pdf/2103.09491v3). Theorem 2.16 and Definition 2.24 give the Cartan bracket and Maurer–Cartan model; Lemma 3.3, Propositions 3.9–3.10 and Theorem 4.16 give compatible-multiderivation spans and comparison with shifted Poisson structures. Section 1.6 specializes to smooth diagonalizable quotients and proves the nontrivial-torsor and homotopy-descent comparisons it uses.
- **Safronov18.** Pavel Safronov, *Poisson-Lie structures as shifted Poisson structures*, [arXiv:1706.02623v2](https://arxiv.org/abs/1706.02623v2). Definitions 2.4–2.5 and Proposition 2.14 give quasi-Poisson action data, vertical twists and their coisotropic quotient interpretation. The acting group has zero Poisson structure in the construction used here.
- **Getzler09.** Ezra Getzler, *Lie theory for nilpotent L-infinity algebras*, Annals of Mathematics 170 (2009), 271–301, [arXiv:math/0404003v4](https://arxiv.org/abs/math/0404003v4). Proposition 4.7 gives the Kan-fibration statement for surjective nilpotent maps. Its degree-restricted Theorem 4.8 is not used as an unrestricted filtered invariance theorem.
- **DR15.** Vasily A. Dolgushev and Christopher L. Rogers, *A Version of the Goldman–Millson Theorem for Filtered L-infinity Algebras*, [arXiv:1407.6735v2](https://arxiv.org/abs/1407.6735v2), Theorem 1.1 and the shifted formulation in Theorem 2.2. The comparison requires complete descending filtrations and quasi-isomorphisms on their filtration pieces; the weightwise maps constructed here satisfy those conditions. The inverse-limit and shift comparisons are part of §1.6.
- **Stacks.** The Stacks Project Authors, *The Stacks Project*. [Tags 04YL, 0503, 0504 and 04YN in the open-immersion section](https://stacks.math.columbia.edu/tag/04YK); [Tag 06PB in inertia of quotient stacks](https://stacks.math.columbia.edu/tag/06PA); [Tag 06FI, algebraicity of flat locally finitely presented groupoid quotients](https://stacks.math.columbia.edu/tag/06FI); [Tag 06NZ, gerbes](https://stacks.math.columbia.edu/tag/06NY); [Tag 06QG, a gerbe with a section](https://stacks.math.columbia.edu/tag/06QG); [Tag 06N3, étale presentations of Deligne–Mumford stacks](https://stacks.math.columbia.edu/tag/06N3); [Lemma 101.35.5 in Tag 0CIK, étale morphisms of stacks](https://stacks.math.columbia.edu/tag/0CIK); [Tag 0E9I, coherent Hartogs](https://stacks.math.columbia.edu/tag/0E9I); [Tag 0245, effective affine descent](https://stacks.math.columbia.edu/tag/0245); [Lemma 69.11.1 in Tag 073I, affine pushforward and base change](https://stacks.math.columbia.edu/tag/073I). General foundations are consumed through the exact supplier contracts above; the displayed elementary examples are proved from their equations and group actions.
