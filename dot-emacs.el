;; ============================================================================
;; The first part of this config sets up the load path and simply includes /
;; requires the libraries used most.
;; 
;; The second half of the file contains personal tweaks to the libraries and
;; emacs itself
;; ============================================================================

(add-to-list 'load-path (expand-file-name "~/.emacs.d/plugins"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/plugins/ecb-2.40"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/plugins/color-theme-6.6.0"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/my"))

(require 'color-theme)
(load-file "~/.emacs.d/plugins/cedet-1.0pre7/common/cedet.el")
(require 'ecb)
(require 'fixme)

;; my customizations to the packages loaded by default

(require 'my-cedet)
(require 'my-ecb)
(require 'my-local-config)  ;; this file isn't version controlled

;; ============================================================================
;; Swap ctrl-x to be ctrl-l : Banish emacs claw!
;; ============================================================================
(global-set-key (kbd "C-l") ctl-x-map)
(global-set-key (kbd "C-x") 'recenter)

;; ============================================================================
;; Set up OS-vars to enable os-specific tweaking of emacs, eg.
;; (if macosx-p
;;     (progn ...))
;; ============================================================================
(defvar mswindows-p (string-match "windows" (symbol-name system-type)))
(defvar macosx-p (string-match "darwin" (symbol-name system-type)))
(defvar linux-p (string-match "linux" (symbol-name system-type)))

;; ============================================================================
;; Programming language specific customizations
;; ============================================================================
(require 'my-programming-r)

;; ============================================================================
;; Finally auto-generated customizations
;; ============================================================================

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(ecb-options-version "2.40")
)

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "White" :foreground "Black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 130 :width normal :foundry "apple" :family "Consolas")))))
