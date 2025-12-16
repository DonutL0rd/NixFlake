vim.g.mapleader = " "

require("lazy").setup({
  spec = {
    {
      "LazyVim/LazyVim",
      import = "lazyvim.plugins",
      opts = {
        colorscheme = "tokyonight",
      },
    },
    
    -- LazyVim extras
    { import = "lazyvim.plugins.extras.editor.aerial" },
    { import = "lazyvim.plugins.extras.editor.telescope" },
    { import = "lazyvim.plugins.extras.formatting.prettier" },
    { import = "lazyvim.plugins.extras.lang.json" },
    { import = "lazyvim.plugins.extras.lang.yaml" },
    { import = "lazyvim.plugins.extras.lang.docker" },
    { import = "lazyvim.plugins.extras.lang.git" },
    { import = "lazyvim.plugins.extras.ui.mini-animate" },
    
    { import = "plugins" },
  },
  defaults = {
    lazy = false,
    version = false,
  },
  install = { colorscheme = { "tokyonight" } },
  checker = { enabled = true },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
