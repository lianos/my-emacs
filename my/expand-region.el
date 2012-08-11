(load (expand-file-name "~/.emacs.d/vendor/expand-region/expand-region"))
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key (kbd "C--") 'er/contract-region)
