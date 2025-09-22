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
(cond
 ((eq system-type 'darwin)
  (setq doom-font (font-spec :family "HackGen Console NF" :size 20 :weight 'regular)
        doom-variable-pitch-font (font-spec :family "HackGen Console NF" :size 21)))
 (t
  (setq doom-font (font-spec :family "HackGen Console NF" :size 27 :weight 'regular)
        doom-variable-pitch-font (font-spec :family "HackGen Console NF" :size 28))))

;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-opera-light)
(add-hook 'doom-load-theme-hook
  (lambda ()
    (set-face-attribute 'org-link nil
      :foreground "gray59"
      :underline t
      :weight 'normal)))

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

; orgファイルのtextlintのために追加
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)
(setq-default buffer-file-coding-system 'utf-8)
(setq-default coding-system-for-write 'utf-8)
(setq-default coding-system-for-read 'utf-8); projectileのキャッシュファイル文字化けに対応

; org繰り返すタスクの完了ログを無効
(setq org-log-repeat nil)

; 起動時の画面サイズ
(setq default-frame-alist
      '((width . 120)
        (height . 50)))

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

; インラインコードなどの記号を非表示
(setq org-hide-emphasis-markers t)

; org-clockの計測中ファイルの場所を定義
(setq org-clock-persist-file "~/Dropbox/org/org-clock-save.el")
(setq org-clock-persist 'history
      org-clock-persist-query-resume t) ; 起動時に自動再開を確認
(org-clock-persistence-insinuate)

; flycheck
(setq flycheck-checker-error-threshold 2000)
; textlintを止める
(setq flycheck-global-modes nil)
; textlintの実行パス
(setq flycheck-textlint-executable
      (expand-file-name
       "scoop/apps/nvm/current/nodejs/nodejs/textlint.cmd"
       (getenv "HOME")))
(setq flycheck-textlint-config "~/Dropbox/org/.textlintrc.js")
; flycheckのテンポラリファイルの文字化け対応（日本語をアンダーバーに置換）
(after! flycheck
  (advice-add 'flycheck-temp-file-system :around
              (lambda (orig filename)
                (let* ((base (file-name-nondirectory filename))
                       (safe-base (replace-regexp-in-string "[^[:ascii:]]" "_" base)))
                  (funcall orig safe-base)))))

(map! :map override
      :n "C-h" #'evil-window-left
      ; C-hはSPC hで代用可能
      :n "C-j" #'evil-window-down
      :n "C-k" #'evil-window-up
      :n "C-l" #'evil-window-right
      :n "C-q" #'evil-window-delete
      :n "S-<left>" #'evil-window-decrease-width
      :n "S-<right>" #'evil-window-increase-width
      :n "S-<up>" #'evil-window-decrease-height
      :n "S-<down>" #'evil-window-increase-height)

(map!
 :leader
 :desc "Toggle Treemacs"
 "e" #'treemacs)

(map!
 :prefix "C-c"
 "t" (lambda () (interactive) (org-capture nil "t"))
 "i" (lambda () (interactive) (org-capture nil "i"))
 "j" (lambda () (interactive) (org-capture nil "j"))
 "l" (lambda () (interactive) (org-capture nil "l"))
 "n l" 'org-roam-buffer-toggle
 "n f" 'org-roam-node-find
 "n g" 'org-roam-ui-mode
 "n i" 'org-roam-node-insert
 "n c" 'org-roam-capture
 "c i" 'org-clock-in
 "c o" 'org-clock-out
 "c r" 'org-clock-report
 )

(after! org
  ; org-refile
  (setq org-refile-targets '(("inbox.org" :maxlevel 2)
                        (+org-capture-journal-file :maxlevel 2)))

  ; org-capture
  (setq org-capture-templates
      '(("t" "Todo" entry (file+headline "inbox.org" "Inbox")
         "* TODO %?\n%i"
        :refile-targets ((+org-capture-journal-file :regexp . "Task")))
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
                (insert "Log")) (t
                nil)))
                (re-search-backward "^\\*.+ Task" nil t)
        ))
        "* DONE %?"
        :clock-in t
        :clock-resume t
        ;; :time-prompt t
        :jump-to-captured t)
        ("j" "Journal" plain (file+datetree +org-capture-journal-file)
        nil
        :time-prompt t
        :immediate-finish t
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
        "* %<[%H:%M]> %?"
        :jump-to-captured nil)
        ))

  (defun my/org-insert-today-clocktable ()
    "Insert a clocktable for today's subtree, with no indent."
    (interactive)
    (let ((org-clocktable-indent-string ""))
      (save-excursion
        ;; Move to heading start (in case point is mid-subtree)
        (org-back-to-heading t)
        ;; Insert clocktable block
        (insert "#+BEGIN: clocktable :scope (\"inbox.org\" \"journal.org\") :maxlevel 6 :compact t :block today\n")
        (insert (format "#+CAPTION: Clock summary at [%s], for %s.\n"
                        (format-time-string "%Y-%m-%d %a %H:%M")
                        (format-time-string "%A, %B %d, %Y")))
        (insert "#+END:\n")
        ;; Generate the report
        (forward-line -3) ; move cursor to the BEGIN line
        (org-dblock-update))))

  ;; キーバインドを C-c r に割り当て（org-mode 限定）
  (map! :map org-mode-map
        "C-c r" #'my/org-insert-today-clocktable)

  (defun my/org-open-at-point-horizontal ()
    "必ず左右分割で別ウィンドウに開く。"
    (interactive)
    (unless (window-in-direction 'right)
      (split-window-right))
    (other-window 1)
    (org-open-at-point))

  ;; 例: S-Enter を左右分割に
  (map! :map org-mode-map
        :n "S-<return>" #'my/org-open-at-point-horizontal)
)

(after! evil
  ;; Evilの角括弧プレフィックスを無効化
  (define-key evil-motion-state-map (kbd "[") nil)
  (define-key evil-motion-state-map (kbd "]") nil))

(after! org
  ;; Orgで単体バインド
  (evil-define-key 'normal org-mode-map
    (kbd "[") #'org-previous-visible-heading
    (kbd "]") #'org-next-visible-heading))

;; コードブロックのシンタックスハイライトが効かないときに試す
;; (org-babel-do-load-languages
;;  'org-babel-load-languages
;;  '(
;;    (shell . t)
;;    )
;;  )

(use-package! org-roam
  :config
  (org-roam-db-autosync-mode)
  (setq org-roam-completion-everywhere nil)
  (setq org-roam-capture-templates
      '(("f" "Fleeting(一時メモ)" plain "%?"
         :target (file+head "fleeting/%<%Y%m%d%H%M%S>-${slug}.org" "#+TITLE: ${title}\n")
         :unnarrowed t)
        ("l" "Literature(文献)" plain "%?"
         :target (file+head "literature/%<%Y%m%d%H%M%S>-${slug}.org" "#+TITLE: ${title}\n")
         :unnarrowed t)
        ("p" "Permanent(記事)" plain "%?"
         :target (file+head "permanent/%<%Y%m%d%H%M%S>-${slug}.org" "#+TITLE: ${title}\n")
         :unnarrowed t)
        ("s" "Structure(まとめ)" plain "%?"
         :target (file+head "structure/%<%Y%m%d%H%M%S>-${slug}.org" "#+TITLE: ${title}\n")
         :unnarrowed t)
        ("b" "Blog(ブログ)" plain "%?"
         :target (file+head "blog/%<%Y%m%d%H%M%S>-${slug}.org" "#+TITLE: ${title}\n")
         :unnarrowed t)))
  (require 'org-roam-protocol))

(use-package! org-roam-ui
  :after org-roam
  ;; :hook (org-roam-mode . org-roam-ui-mode)
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))

(use-package! org-download
  :after org
  :config
  (setq-default org-download-image-dir "./images"
        org-download-heading-lvl nil
        org-download-screenshot-method "magick clipboard: %s"
        org-download-annotate-function (lambda (_) "")))

(use-package! ox-zenn
  :after ox
  :config
  (require 'ox-zenn)
  (add-to-list 'org-export-backends 'zenn))

;; org-sidebar は遅延ロードでOK
(use-package! org-sidebar
  :commands (org-sidebar-tree-toggle org-sidebar-toggle)
  :config
  (setq org-sidebar-tree-jump-fn #'org-sidebar-tree-jump-source)
  (setq org-sidebar-tree-side 'right))

;; SPC o で見出しツリーをサイドバー表示/非表示
(map! :leader
      :desc "Org Sidebar (headings)"
      "o" #'org-sidebar-tree-toggle)

;; Treemacs がロードされた後にペイン移動のショートカットが消える問題への対処
(after! treemacs
  (map! :map treemacs-mode-map
        "C-h" #'evil-window-left
        "C-j" #'evil-window-down
        "C-k" #'evil-window-up
        "C-l" #'evil-window-right
        "C-q" #'evil-window-delete
        "S-<return>" #'treemacs-visit-node-horizontal-split))
