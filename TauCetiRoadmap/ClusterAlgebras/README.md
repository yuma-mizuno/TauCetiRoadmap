# Roadmap: classical and quantum cluster algebras, cluster varieties and positivity

Build a reusable theory of classical and quantum cluster algebras: normalized
Fomin–Zelevinsky seeds, compatible quantum seeds, the Fock–Goncharov lattice
formalism and cluster varieties, the Laurent phenomenon, finite-type classification,
double Bruhat cells,
Laurent positivity, and sign-coherence. The algebraic and geometric definitions must
be connected by constructions and comparison theorems, with their full hypotheses.
Suggested homes are `TauCeti/Algebra/Cluster/` and `TauCeti/AlgebraicGeometry/Cluster/`.

Use faithful Laurent charts in a common ambient division ring as the algebraic
interface; the classical case uses a commutative field. Separate
exchange data, their realization by charts, and the choice of coefficient ring.
The tree presentation, normalized FZ tuples, and lattice seed coordinates are connected to
these objects by equivalences and transport theorems. References specify mathematical
results and proof ingredients; their historical encodings do not prescribe the API.

| Layer | Delivers | Depends on |
|---|---|---|
| 0 | Coefficients, based quantum tori, Laurent charts and local algebra | Mathlib; shared twisted algebra |
| 1 | Classical and quantum seeds, mutation words and cluster algebras | 0 |
| 2 | Common polynomial upper bounds; quantum and classical Laurentness; separation | 0–1 |
| 3 | Lattice formalism, cluster varieties and convention transports | 0–2; scheme gluing |
| 4 | Classical upper-bound structure and acyclic presentations | 0–2 |
| 5 | Finite-type classification and root parametrizations | 0–2; RootSystems |
| 6 | Cluster scattering, Laurent positivity and sign-coherence | 0–3; ScatteringDiagrams |
| 7 | Double Bruhat cells and their upper cluster algebras | 0–4; ReductiveGroups |

## Scope and dependency boundaries

The FZ theory has finite mutable rank, arbitrary coefficient semifields, and integer
skew-symmetrizable exchange matrices. Geometric type allows any finite set of frozen
variables and arbitrary frozen rows. Include disconnected, degenerate and zero
exchange matrices, and rank zero. In geometric type allow any specified subset of
frozen variables to be inverted; write the coefficient ring in each theorem.
Cluster schemes here are over characteristic-zero fields; positivity is an integral
coefficient statement before scalar extension. The double-Bruhat-cell target is for
connected simply connected semisimple algebraic groups over `ℂ`, with a pinning.
Quantum theory has finite total rank, geometric coefficients and integral compatible
pairs over `Z_v=ℤ[v,v⁻¹]`, where `v=q^{1/2}` is an indeterminate. Include arbitrary
skew-symmetrizable mutable blocks admitting such a pair, including principal
extensions of singular and zero matrices. Compatibility forces the extended matrix
to have full column rank; it imposes no full-rank condition on the mutable block.
Allow specified frozen variables to remain noninvertible in the cluster algebra.
The quantum targets are seeds, mutation, Laurentness, bar and grading interfaces,
and realization in other algebras. Monoidal categorification, KLR algebras,
arbitrary multivariate exchange systems, quantum positivity, quantum double-cell coordinate
theorems, and canonical bases are outside this roadmap. General special-fiber
isomorphisms and root-of-unity cluster theory are also outside its scope.
Section 2.6 includes monic polynomial quantum exchange patterns with constant
coefficient one and scalar coefficients in `Z_v`. Mutation reverses the selected
polynomial; reciprocal fixed polynomials and ordinary binary exchange are
specializations. Its upper-bound route proves relative primality in the central
Laurent ring of the pair chart. Layers 3–7 concern ordinary cluster seeds;
generalized coefficient-semifield separation is outside this roadmap.

- [ScatteringDiagrams](../ScatteringDiagrams/README.md) owns completed
  wall groups, consistent completion, broken lines, theta transport and wall positivity.
  Consume §§3.4, 4.2–4.4, 5.1–5.7 and 7.1–7.7 at their stated hypotheses. This roadmap
  owns seed mutation invariance, the cluster chambers, and the theta/cluster comparison.
  Cluster positivity consumes these scattering theorems; their construction must not
  assume cluster Laurentness or positivity. The seed-free twisted algebra in §4.3 is
  shared infrastructure described below, not a dependency on wall completion.
- [RootSystems](../RepresentationTheory/RootSystems/README.md), Layers 1–6, owns
  finite root systems, Weyl/Coxeter comparisons and Cartan–Killing classification.
  Layer 5 here owns almost-positive roots, cluster compatibility and the classification
  of mutation classes; it consumes the existing root and Dynkin carriers.
- [ReductiveGroups](../ReductiveGroups/README.md), Layers 7, 7C and 10, supplies
  opposite Borels, actual root subgroups, Bruhat coordinates and rational highest-weight
  representations and root-coordinate constructions.
  Layer 7 here constructs double cells, generalized minors and their cluster charts.
- [SchemeAndStackFoundations](../SchemeAndStackFoundations/README.md), Layer 0,
  supplies scheme gluing, dimension theory and §0.6's normal Hartogs extension.
  [SchubertGeometry](../SchubertGeometry/README.md) owns flag/Schubert section theory;
  use its existing comparisons when expressing minors as sections, without duplicating it.

- [InductionRestriction](../RepresentationTheory/InductionRestriction/README.md),
  Layer 7's twisted group algebra, owns the normalized-cocycle carrier and its
  universal property. Instantiate `TauCeti.twistedMonoidAlgebra` for the lattice
  cocycle in §0.4. ScatteringDiagrams §4.3's `QuantumMonoidAlgebra` must be connected
  to this same carrier by the basis-preserving algebra equivalence; coefficient
  and lattice maps commute with that equivalence. No second multiplication or
  basis theory is to be developed under a cluster-specific name.
- [QuantumGroups](../QuantumGroups/README.md)'s rank-one PBW development owns
  σ-derivation extensions. The present roadmap uses neither these extensions nor
  quantum-group presentations, representations or Hopf structure: its skew Laurent
  and skew polynomial rings are subrings of a division ring generated by a
  coefficient subring and normalizing elements.

## Ownership and proof dependencies

| Shared material | Single home | Consumers |
|---|---|---|
| Twisted algebra, basis and coefficient/lattice maps | Existing twisted monoid algebra; §0.4 instances | Quantum charts, scattering coefficients |
| Ore fractions, embedded skew Laurent normal forms, patching, support and central divisibility | Seed-free algebra, §§0.4–0.6 | Quantum upper bounds, classical upper-bound structure |
| Finite polynomial replacement with ordered coefficients | Seed-free algebra, §0.7 | Ordinary and polynomial quantum Q2, commutative replacement |
| Exchange matrices, symmetrizers, reindexing and mutation words | Layer 1 | Classical, quantum and lattice seeds |
| Adjacent charts and upper-bound invariance implying global membership | Embedded subrings and involutive patterns, Q3 | Quantum Laurentness, classical structural theorems |
| Quantum local comparisons and integral Laurentness | Q1–Q3 | Classical limit L5, quantum realizations Q4 |
| Positive evaluation, frozen orders and normalized coefficient separation | L6–L7 | General classical Laurentness L8, recurrence specialization |
| Classical coprime upper bounds and acyclic presentations | Layer 4 | Double Bruhat cells and classical structural applications |

The Laurent proof runs `Q1–Q3 → L5 → L6–L7 → L8`. Quantum Laurentness must not
import classical Laurentness, separation, scattering, or categorification.
The classical public Laurent theorem is a corollary of this chain. Layer 4 proves
additional equalities of actual commutative subrings; it is not an input to L5–L8.
An abstract intersection theorem may consume explicit local comparison hypotheses,
but each seed instance must prove them from exchange data. No seed structure
contains Laurentness, upper-bound invariance or an unspecified comparison theorem.

## Library interfaces and conventions

Use `Matrix`, `Basis`, `Module.Dual`, `MvPolynomial`, `MonoidAlgebra`,
`AddMonoidAlgebra`, `FractionRing`, `IsFractionRing`, `Subalgebra`, `Subring`,
`Localization` and `IsLocalization` for their existing mathematical meanings.
Multivariable Laurent rings are group algebras of exponent lattices; the one-variable
comparison uses `LaurentPolynomial`. Tau Ceti's `laurentEval` and
`laurentEvalEquiv` in `TauCeti.Algebra.Polynomial.Laurent.Basic` supply evaluation at
a unit. They do not themselves provide the multivariable cluster-field construction.
For roots use `RootPairing`, `RootPairing.Base` and its integer Cartan matrix;
for types use `TauCeti.DynkinType`, `DynkinType.Valid` and `TauCeti.IsFiniteType`.
Extend these APIs where required instead of declaring parallel carriers.

The algebraic formulas below use FZ's column exchange convention and tropical minimum.
The geometric formulas retain GHKK's lattice convention and its maximum tropicalization.
**Changes of convention are mathematical interfaces:** construct the maps in Layer 3,
prove their inverse and mutation-compatibility laws, and transport downstream statements.
A prose instruction to transpose a matrix or change a sign does not discharge a target.
Declaration names are illustrative; the mathematical statements specify the targets.

Use `OreLocalization` and the existing twisted monoid algebra for the noncommutative
foundations. One-exchange, patching and replacement statements concern subrings of a
fixed division ring, not an abstract skew-polynomial carrier. `FractionRing` and
`IsFractionRing` apply only to the commutative specialization.
All quantum algebras are `Z_v`-algebras; quasi-commuting frozen
generators are not assumed to lie in the center.
The quantum matrix `Λ` is distinct from Layer 3's rational skew form and weights.
Construct comparison maps where needed rather than identifying their carriers.


## Layer 0: coefficient and ambient algebra

**0.1 Coefficient semifields.** A coefficient semifield is a commutative group `P` with an
associative commutative `⊕` over which multiplication distributes; there is no
additive-zero requirement (unlike `Semifield`). Construct `⊕`-preserving group
homomorphisms, indexed products, the one-element object, and `Fˣ` for a `Semifield F`
where nonzero elements have nonzero sums. Prove
[`IsMulTorsionFree P`](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Algebra/Group/Monoid.html#IsMulTorsionFree)
and `IsDomain ℤ[P]`
for `ℤ[P]=MonoidAlgebra ℤ P`; construct `FractionRing ℤ[P]` and the injective
`P →* ℤ[P]ˣ`.

For a type `J`, `Trop(J)` is `Multiplicative (J →₀ ℤ)` with `⊕` the componentwise
minimum and generators `z_j`. Construct evaluations `Trop(J) →* Q`, `z_j ↦ q_j`, into
commutative groups, isomorphisms along `J ≃ J'`, and for finite `J` exponents in `J → ℤ`.
`Qsf(K)` is the set of `p/q ∈ FractionRing (MvPolynomial K ℤ)` with `p,q ≠ 0` having
`ℕ`-coefficients, with variables `u_i`; prove it closed under products, inverses and
`+`, so it is a coefficient semifield with `⊕=+`. For `y : K → P` construct the unique
`⊕`-preserving homomorphism `Qsf(K) → P`, `u_i ↦ y_i`; it sends every such `p/q` to
`p(y)/q(y)` computed with `⊕`.

**0.2 Laurent and rational-function models.** For a commutative ring `R` and a type `K`,
`L(R,K) = AddMonoidAlgebra R (K →₀ ℤ)`, with coefficients, support and monomial `Basis`.
Prove that `MvPolynomial K R → L(R,K)` is injective and is the localization at the
variables (`IsLocalization`), `IsDomain` for a domain `R`, reindexing along `K ≃ K'`, and,
for a commutative `R`-algebra `A`, the unique `L(R,K) →ₐ[R] A` with `X_i ↦ x_i` for
`x : K → Aˣ`. Construct coefficient maps along `R →+* R'`, injective along injective maps,
with identity, composition and reindexing laws, and `IsLocalization` of `L(R',K)` over
`L(R,K)` when `R'` localizes `R`. For finite `K`, a domain `R` and a field `F`, a Laurent
chart is an injective `L(R,K) →ₐ[R] F`. Prove that charts correspond to `x : K → Fˣ`
algebraically independent over `R`, and those whose image generates `F` as a field to
transcendence bases generating `F` with the image of `R`; for these construct
`IsFractionRing L(R,K) F` and `IsFractionRing (MvPolynomial K R) F`, with model
`FractionRing (MvPolynomial K R)`. Public results hold for every generating chart and
transport along `F ≃ₐ[R] F'`.

**0.3 Expansions and coefficient rings.** `L_{R,t}` is the range of a chart `t`.
Construct the inverse `exp_t : L_{R,t} ≃ₐ[R] L(R,K)`, finitely supported coefficients,
and compatibility with coefficient inclusions, reindexing and `F ≃ₐ[R] F'`. For
generating `t,t'`, the transition automorphism of `FractionRing L(R,K)` sends `exp_t f`
to `exp_{t'} f` for `f ∈ L_{R,t} ⊓ L_{R,t'}`; it need not preserve `L(R,K)`.
For `R=ℤ[P]`, `f ∈ L(ℤ[P],K)` (or `exp_t f`) is positive when its coefficients lie in
`ℕ[P]`, equivalently lies in the image `ℕ[P][X_i^{±1}]` of
`AddMonoidAlgebra (MonoidAlgebra ℕ P) (K →₀ ℤ)`, a `Subsemiring`.
For finite `J` and `S⊆J`, construct `R_S=ℤ[z_j:j∈J][z_s⁻¹:s∈S] ⊆ ℤ[Trop(J)]` as a
localization of `MvPolynomial J ℤ`, with `ℤ`-basis the `z^a` with `a_j≥0` for `j∉S`.
Prove `R_∅ ≃ MvPolynomial J ℤ`, `R_J = ℤ[Trop(J)]`, and that `R_T` localizes `R_S` at
the `z_t` (`t∈T\S`) for `S⊆T`.

**Checks.** `Trop(Empty)` is the one-element object; `z^{(-1,2)}∈Trop(Fin 2)` evaluates
to `q_0⁻¹q_1²`. `(u_0²+u_0u_1)/(u_0+u_1)∈Qsf(Fin 2)` evaluates to `y_0` in every `P`. The
canonical chart of `L(ℤ,Fin 2)` keeps monomials `ℤ`-linearly independent.

**0.4 Based quantum tori and Ore realizations.** For a commutative ring `R`, a unit
`u∈Rˣ`, a finite free lattice `L` and an integral alternating form `Λ`, let `T(R,u,Λ)` be
the existing twisted monoid algebra of `Multiplicative L` for the cocycle `u^{Λ(a,b)}`, so
`X^a X^b=u^{Λ(a,b)}X^{a+b}`. Prove inverse monomials, coefficient extraction, finite
support, lattice reindexing, coefficient change along ring maps preserving the unit with
identity and composition laws, and the identification with the lattice group algebra when
`u=1` or `Λ=0`, including evaluation and coefficient extraction. ScatteringDiagrams §4.3's
parameter `q_sc` is `u`; quantum cluster notation takes `u=v` and `q_cl=v²`, so
`X_i X_j=v^{2Λ_ij}X_j X_i`. Give explicit maps between the conventions.

For a basis of `L`, construct the quantum polynomial and mixed Laurent subalgebras by
support, with monomial bases and localization at selected monomials. Universal
property: for `S` a subset of the basis, an `R`-algebra `A` and `U_i∈A` with
`U_iU_j=u^{2Λ_ij}U_jU_i` and `U_s` a unit for `s∈S`, there is a unique `R`-algebra map
from the subalgebra with exponents `a_i≥0` (`i∉S`) sending `X_i` to `U_i`. For any total
order on the basis it sends `X^a` to `u^{-Σ_{i<j}a_i a_j Λ_ij}∏_iU_i^{a_i}`, the product
taken in that order; the result is independent of the order.

`T(R,u,Λ)` is a domain when `R` is a domain and `L` has
[`UniqueSums`](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Algebra/Group/UniqueProds/Basic.html#UniqueSums).
Over a field it
satisfies the left and right Ore conditions; prove them (they may then be registered as
instances) rather than assuming them as instance arguments.
Construct its skew field of fractions with `OreLocalization`, proving as extensions of
Mathlib's API the missing injectivity, fraction-comparison, division-ring and
universal-property lemmas; for a domain `R`, coefficient change embeds `T(R,u,Λ)` in
the skew field of fractions of `T(FractionRing R,u,Λ)`. A quantum chart is an injective
`R`-algebra map of `T(R,u,Λ)` into a division ring; it is generating when its image
generates that ring. Generating charts determine their ambient division ring up to
unique isomorphism. The Laurent theorems of Layers 1–2 use only injectivity of charts.

**0.5 One-exchange algebra.** In a division ring, let `C` be a subring, write `C⟨…⟩` for
the subring generated by `C` and the listed elements, `C[p^{±1}]=C⟨p,p⁻¹⟩` and `C[p]=C⟨p⟩`
for nonzero `p`, and let `x≠0` normalize `C` (`xCx⁻¹=C`) with powers left linearly
independent over `C`. Coefficients stay on the left throughout. For a nonzero `E∈C`
normalizing `C`, with `σ(c)=xcx⁻¹`, `P_0=1` and `P_{r+1}=P_rσ^{-r}(E)`, the element
`y=Ex⁻¹` satisfies:
- `y` normalizes `C`, its powers are left independent over `C`, and `y^r=P_r x^{-r}`;
- `Σ_m c_m x^m∈C[y^{±1}]` if and only if `c_{-r}∈C P_r` for all `r>0`;
- `C[x^{±1}]∩C[y^{±1}]=C⟨x,y⟩`, with unique normal forms `c_0+Σ_{r>0}(c_r x^r+c'_r y^r)`.
These criteria and normal forms are proved; membership in the intersection is not
assumed. In the commutative case this is `D[x^{±1}]∩D[(E/x)^{±1}]=D[x,E/x]`; U1 and Q1
are instances. Also prove, for `z` normalizing `C`:
- *patching*: for a subring H of any ring, finite `a_l,u_l∈H` with
  `Σ_l a_lu_l=1` and `f a_l∈H` give `f∈H`. Give the left-sided form through
  the opposite ring. The two-denominator form with `a_1=a^r`, `a_2=b^s` and
  the comaximal-localization intersection theorem are instances;
- *unit constant terms*: the elements `c(1+zw)` with `c∈Cˣ`, `w∈C[z]` are closed under
  products and under conjugation by any `g` normalizing `C` with `gzg⁻¹∈zC`, and each
  has a right inverse modulo `z^sC[z]` for every `s`.
U2b and Q2's interacting intersection are instances.

**0.6 Support and central divisibility.** For a twisted lattice algebra over a domain
and an integer weight `w`, the least and greatest homogeneous parts of nonzero elements
are nonzero and multiplicative, so `lo_w`, `hi_w` and `width_w=hi_w-lo_w` are additive;
the ordinary Laurent ring is the trivial-twist case. In an ordinary lattice Laurent ring
over a domain, let nonzero P,Q have supports in `ℤa`, respectively `ℤb`, for
linearly independent a,b. Prove that P and Q are relatively prime if P has a unit
coefficient; use width to make every common divisor a single monomial, and its
divisibility into the unit coefficient to make it a unit. In particular,
`1+cX^a` and `1+dX^b` are relatively prime for units `c,d` and rationally
independent `a,b`, and over a factorial coefficient ring so are `∏_r(1+c_rX^a)` and
`∏_s(1+d_sX^b)` for units `c_r,d_s`;
prove polynomial descent for polynomials with no variable factor.

For a sublattice `N` with `Λ(N,L)=0`, `T=T(R,u,Λ)` is free over the central subalgebra
`R[N]`, and `Tf∩Tg=T(fg)` for relatively prime `f,g∈R[N]` in a decomposition monoid;
`Z_v[N]` is factorial. When `R` is a domain and no nonzero power of `u²` is `1`, the
center is `R[rad Λ]`.
Neither a Bézout hypothesis nor a noncommutative UFD is used.

Prove the shared scalar-divisibility statement for a flat module M over a
commutative ring R: `(p)∩(q)=(pq)` implies `pM∩qM=(pq)M`, where `pM` is the
image of scalar multiplication by p. Give the elementwise and submodule forms,
and apply it to flat R-algebras, including noncommutative algebras with their
central structure maps. The free-over-center argument above is an instance.


**0.7 Finite polynomial replacement.** Let D be a division ring, C a subring,
and x,z nonzero elements normalizing C. Let x*,z*,z** lie in D, let A be a finite
index set, `N∈ℕ`, `n_a≤N`, and `c_a∈C`, `d_a,g_a∈D`. Let `φ∈C`, `n₀,m₀∈D`
satisfy `φn₀=m₀`. Suppose the actual exchange identities and defects are

```
z* · z = n₀ + Σ_a x^{n_a} c_a,
z** · z = (x*)^N m₀ + Σ_a (x*)^{N-n_a} d_a,
(x*)^{n_a}x^{n_a} - g_a ∈ z C[z],
d_a = g_a x^{-n_a} φ x^{n_a} c_a.
```

Here `C[z]` and its left coefficients have §0.5's meaning; `z C[z]` is the image
of left multiplication by z. Construct the correction and prove

```
z** = (x*)^N φ z* - Σ_a (x*)^{N-n_a}
       ((x*)^{n_a}x^{n_a}-g_a) x^{-n_a}φx^{n_a}c_a z⁻¹,
z** ∈ C⟨x*,z*,z⟩.
```

Give reindexing and zero-term insertion/removal laws. Prove the scalar, singleton
and finite-sum cases from this same identity. The singleton case with `n_a=N=r`,
`φ=m₁n₁⁻¹`, `n₀=n₁`, `m₀=m₁` gives binary replacement; use it for U2c and
ordinary quantum Q2.

For a commutative coefficient ring R, construct
`D_{P,n}(T)=(P(T)^n-P(0)^n)/T` by shifting coefficients, proving
`T D_{P,n}=P^n-P(0)^n`, coefficient change and evaluation laws. For `P,Q∈R[T]`,
`e≥natDegree Q`, a ring map `f:R→F` into a field and nonzero x,y with
`xz=P_f(y)`, `yw=Q_f(x)`, apply the finite replacement with `n₀=m₀=0`, `φ=1`,
`n_a=a`, `c_a=f(Q.coeff a)`, `g_a=f(P(0))^a` on the support of Q. Prove
`(Σ_a f(Q.coeff a)f(P(0))^a z^{e-a})/y∈H` for every subring H containing
`f(R),y,z,w`. This is a commutative instance of the division-ring replacement,
not a commutativity assumption on the quantum ambient ring. Polynomial and quantum
seed instances construct all displayed identities from their exchange data;
no seed stores these local conclusions or Laurent membership as fields.

Construct the chart, polynomial mutation, Q1, Q2 and upper-bound invariance over
a commutative factorial domain R with a chosen central unit `q∈Rˣ`, in a
possibly noncommutative division R-algebra. Do not require q to have infinite
order. The ordinary quantum case is `R=Z_v`, `q=v`; the classical case is
`q=1`, retaining its integral or field coefficient subring. Define binary
mutation by the degree-one polynomial construction, and derive its faithfulness,
involutivity and local comparisons from that construction.

In the common frame, separate the matrix's positive symmetrizer d from the
integral diagonal form weights w. Require independent exchange columns and
`B̃ᵀΛ=(diag(w) 0)`, with no sign or nonvanishing hypothesis on w. Prove that
matrix and form mutation preserve these conditions, retaining w. Ordinary
quantum compatibility is the case `w=d`; derive column independence from it.
Classical full-column-rank seeds use `q=1`, `Λ=0`, `w=0` and their original d.
Construct their faithful charts over the original coefficient ring, and identify
all coordinate words and chart rings with the independently defined classical
ones. Prove independence from the choice of any unit-parameter form realization.
Derive classical local comparisons and upper-bound invariance from the same
polynomial theorem. A classical seed has no auxiliary quantization as input,
and coefficient specialization is not assumed to commute with intersections.

## Layer 1: classical and quantum seeds and mutation

**1.1 Exchange matrices.** A symmetrizer of `B : Matrix K K ℤ` is `s : K → ℤ` with
`s_i>0` and `s_i b_ij = -s_j b_ji`. An exchange matrix is `B` with a symmetrizer as
data; `μ_k` acts on `B` alone. Write `[a]_+ = max(a,0)`. For `k∈K`, define

$$
b'_{ij}=\begin{cases}-b_{ij}&i=k\text{ or }j=k,\\
b_{ij}+[b_{ik}]_+[b_{kj}]_+-[-b_{ik}]_+[-b_{kj}]_+&\text{otherwise}.\end{cases}
$$

An extended matrix is `B̃ : Matrix I K ℤ`, `I=K⊔J`, whose principal block (rows `K`) is
an exchange matrix; `μ_k` uses the same formula on all rows. Prove `μ_kμ_k=id`, that
symmetrizers of `B` symmetrize `μ_kB`, zero diagonal, and commutation of `μ_k` with the
principal block, reindexing along `K≃K'`, `J≃J'`, and `fromBlocks B₁ 0 0 B₂`. For `B̃`
with skew-symmetric principal block, `q_ik=[b_ik]_+`, `q_ki=[-b_ik]_+` (`i∈I`, `k∈K`),
`q_jj'=0` (`j,j'∈J`) is a bijection onto ice quivers `q : I → I → ℕ` with frozen
vertices `J`, `q_ii=0`, `q_ij q_ji=0` and no arrows between frozen vertices; prove it
intertwines `μ_k` with ice-quiver mutation at mutable `k` (add `q_ik q_kj` arrows `i→j`,
reverse arrows at `k`, cancel 2-cycles, delete arrows between frozen vertices).

For `b_kk=0` and `ε∈{1,-1}`, prove `μ_k(B̃)=E_ε B̃ F_ε`, where `E_ε : Matrix I I ℤ` is
the identity except in column `k`, with `(E_ε)_kk=-1`, `(E_ε)_ik=[-ε b_ik]_+` for `i≠k`,
and `F_ε : Matrix K K ℤ` is the identity except in row `k`, with `(F_ε)_kk=-1`,
`(F_ε)_kj=[ε b_kj]_+` for `j≠k`. Prove `E_ε²=1`, `F_ε²=1`, `rank_ℚ μ_k(B̃)=rank_ℚ B̃`,
and reindexing laws. The classical and quantum layers share this factorization.

**1.2 Seeds and their realizations.** Fix finite `K`, a coefficient semifield `P` and a
field `F` with `Algebra ℤ[P] F`; `P` acts on `F` through `P →* ℤ[P]ˣ`. A `Y`-seed is
`(y,B)`, `y : K → P`, `B` an exchange matrix. A seed in `F` is a `Y`-seed with a Laurent
chart `L(ℤ[P],K) → F` whose image generates `F` as a field; `x_i` is the image of `X_i`.
Construct the inverse equivalences with FZ tuples `(x,y,B)`, `x` a transcendence basis
over `ℤ[P]` generating `F` with `ℤ[P]`. Mutation `μ_k` is `B ↦ μ_kB`, `x'_i=x_i`
(`i≠k`), and

$$
x'_k=\frac{y_k\prod_i x_i^{[b_{ik}]_+}+\prod_i x_i^{[-b_{ik}]_+}}
{(y_k\oplus1)x_k},\qquad
y'_j=\begin{cases}y_k^{-1}&j=k,\\
y_jy_k^{[b_{kj}]_+}(y_k\oplus1)^{-b_{kj}}&j\ne k.\end{cases}
$$

Prove the numerator nonzero, `x'` a transcendence basis generating `F`, `μ_k`
involutive on seeds and `Y`-seeds, and that forgetting the chart commutes with `μ_k`.
Reindexing along `e : K ≃ K'` acts on `y`, `B` and the chart together; prove
`μ_{e k}(e·Σ)=e·μ_kΣ`. Seeds `Σ`, `e·Σ` with `e : Equiv.Perm K` are equivalent.

**1.3 Patterns and algebras.** For involutions `μ_k` (`k∈K`) of any type, a word
`w : List K` acts by `μ_{[k₁,…,k_m]}=μ_{k_m}∘⋯∘μ_{k₁}`; prove the concatenation law,
cancellation of adjacent equal letters, and inversion by the reversed word. This single
API serves matrices, `Y`-seeds, seeds and quantum seeds; `μ_wΣ₀` is reachable from `Σ₀`.
Reduced words, adjacent when one extends the other by a letter, form a
`SimpleGraph.IsTree` with one edge of each label at each vertex (two vertices if
`|K|=1`, one if `K` is empty). The exchange graph has the reachable seeds modulo
equivalence as vertices, distinct classes adjacent when related by one mutation. Both
graphs are comparisons; patterns are defined by words.

For a subring `R⊆ℤ[P]`, `L_{R,t}` is the range of `t`'s chart on `L(R,K)`, `A_R` the
`R`-subalgebra of `F` generated by all reachable `x_{i;t}`, and `U_R=⨅_t L_{R,t}` over
reachable `t`; `A,U,L_t` mean `R=ℤ[P]`. Cluster monomials are `∏_i x_{i;t}^{a_i}`,
`a : K → ℕ`; their multiples by `P` form a separate set. Prove these objects unchanged
under replacing `Σ₀` by a reachable or reindexed seed, and transported by `F ≃ₐ[ℤ[P]] F'`.
For `R⊆R'` construct the inclusions of `L_{R,t}`, `A_R`, `U_R`. `A_R≤U_R` is a separate
theorem for each `R`, in no definition and not deduced from the exchange coefficients
lying in `R`.

**1.4 Geometric coefficients.** For finite `J` and `P=Trop(J)`, construct inverse
bijections between `Y`-seeds `(y,B)` and extended matrices `B̃` with principal block
`B`, by `y_k=∏_j z_j^{b_jk}`, and between their seeds in `F`. Prove that they
intertwine `μ_k(y,B)` with `μ_kB̃` and give the exchange relation
`x_kx'_k=∏_{i∈I}a_i^{[b_ik]_+}+∏_{i∈I}a_i^{[-b_ik]_+}`, `a_i=x_i` (`i∈K`), `a_i=z_i`
(`i∈J`). Apply §1.3 to each `R_S` (§0.3). For `S⊆T⊆J`, prove that `A_{R_T}` is the
localization of `A_{R_S}` at the `z_t`, `t∈T\S`; no such statement for `U` is
asserted. Every comparison of `L_{R,t}`, `A_R`, `U_R` keeps `R` explicit.

For a field `𝕜` of characteristic zero, a geometric seed over `𝕜` in a field `F` is `B̃`
with a Laurent chart `L(𝕜[Trop(J)],K)→F` whose image generates `F`; mutate it by the
exchange relation above, proving the numerator nonzero (also for zero columns), the new
chart generating, and involutivity. For `S⊆J` put `𝕜_S=𝕜[z_j:j∈J][z_s⁻¹:s∈S]` and
define `L_{𝕜_S,t}`, `A_{𝕜_S}`, `U_{𝕜_S}` as in §1.3. Layers 3, 4 and 7 use these.

**Checks.** For `K` empty, `A=U=⊥`. For `K=Unit`, `B=0`: the one-element `P` gives
`xx'=2`; `P=Trop(Unit)`, `y=z` gives `xx'=1+z`. For `K=Unit`, `J=Fin 2`, `B̃` the column
`(0,1,1)`: `xx'=1+z_0z_1`.

**1.5 Compatible quantum seeds.** Take §1.1 with finite `K`, `J`. A compatible pair is
`(B̃,Λ)` with `Λ : Matrix I I ℤ` alternating and `Σ_i b_ik Λ_il=s_k δ_kl` for `k∈K`,
`l∈I` (`δ_kl=0` for `l∈J`), i.e. `B̃ᵀΛ=(D_s 0)`, where `s` is the symmetrizer carried
by the exchange matrix of `B̃` (§1.1); `μ_k`, `P_{k,r}` (Q1) and the principal pair use
this `s`. Prove that if `B̃ᵀΛ=(diag(d) 0)` with `d : K → ℤ` positive, then `d`
symmetrizes the principal block, and `rank_ℚ B̃=|K|`. For a division ring `D`
that is a `Z_v`-algebra, a quantum seed is a compatible pair with a quantum chart
`T(Z_v,v,Λ) → D` on `ℤ^I` (§0.4), and nothing else; `M(a)` is the image of `X^a`.

Set `μ_k(B̃,Λ)=(μ_kB̃,E_εᵀΛE_ε)`; prove independence from `ε`, compatibility and
involutivity. Set `X'_k=M(-e_k+[b_{•k}]_+)+M(-e_k+[-b_{•k}]_+)` (`b_{•k}` the column
`k` of `B̃`, entrywise) and `X'_i=M(e_i)` for `i≠k`. Prove `X'_iX'_j=v^{2Λ'_ij}X'_jX'_i`,
`Z_v`-linear independence of their normalized monomials, and that the division subring
generated by the image of `Z_v` and the `M(e_i)` equals that generated by the image of
`Z_v` and the `X'_i`; construct the chart of `μ_kΣ` on `T(Z_v,v,Λ')` and
prove `μ_kμ_kΣ=Σ`. Construct the bijection between quantum charts and BZ toric frames
`M : ℤ^I → D`, `M(a)M(b)=v^{Λ(a,b)}M(a+b)`, with `Z_v`-independent values.
Words, cancellation and re-rooting use §1.3.
Construct the ring isomorphism `T(Z_v,v,Λ)≃T(Z_v,v,-Λ)` semilinear along `v↦v⁻¹` and
`T(Z_v,v,Λ)ᵐᵒᵖ≃ₐ[Z_v]T(Z_v,v,-Λ)`, both fixing each `X^a`, with `(Λ,B̃)↦(-Λ,-B̃)`.
Prove that each preserves compatibility with the same `s`, commutes with mutation of
pairs and seeds, and interchanges the two summands of `X'_k`. The transported seeds
live in `D` with its `Z_v`-structure twisted by `v↦v⁻¹`, respectively in `Dᵐᵒᵖ`.

For an exchange matrix `B` with symmetrizer `s`, construct the principal pair on `K⊔K`:
`B̃_pr=(B;Id)`, `Λ_pr=((0,-D_s),(D_s,BᵀD_s))`. Prove `Λ_pr` alternating and
`B̃_prᵀΛ_pr=(D_s 0)`, with no other hypothesis on `B`; check `B=0` on `Fin 2` and
`K` empty. L5 uses this pair.

**1.6 Quantum algebras and realization interfaces.** Fix a quantum seed in `D`, with
reachable mutable variables `X_{k;t}` and frozen `X_j=M(e_j)`. For `S⊆J`, `A_{v,S}` is the
`Z_v`-subalgebra of `D` generated by all `X_{k;t}`, all `X_j` and `X_s⁻¹` (`s∈S`); `T_t`
is the range of `t`'s chart and `U_v=⨅_t T_t`. Frozen variables need not be central; no
definition contains a Laurent property. Quantum cluster monomials are `M_t(a)`, the image
of `X^a` under `t`'s chart, with `a_k≥0` (`k∈K`), `a_j≥0` (`j∈J∖S`). Prove these objects
invariant under re-rooting and reindexing, and transport them along `Z_v`-algebra
isomorphisms `D≃D'`.

A polynomial seed realization in a `Z_v`-algebra `A` is an injective `Z_v`-algebra map
to `A` from the quantum polynomial subalgebra of `T(Z_v,v,Λ)` (§0.4), equivalently
`Y : I → A` with `Y_iY_j=v^{2Λ_ij}Y_jY_i` and `Z_v`-independent normalized monomials
`Y^a`, `a∈ℕ^I`. Prove generator extensionality and transport along injective maps
`A→A'`; no category is used. For injective `ι : A → D` into a division ring, construct
the induced quantum chart; a mutation at `k` in `A` is `Y'_k∈A` with `ι(Y'_k)=X'_k`,
which the mutated seed in `D` does not provide. If `ι(A)` contains every `X_{k;t}` of
the induced seed (all reachable `t`), construct the injective `A_{v,∅}→A` inverting
`ι`; membership of the one-step variables `X'_k` alone is not assumed to imply this.

## Layer 2: shared Laurent proof and classical specialization

There are two public statements, with one proof chain. For a compatible quantum
seed, every reachable variable lies in every integral quantum chart `T_t`.
For a classical seed over an arbitrary coefficient semifield P, every reachable
variable lies in every `L_{ℤ[P],t}`, with no full-rank or coprimality premise on
that seed. Both use the common polynomial theorem of §0.7: ordinary quantum
seeds have `R=Z_v`, `q=v`, `w=d`, while full-rank classical seeds have `q=1`,
`Λ=0`, `w=0`. The classical statement for arbitrary P uses a principal lift and
normalized coefficient specialization. The `v=1` theorem separately compares
the quantum and classical representatives. Neither statement uses positivity
of Laurent coefficients, sign-coherence or the classical structural results of Layer 4.

| Milestone | Output | Uses |
|---|---|---|
| Q1 | Integral one-exchange normal forms and divisibility | §0.5, §1.5 |
| Q2 | Two-direction intersections and replacement | Q1, §§0.6–0.7, compatibility |
| Q3 | Common upper-bound invariance and Laurent expansions, including quantum seeds | Q2, shared intersection/word API |
| L5 | Classical principal Laurentness at unit parameter; quantum comparison via `v=1` | Common Q3, principal full-rank seed; quantum Q3 for comparison |
| L6 | Frozen orders, polynomial expansions and principal degrees | L5, support/positive evaluation |
| L7 | Normalized specialization and separation | Seed identities, L5–L6 |
| L8 | Arbitrary-semifield Laurentness and expansion maps | L7 |
| Q4 | Bar, gradings, frozen localization and algebra realizations | Q1–Q3, §1.6 |

### 2.1 Quantum upper bounds and integral expansions

**Q1 — one exchange.** For a seed `s` and mutable `k`, let C be the integral torus of
the coordinates other than `X_k`. Then `X_k` and `E=X'_k X_k∈C` satisfy §0.5's
hypotheses, so `T_s∩T_{μ_k(s)}=C⟨X_k,X'_k⟩` with unique normal forms over `Z_v`. With
`P_{k,r}=∏_{h=1}^r(1+v^{(2h-1)s_k}M(b_{•k}))` (`s_k` from the pair's symmetrizer, §1.5),
prove `(X'_k)^r=P_{k,r}M(-e_k+[-b_{•k}]_+)^r` and `P_r=P_{k,r}M(-e_k+[-b_{•k}]_+)^rX_k^r`
for §0.5's `P_r`. Let `C'` be the subring generated by `Z_v` and any set of coordinates
other than `X_k` containing every coordinate in the support of `b_{•k}`, with their
inverses; then the factors of `P_{k,r}` lie in `C'` and are central there (not in
`T_s`), and the second criterion holds over `C'`: for `c_m∈C'`, `Σ_m c_mX_k^m` lies in
`C'⟨X_k^{±1}⟩∩C'⟨X'^{±1}_k⟩` if and only if `c_{-r}∈C'·P_{k,r}` for all `r>0`.

**Q2 — two-direction comparisons.** For distinct mutable `i,j`, let C be the integral
torus of the other coordinates, `H_ij=C⟨X_i,X'_i,X_j,X'_j⟩`, and `X''_j` the
`j`-coordinate of `μ_jμ_i(s)`. Prove
`(T_s∩T_{μ_i(s)})∩(T_s∩T_{μ_j(s)})=H_ij=C⟨X_i,X'_i,X_j,X''_j⟩`, and `X''_j=X'_j` when
`b_ij=0`. The first equality uses §0.6 and Q1's second criterion over the coordinates
other than `X_i,X_j` when `b_ij=0`, and
§0.5's patching and unit constant terms otherwise. For `b_ij≠0` of either sign, prove
at `s` and at `μ_i(s)` the singleton instance of §0.7's replacement with `x=X_i`, `x*=X'_i`,
`z=X_j`, `z*=X'_j`, `z**=X''_j` and `r=|b_ij|`, in which `n₁` is the summand of
`X'_jX_j` without `X_i`, `m₂` the summand of `X''_jX_j` without `X'_i`, and `g₀` the
`X_j`-free term of `(X'_i)^rX_i^r`; its premise is an identity of exponents (from §1.1)
and of powers of `v` (from compatibility). These are finite algebraic identities,
independent of any global Laurent theorem; no commutation of noncommutative
localizations with intersections is used.

**Q3 — upper-bound invariance and Laurentness.** First prove the order-theoretic
core: for a complete lattice A, any index type K, involutions on a state type V
and `L:V→A`, put `UB(s)=L_s∧⋀_k L_{μ_k(s)}`. Local inclusions
`L_s∧L_{μ_i(s)}∧L_{μ_j(s)}≤L_{μ_jμ_i(s)}` for distinct i,j imply invariance of
UB, and invariance implies `UB(s)=⋀_{w:List K}L_{μ_w(s)}`. This needs no finite
rank or ring structure. Instantiate the theorem with the lattice of subrings.
An involutive mutation pattern of
subrings of a ring `D` is a type of seeds with involutions `μ_k` (`k∈K`, §1.3) and, for
each seed `s`, a subring `T_s⊆D` and generators `g_{s,k}∈T_s` (`k∈K`); put
`UB(s)=T_s∩⋂_{k∈K}T_{μ_k(s)}`. Prove that the three-chart equalities
`T_s∩T_{μ_i(s)}∩T_{μ_j(s)}=T_{μ_i(s)}∩T_s∩T_{μ_jμ_i(s)}` for all reachable `s` and
distinct `i,j` make `UB` constant on reachable seeds, and that if moreover
`g_{μ_k(s),i}∈T_s` for all reachable `s` and all `i,k`, then every `g_{t,i}` lies in
every `T_s` and `UB(s)=⋂_tT_t`. For compatible quantum seeds take `g_{s,k}=X_{k;s}` and
`UB_v(s)=T_s∩⋂_kT_{μ_k(s)}`; Q1–Q2 give the equalities, and `X'_k∈T_s` by definition.
Obtain `A_{v,S}⊆U_v=UB_v(s)` for every `S` and the unique finite expansion of each
variable in each chart, with coefficients in `Z_v` and evaluation, re-rooting,
reindexing and ambient transport laws. No theorem that specialization commutes with
intersections is used.

**Checks.** Test Q1 on `Λ=((0,-1),(1,0))`, `B̃=(0,1)ᵀ`: the exchange relation
is `X_1 X'_1=1+v⁻¹X_2` and `X'_1 X_1=1+vX_2`, both specializing to `1+x_2`, and
`(X'_1)²=(1+vX_2)(1+v³X_2)X_1^{-2}`. For §1.5's principal pair of `B=0` on `Fin 2`
with symmetrizer `(1,1)` (frozen `X_3,X_4`), `X''_2=X'_2` and `H_12` contains `X'_1X'_2` but not
`X_1⁻¹X_2⁻¹(1+v⁻¹X_3)`. For the principal pairs of `B=±((0,b),(-c,0))`,
`(b,c)=(1,1),(1,2),(2,1),(1,3),(3,1)`, verify Q2's replacement premise and
`X''_2∈C⟨X_1,X'_1,X_2,X'_2⟩`. For `K` empty and `J=Fin 1`, `A_{v,∅}=Z_v[X_1]` and
`A_{v,J}=U_v=Z_v[X_1^{±1}]`.
Source: BZ, §5, Lemmas 5.4–5.6, Proposition 5.7, Lemma 5.8 and Corollary 5.2.

### 2.2 Classical limit, principal coefficients and frozen orders

**L5 — classical principal Laurentness and quantum comparison.** Apply the common
polynomial Q3 theorem directly to §1.4's full-column-rank principal geometric seed
using §0.7's unit-parameter zero-form construction over ℤ. Identify every coordinate
word and chart, obtaining integral principal Laurentness without an auxiliary
quantization or a quantum-specialization theorem. Derive the arbitrary-semifield
statement through L7–L8 from this direct instance.

Separately, for a finite free lattice `L` and an integral alternating form `Λ`, construct `sp:T(Z_v,v,Λ)→ℤ[L]` as §0.4's coefficient change along
`Z_v→ℤ`, `v↦1`, followed by §0.4's identification `T(ℤ,1,Λ)≃ℤ[L]`. Prove
`sp(cX^a)=c(1)X^a`, surjectivity and `ker sp=(v-1)T(Z_v,v,Λ)`. For a commutative ring `R`
construct the regrouping `L(R,K⊔J)≃ₐ[R]L(L(R,J),K)`. Let `s` be a compatible quantum
seed with extended matrix `B̃`, `F` a field and `ε:ℤ[ℤ^I]→F` a ring map, and consider a
classical geometric pattern in `F` with initial extended matrix `B̃` and initial
coordinates `x_i=ε(X_i)` (`i∈K`), `z_j=ε(X_j)` (`j∈J`), obtained along words by §1.4's
exchange relation with every exchanged coordinate nonzero. For every reachable `t` and
mutable `j`, prove `ε(sp f)=x_{j;t}`, where `f∈T(Z_v,v,Λ)` is the element that `s`'s
chart sends to `X_{j;t}` (Q3). For algebraically independent `ε(X_i)` the nonvanishing
holds (§1.4). The proof uses neither classical Laurentness nor an extension of `sp` to
the skew field.

For every exchange matrix `B₀` on `K`, compare §1.5's principal quantum pair with
the zero-form principal geometric seed, taking `ε` to be the inclusion of
`ℤ[ℤ^{K⊔K}]` in its fraction field and writing frozen variables as `u_i` (`i∈K`).
The comparison identifies the specialized quantum representative with the
independently constructed classical representative. By regrouping each principal
variable has a unique expansion
`X_{j;t}(x,u)∈ℤ[u_i^{±1}][x_i^{±1}]`. Prove that §1.4's transport identifies this
geometric pattern with the normalized pattern over `Trop(K)` with initial coefficients
`u`. Define `C_t` as the frozen block of the mutated principal matrix `B̃_t`, and the
`c`-vector `c_{j;t}` as its `j`th column. L5–L8 use no sign-coherence, no invertibility
of `C_t` and no constant-term property of `F`-polynomials.

For `S⊆J`, restrict `sp` to a surjective ring map `A_{v,S}→A_{R_S}` onto the classical
geometric algebra with the same `B̃` and inverted frozen set `S`, sending each reachable
quantum variable to the classical variable with the same word and label and `X_j` to `z_j`
(`j∈J`); construct the induced map `A_{v,S}/(v-1)A_{v,S}→A_{R_S}`. Its injectivity, the
equality `A_{v,S}∩(v-1)T_s=(v-1)A_{v,S}` and a specialization isomorphism for `U_v` are
not targets and are not used for Laurentness; GLS treats special fibers under additional
hypotheses.

**L6a — order and subtraction-free expressions.** For a finite type `ι`, use §0.1's
semifield `Qsf(ι)` and its evaluations. For a domain `R`, a finite type `ι` and `f∈ι`, let
`lo_f` be §0.6's least degree on nonzero elements of `L(R,ι)` for the weight `e_f^*`.
Define `ord_f(A/B)=lo_f(A)-lo_f(B)` on nonzero elements of its fraction field; prove
independence of the presentation, `ord_f(gh)=ord_f g+ord_f h`, `ord_f(g⁻¹)=-ord_f g` and
`ord_f=lo_f` on `L(R,ι)`. For nonzero `A,B∈Qsf(ι)`, in the same field by §0.2, prove
`ord_f(A+B)=min(ord_f A,ord_f B)`.

For every integral geometric pattern in `F` (§1.4, coefficient group `Trop(J)` over `ℤ`), identify `F` with
`FractionRing (MvPolynomial (K⊔J) ℤ)` by the isomorphism of §0.2 (with L5's regrouping)
sending the variables to the initial `x_i` and `z_j`, and represent each `x_{j;t}` by the
element of `Qsf(K⊔J)` obtained by applying the exchange formula along its word, and prove
`ord_f(x_{j;t})=0` for every `f∈J`, reachable `t` and `j∈K`, without assuming Laurentness.
Prove that the regrouping identifies `L(MvPolynomial J R,K)` with the elements of
`L(R,K⊔J)` whose support has nonnegative `J`-coordinates; hence a variable whose initial
expansion is Laurent lies in `ℤ[z_j][x_i^{±1}]`. This polynomiality statement takes
Laurentness as a hypothesis, supplied by L5 for principal patterns (L6b) and by L8 for all
geometric ones.

**L6b — principal polynomials and degrees.** Prove `X_{j;t}∈ℤ[u_i][x_i^{±1}]`. Define
`F_{j;t}∈ℤ[u_i]` as the image of `X_{j;t}` under the algebra map `x_i↦1`, and
`F^+_{j;t}∈Qsf(K)` as the semifield evaluation at `x_i↦1` of the representative of
`X_{j;t}` in `Qsf(K⊔K)`. Prove that `F^+_{j;t}` maps to `F_{j;t}`, so `F_{j;t}≠0`;
semifield evaluations `F_{j;t}|_P` are those of `F^+_{j;t}` and presuppose no
nonnegativity of coefficients. Prove `F_{j;0}=1` and, for `t'=μ_k(t)` with entrywise
positive parts,

$$
F_{k;t'}F_{k;t}
=u^{[c_{k;t}]_+}\prod_i F_{i;t}^{[b_{ik;t}]_+}
+u^{[-c_{k;t}]_+}\prod_i F_{i;t}^{[-b_{ik;t}]_+},
\qquad F_{j;t'}=F_{j;t}\ (j\ne k).
$$

Deduce that `F_{k;t}` divides the right side in `ℤ[u_i]`; divisibility is not a premise of
the construction of `F`. Grade `ℤ[u_i^{±1}][x_i^{±1}]` by `ℤ^K` with `deg x_i=e_i`,
`deg u_j=-B₀e_j`. Define `G_t` by `G₀=Id` and, for `t'=μ_k(t)`,
`g'_k=-g_k+G_t[b_{•k;t}]_+-B₀[c_{k;t}]_+`, other columns unchanged, where `b_{•k;t}` is
the `k`th column of the mutable block `B_t`. Prove `G_tB_t=B₀C_t`, that `X_{j;t}` is
homogeneous of degree the `j`th column `g_{j;t}` of `G_t` (its `g`-vector), and
`X_{j;t}(x,u)=x^{g_{j;t}}F_{j;t}(û)` with `û_j=u_j∏_i x_i^{(B₀)_ij}`. These grading
results consume L5–L6a and are not inputs to the `X`-form of L7b's separation theorem or
to L8.

### 2.3 Normalized specialization and the general Laurent theorem

**L7a — domains of evaluation.** For a coefficient semifield `P` and finite `K`, construct
`Pos(P,K)`, the ratios `a/b` of nonzero `a,b∈ℕ[P][x_i:i∈K]` in `FractionRing L(ℤ[P],K)`,
as a coefficient semifield with `⊕=+`; prove closure and nonvanishing. It contains the
images of `P` and all monomials `x^a`, `a∈ℤ^K`; transport it along Laurent charts into
`F`. For a field `F` and a coefficient semifield `𝒮⊆Fˣ` with `⊕=+`, define
subtraction-free evaluation of `Qsf(ι)` at `a:ι→𝒮` followed by inclusion into `F`,
distinct from semifield evaluation into `P`. For `y:K→P` construct the group homomorphism
`Multiplicative (K→₀ℤ)→P`, `u_i↦y_i`, and the ring map `ℤ[u_i^{±1}]→ℤ[P]`; neither is a
semifield map from `Trop(K)`.

Prove *positive_rational_laurent_specialization*: if `φ∈Qsf(ι)` lies in `L(ℤ,ι)`, then
for every `a:ι→𝒮` the Laurent evaluation of `φ` at `a` equals its subtraction-free
evaluation and is nonzero. Injectivity of the substitution and a ring map from the
rational-function field are not assumed. The case `𝒮=Pos(P,K)`, `a_i=y_i` gives
substitution `u_i↦y_i`; L6b's comparison is the case `𝒮=Qsf(K)`.

**L7b — the normalization identity.** Fix `B₀` on `K`; let `Y_{j;t}∈Qsf(K)` be the
`Y`-pattern with initial coefficients `u`. Prove that for every `P` and `y:K→P`,
`Y_{j;t}|_P(y)` is the `Y`-pattern of `(y,B₀)` in `P`. For a seed pattern in `F` with
initial `(x,y,B₀)` put `ŷ_{j;t}=y_{j;t}∏_i x_{i;t}^{b_{ij;t}}`; prove, from seed
identities only, that `ŷ` obeys §1.2's `Y`-mutation with `⊕` replaced by `+`, and that
`ŷ_{j;t}` is the evaluation of `Y_{j;t}` at `(ŷ_{i;0})_i` in `Pos(P,K)`.

Let `h_{k;t}∈ℤ^K` be the exponent vector of `(1⊕Y_{k;t})|_{Trop(K)}(u)∈Trop(K)`. With
`û_j=u_j∏_i x_i^{(B₀)_ij}`, prove in `Qsf(K⊔K)` and `Qsf(K)`, for the subtraction-free
representatives of `X` and `F`:

$$
X_{k;t'}X_{k;t}=
\frac{1+Y_{k;t}(\widehat u)}{u^{h_{k;t}}}
\prod_i X_{i;t}^{[-b_{ik;t}]_+},\qquad
F_{k;t'}F_{k;t}=
\frac{1+Y_{k;t}(u)}{u^{h_{k;t}}}
\prod_i F_{i;t}^{[-b_{ik;t}]_+}.
$$

For a seed pattern in `F` over any `P` with initial `(x,y,B₀)`, let `N_{j;t}∈F` be the
Laurent evaluation of `X_{j;t}` at `x_i↦x_i`, `u_i↦y_i`, and `D_{j;t}=F_{j;t}|_P(y)∈P`.
Prove the separation theorem `x_{j;t}=N_{j;t}/D_{j;t}` for every reachable `t` and `j∈K`,
without a Laurent theorem for this pattern, positivity of `F_{j;t}` or signs of
`c`-vectors. With L6b's grading identity, prove

$$
x_{j;t}=x^{g_{j;t}}\,
\frac{F_{j;t}|_F(\widehat y_1,\ldots,\widehat y_n)}
{F_{j;t}|_P(y_1,\ldots,y_n)}.
$$

**L8 — public theorem and its maps.** For every coefficient semifield `P` and seed `s` in
`F` over `ℤ[P]`, prove `x_{j;t}∈L_{ℤ[P],s}` for every reachable `t` and `j∈K`, from L5
and L7b. The expansion is §0.3's *exp*; prove that `exp_s(x_{j;t})` is `D_{j;t}⁻¹` times
the image of `X_{j;t}` under `u_i↦y_i`. Prove `x_{j;u}∈L_{ℤ[P],t}` for all reachable
`t,u`, hence `A⊆U`, and construct for each reachable `t` the injective algebra map
`A→ₐ[ℤ[P]]L(ℤ[P],K)` restricting `exp_t`, with coefficient extraction and finite support.
Prove that evaluation after expansion is the inclusion into `F`, and commutation with
reindexing, re-rooting and isomorphisms of ambient realizations.
For a coefficient-semifield homomorphism `φ:P→Q` and seeds `s` over `P` and `s_Q` over
`Q` with the same `B₀` and initial coefficients `φ∘y`, construct the ring homomorphism
`A_P→A_Q` restricting the composite of `exp_s`, the coefficient map `L(ℤ[φ],K)` and the
chart of `s_Q`. Prove that it sends each `x_{j;t}` to the corresponding variable of `s_Q`,
identity and composition laws, commutation with expansion in every reachable chart, and
independence of the chart used to construct it.

For geometric type, L8 and L6a give `exp_t(x_{j;u})∈ℤ[z_j][x_i^{±1}]` for reachable
`t,u`, hence `A_{R_S}⊆U_{R_S}` for every `S⊆J` (§0.3). For a characteristic-zero field
`𝕜`, prove that the expansions of the variables of the geometric pattern over `𝕜` (§1.4)
with the same `B̃` are the images of these integral expansions under `ℤ→𝕜`; hence they
lie in `𝕜[z_j][x_i^{±1}]` and in each `𝕜_S[x_i^{±1}]`, so `A_{𝕜_S}⊆U_{𝕜_S}`. Base
change of `U` is not identified with `U_{𝕜_J}`.

**Acceptance checks.** For L8 use the rank-two zero matrix, whose coefficient-free
exchange polynomials are both `2`, and `P=Multiplicative ℚ` (elements `w^a`, `a∈ℚ`, with
`w^a⊕w^b=w^{min(a,b)}`), a divisible, non-free group distinct from `Trop(J)`: for
`y=(w^{1/2},w^{-1/3})` the four clusters are `{x_1,x_2}`, `{x'_1,x_2}`, `{x_1,x'_2}`,
`{x'_1,x'_2}` with `x'_1=(1+w^{1/2})x_1⁻¹` and `x'_2=(1+w^{1/3})x_2⁻¹`. Rank zero
gives `A=U=ℤ[P]`; rank one gives `xx'=2` coefficient-free and `xx'=1+u` with
principal coefficients. For coefficient-free `A₂`, recover exactly
`x₁,x₂,(1+x₂)/x₁,(1+x₁+x₂)/(x₁x₂),(1+x₁)/x₂`. Normalization and separation: FZ IV, §3, §6.

### 2.4 Somos-4 as a consumer of the Laurent theorem

Define `a:ℕ→ℚ` by `a₀=a₁=a₂=a₃=1` and `a_{n+4}=(a_{n+1}a_{n+3}+a_{n+2}²)/a_n`; prove
`0<a_n` for all `n`. Take the coefficient-free seed (one-element `P`) in
`FractionRing (MvPolynomial (Fin 4) ℤ)` with its variables as chart, symmetrizer `d_i=1`
and initial exchange matrix, in the column convention,

```text
 0  -1   2  -1
 1   0  -3   2
-2   3   0  -1
 1  -2   1   0
```

Mutate successively at `k_n=n mod 4`. Prove that after `n` mutations the `(i,j)` entry is
the initial `(i-n,j-n)` entry, indices modulo 4; that column `k_n` has `-2` at `k_{n+2}`,
`1` at `k_{n+1}` and `k_{n+3}`, and `0` at `k_n`; and that the `n`th exchange relation is
`x_{k_n}x'_{k_n}=x_{k_{n+1}}x_{k_{n+3}}+x_{k_{n+2}}²`. Prove that after `n` mutations the
L6a representative in `Qsf(Fin 4)` of the variable at `k_{n+r}` (`0≤r<4`) evaluates to
`a_{n+r}` at `x_i=1` in the semifield `{q∈ℚ:q>0}`.

With L8 and *positive_rational_laurent_specialization* (`𝒮={q∈ℚ:q>0}`), prove that `a_n`
is the image of the L8 expansion under `L(ℤ,Fin 4)→ℤ`, `x_i↦1`; deduce `a_n∈ℤ` and
`0<a_n`. Prove that every `b:ℕ→ℚ` with `b₀=b₁=b₂=b₃=1` and
`b_{n+4}b_n=b_{n+1}b_{n+3}+b_{n+2}²` equals `a`, so each `b_n` is a positive integer.

Check `a₀,…,a₈=1,1,1,1,2,3,7,23,59`. Verify that the transitive proof dependencies of
the integrality theorem include L8, L5 and, through L5, Q3's upper-bound invariance.

### 2.5 Quantum structure and algebraic consumers

**Q4 — bar, grading and frozen localization.** On each `T(Z_v,v,Λ)`, and on each `T_t`
through its chart, define bar: the `ℤ`-linear anti-automorphism with `bar(v)=v⁻¹`,
`bar(X^a)=X^a`, `bar(fg)=bar(g)bar(f)`; prove it is an involution. Prove that the bars of
`T_s` and `T_{μ_k(s)}` agree on `T_s∩T_{μ_k(s)}` (Q1), hence give one bar on `U_v`
preserving each `A_{v,S}`, and that normalized cluster monomials are bar invariant.

For an additive commutative group `H`, an `H`-grading of a compatible seed is an additive
`deg:ℤ^I→H` with `deg(b_{•k})=0` for mutable `k`; it grades `T_s` with `deg(v)=0`. Put
`deg'(e_k)=-deg(e_k)+Σ_i[b_ik]_+deg(e_i)`, `deg'(e_i)=deg(e_i)` for `i≠k`; prove that
`deg'` is an `H`-grading of `μ_k(s)`, that `X'_k` is homogeneous of degree `deg'(e_k)`,
and that every reachable cluster variable is homogeneous. One degree-mutation lemma on
extended matrices serves this grading and L6b's classical grading.

Prove that each frozen `X_j` quasi-commutes with every reachable variable,
`X_jX_{i;t}=v^{2(Λ_t)_{ji}}X_{i;t}X_j`. For `S⊆J`, prove that the submonoid of `A_{v,∅}`
generated by the `X_s`, `s∈S`, is a left and right Ore set, and construct an isomorphism
of its `OreLocalization` with `A_{v,S}` over `A_{v,∅}`, compatible with `A_{v,S}⊆A_{v,S'}`
for `S⊆S'`. This does not make frozen-variable substitutions into quantum seed maps.

For a polynomial seed realization `ι` (§1.6) in a `Z_v`-algebra `A`, construct the images
of normalized monomials and coefficient extraction on the image of `ι`; prove that `ι` is
graded when `A` is `H`-graded with each `ι(X_i)` of degree `deg(e_i)`, and intertwines bar
with any `v↦v⁻¹`-semilinear anti-involution of `A` fixing each `ι(X_i)`.
For a skew-symmetric mutable block and `s_k=d` for all `k`, construct the KKKO adapter
`L=Λ`, `B̃_KKKO=-B̃`, `q^{1/2}=v`, carrying `B̃ᵀΛ=(d Id 0)` to KKKO's
`L B̃_KKKO=(d Id;0)`.
Prove that it swaps the two summands of `X'_k`, commutes with matrix and form mutation,
and induces a transport along mutation words; its sign changes reuse §1.5's
coefficient/form/matrix and opposite-algebra comparisons. These sign, ordering and
half-power transports are definitions and lemmas.

Checks: for the rank-one principal seed `Λ=((0,-1),(1,0))`, `B̃=(0,1)ᵀ` of §2.1, the
adapter gives `d=1`, `ΛB̃_KKKO=(1,0)ᵀ`, and exchanges the summands `M(-e_1+e_2)` and
`M(-e_1)` of `X'_1`. For `K` empty and `J=Fin 1`, `Y_1=t` is a polynomial seed
realization in `A=Z_v[t]` inducing `A_{v,∅}≃A`, and `t` is not a unit of `A`.
Categorification enters only through this algebraic API; no categorical
existence or mutation theorem is assumed or requested. Sources: BZ §§3–6; KKKO
§§5.1–5.2.


### 2.6 Polynomial quantum exchanges

Use §0.7's common scalar-ring construction, with independent columns and
separate form weights, as the proof owner for P1–P3 and Q1–Q3. The statements
below describe its ordinary quantum sector `R=Z_v`, `q=v`, `w=d`. Obtain
binary mutation and its Laurent theorem as degree-one instances; no binary
Laurent theorem is an input to the polynomial proof. The same construction
at `q=1`, `Λ=0`, `w=0` gives the classical polynomial sector directly.
Reuse the based torus, charts, normalizers, §§0.5–0.7 and the seed-free
Q3 pattern theorem. Fix degrees `r_k>0` such that `r_k` divides
every entry of column k of B̃, and put `β_k=b_{•k}/r_k`. The degree is distinct
from the compatible pair's positive symmetrizer `s_k`. Fix polynomials
`H_k(T)=Σ_{l=0}^{r_k}h_{k,l}T^l` over `Z_v` with
`h_{k,0}=h_{k,r_k}=1`. These coefficients are central;
they need not be positive or fixed by `v↦v⁻¹`.

**P1 — seeds and mutation.** A polynomial quantum seed is this degree and
coefficient data together with a compatible pair and a faithful quantum chart.
The matrix and form mutations are §1.1 and §1.5. Degrees stay fixed,
`H_k` changes to `T^{r_k}H_k(T^{-1})` in direction k, and the other polynomials
stay fixed. Reciprocal polynomials give the fixed-polynomial specialization.
The changed coordinate is

$$
X'_k=\sum_{l=0}^{r_k}h_{k,l}
 M(-e_k+l[\beta_k]_++(r_k-l)[-\beta_k]_+).
$$

Prove column divisibility preserved by mutation, `r_k∣s_k`, nonvanishing,
quasi-commutation, faithfulness of the new chart, equality of generated division
subrings and involutivity. The proof of faithfulness uses §0.5's one-exchange
linear independence; no independence at the new seed is an input. Construct
the degree-one comparison `r_k=1`, `H_k=1+T` with ordinary seeds, commuting with
mutation, whole words, charts, expansions and generated algebras. Reuse the
ordinary matrix/form and word APIs rather than introduce parallel carriers.

**P2 — local comparisons.** Construct the exchange data of §0.5 for each k.
With `ν_k=s_k/r_k`, prove that its central factors, up to the computed monomial
units, are `∏_{a=1}^n H_k(v^{(2a-1)ν_k}M(β_k))`. Give both order conventions
and their coefficient criteria. In a pair of noninteracting directions prove
the two-direction intersection using the relative primality of the required
central factors. Reuse §0.6's support theorem for polynomials on independent
directions with a unit coefficient and its central-divisibility theorem;
construct the coefficient-one and support statements for these factors.

For interacting i,j set `x=X_i`, `x*=X'_i`, `z=X_j`, `z*=X'_j`,
`z**=X''_j` and `N=|b_ij|`. Index the summands of the j-exchange by l.
Let `n_l` be the i-coordinate of its exponent after adding `e_j`; the
corresponding mutated exponent has i-coordinate `N-n_l`. Write the summands
of `z* · z` as `x^{n_l}c_l` and those of `z** · z` as `(x*)^{N-n_l}d_l` by multiplying
on the left by the inverse indicated power. Separate the unique term with
`n_l=0`: its original coefficient is n₀ and its mutated term is `(x*)^N m₀`.
The remaining indices form §0.7's A. Put `φ=m₀n₀⁻¹∈C`, where C is the torus
of the other coordinates; n₀ is a monomial unit because the endpoint coefficient is 1.
Define `g_l` as the constant coefficient in z of `(x*)^{n_l}x^{n_l}`.
Prove the defects lie in `zC[z]` and the exact ordered identity
`d_l=g_l x^{-n_l}φx^{n_l}c_l`, from matrix mutation and compatibility.
For the negative interaction, pass to the opposite algebra, negating B̃ and Λ
and reversing the coefficient lists. Prove this transport commutes with mutation.
Apply §0.7 at the seed and its mutation to get the
four-generator replacement equality. These premises are constructed, not
assumed as a surrogate for the replacement theorem.

**P3 — upper bounds and Laurentness.** State and prove relative primality in
exactly the central Laurent ring used by P2. For distinct noninteracting i,j,
the divided columns are independent and central in the pair lattice. For every
`n,m>0`, represent the two central products from P2 by scalar polynomials in
these two directions, each with constant coefficient one. Use §0.6's support
criterion to prove
[`IsRelPrime`](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Algebra/Divisibility/Units.html#IsRelPrime)
and its central-divisibility theorem to reconstruct the four-generator
intersection. Do not replace this construction by a coprimality field on the
seed. For more general central scalar factors, retain the theorem with an
explicit `IsRelPrime` hypothesis as a reusable sufficient condition.

Prove upper-bound invariance, `U_v=UB_v(s)`, finite integral Laurent expansions,
and `A_{v,S}⊆U_v` for every inverted frozen subset S, from the specified seed data.
The chart rings in `U_v` invert all frozen variables; `A_{v,S}` only inverts S.
This claim concerns scalar polynomials over `Z_v` with endpoint coefficients one.
It does not assert automatic coprimality for arbitrary multivariate coefficients
or for rings where the other frozen monomials are not units.
The ordinary theorem is the degree-one instance, with its existing hypotheses.

Construct `v=1` on these finite representatives and the induced surjection
onto the corresponding commutative geometric cluster algebra, with coefficients
`h_{k,l}(1)`. Construct its seed mutation from the same polynomial formula and
prove that the representatives specialize along every word. Prove preservation
of algebraic independence for the independent classical exchange construction,
so nonvanishing of its denominators is a theorem for genuine classical seeds.
The specialization acts on integral Laurent representatives, not on the ambient
division ring. For a principal
construction of degrees r, use frozen block `diag(r_k)`, not `Id`: for a
symmetrizer s divisible by r put `D=diag(s_k)`, `R=diag(r_k)`, `V=R⁻¹D` and
`Λ=((0,-V),(V,R⁻¹BᵀV))`. Prove integrality, alternation and compatibility;
the divisions here are exact integer divisions, not rational matrix entries.

**Checks.** In the faithful generic torus `M(a,b)M(c,d)=v^{ad-bc}M(a+c,b+d)`,
take `B=((0,2),(-2,0))`, `r=(2,2)`, `s=(2,2)` and `H_1=H_2=1+T+T²`.
Put `x=M(1,0)`, `y=M(0,1)`,
`x*=M(-1,0)+M(-1,1)+M(-1,2)`,
`y*=M(0,-1)+M(1,-1)+M(2,-1)`, and
`y**=(1+v⁻¹x*+v⁻²(x*)²)y⁻¹`. Verify the seed formula for all three,
`xy≠yx`, the finite replacement premises and `y**∈Z_v⟨x*,y*,y⟩`.
Check the generic-coefficient variants `1+aT+T²`, `1+bT+T²`, the two signs
of B, and the degree-one specialization against Q2. Check rank zero and one
separately. Add a nonreciprocal cubic, for example `1+2T+T³`, and check that
mutation reverses its coefficients and mutation twice restores the seed. Its
all-word Laurent and classical specialization statements must use the public
theorems. A fixed nonreciprocal polynomial rule must fail the corresponding
negative control. Compare every central coefficient and monomial under `v=1`.

Sources: Bai–Chen–Ding–Xu, *Generalized quantum cluster algebras: the Laurent
phenomenon and upper bounds*, §2, Lemma 4.1, Propositions 4.2, 4.6–4.7 and
Theorem 4.9, for the reciprocal fixed-polynomial model. Nakanishi–Rupel,
[Companion cluster algebras to a generalized cluster algebra](https://arxiv.org/html/1504.06758),
§3, for reversal mutation without reciprocity in the classical theory. Rupel,
[Rank two non-commutative Laurent phenomenon and pseudo-positivity](https://www.numdam.org/item/10.5802/alco.81.pdf),
§5, Theorem 5.1 (pp. 1266–1267), treats nonreciprocal quantum exchange in rank two.
The nonreciprocal quantum construction and its local comparisons are targets
here, not claims attributed to BCDX. Their Theorem 3.1 proves Laurentness by
another argument; it does not supply the central-factor proof required here.
Their polynomial-center coprimality condition and the pair Laurent-ring
condition used here must be distinguished.

## Layer 3: lattice formalism and cluster varieties

Lattice seeds use the notation and conventions of GHKK, Appendix A.

**3.1 Lattice data.** Fixed data: a finite free lattice `N`, a saturated sublattice
`N_uf`, a skew form `{−,−}:N×N→ℚ`, integers `d_i>0` (`i∈I`) and a finite-index
sublattice `N°`, with `{N_uf,N°}⊆ℤ` and `{N,N_uf∩N°}⊆ℤ`. A seed is a basis `(e_i)_{i∈I}`
of `N` whose subfamily over `I_uf⊆I` is a basis of `N_uf`, with `(d_ie_i)` a basis of
`N°`. Put `M=Hom(N,ℤ)`, `M°=Hom(N°,ℤ)`, `f_i=d_i⁻¹e_i*` (dual to `(d_ie_i)`),
`ε_ij={e_i,e_j}d_j`; prove `ε_ij∈ℤ` unless `i,j∉I_uf`. For `k∈I_uf` define the positive
and negative mutations `μ_k^±`: `e'_k=-e_k`, `e'_i=e_i+[±ε_ik]_+e_k` (`i≠k`). Prove that
they give seeds of the same fixed data and are mutually inverse, and that `μ_k^+μ_k^+(s)`
is the image of `s` under the fixed-data automorphism `e_i↦e_i+ε_ike_k` (`i≠k`),
`e_k↦e_k`.

**3.2 Matrix and coefficient transport.** Let *latticeToFZ*`(s)` be the extended matrix
with rows `I`, columns `I_uf`, `B̃_ik=ε_ki={e_k,d_ie_i}`. Prove that `s_k=L/d_k`
(`k∈I_uf`), `L=lcm(d_k:k∈I_uf)`, is a symmetrizer of its mutable block, that every
symmetrizer `(s_k)` of it has `s_kd_k` constant on each connected component (edges
`b_ij≠0`), and that *latticeToFZ* is invariant under fixed-data automorphisms, so
`latticeToFZ(μ_k^+μ_k^+(s))=latticeToFZ(s)`. For an extended matrix `B̃` with symmetrizer
`(s_k)` and `L=lcm(s_k)`, construct *fzToLattice* on `ℤ^I`: `d_k=L/s_k` (mutable `k`),
`d_j=1` (frozen `j`), `{e_k,e_i}=B̃_ik/d_i` for mutable `k`, skewness, and zero
frozen–frozen form. Prove 3.1 for it and that its mutable weights have gcd `1`; for
fixed data and a positive integer `g` dividing every `d_i` (`i∈I`), prove that
`(d_i,{−,−})↦(d_i/g,g{−,−})` preserves 3.1 and `ε`. Prove *latticeToFZ_fzToLattice*
(`latticeToFZ∘fzToLattice=id`), compatibility with reindexing, and, for every word `w`
of signed mutations of a fixed-data seed, `latticeToFZ(μ_w s)=μ_w(latticeToFZ s)` with
equal geometric coefficient patterns (§1.4). Prove that a seed identifies its fixed data
with the free model on `ℤ^I`; the frozen–frozen form and frozen weights are part of the
fixed data, not functions of `B̃`.

**3.3 Torus mutation and gluing.** For a field `𝕜` of characteristic zero let
`A_s=Spec 𝕜[M°]`, `X_s=Spec 𝕜[N]`, `A_i=z^{f_i}`, `X_i=z^{e_i}`, and
`p₁*:N_uf→M°`, `p₁*(n)={n,−}|_{N°}`. With `s'=μ_k^+(s)`, construct `μ_k` as rational maps
`A_s⇢A_{s'}`, `X_s⇢X_{s'}` and as isomorphisms `D(1+z^{p₁*(e_k)})≅D(1+z^{p₁*(e'_k)})`
and `D(1+X_k)≅D(1+X'_k)`, with pullbacks

$$
\mu_k^*A'_k=A_k^{-1}\left(\prod_i A_i^{[\varepsilon_{ki}]_+}
+\prod_i A_i^{[-\varepsilon_{ki}]_+}\right),\qquad \mu_k^*A'_i=A_i\ (i\ne k),
$$

$$
\mu_k^*X'_k=X_k^{-1},\qquad
\mu_k^*X'_i=X_iX_k^{[\varepsilon_{ik}]_+}(1+X_k)^{-\varepsilon_{ik}}\ (i\ne k).
$$

For *latticeToFZ*`(s)`, the first is §1.4's exchange relation (frozen `A_j` as `z_j`)
and the second, for `i∈I_uf`, §1.2's `y`-mutation with `y_i=X_i` and `+` for `⊕`.
Prove composition and cocycle laws along mutation words. Index charts by the rooted
`|I_uf|`-regular tree, glue each pair along the largest opens where the composite
transition and its inverse are regular, and construct the schemes `𝒜`, `𝒳` with chart
inclusions and re-rooting isomorphisms, not required affine or separated. Prove
`Γ(𝒜,𝒪)=⋂_t 𝕜[M°]_t` in `𝕜(𝒜)`, which is `U_{𝕜_J}` (§1.4) for the geometric pattern
over `𝕜` of *latticeToFZ*`(s)`, with `A_j` as `z_j`. Construct `𝕜⊗_ℤA_{R_J}→Γ(𝒜,𝒪)` by L8
(`J=I∖I_uf`); `𝕜⊗_ℤU_{R_J}≅Γ(𝒜,𝒪)` is not assumed.
The maps `p*:N→M°` with `p*(n)(n°)={n,n°}` whenever `n∈N_uf` or `n°∈N_uf∩N°`
(GHKK, (A.2)) form a nonempty torsor under `Hom(N/N_uf,(N_uf∩N°)^⊥)`, `^⊥` the
annihilator in `M°`. For each such `p*`, kept as data, construct `p:𝒜→𝒳` with torus
pullback `z^n↦z^{p*(n)}`, and prove `μ_k∘p=p∘μ_k` on every chart.

**3.4 Principal and tropical comparisons.** Construct the principal extension
`Ñ=N⊕M°`, `Ñ_uf=N_uf⊕0`, `Ñ°=N°⊕M`, `{(n,m),(n',m')}={n,n'}+⟨n,m'⟩−⟨n',m⟩`
(`⟨−,−⟩` the `ℚ`-valued pairing of `N`, `M°`), seed `(e_i,0),(0,f_i)`, weights `d_i`
on both copies. Prove that its *latticeToFZ* is *latticeToFZ*`(s)` with a new
frozen row `(δ_ik)_{k∈I_uf}` for each `i∈I`. Construct `𝒜_prin` (its `𝒜`), the
projection `𝒜_prin→Spec 𝕜[N]` induced by `N⊆M°⊕N=Hom(Ñ°,ℤ)`, and prove that its fiber
over `1` is `𝒜`. Its `p₁*` is injective on `Ñ_uf`; no result of this layer assumes
injectivity of `p₁*` or nonzero rows of `ε`.
For `min` and for `max` on `ℤ`, construct the tropical points of `𝒜` and `𝒳` (charts
`N°`, resp. `M`) with tropicalized transitions. Prove that *minMaxNegation* `x↦−x` is a
semifield isomorphism `(ℤ,max,+)≅(ℤ,min,+)` intertwining the two tropicalizations of
every subtraction-free function (§0.1), hence of every transition. Define
`T_k:M°→M°`, `T_k(m)=m+[⟨d_ke_k,m⟩]_+p₁*(e_k)` (GHKK's `max` convention), and prove
`T_k(Σm_jf_j)=Σm'_jf'_j` in the bases of `s` and `μ_k^+(s)`, with `m'_k=−m_k`,
`m'_j=m_j+[ε_kj]_+[m_k]_+−[−ε_kj]_+[−m_k]_+`. The commuting squares are: lattice,
`latticeToFZ(μ_k^±s)=μ_k(latticeToFZ s)` (§3.2); coordinate, the formula for `T_k` just
given; tropical, *minMaxNegation* composed with the `max`-tropicalized transition equals
the `min`-tropicalized transition composed with *minMaxNegation*. Transport Laurent
expansions (§0.3, L8) and positivity (§0.3) along them. For `c`- and `g`-vectors (L5,
L6b), *fzToLattice* sends `c_{j;t}` to `Σ_i(c_{j;t})_ie_i∈N` and `g_{j;t}` to
`Σ_i(g_{j;t})_if_i∈M°`; §6.3 states its lattice results through these maps.
`N°`, `M`, `M°` and the `min`/`max` tropical points are distinct types.

**Checks.** For `B=((0,1),(−2,0))`, symmetrizer `(2,1)`, weights `(1,2)` and
`{e₁,e₂}=−1`: `ε=Bᵀ`, `f₂=e₂*/2`, `latticeToFZ(μ_k^±s)=μ_k(B)` (`k=1,2`),
`T₁(f₁)=f₁−2f₂`, `T₁(−f₁)=−f₁`, and `T₁^min(∓f₁)=−T₁(±f₁)` for
`T₁^min(m)=m+min(⟨d₁e₁,m⟩,0)p₁*(e₁)`. For `N=N_uf=ℤe₁`, `d₁=1`, zero form, the principal
extension has `B̃=(0,1)ᵀ` and `A₁A'₁=1+t`, `t=z^{(0,e₁)}`, becoming `A₁A'₁=2` at `t=1`.
Sources: GHKK, §1.3, §2 and Appendices A–B.

## Layer 4: upper bounds and acyclic cluster algebras

Equalities and presentations of commutative subrings of a field, instantiating
§§0.5–0.7, §1.3's words and Q3's intersection theorem. Local equalities are proved in
commutative Laurent rings, not by specializing quantum intersections at `v=1`. No
result here is an input to L5–L8.

### 4.1 Classical finite upper bounds

**U1 — one exchange.** Instantiate §0.5 with the identity automorphism. Its unique
expansion and coefficient-divisibility criterion apply over any commutative domain.
For `E=2` over ℤ, `2x⁻¹` belongs to the intersection but `x⁻¹` does not.

**U2a — two commuting directions.** Over a factorial domain `D`, with algebraically
independent `x,y`, relatively prime nonzero `E,F∈D`, `x*=E/x` and `y*=F/y`,
`D[x,x*,y^{±1}]∩D[x^{±1},y,y*]=D[x,x*,y,y*]`. Relative primality of arbitrary exchange
polynomials is not assumed here.

**U2b — two interacting directions.** For a subring `D` of a field, nonzero `x,y`,
`a,b,d∈D`, `f∈Dˣ`, `c≥0`, `e>0`, `x*=(ay^c+b)/x` and `y*=(dx^e+f)/y`,
`D[x,x*,y^{±1}]∩D[x^{±1},y,y*]=D[x,x*,y,y*]`, with no coprimality premise; for
`H=D[x,x*,y,y*]` the two intersected rings are `D[x,x*,y^{±1}]=H[y⁻¹]` and
`D[x^{±1},y,y*]=H[x⁻¹]`. U2a's relative primality is not a Bézout identity.

**U2c — replacement after mutation.** With U2b's data and `g,h∈Dˣ` with
`fh=dgb^e`, `D[x,x*,y,y*]=D[x,x*,y,(g(x*)^e+h)/y]`.

Instances: for a geometric seed over `R=R_J` or `R=𝕜_J` (§1.4) and mutable `i≠j`, put
`D=R[x_l^{±1}:l≠i,j]`, `x=x_i`, `y=x_j`, `x*=x'_i`, `y*=x'_j`, and `B̃'=μ_i(B̃)`. If
`b_ij=0`, then `x*=E_i/x`, `y*=E_j/y` with `E_i,E_j∈D`, U2a applies when they are
relatively prime in `D`, and the `j`-variable of `μ_jμ_i(s)` is `x'_j`. If `b_ij≠0`, put
`e=|b_ij|`, `c=|b_ji|`, `σ=sign(b_ij)`; then `a,b,d,f,g,h` are the monomials in the
`a_l` (`l≠i,j`, §1.4) with exponents `[-σb_li]_+`, `[σb_li]_+`, `[σb_lj]_+`,
`[-σb_lj]_+`, `[-σb'_lj]_+`, `[σb'_lj]_+`, the `j`-variable of `μ_jμ_i(s)` is
`(g(x*)^e+h)/y`, and `σ(b'_lj−b_lj)=e[σb_li]_+` gives `fh=dgb^e`, so U2b and U2c apply.

**U3 — invariant upper bounds.** For `R=R_J` or `R=𝕜_J` (§1.4) and a geometric seed `s`
over `R`, let `E_i∈R[x_l:l∈K]` be its exchange polynomials; `s` is coprime when they are
pairwise relatively prime, and a pattern is totally coprime when all its seeds are. Put
`UB(s)=L_s∩⋂_{i∈K}L_{μ_i(s)}`. Prove that if `b_ij=0` and `E_i,E_j` are relatively prime
in `R[x_l:l∈K]`, they are relatively prime in `D=R[x_l^{±1}:l≠i,j]` (U2a's premise).
Prove *upperBound_mutation*: `UB(s)=UB(μ_k(s))` whenever `s` and `μ_k(s)` are coprime.
For a totally coprime pattern, prove that `UB(s)` is independent of `s` and equals `U`
(Q3's pattern theorem). Layer 7 uses this description; L8 does not.

**U4 — full rank and total coprimality.** For `R` and a geometric seed as in U3, prove
`E_i=∏_la_l^{[-b_li]_+}(1+∏_la_l^{b_li})` in the Laurent ring in all `a_l` (§1.4), and
that `E_i,E_j` are relatively prime in `R[x_l:l∈K]` whenever columns `i≠j` of `B̃` are
linearly independent over `ℚ` (by §0.6). If `B̃` has full column rank, prove that its
pattern is totally coprime and that `UB(s)=U` at every seed `s` (U3, §1.1). Full column
rank is the only hypothesis; no compatible quantum form is assumed.

**Checks.** For U2a with `D=ℤ[u,w]`, `E=1+u`, `F=1+w`: `(1+u)(1+w)x⁻¹y⁻¹=x*y*` lies
in the intersection, and `(1+u)x⁻¹y⁻¹` lies in `D[x,x*,y^{±1}]` but not in
`D[x^{±1},y,y*]`. For `E=F=2` over `ℤ`, `2/(xy)` lies in both left-hand rings of U2a but
not in `ℤ[x,x*,y,y*]`. For U2b–U2c over `ℤ` with all units `1`, `c=1` and `e=1,2,3`,
`(g(x*)^e+h)/y` is `x*y*−1`, `(x*)²y*−y−2`, `(x*)³y*−y²−3y−3`. For mutable block `0`
in rank two and one frozen row `(1,1)`, `E₁=E₂=1+z`: not coprime.

### 4.2 Acyclic presentations

For a geometric seed `s` over `R=R_J` or `R=𝕜_J` (§1.4), let `LB(s)=R[x_i,x'_i:i∈K]`,
`x'_i` the new variable of `μ_i(s)`. Call `s` acyclic if the graph on `K` with an edge
`i→j` for each `b_ij>0` has no directed cycle. For acyclic `s`, prove that the standard
monomials (no factor `x_ix'_i`) form an `R`-basis of `LB(s)` and that
`R[X_i,X'_i:i∈K]/(X_iX'_i−E_i(X))→LB(s)` is an isomorphism; if `s` is also coprime, prove
`LB(s)=A=U=UB(s)`. Coprimality and full rank are theorem hypotheses, not seed data.

**Checks.** For `B=0` in rank two, principal coefficients give full column rank. For
`xx'=1+z₁z₂`, `U=R[x,x']≅R[X,X']/(XX'−1−z₁z₂)` with basis `x^a` (`a≥0`), `x'^b` (`b>0`).
Source: BFZ III, §1 and proofs in §§3–7.

## Layer 5: finite type and almost-positive roots

**5.1 Classification.** For an exchange matrix `B : Matrix K K ℤ` let `[B]` be the set of
all `μ_w(B)`, `w` a mutation word. A pattern is of finite type if it has finitely many
cluster variables; `B` is of finite mutation type if `[B]` is finite. The Cartan
companion `A(B)` has `a_ii=2`, `a_ij=-|b_ij|` (`i≠j`); prove `D_s A(B)` symmetric for each
symmetrizer `D_s` of `B`. Call `B` bipartite if `b_ijb_ik≥0` for all `i,j,k`. For every
coefficient semifield `P` and `y : K→P`, prove the equivalence of:

1. The cluster algebra with initial matrix `B` is of finite type.
2. Some `B'∈[B]` has `IsFiniteType (A(B'))`.
3. Every `B'∈[B]` satisfies `|b'_ij b'_ji|≤3` for all `i≠j`.

For connected `B` (the graph of `b_ij≠0` is connected) of finite type prove that a unique
`t` with `DynkinType.Valid t` has some `B'∈[B]` with `A(B')` equal, after some
`K≃Fin t.rank`, to `(DynkinType.cartanMatrix t)ᵀ`, FZ II's Cartan matrix of type `t` (so
`Bₙ≠Cₙ`); every valid `t` occurs, and two such classes agree up to simultaneous reindexing
exactly when their types agree. Every finite-type `B` is, after reindexing, block diagonal
with connected blocks, and the multiset of their types determines `[B]` up to reindexing.
Build the weighted diagram `Γ(B)` (an edge `i→j` of weight `|b_ij b_ji|` when `b_ij>0`),
diagram mutation with `Γ(μ_k B)=μ_k Γ(B)`, and FZ II Theorems 7.1 and 8.6, where 2-finite
means condition 3 (for diagrams: all weights in the mutation class are at most 3): every
connected 2-finite diagram is mutation equivalent to an orientation of a Dynkin diagram,
all orientations of one Dynkin diagram are mutation equivalent, and every 2-finite `B` is
mutation equivalent to a bipartite matrix. RootSystems' classification does not supply
these targets.

**5.2 Root combinatorics.** Let `Φ` be a finite crystallographic root system with
`RootPairing.Base`, simple roots `α_i` (`i∈I`), Cartan matrix `A` in FZ II's convention
`s_i(α_j)=α_j-a_ijα_i`, i.e. `a_ij=⟨α_j,α_i^∨⟩`; prove that `A` is the transpose of
`RootPairing.Base.cartanMatrix` and, for `Φ` of type `t` with simple roots numbered as in
`t`, of `DynkinType.cartanMatrix t`; both have `(i,j)` entry `⟨α_i,α_j^∨⟩` (Bourbaki). Let
`[β:α_i]` be the coefficient of `α_i` in `β`. Put `Φ_{≥-1}=Φ_{>0}∪{-α_i}`. For a
bipartition `I=I_+⊔I_-` of the Coxeter graph define `τ_ε` on `Φ_{≥-1}` by `τ_ε(-α_i)=-α_i`
for `i∈I_{-ε}` and `τ_ε(α)=(∏_{i∈I_ε}s_i)(α)` otherwise. Prove that exactly one `ℕ`-valued
`(α||β)` on `Φ_{≥-1}²` satisfies `(-α_i||β)=max([β:α_i],0)` and `(τ_εα||τ_εβ)=(α||β)` for
`ε=±`; that `(α||β)=0 ↔ (β||α)=0` (compatibility); and that for every maximal compatible
set `C` and `α∈C` exactly one `α'≠α` makes `C\{α}∪{α'}` maximal compatible. Construct the
cluster complex on `Φ_{≥-1}`, its facets and its exchange graph.

A bipartite seed for `Φ` has a bipartite exchange matrix `B°` (§5.1) with `A(B°)=A`. The
denominator vector `d(x)∈ℤ^I` of `0≠x∈L_{ℤ[P],0}` is the unique `d` with `x=N/∏x_i^{d_i}`,
`N∈ℤ[P][x_i]` divisible by no `x_i`. For every coefficient semifield `P` and bipartite
initial seed, prove there is a unique bijection `α↦x[α]` from `Φ_{≥-1}` to the cluster
variables with `d(x[α])_i=[α:α_i]`; it has `x[-α_i]=x_i` and maps maximal compatible sets
bijectively to clusters. Deduce that there are `rank(Φ)+|Φ_{>0}|` cluster variables and
finitely many seeds.

**Checks.** Types `A₂`, `B₂` and `G₂` have respectively 5, 6 and 8 variables;
type `A₁×A₁` has four. Construct the polygon-diagonal model for `A_n`, including
compatibility as noncrossing and mutation as a flip. The rank-two matrix
`((0,2),(-2,0))` has finite matrix mutation class but infinitely many cluster variables.
Sources: FZ II, Theorems 1.4–1.9 and §§3, 7–10; RootSystems, Layers 1–6.

## Layer 6: scattering, positivity and sign-coherence

**6.1 The cluster scattering input.** For a Layer 3 lattice seed `s` (FZ seeds via
*fzToLattice*), instantiate ScatteringDiagrams §4.2 over `ℚ`, tracking integral
coefficient subsemirings, with its faithful principal action on `ℚ[M°]⟦t_i⟧`,
`q^n=z^{p₁*(n)}t^n`, and incoming walls `(e_i^⊥,1+q^{e_i})`, `i∈I_uf`; call the
completion `𝔇_s`. Prove `κ(e_i)=d_i` and instantiate §4.2's *principalGradingDictionary*
and *principalProjectionComparison*. Uses: ScatteringDiagrams §3.4 uniqueness and §7.2
ordinary binomial positivity. Construct the map from this principal action to the
diagram of §3.4's principal extension (`t_i` ↦ `e_i` in the `N` summand of
`Hom(Ñ°,ℤ)=M°⊕N`), proving it intertwines walls and wall crossings; it is not an
identification. These statements include zero rows of `ε` and noninjective
`p₁*:N_uf→M°`, also where GHKK assumes otherwise.

Construct the piecewise-linear mutation `T_k` (§3.4) of wall supports and labels on the
half-spaces `⟨e_k,−⟩≥0` and `≤0`, with the wall `e_k^⊥`, crossing signs and primitive
normals. Prove `T_k(𝔇_s)` equivalent to `𝔇_{μ_k^+(s)}` (GHKK Theorem 1.24), comparing the
two sides of `e_k^⊥` through ScatteringDiagrams §4.4's slab localizations at each finite
order of the filtration; no filtered map of the completion induced by `T_k` is asserted.
Construct the chamber `C_t^+` of every seed `t` reached by
a mutation word (`C^+` for the initial seed); prove that wall crossing from `C^+` to
`C_t^+` is the composite of §3.3's cluster maps, and that these chambers and their
faces form the cluster fan.
Not every chamber of `𝔇_s` is asserted to be a cluster chamber.

**6.2 Cluster monomials and positivity.** For every `t` and `m∈M°∩C_t^+`, prove that the
theta function `ϑ_{Q,m}`, endpoint `Q` generic in `C^+`, is the initial-chart expansion,
with principal coefficients, of the monomial `z^m` of the seed-`t` torus (a cluster
monomial of `t` times a frozen Laurent monomial): it lies in the subring `ℤ[t_i][M°]`
(`i∈I_uf`) of polynomials in the `t_i` over `ℤ[M°]`, which is injectively included in
`ℚ[M°]⟦t_i⟧`, and equals there the image of Layer 2's finite expansion (L8, L6a) under
`A_i=z^{f_i}`, `u_i↦t_i`. The specialization `t_i=1` is applied only on `ℤ[t_i][M°]`.
Theorems:

- for every geometric pattern (any `B̃`, including singular `B` and zero rows) and
  reachable `s,t`, the expansion of `x_{j;t}` in chart `s` lies in `ℕ[z_f][x_{i;s}^{±1}]`
  (with L6a), and in `ℕ[z_f][z_r^{-1}:r∈S][x_{i;s}^{±1}]` in each `R_S`;
- for every coefficient semifield `P`, it lies in `ℕ[P][x_{i;s}^{±1}]` (with L7), i.e.
  every §0.3 coefficient function is positive;
- the same for cluster monomials and under L7a's `u_i↦y_i` and L8's `A_P→A_Q`.

**6.3 Sign-coherence.** `C_t` and `G_t` are the FZ matrices of L5 and L6b. Construct the
principal partial compactification relative to a fixed initial lattice seed `s`:
start with the cone spanned by `(0,e_i*)` in `Ñ°=N°⊕M`, for the second copy of `I`,
transport its fan by geometric tropicalization of the chart transitions, and glue
the resulting toric charts (GHKK Construction 5.1, Construction B.9 and Remark B.10).
Construct its morphism to `𝔸^I` extending §3.4's coefficient-torus projection.
Prove that adjacent mutations are isomorphisms on neighborhoods of the zero fiber; identify the two coefficient monomials
`u^{[c_{k;t}]_+}`, `u^{[-c_{k;t}]_+}` of each principal exchange relation and prove one is
`1`. These two results must not assume sign-coherence. Theorems, for every
skew-symmetrizable `B₀` and every mutation word:

- each column of `C_t` is entrywise `≥0` or entrywise `≤0`;
- the `g`-vectors `g_{i;t}`, via the principal grading, are the integral generators of
  `C_t^+`, and each row of `G_t` is entrywise `≥0` or `≤0`;
- `G_tᵀD_sC_t=D_s` for the FZ symmetrizer `D_s=diag(s_i)`; hence `det C_t, det G_t=±1`
  and no column of `C_t` is zero; under *fzToLattice* (`d_i=L/s_i`) and §3.4's maps
  this is `⟨d_ic_{i;t},g_{j;t}⟩=δ_ij` between `N` and `M°`;
- every `F_{j;t}` has constant term `1`, and, with `ε` the sign of `c_{k;t}`,
  `F_{k;t'}F_{k;t}=u^{|c_{k;t}|}∏_iF_{i;t}^{[εb_{ik;t}]_+}+∏_iF_{i;t}^{[-εb_{ik;t}]_+}`,
  stated as a consequence of column sign-coherence.

Transport each result to GHKK's conventions by Layer 3's convention maps.

**Checks.** Compute the `A₂` chamber fan and principal `C,G,F` data around its pentagon.
For `B=((0,1),(-2,0))`, mutation in direction 1 has `g=(-1,2)` for the new variable;
check row sign-coherence and `GᵀD_sC=D_s` with `D_s=diag(2,1)`.
Zero-form rank one (`N=N_uf=ℤe₁`, `d₁=1`) has initial wall `(e₁^⊥,1+t_1)` and exchange
`xx'=1+t_1`; after one mutation `C=(−1)`, `G=(−1)` and `F=1+u`, although its skew form
is zero.
Sources: GHKK, Theorems 1.24, 4.9–4.10, Corollary 5.5 and Theorem 5.11.

## Layer 7: double Bruhat cells

**7.1 Geometric input and minors.** Let `G` be a pinned connected simply connected
semisimple group over `ℂ`, `T⊂B_+` its maximal torus and `B_-` the opposite Borel.
For `u,v∈W` construct the locally closed subscheme `G^{u,v}=(B_+uB_+)∩(B_-vB_-)` of `G`
as a scheme intersection, with its function field; prove it smooth, irreducible, of
dimension `rank(G)+ℓ(u)+ℓ(v)`. Construct the double-word factorization charts and their
rational inverses. Uses ReductiveGroups Layers 7 and 7C.

For each fundamental weight `ω_i` (a character of `T`) construct
`Δ_{ω_i,ω_i}` as a matrix coefficient of the rational highest-weight representation of
ReductiveGroups Layer 10, equal to `ω_i(h)` on `U_-TU_+`. With pinned Weyl representatives
put `Δ_{uω_i,vω_i}(g)=Δ_{ω_i,ω_i}(ū⁻¹gv̄)`; prove it regular, dependent only on `uω_i`
and `vω_i`, and for `SL_n` equal to the minor with rows `u([1,i])` and columns `v([1,i])`.
Prove the rank-two identities of FZ, *Double Bruhat cells*, Theorem 1.16 (with their
transposed companions and the `G₂` identities cited there). Construct the twist map
`ζ^{u,v}:G^{u,v}→G^{u⁻¹,v⁻¹}` (its Definition 1.5) as a biregular isomorphism with
inverse `ζ^{u⁻¹,v⁻¹}` and its pullback on coordinate rings. Other isogeny types are out
of scope.

**7.2 The BFZ seed.** For every double reduced word `i` for `(u,v)`, use negative
letters for `u`, positive letters for `v`, and prepend the indices `-r,…,-1` as in BFZ.
The successor `k⁺` is the next occurrence of the same absolute simple index; the mutable
positions are the positive positions with a successor in the word. Implement `B̃(i)` of
BFZ §2.2, Definition 2.3 and Remark 2.4, and the minors `Δ(k;i)` of §2.3,
(2.9)–(2.11), with index conversions. Prove `B̃(i)` skew-symmetrizable of full column
rank, and that the frozen minors are units on `G^{u,v}`. Construct the field isomorphism
sending each initial variable `x_k` to `Δ(k;i)`. For every mutable `k` and every Cartan
type, prove the exchange relation as an identity of regular functions, that `x'_k` is
regular, and that the cluster of `μ_k` gives a chart of `G^{u,v}`.

**7.3 Coordinate ring identification.** Prove that the initial and adjacent charts cover
an open subset of `G^{u,v}` with complement of codimension at least two, and, by
SchemeAndStackFoundations §0.6 (Hartogs), that `Γ(G^{u,v},O)` is the intersection of
these Laurent rings. With U3–U4 construct `U_ℂ(B̃(i)) ≃ₐ[ℂ] Γ(G^{u,v},O)` sending each
`x_k` to `Δ(k;i)`, where `U_ℂ` and `A_ℂ` are §1.4's `U_{𝕜_J}` and `A_{𝕜_J}` for
`𝕜=ℂ`. If the pattern of `B̃(i)` contains an acyclic seed, prove
§4.2's hypotheses for it and deduce `A_ℂ(B̃(i))=U_ℂ(B̃(i))≃ₐ[ℂ]Γ(G^{u,v},O)`. For double
reduced words `i,i'` of `(u,v)` construct the composite `U_ℂ(B̃(i))≃U_ℂ(B̃(i'))` through
`Γ(G^{u,v},O)`, without assuming the seeds mutation equivalent.

**Checks.** For `SL₂`, `G^{s,s}` consists of matrices `(a b; c d)` with `bc≠0` and
`ad-bc=1`. Identify its coordinate ring with
`ℂ[b^{±1},c^{±1},a,d]/(ad-1-bc)`; `a,d` are exchanged and `b,c` are frozen.
For `SL₃` and `(u,v)=(w₀,w₀)`, reproduce BFZ's matrix, eight initial minors,
four mutable positions and four adjacent exchanges in Example 2.11.
Sources: FZ, *Double Bruhat cells and total positivity*; BFZ III, §2, especially
Theorem 2.10, Lemmas 2.12–2.13 and Corollary 2.17.

## Completion criteria

Every carrier has the extensionality, reindexing, evaluation and compatibility lemmas its
consumers here use; definition-only files do not finish a layer. The Laurent theorem and
finite-type classification hold for arbitrary coefficient semifields; geometric
constructions and integral positivity keep their stated scope. The Laurent theorem gives
finite expansions with uniqueness and coefficient transport laws, via the common
polynomial Q1–Q3: use `ℤ[v,v⁻¹]` and the positive compatible form for quantum
seeds, and the integral unit-parameter zero-form principal seed for L5, then
L6–L8 for every `P`. Transitively, L8 and Somos-4 integrality depend on this same
common Q3 through the direct classical L5 instance, without the `v=1` comparison.
Q1–Q3 do not depend on L5–L8, Layer 4,
positivity or categorification. U1–U4 are delivered for their own consumers. There is one
public Laurent engine, sharing §§0.5–0.7 and Q3; its representatives equal the public
expansion maps' values. The targets use neither unique factorization of `ℤ[P]` nor
Laurentness stored in seed data. Polynomial, partially inverted and inverted frozen
coefficient rings instantiate the same definitions, with proved localization maps.
The FZ/lattice comparison maps carry whole patterns, not only exchange matrices.
Layer 6 proves mutation invariance, theta identification and the passage from formal
positive series to finite Laurent coefficients. Layer 7 gives an isomorphism of actual
algebras with checked generator images, not a structure with the coordinate-ring
theorem as a field.
Q4 gives algebraic realizations with noninvertible frozen generators, normalization, bar
and grading transports, and proved Ore localization maps. No ambient fraction-field
specialization, general special-fiber isomorphism, or commutation of base change with an
infinite intersection is assumed. Finite examples check formulas and conventions; they
do not replace the all-rank results.

For §2.6, the degree-one comparison preserves the ordinary public statements
and their proof dependencies. The polynomial local comparisons construct their
premises from seed data and use §0.7; the upper-bound theorem proves the
central-factor coprimality for the specified scalar polynomials. No finite check
substitutes for these all-rank targets.

## References

- **FZ I:** Fomin–Zelevinsky, [*Cluster algebras I: Foundations*](https://arxiv.org/abs/math/0104151),
  §§2–3, especially Theorem 3.1 for the general Laurent statement.
- **FZ II:** Fomin–Zelevinsky, [*Cluster algebras II: Finite type classification*](https://arxiv.org/abs/math/0208229),
  §1.3–1.5, §3, §§7–10 and Proposition 11.2 for polynomial frozen coefficients.
- **FZ IV:** Fomin–Zelevinsky, [*Cluster algebras IV: Coefficients*](https://arxiv.org/abs/math/0602259),
  Definitions 2.1–2.4, Theorems 3.5 and 3.7, and Corollary 6.3.
- **GHKK:** Gross–Hacking–Keel–Kontsevich,
  [*Canonical bases for cluster algebras*](https://arxiv.org/abs/1411.1394), version 2,
  §1.3 (PDF pp. 29–34), §4 (pp. 45–50), §5 (pp. 50–57),
  Appendix A (pp. 111–113) and Appendix B (pp. 113–118).
- **BFZ III:** Berenstein–Fomin–Zelevinsky,
  [*Cluster algebras III: Upper bounds and double Bruhat cells*](https://arxiv.org/abs/math/0305434),
  §§1–4; the upper-bound proof is on PDF pp. 24–28, and Theorem 2.10 and its
  geometric input are on pp. 15–18 of version 3.
- Fomin–Zelevinsky, [*Double Bruhat cells and total positivity*](https://arxiv.org/abs/math/9802056),
  the factorization, twist and generalized-minor constructions used by BFZ.
- **BZ:** Berenstein–Zelevinsky, [*Quantum cluster algebras*](https://arxiv.org/abs/math/0404446),
  §§3–4 for compatible pairs and mutation, §5 for integral upper bounds and Laurentness,
  §6 for bar operations, and §11 for Ore fractions and central divisibility.
- **KKKO:** Kang–Kashiwara–Kim–Oh,
  [*Monoidal categorification of cluster algebras*](https://arxiv.org/abs/1801.05145),
  §§5.1–5.2 for the quantum seed convention and nonlocalized generated algebra.
  Only that algebraic interface is in scope here.
- **GLS:** Geiss–Leclerc–Schröer,
  [*Quantum cluster algebras and their specializations*](https://arxiv.org/abs/1807.09826),
  for the distinction between variable specialization and algebra special-fiber
  isomorphisms.
- **BCDX:** Bai–Chen–Ding–Xu, [*Generalized quantum cluster algebras: the Laurent
  phenomenon and upper bounds*](https://arxiv.org/abs/2203.06928),
  Definition 2.3, Theorems 3.1 and 4.9 and the local algebra of §4.
