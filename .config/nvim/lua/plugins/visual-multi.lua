return {
  "mg979/vim-visual-multi",
  branch = "master",
  lazy = false, -- Ensure the plugin loads immediately
  config = function()
    vim.g.VM_maps = vim.tbl_extend("force", vim.g.VM_maps or {}, {
      ["I Return"] = "",
    })
  end,
}
