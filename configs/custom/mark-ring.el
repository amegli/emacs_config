;;; mark-ring.el --- -*- lexical-binding: t -*-
;;; Commentary:
;; 

;;; Code:
(defvar-local mgli-mark-ring '())
(defvar-local mgli-mark-ring-index 0)

(defun mgli-mark-ring-forward ()
	"Move forward in the list of evil marks and visit the mark."
	(interactive)
	(when mgli-mark-ring
    (setq mgli-mark-ring-index
          (mod (1- mgli-mark-ring-index) (length mgli-mark-ring)))
    (evil-goto-mark-line (nth mgli-mark-ring-index mgli-mark-ring))))

(defun mgli-mark-ring-back ()
	"Move backward in the list of evil marks and visit the mark."
	(interactive)
	(when mgli-mark-ring
    (setq mgli-mark-ring-index
          (mod (1+ mgli-mark-ring-index) (length mgli-mark-ring)))
    (evil-goto-mark-line (nth mgli-mark-ring-index mgli-mark-ring))))

(defun mgli-push-mark-ring (char &optional _pos _buffer)
	(when (and (characterp char)
						 (>= char ?a)
						 (<= char ?z)
						 (not (member char mgli-mark-ring)))
		(push char mgli-mark-ring)
		(1+ mgli-mark-ring-index)))

(advice-add 'evil-set-marker :after #'mgli-push-mark-ring)

(provide 'mark-ring)
;;; mark-ring.el ends here
