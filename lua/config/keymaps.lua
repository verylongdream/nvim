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
--vim.api.nvim_del_keymap("i", "<Backspace>")
--Save on ctrl s
-- vim.api.nvim_set_keymap("n", "<C-s>", ":w!<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("i", "<C-s>", "<Esc>:w!<CR>", { noremap = true, silent = true })
--Ctrl Z Undo Ctrl Shift Z redo
-- vim.api.nvim_set_keymap("n", "<C-z>", "u", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "U", "<C-r>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("i", "<C-z>", "<Esc>u", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("i", "<C-S-z>", "<Esc><C-r>", { noremap = true, silent = true })
--ctrl back space to del line
-- vim.api.nvim_set_keymap("i", "<C-BS>", "<C-u>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<C-BS>", "<C-u>", { noremap = true, silent = true })
--run code via plugin, and open terminal
vim.api.nvim_set_keymap("n", "<leader>T", ':lua require("run_code").run_code()<CR>', { noremap = true, silent = false })
vim.api.nvim_set_keymap("n", "<leader>t", ":vsplit | terminal<CR>i", { noremap = true, silent = true })

-- Find and replace ctrl f.  word/replaceword
-- vim.api.nvim_set_keymap("n", "<C-f>", ":%s/", { noremap = true, silent = false })

vim.api.nvim_set_keymap("n", "<C-f>", ":%s/<C-r><C-w>/", { noremap = true, silent = false })
-- Delete without yanking
vim.api.nvim_set_keymap("n", "d", '"_d', { noremap = true })
vim.api.nvim_set_keymap("n", "D", '"_D', { noremap = true })
vim.api.nvim_set_keymap("n", "dd", '"_dd', { noremap = true })
vim.api.nvim_set_keymap("v", "d", '"_d', { noremap = true })

--vim.api.nvim_set_keymap("n", "P", "o<Esc>p", { noremap = true })

-- vim.api.nvim_set_keymap("n", "P", "]:put<CR>", { noremap = true })
vim.api.nvim_create_user_command("RemindMe", function(args)
  require("remind_me").remindme(unpack(args.fargs))
end, { nargs = "+" })

vim.api.nvim_set_keymap("n", "C", ":Calendar<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "P", "o<Esc>p", { noremap = true, silent = true })

vim.keymap.set("n", "<C-Space>", ":ToggleCheckbox<CR>", { noremap = true, silent = true })

vim.api.nvim_create_autocmd("BufRead", {
  pattern = "vimwiki/diary.md",
  command = "normal ;w;i",
})

-- vim.keymap.set("n", "P", "o<Esc>p", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "X", 'yy"_dd', { noremap = true })

vim.api.nvim_set_keymap("n", "-", "$", { noremap = true, silent = true })
vim.api.nvim_set_keymap("o", "-", "$", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "-", "$", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "0", "^", { noremap = true, silent = true })
vim.api.nvim_set_keymap("o", "0", "^", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "0", "^", { noremap = true, silent = true })

-- Remap for yS
-- vim.api.nvim_set_keymap("n", "yS", "<Plug>YsurroundiW", { noremap = false, silent = true })
-- vim.api.nvim_set_keymap("n", '"', "<Plug>YsurroundiW", { noremap = false, silent = true })

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
-- vim.api.nvim_set_keymap("n", "{", "<Plug>Ysurroundiw{", { noremap = false, silent = true })
vim.api.nvim_set_keymap("n", "(", "<Plug>Ysurroundiw(", { noremap = false, silent = true })
vim.api.nvim_set_keymap("n", "`", "<Plug>YSurroundiw`", { noremap = false, silent = true })
-- vim.api.nvim_set_keymap("n", "[", "<Plug>YSurroundiw[", { noremap = false, silent = true })

--inverses, some add spacing
-- vim.api.nvim_set_keymap("n", "}", "<Plug>YSurroundiw{", { noremap = false, silent = true })
vim.api.nvim_set_keymap("n", ")", "<Plug>YSurroundiw)", { noremap = false, silent = true })
-- vim.api.nvim_set_keymap("n", "]", "<Plug>YSurroundaw[", { noremap = false, silent = true })

--Debugging step over
vim.api.nvim_set_keymap("n", "1", ":DapStepOver<CR>", { noremap = true, silent = true })

-- Define a namespace for our matches to keep track of them
local underline_ns = vim.api.nvim_create_namespace("underline")

local function toggle_underline()
  local bufnr = vim.api.nvim_get_current_buf()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  row = row - 1 -- Adjust for 0-indexing
  local pos = { row, col }

  -- Check for existing underlines
  local existing = vim.api.nvim_buf_get_extmarks(bufnr, underline_ns, pos, pos, {})
  if #existing > 0 then
    -- Remove underline
    for _, mark in ipairs(existing) do
      vim.api.nvim_buf_del_extmark(bufnr, underline_ns, mark[1])
    end
  else
    -- Add underline
    vim.api.nvim_buf_set_extmark(bufnr, underline_ns, row, col, {
      end_row = row,
      end_col = col + 1,
      hl_group = "Underlined",
      hl_eol = true,
    })
  end
end

-- Define the 'Underlined' highlight group
vim.api.nvim_command("highlight Underlined cterm=underline gui=underline")

-- Make the function globally accessible
_G.toggle_underline = toggle_underline

-- Map the 'z' key to the global Lua function
vim.api.nvim_set_keymap("n", "z", ":lua _G.toggle_underline()<CR>", { noremap = true, silent = true })
---------------
------------

--Sets marks to go to specific col number as well as line and adds them to the jump list
vim.api.nvim_set_keymap("n", "m<key>", ':lua set_mark_extmark("<key>")<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gm<key>", ':lua goto_mark_extmark("<key>")<CR>', { noremap = true, silent = true })

local mark_ns = vim.api.nvim_create_namespace("marks")

vim.api.nvim_set_keymap("n", "<A-l>", ":vertical resize +5<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<A-h>", ":vertical resize -5<CR>", { noremap = true, silent = true })

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
  -- Enter visual mode, select the word, and call the visual mode function
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
