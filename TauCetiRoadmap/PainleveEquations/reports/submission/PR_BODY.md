# Painlevé equations

Adds a roadmap constructing Painlevé equations from moduli of meromorphic connections, with horizontal solutions, Riemann–Hilbert comparison and the Painlevé property, initial-condition surfaces, symmetries, Riccati reductions, tau sections and classical scalar/Hamiltonian/Lax comparisons. Its 57 targets include reusable general constructions and their Painlevé applications; Garnier applications, asymptotic connection constants and confluence are outside the scope.

The PR adds only `README.md`, `Suggested.lean` and `metadata.toml` under `TauCetiRoadmap/PainleveEquations/`. The English README includes the full specification, dependency contracts and bibliography. Japanese translation, structured plans, authoring history and validation tooling stay on the separate working branch.

Validation: 997 packaging/preservation checks pass, retaining all 57 target bodies apart from the listed working-file reference edits and preserving every formula. The topic checker passes for 173 roadmaps. GitHub's rendered page contains 212 MathML nodes and all 57 target headings, with no queried math-error nodes or rendering warnings; target 0.6 was visually spot-checked. This is not a mathematical proof or a visual inspection of every formula.

`Suggested.lean` contains four intentional `sorry` proof targets. Its current type checking is unconfirmed: the last direct check stopped at a missing compiled Tau Ceti import. No full repository build was restarted. The irregular proper-RH, global moduli/surface and resonant/ramified tau comparisons are explicitly owned construction and proof targets; narrower source results are not treated as proving them.

The author selected the scope. Codex (GPT-6) assisted with drafting, source/library checks, interface prototypes and editorial/packaging checks. Human mathematical review is required. The linked Getting started: roadmaps Zulip discussion has not been read because prior access attempts failed.
