source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function MyDiff()
    let opt = '-a --binary '
    if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
    if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
    let arg1 = v:fname_in
    if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
    let arg1 = substitute(arg1, '!', '\!', 'g')
    let arg2 = v:fname_new
    if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
    let arg2 = substitute(arg2, '!', '\!', 'g')
    let arg3 = v:fname_out
    if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
    let arg3 = substitute(arg3, '!', '\!', 'g')
    if $VIMRUNTIME =~ ' '
        if &sh =~ '\<cmd'
            if empty(&shellxquote)
                let l:shxq_sav = ''
                set shellxquote&
            endif
            let cmd = '"' . $VIMRUNTIME . '\diff"'
        else
            let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
        endif
    else
        let cmd = $VIMRUNTIME . '\diff'
    endif
    let cmd = substitute(cmd, '!', '\!', 'g')
    silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
    if exists('l:shxq_sav')
        let &shellxquote=l:shxq_sav
    endif
endfunction

set noundofile
set nobackup
set nocompatible
set smartindent
set nu
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set cin
set autoindent
set cursorline
let mapleader = "\<Space>"
if has('gui_running')
    set lines=38 columns=80
    set guioptions-=T
endif
colorscheme angr
syntax on
filetype plugin indent on
autocmd BufNewFile,BufRead *.cpp exec ":call SetCppFile()"
autocmd BufNewFile,BufRead *.c exec ":call SetCFile()"
autocmd BufNewFile,BufRead *.py exec ":call SetPythonFile()"

if has('win32')
    autocmd GUIEnter * call libcallnr("vimtweak.dll", "SetAlpha", 240)
    set enc=utf-8
    set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
    set langmenu=zh_CN.UTF-8
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim
    language messages zh_CN.utf-8
    set guifont=Consolas:h12
    set guifontwide=仿宋
elseif has('unix')
    set guifont=Monaco\ 12 
elseif has('mac')
    set guifont=Monaco\ 12
endif

if has('clipboard')
    if has('unnamedplus') " When possible use + register for copy-paste
        set clipboard=unnamed,unnamedplus
    else " On mac and Windows, use * register for copy-paste
        set clipboard=unnamed
    endif
endif

function BracketCompletion()
    inoremap ' ''<ESC>i
    inoremap " ""<ESC>i
    inoremap ( ()<ESC>i
    inoremap [ []<ESC>i
    inoremap { {<CR>}<ESC>O
endfunction

function SetCppFile()
    call BracketCompletion()
    packadd termdebug
    map <F5> : make <CR>
    map <F6> : call Run() <CR>
    map <F7> : Termdebug %<.run <CR>
    map <F8> : call FormatCode()<CR>
    map <F9> : call Build_And_Run() <CR>
    set makeprg=g++\ %\ -o\ %<.run\ -g\ -std=c++11\ -O2\ -Wall\ -Wextra\ -Wconversion
endfunction

function SetCFile()
    call BracketCompletion()
    packadd termdebug
    map <F5> : make <CR>
    map <F6> : call Run() <CR>
    map <F7> : Termdebug %<.run <CR>
    map <F8> : call FormatCode()<CR>
    map <F9> : call Build_And_Run() <CR>
    set makeprg=gcc\ %\ -o\ %<.run\ -g\ -std=c90\ -O2\ -Wall\ -Wextra\ -Wconversion
endfunction
" Using -std=c90 For Fucking Tan Hao Qiang!

function SetPythonFile()
    call BracketCompletion()
    inoremap { {}<ESC>i
    map <F6> : ! python % <CR>
endfunction

function Run()
    if &filetype == 'cpp' || &filetype == 'c'
        if has('win32')
            exec "! %<.run"
        elseif has('unix')
            exec "!time ./%<.run"
        endif
    elseif &filetype == 'sh'
        exec "!bash %"
    endif
endfunction

function Build_And_Run()
    exec "make"
    call Run()
endfunction

func! FormatCode()
    exec "w"
    if &filetype == 'cpp' || &filetype == 'C' || &filetype == 'h'
        exec "!astyle --style=ansi -n %"
        exec "e %"
    endif
endfunc

call plug#begin('$VIM/vimfiles/plugged')
Plug 'junegunn/vim-easy-align'
Plug 'https://github.com/junegunn/vim-github-dashboard.git'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'
Plug 'luochen1990/rainbow'
Plug 'Valloric/ListToggle'
call plug#end()

let g:rainbow_active = 1

