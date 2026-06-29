# PHOSARA

PHOSARAは、Business Auditを起点に、Design Consultingを経て、Website・Branding・Portfolio・Communicationなどの最適なSolutionを設計するクリエイティブブランドです。

このリポジトリは、PHOSARAの公式資料・Webサイト設計・実装・運用を一元管理するためのものです。

---

## Repository Purpose

このリポジトリの目的は以下です。

- PHOSARAの公式ドキュメントを管理する
- 公式サイト制作に必要な設計資料を管理する
- GitHubでバージョン管理を行う
- Claude Codeが参照しやすい構成にする
- AIエージェントによる開発・運用に対応する
- 将来的なWebサイト実装・運用・改善を支える

---

## Single Source of Truth

PHOSARA全体の最上位基準は以下です。

```text
PHOSARA_MASTER_CONTEXT
```

Website関連の正式資料は以下の5冊です。

```text
PHOSARA_Website_Blueprint_v1.1.md
PHOSARA_Website_Copy_v1.1.md
PHOSARA_Website_Design_System_v2.0.md
PHOSARA_Website_Technical_Guide_v2.0.md
PHOSARA_Website_Operations_Guide_v2.0.md
```

---

## Directory Overview

```text
docs/
  PHOSARA公式資料

website/
  公式サイト実装用ディレクトリ

website/prompts/
  Claude Code・AIエージェント用プロンプト

scripts/
  自動化・補助スクリプト
```

---

## Development Flow

```text
Documentation
↓
Website Blueprint
↓
Website Copy
↓
Design System
↓
Technical Guide
↓
GitHub
↓
Claude Code
↓
Implementation
↓
Review
↓
Release
↓
Improvement
```

---

## Git Branch Rule

```text
main        本番・正式版
develop     開発統合
feature/*   機能追加・資料追加
fix/*       修正
archive/*   整理・移行
```

---

## Commit Message Rule

```text
docs: 資料追加・更新
site: Webサイト実装
fix: 修正
style: デザイン・CSS調整
refactor: 構造整理
chore: 管理作業
```

例：

```text
docs: add website blueprint v1.1
docs: update website documentation architecture
site: add top page layout
fix: correct navigation label
```

---

## Claude Code Rule

Claude Codeは以下の資料を優先して参照します。

1. PHOSARA_Website_Blueprint
2. PHOSARA_Website_Copy
3. PHOSARA_Website_Design_System
4. PHOSARA_Website_Technical_Guide
5. PHOSARA_Website_Operations_Guide

Claude Codeは、これらの資料を勝手に再定義してはいけません。実装時は、資料の内容を基準としてコード化します。

---

## Archive Rule

統合・廃止された資料は削除せず、以下へ移動します。

```text
docs/90_archive/
```

旧バージョンは以下へ移動します。

```text
docs/99_old_versions/
```

---

## Current Phase

現在の優先作業は以下です。

```text
1. GitHubリポジトリ作成
2. フォルダ構成作成
3. 公式資料アップロード
4. README / .gitignore 配置
5. Claude Code接続準備
6. 公式サイト実装開始
```
