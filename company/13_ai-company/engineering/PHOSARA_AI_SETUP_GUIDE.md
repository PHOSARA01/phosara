# PHOSARA AI Company — 完全セットアップガイド

| 項目 | 内容 |
|---|---|
| 文書ID | PHOSARA_AI_SETUP_GUIDE_v1 |
| 版 | v1.0 |
| 発効日 | 2026-07-13 |
| 対象者 | PHOSARA HQ オーナー・Lead AI Engineer |
| 前提OS | macOS（Apple Silicon / Intel）|

> **このガイドについて**
> PHOSARA AI Company を「ゼロから動かす」ために必要な全サービスのセットアップ手順を網羅する。
> このガイド 1 本だけを見れば、環境構築が完了するレベルを目指している。
>
> **思想:** PHOSARA は AI-first を前提とする。オーナーは「承認者」であり、AI 社員が実務を担当する。
> このガイドで構築する環境は、その AI 社員たちが実際に動く「職場」である。

---

## 目次

1. [開発環境](#1-開発環境)
   - 1.1 Git
   - 1.2 Node.js / npm
   - 1.3 GitHub
   - 1.4 Claude Code
2. [AI実行環境 — MCP](#2-ai実行環境--mcp)
   - 2.1 MCP とは
   - 2.2 filesystem MCP
   - 2.3 github MCP
   - 2.4 fetch MCP
   - 2.5 Brave Search MCP
3. [自動化 — n8n](#3-自動化--n8n)
4. [Google Workspace](#4-google-workspace)
   - 4.1 Google Cloud プロジェクト
   - 4.2 Gmail API
   - 4.3 Google Calendar API
   - 4.4 Google Drive API
5. [Web サービス](#5-web-サービス)
   - 5.1 Vercel
   - 5.2 Formspree
6. [統合設定](#6-統合設定)
7. [動作確認](#7-動作確認)
8. [セットアップチェックリスト](#8-phosara-ai-company-セットアップチェックリスト)

---

## 1. 開発環境

---

### 1.1 Git

#### 概要
リポジトリの管理・AI 社員のログ記録・ナレッジの保存に使用する。
GitHub との同期、自動コミット・プッシュはすべて Git を通じて行われる。

#### インストール

```bash
# macOS — Xcode Command Line Tools で自動インストール
xcode-select --install

# または Homebrew 経由
brew install git
```

#### 動作確認

```bash
git --version
# git version 2.39.5 (Apple Git-154) 以上であれば OK
```

#### 初期設定

```bash
git config --global user.name "PHOSARA HQ"
git config --global user.email "your-email@example.com"
git config --global init.defaultBranch main
```

#### トラブルシューティング

| エラー | 原因 | 解決方法 |
|---|---|---|
| `xcrun: error: invalid active developer path` | Xcode Command Line Tools 未インストール | `xcode-select --install` を実行 |
| `git: command not found` | PATH が通っていない | `echo $PATH` で `/usr/bin` が含まれるか確認 |

---

### 1.2 Node.js / npm

#### 概要
MCP サーバーの実行に必要。`npx` コマンドで MCP サーバーを起動する。
n8n のローカル実行にも使用する。

#### インストール（推奨: nvm 経由）

```bash
# nvm（Node Version Manager）をインストール
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# シェルを再起動してから
nvm install --lts        # LTS 版（v20 系）をインストール
nvm use --lts
nvm alias default lts/*  # デフォルトに設定
```

#### 代替: 直接インストール

```bash
# Homebrew 経由
brew install node

# または公式サイトからインストーラーをダウンロード
# https://nodejs.org/
```

#### 料金
無料。オープンソース。

#### 動作確認

```bash
node -v    # v20.0.0 以上
npm -v     # 10.0.0 以上
npx -v     # npm と同じバージョン
```

#### PHOSARA 推奨バージョン
Node.js v20 LTS 以上（v24 系でも動作確認済み）

#### トラブルシューティング

| エラー | 原因 | 解決方法 |
|---|---|---|
| `nvm: command not found` | シェルの設定未反映 | ターミナルを再起動、または `source ~/.zshrc` |
| `EACCES permission denied` | npm のグローバルディレクトリに権限がない | nvm 経由でインストールし直す |

---

### 1.3 GitHub

#### 概要
PHOSARA の**唯一の正典（Single Source of Truth）**。
- AI 社員の設計仕様・ナレッジ・ログ・承認キューをすべて Markdown ファイルで管理
- AI 社員が自動コミット・プッシュして記録を残す
- オーナーがブラウザ上で承認キューを確認・承認する

#### アカウント作成
1. https://github.com/ にアクセス
2. 右上「Sign up」をクリック
3. メールアドレス・パスワード・ユーザー名を設定

#### 料金

| プラン | 月額 | 主な内容 |
|---|---|---|
| Free | $0 | パブリック・プライベートリポジトリ無制限、Actions 2,000分/月 |
| Pro | $4 | Actions 3,000分/月、高度なコードレビュー機能 |
| Team | $4/人 | チーム管理機能 |

**PHOSARA 推奨:** Free プラン（Phase 1 は十分）

#### Personal Access Token（PAT）の取得

MCP github サーバーと Webhook 認証に必須。

```
1. GitHub → 右上アバター → Settings
2. 左メニュー最下部「Developer settings」
3. Personal access tokens → Fine-grained tokens → Generate new token
4. 以下を設定:
   - Token name: phosara-ai-agent
   - Expiration: 90 days（定期更新推奨）
   - Repository access: Only select repositories → phosara
   - Repository permissions:
     ✓ Contents: Read and write
     ✓ Metadata: Read-only（自動付与）
     ✓ Webhooks: Read-only
5. 「Generate token」→ トークンをコピーして .env に保存
   ※ この画面を閉じると二度と表示されない
```

#### Webhook の設定（n8n と連携する場合）

```
1. phosara リポジトリ → Settings → Webhooks → Add webhook
2. Payload URL: http://あなたのn8nのURL/webhook/sales-approval
3. Content type: application/json
4. Secret: .env の N8N_WEBHOOK_SECRET の値
5. Events: Just the push event
6. Active: ✓
7. Add webhook
```

#### 動作確認

```bash
# GitHub CLI でログイン確認
gh auth login
gh auth status
# ✓ Logged in to github.com as PHOSARA01 (...)

# リポジトリのクローン確認
git clone https://github.com/PHOSARA01/phosara.git
```

#### トラブルシューティング

| エラー | 原因 | 解決方法 |
|---|---|---|
| `401 Unauthorized` | PAT の期限切れ・権限不足 | Settings → PAT で権限を確認・再発行 |
| `403 Forbidden` | Repository access の設定ミス | PAT の Repository access を確認 |
| `Repository not found` | クローン URL の間違い | `https://github.com/PHOSARA01/phosara.git` を確認 |

---

### 1.4 Claude Code

#### 概要
PHOSARA AI 社員の**頭脳**。
「AI 社員 = Claude Code」と考えてよい。
Claude Code が知識を読み込み、調査し、分析し、文章を生成し、ファイルに記録する。

n8n がスケジューラー、MCP が道具箱、Claude Code が考えて行動する、という役割分担。

#### インストール

```bash
npm install -g @anthropic-ai/claude-code
```

#### 料金

| プラン | 月額 | 内容 |
|---|---|---|
| Claude.ai Pro（個人）| $20 | claude.ai の利用。API は別課金 |
| Anthropic API（Pay-as-you-go）| 使った分だけ | AI 社員の実行に使用 |

**API 料金（claude-sonnet-4-6 — PHOSARA 推奨モデル）:**

| | 料金 |
|---|---|
| 入力トークン | $3.00 / 100万トークン |
| 出力トークン | $15.00 / 100万トークン |

**PHOSARA Phase 1 試算:**
- 1ターゲット処理 ≈ 5,000〜8,000 トークン
- 月22営業日 × 1社 = 22回
- 月額 ≈ **$0.50 以下**（ほぼ無視できるコスト）

**PHOSARA 推奨:** API の Pay-as-you-go（従量課金）

#### API キーの取得

```
1. https://console.anthropic.com/ にアクセス
2. アカウント作成 or ログイン
3. 左メニュー「API Keys」→「Create Key」
4. Name: phosara-ai-agent
5. キーをコピーして .env に保存
   ANTHROPIC_API_KEY=sk-ant-api03-...
```

#### 初期設定

```bash
# API キーを環境変数に設定（.env から読み込む）
source .env
export ANTHROPIC_API_KEY

# または直接設定（一時的）
export ANTHROPIC_API_KEY=sk-ant-api03-your-key-here
```

#### Claude Code の設定ファイル

グローバル設定: `~/.claude/settings.json`
プロジェクト設定: `phosara/.claude/settings.json`（プロジェクト固有）

```json
{
  "theme": "dark",
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-filesystem",
        "/absolute/path/to/phosara"
      ]
    },
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "ghp_your_token_here"
      }
    },
    "brave-search": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-brave-search"],
      "env": {
        "BRAVE_API_KEY": "BSA_your_key_here"
      }
    },
    "fetch": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-fetch"]
    }
  }
}
```

#### MCP サーバーの追加コマンド（推奨方法）

```bash
# プロジェクトディレクトリで実行（プロジェクトスコープで追加）
cd /path/to/phosara

claude mcp add filesystem -- \
  npx -y @modelcontextprotocol/server-filesystem /path/to/phosara

claude mcp add github \
  -e GITHUB_PERSONAL_ACCESS_TOKEN=ghp_your_token_here -- \
  npx -y @modelcontextprotocol/server-github

claude mcp add brave-search \
  -e BRAVE_API_KEY=BSA_your_key_here -- \
  npx -y @modelcontextprotocol/server-brave-search

claude mcp add fetch -- \
  npx -y @modelcontextprotocol/server-fetch

# 追加を確認
claude mcp list
```

#### 動作確認

```bash
claude --version
# 2.1.195 以上

# 対話モードで起動確認
claude
# > Welcome to Claude Code...
# Ctrl+C で終了

# MCP ツールの確認
claude mcp list
```

#### トラブルシューティング

| エラー | 原因 | 解決方法 |
|---|---|---|
| `ANTHROPIC_API_KEY is not set` | 環境変数未設定 | `export ANTHROPIC_API_KEY=sk-ant-...` |
| `claude: command not found` | npm グローバルインストール失敗 | `npm install -g @anthropic-ai/claude-code` を再実行 |
| `API Error 401` | API キー不正 | Anthropic Console でキーを確認 |
| `API Error 429` | レート制限超過 | しばらく待って再試行 |

---

## 2. AI実行環境 — MCP

---

### 2.1 MCP とは

**MCP（Model Context Protocol）** は Claude Code が外部ツールを呼び出すための標準プロトコル。

```
Claude Code（頭脳）
    │
    ├── filesystem MCP  → ファイルを読み書きする
    ├── github MCP      → GitHub にコミットする
    ├── brave-search    → Web で企業を調査する
    └── fetch MCP       → 企業サイトを読み込む
```

**原則:**
- MCP サーバーは「道具」。判断を持たない
- 「何をするか」を決めるのは Claude Code（AI 社員）
- 道具を使う判断・順序・タイミングはすべて AI 社員が決める

---

### 2.2 filesystem MCP

#### 概要
ローカルの Markdown ファイルを読み書きする。
AI 社員が SALES_LOG.md・OWNER_APPROVAL_QUEUE.md・SALES_STATE.md を更新する際に使用。

#### インストール

```bash
npm install -g @modelcontextprotocol/server-filesystem
```

#### 料金
無料。オープンソース。

#### Claude Code への接続

```bash
claude mcp add filesystem -- \
  npx -y @modelcontextprotocol/server-filesystem /absolute/path/to/phosara
```

**設定ファイルへの直接記述（~/.claude/settings.json）:**
```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-filesystem",
        "/Users/your-username/Desktop/PHOSARA/PHOSARA（GitHubリポジトリ）"
      ]
    }
  }
}
```

#### 動作確認

```bash
# Claude Code を起動して filesystem が使えるか確認
claude
# > /mcp
# filesystem サーバーが CONNECTED と表示されれば OK
```

または:
```bash
claude -p "ai-agent/logs/SALES_LOG.md の内容を読んで内容を教えて" \
  --allowedTools "mcp__filesystem__read_file"
```

#### 利用できるツール

| ツール名 | 用途 |
|---|---|
| `read_file` | ファイルの読み込み |
| `write_file` | ファイルの書き込み（上書き） |
| `create_directory` | ディレクトリ作成 |
| `list_directory` | ディレクトリ一覧 |
| `search_files` | ファイル検索 |

#### トラブルシューティング

| エラー | 原因 | 解決方法 |
|---|---|---|
| `Path not allowed` | 指定パス外へのアクセス | MCP サーバー起動時のパス引数を確認 |
| `ENOENT: no such file or directory` | ファイルが存在しない | パスのスペル・大文字小文字を確認 |
| MCP が DISCONNECTED | サーバー起動失敗 | `npx @modelcontextprotocol/server-filesystem` を単体で実行してエラーを確認 |

---

### 2.3 github MCP

#### 概要
GitHub リポジトリへのファイル読み込み・コミット・プッシュを行う。
AI 社員が承認キューを更新したり、ログを自動コミットする際に使用。

#### インストール

```bash
npm install -g @modelcontextprotocol/server-github
```

#### 料金
無料。ただし GitHub Personal Access Token が必要（無料）。

#### API キー（PAT）の権限設定

```
Fine-grained Token の権限設定:
  Repository access: phosara リポジトリのみ
  Permissions:
    ✓ Contents: Read and write
    ✓ Metadata: Read-only（必須・自動付与）
    □ Pull requests: 不要
    □ Issues: 不要
```

#### Claude Code への接続

```bash
claude mcp add github \
  -e GITHUB_PERSONAL_ACCESS_TOKEN=ghp_your_token_here -- \
  npx -y @modelcontextprotocol/server-github
```

#### 利用できるツール

| ツール名 | 用途 |
|---|---|
| `get_file_contents` | ファイルの読み込み |
| `create_or_update_file` | ファイルの作成・更新・コミット |
| `push_files` | 複数ファイルの一括コミット |
| `list_commits` | コミット履歴の確認 |
| `search_repositories` | リポジトリ検索 |

#### 動作確認

```bash
claude -p "phosara リポジトリの README.md の最初の10行を読んで" \
  --allowedTools "mcp__github__get_file_contents"
```

#### トラブルシューティング

| エラー | 原因 | 解決方法 |
|---|---|---|
| `401 Unauthorized` | PAT の期限切れ | GitHub Settings で PAT を再発行 |
| `403 Forbidden` | 権限不足 | PAT の Contents 権限が Read and write か確認 |
| `422 Unprocessable Entity` | コミット内容の問題 | ブランチ名・ファイルパスを確認 |

---

### 2.4 fetch MCP

#### 概要
Web ページのコンテンツを取得する。
AI 社員が企業のホームページ・Google ビジネスプロフィール・採用ページを読み込む際に使用。

**重要:** 公開情報のみ取得する。ログイン必須ページへのアクセスは禁止。

#### インストール

```bash
npm install -g @modelcontextprotocol/server-fetch
```

#### 料金
無料。オープンソース。

#### Claude Code への接続

```bash
claude mcp add fetch -- \
  npx -y @modelcontextprotocol/server-fetch
```

#### 利用できるツール

| ツール名 | 用途 |
|---|---|
| `fetch` | URL を指定してページを取得（HTML → Markdown 変換済み）|

#### 動作確認

```bash
claude -p "phosara.co のトップページのコンテンツを取得して要約して" \
  --allowedTools "mcp__fetch__fetch"
```

#### 注意事項

- JavaScript で動的に生成されるコンテンツは取得できない場合がある
- 取得できない場合は `[仮定]` と明記して処理を続行する（Runtime §12.2）
- タイムアウトは通常 10〜15 秒

#### トラブルシューティング

| エラー | 原因 | 解決方法 |
|---|---|---|
| `timeout` | サイトの応答が遅い | `[仮定]` と明記して次の処理へ |
| `blocked by robots.txt` | クローラー拒否 | 別の情報源（Brave Search）を使用 |
| `empty response` | JavaScript のみで生成されるページ | 静的な情報を Brave Search で取得 |

---

### 2.5 Brave Search MCP

#### 概要
Web 検索 API。AI 社員が営業ターゲット企業の情報を調査する際に使用。
Google Maps の口コミ件数・SNS の活動状況・ホームページの状態を確認する。

#### アカウント作成・API キー取得

```
1. https://api.search.brave.com/ にアクセス
2. 「Get Started for Free」
3. アカウント作成（メールアドレス + パスワード）
4. ダッシュボード → API Keys → Create New Key
5. Key Name: phosara-ai-agent
6. API キーをコピーして .env に保存
   BRAVE_SEARCH_API_KEY=BSA_your_key_here
```

#### 料金

| プラン | 月額 | クエリ数 |
|---|---|---|
| Free | $0 | 2,000 クエリ/月 |
| Pro | $3 | 20,000 クエリ/月 |

**PHOSARA Phase 1 消費量試算:**
- 1社あたり最大 5 クエリ
- 月 22 営業日 × 5 クエリ = 110 クエリ
- **Free プランで十分**

**PHOSARA 推奨:** Free プラン（Phase 1〜2）

#### インストール

```bash
npm install -g @modelcontextprotocol/server-brave-search
```

#### Claude Code への接続

```bash
claude mcp add brave-search \
  -e BRAVE_API_KEY=BSA_your_key_here -- \
  npx -y @modelcontextprotocol/server-brave-search
```

#### 利用できるツール

| ツール名 | 用途 |
|---|---|
| `brave_web_search` | Web 検索（最大 20 件の結果）|
| `brave_local_search` | ローカル情報検索（店舗・地図情報）|

#### クエリ上限の管理（重要）

```
PHOSARA ルール:
1 ターゲットにつき最大 5 クエリまで

  クエリ例:
  1. "{会社名} 公式サイト"
  2. "{会社名} Instagram Facebook Twitter"
  3. "{会社名} Googleマップ 口コミ"
  4. "{会社名} 採用 求人"
  5. "{業種} {地域} 競合"
```

#### 動作確認

```bash
claude -p "'山田建設 栃木県' を検索して結果を教えて" \
  --allowedTools "mcp__brave-search__brave_web_search"
```

#### トラブルシューティング

| エラー | 原因 | 解決方法 |
|---|---|---|
| `401 Unauthorized` | API キー不正 | Brave Dashboard でキーを確認 |
| `429 Too Many Requests` | 月次上限に達した | 翌月まで待機 or Pro プランへ移行 |
| `empty results` | 検索語句が不適切 | 別のキーワードで再検索 |

---

## 3. 自動化 — n8n

#### 概要
**スケジューラー・通知ルーター**として動作する。
AI 社員（Claude Code）を毎朝定時に起動し、結果をオーナーへメールで通知する。

**n8n が担当すること:**
- 毎朝 09:00 に `morning-batch.sh` を実行する（TRG-01）
- GitHub への push を検知してオーナーにメールを送る（WF-02）
- 毎夕 18:00 に日次レポートを生成・送信する（TRG-02）

**n8n が担当しないこと:**
- 営業文の生成・分析・判断（Claude Code が担当）

#### アカウント作成（セルフホスト 推奨）

```bash
# Node.js が必要（v18 以上）

# n8n をグローバルインストール
npm install -g n8n

# 起動
n8n start

# ブラウザで http://localhost:5678 にアクセス
# 初回: アカウント設定画面が表示される
# メールアドレス・パスワードを設定
```

#### 料金

| プラン | 月額 | 内容 |
|---|---|---|
| セルフホスト（OSS）| $0 | 全機能利用可能。サーバー費は別途 |
| n8n Cloud Starter | $20 | ホスティング不要。5 ワークフロー |
| n8n Cloud Pro | $50 | 15 ワークフロー |

**PHOSARA 推奨:** セルフホスト（コスト $0、Mac のローカルで起動可能）

#### 起動の自動化（macOS launchd）

Mac を再起動しても n8n が自動起動するように設定する。

```bash
# launchd 設定ファイルを作成
cat << 'EOF' > ~/Library/LaunchAgents/com.phosara.n8n.plist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.phosara.n8n</string>
    <key>ProgramArguments</key>
    <array>
        <string>/usr/local/bin/n8n</string>
        <string>start</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <true/>
</dict>
</plist>
EOF

launchctl load ~/Library/LaunchAgents/com.phosara.n8n.plist
```

#### Credential の設定

**Gmail OAuth2（承認通知メールに使用）:**
```
1. n8n → 右上メニュー → Credentials → New
2. Search: Gmail → Gmail OAuth2 API
3. 「OAuth Redirect URL」をコピー（Google Cloud に登録する URL）
   例: http://localhost:5678/rest/oauth2-credential/callback
4. Google Cloud で OAuth2 クライアントを作成（→ 4章参照）
5. Client ID・Client Secret を n8n に入力
6. 「Sign in with Google」で認証
```

**GitHub Personal Access Token:**
```
1. n8n → Credentials → New → GitHub API
2. Access Token: ghp_your_token_here
3. 保存
```

#### ワークフローのインポート

```bash
# JSON ファイルをインポート
n8n import:workflow --input=n8n/workflows/sales-morning-batch.json
n8n import:workflow --input=n8n/workflows/sales-approval-notifier.json
n8n import:workflow --input=n8n/workflows/sales-evening-report.json
```

#### 動作確認

```
1. ブラウザで http://localhost:5678 にアクセス
2. 作成したワークフローを開く
3. 右上「Execute Workflow」でテスト実行
4. 各ノードが「Success」と表示されれば OK
```

#### トラブルシューティング

| エラー | 原因 | 解決方法 |
|---|---|---|
| `localhost:5678 に接続できない` | n8n が起動していない | `n8n start` を実行 |
| `Cannot execute workflow: No trigger` | トリガーノードがない | Cron ノードを追加 |
| `Gmail: OAuth2 error` | 認証期限切れ | Credentials で再認証 |
| `Webhook not receiving` | Webhook URL が間違っている | n8n の Webhook URL と GitHub 設定を照合 |

---

## 4. Google Workspace

---

### 4.1 Google Cloud プロジェクト

#### 概要
Gmail API・Google Calendar API・Google Drive API を使用するための基盤。
n8n が Gmail でオーナーに通知を送るために必要。

#### プロジェクト作成

```
1. https://console.cloud.google.com/ にアクセス
2. Googleアカウントでログイン
3. 上部の「プロジェクトを選択」→「新しいプロジェクト」
4. プロジェクト名: PHOSARA-AI-Company
5. 「作成」
```

#### OAuth 同意画面の設定

```
1. APIs & Services → OAuth consent screen
2. User Type: Internal（Workspace アカウントの場合）
   または External（一般 Gmail の場合）
3. アプリ名: PHOSARA AI Company
4. ユーザーサポートメール: あなたのメールアドレス
5. デベロッパーの連絡先: あなたのメールアドレス
6. 保存して続行
7. スコープ: 後で API ごとに設定
8. テストユーザー（External の場合）: あなたのメールアドレスを追加
```

#### OAuth2 認証情報の作成

```
1. APIs & Services → Credentials → Create Credentials → OAuth client ID
2. アプリケーションの種類: Web アプリケーション
3. 名前: PHOSARA n8n
4. 承認済みのリダイレクト URI:
   http://localhost:5678/rest/oauth2-credential/callback
5. 「作成」→ クライアントID・シークレットをコピー
```

#### 料金

| API | 無料枠 |
|---|---|
| Gmail API | 1,000,000 割り当てユニット/日（実質無制限）|
| Calendar API | 1,000,000 クエリ/100秒 |
| Drive API | 1,000,000 クエリ/100秒 |

**PHOSARA 推奨:** 無料枠で十分（Phase 1〜3 まで無料）

---

### 4.2 Gmail API

#### 概要
n8n がオーナーに承認通知メールを送るために使用。
「承認キューが更新されました」「朝バッチが完了しました」等の通知。

#### API の有効化

```
1. Google Cloud Console → APIs & Services → Library
2. 検索: "Gmail API"
3. Gmail API → 有効にする
```

#### スコープの設定

```
OAuth 同意画面 → スコープを追加:
  https://www.googleapis.com/auth/gmail.send
  （メール送信のみ。受信・削除権限は付与しない）
```

#### n8n との接続

```
1. n8n → Credentials → Gmail OAuth2 API
2. Client ID: Google Cloud からコピーした値
3. Client Secret: Google Cloud からコピーした値
4. 「Sign in with Google」
5. あなたの Google アカウントで認証
6. アクセスを許可
```

#### 動作確認

```
1. n8n で Gmail ノードを追加
2. Operation: Send
3. To: your-email@example.com
4. Subject: テスト送信
5. Message: テスト本文
6. 実行 → メールが届けば OK
```

#### トラブルシューティング

| エラー | 原因 | 解決方法 |
|---|---|---|
| `Gmail API not enabled` | API 未有効化 | Google Cloud → Library → Gmail API → 有効化 |
| `Access denied` | スコープ不足 | OAuth 同意画面でスコープを確認 |
| `This app is blocked` | OAuth 同意画面が未確認 | Google Cloud → OAuth consent → ステータス確認 |
| `Quota exceeded` | 送信上限（一般アカウント: 500通/日）| 翌日まで待機 |

---

### 4.3 Google Calendar API

#### 概要
Business Audit の予約管理に使用（Phase 3 以降）。
AI 社員が候補日程を確認し、オーナーのカレンダーに予約枠を登録する。

#### API の有効化

```
1. Google Cloud Console → APIs & Services → Library
2. 検索: "Google Calendar API"
3. Google Calendar API → 有効にする
```

#### スコープの設定

```
OAuth 同意画面 → スコープを追加:
  https://www.googleapis.com/auth/calendar.events
  （イベントの読み書き。カレンダー設定の変更権限は付与しない）
```

#### n8n との接続

```
1. n8n → Credentials → Google Calendar OAuth2 API
2. Client ID・Client Secret を入力
3. 「Sign in with Google」で認証
```

#### 動作確認

```
1. n8n で Google Calendar ノードを追加
2. Operation: Get Many Events
3. Calendar ID: primary
4. 実行 → 自分のカレンダーのイベントが表示されれば OK
```

#### 注意事項

- Phase 1・2 では使用しない
- Phase 3 で Business Audit 予約機能を実装する際に有効化する
- イベントの削除・カレンダーの共有操作には追加スコープが必要

---

### 4.4 Google Drive API

#### 概要
ナレッジ・営業資料・設計書を Google Drive で管理する場合に使用（Phase 2 以降）。
Phase 1 では GitHub Markdown がメインのデータ層のため必須ではない。

#### API の有効化

```
1. Google Cloud Console → APIs & Services → Library
2. 検索: "Google Drive API"
3. Google Drive API → 有効にする
```

#### スコープの設定

```
OAuth 同意画面 → スコープを追加:
  https://www.googleapis.com/auth/drive.file
  （アプリが作成・開いたファイルのみ。Drive 全体へのアクセス不可）
```

#### n8n との接続

```
1. n8n → Credentials → Google Drive OAuth2 API
2. Client ID・Client Secret を入力
3. 「Sign in with Google」で認証
```

#### 動作確認

```
1. n8n で Google Drive ノードを追加
2. Operation: List
3. 実行 → ファイル一覧が表示されれば OK
```

#### 注意事項

- Phase 1 では設定のみ行い、使用しない
- Phase 2 で営業ターゲットリストを Google Sheets に移行する際に使用する

---

## 5. Web サービス

---

### 5.1 Vercel

#### 概要
PHOSARA 公式サイト（https://phosara.co）のホスティング。
GitHub にプッシュすると自動デプロイされる。
AI 社員が Web サイトに変更を加えた場合、push → Vercel が自動更新する。

#### 現状
**既に設定済み。**
- リポジトリ: PHOSARA01/phosara
- ブランチ: main → 自動デプロイ
- URL: https://phosara.co

#### 料金

| プラン | 月額 | 内容 |
|---|---|---|
| Hobby | $0 | 個人利用。帯域 100GB/月 |
| Pro | $20/人 | 商用利用・チーム管理 |

**PHOSARA 推奨:** Hobby プラン（現在使用中）

#### 動作確認

```bash
# Vercel CLI を使う場合
npm install -g vercel
vercel login

# デプロイ状況の確認
vercel ls
```

または:
```
1. https://vercel.com/phosara01 にアクセス
2. phosara プロジェクトの Deployments タブ
3. 最新デプロイが「Ready」であれば OK
```

#### GitHub との連携確認

```bash
git push origin main
# → Vercel が自動デプロイを開始
# → https://phosara.co で反映を確認
```

#### トラブルシューティング

| エラー | 原因 | 解決方法 |
|---|---|---|
| デプロイが始まらない | GitHub連携が切れている | Vercel → Settings → Git でリポジトリを再連携 |
| Build Error | コードのエラー | Vercel の Deployments → Error ログを確認 |
| 404 Not Found | ルーティング設定ミス | `vercel.json` を確認 |

---

### 5.2 Formspree

#### 概要
PHOSARA 公式サイトの問い合わせフォームのバックエンド。
フォーム送信をメールで受信するサービス。AI 社員が実装するフォームの送信先。

#### 現状
**既に設定済み。**
- フォーム ID: `mzdnpzpy`
- エンドポイント: `https://formspree.io/f/mzdnpzpy`
- 送信先メール: オーナーメールアドレス

#### 料金

| プラン | 月額 | 送信数 |
|---|---|---|
| Free | $0 | 50件/月 |
| Gold | $8 | 1,000件/月 |

**PHOSARA 推奨:** Free プラン（現在使用中）

#### 動作確認

```bash
# フォーム送信テスト（実際の送信はしない。ローカルで確認）
# ブラウザで https://phosara.co/#contact を開く
# 名前・メール・本文を入力して「送信」
# 確認メールが届けば OK
```

**重要:** 実際の問い合わせフォームに対してテスト送信を行うとオーナーにメールが届く。
テストは必要最小限にとどめること。

#### index.html でのフォーム設定確認

```html
<form action="https://formspree.io/f/mzdnpzpy" method="POST">
  <!-- gotcha フィールド（スパム対策）が含まれているか確認 -->
  <input type="text" name="_gotcha" style="display:none">
</form>
```

#### トラブルシューティング

| エラー | 原因 | 解決方法 |
|---|---|---|
| フォーム送信後に何も起きない | action URL が間違っている | `action="https://formspree.io/f/mzdnpzpy"` を確認 |
| メールが届かない | Formspree の設定ミス | Formspree Dashboard で設定を確認 |
| スパムが多い | gotcha フィールド未設置 | `<input type="text" name="_gotcha" style="display:none">` を追加 |

---

## 6. 統合設定

---

### 6.1 .env ファイルの作成

```bash
# リポジトリルートで実行
cd /path/to/phosara

# テンプレートをコピー
cp company/13_ai-company/implementation/.env.example .env

# エディタで編集
open -a TextEdit .env
```

**記入する内容:**

```bash
# ============================================================
# PHOSARA AI Sales Agent — 本番環境変数
# ============================================================

# Anthropic API
ANTHROPIC_API_KEY=sk-ant-api03-xxxxxxxxxxxxxxxx

# GitHub
GITHUB_PERSONAL_ACCESS_TOKEN=ghp_xxxxxxxxxxxxxxxx
GITHUB_REPO_OWNER=PHOSARA01
GITHUB_REPO_NAME=phosara
GITHUB_BRANCH=main

# Brave Search
BRAVE_SEARCH_API_KEY=BSA_xxxxxxxxxxxxxxxx

# n8n
N8N_HOST=http://localhost:5678
N8N_WEBHOOK_SECRET=任意のランダム文字列（パスワード生成ツールで作成）

# Agent 設定
SALES_AGENT_MAX_TARGETS_PER_RUN=1
SALES_AGENT_CONFIDENCE_THRESHOLD=70
SALES_AGENT_APPROVAL_SLA_HOURS=48
OWNER_EMAIL=オーナーのメールアドレス
```

**gitignore への追記確認:**

```bash
grep -q ".env" .gitignore && echo "OK" || echo ".env を .gitignore に追加してください"
```

---

### 6.2 mcp-config.json の作成

```bash
# ディレクトリ作成
mkdir -p ai-agent

# 絶対パスを取得
REPO_PATH=$(pwd)
echo "REPO_PATH: $REPO_PATH"
```

`ai-agent/mcp-config.json` を以下の内容で作成:

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-filesystem",
        "/Users/your-username/Desktop/PHOSARA/PHOSARA（GitHubリポジトリ）"
      ],
      "description": "ローカル Markdown ファイルの読み書き"
    },
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "${GITHUB_PERSONAL_ACCESS_TOKEN}"
      },
      "description": "GitHub コミット・ファイル読み込み"
    },
    "brave-search": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-brave-search"],
      "env": {
        "BRAVE_API_KEY": "${BRAVE_SEARCH_API_KEY}"
      },
      "description": "企業 Web 調査"
    },
    "fetch": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-fetch"],
      "description": "企業サイトのページ取得"
    }
  }
}
```

**パスの確認:**

```bash
# あなたの実際のパスを確認
echo "リポジトリの絶対パス:"
cd /path/to/phosara && pwd

# そのパスを mcp-config.json の filesystem args に設定する
```

---

### 6.3 Claude Code の MCP 設定反映

```bash
# Claude Code の設定ファイルを確認
cat ~/.claude/settings.json

# MCP サーバーを追加（プロジェクトスコープ）
source .env  # 環境変数を読み込む

claude mcp add filesystem -- \
  npx -y @modelcontextprotocol/server-filesystem $(pwd)

claude mcp add github \
  -e GITHUB_PERSONAL_ACCESS_TOKEN=$GITHUB_PERSONAL_ACCESS_TOKEN -- \
  npx -y @modelcontextprotocol/server-github

claude mcp add brave-search \
  -e BRAVE_API_KEY=$BRAVE_SEARCH_API_KEY -- \
  npx -y @modelcontextprotocol/server-brave-search

claude mcp add fetch -- \
  npx -y @modelcontextprotocol/server-fetch

# 確認
claude mcp list
```

---

## 7. 動作確認

### ステップ 1: 環境の確認

```bash
# 全体の確認スクリプト
cat << 'EOF' > scripts/verify-setup.sh
#!/bin/bash
set -e

echo "========================================="
echo " PHOSARA AI Company セットアップ確認"
echo "========================================="
echo ""

# Git
echo "--- Git ---"
git --version && echo "✓ Git OK" || echo "✗ Git NG"

# Node.js
echo ""
echo "--- Node.js ---"
node -v && echo "✓ Node.js OK" || echo "✗ Node.js NG"
npm -v && echo "✓ npm OK" || echo "✗ npm NG"

# Claude Code
echo ""
echo "--- Claude Code ---"
claude --version && echo "✓ Claude Code OK" || echo "✗ Claude Code NG"

# MCP サーバー
echo ""
echo "--- MCP サーバー ---"
npm list -g @modelcontextprotocol/server-filesystem 2>/dev/null | grep -q server-filesystem \
  && echo "✓ filesystem MCP OK" || echo "✗ filesystem MCP NG (npm install -g @modelcontextprotocol/server-filesystem)"
npm list -g @modelcontextprotocol/server-github 2>/dev/null | grep -q server-github \
  && echo "✓ github MCP OK" || echo "✗ github MCP NG"
npm list -g @modelcontextprotocol/server-brave-search 2>/dev/null | grep -q server-brave-search \
  && echo "✓ brave-search MCP OK" || echo "✗ brave-search MCP NG"
npm list -g @modelcontextprotocol/server-fetch 2>/dev/null | grep -q server-fetch \
  && echo "✓ fetch MCP OK" || echo "✗ fetch MCP NG"

# 環境変数
echo ""
echo "--- 環境変数 ---"
[ -n "$ANTHROPIC_API_KEY" ] && echo "✓ ANTHROPIC_API_KEY" || echo "✗ ANTHROPIC_API_KEY 未設定"
[ -n "$GITHUB_PERSONAL_ACCESS_TOKEN" ] && echo "✓ GITHUB_PERSONAL_ACCESS_TOKEN" || echo "✗ GITHUB_PAT 未設定"
[ -n "$BRAVE_SEARCH_API_KEY" ] && echo "✓ BRAVE_SEARCH_API_KEY" || echo "✗ BRAVE_SEARCH_API_KEY 未設定"

# .env のセキュリティ確認
echo ""
echo "--- セキュリティ ---"
git check-ignore .env 2>/dev/null | grep -q ".env" \
  && echo "✓ .env は .gitignore に含まれています" \
  || echo "⚠ .env を .gitignore に追加してください"

echo ""
echo "========================================="
echo " 確認完了"
echo "========================================="
EOF

chmod +x scripts/verify-setup.sh
source .env
bash scripts/verify-setup.sh
```

### ステップ 2: Claude Code の MCP 動作確認

```bash
# filesystem: ファイルが読めるか
claude -p "ai-agent/ ディレクトリのファイル一覧を教えて" \
  --allowedTools "mcp__filesystem__list_directory"

# brave-search: 検索できるか
claude -p "'PHOSARA クリエイティブ' で検索して上位3件を教えて" \
  --allowedTools "mcp__brave-search__brave_web_search"

# fetch: ページが取得できるか
claude -p "https://phosara.co のトップページを取得して最初の200文字を教えて" \
  --allowedTools "mcp__fetch__fetch"

# github: リポジトリが読めるか
claude -p "PHOSARA01/phosara の README.md の最初の5行を教えて" \
  --allowedTools "mcp__github__get_file_contents"
```

### ステップ 3: n8n の動作確認

```
1. http://localhost:5678 にアクセス
2. sales-morning-batch ワークフローを開く
3. 「Test workflow」をクリック（手動実行）
4. 各ノードが Success（緑）になることを確認
5. Gmail 通知が届くことを確認
```

### ステップ 4: エンドツーエンドテスト

```bash
# morning-batch.sh を手動実行
source .env
bash scripts/morning-batch.sh

# 実行後の確認
cat ai-agent/queue/OWNER_APPROVAL_QUEUE.md  # 三点セットが追記されているか
cat ai-agent/logs/SALES_LOG.md              # 状態遷移が記録されているか
cat ai-agent/state/SALES_STATE.md           # WAITING_APPROVAL になっているか
```

---

## 8. PHOSARA AI Company セットアップチェックリスト

セットアップ完了の確認に使用する。すべてにチェックが入れば本番稼働が可能。

---

### Phase 1-A: 開発環境

```
□ Git インストール完了
  確認: git --version → 2.39 以上

□ Node.js / npm インストール完了
  確認: node -v → v20 以上  /  npm -v → 10 以上

□ GitHub アカウント作成・リポジトリのクローン完了
  確認: cd phosara && git status

□ GitHub Personal Access Token 作成完了
  確認: Contents Read/Write 権限あり

□ Claude Code インストール完了
  確認: claude --version → 2.x

□ Anthropic API Key 取得完了
  確認: export ANTHROPIC_API_KEY=sk-ant-... && claude -p "hello"

□ .env ファイル作成・全変数設定完了
  確認: bash scripts/verify-setup.sh で全項目 ✓

□ .env が .gitignore に含まれていることを確認
  確認: git check-ignore .env → .env が表示される
```

---

### Phase 1-B: MCP 設定

```
□ filesystem MCP インストール完了
  確認: npm list -g @modelcontextprotocol/server-filesystem

□ filesystem MCP — Claude Code 接続完了
  確認: claude mcp list に filesystem が表示される

□ github MCP インストール完了
  確認: npm list -g @modelcontextprotocol/server-github

□ github MCP — Claude Code 接続完了（PAT 設定済み）
  確認: claude mcp list に github が表示される

□ fetch MCP インストール完了
  確認: npm list -g @modelcontextprotocol/server-fetch

□ fetch MCP — Claude Code 接続完了
  確認: claude mcp list に fetch が表示される

□ Brave Search アカウント作成・API Key 取得完了
  確認: Brave Dashboard で API Key が有効

□ Brave Search MCP インストール完了
  確認: npm list -g @modelcontextprotocol/server-brave-search

□ Brave Search MCP — Claude Code 接続完了
  確認: claude mcp list に brave-search が表示される

□ 全 MCP の動作確認完了（ファイル読み書き・検索・ページ取得・GitHub）
  確認: 各 MCP のコマンド例を実行して正常動作を確認
```

---

### Phase 1-C: n8n 設定

```
□ n8n インストール完了
  確認: n8n --version

□ n8n 起動確認
  確認: http://localhost:5678 でログイン画面が表示される

□ n8n 自動起動設定完了（launchd）
  確認: Mac 再起動後に http://localhost:5678 でアクセスできる

□ n8n — Gmail OAuth2 Credential 設定完了
  確認: n8n の Gmail ノードでテストメール送信成功

□ n8n — GitHub PAT Credential 設定完了
  確認: n8n の GitHub ノードでリポジトリ一覧が表示される

□ TRG-01（朝バッチ）ワークフロー設定完了
  確認: 手動実行で morning-batch.sh が起動する

□ WF-02（承認通知）ワークフロー設定完了
  確認: OWNER_APPROVAL_QUEUE.md を更新→push → Gmail 通知が届く

□ GitHub Webhook 設定完了
  確認: Webhook の Recent Deliveries に 200 が表示される
```

---

### Phase 1-D: Google Workspace

```
□ Google Cloud プロジェクト作成完了
  確認: console.cloud.google.com でプロジェクト選択可能

□ OAuth 同意画面設定完了
  確認: APIs & Services → OAuth consent screen が「設定済み」

□ OAuth2 クライアント ID / シークレット 取得完了
  確認: Credentials に OAuth2 クライアントが 1件以上ある

□ Gmail API 有効化完了
  確認: APIs & Services → Library → Gmail API が「有効」

□ Gmail API スコープ設定完了（gmail.send）
  確認: OAuth 同意画面のスコープに gmail.send が含まれる

□ Google Calendar API 有効化完了（Phase 3 用）
  確認: APIs & Services → Library → Google Calendar API が「有効」

□ Google Drive API 有効化完了（Phase 2 用）
  確認: APIs & Services → Library → Google Drive API が「有効」
```

---

### Phase 1-E: Web サービス確認

```
□ Vercel 接続確認完了
  確認: git push origin main → https://phosara.co に反映

□ Vercel Deployment が「Ready」状態であることを確認
  確認: vercel.com/phosara01 でデプロイ状況を確認

□ Formspree 接続確認完了
  確認: https://phosara.co/#contact のフォームが機能する

□ Formspree フォーム ID の確認
  確認: index.html の action="https://formspree.io/f/mzdnpzpy"
```

---

### Phase 1-F: エンドツーエンド動作確認

```
□ verify-setup.sh — 全項目 ✓ 確認完了
  確認: bash scripts/verify-setup.sh → 全行 ✓

□ Claude Code の全 MCP 動作確認完了
  確認: filesystem / github / brave-search / fetch 各コマンド例を実行

□ morning-batch.sh の手動実行確認完了
  確認: OWNER_APPROVAL_QUEUE.md に三点セットが追記される

□ SALES_LOG.md に状態遷移が記録されることを確認
  確認: WAITING_APPROVAL エントリが存在する

□ GitHub に自動コミットが記録されることを確認
  確認: git log --oneline | head -3 に sales: エントリがある

□ 承認通知メールが届くことを確認
  確認: OWNER_APPROVAL_QUEUE.md を更新→push → Gmail 通知受信

□ PHOSARA AI Company Phase 1 MVP 動作確認完了 🎉
```

---

> **セットアップ完了後の最初のアクション**
>
> 1. `bash scripts/morning-batch.sh` を手動実行
> 2. `ai-agent/queue/OWNER_APPROVAL_QUEUE.md` で営業文を確認
> 3. 承認欄に「承認: 案A」と追記してコミット
> 4. Phase 2（自動送信・返信確認）の実装へ進む

---

*本ガイドはサービスのアップデートに応じて随時更新する。*
*API キーの更新・サービスの変更が発生した場合は本書の該当セクションも更新すること。*
