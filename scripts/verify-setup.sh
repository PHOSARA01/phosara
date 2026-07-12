#!/usr/bin/env bash
# =============================================================================
# verify-setup.sh — PHOSARA AI Company セットアップ確認
#
# 用途: 環境構築完了後に実行し、全コンポーネントの動作を確認する
# =============================================================================

set -uo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

PASS=0
FAIL=0
WARN=0

ok()   { echo "  ✓ $1"; ((PASS++)) || true; }
fail() { echo "  ✗ $1"; ((FAIL++)) || true; }
warn() { echo "  ⚠ $1"; ((WARN++)) || true; }
header() { echo ""; echo "--- $1 ---"; }

echo ""
echo "============================================================"
echo " PHOSARA AI Company — セットアップ確認"
echo " 実行日時: $(date '+%Y-%m-%d %H:%M JST')"
echo " REPO_DIR: $REPO_DIR"
echo "============================================================"

# =====================================================================
# 1. 開発ツール
# =====================================================================

header "開発ツール"

if command -v git &>/dev/null; then
  GIT_VERSION="$(git --version | head -1)"
  ok "Git: $GIT_VERSION"
else
  fail "Git が見つかりません"
fi

if command -v node &>/dev/null; then
  NODE_VERSION="$(node -v)"
  ok "Node.js: $NODE_VERSION"
else
  fail "Node.js が見つかりません (https://nodejs.org/)"
fi

if command -v npm &>/dev/null; then
  NPM_VERSION="$(npm -v)"
  ok "npm: v$NPM_VERSION"
else
  fail "npm が見つかりません"
fi

if command -v claude &>/dev/null; then
  CLAUDE_VERSION="$(claude --version 2>/dev/null || echo '取得失敗')"
  ok "Claude Code: $CLAUDE_VERSION"
else
  fail "Claude Code が見つかりません (npm install -g @anthropic-ai/claude-code)"
fi

# =====================================================================
# 2. MCP サーバー
# =====================================================================

header "MCP サーバー"

LOCAL_NPM="$HOME/.local/npm-global"

check_mcp() {
  local bin_name="$1"
  local display="$2"
  local bin_path="$LOCAL_NPM/bin/$bin_name"
  if [ -f "$bin_path" ]; then
    ok "$display MCP: $bin_path"
  else
    warn "$display MCP: 未インストール (TMPDIR=/tmp npm_config_cache=/tmp/npm-fresh-cache npm install -g --prefix ~/.local/npm-global @modelcontextprotocol/server-$bin_name)"
  fi
}

check_mcp "mcp-server-filesystem" "filesystem"
check_mcp "mcp-server-github"     "github"
check_mcp "mcp-server-brave-search" "brave-search"
check_mcp "mcp-server-fetch"      "fetch"

# =====================================================================
# 3. 環境変数
# =====================================================================

header "環境変数"

ENV_FILE="$REPO_DIR/.env"
if [ -f "$ENV_FILE" ]; then
  ok ".env ファイル: 存在する"
  # shellcheck disable=SC1090
  set -a; source "$ENV_FILE" 2>/dev/null; set +a
else
  fail ".env ファイル: 存在しない"
  echo "     cp $REPO_DIR/.env.example $REPO_DIR/.env を実行して設定してください"
fi

check_var() {
  local var_name="$1"
  local display="$2"
  local value="${!var_name:-}"
  if [ -z "$value" ]; then
    fail "$display: 未設定 (.env に $var_name を設定してください)"
  elif echo "$value" | grep -qE "your-|your_|REPLACE_WITH|placeholder|xxx|your-key-here|your-token-here"; then
    fail "$display: プレースホルダーのまま（実際の値を .env に設定してください）"
  else
    ok "$display: 設定済み"
  fi
}

check_var "ANTHROPIC_API_KEY"           "ANTHROPIC_API_KEY"
check_var "GITHUB_PERSONAL_ACCESS_TOKEN" "GITHUB_PERSONAL_ACCESS_TOKEN"
check_var "BRAVE_SEARCH_API_KEY"        "BRAVE_SEARCH_API_KEY"

# =====================================================================
# 4. セキュリティ
# =====================================================================

header "セキュリティ"

if git -C "$REPO_DIR" check-ignore ".env" &>/dev/null 2>&1; then
  ok ".env は .gitignore に含まれています"
else
  if [ -f "$ENV_FILE" ]; then
    fail ".env が .gitignore に含まれていません（今すぐ追加してください）"
  else
    ok ".env は存在しないため gitignore 確認をスキップ"
  fi
fi

# =====================================================================
# 5. ディレクトリ構造
# =====================================================================

header "ディレクトリ構造 (ai-agent/)"

check_dir() {
  local path="$REPO_DIR/$1"
  if [ -d "$path" ]; then
    ok "$1/"
  else
    fail "$1/ が存在しません"
  fi
}

check_dir "ai-agent"
check_dir "ai-agent/prompts"
check_dir "ai-agent/state"
check_dir "ai-agent/queue"
check_dir "ai-agent/logs"
check_dir "n8n"
check_dir "n8n/workflows"

# =====================================================================
# 6. 必須ファイル
# =====================================================================

header "必須ファイル"

check_file() {
  local path="$REPO_DIR/$1"
  if [ -f "$path" ]; then
    ok "$1"
  else
    fail "$1 が存在しません"
  fi
}

check_file "ai-agent/CLAUDE.md"
check_file "ai-agent/mcp-config.json"
check_file "ai-agent/prompts/morning-task.md"
check_file "ai-agent/prompts/research.md"
check_file "ai-agent/prompts/ba-analysis.md"
check_file "ai-agent/prompts/message-gen.md"
check_file "ai-agent/prompts/self-review.md"
check_file "ai-agent/state/SALES_STATE.md"
check_file "ai-agent/queue/OWNER_APPROVAL_QUEUE.md"
check_file "ai-agent/logs/SALES_LOG.md"
check_file "ai-agent/logs/CONFLICT_LOG.md"
check_file "scripts/morning-batch.sh"
check_file "scripts/evening-batch.sh"
check_file ".env.example"

# スクリプトの実行権限確認
if [ -x "$REPO_DIR/scripts/morning-batch.sh" ]; then
  ok "scripts/morning-batch.sh: 実行権限あり"
else
  warn "scripts/morning-batch.sh: 実行権限なし (chmod +x scripts/morning-batch.sh)"
fi

if [ -x "$REPO_DIR/scripts/evening-batch.sh" ]; then
  ok "scripts/evening-batch.sh: 実行権限あり"
else
  warn "scripts/evening-batch.sh: 実行権限なし (chmod +x scripts/evening-batch.sh)"
fi

# =====================================================================
# 7. 既存資産（読み取り専用）
# =====================================================================

header "既存資産（読み取り専用・変更禁止）"

check_file "company/04_sales/SALES_TARGET_LIST_TOCHIGI_v1.md"
check_file "company/04_sales/SALES_EXECUTION_TOOLKIT.md"
check_file "company/04_sales/SALES_PLAYBOOK_v2.md"
check_file "company/13_ai-company/runtime/PHOSARA_AI_SALES_RUNTIME_v1.md"
check_file "company/13_ai-company/implementation/phase1-sales-mvp/SALES_MVP_WORKFLOW.md"

# =====================================================================
# 結果サマリー
# =====================================================================

echo ""
echo "============================================================"
echo " 確認結果"
echo "  ✓ 合格: $PASS 件"
echo "  ⚠ 警告: $WARN 件"
echo "  ✗ 失敗: $FAIL 件"
echo "============================================================"

if [ "$FAIL" -eq 0 ] && [ "$WARN" -eq 0 ]; then
  echo " 状態: 全項目 PASS — 本番稼働可能です"
  echo "============================================================"
  echo ""
  exit 0
elif [ "$FAIL" -eq 0 ]; then
  echo " 状態: 警告あり — 動作はしますが推奨設定を確認してください"
  echo "============================================================"
  echo ""
  exit 0
else
  echo " 状態: 失敗あり — 上記の ✗ 項目を修正してください"
  echo "============================================================"
  echo ""
  exit 1
fi
