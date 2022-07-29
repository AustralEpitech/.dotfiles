" variables
let g:black_linelength=79

" plugins
lua require'lspconfig'.pyright.setup{}

" keybindings
nnoremap <C-f> :Black<CR>
