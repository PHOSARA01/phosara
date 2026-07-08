# DIRECTORY_STRUCTURE.md — ディレクトリ構造（正典）

| 項目 | 内容 |
|---|---|
| 目的 | PHOSARA AI Company 実装に関わる全ディレクトリ構造の正典 |
| 対象 | Claude Code / n8n / MCP / GitHub が参照する共通仕様 |
| 更新ルール | ディレクトリ構造が変わったときのみ更新。変更は `IMPLEMENTATION_LOG.md` に記録 |

---

## AI Company ディレクトリ全体構造

```
company/
└── 13_ai-company/
    ├── README.md                              ← 起点・読む順番・依存関係（Design Phase）
    ├── PHOSARA_AI_COMPANY_OS_v1.md            ← AI 企業憲法（最上位文書）
    ├── PHOSARA_AI_IMPLEMENTATION_ROADMAP.md   ← 実装ロードマップ
    ├── agents/                                ← AI 従業員定義書
    │   ├── PHOSARA_AI_CEO_AGENT_v1.md
    │   ├── PHOSARA_AI_SALES_AGENT_v1.md
    │   ├── PHOSARA_AI_CLIENT_SUCCESS_AGENT_v1.md
    │   ├── PHOSARA_AI_KNOWLEDGE_AGENT_v1.md
    │   └── PHOSARA_AI_PBOS_AGENT_v1.md
    └── implementation/                        ← 実装基盤（Phase 0 / このディレクトリ）
        ├── README.md                          ← 起点・読む順番（Implementation Phase）
        ├── STATE.md                           ← 共有状態機械
        ├── WORKFLOW.md                        ← トリガー・運転サイクル
        ├── AGENTS.md                          ← AI 従業員レジストリ
        ├── VERIFICATION.md                    ← 確信度モデル・検証基準
        ├── HUMAN_APPROVAL.md                  ← 承認方針
        ├── IMPLEMENTATION_LOG.md              ← Phase 別実装ログ
        ├── DIRECTORY_STRUCTURE.md             ← このファイル
        ├── .env.example                       ← 環境変数テンプレート
        └── logs/
            └── README.md                      ← ログ形式・命名規則
```

---

## Phase 1 以降の追加予定ディレクトリ

Phase 1（Claude Code MVP）以降に追加される予定のディレクトリ。
**現時点では作成しない。** Phase 移行承認後に追加する。

```
implementation/
├── prompts/          ← Phase 1: Claude Code 用プロンプトテンプレート
│   ├── sales/
│   ├── client-success/
│   ├── knowledge/
│   ├── pbos/
│   └── ceo/
├── workflows/        ← Phase 2: n8n ワークフロー定義（JSON / YAML）
├── approvals/        ← Phase 1+: 承認済みタスクのアーカイブ
├── dashboards/       ← Phase 3: KPI ダッシュボード設定
└── archive/          ← 廃止済みファイルの保存場所（参照禁止）
```

---

## ログディレクトリ構造

```
implementation/
└── logs/
    ├── README.md              ← 命名規則・フォーマット（このファイルで定義）
    ├── sales/                 ← Sales AI のログ
    │   └── YYYY-MM-DD_sales_log.md
    ├── client-success/        ← CS AI のログ
    │   └── YYYY-MM-DD_cs_log.md
    ├── knowledge/             ← Knowledge AI のログ
    │   └── YYYY-MM-DD_knowledge_log.md
    ├── pbos/                  ← PBOS AI のログ
    │   └── YYYY-MM-DD_pbos_log.md
    ├── ceo/                   ← CEO AI のログ（Daily CEO Brief を含む）
    │   └── YYYY-MM-DD_ceo_brief.md
    ├── approvals/             ← 承認記録
    │   └── YYYY-MM-DD_approval_[TASK_ID].md
    └── system/                ← 状態遷移・エスカレーション・Failure Log
        └── YYYY-MM-DD_system_log.md
```

**ログディレクトリの作成タイミング：** Phase 1 開始時。現在（Phase 0）は `logs/README.md` のみを配置する。

---

## リポジトリ全体における位置付け

```
phosara/ (リポジトリルート)
├── CLAUDE.md               ← AI エージェント行動基準（最初に読む）
├── company/                ← PHOSARA HQ 正典資産
│   ├── INDEX.md            ← 全資産の索引
│   └── 13_ai-company/      ← AI Company 設計・実装資産
│       └── implementation/ ← このディレクトリ（Phase 0）
├── docs/                   ← 公式資料
│   └── 08_PBOS/            ← PBOS（正規の場所）
├── website/                ← 公式サイト実装
└── scripts/                ← 自動化スクリプト
```

---

## 依存関係マップ

```
CLAUDE.md
 └─ company/INDEX.md
     └─ company/13_ai-company/README.md（Design Phase の起点）
         ├─ PHOSARA_AI_COMPANY_OS_v1.md   ← 最上位。すべての判断基準
         ├─ PHOSARA_AI_IMPLEMENTATION_ROADMAP.md
         ├─ agents/*.md                    ← 各 AI 従業員の職務定義
         └─ implementation/README.md       ← Implementation Phase の起点
             ├─ STATE.md                   ← OS の State Machine を実装基盤化
             ├─ WORKFLOW.md                ← OS の Trigger System を実装基盤化
             ├─ AGENTS.md                  ← agents/*.md を実装目線でレジストリ化
             ├─ HUMAN_APPROVAL.md          ← OS の Approval Policy を実装基盤化
             ├─ VERIFICATION.md            ← OS の Confidence Score を実装基盤化
             ├─ IMPLEMENTATION_LOG.md      ← Phase 進捗・決定の台帳
             ├─ .env.example               ← Secrets テンプレート
             └─ logs/README.md             ← ログ仕様
```

---

## ファイル命名規則

| 対象 | 規則 | 例 |
|---|---|---|
| 正典・仕様書 | `UPPER_SNAKE_CASE.md` | `STATE.md` / `HUMAN_APPROVAL.md` |
| AI 従業員定義書 | `PHOSARA_AI_[NAME]_AGENT_v[N].md` | `PHOSARA_AI_SALES_AGENT_v1.md` |
| 日次ログ | `YYYY-MM-DD_[agent]_log.md` | `2026-07-08_sales_log.md` |
| 承認記録 | `YYYY-MM-DD_approval_[TASK_ID].md` | `2026-07-08_approval_TSK-001.md` |
| プロンプト（Phase 1+） | `[agent]_[purpose]_v[N].md` | `sales_initial_contact_v1.md` |
| 環境変数 | `.env.example` のみリポジトリに含める。`.env` はコミット禁止 | — |
