# 自己ヒアリング設定記録（D0-05）

| 項目 | 内容 |
|---|---|
| 文書ID | CZ-D0-05-SETUP |
| 作成日 | 2026-07-05 |
| 目的 | Day 1（CZ-02）以降の自己ヒアリングを商用案件と同一条件で実行できる状態を作る |
| 参照 | §5.4 自己ヒアリングプロトコル / BUSINESS_AUDIT_SYSTEM.md §7 |
| 有効化 | 人間オーナーが本書を確認・承認した時点で設定を確定とする |

---

## 1. 進行役の設定

| 項目 | 設定値 |
|---|---|
| **進行役** | Claude Code（本セッション） |
| **進行方法** | `CLIENT_INTERVIEW_GUIDE_CZ.md` の設問を**逐語・順番どおり**に提示する |
| **担当範囲** | 設問の提示・回答の受領・証拠ラベルの付与・未証明フラグの管理 |
| **禁止事項** | 誘導・評価・解決策の示唆・設問の省略・順序の変更 |

### Claude Code の役割（§5.4 準拠）

```
1. CLIENT_INTERVIEW_GUIDE_CZ.md の設問を 1 問ずつ逐語で提示する
2. 人間の回答を受領し、そのまま保存用ファイルに転記する（編集・要約しない）
3. 回答に三証拠源（資料・観察・計測）の根拠があるか判断し、
   なければ「未証明」ラベルを付与する
4. 全設問が終わるまで次のセクションへ進まない
5. 「都合よく答えている」と疑われる回答には、追加の根拠を求める
```

### 自己欺瞞への防衛（Z-1 規律）

- タイブレークは**厳しい側**に倒す（自社案件の恒久規則）
- 「そう思う」だけの回答はスコア根拠にならない
- 証拠が取れない回答は「未証明」のまま確定させる（後から変更しない）
- 問題が発見された場合は、自社に対しても顧客案件と同じ基準で記述する

---

## 2. 回答保存先

| ファイル種別 | 保存先パス | タイミング |
|---|---|---|
| ヒアリング原文（即答記録） | `07_clients/client_zero/02_audit/business/INTERVIEW_RAW_DAY2.md` | Day 2 実施直後・編集前 |
| 三証拠源分類メモ | `07_clients/client_zero/02_audit/business/EVIDENCE_LOG_DAY2.md` | Day 2〜3 |
| 未証明フラグリスト | `07_clients/client_zero/02_audit/business/UNVERIFIED_ITEMS.md` | Day 2〜3 |
| M1/M7/M11 スコア案 | `07_clients/client_zero/02_audit/business/SCORE_DRAFT_D3.md` | Day 3（確定は Day 4 以降） |
| Key Findings 素材 | `07_clients/client_zero/02_audit/business/KEY_FINDINGS_DRAFT.md` | Day 3 |

**原則:** 回答は即答のまま保存する。事後編集は禁止。訂正が必要な場合は追記形式のみとする（§5.4）。

---

## 3. 4ファイルの役割

### ファイル構成

```
07_clients/client_zero/02_audit/
├── AUDIT_CHECKLIST_CZ.md              ← 記入用チェックリスト
├── AUDIT_REPORT_TEMPLATE_CZ.md        ← 報告書雛形
├── IMPROVEMENT_ROADMAP_TEMPLATE_CZ.md ← ロードマップ雛形
└── business/
    └── CLIENT_INTERVIEW_GUIDE_CZ.md   ← ヒアリング進行台本
```

### 役割一覧

| ファイル | 役割 | 使用タイミング | 担当 |
|---|---|---|---|
| `CLIENT_INTERVIEW_GUIDE_CZ.md` | ヒアリング設問の**進行台本**。Claude Code が設問を逐語提示する。設問の省略・順序変更禁止 | Day 2（自己ヒアリング） | Claude Code が提示、人間が回答 |
| `AUDIT_CHECKLIST_CZ.md` | 11モジュール全項目の**現場記入用チェックリスト**。所見・エビデンス源を項目ごとに記録する。エビデンスなき記入は無効 | Day 2〜9（各モジュール実施時） | 人間 + Claude Code（記録補助） |
| `AUDIT_REPORT_TEMPLATE_CZ.md` | 監査報告書の**雛形**。Day 10〜11 の Draft 作成に使用。サマリー・レーダー・信号評価・優先課題・方向性を含む | Day 10〜11（CZ-06〜09） | Claude Code Draft → H 承認 |
| `IMPROVEMENT_ROADMAP_TEMPLATE_CZ.md` | 改善ロードマップの**雛形**。30日クイックウィン・60日土台・90日構造改善・1年戦略を記入する | Day 10〜11（CZ-07） | Claude Code Draft → H 承認 |

### 流れの中での位置づけ

```
Day 2〜3   CLIENT_INTERVIEW_GUIDE_CZ.md  → 設問進行・回答収集
           AUDIT_CHECKLIST_CZ.md         → M1/M7/M11 の証拠記入

Day 6〜9   AUDIT_CHECKLIST_CZ.md         → M2〜M6/M8〜M10 を追記

Day 10〜11 AUDIT_REPORT_TEMPLATE_CZ.md   → 報告書 Draft 作成
           IMPROVEMENT_ROADMAP_TEMPLATE_CZ.md → ロードマップ Draft 作成

Day 12〜14 H 承認 → 収穫の儀 → STATE 完了記録
```

---

## 4. ヒアリング実施ルール（Day 2 に向けた確認）

| ルール | 内容 |
|---|---|
| 進行 | Claude Code が `CLIENT_INTERVIEW_GUIDE_CZ.md` の設問を**逐語・順番どおり**提示する |
| 回答 | 人間オーナーが書面（チャット入力）で**即答**する |
| 事後編集 | **禁止**。訂正は追記形式のみ |
| 証拠確認 | Claude Code が三証拠源（資料・観察・計測）を確認し、なければ「未証明」ラベルを付与する |
| タイブレーク | 証拠が不十分な場合は**厳しい側**に倒す |
| 冷却 | スコア案の確定（H 承認）は Day 4 以降。48時間冷却ルール（§5.4） |
| 緊急停止 | 「都合よく答えている」と気づいた場合は即時停止し、第三者の視点を検討する（§5.3） |

---

## 5. Day 1（CZ-02）開始前の最終確認

| 確認項目 | 状態 |
|---|---|
| Claude Code が進行役として設定されているか | ✅ 本書により設定済み |
| 回答保存先が確定しているか | ✅ `02_audit/business/` 以下（本書 §2 に明記） |
| 4ファイルの役割が明確か | ✅ 本書 §3 に整理済み |
| §5.4 プロトコルのルールが記録されているか | ✅ 本書 §4 に明記 |
| 人間オーナーの承認 | [ ] Day 1 開始前に確認 |

---

> **設定確定の条件:** 人間オーナーが本書を確認し、Day 1 の開始を宣言することをもって設定確定とする。
> 確定後は本ファイルを更新し、「承認済み」とマークすること。
