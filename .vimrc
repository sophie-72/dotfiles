syntax enable

set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab
set expandtab
set autoindent
set termguicolors
set number

call plug#begin()
Plug 'rose-pine/vim', { 'as': 'rose-pine' }
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'
call plug#end()
 
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
