# PLAN.md — PHOSARA 公式サイト制作計画

**作成日:** 2026-07-03
**準拠OS:** PHOSARA Company OS v1.0 / PBOS Gold Edition
**最終判断ルール適合確認:** 本計画のすべての制作物は「60日以内の初回有償クライアント獲得の確率を直接高める」または「再利用可能なPBOS資産を生む」条件を満たす。

---

## Explore 所見（制作着手前の現状分析）

### 現在のサイト構成
| 要素 | 状態 | 備考 |
|---|---|---|
| `website/index.html` | 骨格実装済み | 全セクションがプレースホルダーコピー |
| `#hero` | 実装済み・デザイン改善済み | コピー v1.1 反映済み |
| `#about` | プレースホルダー | コピー未設定 |
| `#services` | プレースホルダー | カード3枚・コピー未設定 |
| `#works` | プレースホルダー | 画像なし・コピー未設定 |
| `#journal` | プレースホルダー | 記事なし |
| `#contact` | フォームHTML実装済み | 送信先未接続 |
| CSS/JS インフラ | 完成 | Design System v2.0 準拠 |
| ロゴSVG | 未配置 | `.gitkeep` のみ |
| Works 画像 | 未配置 | `.gitkeep` のみ |
| OG 画像 | 未配置 | `.gitkeep` のみ |
| 独立ページ | 0本 | about/approach/services/industriesすべて未作成 |

### PBOS との照合で判明した構造上の問題
1. **入口が機能していない** — index.html の全セクションがプレースホルダーのため、訪問者がPBOSに入る動線が存在しない
2. **Approach ページが存在しない** — 「診断のあとにあります」という差別化軸を伝えるページがなく、競合との違いを説明できない
3. **監査（有償）への動線が薄い** — 現状のCTAは「無料相談」にしか向いておらず、Business Audit という最初の有償商品が表面化していない
4. **セクション直帰リスク** — コピーが入っていないまま公開されると信頼を損なう

### 営業導線の分析
```
[現状の想定フロー]
訪問者 → Hero CTA → #contact フォーム → （送信先未接続）→ 途絶

[PBOS が要求するフロー]
訪問者 → Hero → Approach（なぜ診断か）→ Services（何を提供するか）
→ Works（実績による信頼）→ 無料相談申込（選別あり）
→ 相談 → Business Audit 提案 → 有償受注
```

---

## 1. 制作順序

最終判断ルールに従い、「60日収益に直結する順」で制作する。コンテンツのない独立ページより、訪問者が実際に触れる index.html のコピー充填を先行させる。

### Sprint 1 — index.html コンテンツ充填（最優先）
*目的: 今あるサイトを「機能する入口」にする*

| # | 作業 | 優先理由 |
|---|---|---|
| 1-1 | `#about` コピー充填（Website_Copy v1.1 準拠） | 信頼の基礎 |
| 1-2 | `#services` コピー充填・Business Audit を前面化 | 有償商品の可視化 |
| 1-3 | `#contact` コピー充填＋選別質問の追加 | 相談転換率向上 |
| 1-4 | フォーム送信先の接続（Formspree 等） | 問い合わせ受信 |
| 1-5 | `<title>` / `<meta description>` 正式コピー設定 | 最低限のSEO |

### Sprint 2 — Approach ページ（最重要独立ページ）
*目的: 「診断のあとにあります」を深掘りし、相談転換率を上げる*

| # | 作業 | 優先理由 |
|---|---|---|
| 2-1 | `/approach/index.html` 新規作成 | Hero CTA「進め方を見る」の着地先 |
| 2-2 | ステップ図（無料相談 → 監査 → 提案 → 制作）の実装 | PBOSフローの可視化 |
| 2-3 | 「なぜ診断が先か」のコピー実装 | 差別化の説明 |
| 2-4 | Approach → Contact への CTA | 動線接続 |

### Sprint 3 — Services ページ
*目的: Business Audit・Design Consulting・Implementation の詳細説明*

| # | 作業 | 優先理由 |
|---|---|---|
| 3-1 | `/services/index.html` 新規作成 | 商品理解の深化 |
| 3-2 | Business Audit の説明・価格帯の示唆 | 有償商品への興味喚起 |
| 3-3 | 各サービスから Contact への CTA | 動線 |

### Sprint 4 — Works（実績）
*目的: 社会的証明による信頼形成*

| # | 作業 | 優先理由 |
|---|---|---|
| 4-1 | `#works` にClient Zero事例（自社監査）を掲載 | 実績ゼロの初期を乗り越える |
| 4-2 | Works 画像の配置（スクリーンショット等） | 視覚的証明 |
| 4-3 | `/works/{案件名}/` 詳細ページ（受注後に順次追加） | 将来の事例蓄積 |

### Sprint 5 — Industries ページ
*目的: 建設業・クリニック・リフォーム業等への業種別訴求*

| # | 作業 | 備考 |
|---|---|---|
| 5-1 | `/industries/index.html` 一覧ページ | docs/03_業界別ソリューション/ 準拠 |
| 5-2 | 業種別ランディングページ（各1枚） | SEO・開拓の武器 |

### Sprint 6 — Journal（コンテンツマーケティング）
*目的: SEO流入と信頼形成の長期投資*

| # | 作業 | 備考 |
|---|---|---|
| 6-1 | `/journal/index.html` 一覧ページ | |
| 6-2 | 第1記事（Client Zero の学び、匿名化） | PBOS資産の公開 |
| 6-3 | 記事定期投稿（週次WF-08と連動） | 収穫→記事化パイプライン |

---

## 2. ページ一覧

| URL | 種別 | 状態 | Sprint |
|---|---|---|---|
| `/` (index.html) | トップ | 骨格実装済み・コピー未充填 | 1 |
| `/approach/` | Approach | 未作成 | 2 |
| `/services/` | Services | 未作成 | 3 |
| `/works/` | Works 一覧 | 未作成 | 4 |
| `/works/{案件名}/` | Works 詳細 | 未作成 | 4（受注後） |
| `/industries/` | Industries 一覧 | 未作成 | 5 |
| `/industries/{業種}/` | 業種別 LP | 未作成 | 5 |
| `/journal/` | Journal 一覧 | 未作成 | 6 |
| `/journal/{記事}/` | 記事詳細 | 未作成 | 6 |
| `404.html` | エラーページ | 未作成 | Sprint 2 と同時 |

---

## 3. 優先順位マトリクス

| 優先度 | 理由 | 対象 |
|---|---|---|
| **P0（今すぐ）** | 送信先未接続＝問い合わせが届かない | フォーム送信接続 |
| **P0（今すぐ）** | プレースホルダーのままでは信頼を損なう | `#about` / `#services` / `#contact` コピー充填 |
| **P1（今週中）** | Hero CTA「進め方を見る」の着地先がない | `/approach/` 作成 |
| **P2（2週間以内）** | 有償商品の詳細が見えない | `/services/` 作成 |
| **P3（1ヶ月以内）** | 実績ゼロは信頼のボトルネック | Works（Client Zero事例） |
| **P4（Phase B以降）** | SEO・開拓の武器 | Industries / Journal |

---

## 4. CTA設計

### CTA 階層

```
[Primary CTA]   無料相談を予約する → #contact（選別フォーム）
[Secondary CTA] PHOSARAの進め方を見る → /approach/
[Tertiary CTA]  詳細を見る → 各サービスページ
```

### フォーム選別設計（Sprint 1-3 で実装）

無料相談フォームに以下の質問を追加し、非適格リードの自動識別を可能にする。

| フィールド | 目的 |
|---|---|
| お名前 | 基本情報 |
| 会社名・屋号 | 対象確認 |
| メールアドレス | 連絡先 |
| 現在の課題（選択式）| 適格確認・準備材料 |
| 検討時期 | 緊急度の把握 |
| ご相談内容（自由記述）| 事前下調べ材料（AG-2向け） |

### CTA 配置ルール
- 全ページのヘッダーナビに「無料相談」ボタン（現在実装済み）
- 各セクション末尾に文脈に沿った CTA を1つ
- Approach ページ末尾：「相談してみる」「サービス詳細を見る」の2択
- Hero の Secondary CTA（「進め方を見る」）は `/approach/` に向ける（現在はアンカーリンク）

---

## 5. SEO方針

### フェーズ別方針

**Sprint 1（今すぐ）— 最低限のSEO**
- `<title>` と `<meta description>` の正式設定
- `<link rel="canonical">` の確認（現在 `https://phosara.com/` 設定済み）
- OG タグの充填（og:title / og:description / og:image）
- `robots.txt` と `sitemap.xml` の作成（Phase 4 計画済み）

**Sprint 2-3（2週間以内）— ページ別SEO**
- 各ページに固有の `<title>` / `<meta description>` / `<h1>`
- `/approach/` ターゲットキーワード：「事業診断 Web制作」「診断 ブランディング」
- `/services/` ターゲットキーワード：「ビジネスオーディット」「デザインコンサルティング 中小企業」

**Sprint 5-6（中期）— コンテンツSEO**
- 業種別ページ：「建設業 ホームページ 診断」「クリニック ブランディング」等の長尾キーワード
- Journal：週1記事（WF-08 の収穫→記事化パイプラインと連動）

### SEO 非対象（60日フォーカス外）
- 被リンク獲得施策
- 構造化データ（Schema.org）— Sprint 4 以降に検討
- 検索順位の追跡ツール設定 — Phase 4

### 重要判断
60日以内の収益はSEOからは来ない（効果発現まで3-6ヶ月）。SEO は長期投資として丁寧に設計するが、**60日収益の主軸は能動開拓（WF-01）とリファラル**である。サイトは「信頼の証明書」として機能させることが最優先。

---

## 6. モバイル設計

### 現在の実装状況（完了済み）
- モバイルファースト CSS（min-width ブレークポイント：768px / 1024px）
- Hero：`min-height: calc(100vh - 64px)` で全面表示
- CTA ボタン：モバイルで縦並び・フル幅（`flex-direction: column; align-items: stretch`）
- ハンバーガーメニュー：実装済み（44px タッチターゲット確保）
- フォーム：`width: 100%` で横幅対応

### 各 Sprint で守るモバイル設計原則
| 原則 | 実装方針 |
|---|---|
| タッチターゲット最小 44px | ボタン・リンクに `min-height: 44px` または `padding` で確保 |
| 1カラム優先 | グリッドは mobile で 1col、768px 以上で 2col 以上 |
| 折り返し禁止 | ナビテキストの省略は行わず、モバイルではハンバーガーで収容 |
| フォーム使いやすさ | フィールド間の余白を `--space-4` 以上に保つ |
| 画像の CLS 防止 | 全 `<img>` に `width` / `height` 属性と `loading="lazy"`（Hero は `eager`） |

---

## 7. 残リスク

| # | リスク | 深刻度 | 対処方針 | Sprint |
|---|---|---|---|---|
| R1 | ロゴ SVG 未配置 | 高 | オーナーが `docs/` 等から供給・`website/assets/images/logos/` に配置 | P0 |
| R2 | フォーム送信先未接続 | 高 | Formspree（無料枠）または Netlify Forms を Sprint 1 で接続 | 1 |
| R3 | Works 画像ゼロ | 中 | Client Zero（自社監査）のスクリーンショットで初期を乗り越える | 4 |
| R4 | OG 画像未配置 | 中 | SNS 共有時にブランク表示。Sprint 2 までに最低限の OG 画像を作成 | 2 |
| R5 | コピー未充填のまま公開中 | 高 | Sprint 1 を最優先で着手。それまでは index の sections を `hidden` にするか許容するか判断が必要 | 1 |
| R6 | phosara.com DNS / SSL 未確認 | 中 | Vercel ダッシュボードでカスタムドメイン設定と SSL を確認 | 確認のみ（実装外） |
| R7 | Google Fonts CDN 依存 | 低 | CDN 障害時に system-ui フォールバックあり（tokens.css 設定済み）。許容範囲 | — |
| R8 | 実績ゼロ期間の信頼問題 | 中 | Client Zero（WF-08 特別実施）を最初の事例として掲載。「Process」で補完 | 4 |
| R9 | Website_Copy v1.1 との差分 | 中 | 充填前に Copy v1.1 を必ず参照し、AI の創作コピーを一切使用しない | 全Sprint |
| R10 | 営業中の index.html プレースホルダー | 中 | 営業先に URL を案内する前に Sprint 1 を完了させる（案内のタイミングを人間が判断） | 1 |

---

## 付録：ファイル・ディレクトリ命名規則

```
website/
├── index.html               # トップページ
├── approach/
│   └── index.html
├── services/
│   └── index.html
├── works/
│   ├── index.html
│   └── {case-slug}/
│       └── index.html
├── industries/
│   ├── index.html
│   └── {industry-slug}/
│       └── index.html
├── journal/
│   ├── index.html
│   └── {article-slug}/
│       └── index.html
└── assets/
    ├── css/
    │   ├── tokens.css
    │   ├── base.css
    │   ├── layout.css
    │   ├── components.css
    │   └── pages/           # ページ固有スタイル（必要時のみ）
    ├── js/
    │   ├── main.js
    │   ├── nav.js
    │   └── animations.js
    └── images/
        ├── logos/           # phosara-logo.svg（要配置）
        ├── works/           # 実績画像
        ├── journal/         # 記事サムネイル
        └── og/              # OG 画像（要作成）
```

---

## 承認チェックリスト（実装着手前に人間が確認）

- [ ] Website_Copy v1.1 を手元で参照できる状態にある
- [ ] phosara-logo.svg を `website/assets/images/logos/` に配置する準備がある（または一時保留を許容する）
- [ ] フォーム送信先（メールアドレス）を Claude Code に提供する準備がある
- [ ] Sprint 1 完了後に URL を開拓先へ案内開始するタイミングを決めている
- [ ] Client Zero（自社監査）の実施予定がある（Works の初期コンテンツ源）

**実装開始の承認をいただけましたら、Sprint 1 から着手します。**
