# Submission review and verification record

This record concerns the submission revision of the intrinsic Painlevé roadmap. The mathematical specification is [README.md](../../README.md), with [README.ja.md](../../README.ja.md) as its Japanese version. Process history, model attribution, execution results and outstanding human-review steps belong here and in the PR description.

## Snapshot and change boundary

| Item | Recorded value |
|---|---|
| Source draft | `yuma-mizuno/TauCetiRoadmap`, `2a9b41c1ff22ec73612cb2b7c84b4711f0423d8f` |
| Submission base | `TauCetiProject/TauCetiRoadmap:main`, `ffac5139fe4794a132eb540a89e1b973070aad69` |
| Submission branch | `codex/painleve-roadmap-submission` |
| Allowed change directory | `TauCetiRoadmap/PainleveEquationsAndFunctions/` |
| Lean toolchain | `leanprover/lean4:v4.36.0-rc2` |
| Tau Ceti pin | `2fd255d997f47c0b5d834ee416c7015d55444ce5` |
| Mathlib pin | `1b1ccf4b088b32fa3f23f2de1127433254a81e1e` |

The branch begins at the upstream commit above and adds only the Painlevé directory. It does not inherit the unrelated ScatteringDiagrams changes or merge the old divergent branch history. Repository infrastructure, global lists, toolchain and dependency pins are untouched.

The R3 review identifies the exact mathematical snapshot by SHA-256:

| File | SHA-256 |
|---|---|
| README.md | `81c15816b186b118f470059d020987aef9f7959fc5c5c86e0be623a96f312ba1` |
| README.ja.md | `e10c2a2b107f005b17727c93a07ff0c438d769805a34e54649ae13b23394a046` |
| design/plan.json | `dfb8c5e9f0aa3abf5dbebf5934a9c9cda302627445661d00d1b8c4963470f524` |

Other exact input hashes are in [validation.json](validation.json). Native/supplier file hashes are in [dependency_audit.json](dependency_audit.json).

## What is preserved and what is corrected

Every original target, API name, diagnostic name and internal prerequisite remains. The exact comparison is against the pinned source plan, not a reconstructed checklist.

| Item | Source draft | Submission |
|---|---:|---:|
| Targets | 77 | 78 |
| General targets | 29 | 30 |
| Layers | 19 | 19 |
| API laws | 214 | 217 |
| Mathematical diagnostics | 257 | 263 |
| Internal prerequisite edges | 321 | 333 |

The extra target is **A1.7, canonical Barnes G and its normalized asymptotics**. It supplies a genuine missing general prerequisite of P10.3. The new diagnostics include four Barnes examples and two examples detecting improper use of an infinite-dimensional trace and an unjustified scalar descent.

Of the original API statements, 211 are byte-identical and three are explicitly corrected. Of the original diagnostic statements, 254 are byte-identical and three are explicitly corrected. The manifest declares 23 changed core fields, with before/after hashes and a reason for every change. Name preservation alone is not treated as semantic equivalence: the review also checks the changed mathematical scopes. The authoritative details are in [preservation.json](preservation.json).

The Japanese P-target input appendix was moved into the corresponding targets. The English text also places every declared input condition inside its target. This relocation preserves the conditions and makes their scope visible at the point of use.

## Detailed review loop

The lead authoring session performed the edits. Separate AI reviewers inspected the integrated candidate, with a geometry/moduli reviewer and an analytic/algebraic reviewer. Their combined target lists cover all 78 targets; A1.7 was cross-checked by both. Reviewers also inspected overlapping foundation questions. These are AI review sessions within the authoring task, not independent human approvals.

| Round | Geometry/moduli review | Analytic/algebraic review | Result |
|---|---|---|---|
| R1 | 50 targets, ten finding records | 29 targets plus cross-review, six finding records and a P7.3 clarification | Changes required; no completion declared |
| R2 | Nine R1 findings closed; fixed-model-dimension qualification remains | R1 issues closed; two consistency details and a misplaced-hypotheses regression remain | Changes required; correct and re-read |
| R3 | All ten R1 findings and the R2 qualification closed | All R1/R2 findings and P7.3 clarification closed | No remaining reported blockers in the stated review scopes |

The principal corrections were:

- **M1.2/M2.1:** distinguish analytic spaces from fixed-dimensional Hausdorff, second-countable manifolds; separate proper relative direct images from absolute proper GAGA; remove the implicit use of a later moduli universal property in the earlier polarization construction.
- **M2.2/M2.3:** retain the relative base-module linearity of the differential-operator complex; prove Picard formal smoothness using affine square-zero tests, relative cohomological dimension and descent. Relative curve dimension alone does not annihilate absolute cohomology over a nonaffine base.
- **N1.5/N1.6:** name the existing native Frobenius product-coordinate theorem and own the nonlinear adapter; restrict the zero-form degeneracy example to positive-dimensional fibers.
- **A1.6/P8:** derive uniform determinant convergence from compact image and continuity. Construct a finite-dimensional stabilization differential for every Fredholm chart. Require the actual trace-class realization and frame comparison for an infinite-dimensional trace expression. Preserve the exact generic JMU/Hamiltonian comparison locus.
- **G1.4:** construct curve observations on a pointed universal cover and state the scalar deck-invariance criterion for descent. Exclude Part P from its dependency closure, rather than every target in the merged roadmap.
- **P7.3/P10.2:** state the fixed-external-parameter time direction of the nodal-curve extension, and correct the weighted moment/tail reference to A1.4.
- **Sources and language:** include Deligne's substantive 1971 erratum, correct the Japanese translation of 2-categorical coherence, and remove work-history and completion-status prose from the specification.

R2 also detected that eight targets without an API subsection had had their input conditions inserted into the following target. The validator was strengthened to check inclusion **within the owning target block**. It then detected all 16 English/Japanese placement failures and the two diagnostic-schema failures on the R2 snapshot. After correction, the same validator passed on R3. This provides a concrete regression test, rather than treating an increased check count as stronger mathematics.

Exact findings, source evidence, counterexamples, closure results and limits are retained in these records:

- [Geometry R1](submission_review_geometry_r1.json), [R2](submission_review_geometry_r2.json), [R3](submission_review_geometry_r3.json).
- [Analysis R1](submission_review_analysis_r1.json), [R2](submission_review_analysis_r2.json), [R3](submission_review_analysis_r3.json).

## Dependency and community alignment

[dependency_audit.json](dependency_audit.json) records 35 current contracts, 38 distinct source files, exact package pins and the original references they replace. The specification assigns every extension beyond those contracts to a named target. A filesystem/path check does not establish that a source proves a theorem; the source-scope review records that separate assessment.

[community_analysis_alignment.json](community_analysis_alignment.json) records inspected Mathlib PRs and a public Fredholm-determinant discussion. Those WIP or narrower results are not used as established suppliers. Negative searches are limited evidence and are not asserted to prove the absence of all parallel work. The published pinned APIs, not proposed naming, determine the native interface here.

[submission_workflow_alignment.md](submission_workflow_alignment.md) records actual merged neighboring roadmap PRs and their review discussions: ComplexKahlerGeometry #953, FormalLaurentPuiseux #881 and SchemeAndStackFoundations #1110. The official *Getting started: roadmaps* Zulip topic was inaccessible through the available public endpoints (error shell, archive 404 and unauthenticated API 401). Its contents were not inferred. Reading that topic remains an explicit human-side publication step; the submission does not claim full compliance with that unread discussion.

[submission_packaging_review.json](submission_packaging_review.json) separately checks the PR description and this report against the actual counts, retained statements, review scopes, source files and Lean declarations. It records the corrected absolute PR evidence links and the completed specification review. At that packaging snapshot the full build was still running; the final execution status is recorded below and in [build_results.json](build_results.json).

## Executed checks

| Check | Result | Meaning |
|---|---|---|
| Target-local consistency and source-plan comparison | 4,329 / 4,329 passed | Addresses, retained fields/names, declared corrections, document scope, dependency graph and links |
| Independent rerun by analytic reviewer | 4,329 / 4,329 passed | Same validator against the actual pinned source plan |
| `check_roadmap_topics.py` | Passed; 173 roadmaps | The `math.AG` metadata is valid |
| `lake exe cache get` | Exit 0 | Dependency cache acquisition succeeded |
| Painlevé `Suggested.lean` build | Exit 0 | Representative interfaces elaborate; four intentional `sorry` warnings |
| Exact final Suggested source elaboration | Exit 0 | Includes the final finite-dimensional/boundaryless and connected-curve hypotheses |
| Full repository `lake build` | Intentionally stopped at the user’s request; exit 130 | No full-build pass is claimed; it is not a pending local verification gate |

The final command receipts, package versions and exact Suggested source hash are in [build_results.json](build_results.json); the interface review is in [lean_interface_review.md](lean_interface_review.md). The full local run was stopped when the user clarified that it was unnecessary for this revision. Earlier resource-limited attempts are retained as attempts, not successful builds. The repository’s normal CI requirement remains applicable to an opened PR.

The representative Lean file uses actual native tangent/pullback objects, Lie brackets, flow domains and meromorphic curve functions. Four theorem bodies remain `sorry`. In particular, the proper-semiconjugacy prototype is an autonomous specialization and does not encode the full continuous-time, locally uniformly Lipschitz path-lifting theorem. The roadmap README remains definitive.

The earlier 4,975-check result measured preservation. Neither that result nor this revision's 4,329 checks proves the theorem targets. Full proof completion is not represented as a prerequisite for this roadmap PR.

### Reproduction

From the repository root, on the committed toolchain and manifest pins, the scoped checks are:

```bash
lake exe cache get
python3 .github/scripts/check_roadmap_topics.py
python3 TauCetiRoadmap/PainleveEquationsAndFunctions/reports/submission/validate_submission.py
lake build TauCetiRoadmap.PainleveEquationsAndFunctions.Suggested
```

The repository-wide command is `lake build`; it was started but not completed in this revision.

To independently compare the source bytes, obtain `TauCetiRoadmap/PainleveEquationsAndFunctions/design/plan.json` at source commit `2a9b41c1ff22ec73612cb2b7c84b4711f0423d8f` and pass its local path with `--baseline`. Without that argument, the validator checks the stored source-field manifest and current documents; it explicitly reports that it has not independently reread the source file. The output count is correspondingly lower.

The validator requires checked-out Mathlib and Tau Ceti sources to verify native dependency paths. It does not run network requests, theorem proofs, the roadmap worker or AI-provider jobs.

## AI attribution and outstanding human steps

Drafting, source/dependency work, representative Lean prototyping and AI reviews used **ChatGPT (GPT-6 Astra Pro)**. No TauCetiRoadmapWorker process or AI-provider job was run. The source draft's retained attribution also names GPT-6 Astra Pro.

There is no claim that a human has read this final snapshot or that a subject-area expert has approved it. The final human read-through and expert-review arrangements remain to be recorded before opening the PR. Review attention should include the intended mathematical scope, the full irregular RH properness proof target, determinant/moduli comparisons and the analytic realization/normalization interfaces. These are substantial specifications with named proof obligations; the AI reviews do not turn them into completed theorems.

[PR_BODY.md](PR_BODY.md) is prepared for a PR targeting upstream `main` with `awaiting-review`. Preparing and pushing this branch does not itself open a PR, request a review or post a message.
