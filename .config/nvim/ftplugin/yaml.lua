-- packages
require'lspconfig'.yamlls.setup {
    on_attach = require'lspbinds',
}

-- variables
vim.o.shiftwidth = 2
vim.o.tabstop = 2

-- keybindings