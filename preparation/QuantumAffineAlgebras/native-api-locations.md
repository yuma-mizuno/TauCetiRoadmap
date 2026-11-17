# Native API audit for QuantumAffineAlgebras

This records read-only inspection of the pinned sources. It does not report successful elaboration of new declarations. Line numbers below refer to the exact pins, not the current remote branch.

## Inspected pins

| Repository | Commit |
| --- | --- |
| TauCetiRoadmap | `c6ef576569501d342dec5a31a9938c9549dc6a00` |
| TauCetiRoadmapWorker | `162470c202cff60e47b8d3339f2d609a6bb40d45` |
| TauCeti | `2fd255d997f47c0b5d834ee416c7015d55444ce5` |
| Mathlib | `1b1ccf4b088b32fa3f23f2de1127433254a81e1e` |

The library checkouts are under `TauCetiRoadmap/.lake/packages/{TauCeti,mathlib}`. The toolchain recorded by the roadmap repository is `leanprover/lean4:v4.36.0-rc2`.

## Existing carriers and theorems

All TauCeti paths below are relative to the TauCeti repository. The declarations were read together with their surrounding variables and instance assumptions.

| File and line | Existing contract | Boundary relevant to this roadmap |
| --- | --- | --- |
| `TauCeti/Algebra/Category/FiniteHopfModuleCat/Basic.lean:49` | `TauCeti.FiniteHopfModuleCat`: full subcategory of H-modules whose restriction to k is finite dimensional; `of`, `ofHom`, `ofShrink`, forgetful functors and linear structure | Do not rebuild the generic finite-dimensional module category. This file does not supply the type-1 subcategory or its abelian/essential-smallness proofs. |
| `TauCeti/Algebra/Category/FiniteHopfModuleCat/Monoidal.lean:265` | Monoidal category for a k-bialgebra H; tensor is over k through the coproduct; monoidal forgetful functor, monoidal preadditive and linear structure | Tensor is not tensor over H. |
| `TauCeti/Algebra/Category/FiniteHopfModuleCat/RightRigid.lean:65,95,123` | Dual module via antipode S, exact pairing and right rigidity | Requires Hopf algebra structure, not finite dimension of H. |
| `TauCeti/Algebra/Category/FiniteHopfModuleCat/Rigid.lean:69,132,146` | Left dual via S⁻¹, left exact pairing and `rigidCategory hS` | Bijectivity of S is explicit. `rigidCategory` is a definition to install locally, not an unconditional instance. |
| `TauCeti/CategoryTheory/GrothendieckGroup/Abelian.lean:79,108,242,256` | `AbelianK0`, short-exact relation, additive universal lift and lift equivalence | Requires the actual abelian category and essential smallness; this is exact K₀, not split K₀. |
| `TauCeti/CategoryTheory/GrothendieckGroup/Monoidal/Exact.lean:80,108,140,177` | `mulHom`, `of_mul_of`, `instRing`, `liftRingHom` | Requires a monoidal exact structure, obtained by proving tensor biexact. Reuse the ring construction. |
| `TauCeti/CategoryTheory/GrothendieckGroup/Monoidal/Exact.lean:275` | `instCommRing` | Assumes `BraidedCategory`. Do not impose this on all of C_g; prove K₀ commutativity by the quantum-affine representation theory. |
| `TauCeti/RingTheory/CompositionSeries/Multiplicity.lean:217,222,239,309,337,400,408` | `jordanHolderMultiplicity`, agreement with any composition series, isomorphism invariance, zero and simple-object values | Uses module-wise `[IsNoetherian R M] [IsArtinian R M]`, not `[IsArtinianRing R]`. |
| `TauCeti/RingTheory/CompositionSeries/Additivity.lean:126,154` | `jordanHolderMultiplicity_eq_submodule_add_quotient`, `jordanHolderMultiplicity_eq_add_of_exact` | The second statement takes actual R-linear maps, injectivity, surjectivity and `Function.Exact`; endpoint finite-length instances are explicit binders. |
| `TauCeti/Algebra/Category/ModuleCat/FiniteLength.lean:30` | `ModuleCat.prop_of_isFiniteLength`: zero/simple/short-exact-extension induction | Available for an arbitrary coefficient ring. |
| `TauCeti/RepresentationTheory/GrothendieckGroup/SimpleBasis.lean:65,190,260` | `IsExhaustiveSimpleFamily` and `simpleClassBasis` on `FGModuleCat R` | This file assumes `[IsArtinianRing R]`; it cannot be directly instantiated at U_q′. Descend the preceding native multiplicities on C_g instead. |
| `Mathlib/RingTheory/FiniteLength.lean:33,53,76,85` | `IsFiniteLength`, existence of composition series, equivalence with Noetherian and Artinian module conditions | `IsFiniteLength` is a proposition, not a typeclass. |
| `Mathlib/RingTheory/Noetherian/Basic.lean:319` | `isNoetherian_of_tower` | Finite dimension over k implies Noetherian as an H-module through the scalar tower. |
| `Mathlib/RingTheory/Artinian/Module.lean:359` | `isArtinian_of_tower` | The analogous Artinian-module implication does not require H itself Artinian. |
| `Mathlib/RingTheory/SimpleModule/Basic.lean:561` | `jacobson_density`, under `[IsSemisimpleModule R M]`: every endomorphism over `End R M` can be matched by an element of R on an arbitrary finite set of vectors | Applies to a simple rational module with scalar endomorphism algebra. It supplies the finite interpolation argument for absolute simplicity; it is not itself a quantum-affine theorem. |
| `Mathlib/Algebra/Polynomial/Laurent.lean:532` | `LaurentPolynomial.eval₂`, with the substituted parameter a unit | Specialization at a nonzero spectral parameter. |
| `Mathlib/Algebra/Category/ModuleCat/ChangeOfRings.lean:85` | `ModuleCat.restrictScalars` for an actual ring homomorphism | Use for a proved algebra inclusion or quotient; no substitute action carrier. |
| `Mathlib/CategoryTheory/ObjectProperty/FullSubcategory.lean:39` | `CategoryTheory.ObjectProperty.FullSubcategory` | Carrier for the type-1 and Serre tensor subcategories. |
| `Mathlib/CategoryTheory/Simple.lean:55,140` | `CategoryTheory.Simple` and `Simple.not_isZero` | Categorical simple objects are nonzero. |
| `Mathlib/CategoryTheory/EssentiallySmall.lean:47` | `CategoryTheory.EssentiallySmall` | Required by native exact Grothendieck groups. |

## Content identities of central files

These are Git blob identities at the TauCeti pin, independent of local line endings.

| File suffix | Blob |
| --- | --- |
| `FiniteHopfModuleCat/Basic.lean` | `0e905b06bb05967e456f2153f939ec32dff9abc9` |
| `FiniteHopfModuleCat/Monoidal.lean` | `cdc461c6f83ff2a37fbbcf5c0f44ddf18fc29f49` |
| `FiniteHopfModuleCat/RightRigid.lean` | `e4feb2c80c3d832ebd259bb5befe662aeb339030` |
| `FiniteHopfModuleCat/Rigid.lean` | `6186416bc2017ae765c785c15b8ed038494f9f4d` |
| `GrothendieckGroup/Abelian.lean` | `bf71a0383f89916aa361d08d29bef562a1507802` |
| `GrothendieckGroup/Monoidal/Exact.lean` | `945942b97a02ab4c65ac60a365e8512963be4fd9` |
| `CompositionSeries/Multiplicity.lean` | `52ea537edf9e622d57ba1d23ad874bc4a5d8606a` |
| `CompositionSeries/Additivity.lean` | `a1359da7d7bd017f34319ca1f22ba7e5fb161ebf` |
| `ModuleCat/FiniteLength.lean` | `bd49fc8af4a58e325d21ae4e38db95059b6882e2` |
| `RepresentationTheory/GrothendieckGroup/SimpleBasis.lean` | `c04e0a6bf77591e8a6645ee7ea7be05ac926b800` |

## Missing affine carriers and roadmap ownership

Full pinned TauCeti and Mathlib source searches for quantum-affine/quantum-loop, Drinfeld-polynomial, normalized/renormalized R-matrix, and monoidal-categorification declarations found no such native carriers. TauCeti's `QuantumGroups` directory contains `QuantumInteger` and `UqSl2` implementations. This is evidence for keeping unavailable affine headlines in prose rather than inventing substitute carriers in Suggested.lean; it is not a claim that every supporting general algebra theorem is missing.

On the roadmap main snapshot, `QuantumEnvelopingAlgebras` §§1.0–1.5 and §2.1 supply the generic symmetrizable algebra, Hopf structure and braid automorphisms. Its §2.2 is finite-type PBW. Its §5.3 first paragraph specifies the weight-idempotent modified algebra and Laurent form within the finite-type Frobenius layer; the affine extension and agreement with the existing finite-type construction must be stated explicitly. `KacMoody` §0 supplies the realization and lattices. `QuantumGroups` §8.5 owns the native generic finite Hopf module category. `ClusterAlgebras` §§1.2–1.3 and §2.3 supply the classical, noninverted-frozen and locally finite seed conventions. These are suppliers, not new construction targets.

The “KacMoody, Part II” mentioned by KacMoody and QuantumEnvelopingAlgebras has no main/Completed folder at this snapshot. No general quantum global-basis or extremal-module construction target was found. An affine fundamental-module argument must therefore expose the precise local existence/classification theorem it needs; it cannot silently depend on that absent roadmap.

## Reproducible source searches

Run from each library checkout, with the final path changed to `Mathlib` for Mathlib:

```sh
git rev-parse HEAD
rg -n -i 'quantum.?affine|quantum.?loop|drinfeld.?polynomial|normalized.?R.?matrix|renormalized.?R.?matrix|monoidal.?categorification' TauCeti
rg --files TauCeti | rg 'Quantum|FiniteHopfModuleCat|CompositionSeries|GrothendieckGroup'
rg -n 'jordanHolderMultiplicity|simpleClassBasis|prop_of_isFiniteLength' TauCeti
```

Read the files at the pin before relying on a theorem's assumptions. This inventory does not replace elaboration of the eventual import and theorem statements.
