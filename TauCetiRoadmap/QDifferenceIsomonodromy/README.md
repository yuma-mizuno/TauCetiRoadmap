# Roadmap: q 差分方程式と等モノドロミー変形

**Summary.** 複素数 q を 0 < |q| ≠ 1 の範囲で固定し、任意の有限階数の有理 q 接続、その局所分類、大域接続データ、接続データを保存する離散変形を構成する。基本対象は有理関数体上の q 差分加群と、射影直線上のベクトル束 E に備わる有理型同型 A : E ⇢ σ_q*E である。σ_q(z) = qz とする。行列表現 Y(qz) = A(z)Y(z) は、この対象に基底を選んだ表示である。

局所分類の主定理は、共鳴と非半単純な正則特異部分を許し、有理数の傾きを持つ任意の局所 q 差分加群を扱う。傾きフィルトレーションと形式分類を構成し、指定した形式型とその同一視を持つ解析的同型類を、楕円曲線 E_q = ℂ×/q^ℤ 上の q-Stokes 層の第一非可換コホモロジーで分類する。整数傾きでは正規形と有限次元アフィン空間を与え、有限分岐と降下を通じて有理傾きへ進む。

大域比較の主定理は、0 と ∞ の局所解析 q 差分加群を保持し、それぞれの楕円曲線上の実現を結ぶ有理型同型を接続データとする。有理 q 差分加群の圏と、この接続データの圏の同値を、局所 Laurent 模型の延長、有理型行列の分解、射の貼り合わせから構成する。正則特異の場合には、局所定数行列と Birkhoff 接続行列による分類を得る。この比較は複素数上の対象と射についての定理であり、族についての正則性は別に仮定と結論を与える。

変形の主定理は、時間 groupoid に沿う接続データの同型を、合成と両立する有理 horizontal gauge へ持ち上げる。複数方向では、各方向の q 零曲率方程式と方向間の cocycle 条件の両方を扱う。さらに任意階数・任意次数の多項式 q 接続について、特異点のスペクトル群が q^ℤ によって分離される一般初期値から、可換な離散 Schlesinger 変換を構成する。その存在範囲は、任意に指定した有限の時間範囲に対する非空 Zariski 開集合として述べる。

近接するロードマップとの位置付けは次の通りである。[PainleveEquations](../PainleveEquations/README.md) の一般接続・等モノドロミー理論を微分方程式側の比較対象とし、[FormalLaurentPuiseux](../FormalLaurentPuiseux/README.md) の形式局所体、[AlgebraicVectorBundles](../AlgebraicVectorBundles/README.md) の束と引戻し、[ComplexKahlerGeometry](../ComplexKahlerGeometry/README.md) の解析的 germ・束・コホモロジー、[SpecialFunctionsTheta](../SpecialFunctionsTheta/README.md) の theta 関数を利用する。Layer 0–1 は対象・射・局所格子、Layer 2–4 は正則特異・形式・Stokes 分類、Layer 5 は大域比較、Layer 6 は変形と族、Layer 7 は具体的な可換変換を扱う。

## Conventions

代数的定義は可換環 R と環自己同型 σ の上で与える。有限階数の差分加群では underlying module を有限生成射影とし、体上では有限次元とする。階数零を圏の零対象として含め、スペクトル・cyclic vector・多項式因子の主張では n ≥ 1 を明記する。一般基底上の束の階数は局所定数でよく、必要な成分ごとに固定階数へ制限する。

複素解析の主張では |q| > 1 とする。0 < |q| < 1 の方程式は、q を q⁻¹、A(z) を A(q⁻¹z)⁻¹ に取り替える同値によって扱う。q = 0、|q| = 1、根付き一の q は解析的分類の仮定に含まれない。代数的な q シフトの定義には q ≠ 0 で十分であり、無限位数を用いる定理ではその条件を追加する。q は変形の間も固定する。

σ_qf(z) = f(qz) とし、列ベクトルの方程式を σ_qY = AY、その半線形作用素を Φ_A = A⁻¹σ_q と書く。Y′ = GY による gauge は A′ = (σ_qG)AG⁻¹ である。A から A′ への長方形行列 H の horizontal 条件は (σ_qH)A = A′H とする。束の向きは A : E ⇢ σ_q*E、すなわち E_z ⇢ E_qz である。

0 の局所解析体は収束 Laurent 級数体 ℂ({z})、形式体は ℂ((z)) とする。前者は 0 における有理型 germ の既存の体を、Laurent 展開で表示したものである。∞ の座標は w = z⁻¹ であり、σ_q は w ↦ q⁻¹w と作用する。したがって ∞ で局所分類を用いる際には、座標変換と必要な作用の逆転をともに記録する。形式係数体の分岐 z = uʳ には q_rʳ = q を選び、σ_(q_r)u = q_ru とする。選択変更と有限群による降下は Layer 3–4 で扱う。

特異集合には A の極と A⁻¹ の極をともに含める。行列式だけが正則であっても A が正則同型とは限らない。局所格子、形式型の marking、基本解の正規化、時間方向の同型は互いに異なるデータとして保持する。正則特異は q 差分加群の傾きがすべて零であることと同値になる。傾きの符号は A = z^μC が傾き μ となる規約を用いる。

時間の作用 T は σ_q と可換とする。輸送 Y(z,Tt) = B(z,t)Y(z,t) の整合式は A(z,Tt)B(z,t) = B(qz,t)A(z,t) である。「接続データの保存」は指定された同型とその合成法則を意味する。「同じ同型類」と「選ばれた同型」を区別し、framing がないところで輸送の一意性を仮定しない。

## Layer 0: 差分加群と係数体

### 0.1 半線形差分加群と horizontal な射

**構成・定理。** 可換環 R と自己同型 σ に対し、有限生成射影 R 加群 M と可逆な σ 半線形写像 Φ : M → M の組を差分加群とする。射 f : (M,Φ_M) → (N,Φ_N) は R 線形写像で、fΦ_M = Φ_Nf を満たすものとする。既存の半線形写像と線形写像を用いてこの圏を構成し、恒等射・合成・同型の特徴付けを与える。σ = id では可逆線形作用素付き加群の圏となる。

有限生成射影という条件を外した全加群の圏はアーベル圏であり、核・余核の半線形構造を誘導する。有限生成射影部分圏には underlying R 加群の完全列による完全構造を入れる。一般環上でこの部分圏がアーベル圏であるとは主張しない。体 K 上では有限次元部分圏がアーベル圏となり、核・像・余核が有限次元差分加群である。（[RSZ13], §2.1.1 の差分加群の定義・圏構造を、既存の半線形代数へ実装する。）

- Underlying module への忘却関手は忠実であり、同型を反映する。
- 可逆な horizontal な線形写像の逆は horizontal である。
- 直和、零対象、核・余核の underlying module と普遍性を比較する。
- 体上の完全性と、環上の有限生成射影部分圏における admissible な完全列を区別する。

*Needs:* Mathlib の `Module`、`LinearMap`、`LinearEquiv`、加群の圏と完全列。半線形同型の逆に必要な条件は σ と σ⁻¹ の両側逆から供給する。

### 0.2 テンソル・双対・内部 Hom と係数変換

**構成・定理。** 0.1 の有限生成射影差分加群に、既存のテンソル積・双対を用いて rigid symmetric monoidal 構造を与える。単位対象は (R,σ)、テンソル上の作用は m ⊗ n ↦ Φ_Mm ⊗ Φ_Nn、双対上の作用は

    Φ_(M∨)(f) = σ ∘ f ∘ Φ_M⁻¹

とする。内部 Hom にも Φ(f) = Φ_N ∘ f ∘ Φ_M⁻¹ を与える。この式が R 線形写像を R 線形写像へ送り、その空間上では σ 半線形になることを確認する。

f : R → S が τf = fσ を満たすとき、係数変換を S ⊗ᵣ M と s ⊗ m ↦ τ(s) ⊗ Φ_Mm で定める。有限生成射影性の保存に flatness は不要である。任意の完全列と核の保存には S の R 上の flatness を課す。一方、有限生成射影 quotient を持つ admissible 短完全列は underlying R 加群として分裂するため、任意の係数変換で完全性を保つ。ここでは splitting が horizontal である必要はない。体の拡大に対してはこの条件が満たされる。 また S 上の差分加群を R 上へ restriction of scalars できる。S が R 上有限生成射影なら有限生成射影性を保ち、体の拡大の次数が d、S 上の階数が n なら R 上の階数は dn となる。（[RSZ13], §2.1.1; 一般の tensor・係数変換の coherence は既存 API の特殊化。）

- 評価・余評価、結合子、単位子、対称性が horizontal であり、rigidity と coherence の等式を満たす。
- Horizontal な内部 Hom の元と差分加群の射を同一視する。
- 外冪と determinant に q 構造を誘導し、短完全列の determinant 比較を horizontal な同型とする。
- 係数変換の恒等・合成比較は horizontal で、テンソル・双対・外冪と可換する。三段階の係数変換の二つの比較は一致する。

*Needs:* 0.1; native の ModuleCat の対称モノイダル構造、scalar extension とその pseudofunctor、有限生成射影加群の双対・外冪。

### 0.3 行列表示、gauge、作用素の規約

**定理。** K 上の n 次元差分加群に基底を選ぶと Φ = A⁻¹σ、A ∈ GLₙ(K) と一意に書ける。行列系を対象、下の horizontal な矩形行列を射とする圏を構成し、基底を忘れる functor が差分加群の圏との同値を与えることを証明する。異なる階数間の射と非可逆射も含める。その core、すなわち同型射だけを残した groupoid は、可逆行列による gauge groupoid と同値になる。

    (σH)A = A′H,
    A′ = (σG)AG⁻¹,
    det A′ = σ(det G) det A / det G.

第一式が半線形作用素の可換性と同値であること、第二式が可逆な第一式の特殊化であることを証明する。gauge の合成順序は G₂G₁ とし、その作用が行列の合成に一致することを明示する。（[S03], §1.1.2; [K16], Remark 1.8, equation (1.3)。文献の基底変換の逆向きを採る場合は上の式へ変換する。）

- 直和は block diagonal、テンソルは Kronecker 積、双対は A の逆転置、determinant は det A に対応する。
- horizontal な射の base change と行列成分の係数変換が一致する。
- q を q⁻¹ に変える関手は A(z) ↦ A(q⁻¹z)⁻¹ であり、二度適用すると元へ戻る。射とテンソル構造についても比較する。
- 基底の存在は体上で用いる。一般環上の有限生成射影差分加群は局所的な行列表示を貼り合わせる。

*Needs:* 0.1–0.2; 有限次元基底、行列と線形写像、determinant の native API。

### 0.4 q シフトを持つ係数体と定数体

**構成・定理。** q ∈ ℂ× に対し、ℂ(z)、ℂ({z})、ℂ((z)) 上に z ↦ qz の自己同型を構成する。ℂ(z) → ℂ({z}) → ℂ((z)) の埋め込みを差分体の射とし、∞ への埋め込みは w = z⁻¹、w ↦ q⁻¹w と比較する。解析的有理型 germ の Laurent 展開、形式付値、収束条件を区別する。（[RSZ13], §2.1.1; [VPR07], §1。）

q が無限位数なら、これら三つの体の σ_q 不変部分は ℂ である。局所体については Laurent 係数の比較、ℂ(z) についてはその局所体への埋め込みから示す。同じ q シフトは ℂ× 上の大域有理型関数体にも作用するが、そこでの不変部分は局所係数体の不変部分と区別する。

- q シフトは付値を保ち、形式付値位相に関して連続である。
- 解析 germ への pullback は中心を除く近傍を保つ条件を満たし、逆写像 z ↦ q⁻¹z から自己同型を得る。
- 0 と ∞ の局所化、形式完備化、係数変換に対する比較図式を可換にする。
- 分岐体 ℂ((u)) と ℂ({u})、z = uʳ、q_rʳ = q の係数埋め込みは、指定された σ_(q_r) と可換する。
- z = uʳ の解析体拡大 ℂ({u})/ℂ({z}) は基底 1,u,…,uʳ⁻¹ を持つ。Laurent 係数を指数の r による剰余類ごとに分け、f(u) = Σ_(j=0)^(r−1)uʲf_j(z) の各 f_j が収束することを証明する。形式体の同じ基底との比較、次数 r、deck 群 μ_r の u ↦ ζu による Galois 構造を得る。形式体の有限 Galois 構造は FormalLaurentPuiseux Layer 6 を用いる。

*Needs:* 0.2; native の RatFunc、LaurentSeries、有理型 germ と局所双正則 pullback; FormalLaurentPuiseux Layers 1・4・6; ComplexKahlerGeometry §§3.2–3.3。

### 0.5 Skew Laurent 表示と cyclic vector

**構成・定理。** 可換環 R と自己同型 σ に対し、整数 n の R 上の作用を σⁿ とする。この明示的な作用を持つ native `SkewMonoidAlgebra R (Multiplicative ℤ)` を D として用いる。環構造、有限支持、係数、単項式と積の法則は既存 API から受け取り、環の carrier や結合律を再構築しない。係数の埋め込みは `SkewMonoidAlgebra.singleOneRingHom`、Φ は指数 1 の `SkewMonoidAlgebra.of` の値であり、`single_mul_single` により Φa = σ(a)Φ、Φ⁻¹a = σ⁻¹(a)Φ⁻¹ を得る。σ を変える構成にはその作用を明示的に渡し、R に q に依存する大域 instance を設けない。

可逆な σ 半線形作用付き R 加群と全左 D 加群の圏同値を構成する。前者からは aΦⁿ が m を aΦ_Mⁿ(m) へ送る作用を、後者からは R と Φ の作用を取り出す。射の条件、二つの合成の自然同型、有限生成射影および体上の有限次元という underlying R 加群の条件を比較する。R の D への埋め込みが中心に入るとは仮定しない。σ が可換係数環 k を固定する場合に限り、k 線形構造を用いる。

非負指数の部分は native `SkewPolynomial R` と比較する。ℕ→ℤ による単項式の埋め込みが単射な環準同型であり、全 Laurent 環は Φ を可逆にする普遍性を持つことを、`SkewMonoidAlgebra.liftNCRingHom` によって証明する。通常の可換環の localization として取り扱わない。

K = ℂ(z)、ℂ({z})、ℂ((z))、q が無限位数、dim_K M = n ≥ 1 とする。任意の差分加群 M は cyclic vector e を持ち、e, Φe, …, Φⁿ⁻¹e が基底になる。したがって、次数 n、最高係数 1、定数係数非零の skew polynomial P により M ≅ D/DP と表示できる。作用素から companion matrix への比較とその逆を与える。表示の選択自体を不変量とはしない。（[RSZ13], Lemma 2.1.1; [S03], §1.1 冒頭の cyclic vector lemma。[VPR07], Lemma 4.1 は後の Laurent 多項式模型における対応物。）

- 基底付き行列系・cyclic vector 付き差分加群・scalar operator の相互構成を与える。
- 最小作用素の次数が n であり、定数係数非零が Φ の可逆性に対応することを証明する。
- Cyclic vector の変更を加群同型に送り、Layer 3 の Newton slope の不変性へ接続する。
- σ を σ⁻¹ へ変える操作は指数 n↦−n による環同型と対応し、0.3 の作用の反転と整合する。

*Needs:* 0.1–0.4; native の `SkewMonoidAlgebra`、`SkewPolynomial`、`single_mul_single`、`singleOneRingHom`、`of`、`mapDomainRingHom`、`liftNCRingHom`。差分加群との圏同値、可逆生成元の普遍性の特殊化、q 固有の cyclic vector の補題を本節で所有する。

### Examples

階数一の定数系 A = c に G = zᵐ を作用させると A′ = qᵐc となる。双対は c⁻¹、tensor は cd であり、0.2–0.3 の符号と向きを確認する。零次元系は唯一の空行列を持ち、すべての構成の零対象となる。

q = 1 で K² 上の Φ = id を取ると、e と Φe は一致し、cyclic vector は存在しない。したがって 0.5 の無限位数性は消せない。環 R = ℂ[x]、σ = id では射 R → R、m ↦ xm の余核 R/(x) は射影加群でないため、有限生成射影部分圏を一般にアーベル圏とすることもできない。

### Dependencies

0.1 が対象と射、0.2 が操作と base change、0.3 が表示、0.4 が解析・形式係数体、0.5 が scalar operator 表示を供給する。既存の線形代数・分数体・形式 Laurent 級数・解析 germ を利用し、q 構造およびそれらの比較の可換性を本層で加える。後続層への依存はない。

## Layer 1: 束上の q 接続、局所格子、特異点

### 1.1 有理 q 接続の圏と generic fibre

**構成・定理。** k 上の滑らかな射影整曲線 X と k 自己同型 σ_X に対し、有限局所自由層 E と有理同型 A : E ⇢ σ_X*E を有理差分接続とする。正則な射 f : E → F は (σ_X*f)A_E = A_Ff を満たすものとし、有理な射を許す圏も別に定義する。X = ℙ¹_ℂ、σ_X(z) = qz に特殊化して有理 q 接続を得る。（[K16], Definition 1.5; 射と圏構造はこの定義の整理。）

generic fibre を取ると関数体 k(X) 上の 0.1 の差分加群を得る。逆に、任意の有限次元差分加群は generic fibre の基底と自明束を選ぶことで束の模型を持つ。有理 horizontal な射を許す圏から差分加群の圏への関手は圏同値である。正則な束の射だけを許す圏では局所格子が追加データとして残り、この同値と混同しない。

- Generic fibre、直和、tensor、双対、determinant の比較を構成する。
- 座標・局所フレームを選ぶと 0.3 の行列式を得ることを証明する。
- σ_X と可換する曲線の同型、および適切な base change に沿う pullback と比較する。
- 正則な同型の忘却と、有理な同型への局所化を区別する。

*Needs:* Layer 0; native の有限局所自由層と pullback; AlgebraicVectorBundles §§1.1–1.2、3.1–3.2; AlgebraicCurves §§1.1–1.2、Layer 12。

### 1.2 全閉点の局所格子による束の模型

**定理。** 1.1 の関数体上の差分加群 V を固定する。束の模型は、各閉点 p での離散付値環 O_(X,p) 上の full lattice Λ_p ⊂ V で、ある有理基底に関して有限個を除くすべての p で標準格子となるものと同値である。格子族から束を再構成し、元の束との同型を与える。この比較は射についても成り立ち、generic な線形写像 H が正則な束の射になることは HΛ_p ⊂ Λ′_p が全閉点で成り立つことと同値である。

q 接続をこの同値へ運び、A_p が Λ_p を σ_X*Λ の p 成分へどのように写すかを記述する。局所完備化した格子による同じ記述との比較も与え、有限個の変更の貼り合わせと generic fibre の保持を証明する。これは [K16], Definitions 1.5–1.7 の束と modification を、曲線上の既存の格子・局所化へ展開したものである。

- 同じ V の二つの模型の比較は有限個の格子変更に帰着する。
- 束同型の条件は全閉点での格子の等式であり、generic 同型だけでは足りない。
- 直和、dual lattice、tensor lattice、determinant lattice と 1.1 の操作を比較する。
- 局所座標の変更、完備化、有限個の格子変更の合成に関して自然性を証明する。

*Needs:* 1.1; AlgebraicCurves §§1.1–1.2、5.7、Layer 12 の局所環・完備化・native 曲線への比較; 有限局所自由層の Zariski 貼り合わせ。

### 1.3 零点・極・Smith 型と行列式の制約

**構成・定理。** p で A を二つの full lattice 間の有理同型として表し、Smith exponents ν₁(p) ≤ ⋯ ≤ νₙ(p) を定める。局所一様化変数と二つの正則フレームの選択に依存しないことを示す。すべての νᵢ が零であることは A が p で正則同型であることと同値である。負の指数は A の極、正の指数は A⁻¹ の極を表す。（[K16], Definition 1.6; Smith 型と divisor の記述はこの定義の局所線形代数による展開。）

有限集合 Sing(A) を A または A⁻¹ が正則でない閉点の集合とし、determinant の有理切断 det A の位数 d_A(p) = Σᵢνᵢ(p) を与える。σ_X は次数を保つので、det(σ_X*E) ⊗ det(E)⁻¹ の次数は零であり

    Σ_p [k(p):k] d_A(p) = 0

を得る。ℙ¹_ℂ では ℂ× の q 軌道に沿う有限支持の divisor と、端点 0、∞ の寄与を分ける。|q|>1 では各非零 q 軌道そのものは無限集合である。

- Direct sum は Smith exponents の多重集合和、dual は符号を反転して順序を逆にする。
- 正則フレーム間の gauge は各局所 Smith 型を保つ。有理 gauge は束の模型の変更を伴う。
- 特異集合の pullback と、determinant divisor の pullback を比較する。
- 行列式の位数が零であることと、正則同型であることを区別する。

*Needs:* 1.1–1.2; native の `Matrix.exists_smith_normal_form_of_isDiscreteValuationRing` による DVR 上の Smith normal form（分母を払って適用し、付値を戻す）; AlgebraicCurves §§3.1–3.2 の divisor・主 divisor・次数; AlgebraicVectorBundles §3.2 の determinant。

### 1.4 Modification と特異軌道の輸送

**構成・定理。** 有理同型 G : E ⇢ E′ によって E′ 上に A′ = (σ_qG)AG⁻¹ を誘導する。これを q 接続の modification とし、1.2 の有限格子変更と同値に記述する。G の合成・逆、互いに異なる点における独立な格子変更の可換性を証明する。ここで可換性は同じ generic fibre 内の格子族の置換についての主張であり、任意の二つの有理 gauge が可換するという意味ではない。（[K16], Definition 1.7, Remark 1.8。）

ℙ¹_ℂ 上で r_G(p) を determinant の有理同型 G の局所位数とすると

    d_(A′)(p) = d_A(p) + r_G(qp) − r_G(p)

となる。有限 support を持つ divisor として、各 ℂ× 内の q 軌道上の d_A の総和は不変である。固定点 0 と ∞ の d_A も不変である。束の次数は modification によって変わり得るので、generic な q 差分加群の不変性と束の次数の保存を混同しない。

- 同じ generic fibre の模型の圏へ差分加群の射を持ち上げる条件を、全格子の包含または等式で与える。
- Modification の support、長さ、determinant の変化を比較する。
- 端点の局所指数の q 整数冪による移動と、形式・解析同型類の保存を比較する。

*Needs:* 0.3; 1.2–1.3; divisor の pullback と有限和。

### 1.5 単純零点・単純極の elementary modification

**定理。** a ∈ ℂ× とし、A は a で正則、rank A(a) = n − 1、det A は a で単純零点を持つとする。a/q では A が正則同型であり、他の指定した特異点との衝突はないとする。局所変数 t = z − a と ker A(a) の持ち上げを用い

    Λ′_a = Λ_a + t⁻¹ · lift(ker A(a))

という upper modification を行うと、a の単純零点は消え、a/q に単純零点が生じる。a 以外の格子、特に ∞ の格子は元のものを保持する。lift の選択に依存しない格子として定義し、適合するアフィン上のフレームでは G = diag(z − a,1,…,1) と表す。このアフィン表示で determinant の比は (qz − a)/(z − a) となり、束の次数の変化は +1 である。∞ の transition も変更後の束に合わせる。

双対的に、a での Smith 型が (−1,0,…,0) で、a/q が正則同型点なら、主部の kernel を用いる lower modification により単純極を a/q へ移す。次数は −1 である。「留数が階数一」だけで済ませず、単純極の Smith 型、同値な determinant の単純極と局所非退化の条件を保持する。逆操作は該当する隣接点での逆格子変更として与える。（[K16], Definitions 1.6–1.7 の局所模型からの直接の帰結。）

- 核・主部による基底に依存しない定義と diagonal gauge による表示を比較する。
- 特異点の位置、束の次数、determinant divisor の三つの変化を同時に計算する。
- 有限個の操作を合成する場合には、各段階の非衝突・階数・可逆性条件を保持する。

*Needs:* 1.2–1.4; 局所 Smith 型、単純零点の核直線、有限長 quotient と次数。

### 1.6 相対 q 接続、base change、descent

**構成・定理。** スキーム S、単元 q ∈ Γ(S,O_S)×、X = ℙ¹_S、S 上の自己同型 σ_q を取る。D ⊂ X を任意の base change 後も effective Cartier divisor となる相対 divisor とし、U = X ∖ D とする。対象を有限局所自由層 E と O_U 線形同型

    A : E|_U ≅ (σ_q*E)|_U

で定め、正則な horizontal な束同型を射とする。D を拡大する比較、および有限 pole bound を指定した部分問題も与える。非被約 S 上で関数体 Frac(O_S) を導入せず、層と開部分上の同型を用いる。

S′ → S に沿う pullback は相対 q 接続を保ち、恒等・合成・tensor・determinant と整合する。固定された (X,D,σ_q) に対するこのgroupoid は fpqc descent を満たす。証明は、有限局所自由層、U 上の同型、horizontal な可換図式を順に降下する。このgroupoid の構成から、有限型・平滑な Artin stack、安定な粗モジュライ空間の存在を結論しない。（[K16], Definition 1.5 の相対化; descent は SchemeAndStackFoundations §1.1 の供給契約の適用。）

- Nilpotent を含む基底、成分ごとに異なる階数、相対 Cartier divisor の pullback を扱う。
- 局所フレームでの gauge descent と、束の descent を比較する。
- Marking、端点の格子、相対直和因子としての flag を追加したgroupoid への忘却関手を構成する。
- 相対 modification では kernel・quotient が必要な局所自由性を持つ開部分を明示し、点ごとの階数条件だけで全基底の flatness を仮定しない。

*Needs:* 1.1–1.4; native の有限局所自由層と pullback coherence; AlgebraicVectorBundles §§1.1–1.2、2.1–2.2; SchemeAndStackFoundations §§1.1、1.18。

### Examples

局所行列 diag(t,t⁻¹) は determinant が 1 でも Smith 型が (−1,1) であり、特異である。階数一の A(z) = z − a に G(z) = z − a を作用させると A′(z) = qz − a となり、零点は a から a/q へ移る。

E = O(d∞) で e_∞ = zᵈe₀ とし、0 側の行列を定数 c とすると、∞ 側は A_∞ = q⁻ᵈc である。これは同じ有理差分加群にも異なる次数の束の模型があることと、局所指数の q 整数冪による変化を示す。S = Spec ℂ[ε]/(ε²)、A = I では 1 + εH は任意の定数行列 H に対して自己同型となり、族を閉点だけの集合に置き換えるとこのデータを失う。

### Dependencies

0.1–0.4 と既存の曲線・ベクトル束の carrier を用いる。1.1 の generic fibre、1.2 の格子比較、1.3 の特異型を順に構成してから、1.4–1.5 の modification を扱う。1.6 は同じ定義を相対化し、既存の fpqc descent を使用する。局所解析分類、モジュライ空間の表現可能性、特定階数の安定性定理を前提にしない。

## Layer 2: 楕円曲線、theta 関数、正則特異分類

### 2.1 乗法的楕円曲線と q 同変な束

**構成・定理。** |q| > 1 に対し、ℂ× 上の自由かつ properly discontinuous な q^ℤ 作用の商 E_q を構成する。log q の一つの値を選ぶと

    E_q ≅ ℂ / (2πiℤ + (log q)ℤ)

となる。二つの生成元は実線形独立であり、既存の full lattice quotient からコンパクトな複素一次元 Lie 群を得る。log q の値を変えた際の lattice の同一性と比較同型の cocycle を示す。（[S03], §1.2; [VPR07], §2。）

B ∈ GLₙ(O(ℂ×)) が正則かつ逆も正則なら、(z,v) ↦ (qz,B(z)v) の作用から正則ベクトル束 V_B を降下する。同変な正則写像・有理型写像は、それぞれ束の正則写像・有理型写像へ降下する。切断の方程式は s(qz) = B(z)s(z) である。

- 乗法的商と additive lattice quotient の比較を、射と pullback に対して自然にする。
- G ∈ GLₙ(O(ℂ×))、B′ = (σG)BG⁻¹ から正則な束同型を作り、G の合成と一致させる。G が有理型の場合には有理型束同型を得る。
- Tensor、dual、determinant、短完全列の降下を既存の bundle descent と比較する。
- ℳ(E_q) ≅ ℳ(ℂ×)^(σ_q) を証明し、0.4 の定数体の区別を回収する。

*Needs:* 0.3–0.4; ComplexManifolds Milestones 4・7; ComplexTori Milestone 1; ComplexKahlerGeometry §§4.1、4.4。本節は商・束の一般理論を q 作用へ適用する。

### 2.2 乗法的 theta、q-character、q-logarithm

**構成・定理。** SpecialFunctionsTheta の収束・零点・準周期性を、次の乗法的規約へ変換する。

    Θ_q(z) = Σ_(m∈ℤ) q^(−m(m+1)/2) zᵐ,
    Θ_q(qz) = zΘ_q(z),
    e_c(z) = Θ_q(z)/Θ_q(z/c)      (c ∈ ℂ×),
    ℓ_q(z) = zΘ_q′(z)/Θ_q(z).

Θ_q は ℂ× 上正則で、零点は −q^ℤ、すべて単純である。e_c と ℓ_q は ℂ× 上有理型であり、σ_qe_c = ce_c、σ_qℓ_q = ℓ_q + 1 を満たす。局所一様収束と微分を既存 theta theorem の変数変換から得る。（[S00], §1.1.2; [S03], §1.2.2。）

- e_(qc) = (z/(qc))e_c を証明し、c の q^ℤ による変更と gauge z の対応を計算する。
- e_ce_d/e_(cd) は σ_q 不変な有理型関数である。一般に定数 1 ではないため、基本解の tensor 比較にはこの因子を保持する。
- ℓ_q の対数的導関数の変換式、極、基本解に用いる有限多項式との積を扱う。
- 任意の ℂ× 上の有理型基本解において、右側から掛ける σ_q 不変行列が解の自由度を与えることを示す。

*Needs:* 0.4、2.1; SpecialFunctionsTheta §§1.1–1.3、4.1–4.2、5.1。新しい theta の一般収束理論を重複して構築しない。

### 2.3 定数係数系の基本解と Jordan 部分

**定理。** C ∈ GLₙ(ℂ) を乗法的 Jordan 分解 C = C_sC_u とし、C_s の固有空間ごとに e_c、C_u には

    C_u^(ℓ_q) = exp(ℓ_q log C_u)

を用いる。log C_u と exponential は nilpotent 行列の有限和として解釈する。これらの積 E_C は GLₙ(ℳ(ℂ×)) に属し、σ_qE_C = CE_C を満たす。対角化可能性を仮定しない。（[S00], §1.1.2; [S03], §1.2。）

- 定数行列による共役と E_C の構成を比較する。
- 同じ定数系の二つの有理型基本解の比は σ_q 不変行列であり、逆にその右乗法は基本解を保つ。
- 直和との比較を与える。Tensor と dual の基本解には 2.2 の character の比較因子を含める。
- C の unipotent 部分が自明になる場合、階数一の場合、重複固有値を持つ場合の特殊化を示す。

*Needs:* 0.3、2.2; native の `LinearMap.GeneralLinearGroup.jordanDecomposition` と `jordanDecomposition_spec` による perfect field 上の有限次元乗法的 Jordan 分解；nilpotent 行列の有限多項式。

### 2.4 正則特異性と収束する定数化

**定理。** ℂ({z}) 上の q 差分加群について、Φ と Φ⁻¹ に安定な full ℂ{z} 格子が存在すること、meromorphic gauge により A(z) と A(z)⁻¹ をともに 0 で正則にできることを同値とする。これを正則特異性と定義する。任意の正則特異系は収束 meromorphic gauge によって定数 C ∈ GLₙ(ℂ) に変換できる。共鳴する固有値と Jordan block を許し、shearing による固有値の q 整数冪移動と、その後の収束する定数化を含める。（[S00], §§1.1.1、1.1.3–1.1.4、1.3; [S03], §§1.2、2.1。）

非共鳴の正規化された部分では、A(z) = C + Σ_(m≥1)A_mzᵐ、H(0) = I とし、σ_qH · C = AH を満たす正則 H を構成する。仮定は m ≥ 1 のすべてについて X ↦ qᵐXC − CX が可逆であることとする。十分条件は Sp(C)/Sp(C) が q^(ℤ ∖ {0}) と交わらないことであり、重複固有値や非自明 Jordan 部分を排除しない。

    qᵐH_mC − CH_m = Σ_(j=1)^m A_jH_(m−j).

この recurrence の一意性、収束半径が正であること、H と H⁻¹ の正則性を証明する。共鳴を持つ系については、この非共鳴 recurrence をそのまま用いず、必要な shearing と有理型 gauge を先に構成する。

- 格子による定義は gauge 不変であり、直和・tensor・dual・部分対象・商対象で閉じる。
- 共鳴を除く shearing の存在と、定数化の解析的収束を別の補題として与える。
- 一意性は H(0) = I と非共鳴仮定の下で述べ、一般の定数化には stabilizer の自由度を残す。
- ∞ では 0.3–0.4 の座標・作用の反転を適用する。

*Needs:* 0.1–0.5; 2.3; 解析 germ の収束級数、有限次元行列の majorant estimate。

### 2.5 正則特異圏の同値と共鳴する射

**定理。** 定数行列 C、D の間の局所 meromorphic horizontal な射 H は Laurent 多項式である。H = Σ_mH_mzᵐ と展開すると条件は

    qᵐH_mC = DH_m

であり、異なる m に対応する可能な固有値比は有限個なので、非零の H_m は有限個に限られる。この式を射とする定数行列の圏から、正則特異 q 差分加群の圏への関手は充満忠実かつ本質的全射である。（[S03], Lemma 2.1.3.2 と §2.1 の local classification。）

各 q^ℤ 軌道の代表を 1 ≤ |c| < |q| に選んで定数行列の固有値を正規化すれば、二つの正規化された対象の horizontal な射は定数となる。代表の選択、shearing、元の対象との比較同型を明示し、選択なしの canonical な基底を主張しない。

- 共鳴する対象間の非定数 Laurent 射を保持し、同型類だけでなく全 Hom を比較する。
- 圏同値の quasi-inverse、単位・余単位、tensor と exactness の比較を与える。固有値を基本 annulus に正規化した部分圏の tensor は、その正規化を伴う比較を通じて定める。
- 定数行列 c と qᵐc の階数一の同型を zᵐ として回収する。
- 定数系の自己同型群と、フレームを指定した場合の安定化部分群を区別する。

*Needs:* 0.3–0.4、2.4; Laurent 係数比較、行列の intertwiner とスペクトル。

### Examples

C = [[1,1],[0,1]] の基本解は [[1,ℓ_q],[0,1]] である。非半単純な定数系でも定数化と基本解の構成が適用される。階数一の C = c と D = qc の間には H = z という射があり、共鳴する射を定数行列だけで表すと失われる。

q = 2 のとき Θ_q(3z)Θ_q(5z)/(Θ_q(z)Θ_q(15z)) は q 周期的な有理型関数である。零点と極の q 軌道が異なるため非定数であり、ℳ(ℂ×) の不変体を ℂ と置けないことを示す。Θ_q 自身は s(qz) = zs(z) の切断となり、後の純傾きの符号と束の次数の比較に用いる。

### Dependencies

2.1 は一般の商・束の降下を q 作用へ適用し、2.2–2.3 は既存 theta と線形代数から基本解を作る。2.4 の解析的定数化と 2.5 の射の比較を合わせて正則特異圏の分類を得る。正則特異性と傾き零の同値は Layer 3 の slope theorem で証明し、本層で未定義の Newton polygon を前提にしない。

## Layer 3: 局所 slope と形式型

局所解析体 K=ℂ({z})、形式体 K̂=ℂ((z))、|q|>1 を用いる。系 σ_qY=A Y に対応する加群は Φ_A=A⁻¹σ_q であり、系 A=z^μ C の slope を μ とする。slope の異なる成分の分離は形式分類を与え、その間の解析的 extension が次の層の q-Stokes データになる。

### 3.1 Newton polygon と次数

有限次元差分加群 M の cyclic presentation を skew Laurent 環 D=K⟨σ_q,σ_q⁻¹⟩ 上で取り、annihilator P=Σ a_i σ_q^i の係数の付値から Newton polygon を定義する。両端の係数を非零とし、点 (i,v₀(a_i)) の上方半直線の凸包の下辺を取る。P を単元倍して生じる平行移動を同一視し、有限支持の multiplicity function r_M:ℚ→ℕ を不変量とする。cyclic vector と presentation に依存しないことを証明する。零加群では支持を空集合とする。（[RSZ13], §2.2.1, Theorem 2.2.1。）

この定義は加群の annihilator に対するものなので、元のスカラー方程式の作用素の Newton polygon と区別する。スカラー方程式の解を並べた系から Φ_A=A⁻¹σ_q を作る操作には双対が入り、二つの slope は符号が逆になる。（[RSZ13], Example 2.2.2 とその前の説明。）

- 短完全列 0→M′→M→M″→0 に対し r_M=r_M′+r_M″。従って総 multiplicity は rank M に等しい。
- テンソル積について `r_(M⊗N)(λ)=Σ_(μ+ν=λ) r_M(μ)r_N(ν)`、双対について `r_(M∨)(μ)=r_M(−μ)` を証明する。内部 Hom では二つの slope の差が現れる。
- degree を `deg M=Σ_μ μ r_M(μ)` と定め、行列表示では `deg M=v₀(det A)∈ℤ` であることを証明する。各 slope の denominator は対応する multiplicity を割り切る。
- z=wʳ、pʳ=q による scalar extension では multiplicity を変えず slope を r 倍する。単に q を qʳ に取り替える操作とは区別する。

**Checks.**

- rank one の系 A=c zᵐ、c≠0、m∈ℤ では Φ_A(e)=c⁻¹z⁻ᵐe。加群の作用素 σ_q−c⁻¹z⁻ᵐ の Newton polygon は (0,−m) と (1,0) を結ぶので、slope は m、degree は m である。元の解の方程式 σ_qf−c zᵐf=0 の作用素なら slope は −m となる。
- A=diag(z⁻¹,z²) では slope は −1,2、degree は 1。双対の slope は 1,−2、degree は −1。テンソル平方の slope multiplicity は −2 に 1、1 に 2、4 に 1 となる。
- A が二行二列行列 `(0,z;1,0)` の場合、Φ_A²(e₁)=q⁻¹z⁻¹e₁ である。cyclic operator は σ_q²−q⁻¹z⁻¹、slope は 1/2 が二回、degree は 1。整数 slope のみを定義域とする実装ではこの加群を表せない。

*Needs:* Layer 0 の差分加群、cyclic vector、skew Laurent 作用素、行列との比較、双対とテンソル積；K と K̂ の付値・Laurent 展開；Mathlib の有限次元線形代数と有理数。

### 3.2 解析的 slope filtration と形式的分解

非零加群の Newton polygon が一つの slope μ のみを持つとき、pure of slope μ と呼ぶ。解析差分加群 M に対し、pure quotient を持つ唯一の有限 filtration M_≤μ を構成する。これは `S(M_≤μ)=S(M)∩(−∞,μ]`、`S(M/M_≤μ)=S(M)∩(μ,∞)` により特徴付けられる。形式体への拡張では各 slope の最大 pure submodule による直和分解が存在し、M̂ は gr(M)̂ に自然に同型となる。（[RSZ13], §2.2.3, Theorem 2.2.4。）

解析 filtration の存在には最小 slope に対応する収束 factorization を使い、形式分解には各 slope を指定した formal factorization を使う。pure 加群については解析から形式への拡張が充満忠実であり、pure formal 加群は解析的モデルを持つ。したがって解析加群の形式型は gr(M) の解析同型型で記述できる。（[RSZ13], §§2.2.2–2.3；[VPR07], Proposition 1.3, Corollaries 1.5–1.6。）

- すべての射 f:M→N は filtration に strict、すなわち `f(M_≤μ)=im(f)∩N_≤μ` となる。kernel、image、cokernel の filtration はこれと整合する。
- gr は ℂ 線形、exact、faithful で、テンソル積・内部 Hom・双対と自然同型を通じて整合する。テンソル filtration は slope の和で添字付ける。
- 異なる slope の pure 加群の間の Hom は零である。形式体上では異なる slope 間の extension も分裂する。
- 解析加群の filtration が分裂することと、M が gr(M) に解析同型であることを同値にする。形式分裂から解析分裂を推論しない。

**Checks.**

- slope 0 と 1 の pure 加群の直和では、M_≤0 は rank 1、M_≤1 は rank 2 である。順序を逆転した filtration は特徴付けの式を満たさない。
- 系 A=(1,1;0,z) を対角系 diag(1,z) から上三角 unipotent gauge で得るには zσ_qf−f=1 を解く必要がある。その唯一の formal solution は `f=−Σ_(n≥0) q^(n(n−1)/2)z^n` で、|q|>1 のため収束半径は零である。形式的には分裂し、解析的には分裂しない。
- 零加群の filtration と gr はともに零。異なる pure slopes 間の零 Hom と、同じ trivial module の Hom=ℂ を区別する。

*Needs:* §3.1；Layer 0 の kernel、cokernel、extension、scalar extension；Layer 2 の正則特異加群の局所分類；K̂ での formal factorization と K での最小 slope の収束 factorization（[RSZ13] §2.2.3 の q 差分 factorization としてこの節で証明）。

### 3.3 pure 加群の integral・rational normal form

整数 μ に対して、pure analytic 加群は系 A=z^μ C、C∈GLₙ(ℂ) に解析同型である。C の固有値を基本 annulus `1≤|c|<|q|` に取り、その上では C の相似類が加群の同型類を決める。Jordan block を含め、対角化可能性や固有値の相異性を仮定しない。（[RSZ13], §2.2.2.1。）

有理 slope μ=a/r、r≥1、gcd(a,r)=1 については、pʳ=q と z=wʳ を選び、K_r=ℂ({w}) 上の rank-one 系 σ_p y=c wᵃy を K 上へ restriction of scalars した加群 E(r,a,c) を用いる。これは rank r の simple pure 加群である。p を固定すれば、その同型型は r,a と cʳ の ℂ*/q^ℤ における class により決まる。すべての nonzero indecomposable pure 加群は E(r,a,c)⊗U_m の形であり、U_m は eigenvalue 1 の一つの Jordan block に対応する rank m の正則特異加群である。rank は rm、degree は am、slope は a/r となる。pure 加群はこれらの有限直和へ、summand の並べ替えと同型を除いて一意に分解する。（[RSZ13], §2.2.2.2；[VPR07], Proposition 1.3, Corollaries 1.5–1.7。[VPR07] の semilinear operator の逆を取って本書の系の規約へ移す。）

- monomial rank-one 加群との tensor による slope の平行移動と、正則特異部分の tensor・dual の比較を与える。
- pure normal form の formal 同型が収束することを証明し、解析分類と形式分類の一致を射についても与える。
- unipotent Jordan 部分を保持し、simple と indecomposable の区別、同じ slope を持つ直和の Hom と End の計算を与える。
- root p の選択と normal-form parameter c を同時に記録する。p を変えて同じ c を置く操作は、同じ加群を表すとは限らない。本節の分類は選んだ p を固定した契約とする。

**Checks.**

- r=1,a=0,m=2 では U₂ が現れ、その End は I と Jordan nilpotent N の張る二次元空間となる。二つの eigenvalue 1 を半単純化すると End の次元が 4 となり、元の加群を失う。
- r=2,a=1 の E(2,1,c) は rank 2、degree 1、slope 1/2。basis 1,w で系の行列は `(0,cz;c p⁻¹,0)` となり、determinant は −c²p⁻¹z である。p を −p に変えて c を固定すると determinant の定数因子が −1 倍されるため、単なる root の削除は許されない。
- μ=0 の既約型では gcd(0,r)=1 より r=1 である。正則特異の simple 型は rank one となる一方、Jordan block による indecomposable 型は任意 rank に存在する。

*Needs:* §§3.1–3.2；Layer 2 の共鳴を含む正則特異分類と Jordan 分解；Layer 0 の restriction of scalars、tensor、dual；有限巡回拡大の線形代数。

### 3.4 ramification と有限群による descent

z=wʳ、pʳ=q を固定する。0.4 の係数体比較により、K_r/K は基底 1,w,…,w^(r−1) を持つ r 次有限 Galois 拡大であり、その群 μ_r は w↦ζw により作用する。解析的な係数分解の収束と形式体への比較も 0.4 から受け取る。この作用は σ_p と可換である。K_r 上の差分加群 N の descent data は、各 ζ∈μ_r に対する ζ-semilinear bijection D_ζ で、`D_ζD_η=D_(ζη)` と `D_ζΦ=ΦD_ζ` を満たすものとする。K 上の加群 M は K_r⊗_K M と係数への Galois 作用を与え、逆に invariants N^μ_r を取ることで圏同値を得る。analytic・formal の両方で構成する。（[VPR07], Proposition 1.9 とその証明の finite-level descent；[RSZ13], Theorem 2.2.1(iv)；[S24], §§1.4, 2.3.2。）

- natural map `K_r⊗_K N^μ_r→N` が同型であること、射が Galois-equivariant な差分加群の射に対応することを証明する。
- extension、tensor、dual、slope filtration と descent の整合を与える。r がすべての slope の共通分母なら ramification 後の slope はすべて整数となる。
- r|s の場合の逐次 ramification と直接 ramification の comparison と cocycle を与える。必要な根を coherent に選ぶ場合は `p_s^(s/r)=p_r` を条件とする。
- p′=ζp へ変更するとき、semilinear operator を Φ′=D_ζΦ として移し替え、その invariants が元の加群になることを証明する。matrix presentation の係数を据え置いたまま根だけを変更する操作とは区別する。

**Checks.**

- slope 1/2 を z=w² で ramify すると rank を変えず slope 1 となる。rank 2 の加群を rank 1 に置き換えるのは restriction of scalars と extension of scalars の混同である。
- trivial rank-one K_r-module に対し、D_ζ(w)=ζw である。r=2 では invariant scalar は偶数 powers のみで、K_r^μ₂=ℂ({w²})=K となる。
- r=1 では descent group は trivial、比較写像は恒等となる。r=2 の trivial ramified line K₂e に D_(−1)(e)=−e を付けると invariant basis は w⁻¹e であり、Φ(w⁻¹e)=p⁻¹w⁻¹e となる。降下した rank-one 系は A=p で、trivial character による A=1 と異なる。

*Needs:* §§3.1–3.3；Layer 0 の scalar extension と semilinear action；native の `TauCeti.GaloisDescent.span_invariants_eq_top`、`liftBaseChange_injective_of_invariant`、`range_eq_invariants_of_liftBaseChange_surjective`。有限 Galois 拡大 L/K と、L の Galois 作用に関して半線形な K 線形表現 N に対し、これらから標準写像 L⊗_K N^G→N の線形同型と invariants の比較を受け取る。K_r/K の具体的 Galois 構造と解析的係数分解は 0.4 を用い、Φ と descent 比較の可換性をこの節で所有する。

### 3.5 extension の差分コホモロジーと次元

差分加群 M に対し、ℂ 線形二項複体 `M --(Φ−1)→ M` の kernel と cokernel を Γ⁰(M),Γ¹(M) とする。D = K[Φ,Φ⁻¹;σ_q] とし、Ext¹_D(N,M) は全左 D 加群の圏における native `CategoryTheory.Abelian.Ext` とする。下の明示的 projective presentation と短完全列の比較によって `Ext¹_D(N,M) ≅ Γ¹(N∨⊗M)` を得る。これは有限 K 次元の端点を持つ extension の同型類も分類する。pure 加群 P_i,P_j の ranks を r_i,r_j、slopes を μ_i<μ_j とすると、`Hom(P_j,P_i)=0` および `dim Ext¹(P_j,P_i)=r_i r_j(μ_j−μ_i)` を証明する。（[RSZ13], Proposition 2.1.3, Theorem 3.1.1；Appendix A.7。）

この Ext 比較は、P_N = D ⊗_K N と次の短完全列から構成する。D の K 作用は右乗法であり、D を (D,K)-bimodule として用いる。K が D の中心に入るとは仮定しない。有限 K 基底を選ぶと P_N は有限自由左 D 加群となる。

    δ_N(d ⊗ v) = dΦ ⊗ Φ_N⁻¹(v) − d ⊗ v,
    ε_N(d ⊗ v) = d · v,
    0 → P_N —δ_N→ P_N —ε_N→ N → 0.

Φa = σ_q(a)Φ によって δ_N の balanced 性と D 線形性を確認する。Laurent powers の有限支持の端で単射性を示し、有限区間の telescoping で ker ε_N = im δ_N を得る。Hom_D(P_N,M) ≅ Hom_K(N,M) の下で δ_N の precomposition は f ↦ Φ_M f Φ_N⁻¹ − f となる。`TauCeti.homCokernelEquivExt` をこの指定した自由 presentation に適用し、cokernel を native Ext¹ と同定する。ℂ は σ_q に固定されるため、これらは ℂ 線形の比較である。

短完全列 0 → M —i→ E → N → 0 の K 線形 splitting s に対し、kernel を i によって M と同定して

    c_s = (Φ_E s − sΦ_N)Φ_N⁻¹ ∈ Hom_K(N,M)

を取る。s を s + if に変えると c_s は Φ_M f Φ_N⁻¹ − f だけ変わる。逆構成は M ⊕ N 上の作用 (m,n) ↦ (Φ_Mm + cΦ_Nn, Φ_Nn) である。これを presentation の pushout と比較して native extClass と一致させ、同じ cokernel class と両端で恒等な extension 同型の存在を同値にする。中間項 E の有限 K 次元性は端点の有限次元性から従う。有限次元部分圏に enough projectives を仮定しない。

証明は負 slope μ の pure 加群 P に対する `Γ⁰(P)=0`、`dim Γ¹(P)=−μ rank P` を使う。整数 slope では係数比較または q-Borel 変換により cokernel の有限次元の補空間を構成し、有理 slope では ramification と equivariant descent を用いる。形式体では非零 slope の Γ¹ は零となる。slope 0 では Euler characteristic は零であり、共鳴により kernel と cokernel が同時に生じる。（[RSZ13], Lemmas 3.1.2–3.1.3, Proposition 3.2.2, Corollaries 3.2.3–3.2.5。）

- 短完全列から得る Γ⁰,Γ¹ の exact sequence を差分加群の extension の connecting map と比較する。符号は upper triangular extension の gauge 公式から固定する。
- marked two-step extension の零 class が解析的分裂に一致し、Baer sum が cokernel の和に一致することを証明する。
- M₀=⊕P_i の場合、`Σ_(i<j) r_i r_j(μ_j−μ_i)` が End(M₀) の正 slope の weighted sum に一致することを証明する。これは marked isoformal class の次元となる。
- pure slopes の大小を逆にした extension は canonical filtration により分裂する。等しい slope の extension は別に保持し、正則特異の Jordan extension を除去しない。

**Checks.**

- P₀:σ_qy=y、P₁:σ_qy=zy では Ext¹(P₁,P₀) は一次元。行列 `(1,u;0,z)` の定数 u が class を与え、上の Φ-cocycle の規約では代表は −u となる。逆順の Ext¹(P₀,P₁) は零となる。
- trivial module に対する σ_q−1 は Laurent series の定数項を殺し、非零 power zⁿ には qⁿ−1 を掛ける。qⁿ≠1、n≠0 より kernel と cokernel はともに ℂ となる。従って Ext¹(1,1) は零ではない。
- rank 1、slope 0 の P と rank 2、slope 1/2 の Q では `dim Ext¹(Q,P)=1·2·(1/2)=1`。denominator を floor してしまう定義は零を返して誤る。

*Needs:* §§3.1–3.4；0.1 の全差分加群のアーベル圏、0.2 の内部 Hom、0.5 の Ore-module 表示；native の `CategoryTheory.Abelian.Ext`、`ModuleCat.projective_of_free`、`TauCeti.homCokernelEquivExt`、`ShortExact.extClass_baerSum`；Layer 2 の theta と正則特異差分方程式。上の自由 presentation、有限次元 extension の splitting/coboundary 比較、および q-Borel 変換と収束係数の評価による index 補題をこの節で証明する。

### 3.6 pure 加群の Laurent 多項式モデル

R=ℂ[z,z⁻¹] とする。pure analytic 加群 P の slope μ=a/r、r≥1、gcd(a,r)=1 に対し、Laurent model P_global⊂P を構成する。これは R 上で finite free、Φ と Φ⁻¹ に安定であり、K⊗_R P_global→P が同型となる。本書の Φ_A=A⁻¹σ_q では、P_global は zᵃΦʳ の powers により有限次元の ℂ-vector space を張る元全体として特徴付けられる。非零の定数倍をした operator も同じ有限性条件を与える。（[VPR07], Definition 1.8；同文献の |q|<1 の semilinear operator を反転して規約を移す。）

この特徴付けは、§3.3 の pure normal form の generalized eigenspaces から構成する。整数 slope の場合は normal form z^μC の Laurent basis であり、有理 slope の場合は ramified pure model を restriction of scalars し、その intrinsic な特徴付けにより選択独立性を示す。split object M₀=⊕P_i に対しては各 P_i,global の直和を取る。

- pure 加群の射 f:P→Q が対応する Laurent models を保つことを証明する。異なる slopes の射は零であり、同じ slope では operator の generalized eigenspaces の保存から従う。
- fixed pure model の局所射と R 上の射の comparison を同型にし、tensor、dual、直和との整合を与える。
- pure matrix model B∈GLₙ(R) の determinant が c zᵈ、c≠0 であることを示す。B と B⁻¹ は ℂ* 上で正則である。
- finite ramification とその descent、根の変更による比較がこの model と整合することを証明する。general mixed-slope module の Laurent globalization は Layer 5 の契約とする。

**Checks.**

- 系 A=zᵐ は Laurent model R e を持ち、zᵐΦ は coefficient functions に対する σ_q となる。Laurent monomial zᵏe は固有値 qᵏ の eigenvector である。
- 行列 `(0,z;1,0)` では zΦ²(e₁)=q⁻¹e₁、zΦ²(e₂)=e₂ となり、両 basis vectors は finite-orbit condition を満たす。rank-two の slope 1/2 model が ramification なしの R 上に存在する。
- slope 0 の regular unipotent block の model は R² である。Jordan の generalized eigenspaces を eigenvectors だけに置き換えると rank が減るので、後者では定義できない。

*Needs:* §§3.1–3.4；Layer 0 の Laurent 多項式環と scalar extension；有限次元線形代数の generalized eigenspaces；[VPR07] Definition 1.8 の finite-orbit characterization をこの節で証明。

### 3.7 pure 楕円曲線束とそのコホモロジー

§3.6 の pure または split Laurent model B から、`(z,v)∼(qz,B(z)v)` により E_q 上の正則ベクトル束 V(P) を作る。局所モデルの射の comparison によって、この構成を自然同型の範囲で選択独立な faithful tensor functor として与える。（[VPR07], §2, Lemma 2.1 と Theorem 2.3 の直前。Theorem 2.3 は split modules と bundles の同型類の全単射であり、圏同値を主張しない。）

pure slope μ、rank r の P に対し、V(P) の rank は r、degree は rμ となる。整数 slope の場合は degree μ の line bundle と regular-singular factor の flat bundle の tensor product であり、任意有理 slope は finite ramification と determinant を用いて比較する。degree は Chern 数の convention と合わせ、determinant line の automorphy factor の次数に一致させる。

- μ<0 の pure P に対し H⁰(E_q,V(P))=0 を、Laurent coefficient の q 差分 equation から証明する。この結論は arbitrary negative-degree bundle だけからは推論しない。
- Dolbeault cohomology と CR operator の index を比較し、E_q の genus が 1 であることから χ(V(P))=deg V(P) を得る。複素一次元なので coherent H² は零、従って μ<0 なら dim H¹(E_q,V(P))=−rμ となる。
- integral positive gap μ_j−μ_i に対応する Hom block の bundle は rank r_i r_j、degree r_i r_j(μ_i−μ_j) を持つ。§3.5 の差分 Γ¹ と bundle の H¹ の comparison を構成する。（[VPR07], Lemma 2.1, Theorem 2.5；[RSZ13], §§6.2–6.3。）
- filtration を忘れた bundle functor と局所加群を区別する。一般の bundle map は局所加群の射とは限らない。integer-slope mixed modules の filtered fully faithful comparison は §4.7 で構成する。

**Checks.**

- σ_qθ_q=zθ_q を満たす theta function は、degree 0 の trivial bundle から degree 1 の bundle への非零 holomorphic map を与える。一方、slope 0 と 1 の局所 pure 加群の間の Hom は零である。theta function は原点で有理型ではないため、局所加群の射にはならない。
- slope −1、rank 2 の pure block では degree は −2、H⁰=0、dim H¹=2。rank を掛けない degree=−1 では index と整合しない。
- E_q 上の degree-one line bundle L を取り、L⊕L⁻² は total degree −1 でありながら L の非零 section を持つ。負次数だけを仮定した H⁰ vanishing は採用しない。

*Needs:* §§3.1–3.6；Layer 2 の E_q、theta と factor of automorphy；ComplexKahlerGeometry §4.1 の holomorphic bundles と section sheaves、§2.5 の bundle-valued Dolbeault 比較、§5.10 の finite-dimensional cohomology と Serre duality、§7.6 の complex tori；PseudoholomorphicCurveAnalysis §§6.3–6.4 の ∂̄ kernel/cokernel 比較と §7.2 の arbitrary-rank CR operator の index。q automorphy factor から Chern degree への符号の adapter と negative pure slope の H⁰ vanishing はこの節で所有する。

### Examples

rank-one monomial 系は符号と次数を固定する。行列 (0,z;1,0) は slope 1/2 を持つ非分岐体上の rank-two module であり、ramification 後の整数 slope と descent の区別を示す。行列 (1,1;0,z) は形式的には分裂するが解析的には分裂しない extension であり、次の層の Stokes class が検出する対象である。

### Dependencies

Layer 0 の差分代数、Layer 2 の正則特異局所解析と theta、Laurent 付値、有限 Galois descent を用いる。楕円曲線上の束の一般論は ComplexKahlerGeometry の holomorphic bundle・complex torus の契約から受け取る。局所 q 差分 factorization、slope filtration、pure classification、q 差分 extension の index はこの層で証明する。

## Layer 4: q-Stokes データと局所解析分類

形式型 M₀ と gr(M) の同定を保持して解析的 extension を分類する。この同定を持つ classes の affine space、楕円曲線上の q-Stokes torsor、分岐後の有限群下降を比較する。非可換 H¹ は既存の torsor-class carrier を用い、この層では q 差分方程式に固有の係数 sheaf と分類写像を構成する。

### 4.1 graded marking を持つ分類問題

μ₁<⋯<μ_k を相異なる有理数とし、P_i を slope μ_i、rank r_i>0 の pure analytic 加群、M₀=⊕P_i とする。対象は解析差分加群 M と同型 g:gr(M)→M₀ の組である。二つの組の射 f:M→M′ は `g=g′∘gr(f)` を満たすものとし、その同型類の集合を F(M₀) とする。f は自動的に同型であり、与えられた二つの対象の間に存在すれば一意である。（[RSZ13], Definition 2.3.1；一意性は Theorem 2.2.4 の gr の faithfulness。）

commutative ℂ-algebra R に対しては K_R=R⊗_ℂK を用い、quotient を R⊗P_i と同定した filtered difference modules の同型類 F(M₀)(R) を定める。これは固定された graded factors を scalar extension した分類問題であり、任意 R 上の相対 Newton polygon や slope filtration の存在を前提にしない。（[RSZ13], §3.1.2 と Appendix A.3, A.6。）

- split object (M₀,id) を base point とし、R→S に沿った scalar extension、identity と composition を与える。
- Aut(M₀)=∏Aut(P_i) は g を h∘g に取り替えて F(M₀) に作用する。marking を忘れた解析同型類はこの作用の orbit と一致する。
- 同じ underlying module の異なる markings を保ち、marked class と unmarked class の comparison を与える。F(M₀) の affine structure は marked problem のものである。
- k=0 では零加群一つ、k=1 では指定された pure factor 一つを返す。

**Checks.**

- slopes 0,1、両 rank 1 では F(M₀)(ℂ) は §3.5 の extension parameter u を持つ。graded bases を a,b∈ℂ* で変えると u は a/b 倍されるので、u=1 と u=2 は異なる marked classes だが同じ unmarked class を与える。
- k=1 の F(P) は一点である一方、P の automorphism group は一般に非自明である。marked classes の集合を unmarked moduli groupoid と同一視すると、この automorphism を失う。
- R=ℂ[ε]/(ε²) で u=ε と u=0 は異なる marked extensions である。両者は唯一の reduced point では同じ u=0 に特殊化するため、closed points のみではこの functor を決められない。

*Needs:* §§3.2–3.5；0.1 の完全構造、0.2 の scalar extension、§3.5 の extension 比較；native の `MulAction` と `CategoryTheory.ActionCategory`。Aut(M₀) の marking への作用、orbit と unmarked class の比較は本節で構成し、affine representability は §4.2 の結論とする。

### 4.2 Birkhoff–Guenther normal form と affine representability

まず μ_i∈ℤ とし、P_i の系を z^μ_i C_i、C_i∈GL_(r_i)(ℂ) に取る。A₀=diag(z^μ_i C_i) とし、上三角 block U_ij の係数を有限次元空間 `K_(μ_i,μ_j)=⊕_(μ_i≤ℓ<μ_j) ℂz^ℓ` に制限した行列 A_U を考える。任意の marked analytic class に対し、この形の代表と、それへ移す diagonal blocks が identity の解析 gauge が一意に存在することを証明する。（[RSZ13], Proposition 3.3.1, Proposition 3.3.4, Definition 3.3.6, Corollary 3.3.7。）

一般の有理 slopes に対しても、§3.5 の Hom vanishing と Ext 次元、filtered extension の functor を用い、F(M₀) が ℂ 上の affine space に同型な scheme により表現され、その次元が `N=Σ_(i<j) r_i r_j(μ_j−μ_i)` であることを証明する。整数 slopes の U_ij の係数は、その一つの明示的 coordinate system を与える。（[RSZ13], Theorem 3.1.4, Theorem 3.3.5, Appendix A.6, Theorem A.6.1。）

- fixed coefficients の空間を選んだときの normal-form map と inverse を構成し、R⊗K による scalar extension と整合させる。
- 異なる許容 coefficient bands の normal forms を同じ marked class を介して比較する。座標そのものの一致を要求しない。
- k=2 の Baer sum と k≥3 の非可換 upper triangular gauge を区別する。affine-space の同型から canonical additive group law を結論しない。
- representability の parameter ring を R⊗K と明記する。任意の解析空間 T 上で z と t に共同解析的な係数の族を分類する定理とは別である。（[RSZ13], Remark 3.1.5。）

**Checks.**

- ranks (1,1)、slopes (0,3) では U₁₂=u₀+u₁z+u₂z²、N=3。
- ranks (1,1,1)、slopes (0,1,2) では U₁₂ と U₂₃ に各一係数、U₁₃ に二係数があり、N=1+1+2=4。
- 同じ三 block の unipotent matrices の積では (1,3) block に a₁₂b₂₃ が現れる。各 block を独立に足すだけでは gauge の積にならない。

*Needs:* §4.1；§§3.3–3.5；0.1 の短完全列と §3.5 の extension 比較・Baer 和；native の `AlgebraicGeometry.AffineSpace.homOverEquiv` と `AffineSpace.SpecIso`。S=Spec ℂ、X=Spec R、N 個の座標に特殊化し、R↦R^N を表現する affine space と環準同型に関する自然性を受け取る。F(M₀)(R)≅R^N の全 commutative ℂ-algebras 上の自然な比較は本節の q 分類定理として証明する。

### 4.3 meromorphic summation と許容方向

整数 slopes の normal form A_U と graded matrix A₀ を固定する。G は diagonal blocks が identity の upper triangular block group とする。形式的 gauge F̂∈G(K̂) で F̂[A₀]=A_U を満たすものは一意である。E_q 上の禁止方向 Σ(A₀) を、ある i<j と C_i,C_j の固有値 α,β に対し `c^μ_i α ≡ c^μ_j β mod q^ℤ` となる c の集合として定義する。これは有限集合である。各 c∉Σ(A₀) に対し F_c∈G(𝓜(ℂ*)) を構成し、F_c[A₀]=A_U、および (i,j) block の極は −c q^ℤ 上にのみあり位数は μ_j−μ_i 以下、という条件で一意であることを証明する。（[S24], §3.1.1, Theorem 3.1；[RSZ13], Chapters 5–6 の meromorphic summation。）

方向 c は E_q の点であり、その代表 c∈ℂ* を q の整数 powers 倍しても極の spiral は変わらない。theta は σ_qθ_q=zθ_q、zero divisor は −q^ℤ の規約を使い、F_c の極の符号をこれに合わせる。禁止方向の条件は同じ block 内の resonance を禁止するものではない。

- block の slope gap と極位数を対応させる。積・逆行列を取っても total gap の上限が保たれることを証明する。
- 二つの normal forms A_U,A_V に対し、F_V,c F_U,c⁻¹ が同じ極条件を持つ唯一の marked meromorphic isomorphism A_U→A_V であることを証明する。（[S24], Lemma 3.2。）
- coefficients と graded factors の許容な gauge change による比較を構成する。すべての方向で同じ F_c が得られることは仮定しない。

**Checks.**

- A₀=diag(1,a z)、A_U=(1,u;0,a z) では F_c=(1,f_c;0,1) と書け、equation は `a z σ_q f_c−f_c=u`。禁止方向は c≡a⁻¹ mod q^ℤ という一点である。
- この例の u=0 では F_c=I。u≠0 の formal coefficient は `−u aⁿq^(n(n−1)/2)` であり、形式解が一般に収束するという定義ではこの例を扱えない。
- gaps 1,1 を連結した (1,3) block の極位数の上限は 2 となる。すべての off-diagonal blocks を単純極に制限すると群の積で閉じない。

*Needs:* §§4.1–4.2、§§3.2–3.5；Layer 2 の theta、E_q の乗法写像、matrix-valued meromorphic functions；[S24] Theorem 3.1 の theta による変換と収束 Laurent 係数の解析を、この q-summation 定理の証明として構成する。

### 4.4 q-Stokes sheaf、torsor と cocycle

まず整数 slopes の A₀ を用いる。π:ℂ*→E_q とし、開集合 U⊂E_q 上の Λ_I(A₀) の sections を、F∈G(𝒪(π⁻¹U)) で `(σ_qF)A₀=A₀F` を満たすものと定義する。これは群の sheaf である。係数は一般には q-periodic な関数ではなく、各 off-diagonal block は `σ_qF_ij=z^(μ_i−μ_j)C_iF_ijC_j⁻¹` を満たす。（[S24], Corollary 3.4 の後の sheaf の定義；[RSZ13], §4.4。）

許容方向 c,d に対し S_cd=F_c⁻¹F_d と置くと、A₀ の horizontal automorphism であり、`S_cd S_de=S_ce` を満たす。Uc=E_q\{−c} とすれば、S_cd は Uc∩Ud 上の Λ_I(A₀) の section である。これから native torsor-class H¹(E_q,Λ_I(A₀)) の要素を作る。cover の refinement、trivialization の変更、section の gluing には既存の sheaf/torsor の一般論を使用する。

- Λ_I(A₀) の identity、積、逆、restriction を matrix operations で定義し、sheaf axiom を coefficient functions から証明する。
- S_cd の (i,j) block の極は −c q^ℤ と −d q^ℤ 上で、各位数は μ_j−μ_i 以下となる。対角 block は identity である。
- local trivializations の変更に対応する coboundary relation を同じ積順序で与え、cocycle の class が選択に依存しないことを証明する。
- G を group の sheaf として扱い、H¹ は pointed set として使う。非可換 coefficients に対する classes の積を無条件には定義しない。

**Checks.**

- 一つの slope のみなら G={I}、Λ_I は trivial sheaf、H¹ は一点となる。pure module の Jordan 部分はすでに A₀ に含まれている。
- 三つの directions では `(F_c⁻¹F_d)(F_d⁻¹F_e)=F_c⁻¹F_e`。順序を逆にすると一般の upper triangular matrices で cocycle law を満たさない。
- ranks 1,1、slopes 0,1 の block section は σ_qf=(a z)⁻¹f を満たす。通常の q-periodicity σ_qf=f を代わりに課すと Stokes sheaf が変わる。

*Needs:* §4.3；Layer 2 の E_q と正則・有理型関数の sheaves；SchemeAndStackFoundations §2.3 の torsor と native NonabelianH1、map、pullback、isomorphism classes；同 roadmap の sheaf descent の契約。

### 4.5 slope gap による有限 filtration と分類の実現

Λ_I(A₀) を slope gap δ>0 で filter する。δ より小さい gap の blocks を零にした subgroup を取り、δ より大きい gap の subgroup で割った quotient は、μ_j−μ_i=δ の horizontal Hom blocks の直和からなる additive sheaf である。commutator の gap は二つの gap の和以上になるため、有限段階で central extensions に分解できる。（[S24], §3.2.2, equations (3.3)–(3.6)；[RSZ13], §§6.2–6.3。）

各 (i,j) の additive sheaf は E_q 上の rank r_i r_j の holomorphic bundle であり、degree は `r_i r_j(μ_i−μ_j)`、slope は μ_i−μ_j<0 となる。H⁰ は零、H¹ の次元は `r_i r_j(μ_j−μ_i)`、H² は零である。この計算を §3.5 の difference-extension cokernel と比較する。degree は determinant の degree から計算し、rank を掛け忘れない。

この filtration と比較を用いて、§4.4 の cocycle の写像が bijection `F(M₀)→H¹(E_q,Λ_I(A₀))` であることを証明する。surjectivity では任意の Stokes torsor を lower-gap の quotient から順に持ち上げ、最後に実際の解析加群を得る。injectivity では同じ torsor class を与える二つの marked modules の間の解析 gauge を構成する。これは単なる次元の一致からの結論ではない。（[RSZ13], Theorem 4.4.1；[S24], Theorem 3.5 と §3.2.2。）

- q-specific central quotients の exactness と cohomology の作用を構成し、block の lifting obstruction を対応する coherent H² の零で解消する。
- split class を trivial torsor に対応させる。分類写像と inverse の両合成が identity になることを証明する。
- BG coordinates と gap filtration が与える affine structure を比較し、上の bijection をその構造と整合させる。H¹ の affine structure の導入には [S24] §3.2.2 の明示的な比較を用いる。
- native 非可換 H¹ の一般的理論を複製せず、ここではこの q-Stokes sheaf の block quotients と realization を証明する。

**Checks.**

- (r_i,r_j)=(2,3)、gap 1 なら Hom bundle の rank は 6、degree は −6、H¹ の次元は 6 である。degree を −1 とする式はこの値と整合しない。
- slopes 0,1,2、各 rank 1 では gap 1 の H¹ 次元は 2、gap 2 の次元は 2、合計は 4。中央 block の積項を落としても次元だけは同じになるので、§4.4 の cocycle law と併せて検証する。
- rank-two extension (1,1;0,z) の Stokes class は非自明である。もし trivial なら §3.2 の divergent formal solution が解析 gauge となって矛盾する。

*Needs:* §§4.1–4.4、§§3.5–3.7；SchemeAndStackFoundations §2.3 の native 非可換 H¹ と torsors；TopologicalSheafCohomology §§1.1–1.3 の abelian Čech・sheaf cohomology 比較；§3.7 の pure bundle degree、negative slope H⁰ vanishing、genus-one index と coherent H² vanishing。

### 4.6 任意有理 slopes の q-Birkhoff–Malgrange–Sibuya 対応

P_i の slopes を任意の有理数へ戻し、§3.6 の pure Laurent models により A₀=diag(B_i(z)) を表す。各 B_i とその逆は ℂ* 上で正則なので、§4.4 と同じ horizontal block 条件で Λ_I(A₀) を定義できる。r をすべての slope の共通分母、pʳ=q、z=wʳ とし、A₀′(w)=A₀(wʳ) を考える。μ_r は ramified coefficients と E_p に作用し、π_r:E_p→E_q、[w]↦[wʳ] は degree r の有限非分岐被覆である。（[S24], §§2.3.2, 3.3.1。）

ramification が誘導する二つの写像 `F(A₀)→F(A₀′)^μ_r` と `H¹(E_q,Λ_I(A₀))→H¹(E_p,Λ_I(A₀′))^μ_r` が全単射であり、整数 slope の分類写像と可換になることを証明する。従って任意有理 slopes に対して `F(A₀)≅H¹(E_q,Λ_I(A₀))` を得る。この bijection は、coherent に選んだ根を用いた common denominator r の選択とその refinement に依存しない。（[S24], Propositions 3.9–3.11, Theorem 3.13。）

- marked analytic gauge を Galois invariants へ下降し、cohomologous ramified cocycles の comparison も下降する。
- invariant な class が実際に下降することを、この upper triangular unipotent 設定で証明する。一般の group action の orbit の不変性を descent datum の存在と同一視しない。
- root の変更は §3.4 の descent-equivalence を通して比較する。root-dependent normal forms を比較写像なしに同一視しない。
- μ_i∈ℤ のとき r=1 を選べば §4.5 の分類そのものとなり、追加の quotient を生じない。

**Checks.**

- rank 1 の slope 0 と rank 2 の slope 1/2 を持つ graded object では、分岐前の F の次元は 1。r=2 の分岐後は slopes 0,1、ranks 1,2 なので次元は 2 となる。μ₂-invariants が元の一次元の分類を回復し、二次元の ramified class space 全体を返してはならない。
- r=2 の被覆 [w]↦[w²] の核は ±1 の classes である。E_p と E_q は同一の base として扱えず、同じ関数をそのまま下へ写すのではなく invariance が必要である。

*Needs:* §§3.3–3.6、§§4.1–4.5；Layer 2 の E_q と有限 isogeny の quotient 比較；finite Galois descent；SchemeAndStackFoundations §2.3 の torsor pullback；[S24] §3.3 の q-specific unipotent descent をこの節で証明。

### 4.7 射、marking の変更、係数拡張との整合

graded isomorphism h:M₀→N₀ に対し、(M,g)↦(M,hg) と horizontal automorphism sheaf の h による conjugation が、§4.6 の分類写像を通じて可換になることを証明する。analytically isomorphic な local models の比較、summation directions の変更、ramification の refinement についても comparison maps の composition と identity を保つ。（[S24], Lemma 3.8 と §3.2.2 の変数スケールに対する図式；[RSZ13], Remark 2.3.2 と Theorem 2.2.4。）

形式型 M₀ を固定し marking を忘れた analytic modules の groupoid は、Aut(M₀) の F(M₀) への作用 groupoid と同値になる。具体的には、二つの marked representatives の間の unmarked isomorphism の graded map が h を定め、h による marked classes の一致が同じ isomorphism を一意に回復する。これにより automorphism を保ったまま local Stokes classes を大域接続データへ渡す。

整数 slopes の mixed module については §4.2 の BG model を ℂ* 上の factor of automorphy として用い、slope filtration を持つ正則 bundle を構成する。filtration を保つ holomorphic bundle map が一意に局所加群の射へ戻ることを証明し、この filtered functor を exact、fully faithful、tensor-compatible とする。（[S09], §2.3.2, Theorem 2.4, Lemma 2.5。）この filtration を Harder–Narasimhan filtration と同一視しない（同文献 §2.3.3）。一般有理 slopes の接続データでは local module とその射を保持し、整数 slope のこの定理を全 filtered bundles の essential surjectivity へ強めない。

- marked-isomorphism の存在を native H¹ の equality と比較し、存在すれば唯一であることを gr の faithfulness から証明する。
- unmarked automorphism group が Aut(M₀) の該当 class の stabilizer になることを証明する。coarse orbit set と groupoid を別に返す。
- §4.1–4.2 の functor は任意 commutative ℂ-algebra R の scalar extension と整合する。§4.3–4.6 の解析 sheaf と分類写像は複素点上の主張として使用する。
- 任意の解析 parameter base 上で joint holomorphic な inverse、coarse moduli space の smoothness、または moduli stack の同値はこの点の分類からは導かない。必要な族の定理には、その定理固有の解析仮定と parameter ring を付ける。

**Checks.**

- split graded object の class は Aut(M₀) 全体で固定され、その unmarked automorphism group は Aut(M₀) となる。marked automorphism は identity のみなので、両者を同一視できない。
- slopes 0,1 の rank-one blocks の非零 extension class u に対し、graded automorphism (a,b) が class を固定する条件は a/b=1。split class u=0 の stabilizer (ℂ*)² と、u≠0 の diagonal ℂ* を区別する。
- R=ℂ[ε]/(ε²) の二つの classes 0,ε は、複素点の Stokes class だけでは区別できない。点の全単射から非被約 base 上の分類を主張することはできない。

*Needs:* §§3.2、3.6、4.1–4.6；native の `CategoryTheory.ActionCategory` の Groupoid 構造と `ActionCategory.stabilizerIsoEnd`；SchemeAndStackFoundations §2.3 の torsor と NonabelianH1 の同型類比較。local module の同型 groupoid と作用 groupoid の同値、および filtered bundle functor の充満忠実性は本節の q 固有の比較として証明する。

### Examples

二つの slopes の rank-one extension は、一つの divergent formal gauge と非自明な Stokes torsor を与える。三つの slopes では cocycle の非可換な積項が現れ、次元の計算だけでは分類の整合を保証できない。有理 slope 1/2 の例では、ramified class space の半分の次元が descent によって選ばれ、有限群作用を残す必要が見える。

### Dependencies

Layer 3 の local slope、extension、pure Laurent model と Layer 2 の theta・E_q を用いる。sheaf と非可換 H¹ の一般構成は SchemeAndStackFoundations、abelian Čech と derived cohomology の比較は TopologicalSheafCohomology に依存する。この層は q-Stokes sheaf、その gap filtration、meromorphic summation、任意有理 slope の解析分類とその自然性を所有する。

## Layer 5: 大域接続データと有理系の復元

### 5.1 局所解析加群の Laurent 多項式模型と延長

**定理。** R = ℂ[z,z⁻¹] 上で有限自由、可逆な半線形作用を持つ差分加群を考える。0 と ∞ の局所化がともに pure で、0 の傾きが μ、∞ の座標 w = z⁻¹ における元の作用 w ↦ q⁻¹w に対する Newton slope が −μ となるものを global pure model と呼ぶ。∞ で作用を逆転して |q| > 1 の規約に戻すと、数値的な傾きはさらに符号が反転して μ となる。元の作用では傾きの降順に現れる同じ underlying subobjects を、正規化後の傾きの昇順で添字付ける。この二つの操作を区別する。

Global pure な商を持ち、その傾きが 0 で狭義に増加する有限 filtration を備えた R 上の差分加群の圏から、ℂ({z}) 上の局所解析差分加群の圏への scalar extension は圏同値である。任意の有理傾きを含む。フィルトレーションを持たない任意の Laurent 多項式加群まで同じ圏とすることはない。（[VPR07], §4, Lemma 4.2, Theorem 4.3, Observations 4.5。原文の半線形作用・Newton polygon の符号は、3.1 の規約へ変換する。）

この模型を基底表示すると B ∈ GLₙ(R) であり、B と B⁻¹ は ℂ× 上で正則である。det B = czᵈ、c ≠ 0、d ∈ ℤ となる。局所解析加群に模型と局所同型を与え、模型間の局所 horizontal な射が一意に Laurent 多項式の射へ延長することを証明する。模型の選択変更の比較は、この充満忠実性から自然性と cocycle を満たす。

- 圏同値の単位・余単位を構成し、exactness、tensor、dual と比較する。
- ∞ の局所加群にも、w と作用の逆転を介して同じ模型定理を適用する。正規化された w の模型 σ_qZ = D(w)Z を戻す式は B_∞(z) = D(1/(qz))⁻¹、逆式は D(w) = B_∞(1/(qw))⁻¹ である。戻した行列は z の Laurent 多項式行列であり、元の σ_q に対する horizontal 式を満たす。
- 有理係数系と Laurent 模型の間の 0 で有理型な horizontal な germ は、q 差分方程式の反復により ℂ 全体へ一意に有理型延長する。∞ の germ は ℙ¹ ∖ {0} へ同様に延長する。
- 例えば A から B への射 H は H(qz) = B(z)H(z)A(z)⁻¹ を満たす。この式を q 軌道に沿って有限回ずつ反復し、重なりでの一致と有限点での極を処理する。延長の一意性には germ の一致と一致原理を用いる。

*Needs:* 0.1–0.4; 3.1–3.6 の pure 模型と slope filtration; 4.1–4.2 の filtered-extension 分類; 一変数有理型関数の一致原理。本定理の証明は pure 模型、extension class の比較、Hom の比較の順に行い、後の大域接続データを前提としない。

### 5.2 有理型行列の Birkhoff 分解と射影直線上の有理性

**定理。** 任意の R(z) ∈ GLₙ(ℳ(ℂ×)) に対し

    R = F_∞⁻¹F₀,
    F₀ ∈ GLₙ(ℳ(ℂ)),
    F_∞ ∈ GLₙ(ℳ(ℙ¹ ∖ {0}))

となる行列を構成する。F₀ とその逆は 0 で有理型、F_∞ とその逆は ∞ で有理型である。正則可逆な行列に限る分解とは異なり、有限点の零点・極を許す。任意の二つの分解に対して F′₀F₀⁻¹ = F′_∞F_∞⁻¹ は GLₙ(ℂ(z)) に属する。（[S00], §§2.2–2.3; [S03], Proposition 3.1.1.3 の証明で用いる Birkhoff lemma。）

証明は、R と R⁻¹ がともに正則な細い円環を選び、その transition matrix で射影直線上の正則ベクトル束を貼り合わせることから始める。円環の幅に |q| を越える条件は課さない。既存の GAGA によって束を代数化し、generic fibre の基底から大域有理型フレームを得る。二つの開集合上の行列を R によって延長して上の F₀、F_∞ を作る。射影直線上で大域有理型な関数は有理関数であることを使う。

- スカラーの場合、階数零の場合、block diagonal の場合の特殊化を与える。
- 二つの分解の比較行列の有理性と、その合成法則を証明する。
- 行列の各成分について ℳ(ℂ) ∩ ℳ(ℙ¹ ∖ {0}) = ℂ(z) を同じ ℂ× 上の関数体内の等式として与える。
- この存在定理から、パラメータに正則に依存する分解を無条件に選べるとは結論しない。

*Needs:* 1.1 の generic fibre と有限局所自由層; ComplexManifolds Milestones 3・5・7 の射影直線・貼り合わせ・束; ComplexComparisonPartII C0.3–C0.4、C1.9、C2.2 の coherent GAGA と束・切断比較; AlgebraicCurves §§1.1–1.2、3.1–3.2 の有理関数と有限 divisor。

### 5.3 局所解析データの楕円曲線上の実現

**構成・定理。** 5.1 で選んだ Laurent 模型 B を 2.1 により E_q 上の正則束 V(B) へ降下する。局所加群 L の模型と局所同型をデータに含めた圏をまず用い、模型変更の一意な比較を降下して、選択に依存しない関手 V₀、V_∞ を自然同型の意味で構成する。0 と ∞ のいずれも、ℂ× 上の同じ z 座標と同じ q 作用へ戻して降下する。（[VPR07], Theorem 4.3 と §2 の bundle construction の組合せ。）

局所 horizontal な射を Laurent 模型間の射へ延長してから束の正則な射とする。この関手は exact で tensor、dual、determinant と整合する。ただし、局所加群を忘れて裸の正則束だけを残す関手が充満であるとは主張しない。局所の射であるという条件を、接続データの射の定義に残す。

- 模型・基底・局所同型の変更に対する自然比較を構成し、三つの選択の cocycle を証明する。
- 直接和、tensor、dual と比較する同型は局所での比較から一意に延長し、monoidal coherence を満たす。
- 対象間の有理型束同型 φ : V₀(L₀) ⇢ V_∞(L_∞) は、pullback 後の行列 R で

      (σ_qR)B₀ = B_∞R

  を満たすものと同値である。R の変更と φ のフレーム変更を比較する。
- 局所差分加群の射から延長された Laurent 多項式行列の kernel・cokernel を用いる。その cokernel の torsion の support は ℂ× の有限集合かつ q 不変なので零である。したがって R = ℂ[z,z⁻¹] 上の該当加群は有限自由となり、短完全列は underlying R 加群として分裂する。解析化と descent によって束の完全列を得る。任意の正則同変写像にこの有限 support の議論を適用しない。

*Needs:* 2.1; 3.6–3.7 の pure 束の比較; 5.1; 正則ベクトル束の descent、tensor、exact sequence。

### 5.4 全有理 q 差分加群と接続データの圏同値

**定理。** 接続データの対象を (L₀,φ,L_∞) とする。L₀ と L_∞ はそれぞれ 0 と ∞ の局所解析 q 差分加群であり、φ : V₀(L₀) ⇢ V_∞(L_∞) は有理型束同型である。二つの対象間の射は局所 horizontal な射の対 (f₀,f_∞) で

    φ′ V₀(f₀) = V_∞(f_∞) φ

を満たすものとする。この圏と、ℂ(z) 上の有限次元 q 差分加群の圏との ℂ 線形な exact tensor 圏同値を構成する。共鳴、非半単純部分、任意の有理傾きを許す。これは [VPR07], Theorem 4.3 と 5.2 の有理型 Birkhoff 分解を組み合わせた帰結であり、[S03] の正則特異分類だけを一般不確定特異点の定理として引用しない。

**本質的全射の構成。** L₀、L_∞ の模型 B₀、B_∞ を選び、φ の lift を R とする。R = F_∞⁻¹F₀ と分解すると

    A = (σ_qF₀)B₀F₀⁻¹ = (σ_qF_∞)B_∞F_∞⁻¹

となる。右の二つの行列はそれぞれ ℂ と ℙ¹ ∖ {0} で有理型で、重なりで一致するため A ∈ GLₙ(ℂ(z)) である。元の局所加群と接続同型を回復する比較を明示する。

**充満忠実性の構成。** 別の対象の分解を N₀、N_∞ とし、射の局所 Laurent 表示を f₀、f_∞ とすると

    H = N₀f₀F₀⁻¹ = N_∞f_∞F_∞⁻¹

は有理行列であり、(σ_qH)A = A′H を満たす。逆に有理 horizontal な射は局所化してこの互換条件を満たす。両操作が互いに逆であることを証明する。

- 有理系から局所模型への germ gauge を 5.1 で延長し、その比から接続同型を構成する。
- 模型、局所 gauge、Birkhoff 分解の選択変更に対する自然同型、単位・余単位と triangle identity を与える。
- Direct sum、tensor、dual、kernel・cokernel、短完全列を比較する。Tensor の coherence は局所模型の一意な比較を通じて証明する。
- この圏同値は generic な有理差分加群を分類する。元の束の次数・局所格子・framing を回復するには Layer 1 の追加データを保持する。

*Needs:* 0.1–0.4; 1.1; 5.1–5.3。証明の順序は局所模型、接続同型の降下、Birkhoff 分解、射の貼り合わせであり、等モノドロミー変形は前提としない。

### 5.5 正則特異の場合の Birkhoff 接続行列

**定理。** 0 と ∞ で正則特異な有理 q 差分加群について、5.4 を三つ組 (C₀,M,C_∞) に特殊化する。C₀、C_∞ は可逆定数行列、M ∈ GLₙ(ℳ(ℂ×)) は

    M(qz)C₀ = C_∞M(z)

を満たす。射は 2.5 の局所 Laurent horizontal な射の対で、M′f₀ = f_∞M を満たすものとする。この三つ組の圏と正則特異有理 q 差分加群の圏は同値である。（[S03], Proposition 3.1.1.3, pp. 947–948。）

基本解 Y₀ = F₀E_(C₀)、Y_∞ = F_∞E_(C_∞) を選ぶと

    P = Y_∞⁻¹Y₀ = E_(C_∞)⁻¹ M E_(C₀),
    σ_qP = P

となり、P は E_q 上の有理型行列として降下する。局所基本解と局所定数型を伴う P を Birkhoff 接続行列による表示とする。

- 定数化、局所指数の q 整数冪移動、共鳴する Laurent 射に対する M と P の変換式を与える。
- 基本解の変更 Y_j ↦ Y_jD_j、σ_qD_j = D_j に対し P ↦ D_∞⁻¹PD₀ とする。
- 三つ組 (C₀,M,C_∞) の tensor は成分ごとの tensor でよいが、theta を用いた基本解の P の tensor 表示には 2.2 の因子が入る。二つの表示の monoidal comparison を明示する。（[S03], §3.2.1。）
- P だけを残した分類を述べず、局所定数型と許容される射を保持する。

*Needs:* 2.3–2.5; 5.4; E_q 上の有理型関数と行列。

### 5.6 局所データ・格子・基本解を忘れる関手

**構成・定理。** 束上の q 接続と局所格子、generic な q 差分加群、5.4 の接続データ、局所束 V₀・V_∞、5.5 の基本解付き表示の間の比較・忘却関手を構成する。各比較について、保持する射と失うデータを明記する。一般の圏同値と、同型類の集合の対応を区別する。

局所加群を裸の束へ送る関手が一般に充満でないことを、A = 1 と A′ = z で示す。局所 meromorphic な horizontal 射 f は σ_qf = zf を満たすが、付値比較から f = 0 である。一方 Θ_q は ℂ× 上でこの式を満たし、商上では O_(E_q) から次数一の theta 束への非零な正則射を与える。この射は局所 germ の射から来ない。（[VPR07], §2 の bundle construction; [S09], §2.3.3 の slope filtration と bundle filtration の区別。）

- 5.4 の射に局所 horizontal 条件を残す必要性を、上の例で証明する。
- 1.2 の格子の忘却により異なる束の模型が同じ generic module へ写ることを、O(d∞) の例で比較する。
- P のみの忘却では分類できないことを、q = 2、定数系 A = 1 と A′ = 3 で示す。両端に同じ基本解を用いれば両者の P は 1 だが、3 ∉ 2^ℤ なので有理 gauge 同値ではない。
- 形式型の marking を忘れる際の自己同型群の作用を 4.7 と比較し、代表を選ぶ操作と quotient を取る操作を分ける。

*Needs:* 1.2、1.4; 2.2、2.5; 3.7; 4.7; 5.3–5.5。

### Examples

A = zᵐ は Laurent 模型としてそれ自身を選べる。w = z⁻¹ では元の作用に対する slope は −m であり、作用を逆転すると係数 qᵐwᵐ、slope m となる。行列 [[0,z],[1,0]] とその逆も Laurent 行列であり、傾き 1/2 の階数二の局所模型を含む。

階数一の正則特異三つ組では M(qz)c₀ = c_∞M(z) となる。c₀ = c_∞ のとき M は任意の非零な楕円有理型関数でよく、5.2–5.4 はこの接続データから有理係数系を復元する。5.6 の例は、局所加群・基本解の正規化・束の格子をそれぞれ保持する理由を与える。

### Dependencies

5.1 は formal/pure 分類と解析的 filtered-extension 分類から Laurent 模型を得る。5.2 は一般の曲線・bundle GAGA と有理型貼り合わせを用い、5.3 の descent と合わせて 5.4 の圏同値を証明する。5.5 は正則特異部分圏への特殊化、5.6 は忘却関手の性質である。大域比較の本質的全射と充満忠実性を別々に証明し、族の正則性をこの層から自動的に結論しない。

## Layer 6: 接続保存変形と整合する時間輸送

### 6.1 時間 groupoid に沿う q 等モノドロミー

**構成・定理。** 時間を小さい groupoid T とし、各対象 t に有理 q 差分加群 M_t を与える。5.4 の比較関手を D と書く。各時間の射 g : t → t′ に接続データの同型 b_g : D(M_t) → D(M_t′) を与え、b_id = id、b_(hg) = b_hb_g を要求する。これを接続保存の coherent な時間輸送とする。

5.4 の充満忠実性により、各 b_g は一意な有理 horizontal 同型 B_g : M_t → M_t′ に持ち上がる。合成・単位・逆の法則も持ち上がる。逆に、このような B_g の族から接続データの輸送が得られる。したがって、指定した M_t の間の二種類の coherent な輸送のgroupoid は同値である。接続データの対象の族から始める場合には、5.4 の quasi-inverse と単位・余単位を用いて対象と輸送をともに持ち上げる。この定理は大域圏同値の形式的帰結として証明する。

- 時間 groupoid の関手による pullback、部分groupoid への制限、基点変更を構成する。
- 時間輸送の間の自然同型と、有理 q 接続の horizontal な自然同型を比較する。
- 同じ同型類という条件だけでは b_g の選択と合成則が与えられないことを明示する。
- 対象の自己同型群は時間の stabilizer の作用先として保持し、無条件の一意な等モノドロミー輸送を主張しない。

*Needs:* 0.1–0.3; 5.4; native の圏、groupoid、関手、自然同型。groupoid一般の transport を所有し直さず、q の比較関手による持ち上げとその式を本節で与える。

### 6.2 可換な時間方向と q 零曲率方程式

**定理。** 集合 T 上の互いに可換な全単射 T₁,…,T_r を固定し、M_t を行列 A(z,t) で表示する。一つの階数成分 n を取り、各方向の可逆有理行列 B_i(z,t) ∈ GLₙ(ℂ(z)) は

    A(z,T_i t)B_i(z,t) = B_i(qz,t)A(z,t)

を満たすとする。これらが ℤʳ の action groupoid 上の coherent な輸送を定めることは、すべての i,j,t について

    B_j(z,T_i t)B_i(z,t) = B_i(z,T_j t)B_j(z,t)

が成り立つことと同値である。負方向は B_(−i)(z,t) = B_i(z,T_i⁻¹t)⁻¹ とする。任意の有限経路の積が出発点 t と総変位 k ∈ ℤʳ だけに依存し、B_(k+ℓ)(z,t) = B_k(z,T_ℓt)B_ℓ(z,t) となることを証明する。

第一式は空間シフト σ_q と時間方向の互換性、第二式は異なる時間方向の互換性であり、別々の条件である。一般群では生成元に対する式に加えて全定義関係に沿う積の一致を課す。双有理な時間作用では、これらを関数体上の等式とし、各有限経路について全中間写像が定義される共通開集合へ制限する。（[B04], Introduction (3q)–(7q) の互換式を含む一般的な cocycle の整理。）

- 正・負の経路、二方向の square、単位経路、三方向の再順序付けの一致を証明する。
- 時間依存の gauge G(z,t) に対し B′_i = G(z,T_it)B_iG(z,t)⁻¹ とし、二種類の互換式の不変性を示す。
- 部分格子、一方向、周期的な時間の商への制限を扱う。周期の輸送を恒等とするには、その周期に対する追加の関係が必要である。
- 6.1 の抽象輸送と、この行列表現の相互変換を構成する。

*Needs:* 0.3; 6.1; 整数格子・群の presentation と有限積。有理写像の定義域に関する制限は Layer 7 の有限範囲の存在定理で具体化する。

### 6.3 束の模型・格子・framing と輸送の一意性

**定理。** 6.1 の generic な輸送 B_g に対し、各時刻の束の模型と局所格子を指定する。B_g が正則な束同型へ持ち上がることは、全閉点で B_gΛ_(t,p) = Λ_(t′,p) が成り立つことと同値である。一般には B_g は 1.4 の modification を与える。determinant divisor の差、束の次数、有限特異軌道の変化を Layer 1 の式から計算する。

有理系間の horizontal 射について、q が無限位数で、z₀ ∈ ℂ× の全 q 軌道が二つの系の特異集合を避けるとする。z₀ で正則な二つの有理 horizontal 射が z₀ で一致すれば、q 差分式によって全 q 軌道で一致し、有理関数の零点の有限性から同じ射となる。したがって、この点の framing に整合する輸送は、存在すれば一意である。指定した任意の線形写像が輸送へ延長するとは主張しない。

- 格子の輸送と合成、disjoint な modification、時間 cocycle を比較する。
- 一つの時間の射 g とその始点・終点を固定する。有理 horizontal 同型の集合 Isom(M_t,M_t′) は、非空なら Aut(M_t) の右 torsor かつ Aut(M_t′) の左 torsor となる。時間全体の coherent な輸送の集合をこの一つの torsor と同一視しない。
- 固定 determinant、局所型、flag を課す場合には、B_g がその追加データを保存する条件を独立に与える。
- 特異点移動の任意の指定から輸送が存在するとはせず、存在定理の仮定と線形代数的制約を保持する。

*Needs:* 1.2–1.6; 6.1–6.2; 有理関数の零点、q の無限位数性、torsor の基本契約。

### 6.4 接続行列の不変性と有理 gauge の判定

**定理。** 0 と ∞ で正則特異な二つの有理系 A、A′ について、5.5 の基本解 Y_j、Y′_j を選ぶ。ある有理 horizontal gauge B が Y′_j = BY_j を両端で満たせば、P′ = P である。

逆に P′ = P とし、二つの比 Y′₀Y₀⁻¹、Y′_∞Y_∞⁻¹ がそれぞれ 0、∞ へ有理型に延長すると仮定する。接続行列の一致から両者は ℂ× 上で一致し、5.2 の有理性によって一つの B ∈ GLₙ(ℂ(z)) となる。この B は A′B = (σ_qB)A を満たす。したがって、端点での有理型延長を含む正規化されたデータに対して、接続行列保存と有理 gauge による輸送が同値になる。（[S03], §3.1 の接続分類からの帰結。）

- 局所基本解の変更 Y′_j = BY_jD_j、σ_qD_j = D_j の場合には P′ = D_∞⁻¹PD₀ となる。
- 局所指数の q 整数冪移動、共鳴する局所射、framing の選択を端点条件へ明示的に反映する。
- P = P′ だけでは端点条件が従わないことを 5.6 の定数系 1 と 3 の例で確認する。
- 不確定特異点を含む系では、P だけによる同じ判定を無条件に用いず、6.1 の局所解析加群・Stokes データを保持した接続データで判定する。

*Needs:* 2.3–2.5; 5.2、5.4–5.6; 6.1。非共鳴を一般の仮定にはせず、特定の基本解の正規化を用いる場合に必要な条件だけを加える。

### 6.5 正則特異の局所 gauge の解析的パラメータ依存

**定理。** S を複素多様体とし、A(z,s) が { |z| < ρ } × S 上 jointly holomorphic、C(s) = A(0,s) ∈ GLₙ(ℂ) とする。すべての s と m ≥ 1 について線形作用素 X ↦ qᵐXC(s) − C(s)X が可逆であると仮定する。このとき S の各点の近傍で、z の共通の正の半径を取り、H(0,s) = I、σ_qH · C = AH を満たす一意な jointly holomorphic gauge H(z,s) を構成する。

証明は 2.4 の recurrence をパラメータ付きで行う。S のコンパクト部分上では C と C⁻¹ が有界であり、大きな m について逆作用素の評価は O(|q|⁻ᵐ) となる。残る有限個の m は非共鳴仮定とコンパクト性で一様に評価する。A の Cauchy estimate と majorant series により H の局所一様収束を得る。これは [S00], §§1.1.1、1.1.3 の定数化の証明を、明示した一様評価の下で族へ拡張する補題である。

- 重複固有値と Jordan 部分を許す。固有ベクトルをパラメータに正則に選ぶことを前提としない。
- Holomorphic な S′ → S に沿う pullback と構成が一致することを、一意性から示す。
- 非共鳴 locus の局所開性を、有限個の小さい m と大きい m の一様評価から示す。
- 共鳴を横切る族、任意の Stokes marking、任意の局所解析分類に対する同じ一様性を、この補題の結論には含めない。

*Needs:* 2.4; native の有限次元 holomorphic matrix families、一様収束、Cauchy estimate; ComplexKahlerGeometry §3.1 の局所解析。点での圏同値だけをパラメータ正則性の根拠としない。

### 6.6 端点比較の貼り合わせと相対的な有限 pole bound

**構成。** 複素多様体 S 上では、X = ℙ¹ × S の正則有限階数 bundle と section sheaf、有限平坦な相対 effective Cartier divisor D_A、および X ∖ D_A 上の正則同型 A : E ≅ σ_q*E を用いて、解析的な相対 q 接続の groupoid を構成する。射は正則 horizontal な束同型とする。有理型同型による modification も、この解析的な層の上で定める。これは 1.6 と同じ q 構造の定義を解析的 carrier に適用したものであり、一般の S をスキームとして扱うものではない。

**定理。** S を複素多様体とし、この解析的相対 q 接続の行列表現を与えた二つの族 A、A′ を取る。0 側・∞ 側の比較行列 B₀、B_∞ が、それぞれ (ℙ¹ ∖ {∞}) × S と (ℙ¹ ∖ {0}) × S 上で jointly meromorphic であり、重なり ℂ× × S 上で一致し、それぞれ horizontal 式を満たすとする。B と B⁻¹ の極が、それぞれ ℙ¹ × S 上の有限平坦な相対 effective Cartier divisor D、D′ によって重複度を含めて一様に抑えられると仮定する。正確には、貼り合わされた B の各成分が O(D) の正則切断、B⁻¹ の各成分が O(D′) の正則切断であるという、全空間上の条件を課す。

このとき、S の各点の近傍で、貼り合わされた B を z について有理、パラメータについて正則に依存する係数を持つ行列として表示できる。具体的には、D と D′ の support を避ける無限遠点を持つ固定した affine 座標を選び、D を monic polynomial p(z,s) の零 divisor と表す。pB は有限次数の行列多項式となり、その係数は s に正則に依存する。逆行列も D′ を用いて同様に表示し、補助的な affine 座標から元の z 座標へ戻す。極の衝突を許し、個々の根の正則なラベル付けは要求しない。

証明では相対 Cartier divisor の局所 Weierstrass 表示とその有限積を使い、極を消した関数に一様な無限遠での次数評価を適用する。係数の正則性は Cauchy integral または固定有限個の導関数で得る。これにより「各 s で有理」という条件を、族としての有理係数表示へ置き換えるために必要な有限 pole bound を明示する。

- 局所的な有理表示の変更、holomorphic base change、合成、逆を比較する。
- 6.2 の square identity が族の正則な射の等式として貼り合わさることを示す。
- 指定した divisor と格子に整合する B を、上の解析的な相対 groupoid の同型または modification として比較する。1.6 との比較は、滑らかな分離的有限型 ℂ 基底と代数的な束・divisor・q 同型を与え、それらを analytification する場合に限って構成する。
- 一般の点ごとの 5.4 の圏同値から、上の jointly meromorphic な比較や一様 pole bound が自動的に選べるとは主張しない。非被約基底の一般論は 1.6 の層による定義を用い、本節の点と holomorphic function による証明の対象に含めない。

*Needs:* 5.2、5.4; ComplexKahlerGeometry §§3.1–3.2 のパラメータ解析と Weierstrass preparation、§§4.1・4.4 の正則 bundle と section sheaf; ComplexManifolds Milestone 7 の解析的 pullback と gluing; 相対 Cartier divisor、有限平坦な零 divisor、球面上の有理関数。スキーム版との比較には 1.6 と ComplexComparisonPartII C0.3–C0.4 の analytification を用いる。相対極を消す上の有限次元表示と base change の補題は本節で証明する。

### 6.7 解析的に定値化された族と連続時間の整合式

**構成・定理。** S の局所座標近傍 U と基点 s₀ に対し、6.6 の条件を満たす B(z,s)、B(z,s₀) = I が

    A(z,s)B(z,s) = B(qz,s)A(z,s₀)

を満たすとする。B(z,s′,s) = B(z,s′)B(z,s)⁻¹ を定めると、U の pair groupoid 上の coherent な輸送になる。任意の局所座標 s_i に対し Ω_i = (∂_iB)B⁻¹ は z について有理であり

    ∂_i A = Ω_i(qz,s)A − AΩ_i(z,s),
    ∂_iΩ_j − ∂_jΩ_i = [Ω_i,Ω_j]

を満たす。座標変更、holomorphic pullback、時間依存 gauge に対する変換式を与える。接続データは B による局所正規化の下で定値となる。

逆方向は、上の整合式を満たす Ω_i の積分が、指定した端点で jointly meromorphic な基本行列 B と一様な有限 pole bound を持つと仮定して述べる。その B は、基点での恒等式と積分の一意性により上の q horizontal 式を満たし、6.6 によって有理な輸送となる。具体的には B(qz,s)⁻¹A(z,s)B(z,s) の各パラメータ微分が零であることを計算し、連結な近傍で基点の値と一致させる。Flatness だけから端点の有理型性や有理な B を結論しない。

- 離散時間の 6.2 と連続パラメータの整合式を、同じ q 接続を保つ二つの輸送として比較する。
- 基本行列の右側のパラメータ独立な変更、基点変更、局所定値化の重なりの cocycle を扱う。
- 連結な U 上で「同じ同型類」という点ごとの条件と、ここで指定した解析的定値化を区別する。
- 本節は q 接続の族の帰結であり、微分方程式側の局所 Levelt–Turrittin 分類や differential Riemann–Hilbert 対応を前提にしない。

*Needs:* 6.1、6.5–6.6; 有限次元パラメータの正則微分、微分が零の正則関数の局所定値性。逆方向では meromorphic 基本行列と pole bound を入力として保持する。

### Examples

A = I₂、時間作用 T₁ = T₂ = id とし

    U = [[1,1],[0,1]],    V = [[1,0],[1,1]]

を二方向の B とする。各方向の q horizontal 式は成り立つが、UV = [[2,1],[1,1]]、VU = [[1,1],[1,2]] は異なり、時間の square identity は成り立たない。方向ごとの Lax 式だけでは coherent な等モノドロミー輸送にならない。

階数 n の自明系の horizontal 自己同型群は GLₙ(ℂ) であり、同型類の一致から一意な輸送は得られない。適切な点での framing を与えると 6.3 の一意性が適用される。5.6 の定数系 1 と 3 は、6.4 の endpoint 条件を落とせない例である。

極の衝突を含む解析族として、q = 2 と

    B(z,s) = z²/(z² − s),
    A(z,s) = 4(z² − s)/(4z² − s),
    Ω(z,s) = 1/(z² − s)

を取る。A(z,0) = B(z,0) = 1、AB = B(2z)、∂_sA = (Ω(2z,s) − Ω(z,s))A となる。B の pole bound は z² − s = 0 という次数二の有限平坦 divisor、B⁻¹ の bound は 2[0] である。s = 0 で根が衝突しても、6.6 の全空間上の仮定を満たす。

右 Maurer–Cartan 式の非可換な例として、標準行列単位 E₁₂、E₂₁ と B = (I + sE₁₂)(I + tE₂₁) を取る。Ω_s = E₁₂、Ω_t = [[s,−s²],[1,−s]] となり、∂_sΩ_t − ∂_tΩ_s = [[1,−2s],[0,−1]] = [Ω_s,Ω_t] を得る。

### Dependencies

5.4 の圏同値から 6.1 の輸送の同値を得て、6.2 で行列の cocycle と比較する。6.3 は Layer 1 の格子を戻し、6.4 は Layer 2 の基本解表示を扱う。6.5–6.7 は、それぞれ局所的な解析的 gauge、一様 pole bound を持つ大域貼り合わせ、その解析的定値化の微分を扱う。点での分類と、族の存在・正則性・時間 coherence を別の契約として証明する。

## Layer 7: 多項式 q 接続の離散 Schlesinger 変換

任意の階数 n ≥ 1 と次数 d ≥ 1 について、最高次係数 L ∈ GLₙ(ℂ) を固定した多項式 q 接続を考える。有限特異点を d 個の群に分け、群ごとの q シフトを可換な双有理変換として構成する。この層の代数的結果には q ∈ ℂ× の無限位数性で十分であり、解析的接続データとの比較では |q| ≠ 1 を用いる。

根のラベル aᵢ,α ∈ ℂ×（1 ≤ i ≤ d, 1 ≤ α ≤ n）を固定し、異なるラベルの比が q^ℤ に入らないとする。この特異型の条件は本層の具体的変形定理に課す。一般の局所分類・大域分類には遡及させず、L の対角化可能性も仮定しない。[B04] の一般再分解定理と q の場合の構成（Remark 4.14）から、以下の目標を得る。

### 7.1 一次行列因子の順序を変える分解定理

**定理。** 互いに交わらない有限集合 S₁, …, S_N ⊂ ℂ がそれぞれ n 個の相異なる数からなり、Sp(Xᵢ) = Sᵢ とする。任意の置換 π ∈ 𝔖_N に対し、初期値の非空 Zariski 開集合上で

    (zI − X₁) ⋯ (zI − X_N)
      = (zI − Y_π(1)) ⋯ (zI − Y_π(N)),
    Sp(Yᵢ) = Sᵢ

を満たす Yᵢ が一意に存在する。その成分は Xᵢ の成分の有理関数であり、逆置換は逆の双有理変換を与える。置換の合成と再分解の合成が整合することを証明する。

二因子 (zI − X)(zI − Y) について、スペクトルが互いに交わらなければ Sylvester 方程式

    YΛ − ΛX = I

の解 Λ が一意に存在する。det Λ ≠ 0 の開集合では

    S = X + Λ⁻¹ = Λ⁻¹YΛ,
    T = Y − Λ⁻¹ = ΛXΛ⁻¹

により (zI − X)(zI − Y) = (zI − S)(zI − T) を得る。この非消滅条件を隣接交換の定義域とし、任意の有限再分解に対して各中間段階の同じ条件を課す。一意性は、二つの分解を比較した行列の極が互いに素なスペクトル集合にしか存在せず、無限遠で単位行列に近づくことから示す。（[B04], Lemma 3.11, Proof 2; Lemma 4.3.）

同じ結果から、A(z) = L(zI − C₁) ⋯ (zI − C_d) の指定スペクトル群を持つ唯一の monic 一次右因子 zI − Bᵢ を構成する。各根 a_α の核ベクトル v_α ∈ ker A(a_α) を列とする行列 V に対し、正確な条件は det V ≠ 0 であり、Bᵢ = V diag(a_α)V⁻¹ を得る。核ベクトルの倍率に依存しないこと、因子表示と右因子表示の変換が有理であることを証明する。（[B04], Lemmas 3.2–3.4; Lemma 4.2.）

- 同時定数共役 Xᵢ ↦ GXᵢG⁻¹ に対する再分解の自然性を、Sylvester 解の一意性から示す。
- 一次右因子を取り出した monic 商 Dᵢ の係数も一意かつ有理に決まることを、行列多項式の右除算から示す。
- 因子をブロックごとに再分解する操作と全体の再分解を比較し、各ブロック内のスペクトル型が一致する場合の積の一意性を与える。（[B04], Proposition 4.8.）

*Needs:* 0.3 の行列表示; native の `Module.End.iSup_maxGenEigenspace_eq_top`、`Module.End.map_genEigenspace_le`、`LinearMap.injective_iff_surjective`、行列多項式と adjugate/determinant。スペクトルが交わらない作用素の intertwiner は零であることから Sylvester operator の単射性を示し、有限次元性により可逆性を得る。この適用と解の有理依存を本節の再分解の証明に含める。

**Check.** n = 1 では再分解はスカラー因子の並べ替えになる。二つのスペクトル群が交わる場合には、一意性定理の仮定が満たされない。

### 7.2 一群の特異点を動かす有理 gauge

**構成・定理。** Sp(Cᵢ) = {aᵢ,α}_α を持つ一般の因子族に対し、7.1 から A(z) = L Dᵢ(z)(zI − Bᵢ) と書き、Rᵢ(z) = I − z⁻¹Bᵢ を定める。この有理行列により

    A⁽ⁱ⁾(z) = Rᵢ(qz) A(z) Rᵢ(z)⁻¹
            = (zI − q⁻¹Bᵢ) L Dᵢ(z)

を得る。A⁽ⁱ⁾ は次数 d、最高次係数 L の行列多項式であり、det A の根のうち群 i だけが aᵢ,α ↦ q⁻¹aᵢ,α に移る。他の根は変わらない。

Bᵢ は可逆であり、端点では

    A⁽ⁱ⁾(0) = q⁻¹ Bᵢ A(0) Bᵢ⁻¹,
    Rᵢ(∞) = I

となる。0 の局所固有値はすべて同時に q⁻¹ 倍され、無限遠の最高次係数は固定される。有限特異点の移動と 0 の格子変更を Layer 1 の記述と比較し、行列式の divisor の変化が一致することを証明する。

証明は右因子を代入した gauge 恒等式と、両端での展開による。新しい多項式を指定スペクトルの順序へ再分解すると、入力因子族から出力因子族への有理写像 Tᵢ が得られる。（[B04], Introduction (3q)–(7q), Remark 4.14, および 7.1 からの帰結。）

- Rᵢ(z)⁻¹ = z(zI − Bᵢ)⁻¹ と det Rᵢ(z) = z⁻ⁿ∏_α(z − aᵢ,α) を与え、gauge と逆 gauge の極を指定する。
- Rᵢ の局所 Smith 型は 0 で (−1,…,−1)、各 aᵢ,α で (0,…,0,1)、∞ で (0,…,0) となる。これらから Layer 1 の格子変更の長さを回収する。
- Rᵢ とその逆がともに正則な開部分では通常の束同型として扱い、残る有限個の局所格子だけを変更する表示と比較する。

*Needs:* 7.1; 0.3 の horizontal gauge; 1.3–1.5 の determinant divisor と局所格子変更。

**Check.** Rᵢ = zI − Bᵢ とすると最高次係数は qL に変わる。本構成の z⁻¹ により最高次係数が L のまま保たれる。

### 7.3 可換変換の有限範囲での存在と一意性

**定理。** 任意の N ≥ 0 に対して、指定スペクトルを持つ初期因子族の空間の非空 Zariski 開集合上に、maxⱼ |kⱼ| ≤ N を満たす k ∈ ℤᵈ で添字付けられた Cᵢ(k) を構成する。有限範囲の族に対する以下の等式は、現れるすべての添字が指定範囲に属するときに要求する。Cᵢ(0) = Cᵢ、Sp(Cᵢ(k)) = q^(−kᵢ) Sp(Cᵢ) とし、C′ⱼ = Cⱼ(k + eᵢ) に対して

    (zI − q⁻¹Cᵢ) ⋯ (zI − q⁻¹C_d) L (zI − C₁) ⋯ (zI − Cᵢ₋₁)
      = (zI − q⁻¹C′ᵢ₊₁) ⋯ (zI − q⁻¹C′_d) L (zI − C′₁) ⋯ (zI − C′ᵢ)

を要求する。この族は一意で、その成分は初期値に有理に依存する。異なる方向を施す順序は結果に影響せず、TᵢTⱼ = TⱼTᵢ が双有理写像の等式として成り立つ。すべての方向を一度ずつ施すと

    Cᵢ(k + 1) = q⁻¹ L⁻¹ Cᵢ(k) L,    1 = (1, …, 1)

となる。

証明では因子列 pₖ = zI − Qₖ を Qₖ₊d = qLQₖL⁻¹ で延長する。スペクトルの q^ℤ 分離により異なる因子の型が分離される。7.1 の一意な再分解から因子列の可換な輸送を作る。所定の有限範囲で必要な再分解と逆再分解は有限個であり、その定義域の非空開集合を取る。L の上三角化は、代数閉体上の固有値から不変直線を取り、その quotient に次元帰納法を適用して得る。非空性は、その基底を選び、すべての Cᵢ をその基底で対角行列とする点から示す。ねじれた因子列は上三角のままであり、各 Sylvester 解も上三角で、その対角成分は対応する二つの固有値の差の逆数になる。q^ℤ 分離によりこれらは零にならず、必要な行列式条件がすべて成立する。経路独立性、逆変換、同時シフト式をこの構成から証明する。（[B04], §4(a)–(c), Proposition 4.8, Theorem 4.9, Remark 4.14; q の場合の式は Introduction (7q).）

- Monic degree r の行列多項式に対する P(z) ↦ qʳLP(q⁻¹z)L⁻¹ を半群の自己同型とし、一意な再分解がこれと可換することから因子列のねじれ条件の保存を示す。
- 大きい有限範囲で得た族を小さい範囲へ制限する比較を与える。共通の定義域では、一意性によって両構成が一致する。
- 正方向と逆方向の再分解を同じ有理写像の API で扱い、必要な有限個の分母条件を明示した定義域を与える。

*Needs:* 7.1–7.2; 有理写像の合成、非空 Zariski 開集合の有限交叉。

**Check.** 有限範囲ごとの非空開集合と、全整数格子のすべての反復が正則になる一つの共通開集合を区別する。後者の存在はこの定理の結論に含めない。

### 7.4 q 差分 Schlesinger 方程式と平坦な輸送

**定理。** 7.3 の多項式 Aₖ(z) の指定スペクトル群を持つ一次右因子を zI − Bᵢ(k) とする。7.3 と同じ添字範囲の規約の下で、この族は

    Bᵢ(k) − Bᵢ(k + eⱼ) = Bⱼ(k) − Bⱼ(k + eᵢ),
    Bⱼ(k + eᵢ) Bᵢ(k) = Bᵢ(k + eⱼ) Bⱼ(k),
    Bᵢ(k + 1) = q⁻¹ L⁻¹ Bᵢ(k) L,
    Sp(Bᵢ(k)) = q^(−kᵢ) Sp(Bᵢ(0))

を満たす。逆に、一般の初期値についてこれらの条件を満たす族から 7.3 の因子表示を回復する。両表示は

    Cᵢ(k) = Bᵢ(k + eᵢ₊₁ + ⋯ + e_d)

で結ばれる。（[B04], Introduction (3q)–(6q), §4 の再分解構成と Remark 4.14.）

Rᵢ(z,k) = I − z⁻¹Bᵢ(k) に対して、最初の二式は

    Rᵢ(z,k + eⱼ) Rⱼ(z,k) = Rⱼ(z,k + eᵢ) Rᵢ(z,k)

と同値である。また各方向には

    Rᵢ(qz,k) Aₖ(z) = Aₖ₊eᵢ(z) Rᵢ(z,k)

が成り立つ。これにより、Layer 6 の平坦な離散輸送の具体例を、一般初期値から存在・一意に構成する。

- 時間原点を任意の ℓ ∈ ℤᵈ に移すと、初期スペクトルを q^(−ℓᵢ) 倍した同じ方程式を得ることを示す。
- C 表示から行列多項式 Aₖ と全右因子 Bᵢ(k) を回復し、逆の B 表示から得る Aₖ と一致することを証明する。
- 負方向の gauge は Rᵢ(z,k − eᵢ)⁻¹ として供給し、正方向との cancellation と符号を含む square identity を 6.2 と比較する。

*Needs:* 7.3; 0.3 の行列表現と係数比較; 6.2 の方向間 cocycle と離散輸送。

**Check.** 方向ごとの horizontal identity と方向間の square identity は別の等式である。square identity の z⁻¹ と z⁻² の係数比較から、それぞれ最初の二つの Schlesinger 方程式が得られる。

### 7.5 双有理格子作用と接続データの保存

**構成・定理。** 7.3–7.4 を、根のラベル付き特異型の族における ℤᵈ の双有理作用としてまとめる。k ∈ ℤᵈ の変換は、特異型 a の因子空間から特異型 (q^(−kᵢ)aᵢ,α) の因子空間への双有理写像となる。合成、単位元、逆元の等式を証明する。

経路に沿う Rᵢ の積を Rₖ とすると、square identity により経路に依存せず

    Rₖ₊ₗ(z,t) = Rₖ(z,Tₗt) Rₗ(z,t)

を満たす。Layer 5 の大域比較関手を適用すると、これらは大域接続データの coherent な同型になる。方向の選択を格子の元として扱い、任意の部分群や一方向への制限を構成する。（[B04], Theorem 4.9 と Remark 4.14; 接続データとの比較は Layer 5–6 からの帰結。）

この作用はシフトした特異型の間の変換である。端点 0 の固有値には q^(−Σᵢkᵢ) が掛かり、L は固定される。接続データの保存は有理 horizontal gauge と大域比較から証明するので、解析的基本解の対角化や非共鳴を追加する必要はない。

- R₀ = I と R₋ₖ(z,t) = Rₖ(z,T₋ₖt)⁻¹ を、経路による構成と一致する形で与える。
- 部分格子 {k : Σᵢkᵢ = 0} への制限では、0 のスペクトルと det A(0) が保存されることを示す。局所フレームまで固定されるとは主張しない。
- 各有限範囲では、初期値に関する分母の非消滅を課して Rₖ の係数を正則にし、z の極を 0 と有限個のシフト済み根によって一様に抑える。この具体的な族を 6.6 の有限 pole bound の契約と比較する。

*Needs:* 7.2–7.4; 5.4 の大域接続データの圏同値; 6.1–6.2 の coherent な輸送; 6.6 の有限 pole bound を持つ族。

**Check.** det A(0) は q^(−nΣᵢkᵢ) 倍される。nd 個の determinant roots の積も同じ倍率で変わるため、最高次係数 det L との恒等式が保たれる。

### Examples

階数一では A(z) = λ∏ⱼ(z − aⱼ) に対し

    Rᵢ(z) = (z − aᵢ)/z,
    TᵢA(z) = λ(z − q⁻¹aᵢ) ∏ⱼ≠ᵢ(z − aⱼ).

これは Layer 1 の単純零点の移動と端点格子変更の組合せであり、二つの方向の可換性を直接確認できる。

次数一では A(z) = L(zI − C) に対し

    T(C) = q⁻¹L⁻¹CL,
    Tᵏ(C) = q⁻ᵏL⁻ᵏCLᵏ    (k ∈ ℤ).

この明示式が 7.3 の同時シフト規約、逆変換、局所指数の向きと一致することを証明する。n > 1 でも L の非半単純性を許す。これらは 7.2–7.5 の特殊化である。

非可換な階数二・次数二の例として、q = 2 と

    L = [[1,1],[0,1]],
    C₁ = [[3,1],[0,5]],    C₂ = [[7,0],[2,11]]

を取る。L は非半単純であり、C₁C₂ ≠ C₂C₁ である。根 3,5,7,11 は異なる q 軌道にある。群 1 の右因子は

    B₁ = [[27/7,24/7],[2/7,29/7]]

となり、二方向をどちらの順序で施しても

    C₁′ = [[3/2,−1/2],[0,5/2]],
    C₂′ = [[5/2,−3],[1,13/2]]

を得る。各方向の q horizontal 式、R₂(T₁t)R₁(t) = R₁(T₂t)R₂(t)、Cᵢ′ = q⁻¹L⁻¹CᵢL がこの例で一致することを計算する。可換なスカラー因子の例だけでは検出できない、積順序と L による共役を確認できる。

### Dependencies

Layer 0 の差分加群・行列表示・horizontal gauge、Layer 1 の有理 q 接続・局所格子変更・行列式の divisor、Layer 5 の大域接続データとの圏同値、Layer 6 の coherent な離散輸送を用いる。7.1 の行列因子の再分解が 7.2 の変換を供給し、7.3 の有限範囲の存在と一意性が 7.4 の方程式と 7.5 の双有理格子作用を供給する。

## Downstream consumers

個別の q 差分等モノドロミー系は、Layer 1 の束・特異型・modification、Layer 4 の局所解析不変量、Layer 5 の接続データ、Layer 6 の時間輸送、Layer 7 の多項式変換を入力として利用できる。特定の階数や特異型への制限、安定性条件、座標の選択、moduli space の幾何、非線形方程式への消去は、それぞれの消費側で別の定理として与える。

局所分類だけを使う消費側は Layers 0、2–4 で閉じる。大域接続データの保存を使う消費側は Layer 5 の対象と射を保持する。束の次数や特異点の配置を追跡する消費側は、generic module の分類に Layer 1 の局所格子を併せる。

## Scope and ownership

本ロードマップは、q 差分加群とその操作、束上の有理 q 接続、q 差分の Newton slope と形式分類、q-Stokes 層と局所解析分類、局所解析データを保持した大域接続データ、接続保存変形、q 差分 Schlesinger 変換を所有する。数学的な一般性は、任意有限階数、共鳴、非半単純部分、有理数の傾きを含む。具体的な多項式変換では、その存在に必要なスペクトル分離と一般初期値の条件を Layer 7 に限って課す。

既知の結果をその文献の仮定の下で述べ、複数の結果を組み合わせた契約では構成と依存関係を記載する。特に 5.4 は局所 Laurent 模型と有理型 Birkhoff 分解を組み合わせる比較、6.1 はその圏同値による coherent な輸送、6.5–6.7 は指定した解析的仮定の下での族の帰結である。任意の基底上の q Riemann–Hilbert stack equivalence、任意の特異型の平滑モジュライ空間、その symplectic 構造、coarse moduli の存在は含めない。

一般の半線形写像、加群、skew monoid algebra、有限局所自由層、引戻し、曲線の divisor、形式 Laurent 体、解析 germ、複素多様体の商、theta 関数、非可換 H¹ の carrier は既存の供給元を用いる。q 構造を持たない同じ対象を別の carrier として定義し直さない。q の同変条件、作用の方向、選択の比較、q 固有の分類と変形をこれらの上に加える。

| 対象 | 所有する供給元 | 本ロードマップで加える内容 |
| --- | --- | --- |
| 形式係数体・有限分岐 | FormalLaurentPuiseux Layers 1・4・6 | q 自己同型、差分 Newton polygon、slope、q と Galois descent の互換性 |
| 代数的束・引戻し・determinant | native Tau Ceti; AlgebraicVectorBundles §§1.1–1.2、2.1–2.2、3.1–3.2 | 有理 q 同型、局所格子、特異軌道、modification |
| 解析 germ・正則束・Dolbeault 比較 | ComplexKahlerGeometry §§2.5、3.1–3.3、4.1、4.4、5.10 | q シフト、純 q 束の次数とコホモロジー、局所 gauge の解析 |
| 解析的商・lattice quotient・束の gluing | ComplexManifolds Milestones 3–5・7; ComplexTori Milestones 1・3 | E_q、有限 isogeny、q 同変な接続データの降下 |
| Theta の一般解析 | SpecialFunctionsTheta §§1.1–1.3、4.1–4.2、5.1 | 乗法的規約、q-character、q-logarithm、q 基本解 |
| Sheaf descent・torsor・非可換 H¹ | SchemeAndStackFoundations §§1.1、1.15、1.18、2.3; TopologicalSheafCohomology §§1.1–1.3 | q-Stokes sheaf、gap filtration、分類と降下 |
| Coherent GAGA | ComplexComparisonPartII C0.3–C0.4、C1.9、C2.2 | 有理型 Birkhoff 分解への適用と有理 q 系の復元 |
| 閉曲面上の一般 CR index | PseudoholomorphicCurveAnalysis §§6.2–6.4、7.2 | E_q 上の pure q 束の次数・H⁰ 消滅と H¹ の次元 |
| 微分接続・微分時間の等モノドロミー | PainleveEquations Layers 0–2 | 差分の半線形作用、q 接続データ、時間 cocycle を別の理論として構成 |

PainleveEquations の Levelt–Turrittin 分解、微分 Riemann–Hilbert 対応、微分接続の積分可能拡張は q 差分の対応物の供給元ではない。個別の q-Painlevé 方程式、反標準曲面の分類、クラスター実現、tau 関数、q → 1 の confluence、差分 Galois 群の密度定理は本ロードマップの対象に含めない。

## Exact supplier contracts

以下では carrier、写像、同型とその法則を供給契約として記す。Native source は固定 commit のリンクで指定し、ロードマップの契約は現存する節を参照する。上の各層は、それらに q 構造と必要な可換図式を加える。

### From Mathlib

**Skew Laurent 環の carrier。** 明示的な自己同型 σ の整数冪による `MulSemiringAction (Multiplicative ℤ) R` を固定し、`SkewMonoidAlgebra R (Multiplicative ℤ)` の既存の環構造を用いる。`single_mul_single` は (aΦᵐ)(bΦⁿ)=aσᵐ(b)Φᵐ⁺ⁿ を与える。`singleOneRingHom` は係数の環埋め込み、`of` は指数群から乗法モノイドへの写像、`liftNCRingHom` は係数写像 f と指数群の写像 g が f(σⁿ(a))g(n)=g(n)f(a) を満たす場合の環準同型を与える。`mapDomainRingHom` により ℕ→ℤ と作用に整合する指数の変更を扱う。非負指数の carrier は `SkewPolynomial R` であり、これは `SkewMonoidAlgebra R (Multiplicative ℕ)` の既存の略記である。σ に依存する作用は各構成で明示し、基礎環上の中心性を追加しない。供給元: [SkewMonoidAlgebra の環構造と普遍性](https://github.com/leanprover-community/mathlib4/blob/1b1ccf4b088b32fa3f23f2de1127433254a81e1e/Mathlib/Algebra/SkewMonoidAlgebra/Basic.lean)、[作用に整合する写像と比較](https://github.com/leanprover-community/mathlib4/blob/1b1ccf4b088b32fa3f23f2de1127433254a81e1e/Mathlib/Algebra/SkewMonoidAlgebra/Lift.lean)、[SkewPolynomial](https://github.com/leanprover-community/mathlib4/blob/1b1ccf4b088b32fa3f23f2de1127433254a81e1e/Mathlib/Algebra/SkewPolynomial/Basic.lean)。

**半線形写像。** 可換環 R とその環自己同型 σ に対し、加群、R 線形射、σ 半線形射、可逆な σ 半線形射には Mathlib の `Module`、`LinearMap`、`LinearEquiv` を用いる。`LinearEquiv` の σ と逆写像に関する仮定は、σ と σ⁻¹ が両順序で逆であることを要求する `RingHomInvPair` である。恒等写像、合成、逆写像および underlying function の合成法則をこの API から受け取る。環上では有限生成射影性を、体 K 上では有限次元性を underlying module の条件とし、q 差分加群の射には基礎環上の線形性と半線形構造を可換にする条件を加える。既存の半線形写像の carrier を再定義しない。供給元: [LinearMap の定義](https://github.com/leanprover-community/mathlib4/blob/1b1ccf4b088b32fa3f23f2de1127433254a81e1e/Mathlib/Algebra/Module/LinearMap/Defs.lean)、[LinearEquiv の定義と合成・逆](https://github.com/leanprover-community/mathlib4/blob/1b1ccf4b088b32fa3f23f2de1127433254a81e1e/Mathlib/Algebra/Module/Equiv/Defs.lean)。

**加群の圏とテンソル。** `ModuleCat K` は K-module を対象、K 線形写像を射に持つ。可換環上のテンソル積、結合子、左右単位子、対称性、五角形・三角形・六角形の法則は native な対称モノイダル構造を用いる。テンソル積上の q 構造が well-defined であること、双対・内部 Hom 上の q 構造、これらの構造との同変性は q 差分加群の契約に属する。供給元: [ModuleCat](https://github.com/leanprover-community/mathlib4/blob/1b1ccf4b088b32fa3f23f2de1127433254a81e1e/Mathlib/Algebra/Category/ModuleCat/Basic.lean)、[テンソルと coherence](https://github.com/leanprover-community/mathlib4/blob/1b1ccf4b088b32fa3f23f2de1127433254a81e1e/Mathlib/Algebra/Category/ModuleCat/Monoidal/Basic.lean)、[対称性](https://github.com/leanprover-community/mathlib4/blob/1b1ccf4b088b32fa3f23f2de1127433254a81e1e/Mathlib/Algebra/Category/ModuleCat/Monoidal/Symmetric.lean)。

**スカラー変換とその coherence。** 環準同型 f : R → S に沿う scalar restriction と、可換環の場合の scalar extension S ⊗ᵣ M は native の `ModuleCat.restrictScalars` と `ModuleCat.extendScalars` を用いる。恒等比較、合成比較、三重合成の結合性、左右単位との整合性を受け取る。これにより σ による twist を既存の係数変換として表す。σ-semilinear map と σ に沿う scalar extension からの線形射との対応、および σ-compatible な係数体拡大に沿う q 構造の変換を本ロードマップで明示する。供給元: [ChangeOfRings](https://github.com/leanprover-community/mathlib4/blob/1b1ccf4b088b32fa3f23f2de1127433254a81e1e/Mathlib/Algebra/Category/ModuleCat/ChangeOfRings.lean)、[係数変換の pseudofunctor](https://github.com/leanprover-community/mathlib4/blob/1b1ccf4b088b32fa3f23f2de1127433254a81e1e/Mathlib/Algebra/Category/ModuleCat/Pseudofunctor.lean)。

**表現との区別。** `CategoryTheory.Action (ModuleCat K) G` の作用射は K 線形である。したがって σ ≠ id の半線形作用をこの carrier と同一視しない。q シフトによる scalar twist を含む categorical action、あるいは twist の間の同型を構成した後に、native な functor・natural isomorphism・pseudofunctor の coherence を用いる。供給元: [Action の定義](https://github.com/leanprover-community/mathlib4/blob/1b1ccf4b088b32fa3f23f2de1127433254a81e1e/Mathlib/CategoryTheory/Action/Basic.lean)。

**有理関数と形式 Laurent 級数。** 有理関数体 K(z) は `RatFunc K`、形式 Laurent 級数 K((z)) は `LaurentSeries K` を用いる。前者は多項式環の分数体、後者は整数指数の Hahn 級数であり、有限の主部を持つ。K が体なら K((z)) は K[[z]] の分数体であり、native な K(z) → K((z)) の係数埋め込み、形式付値、付値位相の完備性を受け取る。q ≠ 0 に対する z ↦ qz の自己同型、解析的 germ との比較、ramification と q シフトの整合性は別に明示する。形式 Laurent 級数の carrier に収束条件は含まれない。供給元: [RatFunc の定義](https://github.com/leanprover-community/mathlib4/blob/1b1ccf4b088b32fa3f23f2de1127433254a81e1e/Mathlib/FieldTheory/RatFunc/Defs.lean)、[分数体と写像の持ち上げ](https://github.com/leanprover-community/mathlib4/blob/1b1ccf4b088b32fa3f23f2de1127433254a81e1e/Mathlib/FieldTheory/RatFunc/Basic.lean)、[Laurent 級数と付値](https://github.com/leanprover-community/mathlib4/blob/1b1ccf4b088b32fa3f23f2de1127433254a81e1e/Mathlib/RingTheory/LaurentSeries.lean)。

**Affine space と functor of points。** `AlgebraicGeometry.AffineSpace n S` を使用し、`AffineSpace.homOverEquiv` により S 上の X からの射を n 個の Γ(X,O_X) の元と同定する。`AffineSpace.SpecIso` は S=Spec R の場合のこの scheme を Spec(R[xᵢ]) と比較する。S=Spec ℂ、X=Spec R、n が N 元の有限集合の場合に特殊化して、R↦R^N を表現する ℂ 上の affine space を得る。`homOfVector`、`homOfVector_appTop_coord`、`comp_homOfVector`、`hom_ext` による座標写像の存在・一意性と自然性を使用する。q の marked isoformal functor F(M₀)(R) と R^N の自然な全単射は、すべての commutative ℂ-algebras R に対して本ロードマップの分類定理として証明する。複素点の全単射のみから representability は結論しない。供給元: [AffineSpace](https://github.com/leanprover-community/mathlib4/blob/1b1ccf4b088b32fa3f23f2de1127433254a81e1e/Mathlib/AlgebraicGeometry/AffineSpace.lean)。

**作用 groupoid と stabilizer。** 群 G が集合 X に作用するとき、`CategoryTheory.ActionCategory G X` の対象は X の元、x→y の射は g•x=y を満たす g∈G である。native な Groupoid 構造を用い、合成の群ラベルは先に g、後に h を作用させる場合 hg である。`ActionCategory.stabilizerIsoEnd` は対象 x の endomorphism monoid を stabilizer と同定する。Aut(M₀) による graded marking の変更を `MulAction` として構成し、unmarked local modules の同型 groupoid とこの作用 groupoid の同値を q 側で証明する。module category の非可逆射を、この groupoid で置き換えない。供給元: [ActionCategory](https://github.com/leanprover-community/mathlib4/blob/1b1ccf4b088b32fa3f23f2de1127433254a81e1e/Mathlib/CategoryTheory/Action.lean)。

**固有空間と一般 Sylvester 方程式の入力。** 代数閉体 K 上の有限次元 vector space V について、native の `Module.End.iSup_maxGenEigenspace_eq_top` により任意の endomorphism の generalized eigenspaces が V を張ることを受け取る。`Module.End.map_genEigenspace_le` は intertwiner が同じ固有値の generalized eigenspace へ写すことを与える。従って Sp(X)∩Sp(Y)=∅ なら YH=HX を満たす H は零であり、`LinearMap.injective_iff_surjective` により有限次元空間 Hom(V,W) 上の H↦YH−HX は可逆となる。この適用として §7.1 の Sylvester 方程式を証明し、係数行列の adjugate/determinant によって解の有理依存を得る。自己共役性、normality、同時対角化は仮定しない。`Module.End.exists_eigenvalue` と invariant line の quotient に対する次元帰納法から、§7.3 に使う L の上三角化を導く。供給元: [generalized eigenspaces と intertwiner](https://github.com/leanprover-community/mathlib4/blob/1b1ccf4b088b32fa3f23f2de1127433254a81e1e/Mathlib/LinearAlgebra/Eigenspace/Basic.lean)、[固有値の存在と generalized eigenspace 分解](https://github.com/leanprover-community/mathlib4/blob/1b1ccf4b088b32fa3f23f2de1127433254a81e1e/Mathlib/LinearAlgebra/Eigenspace/Triangularizable.lean)、[有限次元の単射と全射](https://github.com/leanprover-community/mathlib4/blob/1b1ccf4b088b32fa3f23f2de1127433254a81e1e/Mathlib/LinearAlgebra/FiniteDimensional/Basic.lean)。

**短完全列と extension classes。** アーベル圏 C の extension group は native の `CategoryTheory.Abelian.Ext` を用いる。これは derived-category shifted Hom による定義であり、`CategoryTheory.HasExt.standard` により十分大きい universe において任意のアーベル圏で使用できる。有限次元 q 差分加群の圏に enough projectives を仮定しない。短完全列の class は `CategoryTheory.ShortComplex.ShortExact.extClass` とし、`extClass_naturality` による両端の射に対する自然性を受け取る。`CategoryTheory.ShortComplex.baerSum` は直和を diagonal に沿って pullback し、codiagonal に沿って pushout する既存の構成である。`ShortExact.baerSum` による短完全性、`ShortExact.extClass_baerSum` による Ext の和との一致、`extClass_pull` と `extClass_push` の自然性を用いる。0.5 の全左 D 加群のアーベル圏にこれを適用し、§3.5 で q 固有の二項複体との比較、upper triangular extension と coboundary の対応、差分 connecting map の符号を証明する。供給元: [derived-category Ext と HasExt.standard](https://github.com/leanprover-community/mathlib4/blob/1b1ccf4b088b32fa3f23f2de1127433254a81e1e/Mathlib/Algebra/Homology/DerivedCategory/Ext/Basic.lean)、[短完全列の extClass](https://github.com/leanprover-community/mathlib4/blob/1b1ccf4b088b32fa3f23f2de1127433254a81e1e/Mathlib/Algebra/Homology/DerivedCategory/Ext/ExtClass.lean)、[Baer 和と extClass の加法](https://github.com/TauCetiProject/TauCeti/blob/2fd255d997f47c0b5d834ee416c7015d55444ce5/TauCeti/Algebra/Homology/Ext/BaerSum.lean)。

### From Tau Ceti

**解析的有理型 germ。** 0 における複素一変数の有理型 germ の体には `TauCeti.meromorphicGerms ℂ 0` を用いる。これは punctured neighborhood filter に沿う関数 germ の部分環であり、有理型関数を代表元に持つことを条件とする。代表元の一致は、中心を除いた十分小さい近傍での一致である。体構造、定数による ℂ-algebra 構造、座標 germ、各 germ の有理型代表元を受け取る。中心で任意に指定された関数値はデータに含めない。供給元: [Meromorphic/Germ](https://github.com/TauCetiProject/TauCeti/blob/2fd255d997f47c0b5d834ee416c7015d55444ce5/TauCeti/Analysis/Meromorphic/Germ.lean)。

**germ の pullback。** 解析写像 g が a を b に送り、punctured neighborhood filter を対応する punctured neighborhood filter に送るとき、g による有理型 germ の pullback を受け取る。これは定数を保存する環準同型で、代表元への合成、恒等写像、合成、g の germ のみに依存する性質を持つ。g が局所双正則なら、対応する germ の体の同型とその逆を受け取る。q ≠ 0 の z ↦ qz はこの契約を実体化し、0 の germ の自己同型を与える。∞ では座標 w = 1/z を用い、w ↦ q⁻¹w による契約を用いる。供給元: [Meromorphic/Pullback](https://github.com/TauCetiProject/TauCeti/blob/2fd255d997f47c0b5d834ee416c7015d55444ce5/TauCeti/Analysis/Meromorphic/Pullback.lean)。

**正則 germ の分数体との比較。** 複素直線上の正則構造層の stalk から有理型 germ の体への単射、後者がその分数体であること、非負の位数による正則 germ の特徴付け、主部と正則部への一意分解を受け取る。これは一変数解析の局所環と有理型 germ の比較である。形式完備化との比較や任意の基底上の相対 meromorphic sheaf の構成はこの供給契約から自動的には従わない。供給元: [StructureSheaf/MeromorphicGerm](https://github.com/TauCetiProject/TauCeti/blob/2fd255d997f47c0b5d834ee416c7015d55444ce5/TauCeti/Geometry/Manifold/Complex/StructureSheaf/MeromorphicGerm.lean)。

**代数的ベクトル束の carrier。** スキーム X 上のベクトル束には `TauCeti.AlgebraicGeometry.FiniteLocallyFreeSheaf X` を用いる。これは X 上の module sheaves の full subcategory で、local freeness と finite presentation を持つ対象からなる。射は既存の module sheaf の射である。rank は局所定数であり、非連結 X で一つの整数に固定しない。固定 rank r が必要な場合のみ `FiniteLocallyFreeSheaf.FixedRank X r` を用いる。任意のスキーム射に沿う pullback、恒等比較、合成比較、free sheaf の pullback、rank-one と invertible sheaf の比較を受け取る。q 接続はこの underlying sheaf とその pullback の間の指定された有理型同型として追加する。供給元: [FiniteLocallyFree](https://github.com/TauCetiProject/TauCeti/blob/2fd255d997f47c0b5d834ee416c7015d55444ce5/TauCeti/AlgebraicGeometry/VectorBundle/FiniteLocallyFree.lean)、[Functoriality](https://github.com/TauCetiProject/TauCeti/blob/2fd255d997f47c0b5d834ee416c7015d55444ce5/TauCeti/AlgebraicGeometry/VectorBundle/Functoriality.lean)、[FixedRank](https://github.com/TauCetiProject/TauCeti/blob/2fd255d997f47c0b5d834ee416c7015d55444ce5/TauCeti/AlgebraicGeometry/VectorBundle/FixedRank.lean)。

**幾何学的 pullback の coherence。** スキーム上の module sheaves の pullback は既存の `Scheme.Modules.pseudofunctor` から受け取る。f : X → Y、g : Y → Z について f* g* と (g ∘ f)* の比較、恒等射との比較、三重合成の結合性を用いる。q シフトと変形方向の二つの pullback を交換するときには、その交換に対応する base morphism の等式とこれらの比較同型を式に含める。位相空間の単なる写像をスキーム射と混同せず、解析側の対応物は正則ベクトル束・正則構造層の供給元から受け取る。供給元: [Mathlib の scheme module sheaves](https://github.com/leanprover-community/mathlib4/blob/1b1ccf4b088b32fa3f23f2de1127433254a81e1e/Mathlib/AlgebraicGeometry/Modules/Sheaf.lean)、[TauCeti の componentwise coherence](https://github.com/TauCetiProject/TauCeti/blob/2fd255d997f47c0b5d834ee416c7015d55444ce5/TauCeti/AlgebraicGeometry/Modules/Pullback/Basic.lean)。

**テンソルと pullback。** 任意のスキーム射に沿う quasi-coherent sheaves の pullback は strong symmetric monoidal である。単位とテンソルの比較は既存の module pullback の canonical comparison であり、その恒等・合成比較も monoidal である。この契約は flatness を仮定しない。有限局所自由層は quasi-coherent なので、この比較をその underlying sheaves に適用する。q 同型をテンソル・双対・外冪に運ぶ際には、この canonical comparison を使って q 構造との可換性を証明する。供給元: [Pullback/Monoidal/Basic](https://github.com/TauCetiProject/TauCeti/blob/2fd255d997f47c0b5d834ee416c7015d55444ce5/TauCeti/AlgebraicGeometry/Modules/Pullback/Monoidal/Basic.lean)、[Identity](https://github.com/TauCetiProject/TauCeti/blob/2fd255d997f47c0b5d834ee416c7015d55444ce5/TauCeti/AlgebraicGeometry/Modules/Pullback/Monoidal/Identity.lean)、[Composition](https://github.com/TauCetiProject/TauCeti/blob/2fd255d997f47c0b5d834ee416c7015d55444ce5/TauCeti/AlgebraicGeometry/Modules/Pullback/Monoidal/Composition.lean)。

**行列式。** 局所定数 rank を持つ有限局所自由層の行列式は、rank ごとの最高外冪を貼り合わせた既存の invertible sheaf を用いる。一般の局所定数 rank に対する functoriality は core、すなわち同型射について受け取る。固定 rank では既存の determinant functor を用いる。任意のスキーム射に沿う pullback との比較を受け取り、固定 rank での恒等・合成との整合性を用いる。行列式 q 接続とその gauge law はこの比較を通じて定義する。供給元: [Determinant/LocallyConstantRank](https://github.com/TauCetiProject/TauCeti/blob/2fd255d997f47c0b5d834ee416c7015d55444ce5/TauCeti/AlgebraicGeometry/VectorBundle/Determinant/LocallyConstantRank.lean)、[Determinant/Pullback](https://github.com/TauCetiProject/TauCeti/blob/2fd255d997f47c0b5d834ee416c7015d55444ce5/TauCeti/AlgebraicGeometry/VectorBundle/Determinant/Pullback.lean)。

**有限 Galois 拡大上の線形下降。** 有限 Galois 拡大 L/K、有限群 G=Gal(L/K)、L-vector space N と、G の L 上の作用に関して半線形な K 線形表現 ρ を取る。`TauCeti.GaloisDescent.span_invariants_eq_top` は N^G が N を L 上張ることを、`liftBaseChange_injective_of_invariant` は不変元からの K 線形単射を scalar extension した写像の単射性を与える。N^G↪N に適用して標準写像 L⊗_K N^G→N の L 線形同型を得る。`range_eq_invariants_of_liftBaseChange_surjective` は base change 後に全射となる invariant な写像の像を invariants と同定する。これらは N の有限次元性や標数零を仮定せず、有限 Galois 拡大と記載した半線形性の下で使う。q 差分加群の場合は、Φ が G 作用と可換することから invariants の安定性と比較写像の horizontality を本ロードマップで証明する。z=wʳ による解析・形式係数体の有限 Galois 構造、基底 1,w,…,w^(r−1)、解析 Laurent 係数分解の収束も q 側の実体化とする。供給元: [invariants の張る空間](https://github.com/TauCetiProject/TauCeti/blob/2fd255d997f47c0b5d834ee416c7015d55444ce5/TauCeti/RepresentationTheory/GaloisDescent/Span.lean)、[base change の単射性](https://github.com/TauCetiProject/TauCeti/blob/2fd255d997f47c0b5d834ee416c7015d55444ce5/TauCeti/RepresentationTheory/GaloisDescent/Injective.lean)、[像と invariants](https://github.com/TauCetiProject/TauCeti/blob/2fd255d997f47c0b5d834ee416c7015d55444ce5/TauCeti/RepresentationTheory/GaloisDescent/Range.lean)。

**乗法的 Jordan 分解。** perfect field K 上の有限次元 vector space V の線形自己同型 g について、`LinearMap.GeneralLinearGroup.jordanDecomposition`、`jordanDecomposition_spec`、`eq_jordanDecomposition_iff` を用い、可換な semisimple factor と unipotent factor の存在・一意性を受け取る。ℂ 上では semisimple factor の eigenspaces と、unipotent factor の nilpotent 対数に theta character・q-logarithm を適用する。q 基本解、その tensor comparison、共鳴を持つ射の比較はこの一般線形代数から自動的に供給されるものではなく、本ロードマップで構成する。供給元: [Multiplicative Jordan–Chevalley](https://github.com/TauCetiProject/TauCeti/blob/2fd255d997f47c0b5d834ee416c7015d55444ce5/TauCeti/LinearAlgebra/JordanChevalley/Multiplicative.lean)。

**DVR 上の Smith 形。** `Matrix.exists_smith_normal_form_of_isDiscreteValuationRing` は DVR R 上の任意の正方行列 A に対し、unit determinant の行列 L,Q と divisibility chain s₀∣s₁∣…を与え、LAQ=diag(sᵢ) とする。零の diagonal entries も許す。q 接続の局所行列は分数体上で可逆なので、共通分母を払った R 上の行列にこの定理を適用し、付値から分母の位数を引いて整数 Smith exponents を得る。座標・格子・gauge に対する変換と q 軌道の divisor の比較は本ロードマップの対象である。供給元: [Smith normal form over DVR](https://github.com/TauCetiProject/TauCeti/blob/2fd255d997f47c0b5d834ee416c7015d55444ce5/TauCeti/LinearAlgebra/Matrix/SmithNormalForm/Basic.lean)、[PID 上の行列の diagonalization](https://github.com/TauCetiProject/TauCeti/blob/2fd255d997f47c0b5d834ee416c7015d55444ce5/TauCeti/LinearAlgebra/Matrix/SmithNormalForm/Diagonal.lean)。

**有限生成射影加群の双対。** 可換環 R 上で、`ModuleCat.hasLeftDualOfFiniteProjective` と `hasRightDualOfFiniteProjective` は finite projective module の categorical dual を与え、その underlying object は internal Hom into R である。`ModuleCat.dualTensorIhom_app_eq` は dual tensor と internal Hom の比較を native の contraction `dualTensorHom`、f⊗n↦(m↦f(m)n)、と同定する。評価・余評価と snake identities はこの native dualizable structure を用い、q 構造に関する horizontality と q category 内での duality は §0.2 で証明する。供給元: [finite projective modules の dualizability](https://github.com/TauCetiProject/TauCeti/blob/2fd255d997f47c0b5d834ee416c7015d55444ce5/TauCeti/Algebra/Category/ModuleCat/FiniteProjective/Dualizable.lean)、[dual tensor と internal Hom](https://github.com/TauCetiProject/TauCeti/blob/2fd255d997f47c0b5d834ee416c7015d55444ce5/TauCeti/Algebra/Category/ModuleCat/DualTensorIhom.lean)。

**Ext¹ の projective presentation による計算。** アーベル圏 C と `HasExt C`、短完全列 S:0→P₁→P₀→N→0、projective な P₀ に対し、native `TauCeti.homCokernelEquivExt` は Hom(P₁,M)/im Hom(P₀,M) と `CategoryTheory.Abelian.Ext N M 1` の線形同型を与える。P₁ の projectivity と C の enough projectives はこの定理の仮定にない。`homCokernelEquivExt_mk` は quotient の元を pushout extension の class に送り、`homCokernelEquivExt_naturality` は M に関する自然性を与える。`homCokernelEquiv` とその identity・inverse・composition laws により projective presentation の変更を比較する。

§3.5 では C=ModuleCat D、D=K[Φ,Φ⁻¹;σ] とし、σ が ℂ を固定することにより ℂ 線形構造を用いる。P_N の有限自由 D 基底には `ModuleCat.projective_of_free` を適用する。`CategoryTheory.ShortComplex.ShortExact.exists_extClass_eq` も、この指定した projective presentation の pushout による実現を供給する。有限 K 次元の端点を持つ extension の中間項が有限 K 次元であること、splitting と差分 coboundary の比較、q 二項複体の符号は本ロードマップで証明する。有限次元 q category に enough projectives を仮定しない。

供給元: [projective presentation と Ext¹](https://github.com/TauCetiProject/TauCeti/blob/2fd255d997f47c0b5d834ee416c7015d55444ce5/TauCeti/Algebra/Homology/Ext/Presentation.lean)、[projective presentation による短完全列の実現](https://github.com/TauCetiProject/TauCeti/blob/2fd255d997f47c0b5d834ee416c7015d55444ce5/TauCeti/Algebra/Homology/Ext/Realization.lean)、[自由加群の categorical projectivity](https://github.com/leanprover-community/mathlib4/blob/1b1ccf4b088b32fa3f23f2de1127433254a81e1e/Mathlib/Algebra/Category/ModuleCat/Projective.lean)、[native Baer 和](https://github.com/TauCetiProject/TauCeti/blob/2fd255d997f47c0b5d834ee416c7015d55444ce5/TauCeti/Algebra/Homology/Ext/BaerSum.lean)。

### From TauCetiRoadmap.FormalLaurentPuiseux

[Layers 1・4・6](../FormalLaurentPuiseux/README.md) から、K[[z]] と K((z)) の係数・付値・有限主部、形式代入と座標自己同型、z = uʳ の bounded-denominator levels、基底 1,u,…,uʳ⁻¹、transition maps、付値の rescaling、有限分岐体の Galois 群 μ_r と基底の比較を受け取る。q ≠ 0 の z ↦ qz をこの代入へ特殊化する。q_rʳ = q を伴う差分体拡大、deck action と半線形作用の可換性、解析的係数分解の収束と解析体の Galois 構造は 0.4、差分加群の下降の可換性は 3.4 で証明する。一般の Newton–Puiseux 定理を、差分作用素の Newton slope theorem と同一視しない。

### From TauCetiRoadmap.AlgebraicVectorBundles

[§§1.1–1.2](../AlgebraicVectorBundles/README.md) から ringed-space pullback の stalk 比較、tensor と単位の比較、恒等・合成・対称性との coherence を受け取る。Native なスキーム上の quasi-coherent 範囲を越える場合には、この roadmap の一般化された契約を用いる。[§§2.1–2.2](../AlgebraicVectorBundles/README.md) の exactness と internal Hom base change は、その flatness および有限表示の仮定を保持して利用する。[§§3.1–3.2](../AlgebraicVectorBundles/README.md) の外冪・対称冪・determinant と短完全列の比較を受け取り、q 同型に対する horizontality を 0.2、1.1 で証明する。

### From TauCetiRoadmap.AlgebraicCurves

[§§1.1–1.2、3.1–3.2、5.7、Layer 12](../AlgebraicCurves/README.md) から、曲線の関数体と閉点の位数、DVR、完備化、divisor、主 divisor、次数の公式、native な代数曲線への比較を受け取る。1.2 の格子族の再構成では、局所自由層の Zariski 貼り合わせと DVR 上の full lattice の比較を使う。1.3–1.5 の q 接続の Smith 型、特異軌道、modification の divisor 公式は q 側の契約とする。

### From TauCetiRoadmap.ComplexManifolds

[Milestone 3](../ComplexManifolds/README.md) の `OnePoint ℂ` 上の射影直線の正則 atlas、Milestone 4 の自由かつ properly discontinuous な正則作用の商と descent、Milestone 5 の open gluing、Milestone 7 items 1–3 の正則 cocycle による束とその射・pullback・tensor・dual を受け取る。2.1 では q^ℤ 作用の自由性・proper discontinuity を証明して適用する。5.2 では円環での行列の貼り合わせを正則束の gluing に移す。q に固有の orbit と接続行列の互換式はこの供給契約の入力として構成する。

### From TauCetiRoadmap.ComplexTori

[Milestone 1](../ComplexTori/README.md) から、full lattice quotient の複素 Lie 群・コンパクト性・universal cover・deck group と線形写像の降下を受け取る。Milestone 3 の equivariant descent と比較を用い、log q の選択変更と、z = wʳ が与える有限 isogeny E_(q_r) → E_q を構成する。log q の実部が非零であることから lattice の実 rank が二であることを確認する。q を動かす period family の理論を、本ロードマップの固定 q の定理の前提にしない。

### From TauCetiRoadmap.ComplexKahlerGeometry

[§§3.2–3.3](../ComplexKahlerGeometry/README.md) の K3.HolomorphicStalk、K3.MeromorphicGermField から、一変数の正則 stalk と有理型 germ の分数体比較、位数、有限主部、局所双正則 pullback、Laurent 展開の一致を受け取る。§3.1 のパラメータ解析と §3.2 の Weierstrass preparation は 6.5–6.6 の局所一様構成に用いる。

[§4.1](../ComplexKahlerGeometry/README.md) の正則有限階数 bundle と locally free section sheaf の比較、§4.4 の成分ごとの locally constant rank の組立てを受け取る。§2.5 の bundle-valued Dolbeault と sheaf cohomology の比較、§5.10 の compact Dolbeault Hodge theory・有限次元性・Serre dualityを、3.7 の q 束に適用する。補助的な smooth Hermitian metric は選べるが、unitary な q 作用や平坦な metric を仮定しない。

[§§7.6–7.8](../ComplexKahlerGeometry/README.md) から複素 torus・曲面の向きと Chern 数の比較、E_q の genus 一、degree-zero line の lattice character 表示を受け取る。Θ_q の零 divisor と q automorphy factor の degree がこの Chern degree に一致すること、および負の pure q-slope の H⁰ 消滅は 3.7 で証明する。

### From TauCetiRoadmap.PseudoholomorphicCurveAnalysis

[§§6.2–6.4](../PseudoholomorphicCurveAnalysis/README.md) の滑らかな Cauchy–Riemann operator の Sobolev realization、楕円正則性、kernel・cokernel の比較と、[§7.2](../PseudoholomorphicCurveAnalysis/README.md) の閉曲面上の任意複素 rank r の index formula

    ind_ℝ D = rχ_top(Σ) + 2⟨c₁(E),[Σ]⟩

を受け取る。E_q 上の正則束の ∂̄ は複素線形であり、ComplexKahlerGeometry の bundle/Dolbeault 比較により左辺は 2(h⁰ − h¹) となる。χ_top(E_q) = 0 から h⁰ − h¹ = deg E を得る。負の総次数の任意 bundle に H⁰ = 0 を仮定せず、q 純型の section 方程式で必要な消滅を別に証明する。

### From TauCetiRoadmap.SpecialFunctionsTheta

[§§1.1–1.3](../SpecialFunctionsTheta/README.md) の theta 級数・正則性・準周期性、§§4.1–4.2 の product・零点・単純性、§5.1 の logarithmic derivative を受け取る。2.2 の Θ_q は |q| > 1 の乗法的規約なので、加法的 theta の変数と nome への変換を明示する。Character の multiplier、q-logarithm の加法的変換、e_ce_d/e_(cd) の楕円因子はこの変換から本ロードマップで導く。

### From TauCetiRoadmap.SchemeAndStackFoundations

[§1.1](../SchemeAndStackFoundations/README.md) の quasi-coherent sheaf と射の descent、§1.18 の groupoid に値を持つ stack と 2-fibre product を、1.6 の有限局所自由層・開部分上の q 同型・その可換図式へ適用する。有限局所自由性と同型であることは適切な局所性によって降下する。ここから q の stable moduli や Artin representability を供給されたものとは扱わない。

[§§1.15、2.3](../SchemeAndStackFoundations/README.md) から、群の層の torsor、native な NonabelianH1、torsor の同型類との比較、群の層の射による map、base pullback、trivial torsor の class を受け取る。4.4–4.6 ではこの carrier 上に q-Stokes cocycle と分類写像を構成する。既存の abelian な H¹ と非可換 torsor class を同じ加群として扱わない。

### From TauCetiRoadmap.TopologicalSheafCohomology

[§§1.1–1.3](../TopologicalSheafCohomology/README.md) の Čech cocycle、refinement、derived sheaf cohomology との比較を用いる。E_q は compact Hausdorff なので、§1.3 の compact Hausdorff space 上の R-module sheaf に対する比較を、q-Stokes の central quotient の additive sheaf へ適用できる。非可換 H¹ 自体の carrier は SchemeAndStackFoundations §2.3 を用い、additive quotient の H¹ と H² の計算だけをこの比較へ渡す。

### From TauCetiRoadmap.ComplexComparisonPartII

[C0.3–C0.4](../ComplexComparisonPartII/README.md) の coherent module・有限局所自由束の analytification、C1.9 の proper/projective coherent GAGA、C2.2 の束・切断・射の比較を受け取る。5.2 では、解析的に貼り合わせた ℙ¹ 上の束を代数化し、generic fibre の有理基底を解析側の有理型フレームへ戻す。微分接続の Riemann–Hilbert 比較はこの用途に含めない。q の接続行列と有理系の復元は 5.3–5.5 で証明する。

### Relation to TauCetiRoadmap.PainleveEquations

[Layers 0–2](../PainleveEquations/README.md) は、微分接続の内在的対象、輸送、追加局所データ、一般等モノドロミーの比較対象である。本ロードマップの証明の依存辺にはしない。ここでの主な違いは、q シフトの半線形作用、E_q 上の q-Stokes と接続データ、時間の離散 cocycle、局所格子の modification にある。6.7 の連続パラメータも q 接続を保存する輸送として述べ、微分接続自体の分類へ置き換えない。

## References

- **[S00]** Jacques Sauloy, [Systèmes aux q-différences singuliers réguliers : classification, matrice de connexion et monodromie](https://www.numdam.org/item/AIF_2000__50_4_1021_0/), *Annales de l’Institut Fourier* **50** (2000), no. 4, 1021–1071. 刊行版を参照する。§§1.1.1–1.1.4 の収束する局所定数化と基本解、§1.3 の正則特異性、§§2.2–2.3 の接続分類と Birkhoff の貼り合わせを用いる。

- **[S03]** Jacques Sauloy, [Galois theory of fuchsian q-difference equations](https://www.numdam.org/item/10.1016/j.ansens.2002.10.001/), *Annales scientifiques de l’École Normale Supérieure*, 4e série, **36** (2003), no. 6, 925–968. 刊行版。§1.1 の差分加群・行列系・cyclic vector、§1.2 の基本解、Lemma 2.1.3.2 の局所射、Proposition 3.1.1.3 の大域正則特異圏同値、§3.2.1 の tensor の比較を用いる。

- **[VPR07]** Marius van der Put and Marc Reversat, [Galois theory of q-difference equations](https://www.numdam.org/item/AFST_2007_6_16_3_665_0/), *Annales de la Faculté des Sciences de Toulouse*, 6e série, **16** (2007), no. 3, 665–718. 刊行版。Proposition 1.3、Corollaries 1.5–1.7 の pure 分類、Definition 1.8 の pure Laurent 模型、Proposition 1.9 の finite-level descent、§2 の楕円曲線上の束、Lemma 4.2・Theorem 4.3・Observations 4.5 の一般 Laurent 模型を用いる。原文は 0 < |q| < 1 を採り、半線形作用と Newton polygon の符号を本ロードマップの規約へ移す。

- **[S09]** Jacques Sauloy, [Équations aux q-différences et fibrés vectoriels holomorphes sur la courbe elliptique ℂ×/q^ℤ](https://www.numdam.org/item/AST_2009__323__397_0/), *Astérisque* **323** (2009), 397–429. 刊行版。§2.3.2、Theorem 2.4、Lemma 2.5 の整数傾きの filtered bundle 比較、§2.3.3 の q slope filtration と bundle filtration の区別を用いる。

- **[RSZ13]** Jean-Pierre Ramis, Jacques Sauloy, Changgui Zhang, [Local analytic classification of q-difference equations](https://www.numdam.org/item/AST_2013__355__R1_0/), *Astérisque* **355** (2013). 刊行版。Lemma 2.1.1、Proposition 2.1.3、Theorems 2.2.1・2.2.4、Definition 2.3.1、Theorems 3.1.1・3.1.4、Remark 3.1.5、§3.3 の Birkhoff–Guenther normal form、Theorem 4.4.1、Chapters 5–6、Appendices A.6–A.7 を用いる。R ⊗_ℂ ℂ({z}) による marked functor と、任意解析基底の共同解析的な族を区別する。

- **[S24]** Jacques Sauloy, [Classification analytique locale des équations aux q-différences de pentes arbitraires](https://www.numdam.org/item/10.5802/afst.1784/), *Annales de la Faculté des Sciences de Toulouse*, 6e série, **33** (2024), no. 3, 647–679. 刊行版。Theorem 3.1 の summation、Theorem 3.5 と §3.2.2 の整数傾きの q-Birkhoff–Malgrange–Sibuya 対応と affine structure、Propositions 3.9–3.11 と Theorem 3.13 の任意有理傾きへの降下を用いる。Hom block の bundle degree は、その rank を含めて determinant から計算する。

- **[B04]** Alexei Borodin, [Isomonodromy transformations of linear systems of difference equations](https://annals.math.princeton.edu/2004/160-3/p08), *Annals of Mathematics* **160** (2004), 1141–1182; [arXiv:math/0209144v2](https://arxiv.org/abs/math/0209144v2). Introduction (3q)–(7q)、Lemmas 3.2–3.4・3.11・4.2–4.3、§4(a)–(c)、Proposition 4.8、Theorem 4.9、Remark 4.14 を用いる。これらの番号は当該 preprint と刊行版で一致する。q 版は一般の再分解定理と Remark 4.14 の構成から展開し、加法差分の定理をそのまま q の定理として引用しない。

- **[K16]** Alisa Knizel, [Moduli spaces of q-connections and gap probabilities](https://doi.org/10.1093/imrn/rnv366), *International Mathematics Research Notices* **2016** (2016), no. 22, 6921–6954; [arXiv:1506.06718v2](https://arxiv.org/abs/1506.06718v2). 本文の Definition 1.5、Definition 1.6、Definition 1.7、Remark 1.8、equation (1.3) はこの arXiv 版の番号を用いる。一般の q 接続・零点と極・modification・gauge の定義のみを利用し、同論文の特定階数の moduli や非線形方程式は本ロードマップに取り込まない。

[S00]: https://www.numdam.org/item/AIF_2000__50_4_1021_0.pdf
[S03]: https://www.numdam.org/item/10.1016/j.ansens.2002.10.001.pdf
[VPR07]: https://www.numdam.org/item/AFST_2007_6_16_3_665_0.pdf
[S09]: https://www.numdam.org/item/AST_2009__323__397_0.pdf
[RSZ13]: https://www.numdam.org/item/AST_2013__355__R1_0.pdf
[S24]: https://www.numdam.org/item/10.5802/afst.1784.pdf
[B04]: https://arxiv.org/abs/math/0209144v2
[K16]: https://arxiv.org/abs/1506.06718v2
