---------------------
----- variables -----
---------------------

vim.g.mapleader        = " "

vim.o.expandtab        = true
vim.o.smartindent      = true
vim.o.shiftwidth       = 4
vim.o.tabstop          = 4
vim.o.cino             = "(s"
vim.g.python_indent    = {
    open_paren = "shiftwidth()"
}

vim.o.list             = true
vim.o.listchars        = "tab:> ,trail:-,nbsp:+,leadmultispace:│   "

vim.o.number           = true
vim.o.relativenumber   = true
vim.o.laststatus       = 3

vim.o.ignorecase       = true
vim.o.smartcase        = true

vim.o.guicursor        = ""

vim.o.path             = vim.o.path .. ",**"
vim.o.suffixes         = vim.o.suffixes .. ",.pyc,.hi"

vim.o.foldmethod       = "indent"
vim.o.foldlevel        = 99

vim.o.grepprg          = "grep -rn"

vim.o.scrolloff        = 2
vim.wo.colorcolumn     = "80"
vim.g.black_linelength = 79

vim.g.netrw_banner     = 0
vim.g.netrw_list_hide  = "\\.o$,\\.d$,\\.gc..$"

vim.o.lazyredraw       = true

vim.o.complete         = vim.o.complete .. ",i"

vim.o.mousemodel       = extend

--------------------
----- packages -----
--------------------

vim.loader.enable()

vim.cmd("packadd plenary")

require"theme"

require"pack-easy-align"
require"pack-lspconfig"
require"pack-telescope"
require"pack-treesitter"
vim.cmd("source ~/.config/nvim/epitech.vim")

-----------------------
----- keybindings -----
-----------------------

-- remove trailing whitespaces
vim.keymap.set("n", "<Leader>e", "<cmd>exe getline(line('.'))<CR>")
vim.keymap.set("n", "<Leader>f", "<cmd>%s/\\s\\+$//e<CR>")
