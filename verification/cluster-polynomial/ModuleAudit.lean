/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
import Lean

/-! Check the compiled module flag using the same API and lifetime discipline
as Tau Ceti's pinned `scripts/ModuleSystem.lean`. Source names are supplied by
the verification runner's complete, validated source enumeration. -/

open Lean

@[noinline] def readFlag (data : ModuleData) : BaseIO Bool :=
  return data.isModule

def main (args : List String) : IO UInt32 := do
  if args.isEmpty then throw (IO.userError "module audit: empty source list")
  initSearchPath (← findSysroot)
  for name in args do
    let path ← findOLean name.toName
    let (data, region) ← readModuleData path
    let optedIn ← readFlag data
    unsafe region.free
    unless optedIn do
      throw (IO.userError s!"module audit: {name} was built without `module`")
  IO.println s!"Module system: all {args.length} compiled modules passed."
  return 0
