(eval-when-compile
  (require 'rails)
  (defvar anything-current-buffer nil))

(defun rails-current-actions ()
  (with-current-buffer anything-current-buffer
    (let ((actions (list))
          (dir (file-name-directory buffer-file-name))
          (name (file-name-nondirectory buffer-file-name)))
      (push (cons rails-root "/Users/yoshimi/projects/tag_diary/config/environments/production.rb") actions)
      (push (cons dir dir) actions)
      (push (cons name buffer-file-name) actions))))

(defvar anything-c-source-rails-current-actions
  '((name . "Action in Rails Current Buffer")
    (candidates . (lambda () (rails-current-actions)))
    (type . file)))

(provide 'anything-rails-current-actions)
