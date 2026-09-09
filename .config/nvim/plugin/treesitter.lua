vim.pack.add({
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
})

require("nvim-treesitter").setup({
    install_dir = vim.fn.stdpath("data") .. "/site",
})

require("nvim-treesitter").install({ "svelte", "typescript", "javascript", "css", "html" })

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "svelte", "typescript", "javascript", "css", "html" },
    callback = function()
        vim.treesitter.start()
    end,
})
