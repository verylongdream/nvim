-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
require("config.lazy")
keymap = vim.api.nvim_set_keymap
keymap("i", "jk", "<Esc>", { noremap = true, silent = true }) -- Add valid options
keymap("n", "<leader>wc", ":e ~/.config/nvim<CR>", { noremap = true, silent = true })
keymap("n", "`a", "'a", { noremap = true, silent = true })
keymap("n", "'a", "`a", { noremap = true, silent = true })

local modes = { "n", "v", "i", "c", "o" }
for _, mode in ipairs(modes) do
  vim.api.nvim_set_keymap(mode, "<leader>wk", ":VimwikiIndex<CR>", { noremap = true, silent = true })
end

-- Set vimwiki_ext2syntax equivalent
vim.g.vimwiki_ext2syntax = { [".md"] = "markdown" }

-- Set vimwiki_list equivalent
vim.g.vimwiki_list = { {
  path = "~/vimwiki/",
  syntax = "markdown",
  ext = ".md",
} }
vim.api.nvim_command("autocmd FileType vimwiki autocmd TextChanged,InsertLeave <buffer> silent write")

-- Subtitute same line
vim.api.nvim_set_keymap("n", "<C-f>", ":s/<C-r><C-w>/", { noremap = true, silent = false })

-- Visual substitute /g /gc for global and c for confirm, global is set permanently in init.lua
vim.keymap.set("v", "z", [[:s/\%V]], { noremap = true, silent = false })

-- Delete without yanking
vim.api.nvim_set_keymap("n", "d", '"_d', { noremap = true })
vim.api.nvim_set_keymap("n", "D", '"_D', { noremap = true })
vim.api.nvim_set_keymap("n", "dd", '"_dd', { noremap = true })
vim.api.nvim_set_keymap("v", "d", '"_d', { noremap = true })
vim.api.nvim_set_keymap("n", "X", 'yy"_dd', { noremap = true })
vim.api.nvim_set_keymap("n", "x", '"_x', { noremap = true })

vim.keymap.set("n", "<C-Space>", ":ToggleCheckbox<CR>", { noremap = true, silent = true })

vim.api.nvim_create_autocmd("BufRead", {
  pattern = "vimwiki/diary.md",
  command = "normal ;w;i",
})

vim.api.nvim_set_keymap("n", "-", "$", { noremap = true, silent = true })
vim.api.nvim_set_keymap("o", "-", "$", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "-", "$", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "0", "^", { noremap = true, silent = true })
vim.api.nvim_set_keymap("o", "0", "^", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "0", "^", { noremap = true, silent = true })

-- Remap for ys
vim.api.nvim_set_keymap("n", '"', "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "ys", "<Plug>Ysurroundiw", { noremap = false, silent = true })
vim.keymap.set("x", "ys", "<Plug>VSurround") -- Add any additional keymaps here

--Surround selected visual text with given bracket quote etc
vim.api.nvim_set_keymap("x", '"', '<Plug>VSurround"', { noremap = false, silent = true })
vim.api.nvim_set_keymap("x", "{", "<Plug>VSurround{", { noremap = false, silent = true })
vim.api.nvim_set_keymap("x", "(", "<Plug>VSurround(", { noremap = false, silent = true })
vim.api.nvim_set_keymap("x", "'", "<Plug>VSurround'", { noremap = false, silent = true })
vim.api.nvim_set_keymap("x", "`", "<Plug>VSurround`", { noremap = false, silent = true })
vim.api.nvim_set_keymap("x", "[", "<Plug>VSurround[", { noremap = false, silent = true })

--inverses, some add spacing
vim.api.nvim_set_keymap("x", "}", "<Plug>VSurround}", { noremap = false, silent = true })
vim.api.nvim_set_keymap("x", ")", "<Plug>VSurround)", { noremap = false, silent = true })
vim.api.nvim_set_keymap("x", "]", "<Plug>VSurround]", { noremap = false, silent = true })

--NORMAL WORD SURROUND WITH CHAR
--------------------------------------------------------------------------
-------------------------------------------------------------------------------

vim.api.nvim_set_keymap("n", '"', '<Plug>Ysurroundiw"', { noremap = false, silent = true })
vim.api.nvim_set_keymap("n", "(", "<Plug>Ysurroundiw(", { noremap = false, silent = true })
vim.api.nvim_set_keymap("n", "`", "<Plug>YSurroundiw`", { noremap = false, silent = true })

--inverses, some add spacing
vim.api.nvim_set_keymap("n", ")", "<Plug>YSurroundiw)", { noremap = false, silent = true })

--Debugging step over
vim.api.nvim_set_keymap("n", "1", ":DapStepOver<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "2", '<cmd>lua require("dap").restart()<CR>', { noremap = true, silent = true })

--Sets marks to go to specific col number as well as line and adds them to the jump list
vim.api.nvim_set_keymap("n", "m<key>", ':lua set_mark_extmark("<key>")<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gm<key>", ':lua goto_mark_extmark("<key>")<CR>', { noremap = true, silent = true })

local mark_ns = vim.api.nvim_create_namespace("marks")

vim.api.nvim_set_keymap("n", "<A-p>", ":vertical resize +5<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<A-n>", ":vertical resize -5<CR>", { noremap = true, silent = true })

--Closes buffer and switches to next and leaves split open, do :q to leave split
vim.cmd([[cnoremap bd :bnext<CR>:bd#<CR>]])

--WRAPPING FOR foo[bar] as Y[ , maybe later make it more dynamic like just make it Y then whatever you want to surround, {, etc more general for funcs
function _G.visual_dynamic_surround()
  local before = vim.fn.input("Enter text to wrap with (e.g., 'bar'): ")
  -- Ensure we yank into a specific register to avoid conflicts
  vim.api.nvim_exec('normal! "zyiw', false)
  local selection = vim.fn.getreg("z")

  -- Construct the wrapped text
  local wrapped_text = before .. "[" .. selection .. "]"
  -- Replace the visual selection with the wrapped text
  -- We use `\"z` to specify the register we yanked the text into
  vim.api.nvim_exec("normal! ciw" .. vim.fn.escape(wrapped_text, '"'), false)
end

-- Function for normal mode
function _G.normal_dynamic_surround()
  -- ( Enter ) visual mode, select the word, and call the visual mode function
  vim.api.nvim_exec("normal! viw", false)
  -- Use vim.schedule to ensure commands are executed in order
  vim.schedule(_G.visual_dynamic_surround)
end

-- Unmap Y in normal mode to prevent conflict with the default behavior
vim.api.nvim_set_keymap("n", "Y", "<Nop>", { noremap = true, silent = true })

-- Map Y[ in visual mode to the visual_dynamic_surround function
vim.api.nvim_set_keymap("v", "Y[", ":<C-U>lua visual_dynamic_surround()<CR>", { noremap = true, silent = true })

-- Map Y[ in normal mode to the normal_dynamic_surround function
vim.api.nvim_set_keymap("n", "Y[", ":<C-U>lua normal_dynamic_surround()<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>z", ":TmuxJumpFile<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>Z", ":TmuxJumpFirst<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "8", "#", { noremap = true })
-- vim.api.nvim_set_keymap("n", "<S-gt>", "*", { noremap = true })

vim.api.nvim_set_keymap("n", "{", ":keepjumps normal! {<CR>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "}", ":keepjumps normal! }<CR>", { silent = true, noremap = true })

vim.api.nvim_set_keymap("n", "}", "10j", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "{", "10k", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "t", "<Nop>", { noremap = true, silent = true })
_G.SimpleInnerPaste = function(char)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("v" .. char, true, false, true), "n", false)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("p", true, false, true), "n", false)
end

vim.api.nvim_set_keymap("n", "tw", '<cmd>lua _G.SimpleInnerPaste("iw")<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", 't"', "<cmd>lua _G.SimpleInnerPaste('i\"')<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "t'", '<cmd>lua _G.SimpleInnerPaste("i\'")<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "t)", '<cmd>lua _G.SimpleInnerPaste("i)")<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "t]", '<cmd>lua _G.SimpleInnerPaste("i]")<CR>', { noremap = true, silent = true })
--
vim.keymap.set("n", "gt", function()
  vim.cmd("vsplit") -- Open a new vertical split window
  vim.lsp.buf.definition() -- Go to the definition
end, { silent = true, noremap = true })

--Visual_mode_moveselection
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true, noremap = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true, noremap = true })

-- vim.keymap.set({ "v", "c", "o", "t" }, "<Space>", "<Esc>", { silent = true, noremap = true })

-- Map 'v' in visual block mode to go back to normal mode
-- vim.keymap.set("x", "v", "<Esc>", { silent = true, noremap = true })

-- Remap redo to U
-- vim.keymap.set("n", "U", "<C-r>", { noremap = true })
