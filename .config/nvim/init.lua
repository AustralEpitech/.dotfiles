---------------------
----- variables -----
---------------------

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

--------------------
----- packages -----
--------------------

require"pack-black"
require"pack-indent-blankline"
require"pack-lspconfig"
require"pack-nvim-treesitter"
require"pack-vim-dirdiff"
require"pack-vim-easy-align"

-----------------------
----- keybindings -----
-----------------------

-- terminal escape key
vim.keymap.set("t", "<Esc>",     "<C-\\><C-n>"           )

-- remove trailing whitespaces
vim.keymap.set("n", "<Leader>w", "<cmd>%s/\\s\\+$//e<CR>")
