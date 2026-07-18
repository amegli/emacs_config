(use-package gptel
  :config
  (setq gptel-default-mode 'org-mode)
  (setq gptel-stream t)
  (setq gptel-confirm-tool-calls t)
  (setq gptel-include-tool-results t))
(add-hook 'gptel-post-response-functions 'gptel-end-of-response)

(use-package claude-code-ide
  :straight (claude-code-ide :type git :host github
                             :repo "manzaltu/claude-code-ide.el")
  :custom
  (claude-code-ide-terminal-backend 'eat)
  (claude-code-ide-diagnostics-backend 'auto)
  (claude-code-ide-enable-execute-code t)
  :config
  (with-eval-after-load 'evil
    (add-to-list 'evil-buffer-regexps '("\\*claude-code\\[" . insert))))

(provide 'init-ai)
