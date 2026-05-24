syntax enable

set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab
set expandtab
set autoindent
set termguicolors
set number

" --- Plugin Management ---
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'
call plug#end()
 
" --- Configure GitGutter with generic, vibrant terminal colors ---
set updatetime=250
highlight SignColumn ctermbg=NONE guibg=NONE
highlight GitGutterAdd guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guifg=#ff2222 ctermfg=1
let g:gitgutter_git_args='--git-dir=$HOME/.dotfiles --work-tree=$HOME'

" --- Clean, Custom Color Palette Rules ---
set background=dark

" 'ron' is a gorgeous, built-in, high-contrast dark theme with cyan/yellow/pink accents
" Other great built-in options to try: 'desert', 'habamax', or 'default'
colorscheme ron

" Make the background completely transparent
highlight Normal guibg=NONE ctermbg=NONE
highlight NonText guibg=NONE ctermbg=NONE

" --- Configure Lightline ---
set laststatus=2
set noshowmode
" 'deus' or 'powerline' are built into Lightline and look great with dark themes
let g:lightline = {'colorscheme': 'deus'}
