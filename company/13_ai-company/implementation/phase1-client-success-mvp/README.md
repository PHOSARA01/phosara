# Client Success AI MVP — Phase 1 起点ガイド

| 項目 | 内容 |
|---|---|
| 版 | v1.0 / 2026-07-09 |
| 対象 | Claude Code（Client Success AI として動作する場合） |
| 準拠 | `company/13_ai-company/runtime/PHOSARA_AI_CLIENT_SUCCESS_RUNTIME_v1.md` |
| 上位 | `company/13_ai-company/implementation/README.md`（Phase 0 共通基盤） |

---

## このディレクトリの目的

Client Success AI が**Phase 1 MVP として実際に稼働するための最小実装セット**。

Sales AI から渡されたハンドオフを受領し、監査前コミュニケーション（事前案内・リマインド）の
ドラフト生成と承認キュー管理までを Claude Code の手動実行で運用する。

---

## Phase 1 MVP スコープ

| # | ステップ | 担当 | 出力先 |
|---|---|---|---|
| CS-MVP-01 | ハンドオフ受領・検証 | Claude Code | STATE / LOG |
| CS-MVP-02 | 予約検証（曜日整合・二重予約確認） | Claude Code | STATE / LOG |
| CS-MVP-03 | 事前案内のドラフト起案 | Claude Code | OWNER_APPROVAL_QUEUE |
| CS-MVP-04 | リマインド計画（前日・当日朝）の事前起案 | Claude Code | OWNER_APPROVAL_QUEUE / STATE |
| CS-MVP-05 | 承認受領・送信記帳の反映 | Claude Code | STATE / LOG |
| CS-MVP-06 | 監査完了確認・LEARNING 記帳 | Claude Code | STATE / LOG |
| CS-MVP-07 | フォローアップ起案（提案書・議事録） | Claude Code | OWNER_APPROVAL_QUEUE |
| CS-MVP-08 | 顧客満足確認ドラフト | Claude Code | OWNER_APPROVAL_QUEUE |
| CS-MVP-09 | 紹介依頼ドラフト（適格顧客のみ） | Claude Code | OWNER_APPROVAL_QUEUE |

### Phase 1 でやらないこと

- 顧客への自動送信（すべてオーナーが手動送信）
- 顧客からのメール・問い合わせ自動取込
- n8n / MCP 連携
- Sales AI・Knowledge AI との自動ハンドオフ
- CEO Daily Brief の自動生成

---

## 日次運転（手動バッチ）

| タイミング | 内容 |
|---|---|
| **朝** | STATE 読込 → 本日の期限（予約・リマインド）走査 → 起案 → 承認キュー更新 |
| **承認窓** | オーナーが `OWNER_APPROVAL_QUEUE.md` を開き、各項目に承認 / 差戻しを追記 → 承認済み文面を手動送信 → 送信済みを記帳 |
| **夕** | 日次報告の生成 → LOG 確定 |

**記帳原則:** すべての状態遷移は LOG に追記してから STATE を更新する（記帳なき遷移の禁止）。

---

## 読む順番（Claude Code 向け）

```
1. このファイル（README.md）     ← 現在地
2. CLIENT_SUCCESS_MVP_WORKFLOW.md ← ステップ別の処理手順
3. CLIENT_SUCCESS_MVP_STATE.md    ← 顧客状態台帳（唯一の正）
4. CLIENT_SUCCESS_MVP_INPUT.md    ← 入力仕様（ハンドオフ書式）
5. CLIENT_SUCCESS_MVP_OUTPUT.md   ← 出力仕様（ドラフト・報告）
6. OWNER_APPROVAL_QUEUE.md        ← 承認キュー（運用ファイル）
7. CLIENT_SUCCESS_MVP_LOG.md      ← ランタイムログ（運用ファイル）
8. DAILY_CLIENT_SUCCESS_REPORT_TEMPLATE.md ← 日次報告テンプレート
9. CONFLICT_LOG.md                ← 仕様矛盾・未定義ログ
```

---

## Human Approval Policy（CS MVP）

| 種別 | 承認要否 |
|---|---|
| 事前案内文面（新規・定型問わず全件） | **必須（A）** |
| リマインド文面（前日・当日朝） | **必須（A）** |
| フォローアップ起案 | **必須（A）** |
| 顧客満足確認・紹介依頼ドラフト | **必須（A）** |
| 例外相談・育成返送起案 | **必須（A）** |
| STATE / LOG の記帳（人間の操作反映） | 不要（Claude Code が自律記帳） |

**承認なしの文面送信は絶対禁止。**
承認された文面はオーナーが手動送信し、「送信済み」をキューに追記してから Claude Code が STATE / LOG へ反映する。

---

## 権限（Runtime 付録 C 継承）

**オーナー専権事項**（AI は起案・補佐までを行い、実行は人間が行う）:

相談実施 / スコア決定 / 優先課題の最終判断 / 価格・契約 / 公開判断 / 悪い知らせの第一報 / 紹介依頼の対話

**緊急停止:** `EMERGENCY_STOP` ファイルがディレクトリに存在する間、全バッチは冒頭で即時終了する。

---

## 確信度（Confidence Score）モデル

| スコア | 処理 |
|---|---|
| 90〜100% | 推奨案として承認キューへ登録 |
| 70〜89% | 仮定を明示したうえで承認キューへ登録 |
| 70% 未満 | 承認キューへ提出せず再分析（2 回連続で同スコアなら CONFLICT_LOG へ） |

---

## 依存関係

| 依存ファイル | 役割 |
|---|---|
| `../../runtime/PHOSARA_AI_CLIENT_SUCCESS_RUNTIME_v1.md` | CS AI の運転仕様（最上位準拠） |
| `../README.md` | Phase 0 共通基盤（状態機械・承認方針） |
| `../HUMAN_APPROVAL.md` | 全 AI 共通 Human Approval Policy |
| `../VERIFICATION.md` | 確信度モデル詳細 |
| `../STATE.md` | 会社共通 8 状態定義 |
| `company/11_client-success/BUSINESS_AUDIT_COMMUNICATION_TEMPLATES.md` | 文面テンプレート（ブランドボイス準拠） |
| `company/04_sales/SALES_LOG_STANDARD.md` | ログ記録規程 |

---

## ファイル一覧

| ファイル | 種別 | 説明 |
|---|---|---|
| `README.md` | 起点 | このファイル |
| `CLIENT_SUCCESS_MVP_WORKFLOW.md` | 手順書 | ステップ別フロー（CS-MVP-01〜13） |
| `CLIENT_SUCCESS_MVP_STATE.md` | 台帳（運用） | 顧客状態台帳（唯一の正） |
| `CLIENT_SUCCESS_MVP_INPUT.md` | 入力仕様 | ハンドオフ書式・受領規則 |
| `CLIENT_SUCCESS_MVP_OUTPUT.md` | 出力仕様 | ドラフト・報告・収穫の出力形式 |
| `OWNER_APPROVAL_QUEUE.md` | キュー（運用） | オーナー承認キュー |
| `CLIENT_SUCCESS_MVP_LOG.md` | ログ（運用） | ランタイムログ（追記のみ） |
| `DAILY_CLIENT_SUCCESS_REPORT_TEMPLATE.md` | テンプレート | 日次報告フォーマット |
| `CONFLICT_LOG.md` | 矛盾ログ（運用） | 仕様矛盾・未定義の記録 |
