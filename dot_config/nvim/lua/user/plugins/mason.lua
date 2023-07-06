local utils = require "astronvim.utils"
-- customize mason plugins
return {
  {
    "williamboman/mason.nvim",
    opts = {
      log_level = vim.log.levels.DEBUG,
    },
  },
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

      for i, v in ipairs(opts.ensure_installed) do
        if v == "luacheck" then table.remove(opts.ensure_installed, i) end
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
