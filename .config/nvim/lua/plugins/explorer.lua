return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    picker = {
      enabled = true,
      ignored = true,
      cwd = true, -- Forces explorer to use the CWD of the current tab
      exclude = { -- add folder names here to exclude
        ".git",
        "node_modules",
        -- "migrations",
      },
      sources = {
        explorer = {
          cwd = true, -- Forces explorer to use the CWD of the current tab
          follow = true, -- Automatically scrolls to the current file in the sidebar
          auto_close = true, -- automatically close the explorer
          hidden = true,
          layout = {
            finder = "explorer",
            layout = {
              preset = "sidebar",
              preview = false,
              position = "right",
              width = 35,
            },
            cycle = false,
          },
        },
      },
      win = {
        input = {
          keys = {
            ["<a-h>"] = false, -- unbind <a-h>
          },
        },
        list = {
          keys = {
            ["<a-h>"] = false, -- unbind <a-h> here too
          },
        },
      },
    },
  },
  keys = {
    {
      "<leader>e",
      function()
        -- Snacks.explorer() -- just focus on the explorer
        Snacks.explorer.open() -- open hide explorer
      end,
      desc = "Open Snacks Picker",
    },
  },
}
