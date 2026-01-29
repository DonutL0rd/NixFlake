{pkgs, lib, config, ...}: {
  imports = [
    ./appConfigs/nvim.nix
    ./appConfigs/starship.nix
  ];
  home.packages = with pkgs; let
    # Development Tools
    developmentTools = [
      nixfmt-rfc-style # Formatter for Nix code
      github-cli       # GitHub command-line interface
      gemini-cli       # Gemini command-line interface
      lazydocker
      talosctl
      argocd
      kubectl
      k9s
      github-copilot-cli
      claude-code
    ];

    # Shell & Terminal
    shellAndTerminal = [
      starship         # Cross-shell prompt
      zellij           # Terminal multiplexer
      yazi             # Terminal file manager
      eza              # Modern replacement for ls
      bat              # Cat clone with syntax highlighting
    ];

    # System & Network Monitoring
    monitoring = [
      btop             # Resource monitor
      gping            # Ping with a graph
      neofetch         # System information tool
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
