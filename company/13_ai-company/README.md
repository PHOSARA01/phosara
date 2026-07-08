# PHOSARA AI Company — 設計資産ディレクトリ

| 項目 | 内容 |
|---|---|
| ディレクトリ | `company/13_ai-company/` |
| 管轄 | PHOSARA HQ |
| 状態 | ACTIVE（正典） |
| 目的 | AI Company実装・Claude Code・n8n・MCP開発の唯一の参照先 |
| 更新ルール適用 | `PBOS_UPDATE_WORKFLOW.md` に従う |

---

## 概要

このディレクトリは PHOSARA AI Company の全設計資産を管理する。
オーナーの戦略・最終決定だけに集中できる会社運営を実現するための AI 従業員定義と実装計画を格納する。

**AIが実行する。オーナーが承認する。人間が責任を負う。** — この原則のもとに設計されたすべての文書はここを参照起点とする。

---

## ディレクトリ構成

```
13_ai-company/
├── README.md                                  ← このファイル（起点）
├── PHOSARA_AI_COMPANY_OS_v1.md                ← AI企業憲法・最上位文書（必ず先に読む）
├── PHOSARA_AI_IMPLEMENTATION_ROADMAP.md       ← 実装ロードマップ（実装順と依存関係）
└── agents/                                    ← AI従業員定義書
    ├── PHOSARA_AI_CEO_AGENT_v1.md             ← CEO AI（統括・意思決定補佐）
    ├── PHOSARA_AI_SALES_AGENT_v1.md           ← Sales AI（営業実行）
    ├── PHOSARA_AI_CLIENT_SUCCESS_AGENT_v1.md  ← Client Success AI（顧客対応）
    ├── PHOSARA_AI_KNOWLEDGE_AGENT_v1.md       ← Knowledge AI（知識管理）
    └── PHOSARA_AI_PBOS_AGENT_v1.md            ← PBOS AI（KPI・ROI管理）
```

---

## 読む順番

実装・参照するすべての関係者（人間・AIエージェント）は以下の順番で読むこと。

| 順番 | ファイル | 理由 |
|---|---|---|
| 1 | `PHOSARA_AI_COMPANY_OS_v1.md` | AI企業の憲法。すべての判断基準がここにある |
| 2 | `PHOSARA_AI_IMPLEMENTATION_ROADMAP.md` | 実装の全体像・フェーズ・優先順位を把握する |
| 3 | `agents/PHOSARA_AI_CEO_AGENT_v1.md` | 統括 AI の役割・権限・報告構造を理解する |
| 4 | `agents/PHOSARA_AI_SALES_AGENT_v1.md` | MVP実装の最初の AI 従業員 |
| 5 | `agents/PHOSARA_AI_CLIENT_SUCCESS_AGENT_v1.md` | MVP実装の第2の AI 従業員 |
| 6 | `agents/PHOSARA_AI_KNOWLEDGE_AGENT_v1.md` | MVP実装の第3の AI 従業員 |
| 7 | `agents/PHOSARA_AI_PBOS_AGENT_v1.md` | Phase 2 以降に接続する AI 従業員 |

---

## 依存関係

```
HQ Core (company/01_hq-core/)
└── Company OS v2.0 (company/02_company-os/)
    └── AI Company OS v1.0  ← 本ディレクトリの最上位文書
        ├── Implementation Roadmap
        └── agents/
            ├── CEO Agent      → 全 Agent を統括
            ├── Sales Agent    → SALES_TARGET_LIST・SALES_LOG と連携
            ├── CS Agent       → CLIENT_SUCCESS_PLAYBOOK と連携
            ├── Knowledge Agent → PBOS・KNOWLEDGE_FINAL_REVIEW と連携
            └── PBOS Agent     → PBOS Gold Edition (docs/08_PBOS/) と連携
```

**上位文書との関係：**
- `HQ Core` および `Company OS v2.0` が最上位。本ディレクトリの内容はこれらに矛盾しない範囲でのみ有効
- 矛盾が発生した場合は HQ Core を優先し、本ディレクトリを更新する

---

## 更新ルール

| 対象 | ルール |
|---|---|
| `PHOSARA_AI_COMPANY_OS_v1.md` | HQ の明示的な承認なしに変更禁止 |
| `PHOSARA_AI_IMPLEMENTATION_ROADMAP.md` | フェーズ完了・計画変更のたびに更新。バージョン番号を上げる |
| `agents/*.md` | 各 Agent の実装・検証後に仕様変更を反映。バージョン番号を上げる |
| `README.md` | ディレクトリ構成・依存関係が変わったときのみ更新 |
| 更新手順 | `PBOS_UPDATE_WORKFLOW.md` に従い、変更をPBOSへ反映する |

---

> **参照禁止：** `company/99_archive/` に移動したファイルは廃止版。参照・使用禁止。
