# n8n ワークフロー — PHOSARA AI Sales Agent

## 概要

n8n は PHOSARA AI Sales Agent の**スケジューラー・通知ルーター**として動作する。
AI の判断・分析・生成は行わない。起動・通知・ルーティングのみ担当。

## セットアップ手順

### 1. n8n のインストール・起動

```bash
npm install -g n8n
n8n start
# → http://localhost:5678 でアクセス
```

### 2. Credential の設定

n8n → Credentials → New から以下を設定:

**Gmail OAuth2:**
- Google Cloud Console で OAuth2 クライアントを作成
- Redirect URI: `http://localhost:5678/rest/oauth2-credential/callback`
- Client ID・Secret を n8n に入力して認証

**GitHub Personal Access Token:**
- n8n → Credentials → New → GitHub API
- Token: .env の GITHUB_PERSONAL_ACCESS_TOKEN の値

### 3. 環境変数の設定

n8n → Settings → Variables（または Environment Variables）に設定:

| 変数名 | 内容 |
|---|---|
| OWNER_EMAIL | オーナーのメールアドレス |
| GITHUB_PERSONAL_ACCESS_TOKEN | GitHub PAT |

### 4. ワークフローのインポート

```bash
# n8n CLI でインポート
n8n import:workflow --input=n8n/workflows/sales-morning-batch.json
n8n import:workflow --input=n8n/workflows/sales-approval-notifier.json
n8n import:workflow --input=n8n/workflows/sales-evening-report.json
```

または n8n の UI から: Workflows → Import from file

### 5. パスの設定

各ワークフローの「Execute Command」ノードで、
`/path/to/phosara/` を実際のリポジトリパスに変更する。

```bash
# 実際のパスを確認
cd /path/to/phosara && pwd
```

### 6. GitHub Webhook の設定（WF-02 用）

```
1. GitHub → phosara リポジトリ → Settings → Webhooks → Add webhook
2. Payload URL: http://your-n8n-host:5678/webhook/sales-approval
3. Content type: application/json
4. Secret: 任意の文字列（.env の N8N_WEBHOOK_SECRET に同じ値を設定）
5. Events: Just the push event
6. Active: ✓
```

### 7. 動作確認

1. `sales-morning-batch` ワークフローを開く
2. 右上「Test workflow」をクリック（手動実行）
3. 各ノードが Success（緑）になることを確認
4. オーナーのメールに通知が届くことを確認

## ワークフロー一覧

| ファイル | トリガー | 機能 |
|---|---|---|
| `sales-morning-batch.json` | Cron 09:00 JST 月〜金 | morning-batch.sh を実行して結果をメール通知 |
| `sales-approval-notifier.json` | GitHub Webhook push | OWNER_APPROVAL_QUEUE.md 更新時にオーナーへメール |
| `sales-evening-report.json` | Cron 18:00 JST 月〜金 | evening-batch.sh を実行して日次レポートをメール通知 |

## ルール

- n8n は起動・通知のみ担当。ビジネスロジックを持たせない
- ワークフローを変更した場合は JSON をエクスポートして Git にコミットする
- n8n の Credential は n8n の暗号化ストレージで管理する（.env には書かない）
