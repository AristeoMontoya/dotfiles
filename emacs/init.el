; Buenas, esta es la configuración nueva desde cero.

; Sin la pantala de inicio
(setq inhibit-startup-message t)

(scroll-bar-mode -1) ; Sin scrollbar visible
(tool-bar-mode -1)   ; Sin toolbar
(tooltip-mode -1)    ; Sin tooltips
(set-fringe-mode 10) ; No sé ni que hace esto

(menu-bar-mode -1)   ; Adiós, barra de menú

; Cambiando la fuente, creo que el tamaño se puede cambiar aquí
; con :height
(set-face-attribute 'default nil :font "JetBrains Mono")

; Para poder cerrar los prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

; Para comenzar con los paquetes. Puede que esto ya cargue por defecto
(require 'package)

; Lugares de donde vamos a sacar los paquetes.
; Importante, se agrega con un punto, no con una coma
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
						 ("org" . "https://orgmode.org/elpa/")
						 ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

; Para cargar los paquetes fuera de Linux.
; Las funciones que terminan con -p pueden retornar nil
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

; Line numbers
(column-number-mode)
(global-display-line-numbers-mode t)

; Desactivar los números de línea en algunos buffer
(dolist (mode '(org-mode-hook
				term-mode-hook
				eshell-mode-hook))
  (add-hook mode (lambda() (display-line-numbers-mode 0))))

; Un paquete no sé para que
(use-package command-log-mode)

; Ivy como framework de completado
(use-package ivy
	:diminish
	:bind (("C-s" . swiper)
		   :map ivy-minibuffer-map
		   ("TAB" . ivy-alt-done)
		   ("C-l" . ivy-alt-done)
		   ("C-j" . ivy-next-line)
		   ("C-k" . ivy-previous-line)
		   :map ivy-switch-buffer-map
		   ("C-k" . ivy-previous-line)
		   ("C-l" . ivy-done)
		   ("C-d" . ivy-switch-buffer-kill)
		   :map ivy-reverse-i-search-map
		   ("C-k" . ivy-previous-line)
		   ("C-d" . ivy-reverse-i-search-kill))
	:config
	(ivy-mode 1))

; Íconos bonitos
(use-package all-the-icons)

; Modeline, la barra de abajo. Estamos usando la de doom emacs
(use-package doom-modeline
	:ensure t
	:init (doom-modeline-mode 1)
	:custom ((doom-modeline-height 15)))

; Rainbow brackets
(use-package rainbow-delimiters
	:hook (prog-mode . rainbow-delimiters-mode))

(use-package atom-one-dark-theme)

; Cambio de tema.
; Nótese que solo tiene una comilla por delante, es un símbolo en lisp
(load-theme 'atom-one-dark t)

; Whichkey
(use-package which-key
	:init (which-key-mode)
	:diminish which-key-mode
	:config
	(setq which-key-idle-delay 0.3))

; Vim
(use-package general
  :config
  (general-create-definer vim/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")

  (vim/leader-keys
   "t" '(:ignore t :which-key "togles")))

;; Ahora sí, vim
(defun vim/evil-hook ()
  (dolist (mode '(custom-mode
		  eshell-mode
		  git-rebase-mode
		  erc-mode
		  circe-server-mode
		  circe-chat-mode
		  circe-query-mode
		  sauron-mode
		  term-mode))
    (add-to-list 'evil-emacs-state-modes mode)))

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  :hook (evil-mode . vim/evil-hook)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(evil general which-key use-package rainbow-delimiters ivy-rich doom-modeline command-log-mode atom-one-dark-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )