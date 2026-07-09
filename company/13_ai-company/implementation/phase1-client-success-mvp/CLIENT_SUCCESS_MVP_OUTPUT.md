# CLIENT_SUCCESS_MVP_OUTPUT — 出力仕様

版: v1.0 / 2026-07-04。**本MVPのすべての対外出力は「ドラフト」であり、承認と送信は人間が行う。**

## §1 文面ドラフト(承認キュー経由)

対象3種: 事前案内 / 前日リマインド / 当日朝リマインド。各ドラフトの必須構成:
1. 宛先・件名案
2. 本文全文(BUSINESS_AUDIT_COMMUNICATION_TEMPLATES準拠。ブランドボイス: 静か・明晰・誠実)
3. 三点セット(事実=予約と経緯の要約/選択肢=文面2案まで/推奨と理由)
4. 確信度%+根拠1行

## §2 日次報告

DAILY_CLIENT_SUCCESS_REPORT_TEMPLATE.mdに従う。提出先はCEOブリーフ素材フォルダ(Phase 1ではオーナーが直接読む)。

## §3 収穫出力(Knowledge向け・ファイル出力)

案件の節目ごとに5行書式で `harvest/` へ出力(Knowledge AIへの自動送出はPhase 2):

```
FROM/TO: Client Success AI → Knowledge AI
WHAT:    収穫一式(顧客の言葉の原文・効いた/効かなかった対応)
BASIS:   STATE該当行・LOG該当区間
STATUS:  開示可否は未確定(確定は人間の公開承認)
NEXT:    資産3条件の検査(期限つき)
```

## §4 育成返送(Sales AI向け)

キャンセル・見送りの顧客は、理由の原文+再接触時機を添えて5行書式で返送ファイルを出力する。

## 付録B — Future Implementation Notes
- §1の文面がテンプレとして連続3回無修正承認された場合、その型はR昇格審査の対象(審査材料は本MVPの承認ログがそのまま使える)
- §3/§4のファイル出力は、Knowledge/Sales Runtimeの受領トリガーにそのまま接続できる命名(`harvest/CS-任意ID.md`)とした
