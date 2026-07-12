# PHOSARA AI Sales Agent — MCP サーバー一覧

| 項目 | 内容 |
|---|---|
| 文書ID | PHOSARA_AI_MCP_SERVER_LIST_v1 |
| 版 | v1.0 |
| 発効日 | 2026-07-13 |
| 状態 | ACTIVE |

---

## MCP とは（実装者向け概要）

MCP（Model Context Protocol）は Claude Code が外部ツールを呼び出すための標準プロトコル。
Claude Code は MCP サーバーを「道具箱」として利用し、ファイル操作・Web検索・API呼び出しを行う。

**原則:**
- MCP サーバーは道具。判断を持たない
- 読む・書く・送るの単機能のみ
- エージェント層（Claude Code）が判断し、MCP を道具として使う

---

## 1. Phase 1 MVP — 必須 MCP サーバー

### 1.1 filesystem（最優先）

| 項目 | 内容 |
|---|---|
| パッケージ | `@modelcontextprotocol/server-filesystem` |
| 用途 | ローカル Markdown ファイルの読み書き |
| Phase | Phase 1 MVP 必須 |

**インストール:**
```bash
npm install -g @modelcontextprotocol/server-filesystem
```

**設定（mcp-config.json）:**
```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-filesystem",
        "/path/to/phosara"
      ]
    }
  }
}
```

**Claude Code が使う操作:**
- `read_file`: SALES_TARGET_LIST.md の読み込み
- `write_file`: OWNER_APPROVAL_QUEUE.md への三点セット追記
- `write_file`: SALES_LOG.md への状態遷移ログ追記
- `write_file`: SALES_STATE.md の状態更新
- `read_file`: CLAUDE.md・各プロンプトファイルの読み込み

**設定する許可パス（セキュリティ）:**
```
/path/to/phosara/ai-agent/          ← 読み書き可
/path/to/phosara/company/04_sales/  ← 読み取りのみ
/path/to/phosara/company/13_ai-company/  ← 読み取りのみ
```

---

### 1.2 github

| 項目 | 内容 |
|---|---|
| パッケージ | `@modelcontextprotocol/server-github` |
| 用途 | GitHub ファイルの読み込み・コミット・プッシュ |
| Phase | Phase 1 MVP 必須 |

**インストール:**
```bash
npm install -g @modelcontextprotocol/server-github
```

**設定（mcp-config.json）:**
```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "${GITHUB_PERSONAL_ACCESS_TOKEN}"
      }
    }
  }
}
```

**Claude Code が使う操作:**
- `create_or_update_file`: OWNER_APPROVAL_QUEUE.md のコミット
- `create_or_update_file`: SALES_LOG.md のコミット
- `get_file_contents`: 設計書・プロンプトの読み込み（リモート参照時）
- `push_files`: 複数ファイルの一括コミット

**注意:** filesystem MCP でローカルファイルを編集した後、github MCP でコミットする。
両方を使い分けることで「ローカルで生成 → GitHub に記録」のフローを実現する。

---

### 1.3 brave-search

| 項目 | 内容 |
|---|---|
| パッケージ | `@modelcontextprotocol/server-brave-search` |
| 用途 | 企業の Web 情報・競合調査 |
| Phase | Phase 1 MVP 必須 |

**インストール:**
```bash
npm install -g @modelcontextprotocol/server-brave-search
```

**設定（mcp-config.json）:**
```json
{
  "mcpServers": {
    "brave-search": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-brave-search"],
      "env": {
        "BRAVE_API_KEY": "${BRAVE_SEARCH_API_KEY}"
      }
    }
  }
}
```

**Claude Code が使う操作:**
- `brave_web_search`: 企業名 + 業種でのホームページ調査
- `brave_web_search`: Google ビジネスプロフィールの確認
- `brave_web_search`: SNS アカウントの存在確認

**API 使用上限の制御（Runtime §12.2 過剰接触防止の類比）:**
```
1ターゲットにつき最大5クエリ
  - クエリ1: "{会社名} 公式サイト"
  - クエリ2: "{会社名} Instagram Facebook"
  - クエリ3: "{会社名} Googleマップ 口コミ"
  - クエリ4: "{会社名} 採用 求人"
  - クエリ5: "{業種} {地域} ホームページ制作" （競合比較用）
```

---

### 1.4 fetch

| 項目 | 内容 |
|---|---|
| パッケージ | `@modelcontextprotocol/server-fetch` |
| 用途 | 企業サイトのページコンテンツ取得 |
| Phase | Phase 1 MVP 必須 |

**インストール:**
```bash
npm install -g @modelcontextprotocol/server-fetch
```

**設定（mcp-config.json）:**
```json
{
  "mcpServers": {
    "fetch": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-fetch"]
    }
  }
}
```

**Claude Code が使う操作:**
- `fetch`: 企業ホームページのトップ・施工実績ページの取得
- `fetch`: Google ビジネスプロフィールの口コミ数確認
- `fetch`: 採用ページの有無確認

**取得制限（Runtime §12.2 公開情報のみ）:**
```
許可: 公開 Web ページ（認証なし）
禁止: ログイン必須ページ
禁止: 個人情報取得を目的としたスクレイピング
取得できない場合: [仮定] と明記して続行
```

---

## 2. 統合 mcp-config.json（Phase 1 MVP 完全版）

`ai-agent/mcp-config.json` に配置する。

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-filesystem",
        "${REPO_ROOT}"
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

---

## 3. Phase 2 以降 — 追加予定 MCP サーバー

| サーバー | パッケージ / 実装 | 用途 | Phase |
|---|---|---|---|
| gmail | `@modelcontextprotocol/server-gmail` | 営業メール送信（承認済み文面のみ）| Phase 2 |
| google-sheets | community: `mcp-google-sheets` | Google Sheets を CRM 台帳として利用 | Phase 2 |
| google-calendar | community: `mcp-google-calendar` | Business Audit 予約管理 | Phase 3 |
| slack | `@modelcontextprotocol/server-slack` | Slack 承認通知（Gmail 代替）| Phase 2 opt |
| puppeteer | `@modelcontextprotocol/server-puppeteer` | JavaScript 動的サイトのスクレイピング | Phase 2 opt |

**Phase 2 で gmail MCP を追加する際の注意:**
- 承認済み文面のみ送信する制御をプロンプトレベルで徹底する
- 送信前に OWNER_APPROVAL_QUEUE.md の承認状態を必ず確認する
- 送信後は即座に SALES_LOG.md に記録する

---

## 4. MCP サーバーの動作確認方法

```bash
# filesystem の確認
echo "test" | npx @modelcontextprotocol/server-filesystem . 2>&1 | head -5

# brave-search の確認（1クエリ消費）
BRAVE_API_KEY=your-key npx @modelcontextprotocol/server-brave-search 2>&1 | head -5

# 全サーバー起動確認
./scripts/verify-setup.sh
```

---

## 5. トラブルシューティング

| 症状 | 原因 | 対処 |
|---|---|---|
| `command not found: npx` | Node.js 未インストール | `node -v` で確認。Node.js 18+ をインストール |
| `BRAVE_API_KEY not set` | 環境変数未設定 | `.env` を確認。`source .env` で読み込み |
| `GITHUB_PERSONAL_ACCESS_TOKEN` 権限エラー | PAT の権限不足 | GitHub → Settings → PAT で Contents 権限を確認 |
| fetch がタイムアウト | 企業サイトが低速 | タイムアウトを 15s に設定。`[仮定]` で続行 |
| brave-search が月次上限 | 2000クエリ超過 | 翌月まで待機。または有料プランへ移行 |

---

*MCP サーバーのバージョンアップ時は必ず動作確認を実施すること。*
*新しい MCP サーバーの追加は HQ 承認を経てから本書を更新する。*
