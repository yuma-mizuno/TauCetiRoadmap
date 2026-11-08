# Shared classical Riemann–Hilbert proof structure

Baseline: `fa5beb6d40adf6b8b96db4116b0aeabf781074fc` on `codex/painleve-roadmap-working`.

:robot: AI-assisted drafting and review using GPT-6 Astra Pro. This record covers verification performed while preparing the revision, with separate agent passes for drafting, mathematical review and structural validation.

This review records the reorganization of the classical RH construction and proof responsibilities in §§4.1–4.4. The mathematical specifications are [README.md](../../README.md) and [README.ja.md](../../README.ja.md). The active specification uses timeless mathematical statements; this report records the revision and its verification.

## Proof ownership

| Target | Common construction or proof | Specialization and comparison |
|---|---|---|
| 4.1 | Local meromorphic/Stokes correspondence, decorated reconstruction, analytic descent and determinant compatibility. | Logarithmic, generic unramified and generic ramified local models supply reusable local results. The logarithmic model is included in the same correspondence. |
| 4.2 | An independently defined ordinary Betti quotient, retained exponent coordinates, determinant morphisms and complete time transport. | Four logarithmic points give the explicit exponent fiber product and its comparison with I13. |
| 4.3 | The holomorphic RH map, rank-one RH isomorphism, coarse determinant-restriction lemma, generic inverse and all-point horizontal compatibility. | The four-point moduli-functor comparison identifies I13's RH map. The stronger inverse on smooth PVI character fibers extends the common generic inverse. |
| 4.4 | Local extension and boundedness results, quotient-compatible global reconstruction, stable replacement, compact inverse images and separate stable realization. | The four-logarithmic properness and surjectivity statements follow from the common proof. Fiber geometry and the stronger PVI inverse give the fiberwise bimeromorphicity and resolution statements. |

The determinant/RH comparison, rank-one reconstruction and coarse restriction are owned once, in §4.3. Their use in §4.4 does not create a second construction. The four-logarithmic map is obtained by specialization, with its exact functor, marking and parameter comparisons retained.

The shared proof is a mathematical obligation of the roadmap, not a claim that a cited paper already implements it. Local extension results alone do not imply properness. Section 4.4 also requires global bounds over the affine quotient, control of nonsemisimple representatives, connection-preserving replacement, and continuous compact parameter sets covering every inverse image of a compact set. It does not invoke a generic inverse locus to prove compactness on a resonant fiber.

## Scope and conclusions retained

- All 55 target identities remain: 19 general framework targets and 36 classical Painlevé application targets. The general moduli and isomonodromic-connection constructions remain independent of the application.
- The classical input remains the admitted genus-zero, rank-two, structural-degree-four data of §3.3, including its determinant, nonemptiness, weight and local-model conditions. The determinant-relative comparison varies compatible regular-singular line connections within these same data.
- All admitted logarithmic resonance, scalar and unipotent strata, reducible characters, bundle types and generic ramified models remain. The leading-coefficient and noncollision conditions are unchanged.
- Properness concerns the complete admitted time/exponent families and their analytic base changes. A compact set is controlled together with its time and exponent projections.
- The ordinary target remains independent of RH and its image. Surjectivity is a separate assertion for every point of every component, with stable realization retaining the prescribed coarse character and local constraints.
- The common inverse on the irreducible, logarithmically nonresonant locus includes PVI. The stronger PVI inverse on the smooth part of each character fiber remains available at resonant exponent values.
- The four-point auxiliary family retains its full exponent fiber product, exact numerical and stability hypotheses, and fiberwise and total-family bimeromorphicity. Irreducibility and density are separate geometric proof obligations; they do not follow from the existence of an inverse alone.
- All-point horizontal compatibility and the proper-semiconjugacy route to continuation remain independent of RH invertibility. No general-rank or arbitrary-curve proper RH theorem is added.

## Source review

[Sabbah, *Introduction to Stokes structures*, arXiv 0912.2762v5](https://arxiv.org/abs/0912.2762v5), is registered as SAB12. Definition 2.22 and Theorem 5.8 supply the ramified local meromorphic/Stokes framework; Proposition 5.5 identifies its regular-singular specialization and Proposition 5.12 treats curve gluing. Chosen lattices, flags, determinant data and their relative comparisons remain explicit constructions of §4.1.

[Inaba, *Moduli of parabolic connections on a curve and Riemann–Hilbert correspondence*, arXiv math/0602004v2](https://arxiv.org/abs/math/0602004v2), is used with its exact four-point specialization. Definition 4.3 supplies the family-functor comparison; §6 supplies logarithmic stable-replacement and compactness arguments. Proposition 5.3 and the proof of Theorem 2.2 supply the source irreducibility and character-locus geometry needed for the fiberwise conclusions. The shared classical proof is not replaced by an unverified application of a general properness criterion.

The scopes of IS12, I23 and HEU10 remain explicit. The generic unramified RH theorem, the construction of a global isomonodromic foliation and universal strong isomonodromic deformation have different conclusions. The additional local extension and family compactness results are owned in §4.4.

## Verification

A separate AI review pass checked the common proof structure, determinant comparisons and preservation of the stronger PVI conclusions. The English and Japanese sections were reviewed together. The structured plan, source locators, prerequisite graph and reuse registry are synchronized with those sections.

The reproducible structural check is [check_sharing.py](check_sharing.py); its result and input fingerprints are in [validation.json](validation.json). It checks all numbered contracts and existing bilingual metadata, derived counts, source consumers, prerequisite order, framework independence, Markdown structure, mathematical payload parsing, and the unchanged-section boundary against the pinned baseline. The other 51 numbered sections are unchanged. Historical verification programs and receipts are retained; the submission index receives an additive pointer to this record.

No Lean build, theorem proof or new GitHub visual-rendering inspection is claimed. `Suggested.lean` and topic metadata are unchanged. Structural validation verifies synchronization and preservation; mathematical proof remains the work specified by the roadmap.
