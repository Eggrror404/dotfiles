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

  -- Yuck language support
  { "elkowar/yuck.vim", ft = "yuck" },

  -- Surround chars
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "User AstroFile",
    config = function() require("nvim-surround").setup {} end,
  },

  -- TODO comments
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    event = "User AstroFile",
    config = function() require("todo-comments").setup {} end,
  },

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

  -- Rofi .rasi file support
  {
    "Fymyte/rasi.vim",
    ft = "rasi",
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "debugloop/telescope-undo.nvim",
    },
    config = function()
      require("telescope").setup {
        extensions = {
          undo = {
            -- telescope-undo.nvim config, see below
          },
        },
      }
      require("telescope").load_extension "undo"
      -- optional: vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")
    end,
  },

  {
    "frabjous/knap",
    ft = { "md", "tex" },
  },
}
