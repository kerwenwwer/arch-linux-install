"vimrc conf
"using vim-autoformat powerline 
let g:ycm_server_python_interpreter = '/usr/bin/python2'
let g:ycm_global_ycm_extra_conf = '/usr/share/vim/vimfiles/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:clang_use_library = 1

" set status line
set laststatus=2
" enable powerline-fonts
let g:airline_powerline_fonts = 1
" enable tabline
let g:airline#extensions#tabline#enabled = 1
" set left separator
let g:airline#extensions#tabline#left_sep = ' '
" set left separator which are not editting
let g:airline#extensions#tabline#left_alt_sep = '|'
" show buffer number
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline_theme='one'
let g:NERDTreeShowIgnoredStatus = 1

"base
execute pathogen#infect()
syntax on
filetype plugin indent on

execute pathogen#infect('stuff/{}', '~/src/vim/bundle/{}')

syntax on

" tab寬度＝4
set tabstop=4
set softtabstop=4
set shiftwidth=4

set nocompatible

" 路進檔位置
set rtp+=~/.vim/bundle/Vundle.vim

"下為插件安裝位置
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'Chiel92/vim-autoformat'
Plugin 'airblade/vim-gitgutter'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'morhetz/gruvbox'
Plugin 'Valloric/YouCompleteMe'
call vundle#end()


filetype plugin indent on

" NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" 關閉NERDTree快捷键 
map <leader>t :NERDTreeToggle<CR> 
" 顯示行號
let NERDTreeShowLineNumbers=1 
let NERDTreeAutoCenter=1 
" 是否顯示隐藏文件 
let NERDTreeShowHidden=1 
" 設置宽度 
let NERDTreeWinSize=50
" 在终端启動vim时，共享NERDTree 
let g:nerdtree_tabs_open_on_console_startup=1 
" 忽略一下文件的顯示 
let NERDTreeIgnore=['\.pyc','\~$','\.swp'] 
" 顯示書籤
let NERDTreeShowBookmarks=1
"字元定義
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }
"顏色顯示
colorscheme gruvbox
let g:solarized_termcolors=256
set t_Cp =256
set background=dark    " Setting dark mode

"自動補全顯示
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0 

"let g:spacevim_statusline_separator = 'arrow'

"F3自动格式化代码
noremap <F3> :Autoformat<CR>
let g:autoformat_verbosemode=1
