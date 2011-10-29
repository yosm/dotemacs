(require 'rails)
(require 'find-cmd)

(eval-when-compile
  (require 'cl)
  (defvar recentf-list nil)
  (defvar anything-current-buffer nil)
  (defvar rails-root nil))


(defvar rails-controller-directories
  (list "app/controllers"))
(defvar rails-model-directories
  (list "app/models"))
(defvar rails-helper-directories
  (list "app/helpers"))
(defvar rails-config-directories
  (list "config"))
(defvar rails-spec-directories
  (list "spec"))
(defvar rails-db-directories
  (list "db"))
(defvar rails-asset-directories
  (list "app/assets/javascripts" "app/assets/stylesheets"))
(defvar rails-lib-directories
  (list "lib"))

(defun rails-controller-files ()
  (when rails-root
    (split-string
     (shell-command-to-string
      (concat "find " (rails-dirs rails-root rails-controller-directories)
              " "
              (find-to-string `(or (name "*_controller.rb"))))))))


(defun rails-model-files ()
  (when rails-root
    (split-string
     (shell-command-to-string
      (concat "find " (rails-dirs rails-root rails-model-directories)
              " "
              (find-to-string `(or (name "*.rb"))))))))


(defun rails-helper-files ()
  (when rails-root
    (split-string
     (shell-command-to-string
      (concat "find " (rails-dirs rails-root rails-helper-directories)
              " "
              (find-to-string `(or (name "*_helper.rb"))))))))


(defun rails-config-files ()
  (when rails-root
    (split-string
     (shell-command-to-string
      (concat "find " (rails-dirs rails-root rails-config-directories)
              " "
              (find-to-string `(or (name "*.rb" "*.yml"))))))))

(defun rails-spec-files ()
  (when rails-root
    (split-string
     (shell-command-to-string
      (concat "find " (rails-dirs rails-root rails-spec-directories)
              " "
              (find-to-string `(or (name "*.rb"))))))))

(defun rails-db-files ()
  (when rails-root
    (split-string
     (shell-command-to-string
      (concat "find " (rails-dirs rails-root rails-db-directories)
              " "
              (find-to-string `(or (name "*.rb"))))))))

(defun rails-asset-files ()
  (when rails-root
    (split-string
     (shell-command-to-string
      (concat "find " (rails-dirs rails-root rails-asset-directories)
              " "
              (find-to-string `(or (name "*.js*" "*.css*"))))))))

(defun rails-lib-files ()
  (when rails-root
    (split-string
     (shell-command-to-string
      (concat "find " (rails-dirs rails-root rails-asset-directories)
              " "
              (find-to-string `(or (name "*.js*" "*.css*"))))))))



(defun current-rails-recentf ()
  (when rails-root
    (loop for f in recentf-list
          when (string-match rails-root f)
          collect f)))



(defun rails-current-actions ()
  (with-current-buffer anything-current-buffer
    (let ((actions (list))
          (dir (file-name-directory buffer-file-name))
          (name (file-name-nondirectory buffer-file-name)))
      (add-to-list 'actions (cons rails-root "/Users/yoshimi/projects/tag_diary/config/environments/production.rb"))
      (add-to-list 'actions (cons dir dir))
      (add-to-list 'actions (cons name buffer-file-name)))))

(defun rails-c-make-displayable-name (path dir)
  (car (last (split-string path dir))))

(defun rails-c-make-displayable-names (path dir)
  (mapcar (lambda (f) (cons (rails-c-make-displayable-name f dir) f)) path))


(defvar anything-c-source-rails-controller-files
  '((name . "Controller")
    (candidates . (lambda () (rails-controller-files)))
    (candidate-transformer . (lambda (cands) (rails-c-make-displayable-names cands "app/controllers/")))
    (type . file)))

(defvar anything-c-source-rails-model-files
  '((name . "Model")
    (candidates . (lambda () (rails-model-files)))
    (candidate-transformer . (lambda (cands) (rails-c-make-displayable-names cands "app/models/")))
    (type . file)))

(defvar anything-c-source-rails-helper-files
  '((name . "Helper")
    (candidates . (lambda () (rails-helper-files)))
    (candidate-transformer . (lambda (cands) (rails-c-make-displayable-names cands "app/helpers/")))
    (type . file)))

(defvar anything-c-source-rails-config-files
  '((name . "Config")
    (candidates . (lambda () (rails-config-files)))
    (candidate-transformer . (lambda (cands) (rails-c-make-displayable-names cands "config/")))
    (type . file)))

(defvar anything-c-source-rails-spec-files
  '((name . "Spec")
    (candidates . (lambda () (rails-spec-files)))
    (candidate-transformer . (lambda (cands) (rails-c-make-displayable-names cands "spec/")))
    (type . file)))

(defvar anything-c-source-rails-db-files
  '((name . "DB")
    (candidates . (lambda () (rails-db-files)))
    (candidate-transformer . (lambda (cands) (rails-c-make-displayable-names cands "db/")))
    (type . file)))

(defvar anything-c-source-rails-asset-files
  '((name . "Asset")
    (candidates . (lambda () (rails-asset-files)))
    (candidate-transformer . (lambda (cands) (rails-c-make-displayable-names cands "assets/")))
    (type . file)))

(defvar anything-c-source-rails-current-project-recentf
  '((name . "Recentf")
    (candidates . current-rails-recentf)
    (candidate-transformer . (lambda (cands) (rails-c-make-displayable-names cands rails-root)))
    (type . file)))

(defvar anything-c-source-rails-current-actions
  '((name . "Action in Rails Current Buffer")
    (candidates . (lambda () (rails-current-actions)))
    (type . file)))


(provide 'anything-of-rails-config)