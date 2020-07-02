" use syntax highlighting
syntax on

filetype plugin indent on
" automatically indent
set smartindent
" tabs are four characters wide
set tabstop=4
" how much vi shifts the indentation
set shiftwidth=2
" expand tabs
set expandtab
" ignore case when searching, unless mixed case
set ignorecase
set smartcase
" allow buffer to open but not shown
set hidden
" show line numbers
set number
" show relative numbers
set relativenumber
" Don't show line numbers in terminal
autocmd TerminalOpen * setlocal norelativenumber
autocmd TerminalOpen * setlocal nonu

let mapleader=" "

" strip trailing whitespace on written file.
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline

map <leader>s :split<cr>
map <leader>v :vsplit<cr>
map <leader>f <C-W>f<C-W>L

" shortcut for directory listing
map <leader>e :Explore<cr>
let g:netrw_liststyles=3

" show tabs and trailing spaces
set lcs=tab:»·,trail:·

" enable 256 colours in terminal
" set t_Co=256

" highlight beyond 80 characters
let &colorcolumn=81
hi ColorColumn guibg=#2d2d2d ctermbg=0

" Turn off swap files
set updatecount=0

" Persistent undo
set undodir=~/.vim/undo,/tmp
set undofile

set modeline

" Stop the cursor going back one space when exiting insert mode.
inoremap <silent> <Esc> <Esc>`^

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

" zenburn colorscheme
Bundle 'http://github.com/jnurmine/Zenburn'
silent! colorscheme zenburn
" solarized colorscheme
Bundle 'altercation/vim-colors-solarized'
" set background=dark
" colorscheme solarized
" colorscheme slate

Bundle 'https://github.com/ervandew/supertab.git'

Bundle 'elixir-lang/vim-elixir'
autocmd BufRead *.ex set filetype=elixir
autocmd BufRead *.exs set filetype=elixir

set foldmethod=syntax
set foldlevel=1

Bundle 'habamax/vim-sendtoterm'

" automatically word wrap long lines
set linebreak
set breakindent
set breakindentopt=shift:4
let &showbreak='↳ '
set breakat==\|(){}[],\ 

