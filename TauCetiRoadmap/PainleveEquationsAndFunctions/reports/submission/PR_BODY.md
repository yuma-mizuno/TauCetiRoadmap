# Add a roadmap for Painlevé equations

## Purpose and scope

This roadmap constructs differential Painlevé dynamics from decorated meromorphic-connection moduli, and defines its functions through horizontal sections and admissible observations. Definitions retain the actual geometric objects, morphisms and pullbacks. Flatness, symplectic preservation, continuation and descent are separate theorems. The classical scalar ODEs, Hamiltonians and linear systems are downstream coordinate-comparison lemmas.

The English specification and its complete Japanese version describe one roadmap with **78 targets in ten numbered layers**: 30 targets of general theory, 44 Painlevé application targets, and four independent five-point application targets.

| Layer | Targets | Mathematical milestone |
|---|---:|---|
| 0 | 9 | Nonlinear connections, solutions, transport, observations, jets and compact-path limits |
| 1 | 6 | Admitted meromorphic connections, moduli, deformation theory and the relative symplectic form |
| 2 | 10 | Strong isomonodromic dynamics, logarithmic RH comparison and the independent five-point application |
| 3 | 12 | Classical Painlevé input, formal profiles, phase spaces and time connection |
| 4 | 9 | Full classical RH comparison, continuation and the Painlevé property |
| 5 | 6 | Initial-condition surfaces, geometric transformations and Riccati reductions |
| 6 | 5 | General determinant lines and intrinsically constructed tau sections |
| 7 | 5 | Classical scalar, Hamiltonian, sigma and linear-system coordinate comparisons |
| 8 | 8 | General RHP estimates, canonical Barnes G, distinguished solutions and connection formulae |
| 9 | 8 | General cancellation, relative Poisson and analytic convergence theorems, followed by Painlevé confluence |

The layers group complete mathematical developments. The classical input, moduli and time-connection specializations form one construction milestone. Intrinsic tau construction has its own layer before the coordinate-comparison layer. General analytic tools appear near their consumers, with their independent hypotheses, APIs and proof ownership retained.

The 30 general targets have no transitive dependency on either application. The five-point targets **2.7–2.10** use the same native connection, moduli and transport constructions and have no Painlevé prerequisite. The intrinsic Painlevé targets in Layers 3–6 do not depend on the coordinate formulas in Layer 7. Reusability includes the actual comparison maps and coherence laws.

All 77 targets from the earlier draft are retained **under the recorded identifier bijection**, together with their mathematical scope and declared corrections. **Target 8.4 is the additional canonical Barnes G construction:** it supplies the zero divisor, normalized logarithms and explicit sectorial remainder required by the connection-constant target 8.7. The cited number-theory roadmap does not supply that interface, so this roadmap owns it as general mathematics.

## Foundation and ownership boundaries

The dependency audit resolves **35 exact contracts against 38 roadmap/native source files** at the recorded upstream and package commits. A roadmap reference means the specified theorem under its actual hypotheses; it is not an implementation claim.

The main boundary corrections are:

- The meromorphic-moduli targets explicitly own the formal-module, analytic-space/analytification, GIT/rigidification, differential-operator deformation-complex and relative-Picard extensions required beyond the existing foundations. Proper relative direct images and absolute proper GAGA have different scopes. The complex-manifold comparison retains dimension, Hausdorffness and countability hypotheses.
- The regular-singular RH theorem uses its exact genus/rank/pole range, exponent lifts, chosen logarithmic lattices and determinant comparison. **The full classical irregular properness theorem in 4.4 remains an explicit application proof target**; it is not attributed to the narrower logarithmic theorem.
- Generic Fredholm determinant sections use finite-dimensional stabilization. Infinite-dimensional trace identities require an actual trace-class realization and determinant-frame comparison. JMU/Hamiltonian identifications retain their stated generic locus.
- Existing RandomMatrices targets supply the named generic determinant, Airy and Hastings–McLeod results. The Painlevé targets own their intrinsic phase-space comparisons and the specified tau normalization and sectorial estimates. General cancellation and Poisson results remain independent of the collision-admissibility, orbit/reduction and convergence comparisons required of the application.

No other roadmap is modified, and no target is conditional on someone opening a new roadmap or upstreaming work to Mathlib. Additional hypotheses delimit required theorems; they do not make those targets optional.

## Review and validation

The submission branch is based on upstream `main` at `ffac5139fe4794a132eb540a89e1b973070aad69`. This structural revision extends the reviewed submission commit `089ae2b8698b5e01523978ba6797e8891dc0a0dd` on the same branch. The upstream diff remains confined to `TauCetiRoadmap/PainleveEquationsAndFunctions/`; the unrelated `ScatteringDiagrams` files and the earlier branch's divergent history are excluded.

Two separate AI review agents reviewed the mathematical specification represented by commit `089ae2b8698b5e01523978ba6797e8891dc0a0dd`. Their combined scopes cover all 78 targets. The recorded loop contains R1 findings, corrections, R2 regression findings, and R3 closure of every reported issue. Examples include the affine-base condition in the Picard lifting proof, the finite-dimensional versus trace-class determinant differential, universal-cover versus scalar descent, the fixed-parameter time direction for Riccati curves, and correct placement of hypotheses inside their owning targets. The R1–R3 JSON records retain that snapshot's original identifiers and hashes; they are not relabelled as reviews of the reorganized documents.

The subsequent structural revision groups those targets into ten layers and replaces alphabetic addresses with globally unique numerical addresses. [numbering.json](https://github.com/yuma-mizuno/TauCetiRoadmap/blob/codex/painleve-roadmap-submission/TauCetiRoadmap/PainleveEquationsAndFunctions/reports/submission/numbering.json) records the bijection and content-preservation comparisons for the numbered snapshot at `4287135b0e642d91c29df0ec1cfa5996fa1c5bcb`. The historical preservation manifest, build receipts and R1–R3 records remain unchanged.

Two further AI reviews checked the actual regrouping: [mathematical organization and content preservation](https://github.com/yuma-mizuno/TauCetiRoadmap/blob/codex/painleve-roadmap-submission/TauCetiRoadmap/PainleveEquationsAndFunctions/reports/submission/numbering_review_geometry.json) and [internal references, links and source numbering](https://github.com/yuma-mizuno/TauCetiRoadmap/blob/codex/painleve-roadmap-submission/TauCetiRoadmap/PainleveEquationsAndFunctions/reports/submission/numbering_review_references.json). They found and closed the remaining obsolete surface-layer references, two local references inside source records, and minor grammatical details. Both records pin the reorganized snapshot and report no open findings within their stated scope.

Actual GitHub inspection subsequently identified unrecognized display/inline math and Markdown interference with TeX backslashes. The presentation repair uses protected inline delimiters and fenced display math, plus the explicitly equivalent operator expansions required by GitHub's renderer. A first candidate still had seven macro error boxes; the second candidate, `9f0f9b5ead988e2a3fe4e9500e54c88bc94f5caa`, renders every formula successfully. A separate [source review](https://github.com/yuma-mizuno/TauCetiRoadmap/blob/codex/painleve-roadmap-submission/TauCetiRoadmap/PainleveEquationsAndFunctions/reports/submission/math_rendering_review.json) verifies mathematical-content preservation and all 73 changed plan strings. The [presentation manifest](https://github.com/yuma-mizuno/TauCetiRoadmap/blob/codex/painleve-roadmap-submission/TauCetiRoadmap/PainleveEquationsAndFunctions/reports/submission/math_rendering.json) bridges the old and new bytes without rewriting historical review hashes.

The current documents use mathematical subject names for their titles and headings. The opening overview states the global dependency policy once. Each numbered target supplies its hypotheses, conclusions and comparison laws; the duplicated proof-contract appendix is removed. The mathematical statements, APIs, diagnostics and prerequisite edges of all 78 targets are unchanged. Synthetic API and diagnostic labels are removed from the prose; the structured plan uses target-local document addresses such as `2.1.api.5`, not proposed Lean declaration names. [organization.json](https://github.com/yuma-mizuno/TauCetiRoadmap/blob/codex/painleve-roadmap-submission/TauCetiRoadmap/PainleveEquationsAndFunctions/reports/submission/organization.json) records the preceding commit, exact file fingerprints and the target locations covering the removed summaries. Current checks verify this successor separately; the historical review and rendering receipts retain their original scope.

Validation evidence:

- **6,704 current mechanical checks pass**, covering the identifier mapping, retained mathematical targets and fields, target-local English/Japanese consistency, dependency resolution, graph acyclicity, proof-ownership boundaries, source keys, links and the strict presentation bridge. The original 77 targets, 214 API items, 257 diagnostics and 321 prerequisite edges are retained under the mapping and the previously declared mathematical corrections. The earlier 6,448-check result belongs to the numbered snapshot before presentation repair.
- The historical rendering snapshot passed **101 presentation checks**, including independent Pandoc GFM recognition of all 486 formulas. The recorded [GitHub browser validation](https://github.com/yuma-mizuno/TauCetiRoadmap/blob/codex/painleve-roadmap-submission/TauCetiRoadmap/PainleveEquationsAndFunctions/reports/submission/math_rendering_browser.json) confirms **249/249 English and 237/237 Japanese MathML formulas at that earlier snapshot**, with no math error boxes or raw dollar delimiters. Selected visual checks cover the long estimate, Barnes expansion/remainder and matrix. The local TeX-to-MathML parser's separate limitation on `d_{\rm phase}` is recorded; GitHub renders that expression correctly.
- `python3 .github/scripts/check_roadmap_topics.py` passes: 173 roadmaps, with `math.AG` for this roadmap.
- The earlier **4,329-check** result belongs to the R3 snapshot. It is historical preservation/specification evidence, distinct from the current structural check result.
- The historical `lake exe cache get`, representative `Suggested.lean` target build and exact-source elaboration succeeded. The prototype uses native tangent/pullback bundles, flow/completeness and meromorphic-curve carriers. **Four theorem bodies remain deliberately `sorry`**, and the proper-semiconjugacy signature at 0.4 is an autonomous specialization of the roadmap theorem. The Lean changes are confined to documentation, including the title and roadmap references; declarations, imports and proof bodies are unchanged. No new Lean build is run. [build_results.json](https://github.com/yuma-mizuno/TauCetiRoadmap/blob/codex/painleve-roadmap-submission/TauCetiRoadmap/PainleveEquationsAndFunctions/reports/submission/build_results.json) retains the original commands and historical source hash; it is not a receipt for the revised comment bytes.
- **The local repository-wide `lake build` was intentionally stopped at the user's request, with exit 130.** It has not been restarted and is not a pending local verification gate. The repository's normal CI check remains applicable when a PR is opened.

These checks concern preservation, specifications and representative interfaces. They are **not proofs of all 78 targets**. The earlier 4,975-check preservation record is not represented as such either. Neither the roadmap worker nor an AI-provider job was run.

Detailed evidence is in [REVIEW.md](https://github.com/yuma-mizuno/TauCetiRoadmap/blob/codex/painleve-roadmap-submission/TauCetiRoadmap/PainleveEquationsAndFunctions/reports/submission/REVIEW.md), [validation.json](https://github.com/yuma-mizuno/TauCetiRoadmap/blob/codex/painleve-roadmap-submission/TauCetiRoadmap/PainleveEquationsAndFunctions/reports/submission/validation.json), [preservation.json](https://github.com/yuma-mizuno/TauCetiRoadmap/blob/codex/painleve-roadmap-submission/TauCetiRoadmap/PainleveEquationsAndFunctions/reports/submission/preservation.json), [dependency_audit.json](https://github.com/yuma-mizuno/TauCetiRoadmap/blob/codex/painleve-roadmap-submission/TauCetiRoadmap/PainleveEquationsAndFunctions/reports/submission/dependency_audit.json), and the six R1–R3 review records linked from that review report.

## AI assistance and human review

AI-assisted drafting, dependency/source inspection, representative Lean prototyping and detailed review used **ChatGPT (GPT-6 Astra Pro)**, including separate delegated reviewer sessions. These are author-side AI review records, not approval by another human contributor or by the roadmap-reviewers team.

The official *Getting started: roadmaps* Zulip topic could not be read through the available public endpoints; the [workflow alignment record](https://github.com/yuma-mizuno/TauCetiRoadmap/blob/codex/painleve-roadmap-submission/TauCetiRoadmap/PainleveEquationsAndFunctions/reports/submission/submission_workflow_alignment.md) records the failed accesses and the three neighboring merged PR discussions that were inspected. The submitting author still needs to read that topic or provide its text.

The final human read-through of this exact submission snapshot has not yet been recorded. A subject-area expert has not been recruited or represented as having reviewed it. Before posting, the author should read the final English/Japanese specification and the review's stated limits, and identify an expert reviewer or describe the plan to seek one. The most valuable specialist review areas are the full irregular proper-RH target, relative moduli/determinant comparisons, and the tau/asymptotic realization and normalization interfaces.

The editorial organization and title revision was assisted by Codex.

This description is prepared for a PR against `TauCetiProject/TauCetiRoadmap:main` with the `awaiting-review` label. No PR, review request or external discussion message is created by this preparation.
