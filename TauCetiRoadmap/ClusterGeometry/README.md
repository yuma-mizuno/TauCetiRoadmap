# Roadmap: cluster geometry

**Summary.** Build cluster structures on specified schemes and algebraic stacks from marked seed patterns, actual open overlaps, and coherent descent. The geometric object is a marked cluster locus together with its realization in an ambient space. Its coordinate ring is a comparison invariant. Establish exact-overlap recognition, invariance under compatible changes of presentation, equivariant mutation and character-valued sections, frozen-boundary extensions, and global section comparisons. Include quotient presentations and gerbe lifts without discarding stabilizers. The principal examples distinguish spaces with identical upper cluster algebras and show why quotient formation and specialization must preserve the given overlaps.

## Scope and ownership

This roadmap owns the passage from seed geometry to a structure on a given space: recognition of chart images and their intersections; structured equivalence and descent; diagonalizable quotient charts with homogeneous exchange; coherent line-bundle coordinates; and comparison of a specified boundary completion with its cluster locus. It also owns the cluster-specific conditions under which an equivariant presentation descends to a quotient stack. An open atlas and an equivariant presentation are separate input forms, with a comparison theorem when the action preserves the individual chart opens.

[ClusterAlgebras](../ClusterAlgebras/README.md), §§3.1–3.5, owns lattice seeds, mutable families, torus mutations, the marked coslice atlas, maximal regular-domain gluing, principal coefficients, and changes of seed presentation. Its §§1.4, 2.3 and 2.7 own the geometric coefficient algebras, Laurent phenomenon and finite-chart recovery. Those constructions are suppliers here. This roadmap does not replace its seed carriers or redefine a cluster variety to be the spectrum of an algebra.

[SchemeAndStackFoundations](../SchemeAndStackFoundations/README.md), §0.6 and §§1.14–1.23, owns reflexive extension, groupoids, torsors, stackification, algebraic stacks, quotient and root stacks, and quasi-coherent descent. Its §3.4 owns Picard groupoids. [EquivariantIntersectionTheory](../EquivariantIntersectionTheory/README.md), §§1.1 and 1.4, owns linearised invertible sheaves and their quotient-stack comparison. General diagonalizable group schemes and comodule weight decompositions are already in Tau Ceti. The character-section targets here concern their compatibility with a marked cluster atlas; they do not reproduce those foundations.

Scattering, theta bases, quantum cluster algebras, categorical cluster structures, derived enhancements and coarse-moduli existence belong to their respective suppliers or consumers. No equivalence between geometric cluster structures and a categorification is asserted. No classification of all cluster structures on a fixed space, or of all gerbes, is part of the target.

## Conventions

Work over an affine base S = Spec R, where R is a commutative ring. All indexing sets are small in a fixed universe. Split tori are T(L) = Spec R[L], with L a finite free character lattice. D(Λ) denotes the diagonalizable group for a finitely generated abelian group Λ; Λ may have torsion. Group actions are left actions. Algebraic stacks are stacks in groupoids on the fppf site; all fibre products of stacks are 2-fibre products. An open immersion of stacks is representable. Equalities of stack morphisms in descent statements mean specified 2-isomorphisms with the stated coherence.

A seed pattern P is the full marked pattern supplied by ClusterAlgebras §3.3, with an explicit choice of flavour A, X or A with principal coefficients. Its initial-seed markings are objects of the coslice of the seed transformation groupoid. Retain the full lattice, the finite indexed mutable family, its weights and any chosen adapted basis. The family may be dependent, repeated or nonspanning. Rank zero for a seed pattern means that the mutable family is empty; its ambient lattice can have positive rank. An adapted basis is required only for formulas which actually use all coordinate variables. An ensemble map includes the lattice map required by ClusterAlgebras §3.3 as data; the exchange matrix does not determine it.

Over a domain, a common-function-field realization requires the supplier's nonvanishing conditions for exchange factors. Over an arbitrary ring, use the specified localized isomorphisms and their open domains; empty domains are allowed. A family of geometric charts still exists when a special fibre ceases to be an integral cluster pattern. Statements about rational functions, valuations, normality or codimension carry their additional hypotheses explicitly.

Write C for the cluster locus, Y for a specified ambient scheme or stack, and j : C → Y for its realization. The notation C does not assert affineness, separatedness, quasi-compactness or finite type. Dense means schematically dense when used for an open realization; topological density alone is insufficient over a nonreduced base. For stacks this condition is tested after smooth base change to schemes. Boundary codimension is also tested on smooth charts.

The degree convention is a* f = χ_λ ⊗ f for a function of weight λ under D(Λ). The character line L_λ on a quotient is the descent of the trivial line with action (y,v) ↦ (h·y,χ_λ(h)v). Thus its sections correspond to functions with that weight, without reversing λ.

## Exact supplier contracts

### From Mathlib

Use `AlgebraicGeometry.Scheme.GlueData`, its glued scheme, chart maps and open cover from `Mathlib.AlgebraicGeometry.Gluing`. In particular, use `Scheme.GlueData.vPullbackConeIsLimit` for the prescribed overlaps, `Scheme.Cover.glueMorphisms` for compatible chart maps, and the native `IsPullback` and `IsOpenImmersion` predicates. The recognition theorem in §0.2 adds a criterion for a map to a specified target; it does not construct a second gluing carrier. Use monoid algebras, localization, tensor products, finite free lattices and scheme base change with their existing universal properties.

### From Tau Ceti

Use `TauCeti.DiagonalizableGroup.groupScheme`, `groupSchemeMap` and `schemeFunctor` from `TauCeti.Algebra.AlgebraicGroup.DiagonalizableGroup.Scheme.Basic` for D(Λ) and maps induced by character maps. Use `TauCeti.Comodule.weightSpace`, `weightProj` and `isInternal_weightSpace` from `TauCeti.Algebra.Coalgebra.Comodule.MonoidAlgebra.Basic` for algebraic weight decompositions. No characteristic-zero hypothesis is imposed on this diagonalizable theory.

Use `StructureSheaf.toOpenₗ_bijective_of_two_le_depth` and the finite-module restriction results in `TauCeti.AlgebraicGeometry.Modules.Tilde.Hartogs` for affine depth-two extension. The native natural-number-graded quasi-coherent algebra API is not substituted for arbitrary-character-graded sections on stacks. The stack carrier needed below is the algebraic-stack supplier, not merely a category-valued pseudofunctor on schemes.

### From TauCetiRoadmap.ClusterAlgebras

Consume §3.1 for full lattice data and mutable families, §3.2 for the adapted-basis matrix convention, §3.3 for character mutation, marked charts, the largest regular overlaps, global functions as a Laurent intersection, and regular toric charts over arbitrary rings. Consume §§3.4–3.5 for principal and seed-presentation comparisons. Consume §1.4 for the distinction between inverted and non-inverted frozen coefficients, §2.3 for Laurent inclusions, and §2.7 when a finite collection of charts is used to compute an upper algebra. Its global-function theorem applies under its stated domain and nonvanishing assumptions; it is not a base-change theorem for upper algebras.

### From TauCetiRoadmap.SchemeAndStackFoundations

Consume §0.6 for normal/reflexive extension and coherent Hartogs. Consume §§1.14–1.16 for action groupoids, stabilizers, torsors and contracted products; §1.18 for stackification, 2-fibre products and descent data; §§1.19–1.20 for representability, algebraicity, inertia and presentations; §1.21 for quotient stacks of flat, locally finitely presented groupoids and root stacks; §1.22 for descent and tensor operations on quasi-coherent sheaves; and §3.4 for the abstract Picard-groupoid construction and the symmetric monoidal groupoid of invertible sheaves on schemes. For an algebraic stack, apply that abstract construction to the tensor-invertible objects of its quasi-coherent category from §1.22, and compare on a scheme presentation; this supplies the stack version used in Layer 3. Open gluing in §1.3 below is the cluster-chart application constructed from these contracts. No general cohomological classification of gerbes is needed.

### From TauCetiRoadmap.EquivariantIntersectionTheory

Consume §1.1 for the groupoid of linearised invertible sheaves for a flat group scheme of finite presentation, retaining equivariant isomorphisms and scalar automorphisms. Consume §1.4 for its equivalence with invertible sheaves on the quotient stack. The characterwise section comparison in §3.2 strengthens this input by specifying the weight convention, the monoidal multiplication and compatibility with all cluster transitions.

## How to read the build

Layer 0 recognizes a marked scheme atlas inside an ambient scheme. Layer 1 supplies concrete quotient charts, homogeneous mutations and coherent stack gluing. Layer 2 identifies precisely which refinements, transports and equivariant presentations preserve the structure. Layer 3 recovers line-bundle-valued exchange and graded sections. Layer 4 adds specified boundary models and treats base change without enlarging overlaps. Layer 5 proves global comparisons and extension results and works out the examples separating rings, spaces and stabilizers. Generic supplier results are inputs to these layers; their cluster compatibility is the new conclusion.

## Layer 0: marked scheme atlases and realization

### 0.1 Actual overlap data for a fixed pattern

For a fixed P, use all its marked seed tori T_i. An actual marked overlap system specifies an open V_ij in T_i and an isomorphism φ_ij : V_ij ≅ V_ji which is the prescribed seed transition on that domain. Require V_ii = T_i, identity on the diagonal, inverse transitions, the domain identity φ_ij(V_ij ∩ V_ik) = V_ji ∩ V_jk, and the cocycle identity on that triple overlap. For every elementary marked mutation a : i → j, require that its supplied localized mutation domain D_a is contained in V_ij and that the restriction of φ_ij is that mutation. For a seed isomorphism, require its entire chart as D_a. Thus all supplied composite path domains are included by the domain and cocycle laws. Over a domain the transitions agree with the marked rational maps. Over an arbitrary ring their agreement is expressed through the universal localized formulas and supplied compositions. The system contains every marked seed chart and realizes every required mutation domain; a convenient finite subcollection is a cover only when its cover property is proved.

The maximal system of ClusterAlgebras §3.3 is one such system. A system inherited by base change is also retained with its actual domains, including the pullbacks of the D_a. These are different operations: the definition includes the explicit comparisons just specified to the chosen seed pattern, but does not require every actual system to be maximal. Construct its glued scheme C with its distinguished full charts and their open restrictions. This is an application of native scheme gluing, with the seed markings retained.

- Provide extensionality for systems with the same marked charts, domains and transitions, and transport along a specified isomorphism of seed patterns.
- Identify V_ij with T_i ×_C T_j and identify the image of each chart with an open subscheme of C. Prove that the distinguished charts cover C.
- Restrict charts to open subdomains and transport the transitions by their actual intersections. These restrictions are refinements of the marked atlas, not new full seed tori.

**Checks.**

- For an empty mutable family the maximal cluster locus is the initial torus, including Spec R when its lattice has rank zero. It is not an arbitrary chosen rational open subset.
- For the repeated mutable family e₁ = e₂ = (1,0) in ℤ², the chart lattice still has rank two. Replacing it by the span of the mutable family would change the dimension.
- The rank-one exchange xx′ = 2 over ℤ has overlap D(2) in each torus. Over 𝔽₂ the pulled-back overlap is empty, so the fibre is two disjoint tori; declaring the transition everywhere defined gives the wrong fibre.
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

### Examples

The maximal A and X schemes of ClusterAlgebras §3.3 carry the identity realization. For an adapted rank-one pattern with one inverted frozen variable z and exchange xx′ = 1+z, the two charts identify with D(x) and D(x′) in the exchange surface. For a nonmaximal overlap system the criterion of §0.2 must be checked on the actual domains; a rational coordinate identity alone does not supply that criterion.

### Dependencies

ClusterAlgebras §§3.1–3.5 supplies marked seed geometry. Mathlib supplies scheme gluing and open immersions. No stack theory, normality or upper-algebra equality is required by the scheme recognition criterion.

## Layer 1: quotient charts and coherent stack atlases

### 1.1 Diagonalizable quotient charts

A graded torus chart consists of a finite free character lattice L, a finitely generated abelian group Λ and a degree map d : L → Λ. It presents the stack [T(L)/D(Λ)], where the action is translation through the homomorphism D(Λ) → T(L) dual to d. Keep d and the marked seed lattice in the presentation; the underlying quotient stack does not determine them. Faithfulness of the action is not imposed.

- Construct the action and its functoriality under commuting squares of lattice and degree maps, using the native diagonalizable group functor.
- Identify the inertia over every object with the pullback of ker(D(Λ) → T(L)) = D(coker d). Prove that this description is compatible with base change and preserves nonreduced stabilizers.
- For a surjective degree map, identify the quotient with T(ker d) by the explicit D(Λ)-torsor T(L) → T(ker d). To prove this, decompose R[L] over R[ker d] by the cosets in Λ, choose one monomial lift in each coset to see faithful freeness, and verify the torsor identity on the two character algebras. Finite generation of Λ and L gives finite presentation. For d = 0 identify the quotient with T(L) × B D(Λ). Record actual quotient morphisms, not only isomorphisms of invariant rings.

**Checks.**

- For d : ℤ → ℤ equal to the identity, [𝔾_m/𝔾_m] is Spec R and has trivial inertia, although the marked character lattice has rank one.
- For d = 0 and Λ = ℤ/rℤ, the chart is T(L) × Bμ_r and its functions are those of T(L). It retains μ_r even when the residue characteristic divides r.
- For the quotient map d : ℤ → ℤ/rℤ, the action on 𝔾_m is free and the quotient coordinate is xʳ. The kernel group is trivial; μ_r is the acting group, not the stabilizer.

*Needs:* native Tau Ceti diagonalizable group schemes; SchemeAndStackFoundations §§1.14–1.16 and 1.21 for stabilizers, torsors and quotient stacks. Quotient algebraicity uses Stacks, Tag 06FI; the inertia computation uses Tag 06PB. The fppf presentation by T(L) need not be smooth when D(Λ) is not smooth.

### 1.2 Homogeneous mutation

For an adapted A-seed presentation, assign degrees a_i in Λ to every mutable and frozen coordinate. Call an exchange at k homogeneous when Σ_i b_ik a_i = 0, where B is the extended matrix of ClusterAlgebras §3.2. Write M₊ = ∏ x_i^[b_ik]₊ and M₋ = ∏ x_i^[−b_ik]₊. Set a′_k = deg(M₊) − a_k and a′_i = a_i for i ≠ k. Prove that the two numerator monomials have the same degree, that the new degrees satisfy all mutated balance equations when the old degrees satisfy all original ones, and that the exchange x_k x′_k = M₊+M₋ is equivariant with these degrees. The mutable-family version uses character pullbacks and commuting coactions, without introducing a nonexistent full basis.

- Characterize equivariance by the equality of coactions on the character generators and their localized inverses. For a nonzero coefficient ring, distinguish the two nonzero monomial summands when proving necessity of degree balance.
- Prove that the exchange open is invariant and that the localized mutation descends to an equivalence of the corresponding open quotient substacks. Compose these equivalences with their actual domains.
- Transport gradings through mutation words and seed isomorphisms, keeping the chosen identification of character groups. For X and principal charts require the same coaction compatibility for their supplied character formulas; do not infer it from the A degree equation without a comparison of the relevant lattices.

**Checks.**

- For xy = 1+z with deg x = 1 and deg z = 0, mutation gives deg y = −1. Both numerator terms have degree zero and the divisor z = −1 is invariant.
- If deg z = 1 in that relation, 1 and z have different weights. The exchange fails the homogeneity condition over every nonzero field, so there is no quotient mutation for that proposed grading.
- For xx′ = 2 over 𝔽₂, the homogeneous exchange domain is empty. Equivariance of the empty-domain isomorphism remains true, but it does not produce a birational mutation on the fibre.

*Needs:* §1.1; ClusterAlgebras §§1.1, 3.2–3.4 for matrix mutation, exchange and character formulas; native comodule weights and localization. The proof expands the two monomial degrees and the mutated matrix, then descends the resulting equivariant isomorphism through SchemeAndStackFoundations §1.21.

### 1.3 Coherent open-stack gluing

A general coherent open-stack gluing datum has algebraic chart stacks C_i, open substacks V_ij in C_i, equivalences φ_ij : V_ij ≃ V_ji, unit and inverse identifications, and 2-isomorphisms η_ijk : φ_jk φ_ij ⇒ φ_ik on the triple overlaps. Impose the same domain identity as in §0.1, the quadruple-overlap coherence equation for η, and the unit and inverse triangle laws, including the associators and unitors of composition. Equivalently use normalized data with φ_ii = id and η_iij and η_ijj the canonical unit comparisons, with the induced compatible inverse comparisons.

A coherent marked cluster atlas is such a datum with all marked seeds present and with each chart actually identified with its specified seed torus, graded quotient-torus model of §1.1, or supplied gerbe lift of such a model as in §1.5. For every required elementary mutation or seed isomorphism, its supplied domain, or its invariant quotient or gerbe pullback, must embed in the relevant V_ij and realize that transformation with the specified coherence. The chart-model identifications and these comparisons are data. An arbitrary algebraic stack carrying a seed label is not a cluster chart. The following gluing theorem applies to the general datum, and preserves all the extra cluster data when present.

- Construct a glued algebraic stack C with representable open chart maps, covering images, and comparisons V_ij ≃ C_i ×_C C_j. Recover the original transition 2-isomorphisms from this realization.
- Prove the bicategorical universal property: morphisms from C to any stack form the groupoid of chart morphisms with compatible transition 2-isomorphisms. Retain automorphisms in this groupoid.
- Prove uniqueness up to an equivalence compatible with all chart maps and coherence data. Changes of a chosen presentation induce coherent equivalences rather than an asserted literal equality of stacks.

For the construction, choose smooth scheme presentations of the C_i, pull the V_ij back to their pairwise presentation spaces, and form the groupoid whose composition is induced by η. The domain law gives a groupoid, and quadruple coherence gives associativity. Stackify its quotient using the supplier; the overlaps are open, so the resulting chart maps are representable open immersions. This construction also proves the stated universal property. It does not require the original quotient-torus presentations themselves to be smooth.

**Checks.**

- If every C_i is a scheme, its transition 2-isomorphisms are unique and the construction agrees with native scheme gluing.
- With one chart T × Bμ_r the glued object has the same μ_r inertia. Replacing the chart groupoid by its orbit set would incorrectly give T.
- Over a field of characteristic different from two, take four identical charts Bμ₂ and identity transitions. Setting η_012 = −1 and all other nondegenerate η to +1 gives quadruple composites −1 and +1, so the data are rejected. With one chart, setting η_iii = −1 while keeping the units trivial violates the unit law even though the quadruple equation alone holds.

*Needs:* §§1.1–1.2 for quotient-chart applications; §0.1 for domain laws; SchemeAndStackFoundations §§1.14, 1.18–1.21 for groupoids, stackification, algebraic presentations and quotients. The algebraicity input is Stacks, Tag 06FI.

### 1.4 Recognition on an algebraic stack

Let the data of §1.3 be given, and let its chart maps to an algebraic stack Y be representable open immersions with coherent compatibility. Prove that the induced C → Y is a representable open immersion if and only if every map V_ij → C_i ×_Y C_j is an equivalence. Its image is the union of the chart images. Apply a smooth atlas of Y and the scheme or algebraic-space recognition criterion, then descend the open-immersion property. Define a realized stack cluster structure by this recognized locus and a schematically dense open inclusion into Y, retaining its decorated presentation.

- Compute inertia locally from the chart groupoids and identify it with the restriction of the inertia of Y. Mutation-word automorphisms are not added to this inertia.
- Compare the scheme and stack notions: a cover by representable open immersions from schemes makes C a scheme. A smooth or fppf cover by schemes has no such consequence.
- Transport the structure along an equivalence of ambient stacks and preserve the actual 2-fibre-product overlaps and the specified coherence maps.

**Checks.**

- Spec k → BG for a nontrivial group scheme G is a torsor atlas, not an open immersion: its self-2-fibre product is G rather than Spec k.
- A geometric point of T × Bμ_r has automorphism group μ_r, including its infinitesimal structure in characteristic dividing r. A torus-coordinate description cannot make this locus a scheme.
- Gluing two copies of 𝔾_m along 𝔾_m ∖ {1} with identity transition gives a scheme with two points over 1. Mapping both charts identically to 𝔾_m violates exact overlaps, even though all rational pullbacks agree.

*Needs:* §§0.2 and 1.3; SchemeAndStackFoundations §§1.19–1.20 for representable open immersions, locality and inertia. Use Stacks, Tags 04YL, 0503, 0504 and 04YN for the open-immersion tests and invariant-open quotient comparison.

### 1.5 Gerbe lifts of marked charts

A banded gerbe lift is an algebraic stack π : G → C together with a commutative flat group scheme K of finite presentation over C. For every scheme T → C, require the 2-pullback G_T to be locally nonempty and locally connected in the fppf topology, with compatible identifications of the automorphism sheaf of each object over T with K_T. Equivalently these are the relative automorphisms, fixing the specified object of C, rather than the full inertia of G. The compatibility includes pullback and conjugation by arrows. These are the data of a K-banded gerbe, rather than the assertion that the total space is the relative classifying stack B_C K. Pull each chart and overlap of C back along π, retaining the pulled-back seed markings and the resulting coherence maps. This gives a marked gerbe atlas on G.

- Prove functoriality under base change and equivalence of banded lifts, and prove that the pulled-back charts are an open cover with the required exact overlaps.
- A chosen section s : C → G with πs ≅ id_C identifies the gerbe with B_C K, compatibly with the band. Conversely a band-compatible equivalence with B_C K supplies such a section. For a stack base, prove the neutralization on scheme tests and descend it. An S-point of G is not a section over C.
- Prove that the coordinate functions of C pull back to G, but a character of K defines a coordinate line on G only when the corresponding line descent data actually exist. Transport existing monoidal line systems; do not manufacture one from the band alone.

**Checks.**

- The displayed product T × Bμ_r has its trivial-torsor section, relative inertia μ_r, and the ordinary functions of T. An abstract neutral gerbe acquires an identified classifying-stack presentation only after a section is chosen.
- Over ℝ, let the constant group C₄ act on Spec ℂ through C₄ → C₂ = Gal(ℂ/ℝ). The quotient [Spec ℂ/C₄] is a C₂-banded gerbe over Spec ℝ with no ℝ-object: such an object would give a homomorphism C₂ → C₄ lifting the identity of C₂, which does not exist. Its product with a torus is a nonneutral lifted rank-zero pattern.
- On this gerbe a line with the nontrivial kernel C₂-character cannot exist. Its equivariant structure would require an antilinear F(z) = a·conj(z) with F² = −1, whereas F² = |a|². This rules out a definition that attaches all character lines automatically.

*Needs:* §§1.3–1.4; SchemeAndStackFoundations §§1.15–1.16, 1.18 and 1.21 for torsors and stack pullbacks. Use Stacks, Tag 06NZ, for the gerbe conditions and Tag 06QG for neutralization over an algebraic-space base with a section; the stack-base extension follows by the stated descent argument. No Brauer-group or second-cohomology classification is used.

### Examples

Ordinary seed tori give the scheme subcase. A homogeneous seed pattern with a common D(Λ)-action gives a quotient atlas using precisely its invariant mutation domains. A neutral band adds constant generic inertia without changing ordinary chart functions. The real C₄ quotient supplies a gerbe lift which cannot be replaced by a split classifying-stack factor over the base.

### Dependencies

Layer 0 supplies the recognition mechanism. Native diagonalizable groups and comodule weights supply the grading action. ClusterAlgebras supplies mutation formulas. SchemeAndStackFoundations §§1.14–1.22 supplies effective algebraic descent, quotients and sheaves, and EquivariantIntersectionTheory §1.1 supplies the linearisations used by the gerbe check.

## Layer 2: structure, equivalence and equivariant presentations

### 2.1 Compatible refinements and equivalence

Associate to a marked atlas its (2,1)-category of admissible marked chart maps into C. Start with each distinguished full chart and all its open restrictions. Generate further chart maps by the permitted seed isomorphisms and mutations on their actual domains, by translations through the grading actions verified in §1.2 with their specified parameters, by isomorphisms of the specified graded or banded chart data, and by isomorphisms over C preserving these markings. An ungraded model has no extra translations unless they are explicitly included through a compatible grading action. Close under restriction and gluing of chart maps which agree with these data on an open cover of their source. For objects u : U → C and v : V → C, a 1-morphism is an allowed f : U → V with α : u ⇒ vf. A 2-morphism (f,α) ⇒ (f′,α′) is θ : f ⇒ f′ satisfying α′ = (v ⋆ θ) α. All these 2-morphisms are invertible. The allowed generators are part of the chart model; an arbitrary rational change of variables is not a generator.

A structured equivalence consists of an equivalence C ≃ C′, a specified isomorphism of the seed patterns and chart-model data, and a biequivalence of the admissible chart (2,1)-categories compatible with their evaluation into C and C′ and with the distinguished full-chart markings. An equivalence of realized structures also includes an equivalence Y ≃ Y′ commuting with the two open realizations. A common compatible refinement consists of open restrictions covering each original chart, with the same marking comparisons and transition 2-isomorphisms. Full seed tori remain distinguished even when a refinement uses smaller opens.

- Prove that compatible refinements induce structured equivalences and that successive refinements compose. Prove the converse local criterion: when an equivalence carries each chart locally to an admissible chart in both directions, the pullbacks of these domains give a common compatible refinement.
- Construct the hom groupoid of structured equivalences between each pair of objects, including their compatible 2-isomorphisms. These assemble into a 2-groupoid with a forgetful pseudofunctor to the underlying realized pairs and their equivalences. Its fibres retain different decorations on the same space.
- Preserve the whole cluster locus under equivalence. Restricting two loci to a shared dense open yields a comparison of restrictions, not an equivalence of their original structures.

**Checks.**

- Refining a chart by two opens that cover it preserves the structure. Deleting a point from the chart and keeping only the complement is not a refinement covering that chart.
- A rank-zero marking of 𝔾_m and a rank-zero marking of 𝔾_m ∖ {1} cannot be identified by their common rational coordinate: the latter open is not a full torus chart, and the loci differ.
- The presentations of Spec k as Spec k and as [𝔾_m/𝔾_m] have equivalent underlying stacks, but their displayed lattice and grading data differ. An explicit permitted presentation comparison is required to identify their structured versions; ordinary stack equivalence does not do so.

*Needs:* §§0.1, 1.3–1.5 for marked charts and their 2-morphisms; ClusterAlgebras §3.5 for allowed changes of seed presentation; SchemeAndStackFoundations §1.18 for descent of compatible maps. No unlisted gauge stabilization is included among the generators.

### 2.2 Maps and transport of realizations

A map of marked cluster loci is a morphism of their marked chart diagrams. It includes a functor on the chosen seed and refinement index diagrams, contravariant character homomorphisms q_i : L′_(αi) → L_i, and compatible degree-group and band maps where these occur. If β_i : Λ′_(αi) → Λ_i is the degree map, require d_i q_i = β_i d′_(αi). After specified permitted seed transports and grading translations, the local pullback of a character z^m must equal z^(q_i(m)), with precisely the character scalar of the specified translation. Require the diagram squares with each seed transition to commute on their actual domains. Local maps must send source overlaps into the corresponding target overlaps; their source domains must cover each distinguished chart. For a gerbe chart also supply the actual chart morphism inducing the band map and the underlying character formula; a band homomorphism alone does not construct it. In the stack case the diagram squares are coherent 2-isomorphisms compatible with these formulas.

A map of realized structures additionally includes F : Y → Y′ and a 2-isomorphism F j ⇒ j′ f. Regularity of every local chart map is required. A rational seed transformation is not an everywhere defined morphism of completions, and a regular map with arbitrary unrelated seed annotations is not a map of these marked diagrams.

- Construct f by descent and prove independence, up to the prescribed unique compatible 2-isomorphism, of compatible refinements of the local description.
- Construct identity maps and composition, with associativity and units inherited from the supplier's bicategory. Define inverse equivalences by actual inverse maps of this data.
- Transport an atlas along an isomorphism of seed patterns, and identify the resulting realization using the supplier's change-of-initial-seed comparisons. Transport a realization along an equivalence of ambient spaces without changing its geometric image.

**Checks.**

- In rank zero, x ↦ x² on 𝔾_m is a regular marked monomial map. In characteristic two it is not étale, so the definition must not force all maps to be chart isomorphisms.
- The inversion x ↦ x⁻¹ is an automorphism of the rank-zero torus. It does not extend to an automorphism of its specified completion 𝔸¹.
- Two maps of stacks with the same action on ordinary functions can have different effects on stabilizers. The comparison of maps therefore includes the groupoid maps and their 2-isomorphisms.
- With no allowed translations, x ↦ c x for c ≠ 1 cannot be marked by the identity character map: its pullback of x is c x, not x. The character-formula requirement rejects an unrelated annotation.

*Needs:* §2.1; §§0.2 and 1.3–1.4 for descent and recognition; ClusterAlgebras §§3.3–3.5 for seed transport. No claim that arbitrary base maps pull back a full cluster structure is used here.

### 2.3 Equivariant cluster presentations

Let G be a flat group scheme of finite presentation acting on a realized cluster locus C and on Y, with j equivariant. An equivariant cluster presentation includes a coherent lift of this geometric action to the admissible marked chart (2,1)-categories of §2.1, compatible with every base change and with the given multiplication and unit coherence. Its comparisons use the allowed chart transformations, not arbitrary automorphisms of the function field. For split seed charts, a concrete sufficient condition is that fppf locally on the group parameter, and on an open cover of the chart domain, the action is a specified seed transformation followed by a grading-torus translation depending only on that group parameter. Require the resulting comparisons to satisfy the group action identities. Translation parameters depending arbitrarily on the chart point are not allowed as new coordinate transformations in this sufficient condition. Actual point-dependent gauge 2-isomorphisms of maps into an already specified quotient chart remain allowed; they change the framing of that map, not its seed-coordinate transformation.

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

## Layer 3: line-bundle exchange and characterwise sections

### 3.1 Monoidal line systems and exchange sections

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

Let Y be a quasi-compact, quasi-separated R-scheme with an action of H = D(Λ). Let L_λ be the character lines on [Y/H] with the convention above, and let A_λ be the λ-weight submodule of A = Γ(Y,O_Y). Prove the multiplication-compatible identifications Γ([Y/H],L_λ) ≅ A_λ and ⊕_λ Γ([Y/H],L_λ) ≅ A as Λ-graded R-algebras. In degree zero this gives Γ([Y/H],O) ≅ A₀ = Aᴴ. The character line system comes from the actual H-torsor Y → [Y/H]. No faithfulness, reducedness or characteristic-zero assumption on H is required.

Use quasi-coherent descent to identify a quotient section with an equivariant section on Y. The quasi-compact and quasi-separated hypotheses permit global sections of the direct sum of copies of O_Y to be identified with the direct sum of global sections, so the action gives an algebraic coaction on A. Apply the native internal weight decomposition and compare multiplication. Prove compatibility with restriction to invariant opens and with all homogeneous mutations of §1.2. For a non-quasi-compact locus, retain the weightwise comparison but assert recovery of A by the direct sum only with a separately established finite-weight property for each global function.

**Checks.**

- For the translation action of 𝔾_m on itself, the quotient is a point. Each character line is isomorphic to a trivial line on that point, but the labelled direct sum recovers k[x±1]; forgetting the character labels leaves only k.
- For a trivial H-action, A has only weight zero and Γ(Y × BH,O) = A. Nontrivial inertia is invisible to this equality.
- Let Y be the disjoint union of countably many copies of 𝔾_m with translation action. The global function whose nth component is xⁿ has unbounded weight support. It lies in the product of the Laurent rings and not in the direct sum of global weight spaces, showing why the quasi-compactness or finite-weight hypothesis is needed.

This graded algebra is not asserted to be a Cox ring. Such a comparison also needs a specified relation between Λ and Pic(Y/H), the chosen representative lines and their tensor coherence; redundant characters and missing line classes are allowed here.

*Needs:* §§1.1–1.2 and 3.1; native comodule weight decomposition; SchemeAndStackFoundations §1.22 for quotient quasi-coherent descent; EquivariantIntersectionTheory §§1.1 and 1.4 for character lines and their quotient interpretation.

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

### Examples

For a homogeneous A pattern, coordinates descend as sections of the character lines and every exchange is an equality in a specified tensor product of those lines. When all degrees vanish, the comparison gives ordinary cluster functions on a quotient with potentially nontrivial generic inertia. When the degree map is surjective, an underlying scheme quotient can still need its character labels to recover the original graded coordinate algebra.

### Dependencies

Layers 1–2 supply equivariant mutation and coherent comparisons. SchemeAndStackFoundations §§1.22 and 3.4 supplies sheaf and Picard descent. EquivariantIntersectionTheory §§1.1 and 1.4 and native comodule weights supply the quotient comparison. No extension of line bundles across a boundary is assumed.

## Layer 4: boundary models, forms and families

### 4.1 Specified frozen-boundary models

A frozen-boundary model for a marked atlas specifies, for each relevant full seed chart, a regular toric partial compactification together with its full cone and face data, a marking of the chosen frozen directions, and open transition extensions satisfying the domain and coherence laws. Its torus restriction must be the original actual transition system. The toric charts are Spec R[σ∨ ∩ L] for regular cones in the cocharacter lattice, using ClusterAlgebras §3.3. A general mutable family is allowed; an adapted basis or explicit character/cone data must be supplied whenever frozen coordinate hyperplanes are named. Arbitrary rays alone do not supply this boundary model.

- Glue the extended charts and prove that the original C embeds as an open subspace C → Cᶠʳ, compatibly with all markings. Prove density where the torus inclusions are schematically dense, including the supplied regular toric models over arbitrary R.
- Extend homogeneous diagonalizable actions to the monoid algebras and descend compatible boundary models to quotient stacks. Track each boundary coordinate as a section of its character line, together with its vanishing substack.
- Given specified effective Cartier boundary divisors and positive root orders, use the supplier's root stacks to construct the corresponding rooted model and its restriction to C. Retain the root orders, divisor sections and their identifications; the underlying divisorial valuations do not determine these stabilizers.

**Checks.**

- The cone generated by the first basis cocharacter gives Spec R[t,z±1]; its zero face gives Spec R[t±1,z±1], including R = ℤ/4ℤ. The coordinate t remains a nonzerodivisor despite nilpotents in R.
- 𝔸² and 𝔸² ∖ {0} have the same dense torus and the same two coordinate divisorial valuations, but different cones and boundary incidence. A list of rays would identify two different models.
- The rth root of (𝔸¹,{0}) is [𝔸¹_u/μ_r] with base coordinate t = uʳ. Its geometric stabilizer at zero is μ_r, while its scheme-theoretic fibre over t = 0 is [Spec k[u]/(uʳ)/μ_r], not merely Bμ_r.

*Needs:* §§0.1, 1.2–1.4 and 3.1; ClusterAlgebras §3.3 for regular toric charts and base change; SchemeAndStackFoundations §1.21 for root stacks and quotient constructions. GHKK, Construction B.9, arXiv v2, p. 117, motivates the specified frozen extensions; it does not assert existence for arbitrary chosen cone systems.

### 4.2 Ambient completions and the remaining locus

A boundary-compatible realization is a pair of open immersions C → Cᶠʳ → Y, where the first is a specified model of §4.1 and the second is a realization satisfying exact overlaps for its extended charts. Define the remaining locus as the closed subset |Y| ∖ |Cᶠʳ|. A closed-substack structure on this subset, when needed, is additional data; it is not recovered from the ordinary coordinate ring. The frozen boundary lies in Cᶠʳ ∖ C and the remaining locus need not be a union of frozen divisors.

- Recognize the extended chart realization by §§0.2 or 1.4, and identify its image as their union. Keep the complement and all inertia induced from Y.
- Transport the pair along a structured equivalence preserving the cone, root and divisor data. Prove that changing the specified ambient completion need not preserve the remaining locus.
- Formulate the condition that the remaining locus has codimension at least two, or that a specified sheaf has depth at least two along it. Use these as hypotheses for the section comparison of §5.2, not as axioms of a cluster structure or as a claim that line bundles extend.

**Checks.**

- For xy = 1+z with z inverted and no frozen direction added, Cᶠʳ = C = D(x) ∪ D(y), and the remaining locus in its affine exchange surface is the single point (0,0,−1).
- Taking Y = Cᶠʳ makes the remaining locus empty. The same marked locus can have a nonempty remaining locus in another completion.
- A root order along a frozen divisor changes the stabilizer of the ambient stack without changing the ordinary vanishing order of the base coordinate. Boundary-compatible equivalence must retain that order and the root section.

*Needs:* §§0.3, 1.4, 2.1 and 4.1; SchemeAndStackFoundations §§0.6–0.7 and 1.20 for depth, dimension and their smooth-local interpretation. No extension or reconstruction theorem is included in this definition.

### 4.3 Base change with actual domains

For any ring map R → R′, pull back every chart, actual overlap, transition, coherence map and existing realization. Prove that the resulting glued scheme or stack is the base change of the original glued object. Prove the analogous comparison for a supplied action-groupoid quotient and for character lines. The pulled-back chart domains are part of the comparison. Do not replace them by the maximal regular domains of the specialized rational maps.

Prove preservation of open immersions and exact-overlap recognition by base change. Preserve a dense realization when it is S-universally schematically dense, meaning that C ×_S S′ → Y ×_S S′ is schematically dense for every S′ → S. Without that hypothesis carry the resulting open realization and assert density only when proved on the new base. The condition is relative to S, not to every base change into Y. For a fibre over a field κ, the supplied common-function-field pattern requires that every required specialized A exchange factor for a nonzero mutable direction be nonzero; X factors for nonzero directions are nonzero over every κ, and zero directions have the supplied identity mutation. Under these conditions the specialized field pattern and its maximal system are defined, but the inherited actual system is still not re-maximized. For the graded global-section algebra provide the natural base-change map; it is an isomorphism only when a relevant base-change theorem or a direct chart computation proves this.

**Checks.**

- For xx′ = 2 over ℤ, let C be the two tori glued over D(2). The integral chart intersection is ℤ[x,x′]/(xx′−2): in a Laurent expansion in x, the coefficient of x⁻ⁿ is divisible by 2ⁿ. On the 𝔽₂-fibre the two tori are disjoint and its functions are 𝔽₂[x±1] × 𝔽₂[x′±1]. The natural map from 𝔽₂[x,x′]/(xx′) is not surjective, for example onto (x⁻¹,0).
- The dense open Spec ℤ[1/2] → Spec ℤ pulls back to the empty open over 𝔽₂. Schematic density without universal density is insufficient for arbitrary base change.
- In characteristic two the exchange factor 1+z² = (1+z)² remains nonzero as a Laurent polynomial. Its nonreduced zero scheme must be retained; replacing integral exponent labels by their residues would give a false degeneration.

*Needs:* §§0.1–0.3, 1.3–1.4, 2.3 and 3.1–3.3; Mathlib localization and scheme base change; SchemeAndStackFoundations §§1.18–1.22 for stack and quasi-coherent base change; ClusterAlgebras §3.3 for localized mutations over arbitrary rings. GHK, Remark 4.2, p. 162, records the danger of retaining only specialized rational transitions.

### 4.4 Descent of split presentations

In this subsection allow an arbitrary base scheme S, with the preceding affine-base constructions on its affine opens. A descended marked presentation over S consists of a split presentation after an fppf covering family, a comparison on each pairwise fibre product using the permitted seed, grading and boundary transformations, and a coherent descent 2-isomorphism on each triple fibre product. These comparisons must identify the actual exchange domains and section identities. The seed lattices and index sets are transported by the supplied comparisons; a global ordering or a global coordinate frame is not chosen unless the descent data provide it. An étale-local torus form uses an arbitrary étale covering family; no single finite étale splitting cover is asserted.

- Descend the decorated geometric object in the 2-category of algebraic stacks and prove that its pullback recovers the given split presentation. Descend the recognized realization and any already specified monoidal line system and boundary data.
- For an individual torus chart, identify the descended affine form or torus torsor by effective affine descent. For a whole cluster locus, conclude that it is a scheme only when the descended charts give a representable open scheme cover or another supplier criterion proves schemeness; descent of an arbitrary scheme presentation does not by itself supply that conclusion.
- Compare two descended presentations using a common refinement of their base covers and the structured comparisons of §2.1. Keep their descent cocycles, including band and character-line obstructions.

**Checks.**

- In rank zero, descent of 𝔾_m over ℂ with conjugation acting by inversion on its character lattice gives the norm-one real torus. It need not have a split real character coordinate.
- The complement of the zero section in O(−1) over ℙ¹ is a 𝔾_m-torsor with locally split rank-zero charts. A global coordinate frame would trivialize O(−1), which this descent datum does not do.
- Translating z by a unit c changes 1+z to 1+cz. A purported descent datum using this translation but keeping the exchange section 1+z fixed fails unless its other specified data compensate for that change.

*Needs:* §§1.3–1.5, 2.1–2.2, 3.1 and 4.1–4.3; SchemeAndStackFoundations §§1.1–1.4, 1.15–1.19 and 1.22 for effective affine, algebraic-space and stack descent. This target concerns supplied compatible descent data, not a classification of nonsplit cluster forms.

### Examples

Regular toric frozen charts and their root stacks provide explicit boundary models. The rank-one family xx′ = 2 gives both loss of a common function field on a fibre and failure of global sections to commute with specialization. A descended rank-zero torus torsor explains why a coordinate must sometimes be treated as a local frame or a line-bundle section rather than as a global function.

### Dependencies

Layers 0–3 supply actual overlaps, coherent descent, quotient presentations and line systems. ClusterAlgebras §3.3 supplies regular toric charts and their scalar change. SchemeAndStackFoundations supplies root stacks, effective descent, dimension and depth. Full toric varieties over a fixed analytic field are not substituted for these arbitrary-base regular charts.

## Layer 5: global comparison, reconstruction and fixed objects

### 5.1 Ordinary upper algebras and an ambient completion

Let C be an integral marked scheme cluster locus over a domain, with dense overlaps and a common marked function field. Compare Γ(C,O_C) with the intersection of its chart rings using §3.3. For the maximal adapted A pattern this is the upper algebra U with the chosen frozen inversions. Given a dense open realization C → Y with Y integral, construct the injective restriction map Γ(Y,O_Y) → U. If Y is normal and Noetherian and Y ∖ C has codimension at least two, prove that this restriction is an isomorphism by the supplied Hartogs theorem. Keep this conclusion distinct from equality of C and Y and from the separate algebraic equality A = U.

For a maximal adapted A atlas over a domain, with the supplier's exchange nonvanishing conditions and all frozen coordinates inverted, prove that the canonical map C → Spec U is an open immersion. The Laurent theorem places every seed coordinate in U. For each seed s, inverting the product of its finitely many coordinates identifies U[(∏_i x_i)⁻¹] with the entire Laurent chart ring R[x_i±1], so each chart maps by an open immersion. The maximal-overlap corollary of §0.2 then proves the global assertion. This recovers GHK, Theorem 3.14, p. 160, by a route using the supplier's Laurent theorem, and does not extend it to arbitrary X loci, quotient stacks or arbitrary actual overlap systems. Where finite-chart computation is desired, use ClusterAlgebras §2.7 with all of its depth and cover hypotheses.

**Checks.**

- Over any field k, set R = k[x,y,z±1]/(xy−1−z). Eliminating z identifies Y = Spec R with Spec k[x,y,(xy−1)⁻¹], a smooth integral surface. The two seed tori cover C = Y ∖ {(0,0,−1)}. The complement has codimension two, so Γ(C,O) = R although C ≠ Y.
- In this rank-one pattern the cluster algebra with z inverted is generated by x, y and z±1, so A = R. The chart intersection and Hartogs comparison give U = R. Thus A = U = Γ(Y,O) does not make the chart union equal to Y.
- The schemes 𝔸² and 𝔸² ∖ {0} have the same global functions over a field. Normality and a coordinate-ring isomorphism alone do not identify a specified open completion with its locus.

*Needs:* §§0.3, 3.3 and 4.2; ClusterAlgebras §§1.4, 2.3, 2.7 and 3.3 for algebraic inclusions and upper algebras; native affine Hartogs and SchemeAndStackFoundations §0.6. The Hartogs input is also Stacks, Tag 0E9I. The exchange-surface computations follow directly from its displayed coordinate ring.

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

Prove that replacing the actual overlap downstairs by the largest domain of its rational coordinate transformation gives the wrong answer. That transformation is the identity on z, whose maximal domain is all of 𝔾_m; using it identifies the two points over −1 and destroys [C/H]. The quotient chart markings, degree data and inherited overlap must survive the quotient.

*Needs:* §§0.2, 1.1–1.4, 2.3, 3.2–3.3 and 5.1; SchemeAndStackFoundations §1.20 for inertia and §1.23 for the geometric-point condition in the definition of a coarse moduli space. The calculations use only the displayed equation and action. In characteristic two, −1 = 1 remains an invertible value, so the same distinction persists.

### 5.4 Automorphisms, extension and fixed objects

A structured automorphism of a realized pair is an invertible map of §2.2 preserving the required seed, line and boundary data up to their specified coherent comparisons. Its restriction to C, its action on the graded section algebra and its action on inertia are separate comparison maps. A mutation word returning to an isomorphic seed defines an automorphism only through its supplied geometric action; a loop in a word presentation is not an automorphism of every moduli object.

- For an integral normal affine Noetherian scheme Y and C ⊂ Y with complement of codimension at least two, prove that every automorphism of C extends uniquely to an automorphism of Y. Use Γ(Y,O) ≅ Γ(C,O), affine reconstruction and the naturality of the map to Spec Γ; apply the same argument to the inverse. Preservation of a chosen frozen model or line system requires that data to be preserved as well.
- For an algebraic stack C and an actual automorphism F, construct the fixed-object stack as the 2-fibre product of (id,F) : C → C × C with the diagonal. Its objects are pairs (x,α : x ≅ F(x)). Prove functoriality under structured conjugacy, with all 2-isomorphisms retained.
- For a specified action of a finite cyclic group of order r, identify the equivariant-object stack by imposing the additional relation Fʳ⁻¹(α) ··· F(α) α = id using the chosen comparison Fʳ ≅ id. The fixed-object stack for one automorphism alone does not impose this relation.

**Checks.**

- If F = id on C, its fixed-object stack is the inertia stack I(C). For C = BG this is [G/G] under conjugation, not just BG; for commutative G it is G × BG.
- For C = 𝔾_m and F(x) = x⁻¹, the fixed scheme has ring k[x±1]/(x²−1). The invariant ring k[x+x⁻¹] describes a different construction, and in characteristic two the fixed scheme is nonreduced.
- For the identity automorphism of B𝔾_m, an object of the fixed-object stack includes an arbitrary scalar automorphism. A trivial cyclic action of order r instead requires that scalar to satisfy aʳ = 1. Forgetting the cyclic relation gives the wrong equivariant objects.

*Needs:* §§2.1–2.3, 3.1 and 5.1–5.2; SchemeAndStackFoundations §§1.18–1.20 for 2-fibre products and inertia; Mathlib affine scheme reconstruction. The automorphism extension theorem is restricted to schemes with the stated affine and Hartogs hypotheses; no reconstruction of a general stack from its ordinary ring is asserted.

### Examples

The rank-one exchange surface simultaneously verifies chart recognition, a codimension-two remaining locus, equality of cluster and upper algebras, homogeneous quotient descent, a nonseparated quotient locus, and a stack completion with extra inertia. The family xx′ = 2 separates geometric base change from upper-algebra base change. The root model and the real nonneutral gerbe show independently why boundary stabilizers and line descent cannot be read from ordinary function rings.

### Dependencies

Layers 0–4 supply the realized and boundary data, structured maps and graded sections. ClusterAlgebras supplies the ordinary algebraic comparison. Native Hartogs and SchemeAndStackFoundations §0.6 supplies extension of existing sheaf sections. SchemeAndStackFoundations §§1.18–1.23 supplies inertia, fixed-object fibre products and the meaning of a coarse moduli space. No categorical, derived or scattering-theoretic recognition theorem is required.

## Downstream consumers

Moduli constructions can establish a cluster structure by giving the seed pattern, the marked chart maps and their actual 2-overlaps, then invoking recognition. A gauge quotient can use the equivariant presentation of §2.3; when its charts are invariant it also obtains the open quotient atlas. Boundary compactifications can supply cone, divisor and root data and invoke the section comparison without asserting that their cluster locus exhausts the ambient space.

Theta-basis and canonical-basis constructions can compare their functions or character sections with the upper section algebra, using the supplier's algebraic theorems and the explicit geometric realization here. Dynamical constructions can distinguish regular automorphisms of the locus, extensions to the chosen completion, invariant functions and fixed moduli objects. Derived and categorical consumers receive the marked geometric object and its actual stabilizers; any enhancement or categorification comparison requires its own additional theorem.

## References

- **GHK15.** Mark Gross, Paul Hacking and Sean Keel, *Birational geometry of cluster algebras*, Algebraic Geometry 2 (2) (2015), 137–175, [doi:10.14231/AG-2015-007](https://doi.org/10.14231/AG-2015-007), [open published PDF](https://api.algebraicgeometry.nl/Article/18588/2015-2-007.pdf). Proposition 2.4, p. 149, supplies maximal regular-domain gluing; Theorem 3.14, p. 160, concerns the standard A scheme and Spec of its upper algebra; Remark 4.2, p. 162, explains specialized identity transitions with proper inherited overlaps. These locators use the published pagination.
- **GHKK18.** Mark Gross, Paul Hacking, Sean Keel and Maxim Kontsevich, *Canonical bases for cluster algebras*, Journal of the American Mathematical Society 31 (2) (2018), 497–608, [arXiv:1411.1394v2](https://arxiv.org/abs/1411.1394v2). The cited locators are the arXiv v2 numbering and pagination: Remark B.8, pp. 116–117, for dependent and nonspanning mutable families; Construction B.9, p. 117, for specified frozen partial compactifications. They are not page references to the published journal version.
- **Stacks.** The Stacks Project Authors, *The Stacks Project*. [Tags 04YL, 0503, 0504 and 04YN in the open-immersion section](https://stacks.math.columbia.edu/tag/04YK); [Tag 06PB in inertia of quotient stacks](https://stacks.math.columbia.edu/tag/06PA); [Tag 06FI, algebraicity of flat locally finitely presented groupoid quotients](https://stacks.math.columbia.edu/tag/06FI); [Tag 06NZ, gerbes](https://stacks.math.columbia.edu/tag/06NY); [Tag 06QG, a gerbe with a section](https://stacks.math.columbia.edu/tag/06QG); [Tag 0E9I, coherent Hartogs](https://stacks.math.columbia.edu/tag/0E9I). General foundations are consumed through the exact supplier contracts above; the displayed elementary examples are proved from their equations and group actions.
