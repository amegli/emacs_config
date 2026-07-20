(add-hook 'js-mode-hook 'eglot-ensure)
(add-hook 'js-ts-mode-hook 'eglot-ensure)
(add-hook 'js2-mode-hook 'eglot-ensure)
(add-hook 'elixir-mode-hook 'eglot-ensure)
(add-hook 'haskell-mode-hook 'eglot-ensure)
(add-hook 'php-mode-hook 'eglot-ensure)
(add-hook 'racket-mode-hook 'eglot-ensure)
(add-hook 'tsx-ts-mode-hook 'eglot-ensure)
(add-hook 'typescript-ts-mode-hook 'eglot-ensure)
(add-hook 'typescript-mode-hook 'eglot-ensure)
(add-hook 'ruby-ts-mode-hook 'eglot-ensure)
(add-hook 'ruby-mode-hook 'eglot-ensure)
(add-hook 'clojurescript-mode-hook 'eglot-ensure)
(add-hook 'clojure-mode-hook 'eglot-ensure)

(use-package flycheck-eglot
  :after (flycheck eglot)
  :config
  (global-flycheck-eglot-mode 1))

(use-package eldoc-box
  :commands eldoc-box-help-at-point
  :init
  (with-eval-after-load 'evil
    (evil-define-key 'normal 'global "K" #'eldoc-box-help-at-point)))

(use-package consult-eglot)

(setq eldoc-idle-delay .1)

;; Load the SuiteScript tsserver plugin (tools/suitescript-ts-plugin) via eglot
;; initializationOptions, but ONLY for js/ts projects that actually have it
;; installed at their root. That scopes it to the NetSuite repo and never
;; touches other TypeScript projects. Falls back to eglot's default otherwise.
(with-eval-after-load 'eglot
  (require 'cl-lib)
  (cl-defmethod eglot-initialization-options ((server eglot-lsp-server))
    (or (and (cl-intersection '(js-ts-mode js-mode typescript-ts-mode tsx-ts-mode typescript-mode)
                              (eglot--major-modes server))
             (let ((root (ignore-errors (project-root (eglot--project server)))))
               (and root
                    (file-exists-p
                     (expand-file-name "node_modules/suitescript-ts-plugin" root))
                    (list :plugins
                          (vector (list :name "suitescript-ts-plugin"
                                        :location (expand-file-name root)))))))
        (cl-call-next-method))))

(provide 'init-eglot)
