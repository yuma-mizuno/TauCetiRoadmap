# Timeless specification review

This revision starts from `2441b2fe3a68efbb628db17eae5f282d35cbb8bd` and revises the complete English and Japanese specification: 57 targets in Layers 0–7, their surrounding exposition, the structured plan, supplier contracts, bibliographic notes and explanatory Lean comments.

The mathematical specification describes the constructions, hypotheses, domains, comparison maps and theorems to establish. Review responses, revision history and verification status are recorded here and in the earlier reports.

## Editorial review

Three AI-assisted reviews covered Layers 0–2, Layers 3–5 and Layers 6–7, reading every target in both languages. Independent cross-reviews then checked the revised foundation, geometry and tau/classical sections. A separate regression review compared the seventeen findings R01–R08 and C01–C09 with the API revision. These are document and mathematical-contract reviews, not completed theorem proofs or human approval.

The rewrite replaces review-response wording, unspecified proof-status comments and development instructions with direct mathematical requirements. It retains meaningful exclusions, source errata, counterexamples, nonimplications and hypotheses. Repeated dependency instructions are consolidated into the address convention. The Japanese-only concluding obligation list is removed after checking that all nine obligations occur in the target contracts and structured plan.

The full scope is retained: the independent nonlinear-connection framework, admitted arbitrary-rank and curve moduli construction, the classical application, resonant and ramified strata, all permitted bundle types, determinant comparisons, initial-condition surfaces, tau sections, and the specified classical equations and special-solution families. The previous exclusions remain explicit.

## Precision corrections

| Location | Correction |
|---|---|
| 0.8 | State that the coordinates used in the first-jet formula are adapted to the specified observation. |
| 1.3 and 1.5 | Keep the coarse-moduli construction in 1.3 and assign openness of the nonempty-fiber locus and its surjective analytic submersion to the smoothness theorem in 1.5. State coarse-space separatedness with its correct scope; retain the unrigidified stack's scalar inertia. |
| 1.4 and 1.5 | Distinguish the scalar infinitesimal automorphism direction from the trace-free tangent condition and the removal of the determinant's 2g deformation directions. |
| 2.3 | Distinguish coherence for triple composition from the associativity pentagon for four composable arrows. |
| 2.5 | Assign wild root/deck isotopy and ramified descent to 4.2 while retaining the logarithmic construction in 2.5. |
| 3.9 and 4.5 | Identify the actual time/moduli inputs and local horizontal-section comparison without treating neighboring classification or exceptional-locus statements as additional inputs. |
| 5.3 | Restore in Japanese the Noetherian colimit-of-Ext comparison and the supplied proper pushforward/base-change scope already specified in English. |
| 6.3 | Replace the broad input range through 4.4 by the actual constructions used; RH properness is not an input to the RHP adapter construction. The admitted resonant and ramified scope is retained. |
| Overview | Distinguish the general Fredholm determinant line of 6.1 from the additional trace-class realizations. Match the Japanese JMU/Hamiltonian scope to 6.4–6.5 and the marked-RHP construction to 6.2–6.3. |
| Structured plan | Correct the layer range to 0–7, identify the I13 comparison with the line-twist quotient Q_log, and include separate surjectivity onto the independently defined full ordinary character target in the 4.4 summary. Synchronize source-scope paragraphs, Japanese titles and supplier summaries. |
| Sources | Pin the duplicated I13 links to the existing cited v2 and include Definition 4.3. State the separated-group-scheme hypothesis in the ACV03 scope, as specified in the [Stacks Project rigidification summary](https://stacks.math.columbia.edu/tag/04V2). |

These changes preserve the target identities, ownership, API and diagnostic inventories, and dependency graph. They clarify conditions and proof ownership within that structure.

## Preserved mathematical distinctions

The regression review confirmed the preceding API repairs, including:

- The actual-family stack, scalar rigidification, base-line-twist quotient and sheafification remain separate constructions. A coarse horizontal section produces local representatives with total connections; global connection-preserving descent still requires its transition maps and cocycle.
- The PVI smooth-character inverse domain remains distinct from the other profiles' irreducible/nonresonant inverse domains. Both inverse laws and the all-points horizontal comparison remain explicit. Properness and surjectivity onto the independently defined full ordinary character quotient are separate theorems.
- Relative splitting strata, named exceptional loci, conditional observer adapters, geometric transformation functors and their coarse-space diagrams retain their definitions and domains.
- The boundary and symmetry lattices remain integral sublattices of Pic(S), with the null class retained. The horizontal splitting is regular on the complete boundary complement U; the compact surface S carries the rational relative two-form with its prescribed polar divisor.
- The coefficient of the canonical tau section in a fixed frame remains distinct from a scalar function normalized to a selected base-point value. JMU comparison retains its generic unramified and logarithmically nonresonant hypotheses and the required correction terms.
- Source-sign corrections, PV elimination and the PI/PII Hamiltonian normalizations remain outputs of 7.2. The eight-model sigma inventory, local full-jet converse, nondegeneracy conditions, PI/PII analytic converses, affine counterexamples and Riccati initial phase data remain in 7.4.

## Mechanical validation

[validation.json](validation.json) records **1,382 passing checks and 0 failures** against the baseline commit. The input hashes bind the receipt to the files actually checked. [check_timeless.py](check_timeless.py) reproduces the checks from a checkout containing the baseline commit and Pandoc:

```sh
python TauCetiRoadmap/PainleveEquations/reports/timeless/check_timeless.py
```

| Property | Result |
|---|---:|
| Targets | 57 |
| General / application targets | 21 / 36 |
| Layers | 8 |
| API items | 169 |
| Diagnostics | 197 |
| Supporting constructions | 27 |
| Internal prerequisite edges | 251 |
| English TeX payloads | 216, exactly preserved in order |
| Japanese TeX payloads | 204, exactly preserved in order |

The checks also verify document/plan agreement, bilingual field counts and prerequisite lists, source-scope and supplier-table synchronization, ownership registries, preceding and acyclic dependencies, independence of the general theory, independence of Layers 3–6 from Layer 7, internal links, table widths, GFM math parsing, unchanged Lean noncomment bytes and unchanged topic metadata. The general/application graph and registry are byte-identical to the baseline. Every target was revised in both languages.

The sigma verification program is unchanged. The earlier exact sigma calculations and their receipt remain bound to the API revision; this report does not present that old receipt as a new calculation on a different snapshot. The formulas, including the sigma tables, were preserved in this revision.

## Source provenance and historical records

[source-note-history.json](source-note-history.json) retains the previous and replacement text of all seventeen revised source notes. The source registry now describes fixed editions and mathematical scope; the record preserves the original retrieval history and verification limitations. In particular, GR84 had only a publisher-table-of-contents check, and this revision does not claim verification of its detailed subtheorem locators or a new full-text inspection.

The [API revision record](../api-review/REVIEW.md), its validation and sigma receipts, and the older submission reports are historical evidence for their own snapshots. They are not overwritten or relabeled as new checks.

## Validation boundary

No full `lake build` or new Lean proof was performed. `Suggested.lean` retains the required opening disclaimer and the same declarations, proof bodies and four `sorry` markers; only explanatory comments change. Parsing GFM syntax does not constitute a new visual inspection of the remote GitHub renderer. The construction and existence theorems stated in the roadmap remain mathematical formalization targets.
