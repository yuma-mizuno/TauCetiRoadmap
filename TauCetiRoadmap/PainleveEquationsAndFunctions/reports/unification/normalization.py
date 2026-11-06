"""Explicit address changes for a lossless one-roadmap consolidation.

Bare literature/section numerals are deliberately not rewritten. Each body
retains its declared local namespace; explicit cross-part references override it.
"""
import re

PARTS = [
    ('N', 'NonlinearConnections', 'frameworks/NonlinearConnections', 'framework'),
    ('M', 'MeromorphicConnectionModuli', 'frameworks/MeromorphicConnectionModuli', 'framework'),
    ('A', 'AnalyticRHPAndDeterminants', 'frameworks/AnalyticRHPAndDeterminants', 'framework'),
    ('C', 'AlgebraicConfluence', 'frameworks/AlgebraicConfluence', 'framework'),
    ('P', 'PainleveEquationsAndFunctions', '.', 'application'),
    ('G', 'FiveLogarithmicPoints', 'applications/FiveLogarithmicPoints', 'application'),
]
PREFIX = {name: prefix for prefix, name, _, _ in PARTS}

def rewrite_text(value, prefix):
    """Change named internal addresses, never mathematical coefficients/locators."""
    out = value
    for name, p in PREFIX.items():
        out = re.sub(r'(?:framework|application):' + re.escape(name) + r'/(\d+\.\d+)',
                     lambda m: 'target:' + p + m.group(1), out)
        out = re.sub(r'(?<![A-Za-z])' + re.escape(name) + r'/(\d+\.\d+)',
                     lambda m: p + m.group(1), out)
        # Named section references keep the namespace name and give explicit IDs.
        pattern = (r'(' + re.escape(name) + r'\s+(?:§§?\s*)?)'
                   r'(\d+\.\d+(?:(?:\s*[–—,/]\s*|\s+and\s+)\d+\.\d+)*)')
        out = re.sub(pattern, lambda m: m.group(1) +
                     re.sub(r'\d+\.\d+', lambda n: p+n.group(0), m.group(2)), out)
    out = re.sub(r'target:(\d+\.\d+)', lambda m: 'target:'+prefix+m.group(1), out)
    return out

def map_ref(value, prefix):
    if value.startswith(('roadmap:', 'foundation:', 'mathlib:', 'gap:')):
        return value
    return rewrite_text(value, prefix)

