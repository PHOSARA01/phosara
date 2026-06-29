# PHOSARA_Website_Technical_Specification_v1.0

## 01 ディレクトリ構成

-   app/
-   public/
-   assets/
-   components/
-   layouts/
-   pages/
-   styles/
-   scripts/
-   docs/

## 02 HTML構成

HTML5セマンティック要素を使用し、ページごとの共通レイアウトを採用する。

## 03 CSS設計

Design Systemを基準とし、コンポーネント単位で管理する。

## 04 JavaScript設計

機能ごとにモジュール化し、グローバル汚染を避ける。

## 05 Tailwind CSS運用方針

デザイントークンに基づくユーティリティクラスを利用する。

## 06 アセット管理

画像・動画・アイコン・フォントを用途別に整理する。

## 07 GitHub運用ルール

main / develop / feature ブランチを基本とし、Pull
Requestでレビューを行う。

## 08 Claude Code実装ルール

Blueprint・Copy・Design System・Component Library・UI System・Animation
Systemを唯一の実装基準とする。

## 09 パフォーマンス最適化

画像最適化、Lazy Load、コード分割、キャッシュを実施する。

## 10 SEO実装要件

構造化データ、メタタグ、OGP、XMLサイトマップを実装する。

## 11 アクセシビリティ実装要件

WCAGに準拠し、キーボード操作・代替テキスト・ARIA属性を実装する。

## 12 セキュリティ方針

HTTPS、入力値検証、CSRF/XSS対策を行う。

## 13 デプロイ方針

GitHub連携による自動デプロイを基本とする。

## 14 保守・運用ルール

Documentation Systemに従い、変更履歴・バージョン管理を徹底する。
