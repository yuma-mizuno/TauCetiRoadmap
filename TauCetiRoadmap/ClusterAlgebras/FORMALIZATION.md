# Library trial: scope and verification

The [roadmap](README.md) is the mathematical specification. This file describes
which results are implemented and how the library trial is checked.

## Source and build boundary

The binary and polynomial quantum theories, their classical specialization, the generic Laurent
algebra and all consumers are in this checkout's source tree. Build them with:

```powershell
lake -f lakefile.library.toml build
```

This is a normal Lake build. `lakefile.library.toml` uses the repository's pinned
`lake-manifest.json` and `lean-toolchain`, the actual Tau Ceti dependency, and the
production Lean options from Tau Ceti: the Mathlib standard linter set and
`warningAsError`. The project build directory is `.lake/build-library`. No
separate project artifact, external worktree, import-table rewrite or patched
copy of a proof is an input. Production source files contain no heartbeat or
recursion-depth overrides and no disabled linters.

The two public roots are `TauCetiRoadmap.LaurentPhenomenon` and
`TauCetiRoadmap.ClusterAlgebras`; examples and audits are separate modules.
The module prefix identifies this trial package. Mathematical declarations use
`TauCeti.Laurent`, `TauCeti.QuantumTorus` and `TauCeti.Cluster`, and import the
existing Tau Ceti and Mathlib carriers rather than redefining them.

## Implemented proof route

The ordinary binary quantum Laurent theorem is implemented for faithful integral
quantum charts into any division ring and compatible pairs, with frozen variables
and a chosen set of frozen inverses. Its public statements are
`QuantumSeed.coordinate_mutateWord_mem_mutateWord_chartRing`,
`QuantumSeed.coordinate_mutateWord_mem_chartRing`,
`QuantumSeed.clusterAlgebra_le_upperAlgebra` and
`QuantumSeed.upperAlgebra_eq_upperBoundAlgebra`.

The common proof carrier is `ExchangeFrame`, over a commutative scalar ring
`R` and a central unit `q : Rˣ`. It records a symmetrizable exchange matrix,
independent rational columns, an alternating integral commutation form `Λ`,
and diagonal form weights `w` satisfying `BᵀΛ=(diag(w) 0)`. These form weights
are distinct from the matrix's positive symmetrizer and may be zero or negative.
The faithful chart is into a possibly noncommutative division `R`-algebra.
The parameter need not have infinite order. The commuting Q2 and global
Laurent theorem require the scalar ring to be a factorial domain.

`PolynomialExchangeSeed` adds normalized monic central polynomial exchanges.
It owns mutation, faithfulness of the changed chart, involutivity, Q1, Q2,
upper-bound invariance and all-word Laurentness. Binary frame mutation is defined
by its degree-one instance in `QuantumPolynomial`; it has no separate mutation
or one-exchange proof engine. The explicit binary central products, their power
and centrality formulas, and the coefficient criteria also use the common
polynomial proofs; they retain no separate binary power induction.

`QuantumSeed` and `PolynomialQuantumSeed` retain the ordinary positive quantum
compatibility condition as subtypes of the common frames with `R=Zv`, `q=v`
and `w` equal to the positive matrix symmetrizer. Their constructors derive
column independence from ordinary compatibility. Their mutation and public
Laurent statements use the common construction and proof.

`commutativeFrame` uses literal `q=1`, `Λ=0` and `w=0`, retaining
its original integral or field coefficient subring and positive matrix symmetrizer.
`GeometricFrame` obtains column independence directly from full rank and identifies
all coordinate words and chart rings with the independent classical definitions.
The classical upper-bound theorem consequently invokes the same polynomial Q2.
It requires no auxiliary quantization, no positive form weights, and no commutation
of coefficient specialization with intersections. Coordinate words and chart rings
at unit parameter are proved independent of the auxiliary form representation.

The general classical Laurent route applies that same common theorem directly to
the zero-form principal seed, then uses normalized coefficient separation. Its
proof term, including the initial-seed and Somos-4 consumers, uses no quantum
specialization theorem or auxiliary positive compatible form. The proved `v=1`
map on integral Laurent representatives remains a separate comparison API.
Its binary comparison is a degree-one instance of the polynomial comparison,
not a second word induction. The verification checks these actual dependencies.

The cluster-specific normalized Caterpillar route and the former classical local
commuting, interacting and rank-two proof files are removed from this integration.
Their passed source snapshot, applications and checks are preserved separately on
`codex/caterpillar-proof-route` at `6bebb4edc0769ec5867f20d946561f46cc91940e`.
Generic Caterpillar mathematics has its independent `LaurentPhenomenon` entry point.

## Actual shared-library integration

`FiniteExchangeReplacement` proves finite ordered replacement in an arbitrary
division ring. It imports only the seed-free normalizer and polynomial-defect
algebra. `SkewReplacement` constructs its singleton instance and proves the
existing binary theorem from it; there is no alternative `_via_finite` theorem.
`ClusterAlgebras.PolynomialQuantumReplacement` constructs its finite premise;
`QuantumReplacement` is its degree-one specialization. Classical seed comparisons
use the zero-form unit-parameter case of the common polynomial seed. The obsolete
binary coefficient and defect engine is removed, and its concrete premise
consumers now test the finite construction.

`PolynomialExchange.replacement_mem_of_ne_zero` constructs the same finite
premise for arbitrary commutative polynomials using their power corrections.
This does not impose commutativity on the finite replacement theorem or on its
quantum consumer. `FlatDivisibility` supplies simultaneous divisibility for flat
modules. Both seed sectors use its common central calculation, with a basis
supplying the free, hence flat, instance.

`Examples.PolynomialQuantum` proves the displayed trinomial replacement in the
faithful generic quantum torus, including `xy ≠ yx` and constructed defects. Its
dependency audit excludes the binary seed replacement results. All these are
ordinary source modules and are built by Lake.

## Polynomial seed verification

`PolynomialExchangeSeed` adds monic central scalar exchange polynomials with
constant coefficient one to the faithful column-compatible exchange frame.
Positive exchange degrees divide the extended columns. Mutation reverses the
selected polynomial, and preserves the others. Reciprocity is not an input.
`PolynomialQuantumMutation` constructs the mutated faithful chart, and
`PolynomialQuantumInvolutive` proves mutation involutive and Q1.

`PolynomialQuantumCoefficients`, `PolynomialQuantumDefects` and
`PolynomialQuantumTerms` derive every coefficient, defect and actual summand
needed by `finiteReplacement_pos`. Negative replacement is transported through
the opposite algebra, including coefficient reversal. The zero and nonzero
interaction intersection theorems in `PolynomialQuantumCommuting` and
`PolynomialQuantumInteracting` yield `PolynomialQuantumLaurent.three_chart`,
`upperBound_mutate` and `coordinate_mutateWord_mem_mutateWord_chartRing`.
These theorems take seed data, without a local-comparison, coprimality or
Laurentness field.

For zero interaction, divided columns are independent central directions in the
pair chart. `PolynomialSupport.isRelPrime_aeval_single` proves relative primality
of polynomials with constant coefficient one on those directions.
`Quantum.PolynomialDivisibility` uses the existing coset basis and flat
simultaneous-divisibility theorem. `PolynomialQuantumCentralFactors` identifies
these factors with powers of the actual exchange coordinate. All frozen
coordinates are invertible in these chart intersections. This differs from
coprimality in a polynomial ring with non-inverted frozen monomials. BCDX
Theorems 3.1 and 4.9 are not substituted for any of these proofs.

`PolynomialGeometricPattern` defines classical matrix, coefficient-reversal and
coordinate mutation independently of quantum seeds. `PolynomialQuantumSpecialization`
proves specialization along every word. `PolynomialQuantumClassical` proves that
independent initial classical variables remain independent, so this comparison
needs no separate nonvanishing input. Specialization is applied to unique integral
Laurent representatives, never extended to the ambient division ring.
`PolynomialQuantumAlgebra` uses the existing chart subalgebras and expansion
inverse to construct `A_{v,S} ≤ U_v = UB_v` and a surjective classical limit onto
the independently defined polynomial classical cluster ring; `classicalLimit_v_sub_one`
checks explicitly that the relation `v-1` maps to zero. No special-fiber
isomorphism is asserted.

`Examples.PolynomialSeedChecks` instantiates the actual public seed construction
with the nonreciprocal cubic `1+2T+T³`, its coefficient reversal, involutivity,
all-word Laurentness and wordwise classical specialization. This supplements
the explicit noncommutative trinomial coefficient checks; it is not the proof
of the general theorem.

`Examples.ScalarSpecializationChecks` constructs a nonreciprocal cubic over `ℤ`
with parameter one, zero form and zero form weights in an ordinary rational
Laurent fraction field. Its integral all-word Laurent theorem invokes the same
polynomial proof directly, without a faithful `Zv` chart or the wordwise
specialization theorem.

The full polynomial principal-lift API, general relabelling and ambient transport,
and the complete polynomial expansion API remain roadmap implementation targets.
The core all-rank seed construction, local comparisons, global Laurent theorem
and classical specialization above are implemented independently of those targets.
This verification does not certify all of Section 2.6 as a finished library.

## Reproduction and evidence

Run the complete trial from this repository root:

```powershell
python verification/cluster-polynomial/run_verification.py --fresh
```

The runner archives this trial's existing project build directory, checks the
pins and tracked sources of every dependency, rejects additional untracked Lean
dependency sources, clears inherited Lean search-path overrides, and invokes the normal Lake build above. Dependency
artifacts are the usual Lake dependency cache; every trial module is rebuilt
from its own source. The runner neither edits proof sources nor generates import
configurations.

The legacy `LibraryAudit.lean` and `DocumentationAudit.lean` drivers each import
every source module in both libraries. They read the private olean parts,
including theorem proofs, private helpers and declaration documentation. The
runner compares both import lists with the source tree, so an orphan cannot
evade either audit. The audit checks every project declaration's type and value transitively,
including private and generated declarations, against the three-axiom allowlist
`propext`, `Classical.choice`, `Quot.sound`. Backwards graph reachability covers
cycles without assuming that imported declarations are axiom-clean. Negative
controls must reject `sorryAx` both individually and in a module-wide audit.

Every mathematical source opts into Lean's module system; a separate audit reads
the actual `isModule` flag from every compiled olean. The runner uses Tau Ceti's
copyright-header checker, Mathlib's text and filename linters, the complete
default environment-linter set with a separate docstring scan, and rejects
project `nolint` exemptions. The public import closures contain no tests or
examples, and the generic Laurent algebra does not import cluster modules.

The finite positive-expression constructors, integer powers, finite products,
nonempty sums and their field-evaluation proofs belong to
`LaurentPhenomenon.PositiveFraction`, under `PositiveExpression`. Both the
coordinate realization and principal coefficient separation use these same
constructors. Coefficient-semifield evaluation remains in its own adapter;
it does not require a ring structure on the target semifield. The tropical
exponent equivalence has one owner, `Trop.exponentEquiv` in
`PrincipalCoefficients`, used by both principal chart comparison and hat-y
evaluation.

The runner also runs the exact symbolic checks: twelve rank-two cases with symbolic reciprocal
coefficients, six cases with noncommuting frozen coordinates, twelve degree-weighted
principal lifts in ranks zero through three, nonreciprocal cubic exchanges
with the correct reversal, and a fixed nonreciprocal polynomial rule that fails
Laurentness. The negative control concerns keeping its coefficients fixed, not
the reversal mutation used by the general construction. Symbolic checks are additional formula tests, not Lean proofs.

The runner needs Python with Sympy and a TOML parser (the standard `tomllib` on
Python 3.11+, or the `tomli` bundled with pip on Python 3.10).

The current run's status, exact input hashes, dependency pins and audited counts
are written to `.lake/verification/library/result.json`; build and header logs are
in the same directory. The report is successful only after all checks finish and
the input hashes are unchanged. No previous run's output is accepted as a result.
