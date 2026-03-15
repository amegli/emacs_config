
(use-package gptel
	:config
	(setq gptel-default-mode 'org-mode)
  (setq gptel-stream t)
  (setq gptel-confirm-tool-calls t)
  (setq gptel-include-tool-results t))
(add-hook 'gptel-post-response-functions 'gptel-end-of-response)

(use-package agent-shell
  :ensure t
	:ensure-system-package
  ((claude-agent-acp . "npm install -g @zed-industries/claude-agent-acp"))
	:config
  (evil-define-key 'insert agent-shell-mode-map (kbd "RET") #'newline)
  (evil-define-key 'normal agent-shell-mode-map (kbd "RET") #'comint-send-input))

(setq agent-shell-anthropic-authentication
      (agent-shell-anthropic-make-authentication :login t))
(setq agent-shell-anthropic-claude-environment
      (agent-shell-make-environment-variables :inherit-env t))
(setq agent-shell-session-strategy 'prompt)

(provide 'init-ai)
