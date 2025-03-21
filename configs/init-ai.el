
(use-package gptel
	:config
	(setq gptel-default-mode 'org-mode)
  (setq gptel-stream t)
  (setq gptel-confirm-tool-calls t)
  (setq gptel-include-tool-results t))
(add-hook 'gptel-post-response-functions 'gptel-end-of-response)

(use-package copilot
  :straight (:host github :repo "copilot-emacs/copilot.el" :files ("dist" "*.el"))
  :config
  (setq copilot-idle-delay 60)
  (global-set-key (kbd "C-'") 'copilot-complete)
  :hook (prog-mode-hook . copilot-mode)
  :bind (:map copilot-completion-map
              ("<tab>" . 'copilot-accept-completion)
              ("TAB" . 'copilot-accept-completion)
              ("C-TAB" . 'copilot-accept-completion-by-word)
              ("C-<tab>" . 'copilot-accept-completion-by-word)))

(provide 'init-ai)
