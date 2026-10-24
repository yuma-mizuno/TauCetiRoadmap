/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.FlatDivisibility
public import Mathlib.LinearAlgebra.FreeModule.Basic
public import Mathlib.RingTheory.Ideal.Span
public import Mathlib.Algebra.Divisibility.Units

/-!
# Central divisibility over a free central subalgebra

Let `T` be an `S`-algebra, so that `S` maps into the center of `T`, which is free as an
`S`-module, and let `S` be a commutative decomposition monoid. For relatively prime `P, Q ∈ S`,
an element of `T` divisible by `P` and by `Q` is divisible by `P Q`, that is
`T P ∩ T Q = T (P Q)`; divisibility is checked on the coordinates in a basis. No Bézout
identity is used.

This is the central divisibility of §0.6: the quantum torus over the Laurent ring of a central
sublattice (`QuantumTorus.exists_eq_mul_centralHom_mul`) and, in the commutative case `T = S`,
the coefficient step of the commuting rank-two intersection
(`Laurent.CommutingExchange.mem_exchangeRing_of_divisibility`) are instances.
-/

@[expose] public section

namespace TauCeti

variable {S T : Type*} [CommRing S] [Ring T] [Algebra S T]

theorem mul_algebraMap_eq_smul (g : T) (P : S) : g * algebraMap S T P = P • g := by
  rw [Algebra.smul_def, Algebra.commutes]

/-- **Central divisibility in a basis.** If `T` has an `S`-basis, then for relatively prime
`P, Q ∈ S` an element of `T` divisible on the right by `P` and by `Q` is divisible by `P Q`. -/
theorem exists_eq_mul_algebraMap_mul_of_basis [DecompositionMonoid S] {ι : Type*}
    (b : Module.Basis ι S T) {P Q : S} (hPQ : IsRelPrime P Q) {f : T}
    (hP : ∃ g, f = g * algebraMap S T P) (hQ : ∃ g, f = g * algebraMap S T Q) :
    ∃ g, f = g * algebraMap S T (P * Q) := by
  let : Module.Free S T := Module.Free.of_basis b
  obtain ⟨g, hg⟩ := Module.exists_mul_smul_of_relPrime hPQ f
    (hP.imp fun g hg ↦ by simpa only [mul_algebraMap_eq_smul] using hg.symm)
    (hQ.imp fun g hg ↦ by simpa only [mul_algebraMap_eq_smul] using hg.symm)
  exact ⟨g, by simpa only [mul_algebraMap_eq_smul] using hg.symm⟩

/-- **Central divisibility.** If `T` is free over `S`, then for relatively prime `P, Q ∈ S` an
element of `T` divisible on the right by `P` and by `Q` is divisible by `P Q`. -/
theorem exists_eq_mul_algebraMap_mul [Module.Free S T] [DecompositionMonoid S] {P Q : S}
    (hPQ : IsRelPrime P Q) {f : T} (hP : ∃ g, f = g * algebraMap S T P)
    (hQ : ∃ g, f = g * algebraMap S T Q) : ∃ g, f = g * algebraMap S T (P * Q) :=
  exists_eq_mul_algebraMap_mul_of_basis (Module.Free.chooseBasis S T) hPQ hP hQ

/-- **Central divisibility** as an equality of left ideals: `T P ∩ T Q = T (P Q)`. -/
theorem span_algebraMap_inf_span_algebraMap [Module.Free S T] [DecompositionMonoid S]
    {P Q : S} (hPQ : IsRelPrime P Q) :
    Ideal.span {algebraMap S T P} ⊓ Ideal.span {algebraMap S T Q} =
      Ideal.span {algebraMap S T (P * Q)} := by
  apply le_antisymm
  · rintro f ⟨hP, hQ⟩
    obtain ⟨g, hg⟩ := exists_eq_mul_algebraMap_mul (T := T) hPQ
      ((Ideal.mem_span_singleton'.1 hP).imp fun _ h ↦ h.symm)
      ((Ideal.mem_span_singleton'.1 hQ).imp fun _ h ↦ h.symm)
    exact Ideal.mem_span_singleton'.2 ⟨g, hg.symm⟩
  · rw [Ideal.span_singleton_le_iff_mem, Submodule.mem_inf, map_mul]
    refine ⟨Ideal.mem_span_singleton'.2 ⟨algebraMap S T Q, ?_⟩,
      Ideal.mem_span_singleton'.2 ⟨algebraMap S T P, rfl⟩⟩
    rw [← map_mul, mul_comm, map_mul]

end TauCeti
