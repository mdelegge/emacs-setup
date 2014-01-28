;;; .emacs --- Summary: Marc DeLegge's emacs resource file
;;
;;; Commentary: 
;;  


;;; Code:

;;; --------------------------------------------------------------------

(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/library")
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(add-to-list 'load-path "~/.emacs.d/el-get/enh-ruby-mode")

(setq default-directory (concat (getenv "HOME") "/"))

(require 'package)
(add-to-list 'package-archives
    '("marmalade" .
      "http://marmalade-repo.org/packages/"))

(add-to-list 'package-archives
    '("melpa" . "http://melpa.milkbox.net/packages/") t)

(setq yasnippet-dir "~/.emacs.d/elpa/yasnippet-0.8.0")

(package-initialize)

(require 'el-get)

;; ====================================================================
;; UI/Platform/Keybinds
;; ====================================================================


;; --------------------------------------------------------------------
;; Command should be Hyper, Meta should be Alt/Option
(setq mac-option-modifier 'meta)
(setq mac-command-modifier 'hyper)


;; --------------------------------------------------------------------
;; Keybinds
(define-key input-decode-map "\e[1;2A" [S-up])

(global-set-key [(hyper a)] 'mark-whole-buffer)
(global-set-key [(hyper v)] 'yank)
(global-set-key [(hyper c)] 'kill-ring-save)
(global-set-key [(hyper x)] 'kill-region)
(global-set-key [(hyper z)] 'undo)

(global-set-key [(hyper o)] 'find-file) ;;Open
(global-set-key [(hyper s)] 'save-buffer)
(global-set-key [(hyper n)] 'new-frame)
(global-set-key [(hyper w)] 'delete-frame)

(global-set-key [(hyper l)] 'goto-line)

(global-set-key [(hyper right)] 'next-multiframe-window)
(global-set-key [(hyper left)] 'previous-multiframe-window)
(global-set-key [(hyper up)] 'scroll-down-command)
(global-set-key [(hyper down)] 'scroll-up-command)

(global-set-key [(hyper f)] 'isearch-forward)
(global-set-key [C-M-right] 'forward-sexp)
(global-set-key [C-M-left] 'backward-sexp)
(global-set-key [C-/] 'undo)


(global-set-key [C-M-right] 'forward-sexp)

;;(global-set-key "\C-cu" 'universal-argument)

;; Now bind the delete line function to the C-u key
;;(global-set-key "\C-u" 'nuke-line)
;;(global-set-key "\M-SPC" 'set-mark-command)

;; rebind search for selection key
(global-set-key "\C-cs" 'google-search-selection)

;; rebind HOME and END keys
(global-set-key [home] 'beginning-of-line)
(global-set-key [end] 'end-of-line)


;; --------------------------------------------------------------------
;; Stop accidental minimization, since it can't be
;; reversed from the keyboard  (from EmacsWiki)
(when window-system
    (global-unset-key [?\C-x ?\C-z])) ; iconify-or-deiconify-frame (C-x C-z)


;; Add Gist code-snippets access
;;(add-to-list 'load-path "~/.emacs.d/vendor/gist.el")
;;(require 'gist)

;; --------------------------------------------------------------------
(load "init")
(load "google")
(load "darkroom-mode")

(setq exec-path (cons "/usr/local/bin" exec-path))


;; --------------------------------------------------------------------
;; add smoother scrolling.
;; Smooth Scrolling doesn't work so well on Windows 7, so only enable it
;; for the Mac
;;(require 'smooth-scrolling)
(if (eq window-system 'mac)
   	(require 'smooth-scrolling))

;; Make scrolling better on the Mac
;; Slow down the mouse wheel acceleration
(when (boundp 'mouse-wheel-scroll-amount)
  (setq mouse-wheel-scroll-amount '(0.01)))


;; --------------------------------------------------------------------
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(global-auto-revert-mode t)
;;(global-linum-mode 1)
(delete-selection-mode t)
(show-paren-mode t)
(column-number-mode t)

(setq shell-file-name "bash")
(setq explicit-shell-file-name shell-file-name)


;; --------------------------------------------------------------------
;; no splash screen
(setq inhibit-splash-screen t)
;;(setq inhibit-startup-message t)

;; --------------------------------------------------------------------
;; Prevent beeps on errors
(setq visible-bell t)


;; --------------------------------------------------------------------
;; Highlight regions and add special behaviors to regions.
;; "C-h d transient" for more information
(setq transient-mark-mode t)



;; --------------------------------------------------------------------
;; Use Command key as Meta key
;;(setq ns-command-modifier (quote meta))


;; --------------------------------------------------------------------
;; Use Y or N instead of Yes or No at prompts
(fset 'yes-or-no-p 'y-or-n-p)


;; --------------------------------------------------------------------
;;(if window-system
;;    (load-theme 'comidia-mod t)
;;    (load-theme 'late-night t)
;;    (load-theme 'wheatgrass t))

;;(load-theme 'wheatgrass t)
(load-theme 'solarized-dark t)


;; --------------------------------------------------------------------
;; Set to preferred Font
;;(set-mac-font "menlo" 16)
(if window-system
	(if (eq window-system 'mac)
       	(set-face-attribute 'default nil :font "Menlo 14")
       	(set-face-attribute 'default nil :font "Ubuntu Mono 14"))
    (set-default-font "-adobe-courier-medium-r-normal--12-180-75-75-m-110-iso8859-1"))


;; --------------------------------------------------------------------
;; make some commands enabled that are default disabled
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)


;; --------------------------------------------------------------------
;; Fix Tab Stops
(setq tab-stop-list (number-sequence 4 200 4))
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)



;; --------------------------------------------------------------------
;; Trailing whitesapce is unnecessary
;;(add-hook 'before-save-hook (lambda () (delete-trailing-whitespace)))

;; Save backups to a special place
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))



;; --------------------------------------------------------------------
;; Set Transparency
;;(set-frame-parameter (selected-frame) 'alpha '(<active> [<inactive>]))
;;(set-frame-parameter (selected-frame) 'alpha '(90 80))
;;(add-to-list 'default-frame-alist '(alpha 90 80))





;; ====================================================================
;; Features
;; ====================================================================


;; --------------------------------------------------------------------
;;iman "man (and info) lookup with completion"
(autoload 'iman "iman"
  "Call the viewers of man pages and GNU Info with completion." t nil)


;;(org-babel-do-load-languages
;; 'org-babel-load-languages
;; '((sh . true) (python . true)))


;; --------------------------------------------------------------------
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;;(define-key global-map "\C-cl" 'org-store-link)
;;(define-key global-map "\C-ca" 'org-agenda)
;;(setq org-log-done t)


(setq org-support-shift-select t)
;;(setq org-agenda-files (list "~/Dropbox/org/work.org"
;;                             "~/Dropbox/org/home.org"
;;                             "~/Dropbox/Work/Work Temp/worknotes.txt"))
;;(global-set-key "\C-cl" 'org-store-link)
;;(global-set-key "\C-cc" 'org-capture)
;;(global-set-key "\C-ca" 'org-agenda)
;;(global-set-key "\C-cb" 'org-iswitchb)


;; --------------------------------------------------------------------
;; Buffer Switching Ease
(ido-mode t)



;; ====================================================================
;; Development
;; ====================================================================

;;(when (memq window-system '(mac ns))
;;  (exec-path-from-shell-initialize))
(require 'ag)
(setq ag-highlight-search t)
;; (global-set-key (kbd "<f5>") 'ag-project)
;; (global-set-key (kbd "<f6>") 'ag-regexp-project-at-point)

;; --------------------------------------------------------------------
;; Support for Ruby Coding
(require 'inf-ruby)
(require 'enh-ruby-mode)
(setq enh-ruby-program "/Users/Marc/.rvm/rubies/ruby-1.9.3-p194/bin/ruby")
(autoload 'enh-ruby-mode "enh-ruby-mode" "Major mode for ruby files" t)
(add-to-list 'auto-mode-alist '("\\.rb$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . enh-ruby-mode)) 
(add-to-list 'interpreter-mode-alist '("ruby" . enh-ruby-mode))
 
(setq enh-ruby-bounce-deep-indent t)
(setq enh-ruby-hanging-brace-indent-level 2)
(remove-hook 'enh-ruby-mode-hook 'erm-define-faces)

;; enable Robe, which allows for jumping to method definitions
(add-hook 'ruby-mode-hook 'robe-mode)
;; M-x robe-start to start
;; C-c C-l (ruby-load-file) to update definitions from files
;; C-c C-k for Rails projects to reload projects
;; M-. to jump to the definition
;; M-, to jump back
;; C-c C-d to see the documentation
;; C-c C-k to refresh Rails environment
;; C-M-i to complete the symbol at point


;; --------------------------------------------------------------------
(require 'smartparens-config)
(require 'smartparens-ruby)
(smartparens-global-mode)
(show-smartparens-global-mode t)
(sp-with-modes '(rhtml-mode)
               (sp-local-pair "<" ">")
               (sp-local-pair "<%" "%>"))


;; --------------------------------------------------------------------
;; auto-completiong
(require 'auto-complete-config)
(autoload 'ruby-mode "ruby-mode" "Major mode for editing ruby scripts." t)
(setq auto-mode-alist  (cons '(".rb$" . enh-ruby-mode) auto-mode-alist))
(setq auto-mode-alist  (cons '(".rhtml$" . html-mode) auto-mode-alist))
(setq ruby-indent-level 4)
(global-font-lock-mode 1)

;;(add-to-list 'ac-dictionary-directories) "some/dictionary/file")
;;(add-to-list 'ac-dictionary-directories
;;             "~/.emacs.d/.cask/24.3.50.1/elpa/auto-complete-20130724.1750/dict")

(ac-config-default)
(setq ac-ignore-case nil)
(add-to-list 'ac-modes 'enh-ruby-mode)
(add-to-list 'ac-modes 'web-mode)
;;(add-hook 'robe-mode-hook 'robe-ac-setup)




;; --------------------------------------------------------------------
;; Python setup
(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))
(setq py-python-command "/usr/bin/python")
(setenv "PYMACS_PYTHON" "/usr/bin/python")


;; --------------------------------------------------------------------
;; NASM mode
(autoload 'nasm-mode "~/.emacs.d/library/nasm-mode.el" "" t)
(add-to-list 'auto-mode-alist '("\\.\\(asm\\|s\\)$" . nasm-mode))


;; --------------------------------------------------------------------
;; Support for Markdown
(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t)
(setq auto-mode-alist (cons '("\\.md" . markdown-mode) auto-mode-alist))


;; --------------------------------------------------------------------
;; Speedbar customization
(require 'speedbar)
(speedbar-add-supported-extension ".rb" )
(speedbar-add-supported-extension "Gemfile" )
(speedbar-add-supported-extension ".erb" )
(speedbar-add-supported-extension ".rhtml" )
(speedbar-add-supported-extension ".yml" )
(speedbar-add-supported-extension ".txt" )
(speedbar-add-supported-extension ".js" )
(speedbar-add-supported-extension ".py" )
(speedbar-add-supported-extension ".md" )
(speedbar-add-supported-extension ".rdoc" )
(speedbar-add-supported-extension ".cs" )
(speedbar-add-supported-extension ".sql" )


;; --------------------------------------------------------------------
;; Enable Flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)

;; enable rubocop
(require 'rubocop)


;; ====================================================================
;; Games/Misc
;; ====================================================================


;; --------------------------------------------------------------------
;; I like to play Gnu Go sometimes
;;(autoload 'gnugo "gnugo" "Play Go" t)
;;(defadvice gnugo-insertion-filter (before gnugo-coding-system-fix activate)
;;  (setq string (replace-regexp-in-string "\r" "" string)))



;; ====================================================================
;; Social Modes
;; ====================================================================

;; --------------------------------------------------------------------
;; ERC junk to filter out messages we don't care about
(require 'erc)
(erc-autojoin-mode t)
(setq erc-autojoin-channels-alist
  '((".*\\.twit.tv" "#twitlive")))

(erc-track-mode t)
(setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT" "MODE"

                                 "324" "329" "332" "333" "353" "477"))
;; don't show any of this
(setq erc-hide-list '("JOIN" "PART" "QUIT" "NICK"))


(setq add-log-mailing-address "marc.delegge@gmail.com")


;; --------------------------------------------------------------------

;;(setq server-socket-dir "~/.emacs.d/server")
;;(setq inline-crypt-openssl-command "/usr/bin/openssl")

;; --------------------------------------------------------------------




;; ====================================================================
;; Emacs-Server
;; ====================================================================

;; Turn on server mode
(if window-system
    (server-start))



;; ====================================================================
;; Built-In Customization
;; ====================================================================

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-default nil)
 '(backup-inhibited t t)
 '(column-number-mode t)
 '(custom-safe-themes (quote ("6cfe5b2f818c7b52723f3e121d1157cf9d95ed8923dbc1b47f392da80ef7495d" "e16a771a13a202ee6e276d06098bc77f008b73bbac4d526f160faa2d76c1dd0e" "b79fb876608767112415442f9cd18d9aaf5ddf9090b3427e7061140ff5ca3587" "d24e10524bb50385f7631400950ba488fa45560afcadd21e6e03c2f5d0fad194" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "5e1d1564b6a2435a2054aa345e81c89539a72c4cad8536cfe02583e0b7d5e2fa" "fe6330ecf168de137bb5eddbf9faae1ec123787b5489c14fa5fa627de1d9f82b" "936e5cac238333f251a8d76a2ed96c8191b1e755782c99ea1d7b8c215e66d11e" "085b401decc10018d8ed2572f65c5ba96864486062c0a2391372223294f89460" "9f443833deb3412a34d2d2c912247349d4bd1b09e0f5eaba11a3ea7872892000" "f9a57c8e2b1e146547c7441d57b4a0a2d37da916db6ea76da6285c2977a54c0b" "13a28ff3dc8b7644c4ee303f26fbc51c336746af882b627a458cb0104f30d5b7" "0b16b81ecd7fb374fba517fc58c8316273000f34ceaa70dc125b140bbe3663a9" "d2eb5d9fcb416adfac529a4de39711162d0e851e6ab840f01fb1054b44441012" "30fe7e72186c728bd7c3e1b8d67bc10b846119c45a0f35c972ed427c45bacc19" "8b7221368020ebdf63bf464ea73e0a0e57953b710e1602e9c3a506d30226773d" "2287676d899c9eb4452e05b0c585c06daa4c7a9af93cd030d7af121f4eea6dc6" "ef835797dced16c0ecb61ea81b82f19e8eaf19d2478115308ac437fc770ec786" default)))
 '(fill-column 78)
 '(ido-auto-merge-work-directories-length nil)
 '(ido-create-new-buffer (quote always))
 '(ido-enable-flex-matching t)
 '(ido-enable-prefix nil)
 '(ido-everywhere t)
 '(ido-ignore-extensions t)
 '(ido-max-prospects 8)
 '(ido-use-filename-at-point (quote guess))
 '(indent-tabs-mode nil)
 '(indicate-empty-lines t)
 '(linum-format " %7d ")
 '(org-agenda-files (quote ("~/Dropbox/Work/Work Temp/worknotes.txt" "~/Dropbox/org/work.org" "~/Dropbox/org/home.org")))
 '(package-archives (quote (("gnu" . "http://elpa.gnu.org/packages/") ("marmalade" . "http://marmalade-repo.org/packages/"))))
 '(puppet-indent-level tab-width)
 '(recentf-max-saved-items 75)
 '(require-final-newline t)
 '(ruby-indent-level tab-width)
 '(safe-local-variable-values (quote ((eval font-lock-add-keywords nil (\` (((\, (concat "(" (regexp-opt (quote ("sp-do-move-op" "sp-do-move-cl" "sp-do-put-op" "sp-do-put-cl" "sp-do-del-op" "sp-do-del-cl")) t) "\\_>")) 1 (quote font-lock-variable-name-face))))))))
 '(speedbar-frame-parameters (quote ((minibuffer) (width . 40) (border-width . 0) (menu-bar-lines . 0) (tool-bar-lines . 0) (unsplittable . t) (left-fringe . 0))))
 '(tab-width 4))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
