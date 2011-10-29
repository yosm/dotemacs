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

;; 画面分割を行いfollow-modeにする
(global-set-key (kbd "C-c z") 'follow-delete-other-windows-and-split)

;; anything-for-files
(global-set-key (kbd "C-x b") 'anything-for-files)
(global-set-key (kbd "C-x C-b") 'anything-for-files)


;; eval-current-buffer
(global-set-key (kbd "C-l") 'eval-current-buffer)

;; anything-of-rails
(global-set-key (kbd "C-;") 'anything-of-rails)