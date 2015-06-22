(require 'auto-install)
(auto-install-compatibility-setup)


;;; .elファイル自動コンパイル
(require 'auto-async-byte-compile)
;; 自動バイトコンパイルを無効にするファイル名の正規表現
(setq auto-async-byte-compile-exclude-files-regexp "/junk/")
(add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)


;;; 同じコマンドを連続実行した場合の振る舞い変更
(require 'sequential-command-config)
(sequential-command-setup-keys)


;;; 自動保存。保存=バージョン管理と考える
(require 'auto-save-buffers-enhanced)
;(setq auto-save-buffers-enhanced-interval 1) ; 指定のアイドル秒で保存
(auto-save-buffers-enhanced t)


;;; recentf-ext導入
(require 'recentf-ext)
;; 履歴を保存する件数を設定
(setq recentf-max-saved-items 500)
;; 最近使ったファイルに含めないファイルを正規表現で指定
;(setq recentf-exclude '("/TAGS$" "/var/tmp/"))


;;; auto-complete導入
(require 'auto-complete-config)
(ac-config-default)


