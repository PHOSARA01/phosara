#!/usr/bin/env bash
# scripts/css-check.sh  PHOSARA CSS構文チェッカー
# 使い方: ./scripts/css-check.sh <ファイル> [セレクター...]

set -euo pipefail

G='\033[0;32m'; R='\033[0;31m'; Y='\033[0;33m'; E='\033[0m'
ok()   { echo -e "${G}[OK]${E} $1"; }
fail() { echo -e "${R}[NG]${E} $1"; }

if [ $# -lt 1 ]; then
  echo "使い方: $0 <CSSファイル> [セレクター...]"
  exit 1
fi

FILE="$1"; shift
SELS=("$@")
ALL=true

echo ""
echo -e "${Y}---${E} $FILE"
echo "=================================="

if [ ! -f "$FILE" ]; then
  fail "ファイルが存在しません"
  echo ""; exit 1
fi

LINES=$(wc -l < "$FILE" | tr -d ' ')
ok "ファイル存在 (${LINES}行)"

OB=$(grep -o '{' "$FILE" | wc -l | tr -d ' ')
CB=$(grep -o '}' "$FILE" | wc -l | tr -d ' ')
if [ "$OB" -eq "$CB" ]; then
  ok "{ } 一致 (各${OB}個)"
else
  fail "{ } 不一致 ({=${OB} }=${CB})"
  ALL=false
fi

OC=$(grep -o '/\*' "$FILE" | wc -l | tr -d ' ')
CC=$(grep -o '\*/' "$FILE" | wc -l | tr -d ' ')
if [ "$OC" -eq "$CC" ]; then
  ok "/* */ 一致 (各${OC}個)"
else
  fail "/* */ 不一致 (/*=${OC} */=${CC})"
  ALL=false
fi

if [ ${#SELS[@]} -gt 0 ]; then
  echo "----------------------------------"
  for S in "${SELS[@]}"; do
    P=$(echo "$S" | sed 's/\./\\./g; s/:/\\:/g')
    if grep -q "$P" "$FILE"; then
      ok "$S"
    else
      fail "$S (未定義)"
      ALL=false
    fi
  done
fi

echo "=================================="
if [ "$ALL" = true ]; then
  echo -e "${G}結果: 全項目パス${E}"; echo ""; exit 0
else
  echo -e "${R}結果: 問題あり${E}"; echo ""; exit 1
fi
