# パンルヴェ方程式とパンルヴェ関数

微分パンルヴェ方程式を、付加構造付き有理型接続のモジュライ上の平坦な非線形接続として構成し、パンルヴェ関数をその水平切断と許容観測によって定義する。性質はその構成から証明する。古典的なスカラー方程式、Hamilton 関数、線形系の表示は座標比較定理として得る。

全体は10層・78個の構成および定理目標からなる。内訳は再利用可能な一般理論30目標、古典的パンルヴェへの適用44目標、および時間が二次元・相ファイバーが四次元となる五つの対数極への適用4目標である。

[English](README.md) · [構造化された数学計画](design/plan.json) · [外部依存の供給範囲](design/dependencies.json)

## 全体の構成

各レイヤーは、一つのまとまった数学的構成または定理群を到達点とする。一般定理とその適用を同じレイヤーに置く場合にも、各目標の入力・結論・証明責任を区別する。

| レイヤー | 到達点 | 目標数 |
|---:|---|---:|
| [0](#layer-0) | 非線形接続とその解 | 9 |
| [1](#layer-1) | 付加構造付き有理型接続のモジュライ | 6 |
| [2](#layer-2) | 等モノドロミー変形と対数型 Riemann–Hilbert 対応 | 10 |
| [3](#layer-3) | パンルヴェ方程式の相空間と等モノドロミー変形 | 12 |
| [4](#layer-4) | Riemann–Hilbert 比較とパンルヴェ性 | 9 |
| [5](#layer-5) | 初期値空間・対称性・Riccati 簡約 | 6 |
| [6](#layer-6) | 行列式線束とタウ切断 | 5 |
| [7](#layer-7) | パンルヴェ方程式の古典的表示 | 5 |
| [8](#layer-8) | Riemann–Hilbert 漸近解析と特徴的な解 | 8 |
| [9](#layer-9) | 合流と収束 | 8 |

<a id="general-theory"></a>

## 一般理論と適用

追加仮定付きの定理を含む全78目標を実施対象とする。仮定は結論の成立範囲を定めるものであり、証明するかどうかの選択ではない。構成、その基本API、比較写像、指定した例を、それぞれの目標に含める。

| 再利用する一般理論 | 目標 |
|---|---|
| 非線形接続・解・移送・観測・ジェット・収束 | 0.1–0.9 |
| 付加構造付き有理型接続のモジュライ | 1.1–1.6 |
| 等モノドロミー変形と対数型 Riemann–Hilbert 対応 | 2.1–2.6 |
| 正則 Fredholm 族の行列式線束 | 6.1 |
| Cauchy 作用素・小ノルム RHP・重み付きモーメント・Barnes G | 8.1–8.4 |
| 極相殺・有限代数の Poisson 幾何・切断および行列式の収束 | 9.1–9.4 |

これら30目標の推移的前提に、パンルヴェまたは五つの対数極への適用目標を含めない。五つの対数極への独立した適用は2.7–2.10であり、パンルヴェを前提にしない。残り44目標がパンルヴェへの適用である。レイヤー3–6の内在的構成と性質は、レイヤー7の古典的座標表示を前提にしない。同じレイヤーへの配置は依存関係を追加しない。相空間・接続・形式を構成してから性質を証明する。

既存ロードマップから受け取るのは、外部依存の供給範囲に明記した結果に限る。それ以外の構成には本ロードマップ内の担当目標を定める。適用側は一般理論と同じ対象・射・引戻しを用い、その仮定と比較を証明する。

## 目標番号と参照の規約

レイヤーを0から9までの通し番号とし、各目標を0.1、0.2、…のようにレイヤー番号と層内の連番で指定する。構造化された内部参照は target:0.1 の形式であり、本文中の内部参照も全体を通じて一意である。文献および供給元ロードマップの節番号は、その出典の番号を用いる。各目標に、その仮定・結論・比較則を定める。

<a id="external-dependencies"></a>
## 外部依存の供給範囲

ロードマップの参照は、そこで指定された構成・定理をその仮定の下で受け取ることを表し、実装済みという意味ではない。既存コードの参照は実際の対象・APIを指定する。ここで必要な拡張には本ロードマップ内の証明担当を定め、詳細を [design/dependencies.json](design/dependencies.json) に記録する。

| 供給項目 | 正確な供給先 | 範囲と本ロードマップの担当 |
|---|---|---|
| <a id="dependency-complex"></a>complex | [ComplexKahlerGeometry](../../TauCetiRoadmap/ComplexKahlerGeometry/README.md) — K1; K3.0; K3.HolomorphicStalk; K3.MeromorphicGermField; K4; K7.1 | 複素逆・陰関数と接束計算、正則芽・一変数有理型芽、正則束と層の同値、非特異な平坦接続と局所系、射影空間のチャート。非線形接続と正則ODEは非線形接続の一般理論、解析化と有理型比較は有理型接続モジュライの一般理論が担う。 |
| <a id="dependency-smooth"></a>smooth | [SmoothBundlesConnections](../../TauCetiRoadmap/SmoothBundlesConnections/README.md) — B1.5; B5.0; B5.2 | 滑らかなEhresmann分裂、固有沈め込みおよび主接続の移送を、それぞれの仮定の範囲で用いる。一般の非線形移送は0.1–0.5が担う。 |
| <a id="dependency-differential"></a>differential | [DifferentialGeometry](../../TauCetiRoadmap/DifferentialGeometry/README.md) — Layers 0–1; 3.1–3.5 | 有限次元多様体・チャート・滑らかな局所／極大／時間依存flow。連続時間・相変数局所一様Lipschitzの定理は0.2、一階jetは0.8、有限チャートの収束は0.9で証明する。 |
| <a id="dependency-frobenius"></a>frobenius | `TauCeti.Analysis.ODE.Frobenius` — TauCeti.exists_frobenius_flat_coordinate | 有限次元の実可積分グラフ場から、明記した正則性の下で、滑らかな逆写像と水平微分を持つ局所積OpenPartialHomeomorphを得る。0.5が沈め込み座標への移送、曲率から可積分性、貼合せとホモトピー不変性を証明し、正則版は0.3を用いる。 |
| <a id="dependency-covers"></a>covers | [Completed/UniversalCovers](../../Completed/UniversalCovers/README.md) — Stage 0.2–0.4; Stage 1.5; Stage 2.6–2.8 | 既存の被覆・経路とホモトピーの持上げ・普遍被覆・基本群。非線形作用と水平降下は0.5で構成し、非正規被覆では実際のファイバー関係を用いる。 |
| <a id="dependency-curves"></a>curves | [ComplexCurveModuli](../../TauCetiRoadmap/ComplexCurveModuli/README.md); [SchemeAndStackFoundations](../../TauCetiRoadmap/SchemeAndStackFoundations/README.md) — ComplexCurveModuli D0.3, D3–D5; SchemeAndStackFoundations 4.15 | 種数0のMöbius正規化と点の移動、安定範囲の標識曲線変形チャート。1・2標点の商チャート、有限jet、局所標識、行列式移送は1.2が構成する。 |
| <a id="dependency-stacks"></a>stacks | [SchemeAndStackFoundations](../../TauCetiRoadmap/SchemeAndStackFoundations/README.md) — 1.18–1.23 | スタック化・2ファイバー積・慣性・準連接層降下・有限慣性のKeel–Mori。Gmの剛化、GIT、gerbeと粗モジュライの比較は1.3が証明する。 |
| <a id="dependency-quotient-predicates"></a>quotient-predicates | [SchemeAndStackFoundations](../../TauCetiRoadmap/SchemeAndStackFoundations/README.md) — 1.17 | 圏論的商・幾何学的商の定義と明記された有限群商。簡約群の不変式と指標商は1.3/2.5、Stokesの商は4.2で構成する。 |
| <a id="dependency-quot"></a>quot | [SchemeAndStackFoundations](../../TauCetiRoadmap/SchemeAndStackFoundations/README.md) — 4.14 | Noetherian・射影的なQuot/HilbertとHom/Isom空間。接続の有界性・方程式・安定性は1.3、解析的引戻しは1.2が担う。 |
| <a id="dependency-cohomology"></a>cohomology | [SchemeAndStackFoundations](../../TauCetiRoadmap/SchemeAndStackFoundations/README.md) — 2.2; 2.6; 2.20; 3.3 | Čech・層コホモロジー、連接な項、相対・Serre双対、次数・曲線Riemann–Roch。ℂ線形微分作用素の全複体と分岐の錐は1.4が構成する。 |
| <a id="dependency-deformation"></a>deformation | [SchemeAndStackFoundations](../../TauCetiRoadmap/SchemeAndStackFoundations/README.md) — 4.2–4.6 | Artin係数・変形関手・hull・基本的小拡大の障害。実際の接続コサイクルと平方零核・versal比較は1.4、強い水平延長は2.1で証明する。 |
| <a id="dependency-bundles"></a>bundles | [AlgebraicVectorBundles](../../TauCetiRoadmap/AlgebraicVectorBundles/README.md) — L0A–L0C; L1A–L1B; L2A–L2B | 有限局所自由層、双対・テンソル・行列式、相対Specと幾何学的ベクトル束との同値。接続と解析化は1.1–1.2、相対Poisson構成は9.2が担う。 |
| <a id="dependency-analytic-coherence"></a>analytic-coherence | [RealAnalyticGeometry](../../TauCetiRoadmap/RealAnalyticGeometry/README.md) — R3.2 item 0 | 与えられた解析多様体の構造層上の連接解析加群。冪零元を含む一般複素解析空間、解析化、GAGA比較は1.2が構成する。 |
| <a id="dependency-proper-cohomology"></a>proper-cohomology | [JacobianChallenge](../../TauCetiRoadmap/JacobianChallenge/README.md) — Layer C | 固有連接直像と、各仮定を区別した平坦基底変換・コホモロジー基底変換。相対Picard拡張は1.5、境界係数と任意基底変換の検証は5.3が担う。 |
| <a id="dependency-chow"></a>chow | [SchemeAndStackFoundations](../../TauCetiRoadmap/SchemeAndStackFoundations/README.md) — 4.12, `chow_lemma` only; 0.9 and 4.11 | Noetherian基底への有限型分離射に対し、基底上準射影的となる射影的改変を供給し、元の射が固有なら改変後は基底上射影的となる。1.2はこの小目標と連接コホモロジー・固有直像をGAGAの証明に用い、4.12の別の平坦化・StableReductionの分岐は前提にしない。 |
| <a id="dependency-field-picard"></a>field-picard | [JacobianChallenge](../../TauCetiRoadmap/JacobianChallenge/README.md); [SchemeAndStackFoundations](../../TauCetiRoadmap/SchemeAndStackFoundations/README.md) — JacobianChallenge Layer D; SchemeAndStackFoundations 1.1, 2.6, 3.4, 4.6, 4.14 | 体上の射影的幾何学的整スキームのPicard、滑らかな曲線のJacobian、線束降下・変形。非被約曲線を含む相対Picardは1.5が構成する。 |
| <a id="dependency-supports"></a>supports | [SchemeAndStackFoundations](../../TauCetiRoadmap/SchemeAndStackFoundations/README.md) — 2.7 | 台付きコホモロジー、局所化・切除、NoetherianなExt余極限との比較。第一境界層・注入・時間直線は5.3が構成する。 |
| <a id="dependency-surfaces"></a>surfaces | [SchemeAndStackFoundations](../../TauCetiRoadmap/SchemeAndStackFoundations/README.md) — 3.4; 4.11; 4.17; 5.9–5.10 | 因子・Picard群、ブローアップ・狭義変換、正規交叉、曲面交点・随伴・格子。非被約境界と相対変形は目標5.1–5.3、変換は目標5.4–5.6が担う。 |
| <a id="dependency-formal-series"></a>formal-series | [FormalLaurentPuiseux](../../TauCetiRoadmap/FormalLaurentPuiseux/README.md) — L1–L4; L5–L6 for finite-extension steps in 1.1 | 形式代入・連続微分・有限次元HahnModule・留数・分岐と有限拡大の代数。微分加群標準形は1.1、収束芽の極相殺と一様極限は9.1が証明する。 |
| <a id="dependency-fredholm"></a>fredholm | `Mathlib.Analysis.Normed.Operator.Fredholm.Basic`; `TauCeti.Analysis.Fredholm.Stabilization`; `TauCeti.Analysis.Normed.Operator.Splitting.Family`; `TauCeti.LinearAlgebra.Determinant.Line` — IsFredholm; nonempty_fredholmPackage; exists_stabilization_kernel_coordinates; kernelHomeomorph; contDiffAt_kerSection; detLine; detLineCongr | 体を複素数に特殊化できる核・余核・安定化と各点の行列式線。双対規約を用い、正則な族・標準切断・コサイクルは6.1が構成する。 |
| <a id="dependency-inversion"></a>inversion | `Mathlib.Analysis.Analytic.Constructions` — analyticAt_inverse; analyticAt_inverse_one_sub | 完備ノルム代数の可逆元における解析的逆写像。実際の族から作用素への写像と一様評価は6.1/8.2で証明する。 |
| <a id="dependency-lp"></a>lp | `Mathlib.Analysis.Fourier.LpSpace`; `Mathlib.MeasureTheory.Function.Holder` — Complex L²/Fourier–Plancherel; Hölder and dominated convergence on the native measure/integral carrier | 既存の複素Lp、Fourier–Plancherel、Hölder不等式、積分収束。積分路の比較は8.1、重み付きモーメントと裾の一様性は8.3が担う。 |
| <a id="dependency-hilbert-transform"></a>hilbert-transform | [PDE](../../TauCetiRoadmap/PDE/README.md) — 2.3/B10 | 実直線のHilbert変換とL²ノルム1の乗算子表示。分岐間の重み付きSchur評価・Plemelj・端点復元は8.1が証明する。 |
| <a id="dependency-cauchy"></a>cauchy | `TauCeti.Analysis.Contour.Cauchy.IntegralFormula`; `TauCeti.MeasureTheory.Integral.SchurTest` — Cauchy integral formula; Unweighted Schur estimates | 指定された既存積分路のCauchy公式と重みなしSchur評価。1/(s+t)の頂点核に必要な重み付き定理は8.1が証明する。 |
| <a id="dependency-trace-ideal"></a>trace-ideal | [OperatorTheory/OperatorIdeals](../../TauCetiRoadmap/OperatorTheory/OperatorIdeals/README.md) — OI-B01–OI-B19; OI-B23; OI-B29–OI-B30 | 完備なトレースクラス・イデアルとノルム評価。正則族は9.4、実際のRHPからの実現は6.3が担う。 |
| <a id="dependency-trace-determinant"></a>trace-determinant | [RandomMatrices](../../TauCetiRoadmap/RandomMatrices/README.md) — 8.3, generic operator-theory prefix | 正の核への特殊化以前の一般的なトレース・外冪・Fredholm行列式級数・トレースノルム連続性。正則依存は9.4、変分比較は6.4で証明する。 |
| <a id="dependency-toeplitz"></a>toeplitz | [OperatorTheory/ToeplitzOperators](../../TauCetiRoadmap/OperatorTheory/ToeplitzOperators/README.md) — T1–T3 | 円周Hardy模型と可逆行列記号の指数＝行列式回転数の負。6.3が実際の積分路・正則族・共鳴・分岐の比較を構成する。 |
| <a id="dependency-rouche"></a>rouche | `TauCeti.Analysis.Complex.Conformal.Rouche`; `TauCeti.Analysis.Analytic.ZeroCount` — rouche; rouche_nullHomologous; Multiplicity zero-count carrier | 円板・零ホモローグな区分的C¹閉曲線のRouchéと零点重複度。一般領域の境界サイクルと回転数は9.4で構成する。 |
| <a id="dependency-meromorphic-germs"></a>meromorphic-germs | `TauCeti.Analysis.Meromorphic.Germ`; `TauCeti.Analysis.Meromorphic.PrincipalPart` — meromorphicGerms.principalPart; principalPart_eq_iff; principalPart_eq_sum_coeff; Analytic regular remainder | スカラーの収束有理型芽・有限主要部・正則剰余。有限次元係数と極相殺・パラメータ一様極限は9.1が担う。 |
| <a id="dependency-curve-functions"></a>curve-functions | `TauCeti.Analysis.Complex.RiemannSurface.FunctionField`; `TauCeti.Analysis.Complex.RiemannSurface.FunctionField.Comap` — TauCeti.RiemannSurface.MeromorphicFunction; Nonconstant curve pullback and order comparison | Riemann面からOnePoint ℂへの正則写像と恒等的無限大を除く証人、引戻し・位数。相空間の観測許容性とスカラー降下は0.7が証明し、同じ関数の対象を用いる。 |
| <a id="dependency-poisson"></a>poisson | [LieGroupoidsPoisson](../../TauCetiRoadmap/LieGroupoidsPoisson/README.md) — G4.6A | 実Lie–Poissonの正負規約とファイバー符号反転。複素相対括弧・留数対・基底変換は9.2が構成する。 |
| <a id="dependency-reduction"></a>reduction | [SymplecticGeometry/HamiltonianReduction](../../TauCetiRoadmap/SymplecticGeometry/HamiltonianReduction/README.md) — R2; R3 | 実滑らかなKKSと正則・自由・固有なHamilton簡約。複素商の存在・軌道の平坦性・衝突の比較は9.5が証明する。 |
| <a id="dependency-airy-hm"></a>airy-hm | [RandomMatrices](../../TauCetiRoadmap/RandomMatrices/README.md) — 8.4; 8.5 | Airyの正規化と裾、Hastings–McLeod解の存在一意性・実軸上の無極性・F1/F2恒等式。内在的な解への橋渡しは8.8、接続定数は8.7が担う。 |
| <a id="dependency-gamma"></a>gamma | `Mathlib.Analysis.SpecialFunctions.Gamma.Basic`; `Mathlib.Analysis.SpecialFunctions.Gamma.Beta`; `Mathlib.Analysis.SpecialFunctions.Gamma.Deriv`; `Mathlib.NumberTheory.Bernoulli`; `Mathlib.NumberTheory.BernoulliPolynomials` — Complex.Gamma; GammaSeq_tendsto_Gamma; Gamma_ne_zero; Real.eulerMascheroniConstant; Bernoulli numbers/polynomials | 既存Gammaと極を除く解析理論、Euler定数、Bernoulli係数。Barnes G・標準正規化・零因子・枝・明示剰余は8.4で構成する。 |
| <a id="dependency-proper"></a>proper | `Mathlib.Topology.Maps.Proper.Basic` — IsProperMap | 位相的固有写像と各仮定の下でのコンパクト逆像・基底変換。水平延長は0.4、解析比較は1.2、RH族の固有性は4.4が証明する。 |

### 補助構成の一次文献

- **DLMF5.** NIST Digital Library of Mathematical Functions. [Barnes G-function (Double Gamma Function)](https://dlmf.nist.gov/5.17). 5.17.1, 5.17.3, 5.17.5 and 5.17.7.
- **NEM14.** Gergő Nemes. [Error bounds and exponential improvement for the asymptotic expansion of the Barnes G-function](https://arxiv.org/abs/1406.2535v2). Equation (1.1); Theorem 1.2, equation (1.10); proofs §§2–3.
- **SGA1XII.** A. Grothendieck et al.; Exposé XII by M. Raynaud. [Revêtements étales et groupe fondamental (SGA 1), Exposé XII: Géométrie algébrique et géométrie analytique](https://arxiv.org/pdf/math/0206203v2). XII Theorem and Definition 1.1 (analytification); §2 (coherent sheaf comparison); §3.1 (morphism properties, including properness); Theorem 4.2 (proper relative direct-image comparison); Corollary 4.3 (cohomology); Theorem 4.4 (proper coherent GAGA).
- **SERREGAGA.** J.-P. Serre. [Géométrie algébrique et géométrie analytique](https://www.numdam.org/article/AIF_1956__6__1_0.pdf). §§1–2; §3 no.12 Theorems1–3 and proofs nos.13–17.
- **GR84.** H. Grauert and R. Remmert. [Coherent Analytic Sheaves](https://link.springer.com/book/10.1007/978-3-642-69582-7). Chapter I, Complex Spaces (pp.1–37); Chapter X, Direct Image Theorem (pp.188–222).
- **KED09.** K. S. Kedlaya. [Good formal structures for flat meromorphic connections, I: Surfaces](https://arxiv.org/pdf/0811.0190v4). §2.1 (field and constants); §2.2 (regular modules and regulating lattices); Theorem2.3.3 and its proof; §2.4 (Deligne–Malgrange lattices).
- **DEL70.** P. Deligne. [Équations différentielles à points singuliers réguliers](https://publications.ias.edu/sites/default/files/Number9.pdf). II §5, Proposition5.4 (extension for a section of ℂ→ℂ/ℤ); Corollary5.6 (nonresonant monodromy/residue comparison); Theorem5.9 (regular-singular algebraic/analytic correspondence); II §6.6 (principal-parts analytification of differential operators and proper hypercohomology comparison), PDF p.103 / printed p.101. [1971年4月の訂正](https://publications.ias.edu/sites/default/files/Erratum%20to%20SLN%20163.pdf)を併用し、II1.23–1.24を除き、高次元の正則特異性・存在論からII5.7/5.9に至る議論ではII4.1の訂正済み証明を用いる。引用した一変数の主張の範囲は保持する。
- **ACV03.** D. Abramovich, A. Corti and A. Vistoli. [Twisted bundles and admissible covers](https://arxiv.org/pdf/math/0106211). §5.1, Theorem5.1.5 and construction; Stacks Project tag04V2 for hypotheses.
- **PICREL.** The Stacks Project Authors. [The Picard functor and its properties](https://stacks.math.columbia.edu/tag/0D2C). Proposition99.11.8, tag0D2C; Lemma108.9.3, tag0DNI; Lemma108.9.5, tag0DPK; the Picard gerbe Lemma108.9.1 in tag0DMD.
- **MFK94.** D. Mumford, J. Fogarty and F. Kirwan. [Geometric Invariant Theory, third edition](https://link.springer.com/book/9783540569633). Chapter1, reductive invariant theory and construction of quotients; coupled to I23 Theorem5.1 and its actual framed filtered-connection construction.

<a id="layer-0"></a>

## レイヤー0：非線形接続とその解

<a id="nonlinear-connections"></a>

本部は、一つのロードマップの中で独立に再利用できる証明単位であり、共通の [plan](design/plan.json) と [英語版](README.md#nonlinear-connections) に記録する。数学的前提には Painlevé の目標、階数二、極因子次数四、古典的スカラー方程式、Riemann–Hilbert 比較を含めない。幾何学的応用の側が自分の相空間族・分裂・補助形式・比較写像を構成し、仮定を証明した一般結果だけを利用する。実際の対象・射・引戻し・比較同型を保持する。

### 定理と構成

| 目標 | 独立に提供する結果 | 利用側が証明すべき追加の入力 |
|---|---|---|
| 0.1 | 非線形接続の対象・射・曲率・基底変換 | 実際の沈め込みと接束の分裂 |
| 0.2 | 局所経路持上げとコンパクト延長 | 時間の連続性と相変数の局所一様 Lipschitz 評価 |
| 0.3 | 正則水平芽とパラメータ依存 | 正則分裂と時間方向の平坦性 |
| 0.4 | 固有半共役による完備性移送 | 固有写像と、すべての点からの部分持上げに対する整合性 |
| 0.5 | 基本亜群作用・普遍被覆上の切断・降下 | 妥当な任意の方法で証明した平坦性と経路完備性 |
| 0.6 | 全空間形式の閉性判定と symplectic transport | ファイバー上の閉性・非退化性と、明記した保存性または全空間閉性 |
| 0.7 | 許容評価とスカラー降下 | 複素曲線上の実際の許容観測 |
| 0.8 | 内在的一階 jet によるスカラー化 | 観測と、証明済みの局所 jet 同型 |
| 0.9 | 存在・no-exit を含む有限座標での収束 | 共通定義域・正の余裕・場の一様評価・対応する初期値 |

依存関係は、スカラー化を symplectic 幾何や大域解析接続の後に置かない。固有半共役定理には平坦性は不要だが、基本亜群 transport には必要である。有理型評価は任意の曲線からの正則写像に使え、接続の完備性を先に証明する必要はない。コンパクト経路での収束は衝突・合流の構成に依存せず、その構成の側が共通定義域の仮定を検証する。

### 正則性の仮定

実 $`C^1`$ 版は個々の水平経路持上げに用いる。曲率・微分形式の恒等式・滑らかな平坦積定理には滑らかな実データを用いる。複素版では有限次元複素多様体上の正則データを用いる。特異・非被約・無限次元の基底への拡張を暗黙に主張しない。

完備性を既に証明した接続を target:0.5 に供給することは正当である。それは、あらゆる接続の定義に完備性の証明を入れてしまうこととは異なる。target:0.1–0.3 で対象と局所解理論を構成し、target:0.4 で完備性の一つの十分条件を証明する。同様に target:0.6 は独立に構成した相対形式を受け取り、平坦性・保存性・全空間閉性の関係を証明する。応用の相対形式そのものを仮定で作ったことにはしない。

<a id="target-0-1"></a>
### 0.1 Ehresmann 接続・射・基底変換

**一般理論。**

$`\pi:M\to B`$ を、境界を持たない有限次元 Hausdorff・第二可算な滑らかな多様体の間の滑らかな沈め込みとする。実非線形接続とは $`d\pi\circ h=\mathrm{id}`$ を満たす $`C^1`$ ベクトル束分裂 $`h:\pi^*TB\to TM`$ である。正則版では複素多様体、正則な沈め込み、正則分裂を用いる。$`\pi`$ の全射性・固有性は定義に含めない。曲率・微分形式・滑らかな Frobenius 理論を使う箇所では実分裂を滑らかと仮定し、$`C^1`$ 版は個々の経路の持上げに用いる。

射 $`(F,f):(M\to B,h)\to(N\to C,k)`$ は、$`\rho F=f\pi`$ および $`dF\circ h=k\circ df`$ を満たす実際の滑らかな写像の組とする。正則圏では正則写像を用いる。恒等射と合成は写像の恒等射と合成である。同型は逆射と整合性を保持し、対象を商集合の一点として同一視しない。

滑らかな、または正則な基底写像 $`u:B'\to B`$ に対し、ファイバー積 $`M'=B'\times_BM`$ と射影 $`\pi'`$ を構成し、$`h'_{(b',m)}(v)=(v,h_m(du(v)))`$ により引戻し分裂を構成する。これが接空間に属すること、分裂恒等式、射に関する関手性、反復基底変換の標準比較同型と整合律を証明する。水平・垂直接部分束を構成し、滑らかまたは正則な場合には垂直曲率 $`K_h(X,Y)=[hX,hY]-h[X,Y]`$ を構成する。平坦性とは $`K_h=0`$ である。水平解作用素・完備性・symplectic 形式は入力に含めない。

**仮定.**

- 境界を持たない有限次元 Hausdorff・第二可算多様体、滑らかな沈め込み、C¹ 分裂。あるいは有限次元複素多様体、正則な沈め込み、正則分裂。
- 曲率と微分形式の主張では実分裂を滑らかとする。基底変換と射の正則性は選択した圏に従う。

**API.**

- 実際の接続保存射とその同型の圏、および接束の水平・垂直分裂を構成する。
- 任意の滑らかな、または正則な基底写像に沿う引戻し接続を構成し、恒等・合成・Cartesian 比較の法則を実際の比較写像とともに証明する。
- $`K_h`$ のテンソル性、接続同型と引戻しに関する自然性を証明する。平坦性は完備性・symplectic 性から独立に定義する。

**チェック.**

- $`TB\ne0`$ のとき零写像 $`\pi^*TB\to TM`$ は分裂恒等式を満たさない。積 $`B\times X\to B`$ の積分裂は満たす。
- 非臨界な時間変換 $`\tau=2t`$ では、$`\partial_\tau`$ に射影するよう正規化したベクトル場は、$`\partial_t`$ に射影するものの二分の一である。
- 分岐した時間写像に沿っても引戻し接続は定義できる。しかし、その事実だけから完備性や一階 jet 観測写像の可逆性は従わない。

*必要な先行結果：* [Smooth bundle and connection foundations](#dependency-smooth) (B1.5; B5.0; B5.2); [Complex manifolds, holomorphic bundles and observations](#dependency-complex) (K1; K3.0; K3.HolomorphicStalk; K3.MeromorphicGermField; K4; K7.1).

**出典と適用範囲.** 一般的な幾何学的構成である。古典的な族や比較射を必要としない。

<a id="target-0-2"></a>
### 0.2 局所水平持上げと連続時間 ODE のコンパクト延長

**一般理論。**

有限次元座標領域上の $`y'=F(t,y)`$ について、$`F`$ が時間について連続で、相変数について局所一様 Lipschitz である場合の局所存在・一意性を証明する。十分小さい閉じた時間・相変数の箱で定数を一様に取る。沈め込み座標 $`\pi(z,y)=z`$ では、$`C^1`$ 基底経路 $`\gamma`$ と $`C^1`$ 分裂から $`y'=A(\gamma(t),y)\gamma'(t)`$ を得る。積分方程式の縮小写像論法で局所解を構成し、一意性・制限との整合性を証明し、座標解を貼り合わせて各初期点を通る一意な極大水平持上げを構成する。有限個の $`C^1`$ 区分を持つ経路では区切り点で解を連結する。

コンパクト延長補題を証明する。基底経路の有限端点まで定義された部分的水平持上げの像が $`M`$ の一つのコンパクト集合に含まれるなら、その端点を越えて延長できる。コンパクト集合付近の有限個の沈め込み座標、一様な局所存在時間、集積点と一意性により端点値と延長を得る。集積点の存在だけで収束を主張してはならず、局所一意性による議論を含める。同じ座標形式の通常の非自律 ODE にもこの補題を提供する。

$`C^1`$ 経路の速度は連続であるだけなので、自律化した場 $`(1,F(t,y))`$ は $`C^1`$ とは限らない。証明では上記の連続時間定理、またはそれへの証明済みの帰着を用い、仮定を満たさない滑らかなベクトル場の定理を流用しない。この仮定の下では初期値への連続依存を証明する。滑らかな依存や正則依存は追加の正則性の下でのみ主張し、正則水平切断は target:0.3 で構成する。完備な持上げ作用素は仮定しない。

**仮定.**

- target:0.1 の接続と、コンパクト区間上で有限個の C¹ 区分を持つ基底経路。
- 解析的座標補題では、開領域上の有限次元 ODE が時間について連続、相変数について局所一様 Lipschitz であること。
- コンパクト延長では、基底経路が定義される有限端点と、部分持上げの像全体を含む一つのコンパクト集合。

**API.**

- 連続時間 Picard–Lindelöf 座標定理と、局所持上げに必要な初期値への連続依存を証明する。
- 一意な極大水平持上げを構成し、制限、定義される範囲での逆向き経路、有限個の C¹ 区分の連結との整合性を証明する。
- 部分持上げが一つのコンパクト集合に含まれれば有限端点を越えて延長することを、実際の非自律 ODE の正則性を用いて証明する。

**チェック.**

- 積分裂では水平持上げのファイバー座標は定数である。
- $`y'=y^2,\ y(0)=1`$ の解は $`y(t)=1/(1-t)`$ であり、アフィン相直線内では $`t=1`$ を越えて延長しない。コンパクト包含の仮定が破れている。
- $`\gamma(s)=|s-1/2|^{3/2}`$ は $`C^1`$ だが、$`\gamma'`$ は $`1/2`$ で $`C^1`$ ではない。持上げ方程式は連続時間 ODE として適用範囲内にあるが、$`C^1`$ 自律化を仮定できない。

*必要な先行結果：* 内部依存：0.1; [Smooth differential calculus and flows](#dependency-differential) (Layers 0–1; 3.1–3.5).

**出典と適用範囲.** 一般 ODE の構成と解析接続の証明である。後の固有性・no-exit 論法に必要な解析的内容を担い、Riemann–Hilbert 写像を用いない。

<a id="target-0-3"></a>
### 0.3 正則水平切断の芽とパラメータ依存

**一般理論。**

平坦な正則分裂を持つ正則な沈め込みについて、各 $`x_0\in M_{b_0}`$ を通り、$`\pi s=\mathrm{id},\ s(b_0)=x_0,\ ds=h`$ を満たす一意な正則水平切断の芽を構成する。沈め込みと分裂が、整合する有限次元複素多様体のパラメータ座標内で正則に変化する場合には、初期点と補助パラメータへの同時正則依存を含む局所存在を証明する。特異な基底や非被約な基底についての主張を暗黙に含めない。

証明課題には、正則パラメータ依存を持つ複素 ODE の定理そのものを含める。共通多重円板上で Picard 反復を収束させ、一様収束から正則性を示し、一意性を証明する。局所基底座標では、平坦性から水平座標ベクトル場が可換となる。局所 flow の可換性を証明し、これらを合成して局所積座標と水平切断を得る。連結な重なり上の一意性と整合性も証明する。こうして得られる初期点と水平芽の対応は、実際の接続同型と整合する基底変換に関して自然である。これは局所構成であり、大域的解析接続は主張しない。

水平芽は局所解析の証明から構成し、その存在定理そのものを入力にしない。一変数複素基底では正則水平直線分布の平坦性は自動的であるが、高次元基底では実質的な仮定である。

**仮定.**

- 有限次元複素多様体、正則な沈め込み、平坦な正則分裂。
- パラメータへの同時正則依存では、有限次元複素多様体のパラメータ座標上の整合する局所正則族と、時間方向の平坦性。
- 指定した基底点のファイバーに属する初期点。その近傍を縮小した局所結論を得る。

**API.**

- 共通多重円板上で複素 ODE の局所存在・一意性と、初期点・パラメータへの同時正則依存を証明する。
- 分裂の証明済み平坦性から、可換な水平 flow と局所正則積座標を構成する。
- 初期点と局所水平切断の芽の自然な全単射を構成し、一意性と重なり上の整合性を証明する。

**チェック.**

- 積分裂では $`(b_0,x_0)`$ を通る水平切断は $`b\mapsto(b,x_0)`$ である。定値写像 $`b\mapsto(b_0,x_0)`$ は自明でない基底上の切断ではない。
- $`\mathbb C^2_{s,t}\times\mathbb C_y`$ 上で $`h\partial_s=\partial_s,\ h\partial_t=\partial_t+s\partial_y`$ とする。水平切断なら $`y_s=0,\ y_t=s`$ が必要で、混合偏微分の一致に反する。平坦性を除けない。
- 滑らかなパラメータ多重円板上の定理だけでは、特異または非被約な基底上の水平切断は得られない。

*必要な先行結果：* 内部依存：0.1, 0.2; [Complex manifolds, holomorphic bundles and observations](#dependency-complex) (K1; K3.0; K3.HolomorphicStalk; K3.MeromorphicGermField; K4; K7.1).

**出典と適用範囲.** 一般解析の構成・定理である。特殊な等モノドロミー水平切断の結果は応用例であり、証明の前提ではない。

<a id="target-0-4"></a>
### 0.4 固有な半共役による完備性の移送

**一般理論。**

$`(M\to B,h)`$ を target:0.1 の実接続とする。$`p:R\to B`$ は位相空間の連続写像であり、完備な連続 transport が指定されているとする。すなわち、有限個の $`C^1`$ 区分を持つ各経路 $`\gamma:[a,b]\to B`$ と各 $`r_0\in R_{\gamma(a)}`$ に対し、$`\gamma`$ 上にあり $`r_0`$ から出発する連続軌道 $`\beta_{\gamma,r_0}:[a,b]\to R`$ があり、制限と連結の法則を満たす。$`R`$ は多様体でなくてよい。$`F:M\to R`$ は $`B`$ 上の連続写像で、コンパクト集合の逆像がコンパクトであるという明示的な意味で固有とする。

各始点での整合性を仮定する。すべての部分的水平持上げ $`x`$ が、その初期点 $`x_0`$ に対し、定義域全体で $`F(x(t))=\beta_{\gamma,F(x_0)}(t)`$ を満たす。このとき、上記のすべての基底経路と $`M_{\gamma(a)}`$ のすべての初期点について、コンパクト区間全体にわたる一意な水平持上げが存在することを証明する。この完備性定理に平坦性は不要である。

完全な標的軌道の像 $`K=\beta_{\gamma,F(x_0)}([a,b])`$ はコンパクトである。部分持上げは $`F^{-1}(K)`$ 内に留まるので、target:0.2 により有限端点を越えて延長でき、局所一意性により貼り合わさる。必要なのは $`F`$ の固有性であり、相空間射影 $`M\to B`$ の固有性ではない。$`F`$ の逆写像・単射性・全射性を用いない。非自明なコンパクト例外ファイバーも全体を保持する。その中の初期点は重要であり、標的軌道の逆像を任意に一つ選んで transport を定義してはならない。

正則な分裂については、その実多様体としての構造に実定理を適用する。正則局所切断やホモトピー不変性には、別目標に述べる平坦性と解析的結果がさらに必要である。稠密開集合上だけの整合性、または例外点を除いた部分でしか成り立たない固有性は、本定理の仮定を満たさない。

**仮定.**

- target:0.1 の有限次元 C¹ Ehresmann 分裂。局所存在とコンパクト延長は target:0.2 から得る。
- B 上の連続な標的と、すべてのコンパクトな区分的 C¹ 基底経路に対する完備な連続軌道。制限・連結の法則を含む。
- 各コンパクト集合の逆像がコンパクトである、B 上の連続写像 F。
- 例外点を含むすべての始点からの、すべての部分的水平持上げに対する半共役条件。

**API.**

- 固有半共役の仮定から、コンパクトな区分的 C¹ 基底経路の全体にわたる、各初期点を通る一意な水平持上げを構成する。
- F の逆写像を選ばず完備性を証明し、コンパクト例外ファイバーの異なる初期点を保持する。
- 正則分裂の実幾何に定理を適用する。固有性だけから平坦性や正則大域切断を主張しない。

**チェック.**

- $`M=\mathbb C_t\times\mathbb C_y,\ h\partial_t=\partial_t+y^2\partial_y,\ R=B=\mathbb C_t,\ F=\pi`$ とする。標的 transport は完備で半共役も成り立つが、$`F`$ は固有ではない。$`y(0)=1`$ の持上げは $`y(1/2)=2,\ y(3/4)=4`$ で、$`t=1`$ に有限値を持たない。
- 積接続と、その定ファイバー座標 transport への恒等比較では、定理は定数のファイバー座標を返す。
- 固有比較が例外曲線を縮約する場合、証明は標的軌道のコンパクトな逆像と、例外曲線の各点における局所一意性を用いる。ファイバーを任意に選んだ一つの逆像点で置き換えると、必要な初期値主張を失う。
- $`C^1`$ 経路 $`\gamma(s)=|s-1/2|^{3/2}`$ は適用範囲内である。その速度が連続にとどまることを target:0.2 で処理し、未証明の $`C^1`$ 自律化を使わない。

*必要な先行結果：* 内部依存：0.1, 0.2.

**出典と適用範囲.** IIS06 Definitions 2.1–2.2 と Lemma 2.12 に例示される非線形接続と幾何学的解析接続の観点から、証明機構を抽出する。一般の連続標的に対する定式化と厳密な仮定は本モジュールで証明する。これらの特殊な結果だけで、あらゆる入力に固有比較が存在するとはしない。

<a id="target-0-5"></a>
### 0.5 基本亜群の transport・普遍被覆・降下

**一般理論。**

滑らかな実接続または正則接続が平坦であり、すべてのコンパクトな区分的 $`C^1`$ 経路に関して完備であるとする。完備性は接続を供給する側が target:0.4 または他の妥当な方法で証明する仮定である。一意な水平持上げから終点写像 $`T_\gamma:M_{\gamma(a)}\to M_{\gamma(b)}`$ を構成し、恒等・逆向き・連結の法則を証明する。$`\gamma_1`$ の後に $`\gamma_2`$ をたどる場合、$`T_{\gamma_2*\gamma_1}=T_{\gamma_2}\circ T_{\gamma_1}`$ と約束する。

端点を固定したホモトピーに対する不変性を証明する。局所平坦積座標、コンパクトなホモトピーの有限分割、重なり上の一意性を用い、連続ホモトピーを区分的に滑らかな代表に関係づける近似または分割の段階も含める。これにより $`B`$ の基本亜群の作用を構成する。終点写像は実の場合には微分同相、正則の場合には双正則写像である。ここで symplectic 保存性は導かない。

連結な $`B`$、指定した $`b_0`$ と基点付き普遍被覆 $`p:\widetilde B\to B`$ に対し、各 $`x_0\in M_{b_0}`$ から、引戻し族 $`\widetilde B\times_BM\to\widetilde B`$ の大域水平切断を構成する。局所積定理により滑らかさ、または正則性を証明する。この切断が $`B`$ 上に降下することと、初期点 $`x_0`$ がすべての基点付きループ $`\ell`$ の実際のモノドロミー写像 $`T_\ell`$ で固定されることは同値である。普遍被覆上の解と、その降下障害は別個の出力である。引戻し・接続同型に対する自然性を実際の写像で証明し、供給された相空間の例外点も含める。

**仮定.**

- target:0.1 の滑らかな実または正則な平坦接続。すべてのコンパクトな区分的 C¹ 基底経路に対する完備性を、接続の供給側が証明済みであること。
- 普遍被覆については、連結な基底、基点、基点付き普遍被覆。有限次元多様体は通常の局所的被覆仮定を満たす。
- symplectic 形式や Riemann–Hilbert 比較は不要である。

**API.**

- 終点 transport を構成し、連結・逆向き・ホモトピー不変性を証明し、実際のファイバー同型による基本亜群作用を得る。
- 基点付き普遍被覆上の引戻し族において、各初期点を通る一意な大域水平切断を構成する。
- 水平切断が元の基底に降下するための必要十分条件が、初期点が全モノドロミー作用で固定されることであると証明する。

**チェック.**

- ループとその逆向きの連結は、別途供給された比較の例外ファイバー上の点を含む、すべての初期点で恒等として作用する。
- $`\mathbb C_t^\times\times\mathbb C^2_{q,p}`$ 上の $`q'=q/(2t),\ p'=-p/(2t)`$ は完備平坦接続である。正方向一周は $`(q,p)\mapsto(-q,-p)`$、二周は恒等である。全ループに固定されるのは $`(0,0)`$ のみだが、すべての初期点は普遍被覆上の水平切断を持つ。
- $`\mathbb C^2_{s,t}\times\mathbb C^2_{q,p}`$ 上で $`h\partial_s=\partial_s+\partial_q,\ h\partial_t=\partial_t+q\partial_p`$ とする。接続は完備だが曲率は $`\partial_p`$。辺の増分が $`a,b`$ の長方形ループは $`p`$ を $`ab`$ だけ平行移動する。平坦性を欠く完備性からホモトピー不変性は得られない。

**本目標が担う補助構成。**

- 沈め込み座標で水平分裂をグラフ場 f:E×F→(E→L[ℝ]F) と表示し、曲率0から既存の IsFrobeniusIntegrableAt 条件を証明する。滑らかな正則性で TauCeti.exists_frobenius_flat_coordinate を適用し、実際の OpenPartialHomeomorph とその逆を多様体へ移す。水平持上げの一意性によって積座標の整合性を証明し、有限個へのホモトピー分割と貼合せを行う。正則圏では 0.3 の正則解族を用いる。実滑らかな定理を指定された入力とし、その非線形な大域比較と整合写像は本目標で証明する。

*必要な先行結果：* 内部依存：0.1, 0.2, 0.3; [Covering spaces and universal covers](#dependency-covers) (Stage 0.2–0.4; Stage 1.5; Stage 2.6–2.8); [Smooth bundle and connection foundations](#dependency-smooth) (B1.5; B5.0; B5.2); [Native real Frobenius product coordinates](#dependency-frobenius) (TauCeti.exists_frobenius_flat_coordinate).

**出典と適用範囲.** 一般の平坦接続と被覆理論である。IIS06 の幾何学的モノドロミーおよび BOA01 の symplectic 等モノドロミーの設定は下流の応用であり、target:0.6 の仮定なしに symplectic 性は従わない。

<a id="target-0-6"></a>
### 0.6 symplectic 保存性と閉じた全空間二形式

**一般理論。**

滑らかな実または正則な沈め込みについて $`V=\ker d\pi`$ と置き、$`h`$ を同じ正則性の分裂とする。$`\omega`$ は $`V`$ 上の相対二形式で、各ファイバー上で閉かつ非退化であるとする。$`\omega`$ を供給する側がこれらの性質を証明する。$`v^V=v-h(d\pi v)`$ と置き、実際の全空間二形式 $`\Omega(v,w)=\omega(v^V,w^V)`$ を構成し、$`\ker\Omega=\mathop{\mathrm{im}}\nolimits h`$ を証明する。

基底ベクトル場 $`X`$ と垂直ベクトル場 $`U,V`$ に対し

```math
(D^h_X\omega)(U,V)=hX\bigl(\omega(U,V)\bigr)-\omega([hX,U],V)-\omega(U,[hX,V])
```

と定義する。$`d\Omega`$ の全成分を計算する。三つの垂直ベクトルでは $`d_V\omega`$、$`(hX,U,V)`$ では $`D^h_X\omega(U,V)`$、$`(hX,hY,U)`$ では $`-\omega(K_h(X,Y),U)`$、三つの水平ベクトルでは零である。垂直非退化性を用いて

```math
d\Omega=0 \quad\Longleftrightarrow\quad K_h=0\ \text{かつ}\ D^h\omega=0
```

を証明する。さらに、局所的に定義された平行移動が相対形式を保存することと $`D^h\omega=0`$ が同値であることを別途証明する。平坦性と保存性は異なる条件である。水平保存性に加えて平坦性と完備性もあれば target:0.5 と合わせて symplectic な大域 transport を得るが、局所判定に完備性は不要である。

水平保存条件 $`D^h\omega=0`$ を証明した上で、時間基底が一次元の場合に限り、局所 symplectic 自明化と相方向の必要な局所完全性の下で、$`\iota_{X_H}\omega=d_{\rm phase}H`$ により $`h\partial_t=\partial_t+X_H`$ の Hamiltonian ポテンシャルを得る。Darboux 座標では内在的全空間形式が $`\Omega=\sum_i dq_i\wedge dp_i+dH\wedge dt`$ と表示される。連結な相座標上の $`H`$ の時間だけに依存する不定性と、時間依存 symplectic 座標変換則を、実際の全空間形式の比較から証明する。多時間では水平二成分の別の解析が必要であり、この一時間の式をそのまま流用しない。

**仮定.**

- 滑らかな実または正則な沈め込みと、同じ正則性の分裂。
- 各ファイバーで閉かつ垂直方向に非退化と証明された相対二形式。全空間形式の閉性を別途証明した場合に限り、判定定理から平坦性と水平保存性を得る。
- Hamiltonian 座標補題では、水平保存性、一次元時間座標、局所 symplectic 自明化、得られた閉じた相方向一形式の局所完全性。

**API.**

- 垂直射影から全空間形式を構成し、核の恒等式と自然性を証明する。
- 各成分公式と、ファイバー上の仮定の下で $`d\Omega=0\iff(K_h=0\ \text{かつ}\ D^h\omega=0)`$ を証明する。
- 無限小水平保存性と、すべての局所平行移動写像が symplectic であることの同値を証明する。
- 内在的全空間形式から、一時間 Hamiltonian 表示、時間だけの不定性、時間依存座標変換則を導く。

**チェック.**

- $`\mathbb C_t\times\mathbb C^2_{q,p}`$ 上で積平坦分裂と $`\omega=e^t\,dq\wedge dp`$ を取る。対応する $`\Omega`$ は $`d\Omega=e^t\,dt\wedge dq\wedge dp\ne0`$ を満たす。平坦性だけでは symplectic 保存性も全空間閉性も従わない。
- $`H=p^2/2`$ の場合、$`\partial_t+p\partial_q`$ と $`dq\wedge dp+p\,dp\wedge dt`$ の内部積は零となり、Hamiltonian 表示の符号が確認できる。
- $`H`$ と $`H+t^2`$ は $`d(t^2)\wedge dt=0`$ により同じ全空間二形式を与える。
- 正次元のファイバーでは相対零形式は閉だが垂直方向に退化している。その全空間拡張の核は接空間全体なので、核と曲率に関する結論には非退化性が必要である。零次元の垂直接空間では零形式は非退化である。

*必要な先行結果：* 内部依存：0.1, 0.2; [Complex manifolds, holomorphic bundles and observations](#dependency-complex) (K1; K3.0; K3.HolomorphicStalk; K3.MeromorphicGermField; K4; K7.1).

**出典と適用範囲.** 一般的なテンソル・微分形式の証明である。I23 Definition 11.4 と Corollary 11.8、BOA01 §7 は特殊な幾何学的構成と比較を与えるが、平坦性だけで任意の相対形式を保存するという定理ではない。

<a id="target-0-7"></a>
### 0.7 許容観測量と曲線上の有理型評価

**一般理論。**

$`S`$ を連結な一次元複素多様体、$`s:S\to M`$ を正則写像とする。許容観測データを、$`s(S)`$ の近傍上の実際の正則 $`\mathbb P^1`$ 値写像、または $`s`$ に沿う評価が well-defined な正則 $`\mathbb P^1`$ 値延長を持つと証明された有理型・有理的表示データとして定義する。これは標識付き観測であり、定義域と比較写像を保持する。

次の基本的な許容の場合には、その延長を構成する。局所的な分子・分母表示を $`s`$ に沿って制限すると、少なくとも一方が恒等的に零ではない正則関数対になるとする。曲線の各点で共通の零点位数を除き、得られる局所 $`\mathbb P^1`$ 写像が重なりで一致することを証明する。別の方法として、解消 $`\widehat M\to M`$、正則観測 $`\widehat Q:\widehat M\to\mathbb P^1`$、正則持上げ $`\widehat s`$ が与えられれば、評価は $`\widehat Q\widehat s`$ である。選択に依存しないことは稠密な定義域上の比較で証明するか、持上げ自体を観測の標識に残す。特に曲線全体が不定点集合に含まれる場合、何らかの持上げが存在するだけでは有理的観測に標準的な値を与えない。

評価写像が恒等的に $`\infty`$ でなければ、$`S`$ 上の有理型関数を定めることを証明する。値が $`\infty`$ となる点では逆数が正則関数の芽であり、その零点は有限位数を持つ。一致の定理により無限位数は除かれる。したがって極は孤立し有限位数である。この定式化では曲線の仮定が本質的であり、高次元基底では極因子や不定点が現れるため、孤立極の定理とはならない。

局所結論を target:0.3 の水平芽に適用し、別途与えられれば target:0.5 の普遍被覆上の水平切断にも適用する。普遍被覆または連結な正規被覆上では、スカラー観測が降下することと、評価された関数がすべての deck 変換で不変であることの同値を証明する。幾何学的初期点が全モノドロミーで固定されることは十分条件だが、スカラー降下の必要条件ではない。実際の整合する観測写像・基底変換・解消間比較について、明示した定義域での自然性を証明する。

**仮定.**

- 連結な複素曲線 S、複素相多様体への正則写像 s、その像上の許容標識付き観測データ。
- 局所商からの構成では、制限した分子と分母の少なくとも一方が恒等的に零ではないこと。重なりの比較は整合性を証明すべき表示データに含める。
- 解消による評価では、実際の正則持上げと観測を与え、独立性を証明するか持上げを標識に残す。
- 通常の有理型関数とするには、評価が恒等的に無限遠でないこと。deck 不変性によるスカラー降下では、指定した普遍被覆（または連結な正規被覆）とその実際の deck 作用。

**API.**

- 実際の写像、一変数の局所商の約分、または指定した解消上の持上げにより許容評価を構成し、主張した比較独立性を証明する。
- 複素曲線上で恒等的に無限遠ではない許容評価について、極が孤立し有限位数であることを証明する。
- 普遍被覆または連結な正規被覆上で、観測関数の降下と deck 不変性の同値を証明し、幾何学的切断全体の降下と区別する。

**チェック.**

- 定値 $`\mathbb P^1`$ 写像 $`Q\equiv\infty`$ は写像として許すが、通常の有理型関数という結論からは除く。
- $`\mathbb C^2`$ 上の有理的観測 $`Q=[x:y]`$ と定値曲線 $`s\equiv(0,0)`$ では、制限した両座標が恒等的に零となる。blowup への方向の異なる持上げは異なる値を与えるので、標識なしのスカラー値は定まらない。
- 穿孔円板上の $`1/t`$ は原点で逆数 $`t`$ を持つ $`\mathbb P^1`$ 写像に延長し、一位の極を一つ持つ。
- $`\mathbb C^\times`$ 上の符号モノドロミー例 $`q'=q/(2t),\ p'=-p/(2t)`$ では、非零初期値の幾何学的切断が降下しなくても観測 $`q^2`$ は降下する。初期点の固定性だけではスカラー降下を特徴づけられない。

- 連結な三枚被覆 p(z)=z³−3z：ℂ\{−2,−1,1,2}→ℂ\{−2,2} は非正規で、モノドロミーは S₃、deck 群は自明である。f(z)=z は deck 不変だが、0 のファイバー上で一定ではなく降下しない。任意の非正規被覆での deck 不変性では足りない。

**本目標が担う補助構成。**

- P¹値の評価と恒等的無限大を除く証人には、既存のRiemann面の有理型関数の対象を用いる。許容された相空間観測との比較、引戻し、位数関数を構成する。降下には被覆の同値関係を用い、普遍被覆または連結正規被覆ではcoversの被覆変換作用と比較する。評価定理の前提に非線形接続の完備性を加えない。

*必要な先行結果：* 内部依存：0.1; [Complex manifolds, holomorphic bundles and observations](#dependency-complex) (K1; K3.0; K3.HolomorphicStalk; K3.MeromorphicGermField; K4; K7.1); [Covering spaces and universal covers](#dependency-covers) (Stage 0.2–0.4; Stage 1.5; Stage 2.6–2.8); [Native meromorphic functions on Riemann surfaces](#dependency-curve-functions) (TauCeti.RiemannSurface.MeromorphicFunction; Nonconstant curve pullback and order comparison).

**出典と適用範囲.** 一般の複素曲線上の評価と降下である。IIS06 の幾何学的解の定義や VDPS09 のスカラー座標は応用の動機になるが、任意の有理的観測が自動的に許容であるとはしない。

<a id="target-0-8"></a>
### 0.8 一階ジェットと二階方程式

**一般理論。**

$`B`$ を複素時間曲線、$`\rho:E\to B`$ を相対次元一の正則な沈め込み、$`(M\to B,h)`$ を正則非線形接続とする。一階 jet 束 $`J^1(E/B)`$ を内在的に構成する。$`e\in E_b`$ の上のファイバーは、$`d\rho_e`$ の複素線型分裂 $`j:T_bB\to T_eE`$ のアフィン空間である。正則な遷移写像を構成し、これらの分裂が $`E\to B`$ の局所正則切断の一階 jet と対応することを証明する。

$`B`$ 上の観測 $`Q:M\to E`$ は

```math
J_Q(x)=\bigl(Q(x),dQ_x\circ h_x\bigr)\in J^1(E/B)
```

を定める。明示した開集合 $`U\subset M`$ 上で、$`J_Q:U\to V`$ が開集合 $`V\subset J^1(E/B)`$ への双正則写像であると仮定し、その仮定を検証する。分裂を $`V`$ に移し、接触条件を証明する。すなわち水平曲線に沿って jet 座標が観測切断の微分に一致する。これにより対応する二階力学を構成する。$`U`$ 内の水平切断の芽と、一階 jet が $`V`$ 内にありこの力学を満たす観測切断の芽との全単射を証明する。逆対応には $`J_Q`$ の実際の逆写像を用い、次元計算や形式的消去だけで代用しない。

下流の座標補題として $`U`$ 上に $`(t,q,p)`$ を選び、$`h\partial_t=\partial_t+A(t,q,p)\partial_q+B(t,q,p)\partial_p`$ と書く。jet 写像 $`(t,q,p)\mapsto(t,q,A(t,q,p))`$ が指定した逆 $`p=P(t,q,v)`$ を持つとする。このとき内在的二階力学は

```math
q''=\bigl(A_t+A A_q+B A_p\bigr)\bigl(t,q,P(t,q,q')\bigr)
```

と表示される。実際の接続同型・観測束同型、および非臨界な時間変換について自然性を証明する。任意の分岐基底変換でも target:0.1 の引戻し接続は定まるが、jet 同型の仮定まで保存するとは限らない。symplectic 構造、完備性、有理型解析接続性、名前の付いたスカラー方程式は仮定しない。

**仮定.**

- 複素曲線上の正則非線形接続、相対次元一の正則観測束 E→B、B 上の実際の観測 Q。
- 構成した一階 jet 写像が jet 束の開部分への双正則写像であると証明された、明示的な開定義域。
- 座標公式では、表示した座標と実際の逆 P。時間変換後のスカラー座標の自然性では、時間変換の微分が零でないこと。

**API.**

- アフィン一階 jet 束、正則遷移写像、切断の jet との同一視、内在的観測 jet 写像を構成する。
- 証明済みの jet 同型を通して接続を移し、接触条件と、実際の逆写像を持つ局所解の芽の対応を証明する。
- 連鎖律から二階スカラー表示を導き、明示した非臨界な座標定義域で自然性を証明する。

**チェック.**

- $`A=p`$ のとき jet の逆は $`p=q'`$ であり、二階方程式は $`q''=B(t,q,q')`$ である。
- $`A`$ が $`p`$ に依存しなければ jet 写像は運動量変数を失い、二次元相座標の開集合上の逆を持たない。
- $`A=p^2`$ では $`p=0`$ を除いて別々の局所逆枝を持つが、自動的な大域逆はない。$`p=0`$ では微分の階数が落ちる。
- スカラー表示の分母を払っても、観測や jet の逆が未定義である相座標内に新しい解は生まれない。元の定義域を保持する。
- $`\tau=t^2`$ の $`t=0`$ では時間微分が零となる。引戻し接続は定義できるが、スカラー jet の非臨界時間変換による比較は適用できない。

*必要な先行結果：* 内部依存：0.1; [Complex manifolds, holomorphic bundles and observations](#dependency-complex) (K1; K3.0; K3.HolomorphicStalk; K3.MeromorphicGermField; K4; K7.1); [Smooth differential calculus and flows](#dependency-differential) (Layers 0–1; 3.1–3.5).

**出典と適用範囲.** 一般的な一階 jet の構成と連鎖律の証明である。VDPS09 §4.1 とその古典系の表示は座標補題の下流の例であり、仮定やスカラー化した力学の定義ではない。

<a id="target-0-9"></a>
### 0.9 有限個の共通座標における解の収束と no-exit 論法

**一般理論。**

$`I=[a,b]`$ をコンパクト区間、$`M`$ を固定した有限次元滑らかな多様体とし、距離パラメータ空間の $`0`$ 付近の $`\varepsilon`$ に対して、$`F_\varepsilon(t,\cdot)`$ を共通定義域上の実際の時間依存接ベクトル場とする。場は時間について連続、相変数について局所一様 Lipschitz とする。相空間自体が変化する応用では、まず実際の共通同一視を構成し、移した場についてこれらの仮定を検証しなければならない。$`x_0:I\to M`$ は $`F_0`$ の既に存在する解とする。

有限分割 $`a=a_0<\cdots<a_N=b`$ と共通相座標を仮定し、各座標で、固定した $`r_j>0`$ に対する閉管状領域 $`\{(t,y):t\in I_j,\ \|y-x_{0,j}(t)\|\le r_j\}`$ が、より大きい共通の時間・相変数定義域にコンパクトに含まれるとする。基準グラフは管状領域の側面境界から明示的な正の余裕 $`r_j`$ を持つ。座標変換とその微分を制御するコンパクトな重なり近傍も選ぶ。各固定管状領域上で $`F_\varepsilon\to F_0`$ が一様であり、相変数 Lipschitz 定数 $`L_j`$ が十分小さい $`\varepsilon`$ に依存せず取れるとする。同じ同一視で対応させた初期点 $`x_\varepsilon(a)`$ は $`x_0(a)`$ に収束するとする。$`I`$ 全体での近似解の存在、管状領域内への閉込め、一様収束は結論であり仮定ではない。

target:0.2 で局所近似解を構成する。第 $`j`$ 管状領域からの最初の脱出が起こるまで、Grönwall 評価

```math
\sup_{t\in I_j}\|x_\varepsilon(t)-x_0(t)\|
\leq \bigl(\|x_\varepsilon(a_j)-x_0(a_j)\|+\ell_j\delta_{\varepsilon,j}\bigr)e^{L_j\ell_j},
\qquad
\ell_j=a_{j+1}-a_j,\quad
\delta_{\varepsilon,j}=\sup_{\text{tube}_j}\|F_\varepsilon-F_0\|
```

を証明する。最初は共通の脱出前区間で上限を取り、脱出を除外した後に $`I_j`$ 全体の評価とする。この上界が指定した余裕より小さくなるよう $`\varepsilon`$ を取ると、最初の脱出は不可能であり、コンパクト延長により区間全体の解を得る。制御した重なり座標を通して終点誤差を移し、有限個の区間について帰納する。これにより、基準グラフのコンパクト近傍上の任意の適合する距離について、$`I`$ 上の一様収束を得る。任意の座標変換を越えて同じ一つの Lipschitz 定数を使えるとは主張しない。

水平持上げでは、引き戻した場に $`\gamma'(t)`$ が入る。$`C^1`$ 基底経路から得るのは連続時間 ODE であり、target:0.2 を用いる。より大きい共通複素近傍上で一様に有界な正則相ベクトル場なら、Cauchy 評価により縮小した管状領域上の一様相 Lipschitz 定数を得る。係数の収束だけでは、共通定義域、no-exit の余裕、対応する初期値の代わりにはならない。経路族やコンパクト時間領域全体での一様性には、経路と座標に関する追加の一様制御が必要である。固定コンパクト経路での収束は、非有界半直線や除外した特異端点を通る収束を主張しない。

**仮定.**

- 固定した有限次元多様体、または応用側が検証した共通同一視と、共通定義域上で時間について連続・相変数について局所 Lipschitz な接ベクトル場。
- コンパクト区間上に存在する基準解、有限個の共通座標による分割、共通の時間・相変数定義域にコンパクトに含まれる固定半径 r_j>0 の閉管状領域、制御されたコンパクトな重なり近傍。
- これらの管状領域上の場の一様収束と、十分小さいパラメータに一様な相変数 Lipschitz 定数。
- 基準初期点に収束する、対応を付けた初期値。大域近似解や no-exit の結論をあらかじめ仮定しない。

**API.**

- 区間長、場の誤差、入ってくる初期誤差を明示し、脱出前の区間ごとの Grönwall 評価を証明する。
- 正の余裕により最初の脱出を除外し、コンパクト延長で各解を区間全体へ延ばし、有限個の制御された座標変換を通じて誤差を移す。
- コンパクト区間全体での存在と一様収束を導く。経路族や時間領域全体を量化する前に必要な追加の一様制御を明示する。

**チェック.**

- $`I=[0,2],\ F_n=1/(n+1),\ F_0=0`$、共通初期値 $`0`$ とする。このとき $`x_n(t)=t/(n+1)`$ で、$`\sup_I|x_n-x_0|=2/(n+1)`$ となり、評価と一致する。
- 場がすべて零でも、初期値 $`x_n(0)=(-1)^n`$ は収束しない。係数の収束だけでは解の収束を導けない。
- 一つの座標上の係数収束では、その座標から出た後の軌道を制御できない。共通の管状領域と正の no-exit の余裕は省略できない。
- $`x_n(t)=t/(n+1)`$ は各固定コンパクト区間上で一様収束するが、$`t\in[0,\infty)`$ 上では一様収束しない。コンパクト経路の結論は非有界半直線の主張を含まない。

*必要な先行結果：* 内部依存：0.2; [Smooth differential calculus and flows](#dependency-differential) (Layers 0–1; 3.1–3.5); [Complex manifolds, holomorphic bundles and observations](#dependency-complex) (K1; K3.0; K3.HolomorphicStalk; K3.MeromorphicGermField; K4; K7.1).

**出典と適用範囲.** 有限個の座標と明示的 no-exit 論法を持つ一般有限次元連続依存定理である。幾何学的退化の側が共通同一視を独立に構成し、各仮定を検証する。係数の極限だけでその構成を代用しない。

### 出典と範囲

一般的主張の証明義務は上記の各目標に置く。次の一次資料は重要な下流の幾何学的設定を示すものであり、そこでの特殊な適用範囲を暗黙に拡張しない。

- **IIS06:** Inaba・Iwasaki・Saito, [Dynamics of the Sixth Painlevé Equation](https://arxiv.org/abs/math/0501007v2)。Definitions 2.1–2.2 と Lemma 2.12 は非線形接続と解析接続、その後の節は特定の幾何学的応用を扱う。
- **I23:** Inaba, [Moduli Space of Factorized Ramified Connections and Generalized Isomonodromic Deformation](https://sigma-journal.com/2023/013/)。Definition 11.4 と Corollary 11.8 は、明記されたモジュライ設定で構成した全空間形式を扱う。
- **BOA01:** Boalch, [Symplectic Manifolds and Isomonodromic Deformations](https://arxiv.org/abs/2002.00052v1)。§7 はその仮定の下で等モノドロミー symplectic 幾何を扱う。
- **VDPS09:** van der Put・Saito, [Moduli spaces for linear differential equations and the Painlevé equations](https://arxiv.org/abs/0902.1702v5)。§4.1 は一階系の表示と下流のスカラー比較に関係する。本モジュールは表示係数を内在的定義として輸入しない。

<a id="layer-1"></a>

## レイヤー1：付加構造付き有理型接続のモジュライ

<a id="connection-moduli"></a>

### 定理と構成

付加構造付き有理型接続のデータから、モジュライ族と、そこに**実際に構成する**平坦・シンプレクティックな非線形時間接続を得る。利用側は適用条件を示し、一つの構成定理 §2.4 を用いる。種数0、階数2、構造的極次数4、時間1変数、名前の付いたスカラー方程式、分類済みの曲面は一般仮定に含めない。

| 利用側が与える入力 | この枠組みが構成する出力 |
| --- | --- |
| 許容曲線・極因子・局所付加構造 | 許されるすべての束型上のスタックと剛化された安定モジュライ |
| 実際に許容される時間族と重みの部屋 | 実際の水平分裂・平坦性・引戻し比較 |
| 行列式の扱いとその検証条件 | 正確な行列式ファイバー比較と次元定理 |
| 基底全体を主張する場合の非空性の証人 | その基底上で全射となる正則非線形接続の基礎対象 |
| スカラー方程式・Hamilton 関数は不要 | 相対シンプレクティック形式・その保存・閉全形式 |

局所的な範囲は §1.1 に明記する対数完全旗条件、一般的不分岐不確定条件、一般的な全分岐の因子分解条件に限る。新しい特異点の種類には、この出力を使う前に適用可能性・構成の定理を要する。対数的な共鳴は旗と格子によって保持する。非空性、大域的な行列式固定輸送、正種数での行列式固定の滑らかさはそれぞれ独立に検証する。

### 依存関係

幾何学的構成は `0.1`（基礎対象・射・引戻し）と `0.6`（一般的な微分形式計算）を用いる。2.5–2.6 の仮定を課した対数的分枝では、局所水平切断のために `0.3` も用いる。これらが幾何学的な水平分裂やそのトレース形式の保存を与えるわけではなく、§§2.1–2.2 がこの構成について証明する。基礎入力は構造化計画に列挙した曲線・束、スタック・モジュライ、連接層コホモロジー、形式局所代数、複素幾何の標準インターフェースである。特殊な利用側を上流の前提にしない。

文献の公式を超えて本稿が担う主な課題は、内在的な表示亜群、検証済みの行列式輸送、分岐関係式も含むトレース零・トレース比較、先行する有限平坦展開変形、整合する比較写像である。特に、スカラー安定化群を除くことと、2g 次元の行列式変形空間を除くことは異なる。

### 適用条件

利用側は局所模型と一般性の開条件を示し、実際の時間族と標識を指定し、行列式を固定しないか、固定行列式とその階数1時間輸送を検証する。有効な安定性の部屋を選び、全射な族を主張する範囲で非空性の証人を与えた上で §2.4 を適用する。完備性、固有 Riemann–Hilbert 比較、スカラー観測量、特別な解、分類結果は利用側に残る追加課題である。

ℙ¹ 上の階数2・5対数極の問題は再利用を具体的に検証する例である。適合する固定行列式の下で非空なら、構成は2次元の配置基底上に4次元の相空間を与える。相対次元2を超えた数学的範囲を確かめる例であり、明示的な存在証明書は独立した利用側に置く。2.5–2.6 の追加仮定付き定理は、I13 の正確な範囲で固有な対数的 Riemann–Hilbert 半共役も供給する。利用側は続いて NonlinearConnections §0.4 の共通延長定理を適用でき、5極専用のコンパクト性定理を要しない。

<a id="target-1-1"></a>
### 1.1 許容される付加構造付き接続データ

**一般理論。**

複素基底上の亜群の族を定義する。その対象は、滑らかで固有な連結曲線の族、空でない順序付きの相異なる標識切断、構造的極因子 P = Σ mᵢaᵢ、整数の階数 r ≥ 1 と次数 d、および以下の局所データである。局所トレース極データを指定して行列式を固定しない問題と、適合する指定線束接続 (L,∇L) 上のファイバーである行列式固定問題の両方を構成する。後者では同型 det(E,∇) ≅ (L,∇L) も対象に含める。接続は曲線全体上の局所自由層、相対有理型接続、および付加構造からなり、自明束チャート上の行列だけではない。射は実際に構造を保つ束同型である。

最初に許容する範囲は I23 §§2–5 の局所模型に限定する。すなわち、m=1 で完全旗と次数付き留数を指定する対数極（共鳴・重複留数を含む）、m≥2 で ma 上の完全フィルトレーションと相異なる先頭固有値を持つ一般的不分岐極、および r≥2、m≥2、wʳ=z を満たす全分岐の一般的模型である。最後の模型は ν(w)=Σₖ₌₀ʳ⁻¹νₖ(z)wᵏ、ν₀=Σⱼ₌₀ᵐ⁻¹a₀ⱼzʲdz/zᵐ、k≥1 に対して νₖ=Σⱼ₌₀ᵐ⁻²aₖⱼzʲdz/zᵐ、a₁₀ 可逆という条件を持つ。この模型に対し、有限段階の因子分解型分岐構造、その関係式、形式模型との同値を構成する。根と形式座標は降下の射を備えた表示である。混合ブロック、任意の傾き、先頭固有値の衝突、a₁₀ の消滅には許容範囲を拡張する別の定理が必要となる。

用いる重みの部屋では安定性と半安定性が一致するよう有理重みを選び、安定性は ∇ 不変な真部分束で判定する。整合性同型を伴う Cartesian 引戻しを構成する。この範囲は再利用可能な理論のために文献で支えられる初期範囲であり、古典的スカラー方程式のリストではない。

**入力条件**

- 複素数体上の滑らかで固有な連結曲線族、r≥1、d∈ℤ、空でない相異なる標識切断と構造的重複度、明記した三種類の局所模型、重みの部屋。
- 行列式固定の場合には、トレース極データおよび留数・次数関係と適合する線束接続と行列式同一視も与える。

**構成・法則（API）**

- 制限、引戻し、射の合成と逆射を構成し、結合子と単位の法則を与える。
- 台となる形式的微分加群、階数 r² − 1 の End⁰(E) 上の誘導接続、および付随する PGLᵣ 接続を同定する。後二者が不変な随伴・射影的出力である。局所行列 A − tr(A)I/r はフレーム内で射影接続を表すが、E 上に標準的に貼り合わされた階数 r の微分加群ではない。行列式線束の平方根は選ばない。
- 放物旗と対数格子を保持し、分岐降下によって同値な局所表示を比較する。
- 行列式との両立性を線束上の接続の同型として表し、選択した局所規約の下で留数・次数の等式を導く。

**検証事項**

- E = O ⊕ O(−1) の行列式の次数は奇数であり、大域的な行列式の半分による捻りは存在しない。指定された行列式がこれに一致するときにも、この束を対象として許さなければならない。
- 同じ重複固有値をもつ二つの対数留数について、一方がスカラーで他方が非零 Jordan ブロックである場合、固有値を指定しても両者は同一視されない。許容される放物的対象とモノドロミーは異なる。
- 階数 2 の分岐チャートで根 w を −w に変えると、表示された枝は変わるが、降下後の対象は同値である。降下の射を忘れる構成はこの検証に適合しない。
- I23 の分岐に関する規約では、階数 2 の分岐点は留数・次数の関係に 2c + 1/2 を寄与する。これを 2c に置き換えると、その関係が 1/2 だけ変わる。
- 傾き安定性または次元公式を適用する前に、階数 0 の入力を除く。r = 1 では随伴束 End⁰(E) の階数は 0 であるが、E 自身に課す正の階数という条件は変えない。
- A = 0 とフレーム変換 g = diag(z,1) に対して、g⁻¹dg = diag(1,0)dz/z である。そのトレースの半分を引くと diag(1/2,−1/2)dz/z になる。このスカラーのずれにより、トレースを引いた階数 2 の接続は E 上に貼り合わさらないが、誘導された End⁰(E) 接続と PGL₂ 接続は貼り合わさる。

**本目標が担う補助構成。**

- 既存の有限局所自由層を用い、相対有理型接続を基底線形な Leibniz 則を満たす一次微分作用素 E→E⊗Ω¹(P) として定義する。ゲージ亜群、テンソル・双対・行列式・End⁰、標識された相対 Cartier 因子での完備化、形式座標変換、分岐引戻しと降下を実際の層写像とコサイクル上で構成する。CKG K4 の供給は非特異な正則比較までとし、代数的対象の解析化比較は 1.2 が担う。大域的な階数 r のトレース除去や行列式の根を導入しない。

- ℂ((z)) 上の有限階数微分加群について、有限分岐 z=wᵉ の後の指数因子と確定特異加群への Levelt–Turrittin 分解を証明し、定数、分岐指数の細分、形式座標変換、被覆変換による降下を扱う。FormalLaurentPuiseux はスカラー演算に用いる。I23 の有限段階の因子化モデルと基底変換は、先頭係数の非消滅・相異性を課した基底上で別途証明する。各ファイバーの分解から衝突を含む相対分解を推論しない。3.4 は階数 2・構造次数 4 に特殊化し、収束するセクター上の実現と Stokes 分類は 4.1 が担う。

*必要な先行結果：* [Formal scalar and vector-valued Laurent algebra](#dependency-formal-series) (L1–L4; L5–L6 for finite-extension steps in 1.1); [Algebraic vector bundles and finite locally free sheaves](#dependency-bundles) (L0A–L0C; L1A–L1B; L2A–L2B); [Complex manifolds, holomorphic bundles and observations](#dependency-complex) (K1; K3.0; K3.HolomorphicStalk; K3.MeromorphicGermField; K4; K7.1); [Stacks, inertia and restricted coarse-space criteria](#dependency-stacks) (1.18–1.23).

**文献の範囲と担当証明：** I23 の Definitions 2.1, 2.2, 2.4, 2.7–2.8、Definition 3.1、Proposition 3.3、Corollaries 4.3–4.4、§5 が局所範囲を支える。座標から独立した包装と2-圏的な整合性を伴う降下は本稿が担う証明課題であり、I23 で既にその包装が証明されているとの主張ではない。

<a id="target-1-2"></a>
### 1.2 許容時間族と行列式の輸送

**一般理論。**

対数留数と形式留数指数を固定して、曲線、標識極、許容された不確定極係数の変形亜群を構成する。I23 §5 の標点付き曲線スタックの滑らかなアトラス、有限座標ジェット、係数の開条件から始める。曲線の粗モジュライに自己同型がないと仮定せず、座標変更の射と降下を構成する。B はこの時間問題の滑らかな複素チャート、標識被覆、または滑らかな複素基底からこの時間問題への任意の正則基底変換の源とする。写像自体が滑らかな射であることは要求しない。引き戻した族と分裂は、許容基底変換の比較によって構成する。B から除く係数判別式と衝突は入力で定まる。穿孔曲線族の位相的標識を局所的に構成して重なり上で比較し、任意の位相的変形を許容時間族とみなさない。

行列式を固定しない場合には行列式切断を選ばない。固定する場合には、指定行列式の強い階数1の輸送を証明付きで必要とする。これは誘導されたトレース極データと固定留数を持つ、適合する可積分な全線束接続である。標識付きの可縮な時間チャート上では、固定した階数1の局所系を延ばし、指定対数格子と極部分の原始関数を貼り合わせてこの輸送を構成する。初期行列式への制限、極の上限、コサイクル則を確認する。種数0の対数的な場合には dlog による明示的構成も行う。大域的な行列式固定の出力には、これらの局所輸送の実際の貼り合わせデータ、または同じ性質を検証した全線束接続を要する。留数条件を満たすだけの自由に変化する行列式接続族は受け付けない。この階数1の構成は本項目が担う準備定理であり、§2.1 の階数 r の水平分裂に依存させない。

外部指数パラメータと時間方向を分ける。強いモノドロミー保存性は、不確定型の許容変化の下で輸送された解析データを保つという意味になり、固定座標での不確定係数を凍結するという意味ではない。解析的 Stokes 分類は代数的構成の前提にしない。

**入力条件**

- §1.1 の付加構造と固定留数指数、上記の許容時間亜群から得られる曲線・極係数・標識の変形。
- 行列式を固定する場合は、本項目で構成するか、極・可積分性・初期値・貼り合わせ条件を検証して与えた階数1の輸送証明。

**構成・法則（API）**

- 許容時間基底 B に沿う接方向と外部の留数・指数パラメータ θ の変化を分け、引戻し接完全列を比較する。
- 標識の変更と局所時間の再パラメータ化を構成し、その整合性の法則を与える。
- 初期条件とは独立に、極の衝突および先頭項の消滅を表す判別集合を入力から同定する。
- 種数0の対数的 dlog 模型を含む局所的な階数1の行列式輸送を構成して検証し、大域的な行列式固定の出力に必要な貼り合わせデータを明記する。

**検証事項**

- ℙ¹ 上の順序付き対数極が5点なら、PGL₂ で商を取った時間の次元は 5 − 3 = 2 であり、その配置は初期条件によらない。
- τ = 2t という変換は、表示された水平生成元を 1/2 倍する。その係数を変えずに保持すると、異なるパラメータ付き系になる。
- 可動極集合が異なる二つの解も同じ Bθ を用いる。一つの解の極を削除した基底は、この要件を満たさない。
- 固定した正種数の曲線上で、非零の正則1形式 η を用いて線束接続を tη だけ変えると、一般には周期が変わり、階数1のモノドロミーも変わる。留数の固定だけでは強い行列式輸送を保証できない。

**本目標が担う補助構成。**

- 複素多重円板の連接イデアルによる商で局所表示される有限次元複素局所環付き空間の圏を、冪零元を保持して構成する。局所環射、開制限、連接閉部分空間、開貼合せ、積・ファイバー積の普遍性を証明する。局所解析には CKG K3 の正則芽と RealAnalyticGeometry R3.2 項目 0 を用いる。有限型分離複素スキームの解析化をアフィン埋込みと貼合せから構成し、表示独立性、関手性、開・閉埋込み、ファイバー積、連接層・有限局所自由層・微分・有理型接続と引戻しの比較を証明する。複素次元nが一定で、台となる位相空間がHausdorffかつ第二可算である滑らかな解析空間を、ℂⁿをモデルとする既存の複素多様体と同定する。成分ごとに次元が異なる滑らかな空間では、開かつ閉な各次元の部分空間ごとに比較する。非線形接続と有理型接続モジュライの構成で多様体として用いる各対象について、次元と位相的仮定を確認する。一般の解析空間では分離性を明記したまま保持し、滑らかさだけからHausdorff性や単一のモデル次元を推論しない。ComplexCurveModuli D2.0 は多様体の場合の比較として用いる。解析的固有性の基底変換と代数的固有写像の解析化比較を構成する。代数的構成は有限型 Noetherian 基底上で行い、任意の滑らかな複素基底からの正則引戻しはこの解析的比較を経由する。特異な Betti 標的も同じ対象を用いる。

- 安定標識曲線のアトラスは安定性の仮定を確認して用いる。種数 0 の一標識・二標識の場合は、実際の PGL₂ 安定化群を保持する商亜群、有限ジェットの torsor、係数の開条件と適合する滑らかなアトラスを構成する。これを安定曲線の粗モジュライのチャートとして扱わない。標識切断を保つ相対的な滑らかな自明化から穿孔族の局所位相標識を作り、重なりで比較する。行列式の階数 1 の移送は、階数 1 局所系・指定対数格子・極部分の原始関数・dlog から独立に構成し、2.1 および後続の階数 r の RH 写像を前提にしない。

- 冪零元を保持した有限型複素スキームについて SGA1 XII1.1–3.1 の解析化と連接層の比較を証明する。固有射 f:X→S と連接層 F に対し、q≥0 で (R^q f_*F)^an≅R^q f^an_*(F^an) を F に自然に構成し、仮定を明示した基底変換写像と両立することを証明する（XII4.2）。体 ℂ 上の固有 X では Coh(X)≃Coh(X^an) と連接コホモロジー比較を証明する（XII4.3–4.4）。射影的な場合は Serre no.12 定理1–3 を用いる証明を構成し、固有の場合は Chow と dévissage による拡張を証明する。有理型接続は Leibniz 作用素の O 線形な主部・ジェット表示を介して比較し、∇ 自体を O 線形な写像と見なさない。これにより RH 構成で使う代数的／正則な曲線・束の比較を得る。非固有の解析基底上の任意の解析的な族が大域的に代数化されるとは主張しない。

- 非空の相対標識因子をもつ滑らかな固有曲線族について、その因子が各幾何学的ファイバーで正の次数を持ち、相対的に豊富であることを証明する。Noetherian代数基底の局所で十分正の倍数を相対的非常に豊富に取り、Quot表示に使う射影的埋込みを構成し、共通の正の倍数を介して、選んだ冪と切断の基底を比較する。得られるモジュライ表示の比較は、その構成の後の1.3で証明する。射影性と有界構成に必要な偏極を明記した入力から得る。

*必要な先行結果：* 内部依存：1.1; [Marked-curve charts](#dependency-curves) (ComplexCurveModuli D0.3, D3–D5; SchemeAndStackFoundations 4.15); [Complex manifolds, holomorphic bundles and observations](#dependency-complex) (K1; K3.0; K3.HolomorphicStalk; K3.MeromorphicGermField; K4; K7.1); [Coherent analytic module sheaves](#dependency-analytic-coherence) (R3.2 item 0); [Cohomology, duality and curve degree](#dependency-cohomology) (2.2; 2.6; 2.20; 3.3); [Proper coherent direct images and base change](#dependency-proper-cohomology) (Layer C); [Chow lemma for the proper GAGA proof](#dependency-chow) (4.12, chow_lemma subtarget only; prerequisites 0.9 and 4.11).

**文献の範囲と担当証明：** I23 §5 の曲線・ジェット・係数の時間スキームと §§10–11 が供給元である。一般の行列式輸送および座標降下のインターフェースは追加の証明課題であり、すべての行列式族が持ち上がるという仮定に置き換えない。

<a id="target-1-3"></a>
### 1.3 すべての束型を含む安定モジュライ

**一般理論。**

§1.2 の許容時間問題上で §1.1 の安定対象のスタック、そのスカラー剛化、相対粗モジュライ空間を構成する。フィルトレーション付き束の有界パラメータ空間に、接続および因子分解構造の関係式を課す。普遍性、分離性、有限型性を証明し、文献で支えられる設定では準射影性も示す。許される束型はすべて含める。行列表示が覆うのはその実際の定義域に限る。普遍対象を持つエタール被覆を構成し、その後のテンソルを降下させる。粗モジュライ上の普遍ベクトル束は仮定しない。

行列式を固定しない安定対象のスカラー慣性群は Gm であり、行列式同一視を固定すると μr になる。行列式固定と剛化は異なる操作である。行列式写像と指定行列式を持つモジュライ問題との比較を構成し、滑らかさと相対次元の計算は §1.5 で行う。必要な粗空間の基底変換比較はこれらの局所ジェルブ表示を通じて証明する。非空性は利用側が別に示す主張であり、任意の数値入力に対する定理ではない。局所的に空なモジュライも保持する。B を非空ファイバーの開集合に制限した後に初めて、全射な解析的沈め込みとして出力する。

分離性と準射影性は、文献が支える設定における相対粗モジュライ（剛化後の相空間の族）について主張する。Gm 慣性をもつ剛化前の安定スタックについて分離性を主張しない。

**入力条件**

- §1.1 の数値・許容局所データ、§1.2 の時間族、固定した重みの部屋、すべての束型。構成自体には非空性を仮定しない。

**構成・法則（API）**

- 適切な射による同値を考慮して幾何学的点と族を同定し、粗モジュライ写像の普遍性を明示する。
- 行列式を固定したファイバーも含め、制限および許容される基底変換との比較を証明する。
- フレーム付きチャートを、実際に対応するモジュライ部分と比較する。ℙ¹ 上の固定分裂型の層は局所閉である。均衡型の部分は開であり、次数 0 では自明束の部分を含む。各包含と閉包の比較を証明し、使用するすべてのチャートの補集合を記録する。
- 重みを変えるときは実際の共通安定領域とその上の比較を同定し、自動的な大域同型を出力しない。

**検証事項**

- 安定対象にも、剛化前にはスカラー自己同型がありうる。すべての固定部分群が自明であったと主張する集合値の商は、この例に適合しない。
- 束の跳躍により、族が自明束のチャートから外れても、モジュライ空間内にはとどまりうる。この理由でその相軌道を特異としない。
- 拡大族 0 → O(−1) → E_t → O(1) → 0 では、E₀ = O(−1) ⊕ O(1) である一方、t ≠ 0 では E_t = O ⊕ O である。二つの分裂型の層の引戻しは A¹ 内の {0} とその補集合であり、前者は開ではない。接続モジュライ全体は、許容される接続の範囲でこのような束の跳躍を保持しなければならない。
- 許容された全分岐の一般的局所模型は形式的微分加群として既約なので、その局所模型を持つ大域接続には ∇ 不変な真部分束がなく、すべての重みで安定である（I23 Remark 2.9）。この主張を任意の分岐ブロックへ拡張しない。

**本目標が担う補助構成。**

- フィルター付き接続の有界性を証明した上で SSF4.14 から有限型のパラメータ空間を構成し、簡約フレーム群、線形化、選んだ有理放物重みに対する Hilbert–Mumford 条件との同値を指定する。必要な不変式の有限生成、安定な幾何学的商・アフィン圏論的商を証明し、I23 の範囲で実際のモジュライ普遍性・分離性・準射影性を得る。Isom 層の fppf 商とスタック化によって中心 Gm の rigidification を作り、その gerbe・基底変換の普遍性と GIT 粗モジュライとの比較を証明する。行列式同定を含む場合の μr 慣性は別に比較し、有限慣性の Keel–Mori を使う箇所を限定する。各テンソルのスカラー作用が自明であることと粗モジュライの基底変換をこの表示上で証明する。

- 有限型の代数的な曲線・時間チャートごとに、有界なフレーム付き Quot 表示の解析化が、1.2 で許容する滑らかな複素基底からの任意の正則基底変換後に、対応する解析的な族を表すことを証明する。十分正のねじりによる局所解析的生成、連接な解析的順像と基底変換、正則フレームと因子化接続の方程式、実際の関係の降下を構成する。これは 2.3 が必要とする解析的モジュライ比較であり、新たな基底の大域的代数化ではない。これらの表示写像を介して解析的商と構成済み GIT 商の解析化を同定する。実際の変形複体を用いるフレーム付き変形・versal 比較は、この GIT 構成の後の 1.4 で証明し、依存の循環を避ける。

- 1.2で構成した正の冪と射影的埋込みから得られる有界なQuot/GIT表示を比較する。まず両表示と実際の点の関手への写像を構成し、その後で証明したモジュライの普遍性から互いに逆の比較写像と、合成・基底変換の法則を得る。これにより、明記した曲線の安定性問題における補助的な偏極・フレームの選択からの独立性を証明する。

*必要な先行結果：* 内部依存：1.1, 1.2; [Quot/Hilbert and parameter schemes](#dependency-quot) (4.14); [Stacks, inertia and restricted coarse-space criteria](#dependency-stacks) (1.18–1.23); [Quotient predicates](#dependency-quotient-predicates) (1.17); [Elementary deformation theory](#dependency-deformation) (4.2–4.6).

**文献の範囲と担当証明：** I23 Theorem 5.1 と §§7–10。行列式固定と粗空間の基底変換比較は、表示されたモジュライ問題を拡張して本稿が構成する。

<a id="target-1-4"></a>
### 1.4 微分作用素による変形複体とトレースペアリング

**一般理論。**

局所構造を保つ無限小自己準同型、許容された接続の変化、因子分解型分岐構造の全関係式から変形複体を構成する。二項接続複体 G• から始め、分岐を伴う場合は F• = Cone(G• → S•ram[1])[−1] 全体を保持する。次数 0、1、2、両微分、および局所因子分解項を含める。二項複体への置換には擬同型の証明を要する。無限小自己同型、接ベクトル、障害類を超コホモロジーで同定し、トレース・Serre 双対ペアリングを構成する。

∇ との交換子は ℂ 線形の一階微分作用素であり、一般に O 線形ではない。ℂ ベクトル空間の層、基礎となる連接な各項、Čech 全複体、および実際の項別双対性計算で扱い、この微分を無言で D(QCoh) に置かない。鎖写像と擬同型で表示・被覆からの独立性を証明する。行列式変形複体へのトレース射とトレース零ファイバーを、符号および局所因子分解との両立性込みで構成する。本項目が比較写像を供給し、§1.5 で滑らかな行列式写像と次元の結論を証明する。スカラーゲージ自己同型と実際の無限小行列式変動は異なる方向である。

**入力条件**

- §1.3 の安定モジュライ問題と許容フィルトレーション・因子分解型分岐の関係式。行列式非固定の場合と指定ファイバーの両方を扱う。複体とペアリングは出力である。

**構成・法則（API）**

- 微分、局所的な両立条件、および無限小族からそのコサイクルへの写像を与える。
- ゲージ変換とコバウンダリーの対応を双方向に証明する。
- トレース零部分と行列式部分への分解、および符号を含めた双対複体を構成する。
- 入力の同型および許容される基底変換に関するペアリングの自然性を証明する。

**検証事項**

- u による無限小ゲージ変換は、接続の代表元を u の交換子微分だけ変える。その接空間での類は 0 である。
- 行列式同一視を固定しなければ安定対象のスカラー自己同型は1次元の無限小方向を持つ。標数0で同一視を固定するとその方向は消えるが、剛化するまで有限群 μr は残る。この操作だけで 2g 個の行列式変形方向を除いたことにはならない。
- ω = dq ∧ dp の下では、順序付き接ベクトル対 (∂q, ∂p) のペアリングは +1、逆順では −1 である。トレースの規約が逆の場合、移送公式を用いる前に補正しなければならない。

**本目標が担う補助構成。**

- 連接な基礎項と実際の ℂ 線形一次微分作用素をもつ複体を、ℂ ベクトル空間の層の Čech 全複体として構成し、細分・被覆独立性・錐の符号・トレース対・項別 Serre 双対との両立を証明する。O 線形でない微分を D(QCoh) の射にしない。分岐因子化の全関係を含む三項の錐について、実際の持上げコサイクルから自己同型・接空間・障害を同定する。ここで必要な有限次元平方零核への拡張、線形性、直和、基底変換を証明し、SSF4.5 の基本的小拡大だけから自動的に得たことにしない。

- 固有な複素曲線上の有界な変形複体について、各微分作用素を有限階の主部表示を介して解析化する。主部の解析化比較と合成との両立を証明し、解析化後の微分の二乗も零となることを示す。各項に固有な連接 GAGA を適用し、収束する超コホモロジーのスペクトル系列を比較して、実際の分岐局所錐を含む代数的／解析的な超コホモロジー比較を得る。これは Deligne II6.6 の証明経路に従う。複体は連接 O 加群を項にもつ複素ベクトル空間の層の複体であり、接続による微分を連接 O 加群の導来圏の O 線形写像として扱わない。相対的な基底変換の主張は別に証明し、使用する定理の平坦性とコホモロジーに関する仮定を保持する。

- 相対族 p:C→B では層の p⁻¹O_B 加群構造と接続微分の p⁻¹O_B 線形性を保持する。O_C 線形ではない。基底の加群作用を含めてČech全複体・トレース・主部比較・基底変換写像を構成し、整合性を証明する。絶対的なℂ線形コホモロジーは各ファイバーとの比較であり、相対構造の代用ではない。

- 実際の持上げ方程式と変形複体からフレーム付き微小変形とversalチャートを構成し、1.3でGITにより構成したモジュライの接空間・障害・持上げとの比較を証明する。この比較を先行するモジュライ構成の存在仮定にはしない。

*必要な先行結果：* 内部依存：1.3; [Cohomology, duality and curve degree](#dependency-cohomology) (2.2; 2.6; 2.20; 3.3); [Elementary deformation theory](#dependency-deformation) (4.2–4.6).

**文献の範囲と担当証明：** I23 §6、(6.9)、Proposition 6.3、§7 Proposition 7.2。行列式固定のファイバーと対応するトレース零複体は本稿が担う明示的比較である。

<a id="target-1-5"></a>
### 1.5 滑らかさ・次元・行列式ファイバー

**一般理論。**

§1.4 を用いて、許容範囲で安定モジュライ族の障害消滅と滑らかさを証明し、相対接束を第一超コホモロジーで同定する。行列式を固定しない非空の安定ファイバーについて dim M_b = 2r²(g−1)+2+r(r−1)deg P を導く。この公式では局所トレース極部分を固定している。

行列式固定の結果を供給するために、このトレース極部分を持つ線束接続のモジュライを構成する。各ファイバーでは Picᵈ(C_b) 上の階数 g のアフィン束となり、接複体は正則 de Rham 複体 O_C → Ω¹_C であることを証明する。ℂ 上で 1/r を用いて、分岐の関係式も含む変形複体全体のトレース射とスカラー切断を構成する。指定安定領域で行列式写像が滑らかであり、接写像が 2g 次元の行列式接空間へ全射であることを証明する。ジェルブの比較後に指定行列式の粗モジュライ族を対応するファイバーと同定する。その後に初めて dim M_b^det = 2(r²−1)(g−1)+r(r−1)deg P を導く。トレースペアリングがトレース零方向とスカラー方向に直交分解し、行列式固定接空間上でも非退化であることを証明する。階数1で行列式を固定したファイバーは0次元である。

行列式を固定した次元・シンプレクティック性の定理には、1.5で構成する変形関手の比較、滑らかな行列式写像、直交するトレース分解を用いる。行列式ファイバーへ制限する前に、明記した複体全体についてこれらの比較を証明する。行列式非固定の定理と種数0での次元の一致は、上記の範囲で成り立つ。

**入力条件**

- §1.3 のモジュライ構成と §1.4 の実際の複体・トレースペアリング、ℂ 上で許容された局所模型。
- 次元の主張は非空の安定ファイバーについて述べる。行列式固定の結論には、本項目で証明する行列式写像の比較をさらに要する。

**構成・法則（API）**

- 相対接層を同定し、接空間と障害の計算に関する基底変換との両立性を証明する。
- 局所両立条件をすべて含めて、行列式変形写像、スカラー切断、トレース零ファイバーを構成する。
- 2g 個の行列式方向を引く前に、滑らかさとトレースの直交分解を証明する。
- 正確な仮定を伴う行列式非固定・固定の次元定理を別々に供給する。

**検証事項**

- 種数 0、階数 2、次数 4 では −8 + 2 + 8 = 2 となり、構造的次数を 5 に変えると 4 になる。
- 正の種数で行列式を固定すると、行列式写像との比較を適用できる場合には 2g 個の方向が除かれる。種数 0 での一致をそのまま一般の場合に持ち出さない。
- r = 1、g = 1 では、行列式を固定しない公式は 2 を与え、線束上の接続全体を固定すると 0 になる。誤って 2 を与えてしまう階数 0 の入力は、定義域の外にある。
- g=1、r=2、deg P=1 では、対応する安定ファイバーが非空で比較が成り立つとき、非固定の公式は4、固定の公式は2を与える。スカラー安定化群だけを除く操作ではこの差を説明できない。

**本目標が担う補助構成。**

- 局所 Noetherian 基底上の射影的・平坦・有限表示の複素曲線族について、任意の基底変換後の O_B≅p_*O_C を仮定して fppf 相対 Picard 代数空間を構成する。連接コホモロジーの基底変換と、以下に明記するaffineな平方零試験と相対コホモロジー次元によって相対的滑らかさを得る線束変形の証明を含める。単位成分・次元一定性の仮定を明示し、曲線や基底の非被約試験も保持する。JacobianChallenge C–D は連接コホモロジーと体上の幾何学的整な特殊例に限って用いる。滑らかな標識曲線では相対 Picᵈ と rigidify した Poincaré 束、適合するトレース極部分を固定した線接続のアフィン torsor を構成し、正則 de Rham 接複体・次元 2g・トレースとスカラーの分解・行列式写像の滑らかさを証明する。非被約曲線の Picard 定理はパンルヴェ固有の結果を前提にせず 5.1 に供給する。

- 形式的滑らかさは、準連接イデアル I を持つ affine な平方零肥厚 T₀↪T に局所化して検証する。平坦性により C_T 内の C_T0 のイデアルを p*I と同定する。H²(C_T0,p*I) に値を取る障害、制限同型を指定した持上げの同型類に対する H¹(C_T0,p*I) の torsor、および H⁰ から得る微小自己同型を構成する。固有かつ相対次元が高々1であることから q>1 で R^q p_*(p*I)=0 を証明し、基底の affine 性と Leray により H²=0 を得る。一般の試験基底は開被覆または fppf 降下で扱い、局所有限表示の判定から滑らかさを導く。非 affine 基底上の絶対 H² 消滅をファイバー次元だけから推論しない。 PICREL tags 0D2C・0DNI・0DPJ・0DPKを用いる。

*必要な先行結果：* 内部依存：1.3, 1.4; [Cohomology, duality and curve degree](#dependency-cohomology) (2.2; 2.6; 2.20; 3.3); [Elementary deformation theory](#dependency-deformation) (4.2–4.6); [Picard over a field and Picard foundations](#dependency-field-picard) (JacobianChallenge Layer D; SchemeAndStackFoundations 1.1, 2.6, 3.4, 4.6, 4.14); [Proper coherent direct images and base change](#dependency-proper-cohomology) (Layer C).

**文献の範囲と担当証明：** I23 Theorem 7.5 と行列式による障害解析。行列式固定の滑らかさ、cone全体の分解、直交性は1.5で証明し、行列式固定の結論に用いる拡張定理である。

<a id="target-1-6"></a>
### 1.6 有限平坦展開変形と閉シンプレクティック形式

**一般理論。**

相対トレース二形式を構成して普遍対象の被覆から降下させ、§§1.4–1.5 により非退化性を証明する。閉性は、極限系や合流への応用に先立ち、本項目の補助構成で証明する。滑らかで整な補助基底 H 上で、固定極因子を I23 §8 の有限平坦因子に置き換える。分岐点では、相異なり0と1を避ける qⱼ に対し ∏ⱼ₌₁ᵐ⁻¹(z−hʳqⱼ)(z−hʳ) を用いる。展開変形された因子分解型局所構造を持つ単純接続のモジュライ代数空間、普遍対象を持つエタール被覆、相対変形複体、トレース形式を構成する。この新しい族に有界性と変形理論を改めて適用する。§1.1 の相異なる標識切断の族だけでこの構成を済ませることはできない。

H 上の滑らかさを証明し、元の安定モジュライ・複体・形式を中心ファイバーの適切な開部分と同定する。極が一般的位置に分離した稠密開パラメータ集合上で、対角的変形複体から、展開変形複体および対数放物的複体への二つの擬同型をトレース形式と適合して構成する。Čech カップ積・トレース計算とゲージ降下で対数トレース形式の閉性を証明し、両比較を通じて閉性を移す。整基底上のこの滑らかな族では相対三形式の層が局所自由であり、指定された稠密開集合への制限が零を検出する。全体で d_relative ω=0 を得て、中心安定領域へ制限し降下する。後から非被約基底へ変換するときは、この証明した恒等式を引き戻す。非被約基底上の稠密性では代用しない。

行列式固定の場合の閉形式は、行列式ファイバーへのこの形式の引戻しである。その非退化性は §1.5の直交性比較から証明する。スカラー Hamilton 関数や相曲面の分類はこの構成に入らない。

**入力条件**

- 許容範囲における §§1.3–1.5。滑らかさ、補助的な単純接続族、一般部分の比較写像、閉性は出力である。
- 行列式固定のシンプレクティック性を供給するには、§1.5の行列式ファイバー比較と非退化性の定理を用いる。

**構成・法則（API）**

- 有限平坦展開変形、単純接続モジュライ、普遍対象の被覆を構成し、中心ファイバーを同定する。
- 対角複体からの両比較写像を構成し、トレースペアリングとの両立性を証明する。
- 非退化性と閉性をそれぞれ証明し、降下および後の基底変換との両立性を含める。

**検証事項**

- 恒等的に消える交代ペアリングは閉じているが、シンプレクティックではない。非退化性は実際の双対性計算から導かなければならない。
- r = 2、局所次数 2、q₁ = 2 の場合、展開変形の方程式は (z − 2h²)(z − h²) である。h = 0 でのファイバーは z²、h = 1 では (z − 2)(z − 1) であり、h² を法として考えると再び z² になる。この族を固定された互いに異なる切断と同一視せず、中心ファイバーと引戻し後の複体・形式を確認する。
- 後の応用とすべてのスカラー方程式を削除しても、有限平坦展開変形、一般部分の両比較写像、閉性の証明が本項目だけで記述・構成できることを確認する。

*必要な先行結果：* 内部依存：1.3, 1.4, 1.5; [Cohomology, duality and curve degree](#dependency-cohomology) (2.2; 2.6; 2.20; 3.3); [Elementary deformation theory](#dependency-deformation) (4.2–4.6); [Algebraic vector bundles and finite locally free sheaves](#dependency-bundles) (L0A–L0C; L1A–L1B; L2A–L2B).

**文献の範囲と担当証明：** I23 Theorem 8.1、Propositions 8.2–8.3、(8.2) の直前の複体。展開変形の証明が要するすべての構成を、有理型接続モジュライの一般理論で証明する。

<a id="layer-2"></a>

## レイヤー2：等モノドロミー変形と対数型 Riemann–Hilbert 対応

<a id="target-2-1"></a>
### 2.1 強い可積分延長と水平分裂

**一般理論。**

モジュライ点の時間接ベクトルに対し、対応する双対数変形上の普遍接続の強い可積分延長を構成する。動く全曲線 X 上で D を係数1の標識相対 Cartier 因子の和とし、滑らかな周囲の族で形成してから無限小基底へ引き戻す。許容される全微分形式の極のフィルトレーションは、固定補助基底に相対的な Ω¹_X(log D) ⊗ O_X(P−D) とする。可積分性と、局所フィルトレーションに付随する核格子、すなわち必要な構造的厚みを持つ E → E|_{mᵢaᵢ}/Fᵢ,k の核、および追加の因子分解関係式の保存を要求する。各ファイバーで別々に旗を保つだけでは足りない。動く極座標 z では許容形式が dz/zᵐ と dε/zᵐ⁻¹ で生成されるという座標補題を証明する。対数点では時間係数は正則である。

この強い延長の範囲内で、中心ファイバー上恒等となる指定同型を除く存在と一意性を証明する。局所持上げを貼り合わせ、普遍対象の被覆から降下して、実際の O 線形分裂 h:π*TB→TM を構成し dπ∘h=id を示す。行列式固定の場合には、構成した延長の行列式が §1.2 の検証済み階数1輸送に一致することを証明し、h が動く行列式ファイバーに接することを得る。これは比較定理であり、任意の行列式切断を保存するという主張ではない。h の存在、可積分性、トレース形式の保存は入力公理にしない。

**入力条件**

- §§1.1–1.5 の許容時間・モジュライ構成と時間接ベクトル。全形式の極条件と核格子の関係式は構成すべき延長の範囲を指定する。
- 行列式固定の場合には、§1.2 の検証済み階数1時間輸送と §1.5 の行列式ファイバー比較を用いる。

**構成・法則（API）**

- 時間方向の接ベクトルから持上げを構成し、加法性と O-線形性を証明する。
- 持上げの制限、基底変換、および入力の同型に関する自然性を証明する。
- 異なる局所座標、形式的対角化、普遍対象をもつ被覆で計算された持上げを比較する。
- 誘導された水平部分束と、その π*TB への射影同型を同定する。
- 強い延長の行列式関手との両立性と、検証済みの動く行列式ファイバーへの接性を証明する。

**検証事項**

- 零の時間接ベクトルの持上げは零である。任意の垂直ベクトルを加えると、可積分拡張の一意性に反する。
- 時間接ベクトルを 2 倍するとその持上げも 2 倍されるが、時間座標を 2t に変えると正規化された生成元は 1/2 倍される。
- 非零の時間接ベクトル上では、零写像は分裂にならない。dπ ∘ 0 = 0 ≠ id だからである。
- m=1 での時間項 dε/z は、動く極座標で許容される全形式の加群の外にある。ファイバーごとの旗の保存ではこの違反を補えない。

**本目標が担う補助構成。**

- 1.1 の形式的対象と 1.4 の実際の変形コサイクルを用い、許容される各双対数時間方向について、極加群 Ω¹(log D)⊗O(P−D)、核格子、因子化関係を保持する強い微小全接続を構成する。中心ファイバーの指定同定をもつ変形類の存在・一意性、行列式移送との一致、重なりと降下を証明し、rigidification 前の微小スカラー自己同型を保持する。混合時間方向の平坦性とトレース形式の保存は 2.2 が別々に証明し、正則基底変換のコヒーレンスは 2.3 が担う。形式 oper の等モノドロミー亜群や各ファイバーの形式標準形を、正則な時間分裂の証明の代用にしない。

*必要な先行結果：* 内部依存：1.1, 1.2, 1.3, 1.4, 1.5, 0.1; [Elementary deformation theory](#dependency-deformation) (4.2–4.6).

**文献の範囲と担当証明：** I23 Definition 10.1、(10.1)、Lemmas 10.3–10.6、Propositions 10.7/10.10、(11.2)。行列式との両立性および内在的極フィルトレーションの比較は本稿が担う証明課題である。

<a id="target-2-2"></a>
### 2.2 平坦性・トレース形式の保存・閉全形式

**一般理論。**

二変数の強い延長と混合無限小項を比較して h([v,w])=[h(v),h(w)] を証明する。正則な積分切断が対応する強い可積分全接続を持つことを示す。この交換子の計算は代数的な延長比較を用い、大域 Riemann–Hilbert 定理を用いない。

実際のトレースコサイクルと強い延長の比較により、構成した水平変化が相対シンプレクティック形式 ω を保つことを証明する。任意の分裂の平坦性だけからこの保存性は従わない。Ω(v,w)=ω(v−h(dπv),w−h(dπw)) を定義し、dΩ=0 と ker Ω=im h を証明して、局所水平輸送による ω の保存を導く。NonlinearConnections §0.6 の一般的な微分形式の同値は最後の計算を整理するために使えるが、トレース形式の保存を未証明の前提として与えるものではない。時間1次元のチャートでシンプレクティック自明化と局所完全性を与えた後に初めて、相対次元2では Ω=dq∧dp+dH∧dt、高い偶数次元では対応する和を導く。スカラー Hamilton 関数はチャートに付随する局所原始関数である。

**入力条件**

- §2.1 の実際の強い分裂と §1.6 の相対シンプレクティック形式。行列式を固定する場合は§1.5の比較定理も用いる。平坦性とその形式の保存は出力である。

**構成・法則（API）**

- 二変数の混合延長項を計算し、交換子恒等式と平坦な水平分布を得る。
- 垂直方向への制限によって相対形式を、核として水平分布を復元する。
- 相対形式、実際の分裂、閉全形式について許容基底変換に関する自然性を証明する。
- 固定チャートにおける二つの Hamilton ポテンシャルを比較する。その差は連結な相ファイバーに沿って定数である。
- 拡張二形式の等式を通じて、時間に依存するシンプレクティック座標変換に伴う追加の生成関数項を述べる。

**検証事項**

- H = p²/2 の場合、dq ∧ dp + p dp ∧ dt と ∂t + p∂q の内部積は零である。符号を逆にすると零にならない。
- H と H + t² は同じ垂直ベクトル場と拡張二形式を与えるが、スカラー関数としては異なる。
- シンプレクティックなファイバー上では、Ω の核に非零の垂直ベクトルは存在しない。ω を零に退化させると、この特徴づけは成り立たない。
- ℂ²×ℂ で ω=dq∧dp、h(∂t)=∂t+q∂q とすると、基底1次元なので分裂は平坦だが、そのフローは ω を拡大する。この例はトレース形式保存の条件を満たさない。

*必要な先行結果：* 内部依存：1.4, 1.6, 2.1, 0.6; [Complex manifolds, holomorphic bundles and observations](#dependency-complex) (K1; K3.0; K3.HolomorphicStalk; K3.MeromorphicGermField; K4; K7.1).

**文献の範囲と担当証明：** I23 Theorem 11.6、Definition 11.4、Corollary 11.8。平坦性の証明とトレース形式の変化は別々の証明課題である。

<a id="target-2-3"></a>
### 2.3 自然性と表示変更の整合性

**一般理論。**

同型な許容付加構造付き時間問題に対し、スタック、剛化、相空間族の両立する同型を構成し、トレースペアリング、ω、h、Ω を保存する。有限ジェット座標変更、形式フレーム変更、降下データ付きの分岐根変更、普遍対象の被覆、適合する階数1行列式輸送を含める。滑らかな複素基底間の正則写像 f:B′→B に対する引戻し比較を構成し、(b′,m) での水平ベクトルが (v′,h_m(df(v′))) であることを証明する。代数スタックの引戻しは一般の試験基底でも意味を持つが、解析的沈め込みの主張には滑らかな複素基底を要する。

恒等基底変換と合成基底変換の自然比較同型、結合の五角形、単位の三角形、2同型な表示の射との両立性を記録する。剛化された相空間では、これらが必要な等式とコサイクル則へ降下する。したがって剛化前は擬関手的であり、剛化後も明記した標準比較を伴って関手的となる。入力の同型でない行列式、重み、ラベル、形式局所型の変更は、定義域を示した実際のパラメータ変更または対応として残す。時間依存ゲージ行列は公式を変えるが、適合する対象と輸送されたテンソルは同一視される。

**入力条件**

- 同じ許容付加構造付き時間問題の同型、指定データを保つ基底写像、§§1.1–2.2 の構成。
- 解析的出力は滑らかな複素基底上で扱い、粗空間比較には §1.3 のスカラージェルブ降下を使う。同型でないパラメータ変更は表示の射に含めない。

**構成・法則（API）**

- スタックの比較1同型と整合する2同型を与え、対応する相空間比較を降下させる。
- 引き戻した分裂・形式が基底変換後に構成した出力と一致することを証明する。
- NonlinearConnections の射の始域・終域写像を保ち、すべてのパラメータ対応の正確な定義域を示す。

**検証事項**

- f:B′→B と g:B″→B′ に対し、直接の (f∘g)* 構成を g*f* と比較し、無関係な同一視を選ばず三重合成の五角形を確認する。
- 重みの壁越えは安定領域を変え、実際の共通安定領域を指定しない限り表示の同型ではない。
- 基底写像 t=s² では h(∂t) の引戻しは h′(∂s)=(∂s,2s h(∂t)) となる。s=0 でも水平ベクトルは ∂s に射影するので、基底写像を局所同型に限る必要はない。

*必要な先行結果：* 内部依存：1.1, 1.2, 1.3, 1.4, 1.6, 2.1, 2.2, 0.1; [Stacks, inertia and restricted coarse-space criteria](#dependency-stacks) (1.18–1.23).

**文献の範囲と担当証明：** I23 Propositions 10.7、10.10 が比較に使う一意性を供給する。内在的な基底変換と2同型の整合性は本稿の証明目標であり、座標公式からの引用ではない。

<a id="target-2-4"></a>
### 2.4 有理型接続モジュライ上の等モノドロミー接続

**一般理論。**

§§1.1–2.3 をまとめ、許容された各付加構造付き時間問題から、剛化された安定相空間族を構成する。滑らかな解析的時間基底の非空ファイバーの開部分上では、NonlinearConnections 0.1、0.6 の正則・平坦・シンプレクティック非線形接続 (π:M→B,h,ω) と、その閉全形式 Ω を得る。入力は曲線と局所接続データ、重みの部屋、行列式の扱いであり、h、スカラー微分方程式、曲面の分類を含まない。行列式非固定なら任意の種数と許容階数・極次数に適用する。行列式固定の出力には §1.5 の独立に証明した比較と §1.2 の検証済み時間輸送を要する。

局所模型の許容性、実際の時間基底、行列式検証、重み、非空性の証人を列挙する共通の利用証明書を与える。幾何学的対象、構成済みのテンソル、正確な範囲の次元定理、自然性、整合的引戻し則を返す。利用側が証明するのはこれらの適用条件と追加の特殊化結果である。特に相対次元2や時間1次元はこの構成定理の条件に含めない。完備性、固有 Riemann–Hilbert 比較、指定観測量、スカラー化、特別な解には、それぞれ下流の仮定と証明を要する。構成定理は明記した許容性を仮定し、指定した先行の構成定理と比較定理を用いる。

**入力条件**

- §§1.1–1.2 の許容幾何学入力と時間問題、§§1.3–1.6 の安定構成、§§2.1–2.3 で実際に構成した h、平坦性、自然性。
- 全射な非線形接続の基礎対象を得るため、非空ファイバーの開時間領域に制限する。提案した基底全体について主張する利用側は非空性を示す。
- 行列式固定の出力には、行列式ファイバーの比較と階数1輸送の定理も用いる。

**構成・法則（API）**

- 特殊な相空間の別名ではなく構成定理を供給する。その結論は許容幾何学入力から π、h、ω、Ω と全法則を与える。
- 共通の利用証明書を供給し、構成・非空性・完備性の各証明課題を区別する。
- 場合の分類をやり直さず、§2.3 を通じて基底変換と表示同値に関する再利用を証明する。

**検証事項**

- すべての特殊な利用側、相対次元2の選択、古典的方程式を除いても、入出力の主張と局所依存関係がそのまま残る。
- ℙ¹ 上の階数2、5対数極、行列式固定、非空の安定領域では相対次元4、配置基底の次元2を得る。この入力を構成定理が受け付けなければならない。
- 任意の形式特異点の組は、次元の式が正になるだけでは許容されない。各局所模型と行列式・時間の証明書を確認する。
- 正則・平坦・シンプレクティック接続でも水平曲線は不完備になりうる。この出力だけでは全初期条件の大域延長を正当化できない。

*必要な先行結果：* 内部依存：1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 2.1, 2.2, 2.3, 0.1, 0.6.

**文献の範囲と担当証明：** この統合と利用条件は本ロードマップの数学設計である。I23 が許容された行列式非固定の構成模型を供給し、追加の行列式・整合性の比較は、指定した有理型接続モジュライの各目標で証明する。

<a id="target-2-5"></a>
### 2.5 標識付き対数 Betti 族と全 Riemann–Hilbert 写像

**一般理論。**

§1.1 の対数的部分問題に対し、穿孔曲線の表現多様体、共役によるアフィン商、指定局所指標を持つ部分族を位相的標識とともに構成する。de Rham 側の留数指数パラメータ λ と、Betti 側の指数写像から得る特性多項式パラメータ a=rh(λ) を保持する。§1.3 の有界構成を留数パラメータ空間 Λ 全体上で改めて行い、I13 の族との比較を証明する。水平分裂は λ を固定した相対的なものであり、λ の変化を時間方向にはしない。標識被覆上では Betti 族を輸送によって固定した指標多様体と時間基底の積に同定する。指標多様体が特異でも、これによりすべての許容時間経路に沿った完備な輸送を得る。滑らかな Betti 接束は要求しない。

§1.3 の安定対数放物接続モジュライ全体から正則 Riemann–Hilbert 写像を構成する。許される可約・共鳴対象とすべての束型を含める。水平切断の局所系とその共役商での類によって定義し、普遍対象の被覆から降下させる。この対数モジュライ問題、重み、留数順序を I13 の正確なモジュライ関手と同定する。行列チャートだけでの比較では足りない。対数格子を保持する全可積分延長と局所解の解析的依存性により、§2.1 で実際に構成した強い分裂が、すべての点で標識付き Betti 輸送と半共役であることを証明する。局所水平持上げの存在は Riemann–Hilbert 写像の可逆性とは独立に示す。共鳴・可約点では写像が正次元のファイバーを持ちうるので、逆写像で置き換えない。

検証済みの行列式輸送に対し、モノドロミーの行列式が階数1の Riemann–Hilbert 写像と一致し、指定行列式が輸送される Betti 切断となることを示す。Hausdorff で局所コンパクトな標識付き終域と全点での半共役を NonlinearConnections §0.4 への入力として供給する。固有性は §2.6 を待ち、始域の完備性はここでは結論しない。

**入力条件**

- §1.1 の対数局所部分問題、§1.2 の許容標点付き曲線時間問題と固定留数指数、§2.4 の実際の安定モジュライと強い接続。
- 穿孔曲線族の位相的標識被覆。行列式固定の結論には検証済み行列式輸送を要する。Betti 終域の特異点は許す。

**構成・法則（API）**

- 完備な経路輸送を持つ標識付きアフィン Betti 終域を構成し、保持する留数・指標パラメータ写像を示す。
- 実際の強い始域分裂について、特異な終域の層への写像も含む全点での Riemann–Hilbert 半共役を証明する。
- 対数モジュライ関手全体を I13 と同定し、行列式、表示変更、解析的基底変換との両立性を証明する。

**検証事項**

- Riemann–Hilbert 写像が同型となる開集合は、安定な共鳴・可約対象すべてを含むわけではない。半共役はそれらの実際のモジュライ点でも確認する。
- 許された整数ずれを持つ二つの留数パラメータが同じ局所モノドロミー固有値を与えうる。a パラメータ上で de Rham 族を同一視せず λ を保持する。
- 特異なアフィン指標多様体も Hausdorff で局所コンパクトな解析空間であり、標識付きの完備輸送を持つ。終域の非特異性を要求すると、固有写像による延長論法に必要な層を除いてしまう。

**本目標が担う補助構成。**

- 穿孔曲線上の CKG K4 から、指定した指数の持上げ・放物旗・実際の対数格子を備えた対数拡張を構成し、モノドロミー規約 exp(−2πiλ) と必要な確定特異の代数的／解析的比較を証明する。共鳴、重複留数、整数による指数変更と格子変更、すべての束の型を保持する。同値は局所系側にも格子・旗を記録し、それらを忘れる写像が一般には単射でない RH 写像になる。族の解析的依存性と普遍対象・標識被覆からの降下を証明する。

- 2.5 は 1.3 の不変式論を用いて有限型表現多様体と簡約群によるアフィン共役商を構成し、1.2 の解析化を適用して特異点を含む Hausdorff 性・局所コンパクト性・標識付き積移送を証明する。4.2 は wild/Stokes のフレーム亜群と、実際に簡約群商または降下が正当化される各段階の商を構成する。局所 Stokes 群が冪単であることから任意の GIT 商を推論しない。根・被覆変換を保つ isotopy、分岐降下、安定化群との両立、全層での正則写像を証明する。SSF1.17 をこれらの構成の代用にしない。

- Deligne II5.4 の拡張は ℂ→ℂ/ℤ の切断を選んで構成され、その標準拡張は一般にはテンソル積と両立しない。したがって行列式との両立は、必要な整数分の格子変更を含めて、実際の対数格子と留数和に対して証明する。モノドロミーの特性多項式の固有値は exp(−2πiλ) となるが、モノドロミー行列が exp(−2πi Res) と共役であるという行列の比較には適切な非共鳴条件（II5.6）が必要であり、すべての共鳴点で主張しない。全 RH 写像と階数 1 の Cartesian な行列式比較の双方でこの区別を保つ。

*必要な先行結果：* 内部依存：1.1, 1.2, 1.3, 2.1, 2.2, 2.3, 2.4, 0.3; [Complex manifolds, holomorphic bundles and observations](#dependency-complex) (K1; K3.0; K3.HolomorphicStalk; K3.MeromorphicGermField; K4; K7.1); [Marked-curve charts](#dependency-curves) (ComplexCurveModuli D0.3, D3–D5; SchemeAndStackFoundations 4.15).

**文献の範囲と担当証明：** I13 §2 の標識付き Riemann–Hilbert 写像、§6、§8 のモノドロミー保存変形。同論文のモジュライ関手・強い分裂との全体的比較、例外的な層、行列式との両立性は本項目の担当である。

<a id="target-2-6"></a>
### 2.6 対数型 Riemann–Hilbert 族の固有性

**一般理論。**

§2.5 で同定した安定対数放物接続モジュライ全体について、留数写像 rh:Λ_r^(n)(d)→A_r^(n) に沿って引き戻した指標族への標識付き Riemann–Hilbert 写像が族として固有であることを証明する。終域には (Rep_r(C,marked points)×_T T̃)×_{A_r^(n)}Λ_r^(n)(d) 全体を用い、一般的な滑らかな指標領域だけに制限しない。文献の正確な範囲は、階数 r≥2、n≥1、安定性と半安定性が一致する一般の重み、および g=0 なら rn−2r−2>0、g=1 なら n>1、g≥2 なら n≥1 である。留数空間は d+Σᵢⱼλⱼ^(i)=0 を満たす。族についての固有性と解析的基底変換での保存を証明する。個々のファイバーだけでの固有性では必要な結果にならない。正確な関手比較の後、この範囲では文献の定理から全射性と双有理型性も得られる。

行列式固定の場合には、de Rham・Betti モジュライの行列式を取る可換正方形を構成する。指定トレース留数と対数格子を持つ階数1の確定特異 Riemann–Hilbert 対応が同型であることを証明し、指定行列式の粗モジュライを対応する行列式 Betti 切断の実際の Cartesian 逆像と同定する。スカラージェルブの比較も含め、行列式同一視を選ぶ操作で粗ファイバーを無言に変更しない。その切断が輸送されるという主張には §1.2 の証明書と §2.5 の比較を要する。この証明した正方形に沿う固有な解析的基底変換により、行列式固定の族の固有性を導く。この比較は種数0でも必要であり、その場合の簡略化も証明する。

§§2.5–2.6 を合わせた固有半共役の証明書を供給する。利用側が実際の始域と時間領域について NonlinearConnections §0.4 を適用し、水平曲線の完全延長を導く。一般の延長定理はここで再証明せず、この固有性を任意の不確定データへ拡張しない。

**入力条件**

- I13 と同定した §2.5 の対数モジュライ問題全体と Riemann–Hilbert 写像。r≥2、n≥1、固定した種数・次数・留数データと d+Σᵢⱼλⱼ^(i)=0。
- 安定性と半安定性が一致する一般の重み。g=0 では rn−2r−2>0、g=1 では n>1、g≥2 では n≥1。
- 行列式固定への制限には、証明した Cartesian 行列式比較、階数1の確定特異対応、検証済みで輸送される行列式切断も要する。

**構成・法則（API）**

- パラメータを保持した終域全体を同定し、許容された解析的時間・指数基底変換に沿う引戻し後の固有性を証明する。
- 階数1の Riemann–Hilbert 対応とスカラー同一視の問題を含め、粗モジュライの Cartesian 行列式比較を構成して証明する。
- 一般延長定理を別途適用するための固有半共役の証明書を返す。

**検証事項**

- g=0、r=2、n=5 では rn−2r−2=4>0 となり、文献の数値条件を満たす。行列式固定の全応用には実際の非空性の証明書と行列式比較も必要である。
- g=0、r=2、n=3 では rn−2r−2=0 となるため、本項目は I13 Theorem 2.2 をその固有性の供給元として適用できない。
- 始域から例外的ファイバーを除くと、一般部分で Riemann–Hilbert 写像が同型でも固有性を失いうる。安定モジュライ始域全体を保持する。
- 5極への応用も、他の固有半共役の利用側と同じ NonlinearConnections §0.4 を使う。ここに5極専用のコンパクト性定理を追加しない。

**本目標が担う補助構成。**

- Deligne II5.4 の拡張は ℂ→ℂ/ℤ の切断を選んで構成され、その標準拡張は一般にはテンソル積と両立しない。したがって行列式との両立は、必要な整数分の格子変更を含めて、実際の対数格子と留数和に対して証明する。モノドロミーの特性多項式の固有値は exp(−2πiλ) となるが、モノドロミー行列が exp(−2πi Res) と共役であるという行列の比較には適切な非共鳴条件（II5.6）が必要であり、すべての共鳴点で主張しない。全 RH 写像と階数 1 の Cartesian な行列式比較の双方でこの区別を保つ。

*必要な先行結果：* 内部依存：1.1, 1.2, 1.3, 1.5, 2.3, 2.4, 2.5.

**文献の範囲と担当証明：** I13 Theorem 2.2 のすべての数値条件、Remark 2.3(1)、§6、§8。本枠組みとの比較と行列式固定の Cartesian 正方形は本稿が証明する。不確定の場合の固有性は推論しない。

### 構成と証明の要件

- `M-local-presentation-descent` — §§1.1、1.2、2.3 で、座標・根の変更を含む入力亜群と整合的降下を構成する。
- `M-determinant-time` — §§1.2、2.1 で階数1の強い輸送を検証し、階数 r の延長との行列式比較を証明する。大域的出力には実際の貼り合わせを要する。
- `M-determinant-fiber` — §§1.4–1.6 で完全な分岐 cone と正則行列式 de Rham 複体を比較し、分解・滑らかさ・2g 除去・直交非退化性を証明する。
- `M-early-unfolding` — §1.6 の有限平坦補助族と一般ファイバーの両比較写像を、すべての合流への応用より先に構成する。
- `M-strong-lift` — §§2.1–2.2 で極と核格子の条件内での存在・一意性、混合項による平坦性、実際のトレース形式保存を証明する。
- `M-coherent-export` — §§2.3–2.4 で引戻し・表示比較、2同型の整合性、一般構成定理をすべての特殊な利用側から独立に証明する。
- `M-regular-RH-proper` — §§2.5–2.6 で I13 の対数モジュライ関手全体との同定、全点での強い分裂の半共役、正確な族の固有性、行列式固定の Cartesian 制限を証明する。始域の完備性は利用側が NonlinearConnections の一般定理を適用して導く。

### 一次文献と使用範囲

- **I23** — [Michi-aki Inaba, Moduli Space of Factorized Ramified Connections and Generalized Isomonodromic Deformation, SIGMA 19 (2023), 013](https://sigma-journal.com/2023/013/); [PDF](https://sigma-journal.com/2023/013/sigma23-013.pdf). §§2–5; §6 (6.9), Proposition 6.3; §7 Proposition 7.2, Theorem 7.5; §8 Theorem 8.1, Propositions 8.2–8.3; §10 Definition 10.1, (10.1), Propositions 10.7/10.10; §11 Definition 11.4, Theorem 11.6, Corollary 11.8.
- **I13** — [Michi-aki Inaba, Moduli of parabolic connections on a curve and Riemann–Hilbert correspondence, Journal of Algebraic Geometry 22 (2013), 407–480](https://arxiv.org/abs/math/0602004); [PDF](https://arxiv.org/pdf/math/0602004). Definitions 1.1 and 2.2; Theorems 2.1–2.2; §6; regular-singular reconstruction and surjectivity.

I13 は選択的な対数分枝 §§2.5–2.6 を供給し、対数的利用例の非空性も支える。§2.4 の一般不確定構成の前提ではない。I23 の局所制約を外した無条件の拡張は主張しない。

<a id="five-point-application"></a>

### 五つの対数極への独立した適用

この適用は、実際の証明再利用を検査する。許容入力の構造的次数は 5、時間基底の次元は 2、相ファイバーの次元は 4 である。一般の構成・延長・降下には古典的適用と同じ証明を用い、パンルヴェの目標は前提にしない。

<a id="target-2-7"></a>
### 2.7 五つの対数極と空でない安定入力

**五つの対数極への独立した適用。**

順序付き五点をもつ種数 0 の曲線をとる。最初の三点を 0、1、∞ に送る一意な正規化の後、時間基底は B = {(t₁,t₂) ∈ ℂ² : t₁,t₂ ∉ {0,1}, t₁ ≠ t₂} と表示される。したがって dim B = 2 は標識曲線の商から得る結論であり、B の座標はその商の表示である。階数 2、構造的因子 P = a₁+⋯+a₅、同定を指定した行列式 (O,d) とその自明な強い時間移送、順序付き留数対 (1/4,−1/4)、(1/4,−1/4)、(1/6,−1/6)、(1/6,−1/6)、(1/4,−1/4) をもつ完全対数的旗を用いる。i=1,…,5 に対して重み αᵢ,₁ = i/100、αᵢ,₂ = i/100 + 2ⁱ⁻¹/1000 を選ぶ。十個はすべて異なり、0<αᵢ,₁<αᵢ,₂<1 である。階数 1 の安定性の壁では 2deg F + Σᵢ εᵢ2ⁱ⁻¹/1000 = 0（εᵢ=±1）が必要になるが、符号和の分子は奇数で絶対値は 31/1000 以下なので成立しない。したがって、この数値データでは安定と半安定が一致する。これらを MeromorphicConnectionModuli §§1.1–1.2 の入力とする。古典的な次数 4 の条件を課さない。

相空間の点を仮定せず、すべての配置について非空性を証明する。γ₁⋯γ₅ = 1 を満たす生成元に対し、D = diag(i,−i)、J = [[0,1],[−1,0]]、K = diag(exp(πi/3),exp(−πi/3))、(M₁,…,M₅) = (D,J,K,K⁻¹,(DJ)⁻¹) とする。積は I であり、各局所スペクトルは相異なる。D と J に共通不変直線がないため、この表現は既約である。exp(−2πiλ) に対応する指定した対数と、必要なら標準拡張からの局所対数格子の変更を用いた確定特異対応により、各標識曲線上に指定した留数・旗をもつ対数接続が得られる。ここで用いるのはモノドロミーの既約性であり、留数行列に定数の共通固有直線がないという条件ではない。

トレース留数は零で、行列式モノドロミーは自明である。したがって行列式の対数接続は、ℙ¹ 上の極をもたない平坦線束接続へ延び、(O,d) と同型になる。その同定を選ぶ。不変な真部分束がないので、選んだ重みについて安定である。追加の確認として、各極で一つずつ留数を選んだ和は [3(σ₁+σ₂+σ₅)+2(σ₃+σ₄)]/12、σᵢ ∈ {−1,1} と書ける。分子は奇数なので整数にはならない。これも留数・次数関係によって階数 1 の不変部分接続を排除する。B 全体でファイバーが非空であることを証明し、B 上の大域的標識付き対象を仮定しない。

**入力条件**

- ℙ¹ 上の順序付き相異なる五点、指定した階数・対数留数・行列式の同定・一般の重みを用いる。時間の商の二次元性と安定ファイバーの非空性は出力である。

**構成・法則（API）**

- 標識曲線の実際の商を B と同定し、その固定された衝突判別集合を確認する。
- 既約モノドロミーの具体例、その指定対数による拡張、行列式の同定を構成する。
- 階数 2 の基礎束を自明と仮定せず、安定ファイバーの非空性を確認する。

**検証事項**

- 積 D J K K⁻¹ (DJ)⁻¹ は厳密に I である。D の固有直線は座標軸であり、J はそれらを入れ替える。
- 留数差は 1/2 または 1/3 で非共鳴である。符号付き和の分子は奇数で、整数となる場合をすべて排除する。
- 五極を四極に置き換えると時間次元は 2 から 1 へ変わり、単なるチャート変更ではない。
- 留数行列に定数の共通固有直線がないことだけでは、微分加群の既約性の証拠にならない。

*必要な先行結果：* 内部依存：1.1, 1.2, 2.5.

**文献と証明範囲：** I13 Theorems 2.1–2.2 and its regular-singular correspondence, plus I23 admitted logarithmic construction. All generic results are consumed through the named frameworks; this application verifies their hypotheses.

<a id="target-2-8"></a>
### 2.8 四次元相空間の等モノドロミー変形

**五つの対数極への独立した適用。**

§2.7 で確認した入力に MeromorphicConnectionModuli §2.4 を適用する。その出力は、許容される次数 0 の束の型をすべて保持した全安定相空間族 π: M → B、相対トレース・シンプレクティック形式 ω、および構成された正則平坦分裂 h である。種数 0 における行列式固定との比較を確認する。一般次元公式は 2·2²(0−1)+2+2(2−1)·5 = 4 を与え、この場合に行列式を固定して除かれる方向は 2g = 0 である。滑らかさとシンプレクティック性は構成の出力であり、入力の項目にしない。モジュライ構成が ω の実際の保存を証明した後で、NonlinearConnections §0.6 により閉じた全二形式を得る。可換な二つの水平時間方向は内在的に存在し、Garnier のスカラー公式や Hamilton 座標を用いない。

**入力条件**

- 2.7 の確認済み入力と非空性を用いる。相空間・分裂・シンプレクティック形式を入力として与えない。

**構成・法則（API）**

- 一般構成の許容条件と行列式比較を確認する。
- 同じ非線形接続対象、相対次元 4、閉じた全形式を提供する。
- 引戻しと表示の比較を同定し、時間次元 2 を保持する。

**検証事項**

- ファイバー次元は −8+2+10=4 で、2 ではない。deg P=5 を古典的な予算に置き換えない。
- 平坦性だけでは e^{t₁}ω を保存しない。実際の保存定理を適用しなければならない。
- 大域的モジュライ族を、自明束上の行列チャートで置き換えない。

*必要な先行結果：* 内部依存：2.7, 2.4, 0.6.

**文献と証明範囲：** I13 Theorems 2.1–2.2 and its regular-singular correspondence, plus I23 admitted logarithmic construction. All generic results are consumed through the named frameworks; this application verifies their hypotheses.

<a id="target-2-9"></a>
### 2.9 五極の Riemann–Hilbert 対応と固有性

**五つの対数極への独立した適用。**

この対数モジュライ問題に、I13 Theorem 2.2 に基づく MeromorphicConnectionModuli §§2.5–2.6 を用いる。g=0、r=2、n=5、rn−2r−2 = 4 > 0、および一般の安定性重みを確認する。階数 1 の行列式比較と、実際の粗モジュライ・gerbe の比較を用いて、構成した行列式固定モジュライを I13 の族の同じ行列式ファイバーと同定する。指数パラメータの写像 λ ↦ exp(−2πiλ) とのファイバー積で留数パラメータを保持した、標識付き指標族を用いる。固有性は、この実際の族の写像についての定理であり、証明した Cartesian な基底変換比較から受け取る。§2.7 の仮定にはせず、葉層の存在からも推測しない。

同 §2.5 の完備な Betti 経路移送を用い、§2.8 の強い分裂がすべての部分水平持ち上げをこの移送へ送ることを証明する。源と標的の比較には許容された全モジュライを用い、選んだ束のチャートへ制限しない。ここで利用するのは確定特異な定理である。一般の不確定特異点の固有性や、古典的パンルヴェの延長定理は取り込まない。

**入力条件**

- 2.7–2.8 の実際の対数入力と構成された接続、確認した I13 の数値範囲、行列式・標識の比較を用いる。固有性と部分持ち上げとの両立性は、一般定理を通じて確認する結論である。

**構成・法則（API）**

- 行列式固定後の正確な I13 モジュライと、指数パラメータを保持する Betti 標的を同定する。
- 証明された Cartesian 比較による固有性と、全点での水平両立性を確認する。

**検証事項**

- この場合は 2·5−4−2=4>0 である。種数・階数・極数の不等式を確認せず原典の定理を適用しない。
- 対数を忘れて指数値だけを保持すると、固有性の主張を失う。
- RH の固有性は π: M→B の固有性を意味しない。

*必要な先行結果：* 内部依存：2.7, 2.8, 2.5, 2.6.

**文献と証明範囲：** I13 Theorems 2.1–2.2 and its regular-singular correspondence, plus I23 admitted logarithmic construction. All generic results are consumed through the named frameworks; this application verifies their hypotheses.

<a id="target-2-10"></a>
### 2.10 五極の移送・モノドロミー・降下

**五つの対数極への独立した適用。**

§2.9 に NonlinearConnections §0.4 を適用し、B 内の任意のコンパクトな区分的 C¹ 経路に対し、各ファイバーのすべての点を通る一意な水平持ち上げを得る。0.3 から正則な局所芽、0.5 から基本亜群の作用と基点付き普遍被覆上の大域水平切断、0.6 からシンプレクティック保存を得る。作用と切断は構成された平坦接続の出力であり、その非線形モノドロミー作用で初期点が固定される場合に、ちょうど B へ降下する。

固有 RH 族を位相的標識の被覆上で構成した場合、まず初期標識を選び、B 内の与えられた経路 γ をその被覆へ持ち上げる。引き戻した接続と持ち上げたコンパクト経路に一般の固有移送定理を適用し、得られた水平持ち上げを M へ射影する。接続を保つ引戻し写像と局所一意性により、初期標識と重なり合う標識チャートの選択から独立であることを証明する。これにより、五穿孔曲線族の大域的な位相標識を仮定せず、B 内のすべての経路について完備性を主張する。

これは、古典的族に使うものと同じ一般の延長・降下の証明の、実際の第二の利用例である。推移的な依存閉包はパンルヴェへの適用の全目標を除外し、形式プロファイルの列挙・加法型曲面分類・スカラーのパンルヴェ公式にも依存しない。直接の import だけでなく、展開したグラフでこの条件を検査する。

相ファイバー二次元の場合のスカラー第一ジェット定理を、この四次元ファイバーに適用しない。また、二次元基底上で一変数の極の主張をしない。連結な正則時間曲線f:C→B、基点c₀∈Cと初期点x₀∈M_(f(c₀))を選ぶ。接続を引き戻し、0.5からCの基点付き普遍被覆C̃上の水平切断を構成する。その切断に沿う引戻しが定義され、非恒等的無限大条件を満たす観測量に0.7を適用して、C̃上の有理型関数を得る。スカラー評価が実際の被覆変換作用に不変であることと、Cへ降下することの同値を証明する。この条件は相空間切断の降下条件より弱くなりうる。C上の水平切断が別途与えられている場合は、同じ観測量の仮定の下でその切断を直接評価する。Garnier 座標辞書は五極への適用の四目標の対象範囲に含めない。

**入力条件**

- 2.8–2.9 の構成済み平坦シンプレクティック接続と確認済み固有半共役を用いる。曲線上の観測量の定理では、連結な正則時間曲線・基点・初期点と、得られる普遍被覆上の切断に沿う観測量の許容性を追加で仮定する。曲線への降下にはスカラー評価の被覆変換不変性、または曲線上に別途与えた水平切断を要する。

**構成・法則（API）**

- 時間二次元・相空間四次元の族に、同じ完備性と亜群作用の定理を適用する。
- 古典的適用への推移的依存がないことを確認する。
- 時間曲線の基点付き普遍被覆上の観測量引戻しと、スカラー評価の被覆変換不変性による降下判定を、明記した全ての許容性仮定の下で証明する。

**検証事項**

- 展開した前提グラフは、次数 4 の定義を含むすべてのパンルヴェ目標を除外する。
- 完備移送でもモノドロミーは非自明になりうる。普遍被覆上の切断が降下するとは限らない。
- 時間曲線に制限しても相ファイバーは四次元で、スカラー第一ジェットのファイバーは二次元である。スカラー第一ジェット同型をそのまま主張できない。

- 一般の平坦完備な接続q′=q/(2t)をℂ××ℂ上で考えると、(1,1)を通る水平芽はq=√tである。観測量qは許容されるが、普遍被覆上の値は一周の移送で符号を変える。曲線への引戻しと許容性だけではスカラー降下は得られず、0.7の追加条件が必要である。

*必要な先行結果：* 内部依存：2.8, 2.9, 0.3, 0.4, 0.5, 0.6, 0.7.

**文献と証明範囲：** I13 Theorems 2.1–2.2 and its regular-singular correspondence, plus I23 admitted logarithmic construction. All generic results are consumed through the named frameworks; this application verifies their hypotheses.

### 文献

- **I13:** Michi-aki Inaba, *Moduli of parabolic connections on a curve and Riemann–Hilbert correspondence*, [arXiv:math/0602004v2](https://arxiv.org/abs/math/0602004v2), Theorems 2.1–2.2; journal publication J. Algebraic Geom. 22 (2013), 407–480.
- **I23:** Michi-aki Inaba, [*Moduli Space of Factorized Ramified Connections and Generalized Isomonodromic Deformation*](https://sigma-journal.com/2023/013/), SIGMA 19 (2023), 013.

<a id="layer-3"></a>

## レイヤー3：パンルヴェ方程式の相空間と等モノドロミー変形

<a id="painleve"></a>

**概要。** 有理型接続のモジュライからパンルヴェ力学系を構成し、その水平切断からパンルヴェ関数を構成する。入力は、曲線、構造的極因子、行列式接続、局所的な形式的モジュライ条件、および安定性と標識のデータである。この入力から、相空間、そのシンプレクティック形式、および水平分布を構成する。すべての古典的スカラー方程式に先立って、共通の延長定理を置く。階数2の基礎となる10種類の形式的プロファイル、それらのラベル付き実現、8種類の加法型曲面、および6種類の古典的微分方程式は、いずれも比較結果として得る。理論の範囲には、共鳴パラメータ、許容される可約接続、分岐を伴う不確定特異点、特殊な不変部分、タウ切断、正規化された解析的解、および合流を含める。係数の初等的な退化は、別個の境界比較で扱う。タウ切断のJMU・ハミルトニアン比較には目標6.2–6.5で述べる正確な一般的位置の条件を課す。行列式の構成自体は、そこで指定する、より広い標識付きRHPの範囲を持つ。

### 対象範囲

Hastings–McLeod解の存在と一意性、実軸上で極を持たないこと、およびそのFredholm・Tracy–Widom恒等式はRandomMatrices §8.5の担当である。本ロードマップの§8.8が担うのは、そのスカラー解から内在的な水平切断への橋渡しだけである。RandomMatricesはこの橋渡しに必要な結果の供給元であり、本ロードマップへの依存を新たに課さない。タウ理論の分枝で必要なトレース級行列式は、RandomMatrices §8.3が明記する作用素の一般性で利用する。両理論を用いる新しい応用は、両者を利用する下流の課題となる。

差分・q差分パンルヴェ力学系、離散系についての一般のSakai分類、クラスターによる実現、任意階数のwild非可換Hodge理論、すべての代数的特殊解の分類、およびあらゆる漸近領域における接続定数の具体値は、別の対象範囲に属する。これらを、本ロードマップで定める微分方程式の理論の前提とはしない。ここに含める有理解と古典関数による解は、目標5.4–5.6・目標7.1–7.5の幾何学的簡約と変換から得られる明示的な族であり、そのような解すべての完全分類を主張しない。

### 規約

ℂ上で考える。曲線は滑らかで連結な射影曲線とし、相異なる標識点からなる有限・非空の順序付き集合を備える。一般の階数は整数r ≥ 1とし、傾き安定性はこの正階数の範囲で定義する。分岐を伴う局所条件には、指定された形式的モデルの階数と局所次数に関する制約も課す。古典的部分圏では種数0、階数2とする。構造的極因子をP = Σ mᵢaᵢと書く。これは極の上限を与え、局所モジュライ問題を記録するものであり、個々の接続の実際に消えない極の因子とは異なる。局所条件が許す場合には、標識点での見かけの特異点やスカラー留数も許容する。§3.7の補助的な展開変形と§9.5の衝突データでは、別途構成した有限平坦な因子を用いる。その特殊ファイバーが相異なる標識切断からなるとは限らない。

対象は、曲線全体上のベクトル束E、有理型接続∇: E → E ⊗ Ω¹(P)、その行列式接続と指定された線束接続との同型、および後述する局所構造からなる。関係する束の分解型はすべて保持する。一般の入力では有理型の行列式接続を許すが、古典的複雑度の部分圏では、留数を固定した確定特異な行列式接続と、動く曲線上でそれに適合する平行移動を用いる。それでも行列式の次数が奇数の場合を許容する。対数的な点では留数の固有値とそれに適合するフィルトレーションを指定し、共鳴パラメータで一つの完全な形式的同型類を固定しない。分岐を伴わない不確定特異点では、先頭項が相異なる一般的位置の形式的条件を用いる。分岐を伴う点では、分岐降下を備えた一般的位置の因子分解型分岐条件を用いる。非零であることを要求した先頭係数は、固定した不確定特異層の内部では非零に保つ。その消滅は目標9.5–9.8で扱う。

重みはwと書き、古典的スカラー係数αとの混同を避ける。指定した数値データについて半安定性と安定性が一致する、一般の安定性重みを用いる。安定性は∇不変な部分束に関する条件である。重みの部屋を変えることは壁越えの問題であり、補助的選択からの独立性ではない。同型は、行列式の同一視、ラベル、および指定した局所構造を保つ。剛化や粗モジュライ空間への移行に先立って、これらの射を保持する。行列式の同一視を固定した安定な階数2の対象では、残るスカラー群はμ₂であり、乗法群全体ではない。行列式を固定する操作と、この残余群を剛化する操作を区別する。

固定した外部の留数・指数パラメータをΘと書き、θ ∈ Θを固定したときの許容された標識付き時間底空間をBθと書く。相空間の族をπθ: Mθ → Bθと書く。固定パラメータと時間方向の区別は、変形問題の一部である。規約∇ = d + Aでは、対数留数λに対応するモノドロミー固有値はexp(−2πiλ)である。d − Aまたは指数θ = −λを用いる文献ではexp(2πiθ)となる。比較先を定めるファイバー積には、実際の対数パラメータを保持する。それらを忘れる写像は固有ではない。

水平分裂はh: π*TB → TMであり、dπ ∘ h = idを満たす。その像が不変に定まる力学系である。それをベクトル場として表すには、時間ベクトルの選択が必要になる。局所解は、初期点を指定した、ds(v) = h(v)を満たすπの正則切断sである。経路は、固定した許容底空間内の、コンパクトな区分的C¹経路とする。選んだ解の極に応じて底空間からさらに点を取り除くことはしない。

ハミルトニアン座標ではω = dq ∧ dpおよびι_Xω = d_phase Hを用いる。したがってq′ = H_p、p′ = −H_qである。拡張2形式はΩ = dq ∧ dp + dH ∧ dtであり、その核は∂t + Xを含む。τ = f(t)という時間変更の下では、正規化された水平生成子にdt/dτが掛かる。スカラーのハミルトニアンは局所的なものであり、時間だけの関数、または時間に依存するシンプレクティック座標変換の生成子により変化しうる。

「パンルヴェ関数」は、まず幾何学的な水平切断またはその芽を意味する。スカラー関数は、時間座標と正規化を指定した上で、許容される観測量を評価して得る。至る所で定義されたℙ¹への写像でも、恒等的に∞を値に取る場合がある。通常の有理型関数であるという結論からは、その場合を除く。普遍被覆上への延長と、B上の一価な対象への降下とは、異なる結論である。

### レイヤー間の依存関係

非線形接続、解、移送、観測量、収束を一般理論として構成・証明する。許容された有理型接続のモジュライと強いモノドロミー保存接続を構成し、対数的Riemann–Hilbert比較と、独立した五極への適用を証明する。この構成を古典的入力へ制限し、形式プロファイルを分類する。古典的全クラスのRiemann–Hilbert比較とパンルヴェ性を証明してから、曲面、変換、Riccati簡約との比較を展開する。行列式線束とタウ切断を内在的に構成する。古典的スカラー方程式、Hamiltonian、sigma形式は、独立した座標比較の目標として導く。一般の小ノルムRHP理論とBarnes Gを用いて、指定された解析解と接続公式を扱う。一般の極相殺、相対Poisson構造、解析的収束定理を用いて、幾何学的合流とタウ極限を証明する。内在的構成、延長、曲面幾何、タウ切断の目標は、古典的スカラー表示の比較を前提としない。

<a id="target-3-1"></a>
### 3.1 パンルヴェ方程式の付加構造付き接続

**パンルヴェへの適用。**

**入力条件**

- MeromorphicConnectionModuli 1.1 の対象、その実際の射、行列式、および許容局所構造を用いる。この段階では古典的な次数制限を課さない。

MeromorphicConnectionModuli §1.1 の対象と射を、そのまま用いる。ここでは付加構造付き接続を再定義せず、§3.3 の古典的部分圏で保持する行列式・局所付加構造・重み・標識を記録する。種数 0・階数 2 という制限は §3.3 で課し、一般枠組みには課さない。パンルヴェの文献で用いられる局所表示を、フィルトレーション・対数格子・分岐降下を保って、この同じ対象と比較する。内在的な随伴・射影的対象は End⁰(E) と PGLᵣ 接続である。大域的にトレースを引いた階数 r の接続や行列式の平方根を導入しない。（I23, §§2–4.）

**構成・法則（API）**

- 元の対象・射を複製せずに同定する。
- 後で選ぶ古典的入力について、奇数次数の行列式と共鳴・分岐表示の比較条件を確認する。

**検証事項**

- E = O ⊕ O(−1) の行列式の次数は奇数であり、大域的な行列式の半分による捻りは存在しない。指定された行列式がこれに一致するときにも、この束を対象として許さなければならない。
- 同じ重複固有値をもつ二つの対数留数について、一方がスカラーで他方が非零 Jordan ブロックである場合、固有値を指定しても両者は同一視されない。許容される放物的対象とモノドロミーは異なる。
- 階数 2 の分岐チャートで根 w を −w に変えると、表示された枝は変わるが、降下後の対象は同値である。降下の射を忘れる構成はこの検証に適合しない。
- I23 の分岐に関する規約では、階数 2 の分岐点は留数・次数の関係に 2c + 1/2 を寄与する。これを 2c に置き換えると、その関係が 1/2 だけ変わる。
- 傾き安定性または次元公式を適用する前に、階数 0 の入力を除く。r = 1 では随伴束 End⁰(E) の階数は 0 であるが、E 自身に課す正の階数という条件は変えない。
- A = 0 とフレーム変換 g = diag(z,1) に対して、g⁻¹dg = diag(1,0)dz/z である。そのトレースの半分を引くと diag(1/2,−1/2)dz/z になる。このスカラーのずれにより、トレースを引いた階数 2 の接続は E 上に貼り合わさらないが、誘導された End⁰(E) 接続と PGL₂ 接続は貼り合わさる。

*必要な先行結果：* 内部依存：1.1.

<a id="target-3-2"></a>
### 3.2 パンルヴェ方程式の時間変形空間

**パンルヴェへの適用。**

**入力条件**

- 取り込んだ付加構造付き入力と許容変形問題、および固定指数データを用いる。古典的行列式の時間方向への持ち上げとの比較は、この適用で確認する。

許容変形問題、座標変更の射、標識被覆、固定指数パラメータは MeromorphicConnectionModuli §1.2 を用いる。古典的部分圏では、留数を固定した確定特異な行列式接続が、その契約で必要な時間方向への持ち上げをもつことを確認する。種数 0 の局所切片と実際の接写像を同定し、時間基底を別の対象として作り直さない。縮約された versal 変形問題を §3.3 の入力とし、その一次元性を §3.4 で証明する。強いモノドロミー保存が保つのは移送された解析データであり、固定座標での不確定特異点の多項式ではない。（HEU10, Theorem 1.1; I23, §§5, 11.）

**構成・法則（API）**

- 一般構成による固定パラメータ方向と時間方向の接空間分解を同定する。
- 古典的制限に必要な行列式の持ち上げと、種数 0 の座標変更の整合性を確認する。

**検証事項**

- 順序付きの四つの対数点は PGL₂ で割ると一つのモジュラスをもつ：4 − 3 = 1。その複比は 0、1、∞ を避ける。
- τ = 2t という変換は、表示された水平生成元を 1/2 倍する。その係数を変えずに保持すると、異なるパラメータ付き系になる。
- 可動極集合が異なる二つの解も同じ Bθ を用いる。一つの解の極を削除した基底は、この要件を満たさない。

*必要な先行結果：* 内部依存：3.1, 1.2.

<a id="target-3-3"></a>
### 3.3 階数 2・次数 4 の部分圏

**パンルヴェへの適用。**

**入力条件**

- 種数0、階数2、構造的次数4、適合する留数を固定した確定特異な行列式接続、縮約されたversal時間変形問題、および非空な安定ファイバーを入力条件とする。

古典的な微分 Painlevé 系の入力クラスを、種数 0、階数 2、次数 4 の構造的極因子、§3.1 の局所モジュライ条件、固定留数と両立する移送を備えた確定特異行列式接続、§3.2 の形式データの縮約された versal（完備）変形、および空でない安定ファイバーによって定義する。種数 0 では、∇ = d + A に対する規約により、行列式の留数は「その和 = −次数」を満たす。時間変形は実際の縮約された変形問題であり、より大きな基底の中で任意に選んだ定値の曲線、または誘導される変形が versal 性を満たさない曲線による制限ではない。非空性はモジュライ問題の定義域に関する条件である。時間が一次元であることも延長可能性も、この定義の構成要素にはしない。縮約された時間の次元は、相空間の次元とは独立に §3.4 で証明する。接続データそのものを対象として保ち、このクラスを六要素の型として定義しない。（VDPS09, §2.2 and Table 1; I23, Theorem 7.5.）

極次数の総量を比較する際の r は、トレース零の指数差から計算される射影的 Katz 不変量である。接続を任意のスカラー接続で捻ったものの最大傾きではない。古典的な行列式の正規化は、余分なスカラー不確定時間を生じさせない。任意のスカラー不確定部分を加えることは、強い時間持上げを指定した別の階数 1 の拡張に属し、一次元変形の数え上げに暗黙に含めない。これらの局所的・形式的比較は、いずれも行列式線束の大域的平方根を必要としない。

**構成・法則（API）**

- 一般の接続関手をこの入力データの充満部分圏に制限し、その射を保持する。
- 階数、種数、構造的次数を不変に取り出し、所定の同値の下で保存されることを証明する。
- 形式的な極次数の総量を Katz 不変量と比較する：整数 r に対して m = r + 1、階数 2 で正の半整数 r に対して m = r + 3/2。
- 例外的な対数指数も含め、各パラメータ基底上で非空性と除外する判別集合を明示する。

**検証事項**

- 四つの対数点の極次数の総量は 1 + 1 + 1 + 1 = 4 であり、この複雑度クラスに属する。
- 五つの対数点では相空間の次元は 2·5 − 6 = 4、三つでは 2·3 − 6 = 0 である。いずれも二次元の Painlevé 入力ではない。
- Katz 傾き 1/2 の二つの分岐点では、極次数の総量は 2 + 2 = 4 である。傾きを整数に限定すると、この入力が失われる。
- 相空間のある点で対数留数が消えても、構造的次数は変わらない。実際の非零の極から総量を計算し直すと、その点を誤って除いてしまう。

*必要な先行結果：* 内部依存：3.1, 3.2.

<a id="target-3-4"></a>
### 3.4 形式的プロファイルと時間正規化の分類

**パンルヴェへの適用。**

**入力条件**

- §3.3の入力に、その許容された一般的位置の射影的局所型と、実際の縮約された形式データの変形問題を備える。極のラベルを保持する。プロファイルの個数、自己同型の固定部分群の計算、および縮約された時間の1次元性は、仮定ではなく結論である。

先頭項の非退化性と縮約された変形に関する仮定を保持し、構造的次数 4 の許容される階数 2 の形式的プロファイルを分類する。まず極のラベルの順序を忘れた基礎プロファイルを分類する。すなわち、4 の分割と、各不確定部分における整数または半整数の一般的局所傾きを列挙する。これにより十個の基礎プロファイルが得られる。ラベル付与の亜群を通じて、元の順序付き入力を復元する。置換はラベル付き表示の間の添字付け替えによる同値を誘導するが、元の亜群におけるラベルを保存する射ではない。順序付き傾きプロファイルは十七個あり、極の数が一、二、三、四の場合の個数はそれぞれ 2、8、6、1 である。これに対応する順序を忘れた個数は 2、5、2、1 である。これは形式的プロファイルの形の個数であって、連続的な指数パラメータを備えた対象の個数ではない。

ラベルを保存する許容された曲線座標変換で割った後、どのラベル付き実現も本質的な時間パラメータを一つもつことを証明する。極が n 個の表示における次元計算は n + Σ⌈rᵢ⌉ − 3 = Σmᵢ − 3 = 1 であり、自己同型の固定部分群と、選択した標識・スライスを明示的に確認する。行列式の正規化とその移送は、必要な射影的方向を取り除かず、スカラー不確定方向も加えない。十個すべての基礎表示とすべてのラベル付与について、この行列式の正規化が可能であることを証明する。§7.2 の表は基礎プロファイルの表であり、その座標公式はラベルの添字付け替えによる同値に沿って移送する。（VDPS09, §2.2, Table 1, printed pp.18–19.）

よく知られた時間領域は、表示に用いる標識と正規化を固定した後にのみ導く。具体的には、四点の複比基底、乗法的な形の時間チャートに対する非零の不確定時間、および多項式チャートに対するアフィン時間である。これらは内在的な時間問題のチャートまたは標識被覆であり、力学系の六通りの定義ではない。この分類は上記の階数 2 の形式的複雑度に限定され、あらゆる二次元非自律系を分類するものではない。

**検証事項**

- 順序付き組 (1,0,0) と (0,1,0) に対応する極次数は (2,1,1) と (1,2,1) である。基礎プロファイルは同じであるが、ラベルを保存する射によっては同一視されない。
- 4 の順序付き分割を、部分 1 に一つ、それより大きい各部分に二つの局所型を割り当てて列挙すると、2 + 8 + 6 + 1 = 17 になる。順序を忘れると 2 + 5 + 2 + 1 = 10 になる。
- ラベルの置換は極次数の総量と時間の次元を保存するが、留数パラメータと複比チャートを移送する。表示されたすべての座標をそのままにするわけではない。

*必要な先行結果：* 内部依存：3.1, 3.2, 3.3; [Formal scalar and vector-valued Laurent algebra](#dependency-formal-series) (L1–L4; L5–L6 for finite-extension steps in 1.1).

#### 例

傾き 5/2 の分岐を伴う極が一つの場合、構造的次数は 4 であり、三つの不確定係数は二次元アフィン座標群で割ることで一つの本質的時間に縮約される。傾き 1 の不分岐な極が二つの場合には、不確定係数が二つ、残るスカラー倍が一つあり、やはり一つの時間が残る。これらはスカラー Painlevé 方程式を一つでも導入する前の、入力型に関する計算である。

#### 依存関係

各目標の「必要な先行結果」と `design/reuse_registry.json` の枠組み間参照を用いる。一般証明の前提は独立したパッケージに置き、この層では指定した適用比較を確認する。

<a id="target-3-5"></a>
### 3.5 パンルヴェ方程式の安定モジュライ

**パンルヴェへの適用。**

**入力条件**

- 古典的入力 3.3 を用いる。表現する族を仮定せず、一般の安定モジュライ構成の正確な仮定を確認する。

§3.3 に MeromorphicConnectionModuli §1.3 を適用する。行列式・安定性・局所モデルの許容条件を古典的入力について確認し、その出力を古典的な全安定モジュライ問題と同定する。有界性は一般構成から得る。スタック、剛化、粗モジュライ族、普遍対象をもつエタール被覆は、一般構成から得られたものを用いる。許容されるすべての束の型と、剛化前の実際の μ₂ 固定部分群を保持する。各古典的枠付きチャートが表す局所閉部分または開部分との比較を、この適用側で担う。balanced なチャートを全モジュライ空間の代わりにしない。（I23, Theorem 5.1.）

**構成・法則（API）**

- 射と行列式の同定を含め、古典的モジュライ関手を一般関手の制限と同定する。
- 各枠付きチャートの包含・補集合・重みの部屋に共通する安定部分を確認する。

**検証事項**

- 安定対象にも、剛化前にはスカラー自己同型がありうる。すべての固定部分群が自明であったと主張する集合値の商は、この例に適合しない。
- 束の跳躍により、族が自明束のチャートから外れても、モジュライ空間内にはとどまりうる。この理由でその相軌道を特異としない。
- 拡大族 0 → O(−1) → E_t → O(1) → 0 では、E₀ = O(−1) ⊕ O(1) である一方、t ≠ 0 では E_t = O ⊕ O である。二つの分裂型の層の引戻しは A¹ 内の {0} とその補集合であり、前者は開ではない。接続モジュライ全体は、許容される接続の範囲でこのような束の跳躍を保持しなければならない。
- 一般的な分岐局所因子は既約であるため、大域的な ∇-不変直線部分束は存在せず、どの重みに対しても安定である。これは I23 Remark 2.9 の内容であり、あらゆる特殊解が存在しないという主張ではない。

*必要な先行結果：* 内部依存：3.3, 1.3.

<a id="target-3-6"></a>
### 3.6 変形複体とトレースペアリング

**パンルヴェへの適用。**

**入力条件**

- 3.5 の族、行列式、および局所構造を用いる。接空間・障害との同定は、確認した比較を通じて一般構成から得る。

MeromorphicConnectionModuli §1.4 を、§3.5 の行列式を固定した族へ特殊化する。古典的な無限小の族とゲージが、そのコサイクルとコバウンダリーに対応することを証明する。分岐を伴う実際の三項錐複体と、ℂ 線形微分作用素・Čech 構成を用いる。交換子微分を O 線形写像に置き換えず、擬同型を証明する前に錐複体を切り詰めない。同じ複体上で行列式制限とトレースの符号規約を確認する。（I23, equation (6.9), Propositions 6.3 and 7.2.）

**構成・法則（API）**

- 行列式を固定する接方向を含め、一般の錐複体との制限比較を構成する。
- この比較の下でゲージ・トレースの符号・局所表示の両立性を確認する。

**検証事項**

- u による無限小ゲージ変換は、接続の代表元を u の交換子微分だけ変える。その接空間での類は 0 である。
- 行列式の同定を指定しない場合、スカラーには無限小自己同型の方向がある。標数 0 でその同定を固定すると、この方向は除かれるが、有限の固定部分群 μ₂ は剛化するまで残る。
- ω = dq ∧ dp の下では、順序付き接ベクトル対 (∂q, ∂p) のペアリングは +1、逆順では −1 である。トレースの規約が逆の場合、移送公式を用いる前に補正しなければならない。

*必要な先行結果：* 内部依存：3.5, 1.4.

<a id="target-3-7"></a>
### 3.7 相空間のシンプレクティック構造

**パンルヴェへの適用。**

**入力条件**

- 古典的族と一般変形構成との比較を用いる。滑らかさ、二次元性、シンプレクティック形式は結論である。

§§3.5–3.6 で同定した族と複体に MeromorphicConnectionModuli §§1.5–1.6 を適用する。行列式ファイバーとの比較を確認する。種数 0 では除き忘れた Jacobian 方向はない。許容される一般次元定理に g = 0、r = 2、deg P = 4 を代入すると 2 が得られる。滑らかさ・非退化性・相対閉性は出力である。補助的有限平坦展開変形、単純接続モジュライ、一般部分での二つの対数的擬同型、滑らかな族での稠密性の議論は、合流定理に先立って一般枠組みで一度証明する。ここでは、その中心安定ファイバー・複体・形式を、許容される非被約基底変換も含めて、実際の古典的族と同定する。目標9.5–9.8は用いない。（I23, Theorems 7.5 and 8.1, Propositions 8.2–8.3.）

**構成・法則（API）**

- 一般定理の特殊化に必要な、行列式固定と中心ファイバーの比較を確認する。
- 同じ相対接束とシンプレクティック形式を古典的族全体に提供する。

**検証事項**

- 種数 0、階数 2、次数 4 では −8 + 2 + 8 = 2 となり、構造的次数を 5 に変えると 4 になる。
- 正の種数で行列式を固定すると、行列式写像との比較を適用できる場合には 2g 個の方向が除かれる。種数 0 での一致をそのまま一般の場合に持ち出さない。
- 恒等的に消える交代ペアリングは閉じているが、シンプレクティックではない。非退化性は実際の双対性計算から導かなければならない。
- r = 1、g = 1 では、行列式を固定しない公式は 2 を与え、線束上の接続全体を固定すると 0 になる。誤って 2 を与えてしまう階数 0 の入力は、定義域の外にある。
- r = 2、局所次数 2、q₁ = 2 の場合、展開変形の方程式は (z − 2h²)(z − h²) である。h = 0 でのファイバーは z²、h = 1 では (z − 2)(z − 1) であり、h² を法として考えると再び z² になる。この族を固定された互いに異なる切断と同一視せず、中心ファイバーと引戻し後の複体・形式を確認する。

*必要な先行結果：* 内部依存：3.3, 3.5, 3.6, 1.5, 1.6.

<a id="target-3-8"></a>
### 3.8 相空間の例外層

**パンルヴェへの適用。**

**入力条件**

- 固定した局所条件で許容される、安定な共鳴・可約・見かけの特異点の各層をすべて含め、一般的位置の分岐局所モデルの既約性を用いる。

固定された局所モジュライ条件が許す w-安定な対数的共鳴、可約接続、見かけの特異点の層を、この構成がすべて保持することを証明する。局所フィルトレーションが重複固有値の曖昧さをどのように解消するかを記述する。非空性は別に記録する。一般的な分岐点では、そこに可約対象を作り出すのではなく、既約性定理を用いる。目標4.1–4.4では、すでに構成されたこれらの層の指標空間内での像を同定する。不確定部分の先頭係数が消えると入力の層が変わるので、§7.3 と目標9.5–9.8で扱う。（I23, §2 and Remark 2.9; IIS06, §4, especially Theorems 4.10–4.12; VDPS09, §2.2 and §3.）

*必要な先行結果：* 内部依存：3.1, 3.5, 3.6, 3.7.

#### 例

種数 0・階数 2 では、次元計算は −8 + 2 + 2·4 = 2 となる。相空間のアフィンチャートには座標 (q,p) があるが、そのチャートから欠けている点も正当な初期条件である。共鳴因子上では、異なる放物的初期点が同じ粗モノドロミー指標をもちうる。相空間はそれらを保持しなければならない。

#### 依存関係

各目標の「必要な先行結果」と `design/reuse_registry.json` の枠組み間参照を用いる。一般証明の前提は独立したパッケージに置き、この層では指定した適用比較を確認する。

<a id="target-3-9"></a>
### 3.9 パンルヴェ方程式の等モノドロミー接続

**パンルヴェへの適用。**

**入力条件**

- 構成済みの古典的モジュライ・時間問題を用いる。その局所構造と行列式の移送が、強い拡張の契約を満たすことを確認する。

古典的時間問題と目標3.5–3.8の族に MeromorphicConnectionModuli §2.1 を適用する。核格子・対数的旗・分岐降下を含め、一般構成の強い拡張を古典的な普遍対象のチャートと同定する。全空間での極のクラスは Ω¹_X(log D) ⊗ O_X(P − D) である。動く座標での生成元 dz/zᵐ と dε/zᵐ⁻¹ は比較補題として得られ、対数極では時間係数が正則になる。強い拡張の存在・一意性・貼合せを一般構成から得て、NonlinearConnections §0.1 の同じ分裂 h を得る。この目標では h を仮定せず、指定されたスカラー方程式から逆算しない。（I23, Definition 10.1, Propositions 10.7 and 10.10.）

**構成・法則（API）**

- 古典的な核格子と動く極のフィルトレーションを、一般の強い拡張クラスと比較する。
- 接分裂、その線形性と基底変換を、接続対象を別に作らず同定する。

**検証事項**

- 零の時間接ベクトルの持上げは零である。任意の垂直ベクトルを加えると、可積分拡張の一意性に反する。
- 時間接ベクトルを 2 倍するとその持上げも 2 倍されるが、時間座標を 2t に変えると正規化された生成元は 1/2 倍される。
- 非零の時間接ベクトル上では、零写像は分裂にならない。dπ ∘ 0 = 0 ≠ id だからである。

*必要な先行結果：* 内部依存：3.2, 3.5, 3.6, 3.7, 2.1, 0.1.

<a id="target-3-10"></a>
### 3.10 等モノドロミー接続の平坦性

**パンルヴェへの適用。**

**入力条件**

- 3.9 で同定した強い分裂と、一般の二パラメータ拡張問題の制限比較を用いる。

MeromorphicConnectionModuli §2.2 と §3.9 の同定により、古典的族上で h([v,w]) = [h(v),h(w)] を得る。二パラメータの強い拡張の比較が、この時間問題へ制限できることを確認する。一般の混合項の証明を形式プロファイルごとに繰り返さず、解析的 Stokes 定理やスカラー方程式を前提としない。（I23, Theorem 11.6.）

**構成・法則（API）**

- 混合拡張の制限比較を確認し、括弧恒等式を提供する。

*必要な先行結果：* 内部依存：3.9, 2.2.

<a id="target-3-11"></a>
### 3.11 シンプレクティック移送と全二形式

**パンルヴェへの適用。**

**入力条件**

- 構成した相対形式と分裂、およびモジュライのシンプレクティック保存定理の特殊化を用いる。平坦性から保存を推測しない。

まず MeromorphicConnectionModuli §2.2 の実際のシンプレクティック保存定理を特殊化する。平坦性だけから保存を導かない。次に (π,h,ω) に NonlinearConnections §0.6 を適用し、閉じた全二形式 Ω(v,w) = ω(v − h(dπv), w − h(dπw))、その核と移送の法則を得る。この形式を古典的族上の形式と同定し、別の Hamilton 対象を作らない。Darboux・時間チャートと局所完全性を確認した後に、座標表示 dq ∧ dp + dH ∧ dt を得る。（I23, Definition 11.4 and Corollary 11.8.）

**構成・法則（API）**

- 取り込んだ相対形式・全形式と水平核を同定する。
- 指定された局所チャートを選んだ後に、Hamiltonian の符号と時間依存座標変換を確認する。

**検証事項**

- H = p²/2 の場合、dq ∧ dp + p dp ∧ dt と ∂t + p∂q の内部積は零である。符号を逆にすると零にならない。
- H と H + t² は同じ垂直ベクトル場と拡張二形式を与えるが、スカラー関数としては異なる。
- シンプレクティックなファイバー上では、Ω の核に非零の垂直ベクトルは存在しない。ω を零に退化させると、この特徴づけは成り立たない。

*必要な先行結果：* 内部依存：3.7, 3.9, 3.10, 2.2, 0.6.

<a id="target-3-12"></a>
### 3.12 等モノドロミー接続の基底変換と表示独立性

**パンルヴェへの適用。**

**入力条件**

- 一般構成の古典的制限として確認された対象と、実際の表示変更の射を用いる。

MeromorphicConnectionModuli §§2.3–2.4 を用い、目標3.1–3.12の対象を、一つの一般構成の古典的制限として同定する。表示・ゲージ・許容基底変換の比較を整合的に保持する。古典的な標識と時間切片についてコサイクル図式を確認する。ラベル・行列式・安定性の部屋の変更は、定義域を指定した射または対応として扱う。後の座標辞書はこの構成と可換でなければならず、力学系の別の定義にはしない。

**構成・法則（API）**

- 古典的特殊化の可換図式と三重重なりの整合性を証明する。
- 取り込んだ構造を一つのモジュライ族と一つの非線形接続上に保持する。

*必要な先行結果：* 内部依存：3.1, 3.2, 3.5, 3.9, 3.10, 3.11, 2.3, 2.4.

#### 例

Hamilton チャート H = p²/2 − 2q³ − tq は水平核を表すが、核はこの公式なしに構成する。H を H + c(t) に置き換えても核は保たれる。標識の変更はパラメータ付きの族に作用するのであって、入力亜群から標識を消すものではない。

#### 依存関係

各目標の「必要な先行結果」と `design/reuse_registry.json` の枠組み間参照を用いる。一般証明の前提は独立したパッケージに置き、この層では指定した適用比較を確認する。

<a id="layer-4"></a>

## レイヤー4：Riemann–Hilbert 比較とパンルヴェ性

<a id="target-4-1"></a>
### 4.1 扇形局所系と分岐を伴う解析的降下

**パンルヴェへの適用。**

**入力条件**

- 許容された階数2の良い形式型、共鳴する対数的格子のデータ、および有限分岐被覆と被覆変換の作用を入力とする。

共鳴する対数格子と旗を保持し、形式的次数付きデータ、扇形解、Stokes 遷移写像による、許容された局所有理型接続の解析的分類を構成する。扇形上の存在、重なり上の一意性、コサイクル恒等式、許容される時間パラメータへの解析的依存性を証明する。分岐点では有限被覆上で構成を行い、指数因子に対する被覆変換による置換も含め、同変な降下を証明する。形式 Laurent 級数による分類だけでは、これらの解析的主張は証明されない。（I23, §9, Theorem 9.7 and Corollary 9.11; BOA01, §§3–6; HEU10, §2; BY15, Remark 3 and Definitions 7 and 13.）

**構成・法則（API）**

- 解の扇形への制限、細分化、扇形的正規化の変更を構成する。
- 実際の局所解析的接続を復元し、付加構造付き対象に対する充満忠実性を証明する。
- 対数的な場合、不分岐の場合、分岐を伴う場合の記述を、共通の降下の言葉で比較する。
- 指定した局所的な範囲で、可積分な時間拡張と、これらのデータの強い局所定常性が同値であることを証明する。

**検証事項**

- 階数 1 の指数関数 exp(1/z) は、通常のモノドロミーが自明でも不確定特異的な増大を示す。通常のモノドロミーだけでは、この対象を分類できない。
- 非自明な冪単対数モノドロミー行列は、二つの固有値がともに 1 でも、単位行列とは異なる。
- 二次被覆上では、z を一周させると二つの形式的指数の枝が交換される。被覆変換の作用を入れずに各枝が個別に元に戻るとする扇形構成は、降下を満たさない。

*必要な先行結果：* 内部依存：3.1, 3.2, 3.9, 3.10, 1.1; [Complex manifolds, holomorphic bundles and observations](#dependency-complex) (K1; K3.0; K3.HolomorphicStalk; K3.MeromorphicGermField; K4; K7.1).

<a id="target-4-2"></a>
### 4.2 Betti 族と完備な移送

**パンルヴェへの適用。**

**入力条件**

- §3.2の許容された標識付き時間変形問題上の§4.1の局所解析データ、保持された指数の持ち上げ、および固定された閉じたスペクトル・行列式条件を入力とする。特異なアフィン商も許す。分岐を伴う族のイソトピー、降下、および完備な平行移動は出力である。

確定特異な部分圏では MeromorphicConnectionModuli §2.5 を用い、その標識付き Betti 族がこの目標の族と一致することを確認する。不確定特異点と分岐を伴う移送の拡張は、以下に範囲を明示した証明課題として残る。

§4.1 の局所データを穴あき曲線上の大域的局所系と貼り合わせて、一般化モノドロミー亜群を構成する。対数格子と旗を備えた付加構造付き亜群と、それらの付加構造を忘れて得られる通常のアフィン指標商を区別する。通常の商には、スペクトル不変量と行列式に関する閉条件を課し、指数パラメータ θ をファイバー積の別の座標として保持する。共鳴時に、閉じていない一つの Jordan 共役類を固定してはならない。指定スペクトルをもつスカラーの層と許容される冪単の層の両方を残す必要がある。Stokes 扇形表示の変更も含め、許容される標識付き変形に沿って局所定常な移送を構成する。合成と逆の法則、および Bθ 内のすべてのコンパクトな道に沿う完備性を証明する。指標ファイバーは特異でもよい。そこでの移送は滑らかな接束の分裂を仮定して定めるのではなく、亜群・位相的構成によって定める。（VDPS09, §§1–3; BOA14, §10, Theorem 10.2; BY15, Proposition 19, Theorem 21 and Corollary 22.）

引用した BOA14 の族の移送定理は、捻りのない場合を対象とする。その同位変形の構成を、BY15 の階数 2 の分岐を伴う対象に拡張する。その際、指数被覆、次数付け、被覆変換の作用を保持し、Stokes 亜群の間に被覆変換と両立する同値を構成し、フレーム付けの作用と閉じたスペクトル条件を降下させる。コンパクトな道に沿って局所積を連結する前に、独立性、合成との両立性、ホモトピーとの両立性を証明する。BY15 の準 Hamilton・Poisson 定理だけでは、この族の移送定理は得られない。

**構成・法則（API）**

- 制限、貼合せ、ゲージ共役、標識変更の関手を構成する。
- 付加構造付き亜群、その圏論的商、および商が個々の軌道を表す部分を区別する。
- 単連結な許容時間近傍上での局所積表示と、有限個の近傍の鎖に沿うその延長を証明する。
- 粗商上の完備な移送と、必要な付加構造空間上へのその持上げを定義する。

**検証事項**

- θ と θ + 1 は同じ指数化された固有値を与えるが、同じ対数格子を与えるとは限らない。比較先には θ を保持する。
- 可約表現とその半単純化は、同じ粗指標をもちうる。商を、すべての接続対象の忠実な符号化とはしない。
- 非自明なループに沿う移送は、ファイバーに非自明に作用しうる。完備性はモノドロミーが自明であることを意味しない。

**本目標が担う補助構成。**

- 2.5 は 1.3 の不変式論を用いて有限型表現多様体と簡約群によるアフィン共役商を構成し、1.2 の解析化を適用して特異点を含む Hausdorff 性・局所コンパクト性・標識付き積移送を証明する。4.2 は wild/Stokes のフレーム亜群と、実際に簡約群商または降下が正当化される各段階の商を構成する。局所 Stokes 群が冪単であることから任意の GIT 商を推論しない。根・被覆変換を保つ isotopy、分岐降下、安定化群との両立、全層での正則写像を証明する。SSF1.17 をこれらの構成の代用にしない。

*必要な先行結果：* 内部依存：3.2, 4.1, 1.3, 1.2, 2.5; [Quotient predicates](#dependency-quotient-predicates) (1.17); [Covering spaces and universal covers](#dependency-covers) (Stage 0.2–0.4; Stage 1.5; Stage 2.6–2.8); [Smooth bundle and connection foundations](#dependency-smooth) (B1.5; B5.0; B5.2).

<a id="target-4-3"></a>
### 4.3 相空間全体上での Riemann–Hilbert 対応と両立性

**パンルヴェへの適用。**

**入力条件**

- §3.5・§3.8の安定モジュライ族全体、目標3.9–3.12の強い分裂、および§§4.1–4.2の付加構造付き解析的再構成とBetti族を入力とする。正則降下と、始域全体での水平性の適合は証明すべき事項である。逆写像は、指定した既約・非共鳴部分でのみ主張する。

確定特異な RH 写像と全点での水平両立性には、同じ放物的モジュライと留数パラメータを保持した標的を同定した後に、MeromorphicConnectionModuli §2.5 を用いる。この利用によって不確定特異点の局所再構成が不要になるわけではない。

解析的分類により Bθ 上の RHθ: Mθᵃⁿ → Rθ を構成し、正則性を証明する。これが、共鳴、可約、例外的な部分の内部にある軌道も含め、§3.9 のすべての水平軌道を §4.2 の移送に送ることを証明する。指定した安定既約・非共鳴の開部分では逆の比較を証明する。それ以外では単射性を主張せず、実際のファイバーと付加構造のデータを記録する。可積分拡張の構成と局所解析的復元を比較し、普遍対象をもつ被覆から降下させる。（IIS06, Theorems 4.10–4.12; IS12, Theorem 5.1; I23, §9 and §11.）

定理がすべての層を含むこと自体が構成目標である。一般的な不分岐の場合の定理は、その入力の一つであって、まだない共鳴または分岐の場合の比較を代替するものではない。これらの部分を越えて拡張する際に、スカラー方程式は用いない。

**構成・法則（API）**

- 普遍対象をもつ被覆から正則な RH 写像を構成し、降下と基底変換に関する自然性を証明する。
- 付加構造付きの局所復元と、付加構造を忘れる通常の指標商を比較する。
- 保持されたすべての点で水平性との両立を証明し、逆写像の定理は指定した開部分でのみ証明する。

**検証事項**

- 例外ファイバー上の異なる二点が同じ通常の指標をもちうる。逆写像としてその一方を選ぶ構成にしてはならない。
- 共鳴する対数点では、固有値が等しいからといって、許容されるスカラーの層または冪単の層のいずれかを削除してはならない。
- 指数の持上げを保持することで、通常の指数化された固有値が等しくても θ と θ + 1 を区別する。

*必要な先行結果：* 内部依存：3.5, 3.8, 3.9, 3.10, 4.1, 4.2, 1.2, 2.5.

<a id="target-4-4"></a>
### 4.4 古典的入力クラス全体に対する固有な比較

**パンルヴェへの適用。**

**入力条件**

- 指数の持ち上げと閉じた指標条件を保持した、許容される古典的時間・パラメータ族全体に対して§4.3で構成したRH写像、および許容される安定な始域のすべての層を入力とする。格子の一様有界性、付加構造の延長、安定な対象への置換、コンパクト集合内への包含、および相対固有性は仮定しない。その証明はこの項目の担当である。

四つの対数極の分岐では、2·4 − 2·2 − 2 = 2 > 0 と行列式固定・標識の比較を確認し、MeromorphicConnectionModuli §2.6（I13, Theorem 2.2）を適用する。この文献はファイバー積によって指数パラメータを保持する。この確定特異な定理から一般の不確定特異点での固有性を推測せず、以下の古典的全クラスへの拡張は明示的証明課題として保持する。

許容された次数 4・階数 2 の各入力と、許容されるすべての指数パラメータについて、§3.5 の安定モジュライ空間全体上で、比較先に指数の持上げを保持した RHθ が、時間族全体の写像として固有であることを証明する。許容パラメータチャート上で対応する族の主張を確立する。各固定時刻の写像の固有性だけでは足りない。比較先は、固定された閉条件を備えた通常の一般化指標データをもち、解に依存する開部分を取り除かない。実現可能な成分への全射性は、固有性と分けて述べる。対象範囲には、共鳴する対数点、安定な可約点、および古典的クラスを定義する一般的な分岐局所構造を含める。（IIS06, Definition 2.11 and Theorems 4.10–4.12; IS12, Theorem 5.1 and the scope warning of Remark 6.3; HEU10, Theorem 1.1.）

必要な拡張は、この節が責任をもって証明する。証明を次の四つの具体的な中間結果を通じて進める：指数の持上げを固定した一般化指標のコンパクトな族にわたる、局所格子の一様有界性；閉じた入射条件をもつ相対射影パラメータ空間内での、保持された旗と因子分解構造の拡張；必要な基底変換と基本変換の後の半安定なものへの置換、それに続く選択した重みに対する半安定 = 安定、および分離的モジュライ問題における一意性；これらの拡張と大域的貼合せおよび解析的モジュライ位相との両立性。安定性は開条件であるが、そのことだけで任意の極限に保存されるわけではない。単にファイバーが閉じていることや各点での可解性を示すのではなく、これらの結果からコンパクト集合の逆像がコンパクトになることを確認する。台となる接続自体も逃走しうるため、射影旗多様体だけではこの定理を証明できない。

HEU10 の普遍的な強いモノドロミー保存変形は、§4.6 の延長の結論に至る別の経路となる可能性がある。その経路では、時間基底の同定、局所付加構造の拡張、行列式と安定性の保存、束の跳躍との両立性、降下、および §3.9 との一致を確立しなければならない。それだけでは、この目標で必要な固有性は証明されない。I23 の大域的葉層構造の定理や IS12 の一般的位置での定理も、この証明を代替しない。コンパクト性定理は、明示的な内部の証明構築課題として残す。

*必要な先行結果：* 内部依存：3.5, 3.6, 3.7, 3.8, 4.1, 4.2, 4.3, 1.3, 2.6; [Quot/Hilbert and parameter schemes](#dependency-quot) (4.14); [Native topological properness](#dependency-proper) (IsProperMap).

#### 例

例外的 RH ファイバーは射影曲線でありうる。その上で選んだ一点も初期条件であり、それ自身の水平持上げをもつ。粗 RH 写像の逆を任意に取ると、この情報が失われる。自明束のチャートでは、孤立した時刻で強い Riemann–Hilbert 問題が解けなくなっても、束上の接続全体としては延長できることがある。

#### 依存関係

各目標の「必要な先行結果」と `design/reuse_registry.json` の枠組み間参照を用いる。一般証明の前提は独立したパッケージに置き、この層では指定した適用比較を確認する。

<a id="target-4-5"></a>
### 4.5 正則水平切断の局所存在

**パンルヴェへの適用。**

**入力条件**

- 構成した正則平坦分裂と許容パラメータ・チャートを用いる。解作用素を入力にしない。

§§3.9–3.10 で実際に構成した正則平坦分裂に NonlinearConnections §0.3 を適用する。幾何学的パンルヴェ芽は、その同じ水平切断の芽に初期点を指定したものである。評価の全単射、局所一意性、パラメータへの正則依存性は一般定理の出力である。目標3.1–3.4の許容パラメータ・チャートが同時正則性の仮定を満たすことを確認する。解析的な存在とパラメータ依存性の証明は 0.3 が担う。

**構成・法則（API）**

- 族の同時正則性の仮定を確認し、幾何学的パンルヴェ芽を一般の切断の芽と同定する。
- 一般の評価全単射と自然性を、実際の古典的ファイバーに適用する。

**検証事項**

- 直積分裂を備えた π: B × F → B では、水平切断は b ↦ (b,x₀) であり、任意の写像 B → F ではない。
- 切断は dπ ∘ ds = id を満たさなければならない。全空間への定値写像は、定値ではない時間近傍上の切断にはならない。
- 正則ベクトル場 q′ = q² と初期条件 q(0) = 1 に対する局所解は 1/(1 − t) である。局所存在だけでは、t = 1 を越えるアフィン相空間チャート内での延長は従わない。

*必要な先行結果：* 内部依存：3.9, 3.10, 0.3.

<a id="target-4-6"></a>
### 4.6 固有な半共役による古典的力学系の完備性

**パンルヴェへの適用。**

**入力条件**

- 目標4.1–4.4で証明した実際の古典的 RH 比較、完備な標的移送、全点での部分持ち上げとの両立性、および固有性を用いる。源の完備性は結論である。

構成済みの相空間族に NonlinearConnections §0.4 を適用する。その連続時間の局所 ODE とコンパクト延長の基礎は 0.2 にある。§4.2 の完備な標的移送、§4.3 の許容されるすべての点での部分水平持ち上げとの両立性、§4.4 の相対固有写像を確認する。任意の許容 θ、初期時刻 b₀、点 x₀ ∈ Mθ,b₀、および b₀ から始まる Bθ 内のコンパクトな区分的 C¹ 経路に対し、一意な水平持ち上げを得る。標的は特異でもよく、例外ファイバーを保持する。RH の局所逆写像や π の固有性は必要ない。一般のコンパクト閉じ込めの証明は NonlinearConnections に置き、ここでは古典的な仮定の検証と、その結果である幾何学的パンルヴェ性を担う。選んだスカラー観測量の極によって許容基底を変更しない。

**構成・法則（API）**

- 例外ファイバーを含め、一般の固有移送定理の仮定を確認する。
- どのスカラーチャートからも独立に、すべての初期点とコンパクト経路についての結論を提供する。

**検証事項**

- y′ = y², y(0) = 1 に対して、M = ℂ_t × ℂ_y から完備な標的の時間直線への射影は整合的だが固有ではない。t ∈ [0,1) に沿って y = 1/(1 − t) であり、t = 1/2 と 3/4 での値はそれぞれ 2 と 4 だが、1 では有限値を持たない。したがって、F の固有性を単なる連続性や射影との整合性で置き換えることはできない。
- 自明な族上で F が恒等写像であり、ファイバー上の平行移動が定値である場合、固有写像による移行は一意な定数ファイバー座標を与える。例外曲線を持つ固有ファイバーの場合、コンパクト集合内への閉じ込めの議論はそのコンパクトな逆像を用い、F の逆写像を選ぶことはない。
- [0,1] 上の底空間の道 γ(s) = |s − 1/2|³ᐟ² は C¹ だが、γ′ は 1/2 で C¹ ではない。定数分裂によるその持ち上げは、時間連続の場合の局所定理の正当な入力である。自律化したベクトル場が C¹ であることを要求する証明は、根拠のない追加仮定を課してしまう。

*必要な先行結果：* 内部依存：4.2, 4.3, 4.4, 4.5, 0.4.

<a id="target-4-7"></a>
### 4.7 古典的移送、普遍被覆上の切断と降下

**パンルヴェへの適用。**

**入力条件**

- シンプレクティック保存を証明した、実際の完備平坦な古典的接続を用いる。その亜群作用は一般構成の出力である。

§3.10 の平坦性と §4.6 の完備性に NonlinearConnections §0.5 を適用する。一般構成により、実際の終点移送、基本亜群の作用、各古典的初期点を通る普遍被覆上の水平切断を得る。モノドロミー作用を入力として仮定せず、構成された接続の作用と同定する。シンプレクティック保存には §3.11 と NonlinearConnections §0.6 を用いる。得られた被覆変換・モノドロミー作用で初期点が固定される場合に、ちょうど降下する。完備性だけから Bθ 上での一価性を導かない。

**構成・法則（API）**

- 一般構成の移送と普遍被覆上の切断を古典的モジュライ族上で同定する。
- 表示の両立性と、降下に必要な実際の固定条件を確認する。

**検証事項**

- 道を進んだ後にその逆向きの道を進むと、例外点を含むすべての初期条件上で恒等写像を得る。
- B = ℂ× 上で H = qp/(2t) とすると、方程式は q′ = q/(2t), p′ = −p/(2t) である。π₁(B) の正の生成元は (q,p) を (−q,−p) に送り、そのようなループを 2 回たどると恒等写像になる。シンプレクティック乗数は (−1)(−1) = 1 である。一方、自明な平行移動として実装すると、最初のループの結果が誤る。
- このモデルでは、生成元で固定されるのは原点だけである。それ以外の各初期点は、普遍被覆上では完備な切断を与えるが、B には降下しない。完備性だけでは降下には不十分である。

*必要な先行結果：* 内部依存：3.10, 3.11, 4.6, 0.5, 0.6.

<a id="target-4-8"></a>
### 4.8 パンルヴェ相空間上の観測量

**パンルヴェへの適用。**

**入力条件**

- 古典的相空間族と、候補となる観測量・定義域を用いる。不定性の回避と必要な持ち上げは証明課題である。

古典的相空間族上で NonlinearConnections §0.7 の観測量の概念を用いる。主張する各古典的 ℙ¹ 値射、または有理写像の定義域と解消・持ち上げの比較を、この適用側で構成する。主張する解の各層に沿って引戻しが定義されることを証明し、恒等的に ∞ となる場合を除いてからスカラー有理型関数と呼ぶ。観測量、その定義域、正規化を明示的データとして保持する。一般の評価定理だけでは、これらの適用固有の検証は得られない。

**構成・法則（API）**

- 実際の古典的観測量を構成し、引戻し・持ち上げの定義域を確認する。
- 一般の観測量の自然性を用い、正規化と重なりの写像を比較する。

**検証事項**

- Q ≡ ∞ は至る所定義された ℙ¹ 値観測量であるが、孤立した極を持つ通常の有理型関数を与えない。
- ℂ² 上の有理写像 [x:y] は定値曲線 (0,0) 上で定義されない。有理性だけでは、すべての解に沿う引き戻しは定義されない。
- 無限遠チャートでは、Q(t) = 1/t は 1/Q(t) = t となり、0 で正則である。この極はチャート上の現象であり、幾何学的な延長の破綻ではない。

*必要な先行結果：* 内部依存：4.5, 4.7, 0.7.

<a id="target-4-9"></a>
### 4.9 古典的時間曲線上の有理型評価

**パンルヴェへの適用。**

**入力条件**

- 証明済みの時間曲線の次元、完備な水平切断、および引戻しと非恒等的無限大条件を確認した観測量を用いる。

§3.4 の時間一次元性という結論を確認し、§§4.7–4.8 に NonlinearConnections §0.7 を適用する。恒等的に ∞ ではないと確認した各スカラー評価は、許容時間曲線の普遍被覆上で有理型となり、内部のスカラー特異点では有限位数の極をもつ。主張するすべての層についての観測量の解消と不定性回避は、§4.8 の適用側の課題である。一価な降下条件は別に述べる。一つの内在的定理を座標比較へ移し、六つのスカラー延長定理を別々には証明しない。

**構成・法則（API）**

- 確認した古典的観測量の定義域に限って、有理型評価定理を提供する。

*必要な先行結果：* 内部依存：3.4, 4.7, 4.8, 0.7.

#### 例

アフィン方程式 q′ = q² は、q(0) = 1 に対して t = 1 に可動極を持つ。その射影ベクトル場は、u = 1/q では u′ = −1 として延長される。これにより、アフィン座標での脱出と幾何学的な延長が区別される。B = ℂ* 上では、水平系が普遍被覆上で完全に延長できながら、0 の周りに非自明なモノドロミーを持つことがある。これは定理に矛盾しない。

#### 依存関係

各目標の「必要な先行結果」と `design/reuse_registry.json` の枠組み間参照を用いる。一般証明の前提は独立したパッケージに置き、この層では指定した適用比較を確認する。

<a id="layer-5"></a>

## レイヤー5：初期値空間・対称性・Riccati 簡約

<a id="target-5-1"></a>
### 5.1 加法型岡本–パンルヴェ対

**パンルヴェへの適用。**

**入力条件**

- 滑らかな有理射影曲面、有効な反標準因子Y、条件Y·Y_i=0、単純正規交差の台、加法型のPicard単位成分、および非ファイバー型を入力条件とする。

滑らかな射影有理曲面 S と、非零有効反標準因子 Y からなる対の比較亜群を定義する。各既約成分について Y·Yᵢ = 0 を満たし、D = Y_red が単純正規交差因子であるとする。Pic⁰(Y) の単位成分が加法群型であることによって表される加法型の条件と、非ファイバー型の条件、すなわち n ≥ 1 に対して nY をファイバーとして持つ楕円ファイブレーションが存在しないことを要求する。ルート基底または正規化された時間を用いるときは、標識を保持する。これらの条件の相対版を構成する。（STT02, Definitions 1.1 and 1.3, Proposition 1.2 および Tables 2–3。）

**構成・法則（API）**

- 重み付き境界交点グラフと Pic(S) 内の直交格子を取り出す。
- 対の同型に対する不変性と、許容される族との整合性を証明する。
- 補集合 S \ D と、その対数的接層および 2 形式の層を比較する。
- 境界ルート格子と対称性ルート格子を区別する。

**検証事項**

- 滑らかな楕円的反標準境界の Picard 単位成分は楕円曲線型であり、加法群型ではないので除外される。
- 乗法型のサイクルの Picard 単位成分は乗法群型であり、除外される。
- 大域的なアフィン平面チャートを要求すると D₈ の場合が除外される。その追加条件は課さない。

**本目標が担う補助構成。**

- 非被約でありうる反標準境界 Y について、射影的・固有・平坦な族、普遍的 O、H² 消滅、単位成分の仮定を証明してから 1.5 の相対 Picard を適用する。正規化・単数・逐次冪零肥厚の完全列により単位成分を計算し、加法型を定める加法群との比較を証明する。D=Y_red を SNC とし、Θ(−log D) をそのイデアルを保つ導分として構成する。重複度は Y に属し、SNC の述語には入れない。実際の曲面族上で相対 Picard 格子・交点・変形の比較を証明する。SSF5.9 の体上の曲面または算術曲面の交点数だけから任意基底の族の比較を推論しない。

*必要な先行結果：* 内部依存：1.5; [Cohomology with supports](#dependency-supports) (2.7); [Divisors, modifications and surface intersections](#dependency-surfaces) (3.4; 4.11; 4.17; 5.9–5.10); [Algebraic vector bundles and finite locally free sheaves](#dependency-bundles) (L0A–L0C; L1A–L1B; L2A–L2B).

<a id="target-5-2"></a>
### 5.2 コンパクト化と 8 つの境界型

**パンルヴェへの適用。**

**入力条件**

- 目標3.1–3.12の内在的形式と分裂を備える古典的相空間族全体、§5.1の対の枠組み、および指定した標識・許容基底変換を入力とする。コンパクト化の構成、8種類の境界型、その補集合全体と相空間族との一致、および形式・分布の比較は結論である。

明示した標識付けと基底変換の後で、§5.1 の対の構造を備えた次数 4 の接続モジュライ族のコンパクト化を構成し、その補集合が相空間族全体に等しいことを証明する。例外曲線と非自明な束のチャートを含めて、シンプレクティック形式と時間分布の延長および比較を証明する。加法型正規交差境界の型を D₄, D₅, D₆, D₇, D₈, E₆, E₇, E₈ に分類する。これらはアフィン型の境界図式である。（STT02, Proposition 1.2 および Tables 2–3; VDPS09, introduction および Table 1; 完全に確立された PVI の比較については IIS06, §10。）

すべてのプロファイルにわたる比較は、構成と証明の目標である。VDPS09 の序文にある予想的な大域比較を、確立済みの定理として用いない。大域同型を主張する前に、重なりの同定、被覆性、および省略されていたチャートへの延長を証明する。このコンパクト化を用いて §4.4 を回避したり、葉層構造の存在だけから完備性を導いたりしない。

**構成・法則（API）**

- 相対コンパクト化と、その境界因子の重複度および交点形式を構成する。
- 束の跳躍と例外チャートを含む、開補集合全体の比較を証明する。
- その同型による変形と相対 2 形式の比較を行い、標識と基底変換に関する法則を記録する。

**検証事項**

- 境界型 D₆ の 2 つの表示は、異なる形式的極データを持ちうる。境界のラベルが共通であるだけでは、モジュライの同型にはならない。
- 以前の定義に見られるアフィン平面という追加仮定がなくても、D₈ の補集合を保持しなければならない。
- 開いた有理チャートとそのスカラー式が正しくても、例外曲線を 1 つ省略すると、補集合全体についての主張は成り立たなくなる。

*必要な先行結果：* 内部依存：3.3, 3.4, 3.5, 3.6, 3.7, 3.8, 3.9, 3.10, 3.11, 3.12, 5.1; [Cohomology with supports](#dependency-supports) (2.7); [Divisors, modifications and surface intersections](#dependency-surfaces) (3.4; 4.11; 4.17; 5.9–5.10); [Quot/Hilbert and parameter schemes](#dependency-quot) (4.14).

<a id="target-5-3"></a>
### 5.3 境界の変形空間と時間方向

**パンルヴェへの適用。**

**入力条件**

- §§5.1–5.2の許容された非ファイバー型加法的対の族と、目標3.9–3.12の内在的時間分裂を入力とする。第1境界層の層を指定し、その階数1という結論、局所自由性と基底変換、およびKodaira–Spencer写像と時間との比較を、この項目で証明する。台付きコホモロジー全体との一致は仮定しない。

F = Θ_S(−log D), N_D = O_S(D)/O_S とする。L = H⁰(D,F ⊗ N_D) を構成し、これらの対に対して L が 1 次元であることを証明し、局所コホモロジーへの単射を構成する。L の族と基底変換に関する定理を確立し、その Kodaira–Spencer 像を §3.9 の時間方向と比較する。連結写像と交点行列の恒等式を内在的に証明し、境界グラフごとに異なる座標計算を繰り返さない。（TER02, Theorem 2.1 および Proposition 2.1; STT02, Theorem 3.1。）

局所コホモロジー空間全体との等しさを、常に成り立つ前提として主張しない。TER02 Conjecture 2.1 と ST04 Appendix A の限定された結果は、適用範囲が異なる。1 次元空間だけでは特別な非零ベクトルは定まらず、正規化された時間が生成元を与える。変形の比較と、指定した代数的補集合上での一意性によって、持ち上げられた分布の等しさを証明する。

**構成・法則（API）**

- 境界の第一層に付随する 1 次元空間、台付きコホモロジーへのその単射、および制限写像を構成する。
- スカラーのパンルヴェ・チャートを選ばずに、交点行列の公式と次元計算を証明する。
- 局所自由性を伴う基底変換と、その Kodaira–Spencer 像と時間接直線との比較を確立する。

**検証事項**

- 選択した非零の時間ベクトルを定数倍すると L 内のその像も同じく定数倍されるが、L 自体は変わらない。
- 単射 L → H¹_D(S,F) だけでは、その終域が 1 次元であることは証明されない。
- A = ℂ[ε]/(ε²) 上の加群 A/(ε) は、唯一の点でのファイバーが 1 次元だが、階数 1 の自由 A 加群ではない。その ℂ 上の長さは 2 ではなく 1 である。したがって、ファイバーの次元が一定というだけでは、主張する局所自由性を伴う基底変換は確立されない。実際のコホモロジー的仮定を証明しなければならない。

**本目標が担う補助構成。**

- SchemeAndStackFoundations 2.6・2.7 の実際の層・台付きコホモロジーと局所化列を用い、境界係数層、第一境界層の注入、連結写像と交点行列の比較を構成する。相対H⁰(D,F⊗N_D)が可逆層となるための固有性・係数平坦性・コホモロジー基底変換の仮定を証明し、実際の有限射影複体または正確な全射性条件を用いて任意基底変換を証明する。非被約基底では各ファイバーの次元1だけでは足りない。Kodaira–Spencerの時間直線と比較し、台付きH¹_D全体との一致は主張しない。

*必要な先行結果：* 内部依存：3.9, 3.10, 3.11, 3.12, 5.1, 5.2; [Cohomology with supports](#dependency-supports) (2.7); [Divisors, modifications and surface intersections](#dependency-surfaces) (3.4; 4.11; 4.17; 5.9–5.10); [Cohomology, duality and curve degree](#dependency-cohomology) (2.2; 2.6; 2.20; 3.3); [Elementary deformation theory](#dependency-deformation) (4.2–4.6); [Proper coherent direct images and base change](#dependency-proper-cohomology) (Layer C).

#### 例

境界型 E₈ には分岐を伴う階数 2 の表示が 1 つ対応し、E₇ には 2 つ対応する。したがって、境界ラベルと接続の表示は異なる種類のデータである。境界の第一層に付随する空間の次元は 1 である。局所コホモロジー群全体について常に同じ次元を主張するには追加の定理が必要であり、ここでは用いない。

#### 依存関係

各目標の「必要な先行結果」と `design/reuse_registry.json` の枠組み間参照を用いる。一般証明の前提は独立したパッケージに置き、この層では指定した適用比較を確認する。

<a id="target-5-4"></a>
### 5.4 付加構造付き接続上の関手

**パンルヴェへの適用。**

**入力条件**

- 許容された付加構造付き接続と、改変のための不変な局所商、または指定された線束接続・双対性・ラベル変更のデータを入力とする。変換後の行列式、局所指数、安定部分、および強い拡張の比較は、構成の出力である。

不変な局所旗に沿う基本変換、許容された階数 1 接続とのテンソル積、双対化、およびラベルの付け替えを、実際の付加構造付きモジュライ問題の間の関手として構成する。新たな行列式、指数、安定性のデータと、変換された対象が安定である領域を明示する。基本変換には核による構成、その上に誘導される接続、および逆基本変換を用い、比較射を保持する。許容された極のフィルトレーションと核格子が保たれることにより、これらの関手を強可積分族に拡張する。（IIS06, Definition 3.5 および §7; I23, §§2–4 および Definition 10.1。）

**構成・法則（API）**

- 粗モジュライへ移る前に、変換後の束と接続を、その行列式および局所型の公式とともに構成する。
- 指定した定義域上で、引き戻し、合成、および逆変換の比較を証明する。
- 安定性が保たれると無証明で宣言する代わりに、重みの変化または必要な壁越え対応を記述する。
- モジュライ問題の関手的同型、開集合上の双有理対応、およびスカラー解の変数置換を区別する。

**検証事項**

- 対数極で 1 次元商に沿って基本変換すると、束の次数は −1 だけ変化する。行列式を変更しないままにすると、行列式の比較が成り立たない。
- 階数 2 の接続に線接続 L をテンソルすると、その接続も含めて行列式が L² だけ変化する。これは、あらかじめ固定された奇数次数の行列式の平方根を構成することではない。
- 共通の許容領域上では、逆基本変換によって元の付加構造付き対象がその射とともに復元される。一方、指定された旗を忘れると、逆変換が可能とは限らない。

*必要な先行結果：* 内部依存：3.1, 3.5, 3.9, 1.1; [Algebraic vector bundles and finite locally free sheaves](#dependency-bundles) (L0A–L0C; L1A–L1B; L2A–L2B).

<a id="target-5-5"></a>
### 5.5 水平性とシンプレクティック形式の変換則

**パンルヴェへの適用。**

**入力条件**

- §5.4の接続の関手、目標3.5–3.12の変形の対と内在的分裂、および§5.2の標識付き曲面との比較を入力とする。追加の標識付き対の反射、それらが実際に正則・双有理となる領域、水平・シンプレクティックな延長、および関係式は、この項目で構成・証明する。

変換された族に強拡張の一意性を適用し、許容された各変換が h と可換になることを証明する。変形複体とトレースペアリングに誘導される写像により、ω の変換則を証明する。パラメータ付きモジュライ族上に得られる作用亜群を構成し、関手の自然同型によって関係式を確立する。標識付き曲面上では、Pic(S) への作用を、対応する整ルート反射および図式の自己同型と比較する。実際の対称性ルート格子とそのパラメータ超平面を、境界ルート図式とは分けて述べる。（PVI については IIS06, Theorem 7.4 および Theorem 10.13; STT02, Tables 2–3 および標識付き変形の構成。）

§5.4 の関手がアフィン Weyl 群全体を生成するとは仮定しない。標識付き対のモジュライ上で追加の反射を構成し、§5.2 を通して接続モジュライに誘導される双有理対応を同定し、主張する定義域上でその水平かつシンプレクティックな延長を証明する。PVI の中央反射は必須の検証例であり、§5.4 に列挙した局所ゲージ基本変換だけでは生成されない。IIS06 Remark 7.5(2) は Fourier 変換による実現を記述する。Fourier–Laplace 変換または中間畳み込みによる実装も同様に、それ自体の関手と強拡張の比較を必要とする。ここでは標識付き曲面による構成を指定した方法とする。PVI の定理を、すべてのプロファイルに対する定理として引用しない。§7.4 で有理 Bäcklund 公式を導く前に、実際の反射関係式と Coxeter 関係式、有効領域の条件、およびチャートの補集合を越える延長を確認する。稠密開集合上の有理写像の恒等式から、至る所定義された自己同型を主張するには、さらに延長を証明しなければならない。

**構成・法則（API）**

- 標識付き対の反射対応を構成し、共通の定義域上で接続関手の生成元と比較する。
- 水平構造およびシンプレクティック構造との可換性、関係式、およびパラメータ変更との整合性を証明する。
- 大域写像と主張する各写像について、正則な定義域と延長定理を記録する。

**検証事項**

- PVI の中央反射は、κ₀ を −κ₀ に、κⱼ を κⱼ + κ₀ に送る。ただし j = 1,2,3,4 である。これは 2κ₀ + Σκⱼ = 1 を保つ。κ₀ = 1/2, κⱼ = 0 では、変換後の組は κ₀ = −1/2, κⱼ = 1/2 となり、−1 + 2 = 1 を得る。κ₀ の符号変更を省くと、代わりに 3 となる。局所的な整数シフトと符号変更だけでは、この反射を構成できない。
- 反射を 2 回行うと、単に同じ境界図式が得られるだけでなく、比較射を伴う元の標識付き族が得られなければならない。
- 不変曲線上で極を持つ双有理公式は、正則な延長が証明されるまでは、その曲線の自己同型ではない。

*必要な先行結果：* 内部依存：3.6, 3.7, 3.12, 5.2, 5.3, 5.4; [Cohomology with supports](#dependency-supports) (2.7); [Divisors, modifications and surface intersections](#dependency-surfaces) (3.4; 4.11; 4.17; 5.9–5.10).

<a id="target-5-6"></a>
### 5.6 不変有理曲線と Riccati 力学

**パンルヴェへの適用。**

**入力条件**

- 許容された非ファイバー型加法的対の内部にある自己交点−2の滑らかな有理曲線、指定された半普遍的な対の変形、および§5.3の時間方向の比較を入力とする。曲線族の延長、その不変性、および射影的線形化は、必要な局所的範囲または有限基底変換後の範囲における結論である。

許容された非ファイバー型の加法型対に対して、C² = −2 を満たす内部の滑らかな有理曲線 C の局所族を構成する。外部パラメータを α₀ に固定し、(α₀,t₀) のファイバー内の曲線 C を、t₀ の解析的または étale な近傍 U に対する時間基底 {α₀}×U 上で局所的に族へ延長する。外部パラメータ方向へ延長する場合は、結節曲線が存在する領域を別途証明し、対の半普遍変形だけからその延長を推論しない。対数的変形完全列を用いて、時間分布による不変性を証明する。その族を延長するために必要なエタールまたは有限基底変換を保持する。元の底空間への降下には、それ自身のモノドロミーの確認が必要である。得られた相対 ℙ¹ 束上で、H⁰(ℙ¹,Tℙ¹) ≅ sl₂ を用い、制限された接続を射影線形接続と同定する。その座標補題では q′ = a(t)q² + b(t)q + c(t) を得る。階数 2 の線形接続への持ち上げは局所的に主張し、大域的に主張するのは持ち上げの障害を解消した場合に限る。（ST04, §2.4, Proposition 2.1, Remark 2.4 および Definition 2.3。）PVI と Gauss 方程式の比較は IIS06 Theorem 5.15 である。同文献の Theorem 5.16 は解析的パンルヴェ性を仮定しているため、この独立した幾何学的構成の前提としては用いない。

ST04 Theorem 3.1 の仮定の下で、これら内部のノード曲線の配置を境界交点格子によって分類する。同定理の、境界型 E₈, D₇, D₈ に対する非存在の主張を導く。線形化により、座標比較の後で対応する古典的特殊関数の族が得られる。パラメータの制約と正規化は、引き続きそれらの補題の一部とする。

**構成・法則（API）**

- h の不変曲線族への制限を構成し、その時間方向への射影が引き続き分裂であることを証明する。
- 誘導される Möbius ゲージ則によって 2 つの射影座標を比較し、局所的な階数 2 の線形化を比較する。
- 許容された幾何学的変換が曲線族全体に沿って正則同型として延長されるとき、その変換によって保たれることを証明する。そうでない場合は閉包を構成し、必要な曲線の性質と不変性を別に証明する。
- ノード曲線の条件と可約接続または例外 RH ファイバーとの比較は、その同定が証明された表示においてのみ行う。

**検証事項**

- ℙ¹ 上の正則な垂直ベクトル場は、アフィン座標では次数が高々 2 の多項式を係数として持つ。3 次の係数は無限遠での正則性を満たさない。
- 分岐を伴う一般的な局所因子は大域的既約性を強制するが、E₇ の分岐を伴う表示は、それでも不変 Riccati 曲線を持ちうる。したがって、「Riccati 型であることと接続が大域的に可約であることは同値」という主張は、表示に依存しない定理ではない。
- 曲線の族は、時間底空間を周回する解析的延長によって置換されることがある。局所的な不変曲線が、自動的に大域的なラベル付き部分族を与えるわけではない。
- 有理解が Riccati 曲線上にあるとは限らない。ST04 §6.2 がこの違いを与える。この目標は、すべての有理解の分類ではない。

*必要な先行結果：* 内部依存：3.9, 3.10, 3.11, 3.12, 5.1, 5.2, 5.3, 5.4, 5.5; [Cohomology with supports](#dependency-supports) (2.7); [Divisors, modifications and surface intersections](#dependency-surfaces) (3.4; 4.11; 4.17; 5.9–5.10); [Quot/Hilbert and parameter schemes](#dependency-quot) (4.14); [Complex manifolds, holomorphic bundles and observations](#dependency-complex) (K1; K3.0; K3.HolomorphicStalk; K3.MeromorphicGermField; K4; K7.1).

#### 例

§7.5 の PII チャートでは、曲線 p = 0 は α = −1/2 において不変である。その Riccati 方程式は、この曲線上の射影接続の座標表示である。α = 0 における種解 q = 0 は異なる幾何を持つ。これを用いて、すべての有理解が不変 Riccati 曲線から生じると推論してはならない。

#### 依存関係

各目標の「必要な先行結果」と `design/reuse_registry.json` の枠組み間参照を用いる。一般証明の前提は独立したパッケージに置き、この層では指定した適用比較を確認する。

<a id="layer-6"></a>

## レイヤー6：行列式線束とタウ切断

<a id="analytic-theory"></a>

**目的。** 一般の解析定理を、その幾何学的・特殊関数的な適用から分ける。入力は作用素族、積分路の構造、跳躍行列、重み付き評価、正則直線束の比較、トレースクラス評価である。七つの仕様のいずれも、Painlevé 方程式、階数2の形式型、相空間の次元、選択した漸近分枝、有理型接続の合流を要しない。

### 行列式と解析的構成

| 仕様 | 一般の入力と出力 | 証明担当 |
| --- | --- | --- |
| 6.1 | 指数0の正則Fredholm族 → 行列式直線束、標準切断、自然性 | 本ロードマップ：6.1 |
| 8.1 | 積分路の幾何 → Cauchy作用素、解クラス、復元判定 | 本ロードマップ：8.1 |
| 8.2 | Cauchy構造と一様なノルム隔たり → 一意な残差解と評価 | 本ロードマップ：8.2 |
| 8.3 | 重み付きモーメントと裾の制御 → 係数と正確な一様性を持つ漸近 | 本ロードマップ：8.3 |
| 9.3 | 比較した直線束の切断、補正済み1形式、正規化 → スカラーの局所一様収束 | 本ロードマップ：9.3 |
| 9.4 | トレースノルムで正則な作用素の収束 → 行列式収束と条件付き局所零点計数 | 本ロードマップ：9.4（行列式はRandomMatrices §8.3） |
| 8.4 | 標準整関数 Barnes G → 零因子・正規化された対数枝・明示的扇形剰余 | 本ロードマップ：8.4 |

内部の依存列は 8.1 → 8.2 → 8.3 である。6.1、9.3、9.4にはそれぞれ独自の基礎的入力があり、9.3と9.4は独立した収束の経路である。一般トレースクラス行列式は RandomMatrices §8.3 から受け取り、複素正則Fredholm行列式線束の族は 6.1 が構成する。既存の実の向き直線、行列記号のToeplitz指数定理、トレースクラス行列式を、相互に無断で置き換えない。

各適用は固有のアダプターを検証する必要がある。これには、パラメトリックスの積分路・端点評価、実際の作用素族またはトレースクラスの実現、直線束・フレーム比較、有理型接続の復元、JMU/Hamiltonianの比較が含まれる。一般定理が受け取るのは正確に述べた解析的データであり、特殊関数の結論を前提にしない。

### 文献の範囲と解析的条件

書誌情報と文献中の参照箇所は [sources.toml](sources.toml) に記す。構成のモデルは、上記の箇所における [MAL04](https://www.numdam.org/articles/10.5802/aif.2052/)、[BERT17](https://arxiv.org/abs/1703.00046v4)、訂正版 [BERT16](https://arxiv.org/abs/1601.04790v2)、[ILP18](https://arxiv.org/abs/1604.03082v4) である。これらの文献が一般仕様の全体を証明すると主張するものではない。

6.1 は安定化・切断・行列式の規約を検証する。端点の余分な斉次項、非コンパクト積分路の L² 問題、独立した行列式の除去可能性、ρ = 1 での評価の損失、小ノルムではない可解跳躍は 8.1–8.2 の検証事項である。8.3 は平行移動Gaussianの反例を正確な符号と定数を含めて扱い、裾の一様性と追加モーメントを区別する。9.3–9.4 は正規化定数、動くHilbert空間、零点、端点についての条件を明記する。接続の復元定理や合流の比較は下流のアダプターであり、一般の解析結果の暗黙の仮定ではない。

<a id="target-6-1"></a>
### 6.1 指数0のFredholm族に対する正則行列式直線束

**一般理論。**

**入力条件**

- 有限次元複素多様体 S と、指数0の有界複素 Fredholm 作用素の正則族を入力とする。まず作用素の定義域と値域は固定した複素 Hilbert 空間とする。
- 有限次元行列式と完全列の規約、有界な局所分裂、および Banach 空間上の正則な逆作用素を用いる。線束、安定化、標準切断、比較のコサイクルは構成の出力である。

既存の Fredholm・行列式線・有限次元安定化の対象を複素数体に特殊化して、正則な行列式線束の族を構成する。正則な局所自明化、標準切断、整合的な貼合せは 6.1 の構成である。有限次元複素多様体 S 上の、有界複素Fredholm作用素の正則族 T_s: H₀ → H₁ を入力とし、指数を0とする。まず H₀,H₁ は固定した複素Hilbert空間とする。この族から正則直線束 L_T とその標準行列式切断 τ_T を構成する。規約は L_T,s = det(ker T_s)* ⊗ det(coker T_s) とし、実の向き直線の規約の双対を用いる。核と余核の次元が跳ぶ場合も直線束を構成する。（MAL04 §2、印刷頁1372–1374は行列式拡張のモデル、BERT17 §1はそこで指定された記号のクラスにおけるRHPへの適用を与える。）

局所的に有限次元複素空間 F と a: F → H₁ を選び、(T_s,a): H₀ ⊕ F → H₁ を全射にする。局所的な有界分裂と正則な逆作用素を用いて K = ker(T,a) が階数 dim F の正則ベクトル束であることを証明する。L_F = det K* ⊗ det F、τ_F = det(K → F) と置き、K → F には射影を用いる。安定化直和因子を追加した際の比較写像を構成し、共通の細分化を経由して任意の安定化を比較する。貼り合わせに先立って、比較のコサイクル則と切断との両立を証明する。有限次元族では標準の行列式フレームにおける通常の行列式が得られるよう、完全列の符号規約を固定する。安定化の選択からの独立性、正則基底変換、作用素族の同型に関する自然性を証明する。同じ比較則を用い、指定された局所自明化を持つ正則Hilbert束上の作用素族へ拡張する。

τ_T(s) ≠ 0 が T_s の可逆性と同値であることを示す。L_T の存在から τ_T の一般点での非消滅は従わず、追加仮定なしに有効因子が定まるとも限らない。候補となる曲率2形式の閉性だけでは、整数的な遷移コサイクルは得られない。各適用はこの単一の構成を引き戻し、RHPによる実現や対数微分公式は別途証明する。

この目標は複素多様体を基底とし、その間の正則な基底変換に制限する。非被約解析基底への拡張には、冪零係数を保持した層の値を取る作用素族の別の理論が必要であり、点ごとの作用素だけでは決まらない。

**構成・法則（API）**

- 指定した双対規約と有限次元の符号較正に従って、安定化の核の束、行列式直線束、標準切断を構成する。
- 細分化との両立、コサイクル則、安定化からの独立性、正則基底変換を証明する。
- 作用素族の同型に関する自然性を証明し、指定された自明化によってHilbert束版を貼り合わせる。
- 一般点での非消滅や因子を仮定せず、切断の非消滅領域を作用素の可逆領域と同一視する。

**検証事項**

- T_s: ℂ → ℂ, z ↦ sz に対して標準フレームで τ(s) = s を得ることを確かめ、双対規約を固定する。
- T_s(z) = s²z では dim ker T₀ = 1 であっても零点の位数は2となる。消滅次数と核の次元の無条件の一致は主張しない。
- 至る所で可逆な定数族では行列式切断は消えない。恒等的に特異な指数0の族では切断が恒等的に0となり得るが、直線束の構成は有効である。
- 二つの有限次元安定化を共通の細分化で比較すると切断が一致しなければならず、第三の安定化を経由しても比較は変わってはならない。

- 双対数の基底では T=ε と T=0 は点ごとには同じ作用素だが、行列式切断は ε と 0 で異なる。この非被約基底はこの複素多様体基底の定理から除く。非被約基底への拡張には、作用素の層としての係数が必要である。

**本目標が担う補助構成。**

- 既存の複素 ContinuousLinearMap.IsFredholm、nonempty_fredholmPackage、IsFredholm.exists_stabilization_kernel_coordinates、kernelHomeomorph、contDiffAt_kerSection、および各点の detLine/detLineCongr を用いる。後者の規約 det ker(T)⊗det coker(T)* の双対を L_T に使う。正則な束・標準切断・安定化比較・基底変換はここで構成し、有界作用素の解析的逆写像と実際の有限次元チャートから正則遷移写像を証明する。

*必要な先行結果：* [Native complex Fredholm and determinant carriers](#dependency-fredholm) (IsFredholm; nonempty_fredholmPackage; exists_stabilization_kernel_coordinates; kernelHomeomorph; contDiffAt_kerSection; detLine; detLineCongr); [Native analytic inversion](#dependency-inversion) (analyticAt_inverse; analyticAt_inverse_one_sub); [Complex manifolds, holomorphic bundles and observations](#dependency-complex) (K1; K3.0; K3.HolomorphicStalk; K3.MeromorphicGermField; K4; K7.1).

<a id="target-6-2"></a>
### 6.2 パンルヴェ族の行列式線束

**パンルヴェへの適用。**

**入力条件**

- 独立した一般の複素行列式構成を用いる。実際のパンルヴェ作用素族は 6.3 で構成・検証する。

正則な複素指数 0 の行列式線束、その標準切断、有限次元安定化、整合的な比較写像には AnalyticRHPAndDeterminants §6.1 を用いる。L_T = det(ker T)* ⊗ det(coker T) という規約と、同じ複素作用素の対象を保持する。この節では §6.3 が用いる規約と利用契約を固定し、実際の作用素族の構成・指数 0・正則依存性の検証は §6.3 が担う。一般構成をパンルヴェ内部で再び証明せず、実の向きの線束で代用しない。

**構成・法則（API）**

- 双対規約を固定し、別の行列式対象を作らず取り込んだ線束・切断を同定する。
- 6.3 が満たすべき、正則・指数 0・降下の検証条件を正確に示す。

**検証事項**

- T_s: ℂ → ℂ, z ↦ sz に対し、標準枠では τ(s) = s となり、これによって双対規約が固定される。
- T_s(z) = s²z に対して、dim ker T₀ = 1 であるにもかかわらず零点の位数は 2 である。零点位数と核の次元の間に、無条件の等式は与えない。
- 至る所可逆な定数族は非消滅の行列式切断を持つ。恒等的に非可逆な指数 0 の族は、恒等的に零の切断を持ちうるが、それによって線束が無効になるわけではない。

*必要な先行結果：* 内部依存：6.1.

<a id="target-6-3"></a>
### 6.3 指数 0 の RHP 実現と降下

**パンルヴェへの適用。**

**入力条件**

- 目標3.1–4.4の付加構造付き接続族と解析的局所再構成に、選んだ補助的参照対象・改変、積分路、格子、枝、および正規化を備えたものを入力とする。Fredholm実現と指数0の証明は、この項目で構成する。降下は、追加複体が非輪状であり、作用素・鎖複体・安定化の同値であることを証明した比較に対してのみ認める。

目標3.1–3.12の付加構造付き接続族と §§4.1–4.3 の解析的比較から、解析的 RHP チャートを構成する。標識データには、基準束または改変、積分路、局所格子、分枝、枠、および正規化を保持する。対応する Fredholm 作用素を構成し、その指数が 0 であることを証明する。この主張を、根拠なく各接続に追加するデータ項目とはしない。最初の閉曲線積分路モデルでは、固定した積分路近傍上の正則可逆な跳躍シンボルを用い、その行列式の回転数を 0 とする。可解な正規化 RHP を対応する標識付き接続と比較し、§6.2 の線束と切断を引き戻す。§§3.1–3.3 に保持した、分岐を伴う層と共鳴層のすべてに対して、明示的なアダプターによってこの構成を解析的な扇形領域モデルへ拡張する。これらのアダプターの証明は構成の一部である。引用した一般的な設定の文献のいずれも、そのすべてを与えるとは主張しない。（BERT17, §1 および Theorem 2.2; MAL04, §2。）

補助束の選択は重要である。ℙ¹ 上で rank E = 2, deg E = d ならば、χ(E(−1)) = d および χ(E(k)) = d + 2k + 2 である。したがって、束の次数が −1 である相空間の対象に対して、説明なしに E(−1) を選んでも指数 0 の複体は得られない。d が奇数の場合、共通の整数回の線束捻りによって Euler 標数を 0 にすることはできない。必要な正規化された指数 0 の複体または改変と、元の接続との比較を構成する。Malgrange の次数 0 の縫合束による構成は、この課題を免除しない。

入力の標識に、基準束と補助的改変を保持する。線束と切断の単元遷移因子を主張するのは、同値性が証明され、追加した補助複体があればそれが至る所非輪状である場合に限る。基準束または改変を任意に変更すると、零因子が変化しうる。その場合は異なる正規化問題として扱い、2 つの切断が単元倍で等しいと宣言する代わりに、相対行列式因子または有理型変換を、その因子とともに構成する。BERT17 の因子分解の比較は、制限のない束の改変に対する不変性を与えない。

**構成・法則（API）**

- RHP の標識チャートと、その接続データから作用素族への関手を構成する。
- 同じ Fredholm 族、または正則な鎖同値／安定同値が証明された族を与える積分路・因子分解・正規化の変更に対して、恒等則および合成則を伴う比較同型を証明する。
- 標識付きモジュライ亜群／スタック上に同変線束と切断を構成する。粗空間への降下は、線束と切断に対する固定部分群の作用が自明であることを証明してから行う。
- 必要な解析的アダプターを持つ層を正確に記録する。記載したアダプターを完成させることは証明目標であり、引用した一般的な設定の文献がすでにすべての層を覆うと主張することではない。

**検証事項**

- 次数 −1 の例は、その接続自体は正当な相空間の対象であるにもかかわらず、E(−1) の指数の検証に失敗する。
- スカラー自己同型は Euler 標数を重みとして作用し、その重みはここでは 0 である。ただし、これによって他のすべての可能な固定部分群の作用まで自明であると確立されるわけではない。
- 2 つの基本的な跳躍因子分解は、異なるスカラー Fredholm 行列式を与えうる。必要な比較は、文字どおりの等しさではなく、その非零の遷移因子である。

**本目標が担う補助構成。**

- 閉曲線模型では実際のHardy/Toeplitz比較を構成し、連続可逆な行列記号にT1–T3を適用する。行列式回転数0と正則依存を確認し、復元写像によって正規化可解性と可逆性を同値にする。行列記号では指数0だけでは足りず、扇形・共鳴・分岐の模型は本目標の別の比較で扱う。

*必要な先行結果：* 内部依存：3.1, 3.5, 3.6, 3.9, 4.1, 4.2, 4.3, 6.2, 1.2; [Cohomology, duality and curve degree](#dependency-cohomology) (2.2; 2.6; 2.20; 3.3); [Elementary deformation theory](#dependency-deformation) (4.2–4.6); [Stacks, inertia and restricted coarse-space criteria](#dependency-stacks) (1.18–1.23); [Trace-class ideal carrier](#dependency-trace-ideal) (OI-B01–OI-B19; OI-B23; OI-B29–OI-B30); [Matrix-symbol Toeplitz index](#dependency-toeplitz) (T1–T3); [Generic trace-class determinant](#dependency-trace-determinant) (8.3, generic operator-theory prefix).

<a id="target-6-4"></a>
### 6.4 タウ因子と変分公式

**パンルヴェへの適用。**

**入力条件**

- 構成済みの行列式切断、真の因子を得るための一般の点での非消滅性、および一般的位置のJMU比較と頂点補正に関する正確な仮定を用いる。

行列式切断が消滅することと、その正規化 RHP が可解でないことが同値であると証明する。被約かつ連結な滑らかなチャート上で切断が恒等的に零でない場合、その有効 Cartier 因子を構成する。大域的な因子は、線束の比較を通して初めて得る。これは選択した RHP 正規化が成立しない領域であり、内在的な相空間や水平切断が存在しなくなるという宣言ではない。6.1 の各安定化チャートで、同じ階数の束 K_stab と F の正則フレームを選び、射影 K_stab→F を表す行列を S(s) とする。標準切断の代表は det S である。非消滅領域で d log(det S)=Tr(S⁻¹dS) を証明し、行列式フレームの変更に伴う実際の対数補正を証明する。これにより分岐・共鳴のアダプターを含む全ての構成済み RHP チャートで行列式フレームの1形式とスカラー正規化を得る。同値に、有限次元空間 F 上で K_fin=I−S と置けば、表示したトレースクラス恒等式を得る。無限次元の可積分核 K による実現を主張する場合は、トレースノルムで正則な族と、非消滅因子 u を伴う τ=u det(I−K) の比較を構成した上で d log τ=d log u−Tr((I−K)⁻¹dK) を用いる。JMU/Hamiltonian 比較の一般領域に関する仮定は保持する。 可積分核との比較を検証した領域で変分公式と枠変更の法則を導く。（BERT17, Theorem 2.2, Proposition 2.3, formula (3.6), Theorem 3.3 および §3.1.2。）

JMU 形式との比較は、明示した形式的正規化の仮定の下でのみ行う。すなわち、BERT10 Assumption 3.1 および §5.1, Proposition 5.1 の、分岐を伴わず最高次項が対角化可能であり、対数的非共鳴条件を満たす一般的な領域に限る。訂正された符号については BERT16 Definition 2.1、頂点での曲率については Theorem 2.1、BERT10 Theorem 5.1 を置き換える結果として Theorem 2.2 を用いる。訂正後の局所公式は ω_M − θ_V を用い、モノドロミーパラメータ上で dθ_V = η_V を満たす。モノドロミーを固定した時間方向では θ_V の成分はないが、因子分解／枠の補正はなお一致させなければならない。補正前の Malgrange 形式も、その当初の修正版も、モノドロミーと時間の全空間上で閉じているとは主張しない。積分路の頂点を取り除くには、縫合の比較の証明が必要である。

**構成・法則（API）**

- 切断の因子と、§6.3 の比較に対するその自然性を構成する。
- 局所変分恒等式と、非消滅の枠乗数によるその変化を証明する。
- 選択した JMU 正規化との比較を、上で述べた、分岐を伴わず最高次項が対角化可能で対数的非共鳴な一般的領域に正確に限定して構成する。ここで与える JMU 比較は、それ以外の分岐を伴う層や共鳴層については主張しない。そのような層で§6.3のRHPアダプターが証明されていれば、行列式切断とその有限次元安定化による対数微分を得る。無限次元のトレース公式には、別途トレースクラス実現と行列式枠の比較を要する。

**検証事項**

- 選択したタウ代表の零点が生じても、内在的な水平解は、別の束のチャート内でその時刻を越えて延長されうる。
- 族 T_s = s² は 2 重零点を保持する。因子の計算で、重複度を核の次元に置き換えることはできない。
- 頂点で非自明な極限を持つグラフでは、BERT16 の補正が必要である。互いに交わらない閉曲線積分路の場合を根拠として、証明されていないグラフから積分路への比較でその補正を省くことはできない。
- 局所接続 d + [[0,z⁻²],[z⁻¹,0]]dz の射影的傾きは 1/2 である。z = w² とゲージ diag(1,w) の後、その最高次項係数は 2(E₁₂ + E₂₁)/w² となる。これは、ここでの JMU 比較の領域外である。それでも、構成した指数 0 の RHP アダプターは、行列式切断とその有限次元安定化による対数微分を備える。この事実から、指定されていない分岐を伴う場合の JMU 微分を導くことはしない。

- 無限次元複素Hilbert空間上のT_s=e^s Iは正則で可逆なFredholm族だが、T_s⁻¹dT_s=I dsはトレースクラスのトレースを持たない。その行列式線の切断には局所有限次元安定化による代表がある。一般のFredholm入力だけでは無限次元のトレース公式を正当化できない。

*必要な先行結果：* 内部依存：4.1, 6.2, 6.3, 1.2; [Generic trace-class determinant](#dependency-trace-determinant) (8.3, generic operator-theory prefix).

<a id="target-6-5"></a>
### 6.5 Hamiltonian、枠、およびスカラー正規化

**パンルヴェへの適用。**

**入力条件**

- JMU・ハミルトニアン比較は、分岐を伴わず非共鳴である一般的位置の部分でのみ行う。より広い範囲でのスカラー正規化には、構成したRHP行列式切断の有限次元安定化による対数1形式、固定した枠、および正則な時間葉上の基点値を用いる。無限次元トレース表示には、検証したトレースクラス実現と枠の比較を追加で要する。

§6.4 の JMU 比較の領域上で、すでに構成した力学の時間座標とシンプレクティック・チャートを選び、選択した行列式枠での対数微分と局所 Hamiltonian の関係を導く。正確な係数と、ゲージ・因子分解・時間だけに依存する補正項を §6.4 から証明する。異なる Hamiltonian の規約を暗黙に同一視しない。シンプレクティック・チャートから得られる局所的な原始関数は、相空間族全体上の標準的な関数ではない。この Hamiltonian／JMU 恒等式はその領域に限定され、追加の分岐／共鳴の場合の恒等式を主張しない。（対数的 Schlesinger の範囲に限った MAL04, Theorem 5.12; BERT16 による訂正を伴う BERT10, §5.1, Proposition 5.1。）

構成した全ての標識付きRHPチャートで、§6.3のアダプターを証明した分岐・共鳴チャートも含め、§6.4の安定化恒等式を用いる。行列式枠ではτ=det Sであり、その非消滅領域でd log τ=Tr(S⁻¹dS)が成り立ち、枠の変更には証明した補正を付ける。無限次元実現τ=u det(I−K)を検証したトレースクラス領域では、d log τ=d log u−Tr((I−K)⁻¹dK)を得る。この実際の対数 1 形式と枠の指定を固定し、正則な基点で行列式ファイバー内の非零値を選ぶことで、スカラー正規化を確立する。この正規化定理は、一般的な比較領域の外での JMU または Hamiltonian との同定を必要としない。（BERT17, Proposition 2.3 および formula (3.6)。）

微分方程式による正規化は、選択した因子を避け、モノドロミーを固定した水平な時間葉に沿って行う。そこでは、閉じたスカラー微分形式と基点値によって、単連結領域上の代表が定まる。この主張をモノドロミーと時間の全空間へ拡張するには、枠補正の後で必要な可積分性を証明しなければならない。単連結性だけでは、線束の接続の曲率は除去されない。

**構成・法則（API）**

- 指定した JMU 比較の領域上で、§3.11 のシンプレクティック形式と時間の規約を変分恒等式と比較し、すべての補正項を記録する。より広いRHPアダプターの領域では、指定した行列式枠で有限次元安定化の恒等式を用いる。無限次元トレース公式は、追加のトレースクラス比較を証明した場合に用いる。
- 時間変更、時間依存のシンプレクティック・チャート変更、および行列式枠の変更に対する変換則を証明する。
- 基点値を固定した後、連結かつ単連結な正則領域上でスカラー正規化の一意性を証明する。降下に対するホロノミー障害は別に述べる。

**検証事項**

- 恒等式 d log τ = H dt を用いる場合、H を H + c(t) に置き換えるには、積分定数を固定した上で τ に exp(∫c(t)dt) を掛ける必要がある。
- 新しい時間 u = f(t) では、同じ対数 1 形式の係数は (dt/du)H となる。スカラー係数を変更しないと、比較が成り立たない。
- 非零定数倍だけ異なる 2 つの代表は、同じ対数微分を定めるが、基点値が一致するまでは異なる正規化スカラー関数である。

*必要な先行結果：* 内部依存：3.11, 3.12, 6.3, 6.4; [Complex manifolds, holomorphic bundles and observations](#dependency-complex) (K1; K3.0; K3.HolomorphicStalk; K3.MeromorphicGermField; K4; K7.1).

#### 例

1 次元作用素族 s, s², 1 は、切断、因子の重複度、および可逆性を区別する。正当な次数 −1 の接続は、相空間の対象と補助的な指数 0 の RHP 複体を区別する。積分路／因子分解の変更は、内在的な線束の切断と、そのスカラー代表を区別する。これらの例は、古典的なタウ方程式を表示する前に、共通の構成を検証する。

#### 依存関係

各目標の「必要な先行結果」と `design/reuse_registry.json` の枠組み間参照を用いる。一般証明の前提は独立したパッケージに置き、この層では指定した適用比較を確認する。

<a id="layer-7"></a>

## レイヤー7：パンルヴェ方程式の古典的表示

<a id="target-7-1"></a>
### 7.1 一階ジェット座標とスカラー・パンルヴェ方程式

**パンルヴェへの適用。**

**入力条件**

- 実際の古典的時間曲線・相曲面、局所観測量、証明されたジェット同型領域を用いる。一般ジェット定理にはシンプレクティック性やパンルヴェ性を前提としない。

観測束とその第一ジェット束で定式化された NonlinearConnections §0.8 を用いる。古典的時間曲線と相曲面について局所観測量を与え、誘導されたジェット写像が指定領域で同型となることを証明する。その領域で、水平芽とスカラー二階方程式の芽との一般の同値を適用する。時間・相座標で h(∂t) = ∂t + A∂q + B∂p、J(t,q,p) = (t,q,A) と書き、p = P(t,q,v) が実際の逆であるとき、座標比較は q″ = (A_t + A A_q + B A_p)(t,q,P(t,q,q′)) となる。連鎖律の定理と内在的ジェット構成は一般枠組みに置く。A_p ≠ 0 が与えるのは局所逆だけである。個々の古典的チャートの構成は §7.2 が担う。有理型延長にはさらに §4.9 を用い、それをジェット定理の仮定にはしない。

**構成・法則（API）**

- 各チャート・観測量のジェット同型領域を確認し、その補集合を記録する。
- 取り込んだジェット構成の座標表示としてのみ、スカラー公式を得る。

**検証事項**

- A = p ならば、逆写像は p = q′ であり、スカラー方程式は q″ = B(t,q,q′) となる。
- A が p に依存しないならば、J は運動量を忘れてしまい、ジェット座標にはなりえない。この場合、この議論によって幾何学的一意性からスカラー解の一意性を導くことはできない。
- A = p² の場合、p = 0 の外側には運動量の二つの枝がある。局所可逆性によって、この二つの枝が大域的に同一視されることはない。
- スカラー式が q による除算を含む場合、q = 0 を横切る解は重なり合う相空間座標を通じて扱う。分母を払うことで新たな解が生じると宣言してはならない。

*必要な先行結果：* 内部依存：3.4, 3.7, 3.9, 0.8.

<a id="target-7-2"></a>
### 7.2 表示と方程式の網羅的比較

**パンルヴェへの適用。**

**入力条件**

- §3.4のプロファイル分類と、すでに構成した内在的モジュライ、分裂、シンプレクティック形式、および延長定理を入力とする。各プロファイルの具体的座標、パラメータ・時間の置換、ジェットの逆写像、および被覆・重なりの比較は、この項目の出力である。

§3.4 の各プロファイルについて、接続のモジュライから具体的な時間・Darboux 座標、またはそれと同等のシンプレクティック座標を、実際の像上の逆写像とともに構成する。§3.9 の強い可積分拡張によってこの座標での h を同定し、§7.1 を適用して、以下の標準方程式へのパラメータと時間変数変換の対応を、必要な標識の被覆も含めて証明する。この比較には、選んだ局所枠、行列式の規約、座標領域、運動量の逆写像、すべての分母、および除外した部分を記録する。モジュライ空間全体の被覆は重なりの定理によって保証するのであり、一つの有理座標が全体を覆うと主張するのではない。両立する系からスカラー表示を導き直し、§7.4 の文献の修正も比較の一部とする。（VDPS09, §2.2, Table 1 および §4; IIS06, Theorems 10.6, 10.10 and 10.13; DLMF, §32.2(i), equations 32.2.1–32.2.6.）

以下の結果の表では、傾きは射影的 Katz 不変量であり、その順序を忘れるのは分類表のためだけである。存在しない極は「—」で表す。§3.4 のラベル付与と添字付け替えの比較によって、順序付きの全 17 プロファイルを復元する。外部パラメータの数は一般の指数族の次元であり、初期条件の数ではない。境界図形はアフィン型である。

| 0, 1, ∞, t における傾き | 境界型 | 外部パラメータの次元 | 表示による実現と正確な参照箇所 |
|---|---|---:|---|
| 0, 0, 0, 0 | D₄ | 4 | PVI; IIS06 §10, Theorems 10.6 and 10.10 |
| 0, 0, 1, — | D₅ | 3 | PV; VDPS09 §4.3, equations (1)–(5) |
| 0, 0, 1/2, — | D₆ | 2 | 退化 PV; VDPS09 §4.4, equations (6)–(11) |
| 1, —, 1, — | D₆ | 2 | PIII(D₆); VDPS09 §4.5, equations (12)–(16) |
| 1/2, —, 1, — | D₇ | 1 | PIII(D₇); VDPS09 §4.6, equations (17)–(21) |
| 1/2, —, 1/2, — | D₈ | 0 | PIII(D₈); VDPS09 §4.7, equations (22)–(26) |
| 0, —, 2, — | E₆ | 2 | PIV; VDPS09 §4.8, equations (27)–(31) |
| 0, —, 3/2, — | E₇ | 1 | Flaschka–Newell による実現; VDPS09 §4.9, equations (32)–(36); 直接得られるスカラー座標は P34 |
| —, —, 3, — | E₇ | 1 | PII の Jimbo–Miwa による実現; VDPS09 §4.10, equations (37)–(41) |
| —, —, 5/2, — | E₈ | 0 | PI; VDPS09 §4.11, equations (42)–(47) |

Flaschka–Newell のスカラー座標を PII に、退化 PV を PIII(D₆) に結びつける実際の変数変換と、許容される逆変換の領域を証明する。同じ境界型を持つ二つの行を、同一の付加構造付きモジュライ問題と宣言しない。特に、退化 PV から PIII へのスカラー変数変換だけでは、それらのモノドロミー保存族を同定したことにはならない。（AHT17, introduction および §§2–3.）

DLMF の正規化に従い、常微分方程式としての各領域で得られる六つの標準スカラー方程式は、次のとおりである。

| 方程式 | 座標表示 |
|---|---|
| PI | q″ = 6q² + t |
| PII | q″ = 2q³ + tq + α |
| PIII | q″ = q′²/q − q′/t + (αq² + β)/t + γq³ + δ/q |
| PIV | q″ = q′²/(2q) + 3q³/2 + 4tq² + 2(t² − α)q + β/q |
| PV | q″ = (1/(2q) + 1/(q − 1))q′² − q′/t + (q − 1)²(αq + β/q)/t² + γq/t + δq(q + 1)/(q − 1) |
| PVI | q″ = (1/q + 1/(q − 1) + 1/(q − t))q′²/2 − (1/t + 1/(t − 1) + 1/(q − t))q′ + q(q − 1)(q − t)[α + βt/q² + γ(t − 1)/(q − 1)² + δt(t − 1)/(q − t)²]/[t²(t − 1)²] |

各行は、ある座標と指定されたパラメータ写像についての定理である。記号 α, β, γ, δ は各行の内部だけで用いる。以下の明示的対応表によって、意図する正規化を固定する。許容される逆座標と運動量の変換も証明の一部とする。

| 文献の変数とパラメータ | 標準変数と係数 |
|---|---|
| IIS06 (1)–(2), 2κ₀ + κ₁ + κ₂ + κ₃ + κ₄ = 1 のもとで | PVI: α = κ₄²/2, β = −κ₁²/2, γ = κ₂²/2, δ = (1 − κ₃²)/2 |
| VDPS09 の PV 系 (2)/(5), §7.4 のスカラー式の修正を適用 | T = t, Q = q/(q − 1); (α,β,γ,δ) = (θ₁²/2,−θ₀²/2,1 − θ∞,−1/2) |
| VDPS09 の退化 PV 系 (8) | T = t², Q = q/(q − 1); (α,β,γ,δ) = (θ₁²/2,−θ₀²/2,−2,0) |
| VDPS09 PIII(D₆), (14) | T = t, Q = q; (α,β,γ,δ) = (4(θ∞ + 1),−4θ₀,4,−4) |
| VDPS09 PIII(D₇), (19) | t = T², Q(T) = Tq(T²); (α,β,γ,δ) = (4(θ∞ + 1),−8,4,0) |
| VDPS09 PIII(D₈), (24) | t = T², Q(T) = q(T²)/T; (α,β,γ,δ) = (8,−8,0,0) |
| VDPS09 PIV, (29) | t = 2T, Q(T) = 2q(2T); α = −θ∞ − 1, β = −2θ₀² |
| VDPS09 PII Jimbo–Miwa, (39) | T = t, Q = q; α = (θ∞ + 1)/2 |
| VDPS09 PI, (45), c⁵ = 2 を選ぶ | T = ct, Q = c⁻²q; Q″ = 6Q² + T |

Flaschka–Newell 座標 (34) では、c³ = 2 を選び、T = −ct, U(T) = cq(t) とおく。このとき U″ = U′²/(2U) + 2U² − TU − θ₀²/(2U) となる。指数の符号の選択 a = ±θ₀ を保持する。U ≠ 0 上では、Q = (U′ − a)/(2U) が α = a − 1/2 に対する PII 変数であり、逆に U = Q′ + Q² + T/2 となる。例外的な枝 U = 0, a = 0 は除算によって復元できないので、相空間の全データを保持する。時間の二乗を用いる比較は、非零の領域上の局所双正則写像、または指定した被覆上の比較である。同じ穿孔直線上の大域的な座標変換ではない。

**構成・法則（API）**

- 表示の各行について、明示式、パラメータ写像、逆ジェット座標、重なりの写像を含む比較パッケージを用意する。
- 拡大 2 形式の等式によって、文献ごとのハミルトニアンと §3.11 の規約を比較する。
- 除外した分母をすべて特定し、その零点集合のうち許容される部分を通る相空間座標を明示する。
- 比較で覆われる各観測量の層上で、§4.9 から標準スカラー方程式のパンルヴェ性を導く。

**検証事項**

- 表示の行は 10、境界型は 8 である。各行をそれぞれ異なる古典的方程式と同一視すると、どちらの数も合わなくなる。
- 上記の標準 PI へのスケーリングは q と t の両方を変える。t のみをスケーリングしても、q² の係数 6 は得られない。
- PII の二つの線形系による表示は、異なる局所特異点データを持つ。スカラー解の式が等しいことは、入力対象が等しいことではない。
- γ = 4, δ = −4 に対する PIII の比較は、非零のスケーリングによって γ = δ = 0 を覆うことができない。後者は §7.3 の境界解析に属する。

*必要な先行結果：* 内部依存：3.4, 3.5, 3.6, 3.7, 3.8, 3.9, 3.10, 3.11, 3.12, 4.9, 5.2, 7.1.

<a id="target-7-3"></a>
### 7.3 係数境界の完全な被覆

**パンルヴェへの適用。**

**入力条件**

- 標準的PIII・PVのすべての係数組を対象とし、スケーリングと反転の非零条件を満たす領域を用いる。求積法で解ける境界は、原始的な層と区別する。

標準 PIII および PV の表示のすべての係数組を、許容される非零のスケーリングと反転によって分類し、その正確な領域と逆変換を証明する。原始的パンルヴェ・プロファイルと初等的な境界方程式は異なる出力である。不確定特異点の最高次係数が零となる点は、その係数の非消滅によって定義された層の内部の点ではない。（FM19, §1.1 および equation (2); DIL21, §§5.2–5.3 および Appendix B.3; DLMF, equations 32.9.6 and 32.9.12.）

| 表示 | 係数条件 | 比較先 |
|---|---|---|
| PIII | γδ ≠ 0 | D₆ プロファイル |
| PIII | γ = 0 かつ αδ ≠ 0、または δ = 0 かつ βγ ≠ 0 | D₇ プロファイル。二つの向きの間の反転比較を含む |
| PIII | γ = δ = 0 かつ αβ ≠ 0 | D₈ プロファイル |
| PIII | α = γ = 0、または β = δ = 0 | 求積・初等的境界 |
| PV | δ ≠ 0 | 通常の PV |
| PV | δ = 0 かつ γ ≠ 0 | 退化 PV による表示 |
| PV | γ = δ = 0 | 求積境界 |

PIII の場合分けがすべての係数組を覆うことを証明する。二つの初等的条件は重なりうるため、一つの境界類にまとめる。指定した時間・観測量の領域上で、枝と積分定数を保持して境界における積分を導き、幾何学的退化を主張する場合には極限初期データを比較する。四つの係数がすべて零である PIII は、ℂ* の選んだ被覆上で q = C exp(μ log t) を与え、その非零解の領域も含めて扱う。一般のこのような冪は ℂ* 上の一価関数ではない。q を含む分母を払って導入された零解・定数解については、元の方程式の領域を別に確認する必要がある。これらの例によって、原始的分類が暗黙のうちに係数値を取り落とすことを防ぐ。

*必要な先行結果：* 内部依存：7.1, 7.2; [Formal scalar and vector-valued Laurent algebra](#dependency-formal-series) (L1–L4; L5–L6 for finite-extension steps in 1.1); [Covering spaces and universal covers](#dependency-covers) (Stage 0.2–0.4; Stage 1.5; Stage 2.6–2.8).

<a id="target-7-4"></a>
### 7.4 ハミルトニアン、シグマ方程式、線形系による実現

**パンルヴェへの適用。**

**入力条件**

- それ以前の幾何学的変換、行列式の変分、および座標比較の結果を、それぞれに明記された実際の領域で用いる。シグマ形式からの逆構成には、明示した再構成の非退化性仮定を課す。文献の符号の訂正と、ハミルトニアン・シグマ・線形系の表示の比較は、この項目で証明する。

許容される各表示について、h と ω から表示されたハミルトン系を導き、同じ強い全接続から Lax 対の両立条件を導く。シグマ方程式、変換、タウ関数の対数微分については、順方向の補題を述べ、逆方向は復元が証明された部分上でのみ述べる。時間のみに依存するハミルトニアンへの加法項、タウ関数の乗法的正規化、枝の選択、例外的な導関数の挙動を明示的に追跡する。（DLMF, §§32.6–32.7; VDPS09, §4; IIS06, Theorem 10.13; BERT17, Proposition 2.3 and Theorem 3.3.）

文献の符号との比較自体を補題とする。VDPS09 §4.1 に表示されている方程式 p′ = F H_q, q′ = −F H_p では、F が q のみに依存するとき、その核を与える形式は dp ∧ dq/F + dH ∧ dt である。文献に印刷された拡大形式の負号は、PI の場合 (44), (46), (47) を含め、これらの方程式と整合しない。F ≠ 0 上で、文献の引数順序 H(p,q,t) を用いて Q = q, P = p/F(q), K(Q,P,t) = −H(F(Q)P,Q,t) とおく。このとき dQ ∧ dP + dK ∧ dt は、正しい文献側の形式の負であり、§3.11 の規約を与える。文献のハミルトニアンを利用する前に、この恒等式を直接確認する。

VDPS09 に印刷された PV 方程式 (3) も、その系 (2) およびハミルトニアン (5) と一致しない。q′ = 2p/t を微分すると、指数パラメータを含む項は、印刷された θ₀²/(2qt²) + θ₁²/[2(q − 1)t²] に代わって [θ₀²(q − 1)² − θ₁²q²]/[2q(q − 1)t²] となる。t = 1, q = 2, p = 0, θ₀ = 0, θ₁ = 1, θ∞ = 1 では、両立する系は q″ = 2 を与える一方、印刷されたスカラー方程式は 7/2 を与える。比較には導き直した式を用い、その後に §7.2 の PV 変数変換を適用する。

シグマ方程式からの復元には、導関数の非退化性の仮定と解析接続の議論を含める。例えば、PI のシグマ関係式 (σ″)² + 4(σ′)³ + 2tσ′ − 2σ = 0 は σ ≡ 0 を解として持つが、q = −σ′ ≡ 0 は q″ = 6q² + t を満たさない。したがって、無条件の逆向きの含意は偽である。σ″ が恒等的には零でない枝では、微分した後に得られた解析的恒等式を延長することで、必要な復元を得る。除外される枝全体は、a を定数として σ = at + 2a³ であり、その q = −a は開いた時間領域上で PI を満たすことはない。このように、このシグマ関係式の余分なスカラー枝を明示する。

この PI の障害と、実際の不変部分上で相空間情報が失われることを区別する。§7.5 の PII の正規化で c = α + 1/2, σ = H とおく。直接微分すると σ′ = −p/2 および σ″ = 2qσ′ − c/2 を得るので、σ′ ≠ 0 上では q = (2σ″ + c)/(4σ′), p = −2σ′ となる。c = 0 かつ p = 0 では、すべての Riccati 軌道 q′ = −q² − t/2 に対して σ ≡ 0 である。これらは初期値 q の異なる実際の相空間軌道であり、いずれも同じスカラーのシグマ関数を持つ。この部分上では相空間・初期点のデータを保持する必要があり、シグマ関数だけからの逆写像は存在しない。復元可能な枝での σ′ の孤立零点には、指定した解析接続の比較が必要であり、零分母にも値を割り当てた除算で済ませない。

*必要な先行結果：* 内部依存：3.11, 5.4, 5.5, 6.4, 6.5, 7.1, 7.2, 7.3.

<a id="target-7-5"></a>
### 7.5 具体的な正規化と特殊解の検証

**パンルヴェへの適用。**

**入力条件**

- §7.2ですでに構成したPI・PIIの接続モジュライとの比較、1次ジェット補題、および許容された幾何学的変換を入力とする。指定したハミルトニアンの正規化、運動量の逆写像、および種となる解の恒等式は導出すべき事項である。例外的領域とRiccatiパラメータα=−1/2を保持する。

対応するモジュライ座標から、PI の座標 H = p²/2 − 2q³ − tq と PII の座標 H = p²/2 − (q² + t/2)p − (α + 1/2)q を証明し、§7.1 を適用する。PII のジェット逆写像は p = q′ + q² + t/2 である。この多項式座標はすべての有限の (q,q′) を覆い、極は他の相空間座標で扱う。§7.2 とのパラメータの対応を確立する。（VDPS09, §§4.10–4.11; DLMF, §§32.2, 32.6 および 32.9.）

証明済みの種となる対象から、§§5.4–5.5 の許容される変換によって生成される有理解と古典特殊関数解の族を構成し、その式は得られた座標補題としてのみ証明する。これら少数の種から、有理解や代数解すべての完全分類を導入しない。

**検証事項**

- α = 0 では、q = 0, p = t/2 がこの座標で水平切断をなす。
- α = 1 かつ t ≠ 0 では、q = −1/t, p = 2/t² + t/2 が両方のハミルトン方程式を満たす。t = 0 での幾何学的延長には別の座標を用いる。
- α = −1/2 では、p = 0 が不変であり、q′ = −q² − t/2 となる。q = u′/u とおくと、u ≠ 0 上で u″ = −tu/2 を得る。これは §5.6 の射影的線形化であり、u の零点は ℙ¹ で解釈する。
- H ↦ H + c(t) によって上の二つの検証例の水平性は変わらないが、§6.5 の恒等式が適用されるとき、正規化されたハミルトニアンによるタウ代表は対応する原始関数の指数因子だけ変わる。

*必要な先行結果：* 内部依存：5.4, 5.5, 5.6, 6.5, 7.1, 7.2, 7.3, 7.4.

#### 例

幾何学的には完全に正則な初期点において、スカラー方程式に見かけの分母が現れることがある。逆に、分母を払った多項式恒等式が、元の方程式には存在しない関数を解として持つこともある。1 次ジェット座標と観測量の比較によって、内在的な解の定義を変えることなく、両方の問題を解決する。

#### 依存関係

各目標の「必要な先行結果」と `design/reuse_registry.json` の枠組み間参照を用いる。一般証明の前提は独立したパッケージに置き、この層では指定した適用比較を確認する。

<a id="layer-8"></a>

## レイヤー8：Riemann–Hilbert 漸近解析と特徴的な解

<a id="target-8-1"></a>
### 8.1 積分路と Cauchy 変換による解

**一般理論。**

**入力条件**

- 有限の行列サイズと、明示した幾何学的クラスに属する固定の向き付き積分路を入力とし、弧長測度、指定した局所分岐、および非零の交差角を備える。
- 有界性、Plemelj 関係、減衰、復元は、この積分路のクラスについて証明する出力である。外部の積分路を適用するアダプターでは、それらを明示した既証明の仮定として受け取る。
- 候補の復元と行列式に関する結論には、明記した境界積分の消滅と特異点の除去可能性を追加で仮定する。

有限個の向き付きのコンパクト C¹,α 弧、閉じた C¹,α 曲線、およびコンパクト集合の外で直線半直線となる弧の和（0 < α ≤ 1）について、再利用可能な積分路の構造を構成する。各弧は正則にパラメータ表示され、端点と横断的な頂点は有限個とする。弧長測度と複素線素 dζ を固定し、異なる枝の交わりは指定された頂点だけで起こるものとする。有界な L² Cauchy境界作用素 C₊, C₋、Plemelj関係 C₊ − C₋ = id、および解析的Cauchy変換 C(h)(z) = (2πi)⁻¹∫_Γ h(ζ)/(ζ − z)dζ と指定クラス上での境界復元を証明する。頂点で異なる枝の間に生じる局所評価と、非有界半直線上の積分の収束・減衰も証明に含める。さらに一般の積分路は、同じ仕様を証明して初めて採用できる。端点の弧長測度が0であることによって、そこでの局所解析の責務がなくなるわけではない。

有限の行列サイズを固定し、正規化されたCauchyクラスの残差解を R = I + C(h), h ∈ L²(Γ) により定義する。ここで h = R₊ − R₋ はほとんど至る所で成立し、無限遠での正規化は積分路の構造と必要な追加モーメント仮定から正当化する。L² の基礎部分からは非有界半直線から離れた扇形領域での減衰を得る。I + O(1/z) という正規化を主張するには §8.3 の L¹ 制御を要する。端点や頂点に余分な斉次項を加えてはならない。密度 h が跳躍から一意に復元されることを証明する。これは解析的な解クラスの指定であり、境界値が L² に属するという条件だけではない。

さらに、端点等を除いた領域でのCauchy公式に基づく候補の復元判定を定式化して証明する。大きな境界を制御し、各端点と頂点を囲む小円上の積分が0に収束することを要する。この判定の局所仮定は、候補の L² 境界値の存在を述べるだけでなく、小円積分の消滅を導かなければならない。局所パラメトリックスを用いる適用は、変換後の候補についてこれらの評価を供給する。行列式については独立の除去可能性判定を述べる。det R の境界値が一致し、開いた弧、全端点、全頂点を越えて正則に延長し、無限遠で1に収束するなら、その整関数はLiouvilleの定理により1である。跳躍の等式 det(I + w) = 1 だけではこの判定の仮定は満たされない。

**構成・法則（API）**

- 積分路に依存する指定された評価とともに、Cauchy変換、有界な境界作用素、Plemelj関係を構成する。
- 正規化されたCauchy変換クラスを定義し、跳躍から密度を復元し、モーメント仮定が与える正規化の正確な強さを記録する。
- 大きな境界、および端点・頂点の小円についての明示的な評価の下で、候補が跳躍から復元されることを証明する。
- 行列式の正則延長と無限遠での正規化を検証した後に限り、行列式1と行列の可逆性を出力する。

**検証事項**

- 恒等跳躍ならこのクラスでは h = 0, R = I となる。Γ = [0,1] 上の競合候補 I + exp(−1/z)z⁻¹E₁₂ は同じ恒等跳躍と正規化を持ち、境界補正は L² に属してそのノルムの二乗は e⁻²/2 であるが、端点に真性特異点を持つ。h = R₊ − R₋ = 0 から非零の補正は復元できず、Cauchy復元によって除外される。
- 非有界積分路では I は L²(Γ) に属するとは限らない。正規化クラスはアフィンなクラス I + C(L²) であり、行列境界値自体に L² 所属を要求するものではない。
- 跳躍の行列式が1であることからは行列式の境界値の一致が得られる。端点・頂点の除去可能性と無限遠での正規化は、依然として別の責務である。
- 任意の許容された跳躍から復元した解析的残差行列が、それだけで指定した極データを持つ有理型接続になるわけではない。その復元は適用側が担当する。

**本目標が担う補助構成。**

- 積分路の横断的な頂点で、s,t>0 に対し C/(s+t) で抑えられる核の重み付きSchur評価を証明する。重み s^(−1/2)、恒等式 ∫₀∞t^(−1/2)/(s+t)dt=πs^(−1/2)、重み付きCauchy–SchwarzとFubiniからL²作用素ノルム Cπ と有限弧への制限を得る。重みなしの行・列積分は発散する。実際の分岐間の核をこの評価へ帰着する座標と弧長密度の比較も証明する。

*必要な先行結果：* [Native Lp, Fourier and integral calculus](#dependency-lp) (Complex L²/Fourier–Plancherel; Hölder and dominated convergence on the native measure/integral carrier); [Real-line Hilbert transform](#dependency-hilbert-transform) (2.3/B10); [Native contour and Schur foundations](#dependency-cauchy) (Cauchy integral formula; Unweighted Schur estimates).

<a id="target-8-2"></a>
### 8.2 定量的な小ノルムRHP定理

**一般理論。**

**入力条件**

- 入力は target:8.1 の積分路の構造と Cauchy 変換による解クラス、および共通の作用素ノルム評価 ‖C_w‖ ≤ ρ < 1 を満たす w_s ∈ L² ∩ L∞ である。
- パラメータに関する正則性の主張には、Banach 空間 L² ∩ L∞ に値を取る正則依存を仮定する。可逆な跳躍を求める境界問題では、跳躍行列の可逆性を仮定する。
- det R = 1 と行列の可逆性には、det(I + w) = 1 に加えて、別途検証したスカラー行列式の延長・正規化判定を用いる。

§8.1 で証明された積分路の構造と有限の行列サイズを固定する。残差跳躍 J_s = I + w_s, w_s ∈ L²(Γ) ∩ L∞(Γ) に対し、L² 上で C_w f = C₋(fw) と定義する。明示したパラメータ集合上で共通の評価 ‖C_w‖ ≤ ρ < 1 を仮定する。可逆跳躍を要求するRHPを考える場合は J_s のほとんど至る所での可逆性を追加し、行列式1の特殊化では det J_s = 1 をほとんど至る所で要求する。これらの跳躍の代数的条件によって、作用素ノルムの隔たりや行列式の除去可能性判定を置き換えることはできない。

Neumann級数を用いて ν = C₋w + C_wν を ν = (id − C_w)⁻¹C₋w により解き、μ = I + ν, h = μw, R = I + C(h) と置く。h ∈ L²、R₋ = μ、R₊ = R₋(I + w) を証明する。逆に、許容されたCauchyクラスの解からは同じ ν の方程式が得られ、指定クラス内での一意性が従う。構成は ν ∈ L² を用い、非有界積分路上で I や μ が L² に属するとは一度も仮定しない。基本評価 ‖(id − C_w)⁻¹‖ ≤ (1 − ρ)⁻¹ と ‖ν‖₂ ≤ ‖C₋w‖₂/(1 − ρ) を述べ、w が L² ∩ L∞ のノルムで依存するとき、レゾルベント恒等式から連続依存性とBanach空間値の正則依存性を導く。重み付き係数漸近は §8.3 を経てのみ出力する。

作用素による構成が与えるのは、行列値解析関数としての境界跳躍問題の解である。行列式が1で至る所可逆な行列解を得るには、さらに §8.1 の行列式の延長・正規化判定を用いる。det J = 1 だけでは det R = 1 の証明にならない。小ノルム領域の外でも問題が可解である場合はある。その場合は別の逆作用素、消滅補題、または別途仮定を検証した議論を要する。任意の小さな L² 跳躍が、指定した特異点を持つ有理型接続を定めるわけでもない。幾何学的パラメトリックスの還元を戻し、接続とその水平な変動を同定する作業は、下流の適用の課題である。（ILP18 §3.3 補題3.3は具体的な適用を与える。一般のノルム隔たりの定理とその仮定はここで担当する。）

**構成・法則（API）**

- id − C_w の逆作用素、密度 ν、跳躍密度 h、および指定されたCauchyクラスでの一意解 R を構成する。
- 指定された跳躍ノルムにおける逆作用素・誤差の定量評価と、連続依存性またはBanach空間値の正則依存性を証明する。
- 独立した行列式除去可能性判定を用い、検証した領域に限って行列式1と行列の可逆性を得る。
- ノルム隔たりの領域外では別の可逆性証明を許し、小ノルム判定が使えないことから不可解性を推論しない。

**検証事項**

- w = 0 なら構成は ν = h = 0, R = I を与え、Cauchyクラスの一意性と一致する。
- 評価 ‖ν‖₂ ≤ ‖C₋w‖₂/(1 − ρ) は ρ が1に近づく際の必要な損失を記録する。ρ = 1 における一様評価は与えない。
- 小ノルム仮定の不成立は不可解性を意味しない。反時計回りの単位円上の定数跳躍 −I₂ は w = −2I₂, ‖C_w‖ = 2 を満たすが、R_out = I₂, R_in = −I₂ は Cauchyクラスの解であり、h = −2I₂、行列式は1である。
- Neumann級数による解定理は、相空間の次元、接続の形式型、モノドロミーによる選択、有理型接続の復元を前提としない。

*必要な先行結果：* 内部依存：8.1; [Native analytic inversion](#dependency-inversion) (analyticAt_inverse; analyticAt_inverse_one_sub).

<a id="target-8-3"></a>
### 8.3 重み付きモーメント、係数展開、一様な裾の制御

**一般理論。**

**入力条件**

- 共通の ρ < 1 を持つ target:8.2 の族、整数 m ≥ 0、および明記した重み付き L¹・L² モーメントを入力とする。
- 明記した積分路の分母評価を満たす固定の分離扇形領域を用いる。一様評価には共通のモーメント評価を仮定する。
- 一様な little-o には、重み付き L¹・L² の裾の一様緊密性、または明記した別の十分条件を仮定する。さらに強い次次数の big-O には、一つ追加したモーメントの一様有界性を仮定する。

§8.2 で構成した族について整数 m ≥ 0 を固定し、W_m(ζ) = 1 + |ζ|ᵐ と置く。W_m w_s ∈ L¹(Γ) ∩ L²(Γ) を要求する。恒等式 h_s = w_s + ν_s w_s とHölderの不等式から、‖W_m h_s‖₁ ≤ ‖W_m w_s‖₁ + ‖ν_s‖₂‖W_m w_s‖₂ を得る。したがって、共通の小ノルム隔たりと表示した重み付きノルムの一様有界性から、h_s の重み付き L¹ ノルムの一様有界性が従う。無限遠の閉扇形領域について、全 ζ ∈ Γ と領域内の十分大きな z に対し |ζ − z| ≥ c(|ζ| + |z|) が成立するという積分路の評価を証明済みとする。定数 c > 0 は、主張するパラメータによらないものとする。

各固定パラメータについて R_s(z) = I − (2πi)⁻¹Σ_{j=0}^m z⁻ʲ⁻¹∫_Γ ζʲh_s(ζ)dζ + o(|z|⁻ᵐ⁻¹) を証明する。特に z⁻ʲ⁻¹ の係数は、符号を含めて −(2πi)⁻¹∫_Γ ζʲh_s(ζ)dζ である。正確な剰余は (2πi)⁻¹z⁻ᵐ⁻¹∫_Γ ζᵐ⁺¹h_s(ζ)/(ζ − z)dζ となる。優収束定理により固定パラメータでの little-o が得られるが、重み付きノルムの一様有界性だけでは、非コンパクトなパラメータ集合に関して一様な little-o は得られない。一方、この有界性からは、指定された分離扇形領域で R_s = I + O(1/z) が一様に従う。半直線そのものの上で主張する場合は追加の局所的扇形評価を要する。

パラメータに関して一様な little-o には、さらに重み付きの裾の一様緊密性を証明する。すなわち A → ∞ のとき sup_s ‖1_{|ζ|>A}W_m w_s‖₁ と sup_s ‖1_{|ζ|>A}W_m w_s‖₂ がともに0に収束することを要する。先の不等式を裾に制限し、‖ν_s‖₂ の一様有界性を用いると、h_s の重み付き L¹ の裾にも同じ性質が従う。正確な剰余を固定した有界部分と裾に分けると、前者は一様に0に収束し、後者は一様に小さい。十分条件として、パラメータ集合がコンパクトで両方の重み付き空間でノルム連続に依存すること、または重み付きモーメントを一つ追加して一様に有界とすることが使える。後者では、同じ分母評価からさらに強い一様な O(|z|⁻ᵐ⁻²) 剰余を得る。下流の端点・合流・漸近正規化の議論は、実際に用いるパラメータ集合上でこれらの制御を検証しなければならない。各点での優収束はその検証にはならない。

**構成・法則（API）**

- 明示した L¹/L² 評価を用い、重み付きモーメントと重み付きの裾の一様緊密性を w_s から h_s に移す。
- 分母評価を証明した扇形領域で、符号を含む無限遠の各係数と正確な剰余を計算する。
- 各点での little-o、一様な big-O、一様な little-o を区別し、最後の結論は裾の一様制御がある場合に限って出力する。
- コンパクトなパラメータ集合と追加モーメントによる十分条件を証明し、一つの追加モーメントから次の次数のより強い big-O を得る。

**検証事項**

- Γ = ℝ とし、Re s > 1, |Im s| < δ に対して w_s(x) = a exp(−(x − s)²)E₁₂ と置き、a > 0 は a exp(δ²) < 1 を満たすほど小さく取る。これはBanach空間値の正則な小跳躍の族で、0次の L¹/L²/L∞ モーメントは一様有界、行列式は1であり、E₁₂² = 0 により厳密に h_s = w_s となる。0次モーメントは M₀ = a√π E₁₂ である。s = n, z = in において n(C(w_n)(in) + M₀/(2πi·in)) は (a√π/(2πi))((1 − i)/2)E₁₂ ≠ 0 に収束する。したがって各点で o(1/z) である剰余がパラメータに関して一様とは限らない。平行移動する質量は裾の一様条件を満たさない。
- 平行移動Gaussian反例で極限のスカラー因子は 1/(1 − i) − i = (1 − i)/2 である。係数の符号と定数 a√π/(2πi) をともに保たなければならない。
- コンパクトなパラメータ集合上で重み付き L¹ と L² の両ノルムに関して連続なら、両方の重み付きの裾は一様に緊密になる。非コンパクト集合上での有界性だけではこの結論は得られない。
- (m + 1) 次の重み付きモーメントが一様有界なら、同じ分離扇形領域で O(|z|⁻ᵐ⁻²) の剰余を得る。一方、積分路の半直線に沿う主張には依然として別の局所評価が必要である。

*必要な先行結果：* 内部依存：8.2; [Native Lp, Fourier and integral calculus](#dependency-lp) (Complex L²/Fourier–Plancherel; Hölder and dominated convergence on the native measure/integral carrier).

<a id="target-8-4"></a>
### 8.4 標準 Barnes G 関数と枝を正規化した扇形漸近展開

**一般理論。**

既存の複素解析の構造上に、標準 Barnes G 関数を構成する。gamma=Real.eulerMascheroniConstant とし、局所一様に収束する標準積

```math
G(z+1)=e^{\frac z2\log(2\pi)-\frac{z(z+1)}2-\frac{\gamma z^2}2}\prod_{k=1}^{\infty}\left(1+\frac zk\right)^k e^{-z+z^2/(2k)}.
```

によって G を定める。漸化式だけではなく、この積が正規化を固定する。積の正規収束と各因子の零点以外での非消滅、整関数性、G(1)=1、複素共役との両立、および z が非正整数でない場合の G(z+1)=Gamma(z)G(z) を証明する。有理型恒等式としての比較も与えるが、既存の Gamma の極における全域化された値を有理型の極の値として用いない。零点が正確に z=-n (n>=0)、位数が n+1 であることを証明し、局所主要係数と有限積・商に必要な除去可能極限の規則を導く。既存の Complex.Gamma、GammaSeq_tendsto_Gamma、Gamma_ne_zero と解析的正則性を用い、標準積との比較をここで証明する。

D={z in C : z!=0 and |arg z|<pi} 上に、正の実軸で実数値をとる正則な Log z、Log Gamma(z+1)、Log G(z+1) を構成する。これらは正の実軸から接続した解析的対数であり、関数値の主値対数を各点で取る操作ではない。c_A を、正整数 m が無限大に向かうときの sum_(k=1)^m k log k - (m^2/2+m/2+1/12) log m + m^2/4 の極限として定め、その存在を証明して A=exp(c_A) と置く。N≥1 に対して

```math
a_N(z)=\frac{z^2}{4}+z\mathop{\mathrm{Log}}\nolimits \Gamma(z+1)-\left(\frac{z(z+1)}2+\frac1{12}\right)\mathop{\mathrm{Log}}\nolimits z-\log A+\sum_{k=1}^{N-1}\frac{B_{2k+2}}{2k(2k+1)(2k+2)z^{2k}}.
```

と定め、次の展開と明示的剰余評価を証明する。

```math
\mathop{\mathrm{Log}}\nolimits G(z+1)=a_N(z)+R_N(z),\qquad |R_N(z)|\le\frac{|B_{2N+2}|\sec^{2N+1}(\arg(z)/2)}{2N(2N+1)(2N+2)|z|^{2N}}.
```

各 0<delta<=pi を固定すると |arg z|<=pi-delta で O_(N,delta)(|z|^(-2N)) が一様に成立する。証明に必要な有限積の対数和および積分剰余の比較を本目標で証明する。Gamma を残したこの展開を用いることで、未指定の Barnes 理論や扇形上の Stirling 理論を前提としない。定数の zeta 関数の導関数による表示は、この定義・証明および接続公式の前提ではない。

この特殊関数の構成は接続のモジュライ、スカラー微分方程式、RHP の各応用目標に依存しない。8.7 は、ここで正規化された因子と証明された局所除去可能極限の規則を用いる。出典は DLMF 5.17.1、5.17.3、5.17.7 と、Nemes, arXiv:1406.2535v2, 式 (1.1)、定理 1.2 の式 (1.10)、§§2–3 の証明である。

**仮定.**

- 既存の複素数体、極を除くGammaの解析的理論、Euler定数、Bernoulli数を用いる。Barnes関数・積の収束・対数枝・正規化極限・零因子・剰余は構成と証明の出力である。
- 点ごとの漸化式ではzを非正整数から除く。対数漸近ではz≠0、|arg z|<π、整数N≥1、0<δ≤πを明記する。

**API.**

- 局所正規収束する標準積から整関数を構成し、G(1)=1、共役との両立、既存Gammaとの比較を証明する。
- Gammaの極を除く点ごと、および有理型恒等式として漸化式を証明する。全零点の位数、局所主要係数、除去可能な商の極限を得る。
- 解析的対数枝とGlaisher正規化極限を構成し、各閉部分扇形で一様なN項展開と明示剰余を証明する。

**検証事項.**

- G(1)=G(2)=G(3)=1、G(4)=2。0での零点は1位でG(z)/z→1、−1では2位であり、全零点が単純という主張は成り立たない。
- H(z)=exp(sin(2πz))G(z)はH(1)=1、同じ許容領域の漸化式、同じ零因子を持つがGとは異なる。標準積または証明した漸近的な一意性条件が必要である。
- 既存Complex.Gamma 0は0に全域化される。z=0で無条件の漸化式を書くとG(1)=Gamma(0)G(0)=0となりG(1)=1に矛盾する。点ごとの恒等式と有理型接続を区別する。
- N=1、実x>0では初めて省略する係数はB₄/(2·3·4)=−1/720で、剰余は負かつ絶対値≤1/(720x²)。Log GをLog G+2πiで置き換えるとこの消滅する剰余条件に反する。δ>0を保持し、負の実軸に達する極限で一様とはしない。

*必要な先行結果：* [Native Gamma, Bernoulli and analytic carriers](#dependency-gamma) (Complex.Gamma; GammaSeq_tendsto_Gamma; Gamma_ne_zero; Real.eulerMascheroniConstant; Bernoulli numbers/polynomials); [Complex manifolds, holomorphic bundles and observations](#dependency-complex) (K1; K3.0; K3.HolomorphicStalk; K3.MeromorphicGermField; K4; K7.1).

<a id="target-8-5"></a>
### 8.5 境界・扇形領域で解を選択するデータ

**パンルヴェへの適用。**

**入力条件**

- 扇形領域・端、枝、形式データ・Stokesデータの枠付け、必要な例外的ファイバーの持ち上げデータ、および正規化を入力とする。解そのものやその存在をデータの一項目として含めない。

許容された幾何学的な時間族上で、境界選択データを定義する。その内容は、端と扇形領域または指定された接近経路、その時間座標と枝、枠付けを備えた局所的な形式データと Stokes データ、de Rham 持ち上げを選ぶために必要な格子・放物・特異点解消のデータ、要求する観測量またはタウ代表の正規化である。実際の標識変換によって同値性を定義する。このデータは解を含まず、存在や一意性の主張も含まない。指定が解の特徴づけになるのは、その解析的実現定理を証明した後である。スペクトル特異点における線形 Stokes データと、時間の境界における非線形漸近挙動は異なる構成であり、この定理によって結びつけられる。（具体的な実現におけるこの区別については、ILP18, §1.4 および §§3.3–3.4, 4.2–4.3.）

**構成・法則（API）**

- より小さい扇形領域への制限、枝の変更、幾何学的比較による境界指定の移送を構成する。
- 正規化された RHP による実現と付加構造付き相空間点の復元を定式化する。どちらの結果も入力の定義に含めない。
- 指定した正規化問題と選ばれた持ち上げについて一意性を述べ、その後、その点から構成した内在的な水平切断との等しさを証明する。
- 指定した解析接続経路に沿って、同じ切断の二つの明示された漸近正規化を比較するものとして接続定数を定義する。

**検証事項**

- 同じ形式的冪級数による漸近展開を持っていても、指数的に小さい項や Stokes データの自由度が残りうる。そのような切り詰められた指定は、一つの解を自動的に選び出すわけではない。
- 例外的な RH ファイバーが非自明である粗モノドロミーデータは、必要な持ち上げデータなしには、一意の相空間点を特定しない。
- 観測量やタウの枠のスケーリングを変えると、漸近定数の数値が変わる。基礎にある水平切断の同値性によって、その正規化の違いが消えることはない。

*必要な先行結果：* 内部依存：4.1, 4.2, 4.3, 4.5, 4.6, 4.7, 4.8, 6.3, 6.4, 6.5, 7.1, 7.2.

<a id="target-8-6"></a>
### 8.6 パンルヴェ解の Riemann–Hilbert 実現

**パンルヴェへの適用。**

**入力条件**

- 指定した幾何学的 RHP データと parametrix を用いる。輪郭・端点・モーメント・一様な裾の仮定は実際に証明し、跳びの形式的記号から推測しない。

Cauchy 解のクラス、小ノルム逆作用素、重み付きモーメント、パラメータ一様な裾の制御には AnalyticRHPAndDeterminants §§8.1–8.3 を用いる。この節は §8.5 が選ぶ実際の輪郭と局所 parametrix を担う。これらの幾何学的局所モデルについて、Cauchy 作用素の有界性と再構成、剰余表示 R = I + C(h)、端点を囲む小円積分の消失、行列式の除去可能性を証明する。境界の L² トレースだけでは足りない。指定したパラメータ集合で w ∈ L² ∩ L∞、det(I+w)=1、共通の作用素ギャップ ‖C_w‖ ≤ ρ < 1 を確認する。非有界輪郭上で I ∈ L² と仮定せず、一般の ν = C₋w + C_wν の解を用いる。

主張する各係数と一様剰余について、target:8.3 の実際の重み付き L¹/L² モーメントと裾の仮定を確認する。重み付きノルムの一様有界性だけでは、パラメータ一様な little-o は得られない。§§8.7、9.8 で用いる正確なパラメータ集合上で、重み付き裾の一様緊密性、コンパクトなノルム連続パラメータ制御、または追加モーメントを与える。一般評価と反例は解析枠組みに置く。

確認した parametrix 還元を戻し、§4.1 により付加構造付き接続を再構成し、そのパラメータ変動を目標3.9–3.12の強い分裂と同定する。一意性で局所解を比較し、目標4.5–4.9で延長する。任意の小さな跳びが、この有理型接続問題を指定するわけではない。確認した小ノルム領域の外では、別の消失補題・可逆性の議論を与え、その仮定を証明する。（ILP18, §3.3, Lemma 3.3 は具体的適用である。）

**構成・法則（API）**

- 一般の Cauchy クラスへの、輪郭・端点・行列式除去可能性の適用条件を証明する。
- 選んだ漸近結論に必要な、一様ギャップと正確な重み付き裾の制御を確認する。
- 実際の付加構造付き接続を再構成し、その水平性と重なりの比較を証明する。

**検証事項**

- 恒等ジャンプは、このクラスでは h = 0, R = I を与える。Γ = [0,1] 上で、別の候補行列 I + exp(−1/z)z⁻¹E₁₂ は同じ恒等ジャンプと正規化を持ち、L² 境界補正のノルムの二乗は e⁻²/2 であるが、端点に真性特異点を持つ。これは Cauchy 復元によって除外される。h = R₊ − R₋ = 0 から、その非零の補正項を復元することはできない。
- 評価 ‖ν‖₂ ≤ ‖C₋w‖₂/(1 − ρ) は、ρ が 1 に近づく際の不可避な評価の悪化を記録するものであり、ρ = 1 での一様評価を与えない。
- 小ノルム仮定が成り立たないことは、非可解性を証明しない。反時計回りの単位円上で、定数ジャンプ −I₂ は w = −2I₂, ‖C_w‖ = 2 を持つ。それでも解 R_out = I₂, R_in = −I₂ は Cauchy クラスに属し、h = −2I₂ かつ行列式は 1 である。
- Γ = ℝ 上で、Re s > 1, |Im s| < δ のもとに w_s(x) = a exp(−(x − s)²)E₁₂ とおき、a exp(δ²) < 1 となるように a > 0 を十分小さく選ぶ。これは、零次の L¹/L²/L∞ モーメントが一様に有界な Banach 空間値の正則な小ジャンプ族であり、ジャンプの行列式は 1 で、E₁₂² = 0 によって密度は正確に h_s = w_s となる。その零次モーメントは M₀ = a√π E₁₂ である。s = n, z = in において、n(C(w_n)(in) + M₀/(2πi·in)) は (a√π/(2πi))((1 − i)/2)E₁₂ ≠ 0 に収束する。したがって、各パラメータでの o(1/z) の剰余がパラメータについて一様であるとは限らない。平行移動する質量は裾の一様条件を満たさない。

*必要な先行結果：* 内部依存：3.9, 3.10, 4.1, 4.5, 4.7, 8.5, 8.1, 8.2, 8.3.

<a id="target-8-7"></a>
### 8.7 接続公式と接続定数

**パンルヴェへの適用。**

**入力条件**

- 正確に列挙した一般的位置のPVIおよび斉次PIIのモノドロミー部分、選択した枝・正規化、供給されたHastings–McLeod対象・Fredholm恒等式、ならびにそれ以前のRHPとBarnes関数の枠組みを入力とする。端点公式、補助的な座標で除外された点を越える接続、およびDIK・HXZ・HMの扇形領域での定数決定に必要な評価は、仮定された出力恒等式ではなく、証明すべき課題である。

ILP18 の Theorems A and B を境界データの言葉に翻訳し、その正規化された RHP による実現を証明して、端点の恒等式と定数比の恒等式を目標6.2–6.5の切断へ移す。パラメータの対応と枝の選択を明示する。目標は以下に指定する文献の範囲であり、対応する方程式のすべてのパラメータではない。

Theorem A には、ν = 0,t,1,∞ に対して固有値 ±θ_ν, 2θ_ν ∉ ℤ を持つ四つの対数留数、標識付きモノドロミー三次曲面 (1.16)、および σ,ρ ≠ 0, 0 ≤ Re σ, Re ρ < 1/2 を満たす σ = σ₀ₜ, ρ = σₜ₁ を用いる。次の四つの集合のすべての元が ℤ に属さないことを要求する：{θ₀ ± θₜ ± σ}, {θ∞ ± θ₁ ± σ}, {θ₁ ± θₜ ± ρ}, {θ∞ ± θ₀ ± ρ}。二つの符号は独立に選ぶ。これらが (1.13) および (1.17) の条件である。文献の t ∈ (0,1) での端点の枝と JMU 正規化を用いて、漸近式 (1.18a–b) と、C₁/C₀ が Barnes G による式 (1.19) に等しいことを、(1.20–1.21) の量をそのまま用いて証明する。Propositions 3.20 and 3.24 および §3.9 が証明目標を与える。(1.21) の補助的な分母が零となる部分では、零分母にも値を割り当てて除算するのではなく、証明した式の延長を用いる。

Theorem B には、斉次 PII, q″ = 2q³ + tq と、文献の Stokes 曲面 s₁ − s₂ + s₃ + s₁s₂s₃ = 0 を用いる。s₁s₃ ≠ 1, Arg(1 − s₁s₃) ∈ (−π,π), s₂ ∉ ℝ および Arg(iϵs₂) ∈ (−π/2,π/2) を要求し、ここで ϵ = sign Re(is₂) ∈ {−1,1} とする。これらが (1.25) の条件である。d log τ = (q′² − q⁴ − tq²)dt のもとで、二つの実半直線に沿う漸近式 (1.26) と、C₊/C₋ が (1.28) に等しいことを証明する。μ,ν は (1.27) に従い、exp(iπη) = −iϵ/s₃ とする。η の式をそのまま用いる座標には s₃ ≠ 0 が必要である。記載された η ↦ η + 2 の不変性、正規化の比較、およびさらに許容されるデータへの解析的延長を証明する。未定義の商に対して指数関数の対数を割り当ててはならない。証明の参照箇所は §§4.3–4.5 および Remark 4.8 であり、Barnes 関数の領域と除去可能な極限を明示する。

ILP18 §4.5 の絶対定数の決定と、モノドロミーに依存する変分計算を分ける。その補助的な証明目標は、DIK08 Theorem 1, (2)–(3) の Airy 行列式定数 χ = (log 2)/24 + ζ′(−1)、HXZ16 Theorem 2.1 の複素扇形領域での無極性、および ILP18 (4.74)–(4.76) で用いる一様な複素扇形領域でのハミルトニアンの漸近式と円弧評価である。既存の Hastings–McLeod 対象と Fredholm 恒等式は RandomMatrices §8.5 から用いる。その前提契約と最初の二つの評価から、三つ目の評価が従うわけではない。

三つ目の補助目標については、提供されたスカラー対象を用い、二つ目の存在定理を証明することなく、arg z ∈ [−π/3,0] および [2π/3,π] 上で Hastings–McLeod の正規化された RHP と扇形パラメトリックスを構成する。境界を含む扇形領域での一様評価と重み付き剰余評価を伴って §8.6 を適用し、ハミルトニアンの漸近式 (4.74) を得る。H_HM を ILP18 のハミルトニアンの正規化とし、第1の扇形領域では H_HM(z)dz、第2の扇形領域では (H_HM(z) − z²/4 + 1/(8z))dz の、向き付き大円弧上の積分が零に収束することを証明する。これら二つの極限を正当化する一様評価を、境界半直線も含めて明示し、証明する。実半直線上の漸近式だけでは不十分である。ILP18 は扇形領域への解析接続について FIKN を引用し、この段階で Jordan 型の評価を用いる。本ロードマップでは、この正確な扇形評価を RHP・パラメトリックスに関する自らの証明目標とし、FIKN 理論全体を記録なく持ち込まない。円弧積分の極限を確立したうえで、残る対数項の寄与が +iπ/24、定数の正規化が exp(χ + iπ/24) となることを計算する。

円弧に関する定量的な契約は次のとおりであり、z = R exp(iθ) と十分大きな R に対して一様に成り立つことを求める。第1の扇形領域では |H_HM(z)| ≤ C R⁻¹ exp(−(4/3)R³ᐟ² cos(3θ/2)) + C R⁻⁵ᐟ² を証明する。第2の扇形領域では φ = θ − π, c = 2√2/3 とおき、|H_HM(z) − z²/4 + 1/(8z)| ≤ C R⁻¹ᐟ⁴ exp(−cR³ᐟ² cos(3φ/2)) + C R⁻¹ exp(−2cR³ᐟ² cos(3φ/2)) + C R⁻⁷ᐟ⁴ を証明する。これらは、境界で一様な剰余を伴う、扇形領域での完全な展開 (4.74) に対する評価である。余弦は振動的な境界で単純零点を持つため、各指数関数の角度積分は O(R⁻³ᐟ²) となる。弧長因子 R を掛けると、第1の円弧の評価は O(R⁻³ᐟ²)、第2の円弧の評価は O(R⁻³ᐟ⁴) となり、必要な消滅を得る。

**検証事項**

- 共鳴指数 2θ_ν ∈ ℤ は、この PVI の実現から除外される。対応する付加構造付き相空間対象が理論の中核に属しうることとは別である。
- 文献の PII は α = 0 である。ラベルを変えても、その定理が任意の α に対する接続公式になるわけではない。
- Stokes 三つ組 (i,i,0) は (1.25) を満たすが、1/s₃ を含む η の式をそのまま適用できない。延長された式には独自の証明が必要である。
- Hastings–McLeod の境界 Stokes データは、この一般の PII 入力の条件を満たさない。この定理も端点での滑らかさも、途中のすべての時間区間を通じて極が存在しないことを主張しない。
- 整関数 exp(−z²) は実軸の両端で任意の冪より速く減衰するが、arg z = −π/3 上では絶対値 exp(R²/2) を持つ。したがって、無極性と実半直線上の減衰だけでは扇形領域の円弧評価を満たさず、上記の明示的な一様重み付き評価が不可欠である。

*必要な先行結果：* 内部依存：6.4, 6.5, 7.1, 7.2, 7.4, 7.5, 8.5, 8.6, 8.4; [Airy, Fredholm and Hastings–McLeod theory](#dependency-airy-hm) (8.4; 8.5).

<a id="target-8-8"></a>
### 8.8 相空間上の Hastings–McLeod 解

**パンルヴェへの適用。**

**入力条件**

- 供給された正規化済みの実Hastings–McLeod解と、正則な実時刻におけるその微分を入力とする。別の存在理論を構成しない。

RandomMatrices §8.5 がすでに担当するスカラーの結果、すなわち q″ = tq + 2q³ の正規化された実 Hastings–McLeod 解、その一意性と実軸上の無極性を用いる。正則な実時刻 t₀ で、§7.1 の 1 次ジェット逆写像を用い、(q(t₀),q′(t₀)) から内在的な相空間点を構成する。§§4.5–4.7 を適用し、得られる水平切断の評価が、実領域と共通の解析接続上で提供されたスカラー解に一致することを証明する。一意性と 1 次ジェットの重なりの比較によって、t₀ からの独立性を証明する。実初期値は局所的な複素解析解を定めるが、それだけで境界挙動を証明するわけではない。境界挙動は提供元の結果を用いる。

一次文献による座標比較は VDPS09 §4.10 であり、これを §7.5 の運動量とハミルトニアンの正規化へ移す。この文献が与えるのは座標であり、RandomMatrices から用いる Hastings–McLeod の存在定理ではない。

**構成・法則（API）**

- 提供された 1 次ジェットから、相空間点および水平切断への橋渡しを構成する。
- スカラー評価、および相空間座標の変更を通じた解析接続との可換性を証明する。
- この評価を通じて、提供元の実数性と実軸上の無極性の主張を移す。Airy 正規化はそのまま保持する。

**検証事項**

- q ∼ Ai を k ≠ 1 に対する q ∼ k Ai へ置き換えると、同じ提供元の契約を満たさない。
- 別の正則な実初期時刻を選んでも、移送後には同じ水平切断が得られる。二つ目の特別な解が生じるのではない。
- 実軸上の無極性は、複素時刻での極の不在を主張しない。この橋渡しから、そのより強い主張を推論しない。

*必要な先行結果：* 内部依存：4.5, 4.6, 4.7, 4.8, 4.9, 7.1, 7.5; [Airy, Fredholm and Hastings–McLeod theory](#dependency-airy-hm) (8.4; 8.5).

#### 例

恒等ジャンプのモデルによって RHP の正規化を確認する。一般の PVI と斉次 PII の指定した範囲によって、証明された接続公式と、制限のない全パラメータの主張を区別する。Hastings–McLeod との橋渡しによって、独立して担当されるスカラー理論との相互利用を確認する。その式を内在的な力学の定義に用いることはない。

#### 依存関係

各目標の「必要な先行結果」と `design/reuse_registry.json` の枠組み間参照を用いる。一般証明の前提は独立したパッケージに置き、この層では指定した適用比較を確認する。

<a id="layer-9"></a>

## レイヤー9：合流と収束

<a id="algebraic-confluence"></a>

**目的。** 二つの再利用可能な結果を独立させる。第一は、任意の有限次元係数を持つ線形なLaurent代数と、その初等的な解析的収束の帰結である。第二は、有限局所自由代数から相対双対上のPoisson構造を構成するものである。どちらも Painlevé 方程式、primitive端点の条件、相空間の次元、漸近解、モジュライの商を要しない。

### 極相殺と Poisson 構造

| 仕様 | 入力 → 出力 | 証明担当 |
| --- | --- | --- |
| 9.1 | ベクトル値Laurent関数芽と主部の相殺 → 厳密な有理恒等式、極限係数、コンパクト集合上の一様収束 | 本ロードマップ：9.1 |
| 9.2 | 有限局所自由可換代数 A → (gl_n ⊗ A)∨ 上の相対Poisson構造、基底変換、全係数の符号移送 | 本ロードマップ：9.2 |

二つの目標は独立している。接続の衝突は両方を用い得るが、どちらの一般定理も、その衝突の幾何学的結論を仮定にしない。因子や係数の表示からは比較補題を得る。一般のPoisson対象をその表示で定義するわけではない。行列式、形式型、相対軌道の条件、簡約の存在、水平接続の極限は、利用する適用側の責務として保つ。

<a id="target-9-1"></a>
### 9.1 有限次元係数を持つ有限主部の相殺

**一般理論。**

**入力条件**

- 有限次元複素ベクトル空間 V、整数 r ≥ 0、および明記した極次数の上界を満たす収束する有理型・正則関数芽を入力とし、P は単純零点を持つとする。
- 主部の相殺は表示した B_j の定義による。有限恒等式、係数公式、およびコンパクト集合上一様な収束は証明の出力である。
- 極の位数が正確に r + 2 となる結論には W ≠ 0 を仮定する。接続、Poisson 簡約、形式型分類、または原始的端点の条件は仮定しない。

V を任意の有限次元複素ベクトル空間、r ≥ 0 を整数とする。ε = 0 における収束する有理型関数芽を用いる。P(ε) = t₁ε + ⋯ + tᵣ₊₁εʳ⁺¹ + O(εʳ⁺²), t₁ ≠ 0 とし、V 値 C(ε) の極の位数は高々 r + 1、ε⁻ʳ⁻¹ の係数を W とする。0 ≤ j ≤ r に対し D_j(ε) を V 値正則関数芽とする。Laurent関数芽 f の負の部分、定数係数、非負の部分をそれぞれ [f]_<0, [f]₀, [f]_≥0 と書く。B_j = −[CPʲ]_<0 + D_j と定義し、

A_ε(z) = Σⱼ₌₀ʳ B_j(ε)/zʲ⁺¹ + C(ε)/(z − P(ε))

と置く。次の厳密な有限恒等式を証明する。

A_ε(z) = Σⱼ₌₀ʳ (D_j(ε) + [C(ε)P(ε)ʲ]_≥0)/zʲ⁺¹ + C(ε)P(ε)ʳ⁺¹/[zʳ⁺¹(z − P(ε))].

この恒等式に必要なのは V のスカラー倍だけである。C(ε)P(ε)ʳ⁺¹ が t₁ʳ⁺¹W に収束し、ℂ \ {0} の各コンパクト部分集合上で A_ε が Σⱼ₌₀ʳ (D_j(0) + [CPʲ]₀)/zʲ⁺¹ + t₁ʳ⁺¹W/zʳ⁺² に一様収束することを証明する。ε の円板を縮めれば、固定したコンパクト集合 K 上で |z − P(ε)| ≥ dist(K,0)/2 が成立する。したがって有限の有理式の剰余から一様収束を証明でき、制御していない無限級数との交換を要しない。複素線形写像 V → V′ に関する自然性を証明する。可逆なパラメータ代入 ε = φ(η) に対して C, P, B_j を合成で移し、D′_j = B_j ∘ φ + [(C ∘ φ)(P ∘ φ)ʲ]_<0 と定義する。D′_j が正則であり、同じ有理関数族と極限係数を与えることを証明する。主部への射影自体は非線形な代入と可換ではなく、正則項 D_j にこの補正が必要である。変換後の主要係数は (t′₁)ʳ⁺¹W′ = t₁ʳ⁺¹W を満たす。z 座標の変更は有理式の別の比較であり、変換せずに個々の係数を同一視することではない。

係数 t₁ʳ⁺¹W が非零であることと W が非零であることは同値である。その場合、極限の V 値有理関数は z = 0 で位数 r + 2 の極を持つ。V = M_n(ℂ) の場合、これは行列の極の位数の主張であり、射影的Katz slopeや形式標準形を与えない。一方、C = O(ε⁻ʳ) なら CPʳ⁺¹ = O(ε) となり、新しく生じるはずの最高係数は0である。これが GMR23 定理2、印刷頁1391–1392、式(12)–(15)の極の位数を上げる主張を用いる前に必要となる添字・尺度の修正である。修正した補題はここで証明し、印刷された主張を前提にしない。適用に現れる時間依存の係数基底が実際のLaurent係数と一致するかどうかは、適用側で検証しなければならない。

**構成・法則（API）**

- 任意の有限次元係数空間について主部の相殺を構成し、厳密な有限有理恒等式を証明する。
- 全ての極限係数を計算し、衝突点を避ける各コンパクト集合上での一様収束を証明する。
- 線形な係数写像および可逆なパラメータ代入との両立を証明し、D_j に必要な正則補正を含める。
- 非零の最高行列極係数と形式的なslopeを区別し、不十分な尺度 C = O(ε⁻ʳ) ではその係数が失われることを示す。

**検証事項**

- r = 1 で C = W/ε², P = t₁ε + t₂ε², B₀ = −W/ε², B₁ = −t₁W/ε とすると、極限は t₂W/z² + t₁²W/z³ である。t₁ = 1, t₂ = 0 では式全体が W/[z²(z − ε)] と等しい。これに対して C = W/ε, B₀ = −W/ε, B₁ = W, P = ε とすると極限は 2W/z² であり、3位の極の係数は0である。
- r = 0 で C = W/ε, P = t₁ε, B₀ = −W/ε + D₀ とすると、極限は D₀(0)/z + t₁W/z² である。公式はこの最小の衝突も含まなければならない。
- W = 0 なら最高係数は消える。この場合に位数 r + 2 の極や、非零の主要項で定まる形式型の層の保存を主張しない。
- 線形汎関数 V → ℂ を相殺の前後どちらで適用しても同じスカラー公式を得る。V = M_n(ℂ) を選んでも係数の添字は変わらず、この補題に行列の交換子は現れない。
- r = 0, C = 1/ε, P = ε, B₀ = −1/ε, D₀ = 0 で ε = η + cη² と代入すると、[C ∘ φ]₀ = −c, D′₀(0) = c となり、極限の単純極係数は0のままである。補正なしに D′₀ = D₀ ∘ φ と置くと、誤った係数 −c を得てしまう。

**本目標が担う補助構成。**

- 既存のスカラー有理型芽の主要部・正則剰余と FormalLaurentPuiseux L1/L3 の形式的なベクトル値比較を用いる。スカラー成分から有限次元の収束芽を構成し、基底独立性・線形自然性・解析的Laurent係数と形式係数の一致を証明する。解析的なコンパクト一様収束は実際の有理式の剰余で証明し、形式的付値収束から推論しない。

*必要な先行結果：* [Formal scalar and vector-valued Laurent algebra](#dependency-formal-series) (L1–L4; L5–L6 for finite-extension steps in 1.1); [Native convergent meromorphic germs](#dependency-meromorphic-germs) (meromorphicGerms.principalPart; principalPart_eq_iff; principalPart_eq_sum_coeff; Analytic regular remainder); [Complex manifolds, holomorphic bundles and observations](#dependency-complex) (K1; K3.0; K3.HolomorphicStalk; K3.MeromorphicGermField; K4; K7.1).

<a id="target-9-2"></a>
### 9.2 有限局所自由代数族の双対上の相対Poisson構造

**一般理論。**

**入力条件**

- 複素代数的または複素解析的な基底 B、有限局所自由な可換 O_B 代数 A、および整数 n ≥ 1 を入力とする。
- 留数による表示には、滑らかな相対曲線内の有限平坦 Cartier 因子と、その実際の双対化・留数比較データを追加する。一般の A について A ≅ A∨ という同定は仮定しない。
- KKS または簡約との両立には、指定した滑らかな軌道の領域と、その仮定を検証した両立するモーメント写像・簡約データを入力とする。Poisson 括弧と符号同型が、それらの領域や商を構成するわけではない。

B を複素代数的または複素解析的な底空間、A を有限局所自由な可換 O_B 代数、n ≥ 1 とする。局所自由なLie代数 L = gl_n(O_B) ⊗ A を [X ⊗ a, Y ⊗ b] = [X,Y] ⊗ ab によって構成する。相対双対ベクトル束 L∨ 上で、ℓ_X(ν) = ν(X) に対して正符号の線形Poisson括弧を {ℓ_X,ℓ_Y}₊ = ℓ_[X,Y] と内在的に定義し、双導分則によって拡張する。対応する代数的または正則な相対Poissonテンソルを構成し、Jacobi恒等式と基底変換との両立を証明する。この構造は B に相対的であり、底空間方向のPoisson括弧を主張するものではない。負符号の規約は {f,g}₋ = −{f,g}₊ と定義する。

ファイバーの符号反転 N(ν) = −ν が、負符号から正符号へのPoisson同型になることを証明する。すなわち {N*f,N*g}₋ = N*{f,g}₊ である。これはTakiff座標表示の全次数を含め、全ての線形係数を反転する。係数行列の恒等写像はこの比較ではない。単元の相対群 GL_n(A) とその余随伴作用を構成し、N の同変性を証明する。既に指定された滑らかな余随伴軌道の領域上で、対になったKKS規約 ω_±,ν(ad*_Xν,ad*_Yν) = ±ν([X,Y]) を比較し、N*ω₊ = ω₋ を証明する。H₊ ∘ N = H₋ に対して、記録した対の規約を用い、対応するHamiltonianベクトル場の移送を証明する。既に与えられた、規約が両立するモーメント写像・正則な簡約のデータを、この同変な比較によって移す際には符号規約も記録する。出力するのはデータが存在する領域での両立性であり、任意の商の存在、相対軌道の平坦性、簡約領域の滑らかさではない。

実際の双対を基礎対象として保つ。トレース対は L∨ を gl_n(O_B) ⊗ A∨ と同定するが、A∨ と A は同定しない。適用側から、滑らかな相対曲線内の有限平坦Cartier因子 P が与えられる場合は、p: P → B と書き、A = p_*O_P に対して A∨ ≅ p_*ω_P/B を構成する。ここで ω_P/B ≅ ω_C/B(P)|_P は相対双対化加群である。これによって得られる A との完全な留数対を証明する。局所多項式表示 A = O_B[z]/(Q(z)) で Q が次数 m のモニック多項式である場合、座標補題は双対化加群の生成元を dz/Q に対応させ、Frobenius汎関数 λ_Q(f) を次数 m 未満の代表の zᵐ⁻¹ 係数と同定する。同値に λ_Q(f) は因子上での f(z)dz/Q(z) の留数の和である。完全性、基底変換、表示変更との両立を証明し、係数とともに微分形式の生成元も移す。一般の有限局所自由 A がこのようなFrobenius同定を持つとは限らない。その双対上の内在的Poisson構造にこの同定は必要ない。

分裂したファイバー A ≅ ∏_i ℂ 上では、Lie代数と括弧が対応して分裂する。局所ファイバー A ≅ ℂ[z]/zᵐ では、Takiff座標公式 [Xzⁱ,Yzʲ] = [X,Y]zⁱ⁺ʲ（i + j < m）と、i + j ≥ m では0となること、および双対上の対応する線形Poisson公式を証明する。これらは有限代数による内在的構成の座標補題である。GMR23 の括弧(96)–(97)との比較では、負符号の規約をファイバーの符号反転で移す。接続の規約 dY/dz = A_source Y と ∇ = d + A_ours の比較には、さらに A_ours = −A_source を要し、留数・指数の係数も一貫して変換する。GMR23 §4.2 の定義3–4と定理12は、そこで指定された領域のモデルであり、任意の局所条件の軌道や衝突の簡約が平坦・正則であることの証明ではない。

**構成・法則（API）**

- A の積から相対双対上の線形Poisson構造を構成し、Jacobi恒等式、代数同型に関する関手性、基底変換を証明する。
- ファイバーの符号反転を同変なPoisson同型として構成し、対になったKKS・Hamiltonian・検証済みの簡約の規約を移す。
- 双対の基礎対象として A∨ を保ち、留数・Frobeniusの座標比較は指定した曲線または多項式の入力がある場合にのみ証明する。
- 分裂代数と切断多項式代数の座標公式を導き、全Takiff次数と文献から供給側への完全な符号写像を含める。

**検証事項**

- O_Δ[z]/(z(z − ε)) は ε ≠ 0 で二つの点の代数の積となり、ε = 0 では ℂ[z]/z² となる。z の中心的な冪零類は比較に含まれる。
- X = E₁₂, Y = E₂₁, ν_source = diag(1,−1)/2 のとき、文献側の線形Poisson括弧は −1 である。ν_ours = −ν_source では正符号の供給側の括弧も −1 となる。ファイバーの符号反転による引き戻しは一致するが、恒等比較では +1 となる。Takiff代数では二つの次数の和が切断次数を超えると括弧は0になる。
- Q(z) = z(z − ε), f = a + bz なら λ_Q(f) = b である。ε ≠ 0 ではこれは [f(ε) − f(0)]/ε に等しく、ε = 0 では残存する冪零類 z の係数となる。分離した点による表示には 1/ε が現れるが、双対化の対は存続する。
- A = ℂ[x,y]/(x,y)² では、どの汎関数 λ に対しても (a,b) ↦ λ(ab) は退化する。span{x,y} に含まれる λ の核の非零元は、全ての A と0の対を持つ。したがって一般の有限局所自由代数を、未指定のFrobenius汎関数で双対と同定することはできない。一方、双対上のPoisson構成はそのまま適用できる。
- ファイバーの符号反転写像は、選んだ軌道族が平坦であることや、目的の複素シンプレクティック商が存在することの根拠にはならない。それらは適用側の独立した仮定または構成目標である。

**本目標が担う補助構成。**

- 滑らかな相対曲線 C→B の有限平坦な有効相対Cartier因子 p:P→B に対し、随伴 ω_(P/B)≅ω_(C/B)(P)|P と有限平坦双対 p_*ω_(P/B)≅Hom_B(p_*O_P,O_B) を証明し、留数で正規化したトレース、基底変換、パラメータ変更との整合性を示す。次数mのモニック表示Qでは λ_Q(f)=coefficient_(m−1)(f mod Q) の完全性を証明して留数トレースと比較し、貼り合わせる。この追加仮定付き定理を実施対象に含め、任意の有限局所自由代数を完全対なしに双対と同一視しない。

- 解析版では、1.2 の解析的基礎部分が構成する複素解析空間と連接・有限局所自由層の対象を用い、冪零係数を保持する。局所自明化から相対ベクトル束と単元群のチャートを構成し、貼合せと基底変換を証明する。相対複素 Poisson 構造、余随伴作用、留数、および仮定付き簡約の比較は 9.2 が担う。共通の対象を用いることで、接続モジュライ・RH・パンルヴェの定理を前提にはしない。

*必要な先行結果：* 内部依存：1.2; [Smooth real linear Poisson signs](#dependency-poisson) (G4.6A); [Algebraic vector bundles and finite locally free sheaves](#dependency-bundles) (L0A–L0C; L1A–L1B; L2A–L2B); [Cohomology, duality and curve degree](#dependency-cohomology) (2.2; 2.6; 2.20; 3.3).

### 文献と適用範囲

書誌情報と文献中の参照箇所は [sources.toml](sources.toml) に記す。[GMR23](https://doi.org/10.1007/s00220-023-04650-8) の関連箇所は、9.1で明示的に修正する定理2の式(12)–(15)、§4.2の定義3–4と定理12、および括弧(96)–(97)である。文献の§5.1がPainlevéの実現を非分岐の場合に制限していることは、その適用の制限であり、上記二つの初等的な一般仕様の制限ではない。任意の軌道の平坦性、簡約の存在、primitive端点としての許容性を文献の定理から推論しない。

<a id="target-9-3"></a>
### 9.3 対数1形式から得る正規化切断の収束

**一般理論。**

**入力条件**

- 共通の連結かつ単連結な複素領域、正則線束の明示的な同型、固定した非消滅フレーム、正規化因子、およびスカラー代表が消えない共通領域を入力とする。
- 正規化した非零値が収束する共通の基点と、明記したコンパクト経路族上一様な、実際の補正済み対数1形式の積分の収束を仮定する。
- 1形式の局所一様収束を十分条件として用いる場合、各コンパクトな経路終点集合に対し、経路を一つの共通のコンパクト集合に収め、その長さを一様有界とする。漸近端点での結論はこの補題に含めない。

行列式や微分方程式からの由来に依存せず、任意の正則直線束の切断に対する収束補題を証明する。共通の連結かつ単連結な複素領域 Ω と固定点 s₀ を取る。正則直線束 L_ε、切断 σ_ε、比較同型 Φ_ε: L_ε → L₀、Ω 上の L₀ の消えない正則フレーム e、および指定された消えない正則正規化因子 c_ε を入力として与える。ε = 0 も含め Φ_ε(c_εσ_ε) = f_ε e と書き、考察する全 f_ε と f₀ が消えない共通領域に制限する。これらの比較と共通非消滅領域の存在は入力であり、未指定の退化から従うものではない。正規化因子によって発散因子を除いてよいが、そのパラメータ微分と選んだフレームを、実際の補正済み1形式 α_ε = d log f_ε に含めなければならない。

各コンパクト K ⊂ Ω に対し、s₀ から s ∈ K への区分的に滑らかな経路 γ_s を選ぶ。経路は共通のコンパクト K′ ⊂ Ω に含まれ、固定した局所計量に関して長さが一様有界であるとする。f_ε(s₀) → f₀(s₀) ≠ 0 と sup_{s∈K}|∫_{γ_s}(α_ε − α₀)| → 0 を仮定する。そのような各 K′ 上で1形式が一様収束すれば十分である。f_ε(s)/f₀(s) = [f_ε(s₀)/f₀(s₀)] exp(∫_{γ_s}(α_ε − α₀)) を証明し、局所一様収束 f_ε → f₀ を導く。対数微分の恒等式から経路への非依存性を証明する。別の定式化として、単連結領域上の閉じた正則1形式と基点での非零値から、原始関数を指数化して一意な消えないスカラー代表を構成する。

この補題はFredholm実現も、接続・漸近パラメトリックス・合流幾何に関する目標も要しない。それらの適用では、まず直線束とフレームの比較を構成し、候補の変分形式が表示した対数微分に実際に等しいことを証明しなければならない。特にJMU表示やHamiltonian表示を用いるには、その比較を別途証明する必要があり、共鳴・分岐端点へ自動的に延長してはならない。BERT17 の命題2.3、式(3.6)、定理3.3、§3.1.2 と、比較が証明された領域での BERT16 定理2.2 は、こうした入力の候補に関するものであり、普遍的な同定を与えるものではない。この証明が扱うのは共通の非消滅領域である。零点を越える場合は別途正則代表を用い、可能な場合には §9.4 の行列式収束の経路を使う。端点の接続定数や非線形Stokes極限には、追加の一様扇形評価と、両立した漸近正規化を要する。

**構成・法則（API）**

- 比較・正規化した直線束の切断を指定された一つのフレームで表示し、全スカラー因子を実際の対数微分に含める。
- 基点での正規化とコンパクト経路族上の評価から、指数積分恒等式とスカラーの局所一様収束を証明する。
- 単連結領域上の閉じた正則1形式と基点での非零値から、消えない代表を構成する。
- 比較公式、零点を越える議論、端点または接続定数の極限については、独立した証明責務を保つ。

**検証事項**

- τ_ε に制御されない ε 依存の非零定数を掛けても d log τ_ε は変わらないが、収束は壊れ得る。基点での正規化は不可欠である。
- τ_ε(z) = z − ε ではスカラー行列式は零点を越えて収束するが、対数微分は零点の近傍で一様収束しない。
- 固定した任意のコンパクト時間区間上での収束からは、端点の漸近評価の一様性は得られず、それだけで極限の接続定数を定めることはできない。
- 直線束のフレームの変更やパラメータ依存の正規化因子は、それ自体の対数微分だけ対数1形式を変える。収束評価を使う前に比較へこの補正を含めなければならない。

*必要な先行結果：* [Complex manifolds, holomorphic bundles and observations](#dependency-complex) (K1; K3.0; K3.HolomorphicStalk; K3.MeromorphicGermField; K4; K7.1).

<a id="target-9-4"></a>
### 9.4 トレースノルムによる行列式収束と局所零点計数

**一般理論。**

**入力条件**

- 固定した Hilbert 空間と、トレースクラスノルムで正則な作用素族を入力とし、コンパクトなパラメータ集合上一様なトレースノルム収束を仮定する。
- Hilbert 空間が動く場合は、積分路と測度の因子も含め、妥当性を検証した同定と、共役して得た作用素の収束を指定する。線束の切断の実現を主張する場合、その実現は別途与える入力である。
- 零点計数では、複素1変数、区分的に滑らかな境界を持つ固定した相対コンパクトな有界領域、その閉包近傍での共通の正則性、および境界上で消えず恒等的にも零でない極限行列式を仮定する。

RandomMatrices §8.3 の一般トレースクラス行列式とトレースノルム連続性を、その供給側が実際に扱う作用素の範囲内で用いる。一つの固定した複素Hilbert空間 H 上で、K_ε(s) を共通の複素領域 Ω においてトレースノルムで正則なトレースクラス作用素族とする。Ω の各コンパクト部分集合上で K_ε → K₀ がトレースノルムに関して一様に成立すると仮定する。D_ε(s) = det_H(id − K_ε(s)) が正則で、D₀ へ局所一様に収束することを証明する。各コンパクトなパラメータ集合 K に対し、像 K₀(K) はトレースノルムでコンパクトである。この像の各点での一般行列式の連続性と有限部分被覆を用い、K 上のトレースノルム一様収束からスカラー行列式の一様収束を得る。正則な族に関する主張は、ここで構成するトレースノルム評価と外冪級数の正規収束から証明する。これはスカラー正則代表の定理であり、その零点を含めてよい。零点を越えて対数微分を積分する議論ではない。

作用素が最初は異なるHilbert空間 H_ε に作用する場合は、有界逆を持つ有界複素線形同型 U_ε: H_ε → H を指定し、共役によって K_ε を移し、移した作用素のトレースノルム収束を証明する。動く積分路のパラメータ表示、向き、測度因子を同定に含めなければならない。移す前の核の各点収束はトレースノルム仮定ではない。このスカラー行列式が、先に与えた直線束の切断を表すと主張する場合は、適用側がその実現を証明し、掛かる非零スカラー因子を制御する。この目標は一般行列式構成を重複せず、任意のRHPがこのトレースクラス表示を持つとも仮定しない。

零点計数の帰結では複素1変数に特殊化し、区分的に滑らかな境界を持つ有界領域 D を取り、その閉包は共通の正則性領域のコンパクト部分集合に含まれるとする。D₀ は ∂D 上で消えず、恒等的に0ではないことを要求する。境界上での一様収束とRouchéの定理を用い、十分小さい ε に対して D_ε と D₀ の D 内の零点の個数が重複度込みで一致することを証明する。孤立した極限零点のまわりの互いに交わらない小領域にこの主張を局所化する。無条件の大域的零点計数を推論してはならない。端点の接続定数や非線形Stokes極限には、依然として一様な端点評価または扇形評価と、両立した漸近正規化を要する。任意の固定コンパクト集合上での収束からは、そのどちらも得られない。

**構成・法則（API）**

- 指定した固定Hilbert空間上で、コンパクト集合上一様なトレースノルム収束から、正則行列式の収束を出力する。
- 明示的な同定で動くHilbert空間を移し、適用に必要な積分路・測度・スカラー正規化の責務を記録する。
- 指定した複素1変数の境界仮定の下で、重複度込みの局所零点計数が十分後で一致することを証明する。
- 零点を越える収束を、対数微分の収束や端点・Stokes定数の極限と区別する。

**検証事項**

- H = ℂ 上で K_ε(z) = 1 − z + ε とすると D_ε(z) = z − ε である。作用素はトレースノルムで収束し、正則行列式は零点を越えて収束するが、d log D_ε = dz/(z − ε) は零点の近傍で一様収束しない。
- 定数族 D_ε ≡ ε は恒等的に0の関数へ一様収束する。極限が境界上で消えないという仮定が破れており、零点計数の結論は得られない。
- 動く積分路の核表示は、パラメータ表示と測度因子を移した作用素に含めなければならない。その後で初めて、トレースノルム評価が一つの固定Hilbert空間に関する命題になる。
- 固定した任意のコンパクト時間区間上での収束からは、端点の漸近評価の一様性は得られず、それだけで極限の接続定数を定めることはできない。

**本目標が担う補助構成。**

- コンパクトなパラメータ集合Kの像K₀(K)はトレースノルムでコンパクトである。一般Fredholm行列式の各点での連続性と有限被覆から、K上のトレースノルム一様収束が行列式の一様収束を与えることを証明する。ノルム球全体での一様連続性は要しない。外冪級数の正規収束に必要な評価を証明して正則依存を得る。零点数には既存Rouchéを用い、一般領域については有限個の正向き区分的C¹境界サイクルを構成し、内部で回転数1、外部で0となることを証明する。

*必要な先行結果：* [Generic trace-class determinant](#dependency-trace-determinant) (8.3, generic operator-theory prefix); [Trace-class ideal carrier](#dependency-trace-ideal) (OI-B01–OI-B19; OI-B23; OI-B29–OI-B30); [Native Rouché and zero counts](#dependency-rouche) (rouche; rouche_nullHomologous; Multiplicity zero-count carrier).

<a id="target-9-5"></a>
### 9.5 幾何学的な接続データの衝突族

**パンルヴェへの適用。**

**入力条件**

- この項目で指定する衝突データ、すなわち曲線族と有限平坦な因子族、ラベル、行列式・指数パラメータ・時間の写像、先頭項の軌道、低次係数、および局所降下・フィルトレーションのデータを入力とする。原始的な両端点は§3.3のすべての条件を満たし、境界端点は別に記録する。正則領域は実際の関係写像・変形写像の階数によって定義する。Poisson構造・符号の比較、訂正済みLaurent補題、共通座標、および水平場の収束は構成・証明の出力である。

衝突データを以下の幾何学的な族として定義し、射はすべてのデータを保つ同型とする。衝突円板 Δ_ε と許容された極限の時間・パラメータ領域上で、次数 4 の有限平坦な構造的極因子を持つ滑らかな射影曲線族、ε ≠ 0 で分離している枝上の順序付きラベルとその特殊化写像、行列式線束の接続とその比較、および gl₂ ⊗ O_P の双対内の局所主要部条件の平坦族を与え、必要に応じてフィルトレーションまたは因子化された分岐を伴う降下を備える。ε について有理型の指数パラメータの写像、ε ≠ 0 で導関数が非零となる時間写像、およびこれらの写像で用いる有限パラメータ被覆を指定する。因子の重複度だけでなく、局所的な最高次係数の軌道と、その形式型を決める低次係数を指定する。極限の形式条件は、実際の最小射影的傾きを伴う §3.1 の条件、または別に標識を付けた低複雑度の境界条件のいずれかとする。これらは代数的・形式的データであり、水平解の極限、シンプレクティック同値、RHP の収束はいずれも定義の構成要素に含めない。

許容される原始的な古典領域では、まず両方の原始的端点が §3.3 の対象であることを要求する。すなわち、種数 0、階数 2、構造的次数 4、許容された局所形式構造、固定留数とそれに両立する時間移送を伴う確定特異な行列式接続、実際の縮約された versal な時間変形問題、一般の重み、および空でない安定ファイバーを要求する。射影的傾きやトレース零の変形の階数によって、この端点条件を置き換えてはならない。その領域内で最高次係数の非消滅・因子化の関係を課し、相対的な局所条件複体と変形複体の各項が平坦な連接層であり、階数が端点問題から計算される一定値となる正則比較部分を構成する。この部分を実際の関係写像と Kodaira–Spencer 写像を用いて定義し、表示の変更に対して不変とする。§3.4 と §3.7 の時間・相空間の次元に関する結論も、水平分布の等しさも、入力に加える構成要素ではない。

一方、境界端点には、実際の縮約された構造的・局所的条件、行列式の極の位数、および満たされなくなる階数または最高次項の条件を記録する。境界端点を原始的な古典領域へ暗黙に含めない。境界端点に初等的なスカラー合流の射を与えるのは、別に証明する §7.3 の対応表と相空間・1 次ジェット比較を通じてのみである。射影的プロファイルが §3.4 のものと一致するという理由だけで、スカラーの不確定特異な行列式成分を余分に持つものを原始的端点と見なしてはならない。指定した正則部分上でモジュライ・還元の比較を構成し、局所モデルでその階数による記述を証明し、目標3.9–3.12の強い変形方程式を解くことで共通の相空間座標と水平ベクトル場の延長を得る。この正則比較が検証されていない成分について、解の収束の射は主張しない。

A = p_*O_P に対し、target:9.2 の相対双対Lie–Poisson構造と、曲線の極データとの留数比較を取り込む。分離した点の代数と衝突時の切断局所代数は、この一つの有限代数族の座標表示である。選んだ局所条件の軌道と相対簡約が、この衝突データに必要な正則性・平坦性を満たすことは別途検証する。一般のPoisson構成はこれらの性質を証明しない。供給されたファイバーの符号反転同型をGMR23の規約へ適用する。dY/dz = A_source Y と ∇ = d + A_ours の比較には、全Takiff係数と留数・指数パラメータについて A_ours = −A_source を要する。この同型によって実際の留数対、対になったKKS形式、モーメント写像、簡約、Hamiltonianの規約を同定する。係数行列の恒等写像はこのアダプターではない。

GMR23 §4.2、印刷頁1428–1429の定義3–4と定理12は、そこで指定された順序付きカスケードとTakiffモデルに用い、§4.3、印刷頁1435–1436の定理13は、そこで指定された領域の極限Hamiltonianに用いる。target:9.1 の単純零点と極次数の仮定を満たす各座標衝突モデルについて、修正した主部補題を V = M₂(ℂ) に適用する。その厳密な有限恒等式から、衝突点を避ける領域での極限Laurent係数とコンパクト集合上の一様な係数極限を得る。適用側では、これらの実際のLaurent係数を文献の時間依存の係数基底および選択した指数・時間写像と照合しなければならない。印刷頁1391–1392の定理2、式(12)–(15)はそのまま用いない。C = O(ε⁻ʳ) では CPʳ⁺¹ = O(ε) となる一方、修正した ε⁻ʳ⁻¹ 係数 W からは最高極限係数 t₁ʳ⁺¹W を得る。衝突パラメータを非線形に変更する場合は、一般補題が指定する正則項 D_j の補正も移す。この行列係数の極限や最高行列係数の非消滅は、射影的Katz slopeを決めるものでも、モジュライ・簡約の比較を供給するものでもない。上で要求した端点の完全な形式型と正則領域のアダプターを証明する。GMR23 §5.1、印刷頁1441はPainlevéの実現を明示的に非分岐の場合へ制限しており、分岐の場合の比較は引き続きこの適用が担当する。

**構成・法則（API）**

- 衝突データの亜群、階数によって定義された指定の許容領域、その特殊ファイバー、および行列式・局所構造の比較を構成する。曲線、枠、パラメータ被覆の変更に対する領域の不変性を証明する。
- 指定した正則部分上で Poisson 構造とシンプレクティック還元の両立性を証明し、必要な特異点解消や改変を特定する。
- 幾何学的な変形方程式から、共通の局所座標に引き戻した水平分布の収束を証明する。
- 検証された各衝突データについて、最高次係数の軌道、低次係数、分岐、指数パラメータの写像を保持して、端点プロファイルへの対応を構成する。最高次係数が消滅した場合は、計算された新たな形式的層または標識付き境界へ送る。量化の対象となる射は、これらの衝突データの比較であり、記載されていない有限個のよく知られたスカラー射ではない。

**検証事項**

- O_Δ[z]/(z(z − ε)) は、ε ≠ 0 では二つの点の代数の積となり、ε = 0 では ℂ[z]/z² となる。中心にある z の冪零類も比較の一部である。
- r = 1 で C = W/ε², P = t₁ε + t₂ε², B₀ = −W/ε², B₁ = −t₁W/ε とすると、極限は t₂W/z² + t₁²W/z³ となる。t₁ = 1, t₂ = 0 の場合、式全体は W/[z²(z − ε)] に等しい。一方、C = W/ε, B₀ = −W/ε, B₁ = W, P = ε とすると、極限は 2W/z² であり、3 位の極の係数は零となる。
- 族 −B/(εz) + B/[ε(z − ε)] + C/z は B/z² + C/z に収束する。B = diag(1,−1) では射影的傾きは 1 である。B = E₁₂, C = E₂₁ では、z = w² とゲージ変換 diag(1,w) の後に傾きは 1/2 となる。B = E₁₂, C = 0 では、ゲージ変換 I + E₁₂/z によって極が取り除かれる。これらは同じ衝突因子を持つが、端点の形式データは異なる。最後の例は一般の不確定特異領域から外れる。
- X = E₁₂, Y = E₂₁, ν_source = diag(1,−1)/2 のとき、文献の線形 Poisson 括弧は −1 となる。ν_ours = −ν_source では、正の規約を持つ提供元の括弧も −1 となる。ファイバーの符号反転による引き戻しは一致するが、恒等比較では +1 となる。Takiff 代数では、二つの次数の和が切り詰め次数を超えると括弧は零となる。
- ℙ¹ 上の大域的な検証用の族を、極 0, εT, 1, ∞ と、T ≠ 0, εT ≠ 1 のもとでの係数 (−B/ε + C)/z + (B/ε)/(z − εT) + D/(z − 1) によって与える。その極限は TB/z² + C/z + D/(z − 1) であり、無限遠の留数は −C − D のままである。原始的な古典対象の検証には、tr(B) = 0 と、指定された行列式の留数・移送を課す。正則半単純でトレース零の B は基礎となる (0,0,1) プロファイルを与え、指定された非零の低次係数を伴う冪零 B は (0,0,1/2) を与える。どちらの係数モデルについても、モジュライの射へ進める前に、§3.3 の端点条件全体、指数パラメータの写像、安定部分、および時間比較 T ↦ εT を確認する。
- B = diag(1,2) は、そのトレース零部分 diag(−1/2,1/2) と同じ射影的な傾き 1 の形を持つが、極限の行列式接続には項 3T dz/z² が現れる。スカラーによる捩りが不変部分束やトレース零の交換子複体を変えなくても、これは原始的な古典領域の外にある。

*必要な先行結果：* 内部依存：3.1, 3.2, 3.3, 3.4, 3.5, 3.6, 3.7, 3.9, 3.10, 3.11, 3.12, 5.2, 9.1, 9.2; [Smooth real KKS and regular reduction](#dependency-reduction) (R2; R3).

<a id="target-9-6"></a>
### 9.6 合流における水平解の収束

**パンルヴェへの適用。**

**入力条件**

- 9.5 の確認済み幾何学的比較、基準持ち上げ、正の余裕をもつ共通チャート、場の一様制御・共通 Lipschitz 評価、初期点の収束を用いる。近似解の経路全体での存在は結論である。

§9.5 の実際の時間・相空間の比較に NonlinearConnections §0.9 を適用する。極限の固定特異点を避けるコンパクトな区分的 C¹ 時間経路と、その上の基準水平持ち上げを与える。正の境界余裕をもつ有限個の共通チャート、経路速度を含めて引き戻した場の一様収束、共通の局所 Lipschitz 評価、初期点の収束を確認する。その後に一般定理から、経路全体での近似持ち上げの存在と一様収束を得る。存在・非退出を仮定にしない。区間評価 (初期誤差 + ℓδ_ε)exp(Lℓ) と有限チャートでの貼合せは一般定理を用いる。正則な場からの微分評価には、Cauchy 評価を適用できる、より大きな共通近傍が必要である。コンパクト時間領域・パラメータ族・端点扇形での一様性には、別途共通被覆と経路族の制御が必要であり、一経路上の収束からは導かない。

**構成・法則（API）**

- 主張する幾何学的衝突領域ごとに、正確な共通チャートと場の収束の仮定を確認する。
- 別個のスカラー証明を作らず、一般の非退出・定量的収束定理を適用する。

**検証事項**

- [0,2] 上で、近似ベクトル場 F_n = 1/(n+1)、極限ベクトル場 F_ref = 0、初期値 0 は x_n(t) = t/(n+1) を与え、一様誤差は 2/(n+1) となる。同じ零ベクトル場でも初期値が (−1)ⁿ ならば解は収束しない。初期値の収束仮定は不可欠である。
- 座標上での係数の収束は、すべての共通近傍から出てしまう軌道を制御しない。証明では正の余裕の仮定を用いる。
- 評価は固定したコンパクト経路上で一様である。非有界な時間半直線上、または極限の固定特異点を横切る一様収束を主張するものではない。

*必要な先行結果：* 内部依存：9.5, 0.9.

<a id="target-9-7"></a>
### 9.7 古典的方程式の合流関係

**パンルヴェへの適用。**

**入力条件**

- §9.5で検証した幾何学的衝突データの射、その記録された端点・パラメータ・時間の写像と定義域、および§9.6に必要な対応するデータと共通近傍の仮定を用いる。スケーリング後のスカラー方程式とそのジェット比較は、目標7.1–7.5を用いて導く。合成では実際の比較データを保持し、極限の交換には追加の一様評価を必要とする。

§9.5 の検証済みの衝突データの射が生成する圏として合流系列を構成し、端点の同定と指定した領域を保持する。その射はデータに依存する比較であり、基礎となる 10 プロファイルだけでは射は定まらない。各射について、幾何学的比較を構成した後に初めて時間座標と相空間座標を選び、目標7.1–7.5を用いてスケーリングされた古典方程式、そのパラメータ写像、1 次ジェットの対応を導く。分岐を伴う (0,0,1/2) 端点は、非零の低次係数を持つ部分上でのみ得られる。除去可能な端点または最高次項が消滅する端点は、別に計算したより低い層に置き、1 次ジェット比較が証明されたところでのみ §7.3 のスカラー境界比較を与える。各射に記録された領域を覆うこと、非零のスケーリング因子、および除外した座標を証明する。§9.6 を適用し、対応させた初期点に対する解の極限を得る。合成には、両立する行列式、ラベル、パラメータ被覆、時間の同定を用いる。極限の交換には追加の一様定理が必要である。この定理は不変な衝突データのクラス全体にわたって量化するものであり、特定されていない有限グラフが可能なすべての退化を尽くすとは主張しない。（GMR23, Definitions 3–4, Theorems 12–13; 修正された Laurent 補題は AlgebraicConfluence §9.1 が担当し、§9.5 で適用するもので、文献の §5 の実現は分岐を伴わない範囲にとどめる。）

**検証事項**

- 同じプロファイルに至る二つの経路が、異なる時間スケールやパラメータ名を生むことがある。等しさには比較写像が必要であり、最後の古典的ラベルの一致では足りない。
- 表示された方程式の代数的極限だけでは、1 次ジェットの逆写像なしに相空間点や解の芽を同定したことにはならない。
- 許容近傍の異なる逐次極限は、表示された極限微分方程式が一致していても、交換できるとは限らない。

*必要な先行結果：* 内部依存：3.12, 7.1, 7.2, 7.3, 7.4, 7.5, 9.5, 9.6.

<a id="target-9-8"></a>
### 9.8 合流におけるタウ切断の収束

**パンルヴェへの適用。**

**入力条件**

- 実際の線束・枠・正規化の比較と、証明された対数微分形式の評価または共通 Hilbert 空間でのトレースノルム評価を用いる。境界や端点の結論を主張するときは、その追加仮定を別途確認する。

§9.5 の衝突に対し、実際の行列式線束の比較、枠、零でない補正因子、共通の正則な正規化点を構成する。この同定の下で、独立した二つの一般契約のいずれかを確認する。AnalyticRHPAndDeterminants §9.3 は、単連結で零点を含まない領域内の制御されたコンパクト経路族上で、補正済み対数微分形式の収束から正規化スカラー収束を与える。用いる形式は §6.4 の実際の行列式枠の形式でなければならない。JMU・Hamiltonian 公式は §§6.4–6.5 で比較を証明した領域に限って用いる。

別の方法では、動く輪郭・測度・作用素を一つの Hilbert 空間へ同定する際の制御と、コンパクト集合上一様なトレースノルム収束を証明し、AnalyticRHPAndDeterminants §9.4 を適用する。この方法は零点を含められる。零点数には、選んだ境界での極限の非消失と、恒等的に零でない極限が必要である。線束・枠・作用素の比較は適用側の課題であり、抽象収束定理からは供給されない。端点定数と非線形 Stokes 極限には、さらに §8.6 の確認済み一様扇形評価と漸近正規化の両立性が必要であり、§9.6 だけからは得られない。

**構成・法則（API）**

- 実際の衝突に沿う線束・枠・正規化・作用素の比較を構成して確認する。
- 選んだ一般収束定理と、零点数・端点について追加する結論の仮定を満たす。

**検証事項**

- τ_ε に、制御されていない ε 依存の非零定数を掛けても d log τ_ε は変わらないが、収束は失われうる。基点での正規化は不可欠である。
- τ_ε(z) = z − ε の場合、スカラー行列式は零点をまたいで収束する一方、その対数微分は零点の近傍で一様収束しない。
- すべての固定したコンパクト時間区間上での収束から、一様な端点漸近評価は得られない。したがって、それだけで極限の接続定数を決定することはできない。

*必要な先行結果：* 内部依存：6.3, 6.4, 6.5, 8.6, 9.5, 9.6, 9.3, 9.4.

#### 例

二つの極の衝突によって、古典的表示に進む前に局所代数と Laurent スケーリングを検証する。初期点を一致させない定数ベクトル場によって、解析的仮定の必要性を検証する。行列式族 z − ε によって、零点における関数の収束と対数微分の収束の違いを検証する。これらの例によって、形式的な係数極限を完全な合流定理と取り違えることを防ぐ。

#### 依存関係

各目標の「必要な先行結果」と `design/reuse_registry.json` の枠組み間参照を用いる。一般証明の前提は独立したパッケージに置き、この層では指定した適用比較を確認する。

### 下流の利用先

ランダム行列や可積分確率論の応用では、内在的な相空間と観測量をつなぐ本ロードマップの結果を、RandomMatrices §§8.3–8.5とともに利用できる。その際、Fredholm行列式、Airy端点、およびHastings–McLeod理論の担当範囲は維持する。両方を利用するものは新しい下流の課題であり、既存のRandomMatricesロードマップに本ロードマップへの依存を後から課すものではない。

ほかの利用先として、幾何学的特殊関数や接続公式の比較、不確定特異点を持つ接続のモジュライと指標多様体、および制御された退化の問題がある。これらは、実際に証明された範囲で、水平性・シンプレクティック性・解の延長・正規化に関する結果を利用する。すべての既約な超越関数の微分代数的分類、代数的特殊解の完全分類、離散・q差分パンルヴェ系、およびクラスターやSakai分類全体に及ぶ構成は、別の拡張である。そのいずれも、上の内在的な微分方程式の構成の前提とはしない。

実施順序は依存グラフに従う。各一般結果を、指定された幾何学・解析学の基礎から構成・証明し、その仮定を検証してから適用する。五極への適用は、パンルヴェの目標を前提とせずに一般のモジュライ・延長定理を用いる。パンルヴェの構成と性質に続いて曲面とタウの理論を展開し、それらの内在的構成から古典的座標表示を導く。正規化された解析的応用と合流は、関係する比較定理と、独立に定めた一般の解析・代数的結果を利用する。この順序により、共通の定義と定理が古典的スカラー表示から独立であることを保つ。

### 参考文献

- **I13.** Michi-aki Inaba. *[Moduli of parabolic connections on a curve and Riemann–Hilbert correspondence](https://arxiv.org/abs/math/0602004v2)*. Journal of Algebraic Geometry 22 (2013), 407–480. 引用版： arXiv math/0602004v2, 6 June 2012; Theorems 2.1–2.2, preprint pp. 5–6; §§1, 6. 族の固有性定理では、指数パラメータを保持したファイバー積と、正確な数値・安定性の仮定を用いる。

- **I23.** Michi-aki Inaba. *[Moduli Space of Factorized Ramified Connections and Generalized Isomonodromic Deformation](https://sigma-journal.com/2023/013/)*. SIGMA 19 (2023), 013, 72 pages. 出版社版、2023年3月22日。参照箇所：Definitions 2.1–2.8; Remark 2.9; Theorems 5.1, 7.5, 8.1, 9.7 and 11.6; equation (6.9); Propositions 6.3, 7.2, 8.2–8.3, 10.7 and 10.10; Definitions 10.1 and 11.4; Corollaries 9.11 and 11.8; equations (8.2), (11.2) and (11.5).

- **IS12.** Michi-aki Inaba; Masa-Hiko Saito. *[Moduli of unramified irregular singular parabolic connections on a smooth projective curve](https://arxiv.org/abs/1203.0084v3)*. Kyoto Journal of Mathematics 53(2) (2013), 433–482. 引用版：arXiv 1203.0084v3（2012年11月22日）。文献キーにはプレプリントの年を残す。参照箇所：Theorem 5.1; Remark 6.3.

- **HEU10.** Viktoria Heu. *[Universal isomonodromic deformations of meromorphic rank 2 connections on curves](https://www.numdam.org/item/AIF_2010__60_2_515_0/)*. Annales de l'Institut Fourier 60(2) (2010), 515–549. NUMDAMで公開された出版本文。誌面pp. 515–549。参照箇所：Theorem 1.1; Definitions 2.3 and 2.10; §2.

- **VDPS09.** Marius van der Put; Masa-Hiko Saito. *[Moduli spaces for linear differential equations and the Painlevé equations](https://arxiv.org/abs/0902.1702v5)*. Annales de l'Institut Fourier 59(7) (2009), 2611–2667. 引用版：arXiv 0902.1702v5（2009年11月12日）。残る内部の不整合は§7.4で指摘する。参照箇所：§2.2, Table 1, preprint pp. 18–19; §3; §4.1 and §§4.3–4.11; equations (12), (17) and (22).

- **IIS06.** Michi-aki Inaba; Katsunori Iwasaki; Masa-Hiko Saito. *[Dynamics of the Sixth Painlevé Equation](https://arxiv.org/abs/math/0501007v2)*. Séminaires et Congrès 14 (2006), 103–167. 引用版：arXiv math/0501007v2（2005年3月6日）。参照箇所：Definitions 2.1–2.2 and 2.11; Lemma 2.12; Definition 3.5; Theorems 4.10–4.12, 5.15–5.16, 7.4, 10.6, 10.10 and 10.13; §§5, 7 and 10.

- **BOA01.** Philip Boalch. *[Symplectic Manifolds and Isomonodromic Deformations](https://arxiv.org/abs/2002.00052v1)*. Advances in Mathematics 163 (2001), 137–205. 引用版：arXiv 2002.00052v1。2001年の論文を著者が2020年に登録した版。参照箇所：§§3–6; Theorems 7.1 and 7.3; §7.

- **BOA14.** P. P. Boalch. *[Geometry and braiding of Stokes data; Fission and wild character varieties](https://arxiv.org/abs/1111.6228v3)*. Annals of Mathematics 179(1) (2014), 301–365. 引用版：arXiv 1111.6228v3（2012年9月22日）。参照箇所：§10, Theorem 10.2; Stokesデータについては§7。

- **BY15.** Philip Boalch; Daisuke Yamakawa. *[Twisted wild character varieties](https://arxiv.org/abs/1512.08091v1)*. arXiv preprint 1512.08091. 引用版：arXiv 1512.08091v1（2015年12月26日）。参照箇所：Remark 3; Definitions 7 and 13; Proposition 19; Theorem 21; Corollary 22.

- **STT02.** Masa-Hiko Saito; Taro Takebe; Hitomi Terajima. *[Deformation of Okamoto–Painlevé pairs and Painlevé equations](https://arxiv.org/abs/math/0006026v2)*. Journal of Algebraic Geometry 11(2) (2002), 311–362. 引用版：arXiv math/0006026v2（2000年9月18日）、3名の共著による論文。参照箇所：Definitions 1.1 and 1.3; Proposition 1.2; Tables 2–3; Theorem 3.1; §6.

- **TER02.** Hitomi Terajima. *[Local cohomology of generalized Okamoto–Painlevé pairs and Painlevé equations](https://arxiv.org/abs/math/0006027v1)*. Japanese Journal of Mathematics, New Series 28(1) (2002), 137–162. 引用版：arXiv math/0006027v1（2000年6月5日）。参照箇所：Theorem 2.1; Proposition 2.1; Conjecture 2.1.

- **ST04.** Masa-Hiko Saito; Hitomi Terajima. *[Nodal curves and Riccati solutions of Painlevé equations](https://arxiv.org/abs/math/0201225v1)*. Journal of Mathematics of Kyoto University 44(3) (2004), 529–568. 引用版：arXiv math/0201225v1（2002年1月23日）。参照箇所：§2.4; Proposition 2.1; Definition 2.3; Remark 2.4; Appendix A.

- **FM19.** Andrea E. V. Ferrari; Lionel Mason. *[Meromorphic Painlevé III transcendents and the Joukowski correspondence](https://arxiv.org/abs/1809.07885v2)*. Journal of Integrable Systems 4(1) (2019), xyz001. 引用版：arXiv 1809.07885v2（2019年1月30日）。参照箇所：§1.1; equation (2).

- **DIL21.** Jan Dereziński; Artur Ishkhanyan; Adam Latosiński. *[From Heun Class Equations to Painlevé Equations](https://sigma-journal.com/2021/056/)*. SIGMA 17 (2021), 056, 59 pages. 出版社版、2021年6月7日。参照箇所：§§5.2–5.3; Appendix B.3.

- **AHT17.** Primitivo B. Acosta-Humánez; Marius van der Put; Jaap Top. *[Isomonodromy for the Degenerate Fifth Painlevé Equation](https://sigma-journal.com/2017/029/)*. SIGMA 13 (2017), 029, 14 pages. 出版社版、2017年5月9日。参照箇所：Introduction; §§2–3.

- **MAL04.** Bernard Malgrange. *[Déformations isomonodromiques, forme de Liouville, fonction τ](https://www.numdam.org/articles/10.5802/aif.2052/)*. Annales de l'Institut Fourier 54(5) (2004), 1371–1392. NUMDAMで公開された出版本文。誌面pp. 1371–1392。参照箇所：§2, printed pp. 1372–1374; Theorem 5.12.

- **BERT10.** Marco Bertola. *[The dependence on the monodromy data of the isomonodromic tau function](https://arxiv.org/abs/0902.4716v2)*. Communications in Mathematical Physics 294 (2010), 539–579. 引用版：arXiv 0902.4716v2（2016年1月20日）。必ずBERT16と併用する。参照箇所：Assumption 3.1; §5.1, Proposition 5.1; Theorem 5.1はBERT16の訂正とともにのみ用いる。

- **BERT16.** Marco Bertola. *[Corrigendum: The dependence on the monodromy data of the isomonodromic tau function](https://arxiv.org/abs/1601.04790v2)*. Communications in Mathematical Physics 381 (2021), 1445–1461. 引用版：arXiv 1601.04790v2（2020年9月19日）。2021年に「Correction to: The Dependence on the Monodromy Data of the Isomonodromic Tau Function」の題で出版された。文献キーには最初のプレプリントの年である2016年を残す。参照箇所：Definition 2.1; Theorems 2.1 and 2.2.

- **BERT17.** Marco Bertola. *[The Malgrange Form and Fredholm Determinants](https://arxiv.org/abs/1703.00046v4)*. SIGMA 13 (2017), 046, 12 pages. 引用版：arXiv 1703.00046v4、SIGMA掲載本文を収録した版。参照箇所：§1; Theorem 2.2; Proposition 2.3; formula (3.6); Theorem 3.3; §3.1.2.

- **ILP18.** A. R. Its; O. Lisovyy; A. Prokhorov. *[Monodromy dependence and connection formulae for isomonodromic tau functions](https://arxiv.org/abs/1604.03082v4)*. Duke Mathematical Journal 167(7) (2018), 1347–1432. 引用版：arXiv 1604.03082v4（2018年10月29日）。参照箇所：§1.4, Theorems A and B, equations (1.13), (1.16)–(1.21), (1.25)–(1.28); Lemma 3.3; Propositions 3.20 and 3.24; §3.9; §§4.3–4.5, especially (4.74)–(4.76); Remark 4.8.

- **DIK08.** P. Deift; A. Its; I. Krasovsky. *[Asymptotics of the Airy-kernel determinant](https://arxiv.org/abs/math/0609451v2)*. Communications in Mathematical Physics 278 (2008), 643–678. 引用版：arXiv math/0609451v2（2007年6月21日）。参照箇所：Theorem 1; equations (2)–(3).

- **HXZ16.** Min Huang; Shuai-Xia Xu; Lun Zhang. *[Location of Poles for the Hastings–McLeod Solution to the Second Painlevé Equation](https://arxiv.org/abs/1410.3338v2)*. Constructive Approximation 43(3) (2016), 463–494. 引用版：arXiv 1410.3338v2（2015年7月9日）。参照箇所：Theorem 2.1.

- **GMR23.** Ilia Gaiur; Marta Mazzocco; Vladimir Rubtsov. *[Isomonodromic Deformations: Confluence, Reduction and Quantisation](https://doi.org/10.1007/s00220-023-04650-8)*. Communications in Mathematical Physics 400 (2023), 1385–1461. 出版社の確定版、2023年3月1日、CC BY 4.0。参照箇所：Theorem 2, pp. 1391–1392, (12)–(15)。これは§9.5の、極の階数を上げる係数についての訂正済み補題とともにのみ用いる。Definitions 3–4 and Theorem 12, §4.2, pp. 1428–1429; brackets (96)–(97); Theorem 13, §4.3, pp. 1435–1436; 分岐を伴わない場合に範囲を限定する明記については§5.1, p. 1441。

- **DLMF.** P. A. Clarkson, *[Painlevé Transcendents, Chapter 32 of the NIST Digital Library of Mathematical Functions](https://dlmf.nist.gov/32)*. Version 1.2.8、2026年9月15日公開。[§32.2](https://dlmf.nist.gov/32.2), equations 32.2.1–32.2.6; [§32.6](https://dlmf.nist.gov/32.6); [§32.7](https://dlmf.nist.gov/32.7); [§32.9](https://dlmf.nist.gov/32.9)、特にequations 32.9.6 and 32.9.12。標準的スカラー表示と正規化の参照先。

### 本ロードマップが担う明示的な証明課題

次の12項目は、構造化計画のパンルヴェへの適用で明示的に記録された証明課題である。いずれも本ロードマップの担当範囲にあり、必要な結論を仮定へ戻してよいという意味ではない。この一覧だけが未証明事項の全体だという主張でもない。

- **§3.4**　入力クラスから、基礎となる10種類および順序付き17種類の形式的プロファイルと、縮約された時間の1次元性を導く。固定部分群と標識の比較を含め、これらの個数を仮定に入れない。〔この項目が担う分類と時間の縮約の証明〕

- **§3.7**　MeromorphicConnectionModuli 1.5–1.6 の中心ファイバー・行列式・基底変換との比較を確認する。展開変形と一般の閉性証明は同枠組みが担う。

- **§4.2**　許容された族におけるStokes平行移動を、被覆変換と同変なイソトピーと降下によって、階数2の良い分岐クラスへ拡張する。〔共通理論で担う証明課題〕

- **§4.4**　許容されるすべての古典的パラメータと安定な層に対して、相対RH写像の固有性を証明する。一様な格子の有界性と安定な対象への置換を含める。〔引用文献の限定された主張を越える本質的な拡張。本課題が文献上未解決であるとは主張しない〕

- **§5.2**　モジュライ全体と曲面の境界補集合との比較を、すべての座標と許容される層について証明する。序論で述べられる全プロファイルに関する予想的比較を仮定しない。〔共通理論で担う証明課題〕

- **§5.3**　第1境界層から得られる1次元空間について、基底変換と時間方向との同一視を証明する。局所コホモロジー全体との一致は仮定しない。〔族の比較に関する課題〕

- **§5.5**　PVIの中央反射を含む追加の標識付き対の反射を構成し、水平な延長と関係式を証明する。〔対称性の構成課題〕

- **§6.3**　共鳴・分岐を伴う場合の指数0のRHPへの対応づけを、許容される比較写像と固定部分群に関する降下を含めて構成する。〔解析的な対応づけの課題〕

- **§8.7**　供給されたHastings–McLeod対象を用いて、DIK08・HXZ16の指定された結果、HMハミルトニアンの正確な一様扇形評価と弧積分の消滅による定数決定、および補助座標で除外された点を越える接続を証明する。〔適用範囲を限定した応用の証明課題〕

- **§9.5**　実際の衝突亜群、端点の形式型と行列式の許容条件、軌道の平坦性、正則簡約の比較、共通チャートを構成する。主部相殺、有限代数の双対 Poisson 構造、符号移送には AlgebraicConfluence 9.1–9.2 を用い、係数・パラメータ変更・留数の比較を確認する。

- **§8.6**　AnalyticRHPAndDeterminants 8.1–8.3 に適用する実際の輪郭・端点・行列式除去可能性・再構成・パラメータ集合の条件を証明する。一般の小ノルム・一様な裾の証明は同枠組みが担う。

- **§4.7**　実際の古典的移送・作用を NonlinearConnections 0.5 の構成と同定し、表示とシンプレクティック性の比較を確認する。一般の作用・普遍被覆切断・降下の構成は同枠組みが担う。
