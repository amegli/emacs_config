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

(defun mgli/suitescript-parse-define ()
  "Extract dependencies from the define() statement in the current buffer."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (when (re-search-forward
           (rx "define" "("
               "[" (group (zero-or-more (not (any "]")))) "]"
               "," (zero-or-more space)
               "(" (group (zero-or-more (not (any ")")))) ")")
           nil t)
      (let ((raw-modules (match-string 1))
            (raw-vars (match-string 2)))
        (let* ((modules
                (mapcar #'mgli/expand-suitescript-path
                        (split-string raw-modules "[\'\,\n]+" t "[\s\t\n]+")))
               (vars (split-string raw-vars "[\'\,\n]+" t "[\s\t\n]+")))
          (cl-mapcar #'cons modules vars))))))

(defun mgli/expand-suitescript-path (path)
  (let ((expanded-path (car (projectile-expand-paths
                             (projectile-normalise-paths (list path))))))
    (or (if expanded-path (concat expanded-path ".js") path))))

(defun mgli/suitescript-completion-at-point ()
  "Provide completion for SuiteScript modules loaded via define()."
  (interactive)
  (let* ((bounds (bounds-of-thing-at-point 'symbol))
         (start (car bounds))
         (end (cdr bounds))
         (modules (mgli/suitescript-parse-define))
         (symbols (mapcar #'cdr modules)))
    (when (and start end (member (buffer-substring start end) symbols))
      (list start end symbols :exclusive 'no)))
  )

;; (add-hook 'js-mode-hook
;;           (lambda () (add-hook 'completion-at-point-functions 'suitescript-completion-at-point nil t)))

(defun mgli/suitescript-jump-to-definition ()
  "Jump to the definition of the module associated with the symbol at point."
  (interactive)
  (let* ((modules (mgli/suitescript-parse-define))
         (symbol-at-point (thing-at-point 'symbol t))
         (module-path (car (rassoc symbol-at-point modules))))
    (if module-path
        (find-file module-path)
      (message "No module found for: %s - %s" symbol-at-point modules))))

(defun mgli/suitescript-extract-methods (file-path)
  "Extract function names from a JavaScript file using js2-mode."
  (with-temp-buffer
    (insert-file-contents file-path)
    (js2-mode)
    (js2-reparse)
    (let (methods)
      (js2-visit-ast
       js2-mode-ast
       (lambda (node)
         (when (js2-function-node-p node)
           (let ((func-name (js2-name-node-name (js2-function-node-name node))))
             (when func-name
               (push func-name methods))))))
      methods)))

(provide 'mgli-misc)
;;; mgli-misc.el ends here
