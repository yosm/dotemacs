;; command キーと Option キーの動作を逆に
(setq ns-command-modifier (quote meta))
(setq ns-alternate-modifier (quote super))

;; 行数を表示する
;(global-set-key "\M-n" 'linum-mode)

;; Ctrl-hでBackSpace
(global-set-key "\C-h" 'backward-delete-char)

;; Ctrl-x ?でhelp
(global-set-key (kbd "C-x ?") 'help-command)

;; fullscreen
(global-set-key (kbd "M-F") 'ns-toggle-fullscreen)


;; Ctrl-zでカーソルのある行を画面最上部にもってくる
(defun line-to-top-of-window () (interactive) (recenter 0))
(global-set-key (kbd "C-z") 'line-to-top-of-window)

;; Ctrl-tでウィンドウを切り替える。初期値はtranspose-chars
;; また分割されていない時は左右に分割する
(defun other-window-or-split ()
  (interactive)
  (when (one-window-p) (split-window-horizontally))
  (other-window 1))
(global-set-key (kbd "C-t") 'other-window-or-split)

