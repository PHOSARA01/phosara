# PROJECT.md

PHOSARAプロジェクトの現在状況・進捗・次のアクションを管理するドキュメントです。

このファイルはオーナーとAIエージェントが「今どこにいるか」を
即座に把握するための「現在地図」です。
作業が進むたびに更新してください。

**最終更新：2026-06-30**

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

```
Phase 2 後半：設計資料最終確定 ＋ AIエージェント運用整備
```

GitHubリポジトリ基盤は完成。
設計資料（Design System v2・Technical Guide v2・Operations Guide v2）の
最終アップロードとAIエージェント運用基盤の整備が進行中。

---

## マイルストーン

| フェーズ | 内容 | 状態 |
|---|---|---|
| Phase 1 | GitHubリポジトリ基盤整備 | 完了 |
| Phase 2 | 設計資料最終確定・AIエージェント運用整備 | 進行中 |
| Phase 3 | 公式サイト実装（HTML・CSS・JavaScript） | 未着手 |
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

---

## 進行中タスク

- [ ] Website Design System v2.0 の最終確定・アップロード
- [ ] Website Technical Guide v2.0 の最終確定・アップロード
- [ ] Website Operations Guide v2.0 の最終確定・アップロード

---

## 保留中タスク

- [ ] `AGENTS.md` の作成
  - 理由：Cursor・Codexなど複数AIエージェント導入時に作成する

---

## 次にやるべきこと（優先順位付き）

| 優先度 | タスク | 備考 |
|---|---|---|
| 1 | `PROJECT.md` 作成 | このファイル・承認後に作成 |
| 2 | Website Design System v2.0 アップロード | 実装前に必要 |
| 3 | Website Technical Guide v2.0 アップロード | 実装前に必要 |
| 4 | Website Operations Guide v2.0 アップロード | 実装前に必要 |
| 5 | 公式サイト実装開始（Phase 3 着手） | 上記完了後 |
| 6 | `AGENTS.md` 作成（将来） | 複数AI導入のタイミングで対応 |

---

## ディレクトリ進捗状況

| ディレクトリ | 状態 | 備考 |
|---|---|---|
| `docs/00_ブランド基盤/` | 完了 | 主要資料アップロード済み |
| `docs/01_営業/` | 完了 | 全資料アップロード済み |
| `docs/02_コンサルティング/` | 完了 | 全資料アップロード済み |
| `docs/03_業界別ソリューション/` | 完了 | 4業界分アップロード済み |
| `docs/04_ケースブック/` | 完了 | Blueprint・Template済み |
| `docs/05_デザインシステム/` | 進行中 | Design System v2・Technical Guide v2・Operations Guide v2 が未アップロード |
| `docs/90_アーカイブ/` | 完了 | 旧資料整理済み |
| `website/` | 未着手 | Phase 3 で実装開始 |
| `scripts/` | 未着手 | Phase 4〜5 で自動化追加 |

---

## 設計資料の整備状況

Website実装に必要な5冊の正式資料の状態です。

| 資料 | バージョン | 状態 |
|---|---|---|
| Website Blueprint | v1.1 | 完了・アップロード済み |
| Website Copy | v1.1 | 完了・アップロード済み |
| Website Design System | v2.0 | 未アップロード（最終確定待ち） |
| Website Technical Guide | v2.0 | 未アップロード（最終確定待ち） |
| Website Operations Guide | v2.0 | 未アップロード（最終確定待ち） |

---

## 直近のコミット履歴

```
f4ac845  docs: add CLAUDE.md and fix gitignore
78792fb  Initial commit
```

---

## 現在の目標

### 短期目標（Phase 2 完了まで）

- 設計資料5冊の最終確定・GitHubへのアップロード完了
- `PROJECT.md` の運用開始
- AIエージェント（Claude Code）による作業フローの安定化

### 中期目標（Phase 3〜4）

- PHOSARA公式サイトの実装・本番リリース
- Blueprint・Copy・Design Systemに完全準拠したサイトの公開
- 問い合わせ導線（無料相談 → Business Audit）の稼働

### 長期目標（Phase 5 以降）

- 「価値を可視化するなら、PHOSARAへ」という市場認知の確立
- Agent Swarm（複数AIエージェント並列運用）による開発・運用の自動化
- 業界別ページの拡充・ケースブックの蓄積・継続的な改善サイクルの確立

---

## 更新ルール

- 作業完了時：完了タスクを `- [ ]` から `- [x]` に変更する
- 新タスク発生時：優先度をつけて「次にやるべきこと」に追記する
- フェーズ移行時：「現在のフェーズ」を更新する
- コミットメッセージ：`chore: update PROJECT.md`
- 最終更新日を必ず更新する

---

## 備考・メモ

- `docs/90_アーカイブ/` の資料は廃止済みのため参照・使用禁止
- `website/` と `scripts/` は現在空（Phase 3 以降で使用）
- `AGENTS.md` は複数AIエージェント導入時に作成予定（現在保留）
