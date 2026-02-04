return {
  -- Theme: Kanagawa (Dragon variant for Coffee/Dark Roast vibe)
  {
    "rebelot/kanagawa.nvim",
    priority = 1000, -- Ensure it loads first
    config = function()
      require("kanagawa").setup({
        theme = "dragon",
        transparent = false, -- Solid background for consistency
        overrides = function(colors)
            local theme = colors.theme
            return {
                -- Force background to match Zellij's 'Roasted Bean' (#1d2021)
                Normal = { bg = "#1d2021" },
                NormalFloat = { bg = "#1d2021" },
                FloatBorder = { bg = "#1d2021", fg = "#504945" }, -- Subtle borders

                -- Unified UI elements
                TelescopeTitle = { fg = theme.ui.special, bold = true },
                TelescopePromptNormal = { bg = "#282828" }, -- Slightly lighter for input
                TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = "#1d2021" },
                
                -- Selection
                Visual = { bg = "#504945" },

                -- Which-key UI
                WhichKey = { fg = "#d5c4a1" }, -- Coffee cream (Standard Gruvbox light2)
                WhichKeyGroup = { fg = theme.syn.identifier },
                WhichKeyDesc = { fg = theme.ui.fg },
                WhichKeyFloat = { bg = "#1d2021" },
                WhichKeyBorder = { bg = "#1d2021", fg = "#504945" },

                -- Neo-tree
                NeoTreeNormal = { bg = "#1d2021" },
                NeoTreeNormalNC = { bg = "#1d2021" },
                NeoTreeDirectoryIcon = { fg = theme.syn.identifier },
                NeoTreeGitModified = { fg = theme.syn.string },
                NeoTreeGitAdded = { fg = theme.diag.ok },
                NeoTreeGitDeleted = { fg = theme.diag.error },

                -- Dashboard
                DashboardHeader = { fg = "#d5c4a1" }, -- Coffee cream
                DashboardCenter = { fg = theme.ui.fg },
                DashboardFooter = { fg = theme.ui.fg_dim },

                -- Bufferline
                BufferLineFill = { bg = "#1d2021" },
                BufferLineBackground = { bg = "#282828", fg = theme.ui.fg_dim },
                BufferLineBufferSelected = { bg = "#1d2021", fg = "#d5c4a1", bold = true },
                BufferLineIndicatorSelected = { fg = "#d5c4a1" },
            }
        end,
        background = {
          dark = "dragon",
          light = "lotus",
        },
      })
      vim.cmd("colorscheme kanagawa-dragon")
    end,
  },

  -- LazyVim expects tokyonight to be present by default. 
  -- We re-enable it to prevent errors, but Kanagawa (above) will override it due to priority.
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = { style = "storm" },
  },

  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = { "BufReadPost", "BufNewFile" },
    config = true,
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
      { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
      { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
      { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
    },
  },

  -- Re-enable bufferline with improved configuration
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous buffer" },
      { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
      { "<leader>bp", "<cmd>BufferLineTogglePin<cr>", desc = "Pin/Unpin buffer" },
      { "<leader>bP", "<cmd>BufferLineGroupClose ungrouped<cr>", desc = "Delete non-pinned buffers" },
    },
    opts = {
      options = {
        always_show_bufferline = false, -- Auto-hide when only one buffer
        close_icon = "",
        buffer_close_icon = "",
        diagnostics = "nvim_lsp",
        separator_style = "slant",
        offsets = {
          {
            filetype = "neo-tree",
            text = "File Explorer",
            highlight = "Directory",
            text_align = "left",
          },
        },
        diagnostics_indicator = function(count, level)
          local icon = level:match("error") and " " or " "
          return " " .. icon .. count
        end,
      },
    },
  },

  -- which-key.nvim: Keybinding discoverability
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "helix",
      delay = 400,
      spec = {
        { "<leader>b", group = "buffer" },
        { "<leader>c", group = "code" },
        { "<leader>f", group = "file/find" },
        { "<leader>g", group = "git" },
        { "<leader>s", group = "search" },
        { "<leader>u", group = "ui" },
        { "<leader>x", group = "diagnostics" },
        { "<leader>w", group = "windows" },
        { "<leader><tab>", group = "tabs" },
      },
    },
  },

  -- neo-tree.nvim: File explorer with git status
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    keys = {
      { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle file explorer" },
      { "<leader>E", "<cmd>Neotree float<cr>", desc = "Toggle floating file explorer" },
      { "<leader>fe", "<cmd>Neotree reveal<cr>", desc = "Reveal current file" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      close_if_last_window = true,
      popup_border_style = "rounded",
      enable_git_status = true,
      enable_diagnostics = true,
      filesystem = {
        follow_current_file = {
          enabled = true,
        },
        use_libuv_file_watcher = true,
      },
      window = {
        position = "left",
        width = 30,
        mappings = {
          ["l"] = "open",
          ["h"] = "close_node",
        },
      },
      default_component_configs = {
        git_status = {
          symbols = {
            added = "✚",
            modified = "",
            deleted = "✖",
            renamed = "➜",
            untracked = "★",
            ignored = "◌",
            unstaged = "✗",
            staged = "✓",
            conflict = "",
          },
        },
      },
    },
  },

  -- dashboard-nvim: Welcome screen
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      theme = "doom",
      config = {
        header = {
          "",
          "   ☕  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗  ☕",
          "      ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
          "      ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
          "      ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
          "      ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
          "      ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
          "",
          "                  Double Espresso Edition",
          "",
        },
        center = {
          {
            icon = "  ",
            desc = "Find file                               ",
            key = "f",
            action = "Telescope find_files",
          },
          {
            icon = "  ",
            desc = "New file                                ",
            key = "n",
            action = "enew",
          },
          {
            icon = "  ",
            desc = "Recent files                            ",
            key = "r",
            action = "Telescope oldfiles",
          },
          {
            icon = "  ",
            desc = "Find text                               ",
            key = "g",
            action = "Telescope live_grep",
          },
          {
            icon = "  ",
            desc = "File explorer                           ",
            key = "e",
            action = "Neotree toggle",
          },
          {
            icon = "  ",
            desc = "Lazy plugin manager                     ",
            key = "l",
            action = "Lazy",
          },
          {
            icon = "  ",
            desc = "Quit                                    ",
            key = "q",
            action = "quit",
          },
        },
        footer = function()
          local stats = require("lazy").stats()
          return {
            "",
            string.format("⚡ Loaded %d/%d plugins in %.2fms", stats.loaded, stats.count, stats.startuptime),
          }
        end,
      },
    },
  },
}
