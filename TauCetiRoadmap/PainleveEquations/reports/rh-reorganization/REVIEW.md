# Classical Riemann–Hilbert scope review

Baseline: `5377bc5e0288937e1fbde0d6bd4a50748720041e`.

This revision organizes the mandatory Riemann–Hilbert work around the classical Painlevé application. The English and Japanese specifications contain **55 targets: 19 framework targets and 36 application targets, in eight layers**. Layer 2 contains the four general isomonodromic-connection targets 2.1–2.4. The classical RH comparison and its continuation inputs belong to Layer 4.

The specification states mathematical constructions, hypotheses and laws directly. This report records the architectural decision, migration review and verification evidence.

## Scope and construction order

The arbitrary admitted genus, rank and polar-degree moduli construction remains in 1.1–2.4. Its strong splitting, flatness, symplectic preservation and coherent presentation/base-change laws remain general. The separate arbitrary-genus/rank logarithmic RH targets 2.5 and 2.6 are removed from the mandatory roadmap.

The four-logarithmic-point application uses the specialization to rank two on the projective line. Its auxiliary unfixed-determinant family is constructed only for that comparison. The irregular and ramified classical profiles retain their local reconstruction, family descent, full stable source, properness and separately quantified surjectivity requirements.

| Construction or comparison | Owner |
|---|---|
| Local logarithmic monodromy from horizontal transport, including resonance and analytic base change | 3.8 |
| Logarithmic and sectorial reconstruction, prescribed lattices and flags, determinant shifts and ramified descent | 4.1 |
| Ordinary and Stokes character quotients, exponent pullbacks and complete marked transport, including singular fibers | 4.2 |
| Full classical RH maps, descent and all-point horizontal compatibility; specialized PVI/I13 moduli-functor comparison | 4.3 |
| PVI family properness and its fixed-determinant restriction; full-classical properness and separate surjectivity | 4.4 |
| Local horizontal existence and completeness through the general continuation theorem | 4.5–4.6 |

Section 3.8 constructs its local monodromy before defining the marked apparent loci. It uses punctured-disk transport and holomorphic parameter dependence, with comparisons for frames, basepoints, loop markings, base-line twists and analytic base change. It has no Layer 4 prerequisite. Section 4.3 applies 0.3 before using the local total-connection representatives of 2.2; no inverse RH map is used to obtain local horizontal sections.

## Migration and mathematical review

[migration.json](migration.json) records the old proof responsibilities, their owners and their precise retained or specialized scopes. The four removed supporting-construction entries are incorporated into the local reconstruction, character-family and determinant comparisons of 3.8 and 4.1–4.4. Their disappearance from the supporting-bullet count does not remove their classical proof obligations.

The review distinguishes the following objects and assertions:

- The actual-family stack, scalar rigidification, base-line-twist quotient, sheafification and coarse space. The PVI/I13 comparison uses the unfixed-determinant functor; the fixed-determinant functor retains its determinant identification and square-trivialized base-line twists.
- The commutative determinant/RH square and the Cartesian fixed-determinant restriction square. Rank-one RH is proved to be an isomorphism with prescribed residues and lattice, on the same full time/exponent base. The fixed-determinant coarse source is then compared with the inverse image of the determinant-character section, including the scalar-gerbe comparison, before applying proper base change.
- The PVI inverse over the fiberwise smooth character locus and the other profiles' explicitly defined irreducible/nonresonant inverse loci. The PVI inverse comparison uses IIS06 directly and does not depend on 4.4.
- Properness of the total RH family and surjectivity onto the independently defined entire ordinary character quotient. Stable replacement, all components, scalar/unipotent logarithmic strata and reducible characters remain explicit requirements.
- The local monodromy's characteristic polynomial and its actual resonant Jordan structure. The added rank-two logarithmic example has identity exponential residue but nontrivial unipotent monodromy.

The revised numbered sections are 1.3, 2.4, 3.8 and 4.1–4.4. The other 48 retained numbered sections are unchanged. The sigma and Hamiltonian contracts, tau normalization distinctions, integral surface/symmetry lattices, transformation functors and earlier API-review corrections remain in their existing sections.

Two parallel AI-assisted mathematical edits were cross-reviewed independently, followed by integration review of both languages, proof ownership, prerequisites and source consumers. The review corrected the determinant-square distinction, explicitly restricted the I13 map comparison to the auxiliary PVI family, and made the local-existence route explicit. These are specification reviews, not completed formal proofs or human approval.

## Focused source verification

- [I13, arXiv math/0602004](https://arxiv.org/abs/math/0602004): the retrieved abstract identifies v2, 6 June 2012; its PDF has 45 pages. Theorem 2.2 was checked for its generic-weight condition, numerical range and full exponent fiber-product family. Definition 4.3 was checked for the locally Noetherian, set-valued moduli functor modulo base-line twists. The retained bibliography remains pinned to v2. The direct versioned endpoint failed in this session; the unversioned abstract and its PDF link provided the identified v2.
- [DEL70](https://publications.ias.edu/sites/default/files/Number9.pdf): II5.4, II5.6 and II5.9 were checked for the chosen extension, tensor limitation, nonresonant matrix comparison and regular-singular correspondence. The [April 1971 erratum](https://publications.ias.edu/sites/default/files/Erratum%20to%20SLN%20163.pdf) was checked for removal of II1.23–1.24 and replacement of the II4.1 argument. The local characteristic-polynomial statement retains resonance.

Other source scopes and editions are inherited from the baseline. The construction of the fixed-determinant restriction, the relative ramified comparisons and full admitted irregular properness remain explicit owned proof targets; this report does not attribute them to a broader theorem than the cited source supplies.

## Reproducible validation

[validation.json](validation.json) records **1,944 passing checks, 0 failures and 0 skips**, together with the SHA-256 hashes of their inputs. [check_reorganization.py](check_reorganization.py) accepts a baseline directory containing the PainleveEquations subtree at the baseline commit:

```sh
painleve_baseline_dir=$(mktemp -d /tmp/painleve-rh-baseline.XXXXXX)
git archive 5377bc5e0288937e1fbde0d6bd4a50748720041e TauCetiRoadmap/PainleveEquations | tar -x -C "$painleve_baseline_dir"
python TauCetiRoadmap/PainleveEquations/reports/rh-reorganization/check_reorganization.py --baseline-dir "$painleve_baseline_dir/TauCetiRoadmap/PainleveEquations" --output /tmp/painleve-rh-validation.json
```

The checker requires Python, Pandoc and SymPy. The historical timeless checker is preserved unchanged and is used only for its parsing helpers; its 57-target acceptance conditions are not applied to this revision.

| Property | Result |
|---|---:|
| Targets | 55 |
| Framework / application targets | 19 / 36 |
| Layers | 8 |
| API items | 171 |
| Diagnostics | 195 |
| Supporting-construction bullets | 23 |
| Internal prerequisite edges | 249 |
| Existing English TeX payloads | 216, unchanged in order |
| Existing Japanese TeX payloads | 204, unchanged in order |

The validation compares the README and plan fields, bilingual prerequisite lists, supplier tables, graph, ownership registry and source consumers. It checks preceding and acyclic internal dependencies, independence of the framework, no Layer 3–6 prerequisite in Layer 7, the local 3.8 construction order, links and GFM math/table parsing. The new resonant example is verified by exact symbolic differentiation, residue exponentiation and analytic-continuation algebra.

`Suggested.lean`, `metadata.toml` and the historical validation programs are unchanged. No full `lake build`, new Lean proof check or new remote-browser rendering inspection was performed. The validation establishes consistency of the roadmap and its specified comparisons; the mathematical formalization targets remain to be proved.
