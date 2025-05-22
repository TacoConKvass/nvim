return {
    { "Hoffs/omnisharp-extended-lsp.nvim", },
    {
        'williamboman/mason.nvim', config = function()
            require('mason').setup()
        end
    },
    {
        'williamboman/mason-lspconfig.nvim', config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "omnisharp",
                },
            })
        end
    },
    {
        'neovim/nvim-lspconfig', version = 'v2.1.0', config = function()
            local config = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            config.lua_ls.setup({
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { 'vim' }
                        }
                    }
                }
            })
            config.omnisharp.setup({
                cmd = { "dotnet", vim.fn.stdpath("data") .. "/mason/packages/omnisharp/OmniSharp.dll" },
                handlers = {
                    ["textDocument/definition"] = require("omnisharp_extended").definition_handler,
                    ["textDocument/typeDefinition"] = require("omnisharp_extended").type_definition_handler,
                    ["textDocument/references"] = require("omnisharp_extended").references_handler,
                    ["textDocument/implementation"] = require("omnisharp_extended").implementation_handler,
                },
            })

            -- vim.keymap.set("n", "<leader>h", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
            -- vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
            vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help, {})
            -- vim.keymap.set("n", "<leader>rr", vim.lsp.buf.rename, {})
            -- vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
        end
    },
}
