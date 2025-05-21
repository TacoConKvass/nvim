-- << General options >> --
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.breakindent = true
vim.opt.scrolloff = 10

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.signcolumn = 'yes:1'

-- Set \ as map leader
vim.g.mapleader = '\\'

-- LSP --
vim.lsp.enable('csharp_ls')

vim.diagnostic.config({
    virtual_text = false,
    update_in_insert = true
})

-- << Plugins >> --

local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    
    return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
    -- Packer
    use ({ 'wbthomason/packer.nvim' })
    
    -- LSP
    use ({ 'neovim/nvim-lspconfig', tag = 'v2.1.0' })

    use ({
        'rachartier/tiny-inline-diagnostic.nvim', commit = 'b6ed803',
        config = function()
            require('tiny-inline-diagnostic').setup({
                preset = 'minimal',
                transparent_bg = true,
                transparent_cursorline = true,
            })
        end
    })

    -- Github theme
    use ({ 
        'projekt0n/github-nvim-theme', tag = 'v1.1.2', 
        config = function() 
            require('github-theme').setup({
                options = {
                    transparent = true,
                },
            })
            vim.cmd('colorscheme github_dark_dimmed')
        end
    })

    -- Treesitter
    use ({
        'nvim-treesitter/nvim-treesitter', tag = 'v0.9.3',
        config = function()
            require('nvim-treesitter.configs').setup({
                ensure_installed = { 'c_sharp', 'rust' },
                sync_install = false,
                auto_install = false,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                }
            })
        end
    })

    -- Telescope
    use ({
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        requires = { {'nvim-lua/plenary.nvim'} },
        config = function()
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
            vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
        end
    })


    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)
