# PHOSARA HQ — 資産インデックス

Claude Code がこのリポジトリで作業する際の参照起点。
最新の正典 Markdown 資産はすべて `company/` ディレクトリ下に格納されています。

---

## 参照優先順位

| 優先 | ディレクトリ | 内容 | 主要ファイル |
|------|-------------|------|-------------|
| 最高 | `01_hq-core/` | HQ Core — 全資産の根拠・原則 | `PHOSARA_HQ_CORE_v1_0.md` (50KB) |
| 高 | `00_brand/` | ブランド最終レビュー | `BRAND_FINAL_REVIEW.md` |
| 高 | `02_company-os/` | Company OS v2.0 + 実行ファイル群 | `PHOSARA_COMPANY_OS_v2_0.md`, `WORKFLOW.md`, `AGENTS.md` |
| 高 | `04_sales/` | 営業標準書・現場ガイド・ログ規程・対象選定基準・営業対象リスト・実行ツールキット・初回営業先決定 | `SALES_PLAYBOOK_v2.md`, `SALES_FIELD_GUIDE.md`, `SALES_LOG_STANDARD.md`, `SALES_TARGET_CRITERIA.md`, `SALES_TARGET_LIST_TOCHIGI_v1.md`, `SALES_EXECUTION_TOOLKIT.md`, `FIRST_SALES_TARGET_DECISION.md` |
| 高 | `05_website/` | Webサイト最終レビュー | `WEBSITE_FINAL_REVIEW.md` |
| 高 | `11_client-success/` | Client Success Playbook・BAコミュニケーションテンプレート | `CLIENT_SUCCESS_PLAYBOOK.md`, `BUSINESS_AUDIT_COMMUNICATION_TEMPLATES.md` |
| 参照 | `12_knowledge/` | ナレッジ最終レビュー・PBOS更新ワークフロー | `KNOWLEDGE_FINAL_REVIEW.md`, `PBOS_UPDATE_WORKFLOW.md` |
| 高 | `13_ai-company/` | AI Company設計資産（AI企業OS・実装ロードマップ・AI従業員定義） | `PHOSARA_AI_COMPANY_OS_v1.md`, `PHOSARA_AI_IMPLEMENTATION_ROADMAP.md`, `agents/` |
| 高 | `05_audit-kit/` | Business Audit Kit v1.0（16ファイル） | `BUSINESS_AUDIT_SYSTEM.md`, `AUDIT_CHECKLIST.md` |
| 高 | `10_skills/` | 共通思考プロトコル・Skills Library（全AI部署適用） | `PHOSARA_META_THINKING_SYSTEM_v1_0.md`, `PHOSARA_SKILLS_LIBRARY_v1_VOLUME1_THINKING_AND_DECISION.md`, `PHOSARA_SKILLS_LIBRARY_v1_VOLUME2_SALES_AND_BUSINESS_AUDIT.md` |
| 中 | `08_execution-os/` | Automation & Execution OS | `PHOSARA_EXECUTION_OS_v1_0.md` |
| 中 | `09_client-zero/` | Client Zero 実行システム | `PHOSARA_CLIENT_ZERO_EXECUTION_v1_0_1.md`（最新） |
| 参照 | `06_pricing/` | 料金・価格ガバナンス | `PHOSARA_PRICING_GOVERNANCE_v1_0.md` |
| 参照 | `07_contracts/` | 契約システム | `PHOSARA_CONTRACT_SYSTEM_v1_0.md` |
| 参照 | `04_revenue-agent/` | 60日売上エージェント | `PHOSARA_60DAY_REVENUE_AGENT.md` |
| 参照 | `03_pbos/` | PBOS（`docs/08_PBOS/` とのコピー） | `PHOSARA_PBOS_Gold_Edition.md` |
| 将来 | `00_constitution/` | Constitution（現在は HQ Core 内に含有） | — |
| 禁止 | `99_archive/` | 廃止版。参照・使用禁止 | — |

---

## ディレクトリ構造

```
company/
├── INDEX.md                         ← このファイル
├── 00_brand/
│   └── BRAND_FINAL_REVIEW.md        ← ブランド最終レビュー
├── 00_constitution/                 ← Constitution 独立化に備えたプレースホルダー
├── 01_hq-core/
│   └── PHOSARA_HQ_CORE_v1_0.md
├── 02_company-os/
│   ├── PHOSARA_COMPANY_OS_v2_0.md
│   ├── STATE.md
│   ├── WORKFLOW.md
│   ├── AGENTS.md
│   ├── SKILLS.md
│   └── VERIFICATION.md
├── 03_pbos/
│   └── PHOSARA_PBOS_Gold_Edition.md
├── 04_revenue-agent/
│   └── PHOSARA_60DAY_REVENUE_AGENT.md
├── 04_sales/
│   ├── SALES_PLAYBOOK_v2.md                  ← 営業標準書
│   ├── SALES_FIELD_GUIDE.md                  ← 営業現場ガイド v1.0
│   ├── SALES_LOG_STANDARD.md                 ← 営業ログ規程 v1.1
│   ├── SALES_TARGET_CRITERIA.md              ← 営業対象選定基準 v1.0
│   ├── SALES_TARGET_LIST_TOCHIGI_v1.md       ← 栃木県営業対象リスト v1.0
│   ├── SALES_EXECUTION_TOOLKIT.md            ← 営業実行ツールキット
│   └── FIRST_SALES_TARGET_DECISION.md        ← 初回営業先決定
├── 05_website/
│   └── WEBSITE_FINAL_REVIEW.md  ← Webサイト最終レビュー
├── 05_audit-kit/
│   ├── BUSINESS_AUDIT_SYSTEM.md
│   ├── AUDIT_CHECKLIST.md
│   ├── AUDIT_REPORT_TEMPLATE.md
│   ├── AUDIT_VERIFICATION.md
│   ├── AUDIT_WORKFLOW.md
│   ├── BUSINESS_AUDIT_SKILLS.md
│   ├── CASE_STUDY_PROCESS.md
│   ├── CLIENT_INTERVIEW_GUIDE.md
│   ├── CLIENT_JOURNEY.md
│   ├── FOLLOWUP_REFERRAL_PROCESS.md
│   ├── IMPROVEMENT_ROADMAP_TEMPLATE.md
│   ├── PROPOSAL_BRIDGE.md
│   ├── QUESTION_LIBRARY.md
│   ├── QUICK_WIN_LIBRARY.md
│   ├── RED_FLAG_RULES.md
│   └── SCORING_SYSTEM.md
├── 06_pricing/
│   └── PHOSARA_PRICING_GOVERNANCE_v1_0.md
├── 07_contracts/
│   └── PHOSARA_CONTRACT_SYSTEM_v1_0.md
├── 08_execution-os/
│   ├── PHOSARA_EXECUTION_OS_v1_0.md
│   └── PHOSARA_FINAL_INTEGRATION_REVIEW_v1_0.md
├── 09_client-zero/
│   ├── PHOSARA_CLIENT_ZERO_EXECUTION_v1_0.md
│   └── PHOSARA_CLIENT_ZERO_EXECUTION_v1_0_1.md  ← 最新版
├── 10_skills/
│   ├── PHOSARA_META_THINKING_SYSTEM_v1_0.md              ← 全AI部署共通思考プロトコル
│   ├── PHOSARA_SKILLS_LIBRARY_v1_VOLUME1_THINKING_AND_DECISION.md  ← Skills Library Vol.1
│   └── PHOSARA_SKILLS_LIBRARY_v1_VOLUME2_SALES_AND_BUSINESS_AUDIT.md  ← Skills Library Vol.2
├── 11_client-success/
│   ├── CLIENT_SUCCESS_PLAYBOOK.md                      ← Client Success Playbook
│   └── BUSINESS_AUDIT_COMMUNICATION_TEMPLATES.md       ← BAコミュニケーションテンプレート
├── 12_knowledge/
│   ├── KNOWLEDGE_FINAL_REVIEW.md  ← ナレッジ最終レビュー
│   └── PBOS_UPDATE_WORKFLOW.md    ← PBOS更新ワークフロー v1.0
├── 13_ai-company/
│   ├── README.md                                  ← 起点・読む順番・依存関係
│   ├── PHOSARA_AI_COMPANY_OS_v1.md                ← AI企業憲法（最上位）
│   ├── PHOSARA_AI_IMPLEMENTATION_ROADMAP.md       ← 実装ロードマップ
│   └── agents/
│       ├── PHOSARA_AI_CEO_AGENT_v1.md             ← CEO AI
│       ├── PHOSARA_AI_SALES_AGENT_v1.md           ← Sales AI
│       ├── PHOSARA_AI_CLIENT_SUCCESS_AGENT_v1.md  ← Client Success AI
│       ├── PHOSARA_AI_KNOWLEDGE_AGENT_v1.md       ← Knowledge AI
│       └── PHOSARA_AI_PBOS_AGENT_v1.md            ← PBOS AI
└── 99_archive/
    ├── company-os-pre-v1.0/                      ← 旧 OS ファイル（参照禁止）
    └── audit-kit-v1.0/                           ← 旧監査キット（参照禁止）
```

---

## 作業ルール（Claude Code 向け）

- **改変前は必ずオーナーの承認を得ること**
- `99_archive/` は読み取り専用。参照・使用・コピー禁止
- `00_constitution/` はプレースホルダー。Constitution を作成する際は `01_hq-core/PHOSARA_HQ_CORE_v1_0.md` を元に独立ファイル化する
- PBOS は `docs/08_PBOS/PHOSARA_PBOS_Gold_Edition.md` が正規の場所。`03_pbos/` はコピー（同期が必要な場合は両方を更新）
- Client Zero の最新版は `09_client-zero/PHOSARA_CLIENT_ZERO_EXECUTION_v1_0_1.md`
