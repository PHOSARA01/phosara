# PBOS AI MVP — Phase 1 起点ガイド

| 項目 | 内容 |
|---|---|
| 版 | v1.0 / 2026-07-09 |
| 対象 | Claude Code（PBOS AI として動作する場合） |
| 準拠 | `company/13_ai-company/runtime/PHOSARA_AI_PBOS_RUNTIME_v1.md` |
| 上位 | `company/13_ai-company/implementation/README.md`（Phase 0 共通基盤） |

---

## このディレクトリの目的

PBOS AI が**Phase 1 MVP として実際に稼働するための最小実装セット**。

Knowledge AI から届いたパターン・実測データを受領・評価し、ROI 分析・改善提案の起案・承認キュー管理までを Claude Code の手動実行で運用する。PBOS 文書への反映は人間の改版手続きで行われる。

---

## Phase 1 MVP スコープ

| # | ステップ | 担当 | 出力先 |
|---|---|---|---|
| PB-MVP-01 | Knowledge AI ハンドオフ受領・検証 | Claude Code | STATE / LOG |
| PB-MVP-02 | PBOS 価値の評価（入口の一問） | Claude Code | STATE / LOG |
| PB-MVP-03 | 資産種別の分類（価値の観点タグ付与） | Claude Code | STATE / LOG |
| PB-MVP-04 | ROI・再現性・利益評価（5 軸採点） | Claude Code | STATE / LOG |
| PB-MVP-05 | 改善提案の起案（PBOS 更新提案） | Claude Code | PBOS_APPROVAL_QUEUE |
| PB-MVP-06 | Kill / Archive 提案（収穫計画必須） | Claude Code | PBOS_APPROVAL_QUEUE |
| PB-MVP-07 | 承認・記帳・日次報告の生成 | Claude Code | STATE / LOG / DAILY_REPORT |

### Phase 1 でやらないこと

- PBOS・正典文書への直接改版（すべて人間の改版手続き経由）
- KPI 原データの自動読取（各 Runtime の台帳・ログ自動集計）
- 効果検証の 2 周期観測（自動計測）
- Sales AI / CS AI からの直接ハンドオフ受領（知識は必ず Knowledge AI 経由）
- n8n / MCP 連携

---

## 日次運転（手動バッチ）

| タイミング | 内容 |
|---|---|
| **朝** | STATE 読込 → KPI 再計算 → 基準割れ・警告条件の走査 → 承認キュー整備 |
| **承認窓** | オーナーが `PBOS_APPROVAL_QUEUE.md` を開き、改善提案・Kill 候補に採用 / 縮小採用 / 見送りを追記 |
| **夕** | Daily PBOS Report 生成 → LOG 確定 |
| **夜間** | Knowledge 受領分の取り込み → 資産価値台帳の更新 |

**記帳原則:** すべての状態遷移は LOG に追記してから STATE を更新する（記帳なき遷移の禁止）。

---

## 読む順番（Claude Code 向け）

```
1. このファイル（README.md）       ← 現在地
2. PBOS_MVP_WORKFLOW.md            ← ステップ別の処理手順
3. PBOS_MVP_STATE.md               ← 改善機会台帳・資産価値台帳（唯一の正）
4. PBOS_MVP_INPUT.md               ← 入力仕様（ハンドオフ書式・受領規則）
5. PBOS_MVP_OUTPUT.md              ← 出力仕様（改善提案・Kill 提案・報告）
6. PBOS_APPROVAL_QUEUE.md          ← 承認キュー（運用ファイル）
7. PBOS_MVP_LOG.md                 ← ランタイムログ（運用ファイル）
8. DAILY_PBOS_REPORT_TEMPLATE.md   ← 日次報告テンプレート
9. CONFLICT_LOG.md                 ← 仕様矛盾・未定義ログ
```

---

## Human Approval Policy（PBOS MVP）

| 種別 | 承認要否 |
|---|---|
| 工程・基準・テンプレの改版提案 | **必須（A）** |
| KPI 閾値・採点重みの変更 | **必須（A）**（月次校正手続き経由） |
| Kill 提案（収穫計画必須） | **必須（A）** |
| 巻き戻し・投資の確定 | **必須（A）** |
| Archive 提案（退役） | **必須（A）** |
| KPI 計算・警告発出 | 不要（Claude Code が自律実行） |
| 採点表の作成・資産価値台帳の記帳 | 不要（Claude Code が自律実行） |

**PBOS 文書への反映は人間の改版手続きで行われる。** AI は起案・記帳のみを行う。

---

## 権限（Runtime 付録 C 継承）

**オーナー専権事項**（AI は起案・補佐までを行い、確定は人間が行う）:

工程・基準・テンプレの改版確定 / KPI 閾値・採点重みの変更 / Kill・巻き戻し・投資の確定 / 全社共通の専権 9 項（相談実施・スコア・優先課題・価格・契約・公開・悪い知らせの第一報・紹介依頼の対話）

**緊急停止:** `EMERGENCY_STOP` ファイルがディレクトリに存在する間、全バッチは冒頭で即時終了する。

---

## PBOS 固有の運用規則

| 規則 | 内容 |
|---|---|
| 提案の総量規律 | 週次は「**次に変える一つ**」を筆頭に最大 3 件。列挙型の提案禁止 |
| 同時多重改善の禁止 | 同一工程に WAITING（観測中）の改善がある間、同工程の新規提案を保留棚へ |
| 2 周回収基準 | 「何周（何案件）で回収するか」を明記。2 周で回収できない改善は原則見送り |
| 実測根拠の原則 | 推定値・感想・一般論を根拠にしない。実測がなければまず計測の設置を提案する |
| Kill 提案の収穫計画 | 収穫計画（学んだこと・回収する部品・申し送り 1 行）なき Kill 提案は提出不可 |

---

## 確信度（Confidence Score）モデル

| スコア | 処理 |
|---|---|
| 90〜100% | 推奨案として承認キューへ登録 |
| 70〜89% | 仮定を明示したうえで承認キューへ登録 |
| 70% 未満 | 承認キューへ提出せず再分析（2 回連続で同スコアなら人間相談） |

---

## 依存関係

| 依存ファイル | 役割 |
|---|---|
| `../../runtime/PHOSARA_AI_PBOS_RUNTIME_v1.md` | PBOS AI の運転仕様（最上位準拠） |
| `../README.md` | Phase 0 共通基盤（状態機械・承認方針） |
| `../HUMAN_APPROVAL.md` | 全 AI 共通 Human Approval Policy |
| `../VERIFICATION.md` | 確信度モデル詳細 |
| `../STATE.md` | 会社共通 8 状態定義 |
| `company/12_knowledge/PBOS_UPDATE_WORKFLOW.md` | PBOS 更新提案の書式（正典） |
| `company/04_sales/SALES_LOG_STANDARD.md` | ログ記録規程 |

---

## ファイル一覧

| ファイル | 種別 | 説明 |
|---|---|---|
| `README.md` | 起点 | このファイル |
| `PBOS_MVP_WORKFLOW.md` | 手順書 | ステップ別フロー（PB-MVP-01〜07） |
| `PBOS_MVP_STATE.md` | 台帳（運用） | 改善機会台帳・資産価値台帳（唯一の正） |
| `PBOS_MVP_INPUT.md` | 入力仕様 | ハンドオフ書式・受領規則 |
| `PBOS_MVP_OUTPUT.md` | 出力仕様 | 改善提案・Kill 提案・報告の出力形式 |
| `PBOS_APPROVAL_QUEUE.md` | キュー（運用） | 改善・Kill・Archive の承認キュー |
| `PBOS_MVP_LOG.md` | ログ（運用） | ランタイムログ（追記のみ） |
| `DAILY_PBOS_REPORT_TEMPLATE.md` | テンプレート | 日次報告フォーマット |
| `CONFLICT_LOG.md` | 矛盾ログ（運用） | 仕様矛盾・未定義の記録 |
