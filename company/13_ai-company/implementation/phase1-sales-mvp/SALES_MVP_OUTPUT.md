# SALES_MVP_OUTPUT.md — Sales AI MVP 出力定義

| 項目 | 内容 |
|---|---|
| 目的 | Sales AI MVP が各ステップで生成する出力の形式・保存先を定義する |
| 原則 | 出力はすべて台帳（ファイル）に記録される。口頭・メモのみの出力を禁ずる |

---

## 出力一覧（Step別）

| Step | 出力名 | 形式 | 保存先 |
|---|---|---|---|
| 3 | 選定記録 | テキスト（構造化） | `SALES_MVP_LOG.md` に追記 |
| 4 | Web調査サマリー | テキスト（項目別） | `SALES_MVP_LOG.md` に追記 |
| 5 | BA価値分析 | テキスト（構造化） | `SALES_MVP_LOG.md` に追記 |
| 6 | 営業文（案A・案B） | 件名 + 本文 | `OWNER_APPROVAL_QUEUE.md` に含める |
| 7 | 自己レビュー結果 | チェックリスト + 判定 | `SALES_MVP_LOG.md` に追記 |
| 8 | Confidence Score | %値 + 根拠1行 + 仮定 | `OWNER_APPROVAL_QUEUE.md` / `SALES_MVP_LOG.md` |
| 9 | 承認キューエントリ | 三点セット形式 | `OWNER_APPROVAL_QUEUE.md` に追記 |
| Log | Sales Logエントリ | SALES_LOG_STANDARD準拠 | `SALES_MVP_LOG.md` に追記 |

---

## 最終出力（MVP 1サイクル完了時）

Sales AI MVP の1サイクル完了時に、Claude Code はオーナーへ以下の形式で報告する。

```markdown
## Sales AI MVP 実行完了報告 — YYYY-MM-DD HH:MM

### 選定企業
- 会社名: [会社名]（[管理ID]）
- ランク: [S / A]
- 営業方法: [初回営業チャネル]

### 実行結果
| Step | 内容 | 結果 |
|---|---|---|
| Step 1–2 | リスト読込・優先ソート | 完了 |
| Step 3 | 候補選定 | [会社名] を選定 |
| Step 4 | Web調査 | [N]項目確認 |
| Step 5 | BA価値分析 | 生成完了 |
| Step 6 | 営業文生成 | 案A・案B を生成 |
| Step 7 | 自己レビュー | 合格（[N]/8項目） |
| Step 8 | Confidence Score | XX% |
| Step 9 | 承認キュー登録 | 完了（AQ-YYYYMMDD-NNN） |
| Log | Sales Log記録 | 完了 |

### 次のアクション（オーナーへ）
OWNER_APPROVAL_QUEUE.md の [AQ-YYYYMMDD-NNN] を確認し、承認または差戻しを記入してください。

### 警告・注意事項
[あれば記載 / なければ「なし」]
```

---

## 承認・差戻し後の出力

### 承認された場合（Phase 2接続後）

```markdown
## 承認確認 — [AQ-YYYYMMDD-NNN]

承認内容: 案A / 案B
承認日時: YYYY-MM-DD HH:MM
次フェーズ: [Phase 2（n8n接続後）に EXECUTING へ遷移]
```

### 差戻しされた場合

```markdown
## 差戻し記録 — [AQ-YYYYMMDD-NNN]

差戻し日時: YYYY-MM-DD HH:MM
差戻し理由: [オーナーの記入内容]
状態: WAITING_APPROVAL → NEW
次アクション: [差戻し理由をStep 6のインプットに追加して再実行 / または別企業を選定]
```

---

## 出力の品質基準

| 出力 | 品質基準 |
|---|---|
| 選定記録 | 「なぜこの会社か」が1〜3文で明確に説明されている |
| BA価値分析 | 相手の立場から見て「そうそう、それが悩みだった」と感じられる言語になっている |
| 営業文 | 自己レビュー8項目を全て通過している |
| Confidence Score | 根拠1行が必ずある。感覚での申告を禁ずる |
| 承認キューエントリ | 三点セット（事実 / 選択肢 / 推奨と理由）が揃っている |
| Sales Log記録 | SALES_LOG_STANDARD.md の必須フィールドが全て埋まっている |

---

## 出力が生成できない場合

| 状況 | 出力内容 | 保存先 |
|---|---|---|
| Confidence Score 70%未満（2回連続） | エラー報告（状況・再現条件・三点セット） | `CONFLICT_LOG.md` + オーナーへE4 |
| 自己レビュー不合格（2回連続） | エラー報告（不合格項目・修正試行の記録） | `CONFLICT_LOG.md` + オーナーへE4 |
| 仕様の矛盾を発見 | 矛盾の記録（原文・矛盾点・暫定適用した文書） | `CONFLICT_LOG.md` のみ。コードで回避しない |
