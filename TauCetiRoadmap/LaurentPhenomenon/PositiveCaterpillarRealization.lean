/-
Copyright (c) 2026 Tau Ceti contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Tau Ceti contributors
-/
module

public import TauCetiRoadmap.LaurentPhenomenon.CoefficientChart
public import TauCetiRoadmap.LaurentPhenomenon.PositiveCaterpillar
public import TauCetiRoadmap.LaurentPhenomenon.FiniteTheorem

/-! # Positive Caterpillar Realization -/

@[expose] public section

noncomputable section
namespace TauCeti.Laurent
variable {G I F : Type*} [AddCommGroup G] [DecidableEq I] [Field F]
  [IsDomain (AddMonoidAlgebra ℤ (G × (I →₀ ℤ)))]
  {P : CaterpillarPath I}
namespace PositiveCaterpillar
variable (T : PositiveCaterpillar G P)

/-- The finite positive coordinate expressions obtained by mutation along the first n spine edges.
-/
def spineExpression : (n : ℕ) → n ≤ P.length → I → CoordinateExpression G I
  | 0, _ => initialCoordinateExpression
  | n + 1, hn =>
    mutateCoordinateExpressions
      (T.exchange (P.spine ⟨n, by omega⟩) (P.label ⟨n, by omega⟩))
      (T.exchange_ne_zero _ _) (P.label ⟨n, by omega⟩)
      (spineExpression n (by omega))

/-- The canonical finite coordinate expressions on the spine and on each attached leaf. -/
def vertexExpression : P.Vertex → I → CoordinateExpression G I
  | .inl k => T.spineExpression k.val (by have := k.isLt; omega)
  | .inr q =>
    mutateCoordinateExpressions (T.exchange (P.spine (P.internalIndex q.val.1)) q.val.2)
      (T.exchange_ne_zero _ _) q.val.2
      (T.spineExpression (q.val.1.val + 1) (by have := q.val.1.isLt; omega))

variable (f : AddMonoidAlgebra ℤ (G × (I →₀ ℤ)) →+* F)

/-- Evaluate a vertex's canonical positive coordinate expression through f. -/
def value (s : P.Vertex) (i : I) : F := (T.vertexExpression s i).evaluate f
omit [IsDomain (AddMonoidAlgebra ℤ (G × (I →₀ ℤ)))] in
theorem value_ne_zero
    (hf : ∀ p, positiveCast p ≠ 0 → f (positiveCast p) ≠ 0) (s : P.Vertex) (i : I) :
    T.value f s i ≠ 0 := expression_evaluate_ne_zero f hf _

omit [IsDomain (AddMonoidAlgebra ℤ (G × (I →₀ ℤ)))] in
theorem value_source (i : I) :
    T.value f P.source i = f (AddMonoidAlgebra.single (0, Finsupp.single i 1) 1) := by
  exact initialCoordinateExpression_evaluate f i

omit [IsDomain (AddMonoidAlgebra ℤ (G × (I →₀ ℤ)))] in
theorem value_path_forward (k : Fin P.length) :
    T.value f (P.spine ⟨k.val + 1, by omega⟩) =
      mutateCoordinateValues f (T.exchange (P.spine ⟨k.val, by omega⟩) (P.label k))
        (P.label k) (T.value f (P.spine ⟨k.val, by omega⟩)) := by
  funext i
  exact mutateCoordinateExpressions_evaluate f _ _ _ i _

omit [IsDomain (AddMonoidAlgebra ℤ (G × (I →₀ ℤ)))] in
theorem value_leaf_forward (q : P.Leaf) :
    T.value f (P.leaf q) =
      mutateCoordinateValues f (T.exchange (P.spine (P.internalIndex q.val.1)) q.val.2)
        q.val.2 (T.value f (P.spine (P.internalIndex q.val.1))) := by
  funext i
  exact mutateCoordinateExpressions_evaluate f _ _ _ i _

omit [IsDomain (AddMonoidAlgebra ℤ (G × (I →₀ ℤ)))] in
private theorem mutation_other (E : PositiveLaurent G I) (i k : I) (hk : k ≠ i) (x : I → F) :
    mutateCoordinateValues f E i x k = x k := by
  simp [mutateCoordinateValues, hk]

omit [IsDomain (AddMonoidAlgebra ℤ (G × (I →₀ ℤ)))] in
private theorem mutation_exchange (E : PositiveLaurent G I) (i : I) (x : I → F)
    (hx : x i ≠ 0) :
    mutateCoordinateValues f E i x i * x i = coordinateEvaluate f E x := by
  simp only [mutateCoordinateValues, Function.update_self]
  exact div_mul_cancel₀ _ hx

omit [IsDomain (AddMonoidAlgebra ℤ (G × (I →₀ ℤ)))] in
private theorem mutation_eval (E : PositiveLaurent G I) (i : I)
    (hE : PositiveIndependent E i) (x : I → F) :
    coordinateEvaluate f E (mutateCoordinateValues f E i x) = coordinateEvaluate f E x :=
  coordinateEvaluate_update f E i hE x _

omit [IsDomain (AddMonoidAlgebra ℤ (G × (I →₀ ℤ)))] in
/-- The constructed vertex values satisfy both orientations of every actual edge. -/
theorem value_edge
    (hf : ∀ p, positiveCast p ≠ 0 → f (positiveCast p) ≠ 0)
    {a b : P.Vertex} {i : I} (he : P.Edge a b i) :
    (∀ k, k ≠ i → T.value f b k = T.value f a k) ∧
    T.value f b i * T.value f a i = coordinateEvaluate f (T.exchange a i) (T.value f a) := by
  cases he with
  | path_forward k =>
    rw [T.value_path_forward f k]
    exact ⟨fun h hh => mutation_other f _ _ h hh _,
      mutation_exchange f _ _ _ (T.value_ne_zero f hf _ _)⟩
  | path_backward k =>
    have hv := T.value_path_forward f k
    have he := T.exchange_undirected (CaterpillarPath.Edge.path_forward (P := P) k)
    rw [← he, hv, mutation_eval f _ _ (T.exchange_independent _ _)]
    exact ⟨fun h hh => (mutation_other f _ _ h hh _).symm, by
      rw [mul_comm]
      exact mutation_exchange f _ _ _ (T.value_ne_zero f hf _ _)⟩
  | leaf_forward q =>
    rw [T.value_leaf_forward f q]
    exact ⟨fun h hh => mutation_other f _ _ h hh _,
      mutation_exchange f _ _ _ (T.value_ne_zero f hf _ _)⟩
  | leaf_backward q =>
    have hv := T.value_leaf_forward f q
    have he := T.exchange_undirected (CaterpillarPath.Edge.leaf_forward (P := P) q)
    rw [← he, hv, mutation_eval f _ _ (T.exchange_independent _ _)]
    exact ⟨fun h hh => (mutation_other f _ _ h hh _).symm, by
      rw [mul_comm]
      exact mutation_exchange f _ _ _ (T.value_ne_zero f hf _ _)⟩

/-- The exchange polynomial with its coefficients mapped to the actual coefficient image of f. -/
def realizedExchange (s : P.Vertex) (i : I) : MvPolynomial I (coefficientRange f) :=
  (positiveToPolynomial (T.exchange s i)).map (coefficientRangeMap f)

omit [DecidableEq I] [IsDomain (AddMonoidAlgebra ℤ (G × (I →₀ ℤ)))] in
theorem realizedExchange_independent (s : P.Vertex) (i : I) (m : I →₀ ℕ)
    (hm : (T.realizedExchange f s i).coeff m ≠ 0) : m i = 0 := by
  apply positiveToPolynomial_independent (T.exchange s i) i (T.exchange_independent s i) m
  intro hz
  apply hm
  simp [realizedExchange, MvPolynomial.coeff_map, hz]

omit [DecidableEq I] [IsDomain (AddMonoidAlgebra ℤ (G × (I →₀ ℤ)))] in
theorem realizedExchange_eval (s : P.Vertex) (i : I) (x : I → F) :
    MvPolynomial.eval₂ (coefficientRange f).subtype x (T.realizedExchange f s i) =
      coordinateEvaluate f (T.exchange s i) x := by
  rw [realizedExchange, MvPolynomial.eval₂_map]
  change MvPolynomial.eval₂ (f.comp coefficientInclusion) x
    (positiveToPolynomial (T.exchange s i)) = _
  exact positiveToPolynomial_eval f _ (T.exchange_polynomial s i) x

/-- A concrete field realization of the entire finite caterpillar, including
    both orientations of spine edges and every attached leaf. -/
def realized
    (hf : ∀ p, positiveCast p ≠ 0 → f (positiveCast p) ≠ 0) :
    RealizedCaterpillar (coefficientRange f) P where
  coord := T.value f
  coord_ne_zero := T.value_ne_zero f hf
  exchange := T.realizedExchange f
  exchange_independent := T.realizedExchange_independent f
  exchange_undirected he := by
    unfold realizedExchange
    rw [T.exchange_undirected he]
  other_coord he := (T.value_edge f hf he).1
  exchange_relation he := by
    rw [T.realizedExchange_eval f]
    exact (T.value_edge f hf he).2

omit [IsDomain (AddMonoidAlgebra ℤ (G × (I →₀ ℤ)))] in
@[simp] theorem realized_source
    (hf : ∀ p, positiveCast p ≠ 0 → f (positiveCast p) ≠ 0) (i : I) :
    (T.realized f hf).coord P.source i = f (AddMonoidAlgebra.single (0, Finsupp.single i 1) 1) :=
  T.value_source f i

omit [IsDomain (AddMonoidAlgebra ℤ (G × (I →₀ ℤ)))] in
/-- Every positive Laurent polynomial is nonzero at every realized vertex. -/
theorem value_positive
    (hf : ∀ p, positiveCast p ≠ 0 → f (positiveCast p) ≠ 0)
    (s : P.Vertex) (E : PositiveLaurent G I) (hE : E ≠ 0) :
    coordinateEvaluate f E (T.value f s) ≠ 0 :=
  coordinateEvaluate_ne_zero f hf E hE (T.vertexExpression s)

/-- The C6 specialization theorem for any vertex or leaf of the actual caterpillar. -/
theorem value_specialize_laurent
    (hf : ∀ p, positiveCast p ≠ 0 → f (positiveCast p) ≠ 0)
    (s : P.Vertex) (i : I) (r : AddMonoidAlgebra ℤ (G × (I →₀ ℤ)))
    (h : positiveFractionEmbedding (positiveCast (G := G × (I →₀ ℤ)))
      (T.vertexExpression s i).representatives.value =
      algebraMap _ (FractionRing (AddMonoidAlgebra ℤ (G × (I →₀ ℤ)))) r) :
    T.value f s i = f r :=
  PositiveExpression.specialize_laurent f hf _ r h

/-- Integer Laurent-ring specialization induced solely by a coefficient-group map. -/
def integerCoefficientMap {H : Type*} [AddCommGroup H] (η : G →+ H) :
    AddMonoidAlgebra ℤ (G × (I →₀ ℤ)) →+* AddMonoidAlgebra ℤ (H × (I →₀ ℤ)) :=
  AddMonoidAlgebra.mapDomainRingHom ℤ (η.prodMap (AddMonoidHom.id _))

omit [IsDomain (AddMonoidAlgebra ℤ (G × (I →₀ ℤ)))] in
theorem mutateCoordinateValues_natural {H : Type*} [AddCommGroup H]
    (η : G →+ H) (ψ : AddMonoidAlgebra ℤ (H × (I →₀ ℤ)) →+* F)
    (E : PositiveLaurent G I) (i : I) (x : I → F) :
    mutateCoordinateValues (ψ.comp (integerCoefficientMap (I := I) η)) E i x =
      mutateCoordinateValues ψ (coefficientMap η E) i x := by
  unfold mutateCoordinateValues integerCoefficientMap
  rw [coordinateEvaluate_natural]

section Naturality
variable {H : Type*} [AddCommGroup H]
  [IsDomain (AddMonoidAlgebra ℤ (H × (I →₀ ℤ)))]
  (η : G →+ H) (U : PositiveCaterpillar H P)
  (ψ : AddMonoidAlgebra ℤ (H × (I →₀ ℤ)) →+* F)
  (hE : ∀ {a b i}, P.Edge a b i → coefficientMap η (T.exchange a i) = U.exchange a i)

include hE

omit [IsDomain (AddMonoidAlgebra ℤ (G × (I →₀ ℤ)))] [IsDomain (AddMonoidAlgebra ℤ (H × (I →₀
  ℤ)))] in
/-- Only actual incident exchange polynomials need specialize on the spine. -/
theorem value_spine_natural (k : Fin (P.length + 1)) :
    T.value (ψ.comp (integerCoefficientMap (I := I) η)) (P.spine k) =
      U.value ψ (P.spine k) := by
  obtain ⟨k, hk⟩ := k
  induction k with
  | zero =>
    funext i
    change T.value (ψ.comp (integerCoefficientMap (I := I) η)) P.source i = U.value ψ P.source i
    rw [T.value_source, U.value_source]
    simp [integerCoefficientMap]
  | succ k ih =>
    rw [T.value_path_forward _ ⟨k, by omega⟩, U.value_path_forward _ ⟨k, by omega⟩,
      ih (by omega), mutateCoordinateValues_natural]
    rw [hE (CaterpillarPath.Edge.path_forward (P := P) ⟨k, by omega⟩)]

omit [IsDomain (AddMonoidAlgebra ℤ (G × (I →₀ ℤ)))] [IsDomain (AddMonoidAlgebra ℤ (H × (I →₀
  ℤ)))] in
/-- Canonical actual caterpillar coordinates specialize, including every leaf. -/
theorem value_natural (s : P.Vertex) (i : I) :
    T.value (ψ.comp (integerCoefficientMap (I := I) η)) s i = U.value ψ s i := by
  cases s with
  | inl k => exact congrFun (T.value_spine_natural η U ψ hE k) i
  | inr q =>
    rw [show (Sum.inr q : P.Vertex) = P.leaf q from rfl,
      T.value_leaf_forward, U.value_leaf_forward,
      T.value_spine_natural η U ψ hE, mutateCoordinateValues_natural,
      hE (CaterpillarPath.Edge.leaf_forward (P := P) q)]

end Naturality
omit [IsDomain (AddMonoidAlgebra ℤ (G × (I →₀ ℤ)))] in
/-- Tree uniqueness from the source chart and the actual exchange recurrences. -/
theorem value_unique (y : P.Vertex → I → F)
    (hsource : ∀ i, y P.source i = f (AddMonoidAlgebra.single (0, Finsupp.single i 1) 1))
    (hother : ∀ {a b i}, P.Edge a b i → ∀ k, k ≠ i → y b k = y a k)
    (hexchange : ∀ {a b i}, P.Edge a b i →
      y b i = coordinateEvaluate f (T.exchange a i) (y a) / y a i)
    (s : P.Vertex) (i : I) : y s i = T.value f s i := by
  have hstep {a b : P.Vertex} {i : I} (he : P.Edge a b i) :
      y b = mutateCoordinateValues f (T.exchange a i) i (y a) := by
    funext k
    by_cases hki : k = i
    · subst k
      simpa [mutateCoordinateValues] using hexchange he
    · simpa [mutateCoordinateValues, hki] using hother he k hki
  have hspine (k : Fin (P.length + 1)) : y (P.spine k) = T.value f (P.spine k) := by
    obtain ⟨k, hk⟩ := k
    induction k with
    | zero =>
      funext i
      exact (hsource i).trans (T.value_source f i).symm
    | succ k ih =>
      rw [hstep (CaterpillarPath.Edge.path_forward (P := P) ⟨k, by omega⟩),
        T.value_path_forward f ⟨k, by omega⟩, ih (by omega)]
  cases s with
  | inl k => exact congrFun (hspine k) i
  | inr q =>
    rw [show (Sum.inr q : P.Vertex) = P.leaf q from rfl,
      hstep (CaterpillarPath.Edge.leaf_forward (P := P) q),
      T.value_leaf_forward, hspine]

omit [IsDomain (AddMonoidAlgebra ℤ (G × (I →₀ ℤ)))] in
/-- Compare an arbitrary polynomial realization to the constructed positive one.
    The hypothesis identifies only exchange evaluations, never Laurentness. -/
theorem realized_coord_unique {C : Subring F} (R : RealizedCaterpillar C P)
    (hsource : ∀ i, R.coord P.source i =
      f (AddMonoidAlgebra.single (0, Finsupp.single i 1) 1))
    (hE : ∀ {a b i}, P.Edge a b i → ∀ x,
      MvPolynomial.eval₂ C.subtype x (R.exchange a i) =
        coordinateEvaluate f (T.exchange a i) x)
    (s : P.Vertex) (i : I) : R.coord s i = T.value f s i := by
  apply T.value_unique f R.coord hsource (fun he => R.other_coord he) ?_ s i
  intro a b i he
  rw [R.exchange_formula he, hE he]

end PositiveCaterpillar
end TauCeti.Laurent
