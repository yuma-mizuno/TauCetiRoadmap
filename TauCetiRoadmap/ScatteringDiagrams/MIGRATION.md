# Mei implementation requirements for scattering diagrams

[README.md](README.md) specifies the mathematics. The requirements here identify
which constructions the affine, slab and focus-focus implementations in
[Mei](https://github.com/yuma-mizuno-lean/Mei) share, and which comparison theorems
connect their presentations. The hypotheses, scope and Checks are those of the
cited README sections. No additional mathematical objects are specified here.

## Broken lines and coefficient propagation

Use [§5.2's broken line](https://github.com/yuma-mizuno/TauCetiRoadmap/blob/mei/TauCetiRoadmap/ScatteringDiagrams/README.md#52-decorated-broken-lines)
for both ordinary walls and slab faces. Ordinary wall actions give graph
correspondences; slab faces give §0.8 correspondences with admissible lifts.
Affine ray coordinates and explicit slab enumerations must represent this same
construction.

Prove the correspondence between each presentation and the common broken-line
construction. It must preserve the whole path and incoming tail, the selected
incoming record, chamber and face encounters, degrees, decorations and endpoint.
Include the README's coordinate identifications and artificial subdivisions.
Retain simultaneous events, unchanged-degree encounters, nonzero degree shifts
with zero spatial projection, and constant incoming sections.

Define weighted evaluation on the common finite endpoint fiber. Evaluation
formulas in a computational presentation follow by reindexing through the
proved correspondence. Geometric parameterizations, classification results and
computable formulas remain useful presentations; repeated propagation and
evaluation definitions are expressed through the common API.

Use [§0.8's finite component expansion](https://github.com/yuma-mizuno/TauCetiRoadmap/blob/mei/TauCetiRoadmap/ScatteringDiagrams/README.md#08-homogeneous-coefficient-correspondences)
for compositions of transfers, including final projection, regrouping,
identity insertion, concatenation and zero extension on inadmissible pieces.
Keep its uniform finite-support hypothesis for identities of linear maps and
its semiring scope. BCH component identities are applications of this expansion.

For coefficient comparisons, distinguish §5.2's embedding theorem from the
general weighted identity. Injective chamber maps and degree isomorphisms give
the stated bijection under the common face, velocity, admissibility and incoming
data. General coefficient maps give equality after grouping histories and
discarding zero components. All comparisons respect the README's subdivision,
composition and truncation laws.

## Finite type families and local resolutions

Obtain affine and single-face families through
[§5.3's bounded-itinerary construction](https://github.com/yuma-mizuno/TauCetiRoadmap/blob/mei/TauCetiRoadmap/ScatteringDiagrams/README.md#53-endpoint-evaluation-closed-families-and-general-position).
Separate the construction from the encounter-bound argument. Use
`filtrationEncounterBound` for the affine relative-degree and positive-kink
instances, with their stated hypotheses.

Relate computational endpoint charts to this family, preserving the complete
types, weights and incoming histories. Prove exhaustivity, fixed-type
uniqueness, common-refinement and cover compatibility, and the prescribed
codimension-one boundary classification. Closed-chart extensions retain
collapsed and singular degenerations; these extensions are distinct from
admissible paths in the open family.

Use [§5.4's local resolutions](https://github.com/yuma-mizuno/TauCetiRoadmap/blob/mei/TauCetiRoadmap/ScatteringDiagrams/README.md#54-local-resolutions-and-gluing-of-sections)
for graph and slab correspondences. Apply finite component expansion to the
histories selected by the geometric incidence inequalities. Retain uniform
finite contributing support on the input module and the README's finite-input
test for arbitrary source modules.

At a terminal face, require a common lift of the two total chamber maps;
individual summands need not have lifts. Joint injectivity supplies uniqueness.
Reflecting a certificate through a coefficient embedding also requires the
specified preimage of its terminal face lift. Prove the concatenation,
subdivision, coefficient and cover comparisons required in §5.4.

## Theta sections and their presentations

Use [§5.4's `finiteSum_matchingFamily`](https://github.com/yuma-mizuno/TauCetiRoadmap/blob/mei/TauCetiRoadmap/ScatteringDiagrams/README.md#54-local-resolutions-and-gluing-of-sections)
to glue the weighted evaluations of a closed family with a local resolution
certificate. The affine and slab theta sections must be instances of
`globalThetaSection`, with its transport, linearity, naturality and truncation
laws. Restriction retains whole global incoming histories, including tails and
bends outside the endpoint domain.

Express [§5.6's monomial sums](https://github.com/yuma-mizuno/TauCetiRoadmap/blob/mei/TauCetiRoadmap/ScatteringDiagrams/README.md#56-monomial-presentations-and-comparison-of-theta-constructions)
in these same weighted evaluations. Use the common family and certificate
comparisons for
[affine covariance](https://github.com/yuma-mizuno/TauCetiRoadmap/blob/mei/TauCetiRoadmap/ScatteringDiagrams/README.md#61-integral-affine-covariance)
and [descent](https://github.com/yuma-mizuno/TauCetiRoadmap/blob/mei/TauCetiRoadmap/ScatteringDiagrams/README.md#62-descent-of-coefficient-diagrams-and-transport).
The positive global sections of
[§7.7](https://github.com/yuma-mizuno/TauCetiRoadmap/blob/mei/TauCetiRoadmap/ScatteringDiagrams/README.md#77-positive-formal-theta-coefficients)
use this gluing construction together with that section's positivity hypotheses.

For [§6.3's focus-focus datum](https://github.com/yuma-mizuno/TauCetiRoadmap/blob/mei/TauCetiRoadmap/ScatteringDiagrams/README.md#63-worked-example-the-focus-focus-slab-and-its-theta-basis),
apply the coefficient-embedding theorem to the displayed span comparison.
Check its degree maps, admissible lifts, incoming records and terminal-lift
preimages. Obtain the closed family and certificate from
`singleFaceBrokenLines` and `singleFaceResolution`.

Identify its global theta sections with the nodal algebra's monomial normal
forms by `slabTheta_normalForm`. Derive the basis, binomial multiplication,
scalar-change and completion statements from the
[§4.4 slab algebra](https://github.com/yuma-mizuno/TauCetiRoadmap/blob/mei/TauCetiRoadmap/ScatteringDiagrams/README.md#44-weight-zero-function-walls-and-face-algebras).
Preserve the explicit branch enumeration as a computation of the common
evaluation. The completion retains precisely the coefficient families with
finite support at each order, as required in §5.4.

## Relative completion and the module probe

Use [§3.3's `relativeAbelianCompletion`](https://github.com/yuma-mizuno/TauCetiRoadmap/blob/mei/TauCetiRoadmap/ScatteringDiagrams/README.md#33-local-scattering-and-existence-of-completion)
with [§3.4's uniqueness and naturality](https://github.com/yuma-mizuno/TauCetiRoadmap/blob/mei/TauCetiRoadmap/ScatteringDiagrams/README.md#34-uniqueness-and-compatibility).
Keep the lifted consistent quotient diagram fixed. Its supports may be
arbitrary §3.2 supports; the incoming ideal walls are full hyperplanes.
The outgoing ideal corrections have the specified pure birth logs and
truncation compatibility.

The [§5.5 probe](https://github.com/yuma-mizuno/TauCetiRoadmap/blob/mei/TauCetiRoadmap/ScatteringDiagrams/README.md#55-module-probes-and-affine-theta-transport)
uses degree group `Γ × ℤ`, tangent lattice `Λ × ℤ`, and spatial projection
`ρ_ext(x,c) = (ρ(x),0)`. The charge is a grading coordinate. There is one
auxiliary spatial coordinate, `z`, and the probe wall is `z = 0`.
State the probe grading, wall spaces, cylinders, coefficient extraction and
transport over these carriers.

Apply relative abelian completion with the cylinder diagram as fixed quotient.
Prove the regular-crossing, far-ray and zero-spatial-direction assertions
using this projection. The finite-order and completed coefficient maps must
satisfy the stated cutoff and conjugation identities.

Use §5.5's common backward-ray operator for the independently proved probe and
broken-line recursions. Apply §0.8's finite-recursion uniqueness to identify
their solutions. Include auxiliary-arrangement independence, generic
stability and zero-spatial-direction components.

Use `operatorProbe` and the incident tangent diagram for
`affineLocalResolution`; relative completion must accept these supports.
The affine theta section is then the §5.4 section of its closed family and
certificate. A probe-derived coefficient field supplies the comparison
theorem's probe side; the equality with the weighted path sum is proved by
the two recursions.

## Dependencies and completion

The component expansion supplies weighted coefficient comparisons and local
resolution identities. The broken-line correspondence supplies the
computational presentations of closed type families. These families and their
certificates supply the common theta construction.

The single-face specialization uses its encounter bound and common face
lifts. The affine specialization uses relative completion, the probe comparison
and the operator-probe certificate. The single-face construction does not
require the affine probe comparison.

For each common construction, prove its defining comparisons and all induced
evaluation, coefficient, coordinate and truncation equations. Express its
consumers through these comparisons and remove superseded public definitions
and repeated proofs. Preserve useful additional generality, geometric results
and computable operations.

Apply the README's completion criteria and Checks to the resulting common
constructions and their specializations. Formula agreement without the
specified path, incoming-data and section comparisons does not discharge
these requirements.

## Provenance: source presentations

The links below identify source declarations for reuse and comparison.
They are secondary to the intrinsic requirements above and the README;
their names and file layout do not prescribe the resulting public API.

| Source | Role |
|---|---|
| [Homogeneous-history expansion](https://github.com/yuma-mizuno-lean/Mei/blob/280b226248836604caa2517e217e6b320c9b3ce6/Mei/LinearAlgebra/GradedModule/History/Expansion.lean), [filtered nilpotence](https://github.com/yuma-mizuno-lean/Mei/blob/280b226248836604caa2517e217e6b320c9b3ce6/Mei/LinearAlgebra/ModuleFiltration/Nilpotent.lean), [BCH component identities](https://github.com/yuma-mizuno-lean/Mei/blob/280b226248836604caa2517e217e6b320c9b3ce6/Mei/Algebra/Lie/Graded/Shifted/Resolution.lean) | Algebraic suppliers for finite component expansion and recursion. Check their support and scalar hypotheses when applying them. |
| [`CutoffDecoratedRay`](https://github.com/yuma-mizuno-lean/Mei/blob/280b226248836604caa2517e217e6b320c9b3ce6/Mei/Geometry/ScatteringDiagram/BrokenLine/Itineraries.lean), [charts](https://github.com/yuma-mizuno-lean/Mei/blob/280b226248836604caa2517e217e6b320c9b3ce6/Mei/Geometry/ScatteringDiagram/BrokenLine/Charts.lean), [degenerations](https://github.com/yuma-mizuno-lean/Mei/blob/280b226248836604caa2517e217e6b320c9b3ce6/Mei/Geometry/ScatteringDiagram/BrokenLine/Degeneration.lean) | Affine ray and closed-chart presentations to identify with the common broken lines and type families. |
| [Coefficient comparison](https://github.com/yuma-mizuno-lean/Mei/blob/280b226248836604caa2517e217e6b320c9b3ce6/Mei/Geometry/ScatteringDiagram/BrokenLine/CoefficientMap.lean) | Fixed-itinerary weighted comparison to connect to the common coefficient-morphism statements. |
| [Probe degrees](https://github.com/yuma-mizuno-lean/Mei/blob/280b226248836604caa2517e217e6b320c9b3ce6/Mei/Geometry/ScatteringDiagram/ModuleProbe/Degree.lean), [initial walls](https://github.com/yuma-mizuno-lean/Mei/blob/280b226248836604caa2517e217e6b320c9b3ce6/Mei/Geometry/ScatteringDiagram/ModuleProbe/Initial.lean), [backward recursion](https://github.com/yuma-mizuno-lean/Mei/blob/280b226248836604caa2517e217e6b320c9b3ce6/Mei/Geometry/ScatteringDiagram/ModuleProbe/BackwardRecursion.lean) | Probe algebra and transport proofs to express on §5.5's degree and spatial carriers, checking the geometric assertions for its projection. |
| [Facet descent](https://github.com/yuma-mizuno-lean/Mei/blob/280b226248836604caa2517e217e6b320c9b3ce6/Mei/Topology/Sheaves/LocallyConstant/FacetDescent/Hom.lean), [sheaf multispans](https://github.com/yuma-mizuno-lean/Mei/blob/280b226248836604caa2517e217e6b320c9b3ce6/Mei/Topology/Sheaves/Multispan.lean) | Suppliers for extension of total chamber maps and reconstruction of matching families from common face lifts. |
| [Signed monomials](https://github.com/yuma-mizuno-lean/Mei/blob/280b226248836604caa2517e217e6b320c9b3ce6/Mei/RingTheory/Node/SignedMonomial.lean) | Algebraic normal forms, basis and products used to compute the common slab theta sections. |
| [`SlabBrokenLine`](https://github.com/yuma-mizuno-lean/Mei/blob/280b226248836604caa2517e217e6b320c9b3ce6/Mei/Geometry/ScatteringDiagram/FocusFocus/Decorated.lean), [slab families](https://github.com/yuma-mizuno-lean/Mei/blob/280b226248836604caa2517e217e6b320c9b3ce6/Mei/Geometry/ScatteringDiagram/FocusFocus/Family.lean), [`slabThetaEvaluation`](https://github.com/yuma-mizuno-lean/Mei/blob/280b226248836604caa2517e217e6b320c9b3ce6/Mei/Geometry/ScatteringDiagram/FocusFocus/Evaluation.lean) | Explicit slab paths and evaluations to identify with the common single-face family and weighted evaluation. |
| [Focus-focus span comparison](https://github.com/yuma-mizuno-lean/Mei/blob/280b226248836604caa2517e217e6b320c9b3ce6/Mei/Geometry/ScatteringDiagram/FocusFocus/Comparison/Diagram.lean) | Coefficient-diagram comparison used to transfer families, certificates and theta sections through the specified embeddings and face isomorphism. |
