" Plugins
call plug#begin()

Plug('nanotech/jellybeans.vim') " color scheme
Plug('itchyny/lightline.vim') " bottom status bar
Plug('vim-scripts/mako.vim') " mako template syntax support
Plug('scrooloose/nerdtree') " File tree
Plug('tpope/vim-commentary') " Comment lines
Plug('tpope/vim-surround') " Easily switch/add surrounding characters
Plug('airblade/vim-gitgutter') " Show gutter with git status per line
Plug('nathanaelkane/vim-indent-guides') " Indent guides

" Ruby
Plug('vim-ruby/vim-ruby') " Ruby support
Plug('tpope/vim-endwise') " Add end keyword automatically

call plug#end()

" Indenting
set smartindent
set autoindent
set expandtab
set tabstop=2
set shiftwidth=2
set backspace=2
"set esckeys
set pastetoggle=<F2>
set cursorline
set nowrap

" Insert lines without entering insert mode
nnoremap <silent> <leader>o :<C-u>call append(line("."),   repeat([""], v:count1))<CR>
nnoremap <silent> <leader>O :<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>

set noerrorbells

filetype on
filetype indent on
filetype plugin on


" Key bindings
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
map <C-n> :NERDTreeToggle<cr>
map <C-p> :relativenumbers!<cr>

nnoremap ; :

nnoremap <ESC> :noh<ESC>

" Use CTRL-S for saving
noremap <C-s> :w<CR>
vnoremap <C-s> <C-C>:w<CR>


" UI
set nu
set relativenumber
set ruler
set title

let mapleader = ","

syntax on
set background=dark
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
colorscheme jellybeans

let &colorcolumn="72,".join(range(80,999),",")

set list listchars=tab:»·,trail:· " show extra space characters

" System
set noswapfile
set nobackup

set mouse=a
set incsearch
set hlsearch

" Disable arrow keys in normal and visual mode
for prefix in ['n', 'v']
  for key in ['<Up>', '<Down>', '<Left>', '<Right>']
    exe prefix . "noremap " . key . " <Nop>"
  endfor
endfor


set clipboard=unnamed
set laststatus=2

" Remove whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" Python settings

au FileType python set tabstop=4
au FileType python set softtabstop=4
au FileType python set shiftwidth=4

" Other plugin settings

let g:gitgutter_sign_column_always = 1

let g:vimfiler_as_default_explorer = 1

let g:lightline = {
      \ 'colorscheme': 'jellybeans',
      \ }

let g:indent_guides_guide_size=1
