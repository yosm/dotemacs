(require 'rails)
(require 'find-cmd)

(defvar rails-helper-directories
  (list "app/helpers"))

(defun rails-helper-files ()
  (when rails-root
    (let ((rails-project-files-list (split-string
                                     (shell-command-to-string
                                      (concat "find " (rails-dirs rails-root rails-helper-directories)
                                              " "
                                              (find-to-string `(or (name "*_helper.rb"))))))))
      
        (mapcar
         (lambda (f)
           (cons (rails-c-make-displayable-name f "app/helpers/") f)) rails-project-files-list))))


(defvar anything-c-source-rails-helper-files
  '((name . "Files in Rails Helper")
    (candidates . (lambda () (rails-helper-files)))
    (type . file)))

(provide 'anything-rails-helper-files)
