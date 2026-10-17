# Roadmap: wall-crossing structures

**Summary.** This roadmap constructs a degree-filtered sheaf of wall-crossing
structures for a Lie algebra graded by a positive submonoid of a lattice,
extending the Kontsevich-Soibelman finite-order construction. Its main theorem
identifies the global sections of this sheaf with the completed
Baker-Campbell-Hausdorff group:

$$
\widehat G \;\simeq\; \Gamma(V,\mathcal W_{\mathfrak g}),
\qquad
g\longmapsto\bigl(\theta\longmapsto\Pi^\theta_{0,k}(g_k)\bigr)_k.
$$

The construction is natural in graded Lie homomorphisms and independent of the
positive degree function used for completion. At each finite order, its sections
are locally middle factors in the sign decomposition of the BCH group. The
comparison with consistent wall presentations recovers their labels and path
products from the same group element. The reusable foundations are positive
gradings, nilpotent BCH groups, ordered factorization, and finite hyperplane
arrangements.

| Layer | Title | What it delivers | Depends on |
|---|---|---|---|
| [0](#layer-0-graded-lie-algebras-and-bch-groups) | Graded Lie algebras and BCH groups | positive gradings, nilpotent truncations, universal rational BCH and the completed group | Mathlib, Tau Ceti |
| [1](#layer-1-finite-order-wall-crossing-sheaves) | Finite-order wall-crossing sheaves | sign factorization, the sheaf of locally modeled middle factors, its stalks and global sections | 0 |
| [2](#layer-2-pronilpotent-wall-crossing-and-wall-presentations) | Pronilpotent wall crossing and wall presentations | the inverse-limit sheaf and its global classification; naturality; consistent finite-order wall presentations and their reconstruction | 0, 1 |

## Scope and ownership

The input is a fixed positively graded Lie algebra on a fixed lattice. The
geometric base is its real dual vector space. Homogeneous pieces can be arbitrary
modules over a commutative `ℚ`-algebra, and wall groups can be nonabelian. A finite
order has finitely many possible degrees; neither its Lie algebra nor its BCH
group is required to be a finite set or a finite-dimensional vector space.

This roadmap owns the algebraic BCH and WCS constructions below. The
[RepresentationTheory/LieGroups roadmap](../RepresentationTheory/LieGroups/README.md)
owns analytic local BCH. The
[RepresentationTheory/LieHighestWeight roadmap](../RepresentationTheory/LieHighestWeight/README.md)
supplies PBW through its existing Tau Ceti implementation, used here over `ℚ` in
the universal construction. General sheaf operations are supplied by Mathlib;
the new sheaf-specific material is the middle-factor local model and its
classification. Wall presentations use finite central hyperplane arrangements.
Affine outgoing completion, coefficient actions, broken lines and theta
functions are consumers of this theory rather than targets here.

General algebra belongs under `TauCeti/Algebra/Lie/` and
`TauCeti/GroupTheory/`; finite arrangement geometry under
`TauCeti/Geometry/HyperplaneArrangement/`; WCS and their wall presentations under
`TauCeti/Geometry/WallCrossing/`. Extend existing carriers and their APIs in their
existing library homes.

## Conventions and suppliers

1. A lattice `N` is a finite free `ℤ`-module. A real dual model consists of a
   finite-dimensional real normed space `V` and an `ℝ`-linear equivalence
   `V ≃ₗ[ℝ] (N →+ ℝ)`. Write `θ(n)` for evaluation. This specifies the topology
   and the pairing, including separation of nonzero lattice elements. The real
   functional obtained from an integral degree function `δ` is denoted by
   `δℝ ∈ V`.
2. Graded Lie algebras and their quotients are over a commutative ring `R`.
   BCH groups and every WCS statement use a commutative `ℚ`-algebra `R`.
   Evaluation of universal rational Lie polynomials uses scalar restriction to
   `ℚ`; Lie maps retain their `R`-linear structures. No freeness or flatness of
   the homogeneous pieces is assumed.
3. Order `k` retains degrees at most `k`: `g≤k = g/F^{k+1}g` and
   `G≤k = BCHGroup(g≤k)`. Order zero is trivial. The finite arrangement uses all
   allowed degrees at that order, including those with zero homogeneous piece.
4. Factorization is ordered `G₊(θ) · G₀(θ) · G₋(θ)`. Products act on the left:
   the first crossing is the rightmost factor. A wall cooriented by `n` and
   labelled `h` contributes `h` when `θ(n)` changes from positive to negative,
   and `h⁻¹` in the reverse direction. Thus a path `P` followed by `Q` has
   product `product(Q) * product(P)`.
5. The WCS sheaves are sheaves of **sets**, represented by
   `TopCat.Sheaf (Type _) V`. Middle-factor maps are functions, not group
   homomorphisms. The group structure transported to global sections by the
   classification theorem is not a pointwise group structure on the sheaf.
6. Declaration names in italics are suggested names. [Suggested.lean](Suggested.lean)
   prototypes selected carriers and statements; the README is definitive and
   supplies the complete scope.

The existing suppliers, used with their public meanings, are:

- `GradedLieAlgebra`, `DirectSum.Decomposition`, `DirectSum.decomposeLieEquiv`,
  `LieSubalgebra`, `LieIdeal`, `LieIdeal.mkQ`, `LieIdeal.liftQ`,
  `LieIdeal.lieHom_qext`, `LieRing.IsNilpotent`, and `lowerCentralSeries`.
  The quotient-map extensions are in `TauCeti.Algebra.Lie.Quotient`.
- `FreeLieAlgebra`, `FreeLieAlgebra.lift`,
  `FreeLieAlgebra.universalEnvelopingEquivFreeAlgebra`,
  `UniversalEnvelopingAlgebra`, and `IsNilpotent.exp`;
  `TauCeti.UniversalEnvelopingAlgebra.ι_injective` and
  `TauCeti.UniversalEnvelopingAlgebra.pbwAssociatedGradedEquiv` from
  `TauCeti.Algebra.Lie.UniversalEnveloping.PBW.Embedding` and `.Injective`.
  Their freeness hypotheses are discharged over `ℚ` for the universal proof.
- `GrpCat.sectionsSubgroup`, `GrpCat.limitCone`, `Subgroup`, `MonoidHom`,
  `AddSubmonoid`, `Module.Free`, `Module.Finite`, `LinearEquiv`, convex sets,
  finite-dimensional linear algebra, and piecewise-linear paths specified by
  finite lists of vertices.
- `TopCat.PrelocalPredicate.sheafify`, `TopCat.subsheafToTypes`, and
  `TopCat.stalkToFiber` in `Mathlib.Topology.Sheaves.LocalPredicate`;
  `TopCat.Sheaf.forget` and the limits API in
  `Mathlib.Topology.Sheaves.Limits`. These supply locality, gluing, stalks and
  limits; the required hypotheses for the WCS local predicate are proved here.

## Layer 0: graded Lie algebras and BCH groups

### 0.1 Positive gradings and truncations

*PositiveDegrees* consists of an additive submonoid `P ⊆ N` and an additive
`δ : N → ℤ` such that `δ(n)>0` for `n∈P\{0}` and
`{n∈P | δ(n)≤k}` is finite for every `k∈ℕ`. Write `N⁺=P\{0}` and
`S_k={n∈N⁺ | δ(n)≤k}`. Finite generation of `P` is not part of the input.

A positive grading on an `R`-Lie algebra `g` is Mathlib's `GradedLieAlgebra`
decomposition `g_n : N → Submodule R g`, with `g_n=0` outside `N⁺`.
*degreeIdeal* `F^a g` is the sum of pieces with `δ(n)≥a`; *truncatedLie*
`g≤k` is the quotient by `F^{k+1}g`. A *GradedLieHom* is an `R`-linear Lie
homomorphism preserving the `N`-grading.

*Targets.*
- `P` is sharp, bounded-degree slices and decompositions `n=a+b` in `P` are
  finite, and `S_k` increases with `k` and exhausts `N⁺`. Construct the example
  `P=ℕ^r ⊆ ℤ^r`, `δ(n)=Σ n_i`.
- The `F^a g` are graded Lie ideals, `F^0g=F^1g=g`, and
  `[F^a g,F^b g]⊆F^{a+b}g`. They are separated. The quotient `g≤k` inherits its
  direct-sum grading, supported on `S_k`, and is nilpotent of class at most `k`.
- For `k≤j`, construct the surjective transition `g≤j →ₗ⁅R⁆ g≤k`, with its
  value on quotient classes, identity and composition laws. The kernel of
  `g≤k+1 → g≤k` is central and is the direct sum of the images of the pieces
  with `δ(n)=k+1`.
- A graded Lie homomorphism induces compatible maps on all truncations.
  Graded Lie subalgebras and quotients by graded Lie ideals retain their
  homogeneous decompositions. Restriction of scalars preserves these
  constructions and their underlying maps.

*Route:* Use homogeneous induction for the ideal and bracket statements. The
direct-sum decomposition separates the low- and high-degree summands, giving the
quotient grading and the central kernel explicitly.

**Checks.** An infinite-dimensional abelian `g_1` is allowed. The monoid
`{0} ∪ {(a,b)∈ℤ² | a≥b≥1}` with `δ(a,b)=a` is an example with finite cutoffs
without finite generation.

*Needs:* the graded Lie, direct-sum and quotient APIs listed above.

### 0.2 Universal nilpotent BCH groups

For a nilpotent `R`-Lie algebra `a`, *BCHGroup a* has underlying set `a`, with
`exp : a ≃ BCHGroup a`, identity `exp 0`, and multiplication given by the
universal rational BCH Lie polynomials. Its inverse equivalence is `log`.
The nilpotency bound controls the length of the evaluated Lie words.

*Targets.*
- Construct the homogeneous universal rational Lie polynomials `BCH_d(X,Y)`
  of bracket length `d≥1`. In the free associative algebra on `X,Y`, truncated
  above word length `c`, their sum through `c` maps to
  `log(exp X exp Y)`, where exponential and logarithm are finite sums in the
  augmentation ideal. Prove that this logarithm is a Lie element, its
  uniqueness under the free-Lie embedding, and compatibility in `c`.
- Evaluation `BCH(x,y)=Σ_{d≤c} BCH_d(x,y)` in an algebra of nilpotency class
  at most `c` is independent of the chosen bound. It is associative, has zero
  as identity and negation as inverse, and defines *BCHGroup*.
- *BCHGroup.map* sends an `R`-linear Lie homomorphism between nilpotent
  algebras to the group homomorphism `exp x ↦ exp(f x)`, with identity,
  composition and scalar-restriction laws. Inclusions of Lie subalgebras
  identify their BCH groups with subgroups. Lie ideals give normal subgroups,
  and BCH identifies the Lie quotient with the group quotient.
- For commuting `x,y`, `exp x exp y=exp(x+y)`. Central Lie ideals give central
  subgroups. For a decreasing family of Lie ideals with `F^0=a` and
  `[F^a,F^b]⊆F^{a+b}`, the group
  commutator of `exp(F^a)` and `exp(F^b)` lies in `exp(F^{a+b})`.
  Apply these constructions to *truncatedGroup* `G≤k=BCHGroup(g≤k)` and its
  quotient maps.

*Route:* Work universally over `ℚ` in the free Lie algebras on two and three
generators and their free associative enveloping algebras. Prove the
homogeneous Dynkin Lie-polynomial identity for `log(exp X exp Y)` there;
associativity follows from the associative product and the injective
free-Lie embedding. Evaluate the resulting identities in the scalar
restriction of `a`. This route uses PBW over `ℚ` and does not require a PBW
theorem for arbitrary `R`-modules or a completed enveloping algebra.

**Checks.** Through bracket length three the expression is
`X+Y+[X,Y]/2+([X,[X,Y]]+[Y,[Y,X]])/12`. In the Heisenberg Lie algebra with
`[X,Y]=Z` central, `log(exp X exp Y)=X+Y+Z/2`.

*Needs:* §0.1 for its applications; free Lie and enveloping algebras, the
existing PBW embedding over `ℚ`, and finite algebraic exponential and logarithm.
Sources: REU, Chapter 3; BRI §2.2.

### 0.3 Completed groups

For a tower of groups `G_k` with transition homomorphisms, the completed group
is the compatible-family group supplied by `GrpCat.sectionsSubgroup` for the
associated functor `ℕᵒᵖ ⥤ GrpCat`. For the BCH tower write
`Ĝ=lim_k G≤k`, with *projection* `pr_k : Ĝ →* G≤k`. Put
`F^0Ĝ=Ĝ` and `F^aĜ=ker(pr_{a-1})` for `a≥1`.
On the product of homogeneous pieces, define the bracket by the finite
component formula `[x,y]_n=Σ_{a+b=n}[x_a,y_b]` from §0.1.

*Targets.*
- Give the compatible-family description, projection extensionality and the
  universal property for compatible families of homomorphisms. Compatible
  maps of towers induce group homomorphisms on their limits, functorially.
- For the BCH tower, the projections are surjective, the `F^aĜ` are
  decreasing and separated, `Ĝ/F^{k+1}Ĝ ≃* G≤k`, and
  `[F^aĜ,F^bĜ]⊆F^{a+b}Ĝ`. Identify its underlying set through `log` with
  `∏_{n∈N⁺} g_n`, compatibly with truncation and the completed Lie bracket.
- If `δ` and `δ'` are two positive degree functions on `P`, their degree
  ideals are cofinal. The cutoff
  `λ(k)=max({0}∪{δ(n) | n∈P, δ'(n)≤k})` induces quotient maps from the
  `δ`-truncation at `λ(k)` to the `δ'`-truncation at `k`. These give
  *changeDegreeEquiv*, with the identity and composition laws and the same
  coordinate in every homogeneous piece. Graded Lie maps commute with it.

*Route:* Use the existing group-limit construction. For cofinality use the
finite cutoff sets directly; compare two induced maps after a common finite
cutoff. For the BCH tower, lifting a finite tuple of homogeneous components
gives surjectivity.

**Checks.** Replacing `δ` by `2δ` changes finite truncations and leaves the
completed group canonically isomorphic. Completion is not finite-dimensional
even when every homogeneous piece is one-dimensional.

*Needs:* §§0.1-0.2; limits of groups and the finite-support direct-sum API.

## Layer 1: finite-order wall-crossing sheaves

Fix an order `k`, put `G=G≤k`, and write `g_{n,k}` for its homogeneous pieces.
All statements in this layer also apply to any positive-graded Lie algebra
whose support is contained in `S_k`.

### 1.1 Ordered and sign factorization

For `θ∈V`, let `g₊(θ)`, `g₀(θ)` and `g₋(θ)` be the sums of the pieces on
which `θ(n)` is positive, zero and negative, and let `G₊(θ)`, `G₀(θ)` and
`G₋(θ)` be their BCH subgroups.

*Targets.*
- For a finite ordered decomposition of `g≤k` as a direct sum of graded Lie
  subalgebras `h_1,…,h_r`, multiplication in that order is a bijection
  `BCHGroup(h_1)×⋯×BCHGroup(h_r) → G`. The inverse factors are natural for
  Lie maps preserving the specified summands and commute with truncation.
- The three sign sums are Lie subalgebras and give such a decomposition.
  Define the uniquely determined factors `Π₊^θ(g)`, `Π₀^θ(g)`, `Π₋^θ(g)`
  by `g=Π₊^θ(g) Π₀^θ(g) Π₋^θ(g)`. Give the factorization, uniqueness,
  subgroup-retraction, identity and naturality lemmas. At `θ=0`, the middle
  factor is `g`; if all `θ(n)>0`, the plus factor is `g`, and if all
  `θ(n)<0`, the minus factor is `g`.
- Define the open neighborhood
  `U_θ={η | sign η(n)=sign θ(n) for n∈S_k with θ(n)≠0}`.
  For `η∈U_θ`, prove
  `Π₀^η(g)=Π₀^η(Π₀^θ(g))`, with both sides viewed in `G`.
  Consequently the equality locus
  `{θ | Π₀^θ(g)=Π₀^θ(h)}` is open, and all three factor maps are constant
  on a fixed sign stratum of the finite degree arrangement.

*Route:* Induct on the degree cutoff. At each step the central kernel from
§0.1 is the direct sum of its intersections with the specified summands, so
the factorization defect has a unique central correction in each factor.
For the neighborhood identity, the positive and negative factors at `θ`
remain positive and negative at `η`; factor the middle one at `η` and apply
uniqueness. This proves the openness statement without a dimension assumption
on the homogeneous pieces.

**Checks.** For the Heisenberg grading over `ℚ`
`deg X=(1,0)`, `deg Y=(0,1)`, `deg Z=(1,1)` and `θ(a,b)=a-b`,
`Π₀^θ(exp Y)=Π₀^θ(exp X)=1`, but
`Π₀^θ(exp Y exp X)=exp(-Z)`. Inverting a factorization converts the
`+·0·−` convention to `−·0·+` and inverts its middle factor.

*Needs:* §§0.1-0.2; finite-dimensional continuity of evaluations.
Sources: KS §2.1.2; BRI §3.2, equation (5).

### 1.2 The finite WCS sheaf

For an open `U⊆V`, a local model is a dependent function
`s : ∀θ∈U, G₀(θ)` of the form `s(θ)=Π₀^θ(g)` for one `g∈G`.
The restriction-stable predicate expressing this is a
`TopCat.PrelocalPredicate`. Apply its `.sheafify` and
`TopCat.subsheafToTypes` to define *finiteWCSSheaf* `W_k`.
Explicitly, `s∈W_k(U)` means that for every `θ∈U` there is an open
neighborhood `O⊆U` and an element `g∈G` such that
`s(η)=Π₀^η(g)` for every `η∈O`.

*Targets.*
- Identify the sections of `W_k` with precisely these locally modeled
  functions. Restrictions are function restriction, equality is pointwise,
  and compatible local sections glue with their given values. Reuse the
  sheaf proof from the local-predicate API.
- *finiteStalkEquiv*: evaluation induces an equivalence of sets
  `(W_k)_θ ≃ G₀(θ)`. Under this equivalence, the germ of the model attached
  to `g` maps to `Π₀^θ(g)`. At the origin the stalk is `G`; off all the
  degree hyperplanes it is a singleton. The restriction of a section to any
  sign stratum is locally constant, with values in its fixed zero subgroup.
- The identity model gives a distinguished section on every open set, and
  model formation commutes with restriction. For any open `U` and `g,h∈G`,
  the two models have the same germ at `θ∈U` exactly when
  `Π₀^θ(g)=Π₀^θ(h)`.

*Route:* Surjectivity of stalk evaluation follows by taking a representative
`g` in `G₀(θ)`. For injectivity, represent both germs by local models and use
the open equality locus in §1.1. Apply the existing `stalkToFiber` criteria.

**Checks.** In rank one the sheaf has stalk `G` at zero and a singleton
elsewhere. In the Heisenberg example of §1.1, pointwise multiplication of the
models for `exp Y` and `exp X` is not a section: its value at zero would force
the model for `exp Y exp X`, whose middle value differs at the stated `θ`.

*Needs:* §1.1; `Mathlib.Topology.Sheaves.LocalPredicate` and the stalk API.
Source: KS Definition 2.1.4 and its preceding local-model construction.

### 1.3 Global sections and finite reconstruction

*Targets.*
- *finiteGlobalEquiv*: the model map
  `G ≃ Γ(V,W_k)`, `g↦(θ↦Π₀^θ(g))`, is an equivalence of sets whose
  inverse is evaluation at zero. State both inverse identities and the
  evaluation formula at every `θ`.
- For any section on `V`, its restriction to each ray `ℝ_{>0}θ` is constant
  in the fixed subgroup `G₀(θ)`. The same holds on every connected component
  of the intersection of an open set with a sign stratum. This gives the
  uniqueness needed for the global theorem.

*Route:* Near zero a section has the model of its value `g` at zero. Along
each positive ray every local model has a fixed sign factorization. Local
constancy and connectedness therefore propagate the equality with the model
of `g` from a small positive multiple of `θ` to `θ`. Surjectivity and
injectivity of the model map follow, including at zero.

**Checks.** If `g` is abelian and concentrated in degree `(1,0)`, then on
`U=ℝ²\{0}` the two components of `U∩{θ_1=0}` may carry independent values.
Such a section extends to `V` exactly when the two values agree. The
definition on arbitrary opens therefore retains local wall data.

*Needs:* §1.2; connectedness of intervals and convex sign strata.
Source: KS Theorem 2.1.6 and Lemma 2.1.7.

## Layer 2: pronilpotent wall crossing and wall presentations

### 2.1 The completed WCS sheaf and its global classification

The quotient maps `G≤j → G≤k` for `k≤j` preserve each sign subgroup and
commute with middle factors. Acting pointwise on local models defines
transition morphisms `W_j → W_k`. Define *wcsSheaf*
`W_g = lim_k W_k` in `TopCat.Sheaf (Type _) V`.

*Targets.*
- Construct the sheaf transition morphisms, with their evaluation formulas,
  identity and composition laws. The finite global equivalences commute with
  these morphisms and with the group quotient maps.
- Identify `W_g(U)` with compatible families `s_k∈W_k(U)`, naturally in the
  open set `U`. The local-model neighborhood and its witnessing group element
  may depend on `k`. Give restrictions, projections, extensionality and the
  universal property, using the existing fact that the sheaf forgetful
  functor creates limits.
- *globalWCSEquiv*: construct the main equivalence
  `Ĝ ≃ Γ(V,W_g)` with order-`k`, point-`θ` value
  `Π₀^θ(pr_k g)`. Its inverse is the compatible family of values at zero.
  State the two inverse identities and commutation with finite-order
  classification. In particular a global WCS determines, and is determined
  by, its finite-order middle factors.
- Completed sign subgroups are the limits of the finite ones. Their ordered
  multiplication `Ĝ₊(θ)×Ĝ₀(θ)×Ĝ₋(θ) → Ĝ` is a bijection, with factors
  given by their finite projections. Evaluation of a section at `θ` means
  its compatible family of finite values in `Ĝ₀(θ)`.

*Route:* Construct the inverse limit in the existing sheaf category and use
its sectionwise description. Pass the mutually inverse finite global maps,
and the finite sign factorizations, to compatible families.

**Checks.** Finite stalk equivalences do not identify completed stalks with
limits of those stalks. For the abelian example with `g_(m,m+1)=ℚ`, `m≥1`,
and `δ(a,b)=a+b`, take the completed element with every displayed coordinate
equal to `1`. At `θ=(1,-1)` every finite-order stalk value is zero, but its
section has a nonzero germ: the walls through
`η_m=(1+1/m,-1)` accumulate at `θ`. Formalize this example using the
sectionwise limit description. Stalk classifications in this roadmap are
the finite-order statements of §1.2.

*Needs:* §§0.3, 1.1-1.3; `Mathlib.Topology.Sheaves.Limits`.
Source: KS §2.1.3 and Proposition 2.1.12 for the strict-cone construction;
the degree-filtered extension here uses the finite-cutoff hypotheses of §0.1.

### 2.2 Naturality and independence of the degree function

*Targets.*
- A graded Lie homomorphism on the same `(N,P,δ)` induces a morphism of
  finite WCS sheaves and of completed WCS sheaves. Its value is the induced
  group map on each zero subgroup. Prove identity, composition and
  restriction laws, and the commuting squares with *finiteGlobalEquiv*,
  *globalWCSEquiv* and every cutoff projection. A map to a Lie algebra over
  another coefficient ring is treated through scalar restriction.
- For `δ,δ'` on the same `(N,P)`, the cofinal quotient maps of §0.3 induce
  *changeDegreeSheafIso* on the whole sheaf, naturally on every open set.
  It commutes with the global equivalence and *changeDegreeEquiv*, with
  graded Lie maps, and with identity and composition of changes of degree.
- An additive lattice isomorphism carrying `P` onto `P'` and preserving the
  specified degree function, together with the corresponding reindexing of
  the Lie grading, transports all constructions along the induced dual
  linear homeomorphism. Give the section equivalences on corresponding
  open sets, their restriction and composition laws, and their evaluation
  on local models. Combine with *changeDegreeSheafIso* when degree functions
  differ.

*Route:* Uniqueness of sign factorization proves naturality before any sheaf
construction. For changed degrees, use the actual quotient maps at cofinal
orders and check the inverse identities after every finite projection. For
lattice reindexing, transport the explicit local-model predicate along the
dual homeomorphism.

**Checks.** Quotienting the Heisenberg algebra over `ℚ` by its center sends
the distinct models of `exp X exp Y` and `exp Y exp X` to the same global
section. Naturality does not require, or
imply, injectivity of the coefficient map. The change from `δ` to `2δ` is
an isomorphism of completed sheaves despite its different finite-order
hyperplane arrangements.

*Needs:* §§0.1-0.3, 1.1-1.3, 2.1; existing sheaf morphisms and transport
along homeomorphisms. Sources: KS §2.1; BRI §2.10.

### 2.3 Finite central arrangements and generic polygonal paths

A finite central integral hyperplane arrangement `A` in `V` is a finite set
of distinct kernels `H_n={θ | θ(n)=0}`, `n∈N\{0}`, with a chosen nonzero
normal for each hyperplane. Its sign strata are the nonempty sets specified
by one of `<0`, `=0`, `>0` for each chosen evaluation. Chambers have no zero
signs. A wall stratum has exactly one distinct hyperplane with zero sign.
Hyperplanes are identified by their kernels, so proportional normals do
not create extra intersections.

A *GenericPLPath A* is a nonempty finite vertex list with all vertices off the
hyperplanes, whose segments avoid intersections of two distinct
hyperplanes. Crossings are ordered along the segments and then along the
vertex list. A segment crossing a hyperplane does so once and transversely,
in one wall stratum. A singleton list is the constant path. Endpoints are
the first and last vertices and are regular points.

*Targets.*
- Sign strata are convex, the chamber and wall strata are relatively open
  in their linear spans, and there are finitely many of them. Evaluations
  are continuous; nonzero normals give proper hyperplanes. The complement
  of a finite union of proper affine subspaces is dense in every nonempty
  open set.
- Any two regular points in an open convex set can be joined within it by
  a generic polygonal path, using one intermediate point. Reversal,
  concatenation at matching endpoints and subdivision at regular points
  preserve the appropriate crossing lists,
  with explicit ordering laws.
- If `A` contains every `H_n`, `n∈S_k`, then its regular points meet both
  open cones `C_±={θ | ∀n∈S_k, ±θ(n)>0}`. Through every point of a wall
  stratum there is a line `θ-tv`, with `v(n)>0` for all `n∈S_k`, meeting
  distinct hyperplanes at distinct parameter values and having regular
  endpoints in `C_+` and `C_-`. The direction can be chosen transverse to
  every hyperplane in `A`. Such lines provide generic test paths through
  every wall stratum.

*Route:* Use finite sign inequalities and finite-dimensional linear algebra.
Bad choices for an intermediate point lie in the affine spans of an
endpoint with an intersection of two hyperplanes. For the line through
`θ`, equality of crossing times is
`θ(n)v(m)=θ(m)v(n)`; discard the finitely many proper linear loci in the
nonempty open cone of positive directions, together with the kernels
`v(n)=0` for the normals in `A`. Normals defining the same hyperplane have
already been merged.

**Checks.** The arrangement from `e_1` and `2e_1` has one hyperplane and no
intersection of distinct hyperplanes. With all degrees on one ray in a
rank-two lattice, the wall is an entire line; no salient-fan hypothesis is
imposed.

*Needs:* §0.1 and Convention 1; finite-dimensional linear algebra, convexity,
finite lists and finite unions. Sources: KS §2.1.1 and Lemmas 2.1.8-2.1.9;
BRI §§2.3-2.7 and the proof of Lemma 3.1.

### 2.4 Wall presentations and reconstruction

At order `k`, let `A` contain every hyperplane from `S_k`. For a hyperplane
`H∈A`, put `g_H=⊕_{n∈S_k, H_n=H} g_{n,k}` and `G_H=exp(g_H)`.
Normals on such degree hyperplanes point along the positive degree ray;
additional hyperplanes have the trivial wall group and any coorientation.
An *ArrangementPresentation A k* assigns one element `h_F∈G_H` to every
wall stratum `F⊂H`. Its path product is the reversed ordered product of
crossing contributions from Convention 4. It is *Consistent* when every
generic polygonal loop has product `1`.

*Targets.*
- The `g_H` are Lie subalgebras. Define path products and prove identity,
  reversal, concatenation, subdivision at regular points and
  coorientation-change laws.
  Consistency is equivalent to dependence only on the endpoints. For a
  consistent presentation, transport between regular points of either
  `C_+` or `C_-` is `1`, so *totalTransport* from a regular point of `C_+`
  to a regular point of `C_-` is well-defined.
- For `g∈G≤k`, *reconstruct* labels `F` by `Π₀^θ(g)`, `θ∈F`.
  The value is independent of `θ` and belongs to `G_H`. This presentation
  is consistent and, for any generic path from `a` to `b`, has product
  `Π₊^b(g)⁻¹ Π₊^a(g)`. Its total transport is `g`.
- *presentationEquiv*: total transport is a bijection from consistent
  presentations on `A` to `G≤k`, inverse to *reconstruct*. For a consistent
  presentation, its label on every `F` is the middle factor of its total
  transport. Composing with *finiteGlobalEquiv* identifies such
  presentations with `Γ(V,W_k)` and matches every wall label.
- Adding finitely many central integral hyperplanes refines a presentation
  by retaining labels on subdivided old wall strata and inserting identity
  labels on new hyperplanes. Refinement preserves products on common
  generic paths and induces a bijection on consistent presentations. Two
  consistent presentations on different arrangements are equivalent when
  their products agree on paths generic for the union arrangement; this
  holds exactly when their total transports agree. Prove the equivalence
  relation and its compatibility with Lie maps and lattice reindexing.
- Let `A_k` be the arrangement of `S_k`. Project a consistent presentation
  on `A_{k+1}` to `G≤k`, then use the refinement bijection to descend it
  uniquely to `A_k`. These are the transition maps for *CompletedPresentation*,
  the type of compatible families of consistent finite presentations.
  Construct the equivalences
  `CompletedPresentation ≃ Ĝ ≃ Γ(V,W_g)`, commuting with every finite
  projection, graded Lie map and change of degree. Thus the completed
  reconstruction is expressed entirely by its finite-order wall products.

*Route:* For canonical labels check the displayed product formula at a
single crossing, then telescope. Conversely, use §2.3's line through a
wall point. Its factors before the crossing belong to `G₋(θ)`, those after
it to `G₊(θ)`, and the crossing itself to `G₀(θ)`. With the left-action
order this is a `+·0·−` factorization of the total transport, so §1.1
recovers its middle factor. This proves uniqueness and the refinement
comparison. Apply the finite equivalences levelwise for completion.

**Checks.** In rank one, with Heisenberg degrees `deg X=deg Y=1`,
`deg Z=2`, reconstruction is the single wall `{0}` with its full group
element as label. In the rank-two Heisenberg example of §1.1 at order two,
take the two coordinate axes and `H_(1,1)`. Label the horizontal axis by
`a=exp Y`, the vertical axis by `b=exp X`, and `H_(1,1)` by `1`, with
the positive degree coorientations. The generic counterclockwise square
`(1,1)→(-2,1)→(-2,-2)→(1,-2)→(1,1)` has product `a⁻¹b⁻¹ab≠1` over
`ℚ`; such a presentation is inconsistent.

*Needs:* §§0.1-0.3, 1.1-1.3, 2.1-2.3. Sources: KS Theorem 2.1.6;
BRI Propositions 3.3-3.4, with the arrangement presentation specified here.

## Completion criteria

The roadmap is complete when its positive-grading and BCH APIs are usable
independently, the local-model predicate gives the stated finite WCS sheaves
and stalks, and *globalWCSEquiv* is proved with its finite evaluation formula,
naturality and degree-independence. The finite arrangement comparison must
recover wall labels and path products and give the compatible completed
presentation theorem. All Targets and Checks are part of this specification;
proving only the suggested Lean declarations does not discharge it.

## References and API design

- **KS:** Kontsevich and Soibelman, *Wall-crossing structures in
  Donaldson-Thomas invariants, integrable systems and Mirror Symmetry*,
  [arXiv:1303.3253](https://arxiv.org/abs/1303.3253), §§2.1.1-2.1.3.
  KS uses strict-cone support in its completed construction. Here completion
  is controlled by the positive degree function and finite cutoffs of §0.1;
  those hypotheses also allow monoids whose closed real cone is not strict.
  Convention 4 fixes the `+·0·−` order; inversion compares it with the
  `−·0·+` order in KS.
- **BRI:** Bridgeland, *Scattering diagrams, Hall algebras and stability
  conditions*, [arXiv:1603.00416](https://arxiv.org/abs/1603.00416), §§2-3.
  The Hall-algebra constructions are sources of applications of the graded
  input, not prerequisites of this roadmap.
- **REU:** Reutenauer, *Free Lie Algebras*, Oxford University Press, 1993,
  [Chapter 3, Logarithms and exponentials](https://doi.org/10.1093/oso/9780198536796.003.0004),
  for universal BCH and the free Lie algebra inside the tensor algebra.
- Mathlib's local-predicate and sheaf-limit modules cited above provide the
  sheaf carriers. The API direction discussed in
  [Mathlib #33795](https://github.com/leanprover-community/mathlib4/pull/33795)
  and [#31925](https://github.com/leanprover-community/mathlib4/pull/31925)
  is the local-predicate construction with explicit stalk criteria. Use
  those interfaces for any missing extension and adopt the Mathlib
  declarations when available.
