syntax enable

set number

call plug#begin()
Plug 'vim-airline/vim-airline'
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
call plug#end()
 
" Configure Airline-theme
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_statusline_ontop = 0
let g:airline_theme='catppuccin_macchiato'                                                            
