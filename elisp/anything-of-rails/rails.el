(require 'find-cmd)
(eval-when-compile
  (defvar rails-root nil))

;; (defun current-buffer-rails-root ()
;;   (let ((rails-project-root (locate-dominating-file default-directory "Gemfile")))
;;     (when (and rails-project-root
;;                (file-exists-p (concat rails-project-root "config/application.rb")))
;;       rails-project-root)))

(defun current-buffer-rails-root ()
  (expand-file-name (locate-dominating-file "/Users/yoshimi/projects/tag_diary/" "Gemfile")))


(defun rails-dirs (root dirs)
  (mapconcat (lambda (x) (if (file-directory-p x) x "" ))
             (mapcar (lambda (x) (concat root x)) dirs )
             " "))

(provide 'rails)
