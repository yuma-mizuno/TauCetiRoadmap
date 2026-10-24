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

The ordinary public proof now uses the polynomial Q2 theorem through the actual
degree-one seed and word comparison in `QuantumPolynomial`. The shared route
runs Q1–Q3, then the proved `v=1` specialization, principal coefficients,
normalized coefficient separation and the general classical Laurent theorem.
The legacy driver `verification/cluster-polynomial/LibraryAudit.lean` checks
the actual proof-term dependencies of the quantum and classical endpoints,
including the initial-seed and Somos-4 consumers. Quantum Laurentness does not depend on the independent
classical upper-bound or Caterpillar proofs. The public classical Laurent theorem
uses the quantum theorem through the proved specialization.

## Actual shared-library integration

`FiniteExchangeReplacement` proves finite ordered replacement in an arbitrary
division ring. It imports only the seed-free normalizer and polynomial-defect
algebra. `SkewReplacement` constructs its singleton instance and proves the
existing binary theorem from it; there is no alternative `_via_finite` theorem.
`ClusterAlgebras.PolynomialQuantumReplacement` constructs its finite premise;
`QuantumReplacement` is its degree-one specialization. The classical
`UpperBoundLocal.replacement_forward` uses the singleton theorem. The obsolete
binary coefficient and defect engine is removed, and its concrete premise
consumers now test the finite construction.

`PolynomialExchange.replacement_mem_of_ne_zero` constructs the same finite
premise for arbitrary commutative polynomials using their power corrections.
This does not impose commutativity on the finite replacement theorem or on its
quantum consumer. `FlatDivisibility` supplies simultaneous divisibility for flat
modules. The classical commuting calculation and the quantum central calculation
both use it; a basis supplies the free, hence flat, instance in the latter.

`Examples.PolynomialQuantum` proves the displayed trinomial replacement in the
faithful generic quantum torus, including `xy ≠ yx` and constructed defects. Its
dependency audit excludes the binary seed replacement results. All these are
ordinary source modules and are built by Lake.

## Polynomial seed verification

`PolynomialQuantumSeed` adds monic central `Zv` exchange polynomials with
constant coefficient one to the existing faithful compatible quantum frame.
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
