;;; .loaddefs.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (enh-ruby-mode) "enh-ruby-mode/enh-ruby-mode" "enh-ruby-mode/enh-ruby-mode.el"
;;;;;;  (21210 15426 0 0))
;;; Generated autoloads from enh-ruby-mode/enh-ruby-mode.el

(autoload 'enh-ruby-mode "enh-ruby-mode/enh-ruby-mode" "\
Enhanced Major mode for editing Ruby code.

\\{enh-ruby-mode-map}

\(fn)" t nil)

(add-to-list 'auto-mode-alist '("\\.rb\\'" . enh-ruby-mode))

(add-to-list 'auto-mode-alist '("Rakefile\\'" . enh-ruby-mode))

(add-to-list 'auto-mode-alist '("\\.gemspec\\'" . enh-ruby-mode))

;;;***

;;;### (autoloads (inf-ruby-console-default inf-ruby-console-gem
;;;;;;  inf-ruby-console-rails inf-ruby-console-auto inf-ruby-switch-setup
;;;;;;  run-ruby inf-ruby inf-ruby-minor-mode inf-ruby-setup-keybindings)
;;;;;;  "inf-ruby/inf-ruby" "inf-ruby/inf-ruby.el" (21187 8310 0
;;;;;;  0))
;;; Generated autoloads from inf-ruby/inf-ruby.el

(defvar ruby-source-modes '(ruby-mode enh-ruby-mode) "\
Used to determine if a buffer contains Ruby source code.
If it's loaded into a buffer that is in one of these major modes, it's
considered a ruby source file by `ruby-load-file'.
Used by these commands to determine defaults.")

(autoload 'inf-ruby-setup-keybindings "inf-ruby/inf-ruby" "\
Hook up `inf-ruby-minor-mode' to each of `ruby-source-modes'.

\(fn)" nil nil)

(autoload 'inf-ruby-minor-mode "inf-ruby/inf-ruby" "\
Minor mode for interacting with the inferior process buffer.

The following commands are available:

\\{inf-ruby-minor-mode-map}

\(fn &optional ARG)" t nil)

(autoload 'inf-ruby "inf-ruby/inf-ruby" "\
Run an inferior Ruby process in a buffer.
With prefix argument, prompts for which Ruby implementation
\(from the list `inf-ruby-implementations') to use.  Runs the
hooks `inf-ruby-mode-hook' (after the `comint-mode-hook' is
run).

\(fn &optional IMPL)" t nil)

(autoload 'run-ruby "inf-ruby/inf-ruby" "\
Run an inferior Ruby process, input and output via buffer *ruby*.
If there is a process already running in `*ruby*', switch to that buffer.
With argument, allows you to edit the command line (default is value
of `ruby-program-name').  Runs the hooks `inferior-ruby-mode-hook'
\(after the `comint-mode-hook' is run).
\(Type \\[describe-mode] in the process buffer for a list of commands.)

\(fn &optional COMMAND NAME)" t nil)

(autoload 'inf-ruby-switch-setup "inf-ruby/inf-ruby" "\
Modify `rspec-compilation-mode' and `ruby-compilation-mode'
keymaps to bind `inf-ruby-switch-from-compilation' to `!-x C-q'.

\(fn)" nil nil)

(autoload 'inf-ruby-console-auto "inf-ruby/inf-ruby" "\
Run the appropriate Ruby console command.
The command and and the directory to run it from are detected
automatically.

\(fn)" t nil)

(autoload 'inf-ruby-console-rails "inf-ruby/inf-ruby" "\
Run Rails console in DIR.

\(fn DIR)" t nil)

(autoload 'inf-ruby-console-gem "inf-ruby/inf-ruby" "\
Run IRB console for the gem in DIR.
The main module should be loaded automatically.  If DIR contains a
Gemfile, it should use the `gemspec' instruction.

\(fn DIR)" t nil)

(autoload 'inf-ruby-console-default "inf-ruby/inf-ruby" "\
Run racksh, custom console.rb, or just IRB, in DIR.

\(fn DIR)" t nil)
 (dolist (mode ruby-source-modes) (add-hook (intern (format "%s-hook" mode)) 'inf-ruby-minor-mode))

;;;***

;;;### (autoloads (rhtml-mode) "rhtml/rhtml-mode" "rhtml/rhtml-mode.el"
;;;;;;  (21187 8376 0 0))
;;; Generated autoloads from rhtml/rhtml-mode.el

(autoload 'rhtml-mode "rhtml/rhtml-mode" "\
Embedded Ruby Mode (RHTML)

\(fn)" t nil)

(add-to-list 'auto-mode-alist '("\\.html\\.erb$" . rhtml-mode))

;;;***

;;;### (autoloads (ruby-compilation-this-test ruby-compilation-cap
;;;;;;  pcomplete/cap ruby-compilation-rake pcomplete/rake ruby-compilation-this-buffer
;;;;;;  ruby-compilation-run) "ruby-compilation/ruby-compilation"
;;;;;;  "ruby-compilation/ruby-compilation.el" (21187 8326 0 0))
;;; Generated autoloads from ruby-compilation/ruby-compilation.el

(eval-after-load 'ruby-mode '(progn (define-key ruby-mode-map (kbd "C-x t") 'ruby-compilation-this-buffer) (define-key ruby-mode-map (kbd "C-x T") 'ruby-compilation-this-test)))

(autoload 'ruby-compilation-run "ruby-compilation/ruby-compilation" "\
Run CMD using `ruby-compilation-executable' in a ruby compilation buffer.
Argument RUBY-OPTIONS can be used to specify additional
command line args for ruby.  If supplied, NAME will be used in
place of the script name to construct the name of the compilation
buffer.

\(fn CMD &optional RUBY-OPTIONS NAME)" t nil)

(autoload 'ruby-compilation-this-buffer "ruby-compilation/ruby-compilation" "\
Run the current buffer through Ruby compilation.

\(fn)" t nil)

(autoload 'pcomplete/rake "ruby-compilation/ruby-compilation" "\
Start pcompletion using the list of available rake tasks.

\(fn)" nil nil)

(autoload 'ruby-compilation-rake "ruby-compilation/ruby-compilation" "\
Run a rake process dumping output to a ruby compilation buffer.
If EDIT is t, prompt the user to edit the command line.  If TASK
is not supplied, the user will be prompted.  ENV-VARS is an
optional list of (name . value) pairs which will be passed to rake.

\(fn &optional EDIT TASK ENV-VARS)" t nil)

(autoload 'pcomplete/cap "ruby-compilation/ruby-compilation" "\
Start pcompletion using the list of available capistrano tasks.

\(fn)" nil nil)

(autoload 'ruby-compilation-cap "ruby-compilation/ruby-compilation" "\
Run a capistrano process dumping output to a ruby compilation buffer.
If EDIT is t, prompt the user to edit the command line.  If TASK
is not supplied, the user will be prompted.  ENV-VARS is an
optional list of (name . value) pairs which will be passed to
capistrano.

\(fn &optional EDIT TASK ENV-VARS)" t nil)

(autoload 'ruby-compilation-this-test "ruby-compilation/ruby-compilation" "\
Run the test at point through Ruby compilation.

\(fn)" t nil)

;;;***

;;;### (autoloads (ruby-mode) "ruby-mode/ruby-mode" "ruby-mode/ruby-mode.el"
;;;;;;  (21187 8283 0 0))
;;; Generated autoloads from ruby-mode/ruby-mode.el

(autoload 'ruby-mode "ruby-mode/ruby-mode" "\
Major mode for editing Ruby scripts.
\\[ruby-indent-line] properly indents subexpressions of multi-line
class, module, def, if, while, for, do, and case statements, taking
nesting into account.

The variable ruby-indent-level controls the amount of indentation.
\\{ruby-mode-map}

\(fn)" t nil)

(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))

(add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))

(add-to-list 'interpreter-mode-alist '("rbx" . ruby-mode))

(add-to-list 'interpreter-mode-alist '("jruby" . ruby-mode))

(add-to-list 'interpreter-mode-alist '("ruby1.9" . ruby-mode))

(add-to-list 'interpreter-mode-alist '("ruby1.8" . ruby-mode))

;;;***

;;;### (autoloads (rvm-open-gem rvm-use rvm-activate-corresponding-ruby
;;;;;;  rvm-use-default) "rvm/rvm" "rvm/rvm.el" (21187 8359 0 0))
;;; Generated autoloads from rvm/rvm.el

(autoload 'rvm-use-default "rvm/rvm" "\
use the rvm-default ruby as the current ruby version

\(fn)" t nil)

(autoload 'rvm-activate-corresponding-ruby "rvm/rvm" "\
activate the corresponding ruby version for the file in the current buffer.
This function searches for an .rvmrc file and actiavtes the configured ruby.
If no .rvmrc file is found, the default ruby is used insted.

\(fn)" t nil)

(autoload 'rvm-use "rvm/rvm" "\
switch the current ruby version to any ruby, which is installed with rvm

\(fn NEW-RUBY NEW-GEMSET)" t nil)

(autoload 'rvm-open-gem "rvm/rvm" "\


\(fn GEMHOME)" t nil)

;;;***

;;;### (autoloads (yaml-mode yaml) "yaml-mode/yaml-mode" "yaml-mode/yaml-mode.el"
;;;;;;  (21187 8394 0 0))
;;; Generated autoloads from yaml-mode/yaml-mode.el

(let ((loads (get 'yaml 'custom-loads))) (if (member '"yaml-mode/yaml-mode" loads) nil (put 'yaml 'custom-loads (cons '"yaml-mode/yaml-mode" loads))))

(autoload 'yaml-mode "yaml-mode/yaml-mode" "\
Simple mode to edit YAML.

\\{yaml-mode-map}

\(fn)" t nil)

(add-to-list 'auto-mode-alist '("\\.ya?ml$" . yaml-mode))

;;;***

;;;### (autoloads nil nil ("inf-ruby/inf-ruby-autoloads.el" "inf-ruby/inf-ruby-pkg.el"
;;;;;;  "rhtml/rhtml-erb.el" "rhtml/rhtml-fonts.el" "rhtml/rhtml-navigation.el"
;;;;;;  "rhtml/rhtml-ruby-hook.el" "rhtml/rhtml-sgml-hacks.el" "ruby-compilation/ruby-compilation-autoloads.el"
;;;;;;  "ruby-compilation/ruby-compilation-pkg.el" "ruby-mode/ruby-mode-autoloads.el"
;;;;;;  "ruby-mode/ruby-mode-pkg.el") (21210 15426 685648 0))

;;;***

(provide '.loaddefs)
;; Local Variables:
;; version-control: never
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; .loaddefs.el ends here
