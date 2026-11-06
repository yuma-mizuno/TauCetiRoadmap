# Reuse contract: single-roadmap edition

The [unified roadmap](README.md) contains this explanation and all mathematical targets in full.

## Appendix: the reusable proof contract

**Mathematical draft.** This revision separates general proof ownership from application-specific admission and comparison proofs. The targets are obligations to construct and prove, not a declaration that their proofs or formalizations are complete. [日本語版](README.ja.md#reuse-contract).

### Acceptance contract

A reusable result has its own inputs, outputs, laws, failure cases, owner and dependency unit. Its transitive prerequisites contain no specialized application. Applications use the same native objects and prove that the hypotheses apply; they do not copy the carrier or repeat the general proof. Actual morphisms, pullbacks and coherence maps are retained. Reusability does not justify weakening a necessary hypothesis.

The previous combined targets mixed proper continuation with classical RH, generic jet scalarization with symplecticity and global continuation, analytic RHP inversion with geometric reconstruction, and ODE convergence with confluence. They now have separate general targets and application adapters.

### Independently reusable parts of one roadmap

| Part | Targets | Reusable mathematics | Proposed ownership |
|---|---:|---|---|
| [NonlinearConnections](README.md#part-n) | 9 | Actual nonlinear connections and base change; continuous-time local lifts; holomorphic germs; proper-transfer completeness; fundamental groupoids and descent; relative forms; observations; intrinsic jets; compact-path limits | Specified extensions of SmoothBundlesConnectionsPartII, DifferentialGeometry and ComplexKahlerGeometry |
| [MeromorphicConnectionModuli](README.md#part-m) | 12 | Admitted decorated input → full moduli, deformation cone, relative symplectic form and constructed strong flat splitting; regular-singular RH branch | Proposed general moduli-construction roadmap |
| [AnalyticRHPAndDeterminants](README.md#part-a) | 6 | Complex Fredholm determinant line; Cauchy-class small-norm RHP; weighted moments and uniform tails; normalized analytic limits | Proposed HeegaardFloerPartII F0.0C, OperatorTheory and ComplexKahlerGeometry extensions |
| [AlgebraicConfluence](README.md#part-c) | 2 | Vector-valued principal-part cancellation; relative Lie–Poisson structures on duals over finite locally free algebras | Proposed FormalLaurentPuiseux and LieGroupoidsPoisson extensions |

These are reviewable units within this draft. Their names do not claim that an upstream project has accepted or implemented them. Several targets may ultimately live in existing roadmaps; each general theorem still has one owner.

### Intrinsic construction and later properties

For an admitted decorated deformation problem D, the general construction produces

\[
D\longmapsto(\pi_D:M_D\to B_D,h_D,\omega_D).
\]

The phase space, tangent splitting, flatness and relative symplectic form are outputs. The construction comes with input-isomorphism and admissible-base-change comparisons, including composition and triple-overlap coherence. On a verified nonempty-fiber base, the consumer receives the actual nonlinear-connection object. No solution operator, completeness theorem or scalar formula is inserted into its input.

The admitted scope retains I23's logarithmic flags, generic distinct-leading unramified conditions and specified generic totally ramified factorized conditions. Mixed blocks and new local types require a new admission/construction theorem. Fixed determinant has its own transport and deformation comparison; the positive-genus removal of 2g directions is not inferred from the genus-zero formula. [I23, §§2–5 and Theorems 5.1, 7.5, 8.1, 11.6](https://sigma-journal.com/2023/013/).

Completeness is obtained separately. A proper semiconjugacy from a finite-dimensional C¹ nonlinear connection to a complete continuous transport sends every partial horizontal lift into the compact preimage of one transported path. Continuous-time local uniqueness and compact extension then give a full lift. The target may be singular; no inverse to the comparison map is needed. Individual-path completeness does not need flatness. Flatness is needed for homotopy invariance, the fundamental-groupoid action and universal-cover sections. Descent is a further fixed-point condition. The moduli application must supply the proper map and all-point compatibility. I13 supplies a precisely scoped regular-singular family theorem with the exponent parameters retained; general irregular properness is not inferred from it. [I13, Theorem 2.2](https://arxiv.org/abs/math/0602004v2).

For scalarization, the general input is a holomorphic observer bundle E→B of relative dimension one over a complex time curve B, together with its intrinsic jet map J_Q:M→J¹(E/B). On a proved jet-isomorphism domain, transport gives a second-order equation. The coordinate formula q″=(A_t+AA_q+BA_p)(t,q,P(t,q,q′)) is a lemma after choosing h(∂t)=∂t+A∂q+B∂p and a genuine inverse p=P(t,q,v). Symplecticity, completeness and the Painlevé property are not hypotheses of that generic theorem.

### A second actual consumer

[FiveLogarithmicPoints](README.md#part-g) contains four application targets with no direct or transitive Painlevé prerequisite. It starts with rank two on an ordered five-pointed projective line, structural degree five, determinant (O,d), and fixed residue pairs ±1/4, ±1/4, ±1/6, ±1/6, ±1/4. Explicit rational weights avoid stability walls. The normalized configuration base has dimension 5−3=2. The phase dimension is −8+2+10=4.

Nonemptiness is witnessed by (D,J,K,K⁻¹,(DJ)⁻¹), where D=diag(i,−i), J=[[0,1],[−1,0]] and K=diag(exp(πi/3),exp(−πi/3)). The product is I; D and J have no common invariant line. Chosen logarithmic lattices, the determinant comparison and stability turn this irreducible representation into an admitted connection for every configuration. No trivial rank-two underlying bundle or global marked object is assumed. The exact I13 inequality is 2·5−2·2−2=4>0.

Both applications consume the same construction in MeromorphicConnectionModuli M3.4, the same completeness theorem in NonlinearConnections N1.4 and the same groupoid/descent theorem in 1.5. The second consumer exposes accidental classical assumptions: its four-dimensional phase fiber cannot be identified with a scalar first-jet fiber, and its two-dimensional time base does not support an unqualified one-variable pole statement. Meromorphic evaluation after an independently supplied holomorphic time-curve pullback uses its exact additional observer hypotheses. A future Garnier display is downstream.

### Remaining application ownership

Painlevé owns the degree-four restriction, the ten underlying and seventeen ordered profile classification and one-dimensional time conclusion; the remaining classical irregular/Stokes and all-strata proper-RH extension; full surface and boundary comparisons; transformations and invariant reductions; actual observer/jet charts; resonant/ramified index-zero RHP realizations; the geometric contour, endpoint and uniformity adapters; and collision families, endpoint admissibility, common charts and tau line/frame/operator comparisons.

The vector-valued pole-cancellation theorem does not classify Katz slopes or certify a primitive endpoint. The relative Lie–Poisson theorem does not assert existence of every symplectic quotient or flatness of every orbit family. Those comparisons remain explicit application obligations.

The two former named gaps are expanded as NonlinearConnections N1.3 and AnalyticRHPAndDeterminants A1.1. They are not counted as proved. Broader irregular transport and geometric reduction statements remain scoped construction targets; no general theorem outside the admitted hypotheses is silently claimed.

### Structural verification and review

`design/reuse_registry.json` registers the six internal parts of one plan; `reports/unification/validate_one_roadmap.py` checks the one graph and its exact correspondence with the reviewed split edition. Acceptance requires resolved references, acyclicity, no general-to-application dependency, no five-point-to-Painlevé dependency, no intrinsic-to-classical-formula reverse dependency, exact English-plan contracts and Japanese coverage. The graph check is a consistency check, not a mathematical proof.

Part P retains the original 44 local Painlevé numbers as application bindings or specialized targets, now with the canonical prefix P; reports/unification/id_map.json records every old-to-new address. `reports/reusability/migration.json` records which general proofs moved and which concrete comparisons remain. Older reviewer verdicts stay bound to their old snapshots. The mathematical review of the preceding split edition and its repairs are in `reports/reusability/review_report.ja.md`; the current consolidation review is in `reports/unification/review_report.ja.md`. Worker execution and official upstream acceptance are not claimed. The user has authorized a draft branch in their fork.
