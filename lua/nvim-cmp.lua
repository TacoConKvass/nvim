return {
    'hrsh7th/nvim-cmp', commit = 'b5311ab',
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path'
    },
    event = { 'InsertEnter' },
    config = function()
        local cmp = require('cmp')

        cmp.setup({
            snippet = { 
                expand = function(args) vim.snippet.expand(args.body) end 
            },
            window = {
                -- completion = cmp.config.window.bordered(),
                -- documentation = cmp.config.window.bordered(),
            },
            mapping = {
                ['<Down>'] = cmp.mapping.select_next_item(),
                ['<Up>'] = cmp.mapping.select_prev_item(),
                ['<C-e>'] = cmp.mapping.complete(),
                ['<Tab>'] = cmp.mapping.confirm({ select = true }),
            },
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'buffer' }
            }),
        })
    end
}
