return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = {
        enabled = false,
      },
      servers = {
        ---@type lspconfig.settings.tsgo
        tsgo = {
          filetypes = {
            "javascript",
            "javascriptreact",
            "javascript.jsx",
            "typescript",
            "typescriptreact",
            "typescript.tsx",
          },
          capabilities = {
            workspace = {
              didChangeConfiguration = { dynamicRegistration = false },
            },
          },
          settings = {
            typescript = {
              -- 1. Inlay hints configuration block ends here
              inlayHints = {
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = false },
                parameterNames = {
                  enabled = "literals",
                  suppressWhenArgumentMatchesName = true,
                },
                parameterTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = { enabled = false },
              },
              -- 2. Suggestion block MUST be a sibling to inlayHints, not inside it
              suggest = {
                autoImports = true,
                completeFunctionCalls = true,
              },
              workspaceSymbols = {
                scope = "all", 
              },
              tsdk = "node_modules/typescript/lib",
              plugins = {
                {
                  name = "next",
                  location = "node_modules/next",
                },
              },
            },
            javascript = {
              suggest = {
                autoImports = true,
              },
            },
          },
        },
      },
    },
  },
}

