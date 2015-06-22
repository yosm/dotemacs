;;; helm
(require 'helm-config)
(helm-mode 1)

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x C-r") 'helm-recentf)
(global-set-key (kbd "C-x C-b") 'helm-mini)
(global-set-key (kbd "C-x b") 'helm-for-files)
(global-set-key (kbd "C-x i") 'helm-imenu)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)

;; helmを縦分割で横に表示する
(setq helm-split-window-default-side 'side)

(define-key helm-map (kbd "C-h") 'delete-backward-char)
(define-key helm-find-files-map (kbd "C-h") 'delete-backward-char)
(define-key helm-map (kbd "TAB") 'helm-execute-persistent-action)
;(define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-t") nil)

;; Emulate `kill-line' in helm minibuffer
(setq helm-delete-minibuffer-contents-from-point t)
(defadvice helm-delete-minibuffer-contents (before helm-emulate-kill-line activate)
  "Emulate `kill-line' in helm minibuffer"
  (kill-new (buffer-substring (point) (field-end))))

