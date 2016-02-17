(defun ggp-gdl-util-contains-all-terms (string term-list)
 ""
 (setq kmax-contains-all-terms-all-match t)
 (mapcar (lambda (term)
	  (if (not (string-match-p term string))
	   (setq kmax-contains-all-terms-all-match nil))) term-list)
 kmax-contains-all-terms-all-match)

(setq auto-mode-alist
 (cons '("\\.kif$" . ggp-gdl-sigmakee-or-ggp-gdl-mode) auto-mode-alist))

(defun ggp-gdl-sigmakee-or-ggp-gdl-mode ()
 "Determine if the current file is a perl or prolog file, and load the appropriate mode"
 (interactive)
 (let ((type (ggp-gdl-sigmakee-or-ggp-gdl-file)))
  (cond 
   ((string= type "sigmakee") (sigmakee-mode))
   ((string= type "ggp-gdl") (ggp-gdl-mode)))))

;; auto-mode-alist

(defun ggp-gdl-sigmakee-or-ggp-gdl-file ()
 ""
 (interactive)
 (let ((contents (buffer-string)))
  (if (ggp-gdl-util-contains-all-terms contents ggp-gdl-mode-main-keyword)
   "ggp-gdl"
   "sigmakee")))

(let ((dir "/var/lib/myfrdcsa/codebases/minor/ggp-gdl-mode"))
 (if (file-exists-p dir)
  (setq load-path
   (cons dir load-path))))

(add-to-list 'auto-mode-alist '("\\.gdl\\'" . ggp-gdl-mode))

;; add something here to check kif files for whether they contain the
;; gdl keywords and if so, make it kif mode, just like prolog/perl
;; thingy

(require 'ggp-gdl-terms)
(require 'ggp-gdl-fontify)
(if (featurep 'freekbs2)
 (require 'ggp-gdl-freekbs2))

(define-derived-mode ggp-gdl-mode
 emacs-lisp-mode "GGP-GDL"
 "Major mode for Sigma Knowledge Engineering Environment.
\\{ggp-gdl-mode-map}"
 (setq case-fold-search nil)
 (define-key ggp-gdl-mode-map [tab] 'ggp-gdl-mode-complete)
 (define-key ggp-gdl-mode-map "\C-csl" 'ggp-gdl-mode-load-assertion-into-stack)
 (define-key ggp-gdl-mode-map "\C-csL" 'ggp-gdl-mode-print-assertion-from-stack)
 ;; (suppress-keymap ggp-gdl-mode-map)

 (make-local-variable 'font-lock-defaults)
 (setq font-lock-defaults '(ggp-gdl-font-lock-keywords nil nil))
 (re-font-lock)
 )

(defun ggp-gdl-mode-complete (&optional predicate)
 "Perform completion on GGP-GDL symbol preceding point.
Compare that symbol against the known GGP-GDL symbols.

When called from a program, optional arg PREDICATE is a predicate
determining which symbols are considered, e.g. `commandp'.
If PREDICATE is nil, the context determines which symbols are
considered.  If the symbol starts just after an open-parenthesis, only
symbols with function definitions are considered.  Otherwise, all
this-command-keyssymbols with function definitions, values or properties are
considered."
 (interactive)
 (let* ((end (point))
	(beg (with-syntax-table emacs-lisp-mode-syntax-table
	      (save-excursion
	       (backward-sexp 1)
	       (while (or
		       (= (char-syntax (following-char)) ?\')
		       (char-equal (following-char) ?\$)
		       (char-equal (following-char) ?\#))
		(forward-char 1))
	       (point))))
	(pattern (buffer-substring-no-properties beg end))
	;; (ggp-gdl-output
	;;  (ggp-gdl-query
	;;   (concat "(constant-complete " "\"" pattern "\")\n")))
	;; (completions
	;;  (cm-convert-string-to-alist-of-strings
	;;   (progn
	;;    (string-match "(\\([^\)]*\\))" ; get this from Cyc and format it into an alist
	;;     cm-cyc-output)
	;;    (match-string 1 cm-cyc-output))))
	(completions
	 ggp-gdl-mode-all-terms)
	(completion (try-completion pattern completions)))
  (cond ((eq completion t))
   ((null completion)
    (message "Can't find completion for \"%s\"" pattern)
    (ding))
   ((not (string= pattern completion))
    (delete-region beg end)
    (insert completion))
   (t
    ;; (message "Making completion list...")
    ;; (let ((list (all-completions pattern completions)))
    ;;  (setq list (sort list 'string<))
    ;;  (with-output-to-temp-buffer "*Completions*"
    ;;   (display-completion-list list)))
    ;; (message "Making completion list...%s" "done")
    (let* 
     ((expansion (completing-read "Term: " 
		  (all-completions pattern completions) nil nil pattern))
      (regex (concat pattern "\\(.+\\)")))

     (string-match regex expansion)
     (insert (match-string 1 expansion)))))))

(provide 'ggp-gdl-mode)
