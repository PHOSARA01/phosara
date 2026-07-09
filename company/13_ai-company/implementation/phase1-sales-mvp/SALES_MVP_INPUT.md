# SALES_MVP_INPUT.md — Sales AI MVP 入力定義

| 項目 | 内容 |
|---|---|
| 目的 | Claude Code が Sales AI MVP を起動する際に読み込むべきファイル・情報を定義する |
| 参照タイミング | 毎回の MVP 実行開始時（Step 1 の前） |

---

## 必須入力（毎回読み込む）

| 優先度 | ファイル / 情報 | 内容 | 読み込む理由 |
|---|---|---|---|
| **最高** | `company/13_ai-company/PHOSARA_AI_COMPANY_OS_v1.md` | AI企業憲法・承認方針・状態機械 | 行動基準の最上位 |
| **高** | `company/13_ai-company/runtime/PHOSARA_AI_SALES_RUNTIME_v1.md` | 運転仕様（フロー・状態・イベント処理） | Sales AI の正典 |
| **高** | `company/04_sales/SALES_TARGET_LIST_TOCHIGI_v1.md` | 栃木県営業対象リスト v1.0 | 候補企業のデータソース |
| **高** | `company/04_sales/SALES_EXECUTION_TOOLKIT.md` | 営業文の型・CTA・実行原則 | 営業文生成の基準 |
| **高** | `company/13_ai-company/implementation/phase1-sales-mvp/SALES_MVP_LOG.md` | Sales Log（累積） | 既接触企業の確認・重複防止 |
| **高** | `company/13_ai-company/implementation/phase1-sales-mvp/OWNER_APPROVAL_QUEUE.md` | 現在の承認キュー | 既に承認待ちの企業を確認 |
| **中** | `company/04_sales/SALES_LOG_STANDARD.md` | Log書式の正典 | ログ記録の書式確認 |
| **参照** | `company/04_sales/FIRST_SALES_TARGET_DECISION.md` | 初回営業先決定ガイド | 優先順位判断の参考 |

---

## セッション開始時のチェックリスト

Claude Code は MVP 実行前に以下を確認する。

```
□ SALES_TARGET_LIST_TOCHIGI_v1.md を読み込んだか
□ OWNER_APPROVAL_QUEUE.md を確認し、現在 WAITING_APPROVAL 中の企業を把握したか
□ SALES_MVP_LOG.md を確認し、接触済み・差戻し済み企業を把握したか
□ SALES_EXECUTION_TOOLKIT.md を確認し、営業文の型を把握したか
□ 起動トリガーを確認したか（オーナー指示 / TRG-01 日次）
```

---

## 起動トリガー（Input として扱う情報）

| トリガー種別 | 内容 | 優先度 |
|---|---|---|
| **TRG-10（オーナー要請）** | オーナーからの明示的な指示 | 最高（即時実行） |
| **TRG-01（DAILY_MORNING）** | 日次朝バッチ（始業前の自動実行） | 高（定期実行） |
| **TRG-06（差戻し後の再実行）** | 差戻しを受けた後の再起動 | 高（差戻し理由をインプットに含める） |

---

## 入力データの品質基準

| データ | 品質基準 |
|---|---|
| SALES_TARGET_LIST のターゲット情報 | 作成日（2026-07-08）時点の情報。古い情報は[要確認]と明記 |
| Web調査情報（Step 4） | 公開情報のみ。取得できない情報は[仮定]と明記 |
| 差戻し理由（再実行時） | `SALES_MVP_LOG.md` の差戻し記録を必ず読み込む |

---

## 入力が不足・矛盾している場合

| 状況 | 対処 |
|---|---|
| SALES_TARGET_LIST が読み込めない | 作業停止 → E4（オーナーへ直行） |
| リスト内の対象企業が全て接触済み | TRG-09（LIST_LOW）を発火 → リスト補充の起案をE3でCEO AIへ |
| SALES_EXECUTION_TOOLKIT が読み込めない | 作業停止 → `CONFLICT_LOG.md` に記録 → オーナー報告 |
| 正典間で矛盾を発見 | `CONFLICT_LOG.md` に記録 → 上位文書を暫定適用 |

---

## 参照（出力の受け取り先）

このファイルは入力定義のみ。出力の形式は `SALES_MVP_OUTPUT.md` を参照。
