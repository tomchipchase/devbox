" autocmd BufRead *.rb set syntax=yard
" autocmd BufRead *.pp set ft=puppet

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

" Shortcut for picking a window
" next
map <leader>n <C-W>w
" previous
map <leader>p <C-W>W
" directional
map <leader>j <C-W>j
map <leader>k <C-W>k
map <leader>h <C-W>h
map <leader>l <C-W>l

" shortcut to close other panes
map <leader>f :only<cr>
" redraw the screen
map <leader>r :redraw<cr>

" shortcut for directory listing
map <leader>e :Explore<cr>
let g:netrw_liststyles=3

"shortcut for buffer select
map <leader>b :buffers<cr>:buf<space>

" shortcut for redo
map <leader>r <C-r>

" shortcut to save
map <leader>w :w<cr>

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

Bundle 'scrooloose/syntastic'
let g:syntastic_ruby_checkers = ['reek', 'rubocop', 'mri']
let g:syntastic_quiet_messagesu = {'level': 'warnings'}
let g:syntastic_javascript_checkers = ['jsxhint']
let g:syntastic_javascript_jsxhint_exec = 'jsx-jshint-wrapper'

Bundle 'rainerborene/vim-reek'
Bundle 'ngmy/vim-rubocop'
Bundle 'tomtom/quickfixsigns_vim'

" puppet file highlighting
Bundle 'rodjek/vim-puppet'

" use my fork of vim-slime so I can use dtach instead of tmux or screen
" requires patched dtach
" Bundle 'tomchipchase/dtach'
let g:slime_target = "tmux"

Bundle 'https://github.com/ervandew/supertab.git'

filetype off
set nocompatible
Bundle 'kchmck/vim-coffee-script'
syntax enable
filetype plugin indent on

" Bundle 'kien/ctrlp'
Bundle 'thoughtbot/vim-rspec'
map <leader>t :call RunCurrentSpecFile()<CR>
map <leader>n :call RunNearestSpec()<CR>
map <leader>l :call RunLastSpec()<CR>
map <leader>a :call RunAllSpecs()<CR>

Bundle 'elixir-lang/vim-elixir'
autocmd BufRead *.ex set filetype=elixir
autocmd BufRead *.exs set filetype=elixir

Bundle 'pangloss/vim-javascript'
Bundle 'mxw/vim-jsx'

Bundle 'vim-ruby/vim-ruby'

vmap <C-c><C-c> J:SlimeSend<CR>u

set foldmethod=syntax
set foldlevel=1
