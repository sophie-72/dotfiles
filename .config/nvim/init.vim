set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab
set expandtab
set autoindent
set number
set clipboard=unnamedplus
set termguicolors

call plug#begin()
Plug 'preservim/nerdtree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'github/copilot.vim'
Plug 'itchyny/lightline.vim'
Plug 'rose-pine/vim', { 'as': 'rose-pine' }
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

" Configure GitGutter
set updatetime=250
highlight SignColumn guibg=#363a4f
highlight GitGutterAdd guibg=#363a4f guifg=#009900 ctermfg=2
highlight GitGutterChange guibg=#363a4f guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guibg=#363a4f guifg=#ff2222 ctermfg=1
let g:gitgutter_git_args='--git-dir=$HOME/.dotfiles --work-tree=$HOME'

" Configure Rose Pine theme
set background=dark
colorscheme rosepine_moon

" Configure Lightline
set laststatus=2
set noshowmode
let g:lightline = {'colorscheme': 'rosepine_moon'}
