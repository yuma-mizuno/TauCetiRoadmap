# Foundations and supplier-boundary review

## Verdict

**Verdict: accepted.**

Remaining findings: **0**. Blocking findings: **0**.

Acceptance is conditional on the following declared supplier gaps, as permitted
by the worker's `prompts/sections/gaps-and-order.md`:

- `integrable-string-decomposition`
- `universal-extremal-module`
- `extremal-global-basis-model`
- `crystal-schubert-strata`
- `crystal-tensor-rule`
- `completed-canonical-element`

The absence of those proposed supplier targets is not represented as a proved
or merged implementation. The main worker/dependency review checks the matching
plan declarations; this review checks their mathematical adequacy, scope and
use in the affine construction.

## Reviewed snapshot and coverage

- File: `TauCetiRoadmap/QuantumAffineAlgebras/README.md`.
- Exact SHA-256:
  `631c9c628b1d25a07322f959a8d7f7b79d804525a106c4877b24502fcb6581d4`.
- Delta baseline: `23ca49278737c113ab7540d9015adc2de07a176f`.
- Inspected main supplier snapshot:
  `c6ef576569501d342dec5a31a9938c9549dc6a00`.
- Review scope: the complete ownership and supplier-contract delta; all
  convention-sensitive changes in Layers 2, 4 and 5; the unchanged affine
  lattice/derived-algebra foundations; and the downstream dependency uses
  through the monoidal-categorification endpoint.

The subject is now Quantum Affine Algebras. General quantum enveloping algebra,
integrable strings, generic extremal modules, generic crystal/global bases and
the completed quasi-R element are consumed. The new affine targets remain
explicit, including all twisted types. No primary roadmap file was edited by
this reviewer.

## Findings raised during the revision and their resolution

| Item | Issue identified | Verified repair |
|---|---|---|
| Completion carrier | A canonical element for the whole Borel pairing would incorrectly treat its infinite, possibly degenerate torus as a finite degreewise dual pair. | The gap now starts from the degreewise nondegenerate nilpotent pairing, uses the completed source halves, and excludes the degree-zero torus from those finite dual pairs. |
| Quasi-R normalization | The raw inverse-pairing tensor has a positive rank-one coefficient, whereas the source quasi-R element satisfying its specified intertwining equation has a negative coefficient. | The gap constructs the normalized element Ξ, states `Ξ Δ(x)=barΔ(x) Ξ`, and requires the actual normalization and generator comparison with the raw canonical tensors. |
| Spectral orientation | K02's positive-half-first source action expands in the inverse spectral ratio; using it unchanged would not justify the claimed expansion at z=0. | Section 5.1 uses the inverse of the swapped K02 intertwiner, gives the negative-half-on-M/positive-half-on-N(z) orientation, and checks the z=0 matrix. |
| Crystal tensor source | K91 §4 and K02 §2.1 were too imprecise as direct tensor-rule locators. | The text now cites K91 §2.4, Theorem 1 and (2.4.3), pp.475–476, with its coproduct (1.4.3), p.472; the string locator is K91 §2.2, (2.2.1)–(2.2.4), p.473. |
| Ambient star structure | The wording could be read as two internal crystal actions on every fixed extremal module. | The regular ordinary/star structures are explicitly on the ambient modified crystal; star-Weyl maps compare the λ and wλ models. |
| Weyl comparison maps | “Weyl maps” might denote non-module-linear Weyl operators acting inside one module. | Section 4.1 explicitly uses U-linear universal maps E(wλ)→E(λ), sending the cyclic vector to u_w, proves they are isomorphisms, and restricts those maps to U′. |
| Quotient grading | A tensor theorem limited to full-P modules would not apply to a finite evaluation module lacking a degree action. | The gap is formulated for P or a quotient Pbar on which every simple-coroot pairing descends, and the affine use is explicitly Pbar=Pcl. |

All these issues are resolved in the exact snapshot above. The raw-pairing and
spectral-orientation issues were also investigated jointly with the parent
reviewer; the matrix and source checks below independently confirm the fixes.

## Supplier adequacy and noncircularity

| Input | Exact affine use | Boundary checked |
|---|---|---|
| QEA §§0.1, 1.0–1.3a, 2.1 | Full datum, intrinsic algebra, Hopf structure, Serre comparison, full torus and braid operators | No second enveloping-algebra carrier is introduced. |
| `integrable-string-decomposition` | Pcl weight refinement and Weyl invariance in §2.1; rational extremal support | Rank-one restrictions may be infinite-dimensional and are over Q(q) or an extension; no complex-only carrier is substituted. |
| `universal-extremal-module` | Derived restriction, normalized inter-module Weyl maps and δ-lift transport in §4.1 | The generic construction is imported; the affine character/lift comparison is new. |
| `extremal-global-basis-model` | Basic-level-zero structure, rational normalization and fundamental quotient | Generic half/highest/modified basis existence is supplier proof support, not hidden local ownership. |
| `crystal-schubert-strata` | Basic-weight bounded-length covering and finite weight multiplicities | General Schubert decomposition is supplied; the affine bounded-length result remains a target. |
| `crystal-tensor-rule` | Tensor crystal bases of finite fundamental quotient modules in §4.3 | The general tensor rule is distinct from the affine simple-crystal and irreducibility theorems retained here. |
| `completed-canonical-element` | The affine spectral action in §5.1 | Completion identities are supplied; convergence, toral factor, spectral orientation and scalar extension are constructed here. |
| Native finite-module, exact-K0 and multiplicity APIs | Layers 2 and 6 | Neither an Artinian-algebra hypothesis nor a braided-category commutativity hypothesis is imported. |
| ClusterAlgebras §§1.1–1.4, 1.6, 2.3 | Layer 9 | Ordinary cluster carriers are consumed; frozen variables remain noninvertible and finite words give the mutation scope. |

The sequence remains acyclic: affine lattice and algebra; actual finite
representation category; spectral families; fundamental modules and simple
spectral classification; rational R-matrices; K0 commutativity; real-simple
tensor theory; component categories and monoidal seeds. The new general
contracts ask for no categorification or quantum-affine classification result
that would depend on this consumer. The quotient-grading tensor rule is a
local rank-one action statement, not a request that the general supplier
import this roadmap's future category C.

## Adversarial mathematical checks

### Rank-one strings and normalization

At weight n, the lower bound `r≥max(0,−n)` remains present. In L(2)⊕1,
the lowest vector has n=−2 and r=2; allowing r=1 would add the invisible
term f(1)=0 from the unit. Thus the corrected supplier contract retains the
uniqueness condition needed by Kashiwara operators.

For an extremal pairing n=0, both e and f annihilate the vector and the
reflected vector equals it. For n=2, the normalized reflected vector is
`f^(2)u=f^2u/[2]`, with `[2]=q+q^-1`. The text preserves both checks.
For a highest-weight-2 vector, applying e to f u gives `[2]u`, while
applying e to `f^(2)u` gives f u. These are the source divided-power
identities, not ordinary-integer formulas.

### Full weights, quotient weights and the δ-lift adapter

For χ_t, all simple-coroot pairings of tδ vanish, hence every K_i acts as 1
and e_i=f_i=0. The full torus acts by the character corresponding to tδ.
With the stated coproduct, the action on χ_t⊗E(λ) has the same e_i,f_i,K_i
operators as E(λ), and its full weights are shifted by tδ. Its cyclic vector
is extremal of weight λ+tδ. The universal properties give the normalized
isomorphism to E(λ+tδ); using χ_−t gives the inverse. Their compositions are
fixed by the cyclic vectors, so the additive composition law is valid without
assuming simplicity.

Consequently χ_1 and the unit agree as derived modules and differ as full-U
weight modules. This directly tests that the new adapter forgets the degree
action without identifying different full weights. Neither §2.1 nor the
crystal tensor contract requires a finite evaluation module to acquire a
full-U degree action.

### Generator conventions, bar and base extension

The relation `K_i E_i K_i^-1=q_i^2 E_i` gives
`E_i K_i^-1=q_i^2 K_i^-1 E_i`; likewise
`K_i F_i=q_i^-2 F_i K_i`. The contract states exactly these two rescalings
between its source generators and the QEA normalized generators.

The revision transports the module action together with its bar and lattices,
and allows the resulting fundamental spectral relabeling. This avoids the
false assertion that changing the normalization fixes each quotient module
at the same spectral parameter. The bar is conjugated through the algebra
comparison. All balanced-basis work remains over Q(q), and the subsequent
extension to k does not postulate a C-linear bar on k.

Positive ramification of the rational parameter preserves the balanced-basis
property coefficientwise in the supplied global basis: the extended lattices
are the A0, A∞ and A spans of that basis, and their intersection has the
constant coefficient field. The retained counterexample `(q−1)A u` tests
that merely spanning the vector space and being bar-stable do not imply this
property. The unit example is used as a basis check, not as a basic weight
with a positive spectral period.

The absolute-simplicity argument using native Jacobson density remains
applicable even when the rational extremal module is infinite-dimensional:
an extended vector involves finitely many F0-linearly independent vectors,
and density isolates any chosen one. The one-dimensional cyclic extremal
weight space identifies the endomorphism algebra with F0. This supplies the
field-extension comparison without a bar or valuation on arbitrary k-modules.

### Regular crystals and all affine types

The regular crystal condition is explicitly retained. The ordinary and star
structures are on the ambient modified crystal, and star-Weyl transport
changes the extremal sector as in K02 §§2.2 and 3.1. No internal star-action
closure of a fixed E(λ) is asserted.

K02 §2.3's Schubert subsets and strata are a separate declared supplier
contract. The basic-level-zero finite-multiplicity proof remains an affine
target and is not erased by importing the generic basis. The finite regular
simple crystal of the fundamental period quotient, tensor simplicity of
such affine crystals and the corresponding module irreducibility are also
retained in §4.3.

The main standing hypotheses still cover every indecomposable symmetrizable
affine type. In particular, the A2^(2) long-node convention, π_1=2Λ_1−Λ_0,
period m_1=1 and central-element distinction remain intact. The D4^(3)
counterexample to an arbitrary mark-one node remains intact. No declaration
limits the general contracts to simply-laced or untwisted types, and no
crystal existence statement is imported from a classical path model.

### Quasi-R and spectral completion

For the source coproduct, write `Ξ=Σ_n a_n e^n⊗f^n` in rank one.
The equation `ΞΔ(e)=barΔ(e)Ξ` with a0=1 forces

`a_(n+1)=−q^-n(q−q^-1)a_n/[n+1]`.

Thus a1 is `−(q−q^-1)` and a2 is
`q^-1(q−q^-1)^2/[2]`. The raw inverse-pairing tensor from QEA §1.4 instead
has coefficients `+(q−q^-1)` and `q(q−q^-1)^2/[2]`. The revised gap
correctly requires the normalization comparison rather than identifying
these two elements.

An independent symbolic computation on L(2)⊗L(2), using 9-by-9 matrices,
verified the e, f and K quasi-intertwining equations for these Ξ coefficients.
The same computation verified that the raw positive inverse-pairing tensor
fails that quasi-intertwining equation. This is a check of the normalization
issue; it is not claimed as a proof for arbitrary Cartan type.

K02's operator applies the positive half to the first factor and the negative
half to the second. On M⊗N(z) this gives the inverse spectral completion.
The revised §5.1 uses the inverse swapped operator; its positive half acts
on N(z), producing the KKOP expansion at z=0. For the rank-one fundamental
example the normalized finite-root term is

`((1−q^-2,q^-1),(q^-1,0))`,

which is exactly the value at zero of the worked rational matrix. The source
K02 orientation instead gives the value at infinity,

`((0,q),(q,1−q^2))`.

These checks fix the normalization, the sign of the toral factor through the
inverse comparison and the direction of completion. The proof obligation
for coefficientwise finite action remains explicit; an infinite sum is not
asserted to lie in the uncompleted tensor algebra.

## Source inspection

The K02 source was read directly in its cached revised text at §§2.2–2.4,
3.1, 4.1–4.2, 5 and 7–8. In particular, (7.3)–(7.6) distinguish the source
quasi-R operator and its toral/flip action, while §8 identifies the spectral
completion in the ratio of the two affine variables.

K91's scanned journal pages 472, 473, 475 and 476 were rendered from the
already-local author PDF. A standalone local Tesseract process supplied
reading assistance; the tensor theorem and its formulas were also visually
inspected in the page images. The rejected network-capable OCR wrapper from
the previous work was not retried. The observed locators are:

- §1.4, (1.4.3), p.472: the source coproduct;
- §2.2, (2.2.1)–(2.2.4), p.473: strings and Kashiwara operators;
- §2.4, Theorem 1, p.475: the lower crystal tensor theorem;
- (2.4.3)–(2.4.4), p.476: the tensor signature and rank-one formulas.

K91 Theorems 2, 4, 6 and 7 and the cited K94 results are correctly described
as the proof sources for the proposed general supplier model. The revised
references no longer assign their construction back to the affine roadmap.

## Limits of this verdict

This is a mathematical and ownership review of the roadmap specification,
conditional on the six explicitly declared contracts. It does not claim that
those contracts have been implemented or accepted by their future owners.
The unchanged documentation-only Suggested.lean still cannot formalize the
quantum-affine headline theorems on absent carriers. The separate worker gate,
full PR inventory, plan validation and final publication verification remain
the parent review's checks.

