# パンルヴェ方程式

微分パンルヴェ方程式を、付加構造付き有理型接続のモジュライ上の平坦な非線形接続として構成し、パンルヴェ関数をその水平切断と許容観測によって定義する。性質はその構成から証明する。古典的なスカラー方程式、Hamilton 関数、線形系の表示は座標比較定理として得る。

全体は8層・57個の構成および定理目標からなる。内訳は再利用可能な一般理論21目標と、古典的パンルヴェへの適用36目標である。

[English](README.md) · [構造化された数学計画](design/plan.json) · [外部依存の供給範囲](design/dependencies.json)

## 全体の構成

各レイヤーは、一つのまとまった数学的構成または定理群を到達点とする。一般定理とその適用を同じレイヤーに置く場合にも、各目標の入力・結論・証明責任を区別する。

| レイヤー | 到達点 | 目標数 |
|---:|---|---:|
| [0](#layer-0) | 非線形接続とその解 | 8 |
| [1](#layer-1) | 付加構造付き有理型接続のモジュライ | 6 |
| [2](#layer-2) | 等モノドロミー変形と対数型 Riemann–Hilbert 対応 | 6 |
| [3](#layer-3) | パンルヴェ方程式の相空間と等モノドロミー変形 | 12 |
| [4](#layer-4) | Riemann–Hilbert 比較とパンルヴェ性 | 9 |
| [5](#layer-5) | 初期値空間・対称性・Riccati 簡約 | 6 |
| [6](#layer-6) | 行列式線束とタウ切断 | 5 |
| [7](#layer-7) | パンルヴェ方程式の古典的表示 | 5 |

<a id="general-theory"></a>

## 一般理論と適用

以下の57目標を対象とする。各目標は、明記した仮定の下での構成、基本API、比較写像、指定した例を含む。

| 再利用する一般理論 | 目標 |
|---|---|
| 非線形接続・解・移送・観測・ジェット | 0.1–0.8 |
| 付加構造付き有理型接続のモジュライ | 1.1–1.6 |
| 等モノドロミー変形と対数型 Riemann–Hilbert 対応 | 2.1–2.6 |
| 正則 Fredholm 族の行列式線束 | 6.1 |

一般理論の21目標は、適用側から独立した理論をなす。適用側の36目標は、それを用いてパンルヴェの相空間・接続・形式を構成し、その性質を証明する。依存関係は各目標の先行結果によって定まる。特に、レイヤー3–6の幾何学的構成と性質は、レイヤー7の古典的座標比較に先行する。

外部ロードマップは、依存関係に明記した結果を供給する。本ロードマップで行う各構成には担当目標を定める。適用側は、明記した仮定と比較写像を通じて、一般理論の対象・射・引戻しを用いる。

## 目標番号と参照の規約

レイヤーを0–7の通し番号とし、各目標を0.1、0.2、…のようにレイヤー番号と層内の連番で指定する。内部参照は target:0.1 の形式を用いる。文献と供給元の節番号は出典の番号に従う。「必要な先行結果」は証明の前提を指定し、[design/reuse_registry.json](design/reuse_registry.json) は一般理論と適用の区分を記録する。各目標に仮定・構成・比較則を定める。

<a id="external-dependencies"></a>
## 外部依存の供給範囲

ロードマップの参照は構成・定理とその仮定を、ライブラリの参照は宣言とAPIを指定する。次の表に、供給される結果と本ロードマップが担う構成を記す。詳細は [design/dependencies.json](design/dependencies.json) に記録する。

| 供給項目 | 正確な供給先 | 範囲と本ロードマップの担当 |
|---|---|---|
| <a id="dependency-complex"></a>complex | [ComplexKahlerGeometry](../../TauCetiRoadmap/ComplexKahlerGeometry/README.md) — K1; K3.0; K3.HolomorphicStalk; K3.MeromorphicGermField; K4; K7.1 | 複素逆・陰関数と接束計算、正則芽・一変数有理型芽、正則束と層の同値、非特異な平坦接続と局所系、射影空間のチャート。非線形接続と正則 ODE は一般理論が担い、1.1–1.2 は共通の接続・解析化に対する有理型付加構造への適用を担う。 |
| <a id="dependency-smooth"></a>smooth | [SmoothBundlesConnections](../../TauCetiRoadmap/SmoothBundlesConnections/README.md) — B1.5; B5.0; B5.2 | 滑らかなEhresmann分裂、固有沈め込みおよび主接続の移送を、それぞれの仮定の範囲で用いる。一般の非線形移送は0.1–0.5が担う。 |
| <a id="dependency-differential"></a>differential | [DifferentialGeometry](../../TauCetiRoadmap/DifferentialGeometry/README.md) — Layers 0–1; 3.1–3.5 | 有限次元多様体・チャート・滑らかな局所／極大／時間依存flow。連続時間・相変数局所一様Lipschitzの定理は0.2、一階jetは0.8で証明する。 |
| <a id="dependency-frobenius"></a>frobenius | `TauCeti.Analysis.ODE.Frobenius` — TauCeti.exists_frobenius_flat_coordinate | 有限次元の実可積分グラフ場から、明記した正則性の下で、滑らかな逆写像と水平微分を持つ局所積OpenPartialHomeomorphを得る。0.5が沈め込み座標への移送、曲率から可積分性、貼合せとホモトピー不変性を証明し、正則版は0.3を用いる。 |
| <a id="dependency-covers"></a>covers | [Completed/UniversalCovers](../../Completed/UniversalCovers/README.md) — Stage 0.2–0.4; Stage 1.5; Stage 2.6–2.8 | 既存の被覆・経路とホモトピーの持上げ・普遍被覆・基本群。非線形作用と水平降下は0.5で構成し、非正規被覆では実際のファイバー関係を用いる。 |
| <a id="dependency-curves"></a>curves | [ComplexCurveModuli](../../TauCetiRoadmap/ComplexCurveModuli/README.md); [SchemeAndStackFoundations](../../TauCetiRoadmap/SchemeAndStackFoundations/README.md) — ComplexCurveModuli D0.3, D3–D5; SchemeAndStackFoundations 4.15 | 種数0のMöbius正規化と点の移動、安定範囲の標識曲線変形チャート。1・2標点の商チャート、有限jet、局所標識、行列式移送は1.2が構成する。 |
| <a id="dependency-stacks"></a>stacks | [SchemeAndStackFoundations](../../TauCetiRoadmap/SchemeAndStackFoundations/README.md) — 1.18–1.23 | スタック化・2ファイバー積・慣性・準連接層降下・有限慣性のKeel–Mori。Gmの剛化、GIT、gerbeと粗モジュライの比較は1.3が証明する。 |
| <a id="dependency-quotient-predicates"></a>quotient-predicates | [SchemeAndStackFoundations](../../TauCetiRoadmap/SchemeAndStackFoundations/README.md) — 1.17 | 圏論的商・幾何学的商の定義と明記された有限群商。簡約群の不変式と指標商は1.3/2.5、Stokesの商は4.2で構成する。 |
| <a id="dependency-quot"></a>quot | [SchemeAndStackFoundations](../../TauCetiRoadmap/SchemeAndStackFoundations/README.md) — 4.14 | Noetherian・射影的なQuot/HilbertとHom/Isom空間。接続の有界性・方程式・安定性は1.3、解析的引戻しは1.2が担う。 |
| <a id="dependency-cohomology"></a>cohomology | [SchemeAndStackFoundations](../../TauCetiRoadmap/SchemeAndStackFoundations/README.md) — 2.2; 2.6; 2.20; 3.3 | Čech・層コホモロジー、連接な項、相対・Serre 双対、次数・曲線 Riemann–Roch。1.4 は制約付きの微分作用素変形複体・分岐錐・トレース・双対比較を構成し、一般の作用素・主部・GAGA は C5.1 を用いる。 |
| <a id="dependency-deformation"></a>deformation | [SchemeAndStackFoundations](../../TauCetiRoadmap/SchemeAndStackFoundations/README.md) — 4.2–4.6 | Artin係数・変形関手・hull・基本的小拡大の障害。実際の接続コサイクルと平方零核・versal比較は1.4、強い水平延長は2.1で証明する。 |
| <a id="dependency-bundles"></a>bundles | [AlgebraicVectorBundles](../../TauCetiRoadmap/AlgebraicVectorBundles/README.md) — L0A–L0C; L1A–L1B; L2A–L2B | 有限局所自由層、双対・テンソル・行列式、相対 Spec と幾何学的ベクトル束との同値。1.1 は共通の通常／形式接続を用いて有理型付加構造を構成し、1.2 は共通の解析化をその対象へ適用する。 |
| <a id="dependency-ordinary-connections"></a>ordinary-connections | [CrystallineCohomology](https://github.com/TauCetiProject/TauCetiRoadmap/blob/5231bad75352a6086d9952ff511636c8a8ddc6ac/TauCetiRoadmap/CrystallineCohomology/README.md) — CR.1.3: ordinary connection carrier and operations | 任意の可換基底環上の通常の接続・延長・曲率・水平射・基底変換・テンソル・Hom・双対。定義に可積分性は課さない。1.1 は共通の接続上で極の上界・付加構造・行列式・End⁰ と局所化の比較を構成する。 |
| <a id="dependency-formal-connections"></a>formal-connections | [FormalConnectionsOpers](https://github.com/TauCetiProject/TauCetiRoadmap/blob/19aacea45eee77564f95118de8f55f72547a9fe0/TauCetiRoadmap/FormalConnectionsOpers/README.md) — F1.1–F1.3; F2.1; F3.3–F3.4 | 相対連続微分・完備テンソル・形式座標自己同型と引戻し作用・Tate 係数の降下・形式接続・左ゲージ亜群。F3.4 の本質像には係数環の被覆条件を保持する。1.1 は実際の束の完備化、円板上への延長条件、分岐付加構造の降下、Levelt–Turrittin と相対因子化を担う。左作用 h とフレーム変換 g は h=g⁻¹ で比較する。 |
| <a id="dependency-analytic-spaces"></a>analytic-spaces | [ComplexComparisonPartII](https://github.com/TauCetiProject/TauCetiRoadmap/blob/fa9bfa5892bc24d60762bb1fbfc61f09f8be9043/TauCetiRoadmap/ComplexComparisonPartII/README.md) — C−1.1–C−1.2; C0.3–C0.5; C0.7; C5.2: ordinary connection comparison prefix | 冪零元を保持する単一の解析空間の圏、局所有限型スキームと局所分離有限型代数空間の解析化、連接層・テンソル・引戻し・étale 降下・固有射・通常の正則接続の比較。1.2 は実際の曲線・時間・モジュライ表示への適用、極と付加構造、滑らかな解析的引戻し、多様体比較とその次元・位相条件を担う。 |
| <a id="dependency-coherent-gaga"></a>coherent-gaga | [ComplexComparisonPartII](https://github.com/TauCetiProject/TauCetiRoadmap/blob/fa9bfa5892bc24d60762bb1fbfc61f09f8be9043/TauCetiRoadmap/ComplexComparisonPartII/README.md) — C1.9 | 有限型複素スキーム・固有代数空間の射影的／固有連接 GAGA と全次数の固有直像比較。冪零元と標準交換写像を保持する。1.2 は曲線・束・行列式の構成で仮定と写像を確認し、1.4 は供給された作用素複体の定理を介して適用する。基底変換の仮定は保持する。 |
| <a id="dependency-differential-operators"></a>differential-operators | [ComplexComparisonPartII](https://github.com/TauCetiProject/TauCetiRoadmap/blob/fa9bfa5892bc24d60762bb1fbfc61f09f8be9043/TauCetiRoadmap/ComplexComparisonPartII/README.md) — C5.1: shared algebraic operators/principal parts; C5.1: DifferentialOperatorAnalytification; C5.1: boundedOperatorHyperGaga | 標数によらない全階の微分作用素・主部・普遍 jet・合成・局所化・層化・解析化と、絶対／相対の固有な有界作用素複体の GAGA。1.1 は一次 Leibniz 作用素、1.2 は有理型付加構造への比較、1.4 は制約付き変形複体・分岐錐と位数・連接性・相対線形性・トレース・双対・基底変換の確認を担う。 |
| <a id="dependency-algebraic-manifolds"></a>algebraic-manifolds | [FormalConnectionsOpers](https://github.com/TauCetiProject/TauCetiRoadmap/blob/19aacea45eee77564f95118de8f55f72547a9fe0/TauCetiRoadmap/FormalConnectionsOpers/README.md) — F2.4: fixed-model analytification and sheaf/tangent comparisons | 微分次元一定の有限型分離滑らか複素スキームの固定モデル多様体、第二可算性、次元・構造層・接束・étale の比較。1.2 はスキームのチャートで適用し、供給された代数空間の解析化を介して実際のモジュライ比較を降下する。任意の滑らかな解析基底では解析チャートによる比較と Hausdorff・第二可算・次元条件を確認する。 |
| <a id="dependency-proper-cohomology"></a>proper-cohomology | [JacobianChallenge](../../TauCetiRoadmap/JacobianChallenge/README.md) — Layer C | 固有連接直像と、各仮定を区別した平坦基底変換・コホモロジー基底変換。Grauertの定理には被約な基底と階数一定の仮定を課す。相対Picard拡張は1.5、境界係数の平坦性と局所自由性・任意基底変換の判定条件の検証は5.3が担う。 |
| <a id="dependency-field-picard"></a>field-picard | [JacobianChallenge](../../TauCetiRoadmap/JacobianChallenge/README.md); [SchemeAndStackFoundations](../../TauCetiRoadmap/SchemeAndStackFoundations/README.md) — JacobianChallenge Layer D; SchemeAndStackFoundations 1.1, 2.6, 3.4, 4.6, 4.14 | 体上の射影的幾何学的整スキームのPicard、滑らかな曲線のJacobian、線束降下・変形。非被約曲線を含む相対Picardは1.5が構成する。 |
| <a id="dependency-supports"></a>supports | [SchemeAndStackFoundations](../../TauCetiRoadmap/SchemeAndStackFoundations/README.md) — 2.7 | 台付きコホモロジー、局所化・切除、NoetherianなExt余極限と局所コホモロジーとの比較。第一境界層の直線、台付きコホモロジーへの単射、および時間直線との同定は5.3が構成する。 |
| <a id="dependency-surfaces"></a>surfaces | [SchemeAndStackFoundations](../../TauCetiRoadmap/SchemeAndStackFoundations/README.md) — 3.4; 4.11; 4.17; 5.9–5.10 | 因子・Picard群、ブローアップ・狭義変換、正規交叉、曲面交点・随伴・格子。非被約境界と相対変形は目標5.1–5.3、変換は目標5.4–5.6が担う。 |
| <a id="dependency-formal-series"></a>formal-series | [FormalLaurentPuiseux](../../TauCetiRoadmap/FormalLaurentPuiseux/README.md) — L1–L4; L5–L6 for finite-extension steps in 1.1 | 形式代入・連続微分・有限次元HahnModule・留数・分岐と有限拡大の代数。微分加群標準形と降下は1.1が担う。 |
| <a id="dependency-fredholm"></a>fredholm | `Mathlib.Analysis.Normed.Operator.Fredholm.Basic`; `TauCeti.Analysis.Fredholm.Stabilization`; `TauCeti.Analysis.Normed.Operator.Splitting.Family`; `TauCeti.LinearAlgebra.Determinant.Line` — IsFredholm; nonempty_fredholmPackage; exists_stabilization_kernel_coordinates; kernelHomeomorph; contDiffAt_kerSection; detLine; detLineCongr | 体を複素数に特殊化できる核・余核・安定化と各点の行列式線。双対規約を用い、正則な族・標準切断・コサイクルは6.1が構成する。 |
| <a id="dependency-inversion"></a>inversion | `Mathlib.Analysis.Analytic.Constructions` — analyticAt_inverse; analyticAt_inverse_one_sub | 完備ノルム代数の可逆元における解析的逆写像。安定化に用いる実際の正則族と作用素の比較は6.1が証明する。 |
| <a id="dependency-trace-ideal"></a>trace-ideal | [OperatorTheory/OperatorIdeals](../../TauCetiRoadmap/OperatorTheory/OperatorIdeals/README.md) — OI-B01–OI-B19; OI-B23; OI-B29–OI-B30 | 完備なトレースクラス・イデアルとノルム評価。実際のRHPからの実現と、そのトレースノルムでの正則依存性は6.3–6.4が担う。 |
| <a id="dependency-trace-determinant"></a>trace-determinant | [RandomMatrices](../../TauCetiRoadmap/RandomMatrices/README.md) — 8.3, generic operator-theory prefix | 正の核への特殊化以前の一般的なトレース・外冪・Fredholm行列式級数・トレースノルム連続性。正則族の仮定と変分比較は6.4が担う。 |
| <a id="dependency-toeplitz"></a>toeplitz | [OperatorTheory/ToeplitzOperators](../../TauCetiRoadmap/OperatorTheory/ToeplitzOperators/README.md) — T1–T3 | 円周Hardy模型と可逆行列記号の指数＝行列式回転数の負。6.3が実際の積分路・正則族・共鳴・分岐の比較を構成する。 |
| <a id="dependency-curve-functions"></a>curve-functions | `TauCeti.Analysis.Complex.RiemannSurface.FunctionField`; `TauCeti.Analysis.Complex.RiemannSurface.FunctionField.Comap` — TauCeti.RiemannSurface.MeromorphicFunction; Nonconstant curve pullback and order comparison | Riemann面からOnePoint ℂへの正則写像と恒等的無限大を除く証人、引戻し・位数。相空間の観測許容性とスカラー降下は0.7が証明し、同じ関数の対象を用いる。 |
| <a id="dependency-proper"></a>proper | `Mathlib.Topology.Maps.Proper.Basic` — IsProperMap | 位相的固有写像と各仮定の下でのコンパクト逆像・基底変換。水平延長は 0.4、実際の族への解析比較の適用は 1.2、RH 族の固有性は 4.4 が担う。 |

### 補助構成の一次文献

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

有限次元多様体上の非線形接続について、射・引戻し・局所解・移送・観測の理論を構成する。適用側は相空間の族と接束の分裂を与え、用いる定理に応じて微分形式や比較写像の仮定を満たす。この一般理論の仮定には、階数2、極次数、スカラーのパンルヴェ方程式、Riemann–Hilbert比較を課さない。

### 定理と構成

| 目標 | 独立に提供する結果 | 利用側が証明すべき追加の入力 |
|---|---|---|
| 0.1 | 非線形接続の対象・射・曲率・基底変換 | 実際の沈め込みと接束の分裂 |
| 0.2 | 局所経路持上げとコンパクト延長 | 時間の連続性と相変数の局所一様 Lipschitz 評価 |
| 0.3 | 正則水平芽とパラメータ依存 | 正則分裂と時間方向の平坦性 |
| 0.4 | 固有半共役による完備性移送 | 固有写像と、すべての点からの部分持上げに対する整合性 |
| 0.5 | 基本亜群作用・普遍被覆上の切断・降下 | 平坦性と経路完備性 |
| 0.6 | 全空間形式の閉性判定と symplectic transport | ファイバー上の閉性・非退化性と、明記した保存性または全空間閉性 |
| 0.7 | 許容評価とスカラー降下 | 複素曲線上の実際の許容観測 |
| 0.8 | 内在的一階 jet によるスカラー化 | 観測と、証明済みの局所 jet 同型 |

§0.8のスカラー化は、接続と観測のジェット写像を用いる。§0.4の固有半共役による完備性定理は、§0.2の局所持上げ理論を持つ接続に適用し、§0.5の基本亜群移送にはさらに平坦性を課す。§0.7の有理型評価は、観測の許容条件の下で、複素曲線からの正則写像に適用する。

### 正則性の仮定

実 $`C^1`$ 版は個々の水平経路持上げに用いる。曲率・微分形式の恒等式・滑らかな平坦積定理には滑らかな実データを用いる。複素版では有限次元複素多様体上の正則データを用いる。このレイヤーの基底は有限次元の滑らかな多様体とする。

目標0.1–0.3で非線形接続と局所解理論を構成する。§0.5は経路完備性を仮定とし、§0.4はその一つの十分条件を与える。§0.6は相対2形式を入力として、その保存性と付随する全空間形式の閉性を特徴付ける。適用側でその形式を構成した上で、この判定法を用いる。

<a id="target-0-1"></a>
### 0.1 Ehresmann 接続・射・基底変換

**一般理論。**

$`\pi:M\to B`$ を、境界を持たない有限次元 Hausdorff・第二可算な滑らかな多様体の間の滑らかな沈め込みとする。実非線形接続とは $`d\pi\circ h=\mathrm{id}`$ を満たす $`C^1`$ ベクトル束分裂 $`h:\pi^*TB\to TM`$ である。正則版では複素多様体、正則な沈め込み、正則分裂を用いる。$`\pi`$ の全射性・固有性は定義に含めない。曲率・微分形式・滑らかな Frobenius 理論を使う箇所では実分裂を滑らかと仮定し、$`C^1`$ 版は個々の経路の持上げに用いる。

射 $`(F,f):(M\to B,h)\to(N\to C,k)`$ は、$`\rho F=f\pi`$ および $`dF\circ h=k\circ df`$ を満たす実際の滑らかな写像の組とする。正則圏では正則写像を用いる。恒等射と合成は写像の恒等射と合成である。同型は射、逆射、および両方向の逆射の恒等式からなる。

滑らかな、または正則な基底写像 $`u:B'\to B`$ に対し、ファイバー積 $`M'=B'\times_BM`$ と射影 $`\pi'`$ を構成し、$`h'_{(b',m)}(v)=(v,h_m(du(v)))`$ により引戻し分裂を構成する。これが接空間に属すること、分裂恒等式、射に関する関手性、反復基底変換の標準比較同型と整合律を証明する。水平・垂直接部分束を構成し、滑らかまたは正則な場合には垂直曲率 $`K_h(X,Y)=[hX,hY]-h[X,Y]`$ を構成する。平坦性とは $`K_h=0`$ である。水平解と完備性は targets:0.2–0.5 で扱い、相対 symplectic 形式は target:0.6 の別のデータとする。

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

**出典と適用範囲.** 明記した多様体と正則性の仮定を満たすすべての沈め込みと分裂に適用する一般的な構成である。

<a id="target-0-2"></a>
### 0.2 局所水平持上げと連続時間 ODE のコンパクト延長

**一般理論。**

有限次元座標領域上の $`y'=F(t,y)`$ について、$`F`$ が時間について連続で、相変数について局所一様 Lipschitz である場合の局所存在・一意性を証明する。十分小さい閉じた時間・相変数の箱で定数を一様に取る。沈め込み座標 $`\pi(z,y)=z`$ では、$`C^1`$ 基底経路 $`\gamma`$ と $`C^1`$ 分裂から $`y'=A(\gamma(t),y)\gamma'(t)`$ を得る。積分方程式の縮小写像論法で局所解を構成し、一意性・制限との整合性を証明し、座標解を貼り合わせて各初期点を通る一意な極大水平持上げを構成する。有限個の $`C^1`$ 区分を持つ経路では区切り点で解を連結する。

コンパクト延長補題を証明する。基底経路の有限端点まで定義された部分的水平持上げの像が $`M`$ の一つのコンパクト集合に含まれるなら、その端点を越えて延長できる。コンパクト集合付近の有限個の沈め込み座標、一様な局所存在時間、集積点と一意性により端点値と延長を得る。局所一意性により、集積点への収束と延長の一意性を証明する。同じ座標形式の通常の非自律 ODE にもこの補題を提供する。

$`C^1`$ 経路の速度は連続であるだけなので、自律化した場 $`(1,F(t,y))`$ は $`C^1`$ とは限らない。上記の連続時間定理、またはそれへの証明済みの帰着を用いる。この仮定の下では初期値への連続依存を証明する。滑らかな依存や正則依存は追加の正則性の下でのみ主張し、正則水平切断は target:0.3 で構成する。極大持上げは局所解から構成する。

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

**出典と適用範囲.** 局所 ODE の構成とコンパクト延長補題により、target:0.4 の固有半共役定理およびコンパクト包含の判定に用いる解析接続の議論を与える。

<a id="target-0-3"></a>
### 0.3 正則水平切断の芽とパラメータ依存

**一般理論。**

平坦な正則分裂を持つ正則な沈め込みについて、各 $`x_0\in M_{b_0}`$ を通り、$`\pi s=\mathrm{id},\ s(b_0)=x_0,\ ds=h`$ を満たす一意な正則水平切断の芽を構成する。沈め込みと分裂が、整合する有限次元複素多様体のパラメータ座標内で正則に変化する場合には、初期点と補助パラメータへの同時正則依存を含む局所存在を証明する。本定理のパラメータ基底は有限次元複素多様体である。

正則パラメータ依存を持つ複素 ODE の定理を証明する。共通多重円板上で Picard 反復を収束させ、一様収束から正則性を示し、一意性を証明する。局所基底座標では、平坦性から水平座標ベクトル場が可換となる。局所 flow の可換性を証明し、これらを合成して局所積座標と水平切断を得る。連結な重なり上の一意性と整合性も証明する。こうして得られる初期点と水平芽の対応は、実際の接続同型と整合する基底変換に関して自然である。これは局所構成であり、大域的解析接続は主張しない。

この局所 ODE 定理から水平芽を構成する。一変数複素基底では正則水平直線分布の平坦性は自動的であるが、高次元基底では実質的な仮定である。

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

**出典と適用範囲.** 局所複素 ODE の構成と可換な水平 flow により証明する。等モノドロミー水平切断は、この一般定理の応用である。

<a id="target-0-4"></a>
### 0.4 固有な半共役による完備性の移送

**一般理論。**

$`(M\to B,h)`$ を target:0.1 の実接続とする。$`p:R\to B`$ は位相空間の連続写像であり、完備な連続 transport が指定されているとする。すなわち、有限個の $`C^1`$ 区分を持つ各経路 $`\gamma:[a,b]\to B`$ と各 $`r_0\in R_{\gamma(a)}`$ に対し、$`\gamma`$ 上にあり $`r_0`$ から出発する連続軌道 $`\beta_{\gamma,r_0}:[a,b]\to R`$ があり、制限と連結の法則を満たす。$`R`$ は多様体でなくてよい。$`F:M\to R`$ は $`B`$ 上の連続写像で、コンパクト集合の逆像がコンパクトであるという明示的な意味で固有とする。

各始点での整合性を仮定する。すべての部分的水平持上げ $`x`$ が、その初期点 $`x_0`$ に対し、定義域全体で $`F(x(t))=\beta_{\gamma,F(x_0)}(t)`$ を満たす。このとき、上記のすべての基底経路と $`M_{\gamma(a)}`$ のすべての初期点について、コンパクト区間全体にわたる一意な水平持上げが存在することを証明する。この完備性定理に平坦性は不要である。

完全な標的軌道の像 $`K=\beta_{\gamma,F(x_0)}([a,b])`$ はコンパクトである。部分持上げは $`F^{-1}(K)`$ 内に留まるので、target:0.2 により有限端点を越えて延長でき、局所一意性により貼り合わさる。必要なのは $`F`$ の固有性であり、相空間射影 $`M\to B`$ の固有性ではない。$`F`$ の逆写像・単射性・全射性を用いない。非自明なコンパクト例外ファイバーも全体を保持する。そのファイバー内の指定初期点を通る持上げを target:0.2 により構成する。

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
- $`C^1`$ 経路 $`\gamma(s)=|s-1/2|^{3/2}`$ は適用範囲内である。その速度が連続にとどまることを target:0.2 で処理し、自律化した場は $`C^1`$ とは限らない。

*必要な先行結果：* 内部依存：0.1, 0.2.

**出典と適用範囲.** IIS06 Definitions 2.1–2.2 と Lemma 2.12 は、この幾何学的解析接続の議論の等モノドロミーの場合を与える。ここでは連続標的と明記した固有性・半共役の仮定の下で一般定理を証明し、各応用が比較写像を構成してその仮定を検証する。

<a id="target-0-5"></a>
### 0.5 基本亜群の transport・普遍被覆・降下

**一般理論。**

滑らかな実接続または正則接続が平坦であり、すべてのコンパクトな区分的 $`C^1`$ 経路に関して完備であるとする。各応用は target:0.4 または他の完備性定理によって、この完備性の仮定を検証する。一意な水平持上げから終点写像 $`T_\gamma:M_{\gamma(a)}\to M_{\gamma(b)}`$ を構成し、恒等・逆向き・連結の法則を証明する。$`\gamma_1`$ の後に $`\gamma_2`$ をたどる場合、$`T_{\gamma_2*\gamma_1}=T_{\gamma_2}\circ T_{\gamma_1}`$ と約束する。

端点を固定したホモトピーに対する不変性を証明する。局所平坦積座標、コンパクトなホモトピーの有限分割、重なり上の一意性を用い、連続ホモトピーを区分的に滑らかな代表に関係づける近似または分割の段階も含める。これにより $`B`$ の基本亜群の作用を構成する。終点写像は実の場合には微分同相、正則の場合には双正則写像である。symplectic な transport を得るには、さらに target:0.6 の水平保存条件を要する。

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

**出典と適用範囲.** 平坦接続と被覆理論から transport と降下の定理を得る。IIS06 は幾何学的モノドロミーへの応用を与え、BOA01 の symplectic 等モノドロミーの設定では、さらに target:0.6 の保存条件を用いる。

<a id="target-0-6"></a>
### 0.6 symplectic 保存性と閉じた全空間二形式

**一般理論。**

滑らかな実または正則な沈め込みについて $`V=\ker d\pi`$ と置き、$`h`$ を同じ正則性の分裂とする。$`\omega`$ は $`V`$ 上の相対二形式で、各ファイバー上で閉かつ非退化であるとする。各応用で $`\omega`$ のこれらのファイバー上の性質を検証する。$`v^V=v-h(d\pi v)`$ と置き、実際の全空間二形式 $`\Omega(v,w)=\omega(v^V,w^V)`$ を構成し、$`\ker\Omega=\mathop{\mathrm{im}}\nolimits h`$ を証明する。

基底ベクトル場 $`X`$ と垂直ベクトル場 $`U,V`$ に対し

```math
(D^h_X\omega)(U,V)=hX\bigl(\omega(U,V)\bigr)-\omega([hX,U],V)-\omega(U,[hX,V])
```

と定義する。$`d\Omega`$ の全成分を計算する。三つの垂直ベクトルでは $`d_V\omega`$、$`(hX,U,V)`$ では $`D^h_X\omega(U,V)`$、$`(hX,hY,U)`$ では $`-\omega(K_h(X,Y),U)`$、三つの水平ベクトルでは零である。垂直非退化性を用いて

```math
d\Omega=0 \quad\Longleftrightarrow\quad K_h=0\ \text{かつ}\ D^h\omega=0
```

を証明する。さらに、局所的に定義された平行移動が相対形式を保存することと $`D^h\omega=0`$ が同値であることを別途証明する。平坦性と保存性は異なる条件である。水平保存性に加えて平坦性と完備性もあれば target:0.5 と合わせて symplectic な大域 transport を得るが、局所判定に完備性は不要である。

水平保存条件 $`D^h\omega=0`$ を証明した上で、時間基底が一次元の場合に限り、局所 symplectic 自明化と相方向の必要な局所完全性の下で、$`\iota_{X_H}\omega=d_{\rm phase}H`$ により $`h\partial_t=\partial_t+X_H`$ の Hamiltonian ポテンシャルを得る。Darboux 座標では内在的全空間形式が $`\Omega=\sum_i dq_i\wedge dp_i+dH\wedge dt`$ と表示される。連結な相座標上の $`H`$ の時間だけに依存する不定性と、時間依存 symplectic 座標変換則を、実際の全空間形式の比較から証明する。この座標公式の時間基底は一次元であり、多時間では水平二成分も扱う必要がある。

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

**出典と適用範囲.** テンソルと微分形式の計算により、成分恒等式と保存性の判定を証明する。I23 Definition 11.4 と Corollary 11.8、BOA01 §7 は、それぞれの仮定の下で特殊な幾何学的構成と比較を与える。

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

- P¹ 値の評価と恒等的無限大を除く証人には、Riemann 面上の有理型関数の対象を用いる。許容された相空間観測との比較、引戻し、位数関数を構成する。降下には被覆の同値関係を用い、普遍被覆または連結正規被覆では covers の被覆変換作用と比較する。評価定理は、明記した観測データを持つすべての正則曲線写像に適用する。

*必要な先行結果：* 内部依存：0.1; [Complex manifolds, holomorphic bundles and observations](#dependency-complex) (K1; K3.0; K3.HolomorphicStalk; K3.MeromorphicGermField; K4; K7.1); [Covering spaces and universal covers](#dependency-covers) (Stage 0.2–0.4; Stage 1.5; Stage 2.6–2.8); [Native meromorphic functions on Riemann surfaces](#dependency-curve-functions) (TauCeti.RiemannSurface.MeromorphicFunction; Nonconstant curve pullback and order comparison).

**出典と適用範囲.** 複素曲線上の評価と被覆降下から一般定理を得る。IIS06 の幾何学的解と VDPS09 のスカラー座標は応用を与え、それぞれの観測量について許容条件を検証する。

<a id="target-0-8"></a>
### 0.8 一階ジェットと二階方程式

**一般理論。**

$`B`$ を複素時間曲線、$`\rho:E\to B`$ を相対次元一の正則な沈め込み、$`(M\to B,h)`$ を正則非線形接続とする。一階 jet 束 $`J^1(E/B)`$ を内在的に構成する。$`e\in E_b`$ の上のファイバーは、$`d\rho_e`$ の複素線型分裂 $`j:T_bB\to T_eE`$ のアフィン空間である。正則な遷移写像を構成し、これらの分裂が $`E\to B`$ の局所正則切断の一階 jet と対応することを証明する。

$`B`$ 上の観測 $`Q:M\to E`$ は

```math
J_Q(x)=\bigl(Q(x),dQ_x\circ h_x\bigr)\in J^1(E/B)
```

を定める。明示した開集合 $`U\subset M`$ 上で、$`J_Q:U\to V`$ が開集合 $`V\subset J^1(E/B)`$ への双正則写像であると仮定し、その仮定を検証する。分裂を $`V`$ に移し、接触条件を証明する。すなわち水平曲線に沿って jet 座標が観測切断の微分に一致する。これにより対応する二階力学を構成する。$`U`$ 内の水平切断の芽と、一階 jet が $`V`$ 内にありこの力学を満たす観測切断の芽との全単射を証明する。観測切断の一階 jet に $`J_Q`$ の実際の逆写像を適用して、逆対応を構成する。

座標補題では $`U`$ 上に観測に適合した座標 $`(t,q,p)`$ を選び、q を観測の局所ファイバー座標として、$`h\partial_t=\partial_t+A(t,q,p)\partial_q+B(t,q,p)\partial_p`$ と書く。jet 写像 $`(t,q,p)\mapsto(t,q,A(t,q,p))`$ が指定した逆 $`p=P(t,q,v)`$ を持つとする。このとき内在的二階力学は

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

**出典と適用範囲.** アフィン一階 jet の構成と連鎖律により力学を定義し、対応を証明する。VDPS09 §4.1 とその古典系の表示は、この座標補題の応用である。

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

§1.1の付加構造付き有理型接続のデータから、モジュライ族と、その平坦かつシンプレクティックな非線形時間接続を構成する。§2.4の構成定理は、§§1.1–1.2の局所模型・時間方向・行列式条件の下で、許容される任意の種数と正階数に適用する。

| 利用側が与える入力 | この枠組みが構成する出力 |
| --- | --- |
| 許容曲線・極因子・局所付加構造 | 許されるすべての束型上のスタックと剛化された安定モジュライ |
| 実際に許容される時間族と重みの部屋 | 実際の水平分裂・平坦性・引戻し比較 |
| 行列式の扱いとその検証条件 | 正確な行列式ファイバー比較と次元定理 |
| 基底全体を主張する場合の非空性の証人 | その基底上で全射となる正則非線形接続の基礎対象 |
| 同じ幾何学的入力 | 相対シンプレクティック形式・その保存・閉全形式 |

局所模型は、§1.1の対数完全旗模型、一般的不分岐不確定模型、一般的な全分岐因子分解模型とする。対数的な共鳴は旗と格子によって表す。ファイバーの非空性、大域的な行列式固定輸送、正種数での行列式固定モジュライの滑らかさには、以下に定める各々の仮定と比較定理を用いる。

### 依存関係

幾何学的構成は、非線形接続と引戻しに§0.1、微分形式の計算に§0.6を用いる。目標2.1–2.2で水平分裂を構成し、トレース形式の保存を証明する。§§2.5–2.6の対数型比較では、局所水平切断に§0.3を用いる。曲線・束、スタック、連接層コホモロジー、形式局所代数、複素幾何は外部依存に指定した理論を用いる。

表示亜群とその降下、階数1の行列式輸送、分岐関係式を含むトレース零・スカラー変形の比較、有限平坦展開変形、整合する基底変換写像を構成する。スカラー剛化はスカラー慣性を除く操作である。§1.5の仮定の下で、行列式固定は、滑らかな行列式射のファイバーを取り、変形空間を余次元2gの部分へ制限する操作である。

### 適用条件

利用側は局所模型と一般性の開条件を示し、実際の時間族と標識を指定し、行列式を固定しないか、固定行列式とその階数1時間輸送を検証する。有効な安定性の部屋を選び、全射な族を主張する範囲で非空性の証人を与えた上で §2.4 を適用する。適用側の目標で完備性の比較、スカラー観測量、特殊解の族を構成し、分類とRiemann–Hilbertの定理を証明する。

目標2.5–2.6は、I13の正確な範囲で固有な対数型Riemann–Hilbert半共役も供給する。利用側はNonlinearConnections §0.4の仮定を確認して完備性を得る。

<a id="target-1-1"></a>
### 1.1 許容される付加構造付き接続データ

**一般理論。**

複素基底上の亜群の族を定義する。その対象は、滑らかで固有な連結曲線の族、空でない順序付きの相異なる標識切断、構造的極因子 P = Σ mᵢaᵢ、整数の階数 r ≥ 1 と次数 d、および以下の局所データである。局所トレース極データを指定して行列式を固定しない問題と、適合する指定線束接続 (L,∇L) 上のファイバーである行列式固定問題の両方を構成する。後者では同型 det(E,∇) ≅ (L,∇L) も対象に含める。接続は曲線全体上の局所自由層、相対有理型接続、および付加構造からなる。行列チャートはこの大域的対象の表示を与える。射は実際に構造を保つ束同型である。

許容範囲は I23 §§2–5 の局所模型からなる。すなわち、m=1 で完全旗と次数付き留数を指定する対数極（共鳴・重複留数を含む）、m≥2 で ma 上の完全フィルトレーションと相異なる先頭固有値を持つ一般的不分岐極、および r≥2、m≥2、wʳ=z を満たす全分岐の一般的模型である。最後の模型は ν(w)=Σₖ₌₀ʳ⁻¹νₖ(z)wᵏ、ν₀=Σⱼ₌₀ᵐ⁻¹a₀ⱼzʲdz/zᵐ、k≥1 に対して νₖ=Σⱼ₌₀ᵐ⁻²aₖⱼzʲdz/zᵐ、a₁₀ 可逆という条件を持つ。この模型に対し、有限段階の因子分解型分岐構造、その関係式、形式模型との同値を構成する。根と形式座標は降下の射を備えた表示である。混合ブロック、任意の傾き、先頭固有値の衝突、a₁₀ の消滅は、この許容範囲に含まれない。

用いる重みの部屋では安定性と半安定性が一致するよう有理重みを選び、安定性は ∇ 不変な真部分束で判定する。整合性同型を伴う Cartesian 引戻しを構成する。これらの局所条件により、すべての種数と許容される階数・極次数における定義域を定める。

**入力条件**

- 複素数体上の滑らかで固有な連結曲線族、r≥1、d∈ℤ、空でない相異なる標識切断と構造的重複度、明記した三種類の局所模型、重みの部屋。
- 行列式固定の場合には、トレース極データおよび留数・次数関係と適合する線束接続と行列式同一視も与える。

**構成・法則（API）**

- 制限、引戻し、射の合成と逆射を構成し、結合子と単位の法則を与える。
- 台となる形式的微分加群、階数 r² − 1 の End⁰(E) 上の誘導接続、および付随する PGLᵣ 接続を同定する。後二者が不変な随伴・射影的出力である。局所行列 A − tr(A)I/r はフレーム内で射影接続を表すが、E 上に標準的に貼り合わされた階数 r の微分加群ではない。行列式線束の平方根は選ばない。
- 放物旗と対数格子を保持し、分岐降下によって同値な局所表示を比較する。
- 行列式との両立性を線束上の接続の同型として表し、選択した局所規約の下で留数・次数の等式を導く。

**検証事項**

- E = O ⊕ O(−1) の行列式の次数は奇数であり、大域的な行列式の半分による捻りは存在しない。この束の行列式が指定されたものに一致するとき、この束を対象として含める。
- 同じ重複固有値をもつ二つの対数留数について、一方がスカラーで他方が非零 Jordan ブロックである場合、固有値を指定しても両者は同一視されない。許容される放物的対象とモノドロミーは異なる。
- 階数 2 の分岐チャートで根 w を −w に変えると、表示された枝は変わる。保持した降下の射によって、得られた降下後の対象を同定する。
- I23 の分岐に関する規約では、階数 2 の分岐点は留数・次数の関係に 2c + 1/2 を寄与する。これを 2c に置き換えると、その関係が 1/2 だけ変わる。
- 傾き安定性または次元公式を適用する前に、階数 0 の入力を除く。r = 1 では随伴束 End⁰(E) の階数は 0 であるが、E 自身に課す正の階数という条件は変えない。
- A = 0 とフレーム変換 g = diag(z,1) に対して、g⁻¹dg = diag(1,0)dz/z である。そのトレースの半分を引くと diag(1/2,−1/2)dz/z になる。このスカラーのずれにより、トレースを引いた階数 2 の接続は E 上に貼り合わさらないが、誘導された End⁰(E) 接続と PGL₂ 接続は貼り合わさる。

**本目標が担う補助構成。**

- CrystallineCohomology CR.1.3 の通常の接続とテンソル・双対・基底変換を、FormalConnectionsOpers F2.1 の微分形式による接続およびテンソル対称性の比較を介して用いる。有限局所自由層 E 上で、相対有理型接続 E→E⊗Ω¹(P) を一次の Leibniz 則により定義し、微分作用素・主部には ComplexComparisonPartII C5.1 の対象を用いる。P の補集合への局所化が共通の通常の接続を与え、極の上界が同じ層写像の条件であることを証明する。付加構造付きゲージ亜群を構成する。用いる各テンソル・双対・Hom について、誘導される極の上界と局所構造を構成し、許容域に入ると主張する場合はその条件を確認する。行列式・End⁰ との比較を実際の層とコサイクル上で証明する。各標識相対 Cartier 因子での完備化には FormalConnectionsOpers F1.1–F1.3・F2.1・F3.3–F3.4 の連続／形式的対象とゲージ亜群を用いる。完備化した束の接続との比較、形式座標変換との両立、許容局所構造の分岐引戻しと被覆変換による降下は本項目が証明する。完備化した GL_r torsor は形式円板上に延びる。F3.4 の係数環の被覆条件を満たす範囲でスタック化との比較を証明し、適用ごとにその条件を確認する。e′=e·g に対する A′=g⁻¹Ag+g⁻¹dg と F3.3 の左作用 h·A=hAh⁻¹−(dh)h⁻¹ を h=g⁻¹ で比較し、行列式・留数・分岐座標との両立を含める。代数的／解析的比較への適用は 1.2 が担う。大域的な階数 r のトレース除去や行列式の根を導入しない。

- FormalConnectionsOpers F2.1 の共通の連続／形式接続を用い、ℂ((z)) 上の有限階数微分加群について、有限分岐 z=wᵉ の後の指数因子と確定特異加群への Levelt–Turrittin 分解を証明し、定数、分岐指数の細分、形式座標変換、被覆変換による降下を扱う。FormalLaurentPuiseux はスカラー演算に用いる。この共通の対象上で、分解と降下を証明する。I23 の有限段階の因子化モデルと基底変換は、先頭係数の非消滅・相異性を課した基底上で別途証明する。相対定理の範囲は、これらの衝突を除く領域である。3.4 は階数 2・構造次数 4 に特殊化し、4.1 は収束するセクター上の実現を構成して Stokes 分類を証明する。

*必要な先行結果：* [Ordinary algebraic connections](#dependency-ordinary-connections) (CR.1.3: ordinary connection carrier and operations); [Continuous formal connections and gauge groupoids](#dependency-formal-connections) (F1.1–F1.3; F2.1; F3.3–F3.4); [Differential operators, principal parts and analytic comparison](#dependency-differential-operators) (C5.1: shared algebraic operators/principal parts only); [Formal scalar and vector-valued Laurent algebra](#dependency-formal-series) (L1–L4; L5–L6 for finite-extension steps in 1.1); [Algebraic vector bundles and finite locally free sheaves](#dependency-bundles) (L0A–L0C; L1A–L1B; L2A–L2B); [Complex manifolds, holomorphic bundles and observations](#dependency-complex) (K1; K3.0; K3.HolomorphicStalk; K3.MeromorphicGermField; K4; K7.1); [Stacks, inertia and restricted coarse-space criteria](#dependency-stacks) (1.18–1.23).

**文献の範囲と担当証明：** I23 の Definitions 2.1, 2.2, 2.4, 2.7–2.8、Definition 3.1、Proposition 3.3、Corollaries 4.3–4.4、§5 が局所範囲を支える。これらの模型を座標から独立に定式化し、2-圏的な整合性を伴う降下を証明する。

<a id="target-1-2"></a>
### 1.2 許容時間族と行列式の輸送

**一般理論。**

対数留数と形式留数指数を固定して、曲線、標識極、許容された不確定極係数の変形亜群を構成する。I23 §5 の標点付き曲線スタックの滑らかなアトラス、有限座標ジェット、係数の開条件から始める。曲線の自己同型を保持し、標点付き曲線スタック上で座標変更の射と降下を構成する。B はこの時間問題の滑らかな複素チャート、標識被覆、または滑らかな複素基底からこの時間問題への任意の正則基底変換の源とする。写像自体が滑らかな射であることは要求しない。引き戻した族と分裂は、許容基底変換の比較によって構成する。B から除く係数判別式と衝突は入力で定まる。穿孔曲線族の位相的標識を局所的に構成して重なり上で比較する。時間族は、指定した曲線・ジェット・係数データと、その降下の射を備える。

行列式を固定しない場合には行列式切断を選ばない。固定する場合には、指定行列式の強い階数1の輸送を証明付きで必要とする。これは誘導されたトレース極データと固定留数を持つ、適合する可積分な全線束接続である。標識付きの可縮な時間チャート上では、固定した階数1の局所系を延ばし、指定対数格子と極部分の原始関数を貼り合わせてこの輸送を構成する。初期行列式への制限、極の上限、コサイクル則を確認する。種数0の対数的な場合には dlog による明示的構成も行う。大域的な行列式固定の出力には、これらの局所輸送の実際の貼り合わせデータ、または同じ性質を検証した全線束接続を要する。行列式族には、この可積分な全接続と貼り合わせデータを要求する。この階数1の構成が、§2.1 の階数 r の水平分裂定理に行列式の入力を供給する。

外部指数パラメータと時間方向を分ける。強いモノドロミー保存性は、不確定係数が許容時間方向に変化する間、輸送された解析データを保つ。代数的時間問題は曲線・ジェット・係数データから構成し、解析的 Stokes 分類は §4.1 が与える。

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

- ComplexComparisonPartII C−1.1–C−1.2 の単一の複素解析空間の圏、スキームおよび局所分離な有限型代数空間の解析化を、構造層・冪零元・開閉部分空間・ファイバー積・étale・滑らか・固有射の比較ごと用いる。連接層・有限局所自由層・解析的 étale 降下には C0.3–C0.5・C0.7 を用いる。実際の曲線・時間チャート・モジュライ表示について、供給された構成と表示写像および引戻しコサイクルとの一致を証明する。微分次元が一定の有限型分離滑らかスキームのチャートでは、FormalConnectionsOpers F2.4 の固定モデルの複素多様体と、複素点上恒等な構造層の比較を用いる。滑らかな代数空間では C−1.2・C0.7 を étale 表示に適用し、チャートの多様体比較が同じモジュライ対象へ降下することを証明する。任意の滑らかな解析基底については、複素次元 n が一定で Hausdorff・第二可算な滑らかな解析空間を、その解析的局所チャートと構造層を介して ℂⁿ をモデルとする既存の CKG 多様体と同定し、代数的チャートからの比較と両方が使える範囲で一致させる。次元が異なる場合は開かつ閉な各次元の部分空間で扱い、用いる各多様体の次元と位相的仮定を確認する。特異な Betti 標的や微小基底を含む一般の解析空間では、供給された対象と冪零元を保持する。供給された固有射の比較と解析的基底変換を実際の族に適用する。代数的構成は有限型 Noetherian 複素基底上のままとし、任意の滑らかな複素基底からの正則写像に沿う引戻しとコサイクル則を証明する。解析空間の圏、空間の解析化、étale 降下は、指定した ComplexComparisonPartII の各目標から得る。ここでは、許容族に対するそれらの写像とコサイクルを同定する。

- 安定標識曲線のアトラスは安定性の仮定を確認して用いる。種数 0 の一標識・二標識の場合は、実際の PGL₂ 安定化群を保持する商亜群、有限ジェットの torsor、係数の開条件と適合する滑らかなアトラスを構成する。これらは、上記の安定化群を保持する商亜群のアトラスである。標識切断を保つ相対的な滑らかな自明化から穿孔族の局所位相標識を作り、重なりで比較する。行列式の階数 1 の移送は、階数 1 局所系・指定対数格子・極部分の原始関数・dlog から独立に構成し、2.1 で用いる行列式輸送を供給する。

- 許容される各代数的曲線族、および比較に用いる各固有スキーム・代数空間に、ComplexComparisonPartII C1.9 の固有連接 GAGA と固有直像比較を適用する。固有性・有限型・連接性を確認し、標準的な交換写像を本構成の曲線・束・行列式の写像と同定する。各基底変換定理で主張する正確な仮定を保持する。1.1 の有理型 Leibniz 作用素の比較には C5.1 の主部による解析化と C5.2 の通常の正則接続との対応を用い、極因子・旗・有限段階の分岐因子化構造・行列式・制限・引戻しとの両立を証明する。一般の解析化・固有 GAGA・直像比較定理は ComplexComparisonPartII から受け取る。この解析的比較は、許容された代数的族の解析化と、許容された正則基底写像による引戻しからなる。非固有な基底上の一般の解析族を代数化するには、追加の仮定が必要である。

- 非空の相対標識因子をもつ滑らかな固有曲線族について、その因子が各幾何学的ファイバーで正の次数を持ち、相対的に豊富であることを証明する。Noetherian 代数基底の局所で十分正の倍数を相対的非常に豊富に取り、Quot 表示に使う射影的埋込みを構成し、共通の正の倍数を介して、選んだ冪と切断の基底を比較する。得られるモジュライ表示の比較は、その構成を行う 1.3 で証明する。射影性と有界構成に必要な偏極を明記した入力から得る。

*必要な先行結果：* 内部依存：1.1; [Marked-curve charts](#dependency-curves) (ComplexCurveModuli D0.3, D3–D5; SchemeAndStackFoundations 4.15); [Complex manifolds, holomorphic bundles and observations](#dependency-complex) (K1; K3.0; K3.HolomorphicStalk; K3.MeromorphicGermField; K4; K7.1); [Complex analytic spaces and analytification](#dependency-analytic-spaces) (C−1.1–C−1.2; C0.3–C0.5; C0.7; C5.2: ordinary connection comparison prefix); [Fixed-model manifold realization of smooth schemes](#dependency-algebraic-manifolds) (F2.4: fixed-model analytification and sheaf/tangent comparisons); [Proper coherent GAGA and direct images](#dependency-coherent-gaga) (C1.9); [Differential operators, principal parts and analytic comparison](#dependency-differential-operators) (C5.1: DifferentialOperatorAnalytification); [Cohomology, duality and curve degree](#dependency-cohomology) (2.2; 2.6; 2.20; 3.3); [Proper coherent direct images and base change](#dependency-proper-cohomology) (Layer C).

**文献の範囲と担当証明：** I23 §5 の曲線・ジェット・係数の時間スキームと §§10–11 が供給元である。明記した極・可積分性・初期値・貼り合わせの条件を満たす階数1輸送を構成し、許容時間亜群の座標降下を証明する。

<a id="target-1-3"></a>
### 1.3 すべての束型を含む安定モジュライ

**一般理論。**

§1.2 の許容時間問題上で §1.1 の安定対象のスタック、そのスカラー剛化、相対粗モジュライ空間を構成する。フィルトレーション付き束の有界パラメータ空間に、接続および因子分解構造の関係式を課す。モジュライの普遍性と有限型性を証明し、文献で支えられる設定では、相対粗モジュライ（スカラー剛化後の相空間の族）の分離性と準射影性を証明する。行列式非固定の安定スタックは、剛化前には Gm 慣性を持つ。許される束型はすべて含める。行列表示が覆うのはその実際の定義域に限る。エタール被覆上に普遍対象を構成し、以後に構成するすべてのテンソルのスカラー不変性を証明して粗モジュライ空間へ降下させる。

行列式を固定しない安定対象のスカラー慣性群は Gm であり、行列式同一視を固定すると μr になる。行列式固定と剛化は異なる操作である。行列式写像と指定行列式を持つモジュライ問題との比較を構成し、滑らかさと相対次元の計算は §1.5 で行う。必要な粗空間の基底変換比較はこれらの局所ジェルブ表示を通じて証明する。構成は局所的に空なモジュライも許す。B 内でファイバーが非空となる部分集合を定める。その開性と、その上で全射な解析的沈め込みとなることは、§1.5 の滑らかさの定理で証明する。この部分集合が B 全体に一致するという応用には、非空性の証明を含める。

各許容曲線・時間チャート上で、実際の族のスタックを 𝔐、そのスカラー剛化を 𝔐ʳⁱᵍ と書く。行列式非固定の場合、Q(S) を、C_S 上の族について、S 上の線束 L の引戻し p_S*L によるテンソルと同型を同一視した集合と定義する。p_S*L には C_S/S に沿う標準的な相対接続を用い、付加構造も移す。行列式固定の場合、そのテンソルには行列式同一視と両立する自明化 L⊗r ≅ O_S も含める。自然写像 π₀𝔐→Q→h_M、剛化 𝔐→𝔐ʳⁱᵍ、および Q^sh ≅ h_(𝔐ʳⁱᵍ) ≅ h_M を構成する。ここで Q^sh は代数的試験基底上の fppf 層化であり、許容解析的基底上では対応する解析的層化を用いる。実際の族、そのスカラー剛化、基底線束によるテンソルを同一視した類を区別し、§2.5 では最後の集合値関手を I13 と比較する。

自明化された ℙ¹ 族上で、Σa_j=d を満たす順序付き分裂型 a=(a₁≥⋯≥a_r) ごとに、基底上 fppf 局所的に ⊕_j O(a_j) と同型な束の充満部分スタック Bun_a を定義する。同型の選択自体はデータに含めない。Bun_(r,d) への局所閉埋込みを証明し、その幾何学的点を分裂型 a と同定する。非被約基底でもこの相対部分関手を保持する。束を忘れる写像 𝔐→Bun_(r,d) による引戻しを 𝔐_a とし、そのスカラー剛化による局所閉な像 M_a↪M を構成する。この定義を ℙ¹ の表示変更に関して降下させる。使用する各フレーム付き行列チャートについて、𝔐_a への写像、フレーム群による商、M_a 内の実際の像を指定する。a₁−a_r≤1 で定める均衡型の部分が開であることを証明し、各チャートの補集合を、明記した周囲のモジュライ空間内で与える。

**入力条件**

- §1.1 の数値・許容局所データ、§1.2 の時間族、固定した重みの部屋、すべての束型。構成自体には非空性を仮定しない。

**構成・法則（API）**

- 実際の族のスタック、スカラー剛化、基底線束による商 Q、明記した層化との比較、および粗モジュライ写像の普遍性を構成する。
- 行列式を固定したファイバーも含め、制限および許容される基底変換との比較を証明する。
- 使用する分裂型ごとに 𝔐_a と M_a を構成し、その局所閉な包含と均衡型の部分の開性を証明する。各フレーム付きチャートを、指定した商と実際の像を通じて比較する。次数 0 では均衡型の部分は自明束の部分と一致する。各チャートの補集合を、指定した周囲のモジュライ空間内で記録する。
- 重みを変えるときは共通安定領域を同定し、その領域上の比較を構成する。

**検証事項**

- 安定対象にも、剛化前にはスカラー自己同型がありうる。集合値の粗商はこれらの射を忘れ、その存在から固定部分群が自明であることは従わない。
- 束の跳躍により、族が自明束のチャートから外れても、モジュライ空間内にはとどまりうる。束の跳躍だけでは、その相軌道は特異にならない。
- 拡大族 0 → O(−1) → E_t → O(1) → 0 では、E₀ = O(−1) ⊕ O(1) である一方、t ≠ 0 では E_t = O ⊕ O である。二つの分裂型の層の引戻しは A¹ 内の {0} とその補集合であり、前者は開ではない。接続モジュライ全体は、許容される接続の範囲でこのような束の跳躍を保持しなければならない。
- 上の束の族を t=0 に引き戻すと、均衡型の部分は空になるが、その A¹ 内の閉包の引戻しは一点である。したがって、この基底変換と閉包は可換でない。
- 許容された全分岐の一般的局所模型は形式的微分加群として既約なので、その局所模型を持つ大域接続には ∇ 不変な真部分束がなく、すべての重みで安定である（I23 Remark 2.9）。この形式的既約性の仮定は、§1.1 の許容された全分岐の一般的局所模型である。

**本目標が担う補助構成。**

- フィルター付き接続の有界性を証明した上で SSF4.14 から有限型のパラメータ空間を構成し、簡約フレーム群、線形化、選んだ有理放物重みに対する Hilbert–Mumford 条件との同値を指定する。必要な不変式の有限生成、安定な幾何学的商・アフィン圏論的商を証明し、I23 の範囲で実際のモジュライ普遍性・分離性・準射影性を得る。Isom 層の fppf 商とスタック化によって中心 Gm の rigidification を作り、その gerbe・基底変換の普遍性と GIT 粗モジュライとの比較を証明する。行列式同定を含む場合の μr 慣性は別に比較し、有限慣性の Keel–Mori を使う箇所を限定する。各テンソルのスカラー作用が自明であることと粗モジュライの基底変換をこの表示上で証明する。

- 有限型の代数的な曲線・時間チャートごとに、有界なフレーム付き Quot 表示の解析化が、1.2 で許容する滑らかな複素基底からの任意の正則基底変換後に、対応する解析的な族を表すことを証明する。十分正のねじりによる局所解析的生成、連接な解析的直像と基底変換、正則フレームと因子化接続の方程式、実際の関係の降下を構成する。これにより、各許容された滑らかな解析基底上で、2.3 に用いる解析的モジュライ比較を構成する。これらの表示写像を介して解析的商と構成済み GIT 商の解析化を同定する。1.4 で変形複体を構成し、そのフレーム付き微小変形と versal チャートを、ここで GIT により構成したモジュライ空間と比較する。

- 1.2 で構成した正の冪と射影的埋込みから得られる有界な Quot/GIT 表示を比較する。まず両表示と実際の点の関手への写像を構成し、その後で証明したモジュライの普遍性から互いに逆の比較写像と、合成・基底変換の法則を得る。これにより、明記した曲線の安定性問題における補助的な偏極・フレームの選択からの独立性を証明する。

*必要な先行結果：* 内部依存：1.1, 1.2; [Quot/Hilbert and parameter schemes](#dependency-quot) (4.14); [Stacks, inertia and restricted coarse-space criteria](#dependency-stacks) (1.18–1.23); [Quotient predicates](#dependency-quotient-predicates) (1.17); [Elementary deformation theory](#dependency-deformation) (4.2–4.6).

**文献の範囲と担当証明：** I23 Theorem 5.1 と §§7–10 が許容モジュライの構成を与える。このモジュライ問題に対し、指定行列式、剛化、粗空間の基底変換の比較を構成する。

<a id="target-1-4"></a>
### 1.4 微分作用素による変形複体とトレースペアリング

**一般理論。**

局所構造を保つ無限小自己準同型、許容された接続の変化、因子分解型分岐構造の全関係式から変形複体を構成する。二項接続複体 G• から始め、分岐を伴う場合は F• = Cone(G• → S•ram[1])[−1] 全体を保持する。次数 0、1、2、両微分、および局所因子分解項を含める。二項複体への置換には擬同型の証明を要する。無限小自己同型、接ベクトル、障害類を超コホモロジーで同定し、トレース・Serre 双対ペアリングを構成する。

∇ との交換子は ℂ 線形の一階微分作用素であり、一般に O 線形ではない。基礎となる各項が連接である ℂ ベクトル空間の層の複体を用い、Čech 全複体と項別の双対性計算によって扱う。鎖写像と擬同型で表示・被覆からの独立性を証明する。行列式変形複体へのトレース鎖写像 tr:F•→D• を構成し、そのホモトピーファイバーを指定行列式の変形複体と、符号および局所因子分解との両立性込みで比較する。ここでは鎖写像、ホモトピーファイバーとの比較、双対複体を構成する。§1.5 でスカラー切断と直和分裂を構成し、直交性、行列式写像の滑らかさ、次元定理を証明する。スカラーゲージ自己同型と実際の無限小行列式変動は異なる方向である。

**入力条件**

- §1.3 の安定モジュライ問題と許容フィルトレーション・因子分解型分岐の関係式。行列式非固定の場合と指定ファイバーの両方を扱う。複体とペアリングは出力である。

**構成・法則（API）**

- 微分、局所的な両立条件、および無限小族からそのコサイクルへの写像を与える。
- ゲージ変換とコバウンダリーの対応を双方向に証明する。
- tr:F•→D•、指定行列式の変形複体とそのホモトピーファイバーとの比較、および符号を含めた双対複体を構成する。スカラー切断による分裂は §1.5 で証明する。
- 入力の同型および許容される基底変換に関するペアリングの自然性を証明する。

**検証事項**

- u による無限小ゲージ変換は、接続の代表元を u の交換子微分だけ変える。その接空間での類は 0 である。
- 行列式同一視を固定しなければ安定対象のスカラー自己同型は1次元の無限小方向を持つ。標数0で同一視を固定するとその方向は消えるが、剛化するまで有限群 μr は残る。スカラーの無限小自己同型方向を除くことと、接空間にトレース零条件を課すことは異なる。後者が 2g 個の行列式変形方向を除くことに対応するという同定は、§1.5 で証明する。
- ω = dq ∧ dp の下では、順序付き接ベクトル対 (∂q, ∂p) のペアリングは +1、逆順では −1 である。トレースの規約が逆の場合、移送公式を用いる前に補正しなければならない。

**本目標が担う補助構成。**

- 連接な基礎項と実際の ℂ 線形一次微分作用素をもつ複体を、ℂ ベクトル空間の層の Čech 全複体として構成し、細分・被覆独立性・錐の符号・トレース対・項別 Serre 双対との両立を証明する。分岐因子化の全関係を含む三項の錐について、実際の持上げコサイクルから自己同型・接空間・障害を同定する。SSF4.5 の基本的小拡大の枠組みを有限次元平方零核へ拡張し、得られる持上げ写像と障害写像の線形性、直和との両立、基底変換に関する自然性を証明する。

- ComplexComparisonPartII C5.1 の標数によらない有限階微分作用素・主部、DifferentialOperatorAnalytification、boundedOperatorHyperGaga を用いる。各固有複素曲線上の付加構造付き有界変形複体について、微分作用素の位数の上界、全項の連接性、解析化した微分と実際の局所条件との両立を証明する。供給された比較写像を、分岐三項錐の鎖写像と、因子化関係・トレース・双対ペアリングを含めて同定する。合成との両立および固有な微分作用素複体の GAGA は C5.1 から受け取る。付加構造付き複体を構成し、その仮定と比較写像の同一視を確認する。連接 O 加群を基礎項とし、ℂ 線形微分作用素を微分とする複素ベクトル空間の層の複体として扱う。相対族 p:C→B では p⁻¹O_B 線形性と固有・連接・有界の仮定を証明してから供給された相対比較を用い、追加のコホモロジー・基底変換の主張では正確な平坦性・有限性の仮定を保持する。この構成の微分作用素に関する入力は、C5.1 の有限階主部による定式化である。

- 相対族 p:C→B では層の p⁻¹O_B 加群構造と接続微分の p⁻¹O_B 線形性を保持する。O_C 線形ではない。基底の加群作用を含めて付加構造付き Čech 全複体とトレースを構成し、この複体上で C5.1 の主部・相対 GAGA の比較写像を同定して、主張する各基底変換写像との整合性を証明する。この基底に関する相対加群構造を保持したまま、各ファイバー上で絶対的な ℂ 線形コホモロジーとの比較を証明する。

- 実際の持上げ方程式と変形複体からフレーム付き微小変形と versal チャートを構成し、1.3 で有界 GIT により構成したモジュライとの接空間・障害・持上げの比較を証明する。

*必要な先行結果：* 内部依存：1.3; [Cohomology, duality and curve degree](#dependency-cohomology) (2.2; 2.6; 2.20; 3.3); [Elementary deformation theory](#dependency-deformation) (4.2–4.6); [Differential operators, principal parts and analytic comparison](#dependency-differential-operators) (C5.1: shared algebraic operators/principal parts; C5.1: DifferentialOperatorAnalytification; C5.1: boundedOperatorHyperGaga); [Proper coherent GAGA and direct images](#dependency-coherent-gaga) (C1.9).

**文献の範囲と担当証明：** I23 §6、(6.9)、Proposition 6.3、§7 Proposition 7.2。指定行列式のファイバーを、トレース写像のホモトピーファイバーおよびそれと両立するトレース零複体と比較する。

<a id="target-1-5"></a>
### 1.5 滑らかさ・次元・行列式ファイバー

**一般理論。**

§1.4 を用いて、許容範囲で安定モジュライ族の障害消滅と滑らかさを証明する。時間基底内でファイバーが非空となる部分集合が開であり、その上への解析的制限が全射な沈め込みとなることを証明する。相対接束を第一超コホモロジーで同定する。行列式を固定しない非空の安定ファイバーについて dim M_b = 2r²(g−1)+2+r(r−1)deg P を導く。この公式では局所トレース極部分を固定している。

行列式固定の結果を供給するために、このトレース極部分を持つ線束接続のモジュライを構成する。各ファイバーでは Picᵈ(C_b) 上の階数 g のアフィン束となり、接複体は正則 de Rham 複体 O_C → Ω¹_C であることを証明する。§1.4 で構成したトレース鎖写像 tr:F•→D• に対し、ℂ 上で 1/r を用いるスカラー鎖写像の切断 s を分岐の全関係式と両立させて構成し、tr∘s=id を証明する。そこから直和への擬同型 F• ≃ F•det ⊕ D• を構成する。F•det は §1.4 で比較した指定行列式のホモトピーファイバーである。指定安定領域で行列式写像が滑らかであり、接写像が 2g 次元の行列式接空間へ全射であることを証明する。ジェルブの比較後に指定行列式の粗モジュライ族を対応するファイバーと同定する。この滑らかな行列式写像から dim M_b^det = 2(r²−1)(g−1)+r(r−1)deg P を導く。トレースペアリングがトレース零方向とスカラー方向に直交分解し、行列式固定接空間上でも非退化であることを証明する。階数1で行列式を固定したファイバーは0次元である。

複体全体について、変形関手の比較、行列式写像の滑らかさ、トレースの直交分解を証明する。指定行列式のファイバーへの制限から、明記した仮定の下でその次元・シンプレクティック性の定理を得る。種数0では、行列式固定と非固定の次元は一致する。

**入力条件**

- §1.3 のモジュライ構成と §1.4 の実際の複体・トレースペアリング、ℂ 上で許容された局所模型。
- 次元の主張は非空の安定ファイバーについて述べる。行列式固定の結論には、本項目で証明する行列式写像の比較をさらに要する。

**構成・法則（API）**

- 相対接層を同定し、接空間と障害の計算に関する基底変換との両立性を証明する。
- §1.4 のトレース射と指定行列式のホモトピーファイバーに対し、スカラー切断 s を構成し、tr∘s=id、直和への比較、およびすべての局所両立条件を証明する。
- 滑らかな行列式写像とトレースの直交分解により、2g 個の行列式方向を同定して除く。
- 正確な仮定を伴う行列式非固定・固定の次元定理を別々に供給する。

**検証事項**

- 種数 0、階数 2、次数 4 では −8 + 2 + 8 = 2 となり、構造的次数を 5 に変えると 4 になる。
- 正の種数で行列式を固定すると、行列式写像との比較を適用できる場合には 2g 個の方向が除かれる。種数 0 での一致をそのまま一般の場合に持ち出さない。
- r = 1、g = 1 では、行列式を固定しない公式は 2 を与え、線束上の接続全体を固定すると 0 になる。誤って 2 を与えてしまう階数 0 の入力は、定義域の外にある。
- g=1、r=2、deg P=1 では、対応する安定ファイバーが非空で比較が成り立つとき、非固定の公式は4、固定の公式は2を与える。スカラー安定化群だけを除く操作ではこの差を説明できない。

**本目標が担う補助構成。**

- 局所 Noetherian 基底上の射影的・平坦・有限表示の複素曲線族について、任意の基底変換後の O_B≅p_*O_C を仮定して fppf 相対 Picard 代数空間を構成する。連接コホモロジーの基底変換と、以下に明記する affine な平方零試験と相対コホモロジー次元によって相対的滑らかさを得る線束変形の証明を含める。単位成分・次元一定性の仮定を明示し、曲線や基底の非被約試験も保持する。JacobianChallenge C–D は連接コホモロジーと体上の幾何学的整な特殊例に限って用いる。滑らかな標識曲線では相対 Picᵈ と rigidify した Poincaré 束、適合するトレース極部分を固定した線接続のアフィン torsor を構成し、正則 de Rham 接複体・次元 2g・トレースとスカラーの分解・行列式写像の滑らかさを証明する。非被約曲線の Picard 定理はパンルヴェ固有の結果を前提にせず 5.1 に供給する。

- 形式的滑らかさは、準連接イデアル I を持つ affine な平方零肥厚 T₀↪T に局所化して検証する。平坦性により C_T 内の C_T0 のイデアルを p*I と同定する。H²(C_T0,p*I) に値を取る障害、制限同型を指定した持上げの同型類に対する H¹(C_T0,p*I) の torsor、および H⁰ から得る微小自己同型を構成する。固有かつ相対次元が高々1であることから q>1 で R^q p_*(p*I)=0 を証明し、基底の affine 性と Leray により H²=0 を得る。一般の試験基底は開被覆または fppf 降下で扱い、局所有限表示の判定から滑らかさを導く。絶対 H² の消滅には試験基底の affine 性を用い、一般の基底での結果は降下によって得る。PICREL tags 0D2C・0DNI・0DPJ・0DPK を用いる。

*必要な先行結果：* 内部依存：1.3, 1.4; [Cohomology, duality and curve degree](#dependency-cohomology) (2.2; 2.6; 2.20; 3.3); [Elementary deformation theory](#dependency-deformation) (4.2–4.6); [Picard over a field and Picard foundations](#dependency-field-picard) (JacobianChallenge Layer D; SchemeAndStackFoundations 1.1, 2.6, 3.4, 4.6, 4.14); [Proper coherent direct images and base change](#dependency-proper-cohomology) (Layer C).

**文献の範囲と担当証明：** I23 Theorem 7.5 と行列式による障害解析が、行列式非固定の滑らかさを与える。cone 全体の分解、直交性、行列式写像の滑らかさを証明し、明記した行列式固定の結論を得る。

<a id="target-1-6"></a>
### 1.6 有限平坦展開変形と閉シンプレクティック形式

**一般理論。**

相対トレース二形式を構成して普遍対象の被覆から降下させ、§§1.4–1.5 により非退化性を証明する。閉性は、本項目の補助構成で証明する。滑らかで整な補助基底 H 上で、固定極因子を I23 §8 の有限平坦因子に置き換える。分岐点では、相異なり0と1を避ける qⱼ に対し ∏ⱼ₌₁ᵐ⁻¹(z−hʳqⱼ)(z−hʳ) を用いる。展開変形された因子分解型局所構造を持つ単純接続のモジュライ代数空間、普遍対象を持つエタール被覆、相対変形複体、トレース形式を構成する。非被約ファイバーも含め、有限平坦な極台を持つこの族について、有界性と変形理論の主張を証明する。

H 上の滑らかさを証明し、元の安定モジュライ・複体・形式を中心ファイバーの適切な開部分と同定する。極が一般的位置に分離した稠密開パラメータ集合上で、対角的変形複体から、展開変形複体および対数放物的複体への二つの擬同型をトレース形式と適合して構成する。Čech カップ積・トレース計算とゲージ降下で対数トレース形式の閉性を証明し、両比較を通じて閉性を移す。整基底上のこの滑らかな族では相対三形式の層が局所自由であり、指定された稠密開集合への制限が零を検出する。全体で d_relative ω=0 を得て、中心安定領域へ制限し降下する。非被約基底への基底変換では、滑らかで整な補助基底上で証明した閉性の恒等式を引き戻す。

行列式固定の場合の閉形式は、行列式ファイバーへのこの形式の引戻しである。その非退化性は §1.5 の直交性比較から証明する。構成は、許容された階数・種数・局所模型の範囲全体に適用する。

**入力条件**

- 許容範囲における §§1.3–1.5。滑らかさ、補助的な単純接続族、一般部分の比較写像、閉性は出力である。
- 行列式固定のシンプレクティック性を供給するには、§1.5 の行列式ファイバー比較と非退化性の定理を用いる。

**構成・法則（API）**

- 有限平坦展開変形、単純接続モジュライ、普遍対象の被覆を構成し、中心ファイバーを同定する。
- 対角複体からの両比較写像を構成し、トレースペアリングとの両立性を証明する。
- 非退化性と閉性をそれぞれ証明し、降下および基底変換との両立性を含める。

**検証事項**

- 恒等的に消える交代ペアリングは閉じているが、シンプレクティックではない。非退化性は実際の双対性計算から導かなければならない。
- r = 2、局所次数 2、q₁ = 2 の場合、展開変形の方程式は (z − 2h²)(z − h²) である。h = 0 でのファイバーは z²、h = 1 では (z − 2)(z − 1) であり、h² を法として考えると再び z² になる。非被約な極因子上のものも含め、中心ファイバーと引戻し後の複体・形式を比較する。
- 許容された階数・種数・局所模型ごとに、§§1.3–1.5 のモジュライと変形のデータから、有限平坦展開変形、一般部分の両比較写像、閉性の証明を構成する。

*必要な先行結果：* 内部依存：1.3, 1.4, 1.5; [Cohomology, duality and curve degree](#dependency-cohomology) (2.2; 2.6; 2.20; 3.3); [Elementary deformation theory](#dependency-deformation) (4.2–4.6); [Algebraic vector bundles and finite locally free sheaves](#dependency-bundles) (L0A–L0C; L1A–L1B; L2A–L2B).

**文献の範囲と担当証明：** I23 Theorem 8.1、Propositions 8.2–8.3、(8.2) の直前の複体。補助的な有限平坦族、変形複体の両比較、トレース形式の降下を本目標で構成する。

<a id="layer-2"></a>

## レイヤー2：等モノドロミー変形と対数型 Riemann–Hilbert 対応

<a id="target-2-1"></a>
### 2.1 強い可積分延長と水平分裂

**一般理論。**

モジュライ点の時間接ベクトルに対し、対応する双対数変形上の普遍接続の強い可積分延長を構成する。動く全曲線 X 上で D を係数1の標識相対 Cartier 因子の和とし、滑らかな周囲の族で形成してから無限小基底へ引き戻す。許容される全微分形式の極のフィルトレーションは、固定補助基底に相対的な Ω¹_X(log D) ⊗ O_X(P−D) とする。可積分性と、局所フィルトレーションに付随する核格子、すなわち必要な構造的厚みを持つ E → E|_{mᵢaᵢ}/Fᵢ,k の核、および追加の因子分解関係式の保存を要求する。各ファイバーで別々に旗を保つだけでは足りない。動く極座標 z では許容形式が dz/zᵐ と dε/zᵐ⁻¹ で生成されるという座標補題を証明する。対数点では時間係数は正則である。

この強い延長の範囲内で、中心ファイバー上恒等となる指定同型を除く存在と一意性を証明する。局所持上げを貼り合わせ、普遍対象の被覆から降下して、実際の O 線形分裂 h:π*TB→TM を構成し dπ∘h=id を示す。行列式固定の場合には、構成した延長の行列式が §1.2 の検証済み階数1輸送に一致することを証明し、h が動く行列式ファイバーに接することを得る。ここで h と強い可積分延長を構成し、検証済み輸送との行列式の両立性を証明する。トレース形式の保存は §2.2 で証明する。

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

- 1.1 の形式的対象と 1.4 の実際の変形コサイクルを用い、許容される各双対数時間方向について、極加群 Ω¹(log D)⊗O(P−D)、核格子、因子化関係を保持する強い微小全接続を構成する。中心ファイバーの指定同定をもつ変形類の存在・一意性、行列式移送との一致、重なりと降下を証明し、rigidification 前の微小スカラー自己同型を保持する。混合時間方向の平坦性とトレース形式の保存は 2.2 が別々に証明し、正則基底変換のコヒーレンスは 2.3 が担う。FormalConnectionsOpers F8.1 の射は oper の reduction を忘れた形式接続の同型である。本構成では許容される不確定特異部の係数が時間とともに変化し、出力は時間基底上の大域的モジュライ族の分裂となる。ここで述べた微小変形コサイクルと重なりの比較から、大域的な分裂を構成する。

*必要な先行結果：* 内部依存：1.1, 1.2, 1.3, 1.4, 1.5, 0.1; [Elementary deformation theory](#dependency-deformation) (4.2–4.6).

**文献の範囲と担当証明：** I23 Definition 10.1、(10.1)、Lemmas 10.3–10.6、Propositions 10.7/10.10、(11.2)。行列式との両立性を証明し、内在的極フィルトレーションを明記した局所形式の加群と同定する。

<a id="target-2-2"></a>
### 2.2 平坦性・トレース形式の保存・閉全形式

**一般理論。**

二変数の強い延長と混合無限小項を比較して h([v,w])=[h(v),h(w)] を証明する。§2.1 の代数的な延長比較から、この交換子恒等式を導く。

剛化された相空間族の正則な水平切断 s:V→M に対し、§1.3 のスカラージェルブと普遍対象被覆を引き戻す。この被覆への持上げを持つ十分小さい時間チャート V_i 上で、代表となる付加構造付き族 (E_i,∇_i) と、その相対接続を制限として持つ強い可積分全接続を構成する。選んだ代表と s|_(V_i) との同一視を保持し、行列式固定の場合、全行列式接続は §1.2 で検証した輸送と一致させる。基底線束 L による代表の変更では、十分小さいチャート上で L に適合する可積分接続を選び、テンソル公式 ∇_tot′=∇_tot⊗1+1⊗p*∇_L と接続を保つ同型によって全接続を比較する。行列式固定の場合、L⊗r 上の誘導接続は指定した自明化に関して自明でなければならない。大域的な束と全接続を出力するには、接続を保つ遷移同型と三重共通部分でのコサイクル則を要する。この降下データを与えない場合、出力は引き戻したジェルブ上の局所対象であり、粗切断の任意の代表上に全接続があるとは主張しない。

実際のトレースコサイクルと強い延長の比較により、構成した水平変化が相対シンプレクティック形式 ω を保つことを証明する。任意の分裂の平坦性だけからこの保存性は従わない。Ω(v,w)=ω(v−h(dπv),w−h(dπw)) を定義し、dΩ=0 と ker Ω=im h を証明して、局所水平輸送による ω の保存を導く。これらの計算で証明した平坦性とトレース形式の保存に、NonlinearConnections §0.6 の微分形式の恒等式を適用する。シンプレクティック自明化と必要な局所完全性を備える時間1次元のチャート上で、相対次元2では Ω=dq∧dp+dH∧dt、高い偶数次元では対応する和を導く。スカラー Hamilton 関数はチャートに付随する局所原始関数である。

**入力条件**

- §2.1 の実際の強い分裂と §1.6 の相対シンプレクティック形式。行列式を固定する場合は §1.5 の比較定理も用いる。平坦性とその形式の保存は出力である。

**構成・法則（API）**

- 二変数の混合延長項を計算し、交換子恒等式と平坦な水平分布を得る。
- 指定した水平切断に対して強い全接続を持つ局所代表族を構成し、適合する基底線束接続によるテンソルの比較を与える。接続を保つ遷移写像とそのコサイクルを入力した場合の降下を証明する。
- 垂直方向への制限によって相対形式を、核として水平分布を復元する。
- 相対形式、実際の分裂、閉全形式について許容基底変換に関する自然性を証明する。
- 固定チャートにおける二つの Hamilton ポテンシャルを比較する。その差は連結な相ファイバーに沿って定数である。
- 拡張二形式の等式を通じて、時間に依存するシンプレクティック座標変換に伴う追加の生成関数項を述べる。

**検証事項**

- H = p²/2 の場合、dq ∧ dp + p dp ∧ dt と ∂t + p∂q の内部積は零である。符号を逆にすると零にならない。
- H と H + t² は同じ垂直ベクトル場と拡張二形式を与えるが、スカラー関数としては異なる。
- シンプレクティックなファイバー上では、Ω の核に非零の垂直ベクトルは存在しない。ω を零に退化させると、この特徴づけは成り立たない。
- ℂ²×ℂ で ω=dq∧dp、h(∂t)=∂t+q∂q とすると、基底1次元なので分裂は平坦だが、そのフローは ω を拡大する。この例はトレース形式保存の条件を満たさない。
- 行列式非固定の場合、ℙ¹_z×ℙ¹_B で極の切断を z=∞ のみとすると、E=pr_B*O(1) と相対接続 d_z は階数1の定値な粗水平切断を表す。B 方向に正則な全接続があれば、z=0 への制限は O(1) 上の正則接続になるが、そのような接続は存在しない。したがって、この粗切断から得るのは局所代表であり、この大域代表上の全接続ではない。

*必要な先行結果：* 内部依存：1.3, 1.4, 1.6, 2.1, 0.6; [Complex manifolds, holomorphic bundles and observations](#dependency-complex) (K1; K3.0; K3.HolomorphicStalk; K3.MeromorphicGermField; K4; K7.1).

**文献の範囲と担当証明：** I23 Theorem 11.6、Definition 11.4、Corollary 11.8。混合延長の計算により平坦性を、トレースコサイクルの変化によりトレース形式の保存を証明する。

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
- ここで構成する、f:B′→B 上の表示比較または基底変換比較 F:M′→M について、明記した定義域上で π∘F=f∘π′、dF∘h′=h∘df、F*ω=ω′、F*Ω=Ω′ を証明する。重み変更の定義域は §1.3 が供給し、実際の幾何学的変換とそのパラメータ写像は §5.4 が構成する。

**検証事項**

- f:B′→B と g:B″→B′ に対し、直接の (f∘g)* 構成を g*f* と比較し、標準比較写像について三重合成の整合性と、四つの合成可能な射に対する結合の五角形を確認する。
- 重みの壁越えは安定領域を変え、実際の共通安定領域を指定しない限り表示の同型ではない。
- 基底写像 t=s² では h(∂t) の引戻しは h′(∂s)=(∂s,2s h(∂t)) となる。s=0 でも水平ベクトルは ∂s に射影するので、基底写像を局所同型に限る必要はない。

*必要な先行結果：* 内部依存：1.1, 1.2, 1.3, 1.4, 1.6, 2.1, 2.2, 0.1; [Stacks, inertia and restricted coarse-space criteria](#dependency-stacks) (1.18–1.23).

**文献の範囲と担当証明：** I23 Propositions 10.7、10.10 が比較に使う一意性を供給する。この一意性から内在的な基底変換の比較を構成し、その2同型の整合性を証明する。

<a id="target-2-4"></a>
### 2.4 有理型接続モジュライ上の等モノドロミー接続

**一般理論。**

§§1.1–2.3 をまとめ、許容された各付加構造付き時間問題から、剛化された安定相空間族を構成する。滑らかな解析的時間基底の非空ファイバーの開部分上では、NonlinearConnections 0.1、0.6 の正則・平坦・シンプレクティック非線形接続 (π:M→B,h,ω) と、その閉全形式 Ω を得る。入力は曲線と局所接続データ、重みの部屋、行列式の扱いであり、これらのデータから h と相対形式・全形式を構成する。行列式非固定なら任意の種数と許容階数・極次数に適用する。行列式固定の出力には §1.5 の独立に証明した比較と §1.2 の検証済み時間輸送を要する。

局所模型の許容性、実際の時間基底、行列式検証、重み、非空性の証人を列挙する共通の利用証明書を与える。幾何学的対象、構成済みのテンソル、正確な範囲の次元定理、自然性、整合的引戻し則を返す。利用側が証明するのはこれらの適用条件と追加の特殊化結果である。特に相対次元2や時間1次元はこの構成定理の条件に含めない。完備性、固有 Riemann–Hilbert 比較、指定観測量、スカラー化、特別な解には、それぞれ下流の仮定と証明を要する。定理は、これらの許容条件の下で §§1.1–2.3 の構成と比較写像を組み合わせる。

**入力条件**

- §§1.1–1.2 の許容幾何学入力と時間問題、§§1.3–1.6 の安定構成、§§2.1–2.3 で実際に構成した h、平坦性、自然性。
- 全射な非線形接続の基礎対象を得るため、非空ファイバーの開時間領域に制限する。提案した基底全体について主張する利用側は非空性を示す。
- 行列式固定の出力には、行列式ファイバーの比較と階数1輸送の定理も用いる。

**構成・法則（API）**

- 許容幾何学入力から π、h、ω、Ω を構成し、沈め込み、分裂、平坦性、非退化性、保存性、閉性の各法則を証明する。
- 共通の利用証明書を供給し、構成・非空性・完備性のそれぞれに必要な仮定を明記する。
- §2.3 の標準比較を用い、基底変換と表示同値に関する法則を証明する。

**検証事項**

- 構成は、許容されたすべての種数・階数・極次数・時間次元に適用し、局所的な前提と出力は §§1.1–2.3 の幾何学的データにより定まる。
- ℙ¹ 上の階数2、5対数極、行列式固定、非空の安定領域では相対次元4、配置基底の次元2を得る。この入力を構成定理が受け付けなければならない。
- 任意の形式特異点の組は、次元の式が正になるだけでは許容されない。各局所模型と行列式・時間の証明書を確認する。
- 正則・平坦・シンプレクティック接続でも水平曲線は不完備になりうる。この出力だけでは全初期条件の大域延長を正当化できない。

*必要な先行結果：* 内部依存：1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 2.1, 2.2, 2.3, 0.1, 0.6.

**文献の範囲と担当証明：** I23 が許容された行列式非固定の構成模型を与える。これを §§1.1–2.3 で証明した行列式と整合性の比較と組み合わせ、明記した構成定理と適用条件を確立する。

<a id="target-2-5"></a>
### 2.5 標識付き対数 Betti 族と全 Riemann–Hilbert 写像

**一般理論。**

§1.1 の対数的部分問題に対し、穿孔曲線の表現多様体、共役によるアフィン商、指定局所指標を持つ部分族を位相的標識とともに構成する。指定した局所特性多項式データ a を持つこの通常のアフィン指標商を Rep_r(C,D)_a と書く。ここでは対数格子と放物旗を忘れる。de Rham 側の留数指数パラメータ λ と、Betti 側の指数写像から得る特性多項式パラメータ a=rh(λ) を保持する。留数パラメータ空間 Λ 全体上で §1.3 の有界構成を適用し、I13 の族との比較を証明する。水平分裂は λ を固定した相対的なものであり、λ の変化を時間方向にはしない。標識被覆上では Betti 族を輸送によって固定した指標多様体と時間基底の積に同定する。指標多様体が特異でも、これによりすべての許容時間経路に沿った完備な輸送を得る。滑らかな Betti 接束は要求しない。

§1.3 の安定対数放物接続モジュライ全体から正則 Riemann–Hilbert 写像を構成する。許される可約・共鳴対象とすべての束型を含める。水平切断の局所系とその共役商での類によって定義し、普遍対象の被覆から降下させる。§1.3 の安定な対数的族を基底線束によるテンソルで同一視した集合値関手を Q_log とする。局所 Noetherian スキーム上で、I13 Definition 4.3 と同じ重み、留数順序、同値関係を用いて自然同型 Q_log ≅ M_I13 を構成する。§1.3 の名前付きの写像を通じて fppf 層化、スカラー剛化、粗空間を比較し、誘導された粗空間の同型を別に証明する。解析化後には解析的層化を用いて対応する比較を構成する。これらの商写像により、実際の族の亜群と集合値関手を関係づける。対数格子を保持する全可積分延長と局所解の解析的依存性により、§2.1 で実際に構成した強い分裂が、すべての点で標識付き Betti 輸送と半共役であることを証明する。局所水平持上げの存在は Riemann–Hilbert 写像の可逆性とは独立に示す。共鳴・可約点では写像が正次元のファイバーを持ちうるので、逆写像で置き換えない。

検証済みの行列式輸送に対し、モノドロミーの行列式が階数1の Riemann–Hilbert 写像と一致し、指定行列式が輸送される Betti 切断となることを示す。Hausdorff で局所コンパクトな標識付き終域と全点での半共役を供給する。§2.6 で族の固有性を証明し、両者を NonlinearConnections §0.4 に適用して始域の完備性を得る。

**入力条件**

- §1.1 の対数局所部分問題、§1.2 の許容標点付き曲線時間問題と固定留数指数、§2.4 の実際の安定モジュライと強い接続。
- 穿孔曲線族の位相的標識被覆。行列式固定の結論には検証済み行列式輸送を要する。Betti 終域の特異点は許す。

**構成・法則（API）**

- 完備な経路輸送を持つ標識付きアフィン Betti 終域を構成し、保持する留数・指標パラメータ写像を示す。
- 実際の強い始域分裂について、特異な終域の層への写像も含む全点での Riemann–Hilbert 半共役を証明する。
- Q_log ≅ M_I13、その層化の比較、誘導される粗空間の同型を構成する。実際の族のスタックとその剛化からの写像、行列式、Riemann–Hilbert 写像、表示変更、解析的基底変換との両立性を証明する。行列式固定の場合は §1.3 の r 乗の自明化を伴う適合した基底線束のテンソルを用いる。

**検証事項**

- Riemann–Hilbert 写像が同型となる開集合は、安定な共鳴・可約対象すべてを含むわけではない。半共役はそれらの実際のモジュライ点でも確認する。
- 許された整数ずれを持つ二つの留数パラメータが同じ局所モノドロミー固有値を与えうる。a パラメータ上で de Rham 族を同一視せず λ を保持する。
- 特異なアフィン指標多様体も Hausdorff で局所コンパクトな解析空間であり、標識付きの完備輸送を持つ。終域の非特異性を要求すると、固有写像による延長論法に必要な層を除いてしまう。
- 一点上の安定対象 E₀ から得られる ℙ¹ 上の族 E₀⊠O と E₀⊠O(1) は、行列式を固定しない Q_log では同じ類を与えるが、実際の束として同型とは限らない。実際の族の亜群を M_I13 と同一視してはならない。

**本目標が担う補助構成。**

- 穿孔曲線上の CKG K4 から、指定した指数の持上げ・放物旗・実際の対数格子を備えた対数拡張を構成し、モノドロミー規約 exp(−2πiλ) と必要な確定特異の代数的／解析的比較を証明する。共鳴、重複留数、整数による指数変更と格子変更、すべての束の型を保持する。同値は局所系側にも格子・旗を記録し、それらを忘れる写像が一般には単射でない RH 写像になる。族の解析的依存性と普遍対象・標識被覆からの降下を証明する。

- 2.5 は 1.3 の不変式論を用いて有限型表現多様体と簡約群によるアフィン共役商を構成し、1.2 の解析化を適用して特異点を含む Hausdorff 性・局所コンパクト性・標識付き積移送を証明する。4.2 は wild/Stokes のフレーム亜群と、実際に簡約群商または降下が正当化される各段階の商を構成する。局所 Stokes 群が冪単であることから任意の GIT 商を推論しない。wild な比較に対する、根・被覆変換を保つ isotopy、分岐降下、安定化群との両立、および全層での正則写像は §4.2 で証明する。SSF1.17 から商の条件を受け取り、亜群・商空間・比較写像は上記の各段階で構成する。

- Deligne II5.4 の拡張は ℂ→ℂ/ℤ の切断を選んで構成され、一般にはテンソル積と両立しない。必要な整数分の格子変更を含め、実際の対数格子と留数和に対して行列式との両立性を証明する。モノドロミーの固有値は exp(−2πiλ) である。適切な非共鳴条件（II5.6）の下で、モノドロミー行列を exp(−2πi Res) と共役まで比較する。共鳴点では、特性多項式についての主張と実際のモノドロミー行列を保持する。全 RH 写像と階数 1 の Cartesian な行列式正方形の双方に、これらの比較を適用する。

*必要な先行結果：* 内部依存：1.1, 1.2, 1.3, 2.1, 2.2, 2.3, 2.4, 0.3; [Complex manifolds, holomorphic bundles and observations](#dependency-complex) (K1; K3.0; K3.HolomorphicStalk; K3.MeromorphicGermField; K4; K7.1); [Marked-curve charts](#dependency-curves) (ComplexCurveModuli D0.3, D3–D5; SchemeAndStackFoundations 4.15).

**文献の範囲と担当証明：** I13 Definition 4.3 と §4 の集合値モジュライ関手およびモジュライ空間、§2 の標識付き Riemann–Hilbert 写像、§6 の解析的比較、§8 のモノドロミー保存変形。スタック・剛化・基底線束による商・層化の比較を構成し、強い分裂の全点での比較と行列式との両立性を証明する。

<a id="target-2-6"></a>
### 2.6 対数型 Riemann–Hilbert 族の固有性

**一般理論。**

§2.5 で同定した安定対数放物接続モジュライ全体について、留数写像 rh:Λ_r^(n)(d)→A_r^(n) に沿って引き戻した指標族への標識付き Riemann–Hilbert 写像が族として固有であることを証明する。終域には (Rep_r(C,marked points)×_T T̃)×_{A_r^(n)}Λ_r^(n)(d) 全体を用い、一般的な滑らかな指標領域だけに制限しない。文献の正確な範囲は、階数 r≥2、n≥1、安定性と半安定性が一致する一般の重み、および g=0 なら rn−2r−2>0、g=1 なら n>1、g≥2 なら n≥1 である。留数空間は d+Σᵢⱼλⱼ^(i)=0 を満たす。族についての固有性と解析的基底変換での保存を証明する。個々のファイバーだけでの固有性では必要な結果にならない。正確な関手比較の後、この範囲では文献の定理から全射性と双有理型性も得られる。

行列式固定の場合には、de Rham・Betti モジュライの行列式を取る可換正方形を構成する。指定トレース留数と対数格子を持つ階数1の確定特異 Riemann–Hilbert 対応が同型であることを証明し、指定行列式の粗モジュライを対応する行列式 Betti 切断の実際の Cartesian 逆像と同定する。スカラージェルブの比較を含め、行列式同一視を選んだモジュライが、明記した粗ファイバーを与えることを証明する。その切断が輸送されるという主張には §1.2 の証明書と §2.5 の比較を要する。この証明した正方形に沿う固有な解析的基底変換により、行列式固定の族の固有性を導く。この比較は種数0でも必要であり、その場合の簡略化も証明する。

§§2.5–2.6 を合わせた固有半共役の証明書を供給する。利用側が実際の始域と時間領域について NonlinearConnections §0.4 を適用し、水平曲線の完全延長を導く。延長の段階には §0.4 の定理を用いる。本項目の固有性の範囲は、上記の対数的な場合とその数値条件である。

**入力条件**

- §2.5 の対数粗モジュライ族全体と Riemann–Hilbert 写像、および同項目の Q_log ≅ M_I13 と誘導された粗空間の比較。r≥2、n≥1、固定した種数・次数・留数データと d+Σᵢⱼλⱼ^(i)=0。
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
- ℙ¹ 上の5対数極を含む各応用では、検証した固有半共役に NonlinearConnections §0.4 を適用して完全延長を得る。

**本目標が担う補助構成。**

- Deligne II5.4 の拡張は ℂ→ℂ/ℤ の切断を選んで構成され、一般にはテンソル積と両立しない。必要な整数分の格子変更を含め、実際の対数格子と留数和に対して行列式との両立性を証明する。モノドロミーの固有値は exp(−2πiλ) である。適切な非共鳴条件（II5.6）の下で、モノドロミー行列を exp(−2πi Res) と共役まで比較する。共鳴点では、特性多項式についての主張と実際のモノドロミー行列を保持する。全 RH 写像と階数 1 の Cartesian な行列式正方形の双方に、これらの比較を適用する。

*必要な先行結果：* 内部依存：1.1, 1.2, 1.3, 1.5, 2.3, 2.4, 2.5.

**文献の範囲と担当証明：** I13 Theorem 2.2 のすべての数値条件、Remark 2.3(1)、§6、§8。明記した仮定の下で、この対数的な枠組みとの比較を証明し、行列式固定の Cartesian 正方形を構成する。

### 構成と証明の要件

- `M-local-presentation-descent` — §§1.1、1.2、2.3で内在的な入力亜群、座標と根の変更に関する整合的降下、およびI23の局所表示との比較を構成する。
- `M-determinant-time` — §§1.2、2.1で、許容される局所チャート上の階数1の強い行列式輸送、指定した証明書の下での大域的な貼合せ、および階数rの延長との行列式比較を構成する。
- `M-determinant-fiber` — §§1.4–1.6で、完全な分岐変形錐と正則な行列式de Rham複体を比較する。スカラー分解、行列式射の滑らかさ、2gの次元減少、直交非退化性を証明し、正種数での行列式固定のシンプレクティック性を導く。
- `M-early-unfolding` — §1.6で有限平坦な補助族と一般ファイバーの両比較写像を構成し、トレース形式の閉性を証明する。
- `M-strong-lift` — §§2.1–2.2で、全極と核格子に関する延長条件の下での存在と一意性、混合項を含む平坦性、およびトレース形式の保存を証明する。
- `M-coherent-export` — §§2.3–2.4で引戻しと表示の標準比較を構成し、その2同型の整合性と一般構成定理を証明する。
- `M-regular-RH-proper` — §§2.5–2.6で、基底線束によるテンソルを同一視した対数型関手Q_logとI13 Definition 4.3との同定、誘導された粗空間の比較、全点での強い分裂の半共役、族の固有性、および行列式固定のCartesian制限を証明する。適用側では§0.4の固有半共役定理から始域の完備性を得る。

### 一次文献と使用範囲

- **I23** — [Michi-aki Inaba, Moduli Space of Factorized Ramified Connections and Generalized Isomonodromic Deformation, SIGMA 19 (2023), 013](https://sigma-journal.com/2023/013/); [PDF](https://sigma-journal.com/2023/013/sigma23-013.pdf). §§2–5; §6 (6.9), Proposition 6.3; §7 Proposition 7.2, Theorem 7.5; §8 Theorem 8.1, Propositions 8.2–8.3; §10 Definition 10.1, (10.1), Propositions 10.7/10.10; §11 Definition 11.4, Theorem 11.6, Corollary 11.8.
- **I13** — [Michi-aki Inaba, Moduli of parabolic connections on a curve and Riemann–Hilbert correspondence, Journal of Algebraic Geometry 22 (2013), 407–480](https://arxiv.org/abs/math/0602004v2); [PDF](https://arxiv.org/pdf/math/0602004v2). Definitions 1.1, 2.2 and 4.3; Theorems 2.1–2.2; §§4, 6 and 8; regular-singular reconstruction and surjectivity.

目標2.5–2.6では、I13が明記する仮定の下で、対数型の対応、固有性、非空性を用いる。§2.4の一般構成定理には、I23の許容局所模型を用いる。

<a id="layer-3"></a>

## レイヤー3：パンルヴェ方程式の相空間と等モノドロミー変形

<a id="painleve"></a>

**概要。** 有理型接続のモジュライからパンルヴェ力学系を構成し、その水平切断からパンルヴェ関数を構成する。入力は、曲線、構造的極因子、行列式接続、局所的な形式的モジュライ条件、および安定性と標識のデータである。この入力から、相空間、そのシンプレクティック形式、および水平分布を構成する。すべての古典的スカラー方程式に先立って、共通の延長定理を置く。階数2の基礎となる10種類の形式的プロファイル、それらのラベル付き実現、8種類の加法型曲面、および6種類の古典的微分方程式は、いずれも比較結果として得る。理論の範囲には、共鳴パラメータ、許容される可約接続、分岐を伴う不確定特異点、特殊な不変部分、タウ切断とそのスカラー正規化を含める。係数の初等的な退化は、別個の境界比較で扱う。タウ切断のJMU・Hamiltonian比較には、目標6.4–6.5の一般的位置の条件を課す。行列式の構成は、6.2–6.3で指定する標識付きRHP族に適用する。

### 対象範囲

一般のFredholm行列式線束と標準切断は§6.1で構成する。§§6.3–6.4のトレース級作用素による実現には、RandomMatrices §8.3の行列式を、その作用素に関する仮定の下で用いる。

有理解と古典関数による解は、§§5.4–5.6と§§7.1–7.5の幾何学的簡約と変換から構成する明示的な族を扱う。目標7.3は係数境界の方程式を扱い、§1.6の有限平坦展開変形はシンプレクティック形式の閉性定理の一部をなす。

差分・q差分パンルヴェ力学系、離散系のSakai分類、クラスターによる実現、任意階数のwild非可換Hodge理論、代数的特殊解の完全分類、境界条件による漸近解析と接続定数、Hastings–McLeod解との同定、合流、およびGarnier系は対象外とする。

### 規約

ℂ上で考える。曲線は滑らかで連結な射影曲線とし、相異なる標識点からなる有限・非空の順序付き集合を備える。一般の階数は整数r ≥ 1とし、傾き安定性はこの正階数の範囲で定義する。分岐を伴う局所条件には、指定された形式的モデルの階数と局所次数に関する制約も課す。古典的部分圏では種数0、階数2とする。構造的極因子をP = Σ mᵢaᵢと書く。これは極の上限を与え、局所モジュライ問題を記録するものであり、個々の接続の実際に消えない極の因子とは異なる。局所条件が許す場合には、標識点での見かけの特異点やスカラー留数も許容する。§1.6の補助的な展開変形では、別途構成した有限平坦な因子を用いる。その特殊ファイバーが相異なる標識切断からなるとは限らない。

対象は、曲線全体上のベクトル束E、有理型接続∇: E → E ⊗ Ω¹(P)、その行列式接続と指定された線束接続との同型、および後述する局所構造からなる。関係する束の分解型はすべて保持する。一般の入力では有理型の行列式接続を許すが、古典的複雑度の部分圏では、留数を固定した確定特異な行列式接続と、動く曲線上でそれに適合する平行移動を用いる。行列式の次数は奇数でもよい。対数的な点では留数の固有値とそれに適合するフィルトレーションを指定し、共鳴パラメータではそれらと両立するすべての形式的同型類を含める。分岐を伴わない不確定特異点では、先頭項が相異なる一般的位置の形式的条件を用いる。分岐を伴う点では、分岐降下を備えた一般的位置の因子分解型分岐条件を用いる。非零であることを要求した先頭係数は、固定した不確定特異層の内部では非零に保つ。その消滅は入力の層を変える。§7.3では係数境界の方程式を比較する。

安定性重みをw、古典的スカラー係数をαと書く。指定した数値データについて半安定性と安定性が一致する、一般の安定性重みを用いる。安定性は∇不変な部分束に関する条件である。重みの部屋を変えることは壁越えの問題であり、補助的選択からの独立性ではない。同型は、行列式の同一視、ラベル、および指定した局所構造を保つ。剛化や粗モジュライ空間への移行に先立って、これらの射を保持する。行列式の同一視を固定した安定な階数2の対象では、残るスカラー群はμ₂であり、乗法群全体ではない。行列式を固定する操作と、この残余群を剛化する操作を区別する。

固定した外部の留数・指数パラメータをΘと書き、θ ∈ Θを固定したときの許容された標識付き時間底空間をBθと書く。相空間の族をπθ: Mθ → Bθと書く。固定パラメータと時間方向の区別は、変形問題の一部である。規約∇ = d + Aでは、対数留数λに対応するモノドロミー固有値はexp(−2πiλ)である。d − Aまたは指数θ = −λを用いる文献ではexp(2πiθ)となる。比較先を定めるファイバー積には、実際の対数パラメータを保持する。それらを忘れる写像は固有ではない。

水平分裂はh: π*TB → TMであり、dπ ∘ h = idを満たす。その像が不変に定まる力学系である。それをベクトル場として表すには、時間ベクトルの選択が必要になる。局所解は、初期点を指定した、ds(v) = h(v)を満たすπの正則切断sである。経路は、固定した許容底空間内の、コンパクトな区分的C¹経路とする。時間底空間は、選んだ解とは独立に固定する。

ハミルトニアン座標ではω = dq ∧ dpおよびι_Xω = d_phase Hを用いる。したがってq′ = H_p、p′ = −H_qである。拡張2形式はΩ = dq ∧ dp + dH ∧ dtであり、その核は∂t + Xを含む。τ = f(t)という時間変更の下では、正規化された水平生成子にdt/dτが掛かる。スカラーのハミルトニアンは局所的なものであり、時間だけの関数、または時間に依存するシンプレクティック座標変換の生成子により変化しうる。

「パンルヴェ関数」は、まず幾何学的な水平切断またはその芽を意味する。スカラー関数は、時間座標と正規化を指定した上で、許容される観測量を評価して得る。至る所で定義されたℙ¹への写像でも、恒等的に∞を値に取る場合がある。通常の有理型関数であるという結論からは、その場合を除く。普遍被覆上への延長と、B上の一価な対象への降下とは、異なる結論である。

### レイヤー間の依存関係

非線形接続、解、移送、観測量を一般理論として構成・証明する。許容された有理型接続のモジュライと強いモノドロミー保存接続を構成し、対数的Riemann–Hilbert比較を証明する。この構成を古典的入力へ制限し、形式プロファイルを分類する。古典的全クラスのRiemann–Hilbert比較とパンルヴェ性を証明してから、曲面、変換、Riccati簡約との比較を展開する。行列式線束とタウ切断を構成する。古典的スカラー方程式、Hamiltonian、sigma形式は、独立した座標比較の目標として導く。構成、延長、曲面幾何、タウ切断の目標は、古典的スカラー表示の比較を前提としない。

<a id="target-3-1"></a>
### 3.1 パンルヴェ方程式の付加構造付き接続

**パンルヴェへの適用。**

**入力条件**

- MeromorphicConnectionModuli 1.1 の対象、その射、行列式、および許容局所構造を用いる。

MeromorphicConnectionModuli §1.1 で構成する付加構造付き接続の圏を、同じ対象と射を用いて扱う。§3.3 の種数 0・階数 2 の制限に対する行列式・局所付加構造・重み・標識を記録する。パンルヴェの文献で用いられる局所表示を、フィルトレーション・対数格子・分岐降下を保って、この同じ対象と比較する。内在的な随伴・射影的構成には End⁰(E) と誘導された PGLᵣ 接続を用いる。これらの構成は、大域的平方根をもたない行列式も含め、許容されるすべての行列式に対して定義される。（I23, §§2–4.）

**構成・法則（API）**

- 対象・射・引戻しを MeromorphicConnectionModuli §1.1 のものと同定する。
- 古典的制限で用いる、奇数次数の行列式および共鳴・分岐表示との比較を構成する。

**検証事項**

- E = O ⊕ O(−1) の行列式の次数は奇数であり、大域的な行列式の半分による捻りは存在しない。この束の行列式が指定されたものに一致するとき、この束を対象として含める。
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

許容変形問題、座標変更の射、標識被覆、固定指数パラメータは MeromorphicConnectionModuli §1.2 を用いる。古典的部分圏では、留数を固定した確定特異な行列式接続が、その契約で必要な時間方向への持ち上げをもつことを確認する。この時間問題における種数 0 の局所切片と接写像を同定する。縮約された versal 変形問題を §3.3 の入力とし、その次元を §3.4 で証明する。強いモノドロミー保存では、座標変更に沿う移送によって解析データを比較する。不確定特異点の多項式表示は、その座標に応じて変わる。（HEU10, Theorem 1.1; I23, §§5, 11.）

**構成・法則（API）**

- 許容入力問題の各滑らかな表示 p:T→Θ 上で、相対時間接束 T_(T/Θ) と完全列 0→T_(T/Θ)→T_T→p*T_Θ→0 を構成する。固定指数のファイバー Bθ について T_(T/Θ)|_(Bθ) を T_(Bθ) と同定し、他の許容基底変換は実際の接写像を通じて比較する。表示変更の微分がこの完全列を保つことを証明する。直和分解を用いるときは局所直積表示を選び、分裂の変換則を明示する。
- 古典的制限に必要な行列式の持ち上げと、種数 0 の座標変更の整合性を確認する。

**検証事項**

- 順序付きの四つの対数点は PGL₂ で割ると一つのモジュラスをもつ：4 − 3 = 1。その複比は 0、1、∞ を避ける。
- τ = 2t という変換は、表示された水平生成元を 1/2 倍する。その係数を変えずに保持すると、異なるパラメータ付き系になる。
- 可動極集合が異なる二つの解も同じ Bθ を用いる。一つの解の極を削除した基底は、この要件を満たさない。
- t′=t+θ、θ′=θ と変換すると、相対時間接線は変わらないが、t を固定した ∂_θ は、t′ を固定した ∂_(θ′) と ∂_(t′) の和になる。時間方向の補空間は、選んだ直積座標に付随する。

*必要な先行結果：* 内部依存：3.1, 1.2.

<a id="target-3-3"></a>
### 3.3 階数 2・次数 4 の部分圏

**パンルヴェへの適用。**

**入力条件**

- 種数0、階数2、構造的次数4、適合する留数を固定した確定特異な行列式接続、縮約されたversal時間変形問題、および非空な安定ファイバーを入力条件とする。

古典的な微分 Painlevé 系の入力クラスを、種数 0、階数 2、次数 4 の構造的極因子、§3.1 の局所モジュライ条件、固定留数と両立する移送を備えた確定特異行列式接続、§3.2 の形式データの縮約された versal（完備）変形、および空でない安定ファイバーによって定義する。種数 0 では、∇ = d + A に対する規約により、行列式の留数は「その和 = −次数」を満たす。縮約された versal 変形全体を時間問題とする。定値の曲線や versal 性を満たさない曲線に沿う制限は、この条件を満たさない。非空性はモジュライ問題の定義域を制限する条件である。対象はこれらの条件を満たす接続データとする。縮約された時間の次元は相空間の次元計算とは独立に §3.4 で導き、延長可能性は §4.6 で導く。（VDPS09, §2.2 and Table 1; I23, Theorem 7.5.）

極次数の総量を比較する際の r は、トレース零の指数差から計算され、スカラー捻りで不変な射影的 Katz 不変量である。確定特異な行列式への正規化により、時間問題にはスカラー不確定方向がない。不確定特異な階数 1 の接続による捻りには強い時間持上げの指定が必要であり、この古典的入力クラスとその一次元変形の数え上げの範囲外とする。これらの局所的・形式的比較は、大域的平方根をもたない行列式線束にも適用される。

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

- §3.3 の入力に、許容された一般的位置の射影的局所型、極のラベル、および縮約された形式データの変形問題を備える。以下の分類で、プロファイルの個数、自己同型の固定部分群、および縮約された時間の次元を決定する。

先頭項の非退化性と縮約された変形に関する仮定を保持し、構造的次数 4 の許容される階数 2 の形式的プロファイルを分類する。まず極のラベルの順序を忘れた基礎プロファイルを分類する。すなわち、4 の分割と、各不確定部分における整数または半整数の一般的局所傾きを列挙する。これにより十個の基礎プロファイルが得られる。ラベル付与の亜群を通じて、元の順序付き入力を復元する。置換はラベル付き表示の間の添字付け替えによる同値を誘導するが、元の亜群におけるラベルを保存する射ではない。順序付き傾きプロファイルは十七個あり、極の数が一、二、三、四の場合の個数はそれぞれ 2、8、6、1 である。これに対応する順序を忘れた個数は 2、5、2、1 である。これは形式的プロファイルの形の個数であって、連続的な指数パラメータを備えた対象の個数ではない。

ラベルを保存する許容された曲線座標変換で割った後、どのラベル付き実現も本質的な時間パラメータを一つもつことを証明する。極が n 個の表示における次元計算は n + Σ⌈rᵢ⌉ − 3 = Σmᵢ − 3 = 1 であり、自己同型の固定部分群と、選択した標識・スライスを明示的に確認する。行列式の正規化とその移送は、必要な射影的方向を取り除かず、スカラー不確定方向も加えない。十個すべての基礎表示とすべてのラベル付与について、この行列式の正規化が可能であることを証明する。§7.2 の表は基礎プロファイルの表であり、その座標公式はラベルの添字付け替えによる同値に沿って移送する。（VDPS09, §2.2, Table 1, printed pp.18–19.）

指定した標識と正規化ごとに、対応する時間領域を構成する。具体的には、四点の複比基底、非零の不確定時間のチャート、またはアフィン時間のチャートである。これらが縮約された時間問題のチャートまたは標識被覆であることを証明する。分類の対象は、§3.3 で指定した階数 2 の形式的複雑度とする。

**検証事項**

- 順序付き組 (1,0,0) と (0,1,0) に対応する極次数は (2,1,1) と (1,2,1) である。基礎プロファイルは同じであるが、ラベルを保存する射によっては同一視されない。
- 4 の順序付き分割を、部分 1 に一つ、それより大きい各部分に二つの局所型を割り当てて列挙すると、2 + 8 + 6 + 1 = 17 になる。順序を忘れると 2 + 5 + 2 + 1 = 10 になる。
- ラベルの置換は極次数の総量と時間の次元を保存するが、留数パラメータと複比チャートを移送する。表示されたすべての座標をそのままにするわけではない。

*必要な先行結果：* 内部依存：3.1, 3.2, 3.3; [Formal scalar and vector-valued Laurent algebra](#dependency-formal-series) (L1–L4; L5–L6 for finite-extension steps in 1.1).

#### 例

傾き 5/2 の分岐を伴う極が一つの場合、構造的次数は 4 であり、三つの不確定係数は二次元アフィン座標群で割ることで一つの本質的時間に縮約される。傾き 1 の不分岐な極が二つの場合には、不確定係数が二つ、残るスカラー倍が一つあり、やはり一つの時間が残る。これらはスカラー Painlevé 方程式を一つでも導入する前の、入力型に関する計算である。

<a id="target-3-5"></a>
### 3.5 パンルヴェ方程式の安定モジュライ

**パンルヴェへの適用。**

**入力条件**

- 古典的入力 3.3 と MeromorphicConnectionModuli §1.3 の一般の安定モジュライ構成を用いる。

§3.3 に MeromorphicConnectionModuli §1.3 を適用する。行列式・安定性・局所モデルの許容条件を古典的入力について確認し、その出力を古典的な全安定モジュライ問題と同定する。有界性は一般構成から得る。スタック、剛化、粗モジュライ族、普遍対象をもつエタール被覆は、一般構成から得られたものを用いる。許容されるすべての束の型と、剛化前の実際の μ₂ 固定部分群を保持する。balanced な部分を含め、各古典的枠付きチャートとその局所閉像または開像との比較を構成し、全モジュライ空間における各像の補集合を指定する。（I23, Theorem 5.1.）

**構成・法則（API）**

- 射と行列式の同定を含め、古典的モジュライ関手を一般関手の制限と同定する。
- 各枠付きチャートの包含・補集合・重みの部屋に共通する安定部分を確認する。

**検証事項**

- 安定対象にも、剛化前にはスカラー自己同型がありうる。集合値の粗商はこれらの射を忘れ、その存在から固定部分群が自明であることは従わない。
- 束の跳躍により、族が自明束のチャートから外れても、モジュライ空間内にはとどまりうる。束の跳躍だけでは、その相軌道は特異にならない。
- 拡大族 0 → O(−1) → E_t → O(1) → 0 では、E₀ = O(−1) ⊕ O(1) である一方、t ≠ 0 では E_t = O ⊕ O である。二つの分裂型の層の引戻しは A¹ 内の {0} とその補集合であり、前者は開ではない。接続モジュライ全体は、許容される接続の範囲でこのような束の跳躍を保持しなければならない。
- 一般的な分岐局所因子は既約であるため、大域接続には ∇-不変直線部分束が存在せず、どの重みに対しても安定である（I23 Remark 2.9）。この判定は不変部分束に関するものであり、特殊解を分類するものではない。

*必要な先行結果：* 内部依存：3.3, 1.3.

<a id="target-3-6"></a>
### 3.6 変形複体とトレースペアリング

**パンルヴェへの適用。**

**入力条件**

- §3.5 の族と、その行列式および局所構造を用いる。

MeromorphicConnectionModuli §1.4 を、§3.5 の行列式を固定した族へ特殊化する。古典的な無限小の族とゲージが、そのコサイクルとコバウンダリーに対応することを証明する。分岐を伴う三項錐複体全体と、ℂ 線形微分作用素・Čech 構成を用いる。交換子微分は一般には O 線形でない。より短い表示を用いる場合は、指定した擬同型によって錐複体全体と比較する。同じ複体上で行列式制限とトレースの符号規約を確認する。（I23, equation (6.9), Propositions 6.3 and 7.2.）

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

- §§3.5–3.6 の古典的族と変形複体、および一般変形構成との比較を用いる。

§§3.5–3.6 で同定した族と複体に MeromorphicConnectionModuli §§1.5–1.6 を適用する。行列式ファイバーとの比較を確認する。種数 0 では Jacobian の次元は零である。一般定理に g = 0、r = 2、deg P = 4 を代入して滑らかさと相対次元 2 を導き、トレース形式の非退化性と相対閉性を導く。一般のシンプレクティック構成に含まれる補助的有限平坦展開変形、単純接続モジュライ、一般部分での二つの対数的擬同型、および滑らかな族での稠密性の議論を用いる。その中心安定ファイバー・複体・形式を、許容される非被約基底変換と両立する形で古典的族と同定する。（I23, Theorems 7.5 and 8.1, Propositions 8.2–8.3.）

**構成・法則（API）**

- 一般定理の特殊化に必要な、行列式固定と中心ファイバーの比較を確認する。
- 同じ相対接束とシンプレクティック形式を古典的族全体に提供する。

**検証事項**

- 種数 0、階数 2、次数 4 では −8 + 2 + 8 = 2 となり、構造的次数を 5 に変えると 4 になる。
- 正の種数で行列式を固定すると、行列式写像との比較を適用できる場合には 2g 個の方向が除かれる。種数 0 での一致をそのまま一般の場合に持ち出さない。
- 恒等的に消える交代ペアリングは閉じているが、シンプレクティックではない。非退化性は実際の双対性計算から導かなければならない。
- r = 1、g = 1 では、行列式を固定しない公式は 2 を与え、線束上の接続全体を固定すると 0 になる。誤って 2 を与えてしまう階数 0 の入力は、定義域の外にある。
- r = 2、局所次数 2、q₁ = 2 の場合、展開変形の方程式は (z − 2h²)(z − h²) である。h = 0 でのファイバーは z²、h = 1 では (z − 2)(z − 1) であり、h² を法として考えると再び z² になる。固定された互いに異なる切断では、中心ファイバーが異なる。この展開変形の中心ファイバーと指定した引戻しについて、複体と形式を確認する。

*必要な先行結果：* 内部依存：3.3, 3.5, 3.6, 1.5, 1.6.

<a id="target-3-8"></a>
### 3.8 相空間の例外層

**パンルヴェへの適用。**

**入力条件**

- §3.5 の安定モジュライ全体、許容された階数2の局所条件と外部指数パラメータ空間 Θ、および §2.5 の対数的局所比較を用いる。名前を付ける各部分の非空性は別の主張とする。

以下の添字付き部分対象族と相空間族 M への包含、およびその引戻しとの両立性を構成する。これらの部分は交わりをもちうるものとし、以下の主張では各部分に平坦性の条件を課さない。

各対数的標点 a_i と各 n∈ℤ について、λ_(i,0)−λ_(i,1)=n で共鳴超平面 Res_(i,n)⊂Θ を定義する。n=0 も含め、その相空間内の部分を M→Θ による引戻しで定める。整数 n を各共鳴部分の添字として保持し、この ℤ 添字付き部分族とその相空間への引戻しを用いる。留数が一致するときに放物旗が保持するデータを記述する。

不変直線の入射モジュライ 𝓘_red を、安定な付加構造付き接続と、飽和した ∇ 不変な階数1部分束 L⊂E の組として定義する。族では L と E/L は局所自由とする。安定スタックおよび相空間族への忘却写像を構成する。幾何学的ファイバー M_b 上の Red(M_b) はこの写像の像で定め、すべての幾何学的ファイバーが Red(M_b) に属することを条件として h_M の可約族部分関手を定義する。入射関手には相対不変直線の選択を含め、可約族部分関手には各ファイバーでの存在条件だけを課す。入射モジュライ、忘却写像、ファイバーごとの可約性条件について引戻しとの両立性を証明する。

対数的標点では、アフィン指標商を取る前の実際の局所モノドロミー T_i を §2.5 から用いる。T_i=I で App_i^lin⊂M^an を、PGL₂ 内の [T_i]=1 で App_i^proj⊂M^an を定義する。普遍対象のチャート上でこれらの解析的部分対象を構成し、共役と代表の変更に関して方程式を降下させ、許容解析的基底変換との両立性を証明する。前者を通常の意味の見かけの特異点、後者を射影的な見かけの特異点の規約とする。選んだ cyclic vector によるスカラー化が標点因子の外に作る見かけの極は、§7.2 が構成する表示データであり、ここで定義する固定標点の部分とは別である。

局所条件が許すすべての点が安定モジュライ全体に保持されることを証明し、各非空性主張の仮定を記録する。許容された全分岐の一般的局所模型を持つ場合、形式的既約性定理により Red(M_b) は空になる。目標4.1–4.4では、ここで定義した部分対象の像を対応する Betti 条件と比較する。不確定部分の先頭係数の消滅は許容入力を変えるので、§7.3 の係数境界の比較で扱う。（I23, §2 and Remark 2.9; IIS06, §4, especially Theorems 4.10–4.12; VDPS09, §2.2, §3 and §4.2.）

**構成・法則（API）**

- 添字付きの各共鳴部分を引戻しとして構成し、その包含と基底変換の等式を与える。
- 𝓘_red とその忘却写像を構成し、幾何学的点での像を可約性と同定する。ファイバーごとの可約族部分関手は別に与える。
- 指定した局所モノドロミー方程式で App_i^lin と App_i^proj を構成し、包含 App_i^lin⊂App_i^proj、解析的降下、基底変換との比較を証明する。
- 後続の像や不変曲線の比較では、各部分の局所条件と非空性の仮定を保持する。

**検証事項**

- 局所接続 d+(1/2)I dz/z のモノドロミーは −I であり、App_i^proj に属するが App_i^lin には属さない。粗い局所指標が恒等行列の指標と一致しても、定義に用いる行列方程式 T_i=I は従わない。
- 重複固有値を持つ対数留数でも、非自明なユニポテントモノドロミーを持ちうる。したがって、共鳴だけではいずれの見かけの特異点の部分にも入らない。
- 一般的位置の全分岐形式模型には不変な階数1部分加群がないため、その大域的な可約入射モジュライは空である。

*必要な先行結果：* 内部依存：2.5, 3.1, 3.5, 3.6, 3.7.

#### 例

種数 0・階数 2 では、次元計算は −8 + 2 + 2·4 = 2 となる。相空間のアフィンチャートには座標 (q,p) があるが、そのチャートから欠けている点も正当な初期条件である。共鳴因子上では、異なる放物的初期点が同じ粗モノドロミー指標をもちうる。相空間はそれらを保持しなければならない。

<a id="target-3-9"></a>
### 3.9 パンルヴェ方程式の等モノドロミー接続

**パンルヴェへの適用。**

**入力条件**

- 構成済みの古典的モジュライ・時間問題を用いる。その局所構造と行列式の移送が、強い拡張の契約を満たすことを確認する。

§3.2 の時間問題と §3.5 の族に、§§3.6–3.7 の比較を用いて MeromorphicConnectionModuli §2.1 を適用する。核格子・対数的旗・分岐降下を含め、一般構成の強い拡張を古典的な普遍対象のチャートと同定する。全空間での極のクラスは Ω¹_X(log D) ⊗ O_X(P − D) である。対数極での時間係数の正則性も含め、動く座標での生成元 dz/zᵐ と dε/zᵐ⁻¹ との比較を証明する。強い拡張の存在・一意性・貼合せの定理を特殊化し、それらが誘導する NonlinearConnections §0.1 の意味での接分裂として h を構成する。（I23, Definition 10.1, Propositions 10.7 and 10.10.）

**構成・法則（API）**

- 古典的な核格子と動く極のフィルトレーションを、一般の強い拡張クラスと比較する。
- 得られる分裂を §0.1 の非線形接続と同定し、その線形性および一般の基底変換写像との両立性を証明する。

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

MeromorphicConnectionModuli §2.2 と §3.9 の同定により、古典的族上で h([v,w]) = [h(v),h(w)] を得る。二パラメータの強い拡張の比較が、この時間問題へ制限できることを確認する。この制限により、代数的な強い拡張の構成から、許容された各形式プロファイルの括弧恒等式を得る。（I23, Theorem 11.6.）

**構成・法則（API）**

- 混合拡張の制限比較を確認し、括弧恒等式を提供する。

*必要な先行結果：* 内部依存：3.9, 2.2.

<a id="target-3-11"></a>
### 3.11 シンプレクティック移送と全二形式

**パンルヴェへの適用。**

**入力条件**

- §§3.7, 3.9 の相対形式と分裂、§3.10 の平坦性、およびモジュライのシンプレクティック保存定理との比較を用いる。

MeromorphicConnectionModuli §2.2 のシンプレクティック保存定理を古典的族へ特殊化する。この保存恒等式と §3.10 の平坦性の下で (π,h,ω) に NonlinearConnections §0.6 を適用し、閉じた全二形式 Ω(v,w) = ω(v − h(dπv), w − h(dπw))、その核と移送の法則を得る。その垂直方向への制限を相対トレース形式と同定する。十分小さな局所 Darboux・時間チャートを選び、必要な局所完全性を証明して、座標表示 dq ∧ dp + dH ∧ dt を導く。（I23, Definition 11.4 and Corollary 11.8.）

**構成・法則（API）**

- §3.7 の相対形式、§0.6 の全形式、および後者の水平核を同定する。
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

MeromorphicConnectionModuli §§2.3–2.4 を用い、目標3.1–3.12の対象を、一つの一般構成の古典的制限として同定する。表示・ゲージ・許容基底変換の比較を整合的に保持する。古典的な標識と時間切片についてコサイクル図式を確認する。ラベル・行列式・安定性の部屋の変更には、指定した定義域上の許容される射または対応を用いる。§7.2 の座標比較と、これらの幾何学的比較写像との可換性を証明する。

**構成・法則（API）**

- 古典的特殊化の可換図式と三重重なりの整合性を証明する。
- 取り込んだ構造を一つのモジュライ族と一つの非線形接続上に保持する。

*必要な先行結果：* 内部依存：3.1, 3.2, 3.5, 3.9, 3.10, 3.11, 2.3, 2.4.

#### 例

Hamilton チャート H = p²/2 − 2q³ − tq は水平核を表すが、核はこの公式なしに構成する。H を H + c(t) に置き換えても核は保たれる。標識の変更はパラメータ付きの族に作用するのであって、入力亜群から標識を消すものではない。

<a id="layer-4"></a>

## レイヤー4：Riemann–Hilbert 比較とパンルヴェ性

<a id="target-4-1"></a>
### 4.1 扇形局所系と分岐を伴う解析的降下

**パンルヴェへの適用。**

**入力条件**

- 許容された階数2の良い形式型、共鳴する対数的格子のデータ、および有限分岐被覆と被覆変換の作用を入力とする。

共鳴する対数格子と旗を保持し、形式的次数付きデータ、扇形解、Stokes 遷移写像による、許容された局所有理型接続の解析的分類を構成する。扇形上の存在、重なり上の一意性、コサイクル恒等式、許容される時間パラメータへの解析的依存性を証明する。分岐点では有限被覆上で構成を行い、指数因子に対する被覆変換による置換も含め、同変な降下を証明する。形式的分類によって漸近型を指定し、扇形上の存在・一意性定理によってその解析的実現を構成する。（I23, §9, Theorem 9.7 and Corollary 9.11; BOA01, §§3–6; HEU10, §2; BY15, Remark 3 and Definitions 7 and 13.）

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

- §3.2 の許容された標識付き時間変形問題上の §4.1 の局所解析データ、保持された指数の持上げ、および固定された閉じたスペクトル・行列式条件を入力とする。特異なアフィン商も許す。

確定特異な部分圏では MeromorphicConnectionModuli §2.5 を用い、その標識付き Betti 族がこの目標の族と一致することを確認する。不確定特異点や分岐を伴う Betti 族とその移送を、以下の貼合せと降下によって構成する。

§4.1 の局所データを穴あき曲線上の大域的局所系と貼り合わせて、一般化モノドロミー亜群を構成する。対数格子と旗を備えた付加構造付き亜群と、それらの付加構造を忘れて得られる通常のアフィン指標商を区別する。通常の商には、スペクトル不変量と行列式に関する閉条件を課し、指数パラメータ θ をファイバー積の別の座標として保持する。共鳴時には、指定されたスペクトルの閉条件を満たす部分全体を用い、スカラーの層と許容される冪単の層をともに含める。Stokes 扇形表示の変更も含め、許容される標識付き変形に沿って局所定常な移送を構成する。合成と逆の法則、および Bθ 内のすべてのコンパクトな道に沿う完備性を証明する。この亜群・位相的構成により、特異な指標ファイバー上でも移送を定義する。（VDPS09, §§1–3; BOA14, §10, Theorem 10.2; BY15, Proposition 19, Theorem 21 and Corollary 22.）

引用した BOA14 の族の移送定理は、捻りのない場合を対象とする。その同位変形の構成を、BY15 の階数 2 の分岐を伴う対象に拡張する。その際、指数被覆、次数付け、被覆変換の作用を保持し、Stokes 亜群の間に被覆変換と両立する同値を構成し、フレーム付けの作用と閉じたスペクトル条件を降下させる。コンパクトな道に沿って局所積を連結する前に、独立性、合成との両立性、ホモトピーとの両立性を証明する。分岐局所対象と準 Hamilton・Poisson 商の幾何には BY15 を用い、族の移送との比較は上記の相対イソトピーによって証明する。

**構成・法則（API）**

- 制限、貼合せ、ゲージ共役、標識変更の関手を構成する。
- 付加構造付き Betti 亜群から通常の表現・Stokes 亜群への忘却関手 Forθ を構成する。対数格子と旗を忘れ、指定された形式的次数付け、Stokes 写像、被覆変換作用を保持する。この通常の亜群から、閉条件を備えたアフィン指標商 Rθ への写像 qθ を構成し、βθ = qθ ∘ Forθ と定める。通常のフレーム付き表現空間における商の普遍性を証明し、商の点が個々の軌道を表す部分を特定する。
- Forθ、qθ、βθ が移送と標識変更に可換であることを、亜群の段階での自然同型を保持して証明する。
- 単連結な許容時間近傍上での局所積表示と、有限個の近傍の鎖に沿うその延長を証明する。
- 粗商上の完備な移送と、必要な付加構造空間上へのその持上げを定義する。

**検証事項**

- θ と θ + 1 は同じ指数化された固有値を与えるが、同じ対数格子を与えるとは限らない。比較先には θ を保持する。
- 可約表現とその半単純化は、同じ粗指標をもちうる。また、スカラーの局所モノドロミー上で異なる旗を選ぶと、異なる付加構造付き対象が同じ通常の指標をもちうる。前者は商の形成、後者は Forθ による、それぞれ別の情報の喪失である。
- 非自明なループに沿う移送は、ファイバーに非自明に作用しうる。完備性はモノドロミーが自明であることを意味しない。

**本目標が担う補助構成。**

- 有限型表現多様体、§1.3 の不変式論による簡約群のアフィン共役商、および §1.2 によるその解析化には §2.5 を用い、特異点での Hausdorff 性・局所コンパクト性・標識付き積移送も受け取る。wild/Stokes のフレーム亜群と商を構成する。簡約なフレーム群を用いる段階では簡約群の不変式論を適用し、他の商の段階は局所的な冪単 Stokes 群を保持した明示的降下によって構成する。根・被覆変換を保つイソトピー、分岐降下、安定化群との両立性、および許容される各層上の正則性を証明する。構成した商の普遍性を SSF1.17 の述語で表す。

*必要な先行結果：* 内部依存：3.2, 4.1, 1.3, 1.2, 2.5; [Quotient predicates](#dependency-quotient-predicates) (1.17); [Covering spaces and universal covers](#dependency-covers) (Stage 0.2–0.4; Stage 1.5; Stage 2.6–2.8); [Smooth bundle and connection foundations](#dependency-smooth) (B1.5; B5.0; B5.2).

<a id="target-4-3"></a>
### 4.3 相空間全体上での Riemann–Hilbert 対応と両立性

**パンルヴェへの適用。**

**入力条件**

- §3.5 の安定モジュライ族全体と §3.8 の各部分、§§3.9–3.10 の分裂と平坦性、§3.12 の表示変更・基底変換の比較、および §§4.1–4.2 の付加構造付き解析的再構成と Betti 族を入力とする。

確定特異な RH 写像と全点での水平両立性には、同じ放物的モジュライと留数パラメータを保持した標的を同定した後に、MeromorphicConnectionModuli §2.5 を用いる。不確定特異点をもつプロファイルには、§4.1 の復元と以下の降下・比較を用いる。

普遍対象をもつ被覆上で、付加構造付き解析的分類と §4.2 の βθ を合成して Bθ 上の RHθ: Mθᵃⁿ → Rθ を構成し、正則な降下を証明する。§3.8 で定義する共鳴・可約・標識点の見かけの特異性の各部分に含まれる軌道も含め、§3.9 のすべての水平軌道を §4.2 の移送に送ることを証明する。可積分拡張の構成と局所解析的復元を比較する。

許容された各プロファイルについて逆写像の定義域を固定する。四つの対数極をもつプロファイルでは、各 b ∈ Bθ における指標曲面 Rθ,b の滑らかな部分の合併を Vθ とし、Uθ = RHθ⁻¹(Vθ) と定める。IIS06 Definition 4.9 の設定との行列式・標識の比較を証明し、これらの部分上で Theorem 4.10 を適用する。共鳴する指数ファイバー上でも、滑らかな指標点は Vθ に含める。それ以外の各プロファイルでは、一般化モノドロミー対象が既約で、すべての対数極において指数差が λᵢ,₁ − λᵢ,₂ ∉ ℤ を満たす通常の指標の部分を Vθ と定める。ここで既約とは、大域モノドロミー、形式的次数付け、すべての Stokes 写像、被覆変換作用と両立する共通の階数 1 部分対象が存在しないことをいう。Uθ は、同じ指数条件を満たし、飽和した ∇ 不変の直線部分束をもたない接続の部分とする。不分岐不確定特異点での相異なる先頭固有値と、分岐点での a₁₀ ≠ 0 という許容条件を保持する。対数極の指数差が整数となる指数ファイバーでは、四対数極型以外についてここで選んだ逆写像の定義域は空になる。

後者のプロファイルでは、非共鳴な指数の持上げから対数格子とラベル付き旗を、ラベル付き形式的直和成分から不分岐不確定特異点の格子とフィルトレーションを、指定された w² = z のモデルと被覆変換による降下から分岐点の格子と因子分解構造の同値類を、それぞれ局所的に一意に復元できることを証明する。これらの復元が許容パラメータに正則に依存し、貼合せによって所定の行列式と次数をもつ安定接続を与えることを証明する。これにより Uθ = RHθ⁻¹(Vθ) を示し、RHθ|Uθ ∘ jθ = id および jθ ∘ RHθ|Uθ = id を満たす正則な逆写像 jθ: Vθ → Uθ を構成する。二種類の定義域の選択のそれぞれについて、この二つの恒等式と許容基底変換・標識変更との両立性を証明する。四対数極型以外の逆写像の定義域は、上記の既約性・非共鳴条件で指定した部分とする。Uθ の外では、実際のファイバーと付加構造のデータを保持する。（IIS06, Definition 4.9 and Theorems 4.10–4.12; IS12, Theorem 5.1 は一般的な不分岐の場合の範囲で用いる; I23, Proposition 3.3, Corollaries 4.3–4.4, §9 and §11。族としての分岐再構成と降下を、この比較の一部として構成する。）

§4.1 と §3.5 の普遍対象チャートを用い、許容されるすべての層上で写像・降下・水平性との比較を構成する。一般的な不分岐部分の比較には IS12 Theorem 5.1 を用い、共鳴・分岐部分の比較は、上記の可積分拡張と解析的復元の写像を通じて証明する。

**構成・法則（API）**

- 普遍対象をもつ被覆から正則な RH 写像を構成し、降下と基底変換に関する自然性を証明する。
- 局所から大域への RH の構成を、§4.2 の Forθ と qθ を通る合成と同定する。
- 明示的に定義した開部分 Uθ、Vθ と逆写像 jθ を構成し、両側の逆写像の恒等式、および基底変換・標識変更に関する自然性を証明する。
- Uθ に属するかどうかによらず、保持されたすべての点で水平性との両立を証明する。

**検証事項**

- 例外ファイバー上の異なる二点が同じ通常の指標をもちうるため、そのファイバー上では両側の逆写像を定義できない。
- 共鳴する対数点では、始域は許容されるスカラーの層と冪単の層の両方を含む。四対数極型の Vθ は、共鳴するパラメータファイバー上の滑らかな指標点を含む。
- 指数の持上げを保持することで、通常の指数化された固有値が等しくても θ と θ + 1 を区別する。

*必要な先行結果：* 内部依存：3.5, 3.8, 3.9, 3.10, 3.12, 4.1, 4.2, 1.2, 2.5.

<a id="target-4-4"></a>
### 4.4 古典的入力クラス全体に対する固有な比較

**パンルヴェへの適用。**

**入力条件**

- 指数の持上げと閉じた指標条件を保持した、許容される古典的時間・パラメータ族全体に対して §4.3 で構成した RH 写像、および許容される安定な始域のすべての層を入力とする。

四つの対数極の分岐では、2·4 − 2·2 − 2 = 2 > 0 と行列式固定・標識の比較を確認し、MeromorphicConnectionModuli §2.6（I13, Theorem 2.2）を適用する。この文献はファイバー積によって指数パラメータを保持する。不確定特異点をもつプロファイルでは、以下の格子の有界性と延長の結果を用いて相対固有性を証明する。

許容された次数 4・階数 2 の各入力と、許容されるすべての指数パラメータについて、§3.5 の安定モジュライ空間全体上で、比較先に指数の持上げを保持した RHθ が、時間族全体の写像として固有であることを証明する。各許容パラメータチャート上で、時間がその基底全体を動く全空間の写像の固有性を証明する。入力の許容条件、非空性、重みの chamber 条件は §§3.3・3.5 のものを用いる。Rθᵃᵈᵐ := Rθ を、§4.2 で構成した通常の一般化指標商の全体として定義する。その定義データは、対数極での局所特性多項式条件、不確定特異点で指定された形式的次数付けと形式モノドロミー、許容される Stokes 因子と被覆変換の関係式、大域的な積の関係式、および固定された行列式指標であり、指数の持上げを保持する。これらの条件は RH とその像から独立である。固有性とは別に、すべての b ∈ Bθ と r ∈ Rθ,b に対して RHθ(m) = r を満たす m ∈ Mθ,bᵃⁿ が存在することを証明する。このように独立に定義された標的のすべての成分上で、この存在主張を証明する。対数点でのスカラー・冪単の各層、可約な指標、および古典的入力が許容する一般的な分岐局所構造を含める。（IIS06, Definition 2.11 and Theorems 4.10–4.12; IS12, Theorem 5.1 and the scope warning of Remark 6.3; HEU10, Theorem 1.1.）

次の四つの中間結果を通じて相対コンパクト性を証明する：指数の持上げを固定した一般化指標のコンパクトな族にわたる、局所格子の一様有界性；閉じた入射条件をもつ相対射影パラメータ空間内での、保持された旗と因子分解構造の拡張；必要な基底変換と基本変換の後の半安定なものへの置換、それに続く選択した重みに対する半安定 = 安定、および分離的モジュライ問題における一意性；これらの拡張と大域的貼合せおよび解析的モジュライ位相との両立性。安定な族が退化するとき、置換の段階で安定な極限対象を構成する。安定部分の開性だけではこの存在は保証されない。指標族の各コンパクト部分 K に対し、台となる接続と付加構造のパラメータの両方を制御して RHθ⁻¹(K) のコンパクト性を証明する。

全射性については、許容された通常の指標の局所実現を構成し、指定された次数と行列式をもつ束上に貼り合わせ、安定な付加構造付き代表が存在することを証明する。可約な粗指標では、同じ粗指標をもつ非半単純な対象からその代表が得られる場合を含め、半単純な代表が安定であるとは仮定しない。安定な対象への置換が指定された指標と固定局所条件をすべて保つことを確認する。これらの存在主張を、コンパクト性の議論とは独立に、指定された各指標について証明する。

固有性は、上記の相対コンパクト性の議論によって証明する。HEU10 Theorem 1.1 は普遍的な強いモノドロミー保存変形を扱う。その古典的な延長への適用には、時間基底の比較、局所付加構造の延長、行列式と安定性の保存、束の跳躍との両立性、降下、および §3.9 との一致が必要である。I23 の大域的葉層構造の定理はそのモジュライの仮定の下で幾何学的な時間分布を与え、IS12 Theorem 5.1 は一般的な不分岐部分の RH 定理を与える。これらの文献の適用範囲と、本項で証明する全古典的入力に対する相対コンパクト性の主張を区別する。

*必要な先行結果：* 内部依存：3.5, 3.6, 3.7, 3.8, 4.1, 4.2, 4.3, 1.3, 2.6; [Quot/Hilbert and parameter schemes](#dependency-quot) (4.14); [Native topological properness](#dependency-proper) (IsProperMap).

#### 例

例外的 RH ファイバーは射影曲線でありうる。その上で選んだ一点も初期条件であり、それ自身の水平持上げをもつ。粗 RH 写像の逆を任意に取ると、この情報が失われる。自明束のチャートでは、孤立した時刻で強い Riemann–Hilbert 問題が解けなくなっても、束上の接続全体としては延長できることがある。

<a id="target-4-5"></a>
### 4.5 正則水平切断の局所存在

**パンルヴェへの適用。**

**入力条件**

- §§3.9–3.10 の正則平坦分裂と、その許容パラメータ・チャートを用いる。

幾何学的パンルヴェ芽を、§§3.9–3.10 の正則平坦分裂に対する、初期点を指定した NonlinearConnections §0.3 の意味での水平切断の芽とする。許容された古典的パラメータ・チャート上で同時正則性の仮定を確認し、§0.3 を適用して評価の全単射、局所存在・一意性、およびパラメータへの正則依存性を得る。

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

- §4.3 の古典的 RH 比較、§4.2 の完備な標的移送、始域のすべての点における部分水平持上げとの両立性、および §4.4 の固有性を用いる。

相空間族に NonlinearConnections §0.4 を適用し、その基礎となる §0.2 の連続時間の局所 ODE とコンパクト延長の定理を用いる。§4.2 の完備な標的移送、§4.3 の許容されるすべての点での部分水平持ち上げとの両立性、§4.4 の相対固有写像を確認する。任意の許容 θ、初期時刻 b₀、点 x₀ ∈ Mθ,b₀、および b₀ から始まる Bθ 内のコンパクトな区分的 C¹ 経路に対し、一意な水平持ち上げを得る。標的は特異でもよく、例外ファイバーとその初期点を保持する。コンパクト集合内への閉じ込めに用いる固有写像は RHθ であり、相空間の射影 π は固有でなくてもよい。これらの仮定を確認して §0.4 のコンパクト閉じ込め定理を特殊化し、幾何学的パンルヴェ性を得る。基底 Bθ は入力データによって固定され、スカラー観測量の極には依存しない。

**構成・法則（API）**

- 例外ファイバーを含め、一般の固有移送定理の仮定を確認する。
- どのスカラーチャートからも独立に、すべての初期点とコンパクト経路についての結論を提供する。

**検証事項**

- y′ = y², y(0) = 1 に対して、M = ℂ_t × ℂ_y から完備な標的の時間直線への射影は整合的だが固有ではない。t ∈ [0,1) に沿って y = 1/(1 − t) であり、t = 1/2 と 3/4 での値はそれぞれ 2 と 4 だが、1 では有限値を持たない。したがって、F の固有性を単なる連続性や射影との整合性で置き換えることはできない。
- 自明な族上で F が恒等写像であり、ファイバー上の平行移動が定値である場合、固有写像による移行は一意な定数ファイバー座標を与える。例外曲線を持つ固有ファイバーの場合、コンパクト集合内への閉じ込めの議論はそのコンパクトな逆像を用い、F の逆写像を選ぶことはない。
- [0,1] 上の底空間の道 γ(s) = |s − 1/2|³ᐟ² は C¹ だが、γ′ は 1/2 で C¹ ではない。定数分裂によるその持上げは、時間連続の場合の局所定理の正当な入力である。同定理が道の速度に要求する正則性は連続性であり、C¹ 級であることではない。

*必要な先行結果：* 内部依存：4.2, 4.3, 4.4, 4.5, 0.4.

<a id="target-4-7"></a>
### 4.7 古典的移送、普遍被覆上の切断と降下

**パンルヴェへの適用。**

**入力条件**

- 完備平坦な古典的接続と、そのシンプレクティック保存恒等式を用いる。

§3.10 の平坦性と §4.6 の完備性に NonlinearConnections §0.5 を適用する。一般構成により、実際の終点移送、基本亜群の作用、各古典的初期点を通る普遍被覆上の水平切断を得る。その終点写像を、§3.9 の接続に対する水平持上げと同定する。シンプレクティック保存には §3.11 と NonlinearConnections §0.6 を用いる。得られた被覆変換・モノドロミー作用で初期点が固定される場合に、ちょうど降下する。完備性だけから Bθ 上での一価性を導かない。

**構成・法則（API）**

- 一般構成の移送と普遍被覆上の切断を古典的モジュライ族上で同定する。
- 表示の両立性と、降下に必要な実際の固定条件を確認する。

**検証事項**

- 道を進んだ後にその逆向きの道を進むと、例外点を含むすべての初期条件上で恒等写像を得る。
- B = ℂ× 上で H = qp/(2t) とすると、方程式は q′ = q/(2t), p′ = −p/(2t) である。π₁(B) の正の生成元は (q,p) を (−q,−p) に送り、そのようなループを 2 回たどると恒等写像になる。シンプレクティック乗数は (−1)(−1) = 1 であり、最初のループは原点以外では非自明に作用する。
- このモデルでは、生成元で固定されるのは原点だけである。それ以外の各初期点は、普遍被覆上では完備な切断を与えるが、B には降下しない。完備性だけでは降下には不十分である。

*必要な先行結果：* 内部依存：3.10, 3.11, 4.6, 0.5, 0.6.

<a id="target-4-8"></a>
### 4.8 パンルヴェ相空間上の観測量

**パンルヴェへの適用。**

**入力条件**

- 古典的相空間族、定義域を明示した観測量候補 Q、および評価を主張する水平切断の範囲を入力とする。各切断について以下のいずれかの許容性の証明を与える。スカラー有理型評価には、さらに評価が恒等的に無限大でないことの証明を要求する。

許容性のデータを備えた観測量候補に、NonlinearConnections §0.7 の観測量の構成を適用する。許容性の入力は、切断の像の近傍で定義された実際の正則な ℙ¹ 値写像、または、切断への制限がともに恒等的に零とはならない両立する局所的な分子・分母の表示、または、指定された解消・正則観測量・正則持上げである。最後の場合には、主張する定義域上で選択からの独立性を証明するか、持上げを標識として保持する。これらのデータから、一変数の共通零点の除去または指定された持上げを用いて許容された評価を構成し、必要な重なりの比較を証明する。観測量、定義域、対象とする解の層、および正規化を、指定する評価データの一部として保持する。評価が恒等的に ∞ でないことの証明は、ℙ¹ 値観測量としての許容性とは別の入力である。

各具体的観測量の構成目標が、候補を与え、評価を主張する解の各層でこれらの入力条件を証明する。古典的各プロファイルについて、§7.2 で標準的な q 候補、定義域と重なり、および共通零点の除去または持上げ・選択独立性・非恒等的無限大・被覆の各条件の証明を構成する。これらの証明を、上記の評価構成の入力とする。

**構成・法則（API）**

- 観測量候補と与えられた許容性の証明から、宣言された切断と定義域上で §0.7 の標識付き観測量と評価を構成する。
- 一般の観測量の自然性を用いて正規化、局所比表示、解消後の持上げを比較し、独立性に必要な標識を保持する。
- §4.9 が用いる非恒等的無限大条件を、別の入力条件として明示する。

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

§3.4 の時間一次元性という結論を確認し、§§4.7–4.8 に NonlinearConnections §0.7 を適用する。恒等的に ∞ ではないと確認した各スカラー評価は、許容時間曲線の普遍被覆上で有理型となり、内部のスカラー特異点では有限位数の極をもつ。観測量、主張する各層での解消または共通零点の除去と選択独立性の証明、および非恒等的無限大の証明は、対応する具体的観測量の構成目標が §4.8 への入力として与える。標準的な古典的 q については §7.2 がそれらを供給する。これらの条件の下で、各観測量に同じ有理型評価定理を適用する。一価な降下には、§0.7 のスカラー観測の不変性による判定を用いる。

**構成・法則（API）**

- 確認した古典的観測量の定義域に限って、有理型評価定理を提供する。

*必要な先行結果：* 内部依存：3.4, 4.7, 4.8, 0.7.

#### 例

アフィン方程式 q′ = q² は、q(0) = 1 に対して t = 1 に可動極を持つ。その射影ベクトル場は、u = 1/q では u′ = −1 として延長される。これにより、アフィン座標での脱出と幾何学的な延長が区別される。B = ℂ* 上では、水平系が普遍被覆上で完全に延長できながら、0 の周りに非自明なモノドロミーを持つことがある。これは定理に矛盾しない。

<a id="layer-5"></a>

## レイヤー5：初期値空間・対称性・Riccati 簡約

<a id="target-5-1"></a>
### 5.1 加法型岡本–パンルヴェ対

**パンルヴェへの適用。**

**入力条件**

- 滑らかな有理射影曲面、有効な反標準因子Y、条件Y·Y_i=0、単純正規交差の台、加法型のPicard単位成分、および非ファイバー型を入力条件とする。

滑らかな射影有理曲面 S と、非零有効反標準因子 Y からなる対の比較亜群を定義する。各既約成分について Y·Yᵢ = 0 を満たし、D = Y_red が単純正規交差因子であるとする。Pic⁰(Y) の単位成分が加法群型であることによって表される加法型の条件と、非ファイバー型の条件、すなわち n ≥ 1 に対して nY をファイバーとして持つ楕円ファイブレーションが存在しないことを要求する。ルート基底または正規化された時間を用いるときは、標識を保持する。これらの条件の相対版を構成する。（STT02, Definitions 1.1 and 1.3, Proposition 1.2 および Tables 2–3。）

Y = Σᵢ mᵢDᵢ と書く。Pic(S) の交点形式を x·y とし、ルートの長さには ⟨x,y⟩ = −x·y を用いる。境界格子 R_∂ = Σᵢ ℤ[Dᵢ]、その整直交補 R_∂^⊥ = {x ∈ Pic(S) : すべての i について x·[Dᵢ] = 0}、および δ = [Y] = −K_S を定義する。δ ∈ R_∂ ∩ R_∂^⊥ と δ·δ = 0 を証明する。これらは δ を保持した Pic(S) の部分格子として扱い、ℤδ による商は取らない。標識付きの相対版と、交点形式を保つ移送を構成する。対称性ルート、それらが R_∂^⊥ 内に張る整格子、およびパラメータ超平面は §5.5 の出力とする。

**構成・法則（API）**

- Pic(S) 内の R_∂, R_∂^⊥, δ、指定した符号によるそれらの双線形形式、および重み付き境界交点グラフを構成する。
- 対の同型に対する不変性と、許容される族との整合性を証明する。
- 補集合 S \ D と、その対数的接層および 2 形式の層を比較する。
- 包含 R_∂^⊥ → Pic(S) と標識付き族に関する比較を §5.5 に供給する。対称性ルート基底の構成は同目標が担う。

**検証事項**

- 滑らかな楕円的反標準境界の Picard 単位成分は楕円曲線型であり、加法群型ではないので除外される。
- 乗法型のサイクルの Picard 単位成分は乗法群型であり、除外される。
- 大域的なアフィン平面チャートを要求すると D₈ の場合が除外される。その追加条件は課さない。
- 自己交点 −2 の境界成分のルート長の平方は 2 である。一方、δ の平方は 0 であり、δ は非零の Picard 類として保持される。R_∂^⊥ の定義には全境界成分との直交性を用い、K_S との直交性だけで置き換えない。

**本目標が担う補助構成。**

- 非被約でありうる反標準境界 Y について、射影的・固有・平坦な族、普遍的 O、H² 消滅、および単位成分の仮定を証明し、§1.5 の相対 Picard の構成を適用する。正規化・単数・逐次冪零肥厚の完全列により単位成分を計算し、加法型を定める加法群との比較を証明する。D=Y_red を SNC とし、Θ(−log D) をそのイデアルを保つ導分として構成する。重複度は Y に属し、SNC の述語には入れない。実際の曲面族上で相対 Picard 格子・交点・変形の比較を証明する。SSF5.9 は体上の曲面または算術曲面の交点形式を与える。これらの形式と相対 Picard の構成を用いて、許容された任意基底上の族の比較を構成する。

*必要な先行結果：* 内部依存：1.5; [Cohomology with supports](#dependency-supports) (2.7); [Divisors, modifications and surface intersections](#dependency-surfaces) (3.4; 4.11; 4.17; 5.9–5.10); [Algebraic vector bundles and finite locally free sheaves](#dependency-bundles) (L0A–L0C; L1A–L1B; L2A–L2B).

<a id="target-5-2"></a>
### 5.2 コンパクト化と 8 つの境界型

**パンルヴェへの適用。**

**入力条件**

- 目標3.1–3.12の内在的形式と分裂を備える古典的相空間族全体、§5.1の対の枠組み、および指定した標識と許容基底変換を入力とする。

明示した標識付けと基底変換の後で、§5.1 の対の構造を備えた次数 4 の接続モジュライ族の相対コンパクト化 S → B を構成する。D = Y_red, U = S \ D と置き、相空間族全体から U への B 上の同型を構成する。例外曲線と非自明な束のチャートを含む U の全チャート上で、この同型によるシンプレクティック形式 ω と水平分裂 h の比較を証明する。ω を S 上の有理相対 2 形式 ω̃ に延長し、Ω²_{S/B}(Y) の切断として表す。各ファイバーで div(ω̃|S_b) = −Y_b を満たし、U 上で ω に一致することを証明する。正則な水平分裂とそのチャートへの延長定理の定義域は U であり、延長定理は U 全体を覆う。S 上で構成する延長は、極因子 Y を持つ有理 2 形式である。加法型正規交差境界の型を D₄, D₅, D₆, D₇, D₈, E₆, E₇, E₈ に分類する。これらはアフィン型の境界図式である。（STT02, Proposition 1.2 および Tables 2–3; VDPS09, introduction および Table 1; 完全に確立された PVI の比較については IIS06, §10。）

初期の座標チャートの補集合を含む U の全チャートについて、重なりの同定、被覆性、および延長を証明し、許容された各プロファイルの比較を構成する。IIS06 §10 は PVI の比較を与え、VDPS09 の序文の大域比較は予想として述べられている。§4.6 の完備性定理には、水平分布に加えて §4.4 の固有性を用いる。

**構成・法則（API）**

- 相対コンパクト化と、その境界因子の重複度および交点形式を構成する。
- 束の跳躍と例外チャートを含む、開補集合全体の比較を証明する。
- その同型により U 上の変形、相対シンプレクティック形式、および正則な水平分裂を比較し、標識と基底変換に関する法則を証明する。
- 各ファイバーで指定された極因子 Y を持つ S 上の有理相対 2 形式を構成し、U への制限がそのシンプレクティック形式に一致することを証明する。

**検証事項**

- 境界型 D₆ の 2 つの表示は、異なる形式的極データを持ちうる。境界のラベルが共通であるだけでは、モジュライの同型にはならない。
- D₈ の補集合を、アフィン平面チャートの仮定を課さずに含める。
- 開いた有理チャートとそのスカラー式が正しくても、例外曲線を 1 つ省略すると、補集合全体についての主張は成り立たなくなる。
- ω̃ の境界での極の位数には、D ではなく Y の重複度を用いる。コンパクト化上の非零の Kodaira–Spencer 時間類が U への制限で消えることはありうるが、S 全体への正則な時間持上げがあれば、コンパクト化上のその類自体が消える。

*必要な先行結果：* 内部依存：3.3, 3.4, 3.5, 3.6, 3.7, 3.8, 3.9, 3.10, 3.11, 3.12, 5.1; [Cohomology with supports](#dependency-supports) (2.7); [Divisors, modifications and surface intersections](#dependency-surfaces) (3.4; 4.11; 4.17; 5.9–5.10); [Quot/Hilbert and parameter schemes](#dependency-quot) (4.14).

<a id="target-5-3"></a>
### 5.3 境界の変形空間と時間方向

**パンルヴェへの適用。**

**入力条件**

- §§5.1–5.2の許容された非ファイバー型加法的対の族と、目標3.9–3.12の内在的時間分裂を入力とする。

F = Θ_S(−log D), N_D = O_S(D)/O_S とする。L = H⁰(D,F ⊗ N_D) を構成し、これらの対に対して L が 1 次元であることを証明し、局所コホモロジーへの単射を構成する。L の族と基底変換に関する定理を確立し、その Kodaira–Spencer 像を §3.9 の時間方向と比較する。境界の交点形式から連結写像と交点行列の恒等式を内在的に証明し、許容された境界グラフを統一的に扱う。（TER02, Theorem 2.1 および Proposition 2.1; STT02, Theorem 3.1。）

第一境界層の構成は、直線と台付きコホモロジー全体への単射を与える。TER02 Conjecture 2.1 はその空間全体との一致を扱い、ST04 Appendix A の結果はそこで指定された追加仮定の下で適用される。直線の生成元は、時間の正規化の選択に依存する。変形の比較と、指定した代数的補集合上での一意性によって、持ち上げられた分布の等しさを証明する。

**構成・法則（API）**

- 境界の第一層に付随する 1 次元空間、台付きコホモロジーへのその単射、および制限写像を構成する。
- スカラーのパンルヴェ・チャートを選ばずに、交点行列の公式と次元計算を証明する。
- 局所自由性を伴う基底変換と、その Kodaira–Spencer 像と時間接直線との比較を確立する。

**検証事項**

- 選択した非零の時間ベクトルを定数倍すると L 内のその像も同じく定数倍されるが、L 自体は変わらない。
- 単射 L → H¹_D(S,F) だけでは、その終域が 1 次元であることは証明されない。
- A = ℂ[ε]/(ε²) 上の加群 A/(ε) は、唯一の点でのファイバーが 1 次元だが、階数 1 の自由 A 加群ではない。その ℂ 上の長さは 2 ではなく 1 である。したがって、ファイバーの次元が一定というだけでは、主張する局所自由性を伴う基底変換は確立されない。実際のコホモロジー的仮定を証明しなければならない。

**本目標が担う補助構成。**

- SchemeAndStackFoundations 2.6・2.7 の準連接層のコホモロジー、台付きコホモロジー、局所化完全列、および Noether 条件下の Ext の帰納極限との比較を用いる。JacobianChallenge Layer C の固有射による連接層の順像と、そこで個別に指定された基底変換条件を用いる。対数的曲面の族について、F と N_D を層として構成し、第一境界層の単射、および連結写像と交点行列の比較を構成する。相対 H⁰(D,F⊗N_D) が可逆層となるための固有性・係数平坦性・コホモロジー基底変換の仮定を証明し、有限射影複体または正確な全射性条件を用いて、非被約基底を含む任意基底変換との両立性を証明する。台付き H¹_D への単射を通して、この直線を Kodaira–Spencer の時間直線と比較する。

*必要な先行結果：* 内部依存：3.9, 3.10, 3.11, 3.12, 5.1, 5.2; [Cohomology with supports](#dependency-supports) (2.7); [Divisors, modifications and surface intersections](#dependency-surfaces) (3.4; 4.11; 4.17; 5.9–5.10); [Cohomology, duality and curve degree](#dependency-cohomology) (2.2; 2.6; 2.20; 3.3); [Elementary deformation theory](#dependency-deformation) (4.2–4.6); [Proper coherent direct images and base change](#dependency-proper-cohomology) (Layer C).

#### 例

境界型 E₈ には分岐を伴う階数 2 の表示が 1 つ対応し、E₇ には 2 つ対応する。したがって、境界ラベルと接続の表示は異なる種類のデータである。境界の第一層に付随する空間の次元は1であり、§5.3で指定する台付きコホモロジー群へ単射で写る。

<a id="target-5-4"></a>
### 5.4 付加構造付き接続上の関手

**パンルヴェへの適用。**

**入力条件**

- 許容された付加構造付き接続と、改変のための不変な局所商、または指定された線束接続・双対性・ラベル変更のデータを入力とする。

不変な局所旗に沿う基本変換、許容された階数 1 接続とのテンソル積、双対化、およびラベルの付け替えを、実際の付加構造付きモジュライ問題の間の関手として構成する。新たな行列式、指数、安定性のデータと、変換された対象が安定である領域を明示する。基本変換には核による構成、その上に誘導される接続、および逆基本変換を用い、比較射を保持する。許容された極のフィルトレーションと核格子が保たれることにより、これらの関手を強可積分族に拡張する。（IIS06, Definition 3.5 および §7; I23, §§2–4 および Definition 10.1。）

各操作 g について、パラメータと時間の写像 φ_g、および操作とその逆操作が所定の付加構造付き局所型を持つ飽和した安定領域 𝔘_g, 𝔘′_g を構成する。φ_g 上の関手 F_g: 𝔘_g → 𝔘′_g、逆関手、および両方向の合成と恒等関手との自然同型を構成する。粗モジュライへの射 p_g: 𝔘_g → U_g, p′_g: 𝔘′_g → U′_g に対して、誘導写像 F̄_g: U_g → U′_g を構成し、粗空間の普遍性によって p′_g ∘ F_g ≃ F̄_g ∘ p_g を証明し、引戻しとの両立を示す。周囲の粗空間の双有理対応を主張するときは、稠密開集合 V_g, V′_g を指定し、制限された写像が互いに逆であることを証明する。水平性とシンプレクティック形式の法則は §5.5 が担い、§7.4 は得られた粗空間の写像を §7.2 のチャート内の公式と比較する。

**構成・法則（API）**

- 粗モジュライへ移る前に、変換後の束と接続を、その行列式および局所型の公式とともに構成する。
- 指定した定義域上で、引き戻し、合成、および逆変換の比較を証明する。
- 変換後の重みを指定し、必要な領域では壁越え対応を用いて安定性の比較を証明する。
- F̄_g と φ_g 上の粗モジュライへの可換図式を構成し、各双有理性の主張について稠密な逆写像領域と両側の逆写像の法則を示す。この幾何学的写像と定義域を §7.4 の座標比較へ供給する。

**検証事項**

- 対数極で 1 次元商に沿って基本変換すると、束の次数は −1 だけ変化する。行列式を変更しないままにすると、行列式の比較が成り立たない。
- 階数 2 の接続に線接続 L をテンソルすると、その接続も含めて行列式が L² だけ変化する。これは、あらかじめ固定された奇数次数の行列式の平方根を構成することではない。
- 共通の許容領域上では、逆基本変換によって元の付加構造付き対象がその射とともに復元される。一方、指定された旗を忘れると、逆変換が可能とは限らない。
- F_g による対象の像と、誘導された粗空間の写像による像は、p′_g を通して一致しなければならない。座標公式だけでは、この降下図式や両方向の逆比較は証明されない。

*必要な先行結果：* 内部依存：3.1, 3.5, 3.9, 1.1; [Algebraic vector bundles and finite locally free sheaves](#dependency-bundles) (L0A–L0C; L1A–L1B; L2A–L2B).

<a id="target-5-5"></a>
### 5.5 水平性とシンプレクティック形式の変換則

**パンルヴェへの適用。**

**入力条件**

- §5.4の接続の関手と降下した写像、目標3.5–3.12の変形の対と内在的分裂、§5.1の格子、および§5.2の標識付き曲面との比較を入力とする。

φ_g 上の F̄_g について、変換された族に強拡張の一意性を適用し、相対時間接束上で dF̄_g ∘ h = h′ ∘ dφ_g を証明する。変形複体とトレースペアリングに誘導される写像により F̄_g⁎ω′ を計算し、各シンプレクティック生成元について指定した定義域上で F̄_g⁎ω′ = ω を証明する。パラメータ付きモジュライ族上に得られる作用亜群を構成し、関手の自然同型によって関係式を確立する。標識付き曲面上では、Pic(S) への作用を、対応する整ルート反射および図式の自己同型と比較する。各プロファイルについて、§5.1 の整格子 R_∂^⊥ 内の対称性単純ルートの類、それらが張る R_sym、Cartan ペアリング、および対応するパラメータ超平面を構成し、R_sym が R_∂^⊥ に一致する場合を明示する。双線形形式 ⟨x,y⟩ = −x·y を用い、採用する各ルート α について反射 x ↦ x − 2⟨x,α⟩α/⟨α,α⟩ の整性を証明する。格子への作用では δ を保持し、反射ルートを持たないプロファイルには空のルート系を指定する。（PVI については IIS06, Theorem 7.4 および Theorem 10.13; STT02, Tables 2–3 および標識付き変形の構成。）

§5.4 の関手と標識付き対のモジュライ上の追加の反射を合わせて、対称性の作用を構成する。§5.2 を通して接続モジュライに誘導される双有理対応を同定し、指定した定義域上で水平かつシンプレクティックな延長を証明する。標識付き対の反射には、§5.4 の局所ゲージ基本変換では生成されない PVI の中央反射を含める。IIS06 Remark 7.5(2) は Fourier 変換による実現を記述する。Fourier–Laplace 変換または中間畳み込みによる実現には、付加構造付きモジュライ問題の間の関手と、その強拡張の比較が必要である。ここでの追加の反射には、標識付き曲面による構成を用いる。引用した IIS06 の定理は PVI を対象とし、他の各プロファイルの主張はその標識付き対との比較によって確立する。反射関係式と Coxeter 関係式、有効領域の条件、およびチャートの補集合を越える延長を証明し、これらの結果を §7.4 の座標比較に供給する。各大域自己同型について、稠密開集合上の有理写像の恒等式に加えて、指定した定義域全体への正則な延長を証明する。

**構成・法則（API）**

- 各プロファイルの R_∂^⊥ 内の対称性ルートデータと標識付き対の反射対応を構成し、共通の定義域上で粗空間へ降下した接続関手の生成元と比較する。
- φ_g 上の水平性の恒等式、相対 2 形式の恒等式、関係式、およびパラメータ変更との整合性を証明し、誘導写像が水平解を水平解に送ることを導く。
- 大域写像と主張する各写像について、正則な定義域と延長定理を記録する。

**検証事項**

- PVI の中央反射は、κ₀ を −κ₀ に、κⱼ を κⱼ + κ₀ に送る。ただし j = 1,2,3,4 である。これは 2κ₀ + Σκⱼ = 1 を保つ。κ₀ = 1/2, κⱼ = 0 では、変換後の組は κ₀ = −1/2, κⱼ = 1/2 となり、−1 + 2 = 1 を得る。κ₀ の符号変更を省くと、代わりに 3 となる。局所的な整数シフトと符号変更だけでは、この反射を構成できない。
- 反射を 2 回行うと、単に同じ境界図式が得られるだけでなく、比較射を伴う元の標識付き族が得られなければならない。
- 不変曲線上で極を持つ双有理公式は、正則な延長が証明されるまでは、その曲線の自己同型ではない。

*必要な先行結果：* 内部依存：3.6, 3.7, 3.12, 5.1, 5.2, 5.3, 5.4; [Cohomology with supports](#dependency-supports) (2.7); [Divisors, modifications and surface intersections](#dependency-surfaces) (3.4; 4.11; 4.17; 5.9–5.10).

<a id="target-5-6"></a>
### 5.6 不変有理曲線と Riccati 力学

**パンルヴェへの適用。**

**入力条件**

- 許容された非ファイバー型加法的対の内部にある自己交点−2の滑らかな有理曲線、指定された半普遍的な対の変形、および§5.3の時間方向の比較を入力とする。

許容された非ファイバー型の加法型対に対して、C² = −2 を満たす内部の滑らかな有理曲線 C の局所族を構成する。外部パラメータを α₀ に固定し、(α₀,t₀) のファイバー内の曲線 C を、t₀ の解析的または étale な近傍 U に対する時間基底 {α₀}×U 上で局所的に族へ延長する。外部パラメータ方向への延長は、結節曲線が存在する領域上で定義し、その領域の存在と対の半普遍変形との比較を証明する。対数的変形完全列を用いて、時間分布による不変性を証明する。その族を延長するために必要なエタールまたは有限基底変換を保持する。元の底空間への降下には、それ自身のモノドロミーの確認が必要である。得られた相対 ℙ¹ 束上で、H⁰(ℙ¹,Tℙ¹) ≅ sl₂ を用い、制限された接続を射影線形接続と同定する。その座標補題では q′ = a(t)q² + b(t)q + c(t) を得る。階数 2 の線形接続への局所的な持上げを構成し、持上げの障害が消える場合には大域的な持上げを構成する。（ST04, §2.4, Proposition 2.1, Remark 2.4 および Definition 2.3。）PVI と Gauss 方程式の比較は IIS06 Theorem 5.15 である。同文献の Theorem 5.16 は解析的パンルヴェ性を仮定する。ここでの幾何学的構成には、対数的変形完全列と時間方向の比較を用いる。

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
- 有理解が Riccati 曲線上にあるとは限らない。ST04 §6.2 がこの違いを与える。上記の分類は、内部のノード曲線とその不変 Riccati 力学を対象とする。

*必要な先行結果：* 内部依存：3.9, 3.10, 3.11, 3.12, 5.1, 5.2, 5.3, 5.4, 5.5; [Cohomology with supports](#dependency-supports) (2.7); [Divisors, modifications and surface intersections](#dependency-surfaces) (3.4; 4.11; 4.17; 5.9–5.10); [Quot/Hilbert and parameter schemes](#dependency-quot) (4.14); [Complex manifolds, holomorphic bundles and observations](#dependency-complex) (K1; K3.0; K3.HolomorphicStalk; K3.MeromorphicGermField; K4; K7.1).

#### 例

§7.5 の PII チャートでは、曲線 p = 0 は α = −1/2 において不変である。その Riccati 方程式は、この曲線上の射影接続の座標表示である。α = 0における有理的な種解q = 0は異なるパラメータ値を持ち、§7.5の種解と変換の構成で扱う。

<a id="layer-6"></a>

## レイヤー6：行列式線束とタウ切断

<a id="analytic-theory"></a>

§6.1 で一般の指数 0 の Fredholm 族に対する正則行列式線束と標準切断を構成し、§§6.2–6.5 で標識付きパンルヴェ RHP 族に適用する。これらの族について作用素による実現を構成し、指数と正則依存性、線束・枠の比較、および指定した JMU・Hamiltonian 恒等式を証明する。行列式の比較を伴うトレースクラス実現には、RandomMatrices §8.3 の一般のトレースクラス行列式を用いる。

書誌情報と文献中の参照箇所は[sources.toml](sources.toml)に記す。構成のモデルはMAL04とBERT17であり、JMU比較にはBERT10とBERT16の訂正を、以下で指定する正確な範囲で用いる。実の向き線束、Toeplitz指数定理、トレース級行列式の供給範囲をそれぞれ保持する。

<a id="target-6-1"></a>
### 6.1 指数0のFredholm族に対する正則行列式直線束

**一般理論。**

**入力条件**

- 有限次元複素多様体 S と、指数0の有界複素 Fredholm 作用素の正則族を入力とする。まず作用素の定義域と値域は固定した複素 Hilbert 空間とする。
- 有限次元行列式と完全列の規約、有界な局所分裂、および Banach 空間上の正則な逆作用素を用いる。線束、安定化、標準切断、比較のコサイクルは構成の出力である。

有限次元複素多様体 S 上の、固定した複素 Hilbert 空間 H₀,H₁ の間の指数 0 の有界複素 Fredholm 作用素の正則族 T_s: H₀ → H₁ に対し、正則直線束 L_T とその標準行列式切断 τ_T を構成する。Fredholm・行列式線・有限次元安定化の既存の対象を複素数体に特殊化し、正則な局所自明化と整合的な貼合せを構成する。規約は L_T,s = det(ker T_s)* ⊗ det(coker T_s) とし、実の向き直線の規約の双対を用いる。核と余核の次元が跳ぶ族も含める。（MAL04 §2、印刷頁1372–1374は行列式拡張のモデル、BERT17 §1はそこで指定された記号のクラスにおけるRHPへの適用を与える。）

局所的に有限次元複素空間 F と a: F → H₁ を選び、(T_s,a): H₀ ⊕ F → H₁ を全射にする。局所的な有界分裂と正則な逆作用素を用いて K = ker(T,a) が階数 dim F の正則ベクトル束であることを証明する。L_F = det K* ⊗ det F、τ_F = det(K → F) と置き、K → F には射影を用いる。安定化直和因子を追加した際の比較写像を構成し、共通の細分化を経由して任意の安定化を比較する。貼り合わせに先立って、比較のコサイクル則と切断との両立を証明する。有限次元族では標準の行列式フレームにおける通常の行列式が得られるよう、完全列の符号規約を固定する。安定化の選択からの独立性、正則基底変換、作用素族の同型に関する自然性を証明する。同じ比較則を用い、指定された局所自明化を持つ正則Hilbert束上の作用素族へ拡張する。

τ_T(s) ≠ 0 が T_s の可逆性と同値であることを示す。τ_T が恒等的に零となる、恒等的に非可逆な族も含める。有効な行列式因子には、τ_T が各連結成分上で恒等的に零でないことを仮定する。線束の遷移コサイクルは安定化の比較から構成する。候補となる曲率 2 形式の閉性だけでは、このコサイクルは得られない。各適用は引戻した線束と切断を用い、RHP による実現と対数微分公式を証明する。

基底の圏は有限次元複素多様体と正則写像からなる。非被約解析基底はこの構成の対象外である。その上の作用素族には冪零係数を層の値を取るデータとして保持する必要があり、点ごとの作用素だけではそのデータは決まらない。

**構成・法則（API）**

- 指定した双対規約と有限次元の符号較正に従って、安定化の核の束、行列式直線束、標準切断を構成する。
- 細分化との両立、コサイクル則、安定化からの独立性、正則基底変換を証明する。
- 作用素族の同型に関する自然性を証明し、指定された自明化によってHilbert束版を貼り合わせる。
- 一般点での非消滅や因子を仮定せず、切断の非消滅領域を作用素の可逆領域と同一視する。

**検証事項**

- T_s: ℂ → ℂ, z ↦ sz に対して標準フレームで τ(s) = s を得ることを確かめ、双対規約を固定する。
- T_s(z) = s²z では dim ker T₀ = 1 である一方、零点の位数は 2 となることを確認する。消滅次数と核の次元は異なりうる。
- 至る所で可逆な定数族では行列式切断は消えない。恒等的に非可逆な指数 0 の族について正則行列式線束を構成し、その標準切断が恒等的に零であることを確認する。
- 二つの有限次元安定化を共通の細分化で比較すると切断が一致しなければならず、第三の安定化を経由しても比較は変わってはならない。

- 双対数の基底では T=ε と T=0 は点ごとには同じ作用素だが、行列式切断は ε と 0 で異なる。両者の区別には、この非被約基底上の冪零な作用素係数が必要である。この基底は複素多様体の圏の対象外である。

**本目標が担う補助構成。**

- 既存の複素 ContinuousLinearMap.IsFredholm、nonempty_fredholmPackage、IsFredholm.exists_stabilization_kernel_coordinates、kernelHomeomorph、contDiffAt_kerSection、および各点の detLine/detLineCongr を用いる。後者の規約 det ker(T)⊗det coker(T)* の双対を L_T に使う。正則な束・標準切断・安定化比較・基底変換はここで構成し、有界作用素の解析的逆写像と実際の有限次元チャートから正則遷移写像を証明する。

*必要な先行結果：* [Native complex Fredholm and determinant carriers](#dependency-fredholm) (IsFredholm; nonempty_fredholmPackage; exists_stabilization_kernel_coordinates; kernelHomeomorph; contDiffAt_kerSection; detLine; detLineCongr); [Native analytic inversion](#dependency-inversion) (analyticAt_inverse; analyticAt_inverse_one_sub); [Complex manifolds, holomorphic bundles and observations](#dependency-complex) (K1; K3.0; K3.HolomorphicStalk; K3.MeromorphicGermField; K4; K7.1).

<a id="target-6-2"></a>
### 6.2 パンルヴェ族の行列式線束

**パンルヴェへの適用。**

**入力条件**

- §6.1 の正則な複素指数 0 の行列式構成と、作用素族の同型および基底変換に関する法則を用いる。

標識付きパンルヴェ作用素族に対する行列式構成を、AnalyticRHPAndDeterminants §6.1 の正則な複素指数 0 の行列式線束、標準切断、有限次元安定化、整合的な比較写像によって指定する。同じ複素作用素の対象上で L_T = det(ker T)* ⊗ det(coker T) とする。必要な入力は、正則な指数 0 の作用素族と、§6.1 の恒等則・合成則・切断との両立を満たす比較写像である。これらの族と比較は、標識付き接続データから §6.3 で構成する。この適用の線束と切断は、上記の双対規約による §6.1 の対象の引戻しである。

**構成・法則（API）**

- 双対規約と、§6.1 の線束・切断の引戻しとの同定を指定する。
- §6.3 で構成する族に対する正則性・指数 0・比較コサイクル・降下の条件を指定する。

**検証事項**

- T_s: ℂ → ℂ, z ↦ sz に対し、標準枠では τ(s) = s となり、これによって双対規約が固定される。
- T_s(z) = s²z では dim ker T₀ = 1 である一方、零点の位数は 2 となることを確認する。零点位数と核の次元は異なりうる。
- 至る所で可逆な定数族では行列式切断は消えない。恒等的に非可逆な指数 0 の族について正則行列式線束を構成し、その標準切断が恒等的に零であることを確認する。

*必要な先行結果：* 内部依存：6.1.

<a id="target-6-3"></a>
### 6.3 指数 0 の RHP 実現と降下

**パンルヴェへの適用。**

**入力条件**

- §§3.1, 3.5, 3.6, 3.9 の付加構造付き接続族、§§4.1–4.3 の局所解析的再構成と比較、§1.2 の時間基底、および §6.2 の行列式構成の適用条件を用いる。選んだ補助的参照対象・改変、積分路、格子、枝、および正規化を含める。Fredholm 実現と指数 0 の証明は本項目で構成する。降下の比較には、追加した補助複体が至る所非輪状である作用素・鎖複体・安定化の同値を用いる。

指定した付加構造付き接続族と §§4.1–4.3 の解析的比較から、解析的 RHP チャートを構成する。標識データには、基準束または改変、積分路、局所格子、分枝、枠、および正規化を保持する。対応する Fredholm 作用素を構成し、指数 0 と正則依存性を証明する。閉曲線積分路モデルでは、固定した積分路近傍上の正則可逆な跳躍シンボルを用い、その行列式の回転数を 0 とする。可解な正規化 RHP を対応する標識付き接続と比較し、§6.2 の線束と切断を引き戻す。§§3.1–3.3 に保持した分岐を伴う層と共鳴層のすべてに対して、解析的な扇形領域モデルとアダプターを構成し、作用素・可解性・行列式の比較を証明する。引用する閉曲線積分路上の構成を作用素モデルの出発点とし、扇形領域・分岐・共鳴に関する比較を本項目で構成する。（BERT17, §1 および Theorem 2.2; MAL04, §2。）

ℙ¹ 上で rank E = 2, deg E = d ならば、χ(E(−1)) = d および χ(E(k)) = d + 2k + 2 である。d が奇数の場合、共通の整数回の線束捻りの Euler 標数はすべて非零であり、特に次数 −1 の相空間の対象に対する E(−1) の指数は −1 である。正規化された指数 0 の複体または改変と、元の接続との比較を構成する。Malgrange の次数 0 の縫合束による構成を用いる際にも、この比較を RHP 実現に含める。

入力の標識に、基準束と補助的改変を保持する。追加した補助複体が至る所非輪状である作用素・鎖複体・安定化の同値に対して、線束と切断の単元遷移因子を構成する。一般の基準束または改変の変更は異なる正規化問題を定め、零因子を変えうる。相対行列式因子または有理型変換を構成し、その零点・極の因子も記述する。BERT17 の因子分解比較は、許容された因子分解の同値に適用する。

**構成・法則（API）**

- RHP の標識チャートと、その接続データから作用素族への関手を構成する。
- 同じ Fredholm 族、または正則な鎖同値／安定同値が証明された族を与える積分路・因子分解・正規化の変更に対して、恒等則および合成則を伴う比較同型を証明する。
- 標識付きモジュライ亜群／スタック上に同変線束と切断を構成する。粗空間への降下は、線束と切断に対する固定部分群の作用が自明であることを証明してから行う。
- 許容された分岐を伴う層と共鳴層のすべてについて解析的アダプターを構成し、定義域を指定して、作用素・指数 0・正則依存性・可解性の比較を証明する。

**検証事項**

- 相空間の対象となる次数 −1 の接続について E(−1) の指数が −1 であることを計算し、正規化した指数 0 の RHP 複体と比較する。
- スカラー自己同型は Euler 標数を重みとして作用し、その重みはここでは 0 である。粗空間への降下の比較では、標識付き亜群の他の各固定部分群についても作用を確認する。
- 2 つの基本的な跳躍因子分解は、異なるスカラー Fredholm 行列式を与えうる。その非零遷移因子を計算し、対応する線束と切断の比較を確認する。

**本目標が担う補助構成。**

- 閉曲線模型では実際のHardy/Toeplitz比較を構成し、連続可逆な行列記号にT1–T3を適用する。行列式回転数0と正則依存を確認し、復元写像によって正規化可解性と可逆性を同値にする。行列記号では指数0だけでは足りず、扇形・共鳴・分岐の模型は本目標の別の比較で扱う。

*必要な先行結果：* 内部依存：3.1, 3.5, 3.6, 3.9, 4.1, 4.2, 4.3, 6.2, 1.2; [Cohomology, duality and curve degree](#dependency-cohomology) (2.2; 2.6; 2.20; 3.3); [Elementary deformation theory](#dependency-deformation) (4.2–4.6); [Stacks, inertia and restricted coarse-space criteria](#dependency-stacks) (1.18–1.23); [Trace-class ideal carrier](#dependency-trace-ideal) (OI-B01–OI-B19; OI-B23; OI-B29–OI-B30); [Matrix-symbol Toeplitz index](#dependency-toeplitz) (T1–T3); [Generic trace-class determinant](#dependency-trace-determinant) (8.3, generic operator-theory prefix).

<a id="target-6-4"></a>
### 6.4 タウ因子と変分公式

**パンルヴェへの適用。**

**入力条件**

- §6.3 の行列式切断、因子を構成する連結な滑らかなチャート上で恒等的に零でないという条件、および以下で指定する一般的位置の JMU 比較と頂点補正の仮定を用いる。

行列式切断が消滅することと、その正規化 RHP が可解でないことが同値であると証明する。被約かつ連結な滑らかなチャート上で切断が恒等的に零でない場合、その有効 Cartier 因子を構成する。大域的な因子は、線束の比較を通して初めて得る。この因子は選択した RHP 正規化が成立しない領域を記録し、別のチャートで水平解が通過する正則な内在的相空間点を含みうる。6.1 の各安定化チャートで、同じ階数の束 K_stab と F の正則フレームを選び、射影 K_stab→F を表す行列を S(s) とする。標準切断の代表は det S である。非消滅領域で d log(det S)=Tr(S⁻¹dS) を証明し、行列式フレームの変更に伴う実際の対数補正を証明する。これにより分岐・共鳴のアダプターを含む全ての構成済み RHP チャートで行列式フレームの1形式とスカラー正規化を得る。同値に、有限次元空間 F 上で K_fin=I−S と置けば、表示したトレースクラス恒等式を得る。無限次元の可積分核による実現では、トレースノルムで正則な族 K と、非消滅因子 u を伴う τ=u det(I−K) の比較を構成する。I−K が可逆であるトレースクラス領域上で d log τ=d log u−Tr((I−K)⁻¹dK) と枠変更の法則を証明する。JMU/Hamiltonian 比較の領域は、以下で指定する一般的位置の部分とする。（BERT17, Theorem 2.2, Proposition 2.3, formula (3.6), Theorem 3.3 および §3.1.2。）

JMU 形式との比較は、明示した形式的正規化の仮定の下でのみ行う。すなわち、BERT10 Assumption 3.1 および §5.1, Proposition 5.1 の、分岐を伴わず最高次項が対角化可能であり、対数的非共鳴条件を満たす一般的な領域に限る。訂正された符号については BERT16 Definition 2.1、頂点での曲率については Theorem 2.1、BERT10 Theorem 5.1 を置き換える結果として Theorem 2.2 を用いる。訂正後の局所公式は ω_M − θ_V を用い、モノドロミーパラメータ上で dθ_V = η_V を満たす。モノドロミーを固定した時間方向では θ_V の成分はない。この制限において因子分解と枠の補正を一致させる。モノドロミーと時間の全空間上では、Malgrange 形式とその補正形の曲率項を保持する。頂点を持つ積分路グラフと頂点のない積分路とを、頂点項を含めた縫合写像によって比較する。

**構成・法則（API）**

- 切断の因子と、§6.3 の比較に対するその自然性を構成する。
- 局所変分恒等式と、非消滅の枠乗数によるその変化を証明する。
- 選択した JMU 正規化との比較を、上で述べた、分岐を伴わず最高次項が対角化可能で対数的非共鳴な一般的領域上で構成する。分岐を伴う各層と共鳴する各層では、§6.3 の RHP アダプターから行列式切断とその有限次元安定化による対数微分を構成し、JMU 比較は指定した一般的領域に限定する。無限次元のトレース公式には、トレースクラス実現と行列式枠の比較を証明する。

**検証事項**

- 選択したタウ代表の零点が生じても、内在的な水平解は、別の束のチャート内でその時刻を越えて延長されうる。
- 族 T_s = s² について、行列式切断の零点が 2 重であり、s = 0 における核が 1 次元であることを確認する。
- 頂点で非自明な極限を持つグラフについて BERT16 の頂点補正を計算し、互いに交わらない閉曲線積分路との縫合比較に、その補正の変換を含める。
- 局所接続 d + [[0,z⁻²],[z⁻¹,0]]dz の射影的傾きは 1/2 である。z = w² とゲージ diag(1,w) の後、その最高次項係数は 2(E₁₂ + E₂₁)/w² となる。これは、ここでの JMU 比較の領域外である。その指数 0 の RHP アダプターは、分岐を伴うチャート上で行列式切断と有限次元安定化による対数微分を備える。

- 無限次元複素Hilbert空間上のT_s=e^s Iは正則で可逆なFredholm族だが、T_s⁻¹dT_s=I dsはトレースクラスのトレースを持たない。その行列式線の切断には局所有限次元安定化による代表がある一方、無限次元のトレース表示は定義されない。

*必要な先行結果：* 内部依存：4.1, 6.2, 6.3, 1.2; [Generic trace-class determinant](#dependency-trace-determinant) (8.3, generic operator-theory prefix).

<a id="target-6-5"></a>
### 6.5 Hamiltonian、枠、およびスカラー正規化

**パンルヴェへの適用。**

**入力条件**

- JMU・ハミルトニアン比較は、分岐を伴わず非共鳴である一般的位置の部分でのみ行う。より広い範囲でのスカラー正規化には、構成した標準 RHP 行列式切断 τ_T の有限次元安定化による対数 1 形式、固定した非消滅枠 e、τ_T(t₀) ≠ 0 を満たす正則な基点 t₀、および時間葉上で選択したスカラー値 c ∈ ℂ× を用いる。無限次元トレース表示には、検証したトレースクラス実現と枠の比較を追加で要する。

§6.4 の JMU 比較の領域上で、§3.11 の力学に対する時間座標とシンプレクティック・チャートを選ぶ。選択した行列式枠での対数微分と局所 Hamiltonian の関係を導き、その係数と、ゲージ・因子分解・時間だけに依存する補正項を §6.4 から証明する。Hamiltonian の規約と局所的な原始関数を、時間の関数を加える不定性も含めて指定する。Hamiltonian／JMU 恒等式の領域はこの一般的領域とし、より広い RHP チャートの領域におけるスカラー正規化には、以下の安定化による対数形式を用いる。（対数的 Schlesinger の範囲に限った MAL04, Theorem 5.12; BERT16 による訂正を伴う BERT10, §5.1, Proposition 5.1。）

§6.3 の全ての標識付き RHP チャートで、分岐・共鳴チャートも含め、固定した標準切断を選択した行列式枠で τ_T = f e と書く。§6.4 の安定化枠では f = det S であり、非消滅領域で d log f = Tr(S⁻¹dS) が成り立つ。e′ = a e へ枠を変えると係数は f′ = a⁻¹f となり、d log f′ = d log f − d log a を得る。行列式枠との比較を伴う無限次元実現 f = u det(I−K) では、I−K が可逆であるトレースクラス領域上で d log f = d log u − Tr((I−K)⁻¹dK) を得る。（BERT17, Proposition 2.3 および formula (3.6)。）

係数 f とその基点値 f(t₀) は、τ_T と e によって定まる。別の出力として正規化スカラー関数 f_norm = c f/f(t₀) を定義し、f_norm(t₀) = c、d log f_norm = d log f、および f_norm e = (c/f(t₀))τ_T を証明する。基点値の選択は標準切断の指定した定数倍を与え、元の切断と枠は比較のために保持する。同じ選択をファイバーの値 c e(t₀) として表すこともでき、枠を変更するときは、同じファイバー値の係数となるよう c も変換する。この正規化は §6.3 の標識付き RHP チャートに適用し、非消滅領域上の安定化による対数形式を用いる。

微分方程式による正規化は、選択した因子を避け、モノドロミーを固定した水平な時間葉に沿って行う。指定した閉じたスカラー対数 1 形式と非零の基点値は、連結かつ単連結な領域上で一意な解を定める。その 1 形式が d log f に一致する領域で解が f_norm に等しいことを証明し、局所解をループに沿って延長するときの降下に対するホロノミー障害を計算する。モノドロミーと時間の全空間の領域に同じスカラー正規化定理を適用する場合も、枠補正の後の閉性を要する。単連結性だけでは、線束の接続の曲率は除去されない。

**構成・法則（API）**

- 指定した JMU 比較の領域上で、§3.11 のシンプレクティック形式と時間の規約を変分恒等式と比較し、すべての補正項を記録する。より広いRHPアダプターの領域では、指定した行列式枠で有限次元安定化の恒等式を用いる。無限次元トレース公式は、追加のトレースクラス比較を証明した場合に用いる。
- 時間変更、時間依存のシンプレクティック・チャート変更、および行列式枠の変更に対する変換則を証明する。
- f_norm = c f/f(t₀)、固定した枠における τ_T との比例比較、および基点値と対数微分の法則を構成する。対応するスカラー微分方程式について、連結かつ単連結な正則領域上の解の一意性を証明し、降下に対するホロノミー障害を同定する。

**検証事項**

- 恒等式 d log τ = H dt を用いる場合、H を H + c(t) に置き換えるには、積分定数を固定した上で τ に exp(∫c(t)dt) を掛ける必要がある。
- 時間変換 u = φ(t) の下で、同じ対数 1 形式の係数は (dt/du)H となる。スカラー係数を変更しないと、比較が成り立たない。
- 非零定数倍だけ異なる 2 つの代表は、同じ対数微分を定めるが、基点値が一致するまでは異なる正規化スカラー関数である。
- T_s(z) = sz の標準行列式枠では f(s) = s である。s₀ = 1, c = 2 とすると f_norm(s) = 2s となる。これは標準切断の 2 倍の係数であり、元の標準切断の係数は s のままである。

*必要な先行結果：* 内部依存：3.11, 3.12, 6.3, 6.4; [Complex manifolds, holomorphic bundles and observations](#dependency-complex) (K1; K3.0; K3.HolomorphicStalk; K3.MeromorphicGermField; K4; K7.1).

#### 例

1 次元作用素族 s, s², 1 の行列式切断、因子の重複度、および可逆領域を計算する。相空間の対象となる次数 −1 の接続と、その補助的な指数 0 の RHP 複体を比較する。積分路／因子分解の変更に対して、線束と切断の比較、およびスカラー代表の間の遷移因子を計算する。

<a id="layer-7"></a>

## レイヤー7：パンルヴェ方程式の古典的表示

<a id="target-7-1"></a>
### 7.1 一階ジェット座標とスカラー・パンルヴェ方程式

**パンルヴェへの適用。**

**入力条件**

- 古典的時間曲線、非線形接続を備えた相曲面、局所観測量、およびジェット同型領域を用いる。一般ジェット定理はシンプレクティック形式もパンルヴェ性も仮定しない。

観測束とその第一ジェット束で定式化された NonlinearConnections §0.8 を用いる。古典的時間曲線と相曲面について局所観測量を与え、誘導されたジェット写像が指定領域で同型となることを証明する。その領域で、水平芽とスカラー二階方程式の芽との一般の同値を適用する。時間・相座標で h(∂t) = ∂t + A∂q + B∂p、J(t,q,p) = (t,q,A) と書き、p = P(t,q,v) が指定領域上の逆写像であるとき、座標比較は q″ = (A_t + A A_q + B A_p)(t,q,P(t,q,q′)) となる。連鎖律の定理と内在的ジェット構成は一般枠組みに置く。A_p ≠ 0 が与えるのは局所逆だけである。個々の古典的チャートの構成は §7.2 が担う。有理型延長にはさらに §4.9 を用い、それをジェット定理の仮定にはしない。

**構成・法則（API）**

- 各チャート・観測量のジェット同型領域を確認し、その補集合を記録する。
- 取り込んだジェット構成の座標表示として、スカラー公式を導く。

**検証事項**

- A = p ならば、逆写像は p = q′ であり、スカラー方程式は q″ = B(t,q,q′) となる。
- A が p に依存しないならば、J は運動量を忘れてしまい、ジェット座標にはなりえない。この場合、この議論によって幾何学的一意性からスカラー解の一意性を導くことはできない。
- A = p² の場合、p = 0 の外側には運動量の二つの枝がある。局所可逆性によって、この二つの枝が大域的に同一視されることはない。
- スカラー式が q による除算を含む場合、q = 0 を横切る解を重なり合う相空間座標で比較する。その延長と、分母を払った方程式が元の有理的な定義域の外で持つ余分な解を区別する。

*必要な先行結果：* 内部依存：3.4, 3.7, 3.9, 0.8.

<a id="target-7-2"></a>
### 7.2 表示と方程式の網羅的比較

**パンルヴェへの適用。**

**入力条件**

- §3.4 のプロファイル分類、§§3.5–3.12 の内在的モジュライ、分裂とシンプレクティック形式、および §§4.8–4.9 の観測量・延長定理を入力とする。文献との局所的な比較補題、各プロファイルの具体的座標と標準観測量、パラメータ・時間の置換、ジェットの逆写像、観測量の適用条件の証明、および被覆・重なりの比較を本項目で構成する。

文献のハミルトン系について、次の符号比較を証明する。VDPS09 §4.1 に表示されている方程式 p′ = F H_q, q′ = −F H_p では、F が q のみに依存するとき、その核を与える形式は dp ∧ dq/F + dH ∧ dt である。文献に印刷された拡大形式の負号は、PI の場合 (44), (46), (47) を含め、これらの方程式と整合しない。F ≠ 0 上で、文献の引数順序 H(p,q,t) を用いて Q = q, P = p/F(q), K(Q,P,t) = −H(F(Q)P,Q,t) とおく。このとき dQ ∧ dP + dK ∧ dt は、正しい文献側の形式の負であり、§3.11 の規約を与える。この恒等式を直接証明し、各文献のハミルトニアンと §3.11 との比較に用いる。

VDPS09 に印刷された PV 方程式 (3) も、その系 (2) およびハミルトニアン (5) と一致しない。q′ = 2p/t を微分すると、指数パラメータを含む項は、印刷された θ₀²/(2qt²) + θ₁²/[2(q − 1)t²] に代わって [θ₀²(q − 1)² − θ₁²q²]/[2q(q − 1)t²] となる。t = 1, q = 2, p = 0, θ₀ = 0, θ₁ = 1, θ∞ = 1 では、両立する系は q″ = 2 を与える一方、印刷されたスカラー方程式は 7/2 を与える。以下の PV 対応表には、両立する系から導いた式を用いる。この二つの局所的な代数補題を本項目で証明し、表示の比較および §7.4 に用いる。

§3.4 の各プロファイルについて、接続のモジュライから具体的な時間・Darboux 座標、またはそれと同等のシンプレクティック座標を、実際の像上の逆写像とともに構成する。§3.9 の強い可積分拡張によってこの座標での h を同定し、§7.1 を適用して、以下の標準方程式へのパラメータと時間変数変換の対応を、必要な標識の被覆も含めて証明する。この比較には、選んだ局所枠、行列式の規約、座標領域、運動量の逆写像、すべての分母、および除外した部分を記録する。これらの座標がモジュライ空間全体を覆うことを、その重なりの同定とともに証明する。上記の文献との比較補題を用いて、両立する系からスカラー表示を導く。（VDPS09, §2.2, Table 1 および §4; IIS06, Theorems 10.6, 10.10 and 10.13; DLMF, §32.2(i), equations 32.2.1–32.2.6.）

表の各プロファイルについて、選んだ cyclic vector または局所枠を伴う標準 q の候補を、実際の有理的な定義域と重なりの比較とともに構成する。cyclic vector による見かけの特異点はこの表示データに属し、§3.8 の固定標点でのモノドロミー条件による部分対象とは区別する。スカラー比較に含める各解の層について、§4.8 が要求する約分または解消後の持上げの比較、代表・持上げの選択からの独立性、および恒等的には無限大でない条件を証明する。どの層を覆い、どこで別の観測量チャートを使い、どこでスカラー値を持たず相空間データを保持するかを明示する。これらの条件を本項目で証明し、§§4.8–4.9 の適用に用いる。

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

Flaschka–Newell のスカラー座標を PII に、退化 PV を PIII(D₆) に結びつける実際の変数変換と、許容される逆変換の領域を証明する。各表示に対応する付加構造付きモジュライ問題を保持する。スカラー変数変換は指定した逆変換の領域上で解の芽を比較する。退化 PV と PIII の場合も含め、モノドロミー保存族の同定には付加構造付き接続の全データの比較を要する。（AHT17, introduction および §§2–3.）

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
| VDPS09 の PV 系 (2)/(5), 上記で導いたスカラー式を使用 | T = t, Q = q/(q − 1); (α,β,γ,δ) = (θ₁²/2,−θ₀²/2,1 − θ∞,−1/2) |
| VDPS09 の退化 PV 系 (8) | T = t², Q = q/(q − 1); (α,β,γ,δ) = (θ₁²/2,−θ₀²/2,−2,0) |
| VDPS09 PIII(D₆), (14) | T = t, Q = q; (α,β,γ,δ) = (4(θ∞ + 1),−4θ₀,4,−4) |
| VDPS09 PIII(D₇), (19) | t = T², Q(T) = Tq(T²); (α,β,γ,δ) = (4(θ∞ + 1),−8,4,0) |
| VDPS09 PIII(D₈), (24) | t = T², Q(T) = q(T²)/T; (α,β,γ,δ) = (8,−8,0,0) |
| VDPS09 PIV, (29) | t = 2T, Q(T) = 2q(2T); α = −θ∞ − 1, β = −2θ₀² |
| VDPS09 PII Jimbo–Miwa, (39) | T = t, Q = q; α = (θ∞ + 1)/2 |
| VDPS09 PI, (45), c⁵ = 2 を選ぶ | T = ct, Q = c⁻²q; Q″ = 6Q² + T |

Flaschka–Newell 座標 (34) では、c³ = 2 を選び、T = −ct, U(T) = cq(t) とおく。このとき U″ = U′²/(2U) + 2U² − TU − θ₀²/(2U) となる。指数の符号の選択 a = ±θ₀ を保持する。U ≠ 0 上では、Q = (U′ − a)/(2U) が α = a − 1/2 に対する PII 変数であり、逆に U = Q′ + Q² + T/2 となる。例外的な枝 U = 0, a = 0 は除算によって復元できないので、相空間の全データを保持する。時間の二乗を用いる比較は、非零の領域上の局所双正則写像、または指定した被覆上の比較である。同じ穿孔直線上の大域的な座標変換ではない。

PI と PII の比較パッケージには、ω = dq ∧ dp, q′ = H_p, p′ = −H_q の規約で、H_I = p²/2 − 2q³ − tq および H_II = p²/2 − (q² + t/2)p − cq, c = α + 1/2 という標準ハミルトニアンを含める。拡大形式の比較と運動量の逆写像は本項目で証明する。これらのハミルトニアンと比較を、§7.4 のシグマモデルと §7.5 の種解の検証に用いる。

**構成・法則（API）**

- 表示の対応表を使う前に、文献の拡大形式の符号比較と両立する PV 系からの消去を証明する。
- 表示の各行について、明示式、パラメータ写像、逆ジェット座標、重なりの写像を含む比較パッケージを用意する。
- 拡大 2 形式の等式によって、文献ごとのハミルトニアンと §3.11 の規約を比較する。
- 除外した分母をすべて特定し、その零点集合のうち許容される部分を通る相空間座標を明示する。
- 各標準 q を構成し、その定義域・重なり・層の被覆・約分または持上げ・非恒等的無限大の条件の証明を §§4.8–4.9 に供給する。
- 比較で覆われる各観測量の層上で、§4.9 から標準スカラー方程式のパンルヴェ性を導く。

**検証事項**

- 表示が 10 行、境界型が 8 種あり、D₆ と E₇ がそれぞれ二つの表示を持つことを確認する。
- PV の文献の検証点 t = 1, q = 2, p = 0, θ₀ = 0, θ₁ = 1, θ∞ = 1 では、両立する消去は q″ = 2 を与え、印刷された 7/2 とは異なる。
- 上記の標準 PI へのスケーリングは q と t の両方を変える。t のみをスケーリングしても、q² の係数 6 は得られない。
- PII の二つの線形系による表示は、異なる局所特異点データを持つ。スカラー解の式が等しいことは、入力対象が等しいことではない。
- γ = 4, δ = −4 に対する PIII の比較は、非零のスケーリングによって γ = δ = 0 を覆うことができない。後者は §7.3 の境界解析に属する。

*必要な先行結果：* 内部依存：3.4, 3.5, 3.6, 3.7, 3.8, 3.9, 3.10, 3.11, 3.12, 4.8, 4.9, 5.2, 7.1.

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

PIII の場合分けがすべての係数組を覆うことを証明する。二つの初等的条件は重なりうるため、一つの境界類にまとめる。指定した時間・観測量の領域上で、枝と積分定数を保持して境界における積分を導く。四つの係数がすべて零である PIII は、ℂ* の選んだ被覆上で q = C exp(μ log t) を与え、その非零解の領域も含めて扱う。一般のこのような冪は ℂ* 上の一価関数ではない。q を含む分母を払って導入された零解・定数解については、元の方程式の領域を別に確認する必要がある。これらの初等的な枝を、元の方程式の定義域とともに、全係数組の分類に含める。

*必要な先行結果：* 内部依存：7.1, 7.2; [Formal scalar and vector-valued Laurent algebra](#dependency-formal-series) (L1–L4; L5–L6 for finite-extension steps in 1.1); [Covering spaces and universal covers](#dependency-covers) (Stage 0.2–0.4; Stage 1.5; Stage 2.6–2.8).

<a id="target-7-4"></a>
### 7.4 ハミルトニアン、シグマ方程式、線形系による実現

**パンルヴェへの適用。**

**入力条件**

- 幾何学的変換、行列式の変分、および座標比較の結果を、それぞれの実際の定義域で用いる。文献の符号比較と PV の消去補題、および PI・PII のハミルトニアンの正規化は §7.2 が供給する。シグマ形式からの再構成には、パラメータを固定し、連結な開時間領域上で以下の明示的な解析性・非退化性条件を課す。

§7.2 の全 10 表示について、同項目で証明した文献との局所比較を用い、h と ω からハミルトン系を、同じ局所代表族上の強い全接続から Lax 対の両立条件を導く。時間のみに依存するハミルトニアンへの加法項、タウ関数の乗法的正規化、および枝の選択を追跡する。§§5.4–5.5 の各幾何学的変換 g について座標表示 Ψ_g を構成し、§7.2 のチャート c,c′ の実際の共通定義域上で c′ ∘ F̄_g = Ψ_g ∘ c を証明する。零分母のうち、別の相空間チャートによって解消されるものと、幾何学的写像そのものの不定性に属するものを同定する。スカラーのジェット変数変換には、§7.1 のジェット逆写像をその指定された領域で用いる。（VDPS09, §4; IIS06, Theorem 10.13; BERT17, Proposition 2.3 and Theorem 3.3.）

σ 表示の比較には、次の 8 つの標準モデルからなる有限の一覧を用いる。パラメータと正準座標は各行に固有のものとし、s = σ, u = σ′, v = σ″ と置く。各モデルの Hamilton 方程式は q′ = K_p, p′ = −K_q である。IMS18 は ℏ = 1 で用いるが、その σ 関数を Hamiltonian 自体とは同一視しない。PI と PII には、以下の具体的逆構成で用いる DLMF の規約を採用する。これらの σ 観測量を、§7.2 で証明する変数変換とその定義域を通じて、Flaschka–Newell 表示と退化 PV 表示に移す。

| モデル | 固定する Hamiltonian と σ 観測量 S(t,q,p) | σ 関係の正確な式 |
|---|---|---|
| PI | K = p²/2 − 2q³ − tq; S = K | DLMF 32.6.6。定義は 32.6.5、逆構成は 32.6.7–8 |
| PII | K = p²/2 − (q² + t/2)p − c q, c = α + 1/2; S = K | DLMF 32.6.13。Hamiltonian は 32.6.9、逆構成は 32.6.14–15 |
| PIII(D₆) | IMS18 (2.18) を ℏ = 1 で用いる。(2.19) に従い S = tK + pq | IMS18 (2.20) |
| PIII(D₇) | K = (q²p² + θqp + tp − q)/t; S = tK | E₇ = t²v² − (θu − 1)² − 4u²(s − tu) = 0 |
| PIII(D₈) | K = (q²p² − q − t/q)/t; S = tK | E₈ = t²v² + 4tu³ − 4su² + 4u = 0 |
| PIV | IMS18 (2.21)。(2.22) に従い S = K + 2t(θ₀ + θ∞/3) | IMS18 (2.23)。同式に記載された 3 つの σ パラメータを用いる |
| PV | IMS18 (2.24); S = tK | IMS18 (2.26)。同式に記載された ν₁, ν₂, ν₃ を用いる |
| PVI | 下式の K₁ を用いる。S = t(t − 1)K₀ + (θ_t² − θ∞²)t/4 − (θ₀² + θ_t² − θ₁² − θ∞²)/8 | IMS18 (2.30)。σ の定義は (2.28)–(2.29) |

PVI の行では A = θ₀ + θ₁ + θ_t と置き、次の有理 Hamiltonian の族を固定する。

```math
\begin{aligned}
t(t-1)K_\varepsilon={}&q(q-1)(q-t)p^2
 -\bigl[\theta_0(q-1)(q-t)+\theta_1q(q-t)
 +(\theta_t-\varepsilon)q(q-1)\bigr]p\\
&+\frac{(A-\theta_\infty)(A+\theta_\infty-2\varepsilon)}4(q-t)
 +\frac{[(t-1)\theta_0+t\theta_1](\theta_t-\varepsilon)}2.
\end{aligned}
```

力学には K₁ を用い、K₀ は上記の σ 観測量を定める式にのみ用いる。係数 −2ε、およびこの規約と IMS18 (2.27)、§7.2 の標準スカラー正規化との比較を本項目で証明する。X = ∂_t + K_p∂_q − K_q∂_p と置き、各行について固定した Hamiltonian から E(t,S,XS,X²S) = 0 を直接証明する。これが順方向の σ 表示の定理であり、スカラーのタウ関数の正規化には依存しない。

上記の D₇, D₈ の正準モデルを、VDPS09 の Hamilton 表示から次の変数変換によって導く。D₇ には VDPS09 (18)–(21) を用い、その座標を (r,z)、θ∞ を λ と書く。θ = λ + 2, q = 1/r, p = −z − θr/2 − tr²/2 と置く。D₈ には VDPS09 (23)–(26) を用い、q = r, p = (z + r/2)/r² と置く。この行の K は、変換した出典の Hamiltonian の負に 1/(4t) を加えたものである。tr ≠ 0 上で両変換が一階系を可換にし、代入から E₇, E₈ が得られることを証明する。時間だけに依存する Hamiltonian の補正項も保持する。

| モデル | §7.2 の標準スカラー方程式との辞書 |
|---|---|
| PI | T = t, Q = q |
| PII | T = t, Q = q; α = c − 1/2 |
| PIII(D₆) | T = t, Q = q; (α,β,γ,δ) = (4θ₀, 4(1 − θ∞), 4, −4) |
| PIII(D₇) | t = T², Q(T) = T/q(T²); (α,β,γ,δ) = (4(θ − 1), −8, 4, 0) |
| PIII(D₈) | t = T², Q(T) = q(T²)/T; (α,β,γ,δ) = (8, −8, 0, 0) |
| PIV | T = t, Q = 2q; (α,β) = (2θ∞ − 1, −8θ₀²) |
| PV | T = t, Q = q; (α,β,γ,δ) = ((θ₀ − θ₁ − θ∞)²/8, −(θ₀ − θ₁ + θ∞)²/8, θ₀ + θ₁ − 1, −1/2) |
| PVI | T = t, Q = q; (α,β,γ,δ) = ((θ∞ − 1)²/2, −θ₀²/2, θ₁²/2, (1 − θ_t²)/2) |

時間を二乗する比較では、非零領域の被覆と選択した枝を保持する。共通チャート上の q′ = K_p を用いて運動量の比較を構成する。スカラー方程式のパラメータの対応と、指定した倍率と時間だけに依存する補正を含めた拡大 2 形式の一致を、それぞれ証明する。

各モデルに対する局所的な逆向きの定理を、次のように構成する。S₀ = S, S₁ = XS, S₂ = X²S と置き、Δ = (∂_qS₀)(∂_pS₁) − (∂_pS₀)(∂_qS₁) を定義する。Δ ≠ 0 かつ E_v(t,S₀,S₁,S₂) ≠ 0 を満たす相空間の点 x₀ で、固定した写像 (t,q,p) ↦ (t,S₀,S₁) に正則逆写像定理を適用し、逆写像が定義される近傍とその枝 I_{x₀} を構成する。順方向の恒等式と陰関数定理により、(t₀,S₀(x₀),S₁(x₀),S₂(x₀)) における E = 0 の芽が、I_{x₀} で移した S₂ のグラフに一致することを証明する。この芽に属する正則な σ 解に対して、(q(t),p(t)) = I_{x₀}(t,σ(t),σ′(t)) と定義する。S₀, S₁ を微分すると、i = 0,1 について dS_i((q′,p′) − (K_p,−K_q)) = 0 を得る。行列式 Δ が非零であることから、両 Hamilton 方程式が従う。x₀ を逆写像の枝のデータとして保持し、構成した近傍上で両方向の逆写像の法則とパラメータに関する解析的依存を証明する。

これらの仮定は具体的な十分条件を持つ開領域を定める。PI, PII, PIV では Δ = −S₂, E_v = 2v、PV, D₇, D₈ では Δ = −tS₂, E_v = 2t²v、PIII(D₆) では Δ = S₁ − tS₂, E_v = 2t(tv − u) である。PVI では上記の行列式 Δ と E_v = 2u t²(t − 1)²v を用いる。したがって、Hamiltonian の定義域内で追加する条件は、それぞれ v ≠ 0、t ≠ 0 かつ v ≠ 0、t ≠ 0 かつ tv − u ≠ 0、および t(t − 1)uvΔ ≠ 0 である。D₈ の Hamiltonian には q ≠ 0 も必要である。以下の PI, PII の連結な枝に対する逆構成は、具体的恒等式を用いてこれらの点ごとの条件より広い範囲を扱う。シグマ形式の結論は、順方向の恒等式、これらの局所的な逆写像の枝、および以下の PI・PII の連結な枝と一次関数の枝の解析からなる。逆構成の分母の零点を越えて再構成した相空間軌道を延長する場合は、幾何学的な相空間チャートの比較を証明する。

PI では、§7.2 の H_I に対して σ = H_I とおく。方程式は E_I = (σ″)² + 4(σ′)³ + 2tσ′ − 2σ = 0 であり、再構成は q = −σ′, p = −σ″ である（DLMF 32.6.2–32.6.8）。連結な開時間領域上で σ が正則で、σ″ が恒等的には零でないこと、同値に σ″ ≠ 0 となる点が存在することを仮定する。微分すると E_I′ = 2σ″(σ‴ + 6(σ′)² + t) となり、恒等定理から領域全体でハミルトン方程式を得る。E_I = 0 から H_I(q,p,t) = σ も証明する。除外される一次関数の枝はちょうど σ = at + 2a³ であり、対応する定数 q = −a は開時間領域上で PI を満たさない。特に σ ≡ 0 は余分なスカラー解である。

PII では c = α + 1/2 とし、§7.2 の H_II に対して σ = H_II とおく。u = σ′, v = σ″ とし、

```math
E=v^2+4u^3+2u(tu-\sigma)-c^2/4,\qquad
D=\sigma'''+6u^2+2tu-\sigma
```

と定める。シグマ方程式は E = 0 である（DLMF 32.6.13）。連結な開時間領域上で σ が正則で、v が恒等的には零でないことを仮定する。開部分 u ≠ 0 上で q = (2v+c)/(4u), p = −2u と定める（DLMF 32.6.14–32.6.15）。次の恒等式を証明する。

```math
E'=2vD,\qquad p'-(2qp+c)=0,
```

```math
q'-(p-q^2-t/2)=\frac{D}{2u}-\frac{E}{4u^2},\qquad
H_{\mathrm{II}}(q,p,t)-\sigma=\frac{E}{2u}.
```

v が恒等的には零でないので、E = 0 から恒等定理により D = 0 を得る。これにより u ≠ 0 上で両方のハミルトン方程式と H_II = σ が成り立つ。その各点で v ≠ 0 を仮定する必要はない。逆に、ハミルトン軌道について σ′ = −p/2, σ″ = 2qσ′ − c/2、したがって E = 0 を証明する。u の孤立零点では、再構成した軌道の相空間全体への延長とシグマ観測量との比較を、§4.6、§§4.8–4.9 およびチャート比較を用いて証明する。

v ≡ 0 の場合は σ = at+b と書ける。シグマ関係式は 4a³−2ab = c²/4 となる。a ≠ 0 なら b = 2a²−c²/(8a) だが、再構成された q = c/(4a), p = −2a は定数であり、開時間領域上で q′ = p−q²−t/2 と両立しない。a = 0 ならシグマ関係式は c = 0 を要求し、任意の b を許す。ハミルトニアンとの同一視には b = 0 が必要であり、このとき実際の Riccati 族 p = 0, q′ = −q²−t/2 はすべて σ ≡ 0 に写る。この族では相空間の初期点を保持する。異なる q の値が同じシグマ関数を与えるため、シグマのみからの逆写像はない。余分な一次関数のシグマ解と、この不変な Riccati 族上でシグマ観測量が単射でないことを区別する。

**構成・法則（API）**

- 有限のシグマ表示一覧について、指定された各シグマ観測量を構成し、その方程式とパラメータ・時間の比較を証明する。実際の非退化性条件と定義域を伴う、指定された逆写像の枝を構成する。
- PI・PII の順方向の恒等式、指定された一次関数でない解析的枝上の逆向き定理、および一次関数の枝の検証を証明する。PII の Riccati 族では相空間データを保持する。
- 座標変換 Ψ_g と F̄_g との可換図式を構成し、分母と幾何学的な定義域を比較する。
- §6.5 の固定された切断の係数と、それとは区別された正規化スカラー関数を用いて、ハミルトニアンとタウ関数の対数微分を比較する。

**検証事項**

- PII で c = 0, σ(t) = t+2 とすると E = 0, σ′ = 1 を満たすが、再構成された q = 0, p = −2 の第1ハミルトン方程式の残差は 2+t/2 である。t = 0 では残差が 2 であるにもかかわらず H_II = σ は成り立つ。この枝ではシグマ方程式、逆構成の分母の非消滅、およびハミルトニアンの恒等式がすべて成り立つ一方、ハミルトン方程式は成り立たない。
- PI の σ ≡ 0 はシグマ方程式を満たすが、得られる q ≡ 0 は PI を満たさない。σ″ が恒等的には零でないという条件はこの枝を除く。
- PII の c = 0 では、q′ = −q²−t/2 の異なる局所解がすべて同じ σ ≡ 0 を与える。逆構成には異なる相空間の初期点を保持する必要がある。
- 座標での Bäcklund 公式と降下させた変換は、共通の定義域上で同じ座標値を持たなければならない。一つのチャートで分母が零になることだけでは、幾何学的写像の不定性を判定できない。

*必要な先行結果：* 内部依存：3.11, 4.6, 4.8, 4.9, 5.4, 5.5, 6.4, 6.5, 7.1, 7.2, 7.3; [複素多様体・正則束・観測量](#dependency-complex) (K1; K3.0; K3.HolomorphicStalk; K3.MeromorphicGermField; K4; K7.1).

<a id="target-7-5"></a>
### 7.5 具体的な正規化と特殊解の検証

**パンルヴェへの適用。**

**入力条件**

- §7.2 の PI・PII の接続モジュライとの比較、ハミルトニアンの正規化、運動量の逆写像と、一階ジェット補題および許容された幾何学的変換を入力とする。例外的領域と Riccati パラメータ α=−1/2 を保持して、種となる解の恒等式を本項目で導く。

§7.2 のモジュライ比較で証明した PI の座標 H = p²/2 − 2q³ − tq と PII の座標 H = p²/2 − (q² + t/2)p − (α + 1/2)q を用い、§7.1 を適用する。PII のジェット逆写像は p = q′ + q² + t/2 である。この多項式座標はすべての有限の (q,q′) を覆い、極は他の相空間座標で扱う。§7.2 とのパラメータの対応を確立する。（VDPS09, §§4.10–4.11; DLMF, §§32.2, 32.6 および 32.9.）

証明した種となる対象に §§5.4–5.5 の許容される変換を施した軌道に属する、有理解と古典特殊関数解の族を構成し、その座標表示を導く。特殊解について構成する対象は、変換の定義域とパラメータ変化を保持した、これらの生成された族とする。

**検証事項**

- α = 0 では、q = 0, p = t/2 がこの座標で水平切断をなす。
- α = 1 かつ t ≠ 0 では、q = −1/t, p = 2/t² + t/2 が両方のハミルトン方程式を満たす。t = 0 での幾何学的延長には別の座標を用いる。
- α = −1/2 では、p = 0 が不変であり、q′ = −q² − t/2 となる。q = u′/u とおくと、u ≠ 0 上で u″ = −tu/2 を得る。これは §5.6 の射影的線形化であり、u の零点は ℙ¹ で解釈する。
- H ↦ H + c(t) は表示した水平軌道を保ち、§6.5 の恒等式が適用されるとき、正規化されたハミルトニアンによるタウ代表を対応する原始関数の指数因子だけ変える。

*必要な先行結果：* 内部依存：5.4, 5.5, 5.6, 6.5, 7.1, 7.2, 7.3, 7.4.

#### 例

幾何学的に正則な初期点において、スカラー方程式に見かけの分母が現れることがある。また、分母を払った多項式恒等式が、元の方程式には存在しない関数を解として持つこともある。一階ジェット座標と観測量の重なりの写像を用いて、幾何学的な延長とこれらの余分なスカラー解を区別し、実際の定義域上で解の芽を比較する。

### 参考文献

- **I13.** Michi-aki Inaba. *[Moduli of parabolic connections on a curve and Riemann–Hilbert correspondence](https://arxiv.org/abs/math/0602004v2)*. Journal of Algebraic Geometry 22 (2013), 407–480. 引用版： arXiv math/0602004v2, 6 June 2012; Theorems 2.1–2.2, preprint pp. 5–6; Definition 4.3; §§1, 4, 6. 族の固有性定理では、指数パラメータを保持したファイバー積と、正確な数値・安定性の仮定を用いる。

- **I23.** Michi-aki Inaba. *[Moduli Space of Factorized Ramified Connections and Generalized Isomonodromic Deformation](https://sigma-journal.com/2023/013/)*. SIGMA 19 (2023), 013, 72 pages. 出版社版、2023年3月22日。参照箇所：Definitions 2.1–2.8; Remark 2.9; Theorems 5.1, 7.5, 8.1, 9.7 and 11.6; equation (6.9); Propositions 3.3, 6.3, 7.2, 8.2–8.3, 10.7 and 10.10; Definitions 10.1 and 11.4; Corollaries 4.3–4.4, 9.11 and 11.8; equations (8.2), (11.2) and (11.5).

- **IS12.** Michi-aki Inaba; Masa-Hiko Saito. *[Moduli of unramified irregular singular parabolic connections on a smooth projective curve](https://arxiv.org/abs/1203.0084v3)*. Kyoto Journal of Mathematics 53(2) (2013), 433–482. 引用版：arXiv 1203.0084v3（2012年11月22日）。文献キーにはプレプリントの年を残す。参照箇所：Theorem 5.1; Remark 6.3.

- **HEU10.** Viktoria Heu. *[Universal isomonodromic deformations of meromorphic rank 2 connections on curves](https://www.numdam.org/item/AIF_2010__60_2_515_0/)*. Annales de l'Institut Fourier 60(2) (2010), 515–549. NUMDAMで公開された出版本文。誌面pp. 515–549。参照箇所：Theorem 1.1; Definitions 2.3 and 2.10; §2.

- **VDPS09.** Marius van der Put; Masa-Hiko Saito. *[Moduli spaces for linear differential equations and the Painlevé equations](https://arxiv.org/abs/0902.1702v5)*. Annales de l'Institut Fourier 59(7) (2009), 2611–2667. 引用版：arXiv 0902.1702v5（2009年11月12日）。全形式の符号とPV消去式の訂正は§7.2で証明する。参照箇所：§2.2, Table 1, preprint pp. 18–19; §3; §4.1 and §§4.3–4.11; equations (12), (17) and (22).

- **IIS06.** Michi-aki Inaba; Katsunori Iwasaki; Masa-Hiko Saito. *[Dynamics of the Sixth Painlevé Equation](https://arxiv.org/abs/math/0501007v2)*. Séminaires et Congrès 14 (2006), 103–167. 引用版：arXiv math/0501007v2（2005年3月6日）。参照箇所：Definitions 2.1–2.2 and 2.11; Lemma 2.12; Definitions 3.5 and 4.9; Theorems 4.10–4.12, 5.15–5.16, 7.4, 10.6, 10.10 and 10.13; §§5, 7 and 10.

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

- **IMS18.** Kohei Iwaki; Olivier Marchal; Axel Saenz. *[Painlevé equations, topological type property and reconstruction by the topological recursion](https://arxiv.org/abs/1601.02517v7)*. Journal of Geometry and Physics 124 (2018), 16–54. 引用版：arXiv 1601.02517v7（2017年10月9日）、§2.2、equations (2.18)–(2.30)、ℏ = 1。Hamiltonianとσの規約、およびPVIの係数とスカラー方程式との比較は§7.4に定める。

- **DLMF.** P. A. Clarkson, *[Painlevé Transcendents, Chapter 32 of the NIST Digital Library of Mathematical Functions](https://dlmf.nist.gov/32)*. Version 1.2.8、2026年9月15日公開。[§32.2](https://dlmf.nist.gov/32.2), equations 32.2.1–32.2.6; [§32.6](https://dlmf.nist.gov/32.6); [§32.7](https://dlmf.nist.gov/32.7); [§32.9](https://dlmf.nist.gov/32.9)、特にequations 32.9.6 and 32.9.12。標準的スカラー表示と正規化の参照先。
