set tabstop=4
set softtabstop=4
set expandtab
set autoindent
set number
set clipboard=unnamedplus

call plug#begin()
Plug 'preservim/nerdtree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'github/copilot.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

" Configure NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * NERDTree
let g:NERDTreeGitStatusWithFlags = 1
let g:NERDTreeShowHidden=1

" Configure Coc
let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \ 'coc-json',
  \ 'coc-css',
  \  'coc-eslint',
  \  'coc-prettier'
  \ ]

" Configure Airline-theme
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_statusline_ontop = 0
let g:airline_theme='dark'
let g:airline#extensions#tabline#enabled = 1
