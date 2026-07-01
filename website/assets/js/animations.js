// ----------------------------------------
// animations.js — スクロール連動アニメーション
// Design System v2.0 Section 14 参照
// ----------------------------------------
(function () {
  'use strict';

  // ---- DOM 読み込み完了後に初期化 ----------------------------
  document.addEventListener('DOMContentLoaded', function () {

    var targets = document.querySelectorAll('.fade-in');

    // 監視対象がなければ処理しない
    if (targets.length === 0) { return; }

    // ---- prefers-reduced-motion 対応 -----------------------
    // アニメーション軽減設定が有効な場合はすべて即座に .is-visible を付与する
    if (window.matchMedia('(prefers-reduced-motion: reduce)').matches) {
      for (var i = 0; i < targets.length; i++) {
        targets[i].classList.add('is-visible');
      }
      return;
    }

    // ---- IntersectionObserver 非対応ブラウザへのフォールバック --
    // 対応していない環境ではすべて即座に .is-visible を付与して表示する
    if (!('IntersectionObserver' in window)) {
      for (var j = 0; j < targets.length; j++) {
        targets[j].classList.add('is-visible');
      }
      return;
    }

    // ---- Intersection Observer の設定 ----------------------
    var observer = new IntersectionObserver(function (entries) {
      entries.forEach(function (entry) {
        if (entry.isIntersecting) {
          // .is-visible を付与してアニメーションを発火
          entry.target.classList.add('is-visible');
          // 一度表示した要素は再監視しない
          observer.unobserve(entry.target);
        }
      });
    }, {
      threshold: 0.2  // 要素が20%以上表示されたタイミングで発火
    });

    // ---- 対象要素の監視を開始 --------------------------------
    for (var k = 0; k < targets.length; k++) {
      observer.observe(targets[k]);
    }

  });

}());
