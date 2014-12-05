;; http://emacs-fu.blogspot.com/2010/02/dealing-with-many-buffers-ibuffer.html
;; http://martinowen.net/blog/2010/02/tips-for-emacs-ibuffer.html
;;
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
           ;; ======================================================== Genentech
           ;; Rpkgs
           ("multiGSEA" (filename . "multiGSEA/"))
           ("rmd.plugins" (filename . "rmd.plugins/"))
           ("c3po" (filename . "c3po"))
           ;; Analyses
           ("MICA" (filename . "MICA-B/"))
           ("schmidt/aPDL1" (filename . "schimdt/aPDL1"))
           ;; by collaborator
           ("belvin" (filename . "belvin/"))
           ("grogan" (filename . "grogan/"))
           ("murthy" (filename . "murthy/"))
           ("schmidt" (filename . "schimdt/"))
           ;; ======================================================== Catch All
           ("Programming/R" (mode . ess-mode))
           ("rmarkdown" (filename . ".Rmd"))
           ;; ===================================================== cBio @ MSKCC
           ;; ("ApAcalypse" (filename . "ApAcalypse/"))
           ;; ("TagSeqAnalysis" (filename . "TagSeqAnalysis/"))
           ;; ("TagSeq" (filename . "TagSeq/"))
           ;; ("SeqStore" (filename . "SeqStore/"))
           ;; ("SeqTools" (filename . "seqtools/"))
           ;; ("biosignals" (filename . "biosignals/"))
           ;; ("GenomicCache" (filename . "GenomicCache/"))
           ;; ("ARE.utils" (filename . "ARE.utils/"))
           ;; ("data.table" (filename . "data.table/"))
           ;; ("shikken" (filename . "shikken/"))
           ;; ("buckshot" (filename . "buckshot/"))

           ;; ("ESS-help" (buffer-name . "help[R]"))
           ("Programming" ;; prog stuff not already in MyProjectX
            (or
             (mode . c-mode)
             (mode . perl-mode)
             (mode . python-mode)
             (mode . emacs-lisp-mode)
             ))
           ))))

(add-hook 'ibuffer-mode-hook
  (lambda ()
    (ibuffer-auto-mode 1)
    (ibuffer-switch-to-saved-filter-groups "default")))

;; Ensure ibuffer opens with point at the current buffer's entry.
;; http://stackoverflow.com/questions/3417438
(defadvice ibuffer
  (around ibuffer-point-to-most-recent) ()
  "Open ibuffer with cursor pointed to most recent buffer name."
  (let ((recent-buffer-name (buffer-name)))
    ad-do-it
    (ibuffer-jump-to-buffer recent-buffer-name)))
(ad-activate 'ibuffer)

;; (provide 'my-ibuffer)
