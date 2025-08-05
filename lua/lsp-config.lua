local function is_windows()
    return package.config.sub(1, 1) == '\\';
end

local lsp_list = {'lua_ls', 'zls', 'rust-analyzer'}
if not is_windows() then
    table.insert(lsp_list, 'nil_ls');
end

local lsp_plugins = {
    {
        'neovim/nvim-lspconfig', version = 'v2.1.0', config = function()
            local capabilities = require('cmp_nvim_lsp').default_capabilities();


            for _, lsp in ipairs(lsp_list) do
                vim.lsp.config(lsp, { capabilities = capabilities })
                vim.lsp.enable(lsp)
            end

            -- vim.keymap.set("n", "<leader>h", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
            -- vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
            vim.keymap.set({"n", "i"}, "<C-s>", vim.lsp.buf.signature_help, {})
            -- vim.keymap.set("n", "<leader>rr", vim.lsp.buf.rename, {})
            -- vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
        end
    },
}

if is_windows() then
    table.insert(lsp_plugins, {
        {
            'williamboman/mason.nvim', config = function()
                require('mason').setup({
                    registries = {
                        "github:mason-org/mason-registry",
                        "github:Crashdummyy/mason-registry",
                    },
                })
            end
        },
        {
            'williamboman/mason-lspconfig.nvim', config = function()
                require("mason-lspconfig").setup({
                    ensure_installed = {
                        "lua_ls",
                    },
                })
            end
        }
    })
end

return lsp_plugins
