# Quantum Affine Algebras: boundary with general quantum representation theory

**Status of this note.** This is the preparatory boundary recommendation, kept
as design history. The subsequent `foundations-supplier-review.md` records
the accepted exact contracts and their validation. In particular, the final
completion contract constructs the normalized source quasi-R element from
the nilpotent pairing, compares it with the raw canonical tensor, and the
affine action uses the inverse swapped source orientation at z=0; the initial
wording below about a Borel canonical element was refined accordingly.

## Review basis

This review responds to the requested subject correction: Quantum Affine
Algebras is a consumer of general quantum enveloping and quantum representation
theory. It is not a second installment charged with constructing that general
theory.

The original quantum-affine README reviewed here is commit
`9f9a91680f97a98778950d2e202d1444d0b9d967`. Supplier statements were read from
main at `c6ef576569501d342dec5a31a9938c9549dc6a00`, including their conventions,
scope boundaries and exact sections, rather than inferred from roadmap names.
The separate open-PR inventory records current PR/head coverage. Its complete
453-PR metadata and changed-file scan found no proposed change to
QuantumEnvelopingAlgebras, KacMoody, QuantumGroups or a quantum crystal/global
basis roadmap. This report does not turn a missing proposal into a supplied
theorem.

## Finding

Changing only the title would not resolve the boundary. The original §2.1
owns all-integrable rank-one string theory; §4.1 constructs the universal
extremal module at every weight; most of §4.2 constructs generic crystal/global
bases, modified sectors and the star action. Those are general foundations,
even when the immediate application fixes an affine Cartan datum.

The corrected roadmap should consume explicit general contracts and own the
affine specializations and theorems listed below. The contracts are meaningful
required interfaces; statements not present in an inspected supplier must be
labelled planned supplier requirements, with their completion status visible
in the review evidence. A bibliography entry is not an already-supplied
roadmap target.

## What the inspected suppliers actually supply

| Supplier | Exact target | Available contractual content | Limit |
|---|---|---|---|
| QuantumEnvelopingAlgebras | §§0.1, 1.0–1.3a | Full root datum; intrinsic generic algebra from the half-algebra radical; Hopf structure, full torus, triangular decomposition and Serre comparison | All finite-rank symmetrizable data; its native rank-one comparison is over complex nonroot parameters |
| QuantumEnvelopingAlgebras | §§1.4–1.5 | Homogeneous nondegenerate nilpotent pairing, Borel pairing and torus-amalgamated double | Does not yet state the completed universal quasi-R element and its full identities |
| QuantumEnvelopingAlgebras | §§2.1, 2.3 | Braid automorphisms; category O, Verma modules, Casimir, integrable highest-weight character formula | Does not supply all-integrable crystal/global basis or universal extremal-module existence |
| QuantumEnvelopingAlgebras | §5.3 | Modified-algebra construction and its integral form in the finite-type Frobenius layer | Cannot silently supply the all-symmetrizable modified-sector/global-basis theory |
| KacMoody | §§0.1–0.3, 2.1 | Full realization, root/weight/coweight lattices and Weyl group | Its crystals are classical path crystals; they are not quantum crystal lattices |
| KacMoody | Scope and ownership | Explicitly assigns generic type-1 modules, quantum O_int, Kashiwara operators, crystal bases and path comparison to a future “KacMoody, Part II” | This is a future ownership statement, not a numbered completed target in a current separate roadmap |
| QuantumGroups | §8.5 | General finite Hopf-module category with tensor and duals, on native carriers | §§8.1–8.4 rank-one representation theorems use the complex-parameter UqSl2 carrier |
| GrothendieckEulerForms | §§1.1–1.4, 2.3 | Exact/abelian K0 and biadditive descent | §4.1's existing simple-class theorem needs an Artinian algebra and cannot be applied to U′ |
| ClusterAlgebras | §§1.1–1.4, 1.6, 2.3 | Ordinary seeds, finite words, ring realization and locally finite patterns | Frozen inverse set must be empty; its existing cluster definitions should simply be consumed |

The explicit future assignment in KacMoody and QuantumEnvelopingAlgebras is
strong evidence against locally taking over the generic crystal construction.
It does not establish that every additional global-basis, extremal-module or
completed-intertwiner requirement below is already included in that future
assignment.

## Required general interfaces

### Worker declaration mechanism

The inspected worker explicitly permits this boundary through declared
supplier gaps (`prompts/sections/gaps-and-order.md`). Each `gap:<slug>` must
have matching README text in the supplier subsection and a `design/plan.json`
entry with `supplier`, `section` and one precise `needs` sentence. A named
planned supplier is permitted: use `KacMoodyPartII`, whose planned ownership
is explicitly named on main, with a **proposed named target**, never an
invented existing section number. Acceptance may have `conditional_gaps`.
The gap's absence from its supplier is not itself a finding; vague, compound,
unowned, redundant or falsely supplied requirements are findings.

No message to the board, upstream issue or PR is authorized in this
preparation task. The evidence must distinguish this local declaration from
an intake announcement that has not happened.

Six atomic consumer contracts are:

| Slug | Supplier | Proposed target | One-sentence needs |
|---|---|---|---|
| `integrable-string-decomposition` | KacMoodyPartII | Proposed: rank-one strings for integrable weight modules | For every type-1 integrable rank-one module over Q(q) or a field extension, with parameter q_i=q^{d_i}, provide the unique finite decomposition v=Σ_{r≥max(0,−n)}f_i^(r)v_r of each K_i-weight-n vector, where e_i v_r=0 and K_i v_r=q_i^{n+2r}v_r, in the specified generator normalization. |
| `universal-extremal-module` | KacMoodyPartII | Proposed: universal extremal modules | For every finite-rank symmetrizable full root datum and λ∈P over Q(q), provide the universal integrable module E(λ) representing normalized extremal vectors, with its canonical extremal family. |
| `extremal-global-basis-model` | KacMoodyPartII | Proposed: the extremal global-basis model | For each such E(λ), provide its balanced rational lower global-basis model as the star-extremal quotient of the all-symmetrizable modified algebra, with the ordinary/star crystal actions, normalized Weyl transport and the rank-one divided-power filtrations. |
| `crystal-schubert-strata` | KacMoodyPartII | Proposed: Schubert decomposition of the half crystal | For the negative-half crystal B(∞) of every finite-rank symmetrizable datum, provide the reduced-word-independent Schubert subsets B_w(∞), their disjoint Bruhat-cell partition and the star and maximum-raising identities of K02 (2.7)–(2.9). |
| `crystal-tensor-rule` | KacMoodyPartII | Proposed: tensor products of crystal lattices | For type-1 integrable modules over Q(q) with crystal bases and full-P or quotient-Pcl weight gradings, provide the crystal-lattice tensor-product theorem and its signature rule for the stated coproduct, compatible with the stated generator normalization. |
| `completed-canonical-element` | QuantumEnvelopingAlgebras | Proposed extension of §§1.4–1.5: completed canonical element | For the homogeneous Borel pairing on every finite-rank symmetrizable datum, provide its canonical element in the root-graded completion with the completed intertwining and coproduct identities in the stated generator normalization. |

The first contract is deliberately rank-one and does **not** require that
an affine evaluation module lift to the full-U degree action. Similarly the
tensor contract includes the quotient weight grading of finite fundamental
U′-modules, not just full-P modules.

**Why the Schubert gap is separate.** K02 §5's finite-multiplicity argument directly
uses §2.3's reduced-word-independent B_w(∞), their Schubert-cell partition,
star inversion and maximum-raising laws (2.7–2.9), through Proposition 3.4.
Those cannot be silently inferred from only the existence of a global basis.
The separate `crystal-schubert-strata` contract keeps this requirement atomic
and does not overload the extremal basis existence statement. The affine
bounded-length covering itself stays here.

The half, highest/lowest and modified global-basis existence proofs are
supplier proof internals of the extremal model. They need not be separate
gap requests merely because the supplier's proof uses them.

### G1. Integrable weight modules and rank-one strings

For the full-root-datum algebra on any finite-rank symmetrizable datum over
F0 = Q(q), and compatibly over extension fields with the chosen generic
parameter, consume the type-1 weight module and integrability interfaces.
Integrability includes local nilpotence of both ladders. Consume local
finite-dimensionality and semisimplicity of each rank-one restriction and the
unique finite decomposition of a weight-λ vector

`u = Σ_r f_i^(r) u_r`,

where `r ≥ max(0, −⟨h_i,λ⟩)` and
`u_r ∈ ker(e_i) ∩ M_(λ+rα_i)`.

Consume the corresponding divided-power identities, Weyl transport and weight
multiplicity invariance. Do not import a theorem formulated only on the
complex native UqSl2 carrier into Q(q) without a field-general comparison.
The lower bound on r is essential: otherwise the trivial summand in
L(2) ⊕ 1 permits an invisible zero-string term.

Affine §2.1 should apply this rank-one contract directly to its Pcl weight
decomposition and also to full-P modules used later; it must not require
every finite evaluation module to lift to the full degree action. Its new
statements remain the precise finite
type-1 category, finite-weight-support nilpotence, and the comparison with
the source category C.

### G2. Rational crystal/global bases and modified sectors

Consume the rational coefficient framework with F0 = Q(q), A0 regular at
q = 0, A∞ = bar(A0), A = Q[q,q^-1] and bar(q) = q^-1. Consume the negative
and positive half crystal/global bases, highest/lowest-weight global bases,
and the all-symmetrizable modified algebra with sector bases
`B(∞) ⊗ T_λ ⊗ B(−∞)`. The required basis is a balanced-triple basis: the
reduction map from the triple intersection is an isomorphism, with global
vectors the inverse images of crystal vectors. Spanning of three lattices
alone does not suffice.

The contract includes the generic tensor rule on crystal lattices, the star
anti-involution, ordinary and star crystal actions, their compatibility and
the relevant Weyl/crystal comparisons. It includes the indicated scalar
extensions of the rational forms; it does not assert a C-linear bar on the
algebraic closure of C(q).

Source content to assign to this general supplier is K91 Theorems 2, 4, 6,
7 (journal pp.466–467) and K94 Proposition 2.1.1, Theorem 2.1.2, Theorems
3.1.1 and 4.3.2 and §5. QEA §5.3's finite-type sector construction is the
object to extend and compare, not a reason to duplicate a second sector
carrier inside QuantumAffineAlgebras.

There is a concrete normalization boundary. QEA §1.2 exposes
`e_hat_i = K_i^-1 E_i`, `f_hat_i = F_i K_i` for its planned crystal supplier,
whereas the original affine README uses
`e_i = E_i K_i^-1`, `f_i = K_i F_i`. Thus
`e_i = q_i^2 e_hat_i` and `f_i = q_i^-2 f_hat_i`.
Both give the displayed source coproduct, but their integral/crystal
normalizations cannot be identified without transport. Either align the
adapter everywhere or require the normalized generator and lattice transport
explicitly. The affine source parameter conversion must also preserve the
regular-at-zero rational lattice, with its positive ramification specified.

### G3. General extremal modules and their basis

Consume for every integral weight λ the actual universal integrable module
E(λ), obtained from extremal relations, and its normalized extremal family.
The universal property represents extremal vectors, including zero; when
`⟨h_i,wλ⟩ = 0`, both annihilation equations apply. Consume Weyl transport,
linearity and uniqueness of the normalized family, and functoriality on
intertwiners.

Consume the crystal/global-basis description through the star-extremal
quotient of the modified sector: the span of excluded global vectors is a
left submodule and the quotient has that universal property. This is K94
Lemma 8.2.1 and Proposition 8.2.2, and the general extremal presentation is
K02 §3.1. Neither the basic-level-zero theorem nor finite dimensionality of
a fundamental period quotient belongs to this general contract.

The affine target may specialize E(λ) to π_i, compare the full and derived
actions, compare δ-lifts, and prove that changes of a lift and normalized
Weyl choices interact with the spectral periodicity. It should not build
E(λ) and its global basis again for all weights.

### G4. The completed canonical intertwiner

Consume the root-graded completion of the paired halves, its canonical
element, independence of homogeneous dual bases, and the generic completed
intertwining/coproduct identities, in the specified generator convention.
The homogeneous pairing is already QEA §§1.4–1.5's; the completion theorem
is a required extension, rather than an existing theorem falsely attributed
to those sections.

Keep the affine spectral action in §5.1: the toral factor descending to
level-zero classical weights, a compatible root of q for rational weight
pairings, coefficientwise finiteness on M ⊗ N(z), a well-defined k((z))
intertwiner and its comparison with the rational normalization. This is
where affine root geometry and the finite classical weight support enter.
Do not claim that the infinite canonical sum lies in U′ ⊗ U′ or yields a
braiding at every specialization.

## Affine content to retain

| Target in the original file | Correct affine-owned content |
|---|---|
| §§1.1–1.2 | Standard affine node, marks/comarks, null directions, classical quotient and basic weights; derived subalgebra, its central group-like element and level-zero quotient |
| §§2.1–2.3 | Actual finite-dimensional type-1 category, level-zero theorem, finite length, inherited abelian/biexact/rigid structures and their normalizations |
| §§3.1–3.2 | Spectral Hopf automorphisms, intrinsic affinization, scalar extension and specialization |
| §4.1 | Specialize the general extremal module and transport its full/derived actions and δ-lifts |
| §4.2 | Basic-level-zero simplicity, orbit multiplicity one, weight bounds, stabilizer normalization and finite weight spaces; the affine Schubert-covering argument and descent to the chosen field |
| §4.3 | Canonical period automorphism z_i, finite-dimensional fundamental quotient, simple finite regular crystal, good-module properties and spectral equivalence relation |
| §4.4 | Current realization comparison at level zero, highest-ℓ-weight classification in untwisted and folded cases, and comparison with the actual fundamental quotient |
| §5.1 | Action of the supplied completed canonical element on affine spectral families and the level-zero toral factor |
| §§5.2–5.3 | Generic tensor simplicity, rational normalization, denominators, primitive renormalization and specialized maps |
| Layer 6 | Simple-class coordinates on the actual category, invariant-lattice commutativity proof and polynomial presentation by spectral fundamental classes |
| Layer 7 | Quantum affine real-simple tensor theory, the head/socle and pairwise theorems, and length-two exchange reality |
| Layer 8 | Serre tensor closures and fundamental spectral-component categories |
| Layer 9 | Categorical seeds/mutations and the exact ordinary KKOP categorification predicate |

The finite regular **simple crystal** statements used for fundamental affine
modules should stay here. General existence and tensor rules for quantum
crystals are reusable inputs, but the K02 simple-crystal criterion and its
finite-dimensional affine irreducibility consequences are not thereby
already supplied. Likewise the affine basic-weight finite-multiplicity proof
must not disappear merely because E(λ) is now imported.

## Additional reusable lemmas

The arbitrary-algebra fd-module simple-class theorem in §6.1, the local-lattice
lemma in §6.2 and the finite-Hopf-module tensor-intersection lemma are general
results used by the affine proof. They have no identified exact current
supplier at the inspected pins. Open PR #1775, ModularCharactersAndBlocks
§1.2, does have independence of a stable-lattice reduction class for finite
groups over a p-modular system, at head
`8379fbab` (see the inventory for the full pin). Its characteristic-zero
fraction field, positive-characteristic residue field, complete DVR and
finite group do not include k[z]_(z−1) and an arbitrary k-algebra A. Thus it
does not already supply §6.2, although the overlap must be recorded.
The generic results may remain explicitly reusable support
lemmas within this consumer roadmap, extending native APIs rather than
creating substitute carriers. If ownership is moved, the corresponding
supplier extension must be recorded with its exact hypotheses; the existing
Artinian-ring simple-class theorem and braided-K0 commutativity instance
cannot replace them.

There is no need to import complete reducibility of all quantum O_int as a
new standalone input merely because a general supplier develops it. The
affine category C is not semisimple, and its finite-dimensional level-zero
objects are not being identified with positive-level highest-weight objects
in O_int.

## Acceptance conditions for the revision

1. Title, summary, scope, reading order and Suggested.lean describe a
   Quantum Affine Algebras consumer roadmap. No “quantum enveloping part II”
   claim remains.
2. Every removed generic construction reappears as an explicit planned
   supplier contract with the exact field, weight, normalization and basis
   hypotheses needed downstream; it is not turned into an unnamed theorem.
3. The evidence distinguishes already-numbered supplier targets from
   required future general-theory additions. Current open-PR absence must
   not be described as evidence that the additions are already implemented
   or fully specified elsewhere.
4. Full twisted affine scope, especially the standard-node condition and
   A2^(2) period normalization, is preserved.
5. The source generator rescaling and rational/global-basis field boundary
   are checked. General crystal lattices are not transported through a
   convention change without an explicit contract.
6. The remaining sequence is noncircular: fundamentals/classification before
   rational R-matrices, those before K0 commutativity, then real-simple
   tensors and the monoidal-seed interface.
7. Dependency review records all declared slugs in `conditional_gaps` on
   acceptance and matches them between README and plan. Passing the
   mechanical gate is not evidence that an as-yet-unwritten supplier target
   is already provided by a merged roadmap. Under the worker's stated rule,
   these declared contracts may nevertheless receive an accepted review.

## Reviewer conclusion

The recommended change is a real ownership refactor, not a scope reduction.
It preserves all affine mathematics and makes its general prerequisites
visible. The original roadmap's explicit self-owned generic foundations must
be removed from its task ownership to honor the user's corrected direction.

