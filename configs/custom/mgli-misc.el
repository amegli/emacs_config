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
  "Scale and weight org headings so nesting depth reads at a glance.
Top three levels are bold anchors; deeper levels stay regular so
long, deeply-nested notes don't turn into a wall of large bold text."
  (dolist (spec '((org-level-1 1.40 bold)
                  (org-level-2 1.25 bold)
                  (org-level-3 1.15 bold)
                  (org-level-4 1.10 regular)
                  (org-level-5 1.05 regular)
                  (org-level-6 1.00 regular)
                  (org-level-7 1.00 regular)
                  (org-level-8 1.00 regular)))
    (cl-destructuring-bind (face height weight) spec
      (set-face-attribute face nil
                           :font "Hack Nerd Font"
                           :weight weight
                           :height height))))

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
