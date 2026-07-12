# PHOSARA AI Sales Agent — 実装タスク一覧

| 項目 | 内容 |
|---|---|
| 文書ID | PHOSARA_AI_IMPLEMENTATION_TASKS_v1 |
| 版 | v1.0 |
| 発効日 | 2026-07-13 |
| 状態 | ACTIVE |

---

## タスク優先度の定義

| Priority | 意味 | 条件 |
|---|---|---|
| **Priority 1** | MVP 起動に必須。これなしでは動かない | 全 P1 完了で初回 dry run が可能 |
| **Priority 2** | 重要。なくても動くが品質・安定性が著しく低い | 全 P2 完了で本番稼働が可能 |
| **Priority 3** | Nice to Have。あると便利・拡張性が上がる | 本番稼働後に着手 |

---

## 実装する順番（絶対的な順序）

```
P1-01 → P1-02 → P1-03 → P1-04 → P1-05
  └──── ここまでで環境が完成 ────┘
          ↓
P1-06 → P1-07 → P1-08 → P1-09 → P1-10
  └──── ここまでで Agent が 1 サイクル動く ──┘
          ↓
P1-11 → P1-12
  └──── ここまでで n8n 連携完成 ──┘
          ↓
P2 タスクへ（本番稼働準備）
          ↓
P3 タスクへ（拡張）
```

---

## Priority 1 — MVP 起動に必須

### P1-01: リポジトリ ディレクトリ構造の作成

| 項目 | 内容 |
|---|---|
| 優先度 | Priority 1 — 最初 |
| 所要時間（目安）| 30分 |
| 担当 | Lead AI Engineer |

**実施内容:**
```bash
mkdir -p ai-agent/prompts
mkdir -p ai-agent/state
mkdir -p ai-agent/queue
mkdir -p ai-agent/logs
mkdir -p scripts
mkdir -p n8n/workflows

# 空ファイルで初期化
touch ai-agent/state/SALES_STATE.md
touch ai-agent/queue/OWNER_APPROVAL_QUEUE.md
touch ai-agent/logs/SALES_LOG.md
touch ai-agent/logs/CONFLICT_LOG.md
```

**完了条件:**
- [ ] `ai-agent/` 配下のディレクトリが全て存在する
- [ ] 各 Markdown ファイルが空の状態で作成されている
- [ ] `.gitignore` に `.env` と `batch-*.log` が追記されている

---

### P1-02: .env ファイルの作成と環境変数の設定

| 項目 | 内容 |
|---|---|
| 優先度 | Priority 1 |
| 所要時間 | 30分（API キー取得含む）|
| 担当 | オーナー + Lead AI Engineer |

**実施内容:**
1. `.env.example` をコピーして `.env` を作成
2. 以下の API キーを取得して設定:
   - `ANTHROPIC_API_KEY`（Anthropic Console）
   - `GITHUB_PERSONAL_ACCESS_TOKEN`（GitHub Settings）
   - `BRAVE_SEARCH_API_KEY`（Brave API Dashboard）
3. `GITHUB_REPO_OWNER`, `GITHUB_REPO_NAME` を設定

**完了条件:**
- [ ] `.env` ファイルが存在し、全 必須変数が設定されている
- [ ] `.env` が `.gitignore` に含まれている（誤コミット防止）
- [ ] `scripts/verify-setup.sh` で全変数が「OK」と表示される

---

### P1-03: MCP サーバーのインストール

| 項目 | 内容 |
|---|---|
| 優先度 | Priority 1 |
| 所要時間 | 20分 |
| 担当 | Lead AI Engineer |

**実施内容:**
```bash
npm install -g @modelcontextprotocol/server-filesystem
npm install -g @modelcontextprotocol/server-github
npm install -g @modelcontextprotocol/server-brave-search
npm install -g @modelcontextprotocol/server-fetch
```

**完了条件:**
- [ ] 4つの MCP サーバーが `npm list -g` に表示される
- [ ] `verify-setup.sh` で MCP サーバーの確認が通る

---

### P1-04: MCP 設定ファイルの作成（mcp-config.json）

| 項目 | 内容 |
|---|---|
| 優先度 | Priority 1 |
| 所要時間 | 30分 |
| 担当 | Lead AI Engineer |

**実施内容:**
- `ai-agent/mcp-config.json` を作成（MCP_SERVER_LIST.md の設定を使用）
- ファイルパスを実際の絶対パスに変更
- 環境変数を正しく参照しているか確認

**完了条件:**
- [ ] `mcp-config.json` が存在する
- [ ] Claude Code が `--mcp-config ai-agent/mcp-config.json` で MCP を認識する
- [ ] `claude list-tools --mcp-config ai-agent/mcp-config.json` で 4 サーバーのツールが表示される

---

### P1-05: verify-setup.sh の作成と実行

| 項目 | 内容 |
|---|---|
| 優先度 | Priority 1 |
| 所要時間 | 20分 |
| 担当 | Lead AI Engineer |

**実施内容:**
- `scripts/verify-setup.sh` を作成（DIRECTORY_STRUCTURE.md の内容を使用）
- 実行して全チェックが通ることを確認

**完了条件:**
- [ ] `verify-setup.sh` を実行して全項目「OK」と表示される
- [ ] Claude Code が起動する（`claude --version`）
- [ ] 4 MCP サーバーが認識される

---

### P1-06: ai-agent/CLAUDE.md（Sales Agent システムプロンプト）の作成

| 項目 | 内容 |
|---|---|
| 優先度 | Priority 1 — Agent の頭脳 |
| 所要時間 | 2〜3時間 |
| 担当 | Lead AI Engineer |

**実施内容:**
以下の内容を含む `ai-agent/CLAUDE.md` を作成:

1. **役割の定義** — PHOSARA AI Sales Agent として動作する
2. **Knowledge 読み込み指示** — 実行開始時に必ず読み込むファイルのリスト
3. **実行フロー** — `SALES_MVP_WORKFLOW.md` の Step 1〜9 を写像
4. **出力フォーマット** — 三点セット・営業文・ログの正確なフォーマット
5. **禁止事項** — 対外送信・承認なし遷移・ログ省略の禁止
6. **ツール使用ルール** — MCP ごとの用途を明記

**完了条件:**
- [ ] `CLAUDE.md` が 200 行以上かつ具体的な指示を含む
- [ ] フォーマット指定が `SALES_MVP_WORKFLOW.md` の仕様と一致する
- [ ] 禁止事項が `PHOSARA_AI_SALES_RUNTIME_v1.md` §12 を網羅する

---

### P1-07: プロンプトファイルの作成（4ファイル）

| 項目 | 内容 |
|---|---|
| 優先度 | Priority 1 |
| 所要時間 | 2〜3時間 |
| 担当 | Lead AI Engineer |

**実施内容:**
各 Step に対応するタスクプロンプトを作成:

```
ai-agent/prompts/
├── research.md      ← Step 4: Web調査（Brave Search + Fetch の具体的な使い方）
├── ba-analysis.md   ← Step 5: BA価値分析（出力フォーマット厳密に指定）
├── message-gen.md   ← Step 6: 営業文生成（件名+本文A+本文Bのフォーマット）
└── self-review.md   ← Step 7-8: 自己レビュー8項目 + Confidence Score
```

**完了条件:**
- [ ] 各ファイルに入力・処理・出力フォーマットが明記されている
- [ ] `self-review.md` に 8項目チェックリストが含まれている
- [ ] `message-gen.md` に禁止事項（値引き・制作先行・他社批判）が含まれている

---

### P1-08: morning-batch.sh の作成

| 項目 | 内容 |
|---|---|
| 優先度 | Priority 1 |
| 所要時間 | 1時間 |
| 担当 | Lead AI Engineer |

**実施内容:**
`scripts/morning-batch.sh` を作成:
- Claude Code を Sales Agent モードで起動
- `--mcp-config` を指定して MCP を有効化
- 実行ログを `ai-agent/logs/batch-{date}.log` に出力
- exit code を適切に設定（0: 成功、1: 失敗）

**完了条件:**
- [ ] `bash scripts/morning-batch.sh` を手動実行できる
- [ ] 実行後に `OWNER_APPROVAL_QUEUE.md` が更新される（または CONFLICT_LOG に記録）
- [ ] `SALES_LOG.md` に状態遷移が記録される
- [ ] `batch-{date}.log` にログが出力される

---

### P1-09: OWNER_APPROVAL_QUEUE.md と SALES_LOG.md の初期フォーマット設定

| 項目 | 内容 |
|---|---|
| 優先度 | Priority 1 |
| 所要時間 | 30分 |
| 担当 | Lead AI Engineer |

**実施内容:**
ヘッダーとフォーマット例を含む初期ファイルを作成:

```markdown
# OWNER_APPROVAL_QUEUE

オーナーへ: 以下のエントリを確認し、承認欄に追記してください。
承認後 24 時間以内に送信を実行します。

---
<!-- 新しいエントリはここに追記されます -->
```

```markdown
# SALES_LOG

| 日時 | ターゲットID | 会社名 | 遷移前 | 遷移後 | メモ |
|---|---|---|---|---|---|
<!-- 新しいエントリはここに追記されます（削除・改変禁止）-->
```

**完了条件:**
- [ ] 両ファイルがフォーマット通りに初期化されている
- [ ] GitHub に初期コミットが完了している

---

### P1-10: ドライラン（実際のターゲット 1社でテスト）

| 項目 | 内容 |
|---|---|
| 優先度 | Priority 1 |
| 所要時間 | 1〜2時間 |
| 担当 | Lead AI Engineer + オーナー |

**実施内容:**
`SALES_TARGET_LIST_TOCHIGI_v1.md` から 1社を選んでドライラン:

```bash
bash scripts/morning-batch.sh
```

実行後に確認:
1. `OWNER_APPROVAL_QUEUE.md` に三点セットが追記されているか
2. `SALES_LOG.md` に状態遷移が記録されているか
3. GitHub に自動コミットされているか
4. 営業文の品質・フォーマットが `SALES_EXECUTION_TOOLKIT.md` に準拠しているか

**完了条件:**
- [ ] 三点セット（事実・選択肢・推奨）が正しいフォーマットで出力される
- [ ] 営業文が `SALES_EXECUTION_TOOLKIT.md` の型に準拠している
- [ ] Confidence Score が付与されている（70% 以上）
- [ ] 状態が `WAITING_APPROVAL` になっている
- [ ] GitHub に変更が自動コミットされている

---

### P1-11: n8n インストールと WF-01（朝バッチ）の設定

| 項目 | 内容 |
|---|---|
| 優先度 | Priority 1 |
| 所要時間 | 1時間 |
| 担当 | Lead AI Engineer |

**実施内容:**
1. n8n をインストール・起動
2. `sales-morning-batch.json` をインポート
3. Cron を `0 9 * * 1-5`（月〜金 09:00 JST）に設定
4. Execute Command ノードのパスを設定

**完了条件:**
- [ ] n8n の Cron が正しく設定されている
- [ ] テスト実行（手動トリガー）で `morning-batch.sh` が実行される
- [ ] 実行完了メールがオーナーに届く

---

### P1-12: n8n WF-02（承認通知）の設定

| 項目 | 内容 |
|---|---|
| 優先度 | Priority 1 |
| 所要時間 | 1時間 |
| 担当 | Lead AI Engineer |

**実施内容:**
1. GitHub Webhook を設定（phosara リポジトリ）
2. `sales-approval-notifier.json` をインポート
3. Gmail Credential を設定（OAuth2）
4. テスト: OWNER_APPROVAL_QUEUE.md に手動でテキストを追加してコミット → メール確認

**完了条件:**
- [ ] GitHub へのプッシュで Webhook が n8n に届く
- [ ] `OWNER_APPROVAL_QUEUE.md` の更新時のみメールが送信される
- [ ] メールに会社名・Confidence Score・承認期限・GitHub URL が含まれる

---

## Priority 2 — 本番稼働に必要

### P2-01: SALES_STATE.md による状態管理の実装

| 項目 | 内容 |
|---|---|
| 優先度 | Priority 2 |
| 所要時間 | 2時間 |

**内容:** Agent が実行前に `SALES_STATE.md` を確認し、既に `WAITING_APPROVAL` の企業がある場合は新規処理をスキップする。承認/差戻し後に状態を更新する。

**完了条件:**
- [ ] 重複処理が起きない（同一ターゲットに 2 回営業文が生成されない）
- [ ] 差戻し時に状態が `NEW` に戻り再処理される

---

### P2-02: 夕バッチ（WF-03）の実装

| 項目 | 内容 |
|---|---|
| 優先度 | Priority 2 |
| 所要時間 | 1時間 |

**内容:** 毎夕 18:00 に当日の `SALES_LOG.md` を集計してオーナーに送信する日次レポート。

---

### P2-03: エラーアラート（WF-04）の実装

| 項目 | 内容 |
|---|---|
| 優先度 | Priority 2 |
| 所要時間 | 1時間 |

**内容:** `CONFLICT_LOG.md` の変更を検知してオーナーに即座に通知する。

---

### P2-04: 自己レビュー不合格ロジックの強化

| 項目 | 内容 |
|---|---|
| 優先度 | Priority 2 |
| 所要時間 | 1時間 |

**内容:** 自己レビューが 2回連続不合格の場合に `CONFLICT_LOG.md` に記録し、処理を停止して次のターゲットに移る。無限ループ防止。

---

### P2-05: Confidence Score 70% 未満の再調査ロジック

| 項目 | 内容 |
|---|---|
| 優先度 | Priority 2 |
| 所要時間 | 1時間 |

**内容:** Score < 70% の場合に Web 調査を再実行（最大 1回）。2回連続失敗で `CONFLICT_LOG.md` に記録。

---

### P2-06: SLA Watchdog（WF-05）の実装

| 項目 | 内容 |
|---|---|
| 優先度 | Priority 2 |
| 所要時間 | 30分 |

**内容:** 承認期限（48時間）まで 24時間を切ったエントリへのリマインダー通知。

---

### P2-07: GitHub コミットメッセージの標準化

| 項目 | 内容 |
|---|---|
| 優先度 | Priority 2 |
| 所要時間 | 30分 |

**内容:** Agent が自動コミットする際のメッセージ規則を定義。

```
sales: add approval queue entry AQ-YYYYMMDD-NNN [{会社名}]
sales: update state to WAITING_APPROVAL [{ターゲットID}]
sales: log state transition [{ターゲットID}] {旧状態} → {新状態}
```

---

## Priority 3 — 拡張・最適化

### P3-01: Google Sheets CRM 連携

| 項目 | 内容 |
|---|---|
| 優先度 | Priority 3 |
| 所要時間 | 3〜5時間 |

**内容:** `SALES_TARGET_LIST_TOCHIGI_v1.md` を Google Sheets に移行し、MCP 経由で読み込む。営業結果を Sheets に自動記録。ダッシュボードとして活用。

---

### P3-02: 業種別プロンプトの最適化

| 項目 | 内容 |
|---|---|
| 優先度 | Priority 3 |
| 所要時間 | 3時間 |

**内容:** 建築・工務店・整体院・接骨院・パチンコホール別の営業文テンプレートを用意。Agent Memory の蓄積で継続改善。

---

### P3-03: KPI ダッシュボードの構築

| 項目 | 内容 |
|---|---|
| 優先度 | Priority 3 |
| 所要時間 | 3時間 |

**内容:** `SALES_LOG.md` から週次・月次 KPI を自動集計し、オーナーに週次レポートとして送信。

---

### P3-04: Agent Memory の実装

| 項目 | 内容 |
|---|---|
| 優先度 | Priority 3 |
| 所要時間 | 3〜5時間 |

**内容:** 成功営業文・高返信件名・業種別成功パターンを蓄積する `AGENT_MEMORY.md` を実装。営業文生成時に参照する。

---

### P3-05: Claude Code Agent のコマンドライン化

| 項目 | 内容 |
|---|---|
| 優先度 | Priority 3 |
| 所要時間 | 2時間 |

**内容:** `phosara-sales` というコマンドで Sales Agent を実行できるようにする。
```bash
phosara-sales run-morning       # 朝バッチ手動実行
phosara-sales status            # 現在の状態確認
phosara-sales approve AQ-xxx    # コマンドラインから承認
```

---

### P3-06: 新しい AI社員の追加テンプレート

| 項目 | 内容 |
|---|---|
| 優先度 | Priority 3 |
| 所要時間 | 2時間 |

**内容:** Client Success AI / Knowledge AI / PBOS AI を追加する際に使えるディレクトリ・設定テンプレート。Sales AI の構造を踏襲して拡張。

---

## タスク進捗トラッカー

| タスク | 状態 | 開始日 | 完了日 |
|---|---|---|---|
| P1-01: ディレクトリ構造 | 未着手 | — | — |
| P1-02: 環境変数 | 未着手 | — | — |
| P1-03: MCP インストール | 未着手 | — | — |
| P1-04: mcp-config.json | 未着手 | — | — |
| P1-05: verify-setup.sh | 未着手 | — | — |
| P1-06: CLAUDE.md | 未着手 | — | — |
| P1-07: プロンプトファイル | 未着手 | — | — |
| P1-08: morning-batch.sh | 未着手 | — | — |
| P1-09: ファイル初期化 | 未着手 | — | — |
| P1-10: ドライラン | 未着手 | — | — |
| P1-11: n8n WF-01 | 未着手 | — | — |
| P1-12: n8n WF-02 | 未着手 | — | — |
| P2-01〜07 | 未着手 | — | — |
| P3-01〜06 | 未着手 | — | — |

---

*タスク完了時はこのトラッカーを更新する。*
*Priority の変更は HQ 承認を経て本書を更新する。*
