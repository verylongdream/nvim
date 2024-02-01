-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
local toggle_checkbox = require("toggle-checkbox")

-- vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
--   pattern = "*",
--   callback = function()
--     vim.cmd("normal! m`")
--   end,
-- })
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  callback = function()
    vim.cmd("normal! m`")
  end,
})
local cmp = require("cmp")

vim.g.vimwiki_list = { { auto_diary_index = 1 } }
vim.api.nvim_create_autocmd("FileType", {
  pattern = "calendar",
  callback = function()
    vim.api.nvim_buf_set_keymap(
      0,
      "n",
      "<CR>",
      ':<C-u>call vimwiki#diary#calendar_action(b:calendar.day().get_day(), b:calendar.day().get_month(), b:calendar.day().get_year(), b:calendar.day().week(), "V")<CR>',
      { silent = true }
    )
  end,
})
cmp.setup({
  mapping = {
    ["<Tab>"] = cmp.mapping.confirm({ select = true }),
    ["<CR>"] = cmp.mapping(function(fallback)
      fallback()
    end, { "i", "s" }),
  },
  -- ... (rest of your configuration)
})

vim.api.nvim_set_keymap("n", "<C-A>", "ggVG", { noremap = true, silent = true })

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  command = "startinsert",
})
vim.api.nvim_create_user_command("StartServer", "Dispatch npm run start", {})

-- Normal mode: Move line up or down
vim.api.nvim_set_keymap("n", "<C-j>", ":m .+1<CR>==", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-k>", ":m .-2<CR>==", { noremap = true, silent = true })

-- Visual mode: Move selected lines up or down
vim.api.nvim_set_keymap("v", "<C-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<C-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
-- _G.grep_for_create = function()
--   local word = "create"
--   local results = vim.fn.systemlist("grep -nH " .. word .. " " .. vim.fn.expand("%:p"))
--   if #results == 0 then
--     print("No matches found")
--     return
--   end
--   vim.fn.setqflist({}, "r", { title = "Search results", lines = results })
--   vim.cmd("copen")
-- end
--
-- vim.api.nvim_set_keymap("n", "<Leader>B", "<cmd>lua _G.grep_for_create()<CR>", { noremap = true, silent = true })
_G.grep_create_in_qf = function()
  local word = ".ts" -- The word to search for in the quickfix list
  local qf_list = vim.fn.getqflist() -- Get the current quickfix list
  local new_qf_list = {} -- A table to store the filtered results

  -- Loop through each item in the quickfix list
  for _, item in ipairs(qf_list) do
    if item.text and item.text:match(word) then
      -- If the line contains the word, add it to the new quickfix list
      -- Make sure to include filename and line number for navigation
      table.insert(new_qf_list, {
        bufnr = item.bufnr,
        lnum = item.lnum,
        col = item.col,
        text = item.text,
      })
    end
  end

  if #new_qf_list == 0 then
    print("No matches found for '" .. word .. "' in the quickfix list")
    return
  end

  -- Set the new quickfix list with the filtered results
  vim.fn.setqflist({}, "r", { title = "Filtered search results", items = new_qf_list })
  vim.api.nvim_command("copen") -- Open the quickfix list window
end

vim.api.nvim_set_keymap("n", "<Leader>B", "<cmd>lua _G.grep_create_in_qf()<CR>", { noremap = true, silent = true })

-- vim.cmd([[set errorformat=%-Gnpm\_output.txt%\\,%f:%l:%m]])
vim.cmd([[set errorformat=%f:%l:%m]])
vim.cmd([[set grepprg=grep\ -nH\ --exclude-dir=node_modules]])

local function populate_quickfix()
  -- Ensure the errorformat is set correctly
  vim.o.errorformat = "%f:%l:%m"

  -- Run the grep command to populate the quickfix with entries excluding node_modules
  vim.fn.execute('silent grep -nH --exclude-dir=node_modules "^[^[]\\+" npm_output.txt')

  -- Open the quickfix window
  vim.cmd("cwindow")
end

-- Create a NeoVim command that calls the Lua function

vim.api.nvim_create_user_command("PopulateQuickfix", populate_quickfix, {})
