(defvar rails-root nil)

(defun current-buffer-rails-root ()
  (let ((rails-project-root (locate-dominating-file default-directory "Gemfile")))
    (when (and rails-project-root
               (file-exists-p (concat rails-project-root "config/application.rb")))
      rails-project-root)))

(defun rails-dirs (root dirs)
  (mapconcat (lambda (x) (if (file-directory-p x) x "" ))
             (mapcar (lambda (x) (concat root x)) dirs )
             " "))

(defun rails-c-make-displayable-name (path dir)
  (car (last (split-string path dir))))

(provide 'rails)
