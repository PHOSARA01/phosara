# PHOSARA Owner Decision Register v1.0

**PHOSARA全体の正式なOwner Decisionを一元管理する正典台帳候補**

## Document Metadata

| Metadata | Value |
|---|---|
| Document ID | PHOSARA_OWNER_DECISION_REGISTER_v1_0 |
| Document Name | PHOSARA Owner Decision Register v1.0 |
| Version | v1.0 |
| Status | DRAFT-FOR-ADOPTION |
| Owner | PHOSARA HQ Owner |
| Approver | Pending Owner Approval |
| Created Date | 2026-07-15 |
| Last Updated | 2026-07-17 |
| Effective Date | Not Effective |
| Canonical Path | `company/00_governance/PHOSARA_OWNER_DECISION_REGISTER_v1_0.md` |
| Supersedes | None |
| Approval Requirement | Owner Approval Required |

本書は完成した正式採用候補であるが、現時点では未発効である。正式採用後、Owner Decision Registerの領域別SSOTとなる。

# 1. Purpose

本書は、PHOSARA全体の正式なOwner Decisionを一元管理し、次の問いへ一意に回答できる状態を作るための台帳である。

- 何が決定されたか
- いつ決定され、いつ発効したか
- 誰が承認したか
- どの文書と正規パスを根拠とするか
- 何を置換し、何によって置換されたか
- Human Approvalが成立しているか

本書は新しいDecisionを創作または承認する文書ではない。各文書に存在するDecision Recordおよび明示的なOwner Decisionを、証拠と一致する範囲で登録する台帳である。

# 2. Scope

## 2.1 Managed Domains

本書は、最低限次の領域に関するOwner Decisionを管理する。

- Governance
- Company OS
- HQ Core
- Pricing
- Contract
- Sales
- PBOS
- AI Company
- Website
- Repository

必要に応じ、Service、Business Audit、Client Success、Knowledge、Customer Caseおよびその他の領域を追加してよい（MAY）。ただし、登録条件を満たさない記録をDecisionとして追加してはならない（MUST NOT）。

## 2.2 In Scope

- Canonical Governanceの採用、改版、置換、退役
- 文書のACTIVE化、DEPRECATED化、ARCHIVED化
- MAJOR改版
- 価格、契約、ブランド核、権限、組織、サービス体系の決定
- Canonical Hierarchyおよび正規パスの決定
- Repository全体へ影響する運用方針
- Human Approvalを必要とする不可逆または重大な決定

## 2.3 Out of Scope

- 日常的なType 2判断
- 作業ログ、状態遷移、下書き、提案のみの記録
- 未承認Draftの内容
- 実装されたという事実だけから推定した決定
- ArchiveまたはLegacyにしか根拠がない現行判断
- 顧客案件内だけで成立する通常の業務記録

# 3. Authority and Definitions

## 3.1 Governance Position

本書は、正式採用後にOwner Decisionの登録、検索、置換関係および監査証跡を管理する領域別SSOTとなる。本書は、登録対象となる各Decisionの原文、Decision RecordまたはOwner Instructionを置き換えない。

本書は、`company/00_governance/PHOSARA_REPOSITORY_GOVERNANCE_MAP_v1_0.md`の階層および領域別SSOT分界と矛盾してはならない（MUST NOT）。同文書は現時点でDRAFT-FOR-ADOPTIONであり、未発効である。

## 3.2 Normative Keywords

| Keyword | 意味 |
|---|---|
| MUST | 必ず実施しなければならない。例外には明示的なHuman Approvalを要する |
| MUST NOT | 実施してはならない。黙示的な例外を認めない |
| SHOULD | 原則として実施すべき。実施しない場合は理由を記録する |
| SHOULD NOT | 原則として実施すべきでない。実施する場合は理由を記録する |
| MAY | 条件を満たす場合に実施してよい。義務ではない |

## 3.3 Definitions

| 用語 | 定義 |
|---|---|
| Owner Decision | PHOSARA HQ Ownerが対象と決定内容を明示して承認した正式決定 |
| Decision Record | 個別文書内で、決定ID、状態、日付、承認者、理由等を記録する一次記録 |
| Decision Register | 複数文書に分散するOwner Decisionを横断管理する本台帳 |
| Canonical Document | Decisionの内容または採用結果を保持する正式文書 |
| Human Approval | 権限を持つ人間が、対象と操作を明示して与える承認 |
| Supersedes | 当該Decisionが正式に置換する旧Decisionまたは旧文書 |
| Superseded By | 当該Decisionを正式に置換した後続Decision |
| Effective | 承認済みDecisionが発効日を迎え、現在適用される状態 |

## 3.4 Reference Documents

| 文書 | パス | 用途 |
|---|---|---|
| AI共通作業基準 | `CLAUDE.md` | セッション入口と行動基準 |
| HQ資産索引 | `company/INDEX.md` | company資産の参照起点 |
| Codex Workflow Standard | `company/00_governance/CODEX_WORKFLOW_STANDARD_v1_0.md` | 作業、Validation、Completion Report |
| PHOSARA Document Standard | `company/00_governance/PHOSARA_DOCUMENT_STANDARD_v1_0.md` | Metadata、Decision Record、文書状態 |
| Repository Governance Map | `company/00_governance/PHOSARA_REPOSITORY_GOVERNANCE_MAP_v1_0.md` | DRAFT。階層・SSOT・競合解決候補 |
| Master Context | `docs/00_ブランド基盤/PHOSARA_MASTER_CONTEXT_v1.0_JP_日本語版.md` | ブランドSSOT |
| Company OS v2.0 | `company/02_company-os/PHOSARA_COMPANY_OS_v2_0.md` | 会社憲法 |
| HQ Core v1.0 | `company/01_hq-core/PHOSARA_HQ_CORE_v1_0.md` | 判断・優先順位・接続のSSOT |

# 4. Decision Lifecycle

Decisionは次のLifecycleで管理する。

```text
Draft
  ↓ 登録候補作成
Pending Review
  ↓ Human Approval
Approved
  ↓ Effective Date到来
Effective
  ↓ 後続Decisionによる置換
Superseded
  ↓ 履歴保存
Archived
```

| Lifecycle State | 意味 | Register上の扱い |
|---|---|---|
| Draft | Decision案。承認されていない | 正式Decision Tableへ登録しない |
| Pending Review | Owner Review待ち | Pending Queueとして分離してよい |
| Approved | Owner Approval成立済み | Decision Tableへ登録できる |
| Effective | 発効済み | 現行Decisionとして使用できる |
| Superseded | 後続Decisionが権威を引き継いだ | 履歴保持し、後続IDを記録する |
| Archived | 現行利用を終了し履歴保存する | 削除せず監査可能性を維持する |

ApprovedとEffectiveは異なる。将来発効のDecisionはApprovedであっても、Effective Dateより前に現行規則として適用してはならない（MUST NOT）。

# 5. Decision ID Standard

## 5.1 Format

Decision IDは次の形式を使用する。

```text
DR-YYYY-MM-DD-NNN
```

例：`DR-2026-07-15-001`

| 要素 | 定義 |
|---|---|
| `DR` | Owner Decision Recordの固定接頭辞 |
| `YYYY-MM-DD` | Decision Date |
| `NNN` | 同一Decision Date内の3桁連番 |

## 5.2 Numbering Rules

- Decision IDはリポジトリ全体で一意でなければならない（MUST）。
- 同じIDを再利用してはならない（MUST NOT）。
- `NNN`は同一日内で`001`から昇順に採番する（MUST）。
- 欠番は許容する。削除または却下を理由に後続IDを繰り上げてはならない（MUST NOT）。
- Decision Dateが未確定のDraftへ正式IDを割り当ててはならない（MUST NOT）。
- Decision IDはOwnerまたは正式に委任された登録担当が確定する（MUST）。
- 文書内Decision Recordと本台帳のDecision IDは一致しなければならない（MUST）。
- 既存の承認済みDecisionにIDがない場合、推測で遡及採番してはならない（MUST NOT）。`Pending Decision ID Assignment`として別管理する。

# 6. Decision Table

本表には、実在する文書内でDecision ID、承認状態、日付および承認者を直接確認できたDecisionだけを登録する。

| Decision ID | Title | Status | Decision Date | Effective Date | Approver | Owner | Canonical Document | Canonical Path | Supersedes | Superseded By | Related Documents | Human Approval | Summary |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| DR-2026-07-15-001 | CODEX Workflow Standard v1.0正式採用 | Effective | 2026-07-15 | 2026-07-15 | PHOSARA HQ Owner | PHOSARA HQ Owner | CODEX_WORKFLOW_STANDARD_v1_0 | `company/00_governance/CODEX_WORKFLOW_STANDARD_v1_0.md` | None stated | None | `CLAUDE.md`、`company/INDEX.md` | Confirmed | Codexの標準作業、Validation、Completion Report、Git禁止事項およびHuman Approvalを正式採用 |
| DR-2026-07-15-002 | PHOSARAリポジトリのAuthority Hierarchy確定 | Effective | 2026-07-15 | 2026-07-15 | PHOSARA HQ Owner | PHOSARA HQ Owner | PHOSARA_OWNER_DECISION_OQ_001_v1_0 | `company/00_governance/PHOSARA_OWNER_DECISION_OQ_001_v1_0.md` | None stated | None | OQ-001、GI-009、GI-010 | Confirmed | Owner Instruction、Canonical Governance、CLAUDE.md、Tool-Specific Standardの正式優先順位を確定 |
| DR-2026-07-15-003 | PHOSARA Document Standard v1.0正式Decision ID割当 | Effective | 2026-07-15 | 2026-07-15 | PHOSARA HQ Owner | PHOSARA HQ Owner | PHOSARA_DOCUMENT_STANDARD_v1_0 | `company/00_governance/PHOSARA_DOCUMENT_STANDARD_v1_0.md` | None stated | None | OQ-002、GI-014、GI-031、`company/00_governance/PHOSARA_OWNER_DECISION_OQ_002_v1_0.md` | Confirmed | ACTIVEであるPHOSARA_DOCUMENT_STANDARD_v1_0へ正式Decision IDを割り当て、ACTIVE状態を維持 |
| DR-2026-07-15-004 | PHOSARA Decision Status Vocabulary確定 | Effective | 2026-07-15 | 2026-07-15 | PHOSARA HQ Owner | PHOSARA HQ Owner | PHOSARA_OWNER_DECISION_OQ_003_v1_0 | `company/00_governance/PHOSARA_OWNER_DECISION_OQ_003_v1_0.md` | None stated | None | OQ-003、GI-012、GI-032、GI-033 | Confirmed | Decision Statusの正式5値とDocument Status、Approver Placeholder、Effective Date Sentinel、Resolution Statusの分界を確定 |
| DR-2026-07-15-005 | Governance DRAFT文書のINDEX登録方針確定 | Effective | 2026-07-15 | 2026-07-15 | PHOSARA HQ Owner | PHOSARA HQ Owner | PHOSARA_OWNER_DECISION_OQ_004_v1_0 | `company/00_governance/PHOSARA_OWNER_DECISION_OQ_004_v1_0.md` | None stated | None | OQ-004、GI-029 | Confirmed | Governance DRAFT候補を必須状態情報および現行SSOTではない旨とともにINDEX登録する方針を確定 |
| DR-2026-07-15-006 | PHOSARA Git Governance Policy確定 | Effective | 2026-07-15 | 2026-07-15 | PHOSARA HQ Owner | PHOSARA HQ Owner | PHOSARA_OWNER_DECISION_OQ_005_v1_0 | `company/00_governance/PHOSARA_OWNER_DECISION_OQ_005_v1_0.md` | None stated | None | OQ-005、GI-024 | Confirmed | mainを唯一の長期Branchとし、短命Branch、Pull Request原則必須、操作別Human ApprovalおよびRevert優先Rollbackを用いるGit運用方針を確定 |
| DR-2026-07-17-001 | PHOSARA Service Catalog v1.0正式採択 | Effective | 2026-07-17 | 2026-07-17 | PHOSARA Owner | PHOSARA HQ Owner | PHOSARA_SERVICE_CATALOG_v1_0 | `company/05_services/PHOSARA_SERVICE_CATALOG_v1_0.md` | None stated | None | `company/INDEX.md`、`company/06_pricing/PHOSARA_PRICING_GOVERNANCE_v1_0.md`、`company/07_contracts/PHOSARA_CONTRACT_SYSTEM_v1_0.md` | Confirmed | LS・CS・FSを正式コード体系としてService CatalogをACTIVE化し、CORE・S・G・M・OP・Pは不採択、Conditional／Futureは昇格せず、WIPを1／1／1／3で確定 |

## 6.1 Approved Decisions Pending Decision ID Assignment

次は、実在文書にAPPROVEDまたは人間承認済みの明示があるが、一意のDecision IDが確定していないため、正式Decision Tableへ未登録とする。

| Document | Path | Verified Evidence | Missing Registration Data | Register Status |
|---|---|---|---|---|
| PHOSARA Company OS v2.0 | `company/02_company-os/PHOSARA_COMPANY_OS_v2_0.md` | ACTIVE、発効日、Type 1として人間承認済みと記載 | Decision ID、承認者の固有表記、標準Decision Record | Pending Decision Record Normalization |

この表への掲載は、新しいDecisionの作成、再承認または遡及採番を意味しない。

## 6.2 Not Registered as Decisions

次は未採用または登録証拠不足のため、正式Decisionとして登録しない。

| Item | Path | Reason |
|---|---|---|
| Repository Governance Map v1.0 | `company/00_governance/PHOSARA_REPOSITORY_GOVERNANCE_MAP_v1_0.md` | DRAFT-FOR-ADOPTION、未発効、Decision Pending |
| Pricing Governance v2.0 | `PHOSARA_PRICING_GOVERNANCE_v2.0.md` | DRAFT候補、未採用、未追跡 |
| 本Decision Register v1.0 | `company/00_governance/PHOSARA_OWNER_DECISION_REGISTER_v1_0.md` | DRAFT-FOR-ADOPTION、未発効、Decision Pending |

# 7. Registration Rules

## 7.1 Add a Decision

Decision Tableへ追加するには、次をすべて満たさなければならない（MUST）。

1. 明示的なOwner Approvalまたは正式な委任承認が存在する
2. Decision IDが一意である
3. Decision DateとEffective Dateを確認できる
4. ApproverとOwnerを確認できる
5. Canonical Documentと実在するCanonical Pathを確認できる
6. Summaryが原文のDecision内容と一致する
7. Supersedes関係を確認済み、または`None stated`と事実に即して記載する
8. 対象文書のDecision Recordと本台帳が一致する
9. 必要なINDEX登録を確認する

実装済み、Git管理済み、更新日が新しい、他文書から参照されているという理由だけで正式Decisionを登録してはならない（MUST NOT）。

## 7.2 Update a Decision

- 誤字、正規パス、関連文書等の非意味的修正は、証拠に基づき更新してよい（MAY）。
- Status、Effective Date、Approver、SupersedesまたはDecision Summaryを変更する場合は、根拠となるOwner Decisionを必要とする（MUST）。
- 過去のDecision内容を無言で書き換えてはならない（MUST NOT）。
- 変更履歴をChange Logへ記録する（MUST）。

## 7.3 Retire a Decision

- Decisionを削除してはならない（MUST NOT）。
- 後続Decisionに置換された場合は`Superseded`へ変更し、`Superseded By`を記録する（MUST）。
- 履歴保存へ移行する場合は、Archive条件と参照可能性を維持する（MUST）。

# 8. Supersession Rules

- 置換は後続Decisionの明示的なOwner Approvalで成立する（MUST）。
- 後続Decisionは`Supersedes`へ旧Decision IDまたは旧文書を記載する（MUST）。
- 旧Decisionは`Superseded By`へ後続Decision IDを記載する（MUST）。
- 置換前のDecision Recordと文書を削除してはならない（MUST NOT）。
- 新文書がDRAFTである間、現行ACTIVE文書を置換してはならない（MUST NOT）。
- Superseded文書は直ちにLegacyまたはArchiveになるとは限らない。移行期間がある場合はDEPRECATEDとして終了条件を記録する。
- Legacyは旧設計または旧実行モデルの役割分類であり、Decision Statusではない。
- Archiveは履歴保存状態であり、現行判断の根拠として使用してはならない（MUST NOT）。
- Copy、Case Copyまたは実装を、明示的なDecisionなしに後継Canonicalとして扱ってはならない（MUST NOT）。

# 9. Human Approval Rules

## 9.1 Owner Approval Required

次はOwner Approvalを必要とする。

- 本Decision Registerの正式採用、ACTIVE化、改版、置換または退役
- Decision IDの正式割当
- Decision Tableへの正式Decision追加
- Decision Statusの変更
- Effective Dateの設定または変更
- Approver、Owner、Summaryの意味的変更
- SupersedesおよびSuperseded Byの確定
- Canonical DocumentまたはCanonical Pathの変更
- 登録済みDecisionの削除に相当する操作

## 9.2 Register Maintenance

AIは、既存証拠の抽出、差分作成、重複検査、パス検査および登録候補の作成を行ってよい（MAY）。AIはOwner ApprovalなしにDecisionを承認済みとして登録してはならない（MUST NOT）。

本台帳の更新承認は、登録対象Decisionそのものの承認を代替しない。対象Decisionと台帳更新の両方について根拠を確認する（MUST）。

# 10. Validation

本書および各更新では、最低限次を検証する。

1. Decision ID重複検査
2. Decision ID形式検査
3. Canonical Path存在確認
4. ACTIVE文書のStatus、Approver、Effective Date、Decision Recordとの整合
5. `company/INDEX.md`または該当正規INDEXとの整合
6. SupersedesとSuperseded Byの双方向整合
7. Document Metadataとの整合
8. Decision DateとDecision ID内日付の整合
9. Decision TableとMachine-Readable Summaryの一致
10. DRAFTが正式Decisionとして登録されていないこと
11. Archive文書を現行Decisionの唯一根拠にしていないこと
12. Markdown見出し、表およびYAML構造の整合
13. 対象外ファイルが変更されていないこと
14. `markdownlint`（実行可能な場合）
15. `git diff --check`
16. `git diff --stat`
17. `git diff --cached --stat`
18. `git status --short`

Validationで不一致を検出した場合は、推測で補完してはならない（MUST NOT）。登録を保留し、ConflictまたはPending Registrationとして記録してOwner Approvalを求める。

# 11. Machine-Readable Summary

```yaml
schema_version: "1.0"
document:
  id: PHOSARA_OWNER_DECISION_REGISTER_v1_0
  name: "PHOSARA Owner Decision Register v1.0"
  version: v1.0
  status: DRAFT-FOR-ADOPTION
  effective: false
  canonical_path: company/00_governance/PHOSARA_OWNER_DECISION_REGISTER_v1_0.md
  owner: PHOSARA HQ Owner
  approver: Pending Owner Approval
  created_date: 2026-07-15
  last_updated: 2026-07-17
  effective_date: Not Effective
  supersedes: null
register:
  decision_id_format: DR-YYYY-MM-DD-NNN
  registered_decision_count: 7
  pending_id_assignment_count: 0
  pending_normalization_count: 1
  registered_decisions:
    - decision_id: DR-2026-07-15-001
      title: "CODEX Workflow Standard v1.0正式採用"
      status: Effective
      decision_date: 2026-07-15
      effective_date: 2026-07-15
      approver: PHOSARA HQ Owner
      owner: PHOSARA HQ Owner
      canonical_document: CODEX_WORKFLOW_STANDARD_v1_0
      canonical_path: company/00_governance/CODEX_WORKFLOW_STANDARD_v1_0.md
      human_approval: Confirmed
    - decision_id: DR-2026-07-15-002
      title: "PHOSARAリポジトリのAuthority Hierarchy確定"
      status: Effective
      decision_date: 2026-07-15
      effective_date: 2026-07-15
      approver: PHOSARA HQ Owner
      owner: PHOSARA HQ Owner
      canonical_document: PHOSARA_OWNER_DECISION_OQ_001_v1_0
      canonical_path: company/00_governance/PHOSARA_OWNER_DECISION_OQ_001_v1_0.md
      related_issues:
        - OQ-001
        - GI-009
        - GI-010
      human_approval: Confirmed
    - decision_id: DR-2026-07-15-003
      title: "PHOSARA Document Standard v1.0正式Decision ID割当"
      status: Effective
      decision_date: 2026-07-15
      effective_date: 2026-07-15
      approver: PHOSARA HQ Owner
      owner: PHOSARA HQ Owner
      canonical_document: PHOSARA_DOCUMENT_STANDARD_v1_0
      canonical_path: company/00_governance/PHOSARA_DOCUMENT_STANDARD_v1_0.md
      decision_path: company/00_governance/PHOSARA_OWNER_DECISION_OQ_002_v1_0.md
      related_issues:
        - OQ-002
        - GI-014
        - GI-031
      human_approval: Confirmed
    - decision_id: DR-2026-07-15-004
      title: "PHOSARA Decision Status Vocabulary確定"
      status: Effective
      decision_date: 2026-07-15
      effective_date: 2026-07-15
      approver: PHOSARA HQ Owner
      owner: PHOSARA HQ Owner
      canonical_document: PHOSARA_OWNER_DECISION_OQ_003_v1_0
      canonical_path: company/00_governance/PHOSARA_OWNER_DECISION_OQ_003_v1_0.md
      related_issues:
        - OQ-003
        - GI-012
        - GI-032
        - GI-033
      human_approval: Confirmed
    - decision_id: DR-2026-07-15-005
      title: "Governance DRAFT文書のINDEX登録方針確定"
      status: Effective
      decision_date: 2026-07-15
      effective_date: 2026-07-15
      approver: PHOSARA HQ Owner
      owner: PHOSARA HQ Owner
      canonical_document: PHOSARA_OWNER_DECISION_OQ_004_v1_0
      canonical_path: company/00_governance/PHOSARA_OWNER_DECISION_OQ_004_v1_0.md
      related_issues:
        - OQ-004
        - GI-029
      human_approval: Confirmed
    - decision_id: DR-2026-07-15-006
      title: "PHOSARA Git Governance Policy確定"
      status: Effective
      decision_date: 2026-07-15
      effective_date: 2026-07-15
      approver: PHOSARA HQ Owner
      owner: PHOSARA HQ Owner
      canonical_document: PHOSARA_OWNER_DECISION_OQ_005_v1_0
      canonical_path: company/00_governance/PHOSARA_OWNER_DECISION_OQ_005_v1_0.md
      related_issues:
        - OQ-005
        - GI-024
      human_approval: Confirmed
    - decision_id: DR-2026-07-17-001
      title: "PHOSARA Service Catalog v1.0正式採択"
      decision_type: CANONICAL_DOCUMENT_ADOPTION
      status: Effective
      decision_date: 2026-07-17
      effective_date: 2026-07-17
      approver: PHOSARA Owner
      owner: PHOSARA HQ Owner
      canonical_document: PHOSARA_SERVICE_CATALOG_v1_0
      canonical_path: company/05_services/PHOSARA_SERVICE_CATALOG_v1_0.md
      decision_summary: "LS・CS・FS体系を正式採択し、Service Catalog v1.0をACTIVEな領域別正典とする"
      adoption_reason: "サービス分類、提供境界、Business Audit Route、単品販売、WIPおよびAI判断基準を一元化し、一サービス一コードで参照できるようにするため"
      adopted_code_system: [LS, CS, FS]
      rejected_code_system: [CORE, S, G, M, OP, P]
      lifecycle_promotions: false
      wip_limits:
        business_audit_concurrent: 1
        website_full_build_concurrent: 1
        ai_business_adoption_sprint_concurrent: 1
        continuous_support_clients_max: 3
      pricing_and_contract_terms_delegated: true
      alternatives_considered:
        - 現行文書に分散したサービス記述を維持する案
        - Pricing Governance内でサービス定義と価格を同時管理する案
        - CORE・S・G・M・OP・P体系を正本コードとして採用する案
      rejected_alternatives_and_reasons:
        - "分散管理案: 重複・競合と参照揺れを残すため却下"
        - "価格文書との統合案: サービス定義と価格統制の責任分界を損なうため却下"
        - "CORE・S・G・M・OP・P体系: LS・CS・FSのLifecycleと一サービス一コードの連続性を損なうため不採択"
      related_documents:
        - company/INDEX.md
        - company/06_pricing/PHOSARA_PRICING_GOVERNANCE_v1_0.md
        - company/07_contracts/PHOSARA_CONTRACT_SYSTEM_v1_0.md
      supersedes: null
      implementation_status: IMPLEMENTED
      human_approval: Confirmed
  pending_registrations:
    - document: PHOSARA_COMPANY_OS_v2_0
      canonical_path: company/02_company-os/PHOSARA_COMPANY_OS_v2_0.md
      reason: Pending Decision Record Normalization
  excluded_drafts:
    - PHOSARA_REPOSITORY_GOVERNANCE_MAP_v1_0
    - PHOSARA_PRICING_GOVERNANCE_v2_0
    - PHOSARA_OWNER_DECISION_REGISTER_v1_0
```

# 12. Decision Record

| 項目 | 内容 |
|---|---|
| Decision ID | Pending |
| Decision Status | Pending Formal Adoption |
| Decision Date | Pending |
| Effective Date | Not Effective |
| Approver | Pending Owner Approval |
| Decision Summary | PHOSARA_OWNER_DECISION_REGISTER_v1_0を、PHOSARA全体の正式なOwner Decisionを一元管理する正典台帳として採用するかを決定する |
| Reason | 分散するDecision Recordを集約し、決定内容、日付、承認者、根拠文書、置換関係および承認状態を一意に確認できるようにするため |
| Alternatives Considered | 各文書内のDecision Recordだけを個別に検索する運用を維持する案 |
| Rejected Alternative | Pending |

# 13. Change Log

| Version | Date | Status | Change |
|---|---|---|---|
| v1.0 | 2026-07-15 | DRAFT-FOR-ADOPTION | Owner DecisionのLifecycle、ID、台帳、登録、置換、Human ApprovalおよびValidationを定義し、証拠を確認できた既存Decisionを初期登録 |
| v1.0 台帳更新 | 2026-07-17 | DRAFT-FOR-ADOPTION | `DR-2026-07-17-001`としてPHOSARA Service Catalog v1.0の正式採択Decisionを登録し、Decision Table、未登録一覧およびMachine-Readable Summaryを同期 |

---

**PHOSARA_OWNER_DECISION_REGISTER_v1_0 — DRAFT-FOR-ADOPTION — NOT EFFECTIVE**
