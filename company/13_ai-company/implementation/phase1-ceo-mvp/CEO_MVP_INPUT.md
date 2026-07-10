# CEO_MVP_INPUT — 入力仕様

版: v1.0 / 2026-07-10

---

## §1 Sales AI 日次報告（TRG-01）

- 受領元: `phase1-sales-mvp/DAILY_SALES_REPORT_TEMPLATE.md` 形式
- 受領タイミング: 夕バッチ提出分（翌朝の CEO Brief に統合）
- 受領検証 3 点:
  - ①共通 7 要素書式の完全性（結論 / 証拠 / 優先度 / リスク / 次の一手 / 固有欄 / やらないこと）
  - ②固有欄の充足（接触件数 / 承認待ち件数 / 商談件数 / 成約件数）
  - ③前日報告との整合（件数の不連続・未記載状態の継続がないか）
- 欠落時: 当夜に Sales AI へ確認 1 回 → 朝までに未達なら「Sales 報告：欠落」と明示してブリーフ発行

## §2 Client Success AI 日次報告（TRG-02）

- 受領元: `phase1-client-success-mvp/DAILY_CLIENT_SUCCESS_REPORT_TEMPLATE.md` 形式
- 受領検証 3 点: §1 と同一（固有欄は CS 固有）
  - ②固有欄: 顧客温度分布 / 約束履行状況 / 紹介の芽 / 解約リスク
- 欠落時: §1 と同手順

## §3 Knowledge AI 日次報告（TRG-03）

- 受領元: `phase1-knowledge-mvp/DAILY_KNOWLEDGE_REPORT_TEMPLATE.md` 形式
- 受領検証 3 点: §1 と同一（固有欄は Knowledge 固有）
  - ②固有欄: 受領件数 / 昇格待ち件数 / 矛盾検出件数 / FAQ 更新案件数
- 欠落時: §1 と同手順

## §4 PBOS AI 日次報告（TRG-04）

- 受領元: `phase1-pbos-mvp/DAILY_PBOS_REPORT_TEMPLATE.md` 形式
- 受領検証 3 点: §1 と同一（固有欄は PBOS 固有）
  - ②固有欄: 受領評価件数 / 承認待ち件数 / 採点分布 / 週次「次に変える一つ」候補（金曜）
- 欠落時: §1 と同手順
- **KPI 算出値を含む**: 計器盤 4 指標の確定値。CEO AI はこの値を経営文脈化するが再計算しない

## §5 オーナー（承認・指示）（TRG-05）

- 承認 / 差戻し: `CEO_APPROVAL_QUEUE.md` への追記のみを正とする
- 戦略方針の変更・臨時指示: オーナーが `CEO_APPROVAL_QUEUE.md` に「OWNER_REQUEST」として登録（5 行書式・FROM=Owner）
- 緊急指示（P0）: 上記に加えて口頭または直接 LOG への記帳で受理する（記帳は CEO AI が代行）

## §6 受領しないもの（Phase 1）

- 各 AI の STATE / LOG の自動読取（KPI 算出自動化）はPhase 2
- Sales AI / CS AI から Knowledge AI を経由しない直接ハンドオフは受理しない
- 財務・銀行データの直接連携は Phase 2
- n8n / MCP からの自動受信は Phase 2

## 付録 B — Future Implementation Notes

- Phase 2 で 4 報告の自動受信（n8n）を追加する際も、受領検証 3 点と受領確認の記帳義務は不変
- 報告書式の改版（固有欄の追加等）は各 MVP が行い、本ファイルに参照行を追記する
