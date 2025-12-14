local telescope = require("telescope")

telescope.setup({
  defaults = {
    layout_strategy = "vertical",
    layout_config = {
      height = 0.8,
      width = 0.8,
    },
  },
})
