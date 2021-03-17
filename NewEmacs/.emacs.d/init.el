;; Install Use-Package
;; Package Manager


;;================================================================================================================
;; Package Management
;;================================================================================================================

;; Package repositories
(setq package-archives '(
			   ("org" . "https://orgmode.org/elpa/")
			   ("gnu" . "https://elpa.gnu.org/packages/")
			   ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

;; use-package to simplify the config file
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

;;================================================================================================================
;; VISUALS
;;================================================================================================================


;; Startup settings (no startup screen or messages, start in full-screen and remove all bars)
(setq
 inhibit-startup-message t
 inhibit-startup-screen t)
;; (add-to-list 'default-frame-alist '(fullscreen . fullboth)) 
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;; colorscheme
(require 'gruvbox-theme)
(load-theme 'gruvbox t)

;; line numbers
(global-linum-mode 1)

;;cursor
(blink-cursor-mode 1)
(setq cursor-type "box")

;; Highlight current line
(global-hl-line-mode 1)

;; Display time in modeline
(setq format-time-format "%H:%M")
(display-time-mode 1)

;; Display bettery life
(display-battery-mode 1)

;; Fancy modeline
(use-package doom-modeline
  :ensure t
  :config
  (doom-modeline-mode 1))

;;================================================================================================================
;; Maneuvering
;;================================================================================================================

;; set C-x p to previous buffer
(global-set-key (kbd "C-x p") (lambda ()
				(interactive)
				(other-window -1)
				))
			      

(define-key global-map (kbd "C-x ]")
  '(lambda () (interactive) (buf-move-right)))

(define-key global-map (kbd "C-x [")
  '(lambda () (interactive) (buf-move-left)))

(define-key global-map (kbd "C-x {")
  '(lambda () (interactive) (buf-move-up)))

(define-key global-map (kbd "C-x }")
  '(lambda () (interactive) (buf-move-down)))

;;================================================================================================================
;; Editing
;;================================================================================================================

;; Multiple line cursor editing command
(global-set-key (kbd "C-c C-m C-c") 'mc/edit-lines)

;; Binds 'git status' to C-c m
(define-key global-map (kbd "C-c m") 'magit-status)
(advice-add
 #'magit-key-mode-popup-committing :after
 (lambda ()
   (magit-key-mode-toggle-option
    (quote committing)
    "--no-verify")))

;; the more common magit git status shortcut mapping
(define-key global-map (kbd "C-c m") 'magit-status)

;;================================================================================================================
;; Clipboard
;;================================================================================================================

(setq x-select-enable-clipboard t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

;;================================================================================================================
;; Autocomplete
;;================================================================================================================
(use-package helm
 :ensure t
 :config
   (require 'helm-config)
 :init (helm-mode 1)
 :bind (("M-x"     . helm-M-x)
        ("C-x C-f" . helm-find-files)
        ("C-x b"   . helm-mini)
        ("C-x r b" . helm-filtered-bookmarks)
        ("C-x C-r" . helm-recentf)
        ("C-c i"   . helm-imenu)
        ("C-h a"   . helm-apropos)
        ("M-y"     . helm-show-kill-ring)
        :map helm-map
        ("C-z" . helm-select-action)
        ("<tab>" . helm-execute-persistent-action)))


;;================================================================================================================
;; Programming Specific Environment Management
;;================================================================================================================

;;(require 'haskell-interactive-mode)
;;(require 'haskell-process)
;; (add-hook 'haskell-mode-hook 'interactive-haskell-mode)
(add-hook 'haskell-mode-hook
	  (lambda ()
	    (interactive)
	    (interactive-haskell-mode)
	    (define-key interactive-haskell-mode-map (kbd "C-c C-l") nil)
	    (define-key haskell-mode-map (kbd "C-c C-l") nil)))


;; Emacs Speaks Statistics (ESS)
(use-package ess
    :ensure t
    :config
    (setq ess-use-company t))

;; Magit
(use-package magit
    :ensure t
    :config
        (global-set-key (kbd "C-x g") 'magit-status))

;;automatically get the correct mode
auto-mode-alist (append (list '("\\.c$" . c-mode)
			      '("\\.tex$" . latex-mode)
			      '("\\.S$" . S-mode)
			      '("\\.s$" . S-mode)
			      '("\\.R$" . R-mode)
			      '("\\.r$" . R-mode)
			      '("\\.html$" . html-mode)
                              '("\\.emacs" . emacs-lisp-mode)
	                )
		      auto-mode-alist)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("a37d20710ab581792b7c9f8a075fcbb775d4ffa6c8bce9137c84951b1b453016" "7661b762556018a44a29477b84757994d8386d6edee909409fabe0631952dad9" "d14f3df28603e9517eb8fb7518b662d653b25b26e83bd8e129acea042b774298" "2681c80b05b9b972e1c5e4d091efb9ba7bb5fa7dad810d9026bc79607a78f1c0" default)))
 '(package-selected-packages
   (quote
    (suscolors-theme paredit yaml-mode multiple-cursors magit jsonl json-mode interaction-log helm haskell-mode gruvbox-theme f ess direx dired-subtree company command-log-mode buffer-move))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
