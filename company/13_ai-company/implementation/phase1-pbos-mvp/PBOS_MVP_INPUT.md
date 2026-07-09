# PBOS_MVP_INPUT — 入力仕様

版: v1.0 / 2026-07-04

## §1 Knowledge AIハンドオフ(唯一の新規機会入口)

Knowledge MVPの `pbos_handoff/` 出力(5行書式)を朝バッチで走査・取込する:

```
FROM/TO: Knowledge AI → PBOS AI
WHAT:    パターン候補(根拠実例2件以上)+実測への遡及リンク
BASIS:   リポジトリ該当ファイル・STATE該当行
STATUS:  パターンは候補であり、改善提案の起票判断はPBOS AI
NEXT:    ROI分析・機会採点(期限つき)
```

受領検証3点: ①5行の完全性 ②根拠実例2件以上 ③実測遡及リンクの生存。

## §2 人間(オーナー)の記帳

- 承認/縮小採用/見送り: PBOS_APPROVAL_QUEUE.mdへの追記のみを正とする
- 採点依頼: オーナーが機会採点を依頼する場合も5行書式(FROM=Owner)で登録する(裏口の禁止)
- KPI閾値・採点重みの変更: 本MVPは受理しない(月次校正・正典改版の手続きへ案内する)

## §3 受領しないもの(Phase 1)

各MVPのSTATE/LOGの自動読取(KPI算出)はPhase 2。Sales/CSからの直接ハンドオフは受理しない(**知識は必ずKnowledge AIを経由する**——層を飛ばした記憶の禁止)。

## 付録B — Future Implementation Notes
- Phase 2でKPI原データの機械読取を追加する際も、算式と原データ参照の記帳義務は不変
- Knowledge経由の原則は全Phaseで不変(直通配線を作らない)
