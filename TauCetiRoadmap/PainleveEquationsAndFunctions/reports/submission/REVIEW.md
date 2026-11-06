# Submission review and verification record

The current specification is [README.md](../../README.md), with [README.ja.md](../../README.ja.md) as its Japanese version. It contains 57 targets in Layers 0–7. This record distinguishes the current scope audit from historical mathematical reviews, build receipts and browser inspections.

## Scope and preservation

The user requested removal of the development applications, all of Layer 8 including the Hastings–McLeod comparison, and confluence in Layer 9. [scope_revision.json](scope_revision.json) pins the preceding specification at `8eaf4ed294dfeee63b0fe5603331a185f0379a70`, records the exact removed targets and suppliers, and fingerprints the resulting specification.

Removed targets: 2.7–2.10, 8.1–8.8 and 9.1–9.8. Target 0.9 is also removed because all its consumers were in Layer 9. Retained targets have no internal prerequisite in the removed set.

General definitions, hypotheses, API items and prerequisite lists of the retained targets are unchanged. In particular, the admitted arbitrary-rank/curve moduli problem, nonlinear-connection framework and general holomorphic Fredholm determinant-line construction are not specialized to the Painlevé application. The auxiliary finite-flat unfolding in 1.6 remains part of the symplectic closedness proof. Target 7.3 retains complete PIII/PV coefficient-boundary coverage.

| Surviving target | Edit |
|---|---|
| 1.6 | Remove sequencing relative to the excluded confluence application; retain the unfolding and closedness construction. |
| 2.6 | Replace a diagnostic referring to the removed five-point application by the same general-consumer compactness diagnostic. |
| 3.7 | Remove references to the excluded confluence targets; retain the general unfolding comparison. |
| 3.8 | Direct coefficient-boundary comparison to 7.3 and remove the confluence reference. |
| 7.3 | Remove the conditional comparison of limiting initial data in a geometric degeneration; retain coefficient classification, boundary integrations and their domains. |

The retained target bodies have identical ordered TeX payloads to the preceding specification in both languages. Summary prose, scope tables, bibliography and ownership lists are synchronized. The registries drop six unused sources and nine unused contracts. `Suggested.lean` and `metadata.toml` are unchanged.

## Current structure

| Layer | Targets | Mathematical milestone |
|---|---:|---|
| 0 | 8 | Nonlinear connections, solutions, transport, observations and jets |
| 1 | 6 | Decorated meromorphic-connection moduli and their symplectic structure |
| 2 | 6 | General isomonodromic construction and logarithmic RH comparison |
| 3 | 12 | Painlevé input, phase spaces and isomonodromic connections |
| 4 | 9 | RH comparison, continuation and the Painlevé property |
| 5 | 6 | Initial-condition surfaces, transformations and Riccati reductions |
| 6 | 5 | General determinant lines and Painlevé tau sections |
| 7 | 5 | Classical equations, coefficient boundaries and coordinate comparisons |

The plan has 21 general targets, 36 application targets, 154 API items, 181 diagnostics, 243 internal prerequisite edges and 27 supporting constructions. The external registry contains 26 contracts against 22 distinct supplier files; the source registry contains 28 records.

## Current verification

[validation.json](validation.json) records 6,105 passing mechanical checks and no failures. These cover document/plan correspondence, target ownership, counts, prerequisite resolution and order, acyclicity, general/application boundaries, supplier paths, source records, Markdown math forms, table structure and local links. The scope audit checks each retained target against the pinned preceding specification, including the complete declared field-edit inventory and formula preservation in both languages.

The validator separately checks the historical preservation chain against its original inputs. The historical 78-target bijection is not asserted of the current scope. The optional original and pre-numbering plan inputs were supplied for this validation run.

These are consistency and preservation checks, not theorem proofs, source-scope certification or human approval. The all-classical irregular proper-RH theorem in 4.4, the global comparisons in 5.2, and the resonant/ramified index-zero RHP adapters in 6.3 remain substantive construction and proof targets.

No Lean build was rerun. The representative `Suggested.lean` is unchanged and contains four `sorry` declarations. The earlier full repository build was cancelled at the user's request and was not restarted. No new browser rendering inspection is claimed; current formula syntax and payload checks are separate from historical visual receipts.

## Historical evidence

The [preceding review record](https://github.com/yuma-mizuno/TauCetiRoadmap/blob/8eaf4ed294dfeee63b0fe5603331a185f0379a70/TauCetiRoadmap/PainleveEquationsAndFunctions/reports/submission/REVIEW.md) retains the detailed history of the original specification and its earlier numbering, presentation and editorial revisions.

The following local evidence files remain bound to their original snapshots:

- [preservation.json](preservation.json), [numbering.json](numbering.json), [organization.json](organization.json) and [math_rendering.json](math_rendering.json).
- Geometry and analysis R1–R3 review JSON records, and the two numbering-review records.
- [build_results.json](build_results.json), [lean_interface_review.md](lean_interface_review.md), [math_rendering_browser.json](math_rendering_browser.json) and [math_rendering_review.json](math_rendering_review.json).
- [dependency_audit.json](dependency_audit.json), [source_provenance.json](source_provenance.json) and community/workflow alignment records.

They are historical evidence, not fresh reviews of the current files. The full prior scope, unused supplier contracts and removed source records remain recoverable from Git.

## Submission boundary

The branch is `codex/painleve-roadmap-submission`, based on upstream `main` at `ffac5139fe4794a132eb540a89e1b973070aad69`. Its diff remains confined to `TauCetiRoadmap/PainleveEquationsAndFunctions/`. No PR or external review request is created by this revision.

The mathematical specification and scope revision were prepared with AI assistance from Codex. Human review and the eventual PR/CI steps are separate from these local checks.
