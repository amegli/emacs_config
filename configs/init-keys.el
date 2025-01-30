
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
	"Make milton go"
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
		(with-help-window "*mgli-milton-output*"
			(princ output))))

(defun mgli-consult-ripgrep ()
	(interactive)
	(let ((current_symbol (symbol-at-point)))
		(consult-ripgrep nil (when current_symbol (symbol-name current_symbol)))))

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
		"a" (cons "avy" (make-sparse-keymap))
		"ac" 'avy-goto-char
		"al" 'avy-goto-line
		"as" 'avy-goto-word-1
		"aw" 'avy-goto-word-0

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
		"pd" 'projectile-find-dir
		"pr" 'projectile-ripgrep
		"pb" 'projectile-ibuffer
		"ps" (cons "project search" (make-sparse-keymap))
		"pss" 'mgli-consult-ripgrep
		"psr" 'consult-ripgrep

		"g" (cons "magit" (make-sparse-keymap))
		"gg" 'magit
		"gb" 'magit-blame-addition
		"gfl" 'magit-log-buffer-file
		"gl" 'magit-log-current

		"t" (cons "terminal" (make-sparse-keymap))
		"te" 'eshell
		"tv" 'vterm
		"ts" 'scratch-buffer
		"tb" (cons "bottom terms" (make-sparse-keymap))
		"tbe" (lambda () (interactive) (mgli/bottom-eshell #'eshell))
		"tbv" (lambda () (interactive) (mgli/bottom-eshell #'vterm))
		"tbs" (lambda () (interactive) (mgli/bottom-eshell #'scratch-buffer))

		"b" (cons "buffer" (make-sparse-keymap))
		"be" 'eval-buffer
		"bl" 'consult-buffer
		"bp" 'previous-buffer
		"bn" 'next-buffer
		"bk" 'kill-buffer
		"br" 'consult-recent-file
		"bd" 'diff-buffers

		"e" (cons "errors" (make-sparse-keymap))
		"en" 'flycheck-next-error
		"ep" 'flycheck-previous-error
		"el" 'flycheck-list-errors

		"j" (cons "jest" (make-sparse-keymap))
		"jb" 'jest-test-run
		"jp" 'jest-test-run-at-point
		"ja" 'jest-test-run-all-tests
		"jj" 'jest-popup

		"c" (cons "code" (make-sparse-keymap))
		"cs" 'consult-eglot-symbols
		"cd" 'eldoc-doc-buffer
		"cc" 'comment-dwim
		"cr" 'xref-find-references
		"cn" 'xref-find-references-and-replace
		"ch" 'hoogle

		"u" (cons "ui" (make-sparse-keymap))
		"ut" 'consult-theme
		)
	)

(provide 'init-keys)
