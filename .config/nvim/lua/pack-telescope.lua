vim.cmd("packadd telescope")
require"telescope".setup {
    pickers = {
        find_files = {
            find_command = {"find", ".", "-type", "f"}
        }
    }
}

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<Leader>tf", builtin.find_files, {})
vim.keymap.set("n", "<Leader>tg", builtin.live_grep,  {})
vim.keymap.set("n", "<Leader>tb", builtin.buffers,    {})
vim.keymap.set("n", "<Leader>th", builtin.help_tags,  {})
