"""Materialize the complete affine roadmap and declared supplier gaps as plan data.

All mathematical prose/API/checks and gap needs are copied from this author's
README, not from source publications. The explicit dependency and locator maps
below are reviewed planning metadata, not declarations at the Lean pins.
"""
from pathlib import Path
import hashlib
import json
import re
import subprocess
import sys
import tomllib

workspace = Path('/workspace/scratch/889845af25ea')
root = workspace / 'TauCetiRoadmap'
prep = workspace / 'preparation/QuantumAffineAlgebras'
readme_path = root / 'TauCetiRoadmap/QuantumAffineAlgebras/README.md'
text = readme_path.read_text()
sys.path.insert(0, str(workspace / 'TauCetiRoadmapWorker'))
from tauceti_roadmap_worker.lanes.design import validate_plan, design_summary

LOCAL = {
    '1.1': [], '1.2': ['1.1'],
    '2.1': ['1.1','1.2'], '2.2': ['1.1','1.2','2.1'], '2.3': ['1.2','2.1','2.2'],
    '3.1': ['1.2','2.3'], '3.2': ['1.1','2.1','3.1'],
    '4.1': ['1.1','1.2'], '4.2': ['1.1','1.2','4.1'],
    '4.3': ['1.1','2.3','3.1','3.2','4.1','4.2'], '4.4': ['2.1','2.2','2.3','4.3'],
    '5.1': ['1.1','1.2','2.1','2.2','2.3','3.2'], '5.2': ['4.2','4.3','4.4','5.1'],
    '5.3': ['2.3','3.1','3.2','5.1','5.2'],
    '6.1': ['2.2'], '6.2': ['6.1'], '6.3': ['2.3','5.2','6.1','6.2'], '6.4': ['4.4','6.1','6.2','6.3'],
    '7.1': ['2.2','2.3','3.1','4.2','4.3','5.2','6.3'], '7.2': ['2.2','2.3','5.3','6.1','7.1'],
    '7.3': ['2.3','5.2','5.3','6.3','7.1','7.2'], '7.4': ['5.3','6.4','7.2','7.3'],
    '8.1': ['2.1','2.2','2.3','6.1','6.3','7.1'], '8.2': ['4.3','5.2','5.3','7.1','7.2','8.1'],
    '9.1': ['7.1','7.3','8.1'], '9.2': ['6.1','6.3','7.2','7.3','7.4','9.1'],
    '9.3': ['6.3','6.4','8.1','9.1','9.2'], '9.4': ['6.1','7.3','8.1','9.1','9.2','9.3'],
}
ROADMAP = {
    '1.1': ['KacMoody §§0.1–0.3 and 2.1'],
    '1.2': ['QuantumEnvelopingAlgebras §§1.1–1.3a'],
    '2.1': ['QuantumEnvelopingAlgebras §1.3a'],
    '2.3': ['QuantumGroups §8.5'],
    '4.1': ['QuantumEnvelopingAlgebras §§1.1–1.3a and 2.1'],
    '5.1': ['QuantumEnvelopingAlgebras §§1.4–1.5'],
    '6.1': ['GrothendieckEulerForms §§1.1–1.4'],
    '6.3': ['GrothendieckEulerForms §§1.1–1.4 and 2.3'],
    '9.1': ['ClusterAlgebras §§1.1–1.4 and 2.3'],
    '9.2': ['ClusterAlgebras §1.1'],
    '9.3': ['ClusterAlgebras §§1.1–1.4 and 2.3'],
    '9.4': ['ClusterAlgebras §§1.1–1.4 and 2.3'],
}
NATIVE = {
    '1.1': ['mathlib:Module.reflection'],
    '1.2': ['mathlib:Algebra.adjoin','mathlib:RingQuot','mathlib:ModuleCat.restrictScalars'],
    '2.1': ['tauceti:TauCeti.FiniteHopfModuleCat','mathlib:Submodule','mathlib:IsSimpleModule'],
    '2.2': ['mathlib:isNoetherian_of_tower','mathlib:isArtinian_of_tower','mathlib:CategoryTheory.Abelian','mathlib:CategoryTheory.EssentiallySmall'],
    '2.3': ['tauceti:TauCeti.FiniteHopfModuleCat','mathlib:TensorProduct','mathlib:Module.Dual'],
    '3.1': ['mathlib:AlgEquiv'],
    '3.2': ['mathlib:LaurentPolynomial','mathlib:LaurentPolynomial.eval₂','mathlib:Localization.AtPrime','mathlib:TensorProduct'],
    '4.1': ['mathlib:ModuleCat.restrictScalars'],
    '4.2': ['mathlib:jacobson_density','mathlib:TensorProduct'],
    '4.4': ['tauceti:TauCeti.jordanHolderMultiplicity'],
    '5.1': ['mathlib:LaurentSeries'],
    '5.3': ['mathlib:Polynomial','mathlib:Localization.AtPrime'],
    '6.1': ['tauceti:TauCeti.jordanHolderMultiplicity','tauceti:TauCeti.jordanHolderMultiplicity_eq_add_of_exact','tauceti:ModuleCat.prop_of_isFiniteLength','tauceti:TauCeti.AbelianK0'],
    '6.2': ['mathlib:Localization.AtPrime','tauceti:TauCeti.AbelianK0.of_shortExact'],
    '6.3': ['tauceti:TauCeti.ExactK0.instRing','tauceti:TauCeti.ExactK0.liftRingHom','tauceti:TauCeti.ExactK0.mapRingHom'],
    '6.4': ['mathlib:MvPolynomial'],
    '8.1': ['mathlib:CategoryTheory.ObjectProperty.FullSubcategory'],
    '8.2': ['mathlib:Polynomial'],
}
HYPOTHESES = {
    '1.1': ['Finite nonempty indecomposable symmetrizable affine Cartan datum, full integral weight/coweight lattices, and the standard node specified in Conventions, including the A₂ₙ⁽²⁾ convention.'],
    '1.2': ['The full generic quantum enveloping algebra of the supplied affine datum, with the stated symmetrizer and Hopf normalization.'],
    '2.1': ['A left U′-module; membership in 𝒞 additionally requires scalar finite dimension, the Pcl-indexed type-1 decomposition and integrability as stated.'],
    '2.2': ['An object of 𝒞; level zero and finite length are conclusions, not extra hypotheses.'],
    '2.3': ['Objects and morphisms of 𝒞, with the native tensor/duality structures; for the intersection lemma the three ambient objects and the stated two submodules and containment.'],
    '3.1': ['A nonzero spectral parameter a∈k× and a U′-module in the stated category.'],
    '3.2': ['A Pcl-weight U′-module M; finite freeness of Laurent rank dim M uses M∈𝒞; specialization is at a≠0.'],
    '4.1': ['A full affine weight λ∈P over F₀=ℚ(q), the supplied universal integrable extremal module, and t∈ℤ for the δ-lift comparison.'],
    '4.2': ['The supplied rational global-basis model; the simplicity, multiplicity and weight-support assertions require λ basic and level zero; the scalar-extension lemma requires scalar endomorphism algebra.'],
    '4.3': ['i∈I₀, the period mᵢ and basic weight πᵢ of §1.1, the extremal structure of §4.2, and nonzero a,b for spectral isomorphism.'],
    '4.4': ['A finite ordered family of actual fundamental spectral modules; the classification is of nonzero simple type-1 objects of 𝒞.'],
    '5.1': ['M,N∈𝒞, an independent formal spectral variable, the supplied completed canonical element, and the specified compatible choice of roots of q for rational weight pairings.'],
    '5.2': ['Nonzero simple M,N∈𝒞, nonzero chosen dominant extremal vectors, and the formal/field spectral extensions of §5.1.'],
    '5.3': ['Simple pairs have normalized rational intertwiners by §5.2; for nonsimple pairs rational renormalizability is an explicit conditional hypothesis, with closure and nonvanishing hypotheses stated in the target.'],
    '6.1': ['A unital k-algebra A, not necessarily Artinian, and A-modules finite-dimensional over k; a compared full subcategory is closed under subquotients and finite sums.'],
    '6.2': ['A unital k-algebra A, R=k[z]_(z−1), t=z−1, F=k(z), two A⊗R-modules finite free over R, and an A⊗F-linear isomorphism of their generic fibres.'],
    '6.3': ['The actual abelian, essentially small, biexact tensor category 𝒞, with simple-class coordinates and rational generic intertwiners; no braiding is assumed.'],
    '6.4': ['Σ is the set of actual fundamental spectral isomorphism classes; the exact commutative ring, classifier and lower-weight constituent statements have been constructed.'],
    '7.1': ['The predicates are on nonzero simple objects of 𝒞; the unit is excluded from prime objects; realness is simplicity of the tensor square.'],
    '7.2': ['M is real simple and N is simple for the main head/socle theorem; the self-R criterion is separately stated with its scalar-self-map hypothesis.'],
    '7.3': ['A finite family of nonzero simple objects of 𝒞; pairwise tensor simplicity is the criterion; repeated factors in real tensor monomials satisfy realness.'],
    '7.4': ['An exact sequence 0→X→M⊗N→Y→0 with M,N,X,Y simple, M real, and X⊗N and Y⊗N simple.'],
    '8.1': ['An arbitrary generating family in 𝒞; the closure contains the unit and is replete and closed under the operations specified in the statement.'],
    '8.2': ['Actual fundamental classes Σ including twisted spectral identifications; the edge relation concerns distinct vertices, and a connected component σ₀ is chosen.'],
    '9.1': ['𝒟 is as in §8.1, J is finite or countable, Jex⊆J, the exchange matrix has finite column supports and skew-symmetric principal part, and its objects are pairwise strongly commuting real simples.'],
    '9.2': ['A monoidal seed and a mutable vertex; categorical mutation requires the stated replacement and two exact sequences, while admissibility assumes only the first sequence with a simple replacement commuting with unchanged objects.'],
    '9.3': ['A supplied categorical mutation and an injective ring realization identifying the seed classes, or the stated algebraic independence; finite-word comparison assumes the corresponding mutations exist.'],
    '9.4': ['An ordinary geometric cluster algebra with noninverted frozen coefficients, 𝒟 as in §8.1, and a specified ring isomorphism; the sufficient criterion explicitly assumes categorical mutation coverage for every finite word.'],
}
LOCATORS = {
    '1.1': ('K02','§4.1, pp.11–17; §5.2, (5.3), (5.6), pp.19–24'),
    '1.2': ('KKOP20','Definition 2.2 and (2.2), pp.6–7'),
    '2.1': ('KKOP20','§2.1, p.7'), '2.2': ('AK97','§1.2, p.5'),
    '2.3': ('KKOP20','§2.1, p.8; Lemma 2.10'),
    '3.1': ('AK97','§1.2, pp.4–5'), '3.2': ('K02','§4.2, p.16'),
    '4.1': ('K02','§3.1, pp.8–9; §4.1; the normalized δ-lift comparison is derived here from the supplied universal property'),
    '4.2': ('K02','§2.4, Definitions 2.2–2.3; Theorem 5.5, Propositions 5.8, 5.12, 5.15 and 5.16'),
    '4.3': ('K02','Definition 4.9, Lemma 4.11, Proposition 4.12, (5.6)–(5.7) and Theorem 5.17, pp.24–25'),
    '4.4': ('AK97','Theorem 1.2, p.6, restricted to type-1 integrable objects; all CP95/CP98 proof locators remain in the target text'),
    '5.1': ('K02','§7, pp.29–31'),
    '5.2': ('K02','Lemma 8.1, Theorems 9.1–9.2, Propositions 9.3–9.5'),
    '5.3': ('KKOP20','§2.2, (2.8)–(2.13), pp.10–11; Propositions 2.11(ii)–(iii) and 2.12'),
    '6.1': ('native-TauCeti','TauCeti/RingTheory/CompositionSeries/Multiplicity.lean:217; Additivity.lean:154; Algebra/Category/ModuleCat/FiniteLength.lean:30; the target descends those multiplicities, not an Artinian-ring simple-basis theorem'),
    '6.2': ('authored-proof','QuantumAffineAlgebras README §6.2: lattice containment, t-power torsion quotient, reduction exact sequence and kernel/cokernel equality; this is the complete authored proof, not an external-source attribution'),
    '6.3': ('KKOP20','§2.1, p.7, for the resulting commutative ring; the local-lattice proof is the authored argument of §§6.1–6.2'),
    '6.4': ('CP95','Proposition 3.4 and Corollary 3.5 for the triangular constituent input; the polynomial-ring presentation is deduced in this target'),
    '7.1': ('KKOP20','Definition 2.4 and following paragraph, p.9'),
    '7.2': ('KKKO15','Theorem 3.12 and Corollaries 3.14, 3.16; the extra Hom-dimension proof is the target’s stated KKOP20 Theorem 2.13 argument'),
    '7.3': ('H10','Theorem 1.1; generic-field formulation explicitly taken from KKOP20 §2.1, p.9'),
    '7.4': ('KKOP20','Proposition 4.9(ii), p.27'),
    '8.1': ('KKOP20','§6, p.32'), '8.2': ('KKOP22','§2.2, pp.12–14'),
    '9.1': ('KKOP20','Definition 6.1, p.32'),
    '9.2': ('KKOP20','Definitions 6.2–6.3 and Proposition 6.4(i), pp.32–33'),
    '9.3': ('KKOP22','§7.1 and Definition 7.3; the exchange comparison is deduced from the stated exact sequences'),
    '9.4': ('KKOP20','Introduction, pp.2–3'),
}
GAP_TARGETS = {
    'integrable-string-decomposition': 'Proposed target: type-1 integrable rank-one strings',
    'universal-extremal-module': 'Proposed target: universal integrable extremal modules',
    'extremal-global-basis-model': 'Proposed target: rational global-basis models of extremal modules',
    'crystal-schubert-strata': 'Proposed target: Schubert strata of the negative-half crystal',
    'crystal-tensor-rule': 'Proposed target: tensor products of crystal lattices',
    'completed-canonical-element': 'Proposed target: completed canonical element extending the homogeneous pairings of §§1.4–1.5',
}
THEOREMS = {'2.2','4.2','4.4','5.2','6.1','6.2','6.3','6.4','7.2','7.3','7.4','9.2','9.3'}
DEFINITIONS = {'7.1','9.1','9.4'}


def section(title):
    match = re.search(r'^## ' + re.escape(title) + r'\n(.*?)(?=^## |\Z)', text, re.M | re.S)
    return match.group(1).strip() if match else ''


def bullets(body):
    return [re.sub(r'\s+', ' ', item.strip()) for item in re.split(r'(?m)^- ', body)[1:]]


def test_kind(body):
    low = body.lower()
    if any(w in low for w in ['would fail','cannot','nonexample','not type','wrong','does not','would give']):
        return 'non-example'
    if any(w in low for w in ['zero module','empty','λ=0','λ = 0','the unit']):
        return 'degenerate'
    if any(w in low for w in ['dimension','matrix','coefficient','rank','a₁','a₂','d₄']):
        return 'computation'
    return 'compatibility'


source_ids = {'K91','K94','K02','AK97','CP95','CP98','KKKO15','KKOP20','KKOP22','H10'}
source_pattern = re.compile(r'\b(?:' + '|'.join(sorted(source_ids, key=len, reverse=True)) + r')\b')
layers = []
target_lookup = {}
for lm in re.finditer(r'^## Layer (\d+): ([^\n]+)\n(.*?)(?=^## |\Z)', text, re.M | re.S):
    layer = {'key': lm[1], 'title': lm[2], 'targets': []}
    body = lm[3]
    for tm in re.finditer(r'^### (\d+\.\d+) ([^\n]+)\n(.*?)(?=^### |\Z)', body, re.M | re.S):
        tid, title, target_text = tm[1], tm[2], tm[3].strip()
        needs_split = re.split(r'\*Needs:\*\s*', target_text, maxsplit=1)
        target_body, needs_text = needs_split[0].strip(), needs_split[1].strip() if len(needs_split) > 1 else ''
        prechecks, check_text = target_body.split('**Checks.**', 1)
        if 'The API includes:' in prechecks:
            statement, api_text = prechecks.split('The API includes:', 1)
            api = [{'name': None, 'role': 'target API', 'statement': b} for b in bullets(api_text)]
        else:
            statement = prechecks
            api = []
        tests = [{'name': f'{tid}-check-{i}', 'kind': test_kind(b), 'statement': b}
                 for i, b in enumerate(bullets(check_text), 1)]
        assert len(tests) >= 3, (tid, len(tests))
        deps = [f'target:{x}' for x in LOCAL[tid]] + [f'roadmap:{x}' for x in ROADMAP.get(tid, [])] + NATIVE.get(tid, [])
        gap_slugs = sorted({g.rstrip('.') for g in re.findall(r'gap:([A-Za-z0-9][\w.-]*)', target_text)})
        deps.extend(f'gap:{g}' for g in gap_slugs)
        source, where = LOCATORS[tid]
        provenance = 'native-library-proof-inputs' if tid == '6.1' else 'authored-elementary-proof' if tid == '6.2' else 'primary-publication'
        target = {
            'id': tid, 'kind': 'theorem' if tid in THEOREMS else 'definition' if tid in DEFINITIONS else 'construction',
            'name': None, 'title': title, 'statement': statement.strip(),
            'hypotheses': HYPOTHESES[tid], 'standing_hypotheses': 'Conventions, reproduced in the top-level conventions field',
            'locator': {'source': source, 'where': where, 'provenance_kind': provenance},
            'reference_passages': [p.strip() for p in target_text.split('\n\n') if source_pattern.search(p)],
            'prerequisites': list(dict.fromkeys(deps)), 'prerequisite_text': needs_text,
            'api': api, 'tests': tests, 'readme_section': tid,
        }
        layer['targets'].append(target)
        target_lookup[tid] = target
    examples = re.search(r'^### Examples\n(.*?)(?=^### |\Z)', body, re.M | re.S)
    dependencies = re.search(r'^### Dependencies\n(.*?)(?=^### |\Z)', body, re.M | re.S)
    layer['examples'] = examples[1].strip() if examples else ''
    layer['dependencies_text'] = dependencies[1].strip() if dependencies else ''
    layers.append(layer)

assert set(target_lookup) == set(LOCAL) == set(HYPOTHESES) == set(LOCATORS), 'Target map drift: update the reviewed metadata maps'
contracts = section('Exact supplier contracts')
gaps = []
gap_pattern = r'^What ([A-Za-z][A-Za-z0-9]*) must provide \(gap:([A-Za-z0-9][\w.-]*)\):\s*(.*?)(?=^What |^### |^These contracts|\Z)'
for gm in re.finditer(gap_pattern, contracts, re.M | re.S):
    supplier, slug, detail = gm[1], gm[2], gm[3].strip()
    flat = re.sub(r'\s+', ' ', detail)
    needs = flat[:flat.index('.') + 1]
    needed_by = [tid for tid,t in target_lookup.items() if f'gap:{slug}' in t['prerequisites']]
    gaps.append({'slug': slug, 'title': GAP_TARGETS[slug].removeprefix('Proposed target: '),
                 'neededBy': needed_by, 'detail': detail, 'needs': needs,
                 'supplier': supplier, 'section': GAP_TARGETS[slug],
                 'status': 'declared supplier contract, not an assertion that a target exists',
                 'readme_contract_sha256': hashlib.sha256(detail.encode()).hexdigest()})
assert set(GAP_TARGETS) == {g['slug'] for g in gaps}, 'Gap-list drift'

suppliers = []
for sm in re.finditer(r'^### From TauCetiRoadmap\.([^\n]+)\n(.*?)(?=^### |\Z)', contracts, re.M | re.S):
    supplier, what = sm[1], sm[2].strip()
    consumed = [r.removeprefix(supplier + ' ') for refs in ROADMAP.values() for r in refs if r.startswith(supplier + ' ')]
    suppliers.append({'roadmap': supplier, 'sections': list(dict.fromkeys(consumed)), 'what': what,
                      'declared_gaps': [g['slug'] for g in gaps if g['supplier'] == supplier]})
pins = {p['name']:p['rev'] for p in json.loads((root/'lake-manifest.json').read_text())['packages']}
external_manifest = tomllib.loads((prep/'sources.toml').read_text())
assert {s['id'] for s in external_manifest['source']} == source_ids
plan = {
    'roadmap': 'QuantumAffineAlgebras', 'title': text.splitlines()[0].removeprefix('# Roadmap: '), 'parent': None,
    'summary': text.split('**Summary.**',1)[1].split('\n## Scope and ownership',1)[0].strip(),
    'baseline': {'mathlib': pins['mathlib'], 'tauceti': pins['TauCeti']},
    'conventions': section('Conventions'), 'scope_and_ownership': section('Scope and ownership'),
    'layers': layers, 'suppliers': suppliers,
    'consumers': [{'roadmap': None, 'what': b} for b in bullets(section('Downstream consumers'))],
    'gaps': gaps,
    'native_contracts': {m[1]:m[2].strip() for m in re.finditer(r'^### From (Mathlib|Tau Ceti)\n(.*?)(?=^### |\Z)', contracts, re.M | re.S)},
    'worked_compatibility_test': section('Worked compatibility test: A₁⁽¹⁾'),
    'references': section('References'),
    'provenance': {
        'primary_commit': subprocess.check_output(['git','rev-parse','HEAD'],cwd=root,text=True).strip(),
        'main_ownership_snapshot': subprocess.check_output(['git','rev-parse','upstream/main'],cwd=root,text=True).strip(),
        'readme_sha256': hashlib.sha256(text.encode()).hexdigest(),
        'external_source_ids': sorted(source_ids),
        'external_manifest': '../sources.toml',
        'internal_locator_sources': {
            'native-TauCeti': {'kind':'pinned-library-proof-inputs','pin':pins['TauCeti'],
                              'description':'Native modulewise multiplicity/additivity/induction inputs; the finite-dimensional categorical descent is the owned target.'},
            'authored-proof': {'kind':'authored-elementary-proof','section':'6.2',
                               'description':'Complete local-lattice proof in this roadmap; not a fetched or externally attributed source.'},
        },
        'locator_policy': 'External publication locators use the ten sources.toml IDs. The two explicitly typed internal proof locators are not fictitious publications and are not added to the external-source acquisition manifest.',
        'name_policy': 'No Lean declaration names are invented for the unavailable affine carriers; null name fields denote prose targets only.',
        'supplier_gap_policy': 'A proposed named target is a missing contract, not an installed numbered supplier section. KacMoodyPartII is the quantum successor named by main KacMoody and QuantumEnvelopingAlgebras scopes.',
    },
}
problems = validate_plan(plan, 'QuantumAffineAlgebras')
assert not problems, problems
all_ids = set(target_lookup)
for tid,t in target_lookup.items():
    assert all(float(dep.split(':',1)[1]) < float(tid) for dep in t['prerequisites'] if dep.startswith('target:'))
assert all(g['neededBy'] for g in gaps)
assert {g['slug'] for g in gaps} == {g.rstrip('.') for g in re.findall(r'gap:([A-Za-z0-9][\w.-]*)', text)}
destination = prep/'design'
destination.mkdir(exist_ok=True)
(destination/'plan.json').write_text(json.dumps(plan, indent=2, ensure_ascii=False)+'\n')
(destination/'README.md').write_text(text)
validation = {
    'validator':'unmodified tauceti_roadmap_worker.lanes.design.validate_plan',
    'problems': problems, 'readme_sha256':plan['provenance']['readme_sha256'],
    'plan_sha256':hashlib.sha256((destination/'plan.json').read_bytes()).hexdigest(),
    'summary':design_summary('QuantumAffineAlgebras', plan, text),
    'parent':None,'conditional_gaps':[g['slug'] for g in gaps],
    'all_local_dependencies_earlier':True,
    'internal_proof_locator_count':2,
}
(prep/'design-plan-validation.json').write_text(json.dumps(validation, indent=2, ensure_ascii=False)+'\n')
print(json.dumps(validation,indent=2,ensure_ascii=False))
