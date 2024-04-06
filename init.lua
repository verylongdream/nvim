-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
local toggle_checkbox = require("toggle-checkbox")
-- vim.cmd.colorscheme("catppuccin")
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  callback = function()
    vim.cmd("normal! m`")
  end,
})
-- local cmp = require("cmp")
--
-- cmp.setup({
--   mapping = {
--     ["<Tab>"] = cmp.mapping.confirm({ select = true }),
--     ["<CR>"] = cmp.mapping(function(fallback)
--       fallback()
--     end, { "i", "s" }),
--   },
--   -- ... (rest of your configuration)
-- })

vim.api.nvim_set_keymap("n", "<C-A>", "ggVG", { noremap = true, silent = true })

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  command = "startinsert",
})
vim.api.nvim_create_user_command("StartServer", "Dispatch npm run start", {})

vim.g.tmuxjump_telescope = true

vim.cmd.highlight("DiagnosticUnderlineError guisp=#ff0000 gui=undercurl")
-- Set the border color for floating windows
vim.o.inccommand = "nosplit"
vim.o.gdefault = true
