# PHOSARA_Website_Design_System_v2.0

> PHOSARAウェブサイト 実装仕様書
> Version 2.0 — 2026-06-30

---

# 01 本書について

本書はPHOSARA公式Websiteを実装する際の**具体的な仕様値の参照先**です。
思想・方針はVisual System v2.0に記載されています。本書に再掲しません。

## 位置付け

| 資料 | 役割 |
|---|---|
| Visual System v2.0 | デザインの思想・方針 |
| Blueprint v1.1 | ページ構造・情報設計 |
| Copy v1.1 | テキスト・コピー |
| **本書（Design System v2.0）** | **実装に使う具体値（数値・トークン）← このファイル** |

## オーナー確認事項の記号

| 記号 | 対象 |
|---|---|
| **【確認A】** | カラー（全HEX値が未確定） |
| **【確認B】** | フォント（未確定） |
| **【確認C】** | アイコンライブラリ（未確定） |
| **【確認D】** | その他の未確定事項 |

---

# 02 ブランドカラー

> **【確認A】** 全HEX値は未確定です。
> オーナー確定後に下記CSS変数ブロックへ記入してください。
> 確定前の実装は禁止です。

## カラートークン

| CSS変数 | 用途 | HEX |
|---|---|---|
| `--color-bg` | ページ背景 | 未定 |
| `--color-surface` | カード・パネル背景 | 未定 |
| `--color-text` | 見出し・本文（メイン） | 未定 |
| `--color-text-sub` | サブ見出し・説明文 | 未定 |
| `--color-text-muted` | 日付・ラベル・補足 | 未定 |
| `--color-accent` | CTAボタン・重要リンク | 未定 |
| `--color-accent-hover` | アクセントホバー時 | 未定 |
| `--color-border` | カード枠・入力欄・区切り | 未定 |
| `--color-border-strong` | ホバー時の枠・強調区切り | 未定 |
| `--color-success` | 成功メッセージ | 未定 |
| `--color-warning` | 警告メッセージ | 未定 |
| `--color-error` | エラーメッセージ・入力エラー | 未定 |

## CSS変数

```css
:root {
  --color-bg:            ;
  --color-surface:       ;
  --color-text:          ;
  --color-text-sub:      ;
  --color-text-muted:    ;
  --color-accent:        ;
  --color-accent-hover:  ;
  --color-border:        ;
  --color-border-strong: ;
  --color-success:       ;
  --color-warning:       ;
  --color-error:         ;
}
```

## カラー使用ルール

- アクセントカラーはCTAボタン・重要リンクにのみ使用する
- 背景の大面積にアクセントカラーを使用しない
- CSSに直接HEXを書かず、必ずCSS変数を使う
- テキストと背景のコントラスト比はWCAG 2.1 AA（4.5:1以上）を満たすこと

---

# 03 タイポグラフィ

> **【確認B】** 使用フォントは未確定です。以下の候補からオーナーが選択後、CSS変数に記入してください。

## フォント候補

### 日本語フォント

| 候補 | フォント名 | 特徴 | 入手方法 |
|---|---|---|---|
| **候補A（推奨）** | **Noto Sans JP** | 可読性が高く、プロフェッショナル。Googleが開発した標準的なゴシック体 | Google Fonts（無料） |
| 候補B | BIZ UDGothic | ビジネス向けに最適化されたゴシック体。堅実な印象 | Google Fonts（無料） |
| 候補C | Noto Serif JP | 明朝体。より上品・格調ある印象 | Google Fonts（無料） |

### 欧文フォント

| 候補 | フォント名 | 特徴 | 入手方法 |
|---|---|---|---|
| **候補A（推奨）** | **Inter** | Linear・Vercelが採用。高い可読性・現代的 | Google Fonts（無料） |
| 候補B | DM Sans | クリーンでモダン。やや丸みがある | Google Fonts（無料） |
| 候補C | Geist | Vercel製。技術的な美しさ | Vercel（無料） |

## CSS変数

```css
:root {
  --font-jp:   '<日本語フォント>', 'Hiragino Sans', 'Yu Gothic', sans-serif;  /* 【確認B】 */
  --font-en:   '<欧文フォント>', system-ui, -apple-system, sans-serif;        /* 【確認B】 */
  --font-mono: '<等幅フォント>', monospace;

  /* font-size（1rem = 16px） */
  --text-display: 3.5rem;
  --text-h1:      2.5rem;
  --text-h2:      2rem;
  --text-h3:      1.5rem;
  --text-h4:      1.25rem;
  --text-lg:      1.125rem;
  --text-base:    1rem;
  --text-sm:      0.875rem;
  --text-xs:      0.75rem;

  /* line-height */
  --leading-display: 1.15;
  --leading-heading: 1.3;
  --leading-body:    1.8;
  --leading-tight:   1.5;

  /* font-weight */
  --weight-normal:   400;
  --weight-semibold: 600;
  --weight-bold:     700;
}
```

## タイポグラフィスケール

| レベル | 用途 | font-size | font-weight | line-height | letter-spacing |
|---|---|---|---|---|---|
| **Display** | Heroの最大見出し | 3.5rem（56px） | 700 | 1.15 | -0.02em |
| **H1** | ページタイトル | 2.5rem（40px） | 700 | 1.2 | -0.02em |
| **H2** | セクション見出し | 2rem（32px） | 600 | 1.3 | -0.01em |
| **H3** | サブ見出し | 1.5rem（24px） | 600 | 1.4 | 0 |
| **H4** | 補助見出し | 1.25rem（20px） | 600 | 1.4 | 0 |
| **Body Large** | リードコピー | 1.125rem（18px） | 400 | 1.9 | 0 |
| **Body** | 通常本文 | 1rem（16px） | 400 | 1.8 | 0 |
| **Small** | 補足・ラベル | 0.875rem（14px） | 400 | 1.6 | 0.01em |
| **Caption** | 日付・タグ・注記 | 0.75rem（12px） | 400 | 1.5 | 0.02em |

## モバイルでのフォントサイズ

| レベル | デスクトップ | モバイル |
|---|---|---|
| Display | 3.5rem（56px） | 2.5rem（40px） |
| H1 | 2.5rem（40px） | 2rem（32px） |
| H2 | 2rem（32px） | 1.75rem（28px） |
| H3 | 1.5rem（24px） | 1.375rem（22px） |

---

# 04 余白・スペーシング

## スペーシングスケール

| 変数名 | 値（px） | 値（rem） | 主な用途 |
|---|---|---|---|
| `--space-1` | 4px | 0.25rem | アイコンと文字の間隔など、最小の隙間 |
| `--space-2` | 8px | 0.5rem | 小さな要素間の余白 |
| `--space-3` | 12px | 0.75rem | ラベルとフィールドの間隔 |
| `--space-4` | 16px | 1rem | 通常の要素間の余白（基本単位） |
| `--space-6` | 24px | 1.5rem | カード内のパディング |
| `--space-8` | 32px | 2rem | セクション内の要素間 |
| `--space-12` | 48px | 3rem | 小さなセクション間 |
| `--space-16` | 64px | 4rem | モバイルのセクション間余白 |
| `--space-20` | 80px | 5rem | タブレットのセクション間余白 |
| `--space-24` | 96px | 6rem | デスクトップの中程度のセクション間 |
| `--space-32` | 128px | 8rem | デスクトップの大きなセクション間余白 |
| `--space-40` | 160px | 10rem | Heroなど最大の余白 |

## CSS変数

```css
:root {
  --space-1:  0.25rem;   /*  4px */
  --space-2:  0.5rem;    /*  8px */
  --space-3:  0.75rem;   /* 12px */
  --space-4:  1rem;      /* 16px */
  --space-6:  1.5rem;    /* 24px */
  --space-8:  2rem;      /* 32px */
  --space-12: 3rem;      /* 48px */
  --space-16: 4rem;      /* 64px */
  --space-20: 5rem;      /* 80px */
  --space-24: 6rem;      /* 96px */
  --space-32: 8rem;      /* 128px */
  --space-40: 10rem;     /* 160px */
}
```

## セクション間の余白

| デバイス | セクション間の余白 |
|---|---|
| モバイル | `--space-16`（64px） |
| タブレット | `--space-24`（96px） |
| デスクトップ | `--space-32`（128px） |

---

# 05 グリッドシステム

## CSS変数

```css
:root {
  --grid-columns:      12;
  --grid-gutter:       1.5rem;   /* 24px */
  --container-max:     1200px;   /* 【確認D】候補：1200px / 1280px / 1440px */
  --container-padding: 1.5rem;
}
```

> **【確認D】** コンテナ最大幅はオーナー確認が必要です。
>
> | 候補 | 最大幅 | 印象 |
> |---|---|---|
> | **候補A（推奨）** | **1200px** | 余白が多く、静かな高級感 |
> | 候補B | 1280px | やや広め。情報量を多く見せたい場合 |
> | 候補C | 1440px | ワイドスクリーン重視 |

## コンテナ

```css
.container {
  max-width:     var(--container-max);
  margin-left:   auto;
  margin-right:  auto;
  padding-left:  var(--container-padding);
  padding-right: var(--container-padding);
}
```

## カラムの使い方

| レイアウト | カラム数 | 主な用途 |
|---|---|---|
| フル幅 | 12 / 12 | Hero・大きなセクション見出し |
| 中央寄せ幅広 | 8 / 12（中央） | 本文・リードコピー |
| 中央寄せ狭 | 6 / 12（中央） | 引用・強調テキスト |
| 2カラム均等 | 6 + 6 | サービス・特徴の並列表示 |
| 3カラム均等 | 4 + 4 + 4 | カード3枚並べ |
| テキスト＋画像 | 7 + 5 または 5 + 7 | 画像とテキストの組み合わせ |

---

# 06 レイアウトルール

## ブレークポイント

```css
/* モバイル：375px〜（デフォルト） */
/* タブレット：768px〜 */
@media (min-width: 768px) { ... }
/* デスクトップ：1024px〜 */
@media (min-width: 1024px) { ... }
/* ラージ：1280px〜 */
@media (min-width: 1280px) { ... }
```

| 名称 | 幅の範囲 | 対象デバイス |
|---|---|---|
| Mobile | 〜767px | スマートフォン |
| Tablet | 768px〜1023px | タブレット・小型PC |
| Desktop | 1024px〜1279px | ノートPC・デスクトップ |
| Large | 1280px〜 | 大型ディスプレイ |

## セクション

```css
.section {
  padding-top:    var(--space-16);   /* モバイル: 64px */
  padding-bottom: var(--space-16);
}

@media (min-width: 768px) {
  .section {
    padding-top:    var(--space-24); /* タブレット: 96px */
    padding-bottom: var(--space-24);
  }
}

@media (min-width: 1024px) {
  .section {
    padding-top:    var(--space-32); /* デスクトップ: 128px */
    padding-bottom: var(--space-32);
  }
}
```

---

# 07 ボタン

## Primary Button

```css
.btn-primary {
  display:          inline-flex;
  align-items:      center;
  justify-content:  center;
  gap:              var(--space-2);
  padding:          14px 32px;
  background-color: var(--color-accent);
  color:            #FFFFFF;
  font-family:      var(--font-en), var(--font-jp);
  font-size:        var(--text-base);   /* 16px */
  font-weight:      var(--weight-semibold);
  line-height:      1;
  border:           none;
  border-radius:    6px;
  cursor:           pointer;
  transition:       background-color 200ms ease-out,
                    transform 150ms ease-out;
  text-decoration:  none;
  white-space:      nowrap;
}

.btn-primary:hover {
  background-color: var(--color-accent-hover);
  transform:        translateY(-1px);
}

.btn-primary:active {
  transform: translateY(0);
}

.btn-primary:focus-visible {
  outline:        2px solid var(--color-accent);
  outline-offset: 3px;
}
```

## Secondary Button

```css
.btn-secondary {
  display:          inline-flex;
  align-items:      center;
  justify-content:  center;
  gap:              var(--space-2);
  padding:          13px 31px;   /* border分1px引く */
  background-color: transparent;
  color:            var(--color-text);
  font-family:      var(--font-en), var(--font-jp);
  font-size:        var(--text-base);
  font-weight:      var(--weight-semibold);
  line-height:      1;
  border:           1px solid var(--color-border-strong);
  border-radius:    6px;
  cursor:           pointer;
  transition:       border-color 200ms ease-out,
                    color 200ms ease-out;
  text-decoration:  none;
  white-space:      nowrap;
}

.btn-secondary:hover {
  border-color: var(--color-text);
}

.btn-secondary:focus-visible {
  outline:        2px solid var(--color-text);
  outline-offset: 3px;
}
```

## Text Button

```css
.btn-text {
  display:         inline-flex;
  align-items:     center;
  gap:             var(--space-1);
  padding:         0;
  background:      none;
  border:          none;
  color:           var(--color-text);
  font-size:       var(--text-base);
  font-weight:     var(--weight-semibold);
  cursor:          pointer;
  text-decoration: none;
  transition:      color 150ms ease-out;
}

.btn-text:hover {
  color: var(--color-accent);
}
```

## ボタンのルール

- Primary Buttonは各ページに1つだけを原則とする
- ボタンサイズの最小タップ領域：高さ44px以上を確保する

---

# 08 カード

## 基本カード

```css
.card {
  background-color: var(--color-surface);
  border:           1px solid var(--color-border);
  border-radius:    8px;
  padding:          var(--space-6);   /* 24px */
  transition:       border-color 200ms ease-out;
}

.card:hover {
  border-color: var(--color-border-strong);
}
```

## カードの種類

| 種類 | 用途 |
|---|---|
| **基本カード** | サービス・特徴の説明 |
| **Worksカード** | 制作実績（画像・タイトル・カテゴリ） |
| **Journalカード** | ブログ記事（サムネイル・タイトル・日付） |
| **業界カード** | 業界別ソリューション（アイコン・業界名・説明） |

## カードのルール

- 影（box-shadow）は原則使用しない
- ホバー時は色の変化のみ（translateYは最大-2px）
- カード内パディング：`--space-6`（24px）
- カード内要素間余白：`--space-4`（16px）

---

# 09 フォーム

## 入力フィールド

```css
.form-input,
.form-textarea,
.form-select {
  width:            100%;
  padding:          12px 16px;
  background-color: var(--color-surface);
  border:           1px solid var(--color-border);
  border-radius:    6px;
  font-family:      var(--font-jp);
  font-size:        var(--text-base);   /* 16px */
  color:            var(--color-text);
  line-height:      var(--leading-body);
  transition:       border-color 200ms ease-out,
                    box-shadow  200ms ease-out;
  appearance:       none;
  -webkit-appearance: none;
}

.form-input:focus,
.form-textarea:focus,
.form-select:focus {
  outline:      none;
  border-color: var(--color-text);
  box-shadow:   0 0 0 3px rgba(17, 17, 17, 0.08);
}

.form-input.is-error,
.form-textarea.is-error {
  border-color: var(--color-error);
  box-shadow:   0 0 0 3px rgba(239, 68, 68, 0.1);
}

.form-input::placeholder,
.form-textarea::placeholder {
  color: var(--color-text-muted);
}
```

## ラベル

```css
.form-label {
  display:       block;
  font-size:     var(--text-sm);   /* 14px */
  font-weight:   var(--weight-semibold);
  color:         var(--color-text);
  margin-bottom: var(--space-2);   /* 8px */
}

.form-label.is-required::after {
  content: ' *';
  color:   var(--color-error);
}
```

## エラーメッセージ

```css
.form-error {
  display:    block;
  font-size:  var(--text-sm);   /* 14px */
  color:      var(--color-error);
  margin-top: var(--space-2);   /* 8px */
}
```

## フォームのルール

- すべての入力欄にラベルを付ける（placeholderのみは禁止）
- フォントサイズは16px以上（Safariのズーム防止）
- テキストエリアは `resize: vertical` を許容する（横方向は禁止）

---

# 10 ナビゲーション

## ヘッダー

```css
.global-header {
  position:         sticky;
  top:              0;
  z-index:          100;
  background-color: var(--color-surface);
  border-bottom:    1px solid var(--color-border);
  padding:          0 var(--container-padding);
}

.global-header-inner {
  display:         flex;
  align-items:     center;
  justify-content: space-between;
  max-width:       var(--container-max);
  margin:          0 auto;
  height:          64px;
}
```

## ナビゲーションリンク

```css
.nav-link {
  font-size:       var(--text-sm);    /* 14px */
  font-weight:     var(--weight-semibold);
  color:           var(--color-text-sub);
  text-decoration: none;
  letter-spacing:  0.05em;
  transition:      color 150ms ease-out;
}

.nav-link:hover,
.nav-link.is-active {
  color: var(--color-text);
}
```

## モバイルナビゲーション

- モバイルではハンバーガーメニューを使用する
- メニューはフルスクリーンまたはドロワー形式
- 開閉アニメーション：フェード（200ms ease-out）

---

# 11 CTA

## CTA セクション

```css
.cta-section {
  padding-top:      var(--space-24);   /* 96px */
  padding-bottom:   var(--space-24);
  background-color: var(--color-bg);
  text-align:       center;
}

.cta-heading {
  font-size:     var(--text-h2);   /* 32px */
  font-weight:   var(--weight-bold);
  color:         var(--color-text);
  margin-bottom: var(--space-4);   /* 16px */
}

.cta-body {
  font-size:     var(--text-lg);   /* 18px */
  color:         var(--color-text-sub);
  margin-bottom: var(--space-8);   /* 32px */
  max-width:     560px;
  margin-left:   auto;
  margin-right:  auto;
}
```

## CTAのルール

- 各ページのCTAは1つを原則とする
- CTAの上下余白は他のセクションより大きくとる

---

# 12 アイコン

> **【確認C】** 使用するアイコンセットはオーナー確認が必要です。

## アイコンセット候補

| 候補 | セット名 | 特徴 |
|---|---|---|
| **候補A（推奨）** | **Lucide Icons** | シンプルな線画。Linear・Vercelが採用 |
| 候補B | Heroicons | Tailwind CSS製。クリーンで一貫性が高い |
| 候補C | Phosphor Icons | バリエーションが豊富 |

## アイコンサイズ

| 用途 | サイズ |
|---|---|
| テキストと並ぶ小さいアイコン | 16px × 16px |
| 通常のアイコン | 24px × 24px |
| 大きなアイコン（特徴説明など） | 32px × 32px |

## CSS

```css
.icon {
  display:      inline-block;
  width:        24px;
  height:       24px;
  stroke-width: 1.5;   /* 【確認C-2】確認後に調整 */
  flex-shrink:  0;
}

.icon-sm { width: 16px; height: 16px; }
.icon-lg { width: 32px; height: 32px; }
```

## アイコン使用ルール

- Outlineスタイルのみ使用する（塗りつぶしアイコンは禁止）
- テキストなしでアイコンのみ使用する場合は `aria-label` を必ず付与する
- 装飾目的のアイコン使用は禁止（情報補助の目的のみ）

---

# 13 画像・写真

## アスペクト比

| 用途 | アスペクト比 |
|---|---|
| Heroの背景画像 | 16:9 または なし（自由高さ） |
| Worksのサムネイル | 16:9 |
| Journalのサムネイル | 16:9 または 3:2 |
| 人物写真（ABOUTなど） | 4:5 または 1:1 |

## CSS

```css
.image-wrapper {
  overflow:      hidden;
  border-radius: 8px;
  aspect-ratio:  16 / 9;   /* 用途に応じて変更 */
}

.image-wrapper img {
  width:      100%;
  height:     100%;
  object-fit: cover;
}
```

## 画像のルール

- `alt` 属性は必ず記述する（装飾目的の場合は `alt=""`）
- `width` と `height` 属性を指定し、レイアウトシフトを防ぐ
- 表示サイズに合わせた解像度の画像を使用する（2倍解像度推奨）
- WebP形式を優先し、JPGをフォールバックとする

---

# 14 アニメーション

## CSS変数

```css
:root {
  /* Duration */
  --duration-fast:   150ms;   /* ホバー・フォーカス */
  --duration-normal: 250ms;   /* フェードイン・フェードアウト */
  --duration-slow:   400ms;   /* ページ遷移・モーダル */

  /* Easing */
  --ease-out:      cubic-bezier(0, 0, 0.2, 1);
  --ease-in:       cubic-bezier(0.4, 0, 1, 1);
  --ease-standard: cubic-bezier(0.4, 0, 0.2, 1);
}
```

## スクロールフェードイン

```css
.fade-in {
  opacity:    0;
  transform:  translateY(16px);
  transition: opacity  var(--duration-normal) var(--ease-out),
              transform var(--duration-normal) var(--ease-out);
}

.fade-in.is-visible {
  opacity:   1;
  transform: translateY(0);
}
```

## prefers-reduced-motion

```css
@media (prefers-reduced-motion: reduce) {
  *,
  *::before,
  *::after {
    animation-duration:        0.01ms !important;
    animation-iteration-count: 1 !important;
    transition-duration:       0.01ms !important;
  }
}
```

---

# 15 レスポンシブ設計

## 各ブレークポイントでの主な変化

| 要素 | Mobile（〜767px） | Tablet（768px〜） | Desktop（1024px〜） |
|---|---|---|---|
| グローバルナビ | ハンバーガーメニュー | ハンバーガーメニュー | 横並びリンク |
| Heroの見出し | 40px | 48px | 56px |
| カードレイアウト | 1カラム | 2カラム | 3カラム |
| セクション余白 | 64px | 96px | 128px |
| コンテナのpadding | 16px | 24px | 24px |
| フォームの幅 | フル幅 | 80% | 640px（最大） |

## コンテナのpadding

```css
.container {
  padding-left:  var(--space-4);    /* モバイル: 16px */
  padding-right: var(--space-4);
}

@media (min-width: 768px) {
  .container {
    padding-left:  var(--space-6);  /* タブレット〜: 24px */
    padding-right: var(--space-6);
  }
}
```

---

# 16 アクセシビリティ

準拠基準：**WCAG 2.1 AA レベル**以上を必須とします。テキストと背景のコントラスト比は4.5:1以上とすること。

## フォーカスリング

```css
:focus-visible {
  outline:        2px solid var(--color-text);
  outline-offset: 3px;
}

.btn-primary:focus-visible {
  outline:        2px solid #FFFFFF;
  outline-offset: 3px;
  box-shadow:     0 0 0 5px var(--color-accent);
}
```

## スキップリンク

```html
<a href="#main-content" class="skip-link">
  メインコンテンツへスキップ
</a>
```

```css
.skip-link {
  position:   absolute;
  top:        -100%;
  left:       var(--space-4);
  padding:    var(--space-2) var(--space-4);
  background: var(--color-text);
  color:      #FFFFFF;
  font-size:  var(--text-sm);
  z-index:    9999;
  transition: top 150ms ease-out;
}

.skip-link:focus {
  top: var(--space-4);
}
```

## セマンティックHTMLのルール

- 見出しは `h1` → `h2` → `h3` の順に使用し、スキップしない
- リストは `ul` / `ol` + `li` で実装する（divの羅列は禁止）
- ボタンは `<button>` タグ、リンクは `<a>` タグを使用する
- フォームの `<label>` と `<input>` は `for` / `id` 属性で紐付ける

---

# 17 禁止事項

## デザイン・実装として禁止

- CSS変数（`--color-*`）以外のカラー値をCSSに直接記述すること
- 8の倍数でない余白・サイズを使用すること（ただし4pxは可）
- 1ページに複数のPrimary Buttonを配置すること
- box-shadowを多用すること（カードに装飾的な影をつけること）
- 完全な円形（border-radius: 9999px）のボタン
- `!important` の乱用（フレームワークとの競合を除く）
- インラインスタイルで色・余白を直接指定すること（CSS変数を使うこと）
- `90_アーカイブ/` 内の旧資料を参照・流用すること

## コピー・テキストとして禁止

- Website Copy v1.1に記載されていないコピーをAIが独自に生成すること
- 見出し・CTAテキストを勝手に変更すること
- 日本語・英語のフォントを逆に適用すること（英字に日本語フォントなど）

## アクセシビリティとして禁止

- フォーカスリング（`:focus-visible`）を `outline: none` で消すこと
- 色だけで情報を伝えること（アイコンやテキストを必ず併用する）
- クリック・タップ領域が44px未満のボタン・リンク
- `alt` 属性のない `<img>` タグ

---

# 18 実装チェックリスト

ページの実装が完了したら、以下のチェックリストを使用してください。

## カラー

- [ ] CSS変数（`--color-*`）のみを使用し、直接HEX値をCSSに書いていない
- [ ] アクセントカラーの使用箇所はCTAボタンと必要最小限にとどまっている
- [ ] すべてのテキストはコントラスト比4.5:1以上を満たしている

## タイポグラフィ

- [ ] フォントは確定フォント（【確認B】）のみを使用している
- [ ] 文字サイズはタイポグラフィスケールに沿った値のみを使用している
- [ ] 本文の行間（line-height）は1.8以上になっている
- [ ] Website Copy v1.1のコピーを正確に使用している（改変なし）

## 余白・グリッド

- [ ] 余白はスペーシングスケール（`--space-*`）に沿った値のみを使用している
- [ ] 8pxの倍数ではない余白値が混入していない
- [ ] 12カラムグリッドに沿ってレイアウトしている

## コンポーネント

- [ ] Primary Buttonは各ページに1つだけ
- [ ] フォームのすべての入力欄にラベルが付いている
- [ ] カードにbox-shadowを多用していない
- [ ] アイコンはOutlineスタイルで統一されている

## アクセシビリティ

- [ ] キーボードのTabキーのみで全ての操作が可能
- [ ] フォーカスリングが表示されている（消していない）
- [ ] すべての画像にalt属性が設定されている
- [ ] スキップリンクが実装されている
- [ ] 見出しの階層（h1→h2→h3）が正しい順序になっている
- [ ] `prefers-reduced-motion` 対応が実装されている

## レスポンシブ

- [ ] モバイル（375px）・タブレット（768px）・デスクトップ（1024px）の3サイズで表示確認した
- [ ] モバイルでの文字サイズは16px以上になっている
- [ ] モバイルでのタップ領域は44px × 44px以上になっている

## ブランド整合性

- [ ] Visual System v2.0の「12 Visual Checklist」を確認した
- [ ] `docs/90_アーカイブ/` の資料を使用していない
- [ ] 【確認A】〜【確認D】がすべて確定・実装に反映されている

---

# オーナー確認事項まとめ

実装前にすべての確認事項を確定してください。

| 記号 | 項目 | 確認内容 |
|---|---|---|
| 【確認A】 | ブランドカラー | 全12色（CSS変数）のHEX値を確定する |
| 【確認B】 | フォント | 日本語・欧文・等幅フォントを各1種類選択する |
| 【確認C】 | アイコンセット | 使用するアイコンライブラリを選択する |
| 【確認C-2】 | アイコン線幅 | stroke-widthの値を確定する |
| 【確認D】 | コンテナ最大幅 | 1200px / 1280px / 1440px から選択する |

---

**最終更新：2026-06-30**
**バージョン：v2.0**
**ステータス：正式版**
