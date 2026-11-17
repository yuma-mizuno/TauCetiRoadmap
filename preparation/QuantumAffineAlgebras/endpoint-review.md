# Endpoint and R-matrix review

## Snapshot and scope

- Reviewed README SHA256: `e1ac2ed03f4b8b0983fb38d3b95a6bc74eb1561eb107b066ff80db49a9c581f3`.
- Snapshot: `/workspace/scratch/889845af25ea/endpoint-review-readme-e1ac2ed03f4b.md` (1,465 lines).
- Read every line of Layers 5–9 and the complete A₁⁽¹⁾ worked example, plus the conventions, supplier contracts, downstream section and references. Also read the Layer 1 weight interface needed for the universal intertwiner.
- Coverage: 17 numbered target subsections and 56 authored check bullets in Layers 5–9. All 56 were reviewed mathematically; this does not mean each was formalized or numerically tested.
- Independent computation: 39 symbolic zero identities, a symbolic determinant, invariant-vector/function conditions, restricted three-dimensional actions, and fixed numerical boundary values. Script and output are adjacent to this report.
- Targeted Lean build: passed, exit 0. See `build-log.txt` and `build-summary.md`.

**Disposition for this snapshot: changes requested.** Four repairable findings follow. No unconditional acceptance is given: the parent is still incorporating foundations-review changes, and final acceptance must identify and review the resulting README hash.

## Findings

### E1 — Own the weight–weight form used by the universal intertwiner

**Location:** §5.1, first paragraph. **Severity:** medium; missing supporting construction.

The text invokes rational weight pairings, their denominators, and the toral weight factor. Layer 1 exports a weight/coroot pairing. The cited QuantumEnvelopingAlgebras §1.5 constructs a symmetric form on the coweight torus Y, which is a different object. A weight–weight form on level-zero classical weights is not yet an explicit supplied or owned construction.

**Repair:** construct the symmetric rational form on `Pcl⁰⊗ℚ` characterized by

    (cl(α_i), λ) = d_i ⟨h_i,λ⟩,  i∈I₀.

The finite-type Cartan matrix makes this construction explicit and unique. Verify the same equation for i=0 using `δ=0`, `a₀=1`, `a_i d_i=r c_i`, and the level-zero equation. Prove Weyl invariance and clear denominators on the lattice to obtain a bicharacter after choosing a root of q. This is the form the toral factor needs; no form on the full affine weight space has to be silently imported. For simple pairs, a change of q-root only changes the corresponding universal scalar coefficient, so normalized R is unchanged.

### E2 — State the closure lemmas needed for nonsimple R-matrix arguments

**Location:** §5.3 / supporting argument of §7.2. **Severity:** medium; hidden proof input unless explicitly owned.

Simple-pair rationality alone does not state the needed renormalized intertwiners on the nonsimple products occurring in the real-simple head/socle proof. The draft mentions factorization through images, but does not explicitly provide the rational-renormalizability closure and nonzero-composition hypotheses.

**Repair:** own the following supporting lemmas for the pairs actually used: rational renormalizability is preserved by tensoring known pairs and by taking nonzero subquotients; primitive renormalizations are obtained by removing common Laurent factors; when the middle factor is simple, the tensor-intersection lemma makes the indicated specialized composition nonzero. The relevant source is KKOP20 Proposition 2.11(ii)–(iii) and Proposition 2.12, with Proposition 2.11(i) / KKKO15 Lemma 3.10 and Corollary 3.11 for nonvanishing. These are elementary R and tensor statements, not numerical Λ invariants. Do not strengthen them to an assertion about all arbitrary pairs.

### E3 — Separate the toral construction from scalar normalization

**Location:** §5.1, second check. **Severity:** low; mathematical wording.

The statement that the universal matrix differs from the normalized matrix “by a scalar series and a toral factor” suggests an additional toral multiplier between two intertwiners. For simple pairs the exact relation is

    R_univ = a_(M,N)(z) R_norm.

The toral factor is already incorporated in the construction of R_univ and hence in R_norm. Replace the check by this scalar-series relation; discuss the toral factor only in the construction paragraph. Source: KKOP20 §2.2, the definition immediately preceding equation (2.8), and equations (2.8)–(2.9).

### E4 — Correct equation ranges for the R-matrix references

**Location:** source locators in §§5.1 and 5.3. **Severity:** low; source precision.

In KKOP20, equation (2.5) is the universal formula, (2.6) its spectral action, and (2.7) a tensor identity. Equations (2.8)–(2.9) are denominator/renormalization formulas on p.11, not further universal tensor identities on pp.9–10. Therefore §5.1 should cite (2.5)–(2.7), pp.9–10, and retain proof ownership of the remaining tensor/Yang–Baxter identities. For §5.3, (2.8)–(2.13), pp.10–11, is the relevant denominator, primitive-map and composition range; Proposition 2.7 supplies additional dual/shift comparisons where needed.

## Main mathematical checks with no defect found

### Completed and rational R-matrices

After adding E1, the completion strategy is sound. Fixing the coefficient of α₀ and the classical weight shift determines the full root degree, because the kernel of the classical quotient is ℤδ and a₀=1. Finite classical weight support therefore leaves only finitely many root degrees at each spectral degree; every such homogeneous algebra piece is finite-dimensional. The choice of the positive half acting on the second, shifted module gives nonnegative spectral degree. This explains the required formal convergence without an infinite element of U′⊗U′.

The rational-normalization argument uses a finite system of intertwining equations because U′ has finitely many generators and the modules are finite-dimensional. Consistency descends from a scalar extension, and normalization uniqueness identifies the descended solution with the normalized universal map. The stronger absolute-generic-simplicity target is mathematically valid: a simple specialization over algebraically closed k supplies finitely many matrix words spanning the full endomorphism algebra, and their nonzero determinant persists generically. This provides a concrete proof route if the formal development needs one.

Minimal-denominator specialization is correct. If all cleared entries vanished at z=1, then dividing out z−1 would contradict minimality whenever the denominator has that factor; when it does not, the normalized top coefficient is already nonzero. The monic shift factor `(a/b)^n` is correct. Pole removal, primitive renormalization and generic invertibility are kept distinct.

### Exact Grothendieck rings

The invariant-lattice specialization proof in §6.2 is correct for an arbitrary unital k-algebra; no finite-dimensional or Artinian hypothesis on the algebra is needed. The temporary torsion quotient is a finite-dimensional A-module, so its kernel/cokernel class relation is legitimate. Injectivity of the simple-class map brings the resulting equality back into the integrable category.

The polynomial presentation in §6.4 is sound in twisted as well as untwisted types after indexing by actual fundamental isomorphism classes. The distinguished highest constituent supplies diagonal coefficient one, all remaining constituents have smaller dominant classical weight, and finite lower dominant intervals give the induction. Injectivity also follows directly from a maximal weight in the finite support of a proposed relation. This establishes the domain required in §§7.4 and 9.3 without q-character machinery.

### Real simples and mutation

The scalar-self-R converse is explicitly owned in §7.2 and supplies the nontrivial input to the length-two argument. The generic field issue for Hernandez is addressed accurately by the exact formulation in KKOP20 §2.1. Repetitions in tensor monomials are covered by reality, not just commutation of distinct isomorphism classes.

The §7.4 proof route does not require Λ. If N were not real, N⊗N would have length two; the tensor-intersection lemma controls its simple submodules, and a nonscalar self-R minus an eigenvalue forces its socle and head to be isomorphic, contradicting the distinction between X⊗N and Y⊗N. That distinction follows from K₀ cancellation and the equal-head/socle theorem. This is the ungraded argument of KKKO arXiv:1801.05145, Proposition 3.2.20 and Corollary 3.2.21, explicitly cross-cited by KKOP22 Proposition 2.21.

The admissibility→mutation argument in §9.2 correctly derives replacement reality and the reverse exact sequence without asserting admissibility of the new seed in all directions. A zero column is correctly rejected by the equal-head/socle criterion. The empty seed and the noninverted frozen convention are handled correctly.

### Categories and endpoint

The Serre tensor closure is taken inside the actual integrable category, contains the unit, and does not impose dual closure. The finite-valency argument for spectral components uses both tensor orders and the quotient by twisted periods; the countability conclusion is valid. The KKOP one-way categorification predicate in §9.4 correctly quantifies over all finite mutation words and all finitely supported nonnegative monomials, and explicitly retains the ring-isomorphism and mutation-coverage assumptions for applications.

## Exact computational evidence

The symbolic script checks all Cartan and mixed commutator relations for the two-dimensional module, both affine Serre relations for e and f, level zero, all six generator intertwining equations for R, the inverse identity, the t=1 identity, invariance of Z under all six generators, its evaluation parameter aq, and both boundary composites. There are 39 asserted zero matrices, all successful.

The determinant is exactly

    det R(t) = (q² t−1)/(q²−t).

The invariant-vector and quotient-function calculations give exactly the displayed conditions:

    e₀u = (a/q−qb) --,
    f₀u = (1/(bq)−q/a) ++,
    ell e₀ = (b−aq²,0,0,0),
    ell f₀ = (0,0,0,1/a−q²/b).

Thus the unit submodule and unit quotient occur in the stated opposite tensor orders. The restriction to Z has e₀=aq f₁ and f₀=(aq)⁻¹ e₁, verifying the center aq used in its q-segment.

For the fixed numerical seed q=2, a=3, b=5, the nontrivial R block is

    [[9/7, -4/7], [-4/7, 15/7]],

with determinant 17/7. The two nonzero coefficients on u are −17/2 and −17/30.

At q=2, t=4, `(t−q²)R` has nonzero block `[[-3,6],[6,-12]]` and rank 1. At q=2, t=1/4, the regular R block is `[[4/5,2/5],[2/5,1/5]]`, with two additional diagonal entries 1, so its rank is 3. Both composites are zero. At t=1, R is the identity matrix.

For X=V(3),Y=V(12), the actual monic denominators in the second spectral variable z are `d_X,Y(z)=z−1` and `d_Y,X(z)=z−16`. Consequently r_X,Y has block `[[-3/4,3/2],[3/2,-3]]` and zero outer diagonal entries; r_Y,X has block `[[-12,-6],[-6,-3]]` and outer diagonal entries −15. Their images are respectively the unit and Z, with the claimed ranks. These numerical checks supplement the symbolic identities; they are not substitutes for the general simplicity theorems.

The q-segment containment test and spectral multiplicity counts in the worked example are consistent: X,Z and Y,Z are in general position, X,Y are not; the monomials XʳZˢ have multiplicities `(r+s,s)`, giving the asserted algebraic independence. The noninvertibility of [Z] follows from dimension 3 under a unital ring map to ℤ.

## Lean validation and limitations

The exact command `lake build TauCetiRoadmap.QuantumAffineAlgebras.Suggested` passed under Lean 4.36.0-rc2 and the pinned packages. The module SHA256 was `bb9f98ed7b53837251bdbfe197011d622205bb40ad063a2b189ba765ff37b4a1`. This module contains `import Mathlib`, a documentation block, and an empty namespace. It checks the import and syntax only. No theorem signature on an invented carrier, placeholder predicate, or admitted declaration was introduced, and no absent mathematical theorem was elaborated.

No tracked primary files were edited by this reviewer. The build log was moved out of the primary checkout after the build completed. Final acceptance must await repairs E1–E4 and review of the later foundations changes.
