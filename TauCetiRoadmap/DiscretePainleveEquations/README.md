# Roadmap: discrete Painlevé equations

**Summary.** Construct discrete Painlevé dynamics in two independently defined settings: moduli of
linear difference objects with specified local lattices and modification correspondences,
and marked rational anticanonical surfaces with a specified Cremona time element. Prove
comparisons between these constructions, including their parameter spaces, domains,
symplectic forms, and time steps. Matrix equations are presentations of these objects.

The complete comparison examples are Jimbo–Sakai `qPVI` and the elliptic
Painlevé equation. Their common linear infrastructure is the geometry of sheaf
bimodules of birank `(2,2)` and the associated noncommutative ruled surfaces.
An ordinary difference connection is one important presentation; a stable sheaf
moduli space supplies a completion when one presentation does not cover the phase space.

The geometric development includes Sakai's finite classification of surface types and
the realization of their symmetry groups. A surface type does not specify a unique
discrete equation: the translation and the parameter action are additional data.

## Scope and ownership

The README specifies the constructions and theorems. [Suggested.lean](Suggested.lean)
states selected headline theorems on native library objects; its module documentation
identifies the geometric statements that require the preceding constructions.

Every numbered target is required. General constructions include their objects,
morphisms, identity and composition laws, pullbacks, and the comparisons specified below.
An external roadmap supplies only its cited results with their hypotheses. Literature
citations identify proof sources; they do not assert that the corresponding Lean API exists.

This roadmap owns the relative marked comparison in 4.4–5.4, the presentation
and scalar dictionaries in 6.3 and 7.4, the operator-side tau comparison in 8.3,
and the specialization of operator moduli in 9.1–9.3. The fieldwise stable-moduli
theorem, the coordinate Lax theorem, and the geometric confluence theorem are
separate inputs to these constructions, with their hypotheses stated at use.

The two complete linear examples have rank two. The reusable connection and modification
theory admits arbitrary finite rank on a smooth projective curve; the noncommutative
ruled-surface theory has birank `(2,2)`. Surface classification is not a claim that
every surface type has a rank-two connection realization or a nonzero translation.
The analytic comparison is the regular-singular `qPVI` Riemann–Hilbert
problem. A general elliptic Riemann–Hilbert equivalence, all higher-rank Garnier systems,
a completeness classification of special solutions, and a uniform analytic confluence
theorem for the entire Sakai diagram are outside the specification.

### The objects that comparisons must distinguish

| Object | What varies | Meaning of a point or arrow |
|---|---|---|
| Parameter space `B` | Curve, correspondence, local type, determinant, markings | A linear problem, not its solution |
| Connection stack `𝔠_λ` | Bundles and difference maps with that type | A linear object with its regular isomorphisms |
| Stable operator-sheaf stack `𝔐_λ` | Coherent sheaves on the specified operator surface | An object of a fixed numerical class and stability condition |
| Coarse phase `M_λ` | Isomorphism classes after scalar descent | A nonlinear initial condition |
| Sakai pair `(X_λ,D_λ)` | A marked compact rational surface and boundary | Its open phase is `U_λ=X_λ∖D_λ` |
| Analytic connection-data space `ℛ_λ` | Connection matrices modulo their analytic equivalences | Riemann–Hilbert data |
| Modification correspondence | Source and target local types | A prescribed change of lattices defining a time step on its domain |

The moduli of marked pairs parametrizes the *surfaces* `X_λ`; it is not their
two-dimensional phase fiber. A simple-object stack usually has scalar
`𝔾_m`-inertia; it is not its coarse space. A polynomial matrix chart can
omit an entire curve from `U_λ`. The analytic Riemann–Hilbert map has its own
target and is not asserted to be algebraic.

The principal comparison therefore has the following form:

    𝔠_λ^pres ≃ 𝔐_λ^pres,     M̄_λ ≅ X_λ,     M_λ° ≅ U_λ,
    ι_(Tλ) ∘ H_T = T_X ∘ ι_λ.

on the expressly constructed presentation/modification domains. Here
`M̄_λ` is the stable sheaf moduli constructed in Layer 4, and
`M_λ°` is its locus of derived disjointness from the operator
anticanonical curve. Coverage by presentation charts, extension to a whole phase,
and compatibility of the extensions are separate conclusions in Layers 6 and 7.
No one of these statements is the definition of the others.

## Conventions

- Algebraic applications are over an algebraically closed field `k` of characteristic
  zero, except the field-independent splitting theorem in 1.4. Relative
  statements use locally Noetherian `k`-schemes. Analytic statements
  specialize to `ℂ`. Connection ranks are positive and all specified polar divisors
  are effective relative Cartier divisors.
- A difference connection is a vector bundle `V` on the *whole* curve `C` with a
  meromorphic isomorphism `Φ:V⇢σ*V`.
  Its arrows are regular bundle isomorphisms `g` satisfying
  `Φ' g=(σ*g)Φ`. For column solutions `Y(σz)=A(z)Y(z)`,
  the conventions are `A'=σ(g)Ag⁻¹` and `F_A=A⁻¹σ`.
  The generic semilinear module forgets the local lattices.
- An equation–sheaf presentation declares its variance. Target 6.3 uses the
  covariant presentation `(id,A)`; its meromorphic Hom solution functor gives
  the dual column equation `Y(qx)=A(x)^(−t)Y(x)`. Target 6.4 defines column
  solutions directly from the original connection. The elliptic presentation
  in 7.2 uses the transpose presentation to recover its stated column equation.
  These dualities and scalar normalizations are part of the comparisons.
- For a modification `R:V⇢V'`, write
  `A'R=σ(R)A`. A spectral automorphism and a time automorphism are distinct,
  even when both use the number `q`.
- A local relative position `(m₁,…,m_r)`, listed in weakly decreasing order,
  means that, in regular local frames,
  the meromorphic map is equivalent to
  `diag(u^(m₁),…,u^(m_r))`. Positive entries are zeros.
  Local formal types include the relevant line-bundle identifications; a numerical
  eigenvalue is used only after trivializing the polar line.
- `𝒮` denotes an operator surface, `Q` its commutative anticanonical
  curve, `X` a commutative phase surface, and `D` its boundary. Identifications
  between `Q` and `D` are conclusions of comparison theorems.
- The Picard intersection form has signature `(1,9)`;
  `δ=-K_X`. A marking is an isometry from the stated model lattice to
  `Pic(X)`, with canonical class, boundary classes, and the chosen
  effective chamber retained. Pullback of divisor classes determines the convention
  for a geometric transformation.
- On an elliptic curve, the nome `p` and the difference step `q` are independent.
  Algebraic definitions do not choose an origin unless a group-law coordinate requires it.
- For each *finite word* `w` of modifications, construct its domain `B_w` and
  its source and target phase domains. Conditions excluding every `q^ℤ`
  resonance, or every translated root wall, can be countably infinite.
  Their intersection is not called a Zariski-open finite-type base without a proof.
  Statements about all iterates either retain these pointwise hypotheses or use
  the domain groupoid of 0.1.

## Exact supplier contracts

### From Mathlib

Use `Scheme`, `Scheme.Modules`, their pullbacks, linear equivalences and categorical
localizations. Consume the separated-morphism and scheme-theoretic-dominance APIs
in `AlgebraicGeometry.Morphisms.Separated` and
`AlgebraicGeometry.Morphisms.SchemeTheoreticallyDominant`, and rational maps in
`AlgebraicGeometry.Birational.RationalMap`. For the noncommutative projective
category use `CategoryTheory.ObjectProperty.SerreClassLocalization.abelian`
after proving its torsion/localization hypotheses. The two-variable theta input
is `NumberTheory.ModularForms.JacobiTheta.TwoVariable`; multiplicative normalization,
normal convergence of its product, and the elliptic quotient comparison are 3.5.

### From Tau Ceti

Use `FiniteLocallyFreeSheaf`, its `FixedRank` subcategory, `LineBundleClass`,
`projectiveLine` and the native `Proj.twistingSheaf`. The fixed-rank and projective
objects in 1.4 are exactly the carriers used in Suggested.lean.

- `projectiveLine.finrank_cohomology_zero_twistingSheaf`, in
  `AlgebraicGeometry.Cohomology.ProjectiveSpace.TwistingSheaf`, supplies the
  dimension `max(n+1,0)`. The negative-twist first-cohomology theorem
  `projectiveLine.finrank_cohomology_one_twistingSheaf` and the projective-space
  higher-cohomology vanishing API supply the other cohomology inputs to 1.4.
- `TauCeti.ComoduleAlgebra.finiteType_coinvariants`, in
  `Algebra.Bialgebra.ComoduleAlgebra.LinearlyReductive`, supplies finite generation
  of invariants of finite-type comodule algebras under its linear-reductivity
  hypothesis. `TauCeti.GeneralLinear.linearlyReductiveCommHopfAlgProperty_coordinateHopfAlgebra`
  supplies this hypothesis for `GL_n` over a characteristic-zero field. Target
  4.1 owns projective GIT and its comparison with stability on the operator Quot
  spaces; it does not redevelop these invariant-theory inputs.
- Use the blowup universal property, strict transform and flat-base-change APIs
  in `TauCeti.AlgebraicGeometry.Blowup`. The geometric Picard and canonical-class
  comparisons are 2.1, rather than definitions on a private abstract lattice.
- Use `IntegralLattice` and `eichlerTransvection`, including its isometry,
  addition and isotropic-parameter laws. The geometric marking and realization
  of the corresponding transformations are 2.1 and 5.1–5.2.
- `TauCeti.ext_of_isSchemeTheoreticallyDominant`, in
  `AlgebraicGeometry.Morphisms.SchemeTheoreticallyDominant`, supplies equality
  of morphisms to a separated target after a schematically dominant pullback.
  Target 0.3 proves schematic density of the actual comparison charts and
  applies this theorem; the general equality principle is already native.

### From the other roadmaps

The following contracts are used at their stated hypotheses. The analytic lane
follows ComplexComparisonPartII, and the differential comparison follows
PainleveEquationsAndFunctions; their foundation targets precede the consumers
6.4 and 9.3–9.4 respectively. Neither supplier depends on this roadmap.

| Supplier | Imported contract | Work owned here |
|---|---|---|
| [AlgebraicVectorBundles](../AlgebraicVectorBundles/README.md), L0A–L0C, L1–L2 | Finite locally free sheaves, pullback, duals, tensors, determinants, and geometric bundle comparison | Bundle stacks, meromorphic difference maps, and Birkhoff–Grothendieck in 1.1–1.4 |
| [AlgebraicCurves](../AlgebraicCurves/README.md), Layers 3–5, 9, 12; [SchemeAndStackFoundations](../SchemeAndStackFoundations/README.md), 3.2–3.7 | Divisors, degrees, Riemann–Roch, genus-zero/genus-one geometry, and curve Picard theory | Relative positions, determinant balance, boundary period maps, and correspondence quotients |
| [SchemeAndStackFoundations](../SchemeAndStackFoundations/README.md), 1.17–1.23, 4.14 | Quotient predicates, stacks, 2-fiber products, inertia, projective Quot/Hilbert, Hom/Isom parameter spaces | Actual Bun/Hecke/connection stacks, bounded stability/GIT, and scalar rigidification; finite-inertia Keel–Mori is not directly applicable to a scalar gerbe |
| [SchemeAndStackFoundations](../SchemeAndStackFoundations/README.md), 2.2, 2.6, 2.18–2.20, 4.3–4.6 | Coherent cohomology, derived coherent categories/duality, and small-extension deformation theory | Difference and operator deformation complexes, relative Ext, obstruction calculations, and the moduli Poisson form |
| [StableReduction](../StableReduction/README.md), Layer 4; [SchemeAndStackFoundations](../SchemeAndStackFoundations/README.md), 4.11, 4.17, 5.9–5.10 | Blowups/strict transforms, flat base change, normal crossings, surface intersection, adjunction, and Riemann–Roch | Rational-surface Picard/canonical formulas, infinitely near configurations, generalized Halphen pairs, and Sakai classification |
| [JacobianChallenge](../JacobianChallenge/README.md), Layers C–D | Proper coherent cohomology and its stated base-change criteria; Picard/Jacobian representability in its stated scope | The boundary Picard functors and multidegree-zero restriction maps needed in 2.3, including singular boundary curves |
| [IntegralLattices](../IntegralLattices/README.md); [RepresentationTheory/RootSystems](../RepresentationTheory/RootSystems/README.md); [KacMoody](../KacMoody/README.md), Layer 2 | Integral/root lattices, root data, Weyl/Coxeter theory at their stated hypotheses | Effective root configurations, Picard markings, geometric realization, and parameter actions |
| [DGAInfinity](../DGAInfinity/README.md), Layers 5–6 | DG derived modules, derived tensor/Hom, pretriangulated and perfect envelopes, and the derived Morita bicategory | DG enhancements of the operator categories, semiorthogonal gluing and its relative t-structures in 3.2; no functorial cone is inferred from a bare triangulated category |
| [GrothendieckEulerForms](../GrothendieckEulerForms/README.md) | Exact/abelian/triangulated `K₀`, finite Ext-Euler forms, and numerical quotients | Operator-surface numerical classes, Serre duality, and their geometric identifications |
| [PadicMeasuresIwasawaAlgebras](../PadicMeasuresIwasawaAlgebras/README.md), 5.1; AlgebraicVectorBundles L0C | Determinants of finite projectives/perfect complexes, exact-sequence and base-change laws, and line-bundle gluing | Perfect relative pushforward and determinants of cohomology in 4.2; tau divisors and the reference-object comparison in 8.2–8.3 |
| [ComplexComparisonPartII][complex-comparison], C−1.1–C−1.2, C0.1–C0.5, C1.9, C2.2; [ComplexKahlerGeometry](../ComplexKahlerGeometry/README.md), K1, K3–K4 | Complex analytic spaces, analytification, coherent analytic sheaves and exact coherent analytification, holomorphic bundle comparison and algebraization on proper curves, holomorphic calculus | Analytic `q`-difference classification, Birkhoff connection matrices, and `qPVI` Riemann–Hilbert in 6.4 |
| [ComplexTori](../ComplexTori/README.md), Milestones 1–2; [ComplexManifolds](../ComplexManifolds/README.md), Milestone 7; Mathlib's Jacobi theta API | Complex-torus quotient/family carriers, holomorphic bundles, and the native two-variable Jacobi theta function and its proved laws | Multiplicative theta normalization and its quotient comparison in 3.5; section interpolation and addition identities in 7.1 |

Concrete existing entry points include
`TauCeti.AlgebraicGeometry.Blowup.UniversalProperty`,
`TauCeti.AlgebraicGeometry.Blowup.StrictTransform`,
`TauCeti.AlgebraicGeometry.IntersectionNumber.Basic`, and
`TauCeti.LinearAlgebra.IntegralLattice.Isometry.Transvection`.
The existing intersection number is degree of restriction to a curve; the full surface
pairing uses the supplier's surface targets. The existing
`SchPseudofunctor` carrier is not an algebraic-stack/moduli theorem.
The lattice file already provides `eichlerTransvection`, its addition
law, and descent in its translation parameter modulo the isotropic line.

For `QGr`, consume Mathlib's
`CategoryTheory.ObjectProperty.SerreClassLocalization.abelian` after
proving the required torsion and localization hypotheses. The roadmap named
[NoncommutativeGeometry](../NoncommutativeGeometry/README.md) concerns other
noncommutative topics; it does not supply noncommutative algebraic surfaces.
Those surfaces, their relative homological algebra, and their moduli construction
are explicit targets of Layers 3–4.

The [Mathlib Picard-group development](https://github.com/leanprover-community/mathlib4/pull/44200)
and the [Picard-group design discussion](https://leanprover-community.github.io/archive/stream/116395-maths/topic/Puzzles.20around.20Picard.20group.html)
guide compatibility with native invertible-object and skeleton constructions.
The [local-freeness](https://github.com/leanprover-community/mathlib4/pull/39553),
[quasicoherent pullback](https://github.com/leanprover-community/mathlib4/pull/39989),
and [affine bundle](https://github.com/leanprover-community/mathlib4/pull/40831)
developments likewise determine compatible interfaces. Consume landed APIs and build
missing results in Tau Ceti with compatible shapes; do not introduce a permanent
private Picard group, bundle category, or semilinear equivalence.

## How to read the build

Layers 0–1 construct transports and regular-lattice difference objects. Layer 2
constructs the marked surfaces independently. Layers 3–4 supply operator categories
and their stable moduli, and Layer 5 constructs the comparison maps. Layers 6–7
instantiate this common theory for Jimbo–Sakai and elliptic Painlevé. Layers 8–9
derive tau sections, Riccati reductions and degeneration from those comparisons.
Each target names its prerequisites; an application cited to explain a construction
is a consumer, not a prerequisite of that construction.

| Layer | Development | Targets |
|---:|---|---|
| [0](#layer-0-relative-discrete-dynamics) | Relative discrete dynamics, domains, and solutions | 0.1–0.3 |
| [1](#layer-1-difference-connections-and-modifications) | Difference connections, local lattices, and modifications | 1.1–1.4 |
| [2](#layer-2-rational-anticanonical-surfaces) | Rational anticanonical surfaces and Sakai's classification | 2.1–2.4 |
| [3](#layer-3-operator-surfaces-and-equation-presentations) | Sheaf bimodules, operator surfaces, and equation presentations | 3.1–3.5 |
| [4](#layer-4-moduli-and-poisson-geometry) | Stable moduli, scalar descent, and Poisson geometry | 4.1–4.4 |
| [5](#layer-5-transformations-and-comparison-theorems) | Cremona actions and comparison with modifications | 5.1–5.4 |
| [6](#layer-6-jimbosakai-qpvi) | Jimbo–Sakai `qPVI` | 6.1–6.4 |
| [7](#layer-7-elliptic-painlevé) | Elliptic Painlevé | 7.1–7.4 |
| [8](#layer-8-dynamical-and-tau-consequences) | Degree growth, tau sections, and Riccati reductions | 8.1–8.4 |
| [9](#layer-9-degeneration-and-differential-comparison) | Algebraic degenerations and the differential limit | 9.1–9.4 |

## Layer 0: Relative discrete dynamics

### 0.1 Transport with explicit domains

For a family `p:M→B`, define the groupoid whose objects are open subfamilies
`U⊂M|B₀`, for open `B₀⊂B`, and whose arrows are pairs consisting of a base
isomorphism `t:B₀→B₁` and an isomorphism `φ:U→V` over `t`. A discrete transport
is such an arrow together with its specified domain. In the stack version retain
natural isomorphisms as 2-morphisms. A modification with several possible targets
is a correspondence until its projections are proved to give a transport.

- Construct identities, inverses and composition when the middle open subfamilies
  agree. Prove the groupoid laws with their base maps.
- For arbitrary composable partial presentations, first restrict to
  `U ∩ φ⁻¹(U′)`, where `U′` is the next source. Construct restriction and base
  change, and prove their compatibility with the groupoid operations.
- Define the domain of each finite word recursively by these inverse images.
  Prove that inverse words give inverse transports on their actual domains.

**Checks.**

- For `φ(z)=z+1` with domain `ℂ∖{0}`, followed by `ψ(z)=1/z`, the composite
  has domain `ℂ∖{0,−1}`. Intersecting the two original domains without pulling
  the second one back incorrectly retains `−1`.
- Inversion on `𝔾_m⊂𝔸¹` squares to the identity of `𝔾_m`, not the identity
  of `𝔸¹`. This distinguishes the stated groupoid from partial maps with one
  fixed object, which form an inverse semigroup.
- The subset `ℂ×∖{2ⁿ:n∈ℤ}` is not Zariski open: its complement is infinite
  and proper in an irreducible curve. All-iterate exclusions therefore remain
  orbitwise conditions, rather than being declared finite-type open bases.

*Needs:* Mathlib's categories, scheme open immersions and pullbacks;
SchemeAndStackFoundations 1.17–1.23 for the stack version. The laws follow from
the pullback universal property and ordinary groupoid composition.

### 0.2 Solutions and observation functions

For an admitted parameter orbit `λ_n`, define a solution on an integer interval
`I` to be points `x_n∈M_(λ_n)` such that, whenever `n,n+1∈I`, the point
`x_n` belongs to the source domain of `T_n` and `x_(n+1)=T_n(x_n)`.
A one-point interval imposes no unused next-arrow condition. A two-sided solution
retains this condition at every index, including the inverse-arrow domains.
An observation is a rational map from the phase family to `ℙ¹`, with its domain.

- Construct restriction, translation of the index interval and reversal using
  inverse arrows. Prove that evaluation at an initial index is a bijection onto
  the points for which all arrows of that finite interval are defined.
- For whole-fiber isomorphisms along a two-sided parameter orbit, prove existence
  and uniqueness on all of `ℤ`. For partial arrows retain the admissibility
  condition; do not infer infinite existence from finite existence separately.
- Construct the observed recurrences in any chosen phase/target charts and prove
  their compatibility with changes of charts. A rational observation has no
  assigned value at its unresolved base locus.

**Checks.**

- The transport `(x,t)↦(x+1,qt)` gives `(x_n,t_n)=(x₀+n,qⁿt₀)` for every
  integer `n`. Changing the spectral map alone leaves the time orbit unspecified.
- Inversion on `ℙ¹` gives the orbit `0,∞,0,∞,…`. The phase solution is regular
  even though its affine observation has a pole at every odd step.
- With identity transport on `𝔸²`, the constant phase point `(0,0)` exists at
  every step, but the rational observation `[x:y]` has no value there. Assigning
  `0/0=0` gives a different object.

*Needs:* 0.1; Mathlib's integer recursion and rational-map carriers;
Tau Ceti's `projectiveLine` and its two polynomial charts. These are consequences
of the solution definition and the scheme gluing laws.

### 0.3 Comparison and descent of dynamics

Define an equivariant comparison by a base map and maps of the corresponding
phase families commuting with each admitted transport. For equivalences require
inverse maps and retain markings and stabilizers. Construct their composition,
restriction and base change, and prove transport of solutions and observations.

- For an open atlas with transition isomorphisms satisfying the cocycle law,
  descend compatible transports and comparisons; prove independence under
  refinement. Apply stack descent to the object functors before scalar descent.
- If `j:U→X` is schematically dense, meaning `𝒪_X→j_*𝒪_U` is injective, and
  `Y→S` is separated, apply the native
  `TauCeti.ext_of_isSchemeTheoreticallyDominant` to two `S`-morphisms `X→Y`
  agreeing on `U`. For the reduced integral case use Mathlib's
  `AlgebraicGeometry.ext_of_isDominant_of_isSeparated`. The underlying
  closed-equalizer argument is [Stacks, Tag 01KM].
- In a flat family, prove schematic density of the specific comparison chart
  from the stated relative hypotheses before applying this principle. Equality
  on geometric fibers alone does not prove equality over a nonreduced base.

**Checks.**

- For `A=k[ε]/(ε²)`, the maps `x↦x` and `x↦x+ε` on `𝔸¹_A` agree on its
  only geometric fiber but differ as `A`-morphisms by the nonzero element `ε`.
- For `R=k[x,ε]/(ε²,xε)`, the open `D(x)` is topologically dense, and the
  functions `0` and `ε` agree there. They differ on `Spec R`; the restriction
  map has kernel `(ε)`, so the open is not schematically dense.
- The two inclusions of `𝔸¹` into the affine line with doubled origin agree
  on `𝔾_m` and have distinct values at `0`. Thus separatedness of the target
  cannot be omitted from the equality theorem.

*Needs:* 0.1–0.2; SchemeAndStackFoundations 1.17–1.23 for descent;
native scheme-theoretic dominance and equality extension; Mathlib's separated
morphisms and gluing.

### Examples

The two-step map in 0.1 has domain `𝔸¹∖{0,−1}`. Its solution functor and
observation functions restrict to exactly that domain; a generic rational
identity does not restore either deleted initial value. The nilpotent examples
in 0.3 test the relative comparison used throughout Layers 5–9.

### Dependencies

This layer uses native categories, schemes, integer recursion, and the stated
stack-descent supplier. Targets 0.2 and 0.3 follow 0.1. It supplies actual
transport domains and comparison descent to Layers 1 and 5–9.

## Layer 1: Difference connections and modifications

### 1.1 Bundles with a meromorphic difference map

For a smooth projective relative curve `C→B` with geometrically connected
fibers, a `B`-automorphism `σ`, positive rank `r`, degree `d` and a relative
effective Cartier divisor `P` finite over `B`, define a difference connection
to be a vector bundle `V` of rank `r` and degree `d` on every geometric fiber,
with an isomorphism `Φ:V(*P)→(σ*V)(*P)`.
Here `V(*P)=colim_n V(nP)` is Cartier localization;
the map and its inverse are represented locally on `B` with finite pole bounds.
Both sides are localized at `P`; this notation does not apply `σ*` to `V(*P)`
when `P` is not `σ`-invariant.
An arrow is a regular bundle isomorphism `g` with `Φ′g=(σ*g)Φ` in this localization.
Allow enlargement of `P` by retaining the original regularity conditions.

- Prove independence of the finite bounds and fpqc descent of objects and arrows.
  Construct pullback with the pulled-back divisor and spectral automorphism.
- Construct tensor products, duals and determinants, using the union of polar
  supports. Prove their functorial laws and determinant-line identifications.
- Over a field construct the generic semilinear module and completed local
  lattices. Prove that the generic functor is faithful and identifies regular
  arrows with generic arrows preserving the lattices at every closed point.
  In a frame its operator is `F_A=A⁻¹σ`; a change `Y′=gY` gives `A′=σ(g)Ag⁻¹`.
  In families retain Cartier localization rather than only geometric fibers.

**Checks.**

- On `ℙ¹` with `σ(z)=qz`, the rank-one rational gauge `g=z` changes `A=a`
  to `A′=qa`. Its divisor is `[0]−[∞]`, so it is not a regular automorphism
  of `𝒪`; quotienting by all rational gauges loses lattice data.
- For `σ=id` and constant `A=2`, the operator on sections is multiplication
  by `1/2`, whereas the equation is `Y=2Y`. This fixes the inverse convention
  in `F_A`, including for noncommuting higher-rank gauge changes.
- Over `k[ε]/(ε²)`, multiplication by `1+ε` and by `1` on the trivial
  bundle have identical geometric-fiber maps and distinct relative maps.
  The relative object therefore cannot be defined by its fiberwise generic data.

*Needs:* AlgebraicVectorBundles L0A–L0C and L1–L2; AlgebraicCurves Layers 3–5
for divisors and function fields; SchemeAndStackFoundations 1.17–1.23 for descent.
For the generic-arrow criterion, use that the regular local rings at closed
points of a smooth curve are DVRs and recover a bundle from the intersection
of its local lattices in its generic fiber. The symmetric factorization theorem
[R13, Proposition 2.2] is used separately in 3.3.

### 1.2 Local type and determinant balance

Over a discrete valuation ring with uniformizer `u`, define the relative position
of two lattices by the unique weakly decreasing integers `(m₁,…,m_r)` in a
Smith form `diag(u^m₁,…,u^m_r)`. Positive entries denote zeros. In families use
the fpqc orbit of this diagonal matrix under regular changes of the two formal
frames, after a local parameter at the marked section is chosen. Construct these
bounded Hecke strata, their independence of parameter, and their locally closed
scheme structures in the framed lattice/relative Quot presentations. Their
unframed quotients are Hecke stacks. A family belongs by scheme-theoretic
factorization through the stratum, not merely by having that position on
geometric fibers.

- Construct dual and inverse positions, convolution strata for composition,
  and the length formulas for positive and negative elementary divisors.
  Prove additivity of determinant valuations, without coordinatewise additivity
  of sorted positions.
- For bounded modifications require the finite-support quotients to be flat
  over `B`, equivalently their finite pushforwards to be locally free. Prove
  base change for the specified strata and lattice filtrations. Flatness of the
  total quotient alone is weaker than belonging to a relative-position stratum.
- Record source/target identification along a `σ`-orbit. At a fixed point,
  construct formal regular-singular types and ordered exponent/eigenline data.
  For `Φ:V⇢σ*V⊗L`, prove

      deg div(det Φ) = deg(σ*V) − deg V + r deg L = r deg L.

  Retain the determinant isomorphism and its normalization when relating this
  twist convention to the signed positions of the original map.

**Checks.**

- The matrices `diag(u,1)` and `diag(1,u)` both have sorted position `(1,0)`;
  their product has `(1,1)`, not `(2,0)`. Their determinant valuations are
  `1,1,2`, as required by determinant additivity.
- For `A=k[ε]/(ε²)`, the matrix `[[u,ε],[0,u]]` over `A[[u]]` has cokernel
  free of rank two over `A` and geometric position `(1,1)`. Its ideal of entries
  is `(u,ε)`, whereas that of `diag(u,u)` is `(u)`. It is not in that relative
  diagonal orbit, despite flat quotient and constant geometric position.
- For rank two and `L=𝒪(2∞)`, the determinant degree is `4`. A simple zero
  has position `(1,0)` and determinant order `1`; a scalar zero `uI` has
  position `(1,1)` and determinant order `2`.

*Needs:* 1.1; elementary-divisor theory over a DVR; AlgebraicCurves Layers 3–5
and 9 for divisors, degree and local geometry; AlgebraicVectorBundles L0C;
SchemeAndStackFoundations 4.14 for the finite presentation spaces. The bounded
orbit/stratification and fixed-point difference conditions are owned here.

### 1.3 Hecke stacks and the modification law

Construct `Bun_r(C)` and `Hecke_S(C)` as fppf stacks over `B`; the latter
classifies triples `(V,W,R)` with `R` an isomorphism off the relative divisor
`S` and the scheme-theoretic positions of 1.2. Their arrows are pairs of
regular bundle isomorphisms intertwining `R`. Define the difference-object
stack by the 2-fiber product

    𝔠_(σ,S)(C) = Bun_r(C) ×_(Bun_r(C) × Bun_r(C)) Hecke_S(C),
    where V ↦ (V,σ*V) and (V,W,R) ↦ (V,W).

- Prove descent, construct the two forgetful maps, and identify the fiber
  product with 1.1's objects and arrows. Impose local and determinant types
  as the corresponding substacks.
- Construct elementary modifications from line subbundles or locally free
  quotients at the marked sections. Prove their inverse and composition laws,
  the degree/position changes and compatibility with arbitrary base change
  for the flat quotients in 1.2.
- Define a connection modification by `Φ′R=(σ*R)Φ`. Prove, in a common frame,
  `det A′=[σ(det R)/det R]det A`. A single-valued time map is a theorem on
  a domain where the source projection is an isomorphism; retain the original
  correspondence on the complement.

**Checks.**

- For a line bundle and a point `p`, the elementary kernel of `V→V|p` is
  `V(−p)`, with degree `deg V−1`. The inverse modification has degree change
  `+1`, fixing the direction of the two Hecke projections.
- For `σ(z)=qz` and `R=z` in rank one, the determinant law gives `A′=qA`.
  Omitting the spectral pullback would incorrectly give `A′=A`.
- A rank-one difference object has regular scalar automorphism group `𝔾_m`.
  The fiber product therefore retains this stabilizer, whereas a set-theoretic
  fiber product of isomorphism classes loses it.

*Needs:* 0.1, 1.1–1.2; SchemeAndStackFoundations 1.17–1.23 and 4.14;
AlgebraicVectorBundles L1–L2 for bundle descent. The modification formula
specializes [JS, §3] and [OR, §4].

### 1.4 Bundle strata and complete presentation domains

For every field `k` and every rank-`r` vector bundle `V` on the split projective
line `ℙ¹_k`, prove that `V≅⊕_(i=1,…,r)𝒪(d_i)` for integers `d_i`, and that the
multiset of these integers is unique. The rank-zero case is the empty direct
sum. This Birkhoff–Grothendieck theorem uses native finite locally free sheaves,
the native projective line and its twisting sheaves. It is stated as
`existsUnique_splitting_projectiveLine` in Suggested.lean.

- Use the supplied twisting-sheaf cohomology formulas
  `h⁰(𝒪(d))=max(d+1,0)` and `h¹(𝒪(d))=max(−d−1,0)` to prove the cohomology
  and Hom formulas for split sums and construct their automorphism groups.
- Construct the relative semicontinuity and bounded splitting-type strata.
  Construct the framed spaces of maps with a fixed pole bound, their regular
  change-of-frame groups and their overlap with the elementary Hecke charts.
- For an irreducible degree-zero rank-two connection
  `V→σ*V(2∞)`, prove `V≅𝒪(k)⊕𝒪(−k)` with `0≤k≤1`. If `k>1`, the
  component `𝒪(k)→𝒪(2−k)` is zero, giving an invariant subbundle. Construct
  both permitted strata and their maps to the connection stack.

**Checks.**

- Both `𝒪²` and `𝒪(1)⊕𝒪(−1)` have degree zero and `h⁰=2`, but after
  tensoring by `𝒪(−1)` their `h⁰` values are `0` and `1`. Thus degree and
  one cohomology dimension do not determine a splitting type.
- Their endomorphism spaces have dimensions `4` and `5`, since
  `h⁰(𝒪(2))=3` and `h⁰(𝒪(−2))=0`. A uniform `GL₂` frame quotient therefore
  cannot represent both bundle strata.
- For `𝒪(2)⊕𝒪(−2)` with pole bound `2∞`, the component from `𝒪(2)` to
  `𝒪(0)` has dimension `h⁰(𝒪(−2))=0`; the connection is reducible. For
  `k=1`, the same component has dimension `h⁰(𝒪)=1`, so the degree bound
  permits that splitting stratum.

*Needs:* For splitting and uniqueness, native projective-line, twisting-sheaf
and cohomology APIs, and AlgebraicCurves Layers 3–5 for divisor theory; a proof
uses a maximal-degree line subbundle or [HM, Proposition 3.1 and Theorem 4.1,
pp. 209–211]. For relative strata, SchemeAndStackFoundations 2.2, 2.6 and 4.14.
The irreducible rank-two bound additionally uses 1.1–1.2; the Hecke overlap uses
1.3. The splitting theorem itself does not depend on difference connections.

### Examples

The polynomial `qPVI` chart later uses `𝒪²`, but the pole bound also permits
`𝒪(1)⊕𝒪(−1)`. The cohomology calculation in 1.4 separates these strata.
The nilpotent matrix in 1.2 gives a flat family that fails the prescribed
relative-position condition despite satisfying it on its only geometric fiber.

### Dependencies

Targets 1.1–1.3 use the native bundle and divisor carriers and the stated
stack/Quot suppliers. The splitting theorem consumes the native projective-line
cohomology directly; its application to connections uses 1.1–1.3. These APIs
provide the regular lattices and presentation domains used in Layers 3 and 6–7.

## Layer 2: Rational anticanonical surfaces

### 2.1 Point blowups and the geometric Picard lattice

Starting from the supplied blowup and intersection theories, prove the Picard
decomposition, intersection formulas, and
`K_(X̃)=π*K_X+E` for a smooth point blowup. Construct ordered
blowup families, including infinitely near sections, and prove the formulas after
the permitted base changes. Treat `ℙ²`, `ℙ¹×ℙ¹`,
and the Hirzebruch surfaces needed for their elementary transformations.

For eight blowups of `ℙ¹×ℙ¹`, construct the marking

    L = ℤH_f ⊕ ℤH_g ⊕ (⊕_(i=1,…,8) ℤE_i),
    H_f² = H_g² = 0,   H_f·H_g = 1,   E_i·E_j = −δ_ij,
    δ = 2H_f + 2H_g − Σ_(i=1,…,8) E_i.

Prove its isometry with the nine-point plane model, compatibility with strict
transforms, and the distinction between an exceptional *class* and an effective
irreducible exceptional curve.

**Checks.**

- Eight point blowups of `ℙ¹×ℙ¹` give `δ²=8−8=0` and Picard rank `10`; nine point blowups of `ℙ²` give `δ²=9−9=0` and the same rank.

- The strict transform of a ruling fiber through exactly two marked centers
  has class `H_f−E₁−E₂`, square `−2` and anticanonical intersection
  `2−1−1=0`.

- At the second blowup, if its center lies on the first exceptional divisor,
  the latter's strict transform has class `E₁−E₂` and square `−2`; the
  total-transform class `E₁` still has square `−1`. The same strict-transform
  formula persists after further blowups whose centers avoid that curve.

*Needs:* The blowup, surface-intersection, and lattice suppliers.

### 2.2 Marked generalized Halphen pairs

Define the geometric class before its classification: a smooth projective rational
surface `X`, `K_X²=0`, and an effective anticanonical divisor
`D=Σ m_iD_i` of canonical type, meaning `D·D_i=0` for every
irreducible component, together with a Picard marking and a chosen chamber.
Use Sakai's unique-anticanonical-divisor hypothesis for the classified
nonautonomous families; distinguish it from the stronger condition
`h⁰(X,nD)=1` for every `n>0`.

- Construct the rational two-form with divisor `−D`, its one-dimensional
  normalization space, and the induced symplectic form on `U=X∖D`.
- Include nonreduced canonical-type boundaries, using their multiplicities
  in adjunction and in the polar divisor. Construct families and their
  isomorphisms with marking, boundary and two-form normalization retained.

**Checks.**

- On a smooth elliptic boundary with normal bundle of exact order two, the restriction sequences give `h⁰(D)=1` and `h⁰(2D)=2`. Uniqueness of the anticanonical divisor does not imply uniqueness of every multiple.

- For an `I₂` boundary, the two components have squares `−2` and mutual intersection `2`; `D=C₁+C₂` satisfies `D·C₁=D·C₂=0` and `D²=0`.

- For the additive `D₄^(1)` boundary with central multiplicity `2` and four outer multiplicities `1`, the central intersection is `2(−2)+4=0` and each outer intersection is `2−2=0`. Replacing the divisor by its reduced support destroys these equalities.

*Needs:* 2.1, adjunction/duality, and curve Picard theory.

### 2.3 Period maps and parameters

Let `R_D⊂L` be generated by the marked boundary components. Construct
restriction of line bundles and the period homomorphism

    per: R_D⊥ → Pic⁰(D),     α ↦ 𝒪_X(μ(α)) restricted to D.

- Prove that this lands in the indicated identity component in the classified
  families. On a reducible boundary, use degree zero on every component.
  Construct the relative version, the smooth/nodal/cuspidal coordinate
  comparisons, and compatibility with markings and change of normalization.

- For a smooth irreducible boundary, identify `R_D⊥=δ⊥` and
  `δ⊥/ℤδ` with the negative `E₈` lattice. Prove
  `per(δ)=𝒪_D(D)`. Descending the period map through `ℤδ` requires
  this line bundle to be trivial. Construct root-parameter charts and the
  equations for the effective-root walls used in Layers 6–8.

- For smooth `D` with nontorsion normal bundle `𝒪_D(D)`, prove from the
  restriction exact sequences that `h⁰(X,nD)=1` for every `n≥0`, hence
  `Γ(X∖D,𝒪)=k`. This is the algebraic obstruction used in the comparison
  with an affine connection-data surface.

**Checks.**

- On a two-component cycle, multidegree `(1,−1)` has total degree zero but does not lie in `Pic⁰(D)`; componentwise orthogonality is necessary.

- For a smooth boundary with nontorsion normal bundle `N`, `per(δ)=N≠𝒪_D` while the class of `δ` in `δ⊥/ℤδ` is zero. Thus the period map cannot factor through that quotient.

- The nodal and cuspidal irreducible rational cubics have `Pic⁰=𝔾_m` and `Pic⁰=𝔾_a`, respectively. Their step laws are multiplication and addition; the smooth genus-one case has neither of these affine groups.

*Needs:* 2.1–2.2, Picard functors, exact sequences, and curve cohomology.

### 2.4 Sakai classification and its scope

Prove the finite classification of the pairs in 2.2 under Sakai's hypotheses.
Construct the boundary configurations, multiplicities, orthogonal symmetry root
data, and marked blowup models. Distinguish the two embeddings conventionally
denoted by the `A₇^(1)` surface labels, rather than identifying them from
their abstract dual graph.

The classification includes the smooth elliptic `A₀^(1)`, the multiplicative
`A₀^(1)*,A₁^(1),…,A₈^(1)` cases with the two `A₇^(1)`
embeddings, and the additive
`A₀^(1)**,A₁^(1)*,A₂^(1)*,D₄^(1),…,D₈^(1), E₆^(1),E₇^(1),E₈^(1)` cases.
This is the 22-type geometric classification, with the embeddings and degenerate
root data retained.

For each type provide the actual lattice embedding, its orthogonal complement,
the effective-chamber conditions, and the family of surfaces realizing it.
Prove exhaustiveness within the stated class. State explicitly which symmetry
data have nonzero translations; an `A₀^(1)` symmetry label does not manufacture
one. Degeneration arrows are constructed families, not conclusions from an
inclusion of Dynkin diagrams. The particular degenerations required here are in
Layer 9.

**Checks.**

- The listed families comprise `1` smooth elliptic, `10` multiplicative and `11` additive types, giving `22`; merging the two `A₇^(1)` embeddings loses one type.

- For a smooth boundary, `rank(δ⊥)=9` and `rank(δ⊥/ℤδ)=8`, with the negative `E₈` intersection form. The boundary graph alone has one vertex and does not encode that symmetry lattice.

- For the `A₈^(1)` boundary, its nine independent marked component classes have orthogonal complement of rank one generated by `δ`; after dividing by `ℤδ` the translation lattice has rank zero. No nonzero time translation is produced by this case.

*Needs:* 2.1–2.3 and root-system theory. *Sources:* [Sakai], [KNY, §§3, 8.2],
[DT, Introduction and Remark 1.1].

### Examples

The order-two Halphen example in 2.2 distinguishes a unique anticanonical
member from a unique member of every multiple. The `A₈^(1)` example in
2.4 shows that a classified surface need not supply a nonzero translation.
The marked `A₃^(1)` and smooth `A₀^(1)` families are instantiated in
Layers 6 and 7 with independently constructed linear moduli.

### Dependencies

The geometric Picard calculation uses native blowups and the named surface
intersection/adjunction supplier. Targets 2.2–2.4 then use boundary Picard
functors and native root lattices. This construction is independent of the
operator category; Layers 5–7 prove comparisons with it.

## Layer 3: Operator surfaces and equation presentations

### 3.1 Sheaf bimodules and the noncommutative projective line

For smooth projective relative curves `C₀,C₁` over a locally Noetherian base `B`,
with geometrically integral fibers, define a sheaf bimodule to be a coherent
sheaf `ℰ` on `C₀×_B C₁` whose support is finite over both factors. Its birank is
`(2,2)` when both projection pushforwards are locally free of rank two. Fix the
tensor-functor convention

    F_ℰ(V) = p₂*(p₁*V ⊗ ℰ).

Thus the graph kernel for an automorphism `σ:C→C` uses
`Γ_σ = {(σ(x),x)}` and has tensor functor `σ*`. Construct convolution, its
associativity, and the left and right adjoint bimodules with their units and
counits. Construct Van den Bergh's symmetric `ℤ`-algebra: the degree-`(i,i+1)`
term is the iterated adjoint bimodule `ℰ^(*i)`, and its quadratic relations are
the images of the adjunction units

    𝒪_(C_i) → ℰ^(*i) ⊗ ℰ^(*(i+1)).

Use right graded modules. A torsion module is a filtered union of modules whose
sufficiently high graded pieces vanish. Define `QGr S(ℰ)` by this localizing
subcategory, and define the coherent operator category by its Noetherian objects.
Establish the following API.

- Prove the quotient universal property and the Serre/localization hypotheses
  needed by `CategoryTheory.ObjectProperty.SerreClassLocalization.abelian`.
  Prove local Noetherianity for the specified relative bimodules, and construct
  their pullback and coherent quotient under base change. A fiberwise quotient
  category alone does not define this relative object.
- Construct the derived projection adjunctions `Lρ_i*` and `Rρ_i*`, their
  two-component semiorthogonal decomposition, and its enhanced gluing model.
  Prove the flatness and finite-Tor-amplitude hypotheses in each asserted
  base-change statement.
- For `ℰ=Δ_*F`, with `F` a rank-two bundle on `C`, identify the coherent
  category with that of `Proj_C Sym F`, using the universal line-quotient
  convention. Prove invariance under isomorphism of bimodules and the specified
  line-bundle changes of presentation. Scheme-theoretic support on the reduced
  diagonal is part of this specialization.

These constructions use the adjunction relations, rather than a separately
chosen quadratic algebra ([VdB]; [R25, Theorem 9.13, Theorem 11.5,
Lemma 11.7, and §13.1]).

**Checks.**

- For `ℰ=Δ_*(𝒪²)`, the quadratic unit has one-dimensional image in a
  four-dimensional tensor product. The degree-two quotient has dimension `3`,
  and the degree-`n` commutative fiber has dimension `n+1`; a free tensor
  algebra would give degree-two dimension `4`.
- The same bimodule gives `coh(ℙ¹×C)`. A graded module concentrated in one
  degree maps to zero in `QGr`, even when that graded piece is nonzero.
- Convolution of the graph kernels for `σ` and `σ⁻¹` gives the diagonal
  kernel, with tensor functor `Id`. The graph `x↦(σ(x),x)` itself gives
  `σ*`, fixing the orientation used in 3.4.

*Needs:* AlgebraicVectorBundles L0A–L0C and L1–L2; SchemeAndStackFoundations
2.2, 2.6, and 2.18–2.20; DGAInfinity Layers 5–6; native adjunctions, graded
module categories, and `CategoryTheory.ObjectProperty.SerreClassLocalization.abelian`.

### 3.2 Rational operator surfaces and their anticanonical curve

A split anticanonical blowup datum over `B` consists of a smooth projective
rational surface `Z₀/B` presented as `ℙ²_B` or a Hirzebruch surface, a relative
effective Cartier anticanonical divisor `Q₀`, and an ordered sequence of sections
`p_i` of the successively transformed divisors. Define

    Z_(i+1) = Bl_(p_i) Z_i,     Q_(i+1) = π_i*Q_i − E_i.

Retain this commutative blowdown structure, the marking, and an invertible sheaf `η` on
`Q_m` whose geometric fibers lie in `Pic⁰(Q_m)`. Use actual invertible sheaves
and their transition isomorphisms in families; rigidify along a section when
one is supplied. A center on the singular locus of `Q_i` is permitted. A
center outside `Q_i` is not an anticanonical blowup datum.

Construct the associated rational operator surface and the following mutually
compatible descriptions ([R25, §§11.1–11.4 and §§13.1–13.2]).

- Construct the ruled models from 3.1, the plane models, and their categorical
  point blowups. For the plane model construct the three-object exceptional
  collection whose adjacent Hom spaces have dimension three and whose
  composition has three-dimensional kernel, using multiplication of sections
  on its anticanonical cubic as in [R25, Proposition 11.11]. At each point
  blowup use the point object on the commutative Cartier boundary. Prove that
  the preceding category is generated by weak line bundles along that
  boundary: these are sheaves with invertible restriction, and every
  quasicoherent sheaf is a quotient of a direct sum of them. Establish this
  property for the initial models and its preservation under blowup; then
  construct the blowup adjunctions and exceptional component of
  [R25, Theorem 11.12].
- In the enhanced description put `𝒜=𝒪_(Z_m)^⊥` and glue `𝒜` to the
  exceptional object corresponding to `𝒪_(Z_m)`, with the cross Hom complex
  from `M∈𝒜` to that object equal to `RHom_(Q_m)(Li*M,η)`. Construct the
  geometric t-structure recursively from the retained blowdown structure,
  and prove that its heart is the actual graded-quotient/blowup category.
  For the projection or blowdown functor `Rf*`, prove that its nonnegative
  part consists of the objects `M` for which `Rf*(θⁿM)` is nonnegative for
  every integer `n`, where the surface Serre functor is `θ[2]`. For the plane
  model use `RHom(𝒪,−)` in this characterization. Prove the existence of the
  t-structure and the comparison of hearts; the enhanced gluing category by
  itself does not supply them ([R25, Lemma 11.10, Proposition 11.11,
  Proposition 11.19, and Theorem 11.31]).
- Fix the point labels in the categorical blowup. Write the positive normal
  bimodule functor on the boundary as `ν_*(−⊗𝒩)`, with `ν` an
  automorphism and `𝒩` an invertible sheaf. Thus the positive normal twist
  sends a point at `p` to a point at `ν(p)`, with its line fiber retained.
  Compute this functor from the boundary bimodule. For operator center `p`,
  the exceptional gluing complex uses `𝒪_(ν(p))[−1]`
  ([R25, Proposition 11.15]). In the auxiliary commutative embedding used
  to describe the new boundary in [R25, Proposition 11.20, Remark 1], the
  blowup center is `ν(p)`. Construct the comparison of that boundary
  identification with the one in the enhanced gluing description. Determine
  each center in the commutative core of Theorem 11.31 from the actual
  exceptional derived restriction after this comparison: in the smooth case
  prove it is a perfect length-one sheaf and take its zeroth Fitting support;
  in the singular case use the exceptional two-term complex below. Retain
  its line factor and all transition isomorphisms. This recursively constructs
  the ordered commutative centers; it does not identify them with the raw
  operator centers or the auxiliary centers without the boundary comparison.
- Construct the reverse normal form from an operator ruled or plane model
  with its ordered boundary centers. In the ruled case write the restrictions
  of the retained exceptional collection as
  `(L′₋₂,L′,L₋₂,𝒪_Q)`. Compute
  `η=(L′)⁻¹⊗(L₋₂)⁻¹⊗L′₋₂`; the line bundle
  `(L₋₂)⁻¹⊗η⁻¹` gives the degree-two morphism `π:Q→ℙ¹`, and the
  commutative ruled surface is
  `ℙ(π_*((L′)⁻¹⊗η⁻¹))`. In the plane case the restrictions
  `(L₋₆,L₋₃,𝒪_Q)` give `η=L₋₆⊗L₋₃⁻²`, with the commutative plane
  embedding defined by `η⁻¹⊗L₋₃⁻¹`. Prove the required degree,
  generation, and embedding statements, and construct the ordered centers
  from the exceptional restrictions by the preceding Fitting-support and
  boundary-comparison construction.
  Construct the resulting enhanced equivalence and
  heart comparison. These formulas are the construction in the proof of
  [R25, Theorem 11.31], not a choice of a surface with the desired moduli.
  Prove their relative version on the actual split-data charts, including
  cohomology base change for the displayed bundles, and effective descent
  for their transition isomorphisms.
- For a center of boundary multiplicity `μ`, retain
  `Q_(i+1)=Q_i^strict+(μ−1)E_i`. Construct the exceptional object's derived
  restriction as the perfect complex
  `𝒪_(Q_(i+1))→𝒪_(Q_(i+1))(E_i)`. This construction also covers singular
  and nonreduced boundary curves ([R25, proof of Theorem 11.31]).

Prove the relative Noetherian theory, proper coherent pushforward, relative
Ext, the projection and blowdown adjunctions, and the Serre and anticanonical
structures `θ[2]` and `θ→Id`. Construct the relative perfect subcategory and
the finite relative resolutions needed for flat coherent families. State and
prove the finite-Tor-amplitude conditions under which relative Hom and proper
pushforward are perfect and commute with base change. Over a field identify
the bounded coherent and perfect categories; over a singular base do not
replace relative perfectness by absolute perfectness of every coherent object.
Families consist of these graded and enhanced relative constructions, rather
than merely a family of abstract triangulated categories.

Construct derived restriction to the commutative boundary, numerical classes
`(rank,c₁,χ)`, and their comparison with the Picard marking of 2.1. Prove

    χ(M,N) = −rank(M)rank(N)χ(𝒪)
             + rank(M)χ(N) + rank(N)χ(M)
             − c₁(M)·(c₁(N) − rank(N)K).

Each point blowup adds one exceptional `K₀` summand and one Picard summand.
For a rational surface prove `rank K₀=rank Pic+2`, and for rank-zero classes
prove `χ(M,M)=−c₁(M)²` ([R25, Corollaries 14.12–14.13]). Define disjointness
from `Q` by `Li_Q*M=0`.

Construct the minimal lift of a sheaf with no nonzero zero-dimensional
subobject as `π*!M=im(π*M→π!M)`, where `Lπ!` is right adjoint to
`Rπ*`. Prove pullback acyclicity, `Rπ*(π*!M)≅M`, compatibility with
composition, and the exceptional Hom-vanishing characterization. Construct
the flattening strata on which this image is a flat family and commutes with
base change. Prove preservation of `χ`, and compute the exceptional Chern
class contribution from the actual gluing maps and point labels rather than
from an unshifted center convention ([R25, Proposition 15.13 and §15.4]).
For a transverse sheaf prove the adjunction identity

    RHom_𝒮(𝒪_(ν(p))[−1],M) ≅ RHom_Q(𝒪_p,Li_Q*M⊗𝒩).

Derive the kernel and cokernel of `α*M→α!M` from this identity and the
exceptional semiorthogonal decomposition
([R25, Proposition 11.15 and Lemma 11.18]). In particular a simple
restriction point `u` is removed by the operator blowup at `p=u`; its
commutative-core center is computed by the boundary comparison above. The
factor `𝒩|_p` is a line and does not change the support test, but it is
retained in relative functorial isomorphisms. Prove the simple-point formula
`c₁(α*!M)=α*c₁(M)−E` and `χ(α*!M)=χ(M)` at the corresponding
transverse multiplicity-one locus. The point formula here is derived from
adjunction and the fixed positive-normal convention.
For the composite ruling `ρ:𝒮→C`, prove cohomological dimension at most
one, `ρ*𝒪_𝒮=𝒪_C`, and `R¹ρ*𝒪_𝒮=0`. Prove that the minimal lift is
a quotient of the ordinary pullback for such sheaves, and hence preserves
generation by a pulled-back generating family. Combine these facts with
relative Hom and base change to compute the ruling pushforwards used by
the stability arguments.

For the Painlevé family take a smooth projective rational weak del Pezzo surface
`Y` with `−K_Y` nef and big, `K_Y²=1`, a blowdown structure, an anticanonical
member `Q`, and the unique base point `p₀` of the anticanonical pencil, smooth
on `Q`. Identify the component of `Q_smooth` containing `p₀` with `Pic⁰(Q)`
by requiring

    𝒪_Q(p₀−p(z)) ≅ z,     X_(z,1) = Bl_(p(z)) Y.

Apply the preceding deformation with parameter `η` to obtain `𝒮_(z,η)`.
Prove `Q_(X_(z,1))²=0` and `C²≥−2` for every irreducible boundary component
`C`. For a model constructed from a smooth genus-one boundary on a ruled
surface and eight ordered boundary blowups, construct `Y` from the first
seven commutative blowups in the reverse normal form. Its irreducible
anticanonical curve has square one, so prove directly that `−K_Y` is nef and
big; the last blowup then supplies `z`. This gives the degree-one input from
the operator presentation without assuming a phase-space comparison.

Prove the commutative specialization `𝒮_(z,1)=X_(z,1)` and the parameter
identities

    det(Li_Q*[𝒪_Q]) = z,     det(Li_Q*[pt]) = η.

The first sign follows from `𝒪_Q(Q_Y)=𝒪_Q(p₀)`, which gives
`N_(Q/X_(z,1))=𝒪_Q(p₀−p(z))`. Construct the ambient mutation and blowdown
equivalences and the two `SL₂(ℤ)` generators, with their numerical and
boundary-restriction actions. Prove the natural isomorphisms needed by the
comparisons; a lattice action does not determine a coherent categorical action
([R25, Proposition 12.12, Theorem 12.13, and Corollary 12.14]).

**Checks.**

- Blowing up the node `xy=0` gives `π*Q=Q^strict+2E`, hence the new
  anticanonical divisor is `Q^strict+E`. Using only the strict transform
  loses the exceptional component and its class.
- At `η=1`, eight blowups of `ℙ¹×ℙ¹` give `K²=8−8=0`,
  `rank Pic=2+8=10`, and `rank K₀=4+8=12`. Picard rank and full
  Grothendieck-group rank are different invariants.
- If the positive normal automorphism is `ν=t_a`, the auxiliary embedding
  of Proposition 11.20 uses center `p+a`. A transverse restriction `𝒪_u`
  is detected by operator center `p=u`, since the right-hand Hom in the
  adjunction identity has degree-zero dimension `1` there and `0` at a
  distinct point. Its one-dimensional value is the retained normal line
  fiber. This does not identify the auxiliary boundary coordinates with
  those of the commutative core.
- For smooth `Q` and `z=1`, the last center is `p₀` and
  `h⁰(−K_(X_(1,1)))=2`. For nontorsion `z`, the restriction sequences
  have nontrivial degree-zero quotients `zⁿ`, so
  `h⁰(n(−K_(X_(z,1))))=1` for every positive `n`. These two commutative
  surfaces have the same value `η=1` but different pencil behavior.

*Needs:* 2.1–2.3 and 3.1; DGAInfinity Layers 5–6; SchemeAndStackFoundations
2.2, 2.6, 2.18–2.20, 4.11, and 4.17; StableReduction Layer 4;
GrothendieckEulerForms; the native blowup and strict-transform APIs specified
in the supplier contracts.

### 3.3 Relative equation–sheaf reconstruction

On a ruled operator model define the presentation domain of a flat family of
pure one-dimensional sheaves `M` by the following conditions: `M` is transverse
to the boundary, meaning `Tor₁(M,𝒪_Q)=0`, and `Rρ₋₁*M` and `Rρ₀*M` are
vector bundles concentrated in degree zero. Fix their ranks and degrees.
Put `W=ρ₋₁*M` and `V=ρ₀*M`. Construct the evaluation resolution

    0 → ρ₁*W → ρ₀*V → M → 0.

Conversely, take injective two-term bundle presentations with base-flat pure
cokernel satisfying the stated transversality conditions. Construct the
presentation and cokernel functors and their natural inverse isomorphisms.
Prove the numerical class formula from this resolution before any twist or
derived equivalence ([R25, §19.1, (19.1)–(19.2)]).

- Prove that concentration in degree zero and the fixed-rank bundle conditions
  give the asserted relative pushforward and base-change properties. Construct
  their open or flattening strata inside the bounded parameter spaces of 1.4
  and 3.2, using the actual relative complexes.
- For reconstruction as a connection retain both
  `Hom(𝒪_f(−1),M)=0` and `Hom(M,𝒪_f(−1))=0` for every ruling-fiber
  object. Prove that the first condition is maximality of the regular
  presentation lattice and implies torsion-freeness of `V,W`, while the
  second is the required `ρ₋₁*`-acyclicity. Construct the relative conditions
  by the Hom complexes and prove their bounded openness or flattening
  descriptions.
- Construct maximal lattices by principal parts. Inside a fixed ambient
  lattice, the one-branch map is
  `V→σ*V(D)/σ*V`; for a correspondence use the simultaneous branch maps.
  On each fixed-length stratum where the image and cokernel of this map are
  flat over the base, prove that its kernel is locally free and that kernel
  formation commutes with base change. When larger ambient lattices are
  required, first prove a common polar bound on the bounded presentation
  family and carry out this construction inside that bound. Keep the coherent
  sheaf and its limiting data outside these strata.
- Retain twisted connections for a general coefficient bimodule. To produce
  an untwisted equation, include a section object `Σ` with the same
  transversality and Hom-vanishing conditions and an identification
  `ρ₀*Σ≅𝒪_C`. Construct its meromorphic normalization of the coefficient
  bimodule. Prove that changing `Σ` tensors the equation by the inverse of
  the associated rank-one connection. Construct the covariant presentation
  and the contravariant solution functor `Hom(M,Mer)` separately, and compute
  the resulting dual or transpose in the coefficient map. Retain the chosen
  scalar normalization ([R25, §19.1, printed pp. 343–345]).

**Checks.**

- Over `R=k[t,u]_((t,u))`, the two-branch presentation `B=(u,u−t)` has
  maximal lattice `R`, since `uf,(u−t)f∈R` forces `f∈R`. At `t=0`
  the maximal lattice is `u⁻¹k[u]_((u))`. In ambient lattice `u⁻¹R`,
  the principal-part map on `u⁻¹R/R≅k[t]_((t))` is multiplication by
  `−t` in its second component; its cokernel is `k`, which is not flat
  over `k[t]_((t))`. The relative stratum therefore detects the failure.
- For `M=𝒪_f(−1)`, the Hom space from `𝒪_f(−1)` to `M` is `k`.
  This pure one-dimensional sheaf fails the maximal-lattice condition even
  though it exists in the coherent operator category.
- A rank-one equation with multiplier `a` normalized by a rank-one section
  with multiplier `c` acquires multiplier `a/c`. For `c=2` this is `a/2`,
  so forgetting the normalization loses scalar information in the equation.

*Needs:* 1.1–1.4 and 3.1–3.2; SchemeAndStackFoundations 2.2, 2.6, and 4.14;
AlgebraicVectorBundles L0A–L0C. *Sources:* [R13, §2]; [R25, §19.1].

### 3.4 The automorphism case and Jimbo–Sakai's operator surface

For `C=ℙ¹`, `q≠0`, and `σ(z)=qz`, construct

    ℰ_q = 𝒪_Δ ⊕ 𝒪_(Γ_σ),     Γ_σ = {(σ(z),z)}.

With 3.1's tensor convention its two summands act by `V` and `σ*V`.
A two-arrow presentation consists of `b₀:W→V` and `b₁:W→σ*V`, with
`b₀` generically invertible. Its covariant reconstructed map is `A=b₁b₀⁻¹`.

- Prove the regular-gauge and meromorphic-modification dictionaries, including
  determinant identities and the local-position strata of 1.2. Compare the
  covariant ratio with the transpose-dual presentation when solutions are
  computed through `Hom(M,Mer)`.
- For the degree-two Jimbo–Sakai chart take `W=V(−2∞)`, let `b₀` be the
  inclusion, and let `b₁` be the restricted connection map. Compute the
  raw class `(0,2s+4f,2)` on this unpolarized ruled model, with `s²=f²=0`
  and `s·f=1`. Construct also the polar bimodule
  `ℰ_q^pol=𝒪_Δ⊕(Γ_σ)_*𝒪_C(2∞)`, where the line twist is on the
  graph's second projection. The same coefficient matrix now gives the
  regular map `(Id,A):V→V⊗ℰ_q^pol`. Its commutative ruled model has
  type `𝔽₂`, and for `V=𝒪²` compute class
  `(0,2s_min+4f,2)`, with `s_min²=−2`; its Chern class is
  anticanonical. Track all ordered minimal lifts, their point-label shifts,
  and their numerical changes. Target 6.3 uses this polar presentation to
  obtain its eight-point anticanonical operator model.
- Over `K=k(C)`, compare with the Ore algebra `K[T,T⁻¹;σ]`, where
  `Tf=σ(f)T`; in a matrix frame the associated semilinear operator is
  `A⁻¹σ`. Globally retain the correspondence and bimodule, since `σ` moves
  open subsets. Compute the point/anticanonical curve of the presentation,
  including the components over the fixed points of `σ`
  ([R25, §§9.2–9.3 and §19.1]; [JS, §3]).

**Checks.**

- At a fixed point of `σ`, the joint fiber of
  `𝒪_Δ⊕𝒪_(Γ_σ)` at the corresponding point of `C×C` has dimension
  `2`; the joint fiber of `𝒪_(Δ∪Γ_σ)` has dimension `1`. Replacing
  the direct sum by the structure sheaf of the union changes the bimodule.
- For `q≠1`, the point curve has equation `z₀z₁uv=0` in the indicated
  two projective-line coordinates and has four irreducible components.
  The two graph branches alone have two components and omit the fixed-point
  contributions.
- At `q=1`, the bimodule is `Δ_*(𝒪²)` and its coherent quotient is
  `coh(ℙ¹×ℙ¹)`. Direct substitution therefore gives a commutative ruled
  surface, not the differential-operator category used in a rescaled limit.
- The unpolarized raw class has square `(2s+4f)²=16`, whereas the polar
  anticanonical class has square `(2s_min+4f)²=8`. Subtracting eight
  simple exceptional classes gives squares `8` and `0`, respectively;
  eight blowups alone do not turn the first class into an anticanonical one.

*Needs:* 1.1–1.3 and 3.1–3.3; Mathlib `Algebra.SkewPolynomial.Basic` and
`RingTheory.OreLocalization.Basic`, with the Ore relation and localization
hypotheses verified in the chosen semilinear convention.

### 3.5 Elliptic correspondences, descent, and reflection

Let `Q` be a smooth genus-one curve, let `π_i:Q→C_i≅ℙ¹` be finite flat
degree-two maps with deck involutions `ι_i`, and let `L` be an invertible
sheaf. Construct the birank-`(2,2)` bimodule and coefficient map

    ℰ = (π₀,π₁)_*L,     B:π₀*V₀ ⇢ π₁*V₁⊗L.

Set `U=π₀*V₀`, `τ=ι₀ι₁`, and `T=L⊗(ι₁*L)⁻¹`. Define

    A = (ι₁*B)⁻¹B:U ⇢ ι₁*U⊗T ≅ τ*U⊗T.

The linear object consists of this twisted map, the `ι₀`-descent of `U`, the
reflection/inverse compatibility, and its coherent local lattices. Retain the
canonical norm trivialization `T⊗ι₁*T≅𝒪_Q`.

- Construct the presentation comparison of 3.3. For the column-solution
  convention the regular presentation uses
  `B†:π₁*V₁∨→π₀*V₀∨⊗L`, obtained by dualizing `B` and tensoring
  with `L`; it corresponds to `ρ₁*V₁∨→ρ₀*V₀∨`. Use the specified
  regular sublattices when `B` is meromorphic. Compute the corresponding
  contravariant meromorphic representation and prove that it gives the
  displayed twisted `A`, including the inverse-dual action on gauge arrows.
  For an untwisted realization `Hom(M,Mer)` use the section normalization of
  3.3 and retain its scalar factor. Derive the numerical class from the
  resolution.
- Prove descent to the coarse double-cover quotient with trivial inertia
  action at ramification points. Compute `τ` from the two degree-two quotient
  line bundles and prove that it is a Jacobian translation acting on the
  genus-one torsor. Retain its order as an additional hypothesis of each
  dynamical application.
- In additive coordinates with `ι₀z=−z` and `ι₁z=−z−h`, prove the
  untwisted comparison
  `Y(z+h)=A(z)Y(z)`, `Y(−z)=Y(z)`, and `A(−z−h)A(z)=I`.
  Prove that replacing `U` by `U⊗P` removes `T` exactly when an
  isomorphism `T⊗P≅τ*P` is supplied. Intrinsically the obstruction is the
  class of `T` modulo the image of `P↦τ*P⊗P⁻¹` from `Pic(Q)` to
  `Pic⁰(Q)`. After choosing an origin and writing `τ=t_a`, a degree-`n`
  bundle contributes `−na`; hence the obstruction vanishes exactly when
  `[T]∈ℤa`. Degree-zero twists do not change it.
- Construct `ℰ` directly in families and prove the corresponding descent
  and base-change statements. Use [R25, Proposition 9.14] for its fieldwise
  recovery of a correspondence and coefficient sheaf; do not extend that
  recovery to every family by definition. For singular reducible
  correspondences retain branch maps and regular-lattice gluing separately.

Construct a shared analytic scalar foundation. For `0<|p|<1`, define

    θ_p(z) = Π_(n≥0)(1−pⁿz)(1−p^(n+1)/z),     z≠0.

Prove normal convergence, simple zero divisor `p^ℤ`, and
`θ_p(pz)=θ_p(1/z)=−z⁻¹θ_p(z)`. Compare this normalization with Mathlib's
two-variable Jacobi theta function and construct the comparison between
`ℂ*/p^ℤ` and its algebraic genus-one curve, including the line bundles
represented by theta automorphy factors. Targets 6.4 and 7.1 use this same
foundation, with `p=q` only in the former application
([R13, §2]; [R25, §§9.2 and 19.1]; [OR, §§2–3]).

**Checks.**

- The ordered product `ι₀ι₁` sends `z` to `z+h`; the reverse product
  sends it to `z−h`. This fixes the difference step in the formula for `A`.
- Locally for `u↦u²`, a trivial line with involution acting as `−1` on
  its fiber has invariant sections `u·k[u²]`. The pullback comparison is
  multiplication by `u`, which is not invertible at `u=0`; coarse descent
  therefore fails for this nontrivial inertia action.
- For `τ=t_a` and `P=𝒪(p)`, the class of `τ*P⊗P⁻¹` is
  `[(p−a)−p]=−a`; for every degree-zero `P` it is zero. A twisting
  class outside `ℤa` cannot be removed by a line-bundle change.
- The product gives `θ_p(1)=0` with a simple zero, and the multiplier under
  `z↦pz` is `−1/z`. The zero divisor is invariant under that shift, but
  the function is not periodic.

*Needs:* 1.1–1.3 and 3.1–3.3; AlgebraicCurves Layers 3–5 and 12;
SchemeAndStackFoundations 3.2–3.7 and 1.17–1.23; ComplexTori Milestones 1–2;
ComplexManifolds Milestone 7; Mathlib
`NumberTheory.ModularForms.JacobiTheta.TwoVariable`.

### Examples

The split graph bimodule in 3.4 gives an ordinary multiplicative difference
equation; the genus-one correspondence in 3.5 gives a reflection-compatible
twisted equation. Both acquire coherent completions through the same ruled
presentation and ordered boundary blowups. The family `B=(u,u−t)` in 3.3
shows why the coherent completion must remain defined when the canonical
equation lattice jumps. On the commutative locus the construction recovers
ordinary sheaves on rational surfaces, with `rank K₀=12` in the eight-point
model.

### Dependencies

Target 3.1 builds the graded and enhanced ruled categories from the bundle,
localization, and dg suppliers. Target 3.2 uses the geometric boundary and
blowup theory of Layer 2 to give their hearts, relative homological algebra,
and numerical classes. Target 3.3 then uses those relative Hom and pushforward
results to prove reconstruction. Targets 3.4–3.5 specialize that theorem;
the scalar analytic construction in 3.5 precedes both analytic applications.
No moduli-space comparison from Layer 4 or either application is an input to
the operator-surface construction.

## Layer 4: Moduli and Poisson geometry

### 4.1 The actual moduli functors and their construction

For a split family `𝒮/B` of 3.2, fix an ample numerical class `H`, represented
by the line objects used for twists. A coherent sheaf is pure of dimension one
when every nonzero subobject has dimension one. For class `v=(0,D,d)` define

    P_M(n) = χ(𝒪_𝒮(−nH),M),     p_M(n) = n + d/(H·D).

Define stability and semistability by the strict and weak reduced-polynomial
inequalities for nonzero proper subobjects. Fix the numerical class itself,
not just its Hilbert polynomial. Define the relative Quot functor for a coherent
`N` by sending `T→B` to quotients `N_T→M` with `M` flat over `T` and with
the specified polynomial on every geometric fiber; isomorphisms commute with
the quotient map. The source `N` need not be flat over `B`.

- Construct the graded-module Quot functor and prove projective
  representability and base change, including the flattening and numerical
  class strata ([R25, Theorem 17.26 and Corollary 17.27]). Prove the
  subobject/quotient stability criteria, openness, and the finite wall
  description on each bounded region of polarizations.
- For a fixed class `v` and `H`, locally on a quasicompact base chart prove
  one integer `m₀` such that every geometric semistable `M` of class `v` is
  generated and acyclic after every twist `m≥m₀`. The integer is uniform in
  `M`. Use it to construct the framed Quot atlas, its `GL_n` action, and
  an ample determinant linearization. After an integral power and a determinant
  character twist make the central scalar weight zero. Construct its
  projective GIT quotient from the invariant section ring and prove that GIT
  semistability and orbit equivalence give the defined sheaf semistability
  and S-equivalence. On the sheaf-stable locus prove that orbits are closed
  in the semistable locus and their stabilizer is exactly the central
  `𝔾_m`; the resulting `PGL_n` action has trivial stabilizers. Use this
  quotient by the center when stating GIT stability
  ([R25, §17.1, Lemmas 18.12–18.16, and Theorem 18.17]).
- Consume `TauCeti.ComoduleAlgebra.finiteType_coinvariants`, invariant
  exactness, and
  `TauCeti.GeneralLinear.linearlyReductiveCommHopfAlgProperty_coordinateHopfAlgebra`
  for this quotient construction. Prove the operator Quot linearization,
  projective quotient, and sheaf-stability comparison here; the native
  invariant results do not already identify this moduli problem.
- Construct the algebraic stacks, projective semistable coarse spaces, and
  separated stable open coarse spaces, with their universal-object covers.
  For bounded connection problems use 1.4's bundle charts and 1.2's actual
  local-type equations. Transfer the stability comparison to their
  presentation domains through 3.3. Simple, stable, and irreducible remain
  distinct predicates; no separated coarse space is asserted for every
  unqualified connection stack.

In particular apply this construction to `𝒮_(z,η)` and
`v=(0,rQ,d)` with `r>0`, `gcd(r,d)=1`, and `z^rη^d=1`. State the
polarization and prove that all semistable objects are stable whenever this
is used. Flatness, saturation, stabilizers, and agreement of the quotient
construction with the original family functor are conclusions of the target.

**Checks.**

- Replacing `H` by `mH`, with positive integer `m`, changes every slope
  `d/(H·D)` to `d/(mH·D)`. All comparison inequalities have the same
  sign, so the stable and semistable loci agree.
- For class `(0,Q,1)`, a positive-dimensional subobject with `χ=0` has
  slope `0<1/(H·Q)`. One with `χ=1` and
  `0<H·c₁≤H·Q` has slope at least `1/(H·Q)`. The two possibilities
  lie on different sides of the stability condition.
- On a smooth integral genus-one curve, `L⊕L` has a summand with exactly
  the same reduced polynomial as the whole sheaf. It is semistable and not
  stable, and its automorphism group is `GL₂`, not `𝔾_m`.
- If a determinant linearization has central scalar weight `P(ℓ)` on a
  framing space of dimension `n`, its `n`th power tensored by the
  character `det^(−P(ℓ))` has weight
  `nP(ℓ)−nP(ℓ)=0`. An uncorrected nonzero central weight would eliminate
  the intended semistable points.

*Needs:* 1.1–1.4 and 3.1–3.3; SchemeAndStackFoundations 1.17–1.23, 2.2,
2.6, and 4.14; the native invariant-theory declarations in the supplier
contracts. *Sources:* [R25, §17.1, Theorem 17.26, Corollary 17.27,
Lemmas 18.12–18.16, and Theorem 18.17].

### 4.2 Scalar rigidification and universal objects

On the simple-object locus prove, using relative Hom and base change, that the
identity induces `𝒪_B≅End(M)` and the inertia is the central `𝔾_m`.
Construct its rigidification and the scalar gerbe over the simple coarse
space; restrict it to the stable moduli spaces of 4.1. Keep fixed determinant
type, fixed determinant isomorphism class, a chosen determinant isomorphism,
projectivization, and scalar rigidification as different operations.

- Construct rigidification, its universal property for maps killing the
  scalar inertia, and its compatibility with pullback. Compute the effect
  of each determinant operation on automorphisms and local types. For a
  rank-`r` connection a chosen determinant isomorphism reduces scalar inertia
  to `μ_r`; fixing only the determinant isomorphism class leaves `𝔾_m`.
- For the universal flat families use 3.2's relative finite resolutions and
  proper cohomology to prove the required perfectness. Construct determinant
  of cohomology by descent, with exact-sequence and base-change laws and the
  scalar-weight calculation. This construction precedes the tau application.
- For `M` of class `(0,rQ,d)`, let `E` be the retained last exceptional
  class with `E·Q=1`. Prove
  `χ(𝒪,M)=d` and `χ(𝒪(−E),M)=d+r`. Choose integers `a,b` with
  `ad+b(d+r)=1` and form

      λ = det RHom(𝒪,M)^a ⊗ det RHom(𝒪(−E),M)^b.

  Prove that `λ` has scalar weight one, so the universal object tensored by
  `λ⁻¹` has weight zero and descends to the coarse space. This proves
  neutrality of the scalar gerbe in these coprime cases. For `d=1`,
  `det RΓ(M)` already has weight one. Prove uniqueness up to a line bundle
  from the base and retain the normalization in every matrix reconstruction.

The Euler identities use [R25, Corollary 14.13]; the universal-object argument
is the coprime determinant construction in the proof of [R25, Theorem 18.17].
Finite-inertia Keel–Mori does not apply to the unrigidified scalar stack.

**Checks.**

- For `(r,d)=(1,2)`, the two determinant weights are `2` and `3`.
  The line `det RHom(𝒪(−E),M)⊗det RΓ(M)⁻¹` has weight `3−2=1`,
  so a universal family does not require changing the elliptic class to
  Euler characteristic one.
- For `(r,d)=(2,4)`, the weights are `4` and `6`; every integral
  combination is even. These two determinant lines cannot supply weight
  one. This calculation does not itself prove nonneutrality of that gerbe.
- A scalar `c` on a rank-two bundle acts on a determinant trivialization
  by `c²`. The stabilizing scalars are `μ₂`, whereas keeping only the
  determinant isomorphism class retains all of `𝔾_m`.

*Needs:* 3.2 and 4.1; SchemeAndStackFoundations 1.17–1.23, 2.2, and 2.6;
AlgebraicVectorBundles L0C; PadicMeasuresIwasawaAlgebras 5.1.

### 4.3 Deformation, obstruction, and the Poisson form

For fixed curve, automorphism, and polar divisor, construct the global
deformation complex of an unrestricted difference map from

    RHom_C(V,V) → RHom_C(V,σ*V(D)),
    f ↦ (σ*f)Φ − Φf.

Use derived global Hom or a `σ`-compatible Čech model: `σ` moves opens, so
this formula is not a differential of ordinary sheaves on `C`. For prescribed
local types construct the maps to the local constraint complexes of 1.2 and
take the corresponding homotopy fibers. Define automorphisms, tangent spaces,
and obstruction maps through square-zero lifting problems with the local data
retained.

- Prove that the cohomology in degrees `0,1,2` gives infinitesimal
  automorphisms, first-order deformations, and obstructions. Prove the
  relative base-change statements and compare the complex with operator-sheaf
  `RHom` on the presentation domain of 3.3.
- On the stable operator moduli construct the bivector by Serre duality,
  Yoneda composition, and trace from
  `Ext¹(M,θM)→Ext¹(M,M)`. Retain the scalar normalization of `θ→Id`.
  Verify the induced bracket on invariant local functions using the framed
  atlases, proving alternation, Jacobi, and compatibility with the quotient
  and overlap maps. Construct the enhanced trace and homotopy identities
  required for this proof; an unenhanced Serre
  pairing alone does not prove Jacobi. The general characteristic-zero
  statement, including singular anticanonical curves, is
  [R25, Theorem 18.4 and Corollary 18.6].
- Define the fixed-derived-restriction deformation problem for
  `N=Li_Q*M∈Perf(Q)`, retaining its isomorphisms and automorphisms.
  Construct the corresponding strata in the simple coarse moduli and prove
  that their connected components are the symplectic leaves. Their tangent
  space is
  `im(Ext¹(M,θM)→Ext¹(M,M))`. Prove smoothness for nonzero `N`
  by the restriction and determinant obstruction calculation of
  [R25, Proposition 18.7]. For `N=0` and nonzero numerical class prove
  smoothness by the determinant-varying deformation and dimension argument
  of [R25, Lemma 18.8 and Propositions 18.9–18.10]. Prove nondegeneracy
  and closedness of the induced two-form. Do not replace derived restriction
  by underived support or discard the automorphisms of the restriction object.

The smooth-boundary theorem [R16, Theorem 11.3] is a specialization, not the
source for the singular-boundary cases above. On a two-dimensional stable
phase `Ext²(M,M)` may be one-dimensional; unobstructedness is proved by the
obstruction calculation, not by asserting that this group vanishes. Target
5.4 compares the resulting normalized form with the geometric surface form.

**Checks.**

- With `σ=Id`, `Φ=diag(a,b)`, and `f=e₁₂`, the displayed differential
  is `(b−a)e₁₂`. It vanishes when `a=b` and is nonzero when `a≠b`,
  detecting the extra infinitesimal stabilizer at coincident eigenvalues.
- A skyscraper sheaf at a smooth point of a commutative surface has
  Ext dimensions `(1,2,1)` in degrees `(0,1,2)`. Its moduli is the smooth
  surface despite the nonzero one-dimensional `Ext²`.
- For that skyscraper sheaf, the map induced by `θ→Id` is multiplication
  by the value of the anticanonical Poisson section at the point. The induced
  surface Poisson rank is `2` off `Q` and `0` on `Q`.

*Needs:* 1.2, 3.2–3.3, and 4.1–4.2; DGAInfinity Layers 5–6;
SchemeAndStackFoundations 2.18–2.20, 4.3–4.6, and 4.14;
GrothendieckEulerForms.

### 4.4 A stable moduli construction of the completed phase

Fix the degree-one weak del Pezzo datum `Y,Q` of 3.2 over an algebraically
closed characteristic-zero field. Let `w∈Pic⁰(Q)`, let `r>0` and `d` be
coprime integers, and let `H` be ample with every semistable pure
one-dimensional sheaf of class `(0,rQ,d)` on
`𝒮_(w^(−d),w^r)` stable. Construct the moduli space and prove

    M̄_H(𝒮_(w^(−d),w^r);0,rQ,d) ≅ X_(w,1).

- Prove nonemptiness, smoothness, projectivity, and connectedness. Construct
  the universal Fourier–Mukai kernel with 4.2's normalization, its derived
  equivalence, and the numerical comparison. The unmarked surface theorem
  is [R25, Lemmas 18.18–18.21 and Theorem 18.22].
- Identify the anticanonical divisor in the moduli space, construct its
  boundary identification, and prove that `Li_Q*M=0` gives its complement.
  Retain the induced action on boundary line bundles and the scalar of the
  two-form when enhancing the unmarked comparison. A choice of equation
  chart, marking, or time element is supplied by the later comparisons.
- For class `(0,Q,1)`, prove directly that semistability equals stability
  and is independent of `H`: the strict inequalities for all nonzero proper
  positive-dimensional subobjects are equivalent to `χ(N)≤0`. For general
  coprime `(r,d)` keep the stated stability hypothesis; this includes
  `(r,d)=(1,2)` without a change of numerical class.
- Prove that the relative stable functor and universal-object construction
  commute with the base changes established in 4.1–4.2. A compatible marked
  family isomorphism requires the actual atlases, boundary maps, and inverse
  charts of 5.4; targets 6.3 and 7.4 construct them for the two examples.
  Fieldwise existence of an unmarked isomorphism is not the family argument.

**Checks.**

- When `w=1` and `(r,d)=(1,1)`, a smooth genus-one fiber `C` of the
  commutative rational elliptic surface contributes `Pic¹(C)≅C`, by
  `p↦𝒪_C(p)`. Its sheaves have `c₁=Q` and `χ=1`, giving the smooth
  fibers of the compactified degree-one relative Picard description.
- If `M` has class `(0,Q,1)`, a proper subobject with `χ=1` has slope
  at least that of `M`; every one with `χ≤0` has strictly smaller slope.
  For `(0,Q,2)`, by contrast, the equality test is
  `χ(N)(H·Q)=2(H·c₁(N))`, which retains the polarization. If `H·Q`
  is odd, coprimality excludes equality for a proper positive-dimensional
  subobject with smaller Hilbert-polynomial leading coefficient.
- At a stable point with `θM≅M` and `c₁(M)=rQ`, simplicity gives
  `dim Hom(M,M)=dim Ext²(M,M)=1`, while `Q²=0` gives
  `χ(M,M)=0`. Therefore `dim Ext¹(M,M)=2`, the dimension of the
  completed phase surface.

*Needs:* 2.1–2.3, 3.2, and 4.1–4.3. *Sources:* [R25, Lemmas 18.18–18.21
and Theorem 18.22]; the relative enhancement is the atlas construction of 5.4
applied in 6.3 and 7.4, not an additional hypothesis of the fieldwise theorem.

### Examples

The same moduli theorem covers both `χ=1` and the elliptic presentation's
`χ=2`. In the latter case determinant weights `2` and `3` already produce a
universal family, while stability keeps its polarization. The commutative
specialization identifies degree-one sheaves on elliptic fibers with points
of those fibers. Skyscraper Ext dimensions `(1,2,1)` exhibit smoothness with
nonzero obstruction space and explain why the trace obstruction is needed.

### Dependencies

Target 4.1 uses the relative operator categories and numerical classes of
Layer 3 to build the Quot and GIT moduli. Target 4.2 descends universal objects
using the determinant supplier and the Euler pairing of 3.2. Target 4.3 proves
the deformation and Poisson statements on those actual moduli spaces. Target
4.4 combines these results with the fieldwise stable-moduli theorem; relative
marked comparisons and time maps are subsequent constructions, so they do
not enter its hypotheses.

## Layer 5: Transformations and comparison theorems

### 5.1 Geometric Weyl transformations

Define a Cremona isometry of a marked rational surface to preserve the
intersection form, canonical class, and effective cone. Construct the simple
changes of marking by resolved birational maps between the relevant parameter
fibers and prove

    s_α(x) = x + (x·α)α,     α²=−2.

Define the domains through the blowdown linear systems of the models in 2.4:
the ruling pencils have two global sections and are base point free after the
specified blowups, plane systems have the specified three-dimensional section
space, and the contracted divisors form the required exceptional configuration.
Express these conditions by relative cohomology, evaluation-rank, and incidence
conditions. Prove the claimed open or locally closed domain descriptions.

- Construct each elementary change on this domain, its inverse, the induced
  parameter and boundary-period maps, and the transformed effective chamber.
  Prove the Picard formula from the actual pullback of divisors.
- Prove Coxeter relations as equalities of the resolved maps on their common
  domains, and construct diagram automorphisms separately. Build domains of
  finite words by the inverse-image composition law of 0.1.
- Prove geometric realization for the symmetry data of every type in 2.4.
  On effective-root walls specify the changes of marking and chamber and the
  resolved correspondences that remain defined. A lattice reflection taking
  an effective class to a noneffective one is not an automorphism preserving
  the effective cone of that fixed marked surface
  ([Sakai]; [KNY, §§3, 5.7, and 8.4]).

**Checks.**

- For `α=E₁−E₂`, the formula gives `s_α(E₁)=E₂` and
  `s_α(E₂)=E₁`, agreeing with interchange of the ordered centers.
- For `α=H_f−H_g`, one has `α²=−2`,
  `s_α(H_f)=H_g`, and `s_α(H_g)=H_f`. This is the ruling interchange
  with its corresponding transformed parameters.
- If a nonzero effective root `α` occurs on a fiber, its reflection sends
  it to `−α`. An ample class has positive intersection with `α` and
  negative intersection with `−α`, so both cannot be effective. This
  excludes a fixed-fiber effective-cone-preserving automorphism with that
  Picard action.

*Needs:* 0.1 and 2.1–2.4; IntegralLattices;
RepresentationTheory/RootSystems; KacMoody Layer 2;
SchemeAndStackFoundations 2.2, 2.6, and 4.14 for the relative linear-system
domains.

### 5.2 Translations and discrete Painlevé data

Use the native Eichler transvection in the Picard convention

    t_v(x) = x + (x·δ)v − [x·v + (v²/2)(x·δ)]δ,
    δ²=0,     v·δ=0,     v²∈2ℤ.

Consume its integrality, isometry, addition law, and invariance under
`v↦v+nδ`. Identify the translation sublattice of each symmetry type, and
realize it by the geometric transformations of 5.1. For an extended-Weyl
element whose power is a translation retain the element, that power, and the
translation parameter separately.

A geometric discrete Painlevé datum consists of the marked family of 2.2, an
admitted translation or specified extended-Weyl element, its base action, and
its realized phase transport on the domain groupoid of 0.1.

- Construct coordinate presentations and their changes of marking. Compute
  the scalar in the pullback of the normalized meromorphic two-form and
  prove that it equals one for the selected Painlevé time elements.
- For `α·δ=0`, prove the period identity
  `per(t_vα)=per(α)⊗per(δ)^(−α·v)`. Compute also `per(δ)` and the
  parameter action for every classified boundary type; after choosing the
  appropriate generalized Picard coordinate this gives the elliptic,
  multiplicative, or additive step.
- Prove the composition law for the realized transports and distinguish
  primitive translations, their multiples, and extended-Weyl elements with
  translation powers. A surface and its boundary do not select a nonzero
  translation parameter ([Sakai]; [KNY, §§3, 5.7, and 8.4]).

**Checks.**

- For `v=E₁−E₂` in the eight-point lattice, the formula gives
  `t_v(E₂)=E₁` and `t_v(E₁)=2E₁−E₂+2δ`.
- Replacing `v` by `v+nδ` leaves the map unchanged; in particular
  `t_(nδ)=Id` for every integer `n`. A nonzero representative along the
  isotropic line does not give a nontrivial time step.
- For integer `n`,
  `t_(nv)(E₂)=E₂+n(E₁−E₂)+(n²−n)δ`.
  The `n²−n` term detects the translation addition law and distinguishes
  it from an ordinary linear shift in the exceptional classes.

*Needs:* 0.1–0.3, 2.3–2.4, and 5.1;
`TauCeti.LinearAlgebra.IntegralLattice.Isometry.Transvection` and its
`eichlerTransvection` isometry, addition, and isotropic-parameter APIs.

### 5.3 Modifications, stability, and group relations

Construct the elementary modification functors and their action on local
types, numerical classes, parameters, markings, and polarizations from the
actual operations of 1.3 and 3.2. For a specified derived equivalence `F`,
define its stable sheaf domain by concentration of `F(M)` in the target heart,
the prescribed numerical class, and target stability. Construct this locus
using the bounded relative complexes, cohomology-vanishing conditions, and
stability opens; construct the corresponding inverse domain. These are
conditions on objects, not an assumed equivalence of the resulting spaces.

- Prove that the modification and its inverse induce mutually inverse
  transports on these domains and compute their Picard actions. Construct
  the chamber changes or stable replacements used by each full-phase
  extension in Layers 6–7, and prove agreement on their common domains.
- Prove the required relations as natural isomorphisms of object functors,
  including their associativity coherence when a categorical action is
  claimed. Prove the resulting equalities of coarse transports separately
  from the lattice relations ([R25, §12.3 and §19.1]).
- In the elliptic plane realization compute the subgroup generated by the
  elementary Hecke shifts and permutations. Its `A₈` translation lattice has
  index three in `E₈`; construct the additional degree-changing operation
  that supplies the full geometric `E₈` action ([OR15, §6]).

**Checks.**

- On a commutative rational elliptic surface with an `I₂` fiber
  `F=C₁+C₂`, a line bundle of multidegree `(0,1)` has Euler
  characteristic `1`. Its maximal subobjects supported on `C₁` and `C₂`
  have Euler characteristics `−1` and `0`, respectively, so its pushforward
  is stable in class `(0,Q,1)`. Tensoring by `𝒪(C₁)` gives
  multidegree `(−2,3)`. The subobject supported on `C₂`, with the two
  nodes subtracted, now has degree `1` and Euler characteristic `2`, so
  it destabilizes for every ample polarization. The autoequivalence
  preserves simplicity and fails to preserve this stable phase.
- The determinants of the root lattices are `det A₈=9` and `det E₈=1`.
  Their full-rank inclusion therefore has index `√9=3`, so the elementary
  translations cannot already be the full `E₈` translation lattice.
- Let `C₃=⟨a⟩`, take every functor to be `Id`, and take scalar
  comparison maps `c(a,a)=2` and `c(g,h)=1` for all other pairs. Every
  coarse and lattice map is the identity. The associativity equation at
  `(a,a,a²)` has sides `2` and `1`, so these comparisons do not define
  a coherent categorical action.

*Needs:* 1.3, 3.2–3.3, 4.1–4.4, and 5.1–5.2;
DGAInfinity Layers 5–6 for enhanced functor composition and natural
transformations. *Sources:* [R25, §§12.3 and 19.1]; [OR15, §6].

### 5.4 The comparison theorem and its verification data

Prove a gluing theorem with the following explicit input. Let `β:B→B′` be
an isomorphism of parameter spaces, let `M̄/B` be the separated stable coarse
family, and let `X/B′` be the separated marked rational-surface family.
After pulling `X` back along `β`, let `Z⊂M̄` and `D⊂X` be their specified
relative Cartier boundaries. Take open covers `M_i` of `M̄` and `X_i` of `X`,
and constructed isomorphisms `φ_i:M_i→X_i` with constructed inverses.
Require that `φ_i` carries `M_i∩M_j` onto `X_i∩X_j` and agrees there with
`φ_j`. On these charts give compatible identifications of the boundary ideal
sheaves, the marked line-bundle classes, and the chosen meromorphic two-forms.

- Prove that the chart maps and their inverses glue to a unique isomorphism
  of marked pairs `φ:(M̄,Z)≅(X,D)` over `β`, respecting the normalized
  forms. Prove independence under refinement. For étale or smooth atlases
  instead of open covers, construct the isomorphisms on the relation spaces
  and their cocycles and apply effective descent; a list of pointwise
  identifications is not such descent data.
- Let a modification transport `H_T` and a geometric time `T_X` have the
  matched parameter action and common specified source domain `Ω`. If
  `φ_(Tλ)∘H_T` and `T_X∘φ_λ` agree on a relatively schematically dense
  open of `Ω`, use 0.3 and separatedness to prove equality on `Ω`.
  Prove schematic density of the actual chart, including nilpotent base
  directions. Apply the same argument on every asserted extension domain.
- In each application construct the parameter map and its inverse, the
  equation–sheaf functor and inverse on each presentation chart, scalar
  descent, blowup coordinates and inverse coordinates, chart coverage,
  boundary and marking comparison, periods, and the two-form scalar.
  Compute the numerical sheaf class from its resolution and every class
  change; do not assign `(0,Q,1)` to a raw matrix problem. Construct the
  modification domain, transformed local type, and the actual time element,
  and verify the displayed equality of time maps on the dense chart.

Targets 6.3 and 7.4 supply these data for the two benchmark problems. The
gluing theorem takes local maps with inverses and overlap identities as input;
it does not take the desired global family isomorphism as a hypothesis.
Agreement of dimensions, surface types, periods, or Picard actions alone does
not supply its input. The equality principle is
`TauCeti.ext_of_isSchemeTheoreticallyDominant`, with its hypotheses verified
as in 0.3 ([Stacks, Tag 01KM]); the equation presentation input is
[R25, §19.1].

**Checks.**

- `Bl₀(𝔸²)→𝔸²` is an isomorphism away from the origin but contracts
  an exceptional `ℙ¹`. An inverse on that dense open does not provide
  covering inverse charts for an isomorphism of completions.
- On `ℙ¹×ℙ¹`, the maps `Id` and `(x,y)↦(2x,y)` induce the same
  Picard action. They send the point `(1,1)` to `(1,1)` and `(2,1)`,
  respectively, so Picard equality cannot replace equality of phase maps.
- Over `A=k[ε]/(ε²)`, the two endomorphisms of `𝔸¹_A` given by
  `x↦x` and `x↦x+ε` agree on every geometric fiber and differ over
  `A`. Their values at `x=0` are `0` and `ε`, showing why fiberwise
  equality cannot establish the relative comparison.

*Needs:* 0.3, 1.3–1.4, 2.1–2.3, 3.3–3.5, 4.1–4.4, and 5.1–5.3;
SchemeAndStackFoundations 1.17–1.23 for effective descent; native scheme
gluing, separated morphisms, and
`TauCeti.ext_of_isSchemeTheoreticallyDominant`.

### Examples

The root reflection `E₁−E₂` interchanges the ordered centers, while the
translation with the same parameter sends `E₁` to
`2E₁−E₂+2δ`; these are different geometric operations. The `I₂` calculation
in 5.3 shows why a derived symmetry needs a separate stability analysis.
Target 5.4 then compares actual time transports on the Jimbo–Sakai and
elliptic atlases, whose coverage and inverse coordinates are supplied in
6.3 and 7.4.

### Dependencies

Targets 5.1–5.2 realize the lattice theory on the independently constructed
marked families of Layer 2. Target 5.3 uses the operator operations and stable
moduli of Layers 3–4 to construct the corresponding transports with their
actual stability domains. Target 5.4 combines these independently defined
objects through chart gluing and 0.3's relative equality theorem. The two
applications verify its local hypotheses; they are consumers of this theorem,
not prerequisites for the general construction.

## Layer 6: Jimbo–Sakai `qPVI`

### 6.1 The linear problem and its presentation

Fix `q∈k×` of infinite multiplicative order, `C=ℙ¹`, `σ(x)=qx`, and
nonzero ordered parameters `(a₁,a₂,a₃,a₄,κ₁,κ₂,θ₁,θ₂,t)` with

    θ₁θ₂ = κ₁κ₂a₁a₂a₃a₄.

Require the four points `ta₁,ta₂,a₃,a₄` to be distinct, and
`κ₁≠κ₂`, `θ₁≠θ₂`. Define the degree-zero rank-two connection functor by
position `(1,0)` at those four points, position `(−2,−2)` at `∞`, ordered
leading eigenvalues `κ₁,κ₂` at `∞`, and ordered eigenvalues `tθ₁,tθ₂` at
`0`. Retain the determinant connection and the local polar-line frames fixed
by `x`. The spectral variable is `x`; the phase variable below is `z`.

- Prove that the trivial-bundle chart with a leading eigenbasis consists of

      A(x,t) = A₀(t) + A₁(t)x + diag(κ₁,κ₂)x²,
      Spec(A₀) = {tθ₁,tθ₂},
      det A = κ₁κ₂(x−ta₁)(x−ta₂)(x−a₃)(x−a₄).

  These matrices are invertible over `k(x)`. Construct their quotient by
  constant diagonal conjugation and its map to the intrinsic connection stack.
- On the open where `A₁₂` has nonzero linear coefficient, define `y` by
  `A₁₂(y)=0` and `z=(y−ta₁)(y−ta₂)/(q A₁₁(y))`. For the following inverse
  chart also require `y z (y−ta₁)(y−ta₂)(y−a₃)(y−a₄)≠0`.
  Put `s_j` equal to the elementary symmetric functions of the four roots,
  `z₁=(y−ta₁)(y−ta₂)/(qκ₁z)` and `z₂=qκ₁z(y−a₃)(y−a₄)`.
  Solve the two linear equations

      α+β=s₁−2y,
      κ₁α+κ₂β=[t(θ₁+θ₂)−κ₁z₁−κ₂z₂]/y,
      γ=y²+2y(α+β)+αβ+z₁+z₂−s₂,
      δ₀=[s₄−(yα+z₁)(yβ+z₂)]/y.

  For a nonzero frame parameter `w`, reconstruct

      A₁₁=κ₁[(x−y)(x−α)+z₁],    A₁₂=κ₂w(x−y),
      A₂₁=κ₁w⁻¹(γx+δ₀),          A₂₂=κ₂[(x−y)(x−β)+z₂].

  Prove the determinant and trace identities and uniqueness modulo the stated
  diagonal frames. This is one open chart; 6.3 supplies its missing divisors.
- Prove the rank-one invariant-subbundle obstruction and identify the bundle
  strata using 1.4. Keep the finite algebraic collision conditions separate
  from the `q`-orbit exclusions in 6.4.

**Checks.**

- The four simple positions contribute determinant order `4`; position
  `(−2,−2)` contributes `−4`. Their sum is zero, as required for an
  untwisted degree-zero determinant connection.
- At `t=1`, the diagonal matrix with entries `(x−1)(x−2)` and
  `2(x−3)(x−4)` has leading eigenvalues `1,2`, zero eigenvalues `2,24`,
  and `θ₁θ₂=48=1·2·1·2·3·4`. It is reducible despite the distinct
  local eigenvalues and roots; its `A₁₂=0` also lies outside the `y,z` chart.
- Conjugation by `diag(2,1)` multiplies `A₁₂` by `2` and `A₂₁` by `1/2`
  and leaves `A₁₁` fixed. Hence it changes `w` to `2w` and leaves the
  reconstructed `y,z` unchanged, testing the quotient and coordinate convention.

*Needs:* 1.1–1.4, 3.4; elementary polynomial and matrix algebra from Mathlib.
*Sources:* [JS, §3, the matrix parametrization and determinant constraint];
[JR25, §2.2, (2.8)–(2.12)].

### 6.2 The `t↦qt` modification

In the matrix chart put `p_i=ta_i` and `ℓ_i=im A(p_i)` for `i=1,2`.
Require that both the source and the shifted four-point configurations are
simple, and that `ℓ₁≠ℓ₂`. Define the unique endomorphism `R₀` by
`R₀|ℓ_i=−qp_i`. Construct

    R(x)=x(xI+R₀)/[(x−qp₁)(x−qp₂)],
    R(x)⁻¹=adj(xI+R₀)/x,
    A′(x)=(qxI+R₀)A(x)adj(xI+R₀)/[q(x−p₁)(x−p₂)].

- Prove polynomiality of `A′` from `(qp_i I+R₀)A(p_i)=0`. Prove that it
  has the original leading coefficient, determinant roots `qp₁,qp₂,a₃,a₄`,
  and `A′(0)=qR₀A₀R₀⁻¹`. Establish the compatibility
  `A′(x)R(x)=R(qx)A(x)` as a map of regular lattices on its stated domain.
- Prove that `R` has position `(1,1)` at `0`, simple rank-one poles at
  `qp₁,qp₂`, no other zeros or poles, and `R(∞)=I`. Prove uniqueness with
  these conditions and the prescribed image-line cancellations ensuring
  polynomiality of `A′`. Equal image lines would force two different eigenvalues
  of `R₀` on the same line, so this matrix construction has exactly the
  specified extra open condition.
- Compute `det R=x²/[(x−qp₁)(x−qp₂)]` and

      det R(qx)/det R(x) = [(x−qp₁)(x−qp₂)]/[(x−p₁)(x−p₂)].

  Derive the recurrence in the coordinates of 6.1, with bars denoting `t↦qt`:

      b₁=a₁a₂/θ₁,  b₂=a₁a₂/θ₂,  b₃=1/(qκ₁),  b₄=1/κ₂,
      y ȳ/(a₃a₄) = [(z̄−b₁t)(z̄−b₂t)]/[(z̄−b₃)(z̄−b₄)],
      z z̄/(b₃b₄) = [(y−a₁t)(y−a₂t)]/[(y−a₃)(y−a₄)].

  The whole-phase extension and its inverse are separate conclusions of 6.3.

**Checks.**

- For `q=2`, `p₁=1`, `p₂=3` and image lines the coordinate axes,
  `R₀=diag(−2,−6)` and `R=diag(x/(x−6),x/(x−2))`. This has the required
  scalar zero at `0` and two distinct rank-one poles.
- In that example at `x=5`, `det R(10)/det R(5)=−3/8`, equal to
  `(5−2)(5−6)/[(5−1)(5−3)]`; the shifted determinant factors are fixed.
- If the same two image lines are equal, `R₀` would have eigenvalues `−2`
  and `−6` on one nonzero vector. No normalized `R` of the displayed form
  exists, although the underlying point may still have a regular phase image.

*Needs:* 0.1–0.3, 1.2–1.3, 6.1; kernels, images and adjugates of bundle maps.
*Sources:* [JS, §§3–4]; [JR25, §2.2, (2.14)].

### 6.3 The full phase and the missing matrix-chart curve

Use the graph and tensor-functor convention of 3.1. Absorb the polar divisor
in the actual coefficient bimodule

    E_q^pol=(i_Δ)_*𝒪 ⊕ (i_(Γ_σ))_*𝒪(2∞),
    F_(E_q^pol)(V)=V⊕σ*V(2∞),

where the graph line bundle is pulled back from the second projection.
By the projection adjunction, `(id,A)` defines a map
`β_A:ρ₁*𝒪²→ρ₀*𝒪²`; take its cokernel `M₀`. This is the covariant
equation–sheaf convention. Construct the regular-lattice functor, including
its maps on gauge arrows, before passing to its coarse quotient.

- Prove that this ruled category has the `F₂` numerical model
  `s²=−2`, `f²=0`, `s·f=1`, with tautological class `h=s+2f`.
  Compute `c₁(ρ₁*𝒪)=−h` and the projection cohomology, giving
  `class(M₀)=(0,2s+4f,2)`. Its first Chern class is the anticanonical
  class of this ruled model.
- Construct the four-component operator boundary and its eight ordered
  simple restriction points: the four determinant zeros on the positive
  section, the two eigenpoints `tθ₁,tθ₂` on the fiber at `0`, and the
  two eigenpoints `κ₁,κ₂` on the fiber at `∞`, with the polar frames in
  6.1. Blow them up in that order and take the successive minimal lifts of
  `M₀`. Prove that each lift subtracts the corresponding exceptional class
  from `c₁` and preserves `χ`. The resulting functor has class
  `(0,Q,2)`, where `Q=2s+4f−Σe_i` and `Q²=0`.
  Write the positive normal functor as `ν_*(−⊗𝒩)`. Derive the simple-point
  calculation from
  `RHom(k_(νp)[−1],M)≅RHom_Q(k_p,Li_Q*M⊗𝒩)`; the restriction zero
  itself is the raw center, and the normal-line fiber is retained. Compute
  the canonical core centers from the exceptional derived restrictions by
  3.2's normal-form construction. The auxiliary boundary embedding in
  [R25, Proposition 11.20, Remark 1] uses `νp`; identifying that auxiliary
  embedding with the canonical core requires its boundary comparison map.
  Keep both constructions distinct from the phase centers below.
- For comparison with the unpolarized kernel in 3.4, begin with
  `W=𝒪(−2∞)²` and presentation `(x_∞²I,A_h)` near infinity.
  Perform twice the elementary transformation at the quotient of the
  diagonal summand at `∞`, with each uniform twist taken on the second
  projection. The intermediate kernels are
  `𝒪_Δ⊕𝒪_(Γ_σ)(j∞)` and `W_j=𝒪((j−2)∞)²` for `j=0,1,2`.
  Prove the residual presentations `(x_∞I,A_h)` and `(I,A_h)` and the
  comparison of maximal lattices. The untwisted `F₀` model initially has
  class `2s+4f`; eight simple blowups there alone would not make it
  anticanonical.
- Compute the commutative core and boundary parameters of 3.2. In its
  normalization `det Li_Q*[𝒪_Q]=z_op`, `det Li_Q*[pt]=η`, the class
  `[M]=[𝒪_Q]+2[pt]` and derived disjointness give `z_op η²=1`.
  Thus 4.4 applies with `(r,d)=(1,2)` and `w=η` once the stability
  comparison is proved. First take an ample `H_*` with odd
  `n=H_*·Q`, using `H_*=2NH₀+e₈` for large `N` and ample `H₀`.
  Use the specific polarization `H=H_*+nf`, so `H·Q=3n` is odd and
  no object of this class is strictly semistable.
- Prove that the finite non-splitting coefficient locus below maps to this
  stable moduli. The minimal-lift presentation makes `M_A` a quotient of
  `𝒪²`, with `ρ_*M_A=𝒪²`, `R¹ρ_*M_A=0`. For a proper pure
  one-dimensional subobject `N`, let `a=c₁(N)·f∈{0,1,2}`. If `a=0`,
  its projection vanishes and `χ(N)≤0`. If `a=1`, its projection is a
  line subsheaf of `𝒪²`; degree zero would give a constant invariant line,
  excluded by the coefficient hypotheses, hence again `χ(N)≤0`.
  If `a=2`, the nonzero quotient is globally generated with torsion
  projection and vanishing first direct image; its Euler characteristic is
  at least one, so `χ(N)≤1`. Since `H_*·c₁(N)>0`, its slope is at most
  `1/[2n+H_*·c₁(N)]<2/(3n)`, the slope of `M_A`. Establish the
  projection and global-generation assertions using the ruling/minimal-lift
  API of 3.2, including in the bounded relative coefficient family.
  Use the weight `3−2=1` determinant normalization in 4.2 and retain this
  polarization in the family comparison.

Construct the phase charts and marking below independently, and prove the
relative marked comparison by 5.4, with `A₃^(1)` boundary and `D₅^(1)`
symmetry data. Compute the boundary identification from the operator core;
in the oriented phase coordinate below its image of `η` has period `q`.
The fieldwise theorem 4.4 does not supply this marking or parameter map.

Use the following exact normalization of [JR25, (1.1)]:

    a₁=k_t, a₂=k_t⁻¹, a₃=k₁, a₄=k₁⁻¹,
    κ₁=k_∞, κ₂=k_∞⁻¹, θ₁=k₀, θ₂=k₀⁻¹, f=y, g=qz.

For general 6.1 data, work on the finite parameter cover retaining
`c²=a₃a₄`, `d²=a₁a₂`, `e²=κ₁κ₂`, and set

    t̂=dt/c, f=y/c, g=qez,
    k_t=a₁/d, k₁=a₃/c, k_∞=κ₁/e, k₀=θ₁/(cde),
    Â(x)=A(cx)/(c²e).

Prove the inverse dictionary and the rank-one/determinant normalization.
Retain this spectral coordinate change and scalar tensor factor as data.
In the normalized coordinates, blow up the ordered centers

    p₁=(0,k₀t),       p₂=(0,k₀⁻¹t),
    p₃=(k_t t,0),     p₄=(k_t⁻¹t,0),
    p₅=(k₁,∞),        p₆=(k₁⁻¹,∞),
    p₇=(∞,k_∞⁻¹),    p₈=(∞,qk_∞).

For the coefficient-quotient theorem impose

    k_j²≠1 (j=0,t,1,∞),       qk_∞²≠1,
    t∉{(k_t k₁)^(±1),(k_t/k₁)^(±1)},
    k₀^ε₀ k_t^ε_t k₁^ε₁ k_∞^ε_∞≠1,
    t≠k₀^ε₀ k_∞^ε_∞          for every ε_j∈{−1,1}.

Prove that these conditions exclude constant triangular orbits and give the
geometric diagonal quotient. Let `D_t` be the strict transforms of the four
coordinate fibers and `U_t=X_t∖D_t`. Prove precisely

    {normalized polynomial matrices}/{diagonal conjugation} ≅ U_t∖E₈°,
    E₈°=E₈∖D_t.

- Construct the additional equation/sheaf presentation charts covering `U_t`,
  including `E₈°`, and prove their inverse constructions and overlap cocycles.
  For the compactification include the sheaves supported on the operator
  boundary. Construct reducible-wall extension charts using 4.1 and the
  relative Ext theory of 3.2, with their own parameter domain. Their Riccati
  restrictions are a subsequent application in 8.4.
- Resolve the two birational flips specified by the recurrence and prove that
  time and inverse time extend between the full open phases. Compare them
  with 6.2 on every equation chart. The omitted curve is not assigned to a
  bundle splitting stratum without computing its reconstruction.
- With pullback from the marking at `qt` to that at `t`, put
  `S=E₃+E₄+E₅+E₆`, `A_e=E₁+E₂+E₇+E₈`, `G=2H_f+H_g−S`. Prove

      T*H_f=5H_f+2H_g−A_e−2S,       T*H_g=G,
      T*E₁=G−E₂, T*E₂=G−E₁,       T*E₃=H_f−E₄, T*E₄=H_f−E₃,
      T*E₅=H_f−E₆, T*E₆=H_f−E₅,  T*E₇=G−E₈, T*E₈=G−E₇.

  Here `H_f` is the class of `f=constant`. The boundary components
  `D₁=H_f−E₁−E₂`, `D₂=H_g−E₃−E₄`, `D₃=H_f−E₇−E₈`,
  `D₄=H_g−E₅−E₆` are permuted by `(1 3)(2 4)`. Prove
  `(T*)²=t_v` for `v=2H_f−S`, and that `2` is the least pure-translation
  power. Normalize the two-form by `df/f∧dg/g`. Define the oriented boundary
  period coordinate by

      p_δ=(g₇g₈ f₃f₄)/(g₁g₂ f₅f₆)=q,

  where the finite coordinates of the indicated centers are used. Prove the
  period and Poisson comparisons with the independently constructed moduli.

**Checks.**

- Before the eight blowups, `(2s+4f)²=4(−2)+16=8` on `F₂`;
  afterwards `Q²=8−8=0`. The negative section already has square `−2`,
  the positive section has square `2−4=−2`, and both special fibers have
  square `0−2=−2`, giving the four-component canonical boundary.
- Taking `c=2,d=3,e=5` and normalized parameters
  `(k₀,k_t,k₁,k_∞)=(17,7,11,13)` gives
  `θ₁θ₂=(cde)²=900=κ₁κ₂a₁a₂a₃a₄`. Omitting `c` from the zero-eigenvalue
  normalization fails this determinant constraint.
- The displayed lattice matrix preserves the intersection matrix and `δ`,
  has characteristic polynomial `(λ−1)⁸(λ+1)²`, and squares to `t_v` with
  `v²=−4`, `v·δ=0`. Its nonidentity boundary permutation excludes a pure
  transvection at one step.
- For the nef class `H=H_f+H_g`, `((T*)ⁿH)·H=8n²+2`, giving
  `2,10,34,74,130,202,290` for `n=0,…,6`. This class is not asserted ample.
  Each of the two flips reverses the logarithmic two-form, so their
  composition preserves it.
- The eight-point products give `g₁g₂=t²`, `g₇g₈=q`,
  `f₃f₄=t²`, `f₅f₆=1`; hence the stated period is `q`, with no inversion
  or extra `q²` factor.

*Needs:* 2.1–2.4, 3.2–3.4, 4.1–4.4, 5.1–5.4, 6.1–6.2.
*Sources:* [JR25, §2, Definition 2.2 and Lemma 2.5]; [DH, §4.2];
[R25, §19.1, §19.2, Proposition 12.12, Theorem 15.1, §15.4,
Proposition 11.15 and Lemma 11.18] for presentations, numerical restriction,
minimal lifts and their boundary adjunctions. The simple-point kernel is
derived from those adjunctions. The marked relative comparison and the displayed lattice
normalization are conclusions here.

### 6.4 Analytic connection data and Riemann–Hilbert

Specialize to `0<|q|<1`. In the normalization of 6.3 require

    k₀²,k_t²,k₁²,k_∞² ∉ q^ℤ,
    (k_t k₁)^(±1),(k_t/k₁)^(±1) ∉ t q^ℤ,
    k₀^ε₀ k_t^ε_t k₁^ε₁ k_∞^ε_∞ ∉ q^ℤ,
    k₀^ε₀ k_∞^ε_∞ ∉ t q^ℤ      for every ε_j∈{−1,1}.

Put `K₀=diag(k₀,k₀⁻¹)`, `K_∞=diag(k_∞,k_∞⁻¹)` and
`A₀=H(tK₀)H⁻¹`. Construct the canonical analytic factors by

    Ψ_∞(qx)=x⁻²A(x)Ψ_∞(x)K_∞⁻¹,       Ψ_∞(∞)=I,
    Ψ₀(qx)⁻¹=tK₀Ψ₀(x)⁻¹A(x)⁻¹,        Ψ₀(0)=H,
    C(x)=Ψ₀(x)⁻¹Ψ_∞(x).

Prove convergence, uniqueness, and holomorphic dependence on parameters.
The connection-data functor consists of holomorphic matrices on `ℂ×` satisfying

    C(qx)=t x⁻²K₀ C(x)K_∞⁻¹,
    det C=c θ_q(k_t x/t,k_t⁻¹x/t,k₁x,k₁⁻¹x),  c≠0,

modulo independent constant diagonal changes of the two local eigenbases.
Use the theta normalization in 3.5; the extra `(q;q)_∞` in [JR25]'s scalar
theta multiplies this four-factor determinant by `(q;q)_∞⁴`, absorbed in `c`.

- Prove regular-gauge invariance and construct the affine Segre model `ℛ_t`
  of this quotient. The displayed `C` strips off the formal exponent factors;
  it is not defined to be a `q`-periodic matrix.
- Construct `RH_t:U_t^an→ℛ_t^an` and prove reconstruction and biholomorphism
  under the displayed hypotheses. Include the chart on `E₈°` and prove its
  agreement with the matrix chart. Own the analytic `q`-difference and
  Birkhoff factorization theorems needed for this conclusion.
- Prove that time induces `[C(x)]↦[xC(x)]`, and that `RH` intertwines this
  target identification with 6.3. This is a holomorphic comparison; no
  algebraic isomorphism with the affine Segre surface is inferred from it.

**Checks.**

- Taking determinants in the functional equation gives multiplier `t²/x⁴`.
  The four theta arguments have product `x⁴/t²`, and
  `θ_q(qz)=−z⁻¹θ_q(z)` gives exactly the same multiplier.
- For `C′(x)=xC(x)`, one obtains
  `C′(qx)=qt x⁻²K₀C′(x)K_∞⁻¹`. Leaving `C` unchanged would leave the
  old parameter `t` in the equation.
- The coefficient operator at order `n` near infinity is
  `V↦q⁻ⁿVK_∞−K_∞V`. On `E₁₂` it vanishes when `k_∞²=q⁻ⁿ`;
  for `q=1/2,n=1,k_∞²=2` this is a resonance despite distinct eigenvalues.

*Needs:* 0.3, 3.5's scalar theta foundation, 6.1–6.3;
ComplexComparisonPartII C−1.1–C−1.2, C0.1–C0.5, C1.9, C2.2;
ComplexKahlerGeometry K1, K3–K4 for the analytic carriers and calculus.
*Sources:* [ORS]; [JR25, (2.1)–(2.2), (2.22)–(2.23), §3.1,
Proposition 3.3].

### Examples

The eight-point model in 6.3 provides a complete algebraic benchmark: the
matrix chart misses a specified curve, one time step permutes boundary
components, and two steps give a specified lattice translation. The analytic
benchmark additionally excludes full `q`-orbits and changes the connection
matrix by `x`; these extra requirements can be tested independently.

### Dependencies

Targets 6.1–6.2 build the linear problem before 6.3 uses the moduli and marked
surface comparison. Target 6.4 adds analytic classification after the algebraic
phase is constructed. Layers 8–9 consume these concrete transports and charts;
the algebraic comparison does not depend on the analytic Riemann–Hilbert theorem.

## Layer 7: Elliptic Painlevé

### 7.1 Linear objects, their operator presentation, and interpolation

Work over characteristic zero. Fix a smooth genus-one curve `Q`, two degree-two
quotients `πᵢ:Q→Cᵢ=ℙ¹` with involutions `ιᵢ`, a line bundle `L` of degree four,
and eight ordered distinct points `u₀,…,u₇`. Put

    Aᵢ = πᵢ*𝒪(1),     τ = ι₀ι₁,
    Δ = u₀+⋯+u₇,      L² ≅ 𝒪_Q(Δ).

The isomorphism in the last expression is input, together with its determinant
section. For the nonautonomous benchmark require `τ` to have infinite order.
In the uniformization `Q=ℂ×/p^ℤ`, with
`ι₀z=η₀/z` and `ι₁z=η₀/(qz)`, this is `qⁿ∉p^ℤ` for every nonzero integer `n`.
Here `η₀` is the reflection constant; it is not the operator parameter `η`
defined in 7.2.

Define the presentation groupoid over a base scheme by rank-two degree-zero
bundles `Vᵢ` on `Cᵢ` and a regular map

    B: π₀*V₀ → π₁*V₁ ⊗ L

with the specified determinant section and simple rank-one degeneracy at each
`uᵢ`. Determinant-line identifications, base line bundles, and isomorphisms of
these objects are retained. The trivial-bundle chart has `V₀=V₁=𝒪²` and
left/right changes of frame. General degree-zero bundles are part of the
definition, so a jump of splitting type does not remove an object from this
groupoid.

Fix the operator surface `𝒮₀` from the bimodule `(π₀×π₁)_*L`, with the
induction functors of 3.1–3.3 normalized by

    L i_Q*ρ₀*V = π₀*V,
    L i_Q*ρ₁*W = L⁻¹⊗π₁*W.

Use the contravariant solution convention. The dual of `B`, tensored by `L`,
is the map

    B†: π₁*(V₁∨) → π₀*(V₀∨)⊗L.

The adjunction of [R25, Lemma 11.33] defines `β_B` and `M₀(B)` by

    0 → ρ₁*(V₁∨) ─β_B→ ρ₀*(V₀∨) → M₀(B) → 0.

In frames `β_B` is represented by `Bᵗ`. On an isomorphism `(g₀,g₁)` use
`g₀^(−∨),g₁^(−∨)` on this resolution; thus this is a covariant functor on the
presentation groupoid. Prove injectivity, purity, and base change from the
simple-determinant local models. This defines the sheaf before any comparison
with a Sakai surface is used.

Applying the meromorphic solution functor to this presentation gives
`B(ι₁z)Y(ι₁z)=B(z)Y(z)`. Retaining the `ι₀`-descent of `Y` gives

    Y(τz) = A(z)Y(z),     A(z) = B(ι₁z)⁻¹B(z).

Intrinsically this map takes `π₀*V₀` to `τ*(π₀*V₀)⊗T`, with
`T=L⊗(ι₁*L)⁻¹`. Use a specified reference section object `Σ` only when
converting this twisted object to scalar-normalized meromorphic operators.
Changing `Σ` has the rank-one effect of 3.5. It does not change the definition
of `M₀(B)`.

In the trivial-bundle chart, set `W=H⁰(Q,L)`. Construct the section/interpolation
dictionary in `W⁴`, which has dimension sixteen. Five prescribed kernel lines
and three prescribed image lines give sixteen homogeneous linear conditions.
Use the locus on which their coefficient matrix has rank fifteen and its
one-dimensional kernel consists of matrices with determinant a nonzero multiple
of the prescribed section. Normalize three distinct kernel lines by the right
projective group and three distinct image lines by the left projective group.
The remaining two kernel parameters vary. This rank and determinant condition,
with the indicated distinctness conditions, is the interpolation domain; a
dimension count alone does not define it.

Construct its theta expression using the scalar theory of 3.5. With
`θ_p(x₁,…,x_m)=∏ᵢθ_p(xᵢ)`, prove the identity

    a θ_p(z/a,az,b/c,bc)
    − b θ_p(a/c,ac,z/b,bz)
    + b θ_p(a/b,ab,z/c,cz) = 0.

Retain the multipliers of every section. Derive the Laurent-polynomial and
additive polynomial identities directly, as required by Layer 8.

**Checks.**

- Compute `h⁰(L)=4`, `h⁰(L²)=8`, and the interpolation kernel dimension
  `16−15=1`; rank fourteen instead leaves a projective line of answers.
- At `p=0`, `a=2,b=3,c=5,z=7`, the three addition-identity terms are
  `−364,432,−68`. In the additive identity they are `−720,840,−120`.
- On the resolution, `RΓρ₀*𝒪²=k²` and `RΓρ₁*𝒪²=0`, so `χ(M₀)=2`;
  the value one would require an actual further change of presentation or class.

*Needs:* 1.2–1.4, 3.1–3.3, 3.5, cohomology/base change, genus-one line
bundles, and the scalar analytic suppliers named in 3.5.
*Sources:* [OR, §§2–3, m=1]; [R25, Lemma 11.33, §§8.2, 19.1].

### 7.2 Ordered lifts, numerical class, and the completed phase

Blow up `𝒮₀` successively at the specified `u₀,…,u₇` on its identified
boundary curve. These are the raw noncommutative centers. Let `ν_Q` denote
the positive normal-twist automorphism, defined on supports by
`supp(k_p(Q))={ν_Qp}`; its one-dimensional fiber factor is retained below.
For the commutative core use 3.2's marked normal-form algorithm: its ordered
centers are the zeroth-Fitting supports of the restrictions of the transformed
exceptional objects, with the boundary comparison retained. These centers are
outputs of that fixed algorithm, not additional choices of eight points.
Neither the raw list nor its translate is substituted for that calculation.
Identify `ν_Q` with the spectral translation only by the point-class
computation below.
Write
`αⱼ:𝒮ⱼ→𝒮_(j−1)` for the raw blowup at `u_(j−1)` and
`eⱼ` for its marked exceptional class. Define the source functor by

    M(B) = α₈^(*!) ⋯ α₁^(*!) M₀(B),
    α^(*!)N = image(α*N → α!N).

Prove that these are relative minimal lifts and commute with base change on
the simple-determinant stratum. The local input is the transverse restriction
`L i_Q*M₀(B)=⊕ᵢ (jᵢ)_*Cᵢ`, where `jᵢ` is the section `uᵢ` and `Cᵢ`
is its rank-one cokernel bundle. Over a field each summand has length one;
in families the bundles `Cᵢ` are retained. In particular, the
centers and the lift functors are fixed by the input, independently of a phase
point or a proposed comparison map.

For the positive normal twist `(ν_Q)_*(−⊗𝒩)`, fix the apparent shift in the
gluing formula by the adjunction computation

    R Hom_𝒮(k_(ν_Qp)[−1],M₀)
      ≅ R Hom_Q(k_p,L i_Q*M₀⊗𝒩).

Thus a simple restriction zero at `u` is removed by the raw blowup at `p=u`,
with the indicated fiber line retained. The translated center in
[R25, Proposition 11.20, Remark 1] belongs to its auxiliary commutative
embedding and is not, by that statement alone, the center in the canonical
core of Theorem 11.31. Derive the two invisible terms from
[R25, Proposition 11.15] and Serre duality; the `?p` placeholders printed in
[R25, (15.21)–(15.22)] are not a specification of these subscripts.

Compute the class in the even ruled lattice. The restriction of `ρ₁*𝒪` has
degree `−4`, its fiber degree is `−1`, and its Euler characteristic is zero;
these give

    c₁(ρ₁*𝒪) = −s−f,     s²=f²=0,     s·f=1,
    [M₀] = (0,2s+2f,2),
    [M]  = (0,Q,2),       Q=2s+2f−e₁−⋯−e₈.

Each simple minimal lift subtracts one `eⱼ` from `c₁` and preserves `χ`.
Use 3.2's fixed marked normal-form construction to obtain `Y` and
`𝒮_(z,η)`. Verify preservation of this numerical normalization by that
construction. No unspecified twist to `χ=1` is included.

The operator parameter has a direct computation. For the point class, use
`[pt]=[ρ₀*k_(x₀)]−[ρ₁*k_(x₁)]`; restricting the two terms to `Q` gives

    η = det(L i_Q*[pt]) = A₀⊗A₁⁻¹.

Independently the normal-divisor triangle gives
`[L i_Q*i_*k_p]=[k_p]−[k_(ν_Q⁻¹p)]`, hence
`η=𝒪_Q(p−ν_Q⁻¹p)` for every `p`. Therefore `ν_Q` is translation by `η`.
Thus `η` corresponds to the translation `τ`: if `ιᵢz=aᵢ−z`, both have
additive parameter `a₀−a₁`; in the multiplicative chart it is the class of
`q` in `ℂ×/p^ℤ`. This proves `ν_Q=τ`; it was not part of the definition.
The determinant of the restriction of the displayed class
gives

    z⊗η² = L²⊗𝒪_Q(−Δ) = 𝒪_Q,
    w=η,     (z,η)=(w⁻²,w).

Fix an ample integral class `H` with `H·Q` odd and use reduced-Hilbert-polynomial
stability. Prove that semistability equals stability for this class: equality
of slopes would require a smaller positive degree to be a multiple of `H·Q`,
because `gcd(2,H·Q)=1`; a proper subobject with zero-dimensional quotient has
the same leading coefficient and strictly smaller Euler characteristic. Define

    M̄_H = M̄_H(𝒮_(w⁻²,w); 0,Q,2),
    M°_H = { M∈M̄_H : L i_Q*M=0 }.

Apply 4.4 with `r=1,d=2`, including its nonemptiness and universal-family
normalization, and construct the marked relative comparison with the smooth
anticanonical `A₀⁽¹⁾` phase. Its normal-bundle period is `w`, and its symmetry
lattice is `E₈⁽¹⁾`. The relative comparison is a theorem of this target: it
requires the functor above, effective descent of the universal kernels, and the
marking, two-form, and period identifications of 5.4. The fieldwise unmarked
isomorphism in [R25, Theorem 18.22] supplies only the corresponding part of
this argument.

For the explicit compactification below, further require that no real symmetry
root has trivial period. Prove stability on this pointwise parameter locus
from the operator numerical pairing. Subquotients of an object derived-disjoint
from the smooth nef boundary remain derived-disjoint. A nonzero zero-dimensional
factor of Euler characteristic `d>0` would have restriction determinant `η^d=1`,
contrary to the infinite-order hypothesis in 7.1. For a simple one-dimensional
factor `N`, Serre duality and the Euler pairing give
`dim Ext¹(N,N)=2+c₁(N)²`. The negative semidefinite pairing on `Q⊥` therefore
forces `c₁(N)²` to be `−2` or `0`. In the first case the trivial restriction
determinant produces a real affine root with trivial period, including the
necessary integral multiple of `δ`, which the hypothesis excludes. In the
second case `c₁(N)` is a positive integral multiple of the primitive class
`Q`. Apply this argument to the Harder–Narasimhan and Jordan–Hölder factors:
the total class `Q` permits no proper positive-dimensional factor. Thus the
presentation objects are stable for every ample `H`. The boundary objects
`i_*N`, `N∈Pic²(Q)`, are stable for every `H` directly, as rank-one sheaves
on the smooth integral curve. Together with 4.4's boundary description this
identifies the stable functors for different polarizations on this locus.
At effective-root walls the chosen-polarization extension charts are the
subsequent construction in 7.4.

Give a second, explicit compactification check for the trivial-bundle chart
on this root-free locus.
The multiplication map `Sym²W→H⁰(Q,L²)` is surjective with kernel dimension
two. Quadrics whose image lies in the line of the determinant section form
`ℙ²`. Their chosen rulings form a double cover `Z→ℙ²` branched over its
determinant quartic. On the domain where that quartic is smooth, `Z` has
`K²=2`. Its boundary is `P=Pic²(Q)`: label a ruling by the degree-two line
bundle dual to the kernel line of the rank-one matrix on `Q`. The complementary
ruling is labeled `L⊗N⁻¹`.

On this locus construct the stable completion by the two additional blowups at the actual
boundary points

    N₀=A₀,     N₁=L⊗A₁⁻¹  in P.

Use the open parameter domain on which these points are distinct and away from
the branch points: `L≠A₀⊗A₁`, `L≠A₀²`, `L≠A₁²`. Prove the blowup
comparison by extending the universal presentation across the two bundle-jump
loci. The first center is detected by
`H⁰(Q,N⊗A₀⁻¹)≠0`; the second is detected by
`H⁰(Q,N⊗L⁻¹⊗A₁)≠0`. These specify the two centers, rather than choosing
two points merely to reduce `K²` by two.

Pin these tests by computing, for the boundary object `i_*N`,

    ρ₀*(i_*N) = π₀*N,
    ρ_(−1)*(i_*N) = π₁*(N⊗L⁻¹⊗A₁²).

For the second formula use the positive normal twist `τ_*(−⊗𝒩)` with
`𝒩=L²η⁻²`, the finite-map relative dualizing line `A₁²`, and
`τ*N=Nη⁻²` for a degree-two line bundle. The two factors `η⁻²` cancel;
omitting either one changes the second center.

Track the boundary orientation in this model. In the kernel-ruling
identification `P=Pic²(Q)`, the resulting normal class is `A₁⊗A₀⁻¹`.
The negative Abel identification with `Q` in the contravariant comparison
inverts this class and gives `w=η`. Retain the Abel basepoint/degree-two line
used for that identification and its translation in the parameter dictionary.
The marked numerical comparison is fixed from the universal kernel and the
ordered exceptional collection, including its positive effective generators.

**Checks.**

- The eight lifts change `c₁²` from eight to zero while leaving `χ=2`;
  the resulting self-Euler pairing is zero.
- The determinant relation for this class is `zη²=1`, whereas using `χ=1`
  would incorrectly give `zη=1`.
- The determinant compactification has `K²=2`, its two specified blowups have
  `K²=0`, and the two ruling labels give the inverse normal classes `η⁻¹`
  and `η` under the positive and negative Abel identifications.

*Needs:* 2.1–2.3, 3.2–3.3, 4.1–4.4, 5.4, 7.1, relative minimal lifts,
determinants of restriction, and projective-bundle cohomology.
*Sources:* [R25, Proposition 11.15, Proposition 11.20 and its first remark,
Lemma 11.33, Proposition 12.12, Corollary 14.13,
§15.4, Lemmas 18.18–18.21, Theorem 18.22]; [R13, §9].
The final paragraph on printed page 91 of [R13, §9] gives the degree-two
compactification and two-tau-divisor observation, citing unpublished work.
The quadric-net construction, specified centers, and marked relative comparison
are owned here; they are not imported as a theorem from that citation.

### 7.3 Elementary modifications and the specified elliptic time

Fix distinct indices `i,j` and the two quotient fibers required by each
modification. The elementary domain requires the chosen points to have distinct
images under that quotient, the relevant image/kernel lines to have rank one,
and the modified determinant divisor to remain simple. Define the left
modification by upper modification of `V₁` along `image B(uᵢ),image B(uⱼ)`
and tensoring by `𝒪_C₁(−1)`. Define the right modification by lower
modification of `V₀` along `kernel B(uᵢ),kernel B(uⱼ)` and tensoring by
`𝒪_C₀(1)`. Use their universal exact sequences, so that the operations and
their domains are defined before theta coordinates are chosen.

Write them as `Eᵢⱼ` and `Fᵢⱼ`, respectively. With `Dᵢⱼ=uᵢ+uⱼ`, prove

    Eᵢⱼ: (uᵢ,uⱼ,L) ↦ (ι₁uᵢ,ι₁uⱼ,L⊗A₁⊗𝒪_Q(−Dᵢⱼ)),
    Fᵢⱼ: (uᵢ,uⱼ,L) ↦ (ι₀uᵢ,ι₀uⱼ,L⊗A₀⊗𝒪_Q(−Dᵢⱼ)).

The remaining determinant points and the quotient maps are unchanged. The
chosen local modification and reference frames fix the isomorphisms in these
formulas; the determinant equation alone would leave a two-torsion ambiguity.
The time step `Tᵢⱼ=Fᵢⱼ∘Eᵢⱼ` therefore has the complete parameter action

    uᵢ↦τuᵢ,     uⱼ↦τuⱼ,     L↦L⊗η,
    A₀↦A₀,     A₁↦A₁,        η↦η.

In the theta chart use the identities, rather than an ambiguous letter
convention, to identify these operations with [OR]:

    Bᴱ=λ_E⁻¹ R_l B,     ι₁*R_l=R_l,
    Bᶠ=λ_F⁻¹ B R_r,     ι₀*R_r=R_r.

The labels for left and right operations in [OR, §5] are reversed relative
to §4; state the relabeling when using Theorem 5.3. Normalize `R_l,R_r` at a
specified point away from their poles. Construct `λ_E,λ_F` as maps of their
actual line bundles and prove

    Aᴱ = (ι₁*λ_E/λ_E) A,
    Aᶠ = (ι₁*λ_F/λ_F) (τ*R_r)⁻¹ A R_r.

For the composite, put `G=(E*R_r)⁻¹` and
`λ_T=λ_E(E*λ_F)`. Its compatibility is

    Aᵀ G = (ι₁*λ_T/λ_T) (τ*G) A.

Thus the displayed scalar ratio is part of the rank-one correction. Prove
the groupoid and determinant-line coherences for compositions. For `(i,j)=(3,4)`
the projectivization recovers [OR, Theorem 5.3] with this relabeling and its
reference normalization.

Use the operator lattice vector

    vᵢⱼ = f−e_(i+1)−e_(j+1),     vᵢⱼ²=−2,     vᵢⱼ·Q=0.

Identify the composite, by its universal modification sequences, with the
operator twist by `−vᵢⱼ` in the convention in which a twist by `D` changes
`χ(M)` by `c₁(M)·D`. Pin this sign on the induced resolution: a positive
fiber twist tensors its two dual bundles by `𝒪(1)` and changes the coefficient
line to `L⊗A₁⊗A₀⁻¹=Lη⁻¹`; the time step above changes it to `Lη`.
Its boundary restriction data change by `D↦η^(D·vᵢⱼ)`, agreeing with the
point and line-bundle changes above.

For a root class `D`, let `K_D` be its numerical operator class `(0,D,0)`
and use the numerical comparison
`μ(D)=c₁(det R Hom(K_D,M)⁻¹)` from the normalized universal kernel.
The point class gives `μ([pt])=−δ`. Pulling a reference class back through
the twist by `−vᵢⱼ` changes it to `K_D+(D·vᵢⱼ)[pt]`. Thus the phase
pullback sends `μ(D)` to `μ(D)−(D·vᵢⱼ)δ`, fixing the translation sign.
Transport `vᵢⱼ` through this numerical comparison. In the phase marking write it
as `v=H_f−E_(i+1)−E_(j+1)`. With the period orientation of 7.2, prove that
the pullback is the Kac transvection `t_v` of 5.2. In particular,

    T*H_f = H_f+2v+2δ,     T*H_g = H_g+2v+δ,
    T*E_(i+1) = H_f−E_(j+1),
    T*E_(j+1) = H_f−E_(i+1),
    T*E_k = E_k+v+δ       (k≠i+1,j+1).

Prove equality with the geometric transport on the presentation chart and
extend it by 5.4. The additional symmetry generators of 5.3 use their actual
changes of presentation and reference data, including the generator beyond
the translation subgroup exhibited by the elementary two-point operations.

**Checks.**

- `F(E(u))=qu`, but `E(F(u))=u/q`; both `E²` and `F²` fix the point.
  The composite changes the determinant line from `L²` to `L²η²`, exactly
  the class of moving the two points by `τ`.
- The displayed Picard map fixes `δ`, has `v²=−2`, and gives degree `18`
  on `H_f+H_g` after one step; its iterates give `2+16n²`.
- `R_l=I` and a non-invariant scalar `λ_E` still change the full connection
  by `ι₁*λ_E/λ_E`, detecting the scalar information suppressed by
  projectivization. The positive fiber-twist check gives `Lη⁻¹`, fixing
  the opposite sign for the actual time functor on sheaves.

*Needs:* 0.1–0.3, 1.3, 3.2–3.5, 5.1–5.4, 7.1–7.2, elementary
modifications of vector bundles and their relative exact sequences.
*Sources:* [OR, §§4–5, Theorem 5.3]; [R25, §8.2]; [OR15, §6].

### 7.4 Reconstruction domains, coverage, and the Lax comparison

Define the sheaf presentation locus using the fixed functors of 7.1–7.2.
For `M∈M°_H`, push it down successively. Require each pushdown to be a sheaf,
the higher direct image to vanish, and both Hom groups with the exceptional
`𝒪_e(−1)` to vanish at that step. For the resulting `M₀`, require

    R¹ρ₀*M₀ = R¹ρ_(−1)*M₀ = 0,
    ρ₀*M₀ and ρ_(−1)*M₀ are rank-two degree-zero vector bundles.

These are explicit cohomological conditions on already defined objects. The
inverse presentation is supplied by the adjunction map in [R25, (19.1)]:
`V₀=(ρ₀*M₀)∨`, `V₁=(ρ_(−1)*M₀)∨`, and the dual coefficient map is `B`.
Prove that this construction and `B↦M(B)` are inverse equivalences, including
their relative Hom spaces and base-change laws. Stability on the presentation
side means the stated Hilbert-polynomial inequalities for this independently
constructed `M(B)`; it is not defined by the existence of a comparison map.

For comparison with a meromorphic twisted reflection connection, impose in
addition the reconstruction tests of 3.3 for the fixed section object `Σ`.
In the trivial-bundle chart the first test has a finite linear description.
For each length-two fiber `F_p=π₁⁻¹(p)`, the map

    (V₁∨)_p → H⁰(F_p,(π₀*V₀∨⊗L)|_(F_p))

induced by `B†` must be injective. It is automatically injective when the
fiber contains at most one simple determinant zero. When its two distinct
points are `uᵢ,uⱼ`, it says

    image B(uᵢ) ≠ image B(uⱼ) in ℙ((V₁)_p).

Use the scheme-theoretic length-two evaluation at a ramification fiber. Prove
its equivalence with `Hom(ρ₁*k_p,M₀)=0`; the opposite Hom vanishing is supplied
by the acyclic induced resolution. Require these evaluation maps to have
constant maximal rank in families. This is a concrete reconstruction domain,
and it includes the flags, regular bundles, and section object in its output.

Establish coverage as follows. On the root-free parameter locus, meaning
that no real symmetry root has trivial period, prove that a stable sheaf in
`M°_H` has no vertical or root subquotient obstructing the preceding pushdown
and acyclicity tests. It therefore has a rank-two degree-zero presentation,
possibly with nontrivial splitting types. Use the algebraic bundle/Quot charts
for all pairs of splitting types and their deformation families, not just
the `𝒪²,𝒪²` chart, and prove coverage of `M°_H`. This root-free condition is
an explicitly stated pointwise restriction, not one Zariski-open all-orbit
condition. On each parameter family, retain the finite rank and determinant
conditions of the charts actually used and prove their open-domain and
base-change statements.

At effective-root walls construct extension charts from the stable coherent
moduli and relative Ext theory of 3.2 and 4.1. Target 8.4 subsequently
identifies their Riccati restrictions. State which of the preceding bundle charts remain valid by the
same cohomological and evaluation tests. On the compactification use the
universal sheaf charts, including `i_*N` with `N∈Pic²(Q)`. Prove the
transitions by the specified adjunction maps, minimal-lift functors, and
elementary modifications; prove their cocycles and equality with the marked
surface atlas. Verify the parameter, time, and scalar-line dictionary with
[KNY, §5.5] on these charts. The time element used in that comparison is the
one computed in 7.3.

**Checks.** Take `L=π₁*𝒪(2)` and four distinct unramified points
`a,b,c,d` of `C₁`. Let `s_ab,s_cd,s_ac,s_bd` be the pulled-back quadratic
sections and form

    B₁=diag(s_ab,s_cd),     B₂=diag(s_ac,s_bd).

- Both determinants have the same eight simple zeros, and both reflection
  matrices are `I`. Their kernel equality partitions are respectively
  `{a,b}|{c,d}` and `{a,c}|{b,d}`, so no constant left/right frame change
  identifies them.
- At `p=a`, the map in the displayed evaluation test has one-dimensional
  kernel; equivalently
  `dim Hom(ρ₁*k_a,M₀(B₁))=dim Hom(ρ₁*k_a,M₀(B₂))=1`.
  This locates the example at a specific failure of maximality.
- For the bundle-jump check, `H⁰(ℙ¹,𝒪²(−1))=0`, whereas
  `h⁰((𝒪(1)⊕𝒪(−1))(−1))=1`; the second object needs the nontrivial-bundle
  chart even though its determinant and total degree agree with the first.

*Needs:* 3.1–3.5, 4.1–4.4, 5.4, 7.1–7.3, relative bundle/Quot
charts, Birkhoff–Grothendieck splitting, and cohomology/base change.
*Sources:* [R25, (19.1), §19.1, §15.4]; [R13, §2]; [KNY, §5.5].

### Examples

The rank-fifteen theta interpolation chart, the two distinct
degree-zero splitting types, the two-center del Pezzo compactification, the
`T₃₄` translation, and the two inequivalent factorizations of `A=I` are
required examples of the same presentation and moduli interfaces.

### Dependencies

Layers 1–5 supply local types, operator categories, relative
minimal lifts, stable moduli, numerical comparison, and phase transport.
The scalar elliptic theory is the shared supplier in 3.5. The fieldwise
moduli theorem in 4.4 and the coordinate system of [OR] are separate inputs;
this layer owns their marked relative integration and the reconstruction
domains just specified.

## Layer 8: Dynamical and tau consequences

### 8.1 Degree growth and regular continuation

For every class `H∈L`, `v∈δ⊥` and integer `n`, use the native
transvection formula and the geometric marking to prove

    (t_(nv)H)·H = H² − (n²v²/2)(H·δ)².

For a nonzero class of `v` in the negative-definite lattice `δ⊥/ℤδ`,
one has `v²<0`. For an ample `H`, prove quadratic degree growth and
`lim_n log(deg Tⁿ)/n=0` using the degree comparison for the resolved
birational maps. The lattice identity also applies to nef `H`; a degree
conclusion using such an `H` additionally requires `H·δ>0` and the proved
comparison with the chosen rational presentation.

- For a time map whose power `m` is a translation, write `n=am+b` with
  `0≤b<m`, calculate the finitely many remainder actions and derive the
  corresponding degree estimates. Apply this to the explicit `m=2` in 6.3.
- Prove regular continuation of the phase solutions for the full-phase
  transports of Layers 6–7. Compute the exceptional-curve images from the
  resolved maps, including `H_f−E₄→E₃` in the marking of 6.3, and then
  their scalar-chart confinement patterns on the noncollision domains.
- Under specialization, calculate the Picard action before applying the
  degree theorem. An autonomous translation on an elliptic surface may still
  have quadratic growth. Continuation on the phase does not require return
  to a single affine observation chart.

**Checks.**

- For `v=E₁−E₂` and `H=H_f+H_g`, the values are `v²=−2`, `H²=2`,
  `H·δ=4`; hence the degree pairing is `2+16n²`, with first values
  `2,18,66`. Omitting the half in the transvection gives a different sequence.
- For `v=0` the same pairing is the constant `H²`; a nonzero translation
  hypothesis is needed for the assertion of quadratic, rather than bounded,
  growth. For Jimbo–Sakai the actual sequence is instead `8n²+2` from 6.3.
- The identity `T*E₃=H_f−E₄` sends the strict fiber through the fourth
  source center to the third target exceptional curve. Its generic phase
  point remains defined even when a displayed scalar denominator vanishes;
  the total-transform class `H_f` would give the wrong image.

*Needs:* 0.2, 2.1, 5.2, 6.3, 7.3–7.4; native real limits and logarithms,
surface intersection and the proved geometric Picard action.
*Sources:* [Sakai]; [KNY, §§3–5].

### 8.2 Determinants of relative cohomology

For the proper perfect pushforwards of 4.2, construct determinant lines by
descent from the supplied determinant functor. For an equal-rank two-term
complex in degrees `0,1`, define

    C=[E⁰ →^d E¹],     λ(C)=det(E¹)⊗det(E⁰)⁻¹,     τ(C)=det(d).

- Prove invariance under quasi-isomorphism, base change, addition of an
  acyclic summand, and the determinant laws for exact triangles. For
  modification sequences retain the natural comparison maps and prove their
  associativity and unit laws.
- Identify the zero scheme of `τ(C)` with the determinant degeneracy scheme.
  If the complex is acyclic on a dense open of an integral base, prove that
  the section is a non-zero-divisor and its zero scheme is Cartier. In a
  general family assume and verify the relative non-zero-divisor and
  base-flatness criteria for that zero scheme; dense generic acyclicity alone
  does not imply them.
- For a general perfect complex give the acyclic trivialization as a rational
  section on the acyclic locus. A regular effective section requires the
  two-term amplitude and extension theorem above. Compute the effect of
  tensoring a universal object by a base line and of changing its reference
  frames. The intrinsic output is the line with its section; a scalar tau
  function additionally includes a trivialization.

**Checks.**

- For `[𝒪 →^t 𝒪]` over `k[t]`, `λ=𝒪`, `τ=t`, and the zero scheme is
  `Spec k[t]/(t)`, with multiplicity one.
- An identity differential has determinant `1` and empty zero scheme.
  Adding `[𝒪 →^1 𝒪]` to the preceding complex still gives section `t`,
  testing independence of an acyclic presentation summand.
- Over `R=k[t,ε]/(ε²,tε)`, multiplication by `t` is invertible on the
  dense open `D(t)`, but `tε=0` with `ε≠0`. Its determinant zero scheme is
  not Cartier. Euler characteristic zero and generic acyclicity do not fix it.

*Needs:* 4.2–4.4; PadicMeasuresIwasawaAlgebras 5.1 for the determinant
functor; AlgebraicVectorBundles L0C for gluing; the proper perfect pushforward
and base-change results established in 3.2 and 4.2.

### 8.3 Sakai tau sections and the moduli comparison

Construct line bundles and canonical sections for the relative effective
Cartier divisors in the marked surface families. For the exceptional classes
appearing in the tau formulas, prove uniqueness of the divisor on the
specified exceptional-curve locus. Where `h⁰>1`, a chosen linear-system
member is additional input. Construct the Picard-torus torsor of compatible
frames and the scalar tau variables it defines.

- Prove the Weyl transformation laws, retaining frame multipliers and their
  cocycle. Derive the elliptic, multiplicative and additive bilinear
  identities of [KNY, §§5.3, 5.7] from the divisor-section relations and the
  theta addition identity in 7.1.
- For an exceptional divisor `E` and the universal-kernel equivalence
  `F:Dᵇ(X)≅Dᵇ(𝒮)` of 4.4, construct
  `P₋=F(𝒪_X(−E))`, `P₀=F(𝒪_X)` and the map `P₋→P₀`.
  Calculate these objects using the operator presentation and its finite
  resolution in each benchmark, including the scalar normalization of 4.2.
- With universal point-image family `M` and projection `π`, prove the
  relative Hom complexes below are line bundles in degree zero and identify
  the induced complex and its map:

      C_E=[Rπ_*RHom(P₀,M) → Rπ_*RHom(P₋,M)]
         ≃ [𝒪_X → 𝒪_X(E)].

  The right-hand map is the canonical section of `E`. Therefore
  `λ(C_E)=𝒪_X(E)` and `τ(C_E)` has divisor `E` with the convention of 8.2.
  Prove this for the marked exceptional generators and transport it through
  the verified modifications. The comparison retains its reference data;
  it does not define a simultaneous scalar normalization or categorical
  Weyl coherence merely from the lattice action.

**Checks.**

- At a point `x∈X`, `Hom(𝒪_X,k(x))=k` and
  `Hom(𝒪_X(−E),k(x))=𝒪_X(E)|x`. The fiber map is multiplication by the
  value of the section of `E`, fixing the direction of the two-term complex.
- In a smooth chart with `E={u=0}`, this map is `[𝒪 →^u 𝒪]` and vanishes
  to order one along `E`; at `u=1` it is invertible. The Picard class alone
  would not determine that divisor or its section.
- Replacing `M` by `M⊗π*N` tensors both relative Hom lines by the same
  base line `N`. Their determinant quotient has exponent `1−1=0`, so
  `λ(C_E)` and its section descend independently of that scalar-gerbe choice.

*Needs:* 2.1–2.3, 3.2–3.3, 4.2–4.4, 5.1–5.4, 6.3, 7.1–7.4, 8.2.
*Sources:* [KNY, §§5.3, 5.7]; [R25, Lemma 18.18, Theorem 18.22,
Corollary 18.34] for the universal-kernel and determinant-class inputs.
The reference-object calculation and section comparison are owned here.

### 8.4 Effective-root walls and Riccati reductions

In the elliptic marking take `α_e=H_f−E₁−E₂`, with the first two centers
the two distinct transverse intersections of one ruling fiber with the smooth
boundary and no other center on that fiber. In the Jimbo–Sakai marking take
`α_q=H_f+H_g−E₁−E₃−E₅−E₇`. Construct the loci where their strict
transforms are effective `−2` curves disjoint from the boundary, and prove
their period equations. Transport these loci by the constructed Weyl maps
on their actual domains.

For `α_q`, the wall is `k_t=k₀k₁k_∞`, and the curve is

    fg−f/k_∞−k₁g+k₀k₁t=0.

Require distinct source and target blowup centers and
`t≠(k₀k_∞)⁻¹` for irreducibility of this source curve. This wall is outside
the non-splitting coefficient quotient in 6.3. Construct its stable extension
charts and calculate the contraction of nonzero triangular extensions by
the affine coefficient invariant quotient. In this marking
`H_f−E₁−E₂` is a boundary component, not the displayed symmetry root.

- For each verified transport preserving these wall families, restrict it to
  the rational curves and construct the projective-linear map and its
  rank-two lift. In the Jimbo–Sakai case prove

      g=(f−k_t t)/[k_∞(f−k₁)],
      ḡ=qk_∞(f−k_t⁻¹t)/(f−k₁⁻¹),
      f̄=k₁(ḡ−k₀qt)/(ḡ−k_∞⁻¹).

  Including projective values, the lift for `f↦f̄` is

      [ qk₁(k_∞−k₀t)      qt(k₀−k₀⁻¹)             ]
      [ qk_∞−k_∞⁻¹        (k_∞⁻¹−qt k₀⁻¹)/k₁      ],

  with determinant `q(1−qt k₀k_∞)(1−t/(k₀k_∞))`. Require both factors
  to be nonzero to obtain an element of `PGL₂`; this is distinct from the
  source curve's irreducibility condition.
- Prove preservation of the target curve at `qt`, identify the reducible
  connection/extension objects on the equation charts, and intertwine their
  elementary modifications with this Riccati map. Compute any curve points
  absent from a chosen linear chart. This target constructs these geometric
  reductions and does not classify all algebraic or special-function solutions.

**Checks.**

- The Jimbo–Sakai class has `α_q²=2−4=−2` and `α_q·δ=4−4=0`.
  The coefficient determinant of its `(1,1)` equation is
  `k₁(k₀t−k_∞⁻¹)`; the abstract root equalities alone do not establish
  irreducibility.
- With `q=2,k₀=2,k₁=3,k_∞=5,t=1`, the lift is
  `[[18,3],[49/5,−4/15]]` and its determinant is `−171/5`, agreeing with
  the factored expression. Substitution of the three displayed formulas
  makes both the `qPVI` recurrence and the target curve equation vanish.
- At `t=1/(qk₀k_∞)` the lift determinant is zero, although for `q≠1`
  the source `(1,1)` curve can remain irreducible. The formula cannot be
  called a projective-linear isomorphism at that parameter.

*Needs:* 1.3, 2.1–2.3, 4.1, 5.1–5.4, 6.3, 7.4.
*Sources:* [KNY, §6] for the root-wall reduction; the stated Jimbo–Sakai
lift is computed from 6.2–6.3 with the displayed marking.

### Examples

The degree sequence `8n²+2`, the local determinant section `t`, and the
explicit rank-two Riccati matrix test three different consequences of the
same marked comparison. In particular a regular phase map, a Cartier tau
divisor, and a nonsingular projective-linear reduction have different
hypotheses; none follows from a lattice label alone.

### Dependencies

The degree and wall results consume the constructed transports from Layers
5–7. The determinant section uses the perfect-cohomology work in 4.2 before
8.3 compares it to surface divisors. Layer 9 uses these determinant and
transport comparisons during specialization.

## Layer 9: Degeneration and differential comparison

### 9.1 Relative degeneration data

For the families specified in 9.2–9.3, construct the relative bimodules,
ordered centers, local-type strata, polarizations and modification maps over
the same parameter base. Prove flatness and base change separately for the
operator category, stable moduli, marked phase pair and transports. Construct
specialization of numerical classes, boundary periods and determinant lines;
retain the multiplicities of the relative Cartier boundary.

- On a locally Noetherian base, use the split operator data of 3.2 and
  relative-position strata of 1.2. For each finite word in modifications,
  intersect its finitely many source and inverse-image domains as in 0.1.
  Prove extension and compatibility on this relative domain. Conditions on
  an entire infinite orbit are not silently promoted to a Zariski-open base.
- For the local difference-to-differential construction take
  `R=k[[ε]]`, `A=R[x,x⁻¹]`, `σ(x)=(1+ε)x`, and
  `Δ(f)=[σ(f)−f]/ε`. Prove that `Δ` is a `σ`-derivation and construct
  the Ore extension with left `A`-basis `{Dⁿ:n≥0}` and relation

      Df=σ(f)D+Δ(f).

  Prove it is `R`-flat, and its special fiber has relation
  `Df=fD+x df/dx`. The element `T=1+εD` is normal; localize at its
  powers to compare with invertible difference operators. After inverting
  `ε`, prove that `D=(T−1)/ε` identifies this localization with the Laurent
  skew algebra. Prove the corresponding module equivalence for modules
  with `T≡I mod ε` and an `R`-flat retained lattice.
- Construct the projective operator compactifications and polar local types
  of 9.3 from this lattice and compare their restriction with the local Ore
  model. Prove the flatness of their moduli using 4.1 and the explicit
  presentations. The local basis theorem by itself does not prove those
  projective or moduli statements.

**Checks.**

- One has `Δ(x)=x`, `Δ(x²)=(2+ε)x²` and
  `Δ(x⁻¹)=−x⁻¹/(1+ε)`. Their specializations are `x,2x²,−x⁻¹`,
  including the inverse-coordinate sign.
- At `ε=0` the relation gives `Dx−xD=x`. The naive limit of the graph
  sum is `𝒪_Δ⊕𝒪_Δ`, with commuting coefficient arrows, so its
  commutator is `0`. It does not give this differential operator category.
- Directly, `(1+εD)x=(1+ε)x(1+εD)`. Without inverting `1+εD`, the
  generic Ore algebra contains the polynomial generator `T` but not its
  inverse; it therefore does not yet model invertible difference transport.

*Needs:* 1.1–1.3, 2.1–2.3, 3.1–3.5, 4.1–4.4, 8.2;
native polynomial/power-series and localization APIs. The Ore normal-form
and localization results are constructed here; the geometric flatness inputs
are SchemeAndStackFoundations 2.2, 2.6, 4.14 and StableReduction Layer 4.

### 9.2 Elliptic to multiplicative and additive `E₈`

Over a characteristic-zero trait use the projective cubic families

    y²z=x³+x²z+εz³,       y²z=x³+εz³,

with section `[0:1:0]`. Their special fibers are respectively nodal and
cuspidal. Construct split marked anticanonical blowup families by choosing
the ordered centers as distinct smooth sections with the divisor relation
of 7.1, and retain the two degree-two maps and their coefficient line bundle.
Work on the relative configuration locus where those maps stay finite flat
of degree two and the presentation's image/cokernel conditions in 3.3 hold.
Construct that locus from the actual finite presentation maps.

- Prove the generalized-Picard specialization to `𝔾_m` and `𝔾_a` using
  normalization and conductor exact sequences. For a fixed concrete time
  take `v=E₁−E₂` and `t_v=s_(δ+v)s_v`. Construct this finite reflection
  word by 5.1–5.3, with its source domains and modified operator data, and
  prove that its period action specializes to the multiplicative and additive
  step laws. The construction applies to other specified words by the same
  finite-word theorem, without identifying them solely by a Dynkin label.
- Prove the scalar theta limits and the coordinate formulas for the
  multiplicative and additive `E₈^(1)` equations in [KNY, §5.6]. Compare
  the specialization of the constructed word with those formulas, retaining
  changes of frames and parameter coordinates. Under
  `f=exp(εu),g=exp(εv)`, the normalized two-form is
  `ε⁻² dlog(f)∧dlog(g)`, with limit `du∧dv`.
- Carry the twisted bimodule and maximal-lattice presentation through this
  family, prove the sheaf/phase comparisons and determinant-line
  specializations, and identify the target surface types `A₀^(1)*` and
  `A₀^(1)**`. Each boundary is irreducible. The four-component `A₃^(1)`
  Jimbo–Sakai family requires a different change of centers and local types.

**Checks.**

- The two discriminants are `−16ε(4+27ε)` and `−432ε²`; both generic
  fibers are smooth. At `ε=0`, the first has distinct tangent lines
  `y=x` and `y=−x` at its singularity, while `y²=x³` has one cusp.
- At the node, gluing scalars `2` and `3` compose to `6`. At the cusp,
  the conductor calculation gives
  `(1+2u)(1+3u)≡1+5u mod u²`. These are respectively multiplication
  in `𝔾_m` and addition in `𝔾_a`.
- With `θ₀(x)=1−x`, the three terms of the 7.1 addition identity at
  `(a,b,c,z)=(2,3,5,7)` are `−364,432,−68`. Its additive leading
  identity has terms `−720,840,−120`. Both sums are zero, checking the
  normalization before the operator and moduli specializations are used.

*Needs:* 2.1–2.4, 3.5, 5.1–5.3, 7.1–7.4, 9.1;
AlgebraicCurves Layers 9 and 12 and the stated Picard suppliers.
*Sources:* [KNY, §5.6]; [R25, §13.1] for split relative operator data.
The simultaneous specialization of the marked comparison is proved here.

### 9.3 `qPVI` to `PVI`

Let `θ₀,θ₁,θ_t,θ_∞` now denote differential exponents, distinct from the
Jimbo–Sakai parameters `θ₁,θ₂` in 6.1. Require
`θ₀θ₁θ_t≠0`, `θ_∞≠1`, `t≠0,1`, and put

    Θ_j(q)=1+(q−1)θ_j/2,
    (a₁,a₂,a₃,a₄)=(Θ_t,Θ_t⁻¹,Θ₁,Θ₁⁻¹),
    (θ₁^JS,θ₂^JS)=(Θ₀,Θ₀⁻¹),   (κ₁,κ₂)=(Θ_∞⁻¹,Θ_∞).

Retain `q` and all `Θ_j` as units. Define the modified coordinates by

    Z=[(y−tΘ_t)(y−t/Θ_t)/(q(y−1)(y−t)z)−1]/[(q−1)y],
    u=y,   v=y(y−1)(y−t)Z
     =[(y−tΘ_t)(y−t/Θ_t)−q(y−1)(y−t)z]/[q(q−1)z].

Construct the `F₂` family using charts `(u,v)`, `(u,1/v)`,
`(u₂,v₂)=(u⁻¹,v/u²)` and `(u⁻¹,u²/v)`. Blow up the following
eight sections on the open base where they are pairwise disjoint:

| Center | Chart | Coordinates |
|---|---|---|
| `β₀⁻` | `(u,v)` | `(0,−tθ₀/(2Θ₀))` |
| `β₀⁺` | `(u,v)` | `(0,tθ₀/2)` |
| `β₁⁻` | `(u,v)` | `(Θ₁⁻¹,−θ₁(t−Θ₁⁻¹)/(2Θ₁))` |
| `β₁⁺` | `(u,v)` | `(Θ₁,θ₁(t−Θ₁)/2)` |
| `β_t⁻` | `(u,v)` | `(tΘ_t,−tθ_t(tΘ_t−1)/2)` |
| `β_t⁺` | `(u,v)` | `(t/Θ_t,t(t−Θ_t)θ_t/(2Θ_t²))` |
| `β_∞⁻` | `(u₂,v₂)` | `(0,−θ_∞/(2Θ_∞))` |
| `β_∞⁺` | `(u₂,v₂)` | `(0,(θ_∞/2−1)/q)` |

- Prove the generic-fiber comparison with 6.3 and the special-fiber comparison
  with the additive `D₄^(1)` Okamoto pair. The moving boundary curve
  `(u−1)(u−t)=(1−q)v` specializes, in the projective `F₂` model, to
  `H+D₁+D_t`. With the other components the full Cartier boundary is
  `2H+D₀+D₁+D_t+D_∞`, where `H` is the section at infinity and the
  `D_j` are the strict transforms of the indicated fibers. Retain the
  multiplicity two.
- For the linear limit, divide the polynomial matrix by `(x−1)(x−t)`
  and use the frame normalization `λ=κ₂w/(q−1)` of [DH, §1.3]. The
  polynomial matrix tends to `(x−1)(x−t)I`; the normalized rational
  matrix has `A_ε=I+εa+O(ε²)` for `ε=q−1`.
  Construct its lattice in 9.1 and prove that

      [Y((1+ε)x)−Y(x)]/ε → x∂_xY=a(x)Y.

  Compute the residues at `0,1,t,∞`, their exponent and determinant
  dictionary, and compare with the independently constructed differential
  connection moduli. With normalized time matrix
  `R_ε=I+εb+O(ε²)`, prove that compatibility at order `ε²` is

      t∂_t a−x∂_x b+[a,b]=0.

  Identify the induced vector field with the continuous roadmap's `PVI`
  isomonodromic connection. On the displayed phase chart prove the exact
  relative two-form identity

      −(q−1)⁻¹ dlog(y)∧dlog(z)
        = dy∧dZ/[1+(q−1)yZ] → dy∧dZ.

- Prove each finite-step comparison on the finite source/target configuration
  domain of the resolved maps. The geometric family also includes parameters
  excluded from the simple-eigenvalue coefficient chart; use stable sheaf
  and surface charts there. The infinite orbit exclusion in [DH, Proposition
  4.4] is not one Zariski-open parameter condition.

The differential target is [PainleveEquationsAndFunctions][continuous]:
1.1–1.3 supply meromorphic connections and their moduli, 3.1–3.12 the
rank-two phase and isomonodromic connection, 5.1–5.2 the Okamoto
compactification, and 7.1–7.2 the scalar `PVI` comparison. The comparison
is a theorem about those independently defined objects.

**Checks.**

- At `q=1`, the differences in the four pairs of centers are
  `tθ₀`, `(t−1)θ₁`, `t(t−1)θ_t`, `θ_∞−1`. Thus the displayed
  hypotheses make all eight limiting centers distinct; they also determine
  a neighborhood of that fiber with disjoint sections.
- For `θ_∞=0`, the two infinity coordinates are `0,−1` at `q=1`
  and remain distinct nearby, whereas `Θ_∞²=1` violates 6.1's leading
  eigenvalue condition. The phase-family theorem is broader than that chart.
- The central boundary component has intersection
  `2H²+4=2(−2)+4=0`; replacing its multiplicity by one gives `2`,
  not zero. In the compatibility calculation the time derivative is
  `t∂_t`, so omitting the factor `t` gives the wrong vector field for
  logarithmic time.

*Needs:* 6.1–6.3, 9.1; the continuous targets listed above;
ComplexComparisonPartII C−1.1–C0.5, C1.9, C2.2 for analytification and
coherent comparison. The finite-step geometric statement precedes 9.4.
*Source:* [DH, §1.3, §§3.3, 4.2–4.3, (64)–(67), Lemma 4.3 and
Proposition 4.4].

### 9.4 Convergence of discrete phase trajectories

Prove a finite-chart convergence theorem on the real mesh
`q=exp(h)`, `h>0`, `s_n=nh∈[0,S]`, `t_n=t₀exp(s_n)`, using the
common phase charts of 9.3. Coordinates may be complex. If `V_t` is the
vector field for the ordinary time coordinate, put `V(s,x)=tV_t(t,x)`.
In a common compact tube around the limiting trajectory assume

    ‖V‖≤M,   ‖D_xV‖≤L,   ‖∂_sV‖≤B,
    ‖T_h(s,x)−x−hV(s,x)‖≤Ch²,   ‖D_xT_h(s,x)‖≤1+Lh,

with constants independent of `s,x,h` in that tube, a positive distance to
its boundary and to the chart's excluded divisors, and fixed bounds on chart
transition derivatives. Use convex coordinate neighborhoods, or retain the
equivalent Lipschitz bounds on each neighborhood.

- The exact ODE step has defect at most `(B+LM)h²/2`. Prove the recurrence
  for the error and, for `nh≤S`, the bound

      error_n ≤ exp(LS) error₀
        + [C+(B+LM)/2] h [exp(LS)−1]/L,

  with the last quotient interpreted as `S` when `L=0`. Prove the no-exit
  assertion whenever this bound is smaller than the fixed tube margin.
- For a finite chain of charts retain the product of their transition
  Lipschitz bounds and the maximum of their local constants. Prove uniform
  convergence on the mesh for convergent initial data, the same limit for
  piecewise linear interpolants in the chosen charts, and error `O(h)` if the initial error is
  `O(h)`. These are estimates on phase trajectories, not just formal
  coefficient limits.
- Verify the bounds for the resolved maps of 9.3 on each compact trajectory
  tube avoiding `t=0,1,∞` and the phase boundary. Obtain the constants from
  the regular chart formulas and holomorphic dependence, including charts
  at apparent poles of scalar observations. The finite-chart local-flow
  theorem from the continuous roadmap supplies the reference solution.

**Checks.**

- For `V=1` and `T_h(x)=x+h`, the mesh equals the exact solution and the
  discretization error is zero.
- For `V=x`, `T_h(x)=(1+h)x`, initial value `1` and `nh=S`, one has
  `exp(S)−(1+h)ⁿ=(S exp(S)/2)h+O(h²)`. The global order is exactly
  the asserted `O(h)` in this example.
- For `T_h(x)=x+h+h^(3/2)` and limiting `V=1`, the rescaled defect
  tends to zero, but the error at `nh=S` is `S√h`. Mere vanishing of
  the rescaled defect does not imply the stated `O(h)` conclusion.

*Needs:* 0.2–0.3, 9.3; PainleveEquationsAndFunctions 0.2–0.3 and 0.9
for local flows and finite-chart continuation; native norms, derivatives,
finite sums, exponential estimates and compactness. The discrete Grönwall
and no-exit argument is proved here on these quantitative hypotheses.

### Examples

The nodal and cuspidal cubics test the two generalized-Jacobian laws. The
eight moving `F₂` centers test the different `qPVI→PVI` degeneration,
including its nonreduced boundary. The Euler examples in 9.4 distinguish a
formal first-order limit from a uniform trajectory estimate.

### Dependencies

The local flat operator construction precedes the geometric specializations.
Target 9.2 consumes the elliptic comparison; 9.3 consumes the independent
continuous roadmap as well as the Jimbo–Sakai phase. Only 9.4 uses analytic
flow estimates. No trajectory convergence is inferred from flatness alone.

## Downstream consumers

The geometric classification exports marked surface families, their period maps and
resolved Cremona actions to work on discrete integrable systems. The operator theory
exports coherent-lattice moduli, reconstruction functors, determinant lines and
modification correspondences to other difference-equation moduli problems. These
constructions retain rank, local type and stability hypotheses at their interfaces.

The Jimbo–Sakai and elliptic comparisons export phase points and solutions independently
of an affine matrix chart. The tau and Riccati developments export line bundles with
sections and actual rational invariant curves. The differential comparison consumes
the independently constructed continuous Painlevé phase; it adds no reverse dependency
to its connection, moduli or local-flow foundations.

## References

- **[Stacks]** The Stacks Project, [Tag 01KM](https://stacks.math.columbia.edu/tag/01KM),
  the closed equalizer for morphisms to a separated target. Target 0.3 applies
  the native equality theorem after proving schematic density of its charts.
- **[HM]** M. Hazewinkel, C. F. Martin, *A short elementary proof of
  Grothendieck's theorem on algebraic vectorbundles over the projective line*,
  Journal of Pure and Applied Algebra **25** (1982), 207–211.
  [Institutional manuscript](https://ir.cwi.nl/pub/10153/10153D.pdf).
  Proposition 3.1 and Theorem 4.1 give splitting and uniqueness over any field;
  these are the statements used in 1.4.
- **[Sakai]** H. Sakai, *Rational Surfaces Associated with Affine Root Systems
  and Geometry of the Painlevé Equations*, Communications in Mathematical Physics
  **220** (2001), 165–229.
  [DOI](https://doi.org/10.1007/s002200100446).
  The classified anticanonical-pair hypotheses and the geometric Weyl realization
  are used in 2.2–2.4 and 5.1–5.2.
- **[KNY]** K. Kajiwara, M. Noumi, Y. Yamada, *Geometric Aspects of Painlevé
  Equations*, Journal of Physics A **50** (2017), 073001.
  [Author manuscript, v8](https://arxiv.org/abs/1509.08186v8).
  §§3, 5–6 and 8 give the lattice, elliptic equation, tau, degeneration,
  Riccati, and configuration comparisons specified here.
- **[DT]** A. Dzhamay, T. Takenawa, *On Some Applications of Sakai's Geometric
  Theory of Discrete Painlevé Equations*, SIGMA **14** (2018), 075.
  [Article](https://doi.org/10.3842/SIGMA.2018.075).
  Introduction, Figures 1–2, and Remark 1.1 distinguish surface type, time
  element, and the corrected characteristic-zero degeneration scheme.
- **[JS]** M. Jimbo, H. Sakai, *A `q`-analog of the sixth Painlevé equation*,
  Letters in Mathematical Physics **38** (1996), 145–154.
  [Author manuscript](https://arxiv.org/abs/chao-dyn/9507010).
  The polynomial problem and its time compatibility are the normalization
  source for 6.1–6.2.
- **[VdB]** M. Van den Bergh, *Non-commutative `ℙ¹`-bundles over
  commutative schemes*, Transactions of the AMS **364** (2012), 6279–6313.
  [Author manuscript](https://arxiv.org/abs/math/0102005).
  Use the adjoint-bimodule `ℤ`-algebra construction and its hypotheses.
- **[R13]** E. M. Rains, *Generalized Hitchin systems on rational surfaces*.
  [Author manuscript](https://arxiv.org/abs/1307.4033).
  Proposition 2.2 supplies the maximal symmetric factorization. Section 9,
  printed p. 91, identifies the degree-two del Pezzo chart and two missing
  tau divisors; the explicit quadric-net and two-center constructions are 7.2. Relative reconstruction hypotheses
  remain explicit targets here.
- **[OR15]** A. Okounkov, E. Rains, *Noncommutative geometry and Painlevé
  equations*, Algebra & Number Theory **9** (2015), 1363–1400.
  [Article PDF](https://msp.org/ant/2015/9-6/ant-v9-n6-p03-p.pdf).
  §6 supplies the geometric moduli and Hecke-translation comparison, including
  the additional operation beyond the `A₈` translations.
- **[R16]** E. M. Rains, *The noncommutative geometry of elliptic difference
  equations*. [Author manuscript](https://arxiv.org/abs/1607.08876).
  Use its sheaf-moduli construction and Theorem 11.3's Poisson statement
  with their assumptions.
- **[OR]** C. M. Ormerod, E. M. Rains, *An elliptic Garnier system*.
  [Author manuscript, v2](https://arxiv.org/abs/1607.07831v2).
  §§2–4 and §5, Theorem 5.3, supply the reflection presentation, elementary
  modifications and the `m=1` elliptic Painlevé comparison. Scalar factors
  suppressed in its projective/Galois formulation are retained here.
- **[R25]** E. M. Rains, *The (noncommutative) geometry of difference equations*.
  [Author manuscript, v1](https://arxiv.org/abs/2504.16187v1).
  The exact contracts are §9.2 (Theorem 9.13 and Proposition 9.14),
  §§9–13 (operator surfaces and derived equivalences),
  §18 (moduli, especially Lemmas 18.18–18.21 and Theorem 18.22),
  and §§19.1, 19.6 (equation and Painlevé comparisons).
  The theorem on stable moduli is not by itself a marked relative
  Jimbo–Sakai or elliptic Lax comparison.
- **[ORS]** Y. Ohyama, J.-P. Ramis, J. Sauloy, *The space of monodromy data
  for the Jimbo–Sakai family of `q`-difference equations*,
  Annales de la Faculté des Sciences de Toulouse **29** (2020), 1119–1250.
  [Article PDF](https://www.numdam.org/item/10.5802/afst.1659.pdf).
  Use the analytic connection-data and quotient construction.
- **[JR25]** N. Joshi, P. Roffelsen, *On the Crystal Limit of the
  `q`-Difference Sixth Painlevé Equation*, Journal of Nonlinear Science
  **35** (2025), article 31.
  [Article](https://doi.org/10.1007/s00332-024-10124-5).
  Only the stated nonzero-`q` results are used: (2.1)–(2.2), Definitions 2.1–2.2,
  Lemma 2.5, Remark 2.6 and Proposition 3.3. The crystal-limit theorem is not
  substituted for a `q→1` theorem.
- **[DH]** T. Dreyfus, V. Heu, *Degeneration from difference to differential
  Okamoto spaces for the sixth Painlevé equation*.
  [Author manuscript](https://arxiv.org/abs/2005.12805).
  §§3–4 specify the modified coordinates, blowup family, and differential limit.
  Trajectory convergence in 9.4 is a separately proved consequence with its
  own uniform estimates.

[continuous]: https://github.com/yuma-mizuno/TauCetiRoadmap/blob/f5b41b49f8770b6c678b8bca87524259e54b6c74/TauCetiRoadmap/PainleveEquationsAndFunctions/README.md
[complex-comparison]: https://github.com/TauCetiProject/TauCetiRoadmap/blob/roadmap/complex-comparison-part-ii/TauCetiRoadmap/ComplexComparisonPartII/README.md
