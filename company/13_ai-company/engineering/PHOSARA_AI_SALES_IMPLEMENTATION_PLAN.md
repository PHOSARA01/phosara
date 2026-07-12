# PHOSARA AI Sales Agent — 実装計画

| 項目 | 内容 |
|---|---|
| 文書ID | PHOSARA_AI_SALES_IMPLEMENTATION_PLAN_v1 |
| 版 | v1.0 |
| 発効日 | 2026-07-13 |
| 状態 | ACTIVE |
| 準拠 | PHOSARA_AI_SALES_RUNTIME_v1.md / SALES_MVP_WORKFLOW.md |
| 作成者 | Lead AI Engineer |

---

## 1. 目的と位置づけ

本書は PHOSARA AI Sales Agent を **実際に動作するシステム** として構築するための
工学実装計画書である。

- 設計の正典 → `agents/PHOSARA_AI_SALES_AGENT_v1.md`
- 運転仕様の正典 → `runtime/PHOSARA_AI_SALES_RUNTIME_v1.md`
- 本書の役割 → **それらを動かすシステムをどう作るか**

設計書の内容はコードで再定義しない。実装は設計の写像である。

---

## 2. MVP スコープ（Phase 1）

### 実装する機能

```
[Step 1] 営業対象リスト読み込み     ← SALES_TARGET_LIST_TOCHIGI_v1.md
    ↓
[Step 2] S・Aランク優先ソート
    ↓
[Step 3] 1社の営業候補を選定
    ↓
[Step 4] Web調査項目の整理           ← MCP: brave-search / fetch
    ↓
[Step 5] Business Audit価値分析
    ↓
[Step 6] 営業文の生成（案A・案B）
    ↓
[Step 7] AI自己レビュー（8項目）
    ↓
[Step 8] Confidence Score付与
    ↓
[Step 9] OWNER_APPROVAL_QUEUE.md 追記  ← MCP: filesystem / github
    ↓
[Log]   SALES_MVP_LOG.md 追記
    ↓
[END]   状態 = WAITING_APPROVAL
```

### 実装しない機能（Phase 2 以降）

- 営業送信（メール・フォーム送信）
- 返信確認・返信分類
- Business Audit予約確定
- Client Success AI へのハンドオフ

---

## 3. 技術スタック

```
┌─────────────────────────────────────────────────────────┐
│  Layer 1: Orchestration                                 │
│  n8n  (スケジューラー・通知ルーター)                       │
└────────────────────────┬────────────────────────────────┘
                         │ Shell / HTTP
┌────────────────────────▼────────────────────────────────┐
│  Layer 2: AI Brain                                      │
│  Claude Code  (claude -p "system_prompt" ...)           │
│  CLAUDE.md で Sales Agent として動作                     │
└────────────────────────┬────────────────────────────────┘
                         │ MCP Protocol
┌────────────────────────▼────────────────────────────────┐
│  Layer 3: Tools (MCP Servers)                           │
│  filesystem  │  github  │  brave-search  │  fetch       │
└────────────────────────┬────────────────────────────────┘
                         │ read / write / commit
┌────────────────────────▼────────────────────────────────┐
│  Layer 4: Data (GitHub Repository)                      │
│  Markdown files = CRM / Queue / Log / Knowledge         │
└─────────────────────────────────────────────────────────┘
                         │ n8n Webhook trigger
┌────────────────────────▼────────────────────────────────┐
│  Layer 5: Owner Interface                               │
│  Gmail  (承認通知)  +  GitHub  (承認キューファイル編集)   │
└─────────────────────────────────────────────────────────┘
```

---

## 4. 実装フェーズ

### Phase 1-A：基盤構築（最初に着手）

| # | タスク | 成果物 |
|---|---|---|
| A-1 | ディレクトリ構造の作成 | `ai-agent/` 配下の全ディレクトリ |
| A-2 | MCP サーバーのインストールと設定 | `mcp-config.json` |
| A-3 | Claude Code CLAUDE.md（Sales Agent 版）の作成 | `ai-agent/CLAUDE.md` |
| A-4 | 環境変数の設定 | `.env`（gitignore 済み）|
| A-5 | 動作確認スクリプト | `scripts/verify-setup.sh` |

### Phase 1-B：Agent コア実装

| # | タスク | 成果物 |
|---|---|---|
| B-1 | ターゲットリスト読み込みロジック | `scripts/morning-batch.sh` |
| B-2 | Web調査プロンプト実装 | `ai-agent/prompts/research.md` |
| B-3 | BA価値分析プロンプト実装 | `ai-agent/prompts/ba-analysis.md` |
| B-4 | 営業文生成プロンプト実装 | `ai-agent/prompts/message-gen.md` |
| B-5 | 自己レビュー・Confidence Score プロンプト実装 | `ai-agent/prompts/self-review.md` |
| B-6 | OWNER_APPROVAL_QUEUE 書き込みロジック | `ai-agent/prompts/queue-write.md` |

### Phase 1-C：n8n ワークフロー

| # | タスク | 成果物 |
|---|---|---|
| C-1 | 朝バッチワークフロー（TRG-01） | n8n workflow JSON |
| C-2 | 承認通知ワークフロー（GitHub Webhook → Gmail）| n8n workflow JSON |
| C-3 | 夕バッチワークフロー（TRG-02）| n8n workflow JSON |

### Phase 1-D：テスト・調整

| # | タスク | 成果物 |
|---|---|---|
| D-1 | ドライラン（実際のターゲット1社でテスト）| テスト実行ログ |
| D-2 | 承認キュー → オーナー通知の動作確認 | 確認チェックリスト |
| D-3 | エラーケース検証（リサーチ失敗 / 自己レビュー不合格等）| エラーログ |

---

## 5. 実装順序（絶対的な順番）

```
A-1 → A-2 → A-3 → A-4 → A-5
  └──── 基盤が動いてから ────┘
          ↓
B-1 → B-2 → B-3 → B-4 → B-5 → B-6
  └──── Agent が 1 サイクル回せてから ──┘
          ↓
C-1 → C-2 → C-3
  └──── n8n で自動化 ──┘
          ↓
D-1 → D-2 → D-3
  └──── 実戦テスト ──┘
```

B フェーズの前に A フェーズを完成させること。
n8n（C）は B が動いてから接続すること。
手動実行で動かない状態で n8n に組み込まない。

---

## 6. Phase 1 の成功条件

以下をすべて満たした状態が Phase 1 完了:

- [ ] `morning-batch.sh` を手動実行すると OWNER_APPROVAL_QUEUE.md が更新される
- [ ] 承認キューに三点セット（事実・選択肢・推奨）が含まれている
- [ ] Confidence Score が 70% 以上の場合のみキューに登録される
- [ ] SALES_MVP_LOG.md に状態遷移が即時記録される
- [ ] n8n の TRG-01 が毎朝定時に morning-batch.sh を実行する
- [ ] GitHub Webhook → n8n → Gmail で承認通知が届く
- [ ] オーナーが OWNER_APPROVAL_QUEUE.md に追記すると状態が変わる

---

## 7. 依存関係と前提条件

| 依存 | 内容 | 確認方法 |
|---|---|---|
| Anthropic API Key | Claude Code の動作に必須 | `claude --version` |
| GitHub PAT | MCP github サーバー + Webhook に必須 | `gh auth status` |
| n8n インスタンス | セルフホスト or Cloud | `http://localhost:5678` |
| Brave Search API Key | Web 調査 MCP に必須 | Brave API Dashboard |
| Gmail OAuth2 | 承認通知の送信に必須 | n8n Gmail credential |
| Node.js ≥ 18 | MCP サーバーの実行に必須 | `node -v` |

---

## 8. リスクと対処

| リスク | 確率 | 対処 |
|---|---|---|
| Web調査で対象企業の情報が取得できない | 中 | `[仮定]` 明記で続行。Confidence Score に反映 |
| Brave Search の API 制限 | 低 | 1ターゲット / 1実行。日次上限に余裕を持たせる |
| Claude Code の出力形式が不安定 | 中 | 出力フォーマットを厳密に指定したプロンプトで制御 |
| n8n → GitHub Webhook 連携の遅延 | 低 | ポーリング方式を代替で実装 |

---

*本書は実装の進捗に応じて随時更新する。*
*仕様との矛盾を発見した場合は CONFLICT_LOG に記録し、コードで回避しない。*
