
(defun mgli-copy-current-file-name ()
  (interactive)
  (if-let ((file-name (buffer-file-name)))
      (progn
        (kill-new file-name)
        (message "Copied file name '%s' to the clipboard." file-name))
    (message "Current buffer is not associated with a file.")))

(defvar milton-config-path "/Users/andrewmegli/Development/test/milton/config/"
  "Path to the milton configuration file.")

(defun mgli-milton (action environment)
	"Make milton go"
	(interactive
	 (list
		(read-string "Action (upload, info, diff...) [default upload]: " nil nil "upload")
		(read-string "Environment (dev, test, stage, prod) [default dev]: " nil nil "dev")))
  (let* ((path-arg (unless (string-equal action "command-file") " --path"))
				 (cd-command (if path-arg nil "cd .. && "))
				 (output (shell-command-to-string
									(format (concat cd-command "milton --%s" path-arg " %s --config %s")
													action (shell-quote-argument buffer-file-name)
													(concat (file-name-as-directory milton-config-path) "milton." environment ".config")
													))))
		(with-help-window "*mgli-milton-output*"
			(princ output))))

(defun mgli-milton-command-file (environment)
	"Run milton against the current command file buffer."
	(interactive
	 (list
		(read-string "Environment (dev, test, stage, prod) [default dev]: " nil nil "dev")))
	(mgli-milton "command-file" environment))

(defun mgli-consult-ripgrep ()
	(interactive)
	(let ((current_symbol (symbol-at-point)))
		(consult-ripgrep nil (when current_symbol (symbol-name current_symbol)))))

(defun mgli-switch-to-recent-file (switching-fn)
	"Filter buffer list to file-based buffers and switch to one.
The provided SWITCHING-FN is used to select a buffer from the results.
This is meant for use with 'previous-buffer' and 'next-buffer' but any
similar function will work."
	(interactive)
	(let ((starting-buffer (current-buffer))
				(valid-buffers (match-buffers
												(lambda (buffer)
												  (and
													 (not (eq buffer (current-buffer)))
													 (buffer-file-name buffer))))))
		(if valid-buffers
				(progn
					(dotimes (_ (length (buffer-list)))
						(unless (not (member (current-buffer) valid-buffers))
							(cl-return))
						(funcall switching-fn))
					(if (not (member (current-buffer) valid-buffers))
							(progn
								(switch-to-buffer starting-buffer)
								(message "Exhausted all switch attempts; returning to original buffer."))))
			(message "No valid buffers to switch to."))))

(defun mgli-previous-file ()
	"Switch to the previous file-based buffer."
	(interactive)
	(mgli-switch-to-recent-file #'previous-buffer))

(defun mgli-next-file ()
	"Switch to the next file-based buffer."
	(interactive)
	(mgli-switch-to-recent-file #'next-buffer))

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

		"m" (cons "milton" (make-sparse-keymap))
		"mm" 'mgli-milton
		"mc" 'mgli-milton-command-file

		"s" 'embrace-commander
		
		"o" (cons "org" (make-sparse-keymap))
		"oc" 'org-toggle-checkbox
		"oo" 'org-capture
		"oa" 'org-agenda
		"op" 'evil-org-open-below
		"of" (cons "format" (make-sparse-keymap))
		"ofb" (lambda () (interactive) (org-emphasize ?*))
		"ofi" (lambda () (interactive) (org-emphasize ?/))
		"ofu" (lambda () (interactive) (org-emphasize ?_))
		"ofv" (lambda () (interactive) (org-emphasize ?=))
		"ofc" (lambda () (interactive) (org-emphasize ? ))
		"ofs" (lambda () (interactive) (org-emphasize ?+))

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
		"gv" 'vc-annotate
		"gp" 'magit-pull
		"gc" 'magit-branch-checkout
		"gl" (cons "log" (make-sparse-keymap))
		"glb" 'magit-log-buffer-file
		"gla" 'magit-log-all-branches
		"gd" (cons "diff" (make-sparse-keymap))
		"gdr" 'magit-diff-range
		"gdf" 'magit-diff-paths

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
		"bp" 'mgli-previous-file
		"bn" 'mgli-next-file
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
		"cs" 'lsp-treemacs-symbols
		"ci" 'consult-imenu
		"cd" 'eldoc-doc-buffer
		"cc" 'comment-dwim
		"cr" 'xref-find-references
		"cn" 'xref-find-references-and-replace
		"ch" 'hoogle

		"u" (cons "ui" (make-sparse-keymap))
		"ut" 'consult-theme

		"v" 'vundo
		)
	)

(provide 'init-keys)
