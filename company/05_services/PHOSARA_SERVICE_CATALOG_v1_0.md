# PHOSARA サービスカタログ v1.0

**全販売サービスの定義 — ACTIVE正典**

## Document Metadata

| Metadata | Value |
|---|---|
| Document ID | PHOSARA_SERVICE_CATALOG_v1_0 |
| Document Name | PHOSARA サービスカタログ v1.0 |
| Version | v1.0 |
| Status | ACTIVE |
| Owner | PHOSARA HQ Owner |
| Approver | PHOSARA Owner |
| Created Date | 2026-07-15 |
| Last Updated | 2026-07-17 |
| Effective Date | 2026-07-17 |
| Supersedes | None |
| Canonical Path | `company/05_services/PHOSARA_SERVICE_CATALOG_v1_0.md` |
| Approval Requirement | Owner Type 1 Approval and Decision Record Required |
| Document Type | Canonical Document |
| Pricing | 本書では価格額を定めない |
| Initial Sales Scope | Launch Services 12種 |
| Priority Industries | 建築会社・工務店／リフォーム会社／整体院・整骨院／パチンコホール |

---

# 1. Purpose

本書は、PHOSARAが「何を販売する会社なのか」を明確にし、販売可能なサービスと提供境界を一元管理するACTIVEな領域別正典である。

本書は次を定める。

- 営業開始時点から販売できるLaunch Services
- 条件審査後に受注できるConditional Services
- 将来提供するFuture / Enterprise Services
- 独立商品として販売しないもの
- Business Auditと各サービスの関係
- 単品サービスの販売条件
- 標準成果物、顧客責任、検収条件、非提供範囲
- WIPと供給能力の上限
- サービスの追加・昇格・成長・退役・Archive規則
- Pricing Governance、Contract System、AI Companyへの引渡し条件

本書は価格額、契約条文、営業会話、AIの具体的な実装方法を定めない。

## 1.1 Normative Keywords

本書では、ガバナンス上重要な規則に限り、次の統制語を使用する。通常の説明文やサービス紹介を機械的に統制語へ置き換えない。

| 統制語 | 日本語上の意味 |
|---|---|
| MUST | 必ず実施しなければならない。例外には事前のオーナー承認と記録を要する |
| MUST NOT | 実施してはならない。例外を黙示的に認めない |
| SHOULD | 原則として実施すべきである。実施しない場合は合理的理由を記録する |
| SHOULD NOT | 原則として実施すべきでない。実施する場合は合理的理由を記録する |
| MAY | 条件を満たす場合に実施してよい。義務ではない |

本書における「必須」「禁止」「してはならない」は、それぞれMUSTまたはMUST NOTと同等の拘束力を持つ。

## 1.2 Definitions

| 用語 | 定義 |
|---|---|
| Business Audit | 複数の証拠源と定義済み診断領域を用いて事業状態を評価し、優先課題、戦略的方向、改善順序を確定するPHOSARAの旗艦診断サービス |
| Launch Service | 標準成果物、提供境界、顧客責任、検収、価格モデル、供給条件が定義され、営業開始時点から通常販売できるサービス |
| Conditional Service | 正式なサービス候補として存在するが、案件条件、外部協力、保守、法務、セキュリティ等の事前審査後にのみ受注できるサービス |
| Future / Enterprise Service | 将来の正式提供候補。通常営業、Web掲載、積極販売、公式価格設定を現時点では行わないサービス |
| Do Not Offer | PHOSARAの独立商品として販売しない技術要素、外部委託領域、禁止行為または非提供領域 |
| Standalone Service | Business Auditや他サービスとの同時購入を必須とせず、単独の成果物と顧客価値を定義して販売できるサービス |
| Specialist Assessment | 対象領域の専門診断。Business Audit全体を実施しない場合でも、Brand、Website、AI、規制、現状評価等の必要領域を実装前に確認する工程 |
| Human Approval | AIや自動処理だけでは完了できず、権限を持つ人間が内容を確認して承認、差戻しまたは却下する統制点 |
| Owner Approval | PHOSARAオーナー本人による最終承認。価格、契約、監査確定、公開、分類変更等の専権事項を含む |
| WIP | Work in Progress。品質、納期、収益性を守るために同時進行を許可する案件または契約の量 |
| PBOS | PHOSARA Business Operating System。需要、収益、納品、継続、知識、資産化を循環させる事業運転システム |
| Success KPI | サービスが意図した事業成果または運用品質へ近づいているかを測る主要指標。成果保証ではない |
| Acceptance Criteria | 成果物が契約上の納品・検収条件を満たしたと判断するための、事前合意された客観的基準 |
| Customer Responsibilities | 情報、素材、アクセス、参加、事実確認、承認等、サービス履行のために顧客が担当する義務 |

## 1.3 Reference Documents

### 現行正典・採用済み参照文書

| 領域 | 文書 | リポジトリパス | 本書との関係 |
|---|---|---|---|
| ブランド | Master Context | `docs/00_ブランド基盤/PHOSARA_MASTER_CONTEXT_v1.0_JP_日本語版.md` | ブランド理念、サービス思想、提供・非提供領域の上位基準 |
| 会社憲法 | Company OS v2.0 | `company/02_company-os/PHOSARA_COMPANY_OS_v2_0.md` | 財務、法務、品質、AI利用、リスクの上位基準 |
| 判断 | HQ Core v1.0 | `company/01_hq-core/PHOSARA_HQ_CORE_v1_0.md` | 優先順位、Type 1、委譲、WIP、投資の上位基準 |
| 事業運転 | PBOS Gold Edition | `docs/08_PBOS/PHOSARA_PBOS_Gold_Edition.md` | Revenue Loop、Asset Loop、継続、計測との接続 |
| 現行価格 | Pricing Governance v1.0 | `company/06_pricing/PHOSARA_PRICING_GOVERNANCE_v1_0.md` | 現行価格正典。本書は価格額を変更しない |
| 契約 | Contract System v1.0 | `company/07_contracts/PHOSARA_CONTRACT_SYSTEM_v1_0.md` | 契約類型、条項、検収、責任分界への引渡し先 |
| 監査教義 | Business Audit Guide v1.0 | `docs/02_コンサルティング/事業監査/Business_Audit_Guide_v1.0_日本語版.md` | Business Auditの教義と診断原則 |
| 営業 | Sales Playbook v2 | `company/04_sales/SALES_PLAYBOOK_v2.md` | サービス販売と顧客説明の実務参照 |
| AI組織 | AI Company OS v1.0 | `company/13_ai-company/PHOSARA_AI_COMPANY_OS_v1.md` | AI従業員の職務、状態、報告、承認の上位基準 |
| 人間承認 | Human Approval | `company/13_ai-company/implementation/HUMAN_APPROVAL.md` | AI実行における人間承認点の実装基準 |

### 採用候補・未発効参照文書

| 文書 | リポジトリパス | 状態 | 本書での扱い |
|---|---|---|---|
| Pricing Governance v2.0 | `PHOSARA_PRICING_GOVERNANCE_v2.0.md` | 未追跡・DRAFT-FOR-ADOPTION・未発効 | 将来のHandoff候補。現行価格正典として扱ってはならない |

---

# 2. Position in Canonical Governance

## 2.1 正式採用後の位置

本書は、上位Governanceから事業方針を受け取り、PHOSARAが販売できるサービスへ変換する領域別正典である。

```text
Master Context
  ブランド理念・使命・価値・非提供領域
        ↓
Company OS
  会社憲法・財務・法務・リスク・品質
        ↓
HQ Core
  意思決定・優先順位・投資・委譲・承認
        ↓
Service Catalog
  何を正式サービスとして販売するか
        ↓
Pricing Governance
  どの価格モデル・条件で販売するか
        ↓
Contract System
  どの契約類型・条項で提供するか
        ↓
Sales Playbook / Owner Sales Handbook
  誰に、いつ、どのように説明・販売するか
        ↓
Business Audit Kit / Website / AI Company / PBOS / Runtime
  診断・制作・運転・改善をどのように実行するか
```

## 2.2 権威の範囲

本書は次の問いに対する唯一の正である。

- そのサービスはPHOSARAの正式商品か
- 現在販売できるか
- 条件付きでのみ受注できるか
- 将来候補か
- 独立商品として販売しないものか
- Business Auditを先行させる必要があるか
- 単品販売できるか
- 標準成果物、顧客責任、検収条件、非提供範囲は何か

価格額はPricing Governance、契約条文はContract Systemを正とする。

## 2.3 現在の効力

本書は、`DR-2026-07-17-001`により2026-07-17付で正式採択され、同日からACTIVEなCanonical Ruleとして発効する。

---

# 3. PHOSARA Service Philosophy

## 3.1 事業定義

PHOSARAは制作物を販売する会社ではない。

PHOSARAは、顧客の事業に存在する見えない課題と価値を可視化し、優先順位を定め、必要な解決策を設計・実装・改善する経営改善会社である。

Website、Brand、Design、GBP、AI等は、事業課題を解決するための手段である。手段そのものを既定解として販売しない。

## 3.2 Business Audit First

Business Auditを、PHOSARAが最も推奨する主力入口商品とする。

Business Auditは、次の場合に特に推奨する。

- 課題が複数領域にまたがる
- 投資の優先順位が不明
- 顧客が特定の制作物を既定解としている
- 過去の施策が成果につながっていない
- 経営者と現場の認識が異なる
- 高額、長期または高リスクの実装を検討している

Business Auditは他サービスを販売するための無料前工程ではない。それ自体で顧客価値が成立する独立商品である。

## 3.3 単品サービス

単品サービスを第二の正式入口として認める。ただし、単品販売を主力にはしない。

解決すべき事業課題、目的、対象顧客、対象範囲、KPIまたは検収条件、顧客責任、意思決定者、非提供範囲が明確な案件に限り、単品サービスを販売できる。

## 3.4 媒体非中心

PHOSARAは媒体やツールを中心に販売しない。

- Websiteではなく、信頼・理解・問い合わせの改善を販売する
- Designではなく、価値の可視化と行動の改善を販売する
- SNSではなく、継続的な認知と関係形成を販売する
- AIではなく、業務品質・速度・再現性の改善を販売する

## 3.5 提供範囲の規律

PHOSARAは、戦略、診断、設計、クリエイティブ、デジタル実装、改善、限定的なAI導入を提供する。

原則として次は提供しない。

- 印刷、配送、施工、建設
- 法務・税務・労務判断
- 効果、検索順位、売上、AI精度の保証
- 口コミ操作
- 人間承認を排除した高リスクAI
- 目的のないツール導入

---

# 4. Service Architecture

PHOSARAのサービスは、次の5領域で構成する。この構造はOffer Ladderの番号や価格段階を定めるものではない。

```text
1. Diagnose — 診断
   課題と投資優先順位を明らかにする

2. Design — 戦略・解決策設計
   目標、順序、範囲、KPI、検収条件を定める

3. Implement — 可視化・顧客接点の実装
   Brand、Design、Content、Website、GBP等を実装する

4. Grow — 継続成長
   KPIに基づいて改善を継続する

5. Enable — AI活用
   限定業務へ安全にAIを導入し、効果と運用条件を検証する
```

## 4.1 Service Matrix

本MatrixはLS、CS、FSを横断し、Lifecycle、販売可否、Audit Route、価格状態、WIPとの関係を一覧化する。Launch ServiceのCurrent Availabilityは本書の発効後の状態を示し、ConditionalおよびFutureのLifecycleは変更しない。

| Service Code | Service Name | Lifecycle | Standalone Sale | Audit Route | Primary Customer | Pricing Status | WIP対象 | Current Availability |
|---|---|---|---|---|---|---|---|---|
| LS-01 | PHOSARA事業監査 | Launch | YES | SELF | 全優先業種 | 価格モデルのみ定義・価格額は本書外 | 同時1件 | 通常販売可 |
| LS-02 | Webサイト事業成果診断 | Launch | YES | Optional | Website課題が限定された事業者 | 価格モデルのみ定義・価格額は本書外 | 個別案件WIP管理 | 通常販売可 |
| LS-03 | ブランド明確性診断 | Launch | YES | Optional | Brand課題が限定された事業者 | 価格モデルのみ定義・価格額は本書外 | 個別案件WIP管理 | 通常販売可 |
| LS-04 | 解決策設計 | Launch | CONDITIONAL | Recommended | 課題・目標・根拠が確定した事業者 | 価格モデルのみ定義・価格額は本書外 | 個別案件WIP管理 | 適用条件を満たす場合に販売可 |
| LS-05 | ブランド戦略・アイデンティティ設計 | Launch | CONDITIONAL | Specialist Assessment Required | ブランド再設計を必要とする事業者 | 価格モデルのみ定義・価格額は本書外 | 高負荷案件として調整 | 専門診断を経て販売可 |
| LS-06 | 販促コミュニケーションデザイン | Launch | YES | Optional | 販促テーマと媒体が明確な事業者 | 価格モデルのみ定義・価格額は本書外 | 個別案件WIP管理 | 通常販売可 |
| LS-07 | 営業コミュニケーション資料設計 | Launch | YES | Recommended | 商談・説明資料を必要とする事業者 | 価格モデルのみ定義・価格額は本書外 | 個別案件WIP管理 | 通常販売可 |
| LS-08 | 事業コンテンツ制作 | Launch | YES | Optional | 事例・専門知を資産化する事業者 | 価格モデルのみ定義・価格額は本書外 | 個別案件WIP管理 | 通常販売可 |
| LS-09 | 事業Webサイト設計・構築 | Launch | CONDITIONAL | Recommended | Websiteが正当な解決策となる事業者 | 価格モデルのみ定義・価格額は本書外 | 本格制作同時1件 | 適用条件を満たす場合に販売可 |
| LS-10 | 地域検索・店舗情報最適化 | Launch | YES | Optional | 来店・地域検索型の事業者 | 価格モデルのみ定義・価格額は本書外 | 個別案件WIP管理 | 通常販売可 |
| LS-11 | PHOSARA事業成長プログラム | Launch | CONDITIONAL | Specialist Assessment Required | 継続改善とKPI運用を必要とする事業者 | 価格モデルのみ定義・価格額は本書外 | 継続支援全体で最大3社 | 現状評価と容量確定後に販売可 |
| LS-12 | AI業務導入スプリント | Launch | CONDITIONAL | Specialist Assessment Required | 限定反復業務と適法な検証データを持つ事業者 | 価格モデルのみ定義・価格額は本書外 | 同時1件 | AI専門評価を経て販売可 |
| CS-01 | Marketing & Channel Audit | Conditional | 通常不可 | 案件別審査 | 複数チャネル課題とデータを持つ事業者 | 個別公式価格なし・共通見積規則のみ | 案件別審査 | 本書採択後も条件審査・Owner承認時のみ |
| CS-02 | AI & Automation Readiness Audit | Conditional | 通常不可 | 案件別審査 | AI・Automationの準備状況を確認する事業者 | 個別公式価格なし・共通見積規則のみ | 案件別審査 | 本書採択後も条件審査・Owner承認時のみ |
| CS-03 | Business Strategy | Conditional | 通常不可 | 案件別審査 | 経営者参加と経営情報提供が可能な事業者 | 個別公式価格なし・共通見積規則のみ | 案件別審査 | 本書採択後も条件審査・Owner承認時のみ |
| CS-04 | Measurement & KPI Design | Conditional | 通常不可 | 案件別審査 | 計測対象とデータ源を持つ事業者 | 個別公式価格なし・共通見積規則のみ | 案件別審査 | 本書採択後も条件審査・Owner承認時のみ |
| CS-05 | Customer Journey Design | Conditional | 通常不可 | 案件別審査 | 顧客接点と現場工程を確認できる事業者 | 個別公式価格なし・共通見積規則のみ | 案件別審査 | 本書採択後も条件審査・Owner承認時のみ |
| CS-06 | Communication Strategy | Conditional | 通常不可 | 案件別審査 | 事業方針と顧客像が確定した事業者 | 個別公式価格なし・共通見積規則のみ | 案件別審査 | 本書採択後も条件審査・Owner承認時のみ |
| CS-07 | Visual Identity Design | Conditional | 通常不可 | 案件別審査 | ブランド核が確定した事業者 | 個別公式価格なし・共通見積規則のみ | 案件別審査 | 本書採択後も条件審査・Owner承認時のみ |
| CS-08 | Photography Direction & Production | Conditional | 通常不可 | 案件別審査 | 撮影目的・媒体・必要カットが明確な事業者 | 個別公式価格なし・共通見積規則のみ | 外部協力を含め案件別審査 | 本書採択後も条件審査・Owner承認時のみ |
| CS-09 | Video & Motion Content | Conditional | 通常不可 | 案件別審査 | 動画用途・配信先・権利条件が明確な事業者 | 個別公式価格なし・共通見積規則のみ | 外部協力を含め案件別審査 | 本書採択後も条件審査・Owner承認時のみ |
| CS-10 | AI Creative Production | Conditional | 通常不可 | 案件別審査 | AI利用・権利・監修条件に同意する事業者 | 個別公式価格なし・共通見積規則のみ | 案件別審査 | 本書採択後も条件審査・Owner承認時のみ |
| CS-11 | Sign & Spatial Communication Planning | Conditional | 通常不可 | 案件別審査 | 店舗・施設の視認・動線課題を持つ事業者 | 個別公式価格なし・共通見積規則のみ | 外部協力を含め案件別審査 | 本書採択後も条件審査・Owner承認時のみ |
| CS-12 | Landing Page | Conditional | 通常不可 | 案件別審査 | オファー・流入経路・KPIが明確な事業者 | 個別公式価格なし・共通見積規則のみ | 案件別審査 | 本書採択後も条件審査・Owner承認時のみ |
| CS-13 | SEO Foundation & Optimization | Conditional | 通常不可 | 案件別審査 | 検索需要と健全なWebsite基盤を持つ事業者 | 個別公式価格なし・共通見積規則のみ | 案件別審査 | 本書採択後も条件審査・Owner承認時のみ |
| CS-14 | SNS Strategy & Enablement | Conditional | 通常不可 | 案件別審査 | 素材供給者と運用担当者がいる事業者 | 個別公式価格なし・共通見積規則のみ | 案件別審査 | 本書採択後も条件審査・Owner承認時のみ |
| CS-15 | LINE Customer Engagement | Conditional | 通常不可 | 案件別審査 | 顧客リスト・同意・利用目的が明確な事業者 | 個別公式価格なし・共通見積規則のみ | 案件別審査 | 本書採択後も条件審査・Owner承認時のみ |
| CS-16 | Advertising Strategy & Operations | Conditional | 通常不可 | 案件別審査 | 受け皿・粗利・LTV・計測が整う事業者 | 個別公式価格なし・共通見積規則のみ | 保守を含め案件別審査 | 本書採択後も条件審査・Owner承認時のみ |
| CS-17 | Recruitment Communication | Conditional | 通常不可 | 案件別審査 | 採用伝達を主要課題とする事業者 | 個別公式価格なし・共通見積規則のみ | 案件別審査 | 本書採択後も条件審査・Owner承認時のみ |
| CS-18 | Customer Experience Improvement | Conditional | 通常不可 | 案件別審査 | 現場観察と責任者参加が可能な事業者 | 個別公式価格なし・共通見積規則のみ | 案件別審査 | 本書採択後も条件審査・Owner承認時のみ |
| CS-19 | Business Process Improvement | Conditional | 通常不可 | 案件別審査 | 経営者と現場責任者が参加できる事業者 | 個別公式価格なし・共通見積規則のみ | 案件別審査 | 本書採択後も条件審査・Owner承認時のみ |
| CS-20 | Continuous Digital Optimization | Conditional | 通常不可 | 案件別審査 | 対象チャネルと月次容量を限定できる事業者 | 個別公式価格なし・共通見積規則のみ | 継続支援上限内で案件別審査 | 本書採択後も条件審査・Owner承認時のみ |
| FS-01 | CRM & Customer Data Design | Future | NO | 対象外 | 将来の実証・保守条件を満たす顧客 | 未設定・価格提示不可 | 販売不可 | 現在販売不可 |
| FS-02 | Workflow Automation | Future | NO | 対象外 | 将来の実証・監視・復旧条件を満たす顧客 | 未設定・価格提示不可 | 販売不可 | 現在販売不可 |
| FS-03 | LINE Automation | Future | NO | 対象外 | 将来のAPI・同意・連携条件を満たす顧客 | 未設定・価格提示不可 | 販売不可 | 現在販売不可 |
| FS-04 | Internal AI & Knowledge Assistant | Future | NO | 対象外 | 将来の内部安定運転条件を満たす顧客 | 未設定・価格提示不可 | 販売不可 | 現在販売不可 |
| FS-05 | AI Agent Design & Implementation | Future | NO | 対象外 | 将来のAgent統制条件を満たす顧客 | 未設定・価格提示不可 | 販売不可 | 現在販売不可 |
| FS-06 | AI & System Integration | Future | NO | 対象外 | 将来の統合・セキュリティ条件を満たす顧客 | 未設定・価格提示不可 | 販売不可 | 現在販売不可 |
| FS-07 | Continuous AI Optimization | Future | NO | 対象外 | 将来の継続AI運用条件を満たす顧客 | 未設定・価格提示不可 | 販売不可 | 現在販売不可 |
| FS-08 | Enterprise Transformation | Future | NO | 対象外 | 将来の大型変革条件を満たす顧客 | 未設定・価格提示不可 | 販売不可 | 現在販売不可 |

---

# 5. Launch Services 12種

Launch Servicesは、営業開始時点からPHOSARAが正式に販売できるサービスである。

## 5.1 LS-01 PHOSARA事業監査

| 項目 | 定義 |
|---|---|
| 正式サービスID | LS-01 |
| Legacy Reference ID | DG-01 |
| 正式名称 | PHOSARA事業監査（PHOSARA Business Audit） |
| 一文説明 | 事業を証拠に基づいて診断し、最優先課題と次の一手を明確にする |
| 事業目的 | 誤った投資を防ぎ、資金と時間を最重要課題へ集中させる |
| 主対象 | 全優先業種 |
| Risk Level | HIGH |
| Risk Basis | 経営判断、監査スコア、優先課題、顧客投資判断に直接影響し、誤判定時の事業影響が大きい |
| Estimated WIP | HIGH |
| Typical Duration | 内部工程14日（現行Business Audit仕様。顧客待ち期間は別） |
| Dependencies | 契約・前払い入金／顧客資料／ヒアリング参加／必要な計測アクセス／Human Approval |
| Deliverable Owner | PHOSARA（監査確定責任：Owner） |
| オーナー承認レベル | ヒアリング実施、監査スコア、優先課題、最終報告は常にオーナー承認 |
| Success KPI | 監査完了率／顧客による優先課題の復唱／監査後の意思決定完了率／次工程転換率 |
| Standard Deliverables | ヒアリング記録／証拠索引／スコア根拠／監査報告書／6領域・11モジュール評価／証拠台帳／優先課題／戦略的方向／30・60・90日および1年の改善ロードマップ／Quick Win／納品面談 |
| Non-included Scope | 詳細実装設計／制作／継続運用／法務・税務・労務判断 |
| Business Audit Route | 本サービス自体 |
| Standalone Sales Policy | YES。それ自体で完結する旗艦商品 |
| Pricing Model | Fixed price |
| Customer Responsibilities | 事前資料の提出／ヒアリング参加／事実確認／必要な計測アクセスの提供／意思決定者の参加 |
| Acceptance Criteria | 合意した証拠源を確認し、報告書・優先課題・方向・ロードマップを納品面談で説明した時点 |

## 5.2 LS-02 Webサイト事業成果診断

| 項目 | 定義 |
|---|---|
| 正式サービスID | LS-02 |
| Legacy Reference ID | DG-02 |
| 正式名称 | Webサイト事業成果診断（Website Performance Audit） |
| 一文説明 | Websiteの事業整合、内容、導線、技術、SEO基礎、計測状態を限定診断する |
| 事業目的 | 改修・刷新・維持のどれが妥当かを判断する |
| 主対象 | 建築・工務店／リフォーム／整体・整骨院 |
| Risk Level | MEDIUM |
| Risk Basis | 技術・内容・導線の誤評価が不要な改修投資を招くが、診断対象はWebsite領域に限定される |
| Estimated WIP | MEDIUM |
| Typical Duration | To Be Defined in Pricing / Contract Design |
| Dependencies | 契約／対象URL／解析・管理アクセス／顧客の事業情報／Human Approval |
| Deliverable Owner | PHOSARA |
| オーナー承認レベル | 最終評価、優先改善項目、改修・刷新・維持判定はオーナー承認 |
| Success KPI | 主要問題の証拠化率／改善優先順位の合意／改修判断の完了／計測可能項目数 |
| Standard Deliverables | Website診断レポート／技術・内容・導線評価／証拠／優先改善項目／改修・刷新・維持判定 |
| Non-included Scope | Website実装／検索順位保証／事業全体の診断 |
| Business Audit Route | Optional |
| Standalone Sales Policy | YES。診断対象がWebsiteに限定されている場合 |
| Pricing Model | Price range |
| Customer Responsibilities | 対象URL・管理情報の提供／解析アクセスの提供／事業目的と主要顧客の説明／事実確認 |
| Acceptance Criteria | 合意した対象ページと診断項目を検査し、証拠付き優先改善レポートを提出した時点 |

## 5.3 LS-03 ブランド明確性診断

| 項目 | 定義 |
|---|---|
| 正式サービスID | LS-03 |
| Legacy Reference ID | DG-03 |
| 正式名称 | ブランド明確性診断（Brand Clarity Audit） |
| 一文説明 | 事業価値、言葉、見え方、接点間の一貫性を診断する |
| 事業目的 | 実力と市場からの見え方の差を特定する |
| 主対象 | 全優先業種 |
| Risk Level | MEDIUM |
| Risk Basis | ブランド評価は主観性と経営上の影響を伴うが、本サービスは診断に限定され実装を含まない |
| Estimated WIP | MEDIUM |
| Typical Duration | To Be Defined in Pricing / Contract Design |
| Dependencies | 契約／既存ブランド資産／経営者ヒアリング／主要接点／Human Approval |
| Deliverable Owner | PHOSARA |
| オーナー承認レベル | 最終評価、不整合判定、優先改善方針はオーナー承認 |
| Success KPI | 主要不整合の特定数／ブランド課題の合意／優先改善方針の確定率 |
| Standard Deliverables | ブランド診断／メッセージ評価／視覚評価／接点評価／不整合一覧／優先改善方針 |
| Non-included Scope | ロゴ制作／Brand Identity構築／成果保証 |
| Business Audit Route | Optional |
| Standalone Sales Policy | YES。診断対象がBrand領域に限定されている場合 |
| Pricing Model | Price range |
| Customer Responsibilities | 既存ブランド資産・営業資料・主要接点の提供／経営者ヒアリング参加／事実確認 |
| Acceptance Criteria | 合意した接点を評価し、不整合と改善優先順位を説明した診断書を提出した時点 |

## 5.4 LS-04 解決策設計

| 項目 | 定義 |
|---|---|
| 正式サービスID | LS-04 |
| Legacy Reference ID | ST-02 |
| 正式名称 | 解決策設計（Solution Design） |
| 一文説明 | 確定した課題を、実装可能な要件・範囲・工程・検収条件へ変換する |
| 事業目的 | 実装前の手戻り、追加費用、期待不一致を防ぐ |
| 主対象 | 全優先業種 |
| Risk Level | MEDIUM |
| Risk Basis | 要件・範囲・検収条件の欠落は後続実装の手戻りと採算悪化を招くが、本サービス自体は設計までに限定される |
| Estimated WIP | MEDIUM |
| Typical Duration | To Be Defined in Pricing / Contract Design |
| Dependencies | Business Audit推奨または確定済み課題／顧客制約・既存環境／契約／Human Approval |
| Deliverable Owner | PHOSARA |
| オーナー承認レベル | 解決策、対象範囲、除外、概算条件、実行順序はオーナー承認 |
| Success KPI | 要件未確定項目の解消率／実装時の追加変更率／顧客承認完了率／検収条件の明確性 |
| Standard Deliverables | 戦略1枚／解決策構成／カテゴリ選定／実装仕様書／要件／対象範囲／除外範囲／KPI／工程／顧客責任／検収項目案 |
| Non-included Scope | 成果物の実装／価格確定／契約締結 |
| Business Audit Route | Recommended |
| Standalone Sales Policy | CONDITIONAL。課題・目標・根拠が既に確定している場合のみ |
| Pricing Model | Price range |
| Customer Responsibilities | 事業情報・制約・予算条件・既存環境の提供／関係者参加／要件承認 |
| Acceptance Criteria | 実装対象、除外、KPI、工程、顧客責任、検収項目案が書面で承認された時点 |

## 5.5 LS-05 ブランド戦略・アイデンティティ設計

| 項目 | 定義 |
|---|---|
| 正式サービスID | LS-05 |
| Legacy Reference ID | BC-01 |
| 正式名称 | ブランド戦略・アイデンティティ設計（Brand Strategy & Identity） |
| 一文説明 | 事業の価値、立ち位置、言葉、視覚体系を一つのブランドとして設計する |
| 事業目的 | 価格競争を減らし、選ばれる理由を明確にする |
| 主対象 | 建築・工務店／リフォーム／パチンコホールを中心に全優先業種 |
| Risk Level | HIGH |
| Risk Basis | 事業の立ち位置、主要メッセージ、視覚体系を長期的に規定し、誤設計時の修正範囲とブランド影響が大きい |
| Estimated WIP | HIGH |
| Typical Duration | To Be Defined in Pricing / Contract Design |
| Dependencies | Brand Auditまたは初期ブランド診断／経営者参加／既存資産／商標情報／契約／Human Approval |
| Deliverable Owner | PHOSARA |
| オーナー承認レベル | ブランド核、ポジショニング、主要メッセージ、Visual Identityはオーナー承認 |
| Success KPI | ブランド核の経営者合意／主要接点の一貫性／メッセージ理解度／承認後の重大手戻り率 |
| Standard Deliverables | Brand Auditまたは初期ブランド診断／コンセプト案／ブランド核／ポジショニング／メッセージ／Visual Identity候補／検証資料／最終データ／基本使用ガイド／ブランド説明 |
| Non-included Scope | 商標登録手続／大規模市場調査／全接点への無制限展開 |
| Business Audit Route | Specialist Assessment Required |
| Standalone Sales Policy | CONDITIONAL。Brand Auditまたは初期ブランド診断を工程に含める |
| Pricing Model | Price range |
| Customer Responsibilities | 経営者参加／事業方針・既存資産の提供／商標情報の開示／各承認点での期限内回答 |
| Acceptance Criteria | 合意したブランド核、言語、視覚体系、基本使用規則が承認・納品された時点 |

## 5.6 LS-06 販促コミュニケーションデザイン

| 項目 | 定義 |
|---|---|
| 正式サービスID | LS-06 |
| Legacy Reference ID | BC-03 |
| 正式名称 | 販促コミュニケーションデザイン（Promotional Communication Design） |
| 一文説明 | 販促テーマを、顧客の理解と行動につながるグラフィックへ変換する |
| 事業目的 | 販促品質、来店、問い合わせ、店格を改善する |
| 主対象 | パチンコホールを中心に全優先業種 |
| Risk Level | LOW |
| Risk Basis | 成果物と媒体範囲を限定しやすく、検収可能である。規制表現はHuman Approvalで統制する |
| Estimated WIP | LOW |
| Typical Duration | To Be Defined in Pricing / Contract Design |
| Dependencies | 契約／掲載情報／顧客素材／媒体仕様／業界規制確認／Human Approval |
| Deliverable Owner | PHOSARA |
| オーナー承認レベル | 対外公開する最終デザイン、規制表現、ブランド適合はオーナー承認 |
| Success KPI | 納期遵守率／初回承認率／媒体展開の整合率／合意した行動指標の変化 |
| Standard Deliverables | 企画整理／ラフ案／承認用デザイン／最終デザインデータ／合意したサイズ展開／入稿用データ |
| Non-included Scope | 印刷／配送／施工／媒体費／無制限修正 |
| Business Audit Route | Optional |
| Standalone Sales Policy | YES。テーマ、用途、媒体、納期、成果物数が確定している場合 |
| Pricing Model | Price range |
| Customer Responsibilities | 正確な掲載情報・素材・媒体仕様の提供／法令上必要な確認／期限内承認 |
| Acceptance Criteria | 合意した仕様・サイズ・形式のデータが、承認済みデザインとして納品された時点 |

## 5.7 LS-07 営業コミュニケーション資料設計

| 項目 | 定義 |
|---|---|
| 正式サービスID | LS-07 |
| Legacy Reference ID | BC-04 |
| 正式名称 | 営業コミュニケーション資料設計（Sales Communication Materials） |
| 一文説明 | 会社案内、営業資料、サービス資料、事例資料を商談成果につながる形へ設計する |
| 事業目的 | 説明の属人化を減らし、理解と成約率を改善する |
| 主対象 | 建築・工務店／リフォームを中心に全優先業種 |
| Risk Level | MEDIUM |
| Risk Basis | 対外的な事実・価値表現が営業成果と信用に影響する一方、成果物と利用場面を事前定義できる |
| Estimated WIP | MEDIUM |
| Typical Duration | To Be Defined in Pricing / Contract Design |
| Dependencies | Business Audit推奨／契約／会社・商品情報／事例許可／顧客確認／Human Approval |
| Deliverable Owner | PHOSARA |
| オーナー承認レベル | 対外メッセージ、事実、最終デザインはオーナー承認 |
| Success KPI | 営業担当者の説明再現率／資料利用率／商談理解度／合意した転換指標の変化 |
| Standard Deliverables | 資料構成案／原稿ドラフト／原稿編集／デザイン／完成資料／PDFまたは合意したデータ形式／合意時の編集可能データ |
| Non-included Scope | 営業代行／成約保証／印刷 |
| Business Audit Route | Recommended |
| Standalone Sales Policy | YES。利用場面、対象顧客、説明内容が明確な場合 |
| Pricing Model | Price range |
| Customer Responsibilities | 正確な会社・商品情報の提供／事例掲載許可／営業実態の説明／期限内承認 |
| Acceptance Criteria | 合意した構成・内容・形式の資料が承認され、利用可能な状態で納品された時点 |

## 5.8 LS-08 事業コンテンツ制作

| 項目 | 定義 |
|---|---|
| 正式サービスID | LS-08 |
| Legacy Reference ID | BC-05 |
| 正式名称 | 事業コンテンツ制作（Business Content Production） |
| 一文説明 | 事例、専門知、サービス価値を継続利用できる事業資産へ編集する |
| 事業目的 | 信頼、指名検索、営業説明、採用、紹介を強化する |
| 主対象 | 建築・工務店／リフォーム／整体・整骨院 |
| Risk Level | LOW |
| Risk Basis | 一次情報、掲載許可、規制表現を確認すれば成果物を限定して検収でき、システム保守を伴わない |
| Estimated WIP | LOW |
| Typical Duration | To Be Defined in Pricing / Contract Design |
| Dependencies | 契約／一次情報／顧客素材／事例・人物の掲載許可／規制表現確認／Human Approval |
| Deliverable Owner | PHOSARA |
| オーナー承認レベル | 事実確認、規制表現、公開内容、最終成果物はオーナー承認 |
| Success KPI | 公開可能コンテンツ数／再利用回数／指名・閲覧・商談での利用／事実訂正率 |
| Standard Deliverables | 素材整理／記事ドラフト／事例記事／サービス説明／専門記事／公開用原稿／再利用可能なコンテンツ部品 |
| Non-included Scope | 未検証事実の作成／医療効果の保証表現／無制限取材・修正 |
| Business Audit Route | Optional |
| Standalone Sales Policy | YES。公開先、目的、情報源、確認責任が明確な場合 |
| Pricing Model | Price range |
| Customer Responsibilities | 一次情報・素材・事例許可の提供／取材参加／事実・権利・規制表現の確認 |
| Acceptance Criteria | 合意した本数・形式・用途のコンテンツが事実確認済みで納品された時点 |

## 5.9 LS-09 事業Webサイト設計・構築

| 項目 | 定義 |
|---|---|
| 正式サービスID | LS-09 |
| Legacy Reference ID | DM-01 |
| 正式名称 | 事業Webサイト設計・構築（Business Website Design & Development） |
| 一文説明 | 事業目的、情報設計、デザイン、実装、基本計測を統合したWebsiteを構築する |
| 事業目的 | 信頼、問い合わせ、採用、事例公開の受け皿を整える |
| 主対象 | 建築・工務店／リフォーム／整体・整骨院を中心に全優先業種 |
| Risk Level | HIGH |
| Risk Basis | 長期工程、複数承認点、公開責任、外部サービス依存、公開後の事業影響を伴う |
| Estimated WIP | HIGH |
| Typical Duration | To Be Defined in Pricing / Contract Design |
| Dependencies | Business Audit推奨／Solution Designまたは同等要件／契約／顧客原稿・写真／ドメイン・解析アクセス／Human Approval |
| Deliverable Owner | PHOSARA |
| オーナー承認レベル | 要件、最終デザイン、公開、納品はオーナー承認 |
| Success KPI | 要件適合率／公開時検査合格率／納期遵守／主要導線の計測可能性／重大不具合数 |
| Standard Deliverables | 要件定義／構成案／情報設計／デザインカンプ／テスト環境／UIデザイン／Website実装／基本SEO／基本計測／ソース／検収資料／運用手順書／利用説明 |
| Non-included Scope | 無制限の原稿・写真制作／検索順位保証／継続保守／外部サービス費 |
| Business Audit Route | Recommended |
| Standalone Sales Policy | CONDITIONAL。Websiteが事業課題に対する正当な解決策である場合 |
| Pricing Model | Price range |
| Customer Responsibilities | 原稿・写真・正確な情報の提供／ドメイン等の権限提供／各承認点での期限内回答／検収参加 |
| Acceptance Criteria | 合意した要件・ページ・機能・表示・基本計測が検査に合格し、顧客検収を完了した時点 |
| WIP上限 | 本格構築は同時1件 |

## 5.10 LS-10 地域検索・店舗情報最適化

| 項目 | 定義 |
|---|---|
| 正式サービスID | LS-10 |
| Legacy Reference ID | DM-03 |
| 正式名称 | 地域検索・店舗情報最適化（Local Presence Optimization） |
| 一文説明 | Google Business Profileを中心に、地域検索からの発見・信頼・行動を改善する |
| 事業目的 | 電話、経路、予約、来店等の地域顧客行動を増やす |
| 主対象 | 整体・整骨院／リフォーム／地域型工務店 |
| Risk Level | LOW |
| Risk Basis | 対象プラットフォームと設定範囲を限定できる。順位は保証せず、公開情報はHuman Approvalで統制する |
| Estimated WIP | LOW |
| Typical Duration | To Be Defined in Pricing / Contract Design |
| Dependencies | 契約／Google Business Profileのオーナー権限／正確な店舗情報・写真／Human Approval |
| Deliverable Owner | PHOSARA |
| オーナー承認レベル | 公開情報、カテゴリ、投稿方針、口コミ対応方針はオーナー承認 |
| Success KPI | 情報完全性／計測基準の設置／電話・経路・予約等の行動指標／口コミ返信実施率 |
| Standard Deliverables | 簡易現状診断／基本情報・カテゴリ整備／写真方針／投稿方針／口コミ対応方針・返信の型／改善チェックリスト／計測基準／引継ぎ手順 |
| Non-included Scope | 口コミ購入・捏造／順位保証／Googleによる停止・仕様変更の保証 |
| Business Audit Route | Optional |
| Standalone Sales Policy | YES。正式な単品入口 |
| Pricing Model | Fixed priceまたはPrice range |
| Customer Responsibilities | オーナー権限の提供／正確な店舗情報・写真の提供／口コミ対応への参加／Google規約の遵守 |
| Acceptance Criteria | 合意した情報・カテゴリ・方針・計測項目が設定または納品され、顧客が確認した時点 |

## 5.11 LS-11 PHOSARA事業成長プログラム

| 項目 | 定義 |
|---|---|
| 正式サービスID | LS-11 |
| Legacy Reference ID | GR-01 |
| 正式名称 | PHOSARA事業成長プログラム（PHOSARA Business Growth Program） |
| 一文説明 | 毎月、事業KPIに基づいて最重要の改善テーマを選び、実行・検証する |
| 事業目的 | 単発施策で終わらず、継続的な事業改善能力を作る |
| 主対象 | 全優先業種。特にパチンコホール |
| Risk Level | HIGH |
| Risk Basis | 継続契約、月次判断、複数成果物、容量超過、収益性低下の累積リスクを伴う |
| Estimated WIP | HIGH |
| Typical Duration | To Be Defined in Pricing / Contract Design |
| Dependencies | 開始時の専門評価／月額契約／固定作業容量／顧客素材・KPI／必要なアクセス権／Human Approval |
| Deliverable Owner | PHOSARA |
| オーナー承認レベル | 月次テーマ、対外成果物、契約容量超過、プラン変更はオーナー承認 |
| Success KPI | 月次テーマ完了率／KPI計測率／継続率／粗利／改善仮説の検証数 |
| Standard Deliverables | 月次テーマ提案／契約容量内の実装成果物／KPIレポート／次月提案／定期レビュー。パチンコホール向けでは、月次販促テーマ、入稿データ、規制確認記録を業種別実装例として扱える |
| Non-included Scope | 無制限対応／大型構築／外部実費／緊急対応／契約容量を超える制作 |
| Business Audit Route | Specialist Assessment Required |
| Standalone Sales Policy | CONDITIONAL。開始時に現状評価と月次容量を確定する |
| Pricing Model | Subscription |
| Customer Responsibilities | 素材・数値の提供／月次テーマ承認／期限内回答／必要なアクセスの維持 |
| Acceptance Criteria | 月ごとに合意したテーマと容量内成果物を納品し、KPIレポートと次月判断を提示した時点 |
| 契約上限 | 継続支援全体で最大3社 |

## 5.12 LS-12 AI業務導入スプリント

| 項目 | 定義 |
|---|---|
| 正式サービスID | LS-12 |
| Legacy Reference ID | OP-05 |
| 正式名称 | AI業務導入スプリント（AI Business Adoption Sprint） |
| 一文説明 | 一つの限定業務へAIを安全に試験導入し、効果・リスク・運用条件を検証する |
| 事業目的 | 小さく安全にAI活用を開始し、本格導入の可否を判断する |
| 主対象 | 全優先業種 |
| Risk Level | CRITICAL |
| Risk Basis | 顧客データ、機密性、AI誤出力、本番利用、Human Approval、外部AI仕様変更が複合し、誤運用時の影響が重大である |
| Estimated WIP | HIGH |
| Typical Duration | To Be Defined in Pricing / Contract Design |
| Dependencies | AI専門評価／契約／限定業務／適法な検証データ／機密・権限確認／利用者参加／Human Approval |
| Deliverable Owner | PHOSARA |
| オーナー承認レベル | 対象業務、利用データ、Human Approval Point、試作の対外・本番利用、Exit判定はオーナー承認 |
| Success KPI | 対象業務の処理時間／修正率／検証合格率／Human Approval遵守率／利用者の再現実行率 |
| Standard Deliverables | 対象業務の確認・診断／導入範囲／設計書／小規模試作／検証結果／Human Approval Point／運用ルール／利用説明／利用者向け研修／効果計測方法／非提供範囲／継続保守要否の判定 |
| Non-included Scope | 全社AI変革／完全自律Agent／大規模システム連携／精度保証／無期限保守／人間承認の排除 |
| Business Audit Route | Specialist Assessment Required |
| Standalone Sales Policy | CONDITIONAL。一つの限定業務に絞り、データ・機密・承認・評価・停止条件を確認できる場合 |
| Pricing Model | Price range |
| Customer Responsibilities | 対象業務の説明／検証用データの適法な提供／利用者の参加／出力確認／禁止データの遵守／検証結果の確認 |
| Acceptance Criteria | 合意した限定業務の試作、検証、Human Approval Point、運用ルール、利用説明、Exit判定を納品した時点 |
| WIP上限 | 同時1件 |

### 対象業務例

- 議事録整理
- 問い合わせ分類
- メール下書き
- 営業文生成
- 社内FAQ
- 文書検索
- 定型レポート生成
- 簡単な通知・登録自動化

### Exit Criteria

スプリント終了時は、次のいずれか一つをオーナーが確定する。

| Exit | 判定基準 |
|---|---|
| 継続導入 | 効果、品質、安全性、運用責任が許容範囲で、限定業務として継続できる |
| 改修して再検証 | 有望だが、精度、入力、Human Approval、運用手順の修正が必要 |
| Workflow Automation候補 | AI判断より定型的な配管・通知・登録として設計する方が適切 |
| AI Agent候補 | 職務、状態、権限、ログを持つ将来サービスとして追加設計が必要 |
| 保留 | データ、担当者、法務、予算、業務標準化等の前提が不足している |
| 中止 | 効果が不足、リスクが過大、または人間業務の方が合理的 |

### 技術手段の扱い

n8n、MCP、ChatGPT、Claude等は技術手段であり、独立商品名にはしない。技術選定は対象業務、データ、リスク、保守性に従属する。

## 5.13 Launch Deliverables Matrix

本Matrixは、Launch Servicesの工程成果物、最終成果物、顧客提供物、内部記録、検証対象を一覧化する。価格、納期、改訂回数、検収日数その他の契約条件は定めない。

| Service Code | 工程成果物 | 最終成果物 | 顧客提供物 | 内部記録 | 検証対象 |
|---|---|---|---|---|---|
| LS-01 | ヒアリング記録／証拠索引／スコア根拠／優先課題案 | 監査報告書／戦略的方向／30・60・90日および1年ロードマップ／Quick Win | 事前資料／事実情報／必要な計測アクセス | 証拠台帳／承認記録／監査判断記録 | 証拠との一致／評価根拠／優先課題の明確性／ロードマップの整合 |
| LS-02 | 対象ページ一覧／技術・内容・導線の診断メモ／証拠一覧 | Website診断レポート／優先改善項目／改修・刷新・維持判定 | 対象URL／解析・管理アクセス／事業目的と顧客情報 | 検査記録／証拠記録／判定承認記録 | 対象範囲／証拠性／技術・内容・導線評価／判定根拠 |
| LS-03 | ブランド資産一覧／メッセージ・視覚・接点の評価記録 | ブランド診断／不整合一覧／優先改善方針 | 既存ブランド資産／営業資料／主要接点情報 | 評価記録／不整合根拠／承認記録 | 事業価値との整合／接点間の一貫性／改善優先順位 |
| LS-04 | 戦略1枚／カテゴリ選定／解決策構成／要件整理 | 実装仕様書／対象・除外範囲／KPI／工程／顧客責任／検収項目案 | 確定済み課題／事業制約／既存環境／関係者情報 | 要件判断記録／未決事項一覧／承認記録 | 課題との適合／要件の完全性／範囲境界／後続実装可能性 |
| LS-05 | 初期ブランド診断／コンセプト案／Visual Identity候補／検証資料 | ブランド核／ポジショニング／メッセージ／最終データ／基本使用ガイド／ブランド説明 | 事業方針／既存資産／商標情報／経営者の判断 | 検証記録／選定理由／承認記録 | ブランド核との整合／言語・視覚の一貫性／基本使用規則 |
| LS-06 | 企画整理／ラフ案／承認用デザイン | 最終デザインデータ／合意したサイズ展開／入稿用データ | 正確な掲載情報／素材／媒体仕様／必要な規制情報 | 制作判断記録／確認記録／承認記録 | 掲載情報／媒体仕様／ブランド適合／規制表現／データ形式 |
| LS-07 | 資料構成案／原稿ドラフト／デザイン案 | 完成資料／PDFまたは合意したデータ形式／合意時の編集可能データ | 会社・商品情報／事例掲載許可／営業実態 | 事実確認記録／構成判断／承認記録 | 事実性／対象顧客との適合／構成・内容・形式／対外表現 |
| LS-08 | 素材整理／取材記録／記事ドラフト | 事例記事／サービス説明／専門記事／公開用原稿／再利用可能なコンテンツ部品 | 一次情報／素材／事例・人物の掲載許可 | 事実確認記録／権利確認／承認記録 | 事実性／権利・規制表現／公開可能性／再利用可能性 |
| LS-09 | 要件定義／構成案／情報設計／デザインカンプ／テスト環境 | 公開可能なWebsite／ソース／基本SEO・計測／検収資料／運用手順書／利用説明 | 原稿／写真／正確な事業情報／ドメイン・解析等の権限 | 要件記録／テスト記録／公開承認記録／引継ぎ記録 | 要件・ページ・機能／表示／主要導線／基本計測／重大不具合 |
| LS-10 | 簡易現状診断／情報・カテゴリ確認／写真・投稿方針案 | 整備済み情報／口コミ対応方針・返信の型／改善チェックリスト／計測基準／引継ぎ手順 | オーナー権限／正確な店舗情報／写真 | 設定記録／公開情報確認／承認記録 | 情報完全性／カテゴリ・公開情報／Google規約／計測可能性 |
| LS-11 | 月次テーマ提案／実装計画／制作・改善中間物 | 契約容量内の実装成果物／KPIレポート／次月提案／定期レビュー | 素材／数値／テーマ判断／必要なアクセス | 容量記録／テーマ承認／作業記録／KPI記録 | 契約容量／テーマ完了／KPI計測／品質／次月判断の根拠 |
| LS-12 | 対象業務診断／導入範囲／設計書／小規模試作／検証記録 | 検証済み試作／Human Approval Point／運用ルール／利用説明／研修／効果計測方法／Exit判定 | 対象業務情報／適法な検証データ／利用者参加／出力確認 | データ・権限確認／検証ログ／Human Approval記録／Exit判断記録 | 限定範囲／安全性／修正率／検証合格／承認遵守／再現実行性 |

---

# 6. Conditional Services

Conditional Servicesは正式なサービス候補として保持するが、案件条件、能力、外部協力、保守、法務、セキュリティ等を確認してから受注する。通常のWebサービス一覧には個別掲載しない。

対外的には、必要に応じて「その他、課題に応じた専門支援」という上位表現を使用できる。

| ID | サービス | 主な受注条件 | 外部協力・保守 | 主なリスク |
|---|---|---|---|---|
| CS-01 | Marketing & Channel Audit | 複数チャネルのデータとアクセス権がある | 原則不要 | Business Auditとの範囲重複 |
| CS-02 | AI & Automation Readiness Audit | 業務、データ、例外、承認点を確認できる | 法務・セキュリティ協力の可能性 | 実装保証との誤認 |
| CS-03 | Business Strategy | 経営者が参加し、経営情報を提供する | 原則不要 | 経営コンサルティングの過大約束 |
| CS-04 | Measurement & KPI Design | 計測対象とデータ源が存在する | 継続集計時は保守あり | 形式的なKPI設定 |
| CS-05 | Customer Journey Design | 顧客接点と現場工程を確認できる | 原則不要 | 現場未定着 |
| CS-06 | Communication Strategy | 事業方針と顧客像が確定している | 原則不要 | Brand・Contentとの重複 |
| CS-07 | Visual Identity Design | ブランド核が確定している | 商標調査で外部協力の可能性 | ロゴ単体制作への矮小化 |
| CS-08 | Photography Direction & Production | 撮影目的、利用媒体、必要カットが明確 | 原則として外部撮影者と連携 | 肖像権、品質責任、外注粗利 |
| CS-09 | Video & Motion Content | 配信先、目的、尺、素材責任が明確 | 規模に応じ外部協力 | 工数超過、権利、修正増加 |
| CS-10 | AI Creative Production | AI利用、権利、用途、監修条件に同意 | 原則不要 | 著作権、類似性、品質誤認 |
| CS-11 | Sign & Spatial Communication Planning | 設計・データまでに限定する | 製作・施工会社が必要 | 施工責任、法令、寸法 |
| CS-12 | Landing Page | オファー、流入経路、KPIが明確 | 原則不要 | 流入設計のない制作 |
| CS-13 | SEO Foundation & Optimization | 検索需要とWebsite基盤がある | 継続時は保守あり | 順位保証、成果時期の誤認 |
| CS-14 | SNS Strategy & Enablement | 素材供給者と運用担当者がいる | 撮影等で外部協力の可能性 | 低粗利の投稿代行化 |
| CS-15 | LINE Customer Engagement | 顧客リスト、同意、目的が明確 | 継続配信時は保守あり | 個人情報、配信負荷 |
| CS-16 | Advertising Strategy & Operations | 受け皿、粗利、LTV、計測が整う | 外部運用者との連携可能性／保守必須 | 広告損失、規制、成果保証誤認 |
| CS-17 | Recruitment Communication | 主課題が採用伝達にある | 労務判断は専門家 | 採用保証、労務領域への越境 |
| CS-18 | Customer Experience Improvement | 現場観察と責任者参加が可能 | 定着支援時は継続対応 | 現場抵抗、責任不明 |
| CS-19 | Business Process Improvement | 経営者と現場責任者が参加する | 労務・会計領域は専門家 | 組織変更への越境 |
| CS-20 | Continuous Digital Optimization | 対象チャネルと月次容量を限定する | 継続保守を含む | Growth Programとの重複、作業消化型への退行 |

## 6.1 承認済み統合補足

以下は、提出版から選択統合した説明、対象、適用条件および候補成果物である。すべてConditional Servicesのままであり、通常販売可能なLaunch Serviceを意味しない。受注には第6章の条件審査とオーナー承認を要する。

| Service Code | サービス説明・対象 | 適用条件 | 候補工程成果物 | 候補最終成果物 | 非対応範囲 |
|---|---|---|---|---|---|
| CS-04 | 計測対象と判断目的を整理し、KPIとデータ取得方法を設計する。計測基盤を必要とする顧客が対象 | データ源、基準値、更新責任、利用目的を確認できる | 計測対象一覧／KPI案／計測設計書 | 承認済みKPI・計測設計／必要時の実装引渡し仕様／数値の見方の手引き | データが存在しない状態での形式的KPI設定／成果保証／無条件の継続集計 |
| CS-09 | 動画・モーションでのみ伝わる価値を、用途と配信先に合わせて設計する。動画利用目的が明確な顧客が対象 | 配信先、目的、尺、素材責任、出演同意、音源、利用権を確認できる | 構成台本／絵コンテまたは構成案／仮編集 | 合意した用途の完成動画／用途別書き出し | 出演・音源・素材の権利未確認案件／無制限修正／成果保証 |
| CS-11 | 店舗・施設の視認性、動線、情報伝達をサインと空間コミュニケーションで設計する | 現地条件、法規、設置場所、寸法、製作・施工責任を確認できる | 現地・動線分析／デザイン案／仕様検討 | 設計図書／デザインデータ／製作仕様書 | 製作・施工／有資格判断／施工保証 |
| CS-13 | 検索需要とWebsite構造を分析し、SEOの基礎と改善方針を設計する | 検索需要、競合、既存評価、健全なWebsite基盤、コンテンツ供給を確認できる | 需要語調査／構造分析／改善案 | SEO設計書／実装引渡し仕様／計測方針 | 検索順位保証／成果時期の保証／無制限の継続改善 |
| CS-14 | 顧客との継続的な認知・関係形成に必要なSNSの発信設計と運用の型を作る | 対象顧客、媒体、素材供給者、運用担当者、承認責任を確認できる | 発信設計／投稿の型／運用案 | 運用設計書／テンプレート一式 | SNS完全代行／投稿本数だけを売る運用／素材供給のない運用 |
| CS-15 | 顧客リストを用いた再来店・再接触の導線をLINEで設計する | 利用目的、同意取得、配信責任、個人情報、運用担当者を確認できる | 配信シナリオ案／導線設計／設定案 | アカウント・配信設計／運用手順 | 同意のない配信／FS-03に該当する自動連携・高度なAutomation／無制限配信代行 |
| CS-16 | 受け皿と採算条件が整った案件について、広告媒体、表現、計測、停止条件を設計する | 受け皿、粗利、LTV、計測環境、予算責任、媒体規約を確認できる | 媒体設計／クリエイティブ案／計測・停止条件案 | 広告設計書／承認済みクリエイティブ／計測仕様 | 広告費の立替／成果保証／受け皿・計測のない広告運用 |
| CS-17 | 採用候補者へ事業・仕事・職場の実態を伝える採用コミュニケーションを設計する | 主課題が採用伝達にあり、職種、条件、労務表現、取材協力を確認できる | 取材記録／構成案／原稿案 | 採用ページまたは採用資料／確認済み原稿データ | 採用成果保証／労務判断／定着問題だけを対象とする支援 |
| CS-18 | 来店・接客・利用時の顧客体験と動線を観察し、改善案を設計する | 現場観察、対象工程、現場責任者、顧客フィードバックを確認できる | 現状・動線分析／課題記録／改善案 | 顧客体験改善設計／実行仕様 | 施工・設備工事／現場実行の代行／成果保証 |
| CS-19 | 現行業務を可視化し、役割、工程、例外、移行方法を含む新しい業務フローを設計する | 経営者と現場責任者が参加し、工程、工数、例外、改善権限を確認できる | 現状マップ／課題・例外一覧／新フロー案 | 新業務フロー設計書／移行手順 | 労務・会計判断／組織変更の代行／一般的な受託システム開発 |

## 6.2 Photographyの提供方針

PHOSARAはPhotographyにおいて、撮影目的の定義、企画、必要カットの設計、ブランド上の方向、撮影ディレクション、素材選定、品質管理、利用媒体との整合を担当する。

必要に応じて外部撮影者と連携する。単なる記録撮影、無目的な大量撮影、撮影者の時間だけを販売する業務は提供しない。

---

# 7. Future / Enterprise Services

Future / Enterprise Servicesは将来の正式候補であり、現時点では通常営業、Web掲載、積極販売を行わない。

対外的には、現在販売可能なAI業務導入スプリントを指す上位表現として「AI活用・業務自動化の導入支援」を使用できる。この表現を、現在未提供のAI Agent、Internal AI、Enterprise Integrationまで販売可能であるかのように使用してはならない。

| ID | サービス | 販売開始に必要な条件 |
|---|---|---|
| FS-01 | CRM & Customer Data Design | データ設計・移行・権限・個人情報・定着支援の実証と保守体制 |
| FS-02 | Workflow Automation | 同型業務3回以上の安定実証、監視、復旧、保守SLA |
| FS-03 | LINE Automation | LINE API、同意管理、CRM・予約連携、障害対応の実証 |
| FS-04 | Internal AI & Knowledge Assistant | PHOSARA内部で3ヶ月以上の安定運転、権限、評価、ログ、復元手順 |
| FS-05 | AI Agent Design & Implementation | 内部Agentの3ヶ月以上の安定運転、状態・承認・停止・保守の標準化 |
| FS-06 | AI & System Integration | 複数システム統合の実証、外部技術パートナー、セキュリティレビュー |
| FS-07 | Continuous AI Optimization | 導入済みAIの継続運用実績、回帰検査、障害分類、SLA |
| FS-08 | Enterprise Transformation | 複数社の監査・実装・継続実績、専門家ネットワーク、大型案件管理能力 |

## 7.1 承認済み将来設計補足

以下は将来設計の補足であり、現在の受注、提案、見積または価格提示を許可するものではない。

| Service Code | 将来のサービス説明・対象 | 将来の適用条件 | 候補工程成果物 | 候補最終成果物 | 非対応・境界 |
|---|---|---|---|---|---|
| FS-01 | 顧客データ、顧客台帳、追客情報を安全に設計・移行・運用する。データ統合を必要とする顧客が将来対象 | データ設計、移行、権限、個人情報、運用担当者、保守体制を実証できる | 要件定義／データ・権限設計／移行計画／運用案 | 将来のCRM・顧客データ環境／運用ルール／研修設計 | 現在販売不可／一般的なCRM導入代行としての受注不可／価格提示不可 |
| FS-02 | 定型業務を安全に自動化し、監視・停止・復旧・保守まで含めて運用する。反復業務と検証データを持つ顧客が将来対象 | 同型業務の安定実証、ROI評価、例外処理、監視、復旧、保守SLAを確立できる | ROI評価／業務・例外分析／設計書／検証記録 | 将来の自動化／監視・停止・復旧手順／保守設計 | 現在販売不可／回収期間の固定保証不可／一般的な受託システム開発を含まない |
| FS-08 | 複数拠点、組織横断またはAIを含む全体変革を個別設計する。大規模な変革条件を持つ顧客が将来対象 | 複数社の実績、専門家レビュー、外部パートナー、大型案件管理、法務・セキュリティ統制を確立できる | 全体診断／変革構想／段階計画／専門家レビュー記録 | 将来の統合変革計画／段階実装設計／Governance設計 | 現在販売不可／通常の個別見積不可／専門家レビューなしの受注不可 |

Future / Enterprise Servicesには現時点で価格を設定しない。

---

# 8. Do Not Offer

次はPHOSARAの独立商品として販売しない。

| 対象 | 独立販売しない理由 | 扱い |
|---|---|---|
| n8n導入 | ツールであり、顧客の事業成果ではない | AI業務導入、将来のWorkflow Automation等の技術手段 |
| MCP Integration単体 | AIとツールを接続する規格であり、単独価値を定義できない | 将来のAI Agent・System Integrationの技術手段 |
| ChatGPT導入 | 外部製品の設定だけではPHOSARA独自価値にならない | AI業務導入スプリントの技術手段 |
| Claude導入 | 同上 | AI業務導入スプリントの技術手段 |
| プロンプト単体販売 | 運用、検証、責任、データ条件を含まず再現性が低い | AI業務導入スプリントの成果物の一部 |
| 印刷・配送 | PHOSARAの提供領域外 | 顧客または外部事業者が直接契約 |
| 施工・建設 | 資格、現場責任、保証が提供領域外 | 外部事業者が直接契約 |
| 広告枠・媒体費の再販売 | 広告運用責任と媒体費を混同する | 顧客負担の外部実費 |
| 口コミ購入・レビュー操作 | 倫理、規約、ブランドに反する | 提供禁止 |
| 検索順位・売上・AI精度の保証 | 外部環境に依存し、誠実に保証できない | 計測・改善を提供する |
| 汎用的な記録撮影 | 事業目的とPHOSARA独自価値がない | Photography Direction案件から除外 |
| 投稿本数だけを売るSNS代行 | 低粗利の作業消化になりやすい | StrategyまたはGrowth Programの限定工程 |
| 人間承認を外した高リスクAI | Company OSとAI Companyの承認方針に反する | 提供禁止 |
| 一般的なカスタムソフトウェア受託開発 | 基幹・業務システム等の一般受託開発は現行の提供能力・責任範囲外 | 必要に応じて専門開発会社との連携を検討する。PHOSARAは受託開発主体にならない |
| ネイティブアプリ受託開発 | iOS・Android向けネイティブアプリの設計・開発・保守は現行の提供範囲外 | Web、LINE等の既存手段で代替可能性を検討する |
| 広告費の立替または融資 | 顧客の媒体費とPHOSARAの役務責任を混同し、財務リスクを生む | 広告費は顧客が媒体または指定事業者へ直接負担する |
| SNS完全代行 | 顧客固有の声・素材・判断をPHOSARAだけで恒常的に代行できない | CS-14またはLS-11で、発信設計、型、限定制作、改善を扱う |
| 弁護士、税理士、社会保険労務士等の士業業務 | 資格・法的責任を伴いPHOSARAの権限外 | 必要に応じて該当専門家へ確認・連携する |
| 成果報酬のみの受託契約 | 外部要因に依存する成果保証と役務提供の責任境界が一致しない | 計測可能な成果物、工程、KPIを定義して提供する |

FS-06 AI & System Integrationは、AIと既存システムの限定的な将来連携候補であり、一般的なカスタムソフトウェアまたはネイティブアプリの受託開発を意味しない。FS-06は現在販売不可であり、正式な昇格前に受注または価格提示を行ってはならない。

---

# 9. Business Audit Route Rules

## 9.1 Route区分

| 区分 | 定義 |
|---|---|
| Required | Business Audit完了を受注条件とする |
| Recommended | 原則としてBusiness Auditを推奨する。課題と根拠が明確な場合のみ省略可能 |
| Optional | Business Auditなしでも、対象領域の限定確認により販売可能 |
| Specialist Assessment Required | Business Audit全体または対象領域の専門診断を必須とする |

## 9.2 Launch Services Route Matrix

| 正式サービスID | Launch Service | Route |
|---|---|---|
| LS-01 | PHOSARA事業監査 | 本サービス自体 |
| LS-02 | Webサイト事業成果診断 | Optional |
| LS-03 | ブランド明確性診断 | Optional |
| LS-04 | 解決策設計 | Recommended |
| LS-05 | ブランド戦略・アイデンティティ設計 | Specialist Assessment Required |
| LS-06 | 販促コミュニケーションデザイン | Optional |
| LS-07 | 営業コミュニケーション資料設計 | Recommended |
| LS-08 | 事業コンテンツ制作 | Optional |
| LS-09 | 事業Webサイト設計・構築 | Recommended |
| LS-10 | 地域検索・店舗情報最適化 | Optional |
| LS-11 | PHOSARA事業成長プログラム | Specialist Assessment Required |
| LS-12 | AI業務導入スプリント | Specialist Assessment Required |

## 9.3 Requiredへの昇格条件

次のいずれかに該当する場合、RecommendedまたはOptionalのサービスでもBusiness Audit Requiredへ昇格できる。

- 課題が複数領域にまたがる
- 高額または長期の投資
- 複数拠点または複数部門
- 経営方針の変更を伴う
- 顧客が手段を既定解として指定している
- KPIが存在しない
- 過去施策の失敗原因が不明
- AI、Automation、個人情報、機密情報等の高リスク要素がある

## 9.4 Service Recommendation Flow

本Flowは、既存のBusiness Audit RouteとStandalone Sales Policyを実務判断へ接続する。Business Auditを最優先入口として推奨するが、明確な定型需要または受注不適合を無視して一律にLS-01へ誘導してはならない。

```text
STEP 1  顧客の症状、目的、対象顧客、希望手段、制約を確認する
   ↓
STEP 2  受注拒否条件またはDo Not Offerに該当するか
   ├─ YES → 【出口3】現時点では受注しない／見送る
   └─ NO  ↓
STEP 3  課題が未特定、複数領域、高額・長期・高リスク、失敗原因不明か
   ├─ YES → 【出口1】LS-01 PHOSARA事業監査へ進む
   └─ NO  ↓
STEP 4  単一の課題が、Launch Serviceの対象・範囲・Standalone Sales Policyに適合するか
   ├─ YES → 【出口2】明確な定型需要として該当LSの単品サービスへ進む
   └─ NO  ↓
STEP 5  ConditionalまたはFutureの領域か
   ├─ Conditional → 通常販売せず、条件審査とOwner Approvalへ上申する
   ├─ Future      → 販売・見積を行わず、将来候補または保留として記録する
   └─ いずれでもない → 【出口3】現時点では受注しない／見送る
```

### 3つの正式出口

| 出口 | 判断 | 次の処理 |
|---|---|---|
| 出口1 | Business Auditへ進む | LS-01の対象、WIP、顧客責任を確認して提案候補とする |
| 出口2 | 明確な定型需要として単品サービスへ進む | 該当LSのStandalone Sales Policy、範囲、非対応範囲、WIPを確認する |
| 出口3 | 現時点では受注しない／見送る | 不適合理由、将来再確認条件、必要に応じた専門家連携を記録する |

Conditional Serviceの条件審査とOwner Approvalは、出口2の通常単品販売には含めない。Future Serviceは、いずれの出口からも現在の販売・見積へ移行させてはならない。

---

# 10. Standalone Sales Rules

## 10.1 単品販売の承認条件

単品販売は次のすべてを満たす場合に認める。

1. 解決する事業課題を一文で説明できる。
2. 顧客が希望する手段と事業課題が区別されている。
3. 目的と対象顧客が明確である。
4. 対象範囲と非提供範囲を定義できる。
5. KPIまたは検収条件を定義できる。
6. 顧客責任を定義できる。
7. 意思決定者が確認できる。
8. PHOSARAのWIP上限内で履行できる。
9. 粗利70%以上を狙える。
10. 法務、権利、外部費、保守責任を整理できる。
11. Business Auditを省略する理由を記録できる。
12. 単品納品だけで独立した顧客価値が成立する。

## 10.2 受注拒否条件

次の場合は受注しない。

- 価格の安さだけが選定条件
- 値引きを前提とする
- 目的、範囲、KPIの確認を拒否する
- 必要な情報や素材を提供しない
- 意思決定者が不明
- 成果保証を要求する
- 虚偽、誇張、口コミ操作を要求する
- 著作権、肖像権、秘密保持を無視する
- PHOSARAに印刷、施工、建設責任を求める
- WIP上限を超える納期を強制する
- 修正無制限を要求する
- AIのHuman Approval Pointを削除するよう求める
- 必要な保守契約を拒否する
- 粗利70%以上を合理的に確保できない
- PHOSARAのブランドを損なう

---

# 11. WIP and Capacity Rules

## 11.1 基本方針

PHOSARAはオーナー1名・1日約5時間の運営を前提とする。受注量より品質、収益性、納期の信頼性を優先する。

WIP上限はMUSTとして遵守する。例外運用は事前のOwner Approvalと決定記録なしに行ってはならない（MUST NOT）。

## 11.2 現行上限

| 対象 | 上限 |
|---|---|
| Business Audit | 同時1件 |
| Website本格制作 | 同時1件 |
| AI業務導入スプリント | 同時1件 |
| 継続支援 | 最大3社 |
| 高負荷案件 | 同時並行を避ける |
| 無制限対応契約 | 禁止 |

## 11.3 継続支援

- 継続支援にはLS-11 PHOSARA事業成長プログラムおよび継続容量を使用するConditional Serviceを含む。
- 契約ごとに月次作業容量を固定する。
- 容量超過は追加見積または翌月候補とする。
- Website本格制作中は、高負荷の月額契約を増やさない。
- 継続支援3社は販売目標ではなく全体の最大上限である。
- 粗利または品質を維持できない場合、新規受付を停止する。

## 11.4 WIP超過時

WIP上限に達した場合は、開始日の後倒し、待ち行列への登録、範囲分割、外部協力の審査、受注見送りのいずれかとする。品質を下げて同時案件数を増やしてはならない。

---

# 12. Service Lifecycle

```text
Future
  ↓ 実証・能力・安全条件を満たす
Conditional
  ↓ 再現性・収益性・契約・品質を満たす
Launch
  ↓ 実績・需要・資産化が蓄積する
Growth / Optimization
  ↓ 需要消失・重複・低収益・高リスクを検出する
Retirement
  ↓ 履歴と根拠を保存する
Archive
```

## 12.1 Future

将来の正式候補。通常営業、Web掲載、積極販売、公式価格設定を行わない。

## 12.2 Conditional

正式候補として存在するが、受注条件、外部協力、保守、法務、セキュリティ等を案件ごとに審査する。通常のWebサービス一覧には個別掲載しない。

## 12.3 Launch

標準成果物、非提供範囲、顧客責任、検収、価格モデル、契約類型、供給能力が定義され、通常販売できる状態。

## 12.4 Growth / Optimization

Launch後の実績、粗利、工数、顧客成果、再利用資産を計測し、提供工程と品質を継続改善する。Growthは別商品への自動昇格を意味しない。

## 12.5 Retirement

新規販売を停止し、進行中契約と既存顧客への責任を整理する状態。退役にはオーナー承認と移行計画を必要とする。

## 12.6 Archive

履歴、決定理由、過去契約との接続を保存する。Archive文書を現行サービスの根拠として使用しない。

---

# 13. Service Addition / Promotion / Retirement Rules

## 13.1 新サービス追加

1. 顧客課題を確認する。
2. 既存サービスで対応できないことを確認する。
3. 目的、成果物、非提供範囲を定義する。
4. Business Auditとの関係と単品販売可否を定義する。
5. 提供能力、WIP、粗利、リスクを検証する。
6. 契約類型と検収条件を定義する。
7. FutureまたはConditionalとして登録する。
8. オーナーがType 1承認する。
9. 本書への追加後にのみ価格設計へ進む。

価格を先に決め、新サービスを後から正当化してはならない。

## 13.2 FutureからConditionalへの昇格

- 必要な内部能力が稼働済み
- セキュリティ、法務、保守条件が明確
- 内部実証または限定パイロットを完了
- 障害時の停止・復旧手順がある
- 必要な外部専門家または技術パートナーを確保
- オーナーがType 1承認

## 13.3 ConditionalからLaunchへの昇格

- 有償案件または内部実証を合計3回以上完了
- 成果物と工程が再現可能
- 品質基準を定義済み
- 粗利70%以上を狙える
- 契約・検収・顧客責任を定義済み
- WIPへの影響が許容範囲
- 重大な未解決Failureがない
- オーナーがType 1承認

## 13.4 Growth / Optimization

- サービス別の売上、粗利、工数、品質、顧客成果を計測する。
- 3回以上再利用された工程はPBOS資産候補とする。
- 改善は標準成果物と顧客価値を維持する。
- 工数短縮だけを理由に品質を下げない。
- 価格変更はPricing Governanceの手続に従う。

## 13.5 Retirement

次の場合は退役審査を行う。

- 需要がない
- 粗利70%を継続的に確保できない
- 品質を再現できない
- 他サービスと完全に重複する
- ブランドを制作会社・何でも屋へ近づける
- 保守負荷が顧客価値を上回る
- 法務・セキュリティリスクが許容できない
- 外部サービス終了等により履行不能

退役時は、新規販売停止、既存顧客への影響確認、契約責任の完了、後継サービスの有無、参照更新を行う。

## 13.6 Archive

退役したサービスの文書と履歴は削除しない。退役日、理由、後継サービス、影響契約を記録し、正規Archiveへ移す。

---

# 14. Pricing Governance Handoff

## 14.1 初期価格設計対象

Pricing Governance v2.0で初期価格を設計する対象は、Launch Services 12種に限定する。

Pricing Governanceは、本書に定義されていないサービスを先に価格化してはならない（MUST NOT）。

| 正式サービスID | サービス | 価格モデル |
|---|---|---|
| LS-01 | PHOSARA事業監査 | Fixed price |
| LS-02 | Webサイト事業成果診断 | Price range |
| LS-03 | ブランド明確性診断 | Price range |
| LS-04 | 解決策設計 | Price range |
| LS-05 | ブランド戦略・アイデンティティ設計 | Price range |
| LS-06 | 販促コミュニケーションデザイン | Price range |
| LS-07 | 営業コミュニケーション資料設計 | Price range |
| LS-08 | 事業コンテンツ制作 | Price range |
| LS-09 | 事業Webサイト設計・構築 | Price range |
| LS-10 | 地域検索・店舗情報最適化 | Fixed priceまたはPrice range |
| LS-11 | PHOSARA事業成長プログラム | Subscription |
| LS-12 | AI業務導入スプリント | Price range |

本書は価格額を定めない。

## 14.2 Conditional Services

Conditional Servicesには個別の公式価格を設定せず、Pricing Governanceで次の共通見積規則のみを定める。

- Price rangeまたはCustom quotation
- オーナー承認必須
- 受注条件審査必須
- 外部費を分離
- 粗利70%以上
- 保守費を本体と分離
- 見積前に提供可否を判定
- 未検証サービスの固定価格化禁止
- 実績蓄積後に正式価格へ昇格

## 14.3 Future / Enterprise Services

Future / Enterprise Servicesには価格を設定しない。正式な昇格前に参考価格、営業価格、対外価格を表示してはならない。

## 14.4 技術手段

n8n、MCP、ChatGPT、Claude等は技術構成または外部費として記載できるが、独立した商品価格を設定しない。

---

# 15. Contract System Handoff

Contract Systemは、Launch Serviceごとに最低限次を定義する。

- 契約類型
- 役務の目的
- 成果物
- 対象範囲と非提供範囲
- 顧客責任
- 支払・着手条件
- 工程と承認点
- 修正回数
- 検収条件とみなし検収
- 遅延、キャンセル、中断
- 知的財産と第三者素材
- 外部実費
- 秘密保持
- AI利用開示
- 保守の有無

## 15.1 AI業務導入スプリント固有条項

- 対象業務を一つに限定する
- 試作と本番運用を区別する
- Human Approval Pointを記載する
- 利用データと禁止データを記載する
- AI出力の限界と顧客側の確認責任を記載する
- 外部AIサービスの仕様変更可能性を記載する
- 継続保守の有無を記載する
- 緊急停止・利用中止条件を記載する
- 完全な正確性や成果を保証しない

## 15.2 Photography固有条項

- PHOSARAと外部撮影者の責任分界
- 撮影場所、肖像権、施設許可
- 利用媒体・期間
- 納品点数と選定・編集範囲
- 外部費
- 天候・日程変更
- 元データの扱い

---

# 16. AI Company Handoff

## 16.1 Sales AI

- Launch Servicesのみを通常提案候補として扱う。
- Conditional Servicesは受注条件を確認し、オーナーへ起案する。
- Future Servicesを販売可能と表現しない。
- Do Not Offerを独立商品として提案しない。
- 価格を確定しない。
- 単品販売条件とBusiness Audit Routeを検査する。

## 16.2 CEO AI

- WIPと供給能力を確認する。
- Launch／Conditional／Futureの分類違反を検出する。
- Business Audit同時1件、Website本格制作同時1件、AI Sprint同時1件、継続支援最大3社を監視する。
- 新サービス追加や昇格をType 1案件としてオーナーへ上申する。

## 16.3 Client Success AI

- 契約容量、顧客責任、期限、承認待ちを監視する。
- Business Growth Programの無制限対応を防止する。
- 保守対象と非保守対象を区別する。
- 契約外作業を追加見積候補として起票する。

## 16.4 Knowledge AI

- サービス成果物、失敗、再利用部品を収穫する。
- 実証によるConditionalからLaunchへの昇格候補を検出する。
- 旧サービス名や未承認価格の残存を検出する。

## 16.5 PBOS AI

- サービス別の売上、粗利、工数、転換率、資産化を計測する。
- 継続的に粗利70%を下回るサービスを警告する。
- WIP超過と供給制約を検出する。
- 昇格、縮小、退役、Killの材料を提示する。

---

# 17. Owner Approval Requirements

次はType 1としてオーナーが決定し、理由と却下した代替案を記録する。

1. 本書の正式採用
2. Launch Servicesの追加・削除
3. Conditional／Future／Do Not Offerの分類変更
4. 新サービスの追加
5. 価格モデルの変更
6. 単品販売可否の変更
7. Business Audit Routeの変更
8. 非提供領域への参入
9. WIP上限の変更
10. Business Growth Programの最大契約数変更
11. AI Serviceの販売範囲変更
12. Enterprise Serviceの正式販売開始
13. 重大な外部委託・専門家連携モデル
14. サービスの退役

AIはサービスの選定、比較、ドラフト、検査を行える。最終提案、最終価格、契約、Conditional Serviceの受注、Future Serviceの例外受注、AI業務導入スプリントの本番利用、分類変更、WIP上限の例外はオーナー承認を必須とする。

AI CompanyはOwner ApprovalをHuman Approvalまたは確信度で代替してはならない（MUST NOT）。承認対象は、明示的な承認が記録されるまで未承認として扱わなければならない（MUST）。

---

# 18. Adoption Checklist

## 18.1 文書

- [x] オーナーによるType 1承認が記録されている
- [x] ステータスをDRAFT-FOR-ADOPTIONからACTIVEへ変更する承認がある
- [x] 承認日とDecision Record IDが記載されている
- [x] `company/INDEX.md`でACTIVEな正典として登録する承認がある

## 18.2 Launch Services

- [x] Launch Servicesが12種である
- [x] 正式サービスIDがLS-01からLS-12まで一意である
- [x] 各サービスの正式名称、成果物、非提供範囲が確定している
- [x] Owner Approval Level、Success KPI、Customer Responsibilities、Acceptance Criteriaが確定している
- [x] Business Audit Routeと単品販売可否が確定している

## 18.3 Pricing

- [ ] Pricing Governanceの初期対象がLaunch Services 12種に限定されている
- [ ] Conditional Servicesは共通見積規則のみで扱う
- [ ] Future Servicesに価格を設定しない
- [ ] ツール名に独立商品価格を付けない
- [ ] 粗利70%以上の規則を接続する

## 18.4 Contract

- [ ] Launch Serviceごとの契約類型がある
- [ ] 成果物、非提供範囲、顧客責任、検収を条文化できる
- [ ] Photographyの外部協力責任を定義できる
- [ ] AI業務導入スプリントのAI利用条項を定義できる
- [ ] 保守の要否を明記できる

## 18.5 Capacity

- [ ] Business Audit同時1件を運用できる
- [ ] Website本格制作同時1件を監視できる
- [ ] AI業務導入スプリント同時1件を監視できる
- [ ] 継続支援最大3社を監視できる
- [ ] 月額作業容量を契約ごとに固定できる
- [ ] 無制限対応を禁止できる

## 18.6 Sales and AI

- [ ] Business Auditを最も推奨する入口として説明できる
- [ ] 単品サービスを第二入口として説明できる
- [ ] Conditional Servicesを通常のサービス一覧へ掲載しない
- [ ] Future AI Servicesを販売可能と誤認させない
- [ ] 「AI活用・業務自動化の導入支援」が現在はAI業務導入スプリントを指すと説明できる
- [ ] Sales AIが分類とRouteを検査できる

---

# 19. Decision Record

| 項目 | 内容 |
|---|---|
| Decision ID | DR-2026-07-17-001 |
| Decision Status | APPROVED |
| Decision Type | Canonical Document Adoption / Service Architecture |
| Decision Date | 2026-07-17 |
| Approver | PHOSARA Owner |
| Adoption Target | `company/05_services/PHOSARA_SERVICE_CATALOG_v1_0.md` v1.0 |
| Decision Summary | 本書をPHOSARAの販売可能サービスに関するACTIVEな領域別正典として正式採択する |
| Reason | サービス分類、提供境界、Business Audit Route、単品販売、WIP、AI判断基準を一元化し、一サービス一コードで一意に参照できるようにするため |
| Adopted Code System | LS-01〜LS-12／CS-01〜CS-20／FS-01〜FS-08 |
| Lifecycle Decision | Conditional ServicesはConditional、Future ServicesはFutureを維持し、今回の採択では昇格しない |
| WIP Decision | Business Audit 1／Website本格制作 1／AI業務導入スプリント 1／継続支援 3 |
| Pricing and Contract Delegation | 価格額および契約条件は本書で決定せず、Pricing GovernanceおよびContract Systemへ委任する |
| Alternatives Considered | 現行文書に分散したサービス記述を維持する案／Pricing Governance内でサービス定義と価格を同時管理する案／提出版のCORE・S・G・M・OP・P体系を正本コードとして採用する案 |
| Rejected Alternatives and Reasons | 分散管理案は重複・競合と参照揺れを残すため却下。価格文書との統合案はサービス定義と価格統制の責任分界を損なうため却下。CORE・S・G・M・OP・P体系は既存LS・CS・FSのLifecycleと一サービス一コードの連続性を損なうため不採択 |
| Effective Date | 2026-07-17 |

本DecisionはオーナーによるType 1承認に基づき、Decision Dateと同日に発効する。採択はサービス体系と提供境界を対象とし、価格額、契約条件、納期、返金条件の決定を含まない。

---

# 20. Machine-Readable Summary

以下は本文の分類・ID・統制点を機械処理しやすい形で要約したものである。本文と不一致がある場合は、正式採用後の本文規則を優先し、不一致をConflictとして報告する。

```yaml
schema_version: "1.0"

document:
  id: PHOSARA_SERVICE_CATALOG_v1_0
  version: v1.0
  status: ACTIVE
  effective: true
  owner: PHOSARA HQ Owner
  approver: PHOSARA Owner
  last_updated: 2026-07-17
  effective_date: 2026-07-17
  canonical_path: company/05_services/PHOSARA_SERVICE_CATALOG_v1_0.md

decision:
  id: DR-2026-07-17-001
  status: APPROVED
  type: CANONICAL_DOCUMENT_ADOPTION
  decision_date: 2026-07-17
  effective_date: 2026-07-17
  approver: PHOSARA Owner
  adopted_code_system: [LS, CS, FS]
  rejected_code_system: [CORE, S, G, M, OP, P]
  lifecycle_promotions: false
  pricing_and_contract_terms_delegated: true

status_classification:
  document_status: ACTIVE
  decision_status: APPROVED
  effective: true
  approver: PHOSARA Owner
  effective_date: 2026-07-17

service_counts:
  launch: 12
  conditional: 20
  future_enterprise: 8

launch_services:
  - { id: LS-01, name: "PHOSARA事業監査", route: SELF }
  - { id: LS-02, name: "Webサイト事業成果診断", route: OPTIONAL }
  - { id: LS-03, name: "ブランド明確性診断", route: OPTIONAL }
  - { id: LS-04, name: "解決策設計", route: RECOMMENDED }
  - { id: LS-05, name: "ブランド戦略・アイデンティティ設計", route: SPECIALIST_ASSESSMENT_REQUIRED }
  - { id: LS-06, name: "販促コミュニケーションデザイン", route: OPTIONAL }
  - { id: LS-07, name: "営業コミュニケーション資料設計", route: RECOMMENDED }
  - { id: LS-08, name: "事業コンテンツ制作", route: OPTIONAL }
  - { id: LS-09, name: "事業Webサイト設計・構築", route: RECOMMENDED }
  - { id: LS-10, name: "地域検索・店舗情報最適化", route: OPTIONAL }
  - { id: LS-11, name: "PHOSARA事業成長プログラム", route: SPECIALIST_ASSESSMENT_REQUIRED }
  - { id: LS-12, name: "AI業務導入スプリント", route: SPECIALIST_ASSESSMENT_REQUIRED }

conditional_services:
  ids: [CS-01, CS-02, CS-03, CS-04, CS-05, CS-06, CS-07, CS-08, CS-09, CS-10, CS-11, CS-12, CS-13, CS-14, CS-15, CS-16, CS-17, CS-18, CS-19, CS-20]
  public_listing: false
  public_parent_expression: "その他、課題に応じた専門支援"

future_enterprise_services:
  ids: [FS-01, FS-02, FS-03, FS-04, FS-05, FS-06, FS-07, FS-08]
  normal_sales: false
  public_listing: false
  pricing_defined: false

do_not_offer:
  - n8n導入
  - MCP Integration単体
  - ChatGPT導入
  - Claude導入
  - プロンプト単体販売
  - 印刷・配送
  - 施工・建設
  - 広告枠・媒体費の再販売
  - 口コミ購入・レビュー操作
  - 検索順位・売上・AI精度の保証
  - 汎用的な記録撮影
  - 投稿本数だけを売るSNS代行
  - 人間承認を外した高リスクAI
  - 一般的なカスタムソフトウェア受託開発
  - ネイティブアプリ受託開発
  - 広告費の立替または融資
  - SNS完全代行
  - 弁護士・税理士・社会保険労務士等の士業業務
  - 成果報酬のみの受託契約

wip_limits:
  business_audit_concurrent: 1
  website_full_build_concurrent: 1
  ai_business_adoption_sprint_concurrent: 1
  continuous_support_clients_max: 3
  unlimited_support_contracts_allowed: false

recommendation_flow:
  exits: [BUSINESS_AUDIT, STANDALONE_LAUNCH_SERVICE, DECLINE_OR_DEFER]
  conditional_normal_sale: false
  future_normal_sale: false

business_audit_route_summary:
  priority_entry: LS-01
  standalone_services_as_second_entry: true
  required_escalation_conditions:
    - 複数領域
    - 高額または長期投資
    - 複数拠点または複数部門
    - 経営方針変更
    - 手段先行
    - KPI不在
    - 失敗原因不明
    - 高リスクAI・Automation・個人情報・機密情報

owner_approval_required_actions:
  - document_adoption
  - service_addition_or_removal
  - classification_change
  - pricing_model_change
  - standalone_policy_change
  - business_audit_route_change
  - non_included_scope_entry
  - wip_limit_exception_or_change
  - conditional_service_acceptance
  - future_service_exception
  - ai_sprint_production_use
  - final_price
  - contract
  - final_external_proposal
  - service_retirement
```

---

# 21. Change Log

| 版 | 日付 | ステータス | 内容 |
|---|---|---|---|
| v1.0 | 2026-07-15 | DRAFT-FOR-ADOPTION | PHOSARAのサービス体系を初めて一元定義。Launch Services 12種、Conditional Services 20種、Future / Enterprise Services 8種、Do Not Offer、Business Audit Route、単品販売、WIP、Service Lifecycle、Pricing・Contract・AI Companyへの接続を制定 |
| v1.0 統合候補更新 | 2026-07-17 | DRAFT-FOR-ADOPTION | 提出版からサービス説明、工程成果物、最終成果物、対象顧客、適用条件、非対応範囲、Recommendation Flow、Service Matrix、Deliverables Matrix、Do Not Offer境界を選択統合。CORE・S・G・M・OP・Pコード体系は不採用とし、LS・CS・FSを維持。Lifecycleの昇格、価格、契約条件、Effective Dateの変更なし |
| v1.0 正式採択 | 2026-07-17 | ACTIVE | `DR-2026-07-17-001`によりLS・CS・FS体系を正本として正式採択。CORE・S・G・M・OP・P体系は不採択。Conditional／Futureの昇格なし。WIPを1／1／1／3で確定し、価格・契約条件はPricing Governance／Contract Systemへ委任 |

---

**PHOSARA_SERVICE_CATALOG_v1_0 — ACTIVE — EFFECTIVE 2026-07-17 — DR-2026-07-17-001**

*PHOSARAが販売するのは、制作物でもツールでもない。顧客の事業にとって、いま必要な正しい一手である。*
