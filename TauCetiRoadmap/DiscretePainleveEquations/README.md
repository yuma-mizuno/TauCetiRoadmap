# Discrete Painlevé equations

Construct discrete Painlevé dynamics in two independently defined settings: moduli of
linear difference objects with specified local lattices and modification correspondences,
and marked rational anticanonical surfaces with a specified Cremona time element. Prove
comparisons between these constructions, including their parameter spaces, domains,
symplectic forms, and time steps. Matrix equations are presentations of these objects.

The complete comparison examples are Jimbo–Sakai $`qP_{\mathrm{VI}}`$ and the elliptic
Painlevé equation. Their common linear infrastructure is the geometry of sheaf
bimodules of birank $`(2,2)`$ and the associated noncommutative ruled surfaces.
An ordinary difference connection is one important presentation; a stable sheaf
moduli space supplies a completion when one presentation does not cover the phase space.

The geometric development includes Sakai's finite classification of surface types and
the realization of their symmetry groups. A surface type does not specify a unique
discrete equation: the translation and the parameter action are additional data.

## Structure and scope

There are 40 targets in ten layers. The README is the specification;
[Suggested.lean](Suggested.lean) prototypes selected interfaces that can be stated
against existing libraries.

| Layer | Development | Targets |
|---:|---|---|
| [0](#layer-0) | Relative discrete dynamics, domains, and solutions | 0.1–0.3 |
| [1](#layer-1) | Difference connections, local lattices, and modifications | 1.1–1.4 |
| [2](#layer-2) | Rational anticanonical surfaces and Sakai's classification | 2.1–2.4 |
| [3](#layer-3) | Sheaf bimodules, operator surfaces, and equation presentations | 3.1–3.5 |
| [4](#layer-4) | Stable moduli, scalar descent, and Poisson geometry | 4.1–4.4 |
| [5](#layer-5) | Cremona actions and comparison with modifications | 5.1–5.4 |
| [6](#layer-6) | Jimbo–Sakai $`qP_{\mathrm{VI}}`$ | 6.1–6.4 |
| [7](#layer-7) | Elliptic Painlevé | 7.1–7.4 |
| [8](#layer-8) | Degree growth, tau sections, and Riccati reductions | 8.1–8.4 |
| [9](#layer-9) | Algebraic degenerations and the differential limit | 9.1–9.4 |

Every numbered target is required. General constructions include their objects,
morphisms, identity and composition laws, pullbacks, and the comparisons specified below.
An external roadmap supplies only its cited results with their hypotheses. Literature
citations identify proof sources; they do not assert that the corresponding Lean API exists.

The combined comparison theorems are owned construction and proof targets.
In particular, the relative marked enhancement of 4.4, the presentation-atlas
coverage and scalar dictionaries of 6.3/7.4, the operator-side tau calculation
of 8.3, and the relative operator/moduli specialization of 9.1 are not imported
as verbatim consequences of one cited theorem. Their intermediate constructions
and checks are specified in those targets. The fiberwise stable-moduli theorem,
the displayed Lax comparison, and the geometric differential-limit theorem
retain the separate scopes stated in the references.

The two complete linear examples have rank two. The reusable connection and modification
theory admits arbitrary finite rank on a smooth projective curve; the noncommutative
ruled-surface theory has birank $`(2,2)`$. Surface classification is not a claim that
every surface type has a rank-two connection realization or a nonzero translation.
The analytic comparison is the regular-singular $`qP_{\mathrm{VI}}`$ Riemann–Hilbert
problem. A general elliptic Riemann–Hilbert equivalence, all higher-rank Garnier systems,
a completeness classification of special solutions, and a uniform analytic confluence
theorem for the entire Sakai diagram are outside the specification.

### The objects that comparisons must distinguish

| Object | What varies | Meaning of a point or arrow |
|---|---|---|
| Parameter space $`B`$ | Curve, correspondence, local type, determinant, markings | A linear problem, not its solution |
| Connection stack $`\mathfrak C_\lambda`$ | Bundles and difference maps with that type | A linear object with its regular isomorphisms |
| Stable operator-sheaf stack $`\mathfrak M_\lambda`$ | Coherent sheaves on the specified operator surface | An object of a fixed numerical class and stability condition |
| Coarse phase $`M_\lambda`$ | Isomorphism classes after scalar descent | A nonlinear initial condition |
| Sakai pair $`(X_\lambda,D_\lambda)`$ | A marked compact rational surface and boundary | Its open phase is $`U_\lambda=X_\lambda\setminus D_\lambda`$ |
| Analytic connection-data space $`\mathcal R_\lambda`$ | Connection matrices modulo their analytic equivalences | Riemann–Hilbert data |
| Modification correspondence | Source and target local types | A prescribed change of lattices defining a time step on its domain |

The moduli of marked pairs parametrizes the *surfaces* $`X_\lambda`$; it is not their
two-dimensional phase fiber. A simple-object stack usually has scalar
$`\mathbb G_m`$-inertia; it is not its coarse space. A polynomial matrix chart can
omit an entire curve from $`U_\lambda`$. The analytic Riemann–Hilbert map has its own
target and is not asserted to be algebraic.

The principal comparison therefore has the following form:

```math
\mathfrak C_\lambda^{\mathrm{pres}}
   \simeq \mathfrak M_\lambda^{\mathrm{pres}},\qquad
 \overline M_\lambda\simeq X_\lambda,\qquad
 M_\lambda^\circ\simeq U_\lambda,\qquad
 \iota_{T\lambda}\circ H_T=T_X\circ\iota_\lambda
```

on the expressly constructed presentation/modification domains. Here
$`\overline M_\lambda`$ is the stable sheaf moduli constructed in Layer 4, and
$`M_\lambda^\circ`$ is its locus of derived disjointness from the operator
anticanonical curve. Coverage by presentation charts, extension to a whole phase,
and compatibility of the extensions are separate conclusions in Layers 6 and 7.
No one of these statements is the definition of the others.

### Conventions

- Algebraic applications are over an algebraically closed field $`k`$ of characteristic
  zero. Relative statements use locally Noetherian $`k`$-schemes. Analytic statements
  specialize to $`\mathbb C`$. Connection ranks are positive and all specified polar divisors
  are effective relative Cartier divisors.
- A difference connection is a vector bundle $`V`$ on the *whole* curve $`C`$ with a
  meromorphic isomorphism $`\Phi:V\dashrightarrow\sigma^*V`$.
  Its arrows are regular bundle isomorphisms $`g`$ satisfying
  $`\Phi' g=(\sigma^*g)\Phi`$. For column solutions $`Y(\sigma z)=A(z)Y(z)`$,
  the conventions are $`A'=\sigma(g)Ag^{-1}`$ and $`F_A=A^{-1}\sigma`$.
  The generic semilinear module forgets the local lattices.
- For a modification $`R:V\dashrightarrow V'`$, write
  $`A'R=\sigma(R)A`$. A spectral automorphism and a time automorphism are distinct,
  even when both use the number $`q`$.
- A local relative position $`(m_1,\ldots,m_r)`$, listed in weakly decreasing order,
  means that, in regular local frames,
  the meromorphic map is equivalent to
  $`\operatorname{diag}(u^{m_1},\ldots,u^{m_r})`$. Positive entries are zeros.
  Local formal types include the relevant line-bundle identifications; a numerical
  eigenvalue is used only after trivializing the polar line.
- $`\mathscr S`$ denotes an operator surface, $`Q`$ its commutative anticanonical
  curve, $`X`$ a commutative phase surface, and $`D`$ its boundary. Identifications
  between $`Q`$ and $`D`$ are conclusions of comparison theorems.
- The Picard intersection form has signature $`(1,9)`$;
  $`\delta=-K_X`$. A marking is an isometry from the stated model lattice to
  $`\operatorname{Pic}(X)`$, with canonical class, boundary classes, and the chosen
  effective chamber retained. Pullback of divisor classes determines the convention
  for a geometric transformation.
- On an elliptic curve, the nome $`p`$ and the difference step $`q`$ are independent.
  Algebraic definitions do not choose an origin unless a group-law coordinate requires it.
- For each *finite word* $`w`$ of modifications, construct its domain $`B_w`$ and
  its source and target phase domains. Conditions excluding every $`q^{\mathbb Z}`$
  resonance, or every translated root wall, can be countably infinite.
  Their intersection is not called a Zariski-open finite-type base without a proof.
  Statements about all iterates either retain these pointwise hypotheses or use
  the domain groupoid of 0.1.

## Foundations and ownership

Use Mathlib's `Scheme`, `Scheme.Modules`, pullbacks, sheaf
descent, linear equivalences, and categorical localizations. Use Tau Ceti's
`FiniteLocallyFreeSheaf`, `LineBundleClass`, blowups, and
`IntegralLattice`. A lattice introduced as an abstract free module is
identified with the geometric Picard group by a theorem.

| Supplier | Imported contract | Work owned here |
|---|---|---|
| [AlgebraicVectorBundles](../AlgebraicVectorBundles/README.md), L0A–L0C, L1–L2 | Finite locally free sheaves, pullback, duals, tensors, determinants, and geometric bundle comparison | Bundle stacks, meromorphic difference maps, and Birkhoff–Grothendieck in 1.1–1.4 |
| [AlgebraicCurves](../AlgebraicCurves/README.md), Layers 3–5, 9, 12; [SchemeAndStackFoundations](../SchemeAndStackFoundations/README.md), 3.2–3.7 | Divisors, degrees, Riemann–Roch, genus-zero/genus-one geometry, and curve Picard theory | Relative positions, determinant balance, boundary period maps, and correspondence quotients |
| [SchemeAndStackFoundations](../SchemeAndStackFoundations/README.md), 1.17–1.23, 4.14 | Quotient predicates, stacks, 2-fiber products, inertia, projective Quot/Hilbert, Hom/Isom parameter spaces | Actual Bun/Hecke/connection stacks, bounded stability/GIT, and scalar rigidification; finite-inertia Keel–Mori is not directly applicable to a scalar gerbe |
| [SchemeAndStackFoundations](../SchemeAndStackFoundations/README.md), 2.2, 2.6, 2.18–2.20, 4.3–4.6 | Coherent cohomology, derived coherent categories/duality, and small-extension deformation theory | Difference and operator deformation complexes, relative Ext, obstruction calculations, and the moduli Poisson form |
| [StableReduction](../StableReduction/README.md), Layer 4; [SchemeAndStackFoundations](../SchemeAndStackFoundations/README.md), 4.11, 4.17, 5.9–5.10 | Blowups/strict transforms, flat base change, normal crossings, surface intersection, adjunction, and Riemann–Roch | Rational-surface Picard/canonical formulas, infinitely near configurations, generalized Halphen pairs, and Sakai classification |
| [JacobianChallenge](../JacobianChallenge/README.md), Layers C–D | Proper coherent cohomology and its stated base-change criteria; Picard/Jacobian representability in its stated scope | The boundary Picard functors and multidegree-zero restriction maps needed in 2.3, including singular boundary curves |
| [IntegralLattices](../IntegralLattices/README.md); [RepresentationTheory/RootSystems](../RepresentationTheory/RootSystems/README.md); [KacMoody](../KacMoody/README.md), Layer 2 | Integral/root lattices, root data, Weyl/Coxeter theory at their stated hypotheses | Effective root configurations, Picard markings, geometric realization, and parameter actions |
| [GrothendieckEulerForms](../GrothendieckEulerForms/README.md) | Exact/abelian/triangulated $`K_0`$, finite Ext-Euler forms, and numerical quotients | Operator-surface numerical classes, Serre duality, and their geometric identifications |
| [PadicMeasuresIwasawaAlgebras](../PadicMeasuresIwasawaAlgebras/README.md), 5.1; AlgebraicVectorBundles L0C | Determinants of finite projectives/perfect complexes, exact-sequence and base-change laws, and line-bundle gluing | Perfect relative pushforward and determinants of cohomology in 4.2; tau divisors and the reference-object comparison in 8.2–8.3 |
| [ComplexComparisonPartII][complex-comparison], C−1.1–C−1.2, C0.1–C0.4, C1.9, C2.2; [ComplexKahlerGeometry](../ComplexKahlerGeometry/README.md), K1, K3–K4 | Complex analytic spaces, analytification, coherent analytic sheaves and exact coherent analytification, holomorphic bundle comparison and algebraization on proper curves, holomorphic calculus | Analytic $`q`$-difference classification, Birkhoff connection matrices, and $`qP_{\mathrm{VI}}`$ Riemann–Hilbert in 6.4 |
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

For $`\operatorname{QGr}`$, consume Mathlib's
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

<a id="layer-0"></a>
## Layer 0: Relative discrete dynamics

### 0.1 Transport with explicit domains

For a family $`p:M\to B`$, define a discrete transport over a base isomorphism
$`t:B_0\to B_1`$ by an isomorphism between specified open subfamilies of
$`M|_{B_0}`$ and $`t^*M|_{B_1}`$. Define the corresponding version for stacks,
with natural isomorphisms as 2-morphisms. A modification that has multiple possible
targets remains a correspondence until uniqueness is proved.

Construct restriction, inverse, composition, base change, and the domain of a word.
Prove associativity with the actual domain identifications, and obtain a groupoid of
admitted transports. An action of an abstract Weyl group requires its relations on
these domains, not only matrices satisfying relations on a lattice.

**Checks.** Composing maps requires the inverse image of the second domain. An infinite
intersection of domains is not supplied an algebraic open-subscheme structure by definition.

*Needs:* Native schemes, open immersions, pullbacks, categories, and the stack supplier.

### 0.2 Solutions and observation functions

A solution over an admitted orbit $`\lambda_n`$ is a sequence
$`x_n\in M_{\lambda_n}`$ satisfying the transport laws. Construct finite-interval
and two-sided solutions, restriction and reindexing, and prove existence and uniqueness
from an initial point when all required transports are isomorphisms of the relevant
whole fibers. State the admissibility condition for each finite interval.

An observation is a rational map to $`\mathbb P^1`$, with its domain retained.
Construct observed scalar recurrences from a chosen chart and prove invariance under
change of presentation. A pole of an observation can be a regular phase point;
an unresolved base point of a rational observation does not have a value merely
because the phase trajectory exists.

**Checks.** A point at infinity in one affine chart has a unique phase iterate when
transport is regular. An observation requiring both numerator and denominator to vanish
must be resolved or replaced by another chart.

*Needs:* 0.1 and native rational-map/projective-line foundations.

### 0.3 Comparison and descent of dynamics

Construct equivariant maps and equivalences between relative transports, including
change of base, retained markings, and stabilizers. Prove transport of solutions and
observations. Descend transports from a presentation atlas when the transition
isomorphisms satisfy the cocycle law, and prove independence of an atlas refinement.

Prove the extension principle used below: two morphisms from a reduced integral
scheme to a separated scheme agreeing on a dense open agree everywhere; compatible
local extensions glue. This extends a *constructed* comparison, not a merely
numerical identification of Picard lattices.

*Needs:* 0.1–0.2, scheme gluing, separatedness, and stack descent.

<a id="layer-1"></a>
## Layer 1: Difference connections and modifications

### 1.1 Bundles with a meromorphic difference map

For a smooth projective relative curve $`C/B`$, a $`B`$-automorphism $`\sigma`$,
rank $`r`$, degree $`d`$, and a finite polar support, construct the groupoid of
bundles $`V`$ with $`\Phi:V\dashrightarrow\sigma^*V`$. In a family, describe the
meromorphic map by a map after a specified Cartier twist and require it to be
invertible off a relative divisor. Prove independence under enlarging the bound.
An arbitrary rational localization on a fiber is not a substitute for this relative construction.

Construct tensor products, duals, determinants, regular pullback, and the
generic-fiber/completed-local-field constructions over fields. Prove the
geometric-fiber comparison with
Mathlib's semilinear equivalences, including the convention $`F_A=A^{-1}\sigma`$.
Characterize regular arrows by preservation of all retained lattices. The generic
fiber functor is faithful, but full faithfulness is asserted only with these
lattice-preservation conditions. For families use the relative Cartier localization;
pointwise generic fibers do not determine data over a nonreduced base.

**Checks.** At $`C=\mathbb P^1`$, $`\sigma(z)=qz`$, multiplication by $`z`$ gives
a rational gauge changing an exponent by $`q`$; it is not a regular automorphism
of $`\mathcal O_{\mathbb P^1}`$. Quotienting by it would forget the time change.

*Needs:* Bundle, curve, and coherent-sheaf suppliers.

### 1.2 Local type and determinant balance

Develop elementary divisors of pairs of lattices over a discrete valuation ring,
relative-position strata, their duality laws, composition/convolution strata,
and local length formulas. Prove determinant-length additivity under composition;
individual elementary divisors do not add coordinatewise.
On an orbit of $`\sigma`$, record how source and target points are identified.
At a fixed point, construct the formal difference module and its regular-singular
eigenline/exponent data. For families, require the finite-support quotients to be
flat over the parameter base, equivalently locally free after their finite
pushforward, and use locally constant elementary-divisor strata; prove their
base-change statements.

For a meromorphic map $`V\to\sigma^*V\otimes L`$, prove
```math
\deg\operatorname{div}(\det\Phi)
 =\deg(\sigma^*V)-\deg V+r\deg L=r\deg L.
```
Translate between this holomorphic-twist convention and signed relative positions
for the original meromorphic map. Construct the determinant local-type constraint
and the rank-one comparison. Retain the actual determinant isomorphism or its
specified normalization, not only its divisor.

**Checks.** For rank two and a $`2\infty`$ twist the determinant has degree four.
Simple determinant zeros have position $`(1,0)`$; a full scalar zero has position
$`(1,1)`$.

*Needs:* 1.1, valuation-ring module theory, divisor degree, and determinant APIs.

### 1.3 Hecke stacks and the modification law

Construct $`\operatorname{Bun}_r(C)`$ and $`\operatorname{Hecke}_S(C)`$ as fppf
stacks on the base: the latter has triples $`(V,W,R)`$, where $`R`$ is an
isomorphism off $`S`$, with the stated lattice positions. Prove descent, the
forgetful maps, and the 2-fiber-product description
```math
\mathfrak C_{\sigma,S}(C)=
 \operatorname{Bun}_r(C)
 \mathbin{\times_{\operatorname{Bun}_r(C)^2}}
 \operatorname{Hecke}_S(C),
 \qquad V\longmapsto(V,\sigma^*V).
```
Impose the local-type and determinant conditions of 1.2 on this construction.

Define modifications of connections by meromorphic bundle maps
$`R:V\dashrightarrow V'`$ with prescribed positions and
$`\Phi'R=(\sigma^*R)\Phi`$. Construct elementary modifications from lines or
quotients in the relevant fibers, prove their inverse and composition laws, and
determine the transformed local type. Prove
```math
\det A'=\frac{\sigma(\det R)}{\det R}\det A
```
in a common frame. Prove uniqueness and regular dependence on a specified domain
before exporting a time map from the correspondence.

*Needs:* 0.1, 1.1–1.2, stacks, relative Hom/Isom/Quot, and bundle descent.

### 1.4 Bundle strata and complete presentation domains

Prove Birkhoff–Grothendieck on $`\mathbb P^1`$, uniqueness of the splitting
multiset, cohomology and automorphisms of split bundles, and the relative
semicontinuity/stratification results used to construct presentation atlases.
Give framed parameter spaces for maps with fixed pole bounds on each bounded
splitting stratum, including their change-of-frame groups.

For a degree-zero irreducible rank-two difference connection
$`V\to\sigma^*V(2\infty)`$, prove that
```math
V\simeq\mathcal O(k)\oplus\mathcal O(-k),\qquad 0\leq k\leq1:
```
if $`k>1`$, the component from $`\mathcal O(k)`$ to
$`\mathcal O(2-k)`$ vanishes and produces an invariant subbundle.
Construct both allowed strata and their overlap with Hecke charts.
For other bounded inputs used below, prove the analogous required bounds rather
than assuming that a trivial-bundle chart contains every object.

*Needs:* 1.1–1.3, curve Riemann–Roch, coherent cohomology/base change, and Quot.

<a id="layer-2"></a>
## Layer 2: Rational anticanonical surfaces

### 2.1 Point blowups and the geometric Picard lattice

Starting from the supplied blowup and intersection theories, prove the Picard
decomposition, intersection formulas, and
$`K_{\widetilde X}=\pi^*K_X+E`$ for a smooth point blowup. Construct ordered
blowup families, including infinitely near sections, and prove the formulas after
the permitted base changes. Treat $`\mathbb P^2`$, $`\mathbb P^1\times\mathbb P^1`$,
and the Hirzebruch surfaces needed for their elementary transformations.

For eight blowups of $`\mathbb P^1\times\mathbb P^1`$, construct the marking
```math
L=\mathbb ZH_f\oplus\mathbb ZH_g\oplus\bigoplus_{i=1}^8\mathbb ZE_i,\qquad
 H_f^2=H_g^2=0,\ H_fH_g=1,\ E_iE_j=-\delta_{ij},
 \quad \delta=2H_f+2H_g-\sum E_i.
```
Prove its isometry with the nine-point plane model, compatibility with strict
transforms, and the distinction between an exceptional *class* and an effective
irreducible exceptional curve.

*Needs:* The blowup, surface-intersection, and lattice suppliers.

### 2.2 Marked generalized Halphen pairs

Define the geometric class before its classification: a smooth projective rational
surface $`X`$, $`K_X^2=0`$, and an effective anticanonical divisor
$`D=\sum m_iD_i`$ of canonical type, meaning $`D\cdot D_i=0`$ for every
irreducible component, together with a Picard marking and a chosen chamber.
Use Sakai's unique-anticanonical-divisor hypothesis for the classified
nonautonomous families; distinguish it from the stronger condition
$`h^0(X,nD)=1`$ for every $`n>0`$.

Construct the rational two-form with divisor $`-D`$, its one-dimensional
normalization space, and the induced symplectic form on $`U=X\setminus D`$.
Include nonreduced canonical-type boundaries, using their multiplicities in
adjunction and in the polar divisor. Construct families and their isomorphisms
with the marking, boundary, and two-form normalization retained.

**Checks.** A smooth elliptic $`D`$, a cycle of rational curves, and an additive
nonreduced boundary have different Picard and period theories. An arbitrary
rational anticanonical pair is not made a Sakai pair by its name.

*Needs:* 2.1, adjunction/duality, and curve Picard theory.

### 2.3 Period maps and parameters

Let $`R_D\subset L`$ be generated by the marked boundary components. Construct
restriction of line bundles and the period homomorphism
```math
\operatorname{per}:R_D^\perp\longrightarrow\operatorname{Pic}^0(D),
 \qquad \alpha\longmapsto\mathcal O_X(\mu(\alpha))|_D.
```
Prove that this lands in the indicated identity component in the classified
families. On a reducible boundary, degree zero on every component is essential;
total degree zero alone is insufficient. Construct the relative version, the
smooth/nodal/cuspidal coordinate comparisons, and the compatibility with markings
and change of normalization.

For a smooth irreducible boundary, identify $`R_D^\perp=\delta^\perp`$ and
$`\delta^\perp/\mathbb Z\delta`$ with the negative $`E_8`$ lattice. Prove
$`\operatorname{per}(\delta)=\mathcal O_D(D)`$. Do not descend the period map
through $`\mathbb Z\delta`$ unless this line bundle is trivial.
Construct root-parameter charts and the equations for the effective-root walls
needed in each comparison.

**Check.** If $`D`$ is smooth and $`\mathcal O_D(D)`$ is nontorsion,
the restriction exact sequences give $`h^0(X,nD)=1`$ for all $`n`$, hence
$`\Gamma(U,\mathcal O_U)=k`$. This detects the difference between a phase surface
and an affine algebraic monodromy surface even when their analytifications agree.

*Needs:* 2.1–2.2, Picard functors, exact sequences, and curve cohomology.

### 2.4 Sakai classification and its scope

Prove the finite classification of the pairs in 2.2 under Sakai's hypotheses.
Construct the boundary configurations, multiplicities, orthogonal symmetry root
data, and marked blowup models. Distinguish the two embeddings conventionally
denoted by the $`A_7^{(1)}`$ surface labels, rather than identifying them from
their abstract dual graph.

The classification includes the smooth elliptic $`A_0^{(1)}`$, the multiplicative
$`A_0^{(1)*},A_1^{(1)},\ldots,A_8^{(1)}`$ cases with the two $`A_7^{(1)}`$
embeddings, and the additive
$`A_0^{(1)**},A_1^{(1)*},A_2^{(1)*},D_4^{(1)},\ldots,D_8^{(1)}, E_6^{(1)},E_7^{(1)},E_8^{(1)}`$ cases.
This is the 22-type geometric classification, with the embeddings and degenerate
root data retained.

For each type provide the actual lattice embedding, its orthogonal complement,
the effective-chamber conditions, and the family of surfaces realizing it.
Prove exhaustiveness within the stated class. State explicitly which symmetry
data have nonzero translations; an $`A_0^{(1)}`$ symmetry label does not manufacture
one. Degeneration arrows are constructed families, not conclusions from an
inclusion of Dynkin diagrams. The particular degenerations required here are in
Layer 9.

*Needs:* 2.1–2.3 and root-system theory. *Sources:* [Sakai], [KNY, §§3, 8.2],
[DT, Introduction and Remark 1.1].

<a id="layer-3"></a>
## Layer 3: Operator surfaces and equation presentations

### 3.1 Sheaf bimodules and the noncommutative projective line

For smooth projective curves $`C_0,C_1`$, define a sheaf bimodule as a coherent
sheaf $`\mathscr E`$ on $`C_0\times C_1`$ whose support is finite over both
factors. Birank $`(2,2)`$ means that both projections have locally free
pushforward of rank two. In a family impose the corresponding relative finiteness
and local-freeness conditions. Construct convolution, its associativity, the
associated tensor functor, and its left and right adjoints with their units and counits.

Construct Van den Bergh's noncommutative symmetric $`\mathbb Z`$-algebra:
degree-$`(i,i+1)`$ terms are the iterated adjoint bimodules
$`\mathscr E^{*i}`$; the quadratic relations are the images of the adjunction
units
```math
\mathcal O_{C_i}\longrightarrow
 \mathscr E^{*i}\otimes\mathscr E^{*(i+1)}.
```
Define graded modules, bounded/torsion modules, and
$`\mathbf P(\mathscr E)=\operatorname{QGr}S(\mathscr E)`$.
Prove the quotient universal property, noetherian/coherent results, relative
pullback under the stated flatness hypotheses, the projection functors, and their
adjunctions. A freely chosen pair of quadratic relations is not this construction.

Compare with the ordinary projective bundle for $`\mathscr E=\Delta_*F`$,
where $`F`$ is a rank-two vector bundle on $`C`$. Scheme-theoretic support on
the reduced diagonal matters; a module on a doubled diagonal is a different case.
Prove invariance under isomorphism of bimodule data and the stated
line-bundle changes of presentation.

*Needs:* Bundle/coherent-sheaf suppliers, adjunctions, graded categories, and native
Serre localization. *Sources:* [VdB]; [R25, §9.2, Theorem 9.13].

### 3.2 Rational operator surfaces and their anticanonical curve

Construct the split rational surfaces obtained from 3.1 with $`C_i=\mathbb P^1`$
by the ordered point-blowup/blowdown construction of [R25, §§9–12].
The input consists of the bimodule, its commutative anticanonical curve, the
ordered centers satisfying the blowup construction's admissibility hypotheses,
and the marking. Define the noncommutative blowup category and its pullback/pushforward
adjunctions, exceptional objects, and restriction functors. Prove the equivalence
with the usual construction on the commutative locus.
Include the singular-boundary-center construction of [R25, §11.4,
Theorem 11.31] at its stated hypotheses: its boundary is the transformed
curve $`Q'`$, and the exceptional restriction is the perfect complex
$`\mathcal O_{Q'}\to\mathcal O_{Q'}(E)`$, not a smooth point sheaf.

Build the relative noetherian theory, finite resolutions used here, coherent
cohomology and base-change criteria, relative Ext, the Serre functor, and the
anticanonical natural transformation $`\theta\to\mathrm{Id}`$.
Construct its boundary category $`\operatorname{coh}(Q)`$, derived restriction
to $`Q`$, and the numerical $`K_0`$ and Euler/intersection comparisons.
Prove the blowup changes of these invariants and their compatibility with 2.1.
The condition of being disjoint from $`Q`$ means $`L i_Q^*M=0`$.

In particular construct Rains's family $`\mathscr S_{z,\eta}`$ from a
possibly degenerate commutative degree-one del Pezzo surface $`Y`$ with
anticanonical curve $`Q`$. Include the weak del Pezzo cases with $`-K_Y`$
nef and big and the boundary-component hypotheses of that construction,
using the parameters
```math
z=\det(L i_Q^*[\mathcal O_Q]),\qquad
 \eta=\det(L i_Q^*[\mathrm{pt}])\quad\text{in }\operatorname{Pic}^0(Q).
```
Keep the tensor-unit parameter distinct from an arbitrary point of the curve.
Prove the commutative specialization $`\mathscr S_{w,1}=X_{w,1}`$, and construct
the ambient blowup/mutation derived equivalences and their action on numerical
classes from [R25, §§9–13]. The universal-kernel equivalence constructed from
a moduli space belongs to 4.4.
Their functorial coherence is proved for the comparisons used here; no strict
categorical action is inferred from a lattice action.

*Needs:* 2.1–2.3, 3.1, coherent duality, derived categories, and $`K_0`$/Euler
suppliers. *Sources:* [R25, §§9–13, especially Theorem 12.13 and Corollary 12.14].

### 3.3 Relative equation–sheaf reconstruction

Construct the presentation functor from two-term bundle presentations on the
ruled model to coherent sheaves on the operator surface. Prove its numerical-class
formula from the actual resolution, before applying any twist or derived equivalence.
Conversely, construct the relative pushforward/presentation on the locus where
the required cohomology and evaluation maps have constant rank and commute with
base change. State the two mutually inverse functors and their natural isomorphisms.

For the equation reconstruction of [R25, §19.1], retain transversality and both
```math
\operatorname{Hom}(\mathcal O_f(-1),M)=0,\qquad
 \operatorname{Hom}(M,\mathcal O_f(-1))=0
```
for the ruling fibers involved. Prove the equivalent local/pushforward conditions
and their precise relative versions. Define and construct the maximal regular
lattice on the locus where its formation commutes with base change. Outside that
locus keep the coherent sheaf and its limiting data; do not replace it fiberwise
by an unrelated maximal lattice.

**Required boundary check.** Over $`R=k[t,u]_{(t,u)}`$, consider the split
two-branch presentation $`B=(u,u-t)`$. The conditions $`uf,(u-t)f\in R`$
give maximal lattice $`R`$; after $`t=0`$ the fiberwise maximal lattice is
$`u^{-1}k[u]_{(u)}`$. Verify this failure of base change and identify the
flatness/constant-rank condition that excludes it from the reconstruction domain.

*Needs:* 1.1–1.4, 3.1–3.2, cohomology/base change, and relative Hom.
*Sources:* [R13, §2]; [R25, §19.1].

### 3.4 The automorphism case and Jimbo–Sakai's operator surface

For $`C=\mathbb P^1`$, $`\sigma(z)=qz`$, construct
```math
\mathscr E_q=\mathcal O_\Delta\oplus\mathcal O_{\Gamma_\sigma}.
```
Pin the graph/projection convention by proving that its tensor functor has
summands $`V`$ and $`\sigma^*V`$.
Two-arrow presentations
```math
b_0:W\longrightarrow V,\qquad b_1:W\longrightarrow\sigma^*V
```
with generically invertible $`b_0`$ recover $`A=b_1b_0^{-1}`$.
Prove the regular-gauge and modification dictionaries, including determinant
and local-position data. For the degree-two Jimbo–Sakai chart use
$`W=V(-2\infty)`$, $`b_0`$ the inclusion, and $`b_1`$ the restricted
connection map. Compute its numerical class and any change of class used to
compare it with the stable model of 4.4.

Over the function field compare with the Ore algebra
$`K[T,T^{-1};\sigma]`$, $`Tf=\sigma(f)T`$.
Globally use the correspondence/bimodule construction: $`\sigma`$ moves opens,
so an ordinary sheaf of rings on $`C`$ with an undeclared shift action is insufficient.

**Checks.** $`\mathcal O_\Delta\oplus\mathcal O_{\Gamma_\sigma}`$ is not
$`\mathcal O_{\Delta\cup\Gamma_\sigma}`$.
Compute the point/anticanonical curve of this presentation. In coordinates
$`[z_0:z_1]`$, $`[u:v]`$, its equation is $`z_0z_1uv=0`$ for $`q\ne1`$:
the fixed-point components are retained. The normalization of the two graphs
alone loses that information.

*Needs:* 1.1–1.3, 3.1–3.3. *Sources:* [R25, §§9.2–9.3, 19.1]; [JS].

### 3.5 Elliptic correspondences, descent, and reflection

Let $`Q`$ be a smooth genus-one curve, $`\pi_i:Q\to C_i\simeq\mathbb P^1`$
finite flat maps of degree two with deck involutions $`\iota_i`$, and
$`L`$ an invertible sheaf. Construct
```math
\mathscr E=(\pi_0,\pi_1)_*L,\qquad
 B:\pi_0^*V_0\dashrightarrow\pi_1^*V_1\otimes L.
```
Prove the birank statement and the presentation comparison of 3.3 on its domain.
Set $`U=\pi_0^*V_0`$, $`\tau=\iota_0\iota_1`$, and
$`T=L\otimes(\iota_1^*L)^{-1}`$. The construction gives
```math
A=(\iota_1^*B)^{-1}B:
 U\dashrightarrow\iota_1^*U\otimes T
       \simeq\tau^*U\otimes T.
```
Define the corresponding linear object using the $`\iota_0`$-descent of $`U`$,
the meromorphic map $`A`$, its inverse/reflection compatibility, and its
coherent local lattices. Prove descent to the coarse double-cover quotient
with the required trivial inertia action at the ramification points.
Keep the norm trivialization $`T\otimes\iota_1^*T\simeq\mathcal O_Q`$.
Prove that $`\tau`$ is a translation by an element of the Jacobian acting
on the genus-one torsor, and compute it from the two degree-two quotient
line bundles. Its order is an additional hypothesis of a dynamical application.

In an untwisted additive coordinate, with
$`\iota_0z=-z,\ \iota_1z=-z-h`$, prove the comparison
```math
Y(z+h)=A(z)Y(z),\qquad Y(-z)=Y(z),\qquad A(-z-h)A(z)=I.
```
Prove that removing $`T`$ by replacing $`U`$ with $`U\otimes P`$ requires
$`T\otimes P\simeq\tau^*P`$; it is not automatic. Characterize this obstruction
in $`\operatorname{Pic}^0(Q)`$. Thus an arbitrary translation connection on
an elliptic curve is not the elliptic Painlevé linear object.

Construct $`\mathscr E`$ directly in families. The recovery of a correspondence
curve and a line bundle from a bimodule over a field does not give a flat
functorial recovery in every family; use [R25, Proposition 9.14] at its stated
scope. At a singular reducible correspondence, meromorphic branch data and the
regular lattices are retained separately: two inverse branch maps need not glue
as a regular isomorphism at their crossing.

Construct a shared scalar analytic foundation, independently of either
Painlevé application. For $`0<|p|<1`$, define
```math
\theta_p(z)=\prod_{n\geq0}(1-p^nz)(1-p^{n+1}/z),\qquad z\ne0,
```
prove normal convergence, its simple divisor $`p^{\mathbb Z}`$, and
$`\theta_p(pz)=\theta_p(1/z)=-z^{-1}\theta_p(z)`$.
Compare with Mathlib's two-variable Jacobi theta function, and construct the
comparison of the multiplicative quotient with its algebraic genus-one curve.
Both 6.4 (with $`p=q`$) and 7.1 consume this same foundation.

*Needs:* 1.1–1.3, 3.1–3.3, genus-one geometry and descent; ComplexTori
Milestones 1–2, ComplexManifolds Milestone 7, and Mathlib's
`NumberTheory.ModularForms.JacobiTheta.TwoVariable`.
*Sources:* [R13, §2]; [R25, §§9.2, 19.1]; [OR].

<a id="layer-4"></a>
## Layer 4: Moduli and Poisson geometry

### 4.1 The actual moduli functors and their construction

Construct the family stacks of connection objects of Layer 1 and coherent
operator-sheaves of Layer 3, with fixed local/numerical data. Define pure
one-dimensional sheaves and stability using the reduced Hilbert polynomial for
a specified ample class $`H`$:
```math
p_M(n)=n+\frac{\chi(M)}{H\cdot c_1(M)}.
```
Prove the subobject/quotient criteria, openness and boundedness in the cases
used here, and change-of-polarization statements with their walls.
Simple, stable, and irreducible are distinct predicates.

For bounded connection presentations use the relative parameter spaces of 1.4
and the actual local-type equations. For operator-sheaves construct the needed
bounded Quot/presentation functors in their graded-module categories, proving
representability and base change; commutative Quot representability alone does
not establish this. Construct the framed parameter spaces and their quotient
descent. Supply the reductive invariant theory and stability-to-quotient comparison
used in a GIT presentation, rather than assuming it from a quotient-stack definition.

Obtain the algebraic stacks of these bounded problems. For operator-sheaves,
construct separated stable coarse algebraic spaces and universal-object covers.
Connection presentation domains inherit this stability only through the proved
equivalence of 3.3; no separated coarse space is asserted for all of Bun or
every unqualified connection stack. For the surfaces $`\mathscr S_{z,\eta}`$
of 3.2 and classes $`(0,rQ,d)`$ with $`r>0`$, $`\gcd(r,d)=1`$, and
$`z^r\eta^d=1`$, prove the projective semistable coarse construction under the
stated ample-polarization hypotheses. Family flatness, saturation, automorphism
groups, and the equivalence
between the quotient and the original moduli functor are parts of the target.

*Needs:* 1.1–1.4, 3.1–3.3, stack/Quot/deformation suppliers.
*Sources:* [R16, moduli construction]; [R25, §§18.1–18.4].

### 4.2 Scalar rigidification and universal objects

On a simple-object locus prove that the inertia is the central $`\mathbb G_m`$,
construct its rigidification, and prove the gerbe comparison with the coarse
moduli problem. Keep fixed determinant type/isomorphism class, a chosen determinant trivialization,
projectivization, and scalar rigidification as different operations.
Prove their effects on automorphisms and on the local-type parameters.
The scalar-gerbe construction here fixes the determinant type without a
chosen determinant isomorphism. For rank-$`r`$ connections, imposing such an
isomorphism reduces scalar inertia to $`\mu_r`$, and requires its own comparison.

For the universal flat families used here, prove the requisite perfectness
of relative coherent pushforward using 3.2's finite resolutions and proper
cohomology. Construct its determinant by descent, with the exact base-change
laws and scalar-character calculation; these are prerequisites to the
universal-object argument, independently of Layer 8.
For a primitive class with $`\chi(M)=1`$, construct the determinant-of-cohomology
line on the universal-object stack. Its scalar weight is one; prove that twisting
the universal object by the inverse of this line descends it to the coarse
space. For the coprime $`(r,d)`$ classes specified in 4.1 use the corresponding
weight-one combination supplied by the actual Euler pairings.
Prove uniqueness only up to tensoring with a line bundle from the base, and
record the chosen normalization when reconstructing a matrix Lax pair.

The construction must explain why the scalar gerbe is neutral in these cases.
Keel–Mori with finite inertia cannot be applied to the unrigidified
$`\mathbb G_m`$-stack.

*Needs:* 4.1, coherent cohomology/base change, determinant and stack suppliers.

### 4.3 Deformation, obstruction, and the Poisson form

Construct the deformation complex of a difference connection from derived
global Hom with the pullback functor, or a $`\sigma`$-compatible Čech model,
with the imposed local conditions. On global cocycles its differential is
```math
f\longmapsto(\sigma^*f)\Phi-\Phi f.
```
Since $`\sigma`$ moves opens, this is not a differential between ordinary
sheaves on $`C`$, even after forgetting $`\mathcal O_C`$-linearity.
Compare it with the operator-sheaf Ext complex on the presentation domain.
Prove tangent, automorphism, and obstruction interpretations for square-zero
extensions, with their relative base-change hypotheses.

For stable operator-sheaves construct the Poisson tensor from
$`\theta\to\mathrm{Id}`$, Serre duality, Yoneda products, and trace.
Identify its symplectic leaves by the required derived restriction to $`Q`$;
on $`L i_Q^*M=0`$, prove nondegeneracy and closedness. The comparison with a
surface two-form is owned by 5.4 and the applications. Prove smoothness by the actual obstruction
calculation. In the two-dimensional cases $`\operatorname{Ext}^2(M,M)`$
can be one-dimensional; its vanishing is not a valid shortcut.

*Needs:* 3.2–3.3, 4.1–4.2, duality, deformation theory, and finite Ext-Euler forms.
*Sources:* [R16, Theorem 11.3]; [R25, §18].

### 4.4 A stable moduli construction of the completed phase

For the family $`\mathscr S_{z,\eta}`$ of 3.2, fix $`Y,Q`$,
$`w\in\operatorname{Pic}^0(Q)`$, coprime integers $`r,d`$ with $`r>0`$,
and an ample class $`H`$ for which every semistable pure one-dimensional sheaf
with $`c_1=rQ,\ \chi=d`$ on $`\mathscr S_{w^{-d},w^r}`$ is stable.
Construct the stable moduli and prove the comparison
```math
\overline M_H(\mathscr S_{w^{-d},w^r};\,0,rQ,d)
       \simeq X_{w,1}.
```
Prove nonemptiness, smoothness, projectivity, the identification of its
anticanonical divisor, and that derived disjointness from $`Q`$ corresponds
to the complement of that divisor. Construct the universal-kernel derived
equivalence and the numerical comparison used in this proof.

This is [R25, Lemmas 18.18–18.21 and Theorem 18.22], including their
degree-one del Pezzo and stability hypotheses. Its statement as an unmarked
surface isomorphism does not supply a chosen equation presentation, marking,
parameter-family isomorphism, or time step; those are constructed in Layers 5–7.

For $`r=d=1`$, prove directly that semistability equals stability and that the
condition is independent of $`H`$: every proper positive-dimensional subobject
has integer Euler characteristic, and the stable inequalities are equivalent
to $`\chi(N)\leq0`$. Prove the corresponding family result on parameter charts
where the constructions and boundary data extend, with effective descent on
their overlaps. The fieldwise theorem alone is not the family proof.

*Needs:* 2.1–2.3, 3.2, 4.1–4.3.

<a id="layer-5"></a>
## Layer 5: Transformations and comparison theorems

### 5.1 Geometric Weyl transformations

Define a Cremona isometry using the intersection pairing, canonical class, and
effective cone of the marked family. Construct the elementary changes of
marking by the actual birational maps and their resolved families. Prove the
simple-reflection formulas
```math
s_\alpha(x)=x+(x\cdot\alpha)\alpha,\qquad \alpha^2=-2,
```
their Coxeter relations on the stated domains, and the induced action on period
and root parameters. Construct diagram automorphisms separately.

Prove the geometric realization for the symmetry data of 2.4 and its relation
to the chamber. On effective-root walls, specify whether a given construction
is a change of marking, a map to another chamber, or a rational correspondence.
An arbitrary lattice isometry is not asserted to be an automorphism of a
fixed surface.

*Needs:* 0.1, 2.1–2.4, and native Weyl/Coxeter theory.
*Sources:* [Sakai]; [KNY, §§3, 5.7, 8.4].

### 5.2 Translations and discrete Painlevé data

Use the existing Eichler transvection with the Picard convention
```math
t_v(x)=x+(x\cdot\delta)v
       -\left(x\cdot v+\frac{v^2}{2}(x\cdot\delta)\right)\delta,
 \qquad v\cdot\delta=0,\quad v^2\in2\mathbb Z.
```
Import its integrality, isometry, addition law and invariance under
$`v\mapsto v+n\delta`$. Identify the translation sublattice appropriate to
each symmetry type and construct its geometric action from 5.1.
For an extended-Weyl element whose power is a translation, retain both the
element and the power; do not label it a primitive translation without checking.

A geometric discrete Painlevé datum consists of the marked family of 2.2,
an admitted translation or specified extended-Weyl element, its base action,
and the realized phase transport. Construct its coordinate presentations and
their change-of-marking comparisons. Prove preservation of the symplectic form
with its specified normalization.

For each classified boundary type, compute the transformation of $`\operatorname{per}`$,
including $`\operatorname{per}(\delta)`$; this recovers the elliptic, multiplicative,
or additive step in the corresponding generalized Picard group after the
relevant period coordinate is chosen.
A choice of surface and boundary alone does not select a nonzero $`v`$.

*Needs:* 0.1–0.3, 2.3–2.4, 5.1, and the native transvection API.

### 5.3 Modifications, stability, and group relations

Construct the action of elementary modifications on local types, numerical
classes, markings, and polarizations. On the domain where the transformed
object remains stable, prove that the moduli correspondence is the transport
of 0.1 and compute its Picard action. Construct the chamber changes or stable
replacements required by each full-phase extension in Layers 6–7, and compare
them on their common domain.

Prove the required relations as natural isomorphisms for the object functors,
and as equalities for their coarse transports. Keep lattice relations,
coarse-map relations, and categorical coherence distinct.
For the elliptic plane realization, compute the subgroup generated by elementary
Hecke shifts and permutations: the $`A_8`$ translation lattice has index three
in $`E_8`$. Construct the additional degree-changing operation needed to recover
the full geometric $`E_8`$ action, as in [OR15, §6].

**Required stability check.** On a commutative rational elliptic surface with
another fiber $`F=C_1+C_2`$ of type $`I_2`$, take a line bundle on $`F`$ of
multidegree $`(0,1)`$. Its pushforward has $`c_1=Q,\ \chi=1`$ and is stable.
Tensoring by $`\mathcal O(C_1)`$ changes the multidegree to $`(-2,3)`$;
the subobject on $`C_2`$ of degree one destabilizes it. Verify this calculation.
Thus simplicity, or an autoequivalence of an operator category, does not prove
preservation of the chosen stable phase.

*Needs:* 1.3, 3.2–3.3, 4.1–4.4, 5.1–5.2.

### 5.4 The comparison theorem and its verification data

Prove a comparison theorem using a concrete atlas: construct the functor from
linear objects to operator-sheaves on each presentation domain, its inverse,
and its scalar descent; construct the blowup coordinates on the resulting
coarse charts; prove agreement of transitions; then identify the compact
moduli with the marked pair and its boundary.

The comparison must supply:

1. The parameter map and its inverse on the stated domain, including determinant,
   exponent lifts, and any scalar normalization.
2. The family isomorphism, its boundary and Picard marking, the period map,
   and the normalized two-form comparison.
3. The modification domain, transformed type, and the actual time element.
4. Equality of the two time maps on a common dense chart, followed by the
   separatedness/extension theorem of 0.3 on every asserted extension domain.

Prove invariance under replacing either atlas by a refinement. Equality of
surface types, dimensions, periods, or lattice actions is insufficient by itself:
either prove the needed rigidity/faithfulness statement for the marked family
or use the dense-chart equality just specified. Compute the normalization of
the numerical sheaf class; the expression $`(0,Q,1)`$ is not assigned to an
arbitrary raw matrix problem by definition.

*Needs:* 0.3, 1.3–1.4, 2.1–2.3, 3.3–3.5, 4.1–4.4, 5.1–5.3.

<a id="layer-6"></a>
## Layer 6: Jimbo–Sakai $`qP_{\mathrm{VI}}`$

### 6.1 The linear problem and its presentation

Fix $`q\in k^\times`$ of infinite multiplicative order, $`C=\mathbb P^1`$,
$`\sigma(z)=qz`$, and nonzero ordered parameters
$`(a_1,a_2,a_3,a_4,\kappa_1,\kappa_2,\theta_1,\theta_2,t)`$ satisfying
```math
\theta_1\theta_2=\kappa_1\kappa_2a_1a_2a_3a_4.
```
On the domain of distinct finite determinant points and distinct specified
eigenvalues, define the degree-zero rank-two connection problem by:
position $`(1,0)`$ at $`ta_1,ta_2,a_3,a_4`$, position $`(-2,-2)`$ at
$`\infty`$, the ordered leading eigenvalues $`\kappa_1,\kappa_2`$ there,
and ordered eigenvalues $`t\theta_1,t\theta_2`$ at $`0`$.
Fix the corresponding determinant connection type. Numerical eigenvalues use
the local polar-line frames specified by $`z`$.

Prove that its trivial-bundle framed chart consists of
```math
A(z,t)=A_0(t)+A_1(t)z+
             \operatorname{diag}(\kappa_1,\kappa_2)z^2,\qquad
 \operatorname{Spec}A_0=\{t\theta_1,t\theta_2\},
```
```math
\det A=\kappa_1\kappa_2
          (z-ta_1)(z-ta_2)(z-a_3)(z-a_4).
```
These are polynomial matrices invertible over $`k(z)`$, not units of
$`\operatorname{Mat}_2(k[z])`$. Prove the residual diagonal-conjugation quotient,
the rank-one obstruction to irreducibility, and the comparison with 1.4 and 3.4.
List the finite collision conditions for each algebraic chart separately from
the orbitwise nonresonance conditions used for analytic reconstruction.

*Needs:* 1.1–1.4, 3.4. *Source:* [JS, §3].

### 6.2 The $`t\mapsto qt`$ modification

Construct the prescribed modification with position $`(1,1)`$ at $`0`$,
simple rank-one poles at $`qta_1,qta_2`$, no other zeros or poles, and
the normalization $`R(\infty)=I`$ in the framed chart. Prove existence,
uniqueness up to the stated isomorphisms, and its exact domain.
Derive
```math
R(z,t)=\frac{z(zI+R_0(t))}
                 {(z-qta_1)(z-qta_2)},\qquad
 \det R=\frac{z^2}{(z-qta_1)(z-qta_2)},
```
```math
A(z,qt)R(z,t)=R(qz,t)A(z,t).
```
Compute the new local data using 1.2–1.3. In particular prove
```math
\frac{\det R(qz,t)}{\det R(z,t)}
 =\frac{(z-qta_1)(z-qta_2)}
        {(z-ta_1)(z-ta_2)}
```
and, from $`R(z)=zC+O(z^2)`$ at zero,
$`A_0(qt)=qC A_0(t)C^{-1}`$.
This identifies the time change from the linear problem itself.

Derive the classical recurrence with
```math
b_1=\frac{a_1a_2}{\theta_1},\quad
 b_2=\frac{a_1a_2}{\theta_2},\quad
 b_3=\frac1{q\kappa_1},\quad b_4=\frac1{\kappa_2},
```
```math
\frac{y\bar y}{a_3a_4}
   =\frac{(\bar z-b_1t)(\bar z-b_2t)}
           {(\bar z-b_3)(\bar z-b_4)},\qquad
 \frac{z\bar z}{b_3b_4}
   =\frac{(y-a_1t)(y-a_2t)}
           {(y-a_3)(y-a_4)}.
```
Here bars mean the parameter shift $`t\mapsto qt`$; define $`y,z`$ from
the matrix entries and prove the inverse reconstruction on their domain.

*Needs:* 0.1–0.3, 1.3, 6.1. *Source:* [JS, §§3–4].

### 6.3 The full phase and the missing matrix-chart curve

Construct the operator surface and ordered centers from the local data in 6.1,
compute the presentation class, and give the explicit changes of presentation
and numerical class bringing it to a primitive instance of 4.4. Prove the
comparison of that stable moduli with the $`A_3^{(1)}`$ marked Sakai surface,
including its $`D_5^{(1)}`$ symmetry data.

For a completely specified coordinate check, translate to the normalization
of [JR25, (1.1)]. With parameters
$`(k_0,k_t,k_1,k_\infty)`$, the eight ordered points are
```math
(0,k_0^{\pm1}t),\quad(k_t^{\pm1}t,0),\quad
 (k_1^{\pm1},\infty),\quad
 (\infty,k_\infty^{-1}),\quad(\infty,qk_\infty).
```
For the coefficient-chart comparison impose the finite conditions
```math
k_j^2\ne1\quad(j=0,t,1,\infty),\qquad qk_\infty^2\ne1,\qquad
 t\notin\{(k_tk_1)^{\pm1},(k_t/k_1)^{\pm1}\},
```
```math
k_0^{\epsilon_0}k_t^{\epsilon_t}k_1^{\epsilon_1}
        k_\infty^{\epsilon_\infty}\ne1,\qquad
 t\ne k_0^{\epsilon_0}k_\infty^{\epsilon_\infty}
 \quad(\epsilon_j\in\{\pm1\}).
```
These include [JR25, (2.3)–(2.4)] and the distinctness of the last two
centers. Prove that they exclude the constant triangular orbits and give
the geometric diagonal quotient. Reducible wall strata use the stable
sheaf moduli and their own charts, not this generic coefficient-quotient theorem.
Prove the parameter dictionary with 6.1–6.2. The strict transforms of
$`f=0,\infty`$ and $`g=0,\infty`$ form $`D_t`$; its complement is $`U_t`$.
Prove the precise coefficient-space theorem
```math
\{\text{normalized polynomial matrices}\}/
       \{\text{diagonal conjugation}\}
       \simeq U_t\setminus E_8^\circ,\qquad
 E_8^\circ=E_8\setminus D_t,
```
with [JR25, Definition 2.2 and Lemma 2.5]'s normalization.
Do not replace its right side by $`U_t`$.

Construct compatible equation/sheaf presentation charts after the required
modifications and prove their coverage of the open phase $`U_t`$ under the
comparison hypotheses. Use sheaf-moduli charts for the compactification,
including the sheaves supported on $`Q`$. Prove the whole-open-phase
extension of the time map and its inverse by the resolved blowup maps, and
its compatibility with the modification on each presentation domain.
Identify any ordinary-bundle chart only by its proved reconstruction theorem;
the omitted $`E_8^\circ`$ is not declared to be one splitting stratum by assumption.

Compute the actual pullback on the entire marked Picard lattice, including
boundary permutations, and its extended-Weyl description. Determine the
finite part and the smallest power that is a pure Kac transvection.
The one-step Jimbo–Sakai map is not preassigned a pure $`E_8`$ transvection.
Prove the two-form and period comparisons of 5.4.

*Needs:* 2.1–2.4, 3.3–3.4, 4.1–4.4, 5.1–5.4, 6.1–6.2.
*Sources:* [JR25, §2]; [DH, §4.2]; [R25, §19.6].

### 6.4 Analytic connection data and Riemann–Hilbert

Specialize to $`0<|q|<1`$. In the $`k_j`$ normalization of 6.3 impose the
explicit hypotheses
```math
k_0^2,k_t^2,k_1^2,k_\infty^2\notin q^{\mathbb Z},\qquad
 (k_tk_1)^{\pm1},(k_t/k_1)^{\pm1}\notin t q^{\mathbb Z},
```
```math
k_0^{\epsilon_0}k_t^{\epsilon_t}k_1^{\epsilon_1}
       k_\infty^{\epsilon_\infty}\notin q^{\mathbb Z},\qquad
 k_0^{\epsilon_0}k_\infty^{\epsilon_\infty}
       \notin t q^{\mathbb Z}\quad(\epsilon_j\in\{\pm1\}).
```
Construct canonical local fundamental solutions with their theta/exponent
factors, convergence, and holomorphic parameter dependence. Form the connection
matrix with a declared ordering of these factors, its functional equation,
determinant divisor, and left/right diagonal equivalences. Prove independence
of regular gauge and the exact change under 6.2.

Construct the algebraic affine Segre model of this connection-data quotient,
and the holomorphic map
$`\mathrm{RH}_t:U_t^{\mathrm{an}}\to\mathcal R_t^{\mathrm{an}}`$.
Prove the reconstruction theorem and biholomorphism under the displayed
hypotheses. On the omitted matrix-chart curve, use the compatible
modified-bundle/presentation chart and prove that reconstruction agrees on
overlaps. Prove compatibility with the time map and the specified identification
of the connection-data targets at $`t`$ and $`qt`$.

This target includes the analytic $`q`$-difference and Birkhoff factorization
theory needed for that proof. The analytic-space supplier gives the carriers
and analytification laws, not the $`q`$-Riemann–Hilbert theorem.
No algebraic isomorphism between the phase and the affine Segre surface is
inferred from the biholomorphism.

*Needs:* 0.3, 3.5's scalar theta foundation, 6.1–6.3 and the analytic suppliers.
*Sources:* [ORS]; [JR25, (2.1)–(2.2), Remark 2.6, Proposition 3.3].

<a id="layer-7"></a>
## Layer 7: Elliptic Painlevé

### 7.1 The elliptic linear data

Use the two-quotient genus-one data of 3.5 with rank-two $`V_0,V_1`$.
For the elliptic dynamical benchmark require the translation $`\tau`$ to
have infinite order. In the multiplicative uniformization this means
$`q^n\notin p^{\mathbb Z}`$ for every nonzero integer $`n`$.
Specify a determinant section with eight ordered simple zeros $`u_0,\ldots,u_7`$,
the compatible determinant-line isomorphism, and the reference normalization
needed for each modification. Kernel/image flags are data of the moduli object,
not all fixed as base parameters. In the [OR] chart the five kernel lines at
$`u_0,\ldots,u_4`$ vary; the three images at $`u_5,u_6,u_7`$ are fixed to
three distinct framing lines, and quotient by the right $`\operatorname{PGL}_2`$
removes three of the five kernel parameters.
In the trivial-bundle chart take $`\deg L=4`$, so that
$`\det B`$ is a section of $`L^2`$. The divisor identity
$`L^2\simeq\mathcal O_Q(\sum u_i)`$ is part of the input.

Construct the stack of these coherent presentation objects and its domain
of equivalence with operator-sheaves via 3.3. Prove its comparison with the
twisted reflection connection, retaining $`\iota_0`$-descent and the line $`T`$.
Determine its numerical class from the resolution. Give the explicit
normalization to the primitive stable model when it is used; dimension two
and eight determinant zeros are not sufficient to identify a moduli problem.

Over $`\mathbb C`$, choose $`0<|p|<1`$ and
$`Q=\mathbb C^\times/p^{\mathbb Z}`$.
Prove the theta presentation of the sections, the line-multiplier/determinant
balancing law, and the comparison with
```math
A(z)=B\!\left(\frac{\eta}{qz}\right)^{-1}B(z).
```
Interpret all factors as maps of their actual line bundles. Using the
scalar theta theory of 3.5, build the degree-four section/interpolation dictionary
and the addition identity used in [OR, (2.7)] and [KNY, §5].
Prove directly the polynomial and Laurent-polynomial counterparts of that
identity used for the additive and multiplicative tau formulas; these
scalar identities do not depend on the surface degeneration of Layer 9.

*Needs:* 1.2, 3.3, 3.5, 4.1–4.2; [ComplexTori](../ComplexTori/README.md),
Milestones 1–2; [ComplexManifolds](../ComplexManifolds/README.md), Milestone 7;
Mathlib's `NumberTheory.ModularForms.JacobiTheta.TwoVariable`
and algebraic genus-one/line-bundle foundations.
*Sources:* [OR, §§2–3, $`m=1`$]; [R25, §19.1].

### 7.2 The stable phase and its boundary

Construct the ordered operator blowup data associated with 7.1, and the
comparison with the $`r=d=1`$ stable phase of 4.4 after its explicitly proved
normalization. For the nonautonomous benchmark take the resulting parameter
$`w\in\operatorname{Pic}^0(Q)`$ to be nontorsion. Compute its dictionary with
the linear parameters and the normal-bundle period, and prove nonemptiness
of this admitted input class. Do not equate $`w`$ with the spectral shift
without that computation; the general theory of 4.4 also permits autonomous
specializations. Identify the resulting marked $`A_0^{(1)}`$ surface,
its smooth anticanonical $`D`$, its $`E_8^{(1)}`$ symmetry lattice, the
normal-bundle period, and its symplectic open phase. Prove the parameter
dictionary and the family comparison on each admitted parameter chart.

Relate the natural compactification of the trivial-bundle determinant chart
to this phase by actual blowups and boundary maps. A required calculation
explains why these compactifications differ. For $`W=H^0(Q,L)`$, prove
$`\dim W=4`$ and that
$`\operatorname{Sym}^2W\to H^0(Q,L^2)`$ is surjective with two-dimensional
kernel. For a generic fixed determinant section, the quadrics mapping to its
line form a projective plane; their two rulings give a double cover branched
over a quartic. The resulting smooth compactification is a degree-two del
Pezzo surface, with $`K^2=2`$. Construct the additional blowups needed for the
marked $`K^2=0`$ phase and identify their boundary meaning.

This check is part of the comparison proof. A two-dimensional quotient of
degree-four matrices is not identified with a Sakai surface solely by a
parameter count.

*Needs:* 2.1–2.3, 3.2–3.3, 4.1–4.4, 5.4, 7.1.
*Sources:* [R13, §9]; [OR, §5]; [R25, §§18.4, 19.6].

### 7.3 Elementary modifications and the elliptic time step

Construct the left and right elementary modifications using their prescribed
kernel/image conditions and reflection symmetries. In the theta presentation,
prove
```math
\lambda_l(E_{ij}B)=R_lB,\qquad
 \lambda_r(F_{ij}B)=BR_r,
```
```math
R_l(z)=R_l(\eta/(qz)),\qquad R_r(z)=R_r(\eta/z),
```
with a reference-point normalization away from their poles. Derive the full
change of the line bundle and determinant data, including the scalar
$`\lambda_l,\lambda_r`$. On determinant points the changes are
```math
E_{ij}:u_i,u_j\mapsto\frac{\eta}{qu_i},\frac{\eta}{qu_j},
 \qquad
 F_{ij}:u_i,u_j\mapsto\frac{\eta}{u_i},\frac{\eta}{u_j}.
```
Thus $`F_{ij}\circ E_{ij}`$ sends $`u_i,u_j`$ to $`qu_i,qu_j`$,
with the other data changed by the proved laws.

Prove the compatibility equation as a morphism between the actual twisted
bundles, retaining the rank-one correction if scalar factors change.
For $`(i,j)=(3,4)`$, the projective compatibility recovers the $`m=1`$
system of [OR, Theorem 5.3], with its stated normalization and relabeling.
Equality of projective equations,
or of Galois groups, does not assert equality of normalized
$`\mathrm{GL}_2`$ connection data.

Compute the marked Picard action and the precise elliptic time element.
Prove its equality with the geometric transport of 5.2 on a dense chart,
then extend it to the admitted full phases by 5.4. Construct the additional
generators and verify the full symmetry comparison specified in 5.3.

*Needs:* 0.1–0.3, 1.3, 3.5, 5.1–5.4, 7.1–7.2.
*Sources:* [OR, §§4–5]; [OR15, §6].

### 7.4 Coverage, changes of presentation, and Lax comparison

Construct the compatible ruled/presentation charts on explicitly specified
parameter domains and prove their coverage of the open stable phase
$`M^\circ\simeq X\setminus D`$ there, with 3.3's reconstruction conditions
verified on each. Record their remaining domains at effective-root walls;
coverage of every wall point is not inferred from the generic theorem.
Use sheaf-moduli charts to cover the compactification and its boundary.
Give the transition functors and their natural isomorphisms, the associated
regular coarse transitions, and the equality with the surface atlas.
Prove compatibility of the modification with every chart where its
operator interpretation is defined, and with its unique extended phase map.
Compare the resulting equation with the geometric elliptic Painlevé equation
of [KNY, §5.5], including the parameter change, chosen time element, and
the full scalar/twist dictionary for the Lax presentation.

**Required faithfulness check.** Let $`L=\pi_1^*\mathcal O_{\mathbb P^1}(2)`$
and let $`s_{ab},s_{cd},s_{ac},s_{bd}`$ be the pullbacks of quadratic sections
with the indicated pairs of zeros at four distinct unramified base points.
The two matrices
```math
B_1=\operatorname{diag}(s_{ab},s_{cd}),\qquad
 B_2=\operatorname{diag}(s_{ac},s_{bd})
```
have the same eight simple determinant zeros and both give $`A=I`$ in the
reflection formula. Their kernel-incidence patterns differ, so they are
not related by constant left/right changes of frame. Verify the example and
locate it outside the faithful reconstruction domain. The map $`B\mapsto A`$
is not asserted to be an equivalence on every reducible presentation.

The completed phase is the independently defined stable moduli of 7.2.
Changing a presentation is not a definition of stability, and the bare
translation connection on $`Q`$ does not classify its points.

*Needs:* 3.3–3.5, 4.1–4.4, 5.4, 7.1–7.3.

<a id="layer-8"></a>
## Layer 8: Dynamical and tau consequences

### 8.1 Degree growth and regular continuation

For a translation with nonzero class $`v`$ in $`\delta^\perp/\mathbb Z\delta`$,
compute the pullback of an ample class $`H`$ under every iterate. For the
fixed-marking comparison prove
```math
(t_{nv}H)\cdot H
      =H^2-\frac{n^2v^2}{2}(H\cdot\delta)^2.
```
Relate this to degrees of the resolved birational presentations and prove
quadratic degree growth and zero algebraic entropy. For an extended-Weyl time
whose power is a translation, derive the corresponding statements from that
power and the finite remainder. State the nontriviality and positivity
hypotheses; the zero translation is excluded. After specialization recheck
the Picard action and the degree comparison. An autonomous nontrivial
elliptic-surface translation can still have quadratic growth.

Use the full-phase transports of Layers 6–7 to prove regular continuation
of phase solutions. Compute the exceptional-curve images and the finite
singularity-confinement patterns in the chosen scalar charts, with the
parameter restrictions for each pattern. Regular phase continuation does
not imply that every trajectory returns to one preferred affine chart.

*Needs:* 0.2, 2.1, 5.2, 6.3, 7.3–7.4, and native real limit/logarithm theory.
*Sources:* [Sakai]; [KNY, §§3–5].

### 8.2 Determinants of relative cohomology

For proper perfect relative complexes arising from the universal-object and
reference-object constructions, build the determinant line by descent from
the supplied determinant functor. Prove base change, triangle/exact-sequence
compatibility, and coherence for composing modifications.
For a generically acyclic complex represented in degrees $`0,1`$ by
equal-rank vector bundles $`E^0\to E^1`$, define
```math
\lambda=(\det E^\bullet)^{-1}
        =\det E^1\otimes(\det E^0)^{-1},
 \qquad \tau=\det(d).
```
Prove independence of this presentation and identify its zero scheme.
For the effective-Cartier-divisor statement prove that the section is a
non-zero-divisor, as on the integral phase charts; in families prove the
required relative Cartier and flatness statements separately.
For a general perfect complex, distinguish the meromorphic acyclic
trivialization from a regular effective section.

Prove the effects of changing a universal family by a base line bundle and
of changing reference frames. A line with a section is the intrinsic output;
a scalar tau function requires the specified trivialization.
Euler characteristic zero alone does not prove the required two-term
amplitude or regularity of the section.

*Needs:* 4.2–4.4 and the determinant/coherent-cohomology suppliers.

### 8.3 Sakai tau sections and the moduli comparison

Construct the line bundles and canonical sections of actual relative
effective Cartier divisors on the surface family, indexed by their marked
classes, and the multiplicative line-bundle comparisons. For the exceptional
classes used in the tau formulas, prove uniqueness of the divisor on the
asserted locus. If $`h^0>1`$, retain the chosen section or linear-system member.
Construct the Picard-torus torsor on which a
compatible choice of frames makes these into scalar tau variables.
Prove the Weyl transformation laws and the elliptic, multiplicative, and
additive bilinear identities specified by [KNY, §§5.3, 5.7], using the
proved divisor-section relations and theta addition identities.
Keep the frame multipliers and their cocycles in the formulas.

Prove a precise comparison with 8.2. For an exceptional divisor $`E`$ and a
universal-kernel equivalence $`F:D^b(X)\simeq D^b(\mathscr S)`$, calculate
reference objects $`P_-=F(\mathcal O_X(-E))`$, $`P_0=F(\mathcal O_X)`$
and the map $`P_-\to P_0`$ in the actual operator model. For the universal
family $`M`$ of point images and the projection $`\pi`$ to its moduli base,
prove that the two relative Hom complexes are line bundles in degree zero
and that their induced two-term complex satisfies
```math
C_E=
 [\,R\pi_*R\mathcal Hom(P_0,M)\longrightarrow
       R\pi_*R\mathcal Hom(P_-,M)\,]
 \simeq [\,\mathcal O_X\longrightarrow\mathcal O_X(E)\,].
```
The map on the right is the canonical section of $`E`$.
Its inverse determinant is $`\mathcal O_X(E)`$, with the convention of 8.2.
Prove the statement for the marked exceptional generators in the two
benchmarks and transport it through the verified transformations.

The reference objects and map must also be computed from the operator
presentation, not merely named as the image of a desired answer.
This gives a comparison with chosen reference data; it does not assert a
canonical simultaneous scalar normalization of every tau identity or a
strict categorical Weyl action.

*Needs:* 2.1–2.3, 3.2, 4.2–4.4, 5.1–5.4, 6.3, 7.1–7.4, 8.2.

### 8.4 Effective-root walls and Riccati reductions

For the elliptic class $`\alpha_e=H_f-E_1-E_2`$, and the Jimbo–Sakai class
$`\alpha_q=H_f+H_g-E_1-E_3-E_5-E_7`$ in the marking of 6.3, together
with their admitted Weyl translates, construct the locus where the indicated strict transform is
an effective $`(-2)`$-curve disjoint from the anticanonical boundary.
Prove its period equation and its actual geometric realization; do not
deduce effectiveness from the abstract equality $`\alpha^2=-2`$.
For $`\alpha_e`$, the first two points lie on one ruling fiber.
For $`\alpha_q`$, verify the wall $`k_0k_t^{-1}k_1k_\infty=1`$ and the curve
$`fg-f/k_\infty-k_1g+k_0k_1t=0`$, on the domain where it is irreducible
and the marked points remain distinct. In the Jimbo–Sakai marking,
$`H_f-E_1-E_2`$ itself is a boundary component, not this symmetry root.
In particular require $`t\ne(k_0k_\infty)^{-1}`$ for irreducibility of
the displayed $`(1,1)`$-curve. This wall violates 6.3's finite non-splitting
conditions; construct its extension-object charts through the stable/geometric
quotient and verify how the affine coefficient invariant quotient contracts
the nonzero triangular-extension family.

For words carrying such a curve to the corresponding target curve, restrict
the phase transport and prove that it is a projective-linear map between
the two rational curves. Construct its rank-two linear lift, scalar
normalization, and the resulting Riccati recurrence. For the displayed
Jimbo–Sakai wall, verify
```math
g=\frac{f-k_t t}{k_\infty(f-k_1)},\qquad
 \bar g=qk_\infty\frac{f-k_t^{-1}t}{f-k_1^{-1}},\qquad
 \bar f=k_1\frac{\bar g-k_0qt}{\bar g-k_\infty^{-1}},
```
including the projective values, and prove preservation of the curve at
the shifted time. In the benchmark
presentation domains, compare the curve with the specified reducible or
extension objects and prove the intertwining with their elementary
modifications. Record any curve points absent from a chosen linear chart.

This constructs geometric Riccati reductions and their linear equations.
It does not assert that all special-function solutions, or all algebraic
solutions, have been classified.

*Needs:* 1.3, 2.1–2.3, 5.1–5.4, 6.3, 7.4.
*Source:* [KNY, §6].

<a id="layer-9"></a>
## Layer 9: Degeneration and differential comparison

### 9.1 Relative degeneration data

Construct one-parameter families of bimodules, ordered blowup centers,
local-type data, stability conditions, and modifications for the comparisons
in 9.2–9.3. Prove flatness and the needed base-change theorems at each level:
the operator algebra/category, the stable moduli, the marked phase pair,
and the chosen transport. These are separate statements.

Construct the specialization maps for numerical classes and periods, identify
the limiting boundary with its multiplicities, and compare determinant lines.
Prove that the specified finite-word modification correspondences extend over
the base on their stated domains. A flat family of curves alone does not imply
a flat family of stable moduli or convergence of the dynamics.

For the difference-to-differential step, construct the flat operator lattice
generated by $`1`$ and $`D=(T-1)/\varepsilon`$, with
```math
Df=\sigma_\varepsilon(f)D+
          \frac{\sigma_\varepsilon(f)-f}{\varepsilon}.
```
Prove its basis/flatness statement and the specialization
$`Df=fD+z\,df/dz`$ when $`\sigma_\varepsilon(z)=(1+\varepsilon)z`$.
Construct the module sector whose leading difference map is the identity
and prove its comparison with differential connections.
The naive special fiber of
$`\mathcal O_\Delta\oplus\mathcal O_{\Gamma_{\sigma_\varepsilon}}`$
is $`\mathcal O_\Delta^{\oplus2}`$; it is not this confluent operator
lattice. Neither a doubled correspondence nor a formal rescaling symbol
alone supplies the required flat construction.

*Needs:* 1.1–1.3, 2.1–2.3, 3.1–3.5, 4.1–4.4, 8.2.

### 9.2 Elliptic to multiplicative and additive $`E_8`$

Construct the smooth-to-nodal and smooth-to-cuspidal anticanonical families,
the compatible marked configurations and the fixed translation used in
[KNY, §5.6]. Prove the generalized-Picard specializations to
$`\mathbb G_m`$ and $`\mathbb G_a`$, the theta/rational coordinate limits,
and the resulting multiplicative and additive $`E_8^{(1)}`$ equations.
Prove compatibility of the period step, phase two-form after its required
rescaling, and the admitted finite-word transport.

Carry the bimodule and local-lattice presentation through the same
specialization on its reconstruction domain, checking the conditions of 3.3.
The targets have surface types $`A_0^{(1)*}`$ and $`A_0^{(1)**}`$.
They are not the $`A_3^{(1)}`$ Jimbo–Sakai surface: a change to that surface
would additionally require specified changes of centers, local type, and
time element.

*Needs:* 2.3–2.4, 3.5, 5.2, 7.1–7.4, 9.1.
*Sources:* [KNY, §5.6]; [R25, the relative operator constructions].

### 9.3 $`qP_{\mathrm{VI}}`$ to $`P_{\mathrm{VI}}`$

Construct the Dreyfus–Heu family with
$`\Theta_j(q)=1+(q-1)\theta_j/2`$, their modified phase coordinates, and
the eight moving centers on $`\mathbb F_2`$. Use their stated conditions
$`\theta_0\theta_1\theta_t\ne0,\ \theta_\infty\ne1,\ t\ne0,1`$
and the actual noncollision domains near $`q=1`$.
Prove the generic-fiber comparison with 6.3's geometric phase and the special-fiber
comparison with the additive $`D_4^{(1)}`$ Okamoto pair.
Retain the nonreduced limiting boundary.
These hypotheses do not imply the generic coefficient-chart conditions of
6.3. Restrict the matrix/linear comparison to the additional presentation
domain of 6.1–6.3, and use stable sheaf charts for the remaining phase
points. Prove each finite-step comparison on the domain of its explicit
resolved maps; the all-orbit exclusion in [DH, Proposition 4.4] is not
silently treated as one Zariski-open family.

After the specified scalar and bundle normalization of the linear problem,
write $`q=1+\varepsilon`$, $`A_\varepsilon=I+\varepsilon a+O(\varepsilon^2)`$.
Prove that
```math
\frac{Y((1+\varepsilon)z)-Y(z)}{\varepsilon}
       =a(z)Y(z)+O(\varepsilon)
```
limits to $`z\,dY/dz=a(z)Y(z)`$, with the four logarithmic local types,
determinant, and exponent dictionary computed. Establish the corresponding
limit of the time compatibility equation and identify its vector field with
the isomonodromic $`P_{\mathrm{VI}}`$ connection, including normalization of
the time coordinate and symplectic form.

The differential target is the independently constructed phase of
[PainleveEquationsAndFunctions][continuous]:
1.1–1.3 for the meromorphic-connection carrier and moduli,
3.1–3.12 for the rank-two classical phase and isomonodromic connection,
5.1–5.2 for its Okamoto compactification, and 7.1–7.2 for the scalar $`P_{\mathrm{VI}}`$
comparison. Prove the comparison with those objects; do not define the
differential phase to be the limit by fiat.

*Needs:* 6.1–6.3, 9.1, the cited continuous targets, and the analytic suppliers.
*Source:* [DH, §§3.3, 4.2–4.3, especially Proposition 4.4 and (67)].

### 9.4 Convergence of discrete phase trajectories

Prove a finite-chart discrete-to-continuous convergence theorem on the real
mesh $`q=e^h,\ h>0,\ s_n=nh\in[0,S],\ t_n=t_0e^{s_n}`$.
Use the common phase-family charts constructed in 9.3; their phase coordinates
may be complex. In each chart write the phase update as
```math
T_h(s,x)=x+hV(s,x)+r_h(s,x),\qquad
 \|r_h(s,x)\|\leq Ch^2,\qquad
 \|D_xT_h(s,x)\|\leq1+Lh.
```
State the uniform bounds on $`V`$ and its derivatives in a compact
trajectory tube, the positive no-exit margins, and the bounds for chart
transitions. Prove a discrete Grönwall estimate and finite-chart no-exit
theorem from these hypotheses, then verify them for the rescaled transport
of 9.3. Convergent initial phase points give uniform convergence to the
limiting horizontal solution on the mesh; piecewise chart interpolants have
the same limit. Prove an $`O(h)`$ error bound when the initial error is
$`O(h)`$. The rescaled defect is $`O(h)`$, while the one-step error above
is $`O(h^2)`$.

Prove compatibility with changes of phase charts and convergence of observations
where they are defined; use projective target charts at poles.
This is stronger than coefficientwise convergence of a displayed recurrence.
It does not assert convergence of the analytic Riemann–Hilbert maps or their
connection constants.

*Needs:* 0.2–0.3, 9.3, the continuous roadmap's local-flow/finite-chart theory
(0.2–0.3, 0.9), and native finite-dimensional normed-space estimates.

## Completion criteria

A layer is discharged by the constructions, laws, comparisons, and examples in
its numbered targets. The two complete examples must expose the same reusable
interfaces; a separate collection of coordinate identities for each example
does not discharge their shared theory.

In particular, a claimed complete comparison includes the underlying family
functors, scalar descent, the full stable phase, its marked boundary and period,
the time element and its actual domain, and agreement of the coordinate
presentation. The following are necessary verification cases:

| Case | Required distinction |
|---|---|
| Rational gauge $`g=z`$ | Generic-module isomorphism versus regular lattice isomorphism |
| Polynomial Jimbo–Sakai matrices | $`U_t\setminus E_8^\circ`$ versus the full $`U_t`$ |
| Degree-four elliptic determinant chart | Its $`K^2=2`$ compactification versus the $`K^2=0`$ phase |
| Two reducible $`B`$-presentations with $`A=I`$ | Presentation data versus a bare reflection matrix |
| Maximal lattice under specialization | Relative reconstruction versus fiberwise saturation |
| Tensoring the $`I_2`$-fiber sheaf | Simple-object operations versus preservation of stability |
| The boundary period | $`\operatorname{per}(\delta)`$ versus passage to the root-lattice quotient |
| A scalar gerbe | Stack, rigidification, universal-family normalization, and coarse space |
| A finite Hecke word | Its algebraic domain versus all-iterate orbitwise conditions |
| A degeneration | Operator, moduli, phase transport, and analytic limits as separate theorems |

The three admitted theorem proofs in Suggested.lean are interface prototypes.
Their elaboration establishes that those signatures use existing types and
conventions; it does not establish the geometric or moduli targets above.

## Primary references

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
- **[JS]** M. Jimbo, H. Sakai, *A $`q`$-analog of the sixth Painlevé equation*,
  Letters in Mathematical Physics **38** (1996), 145–154.
  [Author manuscript](https://arxiv.org/abs/chao-dyn/9507010).
  The polynomial problem and its time compatibility are the normalization
  source for 6.1–6.2.
- **[VdB]** M. Van den Bergh, *Non-commutative $`\mathbb P^1`$-bundles over
  commutative schemes*, Transactions of the AMS **364** (2012), 6279–6313.
  [Author manuscript](https://arxiv.org/abs/math/0102005).
  Use the adjoint-bimodule $`\mathbb Z`$-algebra construction and its hypotheses.
- **[R13]** E. M. Rains, *Generalized Hitchin systems on rational surfaces*.
  [Author manuscript](https://arxiv.org/abs/1307.4033).
  §2 supplies the symmetric-equation/lattice construction; §9 describes the
  elliptic determinant-chart geometry. Relative reconstruction hypotheses
  remain explicit targets here.
- **[OR15]** A. Okounkov, E. Rains, *Noncommutative geometry and Painlevé
  equations*, Algebra & Number Theory **9** (2015), 1363–1400.
  [Article PDF](https://msp.org/ant/2015/9-6/ant-v9-n6-p03-p.pdf).
  §6 supplies the geometric moduli and Hecke-translation comparison, including
  the additional operation beyond the $`A_8`$ translations.
- **[R16]** E. M. Rains, *The noncommutative geometry of elliptic difference
  equations*. [Author manuscript](https://arxiv.org/abs/1607.08876).
  Use its sheaf-moduli construction and Theorem 11.3's Poisson statement
  with their assumptions.
- **[OR]** C. M. Ormerod, E. M. Rains, *An elliptic Garnier system*.
  [Author manuscript, v2](https://arxiv.org/abs/1607.07831v2).
  §§2–4 and §5, Theorem 5.3, supply the reflection presentation, elementary
  modifications and the $`m=1`$ elliptic Painlevé comparison. Scalar factors
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
  for the Jimbo–Sakai family of $`q`$-difference equations*,
  Annales de la Faculté des Sciences de Toulouse **29** (2020), 1119–1250.
  [Article PDF](https://www.numdam.org/item/10.5802/afst.1659.pdf).
  Use the analytic connection-data and quotient construction.
- **[JR25]** N. Joshi, P. Roffelsen, *On the Crystal Limit of the
  $`q`$-Difference Sixth Painlevé Equation*, Journal of Nonlinear Science
  **35** (2025), article 31.
  [Article](https://doi.org/10.1007/s00332-024-10124-5).
  Only the stated nonzero-$`q`$ results are used: (2.1)–(2.2), Definitions 2.1–2.2,
  Lemma 2.5, Remark 2.6 and Proposition 3.3. The crystal-limit theorem is not
  substituted for a $`q\to1`$ theorem.
- **[DH]** T. Dreyfus, V. Heu, *Degeneration from difference to differential
  Okamoto spaces for the sixth Painlevé equation*.
  [Author manuscript](https://arxiv.org/abs/2005.12805).
  §§3–4 specify the modified coordinates, blowup family, and differential limit.
  Trajectory convergence in 9.4 is a separately proved consequence with its
  own uniform estimates.

[continuous]: https://github.com/yuma-mizuno/TauCetiRoadmap/blob/f5b41b49f8770b6c678b8bca87524259e54b6c74/TauCetiRoadmap/PainleveEquationsAndFunctions/README.md
[complex-comparison]: https://github.com/TauCetiProject/TauCetiRoadmap/blob/654c956cf2e193efd94e91816658b2fcd1ffb8d8/TauCetiRoadmap/ComplexComparisonPartII/README.md
