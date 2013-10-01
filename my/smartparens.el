;; For more config options, see:
;;   https://github.com/Fuco1/smartparens/wiki/Example-configuration
(add-to-list 'load-path (expand-file-name "~/.emacs.d/vendor/smartparens"))

(require 'smartparens-config)
(smartparens-global-mode t)

;; highlights matching pairs
(show-smartparens-global-mode t)
