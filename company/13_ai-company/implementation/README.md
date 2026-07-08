# PHOSARA AI Company — Implementation Foundation

| 項目 | 内容 |
|---|---|
| ディレクトリ | `company/13_ai-company/implementation/` |
| 管轄 | PHOSARA HQ |
| Phase | Phase 0（実装基盤） |
| 状態 | ACTIVE |
| 上位文書 | `../PHOSARA_AI_COMPANY_OS_v1.md`（AI企業憲法） |
| 参照対象 | Claude Code / n8n / MCP / GitHub |

---

## 目的

このディレクトリは **PHOSARA AI Company の実装基盤（Phase 0）** を格納する。

AI 従業員が実際に稼働するための共通仕様 — 状態管理・承認フロー・ワークフロー・ログ規程・ディレクトリ構造 — をここで定義する。

実装はここから始まる。設計資産（`../PHOSARA_AI_COMPANY_OS_v1.md` / `../agents/`）との整合は常に維持しなければならない。

---

## 読む順番

| 順番 | ファイル | 内容 |
|---|---|---|
| 1 | `README.md`（このファイル） | 全体像・構成・依存関係 |
| 2 | `DIRECTORY_STRUCTURE.md` | ディレクトリ構造の正典 |
| 3 | `STATE.md` | 状態機械（全 AI 従業員が共有する 8 状態） |
| 4 | `WORKFLOW.md` | トリガー・日次/週次/月次サイクル |
| 5 | `AGENTS.md` | AI 従業員レジストリ・責任範囲・ハンドオフ規約 |
| 6 | `HUMAN_APPROVAL.md` | 承認方針（AI 自律実行 vs オーナー承認の境界） |
| 7 | `VERIFICATION.md` | 確信度モデル・検証チェックリスト |
| 8 | `IMPLEMENTATION_LOG.md` | Phase 別実装ログ（現在地の把握） |
| 9 | `.env.example` | 環境変数テンプレート（Secrets 管理） |
| 10 | `logs/README.md` | ログ形式・命名規則 |

---

## ディレクトリ構成

```
implementation/
├── README.md                ← このファイル（起点）
├── STATE.md                 ← 共有状態機械（8 状態）
├── WORKFLOW.md              ← トリガー・運転サイクル
├── AGENTS.md                ← AI 従業員レジストリ・ハンドオフ規約
├── VERIFICATION.md          ← 確信度モデル・検証基準
├── HUMAN_APPROVAL.md        ← 承認方針（境界定義）
├── IMPLEMENTATION_LOG.md    ← Phase 別実装ログ
├── DIRECTORY_STRUCTURE.md   ← 全体ディレクトリ構造（正典）
├── .env.example             ← 環境変数テンプレート
└── logs/
    └── README.md            ← ログ形式・命名規則
```

---

## 依存関係

```
HQ Core (company/01_hq-core/)
└── Company OS v2.0 (company/02_company-os/)
    └── AI Company OS v1.0 (company/13_ai-company/PHOSARA_AI_COMPANY_OS_v1.md)
        └── Implementation Foundation ← このディレクトリ（Phase 0）
            ├── STATE.md      ← AI Company OS の「Shared State Machine」を実装基盤化
            ├── WORKFLOW.md   ← AI Company OS の「Trigger System / Daily Cycle」を実装基盤化
            ├── AGENTS.md     ← agents/*.md を実装目線でレジストリ化
            ├── HUMAN_APPROVAL.md  ← AI Company OS の「Human Approval Policy」を実装基盤化
            └── VERIFICATION.md   ← AI Company OS の「Confidence Score」を実装基盤化
```

**整合の原則：**
- 本ディレクトリの内容は `PHOSARA_AI_COMPANY_OS_v1.md` に矛盾しない範囲でのみ有効
- 矛盾が発生した場合は HQ Core を最優先とし、本ディレクトリを更新する
- エージェント定義の権威は `../agents/*.md` が持つ。本ディレクトリはそれを実装目線で参照・展開する

---

## Phase ロードマップ（概要）

| Phase | 内容 | 状態 |
|---|---|---|
| **Phase 0** | 実装基盤構築（このディレクトリ） | ✅ ACTIVE |
| Phase 1 | Claude Code MVP（Sales / CS / Knowledge Agent） | 待機中 |
| Phase 2 | n8n ワークフロー接続 | 待機中 |
| Phase 3 | PBOS / CEO Agent 接続・KPI 計測 | 待機中 |
| Phase 4 | 全自動ループ・Daily CEO Brief 完全稼働 | 待機中 |

Phase 移行条件は `IMPLEMENTATION_LOG.md` に記載する。

---

## Phase 0 完了条件（チェックリスト）

- [ ] 全 AI 関連ファイルの保存場所が確定している
- [ ] ログ保存形式が確定している（`logs/README.md`）
- [ ] Secrets 管理方針が確定している（`.env.example`）
- [ ] 実装対象と非対象が明確である（`HUMAN_APPROVAL.md`）
- [ ] 状態機械が文書化されている（`STATE.md`）
- [ ] 承認フローが文書化されている（`HUMAN_APPROVAL.md`）
- [ ] Claude Code がディレクトリ全体を参照できる状態になっている

---

## 更新ルール

| 対象 | ルール |
|---|---|
| `STATE.md` / `WORKFLOW.md` / `AGENTS.md` | AI Company OS v1.0 が改版されたとき同期更新 |
| `HUMAN_APPROVAL.md` | 承認方針の変更はオーナー承認必須 |
| `IMPLEMENTATION_LOG.md` | Phase 完了・移行ごとに追記（上書き禁止） |
| `DIRECTORY_STRUCTURE.md` | ディレクトリ構造が変わったときのみ更新 |
| `.env.example` | 新ツール追加・キー変更のたびに更新 |
| `logs/README.md` | ログ形式変更のたびに更新 |
