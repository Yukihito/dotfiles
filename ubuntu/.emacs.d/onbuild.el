(defun set-exec-path-from-shell-PATH ()
    (interactive)
    (let ((path-from-shell (replace-regexp-in-string "[ \t\n]*$" "" (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
      (setenv "PATH" path-from-shell)
      (setq exec-path (append exec-path (split-string path-from-shell path-separator)))))

(set-exec-path-from-shell-PATH)

(require 'package)
(add-to-list 'package-archives
	     '("melpa-stable" . "https://stable.melpa.org/packages/") t)

; (add-to-list 'package-archives
;	     '("marmalade" . "http://marmalade-repo.org/packages/"))

(add-to-list 'package-archives
	     '("ELPA" . "http://tromey.com/elpa/"))

(add-to-list 'package-archives
	     '("gnu" . "http://elpa.gnu.org/packages/"))
(package-initialize)
(require 'cl)
(defvar installing-packages
  '(
    auto-complete
    undo-tree
    magit
    helm
    helm-ag
    powerline
    ))

(let ((not-installed-packages (loop for package in installing-packages
                                    when (not (package-installed-p package))
                                    collect package)))
  (when (/= (length not-installed-packages) 0)
    (package-refresh-contents)
    (dolist (package not-installed-packages)
      (package-install package))))
