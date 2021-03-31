;;================================================================================================================
;; Package Management
;;================================================================================================================
;; this is required for a current bug in emacs 26.2 on my OS, I need to upgrade emacs (but can't without also upgrading my os.. todo)
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

(require 'package)

;; Package repositories
(setq package-archives '(
 			   ("org" . "https://orgmode.org/elpa/")
			   ("gnu" . "https://elpa.gnu.org/packages/")
			   ("melpa" . "https://melpa.org/packages/")
			)
)


; To set package archives individually sequentially:
;; (add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/"))
;; (add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))
;; (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

;; use-package to simplify the config file
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))



;;================================================================================================================
;; VISUALS
;;================================================================================================================


;; auto dim / dimmer
(use-package auto-dim-other-buffers
  :ensure t
  :diminish auto-dim-other-buffers-mode
  :init (auto-dim-other-buffers-mode t)
  :config
  (set-face-attribute 'auto-dim-other-buffers-face nil
                      :background "#333333"))

;; start in emacs dashboard (better than scratch)
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))
(setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))

;; ToDo: put this in it's own file and load
;; Insert Project list (from https://github.com/gonsie/dotfiles/blob/master/emacs/my-dashboard-extras.el)
(defun dashboard-insert-project-list (list-display-name list)
  "Render LIST-DISPLAY-NAME title and items of LIST."
  (when (car list)
    (dashboard-insert-heading list-display-name)
    (mapc (lambda (el)
            (setq el (concat "~/repos/" (car el)))
            (insert "\n    ")
            (widget-create 'push-button
                           :action `(lambda (&rest ignore) (find-file-existing ,el))
                           :mouse-face 'highlight
                           :follow-link "\C-m"
                           :button-prefix ""
                           :button-suffix ""
                           :format "%[%t%]"
                           (abbreviate-file-name el)))
          list)))

(defun dashboard-insert-projects (list-size)
  "Add the list of LIST-SIZE items from recently accessed projects."
  (let (proj-list)
    (dolist (dirl (directory-files-and-attributes "~/repos" nil "^[^.]+.*"))
      (setq proj-list (append proj-list (list (cons (car dirl)
                                              (format-time-string "%s" (file-attribute-access-time (cdr dirl))))))))
    (setq proj-list (sort proj-list (lambda (a b) (string> (cdr a) (cdr b)))))
    (when (dashboard-insert-project-list
	   "Recent Projects:"
	   (dashboard-subseq proj-list 0 list-size))
      (dashboard-insert-shortcut "p" "Recent Projects:"))))
(dashboard-insert-shortcut "f" "Recent Files")
(dashboard-insert-shortcut "b" "Bookmarks")

(setq dashboard-show-shortcuts nil)
(setq dashboard-set-heading-icons t)
(setq dashboard-set-file-icons t)
(setq dashboard-set-navigator t)
(setq dashboard-set-footer nil)
;(add-to-list 'dashboard-item-generators  '(projects . dashboard-insert-projects))
;(add-to-list 'dashboard-items '(projects . 5) t)
(setq dashboard-items '((recents  . 5)
			(projects . 5)
                        (bookmarks . 5)))

;(setq
; inhibit-startup-message t
; inhibit-startup-screen t)
; When launching a new 'emacs' session default to full screen (not always desired)
;(add-to-list 'default-frame-alist '(fullscreen . fullboth))
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
(setq-default cursor-type 'bar)

;; Highlight current line
(global-hl-line-mode 1)

;; Display time in modeline
(setq format-time-format "%H:%M")
(display-time-mode 1)

;; Display bettery life
(display-battery-mode 1)

;; Fancy modeline ;doom is pretty good but I like the below a bit better
;(require 'doom-modeline)
;(doom-modeline-mode 1)
					;(setq doom-modeline-project-detection 'project)
;(setq doom-modeline-vcs-max-length 40) ; who hasn't run into longer branch names...



;;Todo: Put this in its own file and load
;; taken from https://github.com/gonsie/dotfiles/blob/master/emacs/theme.el who keeps in separate file then loads into init.el
(setq-default mode-line-format
              (list
               ;; day and time
               '(:eval (propertize (format-time-string " %b %d %H:%M ")
                                   'face 'font-lock-builtin-face))


               '(:eval (propertize (substring vc-mode 5)
                                   'face 'font-lock-comment-face))

               ;; the buffer name; the file name as a tool tip
               '(:eval (propertize " %b "
                                   'face
                                   (let ((face (buffer-modified-p)))
                                     (if face 'font-lock-warning-face
                                       'font-lock-type-face))
                                   'help-echo (buffer-file-name)))

               ;; line and column
               " (" ;; '%02' to set to 2 chars at least; prevents flickering
               (propertize "%02l" 'face 'font-lock-keyword-face) ","
               (propertize "%02c" 'face 'font-lock-keyword-face)
               ") "

               ;; relative position, size of file
               " ["
               (propertize "%p" 'face 'font-lock-constant-face) ;; % above top
               "/"
               (propertize "%I" 'face 'font-lock-constant-face) ;; size
               "] "

               ;; spaces to align right
               '(:eval (propertize
                " " 'display
                `((space :align-to (- (+ right right-fringe right-margin)
                                      ,(+ (+ 3 (string-width mode-name)))
                                      )))))

;               (propertize org-mode-line-string 'face '(:foreground "#5DD8FF")) ; this is broken on undefined org-mode-line-string
;	       (propertize 'face '(:foreground "#5DD8FF"))

               ;; the current major mode
               (propertize " %m " 'face 'font-lock-string-face)
               ;;minor-mode-alist
               ))

(set-face-attribute 'mode-line nil
                    :background "#402278"
                    :foreground "white"
                    :box '(:line-width 8 :color "#353644")
                    :overline nil
                    :underline nil)

(set-face-attribute 'mode-line-inactive nil
                    :background "#565063"
                    :foreground "white"
                    :box '(:line-width 8 :color "#565063")
                    :overline nil
                    :underline nil)



;; for having icons in the dired side-bar
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)

;; dired sidebar (with icons)
(use-package dired-sidebar
  :bind (("C-x C-n" . dired-sidebar-toggle-sidebar))
  :ensure t
  :commands (dired-sidebar-toggle-sidebar)
  :init
  (add-hook 'dired-sidebar-mode-hook
            (lambda ()
              (unless (file-remote-p default-directory)
                (auto-revert-mode))))
  :config
  (push 'toggle-window-split dired-sidebar-toggle-hidden-commands)
  (push 'rotate-windows dired-sidebar-toggle-hidden-commands)

  (setq dired-sidebar-subtree-line-prefix "__")
  (setq dired-sidebar-theme 'vscode)
  (setq dired-sidebar-use-term-integration t)
  (setq dired-sidebar-use-custom-font t))

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

;; way better window switching than multiple C-x o , just start with that then move relative with ijkl'
(require 'win-switch)
(win-switch-setup-keys-ijkl "\C-xo")
(setq win-switch-feedback-background-color "#FFFFFF")



;;================================================================================================================
;; Editing
;;================================================================================================================

;; auto insert matching delimeters
(electric-pair-mode)

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

(menu-bar-mode -1)
(tool-bar-mode -1)

(global-set-key (kbd "C-c C-m C-c") 'mc/edit-lines)

;;================================================================================================================
;; Autocomplete and searching
;;================================================================================================================
(use-package helm
:ensure t
 :config
   (require 'helm-config)
 :init (helm-mode 1)
 ; enable helm to autocomplete in various emacs buffers/places (mini buffer, dir selection, meta (M-x) autocomplete etc)
 :bind (("M-x"     . helm-M-x)
        ("C-x C-f" . helm-find-files)
        ("C-x b"   . helm-mini)
        ("C-x r b" . helm-filtered-bookmarks)
        ("C-x C-r" . helm-recentf)
        ("C-c i"   . helm-imenu)
        ("C-h a"   . helm-apropos)
        ("M-y"     . helm-show-kill-ring)
        :map helm-map
	("<tab>" . helm-execute-persistent-action) ; this doesn't work right in any 'termina' window ie the  emacsclient -t windows... ?
        ("C-i" . 'helm-execute-persistent-action) ; this makes tab autocomplete work as expected in the terminal windows
	("C-z" . helm-select-action)
	))

;; Better searching (C-s now uses a minibuffer to show lines/ possible matches to jump to)
(use-package counsel
  :ensure t)

(use-package ivy :demand
      :config
      (setq ivy-use-virtual-buffers t
            ivy-count-format "%d/%d "))

(use-package counsel
  :ensure t
  :diminish ivy-mode
;;  )

;; ;; swiper pop-up search
;; (use-package swiper
;;   :ensure t
;;   :diminish ivy-mode
  :bind (("C-s" . swiper)
	 ("C-c C-r" . ivy-resume))
  :init
  (ivy-mode 1)
  (counsel-mode 1)
  :config
  (setq ivy-use-virutal-buffers t)
  (setq enable-recursive-minibuffers t)
  (setq ivy-display-style 'fancy)
  (setq ivy-count-format "(%d/%d) "))

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
	    (define-key interactive-haskell-mode-map (kbd "C-c C-l") nil) ; I have a bad habit of doing this for R files and this really messes things up in haskell so set it to no op nil
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

;; interact with github via/within magit ie pull requests, stats, etc
(use-package forge
  :after magit
  :ensure t)

;;automatically get the correct mode
auto-mode-alist (append (list '("\\.c$" . c-mode)                 ; c files
			      '("\\.tex$" . latex-mode)           ; latex files
			      '("\\.S$" . S-mode)                 ; source code files
			      '("\\.s$" . S-mode)                 ; source code files
			      '("\\.R$" . R-mode)                 ; R files
			      '("\\.r$" . R-mode)                 ; R files
			      '("\\.html$" . html-mode)           ; html files 
                              '("\\.emacs" . emacs-lisp-mode)     ; emacs lisp files
			      '("\\.csv\\" . csv-mode)            ; csv files
			      '("\\.json\\" . json-mode)          ; json files
	                )
		      auto-mode-alist)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (projectile all-the-icons-dired dired-sidebar win-switch doom-modeline gnu-elpa-keyring-update paredit yaml-mode multiple-cursors magit jsonl json-mode interaction-log helm haskell-mode gruvbox-theme f ess direx dired-subtree company command-log-mode buffer-move))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
