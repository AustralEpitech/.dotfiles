" variables
set path+=**,
set expandtab
set smartindent
set shiftwidth=4
set tabstop=4
set number relativenumber
set ignorecase
set smartcase
set list
set mouse=a
set cc=80
set suffixes+=.pyc
set foldmethod=indent
set nofoldenable
set foldlevel=99
set grepprg=grep\ -rn\ $*

au BufWrite * :%s/\s\+$//e

" packages
so ~/.config/nvim/epitech_header.vim

packadd! nvim-treesitter
lua require'nvim-treesitter.configs'.setup {highlight = {enable = true}}

packadd! black

packadd! indent-blankline
lua << EOF
require'indent_blankline'.setup {
    show_current_context = true,
    show_current_context_start = true,
}
EOF

packadd! nvim-lspconfig

" keybindings
nnoremap <C-c><C-h> :Header<CR>
tnoremap <Esc> <C-\><C-n>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap gf gF

lua vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
