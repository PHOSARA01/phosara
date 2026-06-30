# PHOSARA_Website_Technical_Guide_v2.0

> PHOSARAウェブサイト 技術仕様書
> Version 2.0 — 2026-06-30

---

# 01 本書について

## 目的

本書はPHOSARA公式Websiteを実装するための**技術仕様書**です。
実装担当者（人・Claude Code）が、迷わず正しい方法でコードを書けるよう定義します。

## 他資料との役割分担

| 資料 | 役割 |
|---|---|
| Visual System v2.0 | デザインの思想・方針 |
| Blueprint v1.1 | ページ構造・情報設計・導線 |
| Copy v1.1 | テキスト・コピー（改変禁止） |
| Design System v2.0 | 実装に使う具体値（数値・トークン） |
| **本書（Technical Guide v2.0）** | **実装方法・ファイル構成・ルール ← このファイル** |

## 本書の読み方

- 実装前に必ず01〜03を読む
- 各機能の実装時は該当セクションを参照する
- 疑問が生じたら、上記の優先順位に従って上位資料を確認する

---

# 02 技術方針

## 採用技術スタック

PHOSARAウェブサイトの初期実装は、以下の構成とします。

| 領域 | 採用技術 |
|---|---|
| HTML | Vanilla HTML5 |
| CSS | Vanilla CSS（CSS Custom Properties） |
| JavaScript | Vanilla JavaScript（ES2020以降） |
| ホスティング | Vercel（静的サイトとして配信） |
| バージョン管理 | GitHub |

## フレームワーク・ライブラリを使わない理由

初期実装においてNext.js・Astro・React・Tailwind CSSは採用しません。

**理由：**
- ビルドステップが不要で、HTMLファイルをそのまま配信できる
- 依存ライブラリのバージョン管理コストが発生しない
- コードの内容が人間・AIの両方にとって読みやすい
- Vanilla HTMLならどのエンジニアでもメンテナンスできる
- 将来フレームワークへ移行する判断が正確にできる

**将来の拡張方針：**
サイト規模拡大・CMS連携・動的コンテンツが必要になった段階で、
Next.js（App Router）または Astro への移行を検討します。
その判断はオーナーとの合意のうえで行います。

## 外部ライブラリのルール

外部JavaScriptライブラリの追加は、オーナーの明示的な承認なしに行ってはいけません。

唯一の例外：アイコンライブラリ（【確認C】確定後に追加）

---

# 03 フォルダ構成

## ディレクトリツリー

```
PHOSARA（GitHubリポジトリ）/
│
├── docs/                         ← 設計資料（実装には含めない）
├── scripts/                      ← 自動化スクリプト（将来）
│
├── vercel.json                   ← Vercel設定ファイル
│
└── website/                      ← Vercelが配信するルートディレクトリ
    │
    ├── index.html                → https://phosara.com/
    ├── about/
    │   └── index.html            → https://phosara.com/about/
    ├── approach/
    │   └── index.html            → https://phosara.com/approach/
    ├── services/
    │   └── index.html            → https://phosara.com/services/
    ├── industries/
    │   ├── index.html            → https://phosara.com/industries/
    │   ├── construction/
    │   │   └── index.html        → https://phosara.com/industries/construction/
    │   ├── remodeling/
    │   │   └── index.html        → https://phosara.com/industries/remodeling/
    │   ├── clinic/
    │   │   └── index.html        → https://phosara.com/industries/clinic/
    │   └── pachinko/
    │       └── index.html        → https://phosara.com/industries/pachinko/
    ├── works/
    │   └── index.html            → https://phosara.com/works/
    ├── journal/
    │   └── index.html            → https://phosara.com/journal/
    ├── contact/
    │   └── index.html            → https://phosara.com/contact/
    │
    ├── assets/
    │   ├── css/
    │   │   ├── tokens.css        ← Design System CSS変数（カラー・余白・フォント）
    │   │   ├── base.css          ← リセット・html・bodyの基本スタイル
    │   │   ├── layout.css        ← ヘッダー・フッター・コンテナ・グリッド
    │   │   ├── components.css    ← ボタン・カード・フォーム・アイコン
    │   │   └── pages/
    │   │       ├── top.css       ← TOPページ固有スタイル
    │   │       ├── about.css
    │   │       ├── approach.css
    │   │       ├── services.css
    │   │       ├── industries.css
    │   │       ├── works.css
    │   │       ├── journal.css
    │   │       └── contact.css
    │   ├── js/
    │   │   ├── main.js           ← 全ページ共通の初期化処理
    │   │   ├── nav.js            ← ハンバーガーメニュー・ナビゲーション
    │   │   └── animations.js     ← スクロールフェードイン（Intersection Observer）
    │   └── images/
    │       ├── logos/            ← PHOSARAロゴ（SVG・PNG）
    │       ├── works/            ← 制作実績サムネイル
    │       ├── journal/          ← ブログ記事サムネイル
    │       └── og/               ← OGP画像
    │
    ├── favicon.ico
    ├── apple-touch-icon.png
    ├── sitemap.xml
    └── robots.txt
```

## ファイル命名規則

| 対象 | 規則 | 例 |
|---|---|---|
| HTMLファイル | `index.html`（フォルダ名でURLを表現） | `about/index.html` |
| CSSファイル | kebab-case | `base.css`, `components.css` |
| JSファイル | kebab-case | `main.js`, `nav.js` |
| 画像ファイル | kebab-case | `phosara-logo.svg`, `works-001.jpg` |
| フォルダ名 | 英数字・kebab-case（日本語不使用） | `construction/`, `og/` |

---

# 04 HTML実装ルール

## ページの基本構造

すべてのHTMLファイルは以下の構造を基本とします。

```html
<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="ページの説明文（120文字以内）">
  <title>ページタイトル | PHOSARA</title>

  <!-- OGP -->
  <meta property="og:title"       content="ページタイトル | PHOSARA">
  <meta property="og:description" content="ページの説明文">
  <meta property="og:image"       content="https://phosara.com/assets/images/og/og-default.jpg">
  <meta property="og:url"         content="https://phosara.com/ページのURL">
  <meta property="og:type"        content="website">

  <!-- Canonical -->
  <link rel="canonical" href="https://phosara.com/ページのURL">

  <!-- Favicon -->
  <link rel="icon"             href="/favicon.ico">
  <link rel="apple-touch-icon" href="/apple-touch-icon.png">

  <!-- CSS（読み込み順を守る） -->
  <link rel="stylesheet" href="/assets/css/tokens.css">
  <link rel="stylesheet" href="/assets/css/base.css">
  <link rel="stylesheet" href="/assets/css/layout.css">
  <link rel="stylesheet" href="/assets/css/components.css">
  <link rel="stylesheet" href="/assets/css/pages/top.css">   <!-- ページ固有 -->
</head>
<body>

  <!-- スキップリンク（アクセシビリティ必須） -->
  <a href="#main-content" class="skip-link">メインコンテンツへスキップ</a>

  <!-- ========================================
    Header - グローバルナビゲーション
    Blueprint Section 08 参照
  ======================================== -->
  <header class="global-header">
    <div class="global-header-inner">
      <a href="/" class="site-logo" aria-label="PHOSARA トップページへ">
        <img src="/assets/images/logos/phosara-logo.svg" alt="PHOSARA" width="120" height="32">
      </a>
      <nav class="global-nav" aria-label="グローバルナビゲーション">
        <ul class="nav-list">
          <li><a href="/about/"      class="nav-link">ABOUT</a></li>
          <li><a href="/approach/"   class="nav-link">APPROACH</a></li>
          <li><a href="/services/"   class="nav-link">SERVICES</a></li>
          <li><a href="/industries/" class="nav-link">INDUSTRIES</a></li>
          <li><a href="/works/"      class="nav-link">WORKS</a></li>
          <li><a href="/journal/"    class="nav-link">JOURNAL</a></li>
        </ul>
      </nav>
      <a href="/contact/" class="btn-primary nav-cta">無料相談</a>
      <button class="nav-toggle" aria-label="メニューを開く" aria-expanded="false" aria-controls="mobile-menu">
        <span class="nav-toggle-bar"></span>
        <span class="nav-toggle-bar"></span>
        <span class="nav-toggle-bar"></span>
      </button>
    </div>
    <!-- モバイルメニュー -->
    <div id="mobile-menu" class="mobile-menu" hidden>
      <!-- ナビリンクをここにも複製する -->
    </div>
  </header>

  <!-- ========================================
    Main Content
  ======================================== -->
  <main id="main-content">

    <!-- 各セクションをここに実装する -->

  </main>

  <!-- ========================================
    Footer
    Blueprint Section 参照
  ======================================== -->
  <footer class="global-footer">
    <div class="container">
      <!-- フッターコンテンツ -->
    </div>
  </footer>

  <!-- JavaScript（bodyの閉じタグ直前に配置） -->
  <script src="/assets/js/main.js"       defer></script>
  <script src="/assets/js/nav.js"        defer></script>
  <script src="/assets/js/animations.js" defer></script>

</body>
</html>
```

## セマンティックHTMLのルール

| 目的 | 使うタグ | 禁止 |
|---|---|---|
| ページの主要内容 | `<main>` | `<div id="main">` |
| 繰り返すナビ | `<nav>` | `<div class="nav">` |
| セクション区切り | `<section>` | `<div class="section">` |
| 記事・カード | `<article>` | `<div class="article">` |
| 補足情報 | `<aside>` | `<div class="side">` |
| 見出し | `<h1>`〜`<h3>`（順序厳守） | 見出しの飛ばし使い |
| リスト | `<ul>`・`<ol>` + `<li>` | divの羅列 |
| フォーム送信 | `<button type="submit">` | `<div onclick="">` |
| 外部リンク | `<a href="..." target="_blank" rel="noopener">` | — |

## クラス命名規則（BEM）

BEMの考え方に基づき、以下のルールでクラス名を付けます。

```
Block（コンポーネント）   : .card
Element（子要素）         : .card__title  .card__body  .card__image
Modifier（状態・バリエーション） : .card--featured  .btn-primary--disabled
```

**例：**

```html
<article class="card">
  <div class="card__image">
    <img src="..." alt="...">
  </div>
  <div class="card__body">
    <h3 class="card__title">タイトル</h3>
    <p class="card__text">説明文</p>
  </div>
</article>
```

## 禁止事項（HTML）

- `<div>` だけでナビ・リスト・ボタンを作ること
- `onclick="..."` のインラインイベントハンドラ
- `style="..."` のインラインスタイル
- `<table>` をレイアウト目的で使うこと
- `alt` 属性のない `<img>` タグ
- `<h1>` を複数配置すること（1ページに1つ）

---

# 05 CSS実装ルール

## CSSファイルの読み込み順

順番を守ることで、スタイルが正しく上書きされます。

```
tokens.css       ← 1番目：CSS変数（カラー・余白・フォント）
base.css         ← 2番目：リセット・html・body
layout.css       ← 3番目：ヘッダー・フッター・コンテナ・グリッド
components.css   ← 4番目：ボタン・カード・フォームなどの部品
pages/top.css    ← 5番目：そのページ固有のスタイル（必要な場合のみ）
```

## tokens.css の構成

Design System v2.0 のCSS変数をすべてここに定義します。
**CSSファイル内に直接HEX値・rem値を書いてはいけません。必ず変数を使います。**

```css
/* ------------------------------------------
  tokens.css
  Design System v2.0 参照
------------------------------------------ */
:root {
  /* カラー（【確認A】確定後に記入） */
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

  /* フォント（【確認B】確定後に記入） */
  --font-jp:   '<日本語フォント>', 'Hiragino Sans', 'Yu Gothic', sans-serif;
  --font-en:   '<欧文フォント>', system-ui, -apple-system, sans-serif;
  --font-mono: '<等幅フォント>', monospace;

  /* フォントサイズ */
  --text-display: 3.5rem;
  --text-h1:      2.5rem;
  --text-h2:      2rem;
  --text-h3:      1.5rem;
  --text-h4:      1.25rem;
  --text-lg:      1.125rem;
  --text-base:    1rem;
  --text-sm:      0.875rem;
  --text-xs:      0.75rem;

  /* 行間 */
  --leading-display: 1.15;
  --leading-heading: 1.3;
  --leading-body:    1.8;
  --leading-tight:   1.5;

  /* 太さ */
  --weight-normal:   400;
  --weight-semibold: 600;
  --weight-bold:     700;

  /* 余白（8px基準） */
  --space-1:  0.25rem;
  --space-2:  0.5rem;
  --space-3:  0.75rem;
  --space-4:  1rem;
  --space-6:  1.5rem;
  --space-8:  2rem;
  --space-12: 3rem;
  --space-16: 4rem;
  --space-20: 5rem;
  --space-24: 6rem;
  --space-32: 8rem;
  --space-40: 10rem;

  /* グリッド */
  --grid-columns:      12;
  --grid-gutter:       1.5rem;
  --container-max:     1200px;
  --container-padding: 1.5rem;

  /* アニメーション */
  --duration-fast:   150ms;
  --duration-normal: 250ms;
  --duration-slow:   400ms;
  --ease-out:        cubic-bezier(0, 0, 0.2, 1);
  --ease-in:         cubic-bezier(0.4, 0, 1, 1);
  --ease-standard:   cubic-bezier(0.4, 0, 0.2, 1);
}
```

## base.css の構成

```css
/* ------------------------------------------
  base.css
  リセットと基本スタイル
------------------------------------------ */

/* リセット */
*, *::before, *::after {
  box-sizing: border-box;
  margin:     0;
  padding:    0;
}

html {
  font-size:   16px;
  scroll-behavior: smooth;
}

body {
  background-color: var(--color-bg);
  color:            var(--color-text);
  font-family:      var(--font-jp);
  font-size:        var(--text-base);
  line-height:      var(--leading-body);
  -webkit-font-smoothing:  antialiased;
  -moz-osx-font-smoothing: grayscale;
}

img, video {
  max-width:   100%;
  height:      auto;
  display:     block;
}

ul, ol {
  list-style: none;
}

a {
  color:           inherit;
  text-decoration: none;
}

button {
  background: none;
  border:     none;
  cursor:     pointer;
  font:       inherit;
}

/* フォーカスリング（アクセシビリティ必須） */
:focus-visible {
  outline:        2px solid var(--color-text);
  outline-offset: 3px;
}

/* prefers-reduced-motion */
@media (prefers-reduced-motion: reduce) {
  *, *::before, *::after {
    animation-duration:        0.01ms !important;
    animation-iteration-count: 1 !important;
    transition-duration:       0.01ms !important;
  }
}
```

## CSSのルール

- クラスはBEMに従う（`#id` セレクタでスタイルを当てない）
- 値はすべてCSS変数を使う（直接の数値・HEX値は書かない）
- `!important` は原則禁止（フレームワーク競合の場合を除く）
- インラインスタイルは禁止
- ブレークポイントはモバイルファーストで書く（`min-width` を使う）
- 余白は `--space-*` 変数のみを使用する（8px以外の値は使わない）

---

# 06 JavaScript実装ルール

## 基本方針

- **Vanilla JavaScript のみ使用**（jQuery・他ライブラリは使わない）
- `defer` 属性で非同期読み込みにし、描画をブロックしない
- グローバル変数を増やさない（関数・クラスにまとめる）
- `DOMContentLoaded` または `defer` を使い、DOM読み込み後に処理を実行する

## main.js（共通処理）

```javascript
// ----------------------------------------
// main.js
// 全ページ共通の初期化処理
// ----------------------------------------
document.addEventListener('DOMContentLoaded', () => {
  // 現在のページのナビリンクにis-activeを付与
  const currentPath = window.location.pathname;
  document.querySelectorAll('.nav-link').forEach(link => {
    if (link.getAttribute('href') === currentPath ||
        currentPath.startsWith(link.getAttribute('href')) && link.getAttribute('href') !== '/') {
      link.classList.add('is-active');
      link.setAttribute('aria-current', 'page');
    }
  });
});
```

## nav.js（ハンバーガーメニュー）

```javascript
// ----------------------------------------
// nav.js
// モバイルナビゲーション
// ----------------------------------------
document.addEventListener('DOMContentLoaded', () => {
  const toggle  = document.querySelector('.nav-toggle');
  const menu    = document.querySelector('.mobile-menu');
  if (!toggle || !menu) return;

  toggle.addEventListener('click', () => {
    const isOpen = toggle.getAttribute('aria-expanded') === 'true';
    toggle.setAttribute('aria-expanded', String(!isOpen));
    toggle.setAttribute('aria-label', isOpen ? 'メニューを開く' : 'メニューを閉じる');
    menu.hidden = isOpen;
  });

  // Escキーでメニューを閉じる
  document.addEventListener('keydown', (e) => {
    if (e.key === 'Escape' && !menu.hidden) {
      menu.hidden = true;
      toggle.setAttribute('aria-expanded', 'false');
      toggle.focus();
    }
  });
});
```

## animations.js（スクロールフェードイン）

```javascript
// ----------------------------------------
// animations.js
// Intersection Observerによるフェードイン
// Design System Section 14 参照
// ----------------------------------------
document.addEventListener('DOMContentLoaded', () => {
  const targets = document.querySelectorAll('.fade-in');
  if (!targets.length) return;

  const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        entry.target.classList.add('is-visible');
        observer.unobserve(entry.target);
      }
    });
  }, { threshold: 0.1 });

  targets.forEach(el => observer.observe(el));
});
```

## JavaScriptのルール

- `var` は使わない（`const` または `let` を使う）
- 要素が存在しない場合の null チェックを必ず行う
- `innerHTML` でのユーザー入力の反映は禁止（XSSリスク）
- フォームのバリデーションはサーバー側でも必ず行う（JS のみに頼らない）
- コンソールへの `console.log` はリリース前に削除する

---

# 07 アクセシビリティ実装

## 準拠基準

**WCAG 2.1 AA レベル**以上を必須とします。

## 必須実装リスト

| 項目 | 実装方法 |
|---|---|
| スキップリンク | `<a href="#main-content" class="skip-link">` を `<body>` 直後に配置 |
| フォーカスリング | `base.css` の `:focus-visible` で定義済み。消してはいけない |
| 見出し階層 | `h1` → `h2` → `h3` の順に使用。スキップ禁止 |
| ランドマーク | `<header>`, `<main>`, `<nav>`, `<footer>` を正しく使う |
| 画像のalt | `<img>` には必ず `alt` 属性。装飾のみなら `alt=""` |
| フォームラベル | `<label for="id">` と `<input id="id">` を紐付ける |
| ボタンとリンク | 行動には `<button>`、移動には `<a>` を使い分ける |
| アイコンのみのボタン | `aria-label` で名前を提供する |
| ナビゲーション | `<nav aria-label="グローバルナビゲーション">` でラベルを付ける |
| 現在ページのリンク | `aria-current="page"` を付与する |
| コントラスト比 | テキストと背景の比率は4.5:1以上（確認A確定後に測定） |

## スキップリンクのCSS（`base.css` に記載）

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

---

# 08 レスポンシブ実装

## 基本方針

**モバイルファースト**で実装します。
モバイルのスタイルを先に書き、`min-width` で上書きします。

```css
/* 正しい書き方（モバイルファースト） */
.heading {
  font-size: var(--text-h1);   /* モバイル */
}

@media (min-width: 768px) {
  .heading {
    font-size: var(--text-display); /* タブレット以上 */
  }
}
```

## ブレークポイント（Design System Section 06 参照）

| 名称 | 幅 | 使用するメディアクエリ |
|---|---|---|
| Mobile（デフォルト） | 〜767px | なし（デフォルトスタイル） |
| Tablet | 768px〜 | `@media (min-width: 768px)` |
| Desktop | 1024px〜 | `@media (min-width: 1024px)` |
| Large | 1280px〜 | `@media (min-width: 1280px)` |

## レスポンシブ画像

```html
<!-- 基本的な画像 -->
<img
  src="/assets/images/works/works-001.jpg"
  alt="制作実績の説明"
  width="800"
  height="450"
  loading="lazy"
>

<!-- 解像度に応じた画像の切り替え（将来対応） -->
<picture>
  <source srcset="image.webp" type="image/webp">
  <img src="image.jpg" alt="..." width="800" height="450" loading="lazy">
</picture>
```

## コンテナの実装（Design System Section 05 参照）

```css
.container {
  max-width:     var(--container-max);   /* 1200px（【確認D】） */
  margin-left:   auto;
  margin-right:  auto;
  padding-left:  var(--space-4);         /* モバイル: 16px */
  padding-right: var(--space-4);
}

@media (min-width: 768px) {
  .container {
    padding-left:  var(--space-6);       /* タブレット〜: 24px */
    padding-right: var(--space-6);
  }
}
```

---

# 09 パフォーマンス方針

## 目標値

| 指標 | 目標 |
|---|---|
| LCP（最大コンテンツの表示） | 2.5秒以内 |
| FID（インタラクションの応答） | 100ms以内 |
| CLS（レイアウトシフト） | 0.1以下 |

## 実装上のルール

### 画像最適化

- 画像はWebP形式を優先し、JPGをフォールバックとする
- サムネイル画像は用途に応じたサイズ（1倍・2倍）を用意する
- `<img>` には必ず `width` と `height` 属性を指定し、レイアウトシフトを防ぐ
- Hero画像以外はすべて `loading="lazy"` を付与する
- Hero画像は `loading="eager"` とし、優先的に読み込む

### CSS

- CSSファイルは `<head>` 内に読み込む（レンダリングブロックはやむを得ない）
- 未使用のCSSを書かない
- アニメーションは `transform` と `opacity` のみを使う（`width`・`height`・`top` は使わない）

### JavaScript

- `<script>` は `defer` 属性を付けて `</body>` 直前に配置する
- ページ表示に不要なJSは実行しない
- Intersection Observer を使い、画面外の処理は遅延させる

### フォント

- Webフォントは `font-display: swap` を使い、フォント読み込み中もテキストを表示する
- 読み込むウェイト（太さ）を必要最小限に絞る（400・600・700の3種類）

---

# 10 SEO基本方針

## ページごとの設定

各ページに以下を設定します。

| 項目 | ルール |
|---|---|
| `<title>` | `ページ固有タイトル | PHOSARA`（60文字以内） |
| `<meta name="description">` | そのページの説明（120文字以内） |
| `<h1>` | ページを代表する見出し（1ページに1つ） |
| `rel="canonical"` | 正規URLを明示する |
| OGP `og:image` | 1200×630pxの画像を用意する |

## robots.txt

```
User-agent: *
Allow: /
Sitemap: https://phosara.com/sitemap.xml
```

## sitemap.xml（基本構成）

```xml
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  <url><loc>https://phosara.com/</loc><priority>1.0</priority></url>
  <url><loc>https://phosara.com/about/</loc><priority>0.8</priority></url>
  <url><loc>https://phosara.com/approach/</loc><priority>0.8</priority></url>
  <url><loc>https://phosara.com/services/</loc><priority>0.8</priority></url>
  <url><loc>https://phosara.com/industries/</loc><priority>0.7</priority></url>
  <url><loc>https://phosara.com/works/</loc><priority>0.7</priority></url>
  <url><loc>https://phosara.com/journal/</loc><priority>0.6</priority></url>
  <url><loc>https://phosara.com/contact/</loc><priority>0.9</priority></url>
</urlset>
```

## JSON-LD（構造化データ）

TOPページに以下を追加します。

```html
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "Organization",
  "name": "PHOSARA",
  "url": "https://phosara.com",
  "description": "Business Auditを起点とするコンサルティングファーストのクリエイティブブランド"
}
</script>
```

---

# 11 Vercelデプロイ

## 前提

PHOSARAウェブサイトはGitHubリポジトリと連携したVercelで配信します。
`main` ブランチへのマージ（またはPush）が本番デプロイとなります。

## vercel.json の設定

リポジトリルートに `vercel.json` を配置します。

```json
{
  "outputDirectory": "website",
  "cleanUrls": true,
  "trailingSlash": true,
  "headers": [
    {
      "source": "/(.*)",
      "headers": [
        { "key": "X-Content-Type-Options",  "value": "nosniff" },
        { "key": "X-Frame-Options",          "value": "DENY" },
        { "key": "X-XSS-Protection",         "value": "1; mode=block" },
        { "key": "Referrer-Policy",          "value": "strict-origin-when-cross-origin" }
      ]
    },
    {
      "source": "/assets/(.*)",
      "headers": [
        { "key": "Cache-Control", "value": "public, max-age=31536000, immutable" }
      ]
    }
  ]
}
```

## 設定のポイント

| 設定キー | 値 | 意味 |
|---|---|---|
| `outputDirectory` | `website` | `website/` フォルダをサイトルートとして配信する |
| `cleanUrls` | `true` | `/about/index.html` → `/about/` のようにURLを整形する |
| `trailingSlash` | `true` | URLの末尾に `/` を付ける（SEO上の重複防止） |

## デプロイフロー

```
ローカルで実装・確認
    ↓
feature/ページ名 ブランチにcommit
    ↓
GitHubにPush
    ↓
Pull Requestを作成
    ↓
オーナーレビュー・承認
    ↓
develop ブランチにマージ → プレビューURL（Vercel）で確認
    ↓
main ブランチにマージ → 本番URL（phosara.com）に反映
```

---

# 12 Git運用ルール

## ブランチ戦略（CLAUDE.md準拠）

| ブランチ | 役割 |
|---|---|
| `main` | 本番環境（直接コミット禁止） |
| `develop` | 開発統合ブランチ |
| `feature/ページ名` | 新ページの実装（例：`feature/top-page`） |
| `fix/修正内容` | バグ修正（例：`fix/nav-mobile`） |

## コミットメッセージ規則（CLAUDE.md準拠）

```
site:     Webサイト実装（例：site: add top page hero section）
fix:      修正（例：fix: correct nav link order）
style:    デザイン・CSS調整（例：style: adjust card padding）
docs:     資料更新（例：docs: update technical guide）
chore:    管理作業（例：chore: update sitemap.xml）
```

## 作業の流れ

```bash
# 1. developブランチから新しいfeatureブランチを作成する
git checkout develop
git checkout -b feature/top-page

# 2. ファイルを実装・編集する

# 3. 変更をステージングする（関係ファイルだけを指定する）
git add website/index.html website/assets/css/pages/top.css

# 4. コミットする
git commit -m "site: add top page hero section"

# 5. GitHubにPushする
git push origin feature/top-page

# 6. GitHubでPull Requestを作成し、オーナーにレビューを依頼する
```

## 禁止事項（CLAUDE.md準拠）

- `main` ブランチへの直接コミット
- `git push --force`（force push）
- `git reset --hard` の無断使用
- `.env` など機密情報のコミット

---

# 13 Claude Code作業ルール

## 実装前に必ず確認する資料

Claude Code が実装を開始する前に、以下の順番で資料を確認します。

1. `PHOSARA_Website_Blueprint_v1.1.md` — ページ構造・導線の確認
2. `PHOSARA_Website_Copy_v1.1.md` — 使用するテキストの確認
3. `PHOSARA_Website_Design_System_v2.0.md` — 使用する数値・トークンの確認
4. `PHOSARA_Website_Technical_Guide_v2.0.md`（本書） — 実装方法の確認

## Claude Code が自律的にできること

| 作業 | 可否 |
|---|---|
| HTMLの構造作成 | ✅ 可（セマンティックHTMLに従う） |
| CSSの実装 | ✅ 可（Design SystemのCSS変数を使う） |
| JavaScriptの実装 | ✅ 可（Vanilla JSのみ） |
| 設計資料の読み込み・参照 | ✅ 可 |
| ファイルの新規作成 | ✅ 可（`website/` 内のみ） |
| ファイルの編集 | ✅ 可（変更内容をdiffで提示後） |
| git add・git commit | ✅ 可（オーナーの承認後） |

## Claude Code が単独でできないこと

| 作業 | ルール |
|---|---|
| `git push` | オーナーの明示的な指示が必要 |
| `git merge` / `git reset` | オーナーの明示的な指示が必要 |
| 外部ライブラリの追加 | オーナーの承認が必要 |
| コピー（テキスト）の改変 | 禁止（Website Copyから正確に引用） |
| ブランドカラーHEXの独自決定 | 禁止（【確認A】確定まで禁止） |
| フォントの独自決定 | 禁止（【確認B】確定まで禁止） |
| 複数ファイルの同時変更 | 計画を提示→承認→実施の順番が必要 |

## Claude Code への依頼フォーマット例

```
# 依頼例：TOPページ Heroセクションの実装

## 対象ファイル
- website/index.html（Heroセクションのみ）
- website/assets/css/pages/top.css（Hero関連スタイルのみ）

## 参照資料
- Blueprint Section 09（TOPページ構成）
- Copy v1.1（Heroコピー）
- Design System Section 02〜07（カラー・タイポグラフィ・ボタン）

## 注意事項
- コピーはWebsite Copyから正確に引用する
- CSS変数のみ使用。HEX直書き禁止
- 実装後はdiffを表示する
- commitはしない（確認後に指示する）
```

## 差分（diff）レビューのルール

Claude Code が編集を行ったあと、必ず差分を確認します。

- 想定外のファイルが変更されていないか
- コピーが改変されていないか
- CSS変数以外の値が使われていないか
- 意図しない外部リンク・スクリプトが追加されていないか

確認後にcommit・pushを指示します。

---

# 14 実装チェックリスト

## 実装開始前

- [ ] Blueprint v1.1でページの目的・構成を確認した
- [ ] Copy v1.1で使用するテキストを確認した
- [ ] Design System v2.0で使用する数値・変数を確認した
- [ ] 【確認A】カラーが確定している（未確定の場合は変数のみ記述）
- [ ] 【確認B】フォントが確定している（未確定の場合はプレースホルダーのみ）

## HTML

- [ ] `lang="ja"` が設定されている
- [ ] `<meta charset="UTF-8">` が設定されている
- [ ] `<meta name="viewport">` が設定されている
- [ ] `<title>` がページごとに設定されている（60文字以内）
- [ ] `<meta name="description">` がページごとに設定されている（120文字以内）
- [ ] OGPタグ（`og:title`, `og:description`, `og:image`, `og:url`）が設定されている
- [ ] `rel="canonical"` が設定されている
- [ ] スキップリンクが `<body>` 直後に配置されている
- [ ] `<main id="main-content">` が設定されている
- [ ] `<nav aria-label="...">` でナビゲーションにラベルが付いている
- [ ] 見出しが `h1` → `h2` → `h3` の順で使われている
- [ ] すべての `<img>` に `alt`, `width`, `height` が設定されている
- [ ] Hero画像以外に `loading="lazy"` が付いている
- [ ] CSSは `<head>` 内、JSは `</body>` 直前に配置されている
- [ ] JSの `<script>` に `defer` が付いている

## CSS

- [ ] `tokens.css` → `base.css` → `layout.css` → `components.css` の順で読み込まれている
- [ ] CSS変数（`--color-*`, `--space-*` など）のみを使用している
- [ ] HEX値・固定px値・固定rem値を直接書いていない
- [ ] `!important` を不必要に使っていない
- [ ] インラインスタイル（`style="..."`）を使っていない
- [ ] ブレークポイントはモバイルファースト（`min-width`）で書いている
- [ ] `:focus-visible` を削除していない

## JavaScript

- [ ] `var` を使っていない（`const`・`let` を使っている）
- [ ] DOM要素の null チェックをしている
- [ ] `innerHTML` でユーザー入力を反映していない
- [ ] `console.log` をリリース前に削除した

## アクセシビリティ

- [ ] キーボードのTabキーだけで全操作ができる
- [ ] フォーカスリングが表示される（消していない）
- [ ] スクリーンリーダーで主要情報が読み上げられる
- [ ] 色だけで情報を伝えていない（アイコン・テキストを併用している）
- [ ] フォームラベルとinputが紐付いている（`for`/`id`）
- [ ] `prefers-reduced-motion` 対応が実装されている

## パフォーマンス

- [ ] 画像はWebP形式で用意されている
- [ ] `<img>` に `width` と `height` が設定されている（レイアウトシフト防止）
- [ ] フォントは必要なウェイトのみ読み込んでいる

## SEO

- [ ] `<title>` と `<meta description>` がページごとに設定されている
- [ ] `robots.txt` と `sitemap.xml` が配置されている
- [ ] TOPページに JSON-LD が設定されている

## レスポンシブ

- [ ] モバイル（375px）・タブレット（768px）・デスクトップ（1024px）で表示確認した
- [ ] モバイルでフォントサイズが16px以上になっている
- [ ] タップ領域が44×44px以上になっている

## Git

- [ ] `feature/*` ブランチで作業している（mainに直接コミットしていない）
- [ ] コミットメッセージが規則に従っている
- [ ] 機密情報（.env など）がコミットに含まれていない

---

**最終更新：2026-06-30**
**バージョン：v2.0**
**ステータス：正式版**
