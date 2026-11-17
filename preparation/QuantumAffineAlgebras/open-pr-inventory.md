# Audit of open roadmap pull requests

## Result and extent

This supplementary audit closes the open-pull-request inventory gap in the earlier review of
QuantumAffineAlgebras. The earlier review did not establish complete coverage of open PR heads.
This audit enumerated every open PR at its snapshot, inspected every changed filename, fetched the exact
heads, and searched all touched roadmap README and Suggested.lean files. Relevant ownership
candidates were then read with their actual hypotheses.

The initial snapshot contained **453 open PRs**, of which **452 touch roadmap folders**, with **1,406 changed
filenames**, **499 README snapshots** and **494 Suggested.lean snapshots**. Every one of the 453
listed head SHAs was verified against a fetched PR ref. There are **zero missing touched-folder
READMEs and zero head mismatches**. The sole non-roadmap PR is #2119, whose current changed-file
list is empty.

The final refresh at **2026-11-17 07:02:57 UTC** contains **451 open PRs**, **1,400 changed
filenames**, **497 README snapshots** and **492 Suggested.lean snapshots**. PRs #872 and #879
merged during the audit; #117 alone changed its head. All 451 current head SHAs were verified,
the changed #117 README and Suggested.lean were inspected, and the remaining heads were unchanged.
The new main commit is `4b6909559eb5e50a1cc8b86522723fb6e9db69bf`; the relevant quantum,
Kac–Moody, Grothendieck and cluster suppliers have no changes from the initial main.
The complete refreshed inventory is [open-pr-inventory.json](open-pr-inventory.json), and
[open-pr-inventory-refresh.json](open-pr-inventory-refresh.json) records the complete refreshed
metadata collection and exact delta. The initial inventory remains separately archived.

No open PR in either snapshot supplies a general quantum crystal/global-basis or quantum-affine
representation foundation. The nearest concrete overlap is the stable-lattice reduction theorem
in ModularCharactersAndBlocks §1.2: its finite-group, mixed-characteristic modular-system scope
does **not** supply the arbitrary-algebra, equal-characteristic local-lattice statement used in
the affine Grothendieck-ring argument. The different hypotheses require an explicit variant:
either a fully stated supporting theorem proved in this roadmap or a precisely assigned
general-supplier extension. They do not justify adding a dependency on that PR.

This is a complete inventory and complete text search followed by a focused mathematical
ownership review. It does not claim a line-by-line human mathematical review of all 105 MB of
open-PR README text.

## Initial snapshot provenance

| Item | Evidence |
| --- | --- |
| Repository | [TauCetiProject/TauCetiRoadmap](https://github.com/TauCetiProject/TauCetiRoadmap) |
| Snapshot date | 2026-11-17 |
| Main comparison commit | `c6ef576569501d342dec5a31a9938c9549dc6a00` |
| Listing | `GET /repos/TauCetiProject/TauCetiRoadmap/pulls?state=open&sort=created&direction=asc&per_page=100&page=N` |
| Page sizes, including terminating empty page | 100, 100, 100, 100, 53, 0 |
| Changed filenames | GitHub `list_pr_changed_filenames`, which traverses all file-list pages, for all 453 PRs |
| Exact head checks | 453 / 453 fetched refs agree with recorded SHA |
| Touched roadmap names | 492 distinct names across 499 PR/roadmap snapshots |
| New-folder/revision distinction | 448 genuinely new roadmap names; 50 revisions at a main path; 1 new active copy of a completed owner |
| Source files searched | 499 README files, 494 Suggested.lean files |
| Complete initial machine inventory | [open-pr-inventory-initial.json](open-pr-inventory-initial.json) |
| Worker neighbor evidence | [open-pr-neighbours.md](open-pr-neighbours.md) and [open-pr-neighbours.json](open-pr-neighbours.json) |

The inventory records each PR number, title, URL, state, draft flag, head repository, branch and
SHA, base information, all changed filenames, touched roadmap folders, and a hash of its
initial description. PR descriptions and full upstream README/Lean text remain acquisition
snapshots; they are not reproduced in this audit package.

The touched-folder rule is the worker's rule: a changed README.md, Suggested.lean or metadata.toml
under TauCetiRoadmap or Completed contributes its parent roadmap folder, including nested
RepresentationTheory roadmaps. Exact README contents were read from the recorded head SHA,
not from a subsequently moving branch. Main revisions and new roadmap proposals remain distinct. In particular, #986 adds an active-folder copy of PolynomialGaloisGroups, whose owner already exists under Completed on main; it is not counted as a new supplier.

## Search and comparison

The search included titles, descriptions, changed paths, and complete text at PR heads. The
object terms covered quantum enveloping and affine algebras, Kac–Moody theory, crystal/global
bases, extremal modules, Drinfeld presentations and currents, normalized and renormalized
R-matrices, ordinary cluster algebras, monoidal categorification, simple-class Grothendieck bases,
stable lattices, reduction-class independence, density, and surrounding tensor-category and
representation-theory owners.

Results were checked in context. For example:

- The quantum-enveloping matches in HabiroNahmSeries are supplier citations for Gaussian
  binomials, not a competing construction of quantum representation theory.
- The Kac–Moody matches in the RepresentationTheory family index delimit its finite-type scope.
- Kashiwara matches in the open D-module and Hodge-theory roadmaps concern characteristic cycles
  or Riemann–Hilbert theory.
- Ordinary occurrences of “global basis” in arithmetic or Hilbert-space constructions do not
  denote quantum global bases.
- An “R-matrix” occurrence in PadicHodgeRegulators means a matrix over a coefficient ring R.

The unchanged worker vocabulary and subject-neighbor functions were initially run on **322 main
roadmap names plus all 499 open-head README tuples**, then rerun on the frozen candidate against
**324 current-main names and 497 refreshed open-head tuples**. Both runs found no open-PR
vocabulary neighbor above 0.08 and no subject neighbor above 0.5. The final main vocabulary
scores are QuantumEnvelopingAlgebras 0.195, ClusterAlgebras 0.182, KacMoody 0.135,
QuantumGroups 0.126 and HopfologicalAlgebra 0.124. The neighbor scores supplement the object
search; they do not by themselves prove disjoint ownership. The linked neighbor artifacts
record the final main and candidate identities.

## Mathematically relevant open candidates

The following are the candidates that could plausibly affect ownership or be mistaken for an
input. Each link fixes the audited commit. Other open proposals were retained in the complete
inventory and searched mechanically.

| PR and head | Relevant content inspected | Consequence for QuantumAffineAlgebras |
| --- | --- | --- |
| [#989](https://github.com/TauCetiProject/TauCetiRoadmap/pull/989), `54c7750d5185008da72c09314527f7bcad2d4b7e` | [SemisimpleAlgebras](https://github.com/TauCetiProject/TauCetiRoadmap/blob/54c7750d5185008da72c09314527f7bcad2d4b7e/TauCetiRoadmap/RepresentationTheory/SemisimpleAlgebras/README.md): Scope, exact native contracts, §§1.1, 2.2–2.3 and Layer 3. This revision consumes the already pinned Schur/density/semisimple theory; its owned theorem is simple-source Skolem–Noether §5.1. | Use the native density and endomorphism results already available. This open revision adds no missing quantum-affine or crystal theorem and need not become a dependency. |
| [#1775](https://github.com/TauCetiProject/TauCetiRoadmap/pull/1775), `8379fbab8b8991aba117b742b8f590f0869d1bcd` | [ModularCharactersAndBlocks](https://github.com/TauCetiProject/TauCetiRoadmap/blob/8379fbab8b8991aba117b742b8f590f0869d1bcd/TauCetiRoadmap/RepresentationTheory/ModularCharactersAndBlocks/README.md): Scope, native simple-class basis contracts, §§1.2 and 2.4. Stable lattices in finite-dimensional K[G]-modules over a p-modular system have equal reduction classes. It consumes ArithmeticGaloisDuality §R02.4.4 for the narrower p-adic case. | This is the closest reduction-lattice owner, but G is finite and the coefficient situation is modular. It does not already prove the arbitrary k-algebra statement over k[z] localized at z−1. A fully stated and proved supporting variant, or a precisely assigned generic extension, is required; adding this PR as a dependency would not provide the needed theorem. |
| [#2411](https://github.com/TauCetiProject/TauCetiRoadmap/pull/2411), `0c072e1e2e13e67f39a85ed47dd6bfa0c46b7549` | [ModularCharactersAndBlocksPartII](https://github.com/TauCetiProject/TauCetiRoadmap/blob/0c072e1e2e13e67f39a85ed47dd6bfa0c46b7549/TauCetiRoadmap/ModularCharactersAndBlocksPartII/README.md): Scope and §1.2 supplier reference; finite-group Glauberman correspondence and block heights. | It consumes the preceding lattice theorem and does not enlarge it to general algebras. |
| [#1492](https://github.com/TauCetiProject/TauCetiRoadmap/pull/1492), `a8badcd06b16a3a125b84a9a0b00ce9eae81eef3` | [ClassicalGroupsPartII](https://github.com/TauCetiProject/TauCetiRoadmap/blob/a8badcd06b16a3a125b84a9a0b00ce9eae81eef3/TauCetiRoadmap/ClassicalGroupsPartII/README.md): Scope and Conventions; characteristic-zero algebraic representations of GSp, character rings, and a split-to-exact K₀ comparison using semisimplicity. | The affine category is generally nonsemisimple and unbraided. Neither its exact K₀ commutativity nor polynomial presentation follows by substituting this character-ring theorem. |
| [#1313](https://github.com/TauCetiProject/TauCetiRoadmap/pull/1313), `4cfd9b703dfedaf8596b66e9737b743fc29ac532` | [MotivesAndAlgebraicCycles](https://github.com/TauCetiProject/TauCetiRoadmap/blob/4cfd9b703dfedaf8596b66e9737b743fc29ac532/TauCetiRoadmap/MotivesAndAlgebraicCycles/README.md): Scope, native tensor/duality contracts and neutral reconstruction §6.1; rigid symmetric tensor categories with an exact faithful symmetric fiber functor. | Symmetric Tannaka reconstruction does not supply the nonbraided quantum-affine category or its specialized R-matrices. The general native tensor/duality carriers remain the right input. |
| [#1235](https://github.com/TauCetiProject/TauCetiRoadmap/pull/1235), `392d28ee5b14629578575d590e1171cfdda86b9f` | [GeometricSatakeAndFusion](https://github.com/TauCetiProject/TauCetiRoadmap/blob/392d28ee5b14629578575d590e1171cfdda86b9f/TauCetiRoadmap/GeometricSatakeAndFusion/README.md): scope and the extremal-weight/Tannakian matches. | Classical reductive-group Satake representations and extremal character terms do not supply quantum extremal weight modules or their global bases. |
| [#1547](https://github.com/TauCetiProject/TauCetiRoadmap/pull/1547), `e22a59e1b5cc1906afe933fe8a6c212cc518b492` | [CountingBundlesAndHallAlgebrasOfCurves](https://github.com/TauCetiProject/TauCetiRoadmap/blob/e22a59e1b5cc1906afe933fe8a6c212cc518b492/TauCetiRoadmap/CountingBundlesAndHallAlgebrasOfCurves/README.md): Scope and exact suppliers; finite-field curve Hall convolution, shuffle residues, Higgs counting. | These are curve-counting constructions, not a supplier for the generic affine finite-dimensional representation category used here. |
| [#1427](https://github.com/TauCetiProject/TauCetiRoadmap/pull/1427), `4b68a8d6bdf00a5821bed7e44c3923c412c2e712` | [HabiroNahmSeries](https://github.com/TauCetiProject/TauCetiRoadmap/blob/4b68a8d6bdf00a5821bed7e44c3923c412c2e712/TauCetiRoadmap/HabiroNahmSeries/README.md): QuantumEnvelopingAlgebras supplier contract and §7.1. | It consumes the general supplier's Gaussian-binomial interface and makes no competing claim to its quantum representation theory. |
| [#1737](https://github.com/TauCetiProject/TauCetiRoadmap/pull/1737), `dd6884908239a2f60a348756a7ab37e29138c725` | [ExoticMonoidalStructuresAndAbstractAutomorphicity](https://github.com/TauCetiProject/TauCetiRoadmap/blob/dd6884908239a2f60a348756a7ab37e29138c725/TauCetiRoadmap/ExoticMonoidalStructuresAndAbstractAutomorphicity/README.md): Scope and general smooth/symmetric-category contracts. | Its GL₂ local-field triality product and smooth representation category are distinct; its generic native categorical carriers do not remove affine-specific tensor-product obligations. |

NoncompactQuantumSymmetry (#1015), QuantumFoundations (#1771) and
RelativisticQuantumFieldTheory (#1772) were also screened by their stated scope. They concern
unitary spacetime representations, operational quantum theory and field theory, respectively,
rather than generic quantum enveloping algebras. ToposTheoreticBridges' reference to
ClusterAlgebras concerns Ore localization and is not a monoidal-categorification construction.

## Consequences for the revised ownership boundary

The subject should be **Quantum Affine Algebras**, with a pipeline from a supplied generic
quantum enveloping algebra to the finite-dimensional affine category and the KKOP definition.

1. Consume the general root datum, quantum algebra, Hopf operations, triangular decomposition,
   braid operators, weight modules and general crystal/global-basis support from their existing
   general owners. A finite-type source contract must not silently be promoted to all affine
   types.
2. When the pinned general owner lacks the precise theorem needed, give a named extension
   contract with full hypotheses and theorem outputs. Mark it as an extension requirement;
   do not claim that an unrelated open PR already supplies it.
3. Keep affine specialization, level-zero structure, spectral families, fundamental modules,
   current-presentation comparisons, rational and specialized R-matrices, affine simple
   classification and real-simple tensor theory within the affine roadmap.
4. Prove the finite-length K₀ and invariant-lattice specialization variants actually needed
   by the affine ring theorem, with their full hypotheses stated. Existing native results
   and the analogous modular finite-group PR do not already cover these variants. Explicit
   local support, as in revised §§6.1–6.2, or a precise future general supplier are both
   consistent with this inventory; the modular PR does not supply a dependency shortcut.
5. Keep current-open inventory facts in preparation/review evidence. The mathematical roadmap
   itself should use timeless supplier names and section contracts, without PR numbers or
   transient branch-status prose.

The final gate should receive the refreshed **497 open-head README tuples** together with the
new main's supplier inventory. A previous gate run without these tuples is not evidence for the
open-PR cycle check. The final supplementary review should identify the new roadmap commit
and exact README hash after the ownership corrections.

