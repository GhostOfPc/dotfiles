;;
;; NofarahTech gnuEmacs configuration
;;
;; UI tweaks and customization
;; No menu bar
(menu-bar-mode -1)

;; No tools bar
(tool-bar-mode -1)

;; No scroll bar
(defun nt/disable-scroll-bars (frame)
  (modify-frame-parameters frame
                           '((vertical-scroll-bars . nil)
                             (horizontal-scroll-bars . nil))))
(add-hook 'after-make-frame-functions 'nt/disable-scroll-bars)

;; No tab bar
(defun nt/disable-tab-bar (frame)
  (modify-frame-parameters frame
                           '((tab-bar-mode . nil))))
(add-hook 'after-make-frame-functions 'nt/disable-tab-bar)

;;disable splash screen and startup message
(setq inhibit-startup-message t) 
(setq initial-scratch-message nil)


;; Installing packages from melpa
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))


;; Use packages
(require 'use-package)
(require 'key-chord)
(key-chord-mode 1)


;; Setup the Evil mode, (Vi emulation mode)
;; Vertical splitted window to the right of the current one
(setq evil-vsplit-window-right t)

;;Exit insert mode by pressing i and then i quickly (instead of using Esc)
(setq key-chord-two-keys-delay 0.5)
(key-chord-define evil-insert-state-map "ii" 'evil-normal-state)
(key-chord-mode 1)

;; Enabling the mode
(require 'evil)
(evil-mode 1)


;; Ivy mode (auto-completion in mini-buffer)
(ivy-mode 1)


;; Enable the fancy doom themes
(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-material-dark t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))


;; doom mode line 
(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode))
(setq doom-modeline-height 18)

(require 'display-line-numbers)

;; Set default font
(set-face-attribute 'default nil :font "FantasqueSansMono Nerd Font" :height 141 )
(setq default-frame-alist '((font . "FantasqueSansMono Nerd Font" )
			    (height . 141 )))

(defcustom display-line-numbers-exempt-modes
  '(vterm-mode eshell-mode shell-mode term-mode ansi-term-mode)
  "Major modes on which to disable line numbers."
  :group 'display-line-numbers
  :type 'list
  :version "green")

;; Line numbers for specific modes
(defun display-line-numbers--turn-on ()
  "Turn on line numbers except for certain major modes.
Exempt major modes are defined in `display-line-numbers-exempt-modes'."
  (unless (or (minibufferp)
              (member major-mode display-line-numbers-exempt-modes))
    (display-line-numbers-mode)))

(global-display-line-numbers-mode)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(doom-modeline-height 10)
 '(electric-pair-mode t)
 '(package-selected-packages
   '(key-chord magit org-bullets smartparens yaml-mode lua-mode use-package evil doom-themes doom-modeline counsel)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-comment-face ((t (:slant italic)))))


;; This snippet eanbles lua-mode
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))

;;(setq electric-pair-mode t)

(require 'smartparens-config)


;; Org mode configuration
(use-package org
  :config
  (setq org-ellipsis ""
	org-hide-emphasis-markers t))

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("⦿" "⦾" "⊙" "" "⦿" "⦾" "⊙" )))

(dolist (face '((org-level-1 . 1.2)
		(org-level-2 . 1.1)
		(org-level-3 . 1.05)
		(org-level-4 . 1.0)))
  (set-face-attribute (car face) nil :font "Inter" :weight 'regular :height (cdr face)))
