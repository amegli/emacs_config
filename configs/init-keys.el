(define-key minibuffer-local-map (kbd "C-c C-n") #'evil-normal-state)

(use-package general
	:after evil
	:config
	(general-evil-setup t)
	(general-define-key
	 :states '(normal visual motion emacs)
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
		"glc" 'magit-log-current
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

		"r" (cons "bookmark" (make-sparse-keymap))
		"rm" 'bookmark-set
		"rj" 'bookmark-jump
		"rl" 'list-bookmarks
		"rd" 'bookmark-delete

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
		"uf" (cons "text" (make-sparse-keymap))
		"uf+" 'text-scale-increase
		"uf-" 'text-scale-decrease
		"ufr" 'default-text-scale-reset

		"v" 'vundo
		)
	)

(with-eval-after-load 'eglot
  (general-define-key
   :states '(normal visual motion emacs)
   :keymaps 'eglot-mode-map
   "K" 'eldoc-box-help-at-point))

(provide 'init-keys)
