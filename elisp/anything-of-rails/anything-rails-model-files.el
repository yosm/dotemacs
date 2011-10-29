(require 'rails)
(require 'find-cmd)

(defvar rails-model-directories
  (list "app/models"))

(defun rails-model-files ()
  "Returns a list of all files found under the rails project."

  ;; find root of project return empty list if not a rails project
  (let ((rails-root (rails-root)))
    (when rails-root
      (let ((rails-files-list (split-string
                                       (shell-command-to-string
                                        (concat "find " (rails-dirs rails-root rails-model-directories)
                                                " "
                                                (find-to-string `(or (name "*.rb"))))))))

        ;; convert the list into cons pair of (display . filepath) where
        ;; display is a friendly name
        (mapcar
         (lambda (f)
           (cons (rails-c-make-displayable-name f "app/models/") f)) rails-files-list)))))



(defvar anything-c-source-rails-model-files
  '((name . "Files in Rails Model")
    (candidates . (lambda () (rails-model-files)))
    (type . file)))

(provide 'anything-rails-model-files)
