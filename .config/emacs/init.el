(menu-bar-mode -1)
(tool-bar-mode -1)
(column-number-mode t)
;; Hightlight the current line
(global-hl-line-mode t)
;; Disable the line highlighting and cursor blinking in dashboard mode
(add-hook 'dashboard-mode-hook (lambda () (setq-local global-hl-line-mode nil)
				 (setq-local blink-cursor-mode nil)))
;; Remove scroll bars and tab bar in all windows and frames
(scroll-bar-mode -1)
(defun nt/clean_ui (frame)
  (modify-frame-parameters frame
			   '((vertical-scroll-bars . nil)
			     (horizontal-scroll-bars . nil)
			     (tab-bar-show . nil))))
(add-hook 'after-make-frame-functions 'nt/clean_ui)

(setq inhibit-startup-message t) 
(setq initial-scratch-message nil)

(visual-line-mode t)
(global-visual-line-mode)

(defcustom display-line-numbers-exempt-modes
  '(org-mode vterm-mode eshell-mode shell-mode term-mode ansi-term-mode dashboard-mode)
  "Major modes on which to disable line numbers."
  :group 'display-line-numbers
  :type 'list
  :version "green")

(global-display-line-numbers-mode t)
;; Line numbers for specific modes
(defun display-line-numbers--turn-on ()
  "Turn on line numbers except for certain major modes.
Exempt major modes are defined in `display-line-numbers-exempt-modes'."
  (unless (or (minibufferp)
	      (member major-mode display-line-numbers-exempt-modes))
    (display-line-numbers-mode)
  (setq display-line-numbers-type 'relative)
))

(defun nt/toggle-transparency ()
  (interactive)
  (let ((alpha (frame-parameter nil 'alpha)))
    (set-frame-parameter
     nil 'alpha
     (if (eql (cond ((numberp alpha) alpha)
		    ((numberp (cdr alpha)) (cdr alpha))
		    ;; Also handle undocumented (<active> <inactive>) form.
		    ((numberp (cadr alpha)) (cadr alpha)))
	      100)
	 '(95 . 50) '(100 . 100)))))
(global-set-key (kbd "C-c t") 'nt/toggle-transparency)

(defun tangle-on-save-org-mode-file()
  (when (string= (message "%s" major-mode) "org-mode")
    (org-babel-tangle)))
(add-hook 'after-save-hook 'tangle-on-save-org-mode-file)

(recentf-mode 1)
(global-set-key (kbd "C-c C-r") 'recentf-open-files)

(setq history-length 25)
(savehist-mode 1)

(save-place-mode 1)

(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'nomessage)

(setq use-dialog-box nil)

(global-auto-revert-mode 1)

(setq scroll-conservatively 101)

(defalias 'yes-or-no-p 'y-or-n-p)

(global-set-key (kbd "<escape>")      'keyboard-escape-quit)

;; Installing packages from melpa
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/")
	     '("elpa" . "https://elpa.gnu.org/packages/"))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(add-to-list 'load-path "~/.config/emacs/lisp")

(require 'use-package)
;; This snippet ommits the need to set (:ensure t) each time we add a new package
  (setq use-package-always-ensure t)

(use-package dashboard
  :config
  (dashboard-setup-startup-hook)
  (setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))
  (setq dashboard-banner-logo-title "I use Emacs, which might be thought of as a thermonuclear word processor!!!")
  (setq dashboard-startup-banner 'logo)
  (setq dashboard-set-navigator t)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-items '((recents  . 15)
			  (bookmarks . 5)
			  (projects . 5)
			  (agenda . 5)))
  (setq dashboard-set-file-icons t))

(use-package dired
  :ensure nil
  :commands (dired dired-jump)
  :bind (("C-x C-j" . dired-jump))
  :custom ((dired-listing-switches "-agho --group-directories-first"))
  :config
  (evil-collection-define-key 'normal 'dired-mode-map
    "h" 'dired-single-up-directory
    "l" 'dired-single-buffer))

(use-package dired-single
  :commands (dired dired-jump))

(use-package projectile
  :config
  (projectile-mode t))

;; A better *help* buffer
(use-package helpful
  :commands (helpful-callable helpful-variable helpful-key)
  :bind
  ("C-h f" . helpful-callable)
  ("C-h v" . helpful-variable)
  ("C-h k" . helpful-key)
  )

(use-package vterm)

(use-package yaml-mode)

(use-package markdown-mode)

(use-package vimrc-mode)

;; This snippet eanbles lua-mode
(use-package lua-mode)
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))

;; Icons in the modeline
(use-package all-the-icons)
;; Icons in the dired buffer
(use-package all-the-icons-dired)
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)

;; Enable the fancy doom themes
(use-package doom-themes
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
	doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-one t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-comment-face ((t (:slant italic)))))

;; doom mode line 
(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode)
  :custom (doom-modeline-height 14))

;; Set default font
(defun nt/set-font-faces()
  (set-face-attribute 'default nil :font "FantasqueSansMono Nerd Font" :height 151)
  (set-face-attribute 'fixed-pitch nil :font "FantasqueSansMono Nerd Font" :height 151)
  (set-face-attribute 'variable-pitch nil :font "Open Sans" :height 151))
(if (daemonp)
    (add-hook 'after-make-frame-functions
	      (lambda (frame)
		(with-selected-frame frame
		  (nt/set-font-faces))))
  (nt/set-font-faces))

;; Set the default spacing between lines to not make them stuck to each other
(setq-default line-spacing 8)

(use-package mixed-pitch
  :hook
  (org-mode . mixed-pitch-mode)
  (markdown-mode . mixed-pitch-mode))

(use-package smartparens
  :config (smartparens-global-mode 1))

(use-package rainbow-delimiters
  :hook
  (emacs-lisp-mode . rainbow-delimiters-mode)
  (lua-mode . rainbow-delimiters-mode))

(use-package rainbow-mode
  :hook (org-mode
	 emacs-lisp-mode
	 lua-mode
	 conf-mode))

(use-package which-key
  :init (which-key-mode)
  :config
  (setq which-key-idle-delay 0.2))

(use-package command-log-mode)

(use-package ivy
  :init (ivy-mode)
  :bind (("C-s" . swiper)))

(use-package counsel
  :bind ("M-x" . counsel-M-x))

(use-package ivy-rich
  :init
  (setq ivy-rich-path-style 'abbrev)
  (ivy-rich-mode 1)
  )

(use-package ivy-posframe
  :init
  (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display)))
  (setq ivy-posframe-border-width 2)
  (setq ivy-posframe-parameters
      '((left-fringe . 16)
	(right-fringe . 16)))
  :config
  (ivy-posframe-mode 1))

(use-package company
  :init
  (global-company-mode)
  :bind ( :map company-active-map
   ("<tab>" . company-complete-selection))
  :config
  (setq company-backends '((company-files
		    company-capf
		    company-dabbrev
		    company-keywords)))
  :custom
  (company-minimum-prefix-length 1
  (company-idle-delay 0.0)))

(use-package key-chord
:after evil
:init
(setq key-chord-two-keys-delay 0.5)
:config
(key-chord-mode 1))

(use-package general
:config
(general-define-key :keymaps 'evil-insert-state-map (general-chord "ii") 'evil-normal-state)
(general-define-key :keymaps 'normal (general-chord "SB") 'ivy-switch-buffer)
(general-define-key :keymaps 'normal (general-chord "QB") 'kill-buffer)
(general-define-key :keymaps 'normal (general-chord "FF") 'find-file))

(use-package undo-tree
  :config (global-undo-tree-mode 1))

(use-package evil
  :init
  (setq evil-want-keybinding nil)
  (setq evil-want-integration t)
  (setq evil-undo-system 'undo-redo)
  :config
  (evil-mode 1)
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)
  (evil-global-set-key 'normal (kbd "/") 'swiper)

  ;; In the dashboard mode, the "r" key is binded to go directly to the recent files
  ;; which conflicts with evil mode replace binding
  (add-hook 'dashboard-mode-hook
	    (lambda ()
	      (evil-local-set-key 'normal (kbd "r") 'dashboard-jump-to-recents)
	      (evil-local-set-key 'normal (kbd "p") 'dashboard-jump-to-projects)))

  ;; Vertical splitted window to the right of the current one
  (setq evil-vsplit-window-right t)
  )

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

;; Display visual hints when editing with evil. i.e. highlight lines or words when copied or pasted.
(use-package evil-goggles
  :config 
  (evil-goggles-mode))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (lsp-enable-which-key-integration t)

;; lua
;; https://emacs-lsp.github.io/lsp-mode/page/lsp-lua-language-server/
(setq lsp-clients-lua-language-server-install-dir (f-join (getenv "HOME") ".local/share/lua-language-server/"); Default: ~/.emacs.d/.cache/lsp/lua-language-server/
	lsp-clients-lua-language-server-bin (f-join lsp-clients-lua-language-server-install-dir "bin/lua-language-server")
	lsp-clients-lua-language-server-main-location (f-join lsp-clients-lua-language-server-install-dir "main.lua")
	lsp-lua-workspace-max-preload 2048 ; Default: 300, Max preloaded files
	lsp-lua-workspace-preload-file-size 1024; Default: 100, Skip files larger than this value (KB) when preloading.
	)
  :hook (lua-mode . lsp-deferred))

(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
                          (require 'lsp-pyright)
                          (lsp-deferred))))  ; or lsp-deferred

(defun nt/org-mode-setup()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (auto-fill-mode 1)
  (visual-line-mode 1)
  (setq evil-auto-indent nil))

(use-package org
  :config
  (setq org-ellipsis " ⯆"
	org-hide-emphasis-markers t))

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("⦿" "⊙" "⦾" "⊚" "⊙" "⦾" )))

;; Replace list hyphen with dot
;;(font-lock-add-keywords 'org-mode
;;                        '(("^ *\\([-]\\) "
;;                            (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

(dolist (face '((org-level-1 . 1.3)
		(org-level-2 . 1.1)
		(org-level-3 . 1.05)
		(org-level-4 . 1.0)))
  (set-face-attribute (car face) nil :font "Open Sans" :weight 'regular :height (cdr face)))

(defun nt/org-mode-visual-fill ()
  (setq visual-fill-column-width 150
	visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :defer t
  :hook (org-mode . nt/org-mode-visual-fill)
	(dashboard-mode . nt/org-mode-visual-fill))

;; Make sure org-indent face is available
(require 'org-indent)

(require 'org-tempo)
(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
(add-to-list 'org-structure-template-alist '("lu" . "src lua"))
(add-to-list 'org-structure-template-alist '("sh" . "src shell"))

(use-package toc-org
:hook (org-mode . toc-org-mode)
      (markdown-mode . toc-org-mode))

(use-package vterm
  :commands vterm
  :config
  (setq term-prompt-regexp "^[^#$%>\\n]*[#$%>] *"))
