# PHOSARA Repository Structure

PHOSARA公式GitHubリポジトリの推奨構成です。

```text
phosara/
├── README.md
├── .gitignore
├── docs/
│   ├── 00_brand_foundation/
│   │   ├── master_context/
│   │   ├── brand_book/
│   │   ├── documentation_system/
│   │   ├── wordmark/
│   │   ├── logo/
│   │   └── brand_guidelines/
│   │
│   ├── 01_sales/
│   │   ├── company_guide/
│   │   ├── sales_playbook/
│   │   ├── hearing_sheet/
│   │   ├── proposal_template/
│   │   ├── estimate_template/
│   │   └── contract_template/
│   │
│   ├── 02_consulting/
│   │   ├── design_consulting/
│   │   ├── business_audit/
│   │   ├── design_audit/
│   │   ├── website_audit/
│   │   └── branding_audit/
│   │
│   ├── 03_industry_solutions/
│   │   ├── construction/
│   │   ├── remodeling/
│   │   ├── clinic/
│   │   └── pachinko_hall/
│   │
│   ├── 04_casebook/
│   │   ├── blueprint/
│   │   ├── powerpoint/
│   │   └── html/
│   │
│   ├── 05_design_system/
│   │   ├── website/
│   │   │   ├── PHOSARA_Website_Blueprint_v1.1.md
│   │   │   ├── PHOSARA_Website_Copy_v1.1.md
│   │   │   ├── PHOSARA_Website_Design_System_v2.0.md
│   │   │   ├── PHOSARA_Website_Technical_Guide_v2.0.md
│   │   │   └── PHOSARA_Website_Operations_Guide_v2.0.md
│   │   ├── visual_system/
│   │   ├── prompt/
│   │   └── character/
│   │
│   ├── 06_templates/
│   │   ├── powerpoint/
│   │   ├── word/
│   │   ├── excel/
│   │   └── markdown/
│   │
│   ├── 07_client_deliverables/
│   │   ├── proposals/
│   │   ├── estimates/
│   │   ├── final_data/
│   │   └── clients/
│   │
│   ├── 90_archive/
│   └── 99_old_versions/
│
├── website/
│   ├── src/
│   │   ├── app/
│   │   ├── components/
│   │   ├── layouts/
│   │   ├── styles/
│   │   ├── lib/
│   │   └── content/
│   ├── public/
│   │   ├── images/
│   │   ├── logos/
│   │   └── icons/
│   └── prompts/
│       ├── claude_code/
│       └── ai_agents/
│
└── scripts/
    ├── setup/
    └── automation/
```

## 運用方針

- `docs/` はPHOSARAの公式資料を管理する。
- `website/` は公式サイト実装用のディレクトリとする。
- `website/prompts/` はClaude CodeやAIエージェント用の指示を保存する。
- `90_archive/` は統合・廃止された資料を保存する。
- `99_old_versions/` は旧版を保存する。
- ファイル名は正式名称を維持する。
- フォルダ名はGitHub運用のため英数字・スネークケースを基本とする。
