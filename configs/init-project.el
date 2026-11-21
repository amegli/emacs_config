(use-package projectile
  :config (projectile-mode)
  :bind-keymap ("C-c p" . projectile-command-map)
  :custom ((projectile-completion-system 'default))
  :init
  (when (file-directory-p "~/Development")
    (setq projectile-project-search-path '("~/Development")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package perspective
  :straight t
  :custom
  (persp-mode-prefix-key (kbd "C-c M-p")) 
  :init
  (persp-mode))

(use-package nerd-icons-dired
  :hook
  (dired-mode . nerd-icons-dired-mode))

(use-package rg)

;; Apply each project's direnv environment (.envrc) per buffer, so eglot,
;; compile, and shell commands see the project's tools.  Enabled on after-init
;; so its mode hook runs before the other global minor modes in each buffer.
(use-package envrc
  :hook (after-init . envrc-global-mode))

(setq dired-auto-revert-buffer t)
(setq dired-kill-when-opening-new-dired-buffer t)
(setq dired-dwim-target t)
(setq wdired-allow-to-change-permissions 'advanced)

(provide 'init-project)
