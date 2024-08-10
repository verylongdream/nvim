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
--

vim.api.nvim_set_keymap("n", "<C-A>", "ggVG", { noremap = true, silent = true })

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  command = "startinsert",
})
vim.api.nvim_create_user_command("Ns", "Dispatch npm run start", {})

vim.g.tmuxjump_telescope = true

vim.cmd.highlight("DiagnosticUnderlineError guisp=#ff0000 gui=undercurl")
-- Set the border color for floating windows
vim.o.inccommand = "nosplit"
vim.o.gdefault = true
require("nvim-treesitter.configs").setup({
  textobjects = {
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist

      goto_next_start = {
        [">"] = "@parameter.inner", -- Navigate to the next parameter
      },

      goto_previous_start = {
        ["<"] = "@parameter.inner", -- Navigate to the previous parameter
      },
    },
  },
})
vim.cmd([[
  augroup strdr4605
    autocmd FileType typescript,typescriptreact compiler tsc | setlocal makeprg=npx\ tsc
  augroup END
]])
