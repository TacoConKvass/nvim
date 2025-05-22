return {
    'rachartier/tiny-inline-diagnostic.nvim',
    event = 'VeryLazy',
    priority = 1000, -- needs to be loaded in first
    config = function()
        require('tiny-inline-diagnostic').setup({
            preset = 'powerline',
        })
        vim.diagnostic.config({ virtual_text = false })
    end
}
