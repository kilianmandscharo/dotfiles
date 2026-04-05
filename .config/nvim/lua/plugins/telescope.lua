return {
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        keys = {
            { "<leader>p", ":Telescope find_files<CR>" },
            { "<leader>h", ":Telescope help_tags<CR>" },
            { "<leader>g", ":Telescope live_grep<CR>" },
            { "<leader>/", ":Telescope current_buffer_fuzzy_find<CR>" },
        },
        config = function()
            local actions = require "telescope.actions"

            vim.keymap.set("n", "<leader><leader>g", function()
                vim.ui.input({ prompt = "File pattern (e.g. *.ts): " }, function(pattern)
                    require("telescope.builtin").live_grep({
                        glob_pattern = pattern ~= "" and pattern or nil,
                    })
                end)
            end)

            require('telescope').setup {
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
            }
        end
    }
}
