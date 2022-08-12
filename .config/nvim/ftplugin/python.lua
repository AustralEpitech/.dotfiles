-- packages
require'lspconfig'.pyright.setup {
    on_attach = require'lspbinds',
}

-- variables
vim.cmd("let g:black_linelength=79")

-- keybindings
vim.keymap.set("n", "<C-f>", ":Black<CR>")
