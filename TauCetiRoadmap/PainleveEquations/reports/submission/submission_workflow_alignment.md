# Submission workflow alignment

Date: 2026-11-06. Read-only inspection by the geometry/dependency review agent.

## Result

Three neighboring merged PRs were inspected: two new roadmaps and one foundation extension. Their metadata, returned discussion timelines, and changed-file lists were read. This satisfies the bounded neighboring-PR check. The official **Getting started: roadmaps** Zulip topic could not be read; complete compliance with that reading requirement is therefore **not claimed**.

The frozen Painlevé core was not edited. No PR, approval, label, comment or external message was created.

## Normative guidance

The source is [CONTRIBUTING.md at upstream commit ffac5139](https://github.com/TauCetiProject/TauCetiRoadmap/blob/ffac5139fe4794a132eb540a89e1b973070aad69/CONTRIBUTING.md), especially *Getting started*, *Opening a pull request*, the label convention and *Resolving review conversations*.

It requires nearby merged examples, the official Zulip topic, exact dependency grounding, model attribution and careful reading by the submitting person. A new roadmap PR targets main, changes only its own directory, and includes topic metadata. Labels are manual; a successful build and a roadmap-reviewers approval are the merge gates. These are repository rules, not conclusions inferred from the example PRs.

## Merged examples

| PR | Verified status | Files | Primary discussion inspected |
| --- | --- | --- | --- |
| [#953: ComplexKahlerGeometry](https://github.com/TauCetiProject/TauCetiRoadmap/pull/953) | Merged 2026-10-19 19:44:23 UTC; merge e1e11cfe6ae2505dab06d18a4ff739dd7f7a1bfc | Three files, all in ComplexKahlerGeometry | [Five initial findings](https://github.com/TauCetiProject/TauCetiRoadmap/pull/953#issuecomment-6222639714), [follow-up with one remaining ownership correction](https://github.com/TauCetiProject/TauCetiRoadmap/pull/953#issuecomment-6254097451), [author correction](https://github.com/TauCetiProject/TauCetiRoadmap/pull/953#issuecomment-6258302454) |
| [#881: FormalLaurentPuiseux](https://github.com/TauCetiProject/TauCetiRoadmap/pull/881) | Merged 2026-10-14 09:01:01 UTC; merge 7b79230b1b5b8e06c896ba99dae9a79c77ecf483 | README, Suggested.lean and metadata, all in FormalLaurentPuiseux | PR description and [bodyless APPROVED event](https://github.com/TauCetiProject/TauCetiRoadmap/pull/881#pullrequestreview-5513864486) |
| [#1110: SchemeAndStackFoundations extension](https://github.com/TauCetiProject/TauCetiRoadmap/pull/1110) | Merged 2026-10-19 11:49:56 UTC; merge ec5a26751ea72719592d12967250d106490f1a25 | One README in SchemeAndStackFoundations | [Mathematical/interface review](https://github.com/TauCetiProject/TauCetiRoadmap/pull/1110#pullrequestreview-5570642357), [separate approval event](https://github.com/TauCetiProject/TauCetiRoadmap/pull/1110#pullrequestreview-5570928274), [label-permission note](https://github.com/TauCetiProject/TauCetiRoadmap/pull/1110#issuecomment-6256297800) |

All three target main, have state closed and merged=true in retrieved metadata, and touch only their respective area's directory. The third is an extension, not another new-area submission.

### ComplexKahlerGeometry

The substantive review required an accessible supplier contract, a missing existence theorem, componentwise rank assembly, a source-convention adapter, and a corrected surface-theory dependency. The follow-up closed those five findings but preserved a later ownership defect until its corrective commit. This is direct precedent for exact source boundaries and checking the revised snapshot rather than treating a previous pass as universal closure.

For the Painlevé submission, preserve the reviewed owned constructions, exact external supplier references, fixed-model hypotheses and comparison lemmas. Keep the R1–R3 closure history outside the timeless specification. Historical supplier proposals mentioned in this PR are not evidence that those suppliers exist on current main.

### FormalLaurentPuiseux

The description names native carriers and the neighboring owner of geometric completion/residue transport, reports focused validation, attributes authoring and review models, and distinguishes prototype signatures from future mathematical work. Its returned review discussion has no detailed reviewer prose: only a bodyless approval. No additional mathematical rationale can be inferred.

This supports a focused Painlevé PR description that states scope, native floor, ownership boundaries, actual validation and actual model usage. Prototype compilation remains signature evidence.

### SchemeAndStackFoundations extension

The review tests the additional proof route for a theorem beyond the integral source theorem, rather than accepting a silently weakened hypothesis. It distinguishes an AI-assisted textual verdict submitted as COMMENTED from the later repository APPROVED event. The public coordination note records inability to apply awaiting-review.

The corresponding Painlevé conventions are to own every extension beyond a source's scope, report internal review as internal review, and accurately disclose a label-permission limitation if one applies at publication. None of those events or permissions is inferred for this draft.

## Official Zulip reading: access limitation

The required topic is [Getting started: roadmaps](https://leanprover.zulipchat.com/#narrow/channel/610393-Tau-Ceti/topic/Getting.20started.3A.20roadmaps/with/614905192).

- The official web page returned only an unsupported-browser/error-loading shell, without discussion text.
- The corresponding public archive topic URL returned HTTP 404.
- An unauthenticated read of the official messages API for that exact channel/topic returned HTTP 401.

The topic remains unread. Its contents are not reconstructed from search results or the repository checklist. The submitting human should read it before publication, or provide accessible text for a final check.

## Publication implications

The Painlevé-only diff, exact mathematical ownership, honest admission/build distinction and snapshot-specific review closure are consistent with the inspected examples. The PR description should name the actual models and give the current human-read and subject-expert-review status without implying endorsement.

If publication is authorized later, target main, apply awaiting-review or disclose an actual labeling limitation, and respond explicitly to every external review thread. Our local pass and build results do not constitute external review or a merge-triggering approval.

This check does not rerun historical CI, re-review all mathematics in the examples, or change the scope of the frozen Painlevé manuscript. Detailed metadata and source links are retained in the companion JSON.

