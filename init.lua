-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- << General options >> --
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.breakindent = true
vim.opt.scrolloff = 20

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.signcolumn = 'yes:1'

-- Set \ as map leader
vim.g.mapleader = '\\'

-- LSP --
vim.lsp.config('csharp_ls', {
    cmd = { 'csharp-ls' },
    filetypes = { 'cs' },
    root_markers = { '.sln', '.git', '.csproj' },
    init_options = {
        AutomaticWorkspaceInit = true,
    },
})

vim.diagnostic.config({
	virtual_text = false,
    update_in_insert = true
})

require('lazy').setup('plugins')
