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
  { import = "astrocommunity.pack.cpp" },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.svelte" },
  { import = "astrocommunity.pack.tailwindcss" },
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.yaml" },

  { import = "astrocommunity.editing-support.rainbow-delimiters-nvim" },
  { import = "astrocommunity.editing-support.todo-comments-nvim" },
  { import = "astrocommunity.motion.nvim-surround" },
  { import = "astrocommunity.project.project-nvim" },
}
