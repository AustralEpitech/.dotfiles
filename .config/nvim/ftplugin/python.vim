" variables
let g:black_linelength=79

" packages
lua require'lspconfig'.pyright.setup{}

" keybindings
nnoremap <C-f> :Black<CR>
