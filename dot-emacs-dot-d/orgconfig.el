;; My customizations for org-mode and abbrev mode, under version
;; control
;;
;; Vincent A. Emanuele II
;; Created On: Wed Jul 27 13:56:43 EDT 2011
;;

;; Repeat after me: Package managers in Emacs 24 are your friend
;; Ref:
;;   http://ergoemacs.org/emacs/emacs_package_system.html
;;   http://www.gnu.org/software/emacs/manual/html_node/emacs/Package-Installation.html
(require 'package)
(package-initialize)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(setq package-enable-at-startup nil)

;; Startup edit-server for chrome-emacs integration
(when (and (daemonp) (locate-library "edit-server"))
(require 'edit-server)
(edit-server-start))

;; Adding Confluence integration/settings
;; ... http://sourceforge.net/p/confluence-el/wiki/Home/
(require 'confluence)
(setq confluence-url "https://docs.wellcentive.com/rpc/xmlrpc")
(confluence-default-space-alist (list (cons confluence-url "Data Science")))

;; (autoload 'confluence-get-page "confluence" nil t)
;; (eval-after-load "confluence"
;;   '(progn
;;      (require 'longlines)
;;      (progn
;;        (add-hook 'confluence-mode-hook 'longlines-mode)
;;        (add-hook 'confluence-before-save-hook 'longlines-before-revert-hook)
;;        (add-hook 'confluence-before-revert-hook 'longlines-before-revert-hook)
;;        (add-hook 'confluence-mode-hook '(lambda () (local-set-key "\C-j" 'confluence-newline-and-indent))))))

;; Local location for external lisp files
(add-to-list 'load-path "~/.emacs.d/lisp")
(add-to-list 'load-path "~/.emacs.d/themes")

;; Set color theme
;;

;; load solarized color theme
;; Sources:
;;     http://www.nongnu.org/color-theme/ (color-theme.el)
;;      Installation: http://www.emacswiki.org/cgi-bin/wiki/ColorTheme
;;     https://github.com/altercation/solarized.git (solarize)

(require 'color-theme)
(require 'color-theme-solarized)
(color-theme-initialize)

;; set dark theme
(color-theme-solarized-dark)
;; set light theme
;; (color-theme-solarized-light)

;; Web development setup
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))

;; Autocompletion setup
;; ... AutoComplete mode
;; (add-to-list 'load-path "~/.emacs.d/lisp/auto-complete") 
(require 'ac-html)
(require 'auto-complete-config)
;; (add-to-list 'ac-dictionary-directories "~/.emacs.d/lisp/auto-complete/ac-dict")
(ac-config-default)

(setq ac-use-quick-help t)
(setq ac-use-fuzzy t)
(define-key ac-mode-map (kbd "C-M-k") 'auto-complete)
(ac-flyspell-workaround)

;; ... Web Mode Autocomplete Setup
;; (setq web-mode-ac-sources-alist
;;   '(("css" . (ac-source-css-property))
;;     ("html" . (ac-source-words-in-buffer ac-source-abbrev))))

(setq web-mode-ac-sources-alist
      '( ("css" . (ac-source-css-property))))
;;     ("html" . (ac-source-words-in-buffer ac-source-abbrev))))

(add-to-list 'ac-sources 'ac-source-html-tag)
(add-to-list 'ac-sources 'ac-source-html-attribute)
(add-to-list 'web-mode-ac-sources-alist
  '("html" . (ac-source-html-tag
	      ac-source-html-attribute
	      ac-source-words-in-buffer
	      ac-source-abbrev)))

;; Modify default tab behavior to use 4 spaces
;; ... Note, in sql mode i'm still not completely happe with the behavior
(setq tab-width 4)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(tab-stop-list (quote (4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120))))

;; sql-mode customizations
;;    Default highlighting is mysql keywords
(add-hook 'sql-mode-hook 'sql-highlight-mysql-keywords)
;; (add-hook 'sql-mode-hook 'fci-mode)
(add-hook 'sql-mode-hook '(lambda () (setq indent-tabs-mode nil)))

;; pythom-mode.el setup (from https://launchpad.net/python-mode)
(setq py-install-directory "~/.emacs.d/lisp/python-mode.el-6.1.1")
(add-to-list 'load-path py-install-directory)
(require 'python-mode)

(setq py-extensions-directory "~/.emacs.d/lisp/python-mode.el-6.1.1/extensions")
(add-to-list 'load-path py-extensions-directory)

;; ... Ipython is default shell
(setq-default py-shell-name "ipython")
(setq-default py-which-bufname "IPython")
(setq py-python-command-args '("-colors", "LightBG"))
(setq py-force-py-shell-name-p t)

;; ... Switch to interpreter after executing code
(setq py-shell-switch-buffers-on-execute-p t)
(setq py-switch-buffers-on-execute-p t)

;; ... Don't split windows
(setq py-split-windows-on-execute-p nil)

;; ... Try to automagically figure out indentation
;; note: Why isn't smart operator working?
(setq py-smart-indentation t)
(add-hook 'python-mode-hook 'py-highlight-indentation-on)

;; ... Auto pairing of parentheses
(add-hook 'python-mode-hook 'py-autopair-mode-on)

;; ... "Smart" operator
(require 'py-smart-operator)
(add-hook 'python-mode-hook 'py-smart-operator-mode-on)

;; ... Highlight column where point is located (don't really see a use for this)
;; (require 'column-marker)

;; ... Other hooks/customizations
(add-hook 'python-mode-hook 'fci-mode)
(add-hook 'python-mode-hook 'flyspell-prog-mode)
(add-hook 'python-mode-hook 'turn-on-auto-fill)
(add-hook 'python-mode-hook '(lambda () (setq abbrev-mode 1)))

;; ... IDE-like environment setup
;; ...,,, IDO mode
(require 'ido)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(setq ido-create-new-buffer 'always)
(setq ido-file-extensions-order '(".org" ".csv" ".txt" ".md" ".json" ".py" ".R" ".html" ".xml" ".el"))
(ido-mode t)

;; ...,,, Fill Column Indicator
(require 'fill-column-indicator)


;; Octave mode set-up as default for '.m' files on my mac
(when (eq system-type 'darwin) ;; mac specific settings
  (autoload 'octave-mode "octave-mod" nil t)
  (setq auto-mode-alist
	(cons '("\\.m$" . octave-mode) auto-mode-alist))
  
  (add-hook 'octave-mode-hook
	    (lambda ()
	      (abbrev-mode 1)
	      (fci-mode)
	      (auto-fill-mode 1)
	      (if (eq window-system 'x)
		  (font-lock-mode 1))))
  )

;; Mac keybindings set up
;; (when (eq system-type 'darwin) ;; mac specific settings
;;   (setq mac-option-modifier 'alt)
;;   (setq mac-command-modifier 'meta)
;;  (setq mac-option-key-is-meta t)
;;  (setq mac-right-option-modifier nil)
;;  (setq mac-option-modifier 'super)
  ;; )

;; Emacs Speaks Statistics for R
;; (when (eq system-type 'gnu/linux)
;;   (require 'ess-site))
(require 'ess-site)

(defun myindent-ess-hook ()
  (setq ess-indent-level 4))
(add-hook 'ess-mode-hook 'myindent-ess-hook)
(add-hook 'ess-mode-hook 'fci-mode)

;; Matlab code generation
(defun matlab-function-create (fname)
  "Magic matlab function inserting.
First the user is asked for a function name.
When the function-name doesn't match the current filename the user is
asked for the creation of a new file.  If a matlab entry exists in
`auto-insert-alist' this might then take effect. If no new file is
created we offer to erase the current buffer. 

The next step is the definition of output arguments.  If an argument
is empty the definition of output argument is considered done.  The
output list should be nicely formatted:
  - nothing between the 'function' keyword and the function-name when
    no output argument
  - the single name of a single argument
  - several output arguments put in to [...].

The definition of input arguments works the same.  If any are defined
they are put into parens.

The documentation is prepared:
  - A Matlab H1-line
  - Usage-line copied from the function definitino
  - a list of input and output arguments
  - copyright and author notice using auto-insert-copyright

Also, a skeleton for the inputParser argument-checking routines
is put in place to encourage good programming practice."
  (interactive "sFunction name: ")
  ;; preparing buffer (new or erase or just insert at point)
  (if (or
       (not (buffer-file-name))
       (not (equal fname
                   (replace-string
                    (file-name-nondirectory (buffer-file-name))
                    ".m" ""))))
                   ;; (replace-string
                   ;;  (file-name-nondirectory (buffer-file-name))
                   ;;  ".m" ""))))
    (if (y-or-n-p "create new file? ")
        (find-file (concat fname ".m"))
      (when (not (equal (point-min) (point-max)))
        (if (y-or-n-p "erase current file contents? ")
            (erase-buffer)))))
  (insert "function [")
  ;; insert output arguments
  (let ((gotopos)
        (outarg)
        (hasoutargp nil)
        (outargs)
        (inarg)
        (hasinargp nil)
        (inargs))
    (while (> (length (setq outarg
                            (read-string
                             "output argument (ENTER to finish) ")))
              0)
      (insert (concat outarg ", "))
      (setq outargs (cons outarg outargs))
      (setq hasoutargp t))
    ;; cleanup output list
    (if (not hasoutargp)
        (backward-delete-char 1) ;; remove '['
      (backward-delete-char 2)   ;; remove ', '
      (insert "] = ")
      ;; remove [] around a single output argument
      (when (= (length outargs) 1)
        (save-excursion
          (beginning-of-line)
          (while (re-search-forward "[][]" (point-at-eol) t)
            (replace-match "")))))
    (insert fname "(")
    ;; insert input arguments
    (while (> (length (setq inarg
                            (read-string
                             "input argument (ENTER to finish) ")))
              0)
      (insert (concat inarg ", "))
      (setq inargs (cons inarg inargs))
      (setq hasinargp t))
    ;; clean up input list
    (if (not hasinargp)
        (backward-delete-char 1) ;; opening paren
      (backward-delete-char 2)   ;; ', '
      (insert ")"))
    ;; Matlab H1-line
    (insert (concat "\n% " (upcase fname) " "))
    (setq gotopos (point))
    (insert "<H1 line>\n")
    ;; Usage line (copied from above)
    (insert "%\n% ")
    (insert (upcase 
	     (save-excursion
              (search-backward-regexp "function ")              
              (search-forward-regexp "function ")
              (buffer-substring (point) (point-at-eol)))))
    (insert "\n%\n% <Place a short description here>\n")
    ;; argument documentation
    (when hasinargp
      (insert "%\n% INPUT:\n")
      (mapc #'(lambda (ia)
                (insert (concat "%   " (upcase ia) " - \n")))
            (reverse inargs)))
    (insert "%\n")
    (when hasoutargp
        (insert "% OUTPUT:\n")
      (mapc #'(lambda (oa)
                (insert (concat "%   " (upcase oa) " - \n")))
            (reverse outargs)))
    ;; Section for usage examples and related functions
    (insert "%\n% EXAMPLES:\n%   >>\n%\n% See also:\n%\n")

    ;; Copyright and authors notice
    (insert (concat "% Written-by: " (user-full-name) "\n"))
    (insert (concat "% Created On: " (current-time-string) "\n%\n"))
    (insert (concat "% Copyright (C) "
              (substring (current-time-string) -4) ", "
	      (user-full-name) "\n%\n\n") )

    ;; Set up input argument checking
    (when hasinargp

      (insert "argParser = inputParser;\n\n")

      (insert "% ... Check required inputs\n")
      (mapc #'(lambda (ia)
		(insert (concat ia "Check = \n"))
                (insert (concat "argParser.addRequired( '" ia "', " 
				(concat ia "Check") " );\n\n")))
            (reverse inargs)))

    ;; move to H1-line to make user describe the function
    (goto-char gotopos)

    ;; (mark-end-of-line nil)  
    ))
          
(provide 'matlab-function-create)

;; Auto-insert copyright, author, and time-stamps

;; Make sure my "full" name appears how I want it in signatures
(setq user-full-name "Vincent A. Emanuele II")

;; Highlight paren that matches one at point
(show-paren-mode 1)

;; Display column numbers
(setq column-number-mode t)

;; Wrap lines by default automatically for text
(setq-default fill-column 79)
(add-hook 'text-mode-hook 'turn-on-auto-fill)
(add-hook 'text-mode-hook 'turn-on-flyspell)

;; Spell checking.  
;;
;; 1) Enable flyspell for on-the-fly spell checking to avoid
;; embarrassing mistakes. 
;; 
;; 2) Set personal, private dictionary to be in org directory so it's
;; under version control and synced with all computers I use. 
;;
;; 3) Tab completion using C-M-i
;;

(setq ispell-personal-dictionary "~/org/aspell.personal.en.dictionary")

;; (add-hook 'matlab-mode-hook 'flyspell-prog-mode)

;; Abbrev mode setup.  I use abbrev mode for 2 reasons.
;;
;; 1) Speed : Type reoccurring long words and phrases very fast
;; without sacrificing readability.
;;
;; 2) Auto-correct : Quickly correct common typos I make on a regular
;; basis.
;;

(setq abbrev-file-name "~/org/abbrev_defs")

(if (file-exists-p abbrev-file-name)
        (quietly-read-abbrev-file))

(add-hook 'text-mode-hook (lambda () (abbrev-mode 1)))
;; (add-hook 'matlab-mode-hook 'abbrev-mode)

;; Load json.el
(if (file-exists-p "~/.emacs.d/lisp/json.el")
(load-file "~/.emacs.d/lisp/json.el"))

;; Load htmlize package
(if (file-exists-p "~/git/org-mode/contrib/lisp/htmlize.el")
(load-file "~/git/org-mode/contrib/lisp/htmlize.el"))

;; Org mode setup below
(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(global-set-key "8" (quote org-capture))
(global-set-key "9" (quote org-refile))
(global-set-key "0" (quote org-agenda))
(global-set-key "8" (quote org-capture))
(global-set-key "9" (quote org-refile))

;; ... Below only works for X windows, not in terminal
;; (global-set-key (kbd "C-8") 'org-capture)
;; (global-set-key (kbd "C-9") 'org-refile)
;; (global-set-key (kbd "C-0") 'org-agenda)
;; (global-set-key (kbd "C-8") 'org-capture)
;; (global-set-key (kbd "C-9") 'org-refile)

;; Org-babel set up
(org-babel-do-load-languages
 'org-babel-load-languages
 '((R . t) (python . t) (sh . t) (sql . t) (ditaa . t) (java . t)))

;; Turn off default org-babel security
(setq org-confirm-babel-evaluate nil)

;; Turn on code highlighting in src blocks
(setq org-src-fontify-natively t)

;; Below are the old key bindings; these aren't convenient on a Macbook
;; Air keyboard
;; (global-set-key (kbd "<f12>") 'org-agenda)
;; (global-set-key (kbd "<f8>") 'org-capture)
;; (global-set-key (kbd "<f9>") 'org-refile)

;; General TODO setup
;; (setq org-todo-keywords
;;       '( (sequence "TODO" "INPROGRESS" "WAITING" "|" "DONE" "DELEGATED" )
;; 	 (sequence "|" "CANCELED" ) 
;; 	 (sequence "|" "PHONE" )
;; 	 (sequence "|" "EMAIL" )
;; 	 (sequence "|" "READING" )
;; 	 (sequence "|" "BREAK" )
;; 	 ))

;; (setq org-todo-keyword-faces
;;       '(
;;         ("TODO"  . (:foreground "firebrick2" :weight bold))
;;         ("INPROGRESS"  . (:foreground "blue" :weight bold))
;;         ("WAITING"  . (:foreground "orange" :weight bold))
;;         ("DONE"  . (:foreground "forestgreen" :weight bold))
;;         ("DELEGATED"  . (:foreground "dimgrey" :weight bold))
;;         ("CANCELED"  . (:foreground "forestgreen" :weight bold))
;;         ("PHONE"  . (:foreground "forestgreen" :weight bold))
;;         ("EMAIL"  . (:foreground "forestgreen" :weight bold))
;;         ("READING"  . (:foreground "forestgreen" :weight bold))
;;         ("BREAK"  . (:foreground "forestgreen" :weight bold))
;;         ))
(setq org-todo-keywords
      '( (sequence "TODO(t)" "INPROGRESS(i)" "WAITING(w)" "|" "DONE(d)" "DELEGATED(l)" "CANCELED(c)" )
	 ))

(setq org-todo-keyword-faces
      '(
        ("TODO"  . (:foreground "firebrick2" :weight bold))
        ("INPROGRESS"  . (:foreground "blue" :weight bold))
        ("WAITING"  . (:foreground "orange" :weight bold))
        ("DONE"  . (:foreground "forestgreen" :weight bold))
        ("DELEGATED"  . (:foreground "dimgrey" :weight bold))
        ("CANCELED"  . (:foreground "forestgreen" :weight bold))
        ))

;; Log when tasks are done so I can review timelines for projects
;; later
(setq org-log-done t)

;; Agenda-mode settings
(custom-set-variables
 '(org-agenda-files '("~/org/" "~/org/wellcentive/" "~/org/retired_projects/")
		    )
)
;; (setq org-agenda-custom-commands
;;       '(("w" "Wellcentive Data Quality Agenda"
;; 	 ((org-agenda-list)
;; 	  (org-agenda-filter-apply ,(list "+borgess_fix"))
;; 	  ))))
;; (setq org-agenda-custom-commands
;;       '(("c" "Agenda and CDC tasks"
;; 	 ((agenda "")
;; 	  (tags "+cdc+monthly+goals+january"
;;               ((org-agenda-overriding-header "Monthly Goals, January 2012")))
;; 	  (tags "refile"
;;               ((org-agenda-overriding-header "Notes and Tasks to Refile")))
;; 	  (tags-todo "+cdc/WAITING" ; I'd like only CDC waiting tasks though
;;               ((org-agenda-overriding-header "CDC Tasks started but not yet complete (WAITING)")))
;; 	  (tags-todo "cdc"
;;               ((org-agenda-overriding-header "Tasks marked for completion at the CDC")))))))


;; Column view setup to show effort estimates, etc
;; Task Effort Clock_Summary
(setq org-columns-default-format "%50ITEM(Task) %10Effort(Estimate){:} %10CLOCKSUM")
(setq org-agenda-overriding-columns-format "%50ITEM(Task) %10Effort(Estimate){:} %10CLOCKSUM")

;; Tags
;; (setq org-tag-alist '(("home" . ?h)
;; 		      ("laptop" . ?l)
;; 		      ("errand" . ?e)
;; 		      ("melissa" . ?m)
;; 		      ) )

;; org-capture setup
;; Basically using the setup from http://doc.norang.ca/org-mode.html#Capture

;; ... tasks, notes, appointments, phone calls, org-workflow.  I
;; removed the %a because the links to the original file were really
;; annoying me
(setq org-capture-templates
      (quote (("t" "General purpose todo" entry (file+headline "~/org/todo.org" "Tasks")
               "* TODO %?\n%U\n  %i" :clock-in t :clock-resume t)
	      ("w" "Wellcentive Workflow")
              ("wt" "Wellcentive todo"
              entry (file+headline "~/org/wellcentive/wellcentive.org" "Bucket")
	       "* TODO %?\n%U\n  %i" :clock-in t :clock-resume t)
              ("wn" "Wellcentive meeting note"
              entry (file+headline "~/org/wellcentive/wellcentive.org" "Meeting Notes")
               "* %? %U :note:\n  - Who: \n %i" :prepend t)
              )))

;; Refile settings
; Targets include this file and any file contributing to the agenda - up to 2 levels deep
(setq org-refile-targets (quote ((nil :maxlevel . 3)
                                 (org-agenda-files :maxlevel . 3))))

; Change these two to nil if using IDO
(setq org-refile-use-outline-path t)
(setq org-outline-path-complete-in-steps t)

;; Clock-in/Clock-out settings and configuration
; Taken from http://doc.norang.ca/org-mode.html#ClockSetup with modifications

;; Resume clocking tasks when emacs is restarted
(org-clock-persistence-insinuate)

;; Small windows on my Eee PC displays only the end of long lists which isn't very useful
;;(setq org-clock-history-length 10)
;; Resume clocking task on clock-in if the clock is open
(setq org-clock-in-resume t)
;; Change task to STARTED when clocking in
;;(setq org-clock-in-switch-to-state 'bh/clock-in-to-started)
;; Separate drawers for clocking and logs
(setq org-drawers (quote ("PROPERTIES" "LOGBOOK")))
;; Save clock data and state changes and notes in the LOGBOOK drawer
(setq org-clock-into-drawer t)
;; Sometimes I change tasks I'm clocking quickly - this removes clocked tasks with 0:00 duration
(setq org-clock-out-remove-zero-time-clocks t)
;; Clock out when moving task to a done state
(setq org-clock-out-when-done t)
;; Save the running clock and all clock history when exiting Emacs, load it on startup
(setq org-clock-persist (quote history))
;; Enable auto clock resolution for finding open clocks
(setq org-clock-auto-clock-resolution (quote when-no-clock-is-running))
;; Include current clocking task in clock reports
(setq org-clock-report-include-clocking-task t)

;; Remove empty LOGBOOK drawers on clock out
(defun bh/remove-empty-drawer-on-clock-out ()
  (interactive)
  (save-excursion
    (beginning-of-line 0)
    (org-remove-empty-drawer-at "LOGBOOK" (point))))

(add-hook 'org-clock-out-hook 'bh/remove-empty-drawer-on-clock-out 'append)

;; More logging
(setq org-log-done (quote time))
(setq org-log-into-drawer t)

;; ... Support for markdown 
;; Reference: http://jblevins.org/projects/markdown-mode/
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

