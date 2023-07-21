vim.cmd("packadd easy-align")

vim.keymap.set("n", "ga", "<Plug>(EasyAlign)")
vim.keymap.set("x", "ga", "<Plug>(EasyAlign)")

vim.g.easy_align_delimiters = {
    ["\\"] = {["pattern"] = "\\\\$"}
}
