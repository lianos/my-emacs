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
            ("GenomicFeaturesX"
	     (filename . "GenomicFeaturesX/"))
            ;; ("GenomeAnnoations"
	    ;;  (filename . "GenomeAnnotations/"))
	    ("SeqStore"
	     (filename . "SeqStore/"))
	    ("TagSeq"
	     (filename . "TagSeq/"))
	    ;; ("DGEseq"
	    ;;  (filename . "DGEseq/"))
	    ;; ("TailSeq"
	    ;;  (filename . "TailSeq/"))
	    ;; ("mayr"
	    ;;  (filename . "mayr.project"))
	    ("Programming/R"
	     (mode . ess-mode))
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
