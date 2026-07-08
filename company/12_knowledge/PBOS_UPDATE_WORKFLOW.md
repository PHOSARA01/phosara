# PBOS_UPDATE_WORKFLOW.md

# PHOSARA PBOS Update Workflow v1.0

Version: 1.0  
Owner: PHOSARA HQ  
Status: Official Standard  
Purpose: 営業活動から得られた知見をPBOSへ継続的に反映し、営業・Business Audit・会社資産を自己改善し続ける運用を標準化する。

---

# 基本方針

営業は契約を獲得するだけではなく、

**会社資産（PBOS）を成長させる活動**である。

営業1件ごとに必ず知識を抽出し、

会社全体へ反映する。

営業終了

↓

営業ログ作成

↓

分析

↓

PBOS更新

↓

Skills更新

↓

Sales Playbook更新

↓

Business Audit更新

↓

次回営業へ反映

このループをPHOSARA標準運用とする。

---

# 全体フロー

```text
営業実施
    │
    ▼
SALES_LOG_STANDARD.md
    │
    ▼
営業結果分析
    │
    ▼
更新対象判定
    │
    ├── PBOS
    ├── STATE
    ├── WORKFLOW
    ├── SKILLS
    ├── AGENTS
    ├── KNOWLEDGE
    │
    ▼
Sales Playbook更新
    │
    ▼
Business Audit更新
    │
    ▼
営業標準改善
    │
    ▼
次回営業へ適用
```

---

# STEP 1 営業ログ作成

営業終了後24時間以内に

SALES_LOG_STANDARD.md

へ記録する。

必須項目

- 営業結果
- 顧客反応
- 質問
- 成功要因
- 失敗要因
- 改善点
- Lessons Learned
- 営業フェーズ

---

# STEP 2 営業結果分析

営業ログから以下を分析する。

## 定量分析

- 営業件数
- 返信率
- ヒアリング率
- Business Audit実施率
- 提案率
- 商談率
- 契約率
- 紹介率

---

## 定性分析

- 良かった営業トーク
- 悪かった営業トーク
- よくある質問
- よくある断り文句
- 興味を持たれたポイント
- 不安要素
- 価格への反応
- ブランドへの反応

---

# STEP 3 PBOS更新

営業結果から会社全体へ反映する。

## 更新対象

### PBOS

更新条件

- 商品改善が必要
- 営業導線変更
- 新サービス追加
- 営業戦略変更

---

### STATE

更新条件

- 営業フェーズ進捗
- KPI更新
- ボトルネック発見

---

### WORKFLOW

更新条件

- 営業手順改善
- ヒアリング改善
- 提案フロー改善

---

### KNOWLEDGE

更新条件

- 業界知識追加
- 顧客知識追加
- 新しい質問追加
- 新しい課題追加

---

### AGENTS

更新条件

- AI営業Agent改善
- Business Audit Agent改善
- Proposal Agent改善

---

# STEP 4 Skills更新

営業結果から再利用できるノウハウのみ登録する。

登録対象

- 成約率が高い営業トーク
- 良い質問
- 良い切り返し
- 良い提案方法
- 良いクロージング
- 業種別成功パターン

登録しないもの

- 一時的な成功
- 再現性が低い内容
- 根拠が不十分な内容

---

# STEP 5 Sales Playbook更新

営業標準書を改善する。

更新対象

- Opening
- Discovery
- Business Audit説明
- 提案順序
- クロージング
- FAQ
- objection handling
- Follow Up

更新条件

同じ改善内容が3回以上確認された場合。

---

# STEP 6 Business Audit更新

営業から得られた情報をBusiness Auditへ反映する。

更新対象

## ヒアリング項目

追加

修正

削除

---

## 評価項目

追加

修正

削除

---

## 提案テンプレート

改善

---

## レポート内容

改善

---

## 業種別診断

改善

---

# 更新優先順位

|対象|優先度|
|---|---|
|PBOS|S|
|Skills|S|
|Sales Playbook|S|
|Business Audit|S|
|Knowledge|A|
|Workflow|A|
|Agents|A|
|State|B|

---

# 更新ルール

## 即時更新

以下は営業終了後すぐ更新する。

- 営業ログ
- KPI
- 営業フェーズ

---

## 週次更新

毎週まとめて更新する。

- Skills
- Sales Playbook
- Knowledge

---

## 月次更新

毎月レビューする。

- PBOS
- Business Audit
- Workflow
- Agents

---

# 承認フロー

営業担当

↓

営業責任者レビュー

↓

Knowledge責任者レビュー

↓

PHOSARA HQ承認

↓

PBOS更新

↓

GitHub反映

---

# 更新判断基準

更新前に必ず以下を確認する。

- 再現性があるか
- 他案件でも利用できるか
- 売上向上につながるか
- Business Audit改善につながるか
- PBOS資産になるか

1つでも満たさない場合は更新保留とする。

---

# KPI

毎月集計する。

- 営業件数
- 返信率
- Business Audit実施率
- 提案率
- 商談率
- 契約率
- 紹介率
- 業種別契約率
- Business Audit成約率

---

# 成果物

営業活動から必ず生成される成果物

- SALES_LOG_STANDARD.md
- SALES_PLAYBOOK.md（更新）
- BUSINESS_AUDIT.md（更新）
- SKILLS.md（更新）
- KNOWLEDGE.md（更新）
- PBOS.md（更新）

---

# HQレビュー

PHOSARA HQは週1回レビューを実施する。

レビュー内容

- 更新漏れ確認
- KPI分析
- 営業パイプライン分析
- ボトルネック分析
- Skills品質確認
- Business Audit改善確認
- Sales Playbook改善確認

---

# 成功条件

営業1件が終了した時点で、

営業成果だけでなく会社資産も必ず成長している状態を成功と定義する。

営業活動は「売るための行動」ではなく、「PHOSARAが学習し続ける仕組み」の一部である。

すべての営業結果はPBOSへ蓄積され、Skills・Sales Playbook・Business Auditへ継続的に反映されることで、営業品質・提案品質・契約率を長期的に向上させる。