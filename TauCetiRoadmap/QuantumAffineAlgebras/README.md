# Roadmap: quantum enveloping algebras, part II: affine representations and monoidal categorification

**Summary.** Build the finite-dimensional integrable representation theory of
quantum affine algebras of every affine type over a generic parameter field.
Starting from the full-root-datum quantum enveloping algebra, construct the
derived algebra and its level-zero representation category, spectral families,
fundamental representations and the classification of simple objects. Construct
rational R-matrices and their nonzero specializations, the commutative exact
Grothendieck ring, and the tensor-product theory of real simple objects. The
endpoint is the monoidal-categorification predicate of Kashiwara–Kim–Oh–Park
on these actual categories, together with monoidal seeds and categorical
exchange relations. The principal theorems are level zero, fundamental-module
existence and classification, rational R-matrix existence, the simple-class
basis, Grothendieck-ring commutativity and polynomial presentation, the
real-simple head and socle theorem, pairwise tensor simplicity, local exchange
reality, and the comparison of categorical and algebraic
mutation.

## Scope and ownership

This is the affine representation-theory continuation of
[QuantumEnvelopingAlgebras](../QuantumEnvelopingAlgebras/README.md). Its
§§0.1, 1.0–1.5 and 2.1 own the datum, intrinsic quantum algebra, full torus,
Hopf structure, triangular decomposition, Serre presentation, Borel pairing and
braid operators. Specialize those objects; do not introduce a second quantum
enveloping algebra. The subalgebra without the degree direction, its central
quotient, the finite-dimensional affine category, spectral families, normalized
fundamental modules and R-matrices are owned here. Both untwisted and twisted
affine types, including A₂ₙ⁽²⁾, are included.

[QuantumGroups](../QuantumGroups/README.md) §8.5 owns the finite Hopf-module
category and its tensor and duality structures.
[GrothendieckEulerForms](../GrothendieckEulerForms/README.md) §§1.1–1.4 and 2.3
own Grothendieck groups, bilinear descent and the abelian presentation. The additional simple-class
basis here applies to finite-dimensional modules over an algebra that need not
be Artinian; it is not the Artinian-ring theorem of its §4.1.
[ClusterAlgebras](../ClusterAlgebras/README.md) §§1.1–1.4 and 2.3 own ordinary
geometric seeds, polynomial frozen coefficients, and locally finite classical
patterns. No cluster-algebra construction is repeated here.

The affine extremal modules and the supporting results needed to construct
fundamental modules are targets of Layer 4. They do not presume a general
quantum crystal or global-basis library. General integrable category O, path
crystals, integral forms and root-of-unity representation theory retain their
own scopes. Drinfeld presentations and highest-ℓ-weight arguments may be used
inside the proof of the classification target; a separate API for all their
generators is not an exported endpoint of this roadmap.

The endpoint concerns an ordinary commutative cluster algebra. The quantum
parameter of the algebra does not give the representation category a grading.
Graded quiver Hecke categorification, quantum affine Schur–Weyl duality, numerical
Λ-invariants, affine determinantial modules, and proofs that specified
Hernandez–Leclerc categories categorify specified cluster algebras are outside
this scope. Layer 9 states exactly the data and properties those applications
must supply.

## Conventions

The Cartan matrix is indecomposable and affine, with finite nonempty vertex set
I, entries aᵢⱼ = ⟨hᵢ,αⱼ⟩, primitive positive marks aᵢ and comarks cᵢ, and a fixed
positive integral symmetrizer dᵢ. Use the full affine weight datum with fundamental
weights Λᵢ, primitive null root δ = Σᵢaᵢαᵢ, primitive central coroot
c = Σᵢcᵢhᵢ, and classical weight lattice Pcl = P/ℤδ. The kernel and primitivity
conditions making this quotient valid are part of §1.1. Choose the affine node
0 with a₀ = 1, taking the long node in A₂ₙ⁽²⁾, and put I₀ = I∖{0}.

Let k be the algebraic closure of ℂ(q) inside the complex Puiseux-series field,
with q transcendental. Put qᵢ = q raised
to dᵢ. In particular every quantum factorial used in a divided power is nonzero.
Sources that normalize root lengths by (δ,λ) = ⟨c,λ⟩ have symmetrizer cᵢ/aᵢ.
To compare with them, put r = aᵢdᵢ/cᵢ, independent of i, and replace their
parameter by q raised to r, so that each qᵢ agrees. The spectral period mᵢ is
specified by a Weyl orbit, not identified with the symmetrizer dᵢ.

All modules are left modules and all unadorned tensor products are over k.
Retain the supplier coproduct on Eᵢ,Fᵢ,Kᵢ. The source generators are
`e_i = E_i K_i^-1`, `f_i = K_i F_i`, with the same Kᵢ; thus

```
Δ(e_i) = e_i ⊗ K_i^-1 + 1 ⊗ e_i,
Δ(f_i) = f_i ⊗ 1 + K_i ⊗ f_i,
S(e_i) = −e_i K_i,       S(f_i) = −K_i^-1 f_i.
```

Write DₛM for the contragredient using S and DᵢM for that using S⁻¹.
Their evaluations have domains DₛM⊗M and M⊗DᵢM, respectively. These are the
native right and left duals of `FiniteHopfModuleCat`; KKOP calls the same
objects the left and right dual, respectively. Evaluation domains, rather than
these names, determine every comparison.

A simple object is nonzero. Grothendieck groups impose short-exact-sequence
relations, including nonsplit ones. Frozen variables are not inverted.
Cluster monomials have nonnegative, finitely supported exponents, including at
frozen vertices. The final predicate uses the KKOP convention: a specified
ring isomorphism sends every cluster monomial to a real simple class. No
converse about all real simple objects is imposed.

## Exact supplier contracts

### From Mathlib

- `ModuleCat`, `ModuleCat.restrictScalars`,
  `CategoryTheory.ObjectProperty.FullSubcategory`, `CategoryTheory.Abelian`,
  `CategoryTheory.Simple` and `CategoryTheory.EssentiallySmall`: the native
  category, subcategory, exactness, simplicity and size notions.
- `TensorProduct`, `LinearMap`, `Module.Dual`, `Module.Finite`, `FiniteDimensional`,
  `Submodule`, `IsNoetherian`, `IsArtinian` and `CompositionSeries`:
  algebraic module operations and finite-length inputs.
  `isNoetherian_of_tower` in `RingTheory/Noetherian/Basic.lean` and
  `isArtinian_of_tower` in `RingTheory/Artinian/Module.lean` pass finite length
  from a scalar field to an algebra action. `IsFiniteLength` is a proposition,
  not a typeclass.
- `LaurentPolynomial`, `LaurentPolynomial.eval₂`, `Polynomial`, `RatFunc`,
  `Localization.AtPrime`, `PowerSeries` and `LaurentSeries`: the scalar
  carriers for spectral families, local lattices and formal intertwiners.
- `Algebra.adjoin`, `RingQuot`, `AlgHom`, `AlgEquiv`, `AddMonoidAlgebra` and
  finitely supported functions: subalgebras, quotients, comparison maps and
  graded constructions. A new mathematical structure is installed on these
  carriers only after its defining laws are proved.

### From Tau Ceti

- `TauCeti.FiniteHopfModuleCat` in
  `Algebra/Category/FiniteHopfModuleCat/Basic.lean` is the full subcategory of
  algebra modules finite-dimensional over the scalar field; the carrier itself
  needs only an algebra, despite its name. Its `incl`, `ofShrink` and
  `ofShrinkEquiv` provide inclusion and universe comparison. `Monoidal.lean`
  supplies tensor through a bialgebra coproduct. `RightRigid.lean` supplies
  `dual` and its evaluation; `Rigid.lean` supplies `leftDual` and
  `rigidCategory` with an explicit proof that the antipode is bijective.
- `TauCeti.AbelianK0` and `TauCeti.AbelianK0.of_shortExact` in
  `CategoryTheory/GrothendieckGroup/Abelian.lean`: the native exact Grothendieck
  group of an essentially small abelian category.
  `TauCeti.ExactK0.instRing`, `TauCeti.ExactK0.of_mul_of`,
  `TauCeti.ExactK0.liftRingHom` and `TauCeti.ExactK0.mapRingHom` in
  `CategoryTheory/GrothendieckGroup/Monoidal/Exact.lean` supply the ring and its
  functoriality for a biexact monoidal category. Its braided-category
  commutativity instance is not an input here.
- `TauCeti.jordanHolderMultiplicity` in
  `RingTheory/CompositionSeries/Multiplicity.lean` and
  `TauCeti.jordanHolderMultiplicity_eq_add_of_exact` in
  `RingTheory/CompositionSeries/Additivity.lean` apply to finite-length modules
  over an arbitrary ring. `ModuleCat.prop_of_isFiniteLength` in
  `Algebra/Category/ModuleCat/FiniteLength.lean` supplies induction through
  simple objects and short exact sequences. Layer 6 descends these actual
  multiplicities; it does not rebuild Jordan–Hölder theory.

### From TauCetiRoadmap.QuantumEnvelopingAlgebras

Consume §§0.1 and 1.0–1.3a for the full datum, intrinsic generic algebra, Hopf
structure, triangular decomposition and Serre comparison; §§1.4–1.5 for the
homogeneous nilpotent/Borel pairings; and §2.1 for braid operators. The completed
canonical element and its affine spectral action are new targets in §5.1.

### From TauCetiRoadmap.KacMoody

Consume §§0.1–0.3 for the realization, lattices and root-annihilating directions,
and §2.1 for its Weyl group. Section 1.1 here supplies the affine null directions,
finite classical Weyl group and translations. No quantum crystal statement is
imported from a classical path-crystal construction.

### From TauCetiRoadmap.QuantumGroups

Consume §8.5 only for the general finite Hopf-module category and tensor/dual
interfaces just listed. Its complex rank-one algebra is not substituted for
the generic-parameter affine algebra. The weight-string identities in §2.1 are
proved on the rank-one subalgebras of the latter over k.

### From TauCetiRoadmap.GrothendieckEulerForms

Consume §§1.1–1.4 for generators, relations, choice independence and bilinear
descent, and §2.3 for abelian Grothendieck groups. No Artinian-ring or semisimplicity hypothesis is
added to the quantum affine algebra.

### From TauCetiRoadmap.ClusterAlgebras

Consume §§1.1–1.4 for column matrix mutation, ordinary geometric seeds,
finite-word patterns and their cluster algebras with the chosen frozen inverse
set empty. Section 2.3's locally finite classical patterns supplies the extension
to arbitrary mutable index sets with finite column supports. Restrict to
countable indices and skew-symmetric principal part for the KKOP interface.
The cluster-algebra ring realization is supplied by §§1.3 and 1.6; the
categorical lift and its comparison are constructed in Layer 9.

## How to read the build

Layers 1–3 construct the algebra, the actual finite-dimensional category and
spectral families. Layer 4 constructs the fundamental objects and the spectral
classification needed to normalize intertwiners. Layer 5 passes from a completed
universal intertwiner to rational and specialized R-matrices. Layer 6 forms exact
Grothendieck rings and proves their commutativity by specialization of invariant
lattices. Layer 7 develops real simple tensor products. Layer 8 constructs
natural Serre tensor subcategories, and Layer 9 supplies categorical seeds and
the precise categorification predicate. Neither classification in Layer 4 nor
rationality in Layer 5 assumes Grothendieck-ring commutativity.

## Layer 1: affine lattices and the derived quantum algebra

### 1.1 Null directions, classical weights and basic weights

Specialize the supplied root datum to affine type. Construct the primitive
positive vectors a and c satisfying Aa = 0 and cᵀA = 0, and prove that the
root-annihilating directions are exactly ℤδ and ℤc. Use the full weight datum
with P = (⊕ᵢℤΛᵢ) ⊕ ℤδ and its dual, so that Pcl identifies with the integral
simple-coroot eigenvalue lattice. Define level by ⟨c,λ⟩ and Pcl⁰ as its kernel.
Construct the finite classical Weyl group and the translation subgroup of the
affine Weyl group (K02 §4.1, pp.11–17; KKOP20 §2.1, pp.5–6).

For i∈I₀ put `π_i = (c_0 Λ_i − c_i Λ_0)/gcd(c_0,c_i)` and ϖᵢ = cl(πᵢ).
Prove these are a basis of Pcl⁰. Define a basic level-zero weight to be one whose
classical Weyl orbit contains a fundamental level-zero weight constructed using
a node 0∨ with c₀∨ = 1 and whose remaining reflections generate the classical
Weyl group. Prove independence of this auxiliary node and that each πᵢ is basic.
Define mᵢ as the positive generator characterized by
`Wπ_i ∩ (π_i + ℤδ) = π_i + m_iℤδ`, and prove its existence
(K02 §5.2, (5.3), (5.6), pp.19–24; KKOP22 §2.2, pp.12–13).

The API includes:

- the quotient map, its kernel, the weight/coroot pairing after quotient, and
  extensionality from all simple-coroot pairings;
- the action of each simple reflection, the finite classical action and the
  translation formula, including its dependence on level;
- the inclusion of Pcl⁰, its fundamental basis, and invariance of the basic
  condition and period under a Weyl change of representative.

**Checks.**

- In A₁⁽¹⁾, a = c = (1,1), π₁ = Λ₁−Λ₀ and m₁ = 1; the class of δ is zero
  while δ is a nonzero element of P.
- In A₂⁽²⁾ with long node 0, `A = ((2,−1),(−4,2))`, a = (1,2), c = (2,1),
  π₁ = 2Λ₁−Λ₀, and s₁s₀π₁ = π₁+δ. Thus m₁ = 1. The expression
  Λ₁−Λ₀ has level −1 and cannot replace π₁.
- In A₁⁽¹⁾, the nonidentity translation t=s₁s₀ satisfies
  `cl(tⁿΛ₀)=(1+2n)cl(Λ₀)−2n cl(Λ₁)`, so its iterates are distinct.
  On level zero, t fixes the classical class. Quotienting by c rather than
  δ would fail this comparison.

*Needs:* KacMoody §§0.1–0.3 and 2.1; the supplied full lattice pairing.

### 1.2 Derived subalgebra and the level-zero quotient

Inside the supplied U define U′ as the subalgebra generated by Eᵢ,Fᵢ,Kᵢ and
Kᵢ⁻¹, for i∈I. Use triangular decomposition to identify its toral lattice as
the span of dᵢhᵢ and prove that the inclusion is injective. Restrict the Hopf
structure and prove that the antipode is bijective. The generator change in the
Conventions gives an isomorphism with the eᵢ,fᵢ presentation and the source
coproduct; it changes neither the underlying algebra nor its tensor theory
(KKOP20 Definition 2.2 and (2.2), pp.6–7; QEA §§1.1–1.3a).

The central group-like element used here is `C = ∏_i K_i^(a_i)`.
Since aᵢdᵢ = rcᵢ, it is q raised to rc in the full torus; it need not be the
primitive full-torus element q raised to c. Construct U⁰ = U′/(C−1) as a Hopf
quotient. Prove its universal property and the equivalence between U⁰-modules
and U′-modules on which C acts as 1. The center is retained in U′. The name
quantum loop algebra refers to this central specialization with the stated
toral convention, not to a quotient that also kills the affine generators.

The API includes:

- restriction of scalars along U′→U and inflation along U′→U⁰, with identity,
  composition and the corresponding action formulas;
- coproduct, counit and both antipodes on every generator, and verification that
  the ideal generated by C−1 is a Hopf ideal;
- comparison with the supplier presentation and a generating-family
  extensionality principle for maps out of U′ and U⁰.

**Checks.**

- In A₁⁽¹⁾, C = K₀K₁. In the module V(a) defined in the worked example,
  K₀ = K₁⁻¹, so C acts as 1 while e₀ is nonzero.
- In A₂⁽²⁾ with d = (4,1), C = K₀K₁² = q raised to 2c; replacing it by
  K₀²K₁ would give a noncentral toral element.
- The generator adapter gives
  `Δ(E_i K_i^-1) = E_i K_i^-1 ⊗ K_i^-1 + 1 ⊗ E_i K_i^-1`.
  The unchanged choice eᵢ = Eᵢ gives a different coproduct.

*Needs:* §1.1; QuantumEnvelopingAlgebras §§1.1–1.3a for the algebra and Hopf
structure; native subalgebra and quotient APIs.

### Examples

A₁⁽¹⁾ tests the surviving affine generator and the removed central level.
A₂⁽²⁾ tests the separation of null-root marks, central comarks and symmetrizer.
Finite-type Cartan matrices and an empty vertex set fail the affine hypotheses.

### Dependencies

KacMoody §§0.1–0.3 and 2.1; QuantumEnvelopingAlgebras §§0.1 and 1.0–1.3a.

## Layer 2: finite-dimensional integrable modules

### 2.1 Type-1 weights and finite-dimensionality

For a U′-module M, define the λ-weight space by
`K_i m = q_i^⟨h_i,λ⟩ m` for every i. Type 1 means that these subspaces, indexed
by Pcl, form an internal direct sum equal to M. Integrability means, in addition,
local nilpotence of every eᵢ and fᵢ. Define 𝒞 as the full subcategory of
`TauCeti.FiniteHopfModuleCat k U′` with this property. Prove that for a
finite-dimensional type-1 module the local-nilpotence conditions follow from
finite weight support. This identifies the definition with KKOP's
finite-dimensional integrable category (KKOP20 §2.1, p.7; AK97 §1.1, pp.3–4).

Prove the rank-one divided-power string identities on each i-restriction over
k. In particular, if eᵢv = 0 and Kᵢv = qᵢⁿv, then
`e_i f_i^(r) v = [n−r+1]_i f_i^(r−1) v` for r≥1. Use the finite strings to
prove Weyl invariance of weight multiplicities. This is the weight theory of
these restrictions, with the field and generators just specified, rather than
an appeal to the complex rank-one carrier.

The API includes:

- weight-space membership, uniqueness and finite support; morphisms preserve
  weights, and eᵢ,fᵢ shift them by cl(αᵢ),−cl(αᵢ);
- closure under submodules, quotients, finite direct sums and isomorphisms;
- the faithful exact forgetful maps and agreement of categorical simplicity
  with `IsSimpleModule` for the underlying U′-module.

**Checks.**

- The zero module has empty weight support and belongs to 𝒞, but is not simple;
  the unit has only weight 0 with multiplicity 1.
- V(a) in type A₁⁽¹⁾ has weights ϖ₁ and −ϖ₁, each of dimension 1, and e₁,f₁
  each square to zero.
- The one-dimensional representation with all Kᵢ = −1 and eᵢ = fᵢ = 0
  satisfies the algebra relations but is not type 1: −1 is no integral power
  of a transcendental qᵢ.
- For a highest vector of i-weight 2, the r = 1 string coefficient is
  `[2]_i = q_i+q_i^-1`; for i-weight 0 it is 0. This detects ordinary
  integers substituted for quantum integers.

*Needs:* Layer 1; the native finite-module category, internal direct sums and
submodule APIs; QuantumEnvelopingAlgebras §1.3a for the rank-one relations.

### 2.2 Level zero and finite length

Prove that every weight of every object of 𝒞 has level zero. Weyl invariance
from §2.1 and the translation formula of §1.1 would otherwise give infinitely
many weights. Deduce that C acts as 1 and that inflation identifies 𝒞 with the
type-1 finite-dimensional integrable category of U⁰. The quotient comparison is
a conclusion, not an extra hypothesis (AK97 §1.2, p.5).

Prove finite length using scalar finite-dimensionality and the native
Noetherian/Artinian tower theorems. Construct the abelian structure from kernels
and cokernels inherited from modules; compute images, coimages and exact
sequences through the forgetful functor. Prove essential smallness by replacing
a finite-dimensional carrier by k to a finite power and recording its action.
A one-dimensional object of 𝒞 is the unit: the commutator relations force
Kᵢ² = 1, and type 1 forces Kᵢ = 1.

**Checks.**

- The unit has level 0 and length 1; the zero object has level 0 and length 0.
- V(a) has dimension 2 but length 1. Dimension is a bound on length, not its
  definition.
- A nonzero positive-level integrable highest-weight module cannot be an
  object of 𝒞; its Weyl orbit already contradicts finite support.

*Needs:* §§1.1–1.2 and 2.1; native finite-length and module-category APIs.

### 2.3 Biexact tensor products and duality

Restrict the native Hopf-module tensor structure to 𝒞. Prove its weight formula,
closure under tensor product, and exactness in each variable. Restrict Dₛ and
Dᵢ, prove exact contravariance, evaluation/coevaluation, the triangle identities
and the tensor-dual comparison with reversed factors. Establish the
anti-equivalences DₛDᵢ ≅ Id and DᵢDₛ ≅ Id. A double use of the same dual twists
the action by S² or S⁻² and is not identified with the identity without an
additional intertwiner (KKOP20 §2.1, p.8; QuantumGroups §8.5).

The API includes:

- `(M⊗N)_λ = ⊕_(μ+ν=λ) M_μ⊗N_ν` and weights of either dual obtained by
  negation;
- the exact tensor bifunctor, tensor unit, associator, unitors and the
  forgetful monoidal functor on the actual subcategory;
- evaluation domains DₛM⊗M and M⊗DᵢM, and natural adjunction isomorphisms
  pinned by those domains rather than a left/right naming convention.

**Checks.**

- V(a)⊗V(b) has weight multiplicities 1,2,1 at 2ϖ₁,0,−2ϖ₁ and dimension 4.
- For a functional φ and vector v, evaluation of φ⊗v is φ(v); using the
  untwisted dual action would fail U′-linearity already for e₁.
- On source generators, `S²(e_i)=q_i^-2 e_i` and `S²(f_i)=q_i^2 f_i`.
  The identity map on V(a) does not identify this twist with its original
  action when eᵢ acts nontrivially.

*Needs:* §§1.2 and 2.1–2.2; QuantumGroups §8.5 and the native finite
Hopf-module monoidal/rigid structures; exactness of tensor over a field.

### Examples

The two nonsplit four-dimensional modules in the worked example separate this
abelian rigid category from a semisimple category. Their tensor product and
duals remain objects of the same category.

### Dependencies

Layer 1; QuantumGroups §8.5; native module, finite-dimensional and abelian APIs.

## Layer 3: spectral families and specialization

### 3.1 Spectral shifts as tensor autoequivalences

For a∈k× define the Hopf automorphism τₐ by
`e_i ↦ a^δ(i,0)e_i`, `f_i ↦ a^-δ(i,0)f_i`, and Kᵢ↦Kᵢ.
Let M(a) be restriction of its action along τₐ. Prove τ₁ = Id and
τₐτᵦ = τₐᵦ and obtain exact tensor autoequivalences of 𝒞. Tensor and either dual
commute with the same simultaneous shift. These constructions extend to any
field extension and nonzero parameter there (AK97 §1.2, pp.4–5; KKOP20 §2.1,
p.7).

The API includes:

- generator action formulas, naturality on intertwiners, unit and composition
  comparisons, and inverse shift a⁻¹;
- tensor comparison `(M⊗N)(a) ≅ M(a)⊗N(a)`, with coherence;
- compatibility with both dual actions and with scalar extension.

**Checks.**

- On the evaluation module V(b), shifting by a gives V(ab), since e₀ acts
  by ab times f₁.
- M(1) has the original action; two shifts a,b give ab, not a+b.
- At a = 0 the formula for f₀ is undefined; no zero specialization is part
  of this autoequivalence family.

*Needs:* §§1.2 and 2.3; the algebra's homogeneous Serre relations.

### 3.2 Affinization and scalar extensions

Construct the intrinsic P-graded affinization of a Pcl-weight module by taking
one copy of Mcl(λ) in each λ∈P, with the root-shifting eᵢ,fᵢ actions. Its
U′-linear degree-δ automorphism z is the identity between corresponding copies.
A section of P→Pcl with the source root convention identifies it with
k[z,z⁻¹]⊗M. Compare different sections by their weightwise powers of z.
Construct the canonical specialization quotient by z−a and identify it with
M(a) (KKOP20 §2.1, p.7; K02 §4.2, p.16).

The API includes:

- finite freeness over k[z,z⁻¹] of rank dim M and compatibility of the
  intrinsic and Laurent-coordinate actions;
- base change to k(z), k((z)), and the local ring at z = a≠0, with faithful
  comparisons where appropriate;
- the generator formulas and specialization maps; simultaneous tensor shifts
  use a shared spectral variable, whereas two independent affinizations use
  two variables before diagonal base change.

**Checks.**

- For the unit, affinization is k[z,z⁻¹], and its quotient by z−a is k of
  dimension 1; affinization itself is not a finite-dimensional object of 𝒞.
- V(b) has affinization free of rank 2; specialization at a gives V(ab),
  with e₀ coefficient ab.
- Independently shifting V(a) and V(b) by x and y gives parameters ax,by.
  Setting x=y=t gives the simultaneous tensor shift; setting only y=t does
  not shift the first factor.

*Needs:* §§1.1 and 3.1; native Laurent polynomials, localization and tensor
base change; the weight decomposition of §2.1.

### Examples

Spectral shifts distinguish infinitely many fundamental modules of A₁⁽¹⁾
although all have the same ordinary weight character. The two-variable family
records the ratio of their parameters.

### Dependencies

Layers 1–2; native scalar extension, Laurent polynomial and localization APIs.

## Layer 4: fundamental modules and simple spectral data

### 4.1 Extremal vectors and their universal modules

For an integrable P-weight module over the full U and u of weight λ, call u
extremal when there are vectors u_w of weight wλ, indexed by the affine Weyl
group, with u₁ = u and the following conditions for n = ⟨hᵢ,wλ⟩:

```
n ≥ 0:  e_i u_w = 0,   f_i^(n) u_w = u_(s_i w),
n ≤ 0:  f_i u_w = 0,   e_i^(-n) u_w = u_(s_i w).
```

The zero vector is allowed. Prove uniqueness and linearity of the family.
Construct E(λ) from a cyclic generator of weight λ with these linear relations,
and prove its integrability and its universal property: U-linear maps
E(λ)→M correspond to extremal vectors in Mλ. Equivalently, use generators
u_w and the displayed relations, proving that u₁ generates. This is an actual
quotient construction, not a chosen module assumed to have the desired
properties (K02 §3.1, (3.1)–(3.3), pp.8–9).

The API includes:

- the canonical extremal family, its behavior under intertwiners and the
  universal map with its uniqueness;
- Weyl transport E(λ) ≅ E(wλ), with the specified image of the cyclic vector;
- changes of a δ-lift and the comparison of full-U and derived-U′ actions.

**Checks.**

- For λ = 0, every eᵢ and fᵢ kills the cyclic vector, and E(0) is the unit.
- For n = 0 both conditions apply: eᵢu_w = fᵢu_w = 0 and u_sᵢw = u_w.
  Requiring only one of the two annihilations gives the wrong quotient.
- Along a rank-one string with n = 2, u_sᵢ = fᵢ²u/[2]ᵢ; replacing the
  divided power by fᵢ² changes the normalized extremal vector.

*Needs:* §§1.1–1.2 and 2.1's integrable weight-string theory, used for full
P-weights; QuantumEnvelopingAlgebras §§1.1–1.3a and 2.1; native algebra quotients.

### 4.2 Basic extremal-module structure

For every basic level-zero λ prove E(λ) is nonzero and simple as a full
U-module, has weights in `(λ+Q) ∩ conv(Wλ)`, has finite-dimensional weight
spaces, and has one-dimensional weight space at every point of Wλ. Prove that
an element stabilizing λ fixes its canonical extremal vector, and that
`wt(E(λ)) ∩ (λ+ℤδ)` is the δ-periodic part of Wλ. Also prove that every nonzero
integrable U-module generated by an extremal vector of this basic weight is
isomorphic to E(λ) (K02 Propositions 5.8, 5.15, 5.16, pp.21–24).

This target owns these structural conclusions, including the restricted
crystal/global-basis arguments if that proof route is chosen. In that route
construct the rank-one Kashiwara operators from the string decomposition, the
stable lattice at q = 0 and its crystal quotient for E(λ), and the bar-invariant
integral lift needed to prove the stated finite-weight and cyclicity conclusions
(K02 §§2.2–3.1 and 5.1–5.2). The existence of such a basis is not a hypothesis
of the structure theorem and is not imported from an unnamed supplier.

**Checks.**

- In A₁⁽¹⁾ for λ = π₁, the orbit weights π₁+nδ all occur with multiplicity
  1. E(π₁) is infinite-dimensional despite each weight space being finite.
- Stabilizing λ gives the same normalized vector, not merely an arbitrary
  scalar multiple. This is the condition needed to define a δ-translation
  independently of the chosen Weyl element.
- The weight 0 is not basic and E(0) is one-dimensional; it has no positive
  δ-period. The period conclusion must not be asserted for all level-zero
  weights.

*Needs:* §§1.1 and 4.1; the explicit supporting constructions in this target.

### 4.3 Fundamental modules and spectral periodicity

For λ = πᵢ use §4.2 and the Weyl-transport comparison of §1.1 to construct the
unique U′-linear automorphism zᵢ of E(πᵢ), of degree mᵢδ, sending its extremal
generator to the canonical vector of weight πᵢ+mᵢδ. Define
`F_i = E(π_i)/(z_i−1)E(π_i)`. Prove finite-dimensionality, integrability,
simplicity and the one-dimensional dominant extremal weight ϖᵢ. Prove the
normalized finite extremal-family characterization, and uniqueness of Fᵢ up
to isomorphism, with the basic-weight transport for A₂ₙ⁽²⁾ included
(K02 (5.6)–(5.7), Theorem 5.17, pp.24–25; AK97 §1.3, p.5).

For a,b∈k× prove
`F_i(a) ≅ F_j(b) ↔ i=j and a^(m_i)=b^(m_i)`.
Define Σ as the quotient of I₀×k× by this relation, equivalently the
isomorphism classes of fundamental spectral modules. Prove that changing
normalization of Fᵢ induces the corresponding relabeling of Σ. The same
construction identifies every simple object with fundamental dominant extremal
weight with a spectral shift of Fᵢ (K02 Theorem 5.17(ix); AK97 (1.7);
KKOP20 Remark 2.3). Tensor-power simplicity is the target of §7.1.

The API includes:

- quotient maps, the periodicity automorphism and the comparison with
  affinization after adjoining an mᵢ-th root of the periodic variable;
- the extremal line and weight support, independence of Weyl representatives,
  and invariance of isomorphism classes under spectral relabeling;
- simultaneous shift on Σ, its stabilizer of mᵢ-th roots of unity, and
  agreement with the actual simple-object isomorphism relation.

**Checks.**

- In A₁⁽¹⁾, F₁(a) is V(a), has dimension 2 and period m₁ = 1, and
  F₁(a)≅F₁(b) implies a=b.
- For any index with mᵢ>1 and a nontrivial mᵢ-th root of unity ζ,
  Fᵢ(a)≅Fᵢ(ζa) even though a≠ζa. Σ must identify these labels.
- In A₂⁽²⁾, the basic-weight lift is 2Λ₁−Λ₀ and m₁ = 1; it is Weyl-conjugate
  to the basic weight from the auxiliary short node. A formula using c₀=1
  would fail before a module could be constructed.

*Needs:* §§1.1, 3.1–3.2 and 4.1–4.2; rank-one tensor formulas from §2.3.

### 4.4 Classification by fundamental spectral data

For a finite ordered family of fundamental spectral modules, prove that its
tensor product has a one-dimensional maximal classical weight space of weight
the sum of their ϖᵢ. There is exactly one simple composition factor containing
this weight, and its multiplicity is one. Prove that its isomorphism class is
unchanged by permutation, and that this assignment is a bijection from finite
multisets in Σ to the isomorphism classes of simple objects of 𝒞. In particular
every simple has a unique dominant extremal weight and line
(AK97 Theorem 1.2, p.6; CP95 Proposition 3.2, Theorem 3.3 and Proposition
3.4, pp.8–9; CP98 Theorem 3.1 and Proposition 3.2, pp.7–8; KKOP20 §2.1,
p.7). These claims concern type-1 objects; the unqualified wording of AK97
Theorem 1.2 does not extend the classification to sign-twisted modules.

Treat surjectivity, injectivity and permutation-independence as parts of this
theorem, not consequences of extremal-module existence. A proof using
highest-ℓ-weights must establish the required induced highest-ℓ-weight modules,
simple quotients and polynomial classification in its untwisted and folded
cases (CP95 §§2–3; CP98 §§2–3). The untwisted eigenvalue formula is not imposed
on twisted types. No proof input here is Grothendieck-ring commutativity.

The API includes:

- the distinguished simple constituent and its multiplicity, independent of
  tensor ordering and of representatives in Σ;
- classification, the empty multiset/unit comparison and spectral shift of
  all labels simultaneously;
- the maximal classical weight and line, with explicit comparison to
  normalized R-matrix vectors in §5.2.

**Checks.**

- The empty multiset gives the unit, with dominant weight 0 and multiplicity 1.
- The multisets {V(a)} and {V(b)} for a≠b in A₁⁽¹⁾ have different simple
  images although their ordinary weight characters coincide.
- For {V(a),V(aq²)}, the distinguished constituent is the three-dimensional
  module Z of the worked example, not the whole four-dimensional tensor
  product; the other constituent is the unit.

*Needs:* §§2.1–2.3 and 4.3; native finite-length multiplicities. The
highest-ℓ-weight proof route and its folded classification are owned here.

### Examples

The basic-weight construction includes A₂⁽²⁾ with the long-node convention.
The A₁⁽¹⁾ product at parameter ratio q² distinguishes a distinguished constituent
from either the entire product or its head in a prescribed tensor order.

### Dependencies

Layers 1–3; QuantumEnvelopingAlgebras §§1.1–1.3a and 2.1. No crystal or
classification statement is assumed from a roadmap without a specified target.

## Layer 5: rational and specialized R-matrices

### 5.1 The completed universal intertwiner

Use the homogeneous Borel pairing to construct its canonical element in the
root-graded completion, and prove independence of homogeneous dual bases.
Combine it with the toral weight factor and the flip to obtain the universal
intertwiner with the coproduct of the Conventions. The toral factor on level-zero
weights descends modulo δ. Choose a common denominator of the rational weight
pairings and a compatible root of q in k to define its powers; record how a
change of this choice changes the scalar normalization.

For M,N in 𝒞, construct the induced isomorphism over k((z)) from M⊗N(z) to
N(z)⊗M. Prove that the root-graded completion acts on these spectral families:
for each fixed spectral degree, only finitely many terms act on any vector,
using finite classical weight support and nilpotence in the finite-type
positive directions. The completion is part of the construction, not an
infinite sum assumed to lie in U′⊗U′. Prove naturality, the two tensor identities
and the Yang–Baxter identity on three independent spectral families
(K02 §7, pp.29–31; KKOP20 §2.2, (2.7)–(2.9), pp.9–10).

The API includes:

- the chosen completion, convergence of its action, and compatibility with
  extension from Laurent polynomials to Laurent series;
- the intertwining equation on eᵢ,fᵢ,Kᵢ and its extension to the algebra;
- the inverse formal intertwiner, unit comparisons and tensor identities.

**Checks.**

- With either factor the unit, the canonical element acts as 1, and the
  intertwiner is the appropriate unitor comparison.
- In the rank-one example the rational normalized matrix displayed below has
  a Laurent-series expansion at z = 0; the universal matrix differs by a
  scalar series and a toral factor before normalization.
- The imaginary-root terms have unbounded spectral degrees. They cannot be
  replaced by a finite element of U′⊗U′, although each coefficient of the
  action is defined by a finite calculation.

*Needs:* §§1.1–1.2, 2.1–2.3 and 3.2; QuantumEnvelopingAlgebras §§1.4–1.5 for
the homogeneous pairing; native graded products and Laurent series.

### 5.2 Generic simplicity and rational normalization

For simple M,N in 𝒞, prove that M⊗N(z) is simple over k(z), remains simple
over an algebraic closure of k(z), and that M⊗N(a) is simple for all but
finitely many a∈k×. Establish this through the good fundamental modules of
Layer 4: their crystal/global-basis tensor argument, their normalized formal
intertwiners and cyclicity, followed by the simple spectral classification.
These are proof obligations of this target, not assumptions that arbitrary
simple modules are good (K02 Lemma 8.1, Theorems 9.1–9.2, Propositions 9.3–9.5;
KKOP20 §2.2, pp.10–12).

Let u and v be nonzero vectors in the dominant extremal lines of M and N.
Prove that the universal intertwiner sends u⊗v to a nonzero scalar Laurent
series times v⊗u. Dividing by that series gives the unique normalized
intertwiner Rᴺₘ,ₙ(z) with Rᴺₘ,ₙ(z)(u⊗v)=v⊗u. Prove its coefficients lie in
k(z), rather than only in k((z)): the intertwining and normalization equations
are finite linear equations over k(z), and uniqueness after scalar extension
descends their solution. The definition is independent of the choices of u,v.

Prove the normalized Yang–Baxter identity and the inverse identity obtained
by swapping the factors and replacing their spectral ratio by its inverse.
Prove equivariance under simultaneous shifts and isomorphisms. Distinguish
rational normalization for simple pairs from rational renormalizability for
general nonzero pairs; do not assume the latter for every object of 𝒞.

**Checks.**

- For the unit and a simple M, Rᴺ is the unit comparison, with scalar
  coefficient 1 after normalization.
- For V(a),V(b), with t=b/a, the middle block is the matrix in the worked
  example. It fixes the top vector and has determinant
  `(q²t−1)/(q²−t)`; it is invertible over k(t).
- The same determinant vanishes at t=q⁻², and the matrix has a pole at
  t=q². Generic invertibility therefore cannot be specialized at every
  nonzero parameter.

*Needs:* §§4.2–4.4 and 5.1; the good-module tensor and cyclicity arguments
explicitly owned here; scalar descent for finite systems of linear equations.

### 5.3 Denominators and nonzero specialization

For simple M,N define dₘ,ₙ(z) as the unique monic polynomial, with nonzero
constant term, generating the ideal of polynomials that clear all denominators
of Rᴺₘ,ₙ(z) on the Laurent lattices. Equivalently, take the monic least common
multiple of the reduced denominators of its matrix coefficients, removing
powers of z, and prove basis independence. Construct
`r_M,N = (d_M,N(z) Rᴺ_M,N(z))|_(z=1)` and prove it is a nonzero U′-linear map
M⊗N→N⊗M. Minimality of d proves that all coefficients of the cleared matrix
cannot have a common factor z−1. Multiplication by a different Laurent unit
changes r by a nonzero scalar (KKOP20 §2.2, (2.10)–(2.15), pp.10–12).

The API includes:

- denominator minimality, divisibility, change of basis and independence of
  chosen representatives of simple isomorphism classes;
- local specialization at any a≠0, with the order of its pole removed before
  evaluation, and compatibility with shifts;
- if d has degree n, the monic shift rule
  `d_(M(a),N(b))(z) = (a/b)^n d_M,N((b/a)z)`;
- the relation between normalized rational identities and compositions of
  specialized maps, including the possibility that such a composition is zero.

**Checks.**

- For V(1),V(1), the denominator in the second spectral variable is z−q²;
  its value at 1 is nonzero, and r is a nonzero scalar times the identity.
- For X=V(a), Y=V(aq²), rₓ,ᵧ has rank 1, whereas rᵧ,ₓ has rank 3. Their
  two composites vanish. Neither specialized map is an isomorphism.
- With either factor the unit, d=1. Multiplying d by z−1 would give zero
  on specialization, so an arbitrary denominator-clearing polynomial is not
  a valid replacement for the minimal denominator.

*Needs:* §§3.1–3.2 and 5.2; native polynomial divisibility, localization and
finite-dimensional linear algebra.

### Examples

The explicit A₁⁽¹⁾ matrix tests the spectral ratio, the side of normalization,
the denominator and the rank drop. It also witnesses why these specialized
maps do not furnish a braiding on all of 𝒞.

### Dependencies

Layers 1–4; QuantumEnvelopingAlgebras §§1.4–1.5; native rational functions,
Laurent series and polynomial ideals. Grothendieck-ring commutativity is not
used in constructing the intertwiners.

## Layer 6: the exact Grothendieck ring

### 6.1 Simple-class coordinates without an Artinian algebra

For a unital k-algebra A, give the category of A-modules finite-dimensional
over k its abelian and essentially small structures. Its finite length follows
from the scalar tower. Descend the native module Jordan–Hölder multiplicities
to its exact Grothendieck group, obtaining an isomorphism with the free abelian
group on isomorphism classes of finite-dimensional simple A-modules. The
inverse sends a basis vector to the class of its simple module. Prove that
these maps are inverse by composition-series induction and additivity of the
native multiplicity, not by a new Jordan–Hölder theorem.

Apply this to 𝒞, and to every full subcategory closed under subquotients and
finite sums. Prove that its simple classes are a subset of the ambient simple
classes, and that the exact inclusion induces an injective map of Grothendieck
groups. Extensions are required when constructing Serre subcategories in
Layer 8, but are not an extra premise of this particular injectivity argument.
In particular K₀(𝒞)→K₀(fd U′) is injective.

The API includes:

- the multiplicity homomorphism for each simple isomorphism class, finite
  support of the coordinate function, and the simple-class basis equivalence;
- `[M]=Σ_S [M:S][S]`, positivity, and length as the sum of its coefficients;
- equality with a single simple class if and only if the object is isomorphic
  to that simple, and functoriality for the stated inclusions.

**Checks.**

- The classes of zero and the unit have coordinates 0 and one at the unit,
  respectively. Equality with the zero class forces the object to be zero.
- In the worked example `[X⊗Y]=[Z]+[1]` has length 2 although dimension 4;
  `[V(a)]` has length 1 although dimension 2.
- A nonsplit extension of two simples has the sum of their classes. The
  relation cannot be restricted to direct-sum decompositions.
- U′ is not required to be an Artinian ring. The native theorem
  `TauCeti.simpleClassBasis` for finitely generated modules over an Artinian
  ring cannot supply this instance.

*Needs:* §2.2; GrothendieckEulerForms §§1.1–1.4; native modulewise
Jordan–Hölder multiplicities and their exact-sequence additivity.

### 6.2 A local-lattice specialization lemma

Let A be any unital k-algebra, R=k[z] localized at the prime ideal (z−1),
t=z−1, and F=k(z). Let L₁,L₂ be A⊗R-modules finite free over R. If their
F-fibres are isomorphic as A⊗F-modules, prove
`[L₁/tL₁]=[L₂/tL₂]` in K₀(fd A). The isomorphism need not extend to an
isomorphism of lattices and the two specializations need not be isomorphic.

A proof of this lemma is part of this target. Identify the generic fibres and
multiply one lattice by a power of t so that L₁⊆L₂. The quotient Q=L₂/L₁ is
finite-dimensional over k and killed by a power of t. Reduction gives an exact
sequence

```
0 → Q[t] → L₁/tL₁ → L₂/tL₂ → Q/tQ → 0.
```

The kernel and cokernel sequences for the A-linear endomorphism t:Q→Q give
`[Q[t]]=[Q/tQ]`. Substitution proves the required equality. Establish the
lattice containment, torsion bound and displayed exact sequence explicitly;
they are what makes generic isomorphism sufficient. This is a direct local
algebra argument, rather than a claim that ordinary characters distinguish
quantum affine simples.

**Checks.**

- L₂=R and L₁=tR have identical one-dimensional reductions even though
  reduction of the inclusion is the zero map. Here Q=k, and both end terms
  in the displayed sequence are k.
- The same calculation with L₁=tⁿR, n≥1, gives Q=R/(tⁿ) and
  `dim Q[t]=dim Q/tQ=1`, independently of n.
- For A=k[x], let x act on R² by the matrix with rows (0,t),(0,0).
  The lattices R e₁⊕R e₂ and R(t e₁)⊕R e₂ have the same generic fibre.
  Their reductions have x acting by zero and by a nonzero nilpotent Jordan
  block, respectively. They are not isomorphic, but both classes are twice
  the class of the simple module with x=0.

*Needs:* §6.1; native localization, finite-free modules, exact sequences and
short-exact-sequence relations. The proof is given in this subsection.

### 6.3 Multiplication and commutativity

Install the native exact-K₀ ring on 𝒞 using §2.3's biexact tensor product.
For simple M,N, apply §6.2 to the Laurent lattices of M⊗N(z) and N(z)⊗M,
localized at z=1, and their generic isomorphism Rᴺ. Injectivity from §6.1 gives
`[M⊗N]=[N⊗M]` in K₀(𝒞). Extend by composition-series additivity and tensor
exactness to all objects, and prove commutativity for all ring elements.
Construct the commutative-ring structure from this proof. No braided structure
on 𝒞 is an input (KKOP20 §2.1, p.7, for the resulting commutative ring;
§§6.1–6.2 here provide the specialization proof).

The API includes:

- `[M][N]=[M⊗N]`, `[1]=1`, exact additivity, and the forgetful dimension
  ring homomorphism K₀(𝒞)→ℤ;
- the ring homomorphisms induced by exact tensor functors, especially shifts
  and the subcategory inclusions of Layer 8;
- symmetry of tensor simplicity for simple M,N, and then
  `M⊗N ≅ N⊗M` when either tensor product is simple, by simple-class
  coordinates. Equality of arbitrary classes does not imply isomorphism.

**Checks.**

- `[X][Y]=[Y][X]=[Z]+1`, but X⊗Y and Y⊗X in the worked example are
  nonisomorphic. Ring commutativity does not lift to a braiding.
- The dimension homomorphism sends that equation to `2·2=3+1`.
- If `[M⊗N]` is the class of a simple S, both tensor orders have length 1
  and are isomorphic to S. This uses positivity of composition multiplicities.

*Needs:* §§2.3, 5.2 and 6.1–6.2; the native exact-K₀ ring and ring-map
interfaces of GrothendieckEulerForms §§1.1–1.4 and 2.3.

### 6.4 Fundamental generators and the integral-domain property

Construct the ring homomorphism from the polynomial ring over ℤ in variables
indexed by Σ to K₀(𝒞), sending a variable to its fundamental simple class.
Prove it is an isomorphism. For a monomial, §4.4 gives one distinguished simple
constituent of multiplicity one, labeled by exactly that finite multiset.
Every other constituent has strictly smaller dominant classical weight. The
finite-type dominance order on dominant weights has finite lower intervals;
use induction in this order to obtain a unitriangular change between monomials
and the simple-class basis. This proves both generation and independence,
including for the infinite set Σ.

This argument is the Grothendieck-ring consequence of §4.4's classification and
multiplicativity of highest spectral data (CP95 Proposition 3.4 and Corollary
3.5; CP98 Proposition 3.2 and Corollary 3.3); those corollaries state the
constituent property, rather than being mislabeled as polynomial-ring theorems.
Deduce that K₀(𝒞) is an integral domain. The variables are actual isomorphism
classes Σ, so spectral periods in twisted types do not create duplicate
polynomial variables.

**Checks.**

- The empty monomial is the class of the unit and its leading simple is the
  unit. A single variable is already a basis class.
- In A₁⁽¹⁾ the monomial labeled {V(a),V(aq²)} equals `[Z]+1`; the
  lower-weight correction is essential to the basis change.
- Distinct parameters a,b give distinct polynomial variables when m₁=1,
  even though the ordinary weight characters of V(a),V(b) coincide.
- If mᵢ>1, labels a and ζa with ζᵐⁱ=1 give the same variable. Treating
  I₀×k× itself as the independent-variable set would make injectivity false.

*Needs:* §§4.4 and 6.1–6.3; native multivariate polynomials with finitely
supported monomials; finite-type dominance from §1.1.

### Examples

The local-lattice calculation separates equality in the exact Grothendieck
group from isomorphism of special fibres. The A₁⁽¹⁾ exchange separates the
simple-class basis from the monomial basis in fundamental generators.

### Dependencies

Layers 2, 4 and 5; GrothendieckEulerForms §§1.1–1.4 and 2.3; native module
Jordan–Hölder theory and polynomial rings.

## Layer 7: real simple objects and tensor-product structure

### 7.1 Reality, primeness and strong commutation

For a simple M define reality by simplicity of M⊗M. For simple M,N define
strong commutation by simplicity of M⊗N, and commutation by the existence of
an isomorphism M⊗N≅N⊗M. Define a prime simple to be a nonunit simple whose
factorization as a tensor product of simple objects has a unit factor.
Reality and primeness are distinct predicates. Prove their invariance under
isomorphisms, shifts and either dual. Prove symmetry of strong commutation
using §6.3; strong commutation implies commutation (KKOP20 §2.1, p.9).

Using the good-module crystal and tensor results in §§4.2 and 5.2, prove that
every Fᵢ(a) is real and that all its tensor powers are simple. The tensor
product of simple crystals and the global basis supply this assertion for the
unshifted rational model; simultaneous shift supplies it for arbitrary a∈k×
(K02 Lemma 4.11, Proposition 4.12, Theorem 5.17; KKOP20 Definition 2.4 and the
paragraph following it, p.9).

**Checks.**

- The unit is real and strongly commutes with every simple; it is not prime
  under the stated nonunit convention.
- V(a) is real and prime. Primeness follows from dimension 2 and the fact
  that every one-dimensional object is the unit.
- V(a)⊗V(a) is a real simple of dimension 4 but is not prime. Reality alone
  does not characterize a cluster variable.
- V(a),V(aq²) do not strongly commute: their tensor product has length 2.
  In fact they do not commute, as the unit-submodule calculation below shows.

*Needs:* §§2.2–2.3, 3.1, 4.2–4.3, 5.2 and 6.3; the source's simple-crystal
tensor and irreducibility arguments, with their scalar-extension comparison.

### 7.2 The real-simple head and socle theorem

For a finite-length object, construct its head as the maximal semisimple
quotient and its socle as the sum of its simple subobjects; prove their
universal characterizations and compatibility with exact duality. If M,N are
simple and at least one is real, prove:

- M⊗N and N⊗M have simple head and simple socle;
- the image of rₘ,ₙ is the head of M⊗N and the socle of N⊗M;
- Hom(M⊗N,N⊗M) is the one-dimensional span of rₘ,ₙ;
- if the head and socle of M⊗N are isomorphic, then M⊗N is simple.

These statements include nonzero images and uniqueness, not just the
existence of some simple quotient (KKKO15 Theorem 3.12 and Corollary 3.16;
KKOP20 Theorem 2.13, p.15). For the Hom statement, KKOP20 explicitly notes
that it is not proved in the cited KKKO15 theorem: this target includes the
additional tensor-intersection argument, rather than attributing that proof
to the wrong theorem.

The supporting argument owns the elementary containment lemma for submodules
of a triple tensor product over a field, the factorization of specialized
R-matrices through images, and the implication from a scalar nonzero rₘ,ₘ
to simplicity of M⊗M. State and prove those lemmas on the actual tensor
modules. Prove also that for real simple M the maps sending a simple N to
the head of M⊗N, and to the head of N⊗M, are injective on isomorphism
classes (KKKO15 Corollary 3.14). Deduce that if one of M,N is real,
commutation is equivalent to strong commutation.

**Checks.**

- For X=V(a),Y=V(aq²), the image of rₓ,ᵧ is the unit, which is the head
  of X⊗Y and the socle of Y⊗X. The reverse image is Z of dimension 3.
- For M=N=V(a), the whole tensor square is simple, so its head and socle
  equal the whole four-dimensional module and r is a scalar identity.
- With M the unit, the head operation is N↦N and its cancellation statement
  is literally equality of simple isomorphism classes.
- A nontrivial self-extension of a simple in an arbitrary finite-length
  category can have isomorphic head and socle. The final conclusion above
  is a theorem about these real-factor tensor products, not such categories
  in general.

*Needs:* §§2.2–2.3, 5.3, 6.1 and 7.1; the explicit finite-length head/socle
and tensor-intersection constructions in this target.

### 7.3 Pairwise simplicity and simple tensor monomials

For any finite ordered list of simple objects M₁,…,Mₙ prove that its tensor
product is simple if and only if each two-factor subproduct with distinct
positions is simple. Every permutation is then isomorphic to that simple
product. The forward implication uses exact faithful tensoring by a nonzero
finite-dimensional module and the adjacent intertwiners; the reverse
implication is the pairwise simplicity theorem (H10 Theorem 1.1; KKOP20 §2.1,
p.9, which states it for the generic field and category used here). The
complex-parameter statement of H10 is not silently applied to a different
base field; the generic statement in KKOP20 is the source contract.

Deduce that for any family of pairwise strongly commuting real simples, every
finitely supported tensor monomial, with repetitions allowed, is real simple
and independent of the ordering up to isomorphism. Treat n=0 and n=1
explicitly. A countable seed needs only this finite construction, not an
infinite tensor product.

**Checks.**

- For the empty list the product is the real simple unit; for a one-element
  list simplicity is the hypothesis and pairwise conditions are vacuous.
- Every V(a) to a nonnegative tensor power is real simple. Repetitions use
  reality; conditions only on distinct isomorphism classes would not suffice.
- In the rank-one exchange, X,Z and Y,Z each strongly commute, so Xʳ⊗Zˢ
  and Yʳ⊗Zˢ are real simple for all r,s≥0. The pair X,Y fails the criterion.

*Needs:* §§2.3, 5.2–5.3, 6.3 and 7.1–7.2; the generic pairwise theorem
proved in this target with the cited all-affine source contract.

### 7.4 Reality from a length-two exchange

Let X,Y,M,N be simple objects and let
`0→X→M⊗N→Y→0` be exact. Assume X⊗N and Y⊗N are simple and M is real.
Prove N is real. This is a local tensor theorem, without an assumption that
an entire seed remains admissible after every mutation (KKOP20 Proposition
4.9(ii), p.27).

The proof obligations include the tensor-intersection argument used for the
length-two sequence, the scalar criterion for rₙ,ₙ from §7.2, and cancellation
of nonzero classes in the integral domain K₀(𝒞) from §6.4. In particular,
the simple head/socle theorem implies X≇Y: otherwise M⊗N would be simple.
Cancellation then gives X⊗N≇Y⊗N. The length-two R-matrix argument for these
distinct simple products gives a scalar nonzero rₙ,ₙ and hence reality.
No numerical Λ-invariant is an unmentioned proof input.

**Checks.**

- Take M=X₀=V(a), N=Y₀=V(aq²), X=Z and Y=1 in the worked example.
  Both Z⊗Y₀ and 1⊗Y₀ are simple, and the conclusion says Y₀ is real.
- An exact sequence with both end terms equal to the unit cannot have the
  stated real M: the head/socle conclusion would contradict length 2.
- If N is the unit, M⊗N is already simple, so no such exact sequence with
  two nonzero simple end terms exists. The nonzero convention is essential.

*Needs:* §§5.3, 6.4 and 7.2–7.3; the length-two tensor argument explicitly
owned here.

### Examples

The rank-one exchange tests both possible R-images and a nonprime real
simple. The unit tests the empty-product and nonzero conventions used later
for exchange monomials.

### Dependencies

Layers 2–6; the simple-crystal and generic pairwise results at the exact
locators above. No grading or quiver Hecke category is introduced.

## Layer 8: natural Serre tensor subcategories

### 8.1 Closure generated by a family of modules

For a family of objects of 𝒞, construct the smallest replete full subcategory
containing it and the unit and closed under finite direct sums, subquotients,
extensions and tensor products. Use intersection of all such object
properties and prove its universal property. Construct its inherited abelian,
essentially small and monoidal structures and the biexact inclusion into 𝒞.
An independent requirement of closure under either dual is not part of this
construction (KKOP20 §6, p.32; KKOP22 §7.2, p.64).

Prove that simple objects and finite-length coordinates are inherited,
and that the induced ring homomorphism into K₀(𝒞) is injective. Realness and
strong commutation computed inside the subcategory agree with the ambient
predicates, because subobjects of its objects are retained. Prove monotonicity
in the generating family and invariance under replacing generators by
isomorphic objects or applying a simultaneous spectral shift.

**Checks.**

- With no generators, the closure consists of finite sums of the unit.
  An extension of such objects has only weight 0; eᵢ,fᵢ must act by zero,
  so the extension splits. Its Grothendieck ring is ℤ.
- If V(a) is a generator, V(a)⊗V(a) and all its subquotients belong to the
  closure, without declaring the ambient category semisimple.
- Taking the full generating family of objects of 𝒞 returns 𝒞, and the
  Grothendieck-ring inclusion is the identity.

*Needs:* §§2.1–2.3, 6.1, 6.3 and 7.1; native full-subcategory interfaces.

### 8.2 Fundamental spectral components

On Σ, join two distinct fundamental classes when their modules do not
commute. This is a well-defined undirected graph. Since fundamental modules
are real, §7.2 identifies its edges with nonsimple tensor products. Relate the
edges to poles in one of the two normalized fundamental R-matrices by the
good-module simplicity criterion (K02 Proposition 9.4(iii); KKOP22 §2.2,
pp.12–14). With Σ defined by actual isomorphism classes, the construction
includes the twisted spectral identifications.

For a chosen connected component σ₀, define 𝒞⁰ by the Serre tensor closure
of its fundamental modules. This is the category denoted 𝒞ᵍ⁰, with its chosen
spectral component, in KKOP22 §2.2. Prove finite valency using the finitely
many nonzero roots of the denominator polynomials and the finite number of
fundamental types. Thus each connected component is countable. A simultaneous
spectral shift maps a component isomorphically to its image and induces an
exact tensor equivalence of the associated categories.

The API includes:

- independence of spectral representatives and a graph-equivalence statement
  for simultaneous shifts;
- the denominator criterion in both orders, the component membership
  relation and countability;
- inclusion of generators and unit, the Serre tensor universal property,
  and the injective map K₀(𝒞⁰)→K₀(𝒞).

**Checks.**

- In A₁⁽¹⁾, the component containing V(a) consists of V(aq²ⁿ), n∈ℤ.
  Its edges join consecutive powers; the denominator roots give exactly
  the ratios q² and q⁻².
- There is no loop at V(a), because its square is simple. A zero-denominator
  or a rule testing only one tensor order would give the wrong graph.
- For mᵢ>1, the vertices labeled (i,a) and (i,ζa), with ζᵐⁱ=1, are the
  same vertex. They must not be counted as different neighbors.

*Needs:* §§4.3, 5.2–5.3, 7.1–7.2 and 8.1; finite-root bounds for nonzero
polynomials and finite paths in a locally finite graph.

### Examples

A component category and a closure generated by only part of that component
have different universal properties. Frozen modules in such a smaller closure
need not be tensor-invertible and do not force a localization of its ring.

### Dependencies

Layers 2 and 4–7; native graph connectivity and full-subcategory constructions.

## Layer 9: monoidal seeds and the categorification predicate

### 9.1 Monoidal seeds and finite tensor monomials

Let 𝒟 be a subcategory as in §8.1. Use a finite or countable vertex set J,
a specified subset Jex of mutable vertices, and an integer matrix B with rows
J and columns Jex. Its principal part is skew-symmetric and each column has
finite support, exactly as in the classical seed supplier.

A monoidal seed is a family Mⱼ, j∈J, of pairwise strongly commuting real
simple objects of 𝒟 together with B.
Construct its tensor monomial for every finitely supported function J→ℕ,
prove real simplicity, independence of ordering up to isomorphism, and the
Grothendieck-ring monomial formula (KKOP20 Definition 6.1, p.32; KKOP22
Definition 7.2, p.64). Algebraic independence of the classes is a separate
condition on a realization in a cluster algebra; it is not part of this
monoidal-seed definition.

The API includes:

- frozen/mutable decomposition, finite supports of positive and negative
  exchange columns, and empty monomials;
- replacement of a seed by isomorphic representatives and transport under
  exact tensor equivalences;
- comparison of its matrix data and monomials with ClusterAlgebras
  §§1.1–1.4 and 2.3, with the frozen inverse set empty.

**Checks.**

- An empty seed has only the unit monomial and no mutable directions.
- A family consisting of two copies of the unit satisfies the categorical
  family condition, but its classes are algebraically dependent. It cannot
  realize a two-variable algebraic cluster.
- For X=V(a),Z from the worked example, take J=(x,z), Jex={x} and
  the column (0,1). This gives a monoidal seed, with Z frozen.

*Needs:* §§7.1, 7.3 and 8.1; the exact classical matrix and monomial contracts
of ClusterAlgebras §§1.1–1.4 and 2.3.

### 9.2 Categorical mutation and admissibility

For a mutable k put
`T₊=⊗_(b_ik>0) M_i^(⊗b_ik)` and
`T₋=⊗_(b_ik<0) M_i^(⊗(−b_ik))`.
The products are finite, and an empty product is the unit. A categorical
mutation consists of a simple replacement M′ₖ, the two exact sequences

```
0 → T₊ → M_k ⊗ M′_k → T₋ → 0,
0 → T₋ → M′_k ⊗ M_k → T₊ → 0,
```

and the assertion that replacing Mₖ by M′ₖ and B by its matrix mutation
again gives a monoidal seed. In particular M′ₖ is real and strongly
commutes with the unchanged variables. Define admissibility by the existence,
for every mutable k, of only the first sequence with M′ₖ simple and commuting
with each Mᵢ for i≠k (KKOP20 Definitions 6.2–6.3, pp.32–33).

Prove admissibility is equivalent to the existence of categorical mutations
in all directions of this seed (KKOP20 Proposition 6.4(i)). For the nontrivial
implication, the unchanged Mᵢ are real, so commutation gives strong
commutation. Section 7.3 makes T₊⊗M′ₖ and T₋⊗M′ₖ simple; §7.4 makes
M′ₖ real. The head/socle theorem and equality of the two tensor classes then
give the reversed exact sequence. Prove uniqueness of the replacement up to
isomorphism by real-head cancellation and prove involutivity of a single
categorical mutation up to isomorphism. This theorem does not assert that a
new seed is automatically admissible in every direction.

**Checks.**

- The rank-one pair of sequences has T₊=Z and T₋=1. It mutates X to Y,
  and the column becomes (0,−1). Mutation back interchanges the two sequences.
- A zero exchange column has T₊=T₋=1. It admits no categorical mutation:
  the two-factor product would have isomorphic head and socle but length 2,
  contradicting §7.2. Thus the definition does not promise mutations for
  every matrix/family pair.
- Taking M′ₖ=1 cannot meet a nontrivial exchange sequence with two simple
  end terms, since Mₖ⊗1 is already simple.

*Needs:* §§6.1, 6.3, 7.2–7.4 and 9.1; classical matrix mutation and its
involutivity from ClusterAlgebras §1.1.

### 9.3 Decategorification and algebraic mutation

For a categorical mutation prove the exact exchange identity
`[M_k][M′_k]=[T₊]+[T₋]` in K₀(𝒟). Suppose a ring realization of the
classical cluster algebra identifies the current cluster variables with the
classes [Mᵢ], and that this realization is injective. Compare the categorical
replacement with the algebraic exchange variable in the fraction field.
Cancellation by the nonzero class [Mₖ] is justified by the domain property
inherited from K₀(𝒞); it is not an assumption that [Mₖ] is a unit of K₀(𝒟).
Prove equality with the exchange variable and transport the matrix mutation.

More intrinsically, when [Mᵢ] are algebraically independent, construct the
embedding of the rational function field in these classes into the fraction
field of K₀(𝒟), and show that a categorical mutation realizes the supplier's
exchange formula there. Extend this comparison by induction over a finite
mutation word for which categorical mutations have been supplied. Countably
many vertices introduce no infinite product into a fixed exchange or word
(KKOP22 §7.1 and Definition 7.3; the exchange comparison follows from the two
exact sequences).

**Checks.**

- In the example, the formula is `x y=z+1`, so y=(z+1)/x in the fraction
  field. The categorical module Y lies in 𝒟 even though X is not invertible
  as a module.
- The frozen class [Z] is not a unit: its dimension is 3, which is not a unit
  in ℤ. Its inclusion as a frozen variable therefore does not invert it.
- Two unit variables from §9.1 do not provide an injective polynomial
  realization. The matrix data alone cannot make them algebraically
  independent or define the required rational-function embedding.

*Needs:* §§6.3–6.4, 8.1 and 9.1–9.2; the classical exchange-field and
finite-word pattern contracts of ClusterAlgebras §§1.1–1.4 and 2.3.

### 9.4 Monoidal categorification in the KKOP sense

Let 𝒜 be an ordinary geometric cluster algebra supplied by ClusterAlgebras,
with the frozen inverse set empty, and let 𝒟 be as in §8.1. Define a monoidal
categorification to be a specified ring isomorphism
`Φ : 𝒜 ≅ K₀(𝒟)` such that for every cluster monomial m there exists a real
simple object L of 𝒟 with Φ(m)=[L]. The quantifier includes all seeds reached
by finite mutation words, all finitely supported nonnegative exponents and
the empty monomial (KKOP20 Introduction, pp.2–3; KKOP22 §7.2, p.64).

Prove invariance of this property under exact tensor equivalence of 𝒟 and
under a specified isomorphism of cluster patterns. Given a family of
categorical seeds realizing every finite mutation word from an initial seed,
and a ring isomorphism identifying its initial variables, use §9.3 and then
§7.3 to prove the categorification property. The required ring isomorphism
and existence of all the categorical mutations remain explicit application
data; a single exchange sequence does not supply them.

Prove uniqueness up to isomorphism of the real simple L representing a given
cluster monomial, by the simple-class basis. Distinguish this predicate from
the stronger convention that all real simple classes are cluster monomials,
or that all prime real simple classes are cluster variables. Neither converse
belongs to the stated KKOP definition. A grading and a quantum cluster
parameter would require additional structures outside this endpoint.

**Checks.**

- The empty monomial maps to 1=[1], and the unit is real simple.
- For the cluster algebra ℤ on the empty vertex set and the category of
  finite sums of the unit, the dimension/class isomorphism is a monoidal
  categorification. This checks a complete case, not just an exchange.
- The worked A₁⁽¹⁾ exchange verifies §9.2 and its two adjacent clusters.
  It is not, by itself, a proof of a ring isomorphism or a categorification
  theorem for the full component category 𝒞⁰.
- The real but nonprime V(a)⊗V(a) can represent a square of a cluster
  variable. Requiring every monomial to be prime would contradict this case.

*Needs:* §§6.1, 7.3, 8.1 and 9.1–9.3; the supplied ordinary cluster algebra,
its full finite-word pattern and its cluster-monomial predicate.

### Examples

The empty categorification tests the unit and ring conventions. The nontrivial
rank-one exchange tests frozen coefficients, both tensor orders, exactness and
realness without assuming a global mutation theorem.

### Dependencies

Layers 6–8; ClusterAlgebras §§1.1–1.4 and 2.3. The output is a predicate and
its comparison API on actual quantum affine categories, together with the
local mutation theorem, not a supplied categorification of every such category.

## Worked compatibility test: A₁⁽¹⁾

This calculation fixes the coproduct, parameter and tensor-order conventions
used throughout. With d₀=d₁=1, let V(a) have basis v₊,v₋ and actions

```
K₁ = diag(q,q⁻¹),        K₀ = K₁⁻¹,
e₁ v₋ = v₊,             e₁ v₊ = 0,
f₁ v₊ = v₋,             f₁ v₋ = 0,
e₀ = a f₁,              f₀ = a⁻¹ e₁.
```

Verify the Cartan, commutator and affine Serre relations in these matrices.
The module is simple, type 1 and level zero. These identities define the
parameter a used here; a source with a different evaluation map must be
compared through these actions (CP95 §4, Propositions 4.1–4.2).

For the normalized intertwiner V(a)⊗V(b)→V(b)⊗V(a), put t=b/a. In the
factor-labeled ordered bases (++,+−,−+,−−), its top and bottom entries are
1 and its middle block is

```
                 1       [ q²−1        q(1−t)   ]
              -------    [                       ].
               q²−t      [ q(1−t)      t(q²−1)  ]
```

Multiplying these matrices with the generator actions on both tensor orders
verifies the intertwining equations; the value on ++ fixes normalization.
The determinant of the full matrix is `(q²t−1)/(q²−t)`, and the monic
minimal denominator is t−q². At t=q² the denominator-cleared matrix has rank
1. At t=q⁻² the normalized matrix is regular of rank 3. At t=1 it is the
identity in these factor-labeled bases. Thus invertibility over k(t) does not
supply invertibility at all spectral values.

The vector `u=+−−q(−+)` is killed by e₁ and f₁. Direct substitution gives

```
e₀u = (a/q−qb) --,       f₀u = (1/(bq)−q/a) ++.
```

It spans a unit submodule precisely when b/a=q⁻². The functional with row
`(0,1,−q,0)` is a quotient map to the unit precisely when b/a=q².
For X=V(a), Y=V(aq²), the kernel Z of this functional on X⊗Y is
three-dimensional, spanned by ++, q(+−)+(−+), and --. It is simple: its
finite-type restriction is the irreducible highest-weight-2 module. The
computed actions give the evaluation parameter aq in this normalization.
Consequently there are nonsplit exact sequences

```
0 → Z → X⊗Y → 1 → 0,
0 → 1 → Y⊗X → Z → 0.
```

They do not split because the tensor order with the unit quotient has no unit
submodule, and the opposite order has no unit quotient. In particular
`Hom(1,X⊗Y)=0` and `dim Hom(1,Y⊗X)=1`, proving X⊗Y≇Y⊗X. The images
of the two specialized R-matrices are the unit and Z, respectively. This
simultaneously checks §5.3, the head/socle orientation of §7.2 and the absence
of a braiding on the full category.

For completeness, the rank-one simplicity test uses the q-segment
`Q_r(c)={c q^(−r+1),c q^(−r+3),…,c q^(r−1)}` of the r+1-dimensional
simple evaluation module. Two segments are in general position when their
union is not a segment or one contains the other. A tensor of the corresponding
rank-one simples is simple exactly when the segments are pairwise in general
position (CP95 Proposition 4.2 and Theorem 4.3). Here X,Y,Z correspond to
{a}, {aq²}, {a,aq²}. Thus X⊗Z and Y⊗Z are simple, and X,Y,Z are real.

Take X as the mutable object, Z as the frozen object, and B the column (0,1).
The two exact sequences give the mutation to Y and the relation
`[X][Y]=[Z]+1`. The monomials Xʳ⊗Zˢ are distinct simple objects: their
spectral multisets have r+s copies of a and s copies of aq². Their classes
are therefore linearly independent, which proves algebraic independence of
[X],[Z]. The same argument applies to [Y],[Z]. Finally [Z] is not invertible,
since the dimension homomorphism sends it to 3. These facts verify a local
categorical exchange and its algebraic realization. A claim about an entire
cluster algebra still requires the ring isomorphism and mutation coverage in
§9.4.

## Downstream consumers

- Constructions of Hernandez–Leclerc subcategories can use §8.1 to define
  their actual closure and §8.2 for spectral components, then supply a
  specific seed, ring isomorphism and mutation family to §9.4.
- Quantum affine Schur–Weyl functors can use the intrinsic source algebra,
  spectral families, denominator and exact tensor interfaces. An exact
  tensor functor induces the native map of Grothendieck rings in §6.3.
- Studies of R-matrix invariants can start from the formal scalar coefficient,
  rational normalization and local pole orders in Layer 5. Their further
  integer invariants are not prerequisites for the predicate defined here.
- Categorifications with a grading or a quantum cluster parameter must add
  their grading, shift action and quantum multiplication comparison. They
  do not arise by relabeling q in the ordinary endpoint above.

## References

- **K02.** Masaki Kashiwara, *On level-zero representations of quantized affine
  algebras*, Duke Mathematical Journal 112 (2002), 117–175;
  [arXiv math/0010293v2](https://arxiv.org/abs/math/0010293v2).
  Use the revised text: §§2–5 for extremal and fundamental modules,
  §§7–9 for completed intertwiners, good modules and generic simplicity.
- **AK97.** Tatsuya Akasaka and Masaki Kashiwara, *Finite-dimensional
  representations of quantum affine algebras*, Publications of RIMS 33
  (1997), 839–867;
  [author PDF](https://www.kurims.kyoto-u.ac.jp/~kenkyubu/kashiwara/akasaka.pdf).
  Sections 1.1–1.3 and Theorem 1.2 give the representation-theory setup;
  Appendices A–B discuss R-matrices. Its conjectural general cyclicity
  statements are used only through the proved results in K02 §§8–9.
- **CP95.** Vyjayanthi Chari and Andrew Pressley, *Quantum affine algebras and
  their representations*, in *Representations of groups* (Banff, 1994),
  CMS Conference Proceedings 16 (1995), 59–78;
  [arXiv hep-th/9411145v1](https://arxiv.org/abs/hep-th/9411145v1).
  Section 3 gives classification and multiplicativity of highest spectral
  data; §4 supplies the rank-one segment tests.
- **CP98.** Vyjayanthi Chari and Andrew Pressley, *Twisted quantum affine
  algebras*, Communications in Mathematical Physics 196 (1998), 461–476;
  [arXiv q-alg/9611002v2](https://arxiv.org/abs/q-alg/9611002v2).
  Theorem 1.3 supplies the presentation comparison used in its proof;
  Theorem 3.1, Proposition 3.2 and Corollary 3.3 give the twisted
  classification and tensor highest-data statements.
- **H10.** David Hernandez, *Simple tensor products*, Inventiones Mathematicae
  181 (2010), 649–675;
  [arXiv 0907.3002v2](https://arxiv.org/abs/0907.3002v2).
  Theorem 1.1 is the all-affine pairwise simplicity theorem; its generic-field
  formulation used here is stated in KKOP20 §2.1.
- **KKKO15.** Seok-Jin Kang, Masaki Kashiwara, Myungho Kim and Se-Jin Oh,
  *Simplicity of heads and socles of tensor products*, Compositio Mathematica
  151 (2015), 377–396;
  [arXiv 1404.4125v2](https://arxiv.org/abs/1404.4125v2).
  Theorem 3.12 and Corollaries 3.14 and 3.16 supply the quantum affine
  real-simple head/socle, cancellation and commutation results.
- **KKOP20.** Masaki Kashiwara, Myungho Kim, Se-Jin Oh and Euiyong Park,
  *Monoidal categorification and quantum affine algebras*;
  [arXiv 1910.08307v2](https://arxiv.org/abs/1910.08307v2).
  Sections 2.1–2.2 give the generic quantum affine category and R-matrices;
  Theorem 2.13 gives the real-simple conclusions, Proposition 4.9 the local
  reality theorem, and Definitions 6.1–6.3 and Proposition 6.4(i) the
  ordinary categorical seed and mutation interface.
- **KKOP22.** Masaki Kashiwara, Myungho Kim, Se-Jin Oh and Euiyong Park,
  *Monoidal categorification and quantum affine algebras II*;
  [arXiv 2103.10067v3](https://arxiv.org/abs/2103.10067v3).
  Section 2.2 specifies the spectral-component categories; §§7.1–7.2 give
  the classical cluster and ordinary monoidal-categorification conventions.
