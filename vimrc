" BASIC SETTINGS ---------------------------------------------------------------- {{{

" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

"Turn off bell
set belloff=all

" Support true colors
set termguicolors

" Enable type file detection. Vim will be able to try to detect the type of file in use.
filetype on

" Enable plugins and load plugin for the detected file type.
filetype plugin on

" Load an indent file for the detected file type.
filetype indent on

" Turn syntax highlighting on.
syntax on

" Add numbers to each line on the left-hand side.
set number

" Make the backspace work like in most other programs
set backspace=indent,eol,start

" Highlight cursor line underneath the cursor horizontally.
set cursorline

" Set shift width to 4 spaces.
set shiftwidth=4

" Set tab width to 4 columns.
set tabstop=4

" Use space characters instead of tabs.
set expandtab

" Do not save backup files.
set nobackup

" Do not let cursor scroll below or above N number of lines when scrolling.
set scrolloff=10

" Do not wrap lines. Allow long lines to extend as far as the line goes.
set nowrap

" While searching though a file incrementally highlight matching characters as you type.
set incsearch

" Ignore capital letters during search.
set ignorecase

" Override the ignorecase option if searching for capital letters.
" This will allow you to search specifically for capital letters.
set smartcase

" Show partial command you type in the last line of the screen.
set showcmd

" Show the mode you are on the last line.
set showmode

" Show matching words during a search.
set showmatch

" Use highlighting when doing a search.
set hlsearch

" Set the commands to save in history default number is 20.
set history=1000

" Enable auto completion menu after pressing TAB.
set wildmenu

" Make wildmenu behave like similar to Bash completion.
set wildmode=list:longest

" There are certain files that we would never want to edit with Vim.
" Wildmenu will ignore files with these extensions.
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" Launch Powershell7 when invoked via :shell
set shell=pwsh.exe


" }}}


" PLUGINS ---------------------------------------------------------------- {{{

" Plugin code goes here.

call plug#begin('~/vimfiles/plugged')

Plug 'dense-analysis/ale'
Plug 'preservim/nerdtree'
Plug 'github/copilot.vim'
Plug 'leafgarland/typescript-vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'itchyny/lightline.vim'
Plug 'nikvdp/ejs-syntax' 
Plug 'NLKNguyen/papercolor-theme'

call plug#end()

" }}}


" VIMSCRIPT -------------------------------------------------------------- {{{

" This will enable code folding.
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END
"
" Use the marker method of folding.
"
" zo to open a single fold under the cursor.
" zc to close the fold under the cursor.
" zR to open all folds.
" zM to close all folds.
"

" If the current file type is HTML, set indentation to 2 spaces.
autocmd Filetype html setlocal tabstop=2 shiftwidth=2 expandtab

" If Vim version is equal to or greater than 7.3 enable undofile.
" This allows you to undo changes to a file even after saving it.
if version >= 703
    set undodir=~/.vim/backup
    set undofile
    set undoreload=10000
endif

set background=light        " for the light version
colorscheme PaperColor


" }}}


" STATUS LINE ------------------------------------------------------------ {{{

" Enable the statusline
set laststatus=2

" Indicataor like -- INSERT -- is unnecessary because the mode information is displayed in the statusline
set noshowmode

let g:lightline = {
      \ 'colorscheme': 'PaperColor',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype', 'charvaluehex' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

" }}}


" MAPPINGS --------------------------------------------------------------- {{{

" Set the semicolon as the leader key.
let mapleader = ';'

" Press ;; to jump back to the last cursor position.
nnoremap <leader>; ``

" Press \p to print the current file to the default printer from a Linux operating system.
" View available printers:   lpstat -v
" Set default printer:       lpoptions -d <printer_name>
" <silent> means do not display output.
nnoremap <silent> <leader>p :%w !lp<CR>

" Type jj to exit insert mode quickly.
imap jj <Esc>

" Press the space bar to type the : character in command mode.
nnoremap <space> :

" Pressing the letter o will open a new line below the current one.
" Exit insert mode after creating a new line above or below the current line.
nnoremap o o<esc>
nnoremap O O<esc>

" Center the cursor vertically when moving to the next word during a search.
nnoremap n nzz
nnoremap N Nzz

" Yank from cursor to the end of line.
nnoremap Y y$

" Yank all the content with ya
nnoremap ya ggVG"*y<C-O>

" Clipboard yank and paste
"
" Yank all the content with ,ya
nnoremap ,ya ggVG"*y<C-O>
"
" Yank a whole line in normal mode, copy selected in visual mode
nnoremap ,y "*yy
vnoremap ,y "*y
"
" Yank a whole line in normal mode, copy selected in visual mode
nnoremap ,p  "*p
nnoremap ,p  "*p

" Map the F5 key to run a Python script inside Vim.
" I map F5 to a chain of commands here.
" :w saves the file.
" <CR> (carriage return) is like pressing the enter key.
" !clear runs the external clear screen command.
" !python3 % executes the current file with Python.
nnoremap <f5> :w <CR>:!clear <CR>:!python3 % <CR>

" You can split the window in Vim by typing :split or :vsplit.
" Navigate the split view easier by pressing CTRL+j, CTRL+k, CTRL+h, or CTRL+l.
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Resize split windows using arrow keys by pressing:
" CTRL+UP, CTRL+DOWN, CTRL+LEFT, or CTRL+RIGHT.
noremap <c-up> <c-w>+
noremap <c-down> <c-w>-
noremap <c-left> <c-w>>
noremap <c-right> <c-w><

" NERDTree specific mappings.
" Map the F3 key to toggle NERDTree open and close.
nnoremap <leader>b :NERDTreeToggle<cr>

" Have nerdtree ignore certain files and directories.
let NERDTreeIgnore=['\.git$', '\.jpg$', '\.mp4$', '\.ogg$', '\.iso$', '\.pdf$', '\.pyc$', '\.odt$', '\.png$', '\.gif$', '\.db$']
" }}}
