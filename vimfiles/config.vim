vim9script

set nu
set cin
set nobackup
set noundofile
set smartindent
set nocompatible
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set cursorline
g:mapleader = "\<Space>"

syntax on
filetype plugin indent on
autocmd BufNewFile,BufRead *.cpp exec ":call SetCppFile()"
autocmd BufNewFile,BufRead *.c exec ":call SetCppFile()"
command! -nargs=0 -bar W  exec "w"
command! -nargs=0 -bar Wq  exec "wq" # 键盘Shift延迟

if has('win32')
    set enc=utf-8
    set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
    set langmenu=zh_CN.UTF-8
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim
    language messages zh_CN.utf-8
    set guifont=Consolas:h12
    set guifontwide=YaHei\ Consolas\ Hybrid
elseif has('unix')
    set guifont=Monaco\ 12 
elseif has('mac')
    set guifont=Monaco\ 12
endif

if has('clipboard')
    if has('unnamedplus')
        set clipboard=unnamed,unnamedplus
    else # On mac and Windows, use * register for copy-paste
        set clipboard=unnamed
    endif
endif

:def SetCppFile(): void
    packadd termdebug
    map <F9> : make <CR>
    map <F10> : call Run() <CR>
    # map <F11> : Termdebug %<.run <CR>
    map <F12> : call Build_and_run() <CR>
    map <F8> : call FormatCode()<CR>
    set makeprg=g++\ \"%\"\ -o\ \"%<.exe\"\ -g\ -O2
:enddef

:def g:Run(): void
    if &filetype == 'cpp' || &filetype == 'c'
        if has('win32')
            exec "! %<.exe"
        elseif has('unix')
            exec "!time ./%<.exe"
        endif
    elseif &filetype == 'sh'
        exec "!bash %"
    endif
:enddef

:def g:Build_and_run(): void
    exec "make"
    g:Run()
:enddef

:def FormatCode(): void
    exec "w"
    if &filetype == 'cpp' || &filetype == 'c' || &filetype == 'h'
        exec "!astyle --style=java -n \"%\""
        exec "e \"%\""
    endif
:enddef

call plug#begin('$VIM/vimfiles/plugged')
Plug 'junegunn/vim-easy-align'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'luochen1990/rainbow'
Plug 'Valloric/ListToggle'
Plug 'rakr/vim-one'
Plug 'roman/golden-ratio'
Plug 'jiangmiao/auto-pairs'
call plug#end()

if has('gui_running')
    set lines=54 columns=90
    set guioptions-=T
    set background=dark
    g:one_allow_italics = 1
    colorscheme one
endif

g:rainbow_active = 1
