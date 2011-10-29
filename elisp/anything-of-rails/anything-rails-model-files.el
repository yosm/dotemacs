(require 'rails)
(require 'find-cmd)

(defvar rails-model-directories
  (list "app/models"))

(defun rails-model-files ()
  (when rails-root
    (let ((rails-files-list (split-string
                             (shell-command-to-string
                              (concat "find " (rails-dirs rails-root rails-model-directories)
                                      " "
                                      (find-to-string `(or (name "*.rb"))))))))

        (mapcar
         (lambda (f)
           (cons (rails-c-make-displayable-name f "app/models/") f)) rails-files-list))))

(defvar anything-c-source-rails-model-files
  '((name . "Files in Rails Model")
    (candidates . (lambda () (rails-model-files)))
    (type . file)))

(provide 'anything-rails-model-files)
