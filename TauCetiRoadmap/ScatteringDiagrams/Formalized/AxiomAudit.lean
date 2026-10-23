import TauCetiRoadmap.ScatteringDiagrams.Formalized
import Lean.Util.CollectAxioms

/-!
The audit checks every declaration defined by the proved modules, including
private declarations, data, instances and generated declarations, and follows
its transitive dependencies.
Only Lean's standard logical axioms are permitted. In particular `sorryAx`,
custom axioms and native-decision trust axioms cause a compilation error.
-/

open Lean in
run_elab do
  let env ← getEnv
  let targetNS := `TauCetiRoadmap.ScatteringDiagrams.Formalized
  let allowed := #[`propext, `Classical.choice, `Quot.sound]
  -- A negative control verifies that the imported prototype's admitted theorem
  -- really is detectable. It is inspected as metadata, never used as a proof.
  let control ← collectAxioms
    `TauCetiRoadmap.ScatteringDiagrams.DirectedDiagram.segmentProduct_eq_wallProductAt
  unless control.contains `sorryAx do
    throwError "Negative control changed: review the audit against the current Suggested source."
  let source ← getConstInfo `TauCetiRoadmap.ScatteringDiagrams.sweepSupport_isCell
  let proved ← getConstInfo
    `TauCetiRoadmap.ScatteringDiagrams.Formalized.RationalSweepConnection.sweepSupport_isCell
  unless ← Meta.isDefEq source.type proved.type do
    throwError "The rational-sweep test no longer has exactly the source theorem's type."
  let names := env.constants.fold (init := #[]) fun names name _ =>
    match env.getModuleIdxFor? name with
    | some idx =>
      if targetNS.isPrefixOf env.header.moduleNames[idx.toNat]! then names.push name else names
    | none => names
  if names.isEmpty then
    throwError "The proved namespace is empty; refusing a vacuous audit."
  for name in names do
    for ax in ← collectAxioms name do
      unless allowed.contains ax do
        throwError "Unapproved axiom {ax} in the dependencies of {name}"
  logInfo m!"Axiom audit passed for {names.size} declarations. Allowed: propext, Classical.choice, Quot.sound."
