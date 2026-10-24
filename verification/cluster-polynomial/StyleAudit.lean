/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
import Mathlib.Tactic.Linter.TextBased

/-! Run the pinned Mathlib text and filename linters on an explicit complete
module list. Every relevant option is enabled explicitly, independently of
which Lake configuration a standalone executable discovers. No exemptions or
automatic source changes are used. -/

open Lean Lean.Linter Mathlib.Linter.TextBased

def main (args : List String) : IO UInt32 := do
  if args.isEmpty then
    throw (IO.userError "style audit: empty source list")
  let modules := args.toArray.map String.toName
  let opts : LinterOptions := {
    toOptions := ({} : Options)
      |>.setBool `linter.adaptationNote true
      |>.setBool `linter.trailingWhitespace true
      |>.setBool `linter.whitespaceBeforeSemicolon true
      |>.setBool `linter.unicodeLinter true
      |>.setBool `linter.modulesUpperCamelCase true
      |>.setBool `linter.modulesForbiddenWindows true
    linterSets := {}
  }
  let errors ← lintModules opts #[] modules .humanReadable false
  let casing ← modulesNotUpperCamelCase opts modules
  let filenames ← modulesOSForbidden opts modules
  if errors != 0 || casing != 0 || filenames != 0 then return 1
  IO.println s!"Text and filename style: all {modules.size} modules passed."
  return 0
