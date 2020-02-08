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
autocmd BufNewFile,BufRead *.c exec ":call SetCppFile()"
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
    set guifontwide=仿宋set clipboard=unnamed
elseif has('unix')
    set guifont=Monospace\ 12
    set clipboard=unnamed
elseif has('mac')
    set guifont=Monaco\ 12
endif

function SetCppFile()
    inoremap ' ''<ESC>i
    inoremap " ""<ESC>i
    inoremap ( ()<ESC>i
    inoremap [ []<ESC>i
    inoremap { {<CR>}<ESC>O
    packadd termdebug
    "map <F4> : call Compile() <CR>
    map <F5> : make <CR>
    map <F6> : call Run() <CR>
    map <F7> : Termdebug %<.out <CR>
    map <F8> : call FormatCode()<CR>
    map <F9> : call Build_And_Run() <CR>
    set makeprg=g++\ %\ -o\ %<.out\ -g\ -std=c++11\ -O2\ -Wall\ -Wextra\ -Wconversion
endfunction

function SetPythonFile()
    inoremap ' ''<ESC>i
    inoremap " ""<ESC>i
    inoremap ( ()<ESC>i
    inoremap [ []<ESC>i
    inoremap { {}<ESC>i
    map <F6> : ! python % <CR>
endfunction

function Compile()
    if &filetype == 'cpp'
        exec "!g++ % -o %<.out -g -std=c++11 -O2 -Wall -Wextra -Wconversion"
    elseif &filetype == 'c'
        exec "!gcc % -o %<.out -g -Wall -Wextra -Wconversion"
    endif
endfunction

function Run()
    if &filetype == 'cpp' || &filetype == 'c'
        if has('win32')
            exec "! %<.out"
        elseif has('unix')
            exec "!time ./%<.out"
        endif
    elseif &filetype == 'sh'
        exec "!bash %"
    endif
endfunction

function Build_And_Run()
    exec "make"
    "call Compile()
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
Plug 'skywind3000/vim-quickui'
Plug 'Valloric/ListToggle'
call plug#end()

let g:rainbow_active = 1

" 清除所有目录项目
call quickui#menu#reset()

" 安装一个 File 目录，使用 [名称，命令] 的格式表示各个选项。
call quickui#menu#install('&File', [
            \ [ "&New File\tCtrl+n", 'echo 0' ],
            \ [ "&Open File\t(F3)", 'echo 1' ],
            \ [ "&Close", 'echo 2' ],
            \ [ "--", '' ],
            \ [ "&Save\tCtrl+s", 'echo 3'],
            \ [ "Save &As", 'echo 4' ],
            \ [ "Save All", 'echo 5' ],
            \ [ "--", '' ],
            \ [ "E&xit\tAlt+x", 'echo 6' ],
            \ ])

" 每个项目还可以多包含一个字段，表示它的帮助文档，光标过去时会被显示到最下方的命令行
call quickui#menu#install('&Edit', [
            \ [ '&Copy', 'echo 1', 'help 1' ],
            \ [ '&Paste', 'echo 2', 'help 2' ],
            \ [ '&Find', 'echo 3', 'help 3' ],
            \ ])

" 在 %{...} 内的脚本会被求值并展开成字符串
call quickui#menu#install("&Option", [
			\ ['Set &Spell %{&spell? "Off":"On"}', 'set spell!'],
			\ ['Set &Cursor Line %{&cursorline? "Off":"On"}', 'set cursorline!'],
			\ ['Set &Paste %{&paste? "Off":"On"}', 'set paste!'],
			\ ])

" install 命令最后可以加一个 “权重”系数，用于决定目录位置，权重越大越靠右，越小越靠左
call quickui#menu#install('H&elp', [
			\ ["&Cheatsheet", 'help index', ''],
			\ ['T&ips', 'help tips', ''],
			\ ['--',''],
			\ ["&Tutorial", 'help tutor', ''],
			\ ['&Quick Reference', 'help quickref', ''],
			\ ['&Summary', 'help summary', ''],
			\ ], 10000)

" 打开下面选项，允许在 vim 的下面命令行部分显示帮助信息
let g:quickui_show_tip = 1

" 定义按两次空格就打开上面的目录
noremap <space><space> :call quickui#menu#open()<cr>
