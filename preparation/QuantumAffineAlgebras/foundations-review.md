# Independent foundations review — initial Layers 1–4

Reviewer: quantum_affine_foundations. Reviewed the initial README snapshot ending at Layer 4 (635 lines), the named suppliers in QuantumEnvelopingAlgebras and KacMoody, and the primary sources listed below. Root is revising the file concurrently; section identifiers, rather than line numbers, identify findings. No main-roadmap edits were made.

## Assessment

The mathematical endpoint statements in Layers 1–4 are substantially correct, including the all-affine fundamental construction, the A_2n^(2) convention, the intrinsic spectral quotient, and the distinction between a top-weight constituent and a tensor-product head. I would not pass the initial snapshot's proof-dependency review until the rational-form/crystal-basis contracts and the fundamental-power dependency have been closed. Concrete replacement prose is in `preparation/QuantumAffineAlgebras/proposed-crystal-support.md`.

## Findings requiring revision

### F1 — high — §4.2: global-basis work cannot be performed over the declared k without rational descent

**Issue.** The conventions declare k to be an algebraic closure of C(q), whereas §4.2 asks for a q=0 lattice and a bar-invariant integral lift without specifying a descent field, valuation ring, or balanced-triple theorem. Kashiwara works first over Q(q_s), with the local ring at q_s=0 and Laurent form over Q[q_s,q_s^-1] (K02 §2.1, (2.4); §2.4, Definitions 2.2–2.3).

This is a real obstruction, not merely a missing conventional notation: there is no involution of algebraically closed k that fixes C and sends q to q^-1. If t=(q-1)/(q+1), choose s²=t. Such an involution would have bar(t)=-t and bar(s)=±is; fixing i then gives bar²(s)=-s.

**Correction.** Work with E_F(lambda) over F=Q(q), A_0=functions regular at zero, A=Q[q,q^-1], and the source-generator bar. Our integral d_i allow F=Q(q) directly. Construct the lattice, crystal quotient and the actual balanced isomorphism L∩bar(L)∩E_A ≅ L/qL. Prove the quotient, normalized Weyl action, and period quotient commute with field extension. Prove absolute simplicity before passing to k; the one-dimensional generating extremal line gives End(E_F)=F, and finite interpolation/density proves the required scalar-extension result. Root reports native `jacobson_density` in `Mathlib/RingTheory/SimpleModule/Basic.lean`; consume that instead of creating another density theorem.

**Status communicated.** Root has agreed to adopt rational descent and the existing density supplier.

### F2 — high — §§4.1–4.2: the stated basis proof needs precisely owned existence results

**Issue.** K02 §2.2 reviews crystal structures and refers to earlier work; §3.1 explicitly cites K94 for existence of the extremal module's global crystal basis. Rank-one operators plus an unspecified stable lattice do not supply that basis. K02 Proposition 5.15 additionally uses the modified crystal, its star action, and Schubert subsets of B(infty). No such quantum-basis supplier exists in the present KacMoody roadmap; its Part II is a named future scope, not a target with these conclusions.

**Correction.** The proposed replacement makes the necessary affine-specific support actual local construction/theorem targets: negative-half crystal/global-basis existence; positive-half transport; balanced bases on the modified sectors; commuting ordinary/star actions; and the quotient

    B_ext(lambda)={b∈B(U a_lambda): b* extremal},
    I_lambda=span{G(b): b∉B_ext(lambda)},
    E_F(lambda) ≅ U a_lambda/I_lambda.

Prove I_lambda is a submodule and the surviving basis is balanced and has the extremal universal property. K94 Proposition 8.2.2 states exactly these integrability/extremal/Weyl-transport conclusions. K94 Theorem 2.1.2 supplies the modified-basis existence statement; Theorem 3.1.1 and Theorem 4.3.2 supply the decomposition and star stability. These must be locally owned proof support, not assumed structures. K91 Theorems 2,4,6,7 state the auxiliary highest-weight/negative-half existence and balanced-triple results. Their proofs may be restricted to the fixed affine datum; no separate general exported crystal API is required.

**Existing carrier ownership.** Root found the modified carrier already in QEA §5.3. Reuse that carrier and its weight idempotents; do not define a competing dot U. However QEA §5.1 starts with a finite-type datum. Its §5.3 carrier paragraph does not use finiteness mathematically, but the roadmap should explicitly identify the generic carrier portion or state the affine extension/compatibility target. Do not silently attribute an all-affine integral freeness theorem to a finite-type-only supplier. The crystal/global-basis structure is new here.

**Status communicated.** Replacement prose and exact source images delivered; root has read K94 pp.406–407 and intends to adopt this repair.

### F3 — high/medium — §2.1 → §4.1/4.2: finite-dimensional string theory is not yet the full-module string decomposition

**Issue.** §2.1 proves identities and Weyl invariance in the finite-dimensional category. E(lambda) in §4.1 is an infinite-dimensional full-P weight module. Kashiwara operators require the unique finite decomposition of each vector into divided-power strings, not only the displayed e_i f_i^(r) identity.

**Correction.** State and prove the rank-one string decomposition for arbitrary integrable P-weight modules over F and over k, then specialize to finite-dimensional modules for category C. Local nilpotence and the generic q_i hypotheses give the necessary finite strings. Add this precise full-module contract to the Needs of §4.1/4.2. It does not require the future general quantum category-O roadmap.

### F4 — high — §4.3: tensor-power simplicity cites later R-matrix theory

**Issue.** The initial §4.3 cites K02 Theorem 9.2 and Proposition 9.4 to establish fundamental tensor powers are simple. Proposition 9.4 uses normalized R-matrices, not constructed until Layer 5. This is a dependency cycle if Layer 5 in turn uses §4.3/4.4.

**Correction.** Move the realness/power consequence to Layer 7, or use the independent crystal route: K02 Theorem 5.17(ii) gives a simple crystal for F_i; Lemma 4.11 says a tensor product of simple crystals is simple; Proposition 4.12 implies irreducibility. The tensor crystal compatibility and these two implications must be explicitly owned in the local support. Then §3.1 simultaneous shift gives simplicity of every F_i(a)^⊗n for arbitrary a∈k× without giving F_i(a) a bar over k. This route is noncircular even if the consequence is presented later.

**Status communicated.** Root already identified this cycle and is moving the consequence.

### F5 — medium — §4.4: the highest-l-weight proof needs a presentation and a bridge to the constructed F_i

**Issue.** The intrinsic classification statement is correct and self-contained. However the proposed proof paragraph names induced highest-l-weight modules and folded polynomial classification without saying what supplies the current realization or the comparison with the extremal-quotient fundamental modules. The supplier's Drinfeld–Jimbo triangular decomposition alone is not the triangular decomposition for the current highest-l-weight construction.

**Correction.** Keep these as internal support, but explicitly own the following chain if this proof is chosen: (1) the relevant untwisted/folded current realization of the central quotient, with the source toral and node conventions; (2) its highest-l-weight induction and unique simple quotient; (3) finite-dimensionality exactly for the allowed polynomial data; (4) comparison of an elementary polynomial datum with the F_i(a) of §4.3, including the power a^m_i and the A_2n^(2) basic-weight transport; (5) multiplication of polynomial data on the top tensor line. Then factorization gives the multiset classifier, its injectivity and permutation independence. No current-generator API need be exported, and no K0 commutativity is needed. The theorem is over the declared generic k; do not treat a numerical complex-q theorem as literal scalar extension along C(q)→C fixing C.

**Source precision.** CP95 Theorem 2.2 is the untwisted realization; Proposition 3.2 gives highest-weight status; Theorem 3.3 classifies; Proposition 3.4/Corollary 3.5 are the tensor-product input. CP98 Theorem 1.3 is the folded loop realization; Theorem 3.1 and Proposition 3.2 are the classifier and tensor input. AK97 Theorem 1.2 already states the intrinsic fundamental-constituent classifier over algebraically closed extensions of its generic field. Cite it for the endpoint while owning the chosen proof route.

### F6 — medium — §1.1: make the full affine datum and classical-Weyl action explicit

**Issue.** The declared P=(⊕ZΛ_i)⊕Zδ is a valid choice, but the roots and degree pairing are not explicitly given. General supplier lattices do not imply primitive delta automatically. Also the finite classical Weyl group acts on the level-zero classical quotient; the action of the whole affine group on all P_cl need not factor through this finite group.

**Correction.** With a_0=1, set

    h_i(Λ_j)=δ_ij, h_i(δ)=0,
    α_j=Σ_i a_ij Λ_i+δ_j0 δ.

The dual of the delta-coordinate supplies the degree direction. Then Σa_jα_j=δ; root independence and both primitive annihilator claims follow directly from the one-dimensional kernels of A. Say explicitly that W_cl is the image on P_cl^0 (or its rational span), and choose the standard KKOP affine node with a_0=1, c_0=1 except c_0=2 in A_2n^(2), taking the long node there. The source condition that the remaining reflections generate W_cl should be named/proved.

### F7 — low — §4.3/4.4 source locators and normalized-family API

**Corrections.**

- K02 §4.2 affinization is printed pp.16–17 in the downloaded arXiv v2, not pp.17–18. Prefer section/equation identifiers (4.15)–(4.18) if pagination ambiguity is undesirable.
- CP95 Proposition 3.2 and Theorem 3.3 are printed p.8; Proposition 3.4/Corollary 3.5 extend to p.9. The initial pp.9–11 locator misses the exact classifier.
- CP98 Theorem 3.1 begins printed p.7 and continues p.8; Proposition 3.2 is p.8, not pp.11–13.
- For the “normalized finite extremal-family characterization” in §4.3, spell out that nonzero vectors u_mu for mu in W_cl varpi_i are chosen simultaneously and satisfy the divided-power reflection equations without scalar monodromy. A generic shifted F_i(a) does not have this normalized family unless the spectral period condition is satisfied. AK97 §1.3 lists exactly the three conditions.

## Verified mathematics and nonissues

1. The generator adapter e_i=E_i K_i^-1 and f_i=K_i F_i preserves the standard commutator/Serre presentation and produces the source coproduct. Its antipodes are S(e_i)=-e_i K_i and S(f_i)=-K_i^-1 f_i. Thus S²(e_i)=q_i^-2 e_i and S²(f_i)=q_i² f_i, as asserted.
2. The derived algebra generated by e_i,f_i,K_i±1 is the source U'_q(g). Keeping the central torus in U' and taking a separate Hopf quotient is correct. With d_i a_i = r c_i, C=∏K_i^a_i is central; it need not equal the primitive full-torus element q^c.
3. The A_2^(2) matrix [[2,-1],[-4,2]], marks (1,2), comarks (2,1), integral symmetrizer (4,1), pi_1=2Λ_1−Λ_0 and C=K_0 K_1²=q^(2c) are consistent. In the explicit full datum α_1=pi_1 and α_0=δ−2pi_1, so s_1s_0 pi_1=pi_1+δ and m_1=1. Λ_1−Λ_0 has nonzero level and is indeed wrong.
4. The pi_i=gcd(c_0,c_i)^-1(c_0Λ_i−c_iΛ_0) basis and the intrinsic orbit period agree with KKOP22 §2.2. Using the auxiliary c_{0∨}=1 node to define basic weights, then transporting to KKOP's long-node convention, avoids the A_2n^(2) error. The period m_i is independent of the arbitrary scaling of d_i; no uniform identification with d_i should be added.
5. Finite-dimensional type-1 modules have locally nilpotent e_i,f_i because cl(α_i) is nonzero and the weight support is finite. Their affine-Weyl-invariant weight support forces level zero. A one-dimensional type-1 representation is the unit; the signed one-dimensional representations show why “finite-dimensional” alone is insufficient.
6. The category constructions, closure under subobjects/quotients, inherited kernels/cokernels, finite length from scalar dimension, and restriction of tensor/duals do not assume U' is Artinian or the category semisimple. Extension closure in all finite U'-modules is not needed merely to make C abelian; extensions in later Serre subcategories can be understood inside C.
7. The intrinsic P-graded affinization and Laurent model are correctly distinguished. A section respecting α_i for i≠0 gives e_0 multiplication by z, and quotient z-a agrees with the spectral automorphism. Two independent spectral variables versus a diagonal simultaneous shift are correctly separated.
8. The extremal-family definition applies both inequalities when the pairing is zero. The zero vector is allowed, and the universal quotient in §4.1 is correct. Basic-weight simplicity, finite weight multiplicities, orbit-line dimension one and stabilizer normalization exactly match K02 Propositions 5.8, 5.15, 5.16. They must not be asserted for arbitrary level-zero weights.
9. z_i of degree m_iδ, F_i=E(pi_i)/(z_i-1), the root-adjoined affinization comparison, and F_i(a)≅F_j(b) iff i=j and a^m_i=b^m_i match K02 (5.6)–(5.7), Theorem 5.17, AK97 (1.7), and KKOP22 §2.2. Using actual isomorphism classes Σ is the correct uniform twisted statement.
10. The multiset classifier sends an ordered tensor product to its unique composition factor containing the one-dimensional maximal classical weight. It is not in general the head for that tensor ordering. Finite length and one-dimensionality give multiplicity one; polynomial classification supplies existence, injectivity and order-independence. The empty multiset/unit check is correct.

## Source reads supporting this review

- K02: https://arxiv.org/pdf/math/0010293 — local `sources/kashiwara_level_zero.pdf/.txt`; §§2.1–2.4,3.1,4.1–4.3,5.1–5.2,8–9 read, including Propositions5.8,5.15,5.16 and Theorem5.17.
- AK97: https://www.kurims.kyoto-u.ac.jp/~kenkyubu/kashiwara/akasaka.pdf — local `sources/akasaka_kashiwara.pdf/.txt`; §§1.1–1.4, especially (1.7), Theorem1.2 and normalized-family conditions.
- CP95: https://arxiv.org/pdf/hep-th/9411145 — local `sources/chari_pressley_untwisted.pdf/.txt`; Theorem2.2, Proposition3.2, Theorem3.3, Proposition3.4, Corollary3.5.
- CP98: https://arxiv.org/pdf/q-alg/9611002 — local `sources/chari_pressley_twisted.pdf/.txt`; Theorem1.3, §3, Theorem3.1, Proposition3.2. No untwisted eigenvalue formula was imposed on its folded cases.
- KKOP20: https://arxiv.org/pdf/1910.08307 — local `sources/kkop_2020.pdf/.txt`; §2.1 full datum, base field, source presentation, finite category, top line and affinization.
- KKOP22: https://arxiv.org/pdf/2103.10067 — local `sources/kkop_II.pdf/.txt`; §2.2 basic weights, spectral period, polynomial transformation and actual-isoclass quotient.
- K94: https://www.kurims.kyoto-u.ac.jp/~kenkyubu/kashiwara/enveloping.pdf — local `sources/kashiwara_modified.pdf`; scanned. Personally viewed PDF pp.1,3–4,7,9–10,24–26, including Proposition8.2.2 on journal p.407. Images under `sources/modified_pages/`.
- K91: https://www.kurims.kyoto-u.ac.jp/~kenkyubu/kashiwara/duke-crystal.pdf — local `sources/kashiwara_crystal1991.pdf`; scanned. Personally viewed introductory Theorems2,4,6,7 on journal pp.466–467 (PDF pp.2–3), images `sources/crystal91-02.png`, `sources/crystal91-03.png`.

Sources K94 and K91 were reported directly to repository_audit for legal-fetch/read manifest entries. `sources/kashiwara_global.pdf` was downloaded from the author's global-crystal.pdf but is not needed as a citation for the present findings and has not yet been reviewed.
