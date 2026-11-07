# API review response

This revision answers findings R01–R08 and C01–C09 in the supplied Japanese API review of commit `d59dd62f39e96a680baf3656fc4398dfa8de7fb2`. The English and Japanese specifications, structured plan, prerequisite graph and source locators are synchronized. The 57 target identities and eight numerical layers are retained.

## Findings and changes

| Finding | Targets | Resolution in the specification |
|---|---|---|
| R01 | 7.4 | Fix the eight-profile sigma inventory and its local inverse branches. For PI/PII prove the analytic non-affine converse; for PII distinguish spurious affine branches from the genuine Riccati family and retain its phase initial point. |
| R02 | 7.2, 7.4, 7.5 | Move the VDPS09 extended-form sign and PV-elimination corrections into 7.2 before their consumers. Make the PI/PII Hamiltonian normalization an output of 7.2, used by 7.4 and 7.5. |
| R03 | 2.2 | Return a strong total connection on local representative families of a horizontal coarse section. Specify the scalar line-connection ambiguity, comparison arrows, descent cocycle and the obstruction to a global representative. |
| R04 | 4.3 | Define both inverse loci: the smooth character-surface locus for PVI, and the stated irreducible/nonresonant locus for other admitted profiles. Own the lattice/flag reconstruction, holomorphic dependence and both inverse identities. |
| R05 | 4.4 | Set Rθᵃᵈᵐ := Rθ with explicit local, Stokes, deck, product and determinant constraints independent of RH. Require surjectivity onto this entire ordinary quotient separately from properness. |
| R06 | 4.8, 4.9, 7.2 | Make 4.8 a conditional observer adapter, 7.2 the owner of concrete classical q and its admissibility/coverage certificates, and 4.9 the meromorphic evaluation theorem. |
| R07 | 1.3 | Define relative splitting-type substacks and their coarse images, the locally closed inclusions and the balanced open locus. Remove unspecified closure comparisons. |
| R08 | 3.8 | Define indexed resonance hyperplanes, invariant-line incidence and reducible loci, and ordinary/projective apparent-monodromy loci. Keep apparent poles of a chosen cyclic presentation in 7.2. |
| C01 | 5.4, 5.5, 7.4 | Construct parameter maps, functors on stable domains, descended coarse maps and their commuting diagrams; assign horizontal/symplectic laws to 5.5 and coordinate diagrams to 7.4. |
| C02 | 3.2 | State the time tangent exact sequence; a direct-sum identification requires a specified splitting and its change law. |
| C03 | 4.2 | Separate the decorated groupoid, the forgetful morphism to ordinary representation/Stokes data, and the affine character quotient. |
| C04 | 1.3, 2.5, 2.6 | Distinguish actual families, scalar rigidification, the base-line-twist set functor Q, its sheafification and the coarse space. Compare Q_log, rather than the unmodified groupoid, with I13 Definition 4.3. |
| C05 | 1.4, 1.5 | Make 1.4 own the trace chain map and fixed-determinant homotopy fiber. Make 1.5 own the scalar section, splitting, orthogonality and smoothness consequences. |
| C06 | 2.3 | Restrict naturality to the specified presentation isomorphisms and admitted base changes; do not quantify over arbitrary parameter correspondences. |
| C07 | 5.1, 5.5 | Define the integral boundary lattice and its orthogonal complement in Pic(S), retaining δ = −K. Construct the concrete symmetry-root span and its comparison in 5.5. |
| C08 | 5.2 | Extend the symplectic form rationally to S with its stated polar divisor, and extend the regular horizontal splitting only over every chart of U = S \ D. |
| C09 | 6.5 | Separate the canonical-section coefficient f in τ_T = f e from f_norm = c f/f(t₀); give the proportionality, logarithmic-derivative and frame-change laws. |

The supplementary dependency observation is also addressed: 4.3 directly depends on 3.12 for naturality, and its hypotheses no longer import the unused total-form output of 3.11. A forward textual reference to a later formula is not used as a proof prerequisite.

## Mathematical regression checks

The PI and PII calculations check the differentiated sigma equations and the reconstruction identities exactly. In particular, at c = 0 the PII function σ(t) = t + 2 satisfies the sigma equation and σ′ ≠ 0, but gives q = 0, p = −2 with nonzero first Hamilton residual. The new converse excludes this affine branch. For the actual Riccati branch σ = 0, its many phase trajectories remain distinguished by their initial phase points.

The finite inventory fixes PI, PII, PIII(D₆), PIII(D₇), PIII(D₈), PIV, PV and PVI. Exact symbolic checks substitute each Hamilton vector field into its stated sigma polynomial. The inverse-function construction uses explicit determinant and sigma-polynomial derivative conditions together with a chosen initial phase branch. It does not assert a sigma-only inverse on excluded branches. D7/D8 source vector-field changes and the PVI coefficient convention receive separate algebraic checks.

These finite calculations verify formulas and regressions. The local analytic inverse theorem, moduli descent, global RH existence/properness, coverage and other construction targets still require the mathematical proofs specified in the roadmap.

## Reproducible validation

- [check_api_revision.py](check_api_revision.py) checks document/plan agreement, bilingual target changes, API and diagnostic numbering, prerequisite order and acyclicity, general/application separation, source keys, Markdown math syntax, table widths, unchanged Lean interfaces and the PI/PII regression identities. Run it from this directory with `python check_api_revision.py --output validation.json`.
- [validation.json](validation.json) records 992 passing checks and 0 failures, with exact input hashes. It records 57 targets, 169 API items, 197 diagnostics, 251 internal prerequisite edges and 27 supporting constructions.
- [verify_sigma_inventory.py](verify_sigma_inventory.py) and [sigma-inventory-validation.json](sigma-inventory-validation.json) record 29 passing exact algebraic checks: eight sigma identities, seven reconstruction Jacobians, eight scalar dictionaries, four D7/D8 first-order conjugacies, the D8 time-only correction and the PVI wrong-coefficient counterexample. Run `python verify_sigma_inventory.py --output sigma-inventory-validation.json`. Both validation scripts require SymPy; the document parser also requires Pandoc. They are independent of the historical submission validator.

`Suggested.lean` and `metadata.toml` are byte-identical to the reviewed commit. No full `lake build`, new Lean proof or fresh visual inspection of GitHub's renderer is claimed. The existing historical receipts retain their original inputs and results; their older check counts do not certify this revision.

Prepared with AI assistance from GPT-6 Astra Pro. This response records changes and finite verification, not human mathematical approval.
