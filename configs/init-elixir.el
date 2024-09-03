(use-package elixir-mode
  :ensure t)

(provide 'init-elixir)

(add-hook 'elixir-mode-hook 'eglot-ensure)
(add-to-list 'eglot-server-programs '(elixir-mode "../elixir-ls-v0/language_server.sh"))
