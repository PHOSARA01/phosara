# PHOSARA AI Sales Agent — 実行環境

## 概要

PHOSARA AI Sales Agent の実行環境。
Claude Code がこのディレクトリで動作し、営業文の生成・承認キューへの登録を行う。

## ディレクトリ構造

```
ai-agent/
├── CLAUDE.md                  ← [最重要] Sales Agent システムプロンプト
├── mcp-config.json            ← MCP サーバー設定テンプレート
├── README.md                  ← このファイル
│
├── prompts/                   ← ステップ別タスクプロンプト
│   ├── morning-task.md        ← 朝バッチのメインタスク（claude -p で使用）
│   ├── research.md            ← Step 4: Web調査
│   ├── ba-analysis.md         ← Step 5: BA価値分析
│   ├── message-gen.md         ← Step 6: 営業文生成
│   └── self-review.md         ← Step 7-8: 自己レビュー + Confidence Score
│
├── state/
│   └── SALES_STATE.md         ← 現在の実行状態（AI が更新）
│
├── queue/
│   └── OWNER_APPROVAL_QUEUE.md ← 承認待ちキュー（AI が追記 / オーナーが承認を追記）
│
└── logs/
    ├── SALES_LOG.md           ← 全状態遷移ログ（追記のみ / 削除禁止）
    ├── CONFLICT_LOG.md        ← 例外・仕様矛盾ログ（追記のみ / 削除禁止）
    └── batch-YYYYMMDD.log     ← バッチ実行ログ（.gitignore 済み）
```

## 実行方法

### 手動実行（動作確認時）

```bash
# リポジトリルートから実行
cd /path/to/phosara

# 環境変数を読み込む
source .env

# 朝バッチを手動実行
bash scripts/morning-batch.sh
```

### 自動実行（n8n から）

`n8n/workflows/sales-morning-batch.json` を n8n にインポートして使用する。
設定方法は `n8n/README.md` を参照。

## ファイルの読み書きルール

| ファイル | 書き込み主体 | 操作制約 |
|---|---|---|
| `SALES_STATE.md` | AI | 上書き可（現在状態の管理） |
| `OWNER_APPROVAL_QUEUE.md` | AI（追記）/ オーナー（承認追記） | 削除禁止・追記のみ |
| `SALES_LOG.md` | AI | 削除禁止・追記のみ |
| `CONFLICT_LOG.md` | AI | 削除禁止・追記のみ |
| `batch-*.log` | scripts | .gitignore 済み |

**`company/` 配下のファイルは AI が書き込まない（読み取り専用）。**

## オーナーの操作方法

1. メールで「承認待ち」通知を受け取る
2. `ai-agent/queue/OWNER_APPROVAL_QUEUE.md` を GitHub で開く
3. エントリ末尾の「オーナーの承認欄」に追記する:
   ```
   → 承認: 案A
   ```
4. GitHub でコミットする（n8n が次のアクションを実行する）

## トラブルシューティング

| 問題 | 対処 |
|---|---|
| バッチが起動しない | `scripts/verify-setup.sh` を実行して確認 |
| MCP エラーが出る | `claude mcp list` で MCP の接続状態を確認 |
| ログファイルが更新されない | `ai-agent/logs/` の書き込み権限を確認 |
| Confidence Score が低い | SALES_TARGET_LIST の当該企業のセクションに情報を追記する |

詳細は `company/13_ai-company/engineering/PHOSARA_AI_SETUP_GUIDE.md` を参照。
