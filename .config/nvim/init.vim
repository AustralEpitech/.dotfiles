" variables
let &path = getcwd() . '/**' . ',' . &path
set expandtab
set smartindent
set shiftwidth=4
set tabstop=4
set number relativenumber
set ignorecase
set smartcase
set list
set mouse=a
au BufNewFile,BufRead *.c set cc=81
au BufNewFile,BufRead *.h set cc=81

" packages
source ~/.config/nvim/epitech_header.vim
packadd! nvim-treesitter
lua require('nvim-treesitter.configs').setup{highlight = {enable = true}}

" keybindings
nnoremap <C-c><C-h> :Header<CR>
