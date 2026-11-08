# Submission review and verification record

## Shared classical Riemann–Hilbert proof structure

The [shared RH proof review](../rh-sharing/REVIEW.md) records the bilingual revision against `fa5beb6d40adf6b8b96db4116b0aeabf781074fc`. Sections 4.1–4.4 share the local reconstruction, Betti-family construction, determinant restriction and global properness/stable-realization proofs across all admitted classical profiles, including PVI. The stronger PVI inverse and fiberwise bimeromorphicity statements remain specialized consequences with their geometric proof obligations. The 55 target identities and the 19 framework/36 application division are retained.

The [validation record](../rh-sharing/validation.json) fingerprints the revised specification, structured contracts and source registry. The other 51 numbered sections, representative Lean file, topic metadata and historical checkers and receipts are unchanged. No full build or new GitHub visual-rendering inspection is claimed.

## Earlier review introduction

The following introduction and review sections describe their recorded snapshots.

The current specification is [README.md](../../README.md), with [README.ja.md](../../README.ja.md) as its Japanese version. It contains 55 targets in Layers 0–7: 19 framework targets and 36 classical Painlevé application targets. The classical RH scope revision is recorded first; the remaining sections retain the history of API and scope changes, mathematical reviews, build receipts and browser inspections.

## Classical Riemann–Hilbert scope revision

The [RH scope review](../rh-reorganization/REVIEW.md) records the bilingual reorganization against `5377bc5e0288937e1fbde0d6bd4a50748720041e`. Layer 2 contains the general isomonodromic-connection construction in 2.1–2.4; the classical RH maps, their complete target transport and properness are owned in Layer 4. The separate general logarithmic RH targets 2.5–2.6 are removed, with the PVI comparisons specialized and integrated into 4.1–4.4. Section 3.8 constructs local logarithmic monodromy before its apparent loci.

The [migration record](../rh-reorganization/migration.json) identifies the retained proof responsibilities and scope restrictions. The [validation record](../rh-reorganization/validation.json) binds 1,944 passing checks, 0 failures and 0 skips to their inputs. The plan contains 55 targets, 171 API items, 195 diagnostics, 249 internal prerequisite edges and 23 supporting-construction bullets. All 216 English and 204 Japanese TeX payloads are retained in order. The other 48 retained numbered sections, representative Lean file, topic metadata and historical validation programs are unchanged. No full build or new remote-browser inspection is claimed.

## Timeless specification revision

The [timeless review](../timeless/REVIEW.md), committed as `5377bc5e0288937e1fbde0d6bd4a50748720041e`, records a complete bilingual review and rewrite against `2441b2fe3a68efbb628db17eae5f282d35cbb8bd`. It preserves all 57 targets, 169 API items, 197 diagnostics, 251 internal edges and 27 supporting constructions while synchronizing the prose, source scopes and structured contracts. It also corrects proof ownership and the precision issues listed in that report. The [validation record](../timeless/validation.json) contains 1,382 passing checks and 0 failures, with input hashes for this revision. All 216 English and 204 Japanese TeX payloads are unchanged in order, and the Lean noncomment bytes are unchanged.

The revised source registry contains bibliographic versions and mathematical scope. [source-note-history.json](../timeless/source-note-history.json) preserves the original retrieval history and verification limits of the seventeen edited notes. No new full build or remote rendering inspection is claimed.

## API revision after the reviewed working snapshot

The [API review response](../api-review/REVIEW.md) records the resolution of R01–R08 and C01–C09 against `d59dd62f39e96a680baf3656fc4398dfa8de7fb2`, including the supplementary 4.3 dependency correction. Its [validation record](../api-review/validation.json) contains 992 passing checks and 0 failures for the API-revision bytes committed as `2441b2fe3a68efbb628db17eae5f282d35cbb8bd`. That plan has 57 targets, 8 layers, 169 API items, 197 diagnostics and 251 internal edges. The target identities, general/application division and representative Lean interfaces are retained.

The scope, preservation, build and browser records below describe their earlier snapshots. Their assertions that definitions and formulas were unchanged apply to those earlier revisions; the API revision intentionally changes the affected contracts and adds sigma formulas. The timeless revision preserves that formula inventory. No historical receipt is presented as a new inspection of the current files.

## Historical scope and preservation

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

The retained target bodies have identical ordered TeX payloads to the preceding specification in both languages. Summary prose, scope tables, bibliography and ownership lists are synchronized. The registries drop six unused sources and nine unused contracts. At the scope-reduction snapshot, `Suggested.lean` and `metadata.toml` were unchanged; the subsequent directory rename also renames the Lean namespace.

## Structure before the API revision

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

## Verification before the API revision

[validation.json](validation.json) records 6,135 passing mechanical checks and no failures. These cover document/plan correspondence, target ownership, counts, prerequisite resolution and order, acyclicity, general/application boundaries, supplier paths, source records, Markdown math forms, table structure and local links. The scope audit checks each retained target against the pinned preceding specification, including the complete declared field-edit inventory and formula preservation in both languages.

The validator separately checks the historical preservation chain against its original inputs. The historical 78-target bijection is not asserted of the current scope. The optional original and pre-numbering plan inputs were supplied for this validation run.

These are consistency and preservation checks, not theorem proofs, source-scope certification or human approval. The all-classical irregular proper-RH theorem in 4.4, the global comparisons in 5.2, and the resonant/ramified index-zero RHP adapters in 6.3 remain substantive construction and proof targets.

No full repository build was rerun. The representative `Suggested.lean` contains four `sorry` declarations; its only source change is the namespace rename. The earlier full repository build was cancelled at the user's request and was not restarted. No new browser rendering inspection is claimed; current formula syntax and payload checks are separate from historical visual receipts.

## Historical evidence

The [preceding review record](https://github.com/yuma-mizuno/TauCetiRoadmap/blob/8eaf4ed294dfeee63b0fe5603331a185f0379a70/TauCetiRoadmap/PainleveEquationsAndFunctions/reports/submission/REVIEW.md) retains the detailed history of the original specification and its earlier numbering, presentation and editorial revisions.

The following local evidence files remain bound to their original snapshots:

- [preservation.json](preservation.json), [numbering.json](numbering.json), [organization.json](organization.json) and [math_rendering.json](math_rendering.json).
- Geometry and analysis R1–R3 review JSON records, and the two numbering-review records.
- [build_results.json](build_results.json), [lean_interface_review.md](lean_interface_review.md), [math_rendering_browser.json](math_rendering_browser.json) and [math_rendering_review.json](math_rendering_review.json).
- [dependency_audit.json](dependency_audit.json), [source_provenance.json](source_provenance.json) and community/workflow alignment records.

They are historical evidence, not fresh reviews of the current files. The full prior scope, unused supplier contracts and removed source records remain recoverable from Git.

## Submission boundary

The working branch is `codex/painleve-roadmap-working`, based on upstream `main` at `ffac5139fe4794a132eb540a89e1b973070aad69`. Its diff remains confined to `TauCetiRoadmap/PainleveEquations/`. No PR or external review request is created by this revision.

The mathematical specification and scope revision were prepared with AI assistance from Codex. Human review and the eventual PR/CI steps are separate from these local checks.

## Directory name and arXiv classification

The directory, active roadmap identifiers, proof-owner prefixes and Lean namespace are renamed from `PainleveEquationsAndFunctions` to `PainleveEquations`. [naming_revision.json](naming_revision.json) checks exact identifier substitution against commit `f05568ae46e28030502b460d64a7b95e760fafc0`. Historical receipts and commit-specific URLs retain their original paths and names.

The primary topic remains `math.AG`. The closest moduli/isomonodromy and initial-condition-space sources are primary AG: [van der Put–Saito](https://arxiv.org/abs/0902.1702v5) (cross-listed CA), [Inaba](https://arxiv.org/abs/2108.09667), [Inaba–Iwasaki–Saito](https://arxiv.org/abs/math/0501007v2) (cross-listed DS), and [Saito–Takebe–Terajima](https://arxiv.org/abs/math/0006026v2). Analytic treatments have other primary topics: [Steinmetz](https://arxiv.org/abs/1601.04031) is CV and [Dereziński–Ishkhanyan–Latosiński](https://arxiv.org/abs/2007.05698) is CA. This is a comparison of selected close sources, not a statistical survey. Retaining AG for the present moduli-based construction is an editorial judgement informed by those registrations.

The renamed representative Lean file was submitted to a direct type check, which stopped at the first import because the existing dependency checkout lacks `TauCeti.Geometry.Manifold.Submersion.olean`. No proof-body error was reached, and no full build was started. [namespace_check.json](namespace_check.json) records the failed check; the current namespace has not been certified by Lean.

## Submission packaging

The former `codex/painleve-roadmap-submission` branch is renamed locally and on GitHub to `codex/painleve-roadmap-working`. It retains the Japanese text, structured plan and all verification history. The separate `codex/painleve-equations-submission` branch is based on upstream `main` at `eaf17b10d9267c0e3cdd3b62dd5e8983e47c690d` and contains one roadmap commit adding exactly three files: `README.md`, `Suggested.lean` and `metadata.toml`.

The submitted English README replaces references to omitted working files with its own dependency table and bibliography. All target bodies are preserved except for those explicitly listed reference edits; all mathematical statements, hypotheses, API items, diagnostics, supporting constructions, prerequisite lists and ordered TeX payloads are retained. The Lean interfaces and topic are byte-identical to the working source at `81debc5bdc5512ed79dfaa0ae03ddb4ddadc9989`.

[packaging.json](packaging.json) records the source and submission commits, three file hashes, exact prose substitutions, 997 passing packaging checks and the actual GitHub rendering observations. The current upstream changes to the ComplexCurveModuli supplier redirect its own analytic dependencies; the curve-moduli interfaces consumed here remain present. Root indexes, workflow files and dependency pins are not part of the submission diff.

The submitted page has 212 rendered MathML nodes and 57 target headings, with no queried math errors or rendering warnings. The screenshot spot check covered target 0.6. This does not certify every formula visually or prove the mathematics. Current Lean type checking remains unconfirmed after the missing dependency-object failure; no full build was restarted. Human review, upstream PR creation, its build check and code-owner approval remain outstanding. The prepared PR body is retained only on the working branch; no PR, review request or discussion message has been sent.
