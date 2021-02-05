" Plugins
call plug#begin()

Plug('vim-airline/vim-airline')
Plug('vim-airline/vim-airline-themes')
Plug('tpope/vim-commentary') " Comment lines
Plug('tpope/vim-surround') " Easily switch/add surrounding characters
Plug('airblade/vim-gitgutter') " Show gutter with git status per line
Plug('ctrlpvim/ctrlp.vim') " File browsing
Plug('neomake/neomake') " async make runner
Plug('scrooloose/nerdtree') " file browsing because why not
Plug('chriskempson/base16-vim')
Plug('ernstvanderlinden/vim-coldfusion')
Plug('ciaranm/detectindent')
Plug 'WouterToering/Breve'
Plug 'w0ng/vim-hybrid'
Plug 'notpratheek/vim-sol'
Plug 'junegunn/seoul256.vim'

" Python related
" Plug('vim-scripts/mako.vim') " mako template syntax support
Plug('nvie/vim-flake8') " PEP8 nazism
Plug 'lepture/vim-jinja'

" Ruby RIP
Plug('vim-ruby/vim-ruby') " Ruby support
Plug('tpope/vim-endwise') " Add end keyword automatically

"TYPESCRIPT OOH NO
Plug 'HerringtonDarkholme/yats.vim'
" Plug 'mhartington/nvim-typescript', {'do': ':!install.sh \| UpdateRemotePlugins'}
" Plug 'Shougo/deoplete.nvim'
" Plug 'Shougo/denite.nvim'

Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['typescript', 'html', 'css', 'scss'] }

"Reason?
Plug 'reasonml-editor/vim-reason-plus'
" Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}

call plug#end()

" let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
" let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'

" Use `[c` and `]c` for navigate diagnostics
" nmap <silent> [c <Plug>(coc-diagnostic-prev)
" nmap <silent> ]c <Plug>(coc-diagnostic-next)

" " Remap keys for gotos
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)

" " Use K for show documentation in preview window
" nnoremap <silent> K :call <SID>show_documentation()<CR>
" nnoremap <silent> <D-l> :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
"autocmd CursorHold * silent call <SID>show_documentation()
set updatetime=300

let g:deoplete#enable_at_startup = 1

" Indenting
set smartindent
set autoindent
set expandtab
set tabstop=2
set shiftwidth=2
set backspace=2
set cursorline
set nowrap

" tab completion
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

map <C-n> :NERDTreeToggle<CR>

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
let base16colorspace=256
set termguicolors


let g:sierra_Midnight = 1
let g:quantum_black=1
colorscheme hybrid

"let g:airline_theme='quantum'

let &colorcolumn="72,80,100"

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
au FileType php set tabstop=4
au FileType php set softtabstop=4
au FileType php set shiftwidth=4
au FileType typescript set tabstop=2
au FileType typescript set softtabstop=2
au FileType typescript set shiftwidth=2

au FileType javascript set noexpandtab
au FileType scss set noexpandtab
au FileType cf set noexpandtab

" Other plugin settings

set signcolumn=yes
let g:vimfiler_as_default_explorer = 1

let g:ctrlp_custom_ignore = {
  \ 'dir': '\v[\/](\.(env|git|hg|svn|dist|egg-info)|env|node_modules|bower_components|WEB-INF|build|dist)$',
  \ 'file': '\.js$'
  \ }
let g:ctrlp_working_path_mode = 0
let g:ctrlp_follow_symlinks = 1

let g:python_highlight_all=1
let python_highlight_all=1

let g:neomake_open_list = 0

let g:neomake_warning_sign = {
  \ 'text': '?',
  \ 'texthl': 'ErrorMsg',
  \ }
let g:neomake_error_sign = {
  \ 'text': '!',
  \ 'texthl': 'ErrorMsg',
  \ }

let g:neomake_python_flake8_maker = {
    \ 'args': ['--format=default'],
    \ 'errorformat':
        \ '%E%f:%l: could not compile,%-Z%p^,' .
        \ '%A%f:%l:%c: %t%n %m,' .
        \ '%A%f:%l: %t%n %m,' .
        \ '%-G%.%#',
    \ }

let g:neomake_python_enabled_makers = ['flake8', 'pylint']

let g:detectindent_preferred_when_mixed = 1


autocmd! BufReadPost,BufWritePost * Neomake
autocmd! BufRead *.cfc DetectIndent
