;; Although not a required part of the syntax, by convention,
;; relations are written with an initial lowercase character, and
;; functions, non-relational instances and classes are written with
;; initial capital letters.

(defvar ggp-gdl-mode-main-relation
 (list
  ))

(defvar ggp-gdl-mode-main-keyword
 (list
  "role"
  "init"
  "next"
  "true"
  "does"
  "terminal"
  "goal"
  ))

(defvar ggp-gdl-mode-functions-non-relational-instances-and-classes
 (list
  ))

(defvar ggp-gdl-mode-relations
 (list
  ))

(defvar ggp-gdl-mode-all-terms
 (append ggp-gdl-mode-main-keyword ggp-gdl-mode-main-relation
  ggp-gdl-mode-functions-non-relational-instances-and-classes
  ggp-gdl-mode-relations
  (list "-1" "<=>" "=>")))

(provide 'ggp-gdl-terms)
