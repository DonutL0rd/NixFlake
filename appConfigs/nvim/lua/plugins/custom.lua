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

  -- Disable bufferline to remove tabs
  {
    "akinsho/bufferline.nvim",
    enabled = false,
  },
}
