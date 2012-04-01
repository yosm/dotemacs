;; 専用のファイルを作るまでもない小規模なもの用

;; エラー回避
;; (eval-when-compile
;;   (defvar org-directory ""))


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
(run-with-idle-timer 1 t 'auto-save-buffers) ; アイドル2秒で保存


;;; magit http://philjackson.github.com/magit/index.html
;;; バージョン1.0になって、公式が移動している模様
(require 'magit)


;;; recentf-ext導入
(require 'recentf-ext)
;; 履歴を保存する件数を設定
(setq recentf-max-saved-items 500)
;; 最近使ったファイルに含めないファイルを正規表現で指定
;(setq recentf-exclude '("/TAGS$" "/var/tmp/"))


;;; anything
;;; auto-install-batch anything
(require 'anything-startup)

;;; rails
;;; https://github.com/yosm/anything-of-rails
(require 'rails)


;;; 試行錯誤用ファイルを開くための設定
(require 'open-junk-file)
;; C-x C-zで試行錯誤ファイルを開く
(global-set-key (kbd "C-x C-z") 'open-junk-file)

;;; 式の評価結果を注釈するための設定
(require 'lispxmp)
;; emacs-lisp-modeでC-c C-dを押すと注釈される
(define-key emacs-lisp-mode-map (kbd "C-c C-d") 'lispxmp)

;;; 括弧の対応を保持して編集する設定
(require 'paredit)
(add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-mode-hook 'enable-paredit-mode)
(add-hook 'ielm-mode-hook 'enable-paredit-mode)


(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)
(setq eldoc-idle-delay 0.2) ; すぐ表示したい
(setq eldoc-minor-mode-string "") ; モードラインにElDocと表示しない

;; 釣合のとれる括弧をハイライトする
(show-paren-mode 1)

;; 改行と同時にインデントも行う
(global-set-key "\C-m" 'newline-and-indent)

;; find-functionをキー割り当てする
(find-function-setup-keys)