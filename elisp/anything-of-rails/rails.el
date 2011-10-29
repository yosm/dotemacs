(defvar current-rails-root nil)

(defun rails-root ()
  "Set Rails.root to rails-root"

  (let ((rails-project-root (locate-dominating-file default-directory "Gemfile")))
    (when (and rails-project-root
               (file-exists-p (concat rails-project-root "config/application.rb")))
      rails-project-root)))

(defun current-buffer-rails-root ()
  "Set Rails.root to rails-root"

  (let ((rails-project-root (locate-dominating-file default-directory "Gemfile")))
    (when (and rails-project-root
               (file-exists-p (concat rails-project-root "config/application.rb")))
      rails-project-root)))

(defun rails-dirs (root dirs)
  "Returns list of directories to search in rails, skips ones that do not exist"
  (mapconcat (lambda (x) (if (file-directory-p x) x "" ))
             (mapcar (lambda (x) (concat root x)) dirs )
             " "))

(defun rails-c-make-displayable-name (path dir)
  (car (last (split-string path dir))))

(provide 'rails)
