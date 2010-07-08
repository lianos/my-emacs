;; New/custom color-theme definitions are stored in my own special place
(add-to-list 'load-path (expand-file-name "~/.emacs.d/my/color-themes"))


;; TODO: Figure out how to auto-include all *.el files in ../color-themes
;;  Check: 
;;    http://www.cs.huji.ac.il/~osigor/emacs/load.html
;;    http://www.cs.huji.ac.il/~osigor/emacs/src/htmlized/elisp-load-dir.el.html
(require 'zenburn)

(setq color-theme-is-global t)

;; Do the color picking in my-local-config because I'm having problems with
;; the color-theme when it's run from the terminal vs. Emacs.app
;; (color-theme-initialize)
;; (color-theme-zenburn)

;; Use black bacground color scheme if running in a terminal
;; (if (not window-system)
;;   (progn
;;     (color-theme-initialize)    ;; Use a dark 
;;     (color-theme-zenburn)))


(provide 'my-color-theme)