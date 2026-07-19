
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

;; Keep unmodified buffers in sync with changes on disk
(global-auto-revert-mode 1)
(setq global-auto-revert-non-file-buffers t
      auto-revert-verbose nil)

;; Persist minibuffer history across sessions
(use-package savehist
  :straight nil
  :init (savehist-mode 1))

;; Reopen files at the previous cursor position.
(save-place-mode 1)

(setq ring-bell-function 'ignore)

(let ((rbenv-shims (expand-file-name "~/.rbenv/shims")))
  (when (file-directory-p rbenv-shims)
    (add-to-list 'exec-path rbenv-shims)
    (setenv "PATH" (concat rbenv-shims ":" (getenv "PATH")))))

(add-hook 'text-mode-hook 'visual-line-mode)

(use-package vundo)

(provide 'init-setup)
