# Formalization stress test of the scattering roadmap

This is a stress test of [README.md](README.md) and
[Suggested.lean](Suggested.lean). Its purpose is to determine whether their
definitions, hypotheses, conventions and proposed proof routes support the
claimed mathematics. The test uses complete Lean proofs, with no admitted
steps or added mathematical axioms. Its results are evidence for assessing and
revising the roadmap; this document reports that evidence.

The test root is [Formalized.lean](Formalized.lean). The original four modules
use Mathlib independently of the prototype. The newer connection tests import
`Suggested.lean` to use its **actual definitions**, rather than independently
restating the interfaces. The axiom audit follows every new declaration's
transitive dependencies and rejects any use of an admitted prototype result.
It also checks a known admitted source theorem as a negative control. The
README and Suggested now include the local specification corrections described below.

## Findings from the completed tests

The algebraic and support-geometry tests below support the indicated arguments
under their stated hypotheses. The subsequent specification audit found a missing
locality condition in the prototype and a qualification needed for subdivision
invariance. These are recorded separately from the unproved connections. The results
do not settle the existence, uniqueness or theta-transport arguments as a whole.

### Specification corrections and proof dependencies

1. **Joint meridians must isolate the chosen joint (§§1.2, 3.3).** Before the
   correction, `ChamberTrivialization.meridian_spec` required transversality to `j`
   and that every wall met contain `j`, but did not exclude other joints. Its
   `complex` field was not required to cover the ambient space, so an unstated
   completeness condition cannot supply that exclusion. Consider the wall
   `P=[0,1]×{0}` and the finite complex consisting of `P` and its endpoints.
   The positively oriented triangle `(-2,-2),(4,-2),(-2,4)` contains both
   endpoints in its interior; its boundary misses `P`. It is transverse to
   either point, and the only wall met by its interior contains either point.
   Thus it satisfies the old geometric conditions for both joint meridians.
   With a nonzero central wall label, trivial lower-order quotient and constant
   lifts, both such loop products are `1`, whereas the defect cochain has
   coboundary `c[(0,0)]-c[(1,0)]`. This is the explicit mathematical obstruction
   to the old interface. The new `meridian_isolates` field excludes it, and
   README §1.2 states the same condition. No global completeness requirement
   was added to all polyhedral complexes.

   [SpecificationStress.lean](Formalized/SpecificationStress.lean) proves the
   triangle's positive determinant, strict interior incidences, boundary
   avoidance, spanning property and transversality against the actual source
   simplex predicates. **It does not formalize the entire group/complex/cochain
   countermodel above.** That last conclusion is a mathematical audit argument,
   not a newly completed Lean counterexample to `centralDefect_eq_coboundary`.

2. **Subdivision invariance has a domain condition (§1.4).** The test interval
   `[-1,1]` meets the point `0` once. Splitting it into `[-1,0]` and `[0,1]`
   puts the intersection on both new boundaries. Closed-preimage counting
   would give `1+1`, but neither new piece is an admissible transverse test.
   The same file proves the interior/boundary incidences and the failure of
   the actual `IsTransverseSimplex` condition for both pieces. README now
   requires transversality to both cochain representatives, and transversality
   of every piece of a parameter subdivision. This makes the domain precise;
   it is not a counterexample to invariance with that domain condition.

3. **The sweep proof route had unnecessary dependencies (§1.4).** To obtain
   the generator identity, transversality identifies `P-ℝ≥0 n` with a prism
   having base `P` and all swept facets of `P`. Their orientations give
   `dS(P)=-P-S(dP)`. README now uses this direct route and retains the pairing,
   detection theorem and Stokes identity as API targets. This is a proof-design
   revision, **not a completed proof of that facet formula or quotient descent**.
   All codimensions, arbitrary abelian coefficients, real offsets, unbounded
   supports and lineality remain in scope.

4. **A bundle is not an existence proof (§3.3).** The roadmap now explicitly
   requests `exists_chamberTrivialization`, including the local choices, from
   lower-order consistency and the surjective truncation. Passing an arbitrary
   `ChamberTrivialization` to the defect identity does not build this connection.
   Its existence proof and the general defect identity remain open in the test.

5. **Construction hypotheses must be separated from uniqueness (§§0.8, 1.4).**
   `GradedCorrespondence` now carries the span and admissible lifts; joint
   injectivity is a separate hypothesis for unique common lifts and matching
   families, including refinement comparisons and global theta gluing; it is not
   required in the definition of a based coefficient diagram.
   `SpecificationStress.redundantSpan` uses both projections
   `(x,y)↦x` on `ℚ²`. It is not jointly injective, but its actual transfer maps
   equal those of the identity graph for any coefficient grading. The same file
   proves that the constant interval at `1` is transverse to the point `0` under
   the intersection-local rank condition, while its edge vectors do not span `ℝ`.
   Face and frontier avoidance remain required. These tests use the revised
   source definitions without admitted results.

   The README also allows initial families finite at each order (§3.3) and states
   finite-sum gluing before its theta application (§5.7). These are theorem targets,
   not new completed proofs. The closed degeneration charts of §5.3 remain a
   sufficient geometric construction supplying the gluing hypotheses.

   The all-rank positivity route uses vanishing for directions tangent to the
   joint (§3.3), not merely the special case of zero spatial direction.

### Connections checked against actual definitions

| Precise connection | Complete proof and finding | Limit of the test |
|---|---|---|
| §§1.1, 1.4: rational-normal presentation → swept support → rational-normal presentation with the required dimension | [RationalSweepConnection.lean](Formalized/RationalSweepConnection.lean) constructs `m+m²` inequalities by eliminating the nonnegative sweep parameter. `sweepPresentation_carrier` proves equality with the actual `sweepSupport`. The final `sweepSupport_isCell` has exactly the source theorem's type, also checked by the audit. Real offsets, unbounded supports, and lineality are allowed. No rational-height hypothesis is added. | The conormal contraction, oriented subdivision quotient, all boundary incidences, and the cochain homotopy remain separate obligations. |
| §3.2: time-sorted `segmentProduct` → incident `wallProductAt` | [PathProductConnection.lean](Formalized/PathProductConnection.lean) proves `segmentProduct_eq_wallProductAt` on the actual `DirectedDiagram`, `IsAdmissiblePolygon`, and product definitions. Joint avoidance forces equal support directions; equal real kernels yield integral proportionality of normals; the existing parallel-wall-group axiom then supplies commutation. Sorting, reversal, and inactive factors are handled explicitly. | The theorem concerns a segment with one regular crossing location, as stated in Suggested. It does not supply general-position perturbations or joint-loop generation, or construct wall groups from a graded Lie algebra. |
| §3.3: `CentralKernel` → Mathlib `GroupExtension` → the same central logarithm | [CentralKernelConnection.lean](Formalized/CentralKernelConnection.lean) constructs the extension of the actual quotient groups. Surjectivity is proved from quotient representatives. `log_eq` identifies the independently defined inverses, and the proved closed-path defect formula uses the source logarithm. | The source `CentralKernel` data remain inputs here. This does not construct that data for an arbitrary BCH tower, or construct a geometric lifted meridian from `ChamberTrivialization`. |
| §§0.4, 3.3: an actual noncommutative BCH model → central extension → chamber defect → oriented sweep → correction trace | [HeisenbergConnection.lean](Formalized/HeisenbergConnection.lean) constructs inverse exponential/logarithm maps between Tau Ceti's Heisenberg Lie algebra and group and proves the class-two BCH formula. [RankTwoSweepConnection.lean](Formalized/RankTwoSweepConnection.lean) proves exhaustive geometric crossings, their order and transversality, connects the uncorrected trace to the constructed chamber path, and proves that sweeping its computed defect cancels the loop product. Reversing the correction sign gives a proved nonidentity result. | This is the specified rank-two, class-two model over `ℚ`, for arbitrary rational input coefficients. The trace has a proved exhaustive intersection list and uses a factor definition proved equal to the source crossing rule. It is not packaged as a full source `DirectedDiagram` or `ChamberTrivialization`, and does not prove the general cochain identity `ζ=dA` or global consistency. |

The rational sweep eliminates `t` from
`f_j(y)+t f_j(n)≤c_j`, `t≥0`. It keeps `f_j(y)≤c_j` for nonnegative
slopes and, for every positive slope `a=f_p(n)` and negative slope `b=f_q(n)`,
adds `(a f_q-b f_p)(y)≤a c_q-b c_p`. The converse chooses the maximum of
zero and the finitely many lower bounds. In particular, the case with no upper
bounds and the case with no inequalities are covered by the same proof.

In the concrete correction test, the incoming supports are `y=0` and `x=0`,
and the swept support is `−ℝ≥0(1,1)`. The counterclockwise rectangle has vertices
`(1,1),(-2,1),(-2,-1),(1,-1),(1,1)`. Its bottom edge crosses the outgoing ray
*before* the vertical wall; neither crossing is discarded. Writing
`X=exp(a x)`, `Y=exp(b y)` and `Z(c)=exp(c z)`, its product is
`X⁻¹Y⁻¹Z(c)⁻¹XY=Z(ab-c)`. The constructed chamber defect is `ab`, while
`ι_(1,1)(dx∧dy)=dy-dx`. The negative exponential prescribed for this swept
orientation therefore agrees with `Z(ab)` at normal `dx-dy`. With the wrong
sign and `a=b=1`, the error is `Z(2)≠1`. This is a sensitivity check of the
test, not a counterexample to the roadmap's stated convention.

### Earlier argument-component tests

| Locus and question tested | Proof evidence | Finding for the roadmap | Connection still to test |
|---|---|---|---|
| §§3.1, 3.3: does a noninjective degree-to-direction map invalidate Lie-word vanishing? | [WallLieWords.lean](Formalized/WallLieWords.lean) | The stated homogeneous wall-space axioms suffice over any commutative coefficient ring. Every binary Lie word with at least two leaves vanishes when its total direction lies in the subgroup annihilated by its leaf normals; so does their full linear span. Injectivity of `ρ` is unnecessary. | The actual meridian error must belong to this span, with its linear terms canceled at the specified correction stage. |
| §3.3: are crossing order, conjugation and the correction sign consistent? | [CentralDefect.lean](Formalized/CentralDefect.lean) | For a central group extension and actual lower-order edge transport equations, the first-crossing-rightmost convention gives the telescoping equation below. Equal initial and final lifts and centrality remove the conjugation. The negative logarithm cancels the loop product. | Instantiate the extension and lifts from the BCH tower, and identify the geometric crossing sequence and incidence signs with the cochain coboundary. |
| §1.4: are transverse swept supports closed and strictly outgoing, including for unbounded supports? | [SweepGeometry.lean](Formalized/SweepGeometry.lean) | Transversality constructs a height functional and gives a unique base point and sweep parameter. Closed supports have closed sweeps in finite dimension; the affine direction gains exactly one dimension. Covers and intersections on a common transverse base are preserved. Strict outgoingness requires no boundedness or salience assumption. | Rational-normal presentations are now connected above. Induced orientations, subdivision relations and the full cochain identity `dS + Sd = -id`, including side faces, remain. |
| §3.4: does strict outgoingness give the uniform escape needed by the rectangle argument? | [OutgoingGeometry.lean](Formalized/OutgoingGeometry.lean) | A defining inequality supplies a normal positive on the forward direction. Translating an entire segment sufficiently far in that direction misses the support. Finitely many outgoing supports with the same forward direction admit one common bound. | Admissibility of the rectangle and the path-product identities needed to deduce that the homogeneous central difference is trivial. |

### Hypotheses and conventions exposed by the tests

`DirectedWallSpaces` and `wallBracketNormal` in the test namespace have the
same fields and formula as their suggested counterparts. They are restated here
to keep the proof import graph independent of the admitted prototype. No theorem
identifying independently completed group or diagram constructions is implied.

For a real joint direction `U` and lattice map `i : Λ → V`, the subgroup in
`WallLieWords` is `i⁻¹(U)`. Normals annihilating `U` annihilate this subgroup.
Its vanishing theorem applies when `i(ρ(n)) ∈ U`. Setting `ρ(n)=0` supplies the
zero-direction case without assuming that `ρ` is injective. The requirement of
at least two leaves is essential: an individual wall coefficient with zero
geometric direction need not vanish.

For a lifted path with crossings `X₁,…,Xᵣ` and lifts `t₀,…,tᵣ`, the proved
telescoping equation is

\[
\exp\!\left(\sum_{j=1}^{r}\log(t_j^{-1}X_jt_{j-1})\right)
=t_r^{-1}(X_r\cdots X_1)t_0.
\]

Here `exp` is the injection of Mathlib's specified
`GroupExtension (Multiplicative E) G H`; `log` is its constructed inverse on the
kernel. Each edge satisfies its lower-order transport equation. For `tᵣ=t₀`,
centrality removes the conjugation. This verifies the group calculation with
those inputs. To test the claimed identity `ζ=dA`, the inputs and their
geometric interpretation must themselves be constructed from the roadmap's
data; supplying that identity as a hypothesis would not test it.

## Unresolved stress tests

The highest-risk connections still requiring complete proofs are:

1. **Cochain sweep (§1.4).** The actual rational-normal support construction is
   now proved. Do the orientations, subdivision quotient,
   intersection pairing and Stokes identity give `dS + Sd = -id` with every
   side face retained, including in the presence of lineality? Support geometry
   alone does not answer this.
2. **Actual obstruction and correction (§3.3).** The actual central-kernel
   interface is connected to the group calculation, and the class-two example
   passes the complete geometric trace test. Do the specified chamber
   trivializations give `ζ=dA`? Does the meridian error expand into the required
   homogeneous Lie words with its linear terms canceled? Do the resulting
   sweeps produce the next correction stage on a common refinement?
3. **Path and completion arguments (§§1.2, 2.1–2.3, 3.3–3.4).** The actual
   single-crossing product comparison is now proved. Do generic path
   perturbations and joint-loop generation justify the claimed product
   invariances, finite-order compatibility, existence and uniqueness at the
   stated generality?
4. **Broken lines and transport (§§5.2–5.7).** Do the component-change bounds
   control all encounters and closed degenerations? Do endpoint reconstruction
   and the local resolutions establish transport without assuming the desired
   finite-family or matching conclusions?

The other targets in Layers 0–7 have not been exhaustively stress-tested here.
Each subsequent result should identify the precise roadmap claim, the
hypotheses actually used, and either a complete proof at that scope or a
specific obstruction or counterexample. A stronger auxiliary hypothesis must
be reported as a remaining gap in the test. Declaration counts and successful
builds do not measure how much of the roadmap has survived this examination.

## Reproducing the proof checks

The workspace pins Lean `v4.35.0-rc3` and Mathlib
`6b7abb3c7686292736be2955bd3eb9ebf63b456a`. From the repository root, run:

```powershell
lake build TauCetiRoadmap.ScatteringDiagrams.Formalized.AxiomAudit
```

On this Windows installation, the pinned executable can be called directly:

```powershell
& 'C:/Users/mizun/.elan/toolchains/leanprover--lean4---v4.35.0-rc3/bin/lake.exe' build TauCetiRoadmap.ScatteringDiagrams.Formalized.AxiomAudit
```

[AxiomAudit.lean](Formalized/AxiomAudit.lean) enumerates declarations by their
defining modules, including private and generated declarations. It follows
transitive dependencies and permits only `propext`, `Classical.choice`, and
`Quot.sound`. `sorryAx`, added mathematical axioms and native-decision trust
axioms fail the check. An empty audit also fails. The rational-sweep source
signature is checked for definitional equality with the proved signature. The
known admitted source path-product theorem is inspected as a negative control;
it is never used as a proof. This checks proof dependencies and one exact source
signature; the broader correspondence to the roadmap remains a mathematical
obligation.

The original 2026-10-22 audit checked 147 declarations. The connection-test
build now imports the prototype and consequently reports its existing `sorry`
warnings; those warnings do not certify the new tests. Acceptance requires the
separate transitive-dependency audit to pass for every new declaration.
The specification-test build on 2026-10-22 passed that audit for 333 declarations.
The 2026-10-23 generality revision passed for 339 declarations, including the
negative control and rational-sweep signature comparison. All new proof modules
compiled without warnings. These counts identify the
checked artifact and do not measure coverage of the roadmap.

The original README and Suggested sources were backed up under
`.lake/scattering-backups/20261022-proof-start/`. The state before these
connection tests, including the existing proof modules and report, was backed
up under `.lake/scattering-backups/20261022-connection-stress/`, together with
the Git revision and status. Before the specification corrections, README,
Suggested, the test root and this report were backed up under
`.lake/scattering-backups/20261022-specification-audit/`, with the Git status.
The state before the README generality revision is committed as `9b9115dc`.
No unrelated worktree files were edited.
