;; command キーと Option キーの動作を逆に
(setq ns-command-modifier (quote meta))
(setq ns-alternate-modifier (quote super))

;; バックスラッシュを入力できるように
(define-key global-map [165] nil)
(define-key global-map [67109029] nil)
(define-key global-map [134217893] nil)
(define-key global-map [201326757] nil)
(define-key function-key-map [165] [?\\])
(define-key function-key-map [67109029] [?\C-\\])
(define-key function-key-map [134217893] [?\M-\\])
(define-key function-key-map [201326757] [?\C-\M-\\])

;; 行数を表示する
;(global-set-key "\M-n" 'linum-mode)

;; Ctrl-hでBackSpace
(global-set-key "\C-h" 'backward-delete-char)

;; Ctrl-x ?でhelp
(global-set-key (kbd "C-x ?") 'help-command)

;; fullscreen
;;(global-set-key (kbd "M-F") 'toggle-frame-maximized)
(global-set-key (kbd "M-F") 'toggle-frame-fullscreen)


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

;; eval-current-buffer
(global-set-key (kbd "C-l") 'eval-current-buffer)


;; プロジェクト内にいない場合にプロジェクト一覧を表示する
(global-set-key (kbd "C-;") 'helm-projectile-switch-project)
