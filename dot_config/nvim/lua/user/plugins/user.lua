return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lsp_signature").setup()
  --   end,
  -- },

  -- Grammar lsp (with ltex)
  {
    "brymer-meneses/grammar-guard.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "williamboman/mason.nvim",
    },
    ft = { "md", "txt", "tex" },
    config = function() require("grammar-guard").init() end,
  },
  {
    "frabjous/knap",
    ft = { "md", "tex" },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
  },
}
