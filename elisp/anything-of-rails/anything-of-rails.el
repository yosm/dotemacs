;;; anything-of-rails.el --- minor mode with anything for editing RubyOnRails code

;; Copyright (C) 2011 Kazuya Yoshimi <kazuya dot yoshimi at gmail dot com>

(require 'rails)
(require 'anything)
(require 'anything-rails-controller-files)
(require 'anything-rails-model-files)
(require 'anything-rails-helper-files)
(require 'anything-rails-config-files)
(require 'anything-rails-current-actions)


(defun anything-of-rails ()
  (interactive)
  (let ((current-rails-root (current-buffer-rails-root)))
    (anything-other-buffer '(anything-c-source-rails-current-actions
                             anything-c-source-rails-controller-files
                             anything-c-source-rails-model-files
                             anything-c-source-rails-config-files
                             anything-c-source-rails-helper-files)
                           "*anything-for-rails*")))

(provide 'anything-of-rails)
