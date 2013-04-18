(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/vendor")

;; ============================================================================
;; Set up OS-vars to enable os-specific tweaking of emacs, eg.
;;   (if macosx-p
;;       (progn ...))
(defvar mswindows-p (string-match "windows" (symbol-name system-type)))
(defvar macosx-p (string-match "darwin" (symbol-name system-type)))
(defvar linux-p (string-match "linux" (symbol-name system-type)))

(load "my/functions")
(load "my/env")

(require 'uniquify)

(vendor 'autopair)
(vendor 'browse-kill-ring)
(vendor 'color-theme)
; (vendor 'cedet)
; (vendor 'ecb)
(vendor 'fixme)

;; Not loading this in emacs24 due to the following warning message:
;; Warning (mule): `unibyte: t' is obsolete; use "coding: 'raw-text" instead.
;; (vendor 'goto-last-change)
(vendor 'hl-line+)
(vendor 'ido)
(vendor 'ibuffer)
(vendor 'ssh)
(vendor 'yasnippet)
; (vendor 'magit)
; (vendor 'minimap)
(vendor 'expand-region)

(load "my/globals")
(load "my/cua")
(load "my/tabs")
(load "my/spelling")
(load "my/expand-region")

;; Setup Programming Environments
(load "my/ess")
(load "my/polymode")

(load "my/platform-specific-settings")

(load "my/bindings")

;; ============================================================================
;; Auto-generated custom settings (from M-x customize ...)
;; ============================================================================
(setq custom-file "~/.emacs.d/my/local-config.el")
(load custom-file 'noerror)
