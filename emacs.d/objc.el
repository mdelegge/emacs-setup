;; Objective C
;; ================================================================================
(require 'cc-mode)


;; specialized line formatting for ObjC handling
(add-hook 'objc-mode-hook
          (lambda ()
            (linum-on 1)
            ))

(add-hook 'objc-mode-hook 'visual-line-mode)
(add-hook 'objc-mode-hook 'outline-minor-mode) ;; required for anything.el to work
(add-hook 'objc-mode-hook 'adaptive-wrap-prefix-mode)
(add-hook 'objc-mode-hook (lambda ()
                            (setq adaptive-wrap-extra-indent 4)))

;; ObjectiveC Keymaps
(define-key objc-mode-map (kbd "C-c m") 'search-objc-selector)
(define-key objc-mode-map (kbd "C-c f") 'search-objc-name)
(define-key objc-mode-map (kbd "C-c s") 'objc-headline)


;; Method/Keyword Search methods
(require 'docsetutil)

(setq docsetutil-program
      "/Applications/Xcode.app/Contents/Developer/usr/bin/docsetutil")
(setq docsetutil-browse-url-function 'w3m-browse-url)

(defun get-objc-selector-raw ()
  "Get the characters that are direct residents of the selector's braces.
The expression [[foo bar] a:@\"stuff\" b:[baz zap] c:wow] will
return \" a: b: c:wow\". This string can be further processed to
get just the selector."
  (let ((ignore-set '("@"))
        (skip-set '("(" "{" "[" "\"" "'"))
        (accum "")
        (stay t)
        (char (lambda ()
                (buffer-substring-no-properties
                 (point) (+ 1 (point))))))
    (while stay
      (cond ((member (funcall char) skip-set)
             (progn
               (forward-sexp)))
            ((member (funcall char) ignore-set)
             (progn
               (forward-char)))
            ((string-equal (funcall char) "]")
             (progn
               (setq stay nil)))
            (t
             (progn
               (setq accum (concat accum (funcall char)))
               (forward-char)))))
    accum))

(defun get-objc-selector ()
  "Try to extract a selector name from the area around point.
If the text around point is [[foo bar] a:@\"stuff\" b:[baz zap]
c:wow] then this will return \"a:b:c:\"."
  (save-excursion
    ;; Step just inside the call
    (up-list)
    (backward-list)
    (down-list)

    (let* ((raw (get-objc-selector-raw))
           (has-args (string-match ":" raw))
           (cleaned "")
           (args-regex "\\([a-zA-Z]+\\)[ \t\n]*:")
           (noargs-regex "[a-zA-Z]+")
           (start-point 0))
      (cond (has-args
             (while (string-match args-regex raw start-point)
               (setq cleaned (concat cleaned (match-string 1 raw) ":"))
               (setq start-point (match-end 0))))
            (t
             (while (string-match noargs-regex raw start-point)
               (setq start-point (match-end 0))
               (setq cleaned (match-string 0 raw)))))
      cleaned)))

(defun search-objc-selector ()
  "Try to search the documentation for information about the
selector near point."
  (interactive)
  (let ((name (get-objc-selector)))
    (docsetutil-search name)))

(defun search-objc-name ()
  "Search the documentation for the word under point."
  (interactive)
  (docsetutil-search (thing-at-point 'symbol)))

;; Spotlight-like searching for selectors/pragma marks
;; Mostly from http://blog.fenrir-inc.com/us/2012/02/display-a-list-of-file-methods-and-jump-with-emacs-objective-c.html
(require 'anything)

;; Anything-config changes w3m-command rudely. Stop it.
(with-no-warnings (let ((w3m-command nil)) (require 'anything-config)))

(defvar anything-c-source-objc-headline
  '((name . "Objective-C Headline")
    (headline . "^[ \t]*[-+@]\\|^#pragma[ \t]+mark"))
  "Configuration for Objective-C headline.")

(defun objc-headline ()
  "Produce a list of all selectors and #pragma marks defined in buffer."
  (interactive)
  (let ((anything-candidate-number-limit 500))
    (anything-other-buffer '(anything-c-source-objc-headline)
                           "*ObjC Headline*")))

;; Header file handling
(add-to-list 'magic-mode-alist
                `(,(lambda ()
                     (and (string= (file-name-extension buffer-file-name) "h")
                          (re-search-forward "@\\<interface\\>" 
					     magic-mode-regexp-match-limit t)))
                  . objc-mode))


;; load associated other files
(require 'find-file)
(nconc (cadr (assoc "\\.h\\'" cc-other-file-alist)) '(".m" ".mm"))
(add-to-list 'cc-other-file-alist '("\\.m\\'" (".h")))
(add-to-list 'cc-other-file-alist '("\\.mm\\'" (".h")))

;; handle Framework header file lookups
(defadvice ff-get-file-name (around ff-get-file-name-framework
				    (search-dirs 
				     fname-stub 
				     &optional suffix-list))
  "Search for Mac framework headers as well as POSIX headers."
   (or
    (if (string-match "\\(.*?\\)/\\(.*\\)" fname-stub)
	(let* ((framework (match-string 1 fname-stub))
	       (header (match-string 2 fname-stub))
	       (fname-stub (concat framework ".framework/Headers/" header)))
	  ad-do-it))
      ad-do-it))
(ad-enable-advice 'ff-get-file-name 'around 'ff-get-file-name-framework)
(ad-activate 'ff-get-file-name)

(setq cc-search-directories '("." "../include" "/usr/include" "/usr/local/include/*"
			      "/System/Library/Frameworks" "/Library/Frameworks"))


(require 'compile)
(add-hook 'objc-mode-hook
          (lambda ()
            (unless (file-exists-p "Makefile")
              (set (make-local-variable 'compile-command)
                   ;; emulate make's .c.o implicit pattern rule, but with
                   ;; different defaults for the CC, CPPFLAGS, and CFLAGS
                   ;; variables:
                   ;; clang File.m -o File -ObjC $CPPFLAGS $CFLAGS
                   (let ((file (file-name-nondirectory buffer-file-name)))
                     (format "%s %s -o %s %s %s %s"
                             (or (getenv "CC") "clang")
                             (file-name-nondirectory file)
                             (file-name-sans-extension file)
                             (or (getenv "CPPFLAGS") "")
                             (or (getenv "CFLAGS") "")
                             "-std=c99 -framework Foundation"))))))





