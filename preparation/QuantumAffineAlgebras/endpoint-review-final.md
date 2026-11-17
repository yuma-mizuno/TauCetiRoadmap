# Final endpoint review addendum

## Disposition

**Accepted for the endpoint review. No remaining repairable finding in the reviewed endpoint scope.** All four findings E1–E4 in `endpoint-review.md` are resolved. This is a review of the mathematical roadmap and its stated supporting constructions; the separate foundations and repository reviews retain their own scopes.

- Final README SHA256: `fed2f3c086c8140fd233a88f43563deea917c008353cfa9790eede61e0a16187`.
- Final README length: 1,640 lines.
- Final snapshot: `/workspace/scratch/889845af25ea/endpoint-final-readme-fed2f3c086c8.md`.
- The repair review first checked candidate `556dd72d9d9f4286c6cea439f95749011f6b025a83234311a32cde304a7371f3` in full at the changed endpoint passages. An exact comparison then verified that **Layer 5 through the end of the final file is byte-for-byte unchanged** from that candidate. The final-node change in the conventions and its D₄⁽³⁾ counterexample were read and checked separately.
- Endpoint coverage remains 17 numbered subsections. There are now 57 authored check bullets in Layers 5–9; the additional nonsimple renormalization check was reviewed.

## Repairs checked in full

| Finding | Repair and verification | Status |
|---|---|---|
| E1: weight–weight form | §1.1 now constructs the rational symmetric form on Pcl⁰⊗ℚ from the finite Cartan matrix, states root compatibility and Weyl invariance, and verifies the affine-node formula using the null-root and level equations. This is the form consumed by §5.1. | Resolved |
| E2: nonsimple R inputs | §2.3 owns the tensor-intersection lemma before R-matrices are constructed. §5.3 defines rational renormalizability for general nonzero pairs, constructs primitive maps, proves the required tensor/subquotient closure, and states the simple-middle-factor nonvanishing lemma. §7.2 explicitly consumes these results. | Resolved |
| E3: normalization wording | §5.1 now says that the universal and normalized matrices differ by a nonzero scalar series, and places the toral factor inside the universal construction. | Resolved |
| E4: source equation locators | §5.1 cites KKOP20 (2.5)–(2.7), pp.9–10; §5.3 cites (2.8)–(2.13), pp.10–11. These match the source constructions. | Resolved |

I read the complete revised passages in §§1.1, 2.3, 5.1–5.3, 7.2, 8.2 and 9.4, including their checks and dependency lists. I also inspected the full diff from the earlier reviewed snapshot so that the new assumptions and supplier boundaries were visible.

## Checks on the replacement arguments

### Weight factor and completion

The form in §1.1 closes the earlier construction gap. The classical roots indexed by I₀ are a rational basis, and the finite Cartan matrix is nondegenerate. Symmetrizability gives symmetry of the prescribed pairing. For the affine root, the relation aᵢdᵢ=r cᵢ together with a₀=1 and the level-zero condition gives the same root-compatibility equation. The spectral completion therefore uses an actual constructed form, rather than the unrelated coweight-torus form from the supplier. The A₁⁽¹⁾ check `(ϖ₁,ϖ₁)=1/2` follows from cl(α₁)=2ϖ₁ and ⟨h₁,ϖ₁⟩=1.

### Primitive renormalization and nonzero compositions

The new §5.3 retains the required hypothesis for a general pair. It does not claim rational renormalizability for every arbitrary pair. Primitive-map uniqueness is uniqueness among scalar renormalizations of the fixed universal map, not an unsupported claim that every intertwiner between two nonsimple products is proportional. Dividing the common Laurent-polynomial factors makes every nonzero spectral specialization nonzero. Naturality gives the stated subquotient restriction, and the universal tensor identities give tensor closure.

The simple-middle-factor lemma is now stated with its actual morphism types. It makes the relevant composite nonzero, and applying it at every shifted parameter shows that the product renormalization is already primitive up to a Laurent unit. This supplies the specialized composition statement used by the real-simple theorem without numerical Λ invariants or a circular use of that theorem.

The added checks have the stated values: the tensor-intersection fixture has dimension `2·1·2=4`, with the middle line forced by the two inclusions. The unitor map for `(X⊗Y,1)` has rank 4; its two simple-subquotient comparisons have ranks 3 and 1.

### Pole criterion in §8.2

The replacement proof is sound in both directions. If both denominators are nonzero at 1, the normalized inverse identity specializes, giving commutation; the real-factor theorem gives simplicity. If the tensor product is simple, the nonzero primitive r is an isomorphism, so it cannot kill the nonzero dominant extremal tensor. Its image there is d(1) times the opposite extremal tensor, forcing d(1)≠0. The reverse order is covered as well. This argument applies to the actual shifted fundamental modules and avoids the earlier good-dual hypothesis from K02 Proposition 9.4.

### Endpoint citation and convention

Section 9.4 now cites KKOP20's introduction for the ordinary one-way definition, exactly where that definition is stated. The KKOP22 reference is accurately limited to spectral components, countable seeds and monoidal mutation; its Λ-categorification definition is distinguished as stronger data. The endpoint continues to require a specified ring isomorphism and every cluster monomial to represent a real simple, without adding either Hernandez–Leclerc converse.

### Final affine-node adjustment

The final snapshot strengthens the node choice to the standard KKOP node. This is consistent with the fundamental-weight basis used by the endpoint. The D₄⁽³⁾ boundary check is arithmetically correct: with comarks (1,2,3), the vector (1,1,−1) has level zero, whereas every integral combination of (3,0,−1) and (0,3,−2) has its first two coordinates divisible by 3. Thus the alternate mark-one node fails the proposed basis property and is correctly excluded. No endpoint section changes are hidden in this final adjustment.

## Retained computational and build evidence

The complete A₁⁽¹⁾ worked example is unchanged from the snapshot used for the symbolic checks. Its extracted section SHA256 is `911b746b5b2ff81b8cb1b50be2be3c2f24e672e6179546a1133c2873c6b000de`. The earlier 39 symbolic assertions, determinant and fixed boundary calculations therefore apply unchanged. No optional rerun was needed.

`Suggested.lean` remains SHA256 `bb9f98ed7b53837251bdbfe197011d622205bb40ad063a2b189ba765ff37b4a1`, identical to the module that passed

    lake build TauCetiRoadmap.QuantumAffineAlgebras.Suggested

with exit code 0 under Lean 4.36.0-rc2. The existing `build-log.txt` and `build-summary.md` remain the exact evidence. The module has an import, documentation and an empty namespace; the successful build does not represent elaboration of the future mathematical constructions. No rebuild was run and no tracked primary file was changed by this review.

## Finding counts

- Original repairable findings: 4.
- Verified resolved findings: 4.
- New repairable endpoint findings: 0.
- Remaining repairable endpoint findings: 0.
