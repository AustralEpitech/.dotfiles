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
vim.o.shiftwidth     = 4
vim.o.smartindent    = true
vim.o.tabstop        = 4

vim.o.list           = true
vim.o.number         = true
vim.o.relativenumber = true

vim.o.ignorecase     = true
vim.o.smartcase      = true

vim.o.guicursor      = ""
vim.o.mouse          = "a"

vim.o.suffixes       = vim.o.suffixes .. ",.pyc"

vim.o.foldmethod     = "indent"
vim.o.foldlevel      = 99

vim.o.grepprg        = "grep -rn"

vim.o.scrolloff      = 2
vim.wo.cc            = "80"

-- keybindings
--            (mode, key,         command             )

-- terminal escape key
vim.keymap.set("t",  "<Esc>",     "<C-\\><C-n>"       )

-- go to file:line instead of just file
vim.keymap.set("n",  "gf",        "gF"                )

-- remove trailing whitespaces
vim.keymap.set("n",  "<Leader>w", "<cmd>%s/\\s\\+$//e<CR>")
