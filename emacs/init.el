;; some of this is cribbed from Yegge
;; https://sites.google.com/site/steveyegge2/effective-emacs
(server-start)

(require 'cl)

(add-to-list 'load-path "~/.emacs.d/config")
(load "my_func.el")

;; hide toolbar
(if (fboundp tool-bar-mode) (tool-bar-mode -1))
(if (fboundp menu-bar-mode) (menu-bar-mode -1))

;; standard shit
(setq-default indent-tabs-mode nil)
(column-number-mode t)

;; some stuff for rails devs
;; https://github.com/pjammer/emacs_for_rails_devs

(setq backup-directory-alist (quote ((".*" . "~/.emacs.d/bak"))))
(setq make-backup-files nil) ;; disable backup files
(setq auto-save-default nil) ; turns off that blasted auto-save shit
(global-linum-mode t) ;; line numbers on the side.
(delete-selection-mode t) ;; highlight a word and start typing, and it will delete the word and put your typed characters in it's place. highly annoying if not there.
(electric-pair-mode t) ;; matching (), "", []
(hl-line-mode t) ; turn on highlight line mode
(setq inhibit-startup-message t) ;; meh, not needed on your 300+ day of using
(fset 'yes-or-no-p 'y-or-n-p) ;; uses y instead of yes. less typing
(setq show-trailing-whitespace t)
(add-hook 'before-save-hook 'delete-trailing-whitespace) ;; deletes all whitespace that isn't needed.

;; some ruby-mode stuff
(defun ruby-load-buffer-and-go ()
  "Load the Ruby file in the current buffer.
Then switch to the process buffer."
  (interactive)
  (comint-check-source buffer-file-name)
  (ruby-load-file buffer-file-name)
  (ruby-switch-to-inf t))

(defun ruby-insert-debug-stmt ()
  "Inserts debug statement at point."
  (interactive)
  (newline)
  (insert "binding.pry")
  (enh-ruby-indent-line t)
  (newline)
  (newline))

(add-hook 'enh-ruby-mode-hook
     (lambda ()
       ;; hitting enter will indent.
       (local-set-key (kbd "RET") 'reindent-then-newline-and-indent)
       (local-set-key (kbd "C-c C-g") 'ruby-load-buffer-and-go)
       (local-set-key (kbd "C-c C-d") 'ruby-insert-debug-stmt)))

(defun prev-window ()
  "Select previous window in cyclic ordering of windows."
  (interactive)
  (other-window 1))

;;
;; global keys
;;

;; warn before quitting
(global-unset-key (kbd "C-x C-c"))
(global-set-key (kbd "C-x C-c") 'kb-quit-emacs)

;; replace Alt-X
(global-set-key (kbd "C-x C-m") 'execute-extended-command)
(global-set-key (kbd "C-c C-m") 'execute-extended-command)
(global-unset-key (kbd "M-x"))

;; backward kill character and remap help
(global-set-key (kbd "C-h") 'backward-delete-char)
(global-set-key (kbd "<f1>") 'help)

;; revert-buffer should be accessible/universal
(global-set-key (kbd "<f5>") 'revert-buffer)

;; backward kill word
(global-set-key (kbd "C-w") 'backward-kill-word)
(global-set-key (kbd "C-x C-k") 'kill-region)
(global-set-key (kbd "C-c C-k") 'kill-region)

;; get back macro registers
(global-set-key (kbd "C-x C-a") 'kmacro-bind-to-key)

;; top/end of buffer
(global-unset-key (kbd "C-x t"))
(global-set-key (kbd "C-x t") 'beginning-of-buffer)
(global-set-key (kbd "C-x e") 'end-of-buffer)

;; previous window
(global-unset-key (kbd "C-x p"))
(global-set-key (kbd "C-x p") 'prev-window)

;; ibuffer
(require 'ibuffer)
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; magit
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-S-m") 'magit-status)
(global-unset-key (kbd "C-x m")) ;; seem to accidentally type this a lot
(defun kb-magit-log-head-against-upstream ()
  "Invoke 'magit-log' using current/HEAD against upstream."
  (interactive)
  (magit-log '("..origin/master")))

;; package management
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize)
(unless package-archive-contents (package-refresh-contents))

(autoload 'ansi-color "ansi-color" "trying to get colored logs for Rails" t)

;; turn off as it was causing an error during initialization
;; maybe need to install this manually?
(require 'znc)

;; Yasnippet config
;; --------------------
;; Develop and keep personal snippets under ~/emacs.d/mysnippets
;; (add-to-list 'load-path "~/.emacs.d/elpa/yasnippet-20131026.1440")
;; (require 'yasnippet)
;; (yas-global-mode t)
;; (setq yas/root-directory '("~/.emacs.d/snippets"
;;                          "~/.emacs.d/elpa/yasnippet-20140821.38/snippets"))
;; ;; Load the snippets
;; (mapc 'yas/load-directory yas/root-directory)

;; for statusbar https://github.com/jonathanchu/emacs-powerline/
;; (require 'powerline)

;; copying shell variables https://github.com/purcell/exec-path-from-shell
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; ag https://github.com/Wilfred/ag.el
(setq ag-highlight-search t)
(setq ag-reuse-buffers 't)
(global-set-key (kbd "C-S-a") 'ag)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(autotest-command "autotest")
 '(compilation-message-face (quote default))
 '(custom-enabled-themes (quote (sanityinc-tomorrow-night)))
 '(custom-safe-themes
   (quote
    ("e16a771a13a202ee6e276d06098bc77f008b73bbac4d526f160faa2d76c1dd0e" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "eacfc96fbe418c017f4a00fdde5d5029db8e2800a46251eb2174484fa431917e" "1278386c1d30fc24b4248ba69bc5b49d92981c3476de700a074697d777cb0752" "d7f1c86b425e148be505c689fc157d96323682c947b29ef00cf57b4e4e46e6c7" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" default)))
 '(dabbrev-abbrev-skip-leading-regexp ":")
 '(enable-recursive-minibuffers t)
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-tail-colors
   (quote
    (("#eee8d5" . 0)
     ("#B4C342" . 20)
     ("#69CABF" . 30)
     ("#69B7F0" . 50)
     ("#DEB542" . 60)
     ("#F2804F" . 70)
     ("#F771AC" . 85)
     ("#eee8d5" . 100))))
 '(ibuffer-saved-filter-groups nil)
 '(ibuffer-saved-filters
   (quote
    (("controllers"
      ((filename . "controllers")))
     ("gnus"
      ((or
        (mode . message-mode)
        (mode . mail-mode)
        (mode . gnus-group-mode)
        (mode . gnus-summary-mode)
        (mode . gnus-article-mode))))
     ("programming"
      ((or
        (mode . emacs-lisp-mode)
        (mode . cperl-mode)
        (mode . c-mode)
        (mode . java-mode)
        (mode . idl-mode)
        (mode . lisp-mode)))))))
 '(indent-tabs-mode nil)
 '(magit-diff-use-overlays nil)
 '(magit-fetch-arguments (quote ("--prune")))
 '(magit-use-overlays nil)
 '(proced-filter (quote ##))
 '(purpose-use-default-configuration nil)
 '(rspec-use-rake-when-possible nil)
 '(same-window-buffer-names nil)
 '(syslog-debug-face
   (quote
    ((t :background unspecified :foreground "#2aa198" :weight bold))))
 '(syslog-error-face
   (quote
    ((t :background unspecified :foreground "#dc322f" :weight bold))))
 '(syslog-hour-face (quote ((t :background unspecified :foreground "#859900"))))
 '(syslog-info-face
   (quote
    ((t :background unspecified :foreground "#268bd2" :weight bold))))
 '(syslog-ip-face (quote ((t :background unspecified :foreground "#b58900"))))
 '(syslog-su-face (quote ((t :background unspecified :foreground "#d33682"))))
 '(syslog-warn-face
   (quote
    ((t :background unspecified :foreground "#cb4b16" :weight bold))))
 '(tool-bar-mode nil)
 '(visible-bell t)
 '(weechat-color-list
   (quote
    (unspecified "#002b36" "#073642" "#990A1B" "#dc322f" "#546E00" "#859900" "#7B6000" "#b58900" "#00629D" "#268bd2" "#93115C" "#d33682" "#00736F" "#2aa198" "#839496" "#657b83")))
 '(xclip-mode t)
 '(xclip-use-pbcopy&paste t)
 '(znc-servers
   (quote
    (("znc.websages.com" 8080 t
      ((websages "<username>" "<password>")))))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(global-hl-line-mode 1)

(require 'helm)
(require 'helm-config)
(helm-mode 1)

(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)

;; helm imenu
(global-set-key (kbd "M-i") 'helm-imenu)

;; Ruby setup from https://gist.github.com/gnufied/7160799
(autoload 'enh-ruby-mode "enh-ruby-mode" "Major mode for ruby files" t)
(add-to-list 'auto-mode-alist '("\\.rb$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . enh-ruby-mode))

(projectile-rails-global-mode)

;; robe
;; (add-hook 'enh-ruby-mode-hook 'robe-mode)
;; (setq turn-on-eldoc-mode nil)
(add-hook 'ruby-mode-hook
          (lambda ()
            (local-unset-key (kbd "C-x t"))))

;; set up rbenv
(setenv "PATH" (concat (getenv "HOME") "/.rbenv/shims:" (getenv "HOME") "/.rbenv/bin:" (getenv "PATH")))
(setq exec-path (cons (concat (getenv "HOME") "/.rbenv/shims") (cons (concat (getenv "HOME") "/.rbenv/bin") exec-path)))

(require 'tramp)

;; convenience functions

(defun region-to-browser ()
     (interactive)
     (setq url (buffer-substring-no-properties (region-beginning) (region-end)))
     (shell-command (format "open -a Chromium '%s'" url))
)

(defun touch ()
     "updates mtime on the file for the current buffer"
     (interactive)
     (shell-command (concat "touch " (shell-quote-argument (buffer-file-name))))
     (clear-visited-file-modtime))

(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(put 'downcase-region 'disabled nil)

(add-hook 'coffee-mode-hook
          (lambda ()
            (setq-default indent-tabs-mode nil)
            (setq tab-width 2)))

(put 'upcase-region 'disabled nil)

(require 'pomodoro)
(pomodoro-add-to-mode-line)
(global-set-key (kbd "C-c m m") 'pomodoro-start)
(global-set-key (kbd "C-c m s") 'pomodoro-stop)
(global-set-key (kbd "C-c m p") 'pomodoro-pause)

(fset 'master-me
   "\C-s\C-[r^\\W+master\\W+\C-m\C-m")

(fset 'inception
   "\C-x3\C-xo\C-x2\C-[-\C-xo")
(execute-kbd-macro (read-kbd-macro "\C-x3\C-xo\C-x2\C-[-\C-xo")) ;; start me up

(defun message-current-date ()
  "print current time and date info as message to echo area"
  (interactive)
  (message (format-time-string "%H:%M - %a %b %d" (current-time))))
(global-set-key (kbd "C-c d") 'message-current-date)

(require 'server)
(unless (server-running-p)
  (server-start))

(load "multiple_cursors.el")
(put 'narrow-to-region 'disabled nil)

(defun play-codifi ()
  (interactive)
  (async-shell-command "osascript -e 'tell application \"iTunes\" to set shuffle enabled to true' && osascript -e 'tell application \"iTunes\" to play playlist \"CodiFi\"'")
)

;; window purpose
(purpose-mode)
