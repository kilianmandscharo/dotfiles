local M = {}

M.formatFile = function()
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
end

M.toggleQuickFix = function()
    local windows = vim.fn.getwininfo()
    local qf_open = vim.iter(windows):any(function(w) return w.quickfix == 1 end)
    vim.cmd(qf_open and "cclose" or "copen")
end

return M
