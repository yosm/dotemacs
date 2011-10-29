(require 'rails)
(require 'find-cmd)

(defvar rails-controller-directories
  (list "app/controllers"))

(defun rails-controller-files ()
  (when rails-root
    (let ((rails-project-files-list (split-string
                                     (shell-command-to-string
                                      (concat "find " (rails-dirs rails-root rails-controller-directories)
                                              " "
                                              (find-to-string `(or (name "*_controller.rb"))))))))
      (mapcar
       (lambda (f)
         (cons (rails-c-make-displayable-name f "app/controllers/") f)) rails-project-files-list))))


(defvar anything-c-source-rails-controller-files
  '((name . "Files in Rails Controller")
    (candidates . (lambda () (rails-controller-files)))
    (type . file)))

(provide 'anything-rails-controller-files)
