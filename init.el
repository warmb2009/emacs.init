;配置package源
(package-initialize)
 (setq package-archives '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))

;自动安装包 
(when(>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages") t)
  )
(require 'cl)
;;add whatever packages you want here
(defvar linkin/packages '(
			  company
			  monokai-theme
			  hungry-delete
			  counsel
			  swiper
			  smartparens
			  js2-mode
			  nodejs-repl
			  graphviz-dot-mode
			  android-mode
			  ) "Default packages")

(defun linkin/packages-installed-p ()
  (loop for pkg in linkin/packages
	when (not (package-installed-p pkg)) do (return nil)
	finally (return t)))
(unless (linkin/packages-installed-p)
  (message "%s" "Refreshing package database...")
  (package-refresh-contents)
  (dolist (pkg linkin/packages)
    (when (not (package-installed-p pkg))
      (package-install pkg))))

;关闭 tool-bar scroll-bar
(tool-bar-mode -1)
(scroll-bar-mode -1)

;关闭启动画面
(setq inhibit-splash-screen t)

;显示行号
(global-linum-mode t)
(require 'erc)
;F2键 打开配置文件
(defun open-my-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(global-set-key (kbd "<f2>") 'open-my-init-file)

;(recentf-mode t)
;
(global-auto-revert-mode t)

(global-set-key (kbd "<f8>") 'loop-alpha)  ;;注意这行中的F8 , 可以改成你想要的按键    
    
(setq alpha-list '((85 55) (100 100)))    
    
(defun loop-alpha ()    
  (interactive)    
  (let ((h (car alpha-list)))                    
    ((lambda (a ab)    
       (set-frame-parameter (selected-frame) 'alpha (list a ab))    
       (add-to-list 'default-frame-alist (cons 'alpha (list a ab)))    
       ) (car h) (car (cdr h)))    
    (setq alpha-list (cdr (append alpha-list (list h))))    
    )    
  )
;加入简单的自动补全
(global-company-mode t)

;关闭自动备份
(setq make-backup-files nil)

;org文件内部添加语法高亮
(require 'org)
(setq org-src-fontify-natively t)

;加入最近打开
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;hungry-mode
(require 'hungry-delete)
(global-hungry-delete-mode)

;选择删除
(delete-selection-mode t)
;括号高亮匹配
(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)
(global-hl-line-mode t)

;设置光标类型
(setq-default cursor-type 'bar)


;;;;;配置输入法
;(require 'chinese-pyim)
;(require 'chinese-pyim-basedict)
;(chinese-pyim-basedict-enable)
;(require 'chinese-pyim-greatdict)
;(chinese-pyim-greatdict-enable)


;(setq default-input-method "chinese-pyim")
;(global-set-key (kbd "C-\\") 'toggle-input-method)
;(add-hook 'org-mode-hook (lambda () (setq truncate-lines nil)))

;;================================ 
;;为我的emacs配置主题色彩 (color-theme-色彩名称) 
;;================================ 
;(require 'color-theme) 
;(color-theme-initialize) 
;(color-theme-gnome)
(load-theme 'monokai t)
;;;;;Python
(elpy-enable)
;;;;; Android

(require 'android-mode)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(android-mode-avd "test")
 '(android-mode-builder (quote gradle))
 '(android-mode-sdk-dir "~/.buildozer/android/platform/android-sdk-20")
 '(company-idle-delay 0.08)
 '(company-minimum-prefix-length 1)
 '(custom-safe-themes
   (quote
    ("a49760e39bd7d7876c94ee4bf483760e064002830a63e24c2842a536c6a52756" default)))
 '(package-selected-packages
   (quote
    (flymake-python-pyflakes py-yapf py-autopep8 go-mode w3m kotlin-mode hungry-delete smartparens popwin nodejs-repl monokai-theme js2-mode elpy color-theme chinese-pyim-greatdict chinese-pyim)))
 '(safe-local-variable-values (quote ((conding . utf-8)))))
;;
;;set js mode
;(setq auto-mode-alist
;     (append
;       '(("\\.js\\" . js2-mode))
;       auto-mode-alist))

;;config smex
;(global-set-key (kbd "M-x") 'smex)

;;config swiper
;;搜索增强

(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)

;;寻找命令
;;
(global-set-key (kbd "C-h C-f") 'find-function)
(global-set-key (kbd "C-h C-v") 'find-variable)
(global-set-key (kbd "C-h C-k") 'find-function-on-key)

;自定义变量值

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(require 'smartparens-config)
(smartparens-global-mode t)
;;comfig js files
(setq auto-mode-alist
     (append
      '(("\\.js\\'" . js2-mode))
      auto-mode-alist))

(require 'nodejs-repl)

(setq org-agenda-files '("~/Org"))
(global-set-key (kbd "C-c a") 'org-agenda)
(require 'popwin)
(popwin-mode t)


