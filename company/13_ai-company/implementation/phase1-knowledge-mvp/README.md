# Knowledge AI MVP — Phase 1 起点ガイド

| 項目 | 内容 |
|---|---|
| 版 | v1.0 / 2026-07-09 |
| 対象 | Claude Code（Knowledge AI として動作する場合） |
| 準拠 | `company/13_ai-company/runtime/PHOSARA_AI_KNOWLEDGE_RUNTIME_v1.md` |
| 上位 | `company/13_ai-company/implementation/README.md`（Phase 0 共通基盤） |

---

## このディレクトリの目的

Knowledge AI が**Phase 1 MVP として実際に稼働するための最小実装セット**。

Sales AI / Client Success AI から届いた収穫データを受領・分類し、成功/失敗パターンの抽出・FAQ 更新案の起案・正典昇格の承認キュー管理までを Claude Code の手動実行で運用する。

---

## Phase 1 MVP スコープ

| # | ステップ | 担当 | 出力先 |
|---|---|---|---|
| KN-MVP-01 | Sales AI ハンドオフ受領・検証 | Claude Code | STATE / LOG |
| KN-MVP-02 | CS AI ハンドオフ受領・検証 | Claude Code | STATE / LOG |
| KN-MVP-03 | 知識分類（種別・区画の付与） | Claude Code | STATE / LOG |
| KN-MVP-04 | 成功パターン抽出（2 件以上の実例から） | Claude Code | assets/ / KNOWLEDGE_APPROVAL_QUEUE |
| KN-MVP-05 | 失敗パターン抽出（根因・再発防止の型化） | Claude Code | assets/ / KNOWLEDGE_APPROVAL_QUEUE |
| KN-MVP-06 | FAQ 更新案の起案 | Claude Code | KNOWLEDGE_APPROVAL_QUEUE |
| KN-MVP-07 | 正典昇格・文書改版案の承認キュー登録 | Claude Code | KNOWLEDGE_APPROVAL_QUEUE |
| KN-MVP-08 | 日次報告の生成 | Claude Code | DAILY_KNOWLEDGE_REPORT_TEMPLATE |

### Phase 1 でやらないこと

- Sales AI / CS AI からの自動同期（手動受領のみ）
- リポジトリへの自動書き込み・索引の自動付与
- n8n / MCP 連携
- CEO Daily Brief の自動生成
- Playbook / Business Audit の自動改版

---

## 日次運転（手動バッチ）

| タイミング | 内容 |
|---|---|
| **朝** | STATE 読込 → 前日受領分の分類キュー確定 → 正典昇格待ちの承認キュー整備 |
| **承認窓** | オーナーが `KNOWLEDGE_APPROVAL_QUEUE.md` を開き、昇格候補・改版案に承認 / 差戻しを追記 |
| **夕** | Daily Knowledge Report 生成 → LOG 確定 |
| **夜間** | Sales / CS からの同期受領（翌朝分類キューへ） → リポジトリ整合検査（索引・命名・置き場） |

**記帳原則:** すべての状態遷移は LOG に追記してから STATE を更新する（記帳なき遷移の禁止）。

---

## 読む順番（Claude Code 向け）

```
1. このファイル（README.md）          ← 現在地
2. KNOWLEDGE_MVP_WORKFLOW.md          ← ステップ別の処理手順
3. KNOWLEDGE_MVP_STATE.md             ← 知識アイテム台帳（唯一の正）
4. KNOWLEDGE_MVP_INPUT.md             ← 入力仕様（ハンドオフ書式・受領規則）
5. KNOWLEDGE_MVP_OUTPUT.md            ← 出力仕様（パターン・改版案・報告）
6. KNOWLEDGE_APPROVAL_QUEUE.md        ← 承認キュー（運用ファイル）
7. KNOWLEDGE_MVP_LOG.md               ← ランタイムログ（運用ファイル）
8. DAILY_KNOWLEDGE_REPORT_TEMPLATE.md ← 日次報告テンプレート
9. CONFLICT_LOG.md                    ← 仕様矛盾・未定義ログ
```

---

## Human Approval Policy（Knowledge MVP）

| 種別 | 承認要否 |
|---|---|
| 正典（canon）への昇格 | **必須（A）** |
| 既存文書（Playbook・監査キット・Skills・テンプレ）の改版 | **必須（A）** |
| 開示判定（機密 → 公開区画への移動） | **必須（A）** |
| 資産の退役（archive 移動）・棄却の確定 | **必須（A）** |
| 重複資産の統合（どちらを正とするか） | **必須（A）** |
| 知識の分類・索引付け・メモ層の整理 | 不要（Claude Code が自律実行） |
| 参照依頼への応答・実績台帳の記帳 | 不要（Claude Code が自律実行） |

**原文保全の原則:** 要約・抽出・匿名化のいかなる処理においても、原文への遡及リンクを保持する。原文を破壊する圧縮を禁ずる。

---

## 権限（Runtime 付録 C 継承）

**オーナー専権事項**（AI は起案・補佐までを行い、確定は人間が行う）:

正典昇格 / 文書改版の確定 / 開示判定 / 退役・棄却の確定 / 全社共通の専権 9 項（相談実施・スコア・優先課題・価格・契約・公開・悪い知らせの第一報・紹介依頼の対話）

**パターン化の最低根拠:** 実例 2 件以上（1 件の一般化を禁ずる）。

**緊急停止:** `EMERGENCY_STOP` ファイルがディレクトリに存在する間、全バッチは冒頭で即時終了する。

---

## 確信度（Confidence Score）モデル

| スコア | 処理 |
|---|---|
| 90〜100% | 推奨案として承認キューへ登録 |
| 70〜89% | 仮定を明示したうえで承認キューへ登録 |
| 70% 未満 | 承認キューへ提出せず再分析（2 回連続で同スコアなら人間相談・CONFLICT_LOG へ） |

---

## 知識アイテム 種別・区画定義

| 種別 | 区画 |
|---|---|
| 成功要因 / 失敗要因 | assets/ |
| 顧客の言葉（原文） | assets/（機密未確定は confidential/） |
| FAQ 候補 | assets/ |
| 再利用部品 / 文例 / 記入例 | assets/ |
| 矛盾記録 | CONFLICT_LOG.md |
| 機密（開示未確定） | confidential/（公開判定は人間） |
| 正典に未達のメモ | memo/ |
| 退役 | archive/ |

### リポジトリ 5 区画（Phase 1 ディレクトリ構造）

```
repository/
├── canon/          ← 正典（昇格は承認必須）
├── assets/         ← 収穫資産（部品・文例・記入例）
├── memo/           ← 正典 3 条件未達のメモ
├── confidential/   ← 機密（開示未確定・公開系への移動禁止）
└── archive/        ← 退役資産（削除しない）
```

区画間の移動はすべて LOG に記帳する。索引なき格納を完了と認めない。

### 格納ファイルの命名規約

`種別_内容要約_vX_X.md`（英語ファイル名・日本語本文・SemVer）

例: `success_pattern_initial_audit_v1_0.md`

---

## 依存関係

| 依存ファイル | 役割 |
|---|---|
| `../../runtime/PHOSARA_AI_KNOWLEDGE_RUNTIME_v1.md` | Knowledge AI の運転仕様（最上位準拠） |
| `../README.md` | Phase 0 共通基盤（状態機械・承認方針） |
| `../HUMAN_APPROVAL.md` | 全 AI 共通 Human Approval Policy |
| `../VERIFICATION.md` | 確信度モデル詳細 |
| `../STATE.md` | 会社共通 8 状態定義 |
| `company/12_knowledge/KNOWLEDGE_FINAL_REVIEW.md` | 知識品質の判定基準（正典） |
| `company/12_knowledge/PBOS_UPDATE_WORKFLOW.md` | PBOS 更新提案書式 |
| `company/04_sales/SALES_LOG_STANDARD.md` | ログ記録規程 |

---

## ファイル一覧

| ファイル | 種別 | 説明 |
|---|---|---|
| `README.md` | 起点 | このファイル |
| `KNOWLEDGE_MVP_WORKFLOW.md` | 手順書 | ステップ別フロー（KN-MVP-01〜08） |
| `KNOWLEDGE_MVP_STATE.md` | 台帳（運用） | 知識アイテム台帳（唯一の正） |
| `KNOWLEDGE_MVP_INPUT.md` | 入力仕様 | ハンドオフ書式・受領規則 |
| `KNOWLEDGE_MVP_OUTPUT.md` | 出力仕様 | パターン・改版案・報告の出力形式 |
| `KNOWLEDGE_APPROVAL_QUEUE.md` | キュー（運用） | 正典昇格・改版・開示の承認キュー |
| `KNOWLEDGE_MVP_LOG.md` | ログ（運用） | ランタイムログ（追記のみ） |
| `DAILY_KNOWLEDGE_REPORT_TEMPLATE.md` | テンプレート | 日次報告フォーマット |
| `CONFLICT_LOG.md` | 矛盾ログ（運用） | 仕様矛盾・未定義の記録 |
