# PHOSARA AI Sales Agent — システム構成図

| 項目 | 内容 |
|---|---|
| 文書ID | PHOSARA_AI_SALES_SYSTEM_ARCHITECTURE_v1 |
| 版 | v1.0 |
| 発効日 | 2026-07-13 |
| 状態 | ACTIVE — Phase 1 MVP |

---

## 1. 全体アーキテクチャ

```
╔══════════════════════════════════════════════════════════════════╗
║                   PHOSARA AI Sales Agent v1                     ║
║                    Phase 1 MVP Architecture                     ║
╚══════════════════════════════════════════════════════════════════╝

 OWNER
  │
  │  ① GitHub: OWNER_APPROVAL_QUEUE.md を読んで承認/差戻し
  │  ② Gmail: 承認通知メールを受信
  │
  ▼
┌─────────────────────────────────────────────────────────────────┐
│  ORCHESTRATION LAYER  ─────────── n8n                          │
│                                                                 │
│  ┌─────────────┐  ┌──────────────┐  ┌─────────────────────┐   │
│  │ TRG-01      │  │ Approval     │  │ TRG-02              │   │
│  │ Morning     │  │ Notifier     │  │ Evening Report      │   │
│  │ Batch       │  │ (Webhook→    │  │ Batch               │   │
│  │ 毎朝 09:00  │  │  Gmail)      │  │ 毎夕 18:00          │   │
│  └──────┬──────┘  └──────▲───────┘  └──────────┬──────────┘   │
└─────────│────────────────│──────────────────────│──────────────┘
          │ Shell exec     │ GitHub Webhook        │ Shell exec
          ▼                │                       ▼
┌─────────────────────┐    │         ┌─────────────────────────┐
│  AI BRAIN LAYER     │    │         │  AI BRAIN LAYER         │
│  Claude Code        │    │         │  Claude Code            │
│  (morning-batch.sh) │    │         │  (evening-batch.sh)     │
│                     │    │         │                         │
│  CLAUDE.md:         │    │         │  CLAUDE.md:             │
│  Sales Agent Mode   │    │         │  Report Mode            │
└──────────┬──────────┘    │         └─────────────────────────┘
           │ MCP calls     │ push
           ▼               │
┌──────────────────────────┴──────────────────────────────────────┐
│  TOOL LAYER  ──────────── MCP Servers                          │
│                                                                 │
│  ┌───────────────┐  ┌──────────┐  ┌────────────┐  ┌─────────┐ │
│  │ filesystem    │  │ github   │  │brave-search│  │  fetch  │ │
│  │               │  │          │  │            │  │         │ │
│  │ Read/Write    │  │ Read     │  │ Web Search │  │ Page    │ │
│  │ Markdown      │  │ Commit   │  │ API        │  │ Fetch   │ │
│  │ files         │  │ Push     │  │            │  │         │ │
│  └───────┬───────┘  └────┬─────┘  └─────┬──────┘  └────┬────┘ │
└──────────│───────────────│──────────────│───────────────│──────┘
           │               │              │               │
           ▼               ▼              ▼               ▼
┌──────────────────────────────────────────────────────────────────┐
│  DATA LAYER  ──────────── GitHub Repository                     │
│                                                                  │
│  company/04_sales/                 ai-agent/                    │
│  ├── SALES_TARGET_LIST_TOCHIGI_v1.md  ├── state/               │
│  ├── SALES_TARGET_CRITERIA.md         │   └── SALES_STATE.md   │
│  ├── SALES_PLAYBOOK_v2.md             ├── queue/               │
│  └── SALES_EXECUTION_TOOLKIT.md      │   └── OWNER_APPROVAL_  │
│                                       │       QUEUE.md          │
│  company/13_ai-company/               ├── logs/                │
│  └── implementation/                  │   ├── SALES_LOG.md     │
│      phase1-sales-mvp/                │   └── CONFLICT_LOG.md  │
│      └── SALES_MVP_*.md               └── prompts/             │
│                                           ├── research.md      │
│                                           ├── ba-analysis.md   │
│                                           ├── message-gen.md   │
│                                           └── self-review.md   │
└──────────────────────────────────────────────────────────────────┘
```

---

## 2. コンポーネント詳細

### 2.1 n8n（Orchestration Layer）

**役割:** スケジュール管理・外部イベント検知・通知配信。判断ロジックを持たない。

| コンポーネント | 種別 | 処理 |
|---|---|---|
| Morning Batch Trigger | Cron: 09:00 JST 月〜金 | `morning-batch.sh` を実行 |
| Approval Notifier | GitHub Webhook: push | QUEUE に新エントリを検知 → Gmail 送信 |
| Evening Report Trigger | Cron: 18:00 JST 月〜金 | `evening-batch.sh` を実行 |

**n8n が判断するもの:** なし。
**n8n が実行するもの:** シェルスクリプトの起動・ファイル変更の検知・メール送信。

---

### 2.2 Claude Code（AI Brain Layer）

**役割:** 全ての推論・分析・文章生成・自己レビューを実行。

```
claude -p "$(cat ai-agent/CLAUDE.md)" \
       --task "$(cat ai-agent/tasks/morning-task.md)" \
       --allowedTools "mcp__filesystem,mcp__github,mcp__brave-search,mcp__fetch"
```

**Claude Code が担当するもの:**
- ターゲットリスト読み込み・優先順位付け
- Web 調査の計画と実行（MCP 経由）
- Business Audit 価値分析
- 営業文 生成（案A / 案B）
- AI 自己レビュー（8項目）
- Confidence Score 付与
- OWNER_APPROVAL_QUEUE.md への書き込み（MCP 経由）
- SALES_LOG.md への記録（MCP 経由）

**Claude Code が担当しないもの:**
- スケジューリング（n8n が担当）
- メール送信（n8n + Gmail が担当）
- 承認の判断（オーナーが担当）

---

### 2.3 MCP Servers（Tool Layer）

Claude Code がツールとして呼び出す外部機能。判断を持たない単機能サーバー。

| サーバー | npm パッケージ | 担う機能 |
|---|---|---|
| filesystem | `@modelcontextprotocol/server-filesystem` | ローカル Markdown ファイルの読み書き |
| github | `@modelcontextprotocol/server-github` | GitHub ファイルの読み込み・コミット・プッシュ |
| brave-search | `@modelcontextprotocol/server-brave-search` | 企業 Web 調査のための検索 API |
| fetch | `@modelcontextprotocol/server-fetch` | 企業サイト・Google Maps 等のページ取得 |

**Phase 2 以降で追加予定:**

| サーバー | 用途 |
|---|---|
| `mcp-google-sheets` | Google Sheets をCRM台帳として利用 |
| `mcp-gmail` | 承認済み文面の送信（Phase 2） |
| `mcp-google-calendar` | Business Audit 予約管理（Phase 3） |

---

### 2.4 GitHub Repository（Data Layer）

**役割:** 全データの唯一の正典（Single Source of Truth）。

```
データの流れ:

SALES_TARGET_LIST    →  Claude Code が読み込む
                         (入力: 営業候補一覧)

Web / External       →  Claude Code が MCP 経由で取得
                         (入力: 企業の公開情報)

Claude Code 出力     →  OWNER_APPROVAL_QUEUE.md に書き込む
                         (出力: 三点セット + 営業文)

Claude Code 出力     →  SALES_LOG.md に書き込む
                         (出力: 状態遷移ログ)

オーナーの編集       →  OWNER_APPROVAL_QUEUE.md に承認を追記
                         (入力: 承認 / 差戻し)

GitHub Push          →  n8n Webhook が検知
                         (トリガー: 承認通知)
```

---

## 3. データフロー詳細

### 3.1 Morning Batch（Phase 1 主フロー）

```
n8n TRG-01 (09:00)
    │
    ├── Shell: morning-batch.sh を実行
    │
    └── Claude Code 起動
            │
            ├── [MCP: filesystem] SALES_TARGET_LIST.md を読み込む
            ├── [MCP: filesystem] SALES_MVP_STATE.md を確認
            │
            ├── S/Aランクのターゲットを優先ソート
            ├── 1社を選定（選定理由を記録）
            │
            ├── [MCP: brave-search] 企業名 + 業種 で検索
            ├── [MCP: fetch] 企業サイト・Google Maps を取得
            │
            ├── Web調査サマリーを生成
            ├── BA価値分析を生成
            ├── 営業文を生成（案A・案B）
            ├── AI自己レビュー（8項目チェック）
            ├── Confidence Score を付与
            │
            ├── [Score ≥ 70%]
            │       ├── [MCP: filesystem] OWNER_APPROVAL_QUEUE.md に追記
            │       └── [MCP: filesystem] SALES_LOG.md に追記
            │       └── [MCP: github] commit + push
            │
            └── [Score < 70%]
                    ├── 再調査（Step 4 に戻る、最大1回）
                    └── [2回連続 < 70%] CONFLICT_LOG.md に記録
```

### 3.2 Approval Notification フロー

```
GitHub: commit push（OWNER_APPROVAL_QUEUE.md 更新）
    │
    └── GitHub Webhook → n8n
            │
            ├── 変更ファイルが OWNER_APPROVAL_QUEUE.md か確認
            │
            └── [YES]
                    ├── 新エントリの内容を抽出
                    └── Gmail 送信:
                            件名: [承認待ち] {会社名} — PHOSARA Sales Agent
                            本文: 三点セット + QUEUE へのリンク
```

---

## 4. 責務の分離（Runtime §15.2 写像）

| 層 | 担当 | 判断の有無 |
|---|---|---|
| ツール層（MCP） | ファイル読み書き・検索・ページ取得 | 判断なし |
| エージェント層（Claude Code） | 分析・生成・評価・スコアリング | 営業判断のみ |
| 承認層（オーナー） | 対外送信許可・例外裁定 | 最終決定 |

**配線してはいけない経路:**
- MCP サーバーが直接メール送信する経路
- n8n が Claude の出力を改変する経路
- Claude Code が承認なしで対外送信する経路

---

## 5. 拡張性設計（AI社員の増設）

Phase 1 完了後、以下を同じアーキテクチャで追加できる:

```
Client Success AI  →  同じ MCP サーバー群を利用
Knowledge AI       →  filesystem / github MCP のみで動作
PBOS AI            →  filesystem / github MCP のみで動作
CEO AI             →  各 AI から夕バッチレポートを受信して統合
```

**増設の原則:**
- 各 AI は独自の `CLAUDE.md`（システムプロンプト）を持つ
- 共有するのは MCP サーバー設定のみ
- n8n ワークフローを AI ごとに独立して追加
- データ（Markdown ファイル）でのみ AI 間コミュニケーション

---

*本書はシステムの実装状態を反映して随時更新する。*
