-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
-- Set vimwiki_ext2syntax equivalent
vim.g.vimwiki_ext2syntax = { [".md"] = "markdown" }

-- Set vimwiki_list equivalent
vim.g.vimwiki_list = { {
  path = "~/vimwiki/",
  syntax = "markdown",
  ext = ".md",
} }
