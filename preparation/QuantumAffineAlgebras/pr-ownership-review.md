# QuantumAffineAlgebras: open-PR ownership and source revision review

**Verdict: accepted. Remaining findings in this review: 0.**

This is the author's AI-assisted supplementary self-review of the revised scope, supplier
boundary, current open-roadmap inventory and source-independence delta. It is not maintainer
approval or an external human review. The six declared supplier gaps are requirements of a
roadmap, not claims that the corresponding theorems are implemented or already proposed.
No primary roadmap file was edited by this reviewer.

## Reviewed identity

| Item | Identity |
| --- | --- |
| Roadmap commit | `42a40c74cd66cf8b51d8456e835db66fb392c6e8` |
| README SHA-256 | `631c9c628b1d25a07322f959a8d7f7b79d804525a106c4877b24502fcb6581d4` |
| Suggested.lean SHA-256 | `fea5fbc078c55a7410222589b3da47976749bbb8d2d162392d718c655c3bc389` |
| metadata.toml SHA-256 | `59159a8bb65b50330403f417dd20d78640e3689e84ba3e06af27866690a2574e` |
| Current main compared | `4b6909559eb5e50a1cc8b86522723fb6e9db69bf` |
| Initial main compared | `c6ef576569501d342dec5a31a9938c9549dc6a00` |
| Worker | `162470c202cff60e47b8d3339f2d609a6bb40d45` |
| Final open-PR collection cutoff | 2026-11-17 07:02:57 UTC |

The frozen README has 1,717 lines. The three worktree files were compared byte for byte with
the recorded commit. The title is **quantum affine algebras, finite-dimensional representations
and monoidal categorification**. The roadmap's subject is quantum affine algebra; the general
quantum representation theory is explicitly consumed from its assigned suppliers.

## Complete open-PR coverage and refresh

The initial collection enumerated all 453 open PRs, including a terminating empty page,
read every changed-file list across all its pages, fetched each exact head, and searched all
499 touched-folder README and 494 Suggested.lean snapshots. Focused candidates were read in
context. This is complete inventory and text-search coverage, not a claim of line-by-line
mathematical review of every unrelated roadmap.

The final refresh repeated the entire open-PR metadata collection. Its six page lengths were
100, 100, 100, 100, 51, 0. It found 451 open PRs: #872 and #879 had merged, and #117 alone had
changed its head. No PR was added. The full #117 file list, new README and Suggested.lean were
acquired at `7db30a3f61545185a80ca698fb543f8418370d75`; its complete delta concerns product
measure comparison for Laguerre/Jacobi bases and adds no relevant supplier.

| Final current inventory | Count |
| --- | ---: |
| Open PRs / exact fetched head checks | 451 / 451 |
| PRs touching roadmap folders | 450 |
| Changed filenames | 1,400 |
| README / Suggested.lean snapshots | 497 / 492 |
| Distinct touched roadmap names | 490 |
| New roadmap-name snapshots | 446 |
| Revisions at a main path | 50 |
| Active-folder copy of an existing Completed owner | 1 |
| Missing READMEs / head mismatches | 0 / 0 |

The last classification is #986, PolynomialGaloisGroups, whose owner already exists under
Completed. It is not a new supplier. #2119 has an empty changed-file list and contributes no
roadmap snapshot. The main update added the two merged roadmaps and changed repository-level
README/templates; all relevant QEA, KacMoody, cluster and Grothendieck supplier files are
unchanged. The two newly merged roadmaps therefore remain covered by their exact previously
read heads and are now classified on main.

Evidence: [complete inventory](open-pr-inventory.json), [refresh delta](open-pr-inventory-refresh.json),
[initial inventory](open-pr-inventory-initial.json), [candidate audit](open-pr-inventory.md), and
[unchanged-worker neighbor search](open-pr-neighbours.md). The separate gate and neighbor run
use the refreshed 497 exact-head README tuples. The original review without complete open-head
inputs is not used as evidence for the current open-PR dependency check.

No current open PR supplies a competing general quantum crystal/global-basis or quantum-affine
representation foundation. The detailed candidate audit includes #989, #1775, #2411, #1492,
#1313, #1235, #1547, #1427 and #1737, with exact head links and actual hypotheses. Neither
classical Satake/Tannaka theory nor a symmetric classical character ring supplies the
nonbraided, generally nonsemisimple affine category. The quantum-enveloping references in
#1427 concern Gaussian binomials, not ownership of general quantum representation theory.

## Historical general suppliers are merged

The following statuses were checked with GitHub PR metadata. None is an open-PR dependency.
The scopes in the current main files, rather than an old PR title, determine what is supplied.

| PR | Status and merge time (UTC) | Head SHA | Merge commit |
| --- | --- | --- | --- |
| [#2363](https://github.com/TauCetiProject/TauCetiRoadmap/pull/2363), QuantumEnvelopingAlgebras: define f by the radical of its form | closed, merged; 2026-11-16 18:48:27 | `a6737a5694c79f55c6ac02c9bb4d94e806c6037c` | `6a3e87d97f4782b34bfaaf5bc8855ca1648f5894` |
| [#1125](https://github.com/TauCetiProject/TauCetiRoadmap/pull/1125), Quantum enveloping algebras, integral PBW and Frobenius | closed, merged; 2026-11-05 06:59:12 | `da68a5fb551b33557ad36a59092fe9bb25cdbaed` | `81409789cbdc9f3a5f2771f71bae48c7d365f071` |
| [#1124](https://github.com/TauCetiProject/TauCetiRoadmap/pull/1124), Kac–Moody algebras, integrable modules and path crystals | closed, merged; 2026-11-05 13:54:09 | `cdf21a5fa6eb9666dbbcae6467c5c36b5008301f` | `77387da2ed852b5455cab32935c06766a8c330a9` |

Machine-readable evidence is in [historical-supplier-prs.json](historical-supplier-prs.json).
Main QuantumEnvelopingAlgebras owns the general algebra/Hopf/Serre constructions, homogeneous
pairings and braid operators; its §2.3 owns quantum category O, Verma modules, Casimir and the
character formula. Its scope assigns further type-1 integrable theory and quantum crystals to
KacMoody, Part II. KacMoody itself owns classical Lie and path-crystal theory. The affine
roadmap does not infer a quantum crystal theorem from the classical path model.

KacMoodyPartII has no existing roadmap folder on main or in this open-PR inventory. It is the
future general scope named by the two main owners. The five explicit contracts below make
that missing general support visible. They do not claim that a PR with this title was found.

## Six supplier gaps and the affine work they feed

| Declared contract | General supplier obligation | Work retained in QuantumAffineAlgebras |
| --- | --- | --- |
| `gap:completed-canonical-element` — QuantumEnvelopingAlgebras | A normalized quasi-R element for every finite-rank symmetrizable datum, with its completion, pairing comparison, basis independence and coproduct identities | §5.1 spectral action, convergence, opposite orientation, toral factor and scalar extension; §§5.2–5.3 rational normalization and specialization |
| `gap:integrable-string-decomposition` — KacMoodyPartII | Rank-one type-1 integrable string decomposition in the specified generator convention, without finite-dimensionality | §2.1 applies it to the derived affine algebra; no degree-torus extension of an evaluation module is assumed |
| `gap:universal-extremal-module` — KacMoodyPartII | The universal full-datum integrable module representing extremal vectors, including the zero vector and normalized extremal family | §4.1 restriction to U′, classical-weight grading, normalized Weyl transport and δ-lift comparison |
| `gap:extremal-global-basis-model` — KacMoodyPartII | The rational balanced global-basis model, all-symmetrizable modified crystal, ordinary/star structures and extremal quotient | §4.2 basic level-zero structure, finite weight multiplicities, scalar extension and generator/parameter transport |
| `gap:crystal-schubert-strata` — KacMoodyPartII | General negative-half Schubert subsets and strata, reduced-word independence, star inversion and raising identities | §4.2 affine bounded-length covering and its multiplicity consequences |
| `gap:crystal-tensor-rule` — KacMoodyPartII | Crystal-lattice tensor theorem and signature rule for the stated coproduct and admissible quotient weight grading | §4.3 affine finite simple-crystal consequences and periodic fundamental quotients |

These contracts neither expand the finite-type QuantumEnvelopingAlgebras §5.3 result by
implication nor reconstruct its general extension locally. General half/highest-weight bases
and the modified-sector construction are expressly supplier proof obligations. Rational
forms, transported bar/lattices, full-P versus Pcl weights, and ordinary versus star crystal
actions remain distinguished. The affine spectral classification, exact Grothendieck ring,
real-simple tensor theory and KKOP predicate are owned by the affine roadmap.

The completed-element contract distinguishes the raw pairing tensor from the normalized Ξ.
Section 5.1 explicitly compares K02's orientation with the inverse-and-swapped orientation
expanding at z=0. It therefore does not outsource the affine action or its convergence by
merely assuming an element of an uncompleted tensor product.

## Retained support in §§6.1–6.2

Section 6.1 uses the category of modules finite-dimensional over k for an arbitrary unital
k-algebra A. Native modulewise Jordan–Hölder multiplicities and exact-sequence additivity
provide the coordinates; the new target descends them to the exact Grothendieck group and
proves the basis/inclusion results. The native `TauCeti.simpleClassBasis` theorem for finitely
generated modules over an Artinian ring does not instantiate at U′. The roadmap does not
duplicate Jordan–Hölder or assume the affine algebra is Artinian.

The nearest open proposal for §6.2 is [#1775 §1.2 at its audited head](https://github.com/TauCetiProject/TauCetiRoadmap/blob/8379fbab8b8991aba117b742b8f590f0869d1bcd/TauCetiRoadmap/RepresentationTheory/ModularCharactersAndBlocks/README.md).
It concerns finite-group K[G]-modules over a p-modular system, and its ArithmeticGaloisDuality
supplier covers a still narrower p-adic coefficient situation. It does not supply arbitrary
k-algebras over the equal-characteristic ring R=k[z] localized at (z−1).

The revised §6.2 states that different invariant R-lattices with isomorphic generic fibres
have equal special-fibre classes. Its proof is owned locally: after rescaling and inclusion,
the torsion quotient Q gives the four-term reduction sequence; kernel/cokernel additivity for
multiplication by t yields equal end classes. For L₁=tⁿR⊂R, both end terms have dimension one
although Q has dimension n. For A=k[x] with x(e₂)=te₁, the two indicated lattices reduce to a
zero action and a rank-one nilpotent action, which are not isomorphic but have the same class.
These checks distinguish equality of classes from lattice isomorphism and from semisimplicity.

Thus §§6.1–6.2 are explicit supporting variants with additional hypotheses/outputs explained.
Retaining them does not create a competing general quantum representation roadmap. A future
general module-theory supplier could take them over, but no currently audited owner already
provides the required statements. Adding #1775 as a dependency would not discharge them.

## Source locators and independence delta

The earlier [structure review](structure-review-final.md) recorded 72 locator comparisons and
8 further prose comparisons across 10 sources for commit `9f9a91680f97a98778950d2e202d1444d0b9d967`.
That evidence is retained only for unchanged passages. This supplement checks the changed
general-supplier boundary and its source comparisons at the frozen new hash; it does not
describe all earlier comparisons as fresh work.

[source-locator-count.py](source-locator-count.py) reproduces the earlier 72 count and the
current 78 count. One explicit source ID followed by its locator is one bundle; listing several
results after that ID does not multiply the count. Repeated bundles do count separately.
Bibliography entries and unlocated mentions are excluded. Exact line positions and the
two README hashes are in [source-locator-delta.json](source-locator-delta.json).

| Source | Earlier bundles | Current bundles |
| --- | ---: | ---: |
| KKOP20 | 25 | 26 |
| K02 | 15 | 20 |
| AK97 | 7 | 7 |
| KKOP22 | 7 | 7 |
| CP95 | 6 | 6 |
| CP98 | 4 | 4 |
| K94 | 3 | 1 |
| KKKO15 | 3 | 3 |
| K91 | 1 | 3 |
| H10 | 1 | 1 |
| **Total** | **72** | **78** |

Sixteen fresh passage/source comparisons were made for this revision, across K91, K94, K02
and KKOP20. Nine concern the six supplier contracts: K02 §7; K91 §2.2; K02 §3.1;
the global-basis model against K91 Theorems 2,4,6,7, K94's modified/extremal results and
K02 §§2.2,3.1; K02 §2.3; and the tensor contract against K91 §2.4 and K02 §4.2.
Two more compare the new orientation passage against K02 §§7–8 and KKOP20 §2.2.
Five further prose comparisons come from different sections:

| Further passage | Source text compared | Result |
| --- | --- | --- |
| Conventions, dual evaluation domains | KKOP20 §2.1, p.8 | Independent convention comparison; the evaluation domains determine the names |
| §3.2, intrinsic/Laurent affinization and base-change API | K02 §4.2, p.16 | Independent construction/API wording; only the forced action formulas coincide |
| §4.1, restriction, normalized Weyl maps and δ-lifts | K02 §3.1, pp.8–9 | Independent affine comparison and coherence obligations |
| §4.2, rational balanced model and scalar extension | K02 §2.4, pp.7–8 | Independent implementation-facing hypotheses; no extension of bar to all of k is claimed |
| §9.4, the endpoint and required application data | KKOP20 Introduction, pp.2–3 | The standard predicate is stated with explicit finite-word and frozen-coefficient conventions |

The K91 tensor locator was corrected during this revision to **§2.4, Theorem 1 and (2.4.3),
journal pp.475–476**, with its coproduct at p.472. The rank-one decomposition is **§2.2,
(2.2.1)–(2.2.4), p.473**. These statements were read from local page images/OCR; no inaccessible
book passage is being presumed. The displayed mathematical identities and theorem names are
forced mathematical content. No copied prose, translated proof plan, table, figure, exercise
list or external formalization was found in these comparisons.

KKOP20 has the largest share, **26/78 = 33.3%**. Its table of contents was read: preliminaries,
two sections on new numerical invariants, cluster algebras, then categorification. The roadmap
instead develops affine algebra/category/spectral families/fundamental modules before its
R-matrices and exact K₀, consumes cluster constructions, omits the numerical-invariant
programme, and treats component subcategories separately using KKOP22. Its order is dictated
by the explicit dependency chain from spectral classification and R-matrices to K₀ and then
categorical exchange. Its nine layers do not copy a run of the paper's sections in the same
scope or order. The general-source transfer further clarifies that the foundational sequence
is not an imitation of a single research article's arrangement.

Source independence: 16 additional passages compared with 4 sources, no copied expression found; the earlier 80-passage/10-source review remains evidence only for unchanged passages; largest share KKOP20, 26 of 78 locator bundles (33.3%); contents compared with KKOP20: independent.

Research link: Kashiwara's 2002 level-zero representation theory supplies fundamental modules and R-matrices used by Kashiwara–Kim–Oh–Park (2020) for monoidal categorification. The roadmap reaches their ordinary cluster-algebra predicate; generic foundations are consumed separately. This connection is stated in K02 and KKOP20's introductions and in the roadmap's motivation.

## For the human reviewers

- none
