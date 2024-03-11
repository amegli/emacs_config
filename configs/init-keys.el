
(defun mgli-copy-current-file-name ()
  (interactive)
  (if-let ((file-name (buffer-file-name)))
      (progn
        (kill-new file-name)
        (message "Copied file name '%s' to the clipboard." file-name))
    (message "Current buffer is not associated with a file.")))

(use-package general
  :after evil
  :config
  (general-evil-setup t)
	(general-define-key
	 :states '(normal visual motion emacs)
	 "K" 'lsp-ui-doc-toggle)
  (general-create-definer mgli/leader-def
    :states '(normal motion emacs)
    :keymaps 'override
    :prefix "SPC")
  (mgli/leader-def
    :states '(normal motion emacs)
    :keymaps 'override
    "o" (cons "org" (make-sparse-keymap))
		"oc" 'org-toggle-checkbox
		"oa" 'org-agenda
		"op" 'evil-org-open-below

    "f" (cons "files" (make-sparse-keymap))
    "ff" 'find-file
    "fd" 'dired-jump
		"fc" 'mgli-copy-current-file-name

    "p" (cons "project" (make-sparse-keymap))
    "pp" 'projectile-switch-project
    "pf" 'projectile-find-file
		"ps" 'projectile-ripgrep

    "g" (cons "magit" (make-sparse-keymap))
    "gg" 'magit
    "gb" 'magit-blame-addition

    "t" (cons "terminal" (make-sparse-keymap))
    "tb" 'mgli/bottom-eshell
    "te" 'eshell
    "tv" 'vterm

    "h" (cons "help" (make-sparse-keymap))
    "hh" 'help
    "ha" 'apropos-command
    "hb" 'describe-bindings
    "hk" 'describe-key

    "b" (cons "buffer" (make-sparse-keymap))
    "bl" 'consult-buffer
		"bp" 'previous-buffer
		"bn" 'next-buffer
    "bk" 'kill-buffer

		"e" (cons "errors" (make-sparse-keymap))
		"en" 'flycheck-next-error
		"ep" 'flycheck-previous-error
		"el" 'flycheck-list-errors

    "c" (cons "code" (make-sparse-keymap))
    "cc" 'comment-dwim
		"cr" 'xref-find-references
		"cn" 'xref-find-references-and-replace
		"ch" 'hoogle

    "u" (cons "ui" (make-sparse-keymap))
		"ut" 'consult-theme
    )
  )

(provide 'init-keys)
