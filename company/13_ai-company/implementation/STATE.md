# STATE.md — 共有状態機械

| 項目 | 内容 |
|---|---|
| 上位文書 | `PHOSARA_AI_COMPANY_OS_v1.md` §「Shared State Machine」 |
| 適用対象 | 全 AI 従業員（CEO / Sales / CS / Knowledge / PBOS）のすべての仕事 |
| 原則 | 状態のない仕事を禁ずる |

---

## 状態一覧

すべての仕事は以下の 8 状態のいずれかに属する。

| 状態 | 定義 | 遷移先 |
|---|---|---|
| `NEW` | 登録済み・未着手 | `ANALYZING` |
| `ANALYZING` | 分解・証拠収集・採点中 | `READY` / `WAITING`（情報待ち） |
| `READY` | 実行可能・承認要否の判定済み | `EXECUTING`（承認不要）/ `WAITING_APPROVAL` |
| `WAITING_APPROVAL` | オーナー承認待ち（三点セット添付済み） | `EXECUTING` / `NEW`（差戻し）/ 終了（却下） |
| `EXECUTING` | 実行中 | `LEARNING` / `WAITING`（外部待ち） |
| `WAITING` | 外部要因（顧客・入金・第三者）待ち | `EXECUTING` / エスカレーション |
| `LEARNING` | 収穫・記録・検証中 | `COMPLETED` |
| `COMPLETED` | 完了（収穫記録の存在が完了の条件） | — |

---

## 状態遷移図

```
NEW
 └─→ ANALYZING
      ├─→ READY
      │    ├─→ EXECUTING          (承認不要タスク)
      │    └─→ WAITING_APPROVAL
      │         ├─→ EXECUTING     (承認された)
      │         ├─→ NEW           (差戻し)
      │         └─→ [終了]        (却下)
      └─→ WAITING                 (情報待ち)
           └─→ EXECUTING / エスカレーション

EXECUTING
 ├─→ LEARNING
 └─→ WAITING                     (外部待ち)
      └─→ EXECUTING / エスカレーション

LEARNING
 └─→ COMPLETED
```

---

## 遷移規則（厳守）

1. **状態のない仕事を禁ずる** — 仕事の登録と同時に `NEW` を記録する
2. **`WAITING_APPROVAL` の条件** — 三点セット（事実 / 選択肢 2–3 / 推奨と理由）が添付されていない場合は `WAITING_APPROVAL` に遷移できない。差し戻す
3. **`LEARNING` のスキップを禁ずる** — `EXECUTING` → `COMPLETED` の直接遷移は台帳が受理しない。必ず `LEARNING` を経由する
4. **`WAITING` の記録義務** — 待ち先（顧客名・入金元・第三者名）と期限を明記する。記載なき `WAITING` を禁ずる

---

## 三点セット（WAITING_APPROVAL 添付必須）

`WAITING_APPROVAL` に遷移する際は、以下の三点セットを必ず添付する。

| 要素 | 内容 |
|---|---|
| **① 事実** | 判断の根拠となる事実・データ・証拠（推測を含めない） |
| **② 選択肢** | 2〜3 つの選択肢と、それぞれのトレードオフ |
| **③ 推奨と理由** | AI が推奨する選択肢と、その根拠（確信度を付す） |

三点セットがない承認要請は受理しない。

---

## 状態の記録フォーマット

台帳（ログ）に記録する際は以下のフォーマットを使用する。

```
TASK_ID    : [仕事の一意 ID]
AGENT      : [担当 AI 名]
STATE      : [現在の状態]
UPDATED_AT : [YYYY-MM-DD HH:MM]
SUMMARY    : [仕事の概要（1 行）]
WAITING_FOR: [WAITING の場合のみ記入 — 待ち先と期限]
APPROVAL   : [WAITING_APPROVAL の場合のみ — 三点セットの場所（ファイルパスまたはログ行）]
```

---

## エスカレーション条件

`WAITING` が以下の条件に達した場合、自動でエスカレーションする。

| 条件 | エスカレーション先 |
|---|---|
| 待機 3 日以上（顧客待ち） | CEO AI → オーナーへ通知 |
| 待機 7 日以上（外部要因） | オーナーへ直行（P0 扱い） |
| 待ち先が不明 | 即時エスカレーション（WAITING の記録不備） |

---

## 参照

- 承認基準の詳細 → `HUMAN_APPROVAL.md`
- エスカレーション手順の詳細 → `PHOSARA_AI_COMPANY_OS_v1.md` §「Escalation Rules」
- 状態記録の保存先 → `logs/README.md`
