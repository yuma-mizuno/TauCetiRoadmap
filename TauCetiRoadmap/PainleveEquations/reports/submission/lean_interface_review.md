# Lean interface review

This is an author-side AI review using GPT-6 Astra Pro. It records the representative Lean interfaces; it does not certify the roadmap's mathematical theorems or substitute for human subject-area review.

## Checked carrier boundaries

- N1.1 uses `ContMDiffMap`, `TangentSpace`, the native pullback bundle, `ContinuousLinearMap`, the derivative `mfderiv`, the total-space `ContMDiff` predicate, and the native manifold Lie bracket. A connection contains the actual lift and right-inverse identity; it does not contain assumed flatness, completeness, symplectic preservation, or a solved equation. The horizontal image is an actual `Submodule` of the tangent fibre. The finite-dimensional distribution target uses `TauCeti.IsContMDiffDistribution`.
- N1.4's signature uses `TauCeti.flowDomain`, `TauCeti.flowOf`, and `TauCeti.IsCompleteVectorField`; the target is an arbitrary topological space with native `Flow ℝ R`. Properness is the explicit compact-preimage condition. The semiconjugacy quantifies over every source point and every time in the actual maximal-flow domain, including exceptional points.
- N1.7 returns the existing `TauCeti.RiemannSurface.MeromorphicFunction`. The phase manifold and connected complex curve carry actual manifold instances. The finite-value witness concerns the evaluated curve, not merely the phase observation on its ambient space.

## Adversarial mathematical checks

1. Dropping properness in the N1.4 signature would incorrectly assert completeness of `x′ = x²` by mapping it to a one-point complete flow. The explicit compact-preimage hypothesis excludes that map on the noncompact source.
2. A proper comparison can contract a compact exceptional fibre. The signature contains no inverse or injectivity hypothesis and retains the initial source point in its universal quantifiers.
3. A nonconstant phase observation can equal infinity on an entire selected curve. The explicit witness in `meromorphicObservation` excludes that case; global nonconstancy of the phase observation would not suffice.
4. On the product with horizontal fields `∂s + ∂q` and `∂t + q∂p`, the curvature convention gives the nonzero vertical field `∂p`. The connection carrier allows this example; the vertical-curvature theorem does not smuggle in flatness.
5. Complementarity of vertical and horizontal tangent spaces and the rank of the horizontal distribution are target conclusions, rather than redundant property fields assumed by the connection definition.

## Exact proof boundary

There are nine explicit top-level structure/definition/theorem declarations. Four theorems use `sorry`: vertical-horizontal complementarity, smoothness and rank of the horizontal distribution, verticality of curvature, and the autonomous proper-semiconjugacy completeness theorem. Their signatures typecheck; their proofs are not completed here.

The N1.4 prototype is explicitly an autonomous C¹ specialization. A piecewise-C¹ base path has only continuous velocity. The continuous-time, locally uniformly Lipschitz continuation theorem in N1.2/N1.4 is therefore still the distinct mathematical target specified in the README. The autonomous signature does not discharge it.

The README is definitive. Moduli, Riemann–Hilbert, symplectic, confluence, and Painlevé realization targets are not represented exhaustively by this file.

## Scope of compilation evidence

The pinned toolchain is Lean `v4.36.0-rc2` (commit `b35cb10cf2ced51a2fd1880cfdbf75c71ab7a35a`), with Tau Ceti `2fd255d997f47c0b5d834ee416c7015d55444ce5` and Mathlib `1b1ccf4b088b32fa3f23f2de1127433254a81e1e`. Source pins and repository build configuration were unchanged.

`lake exe cache get` completed with exit 0 and restored 9,111 Mathlib cache files. `lake build TauCetiRoadmap.PainleveEquationsAndFunctions.Suggested` then completed with exit 0 (7,510 jobs), with the four expected `sorry` warnings. That target build preceded the final explicit manifold, connected-curve, and finite-dimensional boundaryless hypothesis refinements. The exact final source was checked separately with `lake env lean TauCetiRoadmap/PainleveEquationsAndFunctions/Suggested.lean`, which also exited 0 with exactly four `sorry` warnings.

The final `Suggested.lean` SHA-256 is `4cc1bfedac907a532f6e472c0931636d20d2c52c370cda4e29d4bea21bd0d011`.

The whole-repository `lake build` was intentionally interrupted with execution-session exit 130 when the user withdrew that requirement. It is neither a completed full-build pass nor a pending submission gate. The final bounded attempt reported no Lean type error before interruption; its observed compiler-process maximum was two, and both compiler-slot locks were free after stopping. Earlier cache-rate and process-resource failures remain historical attempts in [build_results.json](build_results.json), without any success claim.

These checks establish that the representative final interfaces elaborate against the pinned native APIs. They do not prove the four admitted theorems, encode every roadmap target, or replace mathematical expert review.
