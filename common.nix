{pkgs, lib, config, ...}: {
  imports = [
    ./appConfigs/nvim.nix
    ./appConfigs/starship.nix
    ./appConfigs/zellij.nix
    ./appConfigs/ghostty.nix
  ];

  # Shared aliases across all profiles
  home.shellAliases = {
    cat = "bat -pp";
    ls = "eza --icons -F -H --group-directories-first --git -1";
  };

  home.packages = with pkgs; let
    # Development Tools
    developmentTools = [
      nixfmt           # Formatter for Nix code
      github-cli       # GitHub command-line interface
      gemini-cli       # Gemini command-line interface
      lazydocker
      talosctl
      argocd
      kubectl
      k9s
      claude-code
    ];

    # Shell & Terminal
    shellAndTerminal = [
      yazi             # Terminal file manager
      eza              # Modern replacement for ls
      bat              # Cat clone with syntax highlighting
      glow             # Terminal markdown renderer
    ];

    # System & Network Monitoring
    monitoring = [
      btop             # Resource monitor
      gping            # Ping with a graph
      fastfetch        # System information tool
      tailscale        # VPN service
      speedtest-cli    # Internet speed tester
    ];

    # Fun & Miscellaneous
    fun = [
      cmatrix          # Matrix-style text scrolling
      cowsay           # ASCII cow with a message
      sl
    ];

  in
    developmentTools
    ++ shellAndTerminal
    ++ monitoring
    ++ fun;
}
