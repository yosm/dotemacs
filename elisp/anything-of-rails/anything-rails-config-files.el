(require 'rails)
(require 'find-cmd)

(defvar rails-config-directories
  (list "config"))

(defun rails-config-files ()
  (when rails-root
    (let ((rails-project-files-list (split-string
                                     (shell-command-to-string
                                      (concat "find " (rails-dirs rails-root rails-config-directories)
                                              " "
                                              (find-to-string `(or (name "*.rb" "*.yml"))))))))
      
      (mapcar
       (lambda (f)
         (cons (rails-c-make-displayable-name f "config/") f)) rails-project-files-list))))


(defvar anything-c-source-rails-config-files
  '((name . "Files in Rails Config")
    (candidates . (lambda () (rails-config-files)))
    (type . file)))

(provide 'anything-rails-config-files)
