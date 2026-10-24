/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import Mathlib.Algebra.Group.UniqueProds.VectorSpace
public import Mathlib.GroupTheory.DivisibleHull
public import Mathlib.Algebra.MonoidAlgebra.NoZeroDivisors

/-! Domain property for arbitrary torsion-free abelian coefficient groups.
The proof embeds the group into its rational divisible hull. No finite
generation or free-abelian hypothesis is imposed on the coefficient group. -/

@[expose] public section

namespace TauCeti.Laurent

variable (G : Type*) [AddCommGroup G] [IsAddTorsionFree G]

theorem torsionFree_uniqueSums : UniqueSums G :=
  UniqueSums.of_injective_addHom (DivisibleHull.coeAddMonoidHom G).toAddHom
    (fun _ _ h ↦ DivisibleHull.coe_injective h) inferInstance

theorem groupRing_isDomain : IsDomain (AddMonoidAlgebra ℤ G) := by
  let := torsionFree_uniqueSums G
  infer_instance

end TauCeti.Laurent
