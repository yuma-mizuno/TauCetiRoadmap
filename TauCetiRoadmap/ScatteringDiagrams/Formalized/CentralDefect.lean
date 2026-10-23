import Mathlib.GroupTheory.GroupExtension.Defs
import Mathlib.Tactic.Group

/-!
# Central errors along lifted chamber paths

The extension is Mathlib's `GroupExtension`. No BCH, geometric meridian, or
cochain assertion is hidden in it. Given actual lower-order edge transports,
we construct their central logarithms and prove the telescoping identity in
the first-crossing-rightmost convention of README §§0.5 and 3.3.
-/

set_option autoImplicit false

namespace TauCetiRoadmap.ScatteringDiagrams.Formalized
namespace CentralDefect

variable {E G H : Type*} [AddCommGroup E] [Group G] [Group H]
  (S : GroupExtension (Multiplicative E) G H)

noncomputable def kernelEquiv : Multiplicative E ≃* S.rightHom.ker :=
  (MonoidHom.ofInjective S.inl_injective).trans
    (MulEquiv.subgroupCongr S.range_inl_eq_ker_rightHom)

noncomputable def log (u : S.rightHom.ker) : E :=
  (kernelEquiv S).symm u |>.toAdd

theorem exp_log (u : S.rightHom.ker) :
    S.inl (Multiplicative.ofAdd (log S u)) = (u : G) :=
  congrArg Subtype.val ((kernelEquiv S).apply_symm_apply u)

theorem log_injective : Function.Injective (log S) := by
  intro u v h
  apply Subtype.ext
  rw [← exp_log S u, ← exp_log S v, h]

theorem exp_add (a b : E) : S.inl (Multiplicative.ofAdd (a + b)) =
    S.inl (Multiplicative.ofAdd a) * S.inl (Multiplicative.ofAdd b) :=
  S.inl.map_mul _ _

/-- Lower-order compatibility of a crossing places its discrepancy in the kernel. -/
def edgeError (a b X : G) (h : S.rightHom X * S.rightHom a = S.rightHom b) :
    S.rightHom.ker :=
  ⟨b⁻¹ * X * a, by
    change S.rightHom (b⁻¹ * X * a) = 1
    rw [map_mul, map_mul, map_inv, mul_assoc, h, inv_mul_cancel]⟩

noncomputable def edgeLog (a b X : G)
    (h : S.rightHom X * S.rightHom a = S.rightHom b) : E :=
  log S (edgeError S a b X h)

theorem exp_edgeLog (a b X : G)
    (h : S.rightHom X * S.rightHom a = S.rightHom b) :
    S.inl (Multiplicative.ofAdd (edgeLog S a b X h)) = b⁻¹ * X * a :=
  exp_log S _

/-- Actual crossing elements and successive lifts. The only proof field is
the edge transport equation after projection to the lower-order group. -/
inductive LiftedPath : G → G → Type _
  | nil (a : G) : LiftedPath a a
  | cons {a b c : G} (X : G)
      (transport : S.rightHom X * S.rightHom a = S.rightHom b)
      (tail : LiftedPath b c) : LiftedPath a c

namespace LiftedPath

variable {S}

/-- Multiplication on the left: the first crossing is the rightmost factor. -/
def product {a b : G} : LiftedPath S a b → G
  | .nil _ => 1
  | .cons X _ tail => product tail * X

noncomputable def defectSum {a b : G} : LiftedPath S a b → E
  | .nil _ => 0
  | .cons X h tail => defectSum tail + edgeLog S _ _ X h

theorem projected_transport {a b : G} (p : LiftedPath S a b) :
    S.rightHom p.product * S.rightHom a = S.rightHom b := by
  induction p with
  | nil => simp [product]
  | cons X h tail ih => simpa only [product, map_mul, mul_assoc, h] using ih

/-- Exact telescoping before using centrality. No conjugation is silently omitted. -/
theorem exp_defectSum {a b : G} (p : LiftedPath S a b) :
    S.inl (Multiplicative.ofAdd p.defectSum) = b⁻¹ * p.product * a := by
  induction p with
  | nil => simp [defectSum, product]
  | cons X h tail ih =>
    rw [defectSum, exp_add, ih, exp_edgeLog]
    simp only [product]
    group

variable (hcentral : ∀ (e : Multiplicative E) (g : G), S.inl e * g = g * S.inl e)

include hcentral in
/-- For a closed lifted path the product is the exponential of the sum of
the central edge logarithms. Centrality removes precisely the base-lift conjugation. -/
theorem closed_product_eq {a : G} (p : LiftedPath S a a) :
    p.product = S.inl (Multiplicative.ofAdd p.defectSum) := by
  calc
    p.product = a * S.inl (Multiplicative.ofAdd p.defectSum) * a⁻¹ := by
      rw [p.exp_defectSum]
      group
    _ = S.inl (Multiplicative.ofAdd p.defectSum) := by
      rw [← hcentral]
      group

def closedProduct {a : G} (p : LiftedPath S a a) : S.rightHom.ker :=
  ⟨p.product, by
    change S.rightHom p.product = 1
    have h := p.projected_transport
    exact mul_right_cancel (h.trans (one_mul _).symm)⟩

include hcentral in
/-- The logarithm of the loop product equals the sum of its wall discrepancies. -/
theorem closed_defectSum_eq_log {a : G} (p : LiftedPath S a a) :
    p.defectSum = log S p.closedProduct := by
  apply Multiplicative.ofAdd.injective
  apply S.inl_injective
  rw [← p.closed_product_eq hcentral, exp_log]
  rfl

include hcentral in
/-- Changing chamber lifts leaves the closed defect unchanged when the actual
crossing product stays the same. The two base lifts may be different. -/
theorem defectSum_eq_of_product_eq {a b : G} (p : LiftedPath S a a)
    (q : LiftedPath S b b) (h : p.product = q.product) : p.defectSum = q.defectSum := by
  apply Multiplicative.ofAdd.injective
  apply S.inl_injective
  rw [← p.closed_product_eq hcentral, ← q.closed_product_eq hcentral, h]

include hcentral in
/-- The correction has the negative logarithm in the left-action convention. -/
theorem negative_defect_cancels {a : G} (p : LiftedPath S a a) :
    S.inl (Multiplicative.ofAdd (-p.defectSum)) * p.product = 1 := by
  rw [p.closed_product_eq hcentral, ← map_mul]
  change S.inl (Multiplicative.ofAdd (-p.defectSum + p.defectSum)) = 1
  simp

end LiftedPath
end CentralDefect
end TauCetiRoadmap.ScatteringDiagrams.Formalized
