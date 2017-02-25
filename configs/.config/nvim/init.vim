" Plugins
call plug#begin()

Plug('itchyny/lightline.vim') " bottom status bar
Plug('tpope/vim-commentary') " Comment lines
Plug('tpope/vim-surround') " Easily switch/add surrounding characters
Plug('airblade/vim-gitgutter') " Show gutter with git status per line
Plug('ctrlpvim/ctrlp.vim')

" Pretty colors
Plug('nanotech/jellybeans.vim') " color scheme

" Python related
Plug('vim-scripts/mako.vim') " mako template syntax support

" Ruby RIP
" Plug('vim-ruby/vim-ruby') " Ruby support
" Plug('tpope/vim-endwise') " Add end keyword automatically

call plug#end()

" Indenting
set smartindent
set autoindent
set expandtab
set tabstop=2
set shiftwidth=2
set backspace=2
set cursorline
set nowrap

" Insert lines without entering insert mode
nnoremap <silent> <leader>o :<C-u>call append(line("."),   repeat([""], v:count1))<CR>
nnoremap <silent> <leader>O :<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>

" tab completion
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

" remap the tab key to do autocompletion or indentation depending on the
" context (from http://www.vim.org/tips/tip.php?tip_id=102)
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction

set noerrorbells

filetype on
filetype indent on
filetype plugin on


" Key bindings
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

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
let base16colorspace=256
set termguicolors
colorscheme jellybeans

let &colorcolumn="72,80"

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

au FileType javascript set noexpandtab
au FileType scss set noexpandtab

" Other plugin settings

let g:gitgutter_sign_column_always = 1

let g:vimfiler_as_default_explorer = 1

let g:lightline = {
      \ 'colorscheme': 'jellybeans',
      \ }

let g:ctrlp_custom_ignore = {'dir': '\v[\/](\.(git|hg|svn|dist)|node_modules|bower_components|WEB-INF|build|dist)$' }
let g:ctrlp_working_path_mode = 0

