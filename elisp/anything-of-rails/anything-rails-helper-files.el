(require 'rails)
(require 'find-cmd)

(defvar rails-helper-directories
  (list "app/helpers"))

(defun rails-helper-files ()
  "Returns a list of all files found under the rails project."

  ;; find root of project return empty list if not a rails project
  (let ((rails-root (rails-root)))
    (when rails-root
      (let ((rails-project-files-list (split-string
                                       (shell-command-to-string
                                        (concat "find " (rails-dirs rails-root rails-helper-directories)
                                                " "
                                                (find-to-string `(or (name "*_helper.rb"))))))))

        ;; convert the list into cons pair of (display . filepath) where
        ;; display is a friendly name
        (mapcar
         (lambda (f)
           (cons (rails-c-make-displayable-name f "app/helpers/") f)) rails-project-files-list)))))


(defvar anything-c-source-rails-helper-files
  '((name . "Files in Rails Helper")
    (candidates . (lambda () (rails-helper-files)))
    (type . file)))

(provide 'anything-rails-helper-files)
