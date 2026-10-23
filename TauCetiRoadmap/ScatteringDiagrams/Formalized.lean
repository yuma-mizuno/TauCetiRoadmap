import TauCetiRoadmap.ScatteringDiagrams.Formalized.WallLieWords
import TauCetiRoadmap.ScatteringDiagrams.Formalized.CentralDefect
import TauCetiRoadmap.ScatteringDiagrams.Formalized.SweepGeometry
import TauCetiRoadmap.ScatteringDiagrams.Formalized.OutgoingGeometry
import TauCetiRoadmap.ScatteringDiagrams.Formalized.PathProductConnection
import TauCetiRoadmap.ScatteringDiagrams.Formalized.CentralKernelConnection
import TauCetiRoadmap.ScatteringDiagrams.Formalized.HeisenbergConnection
import TauCetiRoadmap.ScatteringDiagrams.Formalized.RationalSweepConnection
import TauCetiRoadmap.ScatteringDiagrams.Formalized.RankTwoSweepConnection
import TauCetiRoadmap.ScatteringDiagrams.Formalized.SpecificationStress

/-!
# Formalization stress test of the scattering roadmap

This root checks proposed roadmap arguments by complete Lean proofs. Connection
tests use the exact definitions from Suggested, and the dependency audit rejects
any use of its admitted results. `FORMALIZATION.md` records the questions
tested, their findings for the specification, and the connections still to test.
The intended artifact is evidence about the roadmap's mathematical adequacy.
-/
