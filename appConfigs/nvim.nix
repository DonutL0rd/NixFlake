{pkgs, lib, config, ...}: {
  home.packages = with pkgs; [
    # LazyVim core dependencies
    ripgrep
    fd
    lazygit
    gcc
    gnumake
    
    # Essential tooling
    tree-sitter
    nodejs_20
    cargo
    go
    python3
    
    # Shell/terminal
    fzf
    delta
  ];
  
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    viAlias = true;
    vimdiffAlias = true;
    
    extraPackages = with pkgs; [
      # Nix
      nil
      nixd
      alejandra
      
      # Lua
      lua-language-server
      stylua
      
      # Shell
      nodePackages.bash-language-server
      shfmt
      shellcheck
      
      # YAML/JSON/TOML
      nodePackages.yaml-language-server
      nodePackages.vscode-langservers-extracted
      taplo
      
      # Markdown
      marksman
      
      # Docker
      nodePackages.dockerfile-language-server-nodejs
    ];
  };
  
  # LazyVim configuration files
  home.file.".config/nvim/init.lua".text = ''
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not (vim.uv or vim.loop).fs_stat(lazypath) then
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
    
    require("config.lazy")
  '';
  
  home.file.".config/nvim/lua/config/lazy.lua".text = ''
    vim.g.mapleader = " "
    vim.g.maplocalleader = "\\"
    
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
        { import = "lazyvim.plugins.extras.coding.yanky" },
        { import = "lazyvim.plugins.extras.editor.aerial" },
        { import = "lazyvim.plugins.extras.editor.telescope" },
        { import = "lazyvim.plugins.extras.formatting.prettier" },
        { import = "lazyvim.plugins.extras.lang.json" },
        { import = "lazyvim.plugins.extras.lang.markdown" },
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
  '';
  
home.file.".config/nvim/lua/config/options.lua".text = ''
  vim.g.mapleader = " "
  vim.g.maplocalleader = "\\"
  
  local opt = vim.opt
  
  opt.number = true
  opt.relativenumber = true
  opt.autowrite = true
  opt.clipboard = "unnamedplus"
  opt.completeopt = "menu,menuone,noselect"
  opt.conceallevel = 2
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
  
  if vim.fn.has("nvim-0.10") == 1 then
    opt.smoothscroll = true
  end
'';
  
  home.file.".config/nvim/lua/config/keymaps.lua".text = ''
    local map = vim.keymap.set
    
    map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
    map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
    
    map("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
    map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
    map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
    map("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })
    
    map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
    map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
    map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
    map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })
    
    map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
    map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
    map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
    map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
    map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
    map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })
    
    map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })
    map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })
    
    map("v", "<", "<gv")
    map("v", ">", ">gv")
    
    map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })
    map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })
    map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })
    
    map("n", "<leader>ww", "<C-W>p", { desc = "Other window", remap = true })
    map("n", "<leader>wd", "<C-W>c", { desc = "Delete window", remap = true })
    map("n", "<leader>w-", "<C-W>s", { desc = "Split window below", remap = true })
    map("n", "<leader>w|", "<C-W>v", { desc = "Split window right", remap = true })
    
    map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
    map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
    map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
    map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
    map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
    map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
  '';
  
  home.file.".config/nvim/lua/config/autocmds.lua".text = ''
    local function augroup(name)
      return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
    end
    
    vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
      group = augroup("checktime"),
      callback = function()
        if vim.o.buftype ~= "nofile" then
          vim.cmd("checktime")
        end
      end,
    })
    
    vim.api.nvim_create_autocmd("TextYankPost", {
      group = augroup("highlight_yank"),
      callback = function()
        vim.highlight.on_yank()
      end,
    })
    
    vim.api.nvim_create_autocmd({ "VimResized" }, {
      group = augroup("resize_splits"),
      callback = function()
        local current_tab = vim.fn.tabpagenr()
        vim.cmd("tabdo wincmd =")
        vim.cmd("tabnext " .. current_tab)
      end,
    })
    
    vim.api.nvim_create_autocmd("BufReadPost", {
      group = augroup("last_loc"),
      callback = function(event)
        local exclude = { "gitcommit" }
        local buf = event.buf
        if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
          return
        end
        vim.b[buf].lazyvim_last_loc = true
        local mark = vim.api.nvim_buf_get_mark(buf, '"')
        local lcount = vim.api.nvim_buf_line_count(buf)
        if mark[1] > 0 and mark[1] <= lcount then
          pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
      end,
    })
    
    vim.api.nvim_create_autocmd("FileType", {
      group = augroup("close_with_q"),
      pattern = {
        "PlenaryTestPopup",
        "help",
        "lspinfo",
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
        "aerial",
      },
      callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
      end,
    })
    
    vim.api.nvim_create_autocmd("FileType", {
      group = augroup("wrap_spell"),
      pattern = { "gitcommit", "markdown" },
      callback = function()
        vim.opt_local.wrap = true
      end,
    })
    
    vim.api.nvim_create_autocmd({ "BufWritePre" }, {
      group = augroup("auto_create_dir"),
      callback = function(event)
        if event.match:match("^%w%w+:[\\/][\\/]") then
          return
        end
        local file = vim.uv.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
      end,
    })
  '';
  
  home.file.".config/nvim/lua/plugins/custom.lua".text = ''
    return {
      {
        "folke/trouble.nvim",
        cmd = { "TroubleToggle", "Trouble" },
        opts = { use_diagnostic_signs = true },
        keys = {
          { "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
          { "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
          { "<leader>xL", "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
          { "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
        },
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
    }
  '';
}
