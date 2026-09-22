return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    close_if_last_window = true,
    enable_git_status = true,
    enable_diagnostics = false,
    default_source = "filesystem",
    sources = {
      "filesystem",
      "buffers",
      "git_status",
    },
    source_selector = {
      winbar = false,
      statusline = false,
    },
    filesystem = {
      bind_to_cwd = true,
      follow_current_file = { enabled = true },
      use_libuv_file_watcher = true,
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_by_name = {
          ".git",
          "node_modules",
        },
      },
    },
    window = {
      position = "right",
      width = 25,
    },
    event_handlers = {
      {
        event = "file_opened",
        handler = function()
          require("neo-tree.command").execute({ action = "close" })
        end,
      },
    },
  },

  -- ✅ Use `keys = function()` to *extend* keymaps
  keys = function(_, keys)
    table.insert(keys, {
      "<leader>fe",
      function()
        require("neo-tree.command").execute({ toggle = true, source = "filesystem" })
      end,
      desc = "Neo-tree Explorer (Alt)",
    })
    return keys
  end,
}

