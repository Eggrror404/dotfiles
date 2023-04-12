return {
  -- Add the community repository of plugin specifications
  "AstroNvim/astrocommunity",
  -- example of imporing a plugin, comment out to use it or add your own
  -- available plugins can be found at https://github.com/AstroNvim/astrocommunity

  { import = "astrocommunity.colorscheme.catppuccin" },
  {
    -- further customize the options set by the community
    "catppuccin",
    opts = {
      flavour = "macchiato",
      transparent_background = true,
      custom_highlights = function(colors)
        return {
          Whitespace = { fg = colors.flamingo },
        }
      end,
    },
  },
  -- { import = "astrocommunity.pack.bash" },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.svelte" },
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.yaml" },

  { import = "astrocommunity.editing-support.nvim-ts-rainbow2" },

  -- { import = "astrocommunity.completion.copilot-lua-cmp" },
}
