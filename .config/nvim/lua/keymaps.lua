local set = vim.keymap.set;

-- Window navigation
set("n", "<C-h>", "<C-w>h")
set("n", "<C-j>", "<C-w>j")
set("n", "<C-k>", "<C-w>k")
set("n", "<C-l>", "<C-w>l")

-- Buffer navigation
set("n", "<S-l>", ":bnext<CR>")
set("n", "<S-h>", ":bprevious<CR>")
set("n", "<leader>c", ":bdelete<CR>")

-- Terminal
set("t", "<Esc>", "<C-\\><C-n>")

-- Toggle Quick Fix List
set("n", "<leader>b", function()
    local windows = vim.fn.getwininfo()
    local qf_open = vim.iter(windows):any(function(w) return w.quickfix == 1 end)
    vim.cmd(qf_open and "cclose" or "copen")
end)

-- Diagnostic
set("n", "gl", vim.diagnostic.open_float)
set("n", "gn", function() vim.diagnostic.jump({ count = vim.v.count1 }) end)
set("n", "gp", function() vim.diagnostic.jump({ count = -vim.v.count1 }) end)

-- LSP
set("n", "gd", vim.lsp.buf.definition)
set("n", "K", function() vim.lsp.buf.hover({ border = "rounded" }) end)
set("n", "<leader>f", function()
    local conform = require("conform")
    local bufnr = vim.api.nvim_get_current_buf()
    if #conform.list_formatters(bufnr) > 0 then
        conform.format({
            bufnr = bufnr,
            lsp_format = "fallback",
            async = false,
        })
    else
        vim.lsp.buf.format()
    end
end)

-- Copy file path
set("n", "<leader>cf", function()
    vim.fn.setreg("+", vim.fn.expand("%:p"))
    vim.notify("Copied path: " .. vim.fn.expand("%:p"))
end, { desc = "Copy full path of current buffer" })

-- Copy file name
set("n", "<leader>cn", function()
    vim.fn.setreg("+", vim.fn.expand("%:t"))
    vim.notify("Copied name: " .. vim.fn.expand("%:t"))
end, { desc = "Copy file name of current buffer" })

-- Telescope
set("n", "<leader>p", ":Telescope find_files<CR>")
set("n", "<leader>h", ":Telescope help_tags<CR>")
set("n", "<leader>g", ":Telescope live_grep<CR>")
set("n", "<leader>/", ":Telescope current_buffer_fuzzy_find<CR>")

-- Trouble
set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
set("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics (Trouble)" })
set("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols (Trouble)" })
set("n", "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
    { desc = "LSP Definitions / references / ... (Trouble)" })
set("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })
set("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })

-- Oil
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
