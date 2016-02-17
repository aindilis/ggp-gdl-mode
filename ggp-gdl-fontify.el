;;; ggp-gdl-fontify.el --- a part of the simple GGP-GDL mode

(defgroup ggp-gdl-faces nil "faces used for GGP-GDL mode"  :group 'faces)

(defvar in-xemacs-p "" nil)

;;; GNU requires that the face vars be defined and point to themselves

(defvar ggp-gdl-main-keyword-face 'ggp-gdl-main-keyword-face
 "Face to use for GGP-GDL relations.")
(defface ggp-gdl-main-keyword-face
 '((((class color)) (:foreground "red" :bold t)))
 "Font Lock mode face used to highlight class refs."
 :group 'ggp-gdl-faces)

(defvar ggp-gdl-function-nri-and-class-face 'ggp-gdl-function-nri-and-class-face
 "Face to use for GGP-GDL keywords.")
(defface ggp-gdl-function-nri-and-class-face
 (if in-xemacs-p 
  '((((class color)) (:foreground "red"))
    (t (:foreground "gray" :bold t)))
  ;; in GNU, no bold, so just use color
  '((((class color))(:foreground "red"))))
 "Font Lock mode face used to highlight property names."
 :group 'ggp-gdl-faces)

(defvar ggp-gdl-normal-face 'ggp-gdl-normal-face "regular face")
(defface ggp-gdl-normal-face
 '((t (:foreground "grey")))
 "Font Lock mode face used to highlight property names."
 :group 'ggp-gdl-faces)

(defvar ggp-gdl-string-face 'ggp-gdl-string-face "string face")
(defface ggp-gdl-string-face
 '((t (:foreground "green4")))
 "Font Lock mode face used to highlight strings."
 :group 'ggp-gdl-faces)

(defvar ggp-gdl-logical-operator-face 'ggp-gdl-logical-operator-face
 "Face to use for GGP-GDL logical operators (and, or, not, exists, forall, =>, <=>)")
;; same as function name face
(defface ggp-gdl-logical-operator-face
 '((((class color)) (:foreground "blue")))
 "Font Lock mode face used to highlight class names in class definitions."
 :group 'ggp-gdl-faces)

(defvar ggp-gdl-main-relation-face 'ggp-gdl-main-relation-face
 "Face to use for GGP-GDL relations.")
(defface ggp-gdl-main-relation-face
 '((((class color)) (:foreground "black" :bold t)))
 "Font Lock mode face used to highlight class refs."
 :group 'ggp-gdl-faces)

(defvar ggp-gdl-relation-face 'ggp-gdl-relation-face
 "Face to use for GGP-GDL relations.")
(defface ggp-gdl-relation-face
 '((((class color)) (:foreground "cyan1")))
 "Font Lock mode face used to highlight class refs."
 :group 'ggp-gdl-faces)

;; (defvar ggp-gdl-property-face 'ggp-gdl-property-face
;;   "Face to use for GGP-GDL property names in property definitions.")
;; (defface ggp-gdl-property-face
;;   (if in-xemacs-p  
;;      '((((class color)) (:foreground "darkviolet" :bold t))
;;        (t (:italic t)))
;;     ;; in gnu, just magenta
;;     '((((class color)) (:foreground "darkviolet"))))
;;      "Font Lock mode face used to highlight property names."
;;      :group 'ggp-gdl-faces)

(defvar ggp-gdl-variable-face 'ggp-gdl-variable-face
 "Face to use for GGP-GDL property name references.")
(defface ggp-gdl-variable-face
 '((((class color)) (:foreground "darkviolet" ))
   (t (:italic t)))
 "Font Lock mode face used to highlight property refs."
 :group 'ggp-gdl-faces)

(defvar ggp-gdl-comment-face 'ggp-gdl-comment-face
 "Face to use for GGP-GDL comments.")
(defface ggp-gdl-comment-face
 '((((class color) ) (:foreground "red" :italic t))
   (t (:foreground "DimGray" :italic t)))
 "Font Lock mode face used to highlight comments."
 :group 'ggp-gdl-faces)

(defvar ggp-gdl-other-face 'ggp-gdl-other-face
 "Face to use for other keywords.")
(defface ggp-gdl-other-face
 '((((class color)) (:foreground "peru")))
 "Font Lock mode face used to highlight other GGP-GDL keyword."
 :group 'ggp-gdl-faces)

;; (defvar ggp-gdl-tag-face 'ggp-gdl-tag-face
;;   "Face to use for tags.")
;; (defface ggp-gdl-tag-face
;;     '((((class color)) (:foreground "violetred" ))
;;       (t (:foreground "black")))
;;   "Font Lock mode face used to highlight other untyped tags."
;;   :group 'ggp-gdl-faces)

;; (defvar ggp-gdl-substitution-face 'ggp-gdl-substitution-face "face to use for substitution strings")
;; (defface ggp-gdl-substitution-face
;;     '((((class color)) (:foreground "orangered"))
;;       (t (:foreground "lightgrey")))
;;   "Face to use for GGP-GDL substitutions"
;;   :group 'ggp-gdl-faces)


;;;================================================================
;;; these are the regexp matches for highlighting GGP-GDL 

(defvar ggp-gdl-font-lock-prefix "\\b")
(defvar ggp-gdl-font-lock-keywords
 (let ()
  (list 

   ;; (list
   ;;  "^[^;]*\\(;.*\\)$" '(1 ggp-gdl-comment-face nil))

   (list 
    ;; (concat "^\s*[^;][^\n\r]*[\s\n\r(]\\b\\(and\\|or\\|not\\|exists\\|forall\\)\\b"
    (concat "\\b\\(and\\|or\\|not\\|exists\\|forall\\)\\b"
     )
    '(1 ggp-gdl-logical-operator-face nil)
    )
   
   (list 
    (concat ggp-gdl-font-lock-prefix "\\(" (join "\\|"
					    ggp-gdl-mode-main-relation ) "\\)\\b" ) '(1
										      ggp-gdl-main-relation-face nil) )

   (list
    (concat ggp-gdl-font-lock-prefix "\\(" 
     (join "\\|"
      ggp-gdl-mode-functions-non-relational-instances-and-classes) "\\)\\b")
    '(1 ggp-gdl-function-nri-and-class-face nil))

   (list 
    (concat
     ggp-gdl-font-lock-prefix "\\([_a-zA-Z0-9-]+Fn\\)\\b" )
    '(1 ggp-gdl-function-nri-and-class-face nil) )

   (list 
    (concat "\\(\\?[_a-zA-Z0-9-]+\\)\\b"
     )
    '(1 ggp-gdl-variable-face nil)
    )

   (list 
    (concat "\\(\\&\\%[_A-Za-z0-9-]+\\)\\b"
     )
    '(1 ggp-gdl-other-face nil)
    )

   (list 
    (concat ggp-gdl-font-lock-prefix "\\(" (join "\\|"
					    ggp-gdl-mode-relations) "\\)\\b" ) '(1
										 ggp-gdl-relation-face nil) )

   (list 
    ;; (concat "^\s*[^;][^\n\r]*[\s\n\r(]\\(=>\\|<=>\\)"
    (concat "\\(<=\\)")
    '(1 ggp-gdl-logical-operator-face nil)
    )

   (list 
    (concat ggp-gdl-font-lock-prefix "\\(" (join "\\|"
					    ggp-gdl-mode-main-keyword ) "\\)\\b" ) '(1
										     ggp-gdl-main-keyword-face nil) )

   
   (list 
    (concat "(\\([a-zA-Z][_a-zA-Z0-9-]*\\)\\b")
    '(1
      ggp-gdl-relation-face nil) )

   
   ;; black for the def parts of PROPERTY DEFINITION
   ;; and of TransitiveProperty UnambiguousProperty UniqueProperty
;;; END OF LIST ELTS
   ))

 "Additional expressions to highlight in GGP-GDL mode.")



(put 'ggp-gdl-mode 'font-lock-defaults '(ggp-gdl-font-lock-keywords nil nil))

(defun re-font-lock () (interactive) (font-lock-mode 0) (font-lock-mode 1))

(provide 'ggp-gdl-fontify)
