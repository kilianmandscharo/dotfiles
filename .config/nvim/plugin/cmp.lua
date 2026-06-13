vim.pack.add({
    'https://github.com/saghen/blink.lib',
    'https://github.com/saghen/blink.cmp'
})

local cmp = require('blink.cmp')
cmp.build():pwait()
cmp.setup({
    keymap = {
        preset = 'none',
        ["<Tab>"] = { 'select_next', 'fallback' },
        ["<S-Tab>"] = { 'select_prev', 'fallback' },
        ["<CR>"] = { 'accept', 'fallback' },
    },
    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    signature = { enabled = true },
    completion = { ghost_text = { enabled = true } },
})
