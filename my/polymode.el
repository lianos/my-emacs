;; See: https://github.com/vitoshka/polymode
; (setq load-path
;       (append '((expand-file-name "~/libs/emacs/polymode")
;                 (expand-file-name "~/libs/emacs/polymode/modes"))
;               load-path))

(add-to-list 'load-path (expand-file-name "~/.emacs.d/vendor/polymode"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/vendor/polymode/modes"))


(require 'poly-R)
(require 'poly-markdown)

;; Activating polymodes by registering them to `auto-mode-alist`
;;; MARKDOWN
(add-to-list 'auto-mode-alist '("\\.md" . poly-markdown-mode))

;;; ORG
(add-to-list 'auto-mode-alist '("\\.org" . poly-org-mode))


;;; R related modes
(add-to-list 'auto-mode-alist '("\\.Snw" . poly-noweb+r-mode))
(add-to-list 'auto-mode-alist '("\\.Rnw" . poly-noweb+r-mode))
(add-to-list 'auto-mode-alist '("\\.Rmd" . poly-markdown+r-mode))
(add-to-list 'auto-mode-alist '("\\.rapport" . poly-rapport-mode))
(add-to-list 'auto-mode-alist '("\\.Rhtml" . poly-html+r-mode))
(add-to-list 'auto-mode-alist '("\\.Rbrew" . poly-brew+r-mode))
(add-to-list 'auto-mode-alist '("\\.Rcpp" . poly-r+c++-mode))
(add-to-list 'auto-mode-alist '("\\.cppR" . poly-c++r-mode))

