return {
  "nickjvandyke/opencode.nvim",
  version = "*", -- Latest stable release
  dependencies = {
    {
      -- `snacks.nvim` integration for custom picker mappings
      "folke/snacks.nvim",
      optional = true,
      opts = {
        input = {}, -- Enhances `ask()`
        picker = { -- Enhances `select()`
          actions = {
            opencode_send = function(...)
              return require("opencode").snacks_picker_send(...)
            end,
          },
          win = {
            input = {
              keys = {
                ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
              },
            },
          },
        },
      },
    },
  },
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      -- Standard configuration defaults
    }

    vim.o.autoread = true -- Required for tracking live OpenCode file rewrites

    ----------------------------------------------------------------------
    -- NEW FUNCTIONALITY: Copy Visual Selection + File Origin for External OpenCode
    ----------------------------------------------------------------------
    vim.keymap.set("x", "<leader>oc", function()
      -- Get file path relative to current working directory
      local file_path = vim.fn.expand("%:.")

      -- Fetch lines for the current visual selection boundaries
      local start_line = vim.fn.line("v")
      local end_line = vim.fn.line(".")
      if start_line > end_line then
        start_line, end_line = end_line, start_line
      end

      local lines = vim.fn.getline(start_line, end_line)
      local selection = table.concat(lines, "\n")
      local filetype = vim.bo.filetype

      -- Format exactly into markdown using OpenCode origin semantics
      local markdown_output =
        string.format("Origin: @%s#L%d-L%d\n```%s\n%s\n```", file_path, start_line, end_line, filetype, selection)

      -- Yield to system clipboard
      vim.fn.setreg("+", markdown_output)
      vim.notify("Copied block + origin reference to clipboard for OpenCode!")
    end, { desc = "Copy block & origin to OpenCode" })

    ----------------------------------------------------------------------
    -- Native Plugin Keymaps (For local buffer controls)
    ----------------------------------------------------------------------
    vim.keymap.set({ "n", "x" }, "<C-a>", function()
      require("opencode").ask("@this: ", { submit = true })
    end, { desc = "Ask opencode…" })
    vim.keymap.set({ "n", "x" }, "<C-x>", function()
      require("opencode").select()
    end, { desc = "Execute opencode action…" })
    vim.keymap.set({ "n", "t" }, "<C-.>", function()
      require("opencode").toggle()
    end, { desc = "Toggle opencode" })

    vim.keymap.set({ "n", "x" }, "go", function()
      return require("opencode").operator("@this ")
    end, { desc = "Add range to opencode", expr = true })
    vim.keymap.set("n", "goo", function()
      return require("opencode").operator("@this ") .. "_"
    end, { desc = "Add line to opencode", expr = true })

    vim.keymap.set("n", "<S-C-u>", function()
      require("opencode").command("session.half.page.up")
    end, { desc = "Scroll opencode up" })
    vim.keymap.set("n", "<S-C-d>", function()
      require("opencode").command("session.half.page.down")
    end, { desc = "Scroll opencode down" })

    -- Keeps number increments working natively by mapping alternative keys
    vim.keymap.set("n", "+", "<C-a>", { desc = "Increment under cursor", noremap = true })
    vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement under cursor", noremap = true })
  end,
}
