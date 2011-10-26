

;; php-mode
(require 'php-mode)
(setq php-mode-force-pear t) ;PEAR規約のインデント設定にする
(setq auto-mode-alist (cons '("\\.ctp$" . html-mode) auto-mode-alist))

