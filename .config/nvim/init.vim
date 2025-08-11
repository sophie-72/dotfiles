set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab
set expandtab
set autoindent
set number
set clipboard=unnamedplus
set termguicolors

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'preservim/nerdtree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
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

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

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
