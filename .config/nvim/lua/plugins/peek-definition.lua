return {
  "rmagatti/goto-preview",
  dependencies = { "rmagatti/logger.nvim" }, -- Fixes core loader errors
  event = "BufEnter",
  config = function()
    require("goto-preview").setup({
      width = 100,
      height = 20,
      border = "rounded",
      default_mappings = false,
      focus_on_open = true,
      dismiss_on_move = false,
      force_close = true,
      stack_floating_preview_windows = true,
    })

    -- Explicitly declared global maps
    vim.keymap.set(
      "n",
      "gpd",
      "<cmd>lua require('goto-preview').goto_preview_definition()<CR>",
      { desc = "Peek Definition", noremap = true, silent = true }
    )
    vim.keymap.set(
      "n",
      "gpi",
      "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>",
      { desc = "Peek Implementation", noremap = true, silent = true }
    )
    vim.keymap.set(
      "n",
      "gpc",
      "<cmd>lua require('goto-preview').close_all_win()<CR>",
      { desc = "Close All Previews", noremap = true, silent = true }
    )

    -- Close the preview window by pressing Escape while focused inside it
    vim.keymap.set(
      "n",
      "<Esc>",
      "<cmd>lua require('goto-preview').close_all_win()<CR>",
      { desc = "Close Preview with Escape", noremap = true, silent = true }
    )
  end,
}
