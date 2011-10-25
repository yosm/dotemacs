;; Font
(create-fontset-from-ascii-font "Menlo-12:weight=normal:slant=normal" nil "menlokakugo")
(set-fontset-font "fontset-menlokakugo"
                  'unicode
                  (font-spec :family "Hiragino Kaku Gothic ProN" :size 12)
                  nil
                  'append)
(add-to-list 'default-frame-alist '(font . "fontset-menlokakugo"))

;; 透過
(set-frame-parameter (selected-frame) 'alpha '(90 90))

;; カーソルを点滅
(blink-cursor-mode t)

;; beepと点滅をさせない
(setq ring-bell-function 'ignore)

;; mark 領域に色付け
(setq transient-mark-mode t)

;; color
(set-foreground-color "azure1")
(set-background-color "black")
(set-cursor-color "DarkGray")

;; 現在行に色をつける
(global-hl-line-mode 0)
;; 現在行の色
;;(set-face-foreground 'hl-line "")
(set-face-background 'hl-line "darkolivegreen")

;; リージョンに色をつける
(transient-mark-mode t)

;; 物理行でのカーソル移動(デフォルト t)
;; (setq line-move-visual nil)

