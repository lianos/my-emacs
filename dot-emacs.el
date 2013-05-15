(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/vendor")

;; ============================================================================
;; For loading libraries from the vendor directory and then loading my
;; customizations for that library. Taken from:
;; https://github.com/rmm5t/dotfiles/blob/master/emacs.d/rmm5t/defuns.el
(defun vendor (library &rest autoload-functions)
  (let* ((file (symbol-name library))
         (normal (concat "~/.emacs.d/vendor/" file))
         (suffix (concat normal ".el"))
         (personal (concat "~/.emacs.d/my/" file))
   (found nil))
    (cond
     ((file-directory-p normal) (add-to-list 'load-path normal) (set 'found t))
     ((file-directory-p suffix) (add-to-list 'load-path suffix) (set 'found t))
     ((file-exists-p suffix)  (set 'found t)))
    (when found
      (if autoload-functions
          (dolist (autoload-function autoload-functions)
            (autoload autoload-function (symbol-name library) nil t))
        (require library)))
    (when (file-exists-p (concat personal ".el"))
      (load personal))))

;; ============================================================================
;; Set up OS-vars to enable os-specific tweaking of emacs, eg.
;;   (if macosx-p
;;       (progn ...))
(defvar mswindows-p (string-match "windows" (symbol-name system-type)))
(defvar macosx-p (string-match "darwin" (symbol-name system-type)))
(defvar linux-p (string-match "linux" (symbol-name system-type)))


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

(vendor 'markdown-mode)

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
(load "my/functions")

;; ============================================================================
;; Auto-generated custom settings (from M-x customize ...)
;; ============================================================================
(setq custom-file "~/.emacs.d/my/local-config.el")
(load custom-file 'noerror)
