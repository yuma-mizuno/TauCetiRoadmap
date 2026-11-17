# Review of QuantumAffineAlgebras (structure, ownership and sources, final round)

**Verdict:** accepted

There are **0 remaining findings** in this independent structural, ownership, source-support and source-independence review. This is one component of the author's AI-assisted self-review; it is not approval by Tau Ceti maintainers or an external human referee. The manuscript is a roadmap, not an implementation of its mathematical targets.

The final review covers all nine layers, all 28 numbered targets, their 95 Checks, the supplier contracts, the worked rank-one example, `Suggested.lean`, and `metadata.toml`. Every numbered target has at least three Checks. The final candidate's exact identities are:

| Item | Identity |
| --- | --- |
| Roadmap commit | `9f9a91680f97a98778950d2e202d1444d0b9d967` |
| README SHA-256 | `fed2f3c086c8140fd233a88f43563deea917c008353cfa9790eede61e0a16187` |
| Suggested.lean SHA-256 | `bb9f98ed7b53837251bdbfe197011d622205bb40ad063a2b189ba765ff37b4a1` |
| metadata.toml SHA-256 | `59159a8bb65b50330403f417dd20d78640e3689e84ba3e06af27866690a2574e` |
| Upstream roadmap baseline | `c6ef576569501d342dec5a31a9938c9549dc6a00` |
| Worker | `162470c202cff60e47b8d3339f2d609a6bb40d45` |
| TauCeti | `2fd255d997f47c0b5d834ee416c7015d55444ce5` |
| Mathlib | `1b1ccf4b088b32fa3f23f2de1127433254a81e1e` |

The README has 1,640 lines at this identity. No primary roadmap file was edited by this reviewer. Acquisition of two additional legal sources added K94 and K91 to the separate preparation manifest.

## Earlier observations rechecked after repair

The following table preserves the substantive repair history. These are resolved observations, not outstanding findings. Some proof-support repairs were also identified by the foundations and endpoint reviewers; this table records this reviewer's recheck of the resulting text.

| Observation | Final repair and verification |
| --- | --- |
| Bilinear descent and abelian K₀ had been assigned the same supplier section | The contracts now cite GrothendieckEulerForms §§1.1–1.4 for additive/bilinear descent and §2.3 for the abelian presentation. Both supplier sections were read. |
| A nonzero-level translation Check did not exclude the identity | §1.1 specifies the nonidentity A₁ translation and its iterates `(1+2n,−2n)` on the classical fundamental-weight coordinates. |
| Mark one alone did not specify an admissible affine node | The Conventions now require KKOP's standard node, its classical-Weyl condition, and c₀=1 except c₀=2 at the long A₂ₙ⁽²⁾ node. The added D₄⁽³⁾ counterexample excludes the incorrect alternative. |
| The rational/global-basis proof route had insufficient base-field and existence contracts | §2.1 now owns full-P integrable rank-one string decomposition. §4.2 works over ℚ(q), specifies the two local rings, Laurent form, balanced triple, negative-half/highest-weight existence, modified-sector basis, star actions, extremal quotient and Schubert support, with K91/K94/K02 locators. Scalar extension to k is justified through the native Jacobson-density theorem. |
| A finite-type modified-algebra supplier could have been silently treated as all-affine | §4.2 explicitly extends the carrier portion of QuantumEnvelopingAlgebras §5.3 to the affine datum and requires agreement on finite-type subdata. Its auxiliary Verma/highest-weight inputs use the actual all-symmetrizable §2.3. |
| The stabilizer Check repeated the desired conclusion without an instance | §4.2 now uses A₂⁽¹⁾, λ=Λ₁−Λ₀ and s₂λ=λ; its normalized vector is `f₂^(0)u=u`. The bad balanced-triple lattice example gives a second independent obstruction. |
| Weyl transport of modules had the weight-level locator | §4.3 now cites §1.1 for weights and §4.1 for the universal-module isomorphism. |
| Fundamental powers, current realization and the top constituent needed explicit proof ownership | §4.3 owns good/simple-crystal support, §7.1 owns powers, and §4.4 owns the untwisted/folded current realization and polynomial-to-fundamental comparison. Classification is not deduced from K₀ commutativity. |
| Some source page/equation locators drifted | Affinization is K02 §4.2, p.16; classification is CP95 pp.8–9 and CP98 pp.7–8; the universal/normalized R references now distinguish KKOP20 (2.5)–(2.7) from (2.8)–(2.13). |
| Later R-matrix arguments needed maps with nonsimple tensor factors | §2.3 now owns tensor intersection and §5.3 explicitly owns the requisite rational renormalizability, tensor/subquotient closure and nonvanishing compositions. |
| K02 Proposition 9.4 had an additional good-dual premise | §8.2 no longer applies that result without its premise. It proves the pole criterion from normalized inverse identities, primitive specialization and the real-simple theorem. |
| A complex-parameter theorem could have been used over a different field | §7.3 explicitly uses the generic-field formulation stated in KKOP20 §2.1, while identifying H10 Theorem 1.1 as the pairwise theorem. |
| The ordinary categorification predicate had an imprecise second locator | §9.4 now cites KKOP20 Introduction pp.2–3. KKOP22 is used for countable seeds and mutation; its stronger Λ-categorification is not identified with the endpoint. |

## Verified sound

### Adversarial instances and computed values

The table tests the hypotheses and the directions of the main comparison maps. Values are stated explicitly; these checks are not proofs of the planned general theorems.

| Target | Instance | Computed values and conclusion |
| --- | --- | --- |
| §1.1, null directions | A₁⁽¹⁾ | For `A=((2,−2),(−2,2))`, both primitive null vectors are `(1,1)`; δ is nonzero in P and zero in Pcl. With d₁=1 and α₁=2ϖ₁ classically, `(ϖ₁,ϖ₁)=1/2`. |
| §1.1, standard node | A₂⁽²⁾ and D₄⁽³⁾ | `((2,−1),(−4,2))(1,2)=0`, `(2,1)A=0`; `2Λ₁−Λ₀` has level 0, while `Λ₁−Λ₀` has level −1. In D₄⁽³⁾ with c=(1,2,3), the excluded last-node vectors `(3,0,−1),(0,3,−2)` miss `(1,1,−1)`, whose level is `1+2−3=0`. |
| §§1.1,2.2, level zero | A₁⁽¹⁾, t=s₁s₀ | `cl(tⁿΛ₀)=(1+2n,−2n)` has infinitely many distinct values. By contrast `tπ₁=π₁+δ`, so its classical level-zero class is fixed. The identity translation would not witness this argument. |
| §1.2, central quotient | A₂⁽²⁾, d=(4,1) | For C=K₀K₁², the two adjoint exponents on E₀,E₁ are `8−8=0` and `−4+4=0`. The incorrect K₀²K₁ gives exponents 12 and −6 and is not central. |
| §2.1, type 1 | One-dimensional sign module | All eᵢ=fᵢ=0 and Kᵢ=−1 satisfy the commutator relations, but −1 is not an integral power of transcendental qᵢ. This object is outside 𝒞. |
| §§2.1,4.1, divided powers | Highest i-weight 2 | The string coefficient at r=1 is qᵢ+qᵢ⁻¹. The normalized opposite extremal vector is fᵢ²u divided by that coefficient. At weight 0 the coefficient is 0. |
| §2.3, dual convention | V(a), e₁ | With the S-contragredient, evaluation of Δ(e₁) on φ₊⊗v₋ gives `−q⁻¹q+1=0`. Also S²(eᵢ)=qᵢ⁻²eᵢ and S²(fᵢ)=qᵢ²fᵢ, so the identity map does not supply same-side biduality. |
| §2.3, tensor intersection | Three two-dimensional trivial modules | For a one-dimensional middle Z, X=M₁⊗Z and Y=Z⊗M₃ give X⊗M₃=M₁⊗Y, of dimension 4. The middle supporting space is the specified line. |
| §§3.1–3.2, spectral action | Parameters a,b | τₐτ_b(e₀)=ab e₀ and τₐ⁻¹=τ_(a⁻¹). Specializing the affine variable to a gives e₀-action multiplied by a and f₀-action by a⁻¹. The pair ratio is b/a. |
| §4.1, zero and zero pairing | λ=0; ⟨hᵢ,wλ⟩=0 | E(0) has dimension 1. When the pairing is zero, both eᵢ and fᵢ annihilate the vector and the reflected family member equals the original one. |
| §4.2, genuine balancedness | A₀u,A∞u,(q−1)Au in ℚ(q)u | The third lattice is bar-stable because bar(q−1)=−q⁻¹(q−1). Its intersection with the other two is 0, while A₀u/qA₀u has dimension 1. Spanning plus bar stability is insufficient. |
| §4.2, normalized transport | A₂⁽¹⁾, λ=Λ₁−Λ₀ | ⟨h₂,λ⟩=0 and s₂λ=λ, but s₂ is nonidentity. Its extremal transport is f₂⁽⁰⁾u=u, with scalar 1. |
| §4.3, spectral quotient | A₁ fundamental module; a period m>1 | V(a) has dimension 2 and period 1; different a give different fundamental classes. For period m and ζᵐ=1, a and ζa define the same class. Thus Σ, not I₀×k×, is the polynomial-variable set. |
| §4.4, distinguished constituent | V(a)⊗V(aq²) | The total dimension is 4. The top-weight constituent Z has dimension 3 and occurs once; the remaining constituent is the unit. The tensor product itself is not the classified simple. |
| §§5.1–5.3, normalization | The displayed A₁ middle block | Its determinant is `(q²t−1)/(q²−t)`, the block at t=1 is the identity, and the monic denominator is t−q². At q=2,t=4 the cleared middle block is `((-3,6),(6,−12))`, rank 1, with the two outer entries zero. |
| §§5.2–5.3, specialization | q=2,t=1/4 | The regular middle block is `((4/5,2/5),(2/5,1/5))`, rank 1; with the two outer entries 1 the full rank is 3. The two exceptional tensor-order maps therefore have ranks 1 and 3, and their composites are zero. |
| §6.1, exact multiplicities | X⊗Y and V(a) | The class of X⊗Y is `[Z]+[1]`, hence length 2 and dimension 4. V(a) has length 1 and dimension 2. A single simple class forces length 1 by nonnegative coordinates. |
| §6.2, reduction of an inclusion | L₁=tⁿR⊆L₂=R | Q=R/(tⁿ) has k-dimension n, but Q[t] and Q/tQ both have dimension 1. Reduction of the inclusion is zero when n≥1, even though both reduced lattices have the same class. |
| §6.2, nonisomorphic fibres | A=k[x], x(e₂)=t e₁ | In bases `(e₁,e₂)` and `(te₁,e₂)`, the two reduced actions have ranks 0 and 1. They are nonisomorphic modules with the same class, twice the simple x=0 class. |
| §§6.3,7.2, tensor order | X=V(a),Y=V(aq²) | The unit-vector calculation gives Hom(1,X⊗Y)=0 and dim Hom(1,Y⊗X)=1. Thus the two products are nonisomorphic despite equal class. The dimension relation is 2·2=3+1. |
| §6.4, polynomial basis | Fundamental multiset {a,aq²} | Its monomial class equals `[Z]+1`; the correction has lower dominant weight. Distinct spectral labels can have identical ordinary characters, so character injectivity is not used. The classification's unique leading label gives the triangular argument. |
| §§7.1–7.3, real versus prime | Unit, V(a), V(a)² | Dimensions are 1,2,4. The unit is real but excluded from prime; V(a) is prime by dimension and the one-dimensional-object theorem; V(a)² is real simple and has a nontrivial tensor factorization. |
| §7.4, length-two reality | M=X,N=Y, end terms Z and 1 | The sequence has dimensions 0→3→4→1→0. The products Z⊗Y and 1⊗Y are simple of dimensions 6 and 2, by the rank-one segment test. The theorem concludes Y is real. Taking N=1 would make the middle term simple and is incompatible with these nonzero end terms. |
| §8.1, empty closure | No generators | Only weight 0 occurs in any extension of units; every eᵢ,fᵢ is zero. The category is finite sums of the unit and its K₀ is ℤ. |
| §8.2, component graph | A₁⁽¹⁾ | The neighbors of V(aq²ⁿ) are exactly V(aq²ⁿ⁻²) and V(aq²ⁿ⁺²); degree is 2 and no loop occurs. Transcendence distinguishes the integer-indexed vertices. The pole criterion is proved in both tensor orders. |
| §§9.1–9.3, seed realization | X mutable, Z frozen | B=(0,1) mutates to (0,−1), and the exact sequences give xy=z+1. Spectral multiplicities of XʳZˢ are `(r+s,s)`, an injective function of (r,s), proving the relevant algebraic independence. Dimension sends [Z] to 3, so [Z] is not a unit. |
| §§9.1–9.2, degenerate seed | Two unit variables; zero exchange column | Two unit classes obey x₁−1=0, so they cannot be independent. A zero column gives two unit end terms; a real-factor tensor would then have equal head and socle and length 2, contradicting §7.2. |
| §9.4, full predicate | Empty cluster algebra | The cluster algebra is ℤ, the category is finite sums of the unit, and the class/dimension isomorphism sends the empty monomial to the real simple unit. The worked nonempty exchange is correctly not promoted to a global categorification theorem. |

The local-lattice proof in §6.2 is valid for an arbitrary k-algebra A: after identifying generic fibres, finite free lattices are commensurable, and the quotient is killed by a power of t. The kernel/cokernel sequences of multiplication by t give equal classes of Q[t] and Q/tQ. The proof uses exact K₀; it would not prove an isomorphism of special fibres.

The polynomial presentation in §6.4 uses classification, finite composition series and finite lower intervals in the finite-type dominant-weight order. It does not assume semisimplicity. Although infinitely many spectral simples can have one dominant weight, each individual tensor product has finite support; induction and the finite-support maximal-term argument still give generation and independence.

### Ownership and supply direction

| Object shared with existing work | Owner at the inspected main snapshot | New work in this roadmap |
| --- | --- | --- |
| Root datum, generic U, Hopf structure, triangular/Serre comparison, homogeneous pairing, braid operators | QuantumEnvelopingAlgebras §§0.1,1.0–1.5,2.1 | Affine specialization, derived subalgebra, central quotient, spectral actions and completed R-action. |
| Quantum Verma modules and highest-weight character formula | QuantumEnvelopingAlgebras §2.3, for every symmetrizable datum | Only the crystal/global-basis support used for the affine extremal construction; no second category-O plan. |
| Modified weight-idempotent carrier and Laurent form in the finite-type layer | QuantumEnvelopingAlgebras §5.3 | Explicit affine extension, finite-type compatibility, and the new crystal/global-basis structures. |
| Realizations, lattices, classical Weyl groups | KacMoody §§0.1–0.3,2.1 | Affine null directions, normalized basic weights, translations and periods. |
| General finite-dimensional Hopf-module category and rigid structure | QuantumGroups §8.5; native TauCeti files | The type-1 full subcategory and the required restriction/abelian/size proofs. |
| Exact/abelian K₀, additive and bilinear descent | GrothendieckEulerForms §§1.1–1.4,2.3; native TauCeti | Simple coordinates for finite-dimensional modules over possibly non-Artinian algebras, affine specialization commutativity and the polynomial presentation. |
| Classical geometric seeds, frozen coefficients, locally finite patterns | ClusterAlgebras §§1.1–1.4,1.6,2.3 | Actual module-valued seeds, exchange sequences, local reality/mutation and the categorification predicate. |

The five direct roadmap suppliers are on the inspected main baseline. Every `*Needs:*` line was read. The logical order is consistent: Layer 4 classification precedes rational normalization; Layer 5 supplies the generic isomorphism used in Layer 6; Layer 6 supplies commutativity/domain cancellation for Layer 7; Layer 7 supplies real tensor monomials and local reality for Layer 9. In particular, classification and rationality do not borrow K₀ commutativity from a later layer. The two proofs developed internally, lattice specialization and the fundamental pole criterion, have their ingredients earlier in the roadmap.

The proposed general “KacMoody, Part II” is a future scope named by existing READMEs, not an existing main/Completed target. It is not used as a supplier. The affine crystal proof support is locally owned, with the existing carrier and highest-weight inputs explicitly reused. No duplicate universal R-matrix construction, affine fundamental-module theorem or categorification predicate was found on main. TypeAHeckeAlgebras has a finite type-A checked-R construction, not this affine spectral theory. No computational algorithm is introduced; the linear equations, polynomial divisibility and finite-support arguments are mathematical proof constructions.

**Overlap check:** read QuantumEnvelopingAlgebras, KacMoody, QuantumGroups, GrothendieckEulerForms, ClusterAlgebras and TypeAHeckeAlgebras; the shared objects and owners are listed above. Public open-PR and Mathlib/Zulip searches found surrounding Hopf infrastructure but no replacement quantum-affine target. No worker-board package index, open-head bundle or merge-order file was supplied; the audit does not claim exhaustive coverage of those unavailable inputs.

### Native APIs and Suggested.lean

The exact file/line contracts are recorded in `native-api-locations.md`. In particular, the review opened:

- `TauCeti/Algebra/Category/FiniteHopfModuleCat/Basic.lean:49,90,227,234`, `Monoidal.lean:265`, `RightRigid.lean:65,95,123`, and `Rigid.lean:69,132,146`. Tensor is over k and uses the coproduct; inverse-antipode rigidity requires an explicit bijectivity proof.
- `TauCeti/CategoryTheory/GrothendieckGroup/Abelian.lean:79,108,242,256` and `Monoidal/Exact.lean:108,140,177,275,299`. The ring construction is reused. The braided `instCommRing` at line 275 is not incorrectly installed on all of 𝒞.
- `TauCeti/RingTheory/CompositionSeries/Multiplicity.lean:217,222,239,309,337,400,408`, `Additivity.lean:126,154`, and `Algebra/Category/ModuleCat/FiniteLength.lean:30`. These use modulewise finite length and apply without an Artinian coefficient ring.
- `TauCeti/RepresentationTheory/GrothendieckGroup/SimpleBasis.lean:65,260`. Its Artinian-ring assumption is real and blocks its direct use at U′; §6.1 instead descends the existing module multiplicities.
- `Mathlib/RingTheory/FiniteLength.lean:33,53,76`, `Noetherian/Basic.lean:319`, `Artinian/Module.lean:359`, and `SimpleModule/Basic.lean:561`. `IsFiniteLength` is a proposition, and `jacobson_density` is the actual finite-interpolation theorem used by the absolute-simplicity proof.
- `Mathlib/Algebra/Polynomial/Laurent.lean:532`, `Algebra/Category/ModuleCat/ChangeOfRings.lean:85`, `CategoryTheory/ObjectProperty/FullSubcategory.lean:39`, `CategoryTheory/Simple.lean:55,140`, and `CategoryTheory/EssentiallySmall.lean:47`.

Full pinned-source searches found no quantum-affine/quantum-loop algebra, Drinfeld-polynomial classifier, normalized or specialized affine R-matrix, or quantum-affine categorification carrier. The current TauCeti quantum-group implementations do not supply those objects. The module docstring names all unavailable affine headlines, including the polynomial presentation and local exchange reality. A general arbitrary-algebra substitute would not state those headlines on their intended carriers.

The worker's `prompts/sections/lean-form.md` expressly permits a declaration-free file when the intended headline carriers are missing. `Suggested.lean` has one Mathlib import, one module docstring and an empty namespace, with no fake predicates, admitted data, options or padding. There are zero own declarations for an elaborated-binder or one-tactic probe. This does not assert that every supporting general algebra statement is unstatable.

The separate targeted build evidence was read: `build-log.txt` records `lake build TauCetiRoadmap.QuantumAffineAlgebras.Suggested`, Lean 4.36.0-rc2, exit 0, and the matching Suggested.lean hash. Its log SHA-256 is `97b3a9cd2bda5e0f9b12fde68a4a39c3df1c6aeea4cda32a9a9505c3a331f39a`. No warnings are present in the recorded output. This validates parsing/import resolution of the supplied file; it does not elaborate absent mathematical declarations.

### Mechanical worker gates

This reviewer ran the unmodified `gates.scan_folder` with `GateOptions`, metadata and stray-file checks, using the actual main supplier set and pinned TauCeti sources. All 25 text/dependency/folder counters were zero. The independent main/Completed inventory contained 322 roadmap names, including completed/nested names; only the five direct suppliers above are dependencies of this file.

The root subsequently ran the full unmodified `gates.run_gate` on the clean committed primary branch. Its `run-gate.py` and `gate-result.json` were read. The actual invocation is:

```python
options = GateOptions(
    order=sorted(merged) + ["QuantumAffineAlgebras"],
    merged=merged,
    tauceti_sources=root / ".lake/packages/TauCeti/TauCeti",
)
result = run_gate(
    root, "QuantumAffineAlgebras", options,
    base="upstream/main", build_cmd="lake build {module}",
)
```

For that final run, `merged` contains the 259 top-level active main roadmaps, including all five direct suppliers. `roadmap_files` is the default `README.md`, `Suggested.lean`, `metadata.toml`; `outside_folder_allow=[]` and `statement_hygiene=True`. Every counter is zero, including build, dirty tree, outside-folder diff and source-material checks. The script did not change the worker or suppress a gate. Metadata is `topic="math.QA"`; the independent metadata script also passed.

The mechanical check is not a substitute for the theorem/ownership review above. In particular, neither the broader inventory nor the final runner claims to possess the worker board's unsupplied open-package graph.

### Sources, exact locators and legal acquisition

`sources.toml` contains ten unique sources. The actual worker Fetcher acquired all ten PDFs from seven arXiv version URLs and three named author-page URLs. All ten PDF SHA-256 values were recomputed and matched. `sources check` returned `0 problem(s)`. No fetched paper, extracted source text or rendered source page is in the primary roadmap folder or the preparation artifacts intended for git.

The relevant source statements were read at the following contracts; repeated uses were checked against the same version:

| Source | Verified contracts |
| --- | --- |
| K91 | Theorems 2,4,6,7 on journal pp.466–467: highest-weight and negative-half crystals, balanced triples and divided-power filtration. These scanned theorem pages were visually read; the separate offline transcription is supporting evidence only. |
| K94 | Proposition 2.1.1 and Theorem 2.1.2 on pp.391–392; Theorem 3.1.1, Theorem 4.3.2 and §5; Lemma 8.2.1 and Proposition 8.2.2 on pp.406–407. Modified-crystal existence, star compatibility and the extremal quotient are distinct obligations. |
| K02 | §§2.2–2.4 and3.1; affine §§4.1–4.3; Theorem5.5, Propositions5.8,5.12,5.15,5.16; (5.6)–(5.7), Theorem5.17; §7 and good-module §§8–9. The good-dual hypothesis before Proposition9.4 was checked and is not silently imported. |
| AK97 | §§1.1–1.3, (1.7), Theorem1.2. Its literal unqualified wording is explicitly restricted to the actual type-1 category in §4.4. The conjectural general cyclicity assertion is not used as a proved theorem. |
| CP95 | Theorem2.2; Proposition3.2, Theorem3.3, Proposition3.4, Corollary3.5; §4 evaluation modules and the segment criterion, Propositions4.1–4.2 and Theorem4.3. |
| CP98 | Theorem1.3; Theorem3.1, Proposition3.2, Corollary3.3. The folded constraints and parameter normalization remain part of the comparison target. |
| H10 | Theorem1.1. Its complex-parameter setting is distinguished from the generic statement in KKOP20. |
| KKKO15 | Theorem3.12, Corollaries3.14 and3.16. The scalar self-R hypothesis is used in the correct direction; the additional one-dimensional Hom claim is not falsely attributed to this theorem. |
| KKOP20 | §2.1 and Definition2.2; §2.2, equations(2.5)–(2.13), Lemma2.10, Propositions2.11–2.12, Theorem2.13; Proposition4.9; Definitions6.1–6.3 and Proposition6.4(i); the ordinary categorification predicate in Introduction pp.2–3. |
| KKOP22 | §§2.1–2.2 for conventions, fundamental spectral labels and components; §§7.1–7.2 for countable classical seeds and categorical mutation. Definition7.7 is stronger Λ-categorification and is not substituted for the endpoint. |

There is one extraction limitation, not a missing mathematical reference. Nine worker-cache text files are readable. K91's full worker OCR operation was not verified as completed: automatic approval review rejected polling it because the OCR runtime contacted a Microsoft telemetry endpoint with an unestablished outbound payload. That action was not retried or bypassed. The required K91 pages had already been read visually. The installed standalone Tesseract executable then transcribed only the two existing local theorem-page images, without the rejected OCR runtime. Those transcripts are recorded as separate offline extraction; they do not turn an uncompleted worker-service operation into a claimed success.

### Source wording and arrangement

The locator inventory counts an explicit source identifier followed by a section, equation, named theorem or introduction locator as one bundle, even when that bundle lists several results. Repeated bundles count separately; bibliography entries and unlocated discussion mentions do not. The counts are:

| Source | Locator bundles |
| --- | ---: |
| KKOP20 | 25 |
| K02 | 15 |
| AK97 | 7 |
| KKOP22 | 7 |
| CP95 | 6 |
| CP98 | 4 |
| K94 | 3 |
| KKKO15 | 3 |
| K91 | 1 |
| H10 | 1 |
| Total | 72 |

At the cited passages, the hypotheses and mathematical notation naturally overlap, but no copied expository passage, translated passage, exercise list or reproduced source table was found. The following eight additional prose comparisons were made beyond locator support checks:

| Additional roadmap passage | Source passage compared | Result |
| --- | --- | --- |
| Scope's distinction between the quantum parameter and a grading | KKOP20 Introduction, pp.2–3 | Independently written boundary statement; no copied explanation. |
| Conventions' dual naming by evaluation domain | KKOP20 §2.1, p.8 | The equations are shared mathematical data; the native-API reconciliation is the roadmap's own. |
| §3.2's intrinsic affinization and specialization discussion | K02 §4.2, p.16 | The same construction is stated through the supplied scalar carriers, with an independent build order. |
| §4.2's rational-base and scalar-extension explanation | K02 §§2.1,2.4 and K94 §1.6 | Local-ring facts are mathematical data. The Jacobson-density bridge and explicit carrier boundary are independently formulated. |
| §5.2's rational normalization and finite-linear-system descent paragraph | KKOP20 §2.2, pp.10–11 | No reproduced proof plan or distinctive sentence. The finite-equation descent obligation is explicit. |
| §7.2's warning about the Hom statement's source attribution | KKOP20 Theorem2.13 and its following note | The source-support boundary is restated in new language and tied to owned tensor-intersection support. |
| §8.1's closure/universal-property paragraph | KKOP22 opening §7 and §7.2 | Standard closure conditions are shared, while the actual construction and inclusion obligations are independently organized. |
| §9.4's distinction from converses and its application obligations | KKOP20 Introduction, pp.2–3 | No copied explanatory passage; the finite-word quantifier and application data are explicit. |

KKOP20 has the largest share, 25/72 (34.7%). Its contents page was read: §2 is preliminaries, §§3–4 are numerical R-invariants, §5 is cluster algebras and §6 is categorification. This roadmap does not reproduce that sequence. It expands affine foundations and classification using K91/K94/K02 and CP95/CP98; separates exact K₀ and its independent lattice proof; omits numerical Λ-invariants; reuses the existing cluster-algebra supplier; and inserts the component-category interface from KKOP22. The order of its core layers is forced by the dependencies listed above, not the article's table of contents.

**Source independence:** 80 passage comparisons across 10 sources (72 cited-locator bundles and 8 additional prose comparisons); no copied expository passage or reused table/figure found. Largest share KKOP20, 25 of 72 locators; its contents were read and the roadmap's arrangement is independent. K91 theorem pages were visually verified despite the uncompleted full-service OCR.

**Research link:** Kashiwara (1991,1994,2002) supplies crystal and affine fundamental-module foundations; Chari–Pressley (1995,1998) supplies classification; Hernandez (2010) and Kang–Kashiwara–Kim–Oh (2015) supply tensor simplicity; Kashiwara–Kim–Oh–Park (2020,2022) uses these structures for cluster monoidal categorification. This connection is supported by the cited papers and the README's stated endpoint.

## Not verifiable

- No worker-board package index, complete open-PR head bundle or board merge-order file was supplied. Public searches and the pinned main/source inventory are recorded, but are not an exhaustive claim about unavailable board work.
- K91's full worker-service OCR completion is not verified. The source URL and PDF bytes are certified, and its cited theorem pages were read visually and transcribed separately offline. No required theorem statement remains unread for that reason.
- The future mathematical implementations are not verified in Lean. The passing build validates the actual import/docstring-only file, as permitted by the worker's missing-carrier rule.

## Source issues

- **Error** in AK97 at Theorem 1.2, printed p.6: read literally without an integrability convention, its classification includes sign characters; it should explicitly restrict to type-1/integrable irreducibles or separately account for sign twists; affects a stated result. The roadmap includes the restriction, and CP95 Proposition 3.2 distinguishes sign twists.

## For the human reviewers

- K91's theorem pages 466–467 were visually verified; its full worker OCR was not completed after automatic review blocked unexpected telemetry. Separate local Tesseract excerpts support the visual reading. No source material is included in git artifacts.
