;; http://emacs-fu.blogspot.com/2010/02/dealing-with-many-buffers-ibuffer.html
;; Look into using eproject: http://github.com/jrockway/eproject
(setq ibuffer-saved-filter-groups
  (quote (("default"      
            ;; ("Org" ;; all org-related buffers
            ;;   (mode . org-mode))  
            ;; ("Mail"
            ;;   (or  ;; mail-related buffers
            ;;    (mode . message-mode)
            ;;    (mode . mail-mode)
            ;;    ;; etc.; all your mail related modes
            ;;    ))
            ("TagSeqAnalysis" (filename . "TagSeqAnalysis/"))
            ("TagSeq" (filename . "TagSeq/"))
            ("SeqStore" (filename . "SeqStore/"))
            ("SeqTools" (filename . "seqtools/"))
            ("biosignals" (filename . "biosignals/"))
            ("GenomicCache" (filename . "GenomicCache/"))
            ("ARE.utils" (filename . "ARE.utils/"))
            ("data.table" (filename . "data.table/"))
            ("shikken" (filename . "shikken/"))
            ("buckshot" (filename . "buckshot/"))
	    ("Programming/R"
	     (mode . ess-mode))
            ("ESS-help"
             (name . "help[R]"))
            ;; ("R Processes"
	    ;;  ())
            ("Programming" ;; prog stuff not already in MyProjectX
              (or
                (mode . c-mode)
                (mode . perl-mode)
                (mode . python-mode)
                (mode . emacs-lisp-mode)
                )) 
            ;; ("ERC"   (mode . erc-mode))
	    ))))

(add-hook 'ibuffer-mode-hook
  (lambda ()
    (ibuffer-switch-to-saved-filter-groups "default")))

;; (provide 'my-ibuffer)
