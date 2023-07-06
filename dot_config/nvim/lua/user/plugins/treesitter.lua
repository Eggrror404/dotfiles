local utils = require "astronvim.utils"

return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    -- Ensure that opts.ensure_installed exists and is a table
    if not opts.ensure_installed then opts.ensure_installed = {} end
    -- Add to ensure_installed
    utils.list_insert_unique(opts.ensure_installed, { "bash", "rasi", "scss", "yuck" })
  end,
}
