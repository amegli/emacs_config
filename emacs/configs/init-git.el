
(use-package magit
  :commands (magit-status magit-get-current-branch))

(use-package git-gutter
  :init (global-git-gutter-mode t))

(provide 'init-git)
