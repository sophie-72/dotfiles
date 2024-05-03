set tabstop=4
set softtabstop=4
set expandtab
set autoindent
set number
set clipboard=unnamedplus
set termguicolors

call plug#begin()
Plug 'preservim/nerdtree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'github/copilot.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
Plug 'airblade/vim-gitgutter'
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
let g:airline_theme='catppuccin_macchiato'

" Configure GitGutter
set updatetime=250
highlight SignColumn guibg=#363a4f
highlight GitGutterAdd guibg=#363a4f guifg=#009900 ctermfg=2
highlight GitGutterChange guibg=#363a4f guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guibg=#363a4f guifg=#ff2222 ctermfg=1
