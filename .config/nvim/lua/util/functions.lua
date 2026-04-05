local M = {}

M.formatFile = function()
    local bufnr = vim.api.nvim_get_current_buf()

    if #require("conform").list_formatters(bufnr) > 0 then
        require("conform").format({
            bufnr = bufnr,
            lsp_format = "fallback",
            async = false,
        })
    else
        vim.lsp.buf.format()
    end
end

M.toggleQuickFix = function()
    local qf_open = false

    for _, win in pairs(vim.fn.getwininfo()) do
        if win["quickfix"] == 1 then
            qf_open = true
            break
        end
    end

    if qf_open == true then
        vim.cmd("cclose")
    else
        vim.cmd("botright copen")
    end
end

M.live_multigrep = function()
    local pickers = require "telescope.pickers"
    local finders = require "telescope.finders"
    local make_entry = require "telescope.make_entry"
    local conf = require "telescope.config".values

    local opts = { cwd = vim.fn.getcwd() }

    local finder = finders.new_async_job {
        command_generator = function(prompt)
            if not prompt or prompt == "" then
                return nil
            end

            local pieces = vim.split(prompt, "  ")
            local args = { "rg" }
            if pieces[1] then
                table.insert(args, "-e")
                table.insert(args, pieces[1])
            end

            if pieces[2] then
                table.insert(args, "-g")
                table.insert(args, pieces[2])
            end

            return vim.iter {
                args,
                { "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case" },
            }:flatten():totable()
        end,
        entry_maker = make_entry.gen_from_vimgrep(opts),
        cwd = opts.cwd,
    }

    pickers.new(opts, {
        debounce = 100,
        prompt_title = "Multi-Grep",
        finder = finder,
        previewer = conf.grep_previewer(opts),
        sorter = require("telescope.sorters").empty(),
    }):find()
end

M.pick_global_mark = function()
    local all_marks = vim.fn.getmarklist();
    local entries = {}

    for _, mark in ipairs(all_marks) do
        local byte = string.byte(string.sub(mark.mark, #mark.mark))
        if byte < 65 or byte > 90 then goto continue end

        local filename = mark.file
        local row = mark.pos[2]
        local col = mark.pos[3]

        table.insert(entries, {
            display = string.format("%s  %s:%d:%d", mark.mark, filename, row, col),
            ordinal = filename .. row .. col,
            filename = filename,
            lnum = row,
            col = col,
        })

        ::continue::
    end

    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local sorters = require("telescope.sorters")
    local themes = require("telescope.themes")

    pickers.new(themes.get_dropdown({
        prompt_title = "Marks",
    }), {
        finder = finders.new_table {
            results = entries,
            entry_maker = function(entry)
                return {
                    value = entry,
                    display = entry.display,
                    ordinal = entry.ordinal,
                    filename = entry.filename,
                    lnum = entry.lnum,
                    col = entry.col,
                }
            end
        },
        sorter = sorters.get_generic_fuzzy_sorter(),
    }):find()
end

return M
