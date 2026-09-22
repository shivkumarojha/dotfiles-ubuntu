-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Force signcolumn to always stay open and fixed at 1-column wide bug- crashing
-- on faster updated and formatting
vim.opt.signcolumn = "yes:1"

vim.opt.wrap = true
vim.opt.textwidth = 80
vim.opt.breakindent = true
--vim.opt.showbreak = "↳ "
vim.opt.linebreak = true
vim.opt.wrapmargin = 2
vim.opt.spell = false

-- Keep the autoformat off
vim.g.autoformat = false
vim.o.laststatus = 0

-- Disable whitespace characters globally
vim.opt.list = false
vim.g.lazyvim_picker = "snacks"

-- ruby related
vim.g.lazyvim_ruby_lsp = "ruby_lsp"
vim.g.lazyvim_ruby_formatter = "rubocop"


-- Automatically read files when they change on disk
vim.o.autoread = true

-- Trigger checktime on FocusGained, BufEnter, CursorHold, CursorHoldI
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  callback = function()
    if vim.fn.mode() ~= "c" then
      vim.cmd("checktime")
    end
  end,
})

-- Notification after file change
vim.api.nvim_create_autocmd("FileChangedShellPost", {
  callback = function()
    vim.notify("File changed on disk. Buffer reloaded.", vim.log.levels.WARN)
  end,
})

vim.g.root_spec = { "cwd" }
