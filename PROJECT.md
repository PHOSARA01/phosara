# PROJECT.md

PHOSARAプロジェクトの現在状況・進捗・次のアクションを管理するドキュメントです。

このファイルはオーナーとAIエージェントが「今どこにいるか」を即座に把握するための「現在地図」です。作業が進むたびに更新してください。

**最終更新：2026-07-01**

---

## 他ドキュメントとの役割分担

| ファイル | 役割 |
|---|---|
| `README.md` | プロジェクト概要・構成説明（訪問者向け） |
| `CLAUDE.md` | AIエージェントの行動ルール・禁止事項 |
| `AGENTS.md` | 各エージェントの役割・連携プロトコル |
| `PROJECT.md` | 現在状況・進捗・次のアクション（このファイル） |

---

## 現在のフェーズ

**Phase 3 進行中：公式サイト実装（HTML・CSS・JavaScript）**

`website/` のベース実装（HTML・CSS・JavaScript）が完了。コミット・GitHub Push 待ち。

---

## マイルストーン

| フェーズ | 内容 | 状態 |
|---|---|---|
| Phase 1 | GitHubリポジトリ基盤整備 | 完了 |
| Phase 2 | 設計資料最終確定・AIエージェント運用整備 | 完了 |
| Phase 3 | 公式サイト実装（HTML・CSS・JavaScript） | 進行中 |
| Phase 4 | 公開・本番リリース | 未着手 |
| Phase 5 | 運用・改善・Agent Swarm拡張 | 未着手 |

---

## 完了済みタスク

### リポジトリ基盤

- [x] GitHubリポジトリ作成・初期設定
- [x] フォルダ構成の構築（`docs/` / `website/` / `scripts/`）
- [x] `.gitignore` の配置
- [x] `README.md` の作成・配置
- [x] `CLAUDE.md` の作成・コミット

### ドキュメント整理

- [x] `docs/90_アーカイブ/` への旧資料整理

### 資料アップロード

- [x] ブランド基盤資料（MASTER_CONTEXT・Brand Book・Wordmark Guidelines）
- [x] 営業資料（Sales Playbook・Proposal・Contract・Estimate・Hearing Sheet・Company Guide）
- [x] コンサルティング資料（Business Audit・Design Audit・Branding Audit・Website Audit）
- [x] 業界別ソリューション資料（建設業・クリニック・パチンコホール・リフォーム業）
- [x] ケースブック（Blueprint v1.2・Template v1.0）
- [x] Website Blueprint v1.1
- [x] Website Copy v1.1
- [x] Website Development Guide v1.0
- [x] Website Design System v2.0（コミット済み：c0aaee3）
- [x] Website Technical Guide v2.0（コミット済み：58ddd0f）

### website/ 実装（Phase 3）

- [x] `website/` ディレクトリ構成の構築
- [x] `vercel.json` 作成
- [x] `website/assets/css/tokens.css` 作成
- [x] `website/assets/css/base.css` 作成
- [x] `website/assets/css/layout.css` 作成
- [x] `website/assets/css/components.css` 作成
- [x] `website/assets/js/main.js` 作成
- [x] `website/assets/js/nav.js` 作成
- [x] `website/assets/js/animations.js` 作成
- [x] `website/index.html` 作成
- [x] `scripts/css-check.sh` 作成

---

## 進行中タスク

- [ ] `website/` 実装のコミット・GitHub Push

---

## 保留中タスク

- [ ] Website Operations Guide v2.0 の作成（未作成・保留中）
- [ ] `AGENTS.md` の作成（将来対応：複数AIエージェント導入時に作成）

---

## 次にやるべきこと（優先順位付き）

| 優先度 | タスク | 備考 |
|---|---|---|
| 1 | `website/` 実装コミット・Push | 統合レビュー完了済み |
| 2 | カラートークン確定（【確認A】） | `tokens.css` のHEX値を記入 |
| 3 | フォント確定（【確認B】） | `tokens.css` のフォント名を記入 |
| 4 | `favicon.ico` / `apple-touch-icon.png` 作成 | 【確認A】確定後に作成 |
| 5 | ナビに APPROACH / INDUSTRIES を追加 | 対応ページ作成と同時に対応 |
| 6 | about / approach / services / industries ページ実装 | Phase 3 後半 |
| 7 | `sitemap.xml` / `robots.txt` 作成 | Phase 4 直前 |
| 8 | `AGENTS.md` 作成（将来） | 複数AI導入のタイミングで対応 |

---

## ディレクトリ進捗状況

| ディレクトリ | 状態 | 備考 |
|---|---|---|
| `docs/00_ブランド基盤/` | 完了 | 主要資料アップロード済み |
| `docs/01_営業/` | 完了 | 全資料アップロード済み |
| `docs/02_コンサルティング/` | 完了 | 全資料アップロード済み |
| `docs/03_業界別ソリューション/` | 完了 | 4業界分アップロード済み |
| `docs/04_ケースブック/` | 完了 | Blueprint・Template済み |
| `docs/05_デザインシステム/` | 完了 | Design System v2.0・Technical Guide v2.0 コミット済み |
| `docs/90_アーカイブ/` | 完了 | 旧資料整理済み |
| `website/` | 進行中 | ベース実装完了・コミット待ち |
| `scripts/` | 進行中 | `css-check.sh` 作成済み |

---

## 設計資料の整備状況

| 資料 | バージョン | 状態 |
|---|---|---|
| Website Blueprint | v1.1 | 完了・コミット済み |
| Website Copy | v1.1 | 完了・コミット済み |
| Website Design System | v2.0 | 完了・コミット済み（c0aaee3） |
| Website Technical Guide | v2.0 | 完了・コミット済み（58ddd0f） |
| Website Operations Guide | v2.0 | 未作成（保留中） |

---

## 直近のコミット履歴

    58ddd0f  docs: add PHOSARA Website Technical Guide v2.0
    c0aaee3  docs: add PHOSARA Website Design System v2.0
    800b399  docs: finalize PHOSARA Visual System v2.0
    96b38fc  docs: add PROJECT.md
    f4ac845  docs: add CLAUDE.md and fix gitignore
    78792fb  Initial commit

---

## 現在の目標

### 短期目標（Phase 3 完了まで）

- `website/` 実装のコミット・GitHub Push
- カラートークン・フォントの確定（【確認A】・【確認B】）
- About / Approach / Services / Industries ページの実装

### 中期目標（Phase 4）

- PHOSARA公式サイトの本番リリース
- Blueprint・Copy・Design System に完全準拠したサイトの公開
- 問い合わせ導線（無料相談 → Business Audit）の稼働

### 長期目標（Phase 5 以降）

- 「価値を可視化するなら、PHOSARAへ」という市場認知の確立
- Agent Swarm（複数AIエージェント並列運用）による開発・運用の自動化
- 業界別ページの拡充・ケースブックの蓄積・継続的な改善サイクルの確立

---

## 更新ルール

- 作業完了時：完了タスクを `[ ]` から `[x]` に変更する
- 新タスク発生時：優先度をつけて「次にやるべきこと」に追記する
- フェーズ移行時：「現在のフェーズ」を更新する
- コミットメッセージ：`chore: update PROJECT.md`
- 最終更新日を必ず更新する

---

## 備考・メモ

- `docs/90_アーカイブ/` の資料は廃止済みのため参照・使用禁止
- カラートークン（【確認A】）・フォント（【確認B】）・アイコン（【確認C】）はオーナー確定待ち
- `favicon.ico` / `apple-touch-icon.png` はリンクタグのみ追加済み、実ファイルは【確認A】確定後に作成
- `AGENTS.md` は複数AIエージェント導入時に作成予定（現在保留）
