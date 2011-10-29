(require 'rails)
(require 'find-cmd)

(defvar rails-controller-directories
  (list "app/controllers"))

(defun rails-controller-files ()
  "Returns a list of all files found under the rails project."

  ;; find root of project return empty list if not a rails project
  (let ((rails-root (rails-root)))
    (when rails-root
      (let ((rails-project-files-list (split-string
                                       (shell-command-to-string
                                        (concat "find " (rails-dirs rails-root rails-controller-directories)
                                                " "
                                                (find-to-string `(or (name "*_controller.rb"))))))))

        ;; convert the list into cons pair of (display . filepath) where
        ;; display is a friendly name
        (mapcar
         (lambda (f)
           (cons (rails-c-make-displayable-name f "app/controllers/") f)) rails-project-files-list)))))



(defvar anything-c-source-rails-controller-files
  '((name . "Files in Rails Controller")
    (candidates . (lambda () (rails-controller-files)))
    (type . file)))

(provide 'anything-rails-controller-files)
