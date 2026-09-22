-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("i", "jj", "<ESC>", { silent = true })
vim.keymap.set("n", "<CapsLock>", "<Esc>", { noremap = true, silent = true })
vim.keymap.set("i", "<CapsLock>", "<Esc>", { noremap = true, silent = true })
vim.keymap.set("v", "<CapsLock>", "<Esc>", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>o", "m`o<Esc>``", { desc = "Insert line below" })
vim.keymap.set("n", "<Leader>O", "m`O<Esc>``", { desc = "Insert line above" })
vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Show diagnostics under cursor" })

-- autoimport with leader ii ---- Found this in normal kemaps leader + cM
-- vim.keymap.set("n", "<leader>ii", function()
--   vim.lsp.buf.code_action({
--     context = { only = { "quickfix", "source.addMissingImports.ts" }, diagnostics = {} },
--   })
-- end, { desc = "Import missing symbols" })

vim.keymap.set("n", "<C->", function()
  require("toggleterm").toggle()
end, { desc = "Toggle terminal" })

vim.keymap.set("n", "<leader>is", function()
  vim.cmd("write")
  vim.notify("Saved", vim.log.levels.INFO)
end, { desc = "Manual Save" })


-- Visual Mode: move selected lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move down", silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move up", silent = true })

-- Normal Mode: move current line
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down", silent = true })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up", silent = true })

-- mapping for opening neo-tree
vim.keymap.set("n", "<leader>fe", function()
  require("neo-tree.command").execute({ toggle = true, source = "filesystem" })
end, { desc = "Force Neo-tree open", silent = true })


-- Fix buffer crash on fast typing + rapid formatting
vim.keymap.set("n", "cf", function()
  local bufnr = vim.api.nvim_get_current_buf()
  -- 1. Safely freeze Treesitter highlighting on this buffer right before formatting
  pcall(function()
    vim.cmd("TSBufDisable highlight")
  end)

  -- 2. Run formatting synchronously to block background text collisions
  local status, conform = pcall(require, "conform")
  if status then
    conform.format({
      async = false,
      timeout_ms = 1000,
      lsp_fallback = true,
    })
  else
    vim.lsp.buf.format({ async = false })
  end

  -- 3. Safely unfreeze Treesitter highlighting now that text is stable
  pcall(function()
    vim.cmd("TSBufEnable highlight")
  end)
end, { desc = "Synchronous safe format" })


vim.keymap.set("n", "<leader>vi", function()
  local tmp_file = "/tmp/nvim_screenshot_ref.png"
  -- 1. Unpack clipboard data safely into tmp
  local cp_result = os.execute("wl-paste --type image/png > " .. tmp_file .. " 2>&1")
  if cp_result ~= 0 then
    vim.notify("Clipboard error: Ensure you have an image copied!", vim.log.levels.ERROR)
    return
  end
  -- 2. Run IMV visibly in background to trace binary missing traps
  local imv_result = os.execute("imv " .. tmp_file .. " &")
  if imv_result ~= 0 then
    vim.notify("Sway/IMV fail: Try running 'imv " .. tmp_file .. "' in an external terminal.", vim.log.levels.WARN)
  else
    vim.notify("Image window triggered successfully!", vim.log.levels.INFO)
  end
end, { desc = "Launch Image Viewer Window" })

-- Run the request under the cursor using <leader>r
vim.keymap.set("n", "<leader>r", "<cmd>Rest run<CR>", { desc = "Run HTTP request" })
