PHOSARA_AI_IMPLEMENTATION_ROADMAP.md

# PHOSARA AI Implementation Roadmap v1.0
## 基本情報
| 項目 | 内容 |
|---|---|
| ファイル名 | PHOSARA_AI_IMPLEMENTATION_ROADMAP.md |
| 管轄 | PHOSARA HQ |
| 対象 | PHOSARA AI社員実装計画 |
| 目的 | 設計済みAI社員を段階的に実装・検証・改善する |
| 対象AI社員 | Sales / Client Success / Knowledge / PBOS / CEO |
| 前提成果物 | PHOSARA_AI_COMPANY_OS_v1.md |
| 実装方針 | 最小構成から開始し、検証後に拡張 |
| 最重要原則 | Owner Approval Flowを維持する |
---
# 1. Executive Summary
PHOSARAは、設計済みAI社員を一度に完全自動化するのではなく、Claude Code・n8n・MCP・GitHubを段階的に組み合わせ、最小リスクでAI Company運用へ移行する。
初期実装では、Sales Agent・Client Success Agent・Knowledge AgentをMVPとして稼働させ、営業・顧客対応・知識蓄積の流れを先に作る。
その後、PBOS AgentとCEO Agentを接続し、KPI・ROI・Daily CEO Brief・Owner Approval Flowを通じて、AI社員が会社運営を補佐する状態へ発展させる。
---
# 2. 実装原則
## 2.1 基本思想
PHOSARAのAI社員実装は、以下の順番を厳守する。
```text
設計
↓
最小実装
↓
検証
↓
ログ蓄積
↓
改善
↓
自動化範囲拡大

⸻

2.2 実装禁止事項

以下は初期段階では禁止する。

* 完全自動営業送信
* 完全自動契約判断
* 完全自動価格提示
* 顧客への無承認メッセージ送信
* PBOSの無承認上書き
* CEO判断の自動代行
* 個人情報・機密情報の無管理保存

⸻

2.3 Human Approval Policy

AIが実行してよいこと。

* 情報整理
* 下書き作成
* ログ分類
* KPI集計
* ROI分析
* 改善提案
* Daily Brief作成
* Knowledge更新案作成
* PBOS更新案作成

Owner承認が必要なこと。

* 初回営業送信
* Business Audit予約確定
* 提案書送付
* 契約条件提示
* 価格提示
* PBOS正式更新
* 顧客への重要連絡
* 会社方針変更

⸻

3. 全体アーキテクチャ

PHOSARA AI Company
Owner
  ↓
CEO Agent
  ↓
Sales Agent
Client Success Agent
Knowledge Agent
PBOS Agent
  ↓
GitHub
n8n
MCP
Logs
PBOS
Dashboard

⸻

4. Phase 0：実装準備

目的

AI社員を安全に実装するための基盤を整備する。

実装範囲

* GitHub構成整理
* AI社員ディレクトリ作成
* Secrets管理方針
* ログ設計
* 設定管理
* 命名規則
* 承認フロー定義
* 運用ルール整備

推奨ディレクトリ構成

phosara/
├── company/
│   └── 13_ai-company/
│       ├── PHOSARA_AI_COMPANY_OS_v1.md
│       ├── PHOSARA_AI_IMPLEMENTATION_ROADMAP.md
│       ├── agents/
│       │   ├── PHOSARA_AI_SALES_AGENT_v1.md
│       │   ├── PHOSARA_AI_CLIENT_SUCCESS_AGENT_v1.md
│       │   ├── PHOSARA_AI_KNOWLEDGE_AGENT_v1.md
│       │   ├── PHOSARA_AI_PBOS_AGENT_v1.md
│       │   └── PHOSARA_AI_CEO_AGENT_v1.md
│       ├── workflows/
│       ├── logs/
│       ├── prompts/
│       ├── approvals/
│       ├── dashboards/
│       └── archive/

必要ツール

* GitHub
* Claude Code
* Markdown
* .env.example
* GitHub Secrets
* ログテンプレート

前提条件

* 採用済みAI社員設計書がGitHubに保存されている
* PHOSARA_AI_COMPANY_OS_v1.mdの格納場所が確定している
* Owner Approval Flowが文書化されている

完了条件

* AI社員関連ファイルの保存場所が確定
* ログ保存形式が確定
* Secrets管理方針が確定
* 実装対象と非対象が明確
* Claude Codeが参照できる状態になっている

リスク

* ファイルが散らばりAIが参照できない
* Secretsを誤ってGitHubへ公開する
* ログ形式が不統一になり後から分析できない

検証方法

* Claude Codeにディレクトリ全体を読ませ、構造理解できるか確認
* ダミーログを作成し、Sales / CS / Knowledge / PBOS / CEOへ流せるか確認
* .env と .env.example が分離されているか確認

次Phaseへの条件

* GitHub上でAI Company関連ディレクトリが整理済み
* 最小ログテンプレートが作成済み
* Owner Approval Flowが確定済み

⸻

5. Phase 1：Claude Code MVP実装

目的

Sales Agent・Client Success Agent・Knowledge Agentを最小構成で動かし、営業開始後の基本業務をAI支援できる状態にする。

実装範囲

Sales Agent MVP

* 営業対象整理
* 営業文下書き
* 返信分類
* Business Audit誘導案作成
* Sales Log作成

Client Success Agent MVP

* Business Audit予約後案内
* 事前連絡文作成
* リマインド文作成
* Audit後フォロー文作成
* Client Success Log作成

Knowledge Agent MVP

* Sales Log分析
* Client Success Log分析
* 成功パターン抽出
* 失敗パターン抽出
* Knowledge更新案作成

必要ツール

* Claude Code
* GitHub
* Markdown
* PHOSARA営業ログ
* Client Successログ
* Knowledgeログ

前提条件

* 各AI社員設計書が保存済み
* 営業ログ標準が定義済み
* Client Successログ標準が定義済み
* Knowledge保存先が確定済み

完了条件

* Sales Agentが営業文下書きを作成できる
* Client Success Agentがフォロー文を作成できる
* Knowledge Agentがログから改善案を抽出できる
* すべてOwner承認前提で動作する
* GitHubにログが保存される

リスク

* AI営業文がPHOSARAブランドとずれる
* 顧客対応が機械的になる
* ログが増えても活用されない
* 人間承認が曖昧になる

検証方法

* 架空リード3件で営業文を生成
* 架空Business Audit予約でCS文を生成
* 架空営業ログからKnowledge抽出
* Ownerが承認しやすい形式か確認
* 出力品質を100点満点で採点

次Phaseへの条件

* 3件以上の営業シミュレーション完了
* 1件以上のBusiness Audit想定フロー完了
* Knowledge更新案が出力できる
* Ownerが運用可能と判断

⸻

6. Phase 2：n8n連携

目的

Trigger・Workflow・通知・スケジュール・ログ保存をn8nで自動化し、AI社員の起動条件を仕組み化する。

実装範囲

* 毎朝のSales Agent起動
* 営業ログ保存
* 返信発生時の通知
* Business Audit予約通知
* フォローアップ予定通知
* Daily Log生成
* Weekly Review準備

想定Trigger

毎朝 09:00
新規営業リスト追加
Gmail返信受信
Business Audit予約確定
Audit実施後
提案送付後
7日間返信なし
月末

必要ツール

* n8n
* GitHub
* Gmail
* Google Calendar
* Google Drive
* Slackまたはメール通知
* Claude APIまたは外部AI接続

前提条件

* Phase 1のMVPが安定
* ログ保存形式が確定
* 通知先が確定
* Owner承認フローが定義済み

完了条件

* n8nがTriggerを検知できる
* 指定タイミングで通知できる
* ログが自動保存される
* AI出力が承認待ち状態で止まる
* 無承認で顧客送信されない

リスク

* 誤Triggerによる不要実行
* 通知過多
* ログ重複
* 未承認送信
* API制限

検証方法

* ダミーTriggerでWorkflow実行
* Gmail返信想定テスト
* Calendar予定作成テスト
* GitHubログ保存テスト
* Owner承認前で停止するか確認

次Phaseへの条件

* 主要Triggerが安定稼働
* 通知漏れがない
* ログ保存が正確
* Ownerが日常運用できる

⸻

7. Phase 3：MCP連携

目的

Google Calendar・Gmail・Google Drive・Web検索・Business Audit支援をAI社員が安全に利用できる状態にする。

実装範囲

Google Calendar

* Business Audit予定確認
* 空き時間確認
* リマインド起動

Gmail

* 返信検知
* 内容分類
* 下書き作成
* フォロー対象抽出

Google Drive

* 提案書保存
* Audit資料保存
* ログ保存
* テンプレート管理

Web検索

* 企業情報収集
* Webサイト確認
* SNS確認
* 競合調査
* 業界情報取得

Business Audit支援

* 監査対象企業の事前分析
* 課題仮説作成
* 質問案作成
* 改善提案案作成

必要ツール

* MCP
* Gmail MCP
* Google Calendar MCP
* Google Drive MCP
* Web Search MCP
* Claude Code
* n8n

前提条件

* Secrets管理が安全
* Google連携範囲が限定されている
* 顧客情報管理ルールが定義済み
* Owner承認が残っている

完了条件

* Calendar情報を安全に参照できる
* Gmail返信を分類できる
* Driveへ成果物保存できる
* Web検索結果をBusiness Auditへ反映できる
* 顧客送信前に承認待ちになる

リスク

* 権限過多
* 個人情報漏洩
* 誤ったWeb情報の採用
* Google連携エラー
* MCP設定ミス

検証方法

* テスト用Gmailで返信分類
* テスト用Calendarで予定確認
* テスト用Driveフォルダへ保存
* 架空企業でWeb調査
* Auditレポート下書き生成

次Phaseへの条件

* MCP連携が安定
* 権限範囲が適切
* Business Audit支援の品質がOwner基準を満たす
* ログがKnowledgeへ渡せる

⸻

8. Phase 4：PBOS連携

目的

Knowledge AgentとPBOS Agentを接続し、営業・CS・Audit・提案・制作から得た知識を会社資産へ変換する。

実装範囲

* Knowledge同期
* PBOS更新案作成
* ROI分析
* KPI集計
* 成功パターン抽出
* 失敗パターン抽出
* Sales Playbook改善案
* Business Audit改善案
* Client Success改善案

必要ツール

* GitHub
* Claude Code
* Knowledge Agent
* PBOS Agent
* Logs
* KPIシート
* Markdown Database

前提条件

* Phase 1〜3でログが蓄積されている
* Knowledge保存形式が確定
* PBOS更新ルールが確定
* PBOS正式更新はOwner承認制

完了条件

* KnowledgeからPBOS更新案を作成できる
* ROI分析が出力できる
* KPI集計ができる
* 更新対象と保留対象を分類できる
* PBOSへ正式反映する前にOwner承認で止まる

リスク

* 未検証の仮説をPBOSへ入れる
* 成功パターンの誤認
* KPIの集計ミス
* PBOSが肥大化する
* 現場で使えない知識が増える

検証方法

* 営業ログ10件想定で分析
* CSログ5件想定で分析
* Business Audit結果3件想定で分析
* PBOS更新案をOwnerがレビュー
* 使える知識と保留知識を分類

次Phaseへの条件

* PBOS更新案の品質が安定
* KPI集計が実用可能
* ROI分析が意思決定に使える
* CEO Agentへ渡せる要約が生成できる

⸻

9. Phase 5：CEO Dashboard

目的

CEO Agentが会社全体の状況を把握し、Daily CEO Brief・経営KPI・優先順位提案・リスク検知を行える状態にする。

実装範囲

* Daily CEO Brief
* 売上KPI
* 営業KPI
* Business Audit KPI
* 提案KPI
* 契約KPI
* Client Success KPI
* PBOS更新状況
* リスク検知
* 今日のTOP3提案

必要ツール

* CEO Agent
* PBOS Agent
* Knowledge Agent
* GitHub
* n8n
* Dashboard Markdown
* 将来的にBIツール

前提条件

* PBOS Agentが稼働
* KPIログが蓄積
* CEO Agent設計書が保存済み
* Daily Brief形式が定義済み

完了条件

* 毎日CEO Briefを生成できる
* 優先順位TOP3を提示できる
* リスクを検知できる
* Owner Decisionが明確
* 実行タスクと後回しタスクを分けられる

リスク

* CEO Agentが判断を代行しすぎる
* KPI不足で誤提案する
* Daily Briefが長すぎて使われない
* リスク検知が過剰になる

検証方法

* 架空1週間分のログでDaily Brief生成
* TOP3提案の妥当性確認
* リスク検知テスト
* Ownerが5分以内で判断できるか確認

次Phaseへの条件

* Daily CEO Briefが実用レベル
* KPIが意思決定に使える
* Ownerが運用負担を感じない
* AI社員間連携の準備が整う

⸻

10. Phase 6：AI Company運用開始

目的

AI社員間連携・Daily Cycle・Weekly Review・Monthly Review・Owner Approval Flowを運用し、PHOSARAをAI Companyとして稼働させる。

実装範囲

* AI社員間連携
* Daily Cycle
* Weekly Review
* Monthly Review
* Owner Approval Flow
* 部署別レポート統合
* PBOS改善サイクル
* AI社員評価
* Workflow改善

Daily Cycle

朝
CEO AgentがDaily Brief生成
↓
Sales Agentが営業優先順位作成
↓
Client Success Agentがフォロー対象確認
↓
Knowledge Agentが前日ログ分析
↓
PBOS Agentが更新候補整理
↓
Ownerが承認・判断

Weekly Review

* 営業件数
* 返信率
* Business Audit予約数
* 提案数
* 契約数
* 失注理由
* PBOS更新
* AI改善点

Monthly Review

* 売上
* 粗利
* ROI
* 継続率
* 紹介率
* AI稼働効率
* PBOS成長
* 翌月重点施策

必要ツール

* Claude Code
* n8n
* MCP
* GitHub
* Gmail
* Calendar
* Drive
* Dashboard
* 各AI Agent

前提条件

* Phase 0〜5が完了
* AI社員ごとの役割が明確
* Owner Approval Flowが実運用済み
* Dashboardが機能している

完了条件

* Daily Cycleが回る
* Weekly Reviewが出る
* Monthly Reviewが出る
* AI社員ごとのログが残る
* Ownerが最終判断に集中できる
* 営業・CS・Knowledge・PBOS・CEOが接続される

リスク

* AI社員が増えすぎて管理不能になる
* 通知・レポート過多
* 実行より分析が増える
* Owner承認がボトルネックになる
* 売上に直結しない自動化へ逸れる

検証方法

* 1週間の模擬運用
* 実営業ログで運用
* Weekly Review確認
* Owner負担時間測定
* 売上貢献度確認

次Phaseへの条件

* 実案件でAI社員運用が成立
* Ownerの作業時間が削減
* 営業・提案・フォロー品質が安定
* PBOSが継続更新される

⸻

11. 実装優先順位

優先順位	対象	理由
1	Phase 0 実装準備	ここが崩れると全体が崩れる
2	Sales Agent MVP	売上に最も近い
3	Client Success Agent MVP	予約後・提案後の機会損失を防ぐ
4	Knowledge Agent MVP	成功・失敗を資産化する
5	n8n Trigger	手動運用の抜け漏れを減らす
6	MCP連携	外部情報・メール・予定と接続する
7	PBOS Agent	会社資産へ変換する
8	CEO Agent Dashboard	経営判断を支援する
9	AI Company運用	全AI社員を接続する

⸻

12. 60日ロードマップ

Day 1〜7

目的：実装準備完了

* AI Companyディレクトリ整理
* 採用済みAI社員ファイル格納
* ログテンプレート作成
* Owner Approval Flow作成
* Secrets管理方針作成
* Claude Code参照ルール作成

成果物

* /company/13_ai-company/
* logs/
* approvals/
* workflows/
* PHOSARA_AI_IMPLEMENTATION_ROADMAP.md

⸻

Day 8〜14

目的：Sales Agent MVP

* 営業対象整理
* 営業文下書き
* 返信分類
* Sales Log作成
* Owner承認フロー確認

成果物

* Sales Agent MVP
* Sales Log Template
* Sales Approval Flow

⸻

Day 15〜21

目的：Client Success Agent MVP

* 予約後案内
* リマインド
* Audit後フォロー
* 提案後フォロー
* CS Log作成

成果物

* Client Success Agent MVP
* CS Log Template
* Follow-up Template

⸻

Day 22〜30

目的：Knowledge Agent MVP

* Sales Log分析
* CS Log分析
* 成功事例抽出
* 失敗事例抽出
* Knowledge更新案作成

成果物

* Knowledge Agent MVP
* Knowledge Update Template
* Success / Failure Pattern Log

⸻

Day 31〜45

目的：n8n Trigger導入

* 毎朝通知
* フォロー予定通知
* Gmail返信検知
* Calendar予定検知
* ログ保存

成果物

* n8n Basic Workflow
* Trigger Map
* Notification Rule

⸻

Day 46〜60

目的：MCP基礎連携

* Gmail分類
* Calendar確認
* Drive保存
* Web調査
* Business Audit事前支援

成果物

* MCP Basic Connection Plan
* Business Audit Support Flow
* AI社員MVP統合テスト

⸻

13. 90日ロードマップ

Day 61〜75

目的：PBOS Agent接続

* Knowledge同期
* PBOS更新案
* ROI分析
* KPI集計

成果物

* PBOS Update Flow
* ROI Report Template
* KPI Log Template

⸻

Day 76〜90

目的：CEO Agent Dashboard MVP

* Daily CEO Brief
* 今日のTOP3
* リスク検知
* KPI要約
* Owner Decision整理

成果物

* CEO Daily Brief Template
* CEO Dashboard MVP
* Risk Detection Log

⸻

14. 180日ロードマップ

Day 91〜120

目的：AI社員間連携

* Sales → CS → Knowledge連携
* Knowledge → PBOS連携
* PBOS → CEO連携
* CEO → Owner Brief連携

成果物

* Agent Collaboration Map
* Daily Cycle v1
* Weekly Review v1

⸻

Day 121〜150

目的：運用改善

* 実案件ログ反映
* AI出力品質改善
* Workflow改善
* KPI改善
* Owner作業時間削減

成果物

* AI Quality Review
* Workflow Improvement Log
* Owner Time Reduction Report

⸻

Day 151〜180

目的：AI Company運用開始

* Monthly Review
* AI社員評価
* PBOS成長分析
* 継続改善サイクル
* 次期AI社員追加判断

成果物

* Monthly Review Template
* AI Employee Evaluation
* PHOSARA AI Company Operation v1

⸻

15. 成功条件

PHOSARA AI社員実装の成功条件は以下とする。

15.1 60日成功条件

* Sales Agent MVPが稼働
* Client Success Agent MVPが稼働
* Knowledge Agent MVPが稼働
* 営業・フォロー・ログ蓄積が回る
* Owner承認フローが機能する

15.2 90日成功条件

* PBOS AgentがKnowledgeを資産化できる
* CEO AgentがDaily Briefを作成できる
* KPIとROIが確認できる
* Ownerが優先順位判断に使える

15.3 180日成功条件

* AI社員間連携が成立
* Daily / Weekly / Monthly Cycleが回る
* PBOSが継続更新される
* Ownerが経営判断に集中できる
* PHOSARAがAI Companyとして運用開始できる

⸻

16. 最終提言

PHOSARAは、AI社員を一気に完全自動化するべきではない。

最初に実装すべきは、売上に近いSales Agent、顧客体験を守るClient Success Agent、会社学習を担うKnowledge Agentである。

その後、PBOS AgentとCEO Agentを接続し、AIが実行・分析・改善を担い、Ownerが判断・承認・方向性決定を担う体制へ移行する。

⸻

17. CEO Decision

PHOSARA HQは、AI Company OS完成後、直ちにPhase 0へ移行する。

最初の60日間は、完全自動化ではなく、Sales / Client Success / Knowledge のMVP実装に集中する。

90日以内にPBOS AgentとCEO Dashboardを接続し、180日以内にAI Company運用を開始する。

最重要判断基準は常に以下とする。

この実装は、
60日以内の売上、
または将来のPBOS資産を前進させるか？

YESなら実行。

NOなら後回し。

⸻

18. 前提条件・不足情報

前提条件

* PHOSARA_AI_COMPANY_OS_v1.mdは正式採用予定
* Sales / Client Success / Knowledge / PBOS / CEO Agentは正式採用済み
* GitHubをPHOSARAの正式資産管理場所とする
* Claude Codeを初期実装の中心とする
* n8nとMCPは段階導入する
* Owner Approval Flowを維持する

不足情報

* 実際のGitHub最終ディレクトリ
* 使用するn8n環境
* MCP連携範囲
* Gmail / Calendar / Driveの運用アカウント
* Dashboard表示形式
* KPI定義の最終版

今後確定すべき事項

* AI社員ごとのログファイル名
* 各Agentの実行タイミング
* Owner承認画面または承認方法
* PBOS正式更新ルール
* CEO Dashboardの保存場所

# 19. 次アクション
1. PHOSARA_AI_COMPANY_OS_v1.md完成後、内容を本ロードマップと照合する。
2. 差分があれば、Phase 0の前に統合修正する。
3. GitHub上にAI Company専用ディレクトリを作成する。
4. Sales / Client Success / Knowledge AgentからMVP化する。
5. 実装開始前にOwner Approval Flowを必ず確定する。
---
# 20. 結論
PHOSARAは、AI社員設計フェーズから実装フェーズへ移行可能な段階に入っている。
ただし、最初から完全自動化を目指すのではなく、
```text
Claude Code
↓
n8n
↓
MCP
↓
PBOS
↓
CEO Dashboard
↓
AI Company運用

の順番で進める。

最初の実装対象は、

* Sales Agent
* Client Success Agent
* Knowledge Agent

の3つに限定する。

この3つが安定して初めて、

* PBOS Agent
* CEO Agent
* AI Company OS

へ接続する。

## Go / No-Go 判定

次Phaseへ進む条件

□ すべての検証項目をクリア

□ Owner承認済み

□ GitHubへ保存済み

□ ログ取得確認済み

□ 問題が重大でない

すべてYESの場合のみ次Phaseへ進む。

以上をもって、PHOSARA_AI_IMPLEMENTATION_ROADMAP.md の完成版とする。