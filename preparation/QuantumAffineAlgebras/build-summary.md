# Targeted Lean validation report

Status: targeted module build passed with exit code 0. This is an import/docstring-only namespace module; no absent mathematical declaration was elaborated or checked.

## Environment

- Lean: `4.36.0-rc2`, commit `b35cb10cf2ced51a2fd1880cfdbf75c71ab7a35a`, official Linux release.
- Lake: `5.0.0-src+b35cb10`.
- Repository: `/workspace/scratch/889845af25ea/TauCetiRoadmap`.
- Toolchain supplied via task-local `PATH`; no global installation or tracked configuration changes.
- Preparation command: `lake exe cache get Mathlib`.
- No `lake update` and no all-roadmap build.

## Dependency revisions

| Package | Manifest revision | Actual revision | Check |
|---|---|---|---|
| TauCeti | `2fd255d997f47c0b5d834ee416c7015d55444ce5` | `2fd255d997f47c0b5d834ee416c7015d55444ce5` | match |
| mathlib | `1b1ccf4b088b32fa3f23f2de1127433254a81e1e` | `1b1ccf4b088b32fa3f23f2de1127433254a81e1e` | match |
| plausible | `129d1ba9a16bc0660f46c79e9fb041ef5d5d80de` | `129d1ba9a16bc0660f46c79e9fb041ef5d5d80de` | match |
| LeanSearchClient | `c61286b7b63cbfd563b28e11e81d0a18233a044a` | `c61286b7b63cbfd563b28e11e81d0a18233a044a` | match |
| importGraph | `b8cc5dd0a36233b88a6ed5a7dbf1207d09338c60` | `b8cc5dd0a36233b88a6ed5a7dbf1207d09338c60` | match |
| proofwidgets | `16259c0d07d61ee37d999d05b5cf96338b8daa11` | `16259c0d07d61ee37d999d05b5cf96338b8daa11` | match |
| aesop | `7d11bfa88558f8d3d90afdf6bd877ed70001498d` | `7d11bfa88558f8d3d90afdf6bd877ed70001498d` | match |
| Qq | `b0256621cb88178e9ad932a53633077b3029e621` | `b0256621cb88178e9ad932a53633077b3029e621` | match |
| batteries | `6d971e7e6b3f7d0a501c5418815aa9022edd3499` | `6d971e7e6b3f7d0a501c5418815aa9022edd3499` | match |
| Cli | `c09cb1e4f1e6e1c231a1175a12b681b075054a1b` | `c09cb1e4f1e6e1c231a1175a12b681b075054a1b` | match |

## Tracked configuration fingerprints before target validation

- `lean-toolchain` SHA-256: `11c697aebe5b539d74f5069e497a588e7dfab1c4eeb74313f28357e351c55ca3`
- `lake-manifest.json` SHA-256: `03ba49c2dd5771394e4ff56b6569ba706a8caed03924900bf6419681cdd101b1`
- `lakefile.toml` SHA-256: `c1ae582f98b71e302ead58536423567e5d2654649261e686ce3c3b15fc240194`

## Cache preparation result

`lake exe cache get Mathlib` exited with status 0. The official cache supplied and decompressed all 9,111 requested files. Final output:

```text
Decompressed 9111 file(s)
Already decompressed 9111 file(s)
```

## Completed target validation

- Command: `lake build TauCetiRoadmap.QuantumAffineAlgebras.Suggested`.
- UTC start: `2026-11-17T06:06:13.697716+00:00`.
- UTC end: `2026-11-17T06:07:45.152777+00:00`.
- Exit code: `0`.
- Repository HEAD when invoked: `d3ac19d0a6b41289ce54bce02b4a31050a4cee42`.
- `Suggested.lean` SHA256: `bb9f98ed7b53837251bdbfe197011d622205bb40ad063a2b189ba765ff37b4a1`.
- Exact stdout/stderr and command/version records: `/workspace/scratch/889845af25ea/preparation/QuantumAffineAlgebras/build-log.txt`.
- Build-log SHA256: `97b3a9cd2bda5e0f9b12fde68a4a39c3df1c6aeea4cda32a9a9505c3a331f39a`.

Final build output:

```text
✔ [18238/18239] Built TauCetiRoadmap.QuantumAffineAlgebras.Suggested (32s)
Build completed successfully (18239 jobs).
```

The job count is the dependency graph for this target; no command to build all roadmap modules was run. `git diff --exit-code -- lean-toolchain lake-manifest.json lakefile.toml` succeeded after the build. The temporary log directory in the primary checkout was removed after moving its completed log to the external preparation directory; primary status then showed only the parent’s README edit.
