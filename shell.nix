{pkgs, lib, config, ...}: {
  home.packages = [
    pkgs.nixfmt-rfc-style
    pkgs.cowsay
    pkgs.starship
    pkgs.github-cli
    pkgs.btop
    pkgs.gemini-cli
    pkgs.tailscale
    pkgs.gping
    
    # LazyVim core dependencies
    pkgs.ripgrep
    pkgs.fd
    pkgs.lazygit
    pkgs.gcc
    
    # Useful tools LazyVim expects
    pkgs.tree-sitter
    pkgs.nodejs  # For many LSPs and formatters
    pkgs.cargo   # For rust-based tools
  ];
  
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    settings = {
      "$schema" = "https://starship.rs/config-schema.json";
      
      format = lib.concatStrings [
        "[](color_orange)"
        "$os"
        "$username"
        "$hostname"
        "[](bg:color_yellow fg:color_orange)"
        "$directory"
        "[](fg:color_yellow bg:color_aqua)"
        "$git_branch"
        "$git_status"
        "[](fg:color_aqua bg:color_blue)"
        "$c"
        "$rust"
        "$golang"
        "$nodejs"
        "$php"
        "$java"
        "$kotlin"
        "$haskell"
        "$python"
        "[](fg:color_blue bg:color_bg3)"
        "$kubernetes"
        "$docker_context"
        "$conda"
        "[](fg:color_bg3 bg:color_bg1)"
        "$time"
        "[ ](fg:color_bg1)"
        "$line_break$character"
      ];
      
      palette = lib.mkForce "tokyonight";
      
      palettes.tokyonight = {
        color_fg0 = "#1a1b26";
        color_bg1 = "#414868";
        color_bg3 = "#565f89";
        color_blue = "#7aa2f7";
        color_aqua = "#7dcfff";
        color_green = "#9ece6a";
        color_orange = "#ff9e64";
        color_purple = "#bb9af7";
        color_red = "#f7768e";
        color_yellow = "#e0af68";
      };
      
      os = {
        disabled = false;
        style = "bg:color_orange fg:color_fg0";
        symbols = {
          Arch = "󰣇 ";
          Linux = "󰌽 ";
          Macos = "󰀵 ";
          NixOS = " ";
        };
      };
      
      username = {
        show_always = true;
        style_user = "bg:color_orange fg:color_fg0";
        format = "[$user]($style)";
      };
      
      hostname = {
        ssh_only = true;
        style = "bg:color_orange fg:color_fg0";
        format = "[@$hostname ]($style)";
      };
      
      kubernetes = {
        symbol = " ";
        style = "fg:color_fg0 bg:color_bg3";
        format = "[ $symbol$context ]($style)";
        disabled = false;
      };
      
      directory = {
        style = "fg:color_fg0 bg:color_yellow";
        format = "[ $path ]($style)";
        truncation_length = 3;
      };
      
      git_branch = {
        symbol = "";
        style = "bg:color_aqua";
        format = "[[ $symbol $branch ](fg:color_fg0 bg:color_aqua)]($style)";
      };
      
      git_status = {
        style = "bg:color_aqua";
        format = "[[($all_status$ahead_behind )](fg:color_fg0 bg:color_aqua)]($style)";
      };
      
      time = {
        disabled = false;
        time_format = "%R";
        style = "bg:color_bg1";
        format = "[[  $time ](fg:color_fg0 bg:color_bg1)]($style)";
      };
      
      character = {
        success_symbol = "[](bold fg:color_green)";
        error_symbol = "[](bold fg:color_red)";
      };
      
      nodejs.symbol = "";
      python.symbol = "";
      rust.symbol = "";
      golang.symbol = "";
      docker_context.symbol = "";
    };
  };
  
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
  };
  
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    viAlias = true;
    vimdiffAlias = true;
    
    # Add LSPs and tools that LazyVim will use
    extraPackages = with pkgs; [
      # Nix
      nil
      nixd
      alejandra
      
      # Lua (for nvim config)
      lua-language-server
      stylua
      
      # Common LSPs - add what you need
      # nodePackages.typescript-language-server
      # pyright
      # rust-analyzer
    ];
  };
  
  # LazyVim config files
  home.file.".config/nvim/init.lua".text = ''
    -- Bootstrap lazy.nvim
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not vim.loop.fs_stat(lazypath) then
      vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
      })
    end
    vim.opt.rtp:prepend(lazypath)
    
    -- Set leader before lazy
    vim.g.mapleader = " "
    vim.g.maplocalleader = "\\"
    
    -- Load lazy
    require("lazy").setup({
      spec = {
        { "LazyVim/LazyVim", import = "lazyvim.plugins" },
        { import = "plugins" },
      },
      defaults = {
        lazy = false,
        version = false,
      },
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
  '';
  
  home.file.".config/nvim/lua/config/lazy.lua".text = ''
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not vim.loop.fs_stat(lazypath) then
      vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
      })
    end
    vim.opt.rtp:prepend(vim.env.LAZY or lazypath)
    
    require("lazy").setup({
      spec = {
        { "LazyVim/LazyVim", import = "lazyvim.plugins" },
        { import = "plugins" },
      },
      defaults = {
        lazy = false,
        version = false,
      },
      install = { colorscheme = { "tokyonight", "habamax" } },
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
  '';
  
  home.file.".config/nvim/lua/config/options.lua".text = ''
    -- Options are automatically loaded before lazy.nvim startup
    -- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
    
    vim.g.mapleader = " "
    vim.g.maplocalleader = "\\"
    
    local opt = vim.opt
    
    opt.number = true
    opt.relativenumber = true
    opt.autowrite = true
    opt.clipboard = "unnamedplus"
    opt.completeopt = "menu,menuone,noselect"
    opt.conceallevel = 3
    opt.confirm = true
    opt.cursorline = true
    opt.expandtab = true
    opt.formatoptions = "jcroqlnt"
    opt.grepformat = "%f:%l:%c:%m"
    opt.grepprg = "rg --vimgrep"
    opt.ignorecase = true
    opt.inccommand = "nosplit"
    opt.laststatus = 3
    opt.list = true
    opt.mouse = "a"
    opt.pumblend = 10
    opt.pumheight = 10
    opt.scrolloff = 4
    opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
    opt.shiftround = true
    opt.shiftwidth = 2
    opt.shortmess:append({ W = true, I = true, c = true, C = true })
    opt.showmode = false
    opt.sidescrolloff = 8
    opt.signcolumn = "yes"
    opt.smartcase = true
    opt.smartindent = true
    opt.spelllang = { "en" }
    opt.splitbelow = true
    opt.splitkeep = "screen"
    opt.splitright = true
    opt.tabstop = 2
    opt.termguicolors = true
    opt.timeoutlen = 300
    opt.undofile = true
    opt.undolevels = 10000
    opt.updatetime = 200
    opt.virtualedit = "block"
    opt.wildmode = "longest:full,full"
    opt.winminwidth = 5
    opt.wrap = false
    opt.fillchars = {
      foldopen = "",
      foldclose = "",
      fold = " ",
      foldsep = " ",
      diff = "╱",
      eob = " ",
    }
  '';
  
  home.file.".config/nvim/lua/config/keymaps.lua".text = ''
    -- Keymaps are automatically loaded on the VeryLazy event
    -- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
    
    local map = vim.keymap.set
    
    -- Better up/down
    map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
    map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
    
    -- Move to window using the <ctrl> hjkl keys
    map("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
    map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
    map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
    map("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })
    
    -- Resize window using <ctrl> arrow keys
    map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
    map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
    map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
    map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })
    
    -- Clear search with <esc>
    map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })
    
    -- Save file
    map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })
    
    -- Better indenting
    map("v", "<", "<gv")
    map("v", ">", ">gv")
    
    -- Add undo break-points
    map("i", ",", ",<c-g>u")
    map("i", ".", ".<c-g>u")
    map("i", ";", ";<c-g>u")
  '';
  
  home.file.".config/nvim/lua/config/autocmds.lua".text = ''
    -- Autocmds are automatically loaded on the VeryLazy event
    -- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
    
    local function augroup(name)
      return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
    end
    
    -- Check if we need to reload the file when it changed
    vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
      group = augroup("checktime"),
      callback = function()
        if vim.o.buftype ~= "nofile" then
          vim.cmd("checktime")
        end
      end,
    })
    
    -- Highlight on yank
    vim.api.nvim_create_autocmd("TextYankPost", {
      group = augroup("highlight_yank"),
      callback = function()
        vim.highlight.on_yank()
      end,
    })
    
    -- Resize splits if window got resized
    vim.api.nvim_create_autocmd({ "VimResized" }, {
      group = augroup("resize_splits"),
      callback = function()
        local current_tab = vim.fn.tabpagenr()
        vim.cmd("tabdo wincmd =")
        vim.cmd("tabnext " .. current_tab)
      end,
    })
    
    -- Close some filetypes with <q>
    vim.api.nvim_create_autocmd("FileType", {
      group = augroup("close_with_q"),
      pattern = {
        "PlenaryTestPopup",
        "help",
        "lspinfo",
        "man",
        "notify",
        "qf",
        "query",
        "spectre_panel",
        "startuptime",
        "tsplayground",
        "neotest-output",
        "checkhealth",
        "neotest-summary",
        "neotest-output-panel",
      },
      callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
      end,
    })
  '';
  
  home.file.".config/nvim/lua/plugins/.gitkeep".text = "";
}