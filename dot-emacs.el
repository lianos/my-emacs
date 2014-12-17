(add-to-list 'load-path (expand-file-name "~/.emacs.d"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/vendor"))

(load "my/functions")

;; =============================================================================
;; Set up OS-vars to enable os-specific tweaking of emacs, eg.
;;   (if macosx-p
;;       (progn ...))
(defvar mswindows-p (string-match "windows" (symbol-name system-type)))
(defvar macosx-p (string-match "darwin" (symbol-name system-type)))
(defvar linux-p (string-match "linux" (symbol-name system-type)))

(load "my/env")

(require 'uniquify)

(vendor 'browse-kill-ring)
(vendor 'color-theme)
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
(vendor 'multiple-cursors)
(vendor 'markdown-mode)
(vendor 'csv-mode)

(load "my/globals")
(load "my/cua")
(load "my/tabs")
(load "my/spelling")
(load "my/smartparens.el")
(load "my/expand-region")
(load "my/auto-complete.el")

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
