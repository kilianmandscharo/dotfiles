vim.pack.add({
    'https://github.com/stevearc/conform.nvim'
})

require("conform").setup({
    formatters_by_ft = {
        python = { "black" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        json = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
    },
})
