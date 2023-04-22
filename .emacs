;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; EMACS Init File
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(package-initialize)

;;;*** General Config ***;;;
(setq standard-indent 3)              ; Set indent to 3 spaces
(setq scroll-step 1)                  ; Scroll line by line
(setq make-backup-files nil)          ; disable backup creation
(setq auto-save-default nil)          ; disable auto-save
(setq inhibit-startup-message t)      ; No Startup Message
(setq ring-bell-function 'ignore)     ; sounds off
(global-font-lock-mode t)             ; turn on font-lock mode
(setq next-line-add-newlines nil)     ; stop at the end of the file, not just add lines
;(mouse-wheel-mode t)                  ; Enable mouse wheel scrolling

;;;*** Display Settings ***;;;

; Text Size
(set-face-attribute 'default nil :height 95)
(set-face-attribute 'default nil :width 'ultra-expanded)

; Screen Properties
(set-foreground-color "white")       ; to set foreground color to white
(set-background-color "black")       ; to set background color to black
(set-cursor-color "green")           ; Set cursor color
(set-mouse-color "white")            ; Set mouse color

; Display date and time in status bar
(setq display-time-day-and-date t
     display-time-24hr-format t)
(display-time)

;set default to lines not wrapping
(set-default 'truncate-lines t)

;(tool-bar-mode -1)                   ; turn off icon bar
;(set-scroll-bar-mode 'right)         ; scroll bar on the right

;;;***********************;;;

;;;*** Navigation Keys ***;;;

(global-set-key [kp-home]  'beginning-of-buffer) ;[Home]
(global-set-key [home]     'beginning-of-buffer) ;[Home]
(global-set-key [kp-end]   'end-of-buffer)       ;[End]
(global-set-key [end]      'end-of-buffer)       ;[End]

;(global-set-key [kp-prior] 'my-scroll-down)      ;[PgUp]
;(global-set-key [prior]    'my-scroll-down)      ;[PgUp]
;(global-set-key [kp-next]  'my-scroll-up)        ;[PgDn]
;(global-set-key [next]     'my-scroll-up)        ;[PgDn]

(defun my-scroll-down ()
   (interactive)
   (setq this-command 'next-line)
   (next-line 4)
)

(defun my-scroll-up ()
   (interactive)
   (setq this-command 'previous-line)
   (previous-line 4)
)

(global-set-key "\M-n"  (lambda () (interactive) (scroll-up   4)) ) ; scroll w/o point
(global-set-key "\M-p"  (lambda () (interactive) (scroll-down 4)) )

;use M-up/down to view previous/next commands in emacs shell
;(define-key comint-mode-map [M-up]   'comint-previous-input)
;(define-key comint-mode-map [M-down] 'comint-next-input)

(global-set-key "\M-\C-p"  'my-scroll-up)    ; scroll w/ point
(global-set-key "\M-\C-n"  'my-scroll-down)

;;*** New Command Bindings ***;;;

;; Set up the keyboard so the delete key on both the regular keyboard
;; and the keypad delete the character under the cursor and to the right
;; under X, instead of the default, backspace behavior.
(global-set-key [delete] 'delete-char)
(global-set-key [kp-delete] 'delete-char)

; some other nice features
(global-set-key "\C-x\C-e" 'revert-buffer)
(global-set-key "\C-x\C-b" 'electric-buffer-list)
(global-set-key "\C-z" 'undo)

;use scroll wheel to change text size
(global-set-key [C-mouse-4] 'text-scale-increase)
(global-set-key [C-mouse-5] 'text-scale-decrease)

;mouse wheel
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ; one line at a time
(setq mouse-wheel-progressive-speed nil)            ; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't)                  ; scroll window under mouse
(setq scroll-step 1)                                ; keyboard scroll one line at a time

;f5 to refresh buffer
(defun revert-buffer-no-confirm ()
  "Revert buffer without confirmation."
  (interactive) (revert-buffer t t))
(global-set-key [f5] 'revert-buffer-no-confirm)


;;;****************;;;

;; Function to delete a line ;;
(defvar previous-column nil "Save the column position")
(defun nuke-line()
  "Kill and entire line, including the trailing newline character" 
  (interactive)
  (setq previous-column (current-column))
  (end-of-line)
  (if (= (current-column) 0)
      (delete-char 1)
    (progn
      (beginning-of-line)
      (kill-line)
      (delete-char 1)jeff
      (move-to-column previous-column))))
;(global-set-key "\C-d" 'nuke-line)

; verilog mode
(autoload 'verilog-mode "verilog-mode" "Verilog mode" t )
(setq verilog-auto-newline nil)
(setq verilog-linter "cn_lint")

;(require 'comint)
; passwords not shown
;(setq comint-password-prompt-regexp
;      (concat comint-password-prompt-regexp
;              "\\|^Password for .*:\\s *\\'"))


; emacs package manager
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (magit))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(global-set-key (kbd "C-x g") 'magit-status)
