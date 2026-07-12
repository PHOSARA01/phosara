# PHOSARA AI Sales Agent — 環境変数・API一覧

| 項目 | 内容 |
|---|---|
| 文書ID | PHOSARA_AI_ENVIRONMENT_VARIABLES_v1 |
| 版 | v1.0 |
| 発効日 | 2026-07-13 |
| 状態 | ACTIVE |

---

## 重要: セキュリティ原則

- `.env` ファイルは **絶対に GitHub へコミットしない**（`.gitignore` 必須）
- API キーは環境変数経由のみで受け渡す
- シークレットをプロンプトや Markdown に直接記述しない
- n8n の Credential は n8n の暗号化ストレージに保存する

---

## 1. Phase 1 MVP — 必須環境変数

### 1.1 Anthropic API

| 変数名 | 値の形式 | 用途 |
|---|---|---|
| `ANTHROPIC_API_KEY` | `sk-ant-api03-...` | Claude Code の実行 |

**取得方法:** https://console.anthropic.com/settings/keys  
**設定場所:** `.env` / シェル環境 / n8n の Environment Variables

```bash
# .env
ANTHROPIC_API_KEY=sk-ant-api03-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

---

### 1.2 GitHub

| 変数名 | 値の形式 | 用途 |
|---|---|---|
| `GITHUB_PERSONAL_ACCESS_TOKEN` | `ghp_...` | MCP github サーバー・Webhook 認証 |
| `GITHUB_REPO_OWNER` | `PHOSARA01` | リポジトリオーナー |
| `GITHUB_REPO_NAME` | `phosara` | リポジトリ名 |
| `GITHUB_BRANCH` | `main` | 書き込み対象ブランチ |

**取得方法:** GitHub Settings → Developer settings → Personal access tokens → Fine-grained tokens  
**必要な権限:**
- `Contents`: Read and write（ファイルの読み書き・コミット）
- `Webhooks`: Read（Webhook 受信、n8n 側で設定）

```bash
# .env
GITHUB_PERSONAL_ACCESS_TOKEN=ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
GITHUB_REPO_OWNER=PHOSARA01
GITHUB_REPO_NAME=phosara
GITHUB_BRANCH=main
```

---

### 1.3 Brave Search API

| 変数名 | 値の形式 | 用途 |
|---|---|---|
| `BRAVE_SEARCH_API_KEY` | `BSA...` | 企業 Web 調査（MCP brave-search） |

**取得方法:** https://api.search.brave.com/  
**プラン:** Free（月 2,000 クエリ）で Phase 1 MVP は十分。  
**推奨上限設定:** 1ターゲットあたり最大 5 クエリ → 1日 5 ターゲットで 25 クエリ

```bash
# .env
BRAVE_SEARCH_API_KEY=BSAxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

---

### 1.4 n8n

| 変数名 | 値の形式 | 用途 |
|---|---|---|
| `N8N_HOST` | `http://localhost:5678` | n8n インスタンス URL |
| `N8N_WEBHOOK_SECRET` | 任意の文字列 | GitHub Webhook の認証トークン |

**n8n のインストール方法（セルフホスト）:**
```bash
npm install -g n8n
n8n start
```

```bash
# .env
N8N_HOST=http://localhost:5678
N8N_WEBHOOK_SECRET=phosara-webhook-secret-xxxxx
```

---

## 2. Phase 1 MVP — 推奨環境変数

### 2.1 Gmail（承認通知用）

n8n の Gmail Credential として設定。`.env` には入れない。

| 設定項目 | 内容 |
|---|---|
| 認証方式 | OAuth2（n8n の Credential に登録） |
| 送信先 | オーナーのメールアドレス |
| 送信元 | PHOSARA 用 Gmail アカウント |

**n8n での設定手順:**
1. n8n → Credentials → New → Gmail OAuth2
2. Google Cloud Console で OAuth2 クライアントを作成
3. n8n の Redirect URI を Google Cloud に登録
4. 認証フローを完了

---

### 2.2 エージェント設定

| 変数名 | 値の形式 | 用途 |
|---|---|---|
| `SALES_AGENT_MAX_TARGETS_PER_RUN` | `1` | 1回の実行で処理するターゲット数（変更不可）|
| `SALES_AGENT_CONFIDENCE_THRESHOLD` | `70` | 承認キュー登録の最低 Confidence Score |
| `SALES_AGENT_APPROVAL_SLA_HOURS` | `48` | 承認期限（時間） |
| `SALES_AGENT_LOG_DIR` | `ai-agent/logs` | ログ保存先 |

```bash
# .env
SALES_AGENT_MAX_TARGETS_PER_RUN=1
SALES_AGENT_CONFIDENCE_THRESHOLD=70
SALES_AGENT_APPROVAL_SLA_HOURS=48
SALES_AGENT_LOG_DIR=ai-agent/logs
```

---

## 3. Phase 2 以降 — 追加予定環境変数

| 変数名 | Phase | 用途 |
|---|---|---|
| `GMAIL_OAUTH_TOKEN` | Phase 2 | 営業メール送信（MCP gmail） |
| `GOOGLE_SHEETS_CREDENTIALS` | Phase 2 | Google Sheets CRM 連携 |
| `GOOGLE_CALENDAR_TOKEN` | Phase 3 | Business Audit 予約管理 |
| `SLACK_BOT_TOKEN` | Phase 2 | Slack 承認通知（Gmail の代替） |
| `OPENAI_API_KEY` | 将来 | 一部タスクのコスト最適化（未定） |

---

## 4. .env.example テンプレート

リポジトリルートに配置。実際の値は記載しない。

```bash
# ============================================================
# PHOSARA AI Sales Agent — Environment Variables
# このファイルをコピーして .env を作成し、実際の値を設定してください
# .env は絶対に GitHub にコミットしないでください
# ============================================================

# [必須] Anthropic API
ANTHROPIC_API_KEY=sk-ant-api03-your-key-here

# [必須] GitHub
GITHUB_PERSONAL_ACCESS_TOKEN=ghp_your-token-here
GITHUB_REPO_OWNER=PHOSARA01
GITHUB_REPO_NAME=phosara
GITHUB_BRANCH=main

# [必須] Brave Search
BRAVE_SEARCH_API_KEY=BSA-your-key-here

# [必須] n8n
N8N_HOST=http://localhost:5678
N8N_WEBHOOK_SECRET=change-this-to-random-secret

# [推奨] Agent 設定
SALES_AGENT_MAX_TARGETS_PER_RUN=1
SALES_AGENT_CONFIDENCE_THRESHOLD=70
SALES_AGENT_APPROVAL_SLA_HOURS=48
SALES_AGENT_LOG_DIR=ai-agent/logs
```

---

## 5. 環境変数の設定場所まとめ

| 環境変数 | Claude Code（shell）| n8n Env | n8n Credential |
|---|---|---|---|
| `ANTHROPIC_API_KEY` | ✓ 必須 | ✓ 必須 | — |
| `GITHUB_PERSONAL_ACCESS_TOKEN` | ✓ 必須 | — | ✓（GitHub node）|
| `BRAVE_SEARCH_API_KEY` | ✓ 必須 | — | — |
| `N8N_WEBHOOK_SECRET` | — | ✓ 必須 | — |
| Gmail OAuth2 | — | — | ✓（Gmail node）|

---

## 6. API の月間コスト試算（Phase 1 MVP）

| API | 使用量（月） | 単価 | 月額試算 |
|---|---|---|---|
| Claude API（claude-sonnet-4-6）| 1ターゲット/日 × 22日 = 22回 × ~5K tokens | $3/MTok | ~$0.33 |
| Brave Search API | 22日 × 5クエリ = 110クエリ | Free 2000/月 | $0 |
| GitHub API | 無制限 | Free | $0 |
| n8n（セルフホスト）| — | サーバー費のみ | 既存コスト |
| Gmail | 22通 | Free | $0 |
| **合計** | | | **~$0.33/月** |

---

*API キーの更新・失効はすぐに CONFLICT_LOG に記録すること。*
*キーの更新後は verify-setup.sh を必ず実行して動作確認する。*
