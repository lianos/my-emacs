;; See: https://github.com/vitoshka/polymode
; (setq load-path
;       (append '((expand-file-name "~/libs/emacs/polymode")
;                 (expand-file-name "~/libs/emacs/polymode/modes"))
;               load-path))

(add-to-list 'load-path (expand-file-name "~/.emacs.d/vendor/polymode"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/vendor/polymode/modes"))


(require 'poly-R)
(require 'poly-markdown)
