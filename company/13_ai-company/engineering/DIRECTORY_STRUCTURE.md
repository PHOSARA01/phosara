# PHOSARA AI Sales Agent — ディレクトリ設計

| 項目 | 内容 |
|---|---|
| 文書ID | PHOSARA_AI_DIRECTORY_STRUCTURE_v1 |
| 版 | v1.0 |
| 発効日 | 2026-07-13 |
| 状態 | ACTIVE |

---

## 1. リポジトリ全体構造（AI Agent 関連部分）

```
phosara/                                      ← GitHub リポジトリルート
│
├── ai-agent/                                 ← AI社員 実行環境（新規作成）
│   ├── CLAUDE.md                             ← Sales Agent システムプロンプト
│   ├── mcp-config.json                       ← MCP サーバー設定
│   │
│   ├── prompts/                              ← Claude Code 用タスクプロンプト
│   │   ├── research.md                       ← Step 4: Web調査
│   │   ├── ba-analysis.md                    ← Step 5: BA価値分析
│   │   ├── message-gen.md                    ← Step 6: 営業文生成
│   │   └── self-review.md                    ← Step 7-8: 自己レビュー+スコア
│   │
│   ├── state/                                ← 実行状態管理
│   │   └── SALES_STATE.md                    ← 現在の状態（WAITING_APPROVAL等）
│   │
│   ├── queue/                                ← 承認キュー
│   │   └── OWNER_APPROVAL_QUEUE.md           ← オーナーが読み・書き込む
│   │
│   └── logs/                                 ← 実行ログ
│       ├── SALES_LOG.md                      ← 全状態遷移ログ（追記のみ）
│       └── CONFLICT_LOG.md                   ← 仕様矛盾・例外記録
│
├── scripts/                                  ← 実行スクリプト（新規作成）
│   ├── morning-batch.sh                      ← TRG-01: 朝バッチ
│   ├── evening-batch.sh                      ← TRG-02: 夕バッチ
│   └── verify-setup.sh                       ← セットアップ確認
│
├── n8n/                                      ← n8n ワークフロー定義（新規作成）
│   ├── workflows/
│   │   ├── sales-morning-batch.json          ← 朝バッチワークフロー
│   │   ├── sales-approval-notifier.json      ← 承認通知ワークフロー
│   │   └── sales-evening-report.json         ← 夕バッチワークフロー
│   └── README.md                             ← n8n セットアップ手順
│
├── company/                                  ← 既存の会社資産（変更しない）
│   ├── 04_sales/                             ← 営業標準（読み取り専用）
│   │   ├── SALES_TARGET_LIST_TOCHIGI_v1.md  ← Agent の入力データ
│   │   ├── SALES_TARGET_CRITERIA.md
│   │   ├── SALES_PLAYBOOK_v2.md
│   │   ├── SALES_FIELD_GUIDE.md
│   │   ├── SALES_EXECUTION_TOOLKIT.md
│   │   └── SALES_LOG_STANDARD.md
│   │
│   └── 13_ai-company/                        ← AI Company 資産
│       ├── agents/                           ← Agent 定義（読み取り専用）
│       │   └── PHOSARA_AI_SALES_AGENT_v1.md
│       ├── runtime/                          ← Runtime 仕様（読み取り専用）
│       │   └── PHOSARA_AI_SALES_RUNTIME_v1.md
│       ├── implementation/                   ← 運用ドキュメント
│       │   └── phase1-sales-mvp/
│       │       ├── SALES_MVP_WORKFLOW.md     ← 設計仕様（読み取り専用）
│       │       ├── SALES_MVP_STATE.md
│       │       └── OWNER_APPROVAL_QUEUE.md   ← ai-agent/queue/ と同期
│       └── engineering/                      ← 工学実装ドキュメント（本書）
│           ├── PHOSARA_AI_SALES_IMPLEMENTATION_PLAN.md
│           ├── SYSTEM_ARCHITECTURE.md
│           ├── DIRECTORY_STRUCTURE.md        ← 本書
│           ├── ENVIRONMENT_VARIABLES.md
│           ├── MCP_SERVER_LIST.md
│           ├── N8N_WORKFLOW_PLAN.md
│           └── IMPLEMENTATION_TASKS.md
│
└── .env.example                              ← 環境変数テンプレート（gitignore済み）
```

---

## 2. ai-agent/ ディレクトリ詳細

### 2.1 CLAUDE.md（最重要ファイル）

Claude Code がこのディレクトリで起動したとき最初に読み込む設定。

```markdown
# PHOSARA AI Sales Agent — Claude Code 設定

## あなたの役割
あなたは PHOSARA の AI Sales Agent です。
...（Sales Agent システムプロンプト）...

## 読み込む Knowledge
実行開始時に必ず以下を読み込む:
- company/04_sales/SALES_TARGET_LIST_TOCHIGI_v1.md
- company/04_sales/SALES_TARGET_CRITERIA.md
- company/04_sales/SALES_PLAYBOOK_v2.md
- company/04_sales/SALES_EXECUTION_TOOLKIT.md
- company/04_sales/SALES_FIELD_GUIDE.md
- company/13_ai-company/implementation/phase1-sales-mvp/SALES_MVP_WORKFLOW.md

## 使用可能なツール
- mcp__filesystem: ファイルの読み書き
- mcp__github: GitHub への読み込み・コミット
- mcp__brave-search: Web 検索
- mcp__fetch: ページ取得

## 禁止事項
- 対外メール・フォームへの送信
- 承認なしの状態遷移
- ログ書き込みなしの状態遷移
```

### 2.2 state/SALES_STATE.md

AI が現在処理中のターゲットと状態を管理するファイル。

```markdown
# SALES_STATE — 現在の状態

| 項目 | 値 |
|---|---|
| 最終更新 | 2026-07-13 09:15 |
| 処理中ターゲット | ST-20260101-003（山田建設） |
| 現在の状態 | WAITING_APPROVAL |
| Confidence Score | 85% |
| エントリID | AQ-20260713-001 |
| 承認期限 | 2026-07-15 09:00 |
```

### 2.3 queue/OWNER_APPROVAL_QUEUE.md

オーナーが読み、承認/差戻しを追記するファイル。

```markdown
# OWNER_APPROVAL_QUEUE — 承認待ちキュー

オーナーへ: 以下のエントリを確認し、承認欄に追記してください。

---
## [AQ-20260713-001] 山田建設株式会社 — 承認待ち
...（三点セット + 営業文全文）...

**オーナーの承認欄（ここに追記してください）：**
→ [ 承認: 案A / 承認: 案B / 差戻し: （理由） ]
```

### 2.4 logs/SALES_LOG.md

すべての状態遷移を時系列で記録。追記のみ。削除・改変禁止。

```markdown
# SALES_LOG

## 2026-07-13

| 時刻 | ターゲットID | 会社名 | 遷移前 | 遷移後 | メモ |
|---|---|---|---|---|---|
| 09:15 | ST-20260101-003 | 山田建設 | NEW | ANALYZING | 朝バッチ開始 |
| 09:22 | ST-20260101-003 | 山田建設 | ANALYZING | READY | 自己レビュー合格 85% |
| 09:23 | ST-20260101-003 | 山田建設 | READY | WAITING_APPROVAL | キュー登録完了 |
```

---

## 3. scripts/ ディレクトリ詳細

### 3.1 morning-batch.sh

```bash
#!/bin/bash
# morning-batch.sh — TRG-01 朝バッチ
# n8n から毎朝 09:00 に呼び出される

set -e

REPO_DIR="$(dirname "$(dirname "$0")")"
AGENT_DIR="$REPO_DIR/ai-agent"
LOG_FILE="$AGENT_DIR/logs/batch-$(date +%Y%m%d).log"

echo "=== Morning Batch Start: $(date) ===" >> "$LOG_FILE"

# Claude Code を Sales Agent として実行
claude \
  --project-dir "$REPO_DIR" \
  --task "$(cat "$AGENT_DIR/prompts/morning-task.md")" \
  --allowedTools "mcp__filesystem,mcp__github,mcp__brave-search,mcp__fetch" \
  >> "$LOG_FILE" 2>&1

echo "=== Morning Batch End: $(date) ===" >> "$LOG_FILE"
```

### 3.2 verify-setup.sh

```bash
#!/bin/bash
# verify-setup.sh — セットアップ確認スクリプト

echo "--- Checking Claude Code ---"
claude --version || { echo "FAIL: claude not found"; exit 1; }

echo "--- Checking MCP Servers ---"
npx @modelcontextprotocol/server-filesystem --version 2>/dev/null || echo "WARN: filesystem MCP not installed"
npx @modelcontextprotocol/server-github --version 2>/dev/null || echo "WARN: github MCP not installed"

echo "--- Checking Environment Variables ---"
[ -n "$ANTHROPIC_API_KEY" ] && echo "OK: ANTHROPIC_API_KEY" || echo "FAIL: ANTHROPIC_API_KEY not set"
[ -n "$GITHUB_PERSONAL_ACCESS_TOKEN" ] && echo "OK: GITHUB_PAT" || echo "FAIL: GITHUB_PAT not set"
[ -n "$BRAVE_SEARCH_API_KEY" ] && echo "OK: BRAVE_SEARCH_API_KEY" || echo "FAIL: BRAVE_SEARCH_API_KEY not set"

echo "--- Done ---"
```

---

## 4. ファイルの読み書きルール

| ファイル | 書き込み主体 | 読み込み主体 | 操作制約 |
|---|---|---|---|
| SALES_TARGET_LIST.md | オーナー | Claude Code | Claude Code は読み取りのみ |
| SALES_STATE.md | Claude Code | Claude Code / n8n | 上書き可（現在状態） |
| OWNER_APPROVAL_QUEUE.md | Claude Code（追記）/ オーナー（追記）| n8n / Claude Code | 削除禁止・追記のみ |
| SALES_LOG.md | Claude Code | オーナー / 監査 | 削除禁止・追記のみ |
| CONFLICT_LOG.md | Claude Code | オーナー | 削除禁止・追記のみ |

---

## 5. gitignore 設定

```gitignore
# 機密情報
.env
*.env.local

# バッチ実行ログ（大量になるため）
ai-agent/logs/batch-*.log

# n8n の実行キャッシュ
n8n/.cache/
```

**gitignore しないもの（GitHub に必ず上げる）:**
- `ai-agent/logs/SALES_LOG.md` — 監査ログのため必須
- `ai-agent/queue/OWNER_APPROVAL_QUEUE.md` — 承認フローのため必須
- `ai-agent/state/SALES_STATE.md` — 状態管理のため必須

---

## 6. 命名規則

| 種別 | 形式 | 例 |
|---|---|---|
| ターゲット ID | `ST-YYYYMMDD-NNN` | `ST-20260101-003` |
| 承認キュー ID | `AQ-YYYYMMDD-NNN` | `AQ-20260713-001` |
| バッチログ | `batch-YYYYMMDD.log` | `batch-20260713.log` |
| ワークフロー JSON | `sales-{機能名}.json` | `sales-morning-batch.json` |

---

*このディレクトリ構造は実装の進捗に応じて更新する。*
*構造変更は CONFLICT_LOG に記録し、本書を同時更新する。*
