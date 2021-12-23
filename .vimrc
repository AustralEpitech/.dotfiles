" system config
unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

" variables
let &path = getcwd() . '/**' . ',' . &path
let g:netrw_liststyle=3 " tree style file explorer
set expandtab
set shiftwidth=4
set tabstop=4
set number relativenumber
set ignorecase
set smartcase
set list
set listchars=tab:\ \ ,multispace:⸱,trail:⸱
set hlsearch
set smartindent
set splitright
set ttymouse=sgr
au BufNewFile,BufRead *.c set cc=81
au BufNewFile,BufRead *.h set cc=81

" packages
source ~/.vim/epitech_header.vim

" keybindings
nnoremap <C-c><C-h> :Header<CR>
