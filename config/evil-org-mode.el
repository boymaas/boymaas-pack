(live-add-pack-lib "evil-org-mode")

(require 'evil-org)

;; bmaas: we cannot require here. It will load org-requires out of
;;        installation install
;(require 'org)
;(require 'org-agenda)
;(require 'org-install)

(require 'org-table)

(require 'cal-move)

;; Enable fontlocking etc for org mode ..
;(require 'hideshow-org)

;; Standard org directory and a directory to
;; append the path after.
(setq org-directory "~/Sites/planning/")
(defun org-path (fname)
  (concat org-directory fname))


(define-key evil-normal-state-map ";oo" 'org-open-at-point)

(define-key evil-normal-state-map ";ol" 'org-store-link)
(define-key evil-normal-state-map ";oL" 'org-insert-link)
(define-key evil-normal-state-map ";oa" 'org-agenda)

;(define-key org-mode-map "\t" 'org-indent-line-function)
(setq org-log-done t)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(add-to-list 'auto-mode-alist '("\\.gtd$" . org-mode))


;; undefine keys for org-mode-map, conflicting with winmove
(set-key org-mode-map (kbd "<S-right>") nil)
(set-key org-mode-map (kbd "<S-left>") nil)
(set-key org-mode-map (kbd "<S-up>") nil)
(set-key org-mode-map (kbd "<S-down>") nil)

;; clockcum format for org-agenda-report
(setq org-time-clocksum-format (quote (:hours "%d" :require-hours t :minutes ":%02d" :require-minutes t)))

(setq org-completion-use-ido t)

(setq org-startup-indented nil)
(setq org-adapt-indentation t)

; Refile targets include this file and any file contributing to the agenda - up to 5 levels deep
(setq org-refile-targets (quote ((nil :maxlevel . 2) (org-agenda-files :maxlevel . 2))))
; Targets start with the file name - allows creating level 1 tasks
(setq org-refile-use-outline-path (quote file))
; Targets complete in steps so we start with filename, TAB shows the next level of targets etc
;(setq org-outline-path-complete-in-steps t)


(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "STARTED(s)" "|" "DONE(d!/!)")
              (sequence "WAITING(w@/!)" "SOMEDAY(S)" "PROJECT(P@)" "|" "CANCELLED(c@/!)"))))


(require 'org-clock)
(require 'org-remember)

;; Resume clocking tasks when emacs is restarted
(org-clock-persistence-insinuate)
;;
;; Yes it's long... but more is better ;)
(setq org-clock-history-length 35)
;; Resume clocking task on clock-in if the clock is open
(setq org-clock-in-resume t)
;; Change task state to STARTED when clocking in
(setq org-clock-in-switch-to-state "STARTED")
;; Save clock data and notes in the LOGBOOK drawer
(setq org-clock-into-drawer t)
;; Sometimes I change tasks I'm clocking quickly - this removes clocked tasks with 0:00 duration
(setq org-clock-out-remove-zero-time-clocks t)
;; Don't clock out when moving task to a done state
(setq org-clock-out-when-done nil)
;; Save the running clock and all clock history when exiting Emacs, load it on startup
(setq org-clock-persist 'history)

;; org-checklist functionality
(eval-after-load "org"
  '(require 'org-checklist))

(evil-define-key 'normal evil-org-mode-map
  ";oc" 'org-toggle-checkbox)

(require 'remember)

;; (org-remember-insinuate) ;; see below
;; insinuate didn't word zo there 3 rows are a quick workaround
(setq remember-annotation-functions '(org-remember-annotation))
(setq remember-handler-functions '(org-remember-handler))
(add-hook 'remember-mode-hook 'org-remember-apply-template)

;; the remember templates

;;     %^{prompt}  prompt the user for a string and replace this sequence with it.
;;                 You may specify a default value and a completion table with
;;                 %^{prompt|default|completion2|completion3...}
;;                 The arrow keys access a prompt-specific history.
;;     %a          annotation, normally the link created with org-store-link
;;     %A          like %a, but prompt for the description part
;;     %i          initial content, the region when remember is called with C-u.
;;                 The entire text will be indented like %i itself.
;;     %t          timestamp, date only
;;     %T          timestamp with date and time
;;     %u, %U      like the above, but inactive timestamps
;;     %^t         like %t, but prompt for date.  Similarly %^T, %^u, %^U
;;                 You may define a prompt like %^{Birthday}t
;;     %n          user name (taken from user-full-name)
;;     %c          Current kill ring head.
;;     %x          Content of the X clipboard.
;;     %^C         Interactive selection of which kill or clip to use.
;;     %^L         Like %^C, but insert as link.
;;     %^g         prompt for tags, with completion on tags in target file.
;;     %k          title of currently clocked task
;;     %K          link to currently clocked task
;;     %^G         prompt for tags, with completion all tags in all agenda files.
;;     %^{prop}p   Prompt the user for a value for property prop
;;     %:keyword   specific information for certain link types, see below
;;     % [file]     insert the contents of the file given by file
;;     % (sexp)     evaluate Elisp sexp and replace with the result
;;     %!          immediately store note after completing the template
;;                 (skipping the C-c C-c that normally triggers storing)
;;     %&          jump to target location immediately after storing note

(setq org-remember-templates
     '(
      ("Todo" ?t "* TODO %^{Brief Description} %^g\n%?\nAdded: %U\nLink: %a" "~/Sites/planning/gtd.org" "Refile")
      ("Journal" ?j "\n* %^{topic} %T \n%i%c%?\nLink: %a\n" "~/Sites/planning/journal.org")
      ("Note" ?n "\n* %^{topic} %T \n%i%?\n" "~/Sites/planning/gtd.org" "Notes")
      ("Someday" ?s "\n* %^{topic} %T \n%i%?\n" "~/Sites/planning/gtd.org")
      ))

(define-key evil-normal-state-map ";or" 'org-remember)

;; some handy settings
(setq org-timeline-show-empty-dates t)
(setq org-insert-mode-line-in-empty-file t)

;; Where to put the refile trees
;;(setq org-refile-targets (quote (("~/Planning/gtd.gtd" :maxlevel . 1) ("~/Planning/notes.gtd" :level . 2))))
(setq org-refile-targets (quote ( (org-agenda-files :maxlevel . 5) (nil :maxlevel . 5))))

;; some fast access to the agendas custom commands
(setq org-agenda-custom-commands
      (quote (("P" "Projects" tags "/!PROJECT" ((org-use-tag-inheritance nil)))
              ("s" "Started Tasks" todo "STARTED" ((org-agenda-todo-ignore-with-date nil)))
              ("c" "Active Project" tags-todo "active&boy" ((org-agenda-todo-ignore-with-date nil)))
              ("w" "Tasks waiting on something" tags "WAITING" ((org-use-tag-inheritance nil)))
              ("r" "Refile New Notes and Tasks" tags "@refile" ((org-agenda-todo-ignore-with-date nil)))
              ("d" "Daily Overview"
               ((agenda)
                (tags-todo "@refile")
                (tags-todo "@tasks")
                (todo "TODO")
                (tags "@daily+LEVEL=2/-DONE")
                (tags-todo "@shopping")))
              ("n" "Notes" tags "note" nil))))
;; (setq org-agenda-custom-commands
;;       '(
;;         ("P" "Projects"
;;          ((tags "project")))
;;         ("H" "Office and Home Lists"
;;          ((agenda)
;;           (tags-todo "office")
;;           (tags-todo "home")
;;           (tags-todo "computer")
;;           (tags-todo "dvd")
;;           (tags-todo "reading")))

;;         ("D" "Daily Action List"
;;          (
;;           (agenda "" ((org-agenda-ndays 1)
;;                       (org-agenda-sorting-strategy
;;                        (quote ((agenda time-up priority-down tag-up) )))
;;                       (org-deadline-warning-days 0) ))))))


;; quick access function to our todo file
(defun gtd ()
    (interactive)
    (find-file (org-path "gtd.org")))
(defun journal ()
    (interactive)
    (find-file (org-path "journal.org")))
;; and a global shortcut for it
(define-key evil-normal-state-map ";og" 'gtd)
(define-key evil-normal-state-map ";oj" 'journal)

; Set default column view headings: Task Effort Clock_Summary
(setq org-columns-default-format "%80ITEM(Task) %10Effort(Effort){:} %10CLOCKSUM")
; global Effort estimate values
(setq org-global-properties (quote (("Effort_ALL" . "0:10 0:30 1:00 2:00 3:00 4:00 5:00 6:00 8:00 12:00 16:00 20:00 24:00"))))


; Erase all reminders and rebuilt reminders for today from the agenda
(defun my-org-agenda-to-appt ()
  (interactive)
  (setq appt-time-msg-list nil)
  (org-agenda-to-appt))

; Rebuild the reminders everytime the agenda is displayed
(add-hook 'org-finalize-agenda-hook 'my-org-agenda-to-appt)

; This is at the end of my .emacs - so appointments are set up when Emacs starts
(my-org-agenda-to-appt)

; Activate appointments so we get notifications
(appt-activate t)

; If we leave Emacs running overnight - reset the appointments one minute after midnight
(run-at-time "24:01" nil 'my-org-agenda-to-appt)

; some extra configs
(add-hook 'org-agenda-mode-hook '(lambda () (hl-line-mode 1)))

;; Include agenda archive files when searching for things
(setq org-agenda-text-search-extra-files (quote (agenda-archives)))

;; Agenda view tweaks

;; Show all future entries for repeating tasks
(setq org-agenda-repeating-timestamp-show-all t)

;; Show all agenda dates - even if they are empty
(setq org-agenda-show-all-dates t)

;; Sorting order for tasks on the agenda
(setq org-agenda-sorting-strategy
      (quote ((agenda time-up priority-down effort-up category-up)
              (todo priority-down)
              (tags priority-down))))

;; Start the weekly agenda today
(setq org-agenda-start-on-weekday nil)

;; Disable display of the time grid
;(setq org-agenda-time-grid
;      (quote (nil "----------------"
;                  (800 1000 1200 1400 1600 1800 2000))))

;; custom keys
(define-key org-agenda-keymap (kbd "w") 'org-agenda-refile)

;; (backing-up policy)
(run-at-time "00:59" 3600 'org-save-all-org-buffers)

;; Publishing
;(require 'org-publish)
;(require 'org-exp)

(setq org-publish-project-alist
      '(("fortunebet"
         ;; Path to your org files.
         :base-directory "~/Sites/planning/"
         :base-extension "NON-EXISTING"
         :include [ "fortunebet.org" ]
         :recursive nil
         :publishing-function org-html-publish-to-html
         ;; Path to your publishing directory.
         :publishing-directory "/ssh:framino@framino:~/public"
         :headline-levels 5
         )))

;; strange thing this has to be set to nil otherwise
;; export won't happen
(setq org-export-copy-to-kill-ring nil)

(provide 'init-org)
