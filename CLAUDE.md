# CLAUDE.md

このファイルはAIエージェントがこのリポジトリで作業する際の行動基準です。
Claude Code・Codex・Cursor・Gemini CLIなど、あらゆるAIエージェントに適用されます。
セッション開始時に必ず読み込み、全ての内部ルールより優先してください。

---

## プロジェクト概要

PHOSARAは、Business Auditを起点に、Design Consultingを経て、
Website・Branding・Portfolio・Communicationの最適なSolutionを設計する
クリエイティブブランドです。

このリポジトリはPHOSARAの公式資料・Webサイト設計・実装・運用を
一元管理するためのものです。

---

## 基準の優先順位（Priority Order）

判断・実装・提案のすべてにおいて、以下の優先順に従ってください。

```
1. オーナーの最新の指示（会話中の最新メッセージが最優先）
2. PHOSARA_MASTER_CONTEXT
3. PHOSARA_Brand_Book
4. PHOSARA_Website_Blueprint
5. PHOSARA_Website_Copy
6. PHOSARA_Website_Design_System
7. PHOSARA_Website_Technical_Guide
8. PHOSARA_Website_Operations_Guide
```

上位の基準が下位の基準と矛盾する場合は、常に上位を優先してください。
資料を独自に再解釈・再定義してはいけません。

---

## 判断に迷う場合のルール

**推測で作業を進めてはいけません。**

以下の場合は必ず作業を止め、オーナーに確認してください。

- 指示の意図が不明確なとき
- 資料間で内容が矛盾しているとき
- 複数の実装方針が考えられるとき
- 資料に記載がない要素の判断が必要なとき
- 想定外のファイル・設定・状態を発見したとき

確認する際は、「何が不明か」「どの選択肢があるか」を簡潔に伝えてください。

---

## ディレクトリ構成

```
company/               PHOSARA HQ 正典資産（経営・実行OS）← company/INDEX.md 参照
  00_constitution/     Constitution プレースホルダー（内容は 01_hq-core/ 内）
  01_hq-core/          HQ Core v1.0（全資産の根拠・最高優先）
  02_company-os/       Company OS v2.0 + STATE / WORKFLOW / AGENTS / SKILLS / VERIFICATION
  03_pbos/             PBOS（docs/08_PBOS/ とのコピー）
  04_revenue-agent/    60-Day Revenue Agent
  05_audit-kit/        Business Audit Kit v1.0（16ファイル）
  06_pricing/          Pricing Governance v1.0
  07_contracts/        Contract System v1.0
  08_execution-os/     Automation & Execution OS v1.0
  09_client-zero/      Client Zero 実行システム（最新: v1_0_1）
  10_skills/           全AI部署共通思考プロトコル
  99_archive/          廃止版（参照・使用禁止）

docs/                  公式資料
  00_ブランド基盤/      ブランド基盤資料
  01_営業/             営業資料
  02_コンサルティング/  コンサル資料
  03_業界別ソリューション/
  04_ケースブック/
  05_デザインシステム/  Webサイト設計書（最重要）
  08_PBOS/             PHOSARA PBOS（正規の場所）
  90_アーカイブ/        廃止資料（参照・使用禁止）

website/               公式サイト実装ディレクトリ
scripts/               自動化・補助スクリプト
```

---

## PHOSARA専用ルール

- ブランドの3原則（**可視化・越境・本質**）に反するUI・文言を実装しない
- PHOSARAのデザイン方向は「本質的・引き算」。装飾的要素を無断で追加しない
- コピー（文言）は必ず `PHOSARA_Website_Copy` から正確に引用する
- AIが独自にコピーを生成・改変してはいけない
- `docs/90_アーカイブ/` の資料は廃止済みのため参照・使用を禁止する

---

## 独自判断で変更してはいけない事項

以下はオーナーの明示的な指示・承認なしに変更してはいけません。

- 仕様・要件定義
- 情報設計（IA）・画面構成・ページ構成
- コンポーネントの命名・ファイル命名規則
- フォルダ構成・ディレクトリ構造
- 技術選定（言語・フレームワーク・ライブラリ・ツール）
- ブランドコピー・テキスト内容
- デザインシステムの定義値（カラー・タイポグラフィ・スペーシング等）

---

## 禁止事項

以下はオーナーの明示的な指示がない限り実行してはいけません。

- 設計資料の内容を独自に再定義・上書きすること
- `main` ブランチへの直接コミット
- `git push` / `git merge` / `git reset --hard` / `git push --force`
- 承認なしでのファイル削除
- `.env` などの機密ファイルのコミット
- 外部ライブラリ・フレームワークの無断追加
- 複数ファイルの同時変更（計画提示・承認が先）

---

## ファイル変更前の承認ルール

AIエージェントは以下のアクションを実行する前に、必ずオーナーに確認・承認を求めること。

| 対象 | ルール |
|---|---|
| `docs/` 配下のファイル | 変更前に目的・内容を説明 → 承認を得る → 変更する |
| `website/` 新規ファイル作成 | 作成前に内容を提示し承認を得る |
| `website/` 既存ファイル変更 | 変更内容をdiffで提示し承認を得る |
| `README.md` / `.gitignore` / `CLAUDE.md` | 変更前に承認を得る |
| `git push` / `git merge` / `git reset` | 実行前に確認を求める |
| 複数ファイルの同時変更 | 変更計画をリストで提示し承認を得る |
| 外部ライブラリの追加 | 追加前に理由と候補を提示し承認を得る |

---

## GitHub運用ルール

### ブランチ戦略

| ブランチ | 用途 |
|---|---|
| `main` | 本番・正式版 |
| `develop` | 開発統合 |
| `feature/*` | 機能追加・資料追加 |
| `fix/*` | 修正 |
| `archive/*` | 整理・移行 |

- `main` へのマージは必ずPull Request経由
- force push は原則禁止
- タグは正式リリース時のみ付与

### コミットメッセージ規則

```
docs:     資料追加・更新
site:     Webサイト実装
fix:      修正
style:    デザイン・CSS調整
refactor: 構造整理
chore:    管理作業
```

例：

```
docs: add website blueprint v1.1
site: add top page hero section
fix: correct navigation label
```

---

## Webサイト実装ルール

- 実装前に Blueprint → Copy → Design System の順で必ず3資料を確認する
- コピー（テキスト）は `Website_Copy` から正確に引用し、改変しない
- HTMLはセマンティクスを維持し、`div` の乱用を避ける
- レスポンシブ・アクセシビリティ・主要ブラウザ（Chrome/Safari/Firefox/Edge）対応を必須とする
- 実装後は設計資料との整合性をdiff確認してから報告する
- コードファイルは `website/` ディレクトリ内にのみ配置する

---

## コードコメントルール

- HTML・CSS・JavaScriptは、各セクションや主要処理にコメントを記述すること
- 可読性を優先し、他のAIエージェントや人間が理解しやすいコードを書くこと
- コメントは「何をしているか」ではなく「なぜそうしているか」を補足することを優先する
- セクションの区切りにはブロックコメントを使用し、構造を視覚的に明確にする

例（HTML）：
```html
<!-- ========================================
  Hero Section - ファーストビュー
  Blueprint Section 03 参照
======================================== -->
```

例（CSS）：
```css
/* ------------------------------------------
  Typography - 見出しシステム
  Design System Section 02 参照
------------------------------------------ */
```

例（JavaScript）：
```javascript
// ----------------------------------------
// Animation - スクロール連動フェードイン
// Design System Animation Rules 参照
// ----------------------------------------
```

---

## 実装完了時の報告ルール

作業完了時は必ず以下の項目を報告してください。

| 項目 | 内容 |
|---|---|
| **変更したファイル一覧** | 変更・作成・削除したファイルのパスをすべて列挙する |
| **変更内容** | 何をどのように変更したかを具体的に記述する |
| **変更理由** | なぜその変更が必要だったかを記述する |
| **設計資料との整合性** | どの資料のどの箇所に基づいて実装したかを明記する |
| **動作確認結果** | 確認した内容・環境・結果を記述する |
| **今後の推奨作業** | 次に行うべき作業・懸念点・改善提案があれば記述する |

---

## PHOSARA HQ 資産（company/ ディレクトリ）

AIエージェントが PHOSARA の経営・実行資産を参照する際のルール。

### 参照優先順位

| 優先 | パス | 内容 |
|------|------|------|
| 最高 | `company/01_hq-core/` | HQ Core — 全判断の根拠 |
| 高 | `company/02_company-os/` | Company OS v2.0 + 実行ファイル群 |
| 高 | `company/04_sales/` | 営業標準書 — `SALES_PLAYBOOK_v2.md` |
| 高 | `company/05_audit-kit/` | Business Audit Kit v1.0 |
| 中 | `company/08_execution-os/` | Automation & Execution OS |
| 中 | `company/09_client-zero/` | Client Zero 実行システム |
| 高 | `company/10_skills/` | 全AI部署共通思考プロトコル — `PHOSARA_META_THINKING_SYSTEM_v1_0.md` / Skills Library Vol.1 — `PHOSARA_SKILLS_LIBRARY_v1_VOLUME1_THINKING_AND_DECISION.md` |
| 参照 | `company/INDEX.md` | 全資産の索引（最初に確認） |

### ルール

- 資産の**改変は必ずオーナーの承認を得てから**行うこと
- `company/99_archive/` は廃止版。**参照・使用禁止**
- `company/00_constitution/` は Constitution 独立化のプレースホルダー。現在の内容は `company/01_hq-core/PHOSARA_HQ_CORE_v1_0.md` を参照
- PBOS の正規の場所は `docs/08_PBOS/PHOSARA_PBOS_Gold_Edition.md`。`company/03_pbos/` はコピー
- Client Zero の**最新版**は `company/09_client-zero/PHOSARA_CLIENT_ZERO_EXECUTION_v1_0_1.md`

---

## アーカイブルール

- 統合・廃止された資料は削除せず `docs/90_アーカイブ/` へ移動する
- 旧バージョンは `docs/99_旧バージョン/` へ移動する
- 移動時はコミットメッセージに `chore:` プレフィックスを使用する

---

## 現在のフェーズ

```
Phase: 公式サイト実装中 + PHOSARA HQ 基盤構築完了
完了済み:
  ✓ GitHubリポジトリ構成の整備
  ✓ CLAUDE.md整備・AIエージェント接続
  ✓ company/ ディレクトリ — HQ 正典資産の保存・構造化
  ✓ website/index.html — トップページ実装（Sprint 1）
  ✓ website/approach/   — /approach/ ページ実装（Sprint 2）
  ✓ website/services/   — /services/ ページ実装（Sprint 3）

進行中:
  - Formspree ID 取得・フォーム接続（要オーナー対応）
  - Sprint 4: /works/ ページ（Client Zero 実績）

次のフォーカス:
  1. Formspree フォームID取得 → index.html の REPLACE_WITH_FORM_ID を差し替え
  2. Sprint 4: /works/ ページ制作
```
