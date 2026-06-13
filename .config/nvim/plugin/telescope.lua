vim.pack.add({
    "https://github.com/nvim-telescope/telescope.nvim",
    "https://github.com/nvim-lua/plenary.nvim",
})

local actions = require("telescope.actions")

require('telescope').setup({
    pickers = {
        find_files = {
            theme = "ivy",
        },
    },
    file_ignore_patterns = {
        "node_modules",
        "*templ.go*",
    },
    defaults = {
        mappings = {
            i = {
                ["<Tab>"] = actions.toggle_selection + actions.move_selection_next,
                ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_previous,
                ["<C-s>"] = actions.send_selected_to_qflist + actions.open_qflist,
            }
        }
    },
})
