# PHOSARA AI Company — Runtime 仕様ディレクトリ

| 項目 | 内容 |
|---|---|
| ディレクトリ | `company/13_ai-company/runtime/` |
| 管轄 | PHOSARA HQ |
| Phase | Phase 1（Claude Code MVP）の公式仕様 |
| 状態 | ACTIVE |
| 上位文書 | `../PHOSARA_AI_COMPANY_OS_v1.md`（AI企業憲法） |
| 参照対象 | Claude Code / n8n / MCP / GitHub |

---

## Runtime 層の目的

Runtime とは **「AI 従業員が毎日どう動くか」を定めた運転仕様** である。

「何であるか（職務・KPI・目的）」を定める **Agent 定義書**（`../agents/*.md`）とは明確に分界する。

Runtime が定めるのは以下の 4 要素のみ。

| 要素 | 内容 |
|---|---|
| **周期（Cycles）** | 日次・週次・月次の運転スケジュール |
| **状態（States）** | 各タスクの状態遷移（`../implementation/STATE.md` と対応） |
| **イベント（Events）** | 例外・割り込み・エラーが発生したときの処理フロー |
| **失敗処理（Failure Handling）** | エスカレーション・降格・復帰の手順 |

---

## Agent 定義との違い

| 比較軸 | Agent 定義書（`../agents/`） | Runtime 仕様（このディレクトリ） |
|---|---|---|
| **問いに答える** | この AI は何者か？ | この AI は毎日どう動くか？ |
| **内容** | 職務・KPI・責任範囲・確信度基準 | 運転周期・状態機械・イベント処理・失敗処理 |
| **参照タイミング** | 設計・役割の確認 | 実装・実行・運用 |
| **改版の契機** | 職務範囲の変更 | 運転手順の改善・実測による最適化 |
| **権威の所在** | Agent 定義書が正 | Runtime が正（Agent 定義を上書きしない） |

**原則：** Runtime はその Agent 定義書を上書きしない。両者が矛盾する場合は Agent 定義書を優先し、Runtime を更新する。

---

## 読む順番

| 順番 | ファイル | 理由 |
|---|---|---|
| 前提 | `../PHOSARA_AI_COMPANY_OS_v1.md` | 状態機械・通信規約・承認方針の共通基盤 |
| 前提 | `../implementation/STATE.md` | Runtime が参照する 8 状態の定義 |
| 前提 | `../implementation/WORKFLOW.md` | トリガー・日次/週次サイクルの共通定義 |
| 1 | `PHOSARA_AI_CEO_RUNTIME_v1.md` | 統合モジュール。他 4 本の出力を受け取る立場 |
| 2 | `PHOSARA_AI_SALES_RUNTIME_v1.md` | MVP の第 1 Agent。循環の起点 |
| 3 | `PHOSARA_AI_CLIENT_SUCCESS_RUNTIME_v1.md` | MVP の第 2 Agent。Sales からのハンドオフを受ける |
| 4 | `PHOSARA_AI_KNOWLEDGE_RUNTIME_v1.md` | MVP の第 3 Agent。Sales・CS から収穫を受ける |
| 5 | `PHOSARA_AI_PBOS_RUNTIME_v1.md` | Phase 2 以降。Knowledge から価値を計測する |

**姉妹仕様：** 全 5 本は同一のアーキテクチャ・用語・章構造を持つ統一された Runtime システムである。

---

## 各 Runtime の役割

| Runtime | 担当 AI | 役割の核心 | 接続先 |
|---|---|---|---|
| `PHOSARA_AI_SALES_RUNTIME_v1.md` | Sales AI | ターゲット接触→承認→送信→Log の日次ループ | → CS AI / Knowledge AI / CEO AI |
| `PHOSARA_AI_CLIENT_SUCCESS_RUNTIME_v1.md` | CS AI | 予約→監査前後のコミュニケーション→紹介依頼の周期管理 | → Knowledge AI / CEO AI |
| `PHOSARA_AI_KNOWLEDGE_RUNTIME_v1.md` | Knowledge AI | 収穫→分類→パターン抽出→正典更新案の夜間処理 | → PBOS AI / CEO AI |
| `PHOSARA_AI_PBOS_RUNTIME_v1.md` | PBOS AI | KPI 計測→ROI 分析→改善起案の週次ループ | → CEO AI |
| `PHOSARA_AI_CEO_RUNTIME_v1.md` | CEO AI | 4 報告の統合→Daily CEO Brief→承認キューの管理 | → オーナー |

---

## Implementation Phase 1 での使い方

### Claude Code による使用

Claude Code は Phase 1 の各タスク実行時に、以下の順序で Runtime を参照する。

```
1. CLAUDE.md（行動基準の確認）
2. ../implementation/STATE.md（状態確認）
3. 該当 Runtime ファイル（第1章: 運転フロー / 第2章: 周期 / 第5章: イベント処理）
4. 関連する正典（SALES_PLAYBOOK / CLIENT_SUCCESS_PLAYBOOK 等）
5. ../implementation/HUMAN_APPROVAL.md（承認要否の確認）
6. ../implementation/logs/（ログの記録）
```

### Phase 1 MVP の実装優先順位

```
Phase 1 MVP（Sales / CS / Knowledge）
 └─ 実装順: Sales Runtime → CS Runtime → Knowledge Runtime
     ├─ Sales: 営業文下書き・承認キュー・Log 作成
     ├─ CS: 予約案内・リマインド・フォローアップ文作成
     └─ Knowledge: Log 分析・パターン抽出・更新案作成

Phase 2 以降
 └─ PBOS Runtime → CEO Runtime（統合ループ）
```

---

## Claude Code / n8n / MCP との関係

| ツール | Runtime の使われ方 |
|---|---|
| **Claude Code** | 各 Runtime の「日次バッチ」「承認窓」処理を実行する主体。Runtime の第 1 章（フロー）・第 2 章（周期）を逐次参照する |
| **n8n** | Runtime の「トリガー」「周期スケジュール」を自動起動する配管。Phase 2 で接続する |
| **MCP** | Runtime が参照する台帳（State / Log）への共通アクセス層。Phase 2 で接続する |
| **GitHub** | Runtime 仕様の版管理・承認記録の保存・ログの永続化 |

---

## 依存関係

```
HQ Core (company/01_hq-core/)
└── Company OS v2.0 (company/02_company-os/)
    └── AI Company OS v1.0 (../PHOSARA_AI_COMPANY_OS_v1.md)
        ├── agents/                    ← 職務・KPI の権威
        ├── implementation/            ← 状態・承認・検証の基盤
        └── runtime/                   ← 運転仕様（このディレクトリ）
            ├── PHOSARA_AI_CEO_RUNTIME_v1.md         ← 統合モジュール
            ├── PHOSARA_AI_SALES_RUNTIME_v1.md       ← 循環の起点
            ├── PHOSARA_AI_CLIENT_SUCCESS_RUNTIME_v1.md
            ├── PHOSARA_AI_KNOWLEDGE_RUNTIME_v1.md
            └── PHOSARA_AI_PBOS_RUNTIME_v1.md
```

Runtime 間の接続（データフロー）:

```
Sales Runtime ──→ CS Runtime ──→ Knowledge Runtime ──→ PBOS Runtime
     ↓                ↓                  ↓                    ↓
                                                        CEO Runtime（統合）
                                                              ↓
                                                           オーナー
```

---

## 更新ルール

| 対象 | ルール |
|---|---|
| 各 Runtime `*.md` | 運転手順の改善・実測による最適化のたびに更新。バージョン番号を上げる |
| `README.md`（このファイル） | ディレクトリ構成・Runtime 間の接続関係が変わったときのみ更新 |
| 改版の手順 | `company/12_knowledge/PBOS_UPDATE_WORKFLOW.md` に従う |
| 改版の権限 | HQ の承認なしに変更禁止（各 Runtime ファイルの絶対規則に従う） |

**絶対規則：** 各 Runtime ファイルに記載された「絶対規則」（承認方針・値引き禁止・監査ファースト・台帳経由の原則）は、Runtime の更新をもって上書きできない。
