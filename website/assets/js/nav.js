// ----------------------------------------
// nav.js — モバイルナビゲーション開閉制御
// Design System v2.0 Section 10 参照
// ----------------------------------------
(function () {
  'use strict';

  // ---- DOM 読み込み完了後に初期化 ----------------------------
  document.addEventListener('DOMContentLoaded', function () {

    var toggle = document.querySelector('.nav-toggle');
    var menu   = document.getElementById('mobile-menu');

    // 要素が存在しない場合は処理しない
    if (!toggle || !menu) { return; }

    // ---- メニューを開く ----------------------------------------
    function openMenu() {
      menu.hidden = false;
      menu.setAttribute('aria-hidden',   'false');
      toggle.setAttribute('aria-expanded', 'true');
      toggle.setAttribute('aria-label',    'メニューを閉じる');
    }

    // ---- メニューを閉じる --------------------------------------
    function closeMenu() {
      menu.hidden = true;
      menu.setAttribute('aria-hidden',   'true');
      toggle.setAttribute('aria-expanded', 'false');
      toggle.setAttribute('aria-label',    'メニューを開く');
    }

    // ---- ハンバーガーボタン クリック（開閉切り替え） -----------
    toggle.addEventListener('click', function () {
      if (menu.hidden) {
        openMenu();
      } else {
        closeMenu();
      }
    });

    // ---- Escキーで閉じる（フォーカスをボタンに戻す） ----------
    document.addEventListener('keydown', function (event) {
      if (event.key === 'Escape' && !menu.hidden) {
        closeMenu();
        toggle.focus();
      }
    });

    // ---- メニュー外クリックで閉じる ---------------------------
    document.addEventListener('click', function (event) {
      if (
        !menu.hidden &&
        !toggle.contains(event.target) &&
        !menu.contains(event.target)
      ) {
        closeMenu();
      }
    });

    // ---- メニュー内のリンクをクリックで閉じる -----------------
    var links = menu.querySelectorAll('a');
    for (var i = 0; i < links.length; i++) {
      links[i].addEventListener('click', function () {
        closeMenu();
      });
    }

  });
}());
