-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  -- first key is the mode
  n = {
    -- second key is the lefthand side of the map
    -- mappings seen under group name "Buffer"
    ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(
          function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
        )
      end,
      desc = "Pick to close",
    },
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<leader>b"] = { name = "Buffers" },
    -- quick save
    -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
    ["<leader>fu"] = { "<cmd>Telescope undo<cr>", desc = "Undo tree" },
    ["<leader>ft"] = { "<cmd>TodoTelescope<cr>", desc = "Todo Comments" },
    ["<leader>fT"] = {
      function() require("telescope.builtin").colorscheme { enable_preview = true } end,
      desc = "Find themes",
    },

    -- overrides the default lazygit setting.
    -- still executes `lazygit`, needs a symbolic link
    ["<leader>gg"] = { desc = "ToggleTerm gitui" },
    ["<leader>tl"] = { desc = "ToggleTerm gitui" },

    ["<S-l>"] = {
      function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
      desc = "Next buffer",
    },
    ["<S-h>"] = {
      function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
      desc = "Previous buffer",
    },
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
    ["<C-h>"] = [[<Cmd>wincmd h<CR>]],
    ["<C-j>"] = [[<Cmd>wincmd j<CR>]],
    ["<C-k>"] = [[<Cmd>wincmd k<CR>]],
    ["<C-l>"] = [[<Cmd>wincmd l<CR>]],
    ["<C-w>"] = [[<C-\><C-n><C-w>]],
  },
}
