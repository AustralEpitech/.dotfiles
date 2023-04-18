vim.cmd("packadd telescope")
require"telescope".setup {
    defaults = {
        file_ignore_patterns = {
            ".o$", ".d$"
        }
    }
}

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<Leader>tf", builtin.find_files, {})
vim.keymap.set("n", "<Leader>tg", builtin.live_grep,  {})
vim.keymap.set("n", "<Leader>tb", builtin.buffers,    {})
vim.keymap.set("n", "<Leader>th", builtin.help_tags,  {})
