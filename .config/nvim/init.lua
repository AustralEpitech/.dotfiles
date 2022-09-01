-- packages
vim.cmd("packadd nvim-treesitter")
require'nvim-treesitter.configs'.setup {
    auto_install = true,
    highlight = {enable = true},
}

vim.cmd("packadd black")

vim.cmd("packadd indent-blankline")
require'indent_blankline'.setup {
    show_current_context = true,
    show_current_context_start = true,
}

vim.cmd("packadd nvim-lspconfig")

vim.cmd("packadd vim-dirdiff")

vim.cmd("packadd vim-easy-align")
vim.keymap.set("n", "ga", "<Plug>(EasyAlign)")
vim.keymap.set("x", "ga", "<Plug>(EasyAlign)<C-x>")

-- variables
vim.g.mapleader      = " "
vim.o.path           = vim.o.path .. ",**"
vim.o.expandtab      = true
vim.o.smartindent    = true
vim.o.shiftwidth     = 4
vim.o.tabstop        = 4
vim.o.number         = true
vim.o.relativenumber = true
vim.o.ignorecase     = true
vim.o.smartcase      = true
vim.o.list           = true
vim.o.mouse          = "a"
vim.o.suffixes       = vim.o.suffixes .. ",.pyc"
vim.o.foldmethod     = "indent"
vim.o.foldlevel      = 99
vim.o.grepprg        = "grep -rn"
vim.wo.cc            = "80"

-- keybindings
--            (mode, key,         command             )

-- terminal escape key
vim.keymap.set("t",  "<Esc>",     "<C-\\><C-n>"       )

-- movement keys
vim.keymap.set("n",  "<C-h>",     "<C-w>h"            )
vim.keymap.set("n",  "<C-j>",     "<C-w>j"            )
vim.keymap.set("n",  "<C-k>",     "<C-w>k"            )
vim.keymap.set("n",  "<C-l>",     "<C-w>l"            )

-- go to file:line instead of just file
vim.keymap.set("n",  "gf",        "gF"                )

-- remove trailing whitespaces
vim.keymap.set("n",  "<Leader>w", ":%s/\\s\\+$//e<CR>")
