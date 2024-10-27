(use-package elixir-mode
  :ensure t)

(provide 'init-elixir)

;; brew install tree-sitter
;; M-x heex-ts-install-grammar
;; (use-package elixir-ts-mode
;; 	:ensure t
;; 	)

(add-hook 'elixir-mode-hook 'eglot-ensure)
(add-to-list 'eglot-server-programs '(elixir-mode "../elixir-ls-v0/language_server.sh"))
