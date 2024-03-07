
(use-package which-key
  :init (which-key-mode)
  :config
  (setq which-key-idle-delay 0.001))

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

(defvar mgli-backup-folder (concat user-emacs-directory "backups"))
(unless (file-exists-p mgli-backup-folder)
        (make-directory mgli-backup-folder t))
(setq backup-directory-alist `(("." . ,mgli-backup-folder)))

(defvar mgli-auto-save-folder (expand-file-name "~/.emacs.d/auto-saves/"))
(unless (file-exists-p mgli-auto-save-folder)
  (make-directory mgli-auto-save-folder t))
(setq auto-save-file-name-transforms `((".*" , mgli-auto-save-folder t)))

(setq ring-bell-function 'ignore)

(provide 'init-setup)
