// ----------------------------------------
// main.js — サイト全体の初期化エントリーポイント
// ----------------------------------------
(function () {
  'use strict';

  // ---- DOM 読み込み完了後に初期化 ----------------------------
  document.addEventListener('DOMContentLoaded', function () {

    // ---- JavaScript 有効フラグを body に付与 ----------------
    // CSS で「JS が有効なときだけ適用するスタイル」を制御するために使用
    document.body.classList.add('js-enabled');

    // ---- 各モジュールの初期化ポイント -----------------------
    // 以下は該当ファイルを追加したタイミングでコメントアウトを外す

    // animations.js — スクロール連動アニメーション
    // initAnimations();

    // contact.js — お問い合わせフォームのバリデーション
    // initContact();

    // analytics.js — アクセス解析
    // initAnalytics();

  });

}());
