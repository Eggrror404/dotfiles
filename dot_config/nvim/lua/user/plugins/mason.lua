local utils = require "astrocommunity.utils"
-- customize mason plugins
return {
  -- use mason-lspconfig to configure LSP installations
  {
    "williamboman/mason-lspconfig.nvim",
    -- overrides `require("mason-lspconfig").setup(...)`
    opts = function(_, opts)
      if not opts.ensure_installed then opts.ensure_installed = {} end
      -- ensure_installed = { "lua_ls" },
      utils.list_insert_unique(opts.ensure_installed, { "ltex" })
    end,
  },
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  {
    "jay-babu/mason-null-ls.nvim",
    -- overrides `require("mason-null-ls").setup(...)`
    -- opts = {
    -- ensure_installed = { "prettier", "stylua" },
    -- },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    -- overrides `require("mason-nvim-dap").setup(...)`
    -- opts = {
    -- ensure_installed = { "python" },
    -- },
  },
}
