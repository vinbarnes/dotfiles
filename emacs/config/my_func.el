(defun kb-quit-emacs ()
  (interactive)
  (when (y-or-n-p "Really? ")
    (save-buffers-kill-terminal)))

(defun kb-open-init ()
  "open Emacs init.el"
  (interactive)
  (find-file "~/.emacs.d/init.el")
  )

(defun kb-open-soggies ()
  (interactive)
  (znc-erc "websages")
  (sleep-for 3)
  (switch-to-buffer "#soggies")
)

(defun kb-close-soggies ()
  (interactive)
  (let 'kill-buffer-query-functions
    (kill-buffer "*irc-websages*")
    (kill-buffer "#soggies")
    (kill-buffer "#spoilers")
    )
)

(defun kb-open-aws ()
  "open AWS url for production ABC account"
  (interactive)
  (browse-url-default-macosx-browser "https://fedsvc.advisory.com/adfs/ls/IdpInitiatedSignOn.aspx"))
(global-set-key (kbd "C-c m o") 'kb-open-aws)

(defun kb-open-rails-app-in-browser ()
  (interactive)
  (browse-url-default-macosx-browser "http://localhost:3000"))
(global-set-key (kbd "C-c r ! !") 'kb-open-rails-app-in-browser)
