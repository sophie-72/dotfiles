syntax enable

set termguicolors
set number

call plug#begin()
Plug 'vim-airline/vim-airline'
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
Plug 'airblade/vim-gitgutter'
call plug#end()
 
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
let g:gitgutter_git_args='--git-dir=$HOME/.dotfiles --work-tree=$HOME'
