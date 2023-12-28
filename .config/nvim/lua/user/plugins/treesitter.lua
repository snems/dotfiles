return {
  "nvim-treesitter/nvim-treesitter",
  cond = false,
  opts = {
    indent = { enable = false },
  },
  config = require "plugins.configs.nvim-treesitter",
}
