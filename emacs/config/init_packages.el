(eval-when-compile
  (require 'use-package))

(use-package helm
  :ensure t)

(use-package projectile
  :ensure t)

(use-package helm-projectile
  :ensure t)

(use-package projectile-rails
  :ensure t)

(use-package window-purpose
  :ensure t)

(use-package magit
  :ensure t)

(use-package exec-path-from-shell
  :ensure t)

(use-package znc
  :ensure t)

(use-package pomodoro
  :ensure t)

(use-package xclip
  :ensure t)

(use-package color-theme-sanityinc-tomorrow
  :ensure t
  :config
  (load-theme 'sanityinc-tomorrow-night t)
  (let ((line (face-attribute 'mode-line :underline)))
    (set-face-attribute 'mode-line          nil :overline   line)
    (set-face-attribute 'mode-line-inactive nil :overline   line)
    (set-face-attribute 'mode-line-inactive nil :underline  line)
    (set-face-attribute 'mode-line          nil :box        nil)
    (set-face-attribute 'mode-line-inactive nil :box        nil)))
    ;;(set-face-attribute 'mode-line-inactive nil :background "#f9f2d9")))

(use-package minions
  :ensure t
  :init (minions-mode))

(use-package moody
  :ensure t
  :config
  (setq x-underline-at-descent-line t)
  (setq moody-slant-function 'moody-slant-apple-rgb)
  (moody-replace-mode-line-buffer-identification)
  (moody-replace-vc-mode))
