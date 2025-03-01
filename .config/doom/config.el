;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(when (eq system-type 'windows-nt)
  (setq doom-font (font-spec :family "HackGen Console NF" :size 30 :weight 'regular)
        doom-variable-pitch-font (font-spec :family "HackGen Console NF" :size 31)))

(when (eq system-type 'darwin)
  (setq doom-font (font-spec :family "HackGen Console NF" :size 20 :weight 'regular)
        doom-variable-pitch-font (font-spec :family "HackGen Console NF" :size 21)))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-tokyo-night)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Dropbox/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

; 起動時の画面サイズ
(setq default-frame-alist
      (append (list
               '(width . 100)
               '(height . 50))))

; 行間
(setq-default line-spacing 5)

; 折り返し
;; reference: https://zenn.dev/ebang/articles/231106_emacs-markdown
;; 以下2つはword-wrap-modeを活かすために必要だが、デフォルトの動作が記述の通りなので指定する必要なし
;; (auto-fill-mode -1)
;; (global-visual-line-mode t)
(global-word-wrap-whitespace-mode t)
(add-to-list 'word-wrap-whitespace-characters ?\])

; 挿入する曜日表記を英語に
(setq system-time-locale "C")

; flycheck
;; (setq flycheck-checker-error-threshold 1000)

; org-capture
(define-key global-map (kbd "C-c c") 'org-capture)
(define-key global-map (kbd "C-c t")
  (lambda () (interactive) (org-capture nil "t")))
(define-key global-map (kbd "C-c s")
  (lambda () (interactive) (org-capture nil "s")))
(define-key global-map (kbd "C-c i")
  (lambda () (interactive) (org-capture nil "i")))
(define-key global-map (kbd "C-c j")
  (lambda () (interactive) (org-capture nil "j")))
(define-key global-map (kbd "C-c l")
  (lambda () (interactive) (org-capture nil "l")))
(after! org
  (setq org-capture-templates
        ; see References
        ; https://orgmode.org/manual/Template-elements.html
        ; https://doc.endlessparentheses.com/Var/org-refile-targets.html
        '(("t" "Todo" entry (file+headline "inbox.org" "Inbox")
           "* TODO %?\n%i"
           :refile-targets ((+org-capture-journal-file :regexp . "Task")))
          ("s" "Scraps" entry (file+headline "scrap.org" "Inbox")
           "* %?\n%i"
           :prepend t
           :refile-targets ((+org-capture-notes-file :level . 1)))
          ("i" "warikomi" entry (file+function +org-capture-journal-file
                (lambda ()
                  (org-datetree-find-date-create (org-date-to-gregorian (org-today)) t)
                  (let ((year (nth 2 (org-date-to-gregorian (org-today))))
                        (month (car (org-date-to-gregorian (org-today))))
                        (day (nth 1 (org-date-to-gregorian (org-today)))))
                    (setq match (re-search-forward (format "^\\*+[ \t]+%d-%02d-%02d \\w+\n\\*+[ \t]+Task$" year month day) nil t))
                    (cond
                     ((not match)
                      (beginning-of-line 2)
                      (insert "* ")
                      (org-do-demote)
                      (org-do-demote)
                      (org-do-demote)
                      (insert "Task\n")
                      (insert "* ")
                      (org-do-demote)
                      (org-do-demote)
                      (org-do-demote)
                      (insert "Log")
                      )
                     (t
                      nil)))
                  (re-search-backward "^\\*.+ Task" nil t)
                ))
           "* DONE %?"
           :clock-in t
           :clock-resume t
           ;; :time-prompt t
           :jump-to-captured t)
          ("j" "Journal Tasks" entry (file+function +org-capture-journal-file
                (lambda ()
                  (org-datetree-find-date-create (org-date-to-gregorian (org-today)) t)
                  (let ((year (nth 2 (org-date-to-gregorian (org-today))))
                        (month (car (org-date-to-gregorian (org-today))))
                        (day (nth 1 (org-date-to-gregorian (org-today)))))
                    (setq match (re-search-forward (format "^\\*+[ \t]+%d-%02d-%02d \\w+\n\\*+[ \t]+Task$" year month day) nil t))
                    (cond
                     ((not match)
                      (beginning-of-line 2)
                      (insert "* ")
                      (org-do-demote)
                      (org-do-demote)
                      (org-do-demote)
                      (insert "Task\n")
                      (insert "* ")
                      (org-do-demote)
                      (org-do-demote)
                      (org-do-demote)
                      (insert "Log")
                      )
                     (t
                      nil)))
                  (re-search-backward "^\\*.+ Task" nil t)
                ))
           "* TODO %?"
           :clock-in t
           :clock-keep t
           ;; :time-prompt t
           :jump-to-captured t)
          ("l" "Journal Logs" entry (file+function +org-capture-journal-file
                (lambda ()
                  (org-datetree-find-date-create (org-date-to-gregorian (org-today)) t)
                  (let ((year (nth 2 (org-date-to-gregorian (org-today))))
                        (month (car (org-date-to-gregorian (org-today))))
                        (day (nth 1 (org-date-to-gregorian (org-today)))))
                    (setq match (re-search-forward (format "^\\*+[ \t]+%d-%02d-%02d \\w+\n\\*+[ \t]+Task$" year month day) nil t))
                    (cond
                     ((not match)
                      (beginning-of-line 2)
                      (insert "* ")
                      (org-do-demote)
                      (org-do-demote)
                      (org-do-demote)
                      (insert "Task\n")
                      (insert "* ")
                      (org-do-demote)
                      (org-do-demote)
                      (org-do-demote)
                      (insert "Log")
                      )
                     (t
                      nil)))
                  (re-search-forward "^\\*.+ Log" nil t)
                ))
           "* %<%H:%M> %?")

          ;; '(("t" "Personal todo" entry (file+headline +org-capture-todo-file "Inbox")
          ;;    "* [ ] %?\n%i\n%a" :prepend t)
          ;; ("n" "Notes" entry (file+headline +org-capture-notes-file "Inbox")
          ;;  "* %?\n%i\n%a" :prepend t)
          ;; ("j" "Journal" entry (file+olp+datetree +org-capture-journal-file)
          ;;  "* %U %?\n%i\n%a")

          ;; ;; Will use {project-root}/{todo,notes,changelog}.org, unless a
          ;; ;; {todo,notes,changelog}.org file is found in a parent directory.
          ;; ;; Uses the basename from `+org-capture-todo-file',
          ;; ;; `+org-capture-changelog-file' and `+org-capture-notes-file'.
          ;; ("p" "Templates for projects")
          ;; ("pt" "Project-local todo" entry  ; {project-root}/todo.org
          ;;  (file+headline +org-capture-project-todo-file "Inbox")
          ;;  "* TODO %?\n%i\n%a" :prepend t)
          ;; ("pn" "Project-local notes" entry  ; {project-root}/notes.org
          ;;  (file+headline +org-capture-project-notes-file "Inbox")
          ;;  "* %U %?\n%i\n%a" :prepend t)
          ;; ("pc" "Project-local changelog" entry  ; {project-root}/changelog.org
          ;;  (file+headline +org-capture-project-changelog-file "Unreleased")
          ;;  "* %U %?\n%i\n%a" :prepend t)

          ;; ;; Will use {org-directory}/{+org-capture-projects-file} and store
          ;; ;; these under {ProjectName}/{Tasks,Notes,Changelog} headings. They
          ;; ;; support `:parents' to specify what headings to put them under, e.g.
          ;; ;; :parents ("Projects")
          ;; ("o" "Centralized templates for projects")
          ;; ("ot" "Project todo" entry
          ;;  (function +org-capture-central-project-todo-file)
          ;;  "* TODO %?\n %i\n %a"
          ;;  :heading "Tasks"
          ;;  :prepend nil)
          ;; ("on" "Project notes" entry
          ;;  (function +org-capture-central-project-notes-file)
          ;;  "* %U %?\n %i\n %a"
          ;;  :heading "Notes"
          ;;  :prepend t)
          ;; ("oc" "Project changelog" entry
          ;;  (function +org-capture-central-project-changelog-file)
          ;;  "* %U %?\n %i\n %a"
          ;;  :heading "Changelog"
          ;;  :prepend t)))

  ; org-refile
  (setq org-refile-targets '(("inbox.org" :maxlevel 2)
                             (+org-capture-notes-file :maxlevel 2)
                             (+org-capture-journal-file :maxlevel 2)))

  ; textlintを止める
  (global-flycheck-mode -1)

  ;; コードブロックのシンタックスハイライトが効かないときに試す
  ;; (org-babel-do-load-languages
  ;;  'org-babel-load-languages
  ;;  '(
  ;;    (shell . t)
  ;;    )
  ;;  )
  ;;
)
