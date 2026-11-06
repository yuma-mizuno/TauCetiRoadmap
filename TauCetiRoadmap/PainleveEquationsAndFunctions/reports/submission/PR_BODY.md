# Add an intrinsic roadmap for Painlevé equations and functions

## Purpose and scope

This roadmap constructs differential Painlevé dynamics from decorated meromorphic-connection moduli, and defines its functions through horizontal sections and admissible observations. Definitions retain the actual geometric objects, morphisms and pullbacks. Flatness, symplectic preservation, continuation and descent are separate theorems. The classical scalar ODEs, Hamiltonians and linear systems are downstream coordinate-comparison lemmas.

The English specification and its complete Japanese version describe one roadmap with **78 targets in 19 layers**:

| Part | Targets | Scope |
|---|---:|---|
| N | 9 | Nonlinear connections, local and complete transport, observations, jets and compact-path limits |
| M | 12 | Decorated meromorphic-connection moduli, the constructed flat symplectic connection, and the precisely scoped logarithmic RH theorem |
| A | 7 | Holomorphic determinant families, Cauchy-class RHP analysis, normalized limits and canonical Barnes G |
| C | 2 | Finite-dimensional pole cancellation and relative finite-algebra Lie–Poisson geometry |
| P | 44 | Classical Painlevé construction, classification, continuation, surfaces, transformations, tau, scalar comparisons, asymptotics and confluence |
| G | 4 | A five-logarithmic-point application with two time variables and four-dimensional phase fibers |

The 30 general targets have no transitive dependency on either application. G is independent of P and uses the same native connection, moduli and transport constructions. P1–P8 do not depend on the coordinate formulas in P9. Reusability includes the actual comparison maps and coherence laws, not just analogous statements with separately defined carriers.

All 77 targets from the earlier draft are retained. **A1.7 is an addition:** the selected tau connection-constant results need a canonical Barnes G construction, its zero divisor, normalized logarithms and an explicit sectorial remainder. The cited current number-theory roadmap does not supply that interface, so this roadmap owns it as general mathematics. P10.3 consumes A1.7.

## Foundation and ownership boundaries

The dependency audit resolves **35 exact contracts against 38 existing roadmap/native source files** at the recorded upstream and package commits. A roadmap reference means the specified theorem under its actual hypotheses; it is not an implementation claim.

The main boundary corrections are:

- M explicitly owns the formal-module, analytic-space/analytification, GIT/rigidification, differential-operator deformation-complex and relative-Picard extensions required beyond the existing foundations. Proper relative direct images and absolute proper GAGA have different scopes. The complex-manifold comparison retains dimension, Hausdorffness and countability hypotheses.
- The regular-singular RH theorem uses its exact genus/rank/pole range, exponent lifts, chosen logarithmic lattices and determinant comparison. **The full classical irregular properness theorem in P4.4 remains an explicit application proof target**; it is not attributed to the narrower logarithmic theorem.
- Generic Fredholm determinant sections use finite-dimensional stabilization. Infinite-dimensional trace identities require an actual trace-class realization and determinant-frame comparison. JMU/Hamiltonian identifications retain their stated generic locus.
- Existing RandomMatrices targets supply the named generic determinant, Airy and Hastings–McLeod results. P owns the bridge to intrinsic phase objects and the specified tau normalization/sectorial estimates. C owns general cancellation and Poisson results; P owns collision admissibility, orbit/reduction comparisons and the convergence adapters.

No other roadmap is modified, and no target is conditional on someone opening a new roadmap or upstreaming work to Mathlib. Additional hypotheses delimit required theorems; they do not make those targets optional.

## Review and validation

The submission is based on upstream `main` at `ffac5139fe4794a132eb540a89e1b973070aad69`. Its diff is confined to `TauCetiRoadmap/PainleveEquationsAndFunctions/`; the unrelated `ScatteringDiagrams` files and the earlier branch's divergent history are excluded.

Two separate AI review agents read the integrated English/Japanese specification. Their combined scopes cover all 78 targets. The recorded loop contains R1 findings, corrections, R2 regression findings, and R3 closure of every reported issue. Examples include the affine-base condition in the Picard lifting proof, the finite-dimensional versus trace-class determinant differential, universal-cover versus scalar descent, the fixed-parameter time direction for Riccati curves, and correct placement of hypotheses inside their owning targets.

Validation evidence:

- **4,329 mechanical checks pass**, including a direct comparison with the earlier draft's `plan.json`, target-local document consistency, dependency resolution, graph acyclicity, ownership boundaries, source keys and local links. All original 77 target IDs, 214 API names, 257 diagnostic names and 321 internal prerequisite edges are retained. The revised fields are individually declared in the preservation manifest.
- `python3 .github/scripts/check_roadmap_topics.py` passes: 173 roadmaps, with `math.AG` for this roadmap.
- `lake exe cache get` succeeds on the unchanged pinned dependencies.
- The representative `Suggested.lean` target builds, and exact-source elaboration succeeds. It uses native tangent/pullback bundles, flow/completeness and meromorphic-curve carriers. **Four theorem bodies are deliberately `sorry`**. Its N1.4 signature is explicitly an autonomous specialization, not the full continuous-time path-lifting theorem.
- **Local repository-wide `lake build`: intentionally stopped at the user’s request.** The scoped checks above are the verification for this revision; no full-repository build pass is claimed. Exact command results and the final Suggested source hash are recorded in [build_results.json](https://github.com/yuma-mizuno/TauCetiRoadmap/blob/codex/painleve-roadmap-submission/TauCetiRoadmap/PainleveEquationsAndFunctions/reports/submission/build_results.json). The repository’s normal CI check remains applicable when a PR is opened.

The checks above are evidence about preservation, specifications and elaborated interfaces. They are **not proofs of all 78 targets**, and the earlier 4,975-check preservation record is not represented as such. Neither the roadmap worker nor an AI-provider job was run.

Detailed evidence is in [REVIEW.md](https://github.com/yuma-mizuno/TauCetiRoadmap/blob/codex/painleve-roadmap-submission/TauCetiRoadmap/PainleveEquationsAndFunctions/reports/submission/REVIEW.md), [validation.json](https://github.com/yuma-mizuno/TauCetiRoadmap/blob/codex/painleve-roadmap-submission/TauCetiRoadmap/PainleveEquationsAndFunctions/reports/submission/validation.json), [preservation.json](https://github.com/yuma-mizuno/TauCetiRoadmap/blob/codex/painleve-roadmap-submission/TauCetiRoadmap/PainleveEquationsAndFunctions/reports/submission/preservation.json), [dependency_audit.json](https://github.com/yuma-mizuno/TauCetiRoadmap/blob/codex/painleve-roadmap-submission/TauCetiRoadmap/PainleveEquationsAndFunctions/reports/submission/dependency_audit.json), and the six R1–R3 review records linked from that review report.

## AI assistance and human review

AI-assisted drafting, dependency/source inspection, representative Lean prototyping and detailed review used **ChatGPT (GPT-6 Astra Pro)**, including separate delegated reviewer sessions. These are author-side AI review records, not approval by another human contributor or by the roadmap-reviewers team.

The official *Getting started: roadmaps* Zulip topic could not be read through the available public endpoints; the [workflow alignment record](https://github.com/yuma-mizuno/TauCetiRoadmap/blob/codex/painleve-roadmap-submission/TauCetiRoadmap/PainleveEquationsAndFunctions/reports/submission/submission_workflow_alignment.md) records the failed accesses and the three neighboring merged PR discussions that were inspected. The submitting author still needs to read that topic or provide its text.

The final human read-through of this exact submission snapshot has not yet been recorded. A subject-area expert has not been recruited or represented as having reviewed it. Before posting, the author should read the final English/Japanese specification and the review's stated limits, and identify an expert reviewer or describe the plan to seek one. The most valuable specialist review areas are the full irregular proper-RH target, relative moduli/determinant comparisons, and the tau/asymptotic realization and normalization interfaces.

This description is prepared for a PR against `TauCetiProject/TauCetiRoadmap:main` with the `awaiting-review` label. No PR, review request or external discussion message is created by this preparation.
