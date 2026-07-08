# logs/ — ログ仕様・命名規則

| 項目 | 内容 |
|---|---|
| 上位文書 | `PHOSARA_AI_COMPANY_OS_v1.md` §「Security Policy / Logging」 |
| 目的 | 全 AI 従業員の実行・承認・状態遷移を時刻付きで記録し、遡及可能にする |
| 原則 | ログの改変を禁ずる。追記のみ |

---

## ディレクトリ構造

```
logs/
├── README.md              ← このファイル（ログ仕様の正典）
├── sales/                 ← Sales AI のログ
├── client-success/        ← Client Success AI のログ
├── knowledge/             ← Knowledge AI のログ
├── pbos/                  ← PBOS AI のログ
├── ceo/                   ← CEO AI のログ（Daily CEO Brief を含む）
├── approvals/             ← 承認記録（WAITING_APPROVAL の三点セット + 結果）
└── system/                ← 状態遷移・エスカレーション・Failure Log
```

**作成タイミング：** Phase 1 開始時に各サブディレクトリを作成する。現在（Phase 0）は本 README のみを配置する。

---

## 命名規則

| ログ種別 | ファイル名パターン | 例 |
|---|---|---|
| Sales 日次ログ | `YYYY-MM-DD_sales_log.md` | `2026-07-08_sales_log.md` |
| CS 日次ログ | `YYYY-MM-DD_cs_log.md` | `2026-07-08_cs_log.md` |
| Knowledge 日次ログ | `YYYY-MM-DD_knowledge_log.md` | `2026-07-08_knowledge_log.md` |
| PBOS 日次ログ | `YYYY-MM-DD_pbos_log.md` | `2026-07-08_pbos_log.md` |
| CEO Brief | `YYYY-MM-DD_ceo_brief.md` | `2026-07-08_ceo_brief.md` |
| 承認記録 | `YYYY-MM-DD_approval_[TASK_ID].md` | `2026-07-08_approval_TSK-001.md` |
| システムログ | `YYYY-MM-DD_system_log.md` | `2026-07-08_system_log.md` |
| Failure Log | `YYYY-MM-DD_failure_[AGENT]_[ID].md` | `2026-07-08_failure_sales_001.md` |

---

## ログフォーマット

### 日次エージェントログ（Sales / CS / Knowledge / PBOS）

```markdown
# [Agent Name] Daily Log — YYYY-MM-DD

## メタデータ
| 項目 | 内容 |
|---|---|
| Agent | [Agent 名] |
| 日付 | YYYY-MM-DD |
| トリガー | [TRG-XX] |
| 作成時刻 | HH:MM |

---

## タスク記録

### TASK-[ID] — [タスク概要]

| 項目 | 内容 |
|---|---|
| 状態 | [状態名] |
| 確信度 | XX% |
| 根拠 | [1 行] |
| 優先度 | P[0-3] |

**実行内容：**
（何を実行したか）

**成果物：**
（成果物の概要と保存場所）

**収穫（LEARNING）：**
（学び・改善候補）

---

## 7 要素報告書式

① **結論：** （3 行以内）

② **証拠：** （事実・データ・ログへの参照）

③ **優先度：** P[0-3]

④ **リスクと可逆性：** （不可逆操作がある場合は明示）

⑤ **次の一手：** [担当] / [期限]

⑥ **資産候補：** （Knowledge / PBOS へ昇格すべき学び）

⑦ **やらないこと：** （意図的に実行しないことを明記）
```

---

### Daily CEO Brief

```markdown
# Daily CEO Brief — YYYY-MM-DD

作成者: CEO AI
作成時刻: HH:MM

---

## ① 会社の今日の一文

（会社の状態を 1 文で表す）

---

## ② 承認待ち一覧（WAITING_APPROVAL）

| TASK_ID | Agent | 概要 | 三点セット |
|---|---|---|---|
| TSK-XXX | [Agent 名] | [概要] | [承認記録へのリンク] |

承認待ちがない場合：「本日の承認待ちはありません」

---

## ③ 警告

| 優先度 | 内容 | 担当 |
|---|---|---|
| P0 | （緊急事項） | [担当 AI] |
| P1 | （高優先事項） | [担当 AI] |

警告がない場合：「本日の警告はありません」

---

## ④ 今日の一手

（優先タスク 1 件 — 担当と期限を明記）

---

## 根拠ログ参照先

- Sales: `logs/sales/YYYY-MM-DD_sales_log.md`
- CS: `logs/client-success/YYYY-MM-DD_cs_log.md`
- Knowledge: `logs/knowledge/YYYY-MM-DD_knowledge_log.md`
- PBOS: `logs/pbos/YYYY-MM-DD_pbos_log.md`
```

---

### 承認記録（approvals/）

```markdown
# 承認記録 — YYYY-MM-DD — [TASK_ID]

| 項目 | 内容 |
|---|---|
| TASK_ID | TSK-XXX |
| 起案 AI | [Agent 名] |
| 承認者 | オーナー |
| 承認日時 | YYYY-MM-DD HH:MM |
| 結果 | 承認 / 差戻し / 却下 |

---

## 三点セット

### ① 事実
（判断の根拠となる事実・データ・証拠）

### ② 選択肢
- A: （内容・トレードオフ）
- B: （内容・トレードオフ）
- C: （任意）

### ③ 推奨と理由
推奨: [A / B / C]
確信度: XX%
理由: （根拠 1 行）

---

## 承認結果

選択: [A / B / C / 却下]
オーナーコメント: （任意）
次アクション: （承認後に実行すること）
```

---

### システムログ（system/）— 状態遷移・エスカレーション記録

```markdown
# System Log — YYYY-MM-DD

---

## 状態遷移記録

| 時刻 | TASK_ID | Agent | 旧状態 | 新状態 | 備考 |
|---|---|---|---|---|---|
| HH:MM | TSK-XXX | [Agent] | EXECUTING | LEARNING | — |

---

## エスカレーション記録

| 時刻 | TASK_ID | 段 | From | To | 内容 |
|---|---|---|---|---|---|
| HH:MM | TSK-XXX | E3 | Sales AI | CEO AI | 正典間の矛盾を検出 |

---

## WAITING タイムアウト監視

| TASK_ID | WAITING 開始日 | 経過日数 | 待ち先 | 対処 |
|---|---|---|---|---|
| — | — | — | — | — |
```

---

### Failure Log

```markdown
# Failure Log — YYYY-MM-DD — [Agent] — [ID]

| 項目 | 内容 |
|---|---|
| 発生日時 | YYYY-MM-DD HH:MM |
| 対象 Agent | [Agent 名] |
| Failure ID | FAIL-[AGENT]-YYYYMMDD-[NN] |
| 重大度 | P[0-3] |
| 状態変更 | [実行前の権限] → 降格（自律権停止） |

---

## 発生内容

（何が起きたか — 事実のみ）

## 原因分析

（なぜ起きたか）

## 再発防止策

（どう防ぐか）

## 復帰審査

| 項目 | 内容 |
|---|---|
| 防止策の実施日 | YYYY-MM-DD |
| 復帰申請日 | YYYY-MM-DD |
| 承認者 | オーナー |
| 復帰承認日 | YYYY-MM-DD |
```

---

## ログ管理ルール

| ルール | 内容 |
|---|---|
| **改変禁止** | ログの内容は変更しない。誤記がある場合は新しいエントリで訂正を記録する |
| **追記のみ** | 日次ログは 1 日 1 ファイル。同日内の追記はファイル末尾に追加する |
| **タイムスタンプ必須** | すべてのエントリに `YYYY-MM-DD HH:MM`（JST）を付ける |
| **担当 AI の明記** | すべてのログエントリに作成した AI 名を記録する |
| **保存場所の固定** | ログは必ず `logs/[種別]/` に保存する。他の場所への保存を禁ずる |
| **機密情報の扱い** | 顧客の個人情報・機密情報はログに直接書かない。参照先（別ファイル・ID）を記録する |

---

## 参照

- 状態遷移の定義 → `../STATE.md`
- 承認方針 → `../HUMAN_APPROVAL.md`
- エージェント一覧 → `../AGENTS.md`
- ディレクトリ構造 → `../DIRECTORY_STRUCTURE.md`
