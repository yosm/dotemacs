;; 専用のファイルを作るまでもない小規模なもの用


;;; http://www.emacswiki.org/emacs/download/auto-install.el
(require 'auto-install)
(setq auto-install-directory "~/.emacs.d/elisp/")
;; 起動時にEmacsWikiのページ名を補完候補に加える。毎回起動時にアクセスして鬱陶しいのでコメントアウト
;; (auto-install-update-emacswiki-package-name t)
;; install-elisp.el互換モードにする
(auto-install-compatibility-setup)
;; ediff関連のバッファを１つのフレームにまとめる
;; (setq ediff-window-setup-function 'ediff-setup-windows-plain)


;;; .elファイル自動コンパイル
;;; install-elisp-from-emacswiki auto-async-byte-compile.el
(require 'auto-async-byte-compile)
;; 自動バイトコンパイルを無効にするファイル名の正規表現
(setq auto-async-byte-compile-exclude-files-regexp "/junk/")
(add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)


;;; 同じコマンドを連続実行した場合の振る舞い変更
;;; auto-install-batch sequential-command
(require 'sequential-command-config)
(sequential-command-setup-keys)


;;; 同ファイル名のバッファをわかりやすくする
(require 'uniquify)
;; filename<dir> 形式のバッファ名にする
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
;; *で囲まれたバッファ名は対象外にする
(setq uniquify-ignore-buffers-re "*[^*]+*")


;;; 自動保存。保存=バージョン管理と考える
;;; install-elisp http://homepage3.nifty.com/oatu/emacs/archives/auto-save-buffers.el
;;; Original http://Oxcc.net/misc/auto-save/auto-save/auto-save-buffers.el
;; 文字コードがEUC-JPなので、インストール時に文字コードの変換を行うこと
(require 'auto-save-buffers)
(run-with-idle-timer 2 t 'auto-save-buffers) ; アイドル2秒で保存


;;; magit http://philjackson.github.com/magit/index.html
;;; バージョン1.0になって、公式が移動している模様
(require 'magit)

