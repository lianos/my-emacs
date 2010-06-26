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
(add-to-list 'load-path (expand-file-name "~/.emacs.d/plugins/wrap-region"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/plugins/yasnippet-0.6.1c"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/my"))

;; ============================================================================
;; Load packages by default
;; ============================================================================
(load-file "~/.emacs.d/plugins/cedet-1.0pre7/common/cedet.el")

(require 'autopair)
(require 'color-theme)
(require 'ecb)
(require 'fixme)
(require 'ido)
(require 'wrap-region)
(require 'yasnippet)

;; ============================================================================
;; Swap ctrl-x to be ctrl-l : Banish emacs claw!
;; I've found this is necessary to be loaded after provided libraries because
;; some of them set keyboard binidngs straight to "C-x" and not the ctl-x-map
;; (I think)
;; ============================================================================
(global-set-key (kbd "C-l") ctl-x-map)
(global-set-key (kbd "C-x") 'recenter)

;; ============================================================================
;; My customization to packages and general local/machine settings
;; ============================================================================
(require 'my-globals)

(require 'my-autopair)
(require 'my-cedet)
(require 'my-ecb)
(require 'my-ido)
(require 'my-local-config)  ;; this file isn't version controlled
(require 'my-wrap-region)
(require 'my-yasnippet)

;; ============================================================================
;; Programming language specific customizations
;; ============================================================================
(require 'my-programming-r)

;; ============================================================================
;; Auto-generated custom settings (from M-x customize ...)
;; ============================================================================
(setq custom-file "~/.emacs.d/my-local-config.el")
(load custom-file 'noerror)
