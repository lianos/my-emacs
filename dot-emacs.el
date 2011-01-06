(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/vendor")

;; ============================================================================
;; Set up OS-vars to enable os-specific tweaking of emacs, eg.
;; (if macosx-p
;;     (progn ...))
;; ============================================================================
(defvar mswindows-p (string-match "windows" (symbol-name system-type)))
(defvar macosx-p (string-match "darwin" (symbol-name system-type)))
(defvar linux-p (string-match "linux" (symbol-name system-type)))

(load "my/functions")
(load "my/env")

(vendor 'autopair)
(vendor 'browse-kill-ring)
(vendor 'color-theme)
(vendor 'cedet)
(vendor 'ecb)
(vendor 'fixme)
(vendor 'goto-last-change)
(vendor 'hl-line+)
(vendor 'ido)
(vendor 'ibuffer)
(vendor 'ssh)
(vendor 'uniquify)
(vendor 'wrap-region)
(vendor 'yasnippet)

(load "my/globals")
(load "my/bindings")
(load "my/cua")
(load "my/tabs")

;; Setup Programming Environments
(load "my/ess")

;; ============================================================================
;; Auto-generated custom settings (from M-x customize ...)
;; ============================================================================
(setq custom-file "~/.emacs.d/my/local-config.el")
(load custom-file 'noerror)
