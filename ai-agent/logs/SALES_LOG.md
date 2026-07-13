# SALES_LOG — 状態遷移ログ

**重要:** このファイルは追記のみ。削除・改変禁止。
遷移の発生と同時に追記する（まとめ書き禁止）。

---

## ログフォーマット

| 日時（JST）| ターゲットID | 会社名 | 遷移前 | 遷移後 | メモ |
|---|---|---|---|---|---|
| YYYY-MM-DD HH:MM | [管理ID] | [会社名] | [旧状態] | [新状態] | [メモ] |

---

## 記録すべきタイミング（必須）

1. ターゲット選定完了 → `IDLE → ANALYZING`
2. 自己レビュー合格 → `ANALYZING → READY`
3. 承認キュー登録完了 → `READY → WAITING_APPROVAL`
4. 承認受領 → `WAITING_APPROVAL → EXECUTING`（Phase 2以降）
5. 差戻し受領 → `WAITING_APPROVAL → NEW`
6. エラー・不合格発生時 → 状態変更なしでも記録

---

## ログ

| 日時（JST）| ターゲットID | 会社名 | 遷移前 | 遷移後 | メモ |
|---|---|---|---|---|---|
| 2026-07-13 00:00 | — | — | — | IDLE | Phase 1-A 初期化完了 |

| 2026-07-13 05:58 | ST-20260708-001 | やまとはり・きゅう整骨院 | IDLE | ANALYZING | オーナー正式承認済み。ドライラン初回ターゲット選定完了 |

| 2026-07-13 06:15 | ST-20260708-001 | やまとはり・きゅう整骨院 | ANALYZING | READY | Web調査5クエリ完了・BA分析・営業文A/B生成・AI自己レビュー8項目全合格（1回目）|
| 2026-07-13 06:17 | ST-20260708-001 | やまとはり・きゅう整骨院 | READY | WAITING_APPROVAL | AQ-20260713-001 を OWNER_APPROVAL_QUEUE.md に登録完了。Confidence Score 78% |
| 2026-07-13 07:00 | ST-20260708-001 | やまとはり・きゅう整骨院 | WAITING_APPROVAL | WAITING_APPROVAL | v1.1 アップグレード。Instagram/GBP/競合3社分析強化・Business Audit Report追加・Confidence Score 78%→85% |
| 2026-07-13 07:15 | ST-20260708-001 | やまとはり・きゅう整骨院 | WAITING_APPROVAL | REVISING | PHOSARA HQ指示によりv1.2最終ブラッシュアップ開始。修正①〜⑦実施（情報分類・配点根拠・Confidence Score配点方式・Executive Recommendation等） |
| 2026-07-13 07:30 | ST-20260708-001 | やまとはり・きゅう整骨院 | REVISING | WAITING_APPROVAL | v1.2完成。Sales Agent v1系最終設計版として確定。Confidence Score 69/100（配点方式）。実戦投入条件付き可 |

<!-- 新しいエントリはここより下に追記されます -->
