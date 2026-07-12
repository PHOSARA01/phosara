#!/usr/bin/env bash
# =============================================================================
# evening-batch.sh — TRG-02 DAILY_EVENING
# PHOSARA AI Sales Agent 夕バッチ
#
# 用途: 毎夕 18:00 に n8n から呼び出される
# 処理: 当日の SALES_LOG から日次レポートを生成し、DAILY_SALES_REPORT を更新する
# =============================================================================

set -euo pipefail

# --- パス設定 ---
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
AGENT_DIR="$REPO_DIR/ai-agent"
LOG_DIR="$AGENT_DIR/logs"
BATCH_DATE="$(date +%Y%m%d)"
BATCH_DATETIME="$(date '+%Y-%m-%d %H:%M JST')"
LOG_FILE="$LOG_DIR/batch-$BATCH_DATE.log"

# --- 環境変数の読み込み ---
ENV_FILE="$REPO_DIR/.env"
if [ -f "$ENV_FILE" ]; then
  set -a
  # shellcheck disable=SC1090
  source "$ENV_FILE"
  set +a
else
  echo "ERROR: .env ファイルが見つかりません: $ENV_FILE" >&2
  exit 1
fi

# --- 必須環境変数のチェック ---
check_env() {
  local var_name="$1"
  if [ -z "${!var_name:-}" ]; then
    echo "ERROR: 環境変数 $var_name が設定されていません" >&2
    exit 1
  fi
}

check_env "ANTHROPIC_API_KEY"

# --- ログディレクトリの確認 ---
mkdir -p "$LOG_DIR"

# --- 実行時 mcp-config.json の生成 ---
MCP_CONFIG_RUNTIME="$AGENT_DIR/mcp-config.runtime.json"
sed \
  -e "s|__REPO_ROOT__|$REPO_DIR|g" \
  -e "s|__GITHUB_PERSONAL_ACCESS_TOKEN__|${GITHUB_PERSONAL_ACCESS_TOKEN:-}|g" \
  -e "s|__BRAVE_SEARCH_API_KEY__|${BRAVE_SEARCH_API_KEY:-}|g" \
  "$AGENT_DIR/mcp-config.json" > "$MCP_CONFIG_RUNTIME"

# --- 開始ログ ---
{
  echo ""
  echo "============================================================"
  echo " PHOSARA AI Sales Agent — 夕バッチ開始"
  echo " 実行日時: $BATCH_DATETIME"
  echo "============================================================"
} >> "$LOG_FILE"

echo "[evening-batch] 開始: $BATCH_DATETIME"

# --- 日次レポート生成プロンプト ---
EVENING_PROMPT="$(cat << 'EOF'
あなたは PHOSARA AI Sales Agent です。
本日（今日の日付）の SALES_LOG.md を読み込み、日次サマリーレポートを生成してください。

## 読み込むファイル
- ai-agent/logs/SALES_LOG.md

## 出力する内容
1. 本日の処理件数（ANALYZING → WAITING_APPROVAL になった件数）
2. 現在 WAITING_APPROVAL のターゲット（エントリID・会社名・承認期限）
3. エラー・CONFLICT が発生したか（あれば内容）
4. 明日の推奨アクション（オーナーへの提案）

## 出力先
ai-agent/logs/SALES_LOG.md の末尾に以下を追記してください:

---
## 日次サマリー YYYY-MM-DD

| 項目 | 値 |
|---|---|
| 処理件数 | [N]社 |
| 承認待ち | [N]件 |
| エラー | [N]件 |
| 生成日時 | YYYY-MM-DD HH:MM JST |

### 明日の推奨アクション
[内容]
EOF
)"

# Claude Code 実行（filesystem MCP のみ使用）
CLAUDE_EXIT_CODE=0
claude \
  --print \
  --mcp-config "$MCP_CONFIG_RUNTIME" \
  --allowedTools "mcp__filesystem__read_file,mcp__filesystem__write_file" \
  "$EVENING_PROMPT" \
  >> "$LOG_FILE" 2>&1 || CLAUDE_EXIT_CODE=$?

# --- 終了処理 ---
{
  echo ""
  echo " 夕バッチ終了: $(date '+%Y-%m-%d %H:%M JST')"
  echo " Claude 終了コード: $CLAUDE_EXIT_CODE"
  echo "============================================================"
} >> "$LOG_FILE"

# 実行時 mcp-config の削除
rm -f "$MCP_CONFIG_RUNTIME"

if [ "$CLAUDE_EXIT_CODE" -ne 0 ]; then
  echo "[evening-batch] 失敗: 終了コード $CLAUDE_EXIT_CODE"
  exit 1
fi

echo "[evening-batch] 完了: $(date '+%Y-%m-%d %H:%M JST')"
exit 0
