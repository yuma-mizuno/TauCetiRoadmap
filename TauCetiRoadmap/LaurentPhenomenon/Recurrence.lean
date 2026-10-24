/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.PositiveLaurentTheorem
public import TauCetiRoadmap.LaurentPhenomenon.IntegerSpecialization

/-!
# Recurrences realized by exchange paths

Users supply the initial values and forward recurrence only. The finite tree's
auxiliary leaves and backward edges are handled by its established realization.
Periodic changes of labels are transported by a separate, purely dynamical lemma.
-/

@[expose] public section
noncomputable section
namespace TauCeti.Laurent

namespace PositiveCaterpillar
variable {G I F : Type*} [AddCommGroup G] [DecidableEq I] [Field F]
  [IsDomain (TotalLaurentRing G I)] {P : CaterpillarPath I}
  (T : PositiveCaterpillar G P) (f : TotalLaurentRing G I →+* F)

omit [IsDomain (TotalLaurentRing G I)] in
/-- Uniqueness on the spine needs no data on the auxiliary leaves. -/
theorem value_spine_eq_recurrence (y : ℕ → I → F)
    (hzero : y 0 = initialVariables f)
    (hstep : ∀ k : Fin P.length, y (k.val + 1) =
      mutateCoordinateValues f (T.exchange (P.spine ⟨k.val, by omega⟩) (P.label k))
        (P.label k) (y k.val))
    (k : ℕ) (hk : k ≤ P.length) :
    T.value f (P.spine ⟨k, by omega⟩) = y k := by
  induction k with
  | zero =>
    rw [hzero]
    funext i
    exact T.value_source f i
  | succ k ih =>
    rw [T.value_path_forward f ⟨k, by omega⟩, ih (by omega)]
    exact (hstep ⟨k, by omega⟩).symm

end PositiveCaterpillar

namespace PositiveCaterpillar
universe u
variable {G I F : Type u} [AddCommGroup G] [DecidableEq I] [Finite I]
  [Field F] [IsDomain (TotalLaurentRing G I)] {P : CaterpillarPath I}
  (T : PositiveCaterpillar G P) (f : TotalLaurentRing G I →+* F)

/-- Laurentness for a separately defined recurrence, with only forward equations
as the bridge to the exchange data. -/
theorem recurrence_laurent
    (hf : ∀ p, positiveCast p ≠ 0 → f (positiveCast p) ≠ 0)
    (y : ℕ → I → F) (hzero : y 0 = initialVariables f)
    (hstep : ∀ k : Fin P.length, y (k.val + 1) =
      mutateCoordinateValues f (T.exchange (P.spine ⟨k.val, by omega⟩) (P.label k))
        (P.label k) (y k.val)) (i : I) :
    y P.length i ∈ chartRing (coefficientRange f) (y 0) := by
  have h := T.laurent f hf i
  have ht := T.value_spine_eq_recurrence f y hzero hstep P.length le_rfl
  have hs := T.value_spine_eq_recurrence f y hzero hstep 0 (Nat.zero_le _)
  change T.value f (P.spine ⟨P.length, by omega⟩) i ∈
    chartRing (coefficientRange f) (T.value f (P.spine ⟨0, by omega⟩)) at h
  rwa [ht, hs] at h

end PositiveCaterpillar

namespace PositiveCaterpillar
variable {G I : Type} [AddCommGroup G] [DecidableEq I] [Finite I]
  [IsDomain (TotalLaurentRing G I)] {P : CaterpillarPath I}
  (T : PositiveCaterpillar G P)

/-- The all-one arithmetic consequence for any recurrence matching the path. -/
theorem recurrence_integral (y : ℕ → I → ℚ) (hzero : ∀ i, y 0 i = 1)
    (hstep : ∀ k : Fin P.length, y (k.val + 1) =
      mutateCoordinateValues allOnes
        (T.exchange (P.spine ⟨k.val, by omega⟩) (P.label k)) (P.label k) (y k.val))
    (i : I) : ∃ z : ℤ, (z : ℚ) = y P.length i := by
  have h := T.allOnes_integral i
  have h0 : y 0 = initialVariables (allOnes (G := G)) := by
    funext i
    simp [hzero]
  have ht := T.value_spine_eq_recurrence allOnes y h0 hstep P.length le_rfl
  change T.value allOnes (P.spine ⟨P.length, by omega⟩) i ∈ _ at h
  rw [ht] at h
  exact h

end PositiveCaterpillar

/-- A finite family of coordinate frames conjugates one fixed recurrence to a
periodic family of mutations. No Laurentness or integrality is assumed. -/
theorem periodic_recurrence_step {S X : Type*} {m : ℕ} (hm : 0 < m)
    (step : S → S) (observe : Fin m → S → X) (mutation : Fin m → X → X)
    (hcompat : ∀ p s, mutation p (observe p s) =
      observe ⟨(p.val + 1) % m, Nat.mod_lt _ hm⟩ (step s))
    (s : ℕ → S) (hs : ∀ n, s (n + 1) = step (s n)) (n : ℕ) :
    observe ⟨(n + 1) % m, Nat.mod_lt _ hm⟩ (s (n + 1)) =
      mutation ⟨n % m, Nat.mod_lt _ hm⟩
        (observe ⟨n % m, Nat.mod_lt _ hm⟩ (s n)) := by
  rw [hcompat, hs]
  congr 1
  apply Fin.ext
  simp [Nat.add_mod]

end TauCeti.Laurent
