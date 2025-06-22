;;; mgli-misc.el --- -*- lexical-binding: t -*-
;;; Commentary:
;; 

;;; Code:
(defun mgli-copy-current-file-name ()
  (interactive)
  (if-let ((file-name (buffer-file-name)))
      (progn
        (kill-new file-name)
        (message "Copied file name '%s' to the clipboard." file-name))
    (message "Current buffer is not associated with a file.")))

(defun mgli-consult-ripgrep ()
	(interactive)
	(let ((current_symbol (symbol-at-point)))
		(consult-ripgrep nil (when current_symbol (symbol-name current_symbol)))))

(defun mgli/org-heading-setup ()
  (dolist (face '((org-level-1 . 1.5)
                  (org-level-2 . 1.3)
                  (org-level-3 . 1.2)
                  (org-level-4 . 1.1)
                  (org-level-5 . 1.0)
                  (org-level-6 . 1.0)
                  (org-level-7 . 1.0)
                  (org-level-8 . 1.0)))
    (set-face-attribute (car face) nil :font "Hack Nerd Font" :weight 'regular :height (cdr face))))

(defun mgli/bottom-eshell (terminal-func)
  (interactive)
  (split-window-below -30)
  (other-window 1)
  (set-window-parameter (selected-window) 'is-mgli-term t)
  (funcall terminal-func))

(defun mgli/close-bottom-eshell (orig-fun &rest args)
  (let ((is-mgli-term (window-parameter (selected-window) 'is-mgli-term)))
    (apply orig-fun args)
    (when is-mgli-term
      (delete-window))))

(provide 'mgli-misc)
;;; mgli-misc.el ends here
