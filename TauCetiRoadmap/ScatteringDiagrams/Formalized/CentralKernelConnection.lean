import TauCetiRoadmap.ScatteringDiagrams.Suggested
import TauCetiRoadmap.ScatteringDiagrams.Formalized.CentralDefect

/-!
# Connecting the prototype's central kernel to the proved path calculation

The quotient groups, transition map, inclusion, and logarithm here are the
actual prototype definitions. We construct the Mathlib extension from them and
prove that its logarithm agrees with the prototype's independently chosen
inverse. We do not invoke either admitted geometric kernel-membership theorem.
-/

set_option autoImplicit false

namespace TauCetiRoadmap.ScatteringDiagrams.Formalized.CentralKernelConnection

open TauCetiRoadmap.ScatteringDiagrams

variable {G E : Type*} [Group G] [AddCommGroup E]
  {K : OrderFiltration G} {k : ℕ} (κ : CentralKernel K k E)

def toExtension : GroupExtension (Multiplicative E)
    (G ⧸ K.ker (k + 1)) (G ⧸ K.ker k) where
  inl := κ.ι
  rightHom := K.step k
  inl_injective := κ.ι_injective
  range_inl_eq_ker_rightHom := κ.range_ι
  rightHom_surjective := by
    intro q
    obtain ⟨g, rfl⟩ := QuotientGroup.mk'_surjective (K.ker k) q
    exact ⟨K.proj (k + 1) g, rfl⟩

theorem log_eq (u : (K.step k).ker) :
    CentralDefect.log (toExtension κ) u = κ.log u := by
  apply Multiplicative.ofAdd.injective
  apply κ.ι_injective
  exact (CentralDefect.exp_log (toExtension κ) u).trans (κ.ι_log u).symm

/-- The abstract telescoping proof now lives on the exact quotient tower and
uses the exact logarithm specified in Suggested. The remaining obligation is
to construct this lifted crossing path from the geometric meridian. -/
theorem closed_defectSum_eq_log {a : G ⧸ K.ker (k + 1)}
    (p : CentralDefect.LiftedPath (toExtension κ) a a) :
    p.defectSum = κ.log p.closedProduct := by
  exact (p.closed_defectSum_eq_log κ.central).trans (log_eq κ p.closedProduct)

end TauCetiRoadmap.ScatteringDiagrams.Formalized.CentralKernelConnection
