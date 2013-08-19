;; Installed on 2013-05-17 like so:
;;   make install DIR=~/.emacs.d/vendor
;;   emacs -Q -L . -batch -l etc/install /Users/lianogls/.emacs.d/vendor
;;   Installing to /Users/lianogls/.emacs.d/vendor from /Users/lianogls/Downloads/auto-complete-1.3.1/
;;   Wrote /Users/lianogls/Downloads/auto-complete-1.3.1/auto-complete-config.elc
;;   Wrote /Users/lianogls/Downloads/auto-complete-1.3.1/auto-complete.elc
;;   Wrote /Users/lianogls/Downloads/auto-complete-1.3.1/fuzzy.elc
;;   Wrote /Users/lianogls/Downloads/auto-complete-1.3.1/popup.elc
;;   Successfully installed!
;;
;;   Add the following code to your .emacs:
;;
;;   (add-to-list 'load-path "/Users/lianogls/.emacs.d/vendor")
;;   (require 'auto-complete-config)
;;   (add-to-list 'ac-dictionary-directories "/Users/lianogls/.emacs.d/vendor/ac-dict")
;;   (ac-config-default)

(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories (expand-file-name "~/.emacs.d/vendor/ac-dict"))
(ac-config-default)
