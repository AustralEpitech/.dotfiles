---------------------
----- variables -----
---------------------

vim.g.mapleader      = " "

vim.o.expandtab      = true
vim.o.smartindent    = true
vim.o.shiftwidth     = 4
vim.o.tabstop        = 4

vim.o.list           = true

vim.o.number         = true
vim.o.relativenumber = true
vim.o.laststatus     = 3

vim.o.ignorecase     = true
vim.o.smartcase      = true

vim.o.guicursor      = ""

vim.o.suffixes       = vim.o.suffixes .. ",.pyc"

vim.o.foldmethod     = "indent"
vim.o.foldlevel      = 99

vim.o.grepprg        = "grep -rn"

vim.o.scrolloff      = 2
vim.wo.colorcolumn   = "80"

vim.g.netrw_banner   = 0

vim.o.lazyredraw     = true

vim.o.complete       = vim.o.complete .. ",i"

vim.o.mousemodel     = extend

--------------------
----- packages -----
--------------------

require"pack-impatient"
vim.cmd("packadd plenary")

require"theme"

require"pack-dirdiff"
require"pack-easy-align"
require"pack-grammalecte"
require"pack-indent-blankline"
require"pack-lspconfig"
require"pack-telescope"
require"pack-treesitter"
vim.cmd("source ~/.config/nvim/epitech_header.vim")

-----------------------
----- keybindings -----
-----------------------

-- remove trailing whitespaces
vim.keymap.set("n", "<Leader>e", "<cmd>exe getline(line('.'))<CR>")
vim.keymap.set("n", "<Leader>f", "<cmd>%s/\\s\\+$//e<CR>")
