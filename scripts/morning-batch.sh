#!/usr/bin/env bash
# =============================================================================
# morning-batch.sh — TRG-01 DAILY_MORNING
# PHOSARA AI Sales Agent 朝バッチ
#
# 用途: 毎朝 09:00 に n8n から呼び出される
# 処理: Claude Code を Sales Agent として起動し、1社の営業文を生成して承認キューへ登録する
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
  # .env をシェルに読み込む（コメント行・空行を除外）
  set -a
  # shellcheck disable=SC1090
  source "$ENV_FILE"
  set +a
else
  echo "ERROR: .env ファイルが見つかりません: $ENV_FILE" >&2
  echo "  cp $REPO_DIR/.env.example $REPO_DIR/.env を実行して設定してください" >&2
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
check_env "GITHUB_PERSONAL_ACCESS_TOKEN"
check_env "BRAVE_SEARCH_API_KEY"

# --- ログディレクトリの確認 ---
mkdir -p "$LOG_DIR"

# --- 実行時 mcp-config.json の生成 ---
# テンプレートの __REPO_ROOT__ を実際のパスで差し替える
MCP_CONFIG_RUNTIME="$AGENT_DIR/mcp-config.runtime.json"
sed \
  -e "s|__REPO_ROOT__|$REPO_DIR|g" \
  -e "s|__GITHUB_PERSONAL_ACCESS_TOKEN__|$GITHUB_PERSONAL_ACCESS_TOKEN|g" \
  -e "s|__BRAVE_SEARCH_API_KEY__|$BRAVE_SEARCH_API_KEY|g" \
  "$AGENT_DIR/mcp-config.json" > "$MCP_CONFIG_RUNTIME"

# --- 開始ログ ---
{
  echo ""
  echo "============================================================"
  echo " PHOSARA AI Sales Agent — 朝バッチ開始"
  echo " 実行日時: $BATCH_DATETIME"
  echo " REPO_DIR: $REPO_DIR"
  echo "============================================================"
} >> "$LOG_FILE"

echo "[morning-batch] 開始: $BATCH_DATETIME"

# --- Claude Code の実行 ---
TASK_PROMPT_FILE="$AGENT_DIR/prompts/morning-task.md"

if [ ! -f "$TASK_PROMPT_FILE" ]; then
  echo "ERROR: タスクプロンプトが見つかりません: $TASK_PROMPT_FILE" >&2
  exit 1
fi

# Claude Code を Sales Agent として実行
# --print: 非インタラクティブモード
# --mcp-config: MCP サーバー設定（実行時生成版）
# --allowedTools: 許可するツール
CLAUDE_EXIT_CODE=0
claude \
  --print \
  --mcp-config "$MCP_CONFIG_RUNTIME" \
  --allowedTools "mcp__filesystem__read_file,mcp__filesystem__write_file,mcp__filesystem__list_directory,mcp__github__get_file_contents,mcp__github__create_or_update_file,mcp__brave-search__brave_web_search,mcp__fetch__fetch" \
  "$(cat "$TASK_PROMPT_FILE")" \
  >> "$LOG_FILE" 2>&1 || CLAUDE_EXIT_CODE=$?

# --- 終了処理 ---
{
  echo ""
  echo "============================================================"
  echo " 朝バッチ終了"
  echo " 終了日時: $(date '+%Y-%m-%d %H:%M JST')"
  echo " Claude 終了コード: $CLAUDE_EXIT_CODE"
  echo "============================================================"
} >> "$LOG_FILE"

# --- 実行時 mcp-config の削除（シークレットを含むため）---
rm -f "$MCP_CONFIG_RUNTIME"

# --- 終了コードの返却 ---
if [ "$CLAUDE_EXIT_CODE" -ne 0 ]; then
  echo "[morning-batch] 失敗: Claude Code が終了コード $CLAUDE_EXIT_CODE を返しました"
  echo "  詳細は $LOG_FILE を確認してください"
  exit 1
fi

echo "[morning-batch] 完了: $(date '+%Y-%m-%d %H:%M JST')"
echo "  承認キュー: $AGENT_DIR/queue/OWNER_APPROVAL_QUEUE.md"
echo "  ログ: $LOG_FILE"
exit 0
