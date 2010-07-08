;; ============================================================================
;; Set up OS-vars to enable os-specific tweaking of emacs, eg.
;; (if macosx-p
;;     (progn ...))
;; ============================================================================
(defvar mswindows-p (string-match "windows" (symbol-name system-type)))
(defvar macosx-p (string-match "darwin" (symbol-name system-type)))
(defvar linux-p (string-match "linux" (symbol-name system-type)))

;; ============================================================================
;; Alter emacs search path
;; ============================================================================
(add-to-list 'load-path (expand-file-name "~/.emacs.d/plugins"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/plugins/ecb-2.40"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/plugins/color-theme-6.6.0"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/plugins/yasnippet-0.6.1c"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/plugins/wrap-region"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/my"))

;; ============================================================================
;; Load packages by default
;; ============================================================================
(load-file "~/.emacs.d/plugins/cedet-1.0pre7/common/cedet.el")

(require 'autopair)
(require 'color-theme)
(require 'ecb)
(require 'fixme)
(require 'hl-line+)
(require 'ido)
(require 'wrap-region)
(require 'yasnippet)

;; ============================================================================
;; My customization to packages and general local/machine settings
;; ============================================================================
(require 'my-globals)
(require 'my-functions)

(require 'my-autopair)
(require 'my-cedet)
(require 'my-color-theme)
(require 'my-cua)
(require 'my-ecb)
(require 'my-ido)
(require 'my-yasnippet)

(require 'my-local-config)  ;; this file isn't version controlled

;; ============================================================================
;; Programming language specific customizations
;; ============================================================================
(require 'my-programming-r)

;; ============================================================================
;; Auto-generated custom settings (from M-x customize ...)
;; ============================================================================
(setq custom-file "~/.emacs.d/my-local-config.el")
(load custom-file 'noerror)

