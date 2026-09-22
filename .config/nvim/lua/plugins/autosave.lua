return {
  "Pocco81/auto-save.nvim",
  lazy = false,
  opts = {
    debounce_delay = 2000,
    execution_message = {
      message = function()
        return ""
      end,
    },
    condition = function(buf)
      local fn = vim.fn
      if not vim.api.nvim_buf_is_valid(buf) then
        return false
      end

      local filetype = vim.bo[buf].filetype

      -- Exclude temp UIs
      if filetype == "harpoon" or filetype == "TelescopePrompt" or filetype == "neo-tree" then
        return false
      end

      return fn.getbufvar(buf, "&modifiable") == 1
    end,
  },
  keys = {
    { "<leader>uv", "<cmd>ASToggle<CR>", desc = "Toggle autosave" },
  },
}
