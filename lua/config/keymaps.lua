-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
vim.keymap.set("n", "<C-c>", "gcc", { desc = "Toggle comment", remap = true })
vim.keymap.set("x", "<C-c>", "gc", { desc = "Toggle comment", remap = true })

local function safe_del(mode, lhs)
  pcall(vim.keymap.del, mode, lhs)
end

local function set_repeat(sequence)
  if vim.fn.exists("*repeat#set") == 1 then
    vim.fn["repeat#set"](sequence, vim.v.count)
  end
end

local function make_repeatable(action)
  return function()
    _G.user_repeat = _G.user_repeat or {}
    _G.user_repeat.repeat_action = function()
      action()
      if vim.fn.exists("*repeat#set") == 1 then
        local repeat_action =
          vim.api.nvim_replace_termcodes(string.format("<cmd>call %s()<cr>", vim.go.operatorfunc), true, true, true)
        vim.fn["repeat#set"](repeat_action, -1)
      end
    end

    vim.go.operatorfunc = "v:lua.user_repeat.repeat_action"
    vim.cmd("normal! g@l")
  end
end

safe_del({ "n", "t" }, "<C-/>")
safe_del({ "n", "t" }, "<C-_>")
vim.keymap.set("n", "<C-/>", "gcc", { desc = "Toggle comment", remap = true })
vim.keymap.set("n", "<C-_>", "gcc", { desc = "Toggle comment", remap = true })
vim.keymap.set("x", "<C-/>", "gc", { desc = "Toggle comment", remap = true })
vim.keymap.set("x", "<C-_>", "gc", { desc = "Toggle comment", remap = true })
vim.keymap.set("n", "<C-w>+", "<cmd>resize +10<cr>", { desc = "Increase window height by 10" })
vim.keymap.set("n", "<C-w>-", "<cmd>resize -10<cr>", { desc = "Decrease window height by 10" })
vim.keymap.set("n", "<C-w><", make_repeatable(function()
  vim.cmd("vertical resize -10")
end), { desc = "Decrease window width by 10" })
vim.keymap.set("n", "<C-w>>", make_repeatable(function()
  vim.cmd("vertical resize +10")
end), { desc = "Increase window width by 10" })

vim.keymap.set("x", "<Plug>(repeatable-indent-right)", function()
  vim.cmd.normal({ args = { ">gv" }, bang = true })
  set_repeat("gv>")
end, { desc = "Indent Right", silent = true })

vim.keymap.set("x", "<Plug>(repeatable-indent-left)", function()
  vim.cmd.normal({ args = { "<gv" }, bang = true })
  set_repeat("gv<")
end, { desc = "Indent Left", silent = true })

vim.keymap.set("x", ">", "<Plug>(repeatable-indent-right)", { remap = true, desc = "Indent Right" })
vim.keymap.set("x", "<", "<Plug>(repeatable-indent-left)", { remap = true, desc = "Indent Left" })

vim.keymap.set("n", "P", function()
  local lines = vim.fn.getreg(vim.v.register, 1, true)

  for _ = 1, vim.v.count1 do
    vim.api.nvim_put(lines, "l", false, true)
  end
end, { desc = "Paste as line above" })

vim.keymap.set("n", "<leader>mp", function()
  local path = vim.fn.expand("%:.")

  if path == "" then
    vim.notify("Current buffer has no file path", vim.log.levels.WARN)
    return
  end

  vim.fn.setreg("+", path)
  vim.notify("Copied: " .. path)
end, { desc = "Copy relative path" })

vim.keymap.set("n", "<leader>mP", function()
  local path = vim.fn.expand("%:.")

  if path == "" then
    vim.notify("Current buffer has no file path", vim.log.levels.WARN)
    return
  end

  local location = string.format("%s:%d", path, vim.api.nvim_win_get_cursor(0)[1])
  vim.fn.setreg("+", location)
  vim.notify("Copied: " .. location)
end, { desc = "Copy relative path with line" })
