(require 'rails)
(require 'find-cmd)

(defvar rails-config-directories
  (list "config"))

(defun rails-config-files ()
  "Returns a list of all files found under the rails project."

  ;; find root of project return empty list if not a rails project
  (let ((rails-root (rails-root)))
    (when rails-root
      (let ((rails-project-files-list (split-string
                                       (shell-command-to-string
                                        (concat "find " (rails-dirs rails-root rails-config-directories)
                                                " "
                                                (find-to-string `(or (name "*.rb" "*.yml"))))))))

        ;; convert the list into cons pair of (display . filepath) where
        ;; display is a friendly name
        (mapcar
         (lambda (f)
           (cons (rails-c-make-displayable-name f "config/") f)) rails-project-files-list)))))



(defvar anything-c-source-rails-config-files
  '((name . "Files in Rails Config")
    (candidates . (lambda () (rails-config-files)))
    (type . file)))

(provide 'anything-rails-config-files)
