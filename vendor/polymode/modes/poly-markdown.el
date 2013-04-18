(require 'polymode)

(defcustom pm-config/markdown
  (pm-config-multi-auto "markdown"
                        :base-submode-name 'pm-base/markdown
                        :auto-submode-name 'pm-submode/markdown)
  "Markdown typical configuration"
  :group 'polymode
  :type 'object)

(defcustom  pm-submode/markdown
  (pm-inner-submode-auto "markdown"
                         :head-reg "^[ \t]*```[{ \t]*\\w.*$"
                         :tail-reg "^[ \t]*```[ \t]*$"
                         :retriever-regexp "```[ \t]*{?\\(\\w+\\)"
                         :font-lock-narrow t)
  "Noweb typical chunk."
  :group 'polymode
  :type 'object)

(define-polymode poly-markdown-mode pm-config/markdown)
(add-to-list 'auto-mode-alist '("\\.md" . poly-markdown-mode))

(provide 'poly-markdown)

