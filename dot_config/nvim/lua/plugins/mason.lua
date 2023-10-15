return {
  -- add any tools you want to have installed below
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "bashls",
        "ltex",
        "shfmt",
        "stylua",
      },
    },
  },

  {
    "stevearc/conform.nvim",
    opts = function()
      return {
        formatters = {
          shfmt = { extra_args = { "-i", "2", "-ci" } },
        },
      }
    end,
  },

  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "css",
        "diff",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "lua",
        "luap",
        "markdown",
        "markdown_inline",
        "python",
        "regex",
        "rust",
        "scss",
        "toml",
        "tsx",
        "typescript",
        "yaml",
        "yuck",
      },
    },
  },
}
