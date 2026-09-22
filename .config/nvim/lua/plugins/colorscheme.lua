return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
  --    flavour = "mocha", -- Explicitly set Mocha
      transparent_background = true, -- No background, shows terminal
      integrations = { -- Enable support for LazyVim plugins
        treesitter = true,
        lsp_trouble = true,
        which_key = true,
        telescope = true,
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-mocha",
    },
  },
}
