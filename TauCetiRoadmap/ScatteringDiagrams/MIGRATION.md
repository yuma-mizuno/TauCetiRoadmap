# Mei implementation migration targets

These targets integrate the affine, slab and focus-focus implementations in
[Mei](https://github.com/yuma-mizuno-lean/Mei) with the constructions specified in
[README.md](README.md). The README supplies the mathematical definitions,
hypotheses and Checks. The targets here require the corresponding implementations
to share those constructions, with proved comparisons for their computational
presentations.

## Dependencies

| Target | Required suppliers |
|---|---|
| R1. Shared coefficient expansion and recursion | §0.8 |
| R2. Broken lines and the affine presentation | §5.2; R1 for weighted coefficient comparisons |
| R3. Closed type families | §1.3 and R2; §5.3's encounter bounds |
| R4. Local resolutions and theta gluing | R1 and the relevant R3 families; §5.4 |
| R5. Relative abelian completion | §§0–3, with the hypotheses of §§3.3–3.4 |
| R6. Probe geometry and coefficient fields | R5 and §5.1; §5.5's probe data |
| R7. Affine probe comparison and theta sections | R1–R3 and R6; R4 for the theta section |
| R8. Focus-focus specialization | R2, R3's single-face family, R4 and §6.3's datum |

These are dependencies between mathematical constructions. In particular,
single-face gluing and R8 do not require the affine probe comparison.
A supplier used from a target need not depend on unrelated applications of that
target. The source-to-target correspondence is in the
[secondary provenance table](#provenance-source-to-target-correspondence).

## R1. Shared coefficient expansion and recursion

**Specification:** [§0.8](https://github.com/yuma-mizuno/TauCetiRoadmap/blob/mei/TauCetiRoadmap/ScatteringDiagrams/README.md#08-homogeneous-coefficient-correspondences).

**Integration.** Use one finite-component expansion for transfer compositions
between graded chamber modules. It must cover final projection, regrouping,
identity insertion, concatenation, zero extension on inadmissible pieces and
coefficient intertwining. For identities of linear maps retain the README's
uniform finite support on the input submodule. A theorem assuming globally
finite grading support supplies an instance, not the whole required generality.

Use one finite-recursion uniqueness theorem for `x = a + U(x)` with `U^r = 0`,
whose solution is `Σ_{j<r} U^j(a)`. Preserve the semimodule scope of §0.8.
Filtration-raising nilpotence over rings supplies its applicable instances.

**Completion.** The shared expansion supplies the uniform-input linear-map
identities required by R4, and BCH component-map identities factor through it.
The recursion theorem applies to R7's filtration-raising operator without
assuming either geometric recursion. Retain useful specialized formulas as
consequences, with no separate proof of the same expansion or uniqueness argument.

## R2. Broken lines and the affine presentation

**Specification:** [§5.2](https://github.com/yuma-mizuno/TauCetiRoadmap/blob/mei/TauCetiRoadmap/ScatteringDiagrams/README.md#52-decorated-broken-lines).

**Integration.** Use §5.2's `BrokenLine`, `DecoratedType` and
`weightedEvaluation` as the common constructions. Ordinary walls supply graph
correspondences; slabs supply the admissible-lift correspondences of §0.8.

Prove a correspondence between the affine ray presentation and this
specialization. Preserve the path, incoming tail and record, endpoint,
encounter order and parameters, chart identifications, degrees and entire
nonzero decorations. Include simultaneous events and unchanged-degree
encounters. Account for artificial subdivisions and retain degree changes
in the kernel of the spatial projection. Include constant incoming sections.

Prove `brokenLine_coefficientEmbedding` with the README's injective chamber
maps, degree isomorphisms and common face, velocity, admissibility and incoming
data. For general coefficient maps, prove the grouped weighted identity
instead; cancellation can remove histories.

**Completion.** Reindexing the common finite endpoint fiber recovers each affine
evaluation and its linear-map form. The coefficient, subdivision and truncation
comparisons agree with those of §5.2. The public propagation and evaluation API
uses this common construction. An explicit ray carrier can remain as a
computational presentation with the proved correspondence, rather than an
independent definition of broken lines or theta weights.

## R3. Closed type families

**Specification:** [§5.3](https://github.com/yuma-mizuno/TauCetiRoadmap/blob/mei/TauCetiRoadmap/ScatteringDiagrams/README.md#53-endpoint-evaluation-closed-families-and-general-position).

**Integration.** Use `boundedItineraries_finiteClosedTypeFamily` for the
affine and single-face families. Separate backward reconstruction and closed
endpoint charts from the encounter-bound argument. Supply
`filtrationEncounterBound`, then its affine relative-degree and positive-kink
applications under the stated hypotheses.

Identify the affine endpoint charts with charts of the common family.
The identification preserves complete types, weights and global incoming
histories, including the individual incoming tails. Prove exhaustion,
fixed-endpoint-and-type uniqueness, subdivision and common-refinement laws,
and compatibility on endpoint covers.

Construct `singleFaceBrokenLines` with the full half-space incoming datum.
Retain the closed boundary charts and the prescribed codimension-one event
classification, including collapsed, terminal and singular degenerations.

**Completion.** The affine, positive-kink and single-face applications have
the stated finite-family properties. Their discriminant, genericity and
local-stability results apply to R2's actual evaluation fibers.
Their closed-chart extensions realize the required degenerations without
asserting that singular or nontransverse boundary paths are admissible.
Reusable affine geometry supplies these comparisons; a second, unrelated
closed-family construction is unnecessary.

## R4. Local resolutions and theta gluing

**Specification:** [§5.4](https://github.com/yuma-mizuno/TauCetiRoadmap/blob/mei/TauCetiRoadmap/ScatteringDiagrams/README.md#54-local-resolutions-and-gluing-of-sections)
and [§4.4](https://github.com/yuma-mizuno/TauCetiRoadmap/blob/mei/TauCetiRoadmap/ScatteringDiagrams/README.md#44-weight-zero-function-walls-and-face-algebras).

**Integration.** Construct `localResolution_expansion` from the relevant R3
charts. Use R1 on the histories selected by the geometric incidence
inequalities, retaining uniform finite contributing support and §5.4's
finite-input test. Equal unrestricted operator words alone do not identify
geometric local resolutions.

Use one `singleFaceResolution` for graph and slab correspondences.
At terminal faces the two total chamber maps require a common face lift;
separate branch lifts are not required. Joint injectivity supplies uniqueness.
Reflection through a coefficient embedding also requires the specified
preimage of the terminal lift.

Use the facet-descent and multispan suppliers to establish
`finiteSum_matchingFamily`. Obtain `globalThetaSection` from a closed family
and its certificate, together with transport, linearity, coefficient,
refinement, restriction and truncation comparisons.
Restrictions retain whole global incoming histories.

**Completion.** The single-face section and its `slabTheta_normalForm` are
applications of this gluing construction. Its theorem accepts the affine
certificate supplied by R7 without requiring R7 in its own proof.
Reuse the slab normal-form basis and multiplication for the theta algebra;
retain coefficient families with finite support at each order in the completion.

## R5. Relative abelian completion

**Specification:** [§3.3](https://github.com/yuma-mizuno/TauCetiRoadmap/blob/mei/TauCetiRoadmap/ScatteringDiagrams/README.md#33-local-scattering-and-existence-of-completion)
and [§3.4](https://github.com/yuma-mizuno/TauCetiRoadmap/blob/mei/TauCetiRoadmap/ScatteringDiagrams/README.md#34-uniqueness-and-compatibility).

**Integration.** Establish `relativeAbelianCompletion` for the specified split
extension `h = g ⋉ I`, keeping the lifted consistent quotient diagram fixed.
Its supports are arbitrary §3.2 supports. The incoming ideal walls are full
hyperplanes and finite at each order; the outgoing ideal corrections have the
specified pure birth logs and truncation compatibility.

Adapt the obstruction, cochain and sweep suppliers to this relative statement.
Prove `relativeAbelianCompletion_unique`, invariance under quotient-diagram
equivalence, and naturality under the split-extension maps and cutoff moduli.

**Completion.** The theorem applies both to R6's fixed cylinder diagram and to
R7's incident tangent diagrams. A completion theorem imposing full-hyperplane
supports on the quotient diagram does not supply this contract. Preserve the
ordinary outgoing-completion API and its full-hyperplane hypotheses as its
own theorem.

## R6. Probe geometry and coefficient fields

**Specification:** [§5.5](https://github.com/yuma-mizuno/TauCetiRoadmap/blob/mei/TauCetiRoadmap/ScatteringDiagrams/README.md#55-module-probes-and-affine-theta-transport),
`moduleProbe`, `probeCompletion` and `probeTransport`.

**Integration.** Express the probe over degree group `Γ × ℤ`, tangent lattice
`Λ × ℤ` and projection `ρ_ext(x,c) = (ρ(x),0)`. The charge is a grading
coordinate; the single auxiliary spatial coordinate is `z`.
Cylinder walls are `d × ℝ`; the probe wall is `z = 0` with degree `(p,1)`.

Carry the positive-degree, ray, semidirect-action, quotient, completed-kernel
and conjugation APIs to these carriers. Keep the relative/probe cutoff relation
`k ↔ k+1`. Apply R5 with the cylinder diagram fixed.
Extract the field from a short upward crossing at `(Q,0)`, with label
`exp(-F(Q))`, independently of the short crossing.

**Completion.** The cylinder, completion, field, transport, far-ray and
zero-spatial-direction theorems hold for this projection, and their consumers
use these carriers. There is no field parameter or selection theorem for a
second auxiliary height. The change of spatial directions requires proofs of
regularity and outgoingness for the stated geometry, not an assertion that
dropping a coordinate transports those properties automatically.

## R7. Affine probe comparison and theta sections

**Specification:** [§5.5](https://github.com/yuma-mizuno/TauCetiRoadmap/blob/mei/TauCetiRoadmap/ScatteringDiagrams/README.md#55-module-probes-and-affine-theta-transport),
`backwardRayOperator` through `theta_coeffMap`.

**Integration.** Construct the common filtration-raising operator `U` on
the generic endpoint functions. Prove `U^(k+1) = 0`.
Independently prove the broken-line and probe equations `Θ = b + UΘ` and
`F = b + UF`, then use R1 to obtain `probeWall_eq_brokenLineSum`.

The broken-line equation uses the actual R2 fibers and R3 closed charts:
cut at the last positive-degree change, deform the prefix in its closed chart,
and attach the terminal segment with all intervening identity encounters.
The probe equation uses R6's transport and far-ray values.
Keep zero component terms in the finite linear-map sums and discard zero
decorations when enumerating actual paths. Retain nonzero shifts in `ker ρ`
and the zero-spatial-direction cases with the conventions of §5.5.
Prove independence of the exceptional refinement and incoming-point choices.

Construct `operatorProbe` and the incident tangent-diagram comparison for
`affineLocalResolution`, using R5 for its supports. Apply R4 to this certificate.

**Completion.** The affine theta section is the common `globalThetaSection`
and satisfies its transport, coefficient and truncation laws. The probe field
and the weighted path sum are identified by the two recursions, not by defining
one to be the other.

## R8. Focus-focus specialization

**Specification:** [§6.3](https://github.com/yuma-mizuno/TauCetiRoadmap/blob/mei/TauCetiRoadmap/ScatteringDiagrams/README.md#63-worked-example-the-focus-focus-slab-and-its-theta-basis),
with §§4.4 and 5.2–5.4.

**Integration.** Use `focusFocusDatum` and its displayed comparison with the
slab correspondence. Verify chamber injectivity, degree isomorphisms,
admissible lifts, incoming records and terminal-lift preimages.
Apply R2's embedding comparison, R3's `singleFaceBrokenLines` and
R4's `singleFaceResolution` to obtain the global family and certificate.

Identify the explicit slab paths with this specialization, preserving their
full geometry and weights. Their binomial enumeration computes the common
weighted evaluation. Define the geometric focus-focus theta section through
R4; identify its values with the algebraic monomials by `slabTheta_normalForm`.

**Completion.** The fiber enumeration, theta basis, product, scalar-change and
completion statements are consequences of the common construction and the
nodal normal-form algebra, including §6.3's Checks. Keep the algebraic
monomials and multiplication formulas as computational results. Equality of
two chamber formulas alone does not establish the global family, certificate
or section comparison.

## Other consumers

Express [§5.6's monomial sums](https://github.com/yuma-mizuno/TauCetiRoadmap/blob/mei/TauCetiRoadmap/ScatteringDiagrams/README.md#56-monomial-presentations-and-comparison-of-theta-constructions)
in the same weighted evaluation; its presentation-invariance result uses R7.
For [§6.1 covariance](https://github.com/yuma-mizuno/TauCetiRoadmap/blob/mei/TauCetiRoadmap/ScatteringDiagrams/README.md#61-integral-affine-covariance)
and [§6.2 descent](https://github.com/yuma-mizuno/TauCetiRoadmap/blob/mei/TauCetiRoadmap/ScatteringDiagrams/README.md#62-descent-of-coefficient-diagrams-and-transport),
transport R2–R4's whole families, certificates and global incoming histories.
Use this section construction in
[§7.7](https://github.com/yuma-mizuno/TauCetiRoadmap/blob/mei/TauCetiRoadmap/ScatteringDiagrams/README.md#77-positive-formal-theta-coefficients)
with that section's separate positivity hypotheses.

For each migrated construction, express its callers through the canonical API,
update their imports and remove the superseded definitions and repeated proofs.
Retain useful additional generality, geometric theorems and computable
presentations. A correspondence theorem with consumers still using an
independent duplicate does not complete the integration.

## Provenance: source-to-target correspondence

These source references identify declarations to reuse, compare or replace.
They are secondary to the intrinsic contracts above and do not prescribe the
final names or file layout.

| Source API | Target and required relation |
|---|---|
| [`sum_homogeneousHistory_eq_prod`](https://github.com/yuma-mizuno-lean/Mei/blob/32d27ceb745338863a19ce9b12c001d0dc6ae5fb/Mei/LinearAlgebra/GradedModule/History/Expansion.lean); [BCH resolution identities](https://github.com/yuma-mizuno-lean/Mei/blob/32d27ceb745338863a19ce9b12c001d0dc6ae5fb/Mei/Algebra/Lie/Graded/Shifted/Resolution.lean) | R1. Supply the shared expansion; preserve the globally finite-support specialization and express BCH formulas through it. Cover varying chamber modules and the uniform input-support hypothesis. |
| [`ModuleFiltration.quotientRaisingEnd_pow_eq_zero`](https://github.com/yuma-mizuno-lean/Mei/blob/32d27ceb745338863a19ce9b12c001d0dc6ae5fb/Mei/LinearAlgebra/ModuleFiltration/Nilpotent.lean) | R1. Keep the filtration-raising nilpotence supplier and use it for finite recursion where its ring hypotheses apply; it does not by itself supply the full semimodule uniqueness statement. |
| [`CutoffDecoratedRay`, `CutoffDecoratedType`, `cutoffDecoratedEvaluation`](https://github.com/yuma-mizuno-lean/Mei/blob/32d27ceb745338863a19ce9b12c001d0dc6ae5fb/Mei/Geometry/ScatteringDiagram/BrokenLine/Itineraries.lean); [`cutoffDecoratedEvaluationLinearMap`](https://github.com/yuma-mizuno-lean/Mei/blob/32d27ceb745338863a19ce9b12c001d0dc6ae5fb/Mei/Geometry/ScatteringDiagram/BrokenLine/Itineraries/Linear.lean) | R2–R3. Identify the ray and type carriers with the common affine presentation. Prove that reindexing `weightedEvaluation` gives `cutoffDecoratedEvaluation` and the value of its linear map. Retain the explicit endpoint parameterization; remove independently duplicated propagation or evaluation proofs. |
| [`map_cutoffDecoratedEvaluation`](https://github.com/yuma-mizuno-lean/Mei/blob/32d27ceb745338863a19ce9b12c001d0dc6ae5fb/Mei/Geometry/ScatteringDiagram/BrokenLine/Itineraries/Map.lean); [`map_completedBCHCutoffEvaluation`](https://github.com/yuma-mizuno-lean/Mei/blob/32d27ceb745338863a19ce9b12c001d0dc6ae5fb/Mei/Geometry/ScatteringDiagram/BrokenLine/Itineraries/Naturality.lean) | R2 and R7. Connect finite and completed coefficient laws to the common comparisons, preserving their degree-fixed specialization and zero-decoration handling. A source fiber restricted to surviving weights is not a bijection of unrestricted fibers. |
| [Affine polyhedral charts](https://github.com/yuma-mizuno-lean/Mei/blob/32d27ceb745338863a19ce9b12c001d0dc6ae5fb/Mei/Geometry/ScatteringDiagram/BrokenLine/Charts.lean); [closed degenerations](https://github.com/yuma-mizuno-lean/Mei/blob/32d27ceb745338863a19ce9b12c001d0dc6ae5fb/Mei/Geometry/ScatteringDiagram/BrokenLine/Degeneration.lean) | R3. Reuse the reconstruction and closed-chart maps. Identify their domains with the common family and prove its exhaustion and boundary classification; preserve continuous boundary paths without claiming boundary admissibility. |
| [`matchingFamilyEquiv`](https://github.com/yuma-mizuno-lean/Mei/blob/32d27ceb745338863a19ce9b12c001d0dc6ae5fb/Mei/Algebra/Category/SemimoduleCat/Multispan/Basic.lean); [facet descent](https://github.com/yuma-mizuno-lean/Mei/blob/32d27ceb745338863a19ce9b12c001d0dc6ae5fb/Mei/Topology/Sheaves/LocallyConstant/FacetDescent/Hom.lean); [`existsUnique_sections_lift_of_local`](https://github.com/yuma-mizuno-lean/Mei/blob/32d27ceb745338863a19ce9b12c001d0dc6ae5fb/Mei/Topology/Sheaves/Multispan.lean) | R4. Use these suppliers to assemble `finiteSum_matchingFamily`; the required connection is from complete local resolutions and total branch maps to the supplied facet and face-lift hypotheses. Do not duplicate matching-family reconstruction. |
| [Probe `degreeEmbedding`, `positiveDegrees` and rays](https://github.com/yuma-mizuno-lean/Mei/blob/32d27ceb745338863a19ce9b12c001d0dc6ae5fb/Mei/Geometry/ScatteringDiagram/ModuleProbe/Degree.lean) | R6. Replace allowed degrees `(x,c,0)` in `Γ × ℤ × ℤ` by `(x,c)` in `Γ × ℤ`; update grading and ray consumers. Preserve positivity, finite cutoffs, charge-one primitiveness and the `k+1` cutoff identity. |
| [`baseCylinder`, `probeWall`, `initialDiagram`](https://github.com/yuma-mizuno-lean/Mei/blob/32d27ceb745338863a19ce9b12c001d0dc6ae5fb/Mei/Geometry/ScatteringDiagram/ModuleProbe/Initial.lean); [charge-zero comparison](https://github.com/yuma-mizuno-lean/Mei/blob/32d27ceb745338863a19ce9b12c001d0dc6ae5fb/Mei/Geometry/ScatteringDiagram/ModuleProbe/ChargeZero.lean) | R5–R6. Replace the completion route for a combined full-hyperplane input by relative completion over the prescribed consistent cylinder. Retain the ordinary full-hyperplane theorem and reusable label comparisons. The relative theorem must also accept arbitrary quotient supports. |
| [`completedBaseProjection`, `completedKernelEquiv` and conjugation](https://github.com/yuma-mizuno-lean/Mei/blob/32d27ceb745338863a19ce9b12c001d0dc6ae5fb/Mei/Geometry/ScatteringDiagram/ModuleProbe/Projection.lean) | R6. Carry the semidirect kernel/extraction API to the reduced degree carriers, keeping the projection, cutoff and conjugation equations used by the field and transport. |
| [`verticalCoefficient_eq_of_height`](https://github.com/yuma-mizuno-lean/Mei/blob/32d27ceb745338863a19ce9b12c001d0dc6ae5fb/Mei/Geometry/ScatteringDiagram/ModuleProbe/Height.lean); [`coefficientField`](https://github.com/yuma-mizuno-lean/Mei/blob/32d27ceb745338863a19ce9b12c001d0dc6ae5fb/Mei/Geometry/ScatteringDiagram/ModuleProbe/Field.lean) | R6. Replace the field constructed from `(Q,y,0)` and a selected regular `y` by the field from the short crossing at `(Q,0)`. Update all field and transport consumers; the height parameter and height-selection dependency disappear. Reprove regularity for `ρ_ext(x,c)=(ρ(x),0)`. |
| [`exists_backwardRayRecursionArrangement`](https://github.com/yuma-mizuno-lean/Mei/blob/32d27ceb745338863a19ce9b12c001d0dc6ae5fb/Mei/Geometry/ScatteringDiagram/ModuleProbe/BackwardRecursion.lean) | R7. Reuse the probe-side jump argument in the reduced geometry, identify it with the common operator and establish the independent equation for actual broken-line fibers. |
| [`SlabBrokenLine`](https://github.com/yuma-mizuno-lean/Mei/blob/32d27ceb745338863a19ce9b12c001d0dc6ae5fb/Mei/Geometry/ScatteringDiagram/FocusFocus/Decorated.lean); [slab family charts](https://github.com/yuma-mizuno-lean/Mei/blob/32d27ceb745338863a19ce9b12c001d0dc6ae5fb/Mei/Geometry/ScatteringDiagram/FocusFocus/Family.lean); [`slabThetaEvaluation`](https://github.com/yuma-mizuno-lean/Mei/blob/32d27ceb745338863a19ce9b12c001d0dc6ae5fb/Mei/Geometry/ScatteringDiagram/FocusFocus/Evaluation.lean) | R8. Identify these explicit paths, charts and evaluations with the common single-face family. Preserve the binomial computations; derive their evaluations and global section interpretation through the common construction. |
| [`FocusFocus.theta` and `theta_mul_theta`](https://github.com/yuma-mizuno-lean/Mei/blob/32d27ceb745338863a19ce9b12c001d0dc6ae5fb/Mei/Geometry/ScatteringDiagram/FocusFocus/Theta.lean); [nodal signed monomials and basis](https://github.com/yuma-mizuno-lean/Mei/blob/32d27ceb745338863a19ce9b12c001d0dc6ae5fb/Mei/RingTheory/Node/SignedMonomial.lean) | R4 and R8. Keep the algebraic definitions, basis and product. Prove their equality with values of `globalThetaSection`; do not replace an algebraic computation by an unproved geometric interpretation. |
| [Focus-focus span comparison](https://github.com/yuma-mizuno-lean/Mei/blob/32d27ceb745338863a19ce9b12c001d0dc6ae5fb/Mei/Geometry/ScatteringDiagram/FocusFocus/Comparison/Diagram.lean); [scalar and cutoff naturality](https://github.com/yuma-mizuno-lean/Mei/blob/32d27ceb745338863a19ce9b12c001d0dc6ae5fb/Mei/Geometry/ScatteringDiagram/FocusFocus/Naturality.lean) | R8. Use the span and tower squares to transport common paths, families and certificates, checking the degree, lift and incoming-data conditions as well as scalar and cutoff compatibility. |
