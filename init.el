(setq native-comp-async-report-warnings-errors 'silent)

;; straight.el is the sole package manager (package.el is disabled in
;; early-init.el; quelpa was removed in the straight migration).
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Every (use-package ...) installs via straight unless :straight nil.
(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

;; This Emacs ships transient 0.8.7 in its baked-in site-lisp, but claude-code-ide
;; needs >= 0.9.0 (transient--set-layout).  Force straight's newer transient onto
;; the load-path and into memory now, before magit (init-git) requires the old one.
(straight-use-package 'transient)
(require 'transient)

(add-to-list 'load-path (expand-file-name "~/.config/emacs/configs"))
(add-to-list 'load-path (expand-file-name "~/.config/emacs/configs/custom"))
(add-to-list 'load-path (expand-file-name "~/.config/emacs/configs/languages"))

(require 'init-setup)
(require 'milton)
(require 'recent-file)
(require 'mgli-misc)
(require 'mark-ring)

(require 'init-flycheck)

;; Pick one
(require 'init-eglot)
;; (require 'init-lsp)

(require 'init-keys)
(require 'init-ui)
(require 'init-evil)
(require 'init-completion)
(require 'init-project)
(require 'init-git)
(require 'init-org)

(require 'init-haskell)
(require 'init-elixir)
(require 'init-javascript)
(require 'init-ruby)
(require 'init-clojure)
(require 'init-lang-misc)

(require 'init-ai)
(require 'init-terminal)
(require 'init-dashboard)
(put 'downcase-region 'disabled nil)

(require 'server)
(unless (server-running-p)
  (server-start))
