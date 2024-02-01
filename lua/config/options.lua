-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.tabstop = 4
vim.g.mapleader = ";"
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.o.tabline = "%f"
vim.opt.swapfile = false
-- vim.opt.scrolloff = 9999
-- vim.opt.errorformat = "%f\\(%l\\,%c\\): error %trror TS%n: %m"
vim.opt.makeprg = "npm run build"

-- Define an errorformat, adjust to match the output of your Node.js application
-- This is an example that you would need to modify based on your actual output
-- vim.opt.errorformat = "%f:%l:%c:%m"
-- vim.opt.errorformat = "%f\\(%l\\,%c\\): error TS%n: %m"
