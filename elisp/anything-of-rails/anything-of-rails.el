;;; anything-of-rails.el --- minor mode with anything for editing RubyOnRails code

;; Copyright (C) 2011 Kazuya Yoshimi <kazuya dot yoshimi at gmail dot com>

(require 'anything)
(require 'find-cmd)

(eval-when-compile
  (require 'cl)
  (defvar recentf-list nil)
  (defvar rails-root nil))

(defun current-buffer-rails-root ()
;;   (let ((rails-project-root (locate-dominating-file default-directory "Gemfile")))
;;     (when (and rails-project-root
;;                (file-exists-p (concat rails-project-root "config/application.rb")))
;;       rails-project-root)))

  (expand-file-name (locate-dominating-file "/Users/yoshimi/projects/sis/jasa/api/trunk/" "Gemfile")))
;  (expand-file-name (locate-dominating-file "/Users/yoshimi/projects/tag_diary/" "Gemfile")))

(defun rails-dirs (root dirs)
  (mapconcat (lambda (x) (if (file-directory-p x) x "" ))
             (mapcar (lambda (x) (concat root x)) dirs )
             " "))


;; (defvar rails-controller-directories
;;   (list "app/controllers"))
;; (defvar rails-model-directories
;;   (list "app/models"))
;; (defvar rails-view-directories
;;   (list "app/views"))
;; (defvar rails-helper-directories
;;   (list "app/helpers"))
;; (defvar rails-config-directories
;;   (list "config"))
;; (defvar rails-spec-directories
;;   (list "spec"))
;; (defvar rails-db-directories
;;   (list "db"))
;; (defvar rails-asset-directories
;;   (list "app/assets/javascripts" "app/assets/stylesheets"))
;; (defvar rails-lib-directories
;;   (list "lib"))

(defvar rails-project-directories
  (list "app" "config" "spec" "db" "lib"))

(defvar omit-rails-project-directory-name
  (list
   "app/controllers"
   "app/models"
   "app/views"
   "app/helpers"
   "app/assets"
   "app"
   "config"
   "db/migrate"
   "db"
   "spec/controllers"
   "spec/models"
   "spec/views"
   "spec/helpers"
   "spec"
   "lib"))

;; (defun rails-controller-files ()
;;   (when rails-root
;;     (split-string
;;      (shell-command-to-string
;;       (concat "find " (rails-dirs rails-root rails-controller-directories)
;;               " "
;;               (find-to-string `(or (name "*_controller.rb"))))))))


;; (defun rails-view-files ()
;;   (when rails-root
;;     (split-string
;;      (shell-command-to-string
;;       (concat "find " (rails-dirs rails-root rails-view-directories)
;;               " "
;;               (find-to-string `(or (name "*.erb"))))))))


;; (defun rails-model-files ()
;;   (when rails-root
;;     (split-string
;;      (shell-command-to-string
;;       (concat "find " (rails-dirs rails-root rails-model-directories)
;;               " "
;;               (find-to-string `(or (name "*.rb"))))))))


;; (defun rails-helper-files ()
;;   (when rails-root
;;     (split-string
;;      (shell-command-to-string
;;       (concat "find " (rails-dirs rails-root rails-helper-directories)
;;               " "
;;               (find-to-string `(or (name "*_helper.rb"))))))))


;; (defun rails-config-files ()
;;   (when rails-root
;;     (split-string
;;      (shell-command-to-string
;;       (concat "find " (rails-dirs rails-root rails-config-directories)
;;               " "
;;               (find-to-string `(or (name "*.rb" "*.yml"))))))))

;; (defun rails-spec-files ()
;;   (when rails-root
;;     (split-string
;;      (shell-command-to-string
;;       (concat "find " (rails-dirs rails-root rails-spec-directories)
;;               " "
;;               (find-to-string `(or (name "*.rb"))))))))

;; (defun rails-db-files ()
;;   (when rails-root
;;     (split-string
;;      (shell-command-to-string
;;       (concat "find " (rails-dirs rails-root rails-db-directories)
;;               " "
;;               (find-to-string `(or (name "*.rb"))))))))

;; (defun rails-asset-files ()
;;   (when rails-root
;;     (split-string
;;      (shell-command-to-string
;;       (concat "find " (rails-dirs rails-root rails-asset-directories)
;;               " "
;;               (find-to-string `(or (name "*.js*" "*.css*")))
;;               " -print 2> /dev/null")))))

;; (defun rails-lib-files ()
;;   (when rails-root
;;     (split-string
;;      (shell-command-to-string
;;       (concat "find " (rails-dirs rails-root rails-lib-directories)
;;               " "
;;               (find-to-string `(or (name "*.rb"))))))))

(defun rails-project-files ()
  (when rails-root
    (split-string
     (shell-command-to-string
      (concat "find " (rails-dirs rails-root rails-project-directories)
              " "
              (find-to-string `(or (name "*.rb" "*.js*" "*.css*" "*.yml"))))))))



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

(defun displayable-prefix (path prefix)
  (if (> (length path) (length rails-root))
      (concat prefix " : ")
    ""))

(defun rails-c-make-displayable-names (path &optional dir)
  (mapcar
   (lambda (f)
     (cons
      (replace-regexp-in-string
       (concat "^" rails-root "\\(" (mapconcat 'identity dir "\\|") "\\)?/?")
       (lambda (s) (displayable-prefix s "\\1"))
       f)
      f))
   path))


;; (defvar anything-c-source-rails-controller-files
;;   '((name . "Controller")
;;     (candidates . (lambda () (rails-controller-files)))
;;     (candidate-transformer . (lambda (cands) (rails-c-make-displayable-names cands "/app/controllers/")))
;;     (type . file)))

;; (defvar anything-c-source-rails-view-files
;;   '((name . "View")
;;     (candidates . (lambda () (rails-view-files)))
;;     (candidate-transformer . (lambda (cands) (rails-c-make-displayable-names cands "/app/views/")))
;;     (type . file)))

;; (defvar anything-c-source-rails-model-files
;;   '((name . "Model")
;;     (candidates . (lambda () (rails-model-files)))
;;     (candidate-transformer . (lambda (cands) (rails-c-make-displayable-names cands "/app/models/")))
;;     (type . file)))

;; (defvar anything-c-source-rails-helper-files
;;   '((name . "Helper")
;;     (candidates . (lambda () (rails-helper-files)))
;;     (candidate-transformer . (lambda (cands) (rails-c-make-displayable-names cands "/app/helpers/")))
;;     (type . file)))

;; (defvar anything-c-source-rails-config-files
;;   '((name . "Config")
;;     (candidates . (lambda () (rails-config-files)))
;;     (candidate-transformer . (lambda (cands) (rails-c-make-displayable-names cands "/config/")))
;;     (type . file)))

;; (defvar anything-c-source-rails-spec-files
;;   '((name . "Spec")
;;     (candidates . (lambda () (rails-spec-files)))
;;     (candidate-transformer . (lambda (cands) (rails-c-make-displayable-names cands "/spec/")))
;;     (type . file)))

;; (defvar anything-c-source-rails-db-files
;;   '((name . "DB")
;;     (candidates . (lambda () (rails-db-files)))
;;     (candidate-transformer . (lambda (cands) (rails-c-make-displayable-names cands "/db/")))
;;     (type . file)))

;; (defvar anything-c-source-rails-asset-files
;;   '((name . "Asset")
;;     (candidates . (lambda () (rails-asset-files)))
;;     (candidate-transformer . (lambda (cands) (rails-c-make-displayable-names cands "/assets/")))
;;     (type . file)))

;; (defvar anything-c-source-rails-lib-files
;;   '((name . "Lib")
;;     (candidates . (lambda () (rails-lib-files)))
;;     (candidate-transformer . (lambda (cands) (rails-c-make-displayable-names cands "/lib/")))
;;     (type . file)))

(defvar anything-c-source-rails-project-files
  '((name . "Project")
    (candidates . (lambda () (rails-project-files)))
    (candidate-transformer . (lambda (cands) (rails-c-make-displayable-names cands omit-rails-project-directory-name)))
    (candidate-number-limit . nil)
    (type . file)))

(defvar anything-c-source-rails-current-project-recentf
  '((name . "Recentf")
    (candidates . current-rails-recentf)
    (candidate-transformer . (lambda (cands) (rails-c-make-displayable-names cands)))
    (type . file)))

(defvar anything-c-source-rails-current-actions
  '((name . "Action in Rails Current Buffer")
    (candidates . (lambda () (rails-current-actions)))
    (type . file)))

(defun anything-of-rails ()
  (interactive)
  (let ((rails-root (current-buffer-rails-root)))
    (anything :sources '(anything-c-source-rails-current-actions
                         anything-c-source-rails-current-project-recentf
                         anything-c-source-rails-project-files)
              :prompt "Anything Of Rails: "
              :resume "noresume"
              :buffer "*anything-for-rails*")))

    ;; (anything-other-buffer '(anything-c-source-rails-current-actions
    ;;                          anything-c-source-rails-current-project-recentf
    ;;                          anything-c-source-rails-project-files)
    ;;                          anything-c-source-rails-controller-files
    ;;                          anything-c-source-rails-view-files
    ;;                          anything-c-source-rails-model-files
    ;;                          anything-c-source-rails-lib-files
    ;;                          anything-c-source-rails-config-files
    ;;                          anything-c-source-rails-spec-files
    ;;                          anything-c-source-rails-db-files
    ;;                          anything-c-source-rails-asset-files
    ;;                          anything-c-source-rails-helper-files)
    ;;                     "*anything-for-rails*")))


(provide 'anything-of-rails)
