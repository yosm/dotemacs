(require 'helm-projectile)
(require 'helm-locate)
(require 'projectile-rails)

(defvar railstar-minor-mode-map
  (let ((map (make-keymap)))
    map))


(define-minor-mode railstar-minor-mode
  "Railstar mode, one key rails development"
  :init-value nil
  :lighter " Railstar"
  :keymap railstar-minor-mode-map
  )


(defun railstar-minor-mode-on ()
  "Enable `railstar-mode' minor mode if this is a rails project."
  (when (and
         (not (projectile-rails--ignore-buffer-p))
         (projectile-rails-root))
    (railstar-minor-mode +1)))

(add-hook 'projectile-mode-hook 'railstar-minor-mode-on)




;;; util

(defun rails-c-make-displayable-names (path)
  (mapcar
   (lambda (f)
     (cons
      (replace-regexp-in-string (concat "^" (projectile-rails-root)) "" f)
      f))
   path))


(defmacro measure-time (&rest body)
  "Measure and return the running time of the code block."
  (declare (indent defun))
  (let ((start (make-symbol "start")))
    `(let ((,start (float-time)))
       ,@body
       (- (float-time) ,start))))

;;; プロジェクトファイル一覧

(defun rails-project-files ()
  (let ((default-directory (replace-regexp-in-string "/$" "" (projectile-rails-root))))
    (split-string
     (shell-command-to-string
      (find-cmd '(prune (name "vendor" "log" "tmp" ".git")) '(and (or (name "*.rb" "*.erb" "*.js*" "*.css*" "*.yml" "*.coffee" "*.scss"))))))
      ))

(defvar railstar-source-rails-project-files
  '((name . "Project")
    (candidates . (lambda () (rails-project-files)))
    (candidate-transformer . (lambda (cands) (rails-c-make-displayable-names cands)))
    (candidate-number-limit . 50)
    (type . file)))

;;; アクション一覧

(defun rails-file-type (file)
  (cond
   ((string-match "/app/views/\\([a-zA-Z0-9_]+\\)/" file) "views")
   ((string-match "/app/controllers/.*/\\([a-zA-Z0-9_]+\\)_controller" file) "controllers")
   ((string-match "/app/models/" file) "models")
   ((string-match "/config/" file) "config")
   ((string-match "/spec/\\([a-zA-Z0-9_]+\\)/" file) (concat "spec-" (match-string 1 file)))
   ((string-match "/app/helpers/" file) "helper")
   ((string-match "/app/mailers/" file) "mailer")
   ((string-match "/app/\\([a-zA-Z0-9_]+\\)/" file) (match-string 1 file))
   (t "misc file")))

(defun controller-to-views (file)
  (replace-regexp-in-string "/controllers/\\(.*\\)_controller.rb" "/views/\\1" file))
(defun controller-to-helper (file)
  (replace-regexp-in-string "controller" "helper" file))
(defun file-to-spec (file)
  (replace-regexp-in-string "/app/\\(.*\\).rb" "/spec/\\1_spec.rb" file))
(defun spec-to-file (file)
  (replace-regexp-in-string "/spec/\\(.*\\)_spec.rb" "/app/\\1.rb" file))
(defun view-to-controller (file)
  (replace-regexp-in-string "/views/\\(.*\\)/.*.erb" "/controllers/\\1_controller.rb" file))
(defun helper-to-controller (file)
  (replace-regexp-in-string "helper" "controller" file))
(defun action-to-view (file method)
  (replace-regexp-in-string "/controllers/\\(.*\\)_controller.rb" (concat "/views/\\1/" method ".html.erb") file))

(defun current-method-name ()
  (save-excursion
    (when (search-backward-regexp "^[ ]*def \\([a-z0-9_]+\\)" nil t)
      (match-string-no-properties 1))))


(defun rails-current-actions ()
  (with-helm-current-buffer
    (let ((actions ())
          (file buffer-file-name)
          (line (projectile-rails-current-line))
          (name (projectile-rails-name-at-point))
          (type (rails-file-type buffer-file-name)))
      (cond ((equal type "controllers")
             (add-to-list 'actions (controller-to-helper file))
             (add-to-list 'actions (controller-to-views file))
             (add-to-list 'actions (file-to-spec file))
             (add-to-list 'actions (action-to-view file (current-method-name))))
            ((equal type "models")
             (add-to-list 'actions (file-to-spec file)))
            ((equal type "views")
             (add-to-list 'actions (view-to-controller file)))
            ((equal type "helper")
             (add-to-list 'actions (helper-to-controller file)))
            ((equal type "spec-controllers")
             (add-to-list 'actions (spec-to-file file)))
            ((equal type "spec-models")
             (add-to-list 'actions (spec-to-file file)))
            ))))



(defvar railstar-source-rails-current-actions
  '((name . "Actions")
    (candidates . (lambda () (rails-current-actions)))
    (candidate-transformer . (lambda (cands) (rails-c-make-displayable-names cands)))
    (candidate-number-limit . 50)
    (type . file)))


;;; helm定義

(defun railstar ()
  (interactive)
  (helm :sources '(
                   railstar-source-rails-current-actions
                   helm-source-projectile-recentf-list
                   railstar-source-rails-project-files
                   )
        :prompt "Railstar: "
        :buffer "*railstar*"))

(provide 'railstar)
