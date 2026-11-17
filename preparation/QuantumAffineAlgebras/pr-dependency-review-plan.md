# QuantumAffineAlgebras: open-PR dependency validation plan

This is a preparatory review note, not an acceptance of an unreviewed revision. It records the unchanged worker rules at commit `162470c202cff60e47b8d3339f2d609a6bb40d45` and the validation needed after the author's correction. It does not modify the worker, supplier roadmaps, board, or upstream PRs.

## Subject and ownership

The author's explicit instruction is to make **quantum affine algebras** the subject and consume the general theory. The README title should therefore name quantum affine algebras, not call the project “quantum enveloping algebras, part II.” The introduction and exact supplier contracts must make the same division: general algebra, crystal/global-basis and representation-theory inputs belong to their named suppliers; this roadmap owns the affine specializations, comparison maps and further affine results it actually needs.

The worker's default instruction to label an extension “Part II” does not require retaining a title the author has explicitly rejected. Nor does a title change excuse duplicate ownership: generic constructions must actually be removed from the affine target statements when their full contracts are consumed. An affine adapter remains a target only with the difference from the general supplier stated precisely.

## Which open work may supply a target

`prompts/sections/dependencies.md` distinguishes the following cases.

| Supplier situation | Contract used by this new roadmap | Evidence kept outside the README |
| --- | --- | --- |
| Roadmap on main, active or completed | Its main version and exact section | Main commit, path and resolved section |
| Open PR adds a genuinely new roadmap folder | Its exact head and exact sections may be consumed | PR number, head SHA, changed files, absence of that folder on main and the required merge precedence |
| Open PR revises a roadmap already on main | Continue to consume main, not proposed strengthened content | Main/head comparison and any changed ownership |
| An open revision drops a cited identifier without a mapping | Use the corrected identifier at its head, or another true owner | The revision becomes an explicit merge dependency in the eventual PR description |
| Existing owner lacks a required general theorem | Declare a precise supplier gap instead of pretending a nonexistent section supplies it | Matching `gap:<slug>` in the README and design plan's `gaps`, plus supplier, section and one-sentence hypothesis-complete need |
| No owner can be found | This is an ownership issue, not an implicit supplier | Explain the search and assign an owner; do not invent a name or claim an unchecked supply |

Because `QuantumAffineAlgebras` is a new folder relative to main, the rule prohibiting **revisions of an already merged roadmap** from adding open suppliers does not apply to this package. No actual open supplier is to be put into the gate's `merged` set.

The main `KacMoody` Scope and ownership explicitly names **KacMoody, Part II** as the general quantum type-1/crystal successor and places it after `QuantumEnvelopingAlgebras`; the latter's main Scope repeats that boundary. Thus `KacMoodyPartII` may be named as the planned owner of a declared gap even if there is no installed folder or open PR. The gap's `section` is a **proposed named target**, never an invented numbered section. Its global/modified/extremal-basis requirements, if added, are new explicit general supplier obligations; they are not represented as existing target statements in the main scope paragraph. The intended chain is classical `KacMoody`, then `QuantumEnvelopingAlgebras`, then the planned `KacMoodyPartII`, then `QuantumAffineAlgebras`. The classical roadmap does not acquire an upward quantum dependency.

This use of a missing named contract is the gap mechanism of `prompts/design.md`, not a fictional cross-reference: `lanes.design.supplier_gap_problems` requires a valid CamelCase supplier and a nonempty proposed section/target, while `validate_plan` requires each `gap:<slug>` prerequisite to match an entry with those fields. The report must distinguish such a planned gap owner from an observed open-PR supplier. The new affine roadmap's `parent` field is `null`.

An open PR whose folder is now on main can be a stale second copy rather than a genuine new supplier. Compare main, merge-base and head before choosing it. A changed-file list alone does not settle that distinction.

## README and Suggested.lean conventions

1. Cite suppliers by `RoadmapName §x.y`, including open roadmaps. The README carries no PR numbers, dates, head SHAs, current-status narrative or private paths. Exact-head evidence belongs in the preparation reports.
2. Use `## Scope and ownership`, `## Exact supplier contracts`, and `### From TauCetiRoadmap.<Name>` to state the consumption boundary. Resolve every cited target at its actual main or eligible open head.
3. Every retained affine target needs its precise statement, API, at least three discriminating Checks, source locators, and explicit dependencies. Merely replacing “prove” with “consume” in the generic target and keeping it as an owned target would retain the duplication.
4. Deleting or moving internal target numbers requires updating every internal Needs/Dependencies reference, the build overview, Worked examples, and Suggested.lean's missing-carrier explanation. This branch has not been proposed upstream, but external/main references to its IDs should still be checked in the complete inventory.
5. `Suggested.lean` never imports another roadmap, even a merged one. It imports `Mathlib` and only native pinned TauCeti modules actually used. A docstring-only module remains permitted when none of the actual headline carriers exists at the pins; state the limitation accurately.

## Complete inventory and exact-head evidence

The inventory should record every current open PR through the terminal empty/short page, and all changed-file pages for each PR. For every touched roadmap folder, read its head README; retain the head SHA and full relative path, including nested or completed folders. Search by mathematical object as well as title, and read full candidate sections once selected. Maintain separate categories for additions, revisions, deletions, renamed folders, and stale duplicate additions.

The inventory agent is currently collecting this data. An assertion that all open PRs were checked must wait for that collection and its coverage count. A complete public PR inventory does not imply access to the worker's internal board packages or official merge order; any unavailable board data remains an explicit limitation.

The worker offers useful pure analysis functions on the collected text:

- `overlaps.neighbours(texts, readme, own='QuantumAffineAlgebras')` for vocabulary neighbours among open heads; use `on_main=True` for main.
- `overlaps.subject_neighbours(texts, readme, own='QuantumAffineAlgebras')` for named-result/heading neighbours, independent of shared supplier prose.
- `overlaps.readme_facts(...)` for dropped IDs and newly introduced revision-only IDs, if the inventory is materialized in the worker mirror/index format; otherwise use its `Revision` and citation predicates on the exact main/base/head texts.
- `openroadmaps.resolve(...)` for citation/name leads when a worker-compatible mirror exists. Its result is a lead, not proof of semantic contract agreement: check the statement, hypotheses and scope manually.

## Unmodified gate configuration

The earlier `run-gate.py` included main suppliers only, no `sibling_readmes` and no `open_readmes`. It therefore did **not** verify cycles or ownership against unmerged heads. That limitation must be superseded, not silently reinterpreted as a completed earlier check.

`GateOptions` at the pinned worker explicitly supports:

```python
GateOptions(
    order=proposed_order,
    merged=actual_main_roadmap_names,
    sibling_readmes=exact_owner_readmes,
    open_readmes=all_main_and_open_texts,
    pull_request=0,
    tauceti_sources=root / '.lake/packages/TauCeti/TauCeti',
)
```

Here:

- `merged` is computed from the actual main tree, including nested active and completed folders. Use `gates.roadmap_names(paths, ('TauCetiRoadmap', 'Completed'))` rather than the old top-level-only comprehension. Open PR additions are not merged.
- `sibling_readmes` maps actual roadmap names to the chosen main/eligible-open owner text. The candidate's text is installed by the gate itself. Main suppliers are read from main, not an unmerged revision.
- `open_readmes` contains `(where, name, text)` for every main and open roadmap snapshot. `where` is exactly `'main'` or `'#123'`. Preserve each open PR's complete touched-folder grouping, including stacked PRs; `depgraph.open_cycles` checks PR-level waits and uses the oldest adding PR for duplicate new folders.
- `pull_request=0` is correct while no PR exists for the candidate.
- `proposed_order` is a local, explicitly labelled proposed order, not the project's official board order. Put the direct/transitive eligible open suppliers before the candidate and validate their induced dependency subgraph. Include the universe of known names so no named supplier disappears from token recognition. Do not claim an official intake placement.

The built-in `depgraph.check_order` only reports an edge's position when its supplier occurs in `order`; an extra assertion should report any candidate/direct-transitive supplier omitted from both `merged` and the proposed order. This is additional validation, not a change to the gate or a suppression. A topological check of the candidate's complete open-supplier closure prevents an arbitrary “all open items first” order from hiding a cycle or unresolved precedence. Full `open_cycles` then checks cycles arising through all other open PRs.

Run the full unmodified `run_gate` on the clean **committed** primary branch with the default three-file allowance, no outside-folder allowance, statement hygiene enabled, `base='upstream/main'`, and `build_cmd='lake build {module}'`. Keep the primary diff confined to `TauCetiRoadmap/QuantumAffineAlgebras/`. Store the inventory and review evidence outside that tree/on the review branch. Record the exact candidate commit and all three file hashes in the resulting JSON.

## Acceptance of the revision

The final review must explicitly resolve both author points: the old search coverage was insufficient, and the subject/general-supplier boundary is corrected in the actual statements. Recheck every changed mathematical statement and supplier contract, and trace their transitive prerequisites for a noncircular construction through all affine types.

The existing mathematical review and rank-one computations may remain valid for unchanged passages, but their exact old hash must not be presented as acceptance of the new file. Add a new delta review, named source/ownership comparisons, all changed checks, updated source-independence counts when target text changes, the exact build result and enhanced gate record. If a precise declared supplier gap remains, state `accepted` **conditional on those named gaps** and include `conditional_gaps`; never claim the missing contract already exists.

No upstream PR, comment, review request or board write is authorized by this preparation task. A locally accepted corrected roadmap and pushed fork commits are the requested outcome.
