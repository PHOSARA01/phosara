# SALES_MVP_STATE.md — Sales MVP 状態機械

| 項目 | 内容 |
|---|---|
| 上位文書 | `../STATE.md`（共有状態機械）/ `../../runtime/PHOSARA_AI_SALES_RUNTIME_v1.md` §「第3章」 |
| 原則 | 状態のないターゲットを禁ずる。共通8状態を継承し、営業固有の意味を与える。新しい状態を追加しない |
| Phase 1スコープ | NEW → ANALYZING → READY → WAITING_APPROVAL まで |

---

## 状態一覧（Phase 1 MVP）

| 共通状態 | 営業での意味 | Phase 1スコープ | 遷移条件 |
|---|---|---|---|
| `NEW` | ターゲットがキューに登録された | ✅ 対象 | リスト読込 / 差戻しによる再登録 |
| `ANALYZING` | Steps 2–7（リサーチ・分析・文面生成・セルフレビュー）実行中 | ✅ 対象 | Step 2 着手 |
| `READY` | 文面と三点セットが完成し承認提出可能 | ✅ 対象 | セルフレビュー合格 + Confidence Score ≥ 70% |
| `WAITING_APPROVAL` | 承認キュー登録済み・オーナー判断待ち | ✅ 対象（終端） | `OWNER_APPROVAL_QUEUE.md` への書き込み完了 |
| `EXECUTING` | 送信・返信対応・予約調整の実行中 | ❌ Phase 2以降 | 承認取得後 |
| `WAITING` | 外部待ち（相手返信・予約確定） | ❌ Phase 2以降 | 送信完了後 |
| `LEARNING` | 接触結果の収穫・ログ確定・同期 | ❌ Phase 2以降 | 返信受領・期限到来 |
| `COMPLETED` | 本サイクル完了 | ❌ Phase 2以降 | 収穫記録の存在が条件 |

---

## Phase 1 状態遷移図

```
[オーナー指示 / TRG-01]
      ↓
    NEW
（ターゲット登録）
      ↓
  ANALYZING
（Steps 2–7 実行中）
   ├─ セルフレビュー不合格 → ANALYZING（再生成）
   ├─ 2回連続不合格 → CONFLICT_LOG → E4（オーナー相談）
   └─ 合格 ↓
    READY
（三点セット・文面完成）
      ↓ [Step 9 実行: OWNER_APPROVAL_QUEUE.md 追記]
WAITING_APPROVAL
（オーナー判断待ち）← Phase 1 の終端
   ├─ 承認 → [Phase 2: EXECUTING へ]
   └─ 差戻し → NEW（理由を記録）
```

---

## 状態の記録フォーマット

各ターゲットの状態を `SALES_MVP_LOG.md` に記録する際のフォーマット。

```
TARGET_ID  : [管理ID — 例: ST-20260708-001]
COMPANY    : [会社名]
STATE      : [現在の状態]
UPDATED_AT : [YYYY-MM-DD HH:MM]
STEP       : [現在実行中のStep番号（ANALYZINGの場合）]
AQ_ENTRY   : [承認キューエントリID — WAITING_APPROVALの場合]
NOTES      : [差戻し理由・エラー内容など]
```

---

## 遷移規則（厳守）

1. **状態のないターゲットを禁ずる** — キュー登録と同時に `NEW` を記録する
2. **ANALYZING → READY の条件** — セルフレビュー全8項目合格かつ Confidence Score ≥ 70%。どちらか欠けても `READY` に遷移しない
3. **WAITING_APPROVAL への条件** — 三点セット（事実 / 選択肢2案 / 推奨と理由）が `OWNER_APPROVAL_QUEUE.md` に書き込まれていること
4. **差戻しは `NEW` へ** — 差戻し理由を `SALES_MVP_LOG.md` に記録してから `NEW` に戻す。理由なき差戻しは理由の確認を1回行う
5. **承認SLAは48時間** — 超過時は督促1回。`OWNER_APPROVAL_QUEUE.md` の警告欄を更新する

---

## WAITING_APPROVAL タイムアウト監視

| 経過時間 | アクション |
|---|---|
| 24時間 | 変化なし（監視継続） |
| 48時間 | 督促フラグを立てる（`OWNER_APPROVAL_QUEUE.md` の当該エントリに「⚠️ 承認期限超過」を追記） |
| Daily Report | 警告欄に「承認待ち超過: [会社名]（[経過時間]）」を記載 |

---

## 差戻しパターンと対処

| 差戻し理由 | 対処 |
|---|---|
| 文面のトーンが合わない | `NEW` に戻し、差戻し理由をANALYZING時のインプットに追加してStep 6から再実行 |
| 対象企業が適切でない | `NEW` に戻し、別の候補を Step 3 から再選定 |
| 情報不足 | `WAITING` 状態で追加情報を待つ（情報源・期限を明記） |
| 同種差戻しが2回連続 | `CONFLICT_LOG.md` に起票 → テンプレ改版候補として記録 |

---

## 各状態でのログ記録義務

| 状態 | 記録内容 | 記録先 |
|---|---|---|
| `NEW` | 登録日時・対象企業・登録理由 | `SALES_MVP_LOG.md` |
| `ANALYZING` | 各Stepの実行結果・確信度変化 | `SALES_MVP_LOG.md` |
| `READY` | セルフレビュー結果・最終Confidence Score | `SALES_MVP_LOG.md` |
| `WAITING_APPROVAL` | エントリID・提出日時・承認期限 | `SALES_MVP_LOG.md` + `OWNER_APPROVAL_QUEUE.md` |
