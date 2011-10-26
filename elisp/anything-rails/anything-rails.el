;;; anything-rails.el --- minor mode for editing RubyOnRails code

;; Copyright (C) 2011 Kazuya Yoshimi <yoshimi at raw-hide dot co dot jp>

;; Authors: Dmitry Galinsky <dima dot exe at gmail dot com>,
;;          Rezikov Peter <crazypit13 (at) gmail.com>

;; Keywords: ruby rails languages oop
;; $URL$
;; $Id$

;;; License

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 2
;; of the License, or (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.



;;; anything-rails.el --- 

(require 'anything)
(require 'anything-config)
(require 'anything-rails-project-files)
(require 'anything-rails-controller-files)

(eval-when-compile (defvar rails-project-root))

(defun rails-root ()
  "Set Rails.root to rails-root"

  (let ((rails-project-root (locate-dominating-file default-directory "Gemfile")))
    (when (and rails-project-root
               (file-exists-p (concat rails-project-root "config/application.rb")))
      rails-project-root)))

(defun anything-for-rails ()
  (interactive)
  (anything-other-buffer '(anything-c-source-rails-project-files
                           anything-c-source-rails-controller-files)
                         "*anything-for-rails*"))

(provide 'anything-rails)

