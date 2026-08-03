
(use-package magit
  :commands (magit-status magit-get-current-branch)
	:config
  (remove-hook 'magit-status-sections-hook 'magit-insert-unpushed-to-pushremote)
  (remove-hook 'magit-status-sections-hook 'magit-insert-unpulled-from-pushremote)
  (remove-hook 'magit-status-sections-hook 'magit-insert-unpulled-from-upstream)
  (remove-hook 'magit-status-sections-hook 'magit-insert-unpushed-to-upstream-or-recent))

(use-package forge
  :after magit)

;; Magit status always opens in the current window; diffs/logs still split off
(setq magit-display-buffer-function
      #'magit-display-buffer-same-window-except-diff-v1)

;; Keep ediff in one frame: control panel as a bottom window, variants side by side
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
(setq ediff-split-window-function 'split-window-horizontally)

;; After any SPC g m <key>, bare n/p/u/l/c/a keep resolving conflicts; ESC exits
(defvar-keymap mgli/smerge-repeat-map
  :repeat t
  "n" #'smerge-next
  "p" #'smerge-prev
  "u" #'smerge-keep-upper
  "l" #'smerge-keep-lower
  "c" #'smerge-keep-current
  "a" #'smerge-keep-all)
(setq repeat-exit-key (kbd "<escape>"))
(repeat-mode 1)

(use-package diff-hl
  :init (global-diff-hl-mode)
  :hook ((magit-pre-refresh . diff-hl-magit-pre-refresh)
         (magit-post-refresh . diff-hl-magit-post-refresh)))

(provide 'init-git)
