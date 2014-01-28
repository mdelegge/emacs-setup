((css-mode status "required" recipe nil)
 (enh-ruby-mode status "installed" recipe
                (:name enh-ruby-mode :description "Replacement for ruby-mode which uses ruby 1.9's Ripper to parse and indent. From Zenspider's repository." :type github :pkgname "zenspider/enhanced-ruby-mode" :features enh-ruby-mode :post-init
                       (progn
                         (autoload 'enh-ruby-mode "enh-ruby-mode" "Major mode for ruby files" t)
                         (add-to-list 'interpreter-mode-alist
                                      '("ruby" . enh-ruby-mode))
                         (add-to-list 'auto-mode-alist
                                      '("\\.rake$" . enh-ruby-mode))
                         (add-to-list 'auto-mode-alist
                                      '("Rakefile$" . enh-ruby-mode))
                         (add-to-list 'auto-mode-alist
                                      '("\\.gemspec$" . enh-ruby-mode))
                         (add-to-list 'auto-mode-alist
                                      '("Gemfile$" . enh-ruby-mode))
                         (add-to-list 'auto-mode-alist
                                      '("\\.rb$" . enh-ruby-mode)))))
 (inf-ruby status "installed" recipe
           (:name inf-ruby :type elpa))
 (package status "installed" recipe
          (:name package :description "ELPA implementation (\"package.el\") from Emacs 24" :builtin "24" :type http :url "http://repo.or.cz/w/emacs.git/blob_plain/1a0a666f941c99882093d7bd08ced15033bc3f0c:/lisp/emacs-lisp/package.el" :shallow nil :features package :post-init
                 (progn
                   (setq package-user-dir
                         (expand-file-name
                          (convert-standard-filename
                           (concat
                            (file-name-as-directory default-directory)
                            "elpa")))
                         package-directory-list
                         (list
                          (file-name-as-directory package-user-dir)
                          "/usr/share/emacs/site-lisp/elpa/"))
                   (make-directory package-user-dir t)
                   (unless
                       (boundp 'package-subdirectory-regexp)
                     (defconst package-subdirectory-regexp "^\\([^.].*\\)-\\([0-9]+\\(?:[.][0-9]+\\)*\\)$" "Regular expression matching the name of\n a package subdirectory. The first subexpression is the package\n name. The second subexpression is the version string."))
                   (setq package-archives
                         (bound-and-true-p package-archives))
                   (mapc
                    (lambda
                      (pa)
                      (add-to-list 'package-archives pa 'append))
                    '(("ELPA" . "http://tromey.com/elpa/")
                      ("gnu" . "http://elpa.gnu.org/packages/")
                      ("marmalade" . "http://marmalade-repo.org/packages/")
                      ("SC" . "http://joseito.republika.pl/sunrise-commander/"))))))
 (rhtml status "installed" recipe
        (:name rhtml :type git :url "https://github.com/eschulte/rhtml.git" :features rhtml-mode))
 (ruby-compilation status "installed" recipe
                   (:name ruby-compilation :type elpa))
 (ruby-mode status "installed" recipe
            (:name ruby-mode :type elpa :load "ruby-mode.el"))
 (rvm status "installed" recipe
      (:name rvm :type git :url "http://github.com/djwhitt/rvm.el.git" :load "rvm.el" :compile
             ("rvm.el")
             :after
             (lambda nil
               (rvm-use-default))))
 (yaml-mode status "installed" recipe
            (:name yaml-mode :type git :url "http://github.com/yoshiki/yaml-mode.git" :features yaml-mode)))
