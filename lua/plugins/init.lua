local plugins = {
  -- Plugin manager
  {
    "folke/lazy.nvim",
  },

  -- Load plugins from separate files
  require("plugins.editor"),
  require("plugins.ui"),
  require("plugins.lsp"),
  require("plugins.tools"),
}

local opts = {
  install = {
    colorscheme = { "tokyonight" },
  },
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
}

require("lazy").setup(plugins, opts)
