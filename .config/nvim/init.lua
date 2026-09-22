-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Redirect all unhandled UI/Lua exceptions directly to a local text log
vim.errorhandler = function(err)
  local file = io.open(vim.fn.stdpath("data") .. "/crash_debug.txt", "a")
  if file then
    file:write(os.date("%Y-%m-%d %H:%M:%S") .. " - " .. tostring(err) .. "\n" .. debug.traceback() .. "\n\n")
    file:close()
  end
  return err
end

