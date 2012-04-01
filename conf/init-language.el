;; php
(require 'php-mode)
(setq php-mode-force-pear t) ;PEAR規約のインデント設定にする
(setq auto-mode-alist (cons '("\\.ctp$" . html-mode) auto-mode-alist))

;; coffee
(require 'coffee-mode)
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))

;; scss
(require 'scss-mode)
(add-to-list 'auto-mode-alist '("\\.scss$" . scss-mode))
