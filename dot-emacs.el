(add-to-list 'load-path (expand-file-name "~/.emacs.d/plugins"))
;;(add-to-list 'load-path (expand-file-name "~/.emacs.d/plugins/ecb-2.32"))
;;(add-to-list 'load-path (expand-file-name "~/.emacs.d/plugins/speedbar-0.14beta4"))
;;(add-to-list 'load-path (expand-file-name "~/.emacs.d/plugins/eieio-0.17"))
;;(add-to-list 'load-path (expand-file-name "~/.emacs.d/plugins/semantic-1.4.4"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/plugins/color-theme-6.6.0"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/my"))

(require 'fixme)
(require 'color-theme)

;; =========== The most important settings: swap ctl-x to ctl-l =========
(global-set-key (kbd "C-l") ctl-x-map)
(global-set-key (kbd "C-x") 'recenter)


;; =========== Programming Language Customizations
(require 'my-programming-r)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "White" :foreground "Black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 130 :width normal :foundry "apple" :family "Consolas")))))
