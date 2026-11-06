# Roadmap: intrinsic Painlevé equations and functions

Construct differential Painlevé equations as flat nonlinear connections on moduli spaces of decorated meromorphic connections, and Painlevé functions as their horizontal sections and admissible observations. Prove their properties from those constructions. The classical scalar equations, Hamiltonians and linear systems are coordinate comparison theorems.

The roadmap contains 78 construction and theorem targets in 10 layers: 30 targets of reusable general theory, 44 targets for the classical Painlevé application, and four targets for a five-logarithmic-point application with two time variables and four-dimensional phase fibers.

[日本語版](README.ja.md) · [Structured mathematical plan](design/plan.json) · [External dependency contracts](design/dependencies.json)

## Structure

Each layer develops one mathematical construction or theorem package. General results retain their own hypotheses, conclusions and proof ownership when placed alongside an application.

| Layer | Mathematical development | Targets |
|---:|---|---:|
| [0](#layer-0) | Nonlinear connections and intrinsic solutions | 9 |
| [1](#layer-1) | Moduli of decorated meromorphic connections | 6 |
| [2](#layer-2) | General isomonodromy and logarithmic Riemann–Hilbert correspondence | 10 |
| [3](#layer-3) | Intrinsic construction of Painlevé equations | 12 |
| [4](#layer-4) | Riemann–Hilbert comparison and the Painlevé property | 9 |
| [5](#layer-5) | Initial-condition surfaces, symmetries and Riccati reductions | 6 |
| [6](#layer-6) | Determinant lines and tau sections | 5 |
| [7](#layer-7) | Classical equations as coordinate comparisons | 5 |
| [8](#layer-8) | Riemann–Hilbert asymptotics and distinguished solutions | 8 |
| [9](#layer-9) | Confluence and convergence | 8 |

## Reusable general theory and proof ownership

All 78 targets, including each theorem with additional hypotheses, are in scope. The hypotheses state when a conclusion holds; they do not make its proof discretionary. Mathematical constructions, their basic APIs, comparison maps and specified examples belong to the same target.

| Reusable general theory | Targets |
|---|---|
| Nonlinear connections, solutions, transport, observations, jets and convergence | 0.1–0.9 |
| Moduli of decorated meromorphic connections | 1.1–1.6 |
| General isomonodromy and logarithmic Riemann–Hilbert correspondence | 2.1–2.6 |
| Determinant lines of holomorphic Fredholm families | 6.1 |
| Cauchy operators, small-norm RHPs, weighted moments and Barnes G | 8.1–8.4 |
| Pole cancellation, finite-algebra Poisson geometry, section and determinant convergence | 9.1–9.4 |

These 30 targets have no transitive prerequisite in either application. The independent five-point application consists of targets 2.7–2.10 and has no Painlevé prerequisite. The remaining 44 targets form the Painlevé application. Its intrinsic constructions and properties in Layers 3–6 do not depend on the classical coordinate comparisons in Layer 7. Sharing a layer adds no dependency. Phase spaces, connections and forms are constructed before their properties are proved.

An existing roadmap supplies only the results specified in the external dependency contracts. Additional constructions have named proof owners here. Applications use the same general objects, morphisms and pullbacks and prove their hypotheses and comparisons.

## Addresses and conventions

Layers are numbered consecutively from 0 to 9. A target identifier consists of its layer and its consecutive position within that layer, for example 0.1 and 0.2. Structured internal references have the form target:0.1; all internal references are global. Literature and supplier-roadmap sections retain their source numbering. The [reusable proof contract](#reuse-contract) specifies shared objects, exact application conditions and comparison laws.

<a id="external-dependencies"></a>
## External dependency contracts

A roadmap reference supplies its stated construction or theorem, with its hypotheses; it does not assert an implemented result. A native reference names an existing carrier or API. Every extension required here has a local proof owner. Full contract records are in [design/dependencies.json](design/dependencies.json).

| Contract | Exact supplier | Scope and local extension |
|---|---|---|
| <a id="dependency-complex"></a>complex | [ComplexKahlerGeometry](../../TauCetiRoadmap/ComplexKahlerGeometry/README.md) — K1; K3.0; K3.HolomorphicStalk; K3.MeromorphicGermField; K4; K7.1 | Complex inverse/implicit-function and tangent calculus; holomorphic germs and one-variable meromorphic germs; holomorphic bundle/sheaf equivalence and nonsingular flat connections/local systems; projective charts. The nonlinear-connection theory owns nonlinear connections, holomorphic ODEs, transport and observations. The meromorphic-moduli theory owns meromorphic/analytic-moduli comparisons. K4 does not supply algebraic analytification. |
| <a id="dependency-smooth"></a>smooth | [SmoothBundlesConnections](../../TauCetiRoadmap/SmoothBundlesConnections/README.md) — B1.5; B5.0; B5.2 | Smooth Ehresmann splittings, proper-submersion and principal-connection transport within their respective hypotheses. 0.1–0.5 own nonlinear connection objects, continuous-time local lifting, holomorphic parameter dependence and complete nonlinear transport. No properness of the phase projection is assumed. |
| <a id="dependency-differential"></a>differential | [DifferentialGeometry](../../TauCetiRoadmap/DifferentialGeometry/README.md) — Layers 0–1; 3.1–3.5 | Finite-dimensional manifolds, charts and smooth local/maximal/time-dependent flows. 0.2 proves the continuous-time locally uniformly Lipschitz theorem; 0.8 constructs intrinsic jets; 0.9 proves finite-chart stability and no exit. |
| <a id="dependency-frobenius"></a>frobenius | `TauCeti.Analysis.ODE.Frobenius` — TauCeti.exists_frobenius_flat_coordinate | For a finite-dimensional real integrable graph field, a local product OpenPartialHomeomorph with a smooth inverse and the prescribed horizontal derivatives, at the stated regularity. 0.5 constructs the submersion-chart graph field, proves curvature implies its integrability, and glues these local products for homotopy-invariant transport. 0.3 supplies the holomorphic counterpart. |
| <a id="dependency-covers"></a>covers | [Completed/UniversalCovers](../../Completed/UniversalCovers/README.md) — Stage 0.2–0.4; Stage 1.5; Stage 2.6–2.8 | Native covering, path and homotopy lifting, universal covers and their fundamental-group interfaces. 0.5 constructs the nonlinear action and horizontal descent; general-cover descent uses the actual fiber relation, not deck invariance without normality. |
| <a id="dependency-curves"></a>curves | [ComplexCurveModuli](../../TauCetiRoadmap/ComplexCurveModuli/README.md); [SchemeAndStackFoundations](../../TauCetiRoadmap/SchemeAndStackFoundations/README.md) — ComplexCurveModuli D0.3, D3–D5; SchemeAndStackFoundations 4.15 | Genus-zero Möbius normalization and supported point-pushing; stable marked-curve deformation charts in the stable range. 1.2 constructs unstable one-/two-pointed quotient charts, finite jets, local markings and determinant transport. Its analytic category is constructed there; D2.0 is only an instance comparison. |
| <a id="dependency-stacks"></a>stacks | [SchemeAndStackFoundations](../../TauCetiRoadmap/SchemeAndStackFoundations/README.md) — 1.18–1.23 | Stackification, 2-fiber products, algebraic/DM presentations, inertia, QCoh descent, and finite-inertia Keel–Mori at its hypotheses. 1.3 proves bounded GIT, scalar Gm rigidification, gerbe and coarse comparisons. Finite-inertia criteria do not apply to an unrigidified Gm stable stack. |
| <a id="dependency-quotient-predicates"></a>quotient-predicates | [SchemeAndStackFoundations](../../TauCetiRoadmap/SchemeAndStackFoundations/README.md) — 1.17 | Categorical/geometric quotient definitions, Artin bootstrap and the stated finite-group projective quotients. Reductive invariant theory and actual character quotients are 1.3/2.5; wild framing and Stokes quotients are 4.2. |
| <a id="dependency-quot"></a>quot | [SchemeAndStackFoundations](../../TauCetiRoadmap/SchemeAndStackFoundations/README.md) — 4.14 | Noetherian projective Quot/Hilbert and Hom/Isom parameter spaces with their stated base-change laws. 1.3 proves boundedness, the equations and stability/GIT comparison. Analytic pullbacks use 1.2. |
| <a id="dependency-cohomology"></a>cohomology | [SchemeAndStackFoundations](../../TauCetiRoadmap/SchemeAndStackFoundations/README.md) — 2.2; 2.6; 2.20; 3.3 | Čech and sheaf cohomology, coherent terms, relative/Serre duality, degrees and curve Riemann–Roch at the stated hypotheses. 1.4 constructs C-linear differential-operator hypercohomology and the ramified cone; coherent underlying terms do not make its differential O-linear. |
| <a id="dependency-deformation"></a>deformation | [SchemeAndStackFoundations](../../TauCetiRoadmap/SchemeAndStackFoundations/README.md) — 4.2–4.6 | Artinian coefficients, deformation functors, hulls and elementary small-extension obstruction calculations. 1.4 constructs actual connection cocycles, the needed arbitrary finite square-zero kernels and framed versality; 2.1 constructs strong horizontal extensions. |
| <a id="dependency-bundles"></a>bundles | [AlgebraicVectorBundles](../../TauCetiRoadmap/AlgebraicVectorBundles/README.md) — L0A–L0C; L1A–L1B; L2A–L2B | Finite locally free sheaves, duals/tensors/determinants, relative Spec and the geometric vector-bundle equivalence. Meromorphic connections and analytification are 1.1–1.2; relative dual Poisson geometry is 9.2. |
| <a id="dependency-analytic-coherence"></a>analytic-coherence | [RealAnalyticGeometry](../../TauCetiRoadmap/RealAnalyticGeometry/README.md) — R3.2 item 0 | Coherent analytic module-sheaf carriers and local calculus on the supplied analytic manifold structure sheaf. 1.2 constructs general complex analytic spaces, nilpotent quotients, analytification and GAGA comparisons. |
| <a id="dependency-proper-cohomology"></a>proper-cohomology | [JacobianChallenge](../../TauCetiRoadmap/JacobianChallenge/README.md) — Layer C | Proper coherent pushforwards and separately stated flat-base-change and cohomology/base-change criteria; Grauert under its reduced-base and constant-rank assumptions. 1.5 proves the relative Picard extension; 5.3 verifies boundary-coefficient flatness and the exact locally free/arbitrary-base-change criterion. |
| <a id="dependency-chow"></a>chow | [SchemeAndStackFoundations](../../TauCetiRoadmap/SchemeAndStackFoundations/README.md) — 4.12, `chow_lemma` only; 0.9 and 4.11 | For a separated finite-type morphism to a Noetherian base, a projective modification with quasi-projective source over that base; the source is projective when the original morphism is proper. 1.2 uses this subtarget with coherent cohomology and proper direct images for the proper GAGA argument. The separate flattening and StableReduction branch of 4.12 is not a prerequisite. |
| <a id="dependency-field-picard"></a>field-picard | [JacobianChallenge](../../TauCetiRoadmap/JacobianChallenge/README.md); [SchemeAndStackFoundations](../../TauCetiRoadmap/SchemeAndStackFoundations/README.md) — JacobianChallenge Layer D; SchemeAndStackFoundations 1.1, 2.6, 3.4, 4.6, 4.14 | Picard representability for projective geometrically integral schemes over a field, smooth-curve Jacobians, line-bundle descent and deformation. 1.5 constructs relative Picard under projective flat finite presentation and universal functions, including nonreduced curves; 5.1 verifies its boundary hypotheses. |
| <a id="dependency-supports"></a>supports | [SchemeAndStackFoundations](../../TauCetiRoadmap/SchemeAndStackFoundations/README.md) — 2.7 | Supported cohomology, localization/excision and the Noetherian colimit-of-Ext comparison with native local cohomology. 5.3 constructs its first boundary layer, injection and time-line comparison; it does not identify all supported cohomology with that line. |
| <a id="dependency-surfaces"></a>surfaces | [SchemeAndStackFoundations](../../TauCetiRoadmap/SchemeAndStackFoundations/README.md) — 3.4; 4.11; 4.17; 5.9–5.10 | Divisor/Picard groups, blowups and strict transforms, normal crossings, surface intersection/adjunction and lattice theory. 5.1–5.3 construct the nonreduced anticanonical boundary, relative logarithmic deformation and family comparisons; targets 5.4–5.6 construct the geometric transformations. |
| <a id="dependency-formal-series"></a>formal-series | [FormalLaurentPuiseux](../../TauCetiRoadmap/FormalLaurentPuiseux/README.md) — L1–L4; L5–L6 for finite-extension steps in 1.1 | Formal substitutions, continuous differentials, finite-dimensional HahnModule comparisons, residue/duality, ramified exponent embeddings and the stated finite-extension algebra. 1.1 proves differential-module Levelt–Turrittin/descent; 9.1 proves the convergent-germ and compact-uniform cancellation adapter. Formal valuation convergence is not analytic convergence. |
| <a id="dependency-fredholm"></a>fredholm | `Mathlib.Analysis.Normed.Operator.Fredholm.Basic`; `TauCeti.Analysis.Fredholm.Stabilization`; `TauCeti.Analysis.Normed.Operator.Splitting.Family`; `TauCeti.LinearAlgebra.Determinant.Line` — IsFredholm; nonempty_fredholmPackage; exists_stabilization_kernel_coordinates; kernelHomeomorph; contDiffAt_kerSection; detLine; detLineCongr | Scalar-generic finite-dimensional kernel/cokernel, stabilization coordinates and pointwise determinant-line comparisons; specialize over ℂ and dualize the convention. 6.1 constructs the holomorphic family, canonical section, transition cocycle and base-change laws. |
| <a id="dependency-inversion"></a>inversion | `Mathlib.Analysis.Analytic.Constructions` — analyticAt_inverse; analyticAt_inverse_one_sub | Analytic inversion on units of a complete normed algebra and the small-norm inverse. 6.1 and 8.2 prove the actual family-to-operator maps and uniform estimates. |
| <a id="dependency-lp"></a>lp | `Mathlib.Analysis.Fourier.LpSpace`; `Mathlib.MeasureTheory.Function.Holder` — Complex L²/Fourier–Plancherel; Hölder and dominated convergence on the native measure/integral carrier | Native complex Lp spaces, Fourier–Plancherel, Hölder inequalities and integral convergence. 8.1 constructs contour measure/coordinate comparisons; 8.3 proves weighted moment and uniform-tail statements. |
| <a id="dependency-hilbert-transform"></a>hilbert-transform | [PDE](../../TauCetiRoadmap/PDE/README.md) — 2.3/B10 | The real-line Cauchy/Hilbert multiplier −i sign(ξ), with L² norm one. 8.1 proves finite-arc/ray transport, the weighted cross-branch Schur bound, Plemelj and endpoint reconstruction. |
| <a id="dependency-cauchy"></a>cauchy | `TauCeti.Analysis.Contour.Cauchy.IntegralFormula`; `TauCeti.MeasureTheory.Integral.SchurTest` — Cauchy integral formula; Unweighted Schur estimates | Cauchy integral formula for the stated native contours and unweighted integral-kernel estimates. 8.1 proves its full contour package; the 1/(s+t) vertex kernel requires the weighted theorem specified there. |
| <a id="dependency-trace-ideal"></a>trace-ideal | [OperatorTheory/OperatorIdeals](../../TauCetiRoadmap/OperatorTheory/OperatorIdeals/README.md) — OI-B01–OI-B19; OI-B23; OI-B29–OI-B30 | Normed complete trace-class ideal, nuclear gauge and two-sided ideal estimates. 9.4 constructs the holomorphic-family adapter; 6.3 verifies actual trace-class realizations where used. |
| <a id="dependency-trace-determinant"></a>trace-determinant | [RandomMatrices](../../TauCetiRoadmap/RandomMatrices/README.md) — 8.3, generic operator-theory prefix | Trace, exterior powers, generic Fredholm determinant series and trace-norm continuity before the positive-kernel point-process specialization. 9.4 proves holomorphic dependence and uniform convergence. 6.4 proves its actual logarithmic derivative and integrable-kernel comparison. |
| <a id="dependency-toeplitz"></a>toeplitz | [OperatorTheory/ToeplitzOperators](../../TauCetiRoadmap/OperatorTheory/ToeplitzOperators/README.md) — T1–T3 | Circle Hardy models and Fredholm index equal to minus determinant winding for continuous invertible matrix symbols. 6.3 constructs contour/Hardy, holomorphic-family, index-zero, resonant and ramified adapters. Index zero alone does not imply invertibility. |
| <a id="dependency-rouche"></a>rouche | `TauCeti.Analysis.Complex.Conformal.Rouche`; `TauCeti.Analysis.Analytic.ZeroCount` — rouche; rouche_nullHomologous; Multiplicity zero-count carrier | Disc and null-homologous piecewise C¹ contour Rouché theorems and zero multiplicities. 9.4 supplies the actual boundary cycle and winding characterization for its general domain theorem. |
| <a id="dependency-meromorphic-germs"></a>meromorphic-germs | `TauCeti.Analysis.Meromorphic.Germ`; `TauCeti.Analysis.Meromorphic.PrincipalPart` — meromorphicGerms.principalPart; principalPart_eq_iff; principalPart_eq_sum_coeff; Analytic regular remainder | Scalar convergent meromorphic germs, finite principal parts and holomorphic remainders. 9.1 supplies finite-dimensional coefficient comparison, the cancellation identity and compact-uniform parameter limits. |
| <a id="dependency-curve-functions"></a>curve-functions | `TauCeti.Analysis.Complex.RiemannSurface.FunctionField`; `TauCeti.Analysis.Complex.RiemannSurface.FunctionField.Comap` — TauCeti.RiemannSurface.MeromorphicFunction; Nonconstant curve pullback and order comparison | Holomorphic maps from a Riemann surface to OnePoint ℂ with a witness excluding the constant-infinity map; native pullback and orders. 0.7 proves phase-observation admissibility and scalar descent; its scalar output uses this same carrier. |
| <a id="dependency-poisson"></a>poisson | [LieGroupoidsPoisson](../../TauCetiRoadmap/LieGroupoidsPoisson/README.md) — G4.6A | Positive/negative real Lie–Poisson conventions and fiber-negation comparison. 9.2 constructs the complex relative O_B-Lie and symmetric-algebra bracket, residue pairing and base change. |
| <a id="dependency-reduction"></a>reduction | [SymplecticGeometry/HamiltonianReduction](../../TauCetiRoadmap/SymplecticGeometry/HamiltonianReduction/README.md) — R2; R3 | Smooth real coadjoint/KKS geometry and regular free proper Hamiltonian reduction. 9.5 proves actual complex quotient existence, orbit flatness and collision comparisons; 9.2 transports already verified data. |
| <a id="dependency-airy-hm"></a>airy-hm | [RandomMatrices](../../TauCetiRoadmap/RandomMatrices/README.md) — 8.4; 8.5 | Airy normalization and tails, scalar Hastings–McLeod existence/uniqueness, real pole-freeness and F1/F2 identities. 8.8 constructs the intrinsic phase-point/jet bridge. 8.7 proves its tau normalization, sectorial calibration and selected connection constants. |
| <a id="dependency-gamma"></a>gamma | `Mathlib.Analysis.SpecialFunctions.Gamma.Basic`; `Mathlib.Analysis.SpecialFunctions.Gamma.Beta`; `Mathlib.Analysis.SpecialFunctions.Gamma.Deriv`; `Mathlib.NumberTheory.Bernoulli`; `Mathlib.NumberTheory.BernoulliPolynomials` — Complex.Gamma; GammaSeq_tendsto_Gamma; Gamma_ne_zero; Real.eulerMascheroniConstant; Bernoulli numbers/polynomials | Gamma and its pole-free analytic theory, Euler–Mascheroni constant, Bernoulli coefficients and native complex analysis. 8.4 constructs Barnes G, canonical normalization, zero divisor, logarithm branches and the explicit sectorial remainder. |
| <a id="dependency-proper"></a>proper | `Mathlib.Topology.Maps.Proper.Basic` — IsProperMap | Topological proper maps and the compact-preimage and base-change properties under their actual topological hypotheses. 0.4 proves complete-lift transfer. 1.2 proves analytic/algebraic comparison; 4.4 proves properness of the actual RH family. |

### Supporting primary sources

- **DLMF5.** NIST Digital Library of Mathematical Functions. [Barnes G-function (Double Gamma Function)](https://dlmf.nist.gov/5.17). 5.17.1, 5.17.3, 5.17.5 and 5.17.7.
- **NEM14.** Gergő Nemes. [Error bounds and exponential improvement for the asymptotic expansion of the Barnes G-function](https://arxiv.org/abs/1406.2535v2). Equation (1.1); Theorem 1.2, equation (1.10); proofs §§2–3.
- **SGA1XII.** A. Grothendieck et al.; Exposé XII by M. Raynaud. [Revêtements étales et groupe fondamental (SGA 1), Exposé XII: Géométrie algébrique et géométrie analytique](https://arxiv.org/pdf/math/0206203v2). XII Theorem and Definition 1.1 (analytification); §2 (coherent sheaf comparison); §3.1 (morphism properties, including properness); Theorem 4.2 (proper relative direct-image comparison); Corollary 4.3 (cohomology); Theorem 4.4 (proper coherent GAGA).
- **SERREGAGA.** J.-P. Serre. [Géométrie algébrique et géométrie analytique](https://www.numdam.org/article/AIF_1956__6__1_0.pdf). §§1–2; §3 no.12 Theorems1–3 and proofs nos.13–17.
- **GR84.** H. Grauert and R. Remmert. [Coherent Analytic Sheaves](https://link.springer.com/book/10.1007/978-3-642-69582-7). Chapter I, Complex Spaces (pp.1–37); Chapter X, Direct Image Theorem (pp.188–222).
- **KED09.** K. S. Kedlaya. [Good formal structures for flat meromorphic connections, I: Surfaces](https://arxiv.org/pdf/0811.0190v4). §2.1 (field and constants); §2.2 (regular modules and regulating lattices); Theorem2.3.3 and its proof; §2.4 (Deligne–Malgrange lattices).
- **DEL70.** P. Deligne. [Équations différentielles à points singuliers réguliers](https://publications.ias.edu/sites/default/files/Number9.pdf). II §5, Proposition5.4 (extension for a section of ℂ→ℂ/ℤ); Corollary5.6 (nonresonant monodromy/residue comparison); Theorem5.9 (regular-singular algebraic/analytic correspondence); II §6.6 (principal-parts analytification of differential operators and proper hypercohomology comparison), PDF p.103 / printed p.101. Read the [April 1971 erratum](https://publications.ias.edu/sites/default/files/Erratum%20to%20SLN%20163.pdf): omit II1.23–1.24 and use the corrected II4.1 proof in the higher-dimensional argument leading to II5.7/5.9. The cited one-dimensional statements retain their scopes.
- **ACV03.** D. Abramovich, A. Corti and A. Vistoli. [Twisted bundles and admissible covers](https://arxiv.org/pdf/math/0106211). §5.1, Theorem5.1.5 and construction; Stacks Project tag04V2 for hypotheses.
- **PICREL.** The Stacks Project Authors. [The Picard functor and its properties](https://stacks.math.columbia.edu/tag/0D2C). Proposition99.11.8, tag0D2C; Lemma108.9.3, tag0DNI; Lemma108.9.5, tag0DPK; the Picard gerbe Lemma108.9.1 in tag0DMD.
- **MFK94.** D. Mumford, J. Fogarty and F. Kirwan. [Geometric Invariant Theory, third edition](https://link.springer.com/book/9783540569633). Chapter1, reductive invariant theory and construction of quotients; coupled to I23 Theorem5.1 and its actual framed filtered-connection construction.

<a id="layer-0"></a>

## Layer 0: Nonlinear connections and intrinsic solutions

<a id="nonlinear-connections"></a>

This is an independently reusable part of the single roadmap, recorded in its one [plan](design/plan.json) and [Japanese version](README.ja.md#nonlinear-connections). Its mathematical prerequisites contain no Painlevé target, rank-two condition, degree-four condition, classical scalar equation, or Riemann–Hilbert comparison. A geometric application constructs its own phase family, splitting and any auxiliary forms or comparison maps, then invokes only the general results whose hypotheses it has proved. The module retains actual objects, arrows, pullbacks and comparison isomorphisms.

### What is reusable

| Target | Independently exported result | Additional input a consumer must prove |
|---|---|---|
| 0.1 | Nonlinear connection objects, arrows, curvature and base change | An actual submersion and tangent splitting |
| 0.2 | Local path lifts and compact extension | Continuous time dependence and local uniform phase Lipschitz bounds |
| 0.3 | Holomorphic horizontal germs and parameter dependence | A holomorphic splitting and flatness in the time directions |
| 0.4 | Completeness transferred by proper semiconjugacy | A proper map and compatibility with every partial lift at every point |
| 0.5 | Fundamental-groupoid action, universal-cover sections and descent | Flatness and path completeness, obtained by any valid proof |
| 0.6 | Closed-total-form criterion and symplectic transport | Fiberwise closedness and nondegeneracy, then the stated preservation or closedness hypothesis |
| 0.7 | Admissible evaluation and scalar descent | An actual admissible observation on a complex curve |
| 0.8 | Intrinsic first-jet scalarization | An observation and a proved local jet isomorphism |
| 0.9 | Finite-chart convergence with existence and no exit | Common domains, positive margins, uniform field bounds and matched initial data |

The dependency graph deliberately does not route scalarization through symplectic geometry or global continuation. Likewise, the proper-semiconjugacy theorem does not require flatness, while fundamental-groupoid transport does. Meromorphic evaluation can be used for any holomorphic map from a curve, without first proving completeness of a connection. Compact-path convergence does not depend on a collision or confluence construction; that construction is responsible for verifying its common-domain hypotheses.

### Regularity and proof boundary

The real $C^1$ branch is used for individual horizontal path lifting. Curvature, differential-form identities and the smooth flat-product theorem use smooth real data. The complex branch uses holomorphic data on finite-dimensional complex manifolds. No statement silently extends these constructions to singular, nonreduced or infinite-dimensional bases.

A consumer may legitimately supply a connection already proved complete to target:0.5. That is different from defining every connection to contain a proof of completeness. Targets 0.1–0.3 construct the carrier and local solution theory, and target:0.4 gives one sufficient theorem for completeness. Similarly, target:0.6 accepts an independently constructed relative form and proves the relation between flatness, preservation and total closedness; it does not manufacture an application’s relative form by an assumption.

<a id="target-0-1"></a>
### 0.1 Ehresmann connections, actual arrows and base change

**General theory.**

Let $\pi:M\to B$ be a smooth submersion between finite-dimensional Hausdorff second-countable smooth manifolds without boundary. A real nonlinear connection is a $C^1$ vector-bundle splitting $h:\pi^*TB\to TM$ with $d\pi\circ h=\mathrm{id}$. The holomorphic version uses complex manifolds, a holomorphic submersion and a holomorphic splitting. Surjectivity and properness of $\pi$ are not part of the definition. Whenever curvature, differential forms or smooth Frobenius theory are used below, strengthen the real splitting to smooth; the $C^1$ branch is retained for individual path lifting.

Define an arrow $(F,f):(M\to B,h)\to(N\to C,k)$ by actual smooth maps, or holomorphic maps in the holomorphic category, satisfying $\rho F=f\pi$ and $dF\circ h=k\circ df$. Composition and identities are the actual compositions and identities of these maps. An isomorphism retains its inverse and compatibility, rather than identifying the objects in a quotient set.

For a smooth or holomorphic map $u:B'\to B$, construct the fiber product $M'=B'\times_BM$, its projection $\pi':M'\to B'$ and the pullback splitting $h'_{(b',m)}(v)=(v,h_m(du(v)))$. Prove its tangent-space membership, splitting identity, functoriality on arrows and the canonical coherence isomorphisms for repeated base change. Construct the horizontal and vertical subbundles and, on the smooth or holomorphic branch, the vertical curvature $K_h(X,Y)=[hX,hY]-h[X,Y]$. Flatness means $K_h=0$. Neither horizontal solution operators, completeness, nor a symplectic form is an input to this construction.

**Hypotheses.**

- Finite-dimensional Hausdorff second-countable manifolds without boundary, a smooth submersion and a C¹ splitting; or finite-dimensional complex manifolds, a holomorphic submersion and a holomorphic splitting.
- For curvature and differential-form assertions, the real splitting is smooth. Base changes and arrows have the regularity of their chosen category.

**API.**

- Construct the category of actual connection-preserving arrows, its isomorphisms, and the horizontal–vertical splitting of the tangent bundle.
- Construct pullback connections along arbitrary smooth or holomorphic base maps and prove identity, composition and Cartesian comparison laws with their actual comparison maps.
- Prove tensoriality of $K_h$ and its naturality under connection isomorphisms and pullback; define flatness independently of completeness and symplecticity.

**Checks.**

- The zero map $\pi^*TB\to TM$ fails the splitting identity when $TB\ne0$; the product splitting on $B\times X\to B$ passes it.
- Under the noncritical time change $\tau=2t$, the vector field normalized to project to $\partial_\tau$ is one half of the vector field normalized to project to $\partial_t$.
- A fiber product connection can be defined along a ramified time map; this alone asserts neither completeness nor invertibility of its first-jet observation map.

*Needs:* [Smooth bundle and connection foundations](#dependency-smooth) (B1.5; B5.0; B5.2); [Complex manifolds, holomorphic bundles and observations](#dependency-complex) (K1; K3.0; K3.HolomorphicStalk; K3.MeromorphicGermField; K4; K7.1).

**Source scope.** Generic geometric construction. No classical family or comparison morphism is needed.

<a id="target-0-2"></a>
### 0.2 Local horizontal lifting and continuous-time compact extension

**General theory.**

Prove the local existence–uniqueness theorem for $y'=F(t,y)$ on finite-dimensional coordinate domains when $F$ is continuous in time and locally uniformly Lipschitz in the phase variable. The local constants are uniform on a sufficiently small closed time–phase box. In submersion coordinates $\pi(z,y)=z$, a $C^1$ base path $\gamma$ turns a $C^1$ splitting into the equation $y'=A(\gamma(t),y)\gamma'(t)$. Construct its local solution by the integral-equation contraction argument, prove uniqueness and restriction, and glue coordinate solutions to the unique maximal horizontal lift through each initial point. For a path with finitely many $C^1$ pieces, concatenate lifts at its breakpoints.

Prove the compact-extension lemma: a horizontal lift defined up to a finite endpoint of a base path extends through that endpoint if its image is contained in a compact subset of $M$. Use finitely many submersion charts near the compact set, uniform local existence intervals, accumulation and uniqueness to obtain the endpoint value and extension. A cluster point alone is not asserted to be the limit without this local uniqueness argument. The resulting lemma is available for ordinary nonautonomous ODEs in the same coordinate form.

The velocity of a $C^1$ path is merely continuous. The autonomized field $(1,F(t,y))$ therefore need not be $C^1$. The proof must use the stated continuous-time theorem, or a proved reduction to it, rather than import a smooth-vector-field theorem with unmet hypotheses. Continuous dependence on initial data is established under these hypotheses; stronger smooth or holomorphic dependence is claimed only with its additional regularity, and holomorphic horizontal sections are constructed in target:0.3. No complete-lift operator is assumed.

**Hypotheses.**

- A connection from target:0.1 and a compact-interval base path with finitely many C¹ pieces.
- For the analytic chart lemma: a continuous-time finite-dimensional ODE locally uniformly Lipschitz in its phase variable on its open domain.
- For compact extension: a finite endpoint at which the base path is defined, and a single compact subset containing the partial lift.

**API.**

- Prove the continuous-time Picard–Lindelöf chart theorem and the continuous initial-data dependence needed for local lifting.
- Construct unique maximal horizontal lifts, with restriction, reversal where defined, and concatenation across finitely many C¹ pieces.
- Prove that containment of a partial lift in one compact subset forces extension through a finite endpoint, using the actual nonautonomous regularity.

**Checks.**

- For the product splitting, the fiber coordinate is constant along every horizontal lift.
- The equation $y'=y^2$, $y(0)=1$ has $y(t)=1/(1-t)$: its local solution does not extend in the affine phase line through $t=1$; compact containment fails.
- The path $\gamma(s)=|s-1/2|^{3/2}$ is $C^1$, but $\gamma'$ is not $C^1$ at $1/2$. Its horizontal-lift equation remains an admissible continuous-time ODE; a $C^1$ autonomization cannot be assumed.

*Needs:* Internal: 0.1; [Smooth differential calculus and flows](#dependency-differential) (Layers 0–1; 3.1–3.5).

**Source scope.** Generic ODE construction and continuation proof. This is the analytic content required by later properness and no-exit arguments; no Riemann–Hilbert map is used.

<a id="target-0-3"></a>
### 0.3 Holomorphic horizontal germs and parameter dependence

**General theory.**

For a holomorphic submersion with a flat holomorphic splitting, construct the unique germ of holomorphic section $s$ through each $x_0\in M_{b_0}$ satisfying $\pi s=\mathrm{id}$, $s(b_0)=x_0$ and $ds=h$. Prove the local existence theorem with joint holomorphic dependence on the initial point and on auxiliary parameters when the submersion and splitting vary holomorphically in compatible finite-dimensional complex-manifold parameter charts. No assertion over singular or nonreduced parameter bases is implicit.

The proof target includes the complex ODE theorem with holomorphic parameter dependence: construct a convergent Picard iteration on a common polydisc, use uniform convergence to prove holomorphy, and prove uniqueness. In local base coordinates, flatness makes the horizontal coordinate vector fields commute. Prove the commuting-flow identity and compose the local flows to obtain local product charts and horizontal sections; prove their uniqueness and compatibility on connected overlaps. The resulting germ–initial-value correspondence is natural under actual connection isomorphisms and compatible base changes. It is local, and contains no global continuation assertion.

Construct horizontal germs by the local analytic proof, without assuming a horizontal-section theorem as input. Over a one-dimensional complex base, flatness of the holomorphic horizontal line distribution is automatic; in higher base dimension it is a genuine hypothesis.

**Hypotheses.**

- Finite-dimensional complex manifolds, a holomorphic submersion and a flat holomorphic splitting.
- For joint parameter dependence: a compatible local holomorphic family in finite-dimensional complex-manifold parameter charts, with flatness in the time directions.
- An initial point in the fiber of the chosen base point; conclusions hold after shrinking around it.

**API.**

- Prove local complex ODE existence, uniqueness and joint holomorphic initial-value and parameter dependence on common polydiscs.
- Construct commuting horizontal flows and local holomorphic product charts from the proved flatness of the splitting.
- Construct the natural bijection between initial points and local horizontal section germs, and prove uniqueness and overlap compatibility.

**Checks.**

- For the product splitting, the horizontal section through $(b_0,x_0)$ is $b\mapsto(b,x_0)$. The constant map $b\mapsto(b_0,x_0)$ is not a section on a nontrivial base.
- On $\mathbb C^2_{s,t}\times\mathbb C_y$, take $h\partial_s=\partial_s$ and $h\partial_t=\partial_t+s\partial_y$. A horizontal section would satisfy $y_s=0,\ y_t=s$, contradicting equality of mixed derivatives; flatness cannot be dropped.
- A theorem over a smooth parameter polydisc does not by itself provide a horizontal section over a singular or nonreduced base.

*Needs:* Internal: 0.1, 0.2; [Complex manifolds, holomorphic bundles and observations](#dependency-complex) (K1; K3.0; K3.HolomorphicStalk; K3.MeromorphicGermField; K4; K7.1).

**Source scope.** A general analytic construction and theorem. Specialized isomonodromic horizontal-section results are examples, not proof prerequisites.

<a id="target-0-4"></a>
### 0.4 Completeness transferred by a proper semiconjugacy

**General theory.**

Let $(M\to B,h)$ be a real connection from target:0.1. Let $p:R\to B$ be any continuous map of topological spaces carrying specified complete continuous transport: for every piecewise $C^1$ path $\gamma:[a,b]\to B$ with finitely many pieces and every $r_0\in R_{\gamma(a)}$, a continuous trajectory $\beta_{\gamma,r_0}:[a,b]\to R$ lies over $\gamma$, starts at $r_0$, and satisfies restriction and concatenation laws. The target need not be a manifold. Let $F:M\to R$ be continuous over $B$ and proper in the explicit sense that inverse images of compact subsets are compact.

Assume compatibility at every source point: every partial horizontal lift $x$ of $\gamma$ with initial point $x_0$ satisfies $F(x(t))=\beta_{\gamma,F(x_0)}(t)$ throughout its domain. Prove that every such base path has a unique horizontal lift on its entire compact interval through every initial point of $M_{\gamma(a)}$. Flatness is not needed for this completeness theorem.

Indeed, the complete target trajectory has compact image $K=\beta_{\gamma,F(x_0)}([a,b])$. Every partial lift is trapped in $F^{-1}(K)$; target:0.2 extends it through each finite endpoint, and local uniqueness glues the extensions. This proof uses properness of $F$, not properness of the phase projection $M\to B$. It does not use an inverse, injectivity or surjectivity of $F$. In particular, a nontrivial compact exceptional fiber is retained in full: the initial point in that fiber matters, and transport is not defined by choosing a preimage of the target trajectory.

For a holomorphic source splitting, apply the real theorem to its underlying real manifolds. Holomorphic local sections and homotopy invariance require the additional flatness and analytic results stated in their own targets. Compatibility only on a dense open subset, or properness only away from exceptional points, does not meet the hypotheses.

**Hypotheses.**

- A finite-dimensional C¹ Ehresmann splitting as in target:0.1; local existence and compact extension are supplied by target:0.2.
- A continuous target over B with specified complete continuous trajectories for all compact piecewise C¹ base paths, including restriction and concatenation laws.
- A continuous map F over B whose inverse image of every compact set is compact.
- Semiconjugacy for every partial horizontal lift through every source point, including exceptional points.

**API.**

- Construct the unique full horizontal lift of each compact piecewise $C^1$ base path through every source initial point from the proper semiconjugacy hypotheses.
- Prove completeness without choosing an inverse to F, and retain distinct initial points in every compact exceptional fiber.
- Apply the theorem to the underlying real geometry of a holomorphic splitting, without asserting flatness or holomorphic global sections from properness alone.

**Checks.**

- Take $M=\mathbb C_t\times\mathbb C_y$, $h\partial_t=\partial_t+y^2\partial_y$, $R=B=\mathbb C_t$ and $F=\pi$. The target transport is complete and the semiconjugacy holds, but $F$ is not proper. The lift through $y(0)=1$ has $y(1/2)=2$, $y(3/4)=4$ and no finite value at $t=1$.
- For a product connection and the identity comparison with its own constant-fiber transport, the theorem returns the constant fiber coordinate.
- If a proper comparison contracts an exceptional curve, the proof uses the compact inverse image of the target trajectory and local uniqueness at each point of that curve; replacing the fiber by one arbitrarily selected preimage fails the required initial-value statement.
- The $C^1$ path $\gamma(s)=|s-1/2|^{3/2}$ is permitted. Its merely continuous velocity is handled by target:0.2; an unproved $C^1$ autonomization is not an admissible shortcut.

*Needs:* Internal: 0.1, 0.2.

**Source scope.** The proof mechanism is abstracted from the nonlinear connection and geometric continuation viewpoint exemplified by IIS06, Definitions 2.1–2.2 and Lemma 2.12. Its generic continuous-target formulation and exact hypotheses are proved in this module; those specialized results do not supply a universal proper comparison.

<a id="target-0-5"></a>
### 0.5 Fundamental-groupoid transport, universal covers and descent

**General theory.**

Let a smooth real or holomorphic connection be flat and complete for all compact piecewise $C^1$ paths. Completeness is a hypothesis to be proved by the producer of the connection, by target:0.4 or another valid argument. From unique horizontal lifting construct endpoint maps $T_\gamma:M_{\gamma(a)}\to M_{\gamma(b)}$, with identity, reversal and concatenation laws. If $\gamma_1$ is traversed before $\gamma_2$, use the convention $T_{\gamma_2*\gamma_1}=T_{\gamma_2}\circ T_{\gamma_1}$.

Prove invariance under endpoint-fixed homotopy. Use local flat product charts, a finite subdivision of a compact homotopy, and uniqueness on overlaps; include the smooth approximation or subdivision step relating continuous homotopies to the piecewise smooth representatives. This constructs an action of the fundamental groupoid of $B$. Endpoint maps are diffeomorphisms in the smooth case and biholomorphisms in the holomorphic case. Symplectic preservation is not inferred here.

For connected $B$, a chosen $b_0$ and a pointed universal cover $p:\widetilde B\to B$, construct for each $x_0\in M_{b_0}$ a global horizontal section of the pulled-back family $\widetilde B\times_BM\to\widetilde B$. Prove it is smooth, or holomorphic in the holomorphic case, by the local product theorem. It descends to a section on $B$ if and only if $x_0$ is fixed by every actual monodromy map $T_\ell$ for based loops $\ell$. Thus the universal-cover solution and its descent obstruction are separate outputs. Pullback and connection-isomorphism naturality are proved using actual maps, including all exceptional points of a supplied phase space.

**Hypotheses.**

- A smooth real or holomorphic flat connection from target:0.1, with completeness for every compact piecewise C¹ base path established by its producer.
- For the universal-cover statement: a connected base with a chosen base point and pointed universal cover. Finite-dimensional manifolds meet the usual local covering hypotheses.
- No symplectic form or Riemann–Hilbert comparison is required.

**API.**

- Construct endpoint transport, prove concatenation, reversal and homotopy invariance, and obtain a fundamental-groupoid action by actual fiber isomorphisms.
- Construct the unique global horizontal section on the pulled-back family over the pointed universal cover through each initial point.
- Prove that the horizontal section descends to the original base exactly when its initial point is fixed by the full monodromy action.

**Checks.**

- A loop followed by its reverse acts as the identity on every initial point, including a point on an exceptional fiber of any separately supplied comparison.
- On $\mathbb C_t^\times\times\mathbb C^2_{q,p}$, the connection $q'=q/(2t),\ p'=-p/(2t)$ is complete and flat. One positive loop sends $(q,p)$ to $(-q,-p)$; two loops act identically. Exactly $(0,0)$ is fixed by every loop, although every initial point has a horizontal section on the universal cover.
- On $\mathbb C^2_{s,t}\times\mathbb C^2_{q,p}$, set $h\partial_s=\partial_s+\partial_q$ and $h\partial_t=\partial_t+q\partial_p$. This connection is complete but has curvature $\partial_p$. A rectangular loop with side increments $a,b$ translates $p$ by $ab$, so completeness without flatness does not give homotopy invariance.

**Supporting constructions owned by this target.**

- In a submersion chart express the horizontal splitting as the graph field f:E×F→(E→L[ℝ]F). Prove that zero curvature gives the native IsFrobeniusIntegrableAt condition. Apply TauCeti.exists_frobenius_flat_coordinate at smooth regularity and transport its actual OpenPartialHomeomorph and inverse back to the manifold. Prove compatibility of these product charts by horizontal uniqueness, then carry out the finite homotopy subdivision and gluing. For the holomorphic category use the local holomorphic solution-family construction of 0.3. The smooth real theorem is a named input; its nonlinear global adapter and all coherence maps are proved here.

*Needs:* Internal: 0.1, 0.2, 0.3; [Covering spaces and universal covers](#dependency-covers) (Stage 0.2–0.4; Stage 1.5; Stage 2.6–2.8); [Smooth bundle and connection foundations](#dependency-smooth) (B1.5; B5.0; B5.2); [Native real Frobenius product coordinates](#dependency-frobenius) (TauCeti.exists_frobenius_flat_coordinate).

**Source scope.** Generic flat-connection and covering theory. The geometric monodromy viewpoint in IIS06 and the symplectic isomonodromy setting of BOA01 are downstream applications; no claim of symplecticity follows without target:0.6's hypotheses.

<a id="target-0-6"></a>
### 0.6 Symplectic preservation and the closed total two-form

**General theory.**

Let $V=\ker d\pi$ for a smooth real or holomorphic submersion, let $h$ be a smooth or holomorphic splitting, and let $\omega$ be a smooth or holomorphic relative two-form on $V$ that is nondegenerate and closed on every fiber. These properties of $\omega$ must be proved by its producer. Define $v^V=v-h(d\pi v)$ and the actual total two-form $\Omega(v,w)=\omega(v^V,w^V)$. Prove that $\ker\Omega=\operatorname{im}h$.

For a base vector field $X$ and vertical fields $U,V$, define
$$
(D^h_X\omega)(U,V)=hX\bigl(\omega(U,V)\bigr)-\omega([hX,U],V)-\omega(U,[hX,V]).
$$
Compute all components of $d\Omega$: on three vertical vectors it is $d_V\omega$; on $(hX,U,V)$ it is $D^h_X\omega(U,V)$; on $(hX,hY,U)$ it is $-\omega(K_h(X,Y),U)$; on three horizontal vectors it is zero. Deduce, using vertical nondegeneracy, the equivalence
$$
d\Omega=0 \quad\Longleftrightarrow\quad K_h=0\ \text{and}\ D^h\omega=0.
$$
Prove separately that the locally defined parallel transport preserves the relative forms if and only if $D^h\omega=0$. Thus flatness and preservation are distinct conditions. Under horizontal preservation D^hω=0, flatness and completeness, target:0.5 then yields symplectic global transport; completeness is not needed for the local criterion.

Under the proved horizontal-preservation condition $D^h\omega=0$, only for a one-dimensional time base, and after a local symplectic trivialization with the required local phase exactness, derive a Hamiltonian potential for $h\partial_t=\partial_t+X_H$ from $\iota_{X_H}\omega=d_{\rm phase}H$. In Darboux coordinates the intrinsic total form has the coordinate display $\Omega=\sum_i dq_i\wedge dp_i+dH\wedge dt$. Prove the time-only ambiguity in $H$ on connected phase charts and the transformation law under time-dependent symplectic coordinates by comparing the actual total forms. Do not use the one-time formula unchanged in several time variables, where horizontal–horizontal components require their own analysis.

**Hypotheses.**

- A smooth real or holomorphic submersion and a splitting of the same regularity.
- A relative two-form proved fiberwise closed and vertically nondegenerate; flatness and horizontal preservation are conclusions of the criterion only when total closedness is separately established.
- For the Hamiltonian coordinate lemma: horizontal preservation, a one-dimensional time chart, a local symplectic trivialization and local exactness of the resulting closed phase one-form.

**API.**

- Construct the total form from the vertical projection and prove its kernel identity and naturality.
- Prove the component formulas and the equivalence $d\Omega=0\iff(K_h=0\ \text{and}\ D^h\omega=0)$ under the stated fiberwise hypotheses.
- Prove the equivalence between infinitesimal horizontal preservation and symplecticity of all local parallel-transport maps.
- Derive the one-time Hamiltonian display, time-only ambiguity and time-dependent coordinate transformation law from the intrinsic total form.

**Checks.**

- On $\mathbb C_t\times\mathbb C^2_{q,p}$ take the product flat splitting and $\omega=e^t\,dq\wedge dp$. The associated $\Omega$ satisfies $d\Omega=e^t\,dt\wedge dq\wedge dp\ne0$; flatness alone does not imply symplectic preservation or total closedness.
- For $H=p^2/2$, contraction of $\partial_t+p\partial_q$ with $dq\wedge dp+p\,dp\wedge dt$ is zero, checking the sign in the Hamiltonian display.
- The potentials $H$ and $H+t^2$ give the same total two-form because $d(t^2)\wedge dt=0$.
- On a positive-dimensional fiber the relative zero form is closed but vertically degenerate; its total extension has full tangent kernel, so the kernel and curvature conclusions require nondegeneracy. On a zero-dimensional vertical tangent space the zero form is nondegenerate.

*Needs:* Internal: 0.1, 0.2; [Complex manifolds, holomorphic bundles and observations](#dependency-complex) (K1; K3.0; K3.HolomorphicStalk; K3.MeromorphicGermField; K4; K7.1).

**Source scope.** Generic tensor and differential-form proof. I23 Definition 11.4 and Corollary 11.8 and BOA01 §7 provide specialized geometric constructions and comparisons, not a theorem that flatness alone preserves an arbitrary relative form.

<a id="target-0-7"></a>
### 0.7 Admissible observations and meromorphic evaluation on curves

**General theory.**

Let $S$ be a connected one-dimensional complex manifold and let $s:S\to M$ be a holomorphic map. Define admissible observation data by an actual holomorphic $\mathbb P^1$-valued map on a neighborhood of $s(S)$, or by meromorphic or rational presentation data for which evaluation along $s$ is proved to have a well-defined holomorphic $\mathbb P^1$-valued continuation. This is a marked observation; its domain and any comparison maps are retained.

Construct that continuation in the following elementary admissible case: local numerator–denominator presentations restrict along $s$ to holomorphic pairs that are not both identically zero. Remove their common vanishing order at each point of the curve, and prove the resulting local $\mathbb P^1$-maps agree on overlaps. Alternatively, if a resolution $\widehat M\to M$, a holomorphic observation $\widehat Q:\widehat M\to\mathbb P^1$ and a holomorphic lift $\widehat s$ are supplied, evaluation is $\widehat Q\widehat s$. Its independence of choices must be proved by comparison on a dense domain, or the lift must remain part of the observation marking. In particular, a curve wholly contained in an indeterminacy locus has no canonical rational evaluation merely because some lift exists.

If the evaluated map is not identically $\infty$, prove that it defines a meromorphic function on $S$. At a point with value $\infty$, its reciprocal is a holomorphic germ with a zero of finite order; the identity theorem excludes infinite order. Thus poles are isolated and of finite order. The curve hypothesis is essential to this formulation: higher-dimensional bases have polar divisors and possible indeterminacy, not a theorem of isolated poles.

Apply this local statement to horizontal germs from target:0.3 and, when separately supplied, to the universal-cover sections from target:0.5. For a universal cover or connected regular cover, prove that the scalar observation descends exactly when the evaluated function is invariant under every deck transformation. A monodromy-fixed geometric initial point is sufficient, but not necessary, for scalar descent. Prove naturality under actual compatible observation maps, base changes and resolved comparisons on their stated domains.

**Hypotheses.**

- A connected complex curve S, a holomorphic map s into a complex phase manifold, and admissible marked observation data on its image.
- For local ratio construction: the restricted numerator and denominator are not both identically zero; comparisons on overlaps are part of the presentation to be proved compatible.
- For evaluation through a resolution: an actual holomorphic lift and observation, with independence proved or the lift retained as marking.
- For an ordinary meromorphic function: evaluation is not identically infinity. For scalar descent by deck invariance: a specified universal cover (or a connected regular cover) and its actual deck action.

**API.**

- Construct admissible evaluation by actual maps, one-variable cancellation of local ratios, or specified resolved lifts, and prove the claimed comparison independence.
- Prove finite-order isolated poles for a non-identically-infinite admissible evaluation on a complex curve.
- For a universal cover or connected regular cover, prove that an observed function descends if and only if it is deck invariant; distinguish this from descent of the full geometric section.

**Checks.**

- The constant $\mathbb P^1$-valued map $Q\equiv\infty$ is allowed as a map but is excluded from the ordinary-meromorphic-function conclusion.
- For the rational observation $Q=[x:y]$ on $\mathbb C^2$ and the constant curve $s\equiv(0,0)$, both restricted coordinates vanish identically. Different directional lifts to the blowup have different values; no unmarked scalar value is defined.
- The observation $1/t$ on a punctured disc extends as a $\mathbb P^1$-map with reciprocal $t$ at the origin, giving one pole of order one.
- For the sign-monodromy example $q'=q/(2t),\ p'=-p/(2t)$ over $\mathbb C^\times$, the observation $q^2$ descends to the base even when the geometric section with nonzero initial data does not. Scalar descent cannot be characterized only by a fixed initial point.

- The connected degree-three cover p(z)=z³−3z from ℂ minus {−2,−1,1,2} to ℂ minus {−2,2} is not regular and has trivial deck group (its monodromy is S₃). The function f(z)=z is deck invariant but is not constant on the fiber over 0, so it does not descend. Deck invariance on an arbitrary nonregular cover is insufficient.

**Supporting constructions owned by this target.**

- Use the native Riemann-surface meromorphic-function carrier for the P¹-valued evaluation together with its explicit witness excluding the constant-infinity map. Construct the comparison of the admissible phase observation with that carrier, its pullbacks and order function. For the descent assertions use the covering-space equivalence relation and, on a universal or connected regular cover, its deck action from the covers contract; no nonlinear completeness theorem is a premise of this evaluation theorem.

*Needs:* Internal: 0.1; [Complex manifolds, holomorphic bundles and observations](#dependency-complex) (K1; K3.0; K3.HolomorphicStalk; K3.MeromorphicGermField; K4; K7.1); [Covering spaces and universal covers](#dependency-covers) (Stage 0.2–0.4; Stage 1.5; Stage 2.6–2.8); [Native meromorphic functions on Riemann surfaces](#dependency-curve-functions) (TauCeti.RiemannSurface.MeromorphicFunction; Nonconstant curve pullback and order comparison).

**Source scope.** Generic complex-curve evaluation and descent. IIS06's geometric definition of solution and VDPS09's scalar coordinates motivate applications; arbitrary rational observations do not automatically satisfy admissibility.

<a id="target-0-8"></a>
### 0.8 Intrinsic first jets and local scalarization

**General theory.**

Let $B$ be a complex time curve, let $\rho:E\to B$ be a holomorphic submersion of relative dimension one, and let $(M\to B,h)$ be a holomorphic nonlinear connection. Construct the first-jet bundle $J^1(E/B)$ intrinsically: its fiber over $e\in E_b$ is the affine space of complex-linear splittings $j:T_bB\to T_eE$ of $d\rho_e$. Construct its holomorphic transition maps and prove that these splittings correspond to first jets of local holomorphic sections of $E\to B$.

An observation $Q:M\to E$ over $B$ defines
$$
J_Q(x)=\bigl(Q(x),dQ_x\circ h_x\bigr)\in J^1(E/B).
$$
On an explicitly specified open $U\subset M$, assume and verify that $J_Q:U\to V$ is a biholomorphism onto an open $V\subset J^1(E/B)$. Transport the splitting to $V$ and prove its contact compatibility: along its horizontal curves, the jet coordinate is the derivative of the observed section. This constructs the corresponding second-order dynamics. Prove a bijection between horizontal section germs in $U$ and observation-section germs whose first jets lie in $V$ and solve that dynamics. The inverse uses the actual inverse of $J_Q$; it is not supplied by dimensional counting or by formal elimination.

As a downstream coordinate lemma choose $(t,q,p)$ on $U$, write $h\partial_t=\partial_t+A(t,q,p)\partial_q+B(t,q,p)\partial_p$, and suppose the jet map $(t,q,p)\mapsto(t,q,A(t,q,p))$ has the specified inverse $p=P(t,q,v)$. Then the intrinsic second-order dynamics has the display
$$
q''=\bigl(A_t+A A_q+B A_p\bigr)\bigl(t,q,P(t,q,q')\bigr).
$$
Prove naturality under actual connection and observation-bundle isomorphisms, and under noncritical time changes. Arbitrary ramified base change still defines the pullback connection of target:0.1, but need not preserve this jet-isomorphism hypothesis. The theorem assumes no symplectic structure, no completeness, no meromorphic continuation property and no named scalar equation.

**Hypotheses.**

- A holomorphic nonlinear connection over a complex curve, a holomorphic observation bundle E→B of relative dimension one, and an actual observation Q over B.
- An explicitly specified open domain on which the constructed first-jet map is proved biholomorphic onto an open subset of the first-jet bundle.
- For coordinate formulae: the displayed chart and actual inverse P. For naturality of the scalarized chart under a time change: its derivative is nonzero.

**API.**

- Construct the affine first-jet bundle, its holomorphic transition maps, its identification with section jets and the intrinsic observation jet map.
- Transport the connection across a proved jet isomorphism, establish the contact condition and prove the local solution-germ correspondence with its actual inverse.
- Derive the scalar second-order display by the chain rule and prove its naturality on the stated noncritical coordinate domains.

**Checks.**

- When $A=p$, the jet inverse is $p=q'$ and the second-order equation is $q''=B(t,q,q')$.
- If $A$ is independent of $p$, the jet map loses the momentum variable and has no open-set inverse in a two-dimensional phase chart.
- For $A=p^2$, the jet map has separate local inverse branches away from $p=0$ but no automatic global inverse; at $p=0$ its differential loses rank.
- Clearing denominators in a scalar display does not create a solution in a phase chart where the observation or jet inverse is undefined; the original domain is retained.
- Under $\tau=t^2$ at $t=0$, the time derivative vanishes. Pullback connections still exist, but the noncritical time-change comparison of scalar jets does not apply.

*Needs:* Internal: 0.1; [Complex manifolds, holomorphic bundles and observations](#dependency-complex) (K1; K3.0; K3.HolomorphicStalk; K3.MeromorphicGermField; K4; K7.1); [Smooth differential calculus and flows](#dependency-differential) (Layers 0–1; 3.1–3.5).

**Source scope.** Generic first-jet construction and chain-rule proof. VDPS09 §4.1 and its displayed classical systems are downstream examples of the coordinate lemma, not assumptions or a definition of the scalarized dynamics.

<a id="target-0-9"></a>
### 0.9 Finite-chart solution convergence and a no-exit argument

**General theory.**

Let $I=[a,b]$ be compact, let $M$ be a fixed finite-dimensional smooth manifold, and let $F_\varepsilon(t,\cdot)$ be actual time-dependent tangent fields on common domains, for parameters $\varepsilon$ near $0$ in a metric parameter space. Fields are continuous in time and locally uniformly Lipschitz in phase. If phase spaces vary, the application must first supply actual common identifications and verify these hypotheses for the transported fields. Let $x_0:I\to M$ be an existing solution for $F_0$.

Assume a finite subdivision $a=a_0<\cdots<a_N=b$ and common phase charts such that, in each chart, the closed tube $\{(t,y):t\in I_j,\ \|y-x_{0,j}(t)\|\le r_j\}$, with a fixed $r_j>0$, is compactly contained in a larger common time–phase domain. Thus the reference graph has the explicit positive margin $r_j$ from the lateral boundary of its tube. Choose compact overlap neighborhoods in which the chart transitions and their derivatives are controlled. On each fixed tube suppose $F_\varepsilon\to F_0$ uniformly and the phase Lipschitz constants $L_j$ can be chosen independent of sufficiently small $\varepsilon$. The matched initial points $x_\varepsilon(a)$ converge to $x_0(a)$. Existence on all of $I$, confinement to the tube cover and uniform convergence of the approximate solutions are conclusions, not hypotheses.

Construct local approximate solutions using target:0.2. Until the first possible exit from the $j$th tube, prove the Grönwall estimate
$$
\sup_{t\in I_j}\|x_\varepsilon(t)-x_0(t)\|
\leq \bigl(\|x_\varepsilon(a_j)-x_0(a_j)\|+\ell_j\delta_{\varepsilon,j}\bigr)e^{L_j\ell_j},
\qquad
\ell_j=a_{j+1}-a_j,\quad
\delta_{\varepsilon,j}=\sup_{\text{tube}_j}\|F_\varepsilon-F_0\|.
$$
Here the supremum is first taken over the common interval before exit; after excluding exit it holds over $I_j$. Choose $\varepsilon$ so that this bound is smaller than the prescribed margin. A first exit is then impossible, and compact extension gives the entire segment. Transfer the endpoint estimate through the controlled chart overlap and induct over the finitely many segments. This yields uniform convergence on $I$ in any compatible metric on a compact neighborhood of the reference graph. Do not assert a single unchanged Lipschitz constant across arbitrary coordinate transitions.

For horizontal lifts, the pulled-back vector field contains $\gamma'(t)$; a $C^1$ base path gives a continuous-time ODE and is covered by target:0.2. Holomorphic phase fields uniformly bounded on larger common complex neighborhoods supply uniform phase Lipschitz constants on smaller tubes by Cauchy estimates. Convergence of coefficients without common domains, a no-exit margin and matched initial data is insufficient. Uniformity over a family of time paths or a compact time domain requires additional uniform path and chart controls. Fixed compact-path convergence asserts neither convergence on unbounded rays nor convergence through excluded singular endpoints.

**Hypotheses.**

- A fixed finite-dimensional manifold, or verified common identifications supplied by the application, and continuous-time locally phase-Lipschitz tangent fields on common domains.
- An existing reference solution on a compact interval, a finite common chart subdivision, fixed closed radius-r_j tubes compactly contained in common time–phase domains with r_j>0, and controlled compact overlap neighborhoods.
- Uniform field convergence on those tubes and phase Lipschitz constants uniform for sufficiently small parameters.
- Matched initial data converging to the reference initial point. No global approximate solution or prior no-exit conclusion is assumed.

**API.**

- Prove the until-exit segmentwise Grönwall estimate with explicit interval lengths, field errors and incoming initial errors.
- Exclude first exits using the positive margins, extend each solution segment by compact extension, and transfer errors through finitely many controlled chart transitions.
- Deduce existence on the entire compact interval and uniform convergence; state the additional uniform controls required before quantifying over families of paths or time domains.

**Checks.**

- On $I=[0,2]$, take $F_n=1/(n+1)$, $F_0=0$ and common initial value $0$. Then $x_n(t)=t/(n+1)$ and $\sup_I|x_n-x_0|=2/(n+1)$, agreeing with the estimate.
- Even for identical zero fields, initial values $x_n(0)=(-1)^n$ do not converge; coefficient convergence alone does not imply solution convergence.
- Convergence of coefficients on one chart does not control a trajectory after it leaves that chart; the common tubes and positive no-exit margins cannot be omitted.
- The solutions $x_n(t)=t/(n+1)$ converge uniformly on every fixed compact interval but not uniformly for $t\in[0,\infty)$. The compact-path conclusion does not contain an unbounded-ray assertion.

*Needs:* Internal: 0.2; [Smooth differential calculus and flows](#dependency-differential) (Layers 0–1; 3.1–3.5); [Complex manifolds, holomorphic bundles and observations](#dependency-complex) (K1; K3.0; K3.HolomorphicStalk; K3.MeromorphicGermField; K4; K7.1).

**Source scope.** Generic finite-dimensional continuous-dependence theorem with an explicit finite-chart no-exit proof. A geometric degeneration must independently construct the common identifications and verify the hypotheses; coefficient limits alone are not that construction.

### Source orientation and ownership

The proofs of the general assertions are the obligations above. The following primary sources explain important downstream geometric settings; their specialized scope must not be silently enlarged.

- **IIS06:** Inaba, Iwasaki and Saito, [Dynamics of the Sixth Painlevé Equation](https://arxiv.org/abs/math/0501007v2), Definitions 2.1–2.2 and Lemma 2.12 for nonlinear connections and continuation; later sections for its specific geometric application.
- **I23:** Inaba, [Moduli Space of Factorized Ramified Connections and Generalized Isomonodromic Deformation](https://sigma-journal.com/2023/013/), Definition 11.4 and Corollary 11.8 for the constructed total form in the stated moduli setting.
- **BOA01:** Boalch, [Symplectic Manifolds and Isomonodromic Deformations](https://arxiv.org/abs/2002.00052v1), §7 for the isomonodromic symplectic setting under its hypotheses.
- **VDPS09:** van der Put and Saito, [Moduli spaces for linear differential equations and the Painlevé equations](https://arxiv.org/abs/0902.1702v5), §4.1 for displayed first-order systems and downstream scalar comparisons. This module does not import their displayed coefficients as intrinsic definitions.

<a id="layer-1"></a>

## Layer 1: Moduli of decorated meromorphic connections

<a id="connection-moduli"></a>

### What is reusable

The construction takes decorated meromorphic-connection data and produces a moduli family together with its **constructed** flat symplectic nonlinear time connection. A consumer supplies admission data and then uses one theorem, §2.4. Genus zero, rank two, structural polar degree four, one time variable, a named scalar equation and a classified surface are absent from the general hypotheses.

| Input the consumer must provide | Output constructed by this framework |
| --- | --- |
| An admitted curve, polar divisor and local decorations | The stack and rigidified stable moduli on all permitted bundle types |
| A genuine admitted time family and stability chamber | The actual horizontal splitting, flatness and pullback comparisons |
| Determinant mode and its verified conditions | Correct determinant-fiber comparison and dimension theorem |
| Nonemptiness evidence for a claimed full base | A surjective holomorphic nonlinear-connection carrier on that base |
| No scalar equation or Hamiltonian is required | Relative symplectic form, its preservation and the closed total form |

The local scope is deliberately exact: logarithmic full-flag conditions, generic unramified irregular conditions, and the generic totally ramified factorized conditions specified in §1.1. A new local singularity class requires an admission/construction theorem before it can use this export. Logarithmic resonance is retained through flags and lattices. Nonempty fibers, global fixed-determinant transport and positive-genus fixed-determinant smoothness have separate verification obligations.

### Dependency and ownership boundary

The geometric construction uses `0.1` (carrier, morphisms and pullbacks) and `0.6` (generic differential-form calculus). The logarithmic branch, under the hypotheses of 2.5–2.6, also uses `0.3` for local horizontal sections. They do not supply the geometric horizontal splitting or preservation of its trace form: §§2.1–2.2 prove those properties for this construction. Foundational inputs are standard curve/bundle, stack/moduli, coherent-cohomology, formal local algebra and complex-geometry interfaces listed in the structured plan. No specialized consumer is a prerequisite.

The main owned extensions beyond a source formula are the intrinsic presentation groupoid, certified determinant transport, the full trace-free/trace comparison including ramified relations, early finite-flat unfolding, and coherent comparison maps. In particular, removing a scalar stabilizer is not the same as removing the 2g-dimensional determinant deformation space.

### Common consumer certificate

A consumer identifies its local models and verifies the open generic conditions; specifies its actual time family and markings; chooses unfixed determinant or verifies the fixed determinant and its rank-one time transport; chooses a valid stability chamber; and provides nonemptiness evidence wherever it claims a surjective family. It then invokes §2.4. Completeness, proper Riemann–Hilbert comparison, scalar observables, distinguished solutions and classification results are further consumer obligations.

The five-logarithmic-point rank-two problem on ℙ¹ is a decisive reuse check: when nonempty with compatible fixed determinant, the construction gives phase dimension four over a two-dimensional configuration base. This checks mathematical scope beyond relative dimension two; its explicit existence certificate belongs to the separate consumer. Targets 2.5–2.6 additionally supply a proper logarithmic Riemann–Hilbert semiconjugacy in the exact I13 range. The same consumer can then apply the general continuation theorem of NonlinearConnections §0.4, without any five-point-specific compactness theorem.

<a id="target-1-1"></a>
### 1.1 Admitted decorated connection data

**General theory.**

Define a groupoid fibered over complex bases whose objects are smooth proper connected curve families, a nonempty ordered set of disjoint marked sections, a structural polar divisor P = Σ mᵢaᵢ, an integer rank r ≥ 1 and degree d, and the local data below. Construct both the unfixed-determinant problem, with all local trace polar data prescribed, and its fiber over a specified compatible line connection (L,∇L); in the latter an isomorphism det(E,∇) ≅ (L,∇L) is part of the object. A connection is a locally free sheaf on the entire curve with a relative meromorphic connection and the chosen decorations, not merely a matrix on a trivial-bundle chart. Morphisms are actual compatible bundle isomorphisms.

The initial admitted domain consists precisely of the local models in I23 §§2–5: logarithmic poles m=1 with full flags and specified graded residues, including resonant and repeated residues; generic unramified poles m≥2 with full filtrations on ma and pairwise distinct leading eigenvalues; and totally ramified generic poles of rank r≥2, m≥2, with wʳ=z and ν(w)=Σₖ₌₀ʳ⁻¹νₖ(z)wᵏ, where ν₀=Σⱼ₌₀ᵐ⁻¹a₀ⱼzʲdz/zᵐ, νₖ=Σⱼ₌₀ᵐ⁻²aₖⱼzʲdz/zᵐ for k≥1, and a₁₀ is invertible. For the last model construct the finite-level factorized ramified structures, their relations and equivalence with the formal model. Roots and formal coordinates are presentations with descent arrows. Mixed blocks, arbitrary slopes, leading-eigenvalue collisions and vanishing a₁₀ require separate extensions of this admitted domain.

Choose rational stability weights in a chamber with stable = semistable whenever that chamber is used; stability tests ∇-invariant proper subbundles. Establish Cartesian pullback with coherent isomorphisms. The initial domain is a source-supported scope for a reusable theory, not a list of classical scalar equations.

**Hypotheses**

- Complex smooth proper connected curve families; r≥1, d∈ℤ; nonempty disjoint marked sections with structural multiplicities; the three explicitly admitted local models; a chosen weight chamber.
- The determinant-fixed mode additionally includes the line connection and its determinant identification, with matching trace polar data and residue/degree relation.

**API**

- `admittedConnectionDataLaw1` — Construct restrictions, pullbacks, composition and inverse of arrows, with the associator and identity laws.
- `admittedConnectionDataLaw2` — Identify the underlying formal differential module, the induced connection on End⁰(E) of rank r² − 1, and the associated PGLᵣ connection. These latter two are the invariant adjoint/projective outputs. The local matrix A − tr(A)I/r represents the projective connection in a frame; it is not a canonically glued rank-r differential module on E. No square root of the determinant line is chosen.
- `admittedConnectionDataLaw3` — Compare equivalent local presentations by ramified descent, keeping parabolic flags and logarithmic lattices.
- `admittedConnectionDataLaw4` — Express determinant compatibility by an isomorphism of line connections; derive the residue/degree equation in a chosen local convention.

**Tests and falsification cases**

- `admittedConnectionDataCheck1` (non-example) — On E = O ⊕ O(−1), the determinant has odd degree; a putative global half-determinant twist does not exist. The carrier must still allow this bundle when the prescribed determinant matches it.
- `admittedConnectionDataCheck2` (compatibility) — Two logarithmic residues with the same repeated eigenvalue, one scalar and one nonzero Jordan block, are not identified by specifying the eigenvalues. Their allowed parabolic objects and monodromy differ.
- `admittedConnectionDataCheck3` (non-example) — Changing the root w to −w in a rank-two ramified chart changes the displayed branches but gives an equivalent descended object; forgetting the descent arrow fails this check.
- `admittedConnectionDataCheck4` (compatibility) — With I23's ramified convention, a rank-two ramified point contributes 2c + 1/2 to the residue/degree relation. Replacing it by 2c changes that relation by 1/2.
- `admittedConnectionDataCheck5` (computation) — Rank zero is rejected before slope stability or the dimension formula is applied. At r = 1 the adjoint bundle End⁰(E) has rank zero, without changing the required positive rank of E.
- `admittedConnectionDataCheck6` (computation) — For A = 0 and frame change g = diag(z,1), g⁻¹dg = diag(1,0)dz/z; subtracting half its trace gives diag(1/2,−1/2)dz/z. The scalar discrepancy prevents gluing a rank-two trace-subtracted connection on E, while the induced End⁰(E) and PGL₂ connections glue.

**Supporting constructions owned by this target.**

- On the existing finite locally free sheaf carrier define a relative meromorphic connection as a base-linear first-order Leibniz operator E→E⊗Ω¹(P), its gauge groupoid, tensor/dual/determinant/End⁰ operations, completion at a marked relative Cartier divisor, formal coordinate changes and ramified pullback/descent. Prove every operation on the actual sheaf maps and cocycles. CKG K4 supplies only the nonsingular holomorphic comparison; 1.2 constructs the algebraic-to-analytic comparison. No global trace-subtracted rank-r object or determinant root is introduced.

- For a finite-rank differential module over ℂ((z)), prove the characteristic-zero Levelt–Turrittin decomposition after a finite extension z=wᵉ into exponential factors tensored with regular-singular modules, with constants, refinement of e, formal coordinate change and deck descent. Use FormalLaurentPuiseux for scalar arithmetic only. Separately prove, over the stated nonvanishing/distinct-leading-coefficient base loci, the finite-level factorized models and their coherent base-change comparisons required by I23. A fibrewise decomposition is not a relative decomposition across collisions. 3.4 applies this common result to rank two and structural degree four; 4.1 still owns convergent sectorial realization and Stokes classification.

*Needs:* [Formal scalar and vector-valued Laurent algebra](#dependency-formal-series) (L1–L4; L5–L6 for finite-extension steps in 1.1); [Algebraic vector bundles and finite locally free sheaves](#dependency-bundles) (L0A–L0C; L1A–L1B; L2A–L2B); [Complex manifolds, holomorphic bundles and observations](#dependency-complex) (K1; K3.0; K3.HolomorphicStalk; K3.MeromorphicGermField; K4; K7.1); [Stacks, inertia and restricted coarse-space criteria](#dependency-stacks) (1.18–1.23).

**Source scope and owned proof:** I23, Definitions 2.1, 2.2, 2.4, 2.7–2.8; Definition 3.1, Proposition 3.3, Corollaries 4.3–4.4 and §5. Coordinate-independent packaging and 2-coherent descent are owned proof obligations, not assertions that I23 already proves that packaging.

<a id="target-1-2"></a>
### 1.2 Admitted time families and determinant transport

**General theory.**

Construct the deformation groupoid of the curve, marked poles and admitted irregular polar coefficients, keeping logarithmic residues and formal residue exponents fixed. Start from a smooth atlas of the pointed-curve stack with the finite coordinate jets and open coefficient conditions of I23 §5. Build the coordinate-change arrows and descent, rather than assuming a coarse curve moduli space has no automorphisms. Let B be a smooth complex chart, marking cover, or base change of this admitted time problem whose new base is smooth. The coefficient discriminants and collisions removed from B are fixed by input data. A topological marking of the punctured family is constructed locally and compared on overlaps; an arbitrary topological deformation is not declared an allowed time family.

In unfixed-determinant mode no determinant section is selected. In fixed-determinant mode require a certified strong rank-one transport of the specified determinant: a compatible integrable total line connection, with the induced trace polar data and fixed residues. Construct this rank-one transport locally on a marked contractible time chart by extending the fixed rank-one local system and gluing the prescribed logarithmic lattices and polar primitives; verify its restriction to the initial determinant, polar bound, and cocycle laws. The logarithmic genus-zero case must also have an explicit dlog construction. Global fixed-determinant output requires actual gluing data for these local transports, or a supplied line connection with the same verified properties. A freely varying family of determinant connections is not accepted on the strength of the residue condition alone. This rank-one construction is an owned preliminary result, independent of the rank-r horizontal splitting of §2.1.

Separate external exponent parameters from these time directions. Strong isomonodromy will preserve transported analytic data under admitted variation of irregular type; it does not mean that the irregular coefficients in a fixed coordinate are frozen. No analytic Stokes classification is a premise of the algebraic construction.

**Hypotheses**

- The decorated local data of 1.1 with fixed residue exponents; curve, polar-coefficient and marking variations obtained from the stated admitted time groupoid.
- For fixed determinant, the rank-one transport certificate constructed here or supplied with its verified pole, integrability, initial-value and gluing conditions.

**API**

- `admittedTimeDeformationLaw1` — Separate tangent directions along the admitted time base B from variation in the external residue/exponent parameter θ, and compare the pullback tangent sequence.
- `admittedTimeDeformationLaw2` — Construct marking changes and local time reparametrizations with their coherence laws.
- `admittedTimeDeformationLaw3` — Identify the collision and vanishing-leading-term discriminant from the input, independently of initial conditions.
- `admittedTimeDeformationLaw4` — Construct and certify local rank-one determinant transports, including the genus-zero logarithmic dlog model, and state the exact gluing datum required for global fixed-determinant output.

**Tests and falsification cases**

- `admittedTimeDeformationCheck1` (computation) — Five ordered logarithmic points on ℙ¹ have two time moduli after quotient by PGL₂: 5 − 3 = 2; their configuration is independent of initial conditions.
- `admittedTimeDeformationCheck2` (computation) — A change τ = 2t multiplies the displayed horizontal generator by 1/2; retaining its coefficient unchanged gives a different parametrized system.
- `admittedTimeDeformationCheck3` (non-example) — Two solutions with different movable pole sets use the same Bθ. A base that deletes one solution's poles fails this requirement.
- `admittedTimeDeformationCheck4` (non-example) — On a fixed positive-genus curve, changing a line connection by tη with nonzero holomorphic η generally changes a period and hence its rank-one monodromy. Fixed residues alone cannot certify a strong determinant transport.

**Supporting constructions owned by this target.**

- Construct the category of finite-dimensional complex locally ringed spaces locally modeled by coherent ideal quotients of polydiscs, retaining nilpotents; prove local-ring morphism, open restriction, coherent closed quotient, open gluing, product and fibre-product universal properties. Use CKG K3 holomorphic germs and RealAnalyticGeometry R3.2 item 0 for the local coherent calculus. Construct analytification of separated finite-type complex schemes by affine embeddings and gluing, proving independence of presentation, functoriality, open/closed and fibre-product comparisons, analytification of coherent and finite locally free sheaves, differentials, meromorphic connections and their pullbacks. Identify smooth analytic spaces of a fixed complex dimension n whose underlying spaces are Hausdorff and second countable with the native CKG manifold carrier modeled on ℂⁿ. For a smooth space with components of different dimensions, make this comparison separately on each open-and-closed dimension locus. Verify the dimension and topological hypotheses for each manifold object used in the nonlinear-connection and meromorphic-moduli constructions. General analytic spaces retain their stated separation properties; smoothness alone does not imply Hausdorffness or a single global model dimension. Use ComplexCurveModuli D2.0 only as the manifold instance comparison. Construct analytic properness/base-change and the proper algebraic-to-analytic comparison used by the moduli families. Algebraic construction takes place over finite-type Noetherian complex bases; arbitrary holomorphic maps from smooth complex bases are handled by this analytic pullback theorem. Every singular Betti target uses this same carrier.

- Consume the stable pointed-curve atlases at their stability hypotheses. Construct the genus-zero one- and two-marked quotient groupoids with their actual PGL₂ stabilizers, the required finite-jet torsors and coefficient-open loci, and their compatible smooth atlases rather than treating them as stable-curve coarse charts. Construct local punctured-family topological markings by relative smooth trivialization preserving marked sections and compare them on overlaps. Construct rank-one determinant transport directly from the flat rank-one local system, prescribed logarithmic lattices, polar primitives and dlog formulas; this construction precedes 2.1 and does not depend on the later rank-r Riemann–Hilbert map.

- Prove the analytification functor and coherent comparison in SGA1 XII1.1–3.1 on complex finite-type schemes, retaining nilpotents. For a proper morphism f:X→S and coherent F, prove (R^q f_*F)^an≅R^q f^an_*(F^an), naturally in F, for q≥0, and its compatibility with the base-change maps under their stated hypotheses (SGA1 XII4.2). For an absolute proper complex X prove Coh(X)≃Coh(X^an), with the coherent cohomology comparison (XII4.3–4.4); the projective step uses Serre no.12 Theorems1–3, and the proper step uses Chow and dévissage. Transport meromorphic connection data through the O-linear principal-parts/jet presentation of a Leibniz operator, not by falsely treating ∇ as an O-linear map. These comparisons supply the algebraic/holomorphic curve and bundle objects used in the RH construction. They do not assert algebraization of an arbitrary analytic family over a nonproper analytic base.

- For a smooth proper curve family with a nonempty relative marked divisor, prove that the divisor has positive degree on every geometric fiber and is relatively ample. Locally on the Noetherian algebraic base choose a sufficiently positive multiple that is relatively very ample, construct the projective embedding used by the Quot presentations, and record comparisons of the chosen powers and bases of sections by passing to a common positive multiple. The comparison of the resulting moduli presentations is proved after their construction in 1.3. Thus projectivity and a polarization for the bounded construction are obtained from the stated input; they are not silently added to every proper family.

*Needs:* Internal: 1.1; [Marked-curve charts](#dependency-curves) (ComplexCurveModuli D0.3, D3–D5; SchemeAndStackFoundations 4.15); [Complex manifolds, holomorphic bundles and observations](#dependency-complex) (K1; K3.0; K3.HolomorphicStalk; K3.MeromorphicGermField; K4; K7.1); [Coherent analytic module sheaves](#dependency-analytic-coherence) (R3.2 item 0); [Cohomology, duality and curve degree](#dependency-cohomology) (2.2; 2.6; 2.20; 3.3); [Proper coherent direct images and base change](#dependency-proper-cohomology) (Layer C); [Chow lemma for the proper GAGA proof](#dependency-chow) (4.12, chow_lemma subtarget only; prerequisites 0.9 and 4.11).

**Source scope and owned proof:** I23 §5 constructs the curve/jet/coefficient time scheme and §§10–11 use it. The general determinant-transport and coordinate-descent interfaces are additional owned obligations; they cannot be replaced by a claim that every determinant family admits a lift.

<a id="target-1-3"></a>
### 1.3 Stable moduli on all bundle types

**General theory.**

Construct the stack of stable objects of §1.1 over the admitted time problem §1.2, its scalar rigidification and its relative coarse moduli space. Use bounded parameter spaces of filtered bundles and impose the connection and factorized-structure relations. Prove the moduli universal property and finite type, and prove separatedness and quasi-projectivity for the relative coarse (rigidified phase) family in the source-supported setting. No separatedness assertion is made for the unrigidified stable stack with Gm inertia. Work with all permitted bundle types. A matrix presentation covers only its actual locus. Construct an étale universal-object cover and descend all subsequent tensors; do not assume a universal vector bundle on the coarse space.

In unfixed-determinant mode the stable scalar inertia is Gm. With a specified determinant identification it is μr; determinant fixing and rigidification are different operations. Construct the determinant morphism and the comparison with the moduli problem having specified determinant, reserving the smoothness and relative dimension calculation for §1.5. Establish the needed coarse-space base-change comparison through these local gerbe presentations. Nonemptiness is an additional consumer assertion, not a theorem for every numerical input. Locally empty moduli are retained; the family becomes a surjective analytic submersion only after restricting B to its open nonempty-fiber locus.

**Hypotheses**

- The numerical and admitted local data of 1.1 and the time family of 1.2; a fixed stability chamber; all bundle types. No nonemptiness assumption is imposed on the construction.

**API**

- `stableDecoratedModuliLaw1` — Identify geometric points and families up to the appropriate arrows, with an explicit coarse-map universal property.
- `stableDecoratedModuliLaw2` — Prove restriction and admissible base-change comparisons, including determinant fibers.
- `stableDecoratedModuliLaw3` — Compare framed charts with their actual moduli loci. Fixed splitting-type strata on ℙ¹ are locally closed; the balanced locus is open, including the trivial-bundle locus in degree zero. Prove each inclusion and closure comparison, and record the complement of every chart used.
- `stableDecoratedModuliLaw4` — For a change of weights, identify the actual common stable locus and the resulting comparison there; do not export an automatic global isomorphism.

**Tests and falsification cases**

- `stableDecoratedModuliCheck1` (non-example) — A stable object may have scalar automorphisms before rigidification. A set-valued quotient that claims all stabilizers were trivial fails this example.
- `stableDecoratedModuliCheck2` (characterisation) — A family can leave a trivial-bundle chart by bundle jumping while remaining in the moduli space. Its phase path is not declared singular for that reason.
- `stableDecoratedModuliCheck3` (computation) — In the extension family 0 → O(−1) → E_t → O(1) → 0, E₀ = O(−1) ⊕ O(1) while E_t = O ⊕ O for t ≠ 0. The two splitting strata pull back to {0} and its complement in A¹; the first is not open. The full connection moduli must retain such bundle jumps on the permitted connection locus.
- `stableDecoratedModuliCheck4` (characterisation) — An admitted totally ramified generic local model is irreducible as a formal differential module, hence a global connection containing it has no proper ∇-invariant subbundle and is stable for every weight (I23 Remark 2.9). This assertion is not exported to arbitrary ramified blocks.

**Supporting constructions owned by this target.**

- After proving boundedness of the filtered connection objects, construct the finite-type parameter schemes using SSF4.14, specify the reductive framing group, linearization and Hilbert–Mumford comparison with the chosen rational parabolic weights, and prove finite generation and the required stable geometric/affine categorical quotients. Prove the actual moduli universal property, separatedness and quasi-projectivity in the I23-supported scope. Construct central Gm rigidification by fppf quotient of Isom sheaves and stackification, prove its gerbe and base-change universal properties, and compare with the GIT coarse family; separately compare μr inertia when a determinant identification is included. State exactly where finite-inertia Keel–Mori applies. Prove scalar action on each descended tensor is trivial and check coarse/base-change comparisons on these presentations.

- For each finite-type algebraic curve/time chart, prove that its analytified bounded framed Quot presentation represents the corresponding analytic families after arbitrary holomorphic base change from the smooth complex bases allowed in 1.2. Establish local analytic generation after a sufficiently positive twist, coherent analytic pushforward/base change, the holomorphic framing and factorized-connection equations, and descent of the actual relation. This is the analytic moduli comparison needed by 2.3, rather than a global algebraization claim for the new base. The analytic quotient is identified with the analytification of the constructed GIT quotient through these presentation maps. Framed deformation and versality comparisons using the actual deformation complex are proved in 1.4, after this GIT construction, to avoid a dependency cycle.

- Compare the bounded Quot/GIT presentations arising from the positive powers and projective embeddings constructed in 1.2. First construct both presentations and their actual functor-of-points maps, then use their proved moduli universal properties to construct inverse comparison maps and the composition/base-change laws. This proves independence of the auxiliary polarization and framing choices within the stated curve stability problem.

*Needs:* Internal: 1.1, 1.2; [Quot/Hilbert and parameter schemes](#dependency-quot) (4.14); [Stacks, inertia and restricted coarse-space criteria](#dependency-stacks) (1.18–1.23); [Quotient predicates](#dependency-quotient-predicates) (1.17); [Elementary deformation theory](#dependency-deformation) (4.2–4.6).

**Source scope and owned proof:** I23 Theorem 5.1 and §§7–10; fixed-determinant and coarse-base-change comparisons are explicitly constructed extensions of the displayed moduli problem.

<a id="target-1-4"></a>
### 1.4 The differential-operator deformation complex and trace pairing

**General theory.**

Construct the deformation complex from infinitesimal endomorphisms preserving the local structures, permitted variations of the connection, and all relations of the factorized ramified structures. Begin with the two-term connection complex G•. In the ramified case retain the full cone F• = Cone(G• → S•ram[1])[−1], including degrees 0, 1 and 2, both differentials and the local factorization terms. A two-term replacement requires a proved quasi-isomorphism. Identify infinitesimal automorphisms, tangent vectors and obstruction classes by hypercohomology and construct the trace/Serre-duality pairing.

The commutator with ∇ is a ℂ-linear first-order differential operator and is generally not O-linear. Work with sheaves of ℂ-vector spaces, coherent underlying terms, Čech totalization and the actual termwise duality calculation; do not silently place this differential in D(QCoh). Prove presentation and cover independence by chain maps and quasi-isomorphisms. Construct the trace morphism to the determinant deformation complex and its trace-free fiber, with signs and local factorization compatibility. This target supplies the comparison maps; §1.5 must prove the resulting smooth determinant-map and dimension statements. Scalar gauge automorphisms and genuine infinitesimal determinant variation are separate directions.

**Hypotheses**

- The stable moduli problem of 1.3 with the admitted filtrations and factorized ramified relations; either unfixed determinant or its specified fiber. The complex and pairing are outputs.

**API**

- `decoratedDeformationComplexLaw1` — Give the differential, local compatibility equations and the map from an infinitesimal family to its cocycle.
- `decoratedDeformationComplexLaw2` — Prove gauge-change and coboundary compatibility in both directions.
- `decoratedDeformationComplexLaw3` — Construct the trace-free/determinant decomposition and the dual complex with its signs.
- `decoratedDeformationComplexLaw4` — Prove naturality of the pairing under input isomorphisms and admissible base change.

**Tests and falsification cases**

- `decoratedDeformationComplexCheck1` (compatibility) — An infinitesimal gauge change by u changes a connection representative by the commutator differential of u; its tangent class is zero.
- `decoratedDeformationComplexCheck2` (characterisation) — Without determinant identification stable scalar automorphisms have a one-dimensional infinitesimal direction. Fixing the identification removes that direction in characteristic zero, although finite μr remains until rigidification; this does not remove the 2g determinant deformation directions by itself.
- `decoratedDeformationComplexCheck3` (computation) — With ω = dq ∧ dp, the ordered tangent pair (∂q, ∂p) has pairing +1 and the reversed pair −1; a reversed trace convention must be corrected before transport formulas are used.

**Supporting constructions owned by this target.**

- Build the total Čech complex in sheaves of ℂ-vector spaces, with coherent underlying terms and the actual C-linear first-order differentials, then prove refinement, cover independence, cone signs, trace pairing and termwise Serre-duality compatibility. Do not apply D(QCoh) to a non-O-linear differential. Identify automorphisms, tangents and obstructions by the actual lifting cocycles, for the ramified three-term cone including all factorization relations. Extend the elementary small-extension framework to the finite-dimensional square-zero kernels needed here, proving linearity, direct sums and base-change naturality rather than reading them into SSF4.5.

- For the bounded deformation complexes on a proper complex curve, construct analytification of each differential operator through its finite-order principal-parts presentation. Prove the principal-parts analytification comparison and compatibility with composition, so that the analytified differential still squares to zero. Apply proper coherent GAGA term by term and the convergent hypercohomology spectral sequences to obtain the algebraic–analytic hypercohomology comparison, including the actual local ramified cone. This follows the proof route of Deligne II6.6. The complex is a complex of sheaves of complex vector spaces with coherent O-module terms; its connection differential is not treated as an O-linear map in the derived category of coherent O-modules. Relative base-change claims are separate and retain the exact flatness and cohomological hypotheses of the source being used.

- For the relative family p:C→B retain the p⁻¹O_B-module action on the sheaves and the p⁻¹O_B-linearity of the connection differential. It is not O_C-linear. Construct the Čech total complex, trace, principal-parts comparisons and every claimed base-change map with that base-module action, then prove compatibility. Absolute ℂ-linear cohomology is its fiberwise comparison, not a substitute for this relative structure.

- Construct framed infinitesimal and versal charts from the actual lifting equations and the deformation complex. Prove the tangent/obstruction and lifting comparison with the moduli already constructed by bounded GIT in 1.3. This comparison is not used to assume that earlier moduli construction.

*Needs:* Internal: 1.3; [Cohomology, duality and curve degree](#dependency-cohomology) (2.2; 2.6; 2.20; 3.3); [Elementary deformation theory](#dependency-deformation) (4.2–4.6).

**Source scope and owned proof:** I23 §6, (6.9), Proposition 6.3 and §7, Proposition 7.2. The fixed-determinant fiber and its compatible trace-free complex are explicit owned comparisons.

<a id="target-1-5"></a>
### 1.5 Smoothness, dimension and the determinant fiber

**General theory.**

Use §1.4 to prove obstruction vanishing and smoothness of the stable moduli family in the admitted domain. Identify its relative tangent bundle by first hypercohomology. For unfixed determinant and a nonempty stable fiber, derive dim M_b = 2r²(g−1)+2+r(r−1)deg P. The local trace polar parts are fixed in this formula.

For the fixed-determinant export, construct the determinant moduli of line connections with those trace polar parts, locally an affine bundle of rank g over Picᵈ(C_b), and prove that its tangent complex is the regular de Rham complex O_C → Ω¹_C. Over ℂ, build a compatible trace map and scalar section using 1/r at the full deformation-complex level, including ramified relations. Prove the induced determinant map is smooth on the stated stable locus, with surjective tangent map onto a 2g-dimensional determinant tangent space. Identify the specified-determinant coarse family with the relevant fiber after its gerbe comparison. Only then deduce dim M_b^det = 2(r²−1)(g−1)+r(r−1)deg P. Prove that the trace pairing splits orthogonally into the trace-free and scalar directions and is nondegenerate on the fixed-determinant tangent space. Rank-one fixed-determinant fibers are zero-dimensional.

The fixed-determinant dimension and symplectic theorems use the deformation-functor comparison, smooth determinant map and orthogonal trace splitting constructed in 1.5. Prove these comparisons on the full stated complex before restricting to a determinant fiber. The unfixed-determinant theorem and the genus-zero dimension agreement have the scopes stated above.

**Hypotheses**

- The moduli construction of 1.3 and actual complex and trace pairing of 1.4; the admitted local models over ℂ.
- Dimension assertions concern nonempty stable fibers. The fixed-determinant conclusion additionally requires the determinant-map comparison proved in this target.

**API**

- `smoothModuliAndDeterminantFiberLaw1` — Identify the relative tangent sheaf and prove base-change compatibility for tangent and obstruction calculations.
- `smoothModuliAndDeterminantFiberLaw2` — Construct the determinant deformation map, its scalar section and the trace-free fiber, including all local compatibility equations.
- `smoothModuliAndDeterminantFiberLaw3` — Prove smoothness and orthogonal trace decomposition before subtracting 2g determinant directions.
- `smoothModuliAndDeterminantFiberLaw4` — Return separate unfixed- and fixed-determinant dimension theorems with their exact hypotheses.

**Tests and falsification cases**

- `smoothModuliAndDeterminantFiberCheck1` (computation) — Genus zero, rank two and degree four give −8 + 2 + 8 = 2; structural degree five instead gives 4.
- `smoothModuliAndDeterminantFiberCheck2` (non-example) — Fixing the determinant in positive genus removes 2g directions when the determinant-map comparison applies; the genus-zero coincidence cannot be exported unchanged.
- `smoothModuliAndDeterminantFiberCheck3` (computation) — At r = 1 and g = 1 the unfixed-determinant formula gives 2, and fixing the entire line connection gives 0. The rank-zero input that would incorrectly give 2 is outside the domain.
- `smoothModuliAndDeterminantFiberCheck4` (computation) — For g=1, r=2 and deg P=1, the unfixed formula gives 4 and the fixed-determinant formula gives 2 whenever the corresponding stable fiber is nonempty and the comparison holds; removing only the scalar stabilizer would miss this difference.

**Supporting constructions owned by this target.**

- Construct the fppf relative Picard algebraic space for the projective flat finitely presented complex curve families used here, over locally Noetherian bases, under the universal-functions condition O_B≅p_*O_C after every base change. Include coherent base-change comparison and the line-bundle deformation argument establishing relative smoothness by the affine square-zero tests and relative cohomological-dimension theorem specified below; state identity-component and constant-dimension hypotheses explicitly, retaining nonreduced curve and base tests. JacobianChallenge C–D supplies only the coherent floor and its fixed-field geometrically integral specialization. For smooth marked curves construct the relative Picᵈ, its rigidified Poincaré comparison and the affine torsor of line connections with fixed compatible trace polar parts. Prove its regular de Rham tangent complex, dimension 2g, and the full trace/scalar splitting and smooth determinant map before exporting a fixed-determinant dimension or symplectic theorem. The nonreduced-curve Picard subtheorem supplies 5.1 without using any Painlevé-specific fact.

- Test formal smoothness locally on affine square-zero thickenings T₀↪T with quasi-coherent ideal I. Flatness identifies the ideal of C_T0 in C_T with p*I. Construct the obstruction in H²(C_T0,p*I), the torsor of isomorphism classes of lifts with a specified restriction isomorphism under H¹(C_T0,p*I), and their infinitesimal automorphisms from H⁰. Prove R^q p_*(p*I)=0 for q>1 by proper relative dimension at most one and use the affine base and Leray to obtain H²=0. Handle general test bases by open/fppf descent and apply the local finite-presentation criterion to deduce smoothness. Do not infer absolute H² vanishing on a nonaffine base from fiber dimension. See PICREL tags 0D2C, 0DNI, 0DPJ and 0DPK.

*Needs:* Internal: 1.3, 1.4; [Cohomology, duality and curve degree](#dependency-cohomology) (2.2; 2.6; 2.20; 3.3); [Elementary deformation theory](#dependency-deformation) (4.2–4.6); [Picard over a field and Picard foundations](#dependency-field-picard) (JacobianChallenge Layer D; SchemeAndStackFoundations 1.1, 2.6, 3.4, 4.6, 4.14); [Proper coherent direct images and base change](#dependency-proper-cohomology) (Layer C).

**Source scope and owned proof:** I23 Theorem 7.5 and its determinant-obstruction argument; fixed-determinant smoothness, full cone splitting and orthogonality are the extensions proved in 1.5 and used by its fixed-determinant conclusions.

<a id="target-1-6"></a>
### 1.6 Early finite-flat unfolding and the closed symplectic form

**General theory.**

Construct the relative trace two-form on the moduli family, descend it from the universal-object cover and prove nondegeneracy using §1.4 and §1.5. Prove closedness by the following auxiliary construction here, before any limiting-system or confluence application. Over a smooth integral auxiliary base H, replace the fixed polar divisor by the finite-flat divisors of I23 §8. At a ramified point use ∏ⱼ₌₁ᵐ⁻¹(z−hʳqⱼ)(z−hʳ), with qⱼ distinct, nonzero and different from 1. Construct the moduli algebraic space of simple connections with the unfolded factorized local structures, an étale universal-object cover, the relative deformation complex and trace form. Reapply the boundedness and deformation arguments to this new family; it is not covered merely by §1.1's disjoint marked sections.

Prove smoothness over H and identify the original stable moduli, complex and form with the appropriate open part of the central fiber. On the dense open parameter set with generic separated poles, construct both quasi-isomorphisms from the diagonal deformation complex to the unfolded complex and the logarithmic parabolic complex, respecting trace forms. Prove closedness of the logarithmic trace form by the Čech cup-product/trace calculation and gauge descent and transfer it through these two comparisons. The relative sheaf of three-forms on this smooth family over an integral base is locally free, and restriction to the indicated dense open detects zero. Deduce d_relative ω=0 on the whole family, restrict to the central stable locus and descend. A later nonreduced base change uses this proved identity; density on a nonreduced base is not a substitute.

The fixed-determinant result is the pullback of this closed form to the determinant fiber, with nondegeneracy supplied only after §1.5's orthogonality comparison. No scalar Hamiltonian or classification of phase surfaces enters this construction.

**Hypotheses**

- §§1.3–1.5 in the admitted domain. Smoothness, the auxiliary simple-connection family, generic comparison maps and closedness are outputs.
- For the fixed-determinant symplectic export, the determinant-fiber comparison and nondegeneracy gate in 1.5.

**API**

- `closedRelativeTraceFormLaw1` — Construct the finite-flat unfolding, the moduli of simple connections and the universal-object cover, and identify their central fibers.
- `closedRelativeTraceFormLaw2` — Construct both diagonal-complex comparison maps and prove compatibility with the trace pairing.
- `closedRelativeTraceFormLaw3` — Prove nondegeneracy and closedness independently, including descent and later base-change compatibility.

**Tests and falsification cases**

- `closedRelativeTraceFormCheck1` (characterisation) — A skew pairing which vanishes identically is closed but is not symplectic; nondegeneracy must follow from the actual duality computation.
- `closedRelativeTraceFormCheck2` (computation) — For r = 2, local order 2 and q₁ = 2, the unfolding equation is (z − 2h²)(z − h²). Its fiber at h = 0 is z² and at h = 1 is (z − 2)(z − 1); modulo h² it is again z². Check the central and pulled-back complexes and forms, rather than identifying this family with fixed distinct sections.
- `closedRelativeTraceFormCheck3` (dependency check) — Delete all later applications and every scalar equation: the finite-flat unfolding, its two generic comparison maps and the closedness proof must still be stated and constructible here.

*Needs:* Internal: 1.3, 1.4, 1.5; [Cohomology, duality and curve degree](#dependency-cohomology) (2.2; 2.6; 2.20; 3.3); [Elementary deformation theory](#dependency-deformation) (4.2–4.6); [Algebraic vector bundles and finite locally free sheaves](#dependency-bundles) (L0A–L0C; L1A–L1B; L2A–L2B).

**Source scope and owned proof:** I23 Theorem 8.1, Propositions 8.2–8.3 and the complex preceding (8.2). The meromorphic-moduli theory contains every construction needed by that unfolding proof.

<a id="layer-2"></a>

## Layer 2: General isomonodromy and logarithmic Riemann–Hilbert correspondence

<a id="target-2-1"></a>
### 2.1 Strong integrable extensions and the actual horizontal splitting

**General theory.**

For a time tangent at a moduli point, construct a strong integrable extension of the universal connection over the corresponding dual-number deformation. On the moving total curve X let D be the sum of the marked relative Cartier divisors with coefficient one, formed on the smooth ambient family before pullback to the infinitesimal base. The allowed total-form pole filtration is Ω¹_X(log D) ⊗ O_X(P−D), relative to any fixed auxiliary base. Require integrability and preservation of the kernel lattices attached to the local filtrations, namely kernels of E → E|_{mᵢaᵢ}/Fᵢ,k with the relevant structural thickening and the additional factorized relations. Preserving flags separately on each fiber is insufficient. Prove the coordinate lemma that, in a moving polar coordinate z, the allowed forms are generated by dz/zᵐ and dε/zᵐ⁻¹; the time coefficient is regular at a logarithmic point.

Prove existence and uniqueness up to the specified isomorphism restricting to the identity on the central fiber, within this strong extension class. Glue the local lifts and descend from the universal-object cover. Construct the actual O-linear splitting h:π*TB→TM and prove dπ∘h=id. In fixed-determinant mode prove that taking determinant of the constructed extension agrees with the certified rank-one transport of §1.2, so that h is tangent to the moving determinant fiber. This is a comparison theorem, not a claim that an arbitrary determinant section is preserved. Existence of h, integrability and preservation of the trace form are not input axioms.

**Hypotheses**

- The admitted time and moduli constructions of §§1.1–1.5 and a time tangent vector. The total pole filtration and kernel-lattice relations specify the class of extensions being constructed.
- For fixed determinant, §1.2 supplies the verified rank-one time transport and §1.5 supplies the determinant-fiber comparison.

**API**

- `strongHorizontalSplittingLaw1` — Construct the lift from a time tangent and prove additivity and O-linearity.
- `strongHorizontalSplittingLaw2` — Prove restriction, base-change and input-isomorphism naturality of the lift.
- `strongHorizontalSplittingLaw3` — Compare lifts computed with different local coordinates, formal diagonalizations and universal-object covers.
- `strongHorizontalSplittingLaw4` — Identify the induced horizontal subbundle and its projection isomorphism to π*TB.
- `strongHorizontalSplittingLaw5` — Prove determinant functoriality of the strong extension and tangency to a certified moving determinant fiber.

**Tests and falsification cases**

- `strongHorizontalSplittingCheck1` (characterisation) — A zero time tangent lifts to zero; adding an arbitrary vertical vector would violate uniqueness of the integrable extension.
- `strongHorizontalSplittingCheck2` (compatibility) — Rescaling the time tangent by 2 rescales its lift by 2, while changing the time coordinate to 2t rescales the normalized generator by 1/2.
- `strongHorizontalSplittingCheck3` (non-example) — The zero map cannot be a splitting over a nonzero time tangent because dπ ∘ 0 = 0 ≠ id.
- `strongHorizontalSplittingCheck4` (non-example) — At m=1 a proposed time term dε/z lies outside the allowed total-form module in a moving polar coordinate; fiberwise flag preservation cannot repair that violation.

**Supporting constructions owned by this target.**

- Using 1.1 formal carriers and 1.4 actual deformation cocycles, construct the strong infinitesimal total connection over each admitted dual-number time direction, with pole module Ω¹(log D)⊗O(P−D), kernel lattices and factorized relations. Prove existence and uniqueness of the deformation class with its specified central identification, preserve the determinant transport, and prove overlap/descent comparisons; scalar infinitesimal automorphisms must remain accounted for before rigidification. 2.2 proves mixed-time flatness and trace-form preservation separately, and 2.3 proves coherent arbitrary holomorphic base change. A formal oper isomonodromy groupoid or a fibrewise formal normal form is not the holomorphic time splitting.

*Needs:* Internal: 1.1, 1.2, 1.3, 1.4, 1.5, 0.1; [Elementary deformation theory](#dependency-deformation) (4.2–4.6).

**Source scope and owned proof:** I23 Definition 10.1, (10.1), Lemmas 10.3–10.6, Propositions 10.7/10.10 and (11.2); determinant compatibility and intrinsic pole-filtration comparison are owned proof obligations.

<a id="target-2-2"></a>
### 2.2 Flatness, trace-form preservation and the closed total form

**General theory.**

Compare the two-parameter strong extensions and their mixed infinitesimal term to prove h([v,w])=[h(v),h(w)]. Prove that holomorphic integral sections carry the corresponding strong integrable total connections. This bracket calculation uses the algebraic extension comparison, not a global Riemann–Hilbert theorem.

Use the actual trace cocycles and strong-extension comparison to prove that the constructed horizontal variation preserves the relative symplectic form ω. Flatness of an arbitrary splitting alone would not imply that assertion. Define Ω(v,w)=ω(v−h(dπv),w−h(dπw)), prove dΩ=0 and ker Ω=im h, and deduce preservation of ω by local horizontal transport. The generic differential-form equivalence in NonlinearConnections §0.6 can organize this final calculation, but it cannot supply trace-form preservation as an unproved premise. In a one-dimensional time chart, only after a symplectic trivialization and local exactness have been supplied, derive Ω=dq∧dp+dH∧dt in relative dimension two, and the analogous sum in higher even dimension. Scalar Hamiltonians are local primitives attached to charts.

**Hypotheses**

- The actual strong splitting of 2.1 and the relative symplectic form of 1.6, with the determinant gate where applicable. Flatness and preservation of that form are outputs.

**API**

- `flatSymplecticIsomonodromyLaw1` — Compute the mixed two-parameter extension term and obtain the bracket identity and flat horizontal distribution.
- `flatSymplecticIsomonodromyLaw2` — Recover the relative form by vertical restriction and the horizontal distribution as the kernel.
- `flatSymplecticIsomonodromyLaw3` — Prove admissible base-change naturality for the relative form, the actual splitting and the closed total form.
- `flatSymplecticIsomonodromyLaw4` — Compare two Hamiltonian potentials in a fixed chart: their difference is constant along connected phase fibers.
- `flatSymplecticIsomonodromyLaw5` — State the extra generator term for a time-dependent symplectic change of coordinates through equality of the extended two-forms.

**Tests and falsification cases**

- `flatSymplecticIsomonodromyCheck1` (non-example) — For H = p²/2, contraction with ∂t + p∂q annihilates dq ∧ dp + p dp ∧ dt; using the opposite sign does not.
- `flatSymplecticIsomonodromyCheck2` (compatibility) — H and H + t² give the same vertical vector field and extended two-form, but different scalar functions.
- `flatSymplecticIsomonodromyCheck3` (non-example) — On a symplectic fiber, Ω has no nonzero vertical kernel vector; degenerating ω to zero would fail this characterization.
- `flatSymplecticIsomonodromyCheck4` (non-example) — On ℂ²×ℂ with ω=dq∧dp, h(∂t)=∂t+q∂q is flat because the base has dimension one, but its flow scales ω. This fails the trace-form preservation obligation.

*Needs:* Internal: 1.4, 1.6, 2.1, 0.6; [Complex manifolds, holomorphic bundles and observations](#dependency-complex) (K1; K3.0; K3.HolomorphicStalk; K3.MeromorphicGermField; K4; K7.1).

**Source scope and owned proof:** I23 Theorem 11.6, Definition 11.4 and Corollary 11.8. The flatness proof and the trace-form variation are separate obligations.

<a id="target-2-3"></a>
### 2.3 Naturality and coherent change of presentation

**General theory.**

For isomorphic admitted decorated time problems construct compatible isomorphisms of their stacks, rigidifications and phase families, preserving the trace pairing, ω, h and Ω. Cover finite-jet coordinate changes, formal frame changes, ramified root changes with descent data, universal-object covers and compatible rank-one determinant transports. Construct the pullback comparison for a holomorphic map f:B′→B between smooth complex bases and prove that the resulting horizontal vector at (b′,m) is (v′,h_m(df(v′))). The corresponding algebraic stack pullback remains meaningful for general test bases, but analytic submersion statements require a smooth complex base.

Record the natural comparison isomorphisms for identity and composite base changes, the associativity pentagon, the identity triangles and compatibility with 2-isomorphic presentation arrows. On the rigidified phase spaces these descend to the required equalities/cocycle laws. Thus the construction is pseudofunctorial before rigidification and functorial up to the specified canonical comparisons afterward. Changes of determinant, weights, labels or formal local type that are not isomorphisms of the input remain genuine parameter changes or correspondences on stated domains. A time-dependent gauge matrix changes a formula but the compatible object and its transported tensors remain identified.

**Hypotheses**

- Isomorphisms of the same admitted decorated time problem and base maps preserving its specified data; the constructions of §§1.1–2.2.
- Analytic output is over smooth complex bases; coarse-space comparisons use the scalar-gerbe descent from 1.3. Non-isomorphic parameter changes are not included among presentation arrows.

**API**

- `coherentModuliNaturalityLaw1` — Give the stack-level comparison 1-isomorphisms and their coherent 2-isomorphisms; descend the corresponding phase-space comparisons.
- `coherentModuliNaturalityLaw2` — Prove equality of pullback splitting and forms with the outputs constructed after base change.
- `coherentModuliNaturalityLaw3` — Preserve source and target maps of the NonlinearConnections morphisms and specify the exact domains of all parameter correspondences.

**Tests and falsification cases**

- `coherentModuliNaturalityCheck1` (compatibility) — For f:B′→B and g:B″→B′, compare direct (f∘g)* construction with g*f* and check the three-composition pentagon rather than choosing unrelated identifications.
- `coherentModuliNaturalityCheck2` (non-example) — A weight wall crossing changes the stable locus and is not a presentation isomorphism unless an actual common stable domain has been specified.
- `coherentModuliNaturalityCheck3` (compatibility) — The base map t=s² pulls h(∂t) back to h′(∂s)=(∂s,2s h(∂t)); at s=0 the horizontal vector still projects to ∂s, so the base map need not be a local isomorphism.

*Needs:* Internal: 1.1, 1.2, 1.3, 1.4, 1.6, 2.1, 2.2, 0.1; [Stacks, inertia and restricted coarse-space criteria](#dependency-stacks) (1.18–1.23).

**Source scope and owned proof:** I23 Propositions 10.7 and 10.10 supply uniqueness used by the comparison. Full intrinsic base-change/2-coherence is an owned theorem target, not a quotation from a coordinate formula.

<a id="target-2-4"></a>
### 2.4 General construction theorem and reusable export

**General theory.**

Assemble §§1.1–2.3 into a construction from each admitted decorated time problem to its rigidified stable phase family and, over the open nonempty-fiber part of a smooth analytic time base, a holomorphic flat symplectic nonlinear connection (π:M→B,h,ω) in NonlinearConnections §§0.1 and 0.6, together with its closed total form Ω. The inputs contain curve and local connection data, a stability chamber and the determinant mode; they do not contain h, a scalar differential equation or a classification of surfaces. The result applies in arbitrary genus and admitted rank/polar degree for unfixed determinant; fixed-determinant export requires the separately proved comparison in §1.5 and the certified time transport in §1.2.

Give a single consumer certificate listing local-model admission, the actual time base, determinant verification, weight choice and nonemptiness evidence. Return the geometric carrier, the constructed tensors, dimension theorem at its exact scope, naturality and coherent pullback laws. A consumer proves only these admission conditions and its further specialized results. In particular neither relative dimension two nor one-dimensional time belongs to this construction theorem. Completeness, proper Riemann–Hilbert comparison, chosen observables, scalarization and distinguished solutions require their own downstream hypotheses and proofs. The construction theorem has the stated admission hypotheses and uses the named preceding construction and comparison theorems.

**Hypotheses**

- The admitted geometric input and time problem of 1.1–1.2; stable construction of 1.3–1.6 and the actual h, flatness and naturality from 2.1–2.3.
- Restrict to the open nonempty-fiber time locus for a surjective nonlinear-connection carrier; a consumer must provide nonemptiness if its whole proposed base is claimed.
- Fixed-determinant export additionally passes the independent determinant-fiber and rank-one transport gates.

**API**

- `meromorphicModuliToNonlinearConnectionLaw1` — Export a construction theorem, not an alias for a specialized phase space: its conclusion supplies π, h, ω, Ω and all their laws from the admitted geometric input.
- `meromorphicModuliToNonlinearConnectionLaw2` — Supply the common consumer certificate and distinguish construction, nonemptiness and completeness obligations.
- `meromorphicModuliToNonlinearConnectionLaw3` — Prove reuse under base change and presentation equivalence through 2.3, without rerunning a case classification.

**Tests and falsification cases**

- `meromorphicModuliToNonlinearConnectionCheck1` (dependency check) — Removing every specialized consumer, every relative-dimension-two selection and every classical equation leaves the input/output statement and all local prerequisites intact.
- `meromorphicModuliToNonlinearConnectionCheck2` (computation) — Five logarithmic points on ℙ¹ in rank two, fixed determinant and a nonempty stable locus give relative dimension 4 and a two-dimensional configuration base; the construction theorem must accept that input.
- `meromorphicModuliToNonlinearConnectionCheck3` (non-example) — A tuple of arbitrary formal singularities is not admitted merely because its dimension formula happens to be positive; each local model and determinant/time certificate must be verified.
- `meromorphicModuliToNonlinearConnectionCheck4` (non-example) — A holomorphic flat symplectic connection can have incomplete horizontal curves; this export alone cannot justify global continuation of all initial conditions.

*Needs:* Internal: 1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 2.1, 2.2, 2.3, 0.1, 0.6.

**Source scope and owned proof:** This assembly and its consumer contract are the roadmap’s mathematical design. I23 supplies the admitted unfixed-determinant construction model; the additional determinant and coherence comparisons are proved in the specified meromorphic-moduli targets.

<a id="target-2-5"></a>
### 2.5 Marked logarithmic Betti family and the full Riemann–Hilbert map

**General theory.**

For the logarithmic subproblem of §1.1, construct the topologically marked family of representation varieties of the punctured curves, their affine conjugacy quotients and the prescribed-local-character subfamilies. Keep the residue-exponent parameter λ on the de Rham side and the exponential characteristic-polynomial parameter a=rh(λ) on the Betti side. Repeat the bounded construction of §1.3 over the simultaneous residue parameter space Λ, and prove its comparison with the I13 family; the horizontal splitting is relative to fixed λ, so varying λ is not a time direction. On a marking cover the Betti family is identified by transport with a fixed character variety times the time base. This gives complete transport along all admissible time paths even when the character variety is singular; no smooth Betti tangent bundle is required.

Construct the holomorphic Riemann–Hilbert map from the entire stable logarithmic parabolic moduli of §1.3, including allowed reducible and resonant objects and all bundle types. Define it through the local system of horizontal sections and its conjugacy-quotient class, and prove descent from the universal-object cover. Identify this logarithmic moduli problem, its weights and residue ordering with the exact moduli functor used by I13; a matrix-chart comparison is insufficient. Prove that the actual strong splitting of §2.1 is semiconjugate to the marked Betti transport at every point, using the total integrable extension with its logarithmic lattices and the analytic dependence of local solutions. Prove local horizontal-lift existence independently of Riemann–Hilbert invertibility. At resonant or reducible points the map may have positive-dimensional fibers and is not replaced by an inverse map.

For a certified determinant transport, show that taking determinant of monodromy agrees with the rank-one Riemann–Hilbert map and that the prescribed determinant is a transported Betti section. Export the Hausdorff locally compact marked target and the full semiconjugacy as inputs to NonlinearConnections §0.4, without asserting properness until §2.6 or deducing source completeness here.

**Hypotheses**

- The logarithmic local subproblem of 1.1, the admitted pointed-curve time problem and fixed residue exponents of 1.2, and the actual stable moduli and strong connection of 2.4.
- A topological marking cover of the punctured-curve family. Fixed-determinant conclusions require the verified determinant transport. The Betti target is allowed to be singular.

**API**

- `regularSingularRiemannHilbertSemiconjugacyLaw1` — Construct the marked affine Betti target with its complete path transport and state the retained residue/character parameter map.
- `regularSingularRiemannHilbertSemiconjugacyLaw2` — Prove the all-points Riemann–Hilbert semiconjugacy for the actual strong source splitting, including the map on singular target strata.
- `regularSingularRiemannHilbertSemiconjugacyLaw3` — Identify the full logarithmic moduli functor with I13 and prove compatibility with determinant, presentation change and analytic base change.

**Tests and falsification cases**

- `regularSingularRiemannHilbertSemiconjugacyCheck1` (non-example) — An open subset where Riemann–Hilbert is an isomorphism does not include all stable resonant or reducible objects. The semiconjugacy statement must be checked on their actual moduli points.
- `regularSingularRiemannHilbertSemiconjugacyCheck2` (compatibility) — Two residue parameters differing by allowed integer shifts can have the same local monodromy eigenvalues; retain λ rather than identifying the de Rham families over the a-parameter.
- `regularSingularRiemannHilbertSemiconjugacyCheck3` (compatibility) — A singular affine character variety is still a Hausdorff locally compact analytic space with complete marked transport; requiring a nonsingular target would discard exactly the strata needed by the proper-map continuation argument.

**Supporting constructions owned by this target.**

- Starting with CKG K4 on punctured curves, construct logarithmic extensions with chosen exponent lifts, parabolic flags and actual logarithmic lattices, prove the monodromy convention exp(−2πiλ), and prove the relevant regular-singular algebraic/analytic comparison. Include resonance, repeated residues and integer shifts of exponents with their lattice modifications; retain all bundle types. The equivalence keeps the lattice/flag data on the local-system side; forgetting them gives the generally noninjective RH map, not an inverse. Prove analytic family dependence and descent on the universal-object/marking covers.

- 2.5 constructs the finite-type representation varieties and their reductive affine conjugacy quotients using the proven 1.3 invariant-theory prefix, then applies 1.2 analytification and proves Hausdorff/local-compactness and marked product transport, including singular points. 4.2 constructs the wild/Stokes framing groupoid and quotient at its actual reductive or explicitly descended stages; unipotent local Stokes groups do not by themselves permit an arbitrary GIT quotient. Prove root/deck isotopy and ramified descent, stabilizer compatibility and all-stratum holomorphic maps. Nothing in SSF1.17 supplies these constructions automatically.

- Deligne II5.4 constructs the extension for a chosen section of ℂ→ℂ/ℤ; it explicitly does not make that canonical extension tensor-compatible. Consequently determinant compatibility is proved on the actual logarithmic lattices and residue sums, with any required integer lattice shifts. The characteristic polynomial of monodromy has eigenvalues exp(−2πiλ); equality of the monodromy matrix with exp(−2πi Res) up to conjugacy uses the appropriate nonresonance condition (II5.6) and is not asserted at every resonant point. Keep these distinctions in both the full RH map and the rank-one Cartesian determinant comparison.

*Needs:* Internal: 1.1, 1.2, 1.3, 2.1, 2.2, 2.3, 2.4, 0.3; [Complex manifolds, holomorphic bundles and observations](#dependency-complex) (K1; K3.0; K3.HolomorphicStalk; K3.MeromorphicGermField; K4; K7.1); [Marked-curve charts](#dependency-curves) (ComplexCurveModuli D0.3, D3–D5; SchemeAndStackFoundations 4.15).

**Source scope and owned proof:** I13 §2 (the marked Riemann–Hilbert map), §6 and §8 (isomonodromic deformation). Full comparison of its moduli functor and strong splitting with this framework, including exceptional strata and determinant compatibility, is explicitly owned.

<a id="target-2-6"></a>
### 2.6 Family properness in the exact logarithmic source scope

**General theory.**

For the full stable logarithmic parabolic moduli problem identified in §2.5, prove family properness of the marked Riemann–Hilbert map to the character family pulled back along the residue map rh:Λ_r^(n)(d)→A_r^(n). Use the complete exponent target (Rep_r(C,marked points)×_T T̃)×_{A_r^(n)}Λ_r^(n)(d), not only the generic smooth character locus. The exact source range is rank r≥2, n≥1, generic weights with stable=semistable, and rn−2r−2>0 when g=0, n>1 when g=1, n≥1 when g≥2. The residue space satisfies d+Σᵢⱼλⱼ^(i)=0. Prove the properness statement for families and its analytic base-change stability; properness of individual fibers alone is not the required result. The source theorem also supplies surjectivity and bimeromorphicity in this range, after the exact functor comparison.

For fixed determinant, construct the commutative determinant square on the de Rham and Betti moduli, prove the rank-one regular-singular Riemann–Hilbert isomorphism with the prescribed trace residues and logarithmic lattice, and identify the specified-determinant coarse moduli with the actual Cartesian inverse image of the corresponding determinant Betti section. Include the scalar-gerbe comparison: choosing a determinant identification must not silently change the coarse fiber. The section is transported only after the certificate of §1.2 and comparison of §2.5. Deduce fixed-determinant family properness by proper analytic base change along this proved square. This comparison is required even in genus zero; the simplification there must be proved.

Export the proper semiconjugacy certificate consisting of §§2.5–2.6. A consumer then invokes NonlinearConnections §0.4 with its own source and time domain to deduce complete horizontal continuation. Do not reprove that general continuation theorem here or extend this properness assertion to arbitrary irregular data.

**Hypotheses**

- The entire logarithmic moduli problem and Riemann–Hilbert map of 2.5, identified with I13; r≥2, n≥1 and fixed genus, degree and residue data with d+Σᵢⱼλⱼ^(i)=0.
- Generic weights satisfying stable=semistable; g=0 requires rn−2r−2>0; g=1 requires n>1; g≥2 requires n≥1.
- Fixed-determinant restriction additionally requires the proved Cartesian determinant comparison, rank-one regular-singular correspondence and certified transported determinant section.

**API**

- `regularSingularFamilyPropernessLaw1` — Identify the full parameterized target and prove properness after pullback along any admitted analytic time/exponent base change.
- `regularSingularFamilyPropernessLaw2` — Construct and prove the Cartesian determinant comparison on coarse moduli, including rank-one Riemann–Hilbert and scalar identification issues.
- `regularSingularFamilyPropernessLaw3` — Return a proper semiconjugacy certificate for a separate application of the general continuation theorem.

**Tests and falsification cases**

- `regularSingularFamilyPropernessCheck1` (computation) — For g=0,r=2,n=5, rn−2r−2=4>0, so the numerical source condition holds. A genuine nonemptiness certificate and the determinant comparison remain necessary for the full fixed-determinant application.
- `regularSingularFamilyPropernessCheck2` (non-example) — For g=0,r=2,n=3, rn−2r−2=0; this target cannot cite I13 Theorem 2.2 as supplying its properness theorem.
- `regularSingularFamilyPropernessCheck3` (non-example) — Deleting an exceptional fiber from the source may destroy properness even though the generic Riemann–Hilbert map is an isomorphism; keep the full stable moduli source.
- `regularSingularFamilyPropernessCheck4` (dependency check) — The five-point application uses the same NonlinearConnections §0.4 as any other proper semiconjugacy consumer; no separate five-point compactness theorem is added here.

**Supporting constructions owned by this target.**

- Deligne II5.4 constructs the extension for a chosen section of ℂ→ℂ/ℤ; it explicitly does not make that canonical extension tensor-compatible. Consequently determinant compatibility is proved on the actual logarithmic lattices and residue sums, with any required integer lattice shifts. The characteristic polynomial of monodromy has eigenvalues exp(−2πiλ); equality of the monodromy matrix with exp(−2πi Res) up to conjugacy uses the appropriate nonresonance condition (II5.6) and is not asserted at every resonant point. Keep these distinctions in both the full RH map and the rank-one Cartesian determinant comparison.

*Needs:* Internal: 1.1, 1.2, 1.3, 1.5, 2.3, 2.4, 2.5.

**Source scope and owned proof:** I13 Theorem 2.2 (including every numerical hypothesis), Remark 2.3(1), §6 and §8. Comparison with this framework and the fixed-determinant Cartesian square are owned proofs. No irregular properness result is inferred.

### Constructive proof requirements

- `M-local-presentation-descent` — Build intrinsic input groupoids and coordinate/root changes with coherent descent, without treating I23 coordinate formulas as the definition.
- `M-determinant-time` — Construct and verify rank-one strong determinant transport on the stated local charts; global fixed-determinant output requires actual gluing. Prove determinant compatibility of the rank-r lift.
- `M-determinant-fiber` — Compare full ramified deformation cone with the regular determinant de Rham complex; prove scalar splitting, smooth determinant map, 2g removal and orthogonal nondegeneracy before exporting positive-genus fixed-determinant symplecticity.
- `M-early-unfolding` — Construct the finite-flat auxiliary family and both generic-fiber comparison maps before every confluence application.
- `M-strong-lift` — Prove existence/uniqueness inside the total-pole and kernel-lattice extension class, mixed-term flatness and actual trace-form preservation.
- `M-coherent-export` — Prove canonical pullback/presentation comparisons, 2-coherence and the general construction theorem independently of all specialized consumers.
- `M-regular-RH-proper` — Identify the entire logarithmic moduli functor with I13, prove all-points strong-splitting semiconjugacy, exact family properness and the Cartesian fixed-determinant restriction. Source completeness belongs to the generic NonlinearConnections theorem, applied downstream.

### Primary sources and exact use

- **I23** — [Michi-aki Inaba, Moduli Space of Factorized Ramified Connections and Generalized Isomonodromic Deformation, SIGMA 19 (2023), 013](https://sigma-journal.com/2023/013/); [PDF](https://sigma-journal.com/2023/013/sigma23-013.pdf). §§2–5; §6 (6.9), Proposition 6.3; §7 Proposition 7.2, Theorem 7.5; §8 Theorem 8.1, Propositions 8.2–8.3; §10 Definition 10.1, (10.1), Propositions 10.7/10.10; §11 Definition 11.4, Theorem 11.6, Corollary 11.8.
- **I13** — [Michi-aki Inaba, Moduli of parabolic connections on a curve and Riemann–Hilbert correspondence, Journal of Algebraic Geometry 22 (2013), 407–480](https://arxiv.org/abs/math/0602004); [PDF](https://arxiv.org/pdf/math/0602004). Definitions 1.1 and 2.2; Theorems 2.1–2.2; §6; regular-singular reconstruction and surjectivity.

I13 is the source for the logarithmic theorems 2.5–2.6 and supports logarithmic-consumer nonemptiness; it is not a prerequisite for the general irregular construction of §2.4. No unrestricted extension beyond the admitted I23 local models is claimed.

<a id="five-point-application"></a>

### Independent five-point application

This application tests actual proof reuse: its admitted input has structural degree five, its time base has dimension two and its phase fibers have dimension four. The generic construction, extension and descent proofs are the same ones used by the classical application. No Painlevé target is a prerequisite.

<a id="target-2-7"></a>
### 2.7 Five logarithmic points with a nonempty stable input

**Independent five-point application.**

Take an ordered five-pointed genus-zero curve. After the unique normalization of the first three points to 0, 1, ∞, its time base is B = {(t₁,t₂) ∈ ℂ² : t₁,t₂ ∉ {0,1}, t₁ ≠ t₂}. Thus dim B = 2 is a conclusion of the marked-curve quotient; coordinates on B display that quotient. Take rank 2, structural divisor P = a₁+⋯+a₅, determinant (O,d) with its fixed identification and trivial strong time transport, and full logarithmic flags with ordered residue pairs (1/4,−1/4), (1/4,−1/4), (1/6,−1/6), (1/6,−1/6), (1/4,−1/4). Choose weights αᵢ,₁ = i/100 and αᵢ,₂ = i/100 + 2ⁱ⁻¹/1000 for i=1,…,5. All ten are distinct and 0<αᵢ,₁<αᵢ,₂<1. A rank-one stability wall would require 2deg F + Σᵢ εᵢ2ⁱ⁻¹/1000 = 0 with εᵢ=±1; the signed sum has odd numerator and absolute value ≤31/1000, so equality is impossible. Thus stable = semistable for these numerical data. These are inputs to MeromorphicConnectionModuli §§1.1–1.2; no classical degree-four condition is imposed.

Prove nonemptiness for every configuration, not by assuming a phase-space point. For generators with γ₁⋯γ₅ = 1 set D = diag(i,−i), J = [[0,1],[−1,0]], K = diag(exp(πi/3),exp(−πi/3)), and (M₁,…,M₅) = (D,J,K,K⁻¹,(DJ)⁻¹). Their product is I and all local spectra are distinct. D and J have no common invariant line, so the representation is irreducible. The regular-singular correspondence with chosen logarithms exp(−2πiλ), and local logarithmic lattice changes from the canonical extension when needed, produces a logarithmic connection with the specified residues and flags on each pointed curve. This statement concerns monodromy irreducibility, not constant-matrix residue eigenlines.

The trace residues vanish and determinant monodromy is trivial. The determinant logarithmic connection therefore extends without poles to a flat line connection on ℙ¹, isomorphic to (O,d); choose that identification. There is no invariant proper subbundle, hence stability for the chosen weights. As an additional check, any sum choosing one residue at each pole is [3(σ₁+σ₂+σ₅)+2(σ₃+σ₄)]/12 with σᵢ ∈ {−1,1}; its numerator is odd, so it is never an integer. This independently excludes a rank-one invariant subconnection by the residue/degree relation. Nonempty fibers on the whole B are proved; a global marked object on B is not assumed.

**Hypotheses**

- Ordered five distinct points on ℙ¹; specified rank, logarithmic residues, determinant identification and generic weights. The two-dimensional time quotient and nonempty stable fibers are outputs.

**API**

- `fivePointAdmittedInputLaw1` — Identify the actual marked-curve quotient with B and its fixed collision discriminant.
- `fivePointAdmittedInputLaw2` — Construct the irreducible monodromy witness, its chosen logarithmic extension and determinant identification.
- `fivePointAdmittedInputLaw3` — Verify nonempty stable fibers without requiring a trivial rank-two underlying bundle.

**Tests**

- `fivePointAdmittedInputCheck1` — The product D J K K⁻¹ (DJ)⁻¹ equals I exactly; the eigenlines of D are the coordinate axes, and J interchanges them.
- `fivePointAdmittedInputCheck2` — The residue differences are 1/2 or 1/3, hence nonresonant. The signed-sum numerator is odd, excluding every integer sum.
- `fivePointAdmittedInputCheck3` — Replacing five poles by four changes the time dimension from 2 to 1; this is not a harmless chart change.
- `fivePointAdmittedInputCheck4` — A pair of residue matrices without a common constant eigenline is not by itself a certificate of differential-module irreducibility.

*Needs:* Internal: 1.1, 1.2, 2.5.

**Source scope:** I13 Theorems 2.1–2.2 and its regular-singular correspondence, plus I23 admitted logarithmic construction. All generic results are consumed through the named frameworks; this application verifies their hypotheses.

<a id="target-2-8"></a>
### 2.8 Constructed flat symplectic dynamics in phase dimension four

**Independent five-point application.**

Apply MeromorphicConnectionModuli §2.4 to the verified input of §2.7. Its output is the full stable phase family π: M → B, retaining all allowed degree-zero bundle types, the relative trace symplectic form ω, and the constructed holomorphic flat splitting h. Verify the fixed-determinant comparison on genus zero. The general dimension formula gives 2·2²(0−1)+2+2(2−1)·5 = 4; fixing the determinant removes 2g = 0 directions here. Smoothness and symplecticity are construction outputs, not fields in the input. Use NonlinearConnections §0.6 for the closed total form, after the moduli construction has proved actual preservation of ω. The two commuting horizontal time directions exist intrinsically; no scalar Garnier formula or Hamiltonian coordinates are used.

**Hypotheses**

- The fully verified input and nonemptiness of 2.7; no phase space, splitting or symplectic form is supplied as input.

**API**

- `fivePointConstructedDynamicsLaw1` — Verify the admission and determinant comparison for the general construction.
- `fivePointConstructedDynamicsLaw2` — Export the same nonlinear connection object, relative dimension four and closed total form.
- `fivePointConstructedDynamicsLaw3` — Identify its pullback and presentation comparisons; keep the time dimension two.

**Tests**

- `fivePointConstructedDynamicsCheck1` — The fiber dimension is −8+2+10=4, not 2; deg P=5 is never replaced by the classical budget.
- `fivePointConstructedDynamicsCheck2` — Flatness alone does not preserve e^{t₁}ω; the actual preservation theorem must be invoked.
- `fivePointConstructedDynamicsCheck3` — The global moduli family is not replaced by its trivial-bundle matrix chart.

*Needs:* Internal: 2.7, 2.4, 0.6.

**Source scope:** I13 Theorems 2.1–2.2 and its regular-singular correspondence, plus I23 admitted logarithmic construction. All generic results are consumed through the named frameworks; this application verifies their hypotheses.

<a id="target-2-9"></a>
### 2.9 A verified proper RH comparison

**Independent five-point application.**

Use MeromorphicConnectionModuli §§2.5–2.6, with I13 Theorem 2.2, on this logarithmic moduli problem. Verify g=0, r=2, n=5, rn−2r−2 = 4 > 0 and generic stability weights. Identify the constructed determinant-fixed moduli with the same determinant fiber of I13's family, using the rank-one determinant comparison and the actual coarse/gerbe comparison. Take the marked character family with the residue parameters retained through its fiber product with the exponent map λ ↦ exp(−2πiλ). Properness is a theorem about this actual family map, inherited through the proved Cartesian/base-change comparison. It is not a hypothesis in §2.7 or an inference from the existence of a foliation.

Use the complete Betti path transport of 2.5 and prove that the strong splitting of 2.8 maps every partial horizontal lift to that transport. Source and target comparisons use the full admitted moduli, rather than a chosen bundle chart. Only the regular-singular theorem is consumed. No general irregular properness or classical Painlevé continuation theorem is imported.

**Hypotheses**

- The actual logarithmic input and constructed connection of 2.7–2.8, with the checked I13 numerical range and the determinant/marking comparison. Properness and partial-lift compatibility are conclusions to verify via the general theorem.

**API**

- `fivePointProperRhLaw1` — Identify the precise I13 moduli and exponent-retaining Betti target after determinant fixing.
- `fivePointProperRhLaw2` — Verify properness by the proved Cartesian comparison and all-point horizontal compatibility.

**Tests**

- `fivePointProperRhCheck1` — Here 2·5−4−2=4>0; the source theorem is not applied without its genus/rank/pole inequality.
- `fivePointProperRhCheck2` — Forgetting the logarithms and retaining only their exponentials loses the properness statement.
- `fivePointProperRhCheck3` — Properness of RH does not say that π: M→B is proper.

*Needs:* Internal: 2.7, 2.8, 2.5, 2.6.

**Source scope:** I13 Theorems 2.1–2.2 and its regular-singular correspondence, plus I23 admitted logarithmic construction. All generic results are consumed through the named frameworks; this application verifies their hypotheses.

<a id="target-2-10"></a>
### 2.10 Reusing complete transport and its exact limits

**Independent five-point application.**

Apply NonlinearConnections §0.4 to §2.9 and obtain unique horizontal lifts through every point of every fiber for every compact piecewise C¹ path in B. Apply 0.3 for holomorphic local germs, 0.5 for the fundamental-groupoid action and the global horizontal section on a pointed universal cover of B, and 0.6 for symplectic preservation. The action and section are outputs of the constructed flat connection; descent to B holds exactly for fixed initial points of its nonlinear monodromy action.

When the proper RH family has been constructed on a topological marking cover, first lift the given path γ in B to that cover after choosing its initial marking. Apply the general proper-transfer theorem to the pulled-back connection and the lifted compact path, then project the resulting horizontal lift to M. The connection-preserving pullback map and local uniqueness prove independence of the initial marking and of overlapping marking charts. Thus completeness is asserted for all paths in B, without assuming a global topological marking of the five-punctured family.

This is the second actual consumer of the same general extension and descent proofs used for the classical family. Its transitive dependency closure excludes every Painlevé application target, including formal-profile enumeration, additive surface classification and scalar Painlevé formulas. This condition is checked on the expanded graph, not only on direct imports.

Do not apply the scalar first-jet theorem for a two-dimensional phase fiber to this four-dimensional fiber, or assert a one-variable pole statement on the two-dimensional base. For a connected holomorphic time curve f:C→B, choose c₀∈C and x₀∈M_(f(c₀)). Pull back the connection and construct its horizontal section on the pointed universal cover C̃ of C by 0.5. For an observer whose pullback along that section is defined and satisfies the non-infinity condition, apply 0.7 to obtain a meromorphic function on C̃. Prove that it descends to C exactly when its scalar evaluation is invariant under the actual deck action; this condition can be weaker than descent of the phase section. If a horizontal section on C is separately supplied, evaluate that section directly under the same observer hypotheses. Garnier coordinate dictionaries lie outside the four five-point application targets.

**Hypotheses**

- The constructed flat symplectic connection and verified proper semiconjugacy of 2.8–2.9. The curve-observer theorems additionally assume a connected holomorphic time curve, a base point, an initial phase point and the stated observer admissibility along the resulting universal-cover section. Descent to the curve additionally requires scalar deck invariance, or an independently supplied horizontal section on that curve.

**API**

- `fivePointCompleteTransportLaw1` — Instantiate the same completeness and groupoid-action theorems on a two-time/four-phase family.
- `fivePointCompleteTransportLaw2` — Verify no transitive dependency on the classical application.
- `fivePointCompleteTransportLaw3` — Prove the observer pullback theorem on the pointed universal cover of the time curve and the scalar-deck-invariance criterion for descent, under all the stated admissibility hypotheses.

**Tests**

- `fivePointCompleteTransportCheck1` — The expanded prerequisite graph excludes every Painlevé target, including its degree-four definition.
- `fivePointCompleteTransportCheck2` — Complete transport can have nontrivial monodromy; a universal-cover section need not descend.
- `fivePointCompleteTransportCheck3` — On a time curve the phase fiber still has dimension four, whereas a scalar first-jet fiber has dimension two; the scalar first-jet isomorphism cannot simply be asserted.

- The generic flat complete connection q′=q/(2t) on ℂ××ℂ has horizontal germ q=√t through (1,1). The observer q is admissible, but its universal-cover value changes sign under one loop. Curve pullback and admissibility alone therefore do not imply scalar descent; 0.7 supplies the exact additional condition.

*Needs:* Internal: 2.8, 2.9, 0.3, 0.4, 0.5, 0.6, 0.7.

**Source scope:** I13 Theorems 2.1–2.2 and its regular-singular correspondence, plus I23 admitted logarithmic construction. All generic results are consumed through the named frameworks; this application verifies their hypotheses.

### Sources

- **I13:** Michi-aki Inaba, *Moduli of parabolic connections on a curve and Riemann–Hilbert correspondence*, [arXiv:math/0602004v2](https://arxiv.org/abs/math/0602004v2), Theorems 2.1–2.2; journal publication J. Algebraic Geom. 22 (2013), 407–480.
- **I23:** Michi-aki Inaba, [*Moduli Space of Factorized Ramified Connections and Generalized Isomonodromic Deformation*](https://sigma-journal.com/2023/013/), SIGMA 19 (2023), 013.

<a id="layer-3"></a>

## Layer 3: Intrinsic construction of Painlevé equations

<a id="painleve"></a>

**Summary.** Construct Painlevé dynamics from moduli of meromorphic connections, and construct Painlevé functions from the horizontal sections of that dynamics. The input consists of a curve, a structural polar divisor, a determinant connection, local formal moduli conditions, and stability and marking data. The phase space, its symplectic form, and its horizontal distribution are constructed from this input. A common continuation theorem precedes every classical scalar equation. The ten underlying rank-two formal profiles, their labelled realizations, their eight additive surface types, and the six classical differential equations are comparison results. The theory includes resonant parameters, allowed reducible connections, ramified irregular singularities, special invariant loci, tau sections, normalized analytic solutions, and confluence. Elementary coefficient degenerations are covered by a separate boundary comparison. JMU/Hamiltonian comparisons of tau sections have the precise generic scope stated in targets 6.4–6.5; the determinant construction itself has the broader marked-RHP scope specified in 6.2–6.3.

### General theory and independent applications

A reusable target satisfies the following condition: a general proof must have its own mathematical inputs, outputs, laws, counterexamples and owner, and its dependency closure must contain no application target. The general theories of nonlinear connections, meromorphic-connection moduli, analytic RHPs and determinants, and algebraic confluence are specified in this document. The five-point construction is an independent application.

| General theory or application | Construction or theorem | Independent consumers |
|---|---|---|
| [NonlinearConnections](#nonlinear-connections) | General nonlinear connections, local lifts, proper transfer, monodromy/descent, symplectic form, observers, intrinsic jets, compact-path limits | Painlevé systems; five logarithmic points; other smooth/holomorphic connection problems |
| [MeromorphicConnectionModuli](#connection-moduli) | Admitted decorated moduli → coherent flat symplectic nonlinear connection; regular-singular RH branch | Degree-four classical input; five logarithmic points; admitted higher-rank/genus data |
| [AnalyticRHPAndDeterminants](#analytic-theory) | Complex Fredholm determinant, Cauchy-class RHP, uniform moments/tails, normalized limits | Painlevé systems; independent operator and RHP problems |
| [AlgebraicConfluence](#algebraic-confluence) | Vector-valued principal-part cancellation and relative dual Lie–Poisson structures | Painlevé systems; other pole-collision and finite-algebra problems |
| [FiveLogarithmicPoints](#five-point-application) | A second worked consumer with two-dimensional time and four-dimensional phase fibers | Uses the first two packages without importing a Painlevé target |

The general framework is not an axiom saying that an arbitrary connection is complete, nor an unrestricted moduli theorem. Each theorem retains its exact hypotheses. General existence/flatness/symplecticity are constructed in the moduli package; completeness requires a separately proved proper semiconjugacy. The classical degree-four restriction occurs only in §3.3. Coordinate equations remain downstream comparisons in targets 7.1–7.5. See [the reusable proof contract](#reuse-contract) for the ownership and proof-reuse contract and [the Japanese version](README.ja.md#reuse-contract).

### Scope and ownership

The reusable constructions and the Painlevé application have separate proof targets within one dependency graph. NonlinearConnections owns general nonlinear-connection, continuation, jet and convergence theorems. MeromorphicConnectionModuli constructs those objects from its admitted geometric input, with a separately scoped regular-singular RH branch. AnalyticRHPAndDeterminants owns the general determinant and RHP analysis; AlgebraicConfluence owns the finite-algebra and pole-cancellation lemmas. The Painlevé application owns the classical restriction and its hypothesis checks, formal-profile classification, the remaining classical irregular/Stokes and proper-RH extension, observable and surface comparisons, transformations, and the analytic and confluence application adapters. It consumes the same underlying objects and theorems; it does not define parallel carriers. The proof owners and shared contracts are recorded in design/plan.json and the reusable proof contract.

RandomMatrices §8.5 owns Hastings–McLeod existence and uniqueness, real pole-freeness, and its Fredholm/Tracy–Widom identities. Section 8.8 here owns only the bridge from that scalar solution to an intrinsic horizontal section. RandomMatrices is a supplier of that bridge; it is not made to depend on this roadmap. The trace-class determinant required by the tau branch is consumed from RandomMatrices §8.3 at its stated operator generality. New applications using both theories are downstream consumers of both.

Difference and q-difference Painlevé dynamics, a general Sakai classification of discrete systems, cluster realizations, arbitrary-rank wild nonabelian Hodge theory, a classification of every algebraic special solution, and numerical connection constants for every asymptotic regime have different scope. They are not prerequisites of the differential theory specified here. Rational and classical-function solutions included here are the explicit families obtained from the geometric reductions and transformations of targets 5.4–5.6 and 7.1–7.5; no completeness classification of all such solutions is asserted.

### Conventions

Work over ℂ. Curves are smooth connected projective curves, with a finite nonempty ordered set of pairwise distinct marked points. The general rank is an integer r ≥ 1; slope stability is defined on this positive-rank domain. A ramified local condition also satisfies the rank and local-order restrictions of its stated formal model. The classical subcategory has genus zero and rank two. Write P = Σ mᵢaᵢ for the structural polar divisor; it bounds the poles and records the local moduli problem. It is not the divisor of nonzero poles of each individual connection. Apparent singularities and scalar residues at a marked point are allowed when the local conditions allow them. The auxiliary unfolding in §3.7 and the collision data of §9.5 use separately constructed finite-flat divisors; their special fibers need not consist of distinct marked sections.

An object is a vector bundle E on the whole curve, a meromorphic connection ∇: E → E ⊗ Ω¹(P), an isomorphism of its determinant connection with the specified line connection, and the local structures below. All relevant bundle splitting types are retained. The general input permits a meromorphic determinant; the classical complexity subcategory uses a regular-singular determinant with fixed residues and its compatible moving-curve transport. This still allows odd determinant degree. At a logarithmic point prescribe residue eigenvalues and a compatible filtration; do not freeze one complete formal isomorphism class at resonant parameters. At an unramified irregular point use a generic distinct-leading-term formal condition. At a ramified point use the generic factorized ramified condition, with ramified descent. Leading coefficients required to be nonzero remain nonzero within a fixed irregular stratum. Their vanishing belongs to targets 9.5–9.8.

Weights are denoted w, avoiding confusion with the classical scalar coefficient α. Use generic stability weights for which semistability equals stability on the specified numerical data. Stability concerns ∇-invariant subbundles. Changing a weight chamber is a wall-crossing problem, not an auxiliary-choice invariance. Isomorphisms preserve the determinant identification, labels and prescribed local structures. Retain these arrows before rigidification or passage to a coarse moduli space. For a stable rank-two object with determinant identification fixed, the residual scalar group is μ₂, not the full multiplicative group; fixing the determinant and rigidifying this remaining group are different operations.

Write Θ for fixed external residue/exponent parameters and Bθ for an admitted marked time base with θ ∈ Θ fixed. Write πθ: Mθ → Bθ for the phase family. The distinction between fixed parameters and time directions is part of the deformation problem. For the convention ∇ = d + A, a logarithmic residue λ has monodromy eigenvalue exp(−2πiλ); sources using d − A or exponent θ = −λ have exp(2πiθ). Retain the actual logarithm parameters in the fiber product defining the comparison target: forgetting them is not a proper map.

The horizontal splitting is h: π*TB → TM with dπ ∘ h = id. Its image is the invariant dynamics. A vector field representing it requires a chosen time vector. A local solution is a holomorphic section s of π satisfying ds(v) = h(v), with a specified initial point. Paths are compact piecewise C¹ paths in the fixed admitted base. The base is never punctured further according to the poles of a selected solution.

Use ω = dq ∧ dp and ι_Xω = d_phase H in a Hamiltonian chart. Thus q′ = H_p and p′ = −H_q. The extended form is Ω = dq ∧ dp + dH ∧ dt, whose kernel contains ∂t + X. Under τ = f(t) the normalized horizontal generator scales by dt/dτ. A scalar Hamiltonian is local and can change by a time-only function or by the generator of a time-dependent symplectic coordinate change.

“Painlevé function” first means a geometric horizontal section or its germ. A scalar function is the evaluation of a specified admissible observable, with a time coordinate and normalization. An everywhere defined map to ℙ¹ may give the constant value ∞; the usual meromorphic-function conclusion excludes that case. Universal-cover continuation and single-valued descent to B are different conclusions.

### Foundations and application boundaries

Use the [external dependency contracts](#external-dependencies) and the general results on nonlinear connections, meromorphic-connection moduli, analytic RHPs and determinants, and algebraic confluence. The Painlevé application owns each classical admission, formal-profile classification, irregular analytic comparison, surface comparison and analytic/confluence adapter stated below. The local proof requirements specify every construction beyond the supplied foundation.

### Order of construction

Construct nonlinear connections, solutions, transport, observations and convergence as general theorems. Construct admitted meromorphic-connection moduli and their strong isomonodromic connection, then establish the logarithmic Riemann–Hilbert comparison and its independent five-point application. Restrict this construction to the classical input and verify its formal profiles. Prove the full classical Riemann–Hilbert comparison and Painlevé property before developing the surface, transformation and Riccati comparisons. Construct determinant lines and tau sections intrinsically. Derive the classical scalar equations, Hamiltonians and sigma forms in separate coordinate-comparison targets. General small-norm RHP theory and Barnes G support the specified analytic solutions and connection formulae. General pole-cancellation, relative Poisson and analytic convergence theorems support geometric confluence and tau limits. The intrinsic construction, continuation, surface geometry and tau-section targets have no classical scalar comparison prerequisite.

<a id="target-3-1"></a>
### 3.1 Binding the general decorated-connection input

**Painlevé application.**

**Hypotheses.**

- An object of MeromorphicConnectionModuli 1.1, with its actual arrows, determinant and admitted local structures; no classical degree restriction yet.

Use the objects and arrows of MeromorphicConnectionModuli §1.1 directly. This is an import binding, not a second definition of decorated connections. Record the determinant, local decorations, weights and marking that the classical restriction in §3.3 will retain. The genus-zero rank-two restriction is imposed there, not in the general framework. Identify the local presentations used in the Painlevé sources with these same objects, preserving filtrations, logarithmic lattices and ramified descent. The invariant adjoint and projective objects are End⁰(E) and the PGLᵣ connection; no globally trace-subtracted rank-r connection or square root of the determinant is introduced. (I23, §§2–4.)

**API.**

- Identify every imported object and arrow without copying its carrier.
- Verify the odd-determinant and resonant/ramified presentation comparisons on the classical inputs to be selected.

**Checks.**

- On E = O ⊕ O(−1), the determinant has odd degree; a putative global half-determinant twist does not exist. The carrier must still allow this bundle when the prescribed determinant matches it.
- Two logarithmic residues with the same repeated eigenvalue, one scalar and one nonzero Jordan block, are not identified by specifying the eigenvalues. Their allowed parabolic objects and monodromy differ.
- Changing the root w to −w in a rank-two ramified chart changes the displayed branches but gives an equivalent descended object; forgetting the descent arrow fails this check.
- With I23's ramified convention, a rank-two ramified point contributes 2c + 1/2 to the residue/degree relation. Replacing it by 2c changes that relation by 1/2.
- Rank zero is rejected before slope stability or the dimension formula is applied. At r = 1 the adjoint bundle End⁰(E) has rank zero, without changing the required positive rank of E.
- For A = 0 and frame change g = diag(z,1), g⁻¹dg = diag(1,0)dz/z; subtracting half its trace gives diag(1/2,−1/2)dz/z. The scalar discrepancy prevents gluing a rank-two trace-subtracted connection on E, while the induced End⁰(E) and PGL₂ connections glue.

*Needs:* Internal: 1.1.

<a id="target-3-2"></a>
### 3.2 Binding the general time-deformation problem

**Painlevé application.**

**Hypotheses.**

- The imported decorated input and admitted deformation problem, with fixed exponent data; the classical determinant time-lift comparison must be verified.

Use MeromorphicConnectionModuli §1.2 for the admitted deformation problem, its coordinate-change arrows, marking covers and fixed exponent parameters. For the classical subcategory verify the regular-singular determinant with fixed residues has the compatible time lift required by that contract. Identify the genus-zero local slices and their actual tangent maps; do not construct a second time-base carrier. The reduced versal problem remains the input to §3.3; its one-dimensionality is proved in §3.4. Strong isomonodromy preserves transported analytic data, not a fixed-coordinate irregular polynomial. (HEU10, Theorem 1.1; I23, §§5, 11.)

**API.**

- Identify the fixed-parameter/time tangent decomposition through the imported construction.
- Verify the determinant lift and genus-zero coordinate-change coherence required by the classical restriction.

**Checks.**

- Four ordered logarithmic points have one modulus after quotient by PGL₂: 4 − 3 = 1; its cross-ratio avoids 0, 1 and ∞.
- A change τ = 2t multiplies the displayed horizontal generator by 1/2; retaining its coefficient unchanged gives a different parametrized system.
- Two solutions with different movable pole sets use the same Bθ. A base that deletes one solution's poles fails this requirement.

*Needs:* Internal: 3.1, 1.2.

<a id="target-3-3"></a>
### 3.3 The rank-two degree-four subcategory

**Painlevé application.**

**Hypotheses.**

- Genus zero; rank two; structural degree four; regular-singular determinant with fixed compatible residues; reduced versal time problem; nonempty stable fibers.

Define the classical differential Painlevé input class by genus zero, rank two, a structural polar divisor of degree four, the local moduli conditions of §3.1, a regular-singular determinant connection with fixed residues and its compatible transport, the reduced versal formal-data deformation from §3.2, and nonempty stable fibers. On genus zero the determinant residues obey their sum = −degree convention for ∇ = d + A. The time deformation is the actual reduced deformation problem, not an arbitrarily chosen constant or nonversal curve in a larger base. Nonemptiness is a domain condition on the moduli problem; neither one-dimensional time nor continuation is a field of this definition. Prove the reduced-time dimension in §3.4, independently of the phase dimension. Keep the connection data themselves as objects; do not define this class as a six-element type. (VDPS09, §2.2 and Table 1; I23, Theorem 7.5.)

In the pole-budget comparison, r is the projective Katz invariant, computed from trace-free exponential differences. It is not the maximal slope of an arbitrary scalar twist of the connection. The classical determinant normalization avoids extra scalar irregular times. Adding an arbitrary scalar irregular part belongs to a separate rank-one extension with a specified strong time lift; it is not silently included in the one-dimensional deformation count. None of these local/formal comparisons requires a global square root of the determinant line.

**API.**

- Restrict the general connection functor to this full subcategory of input data and retain its arrows.
- Extract rank, genus and structural degree invariantly; prove their preservation under the stated equivalences.
- Compare the formal pole budget with Katz invariants: m = r + 1 for integral r, and m = r + 3/2 for a positive half-integral r in rank two.
- State nonemptiness and excluded discriminants explicitly on each parameter base, including exceptional logarithmic exponents.

**Checks.**

- Four logarithmic points have budget 1 + 1 + 1 + 1 = 4 and belong to this complexity class.
- Five logarithmic points have phase dimension 2·5 − 6 = 4, and three have phase dimension 2·3 − 6 = 0; neither is a two-dimensional Painlevé input.
- Two ramified points of Katz slope 1/2 have budget 2 + 2 = 4. Requiring integral slopes would lose this input.
- A logarithmic residue can vanish at a phase point without changing the structural degree. Recomputing the budget from its actual nonzero poles would wrongly remove that point.

*Needs:* Internal: 3.1, 3.2.

<a id="target-3-4"></a>
### 3.4 Classification of formal profiles and time normalizations

**Painlevé application.**

**Hypotheses.**

- An input of 3.3 with its allowed generic projective local types and the actual reduced formal-data deformation problem. Pole labels are retained. The number of profiles, automorphism-stabilizer calculation and one-dimensional reduced time are conclusions, not assumptions.

Classify the allowed rank-two formal profiles of structural degree four, retaining the nondegenerate leading-term and reduced-deformation hypotheses. First classify underlying profiles after forgetting the order of the pole labels: enumerate partitions of four and the integral or half-integral generic local slope at each irregular part. This gives ten underlying profiles. Recover the original ordered input through its label-assignment groupoid: a permutation induces a reindexing equivalence between labelled presentations, not a label-preserving arrow in the original groupoid. There are seventeen ordered slope profiles, with counts 2, 8, 6 and 1 for one, two, three and four poles; the corresponding unordered counts are 2, 5, 2 and 1. These are counts of formal profile shapes, not of objects with continuous exponent parameters.

Prove that every labelled realization has one essential time parameter after quotienting the permitted label-preserving curve-coordinate changes. In a presentation with n poles the dimension calculation is n + Σ⌈rᵢ⌉ − 3 = Σmᵢ − 3 = 1, with the automorphism stabilizers and the chosen marking/slices explicitly checked. The determinant normalization and its transport remove no required projective direction and add no scalar irregular direction. Prove that all ten underlying presentations and every label assignment admit this determinant normalization. The table in §7.2 is a table of underlying profiles; its coordinate formulas are transported along the label-reindexing equivalences. (VDPS09, §2.2, Table 1, printed pp.18–19.)

Prove the familiar time domains only after fixing the displayed marking and normalization: the four-point cross-ratio base, a nonzero irregular time for the multiplicative-looking time charts, and an affine time for the polynomial charts. These are charts or marking covers of the intrinsic time problem; they are not six definitions of dynamics. The classification is restricted to this rank-two formal complexity, and does not classify every two-dimensional nonautonomous system.

**Checks.**

- The ordered tuples (1,0,0) and (0,1,0) have orders (2,1,1) and (1,2,1). They have the same underlying profile but are not identified by a label-preserving arrow.
- Enumerating ordered compositions of 4, with one local type for a part 1 and two for each larger part, gives 2 + 8 + 6 + 1 = 17. Forgetting order gives 2 + 5 + 2 + 1 = 10.
- A label permutation preserves the pole budget and the time dimension, but transports the residue parameters and cross-ratio chart; it does not leave every displayed coordinate unchanged.

*Needs:* Internal: 3.1, 3.2, 3.3; [Formal scalar and vector-valued Laurent algebra](#dependency-formal-series) (L1–L4; L5–L6 for finite-extension steps in 1.1).

#### Examples

For a single ramified pole with slope 5/2, the structural order is 4 and the three irregular coefficients are reduced by the two-dimensional affine coordinate group to one essential time. For two unramified poles of slope 1, there are two irregular coefficients and one residual scaling, again leaving one time. These calculations concern input types before any scalar Painlevé equation is introduced.

#### Dependencies

Use the exact *Needs* list at each target and the cross-package registry in `design/reuse_registry.json`. General proof prerequisites belong to their independent package; this layer verifies its stated application comparisons.

<a id="target-3-5"></a>
### 3.5 Classical specialization of the full stable moduli

**Painlevé application.**

**Hypotheses.**

- The classical input 3.3; verify the exact hypotheses of the general stable-moduli construction rather than assuming its representing family.

Apply MeromorphicConnectionModuli §1.3 to §3.3. Verify its determinant, stability and local-model admission hypotheses on the classical input; boundedness is supplied by the general construction. Identify its output with the full classical stable moduli problem. The stack, rigidification, coarse family and étale universal-object covers are the imported constructions. Retain all permitted bundle types and the actual residual μ₂ stabilizer before rigidification. Own the comparison of every classical framed chart with its actual locally closed or open locus; a balanced chart never replaces the entire moduli space. (I23, Theorem 5.1.)

**API.**

- Identify the classical moduli functor with the restricted general functor, including arrows and determinant identification.
- Verify every framed chart inclusion, its complement, and the weight-chamber common stable loci.

**Checks.**

- A stable object may have scalar automorphisms before rigidification. A set-valued quotient that claims all stabilizers were trivial fails this example.
- A family can leave a trivial-bundle chart by bundle jumping while remaining in the moduli space. Its phase path is not declared singular for that reason.
- In the extension family 0 → O(−1) → E_t → O(1) → 0, E₀ = O(−1) ⊕ O(1) while E_t = O ⊕ O for t ≠ 0. The two splitting strata pull back to {0} and its complement in A¹; the first is not open. The full connection moduli must retain such bundle jumps on the permitted connection locus.
- A ramified generic local factor is irreducible, so it has no global ∇-invariant line and is stable for every weight; this is I23 Remark 2.9, not a claim that every special solution is absent.

*Needs:* Internal: 3.3, 1.3.

<a id="target-3-6"></a>
### 3.6 Specializing the deformation complex and pairing

**Painlevé application.**

**Hypotheses.**

- The family of 3.5 and its determinant and local structures; the tangent/obstruction identifications are imported via the verified comparison.

Specialize MeromorphicConnectionModuli §1.4 to the determinant-fixed family of §3.5, and prove that infinitesimal classical families and gauges correspond to its cocycles and coboundaries. Use its actual three-term ramified cone and ℂ-linear differential-operator/Čech construction. Do not replace the commutator differential by an O-linear map, or truncate the cone without a proved quasi-isomorphism. Verify the determinant restriction and trace-sign convention on the same complex. (I23, equation (6.9), Propositions 6.3 and 7.2.)

**API.**

- Construct the restriction comparison with the general cone, including the determinant-fixed tangent directions.
- Verify gauge, trace-sign and local-presentation compatibility under this comparison.

**Checks.**

- An infinitesimal gauge change by u changes a connection representative by the commutator differential of u; its tangent class is zero.
- Without a determinant identification scalars have an infinitesimal automorphism direction; fixing it in characteristic zero removes that direction, although the finite μ₂ stabilizer remains until rigidification.
- With ω = dq ∧ dp, the ordered tangent pair (∂q, ∂p) has pairing +1 and the reversed pair −1; a reversed trace convention must be corrected before transport formulas are used.

*Needs:* Internal: 3.5, 1.4.

<a id="target-3-7"></a>
### 3.7 The classical symplectic surface as a construction output

**Painlevé application.**

**Hypotheses.**

- The classical family and its comparison with the general deformation construction; smoothness, dimension two and the symplectic form are conclusions.

Apply MeromorphicConnectionModuli §§1.5–1.6 to the family and complex identified in §§3.5–3.6. Verify the determinant-fiber comparison; genus zero contributes no omitted Jacobian directions. Substituting g = 0, r = 2 and deg P = 4 in the admitted general dimension theorem gives 2. Smoothness, nondegeneracy and relative closedness are outputs. The finite-flat auxiliary unfolding, its simple-connection moduli, both generic logarithmic quasi-isomorphisms and the smooth-density argument are proved once in the general framework, before any confluence theorem. Here identify its central stable fiber, complex and form with the actual classical family, including admissible nonreduced base change. Do not invoke targets 9.5–9.8. (I23, Theorems 7.5 and 8.1, Propositions 8.2–8.3.)

**API.**

- Verify the fixed-determinant and central-fiber comparisons needed to specialize the general theorem.
- Export the same relative tangent bundle and symplectic form on the entire classical family.

**Checks.**

- Genus zero, rank two and degree four give −8 + 2 + 8 = 2; structural degree five instead gives 4.
- Fixing the determinant in positive genus removes 2g directions when the determinant-map comparison applies; the genus-zero coincidence cannot be exported unchanged.
- A skew pairing which vanishes identically is closed but is not symplectic; nondegeneracy must follow from the actual duality computation.
- At r = 1 and g = 1 the unfixed-determinant formula gives 2, and fixing the entire line connection gives 0. The rank-zero input that would incorrectly give 2 is outside the domain.
- For r = 2, local order 2 and q₁ = 2, the unfolding equation is (z − 2h²)(z − h²). Its fiber at h = 0 is z² and at h = 1 is (z − 2)(z − 1); modulo h² it is again z². Check the central and pulled-back complexes and forms, rather than identifying this family with fixed distinct sections.

*Needs:* Internal: 3.3, 3.5, 3.6, 1.5, 1.6.

<a id="target-3-8"></a>
### 3.8 Exceptional strata are part of the phase space

**Painlevé application.**

**Hypotheses.**

- All stable resonant, reducible and apparent strata allowed by the fixed local conditions; generic ramified local irreducibility.

Prove that the construction retains all w-stable logarithmic resonance, reducible and apparent-singularity strata allowed by its fixed local moduli conditions. Describe how the local filtration resolves the ambiguity of repeated eigenvalues. Record nonemptiness separately. At generic ramified points use the irreducibility theorem rather than inventing reducible objects there. Targets 4.1–4.4 will identify the images of these already constructed strata in the character space. A vanishing leading irregular coefficient changes the input stratum and is handled by §7.3 and targets 9.5–9.8. (I23, §2 and Remark 2.9; IIS06, §4, especially Theorems 4.10–4.12; VDPS09, §2.2 and §3.)

*Needs:* Internal: 3.1, 3.5, 3.6, 3.7.

#### Examples

At genus zero and rank two, the dimension calculation gives −8 + 2 + 2·4 = 2. An affine phase chart has coordinates (q,p), but points missing from that chart remain genuine initial conditions. On a resonance divisor, distinct parabolic initial points can have the same coarse monodromy character; the phase space must retain them.

#### Dependencies

Use the exact *Needs* list at each target and the cross-package registry in `design/reuse_registry.json`. General proof prerequisites belong to their independent package; this layer verifies its stated application comparisons.

<a id="target-3-9"></a>
### 3.9 Specializing the strong isomonodromy construction

**Painlevé application.**

**Hypotheses.**

- The constructed classical moduli/time problem; verify that its local structures and determinant transport satisfy the strong-extension contract.

Apply MeromorphicConnectionModuli §2.1 to the classical time problem and the family of targets 3.5–3.8. Identify its strong extensions with the classical universal-object charts, including kernel lattices, logarithmic flags and ramified descent. The total pole class is Ω¹_X(log D) ⊗ O_X(P − D); its moving-coordinate generators dz/zᵐ and dε/zᵐ⁻¹ remain comparison lemmas, with a regular time coefficient at a logarithmic pole. Import existence, uniqueness and gluing of strong extensions, and obtain the same splitting h of NonlinearConnections §0.1. This target does not assume h or recover it from a prescribed scalar equation. (I23, Definition 10.1, Propositions 10.7 and 10.10.)

**API.**

- Compare the classical kernel lattices and moving-pole filtration with the general strong-extension class.
- Identify the resulting tangent splitting, its linearity and its base-change maps without creating a second connection object.

**Checks.**

- A zero time tangent lifts to zero; adding an arbitrary vertical vector would violate uniqueness of the integrable extension.
- Rescaling the time tangent by 2 rescales its lift by 2, while changing the time coordinate to 2t rescales the normalized generator by 1/2.
- The zero map cannot be a splitting over a nonzero time tangent because dπ ∘ 0 = 0 ≠ id.

*Needs:* Internal: 3.2, 3.5, 3.6, 3.7, 2.1, 0.1.

<a id="target-3-10"></a>
### 3.10 The imported flatness theorem on classical inputs

**Painlevé application.**

**Hypotheses.**

- The strong splitting identified in 3.9 and the verified restriction of the general two-parameter extension problem.

Use MeromorphicConnectionModuli §2.2 and the identification of §3.9 to obtain h([v,w]) = [h(v),h(w)] on the classical family. Verify that the two-parameter strong-extension comparison restricts to this time problem. The general mixed-term proof is not repeated for each formal profile; no analytic Stokes theorem or scalar equation is a premise. (I23, Theorem 11.6.)

**API.**

- Verify the restriction comparison for the mixed extension and export the bracket identity.

*Needs:* Internal: 3.9, 2.2.

<a id="target-3-11"></a>
### 3.11 Symplectic preservation and total form by general comparison

**Painlevé application.**

**Hypotheses.**

- The constructed relative form and splitting, plus the verified specialization of the moduli symplectic-preservation theorem; preservation is not inferred from flatness.

First specialize the actual symplectic-preservation theorem of MeromorphicConnectionModuli §2.2. Flatness by itself does not supply preservation. Then apply NonlinearConnections §0.6 to (π,h,ω) and obtain the closed total form Ω(v,w) = ω(v − h(dπv), w − h(dπw)), its kernel and transport laws. Identify this form with the classical family, rather than introducing a second Hamiltonian object. A Darboux/time chart and local exactness give the downstream expression dq ∧ dp + dH ∧ dt. (I23, Definition 11.4 and Corollary 11.8.)

**API.**

- Identify the imported relative and total forms and their horizontal kernel.
- Verify Hamiltonian signs and time-dependent coordinate comparisons only after choosing the stated local charts.

**Checks.**

- For H = p²/2, contraction with ∂t + p∂q annihilates dq ∧ dp + p dp ∧ dt; using the opposite sign does not.
- H and H + t² give the same vertical vector field and extended two-form, but different scalar functions.
- On a symplectic fiber, Ω has no nonzero vertical kernel vector; degenerating ω to zero would fail this characterization.

*Needs:* Internal: 3.7, 3.9, 3.10, 2.2, 0.6.

<a id="target-3-12"></a>
### 3.12 Coherent restriction of the general construction

**Painlevé application.**

**Hypotheses.**

- The verified classical restrictions of the general construction and their actual presentation-change arrows.

Use MeromorphicConnectionModuli §§2.3–2.4 to identify all objects in targets 3.1–3.12 as the classical restriction of one construction, with coherent presentation, gauge and admissible base-change comparisons. Verify the cocycle diagrams for the classical markings and time slices. Changes of labels, determinant or stability chamber remain the explicitly permitted morphisms or correspondences, with stated domains. A later coordinate dictionary must commute with this construction; it is not a new definition of the dynamics.

**API.**

- Prove the classical specialization square and its triple-overlap coherence.
- Keep all imported structures on one moduli family and one nonlinear connection.

*Needs:* Internal: 3.1, 3.2, 3.5, 3.9, 3.10, 3.11, 2.3, 2.4.

#### Examples

The Hamiltonian chart H = p²/2 − 2q³ − tq represents a horizontal kernel, but the kernel is constructed without this formula. Replacing H by H + c(t) preserves it. A marking change acts on the parameterized family; it does not erase the marking from the input groupoid.

#### Dependencies

Use the exact *Needs* list at each target and the cross-package registry in `design/reuse_registry.json`. General proof prerequisites belong to their independent package; this layer verifies its stated application comparisons.

<a id="layer-4"></a>

## Layer 4: Riemann–Hilbert comparison and the Painlevé property

<a id="target-4-1"></a>
### 4.1 Sectorial local systems and ramified analytic descent

**Painlevé application.**

**Hypotheses.**

- Admitted good rank-two formal types; resonant logarithmic lattice data; finite ramified covering and deck action.

Construct the analytic classification of the permitted local meromorphic connections by formal graded data, sectorial solutions and Stokes transition maps, retaining resonant logarithmic lattices and flags. Prove sectorial existence, overlap uniqueness, cocycle identities and analytic dependence on the admissible time parameters. At a ramified point perform the construction on the finite cover and prove equivariant descent, including the deck permutation of the exponential factors. A formal Laurent-series classification alone does not prove these analytic assertions. (I23, §9, Theorem 9.7 and Corollary 9.11; BOA01, §§3–6; HEU10, §2; BY15, Remark 3 and Definitions 7 and 13.)

**API.**

- Construct solution-sector restriction, refinement and change of sectorial normalization.
- Recover the actual local analytic connection and prove full faithfulness on decorated objects.
- Compare the logarithmic, unramified and ramified descriptions through the same descent language.
- Prove that integrable time extension is equivalent to strong local constancy of these data at the stated local scope.

**Checks.**

- A rank-one exponential exp(1/z) has irregular growth despite trivial ordinary monodromy; ordinary monodromy alone cannot classify the object.
- A nontrivial unipotent logarithmic monodromy matrix differs from the identity although both eigenvalues equal 1.
- On a quadratic cover, one full turn in z exchanges the two formal exponential branches; a sectorial construction that returns each branch individually without the deck action fails descent.

*Needs:* Internal: 3.1, 3.2, 3.9, 3.10, 1.1; [Complex manifolds, holomorphic bundles and observations](#dependency-complex) (K1; K3.0; K3.HolomorphicStalk; K3.MeromorphicGermField; K4; K7.1).

<a id="target-4-2"></a>
### 4.2 The Betti family and complete transport

**Painlevé application.**

**Hypotheses.**

- The local analytic data of 4.1 over the admitted marked time problem of 3.2, retained exponent lifts, and fixed closed spectral/determinant constraints; singular affine quotients are permitted. Ramified family isotopy, descent and complete transport are outputs.

For the regular-singular subcategory, use MeromorphicConnectionModuli §2.5 and verify that its marked Betti family agrees with this target. The genuinely irregular and ramified transport extensions remain the scoped obligations below.

Construct the generalized monodromy groupoid by gluing the local data of §4.1 with the global local system on the punctured curve. Keep the enriched groupoid with logarithmic lattices and flags distinct from the ordinary affine character quotient obtained by forgetting those decorations. In the ordinary quotient impose the closed spectral-invariant and determinant constraints, and retain the exponent parameter θ as a separate fiber-product coordinate. At resonance do not fix a single nonclosed Jordan conjugacy class: scalar and allowed unipotent strata with the prescribed spectrum must remain present. Construct locally constant transport along admissible marked deformations, including changes of Stokes-sector presentations. Prove composition and inverse laws and completeness along every compact path in Bθ. A singular character fiber is permitted; transport is defined by the groupoid/topological construction, not by an assumed smooth tangent splitting there. (VDPS09, §§1–3; BOA14, §10, Theorem 10.2; BY15, Proposition 19, Theorem 21 and Corollary 22.)

BOA14's cited family-transport theorem has untwisted scope. Extend its isotopy construction to the rank-two ramified objects of BY15 by retaining the exponential covering, grading and deck action, constructing deck-compatible equivalences of the Stokes groupoids, and descending the framing action and closed spectral constraints. Prove independence, composition and homotopy compatibility before concatenating local products along a compact path. BY15's quasi-Hamiltonian/Poisson theorem by itself is not this family-transport theorem.

**API.**

- Construct restriction, gluing, gauge-conjugation and change-of-marking functors.
- Distinguish the decorated groupoid, its categorical quotient and the locus where it represents individual orbits.
- Prove local product descriptions over simply connected admissible time neighborhoods and their continuation along finite chains.
- Define the complete transport on the coarse quotient and its lift on any required decoration space.

**Checks.**

- θ and θ + 1 give the same exponential eigenvalue but need not give the same logarithmic lattice; the comparison target retains θ.
- A reducible representation and its semisimplification can have the same coarse character. The quotient is not declared a faithful encoding of all connection objects.
- Transport around a nontrivial loop may act nontrivially on the fiber; completeness does not imply trivial monodromy.

**Supporting constructions owned by this target.**

- 2.5 constructs the finite-type representation varieties and their reductive affine conjugacy quotients using the proven 1.3 invariant-theory prefix, then applies 1.2 analytification and proves Hausdorff/local-compactness and marked product transport, including singular points. 4.2 constructs the wild/Stokes framing groupoid and quotient at its actual reductive or explicitly descended stages; unipotent local Stokes groups do not by themselves permit an arbitrary GIT quotient. Prove root/deck isotopy and ramified descent, stabilizer compatibility and all-stratum holomorphic maps. Nothing in SSF1.17 supplies these constructions automatically.

*Needs:* Internal: 3.2, 4.1, 1.3, 1.2, 2.5; [Quotient predicates](#dependency-quotient-predicates) (1.17); [Covering spaces and universal covers](#dependency-covers) (Stage 0.2–0.4; Stage 1.5; Stage 2.6–2.8); [Smooth bundle and connection foundations](#dependency-smooth) (B1.5; B5.0; B5.2).

<a id="target-4-3"></a>
### 4.3 Riemann–Hilbert and compatibility on the whole phase space

**Painlevé application.**

**Hypotheses.**

- The full stable moduli family of 3.5/3.8, the strong splitting of targets 3.9–3.12, and the decorated analytic reconstruction and Betti family of 4.1–4.2. Holomorphic descent and all-source horizontal compatibility are to be proved; an inverse is asserted only on the specified irreducible/nonresonant locus.

The regular-singular RH map and its all-point horizontal compatibility are imported through MeromorphicConnectionModuli §2.5, after identifying the same parabolic moduli and residue-parameter target. This import does not discharge the irregular local reconstruction.

Construct RHθ: Mθᵃⁿ → Rθ over Bθ by the analytic classification and prove that it is holomorphic. Prove that it sends every horizontal trajectory of §3.9 to the transport of §4.2, including trajectories inside resonance, reducible and exceptional loci. On the stated stable irreducible/nonresonant open locus prove the inverse comparison; elsewhere record the actual fibers and decoration data rather than asserting injectivity. Compare the integrable-extension construction with the local analytic reconstruction, and descend from universal-object covers. (IIS06, Theorems 4.10–4.12; IS12, Theorem 5.1; I23, §9 and §11.)

The theorem's all-strata scope is a construction target: the generic unramified theorem is one of its inputs, not a replacement for the missing resonant or ramified comparison. No scalar equation is used in the extension across these loci.

**API.**

- Construct the holomorphic RH map from the universal-object cover and prove descent and base-change naturality.
- Compare the decorated local reconstruction with the forgetful ordinary character quotient.
- Prove horizontal compatibility at every retained point and the inverse theorem only on its stated open locus.

**Checks.**

- Two distinct points on an exceptional fiber can have the same ordinary character; the construction must not choose one as an inverse.
- At a resonant logarithmic point, equal eigenvalues do not justify deleting either the allowed scalar or unipotent stratum.
- Retaining exponent lifts distinguishes θ from θ + 1 even when their ordinary exponential eigenvalues agree.

*Needs:* Internal: 3.5, 3.8, 3.9, 3.10, 4.1, 4.2, 1.2, 2.5.

<a id="target-4-4"></a>
### 4.4 Proper comparison for the full classical input class

**Painlevé application.**

**Hypotheses.**

- The RH map constructed in 4.3 for the full admitted classical time/parameter family, with exponent lifts and closed character constraints retained, and every allowed stable source stratum. Uniform lattice bounds, extension of decorations, stable replacement, compact containment and relative properness are not assumed; this target owns their proofs.

On the four-logarithmic-point branch, verify 2·4 − 2·2 − 2 = 2 > 0 and the fixed-determinant/marking comparison, then apply MeromorphicConnectionModuli §2.6 (I13, Theorem 2.2). The source retains the exponent parameters by a fiber product. No general irregular properness is inferred from this regular-singular theorem; the all-classical extension below remains an owned target.

For each admitted degree-four rank-two input and every allowed exponent parameter, prove that RHθ is proper as a map of the whole time family, with the exponent lift retained in its target, on the full stable moduli space of §3.5. Establish the corresponding family statement on admitted parameter charts; properness of each fixed-time map is not sufficient. The target has the ordinary generalized character data with its fixed closed constraints; no solution-dependent open subset is removed. State surjectivity onto the realizable component separately from properness. This includes resonant logarithmic and stable reducible points and the generic ramified local structures defining the classical class. (IIS06, Definition 2.11 and Theorems 4.10–4.12; IS12, Theorem 5.1 and the scope warning of Remark 6.3; HEU10, Theorem 1.1.)

The required extension is owned here. Develop the proof through four concrete intermediate results: boundedness of local lattices uniformly over compact families of generalized characters with fixed exponent lifts; extension of the retained flags and factorized structures in a relative projective parameter space with their closed incidence relations; semistable replacement after the necessary base change and elementary modifications, followed by semistable = stable for the chosen weights and uniqueness in the separated moduli problem; and compatibility of these extensions with global gluing and the analytic moduli topology. Stability is open but is not thereby preserved by arbitrary limits. Verify that these results give compact inverse images of compact subsets, rather than merely closed fibers or pointwise solvability. A projective flag variety alone does not prove the theorem, since the underlying connection may also escape.

HEU10's universal strong isomonodromic deformation gives an independent possible route to the continuation conclusion of §4.6. Such a route must establish the identification of the time bases, extension of local decorations, determinant and stability preservation, bundle-jumping compatibility, descent, and equality with §3.9. It does not by itself prove the properness required in this target. I23's global foliation theorem and IS12's generic theorem also do not discharge it. The compactness theorem remains an explicit internal proof-development task.

*Needs:* Internal: 3.5, 3.6, 3.7, 3.8, 4.1, 4.2, 4.3, 1.3, 2.6; [Quot/Hilbert and parameter schemes](#dependency-quot) (4.14); [Native topological properness](#dependency-proper) (IsProperMap).

#### Examples

An exceptional RH fiber can be a projective curve. A chosen point on it is still an initial condition and has its own horizontal lift; taking an arbitrary inverse of the coarse RH map would discard this information. A trivial-bundle chart may fail the strong Riemann–Hilbert problem at an isolated time even though the full bundle-valued connection continues.

#### Dependencies

Use the exact *Needs* list at each target and the cross-package registry in `design/reuse_registry.json`. General proof prerequisites belong to their independent package; this layer verifies its stated application comparisons.

<a id="target-4-5"></a>
### 4.5 Classical horizontal germs from general local theory

**Painlevé application.**

**Hypotheses.**

- The constructed holomorphic flat splitting and admitted parameter charts; no solution operator is an input.

Apply NonlinearConnections §0.3 to the actual holomorphic flat splitting of §§3.9–3.10. A geometric Painlevé germ is its native horizontal-section germ with specified initial point; the evaluation bijection, local uniqueness and holomorphic parameter dependence are the general outputs. Verify that the admitted parameter charts of targets 3.1–3.4 meet the joint-holomorphic hypotheses. The analytic existence and parameter-dependence proof is owned by 0.3.

**API.**

- Verify the joint-holomorphic family hypotheses and identify geometric Painlevé germs with the imported section germs.
- Use the general evaluation bijection and naturality on the actual classical fibers.

**Checks.**

- On π: B × F → B with the product splitting, a horizontal section is b ↦ (b,x₀), not an arbitrary map B → F.
- A section must satisfy dπ ∘ ds = id; a constant map into the total space is not a section over a nonconstant time neighborhood.
- For the holomorphic vector field q′ = q² with q(0) = 1, the local solution is 1/(1 − t); local existence does not imply continuation in the affine phase chart through t = 1.

*Needs:* Internal: 3.9, 3.10, 0.3.

<a id="target-4-6"></a>
### 4.6 Classical completeness by proper semiconjugacy

**Painlevé application.**

**Hypotheses.**

- The actual classical RH comparison, complete target transport, all-point partial-lift compatibility and properness proved in targets 4.1–4.4; source completeness is the conclusion.

Apply NonlinearConnections §0.4, whose continuous-time local ODE and compact-extension floor is 0.2, to the constructed phase family. Verify the complete target transport of §4.2, the actual partial-lift compatibility of §4.3 at every permitted point, and the relative proper map of §4.4. Obtain a unique horizontal lift for every admitted θ, initial time b₀, point x₀ ∈ Mθ,b₀ and compact piecewise C¹ path in Bθ beginning at b₀. The target may be singular, and exceptional fibers are retained. Neither a local inverse of RH nor properness of π is required. The general compact-containment proof lives entirely in NonlinearConnections; this target owns the classical hypothesis checks and the resulting geometric Painlevé property. Poles of a chosen scalar observable do not change the admitted base.

**API.**

- Check the hypotheses of the general proper-transfer theorem, including exceptional fibers.
- Export the full initial-point and compact-path quantifiers independently of every scalar chart.

**Checks.**

- For y′ = y², y(0) = 1, the projection of M = ℂ_t × ℂ_y to the complete target time line is compatible but not proper. Along t ∈ [0,1), y = 1/(1 − t), with values 2 and 4 at t = 1/2 and 3/4, and no finite value at 1. This excludes replacing properness of F by mere continuity or projection compatibility.
- For identity F on the trivial family and constant fiber transport, the proper transfer returns the unique constant fiber coordinate. For a proper fiber with an exceptional curve, the compact-containment argument uses its compact preimage and never selects an inverse of F.
- The base path γ(s) = |s − 1/2|³ᐟ² on [0,1] is C¹, while γ′ is not C¹ at 1/2. Its constant-splitting lift is a valid input to the continuous-time local theorem; a proof requiring the autonomized field to be C¹ would impose an unsupported extra hypothesis.

*Needs:* Internal: 4.2, 4.3, 4.4, 4.5, 0.4.

<a id="target-4-7"></a>
### 4.7 Classical transport, universal-cover sections and descent

**Painlevé application.**

**Hypotheses.**

- The actual complete flat classical connection, with proved symplectic preservation; its groupoid action is an output of the general construction.

Apply NonlinearConnections §0.5 to the flatness of §3.10 and completeness of §4.6. Its construction produces the actual endpoint transport, fundamental-groupoid action and universal-cover horizontal section through every classical initial point. Identify this action with the constructed connection rather than assuming a monodromy action as input. Use §3.11 and NonlinearConnections §0.6 for symplectic preservation. Descend precisely for initial points fixed by the resulting deck/monodromy action; completeness alone does not imply single-valuedness on Bθ.

**API.**

- Identify the imported transport and universal-cover sections on the classical moduli family.
- Verify presentation compatibility and the actual stabilizer condition for descent.

**Checks.**

- A path followed by its reversal gives the identity on every initial condition, including exceptional points.
- On B = ℂ× with H = qp/(2t), the equations are q′ = q/(2t), p′ = −p/(2t). A positive generator of π₁(B) sends (q,p) to (−q,−p), and two such loops give the identity. The symplectic multiplier is (−1)(−1) = 1, while a trivial-transport implementation would give the wrong first loop.
- In that model only the origin is fixed by the generator. Every other initial point gives a complete section on the universal cover that does not descend to B; completeness alone is insufficient for descent.

*Needs:* Internal: 3.10, 3.11, 4.6, 0.5, 0.6.

<a id="target-4-8"></a>
### 4.8 Classical observable adapters

**Painlevé application.**

**Hypotheses.**

- The classical phase family and a specified candidate observer/domain; non-indeterminacy and any required lift are proof obligations.

Use the observable notion of NonlinearConnections §0.7 on the classical phase family. Own the construction of each claimed classical morphism to ℙ¹, or its stated rational domain and resolution/lift comparison. Prove defined pullback along every claimed solution stratum and exclude an identically infinite pullback before calling the result a scalar meromorphic function. Observers, their domains and normalization remain explicit data; the generic evaluation theorem does not supply these application-specific verifications.

**API.**

- Construct the actual classical observer and verify its pullback/lift domain.
- Compare its normalizations and overlap maps using the general observable naturality law.

**Checks.**

- Q ≡ ∞ is an everywhere defined ℙ¹-valued observer, but it does not produce an ordinary meromorphic function with isolated poles.
- The rational map [x:y] on ℂ² is undefined on the constant curve (0,0); rationality alone does not define a pullback along every solution.
- In the infinity chart, Q(t) = 1/t becomes 1/Q(t) = t, holomorphic at 0. Its pole is a chart event, not a failure of geometric continuation.

*Needs:* Internal: 4.5, 4.7, 0.7.

<a id="target-4-9"></a>
### 4.9 Meromorphic evaluation on the classical time curve

**Painlevé application.**

**Hypotheses.**

- The proved time-curve dimension, the complete horizontal section and an observer with the verified pullback and non-infinity conditions.

Verify the one-dimensional time conclusion of §3.4 and apply NonlinearConnections §0.7 to §§4.7–4.8. Every claimed non-identically-infinite scalar evaluation is meromorphic on the universal cover of the admitted time curve, with finite-order poles at its interior scalar singularities. Observer resolution and non-indeterminacy for every claimed stratum remain the application obligations of §4.8. The single-valued descent criterion is separate. This transfers one intrinsic theorem to the coordinate comparisons, rather than proving six scalar continuation theorems.

**API.**

- Export the meromorphic evaluation theorem only on the verified classical observer domains.

*Needs:* Internal: 3.4, 4.7, 4.8, 0.7.

#### Examples

The affine equation q′ = q² has a movable pole at t = 1 for q(0) = 1. Its projective vector field extends in u = 1/q as u′ = −1. This separates affine-coordinate escape from geometric continuation. On B = ℂ*, a horizontal system can have complete continuation on the universal cover and nontrivial monodromy around 0; this does not contradict the theorem.

#### Dependencies

Use the exact *Needs* list at each target and the cross-package registry in `design/reuse_registry.json`. General proof prerequisites belong to their independent package; this layer verifies its stated application comparisons.

<a id="layer-5"></a>

## Layer 5: Initial-condition surfaces, symmetries and Riccati reductions

<a id="target-5-1"></a>
### 5.1 Additive Okamoto–Painlevé pairs

**Painlevé application.**

**Hypotheses.**

- Smooth rational projective surface; effective anticanonical Y; Y·Y_i=0; SNC support; additive Picard identity component; nonfibered type.

Define the comparison groupoid of smooth projective rational surfaces S with a nonzero effective anticanonical divisor Y, satisfying Y·Yᵢ = 0 for every irreducible component, with D = Y_red a simple normal-crossing divisor. Require additive type, expressed by the additive identity component of Pic⁰(Y), and nonfibered type: no elliptic fibration has a fiber nY with n ≥ 1. Retain markings when a root basis or normalized time is used. Construct the relative versions of these conditions. (STT02, Definitions 1.1 and 1.3, Proposition 1.2 and Tables 2–3.)

**API.**

- Extract the weighted boundary intersection graph and the orthogonal lattices in Pic(S).
- Prove invariance under pair isomorphisms and compatibility with admissible families.
- Compare the complement S \ D with its logarithmic tangent and two-form sheaves.
- Distinguish the boundary-root lattice from a symmetry-root lattice.

**Checks.**

- A smooth elliptic anticanonical boundary has elliptic Picard identity component, not additive, and is excluded.
- A multiplicative cycle has multiplicative Picard identity component and is excluded.
- Requiring a global affine-plane chart would exclude the D₈ case; that additional requirement is absent.

**Supporting constructions owned by this target.**

- Apply 1.5 relative Picard only after proving the proper-flat/projective family, universal-functions, H²-vanishing and identity-component hypotheses for the possibly nonreduced anticanonical Y. Compute the identity component with normalization, units and successive nilpotent-thickening exact sequences, and prove the additive-group comparison defining additive type. Construct Θ(−log D) as derivations preserving the reduced-boundary ideal, with D=Yred SNC; multiplicities belong to Y, not to the SNC predicate. Prove the relative Picard lattice/intersection and deformation comparisons on the actual surface family. SSF5.9’s surface-over-field or arithmetic-surface pairing is a foundation, not an automatic arbitrary-base family result.

*Needs:* Internal: 1.5; [Cohomology with supports](#dependency-supports) (2.7); [Divisors, modifications and surface intersections](#dependency-surfaces) (3.4; 4.11; 4.17; 5.9–5.10); [Algebraic vector bundles and finite locally free sheaves](#dependency-bundles) (L0A–L0C; L1A–L1B; L2A–L2B).

<a id="target-5-2"></a>
### 5.2 Compactification and the eight boundary types

**Painlevé application.**

**Hypotheses.**

- The full classical phase family with the intrinsic form and splitting from targets 3.1–3.12, the pair framework of 5.1, and the stated markings/admissible base changes. Construction of the compactification, the eight boundary types, equality of its full complement with the phase family, and the form/distribution comparison are conclusions.

Construct a compactification of the degree-four connection moduli family with the pair structure of §5.1, after the stated marking/base changes, and prove that its complement is the full phase family. Prove the extension and comparison of the symplectic form and time distribution, including exceptional curves and nontrivial bundle charts. Classify the additive normal-crossing boundary types as D₄, D₅, D₆, D₇, D₈, E₆, E₇ and E₈. These are affine boundary diagrams. (STT02, Proposition 1.2 and Tables 2–3; VDPS09, introduction and Table 1; IIS06, §10 for the fully established PVI comparison.)

The all-profile comparison is a construction and proof target. VDPS09's introductory conjectural global comparison is not used as an established theorem. Prove overlap identifications, coverage and the extension at the omitted charts before asserting a global isomorphism. The compactification is not used to bypass §4.4 or to infer completeness merely from existence of a foliation.

**API.**

- Construct the relative compactification and its boundary divisor with its multiplicities and intersection pairing.
- Prove the full open-complement comparison, including bundle-jumping and exceptional charts.
- Compare the deformation and relative two-form under that isomorphism, and record the marking/base-change law.

**Checks.**

- Two presentations of boundary type D₆ can have different formal pole data; the common boundary label alone is not a moduli isomorphism.
- The D₈ complement must be retained even without the extra affine-plane hypothesis of older definitions.
- An omitted exceptional curve invalidates the full-complement assertion even if the open rational chart and its scalar formula are correct.

*Needs:* Internal: 3.3, 3.4, 3.5, 3.6, 3.7, 3.8, 3.9, 3.10, 3.11, 3.12, 5.1; [Cohomology with supports](#dependency-supports) (2.7); [Divisors, modifications and surface intersections](#dependency-surfaces) (3.4; 4.11; 4.17; 5.9–5.10); [Quot/Hilbert and parameter schemes](#dependency-quot) (4.14).

<a id="target-5-3"></a>
### 5.3 Intrinsic comparison of the time line

**Painlevé application.**

**Hypotheses.**

- The admitted nonfibered additive pair families of 5.1–5.2 and the intrinsic time splitting of targets 3.9–3.12. The first boundary-layer sheaf is specified; its rank-one result, locally free base change and Kodaira–Spencer/time comparison are proved here. Equality with all supported cohomology is not assumed.

Let F = Θ_S(−log D) and N_D = O_S(D)/O_S. Construct L = H⁰(D,F ⊗ N_D), prove that it is one-dimensional for these pairs, and construct its injection into local cohomology. Establish the family/base-change theorem for L and compare its Kodaira–Spencer image with the time direction of §3.9. Prove the connecting-map/intersection-matrix identity intrinsically; do not repeat a different coordinate computation for each boundary graph. (TER02, Theorem 2.1 and Proposition 2.1; STT02, Theorem 3.1.)

Do not assert equality with the entire local-cohomology space as a standing premise: TER02 Conjecture 2.1 and the restricted results of ST04 Appendix A have different scope. A line is not a distinguished nonzero vector; a normalized time supplies a generator. Prove equality of the lifted distributions by the deformation comparison and uniqueness on the prescribed algebraic complement.

**API.**

- Construct the first boundary-layer line, its injection into supported cohomology and its restriction maps.
- Prove the intersection-matrix formula and the dimension calculation without choosing a scalar Painlevé chart.
- Establish locally free base change and the comparison of its Kodaira–Spencer image with the time tangent line.

**Checks.**

- Rescaling a chosen nonzero time vector rescales its image in L, while L itself is unchanged.
- The injection L → H¹_D(S,F) alone does not prove that its target is one-dimensional.
- Over A = ℂ[ε]/(ε²), the module A/(ε) has a one-dimensional fiber at the unique point but is not a free rank-one A-module: its ℂ-length is 1 instead of 2. Constant fiber dimension alone therefore does not establish the claimed locally free base change; the actual cohomological hypotheses must be proved.

**Supporting constructions owned by this target.**

- Use SchemeAndStackFoundations 2.6 and 2.7 for quasi-coherent and supported cohomology, the localization exact sequence, and the Noetherian colimit-of-Ext comparison. Use JacobianChallenge Layer C for coherent proper pushforwards and its separately stated base-change criteria. For the actual family of logarithmic surfaces, construct F and N_D as sheaves, the first boundary-layer injection and its connecting-map/intersection-matrix comparison. Prove the properness, coefficient flatness and cohomology/base-change hypotheses used to make the relative H0(D,F tensor N_D) invertible, and prove arbitrary base-change compatibility through the actual finite-projective complex or the precise surjectivity criterion. Fibrewise dimension one is not the proof on a nonreduced base. The target compares this line with the Kodaira–Spencer time line; it asserts no equality with all supported H1_D.

*Needs:* Internal: 3.9, 3.10, 3.11, 3.12, 5.1, 5.2; [Cohomology with supports](#dependency-supports) (2.7); [Divisors, modifications and surface intersections](#dependency-surfaces) (3.4; 4.11; 4.17; 5.9–5.10); [Cohomology, duality and curve degree](#dependency-cohomology) (2.2; 2.6; 2.20; 3.3); [Elementary deformation theory](#dependency-deformation) (4.2–4.6); [Proper coherent direct images and base change](#dependency-proper-cohomology) (Layer C).

#### Examples

The boundary type E₈ is associated with one ramified rank-two presentation, while E₇ has two. Thus a boundary label and a connection presentation are different kinds of data. The first boundary-layer line has dimension 1; claiming the same dimension for every full local-cohomology group would require an additional theorem and is not used here.

#### Dependencies

Use the exact *Needs* list at each target and the cross-package registry in `design/reuse_registry.json`. General proof prerequisites belong to their independent package; this layer verifies its stated application comparisons.

<a id="target-5-4"></a>
### 5.4 Functors on decorated connections

**Painlevé application.**

**Hypotheses.**

- An admitted decorated connection, an invariant local quotient for a modification or the specified line connection/duality/relabeling data. The transformed determinant, local exponents, stable locus and strong-extension comparison are construction outputs.

Construct elementary modifications along an invariant local flag, tensor product with an admitted rank-one connection, duality and relabeling as functors between the actual decorated moduli problems. Specify the new determinant, exponent and stability data and the locus on which the transformed object is stable. Use the kernel construction for a modification, its induced connection, and the inverse modification; retain the comparison arrows. Extend these functors to strong integrable families by preservation of the allowed pole filtration and kernel lattices. (IIS06, Definition 3.5 and §7; I23, §§2–4 and Definition 10.1.)

**API.**

- Construct the transformed bundle and connection before passing to coarse moduli, with their determinant and local-type formulas.
- Prove pullback, composition and inverse comparisons on their specified domains.
- Describe the change of weights or required wall-crossing correspondence instead of declaring stability invariant without proof.
- Distinguish a functorial isomorphism of moduli problems, an open birational correspondence and a scalar solution substitution.

**Checks.**

- Modifying along a one-dimensional quotient at a logarithmic pole changes the bundle degree by −1; leaving the determinant unchanged fails the determinant comparison.
- Tensoring rank two by a line connection L changes the determinant by L², including its connection; it does not construct a square root of a previously fixed odd-degree determinant.
- The inverse modification recovers the original decorated object with its arrow on the common admissible locus, while forgetting the distinguished flag need not permit the inverse.

*Needs:* Internal: 3.1, 3.5, 3.9, 1.1; [Algebraic vector bundles and finite locally free sheaves](#dependency-bundles) (L0A–L0C; L1A–L1B; L2A–L2B).

<a id="target-5-5"></a>
### 5.5 Horizontal and symplectic transformation laws

**Painlevé application.**

**Hypotheses.**

- The connection functors of 5.4, the deformation pairing and intrinsic splitting of targets 3.5–3.12, and the marked-surface comparison of 5.2. Additional marked-pair reflections, their actual regular/birational domains, horizontal/symplectic extension and relations must be constructed and proved here.

Prove that each admitted transformation intertwines h by applying the uniqueness of strong extensions to its transformed family. Prove the transformation law for ω by the induced map of deformation complexes and trace pairing. Construct the resulting action groupoid on the parameterized moduli family, and establish relations by natural isomorphisms of the functors. On a marked surface compare its action on Pic(S) with the corresponding integral root reflections and diagram automorphisms. State the actual symmetry root lattice and its parameter hyperplanes separately from the boundary root diagram. (IIS06, Theorem 7.4 and Theorem 10.13 for PVI; STT02, Tables 2–3 and the marked deformation construction.)

The functors in §5.4 are not assumed to generate the full affine Weyl group. Construct the additional reflections on the moduli of marked pairs, identify the induced birational correspondence of connection moduli through §5.2, and prove its horizontal and symplectic extension on the claimed domain. The central PVI reflection is a required test: it is not generated merely by the local gauge modifications listed in §5.4. IIS06 Remark 7.5(2) describes a Fourier-transform realization; a Fourier–Laplace or middle-convolution implementation would likewise require its own functor and strong-extension comparison. The marked-surface construction is the specified route here. The PVI theorem is not cited as a theorem for every profile. Verify the actual reflection and Coxeter relations, effective-locus conditions and extension across chart complements before deriving rational Bäcklund formulas in §7.4. An identity of rational maps on a dense open set must be upgraded before claiming an everywhere defined automorphism.

**API.**

- Construct the marked-pair reflection correspondences and compare them with the connection-functor generators on their common domains.
- Prove horizontal and symplectic intertwining, relations and compatibility with parameter changes.
- Record the regular domain and the extension theorem for each claimed global map.

**Checks.**

- The PVI central reflection sends κ₀ to −κ₀ and κⱼ to κⱼ + κ₀ for j = 1,2,3,4. It preserves 2κ₀ + Σκⱼ = 1: at κ₀ = 1/2, κⱼ = 0 the transformed tuple has κ₀ = −1/2 and κⱼ = 1/2, giving −1 + 2 = 1. Omitting the κ₀ sign change gives 3 instead. Local integer shifts and sign changes alone do not construct this reflection.
- A reflection squared must give the original marked family with its comparison arrow, not merely the same boundary diagram.
- A birational formula with a pole on an invariant curve is not an automorphism of that curve until a regular extension is proved.

*Needs:* Internal: 3.6, 3.7, 3.12, 5.2, 5.3, 5.4; [Cohomology with supports](#dependency-supports) (2.7); [Divisors, modifications and surface intersections](#dependency-surfaces) (3.4; 4.11; 4.17; 5.9–5.10).

<a id="target-5-6"></a>
### 5.6 Invariant rational curves and Riccati dynamics

**Painlevé application.**

**Hypotheses.**

- An interior smooth rational curve of self-intersection −2 in an admitted nonfibered additive pair, its stated semiuniversal pair deformation, and the time-direction comparison of 5.3. The continued curve family, its invariance and projective linearization are conclusions, with the required local or finite-base-change scope.

For the admitted nonfibered additive pair, construct the local family of an interior smooth rational curve C with C² = −2. Fix the external parameters at α₀ and, for the curve C in the fiber over (α₀,t₀), construct its family locally along the time base {α₀}×U, with U an analytic or étale neighborhood of t₀; an extension in external-parameter directions requires a separately proved nodal-curve locus and is not inferred from the semiuniversal pair deformation. Prove invariance under the time distribution using the logarithmic deformation sequence. Retain the étale or finite base change needed to continue that family; descent to the original base requires its own monodromy check. On the resulting relative ℙ¹-bundle, identify the restricted connection as a projective linear connection, using H⁰(ℙ¹,Tℙ¹) ≅ sl₂. The coordinate lemma then has q′ = a(t)q² + b(t)q + c(t). A linear rank-two lift is asserted locally, or globally only with its lifting obstruction resolved. (ST04, §2.4, Proposition 2.1, Remark 2.4 and Definition 2.3.) The PVI comparison with the Gauss equation is IIS06 Theorem 5.15; its Theorem 5.16 assumes analytic Painlevé property and is not used as a premise of this independent geometric construction.

Classify these interior nodal configurations by the boundary intersection lattice under ST04 Theorem 3.1's hypotheses. Deduce its nonexistence statement for the E₈, D₇ and D₈ boundary types. Linearization gives the relevant classical special-function families after the coordinate comparisons; the parameter restrictions and normalizations remain part of those lemmas.

**API.**

- Construct restriction of h to the invariant curve family and prove that its projection to time remains a splitting.
- Compare two projective coordinates by the induced Möbius gauge law, and compare local rank-two linearizations.
- Prove preservation under the admitted geometric transformations when they extend as regular isomorphisms along the whole curve family; otherwise construct the closure and prove the required curve and invariance properties separately.
- Compare the nodal-curve condition with reducible connections or exceptional RH fibers only in the presentations where that identification is proved.

**Checks.**

- A holomorphic vertical vector field on ℙ¹ has a polynomial coefficient of degree at most two in an affine coordinate; a cubic coefficient fails regularity at infinity.
- A ramified generic local factor forces global irreducibility, but an E₇ ramified presentation can still have an invariant Riccati curve. Thus “Riccati if and only if globally reducible connection” is not a presentation-independent theorem.
- A family of curves can be permuted by continuation around the time base; a local invariant curve does not automatically give a globally labeled subfamily.
- A rational solution need not lie on a Riccati curve; ST04 §6.2 supplies this distinction. This target is not a classification of all rational solutions.

*Needs:* Internal: 3.9, 3.10, 3.11, 3.12, 5.1, 5.2, 5.3, 5.4, 5.5; [Cohomology with supports](#dependency-supports) (2.7); [Divisors, modifications and surface intersections](#dependency-surfaces) (3.4; 4.11; 4.17; 5.9–5.10); [Quot/Hilbert and parameter schemes](#dependency-quot) (4.14); [Complex manifolds, holomorphic bundles and observations](#dependency-complex) (K1; K3.0; K3.HolomorphicStalk; K3.MeromorphicGermField; K4; K7.1).

#### Examples

In the PII chart of §7.5 the curve p = 0 is invariant at α = −1/2. Its Riccati equation is the coordinate expression of a projective connection on that curve. The seed q = 0 at α = 0 has different geometry; it must not be used to infer that all rational solutions arise from invariant Riccati curves.

#### Dependencies

Use the exact *Needs* list at each target and the cross-package registry in `design/reuse_registry.json`. General proof prerequisites belong to their independent package; this layer verifies its stated application comparisons.

<a id="layer-6"></a>

## Layer 6: Determinant lines and tau sections

<a id="analytic-theory"></a>

**Purpose.** Separate general analytic theorems from their geometric and special-function applications. The inputs are operator families, contour packages, jump matrices, weighted estimates, holomorphic line comparisons and trace-class estimates. None of the seven contracts requires a Painlevé equation, a rank-two formal profile, a phase-space dimension, a selected asymptotic branch, or a collision of meromorphic connections.

### Reuse and ownership

| Contract | General input and output | Proof owner |
| --- | --- | --- |
| 6.1 | Index-zero holomorphic Fredholm family → determinant line, canonical section and naturality | This roadmap: 6.1 |
| 8.1 | Contour geometry → Cauchy operators, solution class and reconstruction criteria | This roadmap: 8.1 |
| 8.2 | Cauchy package and uniform norm gap → unique residual solution and estimates | This roadmap: 8.2 |
| 8.3 | Weighted moments and tail control → coefficients and precisely quantified uniform asymptotics | This roadmap: 8.3 |
| 9.3 | Compared line sections, corrected one-forms and normalization → local uniform scalar convergence | This roadmap: 9.3 |
| 9.4 | Trace-norm holomorphic operator convergence → determinant convergence and conditional local zero counts | This roadmap: 9.4 |
| 8.4 | Canonical entire Barnes G → zero divisor, normalized logarithms and explicit sectorial remainder | This roadmap: 8.4 |

The local dependency chain is 8.1 → 8.2 → 8.3. Targets 6.1, 9.3 and 9.4 have their own foundational inputs; 9.3 and 9.4 are independent convergence routes. RandomMatrices §8.3 supplies the generic trace-class determinant. 6.1 owns the complex holomorphic Fredholm determinant-line family. Existing real orientation lines, matrix-symbol Toeplitz index results and trace-class determinants are not silently substituted for one another.

Applications must verify their own adapters: the contour and endpoint bounds of a parametrix, the actual operator-family or trace-class realization, line and frame comparisons, meromorphic-connection reconstruction, and any JMU/Hamiltonian comparison. The general theorems consume the precisely stated analytic data. Special-function conclusions do not enter their prerequisites.

### Source scope and analytic conditions

Bibliographic information and source locators are listed in [sources.toml](sources.toml). The source models are [MAL04](https://www.numdam.org/articles/10.5802/aif.2052/), [BERT17](https://arxiv.org/abs/1703.00046v4), corrected [BERT16](https://arxiv.org/abs/1601.04790v2), and [ILP18](https://arxiv.org/abs/1604.03082v4), at the locators stated in the targets. These references are not asserted to prove the entire general contract.

6.1 checks stabilization, sections and determinant conventions. The endpoint ghost, the noncompact-contour L² issue, the separate determinant-removability obligation, the ρ = 1 loss and the solvable non-small jump are diagnostics in 8.1–8.2. The translated Gaussian, including its exact sign and constant, and the uniform-tail and extra-moment distinctions are diagnostics in 8.3. The normalization-constant, moving-Hilbert-space, zero and endpoint caveats are diagnostics in 9.3–9.4. A connection reconstruction theorem or a collision comparison is a downstream adapter, not an implicit assumption of any generic analytic result.

<a id="target-6-1"></a>
### 6.1 Holomorphic determinant lines for index-zero Fredholm families

**General theory.**

**Hypotheses.**

- A finite-dimensional complex manifold S and a holomorphic family of bounded complex Fredholm operators of index zero, initially between fixed complex Hilbert spaces.
- Finite-dimensional determinant and exact-sequence conventions, bounded local splittings and holomorphic Banach-space inversion; the line, stabilizations, canonical section and comparison cocycles are outputs.

Construct the holomorphic determinant-line family using the complex specialization of the native Fredholm, determinant-line and finite-dimensional stabilization objects. The holomorphic atlas, canonical section and coherent gluing are constructions of 6.1. For a holomorphic family T_s: H₀ → H₁ of bounded complex Fredholm operators of index zero on a finite-dimensional complex manifold S, initially with fixed complex Hilbert spaces, construct a holomorphic line L_T and its canonical determinant section τ_T. Use the convention L_T,s = det(ker T_s)* ⊗ det(coker T_s), dual to the real orientation-line convention. Construct the line even when the dimensions of kernel and cokernel jump. (MAL04, §2, printed pp. 1372–1374, gives the determinant-extension model; BERT17, §1, gives an RHP application within its stated symbol class.)

Locally choose a finite-dimensional complex space F and a: F → H₁ such that (T_s,a): H₀ ⊕ F → H₁ is surjective. Prove that K = ker(T,a) is a holomorphic vector bundle of rank dim F, using a local bounded splitting and holomorphic inversion. Set L_F = det K* ⊗ det F and τ_F = det(K → F), where K → F is the projection. Construct comparison maps under adding stabilizing summands and then through common refinements; prove their cocycle and section-compatibility laws before gluing. Fix the exact-sequence sign convention by requiring that a finite-dimensional family has its ordinary determinant in the standard determinant frame. Prove independence of all stabilization choices, holomorphic base change and naturality under isomorphisms of operator families. Use these same comparison laws to extend from fixed Hilbert spaces to holomorphic Hilbert bundles with specified local trivializations.

Identify τ_T(s) ≠ 0 exactly with invertibility of T_s. Existence of L_T does not imply that τ_T is generically nonzero, nor that it defines an effective divisor without additional hypotheses. Closedness of a proposed curvature two-form does not supply an integral transition cocycle. Applications pull back this one construction and separately establish any RHP realization or logarithmic-derivative formula. This target is restricted to complex-manifold bases and holomorphic base changes between such bases. Nonreduced analytic bases require a separate sheaf-valued operator-family extension retaining nilpotent coefficients; pointwise operators do not determine that extension.

**API.**

- Construct the stabilization kernel bundles, determinant lines and canonical sections with the declared dual convention and finite-dimensional sign calibration.
- Prove refinement compatibility, the cocycle law, stabilization independence and holomorphic base change.
- Prove naturality under operator-family isomorphisms and glue the Hilbert-bundle version through its specified trivializations.
- Identify the section’s nonvanishing locus with the invertible-operator locus without assuming generic nonvanishing or a divisor.

**Checks.**

- For T_s: ℂ → ℂ, z ↦ sz, the standard frames give τ(s) = s, fixing the dual convention.
- For T_s(z) = s²z, the zero has order two although dim ker T₀ = 1; no unconditional equality between vanishing order and kernel dimension is supplied.
- An everywhere invertible constant family has nonvanishing determinant section; an identically singular index-zero family may have an identically zero section without invalidating its line.
- Two finite-dimensional stabilizations must give the same section after comparison through a common refinement, and a third stabilization must not change that comparison.

- `holomorphicFredholmDeterminantLineCheck5` (scope boundary) — On the dual-number base, T=ε and T=0 have the same pointwise operator but determinant sections ε and 0. This nonreduced base is excluded from the present manifold-base theorem; an extension to nonreduced bases requires sheaf-valued operator coefficients.

**Supporting constructions owned by this target.**

- Consume Mathlib's complex ContinuousLinearMap.IsFredholm and nonempty_fredholmPackage, Tau Ceti's IsFredholm.exists_stabilization_kernel_coordinates, kernelHomeomorph and contDiffAt_kerSection, and the pointwise detLine/detLineCongr API. The latter has fibre det ker(T) tensor det coker(T)*; use its dual for L_T. These scalar-generic suppliers apply over C. This target constructs the holomorphic determinant bundle, its canonical section, stabilization comparisons and holomorphic base-change laws. For the holomorphic transition maps use native analytic inversion in the bounded-operator Banach algebra and the actual finite-dimensional stabilization charts.

*Needs:* [Native complex Fredholm and determinant carriers](#dependency-fredholm) (IsFredholm; nonempty_fredholmPackage; exists_stabilization_kernel_coordinates; kernelHomeomorph; contDiffAt_kerSection; detLine; detLineCongr); [Native analytic inversion](#dependency-inversion) (analyticAt_inverse; analyticAt_inverse_one_sub); [Complex manifolds, holomorphic bundles and observations](#dependency-complex) (K1; K3.0; K3.HolomorphicStalk; K3.MeromorphicGermField; K4; K7.1).

<a id="target-6-2"></a>
### 6.2 Importing the complex determinant-line construction

**Painlevé application.**

**Hypotheses.**

- The explicit general complex determinant construction; actual Painlevé operator families are constructed and checked in 6.3.

Use AnalyticRHPAndDeterminants §6.1 for the holomorphic complex index-zero determinant line, its canonical section, finite-dimensional stabilizations and coherent comparison maps. Retain L_T = det(ker T)* ⊗ det(coker T) and the same native complex operator carriers. This target fixes the convention and the import interface used in §6.3; §6.3 must construct the actual operator family and verify index zero and holomorphic dependence. The generic construction is not repeated inside Painlevé, and a real orientation line is not substituted for it.

**API.**

- Fix the dual convention and identify the imported line/section without a second determinant carrier.
- State the exact holomorphic index-zero and descent checks that 6.3 must discharge.

**Checks.**

- For T_s: ℂ → ℂ, z ↦ sz, the standard frames give τ(s) = s, fixing the dual convention.
- For T_s(z) = s²z, the zero has order two although dim ker T₀ = 1; no unconditional equality between vanishing order and kernel dimension is supplied.
- An everywhere invertible constant family has nonvanishing determinant section; an identically singular index-zero family may have an identically zero section without invalidating its line.

*Needs:* Internal: 6.1.

<a id="target-6-3"></a>
### 6.3 An index-zero RHP realization and descent

**Painlevé application.**

**Hypotheses.**

- The decorated connection family and analytic local reconstruction of targets 3.1–4.4, together with the selected auxiliary reference/modification, contours, lattices, branches and normalization. The Fredholm realization and index-zero proof are constructed here; descent is allowed only for comparisons proved to be operator/chain/stable equivalences with acyclic added complexes.

Construct an analytic RHP chart from the decorated connection family of targets 3.1–3.12 and the analytic comparison of §§4.1–4.3. Retain the reference bundle or modification, contours, local lattices, branches, framings and normalization in its marking data. Construct the associated Fredholm operator and prove its index zero; the assertion is not a field added to every connection by fiat. For the initial closed-contour model use a holomorphic invertible jump symbol in a fixed contour neighborhood and zero determinant winding. Compare the solvable normalized RHP with the corresponding marked connection and pull back §6.2's line and section. Extend this construction to the analytic sectorial models for every ramified and resonant stratum retained by §§3.1–3.3, with explicit adapters. Proving these adapters is part of the construction; neither cited generic source is claimed to supply all of them. (BERT17, §1 and Theorem 2.2; MAL04, §2.)

The auxiliary bundle matters. On ℙ¹, rank E = 2 and deg E = d give χ(E(−1)) = d and χ(E(k)) = d + 2k + 2. Thus a degree-minus-one phase object does not acquire an index-zero complex by the unexplained choice E(−1); no integral common line twist has Euler characteristic zero when d is odd. Construct the needed normalized index-zero complex or modification and its comparison with the original connection. Malgrange's degree-zero sewn-bundle construction does not remove this obligation.

Keep the reference bundle and auxiliary modification in the input marking. Unit transition factors for line and section are asserted only for proved equivalences, with any added auxiliary complex everywhere acyclic. An arbitrary change of reference bundle or modification can change the zero divisor. Treat it as a different normalized problem, and construct the relative determinant factor or meromorphic transformation with its divisor instead of declaring the two sections equal up to a unit. BERT17's factorization comparisons do not supply invariance under unrestricted bundle modification.

**API.**

- Construct RHP marking charts and the operator-family functor from their connection data.
- Prove comparison isomorphisms for changes of contour, factorization or normalization which give the same Fredholm family or a proved holomorphic chain/stable equivalence, with their identity and composition laws.
- Construct an equivariant line and section on the marked moduli groupoid/stack. Descend to a coarse space only after proving trivial stabilizer action on the line and section.
- Record exactly which strata have the required analytic adapter; completing the stated adapters is a proof target, not an assertion that the generic cited sources already cover every stratum.

**Checks.**

- The degree-minus-one example fails the E(−1) index test, even though its connection is a valid phase object.
- Scalar automorphisms act by the Euler-characteristic weight, which is zero here; this does not establish trivial action for all other possible stabilizers.
- Two elementary jump factorizations can give different scalar Fredholm determinants. Their nonzero transition factor, not literal equality, is the required comparison.

**Supporting constructions owned by this target.**

- For the initial closed-contour model construct the actual Hardy/Toeplitz comparison and apply T1–T3 to its continuous invertible matrix symbol. Verify zero determinant winding and holomorphic dependence. Prove normalized solvability equivalent to invertibility through the reconstruction map. Zero Fredholm index alone is insufficient for matrix symbols. Sectorial, resonant and ramified models require the separate comparisons specified in this target.

*Needs:* Internal: 3.1, 3.5, 3.6, 3.9, 4.1, 4.2, 4.3, 6.2, 1.2; [Cohomology, duality and curve degree](#dependency-cohomology) (2.2; 2.6; 2.20; 3.3); [Elementary deformation theory](#dependency-deformation) (4.2–4.6); [Stacks, inertia and restricted coarse-space criteria](#dependency-stacks) (1.18–1.23); [Trace-class ideal carrier](#dependency-trace-ideal) (OI-B01–OI-B19; OI-B23; OI-B29–OI-B30); [Matrix-symbol Toeplitz index](#dependency-toeplitz) (T1–T3); [Generic trace-class determinant](#dependency-trace-determinant) (8.3, generic operator-theory prefix).

<a id="target-6-4"></a>
### 6.4 The divisor and corrected variational comparisons

**Painlevé application.**

**Hypotheses.**

- Constructed determinant section; generic nonvanishing for a proper divisor; exact generic JMU and vertex-correction hypotheses.

Prove that the determinant section vanishes precisely where its normalized RHP is not solvable. On a reduced connected smooth chart where it is not identically zero, construct its effective Cartier divisor; obtain a global divisor only through the line comparisons. This is the failure locus of the selected RHP normalization, not a declaration that the intrinsic phase space or horizontal section ceases to exist. On each 6.1 stabilization chart, choose holomorphic frames for the equal-rank bundles K_stab and F and let S(s) represent the projection K_stab→F. The canonical section has representative det S. Prove d log(det S)=Tr(S⁻¹dS) on its nonvanishing locus and the actual logarithmic correction for a change of determinant frame. This gives the determinant-frame form and scalar normalization on every constructed RHP chart, including the ramified and resonant adapters. Equivalently, K_fin=I−S on the finite-dimensional space F gives the displayed trace-class identity. For a claimed infinite-dimensional integrable-kernel realization K, additionally construct its trace-norm holomorphic family and the comparison τ=u det(I−K), with u nowhere zero; only then use d log τ=d log u−Tr((I−K)⁻¹dK). The JMU/Hamiltonian comparison retains its stated generic locus. On the verified integrable-kernel locus derive the variational formula and its frame-change law. (BERT17, Theorem 2.2, Proposition 2.3, formula (3.6), Theorem 3.3 and §3.1.2.)

Compare with the JMU form only under the stated formal-normalization hypotheses: the generic unramified diagonalizable-leading-term and logarithmic nonresonance locus of BERT10 Assumption 3.1 and §5.1, Proposition 5.1. Use BERT16 Definition 2.1 for the corrected sign, Theorem 2.1 for vertex curvature, and Theorem 2.2, which replaces BERT10 Theorem 5.1. The corrected local formula uses ω_M − θ_V, with dθ_V = η_V on the monodromy parameters. Along fixed-monodromy time directions θ_V has no component; factorization/frame corrections still have to be matched. Neither the raw Malgrange form nor its original modification is asserted closed on the full monodromy-and-time space. Removing contour vertices requires a proved sewing comparison.

**API.**

- Construct the section's divisor and its naturality under the comparisons of §6.3.
- Prove the local variational identity and its change under a nonvanishing frame multiplier.
- Construct the comparison with the selected JMU normalization on exactly the generic unramified, diagonalizable-leading-term and logarithmically nonresonant locus stated above. The delivered JMU comparison makes no assertion on additional ramified or resonant strata. On any such stratum with the proved §6.3 RHP adapter, the determinant section and its finite-dimensional stabilization differential remain the specified objects. The infinite-dimensional trace formula requires the separate trace-class realization and determinant-frame comparison.

**Checks.**

- A zero of the chosen tau representative can occur while the intrinsic horizontal solution continues through that time in another bundle chart.
- The family T_s = s² retains its double zero; the divisor calculation cannot replace multiplicity by kernel dimension.
- A graph with nontrivial vertex limits requires the BERT16 correction; disjoint closed contours do not justify omitting it from an unproved graph-to-contour comparison.
- The local connection d + [[0,z⁻²],[z⁻¹,0]]dz has projective slope 1/2: after z = w² and the gauge diag(1,w), its leading coefficient is 2(E₁₂ + E₂₁)/w². It is outside the JMU comparison locus here. A constructed index-zero RHP adapter still carries the determinant section and its finite-dimensional stabilization logarithmic derivative; no unspecified ramified JMU differential is inferred from that fact.

- On an infinite-dimensional complex Hilbert space, T_s=e^s I is a holomorphic invertible Fredholm family, but T_s⁻¹dT_s=I ds has no trace-class trace. Its determinant-line section has local finite-dimensional stabilization representatives. The general Fredholm input therefore does not justify an infinite-dimensional trace formula.

*Needs:* Internal: 4.1, 6.2, 6.3, 1.2; [Generic trace-class determinant](#dependency-trace-determinant) (8.3, generic operator-theory prefix).

<a id="target-6-5"></a>
### 6.5 Hamiltonians, frames and scalar normalization

**Painlevé application.**

**Hypotheses.**

- JMU/Hamiltonian comparison only on the generic unramified nonresonant locus; broader scalar normalization uses the finite-dimensional stabilization logarithmic form of the constructed RHP determinant section, a fixed frame and a base-point value on a regular time leaf. An infinite-dimensional trace expression additionally requires the verified trace-class realization and frame comparison.

On the JMU comparison locus of §6.4, choose a time coordinate and symplectic chart of the already constructed dynamics and derive the relation between the selected determinant-frame logarithmic derivative and the local Hamiltonian. Prove the exact coefficient and gauge, factorization and time-only correction terms from §6.4; do not silently identify different Hamiltonian conventions. A local primitive supplied by a symplectic chart is not a canonical function on the whole phase family. This Hamiltonian/JMU identity is restricted to that locus, and does not assert an additional ramified/resonant identity. (MAL04, Theorem 5.12 in its logarithmic Schlesinger scope; BERT10, §5.1, Proposition 5.1, with BERT16.)

For every constructed marked RHP chart, including a ramified or resonant chart after its §6.3 adapter is proved, use the stabilization identity of §6.4: in a determinant frame, τ=det S and d log τ=Tr(S⁻¹dS) on the nonvanishing locus, with the proved correction under a frame change. A verified infinite-dimensional realization τ=u det(I−K) gives d log τ=d log u−Tr((I−K)⁻¹dK) on its own trace-class locus. Fix this actual logarithmic one-form and the frame prescription, then establish its scalar normalization by choosing a nonzero value in a determinant fiber at a regular base point. This normalization theorem does not require a JMU or Hamiltonian identification outside the generic comparison locus. (BERT17, Proposition 2.3 and formula (3.6).)

The differential-equation normalization is along a fixed-monodromy horizontal time leaf, away from the chosen divisor. There a closed scalar differential and a base-point value determine the representative on a simply connected domain. Any extension of this assertion to the full monodromy-and-time space must prove the required integrability after its frame corrections; simple connectedness alone does not remove curvature of a line connection.

**API.**

- On the specified JMU comparison locus, compare the symplectic/time convention of §3.11 with the variational identity and record all correction terms. On the broader RHP-adapter locus use the finite-dimensional stabilization identity with its prescribed determinant frame; use an infinite-dimensional trace formula only after its additional trace-class comparison has been proved.
- Prove the transformation laws under a time change, a time-dependent symplectic chart change and a determinant-frame change.
- Prove uniqueness of scalar normalization on a connected simply connected regular domain after its base-point value is fixed; state separately the holonomy obstruction to descent.

**Checks.**

- If an identity uses d log τ = H dt, replacing H by H + c(t) requires multiplying τ by exp(∫c(t)dt), with the integration constant fixed.
- For a new time u = f(t), the same logarithmic one-form has coefficient (dt/du)H; an unchanged scalar coefficient would fail the comparison.
- Two representatives differing by a nonzero constant define the same logarithmic derivative but are different normalized scalar functions until the base-point values agree.

*Needs:* Internal: 3.11, 3.12, 6.3, 6.4; [Complex manifolds, holomorphic bundles and observations](#dependency-complex) (K1; K3.0; K3.HolomorphicStalk; K3.MeromorphicGermField; K4; K7.1).

#### Examples

The one-dimensional operator families s, s² and 1 distinguish section, divisor multiplicity and invertibility. A valid degree-minus-one connection distinguishes the phase object from the auxiliary index-zero RHP complex. A contour/factorization change distinguishes an intrinsic line section from its scalar representatives. These examples test the common construction before any classical tau equation is displayed.

#### Dependencies

Use the exact *Needs* list at each target and the cross-package registry in `design/reuse_registry.json`. General proof prerequisites belong to their independent package; this layer verifies its stated application comparisons.

<a id="layer-7"></a>

## Layer 7: Classical equations as coordinate comparisons

<a id="target-7-1"></a>
### 7.1 Applying the intrinsic first-jet theorem

**Painlevé application.**

**Hypotheses.**

- The actual classical time curve and phase surface, a local observer, and a proved jet-isomorphism domain; no symplectic or Painlevé-property premise is needed for the generic jet theorem.

Use NonlinearConnections §0.8, formulated for an observer bundle and its first-jet bundle. For the classical time curve and phase surface, supply a local observer and prove that the induced jet map is an isomorphism on the stated domain. Apply the general equivalence between horizontal germs and scalar second-order germs on that domain. In a time/phase chart, write h(∂t) = ∂t + A∂q + B∂p and J(t,q,p) = (t,q,A); if p = P(t,q,v) is its genuine inverse, the coordinate comparison is q″ = (A_t + A A_q + B A_p)(t,q,P(t,q,q′)). The chain-rule theorem and intrinsic jet construction belong to the general framework. A_p ≠ 0 gives a local inverse only. Individual classical chart constructions belong to §7.2; meromorphic continuation additionally uses §4.9 and is not a hypothesis of the jet theorem.

**API.**

- Verify each chart/observer jet-isomorphism domain and record its complement.
- Obtain the scalar formula only as the coordinate expression of the imported jet construction.

**Checks.**

- If A = p, the inverse is p = q′ and the scalar equation is q″ = B(t,q,q′).
- If A is independent of p, J forgets the momentum and cannot be a jet chart; scalar uniqueness then cannot be inferred from geometric uniqueness by this argument.
- For A = p² there are two momentum branches away from p = 0; local invertibility does not identify the two branches globally.
- If a scalar formula divides by q, a solution crossing q = 0 must be treated through overlapping phase charts, not by declaring that the cleared denominator creates new solutions.

*Needs:* Internal: 3.4, 3.7, 3.9, 0.8.

<a id="target-7-2"></a>
### 7.2 Exhaustive presentation and equation comparisons

**Painlevé application.**

**Hypotheses.**

- The profile classification of 3.4 and the already constructed intrinsic moduli, splitting, symplectic form and continuation theorem. The concrete charts, parameter/time substitutions, jet inverses and coverage/overlap comparisons for those profiles are outputs of this target.

For every profile in §3.4 construct a concrete time/Darboux or equivalent symplectic chart from the connection moduli, with its inverse on its actual image. Identify h in this chart by the strong integrable extension of §3.9, apply §7.1, and prove the parameter and time-substitution dictionary to the standard equation below, including the required marking covers. The required comparison records the chosen local frames, the determinant convention, the chart domain, the momentum inverse, every denominator, and the omitted loci. Coverage of the full moduli space is the overlap theorem, not the claim that one rational chart covers it. Re-derive the scalar expression from the compatible system; the source corrections in §7.4 are part of the comparison. (VDPS09, §2.2, Table 1 and §4; IIS06, Theorems 10.6, 10.10 and 10.13; DLMF, §32.2(i), equations 32.2.1–32.2.6.)

In the following output table, slopes are projective Katz invariants and their order is forgotten only for the classification table; an omitted pole is written “—”. All seventeen ordered profiles are recovered with the label-assignment and reindexing comparisons of §3.4. The number of external parameters is the dimension of the generic exponent family, not the number of initial conditions. Boundary diagrams are affine.

| Slopes at 0, 1, ∞, t | Boundary type | External dimension | Displayed realization and exact locator |
|---|---|---:|---|
| 0, 0, 0, 0 | D₄ | 4 | PVI; IIS06 §10, Theorems 10.6 and 10.10 |
| 0, 0, 1, — | D₅ | 3 | PV; VDPS09 §4.3, equations (1)–(5) |
| 0, 0, 1/2, — | D₆ | 2 | degenerate PV; VDPS09 §4.4, equations (6)–(11) |
| 1, —, 1, — | D₆ | 2 | PIII(D₆); VDPS09 §4.5, equations (12)–(16) |
| 1/2, —, 1, — | D₇ | 1 | PIII(D₇); VDPS09 §4.6, equations (17)–(21) |
| 1/2, —, 1/2, — | D₈ | 0 | PIII(D₈); VDPS09 §4.7, equations (22)–(26) |
| 0, —, 2, — | E₆ | 2 | PIV; VDPS09 §4.8, equations (27)–(31) |
| 0, —, 3/2, — | E₇ | 1 | Flaschka–Newell realization; VDPS09 §4.9, equations (32)–(36); its immediate scalar coordinate is P34 |
| —, —, 3, — | E₇ | 1 | Jimbo–Miwa realization of PII; VDPS09 §4.10, equations (37)–(41) |
| —, —, 5/2, — | E₈ | 0 | PI; VDPS09 §4.11, equations (42)–(47) |

Prove the actual substitutions and admissible inverse domains relating the Flaschka–Newell scalar coordinate to PII and degenerate PV to PIII(D₆). Two rows sharing a boundary type are not declared identical decorated moduli problems. In particular, a scalar substitution from degenerate PV to PIII does not by itself identify their isomonodromic families. (AHT17, introduction and §§2–3.)

The six standard scalar conclusions, in the DLMF normalization and on their ordinary differential-equation domains, are:

| Equation | Coordinate expression |
|---|---|
| PI | q″ = 6q² + t |
| PII | q″ = 2q³ + tq + α |
| PIII | q″ = q′²/q − q′/t + (αq² + β)/t + γq³ + δ/q |
| PIV | q″ = q′²/(2q) + 3q³/2 + 4tq² + 2(t² − α)q + β/q |
| PV | q″ = (1/(2q) + 1/(q − 1))q′² − q′/t + (q − 1)²(αq + β/q)/t² + γq/t + δq(q + 1)/(q − 1) |
| PVI | q″ = (1/q + 1/(q − 1) + 1/(q − t))q′²/2 − (1/t + 1/(t − 1) + 1/(q − t))q′ + q(q − 1)(q − t)[α + βt/q² + γ(t − 1)/(q − 1)² + δt(t − 1)/(q − t)²]/[t²(t − 1)²] |

Each row is a theorem about a chart and a specified parameter map. The symbols α, β, γ, δ are local to that row. The following explicit dictionaries fix the intended normalization; their admissible inverse charts and momentum transformations are part of the proof.

| Source variables and parameters | Standard variables and coefficients |
|---|---|
| IIS06 (1)–(2), with 2κ₀ + κ₁ + κ₂ + κ₃ + κ₄ = 1 | PVI: α = κ₄²/2, β = −κ₁²/2, γ = κ₂²/2, δ = (1 − κ₃²)/2 |
| VDPS09 PV system (2)/(5), with the scalar correction in §7.4 | T = t, Q = q/(q − 1); (α,β,γ,δ) = (θ₁²/2,−θ₀²/2,1 − θ∞,−1/2) |
| VDPS09 degenerate PV system (8) | T = t², Q = q/(q − 1); (α,β,γ,δ) = (θ₁²/2,−θ₀²/2,−2,0) |
| VDPS09 PIII(D₆), (14) | T = t, Q = q; (α,β,γ,δ) = (4(θ∞ + 1),−4θ₀,4,−4) |
| VDPS09 PIII(D₇), (19) | t = T², Q(T) = Tq(T²); (α,β,γ,δ) = (4(θ∞ + 1),−8,4,0) |
| VDPS09 PIII(D₈), (24) | t = T², Q(T) = q(T²)/T; (α,β,γ,δ) = (8,−8,0,0) |
| VDPS09 PIV, (29) | t = 2T, Q(T) = 2q(2T); α = −θ∞ − 1, β = −2θ₀² |
| VDPS09 PII Jimbo–Miwa, (39) | T = t, Q = q; α = (θ∞ + 1)/2 |
| VDPS09 PI, (45), choose c⁵ = 2 | T = ct, Q = c⁻²q; Q″ = 6Q² + T |

For the Flaschka–Newell coordinate (34), choose c³ = 2 and set T = −ct, U(T) = cq(t). Then U″ = U′²/(2U) + 2U² − TU − θ₀²/(2U). Retain a chosen exponent sign a = ±θ₀. On U ≠ 0, Q = (U′ − a)/(2U) is the PII variable with α = a − 1/2; conversely U = Q′ + Q² + T/2. The exceptional branch U = 0, a = 0 cannot be reconstructed by division and keeps its full phase data. The square-time comparisons are local biholomorphisms on their nonzero domains or comparisons on the indicated covers; they are not global changes of coordinate on the same punctured line.

**API.**

- Export one comparison package per listed presentation, containing the explicit formulas, parameter map, inverse jet chart and overlap maps.
- Compare the source-specific Hamiltonian and the convention of §3.11 by equality of extended forms.
- Identify all excluded denominators and the phase charts through their allowed zero loci.
- Deduce the standard scalar Painlevé property from §4.9 on every observer stratum covered by the comparison.

**Checks.**

- There are ten presentation rows and eight boundary types; identifying every row with a different classical equation fails both counts.
- The standard PI scaling above changes both q and t. Rescaling t alone does not recover the coefficient 6 of q².
- PII's two linear-system presentations have different local singularity data; equality of their scalar solution formulas is not equality of input objects.
- A PIII comparison with γ = 4, δ = −4 cannot cover γ = δ = 0 by a nonzero scaling; the latter belongs to the boundary analysis of §7.3.

*Needs:* Internal: 3.4, 3.5, 3.6, 3.7, 3.8, 3.9, 3.10, 3.11, 3.12, 4.9, 5.2, 7.1.

<a id="target-7-3"></a>
### 7.3 Complete coefficient-boundary coverage

**Painlevé application.**

**Hypotheses.**

- All standard PIII/PV coefficient tuples; nonzero scaling/inversion domains; quadrature boundary kept distinct from primitive strata.

Classify all coefficient tuples of the standard PIII and PV displays by admissible nonzero scalings and inversions, proving their exact domains and inverse substitutions. The primitive Painlevé profiles and the elementary boundary equations are different outputs; a leading irregular coefficient zero is not a point inside a stratum defined by its nonvanishing. (FM19, §1.1 and equation (2); DIL21, §§5.2–5.3 and Appendix B.3; DLMF, equations 32.9.6 and 32.9.12.)

| Display | Coefficient condition | Comparison target |
|---|---|---|
| PIII | γδ ≠ 0 | D₆ profile |
| PIII | γ = 0 and αδ ≠ 0, or δ = 0 and βγ ≠ 0 | D₇ profile, with the inversion comparison between the two orientations |
| PIII | γ = δ = 0 and αβ ≠ 0 | D₈ profile |
| PIII | α = γ = 0, or β = δ = 0 | quadrature/elementary boundary |
| PV | δ ≠ 0 | ordinary PV |
| PV | δ = 0 and γ ≠ 0 | degenerate PV presentation |
| PV | γ = δ = 0 | quadrature boundary |

Prove that the PIII cases cover all tuples; the two elementary alternatives may overlap and are combined into one boundary class. Derive the boundary integrations on their stated time/observer domains, with branches and integration constants retained, and compare limiting initial data when a geometric degeneration is claimed. PIII with all four coefficients zero gives q = C exp(μ log t) on a chosen cover of ℂ*, including its nonzero-solution domain. A generic such power is not a single-valued function on ℂ*. Zero/constant solutions introduced by clearing q denominators require a separate original-equation domain check. These examples prevent the primitive classification from silently losing coefficient values.

*Needs:* Internal: 7.1, 7.2; [Formal scalar and vector-valued Laurent algebra](#dependency-formal-series) (L1–L4; L5–L6 for finite-extension steps in 1.1); [Covering spaces and universal covers](#dependency-covers) (Stage 0.2–0.4; Stage 1.5; Stage 2.6–2.8).

<a id="target-7-4"></a>
### 7.4 Hamiltonian, sigma and linear-system realizations

**Painlevé application.**

**Hypotheses.**

- The earlier geometric transformation, determinant-variation and coordinate-comparison results, on their actual stated domains. The sigma converse has its explicit reconstruction nondegeneracy hypothesis; source-sign corrections and the comparisons of Hamiltonian, sigma and linear-system displays are proved here.

For each admitted presentation, derive the displayed Hamiltonian system from h and ω, and derive the Lax-pair compatibility from the same strong total connection. For sigma equations, transformations and tau logarithmic derivatives, state a forward lemma and a converse only on the locus where the reconstruction has been proved. Track additive Hamiltonian functions of time, multiplicative tau normalizations, branch choices and exceptional derivatives explicitly. (DLMF, §§32.6–32.7; VDPS09, §4; IIS06, Theorem 10.13; BERT17, Proposition 2.3 and Theorem 3.3.)

The source sign comparison is itself a lemma. In VDPS09 §4.1 the displayed equations p′ = F H_q, q′ = −F H_p, with F depending only on q, have kernel form dp ∧ dq/F + dH ∧ dt. The printed minus sign in that extended form is inconsistent with those equations, including the PI instance (44), (46), (47). On F ≠ 0, set Q = q, P = p/F(q), K(Q,P,t) = −H(F(Q)P,Q,t), using the source's argument order H(p,q,t); then dQ ∧ dP + dK ∧ dt is the negative of the correct source form and gives the convention of §3.11. Verify this identity directly before importing any source Hamiltonian.

VDPS09's printed PV equation (3) also disagrees with its system (2) and Hamiltonian (5). Differentiating q′ = 2p/t gives the exponent term [θ₀²(q − 1)² − θ₁²q²]/[2q(q − 1)t²], in place of the printed θ₀²/(2qt²) + θ₁²/[2(q − 1)t²]. At t = 1, q = 2, p = 0, θ₀ = 0, θ₁ = 1, θ∞ = 1, the compatible system gives q″ = 2 while the printed scalar equation gives 7/2. The comparison uses the re-derived expression and then the PV substitution of §7.2.

For sigma reconstruction include the derivative-nondegeneracy hypothesis and analytic extension argument. For example, the PI sigma relation (σ″)² + 4(σ′)³ + 2tσ′ − 2σ = 0 admits σ ≡ 0, whereas q = −σ′ ≡ 0 does not solve q″ = 6q² + t. Thus the unqualified reverse implication is false. On the branch σ″ not identically zero, differentiating and then extending the resulting analytic identity gives the required reconstruction. The entire excluded branch is σ = at + 2a³ with a constant; its q = −a never solves PI on an open time domain. This explicitly identifies the spurious scalar branches of this sigma relation.

Distinguish this PI obstruction from loss of phase information on a genuine invariant locus. In the PII normalization of §7.5, put c = α + 1/2 and σ = H. Direct differentiation gives σ′ = −p/2 and σ″ = 2qσ′ − c/2, hence q = (2σ″ + c)/(4σ′) and p = −2σ′ on σ′ ≠ 0. At c = 0 and p = 0, every Riccati trajectory q′ = −q² − t/2 has σ ≡ 0. These are genuine phase trajectories with distinct initial q, all having the same scalar sigma function. Retain that phase/initial-point data on this locus; there is no sigma-only inverse there. Isolated zeros of σ′ in the reconstructible branch require the stated analytic extension comparison, not totalized division.

*Needs:* Internal: 3.11, 5.4, 5.5, 6.4, 6.5, 7.1, 7.2, 7.3.

<a id="target-7-5"></a>
### 7.5 Concrete normalizations and special-solution checks

**Painlevé application.**

**Hypotheses.**

- The PI/PII connection-moduli comparisons already constructed in 7.2, the first-jet lemma and the admitted geometric transformations. The stated Hamiltonian normalizations, momentum inverse and seed solution identities must be derived; exceptional domains and the Riccati parameter α=−1/2 are retained.

Prove the PI chart H = p²/2 − 2q³ − tq and the PII chart H = p²/2 − (q² + t/2)p − (α + 1/2)q from the corresponding moduli charts, and apply §7.1. The PII jet inverse is p = q′ + q² + t/2. The polynomial chart covers all finite (q,q′), while poles use the other phase charts. Establish its parameter dictionary with §7.2. (VDPS09, §§4.10–4.11; DLMF, §§32.2, 32.6 and 32.9.)

Construct the rational and classical-function families generated from the proved seed objects by §§5.4–5.5's admitted transformations, and prove their formulas only as the resulting coordinate lemmas. No completeness classification of all rational or algebraic solutions is imported from these few seeds.

**Checks.**

- At α = 0, q = 0 and p = t/2 form a horizontal section in this chart.
- At α = 1 and t ≠ 0, q = −1/t and p = 2/t² + t/2 satisfy both Hamilton equations; at t = 0 their geometric continuation uses another chart.
- At α = −1/2, p = 0 is invariant and q′ = −q² − t/2. Setting q = u′/u gives u″ = −tu/2 on u ≠ 0; this is the projective linearization of §5.6, with zeros of u interpreted in ℙ¹.
- H ↦ H + c(t) leaves both tests horizontal, but changes a normalized Hamiltonian tau representative by the corresponding exponential primitive when the identity of §6.5 applies.

*Needs:* Internal: 5.4, 5.5, 5.6, 6.5, 7.1, 7.2, 7.3, 7.4.

#### Examples

The scalar equation may have an apparent denominator at a perfectly regular geometric initial point. Conversely, a denominator-cleared polynomial identity may admit functions absent from the original equation. The first-jet chart and the observer comparison resolve both issues without changing the intrinsic solution definition.

#### Dependencies

Use the exact *Needs* list at each target and the cross-package registry in `design/reuse_registry.json`. General proof prerequisites belong to their independent package; this layer verifies its stated application comparisons.

<a id="layer-8"></a>

## Layer 8: Riemann–Hilbert asymptotics and distinguished solutions

<a id="target-8-1"></a>
### 8.1 Contour packages and the Cauchy-transform solution class

**General theory.**

**Hypotheses.**

- A finite matrix size and a fixed oriented contour in the declared geometric class, with arc-length measure, specified local branches and nonzero crossing angles.
- The boundedness, Plemelj, decay and reconstruction assertions are proof outputs for that class; for an external contour adapter they are explicit imported hypotheses.
- The candidate-reconstruction and determinant conclusions additionally require their stated vanishing boundary-integral and removability hypotheses.

Construct a reusable contour package for finite oriented unions of compact C¹,α arcs, closed C¹,α curves, and noncompact arcs that are straight rays outside a compact set, where 0 < α ≤ 1. Require regular parametrizations and only finitely many endpoints and transverse vertices. Fix arc-length measure and the complex line element dζ, and require that distinct branches meet only at the specified vertices. Prove the bounded L² Cauchy boundary operators C₊, C₋ and the Plemelj relation C₊ − C₋ = id, together with the analytic Cauchy transform C(h)(z) = (2πi)⁻¹∫_Γ h(ζ)/(ζ − z)dζ and its boundary reconstruction on the stated class. The proofs must include the local cross-branch estimates at vertices and the convergence and decay of the integral on unbounded rays. A more general contour can be admitted only after supplying these same contracts. Pointwise endpoints have zero arc-length measure, but that fact removes none of the local analytic obligations there.

For a finite matrix size, define a normalized Cauchy-class residual solution by R = I + C(h), h ∈ L²(Γ), with h = R₊ − R₋ almost everywhere and with the normalization at infinity justified by the contour package and any additional moment hypotheses. The L² floor gives decay on sectors separated from the unbounded rays; a claimed I + O(1/z) normalization requires the L¹ control of §8.3. No extra homogeneous term at an endpoint or vertex is allowed. Prove that h is recovered uniquely from the jump. This specifies an analytic solution class rather than merely L² boundary traces.

Also formulate and prove a candidate-reconstruction criterion using the Cauchy formula on excised domains: control the large boundary and require the small-circle integrals about every endpoint and vertex to tend to zero. The local hypotheses in that criterion must imply this disappearance, not merely assert that the candidate has L² traces. Applications with local parametrices supply those bounds for their transformed candidates. State a separate determinant-removability criterion: when det R has matching boundary values, extends across the open arcs and all endpoints and vertices, and tends to one at infinity, the resulting entire scalar function is one by Liouville’s theorem. The jump identity det(I + w) = 1 alone does not verify this criterion.

**API.**

- Construct the Cauchy transform and bounded boundary operators with Plemelj and the declared contour-dependent bounds.
- Define the normalized Cauchy-transform class, recover its density from the jump and record the precise normalization supplied by its moment assumptions.
- Prove reconstruction of a candidate from its jump under explicit large-boundary and endpoint/vertex small-circle estimates.
- Export determinant-one and matrix-invertibility conclusions only after the scalar determinant extension and infinity normalization have been verified.

**Checks.**

- Identity jump gives h = 0 and R = I in this class. On Γ = [0,1], the competing matrix I + exp(−1/z)z⁻¹E₁₂ has the same identity jump and normalization and has L² boundary correction with squared norm e⁻²/2, but an essential endpoint singularity. It is excluded by Cauchy reconstruction: h = R₊ − R₋ = 0 cannot reconstruct its nonzero correction.
- On an unbounded contour, I need not lie in L²(Γ). The normalized class is the affine class I + C(L²), not a demand that its matrix boundary value itself belong to L².
- The determinant of a jump being one supplies matching determinant traces; endpoint and vertex removability and the normalization at infinity remain separate obligations.
- A residual analytic matrix reconstructed from an arbitrary admissible jump is not thereby a meromorphic connection with prescribed polar data; that reconstruction belongs to the application.

**Supporting constructions owned by this target.**

- At a transverse contour vertex, prove the weighted Schur estimate for a kernel bounded by C/(s+t), s,t>0. Use weight s^(−1/2), the identity ∫₀∞t^(−1/2)/(s+t)dt=πs^(−1/2), and weighted Cauchy–Schwarz/Fubini; deduce the L² bound Cπ and its finite-arc restrictions. An unweighted row/column integral diverges and cannot replace this step. Prove the coordinate and arclength-density comparisons that reduce the actual cross-branch kernel to this bound.

*Needs:* [Native Lp, Fourier and integral calculus](#dependency-lp) (Complex L²/Fourier–Plancherel; Hölder and dominated convergence on the native measure/integral carrier); [Real-line Hilbert transform](#dependency-hilbert-transform) (2.3/B10); [Native contour and Schur foundations](#dependency-cauchy) (Cauchy integral formula; Unweighted Schur estimates).

<a id="target-8-2"></a>
### 8.2 A quantitative small-norm RHP theorem

**General theory.**

**Hypotheses.**

- A contour package with its Cauchy-transform solution class from target:8.1; w_s in L² ∩ L∞ with a common operator norm bound ‖C_w‖ ≤ ρ < 1.
- Banach-holomorphic L² ∩ L∞ dependence for the holomorphic-parameter assertion; invertible jumps if that version of the boundary problem is claimed.
- For det R = 1 and matrix invertibility, det(I + w) = 1 together with the separately verified scalar determinant extension and normalization criterion.

Fix a proved contour package from §8.1 and a finite matrix size. For a residual jump J_s = I + w_s with w_s ∈ L²(Γ) ∩ L∞(Γ), define C_w f = C₋(fw) on L². Assume a common bound ‖C_w‖ ≤ ρ < 1 on the stated parameter set. If an invertible-jump RHP is intended, additionally require J_s to be invertible almost everywhere; in the determinant-one specialization require det J_s = 1 almost everywhere. These algebraic jump assumptions do not replace the operator norm gap or the determinant-removability criterion.

Solve ν = C₋w + C_wν by ν = (id − C_w)⁻¹C₋w, using the Neumann series, and set μ = I + ν, h = μw and R = I + C(h). Prove h ∈ L², R₋ = μ and R₊ = R₋(I + w). Conversely, an admissible Cauchy-class solution yields that same equation for ν and is therefore unique in the specified class. The construction uses ν ∈ L² and never assumes that I or μ is in L² on an unbounded contour. State the basic quantitative bounds ‖(id − C_w)⁻¹‖ ≤ (1 − ρ)⁻¹ and ‖ν‖₂ ≤ ‖C₋w‖₂/(1 − ρ), and derive continuous and Banach-holomorphic parameter dependence from the resolvent identity when w depends in L² ∩ L∞. Weighted coefficient asymptotics are exported only through §8.3.

The operator construction produces a matrix-valued analytic boundary-jump solution. A determinant-one and everywhere invertible matrix solution additionally uses the determinant extension and normalization criterion of §8.1; det J = 1 alone is not a proof of det R = 1. A problem outside the small-norm domain may still be solvable: it needs a different inverse, a vanishing lemma, or another separately verified argument. Nor does an arbitrary small L² jump specify a meromorphic connection with designated singularities. Undoing a geometric parametrix reduction and identifying the resulting connection and its horizontal variation are downstream application tasks. (ILP18, §3.3, Lemma 3.3 is a concrete application; the general norm-gap theorem and its hypotheses are owned here.)

**API.**

- Construct the inverse of id − C_w, the density ν, the jump density h and the unique solution R in the prescribed Cauchy class.
- Prove the quantitative inverse and error bounds and continuous or Banach-holomorphic dependence in the stated jump norms.
- Use the separate determinant-removability criterion to obtain determinant one and matrix invertibility on precisely the verified locus.
- Allow alternative invertibility arguments outside the norm-gap domain without inferring nonsolvability from failure of the small-norm criterion.

**Checks.**

- For w = 0 the construction gives ν = h = 0 and R = I, in agreement with the Cauchy-class uniqueness statement.
- The estimate ‖ν‖₂ ≤ ‖C₋w‖₂/(1 − ρ) records the necessary loss as ρ approaches one; it does not provide a uniform estimate at ρ = 1.
- Failure of the small-norm hypothesis does not prove nonsolvability. On a counterclockwise unit circle the constant jump −I₂ has w = −2I₂ and ‖C_w‖ = 2, yet the solution R_out = I₂, R_in = −I₂ is in the Cauchy class, with h = −2I₂ and determinant one.
- The Neumann-series solution theorem has no prerequisite involving phase-space dimension, a formal connection profile, monodromy selection, or reconstruction of a meromorphic connection.

*Needs:* Internal: 8.1; [Native analytic inversion](#dependency-inversion) (analyticAt_inverse; analyticAt_inverse_one_sub).

<a id="target-8-3"></a>
### 8.3 Weighted moments, coefficient expansions and uniform tails

**General theory.**

**Hypotheses.**

- A family satisfying target:8.2 with a common ρ < 1; an integer m ≥ 0 and the stated weighted L¹ and L² moments.
- A fixed separated sector with the stated contour denominator estimate; common moment bounds for a uniform bound.
- For a uniform little-o, weighted L¹ and L² tail tightness or a stated sufficient alternative; for the stronger next-order big-O, a uniformly bounded additional moment.

For the family constructed in §8.2, fix an integer m ≥ 0 and write W_m(ζ) = 1 + |ζ|ᵐ. Require W_m w_s ∈ L¹(Γ) ∩ L²(Γ). The identities h_s = w_s + ν_s w_s and Hölder’s inequality give ‖W_m h_s‖₁ ≤ ‖W_m w_s‖₁ + ‖ν_s‖₂‖W_m w_s‖₂. Thus the common small-norm gap and uniform bounds for the displayed weighted norms imply a uniform weighted L¹ bound for h_s. Let a closed angular sector at infinity satisfy the proved contour estimate |ζ − z| ≥ c(|ζ| + |z|) for every ζ ∈ Γ and all sufficiently large z in that sector, with c > 0 independent of the claimed parameters.

For each fixed parameter, prove R_s(z) = I − (2πi)⁻¹Σ_{j=0}^m z⁻ʲ⁻¹∫_Γ ζʲh_s(ζ)dζ + o(|z|⁻ᵐ⁻¹). In particular, the coefficient of z⁻ʲ⁻¹ is −(2πi)⁻¹∫_Γ ζʲh_s(ζ)dζ, with this sign. The exact remainder is (2πi)⁻¹z⁻ᵐ⁻¹∫_Γ ζᵐ⁺¹h_s(ζ)/(ζ − z)dζ. Dominated convergence proves the little-o at a fixed parameter, but uniform weighted norm bounds alone do not make it uniform on a noncompact parameter set. Those bounds do imply uniform R_s = I + O(1/z) in the specified separated sectors. Claims on the rays themselves require additional local sectorial estimates.

For a parameter-uniform little-o, additionally prove weighted-tail tightness: as A → ∞, both sup_s ‖1_{|ζ|>A}W_m w_s‖₁ and sup_s ‖1_{|ζ|>A}W_m w_s‖₂ tend to zero. The same weighted L¹ tail property follows for h_s from the preceding inequality applied on the tail and the uniform ‖ν_s‖₂ bound. Split the exact remainder into a fixed bounded part and its tail: the former tends to zero uniformly and the latter is uniformly small. Sufficient alternatives are a compact parameter set with norm-continuous dependence in both weighted spaces, or uniform bounds for one additional weighted moment. The latter gives the stronger uniform O(|z|⁻ᵐ⁻²) remainder by the same denominator estimate. Every downstream endpoint, collision or asymptotic-normalization argument must verify these controls on its actual parameter set; pointwise dominated convergence is not such a verification.

**API.**

- Transfer weighted moments and weighted-tail tightness from w_s to h_s with the explicit L¹/L² estimate.
- Compute each coefficient at infinity, with its sign, and the exact remainder on a sector with a proved denominator bound.
- Distinguish pointwise little-o, uniform big-O and uniform little-o, exporting the last only with uniform tail control.
- Prove the compact-parameter and extra-moment sufficient criteria, including the stronger next-order big-O from one extra moment.

**Checks.**

- On Γ = ℝ, let w_s(x) = a exp(−(x − s)²)E₁₂ with Re s > 1 and |Im s| < δ, choosing a > 0 so small that a exp(δ²) < 1. This is a Banach-holomorphic small-jump family with uniformly bounded zeroth L¹/L²/L∞ moments, determinant one and exact density h_s = w_s because E₁₂² = 0. Its zeroth moment is M₀ = a√π E₁₂. At s = n and z = in, n(C(w_n)(in) + M₀/(2πi·in)) tends to (a√π/(2πi))((1 − i)/2)E₁₂ ≠ 0. Thus a pointwise o(1/z) remainder need not be parameter-uniform; the translated mass fails the uniform tail condition.
- For the translated Gaussian counterexample, the limiting scalar factor is 1/(1 − i) − i = (1 − i)/2. The coefficient sign and the constant a√π/(2πi) must be retained together.
- On a compact parameter set, continuity in the weighted L¹ and L² norms makes the family uniformly tight in both weighted tails; boundedness alone on a noncompact set does not.
- A uniform (m + 1)-st weighted moment gives an O(|z|⁻ᵐ⁻²) remainder on the same separated sector, while a claim along a contour ray still needs its own local estimate.

*Needs:* Internal: 8.2; [Native Lp, Fourier and integral calculus](#dependency-lp) (Complex L²/Fourier–Plancherel; Hölder and dominated convergence on the native measure/integral carrier).

<a id="target-8-4"></a>
### 8.4 Canonical Barnes G and branch-normalized sectorial asymptotics

**General theory.**

Construct the canonical entire Barnes G function on the native complex analytic carrier. Write gamma for Real.eulerMascheroniConstant and define G by the locally uniformly convergent product

\[G(z+1)=e^{\frac z2\log(2\pi)-\frac{z(z+1)}2-\frac{\gamma z^2}2}\prod_{k=1}^{\infty}\left(1+\frac zk\right)^k e^{-z+z^2/(2k)}.\]

The product, rather than a recurrence alone, fixes the normalization. Prove local normal convergence and nonvanishing away from the displayed factors, G(1)=1, compatibility with complex conjugation, and G(z+1)=Gamma(z)G(z) for z not in {-n : n is a natural number}. Interpret this also as a meromorphic identity; the totalized native Gamma function at its poles is not used as the value of a meromorphic pole. Prove that G has exactly the zeros z=-n of multiplicity n+1, with its local leading coefficients and the quotient/removable-limit rules needed for finite products and ratios. Consume native Complex.Gamma, GammaSeq_tendsto_Gamma, Gamma_ne_zero and its analytic regularity; prove the product-to-Gamma comparison here.

Put D = {z in C : z is nonzero and |arg z| < pi}. On D construct the holomorphic branches Log z, Log Gamma(z+1) and Log G(z+1) whose values are real on the positive real axis. These are analytic logarithms continued from that axis, not pointwise principal logarithms of the Gamma or G values. Define c_A as the limit, as m tends to infinity through positive integers, of sum_(k=1)^m k log k - (m^2/2 + m/2 + 1/12) log m + m^2/4, and put A=exp(c_A). Prove existence of this normalization limit. For every integer N>=1 define

\[a_N(z)=\frac{z^2}{4}+z\operatorname{Log}\Gamma(z+1)-\left(\frac{z(z+1)}2+\frac1{12}\right)\operatorname{Log}z-\log A+\sum_{k=1}^{N-1}\frac{B_{2k+2}}{2k(2k+1)(2k+2)z^{2k}}.\]

Prove

\[\operatorname{Log}G(z+1)=a_N(z)+R_N(z),\qquad |R_N(z)|\le\frac{|B_{2N+2}|\sec^{2N+1}(\arg(z)/2)}{2N(2N+1)(2N+2)|z|^{2N}}.\]

Here B_j are the native Bernoulli numbers. For every fixed delta with 0<delta<=pi the bound is uniform on |arg z|<=pi-delta, z nonzero; it is O_(N,delta)(|z|^(-2N)) as |z| tends to infinity. Prove the finite-product logarithmic summation and integral-remainder comparisons that establish this expansion and bound; no unnamed Barnes or sectorial-Stirling supplier is a prerequisite. The Gamma-containing form of the expansion is sufficient and fixes the constant without importing a zeta-derivative formula. Its identification with a zeta-derivative expression is not used by the connection formulas.

This is a reusable special-function construction independent of the connection-moduli, scalar-equation and RHP application targets. 8.7 uses its normalized factors and its proved local removable-limit rules. Sources: DLMF 5.17.1, 5.17.3 and 5.17.7; Nemes, arXiv:1406.2535v2, equation (1.1), Theorem 1.2 equation (1.10), and proofs in Sections 2-3.

**Hypotheses.**

- The native complex field, analytic Gamma carrier on its pole-free locus, Euler–Mascheroni constant and Bernoulli numbers. The Barnes function, product convergence, logarithm branches, normalization limit, divisor and remainder are outputs.
- For recurrence as a pointwise identity, z is not a nonpositive integer. For logarithmic asymptotics, z is nonzero and |arg z|<pi; N>=1 and 0<delta<=pi are explicit.

**API.**

- Construct the canonical entire function from the locally normally convergent Weierstrass product; prove G(1)=1, conjugation compatibility and the product-to-native-Gamma comparison.
- Prove the recurrence away from the native Gamma pole set and as a meromorphic identity, identify every zero and its multiplicity, and derive local leading-coefficient and removable-quotient rules.
- Construct the analytic logarithm branches and Glaisher normalization limit; prove the N-term expansion and explicit remainder bound, uniformly on each fixed closed subsector.

**Diagnostics.**

- The product and recurrence give G(1)=G(2)=G(3)=1 and G(4)=2. At zero G has order one (G(z)/z tends to 1), while at -1 it has order two. A blanket simple-zero statement fails.
- The entire function H(z)=exp(sin(2 pi z))G(z) has H(1)=1, the same recurrence on its allowed domain and the same zero divisor, but H is not G. The canonical product or a proved asymptotic uniqueness condition is necessary to specify G.
- Native Complex.Gamma 0 is totalized to 0. Substituting z=0 in an unrestricted pointwise Barnes recurrence would assert G(1)=Gamma(0)G(0)=0, contrary to G(1)=1. The punctured recurrence and the meromorphic continuation are distinct assertions.
- For N=1 and real x>0 the first omitted coefficient is B4/(2*3*4)=-1/720, so the remainder has negative sign and magnitude at most 1/(720 x^2). Replacing the chosen Log G by Log G+2 pi i violates this vanishing remainder at large x. The sector-uniform constant retains delta>0; it is not uniform as the sector reaches the negative real axis.

*Needs:* [Native Gamma, Bernoulli and analytic carriers](#dependency-gamma) (Complex.Gamma; GammaSeq_tendsto_Gamma; Gamma_ne_zero; Real.eulerMascheroniConstant; Bernoulli numbers/polynomials); [Complex manifolds, holomorphic bundles and observations](#dependency-complex) (K1; K3.0; K3.HolomorphicStalk; K3.MeromorphicGermField; K4; K7.1).

<a id="target-8-5"></a>
### 8.5 Boundary and sectorial selection data

**Painlevé application.**

**Hypotheses.**

- Sector/end, branches, formal/Stokes framing, any exceptional lift data and normalization; no solution/existence included as a field.

Define boundary-selection data over the admitted geometric time family: an end and sector or specified approach path; its time coordinate and branches; local formal and Stokes data with a framing; any lattice, parabolic or resolution datum needed to select a de Rham lift; and a normalization for the requested observable or tau representative. Define equivalence by the actual marking transformations. The record contains no solution and no existence or uniqueness assertion. A specification becomes a characterization only after its analytic realization theorem. Linear Stokes data at a spectral singularity and nonlinear asymptotics at a time boundary are different constructions, connected by the theorem. (ILP18, §1.4 and §§3.3–3.4, 4.2–4.3, for the distinction in concrete realizations.)

**API.**

- Construct restriction to a smaller sector, branch change and transport of a boundary specification under a geometric comparison.
- Formulate realization by a normalized RHP and recovery of a decorated phase point without putting either result into the input definition.
- State uniqueness for the specified normalized problem and its selected lift, then prove equality with the intrinsic horizontal section constructed from that point.
- Define a connection constant as the comparison between two stated asymptotic normalizations of the same section along a specified continuation path.

**Checks.**

- Identical formal power-series asymptotics can leave exponentially small/Stokes freedom; that truncated specification does not automatically select one solution.
- Coarse monodromy data with a nontrivial exceptional RH fiber does not identify a unique phase point without the required lift data.
- Rescaling the observable or tau frame changes numerical asymptotic constants; equivalence of underlying horizontal sections does not erase that normalization.

*Needs:* Internal: 4.1, 4.2, 4.3, 4.5, 4.6, 4.7, 4.8, 6.3, 6.4, 6.5, 7.1, 7.2.

<a id="target-8-6"></a>
### 8.6 Geometric adapters for the general small-norm RHP theorem

**Painlevé application.**

**Hypotheses.**

- Specified geometric RHP data and parametrices; actual contour, endpoint, moment and uniform-tail hypotheses must be proved, not inferred from formal jump notation.

Use AnalyticRHPAndDeterminants §§8.1–8.3 for the Cauchy solution class, small-norm inversion, weighted moments and parameter-uniform tails. This target owns the actual contours and local parametrices selected by §8.5. Prove the bounded Cauchy operators and reconstruction, the residual representation R = I + C(h), disappearance of small endpoint-circle integrals, and determinant removability for these geometric local models. Boundary L² traces alone are insufficient. Verify w ∈ L² ∩ L∞, det(I+w)=1 and a common operator gap ‖C_w‖ ≤ ρ < 1 on the stated parameter set; use the general ν = C₋w + C_wν solution, without assuming I ∈ L² on an unbounded contour.

For every claimed coefficient or uniform remainder, verify the actual weighted L¹/L² moment and tail hypotheses of target:8.3. Uniform weighted norms alone do not give parameter-uniform little-o. Supply weighted-tail tightness, compact norm-continuous parameter control, or an additional moment on precisely the parameter set used by §§8.7 and 9.8. The general estimates and counterexamples are owned in the analytic framework.

Undo the verified parametrix reduction, reconstruct the decorated connection by §4.1, and identify its parameter variation with the strong splitting of targets 3.9–3.12. Compare local solutions by uniqueness and continue by targets 4.5–4.9. An arbitrary small jump does not specify this meromorphic-connection problem. Outside the verified small-norm domain, supply a separate vanishing/invertibility argument and prove its hypotheses. (ILP18, §3.3, Lemma 3.3, is a concrete application.)

**API.**

- Prove the contour, endpoint and determinant-removability adapters into the general Cauchy class.
- Verify the parameter-uniform gap and exact weighted-tail controls required by the chosen asymptotic conclusion.
- Reconstruct the actual decorated connection and prove its horizontality and overlap comparison.

**Checks.**

- Identity jump gives h = 0 and R = I in this class. On Γ = [0,1], the competing matrix I + exp(−1/z)z⁻¹E₁₂ has the same identity jump and normalization and has L² boundary correction with squared norm e⁻²/2, but an essential endpoint singularity. It is excluded by Cauchy reconstruction: h = R₊ − R₋ = 0 cannot reconstruct its nonzero correction.
- The estimate ‖ν‖₂ ≤ ‖C₋w‖₂/(1 − ρ) records the necessary loss as ρ approaches one; it does not provide a uniform estimate at ρ = 1.
- Failure of the small-norm hypothesis does not prove nonsolvability. On a counterclockwise unit circle the constant jump −I₂ has w = −2I₂ and ‖C_w‖ = 2, yet the solution R_out = I₂, R_in = −I₂ is in the Cauchy class, with h = −2I₂ and determinant one.
- On Γ = ℝ, let w_s(x) = a exp(−(x − s)²)E₁₂ with Re s > 1 and |Im s| < δ, choosing a > 0 so small that a exp(δ²) < 1. This is a Banach-holomorphic small-jump family with uniformly bounded zeroth L¹/L²/L∞ moments, determinant one and exact density h_s = w_s because E₁₂² = 0. Its zeroth moment is M₀ = a√π E₁₂. At s = n and z = in, n(C(w_n)(in) + M₀/(2πi·in)) tends to (a√π/(2πi))((1 − i)/2)E₁₂ ≠ 0. Thus a pointwise o(1/z) remainder need not be parameter-uniform; the translated mass fails the uniform tail condition.

*Needs:* Internal: 3.9, 3.10, 4.1, 4.5, 4.7, 8.5, 8.1, 8.2, 8.3.

<a id="target-8-7"></a>
### 8.7 Two precisely scoped connection-formula realizations

**Painlevé application.**

**Hypotheses.**

- The precisely listed generic PVI and homogeneous-PII monodromy loci, chosen branches/normalizations and the supplied Hastings–McLeod object/Fredholm identity, with the earlier RHP and Barnes-function interfaces. The endpoint formulas, continuation through auxiliary chart exclusions and the DIK/HXZ/HM sectorial calibration estimates are proof targets, not assumed output identities.

Translate ILP18 Theorems A and B into the boundary language, prove their normalized RHP realizations and transfer their endpoint and constant-ratio identities to the tau section of targets 6.2–6.5. Keep the parameter dictionaries and branch choices explicit. The targets are the following source loci, not all parameters of the corresponding equations.

For Theorem A use the four logarithmic residues with eigenvalues ±θ_ν, 2θ_ν ∉ ℤ for ν = 0,t,1,∞, the marked monodromy cubic (1.16), and σ = σ₀ₜ, ρ = σₜ₁ satisfying σ,ρ ≠ 0 and 0 ≤ Re σ, Re ρ < 1/2. Require every member of the following four sets to avoid ℤ: {θ₀ ± θₜ ± σ}, {θ∞ ± θ₁ ± σ}, {θ₁ ± θₜ ± ρ}, {θ∞ ± θ₀ ± ρ}, with both signs independent. These are (1.13) and (1.17). With the source's t ∈ (0,1) endpoint branches and JMU normalization, prove its asymptotics (1.18a–b) and C₁/C₀ equal to the Barnes-G expression (1.19), using exactly the quantities (1.20–1.21). Propositions 3.20 and 3.24 and §3.9 supply the proof targets. Where an auxiliary denominator in (1.21) vanishes, use a proved continuation of the expression rather than totalized division.

For Theorem B use homogeneous PII, q″ = 2q³ + tq, and its source Stokes surface s₁ − s₂ + s₃ + s₁s₂s₃ = 0. Require s₁s₃ ≠ 1, Arg(1 − s₁s₃) ∈ (−π,π), s₂ ∉ ℝ and Arg(iϵs₂) ∈ (−π/2,π/2), where ϵ = sign Re(is₂) ∈ {−1,1}. These are (1.25). With d log τ = (q′² − q⁴ − tq²)dt, prove the two real-ray asymptotics (1.26) and C₊/C₋ equal to (1.28), with μ,ν from (1.27) and exp(iπη) = −iϵ/s₃. The literal η chart requires s₃ ≠ 0. Prove the stated η ↦ η + 2 invariance, normalization comparison and analytic extension to further allowed data; never assign an exponential logarithm to an undefined quotient. The proof locators are §§4.3–4.5 and Remark 4.8, with Barnes-function domains and removable limits explicit.

Separate the absolute-constant calibration in ILP18 §4.5 from the monodromy-dependent variational calculation. Its supporting proof targets are the Airy determinant constant χ = (log 2)/24 + ζ′(−1) in DIK08 Theorem 1, (2)–(3); the complex-sector pole-freeness in HXZ16 Theorem 2.1; and the uniform complex-sector Hamiltonian asymptotics and arc estimates used in ILP18 (4.74)–(4.76). Consume the existing Hastings–McLeod object and Fredholm identity from RandomMatrices §8.5. That contract and the first two estimates do not imply the third.

For the third supporting target, construct the Hastings–McLeod normalized RHP and sectorial parametrices on arg z ∈ [−π/3,0] and [2π/3,π], using its supplied scalar object rather than proving a second existence theorem. Apply §8.6 with uniform boundary-sector and weighted remainder estimates to recover the Hamiltonian asymptotics (4.74). With H_HM denoting ILP18's Hamiltonian normalization, prove that the integrals over the oriented large-circle arcs of H_HM(z)dz on the first sector and of (H_HM(z) − z²/4 + 1/(8z))dz on the second tend to zero. State and prove the uniform bounds, including the boundary rays, which justify these two limits; real-ray asymptotics alone do not suffice. ILP18 cites FIKN for the sectorial continuation and uses Jordan-type estimates at this step. Here this exact sectorial estimate is an owned RHP/parametrix proof target, not an unrecorded import of the whole FIKN theory. With the arc limits established, compute the remaining logarithmic contribution as +iπ/24 and the calibration as exp(χ + iπ/24).

The quantitative arc contract is the following, uniformly for z = R exp(iθ) and sufficiently large R. On the first sector prove |H_HM(z)| ≤ C R⁻¹ exp(−(4/3)R³ᐟ² cos(3θ/2)) + C R⁻⁵ᐟ². On the second set φ = θ − π and c = 2√2/3, and prove |H_HM(z) − z²/4 + 1/(8z)| ≤ C R⁻¹ᐟ⁴ exp(−cR³ᐟ² cos(3φ/2)) + C R⁻¹ exp(−2cR³ᐟ² cos(3φ/2)) + C R⁻⁷ᐟ⁴. These are bounds for the full sectorial expansions (4.74), with uniform remainders at the boundary. The angular integrals of each exponential are O(R⁻³ᐟ²), since the cosine has a simple zero at the oscillatory boundary. Multiplication by the arc-length factor R gives first-arc bound O(R⁻³ᐟ²) and second-arc bound O(R⁻³ᐟ⁴), hence the required vanishing.

**Checks.**

- A resonant exponent 2θ_ν ∈ ℤ is excluded from this PVI realization even though the corresponding decorated phase object may belong to the core theory.
- The PII source has α = 0. Its theorem does not become an arbitrary-α connection formula by changing a label.
- The Stokes triple (i,i,0) satisfies (1.25) but does not admit the literal η formula involving 1/s₃; the continued expression needs its own proof.
- Hastings–McLeod boundary Stokes data do not satisfy this generic PII input. Neither this theorem nor endpoint smoothness asserts absence of poles throughout every intermediate time interval.
- The entire function exp(−z²) is flat at both real ends but has modulus exp(R²/2) on arg z = −π/3. Pole-freeness plus real-ray decay therefore fails the sectorial arc test; the explicit uniform weighted bounds above are essential.

*Needs:* Internal: 6.4, 6.5, 7.1, 7.2, 7.4, 7.5, 8.5, 8.6, 8.4; [Airy, Fredholm and Hastings–McLeod theory](#dependency-airy-hm) (8.4; 8.5).

<a id="target-8-8"></a>
### 8.8 The Hastings–McLeod bridge

**Painlevé application.**

**Hypotheses.**

- Supplied normalized real Hastings–McLeod solution and its derivative at a regular real time; no second existence theory.

Consume the scalar result already owned by RandomMatrices §8.5: its normalized real Hastings–McLeod solution of q″ = tq + 2q³, its uniqueness and real pole-freeness. At a regular real time t₀, use §7.1's first-jet inverse to construct the intrinsic phase point from (q(t₀),q′(t₀)). Apply §§4.5–4.7 and prove that the resulting horizontal section evaluates to the supplied scalar solution on its real domain and on the common analytic continuation. Prove independence of t₀ using uniqueness and the first-jet overlap comparison. The real initial values determine the local complex analytic solution; they do not by themselves prove its boundary behavior, which is consumed from the supplier.

The primary-source chart comparison is VDPS09 §4.10, translated to §7.5's momentum and Hamiltonian normalization. That source supplies the chart, not the Hastings–McLeod existence theorem consumed from RandomMatrices.

**API.**

- Construct the phase-point and horizontal-section bridge from the supplied first jet.
- Prove commutation with scalar evaluation and with continuation through changes of phase chart.
- Transport the supplier's reality and real pole-freeness assertions through that evaluation; retain its Airy normalization unchanged.

**Checks.**

- Replacing q ∼ Ai by q ∼ k Ai with k ≠ 1 does not satisfy the same supplier contract.
- Choosing a second regular real initial time produces the same horizontal section after transport, not a second distinguished solution.
- Real pole-freeness does not assert absence of poles at complex times, and the bridge does not infer that stronger statement.

*Needs:* Internal: 4.5, 4.6, 4.7, 4.8, 4.9, 7.1, 7.5; [Airy, Fredholm and Hastings–McLeod theory](#dependency-airy-hm) (8.4; 8.5).

#### Examples

The identity-jump model checks the RHP normalization. The generic PVI and homogeneous-PII loci distinguish a proved connection formula from an unrestricted all-parameter assertion. The Hastings–McLeod bridge checks interoperability with an independently owned scalar theory, without using its formula to define the intrinsic dynamics.

#### Dependencies

Use the exact *Needs* list at each target and the cross-package registry in `design/reuse_registry.json`. General proof prerequisites belong to their independent package; this layer verifies its stated application comparisons.

<a id="layer-9"></a>

## Layer 9: Confluence and convergence

<a id="algebraic-confluence"></a>

**Purpose.** Isolate two reusable results. The first is linear Laurent algebra with an elementary analytic convergence consequence for arbitrary finite-dimensional coefficients. The second constructs a relative dual Poisson structure from a finite locally free algebra. They require no Painlevé equation, primitive endpoint condition, phase dimension, asymptotic solution, or moduli quotient.

### Contracts and ownership

| Contract | Input → output | Proof owner |
| --- | --- | --- |
| 9.1 | Vector-valued Laurent germs and principal-part cancellation → exact rational identity, limiting coefficients and compact-uniform convergence | This roadmap: 9.1 |
| 9.2 | Finite locally free commutative algebra A → relative Poisson structure on (gl_n ⊗ A)∨, base change and all-coefficient sign transport | This roadmap: 9.2 |

The two targets are independent. A collision of connections may use both, but neither general theorem takes the collision’s geometric conclusions as hypotheses. A divisor or coefficient presentation produces comparison lemmas; it does not define the general Poisson object. The determinant, formal type, relative orbit conditions, reduction existence and horizontal-connection limit remain obligations of a consuming application.

<a id="target-9-1"></a>
### 9.1 Finite principal-part cancellation with vector-valued coefficients

**General theory.**

**Hypotheses.**

- A finite-dimensional complex vector space V, an integer r ≥ 0 and convergent meromorphic/holomorphic germs with the stated pole bounds and P having a simple zero.
- The principal-part cancellation is the displayed definition of B_j; the finite identity, coefficient formula and compact-uniform convergence are proof outputs.
- For the exact pole order r + 2, W ≠ 0. No connection, Poisson reduction, formal-type classification or primitive endpoint condition is assumed.

Let V be an arbitrary finite-dimensional complex vector space and r ≥ 0 an integer. Work with convergent meromorphic germs at ε = 0. Let P(ε) = t₁ε + ⋯ + tᵣ₊₁εʳ⁺¹ + O(εʳ⁺²), with t₁ ≠ 0; let C(ε) be V-valued with a pole of order at most r + 1, and write W for its ε⁻ʳ⁻¹ coefficient; and let D_j(ε) be holomorphic V-valued germs for 0 ≤ j ≤ r. For a Laurent germ f, write [f]_<0, [f]₀ and [f]_≥0 for its negative part, constant coefficient and nonnegative part. Define B_j = −[CPʲ]_<0 + D_j and

A_ε(z) = Σⱼ₌₀ʳ B_j(ε)/zʲ⁺¹ + C(ε)/(z − P(ε)).

Prove the exact finite identity

A_ε(z) = Σⱼ₌₀ʳ (D_j(ε) + [C(ε)P(ε)ʲ]_≥0)/zʲ⁺¹ + C(ε)P(ε)ʳ⁺¹/[zʳ⁺¹(z − P(ε))].

This identity uses only scalar multiplication on V. Prove that C(ε)P(ε)ʳ⁺¹ tends to t₁ʳ⁺¹W and that, on every compact subset of ℂ \ {0}, A_ε converges uniformly to Σⱼ₌₀ʳ (D_j(0) + [CPʲ]₀)/zʲ⁺¹ + t₁ʳ⁺¹W/zʳ⁺². After shrinking the ε disk, the denominator on a fixed compact set K is bounded below by |z − P(ε)| ≥ dist(K,0)/2. Thus a finite rational remainder proves uniform convergence; no exchange with an uncontrolled infinite series is needed. Prove naturality under complex-linear maps V → V′. For an invertible parameter substitution ε = φ(η), transport C, P and B_j by composition and define D′_j = B_j ∘ φ + [(C ∘ φ)(P ∘ φ)ʲ]_<0; prove that D′_j is holomorphic and gives the same rational family and limiting coefficients. Principal-part projection itself does not commute with a nonlinear substitution: the holomorphic D_j must receive this correction. The transformed leading coefficients satisfy (t′₁)ʳ⁺¹W′ = t₁ʳ⁺¹W. A change of the z-coordinate is a separate comparison of the rational expression, not an identification of its individual coefficients without transformation.

The coefficient t₁ʳ⁺¹W is nonzero exactly when W is nonzero. In that case the limiting V-valued rational function has a pole of order r + 2 at z = 0. For V = M_n(ℂ) this is a statement about matrix pole order, and supplies no projective Katz slope or formal normal form. If instead C = O(ε⁻ʳ), then CPʳ⁺¹ = O(ε), so the purported new highest coefficient is zero. This is the index/scaling correction needed before the printed pole-raising assertion in GMR23, Theorem 2, pp. 1391–1392, (12)–(15) can be used. The corrected lemma is proved here rather than treating that printed statement as a premise. Whether an application’s time-dependent coefficient basis agrees with its actual Laurent coefficients must be checked in that application.

**API.**

- Construct the principal-part cancellation for arbitrary finite-dimensional coefficient spaces and prove the exact finite rational identity.
- Compute all limiting coefficients and prove uniform convergence on each compact set avoiding the collision point.
- Prove compatibility with linear coefficient maps and invertible parameter substitution, including the necessary holomorphic correction to D_j.
- Distinguish the nonzero highest matrix pole coefficient from formal slope, and exhibit the loss of that coefficient under the insufficient C = O(ε⁻ʳ) scaling.

**Checks.**

- At r = 1, C = W/ε², P = t₁ε + t₂ε², B₀ = −W/ε² and B₁ = −t₁W/ε give the limit t₂W/z² + t₁²W/z³. For t₁ = 1, t₂ = 0, the entire expression equals W/[z²(z − ε)]. By contrast C = W/ε, B₀ = −W/ε, B₁ = W and P = ε give 2W/z² in the limit, with zero triple-pole coefficient.
- At r = 0, C = W/ε, P = t₁ε and B₀ = −W/ε + D₀ give the limit D₀(0)/z + t₁W/z²; the formula must cover this smallest collision.
- If W = 0, the highest coefficient vanishes. The theorem does not assert a pole of order r + 2 or preserve a nonzero-leading formal stratum in that case.
- Applying a linear functional V → ℂ before or after cancellation gives the same scalar formula. Choosing V = M_n(ℂ) changes no coefficient index and introduces no matrix commutator into this lemma.
- For r = 0, C = 1/ε, P = ε, B₀ = −1/ε and D₀ = 0, substitute ε = η + cη². Then [C ∘ φ]₀ = −c and D′₀(0) = c, so the limiting simple-pole coefficient remains zero. Setting D′₀ = D₀ ∘ φ without correction would give the wrong coefficient −c.

**Supporting constructions owned by this target.**

- Use the scalar native meromorphic-germ principal part and holomorphic remainder and FormalLaurentPuiseux L1/L3 for the formal vector-valued comparisons. Construct the finite-dimensional convergent-germ adapter by scalar components, prove basis independence and linear naturality, and compare each analytic Laurent coefficient with the formal one. The exact rational remainder proves analytic compact-uniform convergence independently of formal valuation convergence.

*Needs:* [Formal scalar and vector-valued Laurent algebra](#dependency-formal-series) (L1–L4; L5–L6 for finite-extension steps in 1.1); [Native convergent meromorphic germs](#dependency-meromorphic-germs) (meromorphicGerms.principalPart; principalPart_eq_iff; principalPart_eq_sum_coeff; Analytic regular remainder); [Complex manifolds, holomorphic bundles and observations](#dependency-complex) (K1; K3.0; K3.HolomorphicStalk; K3.MeromorphicGermField; K4; K7.1).

<a id="target-9-2"></a>
### 9.2 Relative dual Poisson structures for finite locally free algebras

**General theory.**

**Hypotheses.**

- A complex algebraic or analytic base B, a finite locally free commutative O_B-algebra A and an integer n ≥ 1.
- For a residue presentation, the additional finite flat Cartier divisor in a smooth relative curve and its actual dualizing/residue comparison data; an identification A ≅ A∨ is not assumed for general A.
- For KKS or reduction compatibility, the specified smooth orbit locus and compatible moment-map/reduction data with their hypotheses already verified. The Poisson bracket and sign isomorphism do not create those loci or quotients.

Let B be a complex algebraic or complex analytic base, A a finite locally free commutative O_B-algebra, and n ≥ 1. Form the locally free Lie algebra L = gl_n(O_B) ⊗ A with [X ⊗ a, Y ⊗ b] = [X,Y] ⊗ ab. On the relative dual vector bundle L∨, define the positive linear Poisson bracket intrinsically by {ℓ_X,ℓ_Y}₊ = ℓ_[X,Y], where ℓ_X(ν) = ν(X); extend by the biderivation rule. Construct the corresponding algebraic or holomorphic relative Poisson tensor, prove Jacobi and prove compatibility with base change. The structure is relative to B and makes no assertion about a Poisson bracket in the base directions. Define the negative convention by {f,g}₋ = −{f,g}₊.

Prove that fiber negation N(ν) = −ν is a Poisson isomorphism from the negative to the positive convention: {N*f,N*g}₋ = N*{f,g}₊. This negates every linear coefficient, including every degree in a Takiff-coordinate presentation; an identity map of coefficient matrices is not the comparison. Construct the relative group of units GL_n(A) and its coadjoint action, and prove equivariance of N. On an already specified smooth coadjoint-orbit locus, compare the paired KKS conventions ω_±,ν(ad*_Xν,ad*_Yν) = ±ν([X,Y]) and prove N*ω₊ = ω₋. For H₊ ∘ N = H₋, prove the corresponding Hamiltonian-vector-field transport using the recorded paired convention. Transport an already supplied compatible moment-map and regular-reduction datum through this equivariant comparison, with its sign convention recorded. The output is compatibility where that datum exists, not existence of arbitrary quotients, flatness of relative orbits, or smoothness of a reduction locus.

Retain the actual dual carrier. The trace pairing identifies L∨ with gl_n(O_B) ⊗ A∨; it does not identify A∨ with A. If the application supplies a finite flat Cartier divisor P in a smooth relative curve, write p: P → B and construct A∨ ≅ p_*ω_P/B with A = p_*O_P, where ω_P/B ≅ ω_C/B(P)|_P is the relative dualizing module. Prove the resulting perfect residue pairing with A. In a local polynomial presentation A = O_B[z]/(Q(z)), with Q monic of degree m, the coordinate lemma identifies the dualizing generator with dz/Q and the Frobenius functional λ_Q(f) with the coefficient of zᵐ⁻¹ in the representative of degree less than m. Equivalently λ_Q(f) is the sum of the residues of f(z)dz/Q(z) at the divisor. Prove perfectness, base change and compatibility with changes of such presentations, transporting the differential generator as well as coefficients. A general finite locally free A need not admit such a Frobenius identification; its intrinsic dual Poisson structure does not require one.

On a split fiber A ≅ ∏_i ℂ the Lie algebra and bracket split accordingly. On a local fiber A ≅ ℂ[z]/zᵐ, prove the Takiff-coordinate formula [Xzⁱ,Yzʲ] = [X,Y]zⁱ⁺ʲ for i + j < m and zero for i + j ≥ m, together with the corresponding dual linear Poisson formula. These are coordinate lemmas for the intrinsic finite-algebra construction. For the source comparison in GMR23, brackets (96)–(97), the negative convention is transported by fiber negation; a connection convention dY/dz = A_source Y versus ∇ = d + A_ours additionally requires A_ours = −A_source, with its residue and exponent coefficients transformed consistently. GMR23 Definitions 3–4 and Theorem 12, §4.2, are models on their stated domains, not a proof that every local-condition orbit or collision reduction is flat or regular.

**API.**

- Construct the relative dual linear Poisson structure from multiplication in A, and prove Jacobi, functoriality under algebra isomorphisms and base change.
- Construct fiber negation as an equivariant Poisson isomorphism and transport the paired KKS, Hamiltonian and already verified reduction conventions.
- Keep A∨ as the dual carrier and prove the residue/Frobenius coordinate comparison only with its specified curve or polynomial input.
- Derive split and truncated-algebra coordinate formulas, including every Takiff degree and the full source-to-supplier sign map.

**Checks.**

- For O_Δ[z]/(z(z − ε)), ε ≠ 0 gives the product of two point algebras, while ε = 0 gives ℂ[z]/z². The central nilpotent class of z is part of the comparison.
- With X = E₁₂, Y = E₂₁ and ν_source = diag(1,−1)/2, the source linear Poisson bracket is −1. At ν_ours = −ν_source the positive supplier bracket is also −1; pullback under fiber negation agrees, while identity comparison gives +1. For a Takiff algebra the bracket is zero when the sum of the two degrees exceeds the truncation degree.
- For Q(z) = z(z − ε) and f = a + bz, λ_Q(f) = b. When ε ≠ 0 this equals [f(ε) − f(0)]/ε; at ε = 0 it is the coefficient of the surviving nilpotent class z. The dualizing pairing persists although the separated-point expression contains 1/ε.
- For A = ℂ[x,y]/(x,y)², every functional λ gives a degenerate pairing (a,b) ↦ λ(ab): a nonzero element of span{x,y} in the kernel of λ pairs to zero with all A. Thus a general finite locally free algebra cannot be identified with its dual by an unstated Frobenius functional, while the dual Poisson construction still applies.
- The fiber-negation map is not evidence that a chosen orbit family is flat or that a desired complex symplectic quotient exists. Those are separate hypotheses or construction targets of the application.

**Supporting constructions owned by this target.**

- For a finite flat effective relative Cartier divisor p:P→B in a smooth relative curve C→B, prove adjunction ω_(P/B)≅ω_(C/B)(P)|P and finite-flat duality p_*ω_(P/B)≅Hom_B(p_*O_P,O_B), with residue-normalized trace and base-change/parameter-change compatibility. In a monic presentation Q of degree m, prove perfectness of λ_Q(f)=coefficient_(m−1)(f mod Q), compare it with the residue trace and glue. This additional-hypothesis theorem is included in 9.2; an arbitrary finite locally free algebra is not identified with its dual without such a perfect pairing.

- For the analytic branch, use the complex analytic-space and coherent/finite locally free sheaf carriers constructed in the analytic foundational prefix of 1.2, retaining nilpotent coefficients. Construct the relative vector-bundle and unit-group charts by local trivializations and prove their gluing and base-change comparisons. 9.2 owns the relative complex Poisson, coadjoint, residue and conditional reduction comparisons. This use of shared carriers imports no connection-moduli, RH or Painlevé theorem.

*Needs:* Internal: 1.2; [Smooth real linear Poisson signs](#dependency-poisson) (G4.6A); [Algebraic vector bundles and finite locally free sheaves](#dependency-bundles) (L0A–L0C; L1A–L1B; L2A–L2B); [Cohomology, duality and curve degree](#dependency-cohomology) (2.2; 2.6; 2.20; 3.3).

### Source and scope

Bibliographic information and source locators are listed in [sources.toml](sources.toml). Relevant locators in [GMR23](https://doi.org/10.1007/s00220-023-04650-8) are Theorem 2, (12)–(15), with the explicit correction in 9.1; §4.2, Definitions 3–4 and Theorem 12; and brackets (96)–(97). The source’s §5.1 restriction to nonramified Painlevé realizations is a limitation of those applications, not a restriction on either elementary general contract above. No source theorem is used to infer arbitrary orbit flatness, reduction existence or primitive endpoint admissibility.

<a id="target-9-3"></a>
### 9.3 Normalized section convergence from logarithmic one-forms

**General theory.**

**Hypotheses.**

- A common connected simply connected complex domain, explicit holomorphic line isomorphisms, a fixed nonvanishing frame, normalization factors and a common domain of nonvanishing scalar representatives.
- A common base point with convergent nonzero normalized values, and integral convergence of the actual corrected logarithmic one-forms uniformly on the stated compact path families.
- For the sufficient local-uniform-form condition, uniformly bounded path lengths in a common compact set for each compact endpoint set; endpoint conclusions are not part of this lemma.

Prove a convergence lemma for arbitrary holomorphic line sections, independently of any determinant or differential-equation origin. Let Ω be a common connected simply connected complex domain with a fixed point s₀. Supply holomorphic line bundles L_ε, sections σ_ε, comparison isomorphisms Φ_ε: L_ε → L₀, a nowhere-zero holomorphic frame e of L₀ on Ω, and specified nowhere-zero holomorphic normalization factors c_ε. Write Φ_ε(c_εσ_ε) = f_ε e, including ε = 0, and restrict to a domain where all the f_ε under consideration and f₀ are nowhere zero. Existence of these comparisons and a common nonvanishing domain is input, not a consequence of an unspecified degeneration. Normalization factors may remove divergent factors; their parameter derivatives and the chosen frame must be included in the actual corrected one-forms α_ε = d log f_ε.

For every compact K ⊂ Ω, choose piecewise smooth paths γ_s from s₀ to s ∈ K, contained in a common compact K′ ⊂ Ω and with uniformly bounded lengths in a fixed local metric. Assume f_ε(s₀) → f₀(s₀) ≠ 0 and sup_{s∈K}|∫_{γ_s}(α_ε − α₀)| → 0. Uniform convergence of the one-forms on each such K′ is a sufficient condition. Prove f_ε(s)/f₀(s) = [f_ε(s₀)/f₀(s₀)] exp(∫_{γ_s}(α_ε − α₀)) and hence locally uniform convergence f_ε → f₀. Prove independence of path using the logarithmic-derivative identity; alternatively, closed holomorphic one-forms on the simply connected domain and one nonzero base-point value construct their unique nowhere-zero scalar representatives by exponentiating primitives.

This lemma requires neither a Fredholm realization nor the targets on connections, asymptotic parametrices or collision geometry. Such applications must first construct the line/frame comparisons and prove that their proposed variational forms really equal the displayed logarithmic derivatives. In particular, using a JMU or Hamiltonian expression requires its own proved comparison and does not automatically extend it to a resonant or ramified endpoint. BERT17, Proposition 2.3, formula (3.6), Theorem 3.3 and §3.1.2, and BERT16, Theorem 2.2 on its comparison locus, concern those possible inputs rather than a universal identification. This proof concerns a common nonvanishing domain. Across zeros, use a separate holomorphic representative and, where available, the determinant convergence route of §9.4. Endpoint connection constants and nonlinear Stokes limits require additional uniform sectorial estimates and compatible asymptotic normalization.

**API.**

- Express compared and normalized line sections in one specified frame, including all scalar factors in the actual logarithmic derivative.
- Prove the exponential integral identity and locally uniform scalar convergence from base-point normalization and compact-path estimates.
- Construct nowhere-zero representatives from closed holomorphic one-forms and one nonzero base-point value on a simply connected domain.
- Retain separate obligations for comparison formulas, passage through zeros, and endpoint or connection-constant limits.

**Checks.**

- Multiplying τ_ε by an uncontrolled ε-dependent nonzero constant leaves d log τ_ε unchanged but can destroy convergence; the base-point normalization is essential.
- For τ_ε(z) = z − ε, scalar determinants converge across the zero, while their logarithmic derivatives do not converge uniformly in a neighborhood of it.
- Convergence on every fixed compact time interval does not give a uniform endpoint asymptotic estimate, so it cannot alone determine the limiting connection constant.
- A change of line frame or a parameter-dependent normalization factor changes the logarithmic one-form by its actual logarithmic derivative; the comparison must include this correction before applying the convergence estimate.

*Needs:* [Complex manifolds, holomorphic bundles and observations](#dependency-complex) (K1; K3.0; K3.HolomorphicStalk; K3.MeromorphicGermField; K4; K7.1).

<a id="target-9-4"></a>
### 9.4 Trace-norm determinant convergence and local zero counts

**General theory.**

**Hypotheses.**

- A fixed Hilbert space and trace-class-norm holomorphic operator families with convergence in trace norm uniform on compact parameter sets.
- For varying Hilbert spaces, specified valid identifications and convergence of the conjugated operators, including any contour and measure factors; a line-section realization is separate input if claimed.
- For zero counts, one complex parameter, a fixed relatively compact bounded domain with piecewise smooth boundary, common holomorphy near its closure, and a limiting determinant nonzero on that boundary and not identically zero.

Use the generic trace-class determinant and its trace-norm continuity from RandomMatrices §8.3, within that supplier’s actual operator scope. On one fixed complex Hilbert space H, let K_ε(s) be trace-class operators, holomorphic in trace norm on a common complex domain Ω, and suppose K_ε → K₀ in trace norm uniformly on every compact subset of Ω. Prove that D_ε(s) = det_H(id − K_ε(s)) is holomorphic and converges to D₀ locally uniformly. For each compact parameter set K, the image K₀(K) is compact in trace norm. Apply continuity of the generic determinant at the points of that compact image and a finite subcover; compact-uniform trace-norm convergence then gives uniform scalar convergence on K. The holomorphic-family assertion is proved from normal convergence of the exterior-power series with the trace-norm estimates constructed here. This is a theorem about scalar holomorphic representatives and can include their zeros; it does not integrate logarithmic derivatives across a zero.

For operators initially acting on different Hilbert spaces H_ε, supply specified bounded complex-linear isomorphisms U_ε: H_ε → H with bounded inverses, transport K_ε by conjugation, and prove the trace-norm convergence of these transported operators. Moving-contour parametrizations, orientation and measure factors must be included in the identification; pointwise convergence of untransported kernels is not the trace-norm hypothesis. If the scalar determinant is to represent a preassigned line section, the application must prove that realization and control any multiplying nonzero scalar factor. This target neither repeats the generic determinant construction nor assumes that every RHP admits this trace-class representation.

For the zero-count consequence, specialize to one complex variable and a bounded domain D with piecewise smooth boundary and compact closure in a common holomorphy domain. Require D₀ to be nonzero on ∂D and not identically zero. Prove that, for sufficiently small ε, D_ε and D₀ have the same number of zeros in D counted with multiplicity, using uniform convergence on the boundary and Rouché’s theorem. Localize this assertion to small disjoint domains around isolated limiting zeros; do not infer an unrestricted global zero-count statement. Endpoint connection constants and nonlinear Stokes limits still require uniform endpoint or sectorial estimates and compatible asymptotic normalization. Convergence on all fixed compact subsets supplies neither condition.

**API.**

- Export holomorphic determinant convergence from compact-uniform trace-norm convergence on a specified fixed Hilbert space.
- Transport varying Hilbert spaces through explicit identifications and record the contour, measure and scalar-normalization obligations required by an application.
- Prove eventual equality of local zero counts with multiplicity under the stated one-variable boundary hypotheses.
- Keep convergence through zeros distinct from logarithmic-derivative convergence and from endpoint or Stokes-constant limits.

**Checks.**

- On H = ℂ take K_ε(z) = 1 − z + ε. Then K_ε converges in trace norm and D_ε(z) = z − ε converges as a holomorphic determinant across the zero, while d log D_ε = dz/(z − ε) does not converge uniformly near that zero.
- The constant family D_ε ≡ ε converges uniformly to the identically zero function; the limiting nonvanishing-boundary hypothesis fails, so no zero-count conclusion follows.
- A moving-contour kernel formula must include the parametrization and measure factors in the transported operator before a trace-norm estimate is a statement about one fixed Hilbert space.
- Convergence on every fixed compact time interval does not give a uniform endpoint asymptotic estimate, so it cannot alone determine the limiting connection constant.

**Supporting constructions owned by this target.**

- For compact K in the common parameter domain, K0(K) is compact in trace norm. Apply continuity of the generic Fredholm determinant at each point of this compact image and a finite cover; trace-norm uniform convergence on K then gives uniform scalar convergence on K. A bound merely uniform on trace-norm balls is unnecessary. To prove holomorphic dependence, apply normal convergence to the supplier's exterior-power series and establish its requisite trace-norm estimates as the holomorphic-family adapter. For zero counts, consume native Rouché on discs; for the stated general domain, construct a finite oriented boundary cycle and prove its winding characterization.

*Needs:* [Generic trace-class determinant](#dependency-trace-determinant) (8.3, generic operator-theory prefix); [Trace-class ideal carrier](#dependency-trace-ideal) (OI-B01–OI-B19; OI-B23; OI-B29–OI-B30); [Native Rouché and zero counts](#dependency-rouche) (rouche; rouche_nullHomologous; Multiplicity zero-count carrier).

<a id="target-9-5"></a>
### 9.5 Collision families of geometric connection data

**Painlevé application.**

**Hypotheses.**

- The collision datum specified in this target: curve and finite-flat divisor family, labels, determinant/exponent/time maps, leading orbit, lower coefficients and local descent/filtration data. Primitive endpoints satisfy every condition of 3.3; boundary endpoints are recorded separately. The regular domain is defined by actual relation/deformation ranks; Poisson/sign comparisons, the corrected Laurent lemma, common charts and horizontal-field convergence are construction/proof outputs.

Define a collision datum as the following geometric family, with arrows given by isomorphisms preserving all the data. Over a collision disk Δ_ε and an admitted limiting time/parameter domain, give a smooth projective curve family with a finite-flat structural divisor of degree four; ordered labels on its separated branches over ε ≠ 0 and their specialization map; a determinant line connection and its comparison; and a flat family of local polar-part conditions in the dual of gl₂ ⊗ O_P, with filtrations or factorized ramified descent as required. Specify the meromorphic-in-ε exponent map, the time map with nonzero derivative for ε ≠ 0, and any finite parameter cover used by these maps. Specify the local leading-coefficient orbit and the lower coefficients that determine its formal type, not merely the multiplicity of the divisor. The limiting formal condition is either a §3.1 condition with its actual minimal projective slope or a separately marked lower-complexity boundary condition. These are algebraic/formal data; no horizontal solution limit, symplectic equivalence or RHP convergence is a field of the definition.

The admitted primitive classical domain first requires both primitive endpoints to be objects of §3.3: genus zero, rank two, structural degree four, the admitted local formal structures, a regular-singular determinant with its fixed-residue compatible time transport, the actual reduced versal time problem, generic weights and nonempty stable fibers. Projective slopes or trace-free deformation ranks cannot replace this endpoint condition. Within that domain, impose the nonzero-leading/factorization relations and construct the regular comparison locus where the relative local-condition and deformation complexes have flat coherent terms and the constant ranks computed from the endpoint problems. Define it using the actual relation and Kodaira–Spencer maps, invariant under changes of presentation; neither the time/phase dimension conclusions of §3.4 and §3.7 nor equality of horizontal distributions is a field added to the input.

A boundary endpoint instead records its actual reduced structural/local conditions, determinant pole order and the rank or leading-term conditions that fail. It is not silently admitted to the primitive classical domain. It receives an elementary scalar confluence arrow only through its separately proved §7.3 dictionary and phase/first-jet comparison. An extra scalar irregular determinant is not a primitive endpoint merely because its projective profile agrees with one in §3.4. Construct the moduli/reduction comparisons on the specified regular locus, prove its rank description in the local model, and obtain the common phase charts and horizontal-field extension by solving the strong deformation equations of targets 3.9–3.12. A component without this verified regular comparison has no asserted solution-convergence arrow.

For A = p_*O_P, import target:9.2’s relative dual Lie–Poisson structure and its residue comparison with the curve’s polar data. The split point algebras and the truncated local algebra at collision are coordinate realizations of this one finite-algebra family. Verify separately that the chosen local-condition orbits and relative reductions satisfy the regularity and flatness conditions needed by this collision datum; the general Poisson construction does not establish those properties. Apply the supplied fiber-negation isomorphism to the GMR23 conventions: dY/dz = A_source Y versus ∇ = d + A_ours requires A_ours = −A_source, for every Takiff coefficient and residue/exponent parameter. Identify the actual residue pairing, paired KKS form, moment map, reduction and Hamiltonian conventions through that isomorphism. An identity map of coefficient matrices is not this adapter.

Use GMR23 Definitions 3–4 and Theorem 12, §4.2, pp. 1428–1429, for its ordered cascade and Takiff models, and Theorem 13, §4.3, pp. 1435–1436, for limiting Hamiltonians on their stated domains. For each coordinate collision model satisfying the simple-zero and pole-bound hypotheses of target:9.1, instantiate that corrected principal-part lemma with V = M₂(ℂ). Its exact finite identity supplies the limiting Laurent coefficients and compact-uniform coefficient limit away from the collision point; the application must match these actual Laurent coefficients with the source’s time-dependent coefficient basis and the chosen exponent/time map. The printed Theorem 2, pp. 1391–1392, (12)–(15), is not used unchanged: C = O(ε⁻ʳ) makes CPʳ⁺¹ = O(ε), whereas the corrected ε⁻ʳ⁻¹ coefficient W gives the highest limit coefficient t₁ʳ⁺¹W. Under a nonlinear change of collision parameter, transport the holomorphic D_j correction specified by the general lemma as well. Neither this matrix coefficient limit nor a nonzero highest matrix coefficient determines the projective Katz slope or supplies a moduli/reduction comparison. Prove the full endpoint formal-type and regular-locus adapters already required above. GMR23 §5.1, p. 1441, explicitly restricts its Painlevé realizations to the nonramified case; the ramified comparisons remain owned applications.

**API.**

- Construct the collision-data groupoid, the specified rank-defined admitted domain, its special fiber and the determinant/local-structure comparison. Prove invariance of its domains under curve, frame and parameter-cover changes.
- Prove Poisson and symplectic-reduction compatibility on the stated regular loci and identify any needed resolution or modification.
- Prove convergence of the pulled-back horizontal distributions in common local charts from the geometric deformation equations.
- Construct the endpoint-profile adapters for every verified collision datum, retaining its leading orbit, lower coefficients, ramification and exponent map. A vanishing leading coefficient is sent to its computed new formal stratum or marked boundary. The quantified arrows are these collision-data comparisons, not an unstated finite list of familiar scalar arrows.

**Checks.**

- For O_Δ[z]/(z(z − ε)), ε ≠ 0 gives the product of two point algebras, while ε = 0 gives ℂ[z]/z². The central nilpotent class of z is part of the comparison.
- At r = 1, C = W/ε², P = t₁ε + t₂ε², B₀ = −W/ε² and B₁ = −t₁W/ε give the limit t₂W/z² + t₁²W/z³. For t₁ = 1, t₂ = 0, the entire expression equals W/[z²(z − ε)]. By contrast C = W/ε, B₀ = −W/ε, B₁ = W and P = ε give 2W/z² in the limit, with zero triple-pole coefficient.
- The family −B/(εz) + B/[ε(z − ε)] + C/z tends to B/z² + C/z. For B = diag(1,−1) the projective slope is 1. For B = E₁₂ and C = E₂₁ it is 1/2 after z = w² and gauge diag(1,w). For B = E₁₂ and C = 0, gauge I + E₁₂/z removes the pole. These cases have the same collision divisor but different endpoint formal data; the last leaves the generic irregular domain.
- With X = E₁₂, Y = E₂₁ and ν_source = diag(1,−1)/2, the source linear Poisson bracket is −1. At ν_ours = −ν_source the positive supplier bracket is also −1; pullback under fiber negation agrees, while identity comparison gives +1. For a Takiff algebra the bracket is zero when the sum of the two degrees exceeds the truncation degree.
- A global test family on ℙ¹ has poles 0, εT, 1, ∞ and coefficient (−B/ε + C)/z + (B/ε)/(z − εT) + D/(z − 1), with T ≠ 0 and εT ≠ 1. Its limit is TB/z² + C/z + D/(z − 1), and its residue at infinity remains −C − D. For the primitive classical test impose tr(B) = 0 and the specified determinant residues/transport. Regular semisimple trace-free B gives the underlying (0,0,1) profile; nilpotent B with the indicated nonzero lower coefficient gives (0,0,1/2). Verify the full §3.3 endpoint conditions, exponent map, stable locus and time comparison T ↦ εT before promoting either coefficient model to a moduli arrow.
- B = diag(1,2) has the same projective slope-one shape as its trace-free part diag(−1/2,1/2), but its limiting determinant has the term 3T dz/z². It is outside the primitive classical domain even though scalar twisting does not change invariant subbundles or the trace-free commutator complex.

*Needs:* Internal: 3.1, 3.2, 3.3, 3.4, 3.5, 3.6, 3.7, 3.9, 3.10, 3.11, 3.12, 5.2, 9.1, 9.2; [Smooth real KKS and regular reduction](#dependency-reduction) (R2; R3).

<a id="target-9-6"></a>
### 9.6 Confluence by the general compact-path theorem

**Painlevé application.**

**Hypotheses.**

- The verified geometric comparison of 9.5, a reference lift, positive-margin common charts, uniform field/common Lipschitz control and initial convergence; approximating pathwise existence is a conclusion.

Apply NonlinearConnections §0.9 to the actual time/phase comparison of §9.5. Supply a reference horizontal lift on a fixed compact piecewise C¹ time path avoiding the limiting fixed singularities. Verify finitely many common charts with a positive boundary margin, uniform convergence of the path-pulled fields (including the path velocity), a common local Lipschitz bound and convergent initial points. The general theorem then produces the approximating lifts on the entire path and proves uniform convergence; their existence/no-exit is not assumed. Import its segment estimate (initial error + ℓδ_ε)exp(Lℓ) and finite-chart gluing. Holomorphic fields give derivative bounds only on a larger common neighborhood where Cauchy estimates apply. Uniformity on compact time domains, parameter families or endpoint sectors requires its separate common-cover and path-family controls; none follows from convergence along one path.

**API.**

- Verify the exact common-chart and field-convergence hypotheses on each claimed geometric collision domain.
- Apply the imported no-exit and quantitative convergence theorem without a separate scalar proof.

**Checks.**

- On [0,2], the approximating fields F_n = 1/(n+1), limiting field F_ref = 0 and initial value 0 give x_n(t) = t/(n+1), with uniform error 2/(n+1). For identical zero fields and initial values (−1)ⁿ, the solutions do not converge; the initial-convergence hypothesis is essential.
- Coefficient convergence on a chart does not control a trajectory that leaves every common neighborhood; the positive-margin hypothesis is used in the proof.
- The estimate is uniform on the fixed compact path. It does not assert uniform convergence on an unbounded time ray or across a limiting fixed singularity.

*Needs:* Internal: 9.5, 0.9.

<a id="target-9-7"></a>
### 9.7 The cascade as coordinate comparison

**Painlevé application.**

**Hypotheses.**

- Verified geometric collision-data arrows of 9.5, their recorded endpoint/parameter/time maps and domains, and the matched-data/common-neighborhood hypotheses needed for 9.6. Scaled scalar equations and their jet comparisons are derived using targets 7.1–7.5; composition retains the actual comparison data, and exchanging limits requires additional uniform estimates.

Construct the cascade as the category generated by the verified collision-data arrows of §9.5, with endpoint identifications and the stated domains retained. Its morphisms are data-dependent comparisons; the ten underlying profiles alone do not specify an arrow. For each such arrow choose the time and phase charts only after the geometric comparison is built, then derive the scaled classical equation, its parameter map and its first-jet correspondence using targets 7.1–7.5. The ramified (0,0,1/2) endpoint is obtained only on its nonzero lower-coefficient locus; a removable or vanishing-leading-term endpoint is placed in its separately computed lower stratum and receives a §7.3 scalar boundary comparison only where the first-jet comparison is proved. Prove coverage of each arrow's recorded domain, its nonzero scaling factors and its omitted charts. Apply §9.6 to obtain the solution limit for matched initial points. Composition uses compatible determinant, label, parameter-cover and time identifications; interchanging limits requires an additional uniform theorem. This theorem quantifies over the invariant collision-data class, and makes no claim that an unspecified finite graph exhausts every possible degeneration. (GMR23, Definitions 3–4, Theorems 12–13; the corrected Laurent lemma is owned by AlgebraicConfluence §9.1 and applied in §9.5, and §5's source realizations retain their nonramified scope.)

**Checks.**

- Two paths to a profile can produce different time scales or parameter names; equality requires the comparison maps, not equality of the final classical label.
- An algebraic limit of a displayed equation without a first-jet inverse does not yet identify its phase points or solution germs.
- Successive limits with different allowable neighborhoods need not commute, even when the displayed limiting differential equations agree.

*Needs:* Internal: 3.12, 7.1, 7.2, 7.3, 7.4, 7.5, 9.5, 9.6.

<a id="target-9-8"></a>
### 9.8 Tau-confluence adapters for general analytic convergence

**Painlevé application.**

**Hypotheses.**

- Actual line/frame/normalization comparisons and either the proved logarithmic-form estimates or common-Hilbert-space trace-norm estimates, with separate boundary or endpoint hypotheses when claimed.

Construct the actual determinant-line comparisons, frames, nonzero correction factors and common regular normalization point for the collision of §9.5. With these identifications, verify one of two independent general contracts. AnalyticRHPAndDeterminants §9.3 yields normalized scalar convergence from convergence of corrected logarithmic forms on controlled compact path families in a simply connected zero-free domain. The forms must be the actual determinant-frame forms of §6.4; JMU/Hamiltonian formulas can be used only on their proved comparison locus in §§6.4–6.5.

Alternatively, prove controlled moving-contour, measure and operator identifications with one Hilbert space and compact-uniform trace-norm convergence, then apply AnalyticRHPAndDeterminants §9.4. This route can include zeros; zero counts require nonvanishing of the limit on the chosen boundary and a limit not identically zero. The line/frame/operator comparisons are application obligations, not supplied by the abstract convergence theorems. Endpoint constants and nonlinear Stokes limits additionally require the verified uniform sectorial controls of §8.6 and compatible asymptotic normalization; §9.6 alone does not give them.

**API.**

- Construct and verify the line, frame, normalization and operator comparisons across the actual collision.
- Discharge the hypotheses of the chosen general convergence route and any additional zero-count or endpoint conclusion.

**Checks.**

- Multiplying τ_ε by an uncontrolled ε-dependent nonzero constant leaves d log τ_ε unchanged but can destroy convergence; the base-point normalization is essential.
- For τ_ε(z) = z − ε, scalar determinants converge across the zero, while their logarithmic derivatives do not converge uniformly in a neighborhood of it.
- Convergence on every fixed compact time interval does not give a uniform endpoint asymptotic estimate, so it cannot alone determine the limiting connection constant.

*Needs:* Internal: 6.3, 6.4, 6.5, 8.6, 9.5, 9.6, 9.3, 9.4.

#### Examples

A two-pole collision tests the local algebra and Laurent rescaling before its classical display. Constant fields with mismatched initial points test the necessity of the analytic hypotheses. The determinant family z − ε tests the difference between function convergence and logarithmic-derivative convergence at a zero. These examples prevent a formal coefficient limit from being mistaken for the full confluence theorem.

#### Dependencies

Use the exact *Needs* list at each target and the cross-package registry in `design/reuse_registry.json`. General proof prerequisites belong to their independent package; this layer verifies its stated application comparisons.

### Downstream consumers

A later random-matrix or integrable-probability application can consume this intrinsic phase/observable bridge together with RandomMatrices §§8.3–8.5, preserving the existing ownership of Fredholm determinants, the Airy edge and Hastings–McLeod theory. Such a joint consumer is a new downstream target; the existing RandomMatrices roadmap is not retroactively made to depend on this one.

Further consumers include geometric special-function and connection-formula comparisons, moduli of irregular connections and character varieties, and controlled degeneration problems. They consume the proved horizontal, symplectic, continuation and normalization interfaces at their actual scope. A differential-algebraic classification of all irreducible transcendents, a complete classification of algebraic special solutions, discrete/q-difference Painlevé systems and cluster or Sakai-wide constructions are separate extensions. None supplies a premise to the intrinsic differential construction above.

Implementation follows the dependency graph. Build each general result from its stated geometric or analytic foundations, and apply it only after its hypotheses have been verified. The five-point application uses the general moduli and continuation theorems without Painlevé prerequisites. The Painlevé construction and property precede the surface and tau developments; the classical coordinate comparisons follow those intrinsic constructions. Normalized analytic applications and confluence use the relevant comparison theorems and independently specified general analytic or algebraic results. This order keeps the common definitions and theorems independent of the classical scalar displays.


### References

- **I13.** Michi-aki Inaba. *[Moduli of parabolic connections on a curve and Riemann–Hilbert correspondence](https://arxiv.org/abs/math/0602004v2)*. Journal of Algebraic Geometry 22 (2013), 407–480. Cited preprint: arXiv math/0602004v2, 6 June 2012; Theorems 2.1–2.2, preprint pp. 5–6; §§1, 6. The family properness theorem uses the exponent fiber product and its exact numerical/stability hypotheses.

- **I23.** Michi-aki Inaba. *[Moduli Space of Factorized Ramified Connections and Generalized Isomonodromic Deformation](https://sigma-journal.com/2023/013/)*. SIGMA 19 (2023), 013, 72 pages. Publisher version, 22 March 2023. Locators: Definitions 2.1–2.8; Remark 2.9; Theorems 5.1, 7.5, 8.1, 9.7 and 11.6; equation (6.9); Propositions 6.3, 7.2, 8.2–8.3, 10.7 and 10.10; Definitions 10.1 and 11.4; Corollaries 9.11 and 11.8; equations (8.2), (11.2) and (11.5).

- **IS12.** Michi-aki Inaba; Masa-Hiko Saito. *[Moduli of unramified irregular singular parabolic connections on a smooth projective curve](https://arxiv.org/abs/1203.0084v3)*. Kyoto Journal of Mathematics 53(2) (2013), 433–482. Cited version: arXiv 1203.0084v3 (22 November 2012); the key retains the preprint year. Locators: Theorem 5.1; Remark 6.3.

- **HEU10.** Viktoria Heu. *[Universal isomonodromic deformations of meromorphic rank 2 connections on curves](https://www.numdam.org/item/AIF_2010__60_2_515_0/)*. Annales de l'Institut Fourier 60(2) (2010), 515–549. Published text through NUMDAM; printed pp. 515–549. Locators: Theorem 1.1; Definitions 2.3 and 2.10; §2.

- **VDPS09.** Marius van der Put; Masa-Hiko Saito. *[Moduli spaces for linear differential equations and the Painlevé equations](https://arxiv.org/abs/0902.1702v5)*. Annales de l'Institut Fourier 59(7) (2009), 2611–2667. Cited version: arXiv 0902.1702v5 (12 November 2009); remaining internal inconsistencies are identified in §7.4. Locators: §2.2, Table 1, preprint pp. 18–19; §3; §4.1 and §§4.3–4.11; equations (12), (17) and (22).

- **IIS06.** Michi-aki Inaba; Katsunori Iwasaki; Masa-Hiko Saito. *[Dynamics of the Sixth Painlevé Equation](https://arxiv.org/abs/math/0501007v2)*. Séminaires et Congrès 14 (2006), 103–167. Cited version: arXiv math/0501007v2 (6 March 2005). Locators: Definitions 2.1–2.2 and 2.11; Lemma 2.12; Definition 3.5; Theorems 4.10–4.12, 5.15–5.16, 7.4, 10.6, 10.10 and 10.13; §§5, 7 and 10.

- **BOA01.** Philip Boalch. *[Symplectic Manifolds and Isomonodromic Deformations](https://arxiv.org/abs/2002.00052v1)*. Advances in Mathematics 163 (2001), 137–205. Cited version: arXiv 2002.00052v1, the author's 2020 deposit of the 2001 article. Locators: §§3–6; Theorems 7.1 and 7.3; §7.

- **BOA14.** P. P. Boalch. *[Geometry and braiding of Stokes data; Fission and wild character varieties](https://arxiv.org/abs/1111.6228v3)*. Annals of Mathematics 179(1) (2014), 301–365. Cited version: arXiv 1111.6228v3 (22 September 2012). Locators: §10, Theorem 10.2; §7 for Stokes data.

- **BY15.** Philip Boalch; Daisuke Yamakawa. *[Twisted wild character varieties](https://arxiv.org/abs/1512.08091v1)*. arXiv preprint 1512.08091. Cited version: arXiv 1512.08091v1 (26 December 2015). Locators: Remark 3; Definitions 7 and 13; Proposition 19; Theorem 21; Corollary 22.

- **STT02.** Masa-Hiko Saito; Taro Takebe; Hitomi Terajima. *[Deformation of Okamoto–Painlevé pairs and Painlevé equations](https://arxiv.org/abs/math/0006026v2)*. Journal of Algebraic Geometry 11(2) (2002), 311–362. Cited version: arXiv math/0006026v2 (18 September 2000), the three-author article. Locators: Definitions 1.1 and 1.3; Proposition 1.2; Tables 2–3; Theorem 3.1; §6.

- **TER02.** Hitomi Terajima. *[Local cohomology of generalized Okamoto–Painlevé pairs and Painlevé equations](https://arxiv.org/abs/math/0006027v1)*. Japanese Journal of Mathematics, New Series 28(1) (2002), 137–162. Cited version: arXiv math/0006027v1 (5 June 2000). Locators: Theorem 2.1; Proposition 2.1; Conjecture 2.1.

- **ST04.** Masa-Hiko Saito; Hitomi Terajima. *[Nodal curves and Riccati solutions of Painlevé equations](https://arxiv.org/abs/math/0201225v1)*. Journal of Mathematics of Kyoto University 44(3) (2004), 529–568. Cited version: arXiv math/0201225v1 (23 January 2002). Locators: §2.4; Proposition 2.1; Definition 2.3; Remark 2.4; Appendix A.

- **FM19.** Andrea E. V. Ferrari; Lionel Mason. *[Meromorphic Painlevé III transcendents and the Joukowski correspondence](https://arxiv.org/abs/1809.07885v2)*. Journal of Integrable Systems 4(1) (2019), xyz001. Cited version: arXiv 1809.07885v2 (30 January 2019). Locators: §1.1; equation (2).

- **DIL21.** Jan Dereziński; Artur Ishkhanyan; Adam Latosiński. *[From Heun Class Equations to Painlevé Equations](https://sigma-journal.com/2021/056/)*. SIGMA 17 (2021), 056, 59 pages. Publisher version, 7 June 2021. Locators: §§5.2–5.3; Appendix B.3.

- **AHT17.** Primitivo B. Acosta-Humánez; Marius van der Put; Jaap Top. *[Isomonodromy for the Degenerate Fifth Painlevé Equation](https://sigma-journal.com/2017/029/)*. SIGMA 13 (2017), 029, 14 pages. Publisher version, 9 May 2017. Locators: Introduction; §§2–3.

- **MAL04.** Bernard Malgrange. *[Déformations isomonodromiques, forme de Liouville, fonction τ](https://www.numdam.org/articles/10.5802/aif.2052/)*. Annales de l'Institut Fourier 54(5) (2004), 1371–1392. Published text through NUMDAM; printed pp. 1371–1392. Locators: §2, printed pp. 1372–1374; Theorem 5.12.

- **BERT10.** Marco Bertola. *[The dependence on the monodromy data of the isomonodromic tau function](https://arxiv.org/abs/0902.4716v2)*. Communications in Mathematical Physics 294 (2010), 539–579. Cited version: arXiv 0902.4716v2 (20 January 2016); always used with BERT16. Locators: Assumption 3.1; §5.1, Proposition 5.1; Theorem 5.1 only with the correction BERT16.

- **BERT16.** Marco Bertola. *[Corrigendum: The dependence on the monodromy data of the isomonodromic tau function](https://arxiv.org/abs/1601.04790v2)*. Communications in Mathematical Physics 381 (2021), 1445–1461. Cited version: arXiv 1601.04790v2 (19 September 2020), published in 2021 as Correction to: The Dependence on the Monodromy Data of the Isomonodromic Tau Function. The key retains the initial 2016 preprint year. Locators: Definition 2.1; Theorems 2.1 and 2.2.

- **BERT17.** Marco Bertola. *[The Malgrange Form and Fredholm Determinants](https://arxiv.org/abs/1703.00046v4)*. SIGMA 13 (2017), 046, 12 pages. Cited version: arXiv 1703.00046v4, carrying the SIGMA publication text. Locators: §1; Theorem 2.2; Proposition 2.3; formula (3.6); Theorem 3.3; §3.1.2.

- **ILP18.** A. R. Its; O. Lisovyy; A. Prokhorov. *[Monodromy dependence and connection formulae for isomonodromic tau functions](https://arxiv.org/abs/1604.03082v4)*. Duke Mathematical Journal 167(7) (2018), 1347–1432. Cited version: arXiv 1604.03082v4 (29 October 2018). Locators: §1.4, Theorems A and B, equations (1.13), (1.16)–(1.21), (1.25)–(1.28); Lemma 3.3; Propositions 3.20 and 3.24; §3.9; §§4.3–4.5, especially (4.74)–(4.76); Remark 4.8.

- **DIK08.** P. Deift; A. Its; I. Krasovsky. *[Asymptotics of the Airy-kernel determinant](https://arxiv.org/abs/math/0609451v2)*. Communications in Mathematical Physics 278 (2008), 643–678. Cited version: arXiv math/0609451v2 (21 June 2007). Locators: Theorem 1; equations (2)–(3).

- **HXZ16.** Min Huang; Shuai-Xia Xu; Lun Zhang. *[Location of Poles for the Hastings–McLeod Solution to the Second Painlevé Equation](https://arxiv.org/abs/1410.3338v2)*. Constructive Approximation 43(3) (2016), 463–494. Cited version: arXiv 1410.3338v2 (9 July 2015). Locators: Theorem 2.1.

- **GMR23.** Ilia Gaiur; Marta Mazzocco; Vladimir Rubtsov. *[Isomonodromic Deformations: Confluence, Reduction and Quantisation](https://doi.org/10.1007/s00220-023-04650-8)*. Communications in Mathematical Physics 400 (2023), 1385–1461. Publisher version of record, 1 March 2023, under CC BY 4.0. Locators: Theorem 2, pp. 1391–1392, (12)–(15), used only with the corrected rank-raising coefficient lemma in §9.5; Definitions 3–4 and Theorem 12, §4.2, pp. 1428–1429; brackets (96)–(97); Theorem 13, §4.3, pp. 1435–1436; §5.1, p. 1441, for its explicit nonramified scope.

- **DLMF.** P. A. Clarkson, *[Painlevé Transcendents, Chapter 32 of the NIST Digital Library of Mathematical Functions](https://dlmf.nist.gov/32)*. Version 1.2.8, released 15 September 2026. [§32.2](https://dlmf.nist.gov/32.2), equations 32.2.1–32.2.6; [§32.6](https://dlmf.nist.gov/32.6); [§32.7](https://dlmf.nist.gov/32.7); [§32.9](https://dlmf.nist.gov/32.9), especially equations 32.9.6 and 32.9.12. Standard scalar displays and normalization reference.

<a id="reuse-contract"></a>

## Appendix: the reusable proof contract

### Acceptance contract

A reusable result has its own inputs, outputs, laws, failure cases, owner and dependency unit. Its transitive prerequisites contain no specialized application. Applications use the same native objects and prove that the hypotheses apply; they do not copy the carrier or repeat the general proof. Actual morphisms, pullbacks and coherence maps are retained. Reusability does not justify weakening a necessary hypothesis.

### Independently reusable theories

| General theory | Targets | Reusable mathematics | Proof owner |
|---|---:|---|---|
| [NonlinearConnections](#nonlinear-connections) | 9 | Actual nonlinear connections and base change; continuous-time local lifts; holomorphic germs; proper-transfer completeness; fundamental groupoids and descent; relative forms; observations; intrinsic jets; compact-path limits | This roadmap: 0.1–0.9 |
| [MeromorphicConnectionModuli](#connection-moduli) | 12 | Admitted decorated input → full moduli, deformation cone, relative symplectic form and constructed strong flat splitting; regular-singular RH branch | This roadmap: 1.1–2.6 |
| [AnalyticRHPAndDeterminants](#analytic-theory) | 7 | Complex Fredholm determinant line; Cauchy-class small-norm RHP; weighted moments and uniform tails; normalized analytic limits | This roadmap: 6.1; 8.1–8.3; 8.4; 9.3–9.4 |
| [AlgebraicConfluence](#algebraic-confluence) | 2 | Vector-valued principal-part cancellation; relative Lie–Poisson structures on duals over finite locally free algebras | This roadmap: 9.1–9.2 |

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

[FiveLogarithmicPoints](#five-point-application) contains four application targets with no direct or transitive Painlevé prerequisite. It starts with rank two on an ordered five-pointed projective line, structural degree five, determinant (O,d), and fixed residue pairs ±1/4, ±1/4, ±1/6, ±1/6, ±1/4. Explicit rational weights avoid stability walls. The normalized configuration base has dimension 5−3=2. The phase dimension is −8+2+10=4.

Nonemptiness is witnessed by (D,J,K,K⁻¹,(DJ)⁻¹), where D=diag(i,−i), J=[[0,1],[−1,0]] and K=diag(exp(πi/3),exp(−πi/3)). The product is I; D and J have no common invariant line. Chosen logarithmic lattices, the determinant comparison and stability turn this irreducible representation into an admitted connection for every configuration. No trivial rank-two underlying bundle or global marked object is assumed. The exact I13 inequality is 2·5−2·2−2=4>0.

Both applications consume the same construction in MeromorphicConnectionModuli 2.4, the same completeness theorem in NonlinearConnections 0.4 and the same groupoid/descent theorem in 0.5. The second consumer exposes accidental classical assumptions: its four-dimensional phase fiber cannot be identified with a scalar first-jet fiber, and its two-dimensional time base does not support an unqualified one-variable pole statement. A holomorphic time-curve pullback and an initial point give meromorphic evaluation on the pointed universal cover under the observer hypotheses. Descent to the time curve requires scalar deck invariance, or a separately supplied horizontal phase section on the curve. Garnier coordinate displays lie outside the five-point application.

### Application-specific proof ownership

Painlevé owns the degree-four restriction, the ten underlying and seventeen ordered profile classification and one-dimensional time conclusion; the remaining classical irregular/Stokes and all-strata proper-RH extension; full surface and boundary comparisons; transformations and invariant reductions; actual observer/jet charts; resonant/ramified index-zero RHP realizations; the geometric contour, endpoint and uniformity adapters; and collision families, endpoint admissibility, common charts and tau line/frame/operator comparisons.

The vector-valued pole-cancellation theorem does not classify Katz slopes or certify a primitive endpoint. The relative Lie–Poisson theorem does not assert existence of every symplectic quotient or flatness of every orbit family. Those comparisons remain explicit application obligations.

### Shared objects and dependency conditions

Every target has a unique address and a definite proof owner. Internal references resolve in an acyclic dependency graph. General targets depend only on foundations and other general targets; the two applications supply their own admission and comparison proofs. The English text, Japanese text and structured plan specify the same hypotheses, conclusions, laws and failure cases. A comparison theorem retains its actual maps and their composition laws; an equality of informal names does not replace it.
