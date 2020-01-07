;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

;; (toggle-frame-maximized)

(setq
 avy-all-windows t ; `gs ' works across windows
 default-directory "~/Code"
 display-line-numbers-type 'visual
 doom-font (font-spec :family "FuraCode Nerd Font" :size 14)
 doom-theme 'doom-gruvbox
 projectile-project-search-path '("~/Code/kid" "~/Code/kid/kidiTrade"))

(use-package! groovy-mode
  :config
  (add-to-list 'auto-mode-alist '("Jenkinsfile\\.w+" . groovy-mode)))

(when (not window-system)
  (xterm-mouse-mode 1))

;; TODO try to remap `g t` and `g T` to switch tabs, and `C-TAB' to switch workspace?
(after! centaur-tabs
  (centaur-tabs-headline-match)
  (centaur-tabs-group-by-projectile-project)
  ;; Don't limit tab cycling to visible tabs only
  (setq centaur-tabs-cycle-scope 'tabs))

(use-package! magithub
  :after magit
  :config
  (magithub-feature-autoinject t)
  (setq magithub-clone-default-directory "~/Code/kid"))

(use-package! kubernetes
  :commands (kubernetes-overview))
(use-package! kubernetes-evil
  :after kubernetes)

(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))

;; TODO check if rust-analyzser is present on the system before setting this
(setq rustic-lsp-server 'rust-analyzer)

(use-package! smart-semicolon)
(add-hook! '(rustic-mode-hook js2-mode-hook) #'smart-semicolon-mode)
;; (add-hook 'rustic-mode-hook #'lsp-ui-doc-mode)
;; (add-hook 'rustic-mode-hook #'lsp-ui-doc-frame-mode)

(setq lsp-ui-doc-delay 0.5)

;; Disable signature popup while typing, but only in rust
(setq-hook! 'rustic-mode-hook lsp-signature-auto-activate nil)

(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time

(map! :leader "j w" #'evil-avy-goto-word-0)

;; don't split word on _
;; https://evil.readthedocs.io/en/latest/faq.html#underscore-is-not-a-word-character
;; (modify-syntax-entry ?_ "w")

;; Replace word motions with symbols
(after! evil
  (defalias 'forward-evil-word 'forward-evil-symbol))

;; (global-whitespace-newline-mode t)
(add-hook 'prog-mode-hook 'whitespace-newline-mode)

;; LSP-Mode performance optimizations
(setq lsp-prefer-capf t
      read-process-output-max (* 1024 1024))

(after! lsp-mode
  (add-to-list 'lsp-file-watch-ignored "[/\\\\]\\.terraform$")
  (add-to-list 'lsp-file-watch-ignored "[/\\\\]\\.results$"))

(load! "~/.doom.d/private.el" nil t)
