# Laurent phenomenon library

This directory contains checked Lean proofs and reusable algebraic interfaces for
both the upper-bound and Caterpillar proofs. It is independent of cluster exchange matrices and
coefficient semifields. The cluster roadmap remains in
[ClusterAlgebras](../ClusterAlgebras/README.md); this document describes the
implementation boundary, not completion of that roadmap.
The cluster implementation derives classical Laurentness from integral quantum
Laurentness and a proved `v=1` map. The quantum and classical implementations
and their consumers are ordinary source modules in this checkout. Their shared
interfaces, production build profile and verification boundaries are recorded in
[ClusterAlgebras/FORMALIZATION.md](../ClusterAlgebras/FORMALIZATION.md).

Import `TauCetiRoadmap.LaurentPhenomenon` for the public library. Declarations live
in `TauCeti.Laurent`. Tests are separate imports under `LaurentPhenomenon.Tests`.

## Shared algebra for the upper-bound proof

The cluster upper-bound route imports these modules directly, without importing
the Caterpillar entry point:

| Module | Reusable result |
|---|---|
| `UpperBoundPattern` | Local three-chart inclusions in a complete lattice imply upper-bound invariance and equality with the intersection of reachable charts; generator membership works in arbitrary ambient rings |
| `DenominatorPatching` | Finite right-ideal identities clear denominators in an embedded subring without commutativity; the left version supplies `ComaximalIntersection` |
| `PolynomialExchange` | Constructed polynomial corrections and homogenized reciprocal evaluation replace an exchange partner for arbitrary polynomial input |
| `SkewPatching`, `SkewReplacement`, `FiniteExchangeReplacement` | Normalizers, polynomial defects and finite ordered exchange sums in a division ring; the binary premise and the nonzero-coordinate commutative polynomial theorem use the same finite-sum proof |
| `FlatDivisibility` | A scalar identity `(p) ∩ (q) = (p*q)` extends to flat modules and central divisibility in noncommutative algebras, without choosing a basis |
| `SkewExchange`, `OneExchangeBase`, `OneExchangeChart` | Exact embedded skew one-variable Laurent intersection; the classical intersection is its trivial-automorphism instance |
| `CommutingExchange` | Two-variable intersection over a factorial domain with relatively prime exchange factors |
| `ComaximalIntersection` | Intersection of two localizations at comaximal elements in an embedded domain |
| `LaurentWeight`, `LaurentSupport`, `PolynomialSupport` | Finite-support widths and relative primality of arbitrary scalar polynomials with constant coefficient one on independent cyclic directions |
| `Quantum.ChangeChart` | Faithfulness of a changed quantum chart from off-coordinate agreement and skew one-variable freeness |
| `Quantum.ScaledMonomial` | Exact scalar phases in chart multiplication and the finite polynomial replacement coefficient identity |
| `Quantum.PolynomialDivisibility` | Simultaneous division by central polynomial factors, using the existing coset basis and flat-module theorem |
| `LaurentFactorial` | Factoriality of finite-rank integer lattice group rings |
| `PositiveWeight`, `CoordinateWeight` | Orders of subtraction-free expressions and nonnegative support of a Laurent representative |
| `CoefficientChart`, `IntegerEvaluation` | Coefficient images, the canonical fraction embedding, initial-chart image equality, and all-one integral evaluation |
| `MutationWord` | Finite words of involutions, concatenation, cancellation, and reversal |

`PositiveFraction.represented_transfer` moves a Laurent representation from a
faithful ambient-field realization to a positive-defined specialization by
cross-multiplying in the source ring. No map from an entire rational-function
field at potentially singular coordinates is assumed. The cluster layer owns
extended matrices, geometric seed comparisons, and normalized coefficient
separation; these generic algebra modules do not import that layer.

`ClusterAlgebras.UpperBound` uses the complete-lattice local inclusion from
`UpperBoundPattern` for its subring-pattern argument, used by quantum and classical
upper bounds. The polynomial quantum calculation constructs the finite ordered premise
directly from the actual seed; the binary calculation is its degree-one instance.
The independent classical local replacement also uses the singleton instance
`ReplacementPremise.zss_mem`.
`PolynomialExchange` itself accepts arbitrary polynomials and a degree bound;
it does not require monicity, reciprocal coefficients or positivity. Its signed
three-term consumer checks a local replacement, not a global generalized seed
pattern. The chart case constructs the premise of
`FiniteReplacementPremise.zss_mem`, with no commutativity assumption on that
shared theorem. The cluster audit checks these transitive proof dependencies.
`ClusterAlgebras.PolynomialQuantumReplacement` constructs the premise in every
degree; its coefficient and defect modules verify the ordered formulas from
matrix compatibility. The ordinary public Laurent theorem consumes this general
Q2 proof through the degree-one comparison. `Examples.PolynomialQuantum` retains
an explicit trinomial coefficient calculation, while `Examples.PolynomialSeedChecks`
uses the complete nonreciprocal cubic seed, all-word Laurent theorem and classical
specialization. All are built together by ordinary Lake imports, and all source
modules enter the whole-library audit.

The simultaneous coefficient divisibility in `CommutingExchange` uses
`TauCeti.Module.algebraMap_mul_dvd_of_relPrime`, the self-module instance of the
flat-module theorem. Its general algebra instance is also checked in the
noncommutative integer matrix ring. Relative primality is required only in the
commutative scalar ring; no noncommutative unique factorization is assumed.

`OrderedExchange` supplies ordered coefficient products and their power identities
for a coefficient-ring homomorphism into any ring and a unit implementing a
specified automorphism. A matrix-ring consumer uses a nontrivial automorphism
and checks that this product differs from the ordinary power. This arithmetic
has only a ring as ambient algebra. `SkewExchange` provides the embedded
skew-Laurent intersection in a division ring. Quantum seed mutation is owned by
the cluster layer. The finite replacement and its trinomial quantum consumer
do not depend on the binary replacement theorem.
The ordered-product consumers are defined in `Tests.UpperBoundLibraryAudit`;
the legacy verification driver checks their actual proof dependencies.

## Objects and dependency direction

| Interface | Data and hypotheses | Proved output |
|---|---|---|
| `LaurentEvaluation.Ring R I` | Any commutative ring `R`; any variable type `I` | Laurent polynomials as Mathlib's additive group algebra of finitely supported integer exponents |
| `LaurentEvaluation.eval c x` | A coefficient homomorphism and a unit for each variable | A ring homomorphism, monomial formulas and naturality |
| `LaurentEvaluation.rename`, `mapCoefficients` | A map of variable indices or coefficient rings | Identity/composition and evaluation compatibility; `renameEquiv` for bijections |
| `LaurentEvaluation.chart_eq_range` | A coefficient map into a field and assigned units | Equality between the generated Laurent chart and the evaluation image |
| `algebraicIndependent_update_exchange`, `adjoin_range_update_exchange` | An algebraically independent tuple and a nonzero exchange polynomial independent of the exchanged variable | Independence and the same generated field after birational exchange |
| `PolynomialChartModel` | A chart isomorphism, local polynomials, a cancellation identity and relative primality of coefficient data | Third-coordinate membership and relative primality, using one shared local calculation |
| `RealizedCaterpillar` | Actual nonzero coordinates and polynomial exchanges on a finite labelled tree | Finite Laurentness from explicit polynomial local models |
| `PolynomialExchangePattern` | Actual nonzero coordinates and involutive polynomial exchanges on a state space | Laurentness along every mutation word from the same polynomial local models |
| `PositiveCaterpillar` | Finite variable type; positive polynomial exchanges and propagation identities; `IsDomain (TotalLaurentRing G I)` | Canonical Laurentness, with local coprimality supplied by the constructed universal deformation |
| `PositiveExpression.DefinedAt f` | Each operand actually inverted by the finite expression evaluates nonzero | Specialization of its proved Laurent representative along `f` |

`PolynomialChartModel` contains neither third-coordinate membership nor relative
primality of the resulting coordinates. Its compatibility and relative-primality
assumptions are on the displayed polynomial data. The coefficient ring of a local
model is a unique factorization domain. Factoriality of the Laurent chart is then
derived from its isomorphism with a one-variable Laurent polynomial ring; callers
do not separately supply it.

The dependency direction is:

1. Coefficient rings, Laurent evaluation, charts and denominator algebra.
2. Local polynomial cancellation and coprimality, shared through
   `PolynomialChartModel`.
3. Mutation-word and finite-tree induction.
4. Positive coefficient deformation, constructed local models, canonical
   Laurentness and finite-expression specialization.
5. The cluster adapters in `TauCetiRoadmap.ClusterAlgebras`, then concrete examples.

No module here imports `ClusterAlgebras`. The public library imports no test or
example modules. Finite trees, path embeddings and labels belong to
`FiniteCaterpillar`; they do not depend on positivity. Positive coordinate points
belong to `PositivePoint` and are defined for additive coefficient groups, without
a coefficient-semifield or finite-rank assumption.

The positive Laurent theorem itself does require finite mutable rank and that
the integer group ring of the coefficient-and-mutable lattice is a domain.
Torsion-free additive coefficient groups supply the domain instance. Generality
of the expression and evaluation definitions does not remove these hypotheses
from the Laurent theorem.

## Laurent presentations and specialization

The universal proof uses `TotalLaurentRing G I`, the integer group ring of the
product of the coefficient group and the mutable exponent lattice. It is connected
to `LaurentEvaluation.Ring (AddMonoidAlgebra ℤ G) I` by the explicit ring
isomorphism `LaurentEvaluation.coefficientRingEquiv`. These are presentations of
the same ring. Monomial transport is proved in `CoefficientRing`, and the
coefficient-ring presentation is consumed by
`PositiveCaterpillar.exists_unique_canonical_coefficient_laurent` and
`coefficient_laurent_representative_specializes`.

`PositiveCaterpillar.exists_unique_canonical_laurent_representative` gives a finite
Laurent polynomial in the canonical fraction field. Uniqueness uses the injective
canonical map. For an arbitrary evaluation, `LaurentEvaluation.unique_representative`
requires injectivity explicitly; noninjective specialization does not imply
unique representatives.

`PositiveCaterpillar.laurent_at` assumes `DefinedAt` only for the target coordinate
expression. Unlike preservation of every nonzero positive polynomial, this
condition can hold in positive characteristic. It allows atoms and intermediate
sums to vanish unless they are inverted. It records the actual expression, so it
does not extend evaluation through an undefined intermediate inverse even if a
later formal cancellation would remove the singularity. No specialization map
from the entire rational-function field is asserted.

The global nonvanishing specialization API is a convenience consequence of the
same finite-expression proof. `PositiveFraction` owns expression evaluation,
definedness, representative construction and specialization. There is no separate
implementation of the global and finite denominator arguments.

## Recurrences and verification

`PositiveCaterpillar.value_spine_eq_recurrence` identifies an independently defined
recurrence with the spine coordinates using only its initial values and one-step
law. `recurrence_laurent` and `recurrence_integral` then reuse the Laurent theorem.
`periodic_recurrence_step` separates finite phase calculations from induction on
all recurrence times. These interfaces belong to the independent general
exchange-pattern proof. The cluster roadmap requires the upper-bound route:
[`ClusterAlgebras/Examples/Somos4.lean`](../ClusterAlgebras/Examples/Somos4.lean)
uses `MatrixSeed.cluster_laurent_unique`, the matrix mutation-word comparison,
and the shared Laurent evaluation and positive-specialization interfaces.

`Tests/AlgebraicExamples.lean` exercises local cancellation with signed,
three-term polynomials. This is a local algebra test, not a construction of an
entire signed exchange pattern. `Tests/ReusableAPIAudit.lean` checks a finite
specialization in characteristic two for which the global positive-nonvanishing
condition fails. Cluster tests also check a consumer starting from an initial
matrix seed and the complete Somos-4 integrality proof, including their actual
proof-term dependencies on the Laurent theorem.

The algebraic API covers arbitrary polynomial data satisfying its displayed
local certificates. It does not claim Laurentness for arbitrary polynomial
recurrences without compatibility hypotheses. A full Laurent-phenomenon-algebra
or generalized-cluster seed mutation theory would require its own definitions
and an adapter proving these certificates; neither is silently assumed here.

To build every mathematical source with Tau Ceti's production options:

```text
lake -f lakefile.library.toml build
```

To rebuild the trial sources from scratch and run the complete audit:

```text
python verification/cluster-polynomial/run_verification.py --fresh
```

The legacy audit driver reads the private proof values as well as public
statements. It checks all project declarations for forbidden axioms, verifies
actual quantum and classical proof dependencies, and runs the default environment
linters. Its initial-seed and Somos-4 checks require quantum Laurentness and reject
dependence on the independent Caterpillar proof. A separate legacy driver scans
required documentation. The runner audits compiled module flags,
source headers, text and filename style, source coverage and the public import
boundary. Full details and the exact run report are described in
[FORMALIZATION.md](../ClusterAlgebras/FORMALIZATION.md).
