# Mei migration to the unified broken-line and theta constructions

This plan guides work in [Mei](https://github.com/yuma-mizuno-lean/Mei) against
the scattering specification in [README.md](README.md). It is maintained on the
`mei` branch of this roadmap repository. The `scattering-rev` branch retains
the mathematical specification without this implementation plan.

All mathematical requirements below come from that README. This document maps
them to existing Mei code and records the order and completion conditions for
the migration. It introduces no mathematical definitions or additional targets.
Names from the README remain suggested names, as stated in its conventions.

## Baseline and use

The specification baseline is
[`1d8aa579`](https://github.com/yuma-mizuno/TauCetiRoadmap/commit/1d8aa57956348365b1bf67de9b16e83c9d6ee244),
“Unify broken-line and theta roadmap constructions”.
The implementation survey below reads Mei at
[`280b2262`](https://github.com/yuma-mizuno-lean/Mei/tree/280b226248836604caa2517e217e6b320c9b3ce6),
on 31 October 2026. It checks source definitions and theorem statements; it
does not certify a new build or the completion of any roadmap layer.
Refresh the implementation survey against current Mei `main` before selecting work.

Use the existing roadmap authoring, CI, review and repair workflow.
The author reads this plan with the README, checks current `main` and open PRs,
and selects one unmet item whose prerequisites are on `main`.
An item can require several independent, complete PRs. Give each prerequisite
its actual consumer; start dependent work after its prerequisite merges.
Existing general results remain available to unrelated roadmap work.

Each implementation PR names its migration item and exact README target,
lists the old declarations it changes, and states what remains.
Use the existing `Roadmap: ScatteringDiagrams` attribution and target-marker
conventions. Run the project's required build, axiom, import and lint checks.
Reviewers check both the mathematical target and the replacement conditions below.
After merge, the maintainer records the PR and verifies the resulting `main`
before marking an item complete. An open PR is work in progress.

## What counts as replacement

Give each mathematical construction one public definition. An affine endpoint
parameterization or an explicit slab enumeration can remain as a computational
presentation when its correspondence with the common construction is proved.
Such a correspondence must preserve the whole path, incoming tail, encounter
data and final weight; agreement of final formulas alone is insufficient.

For each migrated part, update its callers and imports and remove the superseded
definition or repeated proof. Keep useful geometric bounds, normal forms,
computable operations and additional generality. Do not retain a second public
construction solely to preserve an old name. During a multi-PR migration,
identify every remaining independent construction and its consumers explicitly.

The README's hypotheses and Checks remain the acceptance criteria. In particular:

- A coefficient embedding can give a bijection of broken lines under §5.2's
  hypotheses. A general coefficient map gives a grouped identity of weighted
  sums; it need not give a bijection.
- Reflecting a terminal certificate through an embedding also requires the
  specified preimage of its face lift.
- Closed boundary charts retain degenerations. They do not make a singular or
  nontransverse boundary path an admissible broken line.
- Restriction of a theta section retains its global incoming histories,
  including tails and bends outside the restricted endpoint domain.

## Work items

The dependency column names the suppliers to use. It does not require finishing
every application in an earlier item before using one of its merged theorems.
For example, single-face work in M06 and M08 needs M03's single-face family,
not its positive-kink application. Work on M01 and M04 can start independently.

| Item | Result | Prerequisites | Verified completion |
|---|---|---|---|
| M01 | Finite component expansion and nilpotent recursion | Existing linear algebra | Open |
| M02 | Common broken lines and coefficient comparisons | M01 for weighted comparisons | Open |
| M03 | Bounded itineraries and closed type families | M02 | Open |
| M04 | Relative abelian completion | Existing Layers 0–3 suppliers | Open |
| M05 | Probe with one auxiliary spatial coordinate | M04 | Open |
| M06 | Local resolutions and common theta gluing | M01–M03 | Open |
| M07 | Affine probe comparison and theta sections | M01–M03, M05–M06 | Open |
| M08 | Focus-focus as a single-face specialization | M01–M03, M06; §6.3 datum | Open |

“Open” means that the migration acceptance conditions have not been certified
here. It does not mean that all of the required mathematics is absent.
Reuse the baseline suppliers listed at the end of this document.

### M01. Finite component expansion and recursion

**Target:** [§0.8](https://github.com/yuma-mizuno/TauCetiRoadmap/blob/mei/TauCetiRoadmap/ScatteringDiagrams/README.md#08-homogeneous-coefficient-correspondences),
finite component expansion and finite recursion.

Use the existing homogeneous-history API to supply §0.8's finite component
expansion for the correspondence data. Cover final projection, regrouping,
identity insertion, concatenation, zero extension on inadmissible degrees and
coefficient intertwining. State linear-map identities under uniform finite
support on the input submodule. The current globally finite grading-support
theorem is a supplier, rather than a replacement for this hypothesis.

Prove uniqueness and the finite-sum formula for `x = a + U(x)` when `U^r = 0`,
over the semimodules required in §0.8. Reuse the filtration-raising nilpotence
results where their ring hypotheses apply; preserve the semiring scope.

**Complete when:** the shared statements supply both variable-input component
identities for local resolutions and the finite recursion used in M07.
Keep BCH-specific results as applications of this API.

### M02. One broken-line construction

**Target:** [§5.2](https://github.com/yuma-mizuno/TauCetiRoadmap/blob/mei/TauCetiRoadmap/ScatteringDiagrams/README.md#52-decorated-broken-lines),
including `brokenLine_coefficientEmbedding`.

Use §5.2's broken line as the common construction for chamber/face
correspondences, chart data and incoming data. Ordinary walls use graph
correspondences. Its type, endpoint, decorations, finite-fiber weighted
evaluation and subdivision/truncation laws are the ones required there.

Relate `CutoffDecoratedRay` to the affine specialization using its actual
encounter and incoming data. Account for simultaneous events, unchanged-degree
encounters and nonzero shifts in the kernel of the spatial projection.
Include constant incoming sections. Prove the coefficient-embedding comparison
and the separate grouped weighted comparison for general coefficient maps.

**Complete when:** the affine public construction and evaluation use the common
definition or its proved computational presentation, and all affected callers
use that API. The same interface must accept slab correspondences; its
focus-focus instance is completed in M08.

### M03. Construct closed families from encounter bounds

**Target:** [§5.3](https://github.com/yuma-mizuno/TauCetiRoadmap/blob/mei/TauCetiRoadmap/ScatteringDiagrams/README.md#53-endpoint-evaluation-closed-families-and-general-position),
especially `boundedItineraries_finiteClosedTypeFamily`,
`filtrationEncounterBound` and `singleFaceBrokenLines`.

Separate the general finite-tree/backward-reconstruction construction from the
proof of an encounter bound. With filtration length `r` and at most `h`
unmarked encounters between marked steps, prove the stated bound
`r h + r - 1`. Apply it to affine relative degree and to positive-kink data.

Reuse the affine polyhedral charts and continuous closed-chart extensions.
Complete the boundary-event classification, exhaustion, subdivision, common
refinement and endpoint-cover comparisons required by the README.
Construct the single-face family with its full half-space incoming data.

**Complete when:** affine and single-face families are instances of the same
construction, with the README's finite fibers, genericity and boundary
conditions proved. Existing closed charts alone do not close this item.

### M04. Complete an abelian ideal over a fixed diagram

**Targets:** [§3.3](https://github.com/yuma-mizuno/TauCetiRoadmap/blob/mei/TauCetiRoadmap/ScatteringDiagrams/README.md#33-local-scattering-and-existence-of-completion)
and [§3.4](https://github.com/yuma-mizuno/TauCetiRoadmap/blob/mei/TauCetiRoadmap/ScatteringDiagrams/README.md#34-uniqueness-and-compatibility),
`relativeAbelianCompletion` and its uniqueness and naturality.

For the split extension in the README, keep the lifted consistent quotient
diagram fixed. Its supports may be arbitrary §3.2 supports. Add the incoming
full-hyperplane ideal walls and construct outgoing ideal corrections with pure
birth logs, compatibly with truncation.

**Complete when:** the relative existence theorem, uniqueness and naturality
have these hypotheses. Re-running full-hyperplane completion on the entire
quotient diagram does not establish this result. Reuse the existing
obstruction, cochain and sweep arguments to prove the relative statement.

### M05. Replace the old probe geometry

**Target:** [§5.5](https://github.com/yuma-mizuno/TauCetiRoadmap/blob/mei/TauCetiRoadmap/ScatteringDiagrams/README.md#55-module-probes-and-affine-theta-transport),
`moduleProbe`, `probeCompletion` and `probeTransport`.

Replace the degree group `Γ × ℤ × ℤ` by `Γ × ℤ` and the two auxiliary
spatial coordinates by the single coordinate `z`.
The spatial projection is `ρ_ext(x,c) = (ρ(x),0)`; charge is a grading
coordinate and supplies no auxiliary spatial motion.

Migrate grading, wall spaces, cylinders, probe walls, coefficient extraction,
transport and their consumers. Obtain the completion from M04 with the
prescribed cylinder diagram fixed. Prove the far-ray and zero-spatial-direction
statements using the new geometry.

**Complete when:** the canonical probe API has the new carriers and hypotheses,
its callers have migrated, and the old height-selection construction has been
removed. Projecting away a coordinate from the old proofs is insufficient:
their direction, outgoingness and regularity assertions must hold for the new
projection.

### M06. Local resolutions and one gluing theorem

**Target:** [§5.4](https://github.com/yuma-mizuno/TauCetiRoadmap/blob/mei/TauCetiRoadmap/ScatteringDiagrams/README.md#54-local-resolutions-and-gluing-of-sections).

Construct `localResolution_expansion` from the closed charts in M03.
Retain the incidence inequalities selecting the realized histories when using
M01; equality of unrestricted operator words alone does not classify geometric
resolutions. Prove subdivision, concatenation, coefficient and cover
compatibility. Construct `singleFaceResolution` for graph and slab spans.

Assemble `finiteSum_matchingFamily` from the existing facet-descent and
multispan theorems. Apply it to a closed family with a certificate to obtain
`globalThetaSection`, its transport, linearity, naturality and completion.
Only the sums require common face lifts; do not require lifts for every branch.

**Complete when:** the general gluing theorem, the single-face construction and
their stated compatibility laws are proved. M07 then applies this theorem to
the affine certificate. Place work formerly attributed to §5.7 here; the
current README has no §5.7. Derive `slabTheta_normalForm` using §4.4's normal
forms, products and coefficient maps.

### M07. Identify the affine probe and broken-line sums

**Target:** [§5.5](https://github.com/yuma-mizuno/TauCetiRoadmap/blob/mei/TauCetiRoadmap/ScatteringDiagrams/README.md#55-module-probes-and-affine-theta-transport),
from `backwardRayOperator` through `theta_coeffMap`.

Use the migrated probe to construct the common filtration-raising backward-ray
operator. Prove the broken-line and probe recursions independently, including
identity encounters, zero outputs and shifts of zero spatial direction.
Use M01's uniqueness theorem to identify their solutions and prove independence
of the auxiliary arrangement and incoming-point choices.

Construct `operatorProbe` and the incident tangent-diagram comparison needed
for `affineLocalResolution`. M04 must apply to these supports.
Then define the affine theta section by M06's `globalThetaSection`.

**Complete when:** `probeWall_eq_brokenLineSum`, the affine certificate,
theta transport and coefficient/truncation compatibility are proved.
Probe-derived parallel fields alone do not establish this identification.

### M08. Recover focus-focus from the single-face construction

**Targets:** [§4.4](https://github.com/yuma-mizuno/TauCetiRoadmap/blob/mei/TauCetiRoadmap/ScatteringDiagrams/README.md#44-weight-zero-function-walls-and-face-algebras),
[§5.4](https://github.com/yuma-mizuno/TauCetiRoadmap/blob/mei/TauCetiRoadmap/ScatteringDiagrams/README.md#54-local-resolutions-and-gluing-of-sections)
and [§6.3](https://github.com/yuma-mizuno/TauCetiRoadmap/blob/mei/TauCetiRoadmap/ScatteringDiagrams/README.md#63-worked-example-the-focus-focus-slab-and-its-theta-basis).

Use the existing nodal algebra normal forms, signed-monomial basis and product,
and the focus-focus span comparison. Verify the coefficient embeddings, degree
isomorphisms, admissible lifts, incoming records and the preimages of terminal
lifts required to transfer M02, M03 and M06 to this datum.

Replace the independent meaning of `SlabBrokenLine` and
`slabThetaEvaluation` by the common specialization or its proved explicit
enumeration. Define the geometric focus-focus theta sections through
`globalThetaSection`. Retain algebraic theta monomials as normal forms and
identify them with these sections using `slabTheta_normalForm`.

**Complete when:** the global closed family, certificate, theta basis,
multiplication, scalar change and completion are obtained through the common
construction, including the §6.3 Checks. Preserve the existing binomial
enumeration and algebraic formulas as computational consequences.

## Other consumers of the migrated constructions

The revision also changes how existing roadmap targets consume the common
constructions. Include these uses when checking the migration:

- [§5.6](https://github.com/yuma-mizuno/TauCetiRoadmap/blob/mei/TauCetiRoadmap/ScatteringDiagrams/README.md#56-monomial-presentations-and-comparison-of-theta-constructions):
  monomial theta sums express the common weighted evaluation in a basis;
  presentation invariance uses the affine comparison in M07.
- [§6.1](https://github.com/yuma-mizuno/TauCetiRoadmap/blob/mei/TauCetiRoadmap/ScatteringDiagrams/README.md#61-integral-affine-covariance)
  and [§6.2](https://github.com/yuma-mizuno/TauCetiRoadmap/blob/mei/TauCetiRoadmap/ScatteringDiagrams/README.md#62-descent-of-coefficient-diagrams-and-transport):
  covariance and descent transport the common families and certificates and
  apply M06's gluing theorem, retaining whole global incoming histories.
- [§7.7](https://github.com/yuma-mizuno/TauCetiRoadmap/blob/mei/TauCetiRoadmap/ScatteringDiagrams/README.md#77-positive-formal-theta-coefficients):
  the positive global section is the section of §5.4. Update uses of the former
  §5.7 construction without treating positivity itself as proved by this migration.

## Implementation evidence at the baseline

These are source locations for reuse, not prescribed final file names.

- [History expansion](https://github.com/yuma-mizuno-lean/Mei/blob/280b226248836604caa2517e217e6b320c9b3ce6/Mei/LinearAlgebra/GradedModule/History/Expansion.lean)
  supplies `sum_homogeneousHistory_eq_prod` under globally finite grading
  support. [Filtered nilpotence](https://github.com/yuma-mizuno-lean/Mei/blob/280b226248836604caa2517e217e6b320c9b3ce6/Mei/LinearAlgebra/ModuleFiltration/Nilpotent.lean)
  works over rings. [BCH resolution identities](https://github.com/yuma-mizuno-lean/Mei/blob/280b226248836604caa2517e217e6b320c9b3ce6/Mei/Algebra/Lie/Graded/Shifted/Resolution.lean)
  already consume the expansion and explicitly separate algebraic histories
  from geometric realizations.
- [Affine itineraries](https://github.com/yuma-mizuno-lean/Mei/blob/280b226248836604caa2517e217e6b320c9b3ce6/Mei/Geometry/ScatteringDiagram/BrokenLine/Itineraries.lean)
  define `CutoffDecoratedRay`.
  [Charts](https://github.com/yuma-mizuno-lean/Mei/blob/280b226248836604caa2517e217e6b320c9b3ce6/Mei/Geometry/ScatteringDiagram/BrokenLine/Charts.lean)
  and [degenerations](https://github.com/yuma-mizuno-lean/Mei/blob/280b226248836604caa2517e217e6b320c9b3ce6/Mei/Geometry/ScatteringDiagram/BrokenLine/Degeneration.lean)
  supply finite closed endpoint charts.
  [Coefficient comparison](https://github.com/yuma-mizuno-lean/Mei/blob/280b226248836604caa2517e217e6b320c9b3ce6/Mei/Geometry/ScatteringDiagram/BrokenLine/CoefficientMap.lean)
  proves a grouped weighted identity for a fixed itinerary.
- [Probe degrees](https://github.com/yuma-mizuno-lean/Mei/blob/280b226248836604caa2517e217e6b320c9b3ce6/Mei/Geometry/ScatteringDiagram/ModuleProbe/Degree.lean)
  use `Γ × ℤ × ℤ`.
  [Initial probe walls](https://github.com/yuma-mizuno-lean/Mei/blob/280b226248836604caa2517e217e6b320c9b3ce6/Mei/Geometry/ScatteringDiagram/ModuleProbe/Initial.lean)
  use two auxiliary spatial directions and full-hyperplane input for the
  existing completion route.
  [Backward recursion](https://github.com/yuma-mizuno-lean/Mei/blob/280b226248836604caa2517e217e6b320c9b3ce6/Mei/Geometry/ScatteringDiagram/ModuleProbe/BackwardRecursion.lean)
  supplies a probe-side recursion in that geometry.
- [Facet descent](https://github.com/yuma-mizuno-lean/Mei/blob/280b226248836604caa2517e217e6b320c9b3ce6/Mei/Topology/Sheaves/LocallyConstant/FacetDescent/Hom.lean)
  extends morphisms from an input object.
  [Sheaf multispans](https://github.com/yuma-mizuno-lean/Mei/blob/280b226248836604caa2517e217e6b320c9b3ce6/Mei/Topology/Sheaves/Multispan.lean)
  assemble linear chamber maps from local common face lifts.
- [Signed monomials](https://github.com/yuma-mizuno-lean/Mei/blob/280b226248836604caa2517e217e6b320c9b3ce6/Mei/RingTheory/Node/SignedMonomial.lean)
  already give the nodal basis and multiplication.
  [Slab decorated rays](https://github.com/yuma-mizuno-lean/Mei/blob/280b226248836604caa2517e217e6b320c9b3ce6/Mei/Geometry/ScatteringDiagram/FocusFocus/Decorated.lean)
  and [their closed charts](https://github.com/yuma-mizuno-lean/Mei/blob/280b226248836604caa2517e217e6b320c9b3ce6/Mei/Geometry/ScatteringDiagram/FocusFocus/Family.lean)
  provide explicit single-face computations.
  [Evaluation](https://github.com/yuma-mizuno-lean/Mei/blob/280b226248836604caa2517e217e6b320c9b3ce6/Mei/Geometry/ScatteringDiagram/FocusFocus/Evaluation.lean)
  identifies chamber sums with algebraic theta monomials and explicitly
  excludes a construction of sheaf sections or local resolution certificates.
  [The span comparison](https://github.com/yuma-mizuno-lean/Mei/blob/280b226248836604caa2517e217e6b320c9b3ce6/Mei/Geometry/ScatteringDiagram/FocusFocus/Comparison/Diagram.lean)
  supplies the natural transformation between the nodal and Laurent diagrams.
