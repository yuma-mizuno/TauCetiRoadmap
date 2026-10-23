import TauCeti.Algebra.Lie.Heisenberg
import TauCeti.GroupTheory.SpecificGroups.Heisenberg
import TauCetiRoadmap.ScatteringDiagrams.Formalized.CentralDefect
import Mathlib.Tactic.Ring

/-!
# A constructed BCH central extension and its chamber defects

The Lie algebra and group are the existing Tau Ceti Heisenberg objects. We
construct mutually inverse exponential and logarithm maps and check the
class-two BCH multiplication, then construct the central extension used by
`CentralDefect`. No extension, BCH identity, or defect identity is a hypothesis.
The geometric crossing sequence is connected to these calculations separately.
-/

set_option autoImplicit false

namespace TauCetiRoadmap.ScatteringDiagrams.Formalized.HeisenbergConnection

open TauCeti

abbrev H := HeisenbergGroup ℚ
abbrev L := heisenberg ℚ

def exp (A : L) : H :=
  ⟨A.val 0 1, A.val 1 2, A.val 0 2 + A.val 0 1 * A.val 1 2 / 2⟩

def log (g : H) : L :=
  g.x • heisenbergX ℚ + g.y • heisenbergY ℚ +
    (g.z - g.x * g.y / 2) • heisenbergZ ℚ

theorem exp_log (g : H) : exp (log g) = g := by
  ext <;> simp [exp, log]

theorem log_exp (A : L) : log (exp A) = A := by
  simpa [exp, log] using
    (eq_smul_heisenbergX_add_smul_heisenbergY_add_smul_heisenbergZ A).symm

/-- This is the actual polynomial `A+B+[A,B]/2` on the existing Lie algebra. -/
theorem exp_bch (A B : L) :
    exp (A + B + (1 / 2 : ℚ) • ⁅A, B⁆) = exp A * exp B := by
  rw [lie_eq_smul_heisenbergZ]
  ext <;> simp [exp]
  ring

def X (a : ℚ) : H := ⟨a, 0, 0⟩
def Y (b : ℚ) : H := ⟨0, b, 0⟩
def Z (c : ℚ) : H := ⟨0, 0, c⟩

@[simp] theorem exp_X (a : ℚ) : exp (a • heisenbergX ℚ) = X a := by
  ext <;> simp [exp, X]

@[simp] theorem exp_Y (b : ℚ) : exp (b • heisenbergY ℚ) = Y b := by
  ext <;> simp [exp, Y]

@[simp] theorem exp_Z (c : ℚ) : exp (c • heisenbergZ ℚ) = Z c := by
  ext <;> simp [exp, Z]

def centralInclusion : Multiplicative ℚ →* H where
  toFun c := Z c.toAdd
  map_one' := rfl
  map_mul' c d := by ext <;> simp [Z]

def lowerProjection : H →* Multiplicative (ℚ × ℚ) where
  toFun g := Multiplicative.ofAdd (g.x, g.y)
  map_one' := rfl
  map_mul' _ _ := rfl

theorem centralInclusion_injective : Function.Injective centralInclusion := by
  intro c d h
  exact Multiplicative.toAdd.injective (congrArg HeisenbergGroup.z h)

def extension : GroupExtension (Multiplicative ℚ) H (Multiplicative (ℚ × ℚ)) where
  inl := centralInclusion
  rightHom := lowerProjection
  inl_injective := centralInclusion_injective
  range_inl_eq_ker_rightHom := by
    ext g
    constructor
    · rintro ⟨c, rfl⟩
      rfl
    · intro h
      have hxy : (g.x, g.y) = (0, 0) := congrArg Multiplicative.toAdd h
      refine ⟨Multiplicative.ofAdd g.z, ?_⟩
      ext <;> simp [centralInclusion, Z, (Prod.mk.inj hxy).1, (Prod.mk.inj hxy).2]
  rightHom_surjective := by
    intro q
    exact ⟨⟨q.toAdd.1, q.toAdd.2, 0⟩, rfl⟩

theorem extension_central (c : Multiplicative ℚ) (g : H) :
    extension.inl c * g = g * extension.inl c := by
  ext <;> simp [extension, centralInclusion, Z, add_comm]

/-- The abstract inverse of the kernel injection agrees with the actual matrix
corner coordinate, rather than an independently postulated logarithm. -/
theorem centralLog_eq (u : extension.rightHom.ker) :
    CentralDefect.log extension u = u.val.z := by
  exact congrArg HeisenbergGroup.z (CentralDefect.exp_log extension u)

/-- The meridian starts in the northeast chamber and runs counterclockwise.
The factors are derived from the crossing convention in the geometry module. -/
def initialProduct (a b : ℚ) : H := (X a)⁻¹ * (Y b)⁻¹ * X a * Y b

theorem initialProduct_eq (a b : ℚ) : initialProduct a b = Z (a * b) := by
  ext <;> simp [initialProduct, X, Y, Z]

theorem initialProduct_eq_exp_bracket (a b : ℚ) :
    initialProduct a b = exp ⁅a • heisenbergX ℚ, b • heisenbergY ℚ⁆ := by
  rw [initialProduct_eq, lie_smul, smul_lie, lie_heisenbergX_heisenbergY,
    smul_smul, mul_comm b a, exp_Z]

/-- Chamber lifts NE=1, NW=Y, SW=XY, SE=X. Their lower-order transport
equations are proved directly; the nontrivial defect is on the south vertical ray. -/
def chamberPath (a b : ℚ) : CentralDefect.LiftedPath extension (1 : H) 1 :=
  .cons (b := Y b) (Y b) (by simp) <|
  .cons (b := X a * Y b) (X a) (by rw [map_mul]) <|
  .cons (b := X a) (Y b)⁻¹ (by
    apply Multiplicative.toAdd.injective
    apply Prod.ext <;> simp [extension, lowerProjection, X, Y]) <|
  .cons (X a)⁻¹ (by simp) (.nil 1)

theorem chamberPath_product (a b : ℚ) : (chamberPath a b).product = initialProduct a b := by
  simp [chamberPath, CentralDefect.LiftedPath.product, initialProduct, mul_assoc]

theorem chamberPath_defect (a b : ℚ) : (chamberPath a b).defectSum = a * b := by
  rw [(chamberPath a b).closed_defectSum_eq_log extension_central,
    centralLog_eq]
  change (chamberPath a b).product.z = a * b
  rw [chamberPath_product, initialProduct_eq]
  rfl

/-- The same correction sign as README §3.3, after converting its swept
coorientation to the normal `dx-dy`. -/
def correctedProduct (a b c : ℚ) : H :=
  (X a)⁻¹ * (Y b)⁻¹ * (Z c)⁻¹ * X a * Y b

theorem correctedProduct_eq (a b c : ℚ) : correctedProduct a b c = Z (a * b - c) := by
  ext <;> simp [correctedProduct, X, Y, Z]
  ring

theorem correctedProduct_eq_one (a b : ℚ) : correctedProduct a b (a * b) = 1 := by
  rw [correctedProduct_eq]
  simp only [sub_self]
  rfl

/-- A sign regression is observable: it doubles the central error. -/
theorem wrong_sign_detected : correctedProduct 1 1 (-1) ≠ 1 := by
  rw [correctedProduct_eq]
  intro h
  have := congrArg HeisenbergGroup.z h
  norm_num [Z] at this

end TauCetiRoadmap.ScatteringDiagrams.Formalized.HeisenbergConnection
