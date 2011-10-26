;; Original : https://github.com/wolfmanjm/anything-on-rails
(require 'find-cmd)

(defvar rails-directories
  (list "app" "spec" "config" "lib")
  "List of directories in rails root to search for files")

(defun rails-dirs (root)
  "Returns list of directories to search in rails, skips ones that do not exist"
  (mapconcat (lambda (x) (if (file-directory-p x) x "" ))
             (mapcar (lambda (x) (concat root x)) rails-directories )
             " "))

(defun rails-make-displayable-name (path)
  "makes path into a displayable name. eg view(post): file, model: file, controller: name"
  (let ((dir (file-name-directory path))
        (name (file-name-nondirectory path)))
    (let
        ((type (cond
                ((string-match "/app/views/\\([a-zA-Z0-9_]+\\)/" dir)
                 (concat "view(" (match-string 1 dir) ")"))
                ((string-match "/app/controllers/.*/\\([a-zA-Z0-9_]+\\)Controller" dir) "controller")
                ((string-match "/app/models/" dir) "model")
                ((string-match "/config/\\([a-zA-Z0-9_]+\\)/" dir)
                 (concat "config(" (match-string 1 dir) ")"))
                ((string-match "/config/" dir) "config(root)")
                ((string-match "/spec/\\([a-zA-Z0-9_]+\\)/" dir)
                 (concat "spec(" (match-string 1 dir) ")"))
                ((string-match "/spec/" dir) "spec(root)")
                ((string-match "/app/helpers/" dir) "helper")
                ((string-match "/app/mailers/" dir) "mailer")
                ((string-match "/app/\\([a-zA-Z0-9_]+\\)/" dir) (match-string 1 dir))
                (t "misc file"))))

      (concat type ": " name))))


(defun rails-project-files ()
  "Returns a list of all files found under the rails project."

  ;; find root of project return empty list if not a rails project
  ;; checks for Gemfile in the RAILS_ROOT and for config/application.rb (Rails3)
  (let ((rails-project-root (locate-dominating-file default-directory "Gemfile")))
    (when (and rails-project-root
               (file-exists-p (concat rails-project-root "config/application.rb")))
      ;; get a list of all the relevant files
      (let ((rails-project-files-list (split-string
                                       (shell-command-to-string
                                        (concat "find " (rails-dirs rails-project-root)
                                                " "
                                                (find-to-string
                                                 '(prune (name ".svn" ".git")))
                                                " "
                                                (find-to-string
                                                 `(or (name "*.rb" "*.haml" "*.erb" "*.yml"))))))))

        ;; convert the list into cons pair of (display . filepath) where
        ;; display is a friendly name
        (mapcar
         (lambda (f)
           (cons (rails-make-displayable-name f) f)) rails-project-files-list)))))



(defvar anything-c-source-rails-project-files
  '((name . "Files in Rails Project")
    (candidates . (lambda () (rails-project-files)))
    (type . file)))

(provide 'anything-rails-project-files)