;; 言語を日本語にする
(set-language-environment 'Japanese)

;; 極力UTF-8とする
(prefer-coding-system 'utf-8)

;; スタートアップメッセージを非表示
(setq inhibit-startup-message t)

;; tool-barを非表示
(tool-bar-mode 0)

;; scroll-bar を非表示
(scroll-bar-mode 0)

;; menu-bar を非表示
;(menu-bar-mode 0)

;; バックアップファイルを作らない
(setq make-backup-files nil)

;; オートセーブしない
(setq auto-save-default nil)

;; インデントはスペースで
(setq-default indent-tabs-mode nil)

;; インデントはスペース２つが基準
(setq-default tab-width 2)

;; 分割したウィンドウでも折り返し
;; C-x 3した時も折り返されるようになる
(setq truncate-partial-width-windows nil)

;; 履歴を次回Emacs起動時にも保存する
(savehist-mode t)

;; ファイル内のカーソルの位置を記憶する
(setq-default save-place t)
(require 'saveplace)

;; 対応する括弧を表示させる
(show-paren-mode t)

;; モードラインに時刻を表示させる
;;(display-time)

;; 行番号・桁番号を表示させる
(line-number-mode t)
(column-number-mode t)

;; GCを減らして軽くする(デフォルト400000バイト 約0.4M)
(setq gc-cons-threshold (* 100 gc-cons-threshold))

;; ログの記録行数を増やす(デフォルト100)
(setq message-log-max 10000)

;; ミニバッファを再帰的に呼び出せるようにする
(setq enable-recursive-minibuffers nil)

;; ダイアログボックスを使わないようにする
(setq use-dialog-box nil)
(defalias 'message-box 'message)

;; 履歴を保存する量を増やす(デフォルト30)
(setq history-length 1000)

;; キーストロークをエコーエリアに早く表示する
(setq echo-keystrokes 0.1)

;; 大きいファイルを開こうとしたときに警告を発生させる
;; デフォルトは10000000 約10M
(setq large-file-warning-threshold (* 25 1024 1024))

;; ミニバッファで入力を取り消しても履歴に残す
;; 誤って取り消して入力が失われるのを防ぐため
(defadvice abort-recursive-edit (before minibuffer-save activate)
  (when (eq (selected-window) (active-minibuffer-window))
    (add-to-history minibuffer-history-variable (minibuffer-contents))))

;; yesと入力するのは面倒なのでyで十分
(defalias 'yes-or-no-p 'y-or-n-p)
