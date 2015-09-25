
"Vundle setup
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'fatih/vim-go'
Plugin 'Valloric/YouCompleteMe'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/syntastic'
call vundle#end()

filetype plugin indent on
" Mental sanity options - Vim is not fucking vi
set nocompatible
set backspace=indent,eol,start
set undolevels=1000 " default I think is one


" general editor
" search
set incsearch                   " Incremental search
set ignorecase                  " Ignore case
set smartcase                   " Unless user speficies


" tabs
map <C-Left> :tabprevious<CR>
map <C-Right> :tabnext<CR>
map <C-T>  :tabnew<CR>
map <C-W> :tabclose<CR>

set showtabline=1               " Show tabs line if there is more than 1 tab

" Programming specific
" Programming - basic options:
set ruler
syntax on


" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Programming - indenting: I'm an indenting prima donna
set expandtab     " Use spaces instead of tabs
set shiftwidth=4  " Auto-indent spaces
set softtabstop=4 " Spaces per tab

"set foldlevel=99
"
"

""colors
colorscheme solarized
set background=dark
set t_Co=256
"airlineA
set laststatus=2
let g:airline_theme = "lucius"

