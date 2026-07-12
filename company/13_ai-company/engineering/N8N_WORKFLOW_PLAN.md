# PHOSARA AI Sales Agent — n8n ワークフロー計画

| 項目 | 内容 |
|---|---|
| 文書ID | PHOSARA_AI_N8N_WORKFLOW_PLAN_v1 |
| 版 | v1.0 |
| 発効日 | 2026-07-13 |
| 状態 | ACTIVE |

---

## n8n の役割（明確化）

n8n は以下のみを担当する。判断・分析・生成は行わない。

| 担当する | 担当しない |
|---|---|
| スケジュール起動 | 営業文の生成 |
| Claude Code の呼び出し | Business Audit の分析 |
| ファイル変更の検知 | 承認の判断 |
| 承認通知メールの送信 | ターゲットの選定 |
| エラーアラートの送信 | ログの書き込み |

---

## 1. Phase 1 MVP ワークフロー一覧

| # | ワークフロー名 | トリガー | 優先度 |
|---|---|---|---|
| WF-01 | sales-morning-batch | Cron: 09:00 JST (月〜金) | Priority 1 |
| WF-02 | sales-approval-notifier | GitHub Webhook: push | Priority 1 |
| WF-03 | sales-evening-report | Cron: 18:00 JST (月〜金) | Priority 2 |
| WF-04 | sales-error-alert | Claude Code の exit code ≠ 0 | Priority 2 |
| WF-05 | sales-sla-watchdog | Cron: 毎時 | Priority 3 |

---

## 2. WF-01: sales-morning-batch（最優先）

**目的:** 毎朝 09:00 に Claude Code を起動してターゲット調査・営業文生成・承認キュー登録を実行する。

### フロー図

```
[Cron Trigger]
 09:00 JST 月〜金
    │
    ▼
[Function Node]
 実行日が営業日か確認
 (祝日チェック: 日本の公休日リスト)
    │
    ├── [祝日] → 終了
    │
    └── [営業日]
            ▼
        [Execute Command Node]
        bash /path/to/scripts/morning-batch.sh
            │
            ├── [exit 0: 成功]
            │       ▼
            │   [Read Binary Files Node]
            │   ai-agent/logs/batch-{today}.log を読み込む
            │       ▼
            │   [Send Email Node: Gmail]
            │   件名: ✅ [PHOSARA Sales] 朝バッチ完了 {date}
            │   本文: バッチログのサマリー
            │
            └── [exit ≠ 0: 失敗]
                    ▼
                [Send Email Node: Gmail]
                件名: 🚨 [PHOSARA Sales] 朝バッチ失敗 {date}
                本文: エラーログ全文
```

### n8n ノード設定

```json
{
  "name": "sales-morning-batch",
  "nodes": [
    {
      "type": "n8n-nodes-base.cron",
      "name": "Morning Trigger",
      "parameters": {
        "triggerTimes": {
          "item": [{"hour": 0, "minute": 0}]
        },
        "timezone": "Asia/Tokyo"
      },
      "cronExpression": "0 9 * * 1-5"
    },
    {
      "type": "n8n-nodes-base.executeCommand",
      "name": "Run Morning Batch",
      "parameters": {
        "command": "bash /path/to/scripts/morning-batch.sh"
      }
    },
    {
      "type": "n8n-nodes-base.gmail",
      "name": "Send Completion Email",
      "parameters": {
        "to": "{{$env.OWNER_EMAIL}}",
        "subject": "✅ [PHOSARA Sales] 朝バッチ完了 {{$now.format('MM/DD')}}",
        "message": "承認キューを確認してください: {{$env.GITHUB_QUEUE_URL}}"
      }
    }
  ]
}
```

---

## 3. WF-02: sales-approval-notifier（最優先）

**目的:** オーナーが GitHub の OWNER_APPROVAL_QUEUE.md を読んで承認・差戻しを行えるよう、新エントリ追加時にメール通知する。

### フロー図

```
[GitHub Webhook Trigger]
 Repository: phosara
 Event: push
 Branch: main
    │
    ▼
[Function Node]
 変更ファイルに OWNER_APPROVAL_QUEUE.md が含まれるか確認
    │
    ├── [含まれない] → 終了
    │
    └── [含まれる]
            ▼
        [HTTP Request Node]
        GitHub API: ファイルの最新内容を取得
        GET /repos/{owner}/{repo}/contents/ai-agent/queue/OWNER_APPROVAL_QUEUE.md
            │
            ▼
        [Function Node]
        最新の [AQ-YYYYMMDD-NNN] エントリを抽出
        会社名・Confidence Score・承認期限を取り出す
            │
            ▼
        [Send Email Node: Gmail]
        件名: 📋 [承認待ち] {会社名} — PHOSARA Sales Agent
        本文:
          ターゲット: {会社名}（{ランク}）
          Confidence Score: {XX}%
          承認期限: {YYYY-MM-DD 09:00}
          
          承認キューを確認:
          {GitHub URL to OWNER_APPROVAL_QUEUE.md}
          
          ファイルに「承認: 案A」または「差戻し: (理由)」を追記してください。
```

### GitHub Webhook 設定

```
URL: http://{n8n-host}/webhook/sales-approval
Content type: application/json
Secret: ${N8N_WEBHOOK_SECRET}
Events: Pushes
```

---

## 4. WF-03: sales-evening-report（Priority 2）

**目的:** 毎夕 18:00 に当日の営業活動サマリーを生成・送信する。

### フロー図

```
[Cron Trigger]
 18:00 JST 月〜金
    │
    ▼
[Execute Command Node]
bash /path/to/scripts/evening-batch.sh
    │
    ▼
[Read File Node]
ai-agent/logs/SALES_LOG.md の当日分を抽出
    │
    ▼
[Function Node]
本日の処理件数・状態別件数・承認待ち件数を集計
    │
    ▼
[Send Email Node: Gmail]
件名: 📊 [PHOSARA Sales] 日次レポート {MM/DD}
本文:
  本日の処理: {N}社
  承認待ち: {N}件
  承認済み: {N}件
  差戻し: {N}件
  
  詳細ログ: {GitHub URL to SALES_LOG.md}
```

---

## 5. WF-04: sales-error-alert（Priority 2）

**目的:** Claude Code の実行失敗を即座にオーナーへ通知する。

WF-01 の `exit ≠ 0` 分岐と連動。追加の監視として CONFLICT_LOG.md の変更も検知する。

### フロー図

```
[GitHub Webhook Trigger]
 Event: push
 ファイル: ai-agent/logs/CONFLICT_LOG.md
    │
    ▼
[HTTP Request Node]
CONFLICT_LOG.md の最新エントリを取得
    │
    ▼
[Send Email Node: Gmail]
件名: ⚠️ [要確認] PHOSARA Sales — CONFLICT LOG 更新
本文:
  新しい CONFLICT LOG エントリが記録されました。
  
  {CONFLICT_LOG の最新エントリ}
  
  確認: {GitHub URL to CONFLICT_LOG.md}
```

---

## 6. WF-05: sales-sla-watchdog（Priority 3）

**目的:** 承認期限（48時間）が近づいているエントリを検知してリマインダーを送る。

```
[Cron Trigger]
 毎日 09:30 JST（承認期限の前日に実行）
    │
    ▼
[HTTP Request Node]
OWNER_APPROVAL_QUEUE.md を取得
    │
    ▼
[Function Node]
承認期限まで 24 時間以内のエントリを検出
    │
    ├── [なし] → 終了
    │
    └── [あり]
            ▼
        [Send Email Node: Gmail]
        件名: ⏰ [承認期限まで24時間] {会社名} — PHOSARA Sales
        本文: 期限切れ前のリマインダー
```

---

## 7. n8n セットアップ手順

### 7.1 インストール（セルフホスト）

```bash
# Node.js 18+ が必要
npm install -g n8n

# 起動
n8n start

# ブラウザでアクセス
open http://localhost:5678
```

### 7.2 Credential の設定

1. **Gmail OAuth2**
   - n8n → Credentials → New → Gmail OAuth2 API
   - Google Cloud Console で OAuth2 クライアント ID を作成
   - Redirect URI: `http://localhost:5678/rest/oauth2-credential/callback`

2. **GitHub Personal Access Token**
   - n8n → Credentials → New → GitHub API
   - Access Token: `${GITHUB_PERSONAL_ACCESS_TOKEN}`

### 7.3 ワークフローのインポート

```bash
# n8n CLI でインポート
n8n import:workflow --input=n8n/workflows/sales-morning-batch.json
n8n import:workflow --input=n8n/workflows/sales-approval-notifier.json
n8n import:workflow --input=n8n/workflows/sales-evening-report.json
```

### 7.4 GitHub Webhook の設定

```
1. GitHub → phosara リポジトリ → Settings → Webhooks → Add webhook
2. Payload URL: http://{your-n8n-host}/webhook/sales-approval
3. Content type: application/json
4. Secret: ${N8N_WEBHOOK_SECRET}
5. Events: Just the push event
6. Active: ✓
```

---

## 8. Phase 2 追加予定ワークフロー

| ワークフロー | トリガー | 用途 |
|---|---|---|
| `sales-send-email` | 承認ファイル更新 | 承認済み文面の Gmail 送信（Phase 2）|
| `sales-reply-monitor` | Cron: 毎時 | Gmail 受信監視・返信分類（Phase 2）|
| `sales-nurture-scheduler` | Cron: 毎朝 | 育成台帳の 30/60/90日チェック（Phase 3）|
| `sales-weekly-review` | Cron: 金曜 17:00 | 週次レポート生成（Phase 2）|

---

*各ワークフローの JSON ファイルは `n8n/workflows/` ディレクトリに保存する。*
*ワークフローの変更後は必ず JSON をエクスポートして Git にコミットする。*
