return {
    {
		"L3MON4D3/LuaSnip",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		}
	},
    {
        'hrsh7th/nvim-cmp', commit = 'b5311ab',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-nvim-lsp-signature-help',
        },
        event = { 'InsertEnter' },
        config = function()
            local cmp = require('cmp')

            cmp.setup({
                preselect = cmp.PreselectMode.Item,
                snippet = {
                    expand = function(args) require('luasnip').lsp_expand(args.body) end
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = {
                    ['<Down>'] = cmp.mapping.select_next_item(),
                    ['<Up>'] = cmp.mapping.select_prev_item(),
                    ['<C-e>'] = cmp.mapping.complete(),
                    ['<Tab>'] = cmp.mapping.confirm({ select = true }),
                },
                sources = cmp.config.sources({
                    { name = 'nvim_lsp', group_index = 1, },
                    { name = 'nvim_lsp_signature_help', group_index = 1, },
                    { name = 'luasnip' },
                    { name = 'path' },
                    { name = 'buffer', group_index = 2, max_item_count = 8, },
                }),
                view = {
                    docs = {
                        auto_open = true,
                    }
                },
            })
        end
    }
}
