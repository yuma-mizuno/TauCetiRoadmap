# Roadmap: quantum enveloping algebras, part II: affine representations and monoidal categorification

**Summary.** Construct the finite-dimensional integrable representation theory of
quantum affine algebras of every affine type, with a generic quantum parameter.
Starting from the full-root-datum quantum enveloping algebra, build the derived
quantum affine algebra, its level-zero finite-dimensional module category,
spectral shifts and fundamental representations, rational and specialized
R-matrices, the exact Grothendieck ring, and real simple tensor products. The
endpoint is the definition of monoidal categorification of an ordinary cluster
algebra in the sense of Kashiwara–Kim–Oh–Park, together with the categorical
seed and exchange-sequence interfaces needed to use that definition.

## Scope and ownership

This is the affine representation-theory continuation of
[QuantumEnvelopingAlgebras](../QuantumEnvelopingAlgebras/README.md). That roadmap
owns the generic algebra, its full torus, Hopf structure, triangular
decomposition, Serre comparison and Borel pairing. This roadmap specializes
those constructions to affine data and owns the affine module theory and its
connection to ordinary cluster algebras. Twisted affine types are included.

[QuantumGroups](../QuantumGroups/README.md) §8.5 supplies the general finite
Hopf-module category and its monoidal and duality structures.
[GrothendieckEulerForms](../GrothendieckEulerForms/README.md) supplies exact
Grothendieck groups and bilinear descent. The simple-class basis here is for
finite-dimensional modules over an algebra that need not be Artinian.
[ClusterAlgebras](../ClusterAlgebras/README.md) §§1.1–1.4 and §2.3 supply ordinary
geometric seeds, polynomial frozen coefficients, and locally finite classical
patterns. This roadmap owns neither a second cluster-algebra construction nor
a graded quantum cluster algebra.

The scope ends at categorical seeds, their exchange relations, and the precise
monoidal-categorification predicate. The global identification of particular
Grothendieck rings with cluster algebras, quantum affine Schur–Weyl duality,
quiver Hecke algebras and affine determinantial modules are downstream
consumers. A proposed categorical seed is not asserted to admit every mutation.

## Conventions

Fix an indecomposable symmetrizable affine Cartan datum, a distinguished affine
vertex 0, the primitive null root δ and central coroot c. Use an algebraic
closure k of ℂ(q), with q transcendental, and qᵢ = q raised to the symmetrizer dᵢ.
Finite-dimensional means finite-dimensional over k. Modules are left modules.
The derived algebra U′ retains its central group-like element; the level-zero
quotient imposes its value 1. The full affine algebra, the derived subalgebra
and the level-zero quotient are distinct objects.

Retain the supplier coproduct on its generators Eᵢ,Fᵢ,Kᵢ. For comparison with
the quantum-affine sources put eᵢ = EᵢKᵢ⁻¹ and fᵢ = KᵢFᵢ; then
`Δ(e_i) = e_i ⊗ K_i^-1 + 1 ⊗ e_i` and
`Δ(f_i) = f_i ⊗ 1 + K_i ⊗ f_i`. All comparisons transport this convention.

Grothendieck groups impose short-exact-sequence relations. Frozen variables
are not inverted. Cluster monomials have nonnegative, finitely supported
exponents, including at frozen vertices. Monoidal categorification uses the
KKOP convention: a ring isomorphism from the cluster algebra to the
Grothendieck ring sends every cluster monomial to the class of a real simple
object. The converse is not part of this predicate.

## Exact supplier contracts

### From Mathlib

Use algebraic tensor products, module categories, full subcategories, abelian
categories, finite-dimensionality, submodules, localization and Laurent
polynomials on their native carriers.

### From Tau Ceti

Use the finite Hopf-module category; exact Grothendieck rings of biexact
monoidal categories; and the Jordan–Hölder multiplicity and exact-sequence
additivity for finite-length modules over an arbitrary ring.

### From TauCetiRoadmap.QuantumEnvelopingAlgebras

Consume §§0.1, 1.0–1.5 and 2.1 for the datum, quantum algebra, Hopf structure,
triangular decomposition, Serre comparison, Borel pairing and braid operators.
The affine coproduct adapter is part of Layer 1 here.

### From TauCetiRoadmap.KacMoody

Consume Layer 0 for the realization and its lattices and §2.1 for the Weyl
group. Affine null directions and the level-zero quotient are constructed here.

### From TauCetiRoadmap.QuantumGroups

Consume §8.5 for the finite Hopf-module category, tensor product, and the
left and right duals induced by the antipode and its inverse.

### From TauCetiRoadmap.GrothendieckEulerForms

Consume §§1.1–1.4 and 2.3 for exact Grothendieck groups and bilinear descent.
The Artinian-ring hypothesis of §4.1 is not imposed on U′.

### From TauCetiRoadmap.ClusterAlgebras

Consume §§1.1–1.4 and §2.3 for column matrix mutation, ordinary geometric
patterns, their cluster algebras with no frozen inverses, and the finite-word
reduction for locally finite mutable index sets.

## How to read the build

Layers 1 and 2 construct the actual algebra and its exact tensor category.
Layers 3 and 4 construct spectral families and fundamental modules. Layer 5
constructs rational R-matrices and their specialization. Layer 6 derives the
Grothendieck ring and the tensor-product theory of real simple objects. Layer 7
constructs Serre tensor subcategories, including the fundamental spectral
component categories. Layer 8 gives categorical seeds, exchange relations and
the monoidal-categorification predicate on these carriers.

## Layer 1: affine data and the derived quantum algebra

Construct the affine weight lattices, the derived Hopf subalgebra, the central
group-like element and its level-zero quotient, with their comparison maps.

## Layer 2: the finite-dimensional integrable category

Construct type-1 weight spaces and the category of finite-dimensional
integrable U′-modules. Prove it is abelian, finite-length and rigid, with a
biexact tensor product, and prove that every object has level zero.

## Layer 3: spectral families

Construct spectral shifts and affinization, specialization at every nonzero
parameter, and their compatibility with tensor products and both duals.

## Layer 4: fundamental representations

Construct the normalized fundamental modules of every affine type, their
spectral twists and the classification of simple modules by their fundamental
spectral data. Twisted parameter identifications are part of the theorem.

## Layer 5: rational R-matrices and specialization

Construct the completed universal intertwiner, the normalized rational
R-matrix for simple pairs, its monic denominator, and the nonzero specialized
renormalized map. Prove the braid relation where the rational maps are defined;
do not equip the entire specialized category with a braiding.

## Layer 6: Grothendieck rings and real simple tensor products

Construct the simple-class basis and prove commutativity of the exact
Grothendieck ring. Define real and prime simple objects and strong commutation.
Prove the real-simple head and socle theorem and the pairwise-simplicity
criterion for finite tensor products.

## Layer 7: Serre tensor subcategories

Construct the smallest full subcategory containing the unit and a given
family and closed under extensions, subquotients and tensor products. Define
the fundamental spectral graph on isomorphism classes, its connected-component
categories, and the injective maps on exact Grothendieck rings.

## Layer 8: categorical seeds and monoidal categorification

Define monoidal seeds with a countable locally finite exchange matrix,
categorical mutation and admissible seeds. Derive the Grothendieck-ring
exchange relation from the exact sequence. Define monoidal categorification
in the KKOP sense, including its chosen ring isomorphism and its condition on
every cluster monomial in every reachable cluster.

## Downstream consumers

The resulting category, fundamental modules, R-matrix denominators, real-simple
tensor-product API and categorical seed interface support quantum affine
Schur–Weyl duality and constructions of monoidal categorifications for named
Hernandez–Leclerc subcategories.

## References

- Kashiwara, Kim, Oh and Park, *Monoidal categorification and quantum affine
  algebras*, [arXiv:1910.08307v2](https://arxiv.org/abs/1910.08307v2), §§2, 5–6.
- Kashiwara, Kim, Oh and Park, *Monoidal categorification and quantum affine
  algebras II*, [arXiv:2103.10067v3](https://arxiv.org/abs/2103.10067v3), §§2, 7.
- Kang, Kashiwara, Kim and Oh, *Simplicity of heads and socles of tensor
  products*, [arXiv:1404.4125](https://arxiv.org/abs/1404.4125), §3.2.
- Hernandez, *Simple tensor products*,
  [arXiv:0907.3002](https://arxiv.org/abs/0907.3002), Theorem 1.1.
