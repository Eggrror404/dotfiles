local utils = require "astrocommunity.utils"
local null_ls = require "null-ls"
-- customize mason plugins
return {
  -- use mason-lspconfig to configure LSP installations
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts)
      -- Ensure that opts.ensure_installed exists and is a table
      if not opts.ensure_installed then opts.ensure_installed = {} end
      -- Add lsp to ensure_installed
      utils.list_insert_unique(opts.ensure_installed, { "ltex", "bashls", "lemminx" })
    end,
  },
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  {
    "jay-babu/mason-null-ls.nvim",
    opts = function(_, opts)
      -- Ensure that opts.ensure_installed exists and is a table
      if not opts.ensure_installed then opts.ensure_installed = {} end
      -- Add to ensure_installed
      utils.list_insert_unique(opts.ensure_installed, { "shfmt" })

      opts.handlers.shfmt = function(source_name, methods)
        null_ls.register(null_ls.builtins.formatting.shfmt.with {
          extra_args = { "-i", "2", "-ci" },
        })
      end
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    -- overrides `require("mason-nvim-dap").setup(...)`
    -- opts = {
    -- ensure_installed = { "python" },
    -- },
  },
}
