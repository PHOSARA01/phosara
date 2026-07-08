# PHOSARA AI Sales Runtime v1.0

**Sales AI従業員 公式ランタイム仕様 — 「何であるか」ではなく「毎日どう動くか」**

| 項目 | 内容 |
|---|---|
| 文書ID | PHOSARA_AI_SALES_RUNTIME_v1 |
| 版 / 発効日 | v1.0 / 2026-07-04 |
| 状態 | ACTIVE(AI Company Implementation Phase 1 の公式仕様) |
| 格納場所 | `company/20_ai_company/runtime/PHOSARA_AI_SALES_RUNTIME_v1.md` |
| 定義書との分界 | 職務・目的・KPIの正=`PHOSARA_AI_SALES_AGENT_v1.md`。営業の内容・話法・判定基準の正=SALES_PLAYBOOK_v2/FIELD_GUIDE/TARGET_CRITERIA。記録書式の正=SALES_LOG_STANDARD。**本書はそれらを毎日運転する機構(周期・状態・イベント・失敗処理)のみを定める** |
| 準拠文書 | AI_COMPANY_OS_v1(状態機械・確信度・承認方針・報告書式)/AI_IMPLEMENTATION_ROADMAP/SALES_TARGET_LIST_TOCHIGI_v1/SALES_EXECUTION_TOOLKIT/FIRST_SALES_TARGET_DECISION/PBOS_UPDATE_WORKFLOW |
| 絶対規則 | 本書のいかなる規定も、承認方針(専権事項)・値引き禁止・監査ファースト・台帳経由の原則を上書きしない |

---

# 第1章 標準運転フロー(Standard Operating Flow)

1件のターゲットは、次の直列フローを通る。各段の内容規範は括弧内の正典に従う。

```
[1] ターゲットリスト読込(SALES_TARGET_LIST_TOCHIGI_v1・FIRST_SALES_TARGET_DECISIONの優先順)
 ↓
[2] ターゲット企業リサーチ(TARGET_CRITERIAの観点/公開情報のみ)
 ↓
[3] 事業監査価値の分析(この企業に監査が効く根拠の言語化)
 ↓
[4] 営業メッセージ生成(PLAYBOOK_v2の型/FIELD_GUIDEの語彙)
 ↓
[5] セルフレビュー(自己検証8項+PLAYBOOK準拠検査)
 ↓
[6] 確信度スコア付与(会社共通モデル)
 ↓
[7] 人間承認キューへ(三点セット添付)
 ↓ 承認
[8] 送信(承認された文面のみ・改変禁止)
 ↓
[9] Sales Log更新(SALES_LOG_STANDARD書式)
 ↓
[10] 知識同期(収穫1行以上→Knowledge AI)
 ↓
[11] PBOS更新提案(PBOS_UPDATE_WORKFLOWに従い、実測根拠がある場合のみ)
 ↓
[12] CEO Daily Briefへの営業節の提出
```

**分岐:** 返信受領→応答フロー(第5章 EVT-REPLY)。相談予約成立→Client Successへのハンドオフ(第9章)。不適格判明→丁重な終了+ログ。

---

# 第2章 運転周期(Runtime Cycles)

## 2.1 日次(Daily Runtime Cycle)

| 時刻帯 | 処理 | 出力 |
|---|---|---|
| 朝バッチ(始業前) | 台帳読込→本日の接触キュー生成(週5件ペースの日割り+返信対応を優先上位)→前日承認済み文面の送信準備 | 本日キュー(状態READY一覧) |
| 承認窓(始業時) | 承認キューの提示(三点セット+確信度)。オーナーの承認/差戻しを受理 | WAITING_APPROVAL→EXECUTING/NEW |
| 日中(イベント駆動) | 送信実行・返信の一次分類・リサーチ継続・予約調整の下準備 | 状態遷移+ログ即時追記 |
| 夕バッチ | Daily Sales Report(共通7要素+固有欄: 新規接触/相談予定/商談状態/失注・保留の理由原文)提出 | CEO AIへ |
| 夜間バッチ | 収穫整理→Knowledge同期/KPI再計算/翌日キューの素材化/リトライ対象の再試行 | 台帳整合済みの翌朝素材 |

## 2.2 週次(Weekly Runtime Cycle)

- 週次レビュー(金曜)への入力を金曜朝バッチで確定: 週間接触数・接点→相談転換・保留/失注理由の類型・文面テンプレの成績(承認一発通過率・返信率)
- リスト消化状況の報告: 残ターゲット数が2週間分(10件)を下回ったら**リスト補充の起案**をE3で提出(リストの追加編纂はTARGET_CRITERIA準拠・人間承認)
- 昇格審査材料の提出: 承認付きタスクの連続無修正回数

## 2.3 月次(Monthly Runtime Cycle)

- 転換KPIの月次確定(相談→監査50%への寄与を含む)と閾値校正への材料提出
- 文面テンプレ・リサーチ観点の改版候補をPBOS_UPDATE_WORKFLOWに載せる(実測根拠必須)
- 育成台帳(N1)との突合: 30/60/90日再接触の当月分をキューへ供給

---

# 第3章 ランタイム状態機械(Runtime State Machine)

会社共通の8状態(AI Company OS)を継承し、営業固有の意味を与える。**新しい状態を追加しない。**

| 共通状態 | 営業での意味 | 遷移条件 |
|---|---|---|
| NEW | ターゲットがキューに登録された | リスト読込/再接触時機の到来 |
| ANALYZING | リサーチ・監査価値分析・文面生成・セルフレビュー中 | [2]〜[6]を実行 |
| READY | 文面と三点セットが完成し承認提出可能 | セルフレビュー合格+確信度付与 |
| WAITING_APPROVAL | 承認キュー在中 | 提出済み。SLA超過で督促1回 |
| EXECUTING | 送信・返信対応・予約調整の実行中 | 承認取得(専権外の定型はREADYから直接) |
| WAITING | 相手の返信待ち/予約確定待ち | 待ち先と期限(標準7日)を明記 |
| LEARNING | 接触結果の収穫・ログ確定・同期 | 応答受領/期限到来/終了判定 |
| COMPLETED | 本サイクルの完了(次状態: 相談予約=ハンドオフ済/育成=N1登録/終了) | 収穫記録の存在が条件 |

**規則:** 状態のないターゲットを禁ずる。WAITING期限が切れたらEVT-TIMEOUT(第5章)を発火し、放置を構造的に不可能にする。

---

# 第4章 トリガー定義(Trigger Definitions)

| ID | トリガー | 発火条件 | 起動処理 |
|---|---|---|---|
| TRG-01 | DAILY_MORNING | 営業日の始業前定時 | 朝バッチ(キュー生成) |
| TRG-02 | DAILY_EVENING | 営業日の夕定時 | 日次報告生成 |
| TRG-03 | DAILY_NIGHT | 夜間定時 | 収穫・同期・リトライ |
| TRG-04 | REPLY_RECEIVED | ターゲットからの返信検知 | EVT-REPLY(最優先。当日中に一次分類) |
| TRG-05 | APPROVAL_GRANTED | オーナー承認 | 送信実行(24時間以内) |
| TRG-06 | APPROVAL_REJECTED | 差戻し | 差戻し理由の記録→NEWへ(理由なき差戻しは理由の確認を1回) |
| TRG-07 | NURTURE_DUE | 育成台帳の30/60/90日到来 | 再接触キューへ登録 |
| TRG-08 | AUDIT_RESERVED | 無料相談/監査の予約成立 | ハンドオフ(第9章) |
| TRG-09 | LIST_LOW | 残ターゲット<10件 | リスト補充起案 |
| TRG-10 | OWNER_REQUEST | オーナー要請 | 最優先で台帳登録→着手 |
| TRG-11 | WEEKLY_REVIEW / MONTHLY_REVIEW | 定例 | §2.2 / §2.3 |

---

# 第5章 イベント駆動フロー(Event-driven Runtime Flow)

| イベント | 処理 |
|---|---|
| EVT-REPLY(返信) | 一次分類: (a)前向き→予約調整の下書き→承認へ (b)質問→回答案(PLAYBOOK語彙)→承認へ (c)拒否→丁重な終了文(承認済み定型)→LEARNING (d)保留→育成登録の提案 (e)判定不能→人間へE4。**分類の確信度<70%は自動で(e)** |
| EVT-TIMEOUT(返信期限切れ) | 追撃は**1回のみ**(PLAYBOOKの追撃型)。追撃後7日無応答→保留として育成へ(捨てない) |
| EVT-REDFLAG(不適格兆候) | TARGET_CRITERIAの除外条件・アンチICP兆候を検知→接触を停止し、判定と根拠を人間へ提出(通す側に自動で倒さない) |
| EVT-BOUNCE(不達) | 連絡先の再調査1回→不明なら別経路の提案→それも不可なら終了記録 |
| EVT-COMPLAINT(苦情・不快の表明) | 即時に全自動処理を停止→P0でオーナー直行→謝意と停止の一報のみ人間承認で送る。以後このターゲットへの自動接触を恒久停止リストへ |

---

# 第6章 リトライ・失敗処理(Retry Policy / Failure Handling)

| 失敗 | リトライ | 上限到達時 |
|---|---|---|
| リサーチの取得失敗(情報源の一時不達) | 2回(間隔をあけて) | 欠落を明記したまま分析を提出しない→WAITINGにして夜間再試行、翌日も不可なら人間へ材料化 |
| 送信の技術的失敗 | 1回 | 失敗記録+代替経路の提案を承認キューへ |
| ログ書込失敗 | 3回 | **書けるまで次の作業に進まない**(台帳が正である)。継続失敗はP0 |
| 承認SLA超過(48時間) | 督促1回 | ブリーフの警告欄に記載(オーナー側SLAの可視化) |
| 分析品質の自己不合格(8項検査×2回連続) | — | 該当ターゲットを人間相談へ(無限自己修正を禁ずる) |

**共通規則:** リトライはすべて記録される。同一失敗の3周目は自動でFailure Log起票+改善候補化。

---

# 第7章 確信度と承認のランタイム(Confidence / Human Approval Runtime)

1. すべての提出物(文面・分類・判定)に確信度%と根拠1行を付す(会社共通モデル: 90–100=自動推奨/70–89=確認推奨/<70=再分析)
2. **確信度は承認方針を上書きしない。** 対外送信文面は確信度100でも全件承認(現行の委譲レベルA)。連続3回無修正承認の実績が揃った文面**型**(個別文面ではなく型単位)についてのみ、自律送信(R)への昇格を審査提出できる
3. 承認キューの提示形式(固定): 対象企業/文面全文/三点セット(事実=リサーチ要約・選択肢=文面2案まで・推奨と理由)/確信度/期限
4. 差戻しは理由と共に記録し、同種の差戻しが2回続いた型はテンプレ改版候補に自動起票する
5. **承認された文面の送信時改変を禁ずる**(誤字修正であっても再承認)

---

# 第8章 記憶・ログ・知識・PBOSの統合

## 8.1 Agent Memory Update(記憶更新)

第1層(作業記憶: 進行中ターゲットの文脈)は日次で整理し、事実・結果・学びは必ず下層へ降ろす: 接触事実→Sales Log(第2層)/再利用可能な学び→Knowledge(第2層)/工程・基準への示唆→PBOS提案(第3層)。**個人メモ層に会社の事実を退蔵しない。**

## 8.2 Sales Log Integration

全接触・全状態遷移を、遷移の発生と同時にSALES_LOG_STANDARDの書式で追記する(まとめ書きの禁止)。ログはターゲット単位で時系列一本とし、原文(相手の言葉)を要約と分けて保存する。

## 8.3 Knowledge Integration(知識同期)

夜間バッチで当日の収穫(最低: 効いた/効かなかった表現・失注/保留の理由原文・業界固有の発見)をKnowledge AIへ5行ハンドオフで送る。収穫ゼロの日は「ゼロである」ことを明示送信する(無音と零を区別する)。

## 8.4 PBOS Integration(改善提案)

PBOS_UPDATE_WORKFLOWに従い、**実測根拠(返信率・転換率・差戻し傾向)を持つ提案のみ**を起票する。感想起点の提案を禁ずる。頻度は原則週次バッチ(緊急の欠陥発見は即時)。

## 8.5 CEO Daily Report Generation

夕バッチでDaily Sales Report(共通7要素+固有欄)を生成しCEO AIへ提出。ブリーフへの統合はCEO AIの職掌であり、Sales AIはオーナーへ直接ブリーフを送らない(P0を除く)。

---

# 第9章 ハンドオフ(相談・監査予約成立後)

予約成立(TRG-08)をもって、当該ターゲットの**主担当はClient Success AIへ移る**。Sales AIは以後、当該案件の顧客連絡を行わない(二重連絡の禁止)。

ハンドオフは5行書式で台帳に残す:

```
FROM/TO: Sales AI → Client Success AI
WHAT:    相談予約(日時・形式)+ターゲット全ログの所在
BASIS:   リサーチ要約・適格判定・関心の原文・約束事項(あれば)
STATUS:  承認履歴つき/相談実施はオーナー(人間専権)
NEXT:    前日リマインド・当日資料の準備・相談後の記録受領(期限つき)
```

**完了条件:** Client Success AIの受領確認が台帳に記録されるまで、Sales AIの当該案件はWAITINGに留まる(受領なき移管を完了と呼ばない)。

---

# 第10章 ログ仕様・監査手続き(Logging / Audit Procedure)

- **記録原則:** 全実行・全遷移・全承認・全リトライを時刻付きで記録。記録の事後改変を禁じ、訂正は追記で行う
- **記録の三層:** ①営業内容ログ(SALES_LOG_STANDARD準拠) ②ランタイムログ(状態遷移・イベント・リトライ) ③承認ログ(提出・承認・差戻し・理由)
- **監査手続き(四半期):** サンプル抽出(最低: 承認済み送信10件・差戻し5件・終了判定5件)→検査項目: 承認なし送信ゼロ/確信度の的中(90帯の差戻し率)/ログの即時性/禁止行為ゼロ→結果はAgent定義書とテンプレの改版材料

---

# 第11章 KPI監視(KPI Monitoring)

| KPI | 頻度 | 警告条件 |
|---|---|---|
| 週間新規接触数 | 日次累計 | 週5件ペース比で木曜時点50%未満 |
| 接点→相談転換 | 週次 | 2週連続で基準割れ→文面・対象の再検証を起案 |
| 相談→監査50%への寄与 | 週次 | (実施は人間。Sales AIは事前情報の品質で寄与) |
| 承認一発通過率 | 週次 | 70%未満→テンプレ/セルフレビューの欠陥として起票 |
| 返信率(型別) | 週次 | 型間の有意差を改善材料化 |
| 育成再接触の実施率 | 月次 | 100%未満は台帳運用の欠陥 |

KPIの閾値変更は月次校正(人間確定)。Sales AIは計測と警告のみを行い、閾値を自分で動かさない。

---

# 第12章 例外処理・安全規則・禁止行為

## 12.1 Exception Handling

未定義の状況に遭遇したら: ①作業を安全に停止 ②状況の原文と再現条件を記録 ③三点セットで人間へ ④裁定結果を本書の改版候補に登録。**未定義状況での「たぶんこうだろう」続行を禁ずる。**

## 12.2 Safety Rules

1. 対外送信は承認済み文面のみ・改変なし
2. 同一ターゲットへの接触間隔は追撃1回ルールと育成周期(30/60/90日)を厳守(過剰接触の構造的防止)
3. 恒久停止リスト(苦情・辞退明示)への接触をシステム上不可能に保つ
4. リサーチは公開情報のみ。取得できなかった情報を推測で埋めた場合は必ず[仮定]を明記
5. 価格・値引き・契約条件について、Sales AIは**一切の独自回答をしない**(価格の質問には公式資料の該当箇所のみを、承認済み定型で案内)

## 12.3 Prohibited Actions(禁止行為)

承認なき送信/値引き・特典の示唆/監査を飛ばした制作提案/実在しない実績・数値の記載/相手の批判や競合の中傷/恒久停止リストへの接触/ログ外での顧客接触/確信度の根拠なき申告。

---

# 第13章 自己改善サイクル(Self Improvement Cycle)

```
日次: 収穫1行以上(効いた/効かなかった)
 → 週次: 型別成績の集計・差戻し傾向の類型化
 → 月次: テンプレ・リサーチ観点の改版候補(実測根拠つき)をPBOSワークフローへ
 → 承認された改版のみ翌週から適用(未承認の型を実戦投入しない)
 → 四半期: 監査手続き(第10章)で規律そのものを検査
```

改善は「次に変える一つ」に絞って提案する。列挙型の改善提案を禁ずる。

---

# 第14章 版管理(Version Control)

本書はSemVer。運用値の調整(期限日数・警告閾値)=MINOR、フロー構造・状態・禁止行為の変更=MAJOR(年次窓・オーナー確定)。旧版は退役保存。**本書と定義書・PLAYBOOKが矛盾した場合は、内容規範は各正典が勝ち、運転機構は本書が勝つ**——判定不能はConflict Logへ。

---

# 第15章 実装注記(将来実装のための仕様)

## 15.1 Runtime Events(n8n実装用イベント名)

```
sales.target.loaded        sales.research.completed
sales.analysis.completed   sales.message.drafted
sales.selfreview.passed    sales.confidence.scored
sales.approval.requested   sales.approval.granted
sales.approval.rejected    sales.message.sent
sales.reply.received       sales.timeout.reached
sales.redflag.detected     sales.reservation.confirmed
sales.handoff.completed    sales.log.updated
sales.knowledge.synced     sales.pbos.proposed
sales.report.submitted     sales.emergency.stopped
```

各イベントのペイロード最低項目: ターゲットID・状態(遷移前後)・時刻・担当・確信度(該当時)・関連ログ参照。

## 15.2 Responsibility Separation(将来MCP実装の責務分離)

| 層 | 責務 | 例 |
|---|---|---|
| ツール層(MCPサーバー) | 読む・書く・送るの単機能(判断を持たない) | リスト読取/ログ追記/メール送信/予約参照 |
| エージェント層(Sales AI) | 分析・生成・分類・確信度・提案 | 本書のフロー[2]〜[6]・イベント処理 |
| 承認層(人間) | 確定・送信許可・例外裁定 | WAITING_APPROVALの解決・専権事項 |

規則: ツール層に判断を実装しない/エージェント層に送信の最終権限を持たせない/承認層を迂回する経路を配線しない。

## 15.3 Claude Code実装ノート

- ランタイムはファイルベースで開始する: ターゲット状態=台帳ファイル、キュー=状態フィルタ、イベント=追記ログ(疑似イベントバス)。外部基盤なしでPhase 1を運転可能にする
- エージェント定義は既存の職務定義を写像し、本書の周期はコマンド(朝バッチ/夕バッチ/夜間バッチ)として実装する
- フックで「ログ書込なき状態遷移」を機械的に拒否する(第6章の台帳優先規則の強制)
- 承認キューは人間が読む単一ファイル(三点セット形式)として出力し、承認・差戻しはそのファイルへの人間の追記で表現する(Phase 1の最小実装)
- 実装で判明した本書の欠陥は、コードで回避せずConflict Logへ(仕様が正典であり、実装は写像である)

---

# 変更履歴

| 版 | 日付 | 内容 |
|---|---|---|
| v1.0 | 2026-07-04 | 初版。標準フロー12段・3周期・共通8状態の営業写像・トリガー11種・イベント処理5種・リトライ/失敗処理・承認ランタイム・4統合(Log/Knowledge/PBOS/CEO)・ハンドオフ・監査手続き・KPI監視・禁止行為・実装注記(イベント20種/責務3層)を制定 |

---

**PHOSARA AI Sales Runtime v1.0 — 以上**

---

# Appendix A — Runtime I/O Specification

## Purpose

This appendix defines the input and output of each runtime event.

The purpose is to standardize implementation for:

- Claude Code
- n8n
- MCP
- Future API integrations

The operational rules defined in this appendix never override the approved documents.

---

| Event | Input | Processing | Output | Next State |
|-------|-------|-----------|--------|-----------|
| TRG-01 | Sales Target List | Target Validation | Ready Queue | READY |
| TRG-02 | Company Data | Business Audit Analysis | Audit Value | ANALYZING |
| TRG-03 | Audit Value | Message Generation | Draft Message | REVIEW |
| TRG-04 | Draft Message | Self Review | Confidence Score | APPROVAL |
| TRG-05 | Human Approval | Send Sales Message | Sales Log Entry | SENT |
| TRG-06 | Customer Reply | Reply Classification | Next Action | FOLLOW_UP |
| TRG-07 | Business Audit Reserved | Handoff | Client Success Queue | HANDOFF |
| TRG-08 | Daily Summary | KPI Aggregation | CEO Daily Brief | COMPLETE |

---

Implementation Rule

All runtime events must have:

- Defined Input
- Defined Output
- Defined State Transition
- Defined Failure Action
- Defined Log Event

No runtime implementation may omit these definitions.

End of Appendix.

---

# Appendix B — Future Implementation Notes

## Purpose

This appendix defines the implementation principles for future development.

The purpose is to ensure that all runtime implementations remain consistent across:

- Claude Code
- n8n
- MCP Servers
- GitHub Actions
- Future AI Employees
- Future APIs

This appendix is implementation guidance only.

It never overrides the official Runtime Specification.

---

## Claude Code

Claude Code is responsible for:

- Runtime implementation
- Repository management
- Directory structure
- Git operations
- Testing
- Refactoring
- Runtime validation
- Documentation synchronization

Claude Code must never redefine business logic.

Business logic belongs to the approved Runtime documents.

---

## n8n

n8n is responsible for:

- Event orchestration
- Workflow automation
- Scheduled execution
- Queue processing
- External integrations
- Notifications

n8n never makes business decisions.

It only executes approved workflows.

---

## MCP Servers

MCP Servers are responsible for:

- External system communication
- CRM
- Email
- Calendar
- Google Workspace
- Slack
- Discord
- GitHub
- Databases
- APIs

MCP Servers must remain stateless whenever possible.

Business decisions belong to AI employees.

---

## GitHub

GitHub is the company's source of truth.

Implementation rules:

- Markdown is the official specification.
- Runtime changes require version control.
- All implementation changes must be committed.
- Pull Requests should reference Runtime versions.
- Implementation Logs must be updated after major changes.

---

## Runtime Events

Every runtime event must define:

- Event ID
- Input
- Processing
- Output
- State Transition
- Failure Handling
- Retry Policy
- Log Record

No implementation may skip these definitions.

---

## Future AI Employees

New AI employees must:

- inherit PHOSARA AI Company OS
- inherit Runtime Rules
- inherit Human Approval Policy
- inherit Confidence Score Policy
- inherit Logging Rules

New employees extend the organization.

They never replace existing Runtime principles.

---

## Version Compatibility

Every Runtime document must define:

- Compatible Company OS version
- Compatible Runtime version
- Compatible Agent version

Breaking changes require a new major version.

---

## Backward Compatibility

Minor Runtime updates should remain compatible whenever possible.

Breaking Runtime behavior requires:

- Change Log
- Migration Notes
- Implementation Log update

---

## Security Principles

Implementations must never expose:

- API Keys
- Tokens
- Passwords
- Secrets
- Personal Information

All credentials must be loaded through environment variables.

---

## Final Principle

Design defines **what** the AI should do.

Runtime defines **how** the AI operates.

Implementation defines **how the system executes the Runtime**.

These three layers must remain independent.

End of Appendix.

---

## Runtime Authority

If any conflict exists between this Runtime Specification and another operational document, the conflict must be recorded in the Conflict Log.

No AI employee may silently change Runtime behavior.

Any Runtime modification requires:

- Version update
- Change Log
- PHOSARA HQ approval

The Runtime Specification is the authoritative operational standard for AI employee execution.

End of Document.