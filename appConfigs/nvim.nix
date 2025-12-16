{pkgs, ...}: {
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
      # marksman

      # Docker
      nodePackages.dockerfile-language-server-nodejs
    ];
  };

  xdg.configFile = {
    "nvim/init.lua".source = ./nvim/init.lua;
    "nvim/lua/config/lazy.lua".source = ./nvim/lua/config/lazy.lua;
    "nvim/lua/config/options.lua".source = ./nvim/lua/config/options.lua;
    "nvim/lua/config/keymaps.lua".source = ./nvim/lua/config/keymaps.lua;
    "nvim/lua/config/autocmds.lua".source = ./nvim/lua/config/autocmds.lua;
    "nvim/lua/plugins/custom.lua".source = ./nvim/lua/plugins/custom.lua;
  };
}