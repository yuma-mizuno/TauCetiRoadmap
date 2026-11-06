# Submission review and verification record

This record concerns the Painlevé roadmap, its structural revision into ten numbered layers, and its GitHub math rendering. The mathematical specification is [README.md](../../README.md), with [README.ja.md](../../README.ja.md) as its Japanese version. Process history, model attribution, execution results and outstanding human-review steps belong here and in the PR description.

## Snapshots and change boundary

| Item | Recorded value |
|---|---|
| Source draft | `yuma-mizuno/TauCetiRoadmap`, `2a9b41c1ff22ec73612cb2b7c84b4711f0423d8f` |
| Submission base | `TauCetiProject/TauCetiRoadmap:main`, `ffac5139fe4794a132eb540a89e1b973070aad69` |
| Reviewed submission snapshot; parent of the structural revision | `089ae2b8698b5e01523978ba6797e8891dc0a0dd` |
| Numbered snapshot; input to the presentation repair | `4287135b0e642d91c29df0ec1cfa5996fa1c5bcb` |
| Math source candidate inspected on GitHub | `9f0f9b5ead988e2a3fe4e9500e54c88bc94f5caa` |
| Submission branch | `codex/painleve-roadmap-submission` |
| Allowed change directory | `TauCetiRoadmap/PainleveEquationsAndFunctions/` |
| Lean toolchain | `leanprover/lean4:v4.36.0-rc2` |
| Tau Ceti pin | `2fd255d997f47c0b5d834ee416c7015d55444ce5` |
| Mathlib pin | `1b1ccf4b088b32fa3f23f2de1127433254a81e1e` |

The branch begins at the upstream commit above and changes only the Painlevé directory. The structural revision is a successor to the reviewed submission commit on the same branch. It does not inherit the unrelated ScatteringDiagrams changes or merge the old divergent branch history. Repository infrastructure, global lists, toolchain and dependency pins are untouched.

### Historical R3 snapshot

The R3 review identifies the mathematical snapshot published in `089ae2b8698b5e01523978ba6797e8891dc0a0dd` by these SHA-256 values:

| File at the reviewed commit | Historical SHA-256 |
|---|---|
| README.md | `81c15816b186b118f470059d020987aef9f7959fc5c5c86e0be623a96f312ba1` |
| README.ja.md | `e10c2a2b107f005b17727c93a07ff0c438d769805a34e54649ae13b23394a046` |
| design/plan.json | `dfb8c5e9f0aa3abf5dbebf5934a9c9cda302627445661d00d1b8c4963470f524` |

These are not the hashes of the reorganized documents. The R1–R3 JSON records, [preservation.json](preservation.json) and [build_results.json](build_results.json) retain their original identifiers, scope and hashes. The mapping and structural comparisons for the numbered snapshot are recorded separately in [numbering.json](numbering.json). The subsequent presentation repair is recorded in [math_rendering.json](math_rendering.json), with its historical check results retained in Git and current successor checks in [validation.json](validation.json). Native/supplier file hashes remain in [dependency_audit.json](dependency_audit.json).

## Current layer structure and preservation

The roadmap contains **78 targets in Layers 0–9**. A layer represents a mathematical construction or theorem package, rather than each stage of importing a general theorem into an application.

| Layer | Targets | Mathematical milestone |
|---|---:|---|
| 0 | 9 | Nonlinear connections, solutions, transport, observations, jets and convergence |
| 1 | 6 | Meromorphic-connection inputs, moduli, deformation theory and relative symplectic form |
| 2 | 10 | General isomonodromic construction, logarithmic RH comparison and five-point application |
| 3 | 12 | Intrinsic classical Painlevé construction and formal-profile classification |
| 4 | 9 | Classical RH comparison, continuation and the Painlevé property |
| 5 | 6 | Initial-condition surfaces, transformations and Riccati reductions |
| 6 | 5 | General determinant lines and intrinsic tau sections |
| 7 | 5 | Classical coordinate-comparison lemmas |
| 8 | 8 | General RHP estimates and Barnes G, distinguished solutions and connection formulae |
| 9 | 8 | General cancellation, Poisson and convergence theorems, followed by confluence |

The intrinsic tau construction is kept separate from the coordinate-comparison layer. The twelve classical input/moduli/connection targets form one milestone because they bind and verify one general construction. Generic analytic results are placed before their consumers in the relevant layers; their role and prerequisite closure remain independent of those applications. The five-point construction follows the general logarithmic theorem and exercises the same geometry and continuation results before the Painlevé specialization.

The exact ownership ranges are:

- **30 general targets:** 0.1–0.9, 1.1–1.6, 2.1–2.6, 6.1, 8.1–8.4 and 9.1–9.4.
- **Four independent five-point targets:** 2.7–2.10.
- **44 Painlevé targets:** 3.1–3.12, 4.1–4.9, 5.1–5.6, 6.2–6.5, 7.1–7.5, 8.5–8.8 and 9.5–9.8.

All 77 targets from the original draft remain under the identifier bijection; retention does not mean that their literal identifiers are unchanged. Every original API name, diagnostic name and internal prerequisite remains under that correspondence and the previously declared corrections.

| Item | Source draft | Current roadmap |
|---|---:|---:|
| Targets | 77 | 78 |
| General targets | 29 | 30 |
| API laws | 214 | 217 |
| Mathematical diagnostics | 257 | 263 |
| Internal prerequisite edges | 321 | 333 |

The extra target is **8.4, canonical Barnes G and its normalized asymptotics**. It supplies a missing general prerequisite of 8.7. The added diagnostics include four Barnes examples and two examples detecting improper use of an infinite-dimensional trace and an unjustified scalar descent.

[preservation.json](preservation.json) records the earlier comparison from the source draft to the reviewed submission snapshot. In that comparison, 211 original API statements and 254 original diagnostic statements were byte-identical; three API statements and three diagnostic statements were explicitly corrected. The manifest declares 23 changed core fields, with before/after hashes and reasons. These byte-identity counts concern those two historical inputs, not the newly numbered documents. Name preservation alone is not treated as semantic equivalence: the mathematical review also checked the changed scopes.

[numbering.json](numbering.json) records the subsequent bijection, reordering and reference changes against the reviewed parent. It checks preservation of the mathematical targets and their dependencies through the structural revision. The corrected mathematical content of the reviewed snapshot is retained; source bibliographic numbering and genuine mathematical names such as PIII are not roadmap identifiers.

The English and Japanese texts continue to place hypotheses inside their owning targets. The earlier Japanese input appendix was moved into the Painlevé application targets during the mathematical revision. The structural revision retains that scope placement.

## Historical detailed mathematical review loop

The lead authoring session performed the mathematical edits. Separate AI reviewers inspected the integrated candidate, with a geometry/moduli reviewer and an analytic/algebraic reviewer. Their combined target lists cover all 78 targets; the Barnes G target was cross-checked by both. Reviewers also inspected overlapping foundation questions. These are AI review sessions within the authoring task, not independent human approvals.

The following descriptions use current numerical addresses for readability. The linked original records retain the addresses and hashes of their own snapshots.

| Round | Geometry/moduli review | Analytic/algebraic review | Result |
|---|---|---|---|
| R1 | 50 targets, ten finding records | 29 targets plus cross-review, six finding records and a Riccati clarification | Changes required; no completion declared |
| R2 | Nine R1 findings closed; fixed-model-dimension qualification remains | R1 issues closed; two consistency details and a misplaced-hypotheses regression remain | Changes required; correct and re-read |
| R3 | All ten R1 findings and the R2 qualification closed | All R1/R2 findings and the Riccati clarification closed | No remaining reported blockers in the stated review scopes at the reviewed snapshot |

The principal corrections were:

- **1.2/1.3:** distinguish analytic spaces from fixed-dimensional Hausdorff, second-countable manifolds; separate proper relative direct images from absolute proper GAGA; remove the implicit use of a later moduli universal property in the earlier polarization construction.
- **1.4/1.5:** retain the relative base-module linearity of the differential-operator complex; prove Picard formal smoothness using affine square-zero tests, relative cohomological dimension and descent. Relative curve dimension alone does not annihilate absolute cohomology over a nonaffine base.
- **0.5/0.6:** name the existing native Frobenius product-coordinate theorem and own the nonlinear adapter; restrict the zero-form degeneracy example to positive-dimensional fibers.
- **9.4 and 6.2–6.5:** derive uniform determinant convergence from compact image and continuity. Construct a finite-dimensional stabilization differential for every Fredholm chart. Require the actual trace-class realization and frame comparison for an infinite-dimensional trace expression. Preserve the exact generic JMU/Hamiltonian comparison locus.
- **2.10:** construct curve observations on a pointed universal cover and state the scalar deck-invariance criterion for descent. Exclude Painlevé application targets from its dependency closure while retaining the general construction and continuation targets.
- **5.6/8.6:** state the fixed-external-parameter time direction of the nodal-curve extension, and correct the weighted moment/tail reference to 8.3.
- **Sources and language:** include Deligne's substantive 1971 erratum, correct the Japanese translation of 2-categorical coherence, and remove work-history and completion-status prose from the specification.

R2 also detected that eight targets without an API subsection had had their input conditions inserted into the following target. The validator was strengthened to check inclusion **within the owning target block**. It then detected all 16 English/Japanese placement failures and the two diagnostic-schema failures on the R2 snapshot. After correction, the same validator passed on R3. This provides a concrete regression test, rather than treating an increased check count as stronger mathematics.

Exact findings, source evidence, counterexamples, closure results and limits are retained in these immutable records:

- [Geometry R1](submission_review_geometry_r1.json), [R2](submission_review_geometry_r2.json), [R3](submission_review_geometry_r3.json).
- [Analysis R1](submission_review_analysis_r1.json), [R2](submission_review_analysis_r2.json), [R3](submission_review_analysis_r3.json).

Their completion verdicts apply to the recorded mathematical snapshot. The subsequent layer revision has its own structural checks and mapping in [numbering.json](numbering.json); the earlier review records are not presented as a fresh review of the reorganized bytes.

## Dependency and community alignment

[dependency_audit.json](dependency_audit.json) records 35 contracts, 38 distinct source files, exact package pins and the references they replace. Its source-scope assessment and historical target addresses remain tied to that audit; [numbering.json](numbering.json) supplies the current addresses. The specification assigns every extension beyond those contracts to a named target. A filesystem/path check does not establish that a source proves a theorem; the source-scope review records that separate assessment.

[community_analysis_alignment.json](community_analysis_alignment.json) records inspected Mathlib PRs and a public Fredholm-determinant discussion. Those WIP or narrower results are not used as established suppliers. Negative searches are limited evidence and are not asserted to prove the absence of all parallel work. The published pinned APIs, not proposed naming, determine the native interface here.

[submission_workflow_alignment.md](submission_workflow_alignment.md) records actual merged neighboring roadmap PRs and their review discussions: ComplexKahlerGeometry #953, FormalLaurentPuiseux #881 and SchemeAndStackFoundations #1110. The official *Getting started: roadmaps* Zulip topic was inaccessible through the available public endpoints (error shell, archive 404 and unauthenticated API 401). Its contents were not inferred. Reading that topic remains an explicit human-side publication step; the submission does not claim full compliance with that unread discussion.

[submission_packaging_review.json](submission_packaging_review.json) records a packaging check of the earlier submission description and report. It is retained as historical evidence, not as a check of the revised descriptions. At that packaging snapshot the full build was still running; its final cancelled status is in [build_results.json](build_results.json).

## Review of the layer regrouping

Two separate AI reviewer sessions inspected the reorganized snapshot. Their scope was reference correctness, content preservation and mathematical organization; the historical theorem-scope review remains recorded separately above.

- [Geometry and structure review](numbering_review_geometry.json) inspected every target dictionary and all 124 contextual-reference or ownership-prose changes beyond direct identifier substitutions. It verified preservation of the formulas, target roles and prerequisite order. The reviewer disclosed its earlier authorship of the validator changes and supplemented the rerun with direct text comparisons.
- [Reference and source review](numbering_review_references.json) compared 3,359 paired plan strings and all 156 English/Japanese target blocks, checked local links and anchors, and distinguished internal addresses from literature and supplier sections.

The reviews found obsolete surface-layer references, two stale local references inside source records, and two agreement/capitalization details. Each was corrected and rechecked. Both final records report no open findings within their stated scope and pin the numbered snapshot, before the presentation repair below. The English and Japanese TeX-span multisets and external URL multisets were unchanged by that structural revision. The 78 targets, 217 API laws, 263 diagnostics, 32 supporting constructions and 333 prerequisite edges are retained under the explicit numbering map. These reviews are author-side AI checks, not human approvals or theorem proofs.

## GitHub math rendering review

The earlier preservation checks did not establish successful rendering. Inspection of the actual GitHub pages at `4287135` found all 20 intended display equations unrecognized: ten used bracket delimiters, and ten double-dollar blocks lacked paragraph separation. Fifty Japanese inline expressions and one English inline expression also remained literal text. Ordinary Markdown processing consumed some TeX backslashes, including the thin-space command in the Hamiltonian sign diagnostic.

All 466 inline formulas now use protected dollar/backtick delimiters, and all 20 display formulas use blank-separated `math` fences, following the [GitHub math syntax documentation](https://docs.github.com/en/get-started/writing-on-github/working-with-advanced-formatting/writing-mathematical-expressions). A first rendered candidate recognized every formula but still produced seven GitHub error boxes rejecting `operatorname`. The repair therefore also expands the three plain operator names `im`, `Log` and `diag` using `mathop`, `mathrm` and `nolimits`, including the required command-separator space. These changes retain upright operator names, operator spacing and limit placement.

The next candidate, `9f0f9b5`, was checked on the actual GitHub pages before the branch update:

| Document | Inline formulas | Display formulas | Actual MathML formulas | GitHub error boxes / MathML error nodes | Raw dollar text outside math |
|---|---:|---:|---:|---:|---:|
| English | 240 | 9 | 249 / 249 | 0 / 0 | 0 |
| Japanese | 226 | 11 | 237 / 237 | 0 / 0 | 0 |

The browser check also inspected the Hamiltonian thin space, set braces, norm bars, upright operators and the two-by-two matrix. Visual checks covered the long Grönwall estimate, the Barnes product/expansion/remainder and the matrix comparison. All display blocks fit the inspected 1,348-pixel desktop viewport without horizontal overflow. This is a recorded desktop check, not a claim about every screen size.

[math_rendering_review.json](math_rendering_review.json) is a separate, read-only AI review of the changed source bytes. All 486 formulas retain their order and mathematical content; 479 TeX bodies are exact, and the other seven contain only the explicitly listed equivalent operator expansions. Non-math prose is exact except for display-boundary blank lines. The 73 changed plan strings pass the same comparison, while target identities, order, dependency edges and the other design files remain unchanged. The reviewer checked 793 English and 280 Japanese fields inside their owning target blocks.

[math_rendering_check.json](math_rendering_check.json) records 101 passing checks, including independent Pandoc GFM recognition of every formula. [math_rendering_browser.json](math_rendering_browser.json) records the actual browser findings and the two-candidate correction loop. Pandoc's separate TeX-to-MathML converter cannot handle the existing `d_{\rm phase}` expression in either language; GitHub renders both correctly, so the source is retained. Local parser recognition and actual GitHub rendering are reported separately.

[math_rendering.json](math_rendering.json) stores reversible, offset-qualified patches and old/new hashes. The validator reconstructs the numbered snapshot exactly and checks its immutable historical fingerprints; it then checks the current text and permits only the declared presentation changes. The old numbering and mathematical review records are not rewritten or presented as reviews of different bytes.

## Current document organization and headings

The title is *Painlevé equations and functions*. Mathematical subject names replace instruction-shaped headings such as “intrinsic”, “reusable export”, “importing”, and “as a construction output”. The same titles appear in the English and Japanese documents, layer tables, structured plan and part registry. The Suggested file changes only its documentation title.

The global independence policy remains in the opening overview. The duplicated appendix and repeated general-theory overview at the start of Layer 3 are removed. The appendix's mathematical content is already specified in the owning targets: admission and determinant comparisons in 1.1–1.5, construction and coherence in 2.1–2.4, completeness and descent in 0.4–0.5 and their applications, scalarization in 0.8, and the five-point example in 2.7–2.10. The application-specific surface, analytic and confluence obligations remain in their numbered targets. No new target or hypothesis is introduced by this reorganization.

[organization.json](organization.json) binds this revision to commit `9110ce4b595d9afe79399c379fc132b350b69739`. The checker compares all 78 target bodies in each language exactly after removing the heading line, and compares the structured mathematical fields with only titles and the document-level summary excluded. It verifies the current file fingerprints before using the preceding Git snapshot for historical rendering and numbering checks. Those receipts have not been rewritten as reviews of the new bytes.

The current validator passes **6,702 checks** with zero failures, including both original-plan comparisons. The current Markdown math forms and table columns are checked locally. The historical browser result below belongs to its stated earlier snapshot; no new browser inspection or Lean build is claimed. The repository-wide build cancellation remains in effect.

## Rendering-snapshot structural checks

| Check | Result | Meaning |
|---|---|---|
| Identifier mapping, preservation and target-local consistency | 6,547 / 6,547 passed | Numerical addresses, retained mathematical fields, English/Japanese scope, dependency graph, ownership boundaries, links and the strict presentation bridge |
| Math presentation and independent GFM parsing | 101 / 101 passed | Formula payload preservation, complete Markdown recognition and document/plan synchronization |
| Actual GitHub rendering | English 249 / 249; Japanese 237 / 237 | Every formula has MathML; no GitHub math error boxes, MathML errors or raw dollar delimiters remain |
| `check_roadmap_topics.py` | Passed; 173 roadmaps | The `math.AG` metadata remains valid |
| Suggested Lean changes | Roadmap references in comments only | Declarations, imports and proof bodies are unchanged; no new Lean build is run |
| Full repository `lake build` | Not restarted | The user's cancellation remains in effect; no full-build success is claimed |

The rendering snapshot inputs are in [math_rendering.json](math_rendering.json), linked to [numbering.json](numbering.json). Current successor results are in [validation.json](validation.json) and are checked against [organization.json](organization.json). Structural preservation and rendering checks do not prove theorem statements or replace specialist review.

### Earlier executed checks

| Historical check | Result | Scope |
|---|---|---|
| Numerical regrouping consistency | 6,448 / 6,448 passed | Numbered snapshot at `4287135`, before the rendering repair |
| Target-local consistency and source-plan comparison | 4,329 / 4,329 passed | Reviewed R3 snapshot, with its original identifiers |
| Independent rerun by analytic reviewer | 4,329 / 4,329 passed | Same validator against the actual pinned source plan |
| `lake exe cache get` | Exit 0 | Dependency cache acquisition succeeded |
| Painlevé `Suggested.lean` target build | Exit 0 | An earlier prototype revision; four intentional `sorry` warnings |
| Exact R3 Suggested source elaboration | Exit 0 | Reviewed source with the final finite-dimensional/boundaryless and connected-curve hypotheses |
| Full repository `lake build` | Intentionally stopped at the user’s request; exit 130 | No full-build pass is claimed; it is not a pending local verification gate |

[build_results.json](build_results.json) preserves the original commands, package versions and historical Suggested source hash; [lean_interface_review.md](lean_interface_review.md) records the interface review. The prototype target build and exact-source elaboration were distinct runs. The numbering changes alter comments in `Suggested.lean`, so its current byte hash differs from that recorded historical source. No new build or elaboration result is attributed to the changed comment bytes.

The local whole-repository build was stopped when the user clarified that it was unnecessary. Earlier resource-limited attempts remain attempts, not successful builds. The repository's normal CI requirement remains applicable to an opened PR.

The representative Lean file uses actual native tangent/pullback objects, Lie brackets, flow domains and meromorphic curve functions. Four theorem bodies remain `sorry`. In particular, the proper-semiconjugacy prototype is an autonomous specialization and does not encode the full continuous-time, locally uniformly Lipschitz path-lifting theorem. The roadmap README remains definitive.

The earlier 4,975-check result measured preservation. Neither it, the historical 4,329 checks, nor the current structural checks prove all theorem targets. Full proof completion is not represented as a prerequisite for this roadmap PR.

### Reproduction of current scoped checks

From the repository root, run:

```bash
python3 .github/scripts/check_roadmap_topics.py
python3 TauCetiRoadmap/PainleveEquationsAndFunctions/reports/submission/validate_submission.py
python3 TauCetiRoadmap/PainleveEquationsAndFunctions/reports/submission/check_math_rendering.py --pandoc
```

To reproduce the current 6,702 checks, obtain `TauCetiRoadmap/PainleveEquationsAndFunctions/design/plan.json` at source commit `2a9b41c1ff22ec73612cb2b7c84b4711f0423d8f` and pass its local path with `--baseline`; also obtain that file at the reviewed parent `089ae2b8698b5e01523978ba6797e8891dc0a0dd` and pass its path with `--previous-plan`. The first comparison checks the original mathematical preservation manifest; the second independently checks the complete target dictionaries and prerequisite mapping before regrouping. Without these arguments, the validator checks the stored fingerprints and current documents and explicitly reports which source files it has not independently reread. The output count is correspondingly lower. The standalone `--pandoc` check requires Pandoc and adds independent GFM parsing to the standard-library presentation checks; it does not inspect a browser or claim to reproduce the recorded GitHub visual check.

The validator requires checked-out Mathlib and Tau Ceti sources to verify native dependency paths. It does not run network requests, theorem proofs, the roadmap worker or AI-provider jobs. Rebuilding Lean is not required for this comments-only prototype revision.

## AI attribution and outstanding human steps

Earlier drafting, source/dependency work, representative Lean prototyping, structural revision, math rendering inspection and AI reviews used **ChatGPT (GPT-6 Astra Pro)**. No TauCetiRoadmapWorker process or AI-provider job was run. The source draft's retained attribution also names GPT-6 Astra Pro.

There is no claim that a human has read this final snapshot or that a subject-area expert has approved it. The final human read-through and expert-review arrangements remain to be recorded before opening the PR. Review attention should include the intended mathematical scope, the full irregular RH properness proof target, determinant/moduli comparisons and the analytic realization/normalization interfaces. These are substantial specifications with named proof obligations; the AI reviews do not turn them into completed theorems.

The subsequent appendix and title edit was assisted by Codex.

[PR_BODY.md](PR_BODY.md) is prepared for a PR targeting upstream `main` with `awaiting-review`. Preparing and pushing this branch does not itself open a PR, request a review or post a message. No such external action has been taken.
