# Sales AI MVP — Phase 1 実装ガイド

| 項目 | 内容 |
|---|---|
| ディレクトリ | `company/13_ai-company/implementation/phase1-sales-mvp/` |
| 管轄 | PHOSARA HQ |
| Phase | Phase 1（Claude Code MVP） |
| 状態 | ACTIVE |
| 上位文書 | `../../runtime/PHOSARA_AI_SALES_RUNTIME_v1.md` |
| 参照Agent | `../../agents/PHOSARA_AI_SALES_AGENT_v1.md` |
| 参照正典 | `../../../04_sales/SALES_TARGET_LIST_TOCHIGI_v1.md` / `SALES_EXECUTION_TOOLKIT.md` / `SALES_LOG_STANDARD.md` |

---

## このディレクトリの目的

Sales AI MVP は **「営業対象を確認し、調査し、営業文を生成し、オーナー承認待ちまで進める」** ことを自動化する最小実装である。

Claude Code がこのディレクトリを参照することで、オーナーの一言（「今日の営業候補を出して」）から承認キューへの登録まで、一連のフローを実行できる状態を作る。

---

## MVPスコープ（Phase 1でやること・やらないこと）

### やること（Steps 1–9 + Log）

| Step | 内容 | 担当 |
|---|---|---|
| 1 | 営業対象リストを読み込む | Claude Code |
| 2 | S・Aランクを優先して候補を絞る | Claude Code |
| 3 | 1社を営業候補として選定する | Claude Code |
| 4 | Web調査項目を整理する | Claude Code |
| 5 | Business Auditが刺さる理由を生成する | Claude Code |
| 6 | SALES_EXECUTION_TOOLKITに基づき営業文を生成する | Claude Code |
| 7 | AI自己レビューを行う（8項目） | Claude Code |
| 8 | Confidence Scoreを付ける | Claude Code |
| 9 | オーナー承認待ちキューへ入れる | Claude Code |
| Log | Sales Logへ記録する | Claude Code |

### やらないこと（Phase 2以降）

- 実際の営業送信（メール・フォーム・DM）
- Gmail / Gmailフォーム の自動送信
- n8n ワークフロー接続
- MCP / 外部API 接続
- 自動予約
- 返信の自動確認・分類

---

## 読む順番（Claude Code向け）

| 順番 | ファイル | 内容 |
|---|---|---|
| 1 | `README.md`（このファイル） | 全体像・スコープ・使い方 |
| 2 | `SALES_MVP_INPUT.md` | 何を読み込むか（入力定義） |
| 3 | `SALES_MVP_WORKFLOW.md` | 10ステップのフロー詳細 |
| 4 | `SALES_MVP_STATE.md` | 状態機械（現在地の確認） |
| 5 | `OWNER_APPROVAL_QUEUE.md` | 承認キューへの書き方・読み方 |
| 6 | `SALES_MVP_OUTPUT.md` | 何を出力するか（出力定義） |
| 7 | `SALES_MVP_LOG.md` | Sales Logの記録 |
| 8 | `DAILY_SALES_REPORT_TEMPLATE.md` | 日次報告のテンプレート |
| 9 | `CONFLICT_LOG.md` | 仕様の矛盾・未定義の記録 |

---

## Claude Codeによる使い方

### 起動トリガー

以下のいずれかで Sales AI MVP を起動する。

```
オーナー指示例：
「今日の営業候補を1社選んで承認キューに入れて」
「Sales AI MVPを動かして」
「栃木の営業リストから次の候補を出して」
```

### 実行手順（Claude Code）

```
1. SALES_MVP_INPUT.md を確認する
2. SALES_TARGET_LIST_TOCHIGI_v1.md を読み込む
3. SALES_MVP_WORKFLOW.md の Step 1–9 を順番に実行する
4. 各ステップで SALES_MVP_STATE.md の状態を確認・更新する
5. Step 9 完了後、OWNER_APPROVAL_QUEUE.md に追記する
6. SALES_MVP_LOG.md に記録を追記する
7. SALES_MVP_OUTPUT.md の形式で結果を報告する
```

### オーナーが行うこと

```
1. OWNER_APPROVAL_QUEUE.md を開く
2. 承認キューの内容（営業文全文・三点セット・Confidence Score）を確認する
3. ファイルに「承認」または「差戻し（理由）」を追記する
4. Claude Code に承認/差戻しを伝える
```

---

## Human Approval Policy（このMVPでの適用）

| アクション | 承認要否 |
|---|---|
| 営業対象リストの読み込み | 不要（AI自律実行） |
| 候補企業の選定 | 不要（AI自律実行） |
| Web調査項目の整理 | 不要（AI自律実行） |
| BA価値分析の生成 | 不要（AI自律実行） |
| 営業文の生成・自己レビュー | 不要（AI自律実行） |
| **承認キューへの登録** | **不要（AIが起案する行為）** |
| **実際の営業送信** | **必須（オーナー承認後のみ）** |

**絶対規則：** 承認なき送信は禁止。Phase 1では送信機能を持たない。承認は将来の Phase 2（n8n接続後）に接続する。

---

## 依存関係

```
PHOSARA_AI_COMPANY_OS_v1.md（承認方針・状態機械）
└── PHOSARA_AI_SALES_RUNTIME_v1.md（運転仕様・フロー定義）
    └── PHOSARA_AI_SALES_AGENT_v1.md（職務・KPI）
        └── phase1-sales-mvp/（このディレクトリ）
            ├── 参照: SALES_TARGET_LIST_TOCHIGI_v1.md
            ├── 参照: SALES_EXECUTION_TOOLKIT.md
            └── 参照: SALES_LOG_STANDARD.md
```

---

## 更新ルール

| 対象 | ルール |
|---|---|
| `SALES_MVP_WORKFLOW.md` | Runtime の改版または実測による改善時のみ更新 |
| `OWNER_APPROVAL_QUEUE.md` | Sales AI MVP 実行のたびに追記（上書き禁止） |
| `SALES_MVP_LOG.md` | Sales AI MVP 実行のたびに追記（上書き禁止） |
| `CONFLICT_LOG.md` | 仕様の矛盾・未定義を発見したときに追記 |
| `DAILY_SALES_REPORT_TEMPLATE.md` | フォーマット変更のみ（内容の記入はテンプレートを別ファイルにコピーして使う） |

---

## Phase 1完了条件チェックリスト

- [ ] `SALES_MVP_WORKFLOW.md` に従ってStep 1–9が実行できる
- [ ] `OWNER_APPROVAL_QUEUE.md` にエントリが書き込める
- [ ] `SALES_MVP_LOG.md` に記録が残せる
- [ ] 承認・差戻しフローが機能する（`WAITING_APPROVAL` → `NEW`/`EXECUTING`）
- [ ] `CONFLICT_LOG.md` に矛盾がない、または矛盾が記録されている
- [ ] Sales Runtime v1.0 との矛盾が存在しない
