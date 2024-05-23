
(defun mgli-copy-current-file-name ()
  (interactive)
  (if-let ((file-name (buffer-file-name)))
      (progn
        (kill-new file-name)
        (message "Copied file name '%s' to the clipboard." file-name))
    (message "Current buffer is not associated with a file.")))

(defvar milton-config-path "/Users/andrewmegli/Development/milton/"
  "Path to the milton configuration file.")

(defun mgli-milton (action environment)
	(interactive
	 (list
		(read-string "Action (upload, info, diff...) [default upload]: " nil nil "upload")
		(read-string "Environment (SB5, SB2, SB1, PROD) [default SB5]: " nil nil "SB5")))
  (let ((output (shell-command-to-string
                 (format "milton --%s --path %s --config %s"
                         action (shell-quote-argument buffer-file-name)
												 (concat (file-name-as-directory milton-config-path)
																 environment ".config.json"
																 )))))
		(with-output-to-temp-buffer "*mgli-milton-output*"
			(princ output))))

(use-package general
	:after evil
	:config
	(general-evil-setup t)
	(general-define-key
	 :states '(normal visual motion emacs)
	 "K" 'lsp-ui-doc-toggle
	 "gt" 'tab-next
	 "gT" 'tab-previous
	 )
	(general-create-definer mgli/leader-def
		:states '(normal motion emacs)
		:keymaps 'override
		:prefix "SPC")
	(mgli/leader-def
		:states '(normal motion emacs)
		:keymaps 'override
		"m" 'mgli-milton
		
		"o" (cons "org" (make-sparse-keymap))
		"oc" 'org-toggle-checkbox
		"oo" 'org-capture
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
		"ts" 'scratch-buffer

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

		"j" (cons "jest" (make-sparse-keymap))
		"jb" 'jest-file-dwim
		"jp" 'jest-function
		"jj" 'jest-popup

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
