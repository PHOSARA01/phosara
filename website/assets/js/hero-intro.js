// ----------------------------------------
// hero-intro.js — Hero Opening Animation
// PHOSARA Website — 初回ロード時のみ再生
// Design System v2.0 Section 14 参照
//
// アニメーション総尺:
//   0.25s 待機 + 0.65s ロゴ = 0.9s ロゴ完了
//   0.9s  発光開始 + 0.7s   = 1.6s 発光完了
//   1.1s  ビーム開始 + 0.8s = 1.9s ビーム完了
//   1.9s + 0.3s 落ち着き    = 2.2s フェードアウト開始
//   2.2s + 0.75s フェード   = 2.95s 完了
// ----------------------------------------
(function () {
  'use strict';

  var SESSION_KEY    = 'phi-intro';
  var FADEOUT_START  = 2200;   /* ms: フェードアウト開始 */
  var FADEOUT_DUR    = 750;    /* ms: フェードアウト所要時間 */

  // ---- prefers-reduced-motion チェック ----------------------
  // CSS 側でも対応済み。JS 側でも即時スキップ
  if (window.matchMedia &&
      window.matchMedia('(prefers-reduced-motion: reduce)').matches) {
    try { sessionStorage.setItem(SESSION_KEY, '1'); } catch (e) {}
    return;
  }

  // ---- sessionStorage: 初回以外はスキップ -------------------
  var alreadyPlayed = false;
  try {
    alreadyPlayed = !!sessionStorage.getItem(SESSION_KEY);
  } catch (e) {
    /* プライベートブラウジング等で sessionStorage が使えない場合は毎回再生 */
  }

  if (alreadyPlayed) {
    // DOM 確定後に非表示（defer 実行タイミングに関係なく対応）
    var hideOnLoad = function () {
      var el = document.getElementById('hero-intro');
      if (el) { el.hidden = true; }
    };
    if (document.readyState === 'loading') {
      document.addEventListener('DOMContentLoaded', hideOnLoad);
    } else {
      hideOnLoad();
    }
    return;
  }

  // ---- 初回: フラグをセットしてアニメーション開始 -----------
  try { sessionStorage.setItem(SESSION_KEY, '1'); } catch (e) {}

  document.addEventListener('DOMContentLoaded', function () {
    var overlay = document.getElementById('hero-intro');
    var oCircle = document.getElementById('hi-o');   /* inline SVG 内の O サークル */

    if (!overlay) { return; }

    // ---- O circle の画面 X 位置を --hi-o-x に反映 -----------
    // transform-origin とグラデーションピークを O の実座標に合わせる
    function syncBeamOrigin() {
      if (!oCircle) { return; }
      try {
        var rect = oCircle.getBoundingClientRect();
        if (rect.width === 0) { return; }     /* まだレイアウト前 */
        var cx  = rect.left + rect.width / 2;
        var pct = (cx / window.innerWidth * 100).toFixed(2) + '%';
        overlay.style.setProperty('--hi-o-x', pct);
      } catch (e) {}
    }

    syncBeamOrigin();

    // ---- フェードアウト → オーバーレイ除去 ------------------
    var fadeTimer = setTimeout(function () {
      overlay.style.transition = 'opacity ' + (FADEOUT_DUR / 1000) + 's ease-in';
      overlay.style.opacity    = '0';

      var removeTimer = setTimeout(function () {
        overlay.hidden           = true;
        overlay.style.transition = '';
        overlay.style.opacity    = '';
      }, FADEOUT_DUR + 60);

      /* 万が一フェードが終わらなくても強制除去 */
      overlay.addEventListener('transitionend', function onEnd() {
        overlay.removeEventListener('transitionend', onEnd);
        clearTimeout(removeTimer);
        overlay.hidden           = true;
        overlay.style.transition = '';
        overlay.style.opacity    = '';
      });

    }, FADEOUT_START);

    /* ESC キーでスキップ（アクセシビリティ対応） */
    function onEsc(e) {
      if (e.key !== 'Escape') { return; }
      document.removeEventListener('keydown', onEsc);
      clearTimeout(fadeTimer);
      overlay.hidden = true;
    }
    document.addEventListener('keydown', onEsc);
  });

}());
